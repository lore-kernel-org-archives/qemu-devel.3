Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4B6FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRR-0001VL-A9; Sun, 03 May 2026 22:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRN-0001UJ-Ca; Sun, 03 May 2026 22:53:49 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRL-0003sY-Cb; Sun, 03 May 2026 22:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkGYDa01JYgwF2zBCCOrIcuMoFoWJgobqyPxIk+cBM2sZBS86v8nay91Bl5EBY0+i1iVBrpriEEU1nmAqtPogNFmsYp/sxN3ZP4c/uiqM4S8BiYI3EDxBw8ZV1yVPB3ePtvbLXc6MyEhkb1m5Ltp6vmkTSrq8+g06NQ7O62ymPpl0LtxfWM1jkR0QlSfTpEgLCMPG2FXZcE8OqVwVtESscG4rNKPhvEpq/2ryNCudNijPG9xkSob71zv8q8sYJu2Llpb5xe0nCoSqUsUgBc3u8cmOwLXJQp7UTbZiO81diV/GHCUPd51zokfE9hmLh8qGsn1wd+1QYiIJemxThk6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RwrBGyo26gTGVOt8h6JNOv3unFpJQhYuOsUO94LgXU=;
 b=OP6NRzEjR7EKm0IKzXGia7ic2WwQ4DIJLQ6BpuDxRXRUGOylU2lQOQdpK+rkctNWw3xRqNTe6qCttH2kQdxiPj4n7NjiG1oHOX4uyG+wt7CIXZJLbd4NV8PfahdpUFjsejj7oF5MWicLlMugESuHdmIQN5WGs+1jJ5dBHApzJA9fFyFPT2+Pgdv9SJm90w785ww+gYLFZ7uHK6/DRvrMUCoMMFjWNRrkv0EREJbI93JSSmKIAF9FI6u7NMUBKsaAlgfGMeKx9opvphK4MNxdy3NVtGmFdg9OYX5oOHq4Hjv/o0RqHYQu9asg1tzyOd30ABQQXSUToqYIzEnjn/Lz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RwrBGyo26gTGVOt8h6JNOv3unFpJQhYuOsUO94LgXU=;
 b=eddJmc8S+2YYzExfsdePf2CnUMA/IT+kNbElVL7qS9agdklzjjEoslYvwlyFr21iyISzHhC2TMRhZWkeorXnjz0vP51Q26c8toPXZjTwt4K40ZVugrWmxdGrsIvEvIxf40wrynzE+9CpPY7nNKKT05B89cfgenQ0Q2ZVNtw2JmVZCDwHjBM+N6/42lV7m4U+wjDSGYEqH4gPwyQ0Hgou1X2FiKODIHXtZuFqULAT3TpUlrYA5KSDZPIrLrE19/1mowxd5mOQ5/27++y46qinJHxgBAw4gkFFfYR7btGH9itccSYR70rjBJBIveQccI0zfTcJR/eR+qj+x3iul36TLw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYUPR06MB6098.apcprd06.prod.outlook.com (2603:1096:400:358::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHc23E4Zae50w4sSUmC3BP0jFUSeA==
Date: Mon, 4 May 2026 02:53:43 +0000
Message-ID: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYUPR06MB6098:EE_
x-ms-office365-filtering-correlation-id: 502d2074-642a-4594-6c0b-08dea9885aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info: xZ5jdS/KwfQtCp1gE3pnrU8HPDhSGzfnIAVWM7JUltQZZJc/ahvXn1BA2M/39iHar3i0rsKRsVksuv5EYpt6Ke0nvltVMtiZ6TMceToeIHMvLNsodLaPjgJQw0CbSm/o2ZkCx4AzBDxO939kQd/8DQv0gAaQ2ke/9bS2bEbloESCyAgYRr6c/dQ68QGoFnNsx8wvDZSMDLI+j8J89w8p+eZIojm7NfvKaSpq0XJMAMGfENexQ/qImJnDO5FhEA/hd41lKyDTCmY+zsNoBTpEYpmNMlKcnC7dNB+gn4sy5j4VLDruUg4kI48cVuv0wANqAihWOFKsxbwDktFEq8gVH9rjTjOWrqaBJcQgWD91P6hYqs53aw8gVtb68Zcs1Whh5wP9f+rj1r1ZM3FEUKadgVhUdUJFXwVDRD9E2DB0ud3lZVIKiZBsHtSiw6S30fSxjgzhglh2ARgbV+gOsiqByiO+bl1Cy1p2oAacWsYvQ4+lOOr6/Jl5PuZTb1j4EKvN6FEF9fSc7ziz0VVwZBMx8PqsoT8np7R2vr3FoklmYTiTHwrJdQDDUrz8K+ekyWq6L4Hj6YiJ87zi2n6JGk5/pChSxEsdMG+CV4Jh3t30V6wisEY6IeZgsUz4kyVoE3Rqo3VS1O0WadOFTwaY68cc+xjcfb26QpPey0oLXrtiBAxyRYFsYkpQOEQ+MB7wf7ioAIxrnKqkpc35TaOpDAFvxyi34wPynBtCnrzdNNtxXDicyyMxX8glh3Xzg/zqMpSLHAwKeLrxLkXfqaIeLc4o0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NUb8tyTDSAL+yEx9gaW9ISs7OQ6zOOFfleMbyWbrgquKKogowynvyRVsdt?=
 =?iso-8859-1?Q?cJhzh1I6ff11tBPlwt6XBB6UD/9FAVq1UzMiG8mUKOMM6YPtp+VxeSASOA?=
 =?iso-8859-1?Q?osW+ewF1aBH2mA/QKyjAqBpnH10D2IIrOVNoTBRwwvLLlXwkjszXf05Uqa?=
 =?iso-8859-1?Q?FF9G0Vs7jnjAh6chx5Wzda9JNCOtjr1OJVqmOGKu4OIdVrhJ1MvadDY2sr?=
 =?iso-8859-1?Q?8e4JFK8kHn0692mLGxtDVev/gszdSkVwwiYoIgcckNvZLgXNMzTeUbPEWc?=
 =?iso-8859-1?Q?QPruW0NQ/hrpO4xPJjqcpHGhDfs/SD/3bka7/qh7aAqeZ3jAhvlR9Y/fy7?=
 =?iso-8859-1?Q?qSb/B+77AiHicKSEPsypr5Ga5voM6K2VZlw0QSSSfJdw8+o0vtchTl26a6?=
 =?iso-8859-1?Q?rmXKG1gYKR9buTMDAsl0g0lgYq0MHSL0hIml7amp0RqOFdhU2INIwMAIiZ?=
 =?iso-8859-1?Q?tGX1BM0R1CjyUywQjBxKOaxvWeUuUE1sNDS9tXHiN3Z/dhEw9F1odP3E/S?=
 =?iso-8859-1?Q?+SG8AfoWAdpNNPJz3qKnmQyUhnxHzAUnmY2CrIHp3ZbZuBxwEIh+BhXonW?=
 =?iso-8859-1?Q?JF3yP0mgeYhdN9So3L2I07MBKPWsslTODVryferTgxTtWuALY+xmcwctwM?=
 =?iso-8859-1?Q?tK7NJ15PjhY32G91G/x50imnyga5xbOG/ScUOvmmX9X0h/EbsD6wZTA3Gz?=
 =?iso-8859-1?Q?6ho8rxLcQrIMdwn1MkMkJ5G3fwtzSEpxiIFGqBYBYvyGLicJdQkqlyFFqY?=
 =?iso-8859-1?Q?EPHs35pwsv1NiMAcMWoMa2msycnfSFXDa2x0jIqZMGLY3GqcVErFY58HG9?=
 =?iso-8859-1?Q?lFZZvMiuE1d4/S/ObNx+PSzoRxm52YPRSmDsbOCc7Z5yu0JQX43DS4zbN1?=
 =?iso-8859-1?Q?hk3MfV4LhpuPj31tBu/r96opjyRw9qz+MJSMwOz6CECqtz7LeKjay0fowo?=
 =?iso-8859-1?Q?4GVJmbZnyl0NeQ3hcF5ppIiImxtjNlvK3Q6HoMJ6RNcMZMjbaUm2kp0ihE?=
 =?iso-8859-1?Q?tDpmcw8pB9zfd/W2KwiL5O7LXn7pFhOxuGyJfVjr8FaaWiT6ZEoSCGlFtk?=
 =?iso-8859-1?Q?FfTmQ5FXtFIMkuv3h94Q7nfa76ImmZZC/pzklRwYzQ+P105azIaYJO90QW?=
 =?iso-8859-1?Q?wlXOknhOm7lHwgrJL2FrdVuiSl85NmlGU9+wc7VR3R2Q97UO+ySBTbFIXK?=
 =?iso-8859-1?Q?aYZsQuNhkCXCVJr3uQ84WNcWPtJRzuDAEL/msA63y2qatxuRSEItpsMqzS?=
 =?iso-8859-1?Q?LYqxyu/vj7YYKWlgISs8xhCWMQNSDevPjzDDlZCdWxHUewEfRZL7iffnHy?=
 =?iso-8859-1?Q?QwIl9TiuqvBif6HizSUGLj9h4QXxf/YqWfC1EwbuRwCRxRZMZn0UPMyJvU?=
 =?iso-8859-1?Q?j/JRRKL1q8kVaFVSTTVBWs3qS/lNj89tJdZi8sUfiVzdhoJvV6tzP6poVj?=
 =?iso-8859-1?Q?1DotkT8lscBP8XlaOOt0ydB5wJzfQbp8TtQp8CAPKvFSq3SXI0b5f6MZbm?=
 =?iso-8859-1?Q?kRd2WWTs7HEBqW8RvURnDssxshOW60Laq8d/GxgLZqB6ViRAIY4kZtvMr/?=
 =?iso-8859-1?Q?JrKsg6GCKYiB6t62/KEjpziuyKpN4pK59T8qA6oxgtOgcaWdXJK81gKksY?=
 =?iso-8859-1?Q?VQbKV6yL8vWnZwD5jlua3UNArnuVTQOhPpaa25XVm98RubCNbBzlU0DBzt?=
 =?iso-8859-1?Q?6dQSZTeu0mZPHhj/2eA2cmgYd1EBOi0ZBDYNrzw9hHpbW1Kr4XZBe02UDm?=
 =?iso-8859-1?Q?4rcOP5P4ldRyijXC6C9eCt7RXfAtGyZXnwi5/HjbS2YTarYpuU+UXO++yz?=
 =?iso-8859-1?Q?esk0ZaDgfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mDjKe4IalHV8ZQ6c/FNIPtPYeOE8WwYCoXGRVncatixTXn/vsNJRhMba5kKUdeC1Amlf459hnQyA0FvVZXfocuo24b8E+sZmrVvEfhVaKMHd6nfjbLHRB77ROr2LX/w3ikoz5aQ7g9Lh4l6HEkC1s4eWM3McDpABO99ixAQVwAG0jFeLU7yre1BJK0t27M2P8Bjo2J0BTg5EVN0DyJg5BK59Ic3m/dfnGvN0pcwViptMjcoME+FTu6WcvGlGPT7dpNxvFwplt9JuItyxxkyKqwqYoue0qQfyZfoXSOIpeUtdOStu0d2xy9mbkEGwzGTqX3l/B5h5zHk/RaTbkVl9rw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502d2074-642a-4594-6c0b-08dea9885aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:43.4508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tY1d/Jlr2pa0IezfteCBX0IllAWvHWuItMEgi6ztLK8NTfyMzJjq/CH/evMhEMRndoMYEnmrTCVfGbeoB7iIMW4fHbn7Rlc2nbEoicu46wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6098
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,=0A=
which provides the upper 32 bits of descriptor addresses when the=0A=
controller advertises 64-bit capability.=0A=
=0A=
Currently QEMU EHCI model only partially supports this functionality and=0A=
descriptor addresses are effectively treated as 32-bit. This becomes=0A=
problematic on systems where system memory is located above the 4GB=0A=
boundary.=0A=
=0A=
The Linux EHCI driver enables 64-bit addressing if the controller=0A=
advertises the capability. During initialization it programs the=0A=
segment register to zero:=0A=
=0A=
  https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
#L600=0A=
=0A=
The driver also notes that descriptor structures allocated from the=0A=
DMA pool use segment zero semantics. Descriptor memory is allocated=0A=
using the DMA API and platforms may configure a 64-bit DMA mask,=0A=
allowing descriptor memory to be placed above 4GB.=0A=
=0A=
On AST2700 platforms, system DRAM is mapped at 0x400000000. As a=0A=
result, descriptor addresses constructed directly from the EHCI=0A=
registers do not match the actual system addresses used by the=0A=
controller when accessing queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
This patch series implements full 64-bit descriptor addressing support=0A=
in the EHCI emulation. Descriptor address handling is updated to use=0A=
64-bit values and the descriptor structures (QH, qTD, iTD and siTD)=0A=
are extended to support the upper address bits provided by the segment=0A=
register.=0A=
=0A=
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
=0A=
The AST2700 machine uses this property to account for its DRAM mapping=0A=
at 0x400000000 and enables 64-bit EHCI DMA addressing.=0A=
=0A=
Test Result:=0A=
1. EHCI 32bits with ast2600-evb machine=0A=
Command line:=0A=
./build/qemu-system-arm \=0A=
  -machine ast2600-evb \=0A=
  -m 1G \=0A=
  -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw \=0A=
  -nographic \=0A=
  -device usb-kbd,bus=3Dusb-bus.1,id=3Dmykbd \=0A=
  -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
  -device usb-storage,bus=3Dusb-bus.1,id=3Dmystorage,drive=3Dusbdisk=0A=
  -snapshot \=0A=
  -nographic=0A=
Result:=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-=
v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller=0A=
Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_=
hcd Generic UHCI Host Controller=0A=
=0A=
2. EHCI 64bits with ast2700a2-evb machine=0A=
Command line:=0A=
./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\=0A=
 -bios ast27x0_bootrom.bin \=0A=
 -drive file=3Dimage-bmc,format=3Draw,if=3Dmtd \=0A=
 -snapshot \=0A=
 -device usb-kbd,bus=3Dusb-bus.3,id=3Dmykbd \=0A=
 -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
 -device usb-storage,bus=3Dusb-bus.3,id=3Dmystorage,drive=3Dusbdisk=0A=
Result:=0A=
root@ast2700-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-=
v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_=
hcd EHCI Host Controller=0A=
Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
 =0A=
v1=0A=
 1. Fix checkpatch coding style issues=0A=
 2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors=0A=
 3. Add descriptor address offset property=0A=
 4. Enable 64-bit EHCI DMA addressing on AST2700=0A=
 5. Configure descriptor address offset for AST2700=0A=
=0A=
v2=0A=
 1. Remove unused EHCIfstn structure and dead code=0A=
 2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)=0A=
 3. Replace DPRINTF debug logs with trace events=0A=
 4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2=0A=
 5. Fix review issue=0A=
