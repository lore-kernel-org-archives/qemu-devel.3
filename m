Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7314BE65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgjv-000517-1N; Sun, 01 Feb 2026 18:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjt-00050q-6V
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:21 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjr-0000EH-LI
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so31963345e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988017; x=1770592817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+h8fxES7OJzZ8FiNM/iLx0nwAq7x7TFBCRMWBp9kdf4=;
 b=wXtIok5UOllOIcM1giKU+P/NE0M/XRxCKwMu134s5mBiJJ5BJJllRg3n4GubaIkCYS
 PuhQ4oVUaDzxPggALIezhgRy0XYs1lWuHOIvnooCLr9jXMml48JrdMVxBw++ZAZE42K+
 JQFud6Jx69kjXVTIwaZogomGhmv8BmE6lSektjMD20LD3FQt9GUj04DIEP3APANBYTgm
 KlQS5f1RjZSVVyBmJDCKTKeP3Ho9zLjQQmPEX+sWe9tH6NgXjndo7Zcv1sDZfRZojIXt
 D8Wdnz/jZp0Wvjh4Epbe2fv+IpHfUr2B/6OT0A53YQap3YqdsmyEEk3SdMcIzl8BSejM
 zPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988017; x=1770592817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+h8fxES7OJzZ8FiNM/iLx0nwAq7x7TFBCRMWBp9kdf4=;
 b=KLjtq6Dk6MBt2RMCzH8+HYFFXckFS/r6j2kqFiViCWP8NyfE4opIvoprsga7pIgWe0
 XmDI5pnFVIJmX3a1HkjQBu1oTGhvvuIHt7j5xhLX8j7asV8o2PTdhwUi04U2Ixoo5DMR
 OCzNU2bNEh2UZpCWg19a16mHTh9XHXghm2K6/WbMwMrpktxAGv/w05zYw+7PbPNgDqVp
 XS4pdLATPL1Z70RL8Q/ZKLTEZ+To1FeGxKWL0a/CQULPLH4Uppgh2NbLWlkEut403Dq/
 iLXo88VlRtbZ2+HlSRDkfYLp+4KLhucd7mYxpZPRsIpdJGy78UFf4mFe02QCv6pNPAyc
 zBSA==
X-Gm-Message-State: AOJu0YzukfKVZ4+FOiUEGfAmHteYu8zcIDSqVhSjLPkNQAo30QjA+g3u
 BgFCnXDd1dqmE/05SKs9MQJXwg+pX6hMEfYPR9A3j+coTLfiHGBOMEpJw6VoKCseTn3U8kgI+xZ
 2JZUl/nE=
X-Gm-Gg: AZuq6aLJTujVB189OiDoRIBMclvmyGbEixrDdtfQ6plyKFN3hcXJXOcSyNfkiiKmmV4
 4htzsAKoL0QRQEvEJ1AlQuK1/NpSAuRuhWYCnDWqxO3powGlgHHq/JTLPTFuJ9IEGLNyo4Wx2DA
 AGXvjFrsoomF4mPQPgu4oE3vXrnUVQDZZ2uLqhGFFMV3CBjPd7P8bThk+Fr+JtVwwWoWDWJ1OMg
 pkiJACBbNSsVNJHo08XPeQ+Ml9vHTlKgxXDVoGuS74Jn4I7sfLb5/AjZXr5e/VMOFs9C2e/oGv+
 zPGJINKgRZiADwnN83j2qcylgiN6niR2nraAyUkzxrhg4j4O9fCBAzU78rEm9my8tWFsjUtLXF7
 liY6EEnHXsRFs0HSCNTAH/IIi7etj7997DkiZmi9VUZ76oVLD8sKqeFgErpBOJ4FVArcoh/iWVy
 JbtcBVD8A4CT3744hW9N0PDVNbDJRjDUuyjmKvEbL82+asqWGry6LWJLGvyLY0ypuxRvv/EKA=
X-Received: by 2002:a05:600c:8b61:b0:477:b642:9dc9 with SMTP id
 5b1f17b1804b1-482db4866d7mr112879385e9.28.1769988017065; 
 Sun, 01 Feb 2026 15:20:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e297119bsm74342285e9.17.2026.02.01.15.20.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 02/10] hw/virtio: Constify virtio_is_big_endian() argument
Date: Mon,  2 Feb 2026 00:19:51 +0100
Message-ID: <20260201231959.88559-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

VirtIODevice argument is accessed read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index fcaa9b03b4a..17b105c146d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,7 +468,7 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
-static inline bool virtio_is_big_endian(VirtIODevice *vdev)
+static inline bool virtio_is_big_endian(const VirtIODevice *vdev)
 {
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-- 
2.52.0


