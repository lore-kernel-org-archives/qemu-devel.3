Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A87BC6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASu-0000nf-20; Sun, 22 Feb 2026 09:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASZ-0008GL-QP
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASX-0006s4-82
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rnkI9nMTthY8p6DDwYIOuhFVQyTvRTqLVnh7owDEQ5U=;
 b=NyPO1M+fYjXQDucVPqeLuEKIM+s+tZRpmSsleCHrvIjLj0wf5FM2nAyjU5qKbNmhZz9L+n
 vGTvpnWr+RLi7Y7162zQDSyiA3wGbs0M349119ASp262YWrowtaGlfQGiJROlCh5XzDqTV
 wGZQfKMEYKQ0V36Am+qVWmJL7UKho9E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-OfkyPjeHPbu7DfEjkY23qw-1; Sun, 22 Feb 2026 09:29:19 -0500
X-MC-Unique: OfkyPjeHPbu7DfEjkY23qw-1
X-Mimecast-MFC-AGG-ID: OfkyPjeHPbu7DfEjkY23qw_1771770558
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso31545745e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770558; x=1772375358; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rnkI9nMTthY8p6DDwYIOuhFVQyTvRTqLVnh7owDEQ5U=;
 b=ddIM3Fcfr2LF8+AAA9p6M1EDLSxJmrbtxeVZC4NKS2SjFtdvUOjKH0SVMH5oS0ISi8
 d0k6LBLJyeZ8TP28XJJeJRJaGMMqa2XsibziR0Nz9t3y4Kg9a8+7ytfP1fww38MQfUOH
 FM1TADVoLvmwXz36Ud7zxGqHZUKDWU/mDPVssa947XGrX7zrwRH3CFc2q1GuI5OTlr+G
 7y/Nl95hX/VUsOklMY63TqHOYBIfFLN6YYa0kd++YJIN4p/jmcmMuPk7cryaWQNkA8u6
 SkvNno38DMAyla6ip2/DpeNFmUQT/ne7Hhr622+BTHDrg5KTKWcxbLMq61BDj15Xiyb2
 SBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770558; x=1772375358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnkI9nMTthY8p6DDwYIOuhFVQyTvRTqLVnh7owDEQ5U=;
 b=lHkZEYrhG2rtt/Kyk3kw57vKyhZ4xs7S9V8/Gn5MmwUT2hiyZ37qUbEF1xzQ00qocE
 r111Mze7g+XIilCjJS67+X50TdV8gu8AI1RGxQ4wGRqsvXLxZUsonmOT4pFxdWpbor1y
 ArmkG2hPRW7pETSh9X+dDbh3Gs/ITV4RS+EbipEUmYjW1w24/mEVQvNQTDn7k3TOHLEr
 7Ew82sqrEiKq8cQXc06TZ+SEP0RN3kaUdGOMFJoA7RRbpqJ5QrTIallB7EVxokosNSSu
 DxhYVaqH5J1vyQMBoQuc/PbAmKlgCh9idt0fZsm2TU/EtFi5RcWmgMwUJMivjDch1mb4
 iBrw==
X-Gm-Message-State: AOJu0YxZMLHPp++RZ/3WMDm0Bj6FPXXNtLCpHEiyP3b4U/7f81zJHxsd
 wxGcXedHd5yAhe55FcFrSfWns2q8mK3HxHPqm09E5zbivwdrnM4o7MDmlRo7w3lsa0qVt7Z1V78
 G++lZzvbVtxG1dgk8pm65bNPr7BPnFLYgEoDOYgaDtvFbgDtYTH4syLw072MX/6jui56BMJK9bn
 viglp5xxPECzZR98dut/XB+JwZMdqnqT+3UQ==
X-Gm-Gg: AZuq6aJTllDnX4b19jr0DeAZm2UJCRZaLzcAu1o7HvUpFy2gBCRmRuUb6ZElcXaadML
 4ILa+6Eq6Fa4RW/TzEo/VTQDY6CruVMZhoyIzq1zGnBXMXqQmedLvv/7qftAqMvQgaG4aifLOnv
 kCQMy0e3+PRXZtlEHP9tKUdKQNv121LlcVY/pcC6Ms9wsAzQlUysZ36LlH0o8SgycZnVKo4BcsT
 b4BtGDJNJyP50+QmQCkfE9E1MS0/DuxKgitxhF3R2MXhhmUukrRkyl3DZVxPhhHS8BLH/cDFDcX
 XWzT86HyEDn8CbEvF3Ids3r+R1CoKmpiFo6bR7qlJFutli74X45gobbVcQUOjVI4mWxgsTsv2+N
 fP/CdbNtYerzX4IxqqhTx8y8AjJYLVQU4oVojLtxS5uJOHQ==
X-Received: by 2002:a05:600c:3587:b0:483:a27e:6706 with SMTP id
 5b1f17b1804b1-483a95fc063mr103109295e9.9.1771770557562; 
 Sun, 22 Feb 2026 06:29:17 -0800 (PST)
X-Received: by 2002:a05:600c:3587:b0:483:a27e:6706 with SMTP id
 5b1f17b1804b1-483a95fc063mr103108775e9.9.1771770556901; 
 Sun, 22 Feb 2026 06:29:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f7c4csm63521905e9.23.2026.02.22.06.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:16 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arpit Kumar <arpit1.kumar@samsung.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 25/33] hw/cxl: Physical Port Info FMAPI - update to current
 spec and add defines.
