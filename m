Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0707CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJu3-0006uI-8f; Thu, 18 Sep 2025 15:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJu0-0006t6-LA; Thu, 18 Sep 2025 15:02:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJtx-0005ay-0P; Thu, 18 Sep 2025 15:02:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1C98F56F295;
 Thu, 18 Sep 2025 21:02:36 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 6ffIxdzY7ZAT; Thu, 18 Sep 2025 21:02:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2033756F30D; Thu, 18 Sep 2025 21:02:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1E64856F30C;
 Thu, 18 Sep 2025 21:02:34 +0200 (CEST)
Date: Thu, 18 Sep 2025 21:02:34 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/14] hw/pci-host/raven clean ups
In-Reply-To: <ab4c89df-f3bc-4e4a-b514-b77516479d53@ilande.co.uk>
Message-ID: <af74f0e1-1488-2599-2ed9-5d32ed1f5bbe@eik.bme.hu>
References: <cover.1751493467.git.balaton@eik.bme.hu>
 <6b16ad7b-2538-55b5-e512-4faf735f0b41@eik.bme.hu>
 <ab4c89df-f3bc-4e4a-b514-b77516479d53@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2034509976-1758222154=:26402"
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

--3866299591-2034509976-1758222154=:26402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
> On 17/09/2025 12:19, BALATON Zoltan wrote:
>
>> On Thu, 3 Jul 2025, BALATON Zoltan wrote:
>>> Hello,
>> 
>> Ping? Do we have hw/ppc maintainers who can look at this and merge it?
>
> Apologies for the delay, things have been quite hectic here. I'll take a look 
> now.

Thank you, Just sent a v3 so make sure you look at that (although it's 
much the same).

Regards,
BALATON Zoltan
>> 
>>> This series cleans up and simplifies the raven model which does some
>>> strange stuff that no other pci-host is doing and does it in a
>>> convoluted way and also has some legacy bits that can be removed.
>>> Apart from making the model much more readable this also fixes the
>>> non-contiguous IO control bit which was there but did not work as it
>>> was not connected but apparently it's not really used by any guest so
>>> that wasn't noticed.
>>> 
>>> Regards,
>>> BALATON Zoltan
>>> 
>>> v2:
>>> - rebase on master
>>> - add R-b tags from Philippe
>>> 
>>> BALATON Zoltan (14):
>>>  hw/pci-host/raven: Simplify PCI facing part
>>>  hw/pci-host/raven: Simplify host bridge type declaration
>>>  hw/pci-host/raven: Use DEFINE_TYPES macro
>>>  hw/pci-host/raven: Simplify PCI bus creation
>>>  hw/pci-host/raven: Simplify PCI interrupt routing
>>>  hw/pci-host/raven: Simplify direct config access address decoding
>>>  hw/pci-host/raven: Rename direct config access ops
>>>  hw/pci-host/raven: Use correct parameter in direct access ops
>>>  hw/pci-host/raven: Do not use parent object for mmcfg region
>>>  hw/pci-host/raven: Fix PCI config direct access region
>>>  hw/pci-host/raven: Simpify discontiguous IO access
>>>  hw/pci-host/raven: Move bus master address space creation to one place
>>>  hw/pci-host/raven: Do not map regions in init method
>>>  hw/ppc/prep: Fix non-contiguous IO control bit
>>> 
>>> hw/pci-host/raven.c       | 328 ++++++++++++--------------------------
>>> hw/ppc/prep.c             |  19 ++-
>>> hw/ppc/prep_systemio.c    |  14 +-
>>> include/hw/pci/pci_host.h |   1 -
>>> 4 files changed, 127 insertions(+), 235 deletions(-)
>
>
> ATB,
>
> Mark.
>
>
>
--3866299591-2034509976-1758222154=:26402--

