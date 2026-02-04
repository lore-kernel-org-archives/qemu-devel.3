Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5D3E9D3E3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vndrN-00062g-MU; Wed, 04 Feb 2026 09:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vndrL-0005uB-BB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vndrI-0004JS-58
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770215274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L33gbMFZr8W2mA2dSY1kSu0fg4By4qfgVDrm4Ftr6Pc=;
 b=g/iNS4s1aiY3qDXyyZ+yS8eWUSK1NUNs+DYRIAqhg2r5T5N/gNtx9MWwJTPDv88/OhBPYw
 XjlnuBvmT3GHvZPMf3kFOY7i8z9/KdYcViBGbtdMOcs7SVxV37Rpe908ThdF76bo/T7CJk
 5jOirQ4ZVaFDiBecgKKHWp0Gjd9PeNM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-cxd9gP7EMlCJQT8zDwfhhA-1; Wed, 04 Feb 2026 09:27:52 -0500
X-MC-Unique: cxd9gP7EMlCJQT8zDwfhhA-1
X-Mimecast-MFC-AGG-ID: cxd9gP7EMlCJQT8zDwfhhA_1770215272
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c93f0849dso1120220a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:27:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215272; cv=none;
 d=google.com; s=arc-20240605;
 b=bfkjhwrDeV3v/gyOnLhzXUDHAUfmcqQafYVFxXg5zqvOMC70apjwOynPpxLx6/41LC
 9I9XYL7sztqkOGrBQx5y4VmAXRn6LDMiZqIt2paFZEsM/CjEsqsH2KLGGrDbna+SXu0F
 Jkcj6Utn5WYeXKiNW9qxlw4Z/kiOoQA/e784Y035tef2+kyMwv4X9EloXbmajXkEk+so
 RpctqaAYCUs+k9SQdGjquGXUa6JaYJOj/hAXIPqp5hpmu+1zoTY508dqlRcjioaGIZA8
 BMV1ks6d75ZxnW1P2wUDFPnV+qQH8jYKWVuyhKibCbxI+dcrP9H2UJk4vQa5DC1GgqOD
 LSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L33gbMFZr8W2mA2dSY1kSu0fg4By4qfgVDrm4Ftr6Pc=;
 fh=/S0G7WTrJEwiOkkGkeIMfioJVwlrWQZFfOsoj/oGiLk=;
 b=NAevdto/sDrtyjAzpC7dR8R85hq4x2wRbiouFQHO739BOhrFTTexXjA5h08u36astT
 FHYDQStZDJSMLKe29xyKnZX1wmJL9dzUUq1Ixx/CK+4d/+9+CLrsg8VAivyHoUDe0BlD
 v1mR+Ikyl7RnNS39nA3ubSl7C3r1ikTJUniUKjjN09LM+DhvRikRlintRbXHozTZo0XA
 MhwOE8/yb3kUuwPsywjXzt16ltxr7/TbBaz+XxJ0P73rE10/7uf//cPPvYB61n76+2kU
 c1+s7tH+XrUh95z3rYPYDiiGcyvzYYVsaZg35h9OpgAUY8EJPX2BuTLTdxfv7kVvDTfI
 4F3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770215272; x=1770820072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L33gbMFZr8W2mA2dSY1kSu0fg4By4qfgVDrm4Ftr6Pc=;
 b=NuTKPGAc+YNGvI/GcKmJDVQ+CJ06s9ia1aKwA/GDdcjVo4Z4vYHqmiTAQau69wwJOM
 swxWRTpqUwT7HPZaVP5aWX1K9KWz3r8Xlc1AzETGBls3mr7ZaBrKhe1XHLQO5TKMHaqm
 MwNRuEwSbyZt9Emac6yyGs2lJeK7DXbeC9gq5eXOB6AOeDBxOwFGxSdwsCzgPDMHv1wV
 IMDC5HMMcb6cLNdzXThhDYq3pkGg4JN9XhPFosnpXt6NYn7q2ddsnkYtrB3jhMsnogi0
 ZIlYQrXpMztQbYXLQ4Os1dgbOEwn34UPN5BtTHZRXsTBNzeRdII1vc16ki2lrBUJYAFw
 ta8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770215272; x=1770820072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L33gbMFZr8W2mA2dSY1kSu0fg4By4qfgVDrm4Ftr6Pc=;
 b=A4274tPx5RmaIo0f4u6F9kem7+W79358tinuJ+pi9xOHZffvhwJSDbGQVPzLBwYCdv
 AwJ5LMamyvFfVb4cYzDjrJRmzJNyCOHLWF+tISawVGDmigqwF5eaM6M64SJjD8g4rgyr
 E7VtTiFZF/k5ZDez0TxZTUC2f3AHC/gCppmUv7AfjNu2ukA+vBC9zueZSgazlI/k9eLQ
 IjT1u2PYaEDSbd9zKDAvgWK8yPaYVgwaSscuqA9hnuORGJf+cu8L+KBMOnrSLiGUTKM7
 tWjENaPzvr+rZ/+nXy7eOzFIfd1eyq6YJ8URn0h4PK25aVhhKI1KJ+8SjF/V/vcQ9ybr
 5cEg==
