Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82346C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwPN-0004wQ-5v; Tue, 25 Mar 2025 01:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO8-00040b-PU
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO6-0005xO-Td
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so10053161a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878781; x=1743483581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ozZ2STeyLcJfOi2HO38PmZ1SSe1ZJ6WASMV/GdeD4Q=;
 b=tnoQKmzowy9/RMRutjRfPJeuEE7hjZRcMsjLFO6pSze00QCwylUT8mh/RZY1vLGILl
 Gbja6IjZyF3BZLvihOSyrRRktMGGmJp7BAjL/emWCzy6lAV4Df9qhrRWM9bX1yTjdTxV
 0iT3gPdRXroaO9CmTutIA4vuHoB10G0IoNY2I655afuT0FGHSHwp/5ef5DaWrsRAvtnn
 eIWDBVPPJe7nsp/pn7gWcdUE3zWFdz+VAKR7uDrYGOK7azb8g9k0HA8W6Kwq1hcV9+Uf
 S7JTSwNrA3A2MAfX/BfCvt5s23oGRfxaib2lmnSMlt2iFGSo6UEf2RuW2PP0qbQjhUzT
 XoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878781; x=1743483581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ozZ2STeyLcJfOi2HO38PmZ1SSe1ZJ6WASMV/GdeD4Q=;
 b=DOFw4QFJgHshP/7+kx9uQePjgauB0GJGiRZPYgGhMZRHfUv6o9KkHjhJJ+T3yfapoh
 zW+W0GACNBnMnqUmERbtBsLI+1mkZ5MI4YfSOBqoY1PN5WRzcK7JfxhXxpKgKi1oqjXo
 NNhIwdxBufgrRnzf874QTGX0lO6UI7eY9f0163jScA22d3hp657ergiXLJdT6HpA0+Us
 GbaUgdG+i4pTWLAefbYCAsLUpXzunB/VGfuYXiFX5Fs/TN7Ezaww6Wvr6xFvGkjSdLZW
 1D7dt0Hra3foghbd2kqhU64sse0Y6h6XtiCo6xew9JsvXTrjAf4qyZ1CwWilTFwn9BT4
 P8pA==
X-Gm-Message-State: AOJu0YzbGnZBmck8pnV+dVyXjZ+MjKyOtbMGO/YKIAX0oZZ/Z2HC39Ks
 hYEXLp+uiRT+NqrySUIGGeGK0c93Yf3ncG1lzYeVFxtB9dLwbj+qasqUprpo4wK+4QG0sEL/jTN
 D
X-Gm-Gg: ASbGnctxTDBu1wl+KuYLNdY92Tt5IX6ZNm/ZRjzS0n0VFmikxzr/16n8jlfBjrhPEZ4
 wT/qPFFuqCCrIS6g4SNk3wIzyO0Oa4HpSKmcJl3G/LqV35kQxFy4lW/Z4i1iDCTZTS9QYNCNfor
 PRntO2NghY6lvm2XOhpTYL4ZZQYmFoEVTZkoVikRbWVj7qPlnbvGyvwI8QfFoILIq4UoZIl5rqU
 3bsulrbscN9xWjb2GCBUGz07tVscg8o0vb91q3eyQGsBr6YgtT3O1nhguPEpIPxJw2N+0WqoxZL
 p6xnzkO2GSKFCQUBctZ4hfRVZU6rbBMBfIUcDEI/tZKp
X-Google-Smtp-Source: AGHT+IHRwvpXbBUqHAAs7tN3i6H3y1jGNgFgo6lUQwfrkalBcwvw/NCyZ/ABEfCgTBwu3o/ipwe1GQ==
X-Received: by 2002:a17:90b:2551:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-3030fe595c0mr27540468a91.7.1742878781525; 
 Mon, 24 Mar 2025 21:59:41 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 21/29] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
Date: Mon, 24 Mar 2025 21:59:06 -0700
Message-Id: <20250325045915.994760-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

To eliminate TARGET_AARCH64, we need to make various definitions common
between 32 and 64 bit Arm targets.
Added registers are used only by aarch64 code, and the only impact is on
the size of CPUARMState, and added zarray
(ARMVectorReg zarray[ARM_MAX_VQ * 16]) member (+64KB)

It could be eventually possible to allocate this array only for aarch64
emulation, but I'm not sure it's worth the hassle to save a few KB per
vcpu. Running qemu-system takes already several hundreds of MB of
(resident) memory, and qemu-user takes dozens of MB of (resident) memory
anyway.

As part of this, we define ARM_MAX_VQ once for aarch32 and aarch64,
which will affect zregs field for aarch32.
This field is used for MVE and SVE implementations. MVE implementation
is clipping index value to 0 or 1 for zregs[*].d[],
so we should not touch the rest of data in this case anyway.

This change is safe regarding migration, because aarch64 registers still
have the same size, and for aarch32, only zregs is modified.
Migration code explicitly specify a size of 2 for env.vfp.zregs[0].d,
VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2). So extending
the storage size has no impact.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cc975175c61..b1c3e463267 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -169,17 +169,12 @@ typedef struct ARMGenericTimer {
  * Align the data for use with TCG host vector operations.
  */
 
-#ifdef TARGET_AARCH64
-# define ARM_MAX_VQ    16
-#else
-# define ARM_MAX_VQ    1
-#endif
+#define ARM_MAX_VQ    16
 
 typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
-#ifdef TARGET_AARCH64
 /* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
     uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
@@ -189,7 +184,6 @@ typedef struct ARMPredicateReg {
 typedef struct ARMPACKey {
     uint64_t lo, hi;
 } ARMPACKey;
-#endif
 
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
@@ -660,13 +654,11 @@ typedef struct CPUArchState {
     struct {
         ARMVectorReg zregs[32];
 
-#ifdef TARGET_AARCH64
         /* Store FFR as pregs[16] to make it easier to treat as any other.  */
 #define FFR_PRED_NUM 16
         ARMPredicateReg pregs[17];
         /* Scratch space for aa64 sve predicate temporary.  */
         ARMPredicateReg preg_tmp;
-#endif
 
         /* We store these fpcsr fields separately for convenience.  */
         uint32_t qc[4] QEMU_ALIGNED(16);
@@ -711,7 +703,6 @@ typedef struct CPUArchState {
         uint32_t cregs[16];
     } iwmmxt;
 
-#ifdef TARGET_AARCH64
     struct {
         ARMPACKey apia;
         ARMPACKey apib;
@@ -743,7 +734,6 @@ typedef struct CPUArchState {
      * to keep the offsets into the rest of the structure smaller.
      */
     ARMVectorReg zarray[ARM_MAX_VQ * 16];
-#endif
 
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
-- 
2.39.5


