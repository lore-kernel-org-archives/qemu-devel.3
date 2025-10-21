Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C519BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8h9-0007fQ-JY; Tue, 21 Oct 2025 05:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vB8h7-0007ev-8Y
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vB8h3-0007wn-Ec
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761039011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WUzdvLc4CkpygCKRaF0VZRr3T4dF7cR3ywp8FT5NtPM=;
 b=Pf3/u5HmRgpV3NylREKsYDO3yXFiC9l2j32rhfwZMMk1QW+kCj+qc9wVaH/6Ah3Cn4qZ70
 Lkqu/3apmbAUTcPD0rGZmDIJkeWmfQPYHOfABMO7jKozR5VOyuy5LVlmyKmvmtD8/1LxKQ
 aD2/gd+dMWf5JUmfogty5gBU2H3mHJA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14--uWd_5kCMuuTzCwg2BOxbQ-1; Tue, 21 Oct 2025 05:30:09 -0400
X-MC-Unique: -uWd_5kCMuuTzCwg2BOxbQ-1
X-Mimecast-MFC-AGG-ID: -uWd_5kCMuuTzCwg2BOxbQ_1761039008
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so9804513f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761039008; x=1761643808;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUzdvLc4CkpygCKRaF0VZRr3T4dF7cR3ywp8FT5NtPM=;
 b=jWIBp3oM4nTxBP+NF5TmA0GxvV/bBys3QiojVgfyNpmKjnPORyYMh9sPm9CHolv2Vq
 SDsm9pMpgWZNjYJp1Cb+YPbQZtIm2Pcw+Bd1GddjNW0TK4SHbsfDVZgSrM4pKkoSxb5X
 RjSF9EPASOUfgSLqU0H02Cq9MSpN06mfoRT7Bw6A+n+w/GRbvMqLBckIpRkO3pcGzwUk
 365LEi+/mxW8G+uvGMxmeIc7zqT12Jb4XjGrM4wUCIDz0bIYI/bLt7iwDweYDGq7zcjc
 HJAflBeQRd5sC7zvHIPB+3ifs19ZuSr5qslyHvc7qyfEhXfwhIQE/WwAWJzhbcGdTwhg
 iDng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkHCS2SA2QfI8JQgMsUSQAsvdTe2keVsWKIZwxy8MpoRJyPMZAYLkJHIAKAINfCLyNlqFszaCh9t0t@nongnu.org
X-Gm-Message-State: AOJu0Ywevl52N0dYC6vSr9J6P8rlakDnlxKj/DIpZd9RoMKhVVB19b+r
 6iOWOtZ0GDLafl7/pFgQawJbJ5qiLTSP7rYS7ZsfW+7S4cTCu82aWlUTNYze8ULa0gOyL9vvhao
 9M5nXnli2A+YSoHFuAfK8T72R9FQLgQplX9nlj4QH0rf+j30BN8/7HyyE
X-Gm-Gg: ASbGncsRmi9bY8uhtVPHreCC97vXNxvA8mO7MXe5+qc9NusEI4iKd2BnY+JT9eRQDJJ
 h2iAml9AbPL9IUexxyDhls8HwLjbVJhj9MxECTeeeUk9xYUTRptahitdEsuiHPKtDotObC5IBBX
 g2GhlhkY+nVvwTGQJsmIoNPwXWKyDQ4oZnYuLzfRcPnaZrrJJTzc3u+JTi8W5R1AY6sloaXl1mz
 l0msHdLzzi5Ir4Yz+3/6cpZm6Kc0F+ddoM6kFZCJ256GEzUtN54w/8WIfUe4k0jjLz3r/PHkQy4
 jL4ym1S199pD/J1LXB2ikZCGBBGGQna+fBEeGOHftSK2z+4pX0Y0qPN9S0/696sHOVpicASmgUx
 4tY2qTX408Qiqp/44J80DNoEYjahWF7K++mcQPKfptCOmlKldBN1VoE0eeCuM/Obuttms65iwNp
 kZ1A==
