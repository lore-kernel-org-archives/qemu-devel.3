Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57F5EA8108
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmtZ-00077n-Fw; Tue, 10 Feb 2026 07:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-CSLaQkKCsEhurllzslynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--ankeesler.bounces.google.com>)
 id 1vpmtM-00072A-JK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:30:56 -0500
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-CSLaQkKCsEhurllzslynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--ankeesler.bounces.google.com>)
 id 1vpmtH-0005eN-V8
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:30:53 -0500
Received: by mail-qk1-x749.google.com with SMTP id
 af79cd13be357-8c6a87029b6so246924785a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 04:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1770726649; x=1771331449; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kyNRXINSUTBLxrJLZZH047zYsNH4CQmHf2WvnCpbFRA=;
 b=Yjj9JqKLDssNYHPSY4mA08FHopkQe1j3Oi1Ba5HimpZiedsAv5nr+TzEApR8spVsvA
 KBrwNnbFU/Q//gN3DPrVVmLnCMcL/6TZ2jLDRY7wKLewSG1ng6CiX98ISKG422ELEQY3
 QdKRMwk9eBw+iMDSfXosTrVm46AqXdKgkk9mr1/h66d5nyc6i0BRwtqx+tyraczHSETF
 nxDYlEyxGLIhvIGEOMbtYpGXR/5xrxgsjk3mBCqU118kfaf/bVQp+b37X4jEI/l1mjnF
 NEEStxdzEaDv+ieVQ5EYkNGcgqlJtUP2LuBJRXgdB3y0dHxiaTWPaWDSfCwWCOvaGm4f
 p86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770726649; x=1771331449;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kyNRXINSUTBLxrJLZZH047zYsNH4CQmHf2WvnCpbFRA=;
 b=hqce4LQLYIoxD3pp4dE3D6eP3gWxtbuQX6LM493Se9BPMPX6hOLdYaUt0rEMmbyopN
 Rd653/ypH+jz4xFIVGuTw/ElgFfHgVozBf4EMlyDxKE22VshatSxVOV0N2gmAY4rriuq
 pCSid0UHtwcsfFjWJ9mqkZo2OGTS9lhHXJsnKqf+oN0FI+udMpSrWoD1d6f7s78EGbsv
 lXn63GPkegTleIT2dQDK2o7VSc1ZsHbJ8t1/RYmQRQGZZarYQ0UHQc87BWQ3ZCccOBaK
 88EVP94fBrbMAdi2zW7RdSgqoA1Bh4Q9P0NpQcU3NNCi1Mu3urlRIWjzJpDSXf8SwRjy
 44GA==
X-Gm-Message-State: AOJu0YxpPRSfQ/4xwGaV6iBZ1qXSz6rawWhs2qJuiKUlmzQRuy/iy5Uz
 9D2IHnxMIPVl0yrv89KMhq7D266xhiQucc7sQ1O1yhak5H2YhSZdbJDWmXTsTy6gKDvoP7sitxI
 u7HN2gI3sGlcHhteq
X-Received: from qvbnh18.prod.google.com
 ([2002:a05:6214:3912:b0:894:7038:8d75])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:22e5:b0:8ca:fe5c:ea6d with SMTP id
 af79cd13be357-8cafe5cec8emr1309346585a.59.1770726648982; 
 Tue, 10 Feb 2026 04:30:48 -0800 (PST)
Date: Tue, 10 Feb 2026 12:30:38 +0000
In-Reply-To: <20260210123038.2332364-1-ankeesler@google.com>
Mime-Version: 1.0
References: <20260210123038.2332364-1-ankeesler@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260210123038.2332364-2-ankeesler@google.com>
Subject: [PATCH v5 1/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: alex.bennee@linaro.org, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3-CSLaQkKCsEhurllzslynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--ankeesler.bounces.google.com;
 helo=mail-qk1-x749.google.com
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

In 454f4b0f, we started down the path of supporting separate
configurations per display head (e.g., you have 2 heads - one with
EDID name "AAA" and the other with EDID name "BBB").

In this change, we add resolution to this configuration surface (e.g.,
you have 2 heads - one with resolution 111x222 and the other with
resolution 333x444).

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA",
                 "xres":111,
                 "yres":222
              },
              {
                 "name":"BBB",
                 "xres":333,
                 "yres":444
              }
            ]}'

Here is the behavior matrix of the current resolution configuration
surface (xres/yres) with the new resolution configuration surface
(outputs[i].xres/yres).

Note - we use "xres" and "yres" (instead of, say, "width" and "height")
to match analogous virtio_gpu_base_conf.xres/yres.

Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: outputs[i].has_xres && outputs[i].has_yres
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: outputs[i].has_xres != outputs[i].has_yres
Behavior: error

Signed-off-by: Andrew Keesler <ankeesler@google.com>
---
 hw/display/virtio-gpu-base.c | 16 ++++++++++++++++
 qapi/virtio.json             | 13 +++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..4bd2311182 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -233,6 +233,22 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node && output_idx < g->conf.max_outputs;
+         output_idx++, node = node->next) {
+        if (node->value->has_xres != node->value->has_yres) {
+            error_setg(errp,
+                       "must set both outputs[%lu].xres and outputs[%lu].yres",
+                       output_idx, output_idx);
+            return false;
+        }
+        if (node->value->has_xres && node->value->has_yres) {
+            g->enabled_output_bitmask |= (1 << output_idx);
+            g->req_state[output_idx].width = node->value->xres;
+            g->req_state[output_idx].height = node->value->yres;
+        }
+    }
+
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
diff --git a/qapi/virtio.json b/qapi/virtio.json
index cd67c4f52e..09dd0e6d05 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -970,15 +970,24 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.
+# Describes configuration of a VirtIO GPU output.  If both @xres and
+# @yres are set, they take precedence over root virtio-gpu resolution
+# configuration and enable the corresponding output.  If none of @xres
+# and @yres are set, root virtio-gpu resolution configuration takes
+# precedence and only the first output is enabled.  Only setting one
+# of @xres or @yres is an error.
 #
 # @name: the name of the output
 #
+# @xres: horizontal resolution of the output in pixels (since 11.0)
+#
+# @yres: vertical resolution of the output in pixels (since 11.0)
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
 
 ##
 # @DummyVirtioForceArrays:
-- 
2.53.0.rc2.204.g2597b5adb4-goog


