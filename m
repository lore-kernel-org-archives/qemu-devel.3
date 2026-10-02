Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76348CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZqf-00021l-0Y; Fri, 02 Oct 2026 05:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xCZqJ-000217-3y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:46:15 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xCZqG-0000J4-Q2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:46:14 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso11451965e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790934370; x=1791539170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WVmb6E2uchkXq/33Frna5un6zpnD5HsHMY046QL1GQM=;
 b=PNL4KKVWuF61HSE58ZlViOVZb604TEoqEPJWthFKQXgPrxL8Ss04eRn/5HNNLwwV+x
 BKKDmP76OkqTq9Y0ZvAZ7H3JPDchoFG0gs7Y02V+dW5/EvdeaFVRJ8ZbYrPk1QCrPqld
 AUneU9JzxiQtRQkcd3l5DbsI+bZyp188Ss+PJfAW6u6hqZrseR5mmnjgFcPqzU3MKwdR
 P3aLkENruIGoh5AOaOdxc70K31GwmgGRzVg0wFqdzFxftvZ4FAeedX7Y19ux6KbhkMc4
 WPVCaPEj6EIgm8i1+L1nN3PeINBA6O+LoR3msWB4NIRfdx+8jbEcrTT6KS0aXvv7/sPZ
 mwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790934370; x=1791539170;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WVmb6E2uchkXq/33Frna5un6zpnD5HsHMY046QL1GQM=;
 b=L7qCjCSKP2D0D3rbXZGdO+GOISzR01CpZnEgZrFleb3dt7+eq1OYlTvoEjsUwcj1Zi
 7RAc/sBWEOFygMesBGDSbMKodyU3ChVI60qtcqt9uItDbkmPoR8hBnmUZePhCmqxVQcd
 NY3OyTSJSdoXdMcfoQU3dg0tMTwmLbEo9YSzu1lIKAqackaAgF7Ebg8ZPJ3WKPipnryv
 Z7ha3I7ewhLWr8EEQwC+PErzlADcJISCGcBDniRt7FY2iL0AYiRkDucQceqqH+xPq4Af
 u3SQwJNuiX+g7Dmnzk1fedjIEyfYI49krCe1iV1SmJ1yAm/ZGEl6tN9t8Xh9U9AtCBZJ
 eQZw==
X-Gm-Message-State: AFuF++la+YfJ7fxldgZEvXZODQr1zSE2vdjCtRiO/h1wECE2mXJZAOMu
 9ebWWUaX9R49tPYdfjZDVY0TfNxKeNiQnXvKkJbIrVtJhICEvP+xsLrgn3bmkW+wpQs=
X-Gm-Gg: AYBFou2ESqlNcXhdHsrdeRDerxhRH2WgqYOLzeZIAval4f8bpnDxywBwXRJpj7EqaBf
 1wWwhjTPtcovsj2RAn0kP9qfXYf85lWr8SJAEwM0YJJCYskymUYPGSdnbyHg+jkC+Y+ueieeDpB
 V0QNvh0ZJY060wO3qrCUUhQFHZ5VN3l0mn/CZvbknOjoCKM8aPiPSd2FZser03X0KmzIEOpI3r4
 G4ZlyoC6LgGmjmdtjycBv72e+9WTNUVO2qW+9xZiw3Qx7wZ2snRKM81Fpl+PrM3/YOd7b2wFJyP
 16q9o8KmrpsczlnEE22TAlZaDWOVcKhzXkfqI0mCmclTKoI4pSz0Q5Yv98/FEqs+Jn/zr94JXbV
 773y4TdVEwOG1VaCNZlW0uOE2R4dsYSrZoTUOTNFtOKC/UTE+aGUdXwND0NdHURmrsob0mWn2eV
 ZCTl/KewnH0ysnTYMptOi/9ntNf9ZcaMZBNEdAcZN+MfQYeToGFK2Hny7B5tgPH/sOIbyY9A==
X-Received: by 2002:a05:600c:1d15:b0:49f:e427:e88f with SMTP id
 5b1f17b1804b1-4a027564ddemr39614625e9.21.1790934370503; 
 Fri, 02 Oct 2026 02:46:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0a6e894a4sm47576975e9.5.2026.10.02.02.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:46:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 708125F8A5;
 Fri, 02 Oct 2026 10:46:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kyle Evans <kevans@freebsd.org>,  Song Gao
 <gaosong@loongson.cn>,  Ani Sinha <anisinha@redhat.com>,  Warner Losh
 <imp@bsdimp.com>,  Richard Henderson <richard.henderson@linaro.org>,  John
 Snow <jsnow@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Cornelia Huck
 <cohuck@redhat.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,  Zhao Liu
 <zhao1.liu@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,  Laurent
 Vivier <laurent@vivier.eu>,  Brad Smith <brad@comstyle.com>,  Peter Xu
 <peterx@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Eric
 Farman <farman@linux.ibm.com>,  Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Klaus Jensen <its@irrelevant.dk>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/13] tests/functional: add basic gdbstub test for KVM
