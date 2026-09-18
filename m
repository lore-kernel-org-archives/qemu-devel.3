Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAC2C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7r-0005dK-8H; Fri, 18 Sep 2026 03:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7p-0005d0-0c
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:13 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7n-0007Cs-JK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:12 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so2512645e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716910; x=1790321710; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0GWHmPabWSPLaPy4afNz6W8nfAlTeFytEjlJU9wAePc=;
 b=CInoJ10zO1XvJWSFrHifFHxNfmPClk0A+wpnOSVYLnyBhQoVfO/r5d8ds9K/T+uCB4
 YIaeIUsjNkP+ohlPVWkzhmSdqIisSjbgiRNVIAh+YTnKbstCzsLSpq2J99nNOHikyu59
 0wzUR1opqX6kMu1+AJQYx33lXoi5s2UaulKAxAbPAwtN1PN4o67Q5gfZXkkO5hSXSdzJ
 G4ZqySACuKNBUmeXKsgwREiCEwzJql3AXWhRAEazmoRMG98ST55Mq5GKHZ6Z1Zkxpgsv
 xSf25mizx0tOCGvg3Ouv4tNx52xB8+SIBatuFuJyM/nEi6+clUNDDfE6oiI4Ps2mrxEa
 RKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716910; x=1790321710;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0GWHmPabWSPLaPy4afNz6W8nfAlTeFytEjlJU9wAePc=;
 b=ZX6aPzwlo9pUGhxLKLBwxDa8PAVVCknsYxZUjWP1mA5hEChyPQSiIVy5HmhFO9hdzk
 QSFqESM8SFX+XK4Uwd9SAsQjJs8RLg+rjfn6eX2ofOfZwPILMriFVHYMpeD5eT9x6I9i
 GGNPPo1Zz9AwicMS7y8b6j51+W0eV2B1ETKrslKGbiuVsc1KO8r/Ws7m9BmxYyubNuTY
 Mb2+mOQW6IhTsbO/Xw6xNx3DsgAoigcJ7H+kwMlk1ROZCBoYFUrnNQUlAZOXjTYe/enT
 P2lO4UwHbIz/Wz55hulF17pSfqhUeJeWkQuafOm+z9RncodC365y1MN0xDi1XQfCAB0u
 aR6A==
X-Gm-Message-State: AFuF++nezhWyjmh2T3HWz479d/CkWVzobrhsF1NaVtlsdwICGJpWyG1j
 UTzNt2HLAcC43SjjxBUln/bBONk1uSlILne3caihQV/OPaRx0zbY+Jw9lsas0mOwg4BeLj86uH6
 wWKKVMx4=
X-Gm-Gg: AYBFou0vHF8E2t32qwv58uH9L8VlEIRu5ybuNP8db5WOZaUkOg7BxReP5OQsF6PMiGI
 DdLjSrUCH0AZFtqjxSjfkmFbF7/M8gqWFdMRZDdu9PULi/rHA+pHz11hgPTqAP7Xpgqlf6EFvJf
 rq/tbfYhgxt40sqvD8WUdkUk1tRxF/SgIOU+WddoGhUQW8JGCeT4rTfU2bi4oMdcKILqD+ua2QR
 c0W59Q/nySQzdsIugdXNhGVmnOJAaizqhHiCBoByiDwaucLm5PMxUpHutp9s6D/LIL8WB6p26YG
 YH5wIbYHsHvkUf6oZj/iZDEgye7/oJyk8ULvlOyaC2NQwFRinEThOFDOkH9VdyeEHvpqp6MuUzv
 ym7Lzu3oE5PtUyaqHwvsB7eJbJj0Bjywl5sU6e9ZHFXI9daoP3vl4puwbcP/4sMsk8TOZbdDyOw
 rh/QUgEx6Eo1iUNymsV/BX0/foOmNJWAg9tynmQWCnLqPe1r7ANXtMLETESD7uGswsurjrzOZ6/
 5qSpTOiRBXz7N8+YEtMP0utbzdsipJBFuPa3sKsoJi5pl5KgRXuuv+I6YoFNEIoh7pn0EHHcl/2
 iJIja+qM0Abvu1+WR1fQUP3eHpwLsbF0w76PYRC91J+Z38DC6Inn9gKMM1VGtkXWCy4YRrQdalC
 Aj7x/nAj/IL/s5f3KPcJID5q8gIxuWAAq7w==
X-Received: by 2002:a05:600c:5020:b0:49d:726:cc9f with SMTP id
 5b1f17b1804b1-49fc56716f2mr38764935e9.5.1789716910149; 
 Fri, 18 Sep 2026 00:35:10 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:09 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 05/10] hw/audio/virtio-sound: free all stream buffers on reset
Date: Fri, 18 Sep 2026 10:34:48 +0300
Message-ID: <20260918073502.3265143-6-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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

From: Volker Rümelin <vr_qemu@t-online.de>

All remaining stream buffers in the stream queues must
be freed after a reset. This is the initial state of the
virtio-sound device.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial variable rename s -> vsnd]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260803081159.91981-6-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 84083be882..f9822fc609 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1364,6 +1364,16 @@ static void virtio_snd_reset(VirtIODevice *vdev)
         QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
         virtio_snd_ctrl_cmd_free(cmd);
     }
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+        VirtIOSoundPCMBuffer *buffer;
+
+        while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
+            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+            virtio_snd_pcm_buffer_free(buffer);
+        }
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
-- 
γαῖα πυρί μιχθήτω


