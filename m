Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AABC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 11:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siY84-0004GO-Mk; Mon, 26 Aug 2024 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siY7z-0004FI-69; Mon, 26 Aug 2024 07:43:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siY7x-0006lR-78; Mon, 26 Aug 2024 07:43:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wsphf6Wh1z4x3J;
 Mon, 26 Aug 2024 21:43:14 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wsphc3ybrz4wbR;
 Mon, 26 Aug 2024 21:43:12 +1000 (AEST)
Message-ID: <f8d23697-85b4-43bf-8448-b710b8525041@kaod.org>
Date: Mon, 26 Aug 2024 13:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ppc/xive2: Allow 1-byte write of Target field in
 TIMA
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-8-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-8-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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

On 8/1/24 22:30, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> When running PowerVM, the console is littered with XIVE traces regarding
> invalid writes to TIMA address 0x100b6 due to a lack of support for writes
> to the "TARGET" field which was added for XIVE GEN2.  To fix this, we add
> special op support for 1-byte writes to this field.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/xive2.h     |  2 ++
>   include/hw/ppc/xive_regs.h |  1 +
>   hw/intc/xive.c             |  2 ++
>   hw/intc/xive2.c            | 13 +++++++++++++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index b7a7c33ddd..36bd0e747f 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -121,5 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, unsigned size);
>   void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                                hwaddr offset, uint64_t value, unsigned size);
> +void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size);
>   
>   #endif /* PPC_XIVE2_H */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 27a744d50d..f8f05deafd 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -79,6 +79,7 @@
>   #define TM_INC                  0x5  /*  -   +   -   +  */
>   #define TM_LGS                  0x5  /*  +   +   +   +  */ /* Rename P10 */
>   #define TM_AGE                  0x6  /*  -   +   -   +  */
> +#define TM_T                    0x6  /*  -   +   -   +  */ /* Rename P10 */
>   #define TM_PIPR                 0x7  /*  -   +   -   +  */
>   #define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
>   
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 8605dd618f..6229a6f870 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -546,6 +546,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
>                                                        xive_tm_vt_poll },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
> +                                                     NULL },
>   
>       /* MMIOs above 2K : special operations with side effects */
>       { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 9d19273bc8..eed0cc9c3c 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -600,6 +600,19 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       }
>   }
>   
> +static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
> +{
> +    uint8_t *regs = &tctx->regs[ring];
> +
> +    regs[TM_T] = target;
> +}
> +
> +void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tctx_set_target(tctx, TM_QW3_HV_PHYS, value & 0xff);
> +}
> +
>   /*
>    * XIVE Router (aka. Virtualization Controller or IVRE)
>    */


