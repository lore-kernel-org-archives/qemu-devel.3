Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F09BEA4FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuoe4-0006Nu-FU; Tue, 24 Feb 2026 04:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vuodL-0005qd-Dp
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:23:11 -0500
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vuodE-00052z-WB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:23:07 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.210])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4fKshL4bCsz5vxf;
 Tue, 24 Feb 2026 09:22:58 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 24 Feb
 2026 10:22:57 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002bb8ccf0e-7457-4065-bc99-a42242502556,
 F9A4566923F578D8C63E1C019A32813E693EEB39) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <7c6d421b-413a-4908-8e02-a9ccec4e42e5@kaod.org>
Date: Tue, 24 Feb 2026 10:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] i3c: aspeed: Add I3C support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <b6ad55df-e6ef-443b-a075-ab6959cefd46@kaod.org>
 <TYPPR06MB82061ECF268DE4C88A7641B4FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB82061ECF268DE4C88A7641B4FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG16EX1.mxp5.local (172.16.2.161) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 42dfc547-ad30-4691-bb0a-fff3894935ab
X-Ovh-Tracer-Id: 7922113220873259908
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGiYe1Fpr4suuOcvCqvS+HetFLvmnu4UdTJP+AwrUNA7PVN40SEmysBn5MU1sXoE/GIde1XkWEFoGrpBcRTPK3OjAg8Agq98sBcfSSotSbh4osaHJaDqsFZ2HP1esPNNjxkKUzmkj3B/PBOtDdBbzcUxSy7sMsjR8fm7CCUSeoHxBTc4jXFg7NCy1HZGCPE4K2+ePvPBayTdsnQdwJ5hJ++WuH2joEK0KpcUndDzVQmL5jiqokWFFzZ5NHkGrjHtd+pU/BFv0Uu5qOZk7T6YgieGBWwnupz7ruHcDHxovREpKwcxOOFceSzR2DolSPzTJRq9mTGfRDvmrpRvwTlGM9rGDTlcxn3WOe8pEeMaCeWWliDXiGtv+mq0nTDahvyVS3p3+s1B3Vk362IWc6UYL5mZ4+qDrlr5N1od1F9i2DW5Jowm6nyVlGqx7M4CO6m24omuHV8SvIdGT5uZgh2iQ2EmTLN3rs0qT0XkTs9lRK8HRfwnd0c+V8D/kuusAe5xUhwJnQactFvRzKZwH+yBfhzQfdkXmonBAaok/0uV/BNykdphNVg/5KznWay8oAn76AZOJEkr3+zQ0ztYtrGgtL2yqmYTN74kSeH7VO8A9hCNVhFRFGL8+MN9+Z2152B3aKJKKNMFY/v3fFZEE0bSD7X6sn9kRTpS5vK607bztJw8w
DKIM-Signature: a=rsa-sha256; bh=mvRYL1QkJW5VSm4TeqG+2YVRfCxyK6u6hV8jfgQHtGs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1771924980; v=1;
 b=CgvN1+37QyD+n7Wxqd1E+P1rHFW/DCRKj2gcsfvIJE3Vm7qqhCTO5+TRCxb5kvXBEews1BzT
 5u9YP9KbdscACTU1QE/KEBSu09JgiOClFSJB8BSMsdSkGK+9SA6J3OHiHnO9DIlDqp5ed/gxYxb
 1ys1eFyCibt3ymanxhZwhmunCI2MJeEIqcUXRipXqfXR2p6VKoEIgQsnARnjR7Kac+46V+ECvEA
 OjWoAgugbyE8odLAQdeAe/HwpcvRUA1Vs2iMquO3IBgmf6JPHDZu53I/Di2nBj5MTyfnPbxTBjw
 i/ZYoqcUI1G3lB5gmDiz2TBov0AAD9hIezPYsmAJfJpGA==
Received-SPF: pass client-ip=178.32.121.110; envelope-from=clg@kaod.org;
 helo=1.mo548.mail-out.ovh.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 02:29, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v5 00/21] i3c: aspeed: Add I3C support
