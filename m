Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32445C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEFE-0005oG-VW; Mon, 04 Mar 2024 14:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEm-0005Xj-E6
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:36 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEk-0006yo-Ld
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:36 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6095dfcb461so46337797b3.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581473; x=1710186273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaOcSj55m2vuHo7NOezYbOQrG1G43UvBtyGzB+x7te4=;
 b=Hft/mq88jQrBqtcWqgdNOxOs64LYOIrQmJ24uwy/qtzqq3a4x3NlUvMGSo60B4vcMc
 +QiEtA92kI/s7n+uPRSxslW9mvEqsV+BdNg1It4/fAu6weGgoCekPRHp3UNNMaiU9lGc
 VrsrkTTVtwqqxN4WyKF5mu8QBgm8hcbRcD//D42Irxd80tw892KCb++Xhpnb4S5kB52e
 qgYu1xlRCjBwfChEv+2e+SPy3OZtWYYWbytiAAMT8pg8GoP003j+tnYc3/o0ki0sdsyC
 VK2QS4328Qd+LAe+plWaAgH0RYbd/dRs7dO27+KQUM/2a8+654/UDqCrAK9kpo5fTdG1
 xhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581473; x=1710186273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaOcSj55m2vuHo7NOezYbOQrG1G43UvBtyGzB+x7te4=;
 b=uj2WNob5KPx2fe/ysqgOeGAW1El/XpiKoYxyvO+OEBAXeWRDkTjy/rXNf7b1bBI8I1
 6xLwOmRZK1NZwbKX4V20Fg18NxPw6DQrb765V0CrZfDJGi6lfZWCddIuA4Yz/wiyMYkd
 FnV9qmjVt8FWSoTpfz4OPzclXjcRCm1x3XeFsNzqJDuGaYF/mGs0IPu7p/It7TXBX+d1
 XCNArmIyf6GbmJLlKigm6MS6PcJAK5u823cqrzq8+X+KqOL+dQ9NSYUPPukFXskRqdzd
 ktkhdFH+fh3Sv9cIUYu84WDM/aYx0F7Shfui/7OrO6UrmfI3hd86ne1b+NAmlz6WBbNU
 XhgA==
X-Gm-Message-State: AOJu0YxgKApGuiUTriiATOU61++OkCkprv7DtgTLCXparnze1oekcwMo
 zeZBuZ9h0aTLq7NBBLutlQQ7ELffbBrcVujjPH0HNqFjv5WGS4E4G+g7Qes1
X-Google-Smtp-Source: AGHT+IGAUQ4G1g2oUYmUyuIpiZpE/G0LLDXICATQRHvrTwniiC32r7Y2rbFBwsEBLZHMsINmZ5Ysdg==
X-Received: by 2002:a5b:cd1:0:b0:dc2:1f53:3a4f with SMTP id
 e17-20020a5b0cd1000000b00dc21f533a4fmr7160003ybr.5.1709581473236; 
 Mon, 04 Mar 2024 11:44:33 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:33 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 12/13] hw/mem/cxl_type3: Allow to release partial extent
 and extent superset in QMP interface
Date: Mon,  4 Mar 2024 11:34:07 -0800
Message-ID: <20240304194331.1586191-13-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Before the change, the QMP interface used for add/release DC extents
only allows to release extents that exist in either pending-to-add list
or accepted list in the device, which means the DPA range of the extent must
match exactly that of an extent in either list. Otherwise, the release
request will be ignored.

With the change, we relax the constraints. As long as the DPA range of the
extent to release is covered by extents in one of the two lists
mentioned above, we allow the release.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 110 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 21 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c164cf4580..5bd64e604e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1802,28 +1802,79 @@ typedef enum CXLDCEventType {
 } CXLDCEventType;
 
 /*
- * Check whether the exact extent exists in the list
- * Return value: the extent pointer in the list; else null
+ * Testing whether the DPA range [dpa, dpa + len) is covered by
+ * extents in the list.
  */
