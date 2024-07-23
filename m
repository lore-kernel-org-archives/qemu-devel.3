Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F8C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIA-0003zM-PB; Tue, 23 Jul 2024 16:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMI9-0003wc-2O
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMI7-0003w8-GS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso44883335e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767162; x=1722371962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEw2US0MusaevsyReo4Qy9oebugC1Q09g9E1j6NjCoM=;
 b=YkfBe30eIKZlLqI1KrdgrBb36cSgtV1XZNT0ah+gTUvYC84wCgkVRjcRictcqO6eUM
 CIPqcv1F8Nq1BEChvhXu9MWdx9BTAL7TtZXBLeyHUeF5i5OB3QMzQ3oRe/BxnCXZx7vQ
 /MAoN+pVQli1Ns9v/7DfoGKaFVLgPyE7MPQ/8aCxj06fjUJtF5703PLr51lxHzUigsrL
 FWxy7LnUgFnnGN71ovlawJtXYvP4mUGNAXCPC8g9IQEhKS22Y8aTebWH/iMaOBydUZZc
 OqdQfrgQ3YzCLSznQAxyjaKosZtoT+RlwpfTRy71vhvcnHxwz1r9j1hj4zyA6p7crBe+
 Vlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767162; x=1722371962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SEw2US0MusaevsyReo4Qy9oebugC1Q09g9E1j6NjCoM=;
 b=S9fJqyawedkOAr8e4yJEzzDiwqRn1TzeUYWfLZgQ6KXZaqJkS2Ztclla4xpHbzEhcV
 Ywz1xrBUjrarEydKd++RecRp3FbtpfwXC75As/n1Swm10vo0HoZ1PvLidff7zlSAur56
 IhFcQTdOYbZZjB7098iA4FCIqNld0AQ5j3KRbDxq8oG7MXsymzoUKQxfIAzxWx3v1NTq
 pr+2k+cPi5Fm7/88DJVAMrvyMxXFvLshfyaHGFbwKGkkvYa60HgCQx5Yz5ot10Czf5dB
 V/lsm41tEaOOP/WB/uweBZkMVJu3nL5XS550jT/qRNSneJ3yEZao58bc3sMJvoukY9x8
 PcDw==
X-Gm-Message-State: AOJu0YyQrYQ8MCdEWmlgbFoW9tuh4lJ3K9BrgRBC0yCvXbZ/Ol0Eo77n
 kqa3bhB/14IhTxbWV6OcQKl+fGhmfOO/Xqq/6uyIwO/vR2MaHm1jjUn9tKVevwPfv9itomx1Fbk
 rz5I=
X-Google-Smtp-Source: AGHT+IHxcOkhf0+BkIPgdu2V5qPDwcP/E8xsbMKL5oTz99VsZvIHXCMmfubEBbbB6nZr/VrTr4wGMg==
X-Received: by 2002:adf:ee48:0:b0:367:8383:6305 with SMTP id
 ffacd0b85a97d-369f5b14530mr35690f8f.55.1721767161794; 
 Tue, 23 Jul 2024 13:39:21 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e65a7sm319175e9.33.2024.07.23.13.39.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>
Subject: [PULL 04/28] hw/intc/loongson_ipi: Fix resource leak
Date: Tue, 23 Jul 2024 22:38:31 +0200
Message-ID: <20240723203855.65033-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Once initialised, QOM objects can be realized and
unrealized multiple times before being finalized.
Resources allocated in REALIZE must be deallocated
in an equivalent UNREALIZE handler.

Free the CPU array in loongson_ipi_unrealize()
instead of loongson_ipi_finalize().

Cc: qemu-stable@nongnu.org
Fixes: 5e90b8db382 ("hw/loongarch: Set iocsr address space per-board rather than percpu")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240723111405.14208-3-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e7979dbdd8b..4013f81745e 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -318,6 +318,13 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongson_ipi_unrealize(DeviceState *dev)
+{
+    LoongsonIPI *s = LOONGSON_IPI(dev);
+
+    g_free(s->cpu);
+}
+
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
     .version_id = 2,
@@ -353,23 +360,16 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongson_ipi_realize;
+    dc->unrealize = loongson_ipi_unrealize;
     device_class_set_props(dc, ipi_properties);
     dc->vmsd = &vmstate_loongson_ipi;
 }
 
-static void loongson_ipi_finalize(Object *obj)
-{
-    LoongsonIPI *s = LOONGSON_IPI(obj);
-
-    g_free(s->cpu);
-}
-
 static const TypeInfo loongson_ipi_info = {
     .name          = TYPE_LOONGSON_IPI,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(LoongsonIPI),
     .class_init    = loongson_ipi_class_init,
-    .instance_finalize = loongson_ipi_finalize,
 };
 
 static void loongson_ipi_register_types(void)
-- 
2.41.0


