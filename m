Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31116C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JC-00070t-5M; Thu, 20 Feb 2025 11:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J6-0006sd-Sa
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J5-0008Cu-64
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f265c6cb0so620023f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068506; x=1740673306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t+hteArCDvNDkEWIdPPQmXbS1r+mwmrCAQ+A+iGKN+k=;
 b=pnFkhKtO3jdUoJYRl2MeQTDxQfMcQCJxHx0pjgy2Xfa7lMzuqnfuf4Ph32UbdqncRB
 AxHXis5mTMas2Od6DUXrD3w91z9kGVnivzI8vi47rijas7k0u5/8FFWbaxieja6h861R
 +6fS+UJ2wJuTKx7kBTEsmxsR854RP0/bQp1iiv6eeYjAasmIojyfaBYQENh6VVNWfv4z
 DrGrdbuEJp4lxRWSN8MMqceTdwK8d9Qj+LUcwabwXWYTJgz1klhOMbJyXjm9w5LYu5XI
 vw+3iu+f3IvLYGacWTWZ/x/7ETFNhGsCyv7QpKZSpSSSW/XSrYyjQapcCgndCj7ITa6y
 Fwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068506; x=1740673306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+hteArCDvNDkEWIdPPQmXbS1r+mwmrCAQ+A+iGKN+k=;
 b=DltKj9u7M4g135rkli5rDMSILcQNXFNV9g0uvggLQiVvny0Co34OTaB400DN9B74kf
 psENdBQ8P2JUqWOkVcJF/2rSPqRZZ1aeHctDs9zuwwrINvg7n+MJ8Yx3bdazQ8R8XNw8
 2QgjkonGsEZPFoodR5n/LksOdHc5ARYaDrl3Y8AxX/RYBYPkYDSozipgD3LeYZn2KAw1
 LeYESKWfFlspRKIg4qxSETZRUHqAJTs7MGZIFnpsJgvbPzVFjYrdaXfVVNovZBYVZi9M
 +W+WyJZ4UgduFZHBMonzJJ4t99rEhD2xW5vi63IEnbq0mNHt+Zs02KTwiofaO9BL2By1
 KVKg==
X-Gm-Message-State: AOJu0YyTZe3LhIySF9tB64s8PsAG83sruUkDhmcjffME3TI3BagBBXjy
 17cTbJCXXy+AX68FllB3qopN5/fT3GWA8ZW2NYokguENHyCybJl8FTdlcklQdVIvNdBV/xaNwT2
 U
X-Gm-Gg: ASbGncupFzHX6dxdr9Wnk6O8JX65/RpZJh8YxoTqCAEMjSwkB1YNhpOnMQMhEU173J5
 7QdV+wTf25Poa4zWTFlnbMoW6Ahw6Q7QmyEQDgrEXnIisKFFPnXwu+j6npxkJWaIdemAKo+sems
 yortJxVtcObMaloL60iPcUdV3cFBbHmXfwChJNGHVPG6P6ycte3311SyU4lXhdtYgEpxaGQO1r5
 eTU3HAm73U4TgHZvz5ucy1cfuGrgu5y/BpmbWE8CddURV2D63iyWT4f/y1DHZJPJFgzzH43wI6s
 hVqHbhKv1cqc8atEZc5K+g==
X-Google-Smtp-Source: AGHT+IG5deF+/kMARB3TEorYJtMxsNeqJnSLf5C8GywNWV0x6Ex+M1dKElThAli38gOvvrR6cPqL6w==
X-Received: by 2002:a5d:47ce:0:b0:38f:3a89:fdae with SMTP id
 ffacd0b85a97d-38f3a8a019emr17408965f8f.46.1740068505719; 
 Thu, 20 Feb 2025 08:21:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] hw/arm/exynos4210: Specify explicitly the GIC has 64
 external IRQs
Date: Thu, 20 Feb 2025 16:20:57 +0000
Message-ID: <20250220162123.626941-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"). Add the GIC_EXT_IRQS definition (with a comment)
to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index b6537a2d64a..b452470598b 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -103,6 +103,8 @@
 #define EXYNOS4210_PL330_BASE1_ADDR         0x12690000
 #define EXYNOS4210_PL330_BASE2_ADDR         0x12850000
 
+#define GIC_EXT_IRQS 64 /* FIXME: verify for this SoC */
+
 enum ExtGicId {
     EXT_GIC_ID_MDMA_LCD0 = 66,
     EXT_GIC_ID_PDMA0,
@@ -588,6 +590,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /* Private memory region and Internal GIC */
     qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cpu", EXYNOS4210_NCPUS);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-irq",
+                         GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(&s->a9mpcore);
     sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
-- 
2.43.0


