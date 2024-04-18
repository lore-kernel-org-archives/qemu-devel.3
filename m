Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54DC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTYo-0003HP-M8; Thu, 18 Apr 2024 11:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYi-0003Ez-EV
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYY-0004Tz-04
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418ee51e280so4160995e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713453606; x=1714058406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0P6oj7AmfsCZVKQvdoWgcGwUbb8SNKqdN7n9HIoro0g=;
 b=RSLtQ96jmBoS+yGnPLMIB+rQ/8V1u5mhsyatRW8/gBgOmcGuMkYHYmAZZocIyXN31+
 Qscc8IoACFc1bA6sLAhv/LK9+Zg46tBYAmIB9BnUbkO7rVjW+Im8lzWuUCHa08th1zOE
 j4+jRXQ+kliQ1ZgyniuJozzKMHGHcgzQORr/75LAHAfg1mUacPNgmdNvhG+S8EgNfpSs
 kZYVGAxLMkab85Btjaz5qSAKRlCbbdXOwtkpM0WkzEZeCo7AeADEh5Ut2I+P29jyyGC1
 Kc8Do7FxxpvaRdHlOlXEeUCNzNYyFVyCk2PaMAHa2CCyQS7Pw6OvuF88Y+Jkt+e9B3xT
 yIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713453606; x=1714058406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0P6oj7AmfsCZVKQvdoWgcGwUbb8SNKqdN7n9HIoro0g=;
 b=uK+iwrgIOLjG4W3XQeH9b6ZdrlADAenCkNoYhzmCK48eIK72EdcvKM+sHT5+F8B5fc
 6VxRao7hR5ItDlPXO+6EQhlBY8hqQ0B1wcU4y54/Aca6j+jy5p0DjPIProNOe+f9zstf
 ne+HS4TCiKRuMxcz2xMTybWiopWopWcnDAv69uB9ysnFCtyIuBfmuDFCCbpzjutTq4p1
 MS1PC2pC9f2p3Bf/YkWAfsz9YPv/lEA8sb7QT+lSTg5Pcc5IFGI/kRfFhdHXWTb6bbkP
 +rzpOu1wJ4AQXtx/38WrUBDFL2rx2TeeqGy0raPEYrFcjQV4r79kW1IkXwiQ2WC9oghs
 Sg9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHoM/ksGM86uv67rsv2MyujAFZqUXfh90q78H7Jrxl7Aq1rQ9m1jQnAPccyvq9VEHgiTxI//5wSVfou6N2sJ29Jec6qfE=
X-Gm-Message-State: AOJu0YwjjKxE6MTLFvq7TmsnVNJSCAevdk+EhKmRuWSguoLf9hxWyr9f
 ovITkKLQkWw8jUcm/tJK6rKYeMbbiEf+kbk5M5SOXFezL6yNuXounrDs/aUAuBU=
X-Google-Smtp-Source: AGHT+IE2bBMQHCz1TEs9CPCI2t5aDb0YMFFkji4nStoqzpBoQjtDA+BHItJFrHQhDaZc1jogKfi9bg==
X-Received: by 2002:a05:600c:a10:b0:418:9713:866c with SMTP id
 z16-20020a05600c0a1000b004189713866cmr1950176wmp.5.1713453606120; 
 Thu, 18 Apr 2024 08:20:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b004162d06768bsm6886839wmo.21.2024.04.18.08.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:20:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] docs/system/arm/emulation.rst: Add missing implemented
 features
Date: Thu, 18 Apr 2024 16:20:00 +0100
Message-Id: <20240418152004.2106516-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418152004.2106516-1-peter.maydell@linaro.org>
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

