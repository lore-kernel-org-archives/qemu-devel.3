Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3089CCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBoj-0002KB-3O; Tue, 21 Oct 2025 08:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBBoX-0002EN-OD; Tue, 21 Oct 2025 08:50:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBBoS-0007aY-FC; Tue, 21 Oct 2025 08:50:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 89E405972E3;
 Tue, 21 Oct 2025 14:49:59 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id sJq7zUXzfMUg; Tue, 21 Oct 2025 14:49:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 80ECE5972DE; Tue, 21 Oct 2025 14:49:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7ECC45972E2;
 Tue, 21 Oct 2025 14:49:57 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:49:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Subject: Re: [PATCH 35/43] audio: rename QEMUSoundCard -> AudioFE
In-Reply-To: <CAJ+F1CJ8Ojiwen+rPrrFAineLYX0-qyXVysCaUSNeSytWPSYkg@mail.gmail.com>
Message-ID: <22226473-1730-9c09-4fce-0aa03ff244f6@eik.bme.hu>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-36-marcandre.lureau@redhat.com>
 <e8232530-ce04-c542-d39e-c0e2dc5014b3@eik.bme.hu>
 <CAJ+F1CJ8Ojiwen+rPrrFAineLYX0-qyXVysCaUSNeSytWPSYkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-884910048-1761050997=:49605"
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

--3866299591-884910048-1761050997=:49605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Oct 2025, Marc-André Lureau wrote:
> On Tue, Oct 21, 2025 at 4:13 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>> audio/audio.h                       | 20 ++++++++++----------
>>> audio/audio_int.h                   |  6 +++---
>>> audio/audio_template.h              |  4 ++--
>>> hw/audio/lm4549.h                   |  2 +-
>>> include/hw/audio/asc.h              |  2 +-
>>> include/hw/audio/virtio-snd.h       |  2 +-
>>> include/hw/display/xlnx_dp.h        |  2 +-
>>> include/hw/isa/vt82c686.h           |  2 +-
>>> include/hw/qdev-properties-system.h |  2 +-
>>> audio/audio.c                       | 10 +++++-----
>>> hw/audio/ac97.c                     |  6 +++---
>>> hw/audio/adlib.c                    |  6 +++---
>>> hw/audio/asc.c                      |  6 +++---
>>> hw/audio/cs4231a.c                  |  4 ++--
>>> hw/audio/es1370.c                   |  6 +++---
>>> hw/audio/gus.c                      |  6 +++---
>>> hw/audio/hda-codec.c                |  6 +++---
>>> hw/audio/lm4549.c                   |  2 +-
>>> hw/audio/pcspk.c                    |  4 ++--
>>> hw/audio/sb16.c                     |  4 ++--
>>> hw/audio/via-ac97.c                 |  4 ++--
>>> hw/audio/virtio-snd.c               |  4 ++--
>>> hw/audio/wm8750.c                   |  6 +++---
>>> hw/core/qdev-properties-system.c    |  4 ++--
>>> hw/display/xlnx_dp.c                |  2 +-
>>> hw/usb/dev-audio.c                  |  6 +++---
>>> 26 files changed, 64 insertions(+), 64 deletions(-)
>>>
>>> diff --git a/audio/audio.h b/audio/audio.h
>>> index 845e078169..a43ca0700c 100644
>>> --- a/audio/audio.h
>>> +++ b/audio/audio.h
>>> @@ -70,18 +70,18 @@ struct AudioBEClass {
>>> };
>>>
>>> typedef struct AudioBE AudioBE;
>>> -typedef struct QEMUSoundCard {
>>> +typedef struct AudioFE {
>>
>> You could also leave it as it is. While it's a bit odd naming it's clear
>> enough and not at least the local variables now called "card" match the
>> type which would not be the case if you rename it to Audiodev or something
>> else but not rename all the locals. So maybe it does not worth the churn
>> to change this type name.
>
> I think it's still worth it. Local variables are locals, and usually
> easy to understand by the context and using their types. It's easy to
> rename "card" to "audio_fe" or "frontend" though, I can do this in
> this change too.

The point is to have less churn not more so renaming locals from card to 
fe or something (but definitely not to a longer name than currently) would 
just be more churn for not much more clarity. Therefore I argued that 
living with QEMUSoundCard type name is better as it keeps consistency with 
local naming and avoids churn. The current type name does not match 
anything else in QEMU but it's clear (even more clear than the proposed 
AudioFE) so I'd accept this small inconsistency in naming for avoiding a 
lot of churn. If you still want to rename it could we call it AudioCard to 
keep consistency with locals or Audiodev what Paolo proposed which is 
still clearer than AudioFE? But I'd just leave it as it is as the simplest 
solution.

Regards,
BALATON Zoltan
--3866299591-884910048-1761050997=:49605--

