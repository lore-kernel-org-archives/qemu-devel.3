Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B093CFED9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YXm-0004kC-0Q; Tue, 17 Mar 2026 13:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXk-0004ee-1h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:24 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXi-000789-Ii
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:23 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso5931970eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769761; x=1774374561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CVb13IlLEU7TKn2JosjxQ7mvXY+2jkay+xSWdWBH5Zk=;
 b=CD5syXUmjgfY3nZw627NU+SfoYPFDi0sZQ34rioV5HYU6dBBVdwLIiKtpn59uup5YB
 wewmGa3cXeJ/tvBT9cxzSx7RBT0Vt/JDZ7Wkk2ICfQQUVvtrKhaRuK0fKTh+aA1ESmSa
 5m8NLKe5l3fGa9hJrdImXRYPSKndnfwljS+aSch+WJHytRpSn2Cfi8TiJgw3G7YL705C
 G/h8ZS28ga4dZInbRMoht4bVneGJNej3f7FWA4rkGqbGQhjytxalhUZrAc04AATkbC5n
 y3z0PuROMBY4qZHEJr41vrmg7VAaXXUjG2DU19weVtLHUKWj3451MXJFzfuHdVm/OC+q
 f+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769761; x=1774374561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVb13IlLEU7TKn2JosjxQ7mvXY+2jkay+xSWdWBH5Zk=;
 b=dyt9wd6lfKd8W1BUJTAr10CxGjkTk7wqY0ZIpCqvHA617q1VyFSPJ4SHk4FZy35b0s
 trnLREnWOaGABoZrSK1okMTa71+nSpOLNtlTlVTIdJ91vLZ84l0l+jBUhiPZXL+lVSZt
 2hOe43O4yt2bZYaenUFy2vQjLuleUJMBaF2748rEihxgF2DXAtYx9Dfcq1Z/6SD+74GI
 FdN4F4UhhAjzPY9NO29tfEnPnlI/SXPIq5Ix+zrczWxJxgG4JfDII2L8AKuK4mG7E4xO
 D1SKpHiPaHt0yiArIoEN0ld+kwXORI/IZ1o12uuXwO+irtcAHP1HQhyK9iDvIDONKUYV
 2T/A==
X-Gm-Message-State: AOJu0YzACh/5mqHAw2tka71vFzvJL4kXhRpQrB2hRpMydOif/NKt+UHW
 3G8GL/93FaRPNyb9WMDtF76lrI0QcUxTvgn+TWVT3A6YdiTuPOy4eTdVoWqdOhqF
X-Gm-Gg: ATEYQzzR7lbwt1WKHE1/H2iL5dWuGcghGmy4K94BtsuCZ7QXEaZdW7ggtPwAXgRnDob
 ftzNHVv3cqSCWp6yZJSdRJiBKiXGKBrXJT8IBb6EW6590xovxu0U2iEdbEceShl++v3RHSkfVrp
 lsPFPE0O4esKEcnSONtaRzJb+y50vyjIFriN2tRFnKUdgSZJNa+xknf4tudkVNuzrcQ00daWCnk
 hKD5aCBTKztfrwceX5kVSs2/61drFdtRnQ7CNFk3sAOeb6bNbiVrNeMQckr8mkDY8i1BQ+bWrDk
 hJtRJ+Y/lQuykvtYErsVRzWQ5cHxhg8YuDD5VQfu4yTHfL62MqayFLlY5sglzGpKedwsW5kzr8G
 D0VZsttdAkm3MKbtBOpFEtrNXiGn+316kY65DXt6q85es2h2xcXitnXfr7emmkphgQIZdtknDZY
 WlzNGbVr1A+IHzykpsdZ8K0GIHnsxnpiJPyy9jVP3RjLv0I1go8x0JDy476d2SO7c=
X-Received: by 2002:a05:7301:168f:b0:2be:aa:9a4a with SMTP id
 5a478bee46e88-2c0e4e5c708mr167357eec.0.1773769760576; 
 Tue, 17 Mar 2026 10:49:20 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e536896csm282115eec.3.2026.03.17.10.49.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:49:20 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL display
Date: Tue, 17 Mar 2026 14:49:11 -0300
Message-ID: <20260317174915.31829-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132c.google.com
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
  virtio-gpu: decouple Venus from CONFIG_OPENGL
  virtio-gpu: add VIRTIO_GPU_F_BLOB_ALIGNMENT header definitions
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


