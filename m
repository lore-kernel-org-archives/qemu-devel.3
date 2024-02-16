Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C554EC48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw38-0004YI-WE; Fri, 16 Feb 2024 06:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw2E-0002bV-Qu
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw27-0001L6-AN
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fd2f7ef55so16816995e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081528; x=1708686328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TP1TJioczzc39Hx3iqthMm6LDPQbvhwTOiEAkO1gUM=;
 b=YxW32De3ZsXwzJns1+dzJxJhcBFHYEb8tnw00Pf98GX+sR5gfeKz/H3vV8ezDDiDmN
 Vp7iT2hVTH/vhgcq0Zrzd3K1wFB6aA+HwgnbHY/X5FiiFwjHjC4revQ7rlIVkg7gwxnx
 3uCP5OMjKl0is5y2Ety2xRPsrWsPB8LYEXR6hi3W6MV5DFzaS4sfVYqLENmRCUYq+/C9
 ST7vnlkCbp5vBgMHS4El2ekn9fFvZBNUkaGQ3nUYfHLOZYaS0jpGCX8rQhg/9NHrS7bv
 ED6JuTxTNE8BcokPCcENyQDdh4B9spnhIuEp48xK8VNG1R0yvqlKve4ebn6UcB/Fjaly
 EcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081528; x=1708686328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TP1TJioczzc39Hx3iqthMm6LDPQbvhwTOiEAkO1gUM=;
 b=NvERRj9zm9ydTlQTGux8r5v05i+7dJdcvKcJz9xXZ/bTE+jkZwJv6sllPfrWLgtjdI
 gxpr+C9X2w7y2GHvxDZEAM5NVlPjYHWK9I95yyjvv9HevOZ6P5eHiFWvDL3oDE9xRb4W
 HlgjfY4lspVyhReoYbOOJKujZ9ZQudFBpDQXnZ2rZYDXO9ooNTHupL8KvRu7tnOSr2n1
 xU/FqWPetTnMLlnNFepaDADNlONaRiJMpmJkM2wueiZjEVqqXn6s2r5VyqnR0+8HRS+V
 IT/6slut4sDIOWgLNUcZOKqDjZuhF2kT02I/HT6c9jmVF7tV1l5KxFdro8Cb8MQ36huh
 imWQ==
X-Gm-Message-State: AOJu0Yy7Q8jk87ObReJPyAzDiTb7mA9Wy39ivEFNLzTcY6zVdkExqelb
 b9GLV2CU0V/cjqBHo85kXrElM+Do5gcpf5FPuU7lk1jXs9LUvU5GYiz1Nr8PpO0cbx/11zbhMQM
 G
X-Google-Smtp-Source: AGHT+IEuLhan8PMzjpoVk8iNDX+51J2TUk5ZsvY/EOaOL/amk+8mlPJ5ImdnALCtoNT5IeBwXzj7/A==
X-Received: by 2002:a05:600c:3b10:b0:411:aa3c:128d with SMTP id
 m16-20020a05600c3b1000b00411aa3c128dmr7082597wms.15.1708081528391; 
 Fri, 16 Feb 2024 03:05:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b00410c04e5455sm2031239wms.20.2024.02.16.03.05.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:05:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 20/21] hw/arm/mps2: Add QOM parentship relation with OR IRQ
 gates
Date: Fri, 16 Feb 2024 12:03:11 +0100
Message-ID: <20240216110313.17039-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

QDev objects created with object_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Better would be to embedded an call object_initialize_child()...
---
 hw/arm/mps2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..780f2adf0f 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -274,6 +274,7 @@ static void mps2_common_init(MachineState *machine)
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, "num-lines", 6, &error_fatal);
+        object_property_add_child(OBJECT(machine), "orgate12", orgate);
         qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
@@ -317,6 +318,7 @@ static void mps2_common_init(MachineState *machine)
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, "num-lines", 10, &error_fatal);
+        object_property_add_child(OBJECT(machine), "orgate-12", orgate);
         qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
@@ -333,6 +335,8 @@ static void mps2_common_init(MachineState *machine)
 
             txrx_orgate = object_new(TYPE_OR_IRQ);
             object_property_set_int(txrx_orgate, "num-lines", 2, &error_fatal);
+            object_property_add_child(OBJECT(machine),
+                                      "orgate-uart[*]", txrx_orgate);
             qdev_realize(DEVICE(txrx_orgate), NULL, &error_fatal);
             txrx_orgate_dev = DEVICE(txrx_orgate);
             qdev_connect_gpio_out(txrx_orgate_dev, 0,
@@ -425,6 +429,7 @@ static void mps2_common_init(MachineState *machine)
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, "num-lines", 2, &error_fatal);
+        object_property_add_child(OBJECT(machine), "orgate-ssi[*]", orgate);
         orgate_dev = DEVICE(orgate);
         qdev_realize(orgate_dev, NULL, &error_fatal);
         qdev_connect_gpio_out(orgate_dev, 0,
-- 
2.41.0


