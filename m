Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3504AC2A096
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcic4-0006dj-Tt; Mon, 05 Jan 2026 06:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vcibv-0006co-8f
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:18:56 -0500
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vcibs-0004hK-0v
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:18:55 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.6])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dlBd40kZMz5vq4;
 Mon,  5 Jan 2026 11:18:48 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 5 Jan
 2026 12:18:47 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0058d4ecb85-ffd9-4e52-a7a4-156ea7eeb995,
 57A157A87F73C68790EE1B05CA42A5939BFB4281) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <95701480-83b1-4518-9beb-dccd7b445a4e@kaod.org>
Date: Mon, 5 Jan 2026 12:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
To: Kane Chen <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Joe Komlodi <komlodi@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <465b0714-bd08-40b5-9cf9-5cd206e8548b@kaod.org>
 <SI6PR06MB76312852C6243B1F48202A89F7B0A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
 <SI6PR06MB76318E7A596008386B0AE51CF7BFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <ed07c0f2-737d-4d65-917f-d39d02c37063@kaod.org>
 <006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org>
 <CA+QoejXzjvyLA0Pp0xJjCsrwSyegSBRBs-MaT7yP41Nd2B9BcQ@mail.gmail.com>
 <SI6PR06MB76312518466322BC6BD67DC5F7BCA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <d6fa3762-7ea8-4173-af20-9615cc5f92dc@kaod.org>
 <SI6PR06MB763159AEBF12B77662CE6697F7BDA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <72b2b29e-d5eb-412b-913f-6a0f56b709ae@kaod.org>
 <dca78653-72eb-43aa-b7a8-031abf0968eb@kaod.org>
 <SI6PR06MB763148CF78715EC2B1B6436FF786A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB763148CF78715EC2B1B6436FF786A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 464348ab-79da-474d-aaff-89c65e893793
X-Ovh-Tracer-Id: 11391855259526532027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGMwsonOEJoCYDQLyXcbba6CTGb+Xkv1dKvFR9hsOWuqYoAfZqxwcgugA+Tg31ww7/nYhcnfNwY83j/7rME1509DIP1qJzacbycGl625kyK2qawPF/1zyb4o0DXO/iJQvH8ozzeZxM2qtvIBVqJ/Dgrp2h46m86YaN8FRWh9aOZbheFNYP42soOGsyC9FmlqGw57GlFKTOz6X9JwNMHCIjV3kG3jDCEAh18BlpXxjex5C2vkgxM4acYZQOpdipuPouNwlZAtoSyYK4jDFNk2E4UumMM9S4SMpT4/nKJh6L2OCX0qcGU+rIbuFwSxcqsgZte2ZsSwaJcyhVpMp2At+bNEDqm7oRcl0tS12uJWgdP/6JOkz/GzkLtOEPh0S1dQ+0IEOW7Mr7GAd9oU4j2zVi2wrSbYDfjPzpS+DoFPYJTU7L+ETHOBve6mJ6nGvGZBlmbc/KvDm4lC+CQ9p0P2kPlZdsoJJ+pBJX+hV3Ma0H+0UV0flc7yau/hvQn0vv01tc8STgk1NFtt3RTD+VktdzFC2eztH176am5wrsXZl4tUclTipOnPsMP6G3pHpc9SHr/8pa/EvDP4Ma2Y4Gdl3eGDoqPeknh6wJiVgBb/DMqEJf8xUtvwXhqbrk3BFggSzUT/NyHSUhN6MCBvTJJSNpJwyH8si9lfZ32W7hQzwKvRQ
DKIM-Signature: a=rsa-sha256; bh=CzrgwnrDMzc9Doa4mvs1Ex1orArwupxeh4HeXCbFf6M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767611928; v=1;
 b=TZjZtniG5w0ws0vhl7VEgsb7z2wFW/kw/TuWfdMOLOgDx11JuogQROP3DjFEwy1X3UvFgCoJ
 bvlZN1037+TWj5OX+gTv8hqMx59qX8Z9yhzGl3vl4LhscFBA9/kExxTOaL/V0qqHjSMczlzW5oK
 pLaiw5rDjb8faj9eXrJHxn/No8cBHLe30gXbb2Qx8Ij332aqJCG8R/L2vb5CKDa4oR2L2R4dABO
 kWuw0x0+FLarF3IUlz4FDPjQyGiv+FRi032thCaXpRIXPTuK5YgpIAF8dPQUMVXDvmvwG4Lvxj8
 p4j4dYbs3fQWuwiBaIwRObhKrL297IiHz5PuDVWks1d4w==
Received-SPF: pass client-ip=46.105.48.137; envelope-from=clg@kaod.org;
 helo=9.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Kane,

+ Joe (for I3C)

