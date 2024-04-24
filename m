Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYnC-00064U-GP; Wed, 24 Apr 2024 05:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzYnA-00062G-HB; Wed, 24 Apr 2024 05:19:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzYn8-0001LD-7c; Wed, 24 Apr 2024 05:19:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A69844E6031;
 Wed, 24 Apr 2024 11:19:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aKWIqD-YTIsd; Wed, 24 Apr 2024 11:19:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5CE454E6042; Wed, 24 Apr 2024 11:19:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5A39074570D;
 Wed, 24 Apr 2024 11:19:43 +0200 (CEST)
Date: Wed, 24 Apr 2024 11:19:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Chris Wulff <crwulff@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH-for-9.1 05/21] target/m68k: Replace qemu_printf() by
 monitor_printf() in monitor
In-Reply-To: <87sezb43hd.fsf@pond.sub.org>
Message-ID: <605a2b47-0ff3-e7b6-17c7-ececed274e5d@eik.bme.hu>
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-6-philmd@linaro.org> <87sezb43hd.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-92495229-1713950383=:22090"
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

--3866299591-92495229-1713950383=:22090
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 24 Apr 2024, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>
>> Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.
>
> Why?  Here's my attempt at an answer: because this runs only within HMP
> command "info tlb".  Using qemu_printf() there isn't wrong, but with
> monitor_printf(), it's obvious that we print to the monitor.
>
> On monitor_printf() vs. monitor_puts().
>
> qemu_printf() behaves like monitor_printf() when monitor_cur() returns
> non-null, which it certainly does within a monitor command.
>
> monitor_printf() prints like monitor_puts() when monitor_is_qmp()
> returns false, which it certainly does within an HMP command.
>
> Note: despite their names, monitor_printf() and monitor_puts() are at
> different interface layers!
>
> We need a low-level function to send to a monitor, be it HMP or QMP:
> monitor_puts().
>
> We need a high-level function to format JSON and send it to QMP:
> qmp_send_response().
>
> We need a high-level functions to format text and send it to HMP:
> monitor_printf(), ...
>
> Naming the functions that expect an HMP monitor hmp_FOO() would make
> more sense.  Renaming them now would be quite some churn, though.
> Discussed at
> <https://lore.kernel.org/qemu-devel/87y1adm0os.fsf@pond.sub.org/>.

The hmp_ prefix is more cryptic than monitor_. Without knowing QEMU too 
much I can guess what monitor_ does but would have to look up what 
hmp_means so keeping monitor_ is better IMO. The solution to the naming 
issue mentioned above may be renaming monitor_puts to something that tells 
it's a low level function (and add a momitor_puts that behaves as 
expected) but I can't come up with a name either. Maybe the low level 
function could be called hmp_putt? Or add a comment near monitor_puts to 
explain this for now.

Regards,
BALATON Zoltan
--3866299591-92495229-1713950383=:22090--

