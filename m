Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913E606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PMjHnsta
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsVp-00068l-5o; Sun, 25 Oct 2026 03:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVn-00068Y-7J
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVl-0003es-KZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e47347279so250878f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912760; x=1793517560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+SBzxUCmVpcsYxNsqp6mWn/1VHORZtSi6ioX+mIMbbQ=;
 b=PMjHnstaK4L2YR4bzCbEKQdUncOe6T6c5In3z3WC2+irx62n+gXWOyHez2Y3LkjzQQ
 i4z8UZYWtZZvdIBe9T6KEnBsYG4Ha8BV8cFSNvWGBcMQfkjGzcRJN3XAiRc5MvV3r+dB
 6oQsz65z6fkYD5jAOLk3d22e7lLY/aQ2DhbmXqH477cT2Z8SWRSaXiGPl1+jnHFkXjB9
 PL65mK11+iZ7qTruPGrhc1YRZPZ7I2X7/NES4lANjLHGxBpe222LFyveoQWHOFjjzXtC
 vASpwOIDOj0hG1soF8zQrmmluMix7KTOoquAlvqeZIo+zfzVH2GgZEboEjO2fHgD7HCd
 heEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912760; x=1793517560;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+SBzxUCmVpcsYxNsqp6mWn/1VHORZtSi6ioX+mIMbbQ=;
 b=1gjYnUvO5QGs3Bq7ZZ2STlKbBLJzey1zLoh2qBQHelOpaPixMDymz4QOQKGBV35V0u
 40hf18FKGiO180fPGyt2fR/Jih6r/7kBXgr9dJaA8cQtGzTG47hQYR9ENw67BISRAUhi
 yfjr0xWTrJXAjGupSTmh9XKySqwGNVEovH9QVxCiCubEGDgfbMtj5O3m0XJ3juZnyEvF
 DSZrWrqDqAgnESkUR//QTi5lP1/syqwDIJVypZZ2n8iOCERSd51Jks5rkriY+xQMBH7M
 2kbdVzyLhGkms2NHjO7YhILVqHSaX8HvwxdnAvIZYdAUiks6DWtR/G5vN0N9/pSYS6qk
 qyMw==
X-Gm-Message-State: AFq9FYIJvotuMGPoisyl9wEklidcKLKcRoq5UJ+0mb56Zj+BqZj4X/BR
 TApo6T7CNF/ipqnQ9KSb6KWpESfs0LoBpm+ZSVhZthM3lJu/0ekpwXr8yv8y5aZ1cOiUa6QoUib
 yF772gHY=
X-Gm-Gg: AYBFou1mAjNj1N5RIJ8117QUiAePrYB9ceTr+RSOVi49cQqyEs0DVgcrHLkBqcyGJAh
 LWnhH0g1Ld7CYAyGR72yhrw0FtKXz0YtLC3V5MmZ+7mc6s3atMCbxB/FInmXYyInq+qJp1cJ8RR
 CzWyEbDmI8/Ffu/LQtZ7M5qq6UVJNZnnJQAUwPSx0hC1wzi8fd+OaNd6xhCyOFOEtNajUcZ1waY
 nQevTpWZBQEs27I555I50A5nkPLuIJfhYJqkMB2JshveYlSlkDfiZS1YTluWOiOZuT96NSxDTWy
 BXT8g2NS2tvNDHH7DPgUyxzkOSknQEEPc8g6kpD+mf9XT3YY+N5hFRu4Me37fx70nZjBINYKilW
 XoOxAehwMSBupM4fhcbN4MTMyvc8NcccZ+ML3CXjYbtMoPCVI2IuBUQmX+RdjskWNDeX0lIj9Dm
 NbXeB1ZHZyhEMOrdzp4DjjUuH/pRoOUPLwFDs0BA0a4L7u1hAI+XKgzl8OiBW7/nWMWYRmlyYfA
 QA05sigEU6RE3nIL3R/C8RVfXRDUq+rFoBixtHcv3H9lpNQ6vzLI4TYixs=
X-Received: by 2002:a05:6000:2312:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e3eb8b4c5mr6056206f8f.22.1792912760160; 
 Sun, 25 Oct 2026 00:19:20 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 001/100] include/qemu/compiler: Add QEMU_*_NONNULL attributes
Date: Sun, 25 Oct 2026 08:17:36 +0100
Message-ID: <20261025071915.1123867-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 4c49f52eb0..f871298d8d 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -25,6 +25,14 @@
 #define QEMU_PACKED __attribute__((packed))
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
+#define QEMU_ARG_NONNULL                __attribute__((nonnull))
+#define QEMU_ARG_LIST_NONNULL(...)      __attribute__((nonnull(__VA_ARGS__)))
+#define QEMU_RET_NONNULL                __attribute__((returns_nonnull))
+#define QEMU_RET_ARG_NONNULL \
+    __attribute__((returns_nonnull, nonnull))
+#define QEMU_RET_ARG_LIST_NONNULL(...) \
+    __attribute__((returns_nonnull, nonnull(__VA_ARGS__)))
+
 #ifndef glue
 #define xglue(x, y) x ## y
 #define glue(x, y) xglue(x, y)
-- 
2.53.0


