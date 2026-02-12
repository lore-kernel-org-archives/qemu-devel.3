Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF3AEEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQG-0008Fu-Fo; Thu, 12 Feb 2026 16:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQF-0008Eo-8U
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQC-00069H-DF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7daCPthEvukOKqoj7V83sQ59GzRjxo+F8BXF3X8WYOY=;
 b=R14Dj1cSp2wU2K+Fl5pCw+kgt6Ur3IZALjUZgCg1z63JZv1mp+RMHwfUCM9ShZxZ7cRv6U
 tNYuWYWZ7I7ViYotjriKL9di0/RwXOljuyzPIFvcpJK/9VZG2s1I6R7oNM+9qCuhXGqdF3
 0i0i56+hY8CBMza/IonB/FPjPw8IGFc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-8cH66wJuOzWOspMVOckCeg-1; Thu,
 12 Feb 2026 16:40:22 -0500
X-MC-Unique: 8cH66wJuOzWOspMVOckCeg-1
X-Mimecast-MFC-AGG-ID: 8cH66wJuOzWOspMVOckCeg_1770932421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F3111800473; Thu, 12 Feb 2026 21:40:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 850F8180035A; Thu, 12 Feb 2026 21:40:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/16] hw/arm/aspeed_ast27x0_evb: Move ast2700-evb alias to
 AST2700 A2 EVB
Date: Thu, 12 Feb 2026 22:39:49 +0100
Message-ID: <20260212213955.2225662-11-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make AST2700 A2 EVB the default ast2700-evb machine.

The "ast2700-evb" machine alias is moved from the AST2700 A1 EVB
to the AST2700 A2 EVB, making A2 the default evaluation board
for AST2700.

This ensures that users selecting "ast2700-evb" will run on the
latest AST2700 silicon revision. The AST2700 A1 EVB machine
remains available explicitly as "ast2700a1-evb".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0_evb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 32d944848ed0..0ff1bebeb0ed 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -34,7 +34,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
-    mc->alias = "ast2700-evb";
     mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a1";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
@@ -56,6 +55,7 @@ static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
+    mc->alias = "ast2700-evb";
     mc->desc = "Aspeed AST2700 A2 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a2";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
-- 
2.53.0


