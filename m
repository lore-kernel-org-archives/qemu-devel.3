Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85254D262A4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 22:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJoV-0002Gz-8X; Tue, 20 Jan 2026 17:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1viJoT-0002C6-3M; Tue, 20 Jan 2026 17:03:01 -0500
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1viJoR-0004ky-1R; Tue, 20 Jan 2026 17:03:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.85])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dwhCK1lXFz5vtK;
 Tue, 20 Jan 2026 22:02:53 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 20 Jan
 2026 23:02:52 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002da52b8a6-6b0b-4833-abbf-85297594fdb0,
 21EA59D4F1114275CF698448FAF8CB5A144B01CF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <47905102-23d7-47f4-b4a9-78f028c22846@kaod.org>
Date: Tue, 20 Jan 2026 23:02:51 +0100
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
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: ddd9f0c1-5940-4e17-8961-48109f6a96c5
X-Ovh-Tracer-Id: 18126144077204917039
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGD3mh3hd83Cxzj7Wub2hayWrIgP2CeV2JFP4vKG10994f3ynEevxk3n2bOfsdDge0GaYfKq88gZIi1RytIzhC05QEjNtK8/JKPWySKudXp2/GY3rYVY/2l2EotBTbLenZk0GH2NxPt1aL9EmFaiWaGWJVms1dLRRBlcoWMBFW822pz2p6X9vU7t5zLLwjpEvCK/cJOd59U4s2ruDv9eUKPkk1cLX8wL5LT28pktgqPqCDrID/oYA+2G0F9NOkc0FjVi5ScwO+cArTZgVBnpjuZVpfcKfICFXqA6i38lL42yH9k9B8F8bjG88qXoKL5J6PlPxej6V69EPUwbDcW2cb2WJ7VxGZ6GAtC2z27zMdvDinj20BRDMBfETfmXFiRAfwuW0bgiIjuPIjC49slqvfwdSkkYoVoLaAzm1rKo97G+h4z2p+SQsyhMVseJggincZGuKSSarE4dWsV3U9TvRN1h8ohcT/gXgloVOZgjDbdswNVj6ebTTiz/cdLoNE10R0uPR6CMoQPCID1y94lvXmnYWqrMcHVD4Rinw7oAUQ4hzycX4siEFlonB95HUfY3jBZjGBO774iGGLGz/KEYajy0CfqZwAHXlkMyNNiy0SAzPcI4XBHUCBkykSomWbUNXcCqeH/KTvfcST8teoZ5c1Hneyg51IPaHuQJodQizDelA
DKIM-Signature: a=rsa-sha256; bh=q8Mlc7lMJXkW7QAcQjQtPp02hNvf4fhvVa+c13GzKdU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768946575; v=1;
 b=sP5YjsD37ciPKsyz9obad2iXlkp7Uv5tjEsYLaFQoKVebpOri00pW/Op7K1PJb2aGdpjFIZC
 3jpDOycLCt1yFAfMVdWcThQksoY6N3+q9XRqRcqXkwSGgr591ZETG5zm8NeOUB0MuQTQeF+MZ/A
 HuLCsxis8IXGtdLO1fWG0epKxkyJe1aRK05CbnLr1tSQicidcn8mTeG43c05l1zRy+0p5AydFeT
 PWKRR9bJZWR4ivvNEUsBupIOTE/UsF8wFtILK6YewcckJsm+oNyg7lKJblMzX/pMrQ9JWa7KuvC
 e15nVh6J65Vkf4urfFQTtb6kiij43rPOGN5mvIwOXIivw==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
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
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>


Fixes: 545d6bef7097 ("aspeed/i2c: Add support for DMA transfers")

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


