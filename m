Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E222C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfFUy-0006Kg-96; Tue, 04 Feb 2025 04:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfFUt-0006K4-TW; Tue, 04 Feb 2025 04:45:36 -0500
Received: from mail-psaapc01on20727.outbound.protection.outlook.com
 ([2a01:111:f403:200e::727]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfFUs-0003sI-F8; Tue, 04 Feb 2025 04:45:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy3LCz4kofwr7y7nvfLaeo1aKkh8at/PFl0BId//6Gh5EznHA7aDr93Ot+PBxa2CYTBZtRL7OkJtjaLYMsvXKh75x7+/6MVI+D/607Fwztf+ZIsqQ5/t+RJcb+bVeZt7CqoqYDz+munf0i3QRO2ZhRkiK/+OrGmknDnhOL0gQTQitii3ujTFDF+DZRzAECoawRoCIXc0CoHzm7JLfZdgzVCr+PUTECJPAMl8RIfzv7L+KMXvUg6DelHlpYKi+I/tLFQXohxdfrBs4Rbw5ayE0DsUUSq3nkCViC3BOySJ0XWJhYqD4in0pv3L+OjJ4SAMZRDypct8pRx5jvWxNV5vWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OTZ7ejh8HI3k71X+kpd1ewexjvTndCWHBzWkxcFkyQ=;
 b=leeARFiq4nWG6RZvVlCwRplGe6rP13n+CV0tCUeqxXYlW4JZvin5tiSADtK3fREpnq4QmqqCtSaw7njDj5ibGrbmqUbPc/+VvYblZwqUrNkG1hc55ruPwYq9W7oJHokqLKW78PrQRHtqMtebHo1GIZoTcsKSfNUsCbIi7hzU3NeA3Wfn4jTBxohP5iMzroGdVI2dmNAS94D/MUKyOK0hviJ1lGWHXqQJAgCXMiAH9Wxv+VdavhLxgEUKUriNYxSrIlgD02MGCYM1ZrIDf2JbdL06hNuYVKSQ5Rfhujv0pmqJAVZ1T7j3SbChJ6vkmWs2Qvr9W2wxa7cottvAANU5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OTZ7ejh8HI3k71X+kpd1ewexjvTndCWHBzWkxcFkyQ=;
 b=kd1ILdqsj6WJYUUKc1rKMG1HpDE5qPNekIPG0DgaNogCmiXLGVGqpFMC/2xo+atkuaqy4WG5+S90NS1OMzkJF7/8NjVzEKUPL1p/sK+fAtSV/V3FgVC4m00sYURQadMLvSEctk2IsnYLDZOJy8IJNKC86tx3EVlrmuIIxqBa98c0eHUx0VYmfkOhYhelsMXtJXqieEedGpCVlOJ8XCKHbFPz9HRsNRkjxPDgx6Lk/DXT92pr4X9qiboyLbMEIHxbdfzcYWYDC1Ymhv+7bPOZ9rQaf3A2FJvcqpnfYDvf/yEr2oV0yZOQymqFXpGyRapaX3Hit22eJDxX9a0QwOxHXA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6790.apcprd06.prod.outlook.com (2603:1096:820:ff::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Tue, 4 Feb 2025 09:45:25 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Tue, 4 Feb 2025
 09:45:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 06/18] hw/intc/aspeed: Introduce AspeedINTCIRQ
 structure to save the irq index and register address
Thread-Topic: [PATCH v1 06/18] hw/intc/aspeed: Introduce AspeedINTCIRQ
 structure to save the irq index and register address
Thread-Index: AQHba9K7meqnZdOEZ0SS3T3u/tT+zbMuveUAgAg9ElA=
Date: Tue, 4 Feb 2025 09:45:25 +0000
Message-ID: <SI2PR06MB504172A9411E9D6663A84E04FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-7-jamin_lin@aspeedtech.com>
 <a853d2ae4bc50703fe193406f9e4008d18110287.camel@codeconstruct.com.au>
In-Reply-To: <a853d2ae4bc50703fe193406f9e4008d18110287.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6790:EE_
x-ms-office365-filtering-correlation-id: 9f13e6ad-a322-4b8e-141b-08dd4500a6ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?djZacjlxck5aQXJPczFWNkN3eU1QTU5MZmJ4SFFlY1Z1amhGVGY3QWlxTWNw?=
 =?utf-8?B?Skc0N0NNMkFnbjJEVjlQNjRtR3p4NkI5bGJ5T1o3cHdockY5OG80SERSMmV5?=
 =?utf-8?B?UTdVL1kyNWh3UHpkOFRGcitFVm90RVF6eW5HR05Yd3FnOXR3cmJoNnJYcW9l?=
 =?utf-8?B?STVUT0dUMHBLZzV4R1BNVWU5NHRwL1Q4TmVTdCs5akpVUnBqSHlLRWRoeE5O?=
 =?utf-8?B?d1A1SkJoRkovdTdMZ2h5Vy9lZE5RNjNreWhzeGdpQnpodThuV0ZiekRad3Vr?=
 =?utf-8?B?cHorcWJTeWZSay9MdWFhNTd4Y2VFanRxMjhTZG9mNlhEbVZkV2Q4R1dtc2JQ?=
 =?utf-8?B?SkUxalZrWXAyUEtZZG5lZ24zYVQ2MlBMWnpoYTBxWG44dkQ4aTBEQmZwNFJY?=
 =?utf-8?B?RUJhWnhlMUpocVNJbkY5dTJVR0s4MTYwM1NOQ2lZZ1ZVOHNEVlRKd2dtNWh2?=
 =?utf-8?B?b3R6VlVWMjNHOTRHbHJ4V25tZ0xiUlRrRW5SQ2JNVUhDWXFNdnVsTjVZY3FW?=
 =?utf-8?B?a1pON1RaWEdpRDMvMHJUSUYvRGg0anl2TEhTQTRSdFU4blZ6V0pPdWtqOFlk?=
 =?utf-8?B?U1ZHOHo4MUt3cVJzMnRtaDE2T3FGazkzUGJqS3BWb1pDTlQ2M1B0WWplVXpr?=
 =?utf-8?B?VjZpcVVnWS8ycEtHR3NuZVZEZnVYcGxVWjZuQ3hYS05kVzI0R24zNVJ3NzVC?=
 =?utf-8?B?MDRpOHpyMXpwOHhnQlp5clJzN3JqMmV4MnZiMVkwc2JOOWpoUVNDVTFWRHk5?=
 =?utf-8?B?cG5pMWxLT01na2QvYUNKYXVBY2ltOTZyRXBDSTRHbGw4eStZVkNuS1FDLzVO?=
 =?utf-8?B?QkwvcDNacks5MU1pRzl4bitxejg1WW0zSThMOVg1aFA5L2xSb0VKUm9TSDF5?=
 =?utf-8?B?QUFWZkZ0TnNHeWlwYXdIcC9iL0JDQ09ITERmSGZYanZkWnNURTAwVUg4QW1o?=
 =?utf-8?B?c0MwOHFndVl4eXFMdEFBY0RCMEVRUGVCSVR5UDNFTktIY0g4Njg4RzlpaGx6?=
 =?utf-8?B?dHQxNkRMVnN2Z0tOMzdaaW85RDBrOG8vZnBNeVJ0bjhzQUNjRWFzYkxLdjVk?=
 =?utf-8?B?R0FiejUxYnhMcFdndHZPM2Uwa2IwVWF0bnVsSXV5bExSVjNqNFIvODJITElr?=
 =?utf-8?B?RExpaVhCcW9Kd0lHQWtBdU1vdUhIN1FFajRsZVZxY3pTMmpZYUJjQ3ZjV3Ru?=
 =?utf-8?B?VGdTbXJhbmlIdDdxSVcrSjNUTFo5TUJKQUcvY3B5ZDE3ZHFLYURJY3BUbFZr?=
 =?utf-8?B?VWVmWGNjVEJ6d2ljMTZVbGpzaEZmYUpkVkVBVFBLcXRCU1h1VmF1KzM1eUJW?=
 =?utf-8?B?bWRibUtRNFBzdWgzaG8xNEtudlQrME9ZMmgwQWV1YXk3ZkdPRlNxUjlRSWE4?=
 =?utf-8?B?MU9udnVod1c1QmZuODlRMk9WcUJZaXkvQ1JRK0w1aHVZbWh4djZHbnFuR2tH?=
 =?utf-8?B?NzNTRnJuN0ZHVVh4bXpuTndpeUxCTUZqQTlIcUs2WFJvTTBEMzFZNXJYYTZn?=
 =?utf-8?B?NHo1cUxMVjlnZXlBUzVTRDdDYnM5a0JneUt3aE9hZklST2JrWXk4Q1UzSkM3?=
 =?utf-8?B?T2xLL1NSanNab0E0a050S0tFSlVOMFlYbUk1RHhjdzNmbEpCMnpsSHhSZ2FK?=
 =?utf-8?B?dTFtSXZnaVNYWHVHdDlQM1NwZHVDUkk0RlpaVFAzb2lZU3ZOdVJhb09DWitV?=
 =?utf-8?B?U1BGUWZJRExNL2s4SWROV3lFb0lIRElHZUZJalZMeFEyaVdOc2xJK3NnSlJ2?=
 =?utf-8?B?NERHWDlIMUQ0NHFlcjU3bWxMckJrZ1U4emNzSm14N0JhWVUzeTZ2WjlJR1hV?=
 =?utf-8?B?ZkMrcHlqTGk5R0RSbFVkcUowVzhOZEFnZEU4MlVEYU12QXhTbE1NcXlZdWkz?=
 =?utf-8?B?S21iWnFiZXZsMitZYzFMbUNKWFVGQURTYlRveEp0S05XUnprZ2tkZlJ2clR4?=
 =?utf-8?Q?JZoCmJzIUo1xa7aJvUs7u6hUdQzSzq6Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3o1MEZETkJ6MExlSHNoUHh0NWpLZVBlcUpCVWZtSlcxRUxWQlNkTHZUK0pV?=
 =?utf-8?B?OGlicXRIOVFTL2ZtT0VHREVTOEE3SnRSYnk0OFFaWHhIVFNjQ2FoM2haRGlK?=
 =?utf-8?B?eGxkazhmZ2FKYkFNZTFrMStYNy9ZekZ3czE1M3I3NHh0OHZlbEp4VEF1TzVI?=
 =?utf-8?B?K0QzeXhVcFZTalJVTjVYMzZibWoxTDhVM0xkMU1NMFhsZTNtcTl3ajJZTnlL?=
 =?utf-8?B?eFVyQnUvVEtZL2F5ZENmN1R6Z3Nmci92WVJOY0N6bWhoS2ttMG54eHlEVU5W?=
 =?utf-8?B?d2ZmSWYydFh2YitMZlVJUWVFN0JXSSsrTVg0VGVxMnhZaVo2dXhZYkV5blhv?=
 =?utf-8?B?NlM4cjVDMWxJd1k4VjNzYVpKaGRNU21aV0xLUzVsODhob200dGtlTHZuSWYy?=
 =?utf-8?B?dU5FWVpFSGpMcG5nM3MrMmxGQ1NDcGJhcnJzYXh5MU5LSzJMc3NEUlRncGp5?=
 =?utf-8?B?US85TGliWG1SNVNVaENPMmEyMEZLMzR5dmJGRWJDNXJBSGhCUXN2d1BaeVR0?=
 =?utf-8?B?SG02aVhRVnFua2VGM3prMlc3Y0c5aU5EbC9LQTMrNURXSzkyZGdQREVVSEhY?=
 =?utf-8?B?SFpvNUhEUXlsWnM3MkkwU0FrK2xUUVQ3UDRXVEovMHE1czZhWHVvK1UrZXRW?=
 =?utf-8?B?bUl4T2c0ZUsxdjZFaWkxWE9xamJhNFQvRkltYzVJR2dFaHloTVlIVnFJaGdV?=
 =?utf-8?B?Vm4yaHBlRjJrTzJQdlVCM0Z6UmZZZGpnNUF5d0IyaUw2RlR1Yml2YnY4NTI2?=
 =?utf-8?B?RVZQa2NZQlArekpyL3VQekczNkIyN0FIVlduTVkwUVQ4V0sxV3Zoa2NRRzZx?=
 =?utf-8?B?M0MrY1hJdmIrTy9yU01CWXBxOWQxUzNaMGVubVZ3RHdoNzQvdW84MzFsUU9F?=
 =?utf-8?B?TUhPK0lKWFN3T2ZMSm5qdURWV1JuQWhMUUhDVTVJaTlsT2V1blVubVZrWDhw?=
 =?utf-8?B?UFV1WUVRTjk5b1JSUlJnbEorWElSZTBXUjlNVUhEcXgwSnNFb2dwUWMzeE5W?=
 =?utf-8?B?WUdXU25IbjdKSTBoRktnNHpGZlkwTVRLUzgwR0FSNTc1UzhvVnNXcUdxL1NJ?=
 =?utf-8?B?Y3lxWkd5eXhlaEo2T1JCVnRvUlNCc0dMbXkrTzhDWndiT1pXVFVNdklLell1?=
 =?utf-8?B?Y0wxQlgyZW90Uk1jMlJwRnV1aERodXpGWXFyUFlBa01GcmRsRWZ3Tm44ZXc4?=
 =?utf-8?B?VTJQMWJzRHlkMTViVUpJSXJ5azZ5eFZZV2JxY2UvTDJ0RHg5L0d6ZTVTSHN1?=
 =?utf-8?B?Wkw3UTl0TjFYWmV2MWdCeWVsblN2cnJtek1TSWlZZVBNV3c2K08weGl1ejFn?=
 =?utf-8?B?OFlGdWFQMTNSSXh0aml2d2d0b25LbmFQOFpvSGFyY25yenNCU2xLeGY3N2NI?=
 =?utf-8?B?QzU4OTdqSVU5MDNsa2ZQM2xOU3JUVC8yZjZSbHRadDVoUDdTNUUxV0IyRWhy?=
 =?utf-8?B?N1RDQXE4akN6YzhXRitOK0lLUk5aVzF5RkQxR0xKWTVQaVhzQTVsQlczbkVj?=
 =?utf-8?B?VnFtcCtqOGE0UTNXZXZ2citvL2ZzaE15TDl6OGdXeDB5bkRKS2tnKytIOWVp?=
 =?utf-8?B?Y1FYV0llYWNQSFZrSEptQTV5U2RWR01SaXlUQmtSWGh5RGR2M2NOUzhRN1pm?=
 =?utf-8?B?RDdhK3YwRWRTQXl3djRhWVZvdTNkY3RCb2w0dmVxeEZWSmZjaEp5YXFnUDht?=
 =?utf-8?B?M09jSVZFbWF6eUc5dnNLWnFRZk9OM0pIckIwaXB1a1ZIbjV4ZDFtUDVRVnNp?=
 =?utf-8?B?UGtvYTlDejA1ckhkZ3JWQ01PWHRFZTRNR0lTeXJqbXE4dTY0ZTlKcFRaVE1H?=
 =?utf-8?B?czRYVnNrYTZoRTVEYkltTktqZWdDOUlQVHV6U3pDOHc1MWM1RnhBZDRLSWd5?=
 =?utf-8?B?S2wvWEV0aVVpc0FCZXdPYVBTcWJYZ2w5Vno1QVp5c29icXUxbDhWcCsyeWR2?=
 =?utf-8?B?VXl3TVUwYWdISmVlOFIva2lxanFabTR1cllpT1lnTVdITjlRZERtZ1hvMW9x?=
 =?utf-8?B?N3R2eUtqQlpxbmZRN3U2Z1dGeVl1MXJoSldub0hsOUJQb0FMbXU4RFB0L29a?=
 =?utf-8?B?V1BVUC9aNkMxZWJ2aUtHZmpTdWthQWUxVFYzVzVSWjNXc3FteG5IM2NrYzlV?=
 =?utf-8?Q?aC+26sv6VqInjVhCWCawY+fLp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f13e6ad-a322-4b8e-141b-08dd4500a6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 09:45:25.4642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEXwSyqX2MEQA2hEg1DPpwQMKJ6bTsFhCmQRCco+RgOStL8G61u8HSbaM4/uwm1EKfp2mDvkYtIdKdGAYw5+24inp3xyhw7duVIAtQ3UKZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6790
Received-SPF: pass client-ip=2a01:111:f403:200e::727;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQW5kcmV3LCANCg0KPiBGcm9tOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1
Y3QuY29tLmF1Pg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAzMCwgMjAyNSAxMTo1NSBBTQ0K
PiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQGthb2Qub3JnPjsNCj4gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kg
TGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEpvZWwgU3RhbmxleQ0KPiA8am9lbEBqbXMuaWQuYXU+
OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+IGxp
c3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50
YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA2LzE4XSBody9p
bnRjL2FzcGVlZDogSW50cm9kdWNlIEFzcGVlZElOVENJUlENCj4gc3RydWN0dXJlIHRvIHNhdmUg
dGhlIGlycSBpbmRleCBhbmQgcmVnaXN0ZXIgYWRkcmVzcw0KPiANCj4gT24gVHVlLCAyMDI1LTAx
LTIxIGF0IDE1OjA0ICswODAwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhlIElOVEMwIGNvbnRy
b2xsZXIgc3VwcG9ydHMgR0lDSU5UMTI4IHRvIEdJQ0lOVDEzNiwgbWFwcGluZyAxOjEgdG8NCj4g
PiBpbnB1dCBhbmQgb3V0cHV0IElSUXMgMCB0byA4LiBQcmV2aW91c2x5LCB0aGUgZm9ybXVsYSAi
YWRkcmVzcyAmDQo+ID4gMHgwZjAwIiB3YXMgdXNlZCB0byBkZXJpdmUgdGhlIElSUSBpbmRleCBu
dW1iZXJzLg0KPiA+DQo+ID4gSG93ZXZlciwgdGhlIElOVEMwIGNvbnRyb2xsZXIgYWxzbyBzdXBw
b3J0cyBHSUNJTlQxOTJfMjAxLCBtYXBwaW5nIDENCj4gPiBpbnB1dCBJUlEgcGluIHRvIDEwIG91
dHB1dCBJUlEgcGlucy4gVGhlIHBpbiBudW1iZXJzIGZvciBpbnB1dCBhbmQNCj4gPiBvdXRwdXQg
YXJlIGRpZmZlcmVudC4NCj4gPiBBZGRpdGlvbmFsbHksIHRoZSBJTlRDMCBjb250cm9sbGVyIHN1
cHBvcnRzIHJvdXRpbmcgdG8gR0lDLCBTU1AsIFRTUCwNCj4gPiBhbmQgQk9PVE1DVSwgbWFraW5n
IGl0IGRpZmZpY3VsdCB0byB1c2UgYSBmb3JtdWxhIHRvIGRldGVybWluZSB0aGUNCj4gPiBpbmRl
eCBudW1iZXIgb2YNCj4gPiBJTlRDMCBtb2RlbCBzdXBwb3J0ZWQgaW5wdXQgYW5kIG91dHB1dCBJ
UlFzLg0KPiANCj4gSXQncyBhbHNvIGEgYml0IGRpZmZpY3VsdCB0byBmb2xsb3csIGV2ZW4gaGF2
aW5nIGxvb2tlZCBhdCB0aGUgZGF0YXNoZWV0LiBEbyB5b3UNCj4gbWluZCBhZGRpbmcgc29tZSBk
b2N1bWVudGF0aW9uIHdpdGggZGlzY3Vzc2lvbiBhbmQgYSBkaWFncmFtIG9mIHRoZQ0KPiBjb21w
b25lbnRzIGludm9sdmVkIGFuZCB0aGUgcG90ZW50aWFsIGludGVycnVwdCBwYXRocz8NCj4gRnVy
dGhlciwgaXQgd291bGQgYmUgZ3JlYXQgaWYgdGhlIGRvY3VtZW50YXRpb24gYWxzbyBkZXNjcmli
ZWQgdGhlIG1vdGl2YXRpb24NCj4gZm9yIHRoZSBpbnRlcnJ1cHQgY2hhaW5pbmcgaW52b2x2aW5n
IGludm9sdmluZyBJTlQxMjgtMTU5LCBJTlRNKiwgYW5kDQo+IEdJQ0lOVDE5Ml8yMDEsIEdJQ0lO
VDIwOCBhbmQgR0lDSU5UMjI0LiBDbGVhcmx5IGl0J3MgYSB0aGluZywgYnV0LCB3aHk/DQo+IA0K
PiANCg0KUGxlYXNlIHNlZSBteSBjb21tZW50cyBpbiBwYXRjaCAxMi4NClRoYW5rcyBmb3IgeW91
ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpKYW1pbg0KDQo+IEFuZHJldw0K

