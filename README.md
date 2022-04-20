# systemd-failure-notify

Report service unit failures via email. The journal log from the failed
invocation will be included in the email body.

Can be easily added as `ExecStopPost` hook to existing units using the
provided drop-in snippet:

```
[Service]
ExecStopPost=+/usr/bin/systemd-failure-notify "%n"
```

If installed via package, a snippet is installed in
`usr/share/systemd-failure-notify`, that can be symlinked:

```
$ mkdir /etc/systemd/service/my.service.d
$ ln -s /usr/share/systemd-failure-notify/systemd-failure-notify.conf /etc/systemd/service/my.service.d/
```

`systemd-failure-notify` uses `/usr/bin/mail` to send notification
emails. The package recommends `bsd-mailx | s-nail | mailutils`, but
only `bsd-mailx` has been tested so far.
