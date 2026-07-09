Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF38C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whr2N-00029r-Ei; Thu, 09 Jul 2026 11:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whr2L-00029L-MO; Thu, 09 Jul 2026 11:51:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whr2J-0000mT-LC; Thu, 09 Jul 2026 11:51:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E92D2596746;
 Thu, 09 Jul 2026 17:51:34 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id NMthBM7um4Vw; Thu,  9 Jul 2026 17:51:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CDA67596742; Thu, 09 Jul 2026 17:51:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CBC09596741;
 Thu, 09 Jul 2026 17:51:32 +0200 (CEST)
Date: Thu, 9 Jul 2026 17:51:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: A few Machines crash when "no default audio driver available"
In-Reply-To: <ak-i1dNY_RrGNHAM@redhat.com>
Message-ID: <c3999e70-9dcb-5804-f7fc-600ab603c13c@eik.bme.hu>
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org> <ak-i1dNY_RrGNHAM@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1120708212-1783612292=:97021"
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

--3866299591-1120708212-1783612292=:97021
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 9 Jul 2026, Daniel P. Berrangé wrote:
> On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wrote:
>> Cc: mainainters for "Overall Audio backends"
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wrote:
>>>>
>>>> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
>>>> and MIPS machine fuloong2e crashes.
>>>>
>>>> I run them like this:
>>>>
>>>> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio
>>>
>>>> Died when device_set_realized() tried to propagate a "no default audio
>>>> driver available" error to &error_abort.
>>>
>>> Is this something we want to have be a possibility the devices
>>> have to cope with? Can we have the "ignores all audio data"
>>> backend be always available instead?
>>
>> There's plenty of precedence for /dev/null-like backends.
>>
>>> Otherwise every audio device needs to cope with "there is no
>>> audio backend available" and implement "do nothing with the
>>> audio data" itself.
>>
>> Yes.
>
> We've got a bit of tension between "no defaults" and "builtin audio
> devices" here.
>
> Cnosider if I had instead done
>
>  qemu-system-x86_64 -M pc -device ac97 -nodefaults
>
> It is not unreasonable to expect to see an error because you asked
> explicitly for 'ac97'  and forgot to wire up the required audio
> backend, and asked to NOT have any defaults.
>
> But with your 'musicpal' machine example, you never asked for the
> frontend device, so you should be forgiven for also not asking
> for a audio backend.

These machines have an audio device on-board (for pegasos it's part of the 
VIA south bridge) so nodefaults does not change that. I think it would be 
enough to exit with an error message instead of crashing and let the user 
correct the command.

Regards,
BALATON Zoltan
--3866299591-1120708212-1783612292=:97021--