X-Gm-Message-State: AOJu0YyP+QuYj0Qt7H3b2wF3bNA+vm1lGQJxsVqw/dt7S1PJOdi7Ahyo
 vvdyv8gLw8fBEku5Un5cTMT7vgfMlo6gbZK72fMN6J4y0euXdgUtexd3wLAVXZt+Nuc1C1A++H9
 9qNKXga/MghGPnc3CndweayPcEGM++AdNIunmSLekLZHKTAxn39eZyvb7htwaBaKpWlyPEk+xpM
 m5nFMpjoYCdGLx0Af1x+A8bCuaszj1T8o=
X-Gm-Gg: AZuq6aLEpDLRI9+mrZb87Hb4ZY7u1Zr7YYc1V6hJOdD1nfly214XHMQ4Hw8K/Lq2seV
 d5sRutNEPCxxQ0Ht5NFSlrEQ75FjKTK8u8KJpGbtynJAiWVaOXZZhcNOwDgE+oqB6dtpxms2EEH
 6Xb47qzOea3Bytpa1xYlVONbLgsuXUKHuFPdudMsz+8UDLYpFIkdvhZJljN5lAK03+Hot7wdy2D
 59/H66BevfXAz+3Kohjp7g0Gg==
X-Received: by 2002:a17:90b:28c3:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-3547769019fmr5501481a91.3.1770215271457; 
 Wed, 04 Feb 2026 06:27:51 -0800 (PST)
X-Received: by 2002:a17:90b:28c3:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-3547769019fmr5501459a91.3.1770215270893; Wed, 04 Feb 2026
 06:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-19-marcandre.lureau@redhat.com>
 <1d78a544-7204-4695-9fd3-fcde2fdbb7c9@nutanix.com>
