Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697F2CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEm4-0000Lj-0n; Fri, 09 Oct 2026 13:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xFEly-0000LI-7n
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:52:47 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xFElv-0006D2-UL
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:52:45 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2e6df2742cso17416166b.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791568361; cv=none;
 d=google.com; s=arc-20260327;
 b=BiKqv6KBRQIwiVy6f0db9065gzEOz/pA5o/M4bwo5LZ7RPk39eTeC5DKyJTcOOxzNh
 766HtAefsS1tWjwBtX5oAgF5KbZeCz6J/Z7mwcOguVlpAxrJI1fMzOVuMJZ59L2ZDcty
 P4rhh1hZPjKwFFY0ZTXOggUP2BFexhNcHpKl86N3NXwsBM3PWgU9HGFXzGUY645KJKak
 Qj5b3jGKb4LDwZbZGk0YJeAXTE3LYWnH1NIGvltLXP+9bpRCBxySwKSL839F/ZHw4TOk
 uxlPJ7yPxaMcuCAXYYReoUKcLYEiU2auCvaUKt2qNHhIZ4JozXxxuGSFuL4RNKyO9SBa
 v69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=frOKFNFhxa5Nubq4E6Tr81P9hlMUQIcVmTYqoQRSvno=;
 fh=g69kuaC+sP227QrWiGLgRGewvEeYhj4aGz+XGsNhpls=;
 b=TY5OaFxlugYZNPUJoswl945I+Uz4BHT4qlFqktvPVV94+PPzOKEaW4H882fCr/fBh1
 njhxuCn9ezNKFC1MV7DgY9+s+mAcLWJqfJV6y4XVRDnYwCnHaSZ7kJTFuQNmas7UKu2O
 yYo2Pcwu4MF2uG4dT2OiyiSF2uQkoPEskkzLTdXmtDscnUbGaOTB3GYd3swqfSMOTnNE
 LvC9orljb7FFLexkFd2CT1hsU+r3afUWyS9nAUJ7I9Vk0jftGzE14VefQ1dJ720JDYbM
 Zhy/wDVCPvke82WcEcl53x9/536C/XXOH+mgoB5tDzUFaUqKdXPxn+w4KEv+JRI22lFl
 TG1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1791568361; x=1792173161; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=frOKFNFhxa5Nubq4E6Tr81P9hlMUQIcVmTYqoQRSvno=;
 b=O7F7XWI4ri4tDKVI5lT8lHWj/JWXCYa1ogFn7/InCAw7SxgtkK3dPTwPCUqne0WRF/
 PU263jyTA0jBQvHiRZddzGYl/MUCJn3m5nmuWDp7ipFP2I6ZNO1z3xmxG1iRsUy+xeqw
 PTKO81SZRbJ4JsJZqqhptBEahasNrTmKGNycQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791568361; x=1792173161;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=frOKFNFhxa5Nubq4E6Tr81P9hlMUQIcVmTYqoQRSvno=;
 b=h+XhZw5APa/hugJr4qmMeqbFA5CAxRuFgge4elRFgvqjjwh9nx3eUZBpk+thIdq2ra
 nWzeoIksc4v1EYFYMrSR/cwEeGJm+Yn/bay5LFgWAQExGksJd1MGQt5S3ThvL7Hqr6e+
 w7QI+tSNBVMIVdpHo697qEm5wjEqMIhzJXQybHdYdato8efOIKuSsscNVMQKd/N0vCoE
 xNqZ2EQhqkZltc1sA4+rjX0QsHb5R/vj5+iUEN0symvA+kOM1pG2Nc/hHp6ykNLyVyAH
 mrN4EsgkHfFZd9jPlQmAjLw6uS/RLnI0aeJCsfPNnHWIacY0ebiZDMzd2gpPk9Z2d/uK
 5knA==
X-Forwarded-Encrypted: i=1;
 AKwUvByqVYpvM8bdHHxk5JBE7UIAF2c6uQs9Zxoni3t22UVQvDGTtdSlKigjHFmF9UTooWClpTYv7K2fIqlm@nongnu.org
X-Gm-Message-State: AFq9FYIikDdSnJJ2S3bDXuS0oT/uoNmc6SfDFrbIyJvowQEJiTTMcSDB
 Hfm0qMt9QEsbFYjJ1uIiyBz8L1VzMHmYm2t9rJDyJuCJbRtlYKQTHlHB8gk4EjGk/KgJK+xHqVA
 ZGeonN1+GTTxz/+X3tLgDfKiXdftMFwXEmq2/IL7CBA==
