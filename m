Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B44CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9nY-0002Ld-S0; Tue, 21 Oct 2025 06:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vB9nT-0002LE-Ub
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:40:56 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vB9nP-0007rf-TG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:40:55 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-88f239686f2so713665085a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761043246; x=1761648046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDoGjpdUMqWOTTaOoDU0ZOXxGod/W9ttk3BYlxVue4I=;
 b=fPe89JazL64I9i8lxISOvCYvT3m0nSjfFxwgUNsaLw+pO2ONAlRWoCZ7t937mUdHXz
 XN/3mGfP5nZoQwMEq+aytUUSHdw4aVtMbFT7PeMu4YWC24XWPRzYxy1PSAnVlNxcPSUJ
 QhSRhn3LfXGjseqE0wsmsd6VDqooBsHV0GeWE7Q6/V2e8x037/i9d59je8tSu0ku3xGO
 i3Voa+Gu6twPKE29B7SC5+ZfKrJHWb1ciub7X4ZEGWAobcwgxhgJgfG8zCV8EVKHI8I5
 3yUAYlBdsa5xWWTaLDRC4zpu92yjUlCGxVsv+qZmKroRGN3oLtIKY3LpraoQa4HifHuc
 5CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761043246; x=1761648046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDoGjpdUMqWOTTaOoDU0ZOXxGod/W9ttk3BYlxVue4I=;
 b=bRyVH0zisl9NYLi0mnJrYiYovd3Y1Xa/bno9DK48D/+i5mmc6MVG4DeK+rrzRW6HdF
 7Fum+zVVZKHs/Vd0ZrePh5Up/7OUvh0nHSxoPz7JjmIMpGpG/Zhof5+jXeMRMa1Kjdxo
 3RVDgSWjyzBxVlQDMbntOHric36/0LaOBgHnUnwFR5MIf0/KU0S5vycv1237+jA9d9Ns
 ZEhySTWaRscGJcmuKnH3m5yuYi/zaWU8oxO6Seh0J0LkaII8aVFDuj2QW7YUrvPS7gbJ
 +nc5dcBfCgfB4rEY722Lv11V8PGQORaP6mOa3FdqU8uU4oEMnhPacSfIkhUegQpJoOBq
 wd+g==
X-Gm-Message-State: AOJu0Yy9R1lxQv/q6ABNWYN8+jQpZncgPJoYDVXXwuicDyv69DvxnZAT
 3oa7in2TLFMp8Bx3Hw74PeE6quvIUK7So3mwMBDtxMZYH+68YkbdreYh5RSfzNniXFteQ8OUReX
 k5AKi1k8xE0WgoI1MF3hood45PQ0img8=
X-Gm-Gg: ASbGncu9gDjdnj7ydG8YB1US/5egKswFYQjrwccbQ7r5Igfb94FJKrQ2tRUdv3g5id0
 R9TvKXbDoCvO1nbQ7XDgxKGbtMIDJP14vWEAnn+gycTVn7e/IdIiQT5SOXtMIwnF1cSMeamaBvL
 Vs4yEfExMSDJBjM/o9FlWP2tetqveZIp0UOpLmJRjBo/ksIsg+bo10RE6pUJraisMX1IHahvoxJ
 z3GYimVQNIeA5KoTWcFOh22e4aMQqQvIjYF26/N5vlvcMy7VucVjPQsGsZIJCbLV9qVJCmeVP1/
 YULzzwxIpZZmJo05bFtNiBgHp8U=
X-Google-Smtp-Source: AGHT+IHM6kejM683QmBaiEdoy7WXgdmqzNg8T1fF1aFzw7JxpakRQpfSpQqq6ptqI2zjoOitPQ8zm7L7GZnPOghHrRc=
X-Received: by 2002:a05:622a:4203:b0:4e8:a6c3:430c with SMTP id
 d75a77b69052e-4e8a6c343f9mr173123081cf.66.1761043246017; Tue, 21 Oct 2025
 03:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-35-marcandre.lureau@redhat.com>
 <1bd34160-d034-465b-a1ac-0e734ed40484@redhat.com>
 <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
In-Reply-To: <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Oct 2025 14:40:34 +0400
X-Gm-Features: AS18NWA7lzAXHYUrvs403M-ev39LIZ8IPChqfkSejT64Dj0yFOfUO6-uXvbecqM
Message-ID: <CAJ+F1CLoaufD_1tFUd_1uckWZLXVQ7E-GpRDZRDXtfi6unBw7A@mail.gmail.com>
Subject: Re: [PATCH 34/43] audio: rename AudioState -> AudioBE
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Oct 21, 2025 at 1:42=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 10/21/25 11:30, Paolo Bonzini wrote:
> > On 10/21/25 11:03, marcandre.lureau@redhat.com wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Naming is hard. But in general in QEMU, a host "backend" is the term
> >> used to fullfill the request made by the device "frontend".
> >>
> >> Note that "audiodev" is the corresponding QAPI type name (or
> >> configuration).
> >
> > BE and FE aren't used in existing code though.  Looking at current use:

