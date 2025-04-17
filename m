Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD21EC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Wyk-0005Vv-Uh; Thu, 17 Apr 2025 17:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5Wya-0005UD-FO; Thu, 17 Apr 2025 17:40:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5WyX-0002aA-IJ; Thu, 17 Apr 2025 17:40:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0F26F4E602B;
 Thu, 17 Apr 2025 23:40:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Ls5RTI8W24cY; Thu, 17 Apr 2025 23:40:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A4E964E6027; Thu, 17 Apr 2025 23:40:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A281F74577C;
 Thu, 17 Apr 2025 23:40:44 +0200 (CEST)
Date: Thu, 17 Apr 2025 23:40:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Bin Meng <bin.meng@windriver.com>, qemu-ppc@nongnu.org, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v6 3/3] hw/ppc/e500: Add Freescale eSDHC to e500plat
In-Reply-To: <325d3f62-b94b-4391-bdf1-2063da5e3b99@redhat.com>
Message-ID: <d74736e8-6132-2b7e-0037-c1262ce8e388@eik.bme.hu>
References: <20221101222934.52444-1-philmd@linaro.org>
 <20221101222934.52444-4-philmd@linaro.org>
 <325d3f62-b94b-4391-bdf1-2063da5e3b99@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-3320010-1744926044=:26657"
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

--3866299591-3320010-1744926044=:26657
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 17 Apr 2025, Thomas Huth wrote:
> On 01/11/2022 23.29, Philippe Mathieu-Daudé wrote:
>> Adds missing functionality to e500plat machine which increases the
>> chance of given "real" firmware images to access SD cards.
>> 
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> Message-Id: <20221018210146.193159-8-shentey@gmail.com>
>> [PMD: Simplify using create_unimplemented_device("esdhc")]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>
> Hi!
>
> I recently noticed that the QEMU advent calendar 2018 day 19 image 
> (https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz) is flooding 
> the console with "mmc0: Internal clock never stabilised" messages when it's 
> started like this:
>
> /qemu-system-ppc64 -vga none -nographic -monitor none -M ppce500 -cpu e5500 
> -kernel ../day19/uImage
>
> This was not the case when I assembled the image in 2018. I bisected the 
> problem and apparently this patch here is causing the problem. Do you know 
> whether there is a way to fix this again?

That patch added the MMC/SD controller so no wonder it did not appear 
before. The error seems to be in Linux esdhci driver where it checks for:

sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE

So I think that bit should be set somewhere. Berhard had some patches for 
e500 so maybe there's already a fix for this somewhere.

Regards,
BALATON Zoltan
--3866299591-3320010-1744926044=:26657--

