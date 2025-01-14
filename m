Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A028E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXlYk-00024B-0i; Tue, 14 Jan 2025 13:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXlYh-00023a-HY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:22:35 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXlYf-0004EF-GM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:22:35 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d88c355e0dso10253372a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736878951; x=1737483751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CR1XGoy+jnTDPy+e7vBvP4TFgYYpfs9zsMnWBCntSHI=;
 b=l9jj5UcIv1mmw3fqzvMIwlR2JLrrNmjHUxiDku9Kh6ha1gAUO+xofkBAIRJNdHPZb6
 HEIMLj5+mnykAlH+3JueZDkEUJpMhS6qGjZygrrmeTdcoPEBRFUqRR0VOnFrTUVU8k0c
 B37J3E31Bh9h6i85iMNGYKxT3QaaFDrO8mGHXvLrvitknbm1qQhOW0zBrdnRuZs2I0jq
 rtnWJeydGTErU2Xh/JIOdgCly7XOKPdKP8U1cyjWVQTq9guiqh0IUPOwD8ZQQXQQe7rG
 Z15U5uppNuDKQqvlJiTWz/M4QW3Ml4KKlwLCMnAUejiAdWiD5rkW6qgVCDxPVlZteDNY
 ZeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736878951; x=1737483751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CR1XGoy+jnTDPy+e7vBvP4TFgYYpfs9zsMnWBCntSHI=;
 b=echL0Xe0BcNvnN1PPVWBAhozI3xxZ9r5GUvFzxGIruUy4ABk1aXbD9jD6dBkbvU944
 1shpMSiODrqYwNQhvV+FbBa+7Bi2LHAxHiqNIg7qBA0N3pyK2Bgu3cbpY7SRr5T4wVn/
 lrBQzIrHpOeQVX2h7fvL3/mY7CDuHw7yyD/XLcjfm15Dm2W6CQn2cwMwZ2QSO12lBiAQ
 GE9h6Umw37tvkYyhVmSiQEsGkZuDRKdXMA84HdQaoBejxSyXN/0iHlnMwVOROsayj2Xj
 MdmE6juBmXxwBLi7SRvw3sLBMrBrtei5UPsY5xF96mGtMOGfw3tIQ15QVZI7Zw+7mcEr
 3APQ==
X-Gm-Message-State: AOJu0YwtRU54WE+XO4UVfBPIosHqeKE0pvYrJpXbqZK8QNRgMPBu8Z16
 PwFtUAk+jL07kfWvVy99tTwBXxolm0rYW2rFBoMb1YEwhVfFrLcgpRQvTdPtDno=
X-Gm-Gg: ASbGnctqWht4c0o69UxWpNMCeoGmYdRxvT93BH+uBIiIPoUiOx7zlR571t79Fp8ReBr
 tkUoDGjEnGu3CkOeoDmFPbic2wEvSKJqcyRNh4DASwXMcLo4tx3kztDe4zk4xfLnijgoAeD6g+l
 f84Vs12dcYcemQYinEz3COuc5siPmlRR0X5qVIdkyDdfvN8rGDtj8un4GmuzfPIOD2ZtBlFHKo8
 iUAc9SWoBy8wug3KQwltWK0zDeodinZ7lItodvpRZaBr7sQfTwSiPs=
X-Google-Smtp-Source: AGHT+IGYEoRooCUj/I7OqTAB4tkpR4/BiIHodysVPtpjS1ropHeFD/Vbagw5TFzw3quqt/t3CcU8Rg==
X-Received: by 2002:a17:907:8004:b0:ab2:b72e:cf44 with SMTP id
 a640c23a62f3a-ab2b72efaabmr1820765866b.2.1736878951101; 
 Tue, 14 Jan 2025 10:22:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905f0b3sm655625666b.21.2025.01.14.10.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 10:22:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBE9B5F89C;
 Tue, 14 Jan 2025 18:22:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Subject: [RFC PATCH] docs/system: expand the virtio-gpu documentation
Date: Tue, 14 Jan 2025 18:22:21 +0000
Message-Id: <20250114182221.840349-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

This attempts to tidy up the VirtIO GPU documentation to make the list
of requirements clearer. There are still a lot of moving parts and the
distros have some catching up to do before this is all handled
automatically.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Based-on: 20241110221838.2241356-1-dmitry.osipenko@collabora.com
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>

---
Dimitry, feel free to merge or adapt this incomplete RFC into v5
---
 docs/system/devices/virtio-gpu.rst | 89 ++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index f20c600163..6226fb732e 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -4,14 +4,91 @@
 virtio-gpu
 ==========
 
-This document explains the setup and usage of the virtio-gpu device.
-The virtio-gpu device paravirtualizes the GPU and display controller.
-
-Linux kernel support
---------------------
+The virtio-gpu device provides a GPU and display controller
+paravirtualized using VirtIO. It supports a number of different modes
+from simple 2D displays to fully accelerated 3D graphics.
+
+Dependencies
+............
+
+.. note::
+  GPU virtualisation is still an evolving field. Depending on the mode
+  you are running you may need to override distribution supplied
+  libraries with more recent versions or enable build options.
+
+Host requirements
+-----------------
+
+Depending on the mode there are a number of requirements the host must
+meet to be able to be able to support guests. For 3D acceleration QEMU
+must be able to access the hosts GPU and for the best performance be
+able to reliably share GPU memory with the guest.
+
+.. list-table:: Host Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Kernel
+    - Userspace
+  * - virtio-gpu
+    - framebuffer enabled
+    - GTK or SDL display
+  * - virtio-gpu-gl (OpenGL pass-through)
+    - GPU enabled
+    - libvirglrenderer (virgl support)
+  * - virtio-gpu-gl (rutabaga/gfxstream)
+    - GPU enabled
+    - aemu/rutabaga_gfx_ffi or vhost-user client with support
+  * - virtio-gpu-gl (Vulkan pass-through)
+    - Linux 6.13, CONFIG_UDMA
+    - libvirglrenderer (>= 1.1.0, venus support)
+  * - virtio-gpu-gl (Native Context)
+    - Linux 6.13, CONFIG_UDMA
+    - libvirglrenderer (master, possibly with patches)
+
+
+Guest requirements
+------------------
 
 virtio-gpu requires a guest Linux kernel built with the
-``CONFIG_DRM_VIRTIO_GPU`` option.
+``CONFIG_DRM_VIRTIO_GPU`` option. Otherwise for 3D accelerations you
+will need support from Mesa configured for whichever encapsulation you
+need.
+
+.. list-table:: Guest Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Min Mesa Version
+    - Mesa flags
+  * - virtio-gpu
+    - n/a
+    - n/a
+  * - virtio-gpu-gl (OpenGL pass-through)
+    - 20.3.0+
+    - -Dgallium-drivers=virgl
+  * - virtio-gpu-gl (rutabaga/gfxstream)
+    - 24.3.0+
+    - -Dvulkan-drivers=gfxstream
+  * - virtio-gpu-gl (Vulkan pass-through)
+    - 24.2+
+    - -Dvulkan-drivers=virtio
+  * - virtio-gpu-gl (Native Context/Freedreno)
+    - master
+    - ?
+  * - virtio-gpu-gl (Native Context/Intel)
+    - `mr29870`_
+    - -Dvulkan-drivers=iris -Dintel-virtio-experimental=true
+  * - virtio-gpu-gl (Native Context/AMD)
+    - `mr21658`_
+    - -Dvulkan-drivers=radeonsi
+
+.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
+.. _mr21658: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
+      
+Further information
+...................
+
 
 QEMU virtio-gpu variants
 ------------------------
-- 
2.39.5


