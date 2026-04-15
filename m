Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E7AF9D0FD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 00:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCoUG-0007eU-4e; Tue, 14 Apr 2026 20:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCoU9-0007cM-QC; Tue, 14 Apr 2026 20:52:06 -0400
Received: from mail-japanwestazon11022117.outbound.protection.outlook.com
 ([40.107.75.117] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCoU4-0006lQ-8X; Tue, 14 Apr 2026 20:52:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syUbKWuKSWWc/qhiuqQAfVxZJEgoPgtymAPuSkef4wrkwSzRTw5k23n/CLHWK9ZoeyVAE5k5M612If0QzOq+Z1+OUhqmox2TFUMhbFdjGmElgb0LNmymlAajy+7kouurgpsQpwYmS+Eq0hAZ12VXmEu9V21pqEeC9oxFxVfRN4iTHK3iIF4gkdymV1tYpC3dPplqIUB6qI72ElQ7wqS27h9OcAHYYBdp4aYxssFV7tUj2pGhaVhm1tjiyheRZ3XN6L1NIe08xjBjnAZXFy9HzPWkPU1PDlfG/o2L3hXL8xGyD9YWoK54ELYb+m8dhil9kz8u6qP7o195WorxsiZ3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS+ZyU1op6yIjwAQPlBJpb/vq2TYCXqaV8BTDXJJoN0=;
 b=QZIo5Zl/kCuoo7SvyGRQZ9gu4nQvSzq5uJ0fygkQNFNBNhhlHE7SXKwIKR9ilYOJEv+L23/vaTyxYM2NQwFo5cf6WxDbGTAY3eN4fOksaG5etB9V/pMwYe0Xd98vStAFcM+Ye/1m3tOirgNRBPdP89GTvQYjFmXXKxOGyqDe03klaCY0VpQ10qX70ran0nfg7HGsINKx3rJ9mKJimkxYQDN1uZXDxuAicqX3sO5rmLkh+2ejkTW7xUYTGYFriisVnsZwqNfm2v+X1+KjPWaRHiZ559BXlSbGoTPyZ8SwhRrIdlgnHIjn5g1mvC2/Y2ADPx3TCLvV/LscnGLIU+rYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS+ZyU1op6yIjwAQPlBJpb/vq2TYCXqaV8BTDXJJoN0=;
 b=eJ2c9T8Ecehm43iOjibHtZC0A1vgMRq59f5igphzY73X63UyY5eNBzUKXooE3tYD2xvn4eBSw2WBr3cVLgO2MRT6yHaif5lySio8hMMHVhi4vtqAa/d0goWjS3fY9bgIG8bv0ttY8UXVnCKvEcG9eK8Sbjs6I6ozfqalYMDOBEkJpXi8IqSSQLOujIErBVYcfKONAdz/C6Zi6iv2EEXRLondpkoA7TbWL/7E2kyLHjB+5BCUOn8TEzEorMgaodUWRSSDcOU6PX/kkNzwnXBCPmpyXzdlp2ac8QACReQutgVDsjQa1lmUWbt+ydoGO0lyugS7dbzOHcw62pAoH/BbPA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5003.apcprd06.prod.outlook.com (2603:1096:400:1cc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 00:42:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 00:42:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 07/13] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v1 07/13] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHcsShdtlTDceAZ10KDqmxaDHilIbXcGYUAgAHwW0CAAHHrgIABAzog
Date: Wed, 15 Apr 2026 00:42:35 +0000
Message-ID: <TYPPR06MB8206F12D60BE44EE0374E15DFC222@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-8-jamin_lin@aspeedtech.com>
 <b143a786-751e-4d19-b27f-40449aba52a7@linaro.org>
 <TYPPR06MB8206F995851E9CAC13928361FC252@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <c1e69281-4837-431e-a12d-192d563d08a9@linaro.org>
