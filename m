Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17ABC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FKT-0001p4-Px; Tue, 08 Apr 2025 16:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1u2FKH-0001nJ-Kp
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:13:41 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1u2FKD-0004rp-0E
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:13:39 -0400
Received: from fwd74.aul.t-online.de (fwd74.aul.t-online.de [10.223.144.100])
 by mailout04.t-online.de (Postfix) with SMTP id CFB4A149C;
 Tue,  8 Apr 2025 22:13:30 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.159.203]) by fwd74.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1u2FK2-0saCu10; Tue, 8 Apr 2025 22:13:26 +0200
Message-ID: <6911d5c1-fe46-4f6e-9165-b16fd23da2c8@t-online.de>
Date: Tue, 8 Apr 2025 22:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
 <37909074.vkC8U9mzk0@silver>
 <abecc55b-f032-03e3-a9f3-628b1f8f7e5d@eik.bme.hu> <2024817.RjeAs2xCtm@silver>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <2024817.RjeAs2xCtm@silver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1744143206-DF7FE152-EDCAB22F/0/0 CLEAN NORMAL
X-TOI-MSGID: a8956392-dcf6-4eb9-b1e7-b48c43ff936b
Received-SPF: pass client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 08.04.25 um 14:55 schrieb Christian Schoenebeck:
> On Friday, April 4, 2025 1:34:27 PM CEST BALATON Zoltan wrote:
>> On Fri, 4 Apr 2025, Christian Schoenebeck wrote:
>>> On Monday, March 31, 2025 3:05:24 PM CEST BALATON Zoltan wrote:
>>>> On Sun, 23 Mar 2025, Christian Schoenebeck wrote:
>>>>> On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
>>>>>> Quoting Volker Rümelin: "try-poll=on tells the ALSA backend to try to
>>>>>> use an event loop instead of the audio timer. This works most of the
>>>>>> time. But the poll event handler in the ALSA backend has a bug. For
>>>>>> example, if the guest can't provide enough audio frames in time, the
>>>>>> ALSA buffer is only partly full and the event handler will be called
>>>>>> again and again on every iteration of the main loop. This increases
>>>>>> the processor load and the guest has less processor time to provide
>>>>>> new audio frames in time. I have two examples where a guest can't
>>>>>> recover from this situation and the guest seems to hang."
>>>>>>
>>>>>> One reproducer I've found is booting MorphOS demo iso on
>>>>>> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
>>>>>> startup sound but instead it freezes. Even when it does not hang it
>>>>>> plays choppy sound. Volker suggested using command line to set
>>>>>> try-poll=off saying: "The try-poll=off arguments are typically
>>>>>> necessary, because the alsa backend has a design issue with
>>>>>> try-poll=on. If the guest can't provide enough audio frames, it's
>>>>>> really unhelpful to ask for new audio frames on every main loop
>>>>>> iteration until the guest can provide enough audio frames. Timer based
>>>>>> playback doesn't have that problem."
>>>>>>
>>>>>> But users cannot easily find this option and having a non-working
>>>>>> default is really unhelpful so to make life easier just set it to
>>>>>> false by default which works until the issue with the alsa backend can
>>>>>> be fixed.
>>>>>>
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> ---
>>>>>> This fixes my issue but if somebody has a better fix I'm open to that
>>>>>> too.
>>>>>>
>>>>>>  audio/alsaaudio.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
>>>>>> index cacae1ea59..9b6c01c0ef 100644
>>>>>> --- a/audio/alsaaudio.c
>>>>>> +++ b/audio/alsaaudio.c
>>>>>> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
>>>>>>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
>>>>>>  {
>>>>>>      if (!apdo->has_try_poll) {
>>>>>> -        apdo->try_poll = true;
>>>>>> +        apdo->try_poll = false;
>>>>>>          apdo->has_try_poll = true;
>>>>>>      }
>>>>>>  }
>>>>>>
>>>>> Correct me if I am wrong, but AFAICS if polling is not used then no state
>>>>> changes would be handled, no? At least I don't see any snd_pcm_state() call
>>>>> outside of alsa_poll_handler().
>>>> I have no idea but this fixes the problem (and does the same that can be
>>>> also done from command line but nobody can find that command line option)
>>>> so unless somebody has a better idea could this be merged as a fix for
>>>> now?
>>> Well, I understand that if fixes the misbehaviour you encountered. But how
>>> helpful would it be if it then breaks behaviour for other people instead?
>> What behaviour would it break and how?
> There are only a bunch of ALSA states handled right now in the QEMU Alsa
> driver (see alsa_poll_handler()):
>
>     state = snd_pcm_state (hlp->handle);
>     switch (state) {
>     case SND_PCM_STATE_SETUP:
>         alsa_recover (hlp->handle);
>         break;
>
>     case SND_PCM_STATE_XRUN:
>         alsa_recover (hlp->handle);
>         break;
>
>     case SND_PCM_STATE_SUSPENDED:
>         alsa_resume (hlp->handle);
>         break;
>
>     case SND_PCM_STATE_PREPARED:
>         audio_run(hlp->s, "alsa run (prepared)");
>         break;
>
>     case SND_PCM_STATE_RUNNING:
>         audio_run(hlp->s, "alsa run (running)");
>         break;
>
> For instance in poll mode it recovers in case of an xrun, which happens on
> audio output if the audio output data was not delivered by the application in
> time.
>
> The other case is when the system was suspended (standby). It should also
> recover the audio session here.

Hi Christian,

I think the timer based mode works fine. snd_pcm_readi() and
snd_pcm_writei() return -EPIPE in case of a xrun and -ESTRPIPE if a
suspend event occurred. Both cases are handled in alsa_write(). The
-ESTRPIPE case is missing in alsa_read(), which may be a mistake. I
don't think it's possible alsa_read() and alsa_write() get called if the
ALSA system is in state SND_PCM_STATE_SETUP.

The write_loop() example code at
https://www.alsa-project.org/alsa-doc/alsa-lib/examples.html in file
test/pcm.c also doesn't use the snd_pcm_state() function. Please have a
look at write_loop() in test/pcm.c and compare it with
write_and_poll_loop() in the same file.

With best regards
Volker

> Now I haven't tested whether these would work in callback mode right now, but
> looking at the code suggests that they might not.
>
>>> I think it would be better to add a 2nd patch that would handle state changes
>>> in callback mode. That would satisfy both groups of people. AFAICS
>>> snd_pcm_state() can be called both in polling mode and callback mode.
>> I can't do that because I don't quite know neither alsa nor audio in QEMU 
>> so I have no idea what to do. Can you give more clues?
> Well, as a starting point you might try whether these cases described above
> would still work in callback mode. Maybe it is even working, who knows.
>
> /Christian
>
>>> Just my 2 cents. Of course it's up to Gerd to decide.
>> If you know it would break something I agree it should be fixed and I can 
>> try but I could not reproduce any breakage and most people likely use 
>> other audio backends so unlikely to encounter problems with alsa.
>>
>> Regards,
>> BALATON Zoltan
>


