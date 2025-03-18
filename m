Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34437C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfF-0004FE-6s; Tue, 18 Mar 2025 05:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfB-0004Ce-TR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTf9-0002GS-IO
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anPOZEtxH3/bwuKaG3fK/Wl1RN/CiNJW+uU5lmN8zIg=;
 b=S9Ukzn+Pt/1E9x/4GDRsb4IT/Dlhy1uT5nbP/Tw7GwClk7SanXD0cm1YoealRzHLoj2vHx
 E9tarTK8peRHDvZWEqVp5o6yB5OzxxHZurC15VuhJPvZwkAIxaDRslQoAZ7nBsQuvjogHq
 BMEYVzO5Rti9zvSUUgr+onUNbThUl38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-XVI97yw-OD-atEZDYSPhEw-1; Tue,
 18 Mar 2025 05:55:04 -0400
X-MC-Unique: XVI97yw-OD-atEZDYSPhEw-1
X-Mimecast-MFC-AGG-ID: XVI97yw-OD-atEZDYSPhEw_1742291704
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE33519560AE; Tue, 18 Mar 2025 09:55:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD6C21828A83; Tue, 18 Mar 2025 09:55:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 05/32] vfio: Make vfio_viommu_preset() static
Date: Tue, 18 Mar 2025 10:53:48 +0100
Message-ID: <20250318095415.670319-6-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This routine is only used in file "migration.c". Move it there.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 1 -
 hw/vfio/common.c              | 6 ------
 hw/vfio/migration.c           | 5 +++++
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5f082e5a321d97e90066d48cd3c1eaad56912ccb..0aae88131cffda1a90b8ccd0224387133c0fa83a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,7 +290,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_viommu_preset(VFIODevice *vbasedev);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ace7a4403bd49f35cf85009015b3ba315f80cd30..0b9b071cd0490867bb6aa4ceb261350ccd6e1125 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -65,12 +65,6 @@ int vfio_kvm_device_fd = -1;
  * Device state interfaces
  */
 
-
-bool vfio_viommu_preset(VFIODevice *vbasedev)
-{
-    return vbasedev->bcontainer->space->as != &address_space_memory;
-}
-
 static void vfio_set_migration_error(int ret)
 {
     if (migration_is_running()) {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 951e073a20287c46ca199b1648782b59415d0d2a..a1ba993ce549fce0d2a9a60ba07d4782c87c0c09 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1141,6 +1141,11 @@ bool vfio_mig_active(void)
     return true;
 }
 
+static bool vfio_viommu_preset(VFIODevice *vbasedev)
+{
+    return vbasedev->bcontainer->space->as != &address_space_memory;
+}
+
 /*
  * Return true when either migration initialized or blocker registered.
  * Currently only return false when adding blocker fails which will
-- 
2.48.1