> I was able to access a functional AST1700 platform today and captured the actual
> bus states. Below is the output from the real hardware (using the same image as
> my previous QEMU log):
> 
> ls -l /sys/bus/i2c/devices/
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-12 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0fd00.i2c-bus/i2c-12
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-13 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0fe00.i2c-bus/i2c-13
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-16 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f100.i2c-bus/i2c-16
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-17 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f200.i2c-bus/i2c-17
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-18 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f300.i2c-bus/i2c-18
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-19 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f400.i2c-bus/i2c-19
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-20 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f500.i2c-bus/i2c-20
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-21 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f600.i2c-bus/i2c-21
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-22 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f700.i2c-bus/i2c-22
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-23 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f800.i2c-bus/i2c-23
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-24 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f900.i2c-bus/i2c-24
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-25 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fa00.i2c-bus/i2c-25
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-26 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fb00.i2c-bus/i2c-26
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-27 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fc00.i2c-bus/i2c-27
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-28 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fd00.i2c-bus/i2c-28
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-29 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fe00.i2c-bus/i2c-29
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-30 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0ff00.i2c-bus/i2c-30
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-31 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c10000.i2c-bus/i2c-31
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-32 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f100.i2c-bus/i2c-32
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-33 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f200.i2c-bus/i2c-33
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-34 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f300.i2c-bus/i2c-34
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-35 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f400.i2c-bus/i2c-35
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-36 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f500.i2c-bus/i2c-36
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-37 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f600.i2c-bus/i2c-37
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-38 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f700.i2c-bus/i2c-38
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-39 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f800.i2c-bus/i2c-39
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-40 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f900.i2c-bus/i2c-40
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-41 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fa00.i2c-bus/i2c-41
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-42 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fb00.i2c-bus/i2c-42
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-43 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fc00.i2c-bus/i2c-43
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-44 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fd00.i2c-bus/i2c-44
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-45 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fe00.i2c-bus/i2c-45
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-46 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0ff00.i2c-bus/i2c-46
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-47 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c10000.i2c-bus/i2c-47
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-48 -> ../../../devices/platform/soc@14000000/14c21000.i3c1/i2c-48
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-49 -> ../../../devices/platform/soc@14000000/14c23000.i3c3/i2c-49
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-50 -> ../../../devices/platform/soc@14000000/14c25000.i3c5/i2c-50
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-51 -> ../../../devices/platform/soc@14000000/14c27000.i3c7/i2c-51
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-52 -> ../../../devices/platform/soc@14000000/14c29000.i3c9/i2c-52
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-53 -> ../../../devices/platform/soc@14000000/14c2b000.i3c11/i2c-53
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-54 -> ../../../devices/platform/soc@14000000/14c2d000.i3c13/i2c-54
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-55 -> ../../../devices/platform/soc@14000000/14c2f000.i3c15/i2c-55
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-56 -> ../../../devices/platform/ltpi0_bus@30000000/30c21000.i3c1/i2c-56
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-57 -> ../../../devices/platform/ltpi0_bus@30000000/30c23000.i3c3/i2c-57
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-58 -> ../../../devices/platform/ltpi0_bus@30000000/30c25000.i3c5/i2c-58
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-59 -> ../../../devices/platform/ltpi0_bus@30000000/30c27000.i3c7/i2c-59
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-60 -> ../../../devices/platform/ltpi0_bus@30000000/30c29000.i3c9/i2c-60
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-61 -> ../../../devices/platform/ltpi0_bus@30000000/30c2b000.i3c11/i2c-61
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-62 -> ../../../devices/platform/ltpi0_bus@30000000/30c2d000.i3c13/i2c-62
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-63 -> ../../../devices/platform/ltpi0_bus@30000000/30c2f000.i3c15/i2c-63
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-64 -> ../../../devices/platform/ltpi1_bus@50000000/50c21000.i3c1/i2c-64
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-65 -> ../../../devices/platform/ltpi1_bus@50000000/50c23000.i3c3/i2c-65
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-66 -> ../../../devices/platform/ltpi1_bus@50000000/50c25000.i3c5/i2c-66
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-67 -> ../../../devices/platform/ltpi1_bus@50000000/50c27000.i3c7/i2c-67
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-68 -> ../../../devices/platform/ltpi1_bus@50000000/50c29000.i3c9/i2c-68
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-69 -> ../../../devices/platform/ltpi1_bus@50000000/50c2b000.i3c11/i2c-69
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-70 -> ../../../devices/platform/ltpi1_bus@50000000/50c2d000.i3c13/i2c-70
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-71 -> ../../../devices/platform/ltpi1_bus@50000000/50c2f000.i3c15/i2c-71
> lrwxrwxrwx    1 root     root             0 Jan  5 07:24 i2c-8 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0f900.i2c-bus/i2c-8
> 
> As shown above, the real platform incorporates I2C buses via the LTPI (IO expander)
> and even through I3C controllers. Using a consistent i2c-X naming style across the
> model should sufficiently cover these use cases.
> 
>>
>> We would need to modify the bus creation in aspeed_i2c_bus_realize() as
>> follows :
>>
>>        s->bus = i2c_init_bus(dev, NULL);
>>
>> and fix all tests.
> 
> Regarding your suggestion to modify aspeed_i2c_bus_realize() by passing NULL as
> the second argument to i2c_init_bus():
> I have tested this change. It results in the following object hierarchy:
> 
> BMC I2C: /i2c/bus[0]/i2c-bus.0
> IOEXP0 (LTPI0): /ioexp[0]/ioexp-i2c[0]/bus[0]/i2c-bus.16
> IOEXP1 (LTPI1): /ioexp[1]/ioexp-i2c[0]/bus[0]/i2c-bus.32
> 
> By adjusting the I2C object names this way, the naming conflicts are resolved, and
> the automated tests now pass correctly.

Linux doesn’t order the I2C buses in a logical or physical sense. It numbers
them dynamically as adapters are registered. The I3C device will add another
group (SOC, LTPI0, LTP1, I3C) of I2C buses and devices.

So, we need to find a way to distinguish these groups at the QEMU machine
level to add devices on the right bus. Adding a "label" to the I2C bus model
seems to be a step in the right direction. The idea needs time to mature.
Insights are welcome.

Thanks,

C.

