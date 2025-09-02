Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA5CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 14:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRlg-0003Ao-SD; Tue, 02 Sep 2025 10:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gvu2aAkKCqEBOLFFTMFSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--ankeesler.bounces.google.com>)
 id 1utRlZ-000388-C7
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 10:13:45 -0400
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gvu2aAkKCqEBOLFFTMFSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--ankeesler.bounces.google.com>)
 id 1utRlH-0005LK-FE
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 10:13:44 -0400
Received: by mail-qv1-xf49.google.com with SMTP id
 6a1803df08f44-70dd6d255c4so135773806d6.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756822403; x=1757427203; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dHSCPE30znSY0wWG1dnzAUCDvKJoJRQ7QqhxUlGgzFo=;
 b=dcHMaliOyNba2g+yphuv2Zk/5z8QTucL0lYTGSnP462FYNzkOSNjdsPKBQJmSPLPBT
 9nSWo1ZIrCIjYxOgI5qYmdDmKW4Np0fvWATPqFKms0MBB/0Hb85FWhmpc08tIRC6G9iD
 Ppu5FY1IMa4C/fdHEbaXjJzgGHHqHBE3ZkPA/vcg/J0ZEWgWcgQU9Q8jSMjYsfIs1lc/
 qaGeXIigl2EKlHUQ3OeH8yCkowG4hM7P9rv+K/hTfh8etzF0yEw2j6ZKn8uUXM66m+dn
 4efXrtX+l5PHFKTmD+Ay3N1PgPjLY/9LL+6TpkxEhnzi91UognPBN6YDLmGzFgGi9IhZ
 W/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756822403; x=1757427203;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dHSCPE30znSY0wWG1dnzAUCDvKJoJRQ7QqhxUlGgzFo=;
 b=Vjnw+Gnj9ZRaDKOVVtu8fi6Hg+JXRTnzaXP3uCCBn0KzmvDeuyNfFVwzmZwX+FOdQD
 ZP7wnmWGUrct3ryrvLlV0sV8pa6XiDzyrcsaWLKldQrarcSjknDOhJxQ0+U6qU3j6voX
 SIoblM7Z5i3E+joNTruQqKbzIqstR+0e3gCUMMP4lpKGKuxYShkFhSuaqrTrB/O+gQgP
 1hll+cY/HOJSi5/t1wlyllTiTpcwh0sn9eB8Wgp1r/KZnHkbywApIsQUN3emEvaZ/ReN
 Ywpys0+2XriRO8fkYVlYo5TVzEwSLoGJqCdR+joU53Ah7T6oUh6zRZl2qSfTyXG00u0w
 iSmg==
X-Gm-Message-State: AOJu0YyIN3TFnZB9W5NWtJLAF83Hx3QYSyofXL45QLM+fmCu4wWSLAUp
 tTFT+4f5g4NEhQb7AOgh9JYt8DFOHLKOPzTxrYEyigAMC+jzYPgOY8Ir0ETvYbfgfDdJHCTsXz8
 gePh60NUgD8abThYU
X-Google-Smtp-Source: AGHT+IGhn452ukdULXAIbH1TYQFSAodQviu9A4SiU72IYKb64PF3kuaVaXxon8m247idQq6IR2bdFijVcon4FsA=
X-Received: from qkbef6.prod.google.com ([2002:a05:620a:8086:b0:7ff:c939:d59e])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1101:b0:4af:1fe7:2170 with SMTP id
 d75a77b69052e-4b31dcd3740mr112062291cf.39.1756822402879; 
 Tue, 02 Sep 2025 07:13:22 -0700 (PDT)
Date: Tue,  2 Sep 2025 14:13:12 +0000
In-Reply-To: <20250902141312.750525-1-ankeesler@google.com>
Mime-Version: 1.0
References: <20250902141312.750525-1-ankeesler@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250902141312.750525-2-ankeesler@google.com>
Subject: [PATCH v3 1/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f49;
 envelope-from=3gvu2aAkKCqEBOLFFTMFSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--ankeesler.bounces.google.com;
 helo=mail-qv1-xf49.google.com
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

Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
---
 hw/display/virtio-gpu-base.c | 10 ++++++++++
 qapi/virtio.json             | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..6adb5312a4 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node && output_idx < g->conf.max_outputs;
+         output_idx++, node = node->next) {
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
index 9d652fe4a8..9469c63e81 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -966,15 +966,21 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.
+# Describes configuration of a VirtIO GPU output. If both xres and
+# yres are set, they take precedence over root virtio-gpu
+# resolution configuration and enable the corresponding output.
 #
 # @name: the name of the output
 #
+# @xres: horizontal resolution of the output in pixels (since 10.2)
+#
+# @yres: vertical resolution of the output in pixels (since 10.2)
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
 
 ##
 # @DummyVirtioForceArrays:
-- 
2.51.0.338.gd7d06c2dae-goog


