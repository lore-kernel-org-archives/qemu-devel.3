Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414CBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 01:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQyvM-0008BI-OK; Thu, 26 Dec 2024 20:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQyvJ-0008AS-Sw; Thu, 26 Dec 2024 20:13:53 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQyvI-0008HQ-0D; Thu, 26 Dec 2024 20:13:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6m7VCg5Xi0h3145wl6+vLYQeFq9hmlgLUkCmaEGqDahwiKM9+HaPdiSo2ruoKcstlzj9ncTLeX4KkkA72w6A8VoiqJkE4OcXwRaEKZ2ZKpGgpLY56qyor85b7Il+tdYs39XdRppcSKnqGU1p9kSOsQoJhWTWaLZq6lBfT5zI5iWrmRjwu3UFPIN4+783jAYBlfIX5jUsHraIKVuBanWbSI3km17B0p+yVfim975ULcXpviosOEWHGaSOUq7rYNmO4oNWLgzrGD0wrVeHI7ujjnDU8tz+v5U4SOv1BmEENH/Z0LEjv2m3fg7UESoGp+jQtbPI1pK8qlYs/VmuVLMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4/V1LfQhx/uAm57y/aWCkxwL9IdCpL9l7jpgKaEIL8=;
 b=L6s70/Kiihg6Iq/XoWti8kndS0aXVgzvFEDTZLX2LB+M3j3S+MObzCjwkWgHPB8T0yUV7Jc+Uo6VmrNPwSaWRtxAlHRkv03v+QD9cx7hsT9EhxcIz9FzdcU2VCaFEi6hTFOgF5vNjumRU5QQvvYbDgFXzZus7VFAD8lRll4rz1PBxBCsa5qBZTwaKcMIk+AQ/ceNfv/Ug36eWmokT9rZ/KrbYWsLyieF/aGBIiQSE+2Q4eGwb3A0CZ2AzAdwCl1Pe7fakBQZDC5LFLMF8BugsAE3P2FtlvsQstFMYB+ERb9oUVbCD72WSrMDkJWZ5dN8ux7bxfKrTYjvHYcFDf9juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4/V1LfQhx/uAm57y/aWCkxwL9IdCpL9l7jpgKaEIL8=;
 b=WMZtpLHUSLzGq9+kqBnEag+1c42b2RgIFh5ii5iFTXb9db++TbwcZJuSB4yAzC7uS5HZpmVl4DfaA41CDzSQ6KQEq9TY440RTF6tdAo4xleXCPP0IATdX7X+4cRKFky2oydyTTJpv6pY7PxfFRBPkq1oFpxhq74H4MFhTIoBvhClJ8ReibmaHq+tE2iwJWrVQLed/FfBpDxFipdvvmTPsT6sPe4Lw/wC946e7WZaDYCP8klS1os2LUxzqm/KEuBPBR7ehgbJeZUZ5J/aiB9qaLIMegPEr4THRfzkE0G2MPhlRAXgTxLOURseiFsa0WuePyoYfuNYPFnM7sAObt4vuQ==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB6569.apcprd06.prod.outlook.com
 (2603:1096:101:189::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 01:13:44 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 01:13:44 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 4/5] aspeed: Introduce ast2700-fc machine
Thread-Topic: [PATCH 4/5] aspeed: Introduce ast2700-fc machine
Thread-Index: AQHbVnEtyUQmwSqPwEeXnQWj8XMsnLL207IAgAJ4DHA=
Date: Fri, 27 Dec 2024 01:13:43 +0000
Message-ID: <KL1PR0601MB4180304BBA564756932542D5850E2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-5-steven_lee@aspeedtech.com>
 <3a4545ab-d9e7-47d2-b89a-5dd1263de91e@linaro.org>
