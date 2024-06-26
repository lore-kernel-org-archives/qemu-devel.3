Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B8C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMOf9-0002V1-Sn; Wed, 26 Jun 2024 05:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9yaS=N4=kaod.org=clg@ozlabs.org>)
 id 1sMOf5-0002UI-Qn; Wed, 26 Jun 2024 05:09:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9yaS=N4=kaod.org=clg@ozlabs.org>)
 id 1sMOf3-0006JT-US; Wed, 26 Jun 2024 05:09:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W8G9Z6QVdz4wc8;
 Wed, 26 Jun 2024 19:09:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W8G9W0Tl3z4wb2;
 Wed, 26 Jun 2024 19:09:34 +1000 (AEST)
Message-ID: <6eeecfe5-941c-43f2-bda4-7bc19c40ccaa@kaod.org>
Date: Wed, 26 Jun 2024 11:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] ppc/pnv: Remove ppc target dependency from
 pnv_xscom.h
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
 <20240626090528.812-2-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240626090528.812-2-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9yaS=N4=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/26/24 11:05 AM, Chalapathi V wrote:
> In this commit target specific dependency from include/hw/ppc/pnv_xscom.h
> has been removed so that pnv_xscom.h can be included outside hw/ppc.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/pnv_xscom.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 6209e18492..c8dd42bffd 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -21,9 +21,9 @@
>   #define PPC_PNV_XSCOM_H
>   
>   #include "exec/memory.h"
> -#include "hw/ppc/pnv.h"
>   
>   typedef struct PnvXScomInterface PnvXScomInterface;
> +typedef struct PnvChip PnvChip;
>   
>   #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
>   #define PNV_XSCOM_INTERFACE(obj) \


