Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E1D172AA
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkd-00067T-Uk; Sun, 01 Feb 2026 18:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkT-0005oL-5e
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkR-0000Mo-Hf
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so2552321f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988054; x=1770592854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJ2uWCeP8pV22XPIuG+XMR/jSRA5vjFNUShUwB++kLM=;
 b=er2DCJRB/Ua6iLzOdo2LsAKFi2BwJl+OkPbR5iZ/8ORrL7cawA3ikk2uyBGWp81+Mw
 uUwg+cWxeXTE7PKEeeIy8fJ1BavUmEkfXs5WMP5NlFTf/SnNJQ8ziPHKMGcwOIfUtz/9
 xFouWDzGvfBM8XlHiJxb7LVMmCGMJLDlpow0mh+HvqGYyngXtxpzavsGu7m5ETnIVzAg
 tFd9TTYIhM8vGXOUxnOHjAtfrOYdNNgRuKDwjB5ytkQcEfpgSbG9uPMYjbK/4iJiBHf0
 Ejo4VZR3ODANrI+1EMAL7ZSOQ+V1Qf2/almvhiIKuQfaej+xCxVJwNRCCf7yrkZ2UVfe
 ixMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988054; x=1770592854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJ2uWCeP8pV22XPIuG+XMR/jSRA5vjFNUShUwB++kLM=;
 b=vcMDq2um3oyEqdeFX6/o+diLKZtRgP5nYRrQy0uZDq9/d7pcCFow5r8QpYUydxOdqe
 L/gEGoZ8Oeh6rn0wzwxsFVfmr607X7/xwZzG3+vSPlGh7uecwwqcb0KIdngUqsBcHOb2
 UOjDn4Kkra4qcajAP8Hi4fejxr/1wpoMRI8mASoHTv1meOuWlTe4rsAkeLO45QIKyUfw
 2R1Cr93NVA2D7d1aC6cdnuhSd+14sgzmaKu44BfZSAb22VxRC4xav7zdZhlkguKRzM+m
 5SenAzr2tUxetzZjwRfYq1uoUmEUxiyNKyxrWveVIzHc8jFc3tSjLoeDkmkQ5BaA/sfi
 p/dQ==
X-Gm-Message-State: AOJu0YxVWbE8H7Lnv1Z3PgEYBKW3ZVcmRhiWRj6mwhjZUV1l/Q3izG2a
 2vcyAoQ2xgmOiRoh6fHlWRFXD/lGgsQoH5kZ4OYur0HFalVgH9/f4Sn5q7Wdeuu9yIIJdAhaHsl
 54bPESaQ=
X-Gm-Gg: AZuq6aKdD+nUXW2eltiAmsWOpzme/fQJUzci3nrXGMWuhu5tkAPuSHlA5dEQZtNj5bo
 +5vOsDx80Zgzg014g2uaP+yokSaOrDIGTJUP/47ym3FPy+D8ruSsdtAuraqQ5emfSTGIbRAnDW5
 oJID4n3jqQCkHJ23Hjq2fSnrk1MFz7//AuMi1NPBCEETUAiXjlc2fnXEkR7IrY60by3GfVe9lHE
 i26HG3JpPzDYBGMuCFT5WPTLOxXHCwPVUyN9dt37McUzMC32o6d98LdE+n2d4wm5zKVeelwHgro
 6Pi/ggNHk1XymYoLLde+0fR5lnZSBlditEsQYODGByn5uavg/ys2bBPOvJYTR/uZcdHQyHOkBN0
 u220cjqJHo7OVfVi/SKErwk4UzUevume+7mfaiDgaGqDExxWQWNd+alN+Ln7QZpHvm1vSTH0pX9
 pzUmKhsLKrI3PStK2Fd2dAKqEWxTyxEZcRhfBp4RtIgus+rsE4TZpo++0oaZc+
X-Received: by 2002:a05:6000:2910:b0:435:a673:bca1 with SMTP id
 ffacd0b85a97d-435f3a82586mr13923439f8f.27.1769988053694; 
 Sun, 01 Feb 2026 15:20:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm37559633f8f.6.2026.02.01.15.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 07/10] hw/virtio: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Mon,  2 Feb 2026 00:19:56 +0100
Message-ID: <20260201231959.88559-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d64ecc29a89..9c5563f9bec 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3243,15 +3243,14 @@ static bool virtio_access_is_big_endian(const VirtIODevice *vdev)
     if (target_is_legacy_virtio_biendian()) {
         return virtio_is_big_endian(vdev);
     }
-#if TARGET_BIG_ENDIAN
+    if (!target_big_endian()) {
+        return false;
+    }
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
         return false;
     }
     return true;
-#else
-    return false;
-#endif
 }
 
 void virtio_reset(VirtIODevice *vdev)
-- 
2.52.0


