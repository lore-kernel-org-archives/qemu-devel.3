Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF6C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc4d-0001AQ-Lr; Fri, 04 Jul 2025 04:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4O-0000Yb-M6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4M-0001ab-Bz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdgzniatKvacCN5OOUKzv155pnYD6csvOM5DcHK/tos=;
 b=IFyPogOS3zhaZT/oXcRBcmoYiqzQBIjGSU+jSC6CpCvomeJzbiWOMZ6seHqIASZMpDVRxD
 L+ysGPcxqET/6Sv7kxmgMkAtCSTIMxzXzNF3i5hc6H8zj08MJCCtAf+yDTt2zIlc+K8AJC
 oyOtLyD/wP7mQuim7WZ/zFRX2SlUaMw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-2jjezp29PP6QkWM6ABW47g-1; Fri,
 04 Jul 2025 04:46:49 -0400
X-MC-Unique: 2jjezp29PP6QkWM6ABW47g-1
X-Mimecast-MFC-AGG-ID: 2jjezp29PP6QkWM6ABW47g_1751618808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE344180028A; Fri,  4 Jul 2025 08:46:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E18F419560A7; Fri,  4 Jul 2025 08:46:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 27/27] vfio: doc changes for cpr
Date: Fri,  4 Jul 2025 10:45:28 +0200
Message-ID: <20250704084528.1412959-28-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Update documentation to say that cpr-transfer supports vfio and iommufd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-22-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/CPR.rst | 5 ++---
 qapi/migration.json          | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 7897873c86e6cfdf9760a26a3c150d05d02b7518..0a0fd4f6dc31912b6f5ad52d8bce7b4d36da0e9f 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -152,8 +152,7 @@ cpr-transfer mode
 This mode allows the user to transfer a guest to a new QEMU instance
 on the same host with minimal guest pause time, by preserving guest
 RAM in place, albeit with new virtual addresses in new QEMU.  Devices
-and their pinned memory pages will also be preserved in a future QEMU
-release.
+and their pinned memory pages are also preserved for VFIO and IOMMUFD.
 
 The user starts new QEMU on the same host as old QEMU, with command-
 line arguments to create the same machine, plus the ``-incoming``
@@ -322,6 +321,6 @@ Futures
 
 cpr-transfer mode is based on a capability to transfer open file
 descriptors from old to new QEMU.  In the future, descriptors for
-vfio, iommufd, vhost, and char devices could be transferred,
+vhost, and char devices could be transferred,
 preserving those devices and their kernel state without interruption,
 even if they do not explicitly support live migration.
diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6ca1275b60ee6dc86948f7f6f7d6c42aeee..e8a7d3b2a95cf932d2e697756f150d28e23f0439 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -620,8 +620,10 @@
 #
 # @cpr-transfer: This mode allows the user to transfer a guest to a
 #     new QEMU instance on the same host with minimal guest pause
-#     time by preserving guest RAM in place.  Devices and their pinned
-#     pages will also be preserved in a future QEMU release.
+#     time by preserving guest RAM in place.
+#
+#     Devices and their pinned pages are also preserved for VFIO and
+#     IOMMUFD. (since 10.1)
 #
 #     The user starts new QEMU on the same host as old QEMU, with
 #     command-line arguments to create the same machine, plus the
-- 
2.50.0


