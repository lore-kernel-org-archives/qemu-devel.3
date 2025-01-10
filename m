Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C190E7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 02:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW4WO-0008Uf-E9; Thu, 09 Jan 2025 21:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4WM-0008U9-6A; Thu, 09 Jan 2025 21:13:10 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4WJ-00067w-R3; Thu, 09 Jan 2025 21:13:09 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5162571e761so573400e0c.2; 
 Thu, 09 Jan 2025 18:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736475186; x=1737079986; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Pzw4XCx03pIuEYMR2vNAUk1grdo3mo7WUS5bF+dcqg=;
 b=C7lkLN+wIAoc1FDyXWSqSCyv0xVbFkbHJnL0M3mk3dIk/etPsYsLPPWp/a8ZlLRaoh
 /Ip4jfHsy87w3bQDx77yzbkEiPU0KG+xelSIyjFmtwzdaQec/gPgokfZ4EaBBbvn7i8Y
 fNq1zPxNTIBSG6LxPI8/mSYoOnrnXUWjxNNUiOBfbEQZhpT6it/ctqPWSoMiaOk180+Z
 r35Iwn//k88CbsxpzEsPNotdNud4y71tGT4nRtQyG7nvrYVv3/51uNqDbhYMmxpkvZ8r
 LNbRdET5IN9AUP2RQG6my+CeQEoTx0b5USEdiD9PcJXHuwSKZ4k0fK0fj147hlT7ebQr
 RBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736475186; x=1737079986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Pzw4XCx03pIuEYMR2vNAUk1grdo3mo7WUS5bF+dcqg=;
 b=unLTuthnl/oZm9oMJklz4bNL+tTx8MCJ74EDrJYb33LovkND4aC0s28/Dxa+QOEvUB
 xtn3tWz2nsylZvwe/TT1h0s1BA7RMLpNwxFHpi2gLm+URmrst7GOaP5y77XLG8W38hji
 K93o+0qH5LWLFK6qi9SBUnel165mrO0jg3yWm4/VXV0ETH6nhHKH5dCd545lqBDLXqrJ
 mXEA4JGrQ0dnyB4TTH0/NWumGZtSy03c9PdYJtDL2/2mc3KjrVDe0DVi9vbogjEm/YqX
 v8Ddw9RWWYce00wunTCz5+EjqDCKCR2YX7X3Isg2sGcHcSJnf/XPCHa/c2rzLwGkKjqL
 WA4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcXhvQKcaHtmcyhzvhMBheuLC5x0r3Vm0ofU6XqaB1wt6/Aqxl7qRVxVKJ8uAKKiaMzmxH6uQNif/O@nongnu.org
X-Gm-Message-State: AOJu0Yz87bDO722IKVG3Q3fU32/EoTjv7gEEmIB+Ck2vt8uUUjw4gzep
 1E0Lb+yp4qb1ASkLL29Bw51Jg+ZB39X/QW8ip5fgBBmKpBELvy8kJK5HASvfsaMSHcp7gnpl7ht
 ipLU8i0UIA9Qj+bx6SU71kgZ4oFk=
X-Gm-Gg: ASbGncuCrm/Ibru/FDQivafV3Ze2pvmCjMBrXnGIB2Cn4tYXs2jaH76po2DC688vzsX
 /3Lrva22UwJMVvtOu4vrpoRXqdupE2VuB3zdatPubl+5kApEIplltU7L3v2PV19O+OIc=
