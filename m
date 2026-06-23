Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F8FCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc47F-0004o8-O9; Tue, 23 Jun 2026 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wc473-0004ns-Py
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:36:40 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wc471-0001lP-Gw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
 From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U9ZvIhNcG4QapKyUGQf0jDh5wQXaM09AvHN0FQI2QnM=; b=q
 lM9+CQqK5Jv9XGjUj04xhtGTxEfhInow2iSmKondv5VZtG3t1GvOSR6Ikn3uh4TvlhfTr/Vl8B/Sk
 hufcsVGFEm0H7FIxQFKNLfIiP9sRIIewOP/lfu+6mYc0FFzW0m4qyTJLpQQqI8cfKxPonb8L/8/gx
 ffrSCUfdHcCd+HeR3Jp1OBq5G9SK3jNGe9552qanUH7xYBfe3VGqCT+u26InYE0nvMAP1KpFFEoX+
 rc/rZdfIvW839ujOoXMljRCpm4+WtvYI5of0NQRv9c5gCUQsROO5CQcoPSRCxBO/bJId2asSSPoYN
 Df9oKxjmXBjVJEpmSKuE10iYe19iDzn3w==;
Received: from p548e302f.dip0.t-ipconnect.de ([84.142.48.47] helo=silent.lan)
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <rclobus@rclobus.nl>) id 1wc470-00000006Uha-20OQ;
 Tue, 23 Jun 2026 18:36:34 +0200
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Cc: Roland Clobus <rclobus@rclobus.nl>
Subject: [PATCH] virtio-gpu: Support the configurable EDID fields
Date: Tue, 23 Jun 2026 18:35:36 +0200
Message-ID: <20260623163535.366104-2-rclobus@rclobus.nl>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: rclobus@rclobus.nl
Received-SPF: pass client-ip=2a09:8b00:300:8::10;
 envelope-from=rclobus@rclobus.nl; helo=web05.whitelabeldomein.nl
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds support for the fields that are currently configurable
in the function qemu_edid_generate.

Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
---
 hw/display/virtio-gpu-base.c | 41 +++++++++++++++++++++++++++++++--
 qapi/virtio.json             | 44 ++++++++++++++++++++++++++++++------
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index a68b184829..5391189add 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -69,9 +69,39 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
 
     for (output_idx = 0, node = g->conf.outputs;
          output_idx <= scanout && node; output_idx++, node = node->next) {
-        if (output_idx == scanout && node->value && node->value->name) {
+        if (output_idx != scanout || !node->value) {
+            continue;
+        }
+
+        if (node->value->vendor) {
+            info.vendor = node->value->vendor;
+        }
+        if (node->value->name) {
             info.name = node->value->name;
-            break;
+        }
+        if (node->value->serial) {
+            info.serial = node->value->serial;
+        }
+        if (node->value->has_widthmm) {
+            info.width_mm = node->value->widthmm;
+        }
+        if (node->value->has_heightmm) {
+            info.height_mm = node->value->heightmm;
+        }
+        if (node->value->has_xres) {
+            info.prefx = node->value->xres;
+        }
+        if (node->value->has_yres) {
+            info.prefy = node->value->yres;
+        }
+        if (node->value->has_xmax) {
+            info.maxx = node->value->xmax;
+        }
+        if (node->value->has_ymax) {
+            info.maxy = node->value->ymax;
+        }
+        if (node->value->has_refreshrate) {
+            info.refresh_rate = node->value->refreshrate;
         }
     }
 
@@ -237,6 +267,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     for (output_idx = 0, node = g->conf.outputs;
          node && output_idx < g->conf.max_outputs;
          output_idx++, node = node->next) {
+        if (node->value->has_widthmm && node->value->has_heightmm) {
+            g->req_state[output_idx].width_mm = node->value->widthmm;
+            g->req_state[output_idx].height_mm = node->value->heightmm;
+        }
         if (node->value->has_xres != node->value->has_yres) {
             error_setg(errp,
                        "must set both outputs[%zd].xres and outputs[%zd].yres",
@@ -248,6 +282,9 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             g->req_state[output_idx].width = node->value->xres;
             g->req_state[output_idx].height = node->value->yres;
         }
+        if (node->value->has_refreshrate) {
+            g->req_state[output_idx].refresh_rate = node->value->refreshrate;
+        }
     }
 
     g->hw_ops = &virtio_gpu_ops;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 1fc4e38a44..e1cd5864fe 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -952,24 +952,54 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.  If both @xres and
-# @yres are set, they take precedence over root virtio-gpu resolution
-# configuration and enable the corresponding output.  If none of @xres
-# and @yres are set, root virtio-gpu resolution configuration takes
-# precedence and only the first output is enabled.  Only setting one
-# of @xres or @yres is an error.
+# Describes configuration of a VirtIO GPU output.  Matches the fields
+# of struct @qemu_edid_info.
+# If both @xres and @yres are set, they take precedence over root
+# virtio-gpu resolution configuration and enable the corresponding
+# output.  If none of @xres and @yres are set, root
+# virtio-gpu resolution configuration takes precedence and only the
+# first output is enabled.  Only setting one of @xres or @yres is
+# an error.
+#
+# @vendor: a 3 letter code for the vendor (since xx.x TODO)
 #
 # @name: the name of the output
 #
+# @serial: the serial number (since xx.x TODO)
+#          must be numerical
+#
+# @widthmm: width of the display in mm (since xx.x TODO)
+#           If @widthmm is set, @heightmm must be set too
+#
+# @heightmm: height of the display in mm (since xx.x TODO)
+#           If @heightmm is set, @widthmm must be set too
+#
 # @xres: horizontal resolution of the output in pixels (since 11.0)
 #
 # @yres: vertical resolution of the output in pixels (since 11.0)
 #
+# @xmax: maximum horizontal resolution of the output in pixels
+#        (since xx.x TODO)
+#
+# @ymax: maximum vertical resolution of the output in pixels
+#        (since xx.x TODO)
+#
+# @refreshrate: refreshrate in mHz (since xx.x TODO)
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
+  'data': { '*vendor': 'str',
+            'name': 'str',
+            '*serial': 'str',
+            '*widthmm': 'uint16',
+            '*heightmm': 'uint16',
+            '*xres': 'uint32',
+            '*yres': 'uint32',
+            '*xmax': 'uint32',
+            '*ymax': 'uint32',
+            '*refreshrate': 'uint32' } }
 
 ##
 # @DummyVirtioForceArrays:
-- 
2.53.0