In-Reply-To: <179085353196.2170790.3865077624161009164.b4-review@b4>
 (marcandre lureau's message of "Thu, 01 Oct 2026 15:18:51 +0400")
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-6-alex.bennee@linaro.org>
 <179085353196.2170790.3865077624161009164.b4-review@b4>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Fri, 02 Oct 2026 10:46:08 +0100
Message-ID: <87v77kjuzj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

marcandre.lureau@redhat.com writes:

>> We don't really exercise the KVM bits of gdbstub very much as the TCG
>> tests are TCG only and the ones in functional tests are focused on
>> record/replay and reverse debugging.
>>=20
>> Add a basic gdbstub test case which uses heuristics to single step
>> through the default firmware of guests and kick the tyres and check
>> things are working as expected.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> Message-ID: <20260930164649.433573-6-alex.bennee@linaro.org>
>>
>> diff --git a/tests/functional/gdb-scripts/kvm_fw_gdb_test.py b/tests/fun=
ctional/gdb-scripts/kvm_fw_gdb_test.py
>> new file mode 100644
>> index 000000000000..b38b874dc586
>> --- /dev/null
>> +++ b/tests/functional/gdb-scripts/kvm_fw_gdb_test.py
>> @@ -0,0 +1,119 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Generic GDB script to verify gdbstub functionality on guest firmware:
>> +#  - Single-stepping across VM-exits
>> +#  - Placing a hardware breakpoint at a branch or ahead in disassembly
>> +#  - Continuing to the breakpoint and validating that registers changed
>> +#
>> +# Copyright (c) 2026 Linaro Limited
>> +#
>> +# Author:
>> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> +
>> +import gdb
>> +from test_gdbstub import main, report
>> +
>> +def parse_registers():
>> +    """Parse 'info registers' into a name -> value dictionary."""
>> +    regs =3D {}
>> +    for line in gdb.execute("info registers", to_string=3DTrue).splitli=
nes():
>> +        parts =3D line.split()
>> +        if len(parts) >=3D 2:
>> +            regs[parts[0]] =3D parts[1]
>> +    return regs
>> +
>> +def test_single_step():
>> +    """
>> +    Single-step a few instructions and verify PC advances
>> +    """
>> +    current_pc =3D int(gdb.parse_and_eval("$pc"))
>> +    for step in range(1, 6):
>> +        gdb.execute("stepi")
>> +        gdb.execute("x/3i $pc")
>> +        pc =3D int(gdb.parse_and_eval("$pc"))
>> +        report(pc !=3D current_pc, f"single-step {step} advanced pc")
>> +        current_pc =3D pc
>> +
>> +
>> +def might_be_jump(asm):
>> +    """
>> +    Return true if the assembly string might contain a branch/jump inst=
ruction
>> +    """
>> +    branch_keywords =3D {
>> +        "jmp", "b", "bl", "bx", "bne", "beq", "bgt", "blt", "bge", "ble=
",
>> +        "call", "ret", "br", "jal", "jalr", "bc", "bctrl", "j"
>> +    }
>
>
> Do you plan to make this per-architecture? It doesn't cover x86
> conditional jumps.

I think I'm just going to wrap the register checking code into the other
test and drop this one as the heuristics are potentially flaky. It was
really just a workaround to not having symbols easily accessible (which I
have now).

>
>> +
>> +    parts =3D asm.split()
>> +    if not parts:
>> +        return False
>> +    mnemonic =3D parts[0].lower()
>> +    return mnemonic in branch_keywords
>> +
>> +
>> +def test_hw_bkpt():
>> +    """
>> +    Set a hwbkpt somewhere in the future.
>> +    """
>> +
>> +    # FIXME - this is fragile
>> +    disas =3D gdb.execute("x/10i $pc", to_string=3DTrue)
>> +    lines =3D disas.strip().splitlines()
>> +    insns =3D 0
>> +    bp =3D None
>> +
>> +    for line in lines:
>> +        clean =3D line.lstrip("=3D>").strip()
>> +        parts =3D clean.split(":", 1)
>> +        if len(parts) < 2 or not parts[1].strip():
>> +            continue
>> +        insns +=3D 1
>> +
>> +        if might_be_jump(parts[1]):
>> +            # jump too close, bail out?
>> +            if insns < 2:
>> +                report(False, "found jump far enough away")
>> +                return
>> +            else:
>> +                addr =3D int(parts[0].split()[0], 16)
>> +                bp =3D gdb.Breakpoint(f"*{hex(addr)}",
>> +                                    type=3Dgdb.BP_HARDWARE_BREAKPOINT)
>> +                break
>> +        elif insns =3D=3D 10:
>> +            addr =3D int(parts[0].split()[0], 16)
>> +            bp =3D gdb.Breakpoint(f"*{hex(addr)}",
>> +                                type=3Dgdb.BP_HARDWARE_BREAKPOINT)
>> +            break
>> +
>> +    report(bp is not None, f"set hwbkpt @ {bp.location}")
>
> Maybe to make debugging easier:
>
>   if bp is None:
>       report(False, "failed to set hwbkpt (no suitable instruction found)=
")
>       return
>   report(True, f"set hwbkpt @ {bp.location}")
>
>> +    gdb.execute("continue")
>> +
>> +    end_pc =3D gdb.parse_and_eval('$pc')
>> +    report(bp.hit_count =3D=3D 1,
>> +           "break @ %s (%d hits)" % (end_pc, bp.hit_count))
>> +
>> +    bp.delete()
>> +    return
>> +
>> +def test_reg_updates(regs_start):
>> +    regs_end =3D parse_registers()
>> +
>> +    changed =3D [k for k in regs_start
>> +               if k in regs_end and regs_start[k] !=3D regs_end[k]]
>> +
>> +    report(len(changed) > 0, f"{len(changed)} registers changed.")
>> +
>> +def run_test():
>> +    regs_start =3D parse_registers()
>> +
>> +    test_single_step()
>> +
>> +    # skip any pesky mode switching code
>> +    gdb.execute("stepi 50")
>> +
>> +    test_hw_bkpt()
>> +
>> +    test_reg_updates(regs_start)
>> +
>> +
>> +main(run_test)
>> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_=
64/meson.build
>> index 0353b2af8e1d..080e12ddef13 100644
>> --- a/tests/functional/x86_64/meson.build
>> +++ b/tests/functional/x86_64/meson.build
>> @@ -13,6 +13,7 @@ tests_x86_64_system_quick =3D [
>>    'bad_vmstate',
>>    'cpu_model_versions',
>>    'cpu_queries',
>> +  'kvm_gdbstub',
>>    'mem_addr_space',
>>    'migration',
>>    'pc_cpu_hotplug_props',
>> diff --git a/tests/functional/x86_64/test_kvm_gdbstub.py b/tests/functio=
nal/x86_64/test_kvm_gdbstub.py
>> new file mode 100755
>> index 000000000000..26876c3dc580
>> --- /dev/null
>> +++ b/tests/functional/x86_64/test_kvm_gdbstub.py
>> @@ -0,0 +1,55 @@
>> +#!/usr/bin/env python3
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Functional test verifying KVM gdbstub operations on firmware:
>> +#  - Single-stepping across VM-exits
>> +#  - Register sampling across execution steps
>> +#  - Hardware breakpoint at branch destination or instruction
>> +#
>> +# Copyright (c) 2026 Linaro Limited
>> +#
>> +# Author:
>> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> +
>> +import os
>> +import subprocess
>> +from pathlib import Path
>> +from qemu_test import QemuSystemTest, skipIfMissingEnv
>> +
>> +
>> +class KvmGdbstubTest(QemuSystemTest):
>> +
>> +    @skipIfMissingEnv("QEMU_TEST_GDB")
>> +    def test_x86_64_kvm_fw_gdb(self):
>> +        self.require_accelerator("kvm")
>> +
>> +        gdb_path =3D os.getenv("QEMU_TEST_GDB")
>> +
>> +        tests_dir =3D Path(__file__).resolve().parents[2]
>> +        run_test =3D tests_dir / "guest-debug" / "run-test.py"
>> +        gdb_script =3D (tests_dir / "functional" / "gdb-scripts" /
>> +                      "kvm_fw_gdb_test.py")
>> +
>> +        qargs =3D "-machine pc -accel kvm -cpu host -smp 1 -m 512M -dis=
play none"
>> +        cmd =3D [
>> +            str(run_test),
>> +            "--qemu", self.qemu_bin,
>> +            "--qargs", qargs,
>> +            "--binary", "",
>> +            "--test", str(gdb_script),
>> +            "--gdb", gdb_path,
>> +        ]
>> +
>> +        res =3D subprocess.run(cmd, text=3DTrue,
>> +                             stdout=3Dsubprocess.PIPE,
>> +                             stderr=3Dsubprocess.STDOUT)
>> +        if res.stdout:
>> +            self.log.info('run-test.py: %s', res.stdout)
>> +
>> +        self.assertEqual(res.returncode, 0,
>> +                         f"run-test.py failed ({res.returncode}):\n")
>> +
>> +
>> +if __name__ =3D=3D '__main__':
>> +    QemuSystemTest.main()
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

