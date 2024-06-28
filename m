Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993CBC30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dj-0000L4-SJ; Fri, 28 Jun 2024 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dZ-0000G9-IG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:15 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dV-0006hK-AK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:11 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec4eefbaf1so2272381fa.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558187; x=1720162987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yFkcsEXV8tTNgx1V48/Rdkr/iwnE0vz/gcdrAU/mSc4=;
 b=xhlO9C06MKTW9dRT4RdhV0lzKi0PIF/EsR9aKVt1zCtS5isFp8wZ7l50SwAlZhGG3E
 WMnnKvPRtkJ+JYL8mQ2H84e5lCLTxKIHPP+90m7C/TT+lxcZjsm63MXy0f+hf4PjVMZo
 UTxmAcPYlTTDmxIhAiUTK9cbi2xvCAXMf66wkh1uEK1T7ZkxRirCt++38FHcOlipbQw2
 OzpkMqqGnq4prCLM4dybWy/CufuEdyuBBjIczIychabw3alI6Fqq6lgPnAVONPTdGMJj
 SnhfNi7D4ZNERrjXqvEsrQgq3fJQnZf6Qel3P18a1Vcf9Uk/paoA/ls0T9Jd0ji/nHAh
 1RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558187; x=1720162987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFkcsEXV8tTNgx1V48/Rdkr/iwnE0vz/gcdrAU/mSc4=;
 b=jwKJM+hFpQ9/egA6+9e/QP/fmkRNk0L9pt6jU5vTmti2o0nq/N5TqHRZR5raYCRO9N
 6iX6X7d2c7rzb3L7pNvnm0yg6rBZSS6RBlSDUuAQw9dUt4IwnupwkxiLObv3XAl5AfZc
 zfKowlut3ZAk1Y9VX0sYQ8RdnIHrYrNV16Wdw1NuxQbE2D9zVv89oEXTXTvBlGGm0gJn
 l2uKIdWnGvNh+Hx1L5u54kI1YdDAHFTP+ozyXcsR5aBYo8s4FhXu8hxwMAD5FiIAQKvr
 RQWZ3xaMJU5ZqfCAf3FLS90RD2OuUkhvIxkMXTEKuP9GU/9Mz/2XAuojdV9ki99hekMV
 Ix2w==
X-Gm-Message-State: AOJu0YxYUf0C/dxEo+8aHNWOsLWaJ6fz/aPv8xfxIFlFRse8gcv2P2ju
 pwWh+nl7U4NP8fYrYEOOicACOBuK+YVfA3p+o39jlec1B296yL+PyEK9pIVfGziBlBehJT2/q3n
 LZrI=
X-Google-Smtp-Source: AGHT+IGf21oj2fjTbjdCyDm+PxGdNgVgWx9/teGqOSreVc2xC7Vz2kjCF9uSclrQdfV9vpONnpp6Wg==
X-Received: by 2002:a05:651c:220e:b0:2ec:5e2e:39a8 with SMTP id
 38308e7fff4ca-2ec5e2e3aaamr112507221fa.3.1719558186886; 
 Fri, 28 Jun 2024 00:03:06 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256d664052sm10481355e9.27.2024.06.28.00.03.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 09/98] hw/sd/sdcard: Use READY_FOR_DATA definition instead
 of magic value
Date: Fri, 28 Jun 2024 09:00:45 +0200
Message-ID: <20240628070216.92609-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f37d9c93a..135b7d2e23 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -561,7 +561,7 @@ FIELD(CSR, OUT_OF_RANGE,               31,  1)
 
 static void sd_set_cardstatus(SDState *sd)
 {
-    sd->card_status = 0x00000100;
+    sd->card_status = READY_FOR_DATA;
 }
 
 static void sd_set_sdstatus(SDState *sd)
-- 
2.41.0


