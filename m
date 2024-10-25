Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE9D0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L43-0004G8-Vk; Fri, 25 Oct 2024 10:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3w-00047h-B5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3o-0007p1-Vy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so21284315e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865583; x=1730470383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dIJNAUGIBKPluHUtywmy4VA6hHxALG+WEgmCVMe7gU=;
 b=Ac1bPSncqcqgIIWgKjIeAPAATfd3+ryGVtkFPoIvtdFNAqeUlp8TmG0HEy1TXYHf3k
 jfBhHNU9PDyE4S+zqNi9cjA5FTXRve9uKqk1eB8uyQNtmWfH6KaCpWpX4ZKNVzBThRW3
 R69Pye7YYIe1wHN4tZ08CqJJPoi1ubNdQ1z9klpx/JWmy5FUHiwOfIoC+EWic63bueQd
 tvnB4LnZDeOlW6yRSjAGXu/Mu/stZqLnvSxr1QXTCKkdM9OJJgrFv7l2/uJpCzKZbTBA
 gh56Ys9eMbBKcjnDEMT3N+yRej/sDSzBEGgDkQ9fJJR6yQNcgdpfiBZIBJA/ye+4QGin
 9U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865583; x=1730470383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dIJNAUGIBKPluHUtywmy4VA6hHxALG+WEgmCVMe7gU=;
 b=lhHEsI/MXx0GpPW8Z4hRrwdLTVZWemEyFxXK/fWZ+CNdSWJnN6DqPEfmZhzhrS5qqU
 MLxgMJALRMoOGnhujtsjE5MOIsFndXa8bYZsm2ABPSyiFlaDdi8jtqR3zYRDylm9Iky5
 jADf3R4I/enGe3NrrV+NUDrRjjmWQIIyvHQ3xTItOxTj8yn+kntxI6bR3+v0Kzq2MlTf
 NzCqq/kHR63uzTV7vF5slMemAeeDSyx+vJ2JR1vIq1RGzc2RKxctMi44PI2yks92FU2l
 pTHGpga8RYxAnT8gM8dAR2Th4l29Y0FRz2NwOXh4TlUBLNy7N8yvx869HwUkyXjcZLQ0
 gxNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4r7SfarZE4nnZYvKSXEGAj/gsAXniy61sRwRDYc+psoAbiY+6qp3kUdhYqRnswvmVt4MDCyvfs9in@nongnu.org
X-Gm-Message-State: AOJu0Yx9DPZ2YF5gYxmGAzYnqtpd2BWk3MtBmVw60iKXL/qa6eZZr8cd
 s7rURsAe9uY1SxpABiFzqX54z7mwcUdrO+gSAlanuzEIhJ8W3XeemqInmMpWcBA=
X-Google-Smtp-Source: AGHT+IFcA8oxoQEOawvv97SeiVR3If+e/2yvc0iinLIy6uEef3JELIn/jzXfhO2X0gtQUx9yM0jyIw==
X-Received: by 2002:a05:600c:4694:b0:431:5f55:28ad with SMTP id
 5b1f17b1804b1-43191349709mr34138735e9.22.1729865583374; 
 Fri, 25 Oct 2024 07:13:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 08/21] target/ppc: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:41 +0100
Message-Id: <20241025141254.2141506-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
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

Set the 2-NaN propagation rule explicitly in env->fp_status
and env->vec_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As an aside, it looks a bit suspicious that we set
tininess_before_rounding on fp_status but not vec_status...
---
 target/ppc/cpu_init.c          |  8 ++++++++
 fpu/softfloat-specialize.c.inc | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9f..5c9dcd1f857 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7326,6 +7326,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->fp_status);
+    /*
+     * PowerPC propagation rules:
+     *  1. A if it sNaN or qNaN
+     *  2. B if it sNaN or qNaN
+     * A signaling NaN is always silenced before returning it.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
+    set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index a0c740e544d..8e3124c11a6 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -404,15 +404,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X)
+    || defined(TARGET_S390X) || defined(TARGET_PPC)
         g_assert_not_reached();
-#elif defined(TARGET_PPC) || defined(TARGET_M68K)
-        /*
-         * PowerPC propagation rules:
-         *  1. A if it sNaN or qNaN
-         *  2. B if it sNaN or qNaN
-         * A signaling NaN is always silenced before returning it.
-         */
+#elif defined(TARGET_M68K)
         /*
          * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
          * 3.4 FLOATING-POINT INSTRUCTION DETAILS
-- 
2.34.1


