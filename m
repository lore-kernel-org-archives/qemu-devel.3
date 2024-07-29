Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45950C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcsc-0004sB-8R; Mon, 29 Jul 2024 22:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sYcsY-0004aj-D6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:46:23 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sYcsT-0003c5-Lo
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:46:22 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02AF33F433
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722292287;
 bh=WoYiD28Zd2MA7zgvlmN7lyteZE39L8q7GgpSaqHYMpo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=olVAr1v4ASW5DYmdANGu9l4rhTl+KVKTpJBkJ0Xap2t+PqoZvejTfAIeKiZ0aGGWU
 oHryQGqBRGnuD6IKZfrwdWXI5SS4OzwO/6SXkLO2puoPVJ1hsHK2yVu65ogfQAulgs
 H/u69hNjzZFEvmZh93P10/dCrU6MGSjCjG9GgyEG/8KlydT8iZFeVQm0L2OHj26rR0
 x7hE6sQ7TEV1uWZtQ1uvPjzPHhOVOM6vKda3HO46fToJLo1c+c4sTpVIlGhjlFeU4N
 zzMk1tri7JzNKWAEBBau7vqnMKQdgNp7ah/MOWfHXNAi6a4hkgHyXC55KDMMJiFuqS
 nDrCAT38G1p7g==
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52efc9f2081so3167232e87.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 15:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722292286; x=1722897086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WoYiD28Zd2MA7zgvlmN7lyteZE39L8q7GgpSaqHYMpo=;
 b=qliv3LBmdzsb1MdQP5K/uE60b//lrrXr4Q7/oSlrLcAYYj4fvb5ZTFZPF2EBHXv2H0
 vM/LnMxm8YQg1M31RtPPmqdlk2iwVqX0xK6yCB7ZY5mDOpGru0YjF+XUQ212Dh+Nh560
 fNKysUu5IvGMfCTOsdvnzM1zxqjwzE7B8JQTRgYv7orQTAitk2QRsjNI1aM5YFZgHWCG
 5OakMJk5078xl84Ye6cGtfSsRhRAUHQN1a/fBbC8kAKhGvoq3/vXrN41SqGdLWD5R7ot
 eMY3ot6c1wwDZQt6oBxCVJ8iJu8SxVq0tZsasQJOQ1P2hXDGXCexT1hNkSmCuhdRru+d
 ZD7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRSdXqgjTEsrnrUs2Zo9MPj6Y00fYeyPSpeJ/dMA85ZWYDErH5llxM0Chi5/EICWqcfiSEulGq5O58UcAEzLlNW1TRNG0=
X-Gm-Message-State: AOJu0YzTldlirq9a1pvItoHMsao7+t5z1LwG0t2SdtB0ZZ60Pzj6tj0c
 Y/idMG+sMyn02UMgN8Xyll67tmJDEGoOsfuCnrLLg8yS0D8SHd5bFfs2aa0pgcgofwZ2phks7a8
 yeyjiqndZqtF5UCYQxIsAAkCKNM8BtI0O0fyo4WI81SxGNO5YFuRRiI2iLLyx4S94Ywfv
X-Received: by 2002:a05:6512:250e:b0:52e:fa6b:e558 with SMTP id
 2adb3069b0e04-5309b26925amr9198107e87.5.1722292286279; 
 Mon, 29 Jul 2024 15:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7GI/h5fy1N+0FWwwyCwPrCy+DI1vUrn8Ssp/3lxIAYhlkomeMQSF6UULKH+qhq2qrT7E+xw==
X-Received: by 2002:a05:6512:250e:b0:52e:fa6b:e558 with SMTP id
 2adb3069b0e04-5309b26925amr9198086e87.5.1722292285690; 
 Mon, 29 Jul 2024 15:31:25 -0700 (PDT)
Received: from ?IPV6:2a00:20:3:e380:7b1e:1b56:5ce7:c192?
 ([2a00:20:3:e380:7b1e:1b56:5ce7:c192])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab53704sm562706566b.86.2024.07.29.15.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:31:24 -0700 (PDT)
