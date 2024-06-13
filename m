Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646A2C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHjog-0000Zr-L5; Thu, 13 Jun 2024 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9LeC=NP=kaod.org=clg@ozlabs.org>)
 id 1sHjod-0000ZP-Qp; Thu, 13 Jun 2024 08:44:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9LeC=NP=kaod.org=clg@ozlabs.org>)
 id 1sHjoa-0001jY-Ph; Thu, 13 Jun 2024 08:44:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W0MYK4qVqz4xsB;
 Thu, 13 Jun 2024 22:44:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0MYG23SVz4xsD;
 Thu, 13 Jun 2024 22:44:17 +1000 (AEST)
Message-ID: <e2113792-8715-4d75-b730-fdd29492566e@kaod.org>
Date: Thu, 13 Jun 2024 14:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240610062105.49848-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9LeC=NP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/10/24 8:20 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series remove uses of Monitor in hw/ppc/,
> replacing by the more generic HumanReadableText.
> Care is taken to keep the commit bisectables by
> updating functions one by one, also easing review.
> 
> For rationale see previous series from Daniel:
> https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (26):
>    hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
>    hw/ppc: Avoid using Monitor in icp_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
>    hw/ppc: Avoid using Monitor in ics_pic_print_info()
>    hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
>    hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
>    hw/ppc: Avoid using Monitor in
>      SpaprInterruptControllerClass::print_info()
>    hw/ppc: Avoid using Monitor in spapr_irq_print_info()
>    hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
>    hw/ppc: Avoid using Monitor in pic_print_info()
> 
>   include/hw/pci-host/pnv_phb3.h |   2 +-
>   include/hw/pci-host/pnv_phb4.h |   2 +-
>   include/hw/ppc/pnv_chip.h      |   4 +-
>   include/hw/ppc/pnv_psi.h       |   2 +-
>   include/hw/ppc/pnv_xive.h      |   4 +-
>   include/hw/ppc/spapr_irq.h     |   4 +-
>   include/hw/ppc/xics.h          |   4 +-
>   include/hw/ppc/xive.h          |   4 +-
>   include/hw/ppc/xive2_regs.h    |   8 +--
>   include/hw/ppc/xive_regs.h     |   8 +--
>   hw/intc/pnv_xive.c             |  38 ++++++------
>   hw/intc/pnv_xive2.c            |  48 +++++++--------
>   hw/intc/spapr_xive.c           |  41 ++++++-------
>   hw/intc/xics.c                 |  25 ++++----
>   hw/intc/xics_spapr.c           |   7 +--
>   hw/intc/xive.c                 | 108 ++++++++++++++++-----------------
>   hw/intc/xive2.c                |  87 +++++++++++++-------------
>   hw/pci-host/pnv_phb3_msi.c     |  21 +++----
>   hw/pci-host/pnv_phb4.c         |  17 +++---
>   hw/ppc/pnv.c                   |  52 ++++++++--------
>   hw/ppc/pnv_psi.c               |   9 ++-
>   hw/ppc/spapr.c                 |  11 +++-
>   hw/ppc/spapr_irq.c             |   4 +-
>   23 files changed, 256 insertions(+), 254 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



