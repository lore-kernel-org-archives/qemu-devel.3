Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD65606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oOiEQjDY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhlz-0006Wc-Or; Fri, 30 Oct 2026 04:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhli-0006NS-8Q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:22 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlg-0001b0-G9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:21 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-19305bcb72cso300325c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348118; x=1793952918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+XCn0sBHOYbsfWPGiKYrhq0BRf7HOq+gvrjL/gS0UZo=;
 b=oOiEQjDYL7DJuVfy+K5kHTd4umxDsK0QUrqzAc/6hCG4vbxy0cX++iXbQAQ68wgs4I
 RkT1/SWlPjhVQliMJd90wLFR7eZIgTY50vdsX7ErSU72ytukVnAE9sMT9kqpH6Wvwyzw
 5bBzZa4sSW2X9mcey3HGRDsyKP8HcypHdOeHLXGPcjO+lwaPIgCUY/XGqwZqH7/PRA7n
 hoV45n+puRnvgIKAhVlf+O3vl3eSeirNhCPS5KhOxZWVc5QGECeL04nCHC+3TgT7Am8N
 cBjiQZAeROftS+6ELF/uDzWCYFGc1CQaE3mKw33gbfNNpC6gNDdkvkpLxHvKjQb+Tf7e
 rXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348118; x=1793952918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+XCn0sBHOYbsfWPGiKYrhq0BRf7HOq+gvrjL/gS0UZo=;
 b=SRTz0CjLCtk47TRUt2LM8PlOxajLDxy80BK2mepMh3FR5ZLOPSr4KGN7Np3Tu2unWT
 btVVhbBRi8H1Km9UDDwgzXAcoPCzJzONYzpFXFDo1W1M5xtOnmgsv9EFAYY0V4xJgfJi
 XMSCGigOJR38rJt8oTV7imeoCblQgtePRfzsOhRw3xcDCj0yWJTKEx0juKohipagtILb
 2tP8emBI0Q9rAr89ZcF8i8Suekkxm7z9NMIxyR8p/P5eRJTbxy1PCebzaq9V5W16veuj
 vSomLH7wrl1Aa2RAqhQNLhqHOwcv9hzHfczykq6x8H2j7IR8PRaAota2tyDOvWxt5Eil
 NOdA==
X-Gm-Message-State: AFq9FYJhrkIDXexyj/uYzrBY8TDsTdt3gBFi5HFz/OrdlAMonB54zG3S
 0pV+REW9KjVvuLJmw5wnpR6eQ7RyzawVLLOqvIUvTC9/1Vg06yKNwz6HSbL9sA==
X-Gm-Gg: AYBFou2kRbRTuq9jDPuZhRf0Tuy1829CJPgK092Ns7/48UW5QZDGlc7Q1j2WTfQ3KAo
 wRU7cS4r62d0jm+DDTDoyp5lX/5KKnDGfdddrE8aCHTk3BUqxSu/KEFkjNI7sjj8+DcBwIHoB+Z
 DnrQ7K8Kumh8l0Odiv4i8ZyLDJsYTE0iIcxtdD3KITXrxOvP3qoPHjFuA2yH8Xpu6DCf4ExZLk2
 2ks8pOqUdyWfM3eMLmVP3tKVHc+JEgDZifLMqBq4zl4jAh0gUTv9wikBVcZ5xpDRJmJS4U0a+XB
 tpGDRmGqy8NP8xLw8XNgR4nmvQfDLdyT3DQ7HL7H1VfDo3wC3IRutRtJtD04trOMIhzv3X1YtY/
 Uy6VHDJWYG4SH9j5tlXOzis1NFFFO7P2/xHepLlGPwOXi1MfMeelToZLEt04z7g1HBDjPByLB/V
 cpogAEnDGcN+eZ0YDXKPz/3bbycoK86FXjbQcK4t0C8RTGYwKhKvoZvu3DB6OHLTY+jVdJ3dfOe
 9UMtq79IQHAZWAMeOM7zTccYFEbroQS2sxJaNEg6BkE/uH7XHrVHI07xHj+c8VYrtS7ZPsU16sh
 2Kp2azPw3kl5Gf5jg5u4o/7BM1VY2YOvRegSHx/1k5iIRb0hUcVGeh4CN+GTSHAqYg==
X-Received: by 2002:a05:7022:1507:b0:149:49c:233 with SMTP id
 a92af1059eb24-1ac5bbb5048mr2621707c88.27.1793348118159; 
 Fri, 30 Oct 2026 01:15:18 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:17 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 07/12] hw/ufs: Add ssu-timeout mode for power management
 recovery testing
