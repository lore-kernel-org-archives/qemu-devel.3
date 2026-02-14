Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CCEF99FF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 12:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrETK-000464-RX; Sat, 14 Feb 2026 07:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrETI-00045X-Ra
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 07:10:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrETG-00081J-RD
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 07:10:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2FDBB596A0B;
 Sat, 14 Feb 2026 13:09:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id YAMzb4Adq8Ca; Sat, 14 Feb 2026 13:09:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0E9E65969F6; Sat, 14 Feb 2026 13:09:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D1215969F0;
 Sat, 14 Feb 2026 13:09:55 +0100 (CET)
Date: Sat, 14 Feb 2026 13:09:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 31/43] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
In-Reply-To: <CAMxuvazGyHmW1iUcyaKuEdwjvmHRxP_oF-0vno2eZc+-8XH_mQ@mail.gmail.com>
Message-ID: <67fc0281-fef6-452a-c2cc-ff119cb17341@eik.bme.hu>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-32-marcandre.lureau@redhat.com>
 <6f204d62-f14b-479c-ab37-1dcca6b5bd30@nutanix.com>
 <CAMxuvazGyHmW1iUcyaKuEdwjvmHRxP_oF-0vno2eZc+-8XH_mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1911096912-1771070995=:43665"
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

--3866299591-1911096912-1771070995=:43665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 14 Feb 2026, Marc-André Lureau wrote:
> On Fri, Feb 13, 2026 at 4:28 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> The audio_pcm_info structure stored three fields (bits, is_signed,
>>> is_float) that were always derived from the AudioFormat enum. This
>>> redundancy meant the same information was represented twice, with no
>>> type-level guarantee that they stayed in sync.
>>>
>>> Replace these fields with a single AudioFormat field, and add helper
>>> functions to extract the derived properties when needed:
>>> - audio_format_bits()
>>> - audio_format_is_signed()
>>> - audio_format_is_float()
>>>
>>> This improves type safety by making AudioFormat the single source of
>>> truth, eliminating the possibility of inconsistent state between the
>>> format enum and its derived boolean/integer representations.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   audio/audio_int.h       |   4 +-
>>>   audio/audio_template.h  |  12 +--
>>>   include/qemu/audio.h    |  49 +++++++++
>>>   audio/audio-mixeng-be.c | 218 ++++++++++++----------------------------
>>>   audio/dbusaudio.c       |  12 +--
>>>   audio/coreaudio.m       |   2 +-
>>>   6 files changed, 126 insertions(+), 171 deletions(-)
>>>
>>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>>> index 5334c4baad2..dd5f2220d75 100644
>>> --- a/audio/audio_int.h
>>> +++ b/audio/audio_int.h
>>> @@ -45,9 +45,7 @@ struct audio_callback {
>>>   };
>>>
>>>   struct audio_pcm_info {
>>> -    int bits;
>>> -    bool is_signed;
>>> -    bool is_float;
>>> +    AudioFormat af;
>>>       int freq;
>>>       int nchannels;
>>>       int bytes_per_frame;
>>> diff --git a/audio/audio_template.h b/audio/audio_template.h
>>> index 08d60422589..3da91a4782c 100644
>>> --- a/audio/audio_template.h
>>> +++ b/audio/audio_template.h
>>> @@ -173,7 +173,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>>>       sw->empty = true;
>>>   #endif
>>>
>>> -    if (sw->info.is_float) {
>>> +    if (audio_format_is_float(hw->info.af)) {
>>>   #ifdef DAC
>>>           sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
>>>               [sw->info.swap_endianness];
>>> @@ -188,9 +188,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>>>           sw->clip = mixeng_clip
>>>   #endif
>>>               [sw->info.nchannels == 2]
>>> -            [sw->info.is_signed]
>>> +            [audio_format_is_signed(hw->info.af)]
>>>               [sw->info.swap_endianness]
>>> -            [audio_bits_to_index(sw->info.bits)];
>>> +            [audio_format_to_index(hw->info.af)];
>>>       }
>>>
>>>       sw->name = g_strdup (name);
>>> @@ -300,7 +300,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>           goto err1;
>>>       }
>>>
>>> -    if (hw->info.is_float) {
>>> +    if (audio_format_is_float(hw->info.af)) {
>>>   #ifdef DAC
>>>           hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>>>               [hw->info.swap_endianness];
>>> @@ -315,9 +315,9 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>           hw->conv = mixeng_conv
>>>   #endif
>>>               [hw->info.nchannels == 2]
>>> -            [hw->info.is_signed]
>>> +            [audio_format_is_signed(hw->info.af)]
>>>               [hw->info.swap_endianness]
>>> -            [audio_bits_to_index(hw->info.bits)];
>>> +            [audio_format_to_index(hw->info.af)];
>>>       }
>>>
>>>       glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
>>> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
>>> index b6b6ee9b560..a2fbc286eb1 100644
>>> --- a/include/qemu/audio.h
>>> +++ b/include/qemu/audio.h
>>> @@ -185,6 +185,55 @@ bool audio_be_set_dbus_server(AudioBackend *be,
>>>
>>>   const char *audio_application_name(void);
>>>
>>> +static inline int audio_format_bits(AudioFormat fmt)
>>
>> Does the inline make a difference here? My understanding is that the
>> compiler treats this as a weak hint these days, and generally does the
>> right thing by itself.
>
> If you drop "inline" you get -Werror=unused-function.
>
>>
>>> +{
>>> +    switch (fmt) {
>>> +    case AUDIO_FORMAT_S8:
>>> +    case AUDIO_FORMAT_U8:
>>> +        return 8;
>>> +
>>> +    case AUDIO_FORMAT_S16:
>>> +    case AUDIO_FORMAT_U16:
>>> +        return 16;
>>> +
>>> +    case AUDIO_FORMAT_F32:
>>> +    case AUDIO_FORMAT_S32:
>>> +    case AUDIO_FORMAT_U32:
>>> +        return 32;
>>> +
>>> +    case AUDIO_FORMAT__MAX:
>>> +     break;
>>> +    }
>>
>> I'm not sure that AUDIO_FORMAT__MAX is a valid choice here - can you
>> drop the explicit case for AUDIO_FORMAT__MAX and then simply have a
>> default that calls g_assert_not_reached() instead?
>
> We need to handle all variants, because -Werror=switch. That

A default case would catch that but it's better to list all cases here 
instead of using a default because that will catch missing case if a new 
fmt is ever added whereas a default would just absorb it so I think no 
need to change these from AUDIO_FORMAT__MAX to default.

Regards,
BALATON Zoltan
--3866299591-1911096912-1771070995=:43665--

