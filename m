Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EC3C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 21:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfbu-0004wE-Ou; Mon, 24 Feb 2025 16:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmfbr-0004tf-AN; Mon, 24 Feb 2025 16:03:27 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmfbn-000749-Vv; Mon, 24 Feb 2025 16:03:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3AE904E60F5;
 Mon, 24 Feb 2025 22:03:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id WSpVHH6QwV6V; Mon, 24 Feb 2025 22:03:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 45F164E6010; Mon, 24 Feb 2025 22:03:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4455E74577C;
 Mon, 24 Feb 2025 22:03:18 +0100 (CET)
Date: Mon, 24 Feb 2025 22:03:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <F5E0CFB5-ABE9-448E-B76B-4D08D541A092@gmail.com>
Message-ID: <29c166d7-9232-e1db-32f5-efb517bccae3@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
 <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
 <81cd9319-848c-93f5-156d-b35226f90966@eik.bme.hu>
 <4023E866-442D-408B-9BD7-9036694DD8DF@gmail.com>
 <a4083d0c-acd5-f9da-66da-d796d09a0808@eik.bme.hu>
 <F5E0CFB5-ABE9-448E-B76B-4D08D541A092@gmail.com>
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

On Thu, 20 Feb 2025, Bernhard Beschow wrote:
> Am 13. Februar 2025 00:13:24 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> Yes, your DTB based board code is a nice way to create different 
>> machines as the DTB already describes these offsets and irq connections 
>> and your code seems to be quite simple so I think it's a good idea 
>> that's worth pursuing, that could enhance the ppce500 machine and make 
>> it more generic. It could then also drop the separate mpc85xx machine 
>> and put all of these under one ppce500 machine with passing the right 
>> dtb to create the different machines. As long as these are similar 
>> enough and only differ in the devices they have, this could emulate a 
>> lot of these SoCs with the same code.
>
> The existing machines can already be created from a DTB, see the pc-bios 
> folder which contains the two respective .dts files.

That's why I said that once this is merged we could deprecate the existing 
machines in favour of ppc500 with the dts for these machines replacing 
them so we can get rid of board codes and can add new machines like p1022 
by adding the needed devices and the dts also under ppce500 which can 
become a generic machine supporting all of these. One could then use -M 
ppce500 -dtb mpc85xx.dtb or p1022.dtb or similar. This would work for all 
dtbs that we have devices for and maybe by adding unimplemented device for 
unknown ones would allow somewhat booting other machines as long as those 
devices are not use. Or if keeping a machine for the -M option for all of 
these is desired then we can think of adding some other kind of alias that 
can set the dtb for the ppce500 and call that. But in any case this would 
reduce the mpc85xx to a trivial wrapper of ppce500 that just sets the dtb 
for the machine.

> Thanks for your input, I'll look into it closer after my RFC. Right now 
> I'm quite busy driving the i.MX 8M Plus machine forward, hence my 
> delayed responses.
>
>> What I may contribute is new device emulation for missing parts. I have 
>> some dummy sata that does nothing but allows the Linux driver to pass 
>> detecting no devices, a half working DIU I made in the last few days 
>> that needs more work but I got some image from U-Boot on it and may 
>> look at the DMA controller in the future. Let me know if you're 
>> interested in these or have something for these or other parts I could 
>> use instead. I've tested your SPI flash implementation but it wasn't 
>> working with U-Boot for me and may look at your USB eventually.
>
> Your additions sound promising! And thanks for testing the devices.

I also got distracted with other machines so I've postponed this for now 
but want to get back to it eventually.

Regards,
BALATON Zoltan

