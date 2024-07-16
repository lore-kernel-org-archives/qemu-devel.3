Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3051C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcHL-0005xo-Ce; Tue, 16 Jul 2024 03:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTcHH-0005or-PI; Tue, 16 Jul 2024 03:07:12 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTcHG-0002GI-3W; Tue, 16 Jul 2024 03:07:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNVVz5GrJz4x1y;
 Tue, 16 Jul 2024 17:07:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNVVx33ZFz4wbh;
 Tue, 16 Jul 2024 17:07:05 +1000 (AEST)
Message-ID: <9fa273de-d820-4103-97b7-07de88cccd9a@kaod.org>
Date: Tue, 16 Jul 2024 09:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] pnv/xive2: Set Translation Table for the NVC port
 space
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
 <20240715183332.27287-8-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240715183332.27287-8-kowal@linux.vnet.ibm.com>
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

On 7/15/24 20:33, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Set Translation Table for the NVC port space is missing.  The xive model
> doesn't take into account the remapping of IO operations via the Set
> Translation Table but firmware is allowed to define it for the Notify
> Virtual Crowd (NVC), like it's already done for the other VST tables.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index b14fad1b2e..24ecab46a1 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -719,6 +719,7 @@ static int pnv_xive2_stt_set_data(PnvXive2 *xive, uint64_t val)
>       case CQ_TAR_NVPG:
>       case CQ_TAR_ESB:
>       case CQ_TAR_END:
> +    case CQ_TAR_NVC:
>           xive->tables[tsel][entry] = val;
>           break;
>       default:


