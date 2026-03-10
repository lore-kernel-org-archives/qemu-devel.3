Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2217FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzziw-0007Kn-Hc; Tue, 10 Mar 2026 12:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzzih-0007J2-9s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:14:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzzia-0006m3-LY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:14:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E965D5969F3;
 Tue, 10 Mar 2026 17:13:56 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Olu3nhhoUBJd; Tue, 10 Mar 2026 17:13:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E89485969EC; Tue, 10 Mar 2026 17:13:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E6ECC5966F4;
 Tue, 10 Mar 2026 17:13:54 +0100 (CET)
Date: Tue, 10 Mar 2026 17:13:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
In-Reply-To: <CAFEAcA9nAup6PLQRBLb92kyAQOJhnx5ahe-u7nwaZq7kFZuSfw@mail.gmail.com>
Message-ID: <be95ee50-545d-d794-d0cc-e449b354a1d5@eik.bme.hu>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
 <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
 <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
 <18a50a29-1deb-41c5-91f1-ae5f76129a05@linaro.org>
 <9233d54a-1a95-0cc9-c118-9c557b8bae4b@eik.bme.hu>
 <4425f6c4-7003-4d6d-9842-3b9c320be0f6@linaro.org>
 <c551ef96-ca0e-01fb-02c0-435851d5cdc5@eik.bme.hu>
 <CAFEAcA9nAup6PLQRBLb92kyAQOJhnx5ahe-u7nwaZq7kFZuSfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Tue, 10 Mar 2026, Peter Maydell wrote:
> On Tue, 10 Mar 2026 at 14:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> I did not know I can get access to Coverity. Then I can take a look there.
>> I still think there's nothing to fix here because even if uint16_t
>> default_sc_bottom is promoted to int for the calculation we don't support
>> 32 bit hosts any more so this can't get sign extension issue even in that
>> case. So I think Converity is just confused here and we should not make
>> code more complex for it.
>
> None of the types here depend on whether the host is 32 bit or 64 bit:
> * default_sc_bottom is "uint16_t", which is always 16 bits unsigned
> * (default_sc_bottom << 16) is "int", which is 32-bit and signed
>   on any platform we have ever cared about

Yes you're right this is what causes the warning here.

> * val is "uint64_t", which is always 64 bits unsigned
>
> So if default_sc_bottom bit 15 is set (0x8000) then we will end up
> with an "int" value 0x8000_0000 (shift by 16 into the sign bit),
> which then gets sign-extended to give a uint64_t
> 0xffff_ffff_8000_0000 when it is assigned to val.
>
> Coverity warns about this because "I took an unsigned type
> and shifted it right and assigned it to a larger unsigned type,
> and in the middle of that it got handled as signed" is one
> of C's unintuitive corners.
>
> The thing that makes this specific case not a bug is that the value
> of default_sc_bottom is always masked so that bit 15 is zero
> (which is not something Coverity's analysis is capable of
> spotting, because it's too far removed from the site of the
> sign-extension).
>
> We are about 50:50 on whether we prefer to mark these as
> false-positives or else to insert a cast or other thing
> to enforce that the intermediate type in the shift is
> unsigned.

If we want to fix it I think making val uint32_t would be better than a 
cast just in this one case as that would avoid all similar problems in 
other cases too, wouldn't it?

Regards,
BALATON Zoltan

