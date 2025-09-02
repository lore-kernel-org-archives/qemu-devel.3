Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CFFCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utMNo-0007r4-WE; Tue, 02 Sep 2025 04:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utMNl-0007qJ-M4; Tue, 02 Sep 2025 04:28:50 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utMNd-0007Uh-Hu; Tue, 02 Sep 2025 04:28:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3pjnlcxnRQwycDogX9reB+ZLnwcvSYJH52h9Tazr3K1PqSQ55247LnLodTmWLJTSRb8rfZuz7dcylCnMjseAfvFtoDbNXc3lQZ/eJsCNzJ6w8PxsWDfjmPJ8h4Yfdm8GiwDxPAyHUQFb26QSm4pt+OuHK+bx3aHQ9j7VyDLeMouCrrlEDvM2CNUfRh8fgQ0HRViyG6xzg/3KcB9Alr99CG6XyggS0JK4m3//2pWcySU4MkwFYifmuYsNMfpXdOkwo7loBwRQr3MA4RUVdzi8HVUZxMA2yEUMawR86OM+rK8ObhOoHqJASz+0JIDvFM9drNEcZKP3lMUfhUHGXnbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep5f+aFbfCUmZ35d47Ln3GtyDy4chvwk1Dz0EeUk9b0=;
 b=D0mt6LjyDYWi5etyMinSdYDQgXDA8ezfygNJhRz/Eps0Heh0J6Fx9I54x8xcjREyEz+GcSKvrSDwo+Hiw7LPVa3Z8/hxk6mMU6SWJ2zFyXiuRRmCMNeDCYjjBgn587IclYw+AL8Gfbmnyo7wW3KjGc2N5nAFj3C5iWKzbZlP6ZuzdBeLBoDJHvqo5RlzfTf/sJSlLQ7DfZbFmO07Mi7SlmT3Jul9OhG3+u4wNgLioDIbmj5uta6+vBxV5flNWs726zQ+5EzT4Y/SUNQYTAzXPC/6cwKWc060OmWtb9OwBz8k4z0iY1J8uhxpWenzHQWhMzQDykI8+Ej8sBubkXz81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep5f+aFbfCUmZ35d47Ln3GtyDy4chvwk1Dz0EeUk9b0=;
 b=p/IOfOjsnuY7up8xfYEhkvkWdKCclOhKEUA5FSOldrditPUeFt+DPbRE2faxQUf7rNpF0U5VnO3eFwNBRAKAfD2P8I+h1cT6E8N1TVmt724UyTe52m60A+NUcpPN8y0M1vd0oY3rmAabgK19wfGR+XOhtQj9G1KPhnVJzW4typVHFXRRzfz4iJbei3CaiVKTdrHtQiqhYn3QGyWDXgqxLyGwTNp2btcBVp//vgk/09r20hpNlPcTvO3sfNNn5ToGySzVAuDhpNNjVXWr0Sys+rtoySrcmGKgCHfi+O6nYBQvcv+aKCDDOP5qNH5tEjsGLAr5kz3htN7FEynXH7H2JA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5916.apcprd06.prod.outlook.com (2603:1096:101:dd::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 08:28:30 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:28:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support VBootRom
Thread-Topic: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support
 VBootRom
Thread-Index: AQHb9sydZv8OumUorEiKpzfB6N2+/rR/sJSAgAAmBtA=
Date: Tue, 2 Sep 2025 08:28:30 +0000
Message-ID: <SI2PR06MB5041202A90343458D2BE7724FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-2-jamin_lin@aspeedtech.com>
 <9e7ec38d-7bb9-4f1e-b75b-96c3eec97024@kaod.org>
