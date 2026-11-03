Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE4606D838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EgviBV72;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tAQeUHm2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2V-0003ng-Vc; Tue, 03 Nov 2026 06:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2T-0003lE-KJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2S-0000Lb-2O
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLXt3FQxlARNWg3uYE2Yv1IT4qzgDEC1brvODdILLZU=;
 b=EgviBV72ozyZdKv/pF4SI60E/XnBIWmiI5uXdtlCEaRjMEPyh4vqZkAue0r7uzrys/znjK
 mfT0vU+Wb52hYB5UPI/r0srTfxiO4zd/BP0uR5DT9rpCmi9zHcr7a/mgtbz86SxCylo965
 dHb4GNywQFaIdP8/aSbph2YuqDNYO9s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-WWOGsqygNUG0VvqmRqkv2w-1; Tue, 03 Nov 2026 06:50:50 -0500
X-MC-Unique: WWOGsqygNUG0VvqmRqkv2w-1
X-Mimecast-MFC-AGG-ID: WWOGsqygNUG0VvqmRqkv2w_1793706649
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso35083555e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706649; x=1794311449; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RLXt3FQxlARNWg3uYE2Yv1IT4qzgDEC1brvODdILLZU=;
 b=tAQeUHm2aHLfjM6F6kOoRm9FyvXYXShXQp0t+zoippImK1/HfcMjmA9dQdvmj3xEx/
 7lgPGzguqpIquT0ncksrGJ2SVgp3t/O8quvMNVpssUu8QyJXIT6RsVEDWtfJo7Q8UoUg
 4UHgo4z2lHeJfu8mrgSEMdnPt4xJWH9WtFstQ/i4Q/hbToTSk0dl0E7aXwjwF9U9FP8E
 RyqxR0dUGmAwSf8yopx6Bd79ugqwWwz2XAFYm20gwTCyrW2I/vlKtzQtpRCf8IV11q7P
 8QfmfzDdBZnCFrhFN65C8yJCxbfKRl7X3hIKfqf8xRbIAwWZdBtKF7DDuxLa+GX8Omyj
 Mlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706649; x=1794311449;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RLXt3FQxlARNWg3uYE2Yv1IT4qzgDEC1brvODdILLZU=;
 b=sq32ViClx2HiV+Si/NW0XG/4mkr5LvGZVdoVnb/tcBtFSJuiLsYl9topgVNDQKa6qt
 LNjZ3M7GgyHmUFGnEZKjt8eZVfLxd6lLDZvMRIojJ58JZdTHB7tf/Yb2sGa9IgSeiBKr
 B54JgxJAGK996l2i2AUN2Ux1fSMCvkb0Adsnunj4SQrVg0TUee9sOLNOSKiQdk94aYYl
 9xxo9+9vQOrgJMPUo+T/xFZhKaZnw4y+AmQZfmRQ+s8sP5FMqQJ9dYccLiCdx7kltzcK
 gm7Ed+A6FRH8pK8S6cgZecRGkA8eaCqcqBpJf52mqOYy5qmNVrzXvYi2aLE4p/PAiJ/7
 tONg==
X-Gm-Message-State: APuU4Z9l3M2kULbMkAcwuWRa33OSa9ZAZVTooAtMq1jKTf0j3c1X9uju
 uo5l2a9Le6VGhZFaX+tEyjWPRI2OcRkhC50LpK4XQ89S8qXF/OtPy201zwgBvKyRzf902zglXRj
 DnpiMLnWJHglID+as1qVv5xJh8+hVMu62bhnMGAwt+dccgY12uZpROX+OYucXgpKIFIeP3oGyTL
 G9KLTYrwfdBi6fX7vgEZgOfm42g7XtCjdAww==
X-Gm-Gg: AYBFou1PBE6XAc5CrdYyt5cntZ/Ru8+IwBZhpVdca5prt44RtBinG6jOWCuFNyD6ZE/
 Di4vP+Yf+dVJCLiSSzRWSCioopzZO5k6/J7jRVPX7TCqcN8gBUCVfJHsgcahj0zzXXgeYvdSt4s
 4O/T5xW216wwt6s5rQ3karzIaHuoXKuJ56mZtKOvDw2XoFDNI8JSByJlOEdn3LF0Fn6BY4ERSjX
 aH2G64mpNOshJ/7ezlxEyhy8OYdk2LXn7mU5u8JOwmxAjmzr3aMC9HJ1bJs61p9uhZEj1ThaFxh
 1GYYM0ApUckEiqfjru9bZ49v3uCGJyPHYQIHOdbfu5I1MvVa7RGKT09Dj4pQmFs7JZuOhzorcl/
 +5X2gIrQebSYK25yDbWh93+Syp/3YkB3IX3Pa+BVM6g==
X-Received: by 2002:a05:600c:4e44:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4ac1932a2d5mr302022505e9.34.1793706648841; 
 Tue, 03 Nov 2026 03:50:48 -0800 (PST)
X-Received: by 2002:a05:600c:4e44:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4ac1932a2d5mr302021875e9.34.1793706648260; 
 Tue, 03 Nov 2026 03:50:48 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad5ff8sm233079665e9.4.2026.11.03.03.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:47 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/17] tests/qtest: Fix virtio msix message endianness
Message-ID: <8d082458a3abf01babe570f19056b896fa7b14e9.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicholas Piggin <npiggin@gmail.com>

msix messages are written to memory in little-endian order, so they
should not be byteswapped depending on target endianness, but read
as le and converted to host endian by the qtest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-3-uverma@linux.ibm.com>
---
 tests/qtest/libqos/virtio-pci-modern.c | 4 +++-
 tests/qtest/libqos/virtio-pci.c        | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index f31b3be656..097b548f95 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -136,7 +137,8 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
         return qpci_msix_pending(dev->pdev, msix_entry);
     }
 
-    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
+    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, sizeof(data));
+    data = le32_to_cpu(data);
     if (data == 0) {
         return false;
     }
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 102e45b524..d2b978d4b1 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -131,7 +131,9 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
+            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr,
+                          &data, sizeof(data));
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
@@ -156,7 +158,9 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
+            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr,
+                          &data, sizeof(data));
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
-- 
MST


