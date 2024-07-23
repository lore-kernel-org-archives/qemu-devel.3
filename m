Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDCBC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJ5-0004gv-4L; Tue, 23 Jul 2024 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ2-0004Vt-S0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ0-00079K-3P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hr9BZw+jnnZPYCHU7IVnZQe9pLLjGhNrmHmaZ/LVdfI=;
 b=KqfH5u4h6YB1D3P8hgRejRkraFhwEzS56DVhOqZjNVMxGmB8qObMQpHYqLuTP1nUhrHwy0
 0AN80eGF0LHb5RMNPvteD8HEwiPNEMeoWVAe3+HbrUoaBOwUrkht+kb6q925Yj6eqp/Htc
 /okqjtddx3NGrGTeTj+Xy7R4PLVwAs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-EzBQE5EGNDuaci7VYFtvPQ-1; Tue, 23 Jul 2024 10:15:47 -0400
X-MC-Unique: EzBQE5EGNDuaci7VYFtvPQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42674318a4eso57134055e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744146; x=1722348946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr9BZw+jnnZPYCHU7IVnZQe9pLLjGhNrmHmaZ/LVdfI=;
 b=CgTGTMM75JAMWqZlX3KvMlwNRT5a+5sD3ssQC/M1m7BYvjZcoXKzqef5COlT4+RURm
 suemyRtDYD9fycRmnKv5opb0IMkUqfAIidVuL6TMSkJAHcu8Dvi+MclavMRLyD/WTlzj
 rtDbjTKex02D1qH8KVJPh1OVT52+IDkZlzair4co7RWp8Y3xYoMC9NRUQNDJYQCL9Bxc
 fZfTTg6rFUkzPWgDYoE7IIUMsX2st/0J68N3lxzLgNsYgqcCKLt3iPMR0r6zGmnJLAGB
 v36rMkkkpiVqg3ptiTk3CJExpaeYL1NaMd39wH+UtmwhecwbrkGD488Lk9CzD1A22dRX
 P2BQ==
X-Gm-Message-State: AOJu0YzQpF6Wo2cxy1958oGqsnaKpm/U2CSKwkMNDBeK/NWer+nx89Jy
 bOJiqWeWYQ2m/KnJ75UPXchjs8fMnmYUJb6oWwSFROXrPYv+yO+bWUzQofjV0sNr/y4Qtv6H3D0
 H9Gm41Wo5decEf9QAwtIOBJLDweYZyeYnZhX1cVaLYaKIKNQkEaho2mZ4AMu51uEHZrPPKFWRW8
 hNAraNogG4fiYJEMR3FCbNsjVUQ+gJqoW/YXoe
X-Received: by 2002:a5d:4005:0:b0:367:9c46:198 with SMTP id
 ffacd0b85a97d-369bae3a8b6mr8700755f8f.1.1721744146307; 
 Tue, 23 Jul 2024 07:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHaENQtffzWAnK/R1Mi7TVGE5ArkofLyJk7cc2MVrvetHi/JxCaVvbdrCIQ+cGDFJUPwXQEg==
X-Received: by 2002:a5d:4005:0:b0:367:9c46:198 with SMTP id
 ffacd0b85a97d-369bae3a8b6mr8700722f8f.1.1721744145762; 
 Tue, 23 Jul 2024 07:15:45 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa394sm174019995e9.3.2024.07.23.07.15.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] hpet: fix and cleanup persistence of interrupt status
Date: Tue, 23 Jul 2024 16:15:23 +0200
Message-ID: <20240723141529.551737-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
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


