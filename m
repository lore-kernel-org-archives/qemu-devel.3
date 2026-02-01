Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAC9D172A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgsy-0003TN-35; Sun, 01 Feb 2026 18:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgsw-0003Qv-LZ
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:42 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgsv-0002Yc-B4
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43590777e22so2368907f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988579; x=1770593379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+h8fxES7OJzZ8FiNM/iLx0nwAq7x7TFBCRMWBp9kdf4=;
 b=HwRjuDdXMSYrK5iYbnqoMWPQIx0Gd/kXa7l1TTiDA+ict5lip8BZo1sGkmWeystFqD
 9nMKGXveyebuA1Ec7JZiwq4XCkTNp+ZdgK27jt9Z+/uXn7JVf9sIY1IJzwxN0bxtBEht
 o8RZ1wwmtZGQABH8/utp8IuAfT4cCuLAcMInwGc5GxQBe5ylBpCoSDvPyOdg3aqRR6uJ
 f5NwRUrCHcPfj9OIco6tAelPYxRdltMGOIgWCCkqpii4vsBEuIg66TdikASAmpgT5TnQ
 548/9rehHUsD6JDJ9Y83UQBMhIyncrPvk2jb+tdzy1ZMbfYXop/SOlufy/toWfcnjOQM
 LSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988579; x=1770593379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+h8fxES7OJzZ8FiNM/iLx0nwAq7x7TFBCRMWBp9kdf4=;
 b=VIxmGXpCOwafxcPRdRTUhPGL32E99jhe1pRdUSHOLvaDhwoTV5qdQCGQkiIOgHz42+
 W3227eekYBQI28MxSywZhrqooQfMFq3KIl0Ozo06O87AfPTXpxvj+y0oP97kjOPUQx41
 y/Yy1+QH5oEPz9McIBxtNkY8Ww78nHJrQUt0JvcguWY3zfBVB+8m8WHP1OUjzY/7jtg3
 AWZRGdRtBLghxrt/BCM33CS0PNZUKaHOMBm7tQOI9HF1y552Mt3iWhE/2RwVkhEzFynS
 GcOacop2qu5NTOvh04Ou9J1S17SABcGwni/6rV3Q6jbhyEkgfLlAaEQR6F+aDfhTXYo5
 1UcQ==
X-Gm-Message-State: AOJu0Yzvr5He3a9xC+WYPk8jo34L6wJgidhzXHhJPrK17qxYVMRE5IFi
 ahVLWDlruiCqMepCeeNAEbxcZTAVq0uGjmCYgg20zWaefurLcH5ulRRsoSwDSi7PV7yYPWYUNcg
 NbcQtN+Q=
X-Gm-Gg: AZuq6aIng0PendLTUEz8RNdjdLYBsQElm/3ufueDnu3LM9GDr8j/j+sspo5ALIak8t3
 pc/V16pMbet7640bP/KgYQRelxl0TA6Ab5uS7sFCzjsf/ims0NqMRuujbgvRCK2bPvyGH+tCrV7
 4KLAUdTKPou4qhbAK8REy9eDAtkpLEHxJXXNkjQC6+HVEZYZP1duX8WN4bBFpXrUNOdJ9TYtPVk
 Yz8YZUihbyTCaqLcHQV6GJgm6oHp7eb83WniG9Mi6tr3sqavtuMa+KQl2M3+ybIiv8mGB1Y94xc
 HPcS4vFc2LRJLU72KqA1AGL4QGT3LwlNfqINw0tNHmdRSHYuhj19ywjs3AQnIwd55s24P74Lc6s
 PM3oajSSYQgQ50onqPA6aogWHcnza4SwLc9Am5xNMetziSKPBexYvebvRoAafYEmlp5n0vMqhX/
 jnG9qnVT9u2AGfWDXlPCbzglQDRc8EX1jJqGh+Py/XdtF+FM3EEo3NtigSLcRG
X-Received: by 2002:a5d:5d13:0:b0:435:a160:4480 with SMTP id
 ffacd0b85a97d-435f3aa9270mr16179455f8f.29.1769988579445; 
 Sun, 01 Feb 2026 15:29:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm38436771f8f.8.2026.02.01.15.29.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:29:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 02/11] hw/virtio: Constify virtio_is_big_endian() argument
Date: Mon,  2 Feb 2026 00:29:14 +0100
Message-ID: <20260201232924.93399-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


