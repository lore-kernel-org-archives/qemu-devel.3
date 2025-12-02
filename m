Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91619CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP4G-0005oi-ST; Tue, 02 Dec 2025 07:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQP4F-0005oV-9T
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:01:15 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQP48-0005st-Sk
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:01:15 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D6205969FB;
 Tue, 02 Dec 2025 13:01:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LWBfakUaoU7k; Tue,  2 Dec 2025 13:01:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 121BD5969F9; Tue, 02 Dec 2025 13:01:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 102E15969F6;
 Tue, 02 Dec 2025 13:01:05 +0100 (CET)
Date: Tue, 2 Dec 2025 13:01:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 geoff@hostfission.com
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <aS3wKkxxrekvIWuc@redhat.com>
Message-ID: <a79a1247-a218-fb0b-746c-01c97a9781e6@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <fdd7e1c4-a2a5-4039-59a9-9afda763feea@eik.bme.hu>
 <aS3wKkxxrekvIWuc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-138701619-1764676865=:34920"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-138701619-1764676865=:34920
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 1 Dec 2025, Daniel P. Berrangé wrote:
> On Mon, Dec 01, 2025 at 08:30:26PM +0100, BALATON Zoltan wrote:
>> On Mon, 1 Dec 2025, Marc-André Lureau wrote:
>>> On Mon, Dec 1, 2025 at 5:03 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> The following patch series provides a GStreamer-based audio backend,
>>>> which could
>>>>> ultimately allow QEMU to leverage the framework to support the various
>>>> audio
>>>>> subsystems and simplify the audio handling logic (timing, resampling,
>>>> mixing
>>>>> etc), as well as allow greater pipeline flexibility and customization.
>>>>
>>>> While it's good to have a GStreamer backend to integrate well into systems
>>>> already using that, this should not replace existing audio backends in
>>>> QEMU. The reason is that GStreamer has extensive dependencies that I would
>>>>
>>>
>>> GStreamer itself is not so big and doesn't have that many dependencies that
>>> qemu doesn't already have.
>>
>> Except that this proposal uses GStreamer from rust so would also pull in all
>> the rust dependencies too which is still not needed for QEMU. Saying that
>> it's optional but then you lose audio output is also not quite acceptable.
>
> In terms of replacing the existing audio backends, it would simply have to
> wait until we declare Rust to be a mandatory dependency of QEMU, before
> proposing any removal of existing backends.
>
>>>> as another audio backend but not as a replacement for QEMU's audio
>>>> handling logic and backends.
>>>
>>> It would be great if people with very specific or constrained requirements
>>> on qemu audio could check if the GStreamer backend fits their need.
>>
>> At least one of them already said it wouldn't. Also why somebody not running
>> a desktop environment that uses GStreamer would want to add that dependency
>> and use a GStreamer plugin to get the sound back to their native sound
>> service when it is probably already supported by QEMU directly? QEMU also
>> has to support Windows and macOS sound services so having a few more
>> Linux/Unix ones does not make it much more complex.
>
> GStreamer is not merely for desktop environments. It is a general purpose
> audio system, and in terms of QEMU, it is already used by the Spice server
> for video encoding purposes.  IMHO it is reasonable to consider whether
> QEMU could use GStreamer for all audio output regardless of whether it is
> running from a desktop session or not.

But it's most likely found as dependency in apps that already use other 
libraries from the same family that usually come with a certain desktop 
environment. Also spice does not want to replace all the other display 
backends or SDL does not replace other sound backends so the same way it's 
fine to add a GStreamer as another optional way to output sound but not as 
replacing the existing backends and sound infrastructure in QEMU.

> Personally my main concern with gstreamer is that when things go wrong
> it can be very difficult to understand why and thus hard to figure out
> how to fix it, unless you're pretty experienced with gstreamer.
>
> If we do consider rationalizing how many backends we have, IMHO, it
> would be desirable to retain at least one other QEMU audio backend
> that is considered simple & reliable (fool proof) to use & debug.

That probably means we should retain at least the lowest level output for 
the native sound systems of the OSes where QEMU runs but then we can also 
have other backends as the main complexity is in the audio infrastructure 
and not in the backends. What may be possible is to drop OSS and the 
mixing support that is mainly needed for OSS arguing that ALSA has 
replaced OSS on Linux and sndio replaced it on BSD and these can already 
do resampling and mixing themselves so this could simplify QEMU audio code 
to just pass data to a sound service but I'm not sure this feature isn't 
used by some people in QEMU with other backends or to record to wav for 
example. If we remove that too saying that recording can be done from the 
system native sound service then maybe no need for resampling and mixing 
in QEMU at least for output. But what about input where both the system 
and the emulated cards are limited to some specific samping rates and they 
are not set to use the same? Or do the sound services take care of that 
too and you can ask for arbitrary input rate and will it convert from 
hardware rate or you get back an error and QEMU has to handle this?

Regards,
BALATON Zoltan
--3866299591-138701619-1764676865=:34920--

