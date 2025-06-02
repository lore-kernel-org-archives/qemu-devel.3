Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C378C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 12:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4Ge-0003hU-0c; Mon, 02 Jun 2025 08:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uM4GR-0003gZ-7B; Mon, 02 Jun 2025 08:27:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uM4GO-0005Em-R3; Mon, 02 Jun 2025 08:27:38 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C763C55BC04;
 Mon, 02 Jun 2025 14:27:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id iItmfGpcoxnN; Mon,  2 Jun 2025 14:27:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D8E4455BC02; Mon, 02 Jun 2025 14:27:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D6AA5745682;
 Mon, 02 Jun 2025 14:27:30 +0200 (CEST)
Date: Mon, 2 Jun 2025 14:27:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 00/16] hw/pci-host/raven clean ups
In-Reply-To: <f07d5a20-30e3-dddc-e15c-745b449af839@eik.bme.hu>
Message-ID: <eeeb2633-93b2-4a43-72a4-b44a85b21940@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <f07d5a20-30e3-dddc-e15c-745b449af839@eik.bme.hu>
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

On Fri, 23 May 2025, BALATON Zoltan wrote:
> On Sun, 4 May 2025, BALATON Zoltan wrote:
>> Hello,
>> 
>> This series cleans up and simplifies the raven model which does some
>> strange stuff that no other pci-host is doing and does it in a
>> convoluted way and also has some legacy bits that can be removed.
>> Apart from making the model much more readable this also fixes the
>> non-contiguous IO control bit which was there but did not work as it
>> was not connected but apparently it's not really used by any guest so
>> that wasn't noticed.
>
> Ping?

Ping^2

>> Regards,
>> BALATON Zoltan
>> 
>> BALATON Zoltan (16):
>>  hw/pci-host/raven: Remove is-legacy-prep property
>>  hw/pci-host/raven: Revert "raven: Move BIOS loading from board code to
>>    PCI host"
>>  hw/pci-host/raven: Simplify PCI facing part
>>  hw/pci-host/raven: Simplify host bridge type declaration
>>  hw/pci-host/raven: Use DEFINE_TYPES macro
>>  hw/pci-host/raven: Simplify PCI bus creation
>>  hw/pci-host/raven: Simplify PCI interrupt routing
>>  hw/pci-host/raven: Simplify direct config access address decoding
>>  hw/pci-host/raven: Rename direct config access ops
>>  hw/pci-host/raven: Use correct parameter in direct access ops
>>  hw/pci-host/raven: Do not use parent object for mmcfg region
>>  hw/pci-host/raven: Fix PCI config direct access region
>>  hw/pci-host/raven: Simpify discontiguous IO access
>>  hw/pci-host/raven: Move bus master address space creation to one place
>>  hw/pci-host/raven: Do not map regions in init method
>>  hw/ppc/prep: Fix non-contiguous IO control bit
>> 
>> hw/pci-host/raven.c       | 395 ++++++++++----------------------------
>> hw/ppc/prep.c             |  46 ++++-
>> hw/ppc/prep_systemio.c    |  14 +-
>> include/hw/pci/pci_host.h |   1 -
>> 4 files changed, 152 insertions(+), 304 deletions(-)
>> 
>> 
>
>

