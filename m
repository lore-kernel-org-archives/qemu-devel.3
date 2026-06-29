Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39196C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7Qh-0007AC-1O; Mon, 29 Jun 2026 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7Qf-00079q-7r
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:33:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7Qc-00064Q-3y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:33:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4926f8e02e8so18136195e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782721996; x=1783326796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=avilhBaUrX6YmJPA1yMh5rhwuI1vHtU8Kwa8jBIGL8Q=;
 b=RpGElOg0wW/+QWinHCBB/l6l+X8yGTj/1ocstonYHXfLlbeuVb/uWC+kh/q/dd5o3H
 Q5bEGTom2Bw55cup+nlXlrpJmUuoRJiPeyQYaO5yjZNe8d16xM2IqufcHyu/uWbM0ARf
 gPhfplL9PxlclRh+9Aem0U+UW9195zxXKDWhuNnvPbQmUIxyIuqRGb3aIFPfANwdMVmC
 yi9B1pWXJWGgNEdbrofonaKACZ1QCQMI/xD+i7mNay5JIDsTHoDA+2AFXVaMptEOUXls
 S3UX7jfvwFpYNGiD09SP3/DvB3c//nRFe3GDn1TIRHA0kA+qWG2Fd+arrCzNGrtT+DyN
 2MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721996; x=1783326796;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avilhBaUrX6YmJPA1yMh5rhwuI1vHtU8Kwa8jBIGL8Q=;
 b=k3sc9zJJzv8f8GBW94y7uOyKCMCU3bszkQRBPIFSw8nV8oOPBCoyNBJ8ZoT7ga3AUc
 8PzCoJqGsL5QK3iA4YmIyls0AYhfHCQJOmnlwqOp4i7b0wB0YxjNJNKz353Z409HrYsh
 LorXHiX1sqCPMgdbmbrVCNlllR9uyJibmz+gYABFI1husvUPUDhMqZoV8ZT2m1Anz/p8
 ftxulY1rzaFV5DDdQwGXCxfYNBlZOOAL/xbHdqkIKO6VMpKQau+jn/OwAirbjW0Fw7kn
 wkUwENli8pVtU1HRv9VHYKQAIXNCnWfK3jhhjgT3ZPn33bdG0MakG0SjhSNh9ac4kIlR
 pDTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OUGyes8193dXw+EwYpwUmrimmPZAJGcArioShhUkJXoriLWV5TOluoa04NdpuuMm7f/xqCzbzXkcU@nongnu.org
X-Gm-Message-State: AOJu0YzHqu87cbJtMEtdU2VRgoJOvrInNVnCJwJtgDJFbuV5fAGSXwqL
 KWBNqFszxZyjRMqHUeQsSB3fKAtkiX6EX23T6HebkRhs8wUi2XNcAGi5zUP4zsjFhz0=
X-Gm-Gg: AfdE7cnuvtohLm8EtViCMoGRc2blA6sFDVEwaX9nosfg0c47pGkpLg2mTYMjuGVOY+k
 6BwSMo8ZMC4deioiJJD7Xcg6L9o8K3wVdFJCZ5DDNM1U3ODkbcsjBXK+4g9FjACdTNgtPwS8SzK
 oVH6DTXW4Qr9NC6rNIa9N7jlGxgoYAu0lXRWhmZ7Whx6T4GNzNYcI3rNmhIBAmpzObh7huPO4zA
 KhqMNdfXJIqZAM//MpR3TiflCvlp6WwnW5YRw52Imp2r0y3pNNGyWxUjQHCBK6WIO7rd5HbiYUY
 xdfAI/Vk0FKXFFhvvcJfMvg2o8MGvQ/01tnRaygJ9RmVMMa1c5HZ4P/u6bniOMGucHvPVAT9N7l
 cbcGtgs7jiDEfZl1nRIkXL5vHLkPF8YdWL5v63O4r4g3Sid58XeuY6PYj9IJZu4yiqeQm9aINWR
 930HWBOSLQnsQNZG0f4qydh75eAKYHJhzytO858zye7EnIRKGcBkRdn3dbccA01JsqURLp83J27
 m5zEaxV43AXOEoJBH+H0TrR3BJAMxw8iaOyUyZhZYMnmg7b5m1p+/HosGTHpNrMD9boPtepQfDr
 0lF+kT6c+RiMXlAxIS+xSYk=
