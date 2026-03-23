Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DEDEC01CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cve-0001qH-Ew; Mon, 23 Mar 2026 06:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvc-0001oo-Iv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cva-000641-Rl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fe655187so35693475e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263272; x=1774868072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6ZLqp38jEhF8gx3RD7UOd1UMhdnIBandbyq1IDDyic=;
 b=BnSZnYIoVjkERyMYb9b741bRbaa8kmk2L6frNWl6gZcqg29dbrFIsc3Ynhlg4aZCi3
 OM5svSW/2OZodu0cmFyMb1Wk+4Uj2voljkNopJVQIalpXezVcHCz6c2Rk9DxsAZEB9zi
 w7egM9OKrZAIzuJAu/vKGlfw/Eu7UCqXholUXIQA3u8nmDRN3MmIj2Fu6cmFtYERxu3X
 5qh01qO/KnjefzxTNUVSsM3CePLUjCnBdhzpMmUNOG4V+BEaTDN5BWMBLTx/hvsbxxrL
 XvE33Sq0Zm81t0HbfaDpEDQdz+eJO5eL2keQn31z05qiFRwUvYcd3IiaudvA+7zPkJhA
 h13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263272; x=1774868072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A6ZLqp38jEhF8gx3RD7UOd1UMhdnIBandbyq1IDDyic=;
 b=noGwon3dJ467SnBB/ftsIXxiVyQmbBCjGUJySJKLSh5CCIN6Dmf8mJlOnJW3JO/QEp
 nnPxDeqAVpKj89WPtJF83vnSb0lK+NQqgSwpILgCD/VVAGJsaHZCRVlUu1IB4xzOgpVH
 hROLTDpmzlT4KPmCX9T+GZ2e7/Wh3Cgel7g3AgP0buIpyKjnFSUN5WZXHwgbWL17Kpw8
 H1AVdJkyC5t9kYz7Bsj++6Q/yYcOdWJcVTODByVFQT+LYKQwyZS3NCL/lSv8fAANuwv3
 DQ4oeEpQIPY9ttLvUKEuL7Ufozc9/uapk+b5CI7sA1V17PWn70KWZxPGTQU9ZwbHDv/J
 spyA==
X-Gm-Message-State: AOJu0YzS/VM2wGJp7Y1KYXwNbAJpnoWtnfzRkMeajrJSlPrArYSVfzGG
 jwareJBMLTyw9HBiICMuUkK0JbhYjMInCOu7UAYNphG8I6fa/1KAbi95Hjacue7QWAymmTM21Rt
 m8V95TUs=
X-Gm-Gg: ATEYQzy7gB0XUE4/SJdgcoCT0k+KziUWPbgUkahvjBNJ2DHMOz3itSrzPkitEfxu5Ip
 ZUjeXLrwj29Etoj6NG76ZmVpEpBDn1CovUvahx9WUT1q70BB5AVtEeAVgmiWC8R+IkciSbNjN8x
 V83Y2iixUpJhK66fmKzhzgrF0hBMAwPErl7dg/LPJShsBDoTkYw/ybWqDJ2D3K2vFr+IQoi+U/+
 4Q8LADb2HcShu9D1ZnsVjgoVzVqrK9vY7lMAOp6veaINQt9G0yJT7Djo81+rTGRP6lPQZgJtwU0
 FFFAv6XdNRgLBb+85Q3unlkQSQpsO1Y8myOH2JGuo0+RvKNPxpHM8JrMVP9D9L8gawPaaMKGJTy
 nf5EHScsfd5+0NyZUtKCKls1ripdit3AXORzwkNu2cC9g1T8tD5EJDOZpkbVMvO+6luRSzHOqG/
 cCnHNke34nNzWczhpBBIaeBsCJbjxGEX2REUPctHMABmCd67o6bgABL3gyLZ01kHeMQE8IQWptu
 RFMIrKCKAsr+5ZuUALf5B9rOtrUECc=
X-Received: by 2002:a05:600c:8207:b0:485:3ff1:d5c3 with SMTP id
 5b1f17b1804b1-486febb449bmr158201375e9.5.1774263271976; 
 Mon, 23 Mar 2026 03:54:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] tests/qtest/arm-cpu-features: Fix thinko in
 g_strdup_printf() call
Date: Mon, 23 Mar 2026 10:54:20 +0000
Message-ID: <20260323105429.4059580-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In commit 62272f9f8891 we changed some uses of fixed char arrays
to call g_strdup_printf() instead. In one place I made a silly
error where in changing
  sprintf(name, "fmt string", ...)
to
  name = g_strdup_printf("fmt string", ...)
I forgot to delete "name" from the argument list.

Luckily Coverity spotted this (as CID 1645771) because at this
point "name" is NULL and passing g_strdup_printf() a NULL first
argument is not valid.

We didn't notice the mistake in testing or CI because this bit of
code is only run if on an AArch64 host with KVM and SVE available.

Correct the error by removing the stray function argument.

Fixes: 62272f9f8891 ("tests/qtest/arm-cpu-features: Use g_strdup_printf() instead of char arrays")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20260317111121.2062455-1-peter.maydell@linaro.org
---
 tests/qtest/arm-cpu-features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 5444e4d40b..bbdd89a81d 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -612,7 +612,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
              * we need at least one vector length enabled.
              */
             vq = __builtin_ffsll(vls);
-            name = g_strdup_printf(name, "sve%u", vq * 128);
+            name = g_strdup_printf("sve%u", vq * 128);
             error = g_strdup_printf("cannot disable %s", name);
             assert_error(qts, "host", error, "{ %s: false }", name);
             g_free(error);
-- 
2.43.0


