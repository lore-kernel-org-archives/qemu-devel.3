Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC2CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHQ4-000610-IF; Mon, 12 Oct 2026 10:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dridiha98@gmail.com>)
 id 1xGHPQ-0005lq-Dm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:53:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dridiha98@gmail.com>)
 id 1xGHPN-0004m1-Iw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:53:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b00aa033bso225191f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791816821; x=1792421621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HzhU63K24jErOJnBOUdAYsK2+MVciJckXxpdIRqO734=;
 b=jKJHx/BNzs4EUFLKQDLZzVp60jHqEkpYlLKWZ8s0lKR/1fgr5SJ1cNDIWTQKRvcuOQ
 lmCgWGbzK9/tb8fNuunrK56vSnmzP86L0CsZ715E0aKT29rFXaknISrggOqe+9MShAzO
 ze5GnGxoz0pxFvtlDjSkzGQPE9Me3E7kgAHFh4WtG9Ij5Lj+e+ld+Rd/FlDdkjnsibvP
 Qg7wsVT1nx+Npw1Mmw7BxAtNA1C76JRUakAeii5ENp5LPL9owTGg47S18P6d6KOFZzR2
 nJLrp1kf3BdRfXfjRcYLMYAjZyeuYt+09gjDGFRow5sn9YMmkpO9zKKx4BY230FP1yW2
 jSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816821; x=1792421621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HzhU63K24jErOJnBOUdAYsK2+MVciJckXxpdIRqO734=;
 b=lpjxnIANM6doWF/7aG4bhbpaFXuEdHlPEzPV9Ndg6gLG8C+6CHKwrgjCyT4iWXJj+h
 XpFeJTSAXuhgxdzT5PLG+6oc7s/B45/tt8W/hlOdrftm2mZLKnqUfPY+cNdCoW3rElmd
 uojn8ZtsBFsEWc8lYjuKoag3jy7TIPZLfqYDtRfZ29hZLr4wkSXabEjskE4Ke3VsrcAh
 AZE3VLk4Zpz25xxop2T+LBN/CaNbW+/IdVdw4+VBf58Wj5UC/RVlixh4LCCd6zfYB4Lj
 TE7cnSSojcoDq6EsNxf2cDZ9PDBmj2OXJxOHYr05JjhC/IyirP3xcZ6HOEqhCuLR2zRu
 2DDw==
X-Gm-Message-State: AFq9FYKDtPt0lECVV2Lu2FjSufnmzcSlwt2aPcrvUSFtZzLHuZgDn/HD
 Sh8lp13TnwW7MXjypGYZgKdguFgwbUOS7V53i5oKgbrkl//7J0G1fHfsbw5IYebX
X-Gm-Gg: AYBFou2jezNjdxx9p8IXNCOuaM2RhmiLmi9Vn4kI48Gz9rJMRuGhNdpavF0bygFs2py
 o9wIcsJ0SZ8fK/a+Xm65heR15CQ6IVyM8go4+bBSUC9s9JNtZS32JERJHmYsxekKdYVj+hIM16F
 dFdUS4w1yWt2DX/ahqfLcT5kDL5iq39JQZIEDu/cai08kiqsy82SuG+osI+mL3YfV1k+YDhsl1N
 p3CEawJibtGOOgQdAS+iUsu3lElOdx3VOd0YaliZpPaQpd3+mRr+CcCuN4eyiK22tRBAtO8fEsd
 nx9JOobxfxjEQ+Et6EohhpBVpwXl1fnhw9WwMb45f4AqC1aSEeO/n+mk/YABIrAK08eEvGygnmu
 KBCqREEHhv++yQORkFVDJizpIM6q/1JjgEplO69w8JIk5ZPA/RmwIG8Gn/88bYVTZJCZEk0E3Y6
 lHTJqLSqn5rgT1QR6AhByP8w+t+yTWNnEJ3F6pM3kA/mQVxVwXNgUpdePOR32T3YWlIN0jCFCXj
 SwqAy09hu8HV8JK8rKi1vSWwKV1aSFPXrdu4Bn/HLD6wPdPy/VgZbHGIMhKd2ARh6U=
X-Received: by 2002:a5d:5f92:0:b0:48c:4dba:5612 with SMTP id
 ffacd0b85a97d-48dbad3077cmr16267577f8f.5.1791816821028; 
 Mon, 12 Oct 2026 07:53:41 -0700 (PDT)
