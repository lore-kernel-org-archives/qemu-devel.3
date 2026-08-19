Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D97C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmOx-0006Ld-7i; Wed, 19 Aug 2026 15:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwmOn-0006Ac-Gl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:56:34 -0400
Received: from smtpout4.mo536.mail-out.ovh.net ([51.210.91.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwmOl-00030e-BD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:56:33 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hQHQ31McQz87wM;
 Wed, 19 Aug 2026 19:56:26 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 19 Aug 2026 19:56:26 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.8])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQHQ23c9fz6PVv; Wed, 19 Aug 2026 19:56:26 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 70E461923F07; Wed, 19 Aug 2026 19:56:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0057b13cd3d-c2ed-4d67-83f4-ffeb2126ed96,
 C24CD8B75EED539221ACEA448CE881038350F7ED) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <932b207f-fdad-41ad-b220-9f50ef0bd712@kaod.org>
Date: Wed, 19 Aug 2026 21:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/arm/aspeed_soc: Add the ACRY model to
 AspeedSoCState
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
 <20260813062359.425268-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260813062359.425268-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 750412291746147373
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF0T3wDLWTzaISBhfVRgYgmPXvATu3QesljzaCDDLLrSAIHstxI++MaZn3RMk6E0a8X7ABEDaaOcGb1XMS2+Dc0/lKWJ13xkhs5W39lCrADQERtxlfgIQM0IJKtR92Uu/1PjDjaFM1YGVyCHo3nBfTxDBDdKj5bGfaMma1TGJSrBzewtC9Oyxz6YrxN9D3yzLGUjdL2cFIINDNKTTQsDtrw7ChN9Z9nPDLOPd+2e9cmoG8iOXYLldmd2fZH8EuYzNyeLhWBGe80EGkbs6yJHALrx1rFAxks24mdJ/DPuua+Rh2+L5wG45RD19MCwrZlAXWx5zkZSkNCx5V4rx6wSif0RXD9qeGrvPehDm+7OWfIaYN0GzsPTRI9f0Ij75A/OvU4yFj1il8GFSpbVEgSjqDwRlkTqs9bd0d9undqmM0jxinXNDJPmwRtc4Ck8eHtNqphffzsQDmjTQNI93PDFN6N+hIXUpEyayevKOovesceA2TsgZ0hwpVRQ2OHmDt30AnCqn+bt42l/ZJfbtkGlcJibgwYi60GngAjcyK0/EjXAfYFwKUI3/a9p/aFLdENUfVdxZO5+vTAmWnIBgXmKkle7PDcG6RGBUTyNVm1mgys3BXrBAjNeyMCgS0+LoifNWnFM+ls9rWG722dwmxCJp0xlXl4dG1fMHmNIshu7gZjzQ
DKIM-Signature: a=rsa-sha256; bh=OLc7BM1Rnf3oj+dMfZaRoyU3ptZ/B8mjVnr/gNwQH7A=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787169388; v=1;
 b=dKsQFwH2UoNuSO+mRkd9L80CBwHDWVm+uHNbwtIRfIAmiVcZ4dT87B7/U4sDFSCGHRT4KMo7
 lDizu14AurYmj30sPMN9XGySIMPGqzZdQ1bqarJCUh9kJzeJBaBJIy5Sf42dmsyFn5HPysgcqS+
 tcRipkPHlsqdrnq4HAF4JykAz20XXMQcXrEcgLiUaz7tUUxYs8MgOBu3JmeqoeWWCudm04t2ZKA
 EXUBVFdjXmPqJGWZ1ZEMowG8A3fTc3QTlTEc6lyTBzlCZYmrUwW2q9KH16VNigSUoNaIvDjkXtw
 hUwbFpFnb+ldHCEnvBVZg+WAvh5ojdZmaOIFfK04ytvbQ==
Received-SPF: pass client-ip=51.210.91.13; envelope-from=clg@kaod.org;
 helo=smtpout4.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/13/26 08:24, Jamin Lin wrote:
> Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state
> to AspeedSoCState.

I think this can be merged in the following patch.

Thanks

C.


> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index cd68c7f1ca..2e7987f9dc 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -25,6 +25,7 @@
>   #include "hw/i2c/aspeed_i2c.h"
>   #include "hw/i3c/aspeed_i3c.h"
>   #include "hw/ssi/aspeed_smc.h"
> +#include "hw/misc/aspeed_acry.h"
>   #include "hw/misc/aspeed_hace.h"
>   #include "hw/misc/aspeed_sbc.h"
>   #include "hw/misc/aspeed_sli.h"
> @@ -81,6 +82,7 @@ struct AspeedSoCState {
>       AspeedSCUState scu;
>       AspeedSCUState scuio;
>       AspeedHACEState hace;
> +    AspeedACRYState acry;
>       AspeedXDMAState xdma;
>       AspeedADCState adc;
>       AspeedSMCState fmc;
> @@ -270,6 +272,7 @@ enum {
>       ASPEED_DEV_EMMC,
>       ASPEED_DEV_KCS,
>       ASPEED_DEV_HACE,
> +    ASPEED_DEV_ACRY,
>       ASPEED_DEV_DPMCU,
>       ASPEED_DEV_DP,
>       ASPEED_DEV_I3C,


