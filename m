Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A2CE83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYiu-0003fB-RU; Wed, 04 Feb 2026 03:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnYis-0003de-NE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:58:54 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnYiq-0005v0-5W
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:58:54 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.226])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f5Z5h21Qlz5vsq;
 Wed,  4 Feb 2026 08:58:47 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 4 Feb
 2026 09:58:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00594f80d1e-0d50-4169-a44c-1040feb79539,
 E481ED796CD1A7AD002472F698DA8951F44CEEA4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d27d32b2-b076-4049-a845-39fbad4dfa8f@kaod.org>
Date: Wed, 4 Feb 2026 09:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/22] tests/functional/aarch64: Parameterize PCIe2
 initialization in AST2700
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
 <20260204082113.3955407-22-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260204082113.3955407-22-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 7eb67720-13a5-4194-9fcc-833763d34e68
X-Ovh-Tracer-Id: 740560665367383029
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFcqtlfOM4QNFiq34GRKD9NBjTZMMswusWzdFgjxpspDL19zZtYj4YP4B1jZYGN1kkgGJlYa+OC12Yont10MYkg2E/6OKO4SRVK8E+5OOcqbbV44+Z/bEImaL9hnhrh3+1uQUnWMme37oaSTetw59hhAzy+Q6dAqf5sqVBFDtJRsbJev1cuOHsbktAxI+n5Nepgi/Ukenq0WeiOYR2FkI8hubeU63ufOltOWI/LBPtye+GjvZZnSMsiYH3ePx2KP+4t2YO7VNZM6ts36S6v5Zo0jH0jIOXiBq/7QOjyXl0QCZ2FkJ3b9g7ei6Q6yzMCaculoWvrXUA95i08R1e9rNQVA23y3RsrDJ1ZTCQMifL6snYFhJBnKpedDO8mSim+LNvl0InEAVQpbNi+0Wp5a8rX+L6JFC0fEWB65RUpAkmDGBh/7ycG5kGilYF3Pgs+CKBWbcXubMXPx/JzITkm8r26L57RNqEtFvjegkkWyvGKMDUxQoayp2J1emD+kdhsnm4Dy0Erjtnca4m2327PgAn4nONlAtGLA/pM8S6J/10d6buL1YawqvFSmoTk5Pq83+4c2S6mbd5Wxh2S6qT76nLOvCYfNjsE9r1aJyzqREUGkH8STuhTAinpFimMJZzjFyXm+AGrExk8iiVBL7PQCUs/pHPxKFh7oqLSqM2S6EUjTg
DKIM-Signature: a=rsa-sha256; bh=42ZovUMF0ykQ3ngiuSS7JzNRtlBbdU7DmDhL6pWhhCk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770195529; v=1;
 b=LYjc+K1/8EEtFd6vm+FmvdUE1DMnMZJkVQhilTs3kFU+UaRXlbnWvLJsR+cp0AqXOdvruqbI
 9qs+iaSYE9Y7qgml30R25lAoWdJfYFQ0Xk/I3vj+iG4VsdRQMzKpvW84U3YsptpAtKyXuj8Mtum
 d+HRlBoecdH84J1MdbVfxhNTya4IYxXaqFWLUu3ClK8S9nnstllckEC90Ko8+AyAhcDgam+LOeK
 7OPNwcmlcGLoZoudI5tnz0z+LzdjSQaBhE92dgcszS/q4YGm1odaGPJ8aYw4XcsAozywXD+aXwC
 h/yFFf5i9NPrlZdEPG57e42pzWPQxZz+NWy2rldptOGMQ==
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

On 2/4/26 09:21, Kane Chen wrote:
> The current AST2700 functional test forces PCIe2 enablement by manually
> manipulating U-Boot env and FDT via the console. This sequence
> interferes with test cases that rely on the default boot flow of the
> image.
> 
> Introduce a 'enable_pcie' parameter (defaulting to True) to both
> 'verify_openbmc_boot_start' and 'verify_openbmc_boot_and_login' methods.
> This allow test cases to toggle the PCIe2 initialization sequence based
> on their specific requirements without breaking standard boot tests.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




> ---
>   tests/functional/aarch64/test_aspeed_ast2700.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index d7eeab9c23..cb1aafeb99 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -65,13 +65,14 @@ def enable_ast2700_pcie2(self):
>               'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
>           exec_command(self, 'bootm go')
>   
> -    def verify_openbmc_boot_start(self):
> +    def verify_openbmc_boot_start(self, enable_pcie=True):
>           wait_for_console_pattern(self, 'U-Boot 2023.10')
> -        self.enable_ast2700_pcie2()
> +        if enable_pcie:
> +            self.enable_ast2700_pcie2()
>           wait_for_console_pattern(self, 'Linux version ')
>   
> -    def verify_openbmc_boot_and_login(self, name):
> -        self.verify_openbmc_boot_start()
> +    def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
> +        self.verify_openbmc_boot_start(enable_pcie)
>   
>           wait_for_console_pattern(self, f'{name} login:')
>           exec_command_and_wait_for_pattern(self, 'root', 'Password:')


