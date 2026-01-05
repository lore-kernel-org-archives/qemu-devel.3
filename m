Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5D8C2A088
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 10:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vchUg-0006yj-UV; Mon, 05 Jan 2026 05:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vchUR-0006sI-BX; Mon, 05 Jan 2026 05:07:10 -0500
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vchUL-0002LS-UM; Mon, 05 Jan 2026 05:07:07 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.179])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dl92B42fQz5vwX;
 Mon,  5 Jan 2026 10:06:58 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 5 Jan
 2026 11:06:57 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006a4e1ba45-67ef-4e37-be97-9464d8c7e4d7,
 57A157A87F73C68790EE1B05CA42A5939BFB4281) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <dcd218cd-0554-4b19-9113-13bd92ef83e1@kaod.org>
Date: Mon, 5 Jan 2026 11:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] i3c: aspeed: Add I3C support
To: Joe Komlodi <komlodi@google.com>, <qemu-devel@nongnu.org>
CC: <venture@google.com>, <peter.maydell@linaro.org>,
 <steven_lee@aspeedtech.com>, <leetroy@gmail.com>, <jamin_lin@aspeedtech.com>, 
 <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <qemu-arm@nongnu.org>
References: <20250613000411.1516521-1-komlodi@google.com>
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
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 2206e2eb-78ab-47ec-8042-163716e31a74
X-Ovh-Tracer-Id: 10178698110403775410
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGqvGsGcub4jUl8I2UddcR0Xn7W2HklEXSCzEfRDj1Fck3Isy9z8En7ZUdaxEto4DiupArtbbq8uTuM1hwg2jfa8wiQrB+Eg0do5SzWD4nSTrZ9u57d6hLolzzujjeYD/bYBz0yBRGM2MMFu2SYu0Qub72xOy9kK2j9TLU2PPHpEFyEI9elCwGQ/0Y06tIcitOIv87ln2o41xtzE2ZdwgGHoDZTC+/3bTYZYEtF9mBrru39KamqSZ1+FXY/yYW13RJWyvMQWXihnpYbqHU9/C1kFx8H8f1vV2gzdOz66VWIVirXzOWahyw+c21HkqPsHCsC0x/uKNnSzmHL5+uI7/I8BZjFfaXqdPD/A2FAtqSZZvb+Q8XcKHW5BiLGtd/6TBzLRVJbR+e4FhDAWFC3/R0C54vZkE5pJ06bej0avYb5fPwRlykyCSDe7Fm6Wxtk9GBmfOx0OlsLG9fwRfxevbnmWGelI9GLqyeyrPzF6XihTdShVK0EAW7E69laylJ9JQvwlOu745MVa5QyvCKhdrdNspTwujcdh4Jp1zvH3N8XV24WyhPxovPnivr07ahPAij3OzdQhHEjT7WC57gkCn0z+WeVotssVBqCFsfIUgWEc5DCQyuYqAMxPPfTc7iQ4IoswfmYDhCZMEj5/g2XffPml7SdfBjev0PbzTXCKTgEaA
DKIM-Signature: a=rsa-sha256; bh=xib+RYV3mZLw8uqzG//SIoXiuK61Q6WcH4TMLyaqHfs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767607618; v=1;
 b=Oy3Oi8NZx/DrACLts0BbdsKwyuwWksPNwL8XF2jUYQZQQ589oddTQcBnkhDcxbKKL5aC2wn0
 p/ok/zvLQx1bCsHp4w/E7YlMlb4ueAdnl1+35pI7sN/zn/voCqCPMBVT9cVrBg3StWjzAN+Pjph
 ppKfuc2peCSgaP15+jq9zYsLi+97SPKyiWRPGG5MG5UxphyqpaPY7Fv7pI2GUjlVkHjt3dmH4Mg
 vhuUi0tdyedpGn7zazrclr7UnFm5sCAxKyyKInQ/BCJTDyrtMn5cIaduFIBSufvVywrY5054/0M
 9iPTsQlN7qxr7WcRRYk/8jQtMjqRNIhKel0HmmO2Wua/g==
Received-SPF: pass client-ip=46.105.48.137; envelope-from=clg@kaod.org;
 helo=9.mo548.mail-out.ovh.net
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

Hello Joe,

On 6/13/25 02:03, Joe Komlodi wrote:
> Hi all,
> 
> This series adds I3C bus support to QEMU and adds more functionality to the
> Aspeed I3C controller.
> 
> This implementation is a basic implementation that introduces IBIs
> (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't support
> multi-controller buses or HDR transfers.
> 
> First we add the I3C bus and controller model. With that added we extend
> the functionality of the Aspeed I3C controller so it can do transfers
> and handle IBIs.
> 
> Next, we add a mock I3C target. It's intended to be a very simple target
> just to verify that I3C is working on the guest. Internally, we've used it
> on Linux to verify that i3C devices can be probed and can send/receive data
> and IBIs.
> This target is sort of like an EEPROM, and it can also send IBIs upon
> reception of a user-defined magic number.
> 
> Lastly we add  hotplugging support. The hotplugging doesn't do anything too
> complicated, it just adds the device attempting to hotplug to the bus. It
> is the device's responsibility to hot-join and go through the DAA process
> to participate on the bus.
> 
> Thanks,
> Joe
> 
> Joe Komlodi (19):
>    hw/misc/aspeed_i3c: Move to i3c directory
>    hw/i3c: Add bus support
>    hw/i3c: Split DesignWare I3C out of Aspeed I3C
>    hw/i3c/dw-i3c: Add more register fields
>    hw/i3c/aspeed_i3c: Add more register fields
>    hw/i3c/dw-i3c: Add more reset values
>    hw/i3c/aspeed_i3c: Add register RO field masks
>    hw/i3c/dw-i3c: Add register RO field masks
>    hw/i3c/dw-i3c: Treat more registers as read-as-zero
>    hw/i3c/dw-i3c: Use 32 bits on MMIO writes
>    hw/i3c/dw-i3c: Add IRQ MMIO behavior
>    hw/i3c/dw-i3c: Add data TX and RX
>    hw/i3c/dw-i3c: Add IBI handling
>    hw/i3c/dw-i3c: Add ctrl MMIO handling
>    hw/i3c/dw-i3c: Add controller resets
>    hw/i3c/aspeed: Add I3C bus get function
>    hw/i3c: Add Mock target
>    hw/arm/aspeed: Build with I3C_DEVICES
>    hw/i3c: Add hotplug support
> 
>   hw/Kconfig                            |    1 +
>   hw/arm/Kconfig                        |    3 +
>   hw/i3c/Kconfig                        |   15 +
>   hw/i3c/aspeed_i3c.c                   |  261 ++++
>   hw/i3c/core.c                         |  669 +++++++++
>   hw/i3c/dw-i3c.c                       | 1881 +++++++++++++++++++++++++
>   hw/i3c/meson.build                    |    6 +
>   hw/i3c/mock-i3c-target.c              |  311 ++++
>   hw/i3c/trace-events                   |   47 +
>   hw/i3c/trace.h                        |    2 +
>   hw/meson.build                        |    1 +
>   hw/misc/aspeed_i3c.c                  |  383 -----
>   hw/misc/meson.build                   |    1 -
>   hw/misc/trace-events                  |    6 -
>   include/hw/arm/aspeed_soc.h           |    2 +-
>   include/hw/{misc => i3c}/aspeed_i3c.h |   22 +-
>   include/hw/i3c/dw-i3c.h               |  201 +++
>   include/hw/i3c/i3c.h                  |  277 ++++
>   include/hw/i3c/mock-i3c-target.h      |   52 +
>   meson.build                           |    1 +
>   20 files changed, 3735 insertions(+), 407 deletions(-)
>   create mode 100644 hw/i3c/Kconfig
>   create mode 100644 hw/i3c/aspeed_i3c.c
>   create mode 100644 hw/i3c/core.c
>   create mode 100644 hw/i3c/dw-i3c.c
>   create mode 100644 hw/i3c/meson.build
>   create mode 100644 hw/i3c/mock-i3c-target.c
>   create mode 100644 hw/i3c/trace-events
>   create mode 100644 hw/i3c/trace.h
>   delete mode 100644 hw/misc/aspeed_i3c.c
>   rename include/hw/{misc => i3c}/aspeed_i3c.h (63%)
>   create mode 100644 include/hw/i3c/dw-i3c.h
>   create mode 100644 include/hw/i3c/i3c.h
>   create mode 100644 include/hw/i3c/mock-i3c-target.h
> 

Could you please resend a v2 with the R-b tags from Jamin ?

Thanks,

C.

