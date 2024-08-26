Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6ACC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 11:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siXvb-00074d-Lj; Mon, 26 Aug 2024 07:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siXva-00073d-1v; Mon, 26 Aug 2024 07:30:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siXvX-0004ye-TT; Mon, 26 Aug 2024 07:30:29 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WspPm4QVdz4x11;
 Mon, 26 Aug 2024 21:30:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WspPj6vXJz4wj3;
 Mon, 26 Aug 2024 21:30:17 +1000 (AEST)
Message-ID: <bb4a6c6c-42f7-4295-adb1-f05482bf893e@kaod.org>
Date: Mon, 26 Aug 2024 13:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] pnv/xive2: Support for "OS LGS Push" TIMA operation
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-5-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-5-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 8/1/24 22:29, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> Adds support for single byte writes to offset 0x15 of the TIMA address
> space.  This offset holds the Logical Server Group Size (LGS) field.
> The field is used to evenly distribute the interrupt load among the
> members of a group, but is unused in the current implementation so we
> just support the writing of the value for now.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/xive.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 8e62c7e75f..8605dd618f 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -341,6 +341,19 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>       xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
>   }
>   
> +static void xive_tctx_set_lgs(XiveTCTX *tctx, uint8_t ring, uint8_t lgs)
> +{
> +    uint8_t *regs = &tctx->regs[ring];
> +
> +    regs[TM_LGS] = lgs;
> +}
> +
> +static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
> +}
> +
>   /*
>    * Adjust the IPB to allow a CPU to process event queues of other
>    * priorities during one physical interrupt cycle.
> @@ -525,6 +538,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
>                                                        NULL },
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
> +                                                     NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,


