Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4919FCF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBOj-0001dA-US; Mon, 30 Sep 2024 04:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBOi-0001XZ-A1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:04:48 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBOg-00044R-Gc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:04:48 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fad15b3eeeso3659651fa.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683484; x=1728288284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=No3UNTdnI2PUra55xn+9Km9SFh7ve86YSqv3e3Ulz3I=;
 b=cGPdYwHRMNimol0TN8CzfspVViAIYwiGSabVLXFxGnD4btuGQQGohQukOcNkjmgvQQ
 253CwH0aWgoBikt8ApJaW9zFH8rg8nbtll7ESjOxUP0+9LaUk0kYueitgCjj0b4GJDQ5
 i9VFJLOgUtwl8EbeVwildaI1RHgWiiP0dm9cZoO9hkmvOIZ2uisbz6aD6gpuN0sYVMqy
 0BtMsdAwQE6AWIju+0fR4RKdaFud1FnmYzdwiXkwGOqvxTgpkDGM5p6YEDG2beDW89Eu
 Xc82v9Q14d/aBC3pRmKHUF0VCviJuUSIpBKx11isqElYoaJLQGtfJW4iRZa+UgFCiXLM
 IxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683484; x=1728288284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=No3UNTdnI2PUra55xn+9Km9SFh7ve86YSqv3e3Ulz3I=;
 b=hYk5IAzsllT3SPsrocYSWb8gmQxV90G7Ie0+OZ1fhcSCdK0v4EBLpArZrBFl4xmbMK
 Lr1BJ43ZJ2Ylel5zqmV90dzlGIcXMyXmuBwEJ/3QgRfOWBzEg2n7dOHw6d01k6nc7pJi
 9RsT7nNAI8RRKCRS9TFVYs2a/mRTjmDON03gj0BvZa5if0VopQBSjRDhPPlBaDQaB9JW
 M5uyr1Y+joAMpnIpw6B+xGzFynaUiXDMGEo+NBZn5XUNnJNOYVXxS+9yBAP8HIWJ5Aww
 Ysvo67ay7m3BQrU+IpyDpK3jvXmU9saGppWxX/FDc6TnV5YBDXegrJN4cTFX6S+PcXJE
 9qxA==
X-Gm-Message-State: AOJu0YzezijOssdQiF3TVwCONsPWX4oue2ap5ZioFqOlsRuokz0OJusr
 SAzT1WmEC5uTFCQTifKMA4/sEyIZILLHbXX+hrYZHC9obl5VhZX3nOxWtGtQpXx+nRuQHWXicFi
 wWlc=
X-Google-Smtp-Source: AGHT+IFRv3VLtyKO7mNdwt1H9m+lBB/oi2IabLTun7tIx7ArAk7aBJ8x8BS7GDBx16sOWJESKh3XrQ==
X-Received: by 2002:a05:600c:4f01:b0:42c:afea:2a10 with SMTP id
 5b1f17b1804b1-42f58441814mr91713325e9.21.1727681778254; 
 Mon, 30 Sep 2024 00:36:18 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a54dd4sm141894255e9.45.2024.09.30.00.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:36:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 10/13] hw/virtio/virtio-access: Use ld/st_endian_phys() API
Date: Mon, 30 Sep 2024 09:34:47 +0200
Message-ID: <20240930073450.33195-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Refactor to use the recently introduced ld/st_endian_phys() API.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index b920874be8..37a42407ea 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -43,30 +43,21 @@ static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
 {
     AddressSpace *dma_as = vdev->dma_as;
 
-    if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_phys(dma_as, pa);
-    }
-    return lduw_le_phys(dma_as, pa);
+    return lduw_endian_phys(virtio_access_is_big_endian(vdev), dma_as, pa);
 }
 
 static inline uint32_t virtio_ldl_phys(VirtIODevice *vdev, hwaddr pa)
 {
     AddressSpace *dma_as = vdev->dma_as;
 
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_phys(dma_as, pa);
-    }
-    return ldl_le_phys(dma_as, pa);
+    return ldl_endian_phys(virtio_access_is_big_endian(vdev), dma_as, pa);
 }
 
 static inline uint64_t virtio_ldq_phys(VirtIODevice *vdev, hwaddr pa)
 {
     AddressSpace *dma_as = vdev->dma_as;
 
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_phys(dma_as, pa);
-    }
-    return ldq_le_phys(dma_as, pa);
+    return ldq_endian_phys(virtio_access_is_big_endian(vdev), dma_as, pa);
 }
 
 static inline void virtio_stw_phys(VirtIODevice *vdev, hwaddr pa,
@@ -74,11 +65,7 @@ static inline void virtio_stw_phys(VirtIODevice *vdev, hwaddr pa,
 {
     AddressSpace *dma_as = vdev->dma_as;
 
-    if (virtio_access_is_big_endian(vdev)) {
-        stw_be_phys(dma_as, pa, value);
-    } else {
-        stw_le_phys(dma_as, pa, value);
-    }
+    stw_endian_phys(virtio_access_is_big_endian(vdev), dma_as, pa, value);
 }
 
 static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
@@ -86,11 +73,7 @@ static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
 {
     AddressSpace *dma_as = vdev->dma_as;
 
-    if (virtio_access_is_big_endian(vdev)) {
-        stl_be_phys(dma_as, pa, value);
-    } else {
-        stl_le_phys(dma_as, pa, value);
-    }
+    stl_endian_phys(virtio_access_is_big_endian(vdev), dma_as, pa, value);
 }
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
-- 
2.45.2


