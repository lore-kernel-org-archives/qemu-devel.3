Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDBD1D477
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlB-0000op-A7; Thu, 08 Jan 2026 10:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl7-0000mP-0h
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:09 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl2-0003HN-Hv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:07 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so2343367b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885423; x=1768490223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2TvGLUiQmS6w2bEPRWD0JAGFqr/HoBLP/tFQJIaudY=;
 b=IDFL1usjbr7D0Mb/NN79Lp4h2t2JBI1Ih2QetOqpl/JR/nwvF7LxZiIKLx6FY048xj
 1OD9yPn+uhRA5+cLMRkOxd7cQgeT6ytMZCcm6t2QIBDhy87ULNCASu2zB4aZ5yYI8Pmg
 hBI+UwsGGsOEFtFwroyLBA+IBX5Y+ICFNGC7vjz35KkUEk6eetIPbj3e4XkX/vb047nd
 P7yQ513L280mixcdlWudzwpuKhfIwgQN2AW1DrMUGIZ4WNvYWFS6VFW37jNsEVmgjYuC
 x8BHJpTyP4ITm/Hq8gK2tPGMT3GGY0yMDGi49FOlvhIXyxolif4HSPEzv/N2s9rM3I8Z
 HUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885423; x=1768490223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O2TvGLUiQmS6w2bEPRWD0JAGFqr/HoBLP/tFQJIaudY=;
 b=QQKi+wVF1yC9k9WX1BlmHV5OhNGoB0CbbOs1MS4/8M5Nv95E8DhI42ixT1H05vk2Fo
 7CT7WsPJxJG/4FIiqBpjFA9gVXIySdnbdXhP7kEF5vWnMvcqnKVMfprGJlXNZ+qAzwq3
 382bBhf/HitNoy/urZkRjnbo/UP9acA/wNDutnPsgPgKQ1txLn2DJeZWzffzt0Dr6coR
 SqxTNiN4ULpay4Cirp1KQpCebXk57Dl/oFpKQD3thkROD1QkWdQ5AIMIGjoCLzdLpat3
 cJTVQHfIQcrkQOJeKy8D+pez9S68ft98Z++7pGoEFRh4hzPUtAjEN1J6eAbb8+V52nFV
 YwTg==
X-Gm-Message-State: AOJu0YxgpmJ86b9MppaAVHs3JnQ0bZHHOt40mid+65p3rOlB+UgGXVDk
 YkjJW3QD4/V/UbTH1+9AXN4z6nKHYjjmg/hyxRVLxDFK09EmKc8aHbtN+Ov66mwqXKc6JmTOVJs
 R6Ph+givOEDzDhOa6rGT8cpCxg6kdss7CjjwpX5BNcVUpJKWRJxxM76y0XhOUSY9g7G5d97c65a
 Gsptbk5i/Woh8gf0swp1iLtHpCkfF2EwhdegS0YYM=
X-Gm-Gg: AY/fxX7OP/K2DHClncjZDLBRWbN/iEpzwzUjKg6FRit0j/vnOe3gFk1IGRZFqpJ9zCW
 ocLL198S8XlLmM3dJrYrr9p6XvD4gnrv4n4giM/6yZ+jm41X0umzCH73wDtIJ8mS6fCVnmIWTYh
 h45dwi0L4cNO8THkigei6/1aooasA1AQks+16Evmf67P60F70mAxNGHEQc8gWZ/TpdgDUau7DdR
 5kHs4gMCFzEEQslhnfPMsyKTBhaw52joSRw4ce+yxOIJLrBi12XIGsnlAGKNJFObdsVsbQIXTfU
 77uFbHIBgURD/nNtbck01RYCmk9/henl6edDJx9fnQ7M/a//Ajh2+5ki+uxmKbkaQV8Wg+/qTBr
 gevEYcPEFkLCSS5ZLeSsB/rXjIaMp0APM3WYzLE4EDkhRPf20a2iKQcerI3S8odsslmv5LpaQ+U
 4jyD3yEe9sB1bkgir9Mb3FcqSPhV2Hff+7IBzxzOaF3OhOpiMszNuVW/k=
