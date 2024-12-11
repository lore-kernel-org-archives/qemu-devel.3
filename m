Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0E9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRo-0000AT-Ps; Wed, 11 Dec 2024 11:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRn-00009l-9Q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRl-0007eM-Np
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso6093395e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934020; x=1734538820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p5mifZl5EPC5sQJMN5FD/oN3NC4zCFa51s7YMRd5p/0=;
 b=pxRzqmf8lqIaNb4l0lnSJAM9rbVMDzjPinbxy+LwjZPtuS2asErk/AeX/5enfCgPuJ
 bWRLties6+24yrQBLL/oeF8LkDqxmiVhexoatSxy1WCkcVMG2Auw0qc+ts8Oulzfw9Ka
 DXLzQlPD2B+7Wkge9PJWn25fWxzDvK30je0WXsIJtjO50KOz84TJEOXjxW51nNBflMQj
 KqtYQcC+K7wMgwO2HEJv1Xm+DoFJFOTVJmZj0Ai8l1KdtbaKtlfRX4nxVOm1DrbzEW6y
 yIb0mjqX+bxYfh3B07+8zzr0Gbe6sHFJWECPmpgwSSEuM2mCb4pQytp3u4ByjKoP9PIN
 onGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934020; x=1734538820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5mifZl5EPC5sQJMN5FD/oN3NC4zCFa51s7YMRd5p/0=;
 b=SeY/n/lNQunNjeALOhwOGCsYPPtpKUGSQ/VEEIlR1aYt56zma1Tjt2L/VEh6aMUzvA
 PABX6EYOUxpLRmAUgo//Hioo5hCa8SVdF2BHQFvNWm7RK+xbnX/gyaCoWIQj4TQIPKQw
 y8KAgMvJ+gts7HzDJQVV3lOtiiiB7QvxPAJttm/59dIopfAP/pePiqNa9yMkYNF5ZWly
 eGFDGgKWPsMAbGXkLCB+ufIQq9ebdlQe8jbQVYOaD+w+Abiz/Q4P3I40elcOIOLahG58
 z1xwzu0+lHAp2ft7pK7KcSFLO2Oei0azHalbfbodQeW3ZmfrkrvqodCk5517L99NuYKt
 lboQ==
X-Gm-Message-State: AOJu0Yw44mF4QPcO3+lzw1s/tFVUHwBR4V9izW88tI2FBteoJW8EcAHI
 5ObYK8MBPP0sb/hILkdYGxL0urfIXPaK0tCKeKgdw5j3/EoHjvbFb9uGZ4/LWOuRJQST98DnBze
 o
X-Gm-Gg: ASbGncsJ8yoWUHdp8/Vlo0ZgbOv4ulSKmUuQMvKLD2bKT/AjTMKj1MzX4ovPEV4Ez+K
 0NvulVWOWOnSXzgGBOEYyuiWugU8REsVDxp4i35wbRvbYVnIve3F3UuC2smPpTYng4e3ZEKAnRB
 61A7e5CIL7Le0lDa3ek6TYci4WdRY3nBYKXcmj4tujJv4Vmb5oBYYtccw/jKNCySS49BO57EP9h
 nYPwYVa0808lWrHLUjshOe9o01dvnXEnFphrNJYztKrqKbj8eaEYimiQGer
X-Google-Smtp-Source: AGHT+IG2x20y7IXHmYEDNXAUQ/i6F9ZDryZ1wi9fmNj+GVdERx/d2pZKGGasNMcYkAc8fhcif99mig==
X-Received: by 2002:a05:600c:c89:b0:434:f5c0:3296 with SMTP id
 5b1f17b1804b1-4361c3a35f8mr28252145e9.18.1733934020139; 
 Wed, 11 Dec 2024 08:20:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/72] tests/fp: Explicitly set inf-zero-nan rule
Date: Wed, 11 Dec 2024 16:19:01 +0000
Message-Id: <20241211162004.2795499-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Explicitly set a rule in the softfloat tests for the inf-zero-nan
muladd special case.  In meson.build we put -DTARGET_ARM in fpcflags,
and so we should select here the Arm rule of
float_infzeronan_dnan_if_qnan.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241202131347.498124-5-peter.maydell@linaro.org
---
 tests/fp/fp-bench.c | 5 +++++
 tests/fp/fp-test.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 75c07d5d1f1..fde64836194 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -488,7 +488,12 @@ static void run_bench(void)
 {
     bench_func_t f;
 
+    /*
+     * These implementation-defined choices for various things IEEE
+     * doesn't specify match those used by the Arm architecture.
+     */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &soft_status);
 
     f = bench_funcs[operation][precision];
     g_assert(f);
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 5f6f25c8821..251c278ede9 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -935,7 +935,12 @@ void run_test(void)
 {
     unsigned int i;
 
+    /*
+     * These implementation-defined choices for various things IEEE
+     * doesn't specify match those used by the Arm architecture.
+     */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &qsf);
 
     genCases_setLevel(test_level);
     verCases_maxErrorCount = n_max_errors;
-- 
2.34.1