=0A=
v3:=0A=
 1. Add Migration version test function=0A=
 2. Add EHCI 64-bit buffer pointer fields description in commit log=0A=
=0A=
v4:=0A=
 1. Reorder patches in the series=0A=
 2. Fix EHCI migration issues=0A=
 3. Introduce a common properties macro for both sysbus and PCI=0A=
 4. Drop the descriptor address offset property=0A=
 5. Add ctrldssegment-default property=0A=
 6. Address review comments=0A=
=0A=
v5:=0A=
 1. Add 11.0 machine compatibility properties=0A=
=0A=
v6:=0A=
 1. Update reviewer suggested improvements.=0A=
  =0A=
Jamin Lin (11):=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for=0A=
    AST2600 SDK=0A=
  hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration=0A=
    compatibility=0A=
  hw/usb/hcd-ehci: Add property to advertise 64-bit addressing=0A=
    capability=0A=
  hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Add ctrldssegment-default property=0A=
  hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default=0A=
  hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for=0A=
    AST2700 A1/A2=0A=
=0A=
 hw/usb/hcd-ehci.h                             |  29 +++-=0A=
 hw/arm/aspeed_ast27x0.c                       |   5 +=0A=
 hw/core/machine.c                             |   5 +-=0A=
 hw/usb/hcd-ehci.c                             | 162 +++++++++++++-----=0A=
 hw/usb/trace-events                           |  26 +--=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   7 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   7 +=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +=0A=
 8 files changed, 185 insertions(+), 63 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