Message-ID: <7df839591cf9354f7cc054ff6d01e16d46ff9f33.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Arpit Kumar <arpit1.kumar@samsung.com>

Add a new cxl/cxl_ports.h header for field definitions related only to port
commands. Bring field naming up to date with spec as 'version' bitmasks
have been replaced with bitmasks of the specific features.

Fix a small issue where a reserved value for USP was set to 2 rather
than 0.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204173223.44122-2-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 31 ++++++++++++++--------
 include/hw/cxl/cxl_port.h  | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/cxl/cxl_port.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2f449980cd..1c8cbe0f68 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -15,6 +15,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_port.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
@@ -565,16 +566,16 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     } QEMU_PACKED *in;
 
     /*
-     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
+     * CXL r3.2 Table 7-19: Get Physical Port State Port Information Block
      * Format
      */
     struct cxl_fmapi_port_state_info_block {
         uint8_t port_id;
         uint8_t config_state;
-        uint8_t connected_device_cxl_version;
+        uint8_t connected_device_mode;
         uint8_t rsv1;
         uint8_t connected_device_type;
-        uint8_t port_cxl_version_bitmask;
+        uint8_t supported_cxl_mode_bitmask;
         uint8_t max_link_width;
         uint8_t negotiated_link_width;
         uint8_t supported_link_speeds_vector;
@@ -623,21 +624,30 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         if (port_dev) { /* DSP */
             PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
                 ->devices[0];
-            port->config_state = 3;
+            port->config_state = CXL_PORT_CONFIG_STATE_DSP;
             if (ds_dev) {
                 if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
-                    port->connected_device_type = 5; /* Assume MLD for now */
+                    /* Assume MLD for now */
+                    port->connected_device_type =
+                        CXL_PORT_CONNECTED_DEV_TYPE_3_MLD;
                 } else {
-                    port->connected_device_type = 1;
+                    port->connected_device_type =
+                        CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
+                    port->connected_device_mode =
+                        CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
+
                 }
             } else {
-                port->connected_device_type = 0;
+                port->connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
+                port->connected_device_mode =
+                    CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
             }
             port->supported_ld_count = 3;
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
-            port->config_state = 4;
-            port->connected_device_type = 0;
+            port->config_state = CXL_PORT_CONFIG_STATE_USP;
+            port->connected_device_type = 0; /* Reserved for USP */
+            port->connected_device_mode = 0; /* Reserved for USP */
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -667,8 +677,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
         port->link_state = 0;
-        port->port_cxl_version_bitmask = 0x2;
-        port->connected_device_cxl_version = 0x2;
+        port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
new file mode 100644
index 0000000000..04db60f7bc
--- /dev/null
+++ b/include/hw/cxl/cxl_port.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef CXL_PORT_H
+#define CXL_PORT_H
+
+/* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
+#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
+#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
+#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
+#define CXL_PORT_CONFIG_STATE_DSP                0x3
+#define CXL_PORT_CONFIG_STATE_USP                0x4
+#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
+#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
+
+#define CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN 0x00
+#define CXL_PORT_CONNECTED_DEV_MODE_RCD                0x01
+#define CXL_PORT_CONNECTED_DEV_MODE_68B_VH             0x02
+#define CXL_PORT_CONNECTED_DEV_MODE_256B               0x03
+#define CXL_PORT_CONNECTED_DEV_MODE_LO_256B            0x04
+#define CXL_PORT_CONNECTED_DEV_MODE_PBR                0x05
+
+#define CXL_PORT_CONNECTED_DEV_TYPE_NONE            0x00
+#define CXL_PORT_CONNECTED_DEV_TYPE_PCIE            0x01
+#define CXL_PORT_CONNECTED_DEV_TYPE_1               0x02
+#define CXL_PORT_CONNECTED_DEV_TYPE_2_OR_HBR_SWITCH 0x03
+#define CXL_PORT_CONNECTED_DEV_TYPE_3_SLD           0x04
+#define CXL_PORT_CONNECTED_DEV_TYPE_3_MLD           0x05
+#define CXL_PORT_CONNECTED_DEV_PBR_COMPONENT        0x06
+
+#define CXL_PORT_SUPPORTS_RCD        BIT(0)
+#define CXL_PORT_SUPPORTS_68B_VH     BIT(1)
+#define CXL_PORT_SUPPORTS_256B       BIT(2)
+#define CXL_PORT_SUPPORTS_LO_256B    BIT(3)
+#define CXL_PORT_SUPPORTS_PBR        BIT(4)
+
+#define CXL_PORT_LTSSM_DETECT        0x00
+#define CXL_PORT_LTSSM_POLLING       0x01
+#define CXL_PORT_LTSSM_CONFIGURATION 0x02
+#define CXL_PORT_LTSSM_RECOVERY      0x03
+#define CXL_PORT_LTSSM_L0            0x04
+#define CXL_PORT_LTSSM_L0S           0x05
+#define CXL_PORT_LTSSM_L1            0x06
+#define CXL_PORT_LTSSM_L2            0x07
+#define CXL_PORT_LTSSM_DISABLED      0x08
+#define CXL_PORT_LTSSM_LOOPBACK      0x09
+#define CXL_PORT_LTSSM_HOT_RESET     0x0A
+
+#define CXL_PORT_LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
+#define CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
+#define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
+#define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
+
+#endif /* CXL_PORT_H */
-- 
MST


