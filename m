Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7DDD262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSsr-0001op-4g; Wed, 21 Jan 2026 02:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1viSsm-0001nX-Bu
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:44:04 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1viSsk-0002mM-8d
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:44:04 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.52])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dwx5m5PHrz5w1C;
 Wed, 21 Jan 2026 07:43:56 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 21 Jan
 2026 08:43:56 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0084669dbc7-6ce1-48b9-bac2-542babfb5a4d,
 2A1105FB3D88C00DBC221EB2088BBD2D7A128EAC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <98c165bb-3f39-4254-96f4-7965bba8fcf2@kaod.org>
Date: Wed, 21 Jan 2026 08:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/aspeed_i2c.c: Add a check for dma_read
To: Nabih Estefan <nabihestefan@google.com>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <steven_lee@aspeedtech.com>,
 <leetroy@gmail.com>, <jamin_lin@aspeedtech.com>,
 <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <qemu-arm@nongnu.org>
References: <20260120211116.1367476-1-nabihestefan@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260120211116.1367476-1-nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 0d02a0a5-d777-4736-9aac-bb3a7b0675e2
X-Ovh-Tracer-Id: 9492462117638867759
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGpao20fvRN2wmaav/nGnv+HxcE+P/CZ9tkQLyOSa68nM5VdY+CqGi5pH+GYZa7/cc9ie78WqD4zU1uB0ZLYyXadgUkP7xqqF8KOMnaqnwcV2wt1XoeKg1oWshIEnC2Va1YySi0hcMtwEPgfyMrfvTbEpFNORGAN6rDx1KmtWbYnTn6e4+i12S7Jzhwew+wK90o2OcacRgXoECJ3eXt/pDy7LmAlnoE5m9gwHiZMe1NhZ6IAvysDfto3ixRkFXLH3Q7R2AmEU9E0LU7RO1JwErXOpECugEwv2j02MLGMK/R18+aHXTtLJOzhXs7IFZuzTmQ7K/P676IMNgq3Hd/UUw7frwXc4AK1bnCZmnl4y2HosrlRYgm3+r1MauinR+mqpuiZ4v9Rp1U+2xhWqfyBTtZoG3fU/pXnMVGKmJlFEe0LkxqLi1B4NkHkgTnkWA//lWUFZTNWR9zl8vs8kpp4yVOkjyB5XhJG+hkHc5gK3p7hj6m3nGBGfLSIW7guMa6BlzfawRXAS8uEJFfqywtvCD9LzdtpBdZeFCKIDMllb2FiXK/WEa58Oj8lGCGBSHYlIRyJHl5XPTUoXROUkoc4lwznr4/n+zCWOYISDgBUYLgQQNfZ7zcPe/Nzwj655GdV0VkZXY/O+S5NOfEgx9irwVoeQU2mJzeFDySi/YnvbmLrA
DKIM-Signature: a=rsa-sha256; bh=/c1KhJw9vfGWAZqbSFKE6BctQDN8lp/hyf/6TAGMy/E=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768981438; v=1;
 b=CgE79AnFmASqsdaoPj27uPqtfs+v0YnRw5XRrAlGLx99/NskW6TMcyfs8A7ANSG69lHtDxd2
 blgbMLzG4mzM3k5fdHMx5LVOAPFHnlghaQwWJAqRaqjlIwJiSUdvptvqPayQBAGvbfotuWzNY1U
 o70xjvC5Y6iUaNX7uxKpGoE/c4Z5XVTyPg3pgEoqAoWPC5nsxqcwWQoSFmJa9T8X3x6SIr6cy1W
 8Qbf7p392SvhGgpQ8PvCph92UJQMfttHgDbfAT328XJk9Jc2uBj9De8lt4Ile82EsT7S20onzAu
 FR52kzdaf5o4kZKow7NZ1vYpiGK8ka76uzkI/dmG4iqnA==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/20/26 22:11, Nabih Estefan wrote:
> If aspeed_i2c_dma_read fails in aspeed_i2c_bus_send currently, we get
> stuck in an infinite retry loop. Add a check for the return value of
> aspeed_i2c_dma_read that will break us out of said loop.


Have you ever encountered this kind of problem ?

> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   hw/i2c/aspeed_i2c.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 1b8ac561c3..3de72db652 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -272,7 +272,11 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
>           }
>           while (bus->regs[reg_dma_len]) {
>               uint8_t data;
> -            aspeed_i2c_dma_read(bus, &data);
> +            ret = aspeed_i2c_dma_read(bus, &data);
> +            /* Check that we were able to read the DMA */
> +            if (ret) {
> +                break;
> +            }
>               trace_aspeed_i2c_bus_send("DMA", bus->regs[reg_dma_len],
>                                         bus->regs[reg_dma_len], data);
>               ret = i2c_send(bus->bus, data);


Reviewed-by: Cédric Le Goater <clg@redhat.com>


Thanks,

C.

