Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFADC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we6kh-0005qc-2l; Mon, 29 Jun 2026 03:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6kf-0005qT-Le
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:49:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6ke-0002je-0R
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:49:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493a613571eso9026665e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782719394; x=1783324194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BQPUNMqPGfhVgO0YBd130D1q88cK6D5Jjci8R7E/ex8=;
 b=JpJa5wHvDjYRqtmdffl0QSWfmIDnf3fopwSMZpNHKS6bwhRDulcWi2/zjnD05Nqt1D
 TN9RbgyWMb2TwSPPBIUa38UZW5bg5aG5jl6ZBPY3CE5OVITzIHs1JO8lmidixNKqQ0iG
 g2eHgIvR1Qv/8eWIyLQzJ70RnOe/HUCqEzGN5Znr4n6Ux2M79PB12dQpI8ZFPgKpjUwj
 VMJPUeSx7Me7U8yMqv9ikBs57tyyGB3u+CXXmnypWhOR4Piq7DVux7vD76QNepbfhq8z
 vvNVYB19l0PiHtuXgB6BSdg8wya409bvP7Zbd449vwOA6KRILZpIL/of8jA7y3Kgomht
 YzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719394; x=1783324194;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQPUNMqPGfhVgO0YBd130D1q88cK6D5Jjci8R7E/ex8=;
 b=rVa1ru0de7PIlt78HjmP8pT4KSvtI9oLPH0N7U9j58QdY3ucM533MHPD6ZYxK3/oSQ
 kqhs9xjhCjW2VPCzYLHQ/WbIL4I8eoI4F3l4oC9SjzdpZV9s2iGmMCmdMllEx6lZz9Pp
 R27ZNtIGRcENgWvCXHKYc9Ay9s37AaJLoGIcRO/Kz71ll5/d/Bk/LfziLZpKBk7b9ZRJ
 jws5kzYRHNGs1Rbbad09X/l9dJOyVrQvxZcpInFk54Jfwnu3orNbI+iBVwnmnMhqR309
 KeJm5X+cp2Qv2aBEwGK1QyDAVsPQrbO1vJwA2D1MblA7Fo999pxPxeWWCc5M4MmEotBV
 7AFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yIk5BLUN21JwqUnqH2Y4ospOm4bS0w+fG16B0U+6XsjTOLo5Drm1DVfL16+h2T79UPUT3nHl+laJH@nongnu.org
X-Gm-Message-State: AOJu0YyWsGKzvFZZ49rcX/BzddocLZLBOW80fu1z3NFWizWYOTaay/IY
 4lFm5nK5vY9LuLDBkz9bZ4vPGzlZc8yQrurYEE51doJAKer312Ccjh3gaJw0ktXoRlY=
X-Gm-Gg: AfdE7ckcY66Qt1tkAcSzUe7D2KfqNjV7sj0OL8qWKfB579oZ79N/wqzJMC478/3W8g+
 sjudMNboD2vvC17cRFESv1NM2Znbl+hid97U+7yCYeq0Z0G9Oe89+ri87z4kvGKjkgJRHV45sk0
 U+hri3xLIpQb8DSNUzcTEzhYhDGd0kJnCorxYPbW7odCJkq+KImKZNSY1zQymLOXrWnC/i7QRD2
 emOUmHI30zGvP2cVlwgNo/2nvhAelWpFDEEShrw4oj6gxLUq0fc76jr58Mv72PTo+J1kUuPkwRW
 tvENo/vz8nTd/sQKdA734zG/mrwKeI7mJYiIKOyAqQiavwRSB0GQO/p7CSGXSYB1VaFe7Uw5weY
 Nwa/XHDA5dEP6nQtFrBuLehOhDct2TlrZD8gR6iXj0Kvxpk8EzvaCqhguQd2It3rcmmV9s+Yu2a
 wiIAXjr2+UXG9mXjpaUhXFtSa5Tc+0pTiN52FpkosaBYaVSRaLpg1L9zmd8Cm3XvQyQL1zGM1Nk
 I+tzNmXMZEUTtbUzZU7WcdDUx+E6CBFrK8Bl41kpiSnd4XalTnUOJPQvsGOFiKUMz/i3VLmRvdG
 UJ0rAzE85JZLWNZn3XITTcvLtYlH2HyVtA==
