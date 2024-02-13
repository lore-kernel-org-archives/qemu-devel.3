Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3157C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsTu-00036h-DV; Tue, 13 Feb 2024 08:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSe-00020Q-PJ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:37 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSc-00065V-2X
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:32 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d0b4ea773eso56678131fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829465; x=1708434265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjkB+UnEukm/G3HfYj7xftramerJL8Ci1VN86IlC3EQ=;
 b=zLix+y+h6M8Mo5JxlojlTgkM2DJHY2Wp44kxEJBy0913n1yBIHyJBYwC4SAc4f65QV
 m6LV72+hDbyGXapG4PAzHyV1NA6ifEZEj5NZpvSqEUu/hTXmyvQ1TZpBtoa47M3oSyW1
 GVXNR6cNmLmXuxWFvQL8OdVrxAdVGCyhYwb2zaRPyTPRK0kDnQYygjBwq0PcWeZbXdmu
 HrslsdBx+5svjv10dw8C++H0kgfKlMBR1zHAydOliw7Z7e1A0dP0JS5SEucEsGfwKM94
 02WVFYTj7RbgmOpXgNIIJYXsmWnbGl4nURfOz1dmKv23geqyrPB5EiddQmPs3gYFWcI0
 lpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829465; x=1708434265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KjkB+UnEukm/G3HfYj7xftramerJL8Ci1VN86IlC3EQ=;
 b=MAGHtiiY06O6hdDRaAqLv4dly4TzXq0P523HpCgYCC9+cl3zPLNeR94fWwuvp46Np1
 6ZnnS6rfxL/07xb5iJwRjh2xPlay+Mdc80WZTy5uL3Wdd1A0uURZmZkf+SRAqMUTjn0S
 vUI8qotxmLwJW5hfSa3siqc3Kggb1v6jYmoAdZgaqOg9sECKfe2fQDGKZzUWDuRosLOf
 cNoDwnjflwXYLrFT1OCnjLPvp5Cm1bNuCUz26rxKo0gGlwRgWvfTrt5rCOQeFqMuI5w3
 PIWcaZwFLbYAoELG++aqK9B0eal2nJOrOOE40bBioExswETWUtqWMw8Mo2Rdq1cfldWx
 gPZQ==
X-Gm-Message-State: AOJu0YyLMyX3vOEy9TPAg+EFEdLbTU4xXBsVYPQkMmE7gIU5IYKsw0so
 WMT67WK5vYKZ0nEfWAVvWN8xtJfp0QX0yMdYfddRTvQW2h2ZfXLV+L/2jniXKa1ScCaCM70JLOd
 l
X-Google-Smtp-Source: AGHT+IH92ZgrcfEt1Vda9mY54qHQpfWrywCxyUFucjxJ3e+ERAzOyi98zISrTor7mdA2iT6nQmxOdQ==
X-Received: by 2002:a2e:a615:0:b0:2d0:698f:1fb with SMTP id
 v21-20020a2ea615000000b002d0698f01fbmr5797890ljp.5.1707829465497; 
 Tue, 13 Feb 2024 05:04:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdOCzsYTBBK7kPOb9KwFlrPl9+/2764GRmGdTqaSSS1tmSSaFRTKYDcQ/TzlyIkOItZgmR6vAVlr/SIAXXUHtK6C+mw/6xAT3jrXMK5xvqwnnA2ngWuaYefelaA6dpX4QTRuvhlxfw2OVlvcwzwBNk4NwKX+qifcCgg5iskJRgbgNn54GZjjPe6P/KiuDjhSPIO1Hg/X5lKyAEM1QdFujDcVmxeMVW/hfN4JJvKWXg7N5B09K5855vCsVCEafvJonZh4TY0C8qa7/UKAY8i0KgReY4UHe15nb6SSr85+Tt8eoeJarNtAeUt7YSKwI/X8b1Z6LGJG4=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c314b00b00411ab6dad65sm2948681wmo.29.2024.02.13.05.04.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 06/12] hw/misc/macio: Realize IDE controller before
 accessing it
Date: Tue, 13 Feb 2024 14:03:35 +0100
Message-ID: <20240213130341.1793-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/macio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index c9f22f8515..3f449f91c0 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -123,14 +123,17 @@ static bool macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(ide);
 
-    sysbus_connect_irq(sbd, 0, irq0);
-    sysbus_connect_irq(sbd, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
     object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
                              &error_abort);
     macio_ide_register_dma(ide);
+    if (!qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp)) {
+        return false;
+    }
+    sysbus_connect_irq(sbd, 0, irq0);
+    sysbus_connect_irq(sbd, 1, irq1);
 
-    return qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
+    return true;
 }
 
 static void macio_oldworld_realize(PCIDevice *d, Error **errp)
-- 
2.41.0


