Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B0FCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuUW-0007Fn-9w; Tue, 12 May 2026 17:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUN-0006s1-Rq; Tue, 12 May 2026 17:18:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUL-0006v3-KF; Tue, 12 May 2026 17:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619496; bh=z2rxPN6rK9hQ1RBi//OQJXeRRWP5Jsh7MoyvVOcfH6k=;
 h=From:To:Cc:Subject:Date;
 b=OC0KWFF+reiSaNw/LVA59OT3X97evSiKefpoE0UymT7Q/4z+gqLPNGcZGOylrvFjw
 GK+mq/D60IPQRl+2r7UFab4vWUbifqA1/m9LX8YAUAWv6Yj7wnj1jKKnWIuu6cEs6T
 3k2j7yO2okULElnUw+P4Bdoh5jJMkc7BhYk3zzc5uA9WRWCKxPOXgAPjzhCGKrb4QU
 454YsitcV5hGQiObWKfaPfWXwOr82ogClbfPztTFvrabYB/zWRdUReUIyjMYoD5Pbi
 tbG7MCE1hnhtcmc7bNpuZH7QYnfAbYGWy/SUdaY8llMv5jhPDV5GTPi01mEPCEZ9Bi
 MGIK+ZUkpMjsA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BEBBF1AA3CB;
 Tue, 12 May 2026 23:58:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CBD703ABD23;
 Tue, 12 May 2026 23:58:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 00/58] Patch Round-up for stable 11.0.1,
 freeze on 2026-05-22
Date: Tue, 12 May 2026 23:57:21 +0300
Message-ID: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

The following patches are queued for QEMU stable v11.0.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.0

Patch freeze is 2026-05-22, and the release is planned for 2026-05-24:

  https://wiki.qemu.org/Planning/11.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 7437b3eab6af Werner de Carne:
   serial COM: windows serial COM PollingFunc don't sleep
02 52cf667ed228 GuoHan Zhao:
   ui/spice-app: detect runtime directory creation failures
03 181fdf8a7e13 Marc-André Lureau:
   ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
04 027ad866bd29 Pierrick Bouvier:
   target/arm/tcg/translate.c: remove MO_TE usage
05 87e1226e6f68 Marc-André Lureau:
   target/i386: fix strList leak in x86_cpu_get_unavailable_features
06 3eae91a8b93a Simon Scherer:
   target/i386: fix missing PF_INSTR in SIGSEGV context
07 c906c2337058 rickgcn:
   hw: i386: vapic: restore IRQ polling for non-kernel irqchip backends
08 7d6231dfb5ea Magnus Kulke:
   target/i386/mshv: Fix segment regression in MMIO emu
09 76ad26dd172d Paolo Bonzini:
   target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
10 79bc17718677 Stepan Popov:
   meson: add missing semicolon in pthread_condattr_setclock test
11 7077c83f71a7 Anthony Roberts:
   ui/sdl2: Fix assumption of EGL presence at runtime
12 30fad722ce68 Alex Bennée:
   hw/display: don't accidentally autofree existing virgl resources
13 d41ce10d0f5a Vladimir Sementsov-Ogievskiy:
   migration: vmstate_save_state_v: fix double error_setg
14 0990cc8b286b Junjie Cao:
   ati-vga: fix unsigned integer overflow in cursor bounds checks
15 c0306d2b8f45 Thomas Huth:
   hw/misc: Fix the valid access size to the avr-power device
16 3ab47a47d716 Thomas Huth:
   hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
17 654dce6c5236 Matt Turner:
   linux-user/ppc: Fix ppc64 rt_sigframe stack offset
18 029f10e85278 Yixin Wei:
   linux-user: fix off-by-one in host_to_target_for_each_rtattr()
19 93484c768f2b Gyorgy Tamasi:
   linux-user: Don't define target_stat64 struct for loongarch64
20 c8ea1759009a Richard Henderson:
   linux-user/arm/nwfpe: Replace user_registers with current_cpu
21 784f1dde90df Richard Henderson:
   linux-user/arm/nwfpe: Use thread-local storage for qemufpa
22 1730e6f33f97 Alistair Francis:
   linux-user/strace: Use pointer type for read and write values
23 4c681ba3b82d James Hilliard:
   linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
24 8b60ed835478 Helge Deller:
   linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
25 edb4588309a7 Helge Deller:
   linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
26 07c7decaa54a Helge Deller:
   linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
27 b03a6ac6fa5d Helge Deller:
   linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
28 e2af3eadc09b Helge Deller:
   linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
29 9e7734ead149 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
30 b8c2426157f5 Daniel P. Berrangé:
   util: fix use of pthread_get_name_np on OpenBSD
31 57abf6b1d576 Luc Michel:
   hw/core/register: add register_array_get_owner
32 4cb2f91773e8 Yicong Yang:
   hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
33 b2e874bfec59 Sebastián Alba Vives:
   target/riscv: fix stale ptshift and base on page walk restart
34 d5b33fc180f5 Sebastián Alba Vives:
   hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
35 14808578ccbc Munkhbaatar Enkhbaatar:
   riscv_htif: reject invalid signature ranges (end <= begin)
36 d107b748072c Alistair Francis:
   target/riscv: Generate access fault if sc comparison fails
37 175afdb0d155 Alistair Francis:
   target/riscv: Don't OR mip.SEIP when mvien is one
38 5dcc64828dc7 Alistair Francis:
   target/riscv: Use ELEN for Fractional LMUL check
39 dcb6e96257ee Helge Deller:
   linux-user: Add missing CDROM ioctls
40 9fb681792d65 Helge Deller:
   linux-user: Flush errors by using exit() instead of _exit() in error path
41 08dc3e240fc0 Helge Deller:
   linux-user: Allow getsockopt() with NULL optval address
42 9667bf324925 Helge Deller:
   linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
43 1aee8067fce9 kiki:
   hw/intc/xics: Add a check for an invalid server id
44 774e6f5c1533 Vivien LEGER:
   hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
45 a7f27d6903b3 宋文武:
   hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
46 f35f0f1ca121 liugan1:
   hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
47 f77a7cec9f64 Fabiano Rosas:
   migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
48 455a6167f254 Peter Xu:
   migration: Fix low possibility downtime violation
49 41c417290df9 Philippe Mathieu-Daudé:
   target/microblaze: Fix endianness used to disassemble
50 f443b6876362 Peter Maydell:
   target/arm: Report IL=0 for Thumb 16-bit BKPT insn
51 18b664c90085 Peter Maydell:
   hw/misc/bcm2835_rng: Specify valid memory access sizes
52 f252769a23e6 Gerd Hoffmann:
   hw/uefi: fix buffer overruns
53 94d9a8b2c9e6 Gerd Hoffmann:
   hw/uefi: verify pio_xfer_offset before calculating buffer checksum
54 5247b3034c23 Gerd Hoffmann:
   hw/uefi: fix ucs2 string helper functions
55 c45b460d16f9 Gerd Hoffmann:
   hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
56 22b7b222d8f5 Gerd Hoffmann:
   hw/uefi: verify data size before accessing it in wrap_pkcs7
57 b4680c02b8e8 Gerd Hoffmann:
   hw/uefi: avoid possibly unaligned variable_auth_2 struct field access
58 b4ec2e8dae4d Fabiano Rosas:
   tests/functional: Make socat wait longer in migration exec test

