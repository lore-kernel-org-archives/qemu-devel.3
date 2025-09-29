Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C807CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 05:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v36dr-00055m-ND; Mon, 29 Sep 2025 01:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v36dq-00055V-Dv
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 01:41:42 -0400
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v36df-0008V0-F1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 01:41:42 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.1])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cZqmq03F0z6Mt6;
 Mon, 29 Sep 2025 05:41:14 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 29 Sep
 2025 07:41:13 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00529ba7d3e-903a-45a0-95eb-b90fb64884e1,
 C0B7F939972EFBFB8B135CC8703FF5F6CF89E47D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ebe8c9c3-0e94-4ed0-a231-4d93306fb779@kaod.org>
Date: Mon, 29 Sep 2025 07:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Support VBOOTROM to ast2700fc machine
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 86feff9a-7028-4b3c-96d8-88017d6c4945
X-Ovh-Tracer-Id: 2015923786936978223
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFWyVH2V4mfc4aDPxbZ9UJrhypCK4hERc4T0EY52wk90J1OwS6ntWUNYU/U44ROqGCyUuNDyatPCeSedbMCYqSDv5TLzH94OzrRNHzc6D+/vE0p7BCmUAK1bWoqe4gFqSzyLumXGa+4SgQEDup9+SrXBtxZJhrsPAphPE8+1ESixsStRDe51dA7q6g6gJh0pNqxmbSwhH84R6qLXQf9uu9kSyiu9l9ytVhPi4tX9bXTqv+kXVmUTDCT7vIBHdnb7mzQdVmpGJURgnybNVvE8FO7FXdJz0Tp3bhfceuUXH9W/mF4yyLK1RgIeIvpBELCoi8EBNaueWhqSTRAd521cqS2pjt9yU0As1BPXmF8V9m6Fp1ZV5ZpUDI8AJR5M30Tj1p5gFSv+sT6zZSTTpqWt82epuJ0ntFz+AvbzkUOze6HkfEFW81lw3s3J9c8DIvTgmqOe4FXx6rqJ/6XorMQNq3LvEjxuxxzDeZWH2MnJn9w1lEiz1JfYsUlVmaH8hzDK7eLNQo5TH6Zh2L/poT7qfxyO7jwgNJwDiLmVUD+fEFZCUWiiuCLw4lFZGlB5KpK3r5aweDvhQutKWz200geQUSbcKAGXj5rIAB0jAyz97r0OFJupE6//EQ23UQXonVDusC5lOCmRWwAMXOsxv/00ACXPx/2tZ7HHLpjrUGOugDfig
DKIM-Signature: a=rsa-sha256; bh=8OYxozQg+Nkxcm35BtV4SokJTRznc6l6hsCF9NSwwKA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759124476; v=1;
 b=HUVfWvhvNwpDtpdbFXpPy4sTgj1LYTssTqTtLkPYYGUNaNUXRauDmq0wRkfOc5BdsTFvoUTf
 puwWOObdXR2z0OG8Hbk5mvgo1fTwzDH5MBYtrtA0EmB2MCI5gaL12d3iUXFAd2qByBA9R7/K2PY
 ohAe7VQTrDHR8C8yT0WlFg+cuNHOR+FyXpkuNLyMOGewNXPshDLHC1XEe12SRNYtZZHGTCa7Oe+
 DWLivXQiNE++JEdieG+bpFWAwdpbu8QjSE1NMPGBASPbSfusSx8E2ZBYgVEseeOAWQMt6XhihVy
 mIm23R9ayt2kGxNg/iumgO+upHtAaLKmsD3VL8mpQ4G4Q==
Received-SPF: pass client-ip=188.165.58.48; envelope-from=clg@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001 autolearn=ham autolearn_force=no
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

Jamin

On 9/25/25 07:05, Jamin Lin wrote:
> v1
>   1. Added support for Vboot ROM.
>   2. Moved coprocessor initialization from machine level to SoC level
>   3. Unified SCU controllers between PSP and coprocessors
>   4. Shared the same SRAM between PSP and coprocessors
>   5. Support PSP DRAM remaps coprocessor SDRAM
>   6. Added support for controlling coprocessor reset via SCU registers.
> 
> v2
> Split the original patch set into smaller sub-patches for review.
>   This patch focuses on:
>    1. Adding support for Vboot ROM.
>    2. Moving common APIs to SoC-level code for reuse in different
>       platforms and reducing duplication.
> 
> v3
>    1. Drop dead return checks.
>    2. Make sub-init functions return bool with errp.
> 
> Dependencies
> 
> Based on https://github.com/legoater/qemu at the aspeed-next branch.
> 
> Jamin Lin (8):
>    hw/arm/aspeed: Move aspeed_board_init_flashes() to common SoC code
>    hw/arm/aspeed: Move write_boot_rom to common SoC code
>    hw/arm/aspeed: Move aspeed_install_boot_rom to common SoC code
>    hw/arm/aspeed: Move aspeed_load_vbootrom to common SoC code
>    hw/arm/aspeed_ast27x0-fc: Drop dead return checks
>    hw/arm/aspeed_ast27x0-fc: Make sub-init functions return bool with
>      errp
>    hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents into CA35 boot ROM
>    hw/arm/aspeed_ast27x0-fc: Add VBOOTROM support
> 
>   include/hw/arm/aspeed_soc.h |   8 +++
>   hw/arm/aspeed.c             | 105 ++----------------------------------
>   hw/arm/aspeed_ast27x0-fc.c  |  96 +++++++++++++++++----------------
>   hw/arm/aspeed_soc_common.c  |  96 +++++++++++++++++++++++++++++++++
>   4 files changed, 159 insertions(+), 146 deletions(-)
> 

Applied 1-6 to aspeed-next. Waiting for a commit log update of patch 7.

Also, why isn't there a vbootrom functional test for ast2700fc machine ?

Thanks,

C.



