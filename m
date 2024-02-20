Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FC0C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlU-0006Yj-GK; Tue, 20 Feb 2024 14:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVlP-0006XP-5a
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:49 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVlN-0006Z6-Jx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:46 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d228a132acso48085091fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708457201; x=1709062001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hUt/YzOZmeP2AC1y1qRNyEeuFDCyV/aUnZ8Viy/DjY=;
 b=OTkJS3+M0Q0KRbMc7hAIOzKOU/B6vt8mFMLSG2IHRki3R/tJRa2kDNC2aLveL8xuxS
 6ImbjdJVj4zU0j22gJHPriSmibS/ou+nCBJfHUuPJzOLLcjMh15Aa3w7mjK4MX+GJTpu
 hqQgblmNPKlKKy1jqBdYoTS2OQWBjItVGckvHSwQF3j+QoBGYEILQjyYio+KL4wApyKx
 Mp1NxHsaHWmHEMVKLfnWntB98vqABUFhE5+yulgtL/4dZry8TdNWkiFUUro+ZsA9DWLX
 VQn4PFST6TZimh2+87pYu1DRbe7rtZB3ax1UMTOGc1wyNTgQKxQyreaCK/bpqj6/oQpf
 a3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457201; x=1709062001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hUt/YzOZmeP2AC1y1qRNyEeuFDCyV/aUnZ8Viy/DjY=;
 b=RVF1qD93W4ftzWqBGx/qrytpBGTMosJO6d1mO7L60ShmDhN7avjgcyvzQuGPCE7vjp
 zJSeQRldM8kGcuJF2ebZy05Jc6hLMqpENuF2TVANmgV8kkD33NjJQj7nWLUzkPM/9zzA
 p01h2kx/8sisGHDuVv6Ki+7IILFCwYLdTM3zGK25VQWdmPhwaW6rPIFQ6tKHR/ynP4DH
 mMGfaMCpkWn6cV+Y5fKFHcEdjatcOgSCEIpiw6j/iMKKNIdoKC8Wzmlvcz/ww0GXT0Vy
 3H/lx+/qlR/szBcNDZHpkWjQfJ18oM1QZZF7W7QFmqoUyL8t+Zb53J5mPjVisDh3Qptd
 pMWw==
X-Gm-Message-State: AOJu0Yyn3Lq+m9CgplPvAHPJd+IRt7KD1GTDWKNbHq+W6mvkfwhACmcN
 rLbwqzbCWoSZEYen9Sf2XjWKb+KgDvjsgb3eJPihUk++efU/b/YBxgkZ/qZnulFAbVakbS0y9qs
 8
X-Google-Smtp-Source: AGHT+IG3s/xpgkwMsR8rsCm87wdO6rXaSA7VLSIkNEuw8kVHsUmxKU6SwgIaBR3ABGS6Nfn/cwCLnw==
X-Received: by 2002:a2e:8ec8:0:b0:2d2:2ee5:8212 with SMTP id
 e8-20020a2e8ec8000000b002d22ee58212mr6154400ljl.13.1708457200813; 
 Tue, 20 Feb 2024 11:26:40 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 m8-20020a05600c4f4800b00411fb769583sm15737715wmq.27.2024.02.20.11.26.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 11:26:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] hw/alpha/typhoon: Set CPU IRQs using QDev API
Date: Tue, 20 Feb 2024 20:26:25 +0100
Message-ID: <20240220192625.17944-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220192625.17944-1-philmd@linaro.org>
References: <20240220192625.17944-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Keep a reference of CPU IRQs in the TyphoonCchip state.
Resolve them once in typhoon_init(), and access them with
the qemu_irq API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/typhoon.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index e8711ae16a..f038b6f000 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -26,6 +26,8 @@ typedef struct TyphoonCchip {
     uint64_t dim[4];
     uint32_t iic[4];
     AlphaCPU *cpu[4];
+    qemu_irq cpu_tmr[4];
+    qemu_irq cpu_smp[4];
 } TyphoonCchip;
 
 typedef struct TyphoonWindow {
@@ -343,17 +345,16 @@ static MemTxResult cchip_write(void *opaque, hwaddr addr,
             for (i = 0; i < 4; ++i) {
                 AlphaCPU *cpu = s->cchip.cpu[i];
                 if (cpu != NULL) {
-                    CPUState *cs = CPU(cpu);
                     /* IPI can be either cleared or set by the write.  */
                     if (newval & (1 << (i + 8))) {
-                        cpu_interrupt(cs, CPU_INTERRUPT_SMP);
+                        qemu_irq_raise(s->cchip.cpu_smp[i]);
                     } else {
-                        cpu_reset_interrupt(cs, CPU_INTERRUPT_SMP);
+                        qemu_irq_lower(s->cchip.cpu_smp[i]);
                     }
 
                     /* ITI can only be cleared by the write.  */
                     if ((newval & (1 << (i + 4))) == 0) {
-                        cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
+                        qemu_irq_lower(s->cchip.cpu_tmr[i]);
                     }
                 }
             }
@@ -802,7 +803,7 @@ static void typhoon_set_timer_irq(void *opaque, int irq, int level)
                 /* Set the ITI bit for this cpu.  */
                 s->cchip.misc |= 1 << (i + 4);
                 /* And signal the interrupt.  */
-                cpu_interrupt(CPU(cpu), CPU_INTERRUPT_TIMER);
+                qemu_irq_raise(s->cchip.cpu_tmr[i]);
             }
         }
     }
@@ -815,7 +816,7 @@ static void typhoon_alarm_timer(void *opaque)
 
     /* Set the ITI bit for this cpu.  */
     s->cchip.misc |= 1 << (cpu + 4);
-    cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
+    qemu_irq_raise(s->cchip.cpu_tmr[cpu]);
 }
 
 PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
@@ -845,6 +846,8 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
             cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                                  typhoon_alarm_timer,
                                                  (void *)((uintptr_t)s + i));
+            s->cchip.cpu_tmr[i] = qdev_get_gpio_in_named(DEVICE(cpu), "TMR", 0);
+            s->cchip.cpu_smp[i] = qdev_get_gpio_in_named(DEVICE(cpu), "SMP", 0);
         }
     }
 
-- 
2.41.0


