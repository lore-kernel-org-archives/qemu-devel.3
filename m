Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC21AD3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lQZ-0000kg-4Z; Mon, 21 Oct 2024 01:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2lQD-0000Xx-0p; Mon, 21 Oct 2024 01:57:43 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2lQA-0005FP-5D; Mon, 21 Oct 2024 01:57:39 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XX4My4dCTz4wbr;
 Mon, 21 Oct 2024 16:57:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XX4Mv4wYNz4wc1;
 Mon, 21 Oct 2024 16:57:31 +1100 (AEDT)
Message-ID: <92da9c35-5e2d-4a50-90bd-79633dbb3af6@kaod.org>
Date: Mon, 21 Oct 2024 07:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] docs/system/arm: Add placeholder doc for exynos4
 boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
 <20241018141332.942844-5-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018141332.942844-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=cGEO=RR=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/18/24 16:13, Peter Maydell wrote:
> Add a placeholder doc for the exynos4 boards nuri and smdkc210.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS                | 1 +
>   docs/system/arm/exynos.rst | 9 +++++++++
>   docs/system/target-arm.rst | 1 +
>   3 files changed, 11 insertions(+)
>   create mode 100644 docs/system/arm/exynos.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dff8073c5bc..031b117a3a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -716,6 +716,7 @@ L: qemu-arm@nongnu.org
>   S: Odd Fixes
>   F: hw/*/exynos*
>   F: include/hw/*/exynos*
> +F: docs/system/arm/exynos.rst
>   
>   Calxeda Highbank
>   M: Rob Herring <robh@kernel.org>
> diff --git a/docs/system/arm/exynos.rst b/docs/system/arm/exynos.rst
> new file mode 100644
> index 00000000000..86894bc02b7
> --- /dev/null
> +++ b/docs/system/arm/exynos.rst
> @@ -0,0 +1,9 @@
> +Exynos4 boards (``nuri``, ``smdkc210``)
> +=======================================
> +
> +These are machines which use the Samsung Exynos4210 SoC, which has Cortex-A9 CPUs.
> +
> +``nuri`` models the Samsung NURI board.
> +
> +``smdkc210`` models the Samsung SMDKC210 board.
> +
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 9c01e66ffa9..a7f88c8f317 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -90,6 +90,7 @@ undocumented; you can get a complete list by running
>      arm/digic
>      arm/cubieboard
>      arm/emcraft-sf2
> +   arm/exynos
>      arm/fby35
>      arm/musicpal
>      arm/kzm