There is a top-level backends/ though. I meant to say that it's
usually clearer for everyone when we talk about "backend" vs
"frontend" (or not?), and I wish we would follow that naming more in
the code.

> >
> > - BlockDriverState*/BlockBackend*
> >

I am not very familiar with the block subsystem, but it is seems
BlockBackend is actually the backend and BlockDriverState is
implementation data detail. Correct me if I'm wrong

> > - Chardev*/CharBackend
> >

Those are actually always confusing... and I remember I attempted to
rename it in the past... CharBackend is the front-end side..

> > - NetClientState*/NICState*
> >
> > ... it's actually quite common for the *frontend* to have a pointer or
> > object of type FooBackend; that would give Audiodev* and AudioBackend*.
>
> Hmm, I have to correct myself.
>
> QEMUSoundCard's name field is basically unused, and QEMUSoundCard should
> be just an Audiodev*.  There's no need for a separate AudioFE struct.
>

For audio, it's pretty obvious that we have "backend" object to
implement the host audio subsystem details, while "QEMUSoundCard" is
the "frontend", or "client/user" context.

Imho, it's clearer to see the relation between the two objects if we
name them "backend" and "frontend" accordingly. If the "AudioBE" &
"AudioFE" short versions aren't readable enough, I am fine naming
"AudioBackend" & "AudioFrontend"

