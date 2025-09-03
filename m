Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DD2CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 01:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utcZI-0000z9-TJ; Tue, 02 Sep 2025 21:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utcZE-0000y7-N6; Tue, 02 Sep 2025 21:45:44 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utcZB-0003On-B3; Tue, 02 Sep 2025 21:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkH6ADhVk06jNhdo7LLeCg+viGwfpaC/BQCYcxBLSzGpVumtKXp2uc9KPm/0yL1k89ntoKq6py/w+prWXGhEgR6YBsO06obLPJfgUPuimX/roQcCHvDISb/6WFa0Na0mHVss10z6tan35S2kTZVldAg6gltTFL72dwdMrA7QMTLt6jJpJv0w4fhpgTVEFR627cDIeykDgQwMbaKWSjupE2qj+3yoR/i/oAY0NrLZnV8oNY+v82xkOYDsZO1jdaaXuEz+7ci/666ICyIh2ZaHCIDLyqE/Vh/whxvr6yE50efnC4oLgYUrITv2rm+atUUa63GVSH1/svEbAI5+gjBaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdqP+PEPeIyxZtV+EeGGS3Du+xsbBpYJQqNCIgFzfWk=;
 b=BUwUknFIYiojtNuFud6ra0onHAbBSjdoMlDswD3210Cn52aMvTnjldwdE+wmmDpMzSVqRf1Xu8gma2WZOJSRo7YzQCpazc6uZDDq28whFTexUZBFPG+KP4VnZdJWA1/MEWqL+yBwZqZkVDFP4eza/P3Qwm2e0G3zyJTnYcYlieqMisq6iK1WudE/vY9YT5bmYqcbdr1rPVzB9Ek45tzts5QiDIUi1ps3GiI43VsXi8yaO6FRJzj3OU3qmG+R1Ra8slO6nmrf3ByUBUw09QiMGe4dvxsGzlL1IStN7Jxezs7b+ZInjZngMgXIjrlAWitaHE+UMtgYkcpue5plZmES9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdqP+PEPeIyxZtV+EeGGS3Du+xsbBpYJQqNCIgFzfWk=;
 b=XDlmDyxvdsBBhj5pav/r60VEjzM12oFjF4d5tCZu8uNuJAYuXAj9oG+3IYzflsdE+tyhvXNiXx4Gm7qiUw/IuDeK7oAasNV3it0Zch+dqVB1q05Gpvm0A3igyNLBDVulc1jPNIAd/7+2UbXDxaaWQkb3R9b/eVcA92qFQ90GJw+GxGr3kMbNLq/+8+juKm2+kTDd/MiHkaXkQq1hfCTB1x+UUp+jk69kIWONwDieY3CtgPP6aaFyT/sptel9CNgz/lDAJ+YB91L2dnP/V2RQfc20DD0YW3/Avr56qvpnwuki63c0NtRYrpGpvYtm8NK8sdVWDG02qz/zkAjBhTlW2A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5081.apcprd06.prod.outlook.com (2603:1096:4:1c8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 01:45:33 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 01:45:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 04/21] hw/arm/aspeed_ast27x0-ssp: Switch SSP
 memory to SDRAM and use dram_container for remap support
Thread-Topic: [SPAM] [PATCH v1 04/21] hw/arm/aspeed_ast27x0-ssp: Switch SSP
 memory to SDRAM and use dram_container for remap support
Thread-Index: AQHb9sygLmoH16wr40+lQfNxdOfX1LR/yuGAgAEvQNA=
Date: Wed, 3 Sep 2025 01:45:33 +0000
Message-ID: <SI2PR06MB50419C1E44C1DA6E59A7EF77FC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-5-jamin_lin@aspeedtech.com>
 <96254526-949b-4db2-971e-fd0ea9f71e98@kaod.org>