X-Google-Smtp-Source: AGHT+IER1T2bEOksocxiHjBuCP1dE0g7QhSfAUQh55nHqcxN40RBr9eY2zstdnykuGZS3BEr8X5fXLePfSAMoLI73cQ=
X-Received: by 2002:a05:6122:1796:b0:50f:f21c:4fd0 with SMTP id
 71dfb90a1353d-51c6c522a97mr8108399e0c.8.1736475186109; Thu, 09 Jan 2025
 18:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20241217090707.3511160-1-cleger@rivosinc.com>
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 12:12:39 +1000
X-Gm-Features: AbW1kvbpecyNnJECs7Kg3_OgiQ5IkNRWkKies0KD8G1G9akMvYphUyouUXs_yGc
Message-ID: <CAKmqyKNSfObU9pacZ1B=+3WVtBzBcmHJu-D0dBvrtnr=jhkzJg@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] target/riscv: Add support for Smdbltrp and
 Ssdbltrp extensions
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Tue, Dec 17, 2024 at 7:10=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> A double trap typically arises during a sensitive phase in trap handling
> operations =E2=80=94 when an exception or interrupt occurs while the trap
> handler (the component responsible for managing these events) is in a
> non-reentrant state. This non-reentrancy usually occurs in the early
> phase of trap handling, wherein the trap handler has not yet preserved
> the necessary state to handle and resume from the trap. The occurrence
> of such event is unlikely but can happen when dealing with hardware
> errors.
>
> This series adds support for Ssdbltrp and Smdbltrp ratified ISA
> extensions [1]. It is based on the Smrnmi series [5].
>
> Ssdbltrp can be tested using qemu[2], opensbi (master branch), linux[3] a=
nd
> kvm-unit-tests[4]. Assuming you have a riscv environment available and
> configured (CROSS_COMPILE), it can be built for riscv64 using the
> following instructions:
>
> Qemu:
>   $ git clone https://github.com/rivosinc/qemu.git
>   $ cd qemu
>   $ git switch -C dbltrp_v6 dev/cleger/dbltrp_v6
>   $ mkdir build && cd build
>   $ ../configure --target-list=3Driscv64-softmmu
>   $ make
>
> OpenSBI:
>   $ git clone https://github.com/rivosinc/opensbi.git
>   $ cd opensbi
>   $ make O=3Dbuild PLATFORM_RISCV_XLEN=3D64 PLATFORM=3Dgeneric
>
> Linux:
>   $ git clone https://github.com/rivosinc/linux.git
>   $ cd linux
>   $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
>   $ export ARCH=3Driscv
>   $ make O=3Dbuild defconfig
>   $ ./script/config --file build/.config --enable RISCV_DBLTRP
>   $ make O=3Dbuild
>
> kvm-unit-tests:
>   $ git clone https://github.com/clementleger/kvm-unit-tests.git
>   $ cd kvm-unit-tests
>   $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
>   $ ./configure --arch=3Driscv64 --cross-prefix=3D$CROSS_COMPILE
>   $ make
>
> You will also need kvmtool in your rootfs.
>
> Run with kvm-unit-test test as kernel:
>   $ qemu-system-riscv64 \
>     -M virt \
>     -cpu rv64,ssdbltrp=3Dtrue,smdbltrp=3Dtrue \
>     -nographic \
>     -serial mon:stdio \
>     -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
>     -kernel kvm-unit-tests-dbltrp/riscv/sbi_dbltrp.flat
>   ...
>   [OpenSBI boot partially elided]
>   Boot HART ISA Extensions  : sscofpmf,sstc,zicntr,zihpm,zicboz,zicbom,sd=
trig,svadu,ssdbltrp
>   ...
>   #######################################################################=
###
>   #    kvm-unit-tests
>   #######################################################################=
###
>
>   PASS: sbi: fwft: FWFT extension probing no error
>   PASS: sbi: fwft: FWFT extension is present
>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value
>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value =3D=3D 0
>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value =3D=3D 0
>   PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value =3D=3D 1
>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value =3D=3D 1
>   PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
>   INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
>
>   sbi_trap_error: hart0: trap0: double trap handler failed (error -10)
>
>   sbi_trap_error: hart0: trap0: mcause=3D0x0000000000000010 mtval=3D0x000=
0000000000000
>   sbi_trap_error: hart0: trap0: mtval2=3D0x0000000000000003 mtinst=3D0x00=
00000000000000
>   sbi_trap_error: hart0: trap0: mepc=3D0x00000000802000d8 mstatus=3D0x800=
0000a01006900
>   sbi_trap_error: hart0: trap0: ra=3D0x00000000802001fc sp=3D0x0000000080=
213e70
>   sbi_trap_error: hart0: trap0: gp=3D0x0000000000000000 tp=3D0x0000000080=
088000
>   sbi_trap_error: hart0: trap0: s0=3D0x0000000080213e80 s1=3D0x0000000000=
000001
>   sbi_trap_error: hart0: trap0: a0=3D0x0000000080213e80 a1=3D0x0000000080=
208193
>   sbi_trap_error: hart0: trap0: a2=3D0x000000008020dc20 a3=3D0x0000000000=
00000f
>   sbi_trap_error: hart0: trap0: a4=3D0x0000000080210cd8 a5=3D0x0000000080=
2110d0
>   sbi_trap_error: hart0: trap0: a6=3D0x00000000802136e4 a7=3D0x0000000046=
574654
>   sbi_trap_error: hart0: trap0: s2=3D0x0000000080210cd9 s3=3D0x0000000000=
000000
>   sbi_trap_error: hart0: trap0: s4=3D0x0000000000000000 s5=3D0x0000000000=
000000
>   sbi_trap_error: hart0: trap0: s6=3D0x0000000000000000 s7=3D0x0000000000=
000001
>   sbi_trap_error: hart0: trap0: s8=3D0x0000000000002000 s9=3D0x0000000080=
083700
>   sbi_trap_error: hart0: trap0: s10=3D0x0000000000000000 s11=3D0x00000000=
00000000
>   sbi_trap_error: hart0: trap0: t0=3D0x0000000000000000 t1=3D0x0000000080=
213ed8
>   sbi_trap_error: hart0: trap0: t2=3D0x0000000000001000 t3=3D0x0000000080=
213ee0
>   sbi_trap_error: hart0: trap0: t4=3D0x0000000000000000 t5=3D0x0000000080=
20f8d0
>   sbi_trap_error: hart0: trap0: t6=3D0x0000000000000000
>
> Run with linux and kvm-unit-test test in kvm (testing VS-mode):
>   $ qemu-system-riscv64 \
>     -M virt \
>     -cpu rv64,ssdbltrp=3Dtrue,smdbltrp=3Dtrue \
>     -nographic \
>     -serial mon:stdio \
>     -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
>     -kernel linux/build/arch/riscv/boot/Image
>   ...
>   [Linux boot partially elided]
>   [    0.735079] riscv-dbltrp: Double trap handling registered
>   ...
>
>   $ lkvm run -k sbi_dbltrp.flat -m 128 -c 2
>   #######################################################################=
###
>   #    kvm-unit-tests
>   #######################################################################=
###
>
>   PASS: sbi: fwft: FWFT extension probing no error
>   PASS: sbi: fwft: FWFT extension is present
>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value
>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value =3D=3D 0
>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value =3D=3D 0
>   PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
>   PASS: sbi: fwft: dbltrp: Set double trap enable feature value =3D=3D 1
>   PASS: sbi: fwft: dbltrp: Get double trap enable feature value =3D=3D 1
>   PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
>   INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
>   [   51.939077] Guest double trap
>   [   51.939323] kvm [93]: VCPU exit error -95
>   [   51.939683] kvm [93]: SEPC=3D0x802000d8 SSTATUS=3D0x200004520 HSTATU=
S=3D0x200200180
>   [   51.939947] kvm [93]: SCAUSE=3D0x10 STVAL=3D0x0 HTVAL=3D0x3 HTINST=
=3D0x0
>   KVM_RUN failed: Operation not supported
>   $
>
> Testing Smbdbltrp can be done using gdb and trigger some trap. For
> instance, interrupt M-mode firmware at some point, set mstatus.mdt =3D 1
> and corrupt some register to generate a NULL pointer exception.
>
> Link: https://github.com/riscv/riscv-isa-manual/commit/52a5742d5ab5a07920=
19033631b2035a493ad981 [1]
> Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v7 [2]
> Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [3]
> Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dblt=
rp_v1 [4]
> Link: https://lore.kernel.org/qemu-riscv/20241217062440.884261-1-frank.ch=
ang@sifive.com/ [5]
>
> ---
>
> V7:
>  - Rebased on riscv-to-apply.next, on top of snrmi v10 series

