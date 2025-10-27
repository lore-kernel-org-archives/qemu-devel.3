Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C13ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQ3c-0000F8-7H; Mon, 27 Oct 2025 12:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDQ3V-0000CU-QO; Mon, 27 Oct 2025 12:26:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDQ3M-00063T-7y; Mon, 27 Oct 2025 12:26:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1BBFD5972E4;
 Mon, 27 Oct 2025 17:26:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id kRMPONQhpk5o; Mon, 27 Oct 2025 17:26:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 08D535972E2; Mon, 27 Oct 2025 17:26:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 061AA59703F;
 Mon, 27 Oct 2025 17:26:26 +0100 (CET)
Date: Mon, 27 Oct 2025 17:26:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Alexandre Ratchov <alex@caoua.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 09/35] audio: start making AudioState a QOM Object
In-Reply-To: <20251027151045.2863176-10-marcandre.lureau@redhat.com>
Message-ID: <342519b4-4de6-f54b-606e-b1b3b1c97dc9@eik.bme.hu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2105009789-1761582386=:34255"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2105009789-1761582386=:34255
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Oct 2025, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> QOM brings some conveniences for introspection, type checking, reference
> counting, interfaces etc. This is only the first step to introduce QOM
> in audio/ (I have more in the pipeline)
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> audio/audio.h     |  7 +++++++
> audio/audio_int.h |  2 ++
> audio/audio.c     | 43 ++++++++++++++++++++++++++++++++-----------
> 3 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/audio/audio.h b/audio/audio.h
> index eb5b5d662d..e41c5bc55a 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -80,6 +80,10 @@ typedef struct SWVoiceOut SWVoiceOut;
> typedef struct CaptureVoiceOut CaptureVoiceOut;
> typedef struct SWVoiceIn SWVoiceIn;
>
> +struct AudioStateClass {
> +    ObjectClass parent_class;
> +};
> +
> typedef struct AudioState AudioState;
> typedef struct QEMUSoundCard {
>     char *name;
> @@ -182,4 +186,7 @@ const char *audio_get_id(QEMUSoundCard *card);
> #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>
> +#define TYPE_AUDIO_STATE "audio-state"
> +OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)
> +
> #endif /* QEMU_AUDIO_H */
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index f78ca05f92..b2b4d2d10e 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -217,6 +217,8 @@ struct SWVoiceCap {
> };
>
> typedef struct AudioState {
> +    Object parent;

Coding style says parent_obj, not sure other names are acceptable.

Regards,
BALATON Zoltan
--3866299591-2105009789-1761582386=:34255--

