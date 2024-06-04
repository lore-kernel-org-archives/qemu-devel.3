Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76556C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEThO-0006PC-FR; Tue, 04 Jun 2024 08:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulo@myneves.com>) id 1sEQTR-0002Vq-HL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:28:57 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulo@myneves.com>) id 1sEQTN-0006sp-OC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
 s=protonmail; t=1717493328; x=1717752528;
 bh=wf7VFZjlXfP13nMHEyUKTvdayBGhwsPjWQbZbUS1kK8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=jYQ42JOoYBKdDxpOTKK6ZMl2mS6+tRsflq1KvCFZIOkAXBz3uaHLj4Epw4GdSoheK
 eFdsGy3hmXar6ODzWRcHpnY8j17DSYUkDiH6IYkwf4/MRLnOdjOIAbH4pDzl6PlxHD
 xn8oKbC/zPKElnKV1/JNht0eA/onlcSd7HA7y8JnUAuX8S5cYvglC3CLTs9tSwtmCR
 N0mlYB3dwVPqBdiF/LLdK/jv4ugMaybwRPG1iI0fwPOanPA2QCd2RJpLLuVVZpVqmi
 a01wNmz1xfVR2VPbV5YAmlhLLRCJb3rJM8Tq3zrWFbCVfl8UOF1g6L+72pxrm1Z8QQ
 fVvjVmLQRJvrg==
Date: Tue, 04 Jun 2024 09:28:44 +0000
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Octavian Purdila <tavip@google.com>
From: Paulo Neves <paulo@myneves.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 peter.maydell@linaro.org, berrange@redhat.com,
 Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH v2] chardev: add path option for pty backend
Message-ID: <37acc23a-821a-4f83-9c04-30bdc55538c8@myneves.com>
In-Reply-To: <CAMxuvaw=PXk-5yuBwPLS4WUygwbXz1qOJTwrA_EEhNJJuoMGsg@mail.gmail.com>
References: <20240603212228.3878836-1-tavip@google.com>
 <CAMxuvaw=PXk-5yuBwPLS4WUygwbXz1qOJTwrA_EEhNJJuoMGsg@mail.gmail.com>
Feedback-ID: 59941854:user:proton
X-Pm-Message-ID: 32ff171ff9126033da644dfb624ada9bbd61a9c0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.136; envelope-from=paulo@myneves.com;
 helo=mail-40136.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Jun 2024 08:55:32 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Really happy somebody found the patch useful. I forgot to look at the=20
review comments at the time
and never got it merged.
@Octavian thanks for bringing it up to shape.

Cheers
Paulo Neves

