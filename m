Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D50C44512
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 02:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlddG-0000Zw-QW; Sun, 19 Jul 2026 22:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wlddF-0000ZH-6x
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 22:21:25 -0400
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wlddD-0007js-KN
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 22:21:24 -0400
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7ef596c6so85438925ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 19:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784514082; x=1785118882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+sR1BstrE0XzA4vldixr4uehPXwa7g66LGt5Awaoh40=;
 b=SNsYeuzeLsA+aGbZsSkUIL1FI4yMTNTZP8nE3IOWbQiewXf3BYsmnGXRTYzDUv8duZ
 vlYE36hKJfwLWEXKa6dJuJue6uDXz6A9DhRwmygrhozqpCcOp9SDh8HP63BidQCb7J8h
 QFJvHL44cZ1b+uveQnRskTZAABMtWBd4lOuyv/QVHZL3tgQNhbpm/r+LAga0UCpt4Lc6
 pLfYFV1lG3PIMjd/grV2F3jLe81HGFQCKrS8fJypMXpFTU7Si+CNWXKrpUPaFubmVn8K
 /9I0FsPxONnq1SaHmWIPxIWsxJWw76msEqlBPGQYvJFMQotZVq276zN/QsT9VzVNxkCm
 3m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784514082; x=1785118882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+sR1BstrE0XzA4vldixr4uehPXwa7g66LGt5Awaoh40=;
 b=AtAbqYcPN5TuDksD7L8Yhm9bhe7ohil3oeCBGvRNBbQv0rprM0bv1oO5dS6bI/AEOm
 Oos7WiOQY92LgBcNdvSReeEnqXy3O8wEY3ugt62UToYpL2AgqVvvSsm5NXQGENYc0A2A
 z4n3lauCiE9ajt3FEjKmH1hBqJV9LO6jALiONvGNlzE/25aqi4viAKwKo+/jOUHXmutm
 XwInW3tktAyjzvkl0OX8V6xNCL7hIhqusVOGuz9bUTfhSDjBKJjCWVKfi2PgVC08E9NP
 2JkMi2JgF1xEkGEqb2aXov7U0JsJZkI5BZPXw3tvFjImFCAc3F3+cSiR8wnekaH/jcXl
 6LsQ==
X-Gm-Message-State: AOJu0Yz2g8+XWajAMBBj68B65tjnOTMuIyMTeJi5K7JMz6E4+QzjcN3i
 EtiyoKueidJ0729I9+U/v0xhHwe8zAHjl2tz49fn8kWGIzAc9qkaK+m0JVIFcYcEXIRD25YwpCU
 =
X-Gm-Gg: AfdE7clR1/pdP1V4M4jJ/8IxLiLMUCmVohZTF3CI+QoSbJv3ICBe4Su03WO5RQpXk9t
 cZ7szB2hMLLxIA5ZnYY/7b+6ayoAxaXXA2Q3ijqlIVrl0gAweXdOQ2JcL6d7N9woIqFlMtgk06n
 ALVB1ZXDYs1UYO+pos5X/s4v6nGrdeGaazD3knLCRlfutvL1qY1Kx4vRpD36+tbemIie7IeuBSe
 WCTl+bQFWBtDT+v5nqJJUr1+HU9vykMHPxIQ7Eh+mfICmpgDOx5cbQXkaP2p5VWLt5wPE9dLUfE
 PEHco/o8JqGxeDb0wzbv2MJ+R3JaaE5SKFHZFoKBRXios2ZZEq9VFMnRrFDO738S0V/ATp7tM1o
 OOtU3MT+A7vTlRaRxbhwV2JdG+owfOCiNXh33Tf+r+HIF1VRHgWzI0FSuu6enFaHfI5iohcac4S
 qagKrnnIL2LWK8IkYAbBVvGG1G6aFoGFET15I6NP/PSylgn4R9KUrocaBLUzlAbY0sCqEEEk4SX
 Oz/pdVlwjJwbCgNqkRoxypIIuF6ug==
X-Received: by 2002:a17:902:f642:b0:2cc:fa08:eebc with SMTP id
 d9443c01a7336-2cf34831b12mr132087195ad.1.1784514081488; 
 Sun, 19 Jul 2026 19:21:21 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.116.239.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3448db72sm48562055ad.1.2026.07.19.19.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 19:21:20 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-stable@nongnu.org,
 Haotian Jiang <sundayjiang@tencent.com>,
 Haotian Jiang of Tencent Security <jianghaotian.sunday@gmail.com>
Subject: [PATCH] virtio-gpu: fix NULL deref in rutabaga set_scanout
Date: Mon, 20 Jul 2026 10:21:00 +0800
Message-Id: <20260720022100.3700582-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x00.google.com
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

From: Haotian Jiang <sundayjiang@tencent.com>

rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
(16), but does not check scanout_id < conf.max_outputs like the base
class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.

With the default max_outputs=1, virtio_gpu_base_device_realize only
initializes scanout[0].con. A guest submitting SET_SCANOUT with
scanout_id >= 1 takes the con=NULL path, and
qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
QEMU.

Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
CHECK, since realization already ensures max_outputs <=
VIRTIO_GPU_MAX_SCANOUTS.

Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
---
 hw/display/virtio-gpu-rutabaga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 6ff1263901..3f78899442 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
-    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
+    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-- 
Changes v1 -> v2:
  - Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs per
    Akihiko Odaki's suggestion (simpler, no extra if block needed)

2.34.1


