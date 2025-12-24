Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61B9E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRD6-0004HI-CT; Wed, 24 Dec 2025 10:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYRD4-0004Dl-E5
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:55:34 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYRD1-0004f4-09
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:55:34 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.78])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dbxKp4BBDz5yW6;
 Wed, 24 Dec 2025 15:55:26 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 16:55:25 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0049f2ec94c-c329-4f35-bde9-027ad221d087,
 9377EA31308664D21D54FC0151EBFE1D7AAB8817) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <655cb6a0-fc0c-4afa-bb10-ceeeb2a7bc03@kaod.org>
Date: Wed, 24 Dec 2025 16:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/25] tests/qtest: Remove unnecessary 'qemu/bswap.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Anton Johansson <anjo@rev.ng>, Peter
 Maydell <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano
 Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani
 <gautam@linux.ibm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-24-philmd@linaro.org>
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
In-Reply-To: <20251224152210.87880-24-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: c3d609c6-038c-4b79-a872-a71a9228ac96
X-Ovh-Tracer-Id: 931682174380116831
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEzZ3Hg6TzDZwubrNqQSW+l1Yttbmns+JeszqQWeO2F15e92TixEChh/IdrxKJHKKP+IemOFfaVrloWoWKYb9sXwVRv+iVZWkOrWoSj5dElg+UajsEP6RNjyQxgVmqGvhjAT6cLq1LmOISGs3EHmDIhbJwHsY81Fg0unP+fWjf43dc3KFQUIA8QVutMVqL25Nfw5QJnuYYeIt8nqulVAD6q9dbQA4hxxN5AliBkle0Lw4MUaXvW9EU6Htip92itc6CQ+lOQmXeGKrNt7Xg2z6/DsQmhNHSwwCSUuDkWjg5ML9n3HEWOa3o0zwQWs5S5uAcLfHLWLXRSzF2L8leWaQfhYPypqZxwUsRz4TSexxFvf4zpynsELm0HwEuWVm2iHbxxc+1C2cDYjWKZz7kiCHS8DkV7hzzjxv9RLCpTZe2ymPUKTx3syy/LCxMB9Xi/fyPXfZXvzetSYbgthP/cMXmQkacLASEPqMjaObkjIt9HcMF+XG1yjWOIjxii4HYcxvWkx24pfX8OLLU7G5RFfkOKC/ED+OSCW6MLnIlPKqhPXjhVt4v0FoRchIG/Xo2cpjhn9uwXGmIvn5jZiYtmiz/cBTCEDL1DF3kNEKLgCPm1pD3bUqM0H4SRNsqeXEox+RUafhNFXtA2g2xuVzKM5Rcxs2EyQzu9LvL/q3WK8nd4vg
DKIM-Signature: a=rsa-sha256; bh=cFBb5jyIpAbxFgZaF5Sp9pk27VzxpxcKQhLHPqMdb2g=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766591728; v=1;
 b=F420Kj6ax93qBZFKx0DgzNbveKnsrYb5cAlQz2SWNGhI3e24XHTnYhMCIHXwChN+sQCFuOPk
 T7B86AiwP9wY8PMZfZHQdKxztxCRfjuhQFDgT5m6iY7Rc/Q1iGsW+dVA+eNsLEY6ZvLfP5dhSZv
 Tem9a1h5AEmb8fRZxQogYXrkaH6ORcCEu4gvhIO+KaV6sZ8yu8dMS3IRlU9YlBgI1Zv26qzKc+r
 ftxLsSavAo8+kvVHsmPg7gV+ukjZ0IQbS25FhVA93bvCyinU+zosgoiOYnafOxPLvN7kIhkpU80
 INo+V9951ME2QAc+jXceJUe11C7Ej1FGevvsGzF82eAEg==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/24/25 16:22, Philippe Mathieu-Daudé wrote:
> None of these files use API declared in "qemu/bswap.h",
> remove the unnecessary inclusion.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Cédric Le Goater <clg@redhat.com>


> ---
>   tests/qtest/pnv-xive2-common.h     | 1 -
>   tests/qtest/aspeed_smc-test.c      | 1 -
>   tests/qtest/ast2700-smc-test.c     | 1 -
>   tests/qtest/libqos/fw_cfg.c        | 1 -
>   tests/qtest/libqos/i2c-omap.c      | 1 -
>   tests/qtest/pnv-spi-seeprom-test.c | 1 -
>   tests/qtest/vmcoreinfo-test.c      | 1 -
>   7 files changed, 7 deletions(-)
> 
> diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
> index 2077c05ebc7..3b842274243 100644
> --- a/tests/qtest/pnv-xive2-common.h
> +++ b/tests/qtest/pnv-xive2-common.h
> @@ -15,7 +15,6 @@
>   #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
>   #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>                                    PPC_BIT32(bs))
> -#include "qemu/bswap.h"
>   #include "hw/intc/pnv_xive2_regs.h"
>   #include "hw/ppc/xive_regs.h"
>   #include "hw/ppc/xive2_regs.h"
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
> index 50a87e62500..39af1df0ed7 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -24,7 +24,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "qemu/bswap.h"
>   #include "libqtest-single.h"
>   #include "qemu/bitops.h"
>   #include "aspeed-smc-utils.h"
> diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
> index 62d538d8a3a..33fc47230ee 100644
> --- a/tests/qtest/ast2700-smc-test.c
> +++ b/tests/qtest/ast2700-smc-test.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "qemu/bswap.h"
>   #include "libqtest-single.h"
>   #include "qemu/bitops.h"
>   #include "aspeed-smc-utils.h"
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 0ab3959171b..8611f648c14 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -17,7 +17,6 @@
>   #include "malloc-pc.h"
>   #include "libqos-malloc.h"
>   #include "../libqtest.h"
> -#include "qemu/bswap.h"
>   #include "hw/nvram/fw_cfg.h"
>   
>   void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> diff --git a/tests/qtest/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-omap.c
> index 6f98f54820b..71f70c64f85 100644
> --- a/tests/qtest/libqos/i2c-omap.c
> +++ b/tests/qtest/libqos/i2c-omap.c
> @@ -10,7 +10,6 @@
>   #include "i2c.h"
>   
>   
> -#include "qemu/bswap.h"
>   #include "../libqtest.h"
>   
>   enum OMAPI2CRegisters {
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> index 8033261758b..44e0b92730b 100644
> --- a/tests/qtest/pnv-spi-seeprom-test.c
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -7,7 +7,6 @@
>    */
>   #include "qemu/osdep.h"
>   #include "libqtest.h"
> -#include "qemu/bswap.h"
>   #include "hw/ssi/pnv_spi_regs.h"
>   #include "pnv-xscom.h"
>   
> diff --git a/tests/qtest/vmcoreinfo-test.c b/tests/qtest/vmcoreinfo-test.c
> index dcf3b5ae058..0110dcceffa 100644
> --- a/tests/qtest/vmcoreinfo-test.c
> +++ b/tests/qtest/vmcoreinfo-test.c
> @@ -16,7 +16,6 @@
>   #include "libqtest.h"
>   #include "standard-headers/linux/qemu_fw_cfg.h"
>   #include "libqos/fw_cfg.h"
> -#include "qemu/bswap.h"
>   #include "hw/misc/vmcoreinfo.h"
>   
>   static void test_vmcoreinfo_write_basic(void)