Received: from root-hamza.home ([2a01:cb14:55d:b000:d70e:e3f9:93c6:2623])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9463049sm20436625f8f.4.2026.10.12.07.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:53:40 -0700 (PDT)
From: Hamza Dridi <dridiha98@gmail.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 dridiha <dridiha98@gmail.com>
Subject: [PATCH v2] hw/ufs: Add support for REPORT_LUNS SCSI command for Well
 Known LUNs
Date: Mon, 12 Oct 2026 16:53:20 +0200
Message-ID: <20261012145320.391400-1-dridiha98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004125305.99878-1-dridiha98@gmail.com>
References: <20261004125305.99878-1-dridiha98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=dridiha98@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: dridiha <dridiha98@gmail.com>

According to the UFS specification, the REPORT_LUNS SCSI command can query
Well Known LUNs by setting CDB[2] to 0x01 (select Well Known LUNs) or 0x02
(select all LUNs).

Currently, the UFS emulation layer lacks handling for these CDB[2] select
report values, causing command failures when guests attempt to report Well
Known LUNs.

This patch adds support for handling CDB[2] values 0x01 and 0x02 in the
REPORT_LUNS command, returning the appropriate Well Known LUN descriptors
in the SCSI response payload.

Signed-off-by: Hamza Dridi <dridiha98@gmail.com>
---
v1 -> v2:
- Cleard the UPIU WLUN-ID before writing the Wlun byte.

 hw/ufs/lu.c         | 44 ++++++++++++++++++++++++++++++++++----------
 include/block/ufs.h |  3 +++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bdb1650851..4f1f4f265f 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -211,33 +211,57 @@ static const struct SCSIBusInfo ufs_scsi_info = {
     .cancel = ufs_scsi_command_cancelled,
 };
 
+static bool ufs_append_lun(uint8_t *outbuf, uint32_t outbuf_len, int *len,
+                           uint8_t lun, uint8_t lun_msb)
+{
+    if (*len + 8 > outbuf_len) {
+        return false;
+    }
+
+    memset(outbuf + *len, 0, 8);
+    outbuf[*len] = lun_msb;
+    outbuf[*len + 1] = lun;
+    *len += 8;
+
+    return true;
+}
+
 static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
                                    uint32_t outbuf_len)
 {
     UfsHc *u = req->hc;
     int len = 0;
 
-    /* TODO: Support for cases where SELECT REPORT is 1 and 2 */
-    if (req->req_upiu.sc.cdb[2] != 0) {
+    uint8_t report_lun_cmd = req->req_upiu.sc.cdb[2];
+
+    if (report_lun_cmd > 2) {
         return SCSI_COMMAND_FAIL;
     }
 
     if (outbuf_len < 8) {
         return SCSI_COMMAND_FAIL;
     }
+
     memset(outbuf, 0, 8);
     len += 8;
 
-    for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
-        if (u->lus[lun]) {
-            if (len + 8 > outbuf_len) {
+    if (report_lun_cmd == 2 || report_lun_cmd == 1) {
+        ufs_append_lun(outbuf, outbuf_len, &len, u->report_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->dev_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->boot_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->rpmb_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+    }
+
+    if (report_lun_cmd == 0 || report_lun_cmd == 2) {
+        for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
+            if (u->lus[lun] &&
+                !ufs_append_lun(outbuf, outbuf_len, &len, lun, 0)) {
                 break;
             }
-
-            memset(outbuf + len, 0, 8);
-            outbuf[len] = 0;
-            outbuf[len + 1] = lun;
-            len += 8;
         }
     }
 
diff --git a/include/block/ufs.h b/include/block/ufs.h
index d19b3c65ef..9d5ec4c77f 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -818,6 +818,9 @@ typedef struct QEMU_PACKED UtpTaskReqDesc {
  */
 #define UFS_EHS_OFFSET_IN_RESPONSE 32
 
+/* Most significant byte in the Report Lun response for Well Known LU */
+#define UFS_WLUN_MSB 0xC1
+
 /* Well known logical unit id in LUN field of UPIU */
 enum {
     UFS_UPIU_REPORT_LUNS_WLUN = 0x81,
-- 
2.43.0


