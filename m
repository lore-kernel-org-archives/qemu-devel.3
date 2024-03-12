Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F322C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAe7-0006OK-Ri; Tue, 12 Mar 2024 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcC-0002qv-Ji
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAc2-0004bN-9l
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKrjNhHTN2bPQP/9cRYriG9FH7mBRIe1f63zB2PVbVw=;
 b=ES5cmuHfO73k3iFI8yPrTMLcY/4OoS0NoxuCUnzzNUr2A/TcdV3cU3x6XCsSTqMbfPBvEU
 o89iSH14TCf5VCdaA4vX68zu0Twnfu35RBz78WpnDvxLDWFGChBHZFJzukJeQMaC5cabuG
 forRJxAk0RJ/igyu1W2BHW7E58tG5FQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-gCok1JwIMdS2QJvfDSsfpQ-1; Tue, 12 Mar 2024 18:28:44 -0400
X-MC-Unique: gCok1JwIMdS2QJvfDSsfpQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so4144768a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282523; x=1710887323;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKrjNhHTN2bPQP/9cRYriG9FH7mBRIe1f63zB2PVbVw=;
 b=N23n0FrTGjt/JjIuij4rere5Q+1IdpdSXPdVgwx892F+XCjb+rWmhACYBAzv8T0Hq+
 ZHdsQ8v9nMRIotwHLhn6Y8hvTgp8yktKegym6MAbgdU4P8tlMA5dHsBQo5nVxIXxo6eH
 BmhapBZsYbRPXr+rWCQn+wk5Pkp5kdb6pCerkhhI3L7jIuLM5jIeh9idhX4KYTdHUd/s
 Sh1fspns5s+Ptf+fn5wAEfdSHlxEJX7qUVXEe1i6JXMsrq4Ds00XW++K5yIvYOnoZhGg
 8zou2aem1E60VzWO2JeQasMl+meznlW3sdumgrW80YvGfPSAXhVqA+cQPDa4f0v8GQtI
 +fgQ==
X-Gm-Message-State: AOJu0Yy6SS7hRlHcB5xvr8HTDYO1zDri8DqP4xHWKmUzbLXGK2ih/jY3
 AgOzfat4okGa9TXb5LH/wnrVTEvSpawtlq15PnMLk8QolY5/s4lMA6loNsKjMwNCyWEyttnBXyW
 UIGL6nhmJWiv9VF6bSUN159mTwrYDlpeeR4QzahJGdEKVv/TVjSdCS2zcfq/erT/kL8uVdCUAVC
 xwpEpJzihkUEyzk/AK5h0uNR+RLQTEO1On
X-Received: by 2002:a50:ab48:0:b0:566:825b:98 with SMTP id
 t8-20020a50ab48000000b00566825b0098mr1245567edc.6.1710282522958; 
 Tue, 12 Mar 2024 15:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHsKh62kUegGSPD66dBTmSIcnTJFZISZxwV9K1n6JmG5gn76XpggUKe4TMUIWl1pS9MDTy3w==
X-Received: by 2002:a50:ab48:0:b0:566:825b:98 with SMTP id
 t8-20020a50ab48000000b00566825b0098mr1245547edc.6.1710282522417; 
 Tue, 12 Mar 2024 15:28:42 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 cn19-20020a0564020cb300b0056828004c75sm4397850edb.51.2024.03.12.15.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:41 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 58/68] virtio-iommu: Change the default granule to the host
 page size
Message-ID: <9dd5e808fc17ac92180965178a6e867c1e96ac57.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

We used to set the default granule to 4KB but with VFIO assignment
it makes more sense to use the actual host page size.

Indeed when hotplugging a VFIO device protected by a virtio-iommu
on a 64kB/64kB host/guest config, we current get a qemu crash:

"vfio: DMA mapping failed, unable to continue"

This is due to the hot-attached VFIO device calling
memory_region_iommu_set_page_size_mask() with 64kB granule
whereas the virtio-iommu granule was already frozen to 4KB on
machine init done.

Set the granule property to "host" and introduce a new compat.
The page size mask used before 9.0 was qemu_target_page_mask().
Since the virtio-iommu currently only supports x86_64 and aarch64,
this matched a 4KB granule.

Note that the new default will prevent 4kB guest on 64kB host
because the granule will be set to 64kB which would be larger
than the guest page size. In that situation, the virtio-iommu
driver fails on viommu_domain_finalise() with
"granule 0x10000 larger than system page size 0x1000".

In that case the workaround is to request 4K granule.

The current limitation of global granule in the virtio-iommu
should be removed and turned into per domain granule. But
until we get this upgraded, this new default is probably
better because I don't think anyone is currently interested in
running a 4KB page size guest with virtio-iommu on a 64KB host.
However supporting 64kB guest on 64kB host with virtio-iommu and
VFIO looks a more important feature.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20240307134445.92296-4-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/machine.c        | 5 ++++-
 hw/virtio/virtio-iommu.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ac5d5389a..6bd09d4592 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,9 +30,12 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_8_2[] = {};
+GlobalProperty hw_compat_8_2[] = {
+    { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
+};
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
 GlobalProperty hw_compat_8_1[] = {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 84d6819d3b..aab97e1527 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1543,7 +1543,7 @@ static Property virtio_iommu_properties[] = {
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
     DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
-                             GRANULE_MODE_4K),
+                             GRANULE_MODE_HOST),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


