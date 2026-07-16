Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55698C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMiL-0002ro-H8; Thu, 16 Jul 2026 10:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkMiF-0002pF-5K
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:05:20 -0400
Received: from smtpout4.mo540.mail-out.ovh.net ([51.210.91.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkMiC-00023n-Cn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:05:18 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4h1FDS6sspz42vC;
 Thu, 16 Jul 2026 14:05:12 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 14:05:12 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.55])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1FDS48s2z7tDT; Thu, 16 Jul 2026 14:05:12 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 8407A1923D9A; Thu, 16 Jul 2026 14:05:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006e85e0780-d4f9-4cbf-ac95-81c8d703b403,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <56685a9a-495c-464b-8878-6d33001c81b0@kaod.org>
Date: Thu, 16 Jul 2026 16:05:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] tests/functional: Add Huygens BMC boot test
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
 <20260715155037.2237011-6-mikail.sadic@ibm.com>
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
In-Reply-To: <20260715155037.2237011-6-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 16507944434548583589
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFYu6RYzP0DpaOmksmukHbgT54jNuALVIu+GXs+psQ0E9dqEPGz6K+BD1P06cjkuSHa9lnSuVIiHgyfhznBXrT1tc5Fdmbeh6sDHwOxN34+81BkDOpNEdXP/OpUUEJuJXOaKzNxY5JqduiQrEuc8kHqDh1CtoWR9mIGk5/e5IEPmFpo/eN8C+BhIhJaltGqT3Ppg4+HCVfQitgKikZK0KCKElVjrIgVCa1NSjya/MNvDkOPkuDFtmejALNhtO/+4uidfwSmBPH6V52NJQGOUgql8wMglYc91g4uWF6AWFEqrUEcAai71cDCkLeHE7HHJrPbajZ1s0xn/U7VAER7bvAPN/XFCkHriNy+MY8FLMWfRMoZjnwnKwddg1SgmNzW9Kle7evtIItxnZSADip/mE5/9sCfc9DyDILonb+N8o3ZKcXHVDKZMjnzi3cq+3MOrNnfog0clTKHKUDh2zLFNGCvEnKOCLYyWuGUgZSqfWCMKRIBuBurcJWN3uJ08ejhTa1JrQjt9meToR9VSNMk15FKu0yIl1r9ckD+zs7jhb/tuy2axNlha2Xylg5d2ae7jY0JLubOShV2zb1LmiM3j45bWJdget3yqAUFwtiIzJU1vrqS7FBRcLeWq+hSxWEOLRmnA+eRDeQKR5qFcOTb0dfLC5o0GcTmUQ1GK4djB2T7FA
DKIM-Signature: a=rsa-sha256; bh=OOFoFBq+byc2eHk/ZmV8KD8KyWCD3KPwXiYmJgU0eNQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784210714; v=1;
 b=h1p+Ano0jeHuIVsg8xiOd1Wio6Vupk+1J2IWQ87WXymJmYWnE33eKhNF7mJze4rMzu5agIxP
 BrKaYx0rHedU4sZL5+4v5DhE4uta/7ccJqIwXk0UmxLKlb6a5FlMetot+EfNB9ACG4IKobS63Pf
 Ev3JyOCfGXOS2x1LHhOAM7e90Bcpthid+0gFBythnmOJiGhTAoODD7VrGzGS4olJus79KtzR/Sn
 H8e67vbpVwVGA2zkmEwMkF9fBV7sdSb52ALg/EyADGDPYcKjWdSIhHuiSWx+rpES9BQ085WyLvC
 7wV1/R1KUBFACFEwrAYAs6Ofd7QGcLtKqHJNXAcBOlypg==
Received-SPF: pass client-ip=51.210.91.53; envelope-from=clg@kaod.org;
 helo=smtpout4.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/15/26 17:50, Mikail Sadic wrote:
> Add a functional test for the huygens-bmc machine that boots from FMC
> flash and a UFS storage image, verifying the full boot sequence from
> U-Boot through OpenBMC login and multi-user target.
> Note: The Huygens img is not yet public, so this test is for future/internal
> use. It has been tested/verified with the correct image, and will gracefully
> exit if image is not found.
> 
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
> ---
>   tests/functional/aarch64/meson.build          |  2 +
>   .../functional/aarch64/test_aspeed_huygens.py | 49 +++++++++++++++++++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py
> 
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index e81afd6c39..d81c0d6761 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -4,6 +4,7 @@ test_aarch64_timeouts = {
>     'aspeed_ast2700a1' : 600,
>     'aspeed_ast2700a2' : 600,
>     'aspeed_ast2700fc' : 600,
> +  'aspeed_huygens' : 600,
>     'device_passthrough' : 720,
>     'imx8mm_evk' : 240,
>     'imx8mp_evk' : 240,
> @@ -29,6 +30,7 @@ tests_aarch64_system_thorough = [
>     'aspeed_ast2700a1',
>     'aspeed_ast2700a2',
>     'aspeed_ast2700fc',
> +  'aspeed_huygens',
>     'device_passthrough',
>     'hotplug_pci',
>     'imx8mm_evk',
> diff --git a/tests/functional/aarch64/test_aspeed_huygens.py b/tests/functional/aarch64/test_aspeed_huygens.py
> new file mode 100755
> index 0000000000..750d6e0d7f
> --- /dev/null
> +++ b/tests/functional/aarch64/test_aspeed_huygens.py
> @@ -0,0 +1,49 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED Huygens machine with UFS storage
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +
> +from aspeed import AspeedTest
> +
> +class HuygensMachine(AspeedTest):
> +
> +    def test_arm_aspeed_ufs_boot(self):
> +        self.set_machine('huygens-bmc')
> +        self.require_netdev('user')
> +
> +        # Huygens image is not public yet, skip if missing
> +        fmc_path = '/tmp/fmc-huygens.img'
> +        ufs_path = '/tmp/ufs-huygens.img'


This is dead code. resend when they are then.

Thanks,

C.


> +        if not os.path.exists(fmc_path) or not os.path.exists(ufs_path):
> +            self.skipTest(f'Missing required images: {fmc_path}, {ufs_path}')
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-drive',
> +                         'file=' + fmc_path + ',if=mtd,format=raw',
> +                         '-drive',
> +                         'file=' + ufs_path +
> +                         ',if=none,format=raw,readonly=off',
> +                         '-nic', 'user,model=ftgmac100,net=10.0.2.0/24',
> +                         '-nic', 'user,model=ftgmac100,net=10.0.3.0/24',
> +                         '-nic', 'user,model=ftgmac100,net=10.0.4.0/24')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('U-Boot 2023.10')
> +        self.wait_for_console_pattern(
> +            'Vendor: ASPEED Prod.: UFS QEMU Rev: 1.00')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern('Machine model: Huygens')
> +        self.wait_for_console_pattern('Starting systemd-udevd version 257.1')
> +        self.wait_for_console_pattern('Phosphor OpenBMC')
> +        self.wait_for_console_pattern('huygens login:')
> +        self.wait_for_console_pattern('Active BMC Target')
> +        self.wait_for_console_pattern('Multi-User System')
> +        self.vm.shutdown()
> +
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()


