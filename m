Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF84CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBsqA-0003D6-Bt; Wed, 30 Sep 2026 07:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xBsq1-0003C1-Ad
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:51:06 -0400
Received: from smtpout5.mo538.mail-out.ovh.net ([51.210.91.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xBspz-0006Xh-0s
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:51:05 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hvtfV6SJWz6FHN;
 Wed, 30 Sep 2026 11:50:58 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 30 Sep 2026 11:50:58 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.181])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hvtfV1gNCz6MYj; Wed, 30 Sep 2026 11:50:58 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 CE6ED2402C14; Wed, 30 Sep 2026 11:50:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004d9bbd85d-d0f0-4634-ab3d-d1531c030f3d,
 845F429D393748294ED5D50D12AC6EB9B2213B76) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4db6a945-eabf-43c3-9525-698eaf1fa638@kaod.org>
Date: Wed, 30 Sep 2026 13:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] hw/arm/aspeed: Use unimp array and table for
 unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17843824674993974283
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGwH0hfXj7SpnqDE+HPItNCRDLZ54cy1hX/mqcEWGKf2nSkwJh2koLU+g2CRzJL91M6SOdjrGqbt2Uuyc98K1uGg3L0sgoM1h9QLI7rfsB3B636lA1vpsj2FSF9tQu4kDJQl9P5LoETeeX5DYlktZdINVTV65CbgdLaEnevAw7QW69hNBM4yyEMNj25C9f/CR2EilLXWb0VFdqqS6PEx1gb3qnLNMy/HX7CC4ZRRjeW/jbofwiElSYaDY0eTJTYnF/tusf1DSUsWUA1MUzhOhGeJf0c+4iToCpPWPjk9fO9Wgv+Ni1uFYjPuRvAWjxIkvrMsmOGu4yEp3tvv/uHHxf3q0+p8P+uXqowSK2AG6IrQx6tAiqvE7FT2cO3D2vn3FPakp/PJwU1y6xb5/jVWLGx0hINScSQ1a8s4oyTp8PThBH3lOTKPxNvg6wsniJgov5T164mMazfqq21hHfEK5NvqVCV4Txaw4Exz1+dXgX57HRyMgYcgA4AYs6JiqM9XbyLnzIZppbW9qwEzVQrvzIIKA/eVPNfYtVnp7HEiBDaQlOr9l5NdhHPMOUw60pg+xFBqFxnTDi0JRzgVkYJTooaQhRtAQHDzDxHaFrEjri0qlwJdPOHA+ppiGtL2wM7OxmLWRs3C+6mXymYNA9g93JxpAPWRlr7lk8jqFyNO8ioFA
DKIM-Signature: a=rsa-sha256; bh=9PjkOAvELwTljUa9P2dswAE1hmvR57HrCxmaoqvtiCY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1790769060; v=1;
 b=kA2w69VHb6xAO9ExABP+2LrELXli0M8CN2XTwH94rxIeRMBtZK1dDskj/GEbRxi/evG3Slhj
 1TsdlDPQ0vlrmf+P+DqJ8bxQc0nJt0raRrpi1t+UcT5IOUdr9bbGc87EnZ4tZLxB1JIGuhWazI0
 RjcJKB/L14ymmE6C+NKhc+ZOFnokpEEowl1QNTHefoNhIqSkBTPTdnuB0BTnVYMj8rXLOAOUz32
 WWHBYPQEiH5G70qLeWdepwN+sRMR0yNHzMpDMkoyBAMLcJKNNvTSLpWWBpusAFnM5A9k+ISI9NR
 IvEHgeG4xOQa5z6NY3CwRLqns+VBYK7vDcwm7eDaCLygw==
Received-SPF: pass client-ip=51.210.91.34; envelope-from=clg@kaod.org;
 helo=smtpout5.mo538.mail-out.ovh.net
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

On 9/30/26 09:25, Jamin Lin wrote:
> v1:
>   1. Use unimp array and table for unimplemented devices
>   2. Sort device IDs alphabetically
> 
> Jamin Lin (11):
>    hw/arm/aspeed_ast2400: Use unimp array and table for unimplemented
>      devices
>    hw/arm/aspeed_ast2600: Use unimp array and table for unimplemented
>      devices
>    hw/arm/aspeed_ast27x0: Use unimp array and table for unimplemented
>      devices
>    hw/arm/aspeed_ast10x0: Use unimp array and table for unimplemented
>      devices
>    hw/arm/aspeed_ast1040: Use unimp array and table for unimplemented
>      devices
>    hw/arm/aspeed: Remove unused unimplemented device fields
>    hw/arm/aspeed_ast27x0: Use unimp array and table for unimplemented
>      devices for SSP/TSP
>    hw/arm/aspeed_coprocessor: Remove unused unimplemented device fields
>    hw/arm/aspeed_ast1700: Use unimp array and table for unimplemented
>      devices
>    hw/arm/aspeed_ast1700: Remove unused unimplemented device field
>    hw/arm/aspeed: Sort device IDs alphabetically
> 
>   include/hw/arm/aspeed_ast1700.h     |   3 +-
>   include/hw/arm/aspeed_coprocessor.h |   5 +-
>   include/hw/arm/aspeed_soc.h         | 195 ++++++++++++++--------------
>   hw/arm/aspeed_ast1040.c             |  49 ++++---
>   hw/arm/aspeed_ast10x0.c             |  64 ++++-----
>   hw/arm/aspeed_ast1700.c             |  42 +++---
>   hw/arm/aspeed_ast2400.c             |  33 +++--
>   hw/arm/aspeed_ast2600.c             |  53 ++++----
>   hw/arm/aspeed_ast27x0-ssp.c         |  56 ++++----
>   hw/arm/aspeed_ast27x0-tsp.c         |  56 ++++----
>   hw/arm/aspeed_ast27x0.c             |  49 +++----
>   11 files changed, 287 insertions(+), 318 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


