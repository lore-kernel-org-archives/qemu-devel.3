Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA67BC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6Dc-0002IO-HF; Wed, 29 Jul 2026 11:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Db-0002I4-De
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:29:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Da-0008Ec-1k
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:29:15 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so466159f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338952; x=1785943752;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9UU67IURNj8PURmFA5VKoABWjQcNQzhVJM3O/Bwow3E=;
 b=K8Pr/JXnEQxYdX6rtSG6EQpLieHdKxi8x6JNcv+sBDFQbTEfI0XopvmEF6+Xz5aG/H
 XQgWe+OWJLq7/41b0g/ubnNYXxo2V+h2AxtCvDm2IOxzpsyOu3c+9y5ImFzK6ikHsF0F
 +ZO5ubJ/LtbEtfqxRBnUk5Aw3rrlV8+6e9ORqrMyv1Fetd/He2oSZGLonH/ESKqug9iB
 QGVcXddze5/e5Nbg1OScNQGtTJE8QCpb4swprptBh2K22sjtqkcd6nD+fJDbs4o34lV3
 EUm714HkUjF8TGmzeLnb2k1dFElaQtoCaCwKf00LbsXMnRf5JrVfT1iX1UyHB0bodTHZ
 Ce2g==
X-Gm-Message-State: AOJu0YyLgh8OumntibQmBJpm0HfZQO6RYmPZb8issELI5nbLKyd3Fb2K
 PODgfma5Dx4uresBf0jlkmYXWv3KpT7hNhXDanYmpLRDqfhsmf9oIzwLKZDJOAdc
X-Gm-Gg: AR+sD127StHEYPsMiiEY8JYbIQ8ZwhJjG+Z4S2bpWPqVIieDxb7t6nARaq+sgJY91pj
 WzKM/JE6L45sfiOuQrPbqurfvIMKrAqnmgRPYymW4IRanCxzF7bp2/9bxFXSNM1M5olxq4kABK8
 zlSq9ZrslwiQfV1gUoAvZRjct6eA2EnusgvXR/0UyMi0JKMYsFNLKFZ6phSOgWyc3XpTiH7ypok
 hWAZs5/W5NxByg1Ol57zGP1R8FF5bLRFhnxdzrYv5giiNQDcX2diJuCFwnCfR5THUNgWW9gcCDN
 ei19V+DZGtU0WAKJticfZyNTePQHgpmwc//qk9QwLasEHhcQ59DUW7WSQ66qtGt6zdMLmr/JoLW
 +LlnIpCDI2Yi7sVEx6aeaJHhKQ6oaTdPY6Hs1ibA6+rbMFgIwg+AOcUGjepc0SBbs4ZGGE5GeNT
 zFTLSVRs/PmFJAyboKCcgw9MwoWdiHpaktlUfI6KkDn1OdADHFo6rBqvoHntsGr966drRRDjF/t
 aV6elvK1/IlFIxzBNfsxiIwBLjoA864h4cr/o0DJ7PEFA1o
X-Received: by 2002:a05:6000:2dc4:b0:47d:ed1d:e0e6 with SMTP id
 ffacd0b85a97d-47fb1f2a08dmr9196249f8f.55.1785338952567; 
 Wed, 29 Jul 2026 08:29:12 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fbf0a4a00sm2558113f8f.34.2026.07.29.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:29:12 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:41 +0200
Subject: [PATCH 05/25] hw/sensor: tmp105: describe the temperature property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-5-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337963; l=972;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=dtFmKtAlRiVXJztXMlux9lIKLH6pMshNOkJwipbdeOQ=;
 b=AT4qhv0C1pJItpktotlJxfRrfF3wClzk3gbUDiD8QoHK4O7xdJCyXzg4+vTmT7Ot0Qmsdptxq
 y0EWOgJSQguAi5l2aqyt2Dj11hdGl+iW/BbjvgmlbJsUqO2OjDuc3Ik
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Attach a description to the dynamic "temperature" QOM property so it is
documented in the QOM introspection output (qom-list-properties), like
the injection properties of the INA230/INA238 models. The value is
expressed in millidegrees Celsius.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp105.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 5c77f991cc..fefa661711 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -367,6 +367,8 @@ static void tmp105_initfn(Object *obj)
     object_property_add(obj, "temperature", "int",
                         tmp105_get_temperature,
                         tmp105_set_temperature, NULL, NULL);
+    object_property_set_description(obj, "temperature",
+                                    "Temperature, in millidegrees Celsius");
 }
 
 static void tmp105_class_init(ObjectClass *klass, const void *data)

-- 
2.50.1


