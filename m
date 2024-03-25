Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FE9CD11DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropdN-0001p6-Se; Mon, 25 Mar 2024 15:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropd2-0001Vg-EL
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:05:12 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropd0-0004pq-Jm
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:05:04 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7c89cd8df36so96298039f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393501; x=1711998301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eyoni5qZtSKjt9z3QzKJDUPa9p/nHFzydRxiuFbxHok=;
 b=RNW9FZmLtpjfTnmy47Zm2lqo4TpS4kkDzUJx5hVUyiDcy761ALMhGbIdHhaMA+hIEN
 1ZFQeW3XtOqC5yMMkyyo1ljMWzDYhve/sPRvfxo87XekBQb/XgO6D7pOYN9xZQDZ6LPu
 A3L/vd1InKKssQr25ryvoncWsR7SKuTDBfvzO+Oe/1M12ADb+R9s7mC5ame2HFmWOgf8
 q3kdlmJa3GaeR2DX9RuWRZ28keQKJ74f+JqzH0h0XiDDPTQZhXE8UksIB0Lu6lbXA/eh
 i9ypHZAr0yzg5aaX6brAITxo4V8Ow5fJsXi/RGl/kuvknZUD6z1SnISGprk69hnHajbY
 liEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393501; x=1711998301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eyoni5qZtSKjt9z3QzKJDUPa9p/nHFzydRxiuFbxHok=;
 b=E3oM0u8bA0ATmK/TVRmtgoeHbaDrQSRpgxGpwyTQEdEqcT7/khN68fas1yXirxS1eo
 s3G7AifzbAafwyFp/lsgMr6ORT446A70PIN4TKHl7cxg5OOapuQbPIyPMj3A6FYGD3DE
 CUktxXCj5PEdkHtfbsrTMyYULBbd2246ucdVNWAhI+8RdLOz+GSvorBQ+x7VgfvO4HLS
 8IL6QHdRTHNHNxX0H/MMPCIP73tF6vDtHS98U5bNY0zBzBLAtG86TX9GN5QgJynLYK4Q
 Bo654WykgpsoQgYZUB82NVo59SVqlS7047BfOPBB4XUPn/R5De5BU8L+/6Ns4A4Ma+6l
 hGPg==
X-Gm-Message-State: AOJu0YzJeGIJpkSIb2Z+mh8RWFDxSm7XNjFZPAoqVd/af8OMJ3RF4F5I
 B4OuhxzUkl5+YNkkLZH0zlDWVBa6dFhUhgbvEjFgBakdR+L+iVYtHs54OolG
X-Google-Smtp-Source: AGHT+IFFOVVYKVLk+nUgND3cD8rgUQNgsrXraNM2gggO8CtW2mKT/2B7DOt2cMvN8p4yrw0yaEYmJg==
X-Received: by 2002:a05:6602:c5:b0:7d0:3d39:5fbc with SMTP id
 z5-20020a05660200c500b007d03d395fbcmr7642622ioe.1.1711393500891; 
 Mon, 25 Mar 2024 12:05:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:05:00 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Date: Mon, 25 Mar 2024 12:02:29 -0700
Message-ID: <20240325190339.696686-12-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=nifan.cxl@gmail.com; helo=mail-io1-xd33.google.com
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
 hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a0d2239176..3b7949c364 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1674,6 +1674,12 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, &tmp_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1713,25 +1719,27 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                             goto free_and_exit;
                         }
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now, we will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        len1 = dpa - ent_start_dpa;
+                        len2 = 0;
+                        len_done = ent_len - len1 - len2;
+
+                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
+                        cnt_delta--;
+                        if (len1) {
+                            cxl_insert_extent_to_extent_list(&tmp_list,
+                                                             ent_start_dpa,
+                                                             len1, NULL, 0);
+                            cnt_delta++;
+                        }
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
+                    if (len) {
+                        dpa = ent_start_dpa + ent_len;
+                    }
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
@@ -1819,10 +1827,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                     }
 
                     len -= len_done;
-                    /*
-                     * len will always be 0 until superset release is add.
-                     * TODO: superset release will be added.
-                     */
+                    if (len > 0) {
+                        dpa = ent_start_dpa + ent_len;
+                    }
                     break;
                 }
             }
-- 
2.43.0


