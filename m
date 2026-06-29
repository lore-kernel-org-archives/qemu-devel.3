Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E5C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we6mJ-0006mZ-SG; Mon, 29 Jun 2026 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6mG-0006mJ-Lb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:51:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6mF-0003UA-6I
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:51:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-473ba028d46so572236f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782719493; x=1783324293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Njy/KUAeCT5dqPMwEd8WT2wG4msi6kQNlvmNdodaki8=;
 b=H2W17ZFwUMT5nnUH3I0pvasOPDv81VKM1FIY48Idi392G1cOiSqjX84wYl7zihQLOk
 LIWe8K2LOfuzVWk7vTbNs8uWzTYREzlHePlxf2Ag4CqhphfKquuqelNYr5vS59umlGPr
 ZargqHw6EirlBrVP9YpCqacpX0Qo36dyuI2QXUflCQJee5dS28M30VmyR/YPOV6yKcfH
 AxwDQ4/STlzvqjznwU2gJUMY77Oppi4tJD69qB66FNX9ZOKpjdxIzv4EhCDt6UzlxLHB
 qsCwz564TgSssKFa0gFmZ2NAmzWl0Ysm6Chi1Rl6Y9Tua7N7KN6CVxTtx6ggGpZZ5I7h
 xVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719493; x=1783324293;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Njy/KUAeCT5dqPMwEd8WT2wG4msi6kQNlvmNdodaki8=;
 b=YbXw9eJ4wFKXXSzySaW1qMde43bY+B43aN0v73m0wU21grD1EvQr8lHa77IBpSlXaX
 l7noLLkqxw5YstirgXkv55HkaecVVqBaUV/VQqUKTBwJCzDDjB+xq0+kqUDMspFN2oOZ
 LOEM5RHMLxMzM8uf9Np1uju8c9NbS7r9Sj5xKTET+cKk1ao2WEsX/ScSK1N8+lGaavPG
 R1c7OF2HVP9OtCMwJjF3U+riFfgm5H6ExAT7HDnMw3e7BR0VpXqnvH/TT62KMFLWXVt9
 trOiL4U1Lzn22/GvNtNcolYVfenSC/203hqVdawCRJCPNTb7VWSTQXik5z6B1YvkuLtH
 ydkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLXMOOcJd1W6B4UqG3daqBXwiPTx+mEaS8Y/FGC+1lAnDDdtLe+bxccNBqtv1Gu/ljGLn/bDpG1M8M@nongnu.org
X-Gm-Message-State: AOJu0Yw5GK3SIIudGBfaMd/6betzYBekYMuSM1k7BFZeajkppDQxRbm0
 ln2Q5WSSwga/D8mOWEXizwMAoq01O628NV6Jm9tLKaXwYYFTOzJiCd9Q5pA6bHlcOQs=
X-Gm-Gg: AfdE7clioS2VOootK5toAUsLbbfbSZi9rKkBx4IJzCLpvcFk8JzDYythQXWilP6R8dr
 DVMk2wKio1zK2eM372jHYigCcmz7GTXuDoscYZF0Z1zXy6e3YxM8rPWy+ilKjaZG4mBPwOEVYUQ
 jBH4ioRBgrU+mFiXqEIZgYFU7zgzJ75dkLppdCaZ2q1mUrGWdO9uMmaIYFn2z0EctwT8vn2NgfM
 JvnbM6jzvhIKtLXp3LFveon5UjTnMs4qRRFirIH9va+wCvSYHidIVtrIR3NMkdEiX1UcBTXvnbS
 PfoWoF3kDv5pnp3/WSw2n5KRzcXf6yq6VLfSYz9U66q/wuY7zPFE4vOlZWAV9Cp8VBYZCu8DQ9o
 oovnoseu+EdVLQ+AbP4A+EWTStC7KPvrJDHS9vAILSRVtC2Mlo80AVTXZdA4Wb5Pc39qsOcmdlw
 kfUygkAzLxL0IEk6k+YkoUb03WoyRrKAFPNay3wTq50VIhpVNqnNHFDx2SjewMyntSjwxEMU0em
 j78pKwWsonKMOxYY6dU1CjmHqLdJHpTYkK+me/7bHu4K0KQ4ee5cwhq3DTQoWBpyQVw9Wn70x96
 IekoEUnCutOvGAg87kl6OFg=
X-Received: by 2002:a05:6000:40cd:b0:474:b9d1:3203 with SMTP id
 ffacd0b85a97d-474b9d133a8mr423941f8f.7.1782719493133; 
 Mon, 29 Jun 2026 00:51:33 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4734df60acesm10397869f8f.25.2026.06.29.00.51.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 00:51:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:50:57 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 3/9] hw/audio/virtio-sound: free all stream buffers on
 reset
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-4-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-4-alexander@mihalicyn.com>
Message-ID: <thdv5v.20y0dmolbxrdl@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>All remaining stream buffers in the stream queues must
>be freed after a reset. This is the initial state of the
>virtio-sound device.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: trivial variable rename s -> vsnd]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/audio/virtio-snd.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 859c2770195..8f4421ba844 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -1340,6 +1340,7 @@ static void virtio_snd_reset(VirtIODevice *vdev)
> {
>     VirtIOSound *vsnd = VIRTIO_SND(vdev);
>     virtio_snd_ctrl_command *cmd;
>+    uint32_t i;
> 
>     /*
>      * Sanity check that the invalid buffer message queue is emptied at the end
>@@ -1353,6 +1354,16 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>         QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
>         virtio_snd_ctrl_cmd_free(cmd);
>     }
>+
>+    for (i = 0; i < vsnd->snd_conf.streams; i++) {

Or:

+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {

Either way,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>+        VirtIOSoundPCMBuffer *buffer;
>+
>+        while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
>+            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>+            virtio_snd_pcm_buffer_free(buffer);
>+        }
>+    }
> }
> 
> static void virtio_snd_class_init(ObjectClass *klass, const void *data)
>-- 
>2.47.3
>

