Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B209C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAeK-0006ad-Bm; Tue, 12 Mar 2024 18:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcV-0002ui-Nd
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcI-0004d5-Gj
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKkSDazDM8plKzOrprMyap3/frHtZRjZMB1Z0hTsQYk=;
 b=IOKkATASqWqUwtw6agW+2i8If2heOjtkf/fKTi0CP/QL5chScubz+YDkbQ9Ht5u/LDZRVe
 BeTyB/aQQ+Y6E8iOk+p1hNII6wYpXE/fqx/Wp5hPUCd7CfXO5swXEkuYkaWXHCwgVbxX6Y
 KZat2U69udO3oQ7ljaXFPENblm2uJRQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-18JZP0X8N4eGzur0fMTOHw-1; Tue, 12 Mar 2024 18:29:00 -0400
X-MC-Unique: 18JZP0X8N4eGzur0fMTOHw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d45c84435eso10091791fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282538; x=1710887338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKkSDazDM8plKzOrprMyap3/frHtZRjZMB1Z0hTsQYk=;
 b=XpLq1rk0CCuAWWTtBSKBrmebnpMkvbxmEFQDsk8j7T29pmIg2p+6AdQJBc5rpAYyYv
 jnVxUlhElSJ0xSKD6VGD2oSszGAIN+4MlkamTAvEIpgdSYwCh5ejG7HQpYZlQvExuMPE
 0L+dHI1SogGENgtUEIjTav6pf4arB8kBjijgiShG4x9WmglJptRUpiJiEh5EO6ugmg6R
 BTdNVOPHWMteBSfK33xV7JxnytUJFty0tr3xr8Ty7b6JsIdwRa3kGlW5bV7HsG3gsSyv
 Rt9jriRR0lN22SEuKkGsoSL1rsY0oDoUQDBYlZ4H6p0af97cMxMzZRDcaJh9xNXDveq9
 tRJA==
X-Gm-Message-State: AOJu0YyRR8kyJP7qxpMxsdlqi22l7X37DL5rDM/j5GpgPk+soVghkgiW
 JdCh0nJp8bVDVW0Eu0DuZJUg9wzwrySEhMWwCuAP+Q4YYVy6iGsy259bJmrf6wjW88W3lWIkf3i
 keZjoWpmXJgbh9NG6HCbIiT1xCJsAE5DAI/eOcgjsNp6eaDgkXIPW61mBQ8RE18/z/1nnGd0gr4
 UfOAR+NVotDKMovemllFziggAZciajZjQK
X-Received: by 2002:a2e:720b:0:b0:2d4:49d1:38e with SMTP id
 n11-20020a2e720b000000b002d449d1038emr3547950ljc.28.1710282538507; 
 Tue, 12 Mar 2024 15:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTHwlpwOhQH8XRXj1WIhU77gbrM669UAtKbXGhtG3RKMWI4lBcPnVPheexgEOdZeeNAnMX2w==
X-Received: by 2002:a2e:720b:0:b0:2d4:49d1:38e with SMTP id
 n11-20020a2e720b000000b002d449d1038emr3547935ljc.28.1710282537949; 
 Tue, 12 Mar 2024 15:28:57 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 d34-20020a056402402200b005687e7b0cd2sm388946eda.40.2024.03.12.15.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:57 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <Zhenzhong.duan@intel.com>, qemu-arm@nongnu.org
Subject: [PULL 63/68] hw/arm/virt: Set virtio-iommu aw-bits default value to 48
Message-ID: <62d776002c990d5b6fd4a2b6809ab2956c6e1ff0.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

On ARM we set 48b as a default (matching SMMUv3 SMMU_IDR5.VAX == 0).

hw_compat_8_2 is used to handle the compatibility for machine types
before 9.0 (default was 64 bits).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>
Message-Id: <20240307134445.92296-9-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..e5cd935232 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -85,11 +85,28 @@
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
 
+static GlobalProperty arm_virt_compat[] = {
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
+};
+static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
+
+/*
+ * This cannot be called from the virt_machine_class_init() because
+ * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
+ * only is called on virt non abstract class init.
+ */
+static void arm_virt_compat_set(MachineClass *mc)
+{
+    compat_props_add(mc->compat_props, arm_virt_compat,
+                     arm_virt_compat_len);
+}
+
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
                                                     void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
+        arm_virt_compat_set(mc); \
         virt_machine_##major##_##minor##_options(mc); \
         mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
         if (latest) { \
-- 
MST


