Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEDCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8EsU-0004I0-P9; Mon, 13 Oct 2025 05:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v8EsR-0004AS-8i
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:30:00 -0400
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v8EsL-0005QK-GH
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:29:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.164])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4clXB74Wrgz5wn1;
 Mon, 13 Oct 2025 09:29:51 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 13 Oct
 2025 11:29:50 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006ac9256f5-71b4-4a3e-9d99-69957a8a5c14,
 E27D2F41E47E806E38994DC6761E007B2CBA9264) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8ef83f6c-27c3-4f59-8907-1e04ac630666@kaod.org>
Date: Mon, 13 Oct 2025 11:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 00/16] Introduce AspeedCoprocessor class and
 base implementation
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: dffe85d6-10f4-4056-a895-c6b8fbf81ee0
X-Ovh-Tracer-Id: 14307654542697204658
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEszVcNhUQg8auz4A/3rEGlbCnz21djLPODuz2XcWbj0GQqcv/m/s6gVRynEW3P+wlwpoZ5/TsorQ8anZlx3wEr/Mamp+1zRlm3vZqy8GWOJ2UL5S69vbcOAjKZtaJUJtMHYSw5eeSS7YQF/IM0Mu+82R4IeiPeSMwkPX2Qu+LbS53YsCRkt4dgBhdyr8r9QxbJD0W9b4c6eaQmu2QxXwxBDYsejEZsp91/pewMSosHL0kDLUyP6YuEpUQfVeAYk9qnJiDeBBTKTOY9kLmKEmFVZnoQUuT5AlCjUAGUH92DTjr8dZze2Bc8mzPk4TKVKHVabB2X30VWzWcVKwleaF4gQOhSlP9v6eRPTCxLSKRDv1tzSu38hQCkfzOfJbFWDU9pC6HwO+J3fngC7uy92g7zrfUJzZO7TbOK2oCNSEIJRPSkJk9XAPBann8k55taOTZ7VNzI8z7P7UnKLgJg+dELh0gldQ8a5HCrlRlBy0bJZ9CRLv4J2Hl8KStQ6FS2brFrAKAs3/eQhhMUXz7TjC6PkW93GsdqKib4AF+Ohcg5v+J00eSGsukqBaecdY+wnJ/Jy1u9+Lh5JuIfXmd5hBx31hmF/7kT/4N/2cKuqsBl8N0BwPI20eSa27m4Khx/EKOJv1nwv6dMUvaYWibaRIN/UlTGT0iZuepX55d+S7Q/Bg
DKIM-Signature: a=rsa-sha256; bh=HJR9iv7cEmTDw+UW/5ef1iW9vBaeLmgftEpctCUCfzA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760347791; v=1;
 b=dBTXcj+C92eN2JaLNLxE3vmCRiac/4WHn0bTPPibi1U7ZdIqJA4YCRRgwdOgb3bWCEe+cV0c
 Ii59hAUHFLEGHkNqmfBkIaAhmAqpWG2PqlmM9fGxgKPmNAwaB4S5lsFWDZbCaYwd3LRETSyWYj0
 Q3s4vesWGMJlcQZ7RtLnuTPAdEBFd7+mZUtKzvEv3fNKfx7BQu/otRP/b2cjWs3S9PfQ+t0g6xf
 mjdas456gjP1y9xHlsCiOpDwhUihqJBWBbybbW3A6gt5Ljq0iUxXXnQvM0TqP8HivAC4DyMn0zs
 dOB0MMcqzMyJXgL2bgWSQb8pUogd5vgk0umbzhcxYzTlQ==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/13/25 07:43, Jamin Lin wrote:
> v1:
>    1. Remove AspeedSoCState dependency from aspeed_uart_first, aspeed_uart_last,
>       aspeed_soc_uart_set_chr, aspeed_soc_cpu_type, aspeed_mmio_map,
>       aspeed_mmio_map_unimplemented, aspeed_soc_get_irq, and
>       aspeed_soc_uart_realize APIs.
>    2. Introduce AspeedCoprocessor class and base implementation
> 
> v2:
>    1. Fix the "make check" failure.
> 
> v3:
>    1. Remove the aspeed_soc_get_irq and class get_irq hook
> 
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
>      aspeed_soc_uart_realize() API
>    hw/arm/aspeed: Remove the aspeed_soc_get_irq and class get_irq hook
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
>   include/hw/arm/aspeed_coprocessor.h |  61 ++++++++++++++
>   include/hw/arm/aspeed_soc.h         |  48 +++--------
>   hw/arm/aspeed.c                     |  10 ++-
>   hw/arm/aspeed_ast10x0.c             |  89 ++++++++++++--------
>   hw/arm/aspeed_ast2400.c             |  94 ++++++++++++---------
>   hw/arm/aspeed_ast2600.c             | 121 ++++++++++++++++------------
>   hw/arm/aspeed_ast27x0-fc.c          |  33 +++++---
>   hw/arm/aspeed_ast27x0-ssp.c         |  74 +++++++++--------
>   hw/arm/aspeed_ast27x0-tsp.c         |  74 +++++++++--------
>   hw/arm/aspeed_ast27x0.c             | 107 +++++++++++++-----------
>   hw/arm/aspeed_coprocessor_common.c  |  49 +++++++++++
>   hw/arm/aspeed_soc_common.c          |  63 ++++++---------
>   hw/arm/fby35.c                      |  10 ++-
>   hw/arm/meson.build                  |   7 +-
>   14 files changed, 502 insertions(+), 338 deletions(-)
>   create mode 100644 include/hw/arm/aspeed_coprocessor.h
>   create mode 100644 hw/arm/aspeed_coprocessor_common.c
> 


Applied to aspeed-next.

Thanks,

C.



