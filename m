Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C5C02180
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 00:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXUvA-0004ro-9j; Mon, 13 Jan 2025 19:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXUv8-0004rC-6E; Mon, 13 Jan 2025 19:36:38 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXUv5-000567-UZ; Mon, 13 Jan 2025 19:36:37 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4b11a110e4eso1176762137.1; 
 Mon, 13 Jan 2025 16:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736814994; x=1737419794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CL1CmDDWWTjA7Ao/49rzONkyXpxTm83GoBMJW+CD5GA=;
 b=WkxzoW7K5ThBMH3biPT2/DZ/cMKeyEWeHx/Cn+YrVBDTVsrnLjGkNOxoHJHio60UcT
 S9zft2OTIiTemngkgVbE5lrQ3dYFLX+Bof6fYANSnGw+5D20L3wIPeXJTODBDzJ8P4Wu
 xYPmCtlHAxxrfK+gPGXLC9cZ5qRBu1x8Z3cpfgYyP/d+ldaOu91kGmSs3TOWTGvHYxH2
 yq0amMHhJYzC41liinnYCHrDW2fpOASbYLYAAZaAFkopyQVK30fGQ7i4Id/DToHytmJK
 IKFDOnhh8tyZLpbwJPVb4IhAaYKfPKRCSFfa3dk29uLKaWaqV5mgBLIpmMGKD6KGbUVS
 /Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736814994; x=1737419794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CL1CmDDWWTjA7Ao/49rzONkyXpxTm83GoBMJW+CD5GA=;
 b=hFFIw9W8X2s7AAib/dq5kurCfpvZ54ukIL8u7D+YaW8z1cIAoYRR8gDXO7tweSvANY
 Aquu6Fss/zGxKI5POaPVXwaDpsty3lgMbZ3mkicR5/XIs4+V/ZxRvSorlipfifbGRZms
 vunDtELnF4wNYnQcV3+MtYIODbSpj60Jh/o97yCETd1+IC0KY5GnIG6t8yDfRgblUUUk
 wj6CjOZh7zMXBsMe2kMuyKqv22+8GMoSNVjQlORU6XdR1f4+hQXiRPo662cQfJEBggU+
 wTTsIpbNMQ933nuhQKbUHoB3sY2spIcvYt1qwNQne/+D+AznY6ufIQtnPJIW8r694BnP
 yeXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP6kPPVr69hrel8kMDwLg3YV+EquJlIaO0jIpr3n1n8BC/6qiPHLTyCMjXTjQmJZ6+XM5l6craRhAg@nongnu.org
X-Gm-Message-State: AOJu0YxVz0EwwUeYw0A+iscWoPrTplmoSp6mXbnpYSXL3lW/TkCUvfkm
 5sj+ZQN+geAaItRleGgchT9vuL3VaL1HT7RIDmFUK8v+xI8QbZpFykA9yrn6qRzJivkxp8FXKIY
 SDJizO2k3Aq4+3GVXQEnUfv2PxM0=
X-Gm-Gg: ASbGnctT3bTATNXzM+Co5jDrrA5xO36QGt6cTrMwKFqG7Y9a425YyBsrQ63OzTHME46
 BhszEKno6Pn34nsTdG7GWm/eFINWEu2jsBeXTqV27HfPOZ+OCuBD1jA7NVQWE6lyi3ac=
X-Google-Smtp-Source: AGHT+IGTL7gXCDd6zc43wRs2I892LUxKyPihJ4u0ffvfS+CL/6ydcjgXnsz0xVVoBxbQGUsKUj9h0aYLM3TBQSZ2SWE=
X-Received: by 2002:a05:6102:292b:b0:4b2:7446:fc18 with SMTP id
 ada2fe7eead31-4b3d0fb67bemr20508517137.17.1736814994045; Mon, 13 Jan 2025
 16:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20250110125441.3208676-1-cleger@rivosinc.com>
In-Reply-To: <20250110125441.3208676-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2025 10:36:08 +1000
X-Gm-Features: AbW1kvYVHVT_Yw6hDij0URZAvbV9hdv2FHFiAn3tu6SAT7IyYOnE8M-2mC12Mcg
Message-ID: <CAKmqyKM45q3goC06aPFkLFdW1U-Ktkcwyd3QPS1ZcyJm7LmXig@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] target/riscv: Add support for Smdbltrp and
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Fri, Jan 10, 2025 at 10:55=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
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
>   $ git switch -C dbltrp_v8 dev/cleger/dbltrp_v8
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
> Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v8 [2]
> Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [3]
> Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dblt=
rp_v1 [4]
> Link: https://lore.kernel.org/qemu-riscv/20241217062440.884261-1-frank.ch=
ang@sifive.com/ [5]
>
> ---
>
> V8:
>  - Rebased on top of Atish counter_delegation_v4 series
>
> V7:
>  - Rebased on riscv-to-apply.next, on top of snrmi v10 series
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
>  target/riscv/cpu_helper.c | 116 +++++++++++++++++++++++++++++++-------
>  target/riscv/csr.c        |  94 +++++++++++++++++++++++++-----
>  target/riscv/op_helper.c  |  47 ++++++++++++++-
>  7 files changed, 240 insertions(+), 37 deletions(-)

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> --
> 2.47.1
>
>