On 04/06/2024 07:50, Marc-Andr=C3=A9 Lureau wrote:
> On Tue, Jun 4, 2024 at 1:22=E2=80=AFAM Octavian Purdila <tavip@google.com=
> wrote:
>> Add path option to the pty char backend which will create a symbolic
>> link to the given path that points to the allocated PTY.
>>
>> This avoids having to make QMP or HMP monitor queries to find out what
>> the new PTY device path is.
>>
>> Based on patch from Paulo Neves:
>>
>> https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmai=
l.com/
>>
>> Tested with the following invocations that the link is created and
>> removed when qemu stops:
>>
>>    qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
>>    -chardev pty,path=3Dtest,id=3Dcompat_monitor0
>>
>>    qemu-system-x86_64 -nodefaults -monitor pty:test
>>
>> Also tested that when a link path is not passed invocations still work, =
e.g.:
>>
>>    qemu-system-x86_64 -monitor pty
>>
>> Co-authored-by: Paulo Neves <ptsneves@gmail.com>
>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>> [OP: rebase and address original patch review comments]
>> Signed-off-by: Octavian Purdila <tavip@google.com>
>> ---
>> Changes since v1:
>>
>>   * Keep the original Signed-off-by from Paulo and add one line
>>      description with further changes
>>
>>   * Update commit message with justification for why the new
>>      functionality is useful
>>
>>   * Don't close master_fd when symlink creation fails to avoid double
>>      close
>>
>>   * Update documentation for clarity
>>
>>   chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
>>   chardev/char.c     |  5 +++++
>>   qapi/char.json     |  4 ++--
>>   qemu-options.hx    | 24 ++++++++++++++++++------
>>   4 files changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> index cc2f7617fe..b5a4eb59fc 100644
>> --- a/chardev/char-pty.c
>> +++ b/chardev/char-pty.c
>> @@ -29,6 +29,7 @@
>>   #include "qemu/sockets.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/module.h"
>> +#include "qemu/option.h"
>>   #include "qemu/qemu-print.h"
>>
>>   #include "chardev/char-io.h"
>> @@ -41,6 +42,7 @@ struct PtyChardev {
>>
>>       int connected;
>>       GSource *timer_src;
>> +    char *symlink_path;
>>   };
>>   typedef struct PtyChardev PtyChardev;
>>
>> @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
>>       Chardev *chr =3D CHARDEV(obj);
>>       PtyChardev *s =3D PTY_CHARDEV(obj);
>>
>> +    /* unlink symlink */
>> +    if (s->symlink_path) {
>> +        unlink(s->symlink_path);
>> +        g_free(s->symlink_path);
>> +    }
>> +
>>       pty_chr_state(chr, 0);
>>       object_unref(OBJECT(s->ioc));
>>       pty_chr_timer_cancel(s);
>> @@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
>>       int master_fd, slave_fd;
>>       char pty_name[PATH_MAX];
>>       char *name;
>> +    char *symlink_path =3D backend->u.pty.data->device;
>>
>>       master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
>>       if (master_fd < 0) {
>> @@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
>>       g_free(name);
>>       s->timer_src =3D NULL;
>>       *be_opened =3D false;
>> +
>> +    /* create symbolic link */
>> +    if (symlink_path) {
>> +        int res =3D symlink(pty_name, symlink_path);
>> +
>> +        if (res !=3D 0) {
>> +            error_setg_errno(errp, errno, "Failed to create PTY symlink=
");
>> +        } else {
>> +            s->symlink_path =3D g_strdup(symlink_path);
>> +        }
>> +    }
>> +}
>> +
>> +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
>> +                           Error **errp)
>> +{
>> +    const char *path =3D qemu_opt_get(opts, "path");
>> +    ChardevHostdev *dev;
>> +
>> +    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
>> +    dev =3D backend->u.pty.data =3D g_new0(ChardevHostdev, 1);
>> +    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
>> +    dev->device =3D path ? g_strdup(path) : NULL;
> minor nit, g_strdup(NULL) returns NULL. Get rid of "?:" if you send a v3.
Indeed the original patch did not have the ternary.
>>   }
>>
>>   static void char_pty_class_init(ObjectClass *oc, void *data)
>>   {
>>       ChardevClass *cc =3D CHARDEV_CLASS(oc);
>>
>> +    cc->parse =3D char_pty_parse;
>>       cc->open =3D char_pty_open;
>>       cc->chr_write =3D char_pty_chr_write;
>>       cc->chr_update_read_handler =3D pty_chr_update_read_handler;
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 3c43fb1278..404c6b8a4f 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, =
const char *filename,
>>           qemu_opt_set(opts, "path", p, &error_abort);
>>           return opts;
>>       }
>> +    if (strstart(filename, "pty:", &p)) {
>> +        qemu_opt_set(opts, "backend", "pty", &error_abort);
>> +        qemu_opt_set(opts, "path", p, &error_abort);
>> +        return opts;
>> +    }
>>       if (strstart(filename, "tcp:", &p) ||
>>           strstart(filename, "telnet:", &p) ||
>>           strstart(filename, "tn3270:", &p) ||
>> diff --git a/qapi/char.json b/qapi/char.json
>> index 777dde55d9..4c74bfc437 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -509,7 +509,7 @@
>>   ##
>>   # @ChardevHostdevWrapper:
>>   #
>> -# @data: Configuration info for device and pipe chardevs
>> +# @data: Configuration info for device, pty and pipe chardevs
>>   #
>>   # Since: 1.4
>>   ##
>> @@ -650,7 +650,7 @@
>>               'pipe': 'ChardevHostdevWrapper',
>>               'socket': 'ChardevSocketWrapper',
>>               'udp': 'ChardevUdpWrapper',
>> -            'pty': 'ChardevCommonWrapper',
>> +            'pty': 'ChardevHostdevWrapper',
>>               'null': 'ChardevCommonWrapper',
>>               'mux': 'ChardevMuxWrapper',
>>               'msmouse': 'ChardevCommonWrapper',
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 8ca7f34ef0..94ffb1a605 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>>       "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappe=
nd=3Don|off]\n"
>>       "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPAT=
H][,logappend=3Don|off]\n"
>>   #else
>> -    "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
>> +    "-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
>>       "-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=
=3DPATH][,logappend=3Don|off]\n"
>>   #endif
>>   #ifdef CONFIG_BRLAPI
>> @@ -3808,12 +3808,18 @@ The available backends are:
>>
>>       ``path`` specifies the name of the serial device to open.
>>
>> -``-chardev pty,id=3Did``
>> -    Create a new pseudo-terminal on the host and connect to it. ``pty``
>> -    does not take any options.
>> +``-chardev pty,id=3Did[,path=3Dpath]``
>> +    Create a new pseudo-terminal on the host and connect to it.
>>
>>       ``pty`` is not available on Windows hosts.
>>
>> +    If ``path`` is specified, QEMU will create a symbolic link at
>> +    that location which points to the new PTY device.
>> +
>> +    This avoids having to make QMP or HMP monitor queries to find out
>> +    what the new PTY device path is.
>> +
>> +
>>   ``-chardev stdio,id=3Did[,signal=3Don|off]``
>>       Connect to standard input and standard output of the QEMU process.
>>
>> @@ -4171,8 +4177,14 @@ SRST
>>
>>               vc:80Cx24C
>>
>> -    ``pty``
>> -        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
>> +    ``pty[:path]``
>> +        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
>> +
>> +        If ``path`` is specified, QEMU will create a symbolic link at
>> +        that location which points to the new PTY device.
>> +
>> +        This avoids having to make QMP or HMP monitor queries to find
>> +        out what the new PTY device path is.
>>
>>       ``none``
>>           No device is allocated. Note that for machine types which
>> --
>> 2.45.1.288.g0e0cd299f1-goog
>>


