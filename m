Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7528FC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS47-0005VU-S9; Fri, 21 Feb 2025 07:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS44-0005RR-Bf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS42-00075N-SQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBBtVaw1c6M0PAlbeQ2HLOqmT0Z/NhHMcRyXtUTwOIA=;
 b=IhBhVpuxXhrMmCQHBRnaCcASLbg3dSlSuD8WxSK6gFloCKVftGvuG/lZMwMjwgb9pLA3RK
 12KA2MD/xKcNj+bjSrSIgEcUGIhDRKA1QoH6B5JyH2h2eFr7OhIqIpFXiWPjXdLBF2E1aQ
 UJF2pUddzE+zrwZRmPInhLP7nTgxIPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-ARkWdfcHNcGqD0AgIxqPtA-1; Fri, 21 Feb 2025 07:23:29 -0500
X-MC-Unique: ARkWdfcHNcGqD0AgIxqPtA-1
X-Mimecast-MFC-AGG-ID: ARkWdfcHNcGqD0AgIxqPtA_1740140608
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f2c0aa6d6so1468654f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140607; x=1740745407;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aBBtVaw1c6M0PAlbeQ2HLOqmT0Z/NhHMcRyXtUTwOIA=;
 b=dWpU7szLcbRuu/fMCh16u59JofwOnDrGSGm5mUZg9rs88+KxhW/rwUvP5tbjewcxvI
 sB/9ut1GXh1aB7JxwyHiyL9T5BjAAu9vfQvRp9AnsjL4NFHA8XHdD6DKocW+muWztw0f
 +Er5O00gJKID+r8jx3YRDUadV7iDu4yDXNQDCKzG2FQw1q2ualytnUaNKRo8GH0W6QLd
 PgG5Fzx9zfTvUeA1vOWRW+8xeRECiRhx3Z2zcfEZHtsoMoPqW0cGS6hT4usfeLHmgdvZ
 pmUIBs0gEIqsjEpxWCPlqdwQmVDYYJyJsyNK/R0mpI5B+Psf3/GR2YkQwbyqrDHFz30v
 +hsw==
X-Gm-Message-State: AOJu0Yxx+K8rWG2f7pd1Jzu4vScrzC+paPUymao0DnxD1TXuHeJh9PDD
 /HKEKhSMx3v7TB4W8IFzNn2xS1uyOpd1ojPg6dQSn4sPBFkiXsSJwNGahI+SzjrP5kbUt3ueO+4
 wcap2roXvEo3Xqhin1uzHVZCP+ZmKYgIqi+ENXwi8G6eSvICGZrvLnGr0va2gvbr/c2w2BhfnG1
 tBAOY1Ue1eOhFf8/6AT9MRJRvueowX/w==
X-Gm-Gg: ASbGncurWV1LWOExyHt+4cNCA2cNtWu4YNaNG+hhgSWJ4tmlR0AVxXzQJqrl7ABiUBR
 rzoJHhFBRMTjRD1ImH+pwvMBsUxLe+9aWIh6PxyGyQpZddJb3tK2jIzffBVRgRErdD0Q80L02kh
 OC7F+NGQSsfGKo+EUsXXLfCeVVjQslP8ANow9YiKbiPOAM9U70SNpPJiOkDRO03JcAuEjq+a0ve
 xRPkluaMVKuTAyy9+4SzQYFM6+3qVZ+B8E9cY2TbWXGGmQ8+XxD7vZBI/lC4sEOOjR3RxfLl46G
 zT5jfw==
X-Received: by 2002:a5d:47c3:0:b0:38d:d59c:c9d6 with SMTP id
 ffacd0b85a97d-38f61611400mr6413998f8f.21.1740140607484; 
 Fri, 21 Feb 2025 04:23:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAuxjCF3ZwRwvuDWVK/vDileVZBX1yVedjgRj6UPj+N98Yk4D2pum8pMv3NfyhVP6GacQS1g==
X-Received: by 2002:a5d:47c3:0:b0:38d:d59c:c9d6 with SMTP id
 ffacd0b85a97d-38f61611400mr6413967f8f.21.1740140607019; 
 Fri, 21 Feb 2025 04:23:27 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0372124sm15539275e9.39.2025.02.21.04.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:26 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 15/41] hw/pci/msix: Warn on PBA writes
Message-ID: <44ed44aefec571041fe3b3a8b6849613a74b520a.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Of the MSI-X PBA pending bits, the PCI Local Bus Specification says:

  Software should never write, and should only read
  Pending Bits. If software writes to Pending Bits, the
  result is undefined.

Log a GUEST_ERROR message if the PBA is written to by software.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20250117172842.406338-2-npiggin@gmail.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 57ec7084a4..66f27b9d71 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -260,6 +261,14 @@ static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
 static void msix_pba_mmio_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
+    PCIDevice *dev = opaque;
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "PCI [%s:%02x:%02x.%x] attempt to write to MSI-X "
+                  "PBA at 0x%" FMT_PCIBUS ", ignoring.\n",
+                  pci_root_bus_path(dev), pci_dev_bus_num(dev),
+                  PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                  addr);
 }
 
 static const MemoryRegionOps msix_pba_mmio_ops = {
-- 
MST