> Paolo
>
> > Paolo
> >
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>   audio/audio.h                    | 18 +++----
> >>   audio/audio_int.h                | 20 +++----
> >>   audio/audio_template.h           | 20 +++----
> >>   ui/vnc.h                         |  2 +-
> >>   audio/alsaaudio.c                |  2 +-
> >>   audio/audio-hmp-cmds.c           |  2 +-
> >>   audio/audio.c                    | 90 ++++++++++++++++--------------=
--
> >>   audio/dbusaudio.c                |  8 +--
> >>   audio/ossaudio.c                 |  4 +-
> >>   audio/wavcapture.c               |  2 +-
> >>   hw/audio/pcspk.c                 |  2 +-
> >>   hw/core/machine.c                |  2 +-
> >>   hw/core/qdev-properties-system.c |  6 +--
> >>   ui/dbus.c                        |  8 +--
> >>   ui/vnc.c                         | 10 ++--
> >>   15 files changed, 98 insertions(+), 98 deletions(-)
> >>
> >> diff --git a/audio/audio.h b/audio/audio.h
> >> index 1858b930ca..845e078169 100644
> >> --- a/audio/audio.h
> >> +++ b/audio/audio.h
> >> @@ -64,15 +64,15 @@ typedef struct SWVoiceOut SWVoiceOut;
> >>   typedef struct CaptureVoiceOut CaptureVoiceOut;
> >>   typedef struct SWVoiceIn SWVoiceIn;
> >> -typedef struct AudioStateClass AudioStateClass;
> >> -struct AudioStateClass {
> >> +typedef struct AudioBEClass AudioBEClass;
> >> +struct AudioBEClass {
> >>       ObjectClass parent_class;
> >>   };
> >> -typedef struct AudioState AudioState;
> >> +typedef struct AudioBE AudioBE;
> >>   typedef struct QEMUSoundCard {
> >>       char *name;
> >> -    AudioState *state;
> >> +    AudioBE *be;
> >>       QLIST_ENTRY (QEMUSoundCard) entries;
> >>   } QEMUSoundCard;
> >> @@ -83,7 +83,7 @@ typedef struct QEMUAudioTimeStamp {
> >>   bool AUD_register_card (const char *name, QEMUSoundCard *card, Error
> >> **errp);
> >>   void AUD_remove_card (QEMUSoundCard *card);
> >>   CaptureVoiceOut *AUD_add_capture(
> >> -    AudioState *s,
> >> +    AudioBE *s,
> >>       struct audsettings *as,
> >>       struct audio_capture_ops *ops,
> >>       void *opaque
> >> @@ -154,14 +154,14 @@ void audio_create_default_audiodevs(void);
> >>   void audio_init_audiodevs(void);
> >>   void audio_help(void);
> >> -AudioState *audio_state_by_name(const char *name, Error **errp);
> >> -AudioState *audio_get_default_audio_state(Error **errp);
> >> +AudioBE *audio_be_by_name(const char *name, Error **errp);
> >> +AudioBE *audio_get_default_audio_be(Error **errp);
> >>   const char *audio_get_id(QEMUSoundCard *card);
> >>   #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
> >>       DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
> >> -#define TYPE_AUDIO_STATE "audio-state"
> >> -OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)
> >> +#define TYPE_AUDIO_BE "audio-be"
> >> +OBJECT_DECLARE_TYPE(AudioBE, AudioBEClass, AUDIO_BE)
> >>   #endif /* QEMU_AUDIO_H */
> >> diff --git a/audio/audio_int.h b/audio/audio_int.h
> >> index cc7a6fe087..d7e24ec089 100644
> >> --- a/audio/audio_int.h
> >> +++ b/audio/audio_int.h
> >> @@ -57,7 +57,7 @@ struct audio_pcm_info {
> >>       int swap_endianness;
> >>   };
> >> -typedef struct AudioState AudioState;
> >> +typedef struct AudioBE AudioBE;
> >>   typedef struct SWVoiceCap SWVoiceCap;
> >>   typedef struct STSampleBuffer {
> >> @@ -66,7 +66,7 @@ typedef struct STSampleBuffer {
> >>   } STSampleBuffer;
> >>   typedef struct HWVoiceOut {
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>       int enabled;
> >>       int poll_mode;
> >>       int pending_disable;
> >> @@ -87,7 +87,7 @@ typedef struct HWVoiceOut {
> >>   } HWVoiceOut;
> >>   typedef struct HWVoiceIn {
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>       int enabled;
> >>       int poll_mode;
> >>       struct audio_pcm_info info;
> >> @@ -109,7 +109,7 @@ typedef struct HWVoiceIn {
> >>   struct SWVoiceOut {
> >>       QEMUSoundCard *card;
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>       struct audio_pcm_info info;
> >>       t_sample *conv;
> >>       STSampleBuffer resample_buf;
> >> @@ -126,7 +126,7 @@ struct SWVoiceOut {
> >>   struct SWVoiceIn {
> >>       QEMUSoundCard *card;
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>       int active;
> >>       struct audio_pcm_info info;
> >>       void *rate;
> >> @@ -147,7 +147,7 @@ struct audio_driver {
> >>       void *(*init) (Audiodev *, Error **);
> >>       void (*fini) (void *);
> >>   #ifdef CONFIG_GIO
> >> -    void (*set_dbus_server) (AudioState *s, GDBusObjectManagerServer
> >> *manager, bool p2p);
> >> +    void (*set_dbus_server) (AudioBE *s, GDBusObjectManagerServer
> >> *manager, bool p2p);
> >>   #endif
> >>       struct audio_pcm_ops *pcm_ops;
> >>       int max_voices_out;
> >> @@ -206,7 +206,7 @@ static inline void *advance (void *p, int incr)
> >>       return (d + incr);
> >>   }
> >> -int wav_start_capture(AudioState *state, CaptureState *s, const char
> >> *path,
> >> +int wav_start_capture(AudioBE *state, CaptureState *s, const char *pa=
th,
> >>                         int freq, int bits, int nchannels);
> >>   void audio_generic_run_buffer_in(HWVoiceIn *hw);
> >> @@ -238,7 +238,7 @@ struct SWVoiceCap {
> >>       QLIST_ENTRY (SWVoiceCap) entries;
> >>   };
> >> -typedef struct AudioState {
> >> +typedef struct AudioBE {
> >>       Object parent;
> >>       struct audio_driver *drv;
> >> @@ -258,7 +258,7 @@ typedef struct AudioState {
> >>       bool timer_running;
> >>       uint64_t timer_last;
> >>       VMChangeStateEntry *vmse;
> >> -} AudioState;
> >> +} AudioBE;
> >>   extern const struct mixeng_volume nominal_volume;
> >> @@ -271,7 +271,7 @@ void audio_pcm_info_clear_buf (struct
> >> audio_pcm_info *info, void *buf, int len);
> >>   int audio_bug (const char *funcname, int cond);
> >> -void audio_run(AudioState *s, const char *msg);
> >> +void audio_run(AudioBE *s, const char *msg);
> >>   const char *audio_application_name(void);
> >> diff --git a/audio/audio_template.h b/audio/audio_template.h
> >> index c29d79c443..c8f3e9dc93 100644
> >> --- a/audio/audio_template.h
> >> +++ b/audio/audio_template.h
> >> @@ -36,7 +36,7 @@
> >>   #define HWBUF hw->conv_buf
> >>   #endif
> >> -static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
> >> +static void glue(audio_init_nb_voices_, TYPE)(AudioBE *s,
> >>                                                 struct audio_driver
> >> *drv, int min_voices)
> >>   {
> >>       int max_voices =3D glue (drv->max_voices_, TYPE);
> >> @@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW
> >> *sw)
> >>   static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
> >>   {
> >>       HW *hw =3D *hwp;
> >> -    AudioState *s =3D hw->s;
> >> +    AudioBE *s =3D hw->s;
> >>       if (!hw->sw_head.lh_first) {
> >>   #ifdef DAC
> >> @@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW
> >> **hwp)
> >>       }
> >>   }
> >> -static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioState *s, HW *hw)
> >> +static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBE *s, HW *hw)
> >>   {
> >>       return hw ? hw->entries.le_next : glue (s->hw_head_,
> >> TYPE).lh_first;
> >>   }
> >> -static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s,
> >> HW *hw)
> >> +static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBE *s, HW
> >> *hw)
> >>   {
> >>       while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
> >>           if (hw->enabled) {
> >> @@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_,
> >> TYPE)(AudioState *s, HW *hw)
> >>       return NULL;
> >>   }
> >> -static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW
> >> *hw,
> >> +static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBE *s, HW *hw=
,
> >>                                                      struct
> >> audsettings *as)
> >>   {
> >>       while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
> >> @@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)
> >> (AudioState *s, HW *hw,
> >>       return NULL;
> >>   }
> >> -static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
> >> +static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBE *s,
> >>                                                struct audsettings *as)
> >>   {
> >>       HW *hw;
> >> @@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_,
> >> TYPE)(Audiodev *dev)
> >>       abort();
> >>   }
> >> -static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct
> >> audsettings *as)
> >> +static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBE *s, struct
> >> audsettings *as)
> >>   {
> >>       HW *hw;
> >>       AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(=
s-
> >> >dev);
> >> @@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)
> >> (AudioState *s, struct audsettings *as)
> >>   }
> >>   static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
> >> -    AudioState *s,
> >> +    AudioBE *s,
> >>       const char *sw_name,
> >>       struct audsettings *as
> >>       )
> >> @@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
> >>       struct audsettings *as
> >>       )
> >>   {
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>       AudiodevPerDirectionOptions *pdo;
> >>       if (audio_bug(__func__, !card || !name || !callback_fn || !as)) =
{
> >> @@ -503,7 +503,7 @@ SW *glue (AUD_open_, TYPE) (
> >>           goto fail;
> >>       }
> >> -    s =3D card->state;
> >> +    s =3D card->be;
> >>       pdo =3D glue(audio_get_pdo_, TYPE)(s->dev);
> >>       ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
> >> diff --git a/ui/vnc.h b/ui/vnc.h
> >> index f2dab2f4d9..a6aac50ec3 100644
> >> --- a/ui/vnc.h
> >> +++ b/ui/vnc.h
> >> @@ -184,7 +184,7 @@ struct VncDisplay
> >>       VncDisplaySASL sasl;
> >>   #endif
> >> -    AudioState *audio_state;
> >> +    AudioBE *audio_be;
> >>       VMChangeStateEntry *vmstate_handler_entry;
> >>   };
> >> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> >> index 9b6c01c0ef..1c762e0e24 100644
> >> --- a/audio/alsaaudio.c
> >> +++ b/audio/alsaaudio.c
> >> @@ -41,7 +41,7 @@ struct pollhlp {
> >>       struct pollfd *pfds;
> >>       int count;
> >>       int mask;
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>   };
> >>   typedef struct ALSAVoiceOut {
> >> diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
> >> index 819f8fa9d8..f7a7d0c947 100644
> >> --- a/audio/audio-hmp-cmds.c
> >> +++ b/audio/audio-hmp-cmds.c
> >> @@ -67,7 +67,7 @@ void hmp_wavcapture(Monitor *mon, const QDict *qdict=
)
> >>       const char *audiodev =3D qdict_get_str(qdict, "audiodev");
> >>       CaptureState *s;
> >>       Error *local_err =3D NULL;
> >> -    AudioState *as =3D audio_state_by_name(audiodev, &local_err);
> >> +    AudioBE *as =3D audio_be_by_name(audiodev, &local_err);
> >>       if (!as) {
> >>           error_report_err(local_err);
> >> diff --git a/audio/audio.c b/audio/audio.c
> >> index 9e6d79b4e3..66a2e86f13 100644
> >> --- a/audio/audio.c
> >> +++ b/audio/audio.c
> >> @@ -99,7 +99,7 @@ static audio_driver *audio_driver_lookup(const char
> >> *name)
> >>       return NULL;
> >>   }
> >> -static AudioState *default_audio_state;
> >> +static AudioBE *default_audio_be;
> >>   const struct mixeng_volume nominal_volume =3D {
> >>       .mute =3D 0,
> >> @@ -380,7 +380,7 @@ void audio_pcm_info_clear_buf (struct
> >> audio_pcm_info *info, void *buf, int len)
> >>   /*
> >>    * Capture
> >>    */
> >> -static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioState *s=
,
> >> +static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBE *s,
> >>                                                           struct
> >> audsettings *as)
> >>   {
> >>       CaptureVoiceOut *cap;
> >> @@ -460,7 +460,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
> >>   static int audio_attach_capture (HWVoiceOut *hw)
> >>   {
> >> -    AudioState *s =3D hw->s;
> >> +    AudioBE *s =3D hw->s;
> >>       CaptureVoiceOut *cap;
> >>       audio_detach_capture (hw);
> >> @@ -798,7 +798,7 @@ static void audio_pcm_print_info (const char *cap,
> >> struct audio_pcm_info *info)
> >>   /*
> >>    * Timer
> >>    */
> >> -static int audio_is_timer_needed(AudioState *s)
> >> +static int audio_is_timer_needed(AudioBE *s)
> >>   {
> >>       HWVoiceIn *hwi =3D NULL;
> >>       HWVoiceOut *hwo =3D NULL;
> >> @@ -816,7 +816,7 @@ static int audio_is_timer_needed(AudioState *s)
> >>       return 0;
> >>   }
> >> -static void audio_reset_timer (AudioState *s)
> >> +static void audio_reset_timer (AudioBE *s)
> >>   {
> >>       if (audio_is_timer_needed(s)) {
> >>           timer_mod_anticipate_ns(s->ts,
> >> @@ -838,7 +838,7 @@ static void audio_reset_timer (AudioState *s)
> >>   static void audio_timer (void *opaque)
> >>   {
> >>       int64_t now, diff;
> >> -    AudioState *s =3D opaque;
> >> +    AudioBE *s =3D opaque;
> >>       now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >>       diff =3D now - s->timer_last;
> >> @@ -921,7 +921,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
> >>       hw =3D sw->hw;
> >>       if (sw->active !=3D on) {
> >> -        AudioState *s =3D sw->s;
> >> +        AudioBE *s =3D sw->s;
> >>           SWVoiceOut *temp_sw;
> >>           SWVoiceCap *sc;
> >> @@ -969,7 +969,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
> >>       hw =3D sw->hw;
> >>       if (sw->active !=3D on) {
> >> -        AudioState *s =3D sw->s;
> >> +        AudioBE *s =3D sw->s;
> >>           SWVoiceIn *temp_sw;
> >>           if (on) {
> >> @@ -1137,7 +1137,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut
> >> *hw, size_t live)
> >>       return clipped;
> >>   }
> >> -static void audio_run_out (AudioState *s)
> >> +static void audio_run_out (AudioBE *s)
> >>   {
> >>       HWVoiceOut *hw =3D NULL;
> >>       SWVoiceOut *sw;
> >> @@ -1291,7 +1291,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw,
> >> size_t samples)
> >>       return conv;
> >>   }
> >> -static void audio_run_in (AudioState *s)
> >> +static void audio_run_in (AudioBE *s)
> >>   {
> >>       HWVoiceIn *hw =3D NULL;
> >> @@ -1339,7 +1339,7 @@ static void audio_run_in (AudioState *s)
> >>       }
> >>   }
> >> -static void audio_run_capture (AudioState *s)
> >> +static void audio_run_capture (AudioBE *s)
> >>   {
> >>       CaptureVoiceOut *cap;
> >> @@ -1386,7 +1386,7 @@ static void audio_run_capture (AudioState *s)
> >>       }
> >>   }
> >> -void audio_run(AudioState *s, const char *msg)
> >> +void audio_run(AudioBE *s, const char *msg)
> >>   {
> >>       audio_run_out(s);
> >>       audio_run_in(s);
> >> @@ -1559,7 +1559,7 @@ size_t audio_generic_read(HWVoiceIn *hw, void
> >> *buf, size_t size)
> >>       return total;
> >>   }
> >> -static bool audio_driver_init(AudioState *s, struct audio_driver *drv=
,
> >> +static bool audio_driver_init(AudioBE *s, struct audio_driver *drv,
> >>                                 Audiodev *dev, Error **errp)
> >>   {
> >>       s->drv_opaque =3D drv->init(dev, errp);
> >> @@ -1592,7 +1592,7 @@ static bool audio_driver_init(AudioState *s,
> >> struct audio_driver *drv,
> >>   static void audio_vm_change_state_handler (void *opaque, bool runnin=
g,
> >>                                              RunState state)
> >>   {
> >> -    AudioState *s =3D opaque;
> >> +    AudioBE *s =3D opaque;
> >>       HWVoiceOut *hwo =3D NULL;
> >>       HWVoiceIn *hwi =3D NULL;
> >> @@ -1613,9 +1613,9 @@ static void audio_vm_change_state_handler (void
> >> *opaque, bool running,
> >>   static const VMStateDescription vmstate_audio;
> >> -static void audio_state_init(Object *obj)
> >> +static void audio_be_init(Object *obj)
> >>   {
> >> -    AudioState *s =3D AUDIO_STATE(obj);
> >> +    AudioBE *s =3D AUDIO_BE(obj);
> >>       QLIST_INIT (&s->hw_head_out);
> >>       QLIST_INIT (&s->hw_head_in);
> >> @@ -1629,9 +1629,9 @@ static void audio_state_init(Object *obj)
> >>       vmstate_register_any(NULL, &vmstate_audio, s);
> >>   }
> >> -static void audio_state_finalize(Object *obj)
> >> +static void audio_be_finalize(Object *obj)
> >>   {
> >> -    AudioState *s =3D AUDIO_STATE(obj);
> >> +    AudioBE *s =3D AUDIO_BE(obj);
> >>       HWVoiceOut *hwo, *hwon;
> >>       HWVoiceIn *hwi, *hwin;
> >> @@ -1692,7 +1692,7 @@ static Object *get_audiodevs_root(void)
> >>   void audio_cleanup(void)
> >>   {
> >> -    default_audio_state =3D NULL;
> >> +    default_audio_be =3D NULL;
> >>       object_unparent(get_audiodevs_root());
> >>   }
> >> @@ -1743,14 +1743,14 @@ void audio_create_default_audiodevs(void)
> >>    * if dev =3D=3D NULL =3D> legacy implicit initialization, return th=
e
> >> already created
> >>    *   state or create a new one
> >>    */
> >> -static AudioState *audio_init(Audiodev *dev, Error **errp)
> >> +static AudioBE *audio_init(Audiodev *dev, Error **errp)
> >>   {
> >>       int done =3D 0;
> >>       const char *drvname;
> >> -    AudioState *s;
> >> +    AudioBE *s;
> >>       struct audio_driver *driver;
> >> -    s =3D AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
> >> +    s =3D AUDIO_BE(object_new(TYPE_AUDIO_BE));
> >>       if (dev) {
> >>           /* -audiodev option */
> >> @@ -1766,7 +1766,7 @@ static AudioState *audio_init(Audiodev *dev,
> >> Error **errp)
> >>               goto out;
> >>           }
> >>       } else {
> >> -        assert(!default_audio_state);
> >> +        assert(!default_audio_be);
> >>           for (;;) {
> >>               AudiodevListEntry *e =3D QSIMPLEQ_FIRST(&default_audiode=
vs);
> >>               if (!e) {
> >> @@ -1797,11 +1797,11 @@ out:
> >>       return NULL;
> >>   }
> >> -AudioState *audio_get_default_audio_state(Error **errp)
> >> +AudioBE *audio_get_default_audio_be(Error **errp)
> >>   {
> >> -    if (!default_audio_state) {
> >> -        default_audio_state =3D audio_init(NULL, errp);
> >> -        if (!default_audio_state) {
> >> +    if (!default_audio_be) {
> >> +        default_audio_be =3D audio_init(NULL, errp);
> >> +        if (!default_audio_be) {
> >>               if (!QSIMPLEQ_EMPTY(&audiodevs)) {
> >>                   error_append_hint(errp, "Perhaps you wanted to use -
> >> audio or set audiodev=3D%s?\n",
> >>                                     QSIMPLEQ_FIRST(&audiodevs)->dev->i=
d);
> >> @@ -1809,21 +1809,21 @@ AudioState
> >> *audio_get_default_audio_state(Error **errp)
> >>           }
> >>       }
> >> -    return default_audio_state;
> >> +    return default_audio_be;
> >>   }
> >>   bool AUD_register_card (const char *name, QEMUSoundCard *card, Error
> >> **errp)
> >>   {
> >> -    if (!card->state) {
> >> -        card->state =3D audio_get_default_audio_state(errp);
> >> -        if (!card->state) {
> >> +    if (!card->be) {
> >> +        card->be =3D audio_get_default_audio_be(errp);
> >> +        if (!card->be) {
> >>               return false;
> >>           }
> >>       }
> >>       card->name =3D g_strdup (name);
> >>       memset (&card->entries, 0, sizeof (card->entries));
> >> -    QLIST_INSERT_HEAD(&card->state->card_head, card, entries);
> >> +    QLIST_INSERT_HEAD(&card->be->card_head, card, entries);
> >>       return true;
> >>   }
> >> @@ -1837,7 +1837,7 @@ void AUD_remove_card (QEMUSoundCard *card)
> >>   static struct audio_pcm_ops capture_pcm_ops;
> >>   CaptureVoiceOut *AUD_add_capture(
> >> -    AudioState *s,
> >> +    AudioBE *s,
> >>       struct audsettings *as,
> >>       struct audio_capture_ops *ops,
> >>       void *cb_opaque
> >> @@ -2220,7 +2220,7 @@ int
> >> audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
> >>           audioformat_bytes_per_sample(as->fmt);
> >>   }
> >> -AudioState *audio_state_by_name(const char *name, Error **errp)
> >> +AudioBE *audio_be_by_name(const char *name, Error **errp)
> >>   {
> >>       Object *obj =3D
> >> object_resolve_path_component(get_audiodevs_root(), name);
> >> @@ -2228,15 +2228,15 @@ AudioState *audio_state_by_name(const char
> >> *name, Error **errp)
> >>           error_setg(errp, "audiodev '%s' not found", name);
> >>           return NULL;
> >>       } else {
> >> -        return AUDIO_STATE(obj);
> >> +        return AUDIO_BE(obj);
> >>       }
> >>   }
> >>   const char *audio_get_id(QEMUSoundCard *card)
> >>   {
> >> -    if (card->state) {
> >> -        assert(card->state->dev);
> >> -        return card->state->dev->id;
> >> +    if (card->be) {
> >> +        assert(card->be->dev);
> >> +        return card->be->dev->id;
> >>       } else {
> >>           return "";
> >>       }
> >> @@ -2305,19 +2305,19 @@ AudiodevList *qmp_query_audiodevs(Error **errp=
)
> >>       return ret;
> >>   }
> >> -static const TypeInfo audio_state_info =3D {
> >> -    .name =3D TYPE_AUDIO_STATE,
> >> +static const TypeInfo audio_be_info =3D {
> >> +    .name =3D TYPE_AUDIO_BE,
> >>       .parent =3D TYPE_OBJECT,
> >> -    .instance_size =3D sizeof(AudioState),
> >> -    .instance_init =3D audio_state_init,
> >> -    .instance_finalize =3D audio_state_finalize,
> >> +    .instance_size =3D sizeof(AudioBE),
> >> +    .instance_init =3D audio_be_init,
> >> +    .instance_finalize =3D audio_be_finalize,
> >>       .abstract =3D false, // todo, subclass and make it abstract
> >> -    .class_size =3D sizeof(AudioStateClass),
> >> +    .class_size =3D sizeof(AudioBEClass),
> >>   };
> >>   static void register_types(void)
> >>   {
> >> -    type_register_static(&audio_state_info);
> >> +    type_register_static(&audio_be_info);
> >>   }
> >>   type_init(register_types);
> >> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> >> index 908214a170..873f76a89e 100644
> >> --- a/audio/dbusaudio.c
> >> +++ b/audio/dbusaudio.c
> >> @@ -458,7 +458,7 @@ listener_in_vanished_cb(GDBusConnection *connectio=
n,
> >>   }
> >>   static gboolean
> >> -dbus_audio_register_listener(AudioState *s,
> >> +dbus_audio_register_listener(AudioBE *s,
> >>                                GDBusMethodInvocation *invocation,
> >>   #ifdef G_OS_UNIX
> >>                                GUnixFDList *fd_list,
> >> @@ -615,7 +615,7 @@ dbus_audio_register_listener(AudioState *s,
> >>   }
> >>   static gboolean
> >> -dbus_audio_register_out_listener(AudioState *s,
> >> +dbus_audio_register_out_listener(AudioBE *s,
> >>                                    GDBusMethodInvocation *invocation,
> >>   #ifdef G_OS_UNIX
> >>                                    GUnixFDList *fd_list,
> >> @@ -631,7 +631,7 @@ dbus_audio_register_out_listener(AudioState *s,
> >>   }
> >>   static gboolean
> >> -dbus_audio_register_in_listener(AudioState *s,
> >> +dbus_audio_register_in_listener(AudioBE *s,
> >>                                   GDBusMethodInvocation *invocation,
> >>   #ifdef G_OS_UNIX
> >>                                   GUnixFDList *fd_list,
> >> @@ -646,7 +646,7 @@ dbus_audio_register_in_listener(AudioState *s,
> >>   }
> >>   static void
> >> -dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer
> >> *server, bool p2p)
> >> +dbus_audio_set_server(AudioBE *s, GDBusObjectManagerServer *server,
> >> bool p2p)
> >>   {
> >>       DBusAudio *da =3D s->drv_opaque;
> >> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> >> index c5858284a1..f202e743ff 100644
> >> --- a/audio/ossaudio.c
> >> +++ b/audio/ossaudio.c
> >> @@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
> >>   static void oss_helper_poll_out (void *opaque)
> >>   {
> >> -    AudioState *s =3D opaque;
> >> +    AudioBE *s =3D opaque;
> >>       audio_run(s, "oss_poll_out");
> >>   }
> >>   static void oss_helper_poll_in (void *opaque)
> >>   {
> >> -    AudioState *s =3D opaque;
> >> +    AudioBE *s =3D opaque;
> >>       audio_run(s, "oss_poll_in");
> >>   }
> >> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> >> index 0fbc695d23..55ba0906a2 100644
> >> --- a/audio/wavcapture.c
> >> +++ b/audio/wavcapture.c
> >> @@ -103,7 +103,7 @@ static struct capture_ops wav_capture_ops =3D {
> >>       .info =3D wav_capture_info
> >>   };
> >> -int wav_start_capture(AudioState *state, CaptureState *s, const char
> >> *path,
> >> +int wav_start_capture(AudioBE *state, CaptureState *s, const char *pa=
th,
> >>                         int freq, int bits, int nchannels)
> >>   {
> >>       WAVState *wav;
> >> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> >> index c8c63b7915..e9ab5ac41b 100644
> >> --- a/hw/audio/pcspk.c
> >> +++ b/hw/audio/pcspk.c
> >> @@ -188,7 +188,7 @@ static void pcspk_realizefn(DeviceState *dev,
> >> Error **errp)
> >>       isa_register_ioport(isadev, &s->ioport, s->iobase);
> >> -    if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
> >> +    if (s->card.be && AUD_register_card(s_spk, &s->card, errp)) {
> >>           pcspk_audio_init(s);
> >>       }
> >>   }
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 681adbb7ac..2de8b89606 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -763,7 +763,7 @@ static void machine_set_audiodev(Object *obj,
> >> const char *value,
> >>   {
> >>       MachineState *ms =3D MACHINE(obj);
> >> -    if (!audio_state_by_name(value, errp)) {
> >> +    if (!audio_be_by_name(value, errp)) {
> >>           return;
> >>       }
> >> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-
> >> properties-system.c
> >> index 1f810b7ddf..be682895f7 100644
> >> --- a/hw/core/qdev-properties-system.c
> >> +++ b/hw/core/qdev-properties-system.c
> >> @@ -499,16 +499,16 @@ static void set_audiodev(Object *obj, Visitor
> >> *v, const char* name,
> >>   {
> >>       const Property *prop =3D opaque;
> >>       QEMUSoundCard *card =3D object_field_prop_ptr(obj, prop);
> >> -    AudioState *state;
> >> +    AudioBE *state;
> >>       g_autofree char *str =3D NULL;
> >>       if (!visit_type_str(v, name, &str, errp)) {
> >>           return;
> >>       }
> >> -    state =3D audio_state_by_name(str, errp);
> >> +    state =3D audio_be_by_name(str, errp);
> >>       if (state) {
> >> -        card->state =3D state;
> >> +        card->be =3D state;
> >>       }
> >>   }
> >> diff --git a/ui/dbus.c b/ui/dbus.c
> >> index dd0336702d..962b4a8c1e 100644
> >> --- a/ui/dbus.c
> >> +++ b/ui/dbus.c
> >> @@ -220,16 +220,16 @@ dbus_display_complete(UserCreatable *uc, Error
> >> **errp)
> >>       }
> >>       if (dd->audiodev && *dd->audiodev) {
> >> -        AudioState *audio_state =3D audio_state_by_name(dd->audiodev,
> >> errp);
> >> -        if (!audio_state) {
> >> +        AudioBE *audio_be =3D audio_be_by_name(dd->audiodev, errp);
> >> +        if (!audio_be) {
> >>               return;
> >>           }
> >> -        if (!g_str_equal(audio_state->drv->name, "dbus")) {
> >> +        if (!g_str_equal(audio_be->drv->name, "dbus")) {
> >>               error_setg(errp, "Audiodev '%s' is not compatible with
> >> DBus",
> >>                          dd->audiodev);
> >>               return;
> >>           }
> >> -        audio_state->drv->set_dbus_server(audio_state, dd->server,
> >> dd->p2p);
> >> +        audio_be->drv->set_dbus_server(audio_be, dd->server, dd->p2p)=
;
> >>       }
> >>       consoles =3D g_array_new(FALSE, FALSE, sizeof(guint32));
> >> diff --git a/ui/vnc.c b/ui/vnc.c
> >> index 77c823bf2e..0094ec680c 100644
> >> --- a/ui/vnc.c
> >> +++ b/ui/vnc.c
> >> @@ -1276,7 +1276,7 @@ static void audio_add(VncState *vs)
> >>       ops.destroy =3D audio_capture_destroy;
> >>       ops.capture =3D audio_capture;
> >> -    vs->audio_cap =3D AUD_add_capture(vs->vd->audio_state, &vs->as,
> >> &ops, vs);
> >> +    vs->audio_cap =3D AUD_add_capture(vs->vd->audio_be, &vs->as, &ops=
,
> >> vs);
> >>       if (!vs->audio_cap) {
> >>           error_report("Failed to add audio capture");
> >>       }
> >> @@ -2193,7 +2193,7 @@ static void set_encodings(VncState *vs, int32_t
> >> *encodings, size_t n_encodings)
> >>               send_ext_key_event_ack(vs);
> >>               break;
> >>           case VNC_ENCODING_AUDIO:
> >> -            if (vs->vd->audio_state) {
> >> +            if (vs->vd->audio_be) {
> >>                   vnc_set_feature(vs, VNC_FEATURE_AUDIO);
> >>                   send_ext_audio_ack(vs);
> >>               }
> >> @@ -4236,12 +4236,12 @@ void vnc_display_open(const char *id, Error
> >> **errp)
> >>       audiodev =3D qemu_opt_get(opts, "audiodev");
> >>       if (audiodev) {
> >> -        vd->audio_state =3D audio_state_by_name(audiodev, errp);
> >> -        if (!vd->audio_state) {
> >> +        vd->audio_be =3D audio_be_by_name(audiodev, errp);
> >> +        if (!vd->audio_be) {
> >>               goto fail;
> >>           }
> >>       } else {
> >> -        vd->audio_state =3D audio_get_default_audio_state(NULL);
> >> +        vd->audio_be =3D audio_get_default_audio_be(NULL);
> >>       }
> >>       device_id =3D qemu_opt_get(opts, "display");
> >
> >
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau

