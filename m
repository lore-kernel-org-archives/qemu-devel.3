Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302EBC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEZZ-0005f6-3g; Wed, 14 Feb 2024 07:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@zonque.org>)
 id 1raBFa-0004Ko-CJ; Wed, 14 Feb 2024 04:08:18 -0500
Received: from mail.bugwerft.de ([46.23.86.59])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <daniel@zonque.org>)
 id 1raBFU-0002XS-VU; Wed, 14 Feb 2024 04:08:18 -0500
Received: from [192.168.178.97] (pd95ef237.dip0.t-ipconnect.de [217.94.242.55])
 by mail.bugwerft.de (Postfix) with ESMTPSA id A3818281529;
 Wed, 14 Feb 2024 09:08:06 +0000 (UTC)
Message-ID: <6e97c51e-44bb-4edb-9dbb-1bbc0524b812@zonque.org>
Date: Wed, 14 Feb 2024 10:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Stefan Lehner <stefan-lehner@aon.at>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
From: Daniel Mack <daniel@zonque.org>
In-Reply-To: <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.86.59; envelope-from=daniel@zonque.org;
 helo=mail.bugwerft.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Feb 2024 07:40:58 -0500
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

On 2/13/24 21:11, Arnd Bergmann wrote:
> On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote:
>> On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
>>> On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On 2/12/24 04:32, Peter Maydell wrote:
>>>>> The machines I have in mind are:
>>>>>
>>>>> PXA2xx machines:
>>>>>
>>>>> akita                Sharp SL-C1000 (Akita) PDA (PXA270)
>>>>> borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
>>>>> connex               Gumstix Connex (PXA255)
>>>>> mainstone            Mainstone II (PXA27x)
>>>>> spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
>>>>> terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
>>>>> tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
>>>>> verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
>>>>> z2                   Zipit Z2 (PXA27x)
>>>>>
>>>> I test akita, borzoi, spitz, and terrier. Upstream Linux removed support
>>>> for mainstone, tosa, and z2 from the Linux kernel as of version 6.0, so
> 
> It was 6.3 (about one year ago).
> 
>>>> I am no longer testing those.
>>>>
>>>> I never managed to boot connex or verdex.
> 
> I kept specifically the pxa boards that would be sensible to port
> to devicetree because they had qemu support. gumstix verdex is the
> one with the most RAM out of those; spitz, sharpsl and their
> variants are the ones that some of us still have around.
> 
> Robert had working devicetree support for some machines out of tree
> that he has not submitted, and presumably not worked on since.
> 
> Unless someone starts working on converting the remaining
> pxa board files to DT, we can probably remove them after the
> next LTS kernel a year from now.

I agree. Once the machines are removed, people who were actively using
them would be incentivized to work on a DT port. That's not very
complicated to do when you have the hardware to test, but almost
impossible if you don't.


Best regards,
Daniel



