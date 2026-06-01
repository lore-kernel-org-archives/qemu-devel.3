Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B911CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6JA-00047X-T7; Mon, 01 Jun 2026 13:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU6J8-0003vg-1q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:20:10 -0400
Received: from smtpout4.mo536.mail-out.ovh.net ([51.210.91.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU6J5-00030l-NF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:20:09 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgh40nQpz81Z6;
 Mon,  1 Jun 2026 17:20:04 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:20:04 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.151])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTgh36zRgz20mQ; Mon,  1 Jun 2026 17:20:03 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 0AD972403041; Mon,  1 Jun 2026 17:20:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002496e4432-96e1-44e6-ba59-62d6a2b60ff4,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f27d1402-3e75-441a-990b-92a146d0648d@kaod.org>
Date: Mon, 1 Jun 2026 19:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/21] hw/misc/aspeed_scu: Drop noisy unhandled read
 logs for AST2700 SCU/SCUIO
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-17-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-17-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13782140763562290315
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEqSEx9QhvL9y/dlpg9I6mxuR3tUsPQ8emcKcf2HIFc5U5ma4aRQoiGTUGmSGUowe53lupJ0ZZJ1mlboW+aiAXVAbXcjnG3ZrkzJBC2TJLKnDqc2pEPQWODefb9mLtc9iGpPR1GLSlTevIVOqTS6fWUfv9yfqNprE2Mlpz/p52K4leYoAWp4tK9f4D9vRb/uPqtHwByYgQCk3vCpupEmF1QfKiN8j7pGjtUnC0NO1TalBnpgOe/sOwku2yynMLhiCaOJvJXAri45oQ3gjYsCtnw3bTciHOqktHUiVE8OmPQMZvrqGgdwXcb8GFTY0YBiREiGKGKiHOl8F1lJvXoy4Zme/aZc2p/9RGZn0jy9MZBDu71EeW3zg1P7tlu1VzrRnCry2ctVjKZHtuBtAmIvqp+3m1ZJEtXVwN0aWOcP61/fzpj//8M3K3p2ls0I/YytGkMJThd12zHVIlREQyck2UWWDqJiiCu1H2OFegtKsrvUu8BjvsKz8Vs48UgAHaEJP7efL9opvrgcp8/GXbPNm3rpnfggMDKfA9eicmrN2GrCoR+HP6E7wgS5U0JBSBvQwQEjNJRA9sH6jAcZwh+Wbn3/LXE0kpVDr5bclcI2vBf4OPmUkfzo053y6L4dLaHdM3DTj3Gp34Cuw8dqDqSvcfcvJfgiED+wczna/dpqztDNw
DKIM-Signature: a=rsa-sha256; bh=mXdYAMHrIpv5RukVeoC1xcvoFPLozHNaIbTyR7RCEWw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780334404; v=1;
 b=B2EB7nqMKRtD+927xgX0VLLuzKSI2lBUwSzH6dskMb1IUDSJgiMog95d85hqKSWq33lMXhzV
 V1JezQDx1xeS3Os9KstXsUfVi0P8JjtpOiSI+Z1oFKm2lNCFx4YRJSAumEhl8dG45aor5gYEqXP
 D6TZx6S5We35wuiocTLMwIjQGcK44QqYZp1Xf/YloO3VeM9obCjcXvKvZu0tu1QhJbAlIQ50af5
 D2T6asLLRgSDxBKXthUywYU/HZ52CS80RAg48yWZu1Pamiftpf6pL42a+tzAxzfv/2ZIQJo9kAf
 TIk4kzS5rh0Zg/q992OVahv0ZD9Nc/aymEaLNbwh0lqiw==
Received-SPF: pass client-ip=51.210.91.13; envelope-from=clg@kaod.org;
 helo=smtpout4.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/17/26 05:28, Jamin Lin wrote:
> The AST2700 SCU/SCUIO read handlers currently emit LOG_GUEST_ERROR
> messages for all registers that are not explicitly handled.
> 
> However, most SCU registers are simple read-back registers without
> side effects, and do not require explicit handling in the read path.
> Returning the stored register value is sufficient.
> 
> Emitting "Unhandled read" logs for these cases generates excessive
> and misleading noise during normal guest operation, making it harder
> to spot real issues.
> 
> Remove the default unhandled read logging from the SCU and SCUIO read
> handlers to reduce log noise and align with common QEMU device model
> behavior for passive registers.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


please send first.

Thanks,

C.

> ---
>   hw/misc/aspeed_scu.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 251c23def0..362733ba11 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -932,13 +932,6 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
>           return 0;
>       }
>   
> -    switch (reg) {
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",
> -                      __func__, offset);
> -    }
> -
>       trace_aspeed_ast2700_scu_read(offset, size, s->regs[reg]);
>       return s->regs[reg];
>   }
> @@ -1264,13 +1257,6 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,
>           return 0;
>       }
>   
> -    switch (reg) {
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",
> -                      __func__, offset);
> -    }
> -
>       trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);
>       return s->regs[reg];
>   }


