Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B057CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2174-0000BV-1K; Fri, 26 Sep 2025 01:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216u-00007m-W5
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216p-0000wr-1y
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jl395112lMx2yc8mwgCegrKeh0bk0oZNQoFxaEBXyCM=;
 b=YIPkkMGq5SJ31kS8CRNJFMlzbMIcJ7VQVWnDtDU0DtyMrEF5KVX1ejuKfaM6A36XpdMLsx
 6b8AxcO7pyc4IriAmE21PiAz/EjeRBZpiC4uV25hSz0s5OyT7lFtAcvluMRMFlLRDE1tic
 sAGh0+W7YTBpFrTKHG5O8Qrlar5qkHw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-4Ti5sesLMnea0Zw03ATTzA-1; Fri,
 26 Sep 2025 01:34:58 -0400
X-MC-Unique: 4Ti5sesLMnea0Zw03ATTzA-1
X-Mimecast-MFC-AGG-ID: 4Ti5sesLMnea0Zw03ATTzA_1758864897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D271800447; Fri, 26 Sep 2025 05:34:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A813D1800579; Fri, 26 Sep 2025 05:34:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/29] vfio/pci.c: rename vfio_pci_dev_nohotplug_properties[]
 to vfio_pci_nohotplug_properties[]
Date: Fri, 26 Sep 2025 07:33:50 +0200
Message-ID: <20250926053358.308198-22-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-21-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c3bb3725ccbb34511de02f69a6a781619696c1d..6b3c97c56c9c27a9c65cf62e6300e51be1920888 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3920,7 +3920,7 @@ static const TypeInfo vfio_pci_info = {
     .instance_finalize = vfio_pci_finalize,
 };
 
-static const Property vfio_pci_dev_nohotplug_properties[] = {
+static const Property vfio_pci_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
                      use_legacy_x86_rom, false),
@@ -3933,7 +3933,7 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
+    device_class_set_props(dc, vfio_pci_nohotplug_properties);
     dc->hotpluggable = false;
 
     object_class_property_set_description(klass, /* 3.1 */
-- 
2.51.0


