Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A233D232C9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6O9-0002TX-R2; Fri, 09 Jan 2026 01:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve6O7-0002R8-60; Fri, 09 Jan 2026 01:54:23 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve6O4-0002HO-Qt; Fri, 09 Jan 2026 01:54:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alMFil14DGMHlvGku/2x0b+UcZXp/gzi10QdXcJ1CtA7E5whbTUzjBVfjH2G1IlsAVaCpF9AZAlDR7QVzGvDXYrs60RnxAEBf96bpph92S8vt+65EH216C0mgnkwAb5ewFdj4mPQUXCLk9Vr4ks1/b1IJXQ9FS7spwV96xJ3IR7SnVBoKbV1ONR4N5x4Nkd4lTrPMkIuopA90ohDiQtXYc/2WeuY1gHyTTqasjPmKM++rm1LZvKc7xGvLtR1DOXuMtf2e1TAtEX+gXvewyKD+0+wluIbAj213SA8falSN/Qm0PTEAgBQ55TGE/gR+n3R5nBPjjEkYC3SuznxTN0wKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pNxe3FrI5469MF/qcGg+JJQ52gAykpelttN93xOE6Y=;
 b=E1hbUZC7U92SS3fzTXIGbmCvZvgUSDm/kXFUUioCfKUyrrU2gbUeoCO6Mrbb61XfJlFE/ivltd0qD5fN50md8Kc5e47wnSj7wB2iAA9Aw4SZ+K0I0bs5KmmrDIcZ0Mw/2/7JlxbuV/43koovzufShKOObVG+sMg556IZ/TB+oFPQW0b/P9CeTNqBIq+ejZJbeyBxL/5lUICGFwsDJd9w5p7s4ttb2kSiioyj4Tb1ulxFEd9ACcJGgUVuu7XufrwVswXreKa+GlJOiJJWjpUkLwSoEtMcQGj29IdDKkXLB0ASQWA0TWQBhjA8yuEi6Y8zN5VRmtFM9uWYmUeAGn8lFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pNxe3FrI5469MF/qcGg+JJQ52gAykpelttN93xOE6Y=;
 b=h045WlhhCSpi32wTiViighOeab+6Jzx2UGiSVRLACXEBNYqrv2TWcqWFfW1cbD9lBQIX8+603WPtGtFiMXilPu2yyRzmNwK2feuwDz2mHuHDTB9/pioigcE006qUilpWkCi1/j+bsSlC8l72rTwOGS5U9XISlFWb9E+xJCH5udP3QbLc2IhNdVsbdlwNQkXrzG7LM0zqxkNvqby/QrmjoBCkkl0HqJMUoQZEWtJ+q+PmYbjyQoRzIoa68YoX9nDydvTyNtl9AUcpD43AHKC+Z3D0f/ajvulMziaMX5r0iqG1GMKnrohos8fxvGYXFMy1emUjg6RhuinC7+XxeBWINA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5962.apcprd06.prod.outlook.com (2603:1096:101:d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 06:54:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 06:54:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 08/19] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH 08/19] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHb2/a69N6iv3Qb+UW2cpzsiRhITrVEby+QgAZB9lA=
Date: Fri, 9 Jan 2026 06:54:15 +0000
Message-ID: <TYPPR06MB82064506083FBDA950160A0CFC82A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-9-komlodi@google.com>
 <TYPPR06MB82060801EFF3D85E695284EFFC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB82060801EFF3D85E695284EFFC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5962:EE_