As of version DDI0487K.a of the Arm ARM, some architectural features
which previously didn't have official names have been named.  Add
these to the list of features which QEMU's TCG emulation supports.
Mostly these are features which we thought of as part of baseline 8.0
support.  For SVE and SVE2, the names have been brought into line
with the FEAT_* naming convention of other extensions, and some
sub-components split into separate FEAT_ items.  In a few cases (eg
FEAT_CCIDX, FEAT_DPB2) the omission from our list was just an oversight.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2a7bbb82dc4..9388c7dd553 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -8,13 +8,25 @@ Armv8 versions of the A-profile architecture. It also has support for
 the following architecture extensions:
 
 - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
+- FEAT_AA32EL0 (Support for AArch32 at EL0)
+- FEAT_AA32EL1 (Support for AArch32 at EL1)
+- FEAT_AA32EL2 (Support for AArch32 at EL2)
+- FEAT_AA32EL3 (Support for AArch32 at EL3)
 - FEAT_AA32HPD (AArch32 hierarchical permission disables)
 - FEAT_AA32I8MM (AArch32 Int8 matrix multiplication instructions)
+- FEAT_AA64EL0 (Support for AArch64 at EL0)
+- FEAT_AA64EL1 (Support for AArch64 at EL1)
+- FEAT_AA64EL2 (Support for AArch64 at EL2)
+- FEAT_AA64EL3 (Support for AArch64 at EL3)
+- FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
+- FEAT_ASID16 (16 bit ASID)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
+- FEAT_CCIDX (Extended cache index)
 - FEAT_CRC32 (CRC32 instructions)
+- FEAT_Crypto (Cryptographic Extension)
 - FEAT_CSV2 (Cache speculation variant 2)
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
@@ -23,18 +35,27 @@ the following architecture extensions:
 - FEAT_DGH (Data gathering hint)
 - FEAT_DIT (Data Independent Timing instructions)
 - FEAT_DPB (DC CVAP instruction)
+- FEAT_DPB2 (DC CVADP instruction)
+- FEAT_Debugv8p1 (Debug with VHE)
 - FEAT_Debugv8p2 (Debug changes for v8.2)
 - FEAT_Debugv8p4 (Debug changes for v8.4)
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
 - FEAT_ECV (Enhanced Counter Virtualization)
+- FEAT_EL0 (Support for execution at EL0)
+- FEAT_EL1 (Support for execution at EL1)
+- FEAT_EL2 (Support for execution at EL2)
+- FEAT_EL3 (Support for execution at EL3)
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F32MM (Single-precision Matrix Multiplication)
+- FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
+- FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -60,10 +81,13 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MixedEnd (Mixed-endian support)
+- FEAT_MixdEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
 - FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED algorithm)
@@ -75,6 +99,7 @@ the following architecture extensions:
 - FEAT_PAuth (Pointer authentication)
 - FEAT_PAuth2 (Enhancements to pointer authentication)
 - FEAT_PMULL (PMULL, PMULL2 instructions)
+- FEAT_PMUv3 (PMU extension version 3)
 - FEAT_PMUv3p1 (PMU Extensions v3.1)
 - FEAT_PMUv3p4 (PMU Extensions v3.4)
 - FEAT_PMUv3p5 (PMU Extensions v3.5)
@@ -96,8 +121,18 @@ the following architecture extensions:
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SVE (Scalable Vector Extension)
+- FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
+- FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
+- FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
+- FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
+- FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
+- FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
+- FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
+- FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
 - FEAT_TIDCP1 (EL0 use of IMPLEMENTATION DEFINED functionality)
 - FEAT_TLBIOS (TLB invalidate instructions in Outer Shareable domain)
 - FEAT_TLBIRANGE (TLB invalidate range instructions)
@@ -108,8 +143,6 @@ the following architecture extensions:
 - FEAT_VHE (Virtualization Host Extensions)
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
-- SVE (The Scalable Vector Extension)
-- SVE2 (The Scalable Vector Extension v2)
 
 For information on the specifics of these extensions, please refer
 to the `Armv8-A Arm Architecture Reference Manual
-- 
2.34.1


