Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E9DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 06:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TOa-0002Ik-QD; Tue, 30 Sep 2025 01:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TOY-0002IV-PJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:59:26 -0400
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TOS-0004jp-Jp
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:59:26 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.106])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cbS763w5Kz5vwx;
 Tue, 30 Sep 2025 05:59:14 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 07:59:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0032dce8e33-96b1-4b22-bcd9-3c256f841d60,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <200777d4-a0cd-4992-b7ed-ec58acec3f74@kaod.org>
Date: Tue, 30 Sep 2025 07:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add Qualcomm BMC machines
To: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>, Peter Maydell
 <peter.maydell@linaro.org>, Titus Rwantare <titusr@google.com>, Andrew
 Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
CC: Graeme Gregory <quic_ggregory@quicinc.com>, Maheswara Kurapati
 <quic_mkurapat@quicinc.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20220622172830.101210-1-quic_jaehyoo@quicinc.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20220622172830.101210-1-quic_jaehyoo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 9669c53f-5772-4bc4-8cd2-ae7dfc260707
X-Ovh-Tracer-Id: 8192610672520694575
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE52DRRUtdIS1tp8Seawfxmks5HtUc3zZKbxv5YRK2tBT7k+y6BODLuFr/wcio8RRl4CqoPOO4jh9mQFym+1R87iO/TCdsEG4L4KK5rR2fS4qXEPHTp6MQyOgiYZCFfreYeoiC2jNKoxQHLQHjzY1gUU7JHu2PNNcp68wlKhlN7r3spkpgHfjaqLHYieSSfT7dHqKbZDY50nWzf/RlBtyEqlr6ban5pGRDB/4umNbkycXo3x0HMrWTOkkZmwm4AhGcrV5l1BNzgD/31XWdjXwIUw49FaRFqeKvlOCt8oRQkMgmUEF4HkfzqbqdBQamoSyA4XBnt+LRtBYxGTnl4r8msTT3mJF4+LBy642MTPyNsDtDi7W/UHbSMPeWnkkqLgftqXwQtOL1AOy2B3cYdRQens46X2t5rAkDhG4nNv/n1+45CglMZyJofq7fr+K1CmfOfSE/8d3BDQvRc3eaQnbIZG2i24mfVl8JT8O3jb8YPyd7F27AsMhn5nSYjtWpRAJKnr8q358oWidJ5psbiD7sNtHy5rTgM7umH8TmmhFSpPFRMi7gd108n3pkh/DANa8IJ5eGpYrzST/a4wB0ivWLgxlo+TlcBSRI2ZRHhHFfeFhNX4m0LcxcmJPt8x2F4kZhc30DvBrsoOnIXkA1YurFgj5vp6M+MQtMgcype98Btmg
DKIM-Signature: a=rsa-sha256; bh=AsbEsqQsCUo00tTPtJWCI6+2Mnn1pzNrY61066XwXjU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759211954; v=1;
 b=gsgluayRwp8EvxnkzjMGZcT3d6SJSeNThV6nl6JmgSYLb1nnMUQHjEUbJUsq3Pr4YeyInqrl
 zDyWYoPMVhKQiKQK3l5OHENW1TDAAegTZN42qjunuaxRbGWzdSemWHClaPTLq14lWx5mMPeQsUB
 AXSMUsIfy/TVEi+96U3hVDYFMWqIuo6GmtKXJfpOaERKRmu3IHWr9NQJgNXdOx2UO3QhsP2JB6T
 vHRgPCaCXcILIGSTcclPJq5jbHdUmBFYFJoG3/kyPzTLwi9hjK5VqSEcsiBemAdXwT2eWvbnN+2
 NR+UDoet3AJ1o3Np9b8WdylmhkI9mjYSjwT21Am5/XXPQ==
Received-SPF: pass client-ip=188.165.58.48; envelope-from=clg@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/22/22 19:28, Jae Hyun Yoo wrote:
> Hello,
> 
> I'm sending a series to add Qualcomm BMC machines that are equipped with
> Aspeed AST2600 SoC. Also, this series adds MAX31785 fan controller device
> emulation. Please help to review.
> 
> Thanks,
> 
> Jae
> 
> Graeme Gregory (2):
>    hw/arm/aspeed: qcom-dc-scm-v1: add block backed FRU device
>    hw/arm/aspeed: add Qualcomm Firework machine and FRU device
> 
> Jae Hyun Yoo (3):
>    hw/arm/aspeed: add support for the Qualcomm EVB proto board
>    hw/arm/aspeed: add support for the Qualcomm DC-SCM v1 board
>    hw/arm/aspeed: firework: add I2C MUXes for VR channels
> 
> Maheswara Kurapati (4):
>    hw/i2c: pmbus: Page #255 is valid page for read requests.
>    hw/sensor: add Maxim MAX31785 device
>    hw/arm/aspeed: firework: Add MAX31785 Fan controllers
>    hw/arm/aspeed: firework: Add Thermal Diodes
> 
>   hw/arm/Kconfig        |   1 +
>   hw/arm/aspeed.c       | 158 +++++++++++-
>   hw/i2c/pmbus_device.c |   1 -
>   hw/sensor/Kconfig     |   4 +
>   hw/sensor/max31785.c  | 580 ++++++++++++++++++++++++++++++++++++++++++
>   hw/sensor/meson.build |   1 +
>   6 files changed, 742 insertions(+), 3 deletions(-)
>   create mode 100644 hw/sensor/max31785.c
> 

Hello,

Would it be possible to contribute a functional test for these
machines ?

Since these machines contribute little to the Aspeed models,
their value lies in the firmware they can run to exercise the
models. Without functional tests, I plan to schedule the
removal in the QEMU 10.2 cycle.


Thanks,

C.


