Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D34C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 16:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdVrW-0007PA-6r; Sat, 27 Jun 2026 12:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wdVrU-0007Oc-JJ
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 12:26:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wdVrS-0003Qb-NC
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 12:26:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-46f021665c4so123841f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782577588; x=1783182388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OMspnRaD39QB8C2nEdR/tLSw0wI9HyWZuChDsXVONYk=;
 b=SUWvxyJOg6gTgDWlMIYHH5Spi9mMkd4Jg6TeZn+JJQXUgshYfermtlgAp1tGAe7Pya
 ln3OL22IZ2nr0+3bhML0SNakvHITOJKqWHetZPcRPFLk2EjDQd53W+gs+kejxsdXLk1J
 S8yyULa7M/z3OFh5rjDYgAcRsAQtL8WwDgWnyKp74T2eO2RBRj3o98WBU6OzEHPa7Bn+
 kSVSMzxKqsPn8YWD3CO9S7ZWjEsHD4VNBTFlvoqDzAHRaod6uZaWQdTVln6O7To4spl+
 ujDYuk+Lwe3R9voizj/0jJjHmIvNh6fC/3Q2kLzb7SfuKrzQtZj6lfhAG2pZtRRHvspe
 goVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782577588; x=1783182388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMspnRaD39QB8C2nEdR/tLSw0wI9HyWZuChDsXVONYk=;
 b=izOOqqbsolNBA6S9k1oaF4Apx/XDqgFw2/9TMdLJJGoTV/XlHego1WI41rX0u5OSn8
 J2oV1G18Tc+VRd7ND3+japcYPtIRW+UqI1L5pu01egIdzLNYkW3Dw/FSFMAtcnPpCHTn
 MGmqWmDbAGeyDaWVN3sMRK7TFH0WqkHGW+wX6vs3QSDQ4Floxkot6/gkoOOugsyp5HDg
 On+qpeBCoJbZ1BZtSKGuO+oofY8V+KpdrSnMkn3P5syYraZSZBdx0/JQYk8DSeOPl+M1
 G3xZnT2B45kRxF4JahQjcGR8NLkVCUpJabBbbJveEE74HWhEWX5YadL7s+tc0bVw3c7n
 frSg==
X-Gm-Message-State: AOJu0YxyJ2MFBmubQxz9DRGrBnPD+e5H9VwhOg/LQvf+b1ZYxJt5Uv71
 0Msv3p+CH/waY9JiEC7aKcs+4Z7ORJ4/hCiQQ+FYCQctaV1Ktj0Yapja
X-Gm-Gg: AfdE7ckGiT3hU6gXLO2HICUteKrB03uAm5OfNpxDXFN0VkLgMyQYI5LbPfgRylngtwJ
 emEBK6Fv45293j3DAAcueh5yrQXTWu2MlaA/SUIi2zx/vbumb1tuZN3yhu2QI11LX2XX25tiGFt
 JhmfnA60/nAaetYBc2zfK8IsUyNLS9TCIW4Ht0KZ4/xu5Kjas5ChCltrhKv9Gh5FSblc6HGDI0q
 nXryPBP3LlRY6dKNxFdHfrqi+N/whhYVlvnXK4eqdysMbYfrX1XU1Bl+cz4t6YjD63ttBU6O77B
 6Q8Ty/8GMiHreaUnMMAwE0603Pdz17ozIYdXNPEYP+7QQhYjt5vWwJ0q2LPCGOrTfx74+ONvaWy
 o04eTPJ0IFWy5fq3nLfjwP8OzRrX8PB6QCvPsLi8m7I7wqkjYIUBZ6WDmVIyEErRVCsgFoLuObh
 kGGyWOckQfEA==
X-Received: by 2002:a05:600c:a00c:b0:492:6e72:eee with SMTP id
 5b1f17b1804b1-4926e720f83mr51334535e9.3.1782577588499; 
 Sat, 27 Jun 2026 09:26:28 -0700 (PDT)
Received: from AtiePC ([79.117.54.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fd9f2esm151032345e9.5.2026.06.27.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 09:26:28 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: danielpaziyski@gmail.com,
	mst@redhat.com,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3] hw/intc/apic: mask LVTs when software disabling the APIC
Date: Sat, 27 Jun 2026 18:26:23 +0200
Message-ID: <20260627162623.57385-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the Intel SDM Vol. 3 and the AMD64 Programmer's Manual Vol. 2, when
the APIC is software disabled, doing so by clearing the software enable bit from
the spurious interrupt register, the LVT entries must then have their mask bit
set, and any attempts to clear them must be ignored until the APIC is software
enabled again. This patch implements that behavior.

Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
v3:
 - Ported to the latest revision.
 - Link to v2: https://patchew.org/QEMU/20260420173816.63673-1-danielpaziyski@gmail.com/

v2:
 - Be consistent with the rest of the code, and mask the LVTs before
   calling apic_update_irq.
 - Link to v1: https://patchew.org/QEMU/20260225180555.154428-1-danielpaziyski@gmail.com/

 hw/intc/apic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 74e25c6..558c68a 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -928,6 +928,13 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
+static void apic_mask_lvts(APICCommonState *s)
+{
+    for (int i = 0; i < APIC_LVT_NB; i++) {
+        s->lvt[i] |= APIC_LVT_MASKED;
+    }
+}
+
 static int apic_register_write(APICCommonState *s, int index, uint64_t val)
 {
     trace_apic_register_write(index, val);
@@ -972,6 +979,11 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
         break;
     case 0x0f:
         s->spurious_vec = val & 0x1ff;
+
+        if (!(val & APIC_SV_ENABLE)) {
+            apic_mask_lvts(s);
+        }
+
         apic_update_irq(s);
         break;
     case 0x10 ... 0x17:
@@ -1006,6 +1018,9 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
         {
             int n = index - 0x32;
             s->lvt[n] = val;
+            if (!(s->spurious_vec & APIC_SV_ENABLE)) {
+                s->lvt[n] |= APIC_LVT_MASKED;
+            }
             if (n == APIC_LVT_TIMER) {
                 apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
             } else if (n == APIC_LVT_LINT0 && apic_check_pic(s)) {
-- 
2.54.0


