Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09848606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tkyis8L5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLLC-0002xo-EA; Mon, 09 Nov 2026 04:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLL5-0002ip-KN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLL3-0002uC-PP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A52bvNhRMIkR4BGIILpaiOJeXd3yMJvDhM+Fhjcdaik=;
 b=Tkyis8L5OewngpHlmM2JqErYy5UOlCB630zs9hHHAIIkUW04KoPLZADpAxfscqdmDPZMGO
 cmOpBAfWsqSt83ql8ApZw0sdeSgxBtS4d2bvtLEyo52movzepy59l7k6LlD+OKNUl99OVV
 CfZGPlHTDkZ4mJLnZiMgQuRVI+H3MfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-L9mZp7BeP3ShaqR-9o8cZQ-1; Mon,
 09 Nov 2026 04:06:46 -0500
X-MC-Unique: L9mZp7BeP3ShaqR-9o8cZQ-1
X-Mimecast-MFC-AGG-ID: L9mZp7BeP3ShaqR-9o8cZQ_1794215205
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C92D1955E85; Mon,  9 Nov 2026 09:06:45 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35A9B30000E5; Mon,  9 Nov 2026 09:06:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 9/9] vfio/pci: Rename vfio_opt_rom_in_denylist() to
 vfio_quirk_rom_in_denylist()
Date: Mon,  9 Nov 2026 10:06:25 +0100
Message-ID: <20261109090625.908592-10-clg@redhat.com>
In-Reply-To: <20261109090625.908592-1-clg@redhat.com>
References: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The function is defined in pci-quirks.c. Rename it to follow the
vfio_quirk_ naming convention.

No functional change.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        | 2 +-
 hw/vfio/pci-quirks.c | 2 +-
 hw/vfio/pci-rom.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index faf0e9dcf022..463dd5d81130 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -252,7 +252,6 @@ void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);
 
 /* ROM */
 void vfio_pci_size_rom(VFIOPCIDevice *vdev);
-bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 
 /* VGA */
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
@@ -284,6 +283,7 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+bool vfio_quirk_rom_in_denylist(VFIOPCIDevice *vdev);
 
 /* IGD */
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index a38a0e7a3aca..da5836edeb21 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -48,7 +48,7 @@ static const struct {
     { 0x14e4, 0x168e }, /* Broadcom BCM 57810 */
 };
 
-bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)
+bool vfio_quirk_rom_in_denylist(VFIOPCIDevice *vdev)
 {
     int i;
 
diff --git a/hw/vfio/pci-rom.c b/hw/vfio/pci-rom.c
index c8c59727bf7e..89b2b67f8325 100644
--- a/hw/vfio/pci-rom.c
+++ b/hw/vfio/pci-rom.c
@@ -180,7 +180,7 @@ void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 
     if (pdev->romfile || !pdev->rom_bar) {
         /* Since pci handles romfile, just print a message and return */
-        if (vfio_opt_rom_in_denylist(vdev) && pdev->romfile) {
+        if (vfio_quirk_rom_in_denylist(vdev) && pdev->romfile) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
@@ -208,7 +208,7 @@ void vfio_pci_size_rom(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (vfio_opt_rom_in_denylist(vdev)) {
+    if (vfio_quirk_rom_in_denylist(vdev)) {
         if (pdev->rom_bar > 0) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
-- 
2.56.0


