Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E292CDE002
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mt-0004Yu-R7; Fri, 26 Jun 2026 08:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mX-0004To-CL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mT-0002wA-Lj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46caaa805b2so567739f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477336; x=1783082136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vk22Jj3EifnDGUBBY5mcZdeXYuB5UW1kA8dVKyl8j9Y=;
 b=ejxJxfHwc0/vcNG3RKgZrduxqCxnH/EUJ7Fpryqr9xV7qPazP3T6MuPvp+9otHxzZK
 8ZyzcgGYRI0ucFZjlc2g9c/8KPlZl1sHvNeUs0lV0nLu/L7sct6TLk9R/zGpwSFDdM7a
 dle+69WfAU7iKUzl0Du4C7ePApMpxqVuC6240=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477336; x=1783082136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vk22Jj3EifnDGUBBY5mcZdeXYuB5UW1kA8dVKyl8j9Y=;
 b=cIvoqLcPnwjFOT7i3aSCoydOi+EVm6qA7XqL2Ka1oVDvpBelap3XcND6CZAGD/N3f3
 Zu5v/4A56SxQYJZ/U/E/+S/nkQSZwncOEuV7zawm980eEiz+Y/xil+HKjbzzYhte/3Xk
 m0GCOy56txdWSyt2Vq7/xRLRFKPpBP3RnTaiheB8DQqiBngZbzeLH0Au8PH/FFWK4Ypp
 dOwetMm9n6uTu1JhkosReHXYCzf+GOvr5CzYB3zZaiAbrQ22CO90cx1wYtqRm5Rqn+Ny
 JCLdBaO/Jz4GH48sGBZavhhKouFb0Z4J4zpZW++u2eU9oSMQ/K+sXKoqqu3oTwj/U6m8
 Cpuw==
X-Gm-Message-State: AOJu0YyzdKVEaq26n2UQU+SphE6LOsAFlkSUDFZVLaN4WkjIi6n5hSs5
 28v26e49/KskTCwrnCHw5Cj+2PKzC/DjKik3HWboXrV/GJT/PwPbpfcoLeKpOvac4nzRbe0HADz
 7imqM/qE=
X-Gm-Gg: AfdE7ckOZcZw79NHayRUV6aN9pynW8Ap/Rdk7oJBbDKA6tMZ0SLEHb4Tk6ojkJ/yCnU
 gpaOlmtoP6Fy4j1Mh5ObTZr78JPPTRPLycKJKqru1l5PzvnS+x5dsUVFv3rug1FpBreatBq2DqP
 jykbekNHZZht7279Do810B+LagTJOA9Y6rhHUMKTvXYPRF49LdPvCejAiGu8JZKIuW9bc0/nLLq
 xatIY4KuEs2HLi66F7hRiGeXeb5I9xUY1jGkTDwlHn1XkUjEztqd+hBqy77ETZpcptNTmBzlywx
 sx7cE0qyUn1AiKl+sGEkfUCFnK8gqHvkwt1dyJmdWd8Moy8A42ogwtDM4qNhyB14/HiaVqfCrLW
 nWTf3R0XjZ39AcSRWp9ROm5YIvcP58ddoNfX2LKALgaavK2lKDZ2zDzW+IMeJZtAjWmjFZXhyM2
 ttg2F3rGB6RxFxDIz3Ru3gpx51n0/xtRdeYhmpz2dBcmvqmbQy2eabwLUggPmNuL0kLNJ9/ic5N
 vJrB5WJxgy2
X-Received: by 2002:a05:6000:460f:b0:45e:eaed:afd2 with SMTP id
 ffacd0b85a97d-46dbc1bc950mr10686768f8f.0.1782477335972; 
 Fri, 26 Jun 2026 05:35:35 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:35 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 3/9] hw/audio/virtio-sound: free all stream buffers on reset
Date: Fri, 26 Jun 2026 14:35:25 +0200
Message-ID: <20260626123531.132078-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42f.google.com
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
---
 hw/audio/virtio-snd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 859c2770195..8f4421ba844 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1340,6 +1340,7 @@ static void virtio_snd_reset(VirtIODevice *vdev)
 {
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     virtio_snd_ctrl_command *cmd;
+    uint32_t i;
 
     /*
      * Sanity check that the invalid buffer message queue is emptied at the end
@@ -1353,6 +1354,16 @@ static void virtio_snd_reset(VirtIODevice *vdev)
         QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
         virtio_snd_ctrl_cmd_free(cmd);
     }
+
+    for (i = 0; i < vsnd->snd_conf.streams; i++) {
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
2.47.3


