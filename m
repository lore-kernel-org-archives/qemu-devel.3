Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ADEC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0r0p-0006V9-9e; Sun, 30 Aug 2026 21:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0r0l-0006Ug-SY; Sun, 30 Aug 2026 21:40:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0r0j-0002ha-Hi; Sun, 30 Aug 2026 21:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSBC2D5k/4uBIP9K5wGqtLwgs7ejQoKTLa9uYepPHHnFfwJVI9NYp5h6Li0fztP0bX4w2Gk4O2hTSDoFN7QuHQ7VNQuchePQP+DD88Ecghj1l2yCg46PDNejZe5vee7vVZgTrMXxh4SY2gm+G9Z6qU3xFRjfKvoB3k/vZgrYrxmxLJPJK2pTfQNtKQgc/iNGIl55fk4JyiuS4un2cNDlKiB2Yrk4Qb273sdfcMzYeec0UXg/dYT4iQluO9sUxEWQVzQ/0d77cnT+Fzip5prdBvHkKWPODaFiusRGNroC/IYL0zAl15nN1zB/ZeukjOXBDD2q0ZvcAEFqP6Is4tH1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJRFuOEA4d0hZL4LVlS/EEfszn2JE2aIZ4dOCnMBDpY=;
 b=VtGjZiVdyNYGXLbfm/PuIFItpooKASAr+2+nJ/oJREUzZ5I27aUOfQFW3ciY7XSsTD7BbNc6MGY5UkOKA1db+0/3RIwiWPPDVf/diNLJzR1z2exKbP/JzTfFiY+bCzkJkdv+Fr+P/mgEb7Yv69CnFleAXJcWn5LBdYskAukDEggsGaDv5a7XpkiR22t1d/jNzfD/F2Q5L8qacfWlqRl43tWkF9g93WaTitVl3kIlXUyljE5sTHpvhRpVGJKPkp195u8/E3NQEbRlYiuKYe0Vlv13bqj9hTkFeoAYjdwmsDq2Awuvo6PEU1qJO76fgbUMIQjAqnkEglN8qWlQjjRatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJRFuOEA4d0hZL4LVlS/EEfszn2JE2aIZ4dOCnMBDpY=;
 b=bkO4wwplyPu3AUTxwBgJpTcSmub5BxlV1O2tWNmmQxn0cnqp3oEdMjOqp0/NFL8whzlaQTq6PGlhGPWUJK5ZOK+aKu+CdPsL8ZhUJFT019ITW9z3ttgYVDe1fm+5vpd5gXZSxUmcEJHApN4I2TAHceGQNfnFbFhsza2Z5VdRdGAgPC5NVwpuRamKa30hH6TM84PrpCJLrHSQdIYAp0gpav6CmZ+KCo1gIAx2ZqBxt3Ja/m/AyRTg57ILLGcAC09tgHi59LNMFApMddN+20yjyOSCrBQZ0SIdtB7PxOmuMNAyGB2AE6tP9tMBuwGjMttdhgpkCCF7W0AgB/Jk9VaM/w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY8PR06MB9176.apcprd06.prod.outlook.com (2603:1096:405:3aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:40:24 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:40:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Troy
 Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Topic: [PATCH v2 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Index: AQHdMRwQV/tM4a/eWE26Wknz/sxvE7ax4kGAgAWOyFA=
Date: Mon, 31 Aug 2026 01:40:24 +0000
Message-ID: <TYZPR06MB49800D11C3F93FC1B4D91A64FCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
 <20260821032036.1829294-10-jamin_lin@aspeedtech.com>
 <apAx6ZY2uXW5rhDr@redhat.com>
In-Reply-To: <apAx6ZY2uXW5rhDr@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY8PR06MB9176:EE_
x-ms-office365-filtering-correlation-id: 3a6e9f10-9ca0-40ca-b362-08df0700d3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|38070700021|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: /5hCKxNpYMKaSFLBTm0fj8/1WlrTW/dtrpZbi7/UbNYv2fyxa8PAUI/YIEs78wnBVOL5sl5qgui480AwB3vMz/SrBYitEGqxiZg9zMu7LAOoNct96hDlVOwqi6jrJn2z2uM6hN0YhQAd4hho2YibbKN6L8uU/C7znLCo2Bm2+kOvWjy046hxSyZfIv/eTeYf+iQh1et40JljiJLUafA1tEaf3WmNUeAFGNQhoyRIh6MXRMxFizS/AGOCaR/dZCYLAfSRNa4d975qccp/OYkYVX8tQo0YfXC8Q+8x6cufxDt98j/ELrdhKz8kJZqTf2udgI5KyEKhUJs92rgGgMpPoM7dcoMvxWjsl73HFfKMX/qRMpLsccm8GqOWoYzCx7oFhfZqF2+yhHqVFv4cMOJHkWWEZ8trVA40ge6PdyBVgFcEjOiH06zzr6YaRuYJ4hyW+lvXbcMnT/fmpFzlkUkp4YqxpqD8rj+/IAbj5ZMpoJi9um5cpNH82Wcn0CMtJDPXdDYFq0Ykxg8Js2XIOnafYitqBxknrg1npNj+yJhI2qE2NAWADRQC+kUFC7ohyzgwaAEvfft+O3SNup0szASNV8CfxuKqOtniijXfD4dW7OSn52brN5WUAu942Jrqiih92aGOtE+aE79GfPtWLFs+rzQ7Q9gUslt7b2lxxopQaH4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJZbDFnUEY5eThGeklYUUMwTlkveWp4NnRYS1pRTkE4bVpWSHpEcit0Wllu?=
 =?utf-8?B?bEdtNU9vN1lLYjIwUUR0cHVOemZ2TU95dFRObHlkTmlKeE9WOGpCU21wQU92?=
 =?utf-8?B?SW5CT2tBZDRuYUdmaVkzK2llQW1EbVRkbFhCWTBYV1UrOXNNaW0wc0IyODcr?=
 =?utf-8?B?WUdKVVZCdnRMWEpCL2p5eXNqU0ZvUDlFVXkxakswdENjSUZYTU5ROStJN3NP?=
 =?utf-8?B?TjVQbkRzVUFqTHdzUnJwNFFGcGdvaithdHQvK3FKYjQ0bjBEckc5NUZxN3Jt?=
 =?utf-8?B?eGREUHhiNit5cTkzVzQvVVZFNHhEb2RPSzgwZU96T1Z1YVhRSlV0eG5VNEFT?=
 =?utf-8?B?WDBlUzAwYjJLUW50UmdvSUlkYlhRdTBXWFVSZ3hTc05NZUovdjljbWN0Rk1w?=
 =?utf-8?B?Uk1hL3RtYTdlOXBSWHNxMENPV2dnVExxd1Q5MXc0N0RNam9kalJhV1FwVEhh?=
 =?utf-8?B?OGRYMXFPbUJOWS9rZURQVFRsUE9ZZDRLOUF1SXBJRUY0bTdxUThwV1V2WTVz?=
 =?utf-8?B?ZGNORFBtbXVJTlJqWGhKdkw4TXc1L2ZIMnBTQUxpTy8wYlR0ODNoTnlEcEhk?=
 =?utf-8?B?VmRidDgrSStRcFQyZG0yYVFEZ1hIQkhncm5LdkVPR1c5b1FjVjgrQlFRQmVS?=
 =?utf-8?B?MjJoVlpKMDNDMDBBWHNpekRwWSt4V0ZRZWl6Y21LSjlmRnZoRHhGOFdISjZ3?=
 =?utf-8?B?WDhtTmwyUTlsMmlsN2xzRHBFWkhlYnUxd0RFMmtpSExnQWFvSi9sYWxFRHF3?=
 =?utf-8?B?Q1NpaTNLd3BubmoramhML0phYkNQc3hJT2VZalZuZ2hsY2ptWXNZakw2eUlv?=
 =?utf-8?B?RlpzcGF4eEZnRGdTUTZ3WURkdTBTWHgyVDQ3em4xdVRMNmx4eDN3VkJNUFJM?=
 =?utf-8?B?QXEwQmtQZGs4em5oU3NoQ0ZFY3BBTHJ5TTRhT0J3SzNuR1ZxeE5hMUhoaVIx?=
 =?utf-8?B?U3VIWlczUXduMzVIbEs4ZzREaFh3emVnMk5mWUUvamtkWEorWU5ubnBRUEF4?=
 =?utf-8?B?Z2t1OWx5cUNKK2hCZ1U4WjJRTDNDTlF1VWF4bmNFdDdjdDVmL0kvMHZrdWho?=
 =?utf-8?B?VkZ5cWNORm14NE9ZRDZwdXNUa1U2QmRKQmVzUVVYbGk5VVB3TmxUa2VWcE5r?=
 =?utf-8?B?YUh2bE55MktHT1Y5MUJ1U0xLdWtpR1FRK0FmTWlqL0s3QzJHVnAvZUpBTEZk?=
 =?utf-8?B?ckhMZ0IwSGVUN0VZTEd2VWg3dDdyZDJ4THFkRjRhTDdTVVBGVFNoU3pnZnc3?=
 =?utf-8?B?QzUvU0xkd1NiSmQ4OXVLaHh0bjBROGZPR2poNmdKMGlUMXIyYXJUcCtodmNE?=
 =?utf-8?B?bTJpaXI1WW41a0NYaVFRSDFXeDI5bkZtdDI4ZXRkU0ZQMHdIT0xadkNOUXhY?=
 =?utf-8?B?QkxHRmYvNDcwVExLK2JHUThZeW9JRWVvS0k5VGZ1b0N0M0t5RG40RkNudzk3?=
 =?utf-8?B?Y2NiNm4rOHd1YnpQNGI1OE43eTQ1cEZ3QlNhbHlHNld4VE5VczhGakxvejBO?=
 =?utf-8?B?azJ2UytadXVlOGlYcmJJMEs4TW43YmhBQkFQTzRCZEhqcjVFU3hHdkZjRmFX?=
 =?utf-8?B?MEVZUm9sYWd2bFdlNGpxZHVBSWZhZGNSTDJnc1FFVEdMeE5mWEluc1lEdjV3?=
 =?utf-8?B?eURSSnRyNUdrK2Nrc1Q5TXRCZjhWbkpGT1NWNDZmd29ReDZ3Rm45MjdwRzE3?=
 =?utf-8?B?Z0tIUElwMHZqQW9vQnhSVzg0T3NFYis2WVEwYlcwN2VlV0NrZTViUHlUZ1Nz?=
 =?utf-8?B?clphSGQwNnpSVmdWM3NHVkZWUGhKYWhYcC80QW1Vc2VrNjRub0dqOE14VnYv?=
 =?utf-8?B?TlpFU2JWb3luY1lhZEkvWEtLTWdtZm9EcU5nOU5TTXFIaXBkVUJybjQyWlVG?=
 =?utf-8?B?bkFndjlVVlJ2N1AwUFQ4dGx5aUtlWEhaclV2MjkyR1JJK3JaRXlldW5tdG40?=
 =?utf-8?B?N3hlRTV2NGV3YXBaRlpSQmRYdzE1b0VZeDZubm1qcG1KK0M5WWM1MmEzb29r?=
 =?utf-8?B?ZnVoYXQvZXFVY0czS0EvUFowOUpWUFVYV0hDOXU0UW80ZmJpeWVQaUYrbHFi?=
 =?utf-8?B?L2J4YkhaUW5SQlJUeXp0RWZxLzNHQUZGcmhhN3d0bm11MkxlTGdaQ1llSVlv?=
 =?utf-8?B?bFVXTnRXcXZBMG5vU0pzcnQ2TS8zRFlwY0s0b2xTSHRMbjhmWGs0VmpZb2NT?=
 =?utf-8?B?dzY4bFBvdkU1WmZGWEhvekgwU1I4dVVxcjhpL2Q0QlNXSjYrWkViNTNvaURv?=
 =?utf-8?B?MzBCdUhPdEZKczJESGVvM0RHcmc5OWM0cDc0MSsxRzdOc2N6di9aTlBwM2cw?=
 =?utf-8?B?ZjhDclVVOXdYY3pvalVSMHBjVG8yaXFqTWNTdGtFa05oSVZkVWhjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cZR9S0G8SnIKvFTT6sQZ5oXGmfTHqVsDKWp7Sqlx8sZJVE99R/oln8mFpn1tcRqoPWeyHnDPLHAyrNHteWUgg7OILHH7XAQV6MJr0ak74mgrupgFa5j0Gju+B8y5fa12eOwiN32zfvPhqw7GKuZQDAgkCgeiUAhxNTICwUn7fv0S2to00wD8E+0raP6YmnGg4TQzqh/wuCD3Ce60a2bwItF88z4/ntL65hY+u0Gz+J0iHe5Py1yt6CDb8NbzMFG07BliY0O5CxJF+f50yWnqBw+WTIdKDY9XFdv7XD8I8ycCckL2CrkRsOZJnk9dmo0TMACsbvNApKiTgkZZmHqXfg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6e9f10-9ca0-40ca-b362-08df0700d3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:40:24.3714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7l7Fzl0JQ0OiWlXx01Ru/MUn6gm9ntms1X+tME0yfc4256SLzafgHYGBmDV2ErDlQRjZ2rCxVpgb/jIzVI58V6Kj1blHsQbmO8rfNAUE94A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9176
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

SGkgRGFuaWVsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA5LzldIHRlc3RzL3F0ZXN0OiBB
ZGQgQVNQRUVEIFNCQyBFQ0RTQSBlbmdpbmUgdGVzdA0KPiANCj4gT24gRnJpLCBBdWcgMjEsIDIw
MjYgYXQgMDM6MjA6NDlBTSArMDAwMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEFkZCBhIHF0ZXN0
IGZvciB0aGUgQVNQRUVEIHNlY3VyZSBib290IGNvbnRyb2xsZXIgRUNEU0EgZW5naW5lLiBJdA0K
PiA+IHN0YWdlcyB0aGUgcHVibGljIGtleSwgc2lnbmF0dXJlIGFuZCBTSEEtMzg0IGRpZ2VzdCBv
ZiBhIHNlY3AzODRyMQ0KPiA+IGtub3duLWFuc3dlciB2ZWN0b3IgKGZyb20gdGhlIExpbnV4IGtl
cm5lbCBjcnlwdG8gc2VsZi10ZXN0IG1hbmFnZXIsDQo+ID4gZWNkc2FfbmlzdF9wMzg0X3R2X3Rl
bXBsYXRlKSBpbnRvIHRoZSBTRUMgU1JBTSwgdHJpZ2dlcnMgdGhlIGVuZ2luZSdzDQo+ID4gdmVy
aWZ5IGNvbW1hbmQgYW5kIGNoZWNrcyB0aGUgc3RhdHVzIHJlZ2lzdGVyOiBhIHZhbGlkIHNpZ25h
dHVyZQ0KPiA+IHJlcG9ydHMgZG9uZSArIHBhc3MsIGFuZCBhIHRhbXBlcmVkIHNpZ25hdHVyZSBy
ZXBvcnRzIGRvbmUgd2l0aG91dCBwYXNzLg0KPiA+DQo+ID4gVGhlIHRlc3QgaXMgc2tpcHBlZCB3
aGVuIHRoZSBjcnlwdG8gYmFja2VuZCBkb2VzIG5vdCBzdXBwb3J0IEVDRFNBLA0KPiA+IHZpYSBx
Y3J5cHRvX2FrY2lwaGVyX3N1cHBvcnRzKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1p
biBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgdGVzdHMvcXRl
c3QvYXNwZWVkLXNiYy10ZXN0LmMgfCAxOTMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICB8ICAgMiArDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMTk1IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RzL3F0ZXN0L2FzcGVlZC1zYmMtdGVzdC5jDQo+ID4NCj4gDQo+ID4gK3N0YXRpYyB2
b2lkIGFzcGVlZF9hZGRfc2JjX2VjZHNhX3Rlc3RzKGNvbnN0IGNoYXIgKnByZWZpeCwgY29uc3Qg
Y2hhcg0KPiAqbWFjaGluZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3Qgc2VjX2FkZHIsIHVpbnQ2NF90DQo+ID4gK3NyYW1fYWRkcikgew0KPiA+
ICsgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUo
c2JjX2VjZHNhX3Rlc3RzKTsgaSsrKSB7DQo+ID4gKyAgICAgICAgUUNyeXB0b0FrQ2lwaGVyT3B0
aW9ucyBvcHRzID0gew0KPiA+ICsgICAgICAgICAgICAuYWxnID0gUUNSWVBUT19BS19DSVBIRVJf
QUxHT19FQ0RTQSwNCj4gPiArICAgICAgICAgICAgLnUuZWNkc2EuY3VydmVfaWQgPSBzYmNfZWNk
c2FfdGVzdHNbaV0uY3VydmVfaWQsDQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgICAgICBnX2F1
dG9mcmVlIGNoYXIgKnBhdGggPSBOVUxMOw0KPiA+ICsgICAgICAgIEFzcGVlZFNCQ1Rlc3QgKnQ7
DQo+ID4gKw0KPiA+ICsgICAgICAgIGlmICghcWNyeXB0b19ha2NpcGhlcl9zdXBwb3J0cygmb3B0
cykpIHsNCj4gPiArICAgICAgICAgICAgZ19wcmludGVycigiIyBza2lwIFNCQyBFQ0RTQSAlcyB0
ZXN0OiBub3Qgc3VwcG9ydGVkIGJ5IHRoZQ0KPiBjcnlwdG8gIg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICJiYWNrZW5kXG4iLCBzYmNfZWNkc2FfdGVzdHNbaV0ubmFtZSk7DQo+IA0KPiBX
ZSBvdWdodCB0byB1c2UgIGdfdGVzdF9za2lwKC4uLikgaW5zdGVhZCBvZiBnX3ByaW50ZXJyKCIj
IHNraXAuLi4uKSBzbyB3ZSBkb24ndA0KPiBhc3N1bWUgdXNlIG9mIFRBUCBmb3JtYXQuDQo+IA0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCBmaXggaXQuDQpKYW1p
bg0KPiA+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgICAgIHBhdGggPSBnX3N0cmR1cF9wcmludGYoIiVzL3NiYy9lY2RzYS8lcyIsIHByZWZp
eCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNiY19lY2RzYV90ZXN0c1tp
XS5uYW1lKTsNCj4gPiArICAgICAgICB0ID0gZ19uZXcwKEFzcGVlZFNCQ1Rlc3QsIDEpOw0KPiA+
ICsgICAgICAgIHQtPm1hY2hpbmUgPSBtYWNoaW5lOw0KPiA+ICsgICAgICAgIHQtPnNlY19hZGRy
ID0gc2VjX2FkZHI7DQo+ID4gKyAgICAgICAgdC0+c3JhbV9hZGRyID0gc3JhbV9hZGRyOw0KPiA+
ICsgICAgICAgIHQtPmluZGV4ID0gaTsNCj4gPiArICAgICAgICBxdGVzdF9hZGRfZGF0YV9mdW5j
X2Z1bGwocGF0aCwgdCwgdGVzdF9lY2RzYV92ZXJpZnksIGdfZnJlZSk7DQo+ID4gKyAgICB9DQo+
ID4gK30NCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0tDQo+IHw6IGh0dHBzOi8v
YmVycmFuZ2UuY29tICAgICAgIH5+DQo+IGh0dHBzOi8vaGFjaHlkZXJtLmlvL0BiZXJyYW5nZSA6
fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgIH5+ICAgICAgICAgIGh0dHBzOi8v
ZW50YW5nbGUtcGhvdG8ub3JnIDp8DQo+IHw6IGh0dHBzOi8vcGl4ZWxmZWQuYXJ0L2JlcnJhbmdl
ICAgfn4gICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwNCg0K

