Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37EDC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdzo-0006WW-V8; Fri, 17 Jul 2026 04:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wkdzk-0006W6-CI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:32:33 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wkdzi-000277-7M
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:32:32 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabfb70501so24553885ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784277148; x=1784881948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PLxR5/zdjkUO27N60gXOi9bDuitb3Ij55GO3qVURNp8=;
 b=B3GZoBiMQYcd5RbsKzf+NCSN+So5qCkoDNLFcwyM4sFwRD6YgTZlWlv+OUk3IGL9T3
 Wmm7cI+f6nVlF04JL7N97/X895JHCp8vq7d3SQWkGRfpYL1ZSsy7CeL63WmTr5iQODKm
 hNAWATHkebnr35mQM7npCYsc7QHwqm4gpz3FXSIJnlVfUY+qJwsHUr3NIXjlKtJxZOIP
 r4CM59zYwWF935kisBRlai0mTjfmpjl0U0ZsQq0pC0cwvdnhcS/4ZPgO9qT0Xcw3IOKL
 wTzvAnSGX09btHF4gY1asefqMy/z0o2f1KjUHFpnal6P5D8pXFCaJZeJSVpUWHmiQVhZ
 4igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784277148; x=1784881948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PLxR5/zdjkUO27N60gXOi9bDuitb3Ij55GO3qVURNp8=;
 b=s683Je6wZMJDlmndilLxWVEUHjfPwzOfLhQVK1C9tlNy+HOpfHMTJKSQmMLgVocIlt
 KWanty3tsEYxYDWRkL8ainQma6tUhV7T9mrLXwejb45lu6csvO4rkIJN+ShPmwcGxXs9
 CI8AhCQWRrtM31jKDt2Rgv3CzayOnC1z/vkw8tyYpo5wT8wEuB2V0sr3rgrtKOAKnLSc
 pdW4jKDGQz1ipdwURKJRRnPIgv7HVgaGYxk+DTomQiQEQN1shoxzAzyHbdd6oSg60tIA
 bg1t/TjuoT1pm9/xH2Omeu2HGDDtoPJXs9BOPOAgVAwQw4AAmhOnKhPPCctE8lnkTWIV
 PFLg==
X-Gm-Message-State: AOJu0YyTyiWgA3QQPddO2OdGm6btudu6OQnuIyXnIIRLSjpSACV0yFdz
 4OONawkEewe6FUiI6993UdNRv8T8n3+sDi0YCoLKX4N8OYgPByqxUrKjOmi+gHFjIQQolDtf
X-Gm-Gg: AfdE7cmi8sHKK5UCllVrMqsisx+DLlgYUy/GrS7Q0+JsvUBeYKrhRcimfwTGtjwEs54
 CrqolpfqehEMbq3yPrSctA1FD7J1Q7wtdzaPHBxa6ADeoGH6MvwpgG4R80IepWa1ww7Nfyc+bwU
 jFAUD+5eL62hgqpfaSl1jOjHUjZ/t7z9+Cu7RQ0nvtTy6LgANvw9Bt82UrnzZvNYjrZg0wqsiWO
 lIeilWyG4TdZauk6oKoNKGmONQXEPXwNb3q1EonnreFqqkXcJq8PsTrJPJz0Czqwc4KFe5HbqST
 NErUqh03B26BYpcu/BJMjOfu3qUzLDr6/oHbVDEaAHbMs6JEE+ojtsmXngjY94WiGMdwijHMiVO
 A5easHgtVS8W0bWPr2C56KiUg196uKNXhhc0ykaIzVA8vol+Rl3xVo6+5f54AaN9qhwUM0mhp/S
 MKBKmpnb9yJ6Gw71T4+msat8+UCp244cckfRlOQPnHHW3CvdqhIp4dYX/k1qIH/hckMudMvk/qh
 sqzlI59CYKuZ/Upj1qEDIvSgYnT
X-Received: by 2002:a05:6a00:190e:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-84c29305388mr1703593b3a.1.1784277148483; 
 Fri, 17 Jul 2026 01:32:28 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2af9e922sm584026b3a.54.2026.07.17.01.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:32:27 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-stable@nongnu.org,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH] virtio-gpu: fix NULL deref in rutabaga set_scanout
Date: Fri, 17 Jul 2026 16:32:08 +0800
Message-Id: <20260717083208.291036-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x04.google.com
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
(16), but does not check scanout_id < conf.max_outputs like the base
class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.

With the default max_outputs=1, virtio_gpu_base_device_realize only
initializes scanout[0].con. A guest submitting SET_SCANOUT with
scanout_id >= 1 takes the con=NULL path, and
qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
QEMU.

Add the same max_outputs check used by the base class and virgl backend.

Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
---
 hw/display/virtio-gpu-rutabaga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 6ff1263901..24386487ba 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -303,6 +303,14 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
     CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
+
+    if (ss.scanout_id >= vb->conf.max_outputs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
+                      __func__, ss.scanout_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
+        return;
+    }
+
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-- 
2.34.1


