Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078FDC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLfR-0007Us-Bd; Mon, 27 Jan 2025 04:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLeS-0006VF-3D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:43:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLeQ-0005UM-JH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737971005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FV0oE3019T3EwDaED9bFl3tH3qaGLmyi3TvhijFdhXE=;
 b=YpqWhMf9SSOjqtMFisK/B6tfISrx/uHFM1A5XzDOSC+B5IG2D9WD+54d7j9wZh/OFXwfz0
 1ugrZUhyJIpV4jr+jlXYkAXfq041k8tmkpafvJ+mevv4KSL0f3akUeE5TgzVoMFHzkhBoN
 MrWAyEF1lhICto4JJZ+2vacwXZu9uD0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-YGVQuy9IPZGIwYBna_MwJA-1; Mon,
 27 Jan 2025 04:43:21 -0500
X-MC-Unique: YGVQuy9IPZGIwYBna_MwJA-1
X-Mimecast-MFC-AGG-ID: YGVQuy9IPZGIwYBna_MwJA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7BA1801F15; Mon, 27 Jan 2025 09:43:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D885618008CC; Mon, 27 Jan 2025 09:43:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/12] docs/system/arm/aspeed: Remove tacoma-bmc from the
 documentation
Date: Mon, 27 Jan 2025 10:42:39 +0100
Message-ID: <20250127094239.636526-13-clg@redhat.com>
In-Reply-To: <20250127094239.636526-1-clg@redhat.com>
References: <20250127094239.636526-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tacoma-bmc machine has recently been removed, so let's remove
it from the documentation now, too.

Fixes: 2b1b66e01f ("arm: Remove tacoma-bmc machine")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250124174507.27348-1-thuth@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index fa4aa28eeff2..97fd6a0e7fbd 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``tacoma-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-==================================================================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+==================================================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
-- 
2.48.1