X-Received: by 2002:a05:600c:8286:b0:492:68f5:6b30 with SMTP id
 5b1f17b1804b1-49268f56bc1mr206119765e9.17.1782721995805; 
 Mon, 29 Jun 2026 01:33:15 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f700c0sm340519255e9.0.2026.06.29.01.33.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:33:15 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:31:37 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org,
 Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 5/9] hw/audio/virtio-sound: add stream state variable
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-6-alexander@mihalicyn.com>
 <thdwg7.z2gqqr4zn5aq@linaro.org>
 <20260629041955-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260629041955-mutt-send-email-mst@kernel.org>
Message-ID: <thdx3e.b8e2y7qyqykt@linaro.org>
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

On Mon, 29 Jun 2026 11:21, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Mon, Jun 29, 2026 at 10:58:32AM +0300, Manos Pitsidianakis wrote:
>> On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>> > From: Volker Rümelin <vr_qemu@t-online.de>
>> > 
>> > So far, only rudimentary checks have been made to ensure that
>> > the guest only performs state transitions permitted in
>> > virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
>> > variable per audio stream and check all state transitions.
>> 
>> 
>> This was on purpose: 5.14.6.6.1 is not a Device Requirement / normative
>> statement. (In my opinion it should have been).
>
>It's easy to add them - even strong ones (MUST) if it's clear from the description that this
>was always the intent, and no reasonable implementation would
>do anything else. 

Agreed, will send a patch to virtio-comment. I think strictly adhering 
to the state machine does not break any MUST requirement for the device, 
so it should be backwards compatible.

>
>If not we can add weak ones (SHOULD).
>
>
>> I do not oppose keeping the state though, I chose to do it in the Rust
>> implementation (vhost-device-sound) after I wrote this one as well. It makes
>> sense. But please update the commit message to say that this is not about
>> spec compliance, but simply doing a sanity check following the PCM Command
>> Lifecycle section.
>> 
>> 
>> > 
>> > Because only permitted state transitions are possible, only one
>> > copy of the audio stream parameters is required and these do not
>> > need to be initialised with default values.
>> > 
>> > The state variable will also make it easier to restore the audio
>> > stream after migration.
>> > 
>> > Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> > [AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>> >     and then reimplemented the patch idea
>> > /AM]
>> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>> > ---
>> > v3:
>> > 	- explicitly call virtio_snd_pcm_close() from unrealize
>> > 	- remove a call to virtio_snd_pcm_flush() from virtio_snd_pcm_close()
>> > 	[ ^ this was my rebase mistake ]
>> > ---
>> > hw/audio/virtio-snd.c         | 196 +++++++++++++++++++---------------
>> > include/hw/audio/virtio-snd.h |  18 +---
>> > 2 files changed, 109 insertions(+), 105 deletions(-)
>> > 
>> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>> > index 300ba13ffeb..68d737478f5 100644
>> > --- a/hw/audio/virtio-snd.c
>> > +++ b/hw/audio/virtio-snd.c
>> > @@ -30,11 +30,30 @@
>> > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>> > #define VIRTIO_SOUND_HDA_FN_NID 0
>> > 
>> > +#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
>> > +#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
>> > +#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
>> > +
>> > +#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
>> > +#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
>> > +#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
>> > +#define VSND_PCMSTREAM_STATE_STARTED       (4 \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PREPARED \
>> > +                                           | VSND_PCMSTREAM_STATE_F_ACTIVE)
>> > +#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
>> > +#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
>> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
>> 
>> Are the VSND_PCMSTREAM_STATE_F_* really needed? Seems excessive.
>> 
>> I'd do: (did not type check/compile)
>> 
>> + enum virtio_snd_pcm_state {
>> +   VIRTIO_SND_PCM_STATE_UNINIT = 0,
>> +   VIRTIO_SND_PCM_STATE_PARAMS_SET,
>> +   VIRTIO_SND_PCM_STATE_PREPARED,
>> +   VIRTIO_SND_PCM_STATE_STARTED,
>> +   VIRTIO_SND_PCM_STATE_STOPPED,
>> +   VIRTIO_SND_PCM_STATE_RELEASED,
>> + }
>> 
>> Maybe even write a "method" "macro" for preparedness:
>> 
>> +
>> + static inline bool virtio_snd_pcm_state_prepared(virtio_snd_pcm_state s) {
>> + return s > VIRTIO_SND_PCM_STATE_PARAMS_SET && s <
>> VIRTIO_SND_PCM_STATE_RELEASED
>> + }
>> 
>> And "active" flag bit is only in STARTED state, so just check for equality.
>> 
>> This is not a hard request, but it seems simpler to me and would prefer it.
>> 
>> > +
>> > static void virtio_snd_pcm_out_cb(void *data, int available);
>> > static void virtio_snd_process_cmdq(VirtIOSound *s);
>> > static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
>> > static void virtio_snd_pcm_in_cb(void *data, int available);
>> > -static void virtio_snd_unrealize(DeviceState *dev);
>> > 
>> > static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
>> >                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
>> > @@ -129,7 +148,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>> >                                                        uint32_t stream_id)
>> > {
>> >     return stream_id >= s->snd_conf.streams ? NULL :
>> > -        s->pcm.streams[stream_id];
>> > +        &s->streams[stream_id];
>> > }
>> > 
>> > /*
>> > @@ -141,8 +160,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>> > static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
>> >                                                             uint32_t stream_id)
>> > {
>> > -    return stream_id >= s->snd_conf.streams ? NULL
>> > -        : &s->pcm.pcm_params[stream_id];
>> > +    return stream_id >= s->snd_conf.streams ? NULL :
>> > +        &s->streams[stream_id].params;
>> > }
>> > 
>> > /*
>> > @@ -245,11 +264,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
>> > 
>> > /*
>> >  * Set the given stream params.
>> > - * Called by both virtio_snd_handle_pcm_set_params and during device
>> > - * initialization.
>> >  * Returns the response status code. (VIRTIO_SND_S_*).
>> >  *
>> >  * @s: VirtIOSound device
>> > + * @stream_id: stream id
>> >  * @params: The PCM params as defined in the virtio specification
>> >  */
>> > static
>> > @@ -257,14 +275,25 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>> >                                    uint32_t stream_id,
>> >                                    virtio_snd_pcm_set_params *params)
>> > {
>> > +    VirtIOSoundPCMStream *stream;
>> >     virtio_snd_pcm_set_params *st_params;
>> > 
>> > -    if (stream_id >= s->snd_conf.streams || s->pcm.pcm_params == NULL) {
>> > +    if (stream_id >= s->snd_conf.streams) {
>> >         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
>> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> >     }
>> > 
>> > -    st_params = virtio_snd_pcm_get_params(s, stream_id);
>> > +    stream = virtio_snd_pcm_get_stream(s, stream_id);
>> > +
>> > +    switch (stream->state) {
>> > +    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
>> > +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
>> > +    case VSND_PCMSTREAM_STATE_PREPARED:
>> > +    case VSND_PCMSTREAM_STATE_RELEASED:
>> > +        break;
>> > +    default:
>> > +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> > +    }
>> > 
>> >     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
>> >         error_report("Number of channels is not supported.");
>> > @@ -281,6 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>> >         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>> >     }
>> > 
>> > +    st_params = virtio_snd_pcm_get_params(s, stream_id);
>> > +
>> >     st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
>> >     st_params->period_bytes = le32_to_cpu(params->period_bytes);
>> >     st_params->features = le32_to_cpu(params->features);
>> > @@ -289,6 +320,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>> >     st_params->format = params->format;
>> >     st_params->rate = params->rate;
>> > 
>> > +    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
>> > +        /* implicit VIRTIO_SND_R_PCM_RELEASE */
>> > +        virtio_snd_pcm_flush(stream);
>> > +    }
>> > +
>> > +    stream->state = VSND_PCMSTREAM_STATE_PARAMS_SET;
>> > +
>> >     return cpu_to_le32(VIRTIO_SND_S_OK);
>> > }
>> > 
>> > @@ -398,15 +436,12 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
>> >  */
>> > static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
>> > {
>> > -    if (stream) {
>> > -        virtio_snd_pcm_flush(stream);
>> > -        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>> > -            audio_be_close_out(stream->s->audio_be, stream->voice.out);
>> > -            stream->voice.out = NULL;
>> > -        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
>> > -            audio_be_close_in(stream->s->audio_be, stream->voice.in);
>> > -            stream->voice.in = NULL;
>> > -        }
>> > +    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>> > +        audio_be_close_out(stream->s->audio_be, stream->voice.out);
>> > +        stream->voice.out = NULL;
>> > +    } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
>> > +        audio_be_close_in(stream->s->audio_be, stream->voice.in);
>> > +        stream->voice.in = NULL;
>> >     }
>> > }
>> > 
>> > @@ -423,32 +458,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>> >     virtio_snd_pcm_set_params *params;
>> >     VirtIOSoundPCMStream *stream;
>> > 
>> > -    if (s->pcm.streams == NULL ||
>> > -        s->pcm.pcm_params == NULL ||
>> > -        stream_id >= s->snd_conf.streams) {
>> > +    stream = virtio_snd_pcm_get_stream(s, stream_id);
>> > +    if (!stream) {
>> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> >     }
>> > 
>> > -    params = virtio_snd_pcm_get_params(s, stream_id);
>> > -    if (params == NULL) {
>> > +    switch (stream->state) {
>> > +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
>> > +    case VSND_PCMSTREAM_STATE_PREPARED:
>> > +    case VSND_PCMSTREAM_STATE_RELEASED:
>> > +        break;
>> > +    default:
>> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> >     }
>> > 
>> > -    stream = virtio_snd_pcm_get_stream(s, stream_id);
>> > -    if (stream == NULL) {
>> > -        stream = &s->streams[stream_id];
>> > -        stream->active = false;
>> > -        stream->latency_bytes = 0;
>> > -
>> > -        /*
>> > -         * stream_id >= s->snd_conf.streams was checked before so this is
>> > -         * in-bounds
>> > -         */
>> > -        s->pcm.streams[stream_id] = stream;
>> > -    }
>> > +    params = virtio_snd_pcm_get_params(s, stream_id);
>> > 
>> >     virtio_snd_get_qemu_audsettings(&as, params);
>> > -    stream->params = *params;
>> > 
>> >     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>> >     stream->positions[1] = VIRTIO_SND_CHMAP_FR;
>> > @@ -472,6 +498,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>> >         audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
>> >     }
>> > 
>> > +    stream->state = VSND_PCMSTREAM_STATE_PREPARED;
>> > +
>> >     return cpu_to_le32(VIRTIO_SND_S_OK);
>> > }
>> > 
>> > @@ -542,12 +570,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>> >     }
>> > 
>> >     if (start) {
>> > +        switch (stream->state) {
>> > +        case VSND_PCMSTREAM_STATE_PREPARED:
>> > +        case VSND_PCMSTREAM_STATE_STOPPED:
>> > +            break;
>> > +        default:
>> > +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> > +        }
>> > +
>> >         trace_virtio_snd_handle_pcm_start(stream_id);
>> > +        stream->state = VSND_PCMSTREAM_STATE_STARTED;
>> >     } else {
>> > +        switch (stream->state) {
>> > +        case VSND_PCMSTREAM_STATE_STARTED:
>> > +            break;
>> > +        default:
>> > +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> > +        }
>> > +
>> >         trace_virtio_snd_handle_pcm_stop(stream_id);
>> > +        stream->state = VSND_PCMSTREAM_STATE_STOPPED;
>> >     }
>> > 
>> > -    stream->active = start;
>> >     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>> >         audio_be_set_active_out(s->audio_be, stream->voice.out, start);
>> >     } else {
>> > @@ -641,6 +685,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>> >         return;
>> >     }
>> > 
>> > +    switch (stream->state) {
>> > +    case VSND_PCMSTREAM_STATE_PREPARED:
>> > +    case VSND_PCMSTREAM_STATE_STOPPED:
>> > +        break;
>> > +    default:
>> > +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>> > +        return;
>> > +    }
>> > +
>> >     if (virtio_snd_pcm_get_io_msgs_count(stream)) {
>> >         /*
>> >          * virtio-v1.2-csd01, 5.14.6.6.5.1,
>> > @@ -655,6 +708,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>> >         virtio_snd_pcm_flush(stream);
>> >     }
>> > 
>> > +    stream->state = VSND_PCMSTREAM_STATE_RELEASED;
>> > +
>> >     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
>> > }
>> > 
>> > @@ -876,12 +931,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>> >         }
>> >         stream_id = le32_to_cpu(hdr.stream_id);
>> > 
>> > -        if (stream_id >= vsnd->snd_conf.streams
>> > -            || vsnd->pcm.streams[stream_id] == NULL) {
>> > +        if (stream_id >= vsnd->snd_conf.streams) {
>> >             goto tx_err;
>> >         }
>> > 
>> > -        stream = vsnd->pcm.streams[stream_id];
>> > +        stream = &vsnd->streams[stream_id];
>> >         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
>> >             goto tx_err;
>> >         }
>> > @@ -956,13 +1010,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>> >         }
>> >         stream_id = le32_to_cpu(hdr.stream_id);
>> > 
>> > -        if (stream_id >= vsnd->snd_conf.streams
>> > -            || !vsnd->pcm.streams[stream_id]) {
>> > +        if (stream_id >= vsnd->snd_conf.streams) {
>> >             goto rx_err;
>> >         }
>> > 
>> > -        stream = vsnd->pcm.streams[stream_id];
>> > -        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
>> > +        stream = &vsnd->streams[stream_id];
>> > +        if (stream->info.direction != VIRTIO_SND_D_INPUT) {
>> >             goto rx_err;
>> >         }
>> > 
>> > @@ -1021,8 +1074,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>> >     ERRP_GUARD();
>> >     VirtIOSound *vsnd = VIRTIO_SND(dev);
>> >     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> > -    virtio_snd_pcm_set_params default_params = { 0 };
>> > -    uint32_t status;
>> > 
>> >     trace_virtio_snd_realize(vsnd);
>> > 
>> > @@ -1059,6 +1110,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>> >     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>> >         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>> > 
>> > +        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
>> >         stream->s = vsnd;
>> >         QSIMPLEQ_INIT(&stream->queue);
>> >         stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>> > @@ -1072,21 +1124,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>> >         stream->info.channels_max = 2;
>> >     }
>> > 
>> > -    vsnd->pcm.streams =
>> > -        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
>> > -    vsnd->pcm.pcm_params =
>> > -        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
>> > -
>> >     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>> >     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
>> > 
>> > -    /* set default params for all streams */
>> > -    default_params.features = 0;
>> > -    default_params.buffer_bytes = cpu_to_le32(8192);
>> > -    default_params.period_bytes = cpu_to_le32(2048);
>> > -    default_params.channels = 2;
>> > -    default_params.format = VIRTIO_SND_PCM_FMT_S16;
>> > -    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
>> >     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
>> >         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
>> >     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
>> > @@ -1097,28 +1137,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>> >         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
>> >     QTAILQ_INIT(&vsnd->cmdq);
>> >     QSIMPLEQ_INIT(&vsnd->invalid);
>> > -
>> > -    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>> > -        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
>> > -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
>> > -            error_setg(errp,
>> > -                       "Can't initialize stream params, device responded with %s.",
>> > -                       print_code(status));
>> > -            goto error_cleanup;
>> > -        }
>> > -        status = virtio_snd_pcm_prepare(vsnd, i);
>> > -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
>> > -            error_setg(errp,
>> > -                       "Can't prepare streams, device responded with %s.",
>> > -                       print_code(status));
>> > -            goto error_cleanup;
>> > -        }
>> > -    }
>> > -
>> > -    return;
>> > -
>> > -error_cleanup:
>> > -    virtio_snd_unrealize(dev);
>> > }
>> > 
>> > static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
>> > @@ -1167,7 +1185,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>> >         if (!virtio_queue_ready(buffer->vq)) {
>> >             return;
>> >         }
>> > -        if (!stream->active) {
>> > +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
>> >             /* Stream has stopped, so do not perform audio_be_write. */
>> >             return_tx_buffer(stream, buffer);
>> >             continue;
>> > @@ -1261,7 +1279,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>> >         if (!virtio_queue_ready(buffer->vq)) {
>> >             return;
>> >         }
>> > -        if (!stream->active) {
>> > +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
>> >             /* Stream has stopped, so do not perform audio_be_read. */
>> >             return_rx_buffer(stream, buffer);
>> >             continue;
>> > @@ -1334,17 +1352,16 @@ static void virtio_snd_unrealize(DeviceState *dev)
>> >     qemu_del_vm_change_state_handler(vsnd->vmstate);
>> >     trace_virtio_snd_unrealize(vsnd);
>> > 
>> > -    if (vsnd->pcm.streams) {
>> > +    if (vsnd->streams) {
>> > +        virtio_snd_process_cmdq(vsnd);
>> >         for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>> > -            stream = vsnd->pcm.streams[i];
>> > -            if (stream) {
>> > -                virtio_snd_process_cmdq(stream->s);
>> > -                virtio_snd_pcm_close(stream);
>> > +            stream = &vsnd->streams[i];
>> > +            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
>> > +                virtio_snd_pcm_flush(stream);
>> >             }
>> > +            virtio_snd_pcm_close(stream);
>> >         }
>> > -        g_free(vsnd->pcm.streams);
>> >     }
>> > -    g_free(vsnd->pcm.pcm_params);
>> >     g_free(vsnd->streams);
>> >     vsnd->streams = NULL;
>> >     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>> > @@ -1378,6 +1395,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>> >         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>> >         VirtIOSoundPCMBuffer *buffer;
>> > 
>> > +        virtio_snd_pcm_close(stream);
>> > +        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
>> > +
>> >         while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
>> >             QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>> >             virtio_snd_pcm_buffer_free(buffer);
>> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>> > index 41c63b3f23b..72ef34e0976 100644
>> > --- a/include/hw/audio/virtio-snd.h
>> > +++ b/include/hw/audio/virtio-snd.h
>> > @@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
>> > 
>> > typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
>> > 
>> > -typedef struct VirtIOSoundPCM VirtIOSoundPCM;
>> > -
>> > typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
>> > 
>> > /*
>> > @@ -121,31 +119,18 @@ struct VirtIOSoundPCMBuffer {
>> >     uint8_t data[];
>> > };
>> > 
>> > -struct VirtIOSoundPCM {
>> > -    /*
>> > -     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
>> > -     * field, because the operation of PCM control requests is first
>> > -     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
>> > -     * means that some times we get parameters without having an allocated
>> > -     * stream yet.
>> > -     */
>> > -    virtio_snd_pcm_set_params *pcm_params;
>> > -    VirtIOSoundPCMStream **streams;
>> > -};
>> > -
>> > struct VirtIOSoundPCMStream {
>> >     virtio_snd_pcm_info info;
>> >     virtio_snd_pcm_set_params params;
>> > +    uint32_t state;
>> >     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
>> >     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
>> >     VirtIOSound *s;
>> > -    bool flushing;
>> 
>> Spurious change: this should be a separate patch.
>> 
>> >     audsettings as;
>> >     union {
>> >         SWVoiceIn *in;
>> >         SWVoiceOut *out;
>> >     } voice;
>> > -    bool active;
>> >     uint32_t latency_bytes;
>> >     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>> > };
>> > @@ -212,7 +197,6 @@ struct VirtIOSound {
>> > 
>> >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>> >     uint64_t features;
>> > -    VirtIOSoundPCM pcm;
>> >     VirtIOSoundPCMStream *streams;
>> >     AudioBackend *audio_be;
>> >     VMChangeStateEntry *vmstate;
>> > -- 
>> > 2.47.3
>> > 
>

