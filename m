Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE2CCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ouw-0004sP-G6; Thu, 09 Oct 2025 07:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v6our-0004o3-3C; Thu, 09 Oct 2025 07:34:37 -0400
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v6oum-0004GL-74; Thu, 09 Oct 2025 07:34:35 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.106])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cj77h0Svwz5xL3;
 Thu,  9 Oct 2025 11:34:23 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 9 Oct
 2025 13:34:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0018d25e0da-97f2-4ae4-8970-232277aa75f7,
 0ABBE769FBEA5341A3875E1E3E57BEA7B23E4658) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <326472bf-4242-4d05-bca5-b0066b48c541@kaod.org>
Date: Thu, 9 Oct 2025 13:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 00/16] Introduce AspeedCoprocessor class and
 base implementation
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251009023301.4085829-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251009023301.4085829-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 3a573b4d-f33e-4778-b5c3-0ae125f6645b
X-Ovh-Tracer-Id: 11366803986204101554
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFZIliC4rtRc7GPWHR+UrUILm7lcoBUU0+RMJCNMS/KX7uFl50xZYzSjXkmmpTRMKBAozmyWEGaH7aUUACDVWZBa3h81B31tGDZ8GSWLSc5fTbtsRdLBar8t1fBz5symPpLXRIbdEOk7UJ7iJYANF7uzqbQSL44xIs4yOWkOp2tcKyIav7/yjR9HwpFidU1A3gj0nBep7463qMK7WSGiU2Yd4Giw1nPK3KhheVH83vs6KS/EU5Zjk9a70CGIaa6MIYWzxiLliphz5jQk/CUxOp816/XMSxYtDT9C4U9/cOU5KBNcY36937hl1cVYhdQEza6K+JDIGQItTtzNuLPHp+NH85iHfko4kid2Y9xuFfL2wsrjIi5KHrbKd4WeSH9cd/uhBs2QHWkST8In51caEqM3wM8xw+0AMS7mUdIU1y3NFbAlQdAU5XO/2cxCeKzWo90ebKykj3v8LAjC/MzAj2A/g/jiMZbHDRgAC7iUnKHo6Ve5cPaTDK2+Da5N5/jJYN5pgZ1mFgZjgWGEgQgv0zeMLKQG2beraPLVUSBoSsSJZQ+QVVZi84EDd9moUq5aV2MpOvAiS4OC+KcCA1vWhgVpIpGwhNV8Jjgae+YEUDl8Y1eXa6bgWQYkJ7HCti/6KVbgNQymM3uvHQTnUCvhVDumkw0mCuhvRjtH1L3tdZqUg
DKIM-Signature: a=rsa-sha256; bh=nk+40nzDkcPjPHK4QxuEV2jMJGZsMxwitxFHRbcdXcI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760009665; v=1;
 b=u538e7e4M3T0iE1HQRCYYoxP7BeVGCjcnllLosRa5ssUYBrC/LsQav/c6NhCVi1nyG4Zva9a
 l8QPl6xad+lko9X93ZPX3T+DN31yI6VrZGOFFFLg/M5/Z1naAbMvCyJRFpKxPEvrI4JMtGlcZ+M
 PVyu68nSD4IAuh8hoKJ7nzUTI2naFvofIi/y6GRIOc23eeayUfIfvZ98kpWZ2nBcMyQdxbgKU7z
 rNAIhxZ5rtvi1pJQMPeHCUWSqix0XJOLYX3gDA4encws2X2KXC1jcqP/JZ+imQdQIYoMqvfFn40
 PimqYbIAoZBGudqgLYf1RkATIUnOviQqJmdxY6384v1Hg==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
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

Jamin,

On 10/9/25 04:32, Jamin Lin wrote:
> v1:
>    1. Remove AspeedSoCState dependency from aspeed_uart_first, aspeed_uart_last,
>       aspeed_soc_uart_set_chr, aspeed_soc_cpu_type, aspeed_mmio_map,
>       aspeed_mmio_map_unimplemented, aspeed_soc_get_irq, and
>       aspeed_soc_uart_realize APIs.
>    2. Introduce AspeedCoprocessor class and base implementation
> 
> v2:
>    Fix the "make check" failure.


A part from patch 7, the changes look good.


Thanks,

C.



> Jamin Lin (16):
>    hw/arm/aspeed: Remove AspeedSoCState dependency from
>      aspeed_uart_first() API
>    hw/arm/aspeed: Remove AspeedSoCClass dependency from
>      aspeed_uart_last() API
>    hw/arm/aspeed: Remove AspeedSoCState dependency from
>      aspeed_soc_uart_set_chr() API
>    hw/arm/aspeed: Remove AspeedSoCClass dependency from
>      aspeed_soc_cpu_type() API
>    hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_mmio_map()
>      API
>    hw/arm/aspeed: Remove AspeedSoCState dependency from
>      aspeed_mmio_map_unimplemented() API
>    hw/arm/aspeed: Remove AspeedSoCState dependency from
>      aspeed_soc_get_irq() API
>    hw/arm/aspeed: Remove AspeedSoCState dependency from
>      aspeed_soc_uart_realize() API
>    hw/arm/aspeed: Introduce AspeedCoprocessor class and base
>      implementation
>    hw/arm/aspeed_ast27x0-ssp: Make AST27x0 SSP inherit from
>      AspeedCoprocessor instead of AspeedSoC
>    hw/arm/aspeed_ast27x0-tsp: Make AST27x0 TSP inherit from
>      AspeedCoprocessor instead of AspeedSoC
>    hw/arm/aspeed_ast27x0-ssp: Change to use Aspeed27x0CoprocessorState
>    hw/arm/aspeed_ast27x0-tsp: Change to use Aspeed27x0CoprocessorState
>    hw/arm/aspeed_ast27x0-ssp: Rename type to
>      TYPE_ASPEED27X0SSP_COPROCESSOR
>    hw/arm/aspeed_ast27x0-tsp: Rename type to
>      TYPE_ASPEED27X0TSP_COPROCESSOR
>    hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style
> 
>   include/hw/arm/aspeed_coprocessor.h |  62 ++++++++++++++
>   include/hw/arm/aspeed_soc.h         |  51 ++++-------
>   hw/arm/aspeed.c                     |  10 ++-
>   hw/arm/aspeed_ast10x0.c             |  92 ++++++++++++--------
>   hw/arm/aspeed_ast2400.c             |  97 ++++++++++++---------
>   hw/arm/aspeed_ast2600.c             | 126 +++++++++++++++++-----------
>   hw/arm/aspeed_ast27x0-fc.c          |  33 +++++---
>   hw/arm/aspeed_ast27x0-ssp.c         |  73 ++++++++--------
>   hw/arm/aspeed_ast27x0-tsp.c         |  73 ++++++++--------
>   hw/arm/aspeed_ast27x0.c             | 109 +++++++++++++-----------
>   hw/arm/aspeed_coprocessor_common.c  |  49 +++++++++++
>   hw/arm/aspeed_soc_common.c          |  63 +++++++-------
>   hw/arm/fby35.c                      |  10 ++-
>   hw/arm/meson.build                  |   7 +-
>   14 files changed, 524 insertions(+), 331 deletions(-)
>   create mode 100644 include/hw/arm/aspeed_coprocessor.h
>   create mode 100644 hw/arm/aspeed_coprocessor_common.c
> 


