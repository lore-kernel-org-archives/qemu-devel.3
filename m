Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66B2F531E8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 02:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCTqc-0003Mk-3W; Mon, 13 Apr 2026 22:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCTqZ-0003MQ-VK; Mon, 13 Apr 2026 22:49:51 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCTqX-0002sA-5x; Mon, 13 Apr 2026 22:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxotSOxjgcoLYpUp0rM/BeTTsvx7j3cbGloZchz1gRzSF7KR/dgIKZ8upZdaEAiw5GyPewP88Tl7A/kuAOUGeLosgtlPqtcMK7UkGWWA1U9bNDh/EPC7NU2EVFezhsWJFJdgp8vCFtc05y/68nsOIWRolNR+RCd8lmCUbyhgOgfhjsmgTWpJmcSk2AkgpiBCsdH/o4X66nsK/tqdVVEIqn5BFrTf3D8XotjOtMN7nzBArH+TyT358+QjXbr5VgxBK9RJfFSij4vwaahlklLgzz1BbJHJlpLU6OCA/pq2Qfu6GYTluKINGbhElSIp5wVBjEsXvIMM7bwhkiUyiRRHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr5zFxD6zikmSl17s3WQR/2RawVKp27EniYsqxr07So=;
 b=LJX6xPPfSJH6sIjBV3cjzpnuT/zprKny2jfZw1bFB3+UvocQJvizgHaayHFVdPgrowX9gJ4QdJXG47VVqwpC7Lz9XBZ+qp27MjBzMUvZgsSk+8H3uGMWFF7KQhrOMae4vPjf6OqyqYcrWI+umfgr7peeb1+pq37P/rnPoZiCU91MQ/ZSJwJBNCllP62cqGvKS8yC/QrN8gUw5T8L6YqdEvRuDpAic8cADgBmf/tDg9+spKbjNFE6EigCWMuZlwqGODEeEmw/vNk6b1+avxhIwhqwDMmvTaNqttcnBxtYVJ7Jyb9LlqhipRkcYsW9/dmuEU6oAasPpjZAk9ovE3DmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr5zFxD6zikmSl17s3WQR/2RawVKp27EniYsqxr07So=;
 b=CqQsJgX3k8x6rBuTUjJpWPsF4JD5JmoNu+0c5QCynUVK1gG+1DNq4dMbwiCHXyj7hkyM5odOL2zCYJOAc9naE+WnaV5Xc+3vT8/4/MvuHe1MIP7YUamoNBp/ekazaBNlZxPnHZuQTbrEqoLiTBiPRgrkaWDX7GrCkvqoUdKSjsU+UU7yRYgs4/v8GuVGE2DJiwdM+jcJNyV6+51DIMA2WCI8ar0yPCjDcvOGwAggSDhrABb56beqEG9X021xEK91T0JbmENydgD7ojM201v1tw1vBlGiIrZ/2mvF0AKHI7t6/ZlEJc0xNXw3wyeF0/nigFd5V82jaFHdKXAsksKxzg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Tue, 14 Apr
 2026 02:49:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 02:49:38 +0000
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
Thread-Index: AQHcsShdtlTDceAZ10KDqmxaDHilIbXcGYUAgAHwW0A=
Date: Tue, 14 Apr 2026 02:49:37 +0000
Message-ID: <TYPPR06MB8206F995851E9CAC13928361FC252@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-8-jamin_lin@aspeedtech.com>
 <b143a786-751e-4d19-b27f-40449aba52a7@linaro.org>
