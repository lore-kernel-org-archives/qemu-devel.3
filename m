Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53699CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP6y-0008Pp-VH; Tue, 02 Dec 2025 07:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQP6v-0008LG-IM
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:04:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQP6s-0000Dv-Gw
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:03:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 435045969FA;
 Tue, 02 Dec 2025 13:03:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5ucnpFxcPJWs; Tue,  2 Dec 2025 13:03:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 397225969F9; Tue, 02 Dec 2025 13:03:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 373185969F6;
 Tue, 02 Dec 2025 13:03:53 +0100 (CET)
Date: Tue, 2 Dec 2025 13:03:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Alexandre Ratchov <alex@caoua.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 geoff@hostfission.com
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
Message-ID: <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1151089469-1764677033=:34920"
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

--3866299591-1151089469-1764677033=:34920
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 2 Dec 2025, Paolo Bonzini wrote:
> On 12/1/25 21:58, Alexandre Ratchov wrote:
>> On Mon, Dec 01, 2025 at 10:20:49PM +0400, Marc-André Lureau wrote:
>>>> cases. Also when using jack you'd want to have a QEMU backend for it not
>>> It would be great if people with very specific or constrained requirements
>>> on qemu audio could check if the GStreamer backend fits their need.
>> 
>> I'm thinking mainly about their simplicity.
>> 
>> Dropping the system API backends would add an extra sophisticated
>> layer (GStreamer) between the system and the program. In theory, an
>> unlimited number of software layers may be stacked in a program, but
>> the more layers there are, the more fragile the program tends to
>> be. Based on my limited experience, when things went wrong, the system
>> backends were simpler to debug and make work than the big frameworks.
>> 
>> IMHO, the system API backends won't hurt GStreamer users, so I see no
>> reason to remove them.
>
> I mostly agree.  Perhaps the DirectSound backend could be removed by just 
> letting Windows use SDL (unlike macOS, Windows doesn't have a "native" GUI 
> layer), and the ALSA backend is also not so useful in my opinion.  But all 
> the others have a reason to be there.

ALSA is also useful as the native sound backend for Linux. I'd say it can 
already do what pulseaudio or pipewire do so those are not so useful in my 
opinion not ALSA. :-)

Regards,
BALATON Zoltan
--3866299591-1151089469-1764677033=:34920--

