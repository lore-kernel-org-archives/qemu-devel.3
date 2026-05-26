Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F637CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoRR-00071e-5d; Tue, 26 May 2026 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRoRP-00071R-UP; Tue, 26 May 2026 05:51:15 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRoRO-0006OU-8P; Tue, 26 May 2026 05:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncwbqOyQXNd+50dtfki787p2NuiRjZblO0uq5KGenE+x3XNSjHh+VKCo9YC3f45uQzqrzAB4sckc/TtTSMseJZeoU2yRoWRuL1qgthmcKAUjSQVaxSW5QNO8KGBrPERNCqYJCp/qY2zeziFGFaAy734BvPBuvguAb47fmGQx+liMuKbujJiHQluQ24fT6Mryqoe7JPFIF3h+oguVyuahQIP5Art5HW29wAeSTGGiCAfK2greIiaNhSsGnYBH+8Wa+yvh7bjK0mqr3L5mimgGxd0pwqxMzOjkrsHK0wcNW7PSijqaqAw0C/o6kf+EHEU3hS8m0F3DPqLOxLn0Ne6t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJTSK2QsN9kBAcTFxR1pkjoJzv5hSSFlSky7wO7vVI0=;
 b=O07EY6Enq9u2oIXfRnjatBlGJJSZeDM4Q7DRV7iKnsY3/TAYBenG9biqgrI3vutZXAMUnA0KHdM0XrgSngKzdhgiCtTnTXyA3R+3ZWTD0FR3+luy5myQab53wVcrVui4O6ddK36oGqT2QfASffL0o20RYPkIQhYKqQdYpscRb9nxFdgHNzTl9LZ1Zb8K2an3JNFOcAVgbiD9EJZZLv5DPk9+q4G1FHcanhl9r0rkTChHjxstMBtUnzjEX6N+1y5Thao8HKctFcLpCBnuZzQhhmQlgB6Eo6HvrdmOLcDL5zfWZwzWhjgOaQ8XvazR4zDu6R9wxIs18YWi0Si1StR9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJTSK2QsN9kBAcTFxR1pkjoJzv5hSSFlSky7wO7vVI0=;
 b=p3fTDdYdU1KwmmVjghXhf5rejkcVWLhrkKQMY4/G+fKEAa9eVrOA1H8ddvwXE8oFXSMmqaYj+vLil1HtxWfrd3P6A+MHDfiR0e8TaOv6Efy5hSSaX/5EFpW3M0YemJ+Nl+Md5gBZ6/Uq/4fLTPpgGX9jEDLbzQiH7aYGMililkQddfD9EPLNHrJ2krPH7UPnu8csE0Xk6RIdnW8qbTqE8TXNWMoN4+EccHf1DPXDxfmGkQOVkME5TySf3Gz0vzNsM5frfEmpFKgcfMZvzZa9weO6shcyWORODZqH4nH9SVGcYhRp86eyynaM/xGOvzwOHzzn1lEGZWJrYCdHHzuClw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:51:08 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 09:51:08 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 24/32] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Thread-Topic: [PATCH v5 24/32] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Thread-Index: AQHc53vh34xtIrfFZkqvqWXDIrWkL7YgA/CAgAAWCuA=
Date: Tue, 26 May 2026 09:51:08 +0000
Message-ID: <CH3PR12MB75483B20E508737D529F1214AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-25-skolothumtho@nvidia.com>
 <8183d160-d588-4124-886d-a37dc4f92620@redhat.com>
