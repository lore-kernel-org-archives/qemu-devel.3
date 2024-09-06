Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE87CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTXR-0007mh-NI; Fri, 06 Sep 2024 03:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTXP-0007fW-UF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTXO-0000hp-Fy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725608264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7T/GiHajNDfQrOhmjStv5lhEoWWSSNNggx/DwKqObjM=;
 b=H+aXdYivYo5a9rMdHaDZ8SBS080R6mCt63XS31ZnD40WsWlrrs/8aCkhMMDRnBCJlbdEHw
 HHls7oU+LlsZ2d8jpa4xTyr5sYVn5v0iMTaRULQcR4ojuqsPhn5bDSF53S45h8KsYUdKfi
 XkeUxqvZN5j3ZIxQBr3B6eKrp6Usv74=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-O-pD5bhBNAywD3nCdT-GIw-1; Fri, 06 Sep 2024 03:37:42 -0400
X-MC-Unique: O-pD5bhBNAywD3nCdT-GIw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-428040f49f9so13566745e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608260; x=1726213060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7T/GiHajNDfQrOhmjStv5lhEoWWSSNNggx/DwKqObjM=;
 b=kIMNut7jnalOyT4qqxX5Pnl4E8DlHiG7xWAenlb7ACGXYN83qza77qatV9f31O0DB8
 VseHcnG6MkfUniPQSScRf8N+wcrEmbNml/SxOYSpAonmhoH+dGK/SmY1GCB+JST5Ur0L
 a8cPjvl15LyXh4RI42b+WAmFFkO5fVOSX2DT6jfO06SevE8qRA4nPivx9O/78QYaKEpj
 FYVV5VQmF6gFv2DDuCHYzJVWeDxYg8rymvgXNdWh8nLLD4Gyv7bEI3BCUbv+jK/9idte
 MDi1Kjc0rsroDjbRRhzNFd+ptx51NafkRK4iuLJkJTDzagq4E7nDNhw4NOA+mxw8KgC3
 l0aA==
X-Gm-Message-State: AOJu0YwZIdn7ND0K4/bSpb1KWBk+QEv89MdvQW/FWh2YlkhlWGtJV+kK
 NENyd+PhhOcuB0utpcuum/ed57AjHVApCF5rCdruwkBsGc6mj7lt2i5UKvf0jp1PXpr+H8Mu6uy
 ZBl+kujPpIBLU3/VZ8C+SYY5ud75yn6tFrL/hlUtfBggNyNBW3jo93w44IArYk2eBdS5go6P6YF
 swM41I1vRgdFvNiUf3YoHZ3OQ3AsnooVIoxWdIbMs=
X-Received: by 2002:a05:600c:4505:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-42bb27a9ca8mr203560725e9.28.1725608260587; 
 Fri, 06 Sep 2024 00:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH5mupaTaA63fNt0hyF79YO2iO1hRDB/cB26Qbhz2WIz4zvrNRckKc6XLdRGucCeU8LEJ3eA==
X-Received: by 2002:a05:600c:4505:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-42bb27a9ca8mr203560535e9.28.1725608260036; 
 Fri, 06 Sep 2024 00:37:40 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05c6fb9sm11265925e9.7.2024.09.06.00.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:37:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] virtio: kconfig: memory devices are PCI only
Date: Fri,  6 Sep 2024 09:37:37 +0200
Message-ID: <20240906073737.493254-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Virtio memory devices rely on PCI BARs to expose the contents of memory.
Because of this they cannot be used with virtio-mmio or virtio-ccw.  In fact
the code that is common to virtio-mem and virtio-pmem, which is in
hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI is
set.  Reproduce the same condition in the Kconfig file.

Without this patch it is possible to create a configuration with
CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
compilation failure.

Cc: David Hildenbrand <david@redhat.com>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aa63ff7fd41..7c554d230d8 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -37,6 +37,7 @@ config VIRTIO_CRYPTO
 
 config VIRTIO_MD
     bool
+    depends on VIRTIO_PCI
     select MEM_DEVICE
 
 config VIRTIO_PMEM_SUPPORTED
@@ -45,7 +46,7 @@ config VIRTIO_PMEM_SUPPORTED
 config VIRTIO_PMEM
     bool
     default y
-    depends on VIRTIO
+    depends on VIRTIO_PCI
     depends on VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MD
 
@@ -55,7 +56,7 @@ config VIRTIO_MEM_SUPPORTED
 config VIRTIO_MEM
     bool
     default y
-    depends on VIRTIO
+    depends on VIRTIO_PCI
     depends on LINUX
     depends on VIRTIO_MEM_SUPPORTED
     select VIRTIO_MD
-- 
2.46.0


