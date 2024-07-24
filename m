Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A920C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk83-0000Xv-1U; Wed, 24 Jul 2024 18:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7v-0000Hg-Qq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:27 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7r-0006Va-Cc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:27 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8076cee8088so11675939f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858780; x=1722463580;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhtuF+xcgb0CJwH2BcgYevwpIoQXvHSPcnXv2TrhcGA=;
 b=GuNlVCF+1ay3krzR/8aqEWjW04J7Gb1pBnB6wgAkPsBZwghWCK7WBsW1++mConMM5n
 3oBRPM6wWzIMEO1/TtiyHzyi7c8SplfvTbRCjtonc4QhpCO4lhbEMlJf7B5E7i0lfdbO
 kdFk8cV/TmiAGJTmjYYoLoK6ezZdvVJxNeCdQpwY4DNht+/kh06Ymx71dP7L8VhwN9Hz
 mOXm9DeRk/V5LVjVtUbab35u0QSzDPm9asHqSKFColEgee0f5BxWhrWUb1B5Gp28qd5H
 5IgoUBM515DYOl+/1f8z3l/Z72+sih8LDc9OIXgYdxFwcQtbfyj/2UGZplypSpzcOp/b
 ptvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858780; x=1722463580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhtuF+xcgb0CJwH2BcgYevwpIoQXvHSPcnXv2TrhcGA=;
 b=HTOfn2uiLkN/o7MNFLc0GHzV80u622PnAbTVIU3UTdosVwtNQfcZ1t+dSPsuwAxtVb
 FGmf1s/1WSegXizo53YUe6ZpNUYZcybBgI33NjxfbaVxDOOGQ/8veNEbvcBPUtlONTmY
 a4BQdP6iX15gB3qzJDspWXXkmDxep5YmqSMdBPc0yTMmneBxvjTUnmHmh8Vw/Q6Cr8/T
 7UVHuiIpJPxqs0xZ0hbLBb0/v1RvAhBqAMOzlJEAaqp9rQlvuUZxkO6tG9K1n0G0ySTl
 7Zc51EO/8JLZzrO6lVKtCxVkXGEJwhKzejCEVJAYF0vuoFNeiE3gbD2Y41AfsMYUbyX+
 CJ7w==
X-Gm-Message-State: AOJu0YxVdFKGoDopAyS27QuXaBhylKaNdwa/dpi42LfuZA6eKxqDHG0q
 WtjV9TUoZhXsaHGfCLQ6iu9YdekENTj3Z8P6iZAMLypciscBdBrcmdCPggEIiE1hkjtUo5C8Ji/
 FYTU=
X-Google-Smtp-Source: AGHT+IE2oILQJUs2R5qbJSFS7GrHl4URE/bkrEHiXR1joTrO8F/9Ma+VAmtyxQ/ZuYUVWq3BBB1FKg==
X-Received: by 2002:a05:6602:6b0d:b0:807:82c2:5247 with SMTP id
 ca18e2360f4ac-81f7bd5c178mr148775939f.6.1721858779805; 
 Wed, 24 Jul 2024 15:06:19 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/15] bsd-user:Add ARM AArch64 support and capabilities
Date: Wed, 24 Jul 2024 16:04:36 -0600
Message-ID: <20240724220449.10398-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Message-Id: <20240707191128.10509-4-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/target_arch.h         |   1 +
 bsd-user/aarch64/target_arch_elf.h     | 163 +++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_vmparam.h |   6 +
 3 files changed, 170 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_elf.h

diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_arch.h
index 27f47de8eb3..4815a56ae3c 100644
--- a/bsd-user/aarch64/target_arch.h
+++ b/bsd-user/aarch64/target_arch.h
@@ -21,6 +21,7 @@
 #define TARGET_ARCH_H
 
 #include "qemu.h"
+#include "target/arm/cpu-features.h"
 
 void target_cpu_set_tls(CPUARMState *env, target_ulong newtls);
 target_ulong target_cpu_get_tls(CPUARMState *env);
diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
new file mode 100644
index 00000000000..cc87f475b3f
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -0,0 +1,163 @@
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
index dc66e1289b5..0c354919708 100644
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
2.45.1


