Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737CACD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1c-0005kQ-UK; Wed, 10 Apr 2024 05:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1J-0005iR-RP
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1I-0005XX-9v
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:29 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a51abd0d7c2so685373066b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740404; x=1713345204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjsuSCcLyjpkQOiK5wnHTdf6ojU2i1M+lbXXnXeIWDo=;
 b=pBK7reAoK4GVpnPUAIwz53JETgFfJSUTV4yRpbHGKDk5vF2OAZMmBipa2brUgaB582
 SDp9xHccX3QTDmbocoO5k6u4vgGUxvLQojGlJfCFyDAK78Na0JTlPBd1LXzM4Dq9bjhH
 0K7BvxB+5K3oHoq1Ca+lSEY7sj3U1ohgi1a5GseRWZWea1zAZsVnZtMgvYeFMcbF8cp+
 9EHTJzLGjJgXVwQCtNugGOh1NwdxZDXFE6rRq8TLTyjHOzqmDe3c19eXGPC29+790hqA
 aWfS1Tq+By2vl3cy4r35KZ28Af5qH5wkYuFFTLFfxBCtqjeqZcQCIx5mWgoEFYt3ijjT
 V9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740404; x=1713345204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KjsuSCcLyjpkQOiK5wnHTdf6ojU2i1M+lbXXnXeIWDo=;
 b=q1X9t8MiSJf6WUHUkL0QzjP/kP3Kd7+juRFHcBwEOvz6I7KNSuMr+ZR0VkO/Lr2/mJ
 tLACh+xFlolYsNbdqGRudfxPf/6/i7WtWg3gQkK7hc0N1DxuNnZpEtMEqQ4HBznEYhHG
 8UonOegfGX9KfuXNRKYs/c4U/336h+P4OUbDqoXOGAi8N2QDP2Z18RvHngf31Q7fDPVw
 xADks+N1iJkjYJASdBpSQh9WF7NaLiWS85BAZ8FcpaU82LQCzt6aD9KZ2hzTM6znz8eD
 /OhT2Wl05TzeKMFOBZSYRJCwb4dLC73ApcNMxWxTC+w1zimIvhNmg4L7UR8rWTN8qEys
 rOJQ==
X-Gm-Message-State: AOJu0YxBfqDuHa/E64U9braCc/hAY1dPxZPaEbpm4TesEVj9tFdaw6Ck
 qg6C6i7HyOjTIYxEPP7woiAOALZqMmWJLtO1H9jMjhpUlRPE9jdXeNoldgpnIQfNOFRxcUeaSZh
 2
X-Google-Smtp-Source: AGHT+IGiKS6lHvcUT0nXL6iQQWNv5ouo3y11K1PuCDyhXX9Jb3v0Gr7ABnYO8lpNd/0yf5EAPCRp3Q==
X-Received: by 2002:a17:906:dc8f:b0:a51:c975:f02a with SMTP id
 cs15-20020a170906dc8f00b00a51c975f02amr1377951ejc.65.1712740404712; 
 Wed, 10 Apr 2024 02:13:24 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170907272300b00a518a133d77sm6858396ejl.144.2024.04.10.02.13.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 01/16] hw/virtio: Introduce virtio_bh_new_guarded() helper
Date: Wed, 10 Apr 2024 11:13:00 +0200
Message-ID: <20240410091315.57241-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce virtio_bh_new_guarded(), similar to qemu_bh_new_guarded()
but using the transport memory guard, instead of the device one
(there can only be one virtio device per virtio bus).

Inspired-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240409105537.18308-2-philmd@linaro.org>
---
 include/hw/virtio/virtio.h |  7 +++++++
 hw/virtio/virtio.c         | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..7d5ffdc145 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -22,6 +22,7 @@
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
 #include "qom/object.h"
+#include "block/aio.h"
 
 /*
  * A guest should never accept this. It implies negotiation is broken
@@ -508,4 +509,10 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
 bool virtio_legacy_allowed(VirtIODevice *vdev);
 bool virtio_legacy_check_disabled(VirtIODevice *vdev);
 
+QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name);
+#define virtio_bh_new_guarded(dev, cb, opaque) \
+    virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
+
 #endif
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c5bedca848..871674f9be 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4145,3 +4145,13 @@ static void virtio_register_types(void)
 }
 
 type_init(virtio_register_types)
+
+QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name)
+{
+    DeviceState *transport = qdev_get_parent_bus(dev)->parent;
+
+    return qemu_bh_new_full(cb, opaque, name,
+                            &transport->mem_reentrancy_guard);
+}
-- 
2.41.0