x-ms-office365-filtering-correlation-id: 3c09b7f8-18dc-4da6-1ede-08de4f4be74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QzZPdDZiT1NGaFJlbUlBbXRjYThtSWZqanBHek9kZVpNYnhoTllNNWlwUnVo?=
 =?utf-8?B?bjlQeVE4TWdGODFuWXo4Y0xwU25nNkJIYWRKby84MTBrOVdzamRJUCs3b2dZ?=
 =?utf-8?B?d21XenFERzlEVXdVYWxWZEREanF5TTBqaFhBYTNjODVOT0Y2UEJtZENXZENG?=
 =?utf-8?B?VWhDQzBFRGdaQmRRdW1tbk11Mi8zbXZLM0lmNk5zYkRxVjREOWFVMVdCNUlO?=
 =?utf-8?B?alZWVnI0K1RIQ08wUnJQMVZoVEJwWUxpdFVWekVERnY2U0xtTW1jc1loOVUy?=
 =?utf-8?B?SnFPc1FscVZ4RndVdTRKbWd2Q29JUXVLeU5ta21tamgvQk9WaWZoc3A3Z1F2?=
 =?utf-8?B?aUxlYzJkdHZYSzhXWEJaZVhsdEV0VmRkSHVieTRUbktPY0ZYZDhvWWlVNmJE?=
 =?utf-8?B?TGpJNmQwWTdDV3dZaitsYXNKYmJ1WjZVVlFBSk1xVEkyTkxsWnRPMURCTEM0?=
 =?utf-8?B?cElFWFdnN2kraUd2S053bllFU1ltNGhkTmF5cDFuVXBydzJjMUhIYkRtemVX?=
 =?utf-8?B?NU8xSGVJS0wxVnNZSUh2T1NFcElkQ0tWNmtzZGlxOWlOckxvT2I2Q3FlWTJa?=
 =?utf-8?B?YWpEek1IUE1UUlFMUXE0REthK2JQalZQU05QNU91Z25yOGd0eUZ4QUp0WkJB?=
 =?utf-8?B?dzk1SWlqVVRvbnNMVXZxcE11YUdTZU93bkxWREJRcTB6WE81b2toYjBpcGY5?=
 =?utf-8?B?Mk85WlcyV0crWUNKZ0plVjJCY1MvdnZvLzFvemgzbC9DSVBaU1lobklDcXRG?=
 =?utf-8?B?NWpxQnRhcWFLM2VsSjNObU4zNkpzU2I4QjlwTzY0QXBaUFNTOU55dGlkUUYx?=
 =?utf-8?B?WXZUbDRSTmNqU29zSERXYXZDNEF3RWt4KytGRHhDSTFjWi9WZnZXVzh2YnZD?=
 =?utf-8?B?bHVOa2FRbjB0ZXVham11WWdtM1NJaGRtTGNCRWJ2cHhiSVdGbFVEaEc5Lzk4?=
 =?utf-8?B?Wm5NVTJyZzhLQUNUOEZENkE4c0N6cHJSSE9UcGRKbmluSjM4NFVSUmZhOVlu?=
 =?utf-8?B?b29tVGgrS1lZak9oU2JNc1hRYVg1QzdSdmJrRkwydERZMHBwL2pmMkZMeDkx?=
 =?utf-8?B?QnBDb1pIQzJWc0J6MXM1aFV3SzhDdkM1ZVNrVGVtOUc4Y3Fkb0pCcUxHR2xk?=
 =?utf-8?B?ZUVQZXlZQ0ZjUkpkdTl6OUxOU3VocFRCNzJoR0FPSGtFckh2enoyeWs0cFBw?=
 =?utf-8?B?YXhnMWZXY3NqMHZnN3lTR1kvM1ZXUTFMODAzR3pjQ3FyS1B1eHZpQThBM1RN?=
 =?utf-8?B?WmhpdzhuSkIzMXBIYVVHSkhyM1pNYTVBS3gvanhzeGFVeUtFbHdkV2hnM0dt?=
 =?utf-8?B?c0RKanNMSmwxUTJMZEYrcFRraUErbGJsTjNQSWl4bXpmbVp5ODNhT1RNVFY2?=
 =?utf-8?B?cW9lRWFGOGdSMmg1eExYU05pd2haL0dHTm9iV1pUTmpwci93RXhxMFhMN3lI?=
 =?utf-8?B?M0VmRUx2NGdoOEtpaE1oYTZNK24zMGt2dXRyYUxldllqYUREOFJ4U0xxNzQy?=
 =?utf-8?B?NTF3RmpGVjRDRlUybE9iL3FzUFJPUllkcXFOcjZxV24zVjFMaG9IV1YzeE5Z?=
 =?utf-8?B?ZXAvVG5xdFBRNmx2d3lCcXBwMmY2cnFRWFFFU1lmVGphYXFSWUpwTVo4WkpW?=
 =?utf-8?B?Qk9PR3JseDF6Zy9INUxTbXNlUVlvS1B2QkJ0OWlaU2d3N095cjRMV1RUQy9t?=
 =?utf-8?B?QnRSRkJaRCtuTG16MFZYSVkxUWZ3QnZXZXFBV1hLTldhT1Yrc1QrZVRYZTN6?=
 =?utf-8?B?NTVESjM1WWRLVEpwQVhkWmNrU01PYkFrQ0JOU3pZVnVBRWE2RTQzcWRSZzlS?=
 =?utf-8?B?cW9GZElJaFRPNFRnRWhkcDBQdWFsOXVYZ1E4Z1k0c3c2Y3JYV21Va2NOb0Qz?=
 =?utf-8?B?aTVqWFpvWVVDMVNySEpFZHkxczFOTGh0Y3pqUDhQUGttRVRhYkh5NHFUNGJI?=
 =?utf-8?B?QjJJcTZyQWxlNnY4RExldm9IRW1SZSt5SFEveG96bk83S3BMd3ZtS2JOV3hU?=
 =?utf-8?B?VXY5cTdUcHRJUEYvak1IaHlXUmlraTdqT3RhdjhvcVhkVFRqVjdXQ3F6dDZX?=
 =?utf-8?Q?WD57Ny?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlgvSHdmbzIvcHlSM0l4Y3l6TXNSSlJydkJUMmtLOFdSWjduN1NGRFluYS9t?=
 =?utf-8?B?RWY3RXpreSt4bEVaNVlwRmIrNXZCKzdlMVRoTU1TaUVBWmIzcmF1RWltK0ZI?=
 =?utf-8?B?akJ4SmJaSWNZSVRPRlhSa0NmbkRDZUZINmpzbTFEcUdsaVZmaGlhNk1WUWxI?=
 =?utf-8?B?bnNBY0NXcHFZWUdLbGdmbloxWTdGb0N2a0RQMVhmdGd0T1Y3cURacjBwSHRE?=
 =?utf-8?B?SUlDdEVUd0tURlQwUnplOERCaHo0Rlo4S2tySzQreGg4SjFXWVRTamJDbnpk?=
 =?utf-8?B?SVQvdkV4c0lHdUs3NWlneEhWb0J1OXNmU1lkMkZRMTNNVE9sRTdBUHlmN1FL?=
 =?utf-8?B?RjBCeGZpeHMvdWJIMDMyU3Uvamd1Rk9zSWdVaDA0dzZrMGw5TFFlNjduUHU2?=
 =?utf-8?B?TWFDWDlGMFpHaEVybmpWcmhUU1VZdzhMS3Q4Y0RWcGMwY1NxMmlWL3Y4cWlO?=
 =?utf-8?B?dHFHekczY2orM0h4UE1KNEVtZmM5ajlHWTUydDBELzNvekc2S1BtZVhicmdi?=
 =?utf-8?B?UGl3REUzUnJvR0hBN2IxdHNrblVLSHBYblY4YUZwSGRuNWdyd0dxTDI1Zk1h?=
 =?utf-8?B?YmVvTERkb0J3UnF6bWowUm16VmliUHJrUUVjOXpsc3RiVTBCdUkybE55NzJl?=
 =?utf-8?B?aHFVSFY3QTEvRjhrRlZmenVCby83MGJvR0lqYitCeTdMb3NjaHprcjJCbERT?=
 =?utf-8?B?dzRyZkF2RGtpQUpWTnZxT3h0Y2NlR01CZkprOXNjVDVwdHBsVFJBeHFtUFc3?=
 =?utf-8?B?U0h6WDFab1JucnVYNkxDMmhQVEN1SzdudC82Mk0vS0JLcXlMK1FTY21HRkNq?=
 =?utf-8?B?U2RwZlhXNkgvOUIzamtmdStKVkNqRzAzSnQ5bXhLM0plQytrQVZXbUVqTjNj?=
 =?utf-8?B?QWdMcElvSFZmZXdFbmt1WFhIVEc4MFJmV0dUcVNGOVhRQnREeEswMFBReC9k?=
 =?utf-8?B?NDRDL0NFZHhzdkpySFZpSzExOHUwQ0JBZURacFUzU0lUSXpFYzQva3FRSllv?=
 =?utf-8?B?c0N6ZWk2YkVkSUlTVWtzeU9LTmNFYS8wclpYR1ZESWFoRG1wd29tVTl2dzVM?=
 =?utf-8?B?QjRCcitRUktHdlAySGE3aFlVTE9HdjBBWmxoWkZEOGRadFJaUXY0UkdQR256?=
 =?utf-8?B?Vk53bmxpTjA0Ykp5clhid3Q4RmJnQUJLNmh5b203bC92UHRodVJqOWlBdE5Q?=
 =?utf-8?B?MWd5MTJVRm1QZ0EyWGc0V1U3ZExBa1U1d0FXeVlvOWd3SitnRGdRRjd2Z3Bs?=
 =?utf-8?B?OGY1ejNDUGR0V0lHaWNFbi90Z3c3aERWR255Q1pBQmh2d2ppbGE1VW9wbUxH?=
 =?utf-8?B?ekowR0ZsZGZ6dFA0TEJUVC8xY3JQYzN6SG9kSEN2UVFFNlVxY0VKZEgrNjd6?=
 =?utf-8?B?VTZJaFp1Ung4cFh5UCtJT1EzV2FLN0VJUGpUVlAzaEp0ZGhDenVGWU1nd3po?=
 =?utf-8?B?bGxkSWpYbUpWOFZqSU9PVFdHNlRJa2VnY0dBd0lzckRiQXVaNnVZTjQrZVlB?=
 =?utf-8?B?anF6eEFDZ1NicjYzODhhcDdwelMwRUJ4cm14VlhNMXA4ckVYSWswbjJJeWZC?=
 =?utf-8?B?bEpLYWd6SEpKMXZNSkpwQWEyMSs4N0RXYTNkc0RrUzI1V3pyUk1aS2h6VGlU?=
 =?utf-8?B?dUJVdEJHVFZMeUJYaUwrdDhGM2FDTHZJWmFlZFpqTGxUTUJTc0ZHYzNQeGtn?=
 =?utf-8?B?eUtHYVdxbWk1SDdFYlE4K0JocDJTUXltY0N1R21NRjFaUnFuV0QveDBuV1E4?=
 =?utf-8?B?ZGQrQkVLOU51U2YvN1FzNTFMaHNTOFZOZDl0SkR6UVczc1Y5eVI4eUJCZmll?=
 =?utf-8?B?UDRPVFJyU1BzYm5LTmpOSXVGUy83QUhZeGU5M0hZL1plWFZwaGp0QkZkdVQv?=
 =?utf-8?B?S0QzcjVwSm12cWxZUGcvWGNSNW1JNWdCVUN2WW0yTzVTbGp6YmgzTGdqWTBu?=
 =?utf-8?B?bEI4bGozZi9tWGE3K1ZVUTZUNkREQ2NEZ3Zmck9GWFJ6eFRyaWlWam5Kcndw?=
 =?utf-8?B?WUkvQUliQ09TWXpDOW9JVEUyOVBvVjNsY2cyUmZYVjNHU0JUejNMelh3RlIv?=
 =?utf-8?B?YklLQlIrL3VPVTZHNHVzSVFVd0tJUjFNL1Uxb1RPNDFLVmpHNTJKTDFxazhn?=
 =?utf-8?B?d1BwMkNpbnZwWkxBOXhheHV2NkdPNDdITlZ3TzFLRU9GWGlJYkV4WXpTQkpr?=
 =?utf-8?B?cmtVOVNIejlxbk9tRmtpL28zVGVXSlZFNHd3TTMxeDlwTVg1K2gzelVHZjlD?=
 =?utf-8?B?d0hwWEk5MHkxb1lsR2ZsOHFQalBpQkF0d1BpZFF0eTZuZWc1WksrVEplVTF3?=
 =?utf-8?B?bC9yRnYyQkR6aktpYlIwa0tXc2t5UjhZMityKy84ZURGdVBodXNBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c09b7f8-18dc-4da6-1ede-08de4f4be74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 06:54:15.4878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a42pGlVSoGCkBxd/OfFuhDBwL94yuK6GwxB3Xb5AfYO6UZxWhq1BLFNJDmFNDRzf+Yh8tgy6TyS6+Aup91JjPDCaL6+34YaeVld4Pv8Jy8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5962
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgSm9lLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDgvMTldIGh3L2kzYy9kdy1pM2M6IEFk
ZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiANCj4gSGkgSm9lLA0KPiANCj4gPiBTdWJqZWN0
OiBbUEFUQ0ggMDgvMTldIGh3L2kzYy9kdy1pM2M6IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNr
cw0KPiA+DQo+ID4gQWRkcyByZWFkLW9ubHkgcmVnaXN0ZXIgbWFza3MgZm9yIHRoZSBEd0MgSTND
IGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2UgS29tbG9kaSA8a29tbG9k
aUBnb29nbGUuY29tPg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFBhdHJpY2sgVmVudHVyZSA8dmVu
dHVyZUBnb29nbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9pM2MvZHctaTNjLmMgfCA0MCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA0MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTNjL2R3LWkzYy5j
IGIvaHcvaTNjL2R3LWkzYy5jIGluZGV4DQo+ID4gODQ1ZmJkNWVmZC4uNGY0MGY5OTlmNA0KPiA+
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kzYy9kdy1pM2MuYw0KPiA+ICsrKyBiL2h3L2kzYy9kdy1p
M2MuYw0KPiA+IEBAIC0zMTMsNiArMzEzLDQ1IEBAIHN0YXRpYyBjb25zdCB1aW50MzJfdA0KPiA+
IGR3X2kzY19yZXNldHNbRFdfSTNDX05SX1JFR1NdID0gew0KPiA+ICAgICAgW1JfU0xBVkVfQ09O
RklHXSAgICAgICAgICAgICAgICA9IDB4MDAwMDAwMjMsDQo+ID4gIH07DQo+ID4NCj4gPiArc3Rh
dGljIGNvbnN0IHVpbnQzMl90IGR3X2kzY19yb1tEV19JM0NfTlJfUkVHU10gPSB7DQo+ID4gKyAg
ICBbUl9ERVZJQ0VfQ1RSTF0gICAgICAgICAgICAgICAgID0gMHgwNGZmZmUwMCwNCj4gPiArICAg
IFtSX0RFVklDRV9BRERSXSAgICAgICAgICAgICAgICAgPSAweDdmODA3ZjgwLA0KPiA+ICsgICAg
W1JfSFdfQ0FQQUJJTElUWV0gICAgICAgICAgICAgICA9IDB4ZmZmZmZmZmYsDQo+ID4gKyAgICBb
Ul9JQklfUVVFVUVfU1RBVFVTXSAgICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gPiArICAgIFtS
X0RBVEFfQlVGRkVSX1RITERfQ1RSTF0gICAgICAgPSAweGY4ZjhmOGY4LA0KPiA+ICsgICAgW1Jf
SUJJX1FVRVVFX0NUUkxdICAgICAgICAgICAgICA9IDB4ZmZmZmZmZjAsDQo+ID4gKyAgICBbUl9S
RVNFVF9DVFJMXSAgICAgICAgICAgICAgICAgID0gMHhmZmZmZmZjMCwNCj4gPiArICAgIFtSX1NM
Vl9FVkVOVF9DVFJMXSAgICAgICAgICAgICAgPSAweGZmZmZmZjNmLA0KPiA+ICsgICAgW1JfSU5U
Ul9TVEFUVVNdICAgICAgICAgICAgICAgICA9IDB4ZmZmZjgwOWYsDQo+ID4gKyAgICBbUl9JTlRS
X1NUQVRVU19FTl0gICAgICAgICAgICAgID0gMHhmZmZmODA4MCwNCj4gPiArICAgIFtSX0lOVFJf
U0lHTkFMX0VOXSAgICAgICAgICAgICAgPSAweGZmZmY4MDgwLA0KPiA+ICsgICAgW1JfSU5UUl9G
T1JDRV0gICAgICAgICAgICAgICAgICA9IDB4ZmZmZjgwMDAsDQo+ID4gKyAgICBbUl9RVUVVRV9T
VEFUVVNfTEVWRUxdICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gPiArICAgIFtSX0RBVEFfQlVG
RkVSX1NUQVRVU19MRVZFTF0gICAgPSAweGZmZmZmZmZmLA0KPiA+ICsgICAgW1JfUFJFU0VOVF9T
VEFURV0gICAgICAgICAgICAgICA9IDB4ZmZmZmZmZmYsDQo+ID4gKyAgICBbUl9DQ0NfREVWSUNF
X1NUQVRVU10gICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gPiArICAgIFtSX0kzQ19WRVJfSURd
ICAgICAgICAgICAgICAgICAgPSAweGZmZmZmZmZmLA0KPiA+ICsgICAgW1JfSTNDX1ZFUl9UWVBF
XSAgICAgICAgICAgICAgICA9IDB4ZmZmZmZmZmYsDQo+ID4gKyAgICBbUl9ERVZJQ0VfQUREUl9U
QUJMRV9QT0lOVEVSXSAgID0gMHhmZmZmZmZmZiwNCj4gPiArICAgIFtSX0RFVl9DSEFSX1RBQkxF
X1BPSU5URVJdICAgICAgPSAweGZmY2JmZmZmLA0KPiA+ICsgICAgW1JfU0xWX1BJRF9WQUxVRV0g
ICAgICAgICAgICAgICA9IDB4ZmZmZjBmZmYsDQo+ID4gKyAgICBbUl9TTFZfQ0hBUl9DVFJMXSAg
ICAgICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gPiArICAgIFtBX1ZFTkRPUl9TUEVDSUZJQ19S
RUdfUE9JTlRFUl0gPSAweGZmZmZmZmZmLA0KPiA+ICsgICAgW1JfU0xWX01BWF9MRU5dICAgICAg
ICAgICAgICAgICA9IDB4ZmZmZmZmZmYsDQo+ID4gKyAgICBbUl9NQVhfUkVBRF9UVVJOQVJPVU5E
XSAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gPiArICAgIFtSX01BWF9EQVRBX1NQRUVEXSAgICAg
ICAgICAgICAgPSAweGZmZmZmZmZmLA0KPiA+ICsgICAgW1JfU0xWX0lOVFJfUkVRXSAgICAgICAg
ICAgICAgICA9IDB4ZmZmZmZmZjAsDQo+ID4gKyAgICBbUl9TTFZfVFNYX1NZTUJMX1RJTUlOR10g
ICAgICAgID0gMHhmZmZmZmZjMCwNCkkgZG9u4oCZdCBzZWUgdGhpcyByZWdpc3RlciBkZWZpbmVk
IGluIHRoZSBkYXRhc2hlZXQuDQpXaGljaCBkb2N1bWVudCBhcmUgeW91IHJlZmVyZW5jaW5nIGZv
ciB0aGlzIG1lbWJlcj8NCg0KPiA+ICsgICAgW1JfREVWSUNFX0NUUkxfRVhURU5ERURdICAgICAg
ICA9IDB4ZmZmZmZmZjgsDQo+ID4gKyAgICBbUl9TQ0xfSTNDX09EX1RJTUlOR10gICAgICAgICAg
ID0gMHhmZjAwZmYwMCwNCj4gPiArICAgIFtSX1NDTF9JM0NfUFBfVElNSU5HXSAgICAgICAgICAg
PSAweGZmMDBmZjAwLA0KPiA+ICsgICAgW1JfU0NMX0kyQ19GTVBfVElNSU5HXSAgICAgICAgICA9
IDB4ZmYwMDAwMDAsDQo+ID4gKyAgICBbUl9TQ0xfRVhUX1RFUk1OX0xDTlRfVElNSU5HXSAgID0g
MHgwMDAwZmZmMCwNCj4gPiArICAgIFtSX0JVU19JRExFX1RJTUlOR10gICAgICAgICAgICAgPSAw
eGZmZjAwMDAwLA0KPiA+ICsgICAgW1JfRVhURU5ERURfQ0FQQUJJTElUWV0gICAgICAgICA9IDB4
ZmZmZmZmZmYsDQpJIGRvbuKAmXQgc2VlIHRoaXMgcmVnaXN0ZXIgZGVmaW5lZCBpbiB0aGUgZGF0
YXNoZWV0Lg0KV2hpY2ggZG9jdW1lbnQgYXJlIHlvdSByZWZlcmVuY2luZyBmb3IgdGhpcyBtZW1i
ZXI/DQoNCj4gPiArICAgIFtSX1NMQVZFX0NPTkZJR10gICAgICAgICAgICAgICAgPSAweGZmZmZm
ZmZmLA0KDQpJIGRvbuKAmXQgc2VlIHRoaXMgcmVnaXN0ZXIgZGVmaW5lZCBpbiB0aGUgZGF0YXNo
ZWV0Lg0KV2hpY2ggZG9jdW1lbnQgYXJlIHlvdSByZWZlcmVuY2luZyBmb3IgdGhpcyBtZW1iZXI/
DQoNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyB1aW50NjRfdCBkd19pM2NfcmVhZCh2b2lk
ICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsIHVuc2lnbmVkIHNpemUpDQo+IHsNCj4gPiAgICAgIERX
STNDICpzID0gRFdfSTNDKG9wYXF1ZSk7DQo+ID4gQEAgLTM0MSw2ICszODAsNyBAQCBzdGF0aWMg
dm9pZCBkd19pM2Nfd3JpdGUodm9pZCAqb3BhcXVlLCBod2FkZHINCj4gPiBvZmZzZXQsIHVpbnQ2
NF90IHZhbHVlLA0KPiA+DQo+ID4gICAgICB0cmFjZV9kd19pM2Nfd3JpdGUocy0+aWQsIG9mZnNl
dCwgdmFsdWUpOw0KPiA+DQo+ID4gKyAgICB2YWx1ZSAmPSB+ZHdfaTNjX3JvW2FkZHJdOw0KPiA+
ICAgICAgc3dpdGNoIChhZGRyKSB7DQo+IA0KPiBUaGUgZm9sbG93aW5nIHJlZ2lzdGVycyBhcmUg
cmVhZC1vbmx5LCBhbmQgdGhlIGNvZGUgYWxyZWFkeSBjaGVja3MgdGhlaXIgYWNjZXNzDQo+IGJh
c2VkIHNvbGVseSBvbiB0aGUgcmVnaXN0ZXIgYWRkcmVzcy4NCj4gV2h5IGRvIHdlIHN0aWxsIG5l
ZWQgdG8gZGVmaW5lIHRoZW0gaW4gZHdfaTNjX3JvPw0KPiANCj4gICAgIGNhc2UgUl9IV19DQVBB
QklMSVRZOg0KPiAgICAgY2FzZSBSX1JFU1BPTlNFX1FVRVVFX1BPUlQ6DQo+ICAgICBjYXNlIFJf
SUJJX1FVRVVFX0RBVEE6DQo+ICAgICBjYXNlIFJfUVVFVUVfU1RBVFVTX0xFVkVMOg0KPiAgICAg
Y2FzZSBSX1BSRVNFTlRfU1RBVEU6DQo+ICAgICBjYXNlIFJfQ0NDX0RFVklDRV9TVEFUVVM6DQo+
ICAgICBjYXNlIFJfREVWSUNFX0FERFJfVEFCTEVfUE9JTlRFUjoNCj4gICAgIGNhc2UgUl9WRU5E
T1JfU1BFQ0lGSUNfUkVHX1BPSU5URVI6DQo+ICAgICBjYXNlIFJfU0xWX0NIQVJfQ1RSTDoNCj4g
ICAgIGNhc2UgUl9TTFZfTUFYX0xFTjoNCj4gICAgIGNhc2UgUl9NQVhfUkVBRF9UVVJOQVJPVU5E
Og0KPiAgICAgY2FzZSBSX0kzQ19WRVJfSUQ6DQo+ICAgICBjYXNlIFJfSTNDX1ZFUl9UWVBFOg0K
PiAgICAgY2FzZSBSX0VYVEVOREVEX0NBUEFCSUxJVFk6DQo+IA0KPiBUaGFua3MtSmFtaW4NCj4g
DQo+ID4gICAgICBjYXNlIFJfSFdfQ0FQQUJJTElUWToNCj4gPiAgICAgIGNhc2UgUl9SRVNQT05T
RV9RVUVVRV9QT1JUOg0KPiA+IC0tDQo+ID4gMi41MC4wLnJjMS41OTEuZzljOTVmMTdmNjQtZ29v
Zw0KDQo=

