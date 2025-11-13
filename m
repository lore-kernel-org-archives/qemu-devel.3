Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E9CD6E55
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXUq-0004Dj-H6; Thu, 13 Nov 2025 08:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vJXO6-0007Jm-Mc; Thu, 13 Nov 2025 08:29:23 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vJXO2-0001qV-Tv; Thu, 13 Nov 2025 08:29:22 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.72])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4d6h211xD4z5vqf;
 Thu, 13 Nov 2025 13:29:13 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 13 Nov
 2025 14:29:12 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001ebf831df-5e0f-4650-a1b0-1a74b85c9de4,
 4476756531275CA3349E6B909B2DFE5C65DEBF14) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <06842eed-d2cb-4197-bcdc-ef1e9e4d16c2@kaod.org>
Date: Thu, 13 Nov 2025 14:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/arm/test_aspeed_ast2600_buildroot: Fix
 pylint warnings
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 <qemu-arm@nongnu.org>
CC: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 <qemu-devel@nongnu.org>
References: <20251113100601.476900-1-thuth@redhat.com>
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
In-Reply-To: <20251113100601.476900-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 9d787003-3bac-460c-bf1a-6ce359e3f5df
X-Ovh-Tracer-Id: 15936268757002783535
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGMTIJ8ZTTV9ndDJig0jm498hwYB/2IGZOp3R/kQ75jxUlYSQWI7R73+ZvZIB/NO9YUgA3pmAGeLDaa17f9i5wNYo4JBWSyiUY9D82iLzd6CsbfVAEG446y12me3Bd9NO1dge+kQebVJTWEAQh1ZT9dIvrWu8HvL6nB99rwRtC1IBkcyRMwUyzxloklKbkpo+7asENigJasnh4UbcWQdZgyAxct59UARkw9VcpITuEee+LGf59I2aZK3FbmohOh95EP49XKebOAcW30/kFVFyF3IDp+wLq8o8EZ0p5rt1gJISy2V2zjF9aTWNzrx4LsDl4UP/ocN1KG3shjtFpzd6WUCZiffSTGJRTG/D4Uik6ApFed71lfr+0lkrSySLE4My6oRYHgoRccFhQFHiXahS/VhWUcvHTNhJVkE1ZFmYUqZoaekbD/YAYvbstQtNYIaX2wFg2+/d/xE5AA4VEJU9FUxvZ2mGf1Df4cDXytD521W0BeYgDNtq6Wj9gb1ySTqoIZYL+nIMCJnIIRzoTUOtPujTBBk5q1bpFTNGIdS6Z7VpHf3ioor2YL8YuaeMzn0Iahmo9yjm+z8gV6NlUxVyNMFIfnbrGZXR7qqmzE615VpcG5H3F6YaWqn97hjaDXs7qff2VH8jO2qGRYYPfEJZiBcCrlwAIweQD6SYUj/O9BZg
DKIM-Signature: a=rsa-sha256; bh=dtRY7Oq2KnY4ME8ERFUP4loEHlhNA2bij8/IfxEGwqU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763040555; v=1;
 b=UtlfyYzIVo77D6H3KW50F88AwHMrP+EiCiIj8660WfU5EDCX+YSsbq8vGXqj3bcotguqxfMg
 tKFZpclKMcY9GaqFAR4ruUJaeHcZ1X4RwzpABO8UAMleya244TbXcHHnZZtUEXHEYSrOBUuc69A
 JI754LAKeiMspFfYM8Ee/8C9bxuVMFbO1rI6NRORTdGuke4MyMsr+5KFabiDgq5k+v8e8Lmdn2G
 EUB4qr3r4Mm6ZM5an+GJVW0lZjLceuxXD3Lff9Tn4/abO+/PZ+l8+vuKyowFjlkpBMfeIzzETqW
 DVzBOkEaVDbEUJlAD8cxh/IWKuUGVEKDxW1s6IFFomq0g==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/13/25 11:06, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint recommends to use a "with" context for tempfile.TemporaryDirectory()
> to make sure that the directory is deleted once it is not needed anymore,
> and it recommends to use the "check" parameter for subprocess.run().
> For style reasons, the imports at the beginning of the file should be
> grouped by module.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .../arm/test_aspeed_ast2600_buildroot.py      | 21 +++++++++++--------
>   1 file changed, 12 insertions(+), 9 deletions(-)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> index 51f2676c906..575a5f64143 100755
> --- a/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> +++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> @@ -9,8 +9,8 @@
>   import tempfile
>   import subprocess
>   
> -from qemu_test import Asset
>   from aspeed import AspeedTest
> +from qemu_test import Asset
>   from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
>   
>   
> @@ -66,21 +66,18 @@ def test_arm_ast2600_evb_buildroot(self):
>            'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
>           'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
>   
> -    @skipIfMissingCommands('swtpm')
> -    def test_arm_ast2600_evb_buildroot_tpm(self):
> -        self.set_machine('ast2600-evb')
> -
> +    def _test_arm_ast2600_evb_buildroot_tpm(self, tpmstate_dir):
>           image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>   
> -        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> -        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
> +        socket = os.path.join(tpmstate_dir, 'swtpm-socket')
>   
>           # We must put the TPM state dir in /tmp/, not the build dir,
>           # because some distros use AppArmor to lock down swtpm and
>           # restrict the set of locations it can access files in.
>           subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> -                        '--tpmstate', f'dir={tpmstate_dir.name}',
> -                        '--ctrl', f'type=unixio,path={socket}'])
> +                        '--tpmstate', f'dir={tpmstate_dir}',
> +                        '--ctrl', f'type=unixio,path={socket}'],
> +                       check=True)
>   
>           self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
>           self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
> @@ -97,6 +94,12 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>   
>           self.do_test_arm_aspeed_buildroot_poweroff()
>   
> +    @skipIfMissingCommands('swtpm')
> +    def test_arm_ast2600_evb_buildroot_tpm(self):
> +        self.set_machine('ast2600-evb')
> +        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
> +            self._test_arm_ast2600_evb_buildroot_tpm(tpmstate_dir)
> +
>   
>   if __name__ == '__main__':
>       AspeedTest.main()


