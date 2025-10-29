Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1837ECCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE9go-000656-Jv; Wed, 29 Oct 2025 13:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9gk-00061W-Jz
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:10:22 -0400
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9gh-00079I-RF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:10:22 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.134])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cxYdy4tSxz5vtR;
 Wed, 29 Oct 2025 17:10:14 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 29 Oct
 2025 18:10:11 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00634800ecf-7d3d-46d9-b339-303f80504c8f,
 1C4C5A15D30C5F2C89D761F8A9BCD43732F6FBF1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.104.153
Message-ID: <2f0279d5-619b-4ce8-ac32-83c327d42eb1@kaod.org>
Date: Wed, 29 Oct 2025 18:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [SPAM] [PATCH v1 13/13] hw/arm/aspeed: Split AST2500 EVB machine
 into a separate source file for maintainability
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
 <20251023100150.295370-14-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251023100150.295370-14-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 7ca820b7-cf98-4e15-9fd7-376290ce766d
X-Ovh-Tracer-Id: 5365476006626298802
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGJtndeWzAcVmR3XQqv252AeEKBLpnCW+HIMR3QhdhXHEsRNZmTBWFtDuU6G+K6XLtB/XeQtVkaVEIms8z9pRt1yRQt5qfUQRWa1vgO4ljZG7KmZQIpeYzfsufFgQguJNkamwBp8BU5mKpdVzsE4CJJYW+iPhQhTOSpXMqHQ5Uas9wmwwo0I2RlKcjPHbwdNzRInedZEzld+taO0Ma/RRGS9Ram7OQgXGdQlRhrogme9kqwmVbSsmaQ2zYV/ByLPjk7mGrz07y/gMJmTxHLVoOA97IjGia3ClVPINkGCFkzHQhoyDv8PBvWtxprOEDa09El/jlk1VPGy6oBC4ZR2S8yIQA4mbcPVbCCHCgNICUxEQQFUHzsCakeXgA3k67OFRANZGYLRoZUleX588JNS7Qbupl8mawHk19sFRdc6/ZkC69+oSW9rlWRjDW8A3CB6+375gXapD4z+xPhrTP6Nv7CLds/1EGoR34SItBqy8Hgq0bbDaDvs6in1fdYFPC6l+U8pNtn2nredmhfcGWj/jK3X4l2loE+m6xu40Cf+ll9OXJQv8BgiOFZXzGZQOvrrfqjTHtUA2i6ivCuevHD5YWvX92rzAUhn1W8m09Af9VQ0at25PNDsOJzFqdoYTp3ybiEeDQfjEGfQZ/GvdvZBhjMN1ez4nH4t1CNwQBWDtQUqQ
DKIM-Signature: a=rsa-sha256; bh=Sk78NMC4TfOii39X25LCatH/+mH/m+DJOn6fbE5VuQg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1761757814; v=1;
 b=INKY2HR6a43nhgu5OgYXFJaIFTbr5uY45HAcnAsCj0SIdn/NWKXIreI0cYDGKATfG8Oy+CeX
 lIvUMO5wSAf2+c6pGICm9GHoAzIgksS3xCGabwQk7pbzr5j349B/OttHPhX3y+Vrw1BnNg35Ylh
 LJSq2qynqBb8oixTVsdkZ11VI7H4GT2ijWFkfoMys0X48ysJgsaIGQk1uA64DiDlS5QXDP5YsVz
 D942dVEabMm9lUy+pRCxaedsl10TSJdsFBmq3ZpuV2emUJvy5b+RK33c9xeiCEDh6RGNQRR4+JM
 kS9vSohIqwTKhsrLamjmZFBDlsxb76JaShbqiAU8pNX1w==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/25 12:01, Jamin Lin wrote:
> This commit moves the AST2500 EVB machine implementation out of
> aspeed.c into a new standalone file aspeed_ast2500_evb.c.
> 
> This refactor continues the modularization effort for Aspeed platform
> support, placing each board’s logic in its own dedicated source file.
> It improves maintainability, readability, and simplifies future
> development for new platforms without cluttering aspeed.c.
> 
> Key updates include:
> 
> - Moved AST2500_EVB_HW_STRAP1 macro definition into the new file.
> - Moved ast2500_evb_i2c_init() I²C initialization logic.
> - Moved aspeed_machine_ast2500_evb_class_init() and type registration.
> - Added aspeed_ast2500_evb.c to the build system (meson.build).
> - Removed all AST2500 EVB–specific code and macros from aspeed.c.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c             | 45 -------------------------
>   hw/arm/aspeed_ast2500_evb.c | 66 +++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |  1 +
>   3 files changed, 67 insertions(+), 45 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast2500_evb.c
> 



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.





