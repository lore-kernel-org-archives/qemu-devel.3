Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9BCCFD37B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNpzR-0006BQ-MK; Tue, 25 Nov 2025 05:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vNpzF-0006AC-CH
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vNpz6-0002Iw-Ri
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764065359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bywGPmkDfGV/DKfeUSYLZsanIrgHEk2/Wfv2PcSx2k=;
 b=Bj/425tN0jcGv03ltIKagDa5p5RN5cHA+X21sTw/3hCOVWOGwV7n1AxaShJEFf8GeSns+o
 +FX6nwDEGKV/NpRZglvqgM1DcT2OHQM/e2xe4ArR4dUs2Ep1sHXAH0OFTzdFihg3Nsz6F7
 zBX7LVXWSluKIkSKu1V6GdS1rdiTjdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-A-GaWrDZNO6V13ZpoUdTZA-1; Tue,
 25 Nov 2025 05:09:15 -0500
X-MC-Unique: A-GaWrDZNO6V13ZpoUdTZA-1
X-Mimecast-MFC-AGG-ID: A-GaWrDZNO6V13ZpoUdTZA_1764065354
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC9D1800561; Tue, 25 Nov 2025 10:09:13 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3177D18004D8; Tue, 25 Nov 2025 10:09:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v3 01/11] hw/arm/virt: Rename arm_virtio_compat into
 arm_virt_compat_defaults
Date: Tue, 25 Nov 2025 11:07:50 +0100
Message-ID: <20251125100859.506228-2-eric.auger@redhat.com>
In-Reply-To: <20251125100859.506228-1-eric.auger@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Renaming arm_virtio_compat into arm_virt_compat_defaults
makes more obvious that those compats apply to all machine
types by default, if not overriden for specific ones. This also
matches the terminology used for pc-q35.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab56..ec0af8e6e7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,20 +94,21 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
-static GlobalProperty arm_virt_compat[] = {
+static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
-static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
+static const size_t arm_virt_compat_defaults_len =
+    G_N_ELEMENTS(arm_virt_compat_defaults);
 
 /*
  * This cannot be called from the virt_machine_class_init() because
  * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
  * only is called on virt non abstract class init.
  */
-static void arm_virt_compat_set(MachineClass *mc)
+static void arm_virt_compat_default_set(MachineClass *mc)
 {
-    compat_props_add(mc->compat_props, arm_virt_compat,
-                     arm_virt_compat_len);
+    compat_props_add(mc->compat_props, arm_virt_compat_defaults,
+                     arm_virt_compat_defaults_len);
 }
 
 #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
@@ -116,7 +117,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
-        arm_virt_compat_set(mc); \
+        arm_virt_compat_default_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
-- 
2.52.0


