Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F6C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woofe-0007Rj-1s; Tue, 28 Jul 2026 16:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1woofa-0007Qk-CR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:44:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1woofY-0000yR-KD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:44:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso278146b3a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785271495; x=1785876295; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wvCFO13d/gX0SSOPI5qiEVi+rN+exkvgG4VdgT27TEw=;
 b=GI8AS2c9UEt1Geg9Ahk0yLC+6jd6t99r0dYT9AXNzpSjCRZFGoCwl9X9KVOzlDHfml
 ArdhbkXNtHGbfUbQxnqa8tuDfQx9v4c6rR8XZcmNnq9wWzSbYjwztEGo38JL/qf76dhk
 MQWhe5eK/+7EsCfo58x6zzPTKo21ioGIutAJMqhpOVO6RT4m965Wp+VzCnxwEK5eIPR/
 4dcdAu4G0cxUkA7p/BrZ4lTztD/+Sr5VjTWEAPT24sECbbSfCqHNWnxM1TfZnqsi/VjX
 m4+jMNryjBXV1VTjQX1bRuBNpgG6RvnFvMlNL/aEdTNoKIYVEsv2wS89Ts5nvJJCEPb0
 9aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785271495; x=1785876295;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wvCFO13d/gX0SSOPI5qiEVi+rN+exkvgG4VdgT27TEw=;
 b=rFBsx3VzfGr23LjXaUhRHAsYTQRzS9VssIfF3mpDX8zh4S6BnNHXH6JiveGDrsmJ+l
 bnjl1+Twz6hPVaPp+Qyj3+CNsTqrCqvlu1jd61yFe2Ae9BubwRWqDBrBEvUmI6+hpS4y
 krLfuguIEB1u0MALpTgAb6pY05e8StXPykNMCZEDj+aAmySUrA1v+4D5xZOHKvExcR5U
 WLPo7gHI4xknLd6f1Uy7+lQLYw2LeKhvjCzXtS+UhF+VccDaYmyKoloERAdrjFSDe0e0
 zweNkQTQnfNu2eRGEOeNNMF1kN+DzLpAk+yMJB5FckPt3Wi6LMEH1SKGQpHf18Xi2Ni3
 hNxw==
X-Gm-Message-State: AOJu0Yw0r0VL4dLqD3fFmYRxHcxv8sdXMvz+bCGaeINocoPgBxFKh3MC
 688AwTVNia/uwOqIIJEiwAX1XSKEf568qn81FiVNtbnlLjKh6Yc5Kwg4
X-Gm-Gg: AR+sD13b+hr4Gp34qIPx5dZwo1QtdcQvkwxln8bCudQgPui3EsHT2uDB6f4gdYSZ0u7
 IyVz5U4G3vj6/Xw0D7g283zL6wD3YuKABPeVlYBKje13TgmS6vraTeugWkmcHFvALkDC1TwcFrK
 ZEM2PeGipENAsC3nDzeJXpNMEYtegTTOjcinGH6lU9PQ2u4P+UrRMm6c+xM+1G1g85qbdF7GbWd
 EL37CUMshbZoJ/N/h3lsF/ReVExbDqjzplGS1XVqK3CSvkU+IPAWtqz08/yNMSU7157jwyLG4pr
 YhUWJuZ1ZFwcrToZoCvhNKp9IM3OZuLxHg4BUIGwd4ZOpnRK5ymmwP+gPFEaMZuDZ/uJnYdBMmL
 AngnKyzUhqbov/MvYRrDVZLKcIHgvBmf8YRGQPVQIKWEz2c+O8iHKHnNgSTEJpV272k8kippvkE
 ld12e6kumeG+VsetLom2mXLw==
X-Received: by 2002:a05:6a21:6492:b0:3c3:9aff:7a67 with SMTP id
 adf61e73a8af0-3c8ab0d85d1mr4571134637.17.1785271495019; 
 Tue, 28 Jul 2026 13:44:55 -0700 (PDT)
