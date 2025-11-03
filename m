Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C87BCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrjN-0002Vg-RK; Mon, 03 Nov 2025 05:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vFrjM-0002Uv-14
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:24:08 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vFrjC-0004qf-Po
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:24:07 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.200])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d0SNX1Z3yz5yWV;
 Mon,  3 Nov 2025 10:23:40 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 3 Nov
 2025 11:23:32 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00427b1af67-b505-4d5d-b2eb-aae241c819b8,
 25720A756895FCE40C516A1A344E2045610AA209) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <731294a8-bc5d-4cc8-be7e-1354db393d0f@kaod.org>
Date: Mon, 3 Nov 2025 11:23:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 00/30] Split AST2400, AST2500, AST2600, AST2700
 and AST1030 SoC machines into separate source files for
 maintainability
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
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
In-Reply-To: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 0887c1e7-29ee-4466-9719-96db6e4ce9a0
X-Ovh-Tracer-Id: 9413649123107048370
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFvpwnceXi7Yqzde+wV6tn1rSwEKtTLA1KqbCwdt/cI/Pmln4krUiknid69lWcEhQPPiF0z6igGXQ5lCbEc/yVPgvgGekU/U0xEP2+H78wJA42lY46auhbrA+B47lrGoMavMRLBR511Y12kA8MBZ3A39Zj3jixU3nReS28wAAPCotARCAWHVKJ1D0c/7sesUj75Gvvb1UPB0u02aoX+TbVDh9SASu7XMYBJWJ+MF69HQa2/z1dHbgb5AJOgMe+2pQ7T7RJg1cQYJCcWF+3pNfHWfF9p7L+H7o0nv0OWThRkqscMbBmn+tHmCSk+vMsKrOQP/ToBy6f3M79fap0TO/AsZPPHiAlk8e0q/NIsM7BQc37jZNQ6UEBi2W2QsavrDdm60RHXd402IIxzqa4MiyuHVxbJHtKylTeUjsLGFHibgfuIY+Cg18XTA+JTCYMMC7A5qU/09Hc2MEwuAr2W2ND9cJsvJM2gSCCFw3hnEhkn2keN9M7k5zTRgi3Wc8UhvskY4oN5a8e+XGMaSiOXki3wf7QtWnX71i1ytGuWiqP4rJbZ6TELv3yWC87tV76/M7z3+PWGpPL/zqoSvy7RCgKG6FWkQpfbbaKglW4t0ruFFijAG42uB//euazQh9TFgvHmILh1AnjrQtiBsvFuFiRAzRj2DmL74aeq22+WyKTVwg
DKIM-Signature: a=rsa-sha256; bh=QeHy4dvNNdGbrns+bPGIxkG7a35UtO8EIhnMwZq9Kg4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762165430; v=1;
 b=aRzFYxPqYjnUHOapftQiFLWBnxj0buC/3KF0XS2Tr6KoIAolF6aPhjIJqf4DqF2j+1Z7JjcM
 FnNI8QRqxmenEsPA/PfvQUjzVfyiRfbG+rfYBl3BC8HpQSfAaJxOL0B2O8qIwEhmtcOwvC0amop
 k2zWHO6/RCFTsdjJwal7m5/1m9t60iN6rJgtZJax5uK7DNwtux7IESMIxoqx08BJi87jlZBL2DR
 rBu5A1IqCCVHa/tDm7FEofvB2aP8IHhWPfd4O4wjU0fPrcTQOTgsbQa6wWeHQCQvk4856Rr9TNz
 nex8QZKI61LJWnVraeiFXQHbpYIPHZt4ypIZgrVg0bSwg==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jamin,

