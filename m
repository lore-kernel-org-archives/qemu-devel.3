Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5ECC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tv-00055i-Ud; Thu, 08 Feb 2024 13:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tt-0004x6-0x
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:29 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tr-0006o6-5L
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:28 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so10569366b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416005; x=1708020805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARLLZN1q9jOO5ilFbs0xhNVpC6mVoYo93eKHvwmo3rg=;
 b=BzItl0TNbV4E0X7V0XOnMZ7urtn+gtlgFpoTFPRJ1NJ5VU6tLcQqtPDV4sUfSaOo23
 k6ddd4bp+gRU1jj4Z8F9I9R235GQ/gm95sHD5KUaB7GCbJibLqH3BGemRQ1rruRt050I
 3SkpMn1B2XIA/e+DzRgJ/RiNLbRJ9+7qpk2eCnNRzvYJszndfRtipvFVWVxBQMYMC8Wp
 1XEpHmp7Iw7PCtnkivcDk94cO/uG99PoE3zMyd7EKwbb4TDqUS3h7ZVV3lHyQcRGnLWs
 jewIrUuNzNTDrUMKME4/LGuvg9iUOp0E3qlERButSOtdWdqyF5INfu5KEuYr6Bwr3S8S
 MRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416005; x=1708020805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARLLZN1q9jOO5ilFbs0xhNVpC6mVoYo93eKHvwmo3rg=;
 b=iJFa83rZZ4zuKkpN80rgeGIWtTSgdJC/+QBoM7tnM2jx9oIOV3gvq81g/3W3fJkKth
 RcGGl2hVDVdWkUCKNCG8QzdNiYUYRGoR1sS+7F6X4he6L45LYVLsvpG5UzEtgNYmKnY4
 Jw4/4zolkXnI1bvs81uDHaA4yUyjYVbnePhPa90t9Z1EpWzOpaty0s9yWjCq9CrKH/ms
 KT6JORh5kcynlXwWcaMAGWcUYVlYeWA8zu2RVNiuVgcVWtRHR2+wXWJbY6AsinVhQsBv
 buwz0MqoGGUX0lJgf8MfbEIALd0pKNuqRy6xfzlICphCayKPxvPK4tN6SHv0dMwK93dO
 R59A==
X-Gm-Message-State: AOJu0YzCMxtQwNUiqRd4iYz7nFSrDrAygfQj0sXt/c6RXSPM26ae8aya
 hsIR27POv1/j8+QOhtRhyEP+EIBjl06hzXmmt4EvjrxICkQghw7no8i0AH54FF4Hju21o8iCZZ1
 kKTo=
X-Google-Smtp-Source: AGHT+IFNJmzKp+Nd6YSYk5g8osOTKPbq5lQ123BcB5EbAp/PILwUbhYygEwBBRtx0q770AkE0FLs8w==
X-Received: by 2002:a17:906:6d55:b0:a38:4cd:7e13 with SMTP id
 a21-20020a1709066d5500b00a3804cd7e13mr76621ejt.35.1707416005261; 
 Thu, 08 Feb 2024 10:13:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVKe3bkGBFJH1vsY8ebsqIn9hao/dFktYpQkK5HaFuys/YJBAzFebHkOxcimAX7Go3ZEvuRwo1u+NVl8xiGCMRpmSTYos5UyKpbUY237ApkQjomiiyhLZT1g9WAR0YpJWsQ8CIAYWYK1eBJvxE5+VrRY6E3zorRYGmg6MQpuVwKVpOfQJlmDrkZL8eW1aFHU+0zYxpo8nYEMEzlyeUcXzv+Nj1M1YgJYyDFemp9WeaPn18/yTyxs3+t3NdlFDYKbr9YugckyonlUDvRz60Nc3LM+Hr/ESOJ1SNUeRxGUcwgmwNLEKTJmCPv0AqB0aw96EJdzCUm4A==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 vb5-20020a170907d04500b00a38103ab710sm298607ejc.125.2024.02.08.10.13.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/11] hw/misc/macio: Realize IDE controller before
 accessing it
Date: Thu,  8 Feb 2024 19:12:39 +0100
Message-ID: <20240208181245.96617-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/macio/macio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index c9f22f8515..db662a2065 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -122,15 +122,17 @@ static bool macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
                               Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(ide);
+    bool success;
 
-    sysbus_connect_irq(sbd, 0, irq0);
-    sysbus_connect_irq(sbd, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
     object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
                              &error_abort);
     macio_ide_register_dma(ide);
+    success = qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
+    sysbus_connect_irq(sbd, 0, irq0);
+    sysbus_connect_irq(sbd, 1, irq1);
 
-    return qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
+    return success;
 }
 
 static void macio_oldworld_realize(PCIDevice *d, Error **errp)
-- 
2.41.0


