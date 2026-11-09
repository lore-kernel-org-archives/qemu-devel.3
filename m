Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TrEegfsk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLL9-0002rE-Ac; Mon, 09 Nov 2026 04:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLL1-0002hy-3N
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKy-0002tU-Ab
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1jNfzsvKFw5nGatnLjAfz3o/cTGwFm4Njq5qz2llrc=;
 b=TrEegfskhMBSOKrYGhGPZGZEjRHVR8+X+YXxFkj7URo6q4uYqqYP7tJQSvc78xjfmH62d4
 c7ySCHtVFCI576d3aGYYneNbl5BRRUl4dei7mA7tRGhfU60rxsbllYyyfi7ybAUKWN10JJ
 ovmWbmWp43yr17p6cIrl8Gl1VCyanwg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-QNpK3slROi6MheEr_xJVbg-1; Mon,
 09 Nov 2026 04:06:43 -0500
X-MC-Unique: QNpK3slROi6MheEr_xJVbg-1
X-Mimecast-MFC-AGG-ID: QNpK3slROi6MheEr_xJVbg_1794215202
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 245F21800370; Mon,  9 Nov 2026 09:06:42 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA8AA30000E5; Mon,  9 Nov 2026 09:06:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 7/9] vfio/pci: Rename
 vfio_sub_page_bar_update_mappings() function
Date: Mon,  9 Nov 2026 10:06:23 +0100
Message-ID: <20261109090625.908592-8-clg@redhat.com>
In-Reply-To: <20261109090625.908592-1-clg@redhat.com>
References: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  vfio_sub_page_bar_update_mappings -> vfio_pci_bar_update_sub_page_mappings

No functional change.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h | 2 +-
 hw/vfio/cpr.c | 2 +-
 hw/vfio/pci.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2d0237b9afce..bcbb582c13d3 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -260,7 +260,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 /* BARs */
 void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
-void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
+void vfio_pci_bar_update_sub_page_mappings(VFIOPCIDevice *vdev);
 
 /* Capabilities */
 void vfio_pci_cap_add_emulated_word(VFIOPCIDevice *vdev, int pos,
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3c1304781d76..152122c558c7 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -116,7 +116,7 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int nr_vectors;
 
-    vfio_sub_page_bar_update_mappings(vdev);
+    vfio_pci_bar_update_sub_page_mappings(vdev);
 
     if (msix_enabled(pdev)) {
         vfio_pci_msix_set_notifiers(vdev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a52bdfaf1f83..075166b56d3c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -927,7 +927,7 @@ VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
     return NULL;
 }
 
-void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
+void vfio_pci_bar_update_sub_page_mappings(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int page_size = qemu_real_host_page_size();
-- 
2.56.0


