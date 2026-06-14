Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E745CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqA4-0007Sq-EX; Sun, 14 Jun 2026 15:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA1-0007SF-He
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA0-0001h3-30
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=quBGMyZvRLeAt5zE1TZqXrT5mUZTPeEKhm1BaiYb7mU=;
 b=IFJaEqnOwDLTgRbcg6A1gdGqmkBDZ4YetGVRa5G0CGa7nf8SlgIZKHoVZrlskb9qp07/LE
 j5eQbrIXNJBQh5E69qnBSg1hRu0x0nIMJRMDDZeeeIbhCF8yPmmoKkQ//7eVZHkTvSCDr2
 ItnaJ2MmvePBHLTzZ2kPt6oKlz2PFa4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-eoyMMGMYNseCs8h5aet33w-1; Sun, 14 Jun 2026 15:06:18 -0400
X-MC-Unique: eoyMMGMYNseCs8h5aet33w-1
X-Mimecast-MFC-AGG-ID: eoyMMGMYNseCs8h5aet33w_1781463977
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4601102c30dso1474229f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463977; x=1782068777; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=quBGMyZvRLeAt5zE1TZqXrT5mUZTPeEKhm1BaiYb7mU=;
 b=tbzFyA2Wtxprlc07ZxkqsEBNiLeuYPHkVibtveuYk0+eC4Bbg5s/OIxwtl+p/vUmQ3
 51oiFeJsGV4DSgynkUWns9cWg/XkASRWNh/HYXg1uKW/zmqYj1lS2XwirePPg3Bma9Jc
 SVD1tL9XsGx65SNyxgUKGgLSrq7z+/a2sXX9mnIkNJj/4+bi2hf3O6RbpLoYwjd/SkEk
 08cZTwWSHaifT0IojrFpYNoUS1TxMw2HBdvg/U3wf2RS9CQTuN7cGQysTCfo1rgPiz5i
 /fn4BVaMR3ymHuTAC/qqLo5PRS65OxTJifteiHrAJFjecVUZ0S9Bd4wgluVUdCuxxI1V
 kUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463977; x=1782068777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quBGMyZvRLeAt5zE1TZqXrT5mUZTPeEKhm1BaiYb7mU=;
 b=FFoATgqpeYNTDCEo+CirTHLy9LlfIXABgSoPWz0huQN2P8YLwZrFNwOvFwQyYB4Z/r
 cN3NlaXkxhcaDT9zWPz8pmXFOqItqqhvqrj1R1iQDknWRbCtNm6xaa1V8hHbnBOEFn0p
 cdwnVlhs1HDkqL0dy/Tbw89IWTb/m0Ilbdd9mVQwTORxa5Dpi/gUIQVjZbMGCvx4x3cJ
 +TTfm3asxgmagS5oX0l0yHkaIkwK4ChaR669gNcHFZR+MHErs13W/IJ5NCy4UDWLEWLf
 34D2HFGIprdUAaPFxgMrwLiJIkrT2DBXn3QExuGT++6zf/OyX7nEXlnHqsb0x54R6asS
 kkkw==
X-Gm-Message-State: AOJu0Yw7CPckvDpUwrFW6wHoCoDFmbpth70YgVNOgrWTyrsaPalkKThL
 BIiFqvclqcOhZBVjMvTOkyEWbmuDGd9/WouqNf6XfJKmp0FgJ06SGgrHzI3TF4wI2P2h0L1rCGS
 XJYyFaaFcuPtmkemeH2W6+bUEGI/54DNne25DFlQ2/DLrJk5pncFeJznodBlXg5rSBzByyJokKf
 o1xRAIBK8BauLeV9uNcvbDoynoPaI/4J5PnQ==
X-Gm-Gg: Acq92OGRz/9stnP24zduB7CZcqtewRbemehSfJeKyWb6FXGBq0ibhC5dNUPBxKkj7pz
 IReh5vbbEtOU7k7YJbKbQnMtfYLeOivuH3hsxQewP9H9rzC5O8HvbXASTOxqPB+IxOTFkEMGBzI
 T1Hub5JJKOgpdQtYX+oGkJrqJlDnqJFGHwsWfaEy6REZOneoG5+TA7gCk+qYGsdeNI1tivEFqby
 E9kEjypDTZOJb0PZUuUJrMYedq/TbaclSk0LiEmgKaztRwBpIfOykL1yjNGvx8WUaxdw/0Nnuw4
 mGrAyycF0XAmpNWlrtfg+AhaT6qGLOlA8BhV0FwvGhW2blEIJUfxsnrx+/DOcUo/wG2pEkVQ3LL
 oumUcdRfbMSbbIs0A+zcEanhZz7TaQYc9Kbg69tkTmy8=
X-Received: by 2002:a05:6000:188e:b0:45e:f271:5019 with SMTP id
 ffacd0b85a97d-4606db8c6fbmr15470680f8f.14.1781463977039; 
 Sun, 14 Jun 2026 12:06:17 -0700 (PDT)
X-Received: by 2002:a05:6000:188e:b0:45e:f271:5019 with SMTP id
 ffacd0b85a97d-4606db8c6fbmr15470642f8f.14.1781463976551; 
 Sun, 14 Jun 2026 12:06:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm27635846f8f.21.2026.06.14.12.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:16 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 013/106] intel_iommu: Fix PASID validity check in fault
 reporting
Message-ID: <dde3f966f0fe57fa29af664d9c9cab290f3c00bb.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

The current code incorrectly uses "pasid != PCI_NO_PASID" to determine if
PASID should be reported in fault records. However, this check happens
after the code converts PCI_NO_PASID to PASID_0 in scalable mode.

This means that for requests that originally had PCI_NO_PASID, the check
"pasid != PCI_NO_PASID" will incorrectly return true (since pasid is now
PASID_0), causing fault records to incorrectly indicate PASID validity.
According to the VT-d specification, the PASID field in fault records is
only valid for Requests-with-PASID:

  "When Set, indicates the faulted request has a PASID TLP Prefix."

Fix this by capturing the original PASID state before the PCI_NO_PASID to
PASID_0 conversion, ensuring fault records correctly reflect whether the
original request had a PASID.

Fixes: 1b2b12376c8a ("intel_iommu: process PASID-based iotlb invalidation")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-9-zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e15aecf5f9..539e8f5763 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2109,6 +2109,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
+    bool is_pasid = pasid != PCI_NO_PASID;
     uint8_t access_flags, pgtt;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
@@ -2235,7 +2236,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (ret_fr) {
         if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
             vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
-                            addr, is_write, pasid != PCI_NO_PASID, pasid);
+                            addr, is_write, is_pasid, pasid);
         }
         goto error;
     }
-- 
MST


