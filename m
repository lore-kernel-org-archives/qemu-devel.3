Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBAFEDEBFF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbAT-0003pc-Sf; Tue, 03 Mar 2026 20:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxbAO-0003p9-1S
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:36:49 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxbAC-0007qZ-Gx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:36:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5D2545969FA;
 Wed, 04 Mar 2026 02:36:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MqwZBFsYxs86; Wed,  4 Mar 2026 02:36:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48F8E5969F2; Wed, 04 Mar 2026 02:36:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4080A5969F0;
 Wed, 04 Mar 2026 02:36:33 +0100 (CET)
Date: Wed, 4 Mar 2026 02:36:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v11 17/17] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <DGTLV6S10ROE.37PRQWXFH73W@jablonski.xyz>
Message-ID: <2ec3b2de-63c6-4eba-e097-a0a46f8d6021@eik.bme.hu>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
 <20260303024730.1489136-18-chad@jablonski.xyz>
 <6cd73946-b4e5-873b-eafc-64be19a5a51b@eik.bme.hu>
 <DGTLV6S10ROE.37PRQWXFH73W@jablonski.xyz>
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

On Tue, 3 Mar 2026, Chad Jablonski wrote:
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> Also tested that it works with MorphOS that was known to need it for some
>> font rendering so this fixes Xorg and MorphOS. It is now fully reviewed,
>
> This is great! Thank you Zoltan for all of your time and patience
> reviewing.

Thank you for taking up this work and not giving up and doing an excellent 
work testing real cards and modelling it. Now we just need somebody to 
pick up the patches so it can be merged. Hopefully somebody is still 
reading this thread.

Regards,
BALATON Zoltan

