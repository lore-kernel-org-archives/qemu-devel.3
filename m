Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C323DCAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216R-0008I2-Kp; Fri, 26 Sep 2025 01:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216K-0008FY-Nb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216G-0000nW-Ej
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4E8kTpXiav2aYv1eZjolSKz7x28UhYr4H2U284vFXNE=;
 b=bmIelimzPo0ZjGJrtjAPUW+o4SSKhvnrSOP5v3Q7gyriepPOq4VnPzhds6IsKfAm8cpqjk
 w73mB8BSi4BkJxuwojJW0n+e5DvEREaLzX4isF3Oq/RcMXcECdfNBEOjRK5qioXiKVmlVt
 KoGYDZZVwEmKzrp8O8ZEo4NmnKCzs4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-m1EYMu6CPtGWqZZmEQiq4A-1; Fri,
 26 Sep 2025 01:34:23 -0400
X-MC-Unique: m1EYMu6CPtGWqZZmEQiq4A-1
X-Mimecast-MFC-AGG-ID: m1EYMu6CPtGWqZZmEQiq4A_1758864862
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F86F1800366; Fri, 26 Sep 2025 05:34:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A28871800579; Fri, 26 Sep 2025 05:34:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/29] hw/vfio/container-base.c: rename file to container.c
Date: Fri, 26 Sep 2025 07:33:36 +0200
Message-ID: <20250926053358.308198-8-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Rename the file to reflect the previous rename of VFIOContainerBase to
VFIOContainer.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-7-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/{container-base.c => container.c} | 0
 hw/vfio/meson.build                       | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/vfio/{container-base.c => container.c} (100%)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container.c
similarity index 100%
rename from hw/vfio/container-base.c
rename to hw/vfio/container.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 62b7a7eaaca3da6bd914fdc272e6bfe94bd77429..82f68698fb8483196d5ced096f79d1024bf9c4bc 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -3,7 +3,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
-  'container-base.c',
+  'container.c',
   'container-legacy.c',
   'helpers.c',
 ))
-- 
2.51.0