In-Reply-To: <96254526-949b-4db2-971e-fd0ea9f71e98@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5081:EE_
x-ms-office365-filtering-correlation-id: 697939dd-b827-44df-9a45-08ddea8b9290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?VlAyTFgxM08vZWc4MEJFOCs1bjA2S3FyWlc5aDFjOXZCandMcHdHYVZiQUxp?=
 =?utf-8?B?QWY3WkdpNncvYURlSUVkdk5tNWZlSUJvSGFleno4TFlGRmE2WkZHTlJUVk91?=
 =?utf-8?B?K09lS2E5dHB4Z2J6WHF1TUN1Q1VjSitOcXh5WVJrWWtmVDZsTnpUVnlTWjdJ?=
 =?utf-8?B?WElvSmtvZGNDS01KOFhLemlSa1NDRnhzUklJbkxOTURNbm9TYkxGT2owWENN?=
 =?utf-8?B?WTNreUUvMitMd2RJelkzajBOZEJEcXM3RlBPWWhxa1dwNmlwNzFob2FsNUta?=
 =?utf-8?B?REUyU3ZHaTM1TzZxRDVISW4vRmxIZUtzM0xyUy9ZeEp4NDg2a0lPYjRwaXMx?=
 =?utf-8?B?TTNNSWdlSGdtR0dNQXRra21mWDFpSGVFN1FXekZ6eFRQbDcxakt5MVRlNkg2?=
 =?utf-8?B?L204eHdXKzBSVnhTQkV5UDhrOWIwcUdqQzlxNk5Oa0JUUzhUMTBVRVVITUdV?=
 =?utf-8?B?RVZ5aFBIUVc5ZVlqRnRXeEJqZDRVcUVKMkVxendxaVk5b2ZleEhPSTRwMHBQ?=
 =?utf-8?B?R05TTzRiSklWS2gwS0dySzBUcTlCRXI2WEJlSDEvWGhYa3QwLytFQUFzemxl?=
 =?utf-8?B?b3UzV2dyMVBPdE5mMnlwWXo5Z25jekxqUEpHRTU2S0hOWXpvMkhWR3VtbXpZ?=
 =?utf-8?B?ZmU1WFZYKzZJZFRiTlVHeTBBdDNRdDhkN1FiSzRrOFhGQjVJNHJwTW1LUWQr?=
 =?utf-8?B?ZU1aUDZzV3ErVExIR0RSWVlsUkI5cFdCTzBpYXprMk1QaXVNWUFtazQ3Ti9w?=
 =?utf-8?B?Mjg1aUtrRFppT3dwZVNEejI4dFVTU2RNUWJFaGdzaG5uWkRVL2xGQ3owUk80?=
 =?utf-8?B?L2p1c0xmTXBMbFVtZ0ZNWFFuNFZzeTFsa2VzWi90OG02eTNkZlRMUXlleWVI?=
 =?utf-8?B?NVhOOEd1enpEbTlLcW5nSDF1cGEycUZJeStRdWE4UnYvY1lPcWdwa08zRXJk?=
 =?utf-8?B?QjZ5dUhJaG1DS09LcVFqWVYrTldndDVkOGUrNUpCM0JIWlh4L1owaVpuUUNX?=
 =?utf-8?B?WFdzMkNnVTNORmRtMUZGaVAwTXVPQXdpaGJ3dW1MV2dGbTdtNHl1ak1HNGE5?=
 =?utf-8?B?bjl4blN2c3p0MHNpWGY3cTQ2dExvaEh3bUxpSnlqZ1oyWS9yZlpSYmZuR2ZY?=
 =?utf-8?B?Rm92cjFUZmZDN3JZK0xGVXdWaFI3RUR0U0g5cjFTREpwdjd0Z1o1U0ZaVEZ4?=
 =?utf-8?B?ckRjSUROaFlUSDhSMlFzSU0zSUdDNHVHWGp1YVFIYmt5ZmZWUHZRRkY5eTly?=
 =?utf-8?B?WmxTNkRQRjg0QnR1cXNmcExRREFsTXRFTFUwRm8wVk9RRnJzNi9WZ3NRalNy?=
 =?utf-8?B?RWNpdDhvd2p1SkJKVTJaVDdsOWgrSTRWZUZoUUl3WG9xQzB6c3licjdCaGJl?=
 =?utf-8?B?dG5ZN3BNbCtSbUZaZnBlWFQ0MFdYR3J6bFY1WlR2WHU5VUlScUZyWVBQNTRw?=
 =?utf-8?B?Uk9RbGFML0RUREV2TmFOcG9zUTZlclBacmNNUytkbERnSjlYam5Uc01MSjdh?=
 =?utf-8?B?M29FWXgrNXlieitiSTh6S1ZCaUZwYXZyNmVXOHB5dmEwbmFGZ0FFRFdtMU9G?=
 =?utf-8?B?bHlhUUQxSGZaT1RWd25qZ1BVM1l2cGRwNmduazdCMHFDUktpQmZCUnMySUNT?=
 =?utf-8?B?RnJnMGR6NXpIaHhzRUFDWjlGVFpVOWI1M2JZcHZuNVBLTFRZU0pwbUtjTzhY?=
 =?utf-8?B?WGo4Y0V6cjVxemJlUEYweXlqNXV2ajF1UmZpbndCcnF4NDhSMlB1SkRBcnlO?=
 =?utf-8?B?OWZIYytFREJjWGpWMXpDQjNZMnp4THNUV3MxOWltMytTU0tVQU5kdjIxRkM1?=
 =?utf-8?B?UFJWa0ZmdnJlbVlDaWduVkhqZzU1UVZzQjZpUUU2REJBUHdZOGVNQlBEbitz?=
 =?utf-8?B?eWg5MzZUYm5PbVZqVUlMMHp4NWd5U0Y2b01iZktaVVA5cGVMbHdoVktHN0Vi?=
 =?utf-8?B?dE1UQWkvWWVEQ0U3NUg0emFSeVFGTlpxek1uei9nbHJoZjlpcWdoS2VDbEw1?=
 =?utf-8?B?U3FpYStGazMvWWh0K2lIY1F6T2RLaFZjaUlTK09uSmdyNmhYbWloSmYyRUh2?=
 =?utf-8?Q?GvvNm9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRJZmQzSC9LZUxDbVV5MWxFdWhjNzUzbGtyQjFzcm5iNXZvbktlNFhwdlVy?=
 =?utf-8?B?Q083MGhPOWRCSDkvc3BzNXRqYVFTR3hiaHJUWEtEa0YvQXcyVVg3b1ZjdS9j?=
 =?utf-8?B?TEtlcERSZ3o5M1JZL1hudCtvQU91bW5EZGU4VFVyZlJmTVh5a1JpU3FFNzlU?=
 =?utf-8?B?em5Gd1ZDM0pDQWRpRzdlMXFUSUxtWlAvUkFheVh0cTgxTGtJODRZOUhreGxm?=
 =?utf-8?B?NVRtL3lzWWdGSHlLUUVLR21Ib0N0NFlGTE1XNldGMHNQYWhFMS84NGlUcFJl?=
 =?utf-8?B?QkV4ZEVMNFdHSkNTdXUyZ0lXTXdmUTNGL0doUmhGdEQ4cGhQcDVvbzdYY0d1?=
 =?utf-8?B?SVhwaE5NejJra0NXYUg0Z24rOEJBbFVwYVpjNktSYlpERXFvQjhBbU8vSmVM?=
 =?utf-8?B?dG9xbXlod1ZnL1IwNU1KRjk5UHhGUEd0NXhidzE2S2JrRTRiK1I3WlBEMWUw?=
 =?utf-8?B?b2ZIZWJZOG9EV2RNSlIzQjk2VXIyWWcwRENYV05nU3QxbGl4b2FPUENWUUNk?=
 =?utf-8?B?Q0JmK1Jta1p6SjFxWHNNVS9RZVFSQ3o4bGR2K2oyM2ZmV01Ga0Y1WStyRFI0?=
 =?utf-8?B?dlpGcGVGdFRMK1pVRVNMNlVEbUpydkp2cUFiaFdQQms2bzJlV1Y3RkswNXFI?=
 =?utf-8?B?M29ZR05EaktQUFJ1M1hLZmEvZkdiSjd6MUwwcEVrVUR6azdGSElZQzhqUFBl?=
 =?utf-8?B?UnJ1VkxFSlhaWjZUa1hMUktyK0F2Z1JXeG9SYm9ZZnRVMTFFMDlVaUx5dGlW?=
 =?utf-8?B?UGVpTnd6Yi8yUlIweTI2TGNSV00rUVJFbE8wOWdXNGpyVmQ3NmJjeXhYSkNH?=
 =?utf-8?B?NW9wV1RUM2dRMmplYnB2QmllcjZCRDNWQ0xuRVBGK3ViZjVxZlVqWlhoeDR2?=
 =?utf-8?B?T3Q3QjFMcWJVQVlYand3bHJlOGE2R2JtcDQwNTZkb3Vyb0FSRm5ZNVc4cWlS?=
 =?utf-8?B?Wm5xQktlVU5wWlVBcm5GVjM5REx5U2syU1V2WUNoRzZYZHVGVy9vRS9qdURY?=
 =?utf-8?B?blhLYUwzWU1NZm1kM3VLV2ZJTXYxcWQ4MTFGRHBjcFZzeE5rbndHRkNYL1lm?=
 =?utf-8?B?WUFIVmRIdWtnMTh0bmczNjhscjY0anhwRUhlK05XbkdvT21GNE42WXpnK2U3?=
 =?utf-8?B?RHJhaDVPZ2Y3a2xqQ0RUdEZGWUQvR2U5MGdWbmo0cGExSmNESXArUVBlTmdV?=
 =?utf-8?B?QkVNVEFyOHV1RXp1OWFoOElzN3dUWHJNeDMrdHFTTUczZFd0ampoYTVTcmRt?=
 =?utf-8?B?TkY3azUxazNzOUM5M25obnhUK013Q3J0cjcwT1Vic1YzcTdJZUtIcElDZ1Vj?=
 =?utf-8?B?TXZ4aHpNRnh5QUVFbkRhU1FJODNMYytoT2E2dTFtQ3lLNUNrcGc2b0hjdVA0?=
 =?utf-8?B?TEJmNHlpbnEzd2Z1RWpSUFF5ZWR5c0hJc1NLcFgraXovN2p2alpuQ3gwaTYy?=
 =?utf-8?B?VWNRVlh2b2x5eWZIN0lsMVIzVjR1T0dWb0NtWU13dGFIb2IvUmp5bVozdjdr?=
 =?utf-8?B?cjM3cUszaE9LUFY1a3NUS3JpQkZoa2EyNmZFQ0JUNHpBOTZoY3dyQVo5bS9s?=
 =?utf-8?B?RGNHUjdycFJKQk1kUHg3czFxODJJYy92dDBGYjJrODVyc2o0WitJcHNiUUVu?=
 =?utf-8?B?SGUxRjVLWXhYeS9xOTF3dlFVRzV4UnB4UStjVWIvNnRpTzQyN0xOM212T1hs?=
 =?utf-8?B?aVVjSU1YdTEwWXV5WlRTeVRrYjRpbFhwcHhPdTVEdTg2WDFnbDlNODdYb1U5?=
 =?utf-8?B?dUZMRVV1T3UrV0FNQTdYbjE4Q0oxZ3FxSzZscXhSZnhURkw2VEtFUTJ5VElu?=
 =?utf-8?B?NWZhMWdBajhORkF6MnRZZXVMUTVPV2dpdmZXT25wSmk2WXNLRThzMmVVeTFt?=
 =?utf-8?B?TjRrTDVKU0prajdWSklMQmFnU3N2M1FLQlJ3djJCbGI0UklFVVVySXRvSnc5?=
 =?utf-8?B?cmZkVEpnLzk5QjVwYllJNTh2UHBDRUtXYlRIWGtlbFI3RmpkakZ2dTlYTUcw?=
 =?utf-8?B?SGJoWHl2cStlNnBGaS9IWWh0R3V3ZXp1TmRPSzh5V1lQSkZZYW05ZGVRUkEx?=
 =?utf-8?B?ZS9FR3Jjd2R1UWhTZDUzTTFoT29IU21xckFkdUl1K3c0azZZY0R5bk5OM3lF?=
 =?utf-8?Q?+zmh6qxWfRd19HCH0b99Jvlrz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697939dd-b827-44df-9a45-08ddea8b9290
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 01:45:33.6631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoLT5h+46zLBCgDHA1MxSxA3ZJvR7fkxJakFgwI8m9zDFV/enszPLT9evH6emZ4Z7XO0MQpo1Ug9INVkpoIS9zbDdnPtcUi763fFj9VhtY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5081
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDA0LzIxXSBody9h
cm0vYXNwZWVkX2FzdDI3eDAtc3NwOiBTd2l0Y2ggU1NQDQo+IG1lbW9yeSB0byBTRFJBTSBhbmQg
dXNlIGRyYW1fY29udGFpbmVyIGZvciByZW1hcCBzdXBwb3J0DQo+IA0KPiBPbiA3LzE3LzI1IDA1
OjQwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBBU1QyNzAwIGRlc2ln
biwgdGhlIFNTUCBjb3Byb2Nlc3NvciB1c2VzIGl0cyBvd24NCj4gPiBTRFJBTSBpbnN0ZWFkIG9m
IFNSQU0uIEFkZGl0aW9uYWxseSwgYWxsIHRocmVlIGNvcHJvY2Vzc29yc+KAlFNTUCwgVFNQLA0K
PiA+IGFuZCBQU1DigJRzaGFyZSBhIGNvbW1vbiBTUkFNIGJsb2NrLiBJbiB0aGUgcHJldmlvdXMg
aW1wbGVtZW50YXRpb24sIHRoZQ0KPiA+IFNTUCBtZW1vcnkgcmVnaW9uIHdhcyBsYWJlbGVkIGFu
ZCBzaXplZCBhcyAiU1JBTSIsIGJ1dCBpbiBwcmFjdGljZSBpdA0KPiA+IHdhcyBiZWluZyB1c2Vk
IGFzIFNTUCdzIGxvY2FsIFNEUkFNLg0KPiANCj4gDQo+IFNvIHRoZSBTU1AgY29wcm9jZXNzb3Ig
aGFzIG5vIFNSQU0gPw0KDQpUaGFua3MgZm9yIHJldmlldy4NCg0KWWVzLCBib3RoIHRoZSBjb3By
b2Nlc3NvciBhbmQgdGhlIFBTUChDb3J0ZXggQTM1KSBzaGFyZSB0aGUgc2FtZSBTUkFNLg0KDQo+
IA0KPiANCj4gPg0KPiA+IFRoaXMgY29tbWl0IHVwZGF0ZXMgdGhlIFNTUCBtZW1vcnkgbWFwcGlu
ZyB0byByZWZsZWN0IHRoZSBjb3JyZWN0DQo+ID4gaGFyZHdhcmUNCj4gPiBkZXNpZ246DQo+ID4N
Cj4gPiAtIFJlcGxhY2UgdGhlIFNSQU0gcmVnaW9uIHdpdGggYSAiNTEyTUIgU0RSQU0iIHJlZ2lv
biBzdGFydGluZyBhdCAweDAuDQo+IA0KPiBJcyA1MTJNQiBhIHJlYWwgSFcgdmFsdWUgPw0KPiAN
Cg0KWWVzLCB0aGUgU0RSQU0gc2l6ZSBpcyA1MTJNQiBpbiBhIHJlYWwgSFcuDQoNCkphbWluDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+IC0gUmVuYW1lIHRoZSBpbnRl
cm5hbCB2YXJpYWJsZSBmcm9tICJzcmFtIiB0byAiZHJhbV9jb250YWluZXIiIGZvciBjbGFyaXR5
Lg0KPiA+IC0gVXNlICJBU1QyNzAwX1NTUF9TRFJBTV9TSVpFIiAoNTEyTUIpIGluc3RlYWQgb2Yg
dGhlIHByZXZpb3VzIDMyTUINCj4gU1JBTSBzaXplLg0KPiA+IC0gTWFwIHRoZSBuZXcgcmVnaW9u
IHVzaW5nICJBU1BFRURfREVWX1NEUkFNIiBpbnN0ZWFkIG9mDQo+ICJBU1BFRURfREVWX1NSQU0i
Lg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgYWxzbyBwcmVwYXJlcyBmb3IgZnV0dXJlIGVuaGFuY2Vt
ZW50cyB3aGVyZSBQU1AgRFJBTSB3aWxsDQo+ID4gYmUgcmVtYXBwZWQgaW50byB0aGlzIFNTUCBT
RFJBTSBjb250YWluZXIgdXNpbmcgc3VicmVnaW9ucyBhdCBzcGVjaWZpYw0KPiBvZmZzZXRzLg0K
PiA+IFVzaW5nICJkcmFtX2NvbnRhaW5lciIgbWFrZXMgaXQgZWFzaWVyIHRvIG1hbmFnZSBhbGlh
c2VzIGFuZCByZW1hcCBsb2dpYy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLXNzcC5jIHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAt
c3NwLmMNCj4gPiBpbmRleCA4MGVjNTk5NmMxLi45NjQxZTI3ZGUxIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0
Mjd4MC1zc3AuYw0KPiA+IEBAIC0xNSwxMCArMTUsMTAgQEANCj4gPiAgICNpbmNsdWRlICJody9t
aXNjL3VuaW1wLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcvYXJtL2FzcGVlZF9zb2MuaCINCj4gPg0K
PiA+IC0jZGVmaW5lIEFTVDI3MDBfU1NQX1JBTV9TSVpFICgzMiAqIE1pQikNCj4gPiArI2RlZmlu
ZSBBU1QyNzAwX1NTUF9TRFJBTV9TSVpFICg1MTIgKiBNaUIpDQo+ID4NCj4gPiAgIHN0YXRpYyBj
b25zdCBod2FkZHIgYXNwZWVkX3NvY19hc3QyN3gwc3NwX21lbW1hcFtdID0gew0KPiA+IC0gICAg
W0FTUEVFRF9ERVZfU1JBTV0gICAgICA9ICAweDAwMDAwMDAwLA0KPiA+ICsgICAgW0FTUEVFRF9E
RVZfU0RSQU1dICAgICA9ICAweDAwMDAwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0lOVENd
ICAgICAgPSAgMHg3MjEwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TQ1VdICAgICAgID0g
IDB4NzJDMDIwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfU0NVSU9dICAgICA9ICAweDc0QzAy
MDAwLA0KPiA+IEBAIC0xNjMsNyArMTYzLDcgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX3NvY19h
c3QyN3gwc3NwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldl9zb2MsIEVycm9yICoqZXJycCkNCj4g
PiAgICAgICBBc3BlZWRTb0NTdGF0ZSAqcyA9IEFTUEVFRF9TT0MoZGV2X3NvYyk7DQo+ID4gICAg
ICAgQXNwZWVkU29DQ2xhc3MgKnNjID0gQVNQRUVEX1NPQ19HRVRfQ0xBU1Mocyk7DQo+ID4gICAg
ICAgRGV2aWNlU3RhdGUgKmFybXY3bTsNCj4gPiAtICAgIGdfYXV0b2ZyZWUgY2hhciAqc3JhbV9u
YW1lID0gTlVMTDsNCj4gPiArICAgIGdfYXV0b2ZyZWUgY2hhciAqbmFtZSA9IE5VTEw7DQo+ID4g
ICAgICAgaW50IGk7DQo+ID4NCj4gPiAgICAgICBpZiAoIWNsb2NrX2hhc19zb3VyY2Uocy0+c3lz
Y2xrKSkgeyBAQCAtMTgwLDE2ICsxODAsMTcgQEAgc3RhdGljDQo+ID4gdm9pZCBhc3BlZWRfc29j
X2FzdDI3eDBzc3BfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2X3NvYywgRXJyb3IgKiplcnJwKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1Qocy0+bWVtb3J5KSwgJmVy
cm9yX2Fib3J0KTsNCj4gPiAgICAgICBzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmYS0+
YXJtdjdtKSwgJmVycm9yX2Fib3J0KTsNCj4gPg0KPiA+IC0gICAgc3JhbV9uYW1lID0gZ19zdHJk
dXBfcHJpbnRmKCJhc3BlZWQuZHJhbS4lZCIsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQ1BVKGEtPmFybXY3bS5jcHUpLT5jcHVfaW5kZXgpOw0KPiA+ICsgICAgLyogU0RS
QU0gKi8NCj4gPiArICAgIG5hbWUgPSBnX3N0cmR1cF9wcmludGYoImFzcGVlZC5zZHJhbS1jb250
YWluZXIuJWQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUoYS0+YXJtdjdt
LmNwdSktPmNwdV9pbmRleCk7DQo+ID4NCj4gPiAtICAgIGlmICghbWVtb3J5X3JlZ2lvbl9pbml0
X3JhbSgmcy0+c3JhbSwgT0JKRUNUKHMpLCBzcmFtX25hbWUsDQo+IHNjLT5zcmFtX3NpemUsDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCkpIHsNCj4gPiArICAgIGlm
ICghbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmcy0+ZHJhbV9jb250YWluZXIsIE9CSkVDVChzKSwg
bmFtZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBU1QyNzAwX1NTUF9T
RFJBTV9TSVpFLCBlcnJwKSkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgfQ0K
PiA+ICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzLT5tZW1vcnksDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2MtPm1lbW1hcFtBU1BFRURfREVWX1NSQU1d
LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5zcmFtKTsNCj4gPiAr
DQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9TRFJBTV0sDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJnMtPmRyYW1fY29udGFpbmVyKTsNCj4gPg0KPiA+ICAgICAgIC8qIFND
VSAqLw0KPiA+ICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPnNj
dSksIGVycnApKSB7IEBAIC0yNjgsNw0KPiA+ICsyNjksNiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRf
c29jX2FzdDI3eDBzc3BfY2xhc3NfaW5pdChPYmplY3RDbGFzcw0KPiA+ICprbGFzcywgY29uc3Qg
dm9pZCAqZGF0DQo+ID4NCj4gPiAgICAgICBzYy0+dmFsaWRfY3B1X3R5cGVzID0gdmFsaWRfY3B1
X3R5cGVzOw0KPiA+ICAgICAgIHNjLT5zaWxpY29uX3JldiA9IEFTVDI3MDBfQTFfU0lMSUNPTl9S
RVY7DQo+ID4gLSAgICBzYy0+c3JhbV9zaXplID0gQVNUMjcwMF9TU1BfUkFNX1NJWkU7DQo+ID4g
ICAgICAgc2MtPnNwaXNfbnVtID0gMDsNCj4gPiAgICAgICBzYy0+ZWhjaXNfbnVtID0gMDsNCj4g
PiAgICAgICBzYy0+d2R0c19udW0gPSAwOw0KDQo=