Date: Fri, 30 Oct 2026 17:14:33 +0900
Message-ID: <0c6b9e77fbd1ecd3888c6a694349a3cec7ad6256.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1235.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stanley Jhu <stanleyjhu@google.com>

Extend the experimental fault injection property x-fault-inject-mode
with a new "ssu-timeout" mode to facilitate automated testing of host
driver power management and Start Stop Unit (SSU) recovery handling.

When x-fault-inject-mode="ssu-timeout" is set and x-fault-inject-tag
is armed (e.g., 0xfffffffe for any tag, or a matching tag), the
controller only intercepts SCSI START_STOP (0x1B) commands sent to
the UFS Device Well-Known LUN (WLUN) and holds them without queuing
them to the SCSI layer, while letting non-SSU commands complete
normally. This triggers the host driver's 10-second SSU command
timeout and subsequent power management recovery routines (e.g.,
during suspend-to-idle or freeze transitions), verifying host error
recovery and link restoration paths.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 19 +++++++++++++++++--
 hw/ufs/ufs.h |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 83d5fc24414..f8da7c9554c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -862,6 +862,7 @@ static void ufs_fault_inject_sq_cleanup(UfsHc *u, UfsRequest *req)
 static bool ufs_fault_inject_exec_req(UfsRequest *req)
 {
     UfsHc *u = req->hc;
+    uint8_t op;
 
     if (likely(u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_NONE) ||
         u->held_req != NULL ||
@@ -869,8 +870,21 @@ static bool ufs_fault_inject_exec_req(UfsRequest *req)
         return false;
     }
 
+    op = req->req_upiu.sc.cdb[0];
+    if (u->params.fault_inject_mode == UFS_FAULT_INJECT_SSU_TIMEOUT) {
+        if (op == START_STOP &&
+            req->req_upiu.header.lun == UFS_UPIU_UFS_DEVICE_WLUN &&
+            (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY ||
+             req->req_upiu.header.task_tag == u->active_fault_inject_tag)) {
+            u->active_fault_inject_tag = req->req_upiu.header.task_tag;
+            u->held_req = req;
+            trace_ufs_fault_inject_hold_req(req->req_upiu.header.task_tag, 0);
+            return true;
+        }
+        return false;
+    }
+
     if (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY) {
-        uint8_t op = req->req_upiu.sc.cdb[0];
         uint64_t lba = 0;
         bool is_match = false;
 
@@ -3226,6 +3240,7 @@ const QEnumLookup UfsFaultInjectMode_lookup = {
         [UFS_FAULT_INJECT_ABORT_FAILED] = "abort-failed",
         [UFS_FAULT_INJECT_IN_TRANSITION] = "in-transition",
         [UFS_FAULT_INJECT_TIMEOUT] = "timeout",
+        [UFS_FAULT_INJECT_SSU_TIMEOUT] = "ssu-timeout",
     },
     .size = UFS_FAULT_INJECT_MODE_MAX,
 };
@@ -3295,7 +3310,7 @@ const PropertyInfo ufs_prop_fault_inject_tag = {
 const PropertyInfo ufs_prop_fault_inject_mode = {
     .type = "UfsFaultInjectMode",
     .description = "Fault injection mode: abort-success, abort-failed, "
-                   "in-transition, timeout",
+                   "in-transition, timeout, ssu-timeout",
     .enum_table = &UfsFaultInjectMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 80bdaa1a2aa..7ddc5405465 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -110,12 +110,16 @@ typedef struct UfsLu {
  * UFS_FAULT_INJECT_TIMEOUT:       TMR ABORT_TASK does not complete or clear
  *                                 doorbell, triggering hardware-level TMR
  *                                 timeout.
+ * UFS_FAULT_INJECT_SSU_TIMEOUT:   Intercepts SCSI START_STOP (0x1B) commands
+ *                                 targeting the UFS Device WLUN when
+ *                                 x-fault-inject-tag is armed.
  */
 typedef enum UfsFaultInjectMode {
     UFS_FAULT_INJECT_ABORT_SUCCESS = 0,
     UFS_FAULT_INJECT_ABORT_FAILED,
     UFS_FAULT_INJECT_IN_TRANSITION,
     UFS_FAULT_INJECT_TIMEOUT,
+    UFS_FAULT_INJECT_SSU_TIMEOUT,
     UFS_FAULT_INJECT_MODE_MAX,
 } UfsFaultInjectMode;
 
-- 
2.43.0


