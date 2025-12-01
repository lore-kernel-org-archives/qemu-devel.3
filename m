Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27893D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9bw-0004bN-EZ; Mon, 01 Dec 2025 14:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQ9bV-0004V6-TU
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:30:36 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQ9bT-0003PN-S2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:30:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B7A155969FA;
 Mon, 01 Dec 2025 20:30:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5Vdp5bPjGtTh; Mon,  1 Dec 2025 20:30:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ABB685969F6; Mon, 01 Dec 2025 20:30:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A98BA5969F4;
 Mon, 01 Dec 2025 20:30:26 +0100 (CET)
Date: Mon, 1 Dec 2025 20:30:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 geoff@hostfission.com
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
Message-ID: <fdd7e1c4-a2a5-4039-59a9-9afda763feea@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1105212417-1764617426=:37052"
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

--3866299591-1105212417-1764617426=:37052
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 1 Dec 2025, Marc-André Lureau wrote:
> On Mon, Dec 1, 2025 at 5:03 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Hi,
>>>
>>> The following patch series provides a GStreamer-based audio backend,
>> which could
>>> ultimately allow QEMU to leverage the framework to support the various
>> audio
>>> subsystems and simplify the audio handling logic (timing, resampling,
>> mixing
>>> etc), as well as allow greater pipeline flexibility and customization.
>>
>> While it's good to have a GStreamer backend to integrate well into systems
>> already using that, this should not replace existing audio backends in
>> QEMU. The reason is that GStreamer has extensive dependencies that I would
>>
>
> GStreamer itself is not so big and doesn't have that many dependencies that
> qemu doesn't already have.

Except that this proposal uses GStreamer from rust so would also pull in 
all the rust dependencies too which is still not needed for QEMU. Saying 
that it's optional but then you lose audio output is also not quite 
acceptable.

>> like to avoid and still be able to use QEMU with just an ALSA or SDL audio
>> backend that are much leaner and provide the needed functionality for most
>>
>
> SDL audio is itself a wrapper for various audio backends, much like
> GStreamer in the end, but with arguably less flexibility.

Yes, but as QEMU has SDL for systems where that's supported it could also 
have GStreamer as another option but not as the sole option replacing 
other backends.

>> cases. Also when using jack you'd want to have a QEMU backend for it not
>> going through multiple layers. So adding a GStreamer backend has its use
>>
>
> I wonder what are the advantages of using JACK compared to ALSA, or
> pulse/pipewire, tbh.

Jack has capability to route between sources and sinks with low latency 
which pulse/pipewire does not have and it allows processing sound better 
than using plain ALSA. Jack is useful for example when running sound tools 
in virtual machines and want to integrate with host sound tools that 
usually support jack. ALSA is useful if you just want to output sound the 
simplest way without adding latency or complexity. The other backends are 
useful to integrate with other apps/environments using those sound 
services.

>> as another audio backend but not as a replacement for QEMU's audio
>> handling logic and backends.
>
> It would be great if people with very specific or constrained requirements
> on qemu audio could check if the GStreamer backend fits their need.

At least one of them already said it wouldn't. Also why somebody not 
running a desktop environment that uses GStreamer would want to add that 
dependency and use a GStreamer plugin to get the sound back to their 
native sound service when it is probably already supported by QEMU 
directly? QEMU also has to support Windows and macOS sound services so 
having a few more Linux/Unix ones does not make it much more complex.

Regards,
BALATON Zoltan
--3866299591-1105212417-1764617426=:37052--

