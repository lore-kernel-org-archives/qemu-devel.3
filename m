Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62D4C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeJ-000711-Ig; Wed, 14 May 2025 07:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAe6-0006hJ-19
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdz-0006Q1-0d
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0awWa+sd4n9SFgUr0omak6uEhyaTwUgBMVocontbFgE=;
 b=D+azzMqFS0x1gw8j2Ku0eD1jyeQce25LzInmWSy2ZLT83LbHYe91T2F2wQYU4ctSst8IOi
 DsAAEyZmcDQWlF6Q5fxciZBmOvh/81+Dp8u5AtzPq0QQK/pfwLLFvN9sN8UPJWu7FnbNuK
 DK3H0cOdR2sgLP76RLSi/3gE0PKTuc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-lEYO9fiGP4C3W25H38jnSw-1; Wed, 14 May 2025 07:51:24 -0400
X-MC-Unique: lEYO9fiGP4C3W25H38jnSw-1
X-Mimecast-MFC-AGG-ID: lEYO9fiGP4C3W25H38jnSw_1747223483
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso32991985e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223483; x=1747828283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0awWa+sd4n9SFgUr0omak6uEhyaTwUgBMVocontbFgE=;
 b=gPi5PppwNRNZu0YIHcM6IHqjOlgMIG+CRlZSAn13+4gg1RxLBCHJ+VIY6hhejUZgaB
 JMvzOWiMDBgmVZn8fkLUwv/kHlW+H+20x2RK6xRmxpClxMrnkf5YJ6bBlPbSBH3Lfmno
 tCmAVH8qkX/Mk0c1VcPNI1xpwsYmEhmhynZJefsR2Ii02YQukF7JZCHiUk5+Qe58MlfU
 zVuP89P6CZ8xwu7wKBjK5QbbElQEVkJZf0qtAOYATYSKGdsjR3T0FFKDIsEuHA7w18qR
 yOBuJzO11DT7WHSCdSWe442+cpLfgtX14fIB8mjGnvICKbjIfhOVy2CS1VDdF/o+mfy+
 VNfQ==
X-Gm-Message-State: AOJu0YwAipvXYbgdsXgmvH6+SD92QJJBi+e5ZUST/8Bj1bRm26zWE9Fs
 UqQAT9VCDlsIGI//PGygROVITOUphqjcGL8ULJR5RPyNER1XmLTYkmfe8+dd+jPBkFMpw1pV3O6
 w9g80hN1P16EQms8pvsqGQCZv27rpY2JMIo7meafMRBl1GREOWtq3dYJkQaUgkX/dNgMiMbvm43
 Rm2Ay9k57ocJcvQQa0JZ8PYHhuiTjumg==
X-Gm-Gg: ASbGncv0PwzjMZt5Wfvg9xn/aQHPQVOEUKEXbk/4tgiVFX++BWRjiUmVFXvQKvE8sDT
 I/BNIHq640AM80EQ/zFbNiuomU7MhbUX9EkEF/acckIlxylmvarvFnzVF6R73XlIfX2QxXnb2cX
 nM7WlzYYjk96V55AM4jBEosSoAo+Lo5G0YbxGNW3fUaaSZwMah5/wLjI04BrjAXPyxk97EGg74X
 x6Ew+MktmMwSGLtBBZfDW9sq0pcm1NQUCU0ejIJ/P71lbYNDVfPYyQoM/y5ZnMJEgAKbUrXpXAL
 W0RK/w==
X-Received: by 2002:a05:600c:609b:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-442f21798ddmr22865015e9.28.1747223482987; 
 Wed, 14 May 2025 04:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMFe0AufQ68xuHNIUOE8flzQfg1eQBJDbiPllCR7h8gdgK4PeI9WTiRSLyXgXn2KYs66oLXQ==
X-Received: by 2002:a05:600c:609b:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-442f21798ddmr22864645e9.28.1747223482535; 
 Wed, 14 May 2025 04:51:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f482f1d6sm22734075e9.14.2025.05.14.04.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:22 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 25/27] intel_iommu: Take locks when looking for and creating
 address spaces
Message-ID: <1b85dff5f0be30ddbcb7edbd3c084c9c5ee351ca.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

vtd_find_add_as can be called by multiple threads which leads to a race
condition. Taking the IOMMU lock ensures we avoid such a race.
Moreover we also need to take the bql to avoid an assert to fail in
memory_region_add_subregion_overlap when actually allocating a new
address space.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250430124750.240412-3-clement.mathieu--drif@eviden.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b925e65b02..69d72ad35c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4205,9 +4205,30 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     VTDAddressSpace *vtd_dev_as;
     char name[128];
 
+    vtd_iommu_lock(s);
     vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
+    vtd_iommu_unlock(s);
+
     if (!vtd_dev_as) {
-        struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
+        struct vtd_as_key *new_key;
+        /* Slow path */
+
+        /*
+         * memory_region_add_subregion_overlap requires the bql,
+         * make sure we own it.
+         */
+        BQL_LOCK_GUARD();
+        vtd_iommu_lock(s);
+
+        /* Check again as we released the lock for a moment */
+        vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
+        if (vtd_dev_as) {
+            vtd_iommu_unlock(s);
+            return vtd_dev_as;
+        }
+
+        /* Still nothing, allocate a new address space */
+        new_key = g_malloc(sizeof(*new_key));
 
         new_key->bus = bus;
         new_key->devfn = devfn;
@@ -4298,6 +4319,8 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
         vtd_switch_address_space(vtd_dev_as);
 
         g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
+
+        vtd_iommu_unlock(s);
     }
     return vtd_dev_as;
 }
-- 
MST


