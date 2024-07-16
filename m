Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A72C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 20:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToo5-0003Ul-Ic; Tue, 16 Jul 2024 16:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sToo3-0003Sx-VI; Tue, 16 Jul 2024 16:29:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sToo1-0003vd-2U; Tue, 16 Jul 2024 16:29:51 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNrK223PTz4x1y;
 Wed, 17 Jul 2024 06:29:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNrJz6hqjz4x0C;
 Wed, 17 Jul 2024 06:29:39 +1000 (AEST)
Message-ID: <3cac245f-a612-4958-b613-41ee2c1eb557@kaod.org>
Date: Tue, 16 Jul 2024 22:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] pnv/xive2: Move xive2_nvp_pic_print_info() to
 xive2.c
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
 <20240716195633.12679-10-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716195633.12679-10-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
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

On 7/16/24 21:56, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Moving xive2_nvp_pic_print_info() align with the other "pic_print_info"
> functions and allows us to call functions internal to xive2.c.

ok but I don't see the difference in the patch. Am I missing something ?

> 
> In XIVE Gen 2 there were some minor changes to the TIMA header that were
> updated when printed.

This is a second patch.

> Additional END state 'info pic' information as added.  The 'ignore',
> 'crowd' and 'precluded escalation control' bits of an Event Notification
> Descriptor are all used when delivering an interrupt targeting a VP-group
> or crowd.

and this a third.

It shouldn't take too long to split.

Thanks,

C.



> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
> ---
>   include/hw/ppc/xive2_regs.h |  9 +++++++++
>   hw/intc/pnv_xive2.c         | 27 ---------------------------
>   hw/intc/xive.c              | 12 +++++++++---
>   hw/intc/xive2.c             | 33 +++++++++++++++++++++++++++++++--
>   4 files changed, 49 insertions(+), 32 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 4e5e17cd89..4349d009d0 100644
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
> +void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
> +
>   /*
>    * Notification Virtual Group or Crowd (NVG/NVC)
>    */
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 9fe3ec9a67..4740c56347 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -2436,33 +2436,6 @@ static void pnv_xive2_register_types(void)
>   
>   type_init(pnv_xive2_register_types)
>   
> -static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
> -                                     GString *buf)
> -{
> -    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
> -    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
> -
> -    if (!xive2_nvp_is_valid(nvp)) {
> -        return;
> -    }
> -
> -    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
> -                           nvp_idx, eq_blk, eq_idx,
> -                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
> -    /*
> -     * When the NVP is HW controlled, more fields are updated
> -     */
> -    if (xive2_nvp_is_hw(nvp)) {
> -        g_string_append_printf(buf, " CPPR:%02x",
> -                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
> -        if (xive2_nvp_is_co(nvp)) {
> -            g_string_append_printf(buf, " CO:%04x",
> -                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
> -        }
> -    }
> -    g_string_append_c(buf, '\n');
> -}
> -
>   /*
>    * If the table is direct, we can compute the number of PQ entries
>    * provisioned by FW.
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 70f11f993b..5a02dd8e02 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -692,9 +692,15 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf)
>           }
>       }
>   
> -    g_string_append_printf(buf, "CPU[%04x]:   "
> -                           "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2\n",
> -                           cpu_index);
> +    if (xive_presenter_get_config(tctx->xptr) & XIVE_PRESENTER_GEN1_TIMA_OS) {
> +        g_string_append_printf(buf, "CPU[%04x]:   "
> +                               "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
> +                               "  W2\n", cpu_index);
> +    } else {
> +        g_string_append_printf(buf, "CPU[%04x]:   "
> +                               "QW   NSR CPPR IPB LSMFB   -  LGS  T  PIPR"
> +                               "  W2\n", cpu_index);
> +    }
>   
>       for (i = 0; i < XIVE_TM_RING_COUNT; i++) {
>           char *s = xive_tctx_ring_print(&tctx->regs[i * XIVE_TM_RING_SIZE]);
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 3e7238c663..1f150685bf 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -89,7 +89,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
>       pq = xive_get_field32(END2_W1_ESn, end->w1);
>   
>       g_string_append_printf(buf,
> -                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c "
> +                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c%c %c%c "
>                              "prio:%d nvp:%02x/%04x",
>                              end_idx,
>                              pq & XIVE_ESB_VAL_P ? 'P' : '-',
> @@ -98,12 +98,15 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
>                              xive2_end_is_enqueue(end)  ? 'q' : '-',
>                              xive2_end_is_notify(end)   ? 'n' : '-',
>                              xive2_end_is_backlog(end)  ? 'b' : '-',
> +                           xive2_end_is_precluded_escalation(end) ? 'p' : '-',
>                              xive2_end_is_escalate(end) ? 'e' : '-',
>                              xive2_end_is_escalate_end(end) ? 'N' : '-',
>                              xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
>                              xive2_end_is_silent_escalation(end)   ? 's' : '-',
>                              xive2_end_is_firmware1(end)   ? 'f' : '-',
>                              xive2_end_is_firmware2(end)   ? 'F' : '-',
> +                           xive2_end_is_ignore(end) ? 'i' : '-',
> +                           xive2_end_is_crowd(end)  ? 'c' : '-',
>                              priority, nvp_blk, nvp_idx);
>   
>       if (qaddr_base) {
> @@ -137,6 +140,32 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
>                              (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
>   }
>   
> +void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
> +{
> +    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
> +    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
> +
> +    if (!xive2_nvp_is_valid(nvp)) {
> +        return;
> +    }
> +
> +    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
> +                           nvp_idx, eq_blk, eq_idx,
> +                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
> +    /*
> +     * When the NVP is HW controlled, more fields are updated
> +     */
> +    if (xive2_nvp_is_hw(nvp)) {
> +        g_string_append_printf(buf, " CPPR:%02x",
> +                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
> +        if (xive2_nvp_is_co(nvp)) {
> +            g_string_append_printf(buf, " CO:%04x",
> +                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
> +        }
> +    }
> +    g_string_append_c(buf, '\n');
> +}
> +
>   static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>   {
>       uint64_t qaddr_base = xive2_end_qaddr(end);
> @@ -650,7 +679,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>       }
>   
>       found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
> -                          xive_get_field32(END2_W6_IGNORE, end.w7),
> +                          xive2_end_is_ignore(&end),
>                             priority,
>                             xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
>   


