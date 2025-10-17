Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89B8CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9d28-0001yQ-DP; Fri, 17 Oct 2025 01:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v9d20-0001v6-FF; Fri, 17 Oct 2025 01:29:37 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v9d1r-0001rI-0R; Fri, 17 Oct 2025 01:29:36 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.128])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cntfp4cP9z5vq4;
 Fri, 17 Oct 2025 05:29:22 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:29:22 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001fd0710da-47d5-488d-8cb2-585a55b7751f,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <12317b7f-a3b3-466d-9809-efe25b03d308@kaod.org>
Date: Fri, 17 Oct 2025 07:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 11/12] tests/functional/aarch64/ast2700fc: Move
 coprocessor image loading to common function
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
 <20251015062210.3128710-12-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251015062210.3128710-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 59a2ea92-caab-4e67-9738-7bf872b68799
X-Ovh-Tracer-Id: 15290283686575967023
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEjseNlrurgBWxOWls2HgNRaWPXE10BRmugC9HIl4WIHqPppvrzSme62eutv/fD0qmpwZcDhxwibJdxmIZmwjZZ/0y+Y+5I2f/q0gpbt5VXpwQzLIfEtwTpEAD1Ai4lHMHwecwnBuf4UuGj7kwGb8xlnWfXZ0c4g46bOXN/rjiOkFPQyLcw+wfFfrTcpxpTdHP3/JZ+46ZJigh41itw0SvKQzChYCMLgZ/p0J4PtKXIMRzWmWlK5AFaG07uP7mp9EmTrfQtbIiYKTC3sPkNf98sJLJowGJ/jykAr7VnGXrYTisaNOOdM+g6wSwPP8qIhILwEVaKGwNrtkCgcjt1JJ4OtAniSGJq7CnZ/LM6nx0EVIG/jS0YQLcmFu88JBrpGrmFxC2iIdiGrFZhXQN5rJjQf1EuLJT8YcExX16nVChvKxMgvniKNxoEjoxSUtlG3iFiETa4cKBFutVSL7h3BOI/ZqkyCe0GDuOSsirtF1SWRCW1B8p8z//ZmAC+/mmtJHvTA12WjVFYU9frXekNOdjzRk8lLPIKtZtNmjEpUCl2/C3pDpuaXOWR65EdbdKY2PPxhqu2AYEN8sABA/iEq6ne5nXoUKImbfzwk7k/Mi+2u4fy85X0TSVrMuAyLSBrNVY/mFs7BETnao0aScMkEw2nSM0K2amZZaHQ+Muwkpp2hg
DKIM-Signature: a=rsa-sha256; bh=bwJ4y9VASjBD5XMTvpJVQKcj+RWDqwaTRFdny0aSxFI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760678962; v=1;
 b=v7cyIifX5QclO6Kj7r47G43Jcdtqw7+xB5VUHKZMWJX1uZa0TBkJKUbr3w+/DC22xfGfnEB/
 xfguts/NdFOM6l1c49P/PaLBthn6BUskG06bGFSP6n/o6arrN/tf4mBgHA8thBGE4YVfWH1AYOg
 yKmXgf4RFJYsyIdd1DfAoqlGnvPX9DPjT65126P150yIdmEHIzbuEabPnL27tJpFa6fBxIEFJEt
 mXFVLYBdjFnh1siZdvSgips+mk5Wb2rlQMDPxIPDwbh4eyqmNbFmmUYEEXFd9z9J1bs0sj0XVan
 YPt487M8M8uGomtNepp2y66m/Bx8rX6zTTU3YBehdaiYA==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/15/25 08:22, Jamin Lin wrote:
> This removes duplicate code in start_ast2700fc_test() and prepares for reuse in
> upcoming VBOOTROM tests.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../aarch64/test_aspeed_ast2700fc.py          | 22 ++++++++++---------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index 843647e6c5..9ab3d3269b 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -36,6 +36,17 @@ def verify_openbmc_boot_and_login(self, name):
>           exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>           exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
>   
> +    def load_ast2700fc_coprocessor(self, name):
> +        load_elf_list = {
> +            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),
> +            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')
> +        }
> +
> +        for cpu_num, key in enumerate(load_elf_list, start=4):
> +            file = load_elf_list[key]
> +            self.vm.add_args('-device',
> +                             f'loader,file={file},cpu-num={cpu_num}')
> +
>       ASSET_SDK_V908_AST2700 = Asset(
>               'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
>               'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
> @@ -123,16 +134,7 @@ def start_ast2700fc_test(self, name):
>               self.vm.add_args('-device',
>                                f'loader,addr=0x430000000,cpu-num={i}')
>   
> -        load_elf_list = {
> -            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),
> -            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')
> -        }
> -
> -        for cpu_num, key in enumerate(load_elf_list, start=4):
> -            file = load_elf_list[key]
> -            self.vm.add_args('-device',
> -                             f'loader,file={file},cpu-num={cpu_num}')
> -
> +        self.load_ast2700fc_coprocessor(name)
>           self.do_test_aarch64_aspeed_sdk_start(
>                   self.scratch_file(name, 'image-bmc'))
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



