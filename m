Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145CAC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7p7-0006PZ-7r; Wed, 15 Jan 2025 13:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7p6-0006P5-BJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7p4-0006XA-QR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53vmistltzrVou/xTWf8YxfnU3gKvkLoNxNSySUwMVU=;
 b=DrOExO3MsJBCrbOEWm5hzxJV0BXv43VcNCXGnVaZfk/WzX6gPLuxPy/HAfAy9pJHZojcHI
 xDzlQAwZcgGtl22VEODey4g+eSR4Y03eXtrlmQ/XksvTuFsY24LNVQ0oAujRmfCipqTrlG
 LwfGQC5qNNnW2c0WCaSu2Rcov3jJ5u4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-UcXeNrBiMrGb3PHqZ_-l2A-1; Wed, 15 Jan 2025 13:08:55 -0500
X-MC-Unique: UcXeNrBiMrGb3PHqZ_-l2A-1
X-Mimecast-MFC-AGG-ID: UcXeNrBiMrGb3PHqZ_-l2A
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e2579507so36138f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964534; x=1737569334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53vmistltzrVou/xTWf8YxfnU3gKvkLoNxNSySUwMVU=;
 b=gZkkGtWboydNJwZ3Gh6slQMfG+FEOuse03HKkD9RbPYEKi8BiqDQl5J00gD/clOV5K
 5OfKhmFEEZnrkUBHQ+xJZrQ6izj4h67USlXLqF+wkDGEWyCNXQz8DnexlcRA2epn3Pqs
 yYZHuhrrZ/OD9Q8K8D9oxqmxWW6Dn4xGcGqsHLEWTXpNeinUv9T5ndz8Zeub7aGOQxkX
 Of3Ag/zJko7QG6ItDFelI7Awydx2MFr6oUpknZ/U9p3CFwxzY7HsvV/0xpxK8eeB4Bim
 e/C3HevzXLqhZ55hWACus1WSZOI3RFmihvkr+s+QORoEH52XgNosYY9dEAainq7282V3
 mhwA==
X-Gm-Message-State: AOJu0Yw2Wojg0SNwnWGfwDktde47MxuQxdHw1nhZOjjtnztpEL6MSnyF
 eUCPO/+ntpXr42gEfamRYBHgarr56+VKBVQrBgEoUfSbtsrdA9Tzhts24F0Q4VJV/+FAyhDrnmH
 Qd3BkN04LBPGQcWfWNnQCWyMgSIwHVupeiVDvDhB+IZ2E3co62m8uDdvOu3AvMg1tTh7/wQM9kB
 WCLpFRgzZh8RRYVk/O1jrTO5PdzW+UqQ==
X-Gm-Gg: ASbGncs66kwpc65BVCCuSUMTEg8Zj7L8n/4IYKPYmU++8XP76Esje2W3oZAq6Jfk5qs
 s3MEfp1DOEBAuedF+fTR21LzpPyH/9w4cNBSSkePlfMNjBx5z5y9L3PQw96r4eW9xdGOTvt7Nz8
 QFgszzVLeEMBm9BKNhdF3yQT7CENuMLuWsB+oIYjURkCU5yL0OIyOLdJsk5/0XWUIJtLVLOUA1s
 T08NSt97xnUMhNDAM2hV+vgoTixPV9l6zTHNJ8ta7R+zesEN5JV
X-Received: by 2002:a05:6000:1847:b0:386:4a24:18f2 with SMTP id
 ffacd0b85a97d-38a8730adf0mr30686485f8f.25.1736964533952; 
 Wed, 15 Jan 2025 10:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX2fYI7at9FIo8s3RZXuB0hggqKBz8NCyGGATLJaiO+fP75UQmOINK8D7DEooOYHQy9g18Pg==
X-Received: by 2002:a05:6000:1847:b0:386:4a24:18f2 with SMTP id
 ffacd0b85a97d-38a8730adf0mr30686453f8f.25.1736964533503; 
 Wed, 15 Jan 2025 10:08:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d085sm18563905f8f.13.2025.01.15.10.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:52 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 08/48] intel_iommu: Add a placeholder variable for scalable
 mode stage-1 translation
Message-ID: <791346f93d2aa3b7eaebf4a12f4b7c558e94ff6b.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an new element flts in IntelIOMMUState to mark stage-1 translation support
in scalable mode, this element will be exposed as an intel_iommu property
x-flts finally.

For now, it's only a placehholder and used for address width compatibility
check and block host device passthrough until nesting is supported.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20241212083757.605022-4-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index d372cd396b..b19f3004f0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -262,6 +262,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    bool flts;                      /* RO - is stage-1 translation supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
     dma_addr_t root;                /* Current root table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bd639b7ff7..d0c1d73974 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3917,7 +3917,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
-    return true;
+    if (!s->flts) {
+        /* All checks requested by VTD stage-2 translation pass */
+        return true;
+    }
+
+    error_setg(errp, "host device is uncompatible with stage-1 translation");
+    return false;
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4307,14 +4313,21 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
-    /* Currently only address widths supported are 39 and 48 bits */
-    if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
-        (s->aw_bits != VTD_HOST_AW_48BIT)) {
-        error_setg(errp, "Supported values for aw-bits are: %d, %d",
+    if (!s->flts && s->aw_bits != VTD_HOST_AW_39BIT &&
+        s->aw_bits != VTD_HOST_AW_48BIT) {
+        error_setg(errp, "%s: supported values for aw-bits are: %d, %d",
+                   s->scalable_mode ? "Scalable mode(flts=off)" : "Legacy mode",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
     }
 
+    if (s->flts && s->aw_bits != VTD_HOST_AW_48BIT) {
+        error_setg(errp,
+                   "Scalable mode(flts=on): supported value for aw-bits is: %d",
+                   VTD_HOST_AW_48BIT);
+        return false;
+    }
+
     if (s->scalable_mode && !s->dma_drain) {
         error_setg(errp, "Need to set dma_drain for scalable mode");
         return false;
-- 
MST


