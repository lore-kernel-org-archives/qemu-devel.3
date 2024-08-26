Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DDC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 10:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWkU-0008S0-Mv; Mon, 26 Aug 2024 06:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siWkU-0008PS-1U; Mon, 26 Aug 2024 06:14:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siWkS-000329-8N; Mon, 26 Aug 2024 06:14:57 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wsmkj11wJz4x82;
 Mon, 26 Aug 2024 20:14:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wsmkf5x0Bz4wx5;
 Mon, 26 Aug 2024 20:14:50 +1000 (AEST)
Message-ID: <f0d3bef3-b101-4d84-9738-364647a326fe@kaod.org>
Date: Mon, 26 Aug 2024 12:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] pnv/xive2: Define OGEN field in the TIMA
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-3-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-3-kowal@linux.ibm.com>
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
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> The OGEN field at offset 0x1F is a new field for Gen2 TIMA. This
> patch defines it.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   include/hw/ppc/xive_regs.h | 1 +
>   hw/intc/xive.c             | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 9d52d464d9..9062c6abf6 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -79,6 +79,7 @@
>   #define TM_INC                  0x5  /*  -   +   -   +  */
>   #define TM_AGE                  0x6  /*  -   +   -   +  */
>   #define TM_PIPR                 0x7  /*  -   +   -   +  */
> +#define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
>   
>   #define TM_WORD0                0x0
>   #define TM_WORD1                0x4
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 2fb38e2102..136d82338a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -742,6 +742,10 @@ void xive_tctx_reset(XiveTCTX *tctx)
>       tctx->regs[TM_QW1_OS + TM_LSMFB] = 0xFF;
>       tctx->regs[TM_QW1_OS + TM_ACK_CNT] = 0xFF;
>       tctx->regs[TM_QW1_OS + TM_AGE] = 0xFF;
> +    if (!(xive_presenter_get_config(tctx->xptr) &
> +          XIVE_PRESENTER_GEN1_TIMA_OS)) {
> +        tctx->regs[TM_QW1_OS + TM_OGEN] = 2;
> +    }
>   
>       /*
>        * Initialize PIPR to 0xFF to avoid phantom interrupts when the


