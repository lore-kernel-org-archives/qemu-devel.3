Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D3C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXTw-0003FB-Kh; Fri, 03 Jul 2026 02:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXTu-00039r-BK; Fri, 03 Jul 2026 02:34:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXTs-00011Q-Gb; Fri, 03 Jul 2026 02:34:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEn97CAwvR/1QYPJGIDGEGipI5Tb0tKnXjR7QahWUW6k0Xxe2hQ+mi7XIYJSY1yiJP8iizavp3PwSVJ1KDgx50bJngxhDsaS+Ey0x1Yfi7KjRQgtRQEKskULIzNKLAtq6P+TFTb8JN8QAD5bAM3e/AOwdWFdzzDEVMqr1gumSTBafF1jlTTOUsGHcLGqhNVPcIFgF9RCMMwW7MjTJ4uS9+1UguR8K0Y+KScq9j+tAB5hG7XnwBtAoeU/znhLkf+3jRcp4M0oFCNhlJmXw+GWFEjAt+Ec0ShNniFCDMfiLn62XCuwE/dGzsOe6c/98gHTjRlmLvanJ6ESPOhU87bVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3cO3ruHeSX4eUQFcXdA2y7sPqbweli9i+wZutJW17M=;
 b=Kad+9NyCkJXs26eCQ/UrwtXEf+oehSKFIXnaCbZsXUswqNKaiEY0j+o1T5O6pjlkSUAFRYkHO8iD5LReyxCQ2DNGrF+XGvz5AowGZEQA3FxsDhzADp724DMhA5iXWDq517uVgykZYvVaSmSUuWLUN3VBw+m28pes+FAOwKNDZ6fg67M7HRH1uyCgm0ug6YtBcTq79jX+2nrjbDpAfCwRek8fkN4NQKK0JIyN+Qx4IpcIB161L+oDRQZiZQ7zTNK79NTIW3KZy64zyS+l3/2XnVbRQXN0PbWKCynmyPsku3k6dHm//kVhNLJmNA4+dzZ4wq/hBVpch4JtsNhi+bHbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3cO3ruHeSX4eUQFcXdA2y7sPqbweli9i+wZutJW17M=;
 b=LEXwjc0hSNL5lVZ6isFeEabXQ01gXqaWR7Mm9LwS1MgB2ao5AMnCNOL5ml4J2cQmqUOwYZ4ICYuc+PgwTsPA7tfZ4FYijlz14jt06Zn5iEj4WC9vVuYhvawFgzWQtAGae2yi//VLQI4Xpq+mgnjubWaKguN2oLjtI0P2Sf5ip+huESBkNhY81rUqtYMcrfS+siz9QdbKs/N2sN+Mc3Pn70mICb+NKYPqwojg2Ttw+FTGIJn9nby3FOMvzbYZQqORSd5gBd51+6P0Q2mtEw7LU647kdQheP5fo/BQDwqkt7+szRGapxmKhCrq3czdyPigkhl6uV7iKkivjiVHiUc8yQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5819.apcprd06.prod.outlook.com (2603:1096:301:f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:34:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:34:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v4 13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Index: AQHczhpSJ7PHzbamVUeV/l4HBmQxvrYqOXgAgDGWPgA=
Date: Fri, 3 Jul 2026 06:34:25 +0000
Message-ID: <TYZPR06MB4980808AFEE6D38B1D1B21D6FCF42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-14-jamin_lin@aspeedtech.com>
 <45daca50-47c6-4cc8-846a-582cede995cc@kaod.org>
