Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BB4E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVmgf-0001iE-MC; Thu, 09 Jan 2025 02:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tVmgc-0001hz-Rn; Thu, 09 Jan 2025 02:10:35 -0500
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tVmga-0003I0-40; Thu, 09 Jan 2025 02:10:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGLP2GTVBwWvQTpYiazVz2z7ZcGom/HC0rDTzGMp14UYEjsO0wE0iSLWST1JRJIhFEvhBAD7+XIpl47oiNZAUGuSYncNY+O0QdCCHKpqj80GD++L3SKiKzP2uKNb0HwkQcLK35sYixi/PdPFP2djXCRwjDaFeOD90UpyM8HeLG7VhTP7zLYu9R5bNeUbkJQDOwnvfN2SRkpne84PMcHooycYNAUJgzXIb8lmtZa1EqgFgl9gDc6e/0KAhkqdvzdAJzFemdHYPRic0cSaZbPwn4euRpH5QZ9Bo3g4qy8xwu4hNdu4MsYGhx4JpCMj7t2QgngkZhDm757l9kim8piGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py/YzMiEKCfMeP1fILdLUbUgf7vAOoxnUm6GNMR7nFc=;
 b=h+cRCsbdzfrSDf73ME72D9zAkBqKLPE17aMbCQ7C3SQQxmC8OIrCNr8PEnIw91LlQhu3QfO7+vLsRjEigqtJGd6iRKBJiWFcKi35YevVsSQ66+uByJOEjM/aHW5kNwfx4buyDjwAEYZsR3U6SkbhN7QdJN0rVlL63AZGj89xeD8k46NZhawFzXZdRP8B+NOZZ4eZxW5PqE8n0W+pIGdqOjtjLebUwWTk9zvEeFCncMRTM7Wx6A4F32IhZn8lmj9mUVzAxHlxXJ+IEbI0MS4XFhmWmhO1oybUPOki1JLbewVL/fuxbsgtcson6S4F9F5Sxwppa8QlPeSUsO0NRPZFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py/YzMiEKCfMeP1fILdLUbUgf7vAOoxnUm6GNMR7nFc=;
 b=UfGknQR9E7pETysTotfGO4fUI60KGD91iF4AbjXAKtHvKlXLpkExwvzDgc61/ChFMPWrd6S3YFouClmkxpVtMwAfLrFQvL+vMU7nLV5tQ0xf7/sIGfWU0lE+LEHW3zqJUCr/dhkZGQuUSPZ1kzxoSSkaBgnLkhn5TsXmzjBr2Vx02tE2ZdY9saFc1DmWhDLY2tTlrUZXwZvv+nyAMhfwgsRopfuObHUz5NRg120BE+YegiubfMFbqe30HCL91zYX++e9UbuoYLGaPZ8BKsfDvkWRP6qybh8HLN58KtYQFP222EpfidPT4cVUP+Wr9BEAPo1Kik5jJefo0bwSRT6ttw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6723.apcprd06.prod.outlook.com (2603:1096:990:36::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Thu, 9 Jan 2025 07:10:23 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 07:10:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region
 ops
Thread-Topic: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region
 ops
Thread-Index: AQHbT4+qBOUi6dL7pkClZmlFP1QYnrMN1PSAgAAE5ECAAE+/gIAAAGoA
Date: Thu, 9 Jan 2025 07:10:23 +0000
Message-ID: <SI2PR06MB5041CE1DBFA9E17D58CC2547FC132@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
 <20241216075353.1308043-2-jamin_lin@aspeedtech.com>
 <c3b0139f9995427dd83e6172aa17b799361926b6.camel@codeconstruct.com.au>
 <SI2PR06MB504166A128450060C560D908FC132@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <f051128e-94b1-463d-845a-345ec2190d3d@kaod.org>
In-Reply-To: <f051128e-94b1-463d-845a-345ec2190d3d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6723:EE_
x-ms-office365-filtering-correlation-id: 348c0a7c-f977-4b67-0fa7-08dd307cafb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QjZ3QVF0d3dKUHhGcVgzZkNhd0hURkFFU2Y3TjhBd3lMbTFnY3Nsc3cvWmdp?=
 =?utf-8?B?UCtlN0tYeFJJVDU2NHpNZVhRSlVRQWF0bWI2SXF6bGVWVGtsSStNSDNNWmxG?=
 =?utf-8?B?RC85c1R0U3l2eTUreWtqcDBkeXdPZGp4NDN3R0dkUlE4T1pDOWpNQWZGaEt0?=
 =?utf-8?B?U0NBazRmRjBWN21wbms4RHN3UTlNM1RNbjhwaFdBMjN0akRIQmhpTkdwUXFF?=
 =?utf-8?B?N2hRT0ljUVR1SzhwWnIzQWVwMmVSM2JUUWt6U09MZGU1K1hIM1ptM1FlRmJp?=
 =?utf-8?B?cFpoYS9KL2JvRmY1NWtSRUw3Q3g4N2Q0Z050cy9XYmFRUnN2Wk04M0ZtYit2?=
 =?utf-8?B?TWFtUndabVdiN2J6Z3NyUkxHQ1RmVlZXWXBCRnVLUzhjeFRMcGdZb3ZuWVJB?=
 =?utf-8?B?T2dWOThKV2pObHNjN0xyeXlYbzdXQ1Q1YzJCUnVaQWdaa3BTZUlFV3lqZGh3?=
 =?utf-8?B?NU5ZTnVvb3NXZmRPbDZPZnRteTMxb2JiRXRBVVNodTlua09OQi84enVZZXdr?=
 =?utf-8?B?Ujdlc0c3RHNkQ3Bwa1dUYjAwWDFhUjNHOUhQVjBrbVAxK0lWTHFVeGRjUEZt?=
 =?utf-8?B?aEo4OTMwY0ZIbHFvaU80YzNQazJqc0kvLzN2K0h5TFdtUU9UbFFQRnFDdmtG?=
 =?utf-8?B?R2JNY28xRTZqNEpEQ1VQd2gvUk5Oa3RNL1ZjNldkblNCSmZSdDQ3c2YzdnAy?=
 =?utf-8?B?MWxwK0E2eGxXV3llSUFwbE5hWmVlcEFDVnJGVzd6a1ROL1pnRUxpKzA1a3Js?=
 =?utf-8?B?dERzdFZYTHpSd3RDZEk5U21HTkpBVmRLNkRZZU15RHpYT2pPTHo2REU5Q1Ez?=
 =?utf-8?B?bXVDeHlkYVpYczIwU3pvUnkyWEZtWUVhbFFyZE5mRkgxRHkwTkI3VkhuYUFU?=
 =?utf-8?B?RzhqS1RoQ2IvQjFzU1JnZnJZY09rcFVhZTZZbzVORy81dEtDR3dBaVR4Z1lC?=
 =?utf-8?B?UE00K3o5eWgxQzExbDFlU3hNQ0dRajYrdmJ2YytHYVhZSVR2NCt0TGJleEd5?=
 =?utf-8?B?NGcrRzBmSkpHSmxYeng1dFVPbS9CSFpYbExobkhwR3ozL3VXOU1PK3RNWkhG?=
 =?utf-8?B?c1ZFY1Vxa1RFejhQNHM1Nm5LZVM2Q0hhVTZCSXdpNnZpZUZrcVUyZW5DS2ti?=
 =?utf-8?B?djRvbmRKLzdONjNiR05qWkZXTXMwRGZtYVE1UDhlckhrcFEwTVZhZ0p5Vm10?=
 =?utf-8?B?am9DR2llanNPd09WczFSMWloT1V5c0JqK1VqdnRKSnhTS2tPTjNZT3JoZEd2?=
 =?utf-8?B?N0hWb0xTR1ArbFJaTGRCZnlFbExkMTNSV0UwakczNUFVcFdHcS9hZFRMVXo3?=
 =?utf-8?B?RHR0Q1puZ0oyWkJ3VWNWTkplK2xTMTJCSXgwb29DTm5rcGlBZmxXcG5MVVZj?=
 =?utf-8?B?UU9MK2VCcXduT2ErbTRKWjBBUTJuQlJqZUNXWFhzMnMwcldNemlJeDdUVnov?=
 =?utf-8?B?Y1p5WDhjSHMwbUVGMk8yZmVUVW9KbXJpMmN4Z2lkSnRMMWU5TGU5aXRBUEs4?=
 =?utf-8?B?WGhHVytzemNsellGdGpDdzU1UFp5c3lkVUtwWVczN2JBYThxZ0REa2h2OVNk?=
 =?utf-8?B?cEw4cTNEWElNTEpVcXV6Z1VOdlpiZlBSQVQ4d1hTd0lERkcvZ2dJTGpwS2Nn?=
 =?utf-8?B?MnlxR2FPS3Q0ZHQ0enZqTkI5ZkpKZ0VDUUV6Q2g3cDVKdERNRjRZRHV4Slk4?=
 =?utf-8?B?c3cwSitQMEpndnU3ZWhjelp4UnZ6dzB3MFBNc1hRNmdKNC9XS3QxSDJkTHND?=
 =?utf-8?B?S2c4M0V0am9EenVqaXVZOURZUlU5WGRGcW5penZ4bURCaEx6a3V0ZE1PcGRP?=
 =?utf-8?B?cU5HMDZDdmdBUVA1ZXFvYS8zQTQzSDBKQUp5Tkp3NDZraXVVbkZOU3lCeHYz?=
 =?utf-8?B?d0dLcFJWSXk4NTVqclNERStWYlRkZ3E2N3VNZGp1eit2M3NyZEROM2NSQVNG?=
 =?utf-8?Q?kC2u0w6gkqDZKd2SCKP9IaNixZy1XHNB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEUxdGlGOStVa2wwN0U5L2h5TzI5bWtIdlNVdmhWNTRMRkdYSUQ3WXhkRWNn?=
 =?utf-8?B?Vkl6R0wvNnFVaTRUZUVZMWRHOWpxOWZvZlBheEg2NGZ6S2sxYW9FVUxHM2Zp?=
 =?utf-8?B?bjVDRlgrRTFjV2h4Y1hOMnRZNGxxMjV2UUNvczVTSFY5NENsRis1QzVzdjN0?=
 =?utf-8?B?VWFvWHYwOEhZS00wMWRRYWpPeWZ0YWJTM0JHS01JbFp0NEp2U29tN3FuVEd2?=
 =?utf-8?B?UDlYWVdOaDhCZDVXS3lXc2x1MUpFc2tzb3MxU0ZRT2U5Und2a25ieVhnTVlr?=
 =?utf-8?B?dWNSaVp0QXJrZ25pS004NUhlenZUMzdkUlQyRXhRRktpZTJldEVIQTAvRlRr?=
 =?utf-8?B?ekU2c1VjT21OL0ZjOUxCQmxqYmUxUm84Sk8ycXZDd0JhcVFrRWs0M2dJbTVY?=
 =?utf-8?B?ZHNlRFpyYjR0dmpRQ1BjWWtmYXdjNVRjc0QvRFZwZWZPMlkyVjFFSlB4ZklR?=
 =?utf-8?B?cXFLTGZLZTVDOVl6R0F0YXpVYmdnMFJUc0pVSzl6WVU1TWxJTXhKaElHUGN2?=
 =?utf-8?B?eUZvU0ZMVDFSRHFHbmZkcTFVZXMwU0xEQ2xxYS8yYWNnY1hnRHBhM2pYem1U?=
 =?utf-8?B?ZXVGMWEwa3BPSkRRQUNFUFNCVytJSG5ZQWM5aVZkT21IcGVFUWh2MGx4UG1T?=
 =?utf-8?B?OVJPK3k2NlNoUllBNWc5dkNYMHJzcVI1WnpoeDcrTk56bFRLeWN6SHA3QTBV?=
 =?utf-8?B?Rk5oWW8wWDMyS1VmWTdqanp3dWxjNjZWc2FDSTRhQzZXZE9EbkpqeVdidEI4?=
 =?utf-8?B?aExIdGJkUnFjYXUvYzNNK3QvOFVsODk2SWhTcTdydzllWU9UTGlwa3RsdFhG?=
 =?utf-8?B?OEE0S0lGTjFEOE9pNkYxNTRwakNpMkM0WDh3RDhOeDRqNkljbUczZnZlM0FQ?=
 =?utf-8?B?YWJUcGhnQ0crVGh6eC9abWwzQnFrSkZnTXY1SnpBTXBuVS9Fa2MrK1VBclZm?=
 =?utf-8?B?TUVpU2lWR0M2L2JGK3ljVE51ZndrdVp0LytTWDJBL0tVZFFvaVdKaDZtakRY?=
 =?utf-8?B?TTBENExjOGJwMDZoOC82UzJRZWY2SGI5blhJcW1wKzhyY2M2WXBYQmZGZlFo?=
 =?utf-8?B?bUpHNE9ISVdzaHdlM2tIeWhzUTBRMy9iZ0M5U0hGL1Y3TUVVSWRuRnlvRmg5?=
 =?utf-8?B?Q1N3U0cwcmJJRDlGb1BGZzZkWTJPK2dsTldzMTRmR2x5NDZWSG1jblBrNlpC?=
 =?utf-8?B?aS93THl1TjdscWJNMkR5ZDZsY0l6NEN5a0g4SjMvYWwrSjhQcUJuWGpINTRZ?=
 =?utf-8?B?bDIrc1k4MVJaVGRqRy9Rb2djQTlpYU9jQ1gwOEVUTndlbmE5ZE85MXdMc1Jo?=
 =?utf-8?B?bk5KYUV5ZS80a2psYkp4MnpWd0ROYlNML0pEdWppSjM3MVpWeE95L3Q2QWpF?=
 =?utf-8?B?RHY4b2I5VTBPOU4xbjVRd1hWMEh0dEVtUCtQZmRzWisvQ2hwbmpGODBXQUtF?=
 =?utf-8?B?N0JEcWlxU3BxNDdMZ0crTXB3by9qVER1anpPTG41ZVpZQ2hROU5xdWVwNmdO?=
 =?utf-8?B?LzFOOStkZGZlNnNxNERVdDRIa2REalRQV0RGc05yU0xJOGFWZlRUNHIvUngz?=
 =?utf-8?B?cmFvQVU5cXdhL056c1lqQVRmREdNcmg2NnAwTkN3UGRhaVVLbzFQb1B3Z2RM?=
 =?utf-8?B?UGhTR3dZN2hibXArYkRkYjA0ZHFZbmJyM0dodG53OStlaFpVeitQNUFUclN5?=
 =?utf-8?B?bU9tWU9oRDNhVll4YUlEczliclV3b2RWTjBUNnR5bXNQK1FsSWx1eExzaThi?=
 =?utf-8?B?NDdtMEp0dWUyV0dIalZJdDBhY0lxM0JId2VwMm8xaDBYalJTWFFIdE41eU02?=
 =?utf-8?B?N1p4TlFhTkVsaTBDUjc4K2JlUUpoOEV3bjA3bVdINkZReTJhZnQxZ3ZpQlFn?=
 =?utf-8?B?cUdsc3pCZC9qUVN0dWxSaTRmcnRhYnNvV3JrSUJ4Y1dMeXlUVFRkaFV3eUEw?=
 =?utf-8?B?UG45Y29vc3ZHeVZaNElzV21oa2J4T29uMk5CQTFOUnBCc1RoSDdBZUdOK2R2?=
 =?utf-8?B?Smg3dktJTmdNdlFvbHdEWEJhTnVGYnJVUUhyMjFMeWM1dStML3dMQWVmMmNr?=
 =?utf-8?B?cGlTL3FpYThZNk94elJRUVF2VFZsQUgyM0ljcVQvc1dXdk83eUJHL3pPZ25l?=
 =?utf-8?Q?Dmjf7yMfErUcRZZKLz2KBgcc6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348c0a7c-f977-4b67-0fa7-08dd307cafb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:10:23.7684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34f1y54F2Qwm8MMBV/IXAVMjVUDJs13Nq5ZOo82JhtjGtcp2QTS2ixanMY56VMpW8YIMtWyghko/EWFaluGZ3m4x5gjHxmp92qjwZfEoOQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6723
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDks
IDIwMjUgMzowMiBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsNCj4gU3RldmVuIExlZSA8c3RldmVu
X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47DQo+IEpv
ZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFl
bXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVt
dS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2gu
Y29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDEvM10gaHcvdGltZXIvYXNwZWVkOiBTdXBwb3J0IGRpZmZlcmVu
dCBtZW1vcnkgcmVnaW9uDQo+IG9wcw0KPiANCj4gT24gMS85LzI1IDAzOjI2LCBKYW1pbiBMaW4g
d3JvdGU6DQo+ID4gSGkgQW5kcmV3LA0KPiA+DQo+ID4+IEZyb206IEFuZHJldyBKZWZmZXJ5IDxh
bmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5
IDksIDIwMjUgOTo1OSBBTQ0KPiA+PiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA+PiA8Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5
ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA+PiA8c3RldmVu
X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEpvZWwN
Cj4gPj4gU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4g
Pj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0K
PiA+PiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiA+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVl
QGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPj4gPHl1bmxpbi50YW5nQGFzcGVlZHRl
Y2guY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvM10gaHcvdGltZXIvYXNwZWVk
OiBTdXBwb3J0IGRpZmZlcmVudCBtZW1vcnkNCj4gPj4gcmVnaW9uIG9wcw0KPiA+Pg0KPiA+PiBP
biBNb24sIDIwMjQtMTItMTYgYXQgMTU6NTMgKzA4MDAsIEphbWluIExpbiB3cm90ZToNCj4gPj4+
IEl0IHNldCAiYXNwZWVkX3RpbWVyX29wcyIgc3RydWN0IHdoaWNoIGNvbnRhaW5pbmcgcmVhZCBh
bmQgd3JpdGUNCj4gPj4+IGNhbGxiYWNrcyB0byBiZSB1c2VkIHdoZW4gSS9PIGlzIHBlcmZvcm1l
ZCBvbiB0aGUgVElNRVIgcmVnaW9uLg0KPiA+Pj4NCj4gPj4+IEJlc2lkZXMsIGluIHRoZSBwcmV2
aW91cyBkZXNpZ24gb2YgQVNQRUVEIFNPQ3MsIHRoZSB0aW1lciByZWdpc3RlcnMNCj4gPj4+IGFk
ZHJlc3Mgc3BhY2UgYXJlIGNvbnRpZ3VvdXMuDQo+ID4+Pg0KPiA+Pj4gZXg6IFRNQzAwLVRNQzBD
IGFyZSB1c2VkIGZvciBUSU1FUjAuDQo+ID4+PiBleDogVE1DMTAtVE1DMUMgYXJlIHVzZWQgZm9y
IFRJTUVSMS4NCj4gPj4+IGV4OiBUTUM4MC1UTUM4QyBhcmUgdXNlZCBmb3IgVElNRVI3Lg0KPiA+
Pj4NCj4gPj4+IFRoZSBUTUMzMCBpcyBhIGNvbnRyb2wgcmVnaXN0ZXIgYW5kIFRNQzM0IGlzIGFu
IGludGVycnVwdCBzdGF0dXMNCj4gPj4+IHJlZ2lzdGVyIGZvciBUSU1FUjAtVElNRVI3Lg0KPiA+
Pj4NCj4gPj4+IEhvd2V2ZXIsIHRoZSByZWdpc3RlciBzZXQgaGF2ZSBhIHNpZ25pZmljYW50IGNo
YW5nZSBpbiBBU1QyNzAwLiBUaGUNCj4gPj4+IFRNQzAwLVRNQzNDIGFyZSB1c2VkIGZvciBUSU1F
UjAgYW5kIFRNQzQwLVRNQzdDIGFyZSB1c2VkIGZvcg0KPiA+PiBUSU1FUjEuDQo+ID4+PiBJbiBh
ZGRpdGlvbmFsLCBUTUMyMC1UTUMzQyBhbmQgVE1DNjAtVE1DN0MgYXJlIHJlc2VydmVkIHJlZ2lz
dGVycw0KPiA+Pj4gZm9yDQo+ID4+PiBUSU1FUjAgYW5kIFRJTUVSMSwgcmVzcGVjdGl2ZWx5Lg0K
PiA+Pj4NCj4gPj4+IEJlc2lkZXMsIGVhY2ggVElNRVIgaGFzIHRoZWlyIG93biBjb250cm9sIGFu
ZCBpbnRlcnJ1cHQgc3RhdHVzDQo+ID4+PiByZWdpc3Rlci4NCj4gPj4+IEluIG90aGVyIHdvcmRz
LCB1c2VycyBhcmUgYWJsZSB0byBzZXQgY29udHJvbCBhbmQgaW50ZXJydXB0IHN0YXR1cw0KPiA+
Pj4gZm9yDQo+ID4+PiBUSU1FUjAgaW4gb25lIHJlZ2lzdGVyLiBCb3RoIGFzcGVlZF90aW1lcl9y
ZWFkIGFuZA0KPiA+Pj4gYXNwZWVkX3RpbWVyX3dyaXRlIGNhbGxiYWNrIGZ1bmN0aW9ucyBhcmUg
bm90IGNvbXBhdGlibGUgQVNUMjcwMC4NCj4gPj4+DQo+ID4+PiBJbnRyb2R1Y2UgYSBuZXcgImNv
bnN0IE1lbW9yeVJlZ2lvbk9wcyAqIiBhdHRyaWJ1dGUgaW4NCj4gPj4+IEFzcGVlZFRJTUVSQ2xh
c3MgYW5kIHVzZSBpdCBpbiBhc3BlZWRfdGltZXJfcmVhbGl6ZSBmdW5jdGlvbi4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPj4+IC0tLQ0KPiA+Pj4gIMKgaHcvdGltZXIvYXNwZWVkX3RpbWVyLmPCoMKgwqDCoMKgwqDC
oMKgIHwgNyArKysrKystDQo+ID4+PiAgwqBpbmNsdWRlL2h3L3RpbWVyL2FzcGVlZF90aW1lci5o
IHwgMSArDQo+ID4+PiAgwqAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9ody90aW1lci9hc3BlZWRfdGltZXIu
YyBiL2h3L3RpbWVyL2FzcGVlZF90aW1lci5jIGluZGV4DQo+ID4+PiAxNDlmN2NjNWE2Li45NzBi
ZjFkNzlkIDEwMDY0NA0KPiA+Pj4gLS0tIGEvaHcvdGltZXIvYXNwZWVkX3RpbWVyLmMNCj4gPj4+
ICsrKyBiL2h3L3RpbWVyL2FzcGVlZF90aW1lci5jDQo+ID4+PiBAQCAtNjA2LDYgKzYwNiw3IEBA
IHN0YXRpYyB2b2lkIGFzcGVlZF90aW1lcl9yZWFsaXplKERldmljZVN0YXRlDQo+ID4+PiAqZGV2
LCBFcnJvciAqKmVycnApDQo+ID4+PiAgwqDCoMKgwqAgaW50IGk7DQo+ID4+PiAgwqDCoMKgwqAg
U3lzQnVzRGV2aWNlICpzYmQgPSBTWVNfQlVTX0RFVklDRShkZXYpOw0KPiA+Pj4gIMKgwqDCoMKg
IEFzcGVlZFRpbWVyQ3RybFN0YXRlICpzID0gQVNQRUVEX1RJTUVSKGRldik7DQo+ID4+PiArwqDC
oMKgIEFzcGVlZFRpbWVyQ2xhc3MgKmF0YyA9IEFTUEVFRF9USU1FUl9HRVRfQ0xBU1Mocyk7DQo+
ID4+Pg0KPiA+Pj4gIMKgwqDCoMKgIGFzc2VydChzLT5zY3UpOw0KPiA+Pj4NCj4gPj4+IEBAIC02
MTMsNyArNjE0LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3RpbWVyX3JlYWxpemUoRGV2aWNlU3Rh
dGUNCj4gPj4+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPj4+ICDCoMKgwqDCoMKgwqDCoMKgIGFz
cGVlZF9pbml0X29uZV90aW1lcihzLCBpKTsNCj4gPj4+ICDCoMKgwqDCoMKgwqDCoMKgIHN5c2J1
c19pbml0X2lycShzYmQsICZzLT50aW1lcnNbaV0uaXJxKTsNCj4gPj4+ICDCoMKgwqDCoCB9DQo+
ID4+PiAtwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcy0+aW9tZW0sIE9CSkVDVChzKSwN
Cj4gJmFzcGVlZF90aW1lcl9vcHMsDQo+ID4+IHMsDQo+ID4+PiArwqDCoMKgIG1lbW9yeV9yZWdp
b25faW5pdF9pbygmcy0+aW9tZW0sIE9CSkVDVChzKSwgYXRjLT5yZWdfb3BzLCBzLA0KPiA+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQ
RV9BU1BFRURfVElNRVIsIDB4MTAwMCk7DQo+ID4+DQo+ID4+DQo+ID4+PiAgwqDCoMKgwqAgc3lz
YnVzX2luaXRfbW1pbyhzYmQsICZzLT5pb21lbSk7DQo+ID4+PiAgwqB9DQo+ID4+PiBAQCAtNzA4
LDYgKzcwOSw3IEBAIHN0YXRpYyB2b2lkDQo+ID4+PiBhc3BlZWRfMjQwMF90aW1lcl9jbGFzc19p
bml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4gPj4+ICDCoMKgwqDCoCBkYy0+
ZGVzYyA9ICJBU1BFRUQgMjQwMCBUaW1lciI7DQo+ID4+PiAgwqDCoMKgwqAgYXdjLT5yZWFkID0g
YXNwZWVkXzI0MDBfdGltZXJfcmVhZDsNCj4gPj4+ICDCoMKgwqDCoCBhd2MtPndyaXRlID0gYXNw
ZWVkXzI0MDBfdGltZXJfd3JpdGU7DQo+ID4+PiArwqDCoMKgIGF3Yy0+cmVnX29wcyA9ICZhc3Bl
ZWRfdGltZXJfb3BzOw0KPiA+Pj4gIMKgfQ0KPiA+Pj4NCj4gPj4+ICDCoHN0YXRpYyBjb25zdCBU
eXBlSW5mbyBhc3BlZWRfMjQwMF90aW1lcl9pbmZvID0geyBAQCAtNzI0LDYgKzcyNiw3DQo+ID4+
PiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfMjUwMF90aW1lcl9jbGFzc19pbml0KE9iamVjdENsYXNz
ICprbGFzcywgdm9pZA0KPiA+Pj4gKmRhdGEpDQo+ID4+PiAgwqDCoMKgwqAgZGMtPmRlc2MgPSAi
QVNQRUVEIDI1MDAgVGltZXIiOw0KPiA+Pj4gIMKgwqDCoMKgIGF3Yy0+cmVhZCA9IGFzcGVlZF8y
NTAwX3RpbWVyX3JlYWQ7DQo+ID4+PiAgwqDCoMKgwqAgYXdjLT53cml0ZSA9IGFzcGVlZF8yNTAw
X3RpbWVyX3dyaXRlOw0KPiA+Pj4gK8KgwqDCoCBhd2MtPnJlZ19vcHMgPSAmYXNwZWVkX3RpbWVy
X29wczsNCj4gPj4+ICDCoH0NCj4gPj4+DQo+ID4+PiAgwqBzdGF0aWMgY29uc3QgVHlwZUluZm8g
YXNwZWVkXzI1MDBfdGltZXJfaW5mbyA9IHsgQEAgLTc0MCw2ICs3NDMsNw0KPiA+Pj4gQEAgc3Rh
dGljIHZvaWQgYXNwZWVkXzI2MDBfdGltZXJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3Ms
IHZvaWQNCj4gPj4+ICpkYXRhKQ0KPiA+Pj4gIMKgwqDCoMKgIGRjLT5kZXNjID0gIkFTUEVFRCAy
NjAwIFRpbWVyIjsNCj4gPj4+ICDCoMKgwqDCoCBhd2MtPnJlYWQgPSBhc3BlZWRfMjYwMF90aW1l
cl9yZWFkOw0KPiA+Pj4gIMKgwqDCoMKgIGF3Yy0+d3JpdGUgPSBhc3BlZWRfMjYwMF90aW1lcl93
cml0ZTsNCj4gPj4+ICvCoMKgwqAgYXdjLT5yZWdfb3BzID0gJmFzcGVlZF90aW1lcl9vcHM7DQo+
ID4+PiAgwqB9DQo+ID4+Pg0KPiA+Pj4gIMKgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF8y
NjAwX3RpbWVyX2luZm8gPSB7IEBAIC03NTYsNiArNzYwLDcNCj4gPj4+IEBAIHN0YXRpYyB2b2lk
IGFzcGVlZF8xMDMwX3RpbWVyX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkDQo+
ID4+PiAqZGF0YSkNCj4gPj4+ICDCoMKgwqDCoCBkYy0+ZGVzYyA9ICJBU1BFRUQgMTAzMCBUaW1l
ciI7DQo+ID4+PiAgwqDCoMKgwqAgYXdjLT5yZWFkID0gYXNwZWVkXzI2MDBfdGltZXJfcmVhZDsN
Cj4gPj4+ICDCoMKgwqDCoCBhd2MtPndyaXRlID0gYXNwZWVkXzI2MDBfdGltZXJfd3JpdGU7DQo+
ID4+PiArwqDCoMKgIGF3Yy0+cmVnX29wcyA9ICZhc3BlZWRfdGltZXJfb3BzOw0KPiA+Pj4gIMKg
fQ0KPiA+Pj4NCj4gPj4+ICDCoHN0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfMTAzMF90aW1l
cl9pbmZvID0geyBkaWZmIC0tZ2l0DQo+ID4+PiBhL2luY2x1ZGUvaHcvdGltZXIvYXNwZWVkX3Rp
bWVyLmggYi9pbmNsdWRlL2h3L3RpbWVyL2FzcGVlZF90aW1lci5oDQo+ID4+PiBpbmRleCAwN2Rj
NmI2ZjJjLi44ZDBiMTVmMDU1IDEwMDY0NA0KPiA+Pj4gLS0tIGEvaW5jbHVkZS9ody90aW1lci9h
c3BlZWRfdGltZXIuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9ody90aW1lci9hc3BlZWRfdGltZXIu
aA0KPiA+Pj4gQEAgLTczLDYgKzczLDcgQEAgc3RydWN0IEFzcGVlZFRpbWVyQ2xhc3Mgew0KPiA+
Pj4NCj4gPj4+ICDCoMKgwqDCoCB1aW50NjRfdCAoKnJlYWQpKEFzcGVlZFRpbWVyQ3RybFN0YXRl
ICpzLCBod2FkZHIgb2Zmc2V0KTsNCj4gPj4+ICDCoMKgwqDCoCB2b2lkICgqd3JpdGUpKEFzcGVl
ZFRpbWVyQ3RybFN0YXRlICpzLCBod2FkZHIgb2Zmc2V0LCB1aW50NjRfdA0KPiA+Pj4gdmFsdWUp
Ow0KPiA+Pj4gK8KgwqDCoCBjb25zdCBNZW1vcnlSZWdpb25PcHMgKnJlZ19vcHM7DQo+ID4+DQo+
ID4+IFNvIGdpdmVuIHRoZSBsYXlvdXQgY2hhbmdlcyBmb3IgdGhlIEFTVDI3MDAsIHBlcmhhcHMg
d2UgY2FuIGltcHJvdmUNCj4gPj4gdGhlIHdheSB3ZSd2ZSBvcmdhbmlzZWQgdGhlIGNhbGwgZGVs
ZWdhdGlvbj8NCj4gPj4NCj4gPj4gQ3VycmVudGx5IHRoZSBjYWxsYmFja3MgaW4gYGFzcGVlZF90
aW1lcl9vcHNgIGFyZSBnZW5lcmljDQo+ID4+IChhc3BlZWRfdGltZXJfcmVhZCgpLCBhc3BlZWRf
dGltZXJfd3JpdGUoKSksIGFuZCB0aGVuIHdlIHNwZWNpYWxpc2UNCj4gPj4gc29tZSBiaXRzIGlu
IHRoZSBkZWZhdWx0IGxhYmVsIG9mIHRoZSBzd2l0Y2ggc3RhdGVtZW50IGJ5IGRlbGVnYXRpbmcN
Cj4gPj4gdG8gdGhlIFNvQy1zcGVjaWZpYyBjYWxsYmFja3MuDQo+ID4+DQo+ID4+IFBlcmhhcHMg
d2Ugc2hvdWxkIGluc3RlYWQgY2FsbCB0aHJvdWdoIHRoZSBTb0Mtc3BlY2lmaWMgY2FsbGJhY2tz
DQo+ID4+IGZpcnN0LCBhbmQgdGhlbiBoYXZlIHRob3NlIGNhbGwgdGhlIGdlbmVyaWMgb3AgaW1w
bGVtZW50YXRpb24gZm9yDQo+ID4+IGFjY2Vzc2VzIHRvIHJlZ2lzdGVycyBoYXZlIGNvbW1vbiBi
ZWhhdmlvdXJzIGFjcm9zcyB0aGUgQVNUMls0NTZdMDAgU29Dcy4NCj4gPj4NCj4gPj4gV2l0aCB0
aGF0IHBlcnNwZWN0aXZlLCB0aGUgY2hhbmdlIGluIGxheW91dCBmb3IgdGhlIEFTVDI3MDAgaXMN
Cj4gPj4gZWZmZWN0aXZlbHkgYSBzcGVjaWFsaXNhdGlvbiBmb3IgYWxsIHRoZSByZWdpc3RlcnMu
IExhdGVyLCBpZiB0aGVyZSdzDQo+ID4+IHNvbWUgdGlua2VyaW5nIHdpdGggdGhlIHRpbWVyIHJl
Z2lzdGVycyBmb3IgYSBoeXBvdGhldGljYWwgQVNUMjgwMCwNCj4gPj4gd2UgY2FuIGZvbGxvdyB0
aGUgc2FtZSBzdHJhdGVneSBieSBleHRyYWN0aW5nIG91dCB0aGUgY29tbW9uDQo+ID4+IGJlaGF2
aW91cnMgZm9yIHRoZSBBU1QyNzAwIGFuZCBBU1QyODAwLCBhbmQgaW52b2tlIHRoZW0gdGhyb3Vn
aCB0aGUNCj4gZGVmYXVsdCBsYWJlbC4NCj4gPj4NCj4gPj4gQXMgYSBxdWljayBQb0MgdG8gZGVt
b25zdHJhdGUgbXkgbGluZSBvZiB0aGlua2luZyAobm90IGNvbXBpbGVkLCBub3QNCj4gPj4gdGVz
dGVkLCBvbmx5IGNvbnZlcnRzIEFTVDI0MDApOg0KPiA+Pg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91
ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQo+ID4gQ3VycmVudGx5LCBJIGFtIHdvcmtpbmcgb24g
UUVNVSB0byBzdXBwb3J0IHRoZSAiQVNUMjcwMCBBMSIgYm9vdChJIHNob3VsZA0KPiByZWZhY3Rv
ciBJTlRDIG1vZGVsKS4NCj4gDQo+IElzIHRoYXQgdGhlIHJlYXNvbiB3aHkgdGhlIFFFTVUgYXN0
MjcwMC1ldmIgbWFjaGluZSBkb2Vzbid0IGJvb3Qgd2l0aCB0aGUNCj4gdjA5LjA0IFNESyBpbWFn
ZXMgPw0KPiANClllcywgImFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neiIgaXMgdXNlZCBmb3Ig
QVNUMjcwMCBBMS4NClRoZSBkZXNpZ24gYmV0d2VlbiB0aGUgQVNUMjcwMCBBMCBhbmQgQTEgaXMg
ZGlmZmVyZW50LCBlc3BlY2lhbGx5IHRoZSBJTlRDIGNvbnRyb2xsZXJzLiANCkkgYW0gcmVmYWN0
b3JpbmcgdGhlIElOVEMgbW9kZWwgdG8gZW5hYmxlIHRoZSBBU1QyNzAwIEExIHRvIGJvb3QgaW50
byB0aGUgT1MuDQpJZiB5b3Ugd2FudCB0byB0ZXN0IFNESyB2MDkuMDQsIHBsZWFzZSB1c2UgImFz
dDI3MDAtYTAtZGVmYXVsdC1vYm1jLnRhci5neiIuDQpJIGVzdGltYXRlIHRvIHNlbmQgdGhlIHYx
IHBhdGNoIHRvIHN1cHBvcnQgQTEgaW4gdGhlIGVuZCBvZiB0aGlzIG1vbnRoIGJlZm9yZSB0aGUg
Q2hpbmVzZSBOZXcgWWVhci4NCg0KPiA+IE9uY2UgSSBoYXZlIGNvbXBsZXRlZCB0aGF0IHRhc2ss
IEkgd2lsbCByZXZpc2UgdGhlIHRpbWVyIG1vZGVsIHdpdGggeW91cg0KPiBzdWdnZXN0aW9uLg0K
PiANCj4gUGxlYXNlIHJlcGxhY2Ugc3VmZml4ICdfZ2VuZXJpYycgYnkgJ19jb21tb24nIHdoZW4g
eW91IGRvLg0KDQpHb3QgaXQuDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24uDQoNCkphbWluDQo+IA0K
PiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

