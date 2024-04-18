Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC00C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxbDg-0003d9-E2; Thu, 18 Apr 2024 19:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbDF-00037W-OY
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbDE-0005vq-6a
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed9fc77bbfso1169031b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713483038; x=1714087838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9/QnnmOfKtdXC4mQDt19ExscjIokR+8yGloQuw3o6U=;
 b=mDMnxOH77CMqcFh5DZqLriwR9xvWEwaB2vGxNbInOFjCx5qNp4b5+Nx3C91XCBek65
 +UBTkNx3AWcD4rGKIwUQt014IfLIV14sr7vAkmRpiOap87+oOnnKkRGseAGl/FSJE8ab
 j7/f5RgMOqnFxveEyajLeARbhkW3b+WofRM5dGk4kr3Tb5MlQHD7PPjneZihsmCrlUZo
 55LsTImJ6362hVbDz1wSYtfDaOmgV6YaoXynINKsjwe+bxMj3KPBWymxQ83YlRJU9tOK
 yX7uVUDy97sxPuvdv1FLqFu7KQjn/Er1hP2ItvuMll8TurIAfDU0J3hTZjWAOOOImqwh
 F28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713483038; x=1714087838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9/QnnmOfKtdXC4mQDt19ExscjIokR+8yGloQuw3o6U=;
 b=dDzQg9GoIX9q0aypnIAlv8QF411vmpkv53qz4dCdiUrTo40H2i9Ysyt9xAXq76bMNo
 zHv/EYkQqEW2b/oEYu0hpRwI0CaYjXVDjL7oe+JIm24GDnFWsf0/Kdfru43YbLyaqlQX
 Lt78Wl5qJTfNeZXaAjqSBrqNyVNKQMKz+GYDalYx4XGEt+7dQyCi0aM3nsQ1G/CQK2sa
 hOVqUkgpbnAT5VXOzDlXs8VHWi41pDwyd9r1kvdntqVr8fL9h31Zl01loEjpehAhgV8N
 Owf5HW2vBkjJZwXvW7yRePqNau6IkADJwdzMOVqQq5WmCnQ11PMebNA6k3qhAuB+kuca
 6LbQ==
X-Gm-Message-State: AOJu0YyCybRRcFTB+xdnIeIaXXkF6VXPHmtXtLs6iU93k4C6TsdAp3pa
 /BVNXfxdD1Ir9plduVC3e6wwF1FOgttmmeDj40fwdJqSBPKk23dliPlMdA==
X-Google-Smtp-Source: AGHT+IFxmyePkARZkckg2WodGL2yH1e7nz5yCu71kjTaoavsu6MpQP1H/JH9iZsF6BUah9nvlvDQTQ==
X-Received: by 2002:a05:6a00:1a8e:b0:6ee:1d68:d33 with SMTP id
 e14-20020a056a001a8e00b006ee1d680d33mr644097pfv.15.1713483038197; 
 Thu, 18 Apr 2024 16:30:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 16:30:37 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Date: Thu, 18 Apr 2024 16:11:02 -0700
Message-ID: <20240418232902.583744-12-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Fan Ni <fan.ni@samsung.com>

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by accepted extent(s) in the device, the release can be
performed.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 57f1ce9cce..89f0ab8116 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (range_contains(&range, dpa + len - 1)) {
                         len2 = ent_start_dpa + ent_len - dpa - len;
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now. We will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        dpa = ent_start_dpa + ent_len;
                     }
                     len_done = ent_len - len1 - len2;
 
@@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
                     break;
                 }
             }
-            if (len) {
-                ret = CXL_MBOX_INVALID_PA;
-                goto free_and_exit;
-            }
         }
     }
 free_and_exit:
-- 
2.43.0


