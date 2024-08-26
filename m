Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB8C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 10:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWjs-0006vD-QT; Mon, 26 Aug 2024 06:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siWjr-0006u0-Di; Mon, 26 Aug 2024 06:14:19 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siWjh-0002qx-UT; Mon, 26 Aug 2024 06:14:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wsmjp2cXvz4x8B;
 Mon, 26 Aug 2024 20:14:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wsmjm0RsQz4x5J;
 Mon, 26 Aug 2024 20:14:03 +1000 (AEST)
Message-ID: <9314a4fd-368a-4d1a-954e-ddb85d709243@kaod.org>
Date: Mon, 26 Aug 2024 12:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] pnv/xive: TIMA patch sets pre-req alignment and
 formatting changes
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-2-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-2-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 8/1/24 22:29, Michael Kowal wrote:
> From: Michael Kowal <kowal@linux.vnet.ibm.com>
> 
> Making some pre-requisite alignment changes ahead of the following patch
> sets.  Making these changes now will ease the review of the patch sets.
> 
> Checkpatch wants the closing comment '*/' on a separate line, unless it is
> on the same line as the starting comment '/*'.
> 
> There are also changes to prevent lines from spanning 80 columns.
> 
> Changed block of defines from:
>     #define A 1  /* original define comment is not
>                   * preferred, but not flagged... */
>     #define B 2  /* Newly added define comment
>                   * is flagged with a warning */
> To:
>     #define A 1  /* original define comment is */
>                  /* now fine, no warning...    */
>     #define B 2  /* Newly added define comment */
>                  /* is fine...                 */
> 
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/xive_regs.h | 32 ++++++++---------
>   hw/intc/xive.c             | 72 +++++++++++++++++++++++++-------------
>   2 files changed, 64 insertions(+), 40 deletions(-)
> 
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index b9db7abc2e..9d52d464d9 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -114,23 +114,23 @@
>    * Then we have all these "special" CI ops at these offset that trigger
>    * all sorts of side effects:
>    */
> -#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
> -#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg */
> +#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg               */
> +#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg           */
>   #define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate user context */
> -#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user
> -                                         * context */
> -#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit */
> -#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS
> -                                         * context to reg */
> -#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool
> -                                         * context to reg*/
> -#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg */
> -#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd
> -                                         * line */
> -#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line */
> -#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even
> -                                         * line */
> -#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line */
> +#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
> +                                        /* context                            */
> +#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
> +#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
> +                                        /* context to reg                     */
> +#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
> +                                        /* context to reg                     */
> +#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
> +#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
> +                                        /* line                               */
> +#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
> +#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
> +                                        /* line                               */
> +#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
>   /* XXX more... */
>   
>   /* NSR fields for the various QW ack types */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5a02dd8e02..2fb38e2102 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -488,20 +488,32 @@ static const XiveTmOp xive_tm_operations[] = {
>        * MMIOs below 2K : raw values and special operations without side
>        * effects
>        */
> -    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,     4, xive_tm_push_os_ctx, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
> +                                                     xive_tm_vt_poll },
>   
>       /* MMIOs above 2K : special operations with side effects */
> -    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
> -    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
> +                                                     xive_tm_ack_os_reg },
> +    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
> +                                                     xive_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
> +                                                     xive_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
> +                                                     xive_tm_ack_hv_reg },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
> +                                                     xive_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
> +                                                     xive_tm_pull_pool_ctx },
>   };
>   
>   static const XiveTmOp xive2_tm_operations[] = {
> @@ -509,20 +521,32 @@ static const XiveTmOp xive2_tm_operations[] = {
>        * MMIOs below 2K : raw values and special operations without side
>        * effects
>        */
> -    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,  4, xive2_tm_push_os_ctx, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
> +                                                     xive_tm_vt_poll },
>   
>       /* MMIOs above 2K : special operations with side effects */
> -    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
> -    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive2_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive2_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
> +                                                     xive_tm_ack_os_reg },
> +    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
> +                                                     NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
> +                                                     xive2_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
> +                                                     xive2_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
> +                                                     xive_tm_ack_hv_reg },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
> +                                                     xive_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
> +                                                     xive_tm_pull_pool_ctx },
>   };
>   
>   static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,


