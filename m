Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F83EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcuJ-0005Ve-V6; Tue, 18 Jun 2024 13:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJcu6-0005Qt-Hn; Tue, 18 Jun 2024 13:46:09 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJcu3-00089T-Vy; Tue, 18 Jun 2024 13:45:57 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W3Z0w4RRjz4wyg;
 Wed, 19 Jun 2024 03:45:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3Z0t296jz4x0v;
 Wed, 19 Jun 2024 03:45:49 +1000 (AEST)
Message-ID: <6cc4a21e-ffc0-4ead-a08c-e7cd30c55da2@kaod.org>
Date: Tue, 18 Jun 2024 19:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pnv/xive2: Fail VST entry address computation if
 table has no VSD
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
 <20240617204302.12323-5-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240617204302.12323-5-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Of75=NU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 6/17/24 10:43 PM, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Fail VST entry address computatio if firmware doesn't define a descriptor

computation

> for one of the Virtualization Structure Tables (VST), there's no point in
> trying to compute the address of its entry.  Abort the operation and log
> an error.
> 
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index a1146311a3..e473109196 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -244,6 +244,11 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
>       }
>   
>       vsd = xive->vsds[type][blk];
> +    if (vsd == 0) {
> +        xive2_error(xive, "VST: vsd == 0 block id %d for VST %s %d !?",
> +                   blk, info->name, idx);
> +        return 0;
> +    }
>   
>       /* Remote VST access */
>       if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {


