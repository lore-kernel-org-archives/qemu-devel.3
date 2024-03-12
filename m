Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD427C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4AP-00041G-4D; Tue, 12 Mar 2024 11:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4AF-00040J-Eo
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4AC-0001T0-Ia
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710257735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6BHmQ9R4SuKARpjqnz1AO1E/VRWnrRofeqklKAcdxc=;
 b=QD79v3+0CIT+Fm72aYXTRxBEvAYrqmwib52N3I0FxwdvA/d2rsrnT4TIQIWc3LNE3HDCHe
 Sg8BGchaWx0nFfj96NODR6kJ5iPyu/zhMzBcLolkrJiga63BcsLS9pZsQeoCw4X6La/Y0V
 J52OWBZVExYa8dX44r8wHFxQMTdOdag=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Ff9xuHYFNN-YAkHQd_ZlFw-1; Tue, 12 Mar 2024 11:35:33 -0400
X-MC-Unique: Ff9xuHYFNN-YAkHQd_ZlFw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5131d042b1aso3329875e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710257732; x=1710862532;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6BHmQ9R4SuKARpjqnz1AO1E/VRWnrRofeqklKAcdxc=;
 b=ayLEhF9i+9sDL5CfeWhTW0tWnEIU+0ALqwBAKygiVOJaYZgcMoR93MMqiGGthYmgTQ
 dNbNKHTcoYovd17wYGy+L1vjETYU4YgfKhd2XTaMw4QU1yJxqImbYx4pIFQ5uUY6cnk2
 u+r/VJfz/v9UBwrhl9fv94xr7WtXB/3CjDqMk/PLizp49L5OU2rWLsRYuJh2qEOJKgYu
 BBWiJBdb/KqGGf41TUaNTrAhRgNAQ8lj3gXOFkb7qdpA0irb1BzCWemNC7RqS2Ywdo4Y
 qaAMBYUTGiiBJzlveDgLprL4U5evoQ25vDFtXvqnhmGlHoEIFoTEHfzi1E8bTP+mlVzR
 TfWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdJJJfY4Nau6anFvrNgT/ciArp2SPPUXo3MoY0SWUtGUqZ6ffi/3+y4eDO/Tu1zcX8hYihrPgYMPJMUEB9BhMjRZwOMuo=
X-Gm-Message-State: AOJu0YzIAHfEDwRrN1s9dfIlFg0L2V8vq/A/jCEN27K3+Un8QUSggmPH
 byaeG8QoaTKLMP8OydeU3b1bq04xMZvCf5woQQskSEyT/Osp51L6VXm1g7ls5CxEyyyzHPJlAb5
 M8Tsvpi2CptP9L/uVHr/l89CiodloJmMcZ3wMNlfuuItDOadAQr6X
X-Received: by 2002:a05:6512:11cf:b0:512:d5e4:1aa4 with SMTP id
 h15-20020a05651211cf00b00512d5e41aa4mr7051330lfr.60.1710257731749; 
 Tue, 12 Mar 2024 08:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfXDsCaRg3p2Vqs3hlygmKTCInAIikmq2MfVTnqBtdpSRoMrI2sljNvVSrolF9uAssIM1dRg==
X-Received: by 2002:a05:6512:11cf:b0:512:d5e4:1aa4 with SMTP id
 h15-20020a05651211cf00b00512d5e41aa4mr7051300lfr.60.1710257730963; 
 Tue, 12 Mar 2024 08:35:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a056512318b00b005139d7a3418sm1526176lfe.83.2024.03.12.08.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:35:30 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:35:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/11] hw/audio/virtio-sound: add stream state variable
Message-ID: <20240312113334-mutt-send-email-mst@kernel.org>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
 <20240218083351.8524-7-vr_qemu@t-online.de>
 <CAAjaMXYhYuV3BZ0D+Q1dMq5QD+2tDKX8gTZv0cCm3nWGBfJJAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXYhYuV3BZ0D+Q1dMq5QD+2tDKX8gTZv0cCm3nWGBfJJAA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 02:59:45PM +0200, Manos Pitsidianakis wrote:
