Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B554D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Hr-0006Es-GN; Mon, 04 Nov 2024 16:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ho-00060l-Nf
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hn-0005Ls-7f
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBr0W8m8DyGKLRz2Opar4AmzHNpYMF5hjNkEt3At0qU=;
 b=dYoOVvyn3WPXFlNHWV/gXjNb8ddHZga9CyK9Po3aHuyL1jUd4flpgdo+GDwIY4E833ODs2
 wIVU0lxQNlU+as3KWA2Lx+ztzHZetovUYFYWQvJzjKe2bWT7PfhmkfSvKK1eAy7OeJrH8N
 kX3rQa/4B/Sj1jZ2B9EdiyrcTAzsL0E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-qcMcZ2ajMKCY5fXXeZRREQ-1; Mon, 04 Nov 2024 16:06:53 -0500
X-MC-Unique: qcMcZ2ajMKCY5fXXeZRREQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539e91e12bbso2998846e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754411; x=1731359211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBr0W8m8DyGKLRz2Opar4AmzHNpYMF5hjNkEt3At0qU=;
 b=uyuXgJOcoL3OQiFxG3B1mT6FYpZemYxSO5AA0DxFVHVdbFwDei+2miks7lZTUQm+oR
 a+yDc3Edmz144MwjiCXj09xr8M2jRxkTgj6HdOlNXIZoeYyqRxikNbuxnwYJh2i5vwOS
 YTNN6umz/8bBy0d/cJAd074HpW2VqRXgM5MD2Qu+1btCzfDYzF4E1+UVfqk0/63vstn8
 vot+zYHSabkao8VRuYLt7Mj5OSui87jKApK7vsXVMsso9hIY0w0rnMptUG0yH7TlZ5in
 mRDiMlaWK1CHIAZ6akQh9yPOYWiIf1hvUj/zC77uiubJ/RI3fF5MU9K1dhQcOM5KbCyp
 J/aQ==
X-Gm-Message-State: AOJu0YxKH8BoYADm8ZXtXL29o/NQtvHTuzsRYeMbArhoXeiSl0cHaJX/
 r++Eao+Kq4bLVtbqQg1SBdQw9v/JaKnov86Af+TmOQcaPhoO/qfo0zFwqfI0qHa3IldV9U2upaF
 OFMCoEQNNek+smvQr1yYpSqMpNsk1falf+WdabtRj4nC6jeN+ffzy0IDqpGh225gBki0WAmO5P3
 hOY4FmSoKw9z8iOYvi3ECMCYBPMDttzQ==
X-Received: by 2002:a05:6512:12d6:b0:539:d0ef:b3f9 with SMTP id
 2adb3069b0e04-53d65e11a10mr6868219e87.40.1730754411469; 
 Mon, 04 Nov 2024 13:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYuaC7su4TVDhczTLZ3rp4reMjxFfLUnkYrSfB0sDh3chXDkH5F4hWITNIN1P5f4sqxriP5g==
X-Received: by 2002:a05:6512:12d6:b0:539:d0ef:b3f9 with SMTP id
 2adb3069b0e04-53d65e11a10mr6868193e87.40.1730754410855; 
 Mon, 04 Nov 2024 13:06:50 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9403bfsm194359115e9.21.2024.11.04.13.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:50 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 20/65] hw/pci-bridge/cxl-upstream: Add properties to control
 link speed and width
Message-ID: <fa19fe4e3a61765ff60914ee00fc1e7a6a38dba9.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <20240916173518.1843023-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci-bridge/cxl_upstream_port.h | 4 ++++
 hw/pci-bridge/cxl_upstream.c              | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index 12635139f6..f208397ffe 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -12,6 +12,10 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI swcci;
+
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a5a39cc524..55f8b0053f 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
@@ -100,6 +101,7 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
     latch_registers(usp);
 }
 
@@ -363,6 +365,10 @@ static void cxl_usp_exitfn(PCIDevice *d)
 static Property cxl_upstream_props[] = {
     DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLUpstreamPort,
+                                speed, PCIE_LINK_SPEED_32),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
+                                width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
MST


