Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A6BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNY2-0004Jk-M1; Thu, 18 Jul 2024 05:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNY1-0004FV-JI; Thu, 18 Jul 2024 05:35:37 -0400
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNXz-0004ne-Fi; Thu, 18 Jul 2024 05:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuMwKSjwLJPthyo8e3sRNluEyUjVXd2XMySaHSuiyst8gQSHHG6NCVkM7hdfoxTMGH9HnwkbFcE/2j1TQPPp5FM1zFOO2JJDJtkgnuW7ORfjtl6vOM76C62Qx5iH76fKDjP5u4/mHsRDY2nPRifp5gV1b+Lk+AIrtZ8AjmuD5dNk3gy4biaBLsaXCsHonhHIxztc0ZNfenitZmjsXXeR0U++/dpuWVmIfVOXSxgaNeEHSRAaGlWhAzoPEv68S4Lv4YOx7DzAKrxusU6dfKnGD7ATvFh7bzHufOgBdGG1e0yUA663l2+wCEDJHXGJWUOQFaKqNGcqsH9ooQd9PnK7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjWouwS491jVM5pKd/Fw/7yQidB6QcNqwTmKaJzr5bg=;
 b=FQOk8I2MEUImhaNxTM2z4RjO7LK3/+fauz03A8NXKMwuvSgiy9INZZK6VMDs56dC/sC7oMTHSPr6LBvuDaJ4XPAuoGcrDYIEafZi6/eHAcd13UFfvFYZKzhq6JFI/KXGQMsOhOnCRvMi9anNwXbEhquLltTj1xTrMQG2a4VdvZlJGpLnKCwq0kWIlysGQ8CUwdKUXPYMzpSG96xwpdnhn0e5+kPPJYJR5BfiGLY7mwhKgcvFkqBEVl7vlxR7esZ5+tKYa1lBgB4IjqQD9sfQJ8dlFErBoRx+j0N2IADCt350fUco6XVOqiMlEFaO2xiSKd0ahL1lJdjGwQg/nH9JNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjWouwS491jVM5pKd/Fw/7yQidB6QcNqwTmKaJzr5bg=;
 b=Yiuao79w6aoKeBCtzx0vDjYg+haHqLZS3pa8Dp1pVQKWIO4UpSYzZ3s2xZyofJYkfyLTFsJqSL9Psz181H4T30PAfws9kgijB4Xrvsmr+rUF4OO/fPSq9gvr88etgkGas0Demq0L3EEf7fNUc2oaTesPXryRVWpHv/Gwojs76BtXdgph5Jc0NP9YBRhxMTBEhkCmSUZt4FPOtGeCQ3vk1KLqGR2DWKidhaLPqVNNhcqtu2Ds15g/1T/ZC6CG/VistihjIGurAXFiREb4D5ZciVKLEiwi98TMSjJ8FTzng7+jbbdf7cljB47IXoE3btE/CWWDhlFZWJ5nFmPFx13Dvg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6586.apcprd06.prod.outlook.com (2603:1096:101:175::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Thu, 18 Jul 2024 09:35:27 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 09:35:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 09/15] hw/i2c/aspeed: Add AST2700 support
Thread-Topic: [PATCH v1 09/15] hw/i2c/aspeed: Add AST2700 support
Thread-Index: AQHa2N7H/NbJAv0qRE6V+U7Fs022arH8LaCAgAAL4eA=
Date: Thu, 18 Jul 2024 09:35:26 +0000
Message-ID: <SI2PR06MB5041213EDE10B81D9DBE745DFCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-10-jamin_lin@aspeedtech.com>
 <028d2b2b-05d9-4e45-9159-30b3685e2f04@kaod.org>
