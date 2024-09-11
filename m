Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A937EEE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOmg-0001My-8V; Wed, 11 Sep 2024 10:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhi-00070k-Be
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhX-0007Dd-73
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cW6rJsKhPMN4DAXnpRk9aJejhnXYOKSdkgv1oLepLKc=;
 b=UOzKZ/LkrVY2P0xxqap6GqTzzhVJfUEyCR5O9WnyYM/hYdutN79nbugmOSRosPxLBPcdiJ
 3aAY84fHcvs6idYVd+FJe2fgS4YMqoK1Oo90TD0WYRO1Yh4T6Lk+rvRixYSZqK6g71Mck1
 Wzt4GJFe36rDGTw545bhb3q1w5KDauU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-uku9yfBzMNqmtwfAvz6AZA-1; Wed, 11 Sep 2024 09:51:37 -0400
X-MC-Unique: uku9yfBzMNqmtwfAvz6AZA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c25c45afb2so4829182a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062695; x=1726667495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cW6rJsKhPMN4DAXnpRk9aJejhnXYOKSdkgv1oLepLKc=;
 b=U6edi+VD2seSGOTusjonRapM/ryDqo+ePL252+7kyZh5am2rv9KY9asmiCIPswb4Yj
 n+9acIwUU2+7dna2CGRgUlYYqd0iDYEGIKnKd7PgvrPXM/OC2F74ea0ViWHUlqi2bBRx
 j2GNnlKT09IwrOqSGfYAndUqXYzKneqkGJESZEHpJaNATMHus7IvCb7/WHI6G8uj78zf
 RCEybm+g2+LrZbvpXtrYqTi7YeZkKR4FP65Nw/NO2GcXlQDLMQ5D6rQ0X68FTzC23Ldo
 QDeB9r1tcTl3KGwABkHnX2oGE2g49ivTzKtbxKoWfkiKcLQpiQKGOM4pE5+F40pcx95G
 XtzA==
X-Gm-Message-State: AOJu0Ywhjg/IbJiikg4ThA+/m5Yttblo+beeTo5MeJtoEmyJReDiT1L9
 lyEPGNku6A3pTGYmpsSwNjBXTp8M0pSg5gPHwsg+BKBw4Cnyw/W1C7kasvsN9bGoTtXBAdYgEt1
 SYnBm7ZsA8LDs+jA2CY1PHzpC+zVD+AN+KSxukGSoQtkBXRENzHp6EbPVO8YIPBuFRrytP19Vuo
 5HZNt/FPQBt7Oggh64v48RE0mDza777A==
X-Received: by 2002:a17:907:7f10:b0:a8b:6ee7:ba25 with SMTP id
 a640c23a62f3a-a8ffadb0612mr405072366b.47.1726062695518; 
 Wed, 11 Sep 2024 06:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlSiPBnTtHcvdwGtlu9vE+aMb07EQGcKjwLV6c8rHV3ngBWdOtgs2ai/xRWXpg0D8Crxxr8w==
X-Received: by 2002:a17:907:7f10:b0:a8b:6ee7:ba25 with SMTP id
 a640c23a62f3a-a8ffadb0612mr405067566b.47.1726062694589; 
 Wed, 11 Sep 2024 06:51:34 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259c1fa3sm616631166b.80.2024.09.11.06.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:34 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 03/18] hw: Move declaration of IRQState to header and add init
 function
Message-ID: <e72a7f65c11565d2f216711588a4e767a1f6cd80.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

To allow embedding a qemu_irq in a struct move its definition to the
header and add a function to init it in place without allocating it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <e3ffd0f6ef8845d0f7247c9b6ff33f7ee8b432cf.1719690591.git.balaton@eik.bme.hu>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/hw/irq.h | 18 ++++++++++++++++++
 hw/core/irq.c    | 25 +++++++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/hw/irq.h b/include/hw/irq.h
index 645b73d251..c861c1debd 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -1,9 +1,20 @@
 #ifndef QEMU_IRQ_H
 #define QEMU_IRQ_H
 
+#include "qom/object.h"
+
 /* Generic IRQ/GPIO pin infrastructure.  */
 
 #define TYPE_IRQ "irq"
+OBJECT_DECLARE_SIMPLE_TYPE(IRQState, IRQ)
+
+struct IRQState {
+    Object parent_obj;
+
+    qemu_irq_handler handler;
+    void *opaque;
+    int n;
+};
 
 void qemu_set_irq(qemu_irq irq, int level);
 
@@ -23,6 +34,13 @@ static inline void qemu_irq_pulse(qemu_irq irq)
     qemu_set_irq(irq, 0);
 }
 
+/*
+ * Init a single IRQ. The irq is assigned with a handler, an opaque data
+ * and the interrupt number.
+ */
+void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
+                   int n);
+
 /* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
  * opaque data.
  */
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 3f14e2dda7..db95ffc18f 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -26,16 +26,6 @@
 #include "hw/irq.h"
 #include "qom/object.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(IRQState, IRQ)
-
-struct IRQState {
-    Object parent_obj;
-
-    qemu_irq_handler handler;
-    void *opaque;
-    int n;
-};
-
 void qemu_set_irq(qemu_irq irq, int level)
 {
     if (!irq)
@@ -44,6 +34,15 @@ void qemu_set_irq(qemu_irq irq, int level)
     irq->handler(irq->opaque, irq->n, level);
 }
 
+void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
+                   int n)
+{
+    object_initialize(irq, sizeof(*irq), TYPE_IRQ);
+    irq->handler = handler;
+    irq->opaque = opaque;
+    irq->n = n;
+}
+
 qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
                            void *opaque, int n)
 {
@@ -69,10 +68,8 @@ qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
 {
     IRQState *irq;
 
-    irq = IRQ(object_new(TYPE_IRQ));
-    irq->handler = handler;
-    irq->opaque = opaque;
-    irq->n = n;
+    irq = g_new(IRQState, 1);
+    qemu_init_irq(irq, handler, opaque, n);
 
     return irq;
 }
-- 
MST


