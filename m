Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0454C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jp-0002yj-N1; Tue, 08 Sep 2026 23:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3o86gagoKCiAOP6JHAUFDQCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--stanleyjhu.bounces.google.com>)
 id 1x48jn-0002y2-Bu
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:39 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3o86gagoKCiAOP6JHAUFDQCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--stanleyjhu.bounces.google.com>)
 id 1x48jl-000553-B4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:39 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-84e1da97175so6270712b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923555; x=1789528355; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jd1olvtxPwF2Z4hkpdSlSyV0VkfWJ+WuYO0Ye3sE0mY=;
 b=B2IS5C/PQMhCLiYdDQDEPaGpgCx6yy1pOBrcFVT2DXP/IhR5OY4dMV8753YaCseiNU
 2mQ5+rpMFKem4KGm/daMqLVPimbUj02Ez0wwa57GausMDJ6Fkh434VKGa9Mu6AXGM7kg
 DshQdt5PUkInYl07XHLVEKplmw18bA0Cf3y7/jAS57JDjjWEaqY+GIM3hm+8wHoaSBD5
 53JzTenNA/P0XcFczam/+ybr0e84aYu/KN28sPfpDdQfjQxRQsbni114tmAUsEl5jQuB
 ETMnXo1DTgT4qFNIrE4sg8s7gLHokXU7mQJFnoymdnHOCG1mzQU8DhP3+WOvIgbumCa2
 M8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923555; x=1789528355;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jd1olvtxPwF2Z4hkpdSlSyV0VkfWJ+WuYO0Ye3sE0mY=;
 b=dnerECVkP+WYTX8dFIHQIwNArxd39H2hIbX08sc/L2V/zHKcECbinkxKjP/U55YdT8
 vpBpt8ehnawoAEIH/P6mgqkMdN9e6dalz7sxmG3s8stPOGWIcpHct51/45xw9lwro/oq
 yI3YCC9YHcoEt32cDlkUsW5zEqqv5yLbvWwChQ3e6w7PxEVdKggsHTeCcgyZ1a+/eTmc
 hk5dMD16bpt9u1LY6x5aIs8Ye2Qm+J/Xr/qGj2PLSmaJvtahIgyhOdiP2287S89ea8AQ
 ZIjL+gEwkYi4wnSiAPOwEMbCALiN/bdAafQ/oKP5b15VQpdE8qhQx2BlxZjMGd5UasLj
 0PvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtlmStg1fQX71FMSJJ6/HgrZUzJnHNDYEnZmZIP1uZCUBalJaxvmboIq3XtFVgmG9K5ylQVvhjf6pt@nongnu.org
X-Gm-Message-State: AFuF++mcOiawqmpg995HtASSWjwi6mSYeAZviLvPdGdUTorRISgov1At
 fMVGMRNfuswUj8+e2gv5XYvEv2+pd+/0TCdyuqNv4kyoz9wBsL6/rhobhHr1SCRfWS+fsx20pt2
 y99IWaRkYjCXHUGNwHYf6lw==
X-Received: from pfme16.prod.google.com ([2002:aa7:98d0:0:b0:848:8b93:1295])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4305:b0:845:cf73:c1d8 with SMTP id
 d2e1a72fcca58-861684928f1mr45981910b3a.14.1788923555121; 
 Tue, 08 Sep 2026 20:12:35 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:12:29 +0800
In-Reply-To: <20260909031229.1650315-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260909031229.1650315-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031229.1650315-3-stanleyjhu@google.com>
Subject: [PATCH v2 2/2] hw/ufs: Add ssu-timeout mode for power management
 recovery testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3o86gagoKCiAOP6JHAUFDQCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x447.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Extend the experimental fault injection property x-hold-mode with a new
"ssu-timeout" mode to facilitate automated testing of host driver power
management and Start Stop Unit (SSU) recovery handling.

