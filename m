Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A33C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP0-0003od-Vp; Sun, 06 Sep 2026 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOt-0003iW-P0
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOs-0000DT-8P
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhhRojtCLquyEdR39ln9M4wQgQukIGzjOQwib1lmHts=;
 b=XoBqPK6izg3WDjjCsHMg4a/Ut0kNzdLMax9Nd5pjnAManZHne9uyA06YgGK/gUdLXaU0gi
 OQlTHKgtvkbnQZzzuSPsYH5kkoQyP/A2YqYYyVKuPIx1tDfPg7niQjk3YEgspSKFECma0E
 2bHne5kCDsghk614h/s7Zu1V7yx3IQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-W9QwS-JnOti-PBWBS-omUg-1; Sun,
 06 Sep 2026 13:11:23 -0400
X-MC-Unique: W9QwS-JnOti-PBWBS-omUg-1
X-Mimecast-MFC-AGG-ID: W9QwS-JnOti-PBWBS-omUg_1788714683
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E146A18011EC; Sun,  6 Sep 2026 17:11:22 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 806991955F06; Sun,  6 Sep 2026 17:11:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/40] hw/sensor: tmp105: name the parent object field
 parent_obj
Date: Sun,  6 Sep 2026 19:10:07 +0200
Message-ID: <20260906171021.26568-27-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

QEMU coding conventions expect the embedded parent object of a QOM type
to be named parent_obj. Rename the TMP105State I2CSlave member
accordingly and update its references; the change is purely cosmetic.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-2-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sensor/tmp105.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 6069c0905d91..aabeb34f0837 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -42,7 +42,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
  */
 struct TMP105State {
     /*< private >*/
-    I2CSlave i2c;
+    I2CSlave parent_obj;
     /*< public >*/
 
     uint8_t len;
@@ -187,12 +187,12 @@ static void tmp105_read(TMP105State *s)
         break;
     }
 
-    trace_tmp105_read(s->i2c.address, s->pointer);
+    trace_tmp105_read(s->parent_obj.address, s->pointer);
 }
 
 static void tmp105_write(TMP105State *s)
 {
-    trace_tmp105_write(s->i2c.address, s->pointer);
+    trace_tmp105_write(s->parent_obj.address, s->pointer);
 
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
@@ -200,7 +200,7 @@ static void tmp105_write(TMP105State *s)
 
     case TMP105_REG_CONFIG:
         if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
-            trace_tmp105_write_shutdown(s->i2c.address);
+            trace_tmp105_write_shutdown(s->parent_obj.address);
         }
         s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
@@ -305,7 +305,7 @@ static const VMStateDescription vmstate_tmp105 = {
         VMSTATE_INT16(temperature, TMP105State),
         VMSTATE_INT16_ARRAY(limit, TMP105State, 2),
         VMSTATE_UINT8(alarm, TMP105State),
-        VMSTATE_I2C_SLAVE(i2c, TMP105State),
+        VMSTATE_I2C_SLAVE(parent_obj, TMP105State),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -338,7 +338,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
 
-    tmp105_reset(&s->i2c);
+    tmp105_reset(&s->parent_obj);
 }
 
 static void tmp105_initfn(Object *obj)
-- 
2.55.0


