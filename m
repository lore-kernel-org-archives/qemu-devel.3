Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87444C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTKww-0001YK-0q; Fri, 26 Jan 2024 07:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTKwR-0001G5-MR
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:04:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTKwL-0001Sk-TH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:04:13 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLx9t6xs2z6F94N;
 Fri, 26 Jan 2024 20:01:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 4D815140B55;
 Fri, 26 Jan 2024 20:04:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:04:02 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 <peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/12] hw/cxl/mbox: Remove dead code
Date: Fri, 26 Jan 2024 12:01:25 +0000
Message-ID: <20240126120132.24248-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
References: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Davidlohr Bueso <dave@stgolabs.net>

Two functions were reported to have dead code, remove the bogus
branches altogether, as well as a misplaced qemu_log call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6eff56fb1b..dc42850767 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
 
     cxl_dev_disable_media(&ct3d->cxl_dstate);
 
-    if (secs > 2) {
-        /* sanitize when done */
-        return CXL_MBOX_BG_STARTED;
-    } else {
-        __do_sanitization(ct3d);
-        cxl_dev_enable_media(&ct3d->cxl_dstate);
-
-        return CXL_MBOX_SUCCESS;
-    }
+    /* sanitize when done */
+    return CXL_MBOX_BG_STARTED;
 }
 
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
@@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
 
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
-        if (ret == CXL_MBOX_SUCCESS) {
-            switch (cci->bg.opcode) {
-            case 0x4400: /* sanitize */
-            {
-                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-
-                __do_sanitization(ct3d);
-                cxl_dev_enable_media(&ct3d->cxl_dstate);
-            }
+        switch (cci->bg.opcode) {
+        case 0x4400: /* sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+            __do_sanitization(ct3d);
+            cxl_dev_enable_media(&ct3d->cxl_dstate);
+        }
+        break;
+        case 0x4304: /* TODO: scan media */
+            break;
+        default:
+            __builtin_unreachable();
             break;
-            case 0x4304: /* TODO: scan media */
-                break;
-            default:
-                __builtin_unreachable();
-                break;
-            }
         }
-
-        qemu_log("Background command %04xh finished: %s\n",
-                 cci->bg.opcode,
-                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
     } else {
         /* estimate only */
         cci->bg.complete_pct = 100 * now / total_time;
-- 
2.39.2


