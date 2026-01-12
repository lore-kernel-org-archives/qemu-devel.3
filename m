Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C11ED25050
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 08:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDYR-0004px-CL; Mon, 12 Jan 2026 03:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfDYJ-0004kk-SN; Mon, 12 Jan 2026 03:45:31 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfDYI-000295-35; Mon, 12 Jan 2026 03:45:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqvoqAjFvd/zeKyrYb5/wRMX9R1hO32QVzpudu93h4HrxJf4MW8xxwUIPsPCITUl6yH4JB2rkcERwzRDieGICcpUU1i6uSm7Q5Wnl3fJ9xD912rAGGtU77nbDUdnonVWIflA3kw+truvtTpa1lpNQDAs+5BCzJUjkerAMrtoNluwLCF4EzDL+5ZUQlYO2K6IrS1ctC5/MEDwrMuDG1UF9HC44aubalN9+c68JeUAR6pBhQsLS3+sPTypoWa9q7+AFKNpm+XYZcxfCjc1LRgknHpdAw1g/LicUc3FjXE4ZO/GRdNqmg1cCpMC2kBhkSGc28Qs1gM/W6GIWzzJHBKsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLZRRtO2lHGCVJyzzVhkDMHq7VyzRKjM0bwqyWBb124=;
 b=aDH1eVSdrqiAUM0PUGjs7xmRoQFJ6zISVjVXPjAhxEbxPpIN49qukUqvklSK+CKCOLQWFtaM4JUNTTYqA+f1KqqXzL12ewprUi0dvilehMX/KX4UrWzNS2vtlFS7ujalVpxkAvV8ifEAG4cHxGAF70DuqBl42Eabtt4/HCA0iJguJzGxvY8mGAxnLGty0Say005sXlfyQn8AsDFQ/kxv2y6yoZ4lhSbAQ5u+1Tt5V0b5Vu5Z+2tYbx7oIlOI3ayJ9DJd28GrvSjL8eZ4+KyJM0eIgHXhBYeMfKxRQJCAW9+Y43KqHOKnTnjJqfDMZIuouJcL2wRqVZCrpV3WOMXj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLZRRtO2lHGCVJyzzVhkDMHq7VyzRKjM0bwqyWBb124=;
 b=mn34VK2yOt1Y7UMj2XMPyDc2aNqDEFKHChQl+tjh9T/T20gZyMNdyCwXyk/rYQ2Oyl3Gu66nkvPpGWMSlORRNR63VWY5TrpUlG9aZ6LCClSHIyUS0eHrhmqV4OE2dS5CNpvq97c0NXdChY05fwsFlMzLgQlVQjPyqHbrTla7SwvoB+9H066Ik5JeKaLsexeCCJMTMAVCysI+cbNN7MFDhP7BAvYpkP5nR9HVgpsWZSepZ1rMy/CsOjWYI6mvKxJ+XtQzV+pgq0995t3RnrY0Hb9Zia0pjIQLFADvNBm3Kj/zKug5ygCW12oq/sSq/L7h88gBF1uN19JB1T9E9DZtKA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:45:24 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 08:45:24 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOCAAYu5AIAARN1QgAPxowCAAGXKAA==
