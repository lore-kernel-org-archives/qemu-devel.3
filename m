Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1A0C54EE3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHDC-0006Rh-Ut; Wed, 28 Aug 2024 07:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2BaY=P3=kaod.org=clg@ozlabs.org>)
 id 1sjHDB-0006Qk-M6; Wed, 28 Aug 2024 07:51:41 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2BaY=P3=kaod.org=clg@ozlabs.org>)
 id 1sjHD9-0005jr-Gr; Wed, 28 Aug 2024 07:51:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wv2nL6jbHz4wxx;
 Wed, 28 Aug 2024 21:51:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wv2nJ4bk3z4wnw;
 Wed, 28 Aug 2024 21:51:32 +1000 (AEST)
Message-ID: <4983c0a1-c9a4-4146-b106-b9bbc0ab7eee@kaod.org>
Date: Wed, 28 Aug 2024 13:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] pnv/xive2: TIMA support for 8-byte OS context push
 for PHYP
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-13-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-13-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=2BaY=P3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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
> PHYP uses 8-byte writes to the 2nd doubleword of the OS context
> line when dispatching an OS level virtual processor.  This
> support was not used by OPAL/Linux and so was never added.
> 
> Without this support, the XIVE code doesn't notice that a new
> context is being pushed and fails to check for unpresented
> pending interrupts for that context.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/xive.c  |  2 ++
>   hw/intc/xive2.c | 24 +++++++++++++++++++-----
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index d951aac3a0..99c8bea598 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -596,6 +596,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
>                                                        NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, xive2_tm_push_os_ctx,
> +                                                     NULL },
>       { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index af9699ec88..76f2f36973 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -612,17 +612,31 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>   void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                             hwaddr offset, uint64_t value, unsigned size)
>   {
> -    uint32_t cam = value;
> -    uint32_t qw1w2 = cpu_to_be32(cam);
> +    uint32_t cam;
> +    uint32_t qw1w2;
> +    uint64_t qw1dw1;
>       uint8_t nvp_blk;
>       uint32_t nvp_idx;
>       bool vo;
>       bool do_restore;
>   
> -    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
> -
>       /* First update the thead context */
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +    switch (size) {
> +    case 4:
> +        cam = value;
> +        qw1w2 = cpu_to_be32(cam);
> +        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +        break;
> +    case 8:
> +        cam = value >> 32;
> +        qw1dw1 = cpu_to_be64(value);
> +        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1dw1, 8);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
>   
>       /* Check the interrupt pending bits */
>       if (vo) {


