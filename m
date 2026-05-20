Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbqq-0003UR-AX; Wed, 20 May 2026 04:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqN-0003Sq-NL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqL-00047I-PT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ba856db1c0so32984255ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779263992; x=1779868792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxzZDu5BKm346SHqX6kslm5xBxSbr8zBKiC+4HDaSlU=;
 b=jnOK+DKu8Lifr0atebU2QAsynJNThWp1l3upHL3kHe4DoGOD72C7OcNjRGLnA5oTP8
 1mt1iUjvREL21DcuUIryZL6okkO5Y+lInjEBgRBsEYuz8Rx9eMEqAu0HxleIwog3s6XA
 eKJle3Kc0Jfiw8vYbPhgGIORaJgrH7CSbbOBJT6rRWyjm6ZQb/o8znlkTcDHSXtXANjS
 i0Pkin7Zk42p0Hm5Z773f1s8O11YPTPaVMskCEYHr+v4riodtpLX7BjQPCJ4rUWiMCvG
 sAFAc+rMy54bnR5igBNalWsSZaWRHa+TMH1xvJofsVDpGQPgGuMXLMLDsCGI8o08jfi5
 6E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263992; x=1779868792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IxzZDu5BKm346SHqX6kslm5xBxSbr8zBKiC+4HDaSlU=;
 b=DHDtiDuJJoN1s+s/rU5I3cU+ixmPdsmYOZPjwqpksLeRFD7A5JEupDrEAFG6MtaOmb
 E9ZovZ2W1CzXplu9KWb3JptxlR2KYR7ZKnUm1tEuviLv1xK5DcgCRbxRVGe9sACLY22c
 YeUkKdumB4rKnHBvCpSBP15pitOWZbAC2P4X1oJ+AdPkasoF9CML+dYWyZ5KJiC4u6O4
 jE6tE2L3827F0i052+xHfMn6ZJbs8VBVnmldDIvXY54NPTvWcUWF6SalRNdocYYAkops
 HHgXk1DW6E2/gjJlDUElr1GvcCLhU6Tii0Wnu6G4HmXoBdjkfe7VoxJwgGx32n+5SmKB
 tBXQ==
X-Gm-Message-State: AOJu0YzNYBPiu1dqz4ldh14V38Mard6bKBxT4Fzz5s5Y89Fvxgc9oSTc
 MCCtxfw/EVYc5oeAGQtkCaDOt0u4EC9cu/vdRHa2mWzM5hIEHOiar7FDM+c2tQ==
X-Gm-Gg: Acq92OG8JL9Gd497JsQysfBuFCytaJoVE7JwodQ3dP0Xz65ZD3+9TEKQCfArcs1SE1w
 A6asTyhtOQzVsLcFul6zCcJqQbzWCp2hZl85K0sgj006kDOPiGNbjJ+SRy4VikkLEoLcbXA8h50
 jZU5cSgHH34JqisQqjL/hkcjS04ZFtXKlUJ15Cv15NNMq8TgjmIku27AFsYCB/xBLVinLu5DkIT
 ddUMQ+k5sZOlS2WSOD2FQ0zMsvrNLBZCqet3mJEaciXOeRFIuQbNv6lAuWNpsByFt2Wv+V/zLCx
 PqDj5r9Yn3h+VNFePOfQOXt9/7yFi4qeTrK6Vl4SHz6ULdNtrjYQIZJgDfrEdzJpT4Ryjmr2qHy
 VtrHhGRfgJzrocfBHUe4yL7VHrJK62BAF7947He3G0tlYLuvJ0XYwtTkVlDbvKfL1NrxMBYo6v2
 LvOR9grHLHAILa34jTHVY7x26vV1A8
X-Received: by 2002:a17:903:32ce:b0:2b0:6a22:5165 with SMTP id
 d9443c01a7336-2bd7e77a968mr235897775ad.7.1779263991821; 
 Wed, 20 May 2026 00:59:51 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05ffbesm216608435ad.27.2026.05.20.00.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:59:51 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com,
 Jaemyung Lee <ldc.jml@gmail.com>
Subject: [PULL 2/5] hw/ufs: Modify flag handling operation
Date: Wed, 20 May 2026 16:59:28 +0900
Message-ID: <c1bf59e836bd48557ee6d7c7bb0c939a31aaffc0.1779263628.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779263628.git.jeuk20.kim@samsung.com>
References: <cover.1779263628.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jaemyung Lee <ldc.jml@gmail.com>

Change internal flag handling operation same as attribute's

In UFS device, some flag queries directly trigger specific device
behaviour like attribute's, not only changes the internal values.
So restructure flag query processing functions same as attribute
processing, to facilitate linking detailed implementations based on
individual flag value changes.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 152 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 33 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index a3f2a3be18..2cf838d20f 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1089,6 +1089,122 @@ static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
     return UFS_QUERY_RESULT_SUCCESS;
 }
 
