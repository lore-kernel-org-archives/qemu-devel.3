Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC61BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 03:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVN6W-0000Nw-Ks; Tue, 07 Jan 2025 22:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tVN6R-0000NC-6f; Tue, 07 Jan 2025 22:51:31 -0500
Received: from mail-psaapc01on2071b.outbound.protection.outlook.com
 ([2a01:111:f403:200e::71b]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tVN6O-0003tJ-72; Tue, 07 Jan 2025 22:51:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYH71RGhN8xLCbSM/C/8XRTYwkXGr74Xfh0czY/lZiv7blbjMbqjaueUqc055Xt5oe7szlAoSM5mra+aRF1y9a/LdNaLDYU0/uZJVtLWlcycoy9MMoQlxat960VRiikdTkVVfzufnJsPEtgLOzX3vXkCnJo7JPk5iSBcH56A8lrx2w5VI7yO2+SpEa5VU/xzxJYDNtXyZbZmC8nPnMSD7x/9PSHEtJ+IrhUB4IwZD7W6Q9gntI5ekCxBUt41uZHK4JnJFqWga522xbgzk0g7qYouCTKgDbGr00PEpJJSJWO7NcGm77jGe3CWtutMtPr50wdx6mmNuoB/lwYR29J45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLyPc4rowJXfeSWn2moREYqiul+m5eowj8ZwrTehLU8=;
 b=H12tzRkC9boC9pkLQ5Bgd9jGFogIzW5mzBo2lpAvHBaoiyv1d864N7B7tg3Fl8J/NH/gkuSmue2vx6vyJ3IcX26Q8n9rg9LhVIPC7lwmrcrr6tkN9rBje+8ukkvmqxLAfCkogh7v/mFl3Z0MQddVdcYaTYer2Ehe/RzhzByWZAc379yMntOoZEPr4I2vNRUpQgeRCsCm9jAWeyo47bU1sIEfGYWSc1N7ZsQWQU9WbE1d9Yg1RStFSrUb8iNIQMIrcJ2Kei8QbGyLFl5bVbQq3zHhfRxE/N6X8Cm197nW3ZqRZXwGCuXvkd1FYP1cd/YHK+6Zy0dNk91G1sJr2BbVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLyPc4rowJXfeSWn2moREYqiul+m5eowj8ZwrTehLU8=;
 b=WqLuwsjldZN+Z+PBWPMQujLRwG7EbBoNRPW2WxuAKXnj7YVGsdz9IZDAgFQdK0joVeaWfanOhjrfv4B+b4cTAqNQKy+Uunuc9xAQzxthtdzYwYxK+shb3hTXN3f+unnr2Zloa1wJZ4Tsb3Vasv4UFIwTUUwZbe2jQLrj4lrSxtHdBLIqg3wBDCMG+gaVIe6u+ganMFyGStK9sAZ5eZ7fK4m+64ZEGKtZBZJgB3Tuq3UfirZ7Wu+oFPj3TSZyrxGceLsKw7wCm6iI5wJcFl5YeRJTH9R0F1s0dOpthT81sjfLUOvP91LQq6NibjJ/FjZGKRj7U8eIcdKIIrBqGjjrIg==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEYPR06MB6228.apcprd06.prod.outlook.com
 (2603:1096:101:c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 03:51:06 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 03:51:06 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 0/5] Introduce AST27x0 multi-SoC machine
Thread-Topic: [PATCH 0/5] Introduce AST27x0 multi-SoC machine
Thread-Index: AQHbVnEpmsYUrZj8S0+eNdEOIxI9jrMLivWAgADIC3A=
Date: Wed, 8 Jan 2025 03:51:06 +0000
Message-ID: <KL1PR0601MB41802A8867D91C2B8B21637085122@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <8f36b753-660d-4902-be5b-b6569c93aeb5@kaod.org>
In-Reply-To: <8f36b753-660d-4902-be5b-b6569c93aeb5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEYPR06MB6228:EE_
x-ms-office365-filtering-correlation-id: de64125f-07dc-4796-2b43-08dd2f97adec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3IvVEtTUU5lVGNMUVR5YU05MjlGU2pycHNScHUyN2w0cDlseFJIVEYwTEtY?=
 =?utf-8?B?bEk0bWoraTJPQ3puY2g1OHZsaUU3OTZ6TUVkVTNWYUxIa3JPMnAvOGF2ak9h?=
 =?utf-8?B?N0lpYjJzcFRpekhmZHZmTmFKNVpSaStjODBTQTkzMmlmOTV5L1NaL3ZNZTkw?=
 =?utf-8?B?SFVPZlg5dDBIMTd1OTlZanFuZWMvTVowWG1pNXh6ajlXSXR5MVE1OWhXczhp?=
 =?utf-8?B?K25BRlVmVXRmUm5mY2sxaXhkR083c0RrVmR4MVY2ZHlUUHVKUWVmbFkzK3Z0?=
 =?utf-8?B?Z0lCMFVFbVpzTU91ZjBpVXpQNU4zWG00WXM3SzVRc21WR3lNZWlKbGZSZUhZ?=
 =?utf-8?B?b3l2SzNzUDV4K3ZoT2VPbk1RSjBHaXBKUjBucWd6RWVkQVdmeGNEdkZaZGho?=
 =?utf-8?B?a3BKbGUwZHpONGRzalNjOHJxUU15YkJWcWlKeml4Y3h3b3NqWHFYQ1VNYnAx?=
 =?utf-8?B?bGFLN0dWUkRITVRnZElva2ZCeFYvcnozYXJQbmJ6d3hhY3J6ZVJlU1lUTjNy?=
 =?utf-8?B?ZU92VkRxQVVWMWVKVTlWRVVUUURSYXBjWW1pM3Fwb3YwM29KMlA2clV0UnJh?=
 =?utf-8?B?eGdQdk00a2NKZTR2alhISGdtbDhXaDFzbnlTcVJMUXhOR3dIR1hXNEVCRm5F?=
 =?utf-8?B?K3hucG1rZUNEaml0RGIyc0RFbHlEWVNyMHZoZlBvRjVTSXI4SXRSZysybjE3?=
 =?utf-8?B?d2FGcnpjRWdnZlFyR2t5QTZPZVQ1T2d0NU53Nk9uZUhBWFFSckVTTFkyT3hq?=
 =?utf-8?B?WlBMMGVwV1ZCTEZtWldnVlZUQnRIOVlZVnFyVWhhZHlieEIzOEhvbTNrOW1s?=
 =?utf-8?B?ek9FaGFrVnVsamlOd1c1enRGRzU5cS9saGpHR3FvSXA2Y0krM1pPMS9nOFM5?=
 =?utf-8?B?WnNwQlhsakdSQ21kWk0xaUtxMERHb3AxbjhubVdLWHJLUndsNENic3krUUdM?=
 =?utf-8?B?eW1Cd3JKbFZFSW50R1JydldGclZZUVlCSGhRNzdwZG1ub1c3TG1la2ZlUnRG?=
 =?utf-8?B?TTltcDloMlFFZk9rdHVHdG9ST1NSc29SS2RXZkk1cXRNbXQ1UlFDMVFBbGFi?=
 =?utf-8?B?RHBMT1NCRkRsOVAvYjlzM1h4SytXNklpQlhBZVhZUjM5dkRTdElZY1RPajhp?=
 =?utf-8?B?RWE5UHhqOTFiUnpaQnJGeVBxTmplSEhUQjdhbzcrQVFhUGp3ZTJncm9KQjlM?=
 =?utf-8?B?cE9KODQxRjI2UG5wQytlOHVVcmVlMzJ6T2lwN0xrNHlZbnM1VTFjazRXZG50?=
 =?utf-8?B?QWpVY3VCbFdGWVFsYjJLdFJ2SGE1aThVaURmUFRETkM1OVNTN0FyR3BRSVJR?=
 =?utf-8?B?Vi9DUFllcmZDNTJDMjlLTDBVWTBIYUtuWXJTWTlJc3ZpenoxcWk0ZjIwTHJG?=
 =?utf-8?B?aFlXcHZrTGFrVHRiQ3I5Z3NFaHJtQndpZVVMZXA0dzdnQ1Fmeit2Y1FsbVAx?=
 =?utf-8?B?dnUxd254SkVrMkt0QXF3OUtpVU5lS04wclZMSzhlTEFSZnpCenp3b1NhMUp6?=
 =?utf-8?B?ZEtJUzNqMWxEd2lzaGRhWjNjZktqNE8yK1hPaFRyMWJYMUdjWkR4RDVEQUY2?=
 =?utf-8?B?WG51TmJyRkpQUTZhNzdDOE16Um1UUkdTM0drY0pTUUZWOUVQd29KdEJONll6?=
 =?utf-8?B?OVR0VWlJM2RQWUVKWmtUd2VlakV3SDFicldXdkNQL2JOemhpZTlUbjQ3Q29J?=
 =?utf-8?B?Y0NJWGdCY1U5akRLN0c2dTRwL0c2ZnVLVDlxK1lGaWxMOUlqQmNyNWV1dGtU?=
 =?utf-8?B?SEFPYXFhOFlvaWljUzltTmFwM1NidStOK1VWMWN1aDNWUU9qK08veXpsK0RH?=
 =?utf-8?B?aXhtOG1LVXRMLzhnYnRWdDdyZnQ4Qzh0d1BQL3VtRDVLWDQzbVlmVnMvTC9q?=
 =?utf-8?Q?ShiDqK4EznHOF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmkrcjVQRjR5ZU9pT0F5YW5QUWZycWZtSjRGWnhCY1dmdFRQTkhhMWN6bWYv?=
 =?utf-8?B?Z0NQUXVaTFFWK2IzUnNKVXZnbTFvZnFlblBVMExQckt4OVpXcXdmSkVxbkM4?=
 =?utf-8?B?RmtSbkdwdXIxTjY2eXN6NDFoa25pTkNTR2dOUXlacmVZcFMwYU4xMXovNUVT?=
 =?utf-8?B?L3lmUjNVRDJrWEs2dXVKY3JRRU9LbFlCMHo1dUlpRmJtM2dKVGdUdTlRNEF2?=
 =?utf-8?B?VktWRDNEeFZVYW0ydDd2VWN4OEQrbmpVLzE5WmhVQzQzZGMvRExDZGZFMGVx?=
 =?utf-8?B?Q1p1aXprbEsycDZMaTlXd01WOS9UdTVsVXNFQng4WmVWYUJjc3cxUHoxenBo?=
 =?utf-8?B?NEtoL3p0QS9LdjFKNXpVNTlwdUVrYXI4Y0IralhFUzh1SzUyajZya1dNTjQ3?=
 =?utf-8?B?QzUwQm4zT2FSZ3FRSE5wUEo0STh2cUg2c1VpSytGRlozYkwwVkJtTGo1aFBl?=
 =?utf-8?B?RnphbFE2OEhoL0lKSSt0V3RVZ2Zpb2Q5VURNK1R4Mmc1Q09NVnZwcmhlY056?=
 =?utf-8?B?b2dhc1hNSFNaYzR3aEx2dnQvei90SjFrdFJCS1Z0YmFLT01xcjZhSVh5U09G?=
 =?utf-8?B?VnFmTEtCQjkwdm1KaDJGUGUvRDRaWE9xVnZMRG4vMXVZTU0wRkViWG5ZNkVn?=
 =?utf-8?B?SGtrSitiWVpzV1dyRnJUWnB2YUwzTUM2aWhSTXdYWUFMZlVwT2lJcVVHUXZJ?=
 =?utf-8?B?dlN1U2IrdU9xeUNQaDNrTU83b2NDSHUyemdtUVZWazhFOU9mVDVBSzhVdjlK?=
 =?utf-8?B?bDJtMzdyZkJXbURRSUVZWXdPVzVudXFQRkZ1VVZKNkNzS1JGSGZ0cjVqUG5u?=
 =?utf-8?B?ZUlKLzE3U0tXcGE0T21YSTROckhXSlFVT213UTNQWks1YWR6andkWmNhbEE1?=
 =?utf-8?B?dHhBVmRya0Rzd0JtU1V5cmVIZi9OWGh3b0trT255SEd4ZUlaU2xZTXVVeU5R?=
 =?utf-8?B?UUdOTy9oL1RIeWkyY0E1Z1Jia21xU1VLSXBDbUlZendVZThpa0JyKzZPbi94?=
 =?utf-8?B?QUtNL3JzTlIyb3dueHF6bm5PSzRpV2tXb2tFN1EzTHJwcU0zZStFc2hKcWFD?=
 =?utf-8?B?ZnM4NzU5d21DbDBiKzF5bVZaenpIWW02dGdHREROK1FUME5ua05wMlNYVDZH?=
 =?utf-8?B?aUpjbk1DeXUrQy9jeE9hdUYvZVI5WnNTWCtGbE9qRVN1K0FJY0hzOWZOWlJq?=
 =?utf-8?B?WXY1WjVFMHhxcWV3WUg0TTdHTUFyejRXK2d2ZTZLUEVYK2pLbFNxVDFnMTBR?=
 =?utf-8?B?dkkzMFQ0b0lyRVFBMUluR3FnKzFnbExNaVBNL05jK0VValVvcVkwTExMRXJO?=
 =?utf-8?B?Nll3YlN2Y3ZoRlJCbTVURC82T3FKTVlvT2tNem1tM0E4RmlYYlpYM2JNTHhm?=
 =?utf-8?B?NGRLTm54Y2xMQWJiS3VkeWpEU3hSaFdlMzY5elAwVzZxdURpVGlheVRJM3JT?=
 =?utf-8?B?K1lDUFdOWkhtM2JGV1hpMVRyQ0dQU3NNUmJ2Wkg5U2lQKzBLczJsSGkyamJG?=
 =?utf-8?B?SUFCUGg1NXR4Y2E5aDFucE80RzAvVUV4bFN6ME1pdmNmbzZxcmlxRXd5ZWNk?=
 =?utf-8?B?d1FNSkFXeVl2S3dUM0JFVGoybWJ3TEFVck5iZWtuY0dqTDhQZEpYSlV4Znc2?=
 =?utf-8?B?Q1k2ZWowcjNrcmplSmhzbGxiMjM1NDlVY212YVVUZjIyMGs4Q0V4Ymc2Q3Vn?=
 =?utf-8?B?aGhLU2o1cFRValgzWHNrK3E0dE9hMUtCTm91QzBwVmpkN1d2MmlKK1VQUkN6?=
 =?utf-8?B?K2hIQSs3VzhhQktuc3Q2b3pZZStocDZBZUczQ3dmaWtQc3FDeHRTajNnUEFi?=
 =?utf-8?B?T2QzUERCZ1dhdDIrTnNaRmc2RTUrb29wNE82aXphUVR4VlhHeWdMcGJVaVNG?=
 =?utf-8?B?eXVYcVZhVEhRSjFxUnFYaUkvMXpkVks4ZnNnbG50MUErcUR4b0ZCcTU0V3R0?=
 =?utf-8?B?dk51NGhzbjQvRGpTcmJ1RkNxRFl1K2Nxd3FueXNqb1dCNmY3WnFER0RrVFEy?=
 =?utf-8?B?RW8wblVKWnNIb2FMWGdlcHFuY09vdTNYVXh2TG5ydVV6YWhuWUhxOGg1b1Jj?=
 =?utf-8?B?ei9NVHVRbTRPZnNuK0RBTUZteXpxa0Y3NU5mQldMcm5aQkZSVzFqeXlVckRI?=
 =?utf-8?Q?QUMgd73/lofGS5W1jxscdzVHv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de64125f-07dc-4796-2b43-08dd2f97adec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 03:51:06.0356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F36GQlDas7XDJ5iPEfYF1dMUT1vJyuJuXBxY85A4C4PkRXZlUczQ5LYLB78gzIFHKwQx38J3OkAby9NXowBHF3guvQZMFmSd6gIdCA5igjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6228
Received-SPF: pass client-ip=2a01:111:f403:200e::71b;
 envelope-from=steven_lee@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDcs
IDIwMjUgMTE6NTEgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwLzVdIEludHJvZHVjZSBBU1QyN3gwIG11bHRpLVNvQyBtYWNoaW5l
DQo+IA0KPiBTdGV2ZW4sDQo+IA0KPiBXaGVuIHlvdSByZXNlbmQsIGNvdWxkIHlvdSBwbGVhc2Ug
cmViYXNlIG9uIHRvcCBvZiA6DQo+IA0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI0MTIxNjA3NTM1My4xMzA4MDQzLTEtamFtaW5fbGluQGFzDQo+IHBlZWR0ZWNo
LmNvbS8NCj4gDQoNCkkgd2lsbCByZWJhc2UgbXkgVjIgcGF0Y2ggc2VyaWVzIG9uIHRvcCBvZiB0
aGUgcmVxdWVzdGVkIHBhdGNoOg0KDQpUaGFua3MsDQpTdGV2ZW4NCg0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KPiANCj4gT24gMTIvMjUvMjQgMDM6MDMsIFN0ZXZlbiBMZWUgd3JvdGU6DQo+ID4gVGhp
cyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBmdWxsIGNvcmVzIHN1cHBvcnQgZm9yIHRoZSBBU1Qy
N3gwIFNvQywNCj4gPiBhbG9uZyB3aXRoIG5lY2Vzc2FyeSB1cGRhdGVzIHRvIHRoZSBBU1BFRUQg
QVNUMjd4MCBTT0MuDQo+ID4NCj4gPiBUaGUgQVNUMjd4MCBTb0MgaXMgYSBuZXcgZmFtaWx5IG9m
IEFTUEVFRCBTb0NzIGZlYXR1cmluZyA0IENvcnRleC1BMzUNCj4gPiBjb3JlcyBhbmQgMiBDb3J0
ZXgtTTQgY29yZXMuIFRoaXMgcGF0Y2ggc2V0IGFkZHMgdGhlIGZvbGxvd2luZyB1cGRhdGVzOg0K
PiA+DQo+ID4gMS4gUHVibGljIEFQSSB1cGRhdGVzOg0KPiA+ICAgICBNb2RpZmllcyB0aGUgc2Ro
Y2lfYXR0YWNoX2RyaXZlIGFuZCB3cml0ZV9ib290X3JvbSBmdW5jdGlvbnMgdG8NCj4gbWFrZSB0
aGVtDQo+ID4gICAgIGFjY2Vzc2libGUgZm9yIGJyb2FkZXIgdXNhZ2UuDQo+ID4NCj4gPiAyLiBT
b0MgbWVtb3J5IHVwZGF0ZXM6DQo+ID4gICAgIE1hcHMgdW5pbXBsZW1lbnRlZCBkZXZpY2VzIGlu
IHRoZSBBU1QyN3gwIG1lbW9yeSBzcGFjZS4NCj4gPg0KPiA+IDMuIEFTVDI3eDAgQ000IFNvQyBp
bnRlZ3JhdGlvbjoNCj4gPiAgICAgQWRkcyBiYXNpYyBzdXBwb3J0IGZvciB0aGUgQVNUMjd4MCBD
TTQgU29DLg0KPiA+DQo+ID4gNC4gQVNUMjcwMC1GQyBtYWNoaW5lOg0KPiA+ICAgICBJbnRyb2R1
Y2VzIGEgbmV3IEFTVDI3MDAtRkMgbWFjaGluZSB3aGljaCBzdXBwb3J0cyBlbXVsYXRpbmcgNA0K
PiA+ICAgICBjb3J0ZXgtYTM1IGNvcmVzIGFuZCAyIGNvcmV0ZXgtbTQgY29yZXMuDQo+ID4NCj4g
PiA1LiBEb2N1bWVudGF0aW9uOg0KPiA+ICAgICBVcGRhdGVzIHRoZSBBU1BFRUQgZG9jdW1lbnRh
dGlvbiB0byBpbmNsdWRlIHVzYWdlIG9mIHRoZSBuZXcNCj4gPiAgICAgYXN0MjcwMC1mYyBtYWNo
aW5lLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgaGFzIGJlZW4gdGVzdGVkIHVzaW5nIEFTUEVFRCBT
REsgaW1hZ2UgYnkgdGhlIGZvbGxvd2luZw0KPiA+ICAgIElNR0RJUj0uLw0KPiA+ICAgIFVCT09U
X1NJWkU9JChzdGF0IC0tZm9ybWF0PSVzIC1MICR7SU1HRElSfS91LWJvb3Qtbm9kdGIuYmluKQ0K
PiA+DQo+ID4gICAgJCBVQk9PVF9TSVpFPSQoc3RhdCAtLWZvcm1hdD0lcyAtTCAke0lNR0RJUn0v
dS1ib290LW5vZHRiLmJpbikNCj4gPiAgICAkIHdnZXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL3N0
ZXZlbmxlZTcxODkvemVwaHlyL3JlbGVhc2VzL2Rvd25sb2FkLzEuMC4wL2FzdDI3MDAtc3MNCj4g
cC5lbGYNCj4gPiAgICAkIHdnZXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL3N0ZXZlbmxlZTcxODkv
emVwaHlyL3JlbGVhc2VzL2Rvd25sb2FkLzEuMC4wL2FzdDI3MDAtdHMNCj4gcC5lbGYNCj4gPiAg
ICAkIHdnZXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL3N0ZXZlbmxlZTcxODkvemVwaHlyL3JlbGVh
c2VzL2Rvd25sb2FkLzEuMC4wL2JsMzEuYmluDQo+ID4gICAgJCB3Z2V0DQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3plcGh5ci9yZWxlYXNlcy9kb3dubG9hZC8xLjAuMC90ZWUt
cmF3LmJpDQo+IG4NCj4gPiAgICAkIHdnZXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL3N0ZXZlbmxl
ZTcxODkvemVwaHlyL3JlbGVhc2VzL2Rvd25sb2FkLzEuMC4wL3UtYm9vdC1ub2QNCj4gdGIuYmlu
DQo+ID4gICAgJCB3Z2V0DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3plcGh5
ci9yZWxlYXNlcy9kb3dubG9hZC8xLjAuMC91LWJvb3QuZHRiDQo+ID4gICAgJCB3Z2V0DQo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9zdGV2ZW5sZWU3MTg5L3plcGh5ci9yZWxlYXNlcy9kb3dubG9hZC8x
LjAuMC9pbWFnZS1ibQ0KPiBjLnRhci56c3QNCj4gPiAgICAkIHRhciAtLXpzdGQgLXh2ZiBpbWFn
ZS1ibWMudGFyLnpzdA0KPiA+DQo+ID4gICAgJCBxZW11LXN5c3RlbS1hYXJjaDY0IC1tYWNoaW5l
IGFzdDI3MDBmYyBcDQo+ID4gICAgICAgICAtZGV2aWNlDQo+IGxvYWRlcixmb3JjZS1yYXc9b24s
YWRkcj0weDQwMDAwMDAwMCxmaWxlPSR7SU1HRElSfS91LWJvb3Qtbm9kdGIuYmluIFwNCj4gPiAg
ICAgICAgIC1kZXZpY2UgbG9hZGVyLGZvcmNlLXJhdz1vbixhZGRyPSQoKDB4NDAwMDAwMDAwICsN
Cj4gJHtVQk9PVF9TSVpFfSkpLGZpbGU9JHtJTUdESVJ9L3UtYm9vdC5kdGIgXA0KPiA+ICAgICAg
ICAgLWRldmljZQ0KPiBsb2FkZXIsZm9yY2UtcmF3PW9uLGFkZHI9MHg0MzAwMDAwMDAsZmlsZT0k
e0lNR0RJUn0vYmwzMS5iaW4gXA0KPiA+ICAgICAgICAgLWRldmljZQ0KPiBsb2FkZXIsZm9yY2Ut
cmF3PW9uLGFkZHI9MHg0MzAwODAwMDAsZmlsZT0ke0lNR0RJUn0vdGVlLXJhdy5iaW4gXA0KPiA+
ICAgICAgICAgLWRldmljZSBsb2FkZXIsZmlsZT0ke0lNR0RJUn0vYXN0MjcwMC1zc3AuZWxmLGNw
dS1udW09NCBcDQo+ID4gICAgICAgICAtZGV2aWNlIGxvYWRlcixmaWxlPSR7SU1HRElSfS9hc3Qy
NzAwLXRzcC5lbGYsY3B1LW51bT01IFwNCj4gPiAgICAgICAgIC1kZXZpY2UgbG9hZGVyLGNwdS1u
dW09MCxhZGRyPTB4NDMwMDAwMDAwIFwNCj4gPiAgICAgICAgIC1kZXZpY2UgbG9hZGVyLGNwdS1u
dW09MSxhZGRyPTB4NDMwMDAwMDAwIFwNCj4gPiAgICAgICAgIC1kZXZpY2UgbG9hZGVyLGNwdS1u
dW09MixhZGRyPTB4NDMwMDAwMDAwIFwNCj4gPiAgICAgICAgIC1kZXZpY2UgbG9hZGVyLGNwdS1u
dW09MyxhZGRyPTB4NDMwMDAwMDAwIFwNCj4gPiAgICAgICAgIC1tIDFHIFwNCj4gPiAgICAgICAg
IC1kcml2ZSBmaWxlPWltYWdlLWJtYyxpZj1tdGQsZm9ybWF0PXJhdyBcDQo+ID4gICAgICAgICAt
c2VyaWFsIHB0eSAtc2VyaWFsIHB0eSAtc2VyaWFsIHB0eSBcDQo+ID4gICAgICAgICAtUyAtbm9n
cmFwaGljDQo+ID4NCj4gPiAgICAgIGNoYXIgZGV2aWNlIHJlZGlyZWN0ZWQgdG8gL2Rldi9wdHMv
NTEgKGxhYmVsIHNlcmlhbDApDQo+ID4gICAgICBjaGFyIGRldmljZSByZWRpcmVjdGVkIHRvIC9k
ZXYvcHRzLzUyIChsYWJlbCBzZXJpYWwxKQ0KPiA+ICAgICAgY2hhciBkZXZpY2UgcmVkaXJlY3Rl
ZCB0byAvZGV2L3B0cy81MyAobGFiZWwgc2VyaWFsMikNCj4gPg0KPiA+ICAgICQgdGlvIC9kZXYv
cHRzLzUxDQo+ID4gICAgJCB0aW8gL2Rldi9wdHMvNTINCj4gPiAgICAkIHRpbyAvZGV2L3B0cy81
Mw0KPiA+ICAgICQgKHFlbXUpIGMNCj4gPg0KPiA+IFN0ZXZlbiBMZWUgKDUpOg0KPiA+ICAgIGFz
cGVlZDogTWFrZSBzZGhjaV9hdHRhY2hfZHJpdmUgYW5kIHdyaXRlX2Jvb3Rfcm9tIHB1YmxpYw0K
PiA+ICAgIGFzcGVlZDogYXN0Mjd4MDogTWFwIHVuaW1wbGVtZW50ZWQgZGV2aWNlcyBpbiBTb0Mg
bWVtb3J5DQo+ID4gICAgYXNwZWVkOiBJbnRyb2R1Y2UgQVNUMjd4MCBTb0Mgd2l0aCBDb3J0ZXgt
TTQgc3VwcG9ydA0KPiA+ICAgIGFzcGVlZDogSW50cm9kdWNlIGFzdDI3MDAtZmMgbWFjaGluZQ0K
PiA+ICAgIGRvY3M6IGFzcGVlZDogQWRkIGFzdDI3MDAtZmMgbWFjaGluZSBzZWN0aW9uDQo+ID4N
Cj4gPiAgIGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0ICB8ICA1MCArKysrLQ0KPiA+ICAgaHcv
YXJtL2FzcGVlZC5jICAgICAgICAgICAgIHwgICA0ICstDQo+ID4gICBody9hcm0vYXNwZWVkX2Fz
dDI3eDAtY200LmMgfCAzOTcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyAgfCAyMTEgKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgIHwgIDQ1ICsrKy0NCj4gPiAg
IGh3L2FybS9tZXNvbi5idWlsZCAgICAgICAgICB8ICAgNSArLQ0KPiA+ICAgaW5jbHVkZS9ody9h
cm0vYXNwZWVkLmggICAgIHwgICA2ICsNCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aCB8ICA0MSArKysrDQo+ID4gICA4IGZpbGVzIGNoYW5nZWQsIDc0NyBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2Fz
dDI3eDAtY200LmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDI3
eDAtZmMuYw0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KDQo=