X-Received: by 2002:a05:6000:420e:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42704d900a9mr11014542f8f.24.1761039007576; 
 Tue, 21 Oct 2025 02:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa1UUAkXb1pJRNx9wPVBF7ijJd+Zc3ciawbPybpvxARO0tBnMFe6h67dFX9Ar+Hq7sdOpu7g==
X-Received: by 2002:a05:6000:420e:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42704d900a9mr11014496f8f.24.1761039006751; 
 Tue, 21 Oct 2025 02:30:06 -0700 (PDT)
Received: from [192.168.10.27] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-427f009a96asm19633426f8f.31.2025.10.21.02.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:30:05 -0700 (PDT)
Message-ID: <1bd34160-d034-465b-a1ac-0e734ed40484@redhat.com>
Date: Tue, 21 Oct 2025 11:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/43] audio: rename AudioState -> AudioBE
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-35-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20251021090317.425409-35-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/21/25 11:03, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Naming is hard. But in general in QEMU, a host "backend" is the term
> used to fullfill the request made by the device "frontend".
> 
> Note that "audiodev" is the corresponding QAPI type name (or configuration).

BE and FE aren't used in existing code though.  Looking at current use:

- BlockDriverState*/BlockBackend*

- Chardev*/CharBackend

- NetClientState*/NICState*

... it's actually quite common for the *frontend* to have a pointer or 
object of type FooBackend; that would give Audiodev* and AudioBackend*.