In-Reply-To: <c1e69281-4837-431e-a12d-192d563d08a9@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5003:EE_
x-ms-office365-filtering-correlation-id: a52063fd-0453-440d-a160-08de9a87e34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ei+r8eCaKkmZjZgMVjgFgbNdfRSwOiH8B5aD7y4CXiSJyQ5HRtiGu8slSHrKqLhnYhOoEPNihxsPojaDTVdQUoeHa/d2mcXFtWhvrtGDrJf1sZRxe+03KrZ2BMUbdenTOBqX7GiC6jRqQbmMR80LYRqOt+ZPJQiC0X8evx+ECtU3p4/dUZ9U1L/FXUah695OzWceSFvkLZ1Lzf8wu+7TaghLzfSeXdZBiF7x8fUAa3R/5awcgFvELXxobVQWZ1a9H7CvIp0i6w6HLAEFhNNxeuuhZSBmz5yaI5Kkizo4GikxEetlKe5v8+Zui5L/IPpOJ7NbjFG24e2zPZtoQoG4wWgksrJqvcxN4+J4PvRFPDZgrqNTImagvj0S3jFonAioVwbmhUEHDPJTm0gRqAnDFWNmRA84IcNXI1NPE7U6d1UXtNowYuZ/JUIhSQe05dJuTPzHqkjI5VQJ8HUGYei0PSO9K5WI7Fqm3YgTLo9Kz2JhNpCOZNW5sFLJ2vvQ5/kA8zPvaELJXpBIdfn7zO/C/oe2PEnzmKV5w9epGlhG48tmURAqDMf2dQNEi3R1uT0rtoyQSCO4M3/JIhrwE6N3ggLHcSqOXwr5lg83EyR+XkcSHNgwNUjM6E2lnBcrRJuwDeyXhtEYTjRa+YxhiVI78dKak2fvxfevAIw7L1xO4fkuRgoIZeBUCaM7a2yYOCu8rOpiWBtrSLdxjIenUrcqf9lZvx5jrCsCXtmr/m4a5dBMSo3JC6uDAK/BR8/6oC0YliYml8A3sP/71ZSXVkAaHKZX34BZqGjxwhzepRL9s7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE15eWduQjJCVjR3V2QxVEhnd0lrQTArRWxxOWxla0ZNY09wWThHZDV1TWxp?=
 =?utf-8?B?NE05N1pVTGNPQ2RXZGR6TjJrNDlSMis4NW43SlBWMlZjR1BQTi9ObWtLUWlV?=
 =?utf-8?B?VHdRWUVZMWlhZG0xMnJFWnoyYnlLWXZ0WXJQWEprOFdQUGtZQXpTRGp4V2kz?=
 =?utf-8?B?MG1mbVZGQ1RRbThMTGdrNkVBVDQwZFNOYmhRVVY3V1p5VFVPUWFjL3VsWG83?=
 =?utf-8?B?Q1p6cktSZGp5bUZXeXAvdng3elZuWk11QWxWVzFwK3RIdlUvQ0ZDVHJqU3p3?=
 =?utf-8?B?SnhaL281UDJpdnVsRUYreTNjZ0c2eitPYVE1eTkrZE43T0t1SlRjak45bkJr?=
 =?utf-8?B?bmVUUHQrNnJLVXJpdXNTZmFQYkt3QmQyMkNLYXhTUjZEblJURUYyOWJOcFVl?=
 =?utf-8?B?TlYxNmdTOEoyMjZRVXlKbEswSTYzWkZwK09pc1BFR3dxNjcwOHI1WitNcmlC?=
 =?utf-8?B?VGhwY1ZKYzRnQkNjSzZKblNTVi9wdFRaOXhzTDd1UlB3bzVhMW9vS1Fod2t6?=
 =?utf-8?B?cXhjaVdzaUprbnJWUlZzblkwT3Z2bWh2RWdhNFNIaEJiSkt0aXh1bFptYVNT?=
 =?utf-8?B?NXFBTFZ5WlRMSlJzdXhtZkVXR0RDby9QYlNqdGFIaUZKNUZkU0dmNWk4dkFM?=
 =?utf-8?B?bDU2OXNOUXhMSW1BRFQ1SHRWUk1kNDQ1RXlVQnhrSG01bTBMV1B3UUZtdkZI?=
 =?utf-8?B?dUlhNklzMWdMc3JpMlNIcXhvcy9pcVowOXlRZGN6dlZuVlp0K2FHTWxqeVQz?=
 =?utf-8?B?VGNSb1VVRHBML09memdQbm43ZW53T0NmbGJmRVNtQk9YQlVQSHlKZzBtS0tk?=
 =?utf-8?B?Wm5JcXlmbmpNQWNLSURxZDNCYVRlTHFqNEhDUFRvZHVFQmZrS01SWE5RaUVK?=
 =?utf-8?B?N3dMeFZqdmdUVTVTL3BJL2p0Z2duOThmTEs1ZWt1clZUMURTNERQSmR4dWQ4?=
 =?utf-8?B?NzhzSTRmamVFY29udEtxeDkyV0pQOXJRNEFDb2k1ektUTnFhTGdtVUZBQkw4?=
 =?utf-8?B?NXZYLzUyQUg3YlIrWDh4dndISjMyRU1TT2NDTU9EVmd6eUNKeTB3L01PSzVo?=
 =?utf-8?B?dTR4YXVtMkVqK1g1ellGbHZweVdqK0pKZjU4TTlvUlJrWFZHc0lGYWhONUNU?=
 =?utf-8?B?NmtJVFUxUUwzVThLWG0zNUtVS2wvTzdoQ1gxSHU2TXB4TUhZdUJ5eVhzOFVO?=
 =?utf-8?B?clI4MklHaTh4aTh5eVJVZWVxUHY5a1h4RTMyUDVOMy9tK0RjY21hWDhTYVFq?=
 =?utf-8?B?cGIzOWVwZ2VHeHhLYmdRbWNpY0VNcG8vUER2eXRoYTF6aVk5SHRLVVdXVXk1?=
 =?utf-8?B?RGlHQmIvZmR4U1ZxNjh5c3JmMk1yNUFWWHVMbGdUbEZVVTJrSzR1ekZEaGp2?=
 =?utf-8?B?MERoeTdDUVlyWHpiTjR3ZEFXV2QvN3BZREJyaHlTWVZQZWNFSUlaSEpPOEht?=
 =?utf-8?B?SGpmcEVQWDlDSG1wTy9kYmgxZ2owQkdTZDFnNENIZVVhU0hyY1FRY1VzWWc5?=
 =?utf-8?B?M1d3T2syVC9jSnlBN2NqT3Brelh3blIrTklYYldTcWordVFCMVAvZUJQWXhX?=
 =?utf-8?B?OGdnODFGdVJBcnd3eFpNTy94cEhmWGRTbXQwbEcwZStLeHBXT1QydDdEbkFS?=
 =?utf-8?B?UytDSEc2VjY1azNOY2pZYWhGVzk5bTlQRkJlZFRlTWQrYU1TbEdxVWJsblhG?=
 =?utf-8?B?NTdDbFdkcnhrR1dMVmxNUWxRNjFRVVd5Y1h2NGJJb25WUDg2Y09aL3lEc01p?=
 =?utf-8?B?Y1NDWTkzZ3ZvZlFpeW9LTGZWUElHSlc1dDJDWkxpbmM1aHQzZi9mcWgrVE5r?=
 =?utf-8?B?NFhIZnR1UW1nVlJ4TnV2QnlYdUJTZlZqZ3JFOSt2eWtCVVRsQzdWNE5MQjhm?=
 =?utf-8?B?ZFlWUlB0MG9uMmFSRDkzeXJGeEZJRnB3bnpZeGViS3laMitxeFBQZGNqQmg3?=
 =?utf-8?B?YkhXUHlGVnlNV2ZBVmdlemdNekU1bGNLY2ViYm5idjlQU1lEQllBNHVyQ2xy?=
 =?utf-8?B?aVp5cUkzM1pyTUc4a1UrUTFOS3g4b3EyMEUvaGVHT0FyM2o5WmxBaEI1STM5?=
 =?utf-8?B?OW1rUWJMcmRrQWZxMDVsSFk1bVN3QUFSblB2c2h3OGt5RzVkRkVvcHJJVUw2?=
 =?utf-8?B?cDBCTHAyNi9Bek5Yd3JjVk1SUjNKb3JveTMxcFdtSEVxOFNvTmJwbldWb3NK?=
 =?utf-8?B?YXZ0T1dHNU1IRDRwRjZvaERLSjJUUGtkUXRQVTdOU2EyQkF6WU0vbkF0NGpk?=
 =?utf-8?B?cVV4bmR2cExaRzUxb2kyUVUvbkpSckN3Rm8rRjd0TnFRNC8wT015T1J5endM?=
 =?utf-8?B?RlhmTHZhMXZsN1pUUFJ6YldOZVVHQ1lFNVFJRk83b1hwSjBTY0N2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N9oVfxbuylZYluSA25f6zN/lEhFJhC2ywfB0/Wzs3xa3sn4MPq4EIjASFzo5N4lR8WGeGk957uoLAuXlpD+yzkvXzxempZqSI+1BKvmFQb4QjT6of/tJYsOtt1Y1iaTCC2T9izDaAbiDIloOPYMl8kELX5dRD4aJ5lzj3NiqPy44tv8JT5mv1bZx5HbqBbeRzUUIisSp2IrPZzo8/HSXeQhyhvr8JJMTFPKJMeYt3uW0Lbuz1slkMVQ+8UgTtO9ub4wDczQF7FXVmC9WkJ1CSyv+UTPqbSXmH2BC3KP07JRKeOssk0ZT1hndvYShSGz4GIMqZLwPQPWjiUuQYddmBA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52063fd-0453-440d-a160-08de9a87e34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 00:42:35.7606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYXMfS69qceUpc5y193/W0MsnvnT74c2Wjmmw6ZHpvG0rwTvmgB5+14Fg7J0kLaTBuHWJQQatRJIoWNEv540MRRcesZh7R7qnLPbH4p/Nt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5003
