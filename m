Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D739C83F34
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 02:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uePRI-0007Qf-So; Tue, 22 Jul 2025 22:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uePRF-0007Ng-JW; Tue, 22 Jul 2025 22:42:37 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uePRB-0003WG-KF; Tue, 22 Jul 2025 22:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/nklfWKcWRuCmYTf+gj+O2bXoz02o3LzDY/1VOLVqK+OpsAcwJ6lC3b11Qnjeo5JqRlsz7vM737y9z5QS+0iVjYz0sOdo7tK7g7qHwqwkXpLQSg1+J8ani7B0VLS94sktwGnVyFvTo0c5XV8CwWhI106aWxv30BRhmK0+r8EGT0JOwTAegY0zHrHcOKgpwHdtRCAP6odcNP079rO9j1FFIlBQEd17EZVDHtlXKHic3uIH/NWGy9cEKT45bM7Jqo8LPi8dbsgnxMu+1dGhGcjGvmOJf4BKvXx1kr/mfGpalhDVS3EZYGUm8ZIZECeqdMS21MCCSdDGGQwQn539n/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRYVlja30RlG5ymvNe2oNb4iuE835jxbrwA5vCnktVI=;
 b=x0XntjbxXxAaKmYebG7GwH3DcYyxEJ7b13OkTfoWaP4pdcr0y6rJ0kWg5nQDJP8pqXtQnhFurvEi93NjOFd70WQmTm0WXMRkxujREW24XM56pp2SNJ+809ZsBiJ+bYmQekS4cqY8aEIjWwds9fa37k9IApjqBN2H8PtEh0soZkOjRIrf0ynzXN5A/UwddOVlq+M5D8UpdvYGT3o8VC8PvhRv3+hezuVzfIdMvYE1JS4Xo7AFRkXfYi+rIUQ9usZAkzITYqPiMJakS/yXBDJoxBmTXt5zyFDaED2StF2X4W9QfXNKd2Bnka6r/uFyo3SSzbWmaaMmz/c5JwGy04aHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRYVlja30RlG5ymvNe2oNb4iuE835jxbrwA5vCnktVI=;
 b=U76VvU5HUYaxE4d3Un4R8zqs475I1AkT1G7yh7k4YctC1mZT1KGaS4oBbWtHVQFZjs4hfDP5CJc2rhBW+OiNZwdIfLvroQbyuANF3nMuZzkygOYZ6YDr5RdmpzMmJDSgXHmCtDmpf0ZpNJs0LLjfr7JKN/3RMgYa2RwKwxYkWiKE4/CUMhgaU+DjO7kv09G/UNew07cPMonCBMDDZIAPbTRDBnRzwvT0GSmIPWz3vefsSlLCOdqg+LIJfrDqaU34Qmcl5AS1Xij7/EZ2gDV9flw2nWN6fGCy/u3v7dc4NkcupOwIfa+SUqIcDKIyB7Yn38/NJle0N8rc2OOLhEjbFg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5338.apcprd06.prod.outlook.com (2603:1096:4:1ea::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Wed, 23 Jul 2025 02:42:21 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 02:42:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with
 SSP/TSP SCU initialization support
Thread-Topic: [SPAM] [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with
 SSP/TSP SCU initialization support
Thread-Index: AQHb9sytNnqHTsl+Uk6K5yNks8BQkLQ+SvKAgAC7qrA=
Date: Wed, 23 Jul 2025 02:42:20 +0000
Message-ID: <SI2PR06MB5041C491359EECA7CC89A065FC5FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-20-jamin_lin@aspeedtech.com>
 <4b96bdfb-f4ad-41d1-aedc-28e1f0ad0924@kaod.org>
In-Reply-To: <4b96bdfb-f4ad-41d1-aedc-28e1f0ad0924@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5338:EE_
x-ms-office365-filtering-correlation-id: 4af50d28-658e-4005-39e5-08ddc9928c24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?RXdFUlZJd3A0MmdlY3dDNG5tSmljb2Nnd0E0R3hLUEZJVzRuc3ErUEhVbmRz?=
 =?utf-8?B?OWs3OFdYSWdFc3U4b2w2QjVmaERBSHVZUmdxYmhVMGhnZjhVM0ZWbitDTFNu?=
 =?utf-8?B?VEtPbTRBZHZvVjc3eEl4aW1XWHlRYnkxdDZwbVJKeW9HUVdDQkZFNTluUm9O?=
 =?utf-8?B?YXNYdzdWSVNSU01KR3lvZGRCRXI5OEhlRlc1WUpQVURncW5pRWVLbmFMc0M1?=
 =?utf-8?B?OTk4ek91eEJraW1CUm1iK3UwQzVpVHlVNUZRaHBSZTlad01GUWExNzBRN29I?=
 =?utf-8?B?SEtCV3c0Y3VYRGFmRlhvb1prUHJqVEw0Y2xTODRBaTZaZ21DQVpoQXBBU2NP?=
 =?utf-8?B?NU9kZC90S2NlNEJaVHBaTmxzWkY1aTM5Zms0UVlWb3RoVkJsaGNScnovNHdx?=
 =?utf-8?B?OXoxajV0Y3lBTm5pbkJKb1RyZ2F3d3JnVGtXUWM4VXphaXFMaFkvM1ZpUUNO?=
 =?utf-8?B?UE1WTTZHNDJOR0txSll0RUNveE5nVFIvclR3Rzh2Q21FMzJsa3hQRVZTcWR6?=
 =?utf-8?B?ZU0wY0o0a2FWaUpxOE9weHJWa1EvZzNXNFRFeTJLY3hwd1hzdkE5RHhoZ2lq?=
 =?utf-8?B?L0ZGcFgwT1ROZWNtc1REMmN1SHl2cmtnR2w1K0FSd1BYVkFmbVYwT2dkS2dT?=
 =?utf-8?B?WXA2MHd4TEdHb2NJYmZ6QmlvQThucTZiYkZBVy94cDNKc0MxM3dSS1dBQ1Fj?=
 =?utf-8?B?SkhsYm5DMmdVRkdPRFlnY1lWMXJPTVNpMDR4K0tucUhWYzQwTXlyR01wNUxL?=
 =?utf-8?B?UlFqaVFVNXNWNUhMbVFSUWdrUlZvTkNleGNCR3pNRlk5NzNHb0ZvRW1RNXlF?=
 =?utf-8?B?L2h2cDI0bXB6V0RPVUZjTFg2ZnhMT3E3Y3BwRUJseE9GeFhnVlVUQnBud05K?=
 =?utf-8?B?cE1uUHNwczZ6L1dXZWswWnJLcFZXL2lPWjNWV0hSbDVHellNeVRyS3E3M25t?=
 =?utf-8?B?aU95RGRCdlFaejNjVWxPVmVwL01kKzVEOFA5cHU1UzQ1ZElHT1VqY21qN2RU?=
 =?utf-8?B?VGZaNU9DN3hpOE81QnNyOThwVUV4MnJoTy8vUUNHOExkc2tTSlR4c0tkRXBl?=
 =?utf-8?B?TWdlb01uNzh6eDA4RjV1M2FSeXlzbklybmd2bU1uWmkvMk1LOWY0Ukw1NlYx?=
 =?utf-8?B?UDZYZzZVNnhnUjJGVjZnc1BjQWxna1FtL28zMWxLT0hMSTkrVTRmTkhTMWYv?=
 =?utf-8?B?ci9HeloxR3psellzWERSTDR6NzlCbE5aU25ucDlocEJKblVMdzBUZDc2ZWFL?=
 =?utf-8?B?SmZaNHhWTGQ3ZFRkOVNOVGMxUVZmTVJ2ZUZpREJzTW90bFhmN2M0OTcrN0xY?=
 =?utf-8?B?RWtJNVM5M0dlTE1MSm96Q2x0Z1lPK3gyZzZ1NHNWK0NJM0U3c0Q3dWQ3UnJ3?=
 =?utf-8?B?anZJYjQ4ZEp6K0RWMExETlM3ekZvbWQ4RUkwRmx3VkUvN0ZQaXhiSFNIMTNW?=
 =?utf-8?B?VGdGTnhNMlJ4d3FzRFB1TXYyaDFKWGJWWjltelVjQitLRzA3K21ON0crS0o3?=
 =?utf-8?B?R0JjWVRMeStOaE4zQVJITkgyYzRWZExJNXlTbkdiT3ZVWVJYTThXUGp4RFNB?=
 =?utf-8?B?Z3dJbSt2bDRxM0pkWnVONlVoeTM3eHNuTUlFdVJJQlJGUzEvcGlPakJ5NW5H?=
 =?utf-8?B?bG5wa1lTaTVuTy90NDM3OVZjd3d3U1cvcDhEMDFkYUNFOXNSa1BTRlZ2WTRK?=
 =?utf-8?B?YWdYRXh0NWVnVDNMQmllVG9kUWZBaEJ1WFFjdktnWmtjQVdiVFhRdEg1Nm5m?=
 =?utf-8?B?L2tVVE9TYmVFU3Z0UDlDMlIyQVg0T1ZYNVg4SHZPWjBhK3Jtd09QWXhGTjEr?=
 =?utf-8?B?a0xSd3F0VlprdDArQytwMHdlcGkyUUVCT0FIcnlCcmd6OUY4ZjltUkErOWFZ?=
 =?utf-8?B?aCtkTXJ2VmtZTnFrelhteWlRTTFmYU04cmlQOHRIWUxaQk1Lc29YbUlxL3Z6?=
 =?utf-8?B?cGRiQTk3bWZ3KzZ6T0ptMWpBbi9oT0VaN1d1bjlZcS90a0FEN1llSHVJQitj?=
 =?utf-8?B?NVJ2ekU0V050dmthQ3J5N1dBOFpnaVpQdUYyamVURjZYaHdJbmhKZkUyaTZm?=
 =?utf-8?Q?DLSbx7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3JJek9RRXllR0tEZExCY3BYaWxOZmk1eHBUODdzVWhiMXBCc1pqVDJKZDQr?=
 =?utf-8?B?cDUwbVNjbjFzYVdBN05aUHhiVndZYUMvYUZ1VFFpMWxEL0JhMGVZWTlNc083?=
 =?utf-8?B?YnVjSTJBYUVmSjEvUTRRZnA2eDRqcWlhOFoxS1pvMk9CVzdnV0xUT2FsSlFX?=
 =?utf-8?B?cFRVRFBMSDdkTVFpNWNRb1FhcW1WUk9VelVobzRUN1RVMFcvVkNrU2tvUkVr?=
 =?utf-8?B?U0JyVFdtYndtTlowbUdUVjlUeDFCZzdoNkFWaXBnVmtjMGIwbGlzY2xsNXF3?=
 =?utf-8?B?WEJiU0g3cThKVXRIdjg4d3duRHMwTkFKdU9jSUVVVWJxblZIeDU4OWNIYTZV?=
 =?utf-8?B?TDUwRHd2WjJQcDFxMEQ5bjgzK3Q2MVJlQ0xVRUlzWEZqcU9lMmtHUHlvTktV?=
 =?utf-8?B?YnYrMEUyVmhPTXloeG1Bbm02YU8vM2tjR0liVEM4WTg1MDYxWjhyQlJZOGxp?=
 =?utf-8?B?NUJVRktKeS9sd3kxV1U0RUNGQUFYdXc1Ump3Y1c2WFRxbGRRWmxWNFdjbGVR?=
 =?utf-8?B?UmRwNWdhUW1pNHVHV0ljNkZxNXIvMkRUT2pZV2dscTYzbEJXdGJGNDFvbUh4?=
 =?utf-8?B?U1lOb29EaFo2MUVodVJRa0FUaTk2c1Y1bmRPYXJRcHBrbEttYnFOek1Sb3RS?=
 =?utf-8?B?bnlVVWdScVVDRVZmc1Rwbjl1SnBJM1RHNjBZcFFteWE1SEFML3VnTVlDWHpM?=
 =?utf-8?B?cU9ybnB1dUpsM2x1RU53ODI2TnNaYlUrV3c3WFhIWi92Z3llVWc0VTdlaWV0?=
 =?utf-8?B?ZWgyRkJqSFhPMk5XVE40Z0I3SFQra1BxZ012QW15VzZSd0xBNy96RUNGcE5R?=
 =?utf-8?B?VjB0ZkRBOEU0WGVVRWErZEdSbGI5US9ja2JBb0Qwb0xkeDhTS1VYTHRJVEc2?=
 =?utf-8?B?LzUvRkhST2FwcGsxZXRvbU93S0J6L05BcjB1OXY0Y3FENVRZWi94eFZIY0xL?=
 =?utf-8?B?YkxmTE9KNVVpaGhTd3lqWDFBeG5TUGtkOFYvRGhCRmZ5YTNSY01KNFdRUzlK?=
 =?utf-8?B?Mk9tQlRDaVdWeXVNM1IreWp1aTd4MWxVQXJGcCtncVZSOEZiSU84ek5OV0pQ?=
 =?utf-8?B?a2NSZUh2bW1LbG5qbDJnRWt6K05qbDJMcDFQSFBobFhvYVNIeXFVVDJGMWtr?=
 =?utf-8?B?eFo5RFZQSkdyb0hKa09KemVNWktPcWpkTjUrK2F0cFJyK21EanM0U3ZjQTQ3?=
 =?utf-8?B?azFzQ3hvaG1uNnFMWFM2c0NZejB0YnBoZDlhS0pncnVwTUVxYXlsQk1Ecms5?=
 =?utf-8?B?cDEzaUhnWU5SRGR3YXpjTDJtdU5Na3hjOHlBUTVvN2xYcWgxOHlVY2dGV0Rh?=
 =?utf-8?B?TWJ1MWxUODF5alJHOTBOWHIrL0xIU1NUTk5FbzhlWi9MU3ZPMmIvbFJwbGRE?=
 =?utf-8?B?VmIyU09PcEJVUnIxVlRTTzVpeFkrOHJBcXFpUUJsMHBraTFTNlJzb0I2dTdx?=
 =?utf-8?B?NU1OMFhvbDZtMWpTRzdFVDNldEtWVU45VnpycGUzWFdORlpJVFhuOWhWRG9U?=
 =?utf-8?B?K0gzYU5EK2dhN3NDWEJGaW1EeVZhUDJzLzAvNHRsWnhZZEJPOTVlYTkrU3V1?=
 =?utf-8?B?NXVLYUtDN3QxZUN5OTlsZlBEVklFYVVtVEJ0K0NyVUU1NUhYSitEZFdacEZy?=
 =?utf-8?B?WXk0aGVQcGQrU3A2YjBVb1R6VEpVQXRPS0k4RXUvZTRqSi8zQUxKTkpYT3E5?=
 =?utf-8?B?UVE5d3hkczBYTW84VkdWT3RjU3NwNXNTS2V1c3pUdmN2eHAyNVViSm40YWJV?=
 =?utf-8?B?K3ZNK3h5L0U2RDlVVW9vRU9veDVoLy91bHhBakFocmI0aDVKZHB3U1NmcGtZ?=
 =?utf-8?B?ajZHMURHcWhRUVREQVVjelU2Vkx6MjBMdzVrT0Zhdm5NMnE1djc3TEdRMXVO?=
 =?utf-8?B?bjk2NUNTR3FIUTZQaERzNnFOaXlCbU4xMTAwTWdiU1ZCUXY3OW85eGJqeUhF?=
 =?utf-8?B?VSthSkR5d0todjNIZUtReGhrTXdNUWJSOWthVU1LWW9WeGpudmlrTUlEZCtY?=
 =?utf-8?B?MmhQcEt2SWJxekxlNmRTbWJLRGV5QjBmY1FnY0I4UytSeDF5M04zNlJJWTI2?=
 =?utf-8?B?bUZ6UnBKcFpkOEZieWNtQ2hGZFAyeWlwcCsvdlVSQWdQK1RVQzBjSituT01X?=
 =?utf-8?Q?la/hchygWFdVo7HOTVjBbL1ZO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af50d28-658e-4005-39e5-08ddc9928c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 02:42:20.9439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrdYFV/Z0UDzAav/lUlpmJdotHevOvfZMVxvtiGPU6VBhsa/L1jLp7Vkv/Qra2J2KDOqtoSZYOam38/bBQZ0xzxciEzKN0NbNr4qiV1qJcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5338
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDE5LzIxXSBwYy1i
aW9zOiBVcGRhdGUgQVNUMjd4MCB2Qm9vdHJvbSB3aXRoDQo+IFNTUC9UU1AgU0NVIGluaXRpYWxp
emF0aW9uIHN1cHBvcnQNCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gNy8xNy8yNSAwNTo0
MCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSB1cGRhdGVkIGJvb3QgUk9NIGluY2x1ZGVzIGxv
Z2ljIHRvIGluaXRpYWxpemUgYW5kIGVuYWJsZSBTU1AvVFNQDQo+ID4gdXNpbmcgU0NVIHJlZ2lz
dGVycywgYmFzZWQgb24gcmVzZXJ2ZWQtbWVtb3J5IHJlZ2lvbnMgZGVmaW5lZCBpbiB0aGUgZGV2
aWNlDQo+IHRyZWUuDQo+ID4NCj4gPiBJdHMgc291cmNlIGNvZGUgaXMgYXZhaWxhYmxlIGF0Og0K
PiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUvdmJvb3Ryb20vY29tbWl0L2Y5ZWIwYmI1
N2RlY2JhYjg2MGE4MTcxMmM1Ng0KPiAxDQo+ID4gMzJjMjEwMmZhOThlDQo+ID4NCj4gPiBCdWls
ZCBJbmZvcm1hdGlvbjoNCj4gPiBCdWlsZCBEYXRlIDogSnVsIDE3IDIwMjUgMDI6MjY6MDcNCj4g
PiBGVyBWZXJzaW9uIDogZ2l0LWY5ZWIwYmINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgcGMtYmlvcy9h
c3QyN3gwX2Jvb3Ryb20uYmluIHwgQmluIDE1NTUyIC0+IDE3MTkyIGJ5dGVzDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPiBUaGlzIHBhdGNo
IGlzIG5vdCBhcHBseWluZyBmb3Igc29tZSByZWFzb24gSSBkb24ndCBrbm93Lg0KPiANCj4gQ291
bGQgeW91IGdpdmUgaXQgYSB0cnkgcGxlYXNlID8NCj4gDQoNCkl0IHNlZW1zIHdvcmsgdG8gbWUu
IE15IGdpdCB2ZXJzaW9uOiBnaXQgdmVyc2lvbiAyLjQzLjAoVWJ1bnR1IDI0LjA0KQ0KDQoxLiBn
aXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS5naXQNCjIuIERvd25sb2FkIHBh
dGNoIHNlcmllcyBieSBjbGlja2VkIHNlcmllcyBidXR0b24gYXQgdGhlIHJpZ2h0LXRvcCBzaWRl
LCBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zlci8y
MDI1MDcxNzAzNDA1NC4xOTAzOTkxLTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLyANCjMuIGNk
IHFlbXUNCjQuIGdpdCBsb2cNCmNvbW1pdCA5ZTYwMTY4NGRjMjRhNTIxYmIxZDIzMjE1YTYzZTVj
NmU3OWVhMGJiICh0YWc6IHYxMC4xLjAtcmMwLCBvcmlnaW4vc3RhZ2luZywgb3JpZ2luL21hc3Rl
ciwgb3JpZ2luL0hFQUQpDQpBdXRob3I6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4NCkRhdGU6ICAgVHVlIEp1bCAyMiAxNTo0ODo0OCAyMDI1IC0wNDAwDQoNCiAgICBVcGRh
dGUgdmVyc2lvbiBmb3IgdGhlIHYxMC4xLjAtcmMwIHJlbGVhc2UNCg0KICAgIFNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCg0KNS4gZ2l0IGFtIC4u
L0NvbnRyb2wtY29wcm9jZXNzb3ItcmVzZXQtZm9yLUFTVDI3MDAucGF0Y2gNCkFwcGx5aW5nOiBo
dy9hcm0vYXNwZWVkX2FzdDI3eDAtZmM6IFN1cHBvcnQgVkJvb3RSb20NCkFwcGx5aW5nOiBody9h
cm0vYXN0Mjd4MDogTW92ZSBTU1AgY29wcm9jZXNzb3IgaW5pdGlhbGl6YXRpb24gZnJvbSBtYWNo
aW5lIHRvIFNvQyBsZXZlDQpBcHBseWluZzogaHcvYXJtL2FzdDI3eDA6IE1vdmUgVFNQIGNvcHJv
Y2Vzc29yIGluaXRpYWxpemF0aW9uIGZyb20gbWFjaGluZSB0byBTb0MgbGV2ZQ0KQXBwbHlpbmc6
IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3A6IFN3aXRjaCBTU1AgbWVtb3J5IHRvIFNEUkFNIGFu
ZCB1c2UgZHJhbV9jb250YWluZXIgZm9yIHJlbWFwIHN1cHBvcnQNCkFwcGx5aW5nOiBody9hcm0v
YXNwZWVkX2FzdDI3eDAtdHNwOiBTd2l0Y2ggVFNQIG1lbW9yeSB0byBTRFJBTSBhbmQgdXNlIGRy
YW1fY29udGFpbmVyIGZvciByZW1hcCBzdXBwb3J0DQpBcHBseWluZzogaHcvYXJtL2FzdDI3eDA6
IEFkZCBTUkFNIGFsaWFzIGZvciBTU1AgYW5kIGVuc3VyZSBjb3JyZWN0IGRldmljZSByZWFsaXph
dGlvbiBvcmRlcg0KQXBwbHlpbmc6IGh3L2FybS9hc3QyN3gwOiBBZGQgU1JBTSBhbGlhcyBmb3Ig
VFNQIGFuZCBlbnN1cmUgY29ycmVjdCBkZXZpY2UgcmVhbGl6YXRpb24gb3JkZXINCkFwcGx5aW5n
OiBody9hcm0vYXN0Mjd4MDogQWRkIFNDVSBhbGlhcyBmb3IgU1NQIGFuZCBlbnN1cmUgY29ycmVj
dCBkZXZpY2UgcmVhbGl6YXRpb24gb3JkZXINCkFwcGx5aW5nOiBody9hcm0vYXN0Mjd4MDogQWRk
IFNDVSBhbGlhcyBmb3IgVFNQIGFuZCBlbnN1cmUgY29ycmVjdCBkZXZpY2UgcmVhbGl6YXRpb24g
b3JkZXINCkFwcGx5aW5nOiBody9hcm0vYXN0Mjd4MDogTW92ZSBEUkFNIGFuZCBTRE1DIGluaXRp
YWxpemF0aW9uIGVhcmxpZXIgdG8gc3VwcG9ydCBtZW1vcnkgYWxpYXNpbmcNCkFwcGx5aW5nOiBo
dy9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUCBTRFJBTSByZW1hcCBhbmQgdXBk
YXRlIHJlYWxpemF0aW9uIG9yZGVyDQpBcHBseWluZzogaHcvYXJtL2FzdDI3eDA6IEFkZCBEUkFN
IGFsaWFzIGZvciBUU1AgU0RSQU0gcmVtYXAgYW5kIHVwZGF0ZSByZWFsaXphdGlvbiBvcmRlcg0K
QXBwbHlpbmc6IGh3L2FybS9hc3QyN3gwOiBTdGFydCBTU1AgaW4gcG93ZXJlZC1vZmYgc3RhdGUg
dG8gbWF0Y2ggaGFyZHdhcmUgYmVoYXZpb3INCkFwcGx5aW5nOiBody9hcm0vYXN0Mjd4MDogU3Rh
cnQgVFNQIGluIHBvd2VyZWQtb2ZmIHN0YXRlIHRvIG1hdGNoIGhhcmR3YXJlIGJlaGF2aW9yDQpB
cHBseWluZzogaHcvbWlzYy9hc3BlZWRfc2N1OiBBZGQgU0NVIHN1cHBvcnQgZm9yIFNTUCBTRFJB
TSByZW1hcA0KQXBwbHlpbmc6IGh3L21pc2MvYXNwZWVkX3NjdTogQWRkIFNDVSBzdXBwb3J0IGZv
ciBUU1AgU0RSQU0gcmVtYXANCkFwcGx5aW5nOiBody9taXNjL2FzcGVlZF9zY3U6IEltcGxlbWVu
dCBTU1AgcmVzZXQgYW5kIHBvd2VyLW9uIGNvbnRyb2wgdmlhIFNDVSByZWdpc3RlcnMNCkFwcGx5
aW5nOiBody9taXNjL2FzcGVlZF9zY3U6IEltcGxlbWVudCBUU1AgcmVzZXQgYW5kIHBvd2VyLW9u
IGNvbnRyb2wgdmlhIFNDVSByZWdpc3RlcnMNCkFwcGx5aW5nOiBwYy1iaW9zOiBVcGRhdGUgQVNU
Mjd4MCB2Qm9vdHJvbSB3aXRoIFNTUC9UU1AgU0NVIGluaXRpYWxpemF0aW9uIHN1cHBvcnQNCkFw
cGx5aW5nOiB0ZXN0cy9mdW5jdGlvbi9hc3BlZWQ6IFJlcGxhY2UgbWFudWFsIGxvYWRlciB3aXRo
IHZib290cm9tIGZvciBhc3QyNzAwZmMgdGVzdA0KQXBwbHlpbmc6IGRvY3M6IEFkZCBzdXBwb3J0
IHZib290cm9tIGZvciBhc3QyNzAwZmMNCg0KNi4gRG93bmxvYWQgdGhpcyBwYXRjaCBieSBjbGlj
a2VkIG1ib3ggYnV0dG9uIGF0IHRoZSByaWdodC10b3Agc2lkZSwgaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNTA3MTcwMzQwNTQuMTkwMzk5
MS0yMC1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQo3LiBnaXQgYW0gLi4vdjEtMTktMjEtcGMt
Ymlvcy1VcGRhdGUtQVNUMjd4MC12Qm9vdHJvbS13aXRoLVNTUC1UU1AtU0NVLWluaXRpYWxpemF0
aW9uLXN1cHBvcnQucGF0Y2gNCg0KQXBwbHlpbmc6IHBjLWJpb3M6IFVwZGF0ZSBBU1QyN3gwIHZC
b290cm9tIHdpdGggU1NQL1RTUCBTQ1UgaW5pdGlhbGl6YXRpb24gc3VwcG9ydA0KOC4gZ2l0IGxv
Zw0KY29tbWl0IGI0YjlkYTE2ODNlMTc4YTFmOTlhMGUyYjExYmVkYTBhYWRlOGIwZGMgKEhFQUQg
LT4gbWFzdGVyKQ0KQXV0aG9yOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
CkRhdGU6ICAgVGh1IEp1bCAxNyAxMTo0MDo0NyAyMDI1ICswODAwDQoNCiAgICBwYy1iaW9zOiBV
cGRhdGUgQVNUMjd4MCB2Qm9vdHJvbSB3aXRoIFNTUC9UU1AgU0NVIGluaXRpYWxpemF0aW9uIHN1
cHBvcnQNCg0KICAgIFRoZSB1cGRhdGVkIGJvb3QgUk9NIGluY2x1ZGVzIGxvZ2ljIHRvIGluaXRp
YWxpemUgYW5kIGVuYWJsZSBTU1AvVFNQIHVzaW5nIFNDVQ0KICAgIHJlZ2lzdGVycywgYmFzZWQg
b24gcmVzZXJ2ZWQtbWVtb3J5IHJlZ2lvbnMgZGVmaW5lZCBpbiB0aGUgZGV2aWNlIHRyZWUuDQoN
CiAgICBJdHMgc291cmNlIGNvZGUgaXMgYXZhaWxhYmxlIGF0Og0KICAgIGh0dHBzOi8vZ2l0aHVi
LmNvbS9nb29nbGUvdmJvb3Ryb20vY29tbWl0L2Y5ZWIwYmI1N2RlY2JhYjg2MGE4MTcxMmM1NjEz
MmMyMTAyZmE5OGUNCg0KICAgIEJ1aWxkIEluZm9ybWF0aW9uOg0KICAgIEJ1aWxkIERhdGUgOiBK
dWwgMTcgMjAyNSAwMjoyNjowNw0KICAgIEZXIFZlcnNpb24gOiBnaXQtZjllYjBiYg0KDQogICAg
U2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoNCmNv
bW1pdCA5ZTYwMTY4NGRjMjRhNTIxYmIxZDIzMjE1YTYzZTVjNmU3OWVhMGJiICh0YWc6IHYxMC4x
LjAtcmMwLCBvcmlnaW4vc3RhZ2luZywgb3JpZ2luL21hc3Rlciwgb3JpZ2luL0hFQUQpDQpBdXRo
b3I6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCkRhdGU6ICAgVHVlIEp1
bCAyMiAxNTo0ODo0OCAyMDI1IC0wNDAwDQoNCiAgICBVcGRhdGUgdmVyc2lvbiBmb3IgdGhlIHYx
MC4xLjAtcmMwIHJlbGVhc2UNCg0KICAgIFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4NCg0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCg0K

