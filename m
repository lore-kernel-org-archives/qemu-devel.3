Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F285CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOdNN-0006nk-HB; Thu, 27 Nov 2025 09:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vOdNL-0006n1-PC; Thu, 27 Nov 2025 09:53:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vOdNJ-00069w-Mo; Thu, 27 Nov 2025 09:53:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BCD335969FF;
 Thu, 27 Nov 2025 15:53:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id KCjWNuZAGIGB; Thu, 27 Nov 2025 15:53:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 674925969FE; Thu, 27 Nov 2025 15:53:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65AF75969F6;
 Thu, 27 Nov 2025 15:53:33 +0100 (CET)
Date: Thu, 27 Nov 2025 15:53:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>
cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 0/5] block/vvfat: introduce "fat-size" option
In-Reply-To: <20251127142417.710094-1-chigot@adacore.com>
Message-ID: <2535802c-8b9a-bb83-b908-61df51aa8aa1@eik.bme.hu>
References: <20251127142417.710094-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1676134750-1764254933=:65476"
Content-ID: <e07090e5-8164-0756-198f-f71f4dde2649@eik.bme.hu>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1676134750-1764254933=:65476
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <49ab4fc4-1d8c-bb7b-36d2-6e0b60448c40@eik.bme.hu>

On Thu, 27 Nov 2025, Clément Chigot wrote:
> The main goal of this series is to introduce a new option "fat-size"
> within the vvfat backend (patch 5).
>
> This series also includes minor patches:
> - patch 1 introduces another option to create unpartitionned disks.
> - patch 2-4 are minor improvements easing the introducing of
>   "fat-size" option
>
> This was tested on with a aarch64-linux kernel taken from
> functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> workaround, not included here (the SD bus must be associated to the EMMC2
> port instead of through GPIOs).
>
> Changes since v2:
> - patch 1:
>   - change default: true for hard disk, false for false.

Typo: false for floppy

>   - remove "unpartitioned" keyword within filename
> - patch 5
>   - rename option "fs-size"

I'm still not sure if it could be done simpler without adding a separate 
fs-size option and fix size to apply to vvfat instead of raw so it works 
as expected not how it works now. The idea I proposed was to try to set 
format to vvfat if file or protocol contains fat: which was discussed 
here:

https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg01487.html

but I did not understand Kevin's reply if it's possible or why not.

Regards,
BALATON Zoltan

> Clément Chigot (5):
>  vvfat: introduce partitioned option
>  vvfat: move fat_type check prior to size setup
>  vvfat: add a define for VVFAT_SECTOR_BITS and VVFAT_SECTOR_SIZE
>  vvfat: move size parameters within driver structure
>  vvfat: add support for "fs-size" option
>
> block/vvfat.c        | 350 +++++++++++++++++++++++++++++++------------
> qapi/block-core.json |  16 +-
> 2 files changed, 270 insertions(+), 96 deletions(-)
>
>
--3866299591-1676134750-1764254933=:65476--

