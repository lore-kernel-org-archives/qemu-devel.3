Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D0C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWVN-000572-In; Tue, 02 Jul 2024 01:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fXIt=OC=kaod.org=clg@ozlabs.org>)
 id 1sOWVL-00056W-Mn; Tue, 02 Jul 2024 01:56:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fXIt=OC=kaod.org=clg@ozlabs.org>)
 id 1sOWVI-0007Jb-He; Tue, 02 Jul 2024 01:56:39 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WCsbt2KBsz4wny;
 Tue,  2 Jul 2024 15:56:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WCsbn5sjnz4wcr;
 Tue,  2 Jul 2024 15:56:21 +1000 (AEST)
Message-ID: <11cbc79b-d2a8-4c04-b5ea-cb612124d493@kaod.org>
Date: Tue, 2 Jul 2024 07:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hw/net:ftgmac100: fix coding style
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Jason Wang <jasowang@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240619100102.3137941-1-jamin_lin@aspeedtech.com>
 <20240619100102.3137941-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240619100102.3137941-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fXIt=OC=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 6/19/24 12:01 PM, Jamin Lin wrote:
> Fix coding style issues from checkpatch.pl
> 
> Test command:
> ./scripts/checkpatch.pl --no-tree -f hw/net/ftgmac100.c
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Applied to aspeed-next.

Thanks,

C.




> ---
>   hw/net/ftgmac100.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 74b6c3d9a7..25e4c0cd5b 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -238,7 +238,8 @@ typedef struct {
>    */
>   #define FTGMAC100_MAX_FRAME_SIZE    9220
>   
> -/* Limits depending on the type of the frame
> +/*
> + * Limits depending on the type of the frame
>    *
>    *   9216 for Jumbo frames (+ 4 for VLAN)
>    *   1518 for other frames (+ 4 for VLAN)
> @@ -533,8 +534,10 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>               break;
>           }
>   
> -        /* record transmit flags as they are valid only on the first
> -         * segment */
> +        /*
> +         * record transmit flags as they are valid only on the first
> +         * segment
> +         */
>           if (bd.des0 & FTGMAC100_TXDES0_FTS) {
>               flags = bd.des1;
>           }
> @@ -639,7 +642,8 @@ static bool ftgmac100_can_receive(NetClientState *nc)
>    */
>   static uint32_t ftgmac100_rxpoll(FTGMAC100State *s)
>   {
> -    /* Polling times :
> +    /*
> +     * Polling times :
>        *
>        * Speed      TIME_SEL=0    TIME_SEL=1
>        *


