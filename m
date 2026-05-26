Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5815CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0l-0005UN-7i; Tue, 26 May 2026 04:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0b-0005RU-M9
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0Z-0007lA-Jo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyaVP63uw41aQRZ1cguSKQ8Eh0uX5EWMSBBwc7dF8BQ=;
 b=CaYcOBLBtid88wh+zXPQxLFZM1ZCVABuFCknREyKSyTxkjKOMWmf+dXrDu+/pXij5fOjbo
 +DELR44naJHkjRnC/MhRm6FUVY91S9UkNqMrL8Qq2hzYyUvHl9ekHMhKZ5uAP7ZApfjEOU
 es3W2yi+CL3AHsfsAzKCsFF5B+34t0k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-W7jRnSlzPu-pzaj6jrupkg-1; Tue,
 26 May 2026 04:19:22 -0400
X-MC-Unique: W7jRnSlzPu-pzaj6jrupkg-1
X-Mimecast-MFC-AGG-ID: W7jRnSlzPu-pzaj6jrupkg_1779783561
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24F021956088; Tue, 26 May 2026 08:19:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2401180056E; Tue, 26 May 2026 08:19:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/37] docs/system/arm/aspeed: Add AST1040 Bridge IC evaluation
 board
Date: Tue, 26 May 2026 10:18:25 +0200
Message-ID: <20260526081848.651835-15-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Update the Aspeed AST10x0 documentation to include the
AST1040 evaluation board and clarify the AST10x0 family
classification.

The documentation now describes:
- AST1030 and AST1040 as Bridge IC devices
- AST1060 as a Platform Root of Trust processor
- AST1040 Cortex-M4F CPU frequency running at 400 MHz

Also add the ast1040-evb machine entry to the supported
AST10x0 SoC based machine list.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index a2eccf54892d..2d51ceeb8443 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -441,18 +441,26 @@ Use ``tio`` or another terminal emulator to connect to the consoles:
    $ tio /dev/pts/57
 
 
-Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1060-evb``)
-====================================================================================================
+Aspeed Bridge IC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1040-evb``, ``ast1060-evb``)
+=======================================================================================================================
 
-The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
-evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
-and AST1060 (Platform Root of Trust Processor), both integrating an Arm Cortex M4F CPU (200MHz).
+The QEMU Aspeed machines model Bridge ICs and Platform Root of Trust processors
+of various Aspeed evaluation boards. They are based on different members of
+the Aspeed AST10x0 SoC family:
+
+- AST1030 : Bridge IC
+- AST1040 : Bridge IC
+- AST1060 : Platform Root of Trust processor
+
+The AST1030 and AST1060 integrate an Arm Cortex-M4F CPU running at 200 MHz.
+The AST1040 integrates an Arm Cortex-M4F CPU running at 400 MHz.
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
 AST10x0 SoC based machines :
 
 - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)
+- ``ast1040-evb``          Aspeed AST1040 Evaluation board (Cortex-M4F)
 - ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)
 
 Supported devices
-- 
2.54.0