In-Reply-To: <b143a786-751e-4d19-b27f-40449aba52a7@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5134:EE_
x-ms-office365-filtering-correlation-id: e795391d-9ae0-4fec-b063-08de99d07813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: RqZbh6FmHsUY5/r9jdfINN/w6PWzQJl8nnm76mANLQEyFKBeMzyTaz0ye5hzCtjhqbi+irCr9NM7AqwaO3Nkra99OLCJmvM0M4/hdQppGlR3EOJEykyOdppwd+z4Z91Eg9QiAJpxrlo6yjcKA4lpRWLKkAFtY7NpuPgoaIFP+RjoYWXlyJRo7r6xGq1BEsUlcynMh+jhzEkXzWlRDktqeSOMJg+yg45aLTFh6yMcyMecSrDf+nL7OM5XgPCu1KHL52Ot7LzVGoIKvXjt1HdLE/yEn/Oq/yvYHW3UDW0BtN/W5911BTERzZGGF0QDHSt1ipb/1IbJkMRbIvXhC77OvFyVA66bXc9AKCs76tCalvYhPQNHFsdA5+KyHL9CpPm3YpjoPe9D8nlmCoB680N8Xg12hsLPD6cXiPPQ+BOd3r5VhmI82BN7mRPGQ7vJbvoht4UioMm1R4zcBqHFBmkawAR+4OtxRdMczXvpRH/q8mqJtD2OMo1AJ9YSrwngYBbWfcgjJ+BVJfhRrMf7bDCAVaiy4684M329maojbnv9AAgxY79YF2JusCnvEi369oShYF6POBrMHdIwbH1V+W8A4tRx1eCo/oOCqiWBqnlOjj05hMVXoxc/Vw2vEgTmgDsQpzqCnL7TXmP03Jq6jZiSBFFMpQ9wlKjuNPfow67DKUlxIKgGCWkfOKW9NwngPCMCQwmoOnejGuGpbQuecXfNAUkRI3yRdo36odBfkLTWu1iFv2vrCoIJieXddTt31EsEfTmzVHMR3fngOLhUQdCeErHK8c5TsPRlX8i58nZ4rdw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2hpM3FobTVKNEJFbjU3cm5rMURkcnlBWXZyL0hmUVEwdWNCdVl1bHJmWU80?=
 =?utf-8?B?MXhwRWpHWkQwWUJNRGV3eWpicmVaclFMalFVeFNoWHlpVXNRcnBCYi9scW9Y?=
 =?utf-8?B?VXltK00vUWNtWURVT0xqN0ZrZXNwY2ZnQ2d4eENFL3BuMFJORVZFL0FXai9u?=
 =?utf-8?B?eWJ1UVJoQ3czNitHRnQ4ZVVLWEphdlJmQkEzWE84RElQUUppaGh0OU50a2J2?=
 =?utf-8?B?TGFjenFwanJyc1BrZlJwdzUzVG9Sc0JoS0l2SmZrczNkbW5sVG9vRmE4dFdQ?=
 =?utf-8?B?Z2JwRXI3bVI5WVcxOC9KdEVBLzhFbGQya0xqNDdrWVphY0xDaG5TaFFOQ2tq?=
 =?utf-8?B?M0hIdmVrU0d2TnE4Y2srMDBqbHh2a1VoTnZabUtwalordFE5QVU0MldRejV5?=
 =?utf-8?B?SnFUaTloMXVlcm4vRkp0Y2QrQkg0K2Q4U1oydlYxbzJKOWF6aGV2NkozT25O?=
 =?utf-8?B?T2FCTGZlN0dzLy81ZDZKQy9pTll5VkxFWndhVzNxSTRQamNoVktxa05CU2xO?=
 =?utf-8?B?K0FLVEdiRTB2TC9Ia2ttL0hiQndKTTc5VkFHZmZtYTFzUVY3K2ZPRWtpMTZp?=
 =?utf-8?B?eVRHcUR3Nk1VVkZvYktQWE16TnhCZEhiQTNDckMvTVg4WUcvY0xOTnVTOFdp?=
 =?utf-8?B?dEIvUmNRZEFKMDJzaS9CZmY2NHM2VEpoQkZkT3ErcUhqSzZablVtZDJubEFp?=
 =?utf-8?B?RXJjSDIrUVl3TzNwMVJWMWRrZFBnaFZUdmNnODNOWXpzSzZLMUZGZHlOMXF3?=
 =?utf-8?B?am4xN1dQeEdtWHNRNWx5RkxGenIrY29STktoY3dqeHA3eXk3d05HSHZkaGc4?=
 =?utf-8?B?aVRkSEMzWmZiN0hTbjlWTE9hWm8vcm5YOEZvYTBvSXBNOTJRVUFwS3ZFWlI0?=
 =?utf-8?B?V092ZVdqSFRJQ0ZQc0VLQnM5UHFIZVhZeHlSV2UyQVRSVnlmamp2dmxpNXpt?=
 =?utf-8?B?UkI0QSs0RHlUanU2TjBXckN0ZDBxMk01eVY1VXpnODZoR2VTVW5JdGR6ZGlB?=
 =?utf-8?B?bHFsLytJWWlweC9sM1dYSUVrdFpJSFJJNEhzK2NZcHEvVnl6Z09URFUzS0s2?=
 =?utf-8?B?VE11RTBrVnNxZXF6MWlmNVFoWWI0bFkxOHBvNjNWUHJGdzMzaTFhWWtmQkd4?=
 =?utf-8?B?NkNpUmprZmJmdENOOGJnV25nL2NpTCszZHRkZGN2eS9EckhzSCsweXFna2VK?=
 =?utf-8?B?NzkzUDlDWERCNVduSTl2VUNlVUV5b0EwVEovSTRsbmU2YnhSZ0hVV0JITGxV?=
 =?utf-8?B?aGhNaHJCYnVoUDlVa1Y1SjBkMTBKVHJuTm40OFlJWGpkeFVGTVh6RDBaRkZx?=
 =?utf-8?B?NWdDQjB1N2c3VGprYjJNNlpRRUdFRXowQ09WMVJOdjBIUkRUeDJPTC8xVGxi?=
 =?utf-8?B?OHFqSWcrRUNLWUdxU0pTcUtGRmlJOHA5TjFhUUpGaElxZkF5b3JuOElja0tw?=
 =?utf-8?B?V2ZDMkhEeEVkUCtVdnNHQlNXdXZhS2hwbG50SjFGZitlZ0lwQWRqeHhnbXZE?=
 =?utf-8?B?ZGh0Rml0TnA0MlpKdi9zR2ptWlhBclNjRVFuYUcxWVhWOFRiQUxHMDNTZ0l0?=
 =?utf-8?B?dzVXbXRlNVZ2Z3VlMlZwamZIL1RVQkFENDhmbUZkSmJVWkVzWFh2bk1IVUc4?=
 =?utf-8?B?N2lQczZLTUtkSTRuQnNCVUlEeVRNUjBOTUYwUTI2R1ByK3M3cEF5R3VFclpU?=
 =?utf-8?B?bGhUSFpKZWtGTCtyZFRvTzVFdlA4MmVZbWhSMFZ0dUZnYkh0TE0yYWdGbnMx?=
 =?utf-8?B?L0NmV2lEdktJYUZhOHpSUTVNVWJha1RkYkhPU2dXS0xpSzdCNlByb1VrTEZV?=
 =?utf-8?B?OHRqNU1rNXhJZ2U0K2QxTks5a3hDUHp4OFlpOFhWenVqNTNGYmxDbmNqYUNr?=
 =?utf-8?B?OHdEWE5nT3pMMkdKRGIyN0pRdDBidHZsblhGaXBSTzdBOFgxMnY1QVI4NnhJ?=
 =?utf-8?B?WkFUVHJONmQzbmVKQ3d3K3NnNFNPVURJOXVOR3ZiSmNkTnNPRWZuQVR2Kzgz?=
 =?utf-8?B?MUYyRVN6aDF0TFdtRVFybU81dm0rSWNBYm50dlF3NXdHZ21OaGpnc0pISFpN?=
 =?utf-8?B?WW90MFFieTlzNHlWd3RyWk4yZmxxWlg4cDIyR0V0ZEhIN3BFampYQkF0TFhm?=
 =?utf-8?B?SE9FQ3Z0cU5mK2lUNXJFVThHOTErbGhhb2ZZTTdXaFhob2dzRHhRK25ON2VV?=
 =?utf-8?B?R0F4RW40aUJIYmxMTXhjSnpwNHFlM2R3Q2EyR2RTdVREbWRUOW9zR2ZKL0Qx?=
 =?utf-8?B?L1FhZWU5czJ4QkNEZC9oMnVZS24zN0ZLNVA4TXRmVTFpZnVuMm5qd2pMZ0Vl?=
 =?utf-8?B?OFRILzZYRlAxWVdiYlRFOWNJMGF0My9Vc0NxRTBsRy93a2hTelJ3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JOl11+hXkrlvOCPOKDGLgSwieg8w51q38HMsJHJkRaMBY7n6XX/0fabpc8aMMx9F5XmPkH2uMYhP9Hir1Q9o7acCWh3LnRX+E/N3LvctRXKVekLYpLfsyB9Pv4fMBI4bsE0ygQ0LkxTVsS4RIqFxNzY/RQ+WQfJAJMLqwDQjiUgO2OUQEuIbS6TrCbzVMgVX9vyO2W0W3VfKXrIApjbjB8h71j0kwUK82ox+p2LiCQegKcLQFimKlQytaTv03YISMwEEavhZIQ0IjiZ3c/9rleYjp7syJDwJLQIx5U7Av5TeQcTcP5Dn6LeO9Nb4Y+wByA9uOa3FCxcHcu0oKnVnTg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e795391d-9ae0-4fec-b063-08de99d07813
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 02:49:37.9723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkKEQ4t6FXaECV/+qaZknSR+AMGUwe/DUx4shwFHklJ5o/O98d+e2EVuML422OgK/7gkLKo1QdcF0WUyUOvuFQ9KYfYsdFois+msx8t74Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5134
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

