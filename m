Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C45CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIt3J-0008Gs-7g; Tue, 11 Nov 2025 13:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vIt2o-0007tp-Vs; Tue, 11 Nov 2025 13:24:43 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vIt2m-0006ph-67; Tue, 11 Nov 2025 13:24:42 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4d5Zgp482zz5vt3;
 Tue, 11 Nov 2025 18:24:38 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 11 Nov
 2025 19:24:37 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00413aa7bfd-c3cf-4ea1-82f8-75ab93207019,
 FED24A3CA347B2ADB49E2A92EE4521FA9BC47B0E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1ad39032-6b9a-4736-921e-b383d883ace8@kaod.org>
Date: Tue, 11 Nov 2025 19:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/12] docs/system/arm/aspeed: Update Aspeed MiniBMC
 section to include AST1060 PFR processor
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-13-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251106084925.1253704-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 0121ab73-cc4f-4092-8e1f-20efbba2ceaa
X-Ovh-Tracer-Id: 9180024893525166910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGdO+BMgbI+myThn695/kvseagxK/Lljy17LfI4a0AWSuSXgJL1nmgK61cu8VzZCY65ao/vrevwCyBZhbOE549AtMvabT8LIUz97Gg8tCcklWXzM2y45GolYkPOtFBJnCd4gke4dsIV1U8e5Ep+pH0grcM1jhaXRfY6uXYsCHiXl00+bSP3M6GBgyIBPe92x8zbCe0K18RjSvdq69ed6Q36t03F4YwcDmVk11//kn9gf4dHL3KnNx2khduymSsoGDrqPP0sGYPpEDeaF6Aozn+p5fgZZXSGFac7MxuOD3L559CW7b0u/hJhA+zGRxG7k3thpk5aan63/wnNfWpgYTZtSPF8Eyqo6JcBY08h1okJvWMT4PpDFCbczfKXtwD75oCHRkzsRuC4aFHaT2kKf3AkMj4vGM9KbDaqI8mVKKKkUeuPYNi718EwMrEg3FyAGU2LeSNbKuTc40RHv7OSSmzQl9KTBPZTt66xrZ9dFZinFNeww5KicSh37hRDYRrn884vzENmsLyKm9BdzXdeDJSjlKmkyQfIQdDdhTnoFlYW+w1sgMnHHyLoXEIxOKmjdMJZ3sDo3rQdgez3+Cf49k9y5M6zO+5HNfK4fRaDr34mxsjz92/Nh3hfJYlzlJkl+H44AvwTAnta3tsuyKLxM65Odow/JBFtfqQEL+qYDa16Xg
DKIM-Signature: a=rsa-sha256; bh=QsOx7/q31oc5qLI05YWbiITFHkvNvt26hGaWqljXigE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762885478; v=1;
 b=mOV6FrpaOZU00/SLCjSBmeZyHBIZz1MBrGFbce5A3g5FsoN6C+562Qwz5vrEZZTsJZp4eVAL
 ZsI6DgqU9iazhX0lxmaYANM7R5vEyi/lEZq9lVhARu5MJlFkPQxancWIBFoNGeqieliTil2pr/q
 xy2c5yn59AtoxC2zbmCiBK7qGrFRhNp3HVhocXlLbv65gFVVw80ztCezp/O69fYXCDR6Z4i4V8r
 ldU4qMEv3LOtxUoZ9uKEb64lK8df9eFUMLrezTdUMT8yoqsUOSUeowNyS6iZrL0Ru19/7Fq9/Kh
 G//C3PyW2flTNqFd0ZDSWjqJgSRdv7+SuUlggqshYHM2w==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/6/25 09:49, Jamin Lin wrote:
> Added details describing AST1060 as a PFR processor board alongside

Please explain what the TLA 'PFR' means.

> AST1030 MiniBMC, and extended the list of missing devices to include
> SMBus Filter and QSPI Monitor controllers.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   docs/system/arm/aspeed.rst | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index a0c05a6f73..ffa5f4b372 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -448,23 +448,25 @@ Use ``tio`` or another terminal emulator to connect to the consoles:
>      $ tio /dev/pts/57
>   
>   
> -Aspeed minibmc family boards (``ast1030-evb``)
> -==================================================================
> +Aspeed minibmc and PFR processor family boards (``ast1030-evb``, ``ast1060-evb``)
> +=================================================================================
>   
> -The QEMU Aspeed machines model mini BMCs of various Aspeed evaluation
> -boards. They are based on different releases of the
> -Aspeed SoC : the AST1030 integrating an ARM Cortex M4F CPU (200MHz).
> +The QEMU Aspeed machines model mini BMCs and PFR processors of various Aspeed
> +evaluation boards. They are based on different releases of the
> +Aspeed SoC : the AST1030 (MiniBMC) and AST1060 (PFR Processor), both integrating
> +an ARM Cortex M4F CPU (200MHz).
>   
>   The SoC comes with SRAM, SPI, I2C, etc.
>   
> -AST1030 SoC based machines :
> +AST10x0 SoC based machines :
>   
> -- ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)
> +- ``ast1030-evb``          Aspeed AST1030 MiniBMC Evaluation board (Cortex-M4F)
> +- ``ast1060-evb``	   Aspeed AST1060 PFR Processor Evaluation board (Cortex-M4F)
>   
>   Supported devices
>   -----------------
>   
> - * SMP (for the AST1030 Cortex-M4F)
> + * SMP (for the Cortex-M4F)
>    * Interrupt Controller (VIC)
>    * Timer Controller
>    * I2C Controller
> @@ -492,6 +494,8 @@ Missing devices
>    * Virtual UART
>    * eSPI Controller
>    * I3C Controller
> + * SMBus Filter Controller
> + * QSPI Monitor Controller
>   
>   Boot options
>   ------------
> @@ -502,9 +506,11 @@ ASPEED GitHub release repository :
>   
>      https://github.com/AspeedTech-BMC/zephyr/releases
>   
> +   https://github.com/AspeedTech-BMC/aspeed-zephyr-project/releases
> +

Should we keep a reference to both URLs ?

Thanks,

C.


>   To boot a kernel directly from a Zephyr build tree:
>   
>   .. code-block:: bash
>   
>     $ qemu-system-arm -M ast1030-evb -nographic \
> -        -kernel zephyr.elf
> +        -kernel zephyr.bin