-static CXLDCExtent *cxl_dc_extent_exists(CXLDCExtentList *list,
-                                         CXLDCExtentRaw *ext)
+static bool cxl_test_dpa_range_covered_by_extents(CXLDCExtentList *list,
+                                                  uint64_t dpa, uint64_t len)
 {
     CXLDCExtent *ent;
 
-    if (!ext || !list) {
-        return NULL;
+    if (!list) {
+        return false;
     }
 
-    QTAILQ_FOREACH(ent, list, node) {
-        if (ent->start_dpa != ext->start_dpa) {
-            continue;
-        }
+    while (len) {
+        bool has_leftover = false;
 
-        /* Found exact extent */
-        return ent->len == ext->len ? ent : NULL;
+        QTAILQ_FOREACH(ent, list, node) {
+            if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
+                if (dpa + len <= ent->start_dpa + ent->len) {
+                    return true;
+                } else {
+                    len = dpa + len - ent->start_dpa - ent->len;
+                    dpa = ent->start_dpa + ent->len;
+                    has_leftover = true;
+                    break;
+                }
+            }
+        }
+        if (!has_leftover) {
+            break;
+        }
     }
+    return false;
+}
+
+/*
+ * Remove all extents whose DPA range has overlaps with  the DPA range
+ * [dpa, dpa + len) from the list, and delete the overlapped portion.
+ * Note:
+ * 1. If the removed extents is fully within the DPA range, delete the extent;
+ * 2. Otherwise, keep the portion that does not overlap, insert new extents to
+ * the list if needed for the un-coverlapped part.
+ */
+static void cxl_delist_extent_by_dpa_range(CXLDCExtentList *list,
+                                           uint64_t dpa, uint64_t len)
+{
+    CXLDCExtent *ent;
 
-    return NULL;
+process_leftover:
+    QTAILQ_FOREACH(ent, list, node) {
+        if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
+            uint64_t ent_start_dpa = ent->start_dpa;
+            uint64_t ent_len = ent->len;
+            uint64_t len1 = dpa - ent_start_dpa;
+
+            cxl_remove_extent_from_extent_list(list, ent);
+            if (len1) {
+                cxl_insert_extent_to_extent_list(list, ent_start_dpa,
+                                                 len1, NULL, 0);
+            }
+
+            if (dpa + len <= ent_start_dpa + ent_len) {
+                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
+                if (len2) {
+                    cxl_insert_extent_to_extent_list(list, dpa + len,
+                                                     len2, NULL, 0);
+                }
+            } else {
+                len = dpa + len - ent_start_dpa - ent_len;
+                dpa = ent_start_dpa + ent_len;
+                goto process_leftover;
+            }
+        }
+    }
 }
 
 /*
@@ -1915,8 +1966,8 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
     list = records;
     extents = g_new0(CXLDCExtentRaw, num_extents);
     while (list) {
-        CXLDCExtent *ent;
         bool skip_extent = false;
+        CXLDCExtentList *extent_list;
 
         offset = list->value->offset;
         len = list->value->len;
@@ -1933,15 +1984,32 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
              * remove it from the pending extent list, so later when the add
              * response for the extent arrives, the device can reject the
              * extent as it is not in the pending list.
+             * Now, we can handle the case where the extent covers the DPA
+             * range of multiple extents in the pending_to_add list.
+             * TODO: we do not allow the extent covers range of extents in
+             * pending_to_add list and accepted list at the same time for now.
              */
-            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
-                        &extents[i]);
-            if (ent) {
-                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
-                g_free(ent);
+            extent_list = &dcd->dc.extents_pending_to_add;
+            if (cxl_test_dpa_range_covered_by_extents(extent_list,
+                                                      extents[i].start_dpa,
+                                                      extents[i].len)) {
+                cxl_delist_extent_by_dpa_range(extent_list,
+                                               extents[i].start_dpa,
+                                               extents[i].len);
+            } else if (!ct3_test_region_block_backed(dcd, extents[i].start_dpa,
+                                                     extents[i].len)) {
+                /*
+                 * If the DPA range of the extent is not covered by extents
+                 * in the accepted list, skip
+                 */
                 skip_extent = true;
-            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
-                /* If the exact extent is not in the accepted list, skip */
+            }
+        } else if (type == DC_EVENT_ADD_CAPACITY) {
+            extent_list = &dcd->dc.extents;
+            /* If the extent is ready pending to add, skip */
+            if (cxl_test_dpa_range_covered_by_extents(extent_list,
+                                                      extents[i].start_dpa,
+                                                      extents[i].len)) {
                 skip_extent = true;
             }
         }
-- 
2.43.0


