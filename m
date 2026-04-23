Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1E6F99351
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFq03-0008P5-SZ; Thu, 23 Apr 2026 05:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wFq02-0008OJ-Go
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:05:30 -0400
Received: from 5.mo534.mail-out.ovh.net ([54.36.140.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wFpzx-0005kF-UJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:05:30 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4g1VYH6kqkz6CML;
 Thu, 23 Apr 2026 09:05:23 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 23 Apr 2026 09:05:23 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.13])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g1VYH5gB7z1xnY; Thu, 23 Apr 2026 09:05:23 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8A5821B43ABB;
 Thu, 23 Apr 2026 09:05:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007b95cc11f-8ffa-4faf-83d8-760c28ddf65b,
 C846149266E0C9F4D826987B86006927C6E58490) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <aa626393-5757-4c43-96b3-370d8155b74d@kaod.org>
Date: Thu, 23 Apr 2026 11:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "farosas@suse.de" <farosas@suse.de>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
 <20260423051804.362095-18-jamin_lin@aspeedtech.com>
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
In-Reply-To: <20260423051804.362095-18-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16200292288092417069
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGoS7NlEyFt81jSX19rro+JqLaoKKBSoNj4WVSXw8Dyn59fZrkkyTkum6T15Gw2zC52mlRUeD3jIrRqXh6rBduh8M+dlfQE/uDVBAXLg2ODbB1uiIWVXHaySBF7hbVFquuKrmsHv+oAEZkcRwpZvVrfFsxeEQ1Z0zBZpjVwykFe4Vld7dEXTNi26C+VKEG1HXXs0mJF6A7F1imIrXJiNOjZolXNMeA4hz7OdQmBaJCNzmXrONnL6RL85Du+H8iZwSssGG+O73G9tQnH6sDFwi7CGp2i98rYUuZ2XUcKtY4Oh+ao7cOXuXJT+h5e6aZ/0gRSVCOUbCPuR/VQRZq5b+pMnQtoqdTBAGgiDTncxVg7hABJowiBg1yB25577tzGUsk9xya6Q67exJlib0oLxjPA2a51LJt1xJovfOuNbwZqgdUyu9N/u7uI42ZY7USFrW+q0cWsszDQ/Oupv+5hN8DiWWsFtrcThxD/vVGdBrpp9cmhHLTuI7vvJ8ton32YlcLFhjZ2P4QsiUua+zwcMgD4lC9jyehsStfhJeMqZ6pnp+fiISXZiZ+2ySGrOmwA+jy+qMHyF/vSn8kV9bHCzCaKwtcrPPNZmyFtjY0Aq/Mk+i2EX6Pj2oJOG/q1GyK3ndv02cusTeKoPzbiTHw3OMvq2sEqJwUtXttTf2yOSWzYRg
DKIM-Signature: a=rsa-sha256; bh=Ghe9rSHypWlyy/6XHjoUiv3G309UCLhC/Plaf5lJnm0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776935124; v=1;
 b=Shdu7i1S3M3qCSrRNZOrOydgU1XIPkIKwABAiZK1MccaYzV6zbNyF0Dj0OQx7p9decfeF2hX
 Iu5d+JFtR7l9Q4qVLM8AvqP4SeRJnvBOOQWs9NYMDtGrx77bhjntPrcyb9BosmFv8NeBdNuj0UO
 kB6Kz6S8SwX5BiW/GpQdmxXmPtV5UMwZTRqtY0pnlYMyF1CQdXGKMUOHuqy6S0VyTdL2tBj/RGn
 kXzZmuc01KfUYuo3jl7oRufCmJzeLmjezB5Yv5zD5A0keYT3nUs6hD5q/gcURxY2G96uexGuycN
 jMSXURuXruko28e5Px4ZhOq00cBUf0rk7+Z+/Lr850fBA==
Received-SPF: pass client-ip=54.36.140.176; envelope-from=clg@kaod.org;
 helo=5.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/23/26 07:18, Jamin Lin wrote:
> Add a functional test to verify USB EHCI support on the AST2700 A2/A1
> by attaching a USB keyboard device and checking its
> enumeration via lsusb.
> 
> This introduces a helper routine that runs lsusb in the guest
> and validates that the emulated "QEMU USB Keyboard" is detected.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/aarch64/test_aspeed_ast2700a1.py | 7 +++++++
>   tests/functional/aarch64/test_aspeed_ast2700a2.py | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
> index b0c08854da..42b8b200cf 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
> @@ -118,6 +118,11 @@ def do_ast2700_pcie_test(self):
>               'ip addr show dev eth2',
>               'inet 10.0.2.15/24')
>   
> +    def do_ast2700_usb_ehci_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'lsusb',
> +            'QEMU QEMU USB Keyboard')
> +
>       def start_ast2700_test(self, name, bus_id):
>           num_cpu = 4
>           load_images_list = [
> @@ -161,10 +166,12 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):
>           self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
>           self.vm.add_args('-netdev', 'user,id=net1')
> +        self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.3')
>           self.start_ast2700_test('ast2700-a1-image', 1)
>           self.verify_openbmc_boot_and_login('ast2700-a1')
>           self.do_ast2700_i2c_test(1)
>           self.do_ast2700_pcie_test()
> +        self.do_ast2700_usb_ehci_test()
>   
>       def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):
>           self.set_machine('ast2700a1-evb')
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> index ed414999f4..40e0ad81ed 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> @@ -121,6 +121,11 @@ def do_ast2700_pcie_test(self):
>               'ip addr show dev eth2',
>               'inet 10.0.2.15/24')
>   
> +    def do_ast2700_usb_ehci_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'lsusb',
> +            'QEMU QEMU USB Keyboard')
> +
>       def start_ast2700_test(self, name, bus_id):
>           num_cpu = 4
>           load_images_list = [
> @@ -164,10 +169,12 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):
>           self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
>           self.vm.add_args('-netdev', 'user,id=net1')
> +        self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.3')
>           self.start_ast2700_test('ast2700-default-image', 1)
>           self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700_i2c_test(1)
>           self.do_ast2700_pcie_test()
> +        self.do_ast2700_usb_ehci_test()
>   
>       def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):
>           self.set_machine('ast2700a2-evb')

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


