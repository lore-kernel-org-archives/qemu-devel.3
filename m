Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F8606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ku4hnXpj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdGj-0007i6-HO; Wed, 21 Oct 2026 16:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJdGY-0007el-GS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:50:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJdGU-0007QC-B9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:50:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso11948465e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792615825; x=1793220625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X2CxcxJSRvKESmBbEKcO55HDwInTaJ4oWVM+mXsHScg=;
 b=ku4hnXpj4D5+6PcVX4qdxXJ+Ee1KBDXY9rspKE5qwk2sMCBm+uFm3TeCrrW3eOIgjU
 wy7JE8jOWHOm1TItAT63nhslIQtaYEmLwx8xz2nFiDL2XvIcy8bqINHTvC+sybeGiuws
 4DXMyAbJ2lCXw3VY7QLCGiQ+TroPrBd+2dSumrQitu+6uIM7AKMhGSrhNjbyg09EGmE0
 +Mq4XNQN4gm8e6HFJ9RblWe/qknhoR9FOvDd/2fBO1VS9dFA6Te8GHWFwEyvc3JJeq1P
 98oRGbBwGIqozHLIU6rP7qfnmJF0K5EpoinrHI07xSKP4H/4hFoeLtvR+i8Oqg/Xj6U5
 DYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615825; x=1793220625;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X2CxcxJSRvKESmBbEKcO55HDwInTaJ4oWVM+mXsHScg=;
 b=niDQq0Tpyq+EjSxTQ/gmhR05jI/1tDnkBk6UUXWdT9vQZ/bmVS7cVFiIY9SSwagQfO
 82bF8oO8W4FWI1YAtUQS2CwTYHOZ+ylmsCdE+ZFf/L9G/6AG5YfEUYIbqq7ktWIlm2WN
 M+DBUmgm7YJhbRUIFwCTCxvEfbRkyri++VfdyeP4/zBsMGBhPcyCvUoug1V4aRu28iBV
 VXEII75TgiVp+is5P6f8PBjcShfecuF1ifQ9+K4axqoX3FfUqfcH6VNJDG3Xgk/Fc54S
 MkNpD53Wg0oVno7I09CT6WwoN3ImP+O197kNux8NRnaDNGpoCF0M5sPrhbpMkqeqSNB1
 yf9g==
X-Gm-Message-State: AFq9FYJGOvOncQPqwRSYupFAMZmqQ78o+/8LNYC0V/Tr44vWqhgIZJHm
 G+SVSjtsXgao7IFyGR6j+Zbwr1P4+kY1idxBAE4p2VLGHFoN7pUKte6Fytjz1ibsjcQ=
X-Gm-Gg: AYBFou1fJNRPv5mmzcc/CH0dT4t3Ns/lWtoc+oQT8hmYbPZNUFh5Rz5FQuhcp//xvLv
 7LUYsjuD8xYb7qbMuNKxS66nQg74F1ocwTNRVMgZ6KQfku5TShtFUVI13cWoe9oooqBFezW5a02
 B3Lh1gyckNRBKTzWt1r7geRhkassl5hup4SkRGPpovAbIaiw9B1SQyN8zzcg50AIV2SUX19iMrc
 Ieuu9nEk35op6sVbX7XiFr1FamolMzk3FEZaSV2fTX9n6i04ehY2dv7HQlTKA3TTNgit1rjslUe
 PZ+UJ1azrPnaMa0mggyMO5fi6BFrKQ4FBVZMLoCt+gY8XW6MAyOtjYC+jSEUrS+vjAfOnAYkVap
 XDjLRyHX11ZC30HNtqulifweEKsQh2KThZmEkOB6AOlYBn+YSGst0SMvpT0RBani9sGjd5dc7iv
 ncJj/duhI6uhq2tFKOkLfwLcDWzvUSilBmJtw8kMQeNJllam2cz+yC252mE1RSxSjnotwvqHM6R
 G0mnAqnsGCTt/xHo9qB1Z+BXxBGjOWgOxzSmesw657kNE9vIb/O58w=
X-Received: by 2002:a05:600c:6304:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4a1fdd46423mr64987775e9.34.1792615824593; 
 Wed, 21 Oct 2026 13:50:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2038ddb20sm17473515e9.0.2026.10.21.13.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:50:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E7B235F7FA;
 Wed, 21 Oct 2026 21:50:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Cornelia Huck <cohuck@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  Paolo Bonzini <pbonzini@redhat.com>,  Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Keith
 Busch <kbusch@kernel.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,  Eric
 Farman <farman@linux.ibm.com>,  Zhao Liu <zhao1.liu@intel.com>,  Ani Sinha
 <anisinha@redhat.com>,  Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org,  Song Gao <gaosong@loongson.cn>,  Peter Maydell
 <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier
 <laurent@vivier.eu>,  qemu-s390x@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Brad Smith <brad@comstyle.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Klaus Jensen <its@irrelevant.dk>,  John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH v3 12/19] tests/functional: teach tuxrun about launching
 gdb tests
