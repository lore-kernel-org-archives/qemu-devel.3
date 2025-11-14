Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D08FCE7B0E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJu1a-0003Dt-Ky; Fri, 14 Nov 2025 08:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJtzX-0002Cq-SI
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:37:33 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJtzW-0008V1-AU
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:37:31 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.74])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d7J934vXnz6PTy;
 Fri, 14 Nov 2025 13:37:27 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 14 Nov
 2025 14:37:26 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00449c239d7-63da-4c4b-8811-616a05ca450d,
 DCBE4845A3BE020BB938A31E73221960BF2A3C2F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0e9fe31b-463c-40f5-bf7e-126fb770caf1@kaod.org>
Date: Fri, 14 Nov 2025 14:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 12/12] docs/system/arm/aspeed: Update Aspeed
 MiniBMC section to include AST1060 processor
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
 <20251112030553.291734-13-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251112030553.291734-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: b4411277-a759-471e-81fc-1d075ba6cab5
X-Ovh-Tracer-Id: 3501267237811751742
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEprUkoDrRFBMpdrT2iZVzvdoaH8whxx6wBS0SX+VFxDWLiJVR6SYWjtHuNU3utcTuNPcuN1skphyN24qlFDnA5jNV0hCYffy8971FpBIRce2cXhvi/OE4eO1xyFfUwuUMvjY5K41zKM5XUPlUJsIhZO4/aw1q87QxJo0wAoIQWt8Ja/Lul8vYJFEyKB26Gcagp/hZWtHewkQJ9adn/ZkofGNYxV2jLV/7yF+QC4CXd2enwVI0ZF5tGeYIx8OjK1EGxS3pRH/4jwmxsz5PxoTH4XCIsdKQFI6VIFxt7aEnUWaJPi/9f4YKSUhBP3BAG1H+O4tXkQ+excfWvJhRfG3LmsOfvCqrRawpd3c6OPy7sCQ1awqEbP11N6NRP/DB7cQL9pDUCxGHI4baZveZrfMJJQqQ5wG+o/1Y6EQ9BZJIu9CASkQ+ZeC0/fDmvCMuHQ+yMISo84VA2hTg/cxOEuc2KJrrJSN+CzCJm4ERp6L7xs17KdrEG0fCbmeL3b11AsL2pIo2XW3MezgJXNopeNHpWiBpl278DXlIzMssu7CTlFQTIwqy1YlgoUQNLHNoxSLIQsfxsgbOxIZVOkaEYegaqTUzPRnlSDE7gA0aIgTxKYU+MedtvzPEym2i/nM1zrlnwBJ62TGuHaxDjkDaLsbs75E9s2mNxv76f67BCADBaQQ
DKIM-Signature: a=rsa-sha256; bh=oyUVWyRK8MdIDsdqLbOqI5nWMG9keEuxVM0TCHoK8o0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763127447; v=1;
 b=NVW/C3JAVbeMvM8yu7Ul2+lTvMDovslHBtJWvpbLgR+EJpd+0+w/++k8IMl5jX1/TLAeu4lt
 4aY6lRMjWvEsfgB97Wmw1PnhDJbYvU4+t0PNDobJrtFXJYmaLa1cf44GID8UbzN0rH5s8dTC/Bv
 SLD9B1M1FplrPHwp5es7jk4S67oeErMprYfYHQYjfWQKHIgVHO2wtFknyrdgHYK6Rg5LsRxmn2z
 fAFpGFxHVYB/2rrI41lfXOtw1/bCr6fED7Elpy3b8mCIsnahYUmuUx8gFI07YNHZogUcRwUzUnD
 lZrWzqMrlBYVT/nH6K/cKTvJGdPlCuHAgEFEmsWaAYN0Q==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/12/25 04:05, Jamin Lin wrote:
> Added details describing AST1060 as a Platform Root of Trust processor board alongside
> AST1030 MiniBMC, and extended the list of missing devices to include
> SMBus Filter and QSPI Monitor controllers.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   docs/system/arm/aspeed.rst | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 81a9699455..4fa1739cb5 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -448,23 +448,24 @@ Use ``tio`` or another terminal emulator to connect to the consoles:
>      $ tio /dev/pts/57
>   
>   
> -Aspeed minibmc family boards (``ast1030-evb``)
> -==================================================================
> +Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1060-evb``)
> +====================================================================================================
>   
> -The QEMU Aspeed machines model mini BMCs of various Aspeed evaluation
> -boards. They are based on different releases of the
> -Aspeed SoC : the AST1030 integrating an ARM Cortex M4F CPU (200MHz).
> +The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
> +evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
> +and AST1060 (Platform Root of Trust Processor), both integrating an ARM Cortex M4F CPU (200MHz).
>   
>   The SoC comes with SRAM, SPI, I2C, etc.
>   
> -AST1030 SoC based machines :
> +AST10x0 SoC based machines :
>   
>   - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)
> +- ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)
>   
>   Supported devices
>   -----------------
>   
> - * SMP (for the AST1030 Cortex-M4F)
> + * SMP (for the Cortex-M4F)
>    * Interrupt Controller (VIC)
>    * Timer Controller
>    * I2C Controller
> @@ -492,6 +493,8 @@ Missing devices
>    * Virtual UART
>    * eSPI Controller
>    * I3C Controller
> + * SMBus Filter Controller
> + * QSPI Monitor Controller
>   
>   Boot options
>   ------------
> @@ -507,4 +510,4 @@ To boot a kernel directly from a Zephyr build tree:
>   .. code-block:: bash
>   
>     $ qemu-system-arm -M ast1030-evb -nographic \
> -        -kernel zephyr.elf
> +        -kernel zephyr.bin



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



