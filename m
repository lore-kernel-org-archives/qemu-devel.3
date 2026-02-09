Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F0EE78D40
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMg6-0002Ce-Jy; Mon, 09 Feb 2026 03:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpMfz-00027R-UW
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:31:24 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpMft-0007f9-Ec
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:31:22 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.177])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f8dFX4d4rz5vsk;
 Mon,  9 Feb 2026 08:31:12 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 9 Feb
 2026 09:31:11 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004315ccb28-d0e5-4425-abbf-1a088de58471,
 ECF38C093296ADD45142D325C9F6EF635D78D8A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5e9e55de-77fe-4871-97b3-8627892abdac@kaod.org>
Date: Mon, 9 Feb 2026 09:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Split Aspeed ARM tests into
 separate files
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Kane Chen
 <kane_chen@aspeedtech.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <20260209065044.239378-2-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260209065044.239378-2-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 23fb41e1-53d0-47bc-9f53-8cb69a380bbe
X-Ovh-Tracer-Id: 11191445076348799989
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFBHWYuf4O/QB18KNyHNHgD8O0k7ImPacN78JxHMgruLjXzLs7fOkxSlGyA7yoMRJ6TF9yXNQsCkrkWBWvXdsw2LOp+JYM0h08sEm6J7xozLmgqboCtCeqYEoBWsfVqbukdcCFF6fpAURRxa+iEIB304+1uuitb8hlT27/L7BvLvNii6keoIx8txFylbQ8YRAzAW1tXmQlO3kUZjyk8A0y8oHZpDV0jXpq+k5Yd/jrUeACTd2+PWLNOpamKZZWdR5PlYtbZqgYcOrvhEsR/n78o2WGPcoo9tbuKk3puoUuHfpExrxqdL5XGphDyxNnCbOFYOAQ8n2ZPVCTKgW64ZBbnjDmTg+7EGiaUc+dDYEsMXrSD4ghR4rxPOvImseFqGAyiFyLEjXF6RHxdfrcxqZQR85qADYjps5bIywKUqrarF3tPfyYSWip+jhql9WAc7Nj18XSdyGWR2J8iSTEHNAskZeBrwAnTDNOUYqWNff9hTGG01PlKe/wbY723y6nxufaVjakKVlA7nyKGkbnFJCx0O63NcWq9dTQtV9MQ5EPYLFC4pBhyc72jT7NXnUYJ24SgWytdgWcF9JnNzFiYj0Z3uZVrMgJorh294GRClmeOoEUw7HOD82NRdGvbNi/cLJZhe2R/5EhnhqplVG+Id9kvy0KYt8yaycWOx5y18EGzrQ
DKIM-Signature: a=rsa-sha256; bh=GXZ+Lv+gE8fRZ3g/c2IAyzGsK113i5IGnemdXLd+yFI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770625872; v=1;
 b=S6hL3UP2dd+6439s6/FlnjlkOUpYFWjs93PpL4wOuLth0NGqjj1b/ZaRIEwO0YS8n4s0ifym
 gRJARYAm0Kx2PpNMD0X6YivIfHECkONyScZ4VFXp6aUykiUHDbwnDzyHdYjfmApFHWoif5mEO8A
 YPdLJ2GKX08pMzGCTF3i70j/54G1Csvwt60pp0HRIabPsfGp6Kk1YRCNxZdDtUlulz5WHn9tA+U
 fygse1Du7Y4Aox7G5wgqc1XnCS2qAZIP6xJ5kzOn/baP+KW1E+aF3IwK79lRWh6vgcjC/AhLkyh
 oELMxK3j4wWxCdyNRIVtxKDEtyrArDS9sS4J1wb8N4kaw==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

+ Kane,

On 2/9/26 07:50, Cédric Le Goater wrote:
> Reorganize the monolithic Aspeed functional test files into separate
> files based on firmware type (Buildroot vs SDK) and specific test
> scenarios. This allows the test suite to run tests in parallel more
> effectively and makes it easier to identify and run specific test
> scenarios independently.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/arm/meson.build              | 14 +++--
>   tests/functional/arm/test_aspeed_ast1060.py   |  0
>   ...00.py => test_aspeed_ast2500_buildroot.py} | 14 -----
>   .../functional/arm/test_aspeed_ast2500_sdk.py | 29 +++++++++
>   .../arm/test_aspeed_ast2600_buildroot.py      | 41 +------------
>   .../arm/test_aspeed_ast2600_buildroot_tpm.py  | 60 +++++++++++++++++++
>   .../functional/arm/test_aspeed_ast2600_sdk.py | 15 -----
>   .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++
>   8 files changed, 134 insertions(+), 73 deletions(-)
>   mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
>   rename tests/functional/arm/{test_aspeed_ast2500.py => test_aspeed_ast2500_buildroot.py} (74%)
>   create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> 

[ ... ]

> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> new file mode 100755
> index 000000000000..4066532d5dec
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> @@ -0,0 +1,34 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +
> +class AST2600Machine(AspeedTest):
> +
> +    ASSET_SDK_V1100_AST2600 = Asset(
> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-obmc.tar.gz',
> +        '64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93')
> +
> +    def test_arm_ast2600_otp_blockdev_device(self):
> +        self.vm.set_machine("ast2600-evb")
> +
> +        image_path = self.archive_extract(self.ASSET_SDK_V1100_AST2600)
> +        otp_img = self.generate_otpmem_image()
> +
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
> +            "-global", "aspeed-otp.drive=otp",
> +        )
> +        self.do_test_arm_aspeed_sdk_start(
> +            self.scratch_file("ast2600-default", "image-bmc"))
> +        self.wait_for_console_pattern("ast2600-default login:")
> +
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()

Kane,

This test doesn't add much compared to the sdk boot. Is it possible
to extend to exercise the OTP feature ?

Thanks,

C.

