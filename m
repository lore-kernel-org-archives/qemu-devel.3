Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1608C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 02:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcyTe-0000jn-Pf; Wed, 21 Feb 2024 21:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rcyTd-0000jf-4i
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:06:21 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rcyTa-0002pH-4r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:06:20 -0500
Received: from mail.andestech.com (ATCPCS33.andestech.com [10.0.1.100])
 by Atcsqr.andestech.com with ESMTP id 41M25tUB020019;
 Thu, 22 Feb 2024 10:05:55 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Feb
 2024 10:05:55 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 22 Feb 2024 10:05:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.41)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Thu, 22 Feb 2024 10:05:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3PBcl0KRAxxxPNbeRR1h0osn1pkZjKxoXl0iengngQXKwBa1ab0emESR169PJs8DUm3vNPkfsj7EeR3PZZNYpjHLtPV0D+7JGu9mP2H8v+O1qvoyXYO0r93YekesGjWex94nfNRzDfHZkBoHwKru08RVbgg3GEr6MpS/3JEthSTicoLr87qivuVmkYdtgR16yVKjB3BK9UY6sVRjW5sGv3sXAdbCTsv+xovh6sIsLCLbizD0HCtxmZBF1FW33rNvFfZ3sIEk+G3cLCx4AbHVwOlBKuRWrnfZpk+0YB4Vw5RMqXAHe2g4mizZdKLPz3QDB+2qjBR6C50UCLAcfSiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9uuixyEb7gRxao5NWQrM6R6a3VEtUOW/DnLSY72WNc=;
 b=LkR1QiuxoFwSwQ916i6ZEOK8A7XB9OuF0FxA2mTxqGPny9AAfBRI3jCOA75B2H9+lMy/fxqC4d0y6Y+Jk2oX2mZLg2ry7kfG5c2c+mXuVYQ0IyF9TM6407Cj3bYOp70LpodLClXbpLHEKwTh82T9DqJqulSXWwS3ojF+KQLAWeYSxZPidpzCoIb1qEOkn36bIIh7P89sRDxmr5NIpfxxLH0ogQ62zLWxSXrcoJgORwsV94bHjbursQ60IbG07vIr583JOHDHeokUIBTJL7Mvelz6p/hYxMpjq47lT57G7KK013aN6ly+y+AbVPKLXiA5Y4ZO/dZNKShs0YNw9XSWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9uuixyEb7gRxao5NWQrM6R6a3VEtUOW/DnLSY72WNc=;
 b=jYXKifeWBEdxQ3lVXqrhCQ4mRnDeoT67dTtdouNxJgORZvTeA5jZPiQYW+qqsf7I9lp/FDtJerKQoDZfcQjRxzIWn6W4Uxbq4bM8S/ySKORDYdt/iVzk9KdjvpA263vZz0zlCFOaV+JGJjyPRBxy0tKXT+lyB3BQQI94EUdFTfo75UFwOj45VjHDy5C10DXWYF+m6yPpj0ibdlNg2TAU6jkIHhpCYWEOtsFPTknNaSxv80rqHBingbjRVl5zRhVRbyIjKXzmljgBin0gE2qEjg1C3t/xgfH8CQv8f8ZBInN4il0UFhvF7AuVs/LJNs+EWACkuuFDzav0h+13eKR7gQ==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by SEZPR03MB8470.apcprd03.prod.outlook.com (2603:1096:101:220::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Thu, 22 Feb
 2024 02:05:47 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::42e4:f684:dde2:fd45]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::42e4:f684:dde2:fd45%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 02:05:47 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH 4/4] target/riscv: Apply modularized matching conditions
 for icount trigger
Thread-Topic: [PATCH 4/4] target/riscv: Apply modularized matching conditions
 for icount trigger
Thread-Index: AQHaYuNwcDOhfBC6S0eoDV+vCtNkz7EVG2CAgACC0hA=
Date: Thu, 22 Feb 2024 02:05:46 +0000
Message-ID: <SEYPR03MB6700369300FD61FE0854B60FA8562@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-5-alvinga@andestech.com>
 <094d7589-09f6-4515-ae8d-72acbd3ade58@ventanamicro.com>
