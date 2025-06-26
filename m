Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7868AC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5L-0006Q5-Vd; Thu, 26 Jun 2025 18:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv5C-0006M0-Rc
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv54-0000th-9I
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-236377f00easo20588895ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976906; x=1751581706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBps1tm/E0rqCasT+u+6aJlRaXwKKIUQT/6/1t5YR3A=;
 b=EhYMf0ZSAeKLkXgAEKIwUlANM3tPDNGYKHZjbGsbeCgvG+IxJ42+WOn2f2XF+0yQ8P
 k8dWpM3N3GPMW6tKeZ1vpkgpXaqOps1QEUd8yI+8s2Es4fp2DgCDeF2dKam3c0gP65f5
 FkbDnlNqM6Re6K9UocuDMu9tWiyDHOtpeCGAnecTp6yQVZEV2bMqU2sFSrsu5rlQrrkx
 9PSFbxIed6quyy78bWk5M1BwhiTVunQZ11tDPBw2DlJjqQoYb+KCHv9AOiWyb5aGMUwT
 vq0XkBe59IdVpH8/IbbGNyZzQF/OiNsCcU2QqyVY3QeWQwQZGT0cFp9zSfUYWaKKDY5n
 98TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976906; x=1751581706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBps1tm/E0rqCasT+u+6aJlRaXwKKIUQT/6/1t5YR3A=;
 b=nGbEqDfZa34Q1MjhLH4CJ0qXSWeeZ+YFcflfC0iZ6ZqTAfe3UgJsKoXwmQFNMI+K8X
 v/YSHq0z56ujlHouvZ9YRXls8zjX2jJGfXbgQGhMwQKSxmQqRzmSer5Z0V8t+omBSvWt
 mByeLm4nbSsXXQz9EKDEXxn9s7/QIpau/YoUTakpfWiJomPjXYMVEHka5Czyl6J7dMxw
 8lY8/m6gD1ztK+IpQJ8LcXEPII3I2kzZPV3Wtz0RijNvr3hYVteZ6XJfjQQ8zF/M0cLE
 sos3ZJ9NE2YG9g16hQwyTiUP2Fd98x9Y/Szznhi1KvW/uWx2AkXRbqqJo28He+A3kkWF
 vxXA==
X-Gm-Message-State: AOJu0YzDXvPkOJQiuYw8cVZNh5UH7gYvb7c+rC/ok3NrtXu9tHrhDVo+
 uGypKr9U29oAhbKa/DU9rSA0WBsd6nii81ehxPVp5Hm+DwzBcjZyGeM2bmXbig==
X-Gm-Gg: ASbGnctOmfjn1WvT62SiOJV3mqENpusuH05Q0nJ/ndowyVuUgkxiNgXvCTOI6A/vVOF
 c2uA4pDLZfch8wLXOJ1TeCxB7RhoBo4a9WBTLXb7c9IlyT6sCrMf8PiBDwUm0qk52n4IEdWrR1T
 Ccl1D5qfp59UuEvYLQVEGP5r7Deublz9RTYIMmhandDSu8DvW8ZezUEzCUyb3p3MTv8u8aHIW0n
 qwhMmEFbjypNDTPOYI1CuCbL8Sow9HLq66KSNCCGrsEkb923kbdUUiJ4f9Sx4tbMOi87J/I8H3t
 lLkZNzIGG2vvy6Q3cn+07b8+O52Jb+hT55HcpymtVWfSOwPyKjxU7XVbG1Cg0pHUWX0GjPcSrsw
 HRUk1Lkukq2oodjavfA==
X-Google-Smtp-Source: AGHT+IE0vEXNHth7oaL4diMn3sE9UxFbYJIMXP4uA3k28cRYItq0xgl7K501CLHx1FPhTKL//pIV7w==
X-Received: by 2002:a17:902:f548:b0:237:e3a0:9d63 with SMTP id
 d9443c01a7336-23ac46344aemr14497665ad.43.1750976906080; 
 Thu, 26 Jun 2025 15:28:26 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:25 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 05/10] hw/cxl_type3: Add DC Region bitmap lock
Date: Thu, 26 Jun 2025 22:23:28 +0000
Message-ID: <20250626222743.1766404-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Add a lock on the bitmap of each CXLDCRegion in preparation for the next
patch which implements FMAPI Set DC Region Configuration. This command
can modify the block size, which means the region's bitmap must be updated
accordingly.

The lock becomes necessary when commands that add/release extents
(meaning they update the bitmap too) are enabled on a different CCI than
the CCI on which the FMAPI commands are enabled.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 4 ++++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cdd60079c4..b872a26173 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -692,6 +692,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1020,6 +1021,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1046,6 +1048,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1067,6 +1070,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 397edcff4c..6a5025200c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -547,6 +547,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
-- 
2.47.2


