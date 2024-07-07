Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8AFC3DA41
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIb-0000mG-DI; Sun, 07 Jul 2024 15:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIZ-0000lk-TM
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:47 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIX-00058U-Qt
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70af4868d3dso1891750b3a.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379504; x=1720984304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdfibBhkqHXEKbib4pcHbTKhIdldRjkJogYjN56GcWY=;
 b=XAnxL1SvmikR97i30YxhBIrddo5UTAL4g35WfQXRx70ABNTKCFZ9shh589PBLgQqMy
 tw99VPgcRB/2rT8uXreRsOg+lvl+G7YJa9GrLILw52lPWjdTm2slcx88LmFAl50WxlBt
 2iRSBt2R3vsp7ZsbI/GvRceZyzN1NazdSOJxqqLUNLJL8Nh4yFPb5GEpTxS5x6DuSerJ
 V3ipW1XBGivl9f5pE4GiHNFMzhm3Gy6bmXwWPiOVV94+H+JVJkTpO6XTv5zCiycOUamQ
 b0cMs0wQhlB0IrUUBlNH2af0nxweUmYKIjdzvj+XGCJ0cDDyVQkTczayWYn945cKDL3W
 QzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379504; x=1720984304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdfibBhkqHXEKbib4pcHbTKhIdldRjkJogYjN56GcWY=;
 b=ho/MElxQY3LBh5uQdoTlWGhYLsNOZOSEZOcj4dsszSzP58F0ZaOfVo1EomMpgtnxu3
 6mKFERaiswtZmFVPbk56ao9Di1p0cg8WfFR0MhR82jpo1lwPcnWZ5J5AMPbDPxfYLDUl
 MZOsBfhdTNPR+MqZqFUmwXaEHYTjAsrJlvpdUvWSYJ2XmdAffEExA6ivf2CCGaOWqcsY
 ZoeZnvcb/0xGXIPQnQfTre5TxuDKwKU/WWGmZlmxwNGzBivQQ8VI1gWARwiT1Rqspzfd
 humZqalUTDGZpKxpHfCxPRvYXIn269om/sda9WDnMeFgRaqf7ETtYBCJ4no9HAhCuDrB
 InNA==
X-Gm-Message-State: AOJu0YzdwMy3rU2ru72zDQDsDGEL3U3KEEGWx3HbVli0vAw7Yb2LT+OH
 V75zsjJLIuRTgs4hiakeMKr/oVWxpqoFOvnUwOY7cDCibNHcmXdxWiaLkmxq
X-Google-Smtp-Source: AGHT+IG9XO/cmUFWaaJV3EhQYvwN8ccQZWh2EK5qhP5BPrlpkwM322B7DVQ0BluScwS3DwpBea0vqg==
X-Received: by 2002:a05:6a20:d49b:b0:1c0:f33e:aae3 with SMTP id
 adf61e73a8af0-1c0f33eb034mr660380637.59.1720379503855; 
 Sun, 07 Jul 2024 12:11:43 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:43 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/8] bsd-user:Add ARM AArch64 support and capabilities
Date: Mon,  8 Jul 2024 00:41:23 +0530
Message-Id: <20240707191128.10509-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x435.google.com
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

From: Warner Losh <imp@bsdimp.com>

