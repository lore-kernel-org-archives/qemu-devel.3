Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D18BC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrnw-0000BO-N9; Mon, 22 Jul 2024 08:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnc-0007EU-Di
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrna-0007uT-O9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hr9BZw+jnnZPYCHU7IVnZQe9pLLjGhNrmHmaZ/LVdfI=;
 b=gLdZQvWbecFbGorIotlQL1pRYFpamDByWWeyk52Njdvm4LR0SQSEuAXuksagkVtL90945+
 yi08lYpD4H1Ko3Lr1ytszObzj74RXDovvh6qjBCQODlU5TyIqAwaDIvtJsoTwnIrcJ0WuQ
 2y18Ocb/Be+xmkcNCdNOlVt87J93mds=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-d_qA2aW8N4OR17xMRZsxGw-1; Mon, 22 Jul 2024 08:05:47 -0400
X-MC-Unique: d_qA2aW8N4OR17xMRZsxGw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a534faa028so1152634a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649945; x=1722254745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr9BZw+jnnZPYCHU7IVnZQe9pLLjGhNrmHmaZ/LVdfI=;
 b=QHPh/P3MYVVzZ2Yz7HHOu6r5M/LwS+yGm/5Dna6wm2S8GB2Xr38U3u4lxfA2ITePiN
 Uv6akOD68mlPJyxoA47dzWhFJuU9qIdDjJcyOAa8bD0kbMBuU7jZsFv9JvzLgDq2FzD6
 GQg7HTiXENtPrWjp64Hv4Cf0d9vpZIsEWWdIphR0OYvNXUYFr9m6vYa5WfAzD8cBbHL5
 vB/WCFL/IdLN9Wsuxexr8GedfuArZ/DzTAQq3vJ2Eg1YRnFezLKhzEC2d5jiTiSz+gjT
 avrLhA042kFpI5qi5klid4DDjlZ0Pu0nbIspXcJxRvKbAyU4Qia+gmnWVkxoKBib2Eum
 a19Q==
X-Gm-Message-State: AOJu0YwF5HkFkluOJYJV4ieXJeIh0uphiNE6dpcjFMGXyl0myFg8KBC8
 5k3WdKdLT5HLXHadP/JZv57ERycEr+Kfl1roGMQ545M+IaDtgffE79iS+kAjX7N8OcSiAZ2f+OP
 E/TTHMv08rAMzkmKc874q/+xx6d3p86EBWMqnHruwmYE/br+QA0YaCGWBIpSY7Xb1aJkl27nQea
 dG3hxQA0JGzIGRdsnJAgmyqXBmZs8eA7KFLU4O
X-Received: by 2002:a05:6402:528c:b0:5a2:2101:a714 with SMTP id
 4fb4d7f45d1cf-5a479677407mr4553581a12.25.1721649945464; 
 Mon, 22 Jul 2024 05:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbqMKdZok4oCArQguPXMHY6YVtFE2C/Fsb3safFTXF0BzX6kzfMu53c826j63Kx+abDUY6qw==
X-Received: by 2002:a05:6402:528c:b0:5a2:2101:a714 with SMTP id
 4fb4d7f45d1cf-5a479677407mr4553568a12.25.1721649944869; 
 Mon, 22 Jul 2024 05:05:44 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c3f0673sm5985630a12.61.2024.07.22.05.05.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] hpet: fix and cleanup persistence of interrupt status
Date: Mon, 22 Jul 2024 14:05:35 +0200
Message-ID: <20240722120541.70790-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722120541.70790-1-pbonzini@redhat.com>
References: <20240722120541.70790-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are several bugs in the handling of the ISR register:

- switching level->edge was not lowering the interrupt and
  clearing ISR

- switching on the enable bit was not raising a level-triggered
  interrupt if the timer had fired

- the timer must be kept running even if not enabled, in
  order to set the ISR flag, so writes to HPET_TN_CFG must
  not call hpet_del_timer()

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 60 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 4cb5393c0b5..58073df02b5 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -196,21 +196,31 @@ static void update_irq(struct HPETTimer *timer, int set)
     }
     s = timer->state;
     mask = 1 << timer->tn;