In-Reply-To: <1d78a544-7204-4695-9fd3-fcde2fdbb7c9@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Feb 2026 18:27:39 +0400
X-Gm-Features: AZwV_Qj7T5leKSW7CR8ussBxhDeuOFcMX-kNTyo6gNovJlMDtDLbPOMxwjnL5yQ
Message-ID: <CAMxuvaxG9=xs6Oz8hiYzuXggLjmMByaQUod0P7TyYOJVFJ9+-A@mail.gmail.com>
Subject: Re: [PATCH 18/37] audio: introduce AudioMixengBackend
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Feb 4, 2026 at 2:59=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Introduce a sub-class for current "audio_driver" based implementations.
> > Future AudioBackend implementations can do without it.
> >
> > Next cleanup will actually remove "audio_driver" struct altogether and
> > make the subclass proper QOM objects.
> >
> > Public APIs still rely on backend being an AudioMixeng. They will
> > assert() if not. This will be addressed later to allow other backends.
> >
> > Note that the initial naming proposed for this object was AudioDriver,
> > however the semantics for "driver" is already overloaded and leads to
> > confusion, in particular with the QAPI AudiodevDriver. The defining
> > characteristic is of using QEMU's software mixing engine, so
> > AudioMixengBackend.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio_int.h        |  25 +++++---
> >   audio/audio_template.h   |  18 +++---
> >   include/qemu/audio.h     |  17 +++++-
> >   audio/alsaaudio.c        |   2 +-
> >   audio/audio.c            | 124 +++++++++++++++++++++++++++++---------=
-
> >   audio/dbusaudio.c        |   8 +--
> >   audio/ossaudio.c         |   4 +-
> >   tests/audio/test-audio.c |   4 +-
> >   ui/dbus.c                |   6 +-
> >   9 files changed, 144 insertions(+), 64 deletions(-)
> >
> > diff --git a/audio/audio_int.h b/audio/audio_int.h
> > index a6276375887..06f5160e8df 100644
> > --- a/audio/audio_int.h
> > +++ b/audio/audio_int.h
> > @@ -61,7 +61,7 @@ struct audio_pcm_info {
> >       int swap_endianness;
> >   };
> >
> > -typedef struct AudioBackend AudioBackend;
> > +typedef struct AudioMixengBackend AudioMixengBackend;
> >   typedef struct SWVoiceCap SWVoiceCap;
> >
> >   typedef struct STSampleBuffer {
> > @@ -70,7 +70,7 @@ typedef struct STSampleBuffer {
> >   } STSampleBuffer;
> >
> >   typedef struct HWVoiceOut {
> > -    AudioBackend *s;
> > +    AudioMixengBackend *s;
> >       bool enabled;
> >       int poll_mode;
> >       bool pending_disable;
> > @@ -90,7 +90,7 @@ typedef struct HWVoiceOut {
> >   } HWVoiceOut;
> >
> >   typedef struct HWVoiceIn {
> > -    AudioBackend *s;
> > +    AudioMixengBackend *s;
> >       bool enabled;
> >       int poll_mode;
> >       struct audio_pcm_info info;
> > @@ -110,7 +110,7 @@ typedef struct HWVoiceIn {
> >   } HWVoiceIn;
> >
> >   struct SWVoiceOut {
> > -    AudioBackend *s;
> > +    AudioMixengBackend *s;
> >       struct audio_pcm_info info;
> >       t_sample *conv;
> >       STSampleBuffer resample_buf;
> > @@ -126,7 +126,7 @@ struct SWVoiceOut {
> >   };
> >
> >   struct SWVoiceIn {
> > -    AudioBackend *s;
> > +    AudioMixengBackend *s;
> >       bool active;
> >       struct audio_pcm_info info;
> >       void *rate;
> > @@ -239,8 +239,12 @@ struct SWVoiceCap {
> >       QLIST_ENTRY (SWVoiceCap) entries;
> >   };
> >
> > -typedef struct AudioBackend {
> > -    Object parent;
> > +struct AudioMixengBackendClass {
> > +    AudioBackendClass parent_class;
> > +};
> > +
> > +struct AudioMixengBackend {
> > +    AudioBackend parent_obj;
> >
> >       struct audio_driver *drv;
> >       Audiodev *dev;
> > @@ -257,7 +261,7 @@ typedef struct AudioBackend {
> >       bool timer_running;
> >       uint64_t timer_last;
> >       VMChangeStateEntry *vmse;
> > -} AudioBackend;
> > +};
> >
> >   extern const struct mixeng_volume nominal_volume;
> >
> > @@ -270,7 +274,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_inf=
o *info, void *buf, int len);
> >
> >   int audio_bug (const char *funcname, int cond);
> >
> > -void audio_run(AudioBackend *s, const char *msg);
> > +void audio_run(AudioMixengBackend *s, const char *msg);
> >
> >   const char *audio_application_name(void);
> >
> > @@ -323,4 +327,7 @@ void audio_create_pdos(Audiodev *dev);
> >   AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
> >   AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
> >
> > +#define TYPE_AUDIO_MIXENG_BACKEND "audio-mixeng-backend"
> > +OBJECT_DECLARE_TYPE(AudioMixengBackend, AudioMixengBackendClass, AUDIO=
_MIXENG_BACKEND)
> > +
> >   #endif /* QEMU_AUDIO_INT_H */
> > diff --git a/audio/audio_template.h b/audio/audio_template.h
> > index e69e6e74570..a1f78d8748b 100644
> > --- a/audio/audio_template.h
> > +++ b/audio/audio_template.h
> > @@ -36,7 +36,7 @@
> >   #define HWBUF hw->conv_buf
> >   #endif
> >
> > -static void glue(audio_init_nb_voices_, TYPE)(AudioBackend *s,
> > +static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
> >                                                 struct audio_driver *dr=
v, int min_voices)
> >   {
> >       int max_voices =3D glue (drv->max_voices_, TYPE);
> > @@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *=
sw)
> >   static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
> >   {
> >       HW *hw =3D *hwp;
> > -    AudioBackend *s =3D hw->s;
> > +    AudioMixengBackend *s =3D hw->s;
> >
> >       if (!hw->sw_head.lh_first) {
> >   #ifdef DAC
> > @@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **h=
wp)
> >       }
> >   }
> >
> > -static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBackend *s, HW *hw)
> > +static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioMixengBackend *s, H=
W *hw)
> >   {
> >       return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_fir=
st;
> >   }
> >
> > -static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s,=
 HW *hw)
> > +static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioMixengBacke=
nd *s, HW *hw)
> >   {
> >       while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
> >           if (hw->enabled) {
> > @@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_, TYP=
E)(AudioBackend *s, HW *hw)
> >       return NULL;
> >   }
> >
> > -static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW=
 *hw,