Added function to access rval2 by accessing the x1 register.
Defined ARM AArch64 ELF parameters including mmap and dynamic load addresses.
Introduced extensive hardware capability definitions and macros for retrieving hardware capability (hwcap) flags.
Implemented function to retrieve ARM AArch64 hardware capabilities using the `GET_FEATURE_ID` macro.
Added function to retrieve extended ARM AArch64 hardware capability flags.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h     | 165 +++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_vmparam.h |   6 +
 2 files changed, 171 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_elf.h

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
new file mode 100644
index 0000000000..7202cd8334
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -0,0 +1,165 @@
+/*
+ * ARM AArch64 ELF definitions for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_ELF_H
+#define TARGET_ARCH_ELF_H
+
+#include "target/arm/cpu-features.h"
+
+#define ELF_START_MMAP 0x80000000
+#define ELF_ET_DYN_LOAD_ADDR    0x100000
+
+#define elf_check_arch(x) ((x) == EM_AARCH64)
+
+#define ELF_CLASS       ELFCLASS64
+#define ELF_DATA        ELFDATA2LSB
+#define ELF_ARCH        EM_AARCH64
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE       4096
+
+enum {
+    ARM_HWCAP_A64_FP            = 1 << 0,
+    ARM_HWCAP_A64_ASIMD         = 1 << 1,
+    ARM_HWCAP_A64_EVTSTRM       = 1 << 2,
+    ARM_HWCAP_A64_AES           = 1 << 3,
+    ARM_HWCAP_A64_PMULL         = 1 << 4,
+    ARM_HWCAP_A64_SHA1          = 1 << 5,
+    ARM_HWCAP_A64_SHA2          = 1 << 6,
+    ARM_HWCAP_A64_CRC32         = 1 << 7,
+    ARM_HWCAP_A64_ATOMICS       = 1 << 8,
+    ARM_HWCAP_A64_FPHP          = 1 << 9,
+    ARM_HWCAP_A64_ASIMDHP       = 1 << 10,
+    ARM_HWCAP_A64_CPUID         = 1 << 11,
+    ARM_HWCAP_A64_ASIMDRDM      = 1 << 12,
+    ARM_HWCAP_A64_JSCVT         = 1 << 13,
+    ARM_HWCAP_A64_FCMA          = 1 << 14,
+    ARM_HWCAP_A64_LRCPC         = 1 << 15,
+    ARM_HWCAP_A64_DCPOP         = 1 << 16,
+    ARM_HWCAP_A64_SHA3          = 1 << 17,
+    ARM_HWCAP_A64_SM3           = 1 << 18,
+    ARM_HWCAP_A64_SM4           = 1 << 19,
+    ARM_HWCAP_A64_ASIMDDP       = 1 << 20,
+    ARM_HWCAP_A64_SHA512        = 1 << 21,
+    ARM_HWCAP_A64_SVE           = 1 << 22,
+    ARM_HWCAP_A64_ASIMDFHM      = 1 << 23,
+    ARM_HWCAP_A64_DIT           = 1 << 24,
+    ARM_HWCAP_A64_USCAT         = 1 << 25,
+    ARM_HWCAP_A64_ILRCPC        = 1 << 26,
+    ARM_HWCAP_A64_FLAGM         = 1 << 27,
+    ARM_HWCAP_A64_SSBS          = 1 << 28,
+    ARM_HWCAP_A64_SB            = 1 << 29,
+    ARM_HWCAP_A64_PACA          = 1 << 30,
+    ARM_HWCAP_A64_PACG          = 1UL << 31,
+
+    ARM_HWCAP2_A64_DCPODP       = 1 << 0,
+    ARM_HWCAP2_A64_SVE2         = 1 << 1,
+    ARM_HWCAP2_A64_SVEAES       = 1 << 2,
+    ARM_HWCAP2_A64_SVEPMULL     = 1 << 3,
+    ARM_HWCAP2_A64_SVEBITPERM   = 1 << 4,
+    ARM_HWCAP2_A64_SVESHA3      = 1 << 5,
+    ARM_HWCAP2_A64_SVESM4       = 1 << 6,
+    ARM_HWCAP2_A64_FLAGM2       = 1 << 7,
+    ARM_HWCAP2_A64_FRINT        = 1 << 8,
+    ARM_HWCAP2_A64_SVEI8MM      = 1 << 9,
+    ARM_HWCAP2_A64_SVEF32MM     = 1 << 10,
+    ARM_HWCAP2_A64_SVEF64MM     = 1 << 11,
+    ARM_HWCAP2_A64_SVEBF16      = 1 << 12,
+    ARM_HWCAP2_A64_I8MM         = 1 << 13,
+    ARM_HWCAP2_A64_BF16         = 1 << 14,
+    ARM_HWCAP2_A64_DGH          = 1 << 15,
+    ARM_HWCAP2_A64_RNG          = 1 << 16,
+    ARM_HWCAP2_A64_BTI          = 1 << 17,
+    ARM_HWCAP2_A64_MTE          = 1 << 18,
+};
+
+#define ELF_HWCAP   get_elf_hwcap()
+#define ELF_HWCAP2  get_elf_hwcap2()
+
+#define GET_FEATURE_ID(feat, hwcap) \
+    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
+
+static uint32_t get_elf_hwcap(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    hwcaps |= ARM_HWCAP_A64_FP;
+    hwcaps |= ARM_HWCAP_A64_ASIMD;
+    hwcaps |= ARM_HWCAP_A64_CPUID;
+
+    /* probe for the extra features */
+
+    GET_FEATURE_ID(aa64_aes, ARM_HWCAP_A64_AES);
+    GET_FEATURE_ID(aa64_pmull, ARM_HWCAP_A64_PMULL);
+    GET_FEATURE_ID(aa64_sha1, ARM_HWCAP_A64_SHA1);
+    GET_FEATURE_ID(aa64_sha256, ARM_HWCAP_A64_SHA2);
+    GET_FEATURE_ID(aa64_sha512, ARM_HWCAP_A64_SHA512);
+    GET_FEATURE_ID(aa64_crc32, ARM_HWCAP_A64_CRC32);
+    GET_FEATURE_ID(aa64_sha3, ARM_HWCAP_A64_SHA3);
+    GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
+    GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
+    GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
+    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
+    GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
+    GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
+    GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
+    GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
+    GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
+    GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
+    GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
+    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
+    GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
+    GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+
+    return hwcaps;
+}
+
+static uint32_t get_elf_hwcap2(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
+    GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
+    GET_FEATURE_ID(aa64_sve2_aes, ARM_HWCAP2_A64_SVEAES);
+    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
+    GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
+    GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
+    GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
+    GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
+    GET_FEATURE_ID(aa64_sve_i8mm, ARM_HWCAP2_A64_SVEI8MM);
+    GET_FEATURE_ID(aa64_sve_f32mm, ARM_HWCAP2_A64_SVEF32MM);
+    GET_FEATURE_ID(aa64_sve_f64mm, ARM_HWCAP2_A64_SVEF64MM);
+    GET_FEATURE_ID(aa64_sve_bf16, ARM_HWCAP2_A64_SVEBF16);
+    GET_FEATURE_ID(aa64_i8mm, ARM_HWCAP2_A64_I8MM);
+    GET_FEATURE_ID(aa64_bf16, ARM_HWCAP2_A64_BF16);
+    GET_FEATURE_ID(aa64_rndr, ARM_HWCAP2_A64_RNG);
+    GET_FEATURE_ID(aa64_bti, ARM_HWCAP2_A64_BTI);
+    GET_FEATURE_ID(aa64_mte, ARM_HWCAP2_A64_MTE);
+
+    return hwcaps;
+}
+
+#undef GET_FEATURE_ID
+
+#endif /* TARGET_ARCH_ELF_H */
diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64/target_arch_vmparam.h
index dc66e1289b..0c35491970 100644
--- a/bsd-user/aarch64/target_arch_vmparam.h
+++ b/bsd-user/aarch64/target_arch_vmparam.h
@@ -65,4 +65,10 @@ static inline void set_second_rval(CPUARMState *state, abi_ulong retval2)
 {
     state->xregs[1] = retval2; /* XXX not really used on 64-bit arch */
 }
+
+static inline abi_ulong get_second_rval(CPUARMState *state)
+{
+    return state->xregs[1];
+}
+
 #endif /* TARGET_ARCH_VMPARAM_H */
-- 
2.34.1