X-Google-Smtp-Source: AGHT+IGJlaYNE3Fe64+zL/cigyMVcnIVvWgNRIq1PQMdnR9tNTI/cyZOT3IlkR03unWR/RgiECptcw==
X-Received: by 2002:a05:6a00:13aa:b0:81b:c1d9:d266 with SMTP id
 d2e1a72fcca58-81bc1d9d36emr4852945b3a.62.1767885422784; 
 Thu, 08 Jan 2026 07:17:02 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:02 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 02/18] fpu/softfloat: Add OCP(Open Compute Project) OFP8 data
 type
Date: Thu,  8 Jan 2026 23:16:33 +0800
Message-ID: <20260108151650.16329-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
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

This commit provides the implementation defined behavior flags and the basic
operation support for the OCP float8 data types(E4M3 & E5M2).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-specialize.c.inc  | 57 ++++++++++++++++++++++++++-
 include/fpu/softfloat-helpers.h | 20 ++++++++++
 include/fpu/softfloat-types.h   | 23 +++++++++++
 include/fpu/softfloat.h         | 70 +++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ba4fa08b7b..3a3bcd22ae 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -226,6 +226,30 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
 
+/*----------------------------------------------------------------------------
+| Returns 1 if the OCP(Open Compute Platform) FP8 value `a' is a quiet NaN;
+| otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool float8_e4m3_is_quiet_nan(float8_e4m3 a_, float_status *status)
+{
+    return float8_e4m3_is_any_nan(a_);
+}
+
+bool float8_e5m2_is_quiet_nan(float8_e5m2 a_, float_status *status)
+{
+    if (no_signaling_nans(status) || status->ocp_fp8e5m2_no_signal_nan) {
+        return float8_e5m2_is_any_nan(a_);
+    } else {
+        uint8_t a = float8_e5m2_val(a_);
+        if (snan_bit_is_one(status)) {
+            return (((a >> 1) & 0x3F) == 0x3E) && (a & 0x1);
+        } else {
+            return ((a >> 1) & 0x3F) == 0x3F;
+        }
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -240,7 +264,6 @@ bool float16_is_quiet_nan(float16 a_, float_status *status)
         if (snan_bit_is_one(status)) {
             return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
         } else {
-
             return ((a >> 9) & 0x3F) == 0x3F;
         }
     }
@@ -265,6 +288,38 @@ bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
     }
 }
 
+/*----------------------------------------------------------------------------
+| Returns 1 if the OCP(Open Compute Platform) FP8 value `a' is a signaling NaN;
+| otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool float8_e4m3_is_signaling_nan(float8_e4m3 a_, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    } else {
+        if (snan_bit_is_one(status)) {
+            return float8_e4m3_is_any_nan(a_);
+        } else {
+            return false;
+        }
+    }
+}
+
+bool float8_e5m2_is_signaling_nan(float8_e5m2 a_, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    } else {
+        uint8_t a = float8_e5m2_val(a_);
+        if (snan_bit_is_one(status)) {
+            return ((a >> 1) & 0x3F) == 0x3F;
+        } else {
+            return (((a >> 1) & 0x3F) == 0x3E && (a & 0x1));
+        }
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a signaling
 | NaN; otherwise returns 0.
diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 90862f5cd2..4e278a3ee3 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -136,6 +136,26 @@ static inline void set_no_signaling_nans(bool val, float_status *status)
     status->no_signaling_nans = val;
 }
 
+static inline void set_ocp_fp8e5m2_no_signal_nan(bool val, float_status *status)
+{
+    status->ocp_fp8e5m2_no_signal_nan = val;
+}
+
+static inline bool get_ocp_fp8e5m2_no_signal_nan(const float_status *status)
+{
+    return status->ocp_fp8e5m2_no_signal_nan;
+}
+
+static inline void set_ocp_fp8_same_canonical_nan(bool val, float_status *status)
+{
+    status->ocp_fp8_same_canonical_nan = val;
+}
+
+static inline bool get_ocp_fp8_same_canonical_nan(const float_status *status)
+{
+    return status->ocp_fp8_same_canonical_nan;
+}
+
 static inline bool get_float_detect_tininess(const float_status *status)
 {
     return status->tininess_before_rounding;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8f82fdfc97..835dd33bf1 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -119,6 +119,18 @@ typedef struct {
  */
 typedef uint16_t bfloat16;
 
