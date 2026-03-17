Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA577FEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z2N-00011b-Fc; Tue, 17 Mar 2026 14:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2K-00010o-2G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:00 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2H-0002r6-TL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:20:59 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2c0c955a481so408830eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773771656; x=1774376456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1cs50hPDAwmrC0euzS8VUJtwzGSW5bsaYhh3jdDi+v8=;
 b=aa2RZfd5PNmw8HiLiI9hd6jwChJ1nrKINoH6wSOspJRrZR6EZ2Rqs433sAIto622Vu
 0QkjKo2UKVFhmYWZ4nuascmwdQ7D9zg2NU/978+RYwGv9WqT7q3JJKQH4Ox/i/X63zl6
 uW0hSr+A7tgLxldX1Orx7ACeNcMs1NSiktBbSPGlfnrdyFRRptQ2bd3PStpVbPA1RO3V
 cmxfejj4PR+weo67RMAp2feECAk2fO0UndGGEb7fx+2UzqOO7kyIP5JGpoHb65StPtbn
 id/CapHUNxKNAOrfUQ13QvE3ezDfVY606OM7ZlObXEWYRucR2S19PBfc4nr1ZtLO9/98
 jh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773771656; x=1774376456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cs50hPDAwmrC0euzS8VUJtwzGSW5bsaYhh3jdDi+v8=;
 b=VLeL4CXHMNxOHsBsduvs0oXHn1zljAYqHbLlyY3yxJFKTPVIOEVlUKxSm32oPDfECJ
 RirUHcRqNZ0Hd1FJwGpOSxR0cHobD7RF2yHhwm04J35VWH27UGPDDpILCeBq9mMwUVXL
 ZINXNzqcg1mHXAZaFVTP3YjSM7Wox8Us6nxo7sNRFjwdyJ6rLQ8CVA/x2rVMWXuJPaGh
 xmMD2dqu7uUjiHYFwU8OcxdSW6Y64EFdXVO7SZzHyrBZ7XBwAaCr8CPut1quVbm0Q4w3
 04UoS9mJdHOtj2AJNOillHkF07hWUa4EE0vfMcrsMgvJnpYZ0ugPEhgXDW5/KGbEiHjD
 RLcA==
X-Gm-Message-State: AOJu0Yzpm9/bqPyP71bF/K0gHn11e3QIpxRRYWr21aZusCL8kggs6/Sf
 M5NuHMDx4574FtLff/WgQbjPh18njLP6ntWDfWxfeVCZjLkTDzoAlmrVQ5FGUFCA
X-Gm-Gg: ATEYQzw7YNZAh9/K8kDr/CAbAmQdEZKU2SJ+1Rkf9I2xkt62X4uo+KcWxk2J382JyaS
 qR3YUj8yTLCePCaMYoVOPJbERw4VdqrQhd0gQ1oRlkLVgPrI7oQvy4uNtJ5biiGVeP/7CtUIq6H
 /uyYEuGrBFEmJm/Ffz4KkkxhEenI4YY7bU/dCXiYoac6pq/zutwZesnmI6m8Bv/pcHt1g3eIBSd
 2Hb9wb0Dh9sy1Nm/hQPaWSoWCR17mKfESMMUDSz5StdXMukk/WjVN5tz0AX/BRK3ITdR3k0+xp5
 HZ6PUoOEB1yKkNb6+yuJe2973aSDVMOAZFoIKHZJyoU2IvDZBjpBI+GkZ1Xa0jpsPVLCDQRu6B6
 7YObes8XO/fcao0WS/tt0g/v9C3qneLIxg0ceepqlrJovK7ZyM1KQR6EMoSSi7JlDIjsC2M9gC6
 QlBx9nH/l95VKRgp41aHt61Tmvq8xbvLnhf2x+gThEkbrWbtt2uFRl
X-Received: by 2002:a05:7301:1285:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c0e5008008mr228514eec.5.1773771655950; 
 Tue, 17 Mar 2026 11:20:55 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55a53fcsm457367eec.24.2026.03.17.11.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 11:20:55 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, visitorckw@gmail.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL display
Date: Tue, 17 Mar 2026 15:20:45 -0300
Message-ID: <20260317182049.33848-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1333.google.com
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

Decouple Venus from CONFIG_OPENGL so it works on hosts with no GL
display (e.g. macOS with MoltenVK). 2D display commands fall back to
pixman; 3D/Vulkan goes through the render server as usual.

v4 -> v5:
  - Reorder patches: move header definitions (patch 2) before
    Venus decouple (patch 3) to fix bisect breakage (Kuan-Wei Chiu)

v3 -> v4:
  - Rebased onto current master (conflict resolved in virtio-gpu.c
    with new upstream drm feature check)
  - Split Linux header changes into dedicated patch (checkpatch)
  - Fix line-over-80 warnings
  - Resent as new top-level thread (Alex Bennée)

v2 -> v3:
  - Rebased onto current master
  - Fixed line-over-80 warnings

v1 -> v2:
  - Remove hvf_get_map_granule() safety check (moved to hvf-map-granule)
  - Extract GRAPHIC_FLAGS_VK into its own patch
  - Fold standard-headers addition into blob_alignment patch

Lucas Amaral (4):
  ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
  virtio-gpu: add VIRTIO_GPU_F_BLOB_ALIGNMENT header definitions
  virtio-gpu: decouple Venus from CONFIG_OPENGL
  virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT

 hw/display/meson.build                      |  8 +-
 hw/display/virtio-gpu-base.c                | 15 +++-
 hw/display/virtio-gpu-gl.c                  |  6 +-
 hw/display/virtio-gpu-virgl.c               | 85 ++++++++++++++++++---
 hw/display/virtio-gpu.c                     |  8 ++
 include/standard-headers/linux/virtio_gpu.h |  6 ++
 include/ui/console.h                        |  2 +
 ui/console.c                                |  7 ++
 8 files changed, 121 insertions(+), 16 deletions(-)

-- 
2.52.0