Date: Mon, 12 Jan 2026 08:45:23 +0000
Message-ID: <CH3PR12MB754866E17D778C5836903444AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB913696E604E31C678F7083979281A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913696E604E31C678F7083979281A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB9517:EE_
x-ms-office365-filtering-correlation-id: 6daa74ff-e2ba-43f2-d0ac-08de51b6ed4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z2Y5SkpLbEpoZkJIWTU4ODVSZmZ6SWhMR0p5cWN2ZE9FQi9uR1lER1RCczVE?=
 =?utf-8?B?Vk0vUUJnWk9jbW9oQmZvYjlZcDF1WlVnbTJuazBNYUJMOEpkbTVPSmJjVnUw?=
 =?utf-8?B?Z0l3eGRBWVgxNm44Z1JMYWpuRlRCeFFWRkpsbUpVWDlURjN5VFN4eFA3UTdM?=
 =?utf-8?B?dmtLT3pZcG1jdGVZQkl1T2VnNXBHVHE5ZDhwTE1CNXFyZ043d1l6enZwT3Yr?=
 =?utf-8?B?SWJTVnc3MVRvaWVOd3c5VDZFcGliT1Baakt3MVRweVlpZUdXMFNwaU5pVmhK?=
 =?utf-8?B?MXZnRW1hVCs3VnpoTmFkWGk5VkZac1NTc3ZXakdmeCtJc1ZOamluY1dGbFZp?=
 =?utf-8?B?ckZjMGVMdlA3VHA1MTVWWkxBTVVjZjJZSjhtTDFMNTFoOUhZY2IrMWVzdFRR?=
 =?utf-8?B?RVB2UTVJUk16ZENwcTQ2MWliSkpjNVNhZ1Jia2hQZXJ1THNpTnZVbGdpQTk3?=
 =?utf-8?B?YnhQNWl5YW5RSkZTdkJtN1FrRWlzV0JCV0tDL0RodktZQ1ZTRjB0TnBLa2NN?=
 =?utf-8?B?bFIyb2FiZXlsZllodkRwMkV6RFF0Q1dkUFNiS1BEbVg3NUo2VmtpUy9TQ1dV?=
 =?utf-8?B?TkcyYmFZNENuNGtuVlhxTXJvUFdJOGN4Sk1SS09MWkROV1hWNHlTa2FUOWhM?=
 =?utf-8?B?aHp3emVqbDBoNXFndmVQekdxb3E4MzFPRExMQlF1TFowaC9OelZ6TTRHbjBC?=
 =?utf-8?B?OFFwbWVTM1BXOXpMVFRyUFVvZHVrcHhlQXdrd2ZNM2JQYUpTWUM3U1FFRndt?=
 =?utf-8?B?SC9tNU5NSGFoamN0SzJuREFldzVqdFpDWmxDRWx3d2I0UCtNZzk2UHM5YmRo?=
 =?utf-8?B?M05wT2RBNW85eUhERUl2ZkV2NCt0eGxma0M2bGcxUG1IcUZxdHVxNGhwNlRz?=
 =?utf-8?B?S0Z2RGNrbmxxVzNkRVdFYXFDbVlqVkdBNTBCMXNhOUZ6R2tYeTVEUTk0bXV6?=
 =?utf-8?B?RnAva1RZZnR5d3k5RkUzT2ZveitlZzR4UzZwR2w2TjBNcUF5Zm85QUVPRGRJ?=
 =?utf-8?B?QWxLSEx6bi80bVZDWHVLRkNJeFY0STB0Y1p5MEZNYkFHQXlobHAyWjg4MVNC?=
 =?utf-8?B?S1FVMm1Xd3poRExUaXlNVll1QjM2czhERzA4QUdXOHM4MXQzMGorOVZhMjl3?=
 =?utf-8?B?RFZIWmlVKytCVEZ0NzBYbjVYa29XMU9vb2RBeXBjMVNxN0RsbFc1eHFKMjNs?=
 =?utf-8?B?SXBZRVdsSE5YTm9PTzhOMU0rbWNIZjJRZGhMRHE1aDNMSm5PZWt2NnMreEo3?=
 =?utf-8?B?TzJTcUdJMXFDT28yVnQwd285V0hKUnpHa2d4dGZEd1pmVnlvVlNaYmdnSEdv?=
 =?utf-8?B?TUhSazZZU0VmN2dhak1yZWZIUXY1a2dXa3lqdVBEQm9HWVlSV2g5dDkxcnFu?=
 =?utf-8?B?ZUZ4NU9GRlV5RThkZHVnemRzVVNTa1lXNmluSDhWcmhGSEZVVTV5YlBmWUtv?=
 =?utf-8?B?dHR5UktZUHhXNHZMMlU2eVJ0U0xibnhsYWk5T1I3eW9hOXVSV2J5Q1Fpb2NK?=
 =?utf-8?B?Y2tVcWp3dW9VSkdoNUc0U24ySVB0dWR0VDdtTFRva1lBREpFZ1E2cEFQMXBn?=
 =?utf-8?B?cjNrQitTNWV4S2F5UEN0T01jNXdEaE55V2QrSHNyZEFZekZ2a1kwbXowMkVI?=
 =?utf-8?B?RHR2SXg3eUVuRDluemNXdGgyUlNpV1oyWmxjanBrQnk1MHRxZDRPSzU2L1Yw?=
 =?utf-8?B?cnlFZ2owSFRTNXNLSGFIVTMzcUs0WkhmUG52YS8rY1QyOVNWQmVoZHpSbmNs?=
 =?utf-8?B?UEhEa0RPOXFBSlFtQmMrMDg3V3dKWGx4WWRzM1BYYTBSODEzZGxXdURyRkxn?=
 =?utf-8?B?eUQwZWZ1QXBBSTlyeStiS3A4Ym5XQXVBSEcrVWtFNE9KYXdSR0gvRzFSSk9a?=
 =?utf-8?B?bFV2TTNXMUVlNmVvQUdKWW11MTBUdUpIU0hlOWlUOFZuZXdTbmtNWWJabzhm?=
 =?utf-8?B?SHJVSmlTbE9hdEJBN0pmYkFRZmYvRUNqVThwQWU5KzVvTnNub3R2QjVtMUhM?=
 =?utf-8?B?bStvWnhHanp4R2NtSGo2b3JsQzhhRllCK2VkcHF0Kzl0Q2luRzE5aCtPYkkz?=
 =?utf-8?Q?kipXaQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2NKNUhuck1WZWQwV1JlSHBPS1N6N3Bkb2pWVS93UHVRZExmQnVZZm1IWEt0?=
 =?utf-8?B?NitYRHgwVzdkOFZxeThYbGo2ZWYzQVFHWmlOWldHWCs1QWNMamltRVpTMEZm?=
 =?utf-8?B?OUpkU2FmVmE5bm1remtUaDlFQWhOMVBoU3ErUzhhcTUwbEFlVDFnY25vUy9s?=
 =?utf-8?B?aWdLN1YwOVE5T25OZ2VsaUpYY3U0cTFRM2k1ZWFsd042bllUZCtoRjlGREpn?=
 =?utf-8?B?TTQrTDZFMHQxenZYOWNLVmJVV0pibXpqVUhocjgzUU4xenlyU0VnTmNzcmJF?=
 =?utf-8?B?elE2UzhZSzVQaG5xZFFTKzRwY3lHMW5xU2FBZnZQdjRpVWFheGJNSy81N1Rj?=
 =?utf-8?B?Tlk5TXRFNkpqSXlVOThHWndHdjhsUWVNaExxOStuLzIrMnpRL0htWFI0TXJE?=
 =?utf-8?B?MEFvU2tDaDFkazJ3MDZubjltNlh6Qk5UZmp5cnlTaUJOUFpIcEhLZjY0bHJH?=
 =?utf-8?B?a2dZdjl3azlKUVIvN2J6b3UvMGNGRnlEUjNBaS9DWnJtZzc2Y1cyZE9zdEps?=
 =?utf-8?B?YjVXdm95SGtCajRXanN3b2JhNWJaSjc1R0VCbUVZNDVYSnJBQ0t1b3Q3K2li?=
 =?utf-8?B?T3h4M2ErWmYvNXJ6Mld6WVVLQWk4TjJXVmlEVjJRdldjNFpBUXREWkNOOGov?=
 =?utf-8?B?bDJSRWVtYXFuOUN1a3B0dHhEMGx5U1ZBYzZBa1VVb3c3OFdyOXh1UWk3Umdh?=
 =?utf-8?B?NldkVFRwei9sR0hWMjFIU0JiYUE2TTl4d2FKQTQ4cTVzK3RiWEVDRjQ5N0p0?=
 =?utf-8?B?dFBkN3pEeCt0QTVMU2RyRXE2cWRGVDVhemJrS0tCOThqcUpueXIrTXZ3UUti?=
 =?utf-8?B?UmtIek5ZTFRCWVFlQzFUOXlwMURrNHhrT1NWVlg4UkRGOWFsVkQvM0N1TFBi?=
 =?utf-8?B?MWs2ZDhZM2cxTmp1Q3NXdGlwWHdkNWpTNnk2VEVtOWczZVkwNE10RTdWUDV5?=
 =?utf-8?B?TU4wM05jVlVrZ2htRnJvU3BoUkdaWmxLR0VJZTlQV09ZUFZ1bkFlMkp3R2VU?=
 =?utf-8?B?UkJpcGg5aVE3aHBLcGlTUHc4Rys2RnBqYkFMTjRsamo4SzF5ZlVVemJsUUFp?=
 =?utf-8?B?V1p6L1Q3a2xOUnh4THZrZWg4TVhnZTllck9hWGtJVTlkRDA1QVM4a1d1alBH?=
 =?utf-8?B?RzFrMW1GZjZPcUMwTlA5K2ZiTVVuZHJyQlQwMnN1Q2MvdmwxYmdYZ3diZmhj?=
 =?utf-8?B?cVRnWGRkaFRKTUdEekYzd2NNc09sK3BGM0c1dVNCNkt0OE1STzZYekd4V2Jm?=
 =?utf-8?B?THpRMjcyUjFLWUFlUUZvNDQrTU9SQmFNQ0ZCT2cyMWZLL0NWWXQxRUlhQWhZ?=
 =?utf-8?B?Q2pOQkNFTW9Pb3lPdmRTRlZMUWh1cnZrbUUySnlFMlRuMTk4THBCYnh6SDFP?=
 =?utf-8?B?UGgzYXlHSlhzVUgvakZHN2FyRTNKUG03d3Vwbi9LYTIxNWlwbFZTYU9RTG5t?=
 =?utf-8?B?ODhMNTVTdEU0WTU0NFNQQkxTMmw3N1NTakY1NXNVYWV3WGVGbkhXVDM2UktI?=
 =?utf-8?B?NVhDUm1sQ245aW5WbGtsN2szanVnWnJZdGJVRC8xRklXd3VRaEQxNU9MSXF0?=
 =?utf-8?B?VXpBd096cUhUTmR4bEcxNnRPUi9KV3RSb3YvNkIwV1g1TFo1anBlZkZNeXRl?=
 =?utf-8?B?c25YUExhMkk4dUdDK0N0NWFEVzNDRHFFY0VqVXViNnNkTGZoQWFDMDZBZG0z?=
 =?utf-8?B?cFgyQnFVdjVnY2hmRGlEWXVUZ2J1U3hCOEZiWW5WM2ZTdGwzZDVYOWR6Wlhu?=
 =?utf-8?B?Z21CSmtSTHNUVlpRTHhjRTZRSTUxNlIxZmg2NEV6anp2WDAzaVZTMHRzWG8y?=
 =?utf-8?B?MG9qeVRaOExDa0V4OUpCZml1aGw4VzZRS1VkdFhyR29zWTJDTDJjYUNZQkM0?=
 =?utf-8?B?R05YNEgxdFdxOWJBbUd0dTJOZ1o4d1AyZit5RkxzZHM4cnl2WWQ5U211U080?=
 =?utf-8?B?ZU5wRVRHbEdmcGV3b0tQbzRnOGhhTm1SNDh0MlBDMUk4NGRsR0loSXJXK0xN?=
 =?utf-8?B?STVpYzJtU0NGc3FGSHNaMmJlMTg5NkJkMFVrMUlkVytGc1FCdC9SOXBuUUlB?=
 =?utf-8?B?cE5CRjM0R1pybjVycmluTjBiT2thUjN1NUVQdWRnbUZWc1o5VTNEZGU5ZXNZ?=
 =?utf-8?B?SzhGeHdjMDZFZVYwYkhVZVlueFh6N2RFV01oS3QwUEgxQ1lNcGc5ODR5Rnd4?=
 =?utf-8?B?RjNRTVdyL21wcDVLc1BzNHdCUitmMEc5bUYzVjdMM3FlU3NjbkZNYWNXR25W?=
 =?utf-8?B?SDc4ZW5XSHgvWnBROUZpcVNqMUozckEzTUZ2ODVSV3d2YUFaMWNmR3kxcXRm?=
 =?utf-8?B?Z1Y4TGpTMmpMSXVjenFxRnRzVWh0aGExd1EwTElnSE1tUUxNK1VwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daa74ff-e2ba-43f2-d0ac-08de51b6ed4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 08:45:24.0272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZiATgD7HPvVJzz5INPf9XgHOOkOH3vDeVkLbCqgcELu3Np4bvB4vKHwAZZkcoJXnOhpRKzJG5jhbZR5GsBSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHVhbiwgWmhlbnpob25n
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IDEyIEphbnVhcnkgMjAyNiAwMjoz
Mw0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNsZ0ByZWRoYXQuY29tOw0KPiBjb2h1
Y2tAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT47DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsg
S3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCAzLzNdIGh3L3ZmaW8vcmVnaW9uOiBDcmVhdGUgZG1hYnVmIGZvciBQQ0kgQkFSIHBlcg0KPiBy
ZWdpb24NCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gPj4gPj4gPiBAQCAtMzA1LDYgKzM0NSwyMSBAQCBpbnQg
dmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+ID4+ID4+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5zaXplIC0gMSk7DQo+ID4+
ID4+ID4gICAgICAgfQ0KPiA+PiA+PiA+DQo+ID4+ID4+ID4gKyAgICByZXQgPSB2ZmlvX3JlZ2lv
bl9jcmVhdGVfZG1hX2J1ZihyZWdpb24pOw0KPiA+PiA+PiA+ICsgICAgaWYgKHJldCA8IDApIHsN
Cj4gPj4gPj4gPiArICAgICAgICBpZiAocmV0ID09IC1FTk9UVFkpIHsNCj4gPj4gPj4gPiArICAg
ICAgICAgICAgd2Fybl9yZXBvcnRfb25jZSgiVkZJTyBkbWFidWYgbm90IHN1cHBvcnRlZCBpbg0K
PiA+PiA+a2VybmVsIik7DQo+ID4+ID4+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4gPj4gPj4gPiAr
ICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCIlczogZmFpbGVkIHRvIGNyZWF0ZSBkbWFidWY6ICVz
IiwNCj4gPj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25fbmFt
ZShyZWdpb24tPm1lbSksDQo+ID4+ID5zdHJlcnJvcihlcnJubykpOw0KPiA+PiA+PiA+ICsgICAg
ICAgIH0NCj4gPj4gPj4gPiArICAgIH0gZWxzZSB7DQo+ID4+ID4+ID4gKyAgICAgICAgTWVtb3J5
UmVnaW9uICptciA9ICZyZWdpb24tPm1tYXBzWzBdLm1lbTsNCj4gPj4gPj4NCj4gPj4gPj4gRG8g
d2UgbmVlZCB0byBzdXBwb3J0IHJlZ2lvbi0+bW1hcHNbMV0/DQo+ID4+ID4NCj4gPj4gPk15IHVu
ZGVyc3RhbmRpbmcgaXMgYWxsIHJlZ2lvbi0+bW1hcHNbXSBlbnRyaWVzIGZvciBhIFZGSU8gcmVn
aW9uIHNoYXJlDQo+ID4+ID50aGUgc2FtZSBSQU1CbG9jay4gQW5kIHRoZSBrZXJuZWwgcmV0dXJu
cyBhIHNpbmdsZSBkbWFidWYgZmQgcGVyDQo+ID4+ID5yZWdpb24sIG5vdCBwZXIgc3VicmFuZ2Uu
DQo+ID4+DQo+ID4+IE5vdCBnZXQsIGNhbiBSQU1CbG9jayBoYXZlIGhvbGVzPw0KPiA+DQo+ID5Z
ZXMsIGEgUkFNQmxvY2sgY2FuIGVmZmVjdGl2ZWx5IGhhdmUgaG9sZXMsIGJ1dCBpbiB0aGlzIGNv
bnRleHQNCj4gPnRoYXQgaXMgbm90IHdoYXQgaXMgaGFwcGVuaW5nLg0KPiA+DQo+ID5JSVVDLCBm
b3IgYSBWRklPIFBDSSBCQVIgcmVnaW9uLCBhbGwgcmVnaW9uLT5tbWFwc1tdIGVudHJpZXMNCj4g
PmNvcnJlc3BvbmQgdG8gc3VicmFuZ2VzIG9mIHRoZSBzYW1lIEJBUiBhbmQgYXJlIGJhY2tlZCBi
eSB0aGUNCj4gPnNhbWUgTWVtb3J5UmVnaW9uIGFuZCB0aGVyZWZvcmUgdGhlIHNhbWUgUkFNQmxv
Y2suIFRoZSBzcGFyc2UNCj4gPm1tYXAgbGF5b3V0IChucl9tbWFwcyA+IDEpIGV4aXN0cyB0byBk
ZXNjcmliZSB3aGljaCBwYXJ0cyBvZiB0aGUNCj4gPkJBUiBhcmUgbWFwcGFibGUsIG5vdCB0byBy
ZXByZXNlbnQgZGlzdGluY3QgYmFja2luZyBtZW1vcnkgb2JqZWN0cy4NCj4gPg0KPiA+U28gd2hp
bGUgc3BhcnNlIHJlZ2lvbnMgbWF5IGxvb2sgbGlrZSAiaG9sZXMiIGF0IHRoZSBtbWFwIGxldmVs
LCB0aGVyZQ0KPiA+YXJlIG5vIGhvbGVzIGluIHRoZSBSQU1CbG9jayBhYnN0cmFjdGlvbiBpdHNl
bGYuIEFsbCByZWdpb24tPm1tYXBzW10NCj4gPmVudHJpZXMgc2hhcmUgdGhlIHNhbWUgUkFNQmxv
Y2ssIHdoaWNoIGlzIHdoeSBhdHRhY2hpbmcgdGhlIHJldHVybmVkDQo+ID5kbWFidWYgZmQgdG8g
cmVnaW9uLT5tbWFwc1swXS5tZW0ucmFtX2Jsb2NrIGlzIHN1ZmZpY2llbnQsIEkgdGhpbmsuDQo+
ID4NCj4gPkhvd2V2ZXIsIHBvc3NpYmxlIEkgbWF5IGJlIG1pc3NpbmcgdGhlIGNhc2UgeW91IGFy
ZSBjb25jZXJuZWQgYWJvdXQgaGVyZS4NCj4gPlBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IEkg
c2VlIG1lbW9yeV9yZWdpb25faW5pdF9yYW1fZGV2aWNlX3B0cigpIGlzIGNhbGxlZCBmb3IgZWFj
aCByZWdpb24tDQo+ID5tbWFwc1t4XS5tZW0sDQo+IGFuZCBSQU1CbG9jayBpcyBhbGxvY2F0ZWQg
aW4gZWFjaCBjYWxsLg0KDQpBaC4uIEkgc2VlLiAgSXQgZG9lcyBhbGxvY2F0ZSBSQU1CbG9jayBw
ZXIgIG1tYXBzW2ldLiANCg0KPiBJSVVDLCB3ZSBzaG91bGQgc2V0IGZkIGFuZCBmZF9vZmZzZXQg
aW4gZWFjaCBSQU1CbG9jay4NCg0KT2suIFdpbGwgdXBkYXRlIGluIHYyLg0KDQpUaGFua3MsDQpT
aGFtZWVyDQo=

