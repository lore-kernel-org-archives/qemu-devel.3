Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4597C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qr0-0005Cj-AH; Sat, 19 Sep 2026 04:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqy-0005BO-5E
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:24 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0007Hy-EM
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:23 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so7230785e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808117; x=1790412917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0GWHmPabWSPLaPy4afNz6W8nfAlTeFytEjlJU9wAePc=;
 b=eEPupRjcl6exAu4Ea6nbFCZ8Wyv5HuNIKLgAx/ElYRDOuLf7Q7y5slG1YVQ1SRPybw
 KInvvQi4o1N8I2oKE2GbGRqL72rYHY+6k0KEp7GDRNQqSzm7YrpUJpXqN7L2YFvXO3dE
 +HDEAhxQtVDtvhxc003bqsNvXV/SUaeKNRIIjgEbGijfteR01bi6ezEvUFsGNFNVExcT
 aLLF7/ax6mL8/vROq58sAyfpmEqYZ+4p6r+NxHV2nI8jIwAHlLKtqyZpNtyk/SY7ynsb
 sAEu2HxFK08lzOMXwRm5t+VaiFUOXUon0axVsW07L2xCRIk199VldSyBPoMeoJbnJMih
 eXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808117; x=1790412917;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0GWHmPabWSPLaPy4afNz6W8nfAlTeFytEjlJU9wAePc=;
 b=HlOAgSewEZ8Fiw1PcmWpdgqg8FPVfc8h37uS9w1NzjsAGa/nd+sVTNC1BlCmxN6FmF
 N7ey085ClOXx425G0UzhmAlWLUyoLiyoeXTrHc5UuvYKxFiv4zFOFhfA2vH9SAHh2XvI
 rziHHrPk+q5k4tfmXcnPzch+Pwm4+7D4XibIYRDxjkwrAD2wgC32VcpJnOQSyh+DSYpv
 ow5gBTDLOtPug9s5iugkGcdMviPHQQRAapxpa56SD5qUiIPt8yAq5ZRMfBWppDpHtZ4L
 O/IOBjgbB8pdWY3t9fLgc/+EnLFDRsZFSS543eUxKDjIrNY9qpbjT7p+baTLWyYr2w8z
 mF/A==
X-Gm-Message-State: AFuF++m9I4B0P9PllTwKAnvjxqi25KKiSQfum1GpP8u1Kd9uljtKOpc+
 W0qlD2hyS3RSJCD1wHKd9ZHpORlyAJQrfeIATqs6REM1DN+PfR7GCQXHe4g1CrUI+iJmT6NchFh
 uuXauGKA=
X-Gm-Gg: AYBFou0RQYALmYgnt0BINhKeYs3DKF8k9oszCNUZFgP/EnTQZtnhM+/sfGDHSOZLW+s
 CwxbWIWa74tctPleayNZ0+bIGPL+PXj2+EhYOYhlezdyCZo5MEZJzv5TShP9rBG3S/UJlZwg32M
 qf3MGSfOjmMhT6z18nz2lhGNWK20jMT3b5Gy57QRT96BBFDW0pZ7p7XXlqXEzgnlOCWmZz6IYhW
 XGNS5lby0cEc0oyGg5cNEy5UF5vuOIvNTkuXl77NRymPRupWK01Gax8IrfpBnXAfX9ThE+LP2Sv
 xyqiJDpFD6ZfB8RuJq0XwswzjmSZ4GD8ShV7dSvPzOWn5HEt9EUP9f0a1mApbANpCvM4MxJ+Osb
 Xnt+GSsM1r88m2wbc04wDRYWCcZdsqPRYn/itugbK5L92bgIxglJ27LDzNDmMcWRtV7Y/Le+AuS
 oGCfc9frIkOWxEthgs0QaE1/v2yysQ29/yEylpBFJdAcBddOUyBmod9J3oneciWZ9bpkrYqxOI8
 H3RyrqD9j6An01gNe7irbyuHlwVAlsXuoYo2S0jk86VT/g8hgjB13e2jzoIWvi5kejJqNsGVzV7
 tNp7ybx/nD/9Gx6lt7CtDJYCXxd4HK2H7DF18uZpQUNIBS++uVURDaXwWPvUPYqcvpVG0+E1tKv
 TtlXQJjyzgQDigrTPqWR8y3oDQc8I4O9I5g==
X-Received: by 2002:a05:600c:3547:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49fc574121dmr56028075e9.18.1789808116533; 
 Sat, 19 Sep 2026 01:55:16 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:16 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL v2 05/10] hw/audio/virtio-sound: free all stream buffers on
 reset
Date: Sat, 19 Sep 2026 11:54:52 +0300
Message-ID: <20260919085510.3388454-6-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
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


