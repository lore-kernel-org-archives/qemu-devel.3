Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C7CC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts4Bc-0003Ah-Dc; Tue, 11 Mar 2025 14:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47p-0007Mc-Ok
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47e-0006rG-6P
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzlEdU21EJAvCxVTyFEnBfIdZ2C2KuXusinspW+ZuUk=;
 b=Ih0OfE4aBgaqWvUep2ZGj8vr65MK6rczzRAml4he1mAsN0VWeUDeno4N8aR3P23hZMHdBN
 VoYwRQt9xBdCOtJ98hS2qzu4hKqiPtpbfz7gkbncwHzWCrqhS/79JctC1AoddGxoBmvaAf
 WEOGoOeLQb+DBEXwjFw9FmA8eVxmzXk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-UUztEnJ5O9uulG69lhFtAQ-1; Tue,
 11 Mar 2025 14:14:29 -0400
X-MC-Unique: UUztEnJ5O9uulG69lhFtAQ-1
X-Mimecast-MFC-AGG-ID: UUztEnJ5O9uulG69lhFtAQ_1741716869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D281519560B2; Tue, 11 Mar 2025 18:14:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D009180AF7B; Tue, 11 Mar 2025 18:14:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/21] vfio/pci: Drop debug commentary from
 x-device-dirty-page-tracking
Date: Tue, 11 Mar 2025 19:13:28 +0100
Message-ID: <20250311181328.1200431-22-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

The intent behind the x-device-dirty-page-tracking option is twofold:

1) development/testing in the presence of VFs with VF dirty page tracking

2) deliberately choosing platform dirty tracker over the VF one.

Item 2) scenario is useful when VF dirty tracker is not as fast as
IOMMU, or there's some limitations around it (e.g. number of them is
limited; aggregated address space under tracking is limited),
efficiency/scalability (e.g. 1 pagetable in IOMMU dirty tracker to scan
vs N VFs) or just troubleshooting. Given item 2 it is not restricted to
debugging, hence drop the debug parenthesis from the option description.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250311174807.79825-1-joao.m.martins@oracle.com
[ clg: Fixed subject spelling ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3cb7806f2f219174ffb7d28595e9430b41ee40ae..7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3532,7 +3532,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 9.1 */
                                           "x-device-dirty-page-tracking",
                                           "Disable device dirty page tracking and use "
-                                          "container-based dirty page tracking (DEBUG)");
+                                          "container-based dirty page tracking");
     object_class_property_set_description(klass, /* 9.1 */
                                           "migration-events",
                                           "Emit VFIO migration QAPI event when a VFIO device "
-- 
2.48.1


