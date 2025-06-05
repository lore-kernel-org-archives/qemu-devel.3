Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE4C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKET-0000Oz-DQ; Thu, 05 Jun 2025 19:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKER-0000OU-1I
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEO-0004hZ-Lt
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-747fc77ba9eso1282043b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166963; x=1749771763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oEmtdkJsqGS/x/sZAr6F/pr5dRN3cjaHb+H2YFOvnI=;
 b=WouIccsqR9QDg9RVlAvmWVQVzPpDEXJHjwDSAgsavILiYGZ4DfcAjHvhyqRv5ixyaj
 3B2X9/BFqi6HNW9cKjCO4ERoKpmmPInN6afizA/1CpsXBjC5gInqTuNgHGnDsQgPq21X
 ssnSiNk9ShKmJzrirvr1JzG5ZP0OhIdExVmgNDGz4WGCwPWSq5xGSoLRa/cjv5wV0k0k
 yXFZYl50TH1IPLBQDrj6KGGf1oG4sh4QE4c7zhWzA+D/wIZ9bhUi6T212qGsabRZj5AW
 5A2Wga96VWefA4HAKASGC66OLYskZs0awqlLpI3F28kE3XNWbCXMQJLWtMOi2GhvYpxY
 NLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166963; x=1749771763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oEmtdkJsqGS/x/sZAr6F/pr5dRN3cjaHb+H2YFOvnI=;
 b=byIz1tcGnkRW/fLH84tiG6Ui7lQ5sDC7m7jqQ+0KDX2IswzTUkM3tI7aNATRAWbX43
 gsvQbX36Ku3+P+j7JoeLyMjwFqRJnjLJpCVtiFWzKTDKUrVTX453JU2tG/+8kT+ymb9Q
 laeL46Ce0gH6B9NlFvrjMJKRovwl1WplYB5WfcDHH+93ktKRpyda2kkPnBD2MAFrqGX0
 yckf5IVfg+SvYerL2wxrqdwak7Dpt5aKw+4uOdiFGLtU19A/VXku8869/rSkI65liLKt
 E+XurWLDlPBk4E/xYfDv2BxQlCos+tTwfuDDAv7eOVSdZIPRffB4k4pxrxjyNRnpm4Fi
 Hj/A==
X-Gm-Message-State: AOJu0YyTULQjSoE+EsgoyzDAwfVs/bBqQjJYIcx6bAGD2ht4/U+6/mvg
 SI7MtQR+W81RocaMg83r+f2hNWL6OnyWuUENLFo2i3a5GT23QFNd5Bz2mBefYw==
X-Gm-Gg: ASbGncvvntD3Mns26YzWaKL/G1RXsoCD1ED+HIBk9mDJtmg6soYSLM9/Buaq/SGPWY8
 /BhCpTpIZYl5pvtsqGyM13tqopBKvZT0wK0Wg628WtUFXgjpZJnr56Z/WxXgpFb/1eIdfNTUhyQ
 440qxgP+HX8zyQo5u1jzjipeF6rY5zkyzf3J+mQm7QqfiDuAzaOuT46xzY46VISHjXbeqZi3b6/
 1QYV+7FXQIBT0EOa2yIpon7Emxc4HlQIgjkUK1QVUJZzvOj482X8hphmxqLSyncYNZC8/1pDvzj
 lmr+zqjb1iTPfoWw5X++wlU8e0T4ml9yWVGi9jTwTOcfCxUNrkx3eHukE63LI8CNhRznwFVwbz6
 lssrzlKQ=
X-Google-Smtp-Source: AGHT+IFRCuu4cMYQof8Df+JoU1vvBbDbst0D/wIifD7pQn/OeD7hJZhbK404iYgZEQ47fpKgebP2Ig==
X-Received: by 2002:a05:6a00:9a4:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-74827e7ea01mr1995951b3a.6.1749166963189; 
 Thu, 05 Jun 2025 16:42:43 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:42 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 7/9] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Date: Thu,  5 Jun 2025 23:42:21 +0000
Message-ID: <20250605234227.970187-8-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x430.google.com
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

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 47b1509a0e..004e502b22 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3466,6 +3467,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
+static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t start_extent_id;
+        uint32_t extents_returned;
+        uint32_t total_extents;
+        uint32_t list_generation_num;
+        uint8_t rsvd2[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtent *ent;
+    CXLDCExtentRaw *out_rec;
+    uint16_t record_count = 0, record_done = 0, i = 0;
+    uint16_t out_pl_len, max_size;
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.nr_extents_accepted) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.nr_extents_accepted - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            out_rec = &out->records[record_done];
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3591,6 +3665,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
-- 
2.47.2