X-Gm-Gg: AYBFou3JQxxNi5/werxUR3XaIdHQVATv6AU3tIl9xXlT4f6RHNWjFY1hbxDU96ZEwr7
 r6/SmC9oGpc+j3uL94WFpWN48TUPflvZAwYryjntTYwcX6K8r4+xYD12MyqroyBAVJJn/knoJ4J
 iu4uCatB/nIRydYUhe5ui+ArlDTcKbP4qhCeDmclR+BJ0RxLzBOOD8OWuLcScnQoHvwbr7R0eWg
 iVej8iGqGO4BeGl3C6+FOU3F3keew8O42hUf8tx1php6kOg0ucEhvZXx0z5Oge1LNPAhT2gUmGm
 8seNSaIMe2eCy9RVow5vdtrW41JPPtHva3T2CI6QNAGm6TfnFUR2bOMR3/HlblY/OTJ1UFzr6Sl
 lF4Z0NXf19PU=
X-Received: by 2002:a17:907:cf93:b0:c2e:7e0a:335d with SMTP id
 a640c23a62f3a-c31a9a04e4bmr263860266b.2.1791568360986; Fri, 09 Oct 2026
 10:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 9 Oct 2026 19:52:29 +0200
X-Gm-Features: AclHuK9pUYlQnk7RYNRbDCr--rT34FQqaPrJQXFB5iIdktoaaYtXJV8CQU05t3I
Message-ID: <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "open list:nvme" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Mi., 7. Okt. 2026 um 15:27 Uhr schrieb Peter Xu <peterx@redhat.com>:
>
> On Mon, Sep 21, 2026 at 08:03:45PM +0100, Alex Benn=C3=A9e wrote:
> > This is a hacky patch for comment but I've included the diagnostic
> > hacks to the migration test as well as my workaround to get itworking.
> >
> > This test was failing on my KVM system. On investigation I found the
> > nVME activity meant the migration never completed. I ended up
> > inserting some sleeps into the workload script until I was able to
> > get it to run.
>
> Indeed, I can reproduce it too:

Hi Peter,

thank you checking on your system and sharing a stacktrace.
Unfortunately, I wasn't able to reproduce this failure on my system,
but I think I have a good theory what's going on there. I think it is
because we use `snapshot=3Don` for a disk device and at the same time
keep important stuff like `/tmp/test_nvme_mig_workload.pid` on a root
filesystem. Easy fix is to use tmpfs for /tmp, so all data is actually
migrated.

Please, can you try the following patch and let me know if this fixes
the issue or not:

--- a/tests/functional/x86_64/test_nvme_migration.py
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -75,6 +75,11 @@ def configure_machine(self, vm):
     def launch_source_vm(self, vm):
         vm.launch()

+        vm.cmd('migrate-set-parameters', **{
+            'downtime-limit': 2000000,
+            'max-bandwidth': 10 * 1024**3,
+        })
+
         self.wait_for_console_pattern('Entering emergency mode.', vm)
         prompt =3D '# '
         self.wait_for_console_pattern(prompt, vm)
@@ -94,6 +99,8 @@ def launch_source_vm(self, vm):
                                           prompt, vm=3Dvm)
         exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /sys=
',
                                           prompt, vm=3Dvm)
+        exec_command_and_wait_for_pattern(self, 'mount -t tmpfs tmpfs /tmp=
',
+                                          prompt, vm=3Dvm)

         # Run workload before migration to check if it continues
         # to run properly after migration.

Kind regards,
Alex

