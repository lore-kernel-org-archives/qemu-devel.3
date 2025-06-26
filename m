Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1E3C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5M-0006Q7-8t; Thu, 26 Jun 2025 18:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv5B-0006Lv-D0
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv58-0000uI-LK
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2350fc2591dso15861495ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976911; x=1751581711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7glFkwmiYhht2UqiHenwImRsN9dIKZyhfzkSZpDnTys=;
 b=NX9zSwTaTB51VTrq2u6YP2oSQT3hAgirYHw1h4zUPC+JzJSYKJtd4Qb0hefeVUh/1d
 3n0IQjbSUksV8pw2ubZvJEuFAOFHblOVwyTaQRhZJI/+eWMvZm/eMN3DI5wrJn1JFV3a
 60nwAl2qQmQYmlrim6YvLhUyo2vojUjqJVLE7Xcy9zGmIveiKdM6kMN4uHuHuIvlv2bk
 fEVnQIwPtZ8Y1agOau3kFiEBNPqBt9MZVVmuawpAKpfvu8FoW/ZLwNx6bWEI4cFwHk/V
 uZ/po6ox9B+PpbLpZ0+cJgthUaasqE10MqxuqhOGPD6Rb/r8ZR/9KEWGnvwjz+dXoMj+
 uBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976911; x=1751581711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7glFkwmiYhht2UqiHenwImRsN9dIKZyhfzkSZpDnTys=;
 b=Bv42M6jA5F6l1YaNDdhnDnaNHPf0m5981PS3HZGOJpV5Dzw6V9Vda4TlTNiJsI+gmA
 Wjyz4bQfgnEKm1GGz3Gm8+5OXB7gS54+rEcFKSqvnbi6kdRcIKJHWBZEwcA5PV+SNAtB
 i65hTupYlNcw0k2+1OMPvLaC29xEl42Wsp9FoD1C3JAs5/Q2VhPC/LeKcixr8lGvRC93
 Yibd9xfzPPBJtbSVG5dfxyNh84xxZo+oAt70lK11X4xMoOFwdZbFwVhT4enPhsGq5ZCo
 1pKi2byDFZOxAJmBXIZHp+ihgduIG5ka3QSF4izfvTm2OV7BI6r5ClqCeQfEAtU6IUCS
 zk5g==
X-Gm-Message-State: AOJu0YzeOXXq8jxlImZ78Fs4DZr8J4reWfk9YMa0cQ+vYyu8ENuqfneU
 nHcSvAUXRNtYWRBIO9CEwApDMZQcmftxVpbfVZ5ix/QGb0xbtNETKFQdAkinSw==
X-Gm-Gg: ASbGnctFAtIgnrWAzAq14Z9b61F0wqcDLnT1x4aTV872QipVYd4KGyfQZwrclBEmIPX
 yUFRxZWKRBGJHJCvXzd6TD3y3p5+EQWXPIYLxaAiymChb+hYy5hs1UK5pHl8lvlaMrvSPVHyATh
 68W4zlSj7vxA1tbdP9OcGIVtZP+IyE2meslGUEY+Mv6GovhBiTLmE5f+G3Jj3iy5u819rFSg7ZD
 QQXf86mUr4dJUtloYbXqTuGgA7uiAWcPbO+InaeqVVIQd178edQWdGmj8vfWLTY9wO/mlbkSafH
 VY26zn9TaixvS8522q4a4jAUVY2ji3pK53/mOmpa7tj22pgVGmw3sQBmaUNMkC2qy17ojhjfpNp
 +Ry6o/PLr+Wv4tORXDg==
X-Google-Smtp-Source: AGHT+IERKAxuYglZ602YznoXS5WYzlxGHsy6vL5DHQrNlWRyuMa8i4Cr/x9YgZZ+r9vALe46nBLCtQ==
X-Received: by 2002:a17:903:110d:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-23ac61842d1mr8904825ad.20.1750976910978; 
 Thu, 26 Jun 2025 15:28:30 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:30 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 10/10] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC
 Release
Date: Thu, 26 Jun 2025 22:23:33 +0000
Message-ID: <20250626222743.1766404-11-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x629.google.com
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

FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 787eeaa7b9..87f9535d46 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
         #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3638,6 +3639,77 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     }
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
+#define CXL_FORCED_REMOVAL_MASK (1 << 4)
+/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
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
+    int i, rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
+            CXLDCExtentList updated_list;
+            uint32_t updated_list_size;
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+            if (rc) {
+                return rc;
+            }
+
+            /* Fail with Invalid PA if an extent is pending and Forced Removal
+             * flag not set
+             */
+            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
+                for (i = 0; i < in->ext_count; i++) {
+                    CXLDCExtentRaw ext = in->extents[i];
+                    /* Check requested extents don't overlap with pending extents. */
+                    if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                             ext.start_dpa, ext.len)) {
+                        return CXL_MBOX_INVALID_PA;
+                    }
+                }
+            }
+
+            rc = cxl_dc_extent_release_dry_run(ct3d,
+                                               list,
+                                               &updated_list,
+                                               &updated_list_size);
+            if (rc) {
+                return rc;
+            }
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_RELEASE_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                "CXL extent removal policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3772,6 +3844,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
-- 
2.47.2


