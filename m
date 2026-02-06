Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EABEB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIe4-00036P-HA; Fri, 06 Feb 2026 05:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIdp-00034k-8R; Fri, 06 Feb 2026 05:00:57 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIdn-0002xP-C9; Fri, 06 Feb 2026 05:00:44 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.134])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f6qN84ZRYz5vpt;
 Fri,  6 Feb 2026 10:00:40 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 6 Feb
 2026 11:00:39 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00126dd36ac-6ef6-4b06-b56b-e2efc8f2e21d,
 C2DCEC2B1261BCA5104DC73024CD17A0EB88A4A8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <92e0156b-1dde-4d7c-ad34-4c994736a2df@kaod.org>
Date: Fri, 6 Feb 2026 11:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
In-Reply-To: <20260206053340.3716041-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 85cd1b30-8f0b-4b57-ae14-53ff54694635
X-Ovh-Tracer-Id: 13531065084120697662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGvj/+BBDe2JZbT0turgfPw/Ss2XeWMF38tgWZ1E7moszbdwpzxgvhqc2Z6P9IN7tAc1XWRTMMXqHAtreWQyWxv1jYCz2twTy729wkYMkC9TJj8sq0reWgRQIzUgpSdRoOK1bFf97i21dVnHsYAmwi45N1+9nNJcAB8PwizpC3wJygDigwNgFLRSpkzbFwXbGXLZQEsQaTDbNg08hLjrvabO7J5gEBEu1IEsHqd31Anhb1Ea9p6ENlVfVyD6US0PvJHSUVHPaSw/n2ARvmQsBmBvFuGUabfnq4BNbKVdbvQKfrErwLX1RuA5Hs5YAkH09CcrdAkNKWkrCcuRNnA540yDlS1dndtvdle4wlCP+GmZq0EXGyu/51mnZyawvjOI9wlkIt2jcbf5kUq3qEWUlTK8XYAt12LwJ9B5VgDsOwdpFdyCaYcDs46VbLR+O43jgyDC0MpPNnQlkjGoEKR9SGHWtLQsDd2Oy+wt4rVfcmmX4lUKI/7g5dSHijRjo7KQVuTJsp4B0RMDZS0jpTEwFtQXzI7YY8b3KL+Le1+GPW1btw0E2XjwN6SF1xeXVwgfKq1oy3B0oNnHK2txoAUJDqT/UZTHKVM9mLUNL0xYxB0Ohx8ZUxL4AkOft4vyrqo6bMP+qu51qYOedXuK3JVRfhbdvR7HnaZalTlFbjbCXqjUQ
DKIM-Signature: a=rsa-sha256; bh=DXiAl/MdfirKJ37U/4XhC3QSJqkcaXnqV7X3DbZcKNk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770372040; v=1;
 b=U8ZpJFOuSK7HGRFmzeflZn2konQtHuvZ999Czjp0jCP22rjJ93R74/BMBtDqM6x5FVQQ7oQJ
 xYofHNf3kl3+78j1ZK9ktVZ7V1OV2F6p+ve5qJv+sqVSLU5pl2yrhcb5xEjoThrnmWaFCyCSrN0
 GYn3NKF6Qpup/atSZgqnQP+p1owxBQjmiqUOHuV7eKeEK9T8Srd83pFoxTAcJHVRn/7cjUzR/px
 mvfHXDc0ImFJEyANxbhUfCwVkVkJLQf4oDXF9I7SU5kcdXedisnRtX3KfQjmhK5gTXghw7TI0ET
 8D3VJePIpItqro9S6wV5TnPfCgQL6UpR6wFgDuyb5qaiA==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/6/26 06:33, Jamin Lin wrote:
> Update AST2700 FC functional tests to use the AST2700 A2 SDK v11.00 image.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../functional/aarch64/test_aspeed_ast2700fc.py  | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index 47e56dcfc5..51ee8bc787 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -62,8 +62,8 @@ def load_ast2700fc_coprocessor(self, name):
>                                f'loader,file={file},cpu-num={cpu_num}')
>   
>       ASSET_SDK_V1100_AST2700 = Asset(
> -            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
> -            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-default-obmc.tar.gz',
> +            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc')
>   
>       def do_ast2700_i2c_test(self):
>           exec_command_and_wait_for_pattern(self,
> @@ -98,7 +98,7 @@ def do_ast2700fc_ssp_test(self):
>           exec_command_and_wait_for_pattern(self, 'version',
>                                             'Zephyr version 3.7.1')
>           exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
> -                                          '[72c02000] 06010103')
> +                                          '[72c02000] 06020103')
>   
>       def do_ast2700fc_tsp_test(self):
>           self.vm.shutdown()
> @@ -109,7 +109,7 @@ def do_ast2700fc_tsp_test(self):
>           exec_command_and_wait_for_pattern(self, 'version',
>                                             'Zephyr version 3.7.1')
>           exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
> -                                          '[72c02000] 06010103')
> +                                          '[72c02000] 06020103')
>   
>       def start_ast2700fc_test(self, name):
>           ca35_core = 4
> @@ -153,8 +153,8 @@ def test_aarch64_ast2700fc_sdk_v11_00(self):
>           self.require_netdev('user')
>   
>           self.archive_extract(self.ASSET_SDK_V1100_AST2700)
> -        self.start_ast2700fc_test('ast2700-a1')
> -        self.verify_openbmc_boot_and_login('ast2700-a1')
> +        self.start_ast2700fc_test('ast2700-default')
> +        self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700_i2c_test()
>           self.do_ast2700_pcie_test()
>           self.do_ast2700fc_ssp_test()
> @@ -164,8 +164,8 @@ def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):
>           self.set_machine('ast2700fc')
>   
>           self.archive_extract(self.ASSET_SDK_V1100_AST2700)
> -        self.start_ast2700fc_test_vbootrom('ast2700-a1')
> -        self.verify_openbmc_boot_and_login('ast2700-a1')
> +        self.start_ast2700fc_test_vbootrom('ast2700-default')
> +        self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700fc_ssp_test()
>           self.do_ast2700fc_tsp_test()
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