In-Reply-To: <9e7ec38d-7bb9-4f1e-b75b-96c3eec97024@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5916:EE_
x-ms-office365-filtering-correlation-id: 933e6e0e-0d47-4971-ac27-08dde9fab2a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?VWNtdm9DQXJzSFZoVHM0aWdjb0FKYWFYejN5RXdFQ3ZXb1luQXloWEhFWVVo?=
 =?utf-8?B?NGRUR0ljaGsvMzE1czBDTjIyeCt4MG9tSk1kbTJXalZERDkxS3hTT2JGc3p2?=
 =?utf-8?B?MDNRMnk3MEQ4bzBUNDRsYlFwMko1VEdyWGg3N0ZnZFNqUEtudEduT0xoK1Uv?=
 =?utf-8?B?VGJGZXBER24rT2gwQ2dmMkxlT0dDVmlCR3lSajVXZ3k0alBUSjZnaEpsTGNB?=
 =?utf-8?B?RWpNb0sxTG15Wk44cXVwazhrSFR2aGltS21tWEQ0WnlkN29rTUdrUkVDcGk5?=
 =?utf-8?B?NXJlajNMU3ZxRnNPd20xSWJIdVplSG5jRW45Vk9EUkVJWHBKcUROOEU2OXlQ?=
 =?utf-8?B?ZUZXUU0rTytLemJ5VkdaU1VDRjU3S0ZlWU41T25TYXdhWkd1YUFLVXFTUUpH?=
 =?utf-8?B?RmIvUnNEbERqUDFXcGpPUlpFc2xWOCtVc011UlpFdC9tRWFJaFRSMU9qenFQ?=
 =?utf-8?B?czY2ci9ybCtUUERYbTlOdnR2WGFIbHptS0xuakk0K1JTMnZZYW9MWjNNSy9r?=
 =?utf-8?B?UWM3dEo4MEtLVnliQkwwV1dPek5idy9YYWZvTGIvNEVZVFhIVU1jUGFIb1dL?=
 =?utf-8?B?Z2hUbTRIbCtWamVyY2F4NGYrRkhPcnZtZFNTb0dPbWZQelMyTzQvOFpvQ1RZ?=
 =?utf-8?B?cXhtZmNEaFRSZDNNSEx1ZE85NjcwZnoxUW93eVhvMjdrd3RLdGN3Mk8yRGZE?=
 =?utf-8?B?eGRTSzZYT2R2Rk1acTlodTFPOTJTZCtDUzg3dzN6OTlvYmhQM1I5ZDhNdzdn?=
 =?utf-8?B?UTJBNm9KSzZVS0VSTVhLVGhtb0NmNkxITWszbENhVXpXNVZ6T0xHdjBXcFlD?=
 =?utf-8?B?ZjdBYW5NQlFyS2ZNMDlOWWpjT2h5Q0MxTTMwNkw4MXFmWFdsSFNKaDNJR3RG?=
 =?utf-8?B?ME40WWgrc2hHR2lrOEZlWnFCZUE0Smhmd3A1OWJzMlh4cm0zTzBJZllLeDZG?=
 =?utf-8?B?a05qSit1U0FYSmxXZ21PYWg2U01XK1dOUGZrTmRKcWxzbU9PSDZvSjlYY2lR?=
 =?utf-8?B?NGJyV0lVZjRmY0JQTThsSGE0ejFsc3FWYnZtZVNBckdhb3JWWmd3VGlmdlFh?=
 =?utf-8?B?VFF2SDVNUXd4eTJCMUF1eFU2Z0tLRHBGK3ptVEduRjB1dnBRdDRwN3V5SWhj?=
 =?utf-8?B?VnVueUtXTW9YV2ZVNlNEN0NSY254WW1waDArbUtrRFVtblRQNkJpMlZkRXdZ?=
 =?utf-8?B?a010aHlESVR2ZUQyUVdvQ3VmQStXNnI4TEVoMHJQemVob2pnZGJpeUFXeTdK?=
 =?utf-8?B?MlpJSVZTSEJhMHVpTXlKN3dFWU1nZWZkdzRyUlU5b1ZJVmZLK0RISE8rSllU?=
 =?utf-8?B?RkhPVC9rMlNKYUdYSG1idURJUG5iSmN3OGIwNkhwOUViSEZ2NC9FSGF6TmNk?=
 =?utf-8?B?eitEb2p2OXpheGVvd09GY2taUjVmam42MW9MN3lKZzl6c2xVanFweUdpL2RW?=
 =?utf-8?B?M0VkUTVpem1HY0tIZHM5c3AwZWJUVHp4Z3luc3JkKzR6enNxZVkxOWNCU1Fr?=
 =?utf-8?B?aXhjaXowR1JuUElKMGpUeU5odzhXVjIyVVpzYjA2QUsrdzhjTEdxS00rbWhr?=
 =?utf-8?B?T0tCUngrUk1oOEhuOHZobnBQYUFlQ0hQcHk4YkVJTzR3V2trUmR2K1NvQk5u?=
 =?utf-8?B?d1laTk1uRkZ3REJuL29mbXJmV2ZkTWhTRHA1UjB3SXVsMUgwWXBxSS9SUzE2?=
 =?utf-8?B?N3crQXJjOUJYZ284a3RVYXBQZDJIMUlSTGlna05BMGdWVjlIWnNjNXhBNUxw?=
 =?utf-8?B?WkR3NEltZmZuVTlOeXJ0QVFqL1VzbExzRkNyQ3NRQXdiWFd3V0pqRUFtTjdR?=
 =?utf-8?B?NjVNTkwzRjRmd2I4VUs4U1MzTEhjNzl4SjErLzB1TDI0Uyswb0FiQnEyVlQ0?=
 =?utf-8?B?UGlnWXhTQzhKeEFhSHh4RE8rUnJQVGswYnV2RDZxTmJDWUdvU3dlNHZGT1Zz?=
 =?utf-8?B?TDhWTlFHRGFEcWYxUExod0N0bkdOOWtkdUZPTUVjRUZXYnRlcldGUXdlK2s2?=
 =?utf-8?B?ZzJTNElwcHJqNGczV3Y5VE5zUW9VUW1SY1ZOR3IzcEVPeGl2M3ZRMTd2YkNl?=
 =?utf-8?Q?o0MXhV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NCtaQXRoMFJrdlFXK1Y5ZmczM0hoR1dpMGIxRk00cFN4ZE1iTW15MTA2M3JH?=
 =?utf-8?B?ejltek9kNlpHbVZ4VUhjQ0tHaHp5Sjc2cmxkcG5yY3NCM3JOamRpTDRDcXE5?=
 =?utf-8?B?ejNoUEFBMENRb1FqMjQrelRGUmVDU3AxdU4zOFRaakpieFZ0VkhFa3pnNk5D?=
 =?utf-8?B?dkpwWU5nUkE4TzR6RFdnZXJtay9DK2ZFNlBUK1R2VEZpZ1RibTZJV1UrVWF6?=
 =?utf-8?B?UnRDTXZXQkNoajlIbTg3Ui9zUjNGdDY4RGl0djBMQXpQVFgxeUlZTGV4cG1i?=
 =?utf-8?B?OFdXTll6WkxITDJtaFNMaHlUTmdWVnRvTE96bUJ3ZjFDK0owNWdWLzBCOWxZ?=
 =?utf-8?B?QVVibmNjdnErMU44cCtGYklEb0xucytHNmVObTIzYkU1RjVHdDIrdFQxTUs3?=
 =?utf-8?B?RHJhK3htYUpVWHVKZ1JXaUttQnhwQThNdTBTb0kraVUxdFJUdWNZcUoxNVdQ?=
 =?utf-8?B?N1J6S2xpNXJOL0YvOFZYc3lSdThCUm9ZK3pqeUc1ZlJ6UWJ6NDFXS3NFaWZw?=
 =?utf-8?B?MTR5QmllZkFXSVJ0WVl4QVA0a0p3T2M1ZmlsdVFsanQyWjJvWFFMRkk4czhu?=
 =?utf-8?B?cW9PRVJZUDdXZ042MWZHOUhlWEtLd2pNeVl5VUpkUTkvbEIyTWhuNXpmcUg3?=
 =?utf-8?B?N3hGMWRDSHQzZlFHNmI1YU1vOGh1cWFpRnpWbm5rK093SmVCUW5QTzN1UWQ1?=
 =?utf-8?B?YS9CZUtJelJJdkZvOGhSTG02SGowT2t6ekFCODQ0RFM0aGdOMFY1SnViaWRB?=
 =?utf-8?B?TXRldWYwd1ZjSUNQc3F4NS9tRnJNdTd2MTZEaHZpei8rWkJSWTJIczVHMDRO?=
 =?utf-8?B?UXJNMDdhcm8vZEYxcmw4dEhQT2djSEZ3MElhU3VBUWJpL2VOVE5sbENwT3p5?=
 =?utf-8?B?MnBLQXplc3JUVTdqeXFXalRsUGMzWEl5RUJCOTV3MHNGcGpGU3VHQzJGS1kv?=
 =?utf-8?B?N1pYNzlXOXU5QVRrRWhRcTVGdXQ5YU1TdWVDWFMzVFdER291VTVUQzkzM2Jh?=
 =?utf-8?B?dnROTDgwdDZlVW1uL2hEd20vaVN1WFRlQ0dQYUQwWW8xNmhSQjRSSCt0d2ky?=
 =?utf-8?B?SmdZMXFseVY3Qnl6Zm9KZlVScUl0bWxVZkZSazJPTEY3amVwa3NweUFhelYy?=
 =?utf-8?B?QjcvSWZSMWxUcFZiaThlNytFc29qQnZiN2hSVmtYazUxMXBxMW1OZFFvK3BU?=
 =?utf-8?B?YzZaS3YyeTQ2U1pQUXBidkFYOEtSMnE0ZW5rU1BhOUNVMGZYNzZLZFlMWWxB?=
 =?utf-8?B?bldWWXNBY2JzWGp6VmZhZ0ZGVFFNdHlpeGpuYlNpdlVCV1l4MTFoNU9IUU83?=
 =?utf-8?B?UWo5T1lJbnYzTWxJeUVBQkpoLzNyOG1NWno4MDRTQkFzdWxxTUc3YlBiKzIy?=
 =?utf-8?B?MDJ2L0haL3VlMlUzb0xubTNQSEdWOUdGUkF6TE9TeUVDMk1ydzhDV1RSZTRv?=
 =?utf-8?B?T2FUSktacGxUQTM1cWhXS1o0MUpQc21qS0dRL21QeVh1WGczdEhNUVI0UUVu?=
 =?utf-8?B?d293ZGExdWIxc3hyUC8zS0VSU2dtVkw5d0xGaGdVaDZvcHdEby8rekxzL01u?=
 =?utf-8?B?Z3grcjVGTENVZWZJaHFubGg1Um1iRll0ditrK204TFpBM0xFT1A2QTVFTlYr?=
 =?utf-8?B?SjJqVGs1M3BPeUZQMm5GSmNSU2RPWTBkS3I0SFIvWWhlSFJ4Qm5LaE9oMFNQ?=
 =?utf-8?B?NGJBNDVWQWxIS2NTNCtwUldiQnRKdUNTc25QajEvcXJ4bGpVRmdQV3RaV2M2?=
 =?utf-8?B?NGpERXd0bTVUMCs5UlNXcmQwVnF2RFg5aGdZU014T3FscC9UT0xqVWNOTTBM?=
 =?utf-8?B?Y0FQcHYyNldDMTJ2aDN3ZGVlS21FSU5NM1o0dWFGaWJwbkpsUXMwbGRISE5U?=
 =?utf-8?B?Z3RnSUdpamQ5QzZYZzU2MnB3cE9UR0d4UGh6L3psTWFHaXFIL2RzZUx5enV2?=
 =?utf-8?B?Snl6aFdHS1pWVkg3Z3Y3NzF6QXhFY0JUU0hLVnBjNDJxM2hESDJWaGZSQ1Ev?=
 =?utf-8?B?eTlWaGU3bDZJV0dnWGM3emFFL3h3cVo0QWZxQkRjYm8xMHVlbFBlRTIxMzFo?=
 =?utf-8?B?UWVMSngyYUNSVXpnRHV0VW1DVy9Rc1U4QUNFN21PVmNhRHpnck5ianhUdUQ2?=
 =?utf-8?Q?czAme6RvS7DT5KsKK6CXj/umN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e6e0e-0d47-4971-ac27-08dde9fab2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 08:28:30.4328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orbPEKaZd234ZywMu/Dk77gBWNm7kJ//CwgedOcUx6vcNIgPCFvSvRqlbrPvzR64yLCEOY2cvidCnBJdr64KOowvZnqUe7UAZRLLvA2VDQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5916
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAxLzIxXSBody9h
cm0vYXNwZWVkX2FzdDI3eDAtZmM6IFN1cHBvcnQNCj4gVkJvb3RSb20NCj4gDQo+IE9uIDcvMTcv
MjUgMDU6NDAsIEphbWluIExpbiB3cm90ZToNCj4gPiBJbnRyb2R1Y2VzIHN1cHBvcnQgZm9yIGxv
YWRpbmcgYSB2Ym9vdHJvbSBpbWFnZSBpbnRvIHRoZSBkZWRpY2F0ZWQNCj4gPiB2Ym9vdHJvbSBt
ZW1vcnkgcmVnaW9uIGluIHRoZSBBU1QyNzAwIEZ1bGwgQ29yZSBtYWNoaW5lLg0KPiA+DQo+ID4g
QWRkaXRpb25hbGx5LCBpdCBpbXBsZW1lbnRzIGEgbWVjaGFuaXNtIHRvIGV4dHJhY3QgdGhlIGNv
bnRlbnQgb2YNCj4gPiBmbWNfY3MwIGZsYXNoIGRhdGEoYmFja2VuZCBmaWxlKSBhbmQgY29weSBp
dCBpbnRvIHRoZSBtZW1vcnktbWFwcGVkDQo+ID4gcmVnaW9uIGNvcnJlc3BvbmRpbmcgdG8gQVNQ
RUVEX0RFVl9TUElfQk9PVC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFt
aW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLWZjLmMgfCA3NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1m
Yy5jDQo+ID4gaW5kZXggNzA4N2JlNDI4OC4uZTJlZWU2MTgzZiAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4
MC1mYy5jDQo+ID4gQEAgLTExLDYgKzExLDcgQEANCj4gPg0KPiA+ICAgI2luY2x1ZGUgInFlbXUv
b3NkZXAuaCINCj4gPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+ID4gKyNpbmNsdWRlICJx
ZW11L2RhdGFkaXIuaCINCj4gPiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4gICAjaW5j
bHVkZSAic3lzdGVtL2Jsb2NrLWJhY2tlbmQuaCINCj4gPiAgICNpbmNsdWRlICJzeXN0ZW0vc3lz
dGVtLmgiDQo+ID4gQEAgLTM1LDYgKzM2LDcgQEAgc3RydWN0IEFzdDI3MDBGQ1N0YXRlIHsNCj4g
Pg0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBjYTM1X21lbW9yeTsNCj4gPiAgICAgICBNZW1vcnlS
ZWdpb24gY2EzNV9kcmFtOw0KPiA+ICsgICAgTWVtb3J5UmVnaW9uIGNhMzVfYm9vdF9yb207DQo+
ID4gICAgICAgTWVtb3J5UmVnaW9uIHNzcF9tZW1vcnk7DQo+ID4gICAgICAgTWVtb3J5UmVnaW9u
IHRzcF9tZW1vcnk7DQo+ID4NCj4gPiBAQCAtNTUsMTIgKzU3LDY1IEBAIHN0cnVjdCBBc3QyNzAw
RkNTdGF0ZSB7DQo+ID4gICAjZGVmaW5lIEFTVDI3MDBGQ19IV19TVFJBUDIgMHgwMDAwMDAwMw0K
PiA+ICAgI2RlZmluZSBBU1QyNzAwRkNfRk1DX01PREVMICJ3MjVxMDFqdnEiDQo+ID4gICAjZGVm
aW5lIEFTVDI3MDBGQ19TUElfTU9ERUwgIncyNXE1MTJqdiINCj4gPiArI2RlZmluZSBWQk9PVFJP
TV9GSUxFX05BTUUgICJhc3QyN3gwX2Jvb3Ryb20uYmluIg0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQgYXN0MjcwMGZjX2NhMzVfbG9hZF92Ym9vdHJvbShBc3BlZWRTb0NTdGF0ZSAqc29jLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmJp
b3NfbmFtZSwNCj4gRXJyb3INCj4gPiArKiplcnJwKSB7DQo+ID4gKyAgICBnX2F1dG9mcmVlIGNo
YXIgKmZpbGVuYW1lID0gTlVMTDsNCj4gPiArICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAg
ZmlsZW5hbWUgPSBxZW11X2ZpbmRfZmlsZShRRU1VX0ZJTEVfVFlQRV9CSU9TLCBiaW9zX25hbWUp
Ow0KPiA+ICsgICAgaWYgKCFmaWxlbmFtZSkgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJy
cCwgIkNvdWxkIG5vdCBmaW5kIHZib290cm9tIGltYWdlICclcyciLA0KPiBiaW9zX25hbWUpOw0K
PiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICByZXQgPSBs
b2FkX2ltYWdlX21yKGZpbGVuYW1lLCAmc29jLT52Ym9vdHJvbSk7DQo+ID4gKyAgICBpZiAocmV0
IDwgMCkgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkZhaWxlZCB0byBsb2FkIHZi
b290cm9tIGltYWdlICclcyciLA0KPiBiaW9zX25hbWUpOw0KPiA+ICsgICAgICAgIHJldHVybjsN
Cj4gPiArICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXN0MjcwMGZjX2Nh
MzVfd3JpdGVfYm9vdF9yb20oRHJpdmVJbmZvICpkaW5mbywgaHdhZGRyIGFkZHIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJvbV9zaXplLCBF
cnJvcg0KPiA+ICsqKmVycnApIHsNCj4gPiArICAgIEJsb2NrQmFja2VuZCAqYmxrID0gYmxrX2J5
X2xlZ2FjeV9kaW5mbyhkaW5mbyk7DQo+ID4gKyAgICBnX2F1dG9mcmVlIHZvaWQgKnN0b3JhZ2Ug
PSBOVUxMOw0KPiA+ICsgICAgaW50NjRfdCBzaXplOw0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4g
KyAgICAgKiBUaGUgYmxvY2sgYmFja2VuZCBzaXplIHNob3VsZCBoYXZlIGFscmVhZHkgYmVlbiAn
dmFsaWRhdGVkJyBieQ0KPiA+ICsgICAgICogdGhlIGNyZWF0aW9uIG9mIHRoZSBtMjVwODAgb2Jq
ZWN0Lg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBzaXplID0gYmxrX2dldGxlbmd0aChibGspOw0K
PiA+ICsgICAgaWYgKHNpemUgPD0gMCkgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwg
ImZhaWxlZCB0byBnZXQgZmxhc2ggc2l6ZSIpOw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiAr
ICAgIH0NCj4gPiArDQo+ID4gKyAgICBpZiAocm9tX3NpemUgPiBzaXplKSB7DQo+ID4gKyAgICAg
ICAgcm9tX3NpemUgPSBzaXplOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHN0b3JhZ2Ug
PSBnX21hbGxvYzAocm9tX3NpemUpOw0KPiA+ICsgICAgaWYgKGJsa19wcmVhZChibGssIDAsIHJv
bV9zaXplLCBzdG9yYWdlLCAwKSA8IDApIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJmYWlsZWQgdG8gcmVhZCB0aGUgaW5pdGlhbCBmbGFzaCBjb250ZW50Iik7DQo+ID4gKyAgICAg
ICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJvbV9hZGRfYmxvYl9maXhl
ZCgiYXNwZWVkLmJvb3Rfcm9tIiwgc3RvcmFnZSwgcm9tX3NpemUsIGFkZHIpOyB9DQo+IA0KPiBU
aGUgYWJvdmUgaXMgZHVwbGljYXRlZCBjb2RlLiBDb3VsZCB3ZSB0cnkgdG8gaGF2ZSBjb21tb24g
cm91dGluZXMgaW5zdGVhZCA/DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rp
b24uDQoNClBlciBvdXIgZWFybGllciBkaXNjdXNzaW9uLCB3ZSBwbGFuIHRvIHJlZmFjdG9yIGh3
L2FybS9hc3BlZWQuYy4gQXMgYSBmaXJzdA0Kc3RlcCwgSSBjYW4gbW92ZSB0aGUgdmJvb3Ryb20g
aGVscGVycyBpbnRvIGEgY29tbW9uIHNvdXJjZSBmaWxlIHNvIHRoZXkgY2FuIGJlDQpyZXVzZWQg
Ynkgb3RoZXIgYm9hcmRzLg0KDQpEbyB5b3UgaGF2ZSBhIHByZWZlcmVuY2UgZm9yIHRoZSBmaWxl
bmFtZT8NCmh3L2FybS9hc3BlZWRfdXRpbHMuYyAod2l0aCBhIHNtYWxsIGhlYWRlciBpbiBpbmNs
dWRlL2h3L2FybS9hc3BlZWRfdXRpbHMuaCksDQoNCk9uY2UgdGhhdOKAmXMgaW4gcGxhY2UsIGFz
cGVlZF9hc3QyN3gwZi5jIGNhbiByZXVzZSB0aGVzZSBoZWxwZXJzIHRvIHN1cHBvcnQNCnZib290
cm9tIHdpdGggY29wcm9jZXNzb3JzLg0KDQpUaGFua3MtSmFtaW4NCg0KI2RlZmluZSBWQk9PVFJP
TV9GSUxFX05BTUUgICJhc3QyN3gwX2Jvb3Ryb20uYmluIg0Kc3RhdGljIHZvaWQgYXNwZWVkX2xv
YWRfdmJvb3Ryb20oQXNwZWVkTWFjaGluZVN0YXRlICpibWMsIGNvbnN0IGNoYXIgKmJpb3NfbmFt
ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCnN0YXRp
YyB2b2lkIGFzcGVlZF9pbnN0YWxsX2Jvb3Rfcm9tKEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jLCBC
bG9ja0JhY2tlbmQgKmJsaywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NF90IHJvbV9zaXplKQ0Kc3RhdGljIHZvaWQgd3JpdGVfYm9vdF9yb20oQmxvY2tCYWNrZW5k
ICpibGssIGh3YWRkciBhZGRyLCBzaXplX3Qgcm9tX3NpemUsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApDQo+IA0KPiA+ICAgc3RhdGljIHZvaWQgYXN0MjcwMGZjX2Nh
MzVfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4gICB7DQo+ID4gICAgICAgQXN0Mjcw
MEZDU3RhdGUgKnMgPSBBU1QyNzAwQTFGQyhtYWNoaW5lKTsNCj4gPiArICAgIGNvbnN0IGNoYXIg
KmJpb3NfbmFtZSA9IE5VTEw7DQo+ID4gICAgICAgQXNwZWVkU29DU3RhdGUgKnNvYzsNCj4gPiAg
ICAgICBBc3BlZWRTb0NDbGFzcyAqc2M7DQo+ID4gKyAgICB1aW50NjRfdCByb21fc2l6ZTsNCj4g
PiArICAgIERyaXZlSW5mbyAqbXRkMDsNCj4gPg0KPiA+ICAgICAgIG9iamVjdF9pbml0aWFsaXpl
X2NoaWxkKE9CSkVDVChzKSwgImNhMzUiLCAmcy0+Y2EzNSwgImFzdDI3MDAtYTEiKTsNCj4gPiAg
ICAgICBzb2MgPSBBU1BFRURfU09DKCZzLT5jYTM1KTsNCj4gPiBAQCAtMTE4LDYgKzE3MywyNiBA
QCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfY2EzNV9pbml0KE1hY2hpbmVTdGF0ZQ0KPiAqbWFjaGlu
ZSkNCj4gPiAgICAgICBhc3QyNzAwZmNfYm9hcmRfaW5mby5yYW1fc2l6ZSA9IG1hY2hpbmUtPnJh
bV9zaXplOw0KPiA+ICAgICAgIGFzdDI3MDBmY19ib2FyZF9pbmZvLmxvYWRlcl9zdGFydCA9DQo+
ID4gc2MtPm1lbW1hcFtBU1BFRURfREVWX1NEUkFNXTsNCj4gPg0KPiA+ICsgICAgLyogSW5zdGFs
bCBmaXJzdCBGTUMgZmxhc2ggY29udGVudCBhcyBhIGJvb3Qgcm9tLiAqLw0KPiANCj4gVGhpcyBp
cyBhIGZpcnN0IGFkZGl0aW9uIGZvciB0aGUgYXN0MjcwMGZjIG1hY2hpbmUgYW5kIC4uLg0KPiAN
Cj4gPiArICAgIGlmICghcy0+bW1pb19leGVjKSB7DQo+ID4gKyAgICAgICAgbXRkMCA9IGRyaXZl
X2dldChJRl9NVEQsIDAsIDApOw0KPiA+ICsNCj4gPiArICAgICAgICBpZiAobXRkMCkgew0KPiA+
ICsgICAgICAgICAgICByb21fc2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6ZSgmc29jLT5zcGlfYm9v
dCk7DQo+ID4gKyAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faW5pdF9yb20oJnMtPmNhMzVfYm9v
dF9yb20sIE5VTEwsDQo+ICJhc3BlZWQuYm9vdF9yb20iLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJvbV9zaXplLCAmZXJyb3JfYWJvcnQpOw0KPiA+ICsNCj4gbWVt
b3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uX292ZXJsYXAoJnNvYy0+c3BpX2Jvb3RfY29udGFpbmVy
LCAwLA0KPiA+ICsNCj4gJnMtPmNhMzVfYm9vdF9yb20sIDEpOw0KPiA+ICsgICAgICAgICAgICBh
c3QyNzAwZmNfY2EzNV93cml0ZV9ib290X3JvbShtdGQwLA0KPiA+ICsNCj4gc2MtPm1lbW1hcFtB
U1BFRURfREVWX1NQSV9CT09UXSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcm9tX3NpemUsDQo+ICZlcnJvcl9hYm9ydCk7DQo+ID4gKyAgICAgICAgfQ0K
PiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIC8qIFZCT09UUk9NICovDQo+IA0KPiAuLi4gdGhp
cyBpcyBhIHNlY29uZC4gQ291bGQgeW91IHBsZWFzZSBzcGxpdCB0aGUgY2hhbmdlcyA/DQo+IA0K
DQpXaWxsIGRvDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+
ICsgICAgYmlvc19uYW1lID0gbWFjaGluZS0+ZmlybXdhcmUgPzogVkJPT1RST01fRklMRV9OQU1F
Ow0KPiA+ICsgICAgYXN0MjcwMGZjX2NhMzVfbG9hZF92Ym9vdHJvbShzb2MsIGJpb3NfbmFtZSwg
JmVycm9yX2Fib3J0KTsNCj4gPiArDQo+ID4gICAgICAgYXJtX2xvYWRfa2VybmVsKEFSTV9DUFUo
Zmlyc3RfY3B1KSwgbWFjaGluZSwNCj4gJmFzdDI3MDBmY19ib2FyZF9pbmZvKTsNCj4gPiAgIH0N
Cj4gPg0KDQo=

