Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93DEC79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4CkC-0004WX-SK; Wed, 09 Sep 2026 03:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x4CkB-0004Or-IK
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x4Ck8-0003oe-ME
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so51358765e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788938955; x=1789543755; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bYMPqywGbJc/yTTNVlomffS/MV5ae0G3NIpbjhBaPzQ=;
 b=krEm9qAcT7F1p6OOeBnNgLQ1SRf/O2zlM9JUpwaPEuBEx+pLUAvLgmpSQHKyXEJnFd
 GZQouYcofnse9FMClvZGeQNohOY1sHVUoYIo9dg9KXa+yYAbbnenUksA4ugRWZ+Hp3Xg
 KysHc/naeDIb357MXNcHxmknreCkK3z5zhSa6IVcq+RGyOCYesK+RUuEMmgtUNt/fUBN
 1+XCpxDcK6mFpcYbOqMLmkB8Wes1tnk8yc7gAk0s5HsIggmovzp59WIcgceFJXotVZ4N
 mc5V+nm9Vw7JhJDU1Y+TKgB1CJYxUc7E2QEm7SbsPnekJCJbfbf4i/neoAJb4wCx+kB8
 5VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938955; x=1789543755;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYMPqywGbJc/yTTNVlomffS/MV5ae0G3NIpbjhBaPzQ=;
 b=Oz6Eau4zFdhdc9sjyUq1SqI269XEIgomAaleEH81fwQtrZ1zbZNFQKK6vKC+7+Thl6
 kgg9uGiC83oW6Ls+CmkYlwBSQJ16Gc4evoS6QcpkscaZ4My4V0F8ISpfgk/WHdyQGTme
 gXpuGGIA6wB0XFGJJDPKTMibLwP1Rm2bMa2fSBbUvJMWUJt7UipCq+Av0cGQQYStx/oP
 nKQg2EHgi5Id0cgaVOdfe1UKgKPIcVS3S922W22WrYumkrirfQ2elo6xCzWcfnFgeNVh
 +q+xNiiQa1upgAoERw21Q8t0e0RlydqZ2/liB3F3rsZXp0BU8YHhm35YfgQJQWwynDzC
 epBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzrslRhcIo4jAEkPRTXYGJQy8AZQ9LS3Stx5td1p7ryiCqAyjMib/yehJMPuu4OSEbI4gfFJo76+Iw@nongnu.org
X-Gm-Message-State: AFuF++kFQ1zrkqzSRxkpJQWu0oajkhxLvtz34sror650HN39bkL5q5DE
 gFuPv9d+n5RzZ2g6jqKVbF73ClnaMRCMccX1oR8AK1Q+tE82zqKgll/NcUxfGVnO1u0=
X-Gm-Gg: AYBFou16tqMszRMcG0SK0id7Gi5vQLFswhsKmPrvGonSnoVyRdIAw9oMJF5DwIgNPT4
 JQSmagqArdvPslrfZ2VRs9jk3sSJ6Y+qabsa0KDKm34qJIIJt/Hn37b5DRYXo8VhiVm1lS+OBs7
 hkBSpvHC8p1WJ4RPvy1cDKu6BzmiL889/chhs4qTe1eC4IK1ORxQhpy+ANI/iGDbHjMqdj4pWnk
 nm0zs+umMQwf6lCE8S1u+9zw1Pl1WD/FCC3bg64/+riKVqFhkORcAZp+jmDs/W+6e7Ns26ZnEVD
 1vLp1hYZ78IkjJ9xz2pLbEQuDrkLNmaI/+RPARJjvUgI2tg2dLX18hKscM8wyI1dqEkoKZ9rmR1
 s3kt1rT+AIiwcewAJAcn++pB9cz9Pb2ldytNKjQgh9qVaXXd9goQ1W6w+NT5WimV00la9okzyyr
 t4m9QaFTAm0G3d3QnO0jmcGLyJOfwsb7QPvTaX7u3ATZ65vnqYborp0GyM2yZfi5zvoD4z6dHhs
 0y+ZO5YC1VF0gOnyAz/7txuACzq98hOEDUTvGQnS75FwwDzP+qKxjgI4ZPH5lmtDl9cM53zLl9i
 oc5b6/uL5DZHlewxNrLZxLkNrDdzzngcPaK48LguVG4jHAMXMavLZ7gK0sBPedfC5wT0Hia3YnO
 XaubUGmEUozqONR2LcoPd03hp78zbaJJd7nU=