>>
>> On 2/10/26 10:10, Jamin Lin wrote:
>>> v1:
>>>     The initial patch series was based on work by Joe Komlodi
>> <komlodi@google.com>.
>>>
>>>     This series adds I3C bus support to QEMU and adds more functionality to
>> the
>>>     Aspeed I3C controller.
>>>
>>>     This implementation is a basic implementation that introduces IBIs
>>>     (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't support
>>>     multi-controller buses or HDR transfers.
>>>
>>>     First we add the I3C bus and controller model. With that added we
>> extend
>>>     the functionality of the Aspeed I3C controller so it can do transfers
>>>     and handle IBIs.
>>>
>>>     Next, we add a mock I3C target. It's intended to be a very simple target
>>>     just to verify that I3C is working on the guest. Internally, we've used it
>>>     on Linux to verify that i3C devices can be probed and can send/receive
>> data
>>>     and IBIs.
>>>     This target is sort of like an EEPROM, and it can also send IBIs upon
>>>     reception of a user-defined magic number.
>>>
>>>     Lastly we add  hotplugging support. The hotplugging doesn't do
>> anything too
>>>     complicated, it just adds the device attempting to hotplug to the bus. It
>>>     is the device's responsibility to hot-join and go through the DAA process
>>>     to participate on the bus.
>>>
>>> v2:
>>>     Jamin Lin <jamin_lin@aspeedtech.com> has taken ownership of the I3C
>> patch
>>>     series for upstream submission.
>>>
>>>     Changes in this version include:
>>>
>>>     1. Added I3C functional tests.
>>>     2. Updated patch 4 to refine register field definitions.
>>>     3. Updated patch 7 to correct read-only register field masks.
>>>
>>> v3:
>>>     1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>     2. Fix a typo
>>>     3. Fix ASPEED mail server issue
>>>
>>> v4:
>>>     1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com> at the end
>> of each patch.
>>>
>>> v5:
>>>     1. Address review feedback by updating the I3C bus and device to use the
>>>      DEFINE_TYPES() macro instead of an explicit type registration function.
>>>     2. Rename variables to `parent_obj` for the parent object and
>> `parent_class`
>>>      for the parent class to comply with QEMU QOM coding style
>> guidelines.
>>>
>>> Jamin Lin (2):
>>>     hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and align parent_obj
>>>       naming
>>>     tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test
>>>
>>> Joe Komlodi (19):
>>>     hw/misc/aspeed_i3c: Move to i3c directory
>>>     hw/i3c: Add bus support
>>>     hw/i3c: Split DesignWare I3C out of Aspeed I3C
>>>     hw/i3c/dw-i3c: Add more register fields
>>>     hw/i3c/aspeed_i3c: Add more register fields
>>>     hw/i3c/dw-i3c: Add more reset values
>>>     hw/i3c/aspeed_i3c: Add register RO field masks
>>>     hw/i3c/dw-i3c: Add register RO field masks
>>>     hw/i3c/dw-i3c: Treat more registers as read-as-zero
>>>     hw/i3c/dw-i3c: Use 32 bits on MMIO writes
>>>     hw/i3c/dw-i3c: Add IRQ MMIO behavior
>>>     hw/i3c/dw-i3c: Add data TX and RX
>>>     hw/i3c/dw-i3c: Add IBI handling
>>>     hw/i3c/dw-i3c: Add ctrl MMIO handling
>>>     hw/i3c/dw-i3c: Add controller resets
>>>     hw/i3c/aspeed: Add I3C bus get function
>>>     hw/i3c: Add Mock target
>>>     hw/arm/aspeed: Build with I3C_DEVICES
>>>     hw/i3c: Add hotplug support
>>>
>>>    meson.build                                   |    1 +
>>>    hw/i3c/trace.h                                |    2 +
>>>    include/hw/arm/aspeed_soc.h                   |    2 +-
>>>    include/hw/{misc => i3c}/aspeed_i3c.h         |   31 +-
>>>    include/hw/i3c/dw-i3c.h                       |  199 ++
>>>    include/hw/i3c/i3c.h                          |  277 +++
>>>    include/hw/i3c/mock-i3c-target.h              |   52 +
>>>    hw/i3c/aspeed_i3c.c                           |  258 +++
>>>    hw/i3c/core.c                                 |  664 ++++++
>>>    hw/i3c/dw-i3c.c                               | 1862
>> +++++++++++++++++
>>>    hw/i3c/mock-i3c-target.c                      |  298 +++
>>>    hw/misc/aspeed_i3c.c                          |  383 ----
>>>    hw/Kconfig                                    |    1 +
>>>    hw/arm/Kconfig                                |    3 +
>>>    hw/i3c/Kconfig                                |   15 +
>>>    hw/i3c/meson.build                            |    6 +
>>>    hw/i3c/trace-events                           |   48 +
>>>    hw/meson.build                                |    1 +
>>>    hw/misc/meson.build                           |    1 -
>>>    hw/misc/trace-events                          |    6 -
>>>    .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +
>>>    21 files changed, 3710 insertions(+), 412 deletions(-)
>>>    create mode 100644 hw/i3c/trace.h
>>>    rename include/hw/{misc => i3c}/aspeed_i3c.h (53%)
>>>    create mode 100644 include/hw/i3c/dw-i3c.h
>>>    create mode 100644 include/hw/i3c/i3c.h
>>>    create mode 100644 include/hw/i3c/mock-i3c-target.h
>>>    create mode 100644 hw/i3c/aspeed_i3c.c
>>>    create mode 100644 hw/i3c/core.c
>>>    create mode 100644 hw/i3c/dw-i3c.c
>>>    create mode 100644 hw/i3c/mock-i3c-target.c
>>>    delete mode 100644 hw/misc/aspeed_i3c.c
>>>    create mode 100644 hw/i3c/Kconfig
>>>    create mode 100644 hw/i3c/meson.build
>>>    create mode 100644 hw/i3c/trace-events
>>
>>
>> Who will be the maintainers and reviewers ?
>>
> 
> I will add myself (Jamin Lin <jamin_lin@aspeedtech.com>) and Joe Komlodi (<komlodi@google.com>) as Maintainers and
> Nabih Estefan <nabihestefan@google.com> as a Reviewer for I3C in the MAINTAINERS file in v6.

OK. I can be the sponsor then

> Would anyone from the QEMU community be willing to serve as a Maintainer or Reviewer for I3C?

As I3C is currently only available for Aspeed machines, please
add me as a Maintainer. I will handle the pull requests.

Thanks,

C.


