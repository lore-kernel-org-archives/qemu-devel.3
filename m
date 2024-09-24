Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E811CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 21:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stCjv-0006jB-GH; Tue, 24 Sep 2024 17:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1stCjt-0006fm-9G; Tue, 24 Sep 2024 17:06:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1stCjq-0001VM-7H; Tue, 24 Sep 2024 17:06:28 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0AF874E602B;
 Tue, 24 Sep 2024 23:06:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3dgbEMkEQyEW; Tue, 24 Sep 2024 23:06:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0F6D84E6030; Tue, 24 Sep 2024 23:06:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0DAD3757B27;
 Tue, 24 Sep 2024 23:06:20 +0200 (CEST)
Date: Tue, 24 Sep 2024 23:06:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 09/23] hw/ppc/mpc8544_guts: Populate POR PLL ratio status
 register
In-Reply-To: <3A538E68-B44E-4BA6-B48B-B411D108369C@gmail.com>
Message-ID: <f176519b-242f-f82d-4259-ae0b25d1db91@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-10-shentey@gmail.com>
 <3037d1f0-6e44-98ee-48fc-1bb206ebc624@eik.bme.hu>
 <56E67259-70A9-44E5-A3C2-6E40363A73C2@gmail.com>
 <da2c3d7a-8d75-0e7c-e47e-ab329d64841a@eik.bme.hu>
 <3A538E68-B44E-4BA6-B48B-B411D108369C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Tue, 24 Sep 2024, Bernhard Beschow wrote:
> Am 24. September 2024 09:59:21 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>>> Am 23. September 2024 10:43:19 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>>> On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>>>>> Populate this read-only register with some arbitrary values which avoids
>>>>> U-Boot's get_clocks() to hang().
>>>>
>>>> Maybe this should be a property settable by the machine as each board may have different values and it may need to use the correct value for the machine.
>>>
>>> I actually considered this but went with the pragmatic solution to avoid over-engineering. In particular, I wanted to avoid further machine-specitic attributes in the machine class struct. Or do you expect a new e500 machine to be added? In that case I'd set above arbitrary values as default and expect a new machine to override these properties.
>>
>> Can't override if there's no property for it. There's one machine I may be interested in that uses a Freescale e500 SoC. That one seems to use 0x0606180c for this value which I think corresponds to 0/1 Ratio both 3:1, DDR Ratio 12:1 and Plat Ratio 6:1. I think one property to set the 32 bit value without individual fields would be enough and we can put comments next to the value if needed to note what components it comes from. Or if you just need any value here maybe you could take this one then that would be good for me as well.
>
> Let's use your numbers then without a property. Any specific machine I 
> should mention in the commit message? Tabor?

That's also OK with me. No need to mention any specific machine as I'm not 
sure I'll ever finish it. So far it's only an experiment and only planned 
to submit the small patches that came out of it but it's not emulating any 
machine yet.

>> (I have some patches adding second i2c bus and SPD data that are needed for U-Boot for memory detection but it needs more clean up before I can submit it and also waiting for these patches to avoid conflict.)
>
> Neat. That means we'll get DDR3 support?

That's the plan eventually but I don't know when will I have time to do 
that. So far I had a hard coded SPD data for testing but I wanted to 
update the generating function for a while but lacked time for it. This 
gives another reason to do that finally but may take a while.

Regards,
BALATON Zoltan

