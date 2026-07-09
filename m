Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77CEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whdHz-0002MO-N6; Wed, 08 Jul 2026 21:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whdHo-0002Lg-52; Wed, 08 Jul 2026 21:10:44 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whdHm-0008Fm-FN; Wed, 08 Jul 2026 21:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPkJat9y9HI6Wg5u3UPF5bIODLXehx0BduPTuVdvWXqxjfHBo+40hN40tXXfJQXqXl9EvO3cPWrp20gR1pYbUJ+X3t9YD/dEYJ6hsWC6GRCVfZls8sBaeRHhffpO7M1k8YVaf9HuopK8Ktmdwc6KoDfLBEK5upiUbtfnP3fbI3Yy71fLxr5vTDV3fZYTCdxb5G4h3vOMTfFm4YA30aJJ46jj1pUNv15xxVQyjboBSX6w4mFQniXa+LcD4zdIxUf7Dtotd5WtEEDgqJUIzQb/ar1qLh63oTg5/oNgcCKopQjllcN2luxSON6Bzq8PgY6s3zJDEfhgUCO7echRFEMErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6nDXE+pekoWEijMX8WXVPBt5NLcx0XnT2Jsu3BZzY0=;
 b=tPxtslY7mDOAlL6WTjcd7Uv3qsNZ05q3wWZLRTsZngZKdWD3l0/P57VmxfiybtxbUKZuFD8KyyQr0lMqusMdMqyPqOF6Z+AetHw3tSGOXI1zJt1f0CODpNlQydeTNVXIwMRdvih4mKxxgd60XstKFvr/iiF597AebOim7SqooUNWpfnb2kVwxTS3M3kFSrOLvonTDsvlKIEi7v2pfkDZLE8o7kdc8lVX5mEB+FFWD2hTuDfpEXE1hc7CJAP+4aHIGQhqJa0xhn9gk+0XtSD2MX0x4o/FGh5Qz0DDxS67gBNZJArKD7v4F5ZFJDhp27ShO8uRwWHWBX1X92BaiqENrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6nDXE+pekoWEijMX8WXVPBt5NLcx0XnT2Jsu3BZzY0=;
 b=fjJAqHiwCLP5wrnDPMFKHbH1twnocEeTkjOOakJt/4mDSQfRp6LEQ3byQECG7YP/3R6Q8+fYl64GQXPBkOW8q+2v/hOEC0D+59AbmehFP2vjumYqHRDDUhsALRZvfl3bvPr4aTRrYJxxCQaq4VLdIUCzA7WoQNPzflRkunBbTj33ScsUdK1pnm30LAwsRW8azoWkxcxJJkpUL5UACKL0rljQC/HCSjU7sNJs3MT/iBbmi3ltFkGC9yecDog6QdaUw9IWPzZCk6IJ4xHnl56Q9KxlLFRBEZoaU5dtV9TegkX7Q+u1RCCkLDMAU0jh6wd/GH12Eg3l6ZNKQLgVXL0ezQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by OSNPR06MB8225.apcprd06.prod.outlook.com (2603:1096:604:45f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 01:10:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 01:10:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Nabih Estefan <nabihestefan@google.com>, Joe Komlodi
 <komlodi@google.com>, "Murray-Pitts, Lucien"
 <lucien.murray-pitts@siemens.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support
 for AST2700
Thread-Topic: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHdDrsB0PfBWMtPU0KIoukeQI21FLZkPUyAgAAhSYCAAAInQA==
Date: Thu, 9 Jul 2026 01:10:35 +0000
Message-ID: <TYZPR06MB4980C0620EBAB68031639EB2FCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
 <3d2d869c-d1a0-40d1-83c2-755c080bd17d@oss.qualcomm.com>
 <TYZPR06MB4980E558390882926C5263ABFCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
In-Reply-To: <TYZPR06MB4980E558390882926C5263ABFCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|OSNPR06MB8225:EE_
x-ms-office365-filtering-correlation-id: b9ba0d04-cfa3-4d42-7cdc-08dedd56e1b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|38070700021|22082099003|18002099003|4143699003|56012099006|921020;
x-microsoft-antispam-message-info: CoYQlHaVoCEfPwRBovu3WfXqoKk5fBP9ewqHhKk5qtZXhuq7finpX8gWdwUgr0aIshhd2sf0P4C/auNCyoU03rPuISJRCDqWdUQecUMwv/obTGfgqpJ+T+Cpw36NJmDTrrxxjqemiIi0tXgFDgQBeiF4GoC0GqNi6T14Zu+NAB2yDvCvdYLiSZQg4E7efBA5skpiMxdLy6zT/vyc5x6X0MSjMUINWcgno3zpKeCKcLp785KMU7CVubU++WffSBQ6k620gyCCbMyAb8ErhXsGL+RNUUHtoxwUduRh0PNOi8XGNTrTQ8WCp637BHlihTw2WLoiNFnRj2l0oA/9lRjVxUMYEmLi1jyPbh8zlreMzpgRfOS/mZq7t6RL7nNqnFFVURU1i2ya1g1y4+2AzpY+SeruptP7hx+st1Lw1cV8UYwA0PPAoKOkjXCi/ciF2xSNvpn3cBB3eWRdQyp4X/VkIav0cKYEzFtN0VcNo55ShCSP3VNBjPEJ3CeHGGp1gashmKHb7oRrlvXhwIk6y2VY9ZEBhgt9it5gZNAoM5TBbAyh961PMYvwjo3SDIWxEy5MZr0S41pM+5ueE0jUYYnYckF/Lz9/64NtI1pjyEPtgM/w3EzivncC1crt+t348gzV0iK+mTayLdpF1Su6tDmmSl0Ljn2lVSkF87ioiKG2tXnXD3qxs/M5kbpjuoK12DxQ41lajTjx4KMtYGcObJSiZ2sFNj8bHHMqYIfe5rLZ374KRjtHxlKfSzyylil+yjBx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDBNYkRLc2R4b0tXZlA3YWNqMVRvRnAxalg1M1ArMmhVandkUitLR0t5T2p4?=
 =?utf-8?B?NFlKVTh4MlJjNUg3UXdiSTd6QitBQVRISWFKNzdacy9lVDY2bVpWWFNVUUxQ?=
 =?utf-8?B?MWtyZkJjcXBuK2s4VlVsUEhaRmZEUTluSkNkQjNFeE5VeXdKY1hyMitJK21M?=
 =?utf-8?B?S0oxdzVYQmVuaXR2VTUxeWx4N1JJNG13MkJZeFQxejBScWt2ZTlibVhUb0tE?=
 =?utf-8?B?MzlmS1RhdG9ac1kyUXlWR3FuSXRVd3pLdGZ4NUFua0J2V2lDYXFYOU9nNkNU?=
 =?utf-8?B?TXhNcXk2SjcrbGFCa1VKU3JPODJFeGZzNzl0L0tKK25mRDBGbmpPNU40NFFi?=
 =?utf-8?B?c0ZSYWkvWGdmTWltUWp3MHk2T0ZPSE9ub2hWblh4Z2dObWxMR0ltSlRDbTVY?=
 =?utf-8?B?QXRxc3F5NS9nY2R5YnFjZE1RS3JXeFB5cFR6RUVaTy9PeHFETGtxTm5YTjhm?=
 =?utf-8?B?TmI5ajRMSm11bmpZVS81c0dZQkFXYU9ETzNoQ2sxb2JsUnErRnVaYitaa1lZ?=
 =?utf-8?B?eWs0RzBSeE9GZkk2VjgwYy9FU204dVJJMVRTUENQdElybzJ0VVp2SXpIZnRa?=
 =?utf-8?B?aTFwWVh0ZU9CWHlmbjMzSmhGOEpiWFVUc1ZiL0R0TDBKQjNUbWUwZ0hoNHp1?=
 =?utf-8?B?bWp3N25pQVBVZmRqRTFmdjZodXJrbWcwKzhMYzk1VzJBaFg5cXVvSHFyekJ2?=
 =?utf-8?B?QUs1dmxqRXVBVWJtMkFsSUpqaHpqS1dJbnlqN1NWWXZoTGpMS3M4aEo0Mjc2?=
 =?utf-8?B?WHMrZjBGcXhqYXZzTGFNdDlsTWFiU0kvWm01TCtXVzc0cGtuN0p3RkswKzZN?=
 =?utf-8?B?MVo3aUlwc0F6V01iUm40aHhpY3ZnWUxIbXJLQlpvY2tES0RLaDhWK0lQUW5y?=
 =?utf-8?B?VXo3NWVKMXlFbk4vd045N2FlaVpxZ1Fxd1dvV0gvNUdmazg3U3V1UW9JK0Q5?=
 =?utf-8?B?YzRMNVE0YXk1bUgzYnlybDZ5Y2NQTUhNOTcwcURQaWdKVFlrQzJFTzhvMnlz?=
 =?utf-8?B?R1VXY3ZkVVhLaUpjN1JtUEZ5MGZuRnhvR0xqLzQ3WjF4a2dyVXB2N1VScHhh?=
 =?utf-8?B?WWJtZkJiWnpwUjgrZC8wQ2EvaVhwWWduYktOamxtSHg5NVUwZnR0UVZGL1Rx?=
 =?utf-8?B?dmViSG05Ty8zbXhXQSsxODFXZnp6WG9ld2dYc0VMQTNMaG1MMFEzTVB5Z1Jj?=
 =?utf-8?B?a2hhNDRIWTBtV1hFUnRuTnZObTVKVHczOFFrZHV1VElxNDgydUEydUdHbFBs?=
 =?utf-8?B?eG93ZFBoajY5aTZ0NFFQY2owNHA4YVlxTVIvQk1XK0JyMUREUkEyTVkxVkNL?=
 =?utf-8?B?Wm9NaXp5WVQ2cXgvU2xvdXNqN0c5RzJsa09MeXcwMi9zellwTGpJd3JjTVBl?=
 =?utf-8?B?clN3MEowNnhnQnJUeXVyQ1huMWdaVlVlRnV6eHdMR2tGVU9qcVFrdmRxQlVK?=
 =?utf-8?B?UDVTOEpsZFNDVVNGWmZXNm1PQnRidjFWMkJCcnBSdHc0RGNIU3FLYUpWQjYz?=
 =?utf-8?B?eHJuQTZYQ0JWZTlQUFZ3Z2g1aVlZWFArcFZDWUNOZS9OdnQ0SFMrcGhTZzRN?=
 =?utf-8?B?d3drWXU4TzVja05PR3FaaFVuYzhqSm01ak01TVJIRFhkQjJ2SHJJTVMvNmVN?=
 =?utf-8?B?a3p6R3l0T3g4aDN6NzZpcmhzV3UxR3lkQksxY2FTSHl5cVVwOUg1UVpQT285?=
 =?utf-8?B?MVZrS1hlMjdsclJOUTl1bjJIMUxzSElaVzZlMWh5anVtRjgzRmxNZ041c0po?=
 =?utf-8?B?N2JkaG5xT3VjM1ptVi9iSm1PVFVUMHFkNmIxKzNLQ3RIL0tIU0NGSUFoZkw0?=
 =?utf-8?B?ZVZNd0VrMThUY3NSOWRmOWQycjhBTDZFcEFKczQweHMzcmdlcnRiT3IvL3hC?=
 =?utf-8?B?VjB5REhqMXFaUWNwdWhrcnhkaEg4SjA3OS9oQzAwekxxZlV0VythM3JZMWxU?=
 =?utf-8?B?alRaUXR4ckNWSjBCRHFmdVNXWTVQUXJTQTRRL1B1YnhwQ3RTZXh6ekhRaWU5?=
 =?utf-8?B?THQzYkZrUHpwTnlzS3RmWUJwMGlSeDBBWUxVT0h6YVJDcDVqSGR0YlAyMnhG?=
 =?utf-8?B?RHo1VFRUSWc4cG11YTJYcE9TOHJNdnB1VTNoMmNiVS91Z3Jia0lUVTdML3g3?=
 =?utf-8?B?Z3I3UGF4TmFqOVA5UHlmYVRQYXVaSUVJZHBJRXpxLzhKamh4U082S2o3Mlkv?=
 =?utf-8?B?OEFlb005elFvQzNzTEUxczNwOUcybVh0Wi8wOHhxMTBYMzNrZ1lpUjF3VW8w?=
 =?utf-8?B?czFnVUw1TnNZY3FhUkgwWXoySW9nMHlVN0VYcHQxUmtncVpneDFGUjRVYjI1?=
 =?utf-8?B?YmlKbUJuM0kyRGh1cjhIOUdWYUhXNEtSSzdkUW9lYnFLMFo1Y2pXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OBqKYfq46YwRi0wPO8MxyupcBghm4+1fnvb6hrzwvdpGtQn3tFerEFyCEPyxot901ZYDJxWl8sWa+8dFDQnmltWdhkpOLGSrgKcedKMXh2VLdcpbLiZpo2pPg9jQz1a34UrekF1t3dciFw/FVRZ6mQoezu82mqvUeYrugnZAIdB8x3lb/Q+VZTfS7pAsDiZDdjz08a2w7ml0MZRIe55bSu4RvNk8piuaVPKGsxDHjkk60C/YvV+81qkIaCCpefW1sXy03lTKAnvvppha6XK28Jka/MINPVr+upGPrA4TsE2gjaI2WG6sZLu/XZFhJQd3PuiVG9l4LSFj+pX18mtnqA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba0d04-cfa3-4d42-7cdc-08dedd56e1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 01:10:35.6965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VfSemb5vPYGvTBFx1fLZMeS0PjuMhCLtnvexXKLxt2egIoweXRlahEFdH7ze/8Ta4zQWyIfjoOtf7VlKyWv1pQfWWYVl0vpDOabXneafxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8225
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

KyBKb2UoR29vZ2xlKSwgTmFiaWgoR29vZ2xlKSwgTHVjaWVuKHNpZW1lbnMpDQoNCiogDQo+IEhp
IFBoaWxpcHBlDQo+IA0KPiA+IE9uIDgvNy8yNiAxMToyMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+
ID4gVGhpcyBzZXJpZXMgaW1wcm92ZXMgQVNUMjcwMCBwbGF0Zm9ybSBzdXBwb3J0IGJ5IGFsaWdu
aW5nIFNTUC9UU1ANCj4gPiA+IHBvd2VyIGFuZCByZXNldCBiZWhhdmlvciB3aXRoIGhhcmR3YXJl
LCBhbmQgZW5hYmxpbmcgRFJBTSByZW1hcHBpbmcNCj4gPiA+IHJlcXVpcmVkIGZvciBwcm9wZXIg
ZmlybXdhcmUgYm9vdCBmbG93Lg0KPiA+DQo+ID4NCj4gPiA+IEphbWluIExpbiAoMTApOg0KPiA+
ID4gICAgaHcvYXJtL2FzdDI3eDA6IFN0YXJ0IFNTUCBpbiBwb3dlcmVkLW9mZiBzdGF0ZSB0byBt
YXRjaCBoYXJkd2FyZQ0KPiA+ID4gICAgICBiZWhhdmlvcg0KPiA+ID4gICAgaHcvYXJtL2FzdDI3
eDA6IFN0YXJ0IFRTUCBpbiBwb3dlcmVkLW9mZiBzdGF0ZSB0byBtYXRjaCBoYXJkd2FyZQ0KPiA+
ID4gICAgICBiZWhhdmlvcg0KPiA+ID4gICAgaHcvYXJtL2FzdDI3eDA6IEFkZCBEUkFNIGFsaWFz
IGZvciBTU1AgU0RSQU0gcmVtYXANCj4gPiA+ICAgIGh3L2FybS9hc3QyN3gwOiBBZGQgRFJBTSBh
bGlhcyBmb3IgVFNQIFNEUkFNIHJlbWFwDQo+ID4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IElt
cGxlbWVudCBTU1AgcmVzZXQgYW5kIHBvd2VyLW9uIGNvbnRyb2wgdmlhDQo+IFNDVQ0KPiA+ID4g
ICAgICByZWdpc3RlcnMNCj4gPiA+ICAgIGh3L21pc2MvYXNwZWVkX3NjdTogSW1wbGVtZW50IFRT
UCByZXNldCBhbmQgcG93ZXItb24gY29udHJvbCB2aWENCj4gPiBTQ1UNCj4gPiA+ICAgICAgcmVn
aXN0ZXJzDQo+ID4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTQ1Ugc3VwcG9ydCBmb3Ig
U1NQIFNEUkFNIHJlbWFwDQo+ID4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTQ1Ugc3Vw
cG9ydCBmb3IgVFNQIFNEUkFNIHJlbWFwDQo+ID4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNo
NjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjOiBCb290IFNTUC9UU1AgdmlhIFBTUA0KPiA+ID4gICAg
ICBhbmQgbG9hZCBiaW5hcmllcyBmcm9tIERSQU0NCj4gPiA+ICAgIGRvY3M6IEFkZCBzdXBwb3J0
IHZib290cm9tIGFuZCB1cGRhdGUgTWFudWFsIGJvb3QgZm9yIGFzdDI3MDBmYw0KPiA+DQo+ID4g
U2VyaWVzOg0KPiA+IFRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBv
c3MucXVhbGNvbW0uY29tPg0KPiA+DQo+ID4gMiBub3RlczoNCj4gPg0KPiA+IDEvIEkzQyBlcnJv
cnMgaW4gZG1lc2c6DQo+ID4NCj4gPiBbICAgIDguMTUxMjMwXSAgMTRjMjAwMDAuaTNjMDogTUlQ
SSBJM0MgSENJIHYwLjAgcjAwDQo+ID4gWyAgICA4LjE1MTQ5OF0gIDE0YzIwMDAwLmkzYzA6IHVu
c3VwcG9ydGVkIEhDSSB2ZXJzaW9uDQo+ID4gWyAgICA4LjE1MTc2MV0gbWlwaS1pM2MtaGNpIDE0
YzIwMDAwLmkzYzA6IHByb2JlIHdpdGggZHJpdmVyDQo+ID4gbWlwaS1pM2MtaGNpIGZhaWxlZCB3
aXRoIGVycm9yIC05Mw0KPiA+IFsgICAgOC4xNTIyNTBdICAxNGMyMTAwMC5pM2MxOiBNSVBJIEkz
QyBIQ0kgdjAuMCByMDANCj4gPiBbICAgIDguMTUyNTE4XSAgMTRjMjEwMDAuaTNjMTogdW5zdXBw
b3J0ZWQgSENJIHZlcnNpb24NCj4gPiBbICAgIDguMTUyNzc5XSBtaXBpLWkzYy1oY2kgMTRjMjEw
MDAuaTNjMTogcHJvYmUgd2l0aCBkcml2ZXINCj4gPiBtaXBpLWkzYy1oY2kgZmFpbGVkIHdpdGgg
ZXJyb3IgLTkzDQo+ID4gWyAgICA4LjE1MzMyMl0gIDE0YzIyMDAwLmkzYzI6IE1JUEkgSTNDIEhD
SSB2MC4wIHIwMA0KPiA+IFsgICAgOC4xNTM1ODhdICAxNGMyMjAwMC5pM2MyOiB1bnN1cHBvcnRl
ZCBIQ0kgdmVyc2lvbg0KPiA+IFsgICAgOC4xNTM4NTNdIG1pcGktaTNjLWhjaSAxNGMyMjAwMC5p
M2MyOiBwcm9iZSB3aXRoIGRyaXZlcg0KPiA+IG1pcGktaTNjLWhjaSBmYWlsZWQgd2l0aCBlcnJv
ciAtOTMNCj4gPiAuLi4NCj4gDQo+IFRoZSBBU1QyNzAwIEkzQyBjb250cm9sbGVyIGltcGxlbWVu
dHMgdGhlIE1JUEkgSTNDIEhDSSBzcGVjaWZpY2F0aW9uLCB3aGljaA0KPiBpcyBub3QgeWV0IHN1
cHBvcnRlZCBieSBRRU1VLg0KPiBDdXJyZW50bHksIFFFTVUgb25seSBwcm92aWRlcyBhbiBJM0Mg
bW9kZWwgZm9yIHRoZSBEZXNpZ25XYXJlIGNvbnRyb2xsZXINCj4gdXNlZCBvbiB0aGUgQVNUMjYw
MC4NCj4gDQpOYWJpaCwgSm9lLCBMdWNpZW4sDQoNCkFzIGZhciBhcyBJIGtub3csIHlvdSBoYXZl
IGltcGxlbWVudGVkIHN1cHBvcnQgZm9yIHRoZSBJM0MgSENJIGNvbnRyb2xsZXIgb24gdGhlIEFT
VDI3MDAgcGxhdGZvcm0sIGFuZCBpdCBhcHBlYXJzIHRvIHdvcmsgd2VsbCBpbiB5b3VyIGxvY2Fs
IFFFTVUgZW52aXJvbm1lbnQuDQpEbyB5b3UgaGF2ZSBhbnkgcGxhbnMgdG8gdXBzdHJlYW0gdGhp
cyB3b3JrPw0KSWYgeW91IGFyZSBwbGFubmluZyB0byB1cHN0cmVhbSB0aGUgSTNDIEhDSSBzdXBw
b3J0LCBpdCB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLg0KDQpUaGFua3MsDQpKYW1pbg0K
PiA+DQo+ID4gMi8gc2h1dGRvd24gbm90IHdvcmtpbmcNCj4gPg0KPiA+IFsgIDI0Ni40MDUyOTdd
IHN5c3RlbWQtc2h1dGRvd25bMV06IEVudGVyaW5nIGV4aXRyZC4uLg0KPiA+IHNodXRkb3duOiBw
b3dlcm9mZiAtLXRpbWVvdXQ9OTAwMDAwMDB1cyAtLWxvZy1sZXZlbCBpbmZvDQo+ID4gLS1sb2ct
dGFyZ2V0PWttc2cgLS1sb2ctY29sb3IgLS1leGl0LWNvZGU9MA0KPiA+IC9zaHV0ZG93bjogbGlu
ZSA5NzogcG93ZXJvZmY6IG5vdCBmb3VuZCBFeGVjdXRlIHBvd2Vyb2ZmIC1mIGlmIGFsbA0KPiA+
IHVubW91bnRlZCBvaywgb3IgZXhlYyAvaW5pdCBzaHV0ZG93bi1zaCMNCj4gDQo+IE9wZW5CTUMg
Y3VycmVudGx5IG9ubHkgc3VwcG9ydHMgcmVib290Lg0KPiBJbnZva2luZyBzaHV0ZG93biBjYXVz
ZXMgdGhlIHN5c3RlbSB0byByZXR1cm4gdG8gdGhlIExpbnV4IGluaXRyYW1mcyBpbnN0ZWFkIG9m
DQo+IHBvd2VyaW5nIG9mZi4NCj4gDQo+IFRoYW5rcywNCj4gSmFtaW4NCg0K