On 11/3/25 10:27, Jamin Lin wrote:
> v1:
>   1. Split each Aspeed machine into its own source file for better
>      readability and maintainability:
>      - Quanta-Q71L
>      - Supermicro X11
>      - Palmetto
>      - Bletchley
>      - fby35 BMC
>      - Facebook Fuji
>      - QCOM Firework
>      - QCOM DC-SCM V1
>      - GB200NVL
>      - Rainier
>      - Catalina
>      - AST2600 EVB
>      - AST2700 EVB
>      - AST1030 EVB
>   2. Make aspeed_machine_ast2600_class_emmc_init() a shared API
>      for eMMC boot setup.
>   3. Promote connect_serial_hds_to_uarts() to a public machine API
>      for reuse across platforms.
> 
> v2:
>   1. Restore ASPEED_RAM_SIZE() macro
> 
> v3:
>    1. Merged AST2500 SoC machine changes into this patch series.
>     Split each AST2500 machine into its own source file:
>     - FP5280G2
>     - G220A
>     - Tiogapass
>     - YosemiteV2
>     - Witherspoon
>     - Sonorapass
>     - Romulus
>     - Supermicro X11SPI
>     - AST2500 EVB
>    2. Renamed common API functions with the aspeed_ prefix for consistency.
>    3. Added detailed descriptions for the common API functions.
> 
> Jamin Lin (30):
>    hw/arm/aspeed: Move AspeedMachineState definition to common header for
>      reuse
>    hw/arm/aspeed: Make aspeed_machine_class_init_cpus_defaults() globally
>      accessible
>    hw/arm/aspeed: Export and rename create_pca9552() for reuse
>    hw/arm/aspeed: Rename and export create_pca9554() as
>      aspeed_create_pca9554()
>    hw/arm/aspeed: Split FP5280G2 machine into a separate source file for
>      maintenance
>    hw/arm/aspeed: Split G220A machine into a separate source file for
>      better maintenance
>    hw/arm/aspeed: Split Tiogapass machine into a separate source file for
>      cleanup
>    hw/arm/aspeed: Split YosemiteV2 machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Witherspoon machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Sonorapass machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Romulus machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Supermicro X11SPI machine into a separate file
>      for maintainability
>    hw/arm/aspeed: Split AST2500 EVB machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Quanta-Q71L machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Supermicro X11 machine into a separate source
>      file for maintainability
>    hw/arm/aspeed: Split Palmetto machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Move ASPEED_RAM_SIZE() macro to common header for reuse
>    hw/arm/aspeed: Split Bletchley machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split FBY35 BMC machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Fuji machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split QCOM Firework machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split QCOM DC-SCM V1 machine into a separate source
>      file for maintainability
>    hw/arm/aspeed: Make aspeed_machine_ast2600_class_emmc_init() a common
>      API for eMMC boot setup
>    hw/arm/aspeed: Split GB200NVL machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Rainier machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Catalina machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split AST2600 EVB machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split AST2700 EVB machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Rename and export connect_serial_hds_to_uarts() as
>      aspeed_connect_serial_hds_to_uarts()
>    hw/arm/aspeed: Split AST1030 EVB machine into a separate source file
>      for maintainability
> 
>   hw/arm/aspeed_eeprom.h                    |   32 -
>   include/hw/arm/aspeed.h                   |   79 +
>   hw/arm/aspeed.c                           | 1678 +--------------------
>   hw/arm/aspeed_ast10x0_evb.c               |  109 ++
>   hw/arm/aspeed_ast2400_palmetto.c          |   81 +
>   hw/arm/aspeed_ast2400_quanta-q71l.c       |   87 ++
>   hw/arm/aspeed_ast2400_supermicrox11.c     |   82 +
>   hw/arm/aspeed_ast2500_evb.c               |   68 +
>   hw/arm/aspeed_ast2500_fp5280g2.c          |   89 ++
>   hw/arm/aspeed_ast2500_g220a.c             |   93 ++
>   hw/arm/aspeed_ast2500_romulus.c           |   63 +
>   hw/arm/aspeed_ast2500_sonorapass.c        |  103 ++
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c |   78 +
>   hw/arm/aspeed_ast2500_tiogapass.c         |   91 ++
>   hw/arm/aspeed_ast2500_witherspoon.c       |  113 ++
>   hw/arm/aspeed_ast2500_yosemitev2.c        |   92 ++
>   hw/arm/aspeed_ast2600_bletchley.c         |   98 ++
>   hw/arm/aspeed_ast2600_catalina.c          |  226 +++
>   hw/arm/aspeed_ast2600_evb.c               |   66 +
>   hw/arm/aspeed_ast2600_fby35.c             |  179 +++
>   hw/arm/aspeed_ast2600_fuji.c              |  141 ++
>   hw/arm/aspeed_ast2600_gb200nvl.c          |  112 ++
>   hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c    |   56 +
>   hw/arm/aspeed_ast2600_qcom-firework.c     |   92 ++
>   hw/arm/aspeed_ast2600_rainier.c           |  199 +++
>   hw/arm/aspeed_ast27x0_evb.c               |   89 ++
>   hw/arm/aspeed_eeprom.c                    |  192 ---
>   hw/arm/meson.build                        |   24 +-
>   28 files changed, 2515 insertions(+), 1897 deletions(-)
>   delete mode 100644 hw/arm/aspeed_eeprom.h
>   create mode 100644 hw/arm/aspeed_ast10x0_evb.c
>   create mode 100644 hw/arm/aspeed_ast2400_palmetto.c
>   create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c
>   create mode 100644 hw/arm/aspeed_ast2400_supermicrox11.c
>   create mode 100644 hw/arm/aspeed_ast2500_evb.c
>   create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
>   create mode 100644 hw/arm/aspeed_ast2500_g220a.c
>   create mode 100644 hw/arm/aspeed_ast2500_romulus.c
>   create mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
>   create mode 100644 hw/arm/aspeed_ast2500_supermicro-x11spi.c
>   create mode 100644 hw/arm/aspeed_ast2500_tiogapass.c
>   create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c
>   create mode 100644 hw/arm/aspeed_ast2500_yosemitev2.c
>   create mode 100644 hw/arm/aspeed_ast2600_bletchley.c
>   create mode 100644 hw/arm/aspeed_ast2600_catalina.c
>   create mode 100644 hw/arm/aspeed_ast2600_evb.c
>   create mode 100644 hw/arm/aspeed_ast2600_fby35.c
>   create mode 100644 hw/arm/aspeed_ast2600_fuji.c
>   create mode 100644 hw/arm/aspeed_ast2600_gb200nvl.c
>   create mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
>   create mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
>   create mode 100644 hw/arm/aspeed_ast2600_rainier.c
>   create mode 100644 hw/arm/aspeed_ast27x0_evb.c
>   delete mode 100644 hw/arm/aspeed_eeprom.c
> 

It looks good.

Could you please maintain :

   Copyright 2016 IBM Corp.

in the new files since the code is copied from aspeed.c.

Thanks,

C.