Paolo

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h                    | 18 +++----
>   audio/audio_int.h                | 20 +++----
>   audio/audio_template.h           | 20 +++----
>   ui/vnc.h                         |  2 +-
>   audio/alsaaudio.c                |  2 +-
>   audio/audio-hmp-cmds.c           |  2 +-
>   audio/audio.c                    | 90 ++++++++++++++++----------------
>   audio/dbusaudio.c                |  8 +--
>   audio/ossaudio.c                 |  4 +-
>   audio/wavcapture.c               |  2 +-
>   hw/audio/pcspk.c                 |  2 +-
>   hw/core/machine.c                |  2 +-
>   hw/core/qdev-properties-system.c |  6 +--
>   ui/dbus.c                        |  8 +--
>   ui/vnc.c                         | 10 ++--
>   15 files changed, 98 insertions(+), 98 deletions(-)
> 
> diff --git a/audio/audio.h b/audio/audio.h
> index 1858b930ca..845e078169 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -64,15 +64,15 @@ typedef struct SWVoiceOut SWVoiceOut;
>   typedef struct CaptureVoiceOut CaptureVoiceOut;
>   typedef struct SWVoiceIn SWVoiceIn;
>   
> -typedef struct AudioStateClass AudioStateClass;
> -struct AudioStateClass {
> +typedef struct AudioBEClass AudioBEClass;
> +struct AudioBEClass {
>       ObjectClass parent_class;
>   };
>   
> -typedef struct AudioState AudioState;
> +typedef struct AudioBE AudioBE;
>   typedef struct QEMUSoundCard {
>       char *name;
> -    AudioState *state;
> +    AudioBE *be;
>       QLIST_ENTRY (QEMUSoundCard) entries;
>   } QEMUSoundCard;
>   
> @@ -83,7 +83,7 @@ typedef struct QEMUAudioTimeStamp {
>   bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
>   void AUD_remove_card (QEMUSoundCard *card);
>   CaptureVoiceOut *AUD_add_capture(
> -    AudioState *s,
> +    AudioBE *s,
>       struct audsettings *as,
>       struct audio_capture_ops *ops,
>       void *opaque
> @@ -154,14 +154,14 @@ void audio_create_default_audiodevs(void);
>   void audio_init_audiodevs(void);
>   void audio_help(void);
>   
> -AudioState *audio_state_by_name(const char *name, Error **errp);
> -AudioState *audio_get_default_audio_state(Error **errp);
> +AudioBE *audio_be_by_name(const char *name, Error **errp);
> +AudioBE *audio_get_default_audio_be(Error **errp);
>   const char *audio_get_id(QEMUSoundCard *card);
>   
>   #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>       DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>   
> -#define TYPE_AUDIO_STATE "audio-state"
> -OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)
> +#define TYPE_AUDIO_BE "audio-be"
> +OBJECT_DECLARE_TYPE(AudioBE, AudioBEClass, AUDIO_BE)
>   
>   #endif /* QEMU_AUDIO_H */
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index cc7a6fe087..d7e24ec089 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -57,7 +57,7 @@ struct audio_pcm_info {
>       int swap_endianness;
>   };
>   
> -typedef struct AudioState AudioState;
> +typedef struct AudioBE AudioBE;
>   typedef struct SWVoiceCap SWVoiceCap;
>   
>   typedef struct STSampleBuffer {
> @@ -66,7 +66,7 @@ typedef struct STSampleBuffer {
>   } STSampleBuffer;
>   
>   typedef struct HWVoiceOut {
> -    AudioState *s;
> +    AudioBE *s;
>       int enabled;
>       int poll_mode;
>       int pending_disable;
> @@ -87,7 +87,7 @@ typedef struct HWVoiceOut {
>   } HWVoiceOut;
>   
>   typedef struct HWVoiceIn {
> -    AudioState *s;
> +    AudioBE *s;
>       int enabled;
>       int poll_mode;
>       struct audio_pcm_info info;
> @@ -109,7 +109,7 @@ typedef struct HWVoiceIn {
>   
>   struct SWVoiceOut {
>       QEMUSoundCard *card;
> -    AudioState *s;
> +    AudioBE *s;
>       struct audio_pcm_info info;
>       t_sample *conv;
>       STSampleBuffer resample_buf;
> @@ -126,7 +126,7 @@ struct SWVoiceOut {
>   
>   struct SWVoiceIn {
>       QEMUSoundCard *card;
> -    AudioState *s;
> +    AudioBE *s;
>       int active;
>       struct audio_pcm_info info;
>       void *rate;
> @@ -147,7 +147,7 @@ struct audio_driver {
>       void *(*init) (Audiodev *, Error **);
>       void (*fini) (void *);
>   #ifdef CONFIG_GIO
> -    void (*set_dbus_server) (AudioState *s, GDBusObjectManagerServer *manager, bool p2p);
> +    void (*set_dbus_server) (AudioBE *s, GDBusObjectManagerServer *manager, bool p2p);
>   #endif
>       struct audio_pcm_ops *pcm_ops;
>       int max_voices_out;
> @@ -206,7 +206,7 @@ static inline void *advance (void *p, int incr)
>       return (d + incr);
>   }
>   
> -int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
> +int wav_start_capture(AudioBE *state, CaptureState *s, const char *path,
>                         int freq, int bits, int nchannels);
>   
>   void audio_generic_run_buffer_in(HWVoiceIn *hw);
> @@ -238,7 +238,7 @@ struct SWVoiceCap {
>       QLIST_ENTRY (SWVoiceCap) entries;
>   };
>   
> -typedef struct AudioState {
> +typedef struct AudioBE {
>       Object parent;
>   
>       struct audio_driver *drv;
> @@ -258,7 +258,7 @@ typedef struct AudioState {
>       bool timer_running;
>       uint64_t timer_last;
>       VMChangeStateEntry *vmse;
> -} AudioState;
> +} AudioBE;
>   
>   extern const struct mixeng_volume nominal_volume;
>   
> @@ -271,7 +271,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
>   
>   int audio_bug (const char *funcname, int cond);
>   
> -void audio_run(AudioState *s, const char *msg);
> +void audio_run(AudioBE *s, const char *msg);
>   
>   const char *audio_application_name(void);
>   
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index c29d79c443..c8f3e9dc93 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -36,7 +36,7 @@
>   #define HWBUF hw->conv_buf
>   #endif
>   
> -static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
> +static void glue(audio_init_nb_voices_, TYPE)(AudioBE *s,
>                                                 struct audio_driver *drv, int min_voices)
>   {
>       int max_voices = glue (drv->max_voices_, TYPE);
> @@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw)
>   static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
>   {
>       HW *hw = *hwp;
> -    AudioState *s = hw->s;
> +    AudioBE *s = hw->s;
>   
>       if (!hw->sw_head.lh_first) {
>   #ifdef DAC
> @@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
>       }
>   }
>   
> -static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioState *s, HW *hw)
> +static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBE *s, HW *hw)
>   {
>       return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
>   }
>   
> -static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, HW *hw)
> +static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBE *s, HW *hw)
>   {
>       while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
>           if (hw->enabled) {
> @@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, HW *hw)
>       return NULL;
>   }
>   
> -static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *hw,
> +static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBE *s, HW *hw,
>                                                      struct audsettings *as)
>   {
>       while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
> @@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *hw,
>       return NULL;
>   }
>   
> -static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
> +static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBE *s,
>                                                struct audsettings *as)
>   {
>       HW *hw;
> @@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
>       abort();
>   }
>   
> -static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsettings *as)
> +static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBE *s, struct audsettings *as)
>   {
>       HW *hw;
>       AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
> @@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsettings *as)
>   }
>   
>   static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
> -    AudioState *s,
> +    AudioBE *s,
>       const char *sw_name,
>       struct audsettings *as
>       )
> @@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
>       struct audsettings *as
>       )
>   {
> -    AudioState *s;
> +    AudioBE *s;
>       AudiodevPerDirectionOptions *pdo;
>   
>       if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
> @@ -503,7 +503,7 @@ SW *glue (AUD_open_, TYPE) (
>           goto fail;
>       }
>   
> -    s = card->state;
> +    s = card->be;
>       pdo = glue(audio_get_pdo_, TYPE)(s->dev);
>   
>       ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
> diff --git a/ui/vnc.h b/ui/vnc.h
> index f2dab2f4d9..a6aac50ec3 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -184,7 +184,7 @@ struct VncDisplay
>       VncDisplaySASL sasl;
>   #endif
>   
> -    AudioState *audio_state;
> +    AudioBE *audio_be;
>   
>       VMChangeStateEntry *vmstate_handler_entry;
>   };
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 9b6c01c0ef..1c762e0e24 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -41,7 +41,7 @@ struct pollhlp {
>       struct pollfd *pfds;
>       int count;
>       int mask;
> -    AudioState *s;
> +    AudioBE *s;
>   };
>   
>   typedef struct ALSAVoiceOut {
> diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
> index 819f8fa9d8..f7a7d0c947 100644
> --- a/audio/audio-hmp-cmds.c
> +++ b/audio/audio-hmp-cmds.c
> @@ -67,7 +67,7 @@ void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>       const char *audiodev = qdict_get_str(qdict, "audiodev");
>       CaptureState *s;
>       Error *local_err = NULL;
> -    AudioState *as = audio_state_by_name(audiodev, &local_err);
> +    AudioBE *as = audio_be_by_name(audiodev, &local_err);
>   
>       if (!as) {
>           error_report_err(local_err);
> diff --git a/audio/audio.c b/audio/audio.c
> index 9e6d79b4e3..66a2e86f13 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -99,7 +99,7 @@ static audio_driver *audio_driver_lookup(const char *name)
>       return NULL;
>   }
>   
> -static AudioState *default_audio_state;
> +static AudioBE *default_audio_be;
>   
>   const struct mixeng_volume nominal_volume = {
>       .mute = 0,
> @@ -380,7 +380,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
>   /*
>    * Capture
>    */
> -static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioState *s,
> +static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBE *s,
>                                                           struct audsettings *as)
>   {
>       CaptureVoiceOut *cap;
> @@ -460,7 +460,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
>   
>   static int audio_attach_capture (HWVoiceOut *hw)
>   {
> -    AudioState *s = hw->s;
> +    AudioBE *s = hw->s;
>       CaptureVoiceOut *cap;
>   
>       audio_detach_capture (hw);
> @@ -798,7 +798,7 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
>   /*
>    * Timer
>    */
> -static int audio_is_timer_needed(AudioState *s)
> +static int audio_is_timer_needed(AudioBE *s)
>   {
>       HWVoiceIn *hwi = NULL;
>       HWVoiceOut *hwo = NULL;
> @@ -816,7 +816,7 @@ static int audio_is_timer_needed(AudioState *s)
>       return 0;
>   }
>   
> -static void audio_reset_timer (AudioState *s)
> +static void audio_reset_timer (AudioBE *s)
>   {
>       if (audio_is_timer_needed(s)) {
>           timer_mod_anticipate_ns(s->ts,
> @@ -838,7 +838,7 @@ static void audio_reset_timer (AudioState *s)
>   static void audio_timer (void *opaque)
>   {
>       int64_t now, diff;
> -    AudioState *s = opaque;
> +    AudioBE *s = opaque;
>   
>       now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       diff = now - s->timer_last;
> @@ -921,7 +921,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
>   
>       hw = sw->hw;
>       if (sw->active != on) {
> -        AudioState *s = sw->s;
> +        AudioBE *s = sw->s;
>           SWVoiceOut *temp_sw;
>           SWVoiceCap *sc;
>   
> @@ -969,7 +969,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
>   
>       hw = sw->hw;
>       if (sw->active != on) {
> -        AudioState *s = sw->s;
> +        AudioBE *s = sw->s;
>           SWVoiceIn *temp_sw;
>   
>           if (on) {
> @@ -1137,7 +1137,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>       return clipped;
>   }
>   
> -static void audio_run_out (AudioState *s)
> +static void audio_run_out (AudioBE *s)
>   {
>       HWVoiceOut *hw = NULL;
>       SWVoiceOut *sw;
> @@ -1291,7 +1291,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
>       return conv;
>   }
>   
> -static void audio_run_in (AudioState *s)
> +static void audio_run_in (AudioBE *s)
>   {
>       HWVoiceIn *hw = NULL;
>   
> @@ -1339,7 +1339,7 @@ static void audio_run_in (AudioState *s)
>       }
>   }
>   
> -static void audio_run_capture (AudioState *s)
> +static void audio_run_capture (AudioBE *s)
>   {
>       CaptureVoiceOut *cap;
>   
> @@ -1386,7 +1386,7 @@ static void audio_run_capture (AudioState *s)
>       }
>   }
>   
> -void audio_run(AudioState *s, const char *msg)
> +void audio_run(AudioBE *s, const char *msg)
>   {
>       audio_run_out(s);
>       audio_run_in(s);
> @@ -1559,7 +1559,7 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>       return total;
>   }
>   
> -static bool audio_driver_init(AudioState *s, struct audio_driver *drv,
> +static bool audio_driver_init(AudioBE *s, struct audio_driver *drv,
>                                 Audiodev *dev, Error **errp)
>   {
>       s->drv_opaque = drv->init(dev, errp);
> @@ -1592,7 +1592,7 @@ static bool audio_driver_init(AudioState *s, struct audio_driver *drv,
>   static void audio_vm_change_state_handler (void *opaque, bool running,
>                                              RunState state)
>   {
> -    AudioState *s = opaque;
> +    AudioBE *s = opaque;
>       HWVoiceOut *hwo = NULL;
>       HWVoiceIn *hwi = NULL;
>   
> @@ -1613,9 +1613,9 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
>   
>   static const VMStateDescription vmstate_audio;
>   
> -static void audio_state_init(Object *obj)
> +static void audio_be_init(Object *obj)
>   {
> -    AudioState *s = AUDIO_STATE(obj);
> +    AudioBE *s = AUDIO_BE(obj);
>   
>       QLIST_INIT (&s->hw_head_out);
>       QLIST_INIT (&s->hw_head_in);
> @@ -1629,9 +1629,9 @@ static void audio_state_init(Object *obj)
>       vmstate_register_any(NULL, &vmstate_audio, s);
>   }
>   
> -static void audio_state_finalize(Object *obj)
> +static void audio_be_finalize(Object *obj)
>   {
> -    AudioState *s = AUDIO_STATE(obj);
> +    AudioBE *s = AUDIO_BE(obj);
>       HWVoiceOut *hwo, *hwon;
>       HWVoiceIn *hwi, *hwin;
>   
> @@ -1692,7 +1692,7 @@ static Object *get_audiodevs_root(void)
>   
>   void audio_cleanup(void)
>   {
> -    default_audio_state = NULL;
> +    default_audio_be = NULL;
>   
>       object_unparent(get_audiodevs_root());
>   }
> @@ -1743,14 +1743,14 @@ void audio_create_default_audiodevs(void)
>    * if dev == NULL => legacy implicit initialization, return the already created
>    *   state or create a new one
>    */
> -static AudioState *audio_init(Audiodev *dev, Error **errp)
> +static AudioBE *audio_init(Audiodev *dev, Error **errp)
>   {
>       int done = 0;
>       const char *drvname;
> -    AudioState *s;
> +    AudioBE *s;
>       struct audio_driver *driver;
>   
> -    s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
> +    s = AUDIO_BE(object_new(TYPE_AUDIO_BE));
>   
>       if (dev) {
>           /* -audiodev option */
> @@ -1766,7 +1766,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
>               goto out;
>           }
>       } else {
> -        assert(!default_audio_state);
> +        assert(!default_audio_be);
>           for (;;) {
>               AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
>               if (!e) {
> @@ -1797,11 +1797,11 @@ out:
>       return NULL;
>   }
>   
> -AudioState *audio_get_default_audio_state(Error **errp)
> +AudioBE *audio_get_default_audio_be(Error **errp)
>   {
> -    if (!default_audio_state) {
> -        default_audio_state = audio_init(NULL, errp);
> -        if (!default_audio_state) {
> +    if (!default_audio_be) {
> +        default_audio_be = audio_init(NULL, errp);
> +        if (!default_audio_be) {
>               if (!QSIMPLEQ_EMPTY(&audiodevs)) {
>                   error_append_hint(errp, "Perhaps you wanted to use -audio or set audiodev=%s?\n",
>                                     QSIMPLEQ_FIRST(&audiodevs)->dev->id);
> @@ -1809,21 +1809,21 @@ AudioState *audio_get_default_audio_state(Error **errp)
>           }
>       }
>   
> -    return default_audio_state;
> +    return default_audio_be;
>   }
>   
>   bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
>   {
> -    if (!card->state) {
> -        card->state = audio_get_default_audio_state(errp);
> -        if (!card->state) {
> +    if (!card->be) {
> +        card->be = audio_get_default_audio_be(errp);
> +        if (!card->be) {
>               return false;
>           }
>       }
>   
>       card->name = g_strdup (name);
>       memset (&card->entries, 0, sizeof (card->entries));
> -    QLIST_INSERT_HEAD(&card->state->card_head, card, entries);
> +    QLIST_INSERT_HEAD(&card->be->card_head, card, entries);
>   
>       return true;
>   }
> @@ -1837,7 +1837,7 @@ void AUD_remove_card (QEMUSoundCard *card)
>   static struct audio_pcm_ops capture_pcm_ops;
>   
>   CaptureVoiceOut *AUD_add_capture(
> -    AudioState *s,
> +    AudioBE *s,
>       struct audsettings *as,
>       struct audio_capture_ops *ops,
>       void *cb_opaque
> @@ -2220,7 +2220,7 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
>           audioformat_bytes_per_sample(as->fmt);
>   }
>   
> -AudioState *audio_state_by_name(const char *name, Error **errp)
> +AudioBE *audio_be_by_name(const char *name, Error **errp)
>   {
>       Object *obj = object_resolve_path_component(get_audiodevs_root(), name);
>   
> @@ -2228,15 +2228,15 @@ AudioState *audio_state_by_name(const char *name, Error **errp)
>           error_setg(errp, "audiodev '%s' not found", name);
>           return NULL;
>       } else {
> -        return AUDIO_STATE(obj);
> +        return AUDIO_BE(obj);
>       }
>   }
>   
>   const char *audio_get_id(QEMUSoundCard *card)
>   {
> -    if (card->state) {
> -        assert(card->state->dev);
> -        return card->state->dev->id;
> +    if (card->be) {
> +        assert(card->be->dev);
> +        return card->be->dev->id;
>       } else {
>           return "";
>       }
> @@ -2305,19 +2305,19 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
>       return ret;
>   }
>   
> -static const TypeInfo audio_state_info = {
> -    .name = TYPE_AUDIO_STATE,
> +static const TypeInfo audio_be_info = {
> +    .name = TYPE_AUDIO_BE,
>       .parent = TYPE_OBJECT,
> -    .instance_size = sizeof(AudioState),
> -    .instance_init = audio_state_init,
> -    .instance_finalize = audio_state_finalize,
> +    .instance_size = sizeof(AudioBE),
> +    .instance_init = audio_be_init,
> +    .instance_finalize = audio_be_finalize,
>       .abstract = false, // todo, subclass and make it abstract
> -    .class_size = sizeof(AudioStateClass),
> +    .class_size = sizeof(AudioBEClass),
>   };
>   
>   static void register_types(void)
>   {
> -    type_register_static(&audio_state_info);
> +    type_register_static(&audio_be_info);
>   }
>   
>   type_init(register_types);
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 908214a170..873f76a89e 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -458,7 +458,7 @@ listener_in_vanished_cb(GDBusConnection *connection,
>   }
>   
>   static gboolean
> -dbus_audio_register_listener(AudioState *s,
> +dbus_audio_register_listener(AudioBE *s,
>                                GDBusMethodInvocation *invocation,
>   #ifdef G_OS_UNIX
>                                GUnixFDList *fd_list,
> @@ -615,7 +615,7 @@ dbus_audio_register_listener(AudioState *s,
>   }
>   
>   static gboolean
> -dbus_audio_register_out_listener(AudioState *s,
> +dbus_audio_register_out_listener(AudioBE *s,
>                                    GDBusMethodInvocation *invocation,
>   #ifdef G_OS_UNIX
>                                    GUnixFDList *fd_list,
> @@ -631,7 +631,7 @@ dbus_audio_register_out_listener(AudioState *s,
>   }
>   
>   static gboolean
> -dbus_audio_register_in_listener(AudioState *s,
> +dbus_audio_register_in_listener(AudioBE *s,
>                                   GDBusMethodInvocation *invocation,
>   #ifdef G_OS_UNIX
>                                   GUnixFDList *fd_list,
> @@ -646,7 +646,7 @@ dbus_audio_register_in_listener(AudioState *s,
>   }
>   
>   static void
> -dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
> +dbus_audio_set_server(AudioBE *s, GDBusObjectManagerServer *server, bool p2p)
>   {
>       DBusAudio *da = s->drv_opaque;
>   
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index c5858284a1..f202e743ff 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
>   
>   static void oss_helper_poll_out (void *opaque)
>   {
> -    AudioState *s = opaque;
> +    AudioBE *s = opaque;
>       audio_run(s, "oss_poll_out");
>   }
>   
>   static void oss_helper_poll_in (void *opaque)
>   {
> -    AudioState *s = opaque;
> +    AudioBE *s = opaque;
>       audio_run(s, "oss_poll_in");
>   }
>   
> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> index 0fbc695d23..55ba0906a2 100644
> --- a/audio/wavcapture.c
> +++ b/audio/wavcapture.c
> @@ -103,7 +103,7 @@ static struct capture_ops wav_capture_ops = {
>       .info = wav_capture_info
>   };
>   
> -int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
> +int wav_start_capture(AudioBE *state, CaptureState *s, const char *path,
>                         int freq, int bits, int nchannels)
>   {
>       WAVState *wav;
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index c8c63b7915..e9ab5ac41b 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -188,7 +188,7 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
>   
>       isa_register_ioport(isadev, &s->ioport, s->iobase);
>   
> -    if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
> +    if (s->card.be && AUD_register_card(s_spk, &s->card, errp)) {
>           pcspk_audio_init(s);
>       }
>   }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 681adbb7ac..2de8b89606 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -763,7 +763,7 @@ static void machine_set_audiodev(Object *obj, const char *value,
>   {
>       MachineState *ms = MACHINE(obj);
>   
> -    if (!audio_state_by_name(value, errp)) {
> +    if (!audio_be_by_name(value, errp)) {
>           return;
>       }
>   
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 1f810b7ddf..be682895f7 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -499,16 +499,16 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
>   {
>       const Property *prop = opaque;
>       QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
> -    AudioState *state;
> +    AudioBE *state;
>       g_autofree char *str = NULL;
>   
>       if (!visit_type_str(v, name, &str, errp)) {
>           return;
>       }
>   
> -    state = audio_state_by_name(str, errp);
> +    state = audio_be_by_name(str, errp);
>       if (state) {
> -        card->state = state;
> +        card->be = state;
>       }
>   }
>   
> diff --git a/ui/dbus.c b/ui/dbus.c
> index dd0336702d..962b4a8c1e 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -220,16 +220,16 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>       }
>   
>       if (dd->audiodev && *dd->audiodev) {
> -        AudioState *audio_state = audio_state_by_name(dd->audiodev, errp);
> -        if (!audio_state) {
> +        AudioBE *audio_be = audio_be_by_name(dd->audiodev, errp);
> +        if (!audio_be) {
>               return;
>           }
> -        if (!g_str_equal(audio_state->drv->name, "dbus")) {
> +        if (!g_str_equal(audio_be->drv->name, "dbus")) {
>               error_setg(errp, "Audiodev '%s' is not compatible with DBus",
>                          dd->audiodev);
>               return;
>           }
> -        audio_state->drv->set_dbus_server(audio_state, dd->server, dd->p2p);
> +        audio_be->drv->set_dbus_server(audio_be, dd->server, dd->p2p);
>       }
>   
>       consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 77c823bf2e..0094ec680c 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1276,7 +1276,7 @@ static void audio_add(VncState *vs)
>       ops.destroy = audio_capture_destroy;
>       ops.capture = audio_capture;
>   
> -    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
> +    vs->audio_cap = AUD_add_capture(vs->vd->audio_be, &vs->as, &ops, vs);
>       if (!vs->audio_cap) {
>           error_report("Failed to add audio capture");
>       }
> @@ -2193,7 +2193,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>               send_ext_key_event_ack(vs);
>               break;
>           case VNC_ENCODING_AUDIO:
> -            if (vs->vd->audio_state) {
> +            if (vs->vd->audio_be) {
>                   vnc_set_feature(vs, VNC_FEATURE_AUDIO);
>                   send_ext_audio_ack(vs);
>               }
> @@ -4236,12 +4236,12 @@ void vnc_display_open(const char *id, Error **errp)
>   
>       audiodev = qemu_opt_get(opts, "audiodev");
>       if (audiodev) {
> -        vd->audio_state = audio_state_by_name(audiodev, errp);
> -        if (!vd->audio_state) {
> +        vd->audio_be = audio_be_by_name(audiodev, errp);
> +        if (!vd->audio_be) {
>               goto fail;
>           }
>       } else {
> -        vd->audio_state = audio_get_default_audio_state(NULL);
> +        vd->audio_be = audio_get_default_audio_be(NULL);
>       }
>   
>       device_id = qemu_opt_get(opts, "display");


