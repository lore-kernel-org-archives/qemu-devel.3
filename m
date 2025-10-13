Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24ADCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvv-0005CB-FP; Mon, 13 Oct 2025 08:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvr-00057b-LV
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvc-0008El-FG
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eks63TMjKZKNnjepbaN7iti9g+iM+e9hGfP8R2I3juY=;
 b=cfBm/GdnQhI7iondbnmswDuSxbBLlY5IahowLj9acYGNCMitMjl26aswQcdZ+QcEKWQdXY
 Fmhp3Vzitxuypv3C36DPcq6AyO/jL+6kRhUaC1JI6ngb9oPeZJWEsTYYt3RDZeEiuvWkCh
 mxcnCttsbY3aHYiSLR1+XAeSYqiOtLE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-UmJ2drRZORiVqPhHhNeLhQ-1; Mon,
 13 Oct 2025 08:45:23 -0400
X-MC-Unique: UmJ2drRZORiVqPhHhNeLhQ-1
X-Mimecast-MFC-AGG-ID: UmJ2drRZORiVqPhHhNeLhQ_1760359522
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 824B41956096; Mon, 13 Oct 2025 12:45:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FD2D180047F; Mon, 13 Oct 2025 12:45:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/29] hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style
Date: Mon, 13 Oct 2025 14:44:20 +0200
Message-ID: <20251013124421.71977-30-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Fix coding style warnings in aspeed_ast27x0-ssp.c and aspeed_ast27x0-tsp.c
reported by checkpatch.pl regarding line length exceeding 80 characters.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-17-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 3 ++-
 hw/arm/aspeed_ast27x0-tsp.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index d27be8b92558..936c7c72e8f7 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -263,7 +263,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
 
-static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *data)
+static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 7f109101fe44..9318f8c86c51 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -263,7 +263,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
 
-static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *data)
+static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
-- 
2.51.0


