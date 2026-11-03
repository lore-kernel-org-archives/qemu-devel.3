Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F1606D827
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cd+kI/cS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qLP5zsEr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2S-0003l5-Uz; Tue, 03 Nov 2026 06:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2R-0003k5-Pm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2P-0000LR-QY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHKNN3BJbuzXQxrUE+/Ofxxpwwy9gN/qPKU69iR6cNE=;
 b=cd+kI/cS5LJwasOx3cCKHqAsRzozcJEO0WaWYpBo/2xonesyEAlaFjgUKa1WNSI9Y5uybe
 SwvnQPPpxm9Z17jagePaS/yrKhfG9a/TRwzx6JGm28T+CGmhn8MadoyrHa6VcG99Gy0frU
 77sZyCEC1MgkYG8whxgsE9WhfOA4j5Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-HOIOmq62NLiOm5JcRNzjvw-1; Tue, 03 Nov 2026 06:50:47 -0500
X-MC-Unique: HOIOmq62NLiOm5JcRNzjvw-1
X-Mimecast-MFC-AGG-ID: HOIOmq62NLiOm5JcRNzjvw_1793706646
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b0a199b20so3444975f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706646; x=1794311446; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UHKNN3BJbuzXQxrUE+/Ofxxpwwy9gN/qPKU69iR6cNE=;
 b=qLP5zsErhsBa5SJX1vSGgyBm+blF/wFWVjCPIRbt8XaksxrKWnsz0YxcG3aElkPUFb
 QCnsQWo7yFYHrruA/6qfcSjwy9bdMwAKWV7InYDycTFt4pttNQ6Og7olbLW5tA3PQZMd
 d4r/+ZTVWIYmm0WqLWjjkId+3xgIpHKdZ806Cjs9qZMQHsfRwasYk03lOp4+hu0vFrFn
 58QwzWY66OVqO5PPhMo0+z0pzuSyVQDAmk9X52143RMYVd1e+OiHLz4q6kH7hik5FeEV
 VEliLo7PGBEGeLyYIY93BE1Nct95yMDxPgSEU+lvrZqXEWjxo/6xmlqb0o/s5Aa1C/FK
 sffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706646; x=1794311446;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UHKNN3BJbuzXQxrUE+/Ofxxpwwy9gN/qPKU69iR6cNE=;
 b=wMYSFrdO/hqcIMsNeije+m9VbNiKYN37OyRW9jbBCCq8k4w/2BKDFS+ZUVliXFaZAa
 JOTW7l+NWrXsJOLBGkNp1aiXsd5B/n7S1tns5BrEQTRWUGWodc+L16uG2m0ySq3CghnU
 BGoUHmQViQG0BQADh3z7/Zp+yPFH4Dd5Uo+wWccEkic17NOAn7YIS4hfBWEuCG2E70S6
 ha2wBmkidV3J0Lu+2EUThbDAlTktHUgD8fityavZuaPAr3HHCGz+GC1CeJ2b9vjSjNNC
 vlwU6BymsRO/+JqPYTyDVMLiFSwQ9E8DXHpdLygGBv+Oh9qMZ3kJc1EYUjjlZ01JijbV
 97rA==
X-Gm-Message-State: APuU4Z8++afcvoENB2TgWazVSL6QuuH9/eA3EJHzZU7+jOjYQ5drIu9u
 IgI54tMlAR2z6vj9eOZINdCKgsdSSx2I5e7vI/OZY+rCwbgiPWdJ9KAGVaKouFGXvwtrHCjqgHf
 moaEp+i6lvX9jcUKrtF+r9DW5GwGROs0R3bJLgAZh3ir5GOfzKiuHC2ckcQM/74veg87G+XBLwo
 D2zoCqx18ZXhMWKWJA+5ITE9gACnN0Ba9duA==
X-Gm-Gg: AYBFou1EK0MxHfOZ7DeJXVuCFHlpt5sZrgI4SJjMQ4v1qRpsm4OX8cRWgACCJzs9kS1
 Vv7IFVZ1p6HvC9SX9/idAi4K7dIHR9TEMuENEmWnn3fqGKHPeBZUWhes78I5luvcf62Can458wd
 9V2kHbJ7B+39qs4v4oVAIxzQHWwEDagEnR/NB5Jpjj/R53pM7yoT/WGvat1a2XOofJqtupt1vij
 jtnPxWUSM2pUS/mHwpxxsgEaZcj8dbBJd+Jq0bPTfZ/mkLiqtuZpXMGG9uTezfESiWOEQH3aICl
 2C88ZpwjrvAAZR0lD1RvgkU7Z9C/YIHaP2Me6ObJq4XT9k2U8scc/sW2Vbc8zsX3ZZaGT56fDtL
 Knh37kahFiUXmjOZy1Pf3rUr4Ru8Umn3gW/Dt8zKdVA==
X-Received: by 2002:a5d:588a:0:b0:48e:932:af0b with SMTP id
 ffacd0b85a97d-48e6e4f6a88mr28298086f8f.32.1793706646363; 
 Tue, 03 Nov 2026 03:50:46 -0800 (PST)
X-Received: by 2002:a5d:588a:0:b0:48e:932:af0b with SMTP id
 ffacd0b85a97d-48e6e4f6a88mr28298017f8f.32.1793706645754; 
 Tue, 03 Nov 2026 03:50:45 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80eb1sm26123209f8f.34.2026.11.03.03.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:43 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/17] tests/qtest: Enforce zero for the "un-fired" msix
 message value
Message-ID: <370993e916a0b5f35c3284355e373db654112310.1793706601.git.mst@redhat.com>
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

virtio-pci detects an unmasked msix interrupt has fired by looking
for the data payload value at the target address. If a value of zero
is enforced for the memory value when an interrupt has not fired,
then an assertion can be added to catch the case where something
changed the memory to an unexpected value.

This catches an endian conversion bug in the message value when
running these tests on a big endian target. Previously the test
just times out waiting for interrupt, after this it fails nicely.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-2-uverma@linux.ibm.com>
---
 tests/qtest/libqos/virtio-pci-modern.c |  9 +++++----
 tests/qtest/libqos/virtio-pci.c        | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 4e67fcbd5d..f31b3be656 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -137,12 +137,13 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
     }
 
     data = qtest_readl(dev->pdev->bus->qts, msix_addr);
-    if (data == msix_data) {
-        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-        return true;
-    } else {
+    if (data == 0) {
         return false;
     }
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
+    return true;
 }
 
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8c2..102e45b524 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -132,12 +132,13 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
-            if (data == vqpci->msix_data) {
-                qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, vqpci->msix_data);
+            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
@@ -156,12 +157,13 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
-            if (data == dev->config_msix_data) {
-                qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, dev->config_msix_data);
+            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
@@ -323,6 +325,7 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
     vqpci->msix_entry = entry;
 
     vqpci->msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
@@ -355,6 +358,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
 
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-- 
MST


