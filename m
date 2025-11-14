Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B840CE7B11
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtpm-00033K-17; Fri, 14 Nov 2025 08:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJtpR-0002F1-3Z
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:27:05 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJtpN-0006Hp-7c
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:27:04 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.200])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d7Hwy29Vtz6PXc;
 Fri, 14 Nov 2025 13:26:57 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 14 Nov
 2025 14:26:56 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00406ac9ef8-f641-4c74-8de0-504d526a0b2d,
 DCBE4845A3BE020BB938A31E73221960BF2A3C2F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <31abbcab-9424-4d31-8334-d53d845fdd39@kaod.org>
Date: Fri, 14 Nov 2025 14:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 10/12] tests/functional/arm/test_aspeed_ast1060:
 Add functional tests for Aspeed AST1060 SoC
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
 <20251112030553.291734-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251112030553.291734-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 5caf6c13-6cb3-45c1-ba52-f60cf95b238c
X-Ovh-Tracer-Id: 3323938002311809854
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE4Vr/ir2Sw687MRB6nXjyG8t+NAEBwww8qNIxwPfHPfN62lUl/C8Gc6rnRz+ui75kKmetVFcv9kuMpE6NSn/85Xx5xCtkf/L9zlYejEd32EH/5viGhkNFICvtfgzSqBFj59hewH8Z7BMA9Qbw3SJFRu7I7sGrGF1Hde/5vPVd0rL8V43K+sBb7htbaEb4C+Pf41oXsxMNsWf9shhDp95m3ECujaskSd0rDcIs7lYzCACSCsa23BC1SGAtddWsGXo1aHEpz4ePG2smRUU2fR9PcFudgXtcUoWkp26rhcgxtnkYf0cm+7+iKph0v7sHWLWj8k+YS4Ik4KtnrCS3HD9ftcrfWQiBEI7K4LKep7Pk+HbxXiWwvMrRo1TuZIksE2TSo6lAbrZgIKMuqia0wCsOHLBMB/ee3re9RAJzYVUxDIIEQylRCfAgkwf8j2FFVv/j9pp/xnL95x5Rd1Xh4lSro+Yt3cph2FZWb2yaUyrO9f/F/xVi08JjYmyPiQGjc5Gq3FUxRfKuFBSQtgqkpKFQklU192LXALB5DfnmQLmIfdpcSnQ8/SnqJKino+rEpaeqvKPr2GxkVtCCufK4E2lxMFf0xYwd6u1BrCfnmnGoe1eZZohW26osArknkxIapkFLKS3vz1J0FXXYOOz6HLeISJs3hp5QDnLU45zr/XPSNMA
DKIM-Signature: a=rsa-sha256; bh=cTHIjUWRzk8+IVtoiIfXXDfakOywzmsw2XHiilXLZiI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763126819; v=1;
 b=qNbufMUmIQbIJuX3E3+6mTKhLWmABeUQeAmW0sW0+VCbcjXQrU2iYW/W38X2yN1O0tbfmoPv
 0P8qvdqfHSPFnDwIu0+DwWryO15Z9vUIAiuNRkD3cO/3EYofowrTkm0XZq6l25CM1JUUmXGYx/u
 wHeLz/+2jHnUPw14wuuUKjnJhyp1eL/xWuUmbqQTjLo+t9a76bN6UgNQNyhBJPKQMFaqhus6G+C
 CQhpCBLqjNGx6KoxsnBq6z/587ynHZ6FyOOHRWJ638y9ePJY7OMPcyrzzropbY7U0WGRAkCJZ+M
 bKeKF6nGkBZlrZ8gAgpSVstE3qGV6DfUDaQhzZojX1fMg==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Add functional tests for the Aspeed AST1060 SoC and its evaluation board.
> The new test test_aspeed_ast1060.py validates booting the AST1060 EVB
> machine using the Zephyr OS and ASPEED PROT application (ast1060_prot_v03.02.tgz)
> and ensures basic console functionality.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/arm/meson.build            |  1 +
>   tests/functional/arm/test_aspeed_ast1060.py | 52 +++++++++++++++++++++
>   2 files changed, 53 insertions(+)
>   create mode 100644 tests/functional/arm/test_aspeed_ast1060.py


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> index d1ed076a6a..1762a49604 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -28,6 +28,7 @@ tests_arm_system_quick = [
>   
>   tests_arm_system_thorough = [
>     'aspeed_ast1030',
> +  'aspeed_ast1060',
>     'aspeed_palmetto',
>     'aspeed_romulus',
>     'aspeed_witherspoon',
> diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
> new file mode 100644
> index 0000000000..034efa5342
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_ast1060.py
> @@ -0,0 +1,52 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED SoCs with firmware
> +#
> +# Copyright (C) 2025 ASPEED Technology Inc
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from aspeed import AspeedTest
> +from qemu_test import Asset, exec_command_and_wait_for_pattern
> +
> +
> +class AST1060Machine(AspeedTest):
> +    ASSET_ASPEED_AST1060_PROT_3_02 = Asset(
> +        ('https://github.com/AspeedTech-BMC'
> +         '/aspeed-zephyr-project/releases/download/v03.02'
> +         '/ast1060_prot_v03.02.tgz'),
> +         'dd5f1adc935316ddd1906506a02e15567bd7290657b52320f1a225564cc175bd')
> +
> +    def test_arm_ast1060_prot_3_02(self):
> +        self.set_machine('ast1060-evb')
> +
> +        kernel_name = "ast1060_prot/zephyr.bin"
> +        kernel_file = self.archive_extract(
> +            self.ASSET_ASPEED_AST1060_PROT_3_02, member=kernel_name)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_file, '-nographic')
> +        self.vm.launch()
> +        self.wait_for_console_pattern("Booting Zephyr OS")
> +        exec_command_and_wait_for_pattern(self, "help",
> +                                          "Available commands")
> +
> +    def test_arm_ast1060_otp_blockdev_device(self):
> +        self.vm.set_machine("ast1060-evb")
> +
> +        kernel_name = "ast1060_prot/zephyr.bin"
> +        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_02,
> +                                           member=kernel_name)
> +        otp_img = self.generate_otpmem_image()
> +
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            "-kernel", kernel_file,
> +            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
> +            "-global", "aspeed-otp.drive=otp",
> +        )
> +        self.vm.launch()
> +        self.wait_for_console_pattern("Booting Zephyr OS")
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()