In-Reply-To: <8183d160-d588-4124-886d-a37dc4f92620@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8136:EE_
x-ms-office365-filtering-correlation-id: 9d95d465-83ce-4ab2-d9a0-08debb0c4f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|6133799003|11063799006|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BDEiuJjagHpSJ0tP00TK7NZCwipFchLh6snNBAciJ2/qK/yRTdfrmQG4raFH5YQ2JZdc2vMrHwzBHOFnp4ia+onAeN/0rbFztklzpfrr43Rk/ASaGo7+D5QjIoniJhdo3l8bIw3aqOaqZthuHdVakmRTyxxlIbwINRfJYLxf2gy5HasLUUDujo7ExZ8OsLIJKjG2+HpuRcotEK/sUJ0gASxXklJTIz6rfpkNmNhzZ8gAlLJQbHa1VssfT4U+FqFsnRBCSl7HCIaYFiSHAnZ8nTpYJnvhoBYkRZzQV+RVOMFdvnt6SHNVqRNdM+szjMwcjEoOcAOGZe/lb5THndma7NWZWMwgnb26J3PgILCTm2H6yaTYlfcWBjzVoVnSjjwwWA4pPcjyQP3YfqTxynhlBirogbV0S9ubFN2YpFCLkjOMf5mILtQSbAfO05WdAg5K+tm5W3OddoAEksM4kXfzFXDgwfkPJ/7deqQonqEIeL9alktgN8CikjYgHEpJTutDPUfKHB4LFinvRFdypuqUMnI8o/ltNjZ2C74+ZmORTpCeT7ovQzokchUrGdAZqgBrHlg7qvL5O3xQf/Tzycj69k3zBbO7VAEAvtSG51kA1XmWlS4eS4tNkzrm8nrbwTWmFmuD1ErV29LWA0gZKQ1+dM/fRAA5x+ybyTJtytL807SioXLQF9YXAvUzpHj0TgCIfuhKSd6u2ALTkT38Wf7nqqGK0zSDMK6eJX+2ND90K4D6kheVqWZOoibZT6AQlHAV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUJmbW96VExTTDdzU1B6cllrdDlMMXBwOWpDNXI2aVpHbXk4Q1J4cTlGRHFI?=
 =?utf-8?B?RnI4N1VocTAxcFMxRWh6UFM4cStkZFh5MFovTEpqRk5KcFM2SGxtWElwZkxU?=
 =?utf-8?B?dVo0TndQTitWeEQ2OE9oemszRFdwMTkxd1N1S1lOMldZVk9wM2lYT29ZaWFl?=
 =?utf-8?B?Q2RSdm5nVVhXWmE0bDIxNTV4b0hiYVJYMXBGeVlJUVdVVTAxb0lwYzFKSVVy?=
 =?utf-8?B?OFBkNXRiRENnUkIrMXZtQkdVR3pJRUpSOHdjeGF3VC9BTEM1OFJ5dnU1M0RC?=
 =?utf-8?B?dWg4RGloNjF2dSs5cUEvV3pwdFN2WmdiVEloaXRiMnQ1M2d6b2VsVUVibllS?=
 =?utf-8?B?ZjMxRHo1MUJOU1J2a082Y3ZyQnhFZkk0SkFINE9BVWRlQUt5NW5XOGlhY1BW?=
 =?utf-8?B?ekFDaWFyVWUrRVhWQkhPLys3WHhTVkFZcFFrWW9pSnVLbTVWd2I2T3NMcVow?=
 =?utf-8?B?OGxCNFlSa2VkcytJYlY3OCtOTVliUnlzRzE2N1hVaXRoNFZCaEplQnFYNURN?=
 =?utf-8?B?eDhjd2VXUFhIY2lXNFByQVVlVFNkekhNRGdWUWlQQjcwSHFRdllmcmd5WTAx?=
 =?utf-8?B?MTgzeXdJL0hIUEZDUXpib3RYV0xkRklYa25pbUw4S2sxekYrV3BXRVdoR0ZP?=
 =?utf-8?B?M1kzUnJSeVRxeXQwaWNETHVIVWlJQTFuUUNiZHQ4S1RCTnBCVlBwTDFZeXVr?=
 =?utf-8?B?UklCNXVwaWZ6OGdRTnZDdDJqcjAyVm9pWXR0eEUwM095Q1FBRkNKZnhZY1N2?=
 =?utf-8?B?Tnordjkxbkt4dlJiVGlVem5SR2VxbWp5Vlc5Rk9EUXE0dnBFT0dpb3J3MEJK?=
 =?utf-8?B?bjRST2FUaExWR05ZdVBvWFlwUENMSGY4bDhwMEhhUzZVNHBmNGEvejhsQ1dZ?=
 =?utf-8?B?YUlhQ1YzNkM0dTBRV0NBUmlrSkxITDJRVkxOL0kxeEZva29iK3psYW5ZSHl6?=
 =?utf-8?B?TUlKS3RsNmV5bnY2eEZxUmxoa0xQcjZJeGFJSDhxVjUyaFVrWkg0eldRbXdS?=
 =?utf-8?B?MGtEcHhnUmVXcklOTkNTSmdKcjR5bzhSTXZjZkVNN1FMcXJPMFRzRjc0bXhs?=
 =?utf-8?B?WWpTRHJkczVnejJ3VTlmZjExNE16cGt4RHU5VzI4MzZIYnlTTG1pQWtySnRU?=
 =?utf-8?B?bUFBTzA2Si96M3VlYWZqQVRqbkJmMmg0bDRKSTVwTHNxYm9MNjN6K3RpWXFG?=
 =?utf-8?B?MkRVZFEzTnRlTHUyaVRBZFpBQVh3V1piSFQ2VGszbjQrR3p1UDEzYVU1NUt6?=
 =?utf-8?B?SVhzL2tTUTQrMXBPVDBBYUVmL3NNemRHK0swYStXSmh1TDBXL3BxY1NlTXdh?=
 =?utf-8?B?dFgxakFnZ3RHTG9Pb1A0eDdZUHhzM2ZRT1VuaGM5N2NDdVBGNGN3OGllQUhN?=
 =?utf-8?B?TDlvY2FCNGVCcHRmK2RKVituQmw0VzJYSDdWVDkyUnljQkJDcWZldC9ucjVo?=
 =?utf-8?B?dEZ4S0JONC9nWTZsMHZ0TGxyalhZOHdyalBldWFJS0NrL2RaaUtNYVJ0Q0U0?=
 =?utf-8?B?Q1kyWEVFeVJEajJmMVoxTDV1UytrakpaaGpYWVJ3WTM0WFJOaHNmMWxTSEc3?=
 =?utf-8?B?N3lmRVpDQ29Dd1lnNWRqeUtYb3h6ZVhuTGo0Y2FQUUhHZmxNeGZKMTVJVmdo?=
 =?utf-8?B?aTFIMkF0TklCS0dpZWVMM0dXQlEyOHMrN0J5NHhtNjg3M0NZQm9HRUV3RmF4?=
 =?utf-8?B?aWtheVN6bGZMSEFXdldic0JkVEZaR29YVDZrSVc0WEV2b3hTT2JML0ZWeHFQ?=
 =?utf-8?B?ays4NE4ybG1DeC9jaTUxWVByTnRsbUptL08yT2tIUlJQYWVmd1BlUzhXaWho?=
 =?utf-8?B?UitzckUxcG00SCs4Q3dLYzRsSWpzSGc2TC9UTFR2Qm5nbEdGRGJCZXNVc1d5?=
 =?utf-8?B?VEtSZEtVTkdsVy9zdXlNMGNMWllEeFVYbVJrdytGM0VTTzF6bDA3dXhvSXZr?=
 =?utf-8?B?QnFLd2ZmdzJOOGRXblNWbUdqeE9oV2lQeFM2ck5KOUJRQi9Lb2lQRGUrL3A1?=
 =?utf-8?B?ak9hMWkrWnhoLzVOdTZoY05zdCs2QXJzb3FmeS80Q2c4RWVBL3JhWHRSSS9q?=
 =?utf-8?B?SGY2WXpzblk1Rms0aE5PdVQxOGFUTTVtbnZpOTl1OG53NzlvUWdKZzFNMGh4?=
 =?utf-8?B?d1d0NG04ejZEOWIzODJLa05FYUR3ZzNIeTh5TkVzZ2RZM0VhcXFpY242VlJ4?=
 =?utf-8?B?SjM1VUFYYkZQSWxmLzlTeXdTQzNuMXprUmhEYWhRZXdkRGcrMkJGUG1Eb1hG?=
 =?utf-8?B?UEE4VDUzT2VmMm8rOFBGNVA4SmJjOElhcVRZWTZaZVNNZ0dBTHlqT0hWSkN0?=
 =?utf-8?B?U3YzZDB4U0c5Y1lBMUZPWXp5Z2doNUs4YzdaRGZBV1dtQWsyRG13QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95d465-83ce-4ab2-d9a0-08debb0c4f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 09:51:08.0654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuGE3mDpRIlqu6Pah8BILgqmqyxK+S29Lecg4JI7yTpOyZq0Z+jWGmGY0QVrF9QJGbKCUdr0N5lwsnxIWWyCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDI2IE1heSAyMDI2IDA5OjI3DQo+
IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFl
bXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4g
PGphbkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlh
LmNvbT47IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDI0LzMy
XSBody9hcm0vdGVncmEyNDEtY21kcXY6IFJlYWQgYW5kIHByb3BhZ2F0ZQ0KPiBUZWdyYTI0MSBD
TURRViBlcnJvcnMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxp
bmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDUvMTkv
MjYgMTI6MzcgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gSW5zdGFsbCBhbiBldmVu
dCBoYW5kbGVyIG9uIHRoZSBDTURRViB2RVZFTlRRIGZkIHRvIHJlYWQgYW5kIHByb3BhZ2F0ZQ0K
PiA+IGhvc3QgcmVjZWl2ZWQgQ01EUVYgZXJyb3JzIHRvIHRoZSBndWVzdC4NCj4gPg0KPiA+IFRo
ZSBoYW5kbGVyIHJ1bnMgaW4gUUVNVSdzIG1haW4gbG9vcCwgdXNpbmcgYSBub24tYmxvY2tpbmcg
ZmQgcmVnaXN0ZXJlZA0KPiA+IHZpYSBxZW11X3NldF9mZF9oYW5kbGVyKCkuDQo+ID4NCj4gPiBS
ZXZpZXdlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+
IC0tLQ0KPiA+ICBody9hcm0vdGVncmEyNDEtY21kcXYuYyB8IDYwDQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGh3L2FybS90cmFjZS1ldmVudHMgICAg
IHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYyBiL2h3L2FybS90ZWdyYTI0MS1j
bWRxdi5jDQo+ID4gaW5kZXggODUzYzU0OGU1OC4uMGJiYTJjMTgwMSAxMDA2NDQNCj4gPiAtLS0g
YS9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRx
di5jDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4gPg0KPiA+ICAjaW5jbHVkZSAiaHcvYXJtL3Nt
bXV2My5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My1jb21tb24uaCINCj4gPiArI2lu
Y2x1ZGUgImh3L2NvcmUvaXJxLmgiDQo+ID4gICNpbmNsdWRlICJzbW11djMtYWNjZWwuaCINCj4g
PiAgI2luY2x1ZGUgInRlZ3JhMjQxLWNtZHF2LmgiDQo+ID4gICNpbmNsdWRlICJ0cmFjZS5oIg0K
PiA+IEBAIC03MzYsNiArNzM3LDQ4IEBAIG91dDoNCj4gPiAgICAgIHRyYWNlX3RlZ3JhMjQxX2Nt
ZHF2X3dyaXRlX21taW8ob2Zmc2V0LCB2YWx1ZSwgc2l6ZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtz
dGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl9ldmVudF9yZWFkKHZvaWQgKm9wYXF1ZSkNCj4gPiAr
ew0KPiA+ICsgICAgVGVncmEyNDFDTURRViAqY21kcXYgPSBvcGFxdWU7DQo+ID4gKyAgICBJT01N
VUZEVmV2ZW50cSAqdmV2ZW50cSA9IGNtZHF2LT52ZXZlbnRxOw0KPiA+ICsgICAgc3RydWN0IHsN
Cj4gPiArICAgICAgICBzdHJ1Y3QgaW9tbXVmZF92ZXZlbnRfaGVhZGVyIGhkcjsNCj4gPiArICAg
ICAgICBzdHJ1Y3QgaW9tbXVfdmV2ZW50X3RlZ3JhMjQxX2NtZHF2IHZldmVudDsNCj4gPiArICAg
IH0gYnVmOw0KPiA+ICsgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ID4gKw0KPiA+ICsg
ICAgaWYgKCFzbW11djNfYWNjZWxfZXZlbnRfcmVhZF92YWxpZGF0ZSh2ZXZlbnRxLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVV9WRVZFTlRRX1RZ
UEVfVEVHUkEyNDFfQ01EUVYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZidWYsIHNpemVvZihidWYpLCAmbG9jYWxfZXJyKSkgew0KPiA+ICsgICAgICAg
IHdhcm5fcmVwb3J0X2Vycl9vbmNlKGxvY2FsX2Vycik7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0K
PiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmIChidWYudmV2ZW50Lmx2Y21kcV9lcnJfbWFw
WzBdIHx8IGJ1Zi52ZXZlbnQubHZjbWRxX2Vycl9tYXBbMV0pIHsNCj4gPiArICAgICAgICBjbWRx
di0+dmludGZfY21kcV9lcnJfbWFwWzBdID0NCj4gPiArICAgICAgICAgICAgZXh0cmFjdDY0KGJ1
Zi52ZXZlbnQubHZjbWRxX2Vycl9tYXBbMF0sIDAsIDMyKTsNCj4gPiArICAgICAgICBjbWRxdi0+
dmludGZfY21kcV9lcnJfbWFwWzFdID0NCj4gPiArICAgICAgICAgICAgZXh0cmFjdDY0KGJ1Zi52
ZXZlbnQubHZjbWRxX2Vycl9tYXBbMF0sIDMyLCAzMik7DQo+ID4gKyAgICAgICAgY21kcXYtPnZp
bnRmX2NtZHFfZXJyX21hcFsyXSA9DQo+ID4gKyAgICAgICAgICAgIGV4dHJhY3Q2NChidWYudmV2
ZW50Lmx2Y21kcV9lcnJfbWFwWzFdLCAwLCAzMik7DQo+ID4gKyAgICAgICAgY21kcXYtPnZpbnRm
X2NtZHFfZXJyX21hcFszXSA9DQo+ID4gKyAgICAgICAgICAgIGV4dHJhY3Q2NChidWYudmV2ZW50
Lmx2Y21kcV9lcnJfbWFwWzFdLCAzMiwgMzIpOw0KPiA+ICsgICAgICAgIC8qDQo+ID4gKyAgICAg
ICAgICogQ01EUVZfQ01EUV9FUlJfTUFQIGFuZCBWSU5URjBfTFZDTURRX0VSUl9NQVAgYXJlDQo+
IGRpc3RpbmN0DQo+ID4gKyAgICAgICAgICogcmVnaXN0ZXJzIChkaWZmZXJlbnQgTU1JTyBvZmZz
ZXRzKS4gV2l0aCBvbmx5IFZJTlRGMCBleHBvc2VkDQo+ID4gKyAgICAgICAgICogdGhleSBjYXJy
eSB0aGUgc2FtZSBkYXRhLCBzbyBtaXJyb3IuDQo+ID4gKyAgICAgICAgICovDQo+ID4gKyAgICAg
ICAgZm9yIChpbnQgaSA9IDA7IGkgPCA0OyBpKyspIHsNCj4gPiArICAgICAgICAgICAgY21kcXYt
PmNtZHFfZXJyX21hcFtpXSA9IGNtZHF2LT52aW50Zl9jbWRxX2Vycl9tYXBbaV07DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsgICAgICAgIGNtZHF2LT52aV9lcnJfbWFwWzBdIHw9IDB4MTsNCj4gPiAr
ICAgICAgICBxZW11X2lycV9wdWxzZShjbWRxdi0+aXJxKTsNCj4gSSBkb24ndCBzZWUgU01NVV9D
TURRVl9WSV9FUlJfTUFQXzAgdXBkYXRlZCBhbnl3aGVyZS4gSWYgSQ0KPiB1bmRlcnN0YW5kDQo+
IGNvcnJlY3RseSwgaWYgeW91IGdldCBhbiBlcnJvciBvbiBhbnkgVkNNRFEgeW91IHNob3VsZCB1
cGRhdGUgaXQuDQoNClRoaXMgb25lIGFib3ZlIGRvZXMgdGhhdDoNCmNtZHF2LT52aV9lcnJfbWFw
WzBdIHw9IDB4MTsgaXQgc2V0cyBiaXQgMCwgd2hpY2ggaXMgdGhlDQplcnJvciBiaXQgZm9yIFZJ
TlRGMCAodGhlIG9ubHkgVklOVEYgUUVNVSBleHBvc2VzKS4NCg0KSSB3aWxsIGFkZCBhIGNvbW1l
bnQgdG8gbWFrZSBpdCBjbGVhci4NCg0KIEFsc28NCj4gdGhlIHRyaWdnZXJpbmcgb2YgdGhlIGly
cSBzaG91bGQgZGVwbmQgb24gU01NVV9DTURRX1ZJX0lOVF9NQVNLMCwgbm8/DQoNClJpZ2h0LiB3
aWxsIGFkZDoNCg0KaWYgKCEoY21kcXYtPnZpX2ludF9tYXNrWzBdICYgQklUKDApKSkgew0KICAg
ICAgICBxZW11X2lycV9wdWxzZShjbWRxdi0+aXJxKTsNCiAgICB9DQoNClRoYW5rcywNClNoYW1l
ZXINCg0K