When x-hold-mode="ssu-timeout" is set, the controller intercepts SCSI
START_STOP (0x1B) commands sent to the Well-Known LUN (WLUN) and delays
their completion without queuing them to the SCSI layer. This triggers
the host driver's 10-second SSU command timeout and subsequent power
management recovery routines (e.g., during suspend-to-idle or freeze
transitions), verifying driver robustness and link restoration paths.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/ufs.c | 21 +++++++++++++++++++--
 hw/ufs/ufs.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 3bdfe5762e..43c4b4bdba 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2410,7 +2410,17 @@ static void ufs_exec_req(UfsRequest *req)
                 UFS_UPIU_TRANSACTION_COMMAND) {
                 uint8_t op = req->req_upiu.sc.cdb[0];
 
-                if (op == READ_10 || op == WRITE_10) {
+                if (req->hc->hold_mode == UFS_HOLD_SSU_TIMEOUT) {
+                    if (op == START_STOP &&
+                        req->req_upiu.header.lun == UFS_UPIU_UFS_DEVICE_WLUN) {
+                        req->hc->active_hold_tag =
+                            req->req_upiu.header.task_tag;
+                        req->hc->held_req = req;
+                        trace_ufs_inject_hold_req(req->req_upiu.header.task_tag,
+                                                  0);
+                        return;
+                    }
+                } else if (op == READ_10 || op == WRITE_10) {
                     /*
                      * In 10-byte SCSI read/write commands (SBC-4), bytes 2..5
                      * encode the 32-bit Logical Block Address (LBA) in
@@ -3129,6 +3139,9 @@ static void ufs_prop_get_hold_mode(Object *obj, Visitor *v, const char *name,
     case UFS_HOLD_TIMEOUT:
         str = "timeout";
         break;
+    case UFS_HOLD_SSU_TIMEOUT:
+        str = "ssu-timeout";
+        break;
     case UFS_HOLD_ABORT_SUCCESS:
     default:
         str = "abort-success";
@@ -3160,6 +3173,8 @@ static void ufs_prop_set_hold_mode(Object *obj, Visitor *v, const char *name,
         mode = UFS_HOLD_IN_TRANSITION;
     } else if (g_strcmp0(str, "timeout") == 0) {
         mode = UFS_HOLD_TIMEOUT;
+    } else if (g_strcmp0(str, "ssu-timeout") == 0) {
+        mode = UFS_HOLD_SSU_TIMEOUT;
     } else {
         error_setg(errp, "invalid x-hold-mode: %s", str);
         g_free(str);
@@ -3187,7 +3202,7 @@ static void ufs_prop_release_hold_mode(Object *obj, const char *name,
 const PropertyInfo ufs_prop_hold_mode = {
     .type = "str",
     .description = "Fault injection mode: abort-success, abort-failed, "
-                   "in-transition, timeout",
+                   "in-transition, timeout, ssu-timeout",
     .get = ufs_prop_get_hold_mode,
     .set = ufs_prop_set_hold_mode,
     .release = ufs_prop_release_hold_mode,
@@ -3212,6 +3227,8 @@ bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
         u->hold_mode = UFS_HOLD_IN_TRANSITION;
     } else if (g_strcmp0(u->params.x_hold_mode, "timeout") == 0) {
         u->hold_mode = UFS_HOLD_TIMEOUT;
+    } else if (g_strcmp0(u->params.x_hold_mode, "ssu-timeout") == 0) {
+        u->hold_mode = UFS_HOLD_SSU_TIMEOUT;
     } else {
         error_setg(errp, "invalid x-hold-mode: %s", u->params.x_hold_mode);
         return false;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6edeab9db9..8e7b79a8c9 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -109,6 +109,7 @@ typedef enum UfsHoldMode {
     UFS_HOLD_ABORT_FAILED,
     UFS_HOLD_IN_TRANSITION,
     UFS_HOLD_TIMEOUT,
+    UFS_HOLD_SSU_TIMEOUT,
 } UfsHoldMode;
 
 /*
-- 
2.55.0.1007.g17ff1f9808-goog