X-Received: by 2002:a05:600c:a12:b0:492:5e22:ef18 with SMTP id
 5b1f17b1804b1-4926685a81emr268888415e9.9.1782719393966; 
 Mon, 29 Jun 2026 00:49:53 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-472797ef029sm14595121f8f.16.2026.06.29.00.49.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 00:49:53 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:44:54 +0300
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
Subject: Re: [PATCH v3 2/9] hw/audio/virtio-sound: allocate an array of streams
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-3-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-3-alexander@mihalicyn.com>
Message-ID: <thdv34.1hr3kwq58lz3p@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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
>It is much easier to migrate an array of structs than individual
>structs that are accessed via a pointer to a pointer to an array
>of pointers to struct.
>
>For this reason, allocate an array of streams in
>virtio_snd_realize() and initialise all stream variables that
>are constant at runtime immediately after allocation.
>
>This makes it easier to remove the virtio_snd_set_pcm_params()
>and virtio_snd_pcm_prepare() calls in the realisation phase and
>to migrate the audio streams of the virtio sound device after
>the next few patches.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>     and then reimplemented the patch idea
>/AM]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
>v3:
>	As suggested by Marc-André Lureau:
>	- drop VirtIOSoundPCMStream's id field
>---
> hw/audio/virtio-snd.c         | 34 +++++++++++++++++++++-------------
> include/hw/audio/virtio-snd.h |  2 +-
> 2 files changed, 22 insertions(+), 14 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 6eb31e2838e..859c2770195 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -436,12 +436,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
> 
>     stream = virtio_snd_pcm_get_stream(s, stream_id);
>     if (stream == NULL) {
>-        stream = g_new0(VirtIOSoundPCMStream, 1);
>+        stream = &s->streams[stream_id];
>         stream->active = false;
>-        stream->id = stream_id;
>-        stream->s = s;
>         stream->latency_bytes = 0;
>-        QSIMPLEQ_INIT(&stream->queue);
> 
>         /*
>          * stream_id >= s->snd_conf.streams was checked before so this is
>@@ -451,14 +448,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>     }
> 
>     virtio_snd_get_qemu_audsettings(&as, params);
>-    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
>-        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>-    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>-    stream->info.features = 0;
>-    stream->info.channels_min = 1;
>-    stream->info.channels_max = as.nchannels;
>-    stream->info.formats = supported_formats;
>-    stream->info.rates = supported_rates;
>     stream->params = *params;
> 
>     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>@@ -1046,6 +1035,24 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>     vsnd->vmstate =
>         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
> 
>+    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
>+
>+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>+
>+        stream->s = vsnd;
>+        QSIMPLEQ_INIT(&stream->queue);
>+        stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>+        stream->info.features = 0;
>+        stream->info.formats = supported_formats;
>+        stream->info.rates = supported_rates;
>+        stream->info.direction =
>+            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1)
>+            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>+        stream->info.channels_min = 1;
>+        stream->info.channels_max = 2;


Why 2 instead of as.nchannels? Does this break support for more than 2 
channels?

>+    }
>+
>     vsnd->pcm.streams =
>         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
>     vsnd->pcm.pcm_params =
>@@ -1314,12 +1321,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
>             if (stream) {
>                 virtio_snd_process_cmdq(stream->s);
>                 virtio_snd_pcm_close(stream);
>-                g_free(stream);
>             }
>         }
>         g_free(vsnd->pcm.streams);
>     }
>     g_free(vsnd->pcm.pcm_params);
>+    g_free(vsnd->streams);
>+    vsnd->streams = NULL;
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
>diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>index fce7d1feea2..41c63b3f23b 100644
>--- a/include/hw/audio/virtio-snd.h
>+++ b/include/hw/audio/virtio-snd.h
>@@ -136,7 +136,6 @@ struct VirtIOSoundPCM {
> struct VirtIOSoundPCMStream {
>     virtio_snd_pcm_info info;
>     virtio_snd_pcm_set_params params;
>-    uint32_t id;
>     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
>     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
>     VirtIOSound *s;
>@@ -214,6 +213,7 @@ struct VirtIOSound {
>     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>     uint64_t features;
>     VirtIOSoundPCM pcm;
>+    VirtIOSoundPCMStream *streams;
>     AudioBackend *audio_be;
>     VMChangeStateEntry *vmstate;
>     virtio_snd_config snd_conf;
>-- 
>2.47.3
>

