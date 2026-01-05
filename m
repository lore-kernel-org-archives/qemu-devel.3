Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E740C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcnkT-0003h5-Hc; Mon, 05 Jan 2026 11:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vcnkR-0003gH-2B
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 11:48:03 -0500
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vcnkO-0002qk-46
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 11:48:02 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.62])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dlKwq5v2Rz5vSb;
 Mon,  5 Jan 2026 16:47:55 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 5 Jan
 2026 17:47:54 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005de0fceb1-f83e-49d3-8f01-108e1a71f665,
 57A157A87F73C68790EE1B05CA42A5939BFB4281) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1fd2f102-6a4c-4e6c-b9ee-a3e340763747@kaod.org>
Date: Mon, 5 Jan 2026 17:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Refactor ASPEED INTC
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, Patrick Williams
 <patrick@stwcx.xyz>, Joel Stanley <joel@jms.id.au>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>
References: <TYPPR06MB82060AAD1D538252B336AEA8FCBBA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB82060AAD1D538252B336AEA8FCBBA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 1b813ef5-cf41-49b6-926c-826463d9d00d
X-Ovh-Tracer-Id: 16950141625798593528
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFA6TgI3KzuiKYdyQ10XJF1I3R47D40+ZbSTSwU7U8XM2ec6tl25jlmI2r6dlidzFuf9A16XxZay1Oe2mOr6RKJni7KivMu9EuKIzvwXZi9wImkzDAQoo4hYc/Xp2/cPo+4JqhOWR5oostnMCbCHJI+VynT07WV6bCPASAC9snVzhcWM2CZao49mqiuoMxWrc7Ud2HE3HX/IM70ZEH/c9IuFT8SD1StaKLUACDFyhbZXXROfJSVWMZzQ/0dgsgpnpplGtLhFB391EtIM62iSl540RxcgKdgkWlP3CRJp3RyDaV1lXTk4kMX/OXlnACUz7NU3BM5pbRXqupucUSxxZ4Nso6Pye+9GY40a41D+AlGgwJd1En9silX9B+MRxYkLJnJ8tjLeWEqEvNLh16nV9pVT+Yk4Y9LSz1gmF8DQYbMAAWp7CRBinxK4XQhraCr212hP1k9nIpKAUR4KRm4gDQqZ+JWlNAeOj+XN7kfKRpGw7KYjfSE2/gh19YsCFOjztajftj9JVGezKTx5P9AQTedZDN8ur7rXfau6MD3yVimmSJaHPbz7jUNVQCeqbnlrcGSj3QAn5kEaMH/ykoy86Z/yc1u+dCfjyZmZeQfZYWFAIomJ48BfY2+Z1ITVD24m0QC1MAvca9EG2+jhYCmhR6dYY0hsu/eNNpcaMG/7N0F+w
DKIM-Signature: a=rsa-sha256; bh=ElvLLYFfTRB1WYWLOD/FMQRLxsZZ8B9DhNwh4h2saoY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767631677; v=1;
 b=az2UbXM069Iu3tD5sZ/RID1FhvrrF4l53FL1h/7IZJdF3SP9Pv+BLcd51awTxwaoARJbggLb
 QyAgSalGz/8RGt+Ioxe4uIIEvfKxQ5M0JzgBNmVjkqYdCFOX87s9vt/Src4B3Yc9x5TXK+TfMW1
 xjSapBbH+o89dyBmDtTJ5Kf7yfcerEw6lJ4KkwcvX4zYUK/bvxuLMxfOTap7p+PpXTQycrzcZOP
 f5lSz0Mw506Osm9QYdsuODDgLGUv+N50Tcw2QINaQEOtU3FO3Rs2cFmllAEHcmblLgp4g7lf3a8
 NRBFpW2QWGDZ1dYVoD07KYWclDyj3pCPVBytXwLkciurA==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=clg@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 1/2/26 08:52, Jamin Lin wrote:
> Hi all,
> 
> *I am considering refactoring the ASPEED INTC design.*

For what purpose ?
  