> > +static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioMixengBackend =
*s, HW *hw,
> >                                                      struct audsettings=
 *as)
> >   {
> >       while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
> > @@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)(=
AudioBackend *s, HW *hw,
> >       return NULL;
> >   }
> >
> > -static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBackend *s,
> > +static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
> >                                                struct audsettings *as)
> >   {
> >       HW *hw;
> > @@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, T=
YPE)(Audiodev *dev)
> >       abort();
> >   }
> >
> > -static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audse=
ttings *as)
> > +static HW *glue(audio_pcm_hw_add_, TYPE)(AudioMixengBackend *s, struct=
 audsettings *as)
> >   {
> >       HW *hw;
> >       AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(s=
->dev);
> > @@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBacke=
nd *s, struct audsettings *as
> >   }
> >
> >   static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
> > -    AudioBackend *s,
> > +    AudioMixengBackend *s,
> >       const char *sw_name,
> >       const struct audsettings *as
> >       )
> > @@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
> >       const struct audsettings *as
> >       )
> >   {
> > -    AudioBackend *s =3D be;
> > +    AudioMixengBackend *s =3D AUDIO_MIXENG_BACKEND(be);
> >       AudiodevPerDirectionOptions *pdo;
> >
> >       if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> > diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> > index 370e993f080..474d761f0be 100644
> > --- a/include/qemu/audio.h
> > +++ b/include/qemu/audio.h
> > @@ -44,11 +44,21 @@ typedef struct audsettings {
> >   typedef struct SWVoiceOut SWVoiceOut;
> >   typedef struct SWVoiceIn SWVoiceIn;
> >
> > -struct AudioBackendClass {
> > +typedef struct AudioBackend {
> > +    Object parent_obj;
> > +} AudioBackend;
> > +
> > +typedef struct AudioBackendClass {
> >       ObjectClass parent_class;
> > -};
> >
> > -typedef struct AudioBackend AudioBackend;
> > +    const char *(*get_id)(AudioBackend *be);
> > +#ifdef CONFIG_GIO
> > +    bool (*set_dbus_server)(AudioBackend *be,
> > +                            GDBusObjectManagerServer *manager,
> > +                            bool p2p,
> > +                            Error **errp);
> > +#endif
> > +} AudioBackendClass;
> >
> >   bool AUD_backend_check(AudioBackend **be, Error **errp);
> >
> > @@ -125,6 +135,7 @@ AudioBackend *audio_be_by_name(const char *name, Er=
ror **errp);
> >   AudioBackend *audio_get_default_audio_be(Error **errp);
> >   const char *audio_be_get_id(AudioBackend *be);
> >   #ifdef CONFIG_GIO
> > +bool audio_be_can_set_dbus_server(AudioBackend *be);
> >   bool audio_be_set_dbus_server(AudioBackend *be,
> >                                 GDBusObjectManagerServer *server,
> >                                 bool p2p,
> > diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> > index 7d7da576dc9..814820e2864 100644
> > --- a/audio/alsaaudio.c
> > +++ b/audio/alsaaudio.c
> > @@ -41,7 +41,7 @@ struct pollhlp {
> >       struct pollfd *pfds;
> >       int count;
> >       int mask;
> > -    AudioBackend *s;
> > +    AudioMixengBackend *s;
> >   };
> >
> >   typedef struct ALSAVoiceOut {
> > diff --git a/audio/audio.c b/audio/audio.c
> > index 6eb921f0cca..1c83dd4ce6d 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -36,6 +36,7 @@
> >   #include "qemu/log.h"
> >   #include "qemu/module.h"
> >   #include "qemu/help_option.h"
> > +#include "qom/object.h"
> >   #include "system/system.h"
> >   #include "system/replay.h"
> >   #include "system/runstate.h"
> > @@ -383,7 +384,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_inf=
o *info, void *buf, int len)
> >   /*
> >    * Capture
> >    */
> > -static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBackend *=
s,
> > +static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBac=
kend *s,
> >                                                           struct audset=
tings *as)
> >   {
> >       CaptureVoiceOut *cap;
> > @@ -463,7 +464,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
> >
> >   static int audio_attach_capture (HWVoiceOut *hw)
> >   {
> > -    AudioBackend *s =3D hw->s;
> > +    AudioMixengBackend *s =3D hw->s;
> >       CaptureVoiceOut *cap;
> >
> >       audio_detach_capture (hw);
> > @@ -801,7 +802,7 @@ static void audio_pcm_print_info (const char *cap, =
struct audio_pcm_info *info)
> >   /*
> >    * Timer
> >    */
> > -static int audio_is_timer_needed(AudioBackend *s)
> > +static int audio_is_timer_needed(AudioMixengBackend *s)
> >   {
> >       HWVoiceIn *hwi =3D NULL;
> >       HWVoiceOut *hwo =3D NULL;
> > @@ -819,7 +820,7 @@ static int audio_is_timer_needed(AudioBackend *s)
> >       return 0;
> >   }
> >
> > -static void audio_reset_timer(AudioBackend *s)
> > +static void audio_reset_timer(AudioMixengBackend *s)
> >   {
> >       if (audio_is_timer_needed(s)) {
> >           timer_mod_anticipate_ns(s->ts,
> > @@ -841,7 +842,7 @@ static void audio_reset_timer(AudioBackend *s)
> >   static void audio_timer (void *opaque)
> >   {
> >       int64_t now, diff;
> > -    AudioBackend *s =3D opaque;
> > +    AudioMixengBackend *s =3D opaque;
> >
> >       now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >       diff =3D now - s->timer_last;
> > @@ -924,7 +925,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
> >
> >       hw =3D sw->hw;
> >       if (sw->active !=3D on) {
> > -        AudioBackend *s =3D sw->s;
> > +        AudioMixengBackend *s =3D sw->s;
> >           SWVoiceOut *temp_sw;
> >           SWVoiceCap *sc;
> >
> > @@ -972,7 +973,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
> >
> >       hw =3D sw->hw;
> >       if (sw->active !=3D on) {
> > -        AudioBackend *s =3D sw->s;
> > +        AudioMixengBackend *s =3D sw->s;
> >           SWVoiceIn *temp_sw;
> >
> >           if (on) {
> > @@ -1140,7 +1141,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw=
, size_t live)
> >       return clipped;
> >   }
> >
> > -static void audio_run_out(AudioBackend *s)
> > +static void audio_run_out(AudioMixengBackend *s)
> >   {
> >       HWVoiceOut *hw =3D NULL;
> >       SWVoiceOut *sw;
> > @@ -1293,7 +1294,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, =
size_t samples)
> >       return conv;
> >   }
> >
> > -static void audio_run_in(AudioBackend *s)
> > +static void audio_run_in(AudioMixengBackend *s)
> >   {
> >       HWVoiceIn *hw =3D NULL;
> >
> > @@ -1340,7 +1341,7 @@ static void audio_run_in(AudioBackend *s)
> >       }
> >   }
> >
> > -static void audio_run_capture(AudioBackend *s)
> > +static void audio_run_capture(AudioMixengBackend *s)
> >   {
> >       CaptureVoiceOut *cap;
> >
> > @@ -1387,7 +1388,7 @@ static void audio_run_capture(AudioBackend *s)
> >       }
> >   }
> >
> > -void audio_run(AudioBackend *s, const char *msg)
> > +void audio_run(AudioMixengBackend *s, const char *msg)
> >   {
> >       audio_run_out(s);
> >       audio_run_in(s);
> > @@ -1560,8 +1561,8 @@ size_t audio_generic_read(HWVoiceIn *hw, void *bu=
f, size_t size)
> >       return total;
> >   }
> >
> > -static bool audio_driver_init(AudioBackend *s, struct audio_driver *dr=
v,
> > -                              Audiodev *dev, Error **errp)
> > +static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_d=
river *drv,
> > +                                 Audiodev *dev, Error **errp)
> >   {
> >       s->drv_opaque =3D drv->init(dev, errp);
> >       if (!s->drv_opaque) {
> > @@ -1593,7 +1594,7 @@ static bool audio_driver_init(AudioBackend *s, st=
ruct audio_driver *drv,
> >   static void audio_vm_change_state_handler (void *opaque, bool running=
,
> >                                              RunState state)
> >   {
> > -    AudioBackend *s =3D opaque;
> > +    AudioMixengBackend *s =3D opaque;
> >       HWVoiceOut *hwo =3D NULL;
> >       HWVoiceIn *hwi =3D NULL;
> >
> > @@ -1615,7 +1616,47 @@ static const VMStateDescription vmstate_audio;
> >
> >   static void audio_be_init(Object *obj)
> >   {
> > -    AudioBackend *s =3D AUDIO_BACKEND(obj);
> > +}
> > +
> > +static void audio_be_finalize(Object *obj)
> > +{
> > +}
> > +
> > +static const char *audio_mixeng_backend_get_id(AudioBackend *be)
> > +{
> > +    return AUDIO_MIXENG_BACKEND(be)->dev->id;
> > +}
> > +
> > +#ifdef CONFIG_GIO
> > +static bool audio_mixeng_backend_set_dbus_server(AudioBackend *be,
> > +                                                 GDBusObjectManagerSer=
ver *manager,
> > +                                                 bool p2p,
> > +                                                 Error **errp)
> > +{
> > +    AudioMixengBackend *d =3D AUDIO_MIXENG_BACKEND(be);
> > +
> > +    if (!d->drv->set_dbus_server) {
> > +        return false;
> > +    }
> > +
> > +    return d->drv->set_dbus_server(be, manager, p2p, errp);
> > +}
> > +
> > +#endif
> > +
> > +static void audio_mixeng_backend_class_init(ObjectClass *klass, const =
void *data)
> > +{
> > +    AudioBackendClass *be =3D AUDIO_BACKEND_CLASS(klass);
> > +
> > +    be->get_id =3D audio_mixeng_backend_get_id;
> > +#ifdef CONFIG_GIO
> > +    be->set_dbus_server =3D audio_mixeng_backend_set_dbus_server;
> > +#endif
> > +}
> > +
> > +static void audio_mixeng_backend_init(Object *obj)
> > +{
> > +    AudioMixengBackend *s =3D AUDIO_MIXENG_BACKEND(obj);
> >
> >       QLIST_INIT(&s->hw_head_out);
> >       QLIST_INIT(&s->hw_head_in);
> > @@ -1628,9 +1669,9 @@ static void audio_be_init(Object *obj)
> >       vmstate_register_any(NULL, &vmstate_audio, s);
> >   }
> >
> > -static void audio_be_finalize(Object *obj)
> > +static void audio_mixeng_backend_finalize(Object *obj)
> >   {
> > -    AudioBackend *s =3D AUDIO_BACKEND(obj);
> > +    AudioMixengBackend *s =3D AUDIO_MIXENG_BACKEND(obj);
> >       HWVoiceOut *hwo, *hwon;
> >       HWVoiceIn *hwi, *hwin;
> >
> > @@ -1746,10 +1787,10 @@ static AudioBackend *audio_init(Audiodev *dev, =
Error **errp)
> >   {
> >       int done =3D 0;
> >       const char *drvname;
> > -    AudioBackend *s;
> > +    AudioMixengBackend *s;
> >       struct audio_driver *driver;
> >
> > -    s =3D AUDIO_BACKEND(object_new(TYPE_AUDIO_BACKEND));
> > +    s =3D AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
> >
> >       if (dev) {
> >           /* -audiodev option */
> > @@ -1757,7 +1798,7 @@ static AudioBackend *audio_init(Audiodev *dev, Er=
ror **errp)
> >           drvname =3D AudiodevDriver_str(dev->driver);
> >           driver =3D audio_driver_lookup(drvname);
> >           if (driver) {
> > -            done =3D audio_driver_init(s, driver, dev, errp);
> > +            done =3D audio_driver_do_init(s, driver, dev, errp);
> >           } else {
> >               error_setg(errp, "Unknown audio driver `%s'", drvname);
> >           }
> > @@ -1777,7 +1818,7 @@ static AudioBackend *audio_init(Audiodev *dev, Er=
ror **errp)
> >               g_free(e);
> >               drvname =3D AudiodevDriver_str(dev->driver);
> >               driver =3D audio_driver_lookup(drvname);
> > -            if (audio_driver_init(s, driver, dev, NULL)) {
> > +            if (audio_driver_do_init(s, driver, dev, NULL)) {
> >                   break;
> >               }
> >               qapi_free_Audiodev(dev);
> > @@ -1789,7 +1830,7 @@ static AudioBackend *audio_init(Audiodev *dev, Er=
ror **errp)
> >           goto out;
> >       }
> >       object_unref(s);
> > -    return s;
> > +    return AUDIO_BACKEND(s);
> >
> >   out:
> >       object_unref(s);
> > @@ -1828,12 +1869,13 @@ bool AUD_backend_check(AudioBackend **be, Error=
 **errp)
> >   static struct audio_pcm_ops capture_pcm_ops;
> >
> >   CaptureVoiceOut *AUD_add_capture(
> > -    AudioBackend *s,
> > +    AudioBackend *be,
> >       struct audsettings *as,
> >       struct audio_capture_ops *ops,
> >       void *cb_opaque
> >       )
> >   {
> > +    AudioMixengBackend *s =3D AUDIO_MIXENG_BACKEND(be);
> >       CaptureVoiceOut *cap;
> >       struct capture_callback *cb;
> >
> > @@ -2224,27 +2266,37 @@ AudioBackend *audio_be_by_name(const char *name=
, Error **errp)
> >   }
> >
> >   #ifdef CONFIG_GIO
> > +bool audio_be_can_set_dbus_server(AudioBackend *be)
> > +{
> > +    /*
> > +     * TODO:
> > +     * AudioBackendClass *klass =3D AUDIO_BACKEND_GET_CLASS(be);
> > +     * return klass->set_dbus_server !=3D NULL;
> > +     */
> > +    return AUDIO_MIXENG_BACKEND(be)->drv->set_dbus_server !=3D NULL;
> > +}
> > +
> >   bool audio_be_set_dbus_server(AudioBackend *be,
> >                                 GDBusObjectManagerServer *server,
> >                                 bool p2p,
> >                                 Error **errp)
> >   {
> > -    assert(be !=3D NULL);
> > +    AudioBackendClass *klass =3D AUDIO_BACKEND_GET_CLASS(be);
> >
> > -    if (!be->drv->set_dbus_server) {
> > -        error_setg(errp, "Audiodev '%s' is not compatible with DBus", =
be->dev->id);
> > +    if (!audio_be_can_set_dbus_server(be)) {
> > +        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
> > +                   audio_be_get_id(be));
> >           return false;
> >       }
> >
> > -    return be->drv->set_dbus_server(be, server, p2p, errp);
> > +    return klass->set_dbus_server(be, server, p2p, errp);
> >   }
> >   #endif
> >
> >   const char *audio_be_get_id(AudioBackend *be)
> >   {
> >       if (be) {
> > -        assert(be->dev);
> > -        return be->dev->id;
> > +        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
> >       } else {
> >           return "";
> >       }
> > @@ -2319,13 +2371,25 @@ static const TypeInfo audio_be_info =3D {
> >       .instance_size =3D sizeof(AudioBackend),
> >       .instance_init =3D audio_be_init,
> >       .instance_finalize =3D audio_be_finalize,
> > -    .abstract =3D false, /* TODO: subclass drivers and make it abstrac=
t */
> > +    .abstract =3D true,
> >       .class_size =3D sizeof(AudioBackendClass),
> >   };
> >
> > +static const TypeInfo audio_mixeng_backend_info =3D {
> > +    .name =3D TYPE_AUDIO_MIXENG_BACKEND,
> > +    .parent =3D TYPE_AUDIO_BACKEND,
> > +    .instance_size =3D sizeof(AudioMixengBackend),
> > +    .instance_init =3D audio_mixeng_backend_init,
> > +    .instance_finalize =3D audio_mixeng_backend_finalize,
> > +    .abstract =3D false,
>
> Minor nit: you can drop the .abstract =3D false here.

ok

>
> > +    .class_size =3D sizeof(AudioMixengBackendClass),
> > +    .class_init =3D audio_mixeng_backend_class_init,
> > +};
> > +
> >   static void register_types(void)
> >   {
> >       type_register_static(&audio_be_info);
> > +    type_register_static(&audio_mixeng_backend_info);
> >   }
>
> These days the DEFINE_TYPES macro is preferred over calling
> type_register_static() by hand.

Thanks, I added a patch for that and converted the rest of the series.

>
> >   type_init(register_types);
> > diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> > index 1fe7c4ed647..96d4fa3f471 100644
> > --- a/audio/dbusaudio.c
> > +++ b/audio/dbusaudio.c
> > @@ -464,7 +464,7 @@ listener_in_vanished_cb(GDBusConnection *connection=
,
> >   }
> >
> >   static gboolean
> > -dbus_audio_register_listener(AudioBackend *s,
> > +dbus_audio_register_listener(AudioMixengBackend *s,
> >                                GDBusMethodInvocation *invocation,
> >   #ifdef G_OS_UNIX
> >                                GUnixFDList *fd_list,
> > @@ -621,7 +621,7 @@ dbus_audio_register_listener(AudioBackend *s,
> >   }
> >
> >   static gboolean
> > -dbus_audio_register_out_listener(AudioBackend *s,
> > +dbus_audio_register_out_listener(AudioMixengBackend *s,
> >                                    GDBusMethodInvocation *invocation,
> >   #ifdef G_OS_UNIX
> >                                    GUnixFDList *fd_list,
> > @@ -637,7 +637,7 @@ dbus_audio_register_out_listener(AudioBackend *s,
> >   }
> >
> >   static gboolean
> > -dbus_audio_register_in_listener(AudioBackend *s,
> > +dbus_audio_register_in_listener(AudioMixengBackend *s,
> >                                   GDBusMethodInvocation *invocation,
> >   #ifdef G_OS_UNIX
> >                                   GUnixFDList *fd_list,
> > @@ -657,7 +657,7 @@ dbus_audio_set_server(AudioBackend *s,
> >                         bool p2p,
> >                         Error **errp)
> >   {
> > -    DBusAudio *da =3D s->drv_opaque;
> > +    DBusAudio *da =3D AUDIO_MIXENG_BACKEND(s)->drv_opaque;
> >
> >       g_assert(da);
> >       g_assert(!da->server);
> > diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> > index c6cad47a015..6ad20ab1876 100644
> > --- a/audio/ossaudio.c
> > +++ b/audio/ossaudio.c
> > @@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
> >
> >   static void oss_helper_poll_out (void *opaque)
> >   {
> > -    AudioBackend *s =3D opaque;
> > +    AudioMixengBackend *s =3D opaque;
> >       audio_run(s, "oss_poll_out");
> >   }
> >
> >   static void oss_helper_poll_in (void *opaque)
> >   {
> > -    AudioBackend *s =3D opaque;
> > +    AudioMixengBackend *s =3D opaque;
> >       audio_run(s, "oss_poll_in");
> >   }
> >
> > diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> > index 38e30f47f89..e1e518df2a7 100644
> > --- a/tests/audio/test-audio.c
> > +++ b/tests/audio/test-audio.c
> > @@ -165,7 +165,7 @@ static void test_audio_out_sine_wave(void)
> >        */
> >       start_time =3D g_get_monotonic_time();
> >       while (state.frames_written < state.total_frames) {
> > -        audio_run(state.be, "test");
> > +        audio_run(AUDIO_MIXENG_BACKEND(state.be), "test");
> >           main_loop_wait(true);
> >
> >           elapsed_ms =3D (g_get_monotonic_time() - start_time) / 1000;
> > @@ -419,7 +419,7 @@ static void test_audio_capture(void)
> >       start_time =3D g_get_monotonic_time();
> >       while (sine_state.frames_written < sine_state.total_frames ||
> >              state.captured_bytes < CAPTURE_BUFFER_SIZE) {
> > -        audio_run(be, "test-capture");
> > +        audio_run(AUDIO_MIXENG_BACKEND(be), "test-capture");
> >           main_loop_wait(true);
> >
> >           elapsed_ms =3D (g_get_monotonic_time() - start_time) / 1000;
> > diff --git a/ui/dbus.c b/ui/dbus.c
> > index e44e2ff9877..0cac1ba8471 100644
> > --- a/ui/dbus.c
> > +++ b/ui/dbus.c
> > @@ -221,8 +221,7 @@ dbus_display_complete(UserCreatable *uc, Error **er=
rp)
> >
> >       {
> >           AudioBackend *audio_be =3D audio_get_default_audio_be(NULL);
> > -
> > -        if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
> > +        if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
> >               audio_be =3D NULL;
> >           }
> >           if (dd->audiodev && *dd->audiodev) {
> > @@ -231,8 +230,7 @@ dbus_display_complete(UserCreatable *uc, Error **er=
rp)
> >                   return;
> >               }
> >           }
> > -        if (audio_be &&
> > -            !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, e=
rrp)) {
> > +        if (audio_be && !audio_be_set_dbus_server(audio_be, dd->server=
, dd->p2p, errp)) {
> >               return;
> >           }
> >       }
>
> Otherwise:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>

thanks


