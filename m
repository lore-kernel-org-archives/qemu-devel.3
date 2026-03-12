Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F854FED2F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bfR-00075B-Bh; Thu, 12 Mar 2026 04:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0bfH-000749-BJ; Thu, 12 Mar 2026 04:45:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0bfA-0007xf-SP; Thu, 12 Mar 2026 04:45:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhsygxsJaAPNXsOt72iwyh4obsau1gVv+iyCIs57VX6rL2xmRGK16t06OKJHyHQbOUlVGwiJHNtOamUxjocdeiWwNDAlFIWG31YkZQHuiEgvYyQaMbUkZbHFKTBkflhqk3bAkPVY/y+AsmiTN+zESZfkkczj5e9ugJVEc/gX1Ux57rPI5GshfCQl9Jl3+o/N0U0Y50cQzidkZ7efdQoHsk0Zh5ILdT83lrP7M3QRRFt22Y9TSkU+M3Yr45NfrXWuncNWG4gtFacPWxw68bQeeeXCZ4554dDShm0IeGNVMqVTZF4ULnw1J0caTVzYYRsW3cdHefU+drEBv7ATsabifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf+nXO2NTR/N6+IWANFBiQVSr/X3D51mqVlZp31/j88=;
 b=Bq06lKiibPbXH+XRXjGsqkaXQcMuzB9MKM9v7HiQHp3cV9ZMWgTZmH4o0NqvdjOK2lM9F4wJAlzdxIfYQRF/t5Ej2+/z9mInNabY35Qishal0KWtEvE3APvdOgShVAyhOG4uUjpU2zPjxeJgog5ar4J9mdR7RaCPXKfiSrQTgV61p2WXdUHXI2DYjKWFikTrt/BJmU+TwtbQ6q1o1TCmlgJYnPP6awuId+Nq929HWzgx5oR8GwkCXSZf1AtG2fn5ER3IUhN1g6nL/9RrdD4qQBxGRho4siNGtg5PxfgfzL1s5XgiYEnXLkse5CHy5BhrFOEzxe4o/CsJ3auHqLbhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf+nXO2NTR/N6+IWANFBiQVSr/X3D51mqVlZp31/j88=;
 b=LBg9oBlm+8ArsmAyXUqOCsd91LN+C6W7ni9AjUkIHV4D+XYWnvYcGs+bYiEFd8bqaEu4lw2DZmkROL7Mx7IgBVOr/56ZS+Oxf1rHEbcz+telwGQnaAoZotig/IY9/FgXADkftr+ykNqk29+WhVgRBOXgmX3f8viwI0jTPLCJ27bAatuKzSbYPNiSchb8k9oYXfvGkF8vdwRJUAYcx4DTMyFvD4GiOMVUwx3uCvT/amaaDb0GIKsijTD8QuBtT50wzrj9nRz9ef4Xxr95rk5yCkhHe1Y+cITtAdN0gxFoje6rQ+oqZeQtTedz1h7I3vrsfUId5ktN1A2K2itMIrUEng==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:44:54 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:44:54 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
CC: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?=
 <berrange@redhat.com>, Alex Williamson <alex@shazbot.org>, Eric Blake
 <eblake@redhat.com>
Subject: RE: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Topic: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Index: AQHcr/oMB52/+UCqJ0eb9yphs6lsLbWnV1XEgAAb7VCAAx8LbIAAAN/QgAAEU4CAAABkYA==
Date: Thu, 12 Mar 2026 08:44:54 +0000
Message-ID: <CH3PR12MB75489FD88A71369890A2A0A1AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com> <87tsuonp7r.fsf@pond.sub.org>
 <CH3PR12MB754899F3426FCB494EA7154FAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <87v7f1xxv3.fsf@pond.sub.org>
 <CH3PR12MB75485C39AB4ECE0B594C8C92AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <d19fb981-7acb-417a-9b33-cb697066b2bc@redhat.com>
