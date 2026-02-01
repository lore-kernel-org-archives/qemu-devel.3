Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED5ED172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkM-0005bU-HK; Sun, 01 Feb 2026 18:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkL-0005b1-GW
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkK-0000Lj-0f
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so4023030f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988046; x=1770592846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jNtMN+TApjyuOmbux0fVfOi0ZSmxtuwv6TQan6eaBM=;
 b=Z76F5BBAecFWyTXAmgUrxkksB2n6hfrW7L5vtKVNtxSCOGFB0+6bSJY3+E/GQW0O7y
 R1MaSDv0XadnZl5UwsV1v/QMtsMo9uyaZx0Dt05uvSX+MnR9lFAcH2mG95HKY4FYrg1k
 KhbM18yWUfaolD7VCOqh+dNh4lPHgik/AhVPnzCvcTaBA5tTjA27ZeqthYreCSlrFrrR
 nTzl0+SvwA8GsMgDaX5lFGJQ7hmLmMApayt8DXIusD/wjMJDTtartDLbtlwNhFH4RBsU
 rN+2bBroDyhpBbUqoVtvmrr0G/Go2tsMmZFxjjkWltYRzy1UOYBKjhnwdiAM2xTjIaaj
 kPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988046; x=1770592846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7jNtMN+TApjyuOmbux0fVfOi0ZSmxtuwv6TQan6eaBM=;
 b=qS1rswHaSATS5LDmTeL0xf8AxX6Hfm5baoQYgT+qkqvluP7QdaopH3W6M83vg9JqzJ
 5g1sZoY49g9Q40/BiynL2XQ5d7Z0d2zR7Q0ALsbKTmZAo5YyVWzX4QYvFP4Bvq4hpG1C
 PfSTPebhoVa6nRjg3d8XdRssWeb8iA3zLXUFmsDK4Pa92urkeNVgj64dBYwYJLl54lks
 Mw1yJtl3fYjxfwbYES9m1U93aYKMm/SovKLcbF+brFAPd9/+ub8HEMhD6saoLUVSZQ5e
 Eq8bd7FL/b4241Ayvt64J7pfZjWykS8zPYjSPOyV5zlMP5gxBmU7MZhaobP2q4r9LYD5
 2Dgg==
X-Gm-Message-State: AOJu0YzvLtK1aeSQh4hMVFDFVNa3fBSiweKNLEt3IlIIZ/0BbE0FCeNX
 IDQut9i4syw8Y+2whO+uq2ZnqA5KC6PyYuacaRDghRFbMc6kBBjO88WsfqyBOgpfMJnlEiPz48D
 /sMowyt4=
X-Gm-Gg: AZuq6aL+PmD63pmhJeJwKKkEc3xRY8/CxEzTjAqLn1mMLNDmJBQAsa6sZ6eDPDswqHW
 KNLju7oEfxflPOsm0MR1KPHtM19pReLuXQQelU3rH2WMBcW3IXWEKoryERlEGrlf+AGS5jfqby0
 rrBggUyg8FbosBzvGPlLv6m0iqm4D+9yrM4gZVnBrJMPYvOY06qB9fmm7kcYTMe1Td3nFMs5w+K
 ZQ/WSc00I9i/IpqpJnK9uJY3YFyyK594+zYtRdGl5xhYW8O0v6Ziinjzn5LS1G0Gvf8wCiFcOf4
 7+HqaMcwce4DVCJMvbGgmiO8g/JxCUi+J+jQDfXJGYaC78kknf/VkpqPyOiXZ4zyJE5urkNwsLE
 L2yMHDKMkFGU5cCnOJE2j9f3855AAhuYZoHgOTNPl49PQoeVsOocp+BNR1GJHj/WUn+pwd7dQtZ
 g7qeKZJBJanscvNNgABwDRnn9+kFOyRofn5nmcJnPlEyHSJn8Z57nVfgEP/8oR
X-Received: by 2002:a05:6000:240f:b0:435:a9c9:159 with SMTP id
 ffacd0b85a97d-435f3a91f94mr14006534f8f.18.1769988046148; 
 Sun, 01 Feb 2026 15:20:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm39845445f8f.12.2026.02.01.15.20.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 06/10] hw/virtio: Check target supports legacy
 bi-endianness at runtime
Date: Mon,  2 Feb 2026 00:19:55 +0100
Message-ID: <20260201231959.88559-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Convert build-time check by a runtime one using the TargetInfo API.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 627a929b063..d64ecc29a89 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3233,15 +3233,17 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     return ret;
 }
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
+static bool target_is_legacy_virtio_biendian(void)
+{
+    return target_ppc64() || target_base_arm();
+}
 
 static bool virtio_access_is_big_endian(const VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
+    if (target_is_legacy_virtio_biendian()) {
+        return virtio_is_big_endian(vdev);
+    }
+#if TARGET_BIG_ENDIAN
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
         return false;
-- 
2.52.0


