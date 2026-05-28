Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BFFCD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTiy-0006Ki-Pz; Thu, 28 May 2026 01:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSTiw-0006Jw-Ix
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:56:06 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSTiu-0004ff-Nz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:56:06 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c85067c9ccdso3158619a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779947761; x=1780552561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOnEl6g9CzHOp9himAORSol4KLevjnd3PpxGJzoKEiQ=;
 b=EcU5gpN4azGvmR1lIeBq4jsK82x8/LgtPSI0D5CBzCLJR3S4fnsxp+Y9Gp6sLeJpIi
 dnJXoD2mTNn2g72/ajbUuwDvwuMLC2Oe1jeDVt1EG5h47ofJgw01bWwTZWpYrc+H4N8M
 A8JRnNSHtPD4ogiz3yU3lHTIhsOUFZRditQGoK9OiKHVBMJy5kjIHXRMiI6vR2IOPolz
 diy3ITFfYRT8quUnhOm0OoE/pdNfHVrEGKt43VJaaZDvtBaf0vgYKaHS21+nHcFr2EBD
 gl5krDMwuvSlI3Zqc24U8Sj+fkFmpTgY4AyYCIhG9L5IE/nUvzRFb1hDmD4bEW+ZnWiG
 kIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779947761; x=1780552561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZOnEl6g9CzHOp9himAORSol4KLevjnd3PpxGJzoKEiQ=;
 b=jrVZ0KOhifI7hoMED6kfydYbaOMe+Y4b/reenZ19KYYKCQAV5O9Ro0U4r/TzEHwTg+
 mWpKdStABMhPthHHKv9dTesmKhZxFqcahwr+2DKoeUTlW/sIEdVIkY0uxa9LKs2K4jrj
 uR5N84UKxfmNToBoMuTSED1wbl4VthPsg8q7fob7HlgS4M9fQZkn5EJ2oEo/DoQvPhTy
 cjUiQOdt6FbX7P3ruzCJ54agjdjS9WBJY1i8AptSfm5hX5SFXJMnOWaZ5m1uOwCjM7tT
 ut2NG+j/n463q+OJ1/pFCiUEYCU/7aUKzyEe1D/ANzXQv0WsHiDstscZIYHYW1S9Qohb
 fUmg==
X-Gm-Message-State: AOJu0YwkbJCK6C3hHkYc0rldI0d3CJLNeqWt6olLe32eqq3THfFnzr9Z
 Beq4C04UBIDjh8cUySOB7Im+0l2C6JdoeA5cEzPtF57TOssV1ePGI9tI46r70RMY5OI=
X-Gm-Gg: Acq92OF1AC88h+plvndahHOXlV9J2vg13mld0ZzEMoAwY0cylDK3ngbxhDrZiia9Hy1
 olNgsur6almh8bMrqzBpPGJQupPGew31t2Fky/a86xmTckOpg9PgEmDY6cKO5DVb6FtZC8AJXkj
 BJ65EyDwnetqjaDou39yJQXlxe8v938Y2m+XuOoh1Vi1sY3wCrUQ6HPRihuBLHxCDMkJyQmzslU
 GadsEn5rnWfXWveuXI4nQIkUowI+oJTtaFZ8219wZOyqrCDMddqNZlZfLFAr0Lcom1R4K9VO4vD
 xP1US1rDXgueAwDn8t0t6d+ZeC48EkwZcYvENZHQUvX1WNIYw5G7+uL2QeXugz02YaQEVZ2O1qg
 GCbIk2o89vq3651kO+X/yhPtl0Yj4s9cMvYTAG0svCItx+2Kxb4Bk4eGMvav1/irMqyhS/c/lC3
 kJHmA+zry+ImsYYc7QHdZYJBqOm4l6GRkZMc7/Wu96cD8omA==
X-Received: by 2002:a05:6a21:7008:b0:398:b178:a53f with SMTP id
 adf61e73a8af0-3b328ec4d08mr26857031637.40.1779947761546; 
 Wed, 27 May 2026 22:56:01 -0700 (PDT)
Received: from gmail.com ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841f3cbce48sm758068b3a.10.2026.05.27.22.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:56:01 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
Subject: [PATCH v3 2/2] hw/cxl: validate PPR and sparing Set Feature writes
Date: Thu, 28 May 2026 13:55:25 +0800
Message-Id: <61025cb5676b04afcfd7c4cc16904c95564c7a48.1779946245.git.physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779946245.git.physicalmtea@gmail.com>
References: <20260429152750.2409174-1-physicalmtea@gmail.com>
 <cover.1779946245.git.physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=physicalmtea@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Post Package Repair and memory sparing Set Feature branches still
copy mailbox payload data into fixed-size write-attribute objects
without checking that hdr->offset + bytes_to_copy stays within the
target buffer.

patrol scrub and ECS already reject oversized writes, but the later PPR
and sparing feature additions missed the same validation. A full
mailbox payload can therefore overrun the target write-attribute object,
for example in the rank sparing branch.

Use cxl_set_feature_copy() there as well and return
CXL_MBOX_INVALID_PAYLOAD_LENGTH for oversized requests.

Fixes: 5e5a86bab83 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Fixes: da5cafdc4dd ("hw/cxl: Add emulation for memory sparing control feature")
Link: https://gitlab.com/qemu-project/qemu/-/work_items/3458
Cc: qemu-stable@nongnu.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2e4cc5824d..4c7a083e4c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1829,8 +1829,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
-               sppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->soft_ppr_wr_attrs,
+                                   sizeof(ct3d->soft_ppr_wr_attrs),
+                                   hdr->offset, sppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1848,8 +1853,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
-               hppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->hard_ppr_wr_attrs,
+                                   sizeof(ct3d->hard_ppr_wr_attrs),
+                                   hdr->offset, hppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1867,8 +1877,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->cacheline_sparing_wr_attrs,
+                                   sizeof(ct3d->cacheline_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1885,8 +1900,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->row_sparing_wr_attrs,
+                                   sizeof(ct3d->row_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1903,8 +1923,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->bank_sparing_wr_attrs,
+                                   sizeof(ct3d->bank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1921,8 +1946,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->rank_sparing_wr_attrs,
+                                   sizeof(ct3d->rank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
-- 
2.34.1


