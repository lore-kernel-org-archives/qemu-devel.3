Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B87AEE498E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 17:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vadBc-0007q3-D7; Tue, 30 Dec 2025 12:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vadB2-0007Y1-3c
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 12:06:34 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vadAz-0006Ov-Il
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 12:06:31 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.6])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dgfcv28qlz5w9D;
 Tue, 30 Dec 2025 17:06:22 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 30 Dec
 2025 18:06:21 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004c94e92db-3063-4018-a7df-e9c262bfd6f5,
 10BB85812771F3279B7407FE60307F74CBD19E16) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <b67a04d9-3561-4d90-8238-e476ae8896de@kaod.org>
Date: Tue, 30 Dec 2025 18:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Remove AST2700 A0
To: Jamin Lin <jamin_lin@aspeedtech.com>, "reviewer:Incompatible changes"
 <devel@lists.libvirt.org>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 6000dc71-8dc6-4a30-82ef-dd5ad27c6926
X-Ovh-Tracer-Id: 472315013890149365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGL3soYvqjCTyXFEPoUCSY/3eN0A10NNb4YLLriUUnvqRnTk7Asso0mVe6NizB0waxBlThWX/f2zC6EI+xMpcOSHW5RFiCVuztH3JoIrkxyfNs56suxoiMOg+okDh1X5DrhWl7m0xQb3wEhrxkOpQNKRplhK27OVQei2abSDNOu74RXXGlx2wOfZ5vUaNidxKU9sjS4sxU2OfHN4SQKfAs6jJQb9WmPnQW2yOmpqlemIBb0WM/EwzR+1uIAVB5jInB9L8OgpDgPBz4ljewMQR0KYdSgD1hT+VEaYrpWQb3IQBbm/a5njJyDMyxceLKPjodt5H2jFUb7ZyFqrpgq2UgFs1f/qfHZF0NQmCGfTUYH0JMQXIixvGlqFPyXsSmSXuIlKuRTyf5u9NKm8hqnuuEHKWsjxlqdMu70bA1Zv2UjzS+5EFeNFhaA+5o7TA14nP+9bfKdXLfpO7Y4Vczmp+c/bfFtF+5lY9oYnlR5kpcYGvVDt5eDbHnUHKaWHUmxD4pPEa0lc1iIic201ec1EX+XHzHiZyhxRMi+xM/O7Wekg+AnfTWHBKD0BGHVFVW0jodWUwJ6UDAyqpr/p16T/c6fZGlX+RBFojdCjF7eayIS/+sJGJhAJp2wqw88ij6HIGRsFCBi40IFpF9JM0Hx/tfZ+7wrsjhBwEZwEAyCclZFOA
DKIM-Signature: a=rsa-sha256; bh=x74yeCKIlcpYZnHtsmaMTZ3ko2qaE8iVeTjhpj2DNJA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767114384; v=1;
 b=Zy/zLNPqidK7GVfpRKXvI6YTp2jnE+Q5yYS63mkFScMFIg88w/CkeFTE8XsmH9Ysn64Ehb63
 3ZsiuPYqo/8PtUNgl1QT7+EHIDaG0nHgyHS6O374yv7ymBGjyOQ80PZKjcgUvjPlbuX486fzEZD
 1xrY+IV8wGxLlA34snr2wna8SVXqP8XQEbjOf+ZBCejv18l6IznQDc56MSkbiQzU/2/pDGDteY4
 orLrDJJy5SYCb/IC2L0HJv5REnmpBeEZnCdym8Hrm49owEo8Kz7rUVsYgUh4bqS/B+pDKHx//Wr
 eWQxWeqtuXtp9f2c/aLl8PQRjWkR68IL2BsoVmmqY9Yzw==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
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

On 9/1/25 06:08, Jamin Lin via wrote:
> v1:
>    - Remove ast2700a0-evb machine
>    - Remove ast2700-a0 SOC
>    - Remove GIC 128 - 136 for AST2700 A0
> 
> *** BLURB HERE ***
> 
> Jamin Lin (4):
>    hw/arm: Remove ast2700a0-evb machine
>    hw/arm/aspeed_ast27x0: Remove ast2700-a0 SOC
>    hw/intc/aspeed: Remove GIC 128 - 136
>    docs/specs/aspeed-intc:  Remove GIC 128 - 136
> 
>   docs/about/deprecated.rst                     |   8 --
>   docs/specs/aspeed-intc.rst                    |  93 ++++----------
>   hw/arm/aspeed.c                               |  28 +---
>   hw/arm/aspeed_ast27x0.c                       | 121 ++----------------
>   hw/intc/aspeed_intc.c                         |  49 +------
>   .../functional/aarch64/test_aspeed_ast2700.py |  12 --
>   6 files changed, 39 insertions(+), 272 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Applied to aspeed-next.

Thanks,

C.

