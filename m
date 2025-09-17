Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44007CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqBz-0003yo-4u; Wed, 17 Sep 2025 07:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uyqBx-0003yG-Al; Wed, 17 Sep 2025 07:19:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uyqBu-0005II-BO; Wed, 17 Sep 2025 07:19:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F8D056F295;
 Wed, 17 Sep 2025 13:19:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id sRP8pLwY62WM; Wed, 17 Sep 2025 13:19:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8327A56F31B; Wed, 17 Sep 2025 13:19:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8179356F30D;
 Wed, 17 Sep 2025 13:19:07 +0200 (CEST)
Date: Wed, 17 Sep 2025 13:19:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/14] hw/pci-host/raven clean ups
In-Reply-To: <cover.1751493467.git.balaton@eik.bme.hu>
Message-ID: <6b16ad7b-2538-55b5-e512-4faf735f0b41@eik.bme.hu>
References: <cover.1751493467.git.balaton@eik.bme.hu>
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

On Thu, 3 Jul 2025, BALATON Zoltan wrote:
> Hello,

Ping? Do we have hw/ppc maintainers who can look at this and merge it?

Regards,
BALATON Zoltan

> This series cleans up and simplifies the raven model which does some
> strange stuff that no other pci-host is doing and does it in a
> convoluted way and also has some legacy bits that can be removed.
> Apart from making the model much more readable this also fixes the
> non-contiguous IO control bit which was there but did not work as it
> was not connected but apparently it's not really used by any guest so
> that wasn't noticed.
>
> Regards,
> BALATON Zoltan
>
> v2:
> - rebase on master
> - add R-b tags from Philippe
>
> BALATON Zoltan (14):
>  hw/pci-host/raven: Simplify PCI facing part
>  hw/pci-host/raven: Simplify host bridge type declaration
>  hw/pci-host/raven: Use DEFINE_TYPES macro
>  hw/pci-host/raven: Simplify PCI bus creation
>  hw/pci-host/raven: Simplify PCI interrupt routing
>  hw/pci-host/raven: Simplify direct config access address decoding
>  hw/pci-host/raven: Rename direct config access ops
>  hw/pci-host/raven: Use correct parameter in direct access ops
>  hw/pci-host/raven: Do not use parent object for mmcfg region
>  hw/pci-host/raven: Fix PCI config direct access region
>  hw/pci-host/raven: Simpify discontiguous IO access
>  hw/pci-host/raven: Move bus master address space creation to one place
>  hw/pci-host/raven: Do not map regions in init method
>  hw/ppc/prep: Fix non-contiguous IO control bit
>
> hw/pci-host/raven.c       | 328 ++++++++++++--------------------------
> hw/ppc/prep.c             |  19 ++-
> hw/ppc/prep_systemio.c    |  14 +-
> include/hw/pci/pci_host.h |   1 -
> 4 files changed, 127 insertions(+), 235 deletions(-)
>
>

