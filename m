Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2825DC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtSe-0003kH-G8; Thu, 25 Jul 2024 04:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org>)
 id 1sWtSc-0003dp-Sc; Thu, 25 Jul 2024 04:04:26 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org>)
 id 1sWtSZ-0007vn-Sd; Thu, 25 Jul 2024 04:04:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WV3Ls2cyPz4x1V;
 Thu, 25 Jul 2024 18:04:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WV3Lp0jbhz4wnt;
 Thu, 25 Jul 2024 18:04:17 +1000 (AEST)
Message-ID: <040392dd-882a-4180-8051-355e7f020c61@kaod.org>
Date: Thu, 25 Jul 2024 10:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] pnv/xive2: Move xive2_nvp_pic_print_info() to
 xive2.c
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240724212130.26811-1-kowal@linux.ibm.com>
 <20240724212130.26811-10-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240724212130.26811-10-kowal@linux.ibm.com>
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
> Moving xive2_nvp_pic_print_info() to align with the other "pic_print_info"
> functions.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/xive2_regs.h |  2 ++
>   hw/intc/pnv_xive2.c         | 27 ---------------------------
>   hw/intc/xive2.c             | 26 ++++++++++++++++++++++++++
>   3 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 4e5e17cd89..ec5d6ec2d6 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -194,6 +194,8 @@ static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
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
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 3e7238c663..ac914b3d1c 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -137,6 +137,32 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
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


