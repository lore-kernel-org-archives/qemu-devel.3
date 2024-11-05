Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839D2D2B920
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JFO-0001gI-5n; Tue, 05 Nov 2024 08:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFJ-0001Ty-OS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:23 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFG-0002Py-St
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:21 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539e3f35268so6650307e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811917; x=1731416717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTPJzGm6ARvkieLOl7sA7FxSacHjsJ3U8wjcC2hw8sY=;
 b=OI0zRu5WPJ+u6FeIyijnr+v/CDA4CFJwjh7vSvWlDuK0d/WRj8kko2onvYiigSBlNM
 o7CrbtRKbhg26TWr9G+6o8IMXk8bCpnDWeFiCrNUpDbVsd+vTwVRpdFOveVUmNZS35kY
 5d5/Bddr+G9epkTjJaAimElTSLfL0NkBNOXhuYMMC43QcPk4xQsDPwW/4l7o6upBCQ8r
 uP87a+HvhWRAU3Cp/SPgwLAuem+QJJ5Vl5B/PUi0Nyg/HxG7tdoCNVKbcKGr4aFykP82
 kzLBHtTMPzunjyHEIGdLSJOUWfIxx4/rXFrdLxzOo+WgV5u1rE9DLWucEfYunEnczBHb
 349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811917; x=1731416717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTPJzGm6ARvkieLOl7sA7FxSacHjsJ3U8wjcC2hw8sY=;
 b=giP8hxGuRjbRaS/zBturzRvbup33IvQQzOJf4wONFFCfU7ebS4BOMMnzH8TurYez4G
 nz8A5Ao0hMk3lWLbu5OH0CotrFeqs/fZan87m8WTnJHIHmKqIX6NdHk9zrWRC6NAGiij
 zEAz8CM4Uw+ILGwAmvQGa8HmaD8Ik6aYPwwb27DgU5GSMtJaJFKtZs/+wvu5OHfa21vZ
 0web53PW4EF1hva/A1cjZD4oPiRjaJfO5IS7kHFldpkVO/fk26OLXpP+F0+99F1HBble
 kGc2IPYcRvV1viqxTsF3hSJ4s+MqsPfH9TVf4fERizioI7DIWmgiC6ioD7l7o5E0L4tT
 tZ3g==
X-Gm-Message-State: AOJu0YyucCHWLRhDdh2JZKMDyZXJGzLo4ARXzuApDHJx5QFM95OoHNVO
 kXiWmhrsWkoU/ITT3WlFbbs8kJgk6ZojEIU3thHbVsCD7IqTsK/6TwnuWvZOLMmz887e+xvakjG
 u1rA=
X-Google-Smtp-Source: AGHT+IF7o39CgQKyGJLAo1oyV+Q6nf9i7OBUM39LTm0TqHPkAVkhIraSCMoY5C+TcT5eFyJcdM6IIQ==
X-Received: by 2002:a05:6512:1288:b0:535:68ab:7fdd with SMTP id
 2adb3069b0e04-53d65df270cmr7648972e87.19.1730811916609; 
 Tue, 05 Nov 2024 05:05:16 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a99d3sm219571055e9.38.2024.11.05.05.05.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:05:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/19] hw/microblaze/s3adsp1800: Rename unimplemented MMIO
 region as xps_gpio
Date: Tue,  5 Nov 2024 14:04:16 +0100
Message-ID: <20241105130431.22564-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

The machine datasheet mentions the GPIO device as 'xps_gpio'.
Rename it accordingly to easily find its documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 37e9a05a62a..581b0411e29 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -124,7 +124,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
-    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
+    create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
     microblaze_load_kernel(cpu, ddr_base, ram_size,
                            machine->initrd_filename,
-- 
2.45.2


