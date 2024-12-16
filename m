Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04155E77184
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 01:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0Lh-0006Ls-Gi; Sun, 15 Dec 2024 20:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0Lg-0006LM-92
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:40 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0Le-0007o6-7r
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:39 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxL63JiF9nkUBXAA--.102S3;
 Mon, 16 Dec 2024 09:56:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxnsK3iF9nKNCEAA--.50112S14;
 Mon, 16 Dec 2024 09:56:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 12/18] hw/intc/loongarch_extioi: Rename LoongArchExtIOI with
 LoongArchExtIOICommonState
Date: Mon, 16 Dec 2024 09:56:01 +0800
Message-Id: <20241216015607.1795880-13-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241216015607.1795880-1-maobibo@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxnsK3iF9nKNCEAA--.50112S14
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With some structure such as vmstate and property, rename LoongArchExtIOI
with LoongArchExtIOICommonState, these common structure will be moved
to common file.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c | 41 +++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 97d1af5ccc..2ec5a75817 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -391,6 +391,11 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static int loongarch_extioi_common_post_load(void *opaque, int version_id)
+{
+    return vmstate_extioi_post_load(opaque, version_id);
+}
+
 static const VMStateDescription vmstate_extioi_core = {
     .name = "extioi-core",
     .version_id = 1,
@@ -402,31 +407,35 @@ static const VMStateDescription vmstate_extioi_core = {
 };
 
 static const VMStateDescription vmstate_loongarch_extioi = {
-    .name = TYPE_LOONGARCH_EXTIOI,
+    .name = "loongarch.extioi",
     .version_id = 3,
     .minimum_version_id = 3,
-    .post_load = vmstate_extioi_post_load,
+    .post_load = loongarch_extioi_common_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOI, EXTIOI_IRQS_GROUP_COUNT),
-        VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOI,
+        VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_GROUP_COUNT),
+        VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOICommonState,
                              EXTIOI_IRQS_NODETYPE_COUNT / 2),
-        VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOI, EXTIOI_IRQS / 32),
-        VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOI, EXTIOI_IRQS / 32),
-        VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOI, EXTIOI_IRQS_IPMAP_SIZE / 4),
-        VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOI, EXTIOI_IRQS / 4),
-
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOI, num_cpu,
-                         vmstate_extioi_core, ExtIOICore),
-        VMSTATE_UINT32(features, LoongArchExtIOI),
-        VMSTATE_UINT32(status, LoongArchExtIOI),
+        VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 32),
+        VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 32),
+        VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_IPMAP_SIZE / 4),
+        VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 4),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOICommonState,
+                             num_cpu, vmstate_extioi_core, ExtIOICore),
+        VMSTATE_UINT32(features, LoongArchExtIOICommonState),
+        VMSTATE_UINT32(status, LoongArchExtIOICommonState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static Property extioi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
-    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOI, features,
-                    EXTIOI_HAS_VIRT_EXTENSION, 0),
+    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOICommonState, num_cpu, 1),
+    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOICommonState,
+                    features, EXTIOI_HAS_VIRT_EXTENSION, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.5