+static uint32_t ufs_read_flag_value(UfsHc *u, uint8_t idn)
+{
+    switch (idn) {
+    case UFS_QUERY_FLAG_IDN_FDEVICEINIT:
+        return u->flags.device_init;
+    case UFS_QUERY_FLAG_IDN_PERMANENT_WPE:
+        return u->flags.permanent_wp_en;
+    case UFS_QUERY_FLAG_IDN_PWR_ON_WPE:
+        return u->flags.power_on_wp_en;
+    case UFS_QUERY_FLAG_IDN_BKOPS_EN:
+        return u->flags.background_ops_en;
+    case UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE:
+        return u->flags.device_life_span_mode_en;
+    case UFS_QUERY_FLAG_IDN_PURGE_ENABLE:
+        return u->flags.purge_enable;
+    case UFS_QUERY_FLAG_IDN_REFRESH_ENABLE:
+        return u->flags.refresh_enable;
+    case UFS_QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL:
+        return u->flags.phy_resource_removal;
+    case UFS_QUERY_FLAG_IDN_BUSY_RTC:
+        return u->flags.busy_rtc;
+    case UFS_QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE:
+        return u->flags.permanently_disable_fw_update;
+    case UFS_QUERY_FLAG_IDN_WB_EN:
+        return u->flags.wb_en;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN:
+        return u->flags.wb_buffer_flush_en;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8:
+        return u->flags.wb_buffer_flush_during_hibernate;
+    case UFS_QUERY_FLAG_IDN_UNPIN_EN:
+        return u->flags.unpin_en;
+    default:
+        g_assert_not_reached();
+        return 0;
+    }
+}
+
+static QueryRespCode ufs_write_flag_value(UfsHc *u, uint8_t idn, uint8_t value)
+{
+    switch (idn) {
+    case UFS_QUERY_FLAG_IDN_FDEVICEINIT:
+        u->flags.device_init = 0;
+        break;
+    case UFS_QUERY_FLAG_IDN_PERMANENT_WPE:
+        u->flags.permanent_wp_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_PWR_ON_WPE:
+        u->flags.power_on_wp_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_BKOPS_EN:
+        u->flags.background_ops_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE:
+        u->flags.device_life_span_mode_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_PURGE_ENABLE:
+        u->flags.purge_enable = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_REFRESH_ENABLE:
+        u->flags.refresh_enable = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL:
+        u->flags.phy_resource_removal = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE:
+        u->flags.permanently_disable_fw_update = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_WB_EN:
+        u->flags.wb_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN:
+        u->flags.wb_buffer_flush_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8:
+        u->flags.wb_buffer_flush_during_hibernate = value;
+        break;
+    default:
+        return UFS_QUERY_RESULT_INVALID_VALUE;
+    }
+
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
+{
+    UfsHc *u = req->hc;
+    uint8_t idn = req->req_upiu.qr.idn;
+    uint8_t value;
+    QueryRespCode ret;
+
+    ret = ufs_flag_check_idn_valid(idn, op);
+    if (ret) {
+        return ret;
+    }
+
+    if (op == UFS_QUERY_FLAG_READ) {
+        value = ufs_read_flag_value(u, idn);
+        ret = UFS_QUERY_RESULT_SUCCESS;
+    } else if (op == UFS_QUERY_FLAG_SET) {
+        value = 1;
+        ret = ufs_write_flag_value(u, idn, value);
+    } else if (op == UFS_QUERY_FLAG_CLEAR) {
+        value = 0;
+        ret = ufs_write_flag_value(u, idn, value);
+    } else if (op == UFS_QUERY_FLAG_TOGGLE) {
+        value = !(ufs_read_flag_value(u, idn));
+        ret = ufs_write_flag_value(u, idn, value);
+    } else {
+        trace_ufs_err_query_invalid_opcode(op);
+        return UFS_QUERY_RESULT_INVALID_OPCODE;
+    }
+
+    req->rsp_upiu.qr.value = cpu_to_be32(value);
+    return ret;
+}
+
 static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
     /* booting is not supported */
     [UFS_QUERY_ATTR_IDN_BOOT_LU_EN] = UFS_QUERY_ATTR_READ,
@@ -1172,39 +1288,6 @@ static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
     return UFS_QUERY_RESULT_SUCCESS;
 }
 
-static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
-{
-    UfsHc *u = req->hc;
-    uint8_t idn = req->req_upiu.qr.idn;
-    uint32_t value;
-    QueryRespCode ret;
-
-    ret = ufs_flag_check_idn_valid(idn, op);
-    if (ret) {
-        return ret;
-    }
-
-    if (idn == UFS_QUERY_FLAG_IDN_FDEVICEINIT) {
-        value = 0;
-    } else if (op == UFS_QUERY_FLAG_READ) {
-        value = *(((uint8_t *)&u->flags) + idn);
-    } else if (op == UFS_QUERY_FLAG_SET) {
-        value = 1;
-    } else if (op == UFS_QUERY_FLAG_CLEAR) {
-        value = 0;
-    } else if (op == UFS_QUERY_FLAG_TOGGLE) {
-        value = *(((uint8_t *)&u->flags) + idn);
-        value = !value;
-    } else {
-        trace_ufs_err_query_invalid_opcode(op);
-        return UFS_QUERY_RESULT_INVALID_OPCODE;
-    }
-
-    *(((uint8_t *)&u->flags) + idn) = value;
-    req->rsp_upiu.qr.value = cpu_to_be32(value);
-    return UFS_QUERY_RESULT_SUCCESS;
-}
-
 static inline uint8_t ufs_read_device_temp(UfsHc *u)
 {
     uint8_t feat_sup = u->device_desc.ufs_features_support;
@@ -1369,6 +1452,9 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
     case UFS_QUERY_ATTR_IDN_TIMESTAMP:
         u->attributes.timestamp = cpu_to_be64(value);
         break;
+    default:
+        g_assert_not_reached();
+        return 0;
     }
     return UFS_QUERY_RESULT_SUCCESS;
 }
-- 
2.43.0


