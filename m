Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4A2C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd9-0004j8-5H; Wed, 17 Jul 2024 22:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcf-0001ky-Gk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcd-0003gh-7O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc5296e214so2824985ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268714; x=1721873514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTnaaC2sXirvbn1f957lm3joN6tdDiaSgYgNswn/YhQ=;
 b=Sr/ka+d7uBMHDl67UEAg49On5yF8QMj+F0Dljd2F7hgumB0DGhS6Ev1chlAff0WQi4
 /HlmMnBvmkjubLw9Q9p3DFNGia0VOE8ylVDft/y6MJyGZmGUAQSDrmggRmEIm/gSpvhT
 i6uj0wP94Nz/OFBqsqXNy5qmfSvNhRc7yXhIy0NqfbuPGk1nB3ruyONRIa7s2pElDuRe
 piY6ZlAf1i79bb1vuGjs6T+nvU693zScDauK8x+OrGhWu0Cwc9KjoKE1WBFvU9ySVX+X
 4s3Yd4zLAU5qoc77rMdRTwLROMgvMTAyc/QIlnkHyeCc9Xz/NLsuDDZJmUNg9jpqWt5f
 HCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268714; x=1721873514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTnaaC2sXirvbn1f957lm3joN6tdDiaSgYgNswn/YhQ=;
 b=pDygTSbeDrzT9dI9+axChpBRDqdjCmD3vO3B+VqOthyBSvm6GuDsxpwzKbEDdeqzBm
 w+5JZG48YmncxRrVzMl9lqs3MP6eFtod+/AF1lMlXzt+ng5y91FTNz9fLDvtUkMxhYIA
 GAebTuDzUcCJGkEUTevO6lXSTeTeFfZSCkmOtd6ql5IqHpJx4YoBHw03UZ/JKLe5HKd8
 G6wjgbeOIgwnlAiCBQ0TusmHJJP131ZPDAc8p78TSkNY7TCPwmE4XoLvhcdlRdrevAYl
 Cbvh46VWujU2dSN7/dk2nOe0laRs6tarl7WB8RRQXI/cAEw5WEGcqTwPUedsaoSZvJ2R
 mHQA==
X-Gm-Message-State: AOJu0YwyXVjlOwhb5QPSLImag3Vva2iK7s+AGEOmVpz+NR+PNm/C7fQ9
 mAidvHOzRnymHlRnDxwrzTE160HKrnD/lR/Gt9mRUtmHZaJowA99f7pWEAWc
X-Google-Smtp-Source: AGHT+IH/vnIZnA4lWjbNVFvhRMKxCZ4uTFkYsDma/x6cxdX+wR+4fmrHmz4ezbEbHx4hGxPbaB27ng==
X-Received: by 2002:a17:902:f682:b0:1fc:58fc:caf7 with SMTP id
 d9443c01a7336-1fc58fccce2mr21301235ad.14.1721268713538; 
 Wed, 17 Jul 2024 19:11:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/30] roms/opensbi: Update to v1.5
Date: Thu, 18 Jul 2024 12:10:12 +1000
Message-ID: <20240718021012.2057986-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
v1.5.

The following commits were included in v1.5:

