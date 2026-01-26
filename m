Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB3C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkITs-0005A4-E0; Mon, 26 Jan 2026 04:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vkITq-00059S-RD
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:01:54 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vkITp-00026f-53
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:01:54 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.99])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f02bJ6HPlz5vxJ;
 Mon, 26 Jan 2026 09:01:48 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 26 Jan
 2026 10:01:48 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002be5c6730-d48b-4ed9-a3f7-4b3630df8515,
 329AED9B4B2025A2B6FD845E756CD38D93ED9099) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
Date: Mon, 26 Jan 2026 10:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: ed68ead4-5cfa-407e-9103-648a103153cd
X-Ovh-Tracer-Id: 3277494629975952306
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEghy68Y7UW6crngxomV7a5R31xWN0Qx+2EkzR/SZPPIWRyMWkLLrQyhcKsUBdu44Y5sAAmWfJ0EP+l5k9+7aMF8s0Jzdl8wRsWqhqIL92ImT594oMtSsUYOg/SuB2u2znMONgv8ekSWXLzR/Ux1pbkNVIODPJP6l9XlrALIyrc6BpdsgYUBV5tE08o2Ojkblr1PCAKRzHnYO8HOl+jkRvRFSJ+C4Yiy2M8lXjDoSyQZ7Oxb51GVWObPebc0AmVRRuZa/0JATfX0C+G5jFcytaJaZ+u6IFFKtMCi83AHjWfQx6pZxHiw/n11ElH/nTuZHDC91KTfMAO/9/b2VjH3vKIBV0fTnGF8nboD7SPs+dgoAJFK/F19syW2l1CcdB32tiT+nXY3SCFqKyTuJG1sDsEQ7S5TY+l6IytN9/r2NA0eoM0RdUeLNtTzsNzu+6TYpNi+Bmp/56oVtkf19SZqyeyU5nQk8vgYPbuO8e/ZgZrU23/3MQCGTro4mJgn/kb6qKmhayfFVHvzjD05LkFX219RR/duiTX6lXmEqyLK75Ja2szqFBGJifNEyWQy7QJfqKVpNu3avF7eXj27W+5R61eRbV7us6Wb2YU7s9yGFCM0CQMZLobH2l4TNCaijh+YEDdnOSRegEv+pc+ls/mwO8rLNTxVplCoQ2LngVWVrc9sw
DKIM-Signature: a=rsa-sha256; bh=zve9uKHY4vopNRZ0fAauE+5fSY5s/99aaqD1vAXJX/M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769418109; v=1;
 b=Kp9jpDrovmqjEZHgsJpcF1V42PCyFcVgddUqjsl+PAYj5M6G8kKDkR4Ly5LmCP5y3dpM5/tb
 5HgMJaKJFkYCr/S2oR7Oh+3SzuEdmiMzKqQRMXbsoDf/z8Y5Qfl4f7z7xtyr8DXzh/qpFDisV0w
 hu7RCNQgpxs1iC9lFrkK+++VMyheabfRfybBAAu9J5svWRILlCeBHplOdYERVqdlxjzKYm63p7t
 ObVlhNMtLN8Ku15P8ZBDpUD6Qd6jga/2a+mL5/v/sKak3qd9UyxgRmqQ5O5GZudlMfLgUQvAAQy
 7YnpV+WUu8qTEem3vEEYuUbcrIIh1DaAU7TXpd9RGtFZQ==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
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

On 1/20/26 10:29, Jamin Lin via qemu development wrote:
> This commit adds two MemoryRegion aliases to support PSP access to
> SSP SDRAM through shared memory remapping, as defined by the default SCU
> configuration.
> 
> The SSP exposes two DRAM aliases:
>    - remap1 maps PSP DRAM at 0x400000000 (32MB) to SSP SDRAM offset 0x2000000
>    - remap2 maps PSP DRAM at 0x42c000000 (32MB) to SSP SDRAM offset 0x0
> 
> These regions correspond to the default SCU register values, which control
> the mapping between PSP and coprocessor memory windows.
> 
> Set SSP CPUID 4 and bumps the SCU VMState version to 3.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_scu.h |  5 +++++
>   hw/arm/aspeed_ast27x0-fc.c   |  2 ++
>   hw/arm/aspeed_ast27x0-ssp.c  |  6 ++++++
>   hw/arm/aspeed_ast27x0.c      |  4 ++++
>   hw/misc/aspeed_scu.c         | 38 ++++++++++++++++++++++++++++++++++--
>   5 files changed, 53 insertions(+), 2 deletions(-)
make check fails with :

   Unexpected error in aspeed_scu_realize() at ../hw/misc/aspeed_scu.c:609:
   qemu-system-aarch64: aspeed.scu: 'dram' link not set

Thanks,

C.

