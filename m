Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E3CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDCt-0005s0-UG; Tue, 04 Nov 2025 04:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vGDCq-0005qq-Ad
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:20:00 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vGDCm-0002C0-V8
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:20:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.176])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d0zfX3tLgz5wrL;
 Tue,  4 Nov 2025 06:52:36 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 4 Nov
 2025 07:52:35 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0064219cf4f-2d6f-4b62-9af3-dac6c30f9d65,
 A964659C6063B800B97356674929232E0CFCBCD8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <30dc59f4-2c1e-4080-b92f-fc882af6eede@kaod.org>
Date: Tue, 4 Nov 2025 07:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 00/30] Split AST2400, AST2500, AST2600, AST2700
 and AST1030 SoC machines into separate source files for
 maintainability
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 70ce4d59-7a02-4231-b7f8-0e2b3cad0b64
X-Ovh-Tracer-Id: 11723995731790498738
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGYLsbMMZt8VZ4bNOfKang+Fv7lQR8q5/aDLbCbjHfPxyfu6X7uRKjBARDBW/YIMQl/3162Tbrr6VfQ5C+/E+cs7jGLP8kz3h0rUKmEh/jpfI472rQaTS1MdvCFe5NavzymrNHNqe7FeXnGpBkDIoINxpeEZWztt0sDRiAfzGiY/qh2KzqD67cNBSPi+j/enFGsiuW1xUBwybgnDfnnKfnwMjfKVCRr125RsHWnTNTdaf6gonbKnhJvuY932OJ/4j1Bb3C4uMrRhVAcjTrCmWOVp+DTMgwhaX4H/hOkC+B8BYRcuIFEtMofGYvsR7O8GxCxUC1iyRA086X2gk/Gzd1KQXiO5Z+nmixmZBWO4i1C8GgcBidRErmntNNVnKLszvWTiEMPUUm18u2sNbLTIz0dtdaBixUGDT/VLYvM5P/x4O0ym0fGKjEyNOkjlV60By8Z/VLKO1rjYVVdYTALSVwzpI18WmfPDiDsaiRMZdYmwMVrafz0mvImspvYyF10XnSz1RntTvlqe428/kvatGndOPew+lbGvQ7AUHapnX85TRQM7nPXxJIJcVs8CVlUbSReJZompLKblp4j4PqvLUnmSxQUT9G3ZJMCrNeqiIca3aTx/PS3awFzd+L+SAdmLzNgOYpIjfjhjT8oxqqoF+pr2C1UHWVC3WE+I0XEfTDvog
DKIM-Signature: a=rsa-sha256; bh=g1QvV++slqm4E5s/uOPcHuzSOdYX94WVRo3pL5N49Cs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762239157; v=1;
 b=gamoZCm0FHCNaBYwvaueI2+seTpgiiPm6KIK1EMOA2RK8SxSxRp9DBYm4p84Qwtny56/c9Vt
 N+iCRmS1ZyAxQyPxudD3dYEX15uso/OmeAK/J77GyW9/HQGrmYZOdXirqc4wy2wDYaKNY+E8Jlw
 uQpsmj/628ZtJnyxNebhI3Bu0PzhzsXN5/F3vpNaYEjwoecH6rK37V8XApvaj0HGPYfkswSiDQL
 WNygw87O2JAEQJ6EheC7nz2HBf0vgJKNfL9Vsf64zH6zXufyduqAWqg71aaTG7gLGq1u2yvi29b
 TFd+CH4ZXLoHVWHBWvyoplPG0x3JfL3jJPRNkWbxWQ4wQ==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
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

On 11/4/25 04:12, Jamin Lin wrote:
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
> v4:
>    1. maintain :
>      Copyright 2016 IBM Corp.
> 
>      in the new files since the code is copied from aspeed.c
>    2.  Use I2C instead of I2C
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

For the series,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