455de67 include: Bump-up version to 1.5
23b7bad lib: sbi: check incoming dbtr shmem address
0e45b63 docs: Fix wrong filename
caae2f7 lib: sbi: fwft: return SBI_EINVAL rather than SBI_ERR_INVALID_PARAM
e8717d1 lib: sbi: fwft: check feature value to be exactly 1 or 0
ecef14d lib: sbi: implement SBI FWFT extension
e9ee967 lib: sbi: fwft: add support for SBI_FWFT_PTE_AD_HW_UPDATING
c97a1d5 lib: sbi: fwft: add support for SBI_FWFT_MISALIGNED_EXC_DELEG
aa5a859 lib: sbi: add support for firmware features extension
53844c9 lib: sbi: Add support for Svade and Svadu extensions
52dcf35 platform: generic: andes: Add support for RV32 to set up PMA
f09f164 platform: generic: andes: Refine Andes PMA related code
7830e98 lib: serial: fix RX path in litex-uart
62e178a lib: utils/reset: Try initializing all reset devices in dt
3a94a32 sbi: sbi_domain_context: Fix trap context for domain context switching
a73ff04 lib: utils/reset: Fix fdt_reset to search for more dt nodes
b5c984b lib: utils/reset: Skip initialize reset when dt is not enabled
86bbe6c lib: utils/serial: Fix fdt_serial to match more dt nodes
179e00a lib: utils/serial: Skip initialize serial when dt is not enabled
b1c7c75 lib: utils/irqchip: Skip initialize irqchip when dt is not enabled
5e3ad7d lib: utils/timer: Skip initialize timer when dt is not enabled
c5be0e1 lib: utils/ipi: Skip initialize ipi when dt is not enabled
df3db6a lib: utils/fdt: Fix DT property for APLIC delegation
d962db2 lib: utils/gpio: respect flag GPIO_FLAG_ACTIVE_LOW
ae5ef18 lib: sbi: sse: handle missing writable attributes
858754a lib: utils/irqchip: Add sanity checks in imsic_get_data() and imsic_get_target_file()
96f0a2e firmware: Bring back FW_TEXT_START as an optional parameter
e3a30a2 lib: utils/irqchip: Check before initializing imsic
2bed4c1 platform: generic: thead: add Sophgo CV18XX/SG200X series
533067d lib: sbi: Put event after use in sbi_sse_exit() loop
ea9cf6a utils/reset: Add SG2042 hwmon MCU support.
1cb792d lib: sbi: simplify inline function in sbi_dtbr.c
7b37da3 lib: sbi: fix return type of sbi_dbtr_shmem_disabled
e065c3c lib: sbi: Fixed memory permission check in sbi_dbtr_setup_shmem
7f54527 lib: sbi: fix DBTR_SHMEM_MAKE_PHYS for RV64
744f495 lib: sbi: Removal unnecessary check dbtr_thishart_state_ptr
4953bd7 lib: sbi: fix hart_shmem_base
019a8e6 platform: generic: thead: add Canaan Kendryte K230
33e21c9 platform: generic: thead: separate T-Head PMU Errata
2b93ce0 platform: andes: Change all occurrences of andes45 to andes
f68b3ae platform: andes: Rename files with the prefix andes45
17e8291 sbi: sbi_domain_context: Add spinlock for updating domain assigned_harts
1d89a9d lib: sbi: Refine the settings for switching to Virtual Supervisor Mode.
033104d lib: sbi: sse: check handler entry to belong to supervisor mode
bd00765 lib: sbi: sse: use PRV_S instead of hardcoded value for mode
ce3c82c lib: sbi: sse: call enable callback before sending IPI
d528dbf lib: sbi: sse: remove superfluous sbi_list_empty() check
22ff750 lib: sbi: sse: simplify 32bits overflow check
7aa80ea lib: sbi: sse: rename sse_hart_unlock() to sse_enabled_event_unlock()
c21c99d lib: sbi: sse: fix typos, comments and spacing errors
7b1ed96 lib: tests: Add test for spinlocks
7bdf41a lib: tests: Add test for atomic_t
f6243d9 lib: tests: Add test suite init function
d4d2582 firmware: remove FW_TEXT_START
73344d4 lib: utils: check correct value in fdt_node_offset_by_compatible
37e1544 lib: sbi: sse_event_get() may return NULL
68bc031 lib: sbi: Add missing sscrind and sscfg extensions in sbi_hart_ext[]
a7c5c2c Makefile: Remove unnecessary dependencies
268feab Makefile: Respect manual changes to .config
29ecda9 sbi: sbi_domain_context: Check privilege spec version before accessing S-mode CSRs
7862c24 lib: sbi: Wakeup non-coldboot HARTs early in the coldboot path
beb0cd1 lib: sbi: Simplify wait_for_coldboot() implementation
f5375bc platform: generic: allwinner: Optimize current hart scratch access
b94396c lib: utils/timer: Optimize current hart scratch access
5c9a735 include: sbi: Support byteorder macros in assembly
06fc453 lib: sbi: Add SSE support for PMU events
09ad214 lib: sbi: Implement SBI SSE extension
c8cdf01 lib: sbi: Add support for Supervisor Software Events extension
76d7e9b firmware: remove copy-base relocation
5186da6 platform: generic: allwinner: sun20i-d1: Remove duplicated CSR definitions
3b2f89e docs: writing_tests: Make docs correspond the latest changes
f7d0050 lib: sbi: Extend sbi_trap_error() to dump state in a nested trap
5b11f16 lib: sbi: Pass trap context pointer to sbi_ecall_handler()
43d346c lib: sbi: Remove regs parameter from trap irq handling functions
d84e7eb lib: sbi: Remove regs paramter of sbi_irqchip_process()
f414cf9 lib: sbi: Simplify parameters of sbi_illegal_insn_handler()
fea33a9 lib: sbi: Simplify parameters of misaligned and access fault handlers
abea949 lib: sbi: Introduce trap context
60ffc15 include: sbi: Add trap_context pointer in struct sbi_scratch
ebb697a lib: sbi: Remove sbi_trap_exit() and related code
2e85178 lib: sbi: Remove epc from struct sbi_trap_info
86224ec docs/writing_tests: Update tests paths
5c992a1 lib: tests: Move tests to a separate directory
81e3ba7 lib: sbi: call platform load/store emulators
ddf3b64 include: sbi: add emulate_load/store handler to platform ops
4c11265 lib: sbi: abstract out insn decoding to unify mem fault handlers
9221fe5 lib: sbi: change prototype of sbi_misaligned_load/store_handler
a17600c lib: sbi: change prototype of sbi_trap_redirect
2471cf2 include: sbi: rename sbi_misaligned_ldst.h to sbi_trap_ldst.h
c0a6320 lib: sbi: rename sbi_misaligned_ldst.c to sbi_trap_ldst.c
e11025c lib: sbi: Add initial domain context management support
87d8fe7 lib: tests: Add sbi_console test
e5f53fd lib: tests: Add a test for sbi_bitmap
874fcef lib: Add SBIUnit testing macros and functions
b9e4de0 docs: Add documentation about tests and SBIUnit
526b9ce firmware: fw_base.S: fix _reset_regs
8151105 firmware: fw_base.S: Remove _relocate_lottery
187397f firmware: fw_dynamic.S: Remove _bad_dynamic_info
b27b7c6 firmware: fw_base: Simplified setup trap handler
fdf5589 firmware: fw_base.S: Simplify address get
748bef1 lib: sbi_misaligned_ldst: Add handling of C.LHU/C.LH and C.SH
bc36678 platform: andes: Drop andes_pmu_setup()
6bb6b61 lib: sbi: Add support for smcsrind and smcdeleg
322b598 lib: sbi_hsm: Restor hart state to stop when fails to start
96a35db docs/firmware: document new options for jump and payload firmwares
2cff7f3 platform: Apply relocatable address
f056939 firmware: Add relocatable FW_PAYLOAD_FDT_ADDR
7227cdd firmware: Add relocatable FW_JUMP_ADDR and FW_JUMP_FDT_ADDR
741e941 platform: starfive: call starfive_jh7110_inst_init() in pm_reset_init()
3edf044 platform: starfive: return error if needed devices are not present
80ae046 platform: starfive: rename "stf,axp15060-regulator" -> "x-powers,axp15060"
5335340 platform: starfive: remove redundant compatibility check in pmic_ops
4d8569d platform: starfive: get I2C offset address from clocks property
034af1f platform: starfive: correct system clock device tree node
88273fe lib: sbi_pmu: Before using we should ensure PMU init done
46c8c65 docs: move documentation of system suspend test.
8df836d platform: generic: Parse system suspend test from config node.
23e7e48 docs: Add OpenSBI DT configuration guide.
67ce5a7 platform: generic: Add support for specify coldboot harts in DT
9c8b18e firmware: fw_base.S: remove _runtime_offset
4c6b7cb firmware: fw_base.S: Improve loading u32
92e8aff firmware: always create dynsym section
d1dad07 Makefile: check for --exclude-libs
4a76f79 Makefile: don't pass -mstrict-align if not supported
21caaa3 fw_base.S: Fix comment errors
1ec353d lib: sbi: Use mask to check the free bit during trigger allocation
bb90a9e lib: sbi: Print number of debug triggers found
76a2a15 lib: sbi: Implement SBI debug trigger extension
fa87ec9 include: sbi: Add SBI debug trigger extension related defines
97f234f lib: sbi: Introduce the SBI debug triggers extension support
40dac6b lib: sbi: Detect support of debug triggers
2499769 include: sbi: Introduce debug trigger register encodings
20ca19a include: sbi: Add TINFO debug trigger CSR
b752099 include: sbi: Introduce common endianess conversion macro

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240715171521.179517-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 267416 -> 268312 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 270808 -> 272504 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 60ca1165c8..7ec260ff40 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index bae158d457..090c0cf6ac 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index a2b255b889..455de672dd 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit a2b255b88918715173942f2c5e1f97ac9e90c877
+Subproject commit 455de672dd7c2aa1992df54dfb08dc11abbc1b1a
-- 
2.45.2


