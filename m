Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930A4C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNx-0002Jf-Tl; Tue, 11 Aug 2026 12:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNS-0000Qn-VG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNR-0000hh-Aw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/aHR2aX7Yht0pPy3X2g+G97Gsg17VR/tIqg918ZiZ8Y=;
 b=TR/hqlSTFxDbcaFN3y/CAdIXqISSvEkzqrLTT80NjhDKtwGtC3F72Bk7Z4Q1LNQ+qP29Uc
 BL/aMrgd5VRM89mfz7twTGyhxkgdrzAmsQ/Q9NQcJjfh9zLbO1xkpdWJ7yb+O7R2gf3Vwn
 r3hvaTTF+5cNwBMcWbbi+tBwmz1GUmc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-NHAFCp5cMliObNpaByxRkQ-1; Tue,
 11 Aug 2026 12:30:53 -0400
X-MC-Unique: NHAFCp5cMliObNpaByxRkQ-1
X-Mimecast-MFC-AGG-ID: NHAFCp5cMliObNpaByxRkQ_1786465852
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 367F91956063; Tue, 11 Aug 2026 16:30:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBAE9195DF96; Tue, 11 Aug 2026 16:30:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/83] hw/arm/aspeed: anacapa: use ASCII in comments
Date: Tue, 11 Aug 2026 18:28:47 +0200
Message-ID: <20260811162938.1403216-33-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The anacapa machine source contains a few comments using the U+2014 EM
DASH character. Replace them with plain ASCII hyphens so the file stays
ASCII-only.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260707091609.97759-8-emmanuel.blot@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_anacapa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index a1c8111a9344..bd6cc0068602 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -242,7 +242,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     /* &i2c1 */
     /* eeprom@50 */
     at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
-    /* i2c-mux@70 (PCA9546) — 4 channels, empty */
+    /* i2c-mux@70 (PCA9546) - 4 channels, empty */
     i2c_slave_create_simple(i2c[1], TYPE_PCA9546, 0x70);
 
     /* &i2c4 */
@@ -259,7 +259,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
-    /* adc128d818@1f — no model */
+    /* adc128d818@1f - no model */
     /* pca9555@22 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
@@ -305,7 +305,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     /* i2c-mux@71 (PCA9548) */
     i2c_mux = i2c_slave_create_simple(i2c[11], TYPE_PCA9548, 0x71);
 
-    /* i2c11mux ch0-ch4 — empty */
+    /* i2c11mux ch0-ch4 - empty */
 
     /* i2c11mux ch5 */
     /* pca9555@22 */
@@ -328,7 +328,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
                           hpm_brd_id_eeprom, hpm_brd_id_eeprom_len);
 
     /* i2c13mux ch7 */
-    /* nfc@28 — no model */
+    /* nfc@28 - no model */
 }
 
 static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
-- 
2.55.0