SGkgUGhpbGlwcGUNCg0KPiANCj4gT24gMTEvMy8yNiAwODoyNiwgSmFtaW4gTGluIHdyb3RlOg0K
PiA+IEVIQ0kgc3VwcG9ydHMgNjQtYml0IGNvbnRyb2wgZGF0YSBzdHJ1Y3R1cmUgYWRkcmVzc2lu
ZyB3aGVuIHRoZSA2NC1iaXQNCj4gPiBBZGRyZXNzaW5nIENhcGFiaWxpdHkgYml0IGluIEhDQ1BB
UkFNUyBpcyBzZXQuIEluIHRoYXQgbW9kZSwgdGhlDQo+ID4gQ1RSTERTU0VHTUVOVCByZWdpc3Rl
ciBzdXBwbGllcyB0aGUgdXBwZXIgMzIgYml0cyB3aGljaCBhcmUNCj4gPiBjb25jYXRlbmF0ZWQg
d2l0aCAzMi1iaXQgbGluayBwb2ludGVyIGZpZWxkcyB0byBmb3JtIGZ1bGwgNjQtYml0DQo+ID4g
ZGVzY3JpcHRvciBhZGRyZXNzZXMgKEVIQ0kgMS4wLCBzZWN0aW9uIDIuMy41IGFuZCBBcHBlbmRp
eCBCKS4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGFzc3VtZXMgMzItYml0
IFFIIGRlc2NyaXB0b3IgYWRkcmVzc2VzIGFuZA0KPiA+IGRpcmVjdGx5IHVzZXMgbGluayBwb2lu
dGVyIHZhbHVlcyB3aXRob3V0IGFwcGx5aW5nIHRoZSBDVFJMRFNTRUdNRU5UDQo+ID4gdXBwZXIg
ZHdvcmQuDQo+ID4NCj4gPiBJbnRyb2R1Y2UgYSBoZWxwZXIsIGVoY2lfZ2V0X2Rlc2NfYWRkcigp
LCB0byBjb25zdHJ1Y3QgZnVsbCA2NC1iaXQNCj4gPiBkZXNjcmlwdG9yIGFkZHJlc3NlcyB3aGVu
IDY0LWJpdCBjYXBhYmlsaXR5IGlzIGVuYWJsZWQuIFVwZGF0ZSBRSA0KPiA+IHRyYXZlcnNhbCBw
YXRocyAoYXN5bmMgbGlzdCB3YWxrLCBob3Jpem9udGFsIFFIIGxpbmssIGFuZCBwZXJpb2RpYw0K
PiA+IHNjaGVkdWxlIGVudHJ5IGhhbmRsaW5nKSB0byB1c2UgdGhlIHRyYW5zbGF0ZWQgNjQtYml0
IGFkZHJlc3Nlcy4NCj4gPg0KPiA+IEFsc28gYWRkIGJ1ZnB0cl9oaVs1XSB0byBFSENJcWggdG8g
c3VwcG9ydCA2NC1iaXQgYnVmZmVyIHBvaW50ZXINCj4gPiBmaWVsZHMgYXMgZGVmaW5lZCBpbiBB
cHBlbmRpeCBCLg0KPiANCj4gYnVmcHRyX2hpW10gaXMgbm90IHVzZWQgaW4gdGhpcyBwYXRjaCAo
YnV0IHRoZSBmb2xsb3dpbmcpLCBob3dldmVyIEkgd29uZGVyIHdoeQ0KPiBub3QgY29udmVydCB0
byA2NC1iaXQ6DQo+IA0KPiAtICAgIHVpbnQzMl90IGJ1ZnB0cls1XTsgICAgICAgICAgICAgICAv
KiBTdGFuZGFyZCBidWZmZXIgcG9pbnRlciAqLw0KPiArICAgIHVpbnQ2NF90IGJ1ZnB0cls1XTsg
ICAgICAgICAgICAgICAvKiBTdGFuZGFyZCBidWZmZXIgcG9pbnRlciAqLw0KPiANCj4gYWRhcHRp
bmcgdGhlIGN1cnJlbnQgMzItYml0IHBhdGggYW5kIGV4dGVuZGluZyA2NC1iaXQgaW4gdGhlIG5l
eHQgcGF0Y2guDQo+IA0KDQpXZSBjYW5ub3Qgc2ltcGx5IGNvbnZlcnQ6DQoNCnVpbnQzMl90IGJ1
ZnB0cls1XTsNCg0KdG86DQoNCnVpbnQ2NF90IGJ1ZnB0cls1XTsNCg0KYmVjYXVzZSB0aGlzIGRv
ZXMgbm90IG1hdGNoIHRoZSBFSENJIHNwZWNpZmljYXRpb24gZm9yIDY0LWJpdCBkYXRhIHN0cnVj
dHVyZXMuDQoNCkFjY29yZGluZyB0byBFSENJIFNwZWNpZmljYXRpb24gMS4wLCBBcHBlbmRpeCBC
ICg2NC1iaXQgRGF0YSBTdHJ1Y3R1cmVzKSwgYnVmZmVyIHBvaW50ZXJzIGFyZSBub3QgZGVmaW5l
ZCBhcyBhIGNvbnRpZ3VvdXMgNjQtYml0IGZpZWxkLiANCkluc3RlYWQsIHRoZXkgYXJlIGV4cGxp
Y2l0bHkgc3BsaXQgaW50byB0d28gc2VwYXJhdGUgcmVnaW9uczoNCg0KVGhlIDY0LWJpdCBhZGRy
ZXNzIGlzIG5vdCBzdG9yZWQgYXMgYSBzaW5nbGUgY29udGludW91cyA2NC1iaXQgdmFsdWUsIGJ1
dCBhcyB0d28gaW5kZXBlbmRlbnQgMzItYml0IGZpZWxkcyBsb2NhdGVkIGF0IGRpZmZlcmVudCBv
ZmZzZXRzIGluIHRoZSBkZXNjcmlwdG9yLg0KDQpUaGVyZWZvcmUsIGNoYW5naW5nOg0KdWludDMy
X3QgYnVmcHRyWzVdOw0KDQp0bzoNCg0KdWludDY0X3QgYnVmcHRyWzVdOw0KDQp3b3VsZCBpbmNv
cnJlY3RseSBhc3N1bWUgdGhhdDoNCg0KbG93ZXIgMzIgYml0cyBhbmQgdXBwZXIgMzIgYml0cyBh
cmUgY29udGlndW91cyBpbiBtZW1vcnkNCmFuZCBjYW4gYmUgYWNjZXNzZWQgYXMgYSBzaW5nbGUg
NjQtYml0IHZhbHVlIHdoaWNoIGlzIG5vdCBjb21wbGlhbnQgd2l0aCB0aGUgRUhDSSBzcGVjaWZp
Y2F0aW9uIGxheW91dC4NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiA+DQo+ID4gV2hlbiA2NC1iaXQg
Y2FwYWJpbGl0eSBpcyBkaXNhYmxlZCwgZGVzY3JpcHRvciBhZGRyZXNzZXMgcmVtYWluIDMyLWJp
dA0KPiA+IGFuZCBleGlzdGluZyBiZWhhdmlvdXIgaXMgdW5jaGFuZ2VkLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gICBody91c2IvaGNkLWVoY2kuaCB8ICAxICsNCj4gPiAgIGh3L3VzYi9oY2QtZWhjaS5j
IHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QtZWhjaS5oIGIvaHcvdXNiL2hjZC1laGNpLmgg
aW5kZXgNCj4gPiA3ZGM2ZDE1MWNjLi5mMTgxNTBjMzUyIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3Vz
Yi9oY2QtZWhjaS5oDQo+ID4gKysrIGIvaHcvdXNiL2hjZC1laGNpLmgNCj4gPiBAQCAtMjA0LDYg
KzIwNCw3IEBAIHR5cGVkZWYgc3RydWN0IEVIQ0lxaCB7DQo+ID4gICAjZGVmaW5lIEJVRlBUUl9G
UkFNRVRBR19NQVNLICAgICAgICAgIDB4MDAwMDAwMWYNCj4gPiAgICNkZWZpbmUgQlVGUFRSX1NC
WVRFU19NQVNLICAgICAgICAgICAgMHgwMDAwMGZlMA0KPiA+ICAgI2RlZmluZSBCVUZQVFJfU0JZ
VEVTX1NIICAgICAgICAgICAgICA1DQo+ID4gKyAgICB1aW50MzJfdCBidWZwdHJfaGlbNV07DQo+
ID4gICB9IEVIQ0lxaDsNCj4gPg0KPiA+ICAgLyoNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hj
ZC1laGNpLmMgYi9ody91c2IvaGNkLWVoY2kuYyBpbmRleA0KPiA+IGQ3YTA5MTdjYWYuLjhmZDNm
ZDYwYzQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdXNiL2hjZC1laGNpLmMNCj4gPiArKysgYi9ody91
c2IvaGNkLWVoY2kuYw0KPiA+IEBAIC0xNDYsNiArMTQ2LDE4IEBAIHN0YXRpYyBjb25zdCBjaGFy
ICphZGRyMnN0cihod2FkZHIgYWRkcikNCj4gPiAgICAgICByZXR1cm4gbnIyc3RyKGVoY2lfbW1p
b19uYW1lcywgQVJSQVlfU0laRShlaGNpX21taW9fbmFtZXMpLA0KPiBhZGRyKTsNCj4gPiAgIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgdWludDY0X3QgZWhjaV9nZXRfZGVzY19hZGRyKEVIQ0lTdGF0ZSAq
cywgdWludDMyX3QgbG93KSB7DQo+ID4gKyAgICB1aW50NjRfdCBhZGRyOw0KPiA+ICsNCj4gPiAr
ICAgIGFkZHIgPSAodWludDY0X3QpbG93Ow0KPiANCj4gTm90IG5lZWQgZm9yIDMyLWJpdCBAbG93
LCB0YWtlIGEgdWludDY0X3QgYWRkciBhcmd1bWVudC4NCj4gDQo+ID4gKyAgICBpZiAocy0+Y2Fw
c182NGJpdF9hZGRyKSB7DQo+ID4gKyAgICAgICAgYWRkciB8PSAodWludDY0X3Qpcy0+Y3RybGRz
c2VnbWVudCA8PCAzMjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICByZXR1cm4gYWRkcjsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGVoY2lfdHJhY2VfdXNic3RzKHVpbnQz
Ml90IG1hc2ssIGludCBzdGF0ZSkNCj4gPiAgIHsNCj4gPiAgICAgICAvKiBpbnRlcnJ1cHRzICov
DQo+ID4gQEAgLTQzOCw4ICs0NTAsOSBAQCBzdGF0aWMgYm9vbCBlaGNpX3ZlcmlmeV9xaChFSENJ
UXVldWUgKnEsIEVIQ0lxaA0KPiAqcWgpDQo+ID4gICAgICAgICAgIChlbmRwICAgICE9IGdldF9m
aWVsZChxLT5xaC5lcGNoYXIsIFFIX0VQQ0hBUl9FUCkpIHx8DQo+ID4gICAgICAgICAgIChxaC0+
Y3VycmVudF9xdGQgIT0gcS0+cWguY3VycmVudF9xdGQpIHx8DQo+ID4gICAgICAgICAgIChxLT5h
c3luYyAmJiBxaC0+bmV4dF9xdGQgIT0gcS0+cWgubmV4dF9xdGQpIHx8DQo+ID4gKyAgICAgICAg
LyogMSBhbHRuZXh0X3F0ZCArIDEgdG9rZW4gKyA1IGJ1ZnB0ciArIDUgYnVmcHRyX2hpICovDQo+
ID4gICAgICAgICAgIChtZW1jbXAoJnFoLT5hbHRuZXh0X3F0ZCwgJnEtPnFoLmFsdG5leHRfcXRk
LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA3ICogc2l6ZW9mKHVpbnQz
Ml90KSkgIT0gMCkgfHwNCj4gPiArICAgICAgICAgICAgICAgIDEyICogc2l6ZW9mKHVpbnQzMl90
KSkgIT0gMCkgfHwNCj4gPiAgICAgICAgICAgKHEtPmRldiAhPSBOVUxMICYmIHEtPmRldi0+YWRk
ciAhPSBkZXZhZGRyKSkgew0KPiA+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAg
fSBlbHNlIHsNCj4gPiBAQCAtMTUzNCw3ICsxNTQ3LDkgQEAgc3RhdGljIGludCBlaGNpX3N0YXRl
X3dhaXRsaXN0aGVhZChFSENJU3RhdGUgKmVoY2ksDQo+IGludCBhc3luYykNCj4gPiAgICAgICBF
SENJcWggcWg7DQo+ID4gICAgICAgaW50IGkgPSAwOw0KPiA+ICAgICAgIGludCBhZ2FpbiA9IDA7
DQo+ID4gLSAgICB1aW50NjRfdCBlbnRyeSA9IGVoY2ktPmFzeW5jbGlzdGFkZHI7DQo+ID4gKyAg
ICB1aW50NjRfdCBlbnRyeSA9IDA7DQo+ID4gKw0KPiA+ICsgICAgZW50cnkgPSBlaGNpX2dldF9k
ZXNjX2FkZHIoZWhjaSwgZWhjaS0+YXN5bmNsaXN0YWRkcik7DQo+IA0KPiAoZm9yIGV4YW1wbGUs
IEBhc3luY2xpc3RhZGRyIGlzIDY0LWJpdCkuDQo+IA0KPiA+DQo+ID4gICAgICAgLyogc2V0IHJl
Y2xhbWF0aW9uIGZsYWcgYXQgc3RhcnQgZXZlbnQgKDQuOC42KSAqLw0KPiA+ICAgICAgIGlmIChh
c3luYykgew0KPiA+IEBAIC0xNTYyLDggKzE1NzcsOCBAQCBzdGF0aWMgaW50IGVoY2lfc3RhdGVf
d2FpdGxpc3RoZWFkKEVIQ0lTdGF0ZSAqZWhjaSwNCj4gaW50IGFzeW5jKQ0KPiA+ICAgICAgICAg
ICAgICAgZ290byBvdXQ7DQo+ID4gICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgIGVudHJ5
ID0gcWgubmV4dDsNCj4gPiAtICAgICAgICBpZiAoZW50cnkgPT0gZWhjaS0+YXN5bmNsaXN0YWRk
cikgew0KPiA+ICsgICAgICAgIGVudHJ5ID0gZWhjaV9nZXRfZGVzY19hZGRyKGVoY2ksIHFoLm5l
eHQpOw0KPiA+ICsgICAgICAgIGlmIChlbnRyeSA9PSBlaGNpX2dldF9kZXNjX2FkZHIoZWhjaSwg
ZWhjaS0+YXN5bmNsaXN0YWRkcikpIHsNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAg
ICAgICAgICB9DQo+ID4gICAgICAgfQ0K

