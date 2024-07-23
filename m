Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E672C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJK-0005pB-7h; Tue, 23 Jul 2024 10:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ6-0004n1-BL
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ4-0007Cf-GD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SH5zwolTSCtrBQQLhcJsS5itYtwTMNlK41Ys5KgMIiY=;
 b=U3wU4ZYFLyhz4Wespq0Y5VKIr6vRXRVq/frBwNV8Rds9xeOIKJ9Bda7pgopIveHb3phgny
 ZJTRODG2nEQmJtZjgyKK8rJM23I58Fj6TBlxLdq1Z5eOnBOc5Rfd3DISyHhd25WRji1s9C
 5G/z8YWm4y3tMf1nMZZUriVDFvMl5HA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-QP2sPeAlPYG5L11ZrGhasw-1; Tue, 23 Jul 2024 10:15:55 -0400
X-MC-Unique: QP2sPeAlPYG5L11ZrGhasw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42660bca669so37990285e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744154; x=1722348954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SH5zwolTSCtrBQQLhcJsS5itYtwTMNlK41Ys5KgMIiY=;
 b=wDf0u4IzsppdHRZ/tBdjHPO4kxdK27VlAkvxam9EkmgguYUVh3tHhsAUtajoJD82X5
 aBN0d6F+MX8tIowJp5GLc6efUurgGXe+X8P5LfksxQ+57496AE5lc8iTy2mYMaWvSJUp
 DkJK8cBh5+enhsigpHJJhD0hLrLb0Sm6153RYrfOvFjiCxsgGRR8LA8175nqIOI1KcGE
 nCU37pcjiwry6e4603dzkC70xg17a5wKhjWcd4C/PWtjjPzTnpNhQ93IJz6/mFFGwVGp
 4iLAAL5RW2UoLGbGroOeNM60ruXWrq8s+qcwjWsGTI914yPICSbFounW/ISVQAfml0yi
 D9nw==
X-Gm-Message-State: AOJu0Yxu4tcnny8wQc74osTY9Nz/w3iVbF1AVjTUffNnO7B/KjL/8vPr
 kFQHV/K4zaUywxhx7/NLhEsfWKqoggJewhxCY/mfcB0IaiSOzrK5UayaUlFSho1Dsh20+Hybnr/
 UsAomI3HigqhMX4rIboCKcFsR7Ot+vD2hq81OHzhb+0Ist+i8kNrNW7UyDvtxsliTy2UhsQPsk+
 1et2o6U0ze+s5dH/DOf/YtO4N8h7JXRQDgI5qZ
X-Received: by 2002:a05:600c:4f0d:b0:426:5ee5:3129 with SMTP id
 5b1f17b1804b1-427dc515367mr69171435e9.2.1721744153773; 
 Tue, 23 Jul 2024 07:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNOp9d6hFP+NpQkNTRYrKZVdTtf3UQ/unBSjrGHXaiLoEkZb6Lmaz0CmtgiyEXACIChg3xZg==
X-Received: by 2002:a05:600c:4f0d:b0:426:5ee5:3129 with SMTP id
 5b1f17b1804b1-427dc515367mr69171335e9.2.1721744153444; 
 Tue, 23 Jul 2024 07:15:53 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ec6e5sm11638830f8f.96.2024.07.23.07.15.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] hpet: place read-only bits directly in "new_val"
Date: Tue, 23 Jul 2024 16:15:26 +0200
Message-ID: <20240723141529.551737-9-pbonzini@redhat.com>
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

The variable "val" is used for two different purposes.  As an intermediate
value when writing configuration registers, and to store the cleared bits
when writing ISR.

Use "new_val" for the former, and rename the variable so that it is clearer
for the latter case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 380e272fbeb..831e5a95b09 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -510,7 +510,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
 {
     int i;
     HPETState *s = opaque;
-    uint64_t old_val, new_val, val;
+    uint64_t old_val, new_val, cleared;
 
     trace_hpet_ram_write(addr, value);
     old_val = hpet_ram_read(opaque, addr, 4);
@@ -536,13 +536,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  */
                 update_irq(timer, 0);
             }
-            val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
-            timer->config = (timer->config & 0xffffffff00000000ULL) | val;
+            new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
+            timer->config = (timer->config & 0xffffffff00000000ULL) | new_val;
             if (activating_bit(old_val, new_val, HPET_TN_ENABLE)
                 && (s->isr & (1 << timer_id))) {
                 update_irq(timer, 1);
             }
-
             if (new_val & HPET_TN_32BIT) {
                 timer->cmp = (uint32_t)timer->cmp;
                 timer->period = (uint32_t)timer->period;
@@ -623,8 +622,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         case HPET_ID:
             return;
         case HPET_CFG:
-            val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-            s->config = (s->config & 0xffffffff00000000ULL) | val;
+            new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+            s->config = (s->config & 0xffffffff00000000ULL) | new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
                 s->hpet_offset =
@@ -658,9 +657,9 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             trace_hpet_invalid_hpet_cfg(4);
             break;
         case HPET_STATUS:
-            val = new_val & s->isr;
+            cleared = new_val & s->isr;
             for (i = 0; i < s->num_timers; i++) {
-                if (val & (1 << i)) {
+                if (cleared & (1 << i)) {
                     update_irq(&s->timer[i], 0);
                 }
             }
-- 
2.45.2


