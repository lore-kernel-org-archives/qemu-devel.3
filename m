Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE79C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDTX-0008WU-Jr; Tue, 23 Jul 2024 07:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWDTT-0008Ne-Ra
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:14:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWDTJ-0006OV-Ef
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:14:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso38564665e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721733259; x=1722338059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzdAeTmVzX5BA7pT+fF+VfrDZygQBDin0XNPxTXT+RQ=;
 b=rOPMod1u3Bedw6L3xu1mo9/cpuVyApsKS0//4nf77Vp8kz4z9QhzLHJkzoAPspbOdK
 WuTFP4AI+DfAUWEMvlsVfEQBILVELxqlMyZKsmy/ZMQx5L66UF/v1oDwVAMC+P4epbSq
 WU+uJQcO4R7/wuu5nkuNHQb1hUOMpANeEyRmqIKszvarvNMbdpeUfvxYAhTKoytYbRtP
 GV5b6lEiQQ/XxBwuVuEbpGj26eEx60VGy4hFMS41L26TTOTmd/ZjPWySy+lC2iXGv8WK
 V69K5K66qAlpoU5rq6azJ4BjbGsYeD+1XTRFduKu/2bN/JWiyRds2nJgBSLELLqNjtz9
 dvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721733259; x=1722338059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzdAeTmVzX5BA7pT+fF+VfrDZygQBDin0XNPxTXT+RQ=;
 b=JwhiCsXgz0zuFyFNej49Tig5SrqEfSDR6WpIVITDfHzOI6m5ln3x8QozWXS/jK2rnz
 CSpknSSYzhdGvJo0Rsiqj9bLNDFS0R1E2eH5KXaSnAIpOR9sxYpaXTsbovO1d8lVeku8
 AxwrIVUUoaxOeOh7AGHA0tIpwGldOzYnaIFBQldr3rVxWI6QsUOFxVE/VMNhDuEjfIX8
 7CUC+Pdf8Aur0xjEJB0FUU8e3Vk8VvcbiQUwyCUXVwknIFh9rDRKvS2iL2O4kDN8yKG3
 ICOX1HE/EM/XEQOP+x3M+u4tgfddxDh3IPAl74JR1knW7QItkThRfVbO/Kw8qoy55cVk
 BqRA==
X-Gm-Message-State: AOJu0YwrknkUAqi/Bk3oB30E4jU8q4Nw6IAv8PHtPwMSnv6MTNi2wxNT
 6oZQRHqkZN2aU8g9tIlMuoNcnQNJSuNHdZn3Je2sqcoQxBtTNBtq9VQFsgGlUTwMLy+D3rpb7jD
 3UMY=
X-Google-Smtp-Source: AGHT+IGlWSkIIEysLGKW/3ShrI0yzetSGAdLm6xZhsixenICE0r2XqtTojMLhsBH/zwZxnxctxGR0g==
X-Received: by 2002:a05:6000:507:b0:369:b838:9155 with SMTP id
 ffacd0b85a97d-369dee579cbmr1777349f8f.40.1721733259656; 
 Tue, 23 Jul 2024 04:14:19 -0700 (PDT)
Received: from localhost.localdomain (5.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eced0sm11128295f8f.98.2024.07.23.04.14.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 04:14:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] hw/intc/loongson_ipi: Fix resource leak
Date: Tue, 23 Jul 2024 13:14:05 +0200
Message-ID: <20240723111405.14208-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723111405.14208-1-philmd@linaro.org>
References: <20240723111405.14208-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


