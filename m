Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28939D3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lQf-0000yC-8Z; Mon, 21 Oct 2024 01:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2lQZ-0000lm-DH; Mon, 21 Oct 2024 01:58:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2lQW-0005IF-I5; Mon, 21 Oct 2024 01:58:02 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XX4NL3ksGz4wyh;
 Mon, 21 Oct 2024 16:57:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XX4NH4bvZz4wc1;
 Mon, 21 Oct 2024 16:57:51 +1100 (AEDT)
Message-ID: <09e1241f-2d7b-4762-813b-dd99d5005263@kaod.org>
Date: Mon, 21 Oct 2024 07:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] docs/system/arm: Add placeholder docs for
 mcimx6ul-evk and mcimx7d-sabre
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
 <20241018141332.942844-7-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018141332.942844-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cGEO=RR=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Add placeholder docs for the mcimx6ul-evk and mcimx7d-sabre boards.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS                       | 2 ++
>   docs/system/arm/mcimx6ul-evk.rst  | 5 +++++
>   docs/system/arm/mcimx7d-sabre.rst | 5 +++++
>   docs/system/target-arm.rst        | 2 ++
>   4 files changed, 14 insertions(+)
>   create mode 100644 docs/system/arm/mcimx6ul-evk.rst
>   create mode 100644 docs/system/arm/mcimx7d-sabre.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c3325628c9..2866737261b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -791,6 +791,7 @@ F: hw/arm/fsl-imx6ul.c
>   F: hw/misc/imx6ul_ccm.c
>   F: include/hw/arm/fsl-imx6ul.h
>   F: include/hw/misc/imx6ul_ccm.h
> +F: docs/system/arm/mcimx6ul-evk.rst
>   
>   MCIMX7D SABRE / i.MX7
>   M: Peter Maydell <peter.maydell@linaro.org>
> @@ -804,6 +805,7 @@ F: include/hw/arm/fsl-imx7.h
>   F: include/hw/misc/imx7_*.h
>   F: hw/pci-host/designware.c
>   F: include/hw/pci-host/designware.h
> +F: docs/system/arm/mcimx7d-sabre.rst
>   
>   MPS2 / MPS3
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
> new file mode 100644
> index 00000000000..8871138ab3e
> --- /dev/null
> +++ b/docs/system/arm/mcimx6ul-evk.rst
> @@ -0,0 +1,5 @@
> +NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
> +===================================
> +
> +The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
> +MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
> diff --git a/docs/system/arm/mcimx7d-sabre.rst b/docs/system/arm/mcimx7d-sabre.rst
> new file mode 100644
> index 00000000000..c5d35af1d44
> --- /dev/null
> +++ b/docs/system/arm/mcimx7d-sabre.rst
> @@ -0,0 +1,5 @@
> +NXP MCIMX7D Sabre (``mcimx7d-sabre``)
> +=====================================
> +
> +The ``mcimx7d-sabre`` machine models the NXP SABRE Board MCIMX7SABRE,
> +based an an i.MX7Dual SoC.
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index ace36d1b17d..1f806cf4a46 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -97,6 +97,8 @@ undocumented; you can get a complete list by running
>      arm/nrf
>      arm/nuvoton
>      arm/imx25-pdk
> +   arm/mcimx6ul-evk
> +   arm/mcimx7d-sabre
>      arm/orangepi
>      arm/raspi
>      arm/collie