Received: from [127.0.1.1] ([49.43.137.199]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm1734366c88.1.2026.07.28.13.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 13:44:54 -0700 (PDT)
From: Ankur Saini <ankur98saini@gmail.com>
Date: Wed, 29 Jul 2026 02:14:24 +0530
Subject: [PATCH v2] virtio-gpu: reject requests with short/truncated
 control headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zi2IaCuvIdhMdKBTiLUTLHRE
 O5u5QIu30v++yskVuEEl2oF5SxJ4lzAHSroA80jo/jC4IxrTOtOmEUXiTg+X5hC1AUDk2fFum2
 IrCeuhxbK+qk8yHsv37rCQdIS9bMfZfuz/5vZokUa7JmMuVtj/HWcSB7HPk7Qbdv2BXneVAS+A
 AAA
X-Change-ID: 20260728-virtio-gpu-short-header-476aa1dae4f7
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Ankur Saini <ankur98saini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785271491; l=3552;
 i=ankur98saini@gmail.com; s=20260728; h=from:subject:message-id;
 bh=MM5LFpD2vK4p0vGwklanlLhmAWMaXRot2mtQBQ3akmU=;
 b=WN686dLBMhrl8pwHl7JUS85vT4SOBD6d0cp07WwGaXalHAdFV+nz6Zmnfhpk0o+EbBg6YDs5h
 tosn+5vWGx7C/jbqATTpH3xtd1fNgK2iw/smq/ET16HdXriHNEYuOOa
X-Developer-Key: i=ankur98saini@gmail.com; a=ed25519;
 pk=fiA1ENLrWfuTIKes9f/fn/hIbq1fqEHYxopa8LdM/8s=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ankur98saini@gmail.com; helo=mail-pf1-x42b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
partially initialized. If the supplied bytes set the fence flag, stale
fence metadata may later be returned to the guest.

The vhost-user-gpu backend has the same issue: it logs a short header
copy but continues to process the partially initialized command.

Validate the common header length before dispatch in both paths. Clear
cmd_hdr and complete malformed requests with ERR_INVALID_PARAMETER so
stale fields cannot reach the response.

Fixes: CVE-2026-18054
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
Reported-by: Ankur Saini <ankur98saini@gmail.com>
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
---
Changes in v2:
- Also reject short/truncated control headers in vhost-user-gpu.
- Expand the commit message to describe both affected paths.
- Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
 hw/display/virtio-gpu.c                 | 10 ++++++++--
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index bb41758e34..8149834745 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
         if (len != sizeof(cmd->cmd_hdr)) {
             g_warning("%s: command size incorrect %zu vs %zu\n",
                       __func__, len, sizeof(cmd->cmd_hdr));
-        }
-
-        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
-        g_debug("%d %s\n", cmd->cmd_hdr.type,
-                vg_cmd_to_string(cmd->cmd_hdr.type));
-
-        if (vg->virgl) {
-            vg_virgl_process_cmd(vg, cmd);
+            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
+            vg_ctrl_response_nodata(
+                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
         } else {
-            vg_process_cmd(vg, cmd);
+            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
+            g_debug("%d %s\n", cmd->cmd_hdr.type,
+                    vg_cmd_to_string(cmd->cmd_hdr.type));
+
+            if (vg->virgl) {
+                vg_virgl_process_cmd(vg, cmd);
+            } else {
+                vg_process_cmd(vg, cmd);
+            }
         }
 
         if (cmd->state != VG_CMD_STATE_FINISHED) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4d46a4eb10..15a845eff6 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
             break;
         }
 
-        /* process command */
-        vgc->process_cmd(g, cmd);
+        if (unlikely(iov_size(cmd->elem.out_sg, cmd->elem.out_num) <
+                     sizeof(cmd->cmd_hdr))) {
+            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
+            virtio_gpu_ctrl_response_nodata(
+                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
+        } else {
+            vgc->process_cmd(g, cmd);
+        }
 
         /* command suspended */
         if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {

---
base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7

Best regards,
-- 
Ankur Saini <ankur98saini@gmail.com>


