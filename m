Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B707C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 07:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXF1I-0004bW-Iw; Fri, 26 Jul 2024 03:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sXF16-0004Wo-S0; Fri, 26 Jul 2024 03:05:28 -0400
Received: from mail-sgaapc01on2112.outbound.protection.outlook.com
 ([40.107.215.112] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sXF13-0006oK-8y; Fri, 26 Jul 2024 03:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8OYkOwBWSAr2ca3yW4z7zAGC9Q2gWYwY2NIk0goBPbVpmqBDZD2bJFjftP6QX435s3HTpg95atA/P5JPzOqmdittw2YjrAKwqrwcXoyskSgqSDV+MhjwEI+5SzEJ5bPEAGM2rzFKr4IX5BjVJ1ZQZrBscvs3yVcYr3XXiseytHk3lPIKz5hYoYmwHx842vpbMbghWW6oCAI1f6S0Lp8MMS8dLSgll8Nl/PCCBTOJOtCHeeTh0nvKlJbwM3ap1nEkHOGpepDYHyxIdqnHzGoWuMF7JlU48ZCfLGwIFzWaWPzy9c0sb13fKEMoOsUdjZe+7EClvZNxkw99DOeqdf0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvUQivmwJsLSoOJJcuOvpHoa0dn5sL1NLoUZbSYNCY4=;
 b=NWzV3Vss5UPBRmRD/HWpsS8v6J/QjQdP2naSDPmFBgF102/Brk+GNXpzxSU2EcmIB8BGaViOBRKbY6ienbJrwkegtpGawpcQUR0SBBY/YIYidY9dsp6/l2Bqga2FIooEbWywoPHabdRR7wev8UhYtbwobfLA/ji0jsw0gVXRbwKXodRvuDezvJ4N7CSFk4PIsCjOEULJFwJHpEaeFeiibKyACkAlp+vJZsdzAG+/p47DLFY6KIU2SSO/h+/Skg5zqh0FDZq5aii408qckWPwU08mH2sqmfes22ALCHp0XvzqhTrlQidb9xLVHiMdOSTz8SjoAK8KUQM2d/C2Iw7BMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvUQivmwJsLSoOJJcuOvpHoa0dn5sL1NLoUZbSYNCY4=;
 b=QWO+Sz4Ey10O/QfNZKnpTf0IHyxGt61ZESt76FUJ1aGIljCsQkH6Tzyn4xgaixo9WK0JyQZB4lzCeY5r0NcMC82y4SFVOQF3/QCN76bUAw0D87QIJTkiTg8+q25Ie0LzV1VDltvDY6AJBvFJbJvXtQZXhK2BxQww8utMv5tm9nIqgIxBSYFf7Md5ZAH1Wy0coj1shwq9agLK6HxfP17uTNsahqSB1wMzse9oZ+M011MzXGUPFMo6PpAGASK6J+mlC7dL04/Y5eCFLNH6cP1q3Wdi6SrTGINkqFSSmRc1DfqsrAxhGBZeKyFThCRPrkDfdNpnC2t0KnW4oWEeHUXgWQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6439.apcprd06.prod.outlook.com (2603:1096:990:3b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.29; Fri, 26 Jul 2024 07:00:12 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:00:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 12/15] aspeed/soc: introduce a new API to get the INTC
 orgate information
Thread-Topic: [PATCH v1 12/15] aspeed/soc: introduce a new API to get the INTC
 orgate information
Thread-Index: AQHa2N7IMMxGyeAgEkOSM1OBYYC1wLH9x6mAgArPX4CAAAmLUA==
Date: Fri, 26 Jul 2024 07:00:11 +0000
Message-ID: <SI2PR06MB5041BB6E3E67D8BE9FF34921FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-13-jamin_lin@aspeedtech.com>
 <f70ae091-151b-476c-a8ef-312952163fac@kaod.org>
 <SI2PR06MB5041C0F1C8FFF216B7B7FC89FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041C0F1C8FFF216B7B7FC89FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6439:EE_
x-ms-office365-filtering-correlation-id: f85a9819-8499-43ca-3839-08dcad40980d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RU96b3J1NklYazFKcTd6clBwR0VtMGlnT255eGJMdFQxZi8rUjJseWphelhu?=
 =?utf-8?B?TXZwSUYxbmd3Q1kvSFpxQ1RrY2htZCtCUyt1dkZJM21DUHdIcGdDZFFUeW5r?=
 =?utf-8?B?Y2hJNUdodm1sbWFxS1Nrd1FnNVBvZ2hxY1hoemljY3VETXYxb2Y3VkV6ZUtM?=
 =?utf-8?B?MGEybDliR1YydkpXM3NiRndFTUN6eXpIbVNkSnRaQkxSR1VPdTMxK1NRYnR0?=
 =?utf-8?B?bmM2a2YvRTdpNXVTNENwZ0k4ckJMNnkzVHRMaE44QW4zUTBQZUVEbERENVFT?=
 =?utf-8?B?eXk0aHpDUWNSZVlrRWNhdlZRSlBMTVNjM2NTamhBcWlUemZZMHk3MWZCMnBP?=
 =?utf-8?B?endSeTZES3lqaE1tZ2J5OFAzSVBCNjdtNjFCbURoZ2VCZTRTMVZ1ampQbWgy?=
 =?utf-8?B?UjEwcWJkeDQ3amRjcTM2a2liS2JJTFNsWE9MZlBTdFp2VmVIenpVOVpZbDVa?=
 =?utf-8?B?Y1dqUUtUTUt3WEplVXJ3MUJMYTZCa1dNaEVWaTV6QzFpTVNRclgwTFBENGxw?=
 =?utf-8?B?UkVCUXZ5eWhaZ0xKQ3ZBTGtVNU0zMUhEZUhOdEk1dWJGVjl2NDN1Skd4OTBx?=
 =?utf-8?B?bnRaMTB6ZURtWUxQT1E2Tmsrd1poSkx1LzRWQUFQcDhFRHVLNG8zTlNRT0J3?=
 =?utf-8?B?eGpKN3VJVHhhZHZCVVN5SXhjQUJucExuTURWUWdwS3dJUkR2c3JFWDVrZGJw?=
 =?utf-8?B?WTRwcWxMQkt2dytpaXVpVnJVemI0WVVSWXRSVWUrM0I3TVFrMmZCQ2x2eDRT?=
 =?utf-8?B?eVdZYWhRRTNuYWg2TWRLMmE3ZEVTSEZWcHZWME1MNW82dWtzMDNiUkwyYTly?=
 =?utf-8?B?S1FiWnJ1TzhPY2x4TURUNjNVSzVXVzhxZUVvaWFMVjlsU2NpdW5OL3gvWkJi?=
 =?utf-8?B?MHlMeFhlcCttcXhybXpaZlVuM05GNWhyemNXWkdPS2ozUklPUkJua3dLMTAv?=
 =?utf-8?B?RGt6dzg0WkEyV0NWR3dnMEhFQUI0WXMwS0NQTkR0VjZXYTA5R0RIQUlMU1VM?=
 =?utf-8?B?RUl4aHB1VlJlVEZzY2ZVWWRVUGIwWFdhbWJwTmd2QVI2OFlRRzBiTng2STgr?=
 =?utf-8?B?RFZmZFBKcnpDVnZjYjE3akVjQ2R2KzZHTGF4K25YUHpsaGZKWDdrZ1lxbldT?=
 =?utf-8?B?M3BiT1BURHBXbnhUeVdidFJCcHJWNU9yMDgzemVrUFpYRnZ1UWNRajR6NDA2?=
 =?utf-8?B?SjdVb0xZYVdQZmQvRUpuamVER0plQUJ0cno3OVJJODdvU1U0QkJINllvYU85?=
 =?utf-8?B?TXlwczE2cjRSM0l3UU1jMzMzWGMzV3cweE5zNHRnOFQwR2hyUFBJUDZqRXRv?=
 =?utf-8?B?NVBkZ09oN2tLN0hoc1NOMEpEay9rT003VERaZjE4THYraW9ZNFIzaVlCZEhm?=
 =?utf-8?B?OWNTUW1lL1lhbFYvZkFZcDIyR3VVMi9RSW5Oc2FvYmRpbTJKbUkxU3pTK20w?=
 =?utf-8?B?MUtEVGlCMnpHcjVNTTdEczcxR0hFMU1tZnh4UGh4ZlpId3RHT3dvd3M5Y2g2?=
 =?utf-8?B?N1pYWGJNVWh6dm5Wa3VuQW9tSWNuWnBhMFZoaitEdklFalhLSitKaDN6SFBm?=
 =?utf-8?B?N1R4T2hQU0swQ2V4Y2haaVp3Y1FuenpmTFA2dFM4MHllei9FbXlvL24yNnQ0?=
 =?utf-8?B?TUxweFl2L2QvSE1wQ3VtN2xoWVgyME9WM1RxL2hNTUFTeUVtZ0RKWUNwSXky?=
 =?utf-8?B?QmZHa1lyZkdEdUFNSERPS1lBbk1HWUxzZGJERFFIZEFpOEEvRXhuWDh1Ti8w?=
 =?utf-8?B?ZDhDdUFvWnhJV2RmTC9EaXVrM205K2FEMFVkaEdWWSs5MEVQKzE0cS85MVNC?=
 =?utf-8?B?N21RY0lJNk9pbHBSbkZxUzJrYXlVaEYxVnkvUk1OU3VYcWh0TG9tSnpCNXND?=
 =?utf-8?B?V0tGTm1EQ09aRC9ILzFNaWtYU0xycWNQcEJtRFY5dUo1alE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE1pK3Bvc3NBZTBxZnVLUjM4bEU5T1g5WWNyTFlQanF3VTVDSFJmNkZBUGg1?=
 =?utf-8?B?VklZOEwwWXEwSTJTV2ZEby9XSmorTjM4NXJNeENyWDlta3YrQ3kyTU9CM05o?=
 =?utf-8?B?dWgvUVhkT3kvODRqMllBZWxpN1plMlAydklWL3I4OFBFQkorbHdZbzk3bUdJ?=
 =?utf-8?B?TEpEM1Fid1RLS1JabHh0eWVUQTZWVmtna01SanBEUmQyenR3VHE0ZTdSU2ov?=
 =?utf-8?B?Q0NWTVpZV0d5S3JzdzVmSmsrQ2xvRU9UakZ5UVBqRlZOZWxHQU91VHIzSDds?=
 =?utf-8?B?NGRjSHRlQTZ0djNSWnhMdU5nUGJxaWJubUZpRE1GZ1pvRWkzMVBNbWlQZEZ1?=
 =?utf-8?B?SnJndTQwdUZaVTVZVzNkVGZHZ3Q5OWhId1ZWaHhiM1I2Uk5ueWR6em9xMDRs?=
 =?utf-8?B?MGJHTmc5YStSZHEvRkQ2YnVNOXFvR2ZlSzZ4ekJCS1k5am9xZkdpb2RualhO?=
 =?utf-8?B?RGRGejB4cmNvaG5tSHpuZE9wcXFnTklyZUpNWi9mZW9iSGtISTFtZTZqRGlO?=
 =?utf-8?B?R3JwdFI0azJMNkdoa0l2YXpBd2k1Yzh1RzlPSjYwVWl6Q1JISVV5aTNYbExJ?=
 =?utf-8?B?RzB0eTlYeDJORkV6UEZyYjhVTURDTmdLamMyVTdld3hqRVRoeFgxVlQ5Vys5?=
 =?utf-8?B?OW03WWJNemR1VlFaM2RCdzlSRGF2N0poT2dMVzUxQlNLSExUUzdMdGFFeVh1?=
 =?utf-8?B?VWNWNENHQloxbzF0Zjk4bVg0K0YrZEgybFdkRUlLYlQzb2hsSHFaaTc0bWRw?=
 =?utf-8?B?aVIxMjZtdGl2Wk9lRDIzbjk4Rm1QKzJTZXYycG9SVUxyQ3VsT1pHQ05VT2E2?=
 =?utf-8?B?cE5vZjNPOHlsYnFTZkN5MkFBZVlDOG5aelhtSys4NVU4SEtXVFZVbnU1ZDhO?=
 =?utf-8?B?N2M2Y3c2VTZkVFJNNWhqZG9uNE5SMDYxaW5VQnVGK2dPYjFNMmJTN01leU5L?=
 =?utf-8?B?NFVLWG5KYVN3TW5OdjJLWGQ3RHZmSjJrY3VkcW03L1JyUlF4S1RaUTVLRlNC?=
 =?utf-8?B?U05OcVNZNmZuUFh6dW0yYVpoUjNKaUVQdUo1a3JJTEtKR1BuTU1IUURxaDBv?=
 =?utf-8?B?dDRSWXRIT0FDaDBnMmhIREY2Wlh4cFFlcDZWY1JTdXB6SEZKQ0xxbitvTEkv?=
 =?utf-8?B?SVIxakdxU011c0llZzBXeEJzeVF0NG1JMjRSUmRvVTgwNWNNaGZoUzJycUxW?=
 =?utf-8?B?R0VBVVlhdUE5Mkg2UDFnOEJ6OTlZLyt5RHFNdytKSkVKQm9nUUxDbndFckV1?=
 =?utf-8?B?K2pvZnNCUnBydUlyQ09PbWU4QnE4WTArb2hCa0tPYTRxQTBUa29XQ1NjcHlZ?=
 =?utf-8?B?UWZZMnN3ZHFzaTg1dlFmQ1RRdUdFZEsvb1V5dlJ6d2k5MHh3cmt4L1NKcTVn?=
 =?utf-8?B?K1FSd296NzJDNGVnS28yVUt1bWdqR1RXcGpnZlQwSnF2VVRaWlhOdjBTNjBU?=
 =?utf-8?B?NWQ2cDRPV0hxUlNPTHZnektZUk5PeFQxajNmbzkzbDFNUzRIRWlXZmNhLytO?=
 =?utf-8?B?cXcxTnQ3bUxDNm9Sc3ltODhIczA1bGdDcDZKa25pWDA0Qkt6TWJZSHdwVXBm?=
 =?utf-8?B?RHFGbFo5a3F2N01HQWZmd0hZMks5WFU5a1ZScUNwazZYcnpMRUNaTEtRdjRi?=
 =?utf-8?B?eDZjcTczd3ltcnp3REN5YlV3clBlMEppSVUyQVJtMWJqOVhRZ2NQVGl3amlC?=
 =?utf-8?B?ZS9vYWhIWmUzRUdrQkJyYndzaElqelI2eDBKUEZ5VjdjcUpncFBmNlVqNHVz?=
 =?utf-8?B?R3EwT2E4SnhHaElUWW1JOEZBUE42dFBLS3pQK091OVdocTlFZmlBWVdDaHhP?=
 =?utf-8?B?UUN1aklLT0duS0tJQzB3R0RBMnpjZXVqcWh6TjJkOW1TUzBsRlJTN1NoT0tX?=
 =?utf-8?B?eFhqNklWbjV1RXdpVWg0Tk1ZSnBDMUh4NWRhZy80bG9mWlM0VzZ5dy9nek8y?=
 =?utf-8?B?NUc1and3SHI3OHVHZm91azFjaW95blhXZTJxcHVRbjBOd2pVek92eks3cG1T?=
 =?utf-8?B?azZ2bnljYkJJaUh2Nit2aG5BSmJEU296ZEJueTU0akt3SU5XMWdqa2NndC8r?=
 =?utf-8?B?bHNFbThqRTM3eVlONGEvMytLMCs4ZDhsZjgwYXlRRGFCRE03aW1zQjNPdlFH?=
 =?utf-8?Q?olkV1xvKJNghRTkmO0EqFbAIq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85a9819-8499-43ca-3839-08dcad40980d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 07:00:11.9664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8I7mt+H4OXlDlJYU0ItvXgCU/WPqM+IxbqW951iptmawcLyFy4uK7BBj6DzYatV+QuR+TKXZkb8PgmHY7i/U0DFV8aJlebdO+jTHjqCv4Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6439
Received-SPF: pass client-ip=40.107.215.112;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

U29ycnkgZm9yIHR5cG8NCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYxIDEyLzE1XSBhc3BlZWQv
c29jOiBpbnRyb2R1Y2UgYSBuZXcgQVBJIHRvIGdldCB0aGUgSU5UQw0KPiBvcmdhdGUgaW5mb3Jt
YXRpb24NCj4NCj4gSGkgQ2VkcmljLA0KPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTIv
MTVdIGFzcGVlZC9zb2M6IGludHJvZHVjZSBhIG5ldyBBUEkgdG8gZ2V0DQo+ID4gdGhlIElOVEMg
b3JnYXRlIGluZm9ybWF0aW9uDQo+ID4NCj4gPiBPbiA3LzE4LzI0IDA4OjQ5LCBKYW1pbiBMaW4g
d3JvdGU6DQo+ID4gPiBDdXJyZW50bHksIHVzZXJzIGNhbiBzZXQgdGhlIGludGMgbWFwcGluZyB0
YWJsZSB3aXRoIGVudW1lcmF0ZWQNCj4gPiA+IGRldmljZSBpZCBhbmQgZGV2aWNlIGlycSB0byBn
ZXQgdGhlIElOVEMgb3JnYXRlIGlucHV0IHBpbnMuIEhvd2V2ZXIsDQo+ID4gPiBzb21lIGRldmlj
ZXMgdXNlIHRoZSBjb250aW51b3VzIGJpdHMgbnVtYmVyIGluIHRoZSBzYW1lIG9yZ2F0ZS4gVG8N
Cj4gPiA+IHJlZHVjZSB0aGUgZW51bWVyYXRlZCBkZXZpY2UgaWQgZGVmaW5pdGlvbiwgY3JlYXRl
IGEgbmV3IEFQSSB0byBnZXQNCj4gPiA+IHRoZSBJTlRDIG9yZ2F0ZSBpbmRleCBhbmQgc291cmNl
IGJpdCBudW1iZXIgaWYgdXNlcnMgb25seSBwcm92aWRlDQo+ID4gPiB0aGUgc3RhcnQgYnVzIG51
bWJlciBvZiBkZXZpY2UuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+
ID4gPiA0MjU3YjVlOGFmLi4wYmJkNjYxMTBiIDEwMDY0NA0KPiA+ID4gLS0tIGEvaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLmMNCj4gPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4g
PiBAQCAtMTY0LDYgKzE2NCwxMSBAQCBzdHJ1Y3QgZ2ljX2ludGNfaXJxX2luZm8gew0KPiA+ID4g
ICAgICAgY29uc3QgaW50ICpwdHI7DQo+ID4gPiAgIH07DQo+ID4gPg0KPiA+ID4gK3N0cnVjdCBn
aWNfaW50Y19vcmdhdGVfaW5mbyB7DQo+ID4gPiArICAgIGludCBpbmRleDsNCj4gPiA+ICsgICAg
aW50IGludF9udW07DQo+ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+ICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBnaWNfaW50Y19pcnFfaW5mbw0KPiA+ID4gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRj
bWFwW10gPQ0KPiA+IHsNCj4gPiA+ICAgICAgIHsxMjgsICBhc3BlZWRfc29jX2FzdDI3MDBfZ2lj
MTI4X2ludGNtYXB9LA0KPiA+ID4gICAgICAgezEyOSwgIE5VTEx9LA0KPiA+ID4gQEAgLTE5Myw2
ICsxOTgsMjcgQEAgc3RhdGljIHFlbXVfaXJxDQo+ID4gYXNwZWVkX3NvY19hc3QyNzAwX2dldF9p
cnEoQXNwZWVkU29DU3RhdGUgKnMsIGludCBkZXYpDQo+ID4gPiAgICAgICByZXR1cm4gcWRldl9n
ZXRfZ3Bpb19pbihERVZJQ0UoJmEtPmdpYyksIHNjLT5pcnFtYXBbZGV2XSk7DQo+ID4gPiAgIH0N
Cj4gPiA+DQo+ID4gPiArc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyNzAwX2dldF9pbnRjX29y
Z2F0ZShBc3BlZWRTb0NTdGF0ZSAqcywNCj4gPiA+ICtpbnQNCj4gPiBkZXYsDQo+ID4gPiArICAg
IHN0cnVjdCBnaWNfaW50Y19vcmdhdGVfaW5mbyAqb3JnYXRlX2luZm8pIHsNCj4gPiA+ICsgICAg
QXNwZWVkU29DQ2xhc3MgKnNjID0gQVNQRUVEX1NPQ19HRVRfQ0xBU1Mocyk7DQo+ID4gPiArICAg
IGludCBpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShh
c3BlZWRfc29jX2FzdDI3MDBfZ2ljX2ludGNtYXApOyBpKyspIHsNCj4gPiA+ICsgICAgICAgIGlm
IChzYy0+aXJxbWFwW2Rldl0gPT0gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW2ldLmly
cSkNCj4gew0KPiA+ID4gKyAgICAgICAgICAgIGFzc2VydChhc3BlZWRfc29jX2FzdDI3MDBfZ2lj
X2ludGNtYXBbaV0ucHRyKTsNCj4gPiA+ICsgICAgICAgICAgICBvcmdhdGVfaW5mby0+aW5kZXgg
PSBpOw0KPiA+ID4gKyAgICAgICAgICAgIG9yZ2F0ZV9pbmZvLT5pbnRfbnVtID0NCj4gPiBhc3Bl
ZWRfc29jX2FzdDI3MDBfZ2ljX2ludGNtYXBbaV0ucHRyW2Rldl07DQo+ID4gPiArICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ID4gKyAgICAgICAgfQ0KPiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4g
PiArICAgIC8qDQo+ID4gPiArICAgICAqIEludmFsaWQgb3JnYXRlIGluZGV4LCBkZXZpY2UgaXJx
IHNob3VsZCBiZSAxMjggdG8gMTM2Lg0KPiA+ID4gKyAgICAgKi8NCj4gPiA+ICsgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsNCj4gPiA+ICt9DQo+ID4NCj4gPg0KPiA+IFRoaXMgbG9va3MgcmVk
dW5kYW50LiBDb3VsZG4ndCB3ZSBleHRlbmQgYXNwZWVkX3NvY19hc3QyNzAwX2dldF9pcnEoKQ0K
PiA+IHdpdGggYW4gaW5kZXggcGFyYW1ldGVyIGluc3RlYWQgPw0KPiA+DQo+DQo+IFRoYW5rcyBm
b3IgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KPg0KPiBBY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQg
ZGVzaWduIG9mIGFzcGVlZF9zb2NfZ2V0X2lycSwgdGhlIGZ1bmN0aW9uIHR5cGUgb2YNCj4gZ2V0
X2lycSBjYWxsYmFjayBmdW5jdGlvbiBzaG91bGQgYmUgWFhYKEFzcGVlZFNvQ1N0YXRlICpzLCBp
bnQgZGV2KQ0KPg0KPiBxZW11X2lycSBhc3BlZWRfc29jX2dldF9pcnEoQXNwZWVkU29DU3RhdGUg
KnMsIGludCBkZXYpIHsNCj4gICAgIHJldHVybiBBU1BFRURfU09DX0dFVF9DTEFTUyhzKS0+Z2V0
X2lycShzLCBkZXYpOyB9DQo+DQo+IHN0cnVjdCBBc3BlZWRTb0NDbGFzcyB7DQo+ICAgICBxZW11
X2lycSAoKmdldF9pcnEpKEFzcGVlZFNvQ1N0YXRlICpzLCBpbnQgZGV2KTsgfQ0KPg0KPiBJZiB3
ZSB3YW50IHRvIGFkZCBhIG5ldyBpbmRleCBwYXJhbWV0ZXIgaW4gYXNwZWVkX3NvY19hc3QyNzAw
X2dldF9pcnEsIEkNCj4gd2lsbCBjaGFuZ2UgYXMgZm9sbG93aW5nLg0KPiAxLg0KPiBzdGF0aWMg
cWVtdV9pcnEgYXNwZWVkX3NvY19hc3QyNzAwX2dldF9pcnEoQXNwZWVkU29DU3RhdGUgKnMsIGlu
dCBkZXYsIGludA0KPiBpbmRleCkgew0KPiAgICAgQXNwZWVkMjd4MFNvQ1N0YXRlICphID0gQVNQ
RUVEMjdYMF9TT0Mocyk7DQo+ICAgICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0dF
VF9DTEFTUyhzKTsNCj4gICAgIGludCBpOw0KPg0KPiAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwKTsgaSsrKSB7DQo+ICAgICAgICAg
aWYgKHNjLT5pcnFtYXBbZGV2XSA9PSBhc3BlZWRfc29jX2FzdDI3MDBfZ2ljX2ludGNtYXBbaV0u
aXJxKSB7DQo+ICAgICAgICAgICAgIGFzc2VydChhc3BlZWRfc29jX2FzdDI3MDBfZ2ljX2ludGNt
YXBbaV0ucHRyKTsNCj4gICAgICAgICAgICAgcmV0dXJuIHFkZXZfZ2V0X2dwaW9faW4oREVWSUNF
KCZhLT5pbnRjLm9yZ2F0ZXNbaV0pLA0KPiAgICAgICAgICAgICAgICAgYXNwZWVkX3NvY19hc3Qy
NzAwX2dpY19pbnRjbWFwW2ldLnB0cltkZXZdICsgaW5kZXgpOw0KPiAgICAgICAgIH0NCj4gICAg
IH0NCj4NCj4gICAgIHJldHVybiBxZGV2X2dldF9ncGlvX2luKERFVklDRSgmYS0+Z2ljKSwgc2Mt
PmlycW1hcFtkZXZdKTsgfQ0KPg0KPiAyLiBpbnRyb2R1Y2UgYSBuZXcgZ2V0X2lycV9pbmRleCBm
dW5jdGlvbiBwb2ludGVyIGFuZCB0aGUgZnVuY3Rpb24gdHlwZSBvZiB0aGlzDQo+IGNhbGxiYWNr
IGZ1bmN0aW9uIGFzIGZvbGxvd2luZy4NCj4gc3RydWN0IEFzcGVlZFNvQ0NsYXNzIHsNCj4gICAg
cWVtdV9pcnFfaW5kZXggKCpnZXRfaXJxKShBc3BlZWRTb0NTdGF0ZSAqcywgaW50IGRldiwgaW50
IGluZGV4KTsgfQ0KPg0KcWVtdV9pcnEgKCpnZXRfaXJxX2luZGV4KShBc3BlZWRTb0NTdGF0ZSAq
cywgaW50IGRldiwgaW50IGluZGV4KTsNCg0KDQozLiBBZGQgYXNwZWVkX3NvY19nZXRfaXJxX2lu
ZGV4DQpxZW11X2lycSBhc3BlZWRfc29jX2dldF9pcnFfaW5kZXgoQXNwZWVkU29DU3RhdGUgKnMs
IGludCBkZXYsIGludCBpbmRleCkNCnsNCiAgICByZXR1cm4gQVNQRUVEX1NPQ19HRVRfQ0xBU1Mo
cyktPmdldF9pcnFfaW5kZXgocywgZGV2LCBpbmRleCk7DQp9DQoNCjQuIEkgbmVlZCB0byBtb2Rp
ZnkgdGhpcyBmdW5jdGlvbiwgdG9vDQpib29sIGFzcGVlZF9zb2NfdWFydF9yZWFsaXplKEFzcGVl
ZFNvQ1N0YXRlICpzLCBFcnJvciAqKmVycnApDQp7DQogc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19C
VVNfREVWSUNFKHNtbSksIDAsIGFzcGVlZF9zb2NfZ2V0X2lycShzLCB1YXJ0KSk7DQp9DQoNClRo
YW5rcy1KYW1pbg0KPiBEbyB5b3UgaGF2ZSBhbnkgY29uY2VybiBvciBjb3VsZCB5b3UgcGxlYXNl
IGdpdmUgbWUgYW55IHN1Z2dlc3Rpb24/DQo+IFRoYW5rcy1KYW1pbg0KPg0KPg0KPiA+IFRoYW5r
cywNCj4gPg0KPiA+IEMuDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiA+ICAgc3RhdGljIHVpbnQ2
NF90IGFzcGVlZF9yYW1fY2FwYWNpdHlfcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLA0K
PiA+ID4NCj4gdW5zaWduZWQNCj4gPiBpbnQgc2l6ZSkNCj4gPiA+ICAgew0KDQoqKioqKioqKioq
KioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNCuWF
jeiyrOiBsuaYjjoNCuacrOS/oeS7tijmiJblhbbpmYTku7Yp5Y+v6IO95YyF5ZCr5qmf5a+G6LOH
6KiK77yM5Lim5Y+X5rOV5b6L5L+d6K2344CC5aaCIOWPsOerr+mdnuaMh+WumuS5i+aUtuS7tuiA
he+8jOiri+S7pembu+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7tuS5i+eZvOmAgeiAhSwg
5Lim6KuL56uL5Y2z5Yiq6Zmk5pys6Zu75a2Q6YO15Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA
5pyJ6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI5L2cIQ0KDQpESVNDTEFJTUVSOg0KVGhpcyBt
ZXNzYWdlIChhbmQgYW55IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBsZWdhbGx5IHByaXZpbGVn
ZWQgYW5kL29yIG90aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVj
ZWl2ZWQgaXQgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1h
aWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
d2l0aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5b3UuDQo=

