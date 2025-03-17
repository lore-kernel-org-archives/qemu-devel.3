Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE95C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS7-0007ZN-Lu; Mon, 17 Mar 2025 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZi-0003g2-So
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZW-0001Gx-NO
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224019ad9edso36905275ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229850; x=1742834650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qX31zqHeedLuC0moymwx118I/OYgCdYe/VclY70qVzc=;
 b=ffz8VMyKVduhBT3gard/L3p1W+ATrzhWrmIxWPDRcuQXP97U9M+pwVKJ4IU1OFOk6T
 nONCuuJdnPw4GNYV5X/p2F5lvvG9RjPZd+BhaC2SLjpd62XVQi1DJzBNEPEKCVDbYoGh
 CkNW4X2HCsO71uc9gcgsw2qmQrikt1BEceY+jOOXC1H6oQEl4CQzn6eiMa2plCkZ++K5
 D6kbE1r8LZTBa9irwxbunOf9PxXhGi4H1p4RGLPdlMovTqNDP73/hPnGEP+MJB+sejSQ
 jhp9jxDGKDdODYEeCPaCaC3Z991WpP7VyQQqExbvJFNW6Exm6MXYUldxqjOs2ibcRD1P
 dHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229850; x=1742834650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qX31zqHeedLuC0moymwx118I/OYgCdYe/VclY70qVzc=;
 b=mYJj+j2KNzRrUOuHU2MMlKkUZKAwG6hGBN4uOgD/1Ad3ldsxlFPKHYOkS63CKbmt/V
 7lICo6EtUMK78fCuzZX3MYFvYI5U/ngrqiOiYV2wgt8NFPpaaahmxkKtzy9N+0K+PW3/
 mZcGH/nrLXtNb91lRI6w6c17En9/b4zTym7gEuzx+/oTuCAYS/9B4vWiGagW2YjAte5P
 nrW/seeNw8n4W07/wB2HQhMwjajDPbC1/rVOm9+4W3x/6XwSlWk4LlSNTnObtBYICf7I
 9l4NE4mZWUpJKQYP8DDExQj2kq5g/dPBGRvuPuLWJYSXTDLeZK0/wRmzFkSZQ9yTP6Zh
 mNQQ==
X-Gm-Message-State: AOJu0YyJcAM9PLiDl33O2mQjaGC2Rq/A06lNZ41DWMkOVfFAjZx/3oiO
 aDBe/PQ+BGW+Sm20rx4ffMdtJ7iUHB/ERp/jCmQUc6SREkaShTRuBUWN5w==
X-Gm-Gg: ASbGnctZqf0njQ319/vLNuCho7I3sUnTH1y7KHRZn6IzZgWFbYBpg2OTQtl1wWYcGub
 p5OcheTAZnQ99ym9qrsvuATdDoaqpTiRFlfAGi7+casWXO8S8o1M+11s/NIsD3OuChX93PFSQS2
 zHsPbiXMD7jAhUEMN7l9+47y9X6JTm5ku6EeZJlE7EYg4hQEYPhMpFgVydIoiZFWH+IcJttQM0y
 kdugDDGsIwt819bkYJ3fa4yb2923r1WxFcuF3hYN82Cw1BXKRK6Yk1oSUSlWri9wjFvCALgMf3A
 KNfaB1nfUCccTHvFpmQx1ch1/DjTXx8OCbR5idkJt5BYdS5cJkk7nAQgElq6LHngmw==
X-Google-Smtp-Source: AGHT+IHTebDERZjGklDFMKmEuc+upsuhOSlF8scUGuGJDUpkpQHIzWWc0tRIDXwvlj9dgAvfbHTwPA==
X-Received: by 2002:a17:902:f708:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-2262c55fcafmr2783855ad.22.1742229849743; 
 Mon, 17 Mar 2025 09:44:09 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:44:09 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Date: Mon, 17 Mar 2025 16:31:36 +0000
Message-ID: <20250317164204.2299371-10-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:39 -0400
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

FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5bcbd434b7..37810d892f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -128,6 +128,7 @@ enum {
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
         #define INITIATE_DC_ADD           0x4
+        #define INITIATE_DC_RELEASE       0x5
 
 };
 
@@ -3722,6 +3723,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
                                                ext.start_dpa, ext.len)) {
                 return CXL_MBOX_INVALID_EXTENT_LIST;
             }
+        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
+            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_PA;
+            }
         }
     }
 
@@ -3835,6 +3840,88 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h)
+ */
+static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t flags;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
+    CXLEventDynamicCapacity event_rec = {};
+    CXLDCExtentRaw ext;
+    int i, rc = 0;
+
+    switch (in->flags & 0x7) {
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_RELEASE_CAPACITY);
+        if (rc) {
+            return rc;
+        }
+
+        /* Create extents for Event Record */
+        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
+        for (i = 0; i < in->ext_count; i++) {
+            ext = in->extents[i];
+            event_rec_exts[i].start_dpa = ext.start_dpa;
+            event_rec_exts[i].len = ext.len;
+            memset(event_rec_exts[i].tag, 0, 0x10);
+            event_rec_exts[i].shared_seq = 0;
+        }
+
+        /* Create event record and insert to event log */
+        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
+        event_rec.type = DC_EVENT_RELEASE_CAPACITY;
+        /* FIXME: for now, validity flag is cleared */
+        event_rec.validity_flags = 0;
+        /* FIXME: Currently only support 1 host */
+        event_rec.host_id = 0;
+        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
+        event_rec.updated_region_id = 0;
+        for (i = 0; i < in->ext_count; i++) {
+            memcpy(&event_rec.dynamic_capacity_extent,
+                   &event_rec_exts[i],
+                   sizeof(CXLDCExtentRaw));
+
+            event_rec.flags = 0;
+            if (i < in->ext_count - 1) {
+                /* Set "More" flag */
+                event_rec.flags |= BIT(0);
+            }
+
+            if (cxl_event_insert(&ct3d->cxl_dstate,
+                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
+                                 (CXLEventRecordRaw *)&event_rec)) {
+                cxl_event_irq_assert(ct3d);
+            }
+        }
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3977,6 +4064,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
 };
 
 /*
-- 
2.47.2