In-Reply-To: <41147e0a-c8a2-4060-903e-695e3977c8cd@linux.ibm.com> (Ilya
 Leoshkevich's message of "Wed, 21 Oct 2026 22:17:01 +0200")
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-13-alex.bennee@linaro.org>
 <41147e0a-c8a2-4060-903e-695e3977c8cd@linux.ibm.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Wed, 21 Oct 2026 21:50:22 +0100
Message-ID: <87h5iezskx.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On 10/19/26 21:26, Alex Benn=C3=A9e wrote:
>> This resurrects the hand run test script from d84842be6c5 (tests:
>> remove test-gdbstub.py) and modernises it to use the shared test
>> infrastructure for run-test.
>> We then tweak the common tuxrun code to over an alternative "launch
>> via gdbstub" helper which reuses the existing code but:
>>    - needs a vmlinux with symbols
>>    - drops kaslr because it doesn't play nice with symbols
>>    - extend qargs with stuff normally added by vm.launch
>>    - passes kargs directly
>>    - runs with the gdb run-test script
>>    - log the run-test output to the console log
>>    - makes --binary not mandatory
>> Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v3
>>    - mention the nokaslr in the commit message
>>    - add a comment about it to the shared kernel args
>>    - drop unused failcount
>>    - remove stale comment about hbreak
>>    - always delete the watch point pass or fail
>>    - fix unbalanced tuple in sh4's direct call of fetch_tuxrun_assets
>>    - simplify the symbol to watchpoint logic
>>    - drop the mandatory --binary
>>    - make the command copy and paste friendly
>> v2
>>    - add self.vm._machine to qargs
>>    - drop leading spaces in print () calls
>>    - add register read tests
>>    - use gdb.Breakpoint for hwbreak as for swbreak
>>    - drop flaky symbol evaluation, verify hit_count instead
>>    - explicit gdb.BP_BREAKPOINT for CatchBreakpoint
>> ---
>>   .../functional/gdb-scripts/kernel_gdb_test.py | 162 ++++++++++++++++++
>>   tests/functional/qemu_test/tuxruntest.py      |  97 ++++++++++-
>>   tests/functional/sh4/test_tuxrun.py           |   4 +-
>>   tests/guest-debug/run-test.py                 |  14 +-
>>   4 files changed, 261 insertions(+), 16 deletions(-)
>>   create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py
>
> [...]
>
>> @@ -132,10 +144,77 @@ def common_tuxrun(self,
>>           special with the command line we can process most things using
>>           the tag metadata.
>>           """
>> -        (kernel, disk, dtb) =3D self.fetch_tuxrun_assets(kernel_asset, =
rootfs_asset,
>> -                                                       dtb_asset)
>> +        (kernel, disk, dtb, _) =3D self.fetch_tuxrun_assets(kernel_asse=
t,
>> +                                                          rootfs_asset,
>> +                                                          dtb_asset)
>>             self.prepare_run(accel, kernel, disk, drive, dtb,
>> console_index)
>>           self.vm.launch()
>>           self.run_tuxtest_tests(haltmsg)
>>           os.remove(disk)
>> +
>> +    def common_tuxrun_gdb(self,
>> +                          kernel_asset,
>> +                          vmlinux_asset,
>> +                          rootfs_asset,
>> +                          accel=3DNone,
>> +                          dtb_asset=3DNone,
>> +                          drive=3D"virtio-blk-device",
>> +                          haltmsg=3D"reboot: System halted",
>> +                          console_index=3D0):
>> +        """
>> +        Common path for LKFT tests under gdb. Unlike the common_tuxrun
>> +        function we need to launch with the gdb test script and deal
>> +        with munging the arguments for that especially.
>> +        """
>> +        (kernel, disk, dtb, vmlinux) =3D self.fetch_tuxrun_assets(kerne=
l_asset,
>> +                                                                rootfs_=
asset,
>> +                                                                dtb_ass=
et,
>> +                                                                vmlinux=
_asset)
>> +
>> +        gdb_path =3D os.getenv("QEMU_TEST_GDB")
>
> By the way, there is a minor usability issue: if I set QEMU_TEST_GDB to
> a non-existent binary, the test hangs instead of exiting with an error
> message.

I can add a guard - but in normal invocation meson should take care only
to pass the env variable if configure detects gdb.

>
>> +        run_script =3D self.data_file('..', 'guest-debug','run-test.py')
>> +        test_script =3D self.data_file('gdb-scripts', 'kernel_gdb_test.=
py')
>> +
>> +        # Instead of launching QEMU via the functional test machinery
>> +        # we need to launch it with the gdb run script. We utilise the
>> +        # existing prepare_run machinery to build the command line but
>> +        # we pass the kernel args separately to avoid horrible string
>> +        # escaping.
>> +
>> +        self.prepare_run(accel, kernel, disk, drive, dtb,
>> +                         console_index, append =3D False)
>> +
>> +        # the functional test machinery adds more stuff for handling
>> +        # console redirection which we need to do manually.
>> +
>> +        qargs =3D self.vm.args
>> +        qargs.extend(["-display", "none", "-serial", "stdio"])
>> +
>> +        # and the machine type
>> +        if self.vm._machine is not None:
>> +            qargs.extend(["-machine", self.vm._machine])
>> +
>> +        cmd =3D [
>> +            str(run_script),
>> +            "--qemu", self.qemu_bin,
>> +            "--qargs", " ".join(qargs),
>> +            "--kargs", self.kcmd_line,
>> +            "--symbols", str(vmlinux),
>> +            "--test", str(test_script),
>> +            "--gdb", gdb_path,
>> +        ]
>> +
>> +        log_cmd =3D " ".join(f'"{arg}"' if ' ' in arg else arg for arg =
in cmd)
>> +        self.log.info(f"run-test: {log_cmd}")
>> +
>> +        res =3D subprocess.run(cmd, text=3DTrue,
>> +                             stdout=3Dsubprocess.PIPE,
>> +                             stderr=3Dsubprocess.STDOUT)
>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

