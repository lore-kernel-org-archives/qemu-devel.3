Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB4ED26D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJ5a-0002lz-9w; Fri, 09 Jan 2026 15:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ymRhaQkKCmsJWTNNbUNaPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ankeesler.bounces.google.com>)
 id 1veJ5U-0002aO-Eb
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:28:02 -0500
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ymRhaQkKCmsJWTNNbUNaPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ankeesler.bounces.google.com>)
 id 1veJ5R-00031g-Og
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:28:00 -0500
Received: by mail-qk1-x74a.google.com with SMTP id
 af79cd13be357-8bb9f029f31so1172065285a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767990475; x=1768595275; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6Zy41q7LCAe3yk7dQbNsxacbjGwvdO71af/D33OSk4=;
 b=DMiWi1fJHGCl8jQjinTAQwxuk7e/lXTSoR1sMajp6eTBAtpHyfalNElMdrUCY2h6Xl
 nV0Lvq0dXdmh7iX1RXO8DzWpHbNE5l1X8rrGpl2zO4Fsb7pyILx6Dhp4ivQR/qFDdVzZ
 AbJCRcFEPK2j4b57W8aq2UAF0lFukMB5i8E78K80SotbzrxIOfYKe+NcZxJg6411LXAP
 esp8IZCHgnWzhLn1GKvVTZyYDDBGCF9mv5kbBcuno9FJp11i7cmAPuSKcOZuQoR6mMOI
 k9VrhxelDjv0vJrgu7Sxu1xzuVTYW52e/T/lZem4mrP75TjulOS+beosS30rAz6zLFb7
 oeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767990475; x=1768595275;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P6Zy41q7LCAe3yk7dQbNsxacbjGwvdO71af/D33OSk4=;
 b=nsQbqrHUO5EP//mutd4cZ+/W7U+XmtUTXDG3m2g2jCojvfp+gIQdWcoz5xD+GxG4Pf
 HmoxnwTElhdQhFcxByI7/HdnrGBVjR8U8VtAFpS+a4zDHOPnFmIsTxjbcRzIUNjlwpMj
 /RxPzGDY3kWYrT+CtkQszHGVCTVs21S8X7ODt0LcuUGkO1kAzoi7Dz0wFRan+7fNawTw
 KpHVcvM5ijL/8bF9b2P+c8Y/58O6/zwnDtJ7fiMW7QnHOvJF9Pv/9uyMQdRlQhFS/h5N
 eHlas/pSrWX+PUZIe9h6geuCEFWneT0uXR/GtD92rpW0lhpQvSjjftb9GwFrVmP2leGX
 z3Zw==
X-Gm-Message-State: AOJu0YwU1C4T9f8cm7UnOEflBmbivbHPau2WHFysE92Y5JpIarl7klvw
 SBzpzrsYGzRxQygQyIcVPh/hOV+Dq+Vt82eMajVrqh2KQ9789SWTS5grU3daUAXPNQGZCW49j/W
 XgeYeNzrleCIVnayI
X-Google-Smtp-Source: AGHT+IH4B3xbqN3Q5ICJCkOFWUHL9JFgmUwBKOe/jgxtySdgVP4l7UuN6VOlH+6lk1jpM9liWwHo575Mf6DM3gE=
X-Received: from qkaj6.prod.google.com ([2002:a05:620a:a46:b0:8c0:b24c:d2fc])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7115:b0:8b2:db27:425f with SMTP id
 af79cd13be357-8c3893dcc71mr1511445885a.58.1767990474887; 
 Fri, 09 Jan 2026 12:27:54 -0800 (PST)
Date: Fri,  9 Jan 2026 20:27:39 +0000
In-Reply-To: <20260109202740.362506-1-ankeesler@google.com>
Mime-Version: 1.0
References: <20260109202740.362506-1-ankeesler@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109202740.362506-2-ankeesler@google.com>
Subject: [PATCH v4 1/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::74a;
 envelope-from=3ymRhaQkKCmsJWTNNbUNaPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ankeesler.bounces.google.com;
 helo=mail-qk1-x74a.google.com
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

Signed-off-by: Andrew Keesler <ankeesler@google.com>
---
 hw/display/virtio-gpu-base.c | 10 ++++++++++
 qapi/virtio.json             | 13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index cd67c4f52e..c1a1fb4997 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -970,15 +970,24 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.
+# Describes configuration of a VirtIO GPU output.  If both @xres and
+# @yres are set, they take precedence over root virtio-gpu
+# resolution configuration and enable the corresponding output.  If
+# only one or none of @xres or @yres is set, root virtio-gpu
+# resolution configuration takes precedence and only the first output
+# is enabled.
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
2.52.0.457.g6b5491de43-goog