In-Reply-To: <45daca50-47c6-4cc8-846a-582cede995cc@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5819:EE_
x-ms-office365-filtering-correlation-id: 8b581ade-83b5-4ec2-5c74-08ded8cd204c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|56012099006|4143699003|921020;
x-microsoft-antispam-message-info: LZkTIilfw7vuVj3gIWMiAkyqGywHf0kFoB+rOfqaYY1PJbBp5Jszi7/IErMuxoZx9WJOQev2zTkD5HfFJNFISBxx2m+YT04AW7WXViUfK0VcLNeCQ3okp5H3UikWELCV0hBo7/JPL77ZDwNn1XdTlNsjoyQB7RuQVO8NBE9xFS603R1lNW3Ld+yMnUhwG7TQJORwnqsxpwzB/8Blox7QIM8wLcIwpd6/pbDLCHmAcbFH1mCEsDEztei1SwOBBGqW9RPjOF3AFZP6V3C55j1+KDiSkWG9/k+WU+Y5FBlkvZWEflvuhCQlXUhh7h/I3Ld17Qd0IO/DToVS4t3XExhQcEoM3K3xBsQq890AOcAI9QNKNvVa9ttcmYMKGYhLpxXnjeJuXu2Ee7babPIugiDNAcRclp5ZYsfOG1v02Qldzg7viYexniQFHSp71WGz+7+CFvDD+Y4XIEmpV7bGra4Hs8zcBOAq41rQJWmQc3BRIn5TG+4UUDXcVyH/N+IdKFt6a7edlAuULPGVbzlL7v2amf5FJFsHEv8idG3JD33sdl4UD0Vyvb23l3x2IHQRx0kS4D2cIPSsRaJyJ9NUmxb+H2QaCn69tHH2G6476TpwpTirO3DJOYZjC9ambVL6mGt51tMvuRS8EQWyBGnphaPxZ7wSZvOmXNSg7SUE3nCcDD5iv67W7LgSSFcchmyS2g6dAr39VIHBo0Dor06Zeru4SEva7flxL+X6Owgr4n/mkjkhVFszbeb/EGn2ORObazoK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXQ0VUI3d0RiRDFGZkU1L3Y3c0FvcVV0UUd4OFoxNmR1UFplMG5QZ3Z1MGFa?=
 =?utf-8?B?VjN3R0JDVHRuZkwyMVVJdmprc3NMRkxyMGZrTHo1STB5ZXl6ZGFURlIwRmNX?=
 =?utf-8?B?eUhENmE0MUhqM3c4dC8rMDk2MWk5YjFLZ3owOXBiMFk4dGZqalNaMkhJTC84?=
 =?utf-8?B?WEJWRDJmcnVieEZxSW9xcDhldW10anQ0dnRRa0d4MHlsMXRFa1VGQmxtSTNP?=
 =?utf-8?B?enZsM0tYcitEVC9BTVhyd3JOS0x1TkxiVk5pMWtlbVFTMUczZ2s1TEl3SnYw?=
 =?utf-8?B?VkdPVG1vRFVDVXFGMjJaTUFDRVV2eWNJdTM4TURUTlZ3aHN5SlF5blNFMEtF?=
 =?utf-8?B?MGc4ZTZRRHpzUGJsQ0FHVW4vTzBsZ05pZGNUbUxXVzdScC8rQkdZbFFVdzBa?=
 =?utf-8?B?R2EyTUg3RlZpWldDZytaNW1FV1BLSitmN285TUIrTWZxOCtKQis2djErRjgx?=
 =?utf-8?B?ZTZMbG1kVHZ6WVFIbU51alcxdTFyRmdPU00wR3g1RGs1RU1zcnRyc0hXVStU?=
 =?utf-8?B?TjZwK3BEZ0xiOC9kMUJObUJSYUt3WmtXeC94REZwa3E0b1c3cXpsMlQ2cUhE?=
 =?utf-8?B?enRKMUhyZm9KSmNjOVI4NHczdmdqT25ReUdrYmpnakJkY1B2VXVDcTYrMStW?=
 =?utf-8?B?UGpDYVZ4QnNPVG5hNzZzemJ6OG5NZDc2ZnkyZFVHSHRXOUUwZUpNWStWMlhC?=
 =?utf-8?B?dUNSRHZneHRrUmZ1eWwyTFQ3SkJyUUFqVFN3ZWtzMVdGNFdQeVNEYzNEaDZ4?=
 =?utf-8?B?TjlteVVseHlic0hMUVNFU0NnUmFDS05UY0NNUThTY29RdElxWk9pNnZEQTR0?=
 =?utf-8?B?Tm9uMmVwQzlOeUd6MWFFS3BlTUFwbWcxQ1Ixc3pLWlBBK3Y2KzllWXhyQ2ZT?=
 =?utf-8?B?THdBZUw5bTFlZHo1OFBUcXNNWHllL3ZFZHdUSjJZcjVTdi9SZG0vMVJ3a0cv?=
 =?utf-8?B?QVVXS3piNlRWamt4TXhXcEl2T0VwTmdMNG9Nc0RHS29FTmpMbFJFMFY4MmVr?=
 =?utf-8?B?cENXaVVYRUY3MTV0QTBncWJKSFJCcklnSGxNVlArTjlJM2xOajkyZHUyN1Zh?=
 =?utf-8?B?MlVORFM3dUFmS01xK1oxcWZjbC96MTYvSi9hK3ZudUpiZFZlb3dySEIra0g0?=
 =?utf-8?B?WEFLbS9iZm5FMjYyazU1VVg4ejV1ZmcxNWp0UFZHN2NTNnVnZmw4T0cwUXFS?=
 =?utf-8?B?bW91MkI0UzlyWTlOdEJNdmJKUUdaeTZWdHFxMHBJbTd6T3VzL2lPTDJuWVhV?=
 =?utf-8?B?a0pJZFhqQzk1Rm40V0JGRXpmMDVXQk1UbnFsdmFNUk5TcytjeHVBTE0rNGV5?=
 =?utf-8?B?aWlTb0l0dXp0ajk0ZXM2WG40MXBSQUpPY0RKVzdOL1Z5bVNyN2N2VFM4dmox?=
 =?utf-8?B?dEJ6Skg5L0g1RUZ3Z2lsZW1QWDBkRWpjRGtKQkh5eTl1bHhrU2k1S1BvUWJ2?=
 =?utf-8?B?cGJCY2dibWUzVExqc1pPSjVwQkhqKzMxU0ZOY0xldE9VenVEb25aNlYzb3Iv?=
 =?utf-8?B?RFRQbkdjSkoxUGRmclkyZ1ptWUhzSXRzQTkzNnRzVERXZk9YVlQ3OVljWTRU?=
 =?utf-8?B?dElOMWYrYkM3Yjk1STNrUmJTQjVGR2dISHBrTm94SGJFdzBCampncC8zd1pk?=
 =?utf-8?B?SkYzQWpkZkdSM1lpV3pMRm05RVg2bTB6UUpaRUpGaFRDWWFlVFRZbGVvTTEr?=
 =?utf-8?B?anZEZ1AvSHMwcldGa05INWFOYjR5cWszZjl6NmZKMktxVnpzR2dqQmxTaUN3?=
 =?utf-8?B?S2txbjNmWEU3dE9uQk1DWUpjeTk0MHpvbG14QzRqbEJibzg5SHZSNEdpYitY?=
 =?utf-8?B?OEVBVk9WcjdiVndxT0E0SkhwK3hLSnBqMktXOWhtbjdYcm1wV3p2T1VHVFhE?=
 =?utf-8?B?eGp3RUpLaGJ2eXpibGZoVjNiWXlCNGpCdUNMalZTMUNsOC9WUm5helk4VzJ0?=
 =?utf-8?B?ZUREVjV1Z0RsNTJPaWJpNzIwTmZEZkY2b0Y0UG9EZDRKa1RGMTFwb0M2OTVO?=
 =?utf-8?B?V2Z2ZVBBbFRRMFRuN21Rd1MzWEZCbWl3NytOYnA1cFhyTkNndEhnTzg1QkZJ?=
 =?utf-8?B?dUxvajJPcC95RHlGOHpPNDVoaUNqNmVhUzRTcXZkcUMxeEQ3U29kTDNaZXRE?=
 =?utf-8?B?cXVVM1o2dU04RWdPbDF5NkdWaEZrbndyWklVMGdsR0FYZTdMMS9uTlZ0ZjZl?=
 =?utf-8?B?b2xwSFhwYUl5ZnRDZlljT2FrR3V4QXg5R1lpNU9uR1c2N0xhVDFUS09uVkFh?=
 =?utf-8?B?Q3BMSGYrbGJrSjBXYnhBYi9zZ0VNVGhJTFh2dUtmUkE2aER2RUhvU1EzV3Nq?=
 =?utf-8?B?MWFiL3huTm15VlQ3eTErY0tOZXlDVzBhaS94UDZOdWZHa2lobVFWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rDim6jBtwMIDq7fosZO+l6su4RgZ9bvjREueB486E42F8zEFgOXuIr6pBGTZae+QKj7QBA+kHoMGb2SAdr7zWhNBG1iwtN8t9ajBHP3d2h9DW8NO4CUF1fcjq1CpnbzWFbrF50lGDeLWG0klJ5UnvOytgJiQ9ax4cFpNA1OfcVyF+wkq/w7tulovAXzLkKWOKArYkeSmE8ua7q5cXNyoE1mn68OkLlkD99ncGTP6bddTZs9XYbNUlLHKMjFgfAvMoGumKPGYZ3yw8fjL5JN89zxN//PDFczmcldzx/L/MSIY2yvo+wRVnvkZ/jKQph8VcQhAM7wayvISHYJypQr0DA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b581ade-83b5-4ec2-5c74-08ded8cd204c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:34:25.4939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTNxPqUkhlMbEI96nHqgE6tZTad6XcKWnj4TNIlaBFSE/bjUkLBfpnZBAWrpWO0tEBUZplGjq6o4qLrS13SsTOF6Srg2A8M7/oBbGZPAtNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5819
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEzLzIxXSBody9hcm0vYXNw
ZWVkX2FzdDI3eDA6IEFkZCB1bmltcGxlbWVudGVkDQo+IE9UUCBjb250cm9sbGVyIE1NSU8gcmVn
aW9ucyBmb3IgU1NQL1RTUA0KPiANCj4gT24gNC8xNy8yNiAwNToyOCwgSmFtaW4gTGluIHdyb3Rl
Og0KPiA+IFRoZSBBU1QyNzAwIFNTUC9UU1AgZmlybXdhcmUgYWNjZXNzZXMgT1RQIE1NSU8gcmVn
aW9ucyB0aGF0IGFyZSBub3QNCj4gPiB5ZXQgaW1wbGVtZW50ZWQgaW4gUUVNVS4NCj4gPg0KPiA+
IFRoaXMgY2hhbmdlIGFkZHMgdW5pbXBsZW1lbnRlZCBNTUlPIGRldmljZXMgZm9yIHRoZSBPVFAg
YW5kIG1hcHMgdGhlbQ0KPiA+IHRvIHRoZWlyIGNvcnJlc3BvbmRpbmcgcGh5c2ljYWwgYWRkcmVz
c2VzIGluIHRoZSBTU1AvVFNQIGFkZHJlc3Mgc3BhY2UuDQo+ID4gVGhlc2Ugc3R1YiBkZXZpY2Vz
IGFsbG93IFFFTVUgdG8gc2FmZWx5IGhhbmRsZSBmaXJtd2FyZSBhY2Nlc3NlcyBhbmQNCj4gPiBw
cmV2ZW50IHNwdXJpb3VzIGV4Y2VwdGlvbnMsIHdoaWxlIGFjY3VyYXRlbHkgcmVmbGVjdGluZyB0
aGUgaGFyZHdhcmUNCj4gPiBtZW1vcnkgbWFwLg0KPiA+DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFu
Z2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfY29wcm9jZXNz
b3IuaCB8IDEgKw0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oICAgICAgICAgfCAx
ICsNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYyAgICAgICAgIHwgNiArKysrKysN
Cj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYyAgICAgICAgIHwgNiArKysrKysNCj4g
PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gcGxlYXNlIHNlbmQg
Zmlyc3QuDQo+IA0KU29ycnkgcmVwbHkgeW91IGxhdGUuDQpJIHdpbGwgc2VuZCB0aGlzIHBhdGNo
IGluIHRoZSBuZXcgcGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MsDQpKYW1pbg0KPiBUaGFua3MsDQo+
IA0KPiBDLg0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9j
b3Byb2Nlc3Nvci5oDQo+ID4gYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfY29wcm9jZXNzb3IuaA0K
PiA+IGluZGV4IDA4NDA0MGJiZWQuLjc3NTA1NjllZWQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9ody9hcm0vYXNwZWVkX2NvcHJvY2Vzc29yLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2FybS9h
c3BlZWRfY29wcm9jZXNzb3IuaA0KPiA+IEBAIC00Nyw2ICs0Nyw3IEBAIHN0cnVjdCBBc3BlZWQy
N3gwQ29wcm9jZXNzb3JTdGF0ZSB7DQo+ID4gICAgICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRl
IGlwY1syXTsNCj4gPiAgICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgc2N1aW87DQo+ID4g
ICAgICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRlIHByaWNbMl07DQo+ID4gKyAgICBVbmltcGxl
bWVudGVkRGV2aWNlU3RhdGUgb3RwOw0KPiA+DQo+ID4gICAgICAgQVJNdjdNU3RhdGUgYXJtdjdt
Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBiL2lu
Y2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGluZGV4IGQzOWU0Zjc1NTMuLjFkZjg0N2Iz
NGQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gKysr
IGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gQEAgLTI5OSw2ICsyOTksNyBAQCBl
bnVtIHsNCj4gPiAgICAgICBBU1BFRURfREVWX0lPRVhQMV9JM0MsDQo+ID4gICAgICAgQVNQRUVE
X0RFVl9QUklDMCwNCj4gPiAgICAgICBBU1BFRURfREVWX1BSSUMxLA0KPiA+ICsgICAgQVNQRUVE
X0RFVl9PVFAsDQo+ID4gICB9Ow0KPiA+DQo+ID4gICBjb25zdCBjaGFyICphc3BlZWRfc29jX2Nw
dV90eXBlKGNvbnN0IGNoYXIgKiBjb25zdA0KPiA+ICp2YWxpZF9jcHVfdHlwZXMpOyBkaWZmIC0t
Z2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXNzcC5jDQo+ID4gYi9ody9hcm0vYXNwZWVkX2Fz
dDI3eDAtc3NwLmMgaW5kZXggNDY3ZmRlYTlkYi4uNzhiZDZmMzQyYyAxMDA2NDQNCj4gPiAtLS0g
YS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2Fz
dDI3eDAtc3NwLmMNCj4gPiBAQCAtMzAsNiArMzAsNyBAQCBzdGF0aWMgY29uc3QgaHdhZGRyIGFz
cGVlZF9zb2NfYXN0Mjd4MHNzcF9tZW1tYXBbXQ0KPiA9IHsNCj4gPiAgICAgICBbQVNQRUVEX0RF
Vl9GTUNdICAgICAgID0gIDB4NzQwMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfUFJJQzFd
ICAgICA9ICAweDc0MTAwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1NDVUlPXSAgICAgPSAg
MHg3NEMwMjAwMCwNCj4gPiArICAgIFtBU1BFRURfREVWX09UUF0gICAgICAgPSAgMHg3NEMwNzAw
MCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9JTlRDSU9dICAgID0gIDB4NzRDMTgwMDAsDQo+ID4g
ICAgICAgW0FTUEVFRF9ERVZfVUFSVDBdICAgICA9ICAweDc0QzMzMDAwLA0KPiA+ICAgICAgIFtB
U1BFRURfREVWX1VBUlQxXSAgICAgPSAgMHg3NEMzMzEwMCwNCj4gPiBAQCAtMTQ4LDYgKzE0OSw4
IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0Mjd4MHNzcF9pbml0KE9iamVjdCAqb2JqKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfVU5JTVBMRU1FTlRFRF9ERVZJ
Q0UpOw0KPiA+ICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInByaWMxIiwgJmEt
PnByaWNbMV0sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9VTklNUExF
TUVOVEVEX0RFVklDRSk7DQo+ID4gKyAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJv
dHAiLCAmYS0+b3RwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9VTklN
UExFTUVOVEVEX0RFVklDRSk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVl
ZF9zb2NfYXN0Mjd4MHNzcF9yZWFsaXplKERldmljZVN0YXRlICpkZXZfc29jLA0KPiA+IEVycm9y
ICoqZXJycCkgQEAgLTI4OCw2ICsyOTEsOSBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfc29jX2Fz
dDI3eDBzc3BfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2X3NvYywgRXJyb3IgKiplcnJwKQ0KPiA+
ICAgICAgIGFzcGVlZF9tbWlvX21hcF91bmltcGxlbWVudGVkKHMtPm1lbW9yeSwNCj4gU1lTX0JV
U19ERVZJQ0UoJmEtPnByaWNbMV0pLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJhc3BlZWQucHJpYzEiLA0KPiA+DQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9QUklD
MV0sDQo+ID4gMHgxMDAwKTsNCj4gPiArICAgIGFzcGVlZF9tbWlvX21hcF91bmltcGxlbWVudGVk
KHMtPm1lbW9yeSwNCj4gU1lTX0JVU19ERVZJQ0UoJmEtPm90cCksDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLm90cCIsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfT1RQXSwNCj4gMHg4MDAp
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgUHJvcGVydHkgYXNwZWVkXzI3eDBf
Y29wcm9jZXNzb3JfcHJvcGVydGllc1tdID0geyBkaWZmDQo+ID4gLS1naXQgYS9ody9hcm0vYXNw
ZWVkX2FzdDI3eDAtdHNwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMNCj4gPiBpbmRl
eCAzYTkwYmJlYzUxLi5kNjQ0OGQ4MmY1IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRf
YXN0Mjd4MC10c3AuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYw0KPiA+
IEBAIC0zMCw2ICszMCw3IEBAIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX3NvY19hc3QyN3gw
dHNwX21lbW1hcFtdDQo+ID0gew0KPiA+ICAgICAgIFtBU1BFRURfREVWX0ZNQ10gICAgICAgPSAg
MHg3NDAwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9QUklDMV0gICAgID0gIDB4NzQxMDAw
MDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfU0NVSU9dICAgICA9ICAweDc0QzAyMDAwLA0KPiA+
ICsgICAgW0FTUEVFRF9ERVZfT1RQXSAgICAgICA9ICAweDc0QzA3MDAwLA0KPiA+ICAgICAgIFtB
U1BFRURfREVWX0lOVENJT10gICAgPSAgMHg3NEMxODAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RF
Vl9VQVJUMF0gICAgID0gIDB4NzRDMzMwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfVUFSVDFd
ICAgICA9ICAweDc0QzMzMTAwLA0KPiA+IEBAIC0xNDgsNiArMTQ5LDggQEAgc3RhdGljIHZvaWQg
YXNwZWVkX3NvY19hc3QyN3gwdHNwX2luaXQoT2JqZWN0ICpvYmopDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVFlQRV9VTklNUExFTUVOVEVEX0RFVklDRSk7DQo+ID4gICAgICAg
b2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAicHJpYzEiLCAmYS0+cHJpY1sxXSwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1VOSU1QTEVNRU5URURfREVWSUNFKTsN
Cj4gPiArICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgIm90cCIsICZhLT5vdHAsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1VOSU1QTEVNRU5URURfREVWSUNF
KTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyN3gwdHNw
X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldl9zb2MsDQo+ID4gRXJyb3IgKiplcnJwKSBAQCAtMjg1
LDYgKzI4OCw5IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9zb2NfYXN0Mjd4MHRzcF9yZWFsaXpl
KERldmljZVN0YXRlICpkZXZfc29jLCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgYXNwZWVkX21t
aW9fbWFwX3VuaW1wbGVtZW50ZWQocy0+bWVtb3J5LA0KPiBTWVNfQlVTX0RFVklDRSgmYS0+cHJp
Y1sxXSksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFzcGVlZC5w
cmljMSIsDQo+ID4NCj4gc2MtPm1lbW1hcFtBU1BFRURfREVWX1BSSUMxXSwNCj4gPiAweDEwMDAp
Ow0KPiA+ICsgICAgYXNwZWVkX21taW9fbWFwX3VuaW1wbGVtZW50ZWQocy0+bWVtb3J5LA0KPiBT
WVNfQlVTX0RFVklDRSgmYS0+b3RwKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJhc3BlZWQub3RwIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9PVFBdLA0KPiAweDgwMCk7DQo+ID4gICB9DQo+ID4N
Cj4gPiAgIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSBhc3BlZWRfMjd4MF9jb3Byb2Nlc3Nvcl9wcm9w
ZXJ0aWVzW10gPSB7DQoNCg==

