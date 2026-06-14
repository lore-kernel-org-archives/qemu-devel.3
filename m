Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF3ECD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDl-0001s0-2B; Sun, 14 Jun 2026 15:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDi-0001eU-Pf
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDg-0002ya-LS
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0FKrtKD3UbgNzo28PGrqkfe8bMWq9NWlfrneEsbjarY=;
 b=IEQ/yHKeMD4NJUlZbNFeoXDvATRz+4bzNRpZ3U1grLWaeZXcdfG/S41K96pSixDeK0CjCf
 5je4Bl+7hETczM+kReLdePJ0aEjVU1r88v6RinCYIxqeBmsPmWVDCw5NswxJD+SWCKhwW0
 Jp65M9sYg7UN6aAva9sPffOXDtVuX00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-qY3n3hK3P8GfRmUgI6-QRw-1; Sun, 14 Jun 2026 15:10:04 -0400
X-MC-Unique: qY3n3hK3P8GfRmUgI6-QRw-1
X-Mimecast-MFC-AGG-ID: qY3n3hK3P8GfRmUgI6-QRw_1781464203
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so15958345e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464203; x=1782069003; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0FKrtKD3UbgNzo28PGrqkfe8bMWq9NWlfrneEsbjarY=;
 b=n3RrJnGhaJFEOETt0VK/Gh3CrkTLfJf6TOCvoOxCtwYcSsLrOT3NAs/o09sQaT2Maw
 LeoYZwXKIfsuEeCo528UJ8HJuzvLo+0tXrRJdc7pgO9uFMnsSciSh6QkAADbMbl5KqhL
 7uQO/VxLUA4gUGWmH493zjkCG4ueAqFslu34ftOSJkBe/1ZEMF3QOpcf3dCkcuyXdwUK
 EfQxJ0m9M7jLUtZIKqmHFO89eq+icKeVHwetLFYGZtMh636rl6ffVVvrz5Irpi0zf1RO
 dX5SA60+k3mH4wrz3X85dT78ZzOYNVVqEn2XoEYhnIXhkK+XqCodqSf8uoRqgwU6noNO
 mYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464203; x=1782069003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FKrtKD3UbgNzo28PGrqkfe8bMWq9NWlfrneEsbjarY=;
 b=QB71C0dRZRmRClJqdqsYaUlBIncYUgBLPYjJeRy8pnV05xlNyxQLmo83NJM84OSARA
 Iyit+739izKsE5+cyIf7NLHjt3i5eb99W06lOT3OajzLLyP2/8Bf7abgkXqg+h0RyZke
 KqypxlUfC6GodWF35ytdJNoHE3AYISX6m0TUE3RM/rUK+7AABVOOYeo8LI9/Q3Pjlct1
 gr/WJjC0yOxPzy99bzjPPWOKwewJzM3BVGlewsOMa0RULVWPYA/ad+/MM9YekNBw0sbJ
 bAsBXkxGB4LrP5qTJA/l+EWWNU4S3uqrLZ+ZJISRYJyMRIBu2XyroIvocGmVhdf4MMTS
 OYGQ==
X-Gm-Message-State: AOJu0Ywg6nABcZTVL1QbIanVxPxlayK4sypuOeNZh9nmQUvt06LmZ4BS
 eh01Xd3CL3Rcu+La+tw2KoTfYVQ2H4ebTDmY53lLJLsKzfi7y3gpTv4VyeN3GtXgSSWgY1q3ySp
 dO/rb/5pwsfWkbaABtWSUprdwjY5DPOOEUhOLaX5Lsye8vkrCxWSaz2HmeZA+h91vI0RPgMdZw6
 Yvbv8YSI+woFRf7xzsJjaB8cAfUJq26oabBA==
X-Gm-Gg: Acq92OE8MDXQe2nHrbtFqV32Zd26V1VPunKVBuq+L9/1268FCXMDZXPoBgpdSjWTBpu
 smPmaHNQDBiZrDQnYhYm+akGOMd9aXWBdplyuXazIoApG4Lut1j/zTJv0Utpiac2kSm2fyQlMou
 RPqWkAoo70RCDtSxLoY0NKyz6faq6wJMaAM6SuG+IjaE9PruLNkARo3s8Frfl8Po3LAy4KL2Ypm
 rLLQ3r3AUpTGVFgxkvpk4RRQHkhX+V0SiIAUakgqL2NjGXeHkkM1hjXIiSvXILT4367qLO5Iakb
 xvH4coKqVawROAq3n+wgqs5v/ptjgAgApDrH+RXm8iBnkpKjm2WdfbEWIB7yU1daFsGR68FNZvw
 0jnBAkxI7UfKE6guHr5OrCPLBW7J6vdE+I+fTG052NZU=