In-Reply-To: <d19fb981-7acb-417a-9b33-cb697066b2bc@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7291:EE_
x-ms-office365-filtering-correlation-id: 0d44c933-a796-48ad-6e09-08de8013a1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: YhbFE7unTyD907H1ivCPSuiSYh++xESCegu03Y4VEBO+TlzcaVS+/hILY/32DLHd1xB6E5LFZ0VKrBedj4zbH3MIkxsEl80Y3tInUbeslCOPh9D2X5RtDNv52XCZD2eN3IRp2DPSIm8mzbC1e8WEpBb++HDUNF2r7eDOVaVKyypvmRMoXTWcRAerzEGq6jDLemPmluSQPA6xvLzOCq53zlZCdl8vb5LDOE1UzMlme69aG2rDs9a9TQx8DutZOLrvNufvVTlyA3jpDbwzrQu2tRmilUyLQqZXfXWwx2bYqfLwgnm7UposVVuNt+LLtNHTzAZhVBaKhFP8rViOnfUK9f9+XhkArP5vXjIcquP4tjGhq2rzPs+Bh/hiLlMvvLC6/T9vrTZKxXynUfJS45S19TfuGQ4I2oQf3dDz58ZjEp6cBN8LZ9DeX8yyUViBWFPB906tiDkhBB/Hn1KfqE8DKzJegdI0/tTntlf2nHhVS07pa6LVHFrtsJkxWgJzdxZKiAxdy/2Nm7LqtKfyT2PKiJdCJ2lcGhwDxQDaaxeRcJSFxwxximdOxBQ66e3av2GRKxkobZW6QeyA2KODzxORWM9Ozxun0fIQtQ4DegW9SGyhQwHkHWmfqI4FuoGyRAQQ53YHEtOLZxk284WWOWaOVs4UvSMFgnJ5zCW2dQ1shw3uh4YnaaL+iAMndIfzxs+4zm9uSF26KQzNRjZKdG4AWwLDjySQhllPMxyTCjz/r/K/1FkoBQq0Nm3wsLnrekPg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE96Lzh5RXJFamNRWUVCRTcxb29IM1pwa01wbTR1UHk4UHhxMzdRSk14SUc3?=
 =?utf-8?B?OEJ0eWF0dUk3SEEyRGNZVHBJUzJCMkZLcmd0KytkbjdnR2VOYStFVHpyRzVH?=
 =?utf-8?B?cCtOU1JpZUE4SDZMcW5XYlNuRWhaVm9DNnJQWFpMRDdpZ09HYW83WFZscHFR?=
 =?utf-8?B?WXdkYWl1Y2dDRE9UY015T1NJTGpSWTd4STBRRkZCTklYQmliazcxYkltb1Rj?=
 =?utf-8?B?bXNlWEdqRVE4U0NZVzVUZG9iSkdQU21HTnovem1RWTZBeklKMjc5ZUJ6UkRI?=
 =?utf-8?B?Y0tYU1VFTzZyL3g2SXZCWSt2Tk5BQlhWTkdwWENvSzhlcmE4QWpBNXk3Z1Rt?=
 =?utf-8?B?S2tmNzV0M0pqTUlGNWFNbGJyWkdjVklJZCtVRUUva0k1aCs2bXBaaVAvYkxh?=
 =?utf-8?B?YVhuZEFVRGR2dDhkaXVPYVc2SkJ1RjZyMUJoV2NqMWxzSFptS0dMTFgvbmlG?=
 =?utf-8?B?aE0vMkRRcFcwWjRQcGJaOUFFQit6MlZvN0ZmTVRTUHFvbFEvLysvaENIS3Iv?=
 =?utf-8?B?U0pjVnBvci9HSVRzeWpNTUJhT1JDVC9CRDh2SXVqblpCRnRNdHJRQWI5enIy?=
 =?utf-8?B?Z3NXT0g3Szh1TTgzamhDdHZKYVVvMjZoenlUbUpYSFNSMzlqcW9seGkxK2dV?=
 =?utf-8?B?QUpPTDcrSDN2T09oOFo2VFVIRU5BTTRvKzlMV2p1ZmpLek5VbnJaTkZCaUx1?=
 =?utf-8?B?RWRvajQ0Rmp2Z200ekY1dXNKWlNRcW9JWG8ycHB5YWFhYVBGaml2TGhxT1pv?=
 =?utf-8?B?bUNzTVVFcEwyYklycVl2NUZDL2VkUmNMeGdOZW9qa2VIYld4MjhzL09zUTNT?=
 =?utf-8?B?Rm82ZFpiNFliTWxlQzRrZzBjb1ZNSktRSUwwVS9iZEJTMENkTnhaeFI1QVR1?=
 =?utf-8?B?TlZpL2hyUml2eVpnRTR4V1Zrbk10S3hXVXA0UUtiU2kyUTErZEQxakMwZzcr?=
 =?utf-8?B?L1dhMjZhWXlwOHNtZlZDN2ZoM0NWc2pZQXBpak1SL2kza00yNHBBSThScnRX?=
 =?utf-8?B?T3J0YjZLVjNxWDRRZ0U4dlpCcFY1OWgra0VNc1VSSGJRNWJWaEhEL0t2V0ZD?=
 =?utf-8?B?bUQwbHMwdGNBWG9pK2RNZnlnaGZYc09aV1J6Q0hMQmg2TEVMR3ZvcG1JQytz?=
 =?utf-8?B?UGEyVGE0T3V0WkE4d3RlVTNmOUhCdldGK0FQQ2todnEvRVhOT2dRTUpjS0Fm?=
 =?utf-8?B?TGYvQnl3NzZiYU9mR004RWV1QkVlYS9NTGhnVDRuNTV0d1pDeStRRHlRaHQr?=
 =?utf-8?B?dU1McTdOQ3hIa0VPQjJjd2gyUndqVHU0Z3U5cDhCcXVyVFVTMVZsRHhVcDcx?=
 =?utf-8?B?WkFLUVhQb2VyVG5ORnNQZkZsWVo4cDVaNW5Jd2pIZy9jMm1ZeTQzL3dQSm5Z?=
 =?utf-8?B?MWE2aFZqMmZ5c2tQNHp3L3hpY1R3ZjE1VXJiV0ZaRUIwdUZnUW1pWnB2Vmly?=
 =?utf-8?B?QmYwZmNtVnZyS0V6RzBBRE90MnB0a3gxa09ZNE5iYkVvQUtKWFVUQ2NhQzd6?=
 =?utf-8?B?WFZpeWRaWVZINmVoVTVQc2IvdlhXQXZTK0hLU0k2TTg0a2VGdE1YaDdjaEZ5?=
 =?utf-8?B?N01VZVQ2YktqL04vbTFtdUJvN1ZIUW1hejVMUEpxZTZETlRNS3d2cjllVGRi?=
 =?utf-8?B?ZWw2bTV4TXNsYTBiTHpuYUpvdnZ4dVVjNm11dFVweG41SUdpL2R3cVdVbDA4?=
 =?utf-8?B?YzlhQnFsYjlDSGZCSW5FREdvUmpzQWV2QktzUzA0bFl0cjVuZmorQ0xrMWx1?=
 =?utf-8?B?SU9McDZDMzVvRllRNlZ0NXVDWXluSnc2ZVlUMlQ5S01ITE5ZRDZ3bzlNcWRF?=
 =?utf-8?B?LzE5TTdzOHVUK1dETDJYSE5hTStyQk1LbUpMTlc0SjJDdHBQcWk3V29zUHZt?=
 =?utf-8?B?aFZIemFmdEtFNXpjeVYrdkQ2QTczWkVCZTMzSzFsREpqWm04NDVVbTIzRWJ5?=
 =?utf-8?B?eldLT0hTWVc2ejZ4Q0ZITlpPWXJ3aUM1TXZGNCt2NWdUZjUvUm9pUk8zVW5j?=
 =?utf-8?B?Rjc0a1F3cUp4S0FLYzdFYjZEZUEyY1ZnWW80ZG1WekRxc2E0Q3piSkFVdTVG?=
 =?utf-8?B?RVNscXdjOVZDQXgxTE1kMDQ5akFweXdpR3pBRTFHa3lPd1BuRldlcGNsL1ha?=
 =?utf-8?B?a2hCRVdZMitnMmFvdUFNZ1hqQjBnM0puN3JpT0FOMExBZk5zWVgyL0tlTmFF?=
 =?utf-8?B?NlV2R2wzQnZDTkxUUmozZ0hHRWdBQ0RhNGhYNGU5QTlpc0xWdzFTaXdrSUVa?=
 =?utf-8?B?ZlF4ZktKaFdmU21YSG9WZEIvdFY3aXpJUWE4TURjYm1pUzEydGdDejBJRFNQ?=
 =?utf-8?B?dUd4K01PRjVkbDdBbFY3N0ZrZ0lTNGZEYS91SGNpYlNDZHhEM2RuQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d44c933-a796-48ad-6e09-08de8013a1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 08:44:54.1398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oIOmwjALdC6T4sIvoPm+CyNL/2RgM4bGjApAjqCgcyptkmQ78T5xSvGnExpdQAPzncTvsHAmf6rZC/dRb588g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBNYXJjaCAyMDI2IDA4OjM5DQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE1hcmt1cw0K
PiBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gQ2M6IE5hdGhhbiBDaGVuIDxuYXRo
YW5jQG52aWRpYS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IGFybUBub25n
bnUub3JnOyBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT47IEVyaWMgQXVnZXINCj4gPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT47IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTaGFubm9u
IFpoYW8NCj4gPHNoYW5ub24uemhhb3NsQGdtYWlsLmNvbT47IE1pY2hhZWwgUyAuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPjsgSWdvcg0KPiBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT47
IEFuaSBTaW5oYSA8YW5pc2luaGFAcmVkaGF0LmNvbT47DQo+IFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+OyBEYW5pZWwgUC5CZXJyYW5nw6kNCj4gPGJlcnJhbmdlQHJlZGhhdC5j
b20+OyBBbGV4IFdpbGxpYW1zb24gPGFsZXhAc2hhemJvdC5vcmc+OyBFcmljIEJsYWtlDQo+IDxl
Ymxha2VAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS84XSBody9hcm0v
c21tdXYzLWFjY2VsOiBBZGQgaGVscGVyIGZvciByZXNvbHZpbmcNCj4gYXV0byBwYXJhbWV0ZXJz
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cw0KPiANCj4gDQo+IE9uIDMvMTIvMjYgMDk6MzMsIFNoYW1lZXIgS29sb3RodW0gVGhv
ZGkgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6
IDEyIE1hcmNoIDIwMjYgMDg6MjENCj4gPj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+PiBDYzogTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZp
ZGlhLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS0NCj4gPj4gYXJtQG5vbmdu
dS5vcmc7IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPjsgRXJpYyBBdWdlcg0KPiA+PiA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPjsgWmhlbnpob25nIER1YW4NCj4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT47DQo+ID4+IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFNoYW5ub24gWmhhbw0KPiA+PiA8c2hhbm5vbi56aGFvc2xAZ21haWwuY29tPjsgTWljaGFlbCBT
IC4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Ow0KPiA+PiBJZ29yIE1hbW1lZG92IDxpbWFtbWVk
b0ByZWRoYXQuY29tPjsgQW5pIFNpbmhhDQo+IDxhbmlzaW5oYUByZWRoYXQuY29tPjsNCj4gPj4g
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IERhbmllbCBQLkJlcnJhbmfDqQ0K
PiA+PiA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IEFsZXggV2lsbGlhbXNvbiA8YWxleEBzaGF6Ym90
Lm9yZz47IEPDqWRyaWMgTGUNCj4gPj4gR29hdGVyIDxjbGdAcmVkaGF0LmNvbT47IEVyaWMgQmxh
a2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAxLzhd
IGh3L2FybS9zbW11djMtYWNjZWw6IEFkZCBoZWxwZXIgZm9yDQo+ID4+IHJlc29sdmluZyBhdXRv
IHBhcmFtZXRlcnMNCj4gPj4NCj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5p
bmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4NCj4gPj4NCj4gPj4gU2hhbWVlciBLb2xvdGh1
bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+IHdyaXRlczoNCj4gPj4NCj4gPj4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gPj4NCj4gPj4gWy4uLl0NCj4gPj4NCj4gPj4+PiBOYXRo
YW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPiB3cml0ZXM6DQo+ID4+Pj4NCj4gPj4+Pj4gRnJv
bTogTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT4NCj4gPj4+Pj4NCj4gPj4+Pj4gSW50
cm9kdWNlIHNtbXV2M19hY2NlbF9hdXRvX2ZpbmFsaXNlKCkgdG8gcmVzb2x2ZSBwcm9wZXJ0aWVz
IHRoYXQNCj4gPj4+Pj4gYXJlIHNldCB0byAnYXV0bycgZm9yIGFjY2VsZXJhdGVkIFNNTVV2My4g
VGhpcyBoZWxwZXIgZnVuY3Rpb24NCj4gPj4+Pj4gYWxsb3dzIHByb3BlcnRpZXMgc3VjaCBhcyBB
VFMsIFJJTCwgU1NJRFNJWkUsIGFuZCBPQVMgc3VwcG9ydCB0bw0KPiA+Pj4+PiBiZSByZXNvbHZl
ZCBmcm9tIGhvc3QgSU9NTVUgdmFsdWVzLCB3aGlsZSBhdm9pZGluZyB0cmlnZ2VyaW5nDQo+ID4+
Pj4+IGF1dG8tcmVzb2x2ZWQgdmFsdWVzIGZvciBob3QtcGx1Z2dlZCBkZXZpY2VzLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBBdXRvIG1vZGUgcmVxdWlyZXMgYXQgbGVhc3Qgb25lIGNvbGQtcGx1Z2dlZCBk
ZXZpY2UgdG8gcmV0cmlldmUNCj4gPj4+Pj4gYW5kIGZpbmFsaXNlIHRoZXNlIHByb3BlcnRpZXMs
IGFuZCB3ZSBmYWlsIGJvb3QgaWYgdGhhdCBpcyBub3QgdGhlDQo+ID4+Pj4+IGNhc2UuDQo+ID4+
Pj4+DQo+ID4+Pj4+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIG1ha2UgdXNlIG9mIHRoaXMgaGVs
cGVyIHRvIHNldCB0aGUgdmFsdWVzDQo+ID4+Pj4+IHdoZW4gd2UgY29udmVydCB0aGUgdmFsdWVz
IHRvIE9uT2ZmQXV0by4gTmV3IGF1dG9fbW9kZSBhbmQNCj4gPj4+Pj4gYXV0b19maW5hbGlzZWQg
Ym9vbCBtZW1iZXJzIGFyZSBhZGRlZCB0byBTTU1VdjNBY2NlbFN0YXRlLg0KPiA+Pj4+PiBzbW11
djNfYWNjZWxfaW5pdCgpIHdpbGwgc2V0IGF1dG9fbW9kZSB0byB0cnVlIHdoZW4gJ2F1dG8nIGlz
DQo+ID4+Pj4+IGRldGVjdGVkIGZvciB0aGUgYWNjZWwgU01NVXYzIHByb3BlcnRpZXMuDQo+ID4+
Pj4+IHNtbXV2M19hY2NlbF9hdXRvX2ZpbmFsaXNlKCkgd2lsbCBzZXQgYXV0b19maW5hbGlzZWQg
dG8gdHJ1ZSBhZnRlcg0KPiA+Pj4+PiBhbGwgJ2F1dG8nIHByb3BlcnRpZXMgYXJlIHJlc29sdmVk
LCBhbmQgc3Vic2VxdWVudCBjYWxscyB0byB0aGlzDQo+ID4+Pj4+IGZ1bmN0aW9uIHdpbGwgcmV0
dXJuIGVhcmx5IGlmIGF1dG9fZmluYWxpc2VkIGlzIHNldCB0byB0cnVlLg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBTdWdnZXN0ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEu
Y29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gICBody9hcm0vc21tdXYzLWFjY2VsLmMgfCAzOA0K
PiA+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+Pj4+IC0tLQ0KPiA+
Pj4+PiAgIGh3L2FybS9zbW11djMtYWNjZWwuaCB8ICAyICsrDQo+ID4+Pj4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pj4+Pg0KPiA+Pj4+
PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jIGIvaHcvYXJtL3NtbXV2My1hY2Nl
bC5jIGluZGV4DQo+ID4+Pj4+IDE3MzA2Y2QwNGIuLjYxNzYyOWJhY2QgMTAwNjQ0DQo+ID4+Pj4+
IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+Pj4+PiArKysgYi9ody9hcm0vc21tdXYz
LWFjY2VsLmMNCj4gPj4+Pj4gQEAgLTM1LDExICszNSwzNCBAQCBzdGF0aWMgaW50IHNtbXV2M19v
YXNfYml0cyh1aW50MzJfdCBvYXMpDQo+ID4+Pj4+ICAgICAgIHJldHVybiBtYXBbb2FzXTsNCj4g
Pj4+Pj4gICB9DQo+ID4+Pj4+DQo+ID4+Pj4+ICtzdGF0aWMgdm9pZCBzbW11djNfYWNjZWxfYXV0
b19maW5hbGlzZShTTU1VdjNTdGF0ZSAqcywgUENJRGV2aWNlDQo+ID4+ICpwZGV2LA0KPiA+Pj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvbW11X2h3
X2luZm9fYXJtX3NtbXV2MyAqaW5mbykgew0KPiA+Pj4+PiArICAgIFNNTVV2M0FjY2VsU3RhdGUg
KmFjY2VsID0gcy0+c19hY2NlbDsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArICAgIC8qIFJldHVybiBp
ZiBubyBhdXRvIGZvciBhbnkgb3IgZmluYWxpc2VkIGFscmVhZHkgKi8NCj4gPj4+Pj4gKyAgICBp
ZiAoIWFjY2VsLT5hdXRvX21vZGUgfHwgYWNjZWwtPmF1dG9fZmluYWxpc2VkKSB7DQo+ID4+Pj4+
ICsgICAgICAgIHJldHVybjsNCj4gPj4+Pj4gKyAgICB9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAg
ICAvKiBXZSBjYW4ndCB1cGRhdGUgaWYgZGV2aWNlIGlzIGhvdHBsdWdnZWQgKi8NCj4gPj4+Pj4g
KyAgICBpZiAoREVWSUNFKHBkZXYpLT5ob3RwbHVnZ2VkKSB7DQo+ID4+Pj4+ICsgICAgICAgIHdh
cm5fcmVwb3J0KCJhcm0tc21tdXYzOiAnYXV0bycgZmVhdHVyZSBwcm9wZXJ0eQ0KPiA+Pj4+PiAr
IGRldGVjdGVkLCBidXQgaG9zdA0KPiA+Pj4+ICINCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgInZhbHVlIGNhbm5vdCBiZSBhcHBsaWVkIGZvciBob3QtcGx1Z2dlZCBkZXZpY2U7IHVzaW5n
ICINCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgImV4aXN0aW5nIHZhbHVlIik7DQo+ID4+
Pj4NCj4gPj4+PiBXaHkgaXMgdGhpcyB3YXJuaW5nIHVzZWZ1bD8NCj4gPj4+Pg0KPiA+Pj4+IERv
ZXMgQGF1dG8ncyBtZWFuaW5nIGRlcGVuZCBvbiB3aGV0aGVyIHRoZSBkZXZpY2UgaXMgY29sZC0g
b3INCj4gPj4+PiBob3QtcGx1Z2dlZD8NCj4gPj4+DQo+ID4+PiBJZiBTTU1VdjMgYWNjZWw9b24g
YW5kIHByb3BlcnRpZXMgYXJlIHNldCB0byAiYXV0byIsIHdlIHJlcXVpcmUgYXQNCj4gPj4+IGxl
YXN0IG9uZSBjb2xkLXBsdWdnZWQgdmZpby1wY2kgZGV2aWNlIHRvIHJldHJpZXZlIHRoZSBhc3Nv
Y2lhdGVkDQo+ID4+PiBob3N0DQo+ID4+PiBTTU1VdjMgaW5mb3JtYXRpb24gYW5kIGZpbmFsaXNl
IHRoZSBRRU1VIFNNTVV2MyBwcm9wZXJ0aWVzLg0KPiA+Pj4NCj4gPj4+IEluIHRoaXMgc2VyaWVz
LCAiYXV0b19tb2RlIiBpcyBzZXQgaWYgYW55IGFjY2VsIHByb3BlcnR5IGlzDQo+ID4+PiBzcGVj
aWZpZWQgYXMgImF1dG8iLiBUaGUgcHJvcGVydGllcyBhcmUgdGhlbiBmaW5hbGlzZWQgdXNpbmcg
dGhlDQo+ID4+PiBmaXJzdCBjb2xkLXBsdWdnZWQgZGV2aWNlIGFuZCAiYXV0b19maW5hbGlzZWQi
IGlzIHNldC4NCj4gPj4+DQo+ID4+PiBTaW5jZSB3ZSBsYXRlciBmYWlsIHRoZSBndWVzdCBib290
KHNlZSBiZWxvdykgaW4gdGhlIHJlc2V0IHBoYXNlIGlmDQo+ID4+PiBhdXRvX21vZGUgaXMgc2V0
IGJ1dCBhdXRvX2ZpbmFsaXNlZCBpcyBzdGlsbCBmYWxzZSwgdGhlIGFib3ZlDQo+ID4+PiBob3Rw
bHVnIGNhc2Ugc2hvdWxkIG5vdCByZWFsbHkgaGFwcGVuLiBJbiB0aGF0IGNhc2UgdGhlIFZNIHdv
dWxkIG5vdA0KPiBib290Lg0KPiA+Pg0KPiA+PiBTb3VuZHMgY29tcGxpY2F0ZWQuDQo+ID4+DQo+
ID4+PiBTbyBsaWtlbHkgd2UgY2FuIGdldCByaWQgb2YgdGhlIGhvdHBsdWcgY2hlY2sgYWJvdmUu
IE5lZWQgdG8gZG8gYQ0KPiA+Pj4gYml0IG1vcmUgdGVzdGluZyB0byBjb25maXJtIHdlIGNvdmVy
IGFsbCBjb3JuZXIgY2FzZXMuDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+ICsgICAgICAgIHJldHVy
bjsNCj4gPj4+Pj4gKyAgICB9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgICBhY2NlbC0+YXV0b19m
aW5hbGlzZWQgPSB0cnVlOyB9DQo+ID4+DQo+ID4+IFsuLi5dDQo+ID4+DQo+ID4+Pj4+IEBAIC04
NjcsOCArODkxLDEyIEBAIGJvb2wNCj4gPj4gc21tdXYzX2FjY2VsX2F0dGFjaF9nYnBhX2h3cHQo
U01NVXYzU3RhdGUNCj4gPj4+Pj4gKnMsIEVycm9yICoqZXJycCkNCj4gPj4+Pj4NCj4gPj4+Pj4g
ICB2b2lkIHNtbXV2M19hY2NlbF9yZXNldChTTU1VdjNTdGF0ZSAqcykgIHsNCj4gPj4+Pj4gLSAg
ICAgLyogQXR0YWNoIGEgSFdQVCBiYXNlZCBvbiBHQlBBIHJlc2V0IHZhbHVlICovDQo+ID4+Pj4+
IC0gICAgIHNtbXV2M19hY2NlbF9hdHRhY2hfZ2JwYV9od3B0KHMsIE5VTEwpOw0KPiA+Pj4+PiAr
ICAgIGlmIChzLT5zX2FjY2VsICYmIHMtPnNfYWNjZWwtPmF1dG9fbW9kZSAmJg0KPiA+Pj4+PiAr
ICFzLT5zX2FjY2VsLT5hdXRvX2ZpbmFsaXNlZCkNCj4gPj4+PiB7DQo+ID4+Pj4+ICsgICAgICAg
IGVycm9yX3JlcG9ydCgiQVVUTyBtb2RlIHNwZWNpZmllZCBidXQgcHJvcGVydGllcyBub3QgZmlu
YWxpc2VkLiIpOw0KPiA+Pj4+PiArICAgICAgICBleGl0KDEpOw0KPiA+Pj4+DQo+ID4+Pj4gSG93
IGNhbiB3ZSBnZXQgaGVyZT8NCj4gPj4+DQo+ID4+PiBUaGlzIGlzIHJlYWNoZWQgZnJvbSB0aGUg
U01NVXYzIHJlc2V0IGhhbmRsZXIgd2hlbiBhdXRvIG1vZGUgaXMNCj4gPj4+IHNwZWNpZmllZCBi
dXQgbm8gY29sZC1wbHVnZ2VkIGRldmljZSBoYXMgYmVlbiBhdHRhY2hlZCB0byBmaW5hbGlzZQ0K
PiA+Pj4gdGhlIGFjY2VsZXJhdGVkIFNNTVV2MyBwcm9wZXJ0aWVzLg0KPiA+Pj4NCj4gPj4+IElm
IG5vIHN1Y2ggZGV2aWNlIGlzIHByZXNlbnQsICJhdXRvX2ZpbmFsaXNlZCIgcmVtYWlucyBmYWxz
ZSBhbmQgd2UNCj4gPj4+IGhpdCB0aGlzIHBhdGggZHVyaW5nIHJlc2V0Lg0KPiA+Pj4NCj4gPj4+
IEPDqWRyaWMgbWVudGlvbmVkIHRoYXQgd2Ugc2hvdWxkIG5vdCBleGl0IGR1cmluZyB0aGUgcmVz
ZXQgcGhhc2UuIElmDQo+ID4+PiB0aGF0IGlzIHRoZSBjYXNlLCB3ZSBsaWtlbHkgbmVlZCBhbm90
aGVyIHdheSB0byBoYW5kbGUgdGhlIHNjZW5hcmlvDQo+ID4+PiB3aGVyZSBhdXRvIG1vZGUgaXMg
c3BlY2lmaWVkIGJ1dCBubyBjb2xkLXBsdWdnZWQgZGV2aWNlIGlzIHByZXNlbnQuDQo+ID4+DQo+
ID4+IFdoYXQgZXhhY3RseSBkb2VzIHRoZSAiYXV0byIgZmVhdHVyZSBidXkgdXM/ICBJcyBpdCB3
b3J0aCB0aGUNCj4gPj4gY29tcGxleGl0eT8NCj4gPg0KPiA+IFRoZSByZXF1aXJlbWVudCBjYW1l
IGZyb20gdGhlIEt1YmVWaXJ0IGZvbGtzLiBJdCBpcyBlYXNpZXIgZm9yIHRoZW0gaWYNCj4gPiBR
RU1VIGNhbiBwcm9iZSB0aGUgcGxhdGZvcm0gYW5kIHNldCB0aGVzZSB2YWx1ZXMsIGluc3RlYWQg
b2YNCj4gPiBzcGVjaWZ5aW5nIHRoZW0gZm9yIGVhY2ggcGxhdGZvcm0uDQo+ID4NCj4gPiBTZWU6
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9kOTE5MmFlNi1hOTRmLTQ3
OWEtYjE5Zi0NCj4gNzM0Y2M1MmE2YmUNCj4gPiAwQHJlZGhhdC5jb20vDQo+ID4NCj4gPiBXaXRo
b3V0ICJhdXRvIiwgdGhlIG1hbmFnZW1lbnQgbGF5ZXIgbmVlZHMgdG8ga25vdyB0aGUgdmFsdWVz
DQo+ID4gc3VwcG9ydGVkIG9uIGVhY2ggcGxhdGZvcm0uDQo+ID4NCj4gPiBlZzogb24gYSBHQjIw
MCwgaXQgd2lsbCBsb29rIGxpa2UsDQo+ID4NCj4gPiAtZGV2aWNlDQo+ID4gYXJtLXNtbXV2Myxw
cmltYXJ5LWJ1cz1wY2llLjEsaWQ9c21tdXYzLjAsYWNjZWw9b24sYXRzPW9uLHJpbD1vZmYsc3Np
ZA0KPiA+IHNpemU9MjAsb2FzPTQ4DQo+ID4NCj4gPiBXaXRoICJhdXRvIiBpdCBjYW4gc2ltcGx5
IGJlOg0KPiA+DQo+ID4gLWRldmljZSBhcm0tc21tdXYzLHByaW1hcnktYnVzPXBjaWUuMSxpZD1z
bW11djMuMCxhY2NlbD1vbg0KPiA+DQo+ID4gKHByb3ZpZGVkIGEgdmZpby1wY2kgZGV2aWNlIGlz
IGNvbGQtcGx1Z2dlZCkuDQo+IA0KPiBob3cgYWJvdXQsDQo+IA0KPiAgICAtZGV2aWNlIGFybS1z
bW11djMscHJpbWFyeS0NCj4gYnVzPXBjaWUuMSxpZD1zbW11djMuMCxhY2NlbD1vbixpb21tdWZk
PWlvbW11ZmQwDQo+IA0KPiBhbmQgc21tdXYzX2FjY2VsX2luaXQoKSB3b3VsZCBjaGVjayB0aGF0
IHRoZSBjb25kaXRpb25zIGFyZSBjb3JyZWN0Lg0KPiANCg0KV2UgbmVlZCBib3RoIGlvbW11ZmQg
YW5kIGlkZXYgZm9yIGlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8oKQ0KYXMga2VybmVs
IHVzZXMgdGhhdCB0byBmaW5kIHRoZSBob3N0IFNNTVV2MyBhdHRhY2hlZCB0byB0aGF0IGRldmlj
ZS4NCg0KLyoqDQogKiBzdHJ1Y3QgaW9tbXVfaHdfaW5mbyAtIGlvY3RsKElPTU1VX0dFVF9IV19J
TkZPKQ0KICogQHNpemU6IHNpemVvZihzdHJ1Y3QgaW9tbXVfaHdfaW5mbykNCiAqIEBmbGFnczog
TXVzdCBiZSAwDQogKiBAZGV2X2lkOiBUaGUgZGV2aWNlIGJvdW5kIHRvIHRoZSBpb21tdWZkDQou
Li4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