In-Reply-To: <3a4545ab-d9e7-47d2-b89a-5dd1263de91e@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB6569:EE_
x-ms-office365-filtering-correlation-id: 2abbf534-f109-438b-b2f8-08dd2613b505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2dmeW5CY1MyU0d2Wmg1c2lhN29VM1FOWkkveHZmdUcra0k1L1ZRWERJbTg3?=
 =?utf-8?B?K3FUbGxSMjEzZjM1R1BWY1VMWlgxZm9kR1JyOGs2UHp0ZXpUSC9UY3VxMzR4?=
 =?utf-8?B?Wk42OEdJUTZYS2grVVdHbGFMd0lDU1BQM3dUenZNamRjcmFmUCtjbmwxVm1V?=
 =?utf-8?B?OTMxRllLNjVGd040Nkc4cXo4eHYvR0Q2YTVhTkdIbStYRmJEdGxWaGdPeTdX?=
 =?utf-8?B?YWROdXlRUGpjY3g3emwyZURkdEtoaEpQNnBkZHhwMUdMeHZxZDlvSWo3UHpl?=
 =?utf-8?B?TWFVRVNGdDZXalpnTWFTWFozWlh2OVRuempsdEU2RjVBZnhUSGxVQnNQcWxU?=
 =?utf-8?B?ck81SW52bWZvN2RVNDRtTy9TSXlWbkFBOXVZdFVMTmVkUHUyRjdGbCtRMDJM?=
 =?utf-8?B?VE9CbVFUeGRZcUtQby9Gd2pob1F0TVhsUkwvaGxRZW1ncUxlSXU4M2lpQTVh?=
 =?utf-8?B?ZWZ1VUQvQkM1OHQvZ29kd1NwaFhxa3R3bjEvSWlEYUdBdU8rdE9xT3NFS1VE?=
 =?utf-8?B?bXpzTXlsN1c5ZkllVytpc2w5bTc3Q0w4M1hYRUovS1c1Q0R5QmFmb0o4TG5P?=
 =?utf-8?B?NGNXUE1tZzRIZlA0NVFWV1lsNkNNQ25OWnJsd0x4VmdwSTIyOFZrajZQYk5N?=
 =?utf-8?B?SHhhUEthTW5ha21OZXY0bGtrQWlFL2tFMTdEM0FKeVN6S0N4bkdqakxqaDMz?=
 =?utf-8?B?d3pJZFdid3N3UG5RZFNKN3Q2NlBCUzhlZzNwMERLeGNaREpOV280cmYrenJj?=
 =?utf-8?B?Sy90WW1VU3BkVWdweVRtTGU2b1Mwbm80UTR2cThiTWFRM05BTDZ6emNDK1JR?=
 =?utf-8?B?ZjB0c1RvVFo3bDBJTG12VEFPZzAvZjRyUVpOamhQb3p3VWpvYnhRUnhycFBh?=
 =?utf-8?B?ZzEzOEkxam9SeGNOOFZLN25Wcy9SVVpWanFTVmI4aFcxbDdIVXZTL0Q3M05X?=
 =?utf-8?B?aFBtY0Z1YXNhLzdnMlRFcnNKcDZWbmNERUU5QVdNRXBKR3NvRnN6cE1DQ0I2?=
 =?utf-8?B?UEY1SGl6QnR4R2JDbFl3YlNmbzBHSGZSRFh6djgwSmdrbUZtUW9sRWNnajRm?=
 =?utf-8?B?cE9NK0cveFBQTGFyNGJQcVZhaDM5WjZqMll1VXJPcWNlR09zMlpKYmdITmJJ?=
 =?utf-8?B?RVZXVFFkMDk4b0hFcmV6UWNvd0dTekRHOXhHWlRrcXpibUN6aXhIbkhsUFZj?=
 =?utf-8?B?SkZpM1VyOG5kV1pmMjZQM3F0RHFHOUdoR1VmeW01bm9OeVA4SkRyQzhIdjVS?=
 =?utf-8?B?NHA2RXhhU0dkSXBuRlB3RTY1dUJmSHJjOG5oVWJyN2plbWZ4MGpGSFEvdXg2?=
 =?utf-8?B?Y1VCY3hGS2VVYnc4elRkQUo2azB3bHFsS3JpNEhvZXNOQWJMbmM5VmRvOGtr?=
 =?utf-8?B?NzQ4RERxOTlVdGsyQjZERWw4SWU2anExTGlySGdPcTFVZi9zY3JEdzV1akVE?=
 =?utf-8?B?eU9FSHBLbVlwdXJGeDRVWGpFTWV2cGEvQ3BTWG9hTk55RWY2TGtoYUdaaTJt?=
 =?utf-8?B?ZE1qajJRMUN5T1dKMWRyME4xQ1pvUStOSVMvUWVGaVpSU04vdG1XUlRmcDdI?=
 =?utf-8?B?N0VlTHRYUXdoZWNMcUtzQ3FUNjdpTGJ2OVNjNWtDblFudE9PUzJkaE14MlVG?=
 =?utf-8?B?L1JQcGhSdDlIdkMwaU93aUxzd3k1WnhUZkF5YlB1Nm5FdUtkNVd2bXphWXpN?=
 =?utf-8?B?bjJTekhzWHRzUXJNOXd0bnFRK3VMbHUvYlJ6SmQ2TldBTXBweDdEeVk0Q3J1?=
 =?utf-8?B?UmNjdVJieC8ySjhTblU1TlVQdnZOOUZqMDJpa0x6NFBRdlVEUU5lVVdwVm9m?=
 =?utf-8?B?Vm1Sd0E3SWRwcTR5b2djNEZjYkZ0NG5sNjQ2L0FYaDZGRGhiODBQSEtlUUNo?=
 =?utf-8?B?aWdkbUFaRXhDb3NYMHlhZ2F4WFRNYnlhNTBqTHdGaHAxRlg4Sy9pUGIyNGZW?=
 =?utf-8?Q?xm7GvPmJMaB+MT6DQgfToAgDrEdch1jA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFpNZkZzTk1SdEhkWTFOb3pKa1hNbGVtN3Nibit5RU4yU1RUTk1BMUtWOGoz?=
 =?utf-8?B?N1ptRlFOSUliY3ljZkwwMkZlRk9zTXRXMmZXSHlVWERuandRcGN6bVZYUk03?=
 =?utf-8?B?TlM5NzZiaXZRTkp4bWpmSnNEalFwcE1kd0JTd0N2TThGV3FHWkxraVovdmRI?=
 =?utf-8?B?Yk9YYkFxcXUyQzFWM2NGNmprcVVuK3J4UkRMR08yeFl0OEZWYTZOM3gxVkRm?=
 =?utf-8?B?bUoza1ZkUlFzVlpXcTk0cmNRclhlR2xnV0VFaTR3YTBhekc4NXBmQVpUYlBx?=
 =?utf-8?B?VUJ4c3FZMEtvbVhMZ0lRclV3K2ZDeHVPQTZrb0NpRkgyeHhCNTVHdXM1VXJF?=
 =?utf-8?B?bFVaa3ZEaFFMdGFTZUJydjZRZVBCVURuUnpDdmh1TU1yZGdVRDlqSXQxQWpE?=
 =?utf-8?B?ZVFlQUttejZVOCtOSGhUSklRNTJTSyt5b0lOS0V4UjEvWFpZWSsva0p4TjRQ?=
 =?utf-8?B?UkdtOXhUaU5FeitSVm94Y2RZd3VWUUFFeURNV2FjbFRJMmZvOTN1RHd1VXNP?=
 =?utf-8?B?ME00SDE2b290WlNCTUhoZzdsZjc0WUtmSlBQbHJHOWR0ek0xUDBqb1lWWDYz?=
 =?utf-8?B?VmVTSmJ0eTRHdDZOMzc3WlZSMHorN0hBejcxRXRTU2pXY2hST2dCR0p4M1Mr?=
 =?utf-8?B?dzU3Y1ROMnFZQ1dVeDJjWUhXb3l0c1BMeEpNOGQwK2c5NThpQVRJb1N4bktZ?=
 =?utf-8?B?L2xwK2o1YmVORnBtL1dFNktTUTFFWWlmS2tLTEhGNTZpbGVwSE4wYWt0S0x2?=
 =?utf-8?B?MitqdCtYU09nOUhHY0ZjT24xdmhydm1xV2VKTzAxTWtSTHJQRnJEeGRYYngw?=
 =?utf-8?B?RUk1MmorMEhtdm9QQ3N4UVpGSDRUajZWRk5UeEVKc3JqK3pWSzFlMEkwT1BT?=
 =?utf-8?B?eEdwby8zY0g3OHpsZE95b0J0azYvNTJVdjNHdTg1MDFrOXdGaVh6cGltY2pR?=
 =?utf-8?B?dXVLL3Q3NVR5OHZvUFc1Y3paVXVxWEgzSlJ1d1JRY3JtcURTSnc3WFREcTFk?=
 =?utf-8?B?bXJFdUNwSDlIY0JYYlNsR1ZLVlJDMFB3bC9jN292NisyZDYzU3NtTDJUbW5i?=
 =?utf-8?B?bWx6YWVWbXZPcTB2WGhyNDNseG5XYTBYZS8rUXdZM0NRb01SZ3pqTHVoWHFj?=
 =?utf-8?B?dUZCRWFNWnE1L1o4a0VUN1FlWTRvYWc4amxrYkNZbVIwWHlPQk9jQXJMT2Vx?=
 =?utf-8?B?NS9wSXVNTXV2K0NlZnlGWFpkeU9ER1E0TEhOL2xXL0RPVy8xME0yUG5Tb2pE?=
 =?utf-8?B?MURNTHVZSXJBSkQwQjRpSTJUV1Z3R21TTHJobDVpWWFBWml0YkJabjZ1am9C?=
 =?utf-8?B?b1dSSEFDblFNayt2SGcrWm1ac25hWUZKTC9vZEZFZHA4Slkzb1cxaFRBSnRZ?=
 =?utf-8?B?bktaQ091K3lmNk9rT2txQnprSGdGbVNsd0M5ZFJ3cHNvOEZOaEw4QUFBamNT?=
 =?utf-8?B?R0I2dzdOYkpxSEc3WnlQQVRDVmdnWWxEMGhia1RHSW0zeWxNUnBpZUQ5cEFx?=
 =?utf-8?B?bnpsaWozNU5SYUlxNVVaRUc4dWpBYzdUb3hWUnhYVUU0VUFMZTV2U2RpQzhR?=
 =?utf-8?B?eXE2QVJEbVlWclJJQTYyOFhuTzZzQTNHdU5XbjZ1eGVnellOWEFFSjlJcllE?=
 =?utf-8?B?TVIydllhcmM4cndmcDV0Zk1NYWRQWHozdTY4eTdlNnQzcHI2YjlPSFRXY2tx?=
 =?utf-8?B?K3Y4L1VLSzZtOEtTT2VMalpsNCtKSjdhNmhFUGtVMzFvZmwwVFZSOXdKTjZ3?=
 =?utf-8?B?bEVWaW9aOUVabGxHc0w0Y0RKVFFJeS95TlB5d1JxUXZaemtTVFkrRFNkNnJx?=
 =?utf-8?B?eHdzS3AyNkZhNXNGUkswWkZDdFVaSGQ0T2NOMU5wdUs1eWRYR0VOc0FmcmZ0?=
 =?utf-8?B?b3Q1QUhyTXRBRDM3ZVZTYUdTNlJOdVZKbmczUDFFbE9ZTURCNEdod0Y3dm5J?=
 =?utf-8?B?U2Zod25TMndQWSt3MjlxUEdxLzl4MUtTZWxQZVRlcjRGNWdyREh1VHpmS29X?=
 =?utf-8?B?ejdzSnFIRkh3cFRZSXRWS2NYbThnZnZ6RjY5TTFFK1NVTGkrbHFLdkFXQ3la?=
 =?utf-8?B?ZWZjeDA1cTgwRnVZbkd1cUJwR3ROUldyT0dpaERvT0JzMmNJN0RIamRTSGoy?=
 =?utf-8?B?YUJpQkVqTDJGR2VBWTBJR2VIYnRrS3MrUUc4dFBnZnlkMmY4OWJFdHRTeGJK?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abbf534-f109-438b-b2f8-08dd2613b505
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 01:13:43.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTXWaKcU/JL9NXBR3koZ0E8pTBYPU4xVzTadxomZkUnPhzw/qPFaNtP4CGuPLRAbycvGbTviBRwLuwptrhVWckPZCbIwTMKzKiEdPRh5UVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6569
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIERlY2VtYmVyIDI1LCAyMDI0IDc6MzAgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9s
ZWVAYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA8Y2xnQGthb2Qub3JnPjsg
UGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUNCj4gPGxl
ZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBB
bmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFu
bGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1A
bm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVs
QG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZ
dW5saW4gVGFuZw0KPiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggNC81XSBhc3BlZWQ6IEludHJvZHVjZSBhc3QyNzAwLWZjIG1hY2hpbmUNCj4gDQo+
IEhpIFN0ZXZlbiwNCj4gDQo+IE9uIDI1LzEyLzI0IDAzOjAzLCBTdGV2ZW4gTGVlIHZpYSB3cm90
ZToNCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgbWFjaGluZSwgYXN0MjcwMC1mYywg
d2hpY2ggc3VwcG9ydHMgYWxsDQo+ID4gY29yZXMgYXZhaWxhYmxlIGluIHRoZSBBU1QyN3gwIFNv
Qy4gSW4gdGhpcyBtYWNoaW5lDQo+ID4gLSBUaGUgZmlyc3QgNCBjb3JlcyBhcmUgQ29ydGV4LUEz
NSBjb3Jlcy4NCj4gPiAtIENQVSA0IGlzIGRlc2lnbmF0ZWQgYXMgdGhlIFNTUCBjb3JlLg0KPiA+
IC0gQ1BVIDUgaXMgZGVzaWduYXRlZCBhcyB0aGUgVFNQIGNvcmUuDQo+ID4NCj4gPiBUZXN0IFN0
ZXA6DQo+ID4gICAgICB3Z2V0DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3pl
cGh5ci9yZWxlYXNlcy9kb3dubG9hZC8xLjAuMC9hc3QyNzAwLXNzDQo+IHAuZWxmDQo+ID4gICAg
ICB3Z2V0DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3plcGh5ci9yZWxlYXNl
cy9kb3dubG9hZC8xLjAuMC9hc3QyNzAwLXRzDQo+IHAuZWxmDQo+ID4gICAgICB3Z2V0DQo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3plcGh5ci9yZWxlYXNlcy9kb3dubG9hZC8x
LjAuMC9ibDMxLmJpbg0KPiA+ICAgICAgd2dldA0KPiBodHRwczovL2dpdGh1Yi5jb20vc3RldmVu
bGVlNzE4OS96ZXBoeXIvcmVsZWFzZXMvZG93bmxvYWQvMS4wLjAvdGVlLXJhdy5iaQ0KPiBuDQo+
ID4gICAgICB3Z2V0DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3plcGh5ci9y
ZWxlYXNlcy9kb3dubG9hZC8xLjAuMC91LWJvb3Qtbm9kDQo+IHRiLmJpbg0KPiA+ICAgICAgd2dl
dA0KPiBodHRwczovL2dpdGh1Yi5jb20vc3RldmVubGVlNzE4OS96ZXBoeXIvcmVsZWFzZXMvZG93
bmxvYWQvMS4wLjAvdS1ib290LmR0Yg0KPiA+ICAgICAgd2dldA0KPiBodHRwczovL2dpdGh1Yi5j
b20vc3RldmVubGVlNzE4OS96ZXBoeXIvcmVsZWFzZXMvZG93bmxvYWQvMS4wLjAvaW1hZ2UtYm0N
Cj4gYy50YXIuenN0DQo+ID4gICAgICB0YXIgLS16c3RkIC14dmYgaW1hZ2UtYm1jLnRhci56c3QN
Cj4gPg0KPiA+ICAgICAgcWVtdS1zeXN0ZW0tYWFyY2g2NCAtbWFjaGluZSBhc3QyNzAwZmMgXA0K
PiA+ICAgICAgICAtZGV2aWNlDQo+IGxvYWRlcixmb3JjZS1yYXc9b24sYWRkcj0weDQwMDAwMDAw
MCxmaWxlPXUtYm9vdC1ub2R0Yi5iaW4gXA0KPiA+ICAgICAgICAtZGV2aWNlIGxvYWRlcixmb3Jj
ZS1yYXc9b24sYWRkcj0kKCgweDQwMDAwMDAwMCArDQo+IDc0ODg5NikpLGZpbGU9dS1ib290LmR0
YlwNCj4gPiAgICAgICAgLWRldmljZSBsb2FkZXIsZm9yY2UtcmF3PW9uLGFkZHI9MHg0MzAwMDAw
MDAsZmlsZT1ibDMxLmJpblwNCj4gPiAgICAgICAgLWRldmljZSBsb2FkZXIsZm9yY2UtcmF3PW9u
LGFkZHI9MHg0MzAwODAwMDAsZmlsZT10ZWUtcmF3LmJpblwNCj4gPiAgICAgICAgLWRldmljZSBs
b2FkZXIsZmlsZT1hc3QyNzAwLXNzcC5lbGYsY3B1LW51bT00IFwNCj4gPiAgICAgICAgLWRldmlj
ZSBsb2FkZXIsZmlsZT1hc3QyNzAwLXRzcC5lbGYsY3B1LW51bT01IFwNCj4gPiAgICAgICAgLWRl
dmljZSBsb2FkZXIsY3B1LW51bT0wLGFkZHI9MHg0MzAwMDAwMDAgXA0KPiA+ICAgICAgICAtZGV2
aWNlIGxvYWRlcixjcHUtbnVtPTEsYWRkcj0weDQzMDAwMDAwMCBcDQo+ID4gICAgICAgIC1kZXZp
Y2UgbG9hZGVyLGNwdS1udW09MixhZGRyPTB4NDMwMDAwMDAwIFwNCj4gPiAgICAgICAgLWRldmlj
ZSBsb2FkZXIsY3B1LW51bT0zLGFkZHI9MHg0MzAwMDAwMDAgXA0KPiA+ICAgICAgICAtbSAxRyBc
DQo+ID4gICAgICAgIC1kcml2ZSBmaWxlPWltYWdlLWJtYyxpZj1tdGQsZm9ybWF0PXJhdyBcDQo+
ID4gICAgICAgIC1zZXJpYWwgcHR5IC1zZXJpYWwgcHR5IC1zZXJpYWwgcHR5IFwNCj4gPiAgICAg
ICAgLVMgLW5vZ3JhcGhpYw0KPiA+ICAgICAgY2hhciBkZXZpY2UgcmVkaXJlY3RlZCB0byAvZGV2
L3B0cy81MSAobGFiZWwgc2VyaWFsMCkNCj4gPiAgICAgIGNoYXIgZGV2aWNlIHJlZGlyZWN0ZWQg
dG8gL2Rldi9wdHMvNTIgKGxhYmVsIHNlcmlhbDEpDQo+ID4gICAgICBjaGFyIGRldmljZSByZWRp
cmVjdGVkIHRvIC9kZXYvcHRzLzUzIChsYWJlbCBzZXJpYWwyKQ0KPiA+DQo+ID4gICAgICB0aW8g
L2Rldi9wdHMvNTENCj4gPiAgICAgIHRpbyAvZGV2L3B0cy81Mg0KPiA+ICAgICAgdGlvIC9kZXYv
cHRzLzUzDQo+ID4gICAgICAocWVtdSkgYw0KPiANCj4gQ291bGQgd2UgaGF2ZSBhIGZ1bmN0aW9u
YWwgdGVzdCBpbmNsdWRlZCBpbiB0aGlzIHNlcmllcyBwbGVhc2U/DQo+IA0KDQpJIHdpbGwgYWRk
IGEgZnVuY3Rpb25hbCB0ZXN0Lg0KDQpUaGFua3MsDQpTdGV2ZW4NCg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4g
ICBody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyAgfCAyMTENCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gICBody9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgfCAg
IDQgKy0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCB8ICAxMiArKw0KPiA+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAyMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQoNCg==