Received-SPF: pass client-ip=40.107.75.117;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA3LzEzXSBody91c2IvaGNk
LWVoY2k6IEltcGxlbWVudCA2NC1iaXQgUUgNCj4gZGVzY3JpcHRvciBhZGRyZXNzaW5nDQo+IA0K
PiBPbiAxNC80LzI2IDA0OjQ5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgUGhpbGlwcGUNCj4g
Pg0KPiA+Pg0KPiA+PiBPbiAxMS8zLzI2IDA4OjI2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+PiBF
SENJIHN1cHBvcnRzIDY0LWJpdCBjb250cm9sIGRhdGEgc3RydWN0dXJlIGFkZHJlc3Npbmcgd2hl
biB0aGUNCj4gPj4+IDY0LWJpdCBBZGRyZXNzaW5nIENhcGFiaWxpdHkgYml0IGluIEhDQ1BBUkFN
UyBpcyBzZXQuIEluIHRoYXQgbW9kZSwNCj4gPj4+IHRoZSBDVFJMRFNTRUdNRU5UIHJlZ2lzdGVy
IHN1cHBsaWVzIHRoZSB1cHBlciAzMiBiaXRzIHdoaWNoIGFyZQ0KPiA+Pj4gY29uY2F0ZW5hdGVk
IHdpdGggMzItYml0IGxpbmsgcG9pbnRlciBmaWVsZHMgdG8gZm9ybSBmdWxsIDY0LWJpdA0KPiA+
Pj4gZGVzY3JpcHRvciBhZGRyZXNzZXMgKEVIQ0kgMS4wLCBzZWN0aW9uIDIuMy41IGFuZCBBcHBl
bmRpeCBCKS4NCj4gPj4+DQo+ID4+PiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhc3N1bWVz
IDMyLWJpdCBRSCBkZXNjcmlwdG9yIGFkZHJlc3Nlcw0KPiA+Pj4gYW5kIGRpcmVjdGx5IHVzZXMg
bGluayBwb2ludGVyIHZhbHVlcyB3aXRob3V0IGFwcGx5aW5nIHRoZQ0KPiA+Pj4gQ1RSTERTU0VH
TUVOVCB1cHBlciBkd29yZC4NCj4gPj4+DQo+ID4+PiBJbnRyb2R1Y2UgYSBoZWxwZXIsIGVoY2lf
Z2V0X2Rlc2NfYWRkcigpLCB0byBjb25zdHJ1Y3QgZnVsbCA2NC1iaXQNCj4gPj4+IGRlc2NyaXB0
b3IgYWRkcmVzc2VzIHdoZW4gNjQtYml0IGNhcGFiaWxpdHkgaXMgZW5hYmxlZC4gVXBkYXRlIFFI
DQo+ID4+PiB0cmF2ZXJzYWwgcGF0aHMgKGFzeW5jIGxpc3Qgd2FsaywgaG9yaXpvbnRhbCBRSCBs
aW5rLCBhbmQgcGVyaW9kaWMNCj4gPj4+IHNjaGVkdWxlIGVudHJ5IGhhbmRsaW5nKSB0byB1c2Ug
dGhlIHRyYW5zbGF0ZWQgNjQtYml0IGFkZHJlc3Nlcy4NCj4gPj4+DQo+ID4+PiBBbHNvIGFkZCBi
dWZwdHJfaGlbNV0gdG8gRUhDSXFoIHRvIHN1cHBvcnQgNjQtYml0IGJ1ZmZlciBwb2ludGVyDQo+
ID4+PiBmaWVsZHMgYXMgZGVmaW5lZCBpbiBBcHBlbmRpeCBCLg0KPiA+Pg0KPiA+PiBidWZwdHJf
aGlbXSBpcyBub3QgdXNlZCBpbiB0aGlzIHBhdGNoIChidXQgdGhlIGZvbGxvd2luZyksIGhvd2V2
ZXIgSQ0KPiA+PiB3b25kZXIgd2h5IG5vdCBjb252ZXJ0IHRvIDY0LWJpdDoNCj4gPj4NCj4gPj4g
LSAgICB1aW50MzJfdCBidWZwdHJbNV07ICAgICAgICAgICAgICAgLyogU3RhbmRhcmQgYnVmZmVy
IHBvaW50ZXIgKi8NCj4gPj4gKyAgICB1aW50NjRfdCBidWZwdHJbNV07ICAgICAgICAgICAgICAg
LyogU3RhbmRhcmQgYnVmZmVyIHBvaW50ZXIgKi8NCj4gPj4NCj4gPj4gYWRhcHRpbmcgdGhlIGN1
cnJlbnQgMzItYml0IHBhdGggYW5kIGV4dGVuZGluZyA2NC1iaXQgaW4gdGhlIG5leHQgcGF0Y2gu
DQo+ID4+DQo+ID4NCj4gPiBXZSBjYW5ub3Qgc2ltcGx5IGNvbnZlcnQ6DQo+ID4NCj4gPiB1aW50
MzJfdCBidWZwdHJbNV07DQo+ID4NCj4gPiB0bzoNCj4gPg0KPiA+IHVpbnQ2NF90IGJ1ZnB0cls1
XTsNCj4gPg0KPiA+IGJlY2F1c2UgdGhpcyBkb2VzIG5vdCBtYXRjaCB0aGUgRUhDSSBzcGVjaWZp
Y2F0aW9uIGZvciA2NC1iaXQgZGF0YSBzdHJ1Y3R1cmVzLg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRv
IEVIQ0kgU3BlY2lmaWNhdGlvbiAxLjAsIEFwcGVuZGl4IEIgKDY0LWJpdCBEYXRhIFN0cnVjdHVy
ZXMpLA0KPiBidWZmZXIgcG9pbnRlcnMgYXJlIG5vdCBkZWZpbmVkIGFzIGEgY29udGlndW91cyA2
NC1iaXQgZmllbGQuDQo+ID4gSW5zdGVhZCwgdGhleSBhcmUgZXhwbGljaXRseSBzcGxpdCBpbnRv
IHR3byBzZXBhcmF0ZSByZWdpb25zOg0KPiA+DQo+ID4gVGhlIDY0LWJpdCBhZGRyZXNzIGlzIG5v
dCBzdG9yZWQgYXMgYSBzaW5nbGUgY29udGludW91cyA2NC1iaXQgdmFsdWUsIGJ1dCBhcw0KPiB0
d28gaW5kZXBlbmRlbnQgMzItYml0IGZpZWxkcyBsb2NhdGVkIGF0IGRpZmZlcmVudCBvZmZzZXRz
IGluIHRoZSBkZXNjcmlwdG9yLg0KPiA+DQo+ID4gVGhlcmVmb3JlLCBjaGFuZ2luZzoNCj4gPiB1
aW50MzJfdCBidWZwdHJbNV07DQo+ID4NCj4gPiB0bzoNCj4gPg0KPiA+IHVpbnQ2NF90IGJ1ZnB0
cls1XTsNCj4gPg0KPiA+IHdvdWxkIGluY29ycmVjdGx5IGFzc3VtZSB0aGF0Og0KPiA+DQo+ID4g
bG93ZXIgMzIgYml0cyBhbmQgdXBwZXIgMzIgYml0cyBhcmUgY29udGlndW91cyBpbiBtZW1vcnkg
YW5kIGNhbiBiZQ0KPiA+IGFjY2Vzc2VkIGFzIGEgc2luZ2xlIDY0LWJpdCB2YWx1ZSB3aGljaCBp
cyBub3QgY29tcGxpYW50IHdpdGggdGhlIEVIQ0kNCj4gc3BlY2lmaWNhdGlvbiBsYXlvdXQuDQo+
IA0KPiBPSywgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gKFBsZWFzZSBtZW50aW9uIHBh
cnQgb2YgaXQgaW4gdGhpcyBjb21taXQNCj4gZGVzY3JpcHRpb24pLg0KPiANClRoYW5rcyBmb3Ig
dGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgYWRkLg0KSmFtaW4NCj4gUmVnYXJkcywN
Cj4gDQo+IFBoaWwuDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEphbWluDQoNCg==