-    if (!set || !timer_enabled(timer) || !hpet_enabled(timer->state)) {
+
+    if (set && (timer->config & HPET_TN_TYPE_LEVEL)) {
+        /*
+         * If HPET_TN_ENABLE bit is 0, "the timer will still operate and
+         * generate appropriate status bits, but will not cause an interrupt"
+         */
+        s->isr |= mask;
+    } else {
         s->isr &= ~mask;
+    }
+
+    if (set && timer_enabled(timer) && hpet_enabled(s)) {
+        if (timer_fsb_route(timer)) {
+            address_space_stl_le(&address_space_memory, timer->fsb >> 32,
+                                 timer->fsb & 0xffffffff, MEMTXATTRS_UNSPECIFIED,
+                                 NULL);
+        } else if (timer->config & HPET_TN_TYPE_LEVEL) {
+            qemu_irq_raise(s->irqs[route]);
+        } else {
+            qemu_irq_pulse(s->irqs[route]);
+        }
+    } else {
         if (!timer_fsb_route(timer)) {
             qemu_irq_lower(s->irqs[route]);
         }
-    } else if (timer_fsb_route(timer)) {
-        address_space_stl_le(&address_space_memory, timer->fsb >> 32,
-                             timer->fsb & 0xffffffff, MEMTXATTRS_UNSPECIFIED,
-                             NULL);
-    } else if (timer->config & HPET_TN_TYPE_LEVEL) {
-        s->isr |= mask;
-        qemu_irq_raise(s->irqs[route]);
-    } else {
-        s->isr &= ~mask;
-        qemu_irq_pulse(s->irqs[route]);
     }
 }
 
@@ -414,8 +424,13 @@ static void hpet_set_timer(HPETTimer *t)
 
 static void hpet_del_timer(HPETTimer *t)
 {
+    HPETState *s = t->state;
     timer_del(t->qemu_timer);
-    update_irq(t, 0);
+
+    if (s->isr & (1 << t->tn)) {
+        /* For level-triggered interrupt, this leaves ISR set but lowers irq.  */
+        update_irq(t, 1);
+    }
 }
 
 static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
@@ -515,20 +530,26 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         switch ((addr - 0x100) % 0x20) {
         case HPET_TN_CFG:
             trace_hpet_ram_write_tn_cfg();
-            if (activating_bit(old_val, new_val, HPET_TN_FSB_ENABLE)) {
+            if (deactivating_bit(old_val, new_val, HPET_TN_TYPE_LEVEL)) {
+                /*
+                 * Do this before changing timer->config; otherwise, if
+                 * HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
+                 */
                 update_irq(timer, 0);
             }
             val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
             timer->config = (timer->config & 0xffffffff00000000ULL) | val;
+            if (activating_bit(old_val, new_val, HPET_TN_ENABLE)
+                && (s->isr & (1 << timer_id))) {
+                update_irq(timer, 1);
+            }
+
             if (new_val & HPET_TN_32BIT) {
                 timer->cmp = (uint32_t)timer->cmp;
                 timer->period = (uint32_t)timer->period;
             }
-            if (activating_bit(old_val, new_val, HPET_TN_ENABLE) &&
-                hpet_enabled(s)) {
+            if (hpet_enabled(s)) {
                 hpet_set_timer(timer);
-            } else if (deactivating_bit(old_val, new_val, HPET_TN_ENABLE)) {
-                hpet_del_timer(timer);
             }
             break;
         case HPET_TN_CFG + 4: // Interrupt capabilities
@@ -606,9 +627,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 s->hpet_offset =
                     ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
                 for (i = 0; i < s->num_timers; i++) {
-                    if ((&s->timer[i])->cmp != ~0ULL) {
-                        hpet_set_timer(&s->timer[i]);
+                    if (timer_enabled(&s->timer[i]) && (s->isr & (1 << i))) {
+                        update_irq(&s->timer[i], 1);
                     }
+                    hpet_set_timer(&s->timer[i]);
                 }
             } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Halt main counter and disable interrupt generation. */
-- 
2.45.2


