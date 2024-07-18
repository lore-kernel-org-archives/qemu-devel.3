Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B89C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNgQ-0006W8-7g; Thu, 18 Jul 2024 05:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNgO-0006OC-7L; Thu, 18 Jul 2024 05:44:16 -0400
Received: from mail-psaapc01on20709.outbound.protection.outlook.com
 ([2a01:111:f400:feae::709]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNgL-0007J2-TO; Thu, 18 Jul 2024 05:44:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll1wKPis3aUqwpSieO0/4jG851NmrWC+gU79vFTFLOKPAr6+z23QbuC7tsOAf41Hr6ejsQISVZhjJjrTF8RYjWUsaTDyOF2sXYTIz06nlr0wvxqLcjGMt2L9eYMoMgwSSnATOq1um/bx9PxSzTnBHzs9au7JJveqqSLfeBLIH+vUGQA2zC2ILsyDSVeHtn2i7SE185pEn8YomM4Ho+EvunYpeSemgz4JivfVTcrAG5wUHrA8btaq8A9sSMay0026mspdbnDC6Dc8W83x/62ceZO7mcxoPmzNlTkDol8UzftcR+NrTW6lILZg8IFnvDaHO8y9rLPn/BZeC+iD3lIfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otKkbWdE8hCvDK2OHi3LVSf3sdPKLn35GNu2IST6RTg=;
 b=DirQfqwVIt0NwfxXahzJUMug8ROLIyvlcMXPc2LX2c8GFa28pSU+uqSNl6RGuFQyBGNORb/SN983sxvtdGBQYGRNbw9+o+jde5NT9qu3BR721TX3b0km/aLiEd+bibhTDKrKHG+VH9jW97FqKJXDvM+yU7NH8Rlm0t7ctS+2MN1vnBUKruIbVdv+vHPUFLSflMSXAqMwpllAoDV10mEFuoUFN5dLPdudgI0RwXPYxiSLG7JjsfxGdkXddjq+ZK3qvHgTpuvtpG5+3InVctHW6fA1XI3xGsQgf3FuYRVyVn4lKg3l+GHNr51/qDM4Qz9udANAbdcvd4wHHslHcrObvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otKkbWdE8hCvDK2OHi3LVSf3sdPKLn35GNu2IST6RTg=;
 b=PYPp4WLTyEePiKaR91ldFafAeSvySAaGMrCyAIYkZrc8jxjFEiL3uJl0tNg1v8OyBKw/zz7RbO/h3+xPCW6OyVki7pGwjsKxLUPsC/ecfCkN4dG/Wb4145pFRxyldO2NksXrpiDvp390f4eSb0HgRGWSHlP71u6tFyOpK7kEidFlGKbsXq3d9StZNXiIZJyFFKcUZIyqpxRGnQ+YLLwvtrpdrlT2Ku4wKCgt0O+Sx4naGclweyt/yS/C4R+ufhEkCJ7lgodIYWiiZbMsxd3SpgQ4zpUg6JsnbfMJP2gh+3LNEr/9V5GkU7zLzUKhs1dpR61icHDUb3BlhmqNp1rsaA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5108.apcprd06.prod.outlook.com (2603:1096:4:1cb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Thu, 18 Jul 2024 09:44:06 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 09:44:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
Thread-Topic: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
Thread-Index: AQHa2N7FJ4EHEryDLUODXq5rrtI5x7H8K8oAgAAQGIA=
Date: Thu, 18 Jul 2024 09:44:06 +0000
Message-ID: <SI2PR06MB5041E3D271FB5839B12E76D4FCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-5-jamin_lin@aspeedtech.com>
 <de851b5c-5983-44f6-955a-6ba71f966c71@kaod.org>
In-Reply-To: <de851b5c-5983-44f6-955a-6ba71f966c71@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5108:EE_
x-ms-office365-filtering-correlation-id: 39b25130-9339-4a71-cb05-08dca70e2aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MVZLaDdEaHZKaDBsT0JjY2p2NEJ3UHoyTEV2RXROSm5OK0lucUErT2dFZjZi?=
 =?utf-8?B?bHE5bHViSldrV1VWbUE3Qzk0cy9qbVRCRkdmRW52RnN2WTBiaWtoSnVMWTJ5?=
 =?utf-8?B?YkZzMkk4eDNidlFxY1NidndPSUpheG9xRitlL25oZVY3NDY4UWJQcGR4Smhh?=
 =?utf-8?B?TEo4YWEyZTNNZElod0xvY1c0TDNuV1VCUFZLOTlxSFFHcFRmWFFrVk9KTklq?=
 =?utf-8?B?bEdGOXVuTXEvUE1oNVZ2ZG9jKzBmaEJrRHRLU3pNWUhsenBvMUpNWUtBdVNH?=
 =?utf-8?B?all2UTBPQW5ObENxYUFrSi9YUnBKeHNLWVRRczU2YUppcjU4T2tzVmxyaUFa?=
 =?utf-8?B?WkE1WmdzRUZQTWxnRERGSlY2bmhTYjNKekxJTTlGZ0s2ZnF3MWRtaXZPdFJ1?=
 =?utf-8?B?WGlZSVJJQmVpV2RWQVJjTTRDU0hjaHVrOTNUb0NQbm92b0htVkVRdERNMWp2?=
 =?utf-8?B?RVFqTzBEU2JPMkxFYzdSZFl3YWxwWUxFczd1bWIxRFZPTVgrclByd1VCOVZV?=
 =?utf-8?B?bzdmRUoya28vaGVmRTB0ZHdXMk5FaENzVnJXVjJYdGZLcmxSa2VXeVJ0bmNC?=
 =?utf-8?B?cHQyTzlubWN2NjdBUXIwNzAvcVlhdXZXbEcrYWNUYlo4SVFKQXZXajhKUHUy?=
 =?utf-8?B?V2R0SmlKZmVQZUtLaFJCTXN6WW8rQlBJdlZBOU5NMXdqTkJncjZVczBSWGw0?=
 =?utf-8?B?eEZTTHBIZ1BzL2FhTFpsMWgwaGU2cUR0bytNeFFZMmFNYlhJelRWc3FJUGQ4?=
 =?utf-8?B?OXNHUkZIcklHbGdJWkRZMERyaGFVaWVLQ3k1dkwrWmp1bmlaT0RYdzJWeS9R?=
 =?utf-8?B?UkM4OE9Semx3NG96Z2I2NGtIaW1RbkVRa2llOTlObWFUUGhTNGVPY05kcmNM?=
 =?utf-8?B?bUJ1amtlTGNhdkhaUk43bi9sUXEyWDBmYzRlYXhIQmVXL043Tnh1dXFkTnlH?=
 =?utf-8?B?eSt6eU9ma0E0WHlMdW5ZemVuZENuOHBmbzlNZVlGT2djVGc4aTcvRHl3Q3Q4?=
 =?utf-8?B?WFdCRlpjbFVUZHBMZW52cjdKcXhIN0lYcVNuVy9tQVNmQTdvaVNYRHpSZU1t?=
 =?utf-8?B?bjRPMUEvNTFOOFh4Nm4zUVdJOVRVMkNuNkdFTnRTc0RCV0NMaGFyV09Dd1kr?=
 =?utf-8?B?MmNEVjR4dEhCamhPZXNrK2J2a0pGbHVBSlZoTnZSSkdEZGhOQjFPeEh2eEVC?=
 =?utf-8?B?WEV2UmttNEVybXFDbzJqNkJUOWVtcVVLK3V0Nm00VDVpODJIaTRmV0hFeXI2?=
 =?utf-8?B?OENqamtaR0Z3SHEyQk1MQXRJWUYvRyt4YU56Y05vOGxhOU1ZS0FDSUU3UEZ0?=
 =?utf-8?B?Z1pEL0JUcVlaOWpYcDFrWHAvQzZtaUZmRUFWSExZcUFkYlMvM3ZTYWwrSlZm?=
 =?utf-8?B?VUhiZVA3NXh5MjhsR25UZFZ2dmlXVjBWZGx2YkFwM0pSclFmM2hQdmU3QXBO?=
 =?utf-8?B?TGxPSnN3aU1nL1hVZzAraEhtVmhjeHpPUjJjbDJYYTZrcm9hMlFYeXV2QUxG?=
 =?utf-8?B?ZGdWY1BRNW52L2xyaG5nbzJCUG93WGVzc29kVlRMSlI1eGZ3L3RhemRnbHFH?=
 =?utf-8?B?cFdXWHZzaGxpdW1BYVRZYmR2MEs0eDlFb05qUkRqQzdsRjdyZkh4d3NCc3VS?=
 =?utf-8?B?OTkxZ0tlRldKMHgzd25JYmRBNE1JYVdBdzRMSmFSSnF3ZElvbXpYZUFnMjAy?=
 =?utf-8?B?bkhlSDRnaW9LemZESllHWEJuSmJPQlhUbVh2UE8zQ2JJZFhrMjZJV011K0tF?=
 =?utf-8?B?UHhYR3RQOXF0UG9PQk0waUlybnQ4V3pNc0xZbmh2aHJTUXloMXAxVkNwV1hK?=
 =?utf-8?B?QjdIVEx2U3pXUkRFRHE2Um5DcjZtL29uZVBFRTBrekFQWmNnbFlrbGVId09i?=
 =?utf-8?B?UXVkTXRNeGtqaExybmxDUEVJN0JaUi9uTG9VNDg0WHRmeWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzRNK0IwcFdUeWEwdlZjYXI3QUJHdCtxSnlDeWs3RzRmTjdhUGhGWHVqbEVk?=
 =?utf-8?B?VTZTRXdaL3FTZnJqRGRuNktnTng0aE8wRGx1c2xISXVoWk9iaXI4b3hSdlVZ?=
 =?utf-8?B?cElpUm54eVI5eGFadDBENUJqT0tXRDhybUNPdjhDSXFtTzl5YXBTeW1MWFU2?=
 =?utf-8?B?VHdSQkUra3c0aGg2RFhNKzE2ZkVhYkNFTVNHV25lYXh3bC9IVkJBalhiYVNH?=
 =?utf-8?B?Q0ZBMlYwanFTWUc0TlhWS2pRcGhUS0FFbXJDVy82MGYydlBHZ0RoNXV6aHJD?=
 =?utf-8?B?a2ZLWnNYakYwaHVJSDBCOVVVWFE2SG1MOUxRb2RpU2pYbDBwL0VDdnJFLzJz?=
 =?utf-8?B?RDBPMVV5UWpwaFpxU2VQaTZKelF5RU9seFUvVll1Qkg1V3huSitiMHFUdkJl?=
 =?utf-8?B?S0xWUmc5KzdTTytLNmozSzNJM0dqby83djN5bEliaGJZU0NEN0hBUS81dTNT?=
 =?utf-8?B?UHVDVzljcWxvdVp3b3J1R3FqbVpLYXdWaGQ0MklCK21BQ1JpMWJGdHdZNHJt?=
 =?utf-8?B?UEtIaU1pcERWWkJlNDlqMWRsa0YrZDg3VjR5N3VvcmQxMGF5SUV4SmNYMzE1?=
 =?utf-8?B?QjlOQXRHTUdCWGJoaHNIb2RWdVNvR0dtdGlYK3RRZ2wrUEw0YWlBYzlINDB2?=
 =?utf-8?B?ZnNYZ3A3QS9tb1l4eW9YaXFidVhIdEtzODBCaGhaWXVkU2grR3ozVWFOUG43?=
 =?utf-8?B?dWprbFFTYzFzb3FZVEc5SHR1QWhkZ2FXb1psRXhINC9GeUIrZUJmRDMvSmY0?=
 =?utf-8?B?RkhwalRrclJlRXpXWHdUcHFxNTF0YjExYTRsVHpnb2ROby96T0IwV0NVUlZ6?=
 =?utf-8?B?akFYNHZiZWsxbXVRMmRZMWh0UzUvR1BBMlh4R0dhQ2hnZU8zNzhscmkwZVdo?=
 =?utf-8?B?SEpJbnRsZGhiUmJxaFl3dXJXbTJVai9NZUZQRTBrSENHbEllMU1VUmpKUDVq?=
 =?utf-8?B?T2F6VzF1akdxREVTZytqb1g1ai9aMVo1cVJoODg2OFpaYlRQUDIxNTZpb2lG?=
 =?utf-8?B?bklqL09lZXlmMGFjN2xzU2E3L2sxWDBzQ1Y2d01nYmN5OGtpa2RaSE54RDNS?=
 =?utf-8?B?SFhXRVZKV0hLT01vc3F5M2tEZ0NFUlV4UUVrZXprWXhueTF0TlQzdjU5VmJC?=
 =?utf-8?B?OEFYNXcyejNYYmdWNkdiZmNzVFU5Z1pEc3l6aHdSUnpyaHEvTnFReEFjMHBY?=
 =?utf-8?B?bWdsb3M2U2VPZEZOcm5PWUxyNnJxMENGWVBSTFVqdU8rYTkrQTkvVklCR3p3?=
 =?utf-8?B?ZW9Qc2FwTTQ5QWJlQVJsZ1ZkQzBjSEZBV2pBbXlSaFgrZ291bkp1aklWZkVH?=
 =?utf-8?B?T2tsWFZ2cVJGVzlDdVZUZHdvaTVWYkNkS3RYM2lYRERHZ2NKNk4zdm0yaTE3?=
 =?utf-8?B?RW5abnVyakhURmlHVURJc3RWZnNqTGUwaG5mbWF4WFJ5U041RDdGTmZ4Q1RG?=
 =?utf-8?B?bFUweG5jQXlZdzU1RThoVHpXOXhqVjZSZ3JDOGpOcDdob2pKYnVtNUtjbG9r?=
 =?utf-8?B?NVhNZHdiR0pnNFZiQ0IyckV3Q0hhQjRhcHFwWW4xSEFCRzVSczVyVjZkUmRr?=
 =?utf-8?B?QUk2RXJDU1NNT0FHNXVScDVLbWp2YTRCSEpFVGxxOGZpc3VEcGtSZkRrdFdH?=
 =?utf-8?B?eHJ6dTJlNWFiRS9vVlpZUFdWMkRaZDBGeUNYS2hiVitKZWd4WHIzaVh1aFlt?=
 =?utf-8?B?TXNUVWYwT0NZaTF1eTlDWlBOanJMWW1URU9Fcll1enVLYlYrZ25oT0FIMDEx?=
 =?utf-8?B?T29LQklpKzY1YVdGWDkwU3cvQ0NyU3M2Uk9vRi90bzBGcncxL2ZkVUMwaUds?=
 =?utf-8?B?SFQ2cFhUMUpid2diTi9sUXQ0cHFPNVpyd0had0lmU1JmcHdFQmRWZ3E4bTBM?=
 =?utf-8?B?Ni9lVGk1NFRYZ2tqSWRsdDU4Q3dzQlpyREZ5QTd0ZlJuKzROM1I4MDVhYWhX?=
 =?utf-8?B?NThuNkJPRm13TmtmMlBTTG8xd2l3U1p0NGpOTVVLQkRmTEdMM2RBKy9Wcitz?=
 =?utf-8?B?Z0Vxd1NzcmhjQWt4MHVmWWphNXc4VUkvWXZBaitHZ2NMSUVRbHZmMUU0OEQr?=
 =?utf-8?B?Q3Z0VFoyMjh3MEpCK0hmYVNhWFhWL0xCWUdEVjA3emxyS25OVTE4OGVONmto?=
 =?utf-8?Q?c12F9tLUcEZRDRbmtKoSGdlXC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b25130-9339-4a71-cb05-08dca70e2aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:44:06.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SG9/kpWghOcuqjPfOez60mjUbAiqwf5VB9igL6GhzZix67ESWy/Ck0D7AO5zH647nkBHDfU/kPVTv+Plnuk9oo8YtqMTnaLE+UDq0XqIkAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5108
Received-SPF: pass client-ip=2a01:111:f400:feae::709;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMTVdIGh3L2kyYy9hc3Bl
ZWQ6IHN1cHBvcnQgZGlzY29udGludW91cyByZWdpc3Rlcg0KPiBtZW1vcnkgcmVnaW9uIG9mIEky
QyBidXMNCj4NCj4gT24gNy8xOC8yNCAwODo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEl0IG9u
bHkgc3VwcG9ydCBjb250aW51b3VzIHJlZ2lzdGVyIG1lbW9yeSByZWdpb24gZm9yIGFsbCBJMkMg
YnVzLg0KPiA+IEhvd2V2ZXIsIHRoZSByZWdpc3RlciBhZGRyZXNzIG9mIGFsbCBJMmMgYnVzIGFy
ZSBkaXNjb250aW51b3VzIGZvcg0KPiA+IEFTVDI3MDAuDQo+ID4NCj4gPiBFeDogdGhlIHJlZ2lz
dGVyIGFkZHJlc3Mgb2YgSTJDIGJ1cyBmb3IgYXN0MjcwMCBhcyBmb2xsb3dpbmcuDQo+ID4gMHgx
MDAgLSAweDE3RjogRGV2aWNlIDANCj4gPiAweDIwMCAtIDB4MjdGOiBEZXZpY2UgMQ0KPiA+IDB4
MzAwIC0gMHgzN0Y6IERldmljZSAyDQo+ID4gMHg0MDAgLSAweDQ3RjogRGV2aWNlIDMNCj4gPiAw
eDUwMCAtIDB4NTdGOiBEZXZpY2UgNA0KPiA+IDB4NjAwIC0gMHg2N0Y6IERldmljZSA1DQo+ID4g
MHg3MDAgLSAweDc3RjogRGV2aWNlIDYNCj4gPiAweDgwMCAtIDB4ODdGOiBEZXZpY2UgNw0KPiA+
IDB4OTAwIC0gMHg5N0Y6IERldmljZSA4DQo+ID4gMHhBMDAgLSAweEE3RjogRGV2aWNlIDkNCj4g
PiAweEIwMCAtIDB4QjdGOiBEZXZpY2UgMTANCj4gPiAweEMwMCAtIDB4QzdGOiBEZXZpY2UgMTEN
Cj4gPiAweEQwMCAtIDB4RDdGOiBEZXZpY2UgMTINCj4gPiAweEUwMCAtIDB4RTdGOiBEZXZpY2Ug
MTMNCj4gPiAweEYwMCDigJMgMHhGN0Y6IERldmljZSAxNA0KPiA+IDB4MTAwMCDigJMgMHgxMDdG
OiBEZXZpY2UgMTUNCj4gPg0KPiA+IEludHJvZHVjZSBhIG5ldyBjbGFzcyBhdHRyaWJ1dGUgdG8g
bWFrZSB1c2VyIHNldCBlYWNoIEkyQyBidXMgZ2FwIHNpemUuDQo+ID4gVXBkYXRlIGZvcm11bGEg
dG8gY3JlYXRlIGFsbCBJMkMgYnVzIHJlZ2lzdGVyIG1lbW9yeSByZWdpb25zLg0KPg0KPiBJIGRv
bid0IHRoaW5rIHRoaXMgaXMgbmVjZXNzYXJ5IHRvIG1vZGVsLiBDb3VsZCB3ZSBzaW1wbHkgaW5j
cmVhc2UgdGdlIHJlZ2lzdGVyDQo+IE1NSU8gc2l6ZSBmb3IgdGhlIEFTVDI3MDAgYnVzIG1vZGVs
IGFuZCByZWx5IG9uIHRoZSBtZW1vcHMgdG8gY2F0Y2gNCj4gaW52YWxpZCByZWdpc3RlciBvZmZz
ZXRzID8NCj4NClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQoNClNvcnJ5
LCBJIGFtIG5vdCB2ZXJ5IGNsZWFybHkgdW5kZXJzdGFuZCB5b3VyIGNvbW1lbnRzLg0KQ291bGQg
eW91IHBsZWFzZSBkZXNjcmliZSBpdCBtb3JlIGRldGFpbD8NClRoYW5rcy1KYW1pbg0KDQo+DQo+
IFRoYW5rcywNCj4NCj4gQy4NCj4NCj4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvaTJjL2Fz
cGVlZF9pMmMuYyAgICAgICAgIHwgMyArKy0NCj4gPiAgIGluY2x1ZGUvaHcvaTJjL2FzcGVlZF9p
MmMuaCB8IDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9pMmMvYXNwZWVkX2kyYy5jIGIvaHcv
aTJjL2FzcGVlZF9pMmMuYyBpbmRleA0KPiA+IDdkNWE1M2M0YzAuLjQ2MmFkNzhhMTMgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+ICsrKyBiL2h3L2kyYy9hc3BlZWRf
aTJjLmMNCj4gPiBAQCAtMTAxMSw2ICsxMDExLDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19y
ZWFsaXplKERldmljZVN0YXRlICpkZXYsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgICBTeXNC
dXNEZXZpY2UgKnNiZCA9IFNZU19CVVNfREVWSUNFKGRldik7DQo+ID4gICAgICAgQXNwZWVkSTJD
U3RhdGUgKnMgPSBBU1BFRURfSTJDKGRldik7DQo+ID4gICAgICAgQXNwZWVkSTJDQ2xhc3MgKmFp
YyA9IEFTUEVFRF9JMkNfR0VUX0NMQVNTKHMpOw0KPiA+ICsgICAgdWludDMyX3QgcmVnX29mZnNl
dCA9IGFpYy0+cmVnX3NpemUgKyBhaWMtPnJlZ19nYXBfc2l6ZTsNCj4gPg0KPiA+ICAgICAgIHN5
c2J1c19pbml0X2lycShzYmQsICZzLT5pcnEpOw0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25faW5p
dF9pbygmcy0+aW9tZW0sIE9CSkVDVChzKSwNCj4gPiAmYXNwZWVkX2kyY19jdHJsX29wcywgcywg
QEAgLTEwMzMsNyArMTAzNCw3IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9pMmNfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgICAgICAgICByZXR1cm47
DQo+ID4gICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1
YnJlZ2lvbigmcy0+aW9tZW0sIGFpYy0+cmVnX3NpemUgKiAoaSArDQo+IG9mZnNldCksDQo+ID4g
KyAgICAgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKCZzLT5pb21lbSwgcmVnX29mZnNl
dCAqIChpICsNCj4gPiArIG9mZnNldCksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmcy0+YnVzc2VzW2ldLm1yKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oIGIvaW5jbHVkZS9ody9pMmMvYXNw
ZWVkX2kyYy5oDQo+ID4gaW5kZXggMDY1YjYzNmQyOS4uNDIyZWUwZTI5OCAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2ky
Yy9hc3BlZWRfaTJjLmgNCj4gPiBAQCAtMjc1LDYgKzI3NSw3IEBAIHN0cnVjdCBBc3BlZWRJMkND
bGFzcyB7DQo+ID4NCj4gPiAgICAgICB1aW50OF90IG51bV9idXNzZXM7DQo+ID4gICAgICAgdWlu
dDhfdCByZWdfc2l6ZTsNCj4gPiArICAgIHVpbnQzMl90IHJlZ19nYXBfc2l6ZTsNCj4gPiAgICAg
ICB1aW50OF90IGdhcDsNCj4gPiAgICAgICBxZW11X2lycSAoKmJ1c19nZXRfaXJxKShBc3BlZWRJ
MkNCdXMgKik7DQo+ID4NCg0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90
aWNlICoqKioqKioqKioqKioqKioqKioqDQrlhY3osqzogbLmmI46DQrmnKzkv6Hku7Yo5oiW5YW2
6ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/neitt+OAguWm
giDlj7Dnq6/pnZ7mjIflrprkuYvmlLbku7bogIXvvIzoq4vku6Xpm7vlrZDpg7Xku7bpgJrnn6Xm
nKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHogIUsIOS4puiri+eri+WNs+WIqumZpOacrOmbu+WtkOmD
teS7tuWPiuWFtumZhOS7tuWSjOmKt+avgOaJgOacieikh+WNsOS7tuOAguisneisneaCqOeahOWQ
iOS9nCENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykg
bWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhl
IGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5n
IHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0K

