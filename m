Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0634ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSo-0006bd-HG; Mon, 12 Oct 2026 13:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGJSF-0005c7-74; Mon, 12 Oct 2026 13:04:53 -0400
Received: from smtpout2.mo538.mail-out.ovh.net ([51.210.91.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGJSB-0007KF-NY; Mon, 12 Oct 2026 13:04:50 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4j3P2y4FT2z5xT3;
 Mon, 12 Oct 2026 17:04:42 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 17:04:41 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.205])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j3P2x6cjNz1xpS; Mon, 12 Oct 2026 17:04:41 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 63B3712E2C8B;
 Mon, 12 Oct 2026 17:04:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002f5c57776-2b31-455d-bde7-6bf166471e4b,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2c11d6ae-a4db-4f23-92e6-75e01031f38b@kaod.org>
Date: Mon, 12 Oct 2026 19:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] hw/arm/aspeed: Use a table for unimplemented
 devices
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Ani Sinha <anisinha@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 1380634761119902771
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEGhpkL2+PrXT1T4Wi342ZuHyuE8gYEf/L/HHKMKtiHNifgGKCkuslj8pEnJ8NlEn7nFh4J3U3Jw7aK3tIXkRDoUepVLecGjGSG50f/cdUuPqndPUnBr4TnTUrgSCSQ4GZ+tKaJgmHkKjKH12UELdpFQFlh1zYl0oicOFtgYDpNZSalhxQlCIWvu1IOK3DlJQM82nOJxOCfgZ87kAYv3R8iUi+0WgqZfo5W3CqtPupRAgk4mBJRJ7NTR1Bt5LoYu8Eqxyqca3VEP97K+pB1x4EbhehjRGIddD7V0obc1HNXo4iJvMnj8R6Jx3SpiFnTEuNpCYuS17prCZJSijOTa3rkjU4bUByyqO3sCCFXML8CszgiEi8Hcfd8e07xT+BkLSGzAa56eev2CWUqqnzAk579X31OFPN2zQjaEJ6rLMGXwc0xj803deAnJBzx2h9kTsfk4nAQx2ykj4KH6Bo89n2dIkku9ClcqnbTV3G+vCLBaOrQKlTfJm1cckM/ob9rh/UoU/6jz5UXVcpnGD7fh+N5EdNQg4ZBFSQB7HwVE28qEilxdBRrgWfs2S+gMwTWChGCRVRzU1D+rlqre+DY+cF/rwRbyktkro1Aj3E3HzZRioKADTVncmhdqXY7jaPaU0CdX26hJeX4BXIXwo7II4faITTfBRQXK2o8TZl6cwJLCQ
DKIM-Signature: a=rsa-sha256; bh=bns71+s5yXgXyok4WX8QC4MvWbaQrmvn+cJpc5GuWz4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791824684; v=1;
 b=PZ98HuJGV7m9B80xvjQTHLnFCwe7jO+QeFLgBsCyXbeXs8kaPM7HBCQwbjuWRkCJQntpuqZY
 C/bjSOcuosMuOl27qLwp00snbNfcp+KlkCHlKS6dEZ+if9KPgaZ0NEfVKLKAu0K7TP3x32/whbG
 bTKpZgiqKh5eOotKORsFZEu2x4jnyRkPxXNbe7mzOZtbTR+QImoB3X9LGCO19zNdTj6fWKHt2Eo
 DaTZtANyQLX/FfxPEf/YjWfN6ayIUL+zkUGtQl6bRcn3zdEdLybAxkz3oefAgX7ZJW5JCfPn3PU
 QVuE+TIUta7a96W1wsUU0czU5q8DXfvmAQTnU6A2cZhnw==
Received-SPF: pass client-ip=51.210.91.31; envelope-from=clg@kaod.org;
 helo=smtpout2.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/12/26 08:44, Jamin Lin wrote:
> v1:
>   1. Use unimp array and table for unimplemented devices
>   2. Sort device IDs alphabetically
> 
> v2:
>   1. Add a common create_unimplemented_devices() helper and
>      UnimplementedDeviceConfig in hw/misc/unimp, as suggested by Philippe.
>   2. Define the unimplemented device table at the SoC class level
>   3. Drop the "unimp" array and the AspeedUnimpDevice table.
>   4. Remove aspeed_mmio_map_unimplemented(), which is not used anymore.
>   
> Jamin Lin (12):
>    hw/misc/unimp: Add create_unimplemented_devices() helper
>    hw/arm/aspeed_ast2400: Use a table for unimplemented devices
>    hw/arm/aspeed_ast2600: Use a table for unimplemented devices
>    hw/arm/aspeed_ast27x0: Use a table for unimplemented devices
>    hw/arm/aspeed_ast10x0: Use a table for unimplemented devices
>    hw/arm/aspeed_ast1040: Use a table for unimplemented devices
>    hw/arm/aspeed: Remove unused unimplemented device fields
>    hw/arm/aspeed_ast27x0: Use a table for unimplemented devices for
>      SSP/TSP
>    hw/arm/aspeed_coprocessor: Remove unused unimplemented device fields
>    hw/arm/aspeed_ast1700: Use a table for unimplemented devices
>    hw/arm/aspeed_ast1700: Remove unused unimplemented device field
>    hw/arm/aspeed: Remove unused aspeed_mmio_map_unimplemented()
> 
>   include/hw/arm/aspeed_ast1700.h     |  2 --
>   include/hw/arm/aspeed_coprocessor.h |  5 +--
>   include/hw/arm/aspeed_soc.h         | 14 +-------
>   include/hw/misc/unimp.h             | 21 +++++++++++
>   hw/arm/aspeed_ast1040.c             | 40 +++++++--------------
>   hw/arm/aspeed_ast10x0.c             | 55 ++++++++---------------------
>   hw/arm/aspeed_ast1700.c             | 21 +++++------
>   hw/arm/aspeed_ast2400.c             | 25 ++++++-------
>   hw/arm/aspeed_ast2600.c             | 44 +++++++----------------
>   hw/arm/aspeed_ast27x0-ssp.c         | 44 +++++++----------------
>   hw/arm/aspeed_ast27x0-tsp.c         | 44 +++++++----------------
>   hw/arm/aspeed_ast27x0.c             | 41 +++++++--------------
>   hw/arm/aspeed_soc_common.c          | 11 ------
>   hw/misc/unimp.c                     | 20 +++++++++++
>   14 files changed, 138 insertions(+), 249 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


