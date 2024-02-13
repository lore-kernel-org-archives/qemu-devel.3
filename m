Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C16AC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsUD-0003xI-2S; Tue, 13 Feb 2024 08:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsT9-0002Tp-Nb
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:05:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsT7-0006Bg-5j
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:05:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-411c7359e35so2982105e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829499; x=1708434299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3G+vEW0xvfxGhbxCqdv/Jy2lDj70Tb0WDMAzSbPYcE=;
 b=gGp9CFuDM48uzgJgV7N4hAP0MXGegQGckU5j4lC/4alqBRcMd047e1SithzWnSByhN
 ulkM7Z6hlnys0x4ufGSVqluVZp3yJV3zIiGr1FI7jDwgO7XeCvc8XmprBbR1fkhFmguG
 HGHqcJ4OkDech8qPPc5642++TfNc8AzhuDuMBdx7hCfJqb1IVjXf0uCe0weJcJoGQwy+
 LZC22zwDe4QTpj9VC3rQs9HcJyuKv/83vlAuFtdhc5SDas4yy7AXrSsWs+qn9j+poVlV
 XbZr58JDyh7NuNxNM5ww7Ati6DgWL2HbzgTUE5ORyf18qLVZj2vTxlHAgz9rTNq40Xvu
 zQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829499; x=1708434299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3G+vEW0xvfxGhbxCqdv/Jy2lDj70Tb0WDMAzSbPYcE=;
 b=Rwi4f2JOfHpb47vSwsnFe2J1dxIVypYjJC6CJi8Kz/wxR7O8KYi7cH/DMhpSCx9a/x
 pfv73OtmVg/sbuTsAXJ2MBpy6Ek2cAtjVLOuLn1BBSh+HbWw/8olB/1ydfm3YN9UHRa3
 KmUepPtIyFgcf9Q6xwLTdEMUFFM4e/h8Ii1AOGafeJWOKXdTE7EHHWSfciK1LyyAA3T5
 gl039GqskasGLfreQkcy+YA8tkSit0ZdYuo1kzvXFZzdLZa8JnWh3qnqzT/T8hn9B6cI
 TSWN6+v4ECbaV1gXMbEzcnSbOldFrWbI4jTY5YH47qkx7KAT/eZ552M3EY/r1UvZZCz6
 AnwA==
X-Gm-Message-State: AOJu0YwJ+R67ZAfEcemSAosdGt3Q0/+MxoD579SCfRykjF/vcO0u1AaT
 vUd3U4u/So8DUChcKQGeyzBc2/LBmNldCFRPz3M374dyqDxEs11SzEAtENGydCa5L4b+8VFHbVQ
 A
X-Google-Smtp-Source: AGHT+IGtnmQRNqvyyUTuTlEM/IlSw9bzoQb/RYNCll0/zRSkxxRa88f001zakCHbh4xZWbt9yeEpZw==
X-Received: by 2002:adf:f712:0:b0:33b:4656:5e5 with SMTP id
 r18-20020adff712000000b0033b465605e5mr7446743wrp.27.1707829498845; 
 Tue, 13 Feb 2024 05:04:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUipwOP/ic6f1PTuNgzbwZzkboeUhao/GmYCicaTda3rwMCm0h45lDPBGyEtImnsy8MW1jkyMz4jn5ESyas6z+5A6h8+ToNGavXLrGpXkoBd5TV1KoIlGKeSVJ/wPdgPi9n4TcgfoTACI79dS0OSRX+YcdxJCqZ8q2mvArIiaLmpMqECDPv2LmNkwBPCTZ+DkO4y2jX48N24zr5iwc+7FbqYqTmg9eqhOAPV9D1FcAEKO0n2RD9VdqmPehn3WBfM0TmOqW5AbU1aFeSABzt2NR+L2qP6XvI0FxGz6yiO895HoRMhxuInSyPcKeLrNGIgAJJMsWHysHsvorDKLdhYRy8Dc7FOPV6vG7K7nHmwOoVrgZjfp4w6hdFMyi9TL4MBEjThLTX8g1jksuhnp497vtwA/wI9sqkqldBwUYwPWAh05cZ7UGogf8XOTvR3LiexWWZm2og5A==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d58d0000000b0033afe816977sm9465067wrf.66.2024.02.13.05.04.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v4 11/12] hw/sparc/leon3: Initialize GPIO before realizing CPU
 devices
Date: Tue, 13 Feb 2024 14:03:40 +0100
Message-ID: <20240213130341.1793-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Inline cpu_create() in order to call
qdev_init_gpio_in_named_with_opaque()
before the CPU is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/leon3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d2be900988..d0ff4a2892 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -233,7 +233,9 @@ static void leon3_generic_hw_init(MachineState *machine)
     APBPnp *apb_pnp;
 
     /* Init CPU */
-    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
+    cpu = SPARC_CPU(object_new(machine->cpu_type));
+    qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     env = &cpu->env;
 
     cpu_sparc_set_id(env, 0);
@@ -260,7 +262,6 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
-    qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
     qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-- 
2.41.0


