Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B697FEF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHg9-0005YT-Hf; Sun, 08 Feb 2026 22:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vpHg7-0005Wo-Bb
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:11:11 -0500
Received: from mail-japanwestazon11011031.outbound.protection.outlook.com
 ([40.107.74.31] helo=OS0P286CU010.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vpHg4-0000D5-P9
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:11:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2Gn07mWh7OUAqDfqrrXU6nI1VV0W7KNl0NigImdLzxLzhVKkmM7ZXOyFNjQmQMv66emvyvYqE6lOb7+f0aNQ1oyn+DSg6nNK+3rj9VIPhmwULknlpnDG73xqAkAeEq8nsp8ffcUHfiMObc7cujglUS0tJL+Z5njes85J0ZokzKoyY0AuqqpveZ2cGaepfWPYqgsQ9KPifcFwccwHNrNVK5oxkmCzYLkJAEjo0VAqUEOMivJLPvHpCeyM7I9ZxBOn4SRCu6yRQ5M1sUYIZbbKawrdSIx5DMPXpob/2uKSDHLgZkWhhE1pllsb03gnTRnm94cusBU217kAOYS5BE4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EP4hb4jV8lVhliGAKFjPdv6obiauIf/ch0tR/Ajtpg=;
 b=PSEUhCYFRR4t8MGLrQSHfSmB4j4PeebrzvxbnUxMjS5CTxh9HoydzMXvn0YpJ42qD8JXNwaZrlFTmmWspK/KclJarpSlJCbvynr/qtEKBvrTKoetcs9b7LgyRiVC6PixKnEvnkxsmO4wNZXMUkL/pjfSwMcnHrE8FlBq+mW98KaPlSznLMlhbKX3+aZDd8MUnYu8zMXcRljT8Imp7gparhuTmdmXE3R/nIyHQxu4mwqxkNI4dyUk0QCDPQeIv8QNX+8vZ7Yj9s93n1b8sIjW1PuIXC0VoWRgZfFAVPnVSS9sH4c3aeEjCPOP3N6eoiAktJaLNrxeKmeTsJxCScKy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EP4hb4jV8lVhliGAKFjPdv6obiauIf/ch0tR/Ajtpg=;
 b=bLJhWwWInVOvEDXF/Ahw+bwXJiQ+jxYDk5AKXwb1FJEwYcvdWlHFWF9+PpO8jzC7KaPaM9NEjQeisi1bXsl8Mbky/4MoRn1yI8E3kFpUAqMuluB6waEPA7H37RnX7co1W3d1i7pYFGvY3M1XROlkIEMsMUglvgBvDLx7H6xpBnr8Oy9dg7DMgUPIClupopy824YFvaFC4yZSDcNgpHrmwWUlPO40dTEYxMcV+4HqOQD3pGd+Kidll7MYOs42KDsbcdILB/EsNXqicDwMGXPWewTm8ehvjTrPOMXD/GSkf/k9pxVxao3LMF6ZUxLi2Xx67wkydjawQwydz5/+B+x7nw==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by OS3PR01MB9317.jpnprd01.prod.outlook.com
 (2603:1096:604:1c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 03:06:00 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 03:06:00 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "mst@redhat.com"
 <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "ppbonzini@redhat.com" <ppbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@kernel.org" <david@kernel.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "venkataravis@micron.com"
 <venkataravis@micron.com>, "gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH v2 2/2] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Thread-Topic: [PATCH v2 2/2] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Thread-Index: AQHcleceFhae2jAJBkW4/xt4eQkS4LV5tjmA
Date: Mon, 9 Feb 2026 03:06:00 +0000
Message-ID: <ae9d737c-6c2d-4ad1-b40e-62ea0e466696@fujitsu.com>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
 <20260204150002.669-3-alireza.sanaee@huawei.com>
In-Reply-To: <20260204150002.669-3-alireza.sanaee@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|OS3PR01MB9317:EE_
x-ms-office365-filtering-correlation-id: df8428f3-e954-4bfd-b504-08de67882765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YWpJSW9tVnVxcTBmWC9TdjVmQnVxaEE0U0RHMzlKQU9SWEt3cnRnWWIwSmpV?=
 =?utf-8?B?c2VYMTVkcnBYeWhtcWdHMWcvS1lRQVpoZ2h6M2lldzA5eXp6NG91NEF0MDRo?=
 =?utf-8?B?RFNULzN6a0prNGxWd2xMMkVMRDVWZXBzc1YrTkhjODRUSFFqUFlwelljUExV?=
 =?utf-8?B?TEozcXFnM0RnS1NOUndwcm8yV3h0Z0xJTm85aUhQWGVNNVpGc01KTEZTWE9J?=
 =?utf-8?B?K1ZHVjUwN0lUQ1VGSzIvRTYxZjNuTzYyTEtGQzdrei9palUxNEtqbVhoWHYx?=
 =?utf-8?B?dlg2NFZnNWVtMUZ2YmNjMG1LeTlnMlF1QUxUUGQ5TTRDdGlTN1NXbXF3RG5r?=
 =?utf-8?B?YzB0L1lyZTk1a0lWZGJCeFY0OFZ3M0Z3NmFjQXVJdUR3M3NDQXQzbm0wNytj?=
 =?utf-8?B?N2pqQTg5YlJpYkk4UVJYQnRqYkZvVExyK0Y1ekdWcFVQeTBjUnIrQTJTdUFv?=
 =?utf-8?B?QUNSaEpJSmZDbWY2VlVzZFJOVnlUZzdsVFZ0UHVPMGN0RDBpbk92RzFLM1l4?=
 =?utf-8?B?SzcwSTZCNm9xNFc0TkVhamkvWDhpeE43d1JEVmgxdklBTk8vN0NtZXB6RmxU?=
 =?utf-8?B?WDNrdjVjRnFVOG4xYzlaRVN5ZS9MbnM2Z0ErckgzdVFxdkRYVG1hcEhLMENx?=
 =?utf-8?B?em9GeGowcDQxV2NScjIyM0dMRzh1S0NtL1doa0NCNVJjYXpDbG5scTd0OGhV?=
 =?utf-8?B?UXkwaEc5MG9WR1BxdHYwWENDVjhGWkh3eUxCTFJ0dkc3clFSelZUT2FtMVRS?=
 =?utf-8?B?YkhpQ1E3ei83Q0ovN2E2MEExZHZtcENtWGJmdmVneTZ4c0RnOHBsdmF5enFR?=
 =?utf-8?B?NEtySmJ4MXdMUzJtOTU0bDV3L3QwWFhFRWtBeDVwa1hoaWxjQ1ZWdzRUNU1G?=
 =?utf-8?B?VGtxMnFPT1RqSTJKbWduLyt3Mzlua3hsYTBQY2NmL0xNZ3BGT0lOdzBmdmpQ?=
 =?utf-8?B?ejdXL01yVXMva3ZWMWRqWmhOQVhZVUZZRlp0VUg4c3VlS0ZiaUkzM1RpNGpP?=
 =?utf-8?B?R29IRkZPK2g4dDZqcW8ySmtxRTlENUZlV1Q3YVZBYjlHVHpkb3Ywb2lmeVFX?=
 =?utf-8?B?aTN1WmJ2Sjh1cG1uK0R6cW1tUE91NUtuZWdXeldIOExjZ0FlVEZ5SG1qL28y?=
 =?utf-8?B?cVAzK1IxMTRkRjZadzJKdFZ3WGJlY3dkN0hBaGFWQ0VDWlpDQ3UzUDFZcWNi?=
 =?utf-8?B?WmprYkgvRUNqb1BDQ3NXYnBUcFdjdkVRYXI4UGF0akZ5SW1WTkRCeWFoVVlU?=
 =?utf-8?B?SlYrK0N4ZXN4NTA1UlNzL1VkbjhkdVVnbWhlRGJOTEtFMWIrOGlBMDlqbm41?=
 =?utf-8?B?MHpGNkhLWERqNkU4REs3cDJKUlRVWlZVSVBXSXJXT1p6NWZ3NWdNcjhVVVY1?=
 =?utf-8?B?V0Fyb3dVOWl3TjBIN0pVY1BLODlsaWI0QkFoR3hmR3Y2Tmh2czhuMTd1N2tO?=
 =?utf-8?B?T0NHTjNweDRlaFBCYmY5RHlDeHh6YUVCcm8rNlo1WVJWSGd5R0kyUURLdFRo?=
 =?utf-8?B?OTlleGFKNWk2bENTUVJScTZtMUZWR3RPeGV1dnBTa0hsd1JzT0ptbU5GTk5E?=
 =?utf-8?B?R0cvTjJ1UHh2OW1ZaUV1WWhMZytxQW1wbFRFOW0rTmh6N2Jxd3ZaUXFraTd4?=
 =?utf-8?B?N2Z0QngvbFUzcC8vbENidGxmNldjc2g1ZEtST0VPUjF3d3ZmZ2E5T0RoOGJ5?=
 =?utf-8?B?NG81L3ZuaHdxZFVpT2w5RWtlY2NER21oa2Yvc0laZnVzY2ZUMTB3aHUrSHRs?=
 =?utf-8?B?VXNrWUp0VGNTWkxYN2tKaDlZVm9SdHF1SE1lR1F4bk11cUk2bjBDazNtT2xp?=
 =?utf-8?B?b3owU0tlcE5jRUJGNXk2QW1FcVEyMEx4S1JiOC9CZEh4cytocnJPSzBHL2Nr?=
 =?utf-8?B?MUtyeGNlaGwvcmxSMU0vUlZpalh3SHFlVTJPbzQ0dE42UVorZy9GYmVJUmh3?=
 =?utf-8?B?VDNNdHh2alhtZlJOa25qYzV1M2s3VXRPU05yTmZIdHpNRFMwbGl1ZEMwUTVh?=
 =?utf-8?B?OVFCb1RNa2NDVndLUUx6Uko4WjNYbGlLQWQ5VS9UNmdOYUE3azVLN0tSNlVK?=
 =?utf-8?B?SUVwSml3RGplUWdZSmtKdGZudjFObEF3K202Mm93V3NvY2M3c1dZWEhqNEFV?=
 =?utf-8?B?Q04xN0dDUW5ZaHBDc2p0MTI3eGhJT3Rob2VGQXR6bEU3aVUyM3Q0d01hWVlW?=
 =?utf-8?Q?ZPu5KGxGlTU8hErwbudmqzhAxt4H+Ugx2auRhcKCrrQW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzE4N21YNUhyMi9pd0NuU1l5enJBczl0WHk0VjJodDd5NXlpYzg1NWx4ejZk?=
 =?utf-8?B?L3pnaXlnTndPaFA3OWxYRElDMnZ0dk5qd0Z6WG5rejFLK1hyUzRTbngvcTYw?=
 =?utf-8?B?S2VNYXFVREozUFgzLzhmMitUeXFMMXVkbmVjbi92dkI1YkM0TTdPU1MzK1BG?=
 =?utf-8?B?YmszaWtWMWNOdnhMNVNYbmh1ZEV1dVZWREREdGdHSWlpU2s1dWM2ZGhRNW0x?=
 =?utf-8?B?NEJQMGJlMzQ4d3RCTW15bFFtbGNkb1UwQ2ZpbzM0aHBBbG1PMWk2cHZBR2ta?=
 =?utf-8?B?R0tHR3d0NkRmeTg2am9wRlY3anJUWTJQMTcrTndjUGJuUDFIQnFQVkErcEdW?=
 =?utf-8?B?SVk1UmFhcncvNGpRbHpBTFlOVURQaXhlK3RCKzV5bmxLM2dKMVQveGVoVEFk?=
 =?utf-8?B?RUc0Nkppc1E1K0hLMEdaVXA4NCtGMG4wcDVjT3VDQW5tWDNGSVJaRkN6K1N2?=
 =?utf-8?B?WHg3RXV3TVpQbWpOTUlCWmt6dnlYRTlXY3p6SjlYRDRSU2U0YTJYbGxEbkpB?=
 =?utf-8?B?eG5RazM2TDlNdXJBblNybi9SdUpDNDRTYTJLVEEwZnlRVXhnV05PRy9VbENK?=
 =?utf-8?B?K0Z0WFFSY1RjdUE1bnBjTUhDaEtCQ0JYelNXbmg4eWpCeU1yVHpQVC9ZZnA4?=
 =?utf-8?B?dWdRQzJXWElGVTBkOEJxbkRPODlSM0hqcGh6WERpRTZmLytIQzVydXNwZVF0?=
 =?utf-8?B?VitXWmZqRnhTRG51eVlZZ0lzcUw4MmlGdHBEVHl1a0ZVazJ2RzhlRkZPbGY5?=
 =?utf-8?B?MU5sRGhFWVpHYUprRHB0VjZuNVNvQ3FrMWFGRDhacFNrVmljK1NSS3RFWVBt?=
 =?utf-8?B?WEdnK3hkNjVJT1NhUzhzb2hMbldmbjRGRU5uYy9HL041MzlWQnVib3dSdGVw?=
 =?utf-8?B?SllSQ0dWQkhldGU4RkRESDFQWk5TeWhDWkdWOElsN3F0N1QrQitJSnpTYnhM?=
 =?utf-8?B?bmM2amxRT3RiYkdTa3RZRytZVXZrWFVzb0VLM1Z0cXpqeFJ3c3IzRm5HK0x1?=
 =?utf-8?B?MFd4OWk0N0JsTENQa0lxcFZVRmE4NXo1eTdYRzdHcUhxM2lwalVmeFluRTJN?=
 =?utf-8?B?Z1BTdkFwQzd4cVp3ZERKT0VIaC95UFh6aXB4b2RGU2lUZGNueUtxR2Y1M0NN?=
 =?utf-8?B?dVNRZG9jTkRVU3FuZ2dXTDlGV1V6QkNVVXNBV3pjWWRPNCtmeThUT2pIUTgw?=
 =?utf-8?B?WnpnZHQxeFl5d1E1SFo0c29LdzBVYnJtUlp2aVdrUGw5d21XcUtMN2FyQ1pM?=
 =?utf-8?B?VGM2Z2g5QTBqMXJqRmFTK0JDL2R2S1BNMlN0SHFxWmVRK20rcXBpVG1NSURu?=
 =?utf-8?B?YTdhaHBOOGVWbG5reFhtYlg3Z2hRVmFxZTdCLzVNZkFaZHdJaGtrSGlUVlNQ?=
 =?utf-8?B?UDM4dVZyMXJUSml4UXFHTUFkb1laY2o2dVh3T3JXVjIxRzNFZHZUUmN6Um8r?=
 =?utf-8?B?U0dYUmg5S3hEd2g0OWlYKy9vb2g0ZGRjenlXREZaNVpBNjN0TmtES3g3Z0ds?=
 =?utf-8?B?RjVMbEFLNytXYmZzcm1CWWlGQS9sRS9JMmtFanl2bXVWemFTOGZMZzNMbWZx?=
 =?utf-8?B?UHc1VjI1aytvVHN6WDgrdXdUdE9JcWVFMjBUcUVQUWhaeloyNnVHSTJCMVR0?=
 =?utf-8?B?cVNCRld0a2h3ZDBrbTBPUmJKWFhBY0FxQW1VVFV3bWFVbjlUZURQRE9GTE1q?=
 =?utf-8?B?QmtLYW50N1ZHbFNTK1FNUnF5R1VHVU5zN2t0N1hBT2RzMVhVak5KZFlZKzUy?=
 =?utf-8?B?ZVEwcVgrSVQxS3J0a2hSaUd5WXc0eU9TNzZQTDdTN0pyN0E2WGIvOWlYUTNL?=
 =?utf-8?B?dE55OVpTZ1FHenFxNXkxVEZ1YzMrV09LVXdKS3Q0R2JpU1BXNHJtUFRkTWZQ?=
 =?utf-8?B?S1VmL2ZOR0Q4c2R2eCtMYVlKSlZJaGtMS1ZUVVZMS2xFWTNxY3hScTZqb1Bi?=
 =?utf-8?B?d0dxazMvQ2k3bS9JbW50R3krRkVwaGlKZnlLaDdUKzcwU240NXFQSjFINnFW?=
 =?utf-8?B?dVlUOG16SEVnaHVGdHBxS1JhN01IR0VrMWJ2SzVGQ08xSk9RdVlHbjFVZ1M3?=
 =?utf-8?B?UGt4VnVIL3JjbUtUcUNxQ1lMaVRKZFkvQ05iTDgxS1BaVGt5OWh1T0FmaFA3?=
 =?utf-8?B?SFVhb2h2azlLTUlrVWdxNlB0MXN0MHk3Njh1cElOQm1ucGdacWJ6UE8zYUVo?=
 =?utf-8?B?NzNSUmxUSFF4RGY0QmlZRjBORXZaQTllMy95a0lJRVU2b1NxRktFc29acEha?=
 =?utf-8?B?aXNqOHB2VXExQllCejMrVjZhYTJEWDBicXg3REJQaWhldzVienRXVHp2aDUr?=
 =?utf-8?B?Qi9Fb1VxRXJSU0Fidk9RQmV0WXkrY0RTS2NOT2NvbVdYTlFxNHpJU2lNT0hn?=
 =?utf-8?Q?YU6Htlryr7+485k4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEE8FB3B456F3C449C3C2BE82266F261@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8428f3-e954-4bfd-b504-08de67882765
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 03:06:00.6996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8fnukDx5w/opiTJ5xKcsEq0mRbMSn8ErbkcCV00eyRT+i6xfEElycqbFZJ9LrbvouG62pfCy+5XoUTA4CfaCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9317
Received-SPF: pass client-ip=40.107.74.31; envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU010.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDA0LzAyLzIwMjYgMjM6MDAsIEFsaXJlemEgU2FuYWVlIHdyb3RlOg0KPiBUaGUgQ1hM
IGFkZHJlc3MgdG8gZGV2aWNlIGRlY29kaW5nIGxvZ2ljIGlzIGNvbXBsZXggYmVjYXVzZSBvZiB0
aGUgbmVlZA0KPiB0byBjb3JyZWN0bHkgZGVjb2RlIGZpbmUgZ3JhaW5lZCBpbnRlcmxlYXZlLiBU
aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbg0KPiBwcmV2ZW50cyB1c2Ugd2l0aCBLVk0gd2hlcmUg
ZXhlY3V0ZWQgaW5zdHJ1Y3Rpb25zIG1heSByZXNpZGUgaW4gdGhhdA0KPiBtZW1vcnkgYW5kIGdp
dmVzIHZlcnkgc2xvdyBwZXJmb3JtYW5jZSBldmVuIGluIFRDRy4NCg0KDQpEbyB5b3UgbWVhbiBL
Vk0gd2lsbCB3b3JrIGFmdGVyIHRoaXMgcGF0Y2ggaW4gMS13YXkgY2FzZQ0KDQoNCj4gDQo+IElu
IG1hbnkgcmVhbCBjYXNlcyBub24gaW50ZXJsZWF2ZWQgbWVtb3J5IGNvbmZpZ3VyYXRpb25zIGFy
ZSB1c2VmdWwgYW5kDQo+IGZvciB0aG9zZSB3ZSBjYW4gdXNlIGEgbW9yZSBjb252ZW50aW9uYWwg
bWVtb3J5IHJlZ2lvbiBhbGlhcyBhbGxvd2luZw0KPiBzaW1pbGFyIHBlcmZvcm1hbmNlIHRvIG90
aGVyIG1lbW9yeSBpbiB0aGUgc3lzdGVtLg0KDQoNCkRvIHlvdSBoYXZlIGFueSBiZW5jaG1hcmsg
ZGF0YSB0byBkZW1vbnN0cmF0ZSB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQ/DQoNCg0KDQo+
IA0KPiBDby1kZXZlbG9wZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlyZXphIFNhbmFlZSA8YWxp
cmV6YS5zYW5hZWVAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICAgaHcvY3hsL2N4bC1jb21wb25lbnQt
dXRpbHMuYyB8ICAgOCArKw0KPiAgIGh3L2N4bC9jeGwtaG9zdC5jICAgICAgICAgICAgfCAxOTcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gICBody9tZW0vY3hsX3R5cGUz
LmMgICAgICAgICAgIHwgICA0ICsNCj4gICBpbmNsdWRlL2h3L2N4bC9jeGwuaCAgICAgICAgIHwg
ICAxICsNCj4gICBpbmNsdWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggIHwgICAxICsNCj4gICA1IGZp
bGVzIGNoYW5nZWQsIDIwNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2h3L2N4bC9jeGwtY29tcG9uZW50LXV0aWxzLmMgYi9ody9jeGwvY3hsLWNvbXBv
bmVudC11dGlscy5jDQo+IGluZGV4IGQzNjE2MmU5MWIuLmQ0NTlkMDRiNmQgMTAwNjQ0DQo+IC0t
LSBhL2h3L2N4bC9jeGwtY29tcG9uZW50LXV0aWxzLmMNCj4gKysrIGIvaHcvY3hsL2N4bC1jb21w
b25lbnQtdXRpbHMuYw0KPiBAQCAtMTQyLDYgKzE0MiwxNCBAQCBzdGF0aWMgdm9pZCBkdW1iX2hk
bV9oYW5kbGVyKENYTENvbXBvbmVudFN0YXRlICpjeGxfY3N0YXRlLCBod2FkZHIgb2Zmc2V0LA0K
PiAgICAgICAgICAgdmFsdWUgPSBGSUVMRF9EUDMyKHZhbHVlLCBDWExfSERNX0RFQ09ERVIwX0NU
UkwsIENPTU1JVFRFRCwgMCk7DQo+ICAgICAgIH0NCj4gICAgICAgc3RsX2xlX3AoKHVpbnQ4X3Qg
KiljYWNoZV9tZW0gKyBvZmZzZXQsIHZhbHVlKTsNCj4gKw0KPiArICAgIGlmIChzaG91bGRfY29t
bWl0KSB7DQo+ICsgICAgICAgIGNmbXdzX3VwZGF0ZV9ub25faW50ZXJsZWF2ZWQodHJ1ZSk7DQo+
ICsgICAgfQ0KPiArDQo+ICsgICAgaWYgKHNob3VsZF91bmNvbW1pdCkgew0KPiArICAgICAgICBj
Zm13c191cGRhdGVfbm9uX2ludGVybGVhdmVkKGZhbHNlKTsNCj4gKyAgICB9DQoNCg0KVGhpcyBt
aWdodCBiZSBzbGlnaHRseSBiZXR0ZXIgYXMgYW4gaWYtZWxzZSBibG9jaywgc2luY2Ugc2hvdWxk
X2NvbW1pdCBhbmQgc2hvdWxkX3VuY29tbWl0IGFyZSBtdXR1YWxseSBleGNsdXNpdmU6DQoNCg0K
aWYgKHNob3VsZF9jb21taXQpIHsNCgljZm13c191cGRhdGVfbm9uX2ludGVybGVhdmVkKHRydWUp
OzsNCn0gZWxzZSBpZiAoc2hvdWxkX3VuY29tbWl0KSB7DQoJY2Ztd3NfdXBkYXRlX25vbl9pbnRl
cmxlYXZlZChmYWxzZSk7DQp9DQoNCg0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBiaV9o
YW5kbGVyKENYTENvbXBvbmVudFN0YXRlICpjeGxfY3N0YXRlLCBod2FkZHIgb2Zmc2V0LA0KPiBk
aWZmIC0tZ2l0IGEvaHcvY3hsL2N4bC1ob3N0LmMgYi9ody9jeGwvY3hsLWhvc3QuYw0KPiBpbmRl
eCA5NjMzYjAxYWJmLi4xZmNmZTAxMTY0IDEwMDY0NA0KPiAtLS0gYS9ody9jeGwvY3hsLWhvc3Qu
Yw0KPiArKysgYi9ody9jeGwvY3hsLWhvc3QuYw0KPiBAQCAtMTA0LDcgKzEwNCw3IEBAIHZvaWQg
Y3hsX2Ztd3NfbGlua190YXJnZXRzKEVycm9yICoqZXJycCkNCj4gICB9DQo+ICAgDQo+ICAgc3Rh
dGljIGJvb2wgY3hsX2hkbV9maW5kX3RhcmdldCh1aW50MzJfdCAqY2FjaGVfbWVtLCBod2FkZHIg
YWRkciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqdGFyZ2V0
KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90ICp0YXJnZXQsIGJv
b2wgKmludGVybGVhdmVkKQ0KPiAgIHsNCj4gICAgICAgaW50IGhkbV9pbmMgPSBSX0NYTF9IRE1f
REVDT0RFUjFfQkFTRV9MTyAtIFJfQ1hMX0hETV9ERUNPREVSMF9CQVNFX0xPOw0KPiAgICAgICB1
bnNpZ25lZCBpbnQgaGRtX2NvdW50Ow0KPiBAQCAtMTM4LDYgKzEzOCwxMSBAQCBzdGF0aWMgYm9v
bCBjeGxfaGRtX2ZpbmRfdGFyZ2V0KHVpbnQzMl90ICpjYWNoZV9tZW0sIGh3YWRkciBhZGRyLA0K
PiAgICAgICAgICAgZm91bmQgPSB0cnVlOw0KPiAgICAgICAgICAgaWdfZW5jID0gRklFTERfRVgz
MihjdHJsLCBDWExfSERNX0RFQ09ERVIwX0NUUkwsIElHKTsNCj4gICAgICAgICAgIGl3X2VuYyA9
IEZJRUxEX0VYMzIoY3RybCwgQ1hMX0hETV9ERUNPREVSMF9DVFJMLCBJVyk7DQo+ICsNCj4gKyAg
ICAgICAgaWYgKGludGVybGVhdmVkKSB7DQo+ICsgICAgICAgICAgICAqaW50ZXJsZWF2ZWQgPSBp
d19lbmMgIT0gMDsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgICB0YXJnZXRfaWR4ID0g
KGFkZHIgLyBjeGxfZGVjb2RlX2lnKGlnX2VuYykpICUgKDEgPDwgaXdfZW5jKTsNCj4gICANCj4g
ICAgICAgICAgIGlmICh0YXJnZXRfaWR4IDwgNCkgew0KPiBAQCAtMTU3LDcgKzE2Miw4IEBAIHN0
YXRpYyBib29sIGN4bF9oZG1fZmluZF90YXJnZXQodWludDMyX3QgKmNhY2hlX21lbSwgaHdhZGRy
IGFkZHIsDQo+ICAgICAgIHJldHVybiBmb3VuZDsNCg0KWy4uLl0NCg0KPiArDQo+ICtzdGF0aWMg
aW50IHVwZGF0ZV9ub25faW50ZXJsZWF2ZWQoT2JqZWN0ICpvYmosIHZvaWQgKm9wYXF1ZSkNCj4g
K3sNCj4gKyAgICBjb25zdCBpbnQgaGRtX2luYyA9IFJfQ1hMX0hETV9ERUNPREVSMV9CQVNFX0xP
IC0gUl9DWExfSERNX0RFQ09ERVIwX0JBU0VfTE87DQo+ICsgICAgYm9vbCBjb21taXQgPSAqKGJv
b2wgKilvcGFxdWU7DQo+ICsgICAgQ1hMVHlwZTNEZXYgKmN0M2Q7DQo+ICsgICAgdWludDMyX3Qg
KmNhY2hlX21lbTsNCj4gKyAgICB1bnNpZ25lZCBpbnQgaGRtX2NvdW50LCBpOw0KPiArICAgIHVp
bnQzMl90IGNhcDsNCj4gKyAgICB1aW50NjRfdCBkcGFfYmFzZSA9IDA7DQo+ICsNCj4gKyAgICBp
ZiAoIW9iamVjdF9keW5hbWljX2Nhc3Qob2JqLCBUWVBFX0NYTF9UWVBFMykpIHsNCj4gKyAgICAg
ICAgcmV0dXJuIDA7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgY3QzZCA9IENYTF9UWVBFMyhvYmop
Ow0KPiArICAgIGNhY2hlX21lbSA9IGN0M2QtPmN4bF9jc3RhdGUuY3JiLmNhY2hlX21lbV9yZWdp
c3RlcnM7DQo+ICsgICAgY2FwID0gbGRsX2xlX3AoY2FjaGVfbWVtICsgUl9DWExfSERNX0RFQ09E
RVJfQ0FQQUJJTElUWSk7DQo+ICsgICAgaGRtX2NvdW50ID0gY3hsX2RlY29kZXJfY291bnRfZGVj
KEZJRUxEX0VYMzIoY2FwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIENYTF9IRE1fREVDT0RFUl9DQVBBQklMSVRZLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERFQ09ERVJfQ09VTlQpKTsNCj4g
KyAgICAvKg0KPiArICAgICAqIFdhbGsgdGhlIGRlY29kZXJzIGFuZCBmaW5kIGFueSBjb21taXR0
ZWQgd2l0aCBpdyBzZXQgdG8gMA0KPiArICAgICAqIChub24gaW50ZXJsZWF2ZWQpLg0KPiArICAg
ICAqLw0KPiArICAgIGZvciAoaSA9IDA7IGkgPCBoZG1fY291bnQ7IGkrKykgew0KPiArICAgICAg
ICB1aW50NjRfdCBkZWNvZGVyX2Jhc2UsIGRlY29kZXJfc2l6ZSwgc2tpcDsNCj4gKyAgICAgICAg
dWludDMyX3QgaGRtX2N0cmwsIGxvdywgaGlnaDsNCj4gKyAgICAgICAgaW50IGl3LCBjb21taXR0
ZWQ7DQo+ICsNCj4gKyAgICAgICAgaGRtX2N0cmwgPSBsZGxfbGVfcChjYWNoZV9tZW0gKyBSX0NY
TF9IRE1fREVDT0RFUjBfQ1RSTCArIGkgKiBoZG1faW5jKTsNCj4gKyAgICAgICAgY29tbWl0dGVk
ID0gRklFTERfRVgzMihoZG1fY3RybCwgQ1hMX0hETV9ERUNPREVSMF9DVFJMLCBDT01NSVRURUQp
Ow0KPiArICAgICAgICBpZiAoY29tbWl0IF4gY29tbWl0dGVkKSB7DQoNCg0KSXMgdGhlcmUgYW55
IHNwZWNpZmljIHJlYXNvbiBmb3IgdXNpbmcgXiBoZXJlIGluc3RlYWQgb2YgJz09JyA/DQoNCg0K
DQpUaGFua3MNClpoaWppYW4=

