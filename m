Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B816DC54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfrmB-0005oP-R4; Thu, 29 Feb 2024 20:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfrm9-0005o5-VP; Thu, 29 Feb 2024 20:33:25 -0500
Received: from mail-eastasiaazlp170120004.outbound.protection.outlook.com
 ([2a01:111:f403:c400::4] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfrm7-0003HH-I8; Thu, 29 Feb 2024 20:33:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9erj9ol8jsQu9bHU0P6IXuo27/KPwIF93pLbhCO8r1x4cH2uk+9qUUj7h0xmmRIdXoA+QeZOmUObdDami7JymDjMIfqKM+IJU/RPzBaVjUhF5c2qSc5gnLqTOfWBlaZumcur4w2Q6XY+d4yTTJu++gPHm1olvF6uBoHnzU5FlojJSUVCdjtN+agwAbKyDQh6fKKlsCQ04IBwOAF2lg9nlPuEBV1uZqfD+W9hGZLK8q/S/r4x9AQT2VrsoB00XtvoT8+Q9yZuOHvODWy242V43aqpUWZ8FHRtdDrPyIhhT5XajqcwpXU4myjL0nFQTLwpC3rOvd/HGZqBg2mkujnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9gSUQB/REVDtSe/Q7jJi/ZS7bN5AhjSdEWTprkNy0k=;
 b=i22PGfv8ZjfuEUBFGPTzXcZT6sVUndEQYEHLnzFO6MTWpB200ZA2tb6Uy5i8dQMOpB5xKTcgKgQRXAELj92WxM9Np4/U1J6TT/bvqIIQD+DZP2VYXfDB86jIGujGewZ8JLZJN7rD7aV8FuB9vQx4Z51VR1m3WMMrAYjdRHinyYRnvv0ViHNLiQZ28WtJVAuENFxNd6FVJlA+clIWx05pqT9VOnv4xLVZm47i7O9Btw6kIOqW7qGcsk4Zx22DCQdNzvyvwmVi21aamvecMSob1SPsPPpOCGddJvvR+64X4jnLAeAaonqu+jlHhFZq/OwNa9YVh6AVl5LhvXXaLc+wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9gSUQB/REVDtSe/Q7jJi/ZS7bN5AhjSdEWTprkNy0k=;
 b=SQ14L4XMTVPxDXw+H0zjvypChQoHZDrcCF/xP95dJloe4RsFasyyqPZ1z9+lCIl1+ndEKh5/rFTPFOopxXl+TWWs813Ar75xfymaUKKq4xdTaMhOlhaMygw1nGOpFvW3KYbopB4+ZadANGLL7VZzB1YbxnwWNB5Gw4+IZTtTALy0ljncDGJVMzyWsMBPnCbHmiOt394ptUmJIK5+U1gfrSBYhaywixxi1C2YPdIvmqD/k/qIzfotJ8wv1Zgt/jq49+Gg8k0L1U3DyzLexfY/5wOWKRBSHJIQXiCHRb+hkzyXJO3vYIDZAcFupQog3dZA8qRdhRT4XNp9BqkPCOv5fA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB7163.apcprd06.prod.outlook.com (2603:1096:405:8f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Fri, 1 Mar 2024 01:33:15 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 01:33:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 3/8] aspeed/sdmc: Add AST2700 support
Thread-Topic: [PATCH v1 3/8] aspeed/sdmc: Add AST2700 support
Thread-Index: AQHaauAvBwYelKhFi0mSFZFlyx+e9rEhCnMAgAEQeAA=
Date: Fri, 1 Mar 2024 01:33:14 +0000
Message-ID: <SI2PR06MB5041759FE2C46854DFB91012FC5E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240229072315.743963-1-jamin_lin@aspeedtech.com>
 <20240229072315.743963-4-jamin_lin@aspeedtech.com>
 <06696a4e-ae61-4fa0-984b-481e680f9989@linaro.org>
In-Reply-To: <06696a4e-ae61-4fa0-984b-481e680f9989@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB7163:EE_
x-ms-office365-filtering-correlation-id: 7300f2f3-68a5-4666-8e72-08dc398f9056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T343vs9Jsrd27jKGYe7lso16YLeBGDh00KqUwNc32lAp1SXuZNlKbjxJI9Xfv2Ojp07IFwN7hoD2OFkcEVziDMHDfm7fLtW/cVPeqYZpOr1ZWHAzmJwz+wy745vnd4BgojdZs3Ics7BTvrq/0IOylqurcAnTltvrF8XEpUYrak+6SyLNKDTI6u7Gh0EXhmqlqtniX2QIvccmFew90PRF6e+sw2NEDoQ0zn3zl6Z4cmY7WQSO0Wry93YJDgYlYjdGuKnn+T7xhvJG47/eqSpcadkvnH97nXOf/31/i4HpMta7nxT8LvPte50+txIm7acr5GEufB5MUW3OHWWed6jZZIrFfcSZLmnSS78XlyyXXhTmpWRj6uubd8nCNA1T/3ktYLeQFXKq4OCU5Rkv0ppDUa7IKQS+1JfFtYM4T3OqRiKdx32+erSOrRkgU401ylXF4sOY+zlT9ccnfY3pI6mdLvpjpdkLET/QxnwQ6R6mP8HPUFZif6YxGupANmtHzEpQxEtlNsTD3prJpeJqMCQHTfQnCKivF6/tuVR8gwQxVE3+cUpYJPp5OAIfICQviqWb9m53G9Gfs3vvfy11XpYNIz4f1K6XitwWvrUnKIaNOjOSMmy4GT/FfT66snqWioP0aHknsvUSMO0S+MF2TWNnDc4hMkdDK9zhrmTrNA1vQ1QbHVpq2nglM7/C8Hi/BAyFAU5x6V6Uuh1iGnr1GWcZlaVq8tVC2aFPvhx0pLfI3hI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NlMU4wai82U0tTb0trSjJ6R1FlREx0WFBZa1AyNE5mTG9NNktEbTNsL2U5?=
 =?utf-8?B?V1FFVTVrZVlCL3BObTNwWWdrQnNyNFk4aTRNQ21kYUZMbmRVUElTK3NqTCto?=
 =?utf-8?B?cUZRY2tVbUJwUjdlN251VnNMSFc5UmRKemxCZTRsVXJXUU5EUWQ1YUsyNDhK?=
 =?utf-8?B?ckZqdTN5K2ZCNEl2bDZYL1o1MUdTUysyYWduN1Z6VEg3cCtEUmFOT0FiMXJs?=
 =?utf-8?B?Q2l5UjVhc3lHQ3JRVnZPVUtTc1Z5TVEwbFBDOVI0Z1YzZXJTV0dPQ3B2RmR0?=
 =?utf-8?B?cFBLWnljeXVkYjNZYmo4ZVU1ZDBqY01IZHdXM3NrUXRyNmtIclpnWGIvbkxl?=
 =?utf-8?B?dzFZaTN1TTRSZDRrSnV5UGJxL1hDMW5SY2V2anI5UmN5a2VlUjV3K2cvbTJ6?=
 =?utf-8?B?NXYvUmZXSll6bFh4Um1nS2NzVDYyUmtJdFpwaHdWZmU4dE9vUWUrNnQxZGhJ?=
 =?utf-8?B?d2RRQlJGZVNyd1lLZ2Jjb1o2dCtGR01CV2VMeGlvR2srSEFjUGZNZFdkY0c3?=
 =?utf-8?B?bkdnQmV1S0JrekQxbHE3VUZhY29GclNQQ0JOaGovWWJpMXNnbTR2dVQ3OExm?=
 =?utf-8?B?ZlpCeVZVQVgwd1N4Y00vWGpxU0s3V2xaY05BQlN3aWF3S2FhMFh1VEFldDRC?=
 =?utf-8?B?eVdDQlc5QXhLSVc3U0dGL1JOK1FFOUVUNENoV2NpcnBBSG5BTkZ5UE1tUCt2?=
 =?utf-8?B?WDErTG1nUTRVVDJ6eTFwTUZ4aHBpZjlzR0FSZDlzdWJBVG5aVDJWOEVxNTdU?=
 =?utf-8?B?SnMycWt3TG5rUUpwV2NWV21mUXlNSktDZm1tcW9UL3p5ZEJqV3ZKbGVTZitL?=
 =?utf-8?B?bXpxVEJ6Z1NBbFRxR3N5K1c5cEt1dk5LWHZqd0xwbW81VmdBYzMvcjhkQ1VF?=
 =?utf-8?B?clZpdGZQcGNEUndCZ3o1Y1dkR2xCQjFHc3h6MGdMRUxIT21KNmp2Vzc3Y3Ir?=
 =?utf-8?B?enFtcHdOejB3M0pGRDU5eGtrYmF5S2d4cVdrT0x3OGM2a0VRR21iM29JMjNh?=
 =?utf-8?B?RjRFS05RQVplRnROL2F5QTlKdU9iaDBFUkxSWDBKdlFISkRXVHpKZUdvNWls?=
 =?utf-8?B?ZWsyRXYwQTE0L0NDTUZvSkxVVFBuRzFJbDR6T0lmYWZKbTJTSEJSNjBoVVhS?=
 =?utf-8?B?RE4rVkJuQWEvQlVEVVY1SnB5TC9EY0JnZkZqcThDeVBVNW85V3VaRHZmV2t1?=
 =?utf-8?B?dlZWY0NIaFlTT2dOZmgrZlhrZVdMNnp1MGtNTmtlT2drS3RIOXdEM1gwalVY?=
 =?utf-8?B?enBsZ2lpOE1rOFZDOWF5a1N1Nkx0TXZvUXZxdDluWGdBSkV1R0FJY2lUcmpS?=
 =?utf-8?B?QllubG9hTXVocThpamJsbGdib3RRa1d0T2ROeE12cTUvbWo3VmhBNU5aNmty?=
 =?utf-8?B?a3NaaUVpQWNGNndvaDFhamY0NDIvS3g4cUhoNFNkRml1NmFnWmoreENNSmcr?=
 =?utf-8?B?VkJnUDNUTklDVE94cytOMlVzc2VxUENkcloxaUQ5d2NMMGZHa1p5VmdnMDY4?=
 =?utf-8?B?N0taYW1jK0Rudkl1UjkwcWMyOTBPa1RpcmxCbWpONmc2RXBoSHdOUFVSVFJK?=
 =?utf-8?B?TFdwK3hNRTF5dWVGUzdKc01DcHoxci9nbXMzcEhlQkEvaUp1dThDRmJrOWNs?=
 =?utf-8?B?eE4rc2FmTjBkV0lUYnJrS1JsZ2RxSkFQekFlTnN4UzYyMC9EZ0lrOXFoditJ?=
 =?utf-8?B?cm9UV2tBa2ZJNi9aK0I1ZjRWd2EyZlVJZlFRNGxoWjdndjZUeEhrZXVsRlhk?=
 =?utf-8?B?aWQvTXNwVlFNR0ZEc3hqd1N2blNGci93MUZIUEc1TEJBK3ZqUDFZRVk1VzAr?=
 =?utf-8?B?cUVmNmwvVERvdEFodXQ4dTZEbHBIUkVtQ3F5RzlEcGlrRGx1QmhKZFR2Z1Fl?=
 =?utf-8?B?SE5zdDdXbUliYTBYRnBEZVhjN255cVZKallleTlNWDMxLzJqeStrUG5mRTA3?=
 =?utf-8?B?TitBNDduc2N4d2FZOEhCVjFBcWh2YktVblEwbnRrbitxaW55MlVHemZmaXlQ?=
 =?utf-8?B?WXQ1SkF2eDUwcVdRWnRlWE5saVlmczNMeldybkZMTi9OaFBRcEU0aDlXa3VE?=
 =?utf-8?B?QU5PdjVTLzZEU0Iyb0RDOXNUWUsycmdoUXFad245aVh6clBoRjZBbXd2RUlr?=
 =?utf-8?Q?1RooSqPZ/gDrWrONQ2JcxuCww?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7300f2f3-68a5-4666-8e72-08dc398f9056
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 01:33:14.3920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysDDLOaaaQCL9vmzTWqsChOEM/3cuc2EtvpLyqsSyKq8zcI2SA7mJXxOrv0u3DsU1XLYTg+kelyL1FhfsNWR6Ng1LSFiMuFsFoL/O1eA/bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7163
Received-SPF: pass client-ip=2a01:111:f403:c400::4;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyOSwg
MjAyNCA1OjE3IFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25z
dHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFsaXN0YWlyDQo+
IEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MN
Cj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0K
PiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVl
ZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDMvOF0gYXNwZWVkL3NkbWM6IEFkZCBBU1QyNzAwIHN1
cHBvcnQNCj4gDQo+IEhpIEphbWluLA0KPiANCj4gT24gMjkvMi8yNCAwODoyMywgSmFtaW4gTGlu
IHZpYSB3cm90ZToNCj4gPiBUaGUgU0RSQU0gbWVtb3J5IGNvbnRyb2xsZXIoRFJBTUMpIGNvbnRy
b2xzIHRoZSBhY2Nlc3MgdG8gZXh0ZXJuYWwNCj4gPiBERFI0IGFuZCBERFI1IFNEUkFNIGFuZCBw
b3dlciB1cCB0byBERFI0IGFuZCBERFI1IFBIWS4NCj4gPg0KPiA+IFRoZSBEUkFNIG1lbW9yeSBj
b250cm9sbGVyIG9mIEFTVDI3MDAgaXMgbm90IGJhY2t3YXJkIGNvbXBhdGlibGUgdG8NCj4gPiBw
cmV2aW91cyBjaGlwcyBzdWNoIEFTVDI2MDAsIEFTVDI1MDAgYW5kIEFTVDI0MDAuDQo+ID4NCj4g
PiBNYXggbWVtb3J5IGlzIG5vdyA4R2lCIG9uIHRoZSBBU1QyNzAwLiBJbnRyb2R1Y2UgbmV3DQo+
IGFzcGVlZF8yNzAwX3NkbWMNCj4gPiBhbmQgY2xhc3Mgd2l0aCByZWFkL3dyaXRlIG9wZXJhdGlv
biBhbmQgcmVzZXQgaGFuZGxlcnMuDQo+ID4NCj4gPiBEZWZpbmUgRFJBTUMgbmVjZXNzYXJ5IHBy
b3RlY3RlZCByZWdpc3RlcnMgYW5kIHVucHJvdGVjdGVkIHJlZ2lzdGVycw0KPiA+IGZvciBBU1Qy
NzAwIGFuZCBpbmNyZWFzZSB0aGUgcmVnaXN0ZXIgc2V0IHRvIDB4MTAwMC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGh3L21pc2MvYXNwZWVkX3NkbWMuYyAgICAgICAgIHwgMjE1DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2Rt
Yy5oIHwgICA0ICstDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE5OCBpbnNlcnRpb25zKCspLCAy
MSBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiA+IEBAIC0yMzEsNyArMjcwLDEwIEBAIHN0YXRpYyB2
b2lkIGFzcGVlZF9zZG1jX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4gRXJyb3IgKiplcnJw
KQ0KPiA+ICAgICAgIEFzcGVlZFNETUNTdGF0ZSAqcyA9IEFTUEVFRF9TRE1DKGRldik7DQo+ID4g
ICAgICAgQXNwZWVkU0RNQ0NsYXNzICphc2MgPSBBU1BFRURfU0RNQ19HRVRfQ0xBU1Mocyk7DQo+
ID4NCj4gPiAtICAgIGFzc2VydChhc2MtPm1heF9yYW1fc2l6ZSA8IDQgKiBHaUIpOyAvKiAzMi1i
aXQgYWRkcmVzcyBidXMgKi8NCj4gPiArICAgIGlmICghYXNjLT5pc19hYXJjaDY0KSB7DQo+IA0K
PiBNYXliZSBuYW1lIGl0ICdidXM2NGJpdCc/IEJlY2F1c2UgdGhpcyBpc24ndCByZWFsbHkgcmVs
YXRlZCB0byBBYXJjaDY0Lg0KPiANCj4gPiArICAgICAgICBhc3NlcnQoYXNjLT5tYXhfcmFtX3Np
emUgPCA0ICogR2lCKTsgLyogMzItYml0IGFkZHJlc3MgYnVzICovDQo+ID4gKyAgICB9DQo+IA0K
PiANCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkXzI3MDBfc2RtY19jbGFzc19pbml0KE9iamVjdENs
YXNzICprbGFzcywgdm9pZA0KPiA+ICsqZGF0YSkgew0KPiA+ICsgICAgRGV2aWNlQ2xhc3MgKmRj
ID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiArICAgIEFzcGVlZFNETUNDbGFzcyAqYXNjID0g
QVNQRUVEX1NETUNfQ0xBU1Moa2xhc3MpOw0KPiA+ICsNCj4gPiArICAgIGRjLT5kZXNjID0gIkFT
UEVFRCAyNzAwIFNEUkFNIE1lbW9yeSBDb250cm9sbGVyIjsNCj4gPiArICAgIGRjLT5yZXNldCA9
IGFzcGVlZF8yNzAwX3NkbWNfcmVzZXQ7DQo+ID4gKw0KPiA+ICsgICAgYXNjLT5pc19hYXJjaDY0
ID0gdHJ1ZTsNCj4gPiArICAgIGFzYy0+bWF4X3JhbV9zaXplID0gOCAqIEdpQjsNCj4gPiArICAg
IGFzYy0+Y29tcHV0ZV9jb25mID0gYXNwZWVkXzI3MDBfc2RtY19jb21wdXRlX2NvbmY7DQo+ID4g
KyAgICBhc2MtPndyaXRlID0gYXNwZWVkXzI3MDBfc2RtY193cml0ZTsNCj4gPiArICAgIGFzYy0+
dmFsaWRfcmFtX3NpemVzID0gYXNwZWVkXzI3MDBfcmFtX3NpemVzOyB9DQo+IA0KPiANCj4gPiBA
QCAtNTEsNiArNTIsNyBAQCBzdHJ1Y3QgQXNwZWVkU0RNQ0NsYXNzIHsNCj4gPiAgICAgICBjb25z
dCB1aW50NjRfdCAqdmFsaWRfcmFtX3NpemVzOw0KPiA+ICAgICAgIHVpbnQzMl90ICgqY29tcHV0
ZV9jb25mKShBc3BlZWRTRE1DU3RhdGUgKnMsIHVpbnQzMl90IGRhdGEpOw0KPiA+ICAgICAgIHZv
aWQgKCp3cml0ZSkoQXNwZWVkU0RNQ1N0YXRlICpzLCB1aW50MzJfdCByZWcsIHVpbnQzMl90IGRh
dGEpOw0KPiA+ICsgICAgdWludDMyX3QgaXNfYWFyY2g2NDsNCj4gDQo+IGJvb2wuDQo+IA0KPiA+
ICAgfTsNCj4gPg0KPiA+ICAgI2VuZGlmIC8qIEFTUEVFRF9TRE1DX0ggKi8NClRoYW5rcyBmb3Ig
cmV2aWV3IGFuZCB3aWxsIGZpeC4NCg0K