Message-ID: <0a4172b9-aca0-45c4-962c-3c49327e2f5c@canonical.com>
Date: Tue, 30 Jul 2024 00:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] roms/opensbi: Update to v1.5
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 qemu-devel@nongnu.org
References: <20240715171521.179517-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240715171521.179517-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/15/24 19:15, Daniel Henrique Barboza wrote:
> Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
> v1.5.
> 
> The following commits were included in v1.5:
> 
> 455de67 include: Bump-up version to 1.5
> 23b7bad lib: sbi: check incoming dbtr shmem address
> 0e45b63 docs: Fix wrong filename
> caae2f7 lib: sbi: fwft: return SBI_EINVAL rather than SBI_ERR_INVALID_PARAM
> e8717d1 lib: sbi: fwft: check feature value to be exactly 1 or 0
> ecef14d lib: sbi: implement SBI FWFT extension
> e9ee967 lib: sbi: fwft: add support for SBI_FWFT_PTE_AD_HW_UPDATING
> c97a1d5 lib: sbi: fwft: add support for SBI_FWFT_MISALIGNED_EXC_DELEG
> aa5a859 lib: sbi: add support for firmware features extension
> 53844c9 lib: sbi: Add support for Svade and Svadu extensions
> 52dcf35 platform: generic: andes: Add support for RV32 to set up PMA
> f09f164 platform: generic: andes: Refine Andes PMA related code
> 7830e98 lib: serial: fix RX path in litex-uart
> 62e178a lib: utils/reset: Try initializing all reset devices in dt
> 3a94a32 sbi: sbi_domain_context: Fix trap context for domain context switching
> a73ff04 lib: utils/reset: Fix fdt_reset to search for more dt nodes
> b5c984b lib: utils/reset: Skip initialize reset when dt is not enabled
> 86bbe6c lib: utils/serial: Fix fdt_serial to match more dt nodes
> 179e00a lib: utils/serial: Skip initialize serial when dt is not enabled
> b1c7c75 lib: utils/irqchip: Skip initialize irqchip when dt is not enabled
> 5e3ad7d lib: utils/timer: Skip initialize timer when dt is not enabled
> c5be0e1 lib: utils/ipi: Skip initialize ipi when dt is not enabled
> df3db6a lib: utils/fdt: Fix DT property for APLIC delegation
> d962db2 lib: utils/gpio: respect flag GPIO_FLAG_ACTIVE_LOW
> ae5ef18 lib: sbi: sse: handle missing writable attributes
> 858754a lib: utils/irqchip: Add sanity checks in imsic_get_data() and imsic_get_target_file()
> 96f0a2e firmware: Bring back FW_TEXT_START as an optional parameter
> e3a30a2 lib: utils/irqchip: Check before initializing imsic
> 2bed4c1 platform: generic: thead: add Sophgo CV18XX/SG200X series
> 533067d lib: sbi: Put event after use in sbi_sse_exit() loop
> ea9cf6a utils/reset: Add SG2042 hwmon MCU support.
> 1cb792d lib: sbi: simplify inline function in sbi_dtbr.c
> 7b37da3 lib: sbi: fix return type of sbi_dbtr_shmem_disabled
> e065c3c lib: sbi: Fixed memory permission check in sbi_dbtr_setup_shmem
> 7f54527 lib: sbi: fix DBTR_SHMEM_MAKE_PHYS for RV64
> 744f495 lib: sbi: Removal unnecessary check dbtr_thishart_state_ptr
> 4953bd7 lib: sbi: fix hart_shmem_base
> 019a8e6 platform: generic: thead: add Canaan Kendryte K230
> 33e21c9 platform: generic: thead: separate T-Head PMU Errata
> 2b93ce0 platform: andes: Change all occurrences of andes45 to andes
> f68b3ae platform: andes: Rename files with the prefix andes45
> 17e8291 sbi: sbi_domain_context: Add spinlock for updating domain assigned_harts
> 1d89a9d lib: sbi: Refine the settings for switching to Virtual Supervisor Mode.
> 033104d lib: sbi: sse: check handler entry to belong to supervisor mode
> bd00765 lib: sbi: sse: use PRV_S instead of hardcoded value for mode
> ce3c82c lib: sbi: sse: call enable callback before sending IPI
> d528dbf lib: sbi: sse: remove superfluous sbi_list_empty() check
> 22ff750 lib: sbi: sse: simplify 32bits overflow check
> 7aa80ea lib: sbi: sse: rename sse_hart_unlock() to sse_enabled_event_unlock()
> c21c99d lib: sbi: sse: fix typos, comments and spacing errors
> 7b1ed96 lib: tests: Add test for spinlocks
> 7bdf41a lib: tests: Add test for atomic_t
> f6243d9 lib: tests: Add test suite init function
> d4d2582 firmware: remove FW_TEXT_START
> 73344d4 lib: utils: check correct value in fdt_node_offset_by_compatible
> 37e1544 lib: sbi: sse_event_get() may return NULL
> 68bc031 lib: sbi: Add missing sscrind and sscfg extensions in sbi_hart_ext[]
> a7c5c2c Makefile: Remove unnecessary dependencies
> 268feab Makefile: Respect manual changes to .config
> 29ecda9 sbi: sbi_domain_context: Check privilege spec version before accessing S-mode CSRs
> 7862c24 lib: sbi: Wakeup non-coldboot HARTs early in the coldboot path
> beb0cd1 lib: sbi: Simplify wait_for_coldboot() implementation
> f5375bc platform: generic: allwinner: Optimize current hart scratch access
> b94396c lib: utils/timer: Optimize current hart scratch access
> 5c9a735 include: sbi: Support byteorder macros in assembly
> 06fc453 lib: sbi: Add SSE support for PMU events
> 09ad214 lib: sbi: Implement SBI SSE extension
> c8cdf01 lib: sbi: Add support for Supervisor Software Events extension
> 76d7e9b firmware: remove copy-base relocation
> 5186da6 platform: generic: allwinner: sun20i-d1: Remove duplicated CSR definitions
> 3b2f89e docs: writing_tests: Make docs correspond the latest changes
> f7d0050 lib: sbi: Extend sbi_trap_error() to dump state in a nested trap
> 5b11f16 lib: sbi: Pass trap context pointer to sbi_ecall_handler()
> 43d346c lib: sbi: Remove regs parameter from trap irq handling functions
> d84e7eb lib: sbi: Remove regs paramter of sbi_irqchip_process()
> f414cf9 lib: sbi: Simplify parameters of sbi_illegal_insn_handler()
> fea33a9 lib: sbi: Simplify parameters of misaligned and access fault handlers
> abea949 lib: sbi: Introduce trap context
> 60ffc15 include: sbi: Add trap_context pointer in struct sbi_scratch
> ebb697a lib: sbi: Remove sbi_trap_exit() and related code
> 2e85178 lib: sbi: Remove epc from struct sbi_trap_info
> 86224ec docs/writing_tests: Update tests paths
> 5c992a1 lib: tests: Move tests to a separate directory
> 81e3ba7 lib: sbi: call platform load/store emulators
> ddf3b64 include: sbi: add emulate_load/store handler to platform ops
> 4c11265 lib: sbi: abstract out insn decoding to unify mem fault handlers
> 9221fe5 lib: sbi: change prototype of sbi_misaligned_load/store_handler
> a17600c lib: sbi: change prototype of sbi_trap_redirect
> 2471cf2 include: sbi: rename sbi_misaligned_ldst.h to sbi_trap_ldst.h
> c0a6320 lib: sbi: rename sbi_misaligned_ldst.c to sbi_trap_ldst.c
> e11025c lib: sbi: Add initial domain context management support
> 87d8fe7 lib: tests: Add sbi_console test
> e5f53fd lib: tests: Add a test for sbi_bitmap
> 874fcef lib: Add SBIUnit testing macros and functions
> b9e4de0 docs: Add documentation about tests and SBIUnit
> 526b9ce firmware: fw_base.S: fix _reset_regs
> 8151105 firmware: fw_base.S: Remove _relocate_lottery
> 187397f firmware: fw_dynamic.S: Remove _bad_dynamic_info
> b27b7c6 firmware: fw_base: Simplified setup trap handler
> fdf5589 firmware: fw_base.S: Simplify address get
> 748bef1 lib: sbi_misaligned_ldst: Add handling of C.LHU/C.LH and C.SH
> bc36678 platform: andes: Drop andes_pmu_setup()
> 6bb6b61 lib: sbi: Add support for smcsrind and smcdeleg
> 322b598 lib: sbi_hsm: Restor hart state to stop when fails to start
> 96a35db docs/firmware: document new options for jump and payload firmwares
> 2cff7f3 platform: Apply relocatable address
> f056939 firmware: Add relocatable FW_PAYLOAD_FDT_ADDR
> 7227cdd firmware: Add relocatable FW_JUMP_ADDR and FW_JUMP_FDT_ADDR
> 741e941 platform: starfive: call starfive_jh7110_inst_init() in pm_reset_init()
> 3edf044 platform: starfive: return error if needed devices are not present
> 80ae046 platform: starfive: rename "stf,axp15060-regulator" -> "x-powers,axp15060"
> 5335340 platform: starfive: remove redundant compatibility check in pmic_ops
> 4d8569d platform: starfive: get I2C offset address from clocks property
> 034af1f platform: starfive: correct system clock device tree node
> 88273fe lib: sbi_pmu: Before using we should ensure PMU init done
> 46c8c65 docs: move documentation of system suspend test.
> 8df836d platform: generic: Parse system suspend test from config node.
> 23e7e48 docs: Add OpenSBI DT configuration guide.
> 67ce5a7 platform: generic: Add support for specify coldboot harts in DT
> 9c8b18e firmware: fw_base.S: remove _runtime_offset
> 4c6b7cb firmware: fw_base.S: Improve loading u32
> 92e8aff firmware: always create dynsym section
> d1dad07 Makefile: check for --exclude-libs
> 4a76f79 Makefile: don't pass -mstrict-align if not supported
> 21caaa3 fw_base.S: Fix comment errors
> 1ec353d lib: sbi: Use mask to check the free bit during trigger allocation
> bb90a9e lib: sbi: Print number of debug triggers found
> 76a2a15 lib: sbi: Implement SBI debug trigger extension
> fa87ec9 include: sbi: Add SBI debug trigger extension related defines
> 97f234f lib: sbi: Introduce the SBI debug triggers extension support
> 40dac6b lib: sbi: Detect support of debug triggers
> 2499769 include: sbi: Introduce debug trigger register encodings
> 20ca19a include: sbi: Add TINFO debug trigger CSR
> b752099 include: sbi: Introduce common endianess conversion macro
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 267416 -> 268312 bytes
>   .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 270808 -> 272504 bytes
>   roms/opensbi                                  |   2 +-
>   3 files changed, 1 insertion(+), 1 deletion(-)

While OpenSBI v1.5 compiled from source allows to poweroff U-Boot 
qemu-riscv64_smode_defconfig, poweroff fails with the binary provided by 
this patch.

For details see
https://gitlab.com/qemu-project/qemu/-/issues/2467

Best regards

Heinrich

