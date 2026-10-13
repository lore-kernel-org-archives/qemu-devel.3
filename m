Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B49CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfLr-0005XW-Gu; Tue, 13 Oct 2026 12:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfLG-00059o-8n
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:27:09 -0400
Received: from smtpout2.mo537.mail-out.ovh.net ([51.210.91.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfLA-00057Q-Fd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:27:03 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4j408v55X0z3wkL;
 Tue, 13 Oct 2026 16:26:55 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:26:55 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.233])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j408v0JQkz6MbW; Tue, 13 Oct 2026 16:26:55 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A979212E2CA6;
 Tue, 13 Oct 2026 16:26:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008cd285c04-b028-4431-ae67-8a95c5cd409a,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7f3eb371-308a-4687-a830-9071bca6a689@kaod.org>
Date: Tue, 13 Oct 2026 18:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/50] hw/rtc: ds1338: move TYPE_DS1338 to a public
 header
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-8-4c3dff084ec9@free.fr>
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
In-Reply-To: <20261012-bmc-minerva-v2-8-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6615506377813699629
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEy2TVmIGdJz9wb2lZxs6ZOYk0T6DuDjUbu8/zXGYTH4fUECEqloGjFfQQCwGTA+Qh7f8ykczPwXj/0yRHFk+ke0Oq8cqPzvgWUWqE52q4F8K7KHMRomHayz0KSPI3Kj1OS1RB4ltUXcr9VLwn8YMxu6kumcdPsPn14jLrFeI22oREKqPhMU2SvVrQ8KaXHRxjVPvt64nha3KIPtHpiy9r9K5jkCxjkBrKxyaee8ty7LwZMq0oVcVbO7WlIGgJOp6cyTRlPBQhZa3PdT41/UEK/QPowtMJd7DrnTJlu2XG9nN1MD1oRi9XLbB1T/tzjDKh80+WtaijTeEgascMvqUOASS318/WW8I689B1/rFpoJS/H8rqU1pa6Ty+1OtkeRI/ueRnVhPBKnAoKvDhEpwPUCAEjaVWuc5QUVF+QjWMVDuoVI/nclOXVhq+YMUuwNsq68/RZ2xiEjk/ugHqtrSPHph9ucCYbEQpPwWyH4v9qCgLRqJQxmvmIMz74fgOvJVRg4yWwFAzq2ZBkW2MR/wZpxJhRdvUsCT/HPM/Z/LqkNNeprg97s/TtcYZL9sDCvXeyeQj4djOkoiHtboSAbjMa264GKp7lN4BkN8S7Njg2z8OWlzTVc6i2DIRurGy4uwY2zb9WUZpbGuk/tOp8V4h1Zz1ncHYII/w6uRY3z540iQ
DKIM-Signature: a=rsa-sha256; bh=fPWqKdFXIRT/ZBtnTogM/a6xkJorxhRc4FlHXS8GHCI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908817; v=1;
 b=foG+9UwRpaWA5+JwPIswn8/alWXW6bxW+CG7AgMcCcv5N/QpzGjSeoZHb/5NLGBGqIEDVMi4
 to8BJRUCmCeIeAgDQemd9an4jGbufFeLkM+LlmEunBW84UHrHcZvY0UgsrePxGFr9LfosBpzCTE
 B7p7Cby1KosqE4+lamdQwN9SlD01FPb9uppPBAOVDYtljyqBNcD6xAlH9tT+yUCiUmDlhPHKQkG
 +Uct3Q5IpBbkkBkgqdSZKGmmglQvQsCY486pr+ge4cSP7FDEt0OhAZ4+YrxYLnBmOSwjaADrMnu
 d40SEDzYUkywMOqgdxadTWB/hrk6SSnvDHJrEa3C+VGeQ==
Received-SPF: pass client-ip=51.210.91.21; envelope-from=clg@kaod.org;
 helo=smtpout2.mo537.mail-out.ovh.net
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

On 10/12/26 16:32, Emmanuel Blot wrote:
> Move the TYPE_DS1338 type name definition from ds1338.c into a new
> include/hw/rtc/ds1338.h header so that boards instantiating the device
> no longer need to redefine the type name string locally.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/rtc/ds1338.c         |  2 +-
>   include/hw/rtc/ds1338.h | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
> index 5f1ee2e410..f8b3340bf0 100644
> --- a/hw/rtc/ds1338.c
> +++ b/hw/rtc/ds1338.c
> @@ -12,6 +12,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/i2c/i2c.h"
> +#include "hw/rtc/ds1338.h"
>   #include "migration/vmstate.h"
>   #include "qemu/bcd.h"
>   #include "qom/object.h"
> @@ -29,7 +30,6 @@
>   #define HOURS_PM   0x20
>   #define CTRL_OSF   0x20
>   
> -#define TYPE_DS1338 "ds1338"
>   OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
>   
>   struct DS1338State {
> diff --git a/include/hw/rtc/ds1338.h b/include/hw/rtc/ds1338.h
> new file mode 100644
> index 0000000000..f4cfe6a8e7
> --- /dev/null
> +++ b/include/hw/rtc/ds1338.h
> @@ -0,0 +1,20 @@
> +/*
> + * MAXIM DS1338 I2C RTC+NVRAM
> + *
> + * Copyright (c) 2009 CodeSourcery.
> + * Written by Paul Brook
> + *
> + * This code is licensed under the GNU GPL v2.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_RTC_DS1338_H
> +#define HW_RTC_DS1338_H
> +
> +#define TYPE_DS1338 "ds1338"
> +
> +#endif
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


