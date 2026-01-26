Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CBC88E7F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIoA-00024W-Pp; Mon, 26 Jan 2026 04:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkInx-0001xf-Ld
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkInw-00060W-38
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769419359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8+gTPo+yv/FqpTy8nATRmAuAwhNf/xZdt8S5Dqeu0g=;
 b=i2HM94ddHv9U2FxF67C/8bXaQL4mpUrAUWktmp2DEiUzgdJxtWZepJBz2k4he+6y7h3YIi
 xK3yYNduVAobSpqHUDhXsqUPy+ttePu1yTMIRr5soFg5C7bhUuGpYjmKRmI9Bx4FSj07LO
 vGJysoj0y3VZvYFuBdUlBy3qmiRhLCc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-iSfoWPmpNfmeiDrJVAouzg-1; Mon,
 26 Jan 2026 04:22:35 -0500
X-MC-Unique: iSfoWPmpNfmeiDrJVAouzg-1
X-Mimecast-MFC-AGG-ID: iSfoWPmpNfmeiDrJVAouzg_1769419354
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D4761955F2C; Mon, 26 Jan 2026 09:22:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF4201956095; Mon, 26 Jan 2026 09:22:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 7/7] vfio-user: update VFIOProxy flag constants to use the
 BIT() macro
Date: Mon, 26 Jan 2026 10:22:12 +0100
Message-ID: <20260126092212.503162-8-clg@redhat.com>
In-Reply-To: <20260126092212.503162-1-clg@redhat.com>
References: <20260126092212.503162-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This should help avoid incorrect constant values being used in future. At
the same time we can remove the gap left for BIT(1) which was originally
intended for the VFIO_PROXY_NO_MMAP feature which was removed from later
versions of the vfio-user series.

Suggested-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260121110055.2333711-3-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index b09fd886f17f24abcf8d99e5520a39501c0486f1..7b97460cc504a408e8e4299fa84fd56a2d674aa0 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -91,10 +91,10 @@ typedef struct VFIOUserProxy {
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
-#define VFIO_PROXY_CLIENT        0x1
-#define VFIO_PROXY_FORCE_QUEUED  0x4
-#define VFIO_PROXY_NO_POST       0x8
-#define VFIO_PROXY_USE_MULTI     0x10
+#define VFIO_PROXY_CLIENT        BIT(0)
+#define VFIO_PROXY_FORCE_QUEUED  BIT(1)
+#define VFIO_PROXY_NO_POST       BIT(2)
+#define VFIO_PROXY_USE_MULTI     BIT(3)
 
 /* coalescing high and low water marks for VFIOProxy num_outgoing */
 #define VFIO_USER_OUT_HIGH       1024
-- 
2.52.0


