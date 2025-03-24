Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB50C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 07:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twcR4-0006pN-AX; Mon, 24 Mar 2025 03:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=sfo0=WL=kaod.org=clg@ozlabs.org>)
 id 1twcQz-0006p9-EC; Mon, 24 Mar 2025 03:41:21 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=sfo0=WL=kaod.org=clg@ozlabs.org>)
 id 1twcQv-0003vN-Tj; Mon, 24 Mar 2025 03:41:21 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZLlNT40F1z4x8X;
 Mon, 24 Mar 2025 18:41:13 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZLlNQ4993z4wcd;
 Mon, 24 Mar 2025 18:41:10 +1100 (AEDT)
Message-ID: <57ce8d50-db92-44f0-96a9-e1297eea949f@kaod.org>
Date: Mon, 24 Mar 2025 08:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Power11 support for QEMU [PowerNV]
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250308205141.3219333-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=sfo0=WL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.062, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Aditya,

On 3/8/25 21:51, Aditya Gupta wrote:
> Overview
> ============
> 
> Add support for Power11 powernv machine type, to emulate PowerNV VMs
> running on Power11.

Could you please consider deprecating the POWER8NVL and POWER8E CPUs
and associated chips and machines ? I think keeping POWER8 is fine
since it has different HW implementation from the following generations.
However, the POWER8NVL and POWER8E variants don't add much to QEMU.
They were practical at one point for bringup (2014). They are not
anymore.

This will remove some lpc peculiarities.

Thanks,

C.



> 
> As Power11 core is same as Power10, hence much of the code has been reused
> from Power10. And Power10 PNV Chip has been declared as parent of Power11
> PNV Chip so that any existing/new functionality can also be reused for
> Power11.
> 
> This parent/child hierarchy causes an issue in .instance_init, as parent's
> instance_init is also called for the child object. Skip initialising child
> objects in P10's instance init if we have a P11 chip, this prevents
> initialising same objects twice by p10 and p11 instance inits.
> 
> Power11 PSeries already added in QEMU in:
>    commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")
> 
> Git Tree for Testing
> ====================
> 
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v5
> 
> Has been tested with following cases:
> * '-M powernv' / '-M powernv10' / '-M powernv11'
> * '-smp' option tested
> 
> skiboot with Power11 support: https://github.com/open-power/skiboot, since
> commit 785a5e3
> 
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1
> 
> Note: Functional test not added now, will add as soon as op-build releases
> new kernel image with Power11 support
> 
> Changelog
> =========
> v5:
>    + add chiptod
>    + add instance_init for P11 to use P11 models
>    + move patch introducing Pnv11Chip to the last
>    + update skiboot.lid to skiboot's upstream/master
> 
> v4:
>    + patch #5: fix memory leak in pnv_chip_power10_quad_realize
>    - no change in other patches
> 
> v3:
>    + patch #1: version power11 as power11_v2.0
>    + patch #2: split target hw/pseries code into patch #2
>    + patch #3,#4: fix regression due to Power10 and Power11 having same PCR
>    + patch #5: create pnv_chip_power11_dt_populate and split pnv_chip_power10_common_realize as per review
>    + patch #6-#11: no change
>    - remove commit to make Power11 as default
> 
> v2:
>    + split powernv patch into homer,lpc,occ,psi,sbe
>    + reduce code duplication by reusing power10 code
>    + make power11 as default
>    + rebase on qemu upstream/master
>    + add more information in commit descriptions
>    + update docs
>    + update skiboot.lid
> 
> Aditya Gupta (8):
>    ppc/pnv: Add HOMER for POWER11
>    ppc/pnv: Add a LPC controller for POWER11
>    ppc/pnv: Add OCC for Power11
>    ppc/pnv: Add a PSI bridge model for Power11
>    ppc/pnv: Add SBE model for Power11
>    ppc/pnv: Add ChipTOD model for Power11
>    ppc/pnv: Add a Power11 Pnv11Chip, and a Power11 Machine
>    ppc/pnv: Update skiboot to support Power11
> 
>   docs/system/ppc/powernv.rst            |   9 +-
>   hw/ppc/pnv.c                           | 177 ++++++++++++++++++++++++-
>   hw/ppc/pnv_chiptod.c                   |  37 ++++++
>   hw/ppc/pnv_core.c                      |  11 ++
>   hw/ppc/pnv_homer.c                     |   8 ++
>   hw/ppc/pnv_lpc.c                       |  14 ++
>   hw/ppc/pnv_occ.c                       |  14 ++
>   hw/ppc/pnv_psi.c                       |  24 ++++
>   hw/ppc/pnv_sbe.c                       |  15 +++
>   include/hw/ppc/pnv.h                   |   5 +
>   include/hw/ppc/pnv_chip.h              |   7 +
>   include/hw/ppc/pnv_chiptod.h           |   2 +
>   include/hw/ppc/pnv_core.h              |   1 +
>   include/hw/ppc/pnv_homer.h             |   3 +
>   include/hw/ppc/pnv_lpc.h               |   4 +
>   include/hw/ppc/pnv_occ.h               |   2 +
>   include/hw/ppc/pnv_psi.h               |   2 +-
>   include/hw/ppc/pnv_sbe.h               |   2 +
>   pc-bios/skiboot.lid                    | Bin 2527328 -> 2527424 bytes
>   19 files changed, 321 insertions(+), 10 deletions(-)
> 


