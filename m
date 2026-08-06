Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D231C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrxaz-0004u5-Gu; Thu, 06 Aug 2026 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wrxaw-0004rU-KR; Thu, 06 Aug 2026 08:53:10 -0400
Received: from smtpout10.mo537.mail-out.ovh.net ([51.210.91.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wrxat-0000GI-2S; Thu, 06 Aug 2026 08:53:09 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hG6dK4nYcz48yZ;
 Thu,  6 Aug 2026 12:52:53 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  6 Aug 2026 12:52:52 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.132])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hG6dJ6tR9z5vVs; Thu,  6 Aug 2026 12:52:52 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 7F5D01B43EBC;
 Thu,  6 Aug 2026 12:52:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001e485874b-9cc9-4049-9650-a620fd9b5b3c,
 3674F41004D9368A494C832AF9EEF1C5F00DB56D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <302c4858-c8dc-4b4f-98a5-a21c8f166c73@kaod.org>
Date: Thu, 6 Aug 2026 14:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] tests/functional/arm/test_aspeed: Update ASPEED
 SDK v11.03
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9485706717482953739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFM/6gzvPct4OmylkIazcgkANzz6fz6XLjZbW7ceCpdIoGKzbFfJWMIilMX1S0s+BAfYakdWkGVkzI2+OpmFnebptKCmDCM03qzhz/T+4T1HdoBRdho+oYA+xfzf+upmt0j4dUfwmBHidWu6y2XlzqUzBgDfGVxvy+bwvG3A3UCyIARIOMAne3dW7ueVvA70wt+xzG9cocXU/5P4DOQL5debdR5FqZ5ChQryRKLqeKUMa12AAB14f/dhd3GR+FZh2WsyYREeqRB4mu8wffPnE5fmcTI4/dcV8SkH5lAwiQolIG32i2Odgrt4aj5FPPOcdTgAWYI1NX2JKAiMp6hJrvbTc3+ui8+FSrPKd+2uEWhGFqLzq1io7nDgHPkXQUvRSdwb4M2a5Xe7yqD/EXoFbyylv5owPGRAA9IIfocWMZTMoI+ULzVUKX67tg/B77OkB5p1AQJt9Tbf71YSHK2cqTBoaq7wvLUNf7KmtWihrmaEkgeV2W+BUF7weDXdyLM29vRWA3pf8avC8DC2FYinbij7Nm8WMG+9l9Wpzly9uqGvV/XZJ0miAWn4IIxYRnHqzRDZRzQ1sPaKC6HMnRYan8McXAc4an3brQGBNt/YWGTDAlZhIA348pxGCCxt5z253lqF6yN1Dtkd3xbTFlW9yajBYLQ4BYorPvipgGPaIC/HA
DKIM-Signature: a=rsa-sha256; bh=gEZ2xxeIHjrEXdJIUwRYEYiIHxEVPQeitqPFvjYBNtw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1786020775; v=1;
 b=lzmjz/38GQYXqPLCAQjipJYlIIhWD2c0qXZDQHDg2EV+5+Q35mm2Gbetsvos0B5C1uRtDxKS
 1TNnzOEAvTi4K/JMcXXLRUjJuV8fquwUtIwMVBH0usio+E3xU9FaGjd0C6P+TkiFF9qr9EMmDz7
 IBMUw53GoE6puaK5Jf3hw/e3qCNRAITomrjDlkfeg+hTvL+TaopMEX3W3XxdCBOu4d2eGcTC6wA
 XofoWpheUBc2TVVMT1VXBbBheCFy81G9QN6x6jt0dOaRSkk8CNH2FmyqVJOY5MH9cPYTN6Kq03y
 c5xQO8lQPDPD3ceiE3puZfY9IE6nsf7yYP0H8f+7oPF5w==
Received-SPF: pass client-ip=51.210.91.29; envelope-from=clg@kaod.org;
 helo=smtpout10.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/4/26 10:19, Jamin Lin wrote:
> v1:
>    1. Update ASPEED SDK v11.03 to AST2500/AST2600/AST2700.
>    2. Update ASPEED Zephyr SDK v03.08 to AST1030.
>    3. Update ASPEED Zephyr Project v03.07 to AST1060.
>    4. Support the I2C master buffer mode to AST2700.
> 
> Jamin Lin (8):
>    hw/i2c/aspeed_i2c: Support the AST2700 master buffer mode
>    tests/functional/aarch64/test_aspeed_ast2700a2: Update ASPEED SDK
>      v11.03
>    tests/functional/aarch64/test_aspeed_ast2700a1: Update ASPEED SDK
>      v11.03
>    tests/functional/aarch64/test_aspeed_ast2700fc: Update ASPEED SDK
>      v11.03
>    tests/functional/arm/test_aspeed_ast2600_sdk: Update ASPEED SDK v11.03
>    tests/functional/arm/test_aspeed_ast2500_sdk: Update ASPEED SDK v11.03
>    tests/functional/arm/test_aspeed_ast1030: Update ASPEED Zephyr SDK
>      v03.08
>    tests/functional/arm/test_aspeed_ast1060: Update ASPEED ZEPHYR PROJECT
>      v03.07
> 
>   include/hw/i2c/aspeed_i2c.h                   |  2 +
>   hw/i2c/aspeed_i2c.c                           | 79 +++++++++++++++++++
>   .../aarch64/test_aspeed_ast2700a1.py          | 27 ++++---
>   .../aarch64/test_aspeed_ast2700a2.py          | 27 ++++---
>   .../aarch64/test_aspeed_ast2700fc.py          | 21 ++---
>   tests/functional/arm/test_aspeed_ast1030.py   | 12 +--
>   tests/functional/arm/test_aspeed_ast1060.py   | 14 ++--
>   .../functional/arm/test_aspeed_ast2500_sdk.py |  8 +-
>   .../arm/test_aspeed_ast2500_sdk_515.py        |  8 +-
>   .../functional/arm/test_aspeed_ast2600_sdk.py |  8 +-
>   .../arm/test_aspeed_ast2600_sdk_515.py        |  8 +-
>   .../arm/test_aspeed_ast2600_sdk_otp.py        |  8 +-
>   12 files changed, 153 insertions(+), 69 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



