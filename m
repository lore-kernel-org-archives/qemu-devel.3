Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=loK4z8kM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOMy-0005OT-7U; Mon, 26 Oct 2026 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLOMs-0005Km-Eo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:20:19 -0400
Received: from smtpout1.mo540.mail-out.ovh.net ([51.210.91.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLOMp-0006hj-IQ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:20:18 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4jD0kN3h1Kz45Gv;
 Mon, 26 Oct 2026 17:20:12 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 26 Oct 2026 17:20:12 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.119])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jD0kN2qjpz1xqY;
 Mon, 26 Oct 2026 17:20:12 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 9B7F919231D6; Mon, 26 Oct 2026 17:20:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003ded8853f-7924-4206-83df-cc8f81ad243c,
 0F1D26DCAC6332081EAAC0C4732524D537662835) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <87e81593-a68c-4f41-9858-0ab37cf6c611@kaod.org>
Date: Mon, 26 Oct 2026 18:20:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] hw/arm/aspeed: Add AST1080 SoC and EVB support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10073426467292556403
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEY9CCrG5m6rnr0jyQ/WX7SWx0LrIc7JRRSWCeg6DBa/VB+IAlu0cuKRmbERATwVec/COZbclo9yi2Y18mmqtJ1KYS4Hgcn9wWfS3phlcKofOGrsgizcEPZGJTFbD/WK4fqqQTpUKk3Kt3hjEVKVOVtHR0GOZVKQlyY1vJq/Xz0kfenqeQxM9gtWNZrr5t2LctTnUst7erj4r6HQ2TQ10vGYxXJiKSNxhjAJNaEXdiLPU9WeRFXi/YTxcN4vUb+4igB5SUK0BPORG5WuRG0EXtCicBFaJelfbYw+HtS7VNDE80UzzR5L9YtenxMan8Ve5awphgZR5sLJCdhVxEo0U4BRob8OtufXohllSqUYNyrM+6L54TSdkPyjM6joAor7aQh7nnsXIzimF9QdwWZzvw5e2lh0lQkqMarWWkJqMMKG40xHReVXl+7fw3OMH91w+1YERs6kkthWDv9Dg24s7veF4zZeZpfWf8ou9tHEYf67DnPUAubtoNqxqTJE3/dh0LXt8kqwjWLKBZQ4HZYLrD502p+IlPaLBmKEte7PXnj1iyKzvY3CzHMxvLdcGlsuFhVcMfDVK8yFUqWYcZhsY4oHdVnA6ef7WJT9wyLKE+mzYhf9TiftVAyeJdRRkmgvtb+Rc5YL9qtxAOfMhndBItNPuhonO5mSZM6Ns8Vo+WOzA
DKIM-Signature: a=rsa-sha256; bh=bHJjdFninLu7jaULjZNghW+rqb7xx2aH977LqZG4LuE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793035212; v=1;
 b=loK4z8kMYomYTegQo6gGnkspge9Qo8DFVSSb+sVKuQRJ8FjF6qV6aHjS6i68sR2xT4r5Amg4
 AD9+VyF6it+s2uKooR7rXRmA3Fwe6h4ePtVpoFsGxPdymoT5EEEpQxA91BcvFqyHcQZJ9ZDPAmU
 mY7ZD+vzEgEqCnjOrwA6Yxz4CuBb1Gdt8y+OnJtCpzhQdSzk3+lhBRj/zvdy8rKoAtyEm371Rly
 oI1eNJwOfiFOk8mvJXnGrjL7k5hku936UB0ASZsJeIvTd4uXJ1++wZ+adOEIXX8h7+9xR73VGQJ
 /Iw8ka+ku2Ec2pauYu3omlgKNV4uF1nioBpviVK2r89HA==
Received-SPF: pass client-ip=51.210.91.50; envelope-from=clg@kaod.org;
 helo=smtpout1.mo540.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/15/26 08:36, Jamin Lin wrote:
> This series adds support for the AST1080 Platform Root of Trust SoC
> and its evaluation board.
> 
> This series depends on:
> 
> [v1,00/14] hw/arm/aspeed: Add AST1040 FMC/SPI controllers and unimplemented devices
> https://patchwork.kernel.org/project/qemu-devel/cover/20261015055642.106204-1-jamin_lin@aspeedtech.com/
> 
> and is based on the aspeed-next branch:
> https://github.com/legoater/qemu/commits/aspeed-next
> 
> The AST1080 shares most of its design with the AST1040, so the AST1040
> init and realize code is first split into common functions. The
> AST1080 SoC is then added with its own unimplemented devices (QSPI
> filters and I2C filter).
> 
> v1
>   1. Add common init function for AST1040/AST1080 SoCs
>   2. Add common realize function for AST1040/AST1080 SoCs
>   3. Add AST1080 SOC and EVB machine
>   4. Add AST1080 functional test.
>   
> Jamin Lin (9):
>    hw/arm/aspeed_ast1040: Add common init function for AST1040/AST1080
>      SoCs
>    hw/arm/aspeed_ast1040: Add common realize function for AST1040/AST1080
>      SoCs
>    hw/misc/aspeed_scu: Add AST1080 A0 silicon revision definition
>    hw/arm/aspeed_ast1040: Add AST1080 SoC support
>    hw/arm/aspeed_ast1040: Add AST1080 QSPI filters as unimplemented
>      device
>    hw/arm/aspeed_ast1040: Add AST1080 I2C filter as an unimplemented
>      device
>    hw/arm/aspeed_ast1040_evb: Add AST1080 EVB machine support
>    tests/functional/arm/aspeed: Add AST1080 test with ASPEED MCU FW Hub
>      v01.00
>    docs/system/arm/aspeed: Add AST1080 Platform Root of Trust evaluation
>      board
> 
>   docs/system/arm/aspeed.rst                  |   8 +-
>   include/hw/misc/aspeed_scu.h                |   1 +
>   hw/arm/aspeed_ast1040.c                     | 154 +++++++++++++++-----
>   hw/arm/aspeed_ast1040_evb.c                 |  23 +++
>   hw/misc/aspeed_scu.c                        |   1 +
>   tests/functional/arm/meson.build            |   1 +
>   tests/functional/arm/test_aspeed_ast1080.py |  37 +++++
>   7 files changed, 186 insertions(+), 39 deletions(-)
>   create mode 100644 tests/functional/arm/test_aspeed_ast1080.py
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


