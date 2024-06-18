Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2148FC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcvz-0006so-Vy; Tue, 18 Jun 2024 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJcvr-0006s2-D4; Tue, 18 Jun 2024 13:47:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJcvp-0008Nh-5f; Tue, 18 Jun 2024 13:47:47 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W3Z326l79z4wyg;
 Wed, 19 Jun 2024 03:47:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3Z302H2Sz4wcJ;
 Wed, 19 Jun 2024 03:47:39 +1000 (AEST)
Message-ID: <cfb60bbd-72fa-4ae6-806e-717745989a6f@kaod.org>
Date: Tue, 18 Jun 2024 19:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
 <20240617204302.12323-6-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240617204302.12323-6-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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
> Moving xive2_nvp_pic_print_info() align with the other "pic_print_info"
> functions and allows us to call functions internal to xive2.c.
> 
> In XIVE Gen 2 there were some minor changes to the TIMA header that were
> updated when printed.
> 
> Additional END state 'info pic' information as added.  The 'ignore',
> 'crowd' and 'precluded escalation control' bits of an Event Notification
> Descriptor are all used when delivering an interrupt targeting a VP-group
> or crowd.
> 
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>

Looks correct. You might need to rebase because Philippe sent changes
on the same routines.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/ppc/xive2_regs.h |  9 +++++++++
>   hw/intc/pnv_xive2.c         | 27 ---------------------------
>   hw/intc/xive.c              | 11 +++++++++--
>   hw/intc/xive2.c             | 33 +++++++++++++++++++++++++++++++--
>   4 files changed, 49 insertions(+), 31 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 816f5d0e84..5fa39f3ccc 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -97,6 +97,7 @@ typedef struct Xive2End {
>           uint32_t       w6;
>   #define END2_W6_FORMAT_BIT         PPC_BIT32(0)
>   #define END2_W6_IGNORE             PPC_BIT32(1)
> +#define END2_W6_CROWD              PPC_BIT32(2)
>   #define END2_W6_VP_BLOCK           PPC_BITMASK32(4, 7)
>   #define END2_W6_VP_OFFSET          PPC_BITMASK32(8, 31)
>   #define END2_W6_VP_OFFSET_GEN1     PPC_BITMASK32(13, 31)
> @@ -111,6 +112,8 @@ typedef struct Xive2End {
>   #define xive2_end_is_notify(end)                \
>       (be32_to_cpu((end)->w0) & END2_W0_UCOND_NOTIFY)
>   #define xive2_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END2_W0_BACKLOG)
> +#define xive2_end_is_precluded_escalation(end)          \
> +    (be32_to_cpu((end)->w0) & END2_W0_PRECL_ESC_CTL)
>   #define xive2_end_is_escalate(end)                      \
>       (be32_to_cpu((end)->w0) & END2_W0_ESCALATE_CTL)
>   #define xive2_end_is_uncond_escalation(end)              \
> @@ -123,6 +126,10 @@ typedef struct Xive2End {
>       (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE1)
>   #define xive2_end_is_firmware2(end)              \
>       (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE2)
> +#define xive2_end_is_ignore(end)                \
> +    (be32_to_cpu((end)->w6) & END2_W6_IGNORE)
> +#define xive2_end_is_crowd(end)                 \
> +    (be32_to_cpu((end)->w6) & END2_W6_CROWD)
>   
>   static inline uint64_t xive2_end_qaddr(Xive2End *end)
>   {
> @@ -194,6 +201,8 @@ static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
>       return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
>   }
>   
> +void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, Monitor *mon);
> +
>   /*
>    * Notification Virtual Group or Crowd (NVG/NVC)
>    */
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index e473109196..2138b7e365 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -2435,33 +2435,6 @@ static void pnv_xive2_register_types(void)
>   
>   type_init(pnv_xive2_register_types)
>   
> -static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
> -                                     Monitor *mon)
> -{
> -    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
> -    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
> -
> -    if (!xive2_nvp_is_valid(nvp)) {
> -        return;
> -    }
> -
> -    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x",
> -                   nvp_idx, eq_blk, eq_idx,
> -                   xive_get_field32(NVP2_W2_IPB, nvp->w2));
> -    /*
> -     * When the NVP is HW controlled, more fields are updated
> -     */
> -    if (xive2_nvp_is_hw(nvp)) {
> -        monitor_printf(mon, " CPPR:%02x",
> -                       xive_get_field32(NVP2_W2_CPPR, nvp->w2));
> -        if (xive2_nvp_is_co(nvp)) {
> -            monitor_printf(mon, " CO:%04x",
> -                           xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
> -        }
> -    }
> -    monitor_printf(mon, "\n");
> -}
> -
>   /*
>    * If the table is direct, we can compute the number of PQ entries
>    * provisioned by FW.
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 057b308ae9..de583a87af 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -693,8 +693,15 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
>           }
>       }
>   
> -    monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
> -                   "  W2\n", cpu_index);
> +    if (xive_presenter_get_config(tctx->xptr) & XIVE_PRESENTER_GEN1_TIMA_OS) {
> +        monitor_printf(mon,
> +                       "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
> +                       "  W2\n", cpu_index);
> +    } else {
> +        monitor_printf(mon,
> +                       "CPU[%04x]:   QW   NSR CPPR IPB LSMFB   -  LGS  T  PIPR"
> +                       "  W2\n", cpu_index);
> +    }
>   
>       for (i = 0; i < XIVE_TM_RING_COUNT; i++) {
>           char *s = xive_tctx_ring_print(&tctx->regs[i * XIVE_TM_RING_SIZE]);
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 98c0d8ba44..e5168330f3 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -91,7 +91,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
>       pq = xive_get_field32(END2_W1_ESn, end->w1);
>   
>       monitor_printf(mon,
> -                   "  %08x %c%c %c%c%c%c%c%c%c%c%c%c prio:%d nvp:%02x/%04x",
> +                   "  %08x %c%c %c%c%c%c%c%c%c%c%c%c%c %c%c prio:%d nvp:%02x/%04x",
>                      end_idx,
>                      pq & XIVE_ESB_VAL_P ? 'P' : '-',
>                      pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
> @@ -99,12 +99,15 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
>                      xive2_end_is_enqueue(end)  ? 'q' : '-',
>                      xive2_end_is_notify(end)   ? 'n' : '-',
>                      xive2_end_is_backlog(end)  ? 'b' : '-',
> +                   xive2_end_is_precluded_escalation(end) ? 'p' : '-',
>                      xive2_end_is_escalate(end) ? 'e' : '-',
>                      xive2_end_is_escalate_end(end) ? 'N' : '-',
>                      xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
>                      xive2_end_is_silent_escalation(end)   ? 's' : '-',
>                      xive2_end_is_firmware1(end)   ? 'f' : '-',
>                      xive2_end_is_firmware2(end)   ? 'F' : '-',
> +                   xive2_end_is_ignore(end) ? 'i' : '-',
> +                   xive2_end_is_crowd(end)  ? 'c' : '-',
>                      priority, nvp_blk, nvp_idx);
>   
>       if (qaddr_base) {
> @@ -138,6 +141,32 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
>                      (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
>   }
>   
> +void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, Monitor *mon)
> +{
> +    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
> +    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
> +
> +    if (!xive2_nvp_is_valid(nvp)) {
> +        return;
> +    }
> +
> +    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x",
> +                   nvp_idx, eq_blk, eq_idx,
> +                   xive_get_field32(NVP2_W2_IPB, nvp->w2));
> +    /*
> +     * When the NVP is HW controlled, more fields are updated
> +     */
> +    if (xive2_nvp_is_hw(nvp)) {
> +        monitor_printf(mon, " CPPR:%02x",
> +                       xive_get_field32(NVP2_W2_CPPR, nvp->w2));
> +        if (xive2_nvp_is_co(nvp)) {
> +            monitor_printf(mon, " CO:%04x",
> +                           xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
> +        }
> +    }
> +    monitor_printf(mon, "\n");
> +}
> +
>   static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>   {
>       uint64_t qaddr_base = xive2_end_qaddr(end);
> @@ -651,7 +680,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>       }
>   
>       found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
> -                          xive_get_field32(END2_W6_IGNORE, end.w7),
> +                          xive2_end_is_ignore(&end),
>                             priority,
>                             xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
>   