> According to the previous discussion, one suggestion was to create separate memory regions for different register groups in order to reduce code size.
> 
> The total register space of INTC is 0x4000 (16 KB), and the register space of INTCIO is 0x400.
> 
> Based on this idea, I created a GIC memory region with size 0xB08 and mapped it at offset 0x1000.
> 
> Relevant links:
> 
> https://github.com/qemu/qemu/commit/7ffee511fcf1487e016ae1d11c5e191557a8b804 <https://github.com/qemu/qemu/commit/7ffee511fcf1487e016ae1d11c5e191557a8b804>
> 
> https://patchwork.kernel.org/project/qemu-devel/patch/20250213033531.3367697-2-jamin_lin@aspeedtech.com/ <https://patchwork.kernel.org/project/qemu-devel/patch/20250213033531.3367697-2-jamin_lin@aspeedtech.com/>
> 
> As mentioned in the discussion:
> 
> ```````
> 
> However, we could "optimize" a bit the MMIO apertures to avoid mapping
> 
> huge unused gaps and only map the useful set of registers :
> 
>     INTC Registers      [ 0x1000 - 0x1B04 ]
> 
>     SSP INTC Registers  [ 0x2000 - 0x2B04 ]
> 
>     INTCIO Registers    [ 0x0100 - 0x0154 ]
> 
> Each set would be associated with a subregion which would be mapped at
> the right offset in the region container.


IMO, we should keep one device model per HW unit. So, 2 INTC device
models for the AST2700 SoC.

However, if the HW unit has multiple sets of registers grouping related
features, it makes sense to introduce a specific memory sub region per
set of registers and map each of them in a memory container.

This could make sense for the INTC0 unit but it's not a strong
requirement. I didn't look at the other INTCs.

> ```````
> 
> However, after implementing this approach, I see several issues that make it difficult to maintain in the long term:
> 
>  1. Register offsets no longer match the datasheet
> 
> For example:
> 
> REG32(GICINT128_EN,         0x000)  -> 0x1000 in the datasheet.
> 
> REG32(GICINT128_STATUS,     0x004)  -> 0x1004 in the datasheet.
> 
> This mismatch makes the code harder to understand and more error-prone.

Hmm, that's not a strong argument. The naming is more important.

>  2. Sharing INTC / INTCIO between PSP, TSP, and SSP becomes complex
> 
> To allow TSP and SSP to access the same INTC and INTCIO registers, we would need to create many memory aliases, which significantly increases complexity.
why memory aliases ? I don't quite understand your objective.

>  3. Poor scalability for future SoCs
> 
> Currently, we create separate SSP INTC, SSP INTCIO, TSP INTC, and TSP INTCIO memory regions only for AST2700.

QEMU models all these interrupt controllers :

     .name = TYPE_ASPEED_INTC, (abstract)

     .name = TYPE_ASPEED_2700_INTC,
     .name = TYPE_ASPEED_2700_INTCIOEXP2,
     .name = TYPE_ASPEED_2700_INTCIOEXP1,
     .name = TYPE_ASPEED_2700_INTCIO,
     .name = TYPE_ASPEED_2700SSP_INTC,
     .name = TYPE_ASPEED_2700SSP_INTCIO,
     .name = TYPE_ASPEED_2700TSP_INTC,
     .name = TYPE_ASPEED_2700TSP_INTCIO,

So the current design looks OK, AFAICT.

> 
> Supporting future SoCs would require adding even more memory regions, which does not scale well.
> 
>  4. Total mapped size exceeds the original INTC size
> 
> *The size of SSP INTC is 0x2B08 and the size of TSP INTC is 0x3B08. The combined size*
> 
> *(0x2B08 + 0x3B08 + 0x0B08) is larger than the original INTC size of 0x4000, which is conceptually incorrect.*

That I don't understand.
  
> *Because of these concerns, I would like to change the design to create only one INTC and one INTCIO to improve maintainability and correctness. *

Isn't that the case already ?

See aspeed_soc_ast2700_init() :

     object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
     object_initialize_child(obj, "intcio", &a->intc[1],
                             TYPE_ASPEED_2700_INTCIO);

> *In this model, coprocessors would only need to create a single memory alias to share the INTC between PSP and SSP.*

I think you need to explain more these new requirements to get feedback.
What are you trying to achieve ?

Thanks,

C.


