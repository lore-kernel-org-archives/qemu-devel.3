Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D6FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtRL-0007sz-MG; Thu, 25 Jul 2024 04:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org>)
 id 1sWtRI-0007r3-5M; Thu, 25 Jul 2024 04:03:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org>)
 id 1sWtRG-0007mp-1x; Thu, 25 Jul 2024 04:03:03 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WV3KH1jJkz4x1V;
 Thu, 25 Jul 2024 18:02:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WV3KD2KyYz4wnt;
 Thu, 25 Jul 2024 18:02:56 +1000 (AEST)
Message-ID: <23779044-cfd7-4528-8cc6-540ec2db76c1@kaod.org>
Date: Thu, 25 Jul 2024 10:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] pnv/xive2: Dump more END state with 'info pic'
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240724212130.26811-1-kowal@linux.ibm.com>
 <20240724212130.26811-12-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240724212130.26811-12-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/24/24 23:21, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Additional END state 'info pic' information as added.  The 'ignore',
> 'crowd' and 'precluded escalation control' bits of an Event Notification
> Descriptor are all used when delivering an interrupt targeting a VP-group
> or crowd.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   include/hw/ppc/xive2_regs.h | 7 +++++++
>   hw/intc/xive2.c             | 7 +++++--
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index ec5d6ec2d6..4349d009d0 100644
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
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ac914b3d1c..1f150685bf 100644
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
> @@ -676,7 +679,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>       }
>   
>       found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
> -                          xive_get_field32(END2_W6_IGNORE, end.w7),
> +                          xive2_end_is_ignore(&end),
>                             priority,
>                             xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
>   


