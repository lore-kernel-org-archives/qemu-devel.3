Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E40AC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qH-0007Jp-0t; Wed, 15 Jan 2025 13:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pN-0006WS-2l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pK-0006ZD-Dt
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kdtm+2f9V+BfEyWZHZKI78yzC3XfKmF43hh2EJ0QkBU=;
 b=iuZ83PR9R7dwJ3EmYQI+vHrpx6GjCOsrkHMNbnb0XVzVrPV/7XI0d01pLhx3xtfFeDcoI+
 uGA/SiGtxLyvj7Dwri3fgHdSdovpiKPsat8poFe+iBLL7ceOMBwhlM74/Bv6VzflgA5f9P
 R20CrNW6UqS5YlZhuYjf9N/pNeVA0ek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-NFaMRDEqONmOl-ytxdT4wQ-1; Wed, 15 Jan 2025 13:09:12 -0500
X-MC-Unique: NFaMRDEqONmOl-ytxdT4wQ-1
X-Mimecast-MFC-AGG-ID: NFaMRDEqONmOl-ytxdT4wQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso37116445e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964551; x=1737569351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kdtm+2f9V+BfEyWZHZKI78yzC3XfKmF43hh2EJ0QkBU=;
 b=vp94kiKw7HeH9JCx9PdxSjQSEAIDvj91pO0oQr06sVb5/5BaNx3Rjf5C8tEQGgKUzb
 NWvM8RoS76C4+phn4MBn2oDmy2SyJcIeIfHtsjh0sn1jOhVpI1hfTipuKN6iQwgHBTZA
 t2deo/ZyaxUb0ozZxgZRotmvgIEXmX62v97xUtfqRPVLS4adPQPeF881TIW2FkR77fOV
 EO7Y07ky0PBiwWAeYZIxMUpi9b+0rrLjPvrxhiz0DRsrIG9I7oI7Jg12FDm8oxA0lVX+
 iJawRHgroEHEfM02Vi5cyhQq4JMOYHEJCxxSrCQi/HJF85Zbupr0nbLu9Tge17Wr+QYc
 TrYw==
X-Gm-Message-State: AOJu0YxQx8FLzYa6QG6A/C9uutzMe1LVVlFJAv+2F2OsVfdO79zyH5g/
 Yr/lQ5lWOFZyMvtJPDVNU8e3OXFYDd6dpujZ+JQLw01yxOO+JV+LxeZtyfgclLSjuxflfgPjIn1
 IsqOo7kbVtTk/HV9HdRO3y+83B058t6EJr3RCS281kJaKXlequMEFLZElJ2zAs9UyaNxo+TYfRw
 FSWQYN/9PalQOLtVtYo9k4HC8nhztXbg==
X-Gm-Gg: ASbGnctiqA3W0ohRFGaidm8OjsvFzlDPWbOVDUgRZ2eIOR1DuJM71wvKUKt3tFQzCGp
 kHHCIUUKCpC1hKwHVMdsCl0ggRtc9yPZBh9kFPTtPXjZjvvvw6cFCOXrknkV3XaqXOhzvSR8JWA
 IoCmQQVKN1H9PA1npO/GwyUcZfq3lAy1R0TEmswniJ6VWGYkRCNK2Qnef0ViTEOkmyKntNeDxHw
 sUPYe3CaSrBUxchcgv8O7cRz/ZndgKh3YRAfjKzBU+CnSezHp1Y
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr299616505e9.0.1736964550879; 
 Wed, 15 Jan 2025 10:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6r9jsTuGkN/DnN9sXfOyIUHCV42SN+NOxRTvQ8WzYfUKaQQdiJuiMDdPuVCkKO+InLPw5XA==
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr299616035e9.0.1736964550413; 
 Wed, 15 Jan 2025 10:09:10 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499942sm31161245e9.6.2025.01.15.10.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:09 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/48] intel_iommu: Check stage-1 translation result with
 interrupt range
Message-ID: <fed51ee5e02d8779ccbdce555e556c4ada321281.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Per VT-d spec 4.1 section 3.15, "Untranslated requests and translation
requests that result in an address in the interrupt range will be
blocked with condition code LGN.4 or SGN.8."

This applies to both stage-1 and stage-2 IOMMU page table, move the
check from vtd_iova_to_slpte() to vtd_do_iommu_translate() so stage-1
page table could also be checked.

By this chance, update the comment with correct section number.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-9-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 48 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3959fe44c7..d53ce01e82 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1138,7 +1138,6 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t slpte;
     uint64_t access_right_check;
-    uint64_t xlat, size;
 
     if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
         error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
@@ -1191,28 +1190,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
         level--;
     }
 
-    xlat = vtd_get_pte_addr(*slptep, aw_bits);
-    size = ~vtd_pt_level_page_mask(level) + 1;
-
-    /*
-     * From VT-d spec 3.14: Untranslated requests and translation
-     * requests that result in an address in the interrupt range will be
-     * blocked with condition code LGN.4 or SGN.8.
-     */
-    if ((xlat > VTD_INTERRUPT_ADDR_LAST ||
-         xlat + size - 1 < VTD_INTERRUPT_ADDR_FIRST)) {
-        return 0;
-    } else {
-        error_report_once("%s: xlat address is in interrupt range "
-                          "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
-                          "slpte=0x%" PRIx64 ", write=%d, "
-                          "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
-                          "pasid=0x%" PRIx32 ")",
-                          __func__, iova, level, slpte, is_write,
-                          xlat, size, pasid);
-        return s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
-                                  -VTD_FR_INTERRUPT_ADDR;
-    }
+    return 0;
 }
 
 typedef int (*vtd_page_walk_hook)(const IOMMUTLBEvent *event, void *private);
@@ -2064,6 +2042,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     uint8_t access_flags;
     bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
+    uint64_t xlat, size;
 
     /*
      * We have standalone memory region for interrupt addresses, we
@@ -2173,6 +2152,29 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
     }
+    if (!ret_fr) {
+        xlat = vtd_get_pte_addr(pte, s->aw_bits);
+        size = ~vtd_pt_level_page_mask(level) + 1;
+
+        /*
+         * Per VT-d spec 4.1 section 3.15: Untranslated requests and translation
+         * requests that result in an address in the interrupt range will be
+         * blocked with condition code LGN.4 or SGN.8.
+         */
+        if ((xlat <= VTD_INTERRUPT_ADDR_LAST &&
+             xlat + size - 1 >= VTD_INTERRUPT_ADDR_FIRST)) {
+            error_report_once("%s: xlat address is in interrupt range "
+                              "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
+                              "pte=0x%" PRIx64 ", write=%d, "
+                              "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
+                              "pasid=0x%" PRIx32 ")",
+                              __func__, addr, level, pte, is_write,
+                              xlat, size, pasid);
+            ret_fr = s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
+                                        -VTD_FR_INTERRUPT_ADDR;
+        }
+    }
+
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
-- 
MST


