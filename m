Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2BCC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9LhX-0006ef-HA; Mon, 28 Apr 2025 06:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9LhR-0006ER-Gh
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9LhL-0003GI-O9
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745836010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdD5WhvUXDD+TKpNtMmpeP4Gbsk9q0qnRvNCY4+zyDg=;
 b=X5i48mOaXT7Y8uz4h7QDrTvnx7WBFRa60IWYEXhFtz/UrZPLx8M165tvmDyrMsKIaaLwBu
 pNgpwLKwuQPiOZ7Am5M+eA/0Btahw3oSu9iTWtjPxyTfOkjztVctV7HtQ3MI3A3D9n/Lqx
 G8c/yEabaH+IdDS3i1UxzOJloL+30Bg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-yGbEaFJIMAqiXgk2Xt8oZg-1; Mon,
 28 Apr 2025 06:26:47 -0400
X-MC-Unique: yGbEaFJIMAqiXgk2Xt8oZg-1
X-Mimecast-MFC-AGG-ID: yGbEaFJIMAqiXgk2Xt8oZg_1745836006
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 538161956086; Mon, 28 Apr 2025 10:26:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81D72180045C; Mon, 28 Apr 2025 10:26:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com
Subject: [RFC 02/24] hw/acpi/ged: Fix wrong identation
Date: Mon, 28 Apr 2025 12:25:28 +0200
Message-ID: <20250428102628.378046-3-eric.auger@redhat.com>
In-Reply-To: <20250428102628.378046-1-eric.auger@redhat.com>
References: <20250428102628.378046-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/acpi/generic_event_device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index c85d97ca37..7b2d582fff 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -458,11 +458,11 @@ static void acpi_ged_initfn(Object *obj)
      * container for memory hotplug IO and expose it as GED sysbus
      * MMIO so that boards can map it separately.
      */
-     memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
-                        MEMORY_HOTPLUG_IO_LEN);
-     sysbus_init_mmio(sbd, &s->container_memhp);
-     acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
-                              &s->memhp_state, 0);
+    memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
+                       MEMORY_HOTPLUG_IO_LEN);
+    sysbus_init_mmio(sbd, &s->container_memhp);
+    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
+                             &s->memhp_state, 0);
 
     memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
                           TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
-- 
2.49.0


