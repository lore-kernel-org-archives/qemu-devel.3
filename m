Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4677EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGG-0007xc-5n; Tue, 23 Jul 2024 07:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFe-00059w-Pc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFb-0002mw-5H
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRfxJi15v0LjYUfndDtOwJPZVyigXXbxUoHPnTtDziA=;
 b=Oo1rKhzEwgpFBD+V4bpKSuflUt/av0NHnpfCYa9QWJc6BlD0UxsfajkSepZVSPIWiUer66
 Gr4fhoEMiRHPcUO4Sr3u8vMgsUplBJT68NJp7Ujj64fXeMCQxlJDlQRXuoPjQzsutJ7Y6N
 pufUEv4/X5akMoJKMiI8uTQ2CoOPPSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-jNiqqswuOdahHBROYyDtdQ-1; Tue, 23 Jul 2024 07:00:08 -0400
X-MC-Unique: jNiqqswuOdahHBROYyDtdQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42667cc80e8so40125375e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732407; x=1722337207;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RRfxJi15v0LjYUfndDtOwJPZVyigXXbxUoHPnTtDziA=;
 b=K2SrzxIERDgeoQflxJzv2yjVwHxlB7qfGG25EnJSvAnrmyLBTPToW8P7m4w8zkI5aq
 WvxLhISWYDpfO35b6aALWYfG5cT9HnCQJ02pLMFKlB9yOv4cNT2+AACMJsnfRJca5fBX
 LHGqmzZWSwInxB/NkB8csoSu+M7u783BZyDejwigN7DoQqzC8UDHj5sefIpuAlzh0kHV
 YRhXgQvBSD4CBKCE/X6LU2LVb3yocYvKPzOI9xhgajJEMwMS58cTTSJ1dghDlMoof80S
 DCfqIuXK4wQOCRkhsacSmyRnnrBevg9UST2k88U2UksGoo14m+T2i79jZxmy5BCeychd
 UdJA==
X-Gm-Message-State: AOJu0Ywvue8/KoUgR8+hDFJpTwms3b5qwERShdktlIqvYN5Qr077LeQX
 nzcAjp6hOlCSQBvkWJqP3S2Sgsjd7SSbMPXsTcQZjAoKV9ZExdSomfmNfkdWZTgEYsID/cb/p7d
 ULyoPb2uqQ4qzq+nX+VvNUpUrRa0rrhgrIbM87yNbst4F3uzHvo8xPhEhYr5WRMMwqIEcmiT0Yt
 072lAB1XT8lQ+OO3cvyECfS3SvSt1t4Q==
X-Received: by 2002:adf:a3d2:0:b0:367:9903:a81 with SMTP id
 ffacd0b85a97d-369dee57a01mr1656352f8f.43.1721732406696; 
 Tue, 23 Jul 2024 04:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs4ZaqvDfD4PGNpyQFZizlutPINy7iS7blsqX23Oh2qTn92E6vzYIzyMcF8jI5zDmzLyyP1A==
X-Received: by 2002:adf:a3d2:0:b0:367:9903:a81 with SMTP id
 ffacd0b85a97d-369dee57a01mr1656328f8f.43.1721732406036; 
 Tue, 23 Jul 2024 04:00:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878811bedsm11225122f8f.117.2024.07.23.04.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:05 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL v2 46/61] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Message-ID: <62ac01d1de5096022e08355f8df47bf1191a3ed1.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

We are currently missing the deallocation of the [host_]resv_regions
in case of hot unplug. Also to make things more simple let's rule
out the case where multiple HostIOMMUDevices would be aliased and
attached to the same IOMMUDevice. This allows to remove the handling
of conflicting Host reserved regions. Anyway this is not properly
supported at guest kernel level. On hotunplug the reserved regions
are reset to the ones set by virtio-iommu property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-4-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 62 ++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2c54c0d976..2de41ab412 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -538,8 +538,6 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
 {
     IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
     IOMMUDevice *sdev;
-    GList *current_ranges;
-    GList *l, *tmp, *new_ranges = NULL;
     int ret = -EINVAL;
 
     if (!sbus) {
@@ -553,33 +551,10 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
         return ret;
     }
 
-    current_ranges = sdev->host_resv_ranges;
-
-    /* check that each new resv region is included in an existing one */
     if (sdev->host_resv_ranges) {
-        range_inverse_array(iova_ranges,
-                            &new_ranges,
-                            0, UINT64_MAX);
-
-        for (tmp = new_ranges; tmp; tmp = tmp->next) {
-            Range *newr = (Range *)tmp->data;
-            bool included = false;
-
-            for (l = current_ranges; l; l = l->next) {
-                Range * r = (Range *)l->data;
-
-                if (range_contains_range(r, newr)) {
-                    included = true;
-                    break;
-                }
-            }
-            if (!included) {
-                goto error;
-            }
-        }
-        /* all new reserved ranges are included in existing ones */
-        ret = 0;
-        goto out;
+        error_setg(errp, "%s virtio-iommu does not support aliased BDF",
+                   __func__);
+        return ret;
     }
 
     range_inverse_array(iova_ranges,
@@ -588,14 +563,31 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
     rebuild_resv_regions(sdev);
 
     return 0;
-error:
-    error_setg(errp, "%s Conflicting host reserved ranges set!",
-               __func__);
-out:
-    g_list_free_full(new_ranges, g_free);
-    return ret;
 }
 
+static void virtio_iommu_unset_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
+                                                int devfn)
+{
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    g_list_free_full(g_steal_pointer(&sdev->host_resv_ranges), g_free);
+    g_list_free_full(sdev->resv_regions, g_free);
+    sdev->host_resv_ranges = NULL;
+    sdev->resv_regions = NULL;
+    add_prop_resv_regions(sdev);
+}
+
+
 static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t new_mask,
                                  Error **errp)
 {
@@ -704,6 +696,8 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     if (!hiod) {
         return;
     }
+    virtio_iommu_unset_host_iova_ranges(viommu, hiod->aliased_bus,
+                                        hiod->aliased_devfn);
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
 }
-- 
MST