In-Reply-To: <094d7589-09f6-4515-ae8d-72acbd3ade58@ventanamicro.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|SEZPR03MB8470:EE_
x-ms-office365-filtering-correlation-id: bf375ee3-309f-4187-3ea3-08dc334ac8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcrE6wAi2R/E91Og8MlhmhilI5d/HcrTMd2tHJS9gEZlyJ5M9Zjkp19ySkUQzxSRigaIaFdLqSVzOWqsj5e14XydWD9BMhUUKc1FPRN2ck/wQY6iIdDaCiYuEhI4wEahODxaxXKBQePaiav88oxfCJbKjTTG2E2t9L1Bb+IaA3TtbA55m5Bl4w+/rshtrPPE2YjHrdlf2f7hNvOQENnlWLSh6GcFs6GB089Essz1QigwQWzDEnwgJK6ITQ4UMjk47xUUL8DFlj6CNBl7L1XGLCKMPbQtU4IYMiPCoYpJwO7mzH6nFT+SZUrouPXlu49cvl6SHJ7DIp071sQkh8sUo3JOGcyFWbI/6V7iT53AHArMLq8HoWuLFAGn/IQ5/a0XruUuigAxOgVNZVkIJdh4S4h0kFp6FKcuPFBXAUnpAprwbeYAdLUyvhooAPt7vYj/YgZJoio6fmTRuFhV4Si5rnMWsoSvumGaCTeV/NgykptaI3sSfEAJufJTefdDsFzswbzsvhFkJZUvKwrTE/vezb8P0GXGdvVrKV8tPE5eFgvvl0Uk/5MJL+OLD7WfULqaiBNnC8OWdaNYj2nhJ2jt+gC7hKeB1fjvMOjPNsWrj5mMYHRXNnRgdrYTUe6fDbbh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDl2dWtDVEJnYTZaMDRYZ0sxbG95SzIzQ0JRSzBCbERrblVzdFFuM0diQW94?=
 =?utf-8?B?eXdaRHpaYklmaTdxd1ZHMjJDSGZBN3pLU01mcytEcnlKUXo2Nk5UVXQza25E?=
 =?utf-8?B?cWhGTWxuYmRuL08vTFVuWG1DcW8rMjhrNVJaOWNPN1BoWUo4VW5RNzhBbWQ5?=
 =?utf-8?B?cGJJZ0tFa1ZBVTEyMnJ3c3dXdHJxdEZvQnJBdGZhZjhVZE9oRllwQmJhWWRG?=
 =?utf-8?B?bWFqeC9raDdEZ3pCN1VadFdTSTlaNHBDVlRuUWlRTkZQTTN0Z1ZweHBwOHFR?=
 =?utf-8?B?UCtpNStmWHQ4NmJZZFpNOHRXL1ovdFh3dmlFNmp1bDd2b1V5aTdjbzduQ2lQ?=
 =?utf-8?B?bG9pY0gzdUNQOFJkbnlHdGhBbU5jRGthSE13amY1dkcwek5SQ0ZmUkxhODZx?=
 =?utf-8?B?MlhXbzgxaFdYSWxJL2F6a3Z6RkdlK1ppTUk5K2dXdDZsMm0rZWNMNGUyNFlR?=
 =?utf-8?B?RDBNWm1uL1pwRkRMcHFGdUgvM3BrTnV0cXpmcVcrQWVNcnVJUDZjLzBtd0NX?=
 =?utf-8?B?UnB3Y0NsSFZ6aTdGZmlNOVJBNW5oT29nc0tjVHhPQWdQanZSL3ROcE9LdGR3?=
 =?utf-8?B?OG9CVW5KRWh4VXdNcnBqNGhsRGZBcVFWNTVycG1xNjhiaHJvRDg2ci9xRkdY?=
 =?utf-8?B?ZlVIVEFpODFvQXBhZUUrODhkeTU5T2FRaHYzdGVsMGlZTHFBL3NodFJPbklI?=
 =?utf-8?B?bHQ5WWVVY0JmMkdHWEVSOHNBUUgvTk81S1lwRlZGazlOS2FsVExZQWFIWko4?=
 =?utf-8?B?MVB6SzlyeUVWb2Fjc3RMc0NSaWx4Q0k4Mzc2MlQvQXVuWDhHV01xbmo1dnVT?=
 =?utf-8?B?QjdQclZzV1dHN0laWkpJWDBjdU5zdkVCSlFXNjBxMW5DcU4yWCs0bTZsclFK?=
 =?utf-8?B?Wis5TGp4bUpNangyVk5lWnFub3E5a2RMNktNSHh6NVhVUzJZOGE2YitxUzRI?=
 =?utf-8?B?QTZPQkR0NkFkdXMwM0RZNE4zOVlLVTd0TmNBQnVPWEpoS2lKbXFBWStURjlu?=
 =?utf-8?B?TUF4OXlQNUlOc3Zod3ZyZzQ1bUJUSmVKTGRBVlB5NHlMQlcyT1N1cW9Qc0Iy?=
 =?utf-8?B?ZGtXMGcyUTJkZXEwcTZHS3Ztb1lEWlc3YTZ4ZC9NdHlJMTdmVjFxM09aTFpl?=
 =?utf-8?B?MXhPYkFmbVh1dHl5bG9OMTIrVjZyWVhHUDlYemRlQTdtbU1zWE5YOC9xT3Fn?=
 =?utf-8?B?bUhaeG02QStUYldoRU80T1lmRld6enZHSHllTDBxd2NIUEVpTE1ONm5ucXd5?=
 =?utf-8?B?ZXd5NllKTmluMDRpQVhNSW1hUTVWL1dXVWRFcTY0TTNJMkFwNy9vWEZUOHk3?=
 =?utf-8?B?ZmlvdXdlK3hETlIwNVVhVkllbDJGTmQrTzFET1dWUW9rRXBXVHJDTmlVNXBO?=
 =?utf-8?B?OGtLVnFOMEtsVm8xMGxxcy9lZVFBU0hZcHBVT2ppVVRuV3lNTlJtdlpLZ2Ns?=
 =?utf-8?B?TU5wVCttTmVHV0RhdExtT2NvK2tKbDZVQ2ZDYnUxU3pBcW9iMWZyQVUrT1Zt?=
 =?utf-8?B?T0dzcUtDYWNzRmY5dVdBNXdPdHBiNTdGQmJTNVR0ZkcwOW1nWDIrc1ZPU1Fk?=
 =?utf-8?B?Q3RtQ2ZoNHhmZXJpdFAxOGQxUXE0akJzZW5yOVQ5ODBwSWpjaTVQNmE5L1dy?=
 =?utf-8?B?T1diUzNrVEZGYktNekU5TlNZRmZsOVpBTEpqZ1RsdjBzVkIzOTJ3Z1NxNWE0?=
 =?utf-8?B?MVZKOURXWU5pNHorODd1TTRBTmo3NlRhN3c4aFJQMFIzN1ozU0hUWlI4bWda?=
 =?utf-8?B?TzhNbXhoL0x4NnpxZkpiY04vVVlPN2NtdjRKN1VUVkluc09MRUlaRFNxM1ds?=
 =?utf-8?B?VDArdlQrZ2xOUGE2SGllK0xnSks0cE5NamY4NW1MUy9ZN1dLZzl3MXNkdERU?=
 =?utf-8?B?bDEyemVrbmlsNndLNGlwU0p4WFMrZUxmc1JobEhPV1R1TVFHKzJYSWZWSm0r?=
 =?utf-8?B?OXk1aUg0Qzh3SWplQkdpQ2pyYWpNUWRqNVVGMkhBWVdmbWVub24yUTl1STlp?=
 =?utf-8?B?RUgyWmQxcVg1UDEzMjNSQllzRXA3Mytwd2wrMWdTVXhpSDFQSmhuWW05R3dD?=
 =?utf-8?B?Y29namI1bHlQR0dwZDBiWW9MYVJTOUxmZ29pZW9laEpFa1Y4OGFnS0dTL0pz?=
 =?utf-8?Q?lbhvLzvTUOHsa7z0fmB+tMAZx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf375ee3-309f-4187-3ea3-08dc334ac8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 02:05:46.9825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xt0E/btAGY48Vo6xV6hKrcwBvvLH/+FoqYIqj2NTC1vARjBGPdW8pfKZqAZj+3mGJSzjlK0LPWnh41YJYRq7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8470
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41M25tUB020019
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgRmVicnVhcnkgMjIsIDIwMjQgMjowNiBBTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEg
Q2hhbmco5by15ZOy5ZiJKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPjsNCj4gcWVtdS1yaXNjdkBu
b25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbTsgYmluLm1lbmdAd2luZHJpdmVyLmNvbTsNCj4gbGl3ZWkxNTE4QGdtYWlsLmNvbTsg
emhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0g
dGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBjb25kaXRpb25zDQo+IGZv
ciBpY291bnQgdHJpZ2dlcg0KPiANCj4gDQo+IA0KPiBPbiAyLzE5LzI0IDAwOjI1LCBBbHZpbiBD
aGFuZyB3cm90ZToNCj4gPiBXZSBoYXZlIGltcGxlbWVudGVkIHRyaWdnZXJfY29tbW9uX21hdGNo
KCksIHdoaWNoIGNoZWNrcyBpZiB0aGUNCj4gPiBlbmFibGVkIHByaXZpbGVnZSBsZXZlbHMgb2Yg
dGhlIHRyaWdnZXIgbWF0Y2ggQ1BVJ3MgY3VycmVudCBwcml2aWxlZ2UNCj4gPiBsZXZlbC4gV2Ug
Y2FuIGludm9rZSB0cmlnZ2VyX2NvbW1vbl9tYXRjaCgpIHRvIGNoZWNrIHRoZSBwcml2aWxlZ2UN
Cj4gPiBsZXZlbHMgb2YgdGhlIHR5cGUgMyB0cmlnZ2Vycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsdmluIENoYW5nIDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICB0
YXJnZXQvcmlzY3YvZGVidWcuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di9kZWJ1Zy5jIGIvdGFyZ2V0L3Jpc2N2L2RlYnVnLmMgaW5kZXgNCj4gPiA2N2JhMTljOTY2Li5k
ZTk5NmEzOTNjIDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9yaXNjdi9kZWJ1Zy5jDQo+ID4gKysr
IGIvdGFyZ2V0L3Jpc2N2L2RlYnVnLmMNCj4gPiBAQCAtNjI0LDcgKzYyNCw3IEBAIHZvaWQgaGVs
cGVyX2l0cmlnZ2VyX21hdGNoKENQVVJJU0NWU3RhdGUgKmVudikNCj4gPiAgICAgICAgICAgaWYg
KGdldF90cmlnZ2VyX3R5cGUoZW52LCBpKSAhPSBUUklHR0VSX1RZUEVfSU5TVF9DTlQpIHsNCj4g
PiAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICAgICAgICAgICB9DQo+ID4gLSAgICAgICAg
aWYgKGNoZWNrX2l0cmlnZ2VyX3ByaXYoZW52LCBpKSkgew0KPiA+ICsgICAgICAgIGlmICghdHJp
Z2dlcl9jb21tb25fbWF0Y2goZW52LCBUUklHR0VSX1RZUEVfSU5TVF9DTlQsIGkpKSB7DQo+ID4g
ICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiAgICAgICAgICAgfQ0KPiANCj4gDQo+IExvb2tz
IGdvb2QuIFNob3VsZG4ndCB3ZSBhbHNvIGNoYW5nZSByaXNjdl9pdHJpZ2dlcl9lbmFibGVkKCkg
dG8gYWxzbyB1c2UNCj4gdHJpZ2dlcl9jb21tb25fbWF0Y2goKT8gcmlzY3ZfaXRyaWdnZXJfZW5h
YmxlZCgpIGlzIHJlbWFya2FibHkgc2ltaWxhciB0bw0KPiBoZWxwZXJfaXRyaWdnZXJfbWF0Y2go
KSBzbyBJIGJlbGlldmUgd2UgY2FuIGFsc28gdXNlIHRoZSBuZXcgZnVuY3Rpb24gdGhlcmUuDQoN
CkkgdGhpbmsgd2UgbWlnaHQgbm90IHdhbnQgdG8gYXBwbHkgdHJpZ2dlcl9jb21tb25fbWF0Y2go
KSBpbnRvIHJpc2N2X2l0cmlnZ2VyX2VuYWJsZWQoKS4NClRoZSB0cmlnZ2VyX2NvbW1vbl9tYXRj
aCgpIGlzIHVzZWQgdG8gY2hlY2sgaWYgdGhlIHRyaWdnZXIgY2FuIGJlIG1hdGNoZWQgaW4gY3Vy
cmVudCBwcml2aWxlZ2UgbGV2ZWwuDQpJdCB3aWxsIGNoZWNrIG1hbnkgY29uZGl0aW9uczogdHJp
Z2dlciBwcml2aWxlZ2UgbGV2ZWxzLCB0ZXh0cmEsIHRjb250cm9sLCBldGMuDQpUaGUgcmlzY3Zf
aXRyaWdnZXJfZW5hYmxlZCgpIGlzIHVzZWQgdG8gY2hlY2sgaWYgYW55IGljb3VudCB0cmlnZ2Vy
IGlzIGVuYWJsZWQgYnkgY2hlY2tpbmcgdnMvdnUvY291bnQvcy91IGZpZWxkcyBvZiB0ZGF0YTEg
b25seS4NCg0KSW4gZmFjdCwgd2UgZm91bmQgdGhlIGNvbXBhcmlzb25zIGJldHdlZW4gdGRhdGEx
IGJpdC1maWVsZHMgYW5kIGVudi0+cHJpdiBpbiBjaGVja19pdHJpZ2dlcl9wcml2KCkgYXJlIGJ1
Z3MuDQpBbmQgd2UgaGF2ZSBhIHBhdGNoIHRvIGZpeCB0aGF0Og0KDQogICAgYm9vbCByaXNjdl9p
dHJpZ2dlcl9lbmFibGVkKENQVVJJU0NWU3RhdGUgKmVudikNCiAgICB7DQogICAgICAgIGludCBj
b3VudDsNCiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBSVl9NQVhfVFJJR0dFUlM7IGkrKykg
ew0KICAgICAgICAgICAgaWYgKGdldF90cmlnZ2VyX3R5cGUoZW52LCBpKSAhPSBUUklHR0VSX1RZ
UEVfSU5TVF9DTlQpIHsNCiAgICAgICAgICAgICAgICBjb250aW51ZTsNCiAgICAgICAgICAgIH0N
CgktICAgICAgICBpZiAoY2hlY2tfaXRyaWdnZXJfcHJpdihlbnYsIGkpKSB7DQogICAgKyAgICAg
ICAgaWYgKChlbnYtPnRkYXRhMVtpXSAmIElUUklHR0VSX1ZTKSA9PSAwICYmDQogICAgKyAgICAg
ICAgICAgIChlbnYtPnRkYXRhMVtpXSAmIElUUklHR0VSX1ZVKSA9PSAwICYmDQogICAgKyAgICAg
ICAgICAgIChlbnYtPnRkYXRhMVtpXSAmIElUUklHR0VSX1UpICA9PSAwICYmDQogICAgKyAgICAg
ICAgICAgIChlbnYtPnRkYXRhMVtpXSAmIElUUklHR0VSX1MpICA9PSAwICYmDQogICAgKyAgICAg
ICAgICAgIChlbnYtPnRkYXRhMVtpXSAmIElUUklHR0VSX00pICA9PSAwICkgew0KICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOw0KICAgICAgICAgICAgfQ0KICAgICAgICAgICAgY291bnQgPSBpdHJp
Z2dlcl9nZXRfY291bnQoZW52LCBpKTsNCiAgICAgICAgICAgIGlmICghY291bnQpIHsNCiAgICAg
ICAgICAgICAgICBjb250aW51ZTsNCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIHJldHVybiB0
cnVlOw0KICAgICAgICB9DQogICAgDQogICAgICAgIHJldHVybiBmYWxzZTsNCiAgICB9DQoNCg0K
U2luY2VyZWx5LA0KQWx2aW4gQ2hhbmcNCg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IERhbmll
bA0KPiANCj4gDQo+IA0KPiANCj4gDQo+ID4gICAgICAgICAgIGNvdW50ID0gaXRyaWdnZXJfZ2V0
X2NvdW50KGVudiwgaSk7DQo=

