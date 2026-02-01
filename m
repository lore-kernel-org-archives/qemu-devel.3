Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D5D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgtR-0003vZ-Qw; Sun, 01 Feb 2026 18:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtQ-0003sY-0l
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtO-00038N-B3
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-480706554beso41880645e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988608; x=1770593408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jNtMN+TApjyuOmbux0fVfOi0ZSmxtuwv6TQan6eaBM=;
 b=JjnuRlNeMzJ23Ud7Tx1fAPBjOrYbAxQYfIZElNNf6/Nezk4I252f5MMBqLCx3DlZ6I
 szCFVxSffqfO4WYrNZSkkd5IN7kLTJ8n8pVsyeQ//CkFCKBzZRmDlthKTgCS3xySoQZ6
 4yGshYyd6eSU0XlmdIbwFEyjL43YgDxhFb5c4E/pbZZ1TEaS0mO3ycrPbGgJZr7Qz9z9
 /JIMerUTn4OTVTHd4z38R4/X7/WV5j7B7AFvQFmIff73gDg7RcVTuA1ZMXOxlH61XBQ9
 bkRhi1xsW03k1ZhZi3dXCR8FzdvTyA80R/mLhivUyYsBDsSaVq6HcHB6GZSpZzIFlGmN
 MYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988608; x=1770593408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7jNtMN+TApjyuOmbux0fVfOi0ZSmxtuwv6TQan6eaBM=;
 b=e4zb+y7LeMzwgLzG4lvIpR8MQIK1iQsg+6gZiTE4JhEW6ddJ6etEjuK13Q1CruCjdq
 iRGe7oQZt56TAzC6I7hIzI4uC0Px3mfosN8R7F7Hd9RLoCM9QIXDrzroTCL7iSFkRufH
 BW2Ytli/vHIYnpyAYcs299PcCDK0QxG1A/Tl5RMbtMIb/9aVasdbQQt2gquvUMNdJWDl
 nvomDuzo1WgWKkTh6RUP2v8m0TGubz91JGmXKcXOfGzEcg2O+EJV6nwzkyl3Ju8oLWTn
 0wSmznfZwAD3jKqEB2JqmtWvluWYGf9Lb4L0uZEr+D0JTRc7HWuuVM8pSbd8Qssb4Vmk
 Rm1w==
X-Gm-Message-State: AOJu0YwawITxpFY+qXpvOu0U4lXCh4OdlW9EIOI0hvznMC9asDq3kMiO
 Hhz6KmszqyIpDHSMmsgYu0LdwySTW8Dbjbvyq2EBNEMoD8EUU+agURd/Vpbim3zPzrx04xts6Xy
 NkG3FXU8=
X-Gm-Gg: AZuq6aL9wBAki3WFRV0qR5oPfUxrtLXvfSIRfIHtA8lqNQiFY/ypsLYRyXN+7yj+7bJ
 WG1C7qfE47wqdQbEtt6PHIngUv6F5VgOwhwRxEz/9P8wJmcYTdQN6uKeDv7k6Ty66BWRfaw9Y0+
 ED898nls+QkUSDlTnmWMvIMJNdSHzkdxnooHC8Qar/V379FJoz56/ngob0m+BXUAE4zHS5fFn19
 z+Bhlmo1C5MKDh6lG8P/RnVa66SlrB5L5/ft6XSA8XI/2rH89kYHaxyVLv4EFzC9wGsBRTrm0Jm
 L01g8ZLH6348RNNpTETSHYynFxqMRB3vTtZl5YuuUAUinL37oF/oNsZpRefdAZ+oQgPjy4nQgWS
 wh+xvJ0GQUmKXuZC4Men2OshTA2Wcr0vN7zCVM/I11HMh8yTfLP2SKJMFXw4f4F1KXR6rwP9opu
 5wJZ/Vwe8640cSgcvcKQ2zvE251vyosBVUzEJru5xfdqF3LcnhfpcQTz8kbJFs
X-Received: by 2002:a5d:5f51:0:b0:435:add0:3d68 with SMTP id
 ffacd0b85a97d-435f3abb466mr13958872f8f.58.1769988608371; 
 Sun, 01 Feb 2026 15:30:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4757sm40860174f8f.5.2026.02.01.15.30.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 06/11] hw/virtio: Check target supports legacy
 bi-endianness at runtime
Date: Mon,  2 Feb 2026 00:29:18 +0100
Message-ID: <20260201232924.93399-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


