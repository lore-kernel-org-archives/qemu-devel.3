Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DE606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ne0Wrxbd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35B-0004Xc-5f; Sat, 31 Oct 2026 03:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33l-00037z-U9
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33e-0002rF-Fr
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iS/QYmO1rtFw2lyxwAODrENg58ePUzkUKcEiGKRS2bo=;
 b=Ne0Wrxbd2Pv5L1x9J8Cus0gXo78fmgqBP1TATqzgx5uG/rdXXAeGLtDnBGa6chYPvhUHrG
 jH0IXq778b1k/2HDj97wXG87xwQ5OFox51NyGBEIDmJDxZdE6R6UsMIafLfLvfrDCHT4sj
 QHcg7RcUsrvGH5ZORimdR65W/93W/Yw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-UvZEhcKXOLWfXN0r1uXrCw-1; Sat,
 31 Oct 2026 02:59:14 -0400
X-MC-Unique: UvZEhcKXOLWfXN0r1uXrCw-1
X-Mimecast-MFC-AGG-ID: UvZEhcKXOLWfXN0r1uXrCw_1793429953
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17A7E1800365; Sat, 31 Oct 2026 06:59:13 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A69051800765; Sat, 31 Oct 2026 06:59:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/34] hw/arm/aspeed_ast1040: Add AST1080 I2C filter as an
 unimplemented device
Date: Sat, 31 Oct 2026 07:58:08 +0100
Message-ID: <20261031065823.191966-20-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST1080 provides an SMBus Filter Controller (I2C filter) at
0x74c14000, but the controller is not modeled yet.

This controller is only available on the AST1080. The AST1040 does not
have it, so it is added to the AST1080 specific init and realize
functions instead of the common AST10x0 G2 ones.

Add the register region as an unimplemented device to reflect the
AST1080 memory map.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index e5c8d15dcbfa..56ef6b1268c4 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -102,6 +102,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040_unimp_devs[] = {
 };
 
 static const UnimplementedDeviceConfig aspeed_soc_ast1080_unimp_devs[] = {
+    { "i2c-filter", "aspeed.i2c-filter", 0x74C14000, 0x1000, -1000 },
     { "spim0", "aspeed.spim0", 0x74C15000, 0x1000, -1000 },
     { "spim1", "aspeed.spim1", 0x74C16000, 0x1000, -1000 },
     { "spim2", "aspeed.spim2", 0x74C17000, 0x1000, -1000 },
-- 
2.56.0


