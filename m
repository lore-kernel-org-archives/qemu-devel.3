Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A17EDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4aX-0000Yc-QQ; Tue, 10 Sep 2024 13:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=54h1=QI=kaod.org=clg@ozlabs.org>)
 id 1so4aV-0000RF-V5; Tue, 10 Sep 2024 13:23:35 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=54h1=QI=kaod.org=clg@ozlabs.org>)
 id 1so4aU-00033z-6H; Tue, 10 Sep 2024 13:23:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X39XK05gnz4wb0;
 Wed, 11 Sep 2024 03:23:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X39XG4lYqz4x2J;
 Wed, 11 Sep 2024 03:23:26 +1000 (AEST)
Message-ID: <f8ba5d94-69b3-460a-9a3c-4473bf2fb41e@kaod.org>
Date: Tue, 10 Sep 2024 19:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] ppc/xive2: Dump more NVP state with 'info pic'
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240909211038.27440-1-kowal@linux.ibm.com>
 <20240909211038.27440-6-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240909211038.27440-6-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=54h1=QI=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 9/9/24 23:10, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> The 'PGoFirst' field of a Notify Virtual Processor tells if the NVP
> belongs to a VP group.
> 
> Also, print the Reporting Cache Line address, if defined.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/xive2_regs.h |  1 +
>   hw/intc/xive2.c             | 10 ++++++++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 7acf7dccf3..d71a54f9ff 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -151,6 +151,7 @@ typedef struct Xive2Nvp {
>   #define NVP2_W0_VALID              PPC_BIT32(0)
>   #define NVP2_W0_HW                 PPC_BIT32(7)
>   #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
> +#define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
>           uint32_t       w1;
>   #define NVP2_W1_CO                 PPC_BIT32(13)
>   #define NVP2_W1_CO_PRIV            PPC_BITMASK32(14, 15)
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index fbd05aa9f5..ac581fa195 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -161,14 +161,20 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
>   {
>       uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
>       uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
> +    uint64_t cache_line = xive2_nvp_reporting_addr(nvp);
>   
>       if (!xive2_nvp_is_valid(nvp)) {
>           return;
>       }
>   
> -    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
> +    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x PGoFirst:%02x",
>                              nvp_idx, eq_blk, eq_idx,
> -                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
> +                           xive_get_field32(NVP2_W2_IPB, nvp->w2),
> +                           xive_get_field32(NVP2_W0_PGOFIRST, nvp->w0));
> +    if (cache_line) {
> +        g_string_append_printf(buf, "  reporting CL:%016"PRIx64, cache_line);
> +    }
> +
>       /*
>        * When the NVP is HW controlled, more fields are updated
>        */


