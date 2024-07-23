Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4362C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMHz-0003V5-Bt; Tue, 23 Jul 2024 16:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMHx-0003RK-Ae
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMHv-0003v1-KZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso44609795e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767150; x=1722371950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07s3gAboUiyqxdzn5K8IrlmeguSj0H4h3EuvIHEUowk=;
 b=u6t+O6SzM9ytBu9h2IU95IyQzBh77auCijdrLJ7tIhgAkzohTWLY0VVpI4GItdeeDz
 WruGSSkzoKz7g3g9Xe25jVzbSoyoDQhmMmmYcblgK6Q6vFKeHOfYfYXcEwReZxyEhI3k
 fqsvkTr1Ufkhhnaej9uJtWUpg7xq1K8V+bvzJcUgg0yca3K0zvV1aseSBggIANWuEkI0
 uVZ7A+vnL8ziWfOosQHi7S/g3avW6HXDX4HEaqTsBM4EBqf12t/e4U6TE60DANAyn1DV
 dNlrVO39gL4zfkqPVAiD06xho5klxFq1nIcgqrws5YSWokoFBwNicbZxoCoFdj2SejjH
 ahsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767150; x=1722371950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07s3gAboUiyqxdzn5K8IrlmeguSj0H4h3EuvIHEUowk=;
 b=NqPLN85TdIprcZcUEbQ3A5X+20eepi8Qp3YyE7adyUD/KYxTgl6kl63n/9pKi1fBU+
 pKdqAkWoF0LF/ETqi+MeNUNwpsP8Iut7NAG3iSGLB7dlpag010Eh09Y7m4qYQwiqKzMc
 3OPU160Saw0PGCKobUKIzoBvCVLT3ReJSSkuFJecGonc5jg7S+1mNwAXPvVCAL8nVF17
 pefQrkMZgAdfn4qrx8HKVblLmOsAcYGE5/I60PWJ7eTURYI6Bkcqp30pNVyNa2BU9RsH
 5ZTkswk4zKj0K02ZOHlhzHYwA0sk4CRs8GFKNbG0bHWg16N2MVdVpbr5kXr4nqWX8tKL
 69wg==
X-Gm-Message-State: AOJu0YwjrPfpppaosh38Ooao/RW8IF2XExPl2VJ5QHN+TG7kKte+ZutK
 O7nWqX+dCMcfP6VrGQX7ltoAjSovWq5shg31FXMfEp7toFztD5oB2N8GGXuRdt6ZADrkKO8YKIg
 ztx4=
X-Google-Smtp-Source: AGHT+IFVSL1Q0OK4Dz55H4GJs+er0z4SuHBsokaUuHWhGAV32blMH2Wcsd/QmMpixMUi4s8rwkAL9A==
X-Received: by 2002:a05:6000:1108:b0:368:667a:3dec with SMTP id
 ffacd0b85a97d-369f5b30273mr22511f8f.18.1721767149874; 
 Tue, 23 Jul 2024 13:39:09 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ebab0sm12538751f8f.92.2024.07.23.13.39.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 02/28] hw/i386/intel_iommu: Extract device IOTLB invalidation
 logic
Date: Tue, 23 Jul 2024 22:38:29 +0200
Message-ID: <20240723203855.65033-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

This piece of code can be shared by both IOTLB invalidation and
PASID-based IOTLB invalidation

No functional changes intended.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-ID: <20240718081636.879544-12-zhenzhong.duan@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/intel_iommu.c | 57 +++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 37c21a0aec6..536994c3107 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2666,13 +2666,43 @@ static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
     return true;
 }
 
+static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
+                                     bool size, hwaddr addr)
+{
+    /*
+     * According to ATS spec table 2.4:
+     * S = 0, bits 15:12 = xxxx     range size: 4K
+     * S = 1, bits 15:12 = xxx0     range size: 8K
+     * S = 1, bits 15:12 = xx01     range size: 16K
+     * S = 1, bits 15:12 = x011     range size: 32K
+     * S = 1, bits 15:12 = 0111     range size: 64K
+     * ...
+     */
+
+    IOMMUTLBEvent event;
+    uint64_t sz;
+
+    if (size) {
+        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
+        addr &= ~(sz - 1);
+    } else {
+        sz = VTD_PAGE_SIZE;
+    }
+
+    event.type = IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
+    event.entry.target_as = &vtd_dev_as->as;
+    event.entry.addr_mask = sz - 1;
+    event.entry.iova = addr;
+    event.entry.perm = IOMMU_NONE;
+    event.entry.translated_addr = 0;
+    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
     VTDAddressSpace *vtd_dev_as;
-    IOMMUTLBEvent event;
     hwaddr addr;
-    uint64_t sz;
     uint16_t sid;
     bool size;
 
@@ -2697,28 +2727,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
         goto done;
     }
 
-    /* According to ATS spec table 2.4:
-     * S = 0, bits 15:12 = xxxx     range size: 4K
-     * S = 1, bits 15:12 = xxx0     range size: 8K
-     * S = 1, bits 15:12 = xx01     range size: 16K
-     * S = 1, bits 15:12 = x011     range size: 32K
-     * S = 1, bits 15:12 = 0111     range size: 64K
-     * ...
-     */
-    if (size) {
-        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
-        addr &= ~(sz - 1);
-    } else {
-        sz = VTD_PAGE_SIZE;
-    }
-
-    event.type = IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
-    event.entry.target_as = &vtd_dev_as->as;
-    event.entry.addr_mask = sz - 1;
-    event.entry.iova = addr;
-    event.entry.perm = IOMMU_NONE;
-    event.entry.translated_addr = 0;
-    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
+    do_invalidate_device_tlb(vtd_dev_as, size, addr);
 
 done:
     return true;
-- 
2.41.0


