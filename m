Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E6CD74ED3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjI4m-00035y-AN; Fri, 23 Jan 2026 09:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vjI4R-0002hY-Qh
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:23:33 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vjI4N-0004jv-Rr
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:23:31 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DDAE3596ADB;
 Fri, 23 Jan 2026 15:23:21 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Q-uV95R6rhTw; Fri, 23 Jan 2026 15:23:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D1146596ADF; Fri, 23 Jan 2026 15:23:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CEEF5596AE0;
 Fri, 23 Jan 2026 15:23:19 +0100 (CET)
Date: Fri, 23 Jan 2026 15:23:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: Re: [PATCH 21/37] audio: add QOM module-objects for each backend
In-Reply-To: <20260123074945.2563196-22-marcandre.lureau@redhat.com>
Message-ID: <3f0d41b1-dbce-80ba-c1e2-a8d73d1c6caf@eik.bme.hu>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-22-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-375026873-1769178199=:60220"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-375026873-1769178199=:60220
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 23 Jan 2026, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> This will allow to use QOM and the dynamic object module loading.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> audio/audio_int.h   |  2 ++
> audio/alsaaudio.c   | 27 +++++++++++++++++++++++++++
> audio/dbusaudio.c   | 26 ++++++++++++++++++++++++++
> audio/dsoundaudio.c | 26 ++++++++++++++++++++++++++
> audio/jackaudio.c   | 26 ++++++++++++++++++++++++++
> audio/noaudio.c     | 26 ++++++++++++++++++++++++++
> audio/ossaudio.c    | 26 ++++++++++++++++++++++++++
> audio/paaudio.c     | 26 ++++++++++++++++++++++++++
> audio/pwaudio.c     | 26 ++++++++++++++++++++++++++
> audio/sdlaudio.c    | 26 ++++++++++++++++++++++++++
> audio/sndioaudio.c  | 26 ++++++++++++++++++++++++++
> audio/spiceaudio.c  | 26 ++++++++++++++++++++++++++
> audio/wavaudio.c    | 26 ++++++++++++++++++++++++++
> audio/coreaudio.m   | 26 ++++++++++++++++++++++++++
> 14 files changed, 341 insertions(+)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 06f5160e8df..29f5864be69 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -241,6 +241,8 @@ struct SWVoiceCap {
>
> struct AudioMixengBackendClass {
>     AudioBackendClass parent_class;
> +
> +    audio_driver *driver;
> };
>
> struct AudioMixengBackend {
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 814820e2864..881f3d0349d 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -27,6 +27,7 @@
> #include "qemu/main-loop.h"
> #include "qemu/module.h"
> #include "qemu/audio.h"
> +#include "qom/object.h"
> #include "trace.h"
>
> #pragma GCC diagnostic ignored "-Waddress"
> @@ -36,6 +37,22 @@
>
> #define DEBUG_ALSA 0
>
> +#define TYPE_AUDIO_ALSA "audio-alsa"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
> +
> +struct AudioALSA {
> +    AudioMixengBackend parent;
> +};

If you have nothing to put here only the parent you don't need to declare 
the state struct...

> +
> +static struct audio_driver alsa_audio_driver;
> +
> +static void audio_alsa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &alsa_audio_driver;
> +}
> +
> struct pollhlp {
>     snd_pcm_t *handle;
>     struct pollfd *pfds;
> @@ -945,8 +962,18 @@ static struct audio_driver alsa_audio_driver = {
>     .voice_size_in  = sizeof (ALSAVoiceIn)
> };
>
> +static const TypeInfo audio_alsa_info = {
> +    .name = TYPE_AUDIO_ALSA,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioALSA),

...and can set instance_size of the parent so I think you can drop the 
struct above everywhere where no other fields are needed other than the 
parent. (See e.g. via_mc97_info)

Regards,
BALATON Zoltan

> +    .class_init = audio_alsa_class_init,
> +};
> +
> +
> static void register_audio_alsa(void)
> {
>     audio_driver_register(&alsa_audio_driver);
> +    type_register_static(&audio_alsa_info);
> }
> type_init(register_audio_alsa);
> +module_obj(TYPE_AUDIO_ALSA);
--3866299591-375026873-1769178199=:60220--

