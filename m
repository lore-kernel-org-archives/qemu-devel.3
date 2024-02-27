Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED7AC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret11-0006a9-VU; Tue, 27 Feb 2024 03:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret10-0006UH-Cs
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:42 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0x-0007pK-VF
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:42 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d36736d4eso2476904f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023238; x=1709628038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJyS5qt8DjA8G6kRexYPEmNOufFI9EWHlHMdi9Zk7Sg=;
 b=in1tBdvNoik6s04JJiuCezTZcHJ/oF/OAo/pO3EeWoRojTanmVjcWgdA460JI8LfZL
 mbfSb0B5iTf68HTYC0KNVOaUnULtxbHMLDHAoJpmMvgW9OZ5yjCik3ysviXozq7KJIzE
 bWY9xA0545mUfDS7DsoswsNApYHIqSXM+nUkgwxF6VK8qJM40SLYdYrhThAR/1Mf9wyc
 wRhzmBvQdmdhC9bbHm1AxqhhmimbNzUQnXZAUvy1dkFyN+Vf0r5ivZMuPQVzaFAJ/zfI
 e33LiY1ivysuXa+oz85ACFTfUdqyzPQsxdulWeGAKFClUnx/SkLp86dqiG2emYzOxFkS
 0fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023238; x=1709628038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJyS5qt8DjA8G6kRexYPEmNOufFI9EWHlHMdi9Zk7Sg=;
 b=v9jUSDSWqdcpelGXH/JS0pISKfzTeT4frXrAYdn+huOqBVyu+JAhYdlAu0hq85kUhO
 HVmXYnQlGVqccdJF0qkJ7kOvWvK7JZW14LULSFEORa2shZr/kK6UnonblFR01PeCHQZu
 kQEvQwTKDfJ5q6GYlIEvCIOMP6LiAmCFnxCQfR3c9K9NmyjarR46a3otCi/pFT35Ao1d
 dFrs+PVy8GEbFjrMaIqP5+q+MvZ7axq/+v22gT7zQWiBbJ2O2BX0jKQpFGXeqxrDAXcV
 du10g6yz8R8GrwWuSAEF3lfeeAKfRAEQ6ZfA6Fx9gAN4uxvkjBD2qjqAjHiM7byd1OHI
 uN3g==
X-Gm-Message-State: AOJu0YwacqxkXCnldrlnwmewz7WGpKvUpmCoyHk23VJuSJKn19HTslIs
 SVWyVOQLEAq+ywknRT5pLXmHgEHOOlIeM4eX/ioBVcBanvWvo4cDcytRcQWHRfRb7VXCfAZNuZF
 W
X-Google-Smtp-Source: AGHT+IF1jtyHafkZSI+78yE7AAE4YQku7yF6yWVst9Y+apCsP6UMwiZuZmiNYke9vjpqC9/NsQxciQ==
X-Received: by 2002:adf:ee4b:0:b0:33d:eb12:508b with SMTP id
 w11-20020adfee4b000000b0033deb12508bmr904783wro.48.1709023238379; 
 Tue, 27 Feb 2024 00:40:38 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm11023879wrb.84.2024.02.27.00.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/30] hw/nubus: increase maximum Declaration ROM size from
 128k to 1Mb
Date: Tue, 27 Feb 2024 09:39:24 +0100
Message-ID: <20240227083948.5427-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Whilst 128k is more than enough for a typical Declaration ROM, a C compiler
configured to produce an unstripped debug binary can generate a ROM image that
exceeds this limit. Increase the maximum size to 1Mb to help make life easier
for developers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20240111102954.449462-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nubus/nubus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
index b3b4d2eadb..fee79b71d1 100644
--- a/include/hw/nubus/nubus.h
+++ b/include/hw/nubus/nubus.h
@@ -51,7 +51,7 @@ struct NubusBus {
     qemu_irq irqs[NUBUS_IRQS];
 };
 
-#define NUBUS_DECL_ROM_MAX_SIZE    (128 * KiB)
+#define NUBUS_DECL_ROM_MAX_SIZE    (1 * MiB)
 
 struct NubusDevice {
     DeviceState qdev;
-- 
2.41.0


