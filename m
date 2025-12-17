Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4174ED609D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfJL-0006BE-NN; Tue, 16 Dec 2025 19:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xvdBaQYKCg8D9qx2Ev33v0t.r315t19-stAt0232v29.36v@flex--yubinz.bounces.google.com>)
 id 1vVfJK-0006AK-JN
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:34 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xvdBaQYKCg8D9qx2Ev33v0t.r315t19-stAt0232v29.36v@flex--yubinz.bounces.google.com>)
 id 1vVfJI-00057D-Hi
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:34 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-29efd658fadso148668845ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765930951; x=1766535751; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Td4DPCzbmgg72zwqL5xCqKX1wPVdbUHYL/gz2sAvTfU=;
 b=RPPEczq2n5l5i0pSLuBGv4uYtwFWins6tCplnaIPDrk+u7C+maQqcynr2HUu6mysHh
 D0lf8BjzMTxmBNloYivBaHwVkoKmf7qy15XZ5+7i1GjoLSJQmFj/ioW97X3gReMamElg
 WYv2A3wyxFr9jb2cOkyXiEXgB8O1+owivceBc4rj3Dt3ugp0JwDa6epiAFlzMBW5Ffhl
 cqVBIBbPoDDXiIhmWxTNmt/flB7VjtOCw9be25HE/q04PsR2g5BDN61e4jasUSEWmpsI
 gg1IFkeBSGfu+P4M0ytoe05SmQw0moxsYcZA7J6BEeAOzoTH7+a7BpHDlLd+x1dXcM/o
 cGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765930951; x=1766535751;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Td4DPCzbmgg72zwqL5xCqKX1wPVdbUHYL/gz2sAvTfU=;
 b=OIHB01hXebwdQxMx5m7rbDPf/QrBSkRwy/yMNQx6Dzc8Zm9Op5hORm1ln4bC8FJdvM
 PgtcarMknew5XzPUtTAOV6wJQ2ykk6wNkP75ByRBIuywpyZ1mCc9bH1qGEEMKodPD4dH
 PENLgUAXWxoX6zC3jP2Yx3B/lQOwCNaNUIEtvXjysRtMSU2OJENRByxlN4lIqB93Dy5F
 Gkrls9CUaUdrEglgqgaFtqUVTA2pxxeibXo8NhWaJckt5y65z2fTSBCdbjrCq/qPIE3m
 L/tpMNc2kMGmMrxGxjbvT+2MXDDms1A73eok00LvUPPcnuQo3t2SfHyq+2j0n/0Q9K7S
 gaIQ==
X-Gm-Message-State: AOJu0YzyY50/zQs7bKhaM6AqijE8YXNKbfcnS9Nvxh7KHN7wdAaImxAS
 RKEYRd22Kii9tgQBY6h4SYvLk+UZzBwBt5+0ljT2jNdzSXcSZhQTaRYAvpHVfJkpKnj8QeiLG3f
 G5xGgplAB3PgD21u07awgnHNNNMllwNtNaUs3uo1Vzf4Fll8VEpLl91d+ba/XX3KNkFCVDLTphS
 YBG3MxPXGr2gXohiRlEjOlS3KEStrYaxnq+K4=
X-Google-Smtp-Source: AGHT+IFjkpWaeGVncAoFTTO807u93JYuLeP+c1BJKbTKFlVaUeXXnwO1BXykUZZRfotUaZ+eSqTwjS9Rms4=
X-Received: from dyaf27-n1.prod.google.com
 ([2002:a05:693c:839b:10b0:2a9:83e7:2680])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d197:b0:2a4:3593:6474
 with SMTP id 5a478bee46e88-2ac30120ab9mr11104971eec.36.1765930950560; Tue, 16
 Dec 2025 16:22:30 -0800 (PST)
Date: Wed, 17 Dec 2025 00:22:15 +0000
In-Reply-To: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
Mime-Version: 1.0
References: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251217-aspeed-sgpio-v4-5-28bbb8dcab30@google.com>
Subject: [PATCH v4 5/6] hw/arm/aspeed_ast27x0: Wire SGPIO controller to
 AST2700 SoC
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3xvdBaQYKCg8D9qx2Ev33v0t.r315t19-stAt0232v29.36v@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This commit integrates the Aspeed SGPIO controller into the AST2700

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/arm/aspeed_ast27x0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index e5f04bd16e80696e41005d9062a6df6d060b8088..787accadbecae376d0c747d054ec6372785375b1 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -519,6 +519,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     object_initialize_child(obj, "gpio", &s->gpio, typename);
 
+    snprintf(typename, sizeof(typename), "aspeed.sgpio-%s", socname);
+    for (i = 0; i < sc->sgpio_num; i++) {
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i], typename);
+    }
+
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
 
     snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
@@ -973,6 +978,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
 
+    /* SGPIO */
+    for (i = 0; i < sc->sgpio_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
+    }
+
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;

-- 
2.52.0.305.g3fc767764a-goog