X-Received: by 2002:a05:600c:6214:b0:492:1e36:1fe8 with SMTP id
 5b1f17b1804b1-4921e36204dmr101204795e9.36.1781464203192; 
 Sun, 14 Jun 2026 12:10:03 -0700 (PDT)
X-Received: by 2002:a05:600c:6214:b0:492:1e36:1fe8 with SMTP id
 5b1f17b1804b1-4921e36204dmr101204465e9.36.1781464202594; 
 Sun, 14 Jun 2026 12:10:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea95b274sm272829555e9.1.2026.06.14.12.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:10:02 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:10:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 104/106] intel_iommu: fix guest-triggerable abort on oversized
 MMIO access
Message-ID: <1d741b375300ad14066c74f7f2d3430114a5cf7f.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Junjie Cao <junjie.cao@intel.com>

An 8-byte guest access to a 32-bit-only VT-d register hit
assert(size == 4) and aborted QEMU.  Remove all 25 asserts.

All 3 read-side and 18 of 22 write-side asserts are at
non-8-aligned offsets (unreachable, rejected by
memory_region_access_valid()) -- simply deleted.

The remaining 4, all writes at 8-aligned offsets, are
reachable: FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0.
Truncating the high half via vtd_set_long() matches prior
behavior; log under -d guest_errors since the VT-d spec is
silent on oversized accesses to 32-bit registers, and add a
comment so future maintainers don't delete the check as
"harmless".  min_access_size stays 4, so all size-based
branches on 64-bit register pairs are preserved.

Found by generic-fuzz (24 distinct crash seeds, all fixed).

Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260514180703.85686-2-junjie.cao@intel.com>
---
 hw/i386/intel_iommu.c | 74 ++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8bb2a1e339..744cdfd2e6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
@@ -3659,7 +3660,6 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
 
@@ -3674,12 +3674,10 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
         val = s->iq >> 32;
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
         val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
         break;
 
@@ -3725,7 +3723,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_CCMD_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ccmd_write(s);
         break;
@@ -3741,13 +3738,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IOTLB_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_iotlb_write(s);
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3761,27 +3756,35 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IVA_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Status Register, 32-bit */
     case DMAR_FSTS_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_fsts_write(s);
         break;
 
     /* Fault Event Control Register, 32-bit */
     case DMAR_FECTL_REG:
-        assert(size == 4);
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_fectl_write(s);
         break;
 
     /* Fault Event Data Register, 32-bit */
     case DMAR_FEDATA_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3800,13 +3803,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Fault Event Upper Address Register, 32-bit */
     case DMAR_FEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Protected Memory Enable Register, 32-bit */
     case DMAR_PMEN_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3820,7 +3821,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3835,7 +3835,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQT_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* 19:63 of IQT_REG is RsvdZ, do nothing here */
         break;
@@ -3851,39 +3850,57 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Completion Status Register, 32-bit */
     case DMAR_ICS_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ics_write(s);
         break;
 
     /* Invalidation Event Control Register, 32-bit */
     case DMAR_IECTL_REG:
-        assert(size == 4);
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_iectl_write(s);
         break;
 
     /* Invalidation Event Data Register, 32-bit */
     case DMAR_IEDATA_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Address Register, 32-bit */
     case DMAR_IEADDR_REG:
-        assert(size == 4);
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Upper Address Register, 32-bit */
     case DMAR_IEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3897,7 +3914,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_1:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3912,7 +3928,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_3:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* May clear bit 127 (Fault), update PPF */
         vtd_update_fsts_ppf(s);
@@ -3927,18 +3942,27 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IRTA_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     case DMAR_PRS_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_prs_write(s);
         break;
 
     case DMAR_PECTL_REG:
-        assert(size == 4);
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_pectl_write(s);
         break;
-- 
MST


