Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC58AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7il-0000Dp-L7; Fri, 28 Jun 2024 05:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN7ii-0000D5-OY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:16:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN7ig-0003Dq-Fi
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:16:40 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9VDd6zjQz4w2N;
 Fri, 28 Jun 2024 19:16:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9VD81z0kz4w2K;
 Fri, 28 Jun 2024 19:16:07 +1000 (AEST)
Message-ID: <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
Date: Fri, 28 Jun 2024 11:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-91-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
> When booting U-boot/Linux on Aspeed boards via eMMC,
> some commands don't behave as expected from the spec.
> 
> Add the 'x-aspeed-emmc-kludge' property to allow non
> standard uses until we figure out the reasons.

I am not aware of any singularity in the eMMC logic provided by Aspeed.
U-Boot and Linux drivers seem very generic. May be others can tell.

Thanks,

C.


  
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index bd77853419..dc692fe1fa 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -127,6 +127,7 @@ struct SDState {
>   
>       uint8_t spec_version;
>       BlockBackend *blk;
> +    bool aspeed_emmc_kludge;
>   
>       const SDProto *proto;
>   
> @@ -2567,6 +2568,8 @@ static Property sd_properties[] = {
>       DEFINE_PROP_UINT8("spec_version", SDState,
>                         spec_version, SD_PHY_SPECv3_01_VERS),
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
> +    DEFINE_PROP_BOOL("x-aspeed-emmc-kludge", SDState,
> +                     aspeed_emmc_kludge, false),
>       /* We do not model the chip select pin, so allow the board to select
>        * whether card should be in SSI or MMC/SD mode.  It is also up to the
>        * board to ensure that ssi transfers only occur when the chip select


