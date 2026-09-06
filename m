Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4D4C79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOq-0003h6-Nj; Sun, 06 Sep 2026 13:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOb-0003cU-9l
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOZ-00008d-Hg
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNTr1qNCE6jZQzSU89dpdX4vjNmRkzzji1cy5FhKr/Y=;
 b=GW1wOD9ZZRd6tMnX9/3uX+DNGevQd0GteTKLS2WWXcEr6mEoLUcyqU27UGnmbxpzTiJhVg
 YC5EIy1f88IX+KNJD8eloFIwzz+1sMbVTbH/e/3z/xmnmBLfFO6B5ktwwSbxNM1jnr1R8K
 t4+4NmaINS7U474YRaSC79jPQwe3xoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-yt53WO-JNhCYYNd5bZcuRw-1; Sun,
 06 Sep 2026 13:11:04 -0400
X-MC-Unique: yt53WO-JNhCYYNd5bZcuRw-1
X-Mimecast-MFC-AGG-ID: yt53WO-JNhCYYNd5bZcuRw_1788714663
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9234418001E6; Sun,  6 Sep 2026 17:11:03 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC2C01955F06; Sun,  6 Sep 2026 17:11:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/40] hw/arm/aspeed_ast10x0: Remove obsolete unimplemented SBC
 mapping
Date: Sun,  6 Sep 2026 19:09:57 +0200
Message-ID: <20260906171021.26568-17-clg@redhat.com>
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST10x0 SoC now implements the SBC device model. However, the
old unimplemented SBC mapping was left in place.

Remove the obsolete mapping now that the SBC device is implemented.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 1 -
 hw/arm/aspeed_ast10x0.c     | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 8d80f1670587..cba8b7cdca58 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -92,7 +92,6 @@ struct AspeedSoCState {
     AspeedSBCState sbc;
     AspeedSLIState sli;
     AspeedSLIState sliio;
-    UnimplementedDeviceState sbc_unimplemented;
     AspeedSDMCState sdmc;
     AspeedPWMState pwm;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 93c81195b56a..5165dcce5912 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -163,8 +163,6 @@ static void aspeed_soc_ast10x0_init(Object *obj, const char *socname)
     object_initialize_child(obj, "hace", &s->hace, typename);
 
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "sbc-unimplemented", &s->sbc_unimplemented,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
@@ -222,11 +220,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
                                   "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
-    aspeed_mmio_map_unimplemented(s->memory,
-                                  SYS_BUS_DEVICE(&s->sbc_unimplemented),
-                                  "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC],
-                                  0x40000);
-
     /* AST10x0 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
-- 
2.55.0