> Hello Volker,
> 
> On Sun, 18 Feb 2024 at 10:34, Volker Rümelin <vr_qemu@t-online.de> wrote:
> >
> > So far, only rudimentary checks have been made to ensure that
> > the guest only performs state transitions permitted in
> > virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle.
> 
> 5.14.6.6.1 is non-normative in virtio v1.2. You can even see it's not
> in device requirements. The state transitions were thus not checked on
> purpose.
> 
> There is nothing in the standard that describes error conditions
> pertaining to the "PCM lifecycle" state machine. It really should, but
> it doesn't, unfortunately.

Well it's not a big deal, if something does not make sense
but we did not require it, as long as we can be reasonably
sure no one does it we can always add them later
and if drivers practically behave correctly then qemu can
just assume that, any drivers doing stupid things will only
hurt themselves.



> > Add a state
> > variable per audio stream and check all state transitions.
> >
> > Because only permitted state transitions are possible, only one
> > copy of the audio stream parameters is required and these do not
> > need to be initialised with default values.
> >
> > The state variable will also make it easier to restore the audio
> > stream after migration.
> 
> I suggest you instead add the state tracking but only use it for the
> post_load code for migration.
> 


> 
> > Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> > ---
> >  hw/audio/virtio-snd.c         | 213 ++++++++++++++++++----------------
> >  include/hw/audio/virtio-snd.h |  20 +---
> >  2 files changed, 111 insertions(+), 122 deletions(-)
> >
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 435ce26430..bbbdd01aa9 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -31,11 +31,30 @@
> >  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> >  #define VIRTIO_SOUND_HDA_FN_NID 0
> >
> > +#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
> > +#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
> > +#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
> > +
> > +#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
> > +#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
> > +#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
> > +                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
> > +#define VSND_PCMSTREAM_STATE_STARTED       (4 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
> > +                                           | VSND_PCMSTREAM_STATE_F_PREPARED \
> > +                                           | VSND_PCMSTREAM_STATE_F_ACTIVE)
> > +#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
> > +                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
> > +#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
> > +
> >  static void virtio_snd_pcm_out_cb(void *data, int available);
> >  static void virtio_snd_process_cmdq(VirtIOSound *s);
> >  static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
> >  static void virtio_snd_pcm_in_cb(void *data, int available);
> > -static void virtio_snd_unrealize(DeviceState *dev);
> >
> >  static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
> >                                    | BIT(VIRTIO_SND_PCM_FMT_U8)
> > @@ -153,8 +172,8 @@ virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
> >  static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
> >                                                         uint32_t stream_id)
> >  {
> > -    return stream_id >= s->snd_conf.streams ? NULL :
> > -        s->pcm->streams[stream_id];
> > +    return stream_id >= s->snd_conf.streams ? NULL
> > +        : &s->streams[stream_id];
> >  }
> >
> >  /*
> > @@ -167,7 +186,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
> >                                                              uint32_t stream_id)
> >  {
> >      return stream_id >= s->snd_conf.streams ? NULL
> > -        : &s->pcm->pcm_params[stream_id];
> > +        : &s->streams[stream_id].params;
> >  }
> >
> >  /*
> > @@ -253,11 +272,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> >
> >  /*
> >   * Set the given stream params.
> > - * Called by both virtio_snd_handle_pcm_set_params and during device
> > - * initialization.
> >   * Returns the response status code. (VIRTIO_SND_S_*).
> >   *
> >   * @s: VirtIOSound device
> > + * @stream_id: stream id
> >   * @params: The PCM params as defined in the virtio specification
> >   */
> >  static
> > @@ -265,9 +283,10 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >                                     uint32_t stream_id,
> >                                     virtio_snd_pcm_set_params *params)
> >  {
> > +    VirtIOSoundPCMStream *stream;
> >      virtio_snd_pcm_set_params *st_params;
> >
> > -    if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
> > +    if (stream_id >= s->snd_conf.streams) {
> >          /*
> >           * TODO: do we need to set DEVICE_NEEDS_RESET?
> >           */
> > @@ -275,7 +294,17 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >      }
> >
> > -    st_params = virtio_snd_pcm_get_params(s, stream_id);
> > +    stream = virtio_snd_pcm_get_stream(s, stream_id);
> > +
> > +    switch (stream->state) {
> > +    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
> > +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> > +    case VSND_PCMSTREAM_STATE_PREPARED:
> > +    case VSND_PCMSTREAM_STATE_RELEASED:
> > +        break;
> > +    default:
> > +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +    }
> >
> >      if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
> >          error_report("Number of channels is not supported.");
> > @@ -290,6 +319,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >      }
> >
> > +    st_params = virtio_snd_pcm_get_params(s, stream_id);
> > +
> >      st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
> >      st_params->period_bytes = le32_to_cpu(params->period_bytes);
> >      st_params->features = le32_to_cpu(params->features);
> > @@ -298,6 +329,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >      st_params->format = params->format;
> >      st_params->rate = params->rate;
> >
> > +    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > +        /* implicit VIRTIO_SND_R_PCM_RELEASE */
> > +        virtio_snd_pcm_flush(stream);
> > +    }
> > +
> > +    stream->state = VSND_PCMSTREAM_STATE_PARAMS_SET;
> > +
> >      return cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -410,15 +448,12 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
> >   */
> >  static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
> >  {
> > -    if (stream) {
> > -        virtio_snd_pcm_flush(stream);
> > -        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> > -            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
> > -            stream->voice.out = NULL;
> > -        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
> > -            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
> > -            stream->voice.in = NULL;
> > -        }
> > +    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> > +        AUD_close_out(&stream->s->card, stream->voice.out);
> > +        stream->voice.out = NULL;
> > +    } else {
> > +        AUD_close_in(&stream->s->card, stream->voice.in);
> > +        stream->voice.in = NULL;
> >      }
> >  }
> >
> > @@ -435,33 +470,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
> >      virtio_snd_pcm_set_params *params;
> >      VirtIOSoundPCMStream *stream;
> >
> > -    if (s->pcm->streams == NULL ||
> > -        s->pcm->pcm_params == NULL ||
> > -        stream_id >= s->snd_conf.streams) {
> > +    stream = virtio_snd_pcm_get_stream(s, stream_id);
> > +    if (!stream) {
> >          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >      }
> >
> > -    params = virtio_snd_pcm_get_params(s, stream_id);
> > -    if (params == NULL) {
> > +    switch (stream->state) {
> > +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> > +    case VSND_PCMSTREAM_STATE_PREPARED:
> > +    case VSND_PCMSTREAM_STATE_RELEASED:
> > +        break;
> > +    default:
> >          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >      }
> >
> > -    stream = virtio_snd_pcm_get_stream(s, stream_id);
> > -    if (stream == NULL) {
> > -        stream = &s->streams[stream_id];
> > -        stream->active = false;
> > -        stream->pcm = s->pcm;
> > -
> > -        /*
> > -         * stream_id >= s->snd_conf.streams was checked before so this is
> > -         * in-bounds
> > -         */
> > -        s->pcm->streams[stream_id] = stream;
> > -    }
> > +    params = virtio_snd_pcm_get_params(s, stream_id);
> >
> >      virtio_snd_get_qemu_audsettings(&as, params);
> > -    stream->params = *params;
> > -
> >      stream->positions[0] = VIRTIO_SND_CHMAP_FL;
> >      stream->positions[1] = VIRTIO_SND_CHMAP_FR;
> >      stream->as = as;
> > @@ -484,6 +509,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
> >          AUD_set_volume_in(stream->voice.in, 0, 255, 255);
> >      }
> >
> > +    stream->state = VSND_PCMSTREAM_STATE_PREPARED;
> > +
> >      return cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -552,12 +579,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
> >      }
> >
> >      if (start) {
> > +        switch (stream->state) {
> > +        case VSND_PCMSTREAM_STATE_PREPARED:
> > +        case VSND_PCMSTREAM_STATE_STOPPED:
> > +            break;
> > +        default:
> > +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +        }
> > +
> >          trace_virtio_snd_handle_pcm_start(stream_id);
> > +        stream->state = VSND_PCMSTREAM_STATE_STARTED;
> >      } else {
> > +        switch (stream->state) {
> > +        case VSND_PCMSTREAM_STATE_STARTED:
> > +            break;
> > +        default:
> > +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +        }
> > +
> >          trace_virtio_snd_handle_pcm_stop(stream_id);
> > +        stream->state = VSND_PCMSTREAM_STATE_STOPPED;
> >      }
> >
> > -    stream->active = start;
> >      if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> >          AUD_set_active_out(stream->voice.out, start);
> >      } else {
> > @@ -644,15 +687,18 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
> >
> >      stream_id = le32_to_cpu(stream_id);
> >      trace_virtio_snd_handle_pcm_release(stream_id);
> > +
> >      stream = virtio_snd_pcm_get_stream(s, stream_id);
> > -    if (stream == NULL) {
> > -        /*
> > -         * TODO: do we need to set DEVICE_NEEDS_RESET?
> > -         */
> > -        error_report("already released stream %"PRIu32, stream_id);
> > -        virtio_error(VIRTIO_DEVICE(s),
> > -                     "already released stream %"PRIu32,
> > -                     stream_id);
> > +    if (!stream) {
> > +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +        return;
> > +    }
> > +
> > +    switch (stream->state) {
> > +    case VSND_PCMSTREAM_STATE_PREPARED:
> > +    case VSND_PCMSTREAM_STATE_STOPPED:
> > +        break;
> > +    default:
> >          cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >          return;
> >      }
> > @@ -671,6 +717,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
> >          virtio_snd_pcm_flush(stream);
> >      }
> >
> > +    stream->state = VSND_PCMSTREAM_STATE_RELEASED;
> > +
> >      cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -873,12 +921,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
> >          }
> >          stream_id = le32_to_cpu(hdr.stream_id);
> >
> > -        if (stream_id >= s->snd_conf.streams
> > -            || s->pcm->streams[stream_id] == NULL) {
> > +        if (stream_id >= s->snd_conf.streams) {
> >              goto tx_err;
> >          }
> >
> > -        stream = s->pcm->streams[stream_id];
> > +        stream = &s->streams[stream_id];
> >          if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
> >              goto tx_err;
> >          }
> > @@ -948,13 +995,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
> >          }
> >          stream_id = le32_to_cpu(hdr.stream_id);
> >
> > -        if (stream_id >= s->snd_conf.streams
> > -            || !s->pcm->streams[stream_id]) {
> > +        if (stream_id >= s->snd_conf.streams) {
> >              goto rx_err;
> >          }
> >
> > -        stream = s->pcm->streams[stream_id];
> > -        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
> > +        stream = &s->streams[stream_id];
> > +        if (stream->info.direction != VIRTIO_SND_D_INPUT) {
> >              goto rx_err;
> >          }
> >          size = iov_size(elem->in_sg, elem->in_num) -
> > @@ -1013,8 +1059,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
> >      ERRP_GUARD();
> >      VirtIOSound *vsnd = VIRTIO_SND(dev);
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > -    virtio_snd_pcm_set_params default_params = { 0 };
> > -    uint32_t status;
> >
> >      trace_virtio_snd_realize(vsnd);
> >
> > @@ -1052,6 +1096,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
> >          VirtIOSoundPCMStream *stream = &vsnd->streams[i];
> >
> >          stream->id = i;
> > +        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
> >          stream->s = vsnd;
> >          QSIMPLEQ_INIT(&stream->queue);
> >          stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
> > @@ -1065,23 +1110,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
> >          stream->info.channels_max = 2;
> >      }
> >
> > -    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
> > -    vsnd->pcm->snd = vsnd;
> > -    vsnd->pcm->streams =
> > -        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
> > -    vsnd->pcm->pcm_params =
> > -        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
> > -
> >      virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> >      virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> >
> > -    /* set default params for all streams */
> > -    default_params.features = 0;
> > -    default_params.buffer_bytes = cpu_to_le32(8192);
> > -    default_params.period_bytes = cpu_to_le32(2048);
> > -    default_params.channels = 2;
> > -    default_params.format = VIRTIO_SND_PCM_FMT_S16;
> > -    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
> >      vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
> >          virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
> >      vsnd->queues[VIRTIO_SND_VQ_EVENT] =
> > @@ -1091,28 +1122,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
> >      vsnd->queues[VIRTIO_SND_VQ_RX] =
> >          virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
> >      QTAILQ_INIT(&vsnd->cmdq);
> > -
> > -    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> > -        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
> > -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
> > -            error_setg(errp,
> > -                       "Can't initialize stream params, device responded with %s.",
> > -                       print_code(status));
> > -            goto error_cleanup;
> > -        }
> > -        status = virtio_snd_pcm_prepare(vsnd, i);
> > -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
> > -            error_setg(errp,
> > -                       "Can't prepare streams, device responded with %s.",
> > -                       print_code(status));
> > -            goto error_cleanup;
> > -        }
> > -    }
> > -
> > -    return;
> > -
> > -error_cleanup:
> > -    virtio_snd_unrealize(dev);
> >  }
> >
> >  static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
> > @@ -1154,7 +1163,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
> >          if (!virtio_queue_ready(buffer->vq)) {
> >              return;
> >          }
> > -        if (!stream->active) {
> > +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
> >              /* Stream has stopped, so do not perform AUD_write. */
> >              return_tx_buffer(stream, buffer);
> >              continue;
> > @@ -1246,7 +1255,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
> >          if (!virtio_queue_ready(buffer->vq)) {
> >              return;
> >          }
> > -        if (!stream->active) {
> > +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
> >              /* Stream has stopped, so do not perform AUD_read. */
> >              return_rx_buffer(stream, buffer);
> >              continue;
> > @@ -1306,19 +1315,14 @@ static void virtio_snd_unrealize(DeviceState *dev)
> >      trace_virtio_snd_unrealize(vsnd);
> >
> >      if (vsnd->streams) {
> > -        if (vsnd->pcm->streams) {
> > -            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> > -                stream = vsnd->pcm->streams[i];
> > -                if (stream) {
> > -                    virtio_snd_process_cmdq(stream->s);
> > -                    virtio_snd_pcm_close(stream);
> > -                }
> > +        virtio_snd_process_cmdq(vsnd);
> > +        for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> > +            stream = &vsnd->streams[i];
> > +            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > +                virtio_snd_pcm_flush(stream);
> >              }
> > -            g_free(vsnd->pcm->streams);
> > +            virtio_snd_pcm_close(stream);
> >          }
> > -        g_free(vsnd->pcm->pcm_params);
> > -        g_free(vsnd->pcm);
> > -        vsnd->pcm = NULL;
> >          g_free(vsnd->streams);
> >          vsnd->streams = NULL;
> >      }
> > @@ -1347,6 +1351,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
> >          VirtIOSoundPCMStream *stream = &s->streams[i];
> >          VirtIOSoundPCMBuffer *buffer;
> >
> > +        virtio_snd_pcm_close(stream);
> > +        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
> > +
> >          while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
> >              QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
> >              virtio_snd_pcm_buffer_free(buffer);
> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
> > index 95aef8192a..65afa6c184 100644
> > --- a/include/hw/audio/virtio-snd.h
> > +++ b/include/hw/audio/virtio-snd.h
> > @@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
> >
> >  typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
> >
> > -typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> > -
> >  typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
> >
> >  /*
> > @@ -121,34 +119,19 @@ struct VirtIOSoundPCMBuffer {
> >      uint8_t data[];
> >  };
> >
> > -struct VirtIOSoundPCM {
> > -    VirtIOSound *snd;
> > -    /*
> > -     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
> > -     * field, because the operation of PCM control requests is first
> > -     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
> > -     * means that some times we get parameters without having an allocated
> > -     * stream yet.
> > -     */
> > -    virtio_snd_pcm_set_params *pcm_params;
> > -    VirtIOSoundPCMStream **streams;
> > -};
> > -
> >  struct VirtIOSoundPCMStream {
> > -    VirtIOSoundPCM *pcm;
> >      virtio_snd_pcm_info info;
> >      virtio_snd_pcm_set_params params;
> >      uint32_t id;
> > +    uint32_t state;
> >      /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> >      uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> >      VirtIOSound *s;
> > -    bool flushing;
> >      audsettings as;
> >      union {
> >          SWVoiceIn *in;
> >          SWVoiceOut *out;
> >      } voice;
> > -    bool active;
> >      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> >  };
> >
> > @@ -214,7 +197,6 @@ struct VirtIOSound {
> >
> >      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> >      uint64_t features;
> > -    VirtIOSoundPCM *pcm;
> >      VirtIOSoundPCMStream *streams;
> >      QEMUSoundCard card;
> >      VMChangeStateEntry *vmstate;
> > --
> > 2.35.3
> >


