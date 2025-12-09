Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485B9D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSlB1-0007Gx-4o; Mon, 08 Dec 2025 19:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38GY3aQYKCuslhOVamTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--yubinz.bounces.google.com>)
 id 1vSlAz-0007Bo-1j
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:57 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38GY3aQYKCuslhOVamTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--yubinz.bounces.google.com>)
 id 1vSlAx-0007T6-KH
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:56 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b99dc8f439bso9911192a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765238513; x=1765843313; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=otXfzV3x3jmdu0ev4HSkq2G8k4KXSOIhZQ6dmB3c07g=;
 b=tHSZFQE8o22Nc7gkV/pwUNh+VROd/trkXX8Sxptwm56alCfHaFn+mG4RRd8iU8lNnc
 NKWKOOu2ikxOW3ePSUdGvq/N/687w1irq8tEIX6hS3KH/UeK5bUjSnVy04Pdy4YCb1qD
 RFOCP+CoKMd5FAOXjE294SOwosy97cVsjnNOLyfhh78J2BIlZKaNVQ+Oxlb9ZXuYVQIO
 03VMV8rh1F8N3HU7o0XfJdZGh4OF37QVPpWjM8gpZrGCN+6S/qwkQxiVtKlNbv2lRmka
 1JZ4eyQBKGuYVxaRQc3pwkf/6h7P1KfPdXCrV6eixa0/ilkJgjpiObckaUGtOh1XobIf
 0s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765238513; x=1765843313;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=otXfzV3x3jmdu0ev4HSkq2G8k4KXSOIhZQ6dmB3c07g=;
 b=R+mfRictmr2G3VrESy2JSUQtyGJsPaK3LkU4vhmory1o8rl8Eba7Q56JV71X/Kk6kf
 uRYspTgCMX+ZQaQHrvk6Ra83ODVre9KWX71h/ZxoZUqfXCkI8Nk53J2vUgIFqmh/QEVB
 jsH6aafo4ZIJ7rwf+ubc2NqPfYTm1xEh5EiIlR+wLWsuFzKIQDFKOdtuL5Quh+r3VOJT
 kqmnc18nWVs67Rtw3jKszUaOUb4C4zJsY/XB9syLaFUztqaPC8ryJqZqHLHOl5nR4aNa
 qgYwzhjImp0DCPUEes3ggsbs8J7vg/WcJoO5HQY1Xh2WwgnN8zXcRnl0mKoD9mp1R+b3
 +pQA==
X-Gm-Message-State: AOJu0YyAaQQ+xRNenzAHRgWaz3M9ERK/rwo8QJEFY8wszd+S0lThvCmk
 P3Dd5daDvvp242RqkKRqDSOmMbBAw6ZBUDA4nHgSyuXkNqWOSkwk/1Im/nZxCKIwzIczWUqEDno
 2f4d8ahAL7Ymh7QuWWkF53CJuppKfrSO+7WoIdViN7BK5guS2C81iSwZYqp/N4cX1oPl/H08wsj
 EjCWhOaLFbeWzo6kk+ECGn+WAHSARwKahDnWc=
X-Google-Smtp-Source: AGHT+IHW3z+q3GdQLsjhOzIktqrA/HPJHeruugQhUC1kIoFCNfbbRm7CFdSq4IdX37AW0pj/4rpbyL7ZwrU=
X-Received: from dlbds7.prod.google.com ([2002:a05:7022:2507:b0:119:49ca:6b8b])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:492:b0:119:e569:fbb3
 with SMTP id a92af1059eb24-11e032bab02mr8030968c88.34.1765238512653; Mon, 08
 Dec 2025 16:01:52 -0800 (PST)
Date: Tue, 09 Dec 2025 00:01:37 +0000
In-Reply-To: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
Mime-Version: 1.0
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251209-aspeed-sgpio-v2-5-976e5f5790c2@google.com>
Subject: [PATCH v2 5/6] hw/arm/aspeed_ast27x0: Wire SGPIO controller to
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=38GY3aQYKCuslhOVamTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
2.52.0.223.gf5cc29aaa4-goog


