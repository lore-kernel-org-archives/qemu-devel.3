Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77DBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGx85-0003ZG-9v; Thu, 06 Nov 2025 05:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vGx83-0003Yx-KZ
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:22:07 -0500
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vGx81-0007ys-SI
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:22:07 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.158])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d2JC72fvrz6N10;
 Thu,  6 Nov 2025 10:21:54 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 6 Nov
 2025 11:21:52 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003dc499cbf-3cbb-4d7c-9a8a-e022e86b7db3,
 1EC303821F6CCC1051669714FDB86A1A85E07995) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <99b099b0-e28d-4fc3-b2d3-5e9f08d1d6f2@kaod.org>
Date: Thu, 6 Nov 2025 11:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] hw/arm/aspeed: Attach SPI device to AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-10-kane_chen@aspeedtech.com>
 <CA+QoejUqmspVZG=-T8TRbbc5nRXy0YQsLg6A4M54o6k=EkW6kA@mail.gmail.com>
 <SEZPR06MB7619311D7021C5112BAF664AF7C2A@SEZPR06MB7619.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SEZPR06MB7619311D7021C5112BAF664AF7C2A@SEZPR06MB7619.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: ca71c127-2bd1-44b8-bba9-7ad58ba0be21
X-Ovh-Tracer-Id: 8557402242000522229
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEjc1rK3l5boO1FcW+qeFksjofBuwK9b93jwNspYBaT4V6HTv/oLJh/4ijJ0K58zugQ9JKZtK7Rvb3cmEjFJZjiDuh49EzbnNAy9F7pBEAlnZJnX2hfpPmFb0hnLDIaRC0otBzt5GkuK3+2JjkNn8vRE4x6zVakRZsOOrCOfQGdh9cYNP6WrKZyHVnj6e4HnoNHVbp77QoIBscV5SdQmmfwU4Xy5jla/CCZENRbnFkIXf20pt7KPthytGL6j77kc4/CXF/UCW/6y/BVYD49yY8HxYiZPbrv+mpIdq4pTLDdUwXxJZT7SyuF6lUmWoCcaiWFzenb4lHgfMoSZ4tL8VIYdeBjVu7cP16ozcXTXZri+oRUNu+o2p450MY7n8sjriYifgZBIjKyVtUVAjJHt6xxau0WXpE6NEPl3xPgXe+RspOMgmcgk1aXJVoZLwZl24PWuS2JhXoq4Bx7sJV9r05nUEBb9UQpZeS3/SSh1qQPLChTAOSmkcebs6X3yvzRsm5rJgD0huuhVQS7v6XDmqSQHk+eRYhb/0ryCayp+ZaeSZaGx4eqA/SCpigfKCaBTnJrw/VDx+T9N5jOGxhDZk4gAgmCeEBgJPq+OCILq/SOqjrR5iQEnubB6fMlMpPaV8OkD80UhFhcBrk33u8fyfZi4H0AVxEhi2s7r3MeCTJP4g
DKIM-Signature: a=rsa-sha256; bh=j7jC/KvvQEiDO6Ak3uEPm2DrKbabNP9MnA0rlfeN8Ig=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762424516; v=1;
 b=cuUHNoPMd76LyTAGyGM0LbHPlgJKlDSEE0hbRq7+aCGUbHWEQFaCzksUagtaewse30wyNTTC
 wjH2HLSUDi3h/ojHtDdQ64eujWz1jDNyhCGlCuTyg6AjrgvTwkaTwAtoIhnuoGpBv4tFpzXj62J
 yCBOieOz8AdxwTK5frmjriAtLr88UTYebgrNNubfobbHIB/LGppIyROghFgvr/LN8/JOzvl2b5J
 E/sWvSSWbsxf/zg1QV5EZrS9FLAeuVkHtTaS8FvSQN3uwJWFusJJDlmJ0WdXzVNDcGqu0tV1JR1
 7iDLDovSzSFXPVq17JOtvHk2ArHtNQNEY7OvpAJ8s4jQA==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=clg@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/6/25 11:11, Kane Chen wrote:
> Hi Nabih,
> 
> Thanks for pointing this out. It seems I need to add the abstract attribute to the aspeed_ast1700_info
> structure, as shown below:
> 
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> index 3d9a920a7a..ec95217f16 100644
> --- a/hw/misc/aspeed_ast1700.c
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -286,6 +286,7 @@ static const TypeInfo aspeed_ast1700_info = {
>       .instance_size = sizeof(AspeedAST1700SoCState),
>       .class_init    = aspeed_ast1700_class_init,
>       .instance_init = aspeed_ast1700_instance_init,
> +    .abstract      = true,
>   };

Hmm,

Please rework all typenames in aspeed_ast1700_instance_init(): remove
all snprintf() and use directly strings like "aspeed.gpio-ast2700".
For now, It should be fine. We will see if extensions are needed
in the future.

Also, I don't see why you need :

   static const TypeInfo aspeed_ast1700_ast2700_info = {
       .name = TYPE_ASPEED_AST1700_AST2700,
       .parent = TYPE_ASPEED_AST1700,
   };

Can't you use directly TYPE_ASPEED_AST1700 instead  ?

> On the other hand, I encountered a timeout error while running the make check-functional test.
> I need to investigate why the test case failed.
> Once this issue is clarified, I’ll submit another patch for further review.

Wait for some feedback from me before resending.

Thanks,

C.

