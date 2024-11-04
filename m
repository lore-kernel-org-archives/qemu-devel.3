Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1717D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84HX-0005BC-Jf; Mon, 04 Nov 2024 16:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HV-000548-Qr
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HU-0005KP-DQ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HT4p44lGhUJLiZNcVVDhq7UK1RgS21i7OPit+tLHM+w=;
 b=I3vPxiRIVXLG8uYlDP8e3/nBdEnsRA6VsfmK23WKxOdXnkx7xkxY02lafjo3bH1t75Z18r
 Ms6wOIk58r2RIxX23ODCzYzWd0M7N282wiwwS7CkhwYSY76/pgwz66AJeDDLtGCgWODIi1
 ejHlcZxCSXzh12333nwggYlIeqEEI5Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-mLO1yNvdNz6CK4M4SIi5iA-1; Mon, 04 Nov 2024 16:06:34 -0500
X-MC-Unique: mLO1yNvdNz6CK4M4SIi5iA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d533a484aso2900116f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754393; x=1731359193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HT4p44lGhUJLiZNcVVDhq7UK1RgS21i7OPit+tLHM+w=;
 b=Zc9/DL3Fb9qkQVj3pfw4ul1XlvXrFAnDnrrWl6z/zqm8X1xcq+xLSsljmMq6nmObjT
 zdqTKlId7KsQFU/UU+7JIutzQ2E9WgB22aVDy4J5dZXJQnvjiY2eevssbM5JZCkbliLZ
 ghKz3/RB4NZs+CVEXeUVKOwsXs5umIEnfI8fZWa0H3ZweK0bOldMlSE2VQ0Mb9l78LET
 /uVVXhzG7x3XjOtbtPRldCIKX4jGuMq4C8I/Hvfu24UT+jnbYYvI17X4cVYUT8jxTV6f
 kiXJwZZwsw07jJIy3IGXh7zRjOSe4OvX1VkSXcLHpgHssb/JTUiQzJLArDJorbnul/FZ
 yjXg==
X-Gm-Message-State: AOJu0YwksL13n7t3Svd1fI0MZ3G2OF62iwz8rL7eL5f0se79MWEjOvBC
 0IuwcNl2reZsNOQiFQ3hijrsp8uF2TMyJGJUFiuN/nTQJl6BKdR0Y1B9ynjwgwdfTrsdCcpblQa
 4pvyvI9aTO+gUeablFv81wp6sDUdf8OuLo3eUdEiAP+WFQpZ1lWuNvYTe6PVdcHq1yEzMPLoBBx
 CbMHtuAzDgqCf+oqXZedhAOcuNM9DmfQ==
X-Received: by 2002:a05:600c:3d8a:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-4327dac773dmr132311235e9.14.1730754392854; 
 Mon, 04 Nov 2024 13:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvvO5PPBjV10Kv8z7u+BWa79l2PlmKjn6ASM2It+p19Xst/nk1YGA/irgAlzXrlgakYDU82Q==
X-Received: by 2002:a05:600c:3d8a:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-4327dac773dmr132311055e9.14.1730754392354; 
 Mon, 04 Nov 2024 13:06:32 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e8915sm164244265e9.27.2024.11.04.13.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:31 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 15/65] hw/pci-bridge/cxl_root_port: Provide x-speed and
 x-width properties.
Message-ID: <1478b5609022ed4331bff83d06cefed983df82ac.1730754238.git.mst@redhat.com>
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

Approach copied from gen_pcie_root_port.c
Previously the link defaulted to a maximum of 2.5GT/s and 1x.  Enable setting
it's maximum values.  The actual value after 'training' will depend on the
downstream device configuration.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916173518.1843023-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 hw/pci-bridge/cxl_root_port.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 2dd10239bd..5e2156d7ba 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "hw/cxl/cxl.h"
@@ -206,6 +207,10 @@ static Property gen_rp_props[] = {
                      -1),
     DEFINE_PROP_SIZE("pref64-reserve", CXLRootPort, res_reserve.mem_pref_64,
                      -1),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_32),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
MST