Sorry for asking again, but can you do another rebase on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

All these new extensions are conflicting a lot unfortunately, but at
least snrmi has been merged :)

Alistair

>
> V6:
>  - Simplify and fix write_henvcfg() masking by assigning the written
>    value to henvcfg and mask the value to be written as well as clearing
>    the upper part of henvcfgh upon writing.
>  - Rebased on RNMI v9 series.
>
> V5:
>  - Use 0 instead of false to set MSTATUS_MDT in helper_mnret()
>  - Added explicit comments about henvcfg write mask being tricky.
>  - Fixed a invalid menvcfg_mask in write_henvcfgh
>
> V4:
>  - Remove DTE from sstatus_v1_10_mask variable and add specific if for
>    DTE masking where it's used.
>  - Use mstatus_hs.sdt field rather than setting DTE to 0 in
>    riscv_do_cpu_interrupt().
>  - Add a fix for henvcfg value which was incorrectly set after changing
>    menvcfg
>  - Remove useless ext_ssdbltrp check in
>    riscv_env_smode_dbltrp_enabled().
>  - Remove useless mstatus clear in write_mstatus().
>  - Add proper handling of SDT writing to vsstatus.
>  - Add clearing of vsstatus//mstatus SDT field when DTE is disabled.
>  - Fix wrong value being written for MDT/MIE in write_mstatush().
>  - Rebased on Frank Snrnmi v7
>
> V3:
>  - Fix spec version from 1.12 to 1.13 for Smdbltrp and Ssdbltrp
>  - Add better comments for dte/sdt computation in
>    riscv_cpu_do_interrupt().
>  - Move some CSR related changes to the CSRs related commits.
>
> V2:
>  - Squashed commits that added ext_s{s|m}dbltrp as suggested by Daniel
>
> Cl=C3=A9ment L=C3=A9ger (9):
>   target/riscv: Fix henvcfg potentially containing stale bits
>   target/riscv: Add Ssdbltrp CSRs handling
>   target/riscv: Implement Ssdbltrp sret, mret and mnret behavior
>   target/riscv: Implement Ssdbltrp exception handling
>   target/riscv: Add Ssdbltrp ISA extension enable switch
>   target/riscv: Add Smdbltrp CSRs handling
>   target/riscv: Implement Smdbltrp sret, mret and mnret behavior
>   target/riscv: Implement Smdbltrp behavior
>   target/riscv: Add Smdbltrp ISA extension enable switch
>
>  target/riscv/cpu.c        |   9 ++-
>  target/riscv/cpu.h        |   1 +
>  target/riscv/cpu_bits.h   |   8 +++
>  target/riscv/cpu_cfg.h    |   2 +
>  target/riscv/cpu_helper.c | 115 +++++++++++++++++++++++++++++++-------
>  target/riscv/csr.c        |  95 ++++++++++++++++++++++++++-----
>  target/riscv/op_helper.c  |  47 +++++++++++++++-
>  7 files changed, 239 insertions(+), 38 deletions(-)
>
> --
> 2.45.2
>
>

