Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F36C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLFB-0002Vf-QP; Fri, 26 Jan 2024 07:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTLF9-0002EX-2D; Fri, 26 Jan 2024 07:23:35 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTLF7-00073c-0U; Fri, 26 Jan 2024 07:23:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLxgN2V1Rz4wx5;
 Fri, 26 Jan 2024 23:23:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLxgL3f8Fz4wd4;
 Fri, 26 Jan 2024 23:23:26 +1100 (AEDT)
Message-ID: <42d89d11-10dc-445b-a9bd-f33e109a863f@kaod.org>
Date: Fri, 26 Jan 2024 13:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20240125055544.79405-1-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240125055544.79405-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/24 06:55, Philippe Mathieu-Daudé wrote:
> Series fully reviewed.
> 
> Since v2:
> - Addressed Gavin & Richard review comments.
> - Collected R-b tags
> 
> Since v1:
> - Follow suggestions from Cédric from [*]
> 
> [*] https://lore.kernel.org/qemu-devel/e13c655b-7904-4e47-a673-4efd13c26b3d@kaod.org/
> 
> Based-on: <20240123222508.13826-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (5):
>    hw/arm/aspeed: Remove dead code
>    hw/arm/aspeed: Set default CPU count using aspeed_soc_num_cpus()
>    hw/arm/aspeed: Init CPU defaults in a common helper
>    hw/arm/aspeed: Introduce aspeed_soc_cpu_type() helper
>    hw/arm/aspeed: Check for CPU types in machine_run_board_init()
> 
>   include/hw/arm/aspeed_soc.h |  4 ++-
>   hw/arm/aspeed.c             | 70 +++++++++++++++----------------------
>   hw/arm/aspeed_ast10x0.c     |  8 +++--
>   hw/arm/aspeed_ast2400.c     | 15 ++++++--
>   hw/arm/aspeed_ast2600.c     |  9 +++--
>   hw/arm/aspeed_soc_common.c  |  8 +++++
>   6 files changed, 65 insertions(+), 49 deletions(-)
> 

Applied to aspeed-next.

Thanks,

C.