In-Reply-To: <028d2b2b-05d9-4e45-9159-30b3685e2f04@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6586:EE_
x-ms-office365-filtering-correlation-id: 697d4806-2f33-4b56-6790-08dca70cf4e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFlCVTkyTURsZnVXRm5ocUlHcStuWDkyZ1JPNkhvZnJ2aDZLN2VKR0lKQXp4?=
 =?utf-8?B?Q1c0T2pVQlQ3dEo1RTR3SThwckdCQ3IyMll3N01EYlVHZ1h5OEhIUkNmaVdX?=
 =?utf-8?B?U3lsc3h2T243Yno3Yk1JQmRCenNSa2dvWjMvMmZyNW95clFlSVkxWHdKdXpR?=
 =?utf-8?B?NVdjUDcvWDFFZkgyc2QrMlUrdWdSNWllTDFxS2hLRjVxZy9YOGdTTTg0N0xF?=
 =?utf-8?B?RUZ0WUVJdGN0SHR5N3lvazNHenorUXRXaVh6UEhhSU5oTU1WckF0SndIaTFX?=
 =?utf-8?B?dmVWWGErQ0dRalRLYlpYZ1JBb2RGanB6alVBTTRjQ1JHNExxN3NBUHRURzZw?=
 =?utf-8?B?eVNLM2NJVjZBY01RWDdqcG5JVWtwS3ZFU3dtUFhjcGJYNG1CZW0wbG9mVXcr?=
 =?utf-8?B?a0xsRmFXbTlTVGl1eVVXNUJwQnV3Zm5TeFhxM0lPMExveVc4c1luQlZQcm94?=
 =?utf-8?B?dEtFZnhlNDIyc1NrUHZqZldUTSt5enUyQVVCSHJ6TTl3OHNzekhISDNlM1JF?=
 =?utf-8?B?YURXeng4d3J2MktmSUhoS2ZjNHE4MEw3UE9wVDVXMzhpdG5aOEthK0JmNEo4?=
 =?utf-8?B?NGZGa2hsNFA0UE5pZWF4aDhZaUx0Y0J5M3RRRWVwU1J6MFVWVmQvbXdROFlo?=
 =?utf-8?B?M29pWHVSTVl3dTVkRFB3OFJ6bXIzYzZKRDVyRHpwK1VUMGhEY3RJbGNJVGVY?=
 =?utf-8?B?V3ovalB6Y1RzRDZJdk5HKzRvVGVxM3BFbHVoMEplYy8yOFlRY0RwaW02OHJJ?=
 =?utf-8?B?QmYrL3FiSnFRbzBQOUdhYXFVaHpLT3V6Q0p4cGVFS1hMN0RzL3ZlL2ZraW1t?=
 =?utf-8?B?R3RiakxJUHlyRXBmZzVYNXFCcW91b2VCMUIwV1lldTU2eXZvVWlpWUZRNzFi?=
 =?utf-8?B?cVUyeWdpa2dodytKTVpoVFg2Yk9tYWZyS0QvczRpODdLQ3lLL1JzNnhTb3Rn?=
 =?utf-8?B?NGs4ZkZwaU1HM1FPTklkaVlGNFlIZUxPTFdXODdKSm5qVElkeWV4M0drbmh2?=
 =?utf-8?B?MHgrWExyZCs1c2hTOWs0R09lNU5pN2NsYUJpRi9uOTVBeWRCZkhSaVZvb3Ux?=
 =?utf-8?B?VjlhNm1GZ2FDS1VzZ090Y1pCMWJvV0U1VTZZTGVXQURsUGNNN2V0TjdFaHVM?=
 =?utf-8?B?RkNsa1dKZlM4UHBvMjZvVkNPWHlCcVVhT2FxNmJuY2hpQ3hVQzAwTW5FdG1T?=
 =?utf-8?B?UnU2N2xmZ3NNSGdXTy9CT2lzNkl1dWJXb28yTFlqaTlrdlJodFJBSEV4R2Uw?=
 =?utf-8?B?Y0V3Um1JeXNSZkRCWFU1TEdJSERIYTFUWW9mU25MUFpXZ0xiZ3FIeGFZTzlp?=
 =?utf-8?B?cnp4QzVQR2hWcG5MeXpGWG83NFhCNFVOaHRXRC95TTYySWpWZ1RnaVF4OUkw?=
 =?utf-8?B?SWwyWVQ2eU16K2UxK1VhNWg5b2JnMi94cjNkbVd1a0ZReWdWRmFVa0hucDg0?=
 =?utf-8?B?TjhTWm15TW9LUmdTeWFhd3VQRGtwZWhGTC9xTmY3TUpoaEFUOEJZOU5kL3Vk?=
 =?utf-8?B?S1I1NWwxR3h4K1Q0N0l5NDloOU9FNlM3MTB5aS9VUnpHMjY2WUpYSDYrbEIx?=
 =?utf-8?B?Tk5CNHdoMWpOZnFUcURIakkzVUFzc0c1UHhUWnRNT09pMzFLbUFPOHBNSlNK?=
 =?utf-8?B?emtaSmI1M2srQXQza2ZnSm5hc01JekJXcTViRG4yRHZYZlBYL1VvZUhNelY4?=
 =?utf-8?B?WUcveHN4YUljMkVGYkhFL3JITVF0S1VPS1dlSGhBcDNoR1VXdUVOUG9HRGdU?=
 =?utf-8?B?R0RPYnVEY0tReGtoaUlkbmpvWGJEcEduV3puaWo5bkRSMlNKZHRlZ016ZkF6?=
 =?utf-8?B?VmxsUUkxVHFqaStpZlBIZ2EwZEtMTFg0L3pCWnF3MEdNSGMyQ0VtYnBxZzRQ?=
 =?utf-8?B?MVc5T2QwWGpSU2NDcjdaNUd2a1JIRUh5QTVpQjZLTHVrN2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTRwSFF6TFhwVk1qcnFySDZPM1FRS0tOQnFYckZSdHFNUnBhQWh4WGhYZmUw?=
 =?utf-8?B?a3VUN3N1Z1FRaUVYRlQyaDVDSmF2SDhPWlF4dGdHNG5nZlVoU2ovNmgzZDFZ?=
 =?utf-8?B?TTk3Z2ZsV1NzZCswM3FFc01TNzdYS05aTkNoTS9Sa3FGWTcveXlXcHNjVzlu?=
 =?utf-8?B?S2RPZTQ3SVVnbjE2VnZjQlVZOXRDMDhOcyt1N205QkNJSkQrUXNSeWxKc1pk?=
 =?utf-8?B?RnE0TkdDTVNhcWJuTGM4TDVCTG5HZHZiVUxOeWF5UVhYYm9CbjQvaDBMdkJR?=
 =?utf-8?B?VVZMSjJ6ZDd6aEdEWlJTS2NBWWd2TlU5QndzbTY0N0VocEcvTEhVbjZJSEN6?=
 =?utf-8?B?d0tlOUozbzJFQVZXL3JvSmR5YktHOCtwNkVJVVUxWkNuNkRrQzkvSnFaQTB5?=
 =?utf-8?B?amdOUklJK3VjNmcrYVlLUHJ1KzJMWGkreXdJUVc4SWFEODIxc3BaaWxKVTBt?=
 =?utf-8?B?LzJQSzZIdmt4TDQvU2ZOWHcyUDF0OWRpRVYraTdBK1hVV29QRFNPdFgrdVMx?=
 =?utf-8?B?emtsQWhoeGZRK3Vtdmpoem4xa1NPRHBCbmE3T1poYnpBYitSV3plN1ViU08w?=
 =?utf-8?B?UU9PZ0hhRVFNcUJWREhCUUFmL1k3MG1DWUF1QmNHWlpoRWJ2dFFKMEJLeGgr?=
 =?utf-8?B?eXNmTUFTZTM4a1EzempLdG91SFVDMHcvSndUdFg3TWdUWWRtcitGamV0NnlK?=
 =?utf-8?B?SE05NUZPY0t1UXhvcm8vQ3JHQy9ObXVmTWVLZ3RuREpUQjF1eExFVTFRdG05?=
 =?utf-8?B?M0JIek9GVVFrM1M5RFJTUEowVWZMWHNja2k1R0RHSjRONXJ4M3B6ZXdESEQ5?=
 =?utf-8?B?bEFTUS9xSHJ1eFpVenRzWXUyTENsSWZmZnlEd3pYR240SG5jb1VIM29ON3o4?=
 =?utf-8?B?cE04VlJoV3Z1V1pCVXU1ZkFpaEVZdG12YWk4cXVQSHUvemgxTFoyWW1neEVU?=
 =?utf-8?B?d2dwSm45MW1ESmRtMWNRQTNFRXRueG1JdjEvZXp0c0JwTWxaZStzOFUvTHFn?=
 =?utf-8?B?TU5GRmR5eUdkSlFWenVjZzZIbUx5Y0tvM2ZhTkEvcGNqcytUWXNwVTRJSWZT?=
 =?utf-8?B?YlY5WWxiaWtEZDQ2ZTNneE9Xc3hQQjVsM1BmSWJuNmlvd2luTXF5NVJTMkdT?=
 =?utf-8?B?cld3ei9WYmZuOGNsODA0aE9vRitKcUJYOW55ckdWMVFzMm9LU0ZVamU2MnRr?=
 =?utf-8?B?NXdCTGJqTkVBNFJCdHhQa1BoSjNXMFJuWkN3L3VtZlUrZzZNWVM3VzRWNm9N?=
 =?utf-8?B?aS9VVExYWmNUZXl0UXVRUnF2SDk4NHhEYmV2SkpWZjFxcHRPVEpUZFZZU2NV?=
 =?utf-8?B?VFBtMWx1Mjd6K0Z6WDlsdElJZ05JV0ZYT0RRTnZhaGtnSEFrcEM4a2hwY0Mv?=
 =?utf-8?B?Y2pLd001Q0k5NStFaCtBNXdiQUgwRkxJYlRrSk42QWFyaC9VU3kyc2NRK29w?=
 =?utf-8?B?THFEWU5KZFZEeWd0RkxtcnFJWURmeW5tSGRVNnI4YUtNTWRWaEZUMWVDQjV6?=
 =?utf-8?B?eHRabHNmbk5MaVZBYzBubVlHdzIvWEY1d0NDNlBESkVSakdnejZTUDdvWXhm?=
 =?utf-8?B?T3ZIcjZkU3hiM05zVUJMRHJxTmw2TEd3NWx6VW1yN0R0Znpic1RFaWxSNmJr?=
 =?utf-8?B?NytiWnNyWERyRnlKdnZCT3JudHMwVzErb254ZzRjdG4vNjFEd3NvN0FLYUh6?=
 =?utf-8?B?OXE2MlByWDFsZnRDVTlkSmFIRGFlMk1rZWxzd0w1ajdtaklpQnA0a2lUZlJa?=
 =?utf-8?B?aEpRRWdjMnFYZVpnaWEyV1ByY2tFYVJTakhJWEdqWGFoRWh4dHFjbTdXNnZz?=
 =?utf-8?B?RHE5bkEzYkxSdWpOZmN2RW5jV29ybTJHSGc5ODlJYzk3T3dWN2ZrTkIwSWFD?=
 =?utf-8?B?SDB1ZXFoaHRHMUpuVXlXWEpLdjlkM1grYTBUcE41dWg2Zk5yVlNmMU9FV3ZH?=
 =?utf-8?B?T0gzZ0VJdEtXY0tWeTR0NlBIYWxYZHI3UVFsc3oxb3N1UmpBMUR4TlMxK0JO?=
 =?utf-8?B?UnQzN2NqMjJWQnQrL1FZWmttcHFNL3hCZThYdU43YXhaV3lydDZJWHEvbjBL?=
 =?utf-8?B?TmVzSlBWMEtwVWxTODZvYytzMGh2OVNVbHlhTm5wYW1YTjd3U2FSanJubHIz?=
 =?utf-8?Q?iWu2mjRHsAOC/uQCEgQV6y5x8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697d4806-2f33-4b56-6790-08dca70cf4e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:35:26.9728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEFw3xOH6cDPbsP9S0lIVQZBNgAztlS8CHFPERKfPvtzWLLFCqTtnRydkt7Q5RlQiqnlseoGxiOS+1Fx87Sb3Q9zxW3F5CWpPVYZkGekvqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6586
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDkvMTVdIGh3L2kyYy9hc3Bl
ZWQ6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4NCj4gT24gNy8xOC8yNCAwODo0OSwgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IEludHJvZHVjZSBhIG5ldyBhc3QyNzAwIGNsYXNzIHRvIHN1cHBvcnQgQVNU
MjcwMC4NCj4gPiBUaGUgSTJDIGJ1cyByZWdpc3RlciBtZW1vcnkgcmVnaW9ucyBhbmQgSTJDIGJ1
cyBwb29sIGJ1ZmZlciBtZW1vcnkNCj4gPiByZWdpb25zIGFyZSBkaXNjb250aW51b3VzIGFuZCB0
aGV5IGRvIG5vdCBiYWNrIGNvbXBhdGlibGUgQVNUMjYwMC4NCj4gPg0KPiA+IEFkZCBhIG5ldyBh
c3QyNzAwIGkyYyBjbGFzcyBpbml0IGZ1bmN0aW9uIHRvIG1hdGNoIHRoZSBhZGRyZXNzIG9mIEky
Qw0KPiA+IGJ1cyByZWdpc3RlciBhbmQgcG9vbCBidWZmZXIgZnJvbSB0aGUgZGF0YXNoZWV0Lg0K
PiA+DQo+ID4gQW4gSTJDIGNvbnRyb2xsZXIgcmVnaXN0ZXJzIG93bnMgOEtCIGFkZHJlc3Mgc3Bh
Y2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2kyYy9hc3BlZWRfaTJjLmMgICAgICAgICB8IDYy
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUv
aHcvaTJjL2FzcGVlZF9pMmMuaCB8ICAxICsNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNjMgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3BlZWRfaTJjLmMgYi9o
dy9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+ID4gYzBkM2FjMzg2Ny4uMjlkNDAwYWM5MyAxMDA2
NDQNCj4gPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gKysrIGIvaHcvaTJjL2FzcGVl
ZF9pMmMuYw0KPiA+IEBAIC0xMTAxLDYgKzExMDEsNDEgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2ky
Y19pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPiA+ICAgICogICAweERBMCAuLi4gMHhEQkY6
IERldmljZSAxNCBidWZmZXINCj4gPiAgICAqICAgMHhEQzAgLi4uIDB4RERGOiBEZXZpY2UgMTUg
YnVmZmVyICgxNSBhbmQgMTYgdW51c2VkIGluIEFTVDEwMzApDQo+ID4gICAgKiAgIDB4REUwIC4u
LiAweERGRjogRGV2aWNlIDE2IGJ1ZmZlcg0KPiA+ICsgKg0KPiA+ICsgKiBBZGRyZXNzIERlZmlu
aXRpb25zIChBU1QyNzAwKQ0KPiA+ICsgKiAgIDB4MDAwIC4uLiAweDBGRjogR2xvYmFsIFJlZ2lz
dGVyDQo+ID4gKyAqICAgMHgxMDAgLi4uIDB4MTdGOiBEZXZpY2UgMA0KPiA+ICsgKiAgIDB4MUEw
IC4uLiAweDFCRjogRGV2aWNlIDAgYnVmZmVyDQo+ID4gKyAqICAgMHgyMDAgLi4uIDB4MjdGOiBE
ZXZpY2UgMQ0KPiA+ICsgKiAgIDB4MkEwIC4uLiAweDJCRjogRGV2aWNlIDEgYnVmZmVyDQo+ID4g
KyAqICAgMHgzMDAgLi4uIDB4MzdGOiBEZXZpY2UgMg0KPiA+ICsgKiAgIDB4M0EwIC4uLiAweDNC
RjogRGV2aWNlIDIgYnVmZmVyDQo+ID4gKyAqICAgMHg0MDAgLi4uIDB4NDdGOiBEZXZpY2UgMw0K
PiA+ICsgKiAgIDB4NEEwIC4uLiAweDRCRjogRGV2aWNlIDMgYnVmZmVyDQo+ID4gKyAqICAgMHg1
MDAgLi4uIDB4NTdGOiBEZXZpY2UgNA0KPiA+ICsgKiAgIDB4NUEwIC4uLiAweDVCRjogRGV2aWNl
IDQgYnVmZmVyDQo+ID4gKyAqICAgMHg2MDAgLi4uIDB4NjdGOiBEZXZpY2UgNQ0KPiA+ICsgKiAg
IDB4NkEwIC4uLiAweDZCRjogRGV2aWNlIDUgYnVmZmVyDQo+ID4gKyAqICAgMHg3MDAgLi4uIDB4
NzdGOiBEZXZpY2UgNg0KPiA+ICsgKiAgIDB4N0EwIC4uLiAweDdCRjogRGV2aWNlIDYgYnVmZmVy
DQo+ID4gKyAqICAgMHg4MDAgLi4uIDB4ODdGOiBEZXZpY2UgNw0KPiA+ICsgKiAgIDB4OEEwIC4u
LiAweDhCRjogRGV2aWNlIDcgYnVmZmVyDQo+ID4gKyAqICAgMHg5MDAgLi4uIDB4OTdGOiBEZXZp
Y2UgOA0KPiA+ICsgKiAgIDB4OUEwIC4uLiAweDlCRjogRGV2aWNlIDggYnVmZmVyDQo+ID4gKyAq
ICAgMHhBMDAgLi4uIDB4QTdGOiBEZXZpY2UgOQ0KPiA+ICsgKiAgIDB4QUEwIC4uLiAweEFCRjog
RGV2aWNlIDkgYnVmZmVyDQo+ID4gKyAqICAgMHhCMDAgLi4uIDB4QjdGOiBEZXZpY2UgMTANCj4g
PiArICogICAweEJBMCAuLi4gMHhCQkY6IERldmljZSAxMCBidWZmZXINCj4gPiArICogICAweEMw
MCAuLi4gMHhDN0Y6IERldmljZSAxMQ0KPiA+ICsgKiAgIDB4Q0EwIC4uLiAweENCRjogRGV2aWNl
IDExIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4RDAwIC4uLiAweEQ3RjogRGV2aWNlIDEyDQo+ID4gKyAq
ICAgMHhEQTAgLi4uIDB4REJGOiBEZXZpY2UgMTIgYnVmZmVyDQo+ID4gKyAqICAgMHhFMDAgLi4u
IDB4RTdGOiBEZXZpY2UgMTMNCj4gPiArICogICAweEVBMCAuLi4gMHhFQkY6IERldmljZSAxMyBi
dWZmZXINCj4gPiArICogICAweEYwMCAuLi4gMHhGN0Y6IERldmljZSAxNA0KPiA+ICsgKiAgIDB4
RkEwIC4uLiAweEZCRjogRGV2aWNlIDE0IGJ1ZmZlcg0KPiA+ICsgKiAgIDB4MTAwMCAuLi4gMHgx
MDdGOiBEZXZpY2UgMTUNCj4gPiArICogICAweDEwQTAgLi4uIDB4MTBCRjogRGV2aWNlIDE1IGJ1
ZmZlcg0KPiA+ICAgICovDQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfaTJjX3JlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgew0KPiA+IEBAIC0xNTAwLDYgKzE1
MzUsMzIgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF8xMDMwX2kyY19pbmZvID0gew0K
PiA+ICAgICAgIC5jbGFzc19pbml0ID0gYXNwZWVkXzEwMzBfaTJjX2NsYXNzX2luaXQsDQo+ID4g
ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF8yNzAwX2kyY19jbGFzc19pbml0KE9i
amVjdENsYXNzICprbGFzcywgdm9pZA0KPiA+ICsqZGF0YSkgew0KPiA+ICsgICAgRGV2aWNlQ2xh
c3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiArICAgIEFzcGVlZEkyQ0NsYXNzICph
aWMgPSBBU1BFRURfSTJDX0NMQVNTKGtsYXNzKTsNCj4gPiArDQo+ID4gKyAgICBkYy0+ZGVzYyA9
ICJBU1BFRUQgMjcwMCBJMkMgQ29udHJvbGxlciI7DQo+ID4gKw0KPiA+ICsgICAgYWljLT5udW1f
YnVzc2VzID0gMTY7DQo+ID4gKyAgICBhaWMtPnJlZ19zaXplID0gMHg4MDsNCj4gPiArICAgIGFp
Yy0+cmVnX2dhcF9zaXplID0gMHg4MDsNCj4gPiArICAgIGFpYy0+Z2FwID0gLTE7IC8qIG5vIGdh
cCAqLw0KPiA+ICsgICAgYWljLT5idXNfZ2V0X2lycSA9IGFzcGVlZF8yNjAwX2kyY19idXNfZ2V0
X2lycTsNCj4gPiArICAgIGFpYy0+cG9vbF9zaXplID0gMHgyMDsNCj4gPiArICAgIGFpYy0+cG9v
bF9nYXBfc2l6ZSA9IDB4ZTA7DQo+ID4gKyAgICBhaWMtPnBvb2xfYmFzZSA9IDB4MWEwOw0KPiA+
ICsgICAgYWljLT5idXNfcG9vbF9iYXNlID0gYXNwZWVkXzI1MDBfaTJjX2J1c19wb29sX2Jhc2U7
DQo+ID4gKyAgICBhaWMtPmhhc19kbWEgPSB0cnVlOw0KPiA+ICsgICAgYWljLT5tZW1fc2l6ZSA9
IDB4MTAwMDA7DQo+DQo+IEkgc2VlIGFuIG92ZXJsYXAgdGhlIFNMSSBtb2RlbC4gSXMgdGhpcyB2
YWx1ZSBjb3JyZWN0ID8NCj4NClllcywgaXQgaXMgaW5jb3JyZWN0IG1lbV9zaXplIHZhbHVlLg0K
V2lsbCB1cGRhdGUgbWVtX3NpemUgdG8gMHgyMDAwKDhLQikNClRoYW5rcyBmb3IgcmV2aWV3Lg0K
DQpKYW1pbg0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IEMuDQo+DQo+DQo+DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfMjcwMF9pMmNfaW5mbyA9IHsNCj4g
PiArICAgIC5uYW1lID0gVFlQRV9BU1BFRURfMjcwMF9JMkMsDQo+ID4gKyAgICAucGFyZW50ID0g
VFlQRV9BU1BFRURfSTJDLA0KPiA+ICsgICAgLmNsYXNzX2luaXQgPSBhc3BlZWRfMjcwMF9pMmNf
Y2xhc3NfaW5pdCwgfTsNCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfaTJjX3JlZ2lz
dGVyX3R5cGVzKHZvaWQpDQo+ID4gICB7DQo+ID4gICAgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMo
JmFzcGVlZF9pMmNfYnVzX2luZm8pOw0KPiA+IEBAIC0xNTA5LDYgKzE1NzAsNyBAQCBzdGF0aWMg
dm9pZCBhc3BlZWRfaTJjX3JlZ2lzdGVyX3R5cGVzKHZvaWQpDQo+ID4gICAgICAgdHlwZV9yZWdp
c3Rlcl9zdGF0aWMoJmFzcGVlZF8yNTAwX2kyY19pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lz
dGVyX3N0YXRpYygmYXNwZWVkXzI2MDBfaTJjX2luZm8pOw0KPiA+ICAgICAgIHR5cGVfcmVnaXN0
ZXJfc3RhdGljKCZhc3BlZWRfMTAzMF9pMmNfaW5mbyk7DQo+ID4gKyAgICB0eXBlX3JlZ2lzdGVy
X3N0YXRpYygmYXNwZWVkXzI3MDBfaTJjX2luZm8pOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICB0eXBl
X2luaXQoYXNwZWVkX2kyY19yZWdpc3Rlcl90eXBlcykNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9pMmMvYXNwZWVkX2kyYy5oIGIvaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oDQo+ID4g
aW5kZXggYmRhZWEzMjA3ZC4uNGYyM2RjMTBjMyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3
L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgN
Cj4gPiBAQCAtMzEsNiArMzEsNyBAQA0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF8yNTAwX0ky
QyBUWVBFX0FTUEVFRF9JMkMgIi1hc3QyNTAwIg0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF8y
NjAwX0kyQyBUWVBFX0FTUEVFRF9JMkMgIi1hc3QyNjAwIg0KPiA+ICAgI2RlZmluZSBUWVBFX0FT
UEVFRF8xMDMwX0kyQyBUWVBFX0FTUEVFRF9JMkMgIi1hc3QxMDMwIg0KPiA+ICsjZGVmaW5lIFRZ
UEVfQVNQRUVEXzI3MDBfSTJDIFRZUEVfQVNQRUVEX0kyQyAiLWFzdDI3MDAiDQo+ID4gICBPQkpF
Q1RfREVDTEFSRV9UWVBFKEFzcGVlZEkyQ1N0YXRlLCBBc3BlZWRJMkNDbGFzcywgQVNQRUVEX0ky
QykNCj4gPg0KPiA+ICAgI2RlZmluZSBBU1BFRURfSTJDX05SX0JVU1NFUyAxNg0KDQoqKioqKioq
KioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioN
CuWFjeiyrOiBsuaYjjoNCuacrOS/oeS7tijmiJblhbbpmYTku7Yp5Y+v6IO95YyF5ZCr5qmf5a+G
6LOH6KiK77yM5Lim5Y+X5rOV5b6L5L+d6K2344CC5aaCIOWPsOerr+mdnuaMh+WumuS5i+aUtuS7
tuiAhe+8jOiri+S7pembu+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7tuS5i+eZvOmAgeiA
hSwg5Lim6KuL56uL5Y2z5Yiq6Zmk5pys6Zu75a2Q6YO15Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A
5omA5pyJ6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI5L2cIQ0KDQpESVNDTEFJTUVSOg0KVGhp
cyBtZXNzYWdlIChhbmQgYW55IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBsZWdhbGx5IHByaXZp
bGVnZWQgYW5kL29yIG90aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUg
cmVjZWl2ZWQgaXQgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBl
LW1haWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgd2l0aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5b3Uu
DQo=

