Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85316C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 20:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTodQ-0001qG-M5; Tue, 16 Jul 2024 16:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTodK-0001ob-Mu; Tue, 16 Jul 2024 16:18:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTodH-0001sQ-65; Tue, 16 Jul 2024 16:18:45 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNr4D6DTFz4x3c;
 Wed, 17 Jul 2024 06:18:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNr4B3pSCz4wym;
 Wed, 17 Jul 2024 06:18:34 +1000 (AEST)
Message-ID: <4b72c7b9-a812-43c6-b735-43eac8709fc6@kaod.org>
Date: Tue, 16 Jul 2024 22:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] XIVE changes for Cache Watch, VSTs, STT and info
 pic
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Mike,

On 7/16/24 21:56, Michael Kowal wrote:
> These changes provide enhanced support of the External Interrupt Virtualization
> Engine.  The changes are focused on the following areas:
>   - Cache Watch, Cache Flush and Sync Injection
>   - Virtual Structure Tables
>   - Set Translation Table
>   - 'info pic' command data that is dumped
> 
> Frederic Barrat (7):
>    pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
>    pnv/xive2: Add NVG and NVC to cache watch facility
>    pnv/xive2: Configure Virtualization Structure Tables through the PC
>    pnv/xive2: Enable VST NVG and NVC index compression
>    pnv/xive2: Set Translation Table for the NVC port space
>    pnv/xive2: Fail VST entry address computation if table has no VSD
>    pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
> 
> Michael Kowal (1):
>    pnv/xive2: Structure/define alignment changes
> 
> Nicholas Piggin (1):
>    pnv/xive: Support cache flush and queue sync inject with notifications
> 
>   hw/intc/pnv_xive2_regs.h    | 108 +++++++
>   include/hw/ppc/pnv_chip.h   |   1 +
>   include/hw/ppc/xive2_regs.h |   9 +
>   hw/intc/pnv_xive2.c         | 566 ++++++++++++++++++++++++++++++------
>   hw/intc/xive.c              |  12 +-
>   hw/intc/xive2.c             |  33 ++-
>   6 files changed, 633 insertions(+), 96 deletions(-)
> 
> --
> 2.43.0
> 

Hello Mike,

When you respin a series, it is useful to update the individual
patches with the given R-b tags. To keep track of them, you can use
the b4 command :
   
   $ b4 am 20240715183332.27287-1-kowal@linux.vnet.ibm.com
   Grabbing thread from lore.kernel.org/all/20240715183332.27287-1-kowal@linux.vnet.ibm.com/t.mbox.gz
   Analyzing 23 messages in the thread
   Looking for additional code-review trailers on lore.kernel.org
   Checking attestation on all messages, may take a moment...
   ---
     ✓ [PATCH v2 1/9] pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
     ✓ [PATCH v2 2/9] pnv/xive2: Structure/define alignment changes
       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
     ✓ [PATCH v2 3/9] pnv/xive: Support cache flush and queue sync inject with notifications
     ✓ [PATCH v2 4/9] pnv/xive2: Add NVG and NVC to cache watch facility
     ✓ [PATCH v2 5/9] pnv/xive2: Configure Virtualization Structure Tables through the PC
       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
     ✓ [PATCH v2 6/9] pnv/xive2: Enable VST NVG and NVC index compression
       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
     ✓ [PATCH v2 7/9] pnv/xive2: Set Translation Table for the NVC port space
       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
       + Reviewed-by: Cédric Le Goater <clg@kaod.org>
     ✓ [PATCH v2 8/9] pnv/xive2: Fail VST entry address computation if table has no VSD
       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
       + Reviewed-by: Cédric Le Goater <clg@kaod.org>
     ✓ [PATCH v2 9/9] pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
     ---
     ✓ Signed: DKIM/ibm.com (From: kowal@linux.vnet.ibm.com)
   


Thanks,

C.



