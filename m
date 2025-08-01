Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D47C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqpP-0001zS-GE; Fri, 01 Aug 2025 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhP-0005RZ-Fx
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhM-0002j3-HR
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AigbT03t6Dx2Zi4WTEKRTIlUrva/CR4VU0he0l7c2Hw=;
 b=ANpNuXGEraHzHJsL/mzk0EYT/7QA0Kvm5OcAY63QmXAnSaKo9T8kkmtoby7ShjLYSoHitg
 TLqz6MKIp22BAIucFsBmOMmBC3qKv1JeyEJgMc7HLRX0FKxhwBNqIrIsFD1+v+83zFaIwA
 8GmbbIkPPUTwejfd6xN33N5h1BgfRi8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-pMLr5UUhNdK5jMRewsX2rQ-1; Fri, 01 Aug 2025 10:25:25 -0400
X-MC-Unique: pMLr5UUhNdK5jMRewsX2rQ-1
X-Mimecast-MFC-AGG-ID: pMLr5UUhNdK5jMRewsX2rQ_1754058325
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b78c983014so127258f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058324; x=1754663124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AigbT03t6Dx2Zi4WTEKRTIlUrva/CR4VU0he0l7c2Hw=;
 b=aTuCx2em8+a7OBeCqpatDA+ADbo2xlipwyWCjpD30D/3DSmm0rpADixhFILA9LgfjF
 JAYFrfa1VGC9Y38iACpszNAH6o/Rqy8Jr6+sDwCBtS2/wmNdCnRtAAzrZLCTJL9wwlQu
 xya2W7fV945iOZzmH4O2h+ECSDFebmtwjz721j166KdH4XUyTX5/VYxMHh29bWlxeXuK
 NksgB6mUMzVH8ITbzcwhKOk9pp5hjQuGgv1e1+qppdb72C0KUwK1jUPgrj+h9iYxC6qT
 NqB6hEqVPKLkHEghzwPDNqlJH6F+FL3hnl75bldkLSmr8dVKnHk2H6ZoRk87bCVCSwGM
 9fJw==
X-Gm-Message-State: AOJu0YyBSrISqAM2onqXugcjXgtq3dLFz6en9RSHDifcdWFOitbzrjy4
 /vW1gCQcityezujLOfPnSMF0nlqFbTuK4JPZoYQGCkt1pJEFrjDWHy3XBiNv9zHkvzkMHbKi2sv
 RCppH/9JYivg926Dv9aKYsd0FfeRb92lHIvNTHL0ulQYXh3xtdUKuVROTQ0CMuOOlhnuvcXbt+O
 CvMTeWOYe1mMvp2KVPeYMvUAAtwN3Gm6Nbig==
X-Gm-Gg: ASbGncv8s9H9sC8dGm/xTLy0w/961NAb+mduPljAAjy/2FEu+qRxc3OzFOGeBLI7NZf
 skAv2+FJh/D3GUWGFQpThAeZNcYc5W3l8LhRK2012SBo3gVSR6wRuhWDmrbiOvnzJRXya9Ku3Ap
 M23VYg2tgC5/DLO9tH7uoIn7+lVhL4J+F7NfVa5+5XnU5y0Tp4u7NrP8FbpU8IEl249C5COy2Bn
 pc2HsckVuEJ5v3p6uB7rQPlNNMCGfE6mfqaOBQDntUfy+zRmefJKoH5HK522LamYCRKYo1nCZYW
 E9RghA46bLs7l0wQzbqOQdz8Y7+nX4ZU
X-Received: by 2002:a05:6000:26ca:b0:3b7:7c18:c72d with SMTP id
 ffacd0b85a97d-3b794fc1a99mr9201036f8f.4.1754058324296; 
 Fri, 01 Aug 2025 07:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHffW4HPsaBKkwpjr+ZDkjzYe2KdD7t2nb4I6qbz0fn1/eJQ3uKpuOIvJ0eTdJ9Nczgdw799A==
X-Received: by 2002:a05:6000:26ca:b0:3b7:7c18:c72d with SMTP id
 ffacd0b85a97d-3b794fc1a99mr9201007f8f.4.1754058323862; 
 Fri, 01 Aug 2025 07:25:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ad803sm6017813f8f.6.2025.08.01.07.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:23 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Ethan MILON <ethan.milon@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 09/17] hw/i386/amd_iommu: Fix amdvi_write*()
Message-ID: <47d3b32d6fb1c6ec8afb78d12d2420dbbb4c3499.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

amdvi_write*() function do not preserve the older values of W1C bits in
the MMIO register. This results in all W1C bits set to 0, when guest
tries to reset a single bit by writing 1 to it. Fix this by preserving
W1C bits in the old value of the MMIO register.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Suggested-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Message-Id: <20250801060507.3382-5-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7308611bf1..c9c32cf7b0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -123,8 +123,13 @@ static void amdvi_writew(AMDVIState *s, hwaddr addr, uint16_t val)
     uint16_t romask = lduw_le_p(&s->romask[addr]);
     uint16_t w1cmask = lduw_le_p(&s->w1cmask[addr]);
     uint16_t oldval = lduw_le_p(&s->mmior[addr]);
+
+    uint16_t oldval_preserved = oldval & (romask | w1cmask);
+    uint16_t newval_write = val & ~romask;
+    uint16_t newval_w1c_set = val & w1cmask;
+
     stw_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+             (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
 static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
@@ -132,8 +137,13 @@ static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
     uint32_t romask = ldl_le_p(&s->romask[addr]);
     uint32_t w1cmask = ldl_le_p(&s->w1cmask[addr]);
     uint32_t oldval = ldl_le_p(&s->mmior[addr]);
+
+    uint32_t oldval_preserved = oldval & (romask | w1cmask);
+    uint32_t newval_write = val & ~romask;
+    uint32_t newval_w1c_set = val & w1cmask;
+
     stl_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+             (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
 static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
@@ -141,8 +151,13 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
     uint64_t romask = ldq_le_p(&s->romask[addr]);
     uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
     uint64_t oldval = ldq_le_p(&s->mmior[addr]);
+
+    uint64_t oldval_preserved = oldval & (romask | w1cmask);
+    uint64_t newval_write = val & ~romask;
+    uint64_t newval_w1c_set = val & w1cmask;
+
     stq_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+             (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
 /* OR a 64-bit register with a 64-bit value */
-- 
MST