+/*
+ * Software OCP(Open Compute Project) 8-bit floating point types
+ */
+typedef uint8_t float8_e4m3;
+typedef uint8_t float8_e5m2;
+#define float8_e4m3_val(x) (x)
+#define float8_e5m2_val(x) (x)
+#define make_float8_e4m3(x) (x)
+#define make_float8_e5m2(x) (x)
+#define const_float8_e4m3(x) (x)
+#define const_float8_e5m2(x) (x)
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
@@ -410,6 +422,17 @@ typedef struct float_status {
      */
     bool snan_bit_is_one;
     bool no_signaling_nans;
+    /*
+     * When true, OCP FP8 E5M2 format does not generate signaling NaNs.
+     * RISC-V uses only quiet NaNs in its OCP FP8 implementation.
+     */
+    bool ocp_fp8e5m2_no_signal_nan;
+    /*
+     * When true, OCP FP8 formats use the same canonical NaN representation
+     * (0x7F) for all NaN outputs. RISC-V specifies a single canonical NaN
+     * for both E4M3 and E5M2.
+     */
+    bool ocp_fp8_same_canonical_nan;
     /* should overflowed results subtract re_bias to its exponent? */
     bool rebias_overflow;
     /* should underflowed results add re_bias to its exponent? */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c18ab2cb60..6f7259f9dd 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -189,6 +189,76 @@ float128 int128_to_float128(Int128, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
+/*----------------------------------------------------------------------------
+| Software OCP FP8 operations.
+*----------------------------------------------------------------------------*/
+
+bool float8_e4m3_is_quiet_nan(float8_e4m3, float_status *status);
+bool float8_e4m3_is_signaling_nan(float8_e4m3, float_status *status);
+bool float8_e5m2_is_quiet_nan(float8_e5m2, float_status *status);
+bool float8_e5m2_is_signaling_nan(float8_e5m2, float_status *status);
+
+static inline bool float8_e4m3_is_any_nan(float8_e4m3 a)
+{
+    return ((float8_e4m3_val(a) & ~0x80) == 0x7f);
+}
+
+static inline bool float8_e5m2_is_any_nan(float8_e5m2 a)
+{
+    return ((float8_e5m2_val(a) & ~0x80) > 0x7c);
+}
+
+static inline bool float8_e4m3_is_neg(float8_e4m3 a)
+{
+    return float8_e4m3_val(a) >> 7;
+}
+
+static inline bool float8_e5m2_is_neg(float8_e5m2 a)
+{
+    return float8_e5m2_val(a) >> 7;
+}
+
+static inline bool float8_e4m3_is_infinity(float8_e4m3 a)
+{
+    return false;
+}
+
+static inline bool float8_e5m2_is_infinity(float8_e5m2 a)
+{
+    return (float8_e5m2_val(a) & 0x7f) == 0x7c;
+}
+
+static inline bool float8_e4m3_is_zero(float8_e4m3 a)
+{
+    return (float8_e4m3_val(a) & 0x7f) == 0;
+}
+
+static inline bool float8_e5m2_is_zero(float8_e5m2 a)
+{
+    return (float8_e5m2_val(a) & 0x7f) == 0;
+}
+
+static inline bool float8_e4m3_is_zero_or_denormal(float8_e4m3 a)
+{
+    return (float8_e4m3_val(a) & 0x78) == 0;
+}
+
+static inline bool float8_e5m2_is_zero_or_denormal(float8_e5m2 a)
+{
+    return (float8_e5m2_val(a) & 0x7c) == 0;
+}
+
+static inline bool float8_e4m3_is_normal(float8_e4m3 a)
+{
+    uint8_t em = float8_e4m3_val(a) & 0x7f;
+    return em >= 0x8 && em <= 0x7e;
+}
+
+static inline bool float8_e5m2_is_normal(float8_e5m2 a)
+{
+    return (((float8_e5m2_val(a) >> 2) + 1) & 0x1f) >= 2;
+}
+
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
-- 
2.43.7