X-Received: by 2002:a05:600c:474c:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49cf828cd70mr311689075e9.16.1788938954602; 
 Wed, 09 Sep 2026 00:29:14 -0700 (PDT)
Received: from meli-email.org (athedsl-116222.home.otenet.gr. [85.75.29.157])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm352577595e9.0.2026.09.09.00.29.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2026 00:29:14 -0700 (PDT)
Date: Wed, 09 Sep 2026 10:26:08 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 07/10] hw/audio/virtio-sound: add stream state variable
User-Agent: meli/0.8.13
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <20260803081159.91981-8-alexander@mihalicyn.com>
In-Reply-To: <20260803081159.91981-8-alexander@mihalicyn.com>
Message-ID: <tl364p.3wmmsms274jr@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Mon, 03 Aug 2026 11:11, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>So far, only rudimentary checks have been made to ensure that
>the guest only performs state transitions described in
>virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. While this
>is not a Device Requirement, let's add a state variable
>per audio stream and check all state transitions.
>
>Because only permitted state transitions are now possible, only one
>copy of the audio stream parameters is required and these do not
>need to be initialised with default values.
>
>The state variable will also make it easier to restore the audio
>stream after migration.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>     and then reimplemented the patch idea
>/AM]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>---
>v5:
>	- checkpatch fix
>v4:
>	- switched to enum virtio_snd_pcm_state
>	  (suggested by Manos Pitsidianakis)
>	- call virtio_snd_pcm_close() when switching to
>	  VSND_PCMSTREAM_STATE_PARAMS_SET and VSND_PCMSTREAM_STATE_RELEASED
>	  states
>	- added virtio_error() in case when stream->state is unexpected
>	- fixed an error message text in virtio_snd_set_pcm_params
>	  (suggestions from Marc-André Lureau)
>v3:
>	- explicitly call virtio_snd_pcm_close() from unrealize
>	- remove a call to virtio_snd_pcm_flush() from virtio_snd_pcm_close()
>	[ ^ this was my rebase mistake ]
>---
> hw/audio/virtio-snd.c         | 213 ++++++++++++++++++++--------------
> include/hw/audio/virtio-snd.h |  17 +--
> 2 files changed, 124 insertions(+), 106 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 46026b8cffc..1c218569cfd 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -30,11 +30,26 @@
> #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> #define VIRTIO_SOUND_HDA_FN_NID 0
> 
>+typedef enum virtio_snd_pcm_state {
>+    VIRTIO_SND_PCM_STATE_UNINIT = 0,
>+    VIRTIO_SND_PCM_STATE_PARAMS_SET,
>+    VIRTIO_SND_PCM_STATE_PREPARED,
>+    VIRTIO_SND_PCM_STATE_STARTED,
>+    VIRTIO_SND_PCM_STATE_STOPPED,
>+    VIRTIO_SND_PCM_STATE_RELEASED,
>+} virtio_snd_pcm_state;
>+
>+static inline bool virtio_snd_pcm_state_prepared(virtio_snd_pcm_state s)
>+{
>+    return s > VIRTIO_SND_PCM_STATE_PARAMS_SET &&
>+           s < VIRTIO_SND_PCM_STATE_RELEASED;
>+}
>+
> static void virtio_snd_pcm_out_cb(void *data, int available);
> static void virtio_snd_process_cmdq(VirtIOSound *s);
> static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
>+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream);
> static void virtio_snd_pcm_in_cb(void *data, int available);
>-static void virtio_snd_unrealize(DeviceState *dev);
> 
> static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
>                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
>@@ -129,7 +144,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>                                                        uint32_t stream_id)
> {
>     return stream_id >= s->snd_conf.streams ? NULL :
>-        s->pcm.streams[stream_id];
>+        &s->streams[stream_id];
> }
> 
> /*
>@@ -141,8 +156,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
> static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
>                                                             uint32_t stream_id)
> {
>-    return stream_id >= s->snd_conf.streams ? NULL
>-        : &s->pcm.pcm_params[stream_id];
>+    return stream_id >= s->snd_conf.streams ? NULL :
>+        &s->streams[stream_id].params;
> }
> 
> /*
>@@ -245,11 +260,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> 
> /*
>  * Set the given stream params.
>- * Called by both virtio_snd_handle_pcm_set_params and during device
>- * initialization.
>  * Returns the response status code. (VIRTIO_SND_S_*).
>  *
>  * @s: VirtIOSound device
>+ * @stream_id: stream id
>  * @params: The PCM params as defined in the virtio specification
>  */
> static
>@@ -257,14 +271,27 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>                                    uint32_t stream_id,
>                                    virtio_snd_pcm_set_params *params)
> {
>+    VirtIOSoundPCMStream *stream;
>     virtio_snd_pcm_set_params *st_params;
> 
>-    if (stream_id >= s->snd_conf.streams || s->pcm.pcm_params == NULL) {
>-        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
>+    stream = virtio_snd_pcm_get_stream(s, stream_id);
>+    if (!stream) {
>+        virtio_error(VIRTIO_DEVICE(s), "invalid stream id: %"PRIu32,
>+                     stream_id);
>         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>     }
> 
>-    st_params = virtio_snd_pcm_get_params(s, stream_id);
>+    switch (stream->state) {
>+    case VIRTIO_SND_PCM_STATE_UNINIT:
>+    case VIRTIO_SND_PCM_STATE_PARAMS_SET:
>+    case VIRTIO_SND_PCM_STATE_PREPARED:
>+    case VIRTIO_SND_PCM_STATE_RELEASED:
>+        break;
>+    default:
>+        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
>+                     stream->state);
>+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>+    }
> 
>     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
>         error_report("Number of channels is not supported.");
>@@ -281,6 +308,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>     }
> 
>+    st_params = virtio_snd_pcm_get_params(s, stream_id);
>+
>     st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
>     st_params->period_bytes = le32_to_cpu(params->period_bytes);
>     st_params->features = le32_to_cpu(params->features);
>@@ -289,6 +318,15 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>     st_params->format = params->format;
>     st_params->rate = params->rate;
> 
>+    if (virtio_snd_pcm_state_prepared(stream->state)) {
>+        /* implicit VIRTIO_SND_R_PCM_RELEASE */
>+        virtio_snd_pcm_flush(stream);
>+    }
>+
>+    virtio_snd_pcm_close(stream);
>+
>+    stream->state = VIRTIO_SND_PCM_STATE_PARAMS_SET;
>+
>     return cpu_to_le32(VIRTIO_SND_S_OK);
> }
> 
>@@ -398,15 +436,12 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
>  */
> static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
> {
>-    if (stream) {
>-        virtio_snd_pcm_flush(stream);
>-        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>-            audio_be_close_out(stream->s->audio_be, stream->voice.out);
>-            stream->voice.out = NULL;
>-        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
>-            audio_be_close_in(stream->s->audio_be, stream->voice.in);
>-            stream->voice.in = NULL;
>-        }
>+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>+        audio_be_close_out(stream->s->audio_be, stream->voice.out);
>+        stream->voice.out = NULL;
>+    } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
>+        audio_be_close_in(stream->s->audio_be, stream->voice.in);
>+        stream->voice.in = NULL;
>     }
> }
> 
>@@ -423,33 +458,26 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>     virtio_snd_pcm_set_params *params;
>     VirtIOSoundPCMStream *stream;
> 
>-    if (s->pcm.streams == NULL ||
>-        s->pcm.pcm_params == NULL ||
>-        stream_id >= s->snd_conf.streams) {
>+    stream = virtio_snd_pcm_get_stream(s, stream_id);
>+    if (!stream) {
>         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>     }
> 
>-    params = virtio_snd_pcm_get_params(s, stream_id);
>-    if (params == NULL) {
>+    switch (stream->state) {
>+    case VIRTIO_SND_PCM_STATE_PARAMS_SET:
>+    case VIRTIO_SND_PCM_STATE_PREPARED:
>+    case VIRTIO_SND_PCM_STATE_RELEASED:
>+        break;
>+    default:
>+        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
>+                     stream->state);
>         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>     }
> 
>-    stream = virtio_snd_pcm_get_stream(s, stream_id);
>-    if (stream == NULL) {
>-        stream = &s->streams[stream_id];
>-        stream->active = false;
>-        stream->latency_bytes = 0;
>-
>-        /*
>-         * stream_id >= s->snd_conf.streams was checked before so this is
>-         * in-bounds
>-         */
>-        s->pcm.streams[stream_id] = stream;
>-    }
>+    params = virtio_snd_pcm_get_params(s, stream_id);
> 
>     virtio_snd_get_qemu_audsettings(&as, params);
>     stream->info.channels_max = as.nchannels;
>-    stream->params = *params;
> 
>     stream->as = as;
> 
>@@ -471,6 +499,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>         audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
>     }
> 
>+    stream->state = VIRTIO_SND_PCM_STATE_PREPARED;
>+
>     return cpu_to_le32(VIRTIO_SND_S_OK);
> }
> 
>@@ -545,7 +575,31 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>     }
> 
>-    stream->active = start;
>+    if (start) {
>+        switch (stream->state) {
>+        case VIRTIO_SND_PCM_STATE_PREPARED:
>+        case VIRTIO_SND_PCM_STATE_STOPPED:
>+            break;
>+        default:
>+            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
>+                         stream->state);
>+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>+        }
>+
>+        stream->state = VIRTIO_SND_PCM_STATE_STARTED;
>+    } else {
>+        switch (stream->state) {
>+        case VIRTIO_SND_PCM_STATE_STARTED:
>+            break;
>+        default:
>+            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
>+                         stream->state);
>+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>+        }
>+
>+        stream->state = VIRTIO_SND_PCM_STATE_STOPPED;
>+    }
>+
>     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>         audio_be_set_active_out(s->audio_be, stream->voice.out, start);
>     } else {
>@@ -639,6 +693,17 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>         return;
>     }
> 
>+    switch (stream->state) {
>+    case VIRTIO_SND_PCM_STATE_PREPARED:
>+    case VIRTIO_SND_PCM_STATE_STOPPED:
>+        break;
>+    default:
>+        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
>+                     stream->state);
>+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>+        return;
>+    }
>+
>     if (virtio_snd_pcm_get_io_msgs_count(stream)) {
>         /*
>          * virtio-v1.2-csd01, 5.14.6.6.5.1,
>@@ -653,6 +718,10 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>         virtio_snd_pcm_flush(stream);
>     }
> 
>+    virtio_snd_pcm_close(stream);
>+
>+    stream->state = VIRTIO_SND_PCM_STATE_RELEASED;
>+
>     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
> }
> 
>@@ -876,12 +945,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>         size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
>         stream_id = le32_to_cpu(hdr.stream_id);
> 
>-        if (stream_id >= vsnd->snd_conf.streams
>-            || vsnd->pcm.streams[stream_id] == NULL) {
>+        if (stream_id >= vsnd->snd_conf.streams) {
>             goto tx_err;
>         }
> 
>-        stream = vsnd->pcm.streams[stream_id];
>+        stream = &vsnd->streams[stream_id];
>         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
>             goto tx_err;
>         }
>@@ -959,15 +1027,13 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>         }
>         stream_id = le32_to_cpu(hdr.stream_id);
> 
>-        if (stream_id >= vsnd->snd_conf.streams
>-            || !vsnd->pcm.streams[stream_id]) {
>+        if (stream_id >= vsnd->snd_conf.streams) {
>             goto rx_err;
>         }
> 
>-        stream = vsnd->pcm.streams[stream_id];
>+        stream = &vsnd->streams[stream_id];
>         size = iov_size(elem->in_sg, elem->in_num);
>-        if (stream == NULL
>-            || stream->info.direction != VIRTIO_SND_D_INPUT
>+        if (stream->info.direction != VIRTIO_SND_D_INPUT
>             || size < sizeof(virtio_snd_pcm_status)) {
>             goto rx_err;
>         }
>@@ -1031,8 +1097,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>     ERRP_GUARD();
>     VirtIOSound *vsnd = VIRTIO_SND(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>-    virtio_snd_pcm_set_params default_params = { 0 };
>-    uint32_t status;
> 
>     trace_virtio_snd_realize(vsnd);
> 
>@@ -1069,6 +1133,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
> 
>+        stream->state = VIRTIO_SND_PCM_STATE_UNINIT;
>         stream->s = vsnd;
>         QSIMPLEQ_INIT(&stream->queue);
>         stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>@@ -1082,21 +1147,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>         stream->info.channels_max = 2;
>     }
> 
>-    vsnd->pcm.streams =
>-        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
>-    vsnd->pcm.pcm_params =
>-        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
>-
>     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> 
>-    /* set default params for all streams */
>-    default_params.features = 0;
>-    default_params.buffer_bytes = cpu_to_le32(8192);
>-    default_params.period_bytes = cpu_to_le32(2048);
>-    default_params.channels = 2;
>-    default_params.format = VIRTIO_SND_PCM_FMT_S16;
>-    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
>     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
>         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
>     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
>@@ -1107,28 +1160,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
>     QTAILQ_INIT(&vsnd->cmdq);
>     QSIMPLEQ_INIT(&vsnd->invalid);
>-
>-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>-        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
>-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
>-            error_setg(errp,
>-                       "Can't initialize stream params, device responded with %s.",
>-                       print_code(status));
>-            goto error_cleanup;
>-        }
>-        status = virtio_snd_pcm_prepare(vsnd, i);
>-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
>-            error_setg(errp,
>-                       "Can't prepare streams, device responded with %s.",
>-                       print_code(status));
>-            goto error_cleanup;
>-        }
>-    }
>-
>-    return;
>-
>-error_cleanup:
>-    virtio_snd_unrealize(dev);
> }
> 
> static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
>@@ -1177,7 +1208,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>         if (!virtio_queue_ready(buffer->vq)) {
>             return;
>         }
>-        if (!stream->active) {
>+        if (stream->state != VIRTIO_SND_PCM_STATE_STARTED) {
>             /* Stream has stopped, so do not perform audio_be_write. */


The spec says in 5.14.6.6.1 PCM Command Lifecycle (between PREPARE and 
START states):

    3.  Output only: the driver transfers data for pre-buffing.

Does this mean the guest cannot prebuf?

This is not introduced by this patch but it made me notice it.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>             return_tx_buffer(stream, buffer);
>             continue;
>@@ -1271,7 +1302,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>         if (!virtio_queue_ready(buffer->vq)) {
>             return;
>         }
>-        if (!stream->active) {
>+        if (stream->state != VIRTIO_SND_PCM_STATE_STARTED) {
>             /* Stream has stopped, so do not perform audio_be_read. */
>             return_rx_buffer(stream, buffer);
>             continue;
>@@ -1344,17 +1375,16 @@ static void virtio_snd_unrealize(DeviceState *dev)
>     qemu_del_vm_change_state_handler(vsnd->vmstate);
>     trace_virtio_snd_unrealize(vsnd);
> 
>-    if (vsnd->pcm.streams) {
>+    if (vsnd->streams) {
>+        virtio_snd_process_cmdq(vsnd);
>         for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>-            stream = vsnd->pcm.streams[i];
>-            if (stream) {
>-                virtio_snd_process_cmdq(stream->s);
>-                virtio_snd_pcm_close(stream);
>+            stream = &vsnd->streams[i];
>+            if (virtio_snd_pcm_state_prepared(stream->state)) {
>+                virtio_snd_pcm_flush(stream);
>             }
>+            virtio_snd_pcm_close(stream);
>         }
>-        g_free(vsnd->pcm.streams);
>     }
>-    g_free(vsnd->pcm.pcm_params);
>     g_free(vsnd->streams);
>     vsnd->streams = NULL;
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>@@ -1387,6 +1417,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>         VirtIOSoundPCMBuffer *buffer;
> 
>+        virtio_snd_pcm_close(stream);
>+        stream->state = VIRTIO_SND_PCM_STATE_UNINIT;
>+
>         while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
>             QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>             virtio_snd_pcm_buffer_free(buffer);
>diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>index 97ffaae18be..85d5d7c8619 100644
>--- a/include/hw/audio/virtio-snd.h
>+++ b/include/hw/audio/virtio-snd.h
>@@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
> 
> typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
> 
>-typedef struct VirtIOSoundPCM VirtIOSoundPCM;
>-
> typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
> 
> /*
>@@ -121,28 +119,16 @@ struct VirtIOSoundPCMBuffer {
>     uint8_t data[];
> };
> 
>-struct VirtIOSoundPCM {
>-    /*
>-     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
>-     * field, because the operation of PCM control requests is first
>-     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
>-     * means that some times we get parameters without having an allocated
>-     * stream yet.
>-     */
>-    virtio_snd_pcm_set_params *pcm_params;
>-    VirtIOSoundPCMStream **streams;
>-};
>-
> struct VirtIOSoundPCMStream {
>     virtio_snd_pcm_info info;
>     virtio_snd_pcm_set_params params;
>+    uint32_t state;
>     VirtIOSound *s;
>     audsettings as;
>     union {
>         SWVoiceIn *in;
>         SWVoiceOut *out;
>     } voice;
>-    bool active;
>     uint32_t latency_bytes;
>     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> };
>@@ -209,7 +195,6 @@ struct VirtIOSound {
> 
>     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>     uint64_t features;
>-    VirtIOSoundPCM pcm;
>     VirtIOSoundPCMStream *streams;
>     AudioBackend *audio_be;
>     VMChangeStateEntry *vmstate;
>-- 
>2.47.3
>

