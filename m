Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59644EFB7FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulEB-0003ot-5c; Tue, 24 Feb 2026 00:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDz-0003ok-75
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:47 -0500
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDx-0002IS-4k
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:46 -0500
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso5017399eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911882; x=1772516682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7P4L6KRGUfnJuZGklnenZefdnYuPN4EZ2NjRTD5rCHQ=;
 b=U16My6skclzhMY8OQMMcJU53wUCgJ45X0DoqChxGCcY7L/kWiOsnZzZFjHTrzb21fA
 OvqUt5qRoZ0N9lwWhS8Okdpwwd8r64v6en2BOYbJfWCJL0XBQPjFCEQYeRCgkJctzVF2
 Rcx0Aw3acu+/X2ItuIWP0eRWLALEzF3fSyL7LXKOR3e75ZgfWKS3gRCB2cywdxKXDgk2
 PLILSGteLXx/JH0VY3/9TsoCR78S2KyoBXoCCvx4r33gUvHLeWSrRFhBNNbEOURsuMTm
 XKbccG5HV+yLCVjMqWTfEd9sytHmI9lgA2fHheHnNjgPsQI1dpnGWoNGIHhvfSCuCg1u
 kZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911882; x=1772516682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7P4L6KRGUfnJuZGklnenZefdnYuPN4EZ2NjRTD5rCHQ=;
 b=Ysb7PKeLgsK6Jo0WXKMp3zicsVPTI8T/cA38vHmfGpnRydJ5RCkMO6MmOhcXGDwiew
 oWWoc4eqPMGelBT/q4ZwakPShqfGT1CGKozjPXY51d/Ktynb9kGzn9CHZZfTz0644b4L
 boam4qPVGMO0foy4MbH/e1Uq1KEXcpySo18G9PA7zzos7xIczMnNsK/BhDu34m7Wnop4
 hu7gXMWopeBqhGTP2oQCeHg2eebNI1bgRb9jhlJm+W+IbgGIbg02DdbXmiwVarC5JKDa
 foBCeRH4OAOncBx2d3w8BgXJ+6tOJFtw8cZBnTD9YQOda4AyJgp+CwPyptuh4YJd5zKs
 teOA==
X-Gm-Message-State: AOJu0YwXjJpjC0OcIxTzsqKtMRRmKH2HBd9GvqeXMWy64WgaSqRy9jyz
 lDdfB1WECNlsmjyogjIt4a389liQQaBh31xCMwpFNbgO10EAYgxAA+jDsa4qzK6GgXhcrQuXDRI
 oGYE2qLg=
X-Gm-Gg: ATEYQzxZ9gO4lyMqmBFy+EXlEMxS9M+C2nmffFxy7wHCcCNRsRWdm3GVPvzPoAaNnm4
 YkN5F80JUeKgw7yMXmqzqctXYB0X7tAHIvO4cjjK6bDj+CcG+YTMaA7PAY2GrT8SrUEIRwghYPR
 dWP3N3FjfoUNzjvOU7zpU2oPHarr2yI5gDnSPnrPAscrB1SIzQAKDk2vL0MOoiwNVd7S8OIdd2i
 ZJH4844wqYAjLK1V3FVPffFwp2mP2LKIsGx1IAVdrV2bgrCtgOWRzviRkX/qWMdSvpglS22ctfH
 cjQj34EW+tTef8sbESB2G2IjQbUg18r+LNYuG+OhlC/Z9i0vAB0VByVE5aWocrxgGfCp2hR2qqT
 uZEPEd6Ppc4zONH02gtoycADTGHWGhs2BXm44Ttv0HFbR0HToKelaGR7cJF69D3+Pmo7ufH+At4
 PlA5B6j1+sBOafJGbN5GUBDiBLdevYlMuZsy10J3Zmx9IgV3/xDj7g
X-Received: by 2002:a05:693c:3944:b0:2ae:5e93:b69 with SMTP id
 5a478bee46e88-2bd7bd24e03mr4123931eec.29.1771911881868; 
 Mon, 23 Feb 2026 21:44:41 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:44:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 3/9] target/i386: Fix pseudo-NaN handling in
 FPATAN/FYL2XP1/FYL2X helpers
Date: Tue, 24 Feb 2026 16:44:11 +1100
Message-ID: <20260224054417.32430-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
References: <20260224054417.32430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x132b.google.com
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

From: Max Chou <max.chou@sifive.com>

According to Intel's x87 FPU specification (Table 8-10, Vol. 1), arithmetic
operations on operands in unsupported formats (including pseudo-NaNs) must
return the QNaN floating-point indefinite value.

The helper functions for FPATAN, FYL2XP1, and FYL2X incorrectly check for
signaling NaN before checking for invalid encodings. This causes pseudo-NaNs
to be treated as valid signaling NaNs and silenced, rather than being
rejected as unsupported formats.

Reorder the checks to test floatx80_invalid_encoding before
floatx80_is_signaling_nan, matching the correct behavior already
implemented in helper_fscale.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260204051756.667397-5-max.chou@sifive.com>
---
 target/i386/tcg/fpu_helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b3b23823fd..37c83ded38 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1377,16 +1377,16 @@ void helper_fpatan(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2061,16 +2061,16 @@ void helper_fyl2xp1(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2159,16 +2159,16 @@ void helper_fyl2x(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
-- 
2.43.0


