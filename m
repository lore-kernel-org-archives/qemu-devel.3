Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC522606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W8XAmCDy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35D-0004j2-99; Sat, 31 Oct 2026 03:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33q-00038f-7b
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33l-0002sH-7A
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTlL+uwCObdDN1YM7HnOgrejyMLfbi/5m5qKHNcwrz8=;
 b=W8XAmCDyghAgw0UuDzNMV3xM7GGDZ8PuVYL6Cd9DtyN0rPqMNtWUku48OLa4in+WCg+IJt
 dSWb3gCY2k+j8mQzsk9BLT/F7yYJvhwmLf13Rf42eOGG/IfoMnxUSSVK3Qqr3LHgtDNbzt
 90pc9PHNMjrWSXWfkfQqhdf5kmSfawc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-47aIEO3wOq2DzBCIwc9TFw-1; Sat,
 31 Oct 2026 02:59:19 -0400
X-MC-Unique: 47aIEO3wOq2DzBCIwc9TFw-1
X-Mimecast-MFC-AGG-ID: 47aIEO3wOq2DzBCIwc9TFw_1793429958
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6BC3195609E; Sat, 31 Oct 2026 06:59:18 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 416281800677; Sat, 31 Oct 2026 06:59:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/34] docs/system/arm/aspeed: Add AST1080 Platform Root of
 Trust evaluation board
Date: Sat, 31 Oct 2026 07:58:11 +0100
Message-ID: <20261031065823.191966-23-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update the Aspeed AST10x0 documentation to include the AST1080
evaluation board.

The documentation now describes:
- AST1080 as a Platform Root of Trust processor
- AST1080 Cortex-M4F CPU frequency running at 400 MHz

Also add the ast1080-evb machine entry to the supported AST10x0 SoC
based machine list.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 2d51ceeb8443..be74ee39fa16 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -441,8 +441,8 @@ Use ``tio`` or another terminal emulator to connect to the consoles:
    $ tio /dev/pts/57
 
 
-Aspeed Bridge IC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1040-evb``, ``ast1060-evb``)
-=======================================================================================================================
+Aspeed Bridge IC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1040-evb``, ``ast1060-evb``, ``ast1080-evb``)
+========================================================================================================================================
 
 The QEMU Aspeed machines model Bridge ICs and Platform Root of Trust processors
 of various Aspeed evaluation boards. They are based on different members of
@@ -451,9 +451,10 @@ the Aspeed AST10x0 SoC family:
 - AST1030 : Bridge IC
 - AST1040 : Bridge IC
 - AST1060 : Platform Root of Trust processor
+- AST1080 : Platform Root of Trust processor
 
 The AST1030 and AST1060 integrate an Arm Cortex-M4F CPU running at 200 MHz.
-The AST1040 integrates an Arm Cortex-M4F CPU running at 400 MHz.
+The AST1040 and AST1080 integrate an Arm Cortex-M4F CPU running at 400 MHz.
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
@@ -462,6 +463,7 @@ AST10x0 SoC based machines :
 - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)
 - ``ast1040-evb``          Aspeed AST1040 Evaluation board (Cortex-M4F)
 - ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)
+- ``ast1080-evb``          Aspeed AST1080 Evaluation board (Cortex-M4F)
 
 Supported devices
 -----------------
-- 
2.56.0