>
> $ ./run ../tests/functional/x86_64/test_nvme_migration.py X8664NVMeMigrat=
ionTest.test_migration_with_unix
> TAP version 13
> Traceback (most recent call last):
>   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.=
py", line 162, in test_migration_with_unix
>     self.migration_with_unix()
>     ~~~~~~~~~~~~~~~~~~~~~~~~^^
>   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 98, in =
migration_with_unix
>     self.migrate(dst_uri)
>     ~~~~~~~~~~~~^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 78, in =
migrate
>     self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
>     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 63, in =
migrate_vms
>     self.assert_dest_vm(dst_vm)
>     ~~~~~~~~~~~~~~~~~~~^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.=
py", line 128, in assert_dest_vm
>     self.exec_command_and_check(
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>         "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.=
py", line 48, in exec_command_and_check
>     wait_for_console_pattern(self, 'OK', failure_message=3D"FAIL", vm=3Dv=
m)
>     ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 191=
, in wait_for_console_pattern
>     return _console_interaction(test, success_message, failure_message,
>                                 None, vm=3Dvm)
>   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 134=
, in _console_interaction
>     done, line =3D _console_read_line_until_match(test, vm,
>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>                                                 success_message_b,
>                                                 ^^^^^^^^^^^^^^^^^^
>                                                 failure_message_b)
>                                                 ^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 70,=
 in _console_read_line_until_match
>     test.fail(
>     ~~~~~~~~~^
>         f"'{failure}' found in console, expected '{success}'")
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError: 'b'FAIL'' found in console, expected 'b'OK''
>
> not ok 1 test_nvme_migration.X8664NVMeMigrationTest.test_migration_with_u=
nix
> 1..1
>
> Copy the author too (Alexander).
>
> >
> > *NOTE*: obviously this can't be merged as is but I think we could
> > certainly do with more tracking in the test to see when things aren't
> > working with possibly the sleep as another patch.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  tests/functional/migration.py                 | 37 +++++++++++++++----
> >  .../functional/x86_64/test_nvme_migration.py  |  1 +
> >  2 files changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/functional/migration.py b/tests/functional/migration=
.py
> > index 8d2428efc24..e51a82c22f4 100644
> > --- a/tests/functional/migration.py
> > +++ b/tests/functional/migration.py
> > @@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
> >      timeout =3D 10
> >
> >      @staticmethod
> > -    def migration_finished(vm):
> > -        return vm.cmd('query-migrate')['status'] in ('completed', 'fai=
led')
> > +    def migration_finished(query):
> > +        return query['status'] in ('completed', 'failed')
> >
> > -    def assert_migration(self, src_vm, dst_vm):
> > +    def wait_for_vm(self, src_or_dst, vm):
> > +        "Track the state of one VM in the migration"
> > +        current_state =3D last_state =3D vm.cmd('query-migrate')
> >
> > -        end =3D time.monotonic() + self.timeout
> > -        while time.monotonic() < end and not self.migration_finished(s=
rc_vm):
> > -            time.sleep(0.1)
> > +        self.log.info(f"waiting for {src_or_dst} to complete")
> >
> >          end =3D time.monotonic() + self.timeout
> > -        while time.monotonic() < end and not self.migration_finished(d=
st_vm):
> > +        while time.monotonic() < end:
> > +            if self.migration_finished(current_state):
> > +                break
> > +            else:
> > +                last_remain =3D last_state['remaining']
> > +                current_remain =3D current_state['remaining']
> > +
> > +                if current_remain > last_remain:
> > +                    self.log.warning(f"slow migration {current_remain}=
 > {last_remain}")
> > +
> >              time.sleep(0.1)
> > +            last_state =3D current_state
> > +            current_state =3D vm.cmd('query-migrate')
> > +
> > +
> > +    def assert_migration(self, src_vm, dst_vm):
> > +
> > +        self.wait_for_vm("src", src_vm)
> > +
> > +        # if we hit this we never completed...
> > +        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'compl=
eted')
> > +
> > +        self.wait_for_vm("dst", dst_vm)
> > +
> > +        self.log.info("checking everything is OK")
> >
> >          self.assertEqual(src_vm.cmd('query-migrate')['status'], 'compl=
eted')
> >          self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'compl=
eted')
> > diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/fun=
ctional/x86_64/test_nvme_migration.py
> > index 890f0aab6d6..58596f63cd3 100755
> > --- a/tests/functional/x86_64/test_nvme_migration.py
> > +++ b/tests/functional/x86_64/test_nvme_migration.py
> > @@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
> >                  rm -f /tmp/test_nvme_mig_workload.iter_finished; \
> >                  echo 3 > /proc/sys/vm/drop_caches; \
> >                  find /usr/bin -type f -exec cksum {} \\;; \
> > +                sleep 0.3; \
> >                  touch /tmp/test_nvme_mig_workload.iter_finished; \
> >              done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &"=
,
> >              prompt, vm=3Dvm)
> > --
> > 2.47.3
> >
>
> --
> Peter Xu
>

