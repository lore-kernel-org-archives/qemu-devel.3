Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F50CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE9gP-0005gp-Ss; Wed, 29 Oct 2025 13:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9gN-0005e6-35
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:10:00 -0400
Received: from 9.mo552.mail-out.ovh.net ([87.98.180.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9gF-00070T-Pg
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:09:58 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.110])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4cxYdS45Rnz5yh7;
 Wed, 29 Oct 2025 17:09:48 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 29 Oct
 2025 18:09:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0069d3c29ee-ea1c-4833-b376-e5e8eab47fce,
 1C4C5A15D30C5F2C89D761F8A9BCD43732F6FBF1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.104.153
Message-ID: <53f3d7e0-16f4-43fc-ac3d-c6dfa8ac7d43@kaod.org>
Date: Wed, 29 Oct 2025 18:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [SPAM] [PATCH v1 09/13] hw/arm/aspeed: Split Witherspoon machine
 into a separate source file for maintainability
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
 <20251023100150.295370-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251023100150.295370-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 9f14e0c2-743c-4cf6-9068-e5cfcd318a3a
X-Ovh-Tracer-Id: 5358157657433017266
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGJtndeWzAcVmR3XQqv252AeEKBLpnCW+HIMR3QhdhXHEsRNZmTBWFtDuU6G+K6XLtB/XeQtVkaVEIms8z9pRt1yRQt5qfUQRWa1vgO4ljZG7KmZQIpeYzfsufFgQguJNkamwBp8BU5mKpdVzsE4CJJYW+iPhQhTOSpXMqHQ5Uas9wmwwo0I2RlKcjPHbwdNzRInedZEzld+taO0Ma/RRGS9Ram7OQgXGdQlRhrogme9kqwmVbSsmaQ2zYV/ByLPjk7mGrz07y/gMJmTxHLVoOA97IjGia3ClVPINkGCFkzHQhoyDv8PBvWtxprOEDa09El/jlk1VPGy6oBC4ZR2S8yBs0BneN0E6zmtBdByWb4DtoSqSvXTeKCU+U9sWCum5/JDswF49MBkZRl5tFCD/3ZGbM7F8hH0d+Yg36oaR2D7NCGD9tjFH+p1MuQB27ngQHpcXOVmCjYuZJfA42J7wW85IOR0ICcEMDtdTWk0eSXPpD5zNlihX1n87JPl8e9DnkWJ5TBYBkmZNFrXVwoU6zbAkphCp/btrh1jvJeQ84zk1nolBHtFdtPGxnnjNYnPMF34zLbo1jMTpSEjdd8CL/EpSssx7MeWN8H5LInHLvYyXJi2fPWHx30wVFdq1GsyLy4MPyAkbwfZ05YDrI3tZ8p6Kb6xhpgykoqbBt67XR/4w
DKIM-Signature: a=rsa-sha256; bh=49Quk4wfVjVvkIi10eICyYRNpyEevpD5m5lPOfjP9SA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1761757788; v=1;
 b=ZwQ0JsXt1ZTZjy3WZba4yMs3Zr3i6qbRRnyXL1kILCw3moqQEAzWy/aiKN2Y6Wmnt6rzksVj
 wlM/kzdu7LGJzKKT8E6235b2/UkZ5aHU//W+EPiWPEvbbfegu6qq0TTn91pej8Z9+FmiXN1Dfs4
 6bODwxZ25meQ46AeHcnh+fESHQHm85JfXyAMbEUr8UfsVCIPZQXLBym8M77iGgrJU3uvD8njycr
 MKIgV4ECAxXAaUTDvwpNwgGWTGtnG8A6bH6Z2DJ6QMIwJOKHKlHKZpggGyX0rrXumENFdPg9ft8
 sAzhWUw4KYGfUw6bSpoEwdAvHFifu0B/1DVSiot+CjwNg==
Received-SPF: pass client-ip=87.98.180.222; envelope-from=clg@kaod.org;
 helo=9.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
> This commit moves the Witherspoon BMC machine implementation out of
> aspeed.c and into a new dedicated file aspeed_ast2500_witherspoon.c.
> 
> To support splitting Witherspoon into a dedicated source file,
> a new WITHERSPOON_BMC_HW_STRAP1 macro is added as a copy of
> ROMULUS_BMC_HW_STRAP1.
> 
> The change is part of a broader effort to modularize Aspeed board
> definitions, allowing each machine type to be maintained and updated
> independently. By isolating Witherspoon logic, the aspeed.c file
> becomes cleaner and easier to manage as more platforms are added.
> 
> Key updates include:
> 
> - Moved witherspoon_bmc_i2c_init() and related LED setup code into
> aspeed_ast2500_witherspoon.c.
> - Added WITHERSPOON_BMC_HW_STRAP1 replacement macro for local use.
> - Removed aspeed_machine_witherspoon_class_init() and type
> registration from aspeed.c.
> - Added the new file to meson.build for compilation.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c                     |  81 --------------------
>   hw/arm/aspeed_ast2500_witherspoon.c | 111 ++++++++++++++++++++++++++++
>   hw/arm/meson.build                  |   1 +
>   3 files changed, 112 insertions(+), 81 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.





