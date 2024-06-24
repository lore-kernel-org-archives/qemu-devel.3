Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59041C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfJC-0007ni-TY; Mon, 24 Jun 2024 04:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=voaC=N2=kaod.org=clg@ozlabs.org>)
 id 1sLfJA-0007n0-Le; Mon, 24 Jun 2024 04:44:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=voaC=N2=kaod.org=clg@ozlabs.org>)
 id 1sLfJ8-0006qi-5Q; Mon, 24 Jun 2024 04:44:16 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W71j50gLhz4x0r;
 Mon, 24 Jun 2024 18:44:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W71j129Chz4wx6;
 Mon, 24 Jun 2024 18:44:04 +1000 (AEST)
Message-ID: <2d0bcf57-0a76-458a-a40f-70a31135e9e5@kaod.org>
Date: Mon, 24 Jun 2024 10:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] aspeed/soc: fix coverity issue
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240619093508.2528537-1-jamin_lin@aspeedtech.com>
 <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=voaC=N2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/19/24 11:35 AM, Jamin Lin wrote:
> Fix coverity defect: DIVIDE_BY_ZERO.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


I have rewritten the commit log :

     aspeed/soc: Fix possible divide by zero
     
     Coverity reports a possible DIVIDE_BY_ZERO issue regarding the
     "ram_size" object property. This can not happen because RAM has
     predefined valid sizes per SoC. Nevertheless, add a test to
     close the issue.

     Fixes: Coverity CID 1547113

with that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/arm/aspeed_ast27x0.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index b6876b4862..d14a46df6f 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -211,6 +211,12 @@ static void aspeed_ram_capacity_write(void *opaque, hwaddr addr, uint64_t data,
>       ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
>                                           &error_abort);
>   
> +    if (!ram_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: ram_size is zero",  __func__);
> +        return;
> +    }
> +
>       /*
>        * Emulate ddr capacity hardware behavior.
>        * If writes the data to the address which is beyond the ram size,


