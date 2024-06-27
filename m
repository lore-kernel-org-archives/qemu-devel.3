Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46007C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKU-00011n-0y; Thu, 27 Jun 2024 09:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKQ-00010G-Uy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:22 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKP-0006LX-9O
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:22 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso5671334a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495500; x=1720100300;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GK1NnhFlKONfJOQ1epeja3jVUC6tPChPm6e/EkyYkzg=;
 b=3dfUEHYUCKzfRk7JTHaTwWcEEyeH9EmUDesSahiUXQXRaAOjwIMN2m2BkjCSkiyV1L
 h1fkXkEGFmToUnYBsBc39jrsJcx8RZxiALKMndPOGtQKWgToLxj5SL/kWIWU8iT0cOma
 BhdLbdGqSd+wxfGv0xQ3abc9vGKwllX2JNCtyYSUJD3oi4NpB69Wb0n4qj2jy6RLWW6E
 Fppt3Hrbk050D8CDfCQogynhKavRTEYuwU8cPHEz4DTEaYKiTw1eq55JsR3l3Ovfyn0F
 S20DtImPfnrYkXlWh63M/mCo5f4WjuKBukeXFDOQOxcE6d0rOMJvmSdkf/956ShPZ0s0
 3hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495500; x=1720100300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK1NnhFlKONfJOQ1epeja3jVUC6tPChPm6e/EkyYkzg=;
 b=eiZMzFws1/8bf3fh8b3Ut5xwlK5ap2efXKeWpXsRpVSzIw99nDdbmRKzjF+G8USlkb
 7g84y2M0ptgk/SD4OlSoQTkvlbDbxZ4Q366a3cU1CGrAeQ30nFnBot3Mw1HtopM0lP6f
 X1LLdSDIPYK//haOEnl3pA47979WA9Igr6B1DvZDPhTxJsx0B/pkv3R0AxEYQ6D/p32X
 5fT5Bv8dEKUmcdYMQN4lYIPptw98bszGgh/m51pD1huAE8BITlA38DyVv9MGL6aMdlaC
 iCiMdAT0v5vioDVY01vWdHYDX+HFycdErOpUjTCvqxK1WCvXv0pJdGiGwITn/dwApXvm
 6jOA==
X-Gm-Message-State: AOJu0YwjMRXgZs24L5ajSo6lp7TZyX2Wxi+eE5iAI+dz7YSIgRMWBJnU
 Yv1OCjP3AMCcLP4POtUEzUM7mmqtKC+xPEf/UGudoGSzMNMEB+dHTdX1FrAF3BI=
X-Google-Smtp-Source: AGHT+IH3egdUupwHg3/fKTQf59c7eE0cNW7DQzddzdTPcu/CpgemJeZtdnd9ja5WHZ+QSceM/GYFVQ==
X-Received: by 2002:a05:6a21:3382:b0:1be:c6e6:a712 with SMTP id
 adf61e73a8af0-1bec6e6a7edmr4650330637.29.1719495499967; 
 Thu, 27 Jun 2024 06:38:19 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8fcd7dsm13226835ad.117.2024.06.27.06.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:45 +0900
Subject: [PATCH v2 02/15] hw/ide: Convert macio ide_irq into GPIO line
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-2-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

macio ide_irq is connected to the IDE bus. This fixes the leak of
ide_irq.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ide/macio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index aca90d04f0e8..9c96a857a7c1 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -427,7 +427,7 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
     s->bus.dma = &s->dma;
 }
 
-static void pmac_ide_irq(void *opaque, int n, int level)
+static void pmac_irq(void *opaque, int n, int level)
 {
     MACIOIDEState *s = opaque;
     uint32_t mask = 0x80000000u >> n;
@@ -446,6 +446,11 @@ static void pmac_ide_irq(void *opaque, int n, int level)
     }
 }
 
+static void pmac_ide_irq(void *opaque, int n, int level)
+{
+    pmac_irq(opaque, 1, level);
+}
+
 static void macio_ide_initfn(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
@@ -456,8 +461,8 @@ static void macio_ide_initfn(Object *obj)
     sysbus_init_mmio(d, &s->mem);
     sysbus_init_irq(d, &s->real_ide_irq);
     sysbus_init_irq(d, &s->real_dma_irq);
-    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
-    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
+    s->dma_irq = qemu_allocate_irq(pmac_irq, s, 0);
+    qdev_init_gpio_in_named_with_opaque(DEVICE(obj), pmac_ide_irq, s, NULL, 1);
 
     object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
                              (Object **) &s->dbdma,

-- 
2.45.2


