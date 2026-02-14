Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE373EF99FF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 12:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrEWZ-0005Go-8e; Sat, 14 Feb 2026 07:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrEWY-0005Gg-Ak
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 07:13:22 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrEWW-00008b-5I
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 07:13:22 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B389B5969F6;
 Sat, 14 Feb 2026 13:13:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 9VCgWtzFeKSe; Sat, 14 Feb 2026 13:13:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9CD215969F1; Sat, 14 Feb 2026 13:13:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9797E5969F0;
 Sat, 14 Feb 2026 13:13:15 +0100 (CET)
Date: Sat, 14 Feb 2026 13:13:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
In-Reply-To: <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
Message-ID: <9647b133-f824-74ea-f1c4-3691ee99222f@eik.bme.hu>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
 <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
 <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1956513522-1771071195=:43665"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1956513522-1771071195=:43665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 14 Feb 2026, Marc-André Lureau wrote:
> On Fri, Feb 13, 2026 at 4:50 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Use more correct GTimer, specific for each backend, with a trace event.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   audio/audio_int.h       |  1 +
>>>   audio/audio-mixeng-be.c | 25 +++++++++----------------
>>>   audio/trace-events      |  1 +
>>>   3 files changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>>> index dd5f2220d75..e0ed6af67ed 100644
>>> --- a/audio/audio_int.h
>>> +++ b/audio/audio_int.h
>>> @@ -224,6 +224,7 @@ struct AudioMixengBackend {
>>>       Audiodev *dev;
>>>
>>>       QEMUTimer *ts;
>>> +    GTimer *run_timer;
>>>       QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
>>>       QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
>>>       QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
>>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
>>> index 343f6ec181e..1b2c1fafa87 100644
>>> --- a/audio/audio-mixeng-be.c
>>> +++ b/audio/audio-mixeng-be.c
>>> @@ -24,13 +24,13 @@
>>>   #include "system/replay.h"
>>>   #include "system/runstate.h"
>>>   #include "trace.h"
>>> +#include "trace/control.h"
>>>
>>>   #define AUDIO_CAP "audio"
>>>   #include "audio_int.h"
>>>
>>>   /* #define DEBUG_OUT */
>>>   /* #define DEBUG_CAPTURE */
>>> -/* #define DEBUG_POLL */
>>>
>>>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>>>
>>> @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const char *msg)
>>>       audio_run_in(s);
>>>       audio_run_capture(s);
>>>
>>> -#ifdef DEBUG_POLL
>>> -    {
>>> -        static double prevtime;
>>> -        double currtime;
>>> -        struct timeval tv;
>>> -
>>> -        if (gettimeofday (&tv, NULL)) {
>>> -            perror ("audio_run: gettimeofday");
>>> -            return;
>>> -        }
>>> -
>>> -        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
>>> -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
>>> -        prevtime = currtime;
>>> +    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
>>> +        /* Convert seconds to microseconds for trace event */
>>> +        int64_t elapsed_us = g_timer_elapsed(s->run_timer, NULL) * 1000000;
>>
>> Not being familiar with g_timer_elapsed() I had a look at the glib docs,
>> and it seems that g_timer_elapsed() returns a gdouble as opposed to an
>> int64_t?
>
> yes, as seconds. So it is multiplied by 1000000 to get back usec, as before

There's #define NANOSECONDS_PER_SECOND 1000000000LL in qemu/timer.h. Do we 
need a MICROSECONDS_PER_SECOND constant there (or defined here) to make it 
more obvious?

Regards,
BALATON Zoltan
--3866299591-1956513522-1771071195=:43665--

