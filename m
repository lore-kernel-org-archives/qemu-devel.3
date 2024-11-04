Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE50D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Hq-00067x-L4; Mon, 04 Nov 2024 16:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hk-0005lM-TE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hj-0005LO-Cb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7NBjxcaDcjtzQHlNEnd4IoK3C/16CIfbxI1oLBTaFY=;
 b=GOWFsyo0SJZE2UeB3KebLwt522GhGAjbUZnj/K7jcGWw3zsCxiKTacYico6+9ejEYrhN27
 dECRwtbyM1fIyWjqcBUgjtVxzOTNCWlXolui5DwW09CH0hqchNRF9Di9gaByltriG6CBQN
 u6TjoMJCNTDjDeM0d+w7nZcGyD9YZuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-q7qS2VF1NYixV2akM0VnqQ-1; Mon, 04 Nov 2024 16:06:49 -0500
X-MC-Unique: q7qS2VF1NYixV2akM0VnqQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so34505545e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754408; x=1731359208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7NBjxcaDcjtzQHlNEnd4IoK3C/16CIfbxI1oLBTaFY=;
 b=E7Rq8BZee5etxT0WzfHpInOdKcXUk7Ud1yA6Blaa6aZcBwCEKShwxb42KZPnr8EBmo
 mOeKtkVO5564XbzFYaQHMDiP3UcXu0TII50nvIL23exby06TCtT4rBxVOQhfDy3XiB3d
 gkFrBXmGTuJ4J4y5VI29GyxTV5l1HK3e5/WWT932i6aOFYO4QbC5G1o9f6Z5mWhdD3kn
 naME9VeKi/Pgh2iZoPyvvUH7gcnbMxfkpcI8fsASu069fpUjzvvS8QLNqUgtNQu1AeRo
 eERUPkW2GU6Pqkq4rFzxip3Lx4/5SN92yjL6JQ7eclzzdGHYfliL4kaf68BTc4RU3MaJ
 37RQ==
X-Gm-Message-State: AOJu0YyId3oTuDUl00Z8IU8sfxTGTspFVt46ofiufZtMQ+z88DJV9m6W
 ESNtc+o0fJk7W1ZbgsVXjoQxCBv6f3b2K82zxCEXCYviZViVxwHplUhJnCJ4cDvHQe9yjNg4+73
 8Qkoug9Frl4oCNSEq2OsIYYxKZg5ITz+HkF7UB7IQu876WxgvEVnK4harVKK1Q8eR2Wsg2EEW9J
 cO5YD3ZLW6+6E6pAPY/7LNhLug9pol6w==
X-Received: by 2002:a05:600c:6014:b0:431:5d14:1cae with SMTP id
 5b1f17b1804b1-4327b7019e9mr147152635e9.19.1730754408129; 
 Mon, 04 Nov 2024 13:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW6sOthLSX7OSyJZXtfYhKKpA08xvh2xrUs/h4/mK3DqnVUTUaEwQtdpKe6NOsxHD7hUphHw==
X-Received: by 2002:a05:600c:6014:b0:431:5d14:1cae with SMTP id
 5b1f17b1804b1-4327b7019e9mr147152425e9.19.1730754407636; 
 Mon, 04 Nov 2024 13:06:47 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab2aasm164105045e9.6.2024.11.04.13.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:46 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 19/65] hw/mem/cxl-type3: Add properties to control link speed
 and width
Message-ID: <14bd0f3865489d537a93b7c80617622473f224e4.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To establish performance characteristics of a CXL device when used via a
particular CXL topology (root ports, switches, end points) it is necessary
to set the appropriate link speed and width in the PCI Express capability
structure.  Provide x-speed and x-link properties for this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916173518.1843023-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 4 ++++
 hw/mem/cxl_type3.c          | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fdd0f4e62b..e14e56ae4b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -549,6 +549,10 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    /* PCIe link characteristics */
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+
     /* DOE */
     DOECap doe_cdat;
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 235ac40aeb..44d491d8f6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -17,6 +17,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -1200,6 +1201,7 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
 
@@ -1229,6 +1231,10 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLType3Dev,
+                                speed, PCIE_LINK_SPEED_32),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
+                                width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


