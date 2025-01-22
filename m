Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662DBC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 03:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taRZG-0003zB-Ns; Tue, 21 Jan 2025 22:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taRZD-0003ys-WC; Tue, 21 Jan 2025 22:38:12 -0500
Received: from mail-psaapc01on20716.outbound.protection.outlook.com
 ([2a01:111:f403:200e::716]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taRZ7-0008CQ-W1; Tue, 21 Jan 2025 22:38:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIz+aNAYKtTmpSlOwM+2ZwLZHSJvZ2/jF60z3an0+1tk8pXyPMUYWd5GKjV5dDdbOa1nOtHZVx43L7VDn9rURIs7xRASK38ky3gfNekcjW2+QUuYi/vjnVa9wLflhy+Pw1GrM2JIQ+EQUoGzq6rCkZA3CnHNY3PFSzPVI2hK9KL+NABTfF+nUW8V8PN0cl2iotRDWucBlDdpC6GYTVtkalDMDA9kTYqir4jF0qGOqVcqxC89t4LpifuOHtIqTZ8ir5QlEuzwsos3mnYR02e6uliRHxPelJYBcMt47j4piIWb/4xXnwPbx1eT3dpD84g573uzWAY6miKRdGha41xkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmZPnua4TfH+8xAG4CYy/6ccqDz7TUAjLrF9TrqNsU4=;
 b=IhszLfAtmQ4dxQblFpsit4DUGLDn9RDclTQkilwkcWN1LdzwgNpXJpf6BF25wZQqnOLSIMy4n1Xl18W6ifn2o89qcG9t4l/Lucte/KgiDT53bAkkueiWYOlh0pXhikz70ojWbdJt57S8sbfsUStfBdzlp+bQYLYgFZT8ia/uH+Be5us1Z9dnBbmh3I/IVZ3/jsQCORGyawMjqtJqA7abPQzyFLd+0sbn1xX7RiNWy9jvqMbEvG9eE8Ml/RBQin/G+F9fKCT0f2UWzw/QLMJ8/oSKNP3OzqTvs94siyAz5qBj60YzPKLpWHHzuYYV8AmQbDh8tGYKJv7DTsrBkHgjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmZPnua4TfH+8xAG4CYy/6ccqDz7TUAjLrF9TrqNsU4=;
 b=FzAtkUkpS6akuiq5IsebB1huUUmb+4I77jwft9yhj+KROf1M3429cPT1zw8VcBW49/JlsoUd0VEuEc2biA3DNR7S2SnXRrO6+PHjRFgOSPP3tUB0SkwEX7n+Vku30w0thODcF943YH/ngFb5+RGM6nYOIr/oDjIUjsf/6YPJZRVFS042k2qMtUHVWDuKFwMSnDKuaFlqE3pOH7GGsGSr/lERskOdXFh1vKKQkhJ9JquW2JLdsWA0EOo398OlcIUE28KxE+yIvWM6nLDyU3ZHC66LZWkpMKJWZ5mWwst7mUoouVrHNKtKcaGzTMiN6a1J7xmxCROajtmKBCZIkcM1eg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6703.apcprd06.prod.outlook.com (2603:1096:990:36::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Wed, 22 Jan 2025 03:37:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 03:37:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 0/3] Support timer for AST2700
Thread-Topic: [PATCH v2 0/3] Support timer for AST2700
Thread-Index: AQHbZYasrjdPDnCvgEK0HK0og+bC17MfcKkAgALB8kA=
Date: Wed, 22 Jan 2025 03:37:58 +0000
Message-ID: <SI2PR06MB5041CE6ADE4237A763644474FCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250113064455.1660564-1-jamin_lin@aspeedtech.com>
 <929bd54a-1325-4282-9b7b-0d8f83cd6f11@kaod.org>
In-Reply-To: <929bd54a-1325-4282-9b7b-0d8f83cd6f11@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6703:EE_
x-ms-office365-filtering-correlation-id: 56fbf9bc-1dfa-46ff-f3d1-08dd3a962a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WWM1TXZMbXBiZ0txTkkzOGVHTXA4WHl5cTNEY0grRXgwSS83VUMwbzhSSkx2?=
 =?utf-8?B?YStxODUvdzFudGs0TFc4VlZhVGQ4TWgzOHdXUitVQ2lQaWhuS1JHR1ppZGpE?=
 =?utf-8?B?VWlvM3pNK3VBb0ZHaXV4UmNoVDJmU0l6QUpiNzRONDdUSEhGWjVqem1XZTlM?=
 =?utf-8?B?ZUdiV3d6QStFUGVOMHRnbzhwbFkzWDBSZVNFWkpqYU1NRC9tMk5KUHhrSHov?=
 =?utf-8?B?bjFvL3Q5OFJ3OHRWYkdDMTBGOEJDVjVVMFNsWXpxYnpYaTFtOWtiaW1DQnRi?=
 =?utf-8?B?bUtrYU8xa1owMDNFVmRlc01sSmUzRVdOWVBmN0doYUptT2tFRDRPRlgyWm5x?=
 =?utf-8?B?bGJ1bjN1ZW5VNXBDa3hQSUdnaXhvTVBMQ1RwRVY4WGhaVk1SVm12bi9lVno2?=
 =?utf-8?B?YzlkTUdmLzhiMi9GR3VGUitJc245TjltQlRhNkEvVnlaWDF3clNrR1V1a2J3?=
 =?utf-8?B?U2Uzd09UTWZhak9MNVEyWEthQWhRSEpLZnJERjZFOW9EcnkrVkdpZHhPWHh6?=
 =?utf-8?B?ZndMSUgxYzdYdk1tQkRMVGh4bGdRNGdUY2xBT1E0eWpiY2o2d04yMk13VmlI?=
 =?utf-8?B?MHJzYWJ1MEk3UWx6QW1oNDRsZkR6LzhqdFA4MTJTbThzVFRCajRFWWU3OFgv?=
 =?utf-8?B?ektNTXNGTlhzL1A2STRpTkVJMUxpdW1TZWQzU1BFQk9INThmdzE5NW4vVHdl?=
 =?utf-8?B?N1RHM3pEQ2JNMVNSc3R4WXlWMGhCaEd4RFRXRDhkQ2s3Q3VVbXFyL2txeUN5?=
 =?utf-8?B?WUlGd0pzQ3ZJVHh2MDJOVzB4NXdicmxmUHFqOXBVOEtEYU1BZmNNK2p2OGRj?=
 =?utf-8?B?YlFqYXlPeSsvRkFsWGlNbElyMVc3b2d4V3JpZWNWZUdyMzkxQkQwc09wUG5Z?=
 =?utf-8?B?d2NtM3pnY3VzVFFnOXJkbmlZem5yV2V3R3JLRVlKdVNiWDlGa3pOWllXdzNP?=
 =?utf-8?B?czJYTnpWYU5WQlk2ZXByRUhSOUl4bUNWYXJuSXR1eDZrWmxuU0M1aDVQamE2?=
 =?utf-8?B?QjNLQlVKV2pvN0c5d045bC9wNndQSXp4Q1hiTGRYUVlyWHBXaFpXR2VGKzVS?=
 =?utf-8?B?dmlPVFpSSkVXTWhEb3ljTWtWQVBlL0VGQnlTVFhzT2tIU002WEMvZ2VIc1dq?=
 =?utf-8?B?QmZLc0FvRWVxbThscGdRVU9ycUF2QzRLYkVDL3M0MnowTlRUWkp4ZldpaFpY?=
 =?utf-8?B?bWJwSWFCbnhNL0w2emU0eHV1VnovYUNCL3lxRXI0cDZuWDh3eU5EOHJDMjRi?=
 =?utf-8?B?OUI1UHhNL1lOaUk4ODl3aW9lVUhvUWFyY0xxeFBLZjZ2MnArYWE2L2hoZ0lB?=
 =?utf-8?B?bHFuTS8wbUxiNEs0RE84MTg3RXRFNzhaN0toKzJ5YXY2MVZUWVBCeXlZUC82?=
 =?utf-8?B?cWFxaE5KWmVOM2NmVnlYbGM0TUxxNlJKS1VXMitNQStQM1ZSdDhXWjVOaWtq?=
 =?utf-8?B?M1VueXFDM3JxaVVzZ2V4QjRyRU81d1MwZzdhSG5oTDFqbVBWamdhSFQrNk9o?=
 =?utf-8?B?Um5KTVFaa1A2akl3dlpReEtDTGkxQXRZc29qM1JuaFVieXRiN1o1dUdDc1lj?=
 =?utf-8?B?ekRTeUlBU29QZUFwZVlpWkdUZnAzb1hpTkptT0NxQnNQcUhWcDNhdzNOMktQ?=
 =?utf-8?B?MllDOTNxeUhsNnY5OGRYT0s0M0N4Mzhlc0d3bktNbUEyWkROTTRoSmgxdXg5?=
 =?utf-8?B?SkxYbHpTRWlka21OR0VnWm05UGN5bUtvOHZkR01iQVJ3OVUxZzdiaUZHQVlm?=
 =?utf-8?B?Nmp0U1NLeS9DeHlXbU4zQk1hODNpWlQ0NXlHQkcrbThxL1E3S0lWTlBvamU2?=
 =?utf-8?B?aHpmVnpIeHl3ZjZSeDFQRDQxbVhzMnhCS0NKb1I1OWlWczNoWU9KS1h0ZjBz?=
 =?utf-8?Q?ST6ewbmNb5w5D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVlRbWhxdHlBb3g2RDhteWZtMmtiMUpKZ084Vkpmb2RMTUorU0Z6eDNjVktx?=
 =?utf-8?B?eWNiZnFTcjhZTmdtVXV5Y3QzOTMyVE5CeVJkY09TTWtocFlWV2VuRHlsMWlX?=
 =?utf-8?B?aEk4STlBSkNHTEh2ejZIUko1ek5xSVZ5NGw1a3V1ZkU5a0ZPVmYraHF1RzZV?=
 =?utf-8?B?NUhSNytkQ0lIeGtSYmMzbk9OdkQybXpzL2d5ZXhWRWZkeTlScmdZNVBUNnNm?=
 =?utf-8?B?dG5Ya1dJVlBNZEJ2WnVlY2xuLzVROGdRL3A4eG1mYm55S3B2cG12VnhGNlF1?=
 =?utf-8?B?bUtUM3o4QUljVTk1bkcwM3lwQ28zR1F0NDZwcEJ4MkxQWnFzaURZUmI2TnVE?=
 =?utf-8?B?QytXN2xudUhPdGwwdFFnU0dQSVpXVytXMHZMazNQK1hiejN1SWhmNEVTV2ZV?=
 =?utf-8?B?dkREWDJTUUcrMWY5OXUxdW15NnhuOW5wTTRqRGdhS3pWL2dvWEJkRUR0Z1lG?=
 =?utf-8?B?NldEU1FPYWZOK3RtT2FMaWMrRVYrdWxVdURPZjlRVit2TG9DODVQblVSYnln?=
 =?utf-8?B?dXVCbjZlK0E0TVhxMmpmMFVaVGRRbUk0UEZGWXkzTlcrTU9qbDdzaHdGdlNJ?=
 =?utf-8?B?TmxjZFg0NDkyT2NSZFBUSHlESW1PNHR0NjAwZTY1MWd3dWszdzdWYjg5RFA4?=
 =?utf-8?B?bWpTT2ZtMTgzUWtWNStabFFzNitaa2x1N2pwbGwyNldmcko3ZS8yc09VbGIy?=
 =?utf-8?B?ZEZEKzJlanBWS2xueEp4TVNPYVVDaXBZeGtZK3V3dlJvbVN4MTJpK2RFZzlQ?=
 =?utf-8?B?OXNVbk1kVlQ0NGd6bjNZblBFNjQvTWJNOHptRDBXdXhFTFFsSXNWUEZMNEZi?=
 =?utf-8?B?b21xanNNZjJIanR5YnlKcnkvNm8rQmhjM2liUVVPdEdob1BxQlJ0T2ZTdWFl?=
 =?utf-8?B?d2VKU2x0VnZKTEJ4YWtsK0N6NzNCV09ZTS84UWdBS2xRR0YyRVpzWVJrRFpp?=
 =?utf-8?B?cnFSdHdyU2dieEFiK3dyTWxtUkl6UExaaHRtOEtFN3c2My96NWVseVEzaTF5?=
 =?utf-8?B?MW9NUUZ4Zit6K2xzR1ZQamtTRG9oMFlmejkwbnllRWVpVkxHaDFrMWVwcTZs?=
 =?utf-8?B?SzNNd1JRenNXbFkvekRFYy96cE5NRnpPejhLM2cvQWc5anBUTE0rSTdlbGVx?=
 =?utf-8?B?dEFFemYvZkwzeWJIMFdybDZyOVlaNXpTNjNza056Ry8wZ3pMVGNWelFxVlU4?=
 =?utf-8?B?WXMrL25yMGZHQWhwSk9kS1hyUEVVNVN0b1R4Y3QrS3ltUDFPNmtLelMyYzNZ?=
 =?utf-8?B?dU5QeHNwaTQ0aktRQm5qL2FoQ1RaM20vU2c2bC9OejhtQnRQRHFNOFNoMktN?=
 =?utf-8?B?VDlka3hUb3RXbjJDQmZpMHNjNDg0WWxyZXRDdktveGVpcW1VVkJKb2V3TGxX?=
 =?utf-8?B?U1FxRDAvVlVBTExyS0F2cExRNTh2dklCMWNaY25Dci95SEZ2K0IxNnNiQXdh?=
 =?utf-8?B?VHp1WWNHQStiUUgrUDhLOEtjWGNqWFlPOVZsR1FqWnhGNERvamRHRlhFdXZm?=
 =?utf-8?B?cElkVjNtOElYSVVMT0duaUFjUUJBUzhEOURqaHJ6eWo3SjN3aVVoRW95WjJB?=
 =?utf-8?B?OEFNNXVTandxTVRkRkZ3Q2JNRzlTQ0hOdkx3bUNyRWF1RmV3RUJjeFMyRlhC?=
 =?utf-8?B?WFpDQk9ycVJTbnhxcHBpd2p1MFFkQm5hdXdjaXFLYlk5TENOem0rMUMrNElD?=
 =?utf-8?B?WFAxVkJRVHliQVB5Y05vTUR0Wlc5UGQ1L0xMa3FrdUQ1YWs3a0Z3bi96WVox?=
 =?utf-8?B?dkNDNDhxeHBXbDU3MCsvQThvNERaV2FBLzBiUHk2Q3ZhY1FWR2hRVmh6THdn?=
 =?utf-8?B?Y3RHcXlqbmphT3lac3dPTHJPR3M0OUxqRTV4S1dUTDJFdW1ZYjd0Y3ZpazAx?=
 =?utf-8?B?TXZEN1dMemNkMExyQnVTSFVMWHRKYVdTdzZJVHhmd0czdDFhVzN3SEZLMElz?=
 =?utf-8?B?by95THU3bTBYOVJFSHo1OHVZYXlkWS9kQityOFpYVWdxUS9NcEh4a0gzQnhp?=
 =?utf-8?B?SE14eTIwS1dnWkcwOGpqa2FVYlN5a3VhMzd4dElxemUvRG1MT2JtakhXWU9D?=
 =?utf-8?B?MVVhZ0ZQYXZnQUlOV1NTMFhuVkFoS3BndXVYaS9TQ3hsZXEvZXJYcWE1SWRi?=
 =?utf-8?Q?/2dT7JIPenFhoelp8CD1DhxQ2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fbf9bc-1dfa-46ff-f3d1-08dd3a962a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 03:37:58.8753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrMa25ZAYwrGDw/DiAccJzG/iKGdqDZ4zagkbPvEtjGboa6ZokKFmeSeUt9Bu9lLoh3ITgDvplCrmKbVoGKTWdigyTN5nnwRlDKM0rouup4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6703
Received-SPF: pass client-ip=2a01:111:f403:200e::716;
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

SGkgQ2VkcmljLCANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjAs
IDIwMjUgNTozMCBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVl
IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwu
Y29tPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpv
ZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFl
bXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVt
dS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2gu
Y29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDAvM10gU3VwcG9ydCB0aW1lciBmb3IgQVNUMjcwMA0KPiANCj4g
T24gMS8xMy8yNSAwNzo0NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IHYxOg0KPiA+ICAgIC0gU3Vw
cG9ydCB0aW1lciBmb3IgQVNUMjcwMA0KPiA+ICAgIC0gSW50cm9kdWNlIG5ldyAiYXNwZWVkXzI3
MDBfdGltZXJfcmVhZCIgYW5kDQo+ICJhc3BlZWRfMjcwMF90aW1lcl93cml0ZSINCj4gPiAgICAg
IGNhbGxiYWNrIGZ1bmN0aW9ucyBhbmQgImFzcGVlZF8yNzAwX3RpbWVyX29wcyIgbWVtb3J5DQo+
ID4gICAgICByZWdpb24gb3BlcmF0aW9uIGZvciBBU1QyNzAwLg0KPiA+ICAgICAgSW50cm9kdWNl
IGEgbmV3IGFzdDI3MDAgY2xhc3MgdG8gc3VwcG9ydCBBU1QyNzAwLg0KPiA+DQo+ID4gdjI6DQo+
ID4gICAgUmVmYWN0b3IgVGltZXIgQ2FsbGJhY2tzIGZvciBTb0MtU3BlY2lmaWMgSW1wbGVtZW50
YXRpb25zDQo+ID4NCj4gPiBKYW1pbiBMaW4gKDMpOg0KPiA+ICAgIGh3L3RpbWVyL2FzcGVlZDog
UmVmYWN0b3IgVGltZXIgQ2FsbGJhY2tzIGZvciBTb0MtU3BlY2lmaWMNCj4gPiAgICAgIEltcGxl
bWVudGF0aW9ucw0KPiA+ICAgIGh3L3RpbWVyL2FzcGVlZDogQWRkIEFTVDI3MDAgU3VwcG9ydA0K
PiA+ICAgIGFzcGVlZC9zb2M6IFN1cHBvcnQgVGltZXIgZm9yIEFTVDI3MDANCj4gPg0KPiA+ICAg
aHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICB8ICAxNyArKysNCj4gPiAgIGh3L3RpbWVy
L2FzcGVlZF90aW1lci5jICAgICAgICAgfCAyNjMNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0NCj4gPiAgIGh3L3RpbWVyL3RyYWNlLWV2ZW50cyAgICAgICAgICAgfCAgIDIgKy0N
Cj4gPiAgIGluY2x1ZGUvaHcvdGltZXIvYXNwZWVkX3RpbWVyLmggfCAgIDEgKw0KPiA+ICAgNCBm
aWxlcyBjaGFuZ2VkLCAyNjcgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4g
DQo+IA0KPiBBcHBsaWVkIHRvIGFzcGVlZC1uZXh0Lg0KPiANCj4gVGhhbmtzLA0KPiANCg0KU29y
cnksIEkgZG8gbm90IHNlZSB0aGlzIGNvbW1lbnQgaW4gdGhlIGZvbGxvd2luZyBsaW5rcywgdG9v
Lg0KRG8gSSBsb3N0IGFueXRoaW5nPyANCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L3FlbXUtZGV2ZWwvbGlzdC8gDQpodHRwczovL3BhdGNoZXcub3JnL1FFTVUvIA0KaHR0
cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9xZW11LWRldmVsQG5vbmdudS5vcmcvbWFpbDUuaHRt
bCANCg0KVGhhbmtzLUphbWluDQoNCj4gQy4NCj4gDQoNCg==

