Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C126BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytAK-0001vc-03; Mon, 22 Apr 2024 08:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytAH-0001ly-Lh
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytAF-0006Um-Mz
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57217644ba1so206492a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790373; x=1714395173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hCHqhMxNEfKL+VNLDziQLRb3vVkMKAX1ZPlFQlO+/E=;
 b=e9LfsEo/hjd+LRGVFfjvxFIIVx5wMHtxT3vbTn4kXWCyuU+JbyrIkubsu3ZIe52qK2
 vNe0yK70DgbTROqoGxg6yIbnT1OyYQDiBITvhKk0nV0or3vQ7oTqXwSg9MTcEaLKROz9
 EWLkXYRrSYXttKcipZS7WPcmCSJf2M7G9lgh6Q2GRqNsMyCUjHRgF95dXaGnKysUx+QO
 oxwE98i1V1QzhBK0sx6TVTmgqBkp4UBJwNmxSzNeQwcMcjGJazW3lyx3Mrsh5QHv7RXS
 sbpRDDNmkzTXAbLNBaVpZtkrermYMzP/93VR3w+bTzuFEo2JPL2tPD3XRxlpKkxWaEkL
 nIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790373; x=1714395173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hCHqhMxNEfKL+VNLDziQLRb3vVkMKAX1ZPlFQlO+/E=;
 b=d2mjHjqlwl69WMi2HHcOrhFOZBEqb9mqQVIzi5bapEQnp59jcx8QcUsQqBgNU4bS/5
 7OWcAeW0GiMHmRmWwhix1EuVPx4MgdX4oKMsVw2o6q+wHsi/0gnVaOxmK29FyrW2N1BQ
 9MRHqonWvyR6WPc15z15iHblF2dJg2RecxIDuOiwWqmG7knsfmxFJwgcMHYppq7ykMnn
 rsI8lK8pkZAOANjQL1YJiEzn7RAxVKNB5a8ljJt1Mu1pfV2Jrpkdti4S5Y3sei0i/Pnx
 A3fzm1+igs3ZxaYk9h8zpH3s7Y90adN7qqvU4aZ6/J/k8XvVb6m9XCldp3zAUqLYKxbG
 hZUg==
X-Gm-Message-State: AOJu0YyKBprK6/LqM3qdOJXNlOB3JbX29SKIf4EgHQwddDjKVJyXKmBk
 5PLxtuZC40sf3CZN8qujyli3817nn5xWwfxLEMSh9hjuLWYLDYfJAaKa99u5cpFXRD155f2+tHq
 9
X-Google-Smtp-Source: AGHT+IFbCiXVIL1jL8GFULyYTFqB1od2FCqbxp4ISwMFew6KZuoSf3RKU9OJWwYD61uDny4DPpkG7w==
X-Received: by 2002:a17:906:1949:b0:a52:5925:1f76 with SMTP id
 b9-20020a170906194900b00a5259251f76mr5863700eje.47.1713790373264; 
 Mon, 22 Apr 2024 05:52:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a1709066b8a00b00a55bfb4e3b6sm593574ejr.217.2024.04.22.05.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:52:53 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 4/4] virtio_snd_set_config: validate and re-setup card
Date: Mon, 22 Apr 2024 15:52:14 +0300
Message-ID: <4556f526055b140d949189d78e7c46b261302373.1713789200.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Validate new configuration values and re-setup audio card.

Changing the number of streams via virtio_snd_set_config() did not
re-configure the audio card, leaving it in an invalid state. This can be
demonstrated by this heap buffer overflow:

```shell
cat << EOF | qemu-system-x86_64 -display none \
-machine accel=qtest -m 512M -machine q35 -device \
virtio-sound,audiodev=my_audiodev,streams=2 -audiodev \
alsa,id=my_audiodev -qtest stdio
outl 0xcf8 0x80001804
outw 0xcfc 0x06
outl 0xcf8 0x80001820
outl 0xcfc 0xe0008000
write 0xe0008016 0x1 0x03
write 0xe0008020 0x4 0x00901000
write 0xe0008028 0x4 0x00a01000
write 0xe000801c 0x1 0x01
write 0xe000a004 0x1 0x40
write 0x10c000 0x1 0x02
write 0x109001 0x1 0xc0
write 0x109002 0x1 0x10
write 0x109008 0x1 0x04
write 0x10a002 0x1 0x01
write 0xe000b00d 0x1 0x00
EOF
```

When built with `--enable-sanitizers`, QEMU prints this error:

  ERROR: AddressSanitizer: heap-buffer-overflow [..snip..] in
  virtio_snd_handle_rx_xfer().

Closes #2296.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Suggested-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a9cfaea046..d47af2ed69 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -36,7 +36,11 @@ static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
 static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
 static void virtio_snd_pcm_in_cb(void *data, int available);
+static bool virtio_snd_setup(VirtIOSound *vsnd, Error **errp);
+static void virtio_snd_unsetup(VirtIOSound *vsnd);
 static void virtio_snd_unrealize(DeviceState *dev);
+static bool virtio_snd_is_config_valid(virtio_snd_config snd_conf,
+                                       Error **errp);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -111,23 +115,26 @@ static void
 virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
-    const virtio_snd_config *sndconfig =
-        (const virtio_snd_config *)config;
+    virtio_snd_config new_value =
+        *(const virtio_snd_config *)config;
 
+    le32_to_cpus(&new_value.jacks);
+    le32_to_cpus(&new_value.streams);
+    le32_to_cpus(&new_value.chmaps);
 
-   trace_virtio_snd_set_config(vdev,
-                               s->snd_conf.jacks,
-                               sndconfig->jacks,
-                               s->snd_conf.streams,
-                               sndconfig->streams,
-                               s->snd_conf.chmaps,
-                               sndconfig->chmaps);
-
-    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
-    le32_to_cpus(&s->snd_conf.jacks);
-    le32_to_cpus(&s->snd_conf.streams);
-    le32_to_cpus(&s->snd_conf.chmaps);
+    trace_virtio_snd_set_config(vdev,
+                                s->snd_conf.jacks,
+                                new_value.jacks,
+                                s->snd_conf.streams,
+                                new_value.streams,
+                                s->snd_conf.chmaps,
+                                new_value.chmaps);
 
+    if (virtio_snd_is_config_valid(new_value, &error_warn)) {
+        virtio_snd_unsetup(s);
+        s->snd_conf = new_value;
+        virtio_snd_setup(s, &error_fatal);
+    }
 }
 
 static void
-- 
γαῖα πυρί μιχθήτω


