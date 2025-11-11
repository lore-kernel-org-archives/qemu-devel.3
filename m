Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EE9CCFA13
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 01:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIdQ1-0000f0-7y; Mon, 10 Nov 2025 20:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIdPc-0000Xk-P5; Mon, 10 Nov 2025 20:43:19 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIdPX-0007lp-L6; Mon, 10 Nov 2025 20:43:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVOxPJK63/DbWww+pNLHyq4hs2Xv1zqaVEHnExkqxru89drRvHG16Bx0/jqCCjazlVfGgkRZHn/7UgmMLWYubS9G+l5X0lMK9Cmv9rlVnRbJABy9Kl2RaJS5P8lWC6KWpDqc85Ic80oHau+ivChHU7NZmNUYxSzLMI0yJTCJ37gNIJf8V8BVB77y/lsRsurj1XYq1LbMj8lSVUIYJ7eKC79wp+jTq1ED0pkcajRoyj50H61IxG8pUEbJgtrgmVFgkxZprdZUBtTL1zNLGVd6ymvZuVyO5m5N8fN2Yjv/1+YU07QSC9E50H8ZP8fcz3I815eiCIk2/8AApenu/iluug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XhDNPXsFFvesozE7MKks8jvyZlJYBPfyj/mM5nzyBM=;
 b=iYTVdTBqX0vK/Bdda4HYX0Gl5fM/A0TbHAT6uQvQt0ROD3wnVZz00n6drt8cLLKf0bQvt/LwkgU+UP+zPWG6nl1n7ojPABSm5po812bn8/u/1hHS8EXEyY6pP5yyFmM3cAIJAcM6J9+9oK+vC+PfwuCdjemPsExw37soaYRmTMoh4up3xyc6qd/0uYsOUK54OnPQuisnlCGbBSyqtrbBrpg7gpMHab8ltVqlKMkAOJsB0MNSQPvifHnQdDfaYoaoIYkMjXdku/WQBBzl4unyZ1Yd62JlYC8eK5SWAe/PB26S9A32FGvekwyvKYcc1bwxgj64HBrol/mTRn7seNpdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XhDNPXsFFvesozE7MKks8jvyZlJYBPfyj/mM5nzyBM=;
 b=CBMlVlL4t76FTgSBuvWqI+DesSYvCT9rqZ/LA6qREUvW1oP2z80OJQnng0fQgGE4llaEg9ZnGzK/8yIPJ+xhOdYFLdvgtqRoLkjD0wMLWjJ/PrcGx5N7RWgLqT6LqgivdHcMMdSD0wByyydKFE3OjZmUWzjm5jbLdQdoOsRkryB6Yf9QKFhoq32RfSyxt5slppg/IqawpMlqYC7vXzio0BTdJZRhYUOHStr+/iFeJgB9MZQ14M8n/AKShf/ikewW/YemmtwPEqpest4WUXCZb6LZg0lm03qtif00nthKQwejGwwabZHRFS7x8H39ogXK/MFgJUYh2j1UqEYMBvCGhg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB5184.apcprd06.prod.outlook.com (2603:1096:101:89::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:42:57 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:42:57 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 08/17] hw/arm/aspeed: Attach SRAM device to AST1700
 model
Thread-Topic: [PATCH v2 08/17] hw/arm/aspeed: Attach SRAM device to AST1700
 model
Thread-Index: AQHcTgiMwSVQOVPevUqLSYfUimGlg7TsHG2AgACeL8A=
Date: Tue, 11 Nov 2025 01:42:57 +0000
Message-ID: <SI6PR06MB7631C537907F4E016640BC2CF7CFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-9-kane_chen@aspeedtech.com>
 <bc22c287-b240-4cba-a8c1-515856186469@kaod.org>
In-Reply-To: <bc22c287-b240-4cba-a8c1-515856186469@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB5184:EE_
x-ms-office365-filtering-correlation-id: 76b1e8f6-536f-4cb8-66e2-08de20c3a424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U2dMamcySmdLejhzYlY4b0wwemFkeVp6MEtVYlVjNHVvOVBIRWVIOHJIU3hn?=
 =?utf-8?B?SjFmcmMrVFZpOGZ4a1Fndk1mQXNIdHBLTm1XdmFpZ0RVK1R6MVNJNWtubWNR?=
 =?utf-8?B?ODdCZ0xaUnpzVFdDekYvRlZiSkk3VFNVTUxxY2ROOEk4VGNhUmc2MXltKyt6?=
 =?utf-8?B?Nm1lbC93a0wyK3ZMV1B1aEd5bEdKblFTdmdPUnpYcElYcnd4UDBQN2pTM1ZC?=
 =?utf-8?B?UzVialZaS0FlRlZ0Q1k0RG5qQjNIVjJPUlFmL1hyM293T2VMVzBDZWowbzFw?=
 =?utf-8?B?REQraFRBUDlSR1NYRmd4YzRNSFdKZ0R2NForMmpSbFhOYUR0L0YvNUUwb2pr?=
 =?utf-8?B?Yi9uMDVud3prSE0yOTU1cmpUVGY3NEFtWmpFajg2VXN4eUgvTlpNOElXTzBv?=
 =?utf-8?B?ZjlnMmZrdHUzVjhVVzZIeHJYemt2a1UyLzdkWFk4ZFhmMWNwK3lsSWE3a2JU?=
 =?utf-8?B?UjdlMXF1Mk90TUlXYmdXWXo3MFl1SEV0dmxua2lMYTVPZU41SGl4RGhEY3JJ?=
 =?utf-8?B?aCtDSDNuN2FuTzFWcFNtMWFXaTEvMnB6ajQ4MThvaXJwN3lOQ1NWdjJyZG44?=
 =?utf-8?B?WFdiT3R5S2NjRXZzTWlyNEY0bHpNSDRBcFRpdDlKclBPOTBNWm14dWZFbjN5?=
 =?utf-8?B?QTQ3cmRNNXV4OHFIcWUxU1N1Nk5PV3lkWlVJdDEyeG1WS2dKbit2VlE1dXhC?=
 =?utf-8?B?RzRaSUxCdkFKbDU0VW1zSkhZUlF1QzRQZDROR2xzNld4eVMzclJLSHd2TStH?=
 =?utf-8?B?ZytvQlVqYVVsU3JqSDhhcVg3ZzZQRzZxbWhWVWdMSTVzRUJIZFlKVmRDeWRH?=
 =?utf-8?B?MXZFQWV4UUpCWUVnUyt4aVpNa2RUV0VsTHE0dU1EeTY4WFVvMjlsZHBPOHU2?=
 =?utf-8?B?eHFocFkyT2tZc1pLb3BTZlVpNm9lTXQ5MGllOVoxZHViUXl6Tlh2UXNONSt0?=
 =?utf-8?B?L2dPaWlBMWlTdVBjdlBuTmJxdFNzemZkRkc2Vk8vbitzWkRDRXNKdk1NQ2k2?=
 =?utf-8?B?a2pWazMwSkhZWmc3L2pqeE9sSm1KQkRuWkdLUFNSQUY0YmpqaGtqWGh0K1F0?=
 =?utf-8?B?WHk2Ym9CbkxWMUxkd081a2lEZmFsREgzRVVwcTZUN3hDUWpFenNrelBVWmVL?=
 =?utf-8?B?bDFPd1VHdCsyaWZYU25Ga0doR2QzZmFzV3pPZllnN1M2N05lUkZzKzgva1hp?=
 =?utf-8?B?NGZXMURWYzJJck9HbG5KM0syZTFYYk1jb3dnVjJNWUs3QUVXdERiRUpEYVhh?=
 =?utf-8?B?NUNNRTVBOUk3QmNhbnpHeFBkUHNqTlM2OHVvN2ROVWs3elNCbUx1ak9ZQkRs?=
 =?utf-8?B?Ulh5WWxQYiswdWl3YW8yeDRNeWtYcVNDTnc1bm42cVVZbk0vYjc1SlAwUGZx?=
 =?utf-8?B?eGxxajFTWGpkejF4bmw0NjY4ckMvWHhGTTJSUzJLSlI3ZXJRRkFyMjFzR1Qv?=
 =?utf-8?B?UkFjQ091RmNlbk84MDFDNjEyQ0F4SEdYbzNvcXhTb3liNStzRlJxR2sxTmYz?=
 =?utf-8?B?RVViRnMxTVdqbUpnL2luNUZyYWIwb2lzQUtFSFlTVWV2bVlYbUd1OGpGTHdB?=
 =?utf-8?B?bDF3SmJWSGFrUVAvR1JlZmpKak9Ock9GMnJwaktyU1AzYkw2YkZmb3AzY1hT?=
 =?utf-8?B?dkdVUVNHd3p3Z2ZYWEkzTk01enAzYkMxNHVuSlY2cjNVOXNqVEtKUG5VK1RT?=
 =?utf-8?B?L2ErNm4rZzV2dWpTMEdVTEM0K1grN0FPRzhkZDh1QXFXZWFoeHllVDNrLzJB?=
 =?utf-8?B?b0I0ZUZjOFh0ckJlYVRZRjMwZzNjK0hNemFDSE1ad2pGNllCZGh3clVHYlF2?=
 =?utf-8?B?K0l1R2Fmak9Gd0g2WWVvdTVLM09vTlJCM0JnUkJLV05YU3lRdElPME84czhG?=
 =?utf-8?B?dGd0TnV4VTZ2WDd6YzVlNmQrVGJORndBbDJJVDQySzdBYi9Yb1RvVkdGYkMv?=
 =?utf-8?B?anc1Q2cxb2RZeEg5ZExsU2NxU2cvZTU3SHM5eE1naVZ5MzlVTktjM3dmNE9R?=
 =?utf-8?B?YlVBTkw4VndiUDVQVzFsNENrQUNHSlVIRmU3ZUZGdFdkVzRPNTFESFhmOE50?=
 =?utf-8?Q?26LOYS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDNvL3hhTThRY3R4T1JlbUEzSzNOdldSZDluV05TN0VFVnhEdXZSSFd3dDlX?=
 =?utf-8?B?WUdjZXBFcDdjajV2UmttdWJiV2FhdDRTQitQWmtXZ2NwVmRzZnNCMXQvWnpl?=
 =?utf-8?B?Y0dQVDJKTmVkWHA0QkVVNWtlZjNmMkpBMlh3WmRvZ1FadDJzbGtIREZaRlY1?=
 =?utf-8?B?Q1lGRHB5Z3p2cVYyUkh3bjI5MnovczJWcVdqT0dmYXQ2emVLVG94bXUvTS9h?=
 =?utf-8?B?TFNtUU1EdjcwbHpXTVNKSkxON1hyeWVwUXFKbUlITUxGL2J5Y0dnZzg0N1BJ?=
 =?utf-8?B?TzV5aW1Ka1I4eU1tN1lTMnI2UWszczNNRDZwczRMa1ZXWXV3M0M3SFJ0eTVX?=
 =?utf-8?B?Sjk2Y3hwTW5LeFBnVGdjSFdRU09PVHgxRVdsMU1DeFVZOUxQTDQwUnFlTGJi?=
 =?utf-8?B?NU8zTk1wcHBRblg0b2s3ZmVFeE0va0NYMFREbkVMRk5adTJUa0FsMG5kb0ly?=
 =?utf-8?B?TCtSb0VZNkU3YnpSclN2cnB5WWJyRjNsUTVScUVJVXZjcmFqVHloRzhNalcz?=
 =?utf-8?B?U3EvV2x0Ti8yUXArd1VVb2Z1SHBNOHFESVRMNUh4Sjk1eW1YYXdXUDJSUm12?=
 =?utf-8?B?VmNqQzNtWGRkNEpJUXkyWXN0WWxvUW43ZWtzZW50Y3lmOHBEREJqbi9mQVdF?=
 =?utf-8?B?Y1kvZi9LRlAzS2plcFh2SjRIdWVjS3VyYzZNa1paMDczUlA3bVJiUUZ0MXZG?=
 =?utf-8?B?NHBWOTZTQUY2QW9VdlUvZ1ZDQnVuamZscGw4U0Y2dlRiR0gwNEw4RTY2cWVv?=
 =?utf-8?B?NHQwQXhQNnIzLzFVSVVwS2Z2M3I4UU1BbGorTXdYQnpvMElsalUxeTFiQmFz?=
 =?utf-8?B?Wityd3R6UEY1disyL0xzd3FlSm1SbE5qbkZFa0ZRdGJ2aVdXZUVJd3ZFM1Fz?=
 =?utf-8?B?Nk1yNy9nbEViVmVhcUJvc2ZkQzZhSEp2MDcwRXFFQjVqYXBGbWMrU2ZzckdI?=
 =?utf-8?B?U3hkdHhCakFrWjd3ejROYWIyVWZZNjJ2U0EwYVVaS2ZTdHZBeFlRN2lIckRK?=
 =?utf-8?B?bSs5TnhYaEpFMDFlbGJRTXZZbkhReThWbk1XelVyZERyU0tQamZDWC9UaEk5?=
 =?utf-8?B?N3dQRXJMRWw0amY5ZzdaOFFqdzBDeGlGMnJUK3pkMG9oSThrSHFyT0l4UjdK?=
 =?utf-8?B?UFlPdkV3V2gwVysrdE52VmhvYXpreWhqd1JYdHJCQi81a0dZSm1IL3NyajB4?=
 =?utf-8?B?d3ZqcVk3WXB4Wk13L2p3ZUJRNlFoaDZIaFZMMXFwRzNwR2kzc2RnRDFpbDdF?=
 =?utf-8?B?cWlMTVBMRHRiSS83Nk1uTzBNSVNIc3UxNEJmUkhxbXd0VkFObzlna1pXZkRG?=
 =?utf-8?B?YmNsM0drMHpKeDZ3OERZSjY0SGZaOWMyS2NLaVFON1ltR3p1eWJrNE1tNlVZ?=
 =?utf-8?B?L2JrMm9zYVBWN2N5dUxJYkkwVkZSc2ZXY05La3VUSEx6Y0RpTGI2S1lvWTls?=
 =?utf-8?B?M041dWttbCswQmRNcytWNmk4cnpwOCtqL25pRmhqY2c4Y2IxNHk3MmNZV2VR?=
 =?utf-8?B?ZmNTWHV5d01HbHIyMTg4dXozeW43ZDNtUG5jTjAzSjd1WU5XbkYwenNTRktk?=
 =?utf-8?B?empkZmw4aytOTytoNW1pNC9GdkFlMjIvSVN6bHF4Mm94VUhiWlNMUjNERnN2?=
 =?utf-8?B?YTZkcHBUa2VPZ0svYVptYm1TSkQzKzRsNVRBR2NENHhCZ1dvN3hab295M21Y?=
 =?utf-8?B?eG56dXd0a3dIbmxNVGRrZkVSaGhXaUM4dmVMVUlWRTl3OEI2czJ1WnJjTko2?=
 =?utf-8?B?eGM1akV1VXQwQnZKcUNLSHFjK2Z6SGNLWkw1T3lSVS9waHdFendQdzZrcVpl?=
 =?utf-8?B?OG90d0hlZE5WclFXQkFJTC9wUEZCZGhWVlZSdkRLNlplZWZFZ2pLcTltSElO?=
 =?utf-8?B?THVYenorN1RuSlJ0YzNzamE0NFRuVDFTU3ljS3ZXZVAwYkxCZVNlR1BPWjNx?=
 =?utf-8?B?U29RZFYwaU4zVW9adWdvYkNqYVpNRUNRVndNek9XU2xEOTRLQUV5WEVzMkxy?=
 =?utf-8?B?ZEdyMXdBdXVEakZBUzJkNDFDSTlxSkpLUTB1RXJhSzhsd3hBZXV0WWx4SnFu?=
 =?utf-8?B?YWd1ZG9WV3JoSExiQjlETnk0TUd0b1NOZ0o0SUlEbDZWc0lEWXRoY1ZUVW5w?=
 =?utf-8?Q?pmr6KpseZzoiOvH+lMnlzZQPy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b1e8f6-536f-4cb8-66e2-08de20c3a424
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:42:57.7314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boqRXSGdS34CHdZG83vU4o+/3CkQOMELmPI7uvYK4hz+6IsVEoAoTDmUQMoOmSfLGnJN2VANGwv29YBBdyMAQDEZkMFkb0YQZKrkrIQCbf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5184
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcuIEkgd2lsbCBhZGp1c3QgdGhlIGNv
ZGUgYmFzZWQgdGhlIGZlZWRiYWNrLg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5v
cmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDExLCAyMDI1IDEyOjA4IEFNDQo+IFRvOiBL
YW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVj
aC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0
cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0
OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVz
IENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95
X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOC8xN10gaHcv
YXJtL2FzcGVlZDogQXR0YWNoIFNSQU0gZGV2aWNlIHRvDQo+IEFTVDE3MDAgbW9kZWwNCj4gDQo+
IE9uIDExLzUvMjUgMDQ6NTgsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4t
QVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IE1hcCB0aGUgU1JBTSBkZXZp
Y2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFT
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L21p
c2MvYXNwZWVkX2FzdDE3MDAuaCB8ICAxICsNCj4gPiAgIGh3L21pc2MvYXNwZWVkX2FzdDE3MDAu
YyAgICAgICAgIHwgMjUNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmgNCj4gPiBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRf
YXN0MTcwMC5oDQo+ID4gaW5kZXggZTEwNWNlYjAyNy4uMzkxYzg2ODdmNSAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
aHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5oDQo+ID4gQEAgLTMyLDYgKzMyLDcgQEAgc3RydWN0IEFz
cGVlZEFTVDE3MDBTb0NTdGF0ZSB7DQo+ID4NCj4gPiAgICAgICBBc3BlZWRMVFBJU3RhdGUgbHRw
aTsNCj4gPiAgICAgICBTZXJpYWxNTSB1YXJ0Ow0KPiA+ICsgICAgTWVtb3J5UmVnaW9uIHNyYW07
DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAjZW5kaWYgLyogQVNQRUVEX0FTVDE3MDBfSCAqLw0KPiA+
IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmMgYi9ody9taXNjL2FzcGVlZF9h
c3QxNzAwLmMgaW5kZXgNCj4gPiAxYzJkMzY3Y2RiLi42ZjdmZjYyNWI1IDEwMDY0NA0KPiA+IC0t
LSBhL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX2Fz
dDE3MDAuYw0KPiA+IEBAIC0xNSwxNCArMTUsMTggQEANCj4gPiAgICNpbmNsdWRlICJtaWdyYXRp
b24vdm1zdGF0ZS5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2FzdDE3MDAuaCIN
Cj4gPg0KPiA+ICsjZGVmaW5lIEFTVDE3MDBfQk9BUkQxX01FTV9BRERSICAgICAgMHgzMDAwMDAw
MA0KPiA+ICAgI2RlZmluZSBBU1QyNzAwX1NPQ19MVFBJX1NJWkUgICAgICAgIDB4MDEwMDAwMDAN
Cj4gPiArI2RlZmluZSBBU1QxNzAwX1NPQ19TUkFNX1NJWkUgICAgICAgIDB4MDAwNDAwMDANCj4g
Pg0KPiA+ICAgZW51bSB7DQo+ID4gKyAgICBBU1BFRURfQVNUMTcwMF9ERVZfU1JBTSwNCj4gPiAg
ICAgICBBU1BFRURfQVNUMTcwMF9ERVZfVUFSVDEyLA0KPiA+ICAgICAgIEFTUEVFRF9BU1QxNzAw
X0RFVl9MVFBJX0NUUkwsDQo+ID4gICB9Ow0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgaHdhZGRy
IGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtdID0gew0KPiA+ICsgICAgW0FTUEVFRF9BU1QxNzAw
X0RFVl9TUkFNXSAgICAgID0gIDB4MDBCQzAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9BU1QxNzAw
X0RFVl9VQVJUMTJdICAgID0gIDB4MDBDMzNCMDAsDQo+ID4gICAgICAgW0FTUEVFRF9BU1QxNzAw
X0RFVl9MVFBJX0NUUkxdID0gIDB4MDBDMzQwMDAsDQo+ID4gICB9Ow0KPiA+IEBAIC0zMSwxMiAr
MzUsMzMgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZQ0K
PiAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgQXNwZWVkQVNUMTcwMFNvQ1N0YXRlICpz
ID0gQVNQRUVEX0FTVDE3MDAoZGV2KTsNCj4gPiAgICAgICBTeXNCdXNEZXZpY2UgKnNiZCA9IFNZ
U19CVVNfREVWSUNFKGRldik7DQo+ID4gICAgICAgaHdhZGRyIHVhcnRfYmFzZTsNCj4gPiArICAg
IEVycm9yICplcnIgPSBOVUxMOw0KPiANCj4gVGhpcyB2YXJpYWJsZSBjb3VsZCBiZSBhdm9pZGVk
Lg0KPiANCj4gPiArICAgIGludCBib2FyZF9pZHg7DQo+ID4gKyAgICBjaGFyIHNyYW1fbmFtZVsz
Ml07DQo+ID4gKw0KPiA+ICsgICAgaWYgKHMtPm1hcHBlZF9iYXNlID09IEFTVDE3MDBfQk9BUkQx
X01FTV9BRERSKSB7DQo+ID4gKyAgICAgICAgYm9hcmRfaWR4ID0gMDsNCj4gPiArICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgYm9hcmRfaWR4ID0gMTsNCj4gPiArICAgIH0NCj4gDQo+IFRoYXQn
cyBhIGJpdCBoYWNreS4NCj4gDQo+IEFuICJpbmRleCIgcHJvcGVydHkgc2V0IGF0IHRoZSBTb0Mg
bGV2ZWwgd291bGQgYXZvaWQgdGhpcyB3ZWFrIGhldXJpc3RpYy4NCj4gDQo+IA0KPiA+DQo+ID4g
ICAgICAgLyogT2NjdXB5IG1lbW9yeSBzcGFjZSBmb3IgYWxsIGNvbnRyb2xsZXJzIGluIEFTVDE3
MDAgKi8NCj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2luaXQoJnMtPmlvbWVtLCBPQkpFQ1Qocyks
DQo+IFRZUEVfQVNQRUVEX0FTVDE3MDAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIEFT
VDI3MDBfU09DX0xUUElfU0laRSk7DQo+ID4gICAgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZz
LT5pb21lbSk7DQo+ID4NCj4gPiArICAgIC8qIFNSQU0gKi8NCj4gPiArICAgIHNucHJpbnRmKHNy
YW1fbmFtZSwgc2l6ZW9mKHNyYW1fbmFtZSksICJhc3BlZWQuaW9leHAtc3JhbS4lZCIsDQo+IGJv
YXJkX2lkeCk7DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKCZzLT5zcmFtLCBPQkpF
Q1QocyksIHNyYW1fbmFtZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgQVNUMTcw
MF9TT0NfU1JBTV9TSVpFLCAmZXJyKTsNCj4gDQo+IEp1c3QgcGFzcyAnZXJycCcgYW5kIHRlc3Qg
dGhlIHJldHVybiB2YWx1ZSBvZiBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKCkNCj4gDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICsgICAgaWYgKGVyciAhPSBOVUxMKSB7
DQo+ID4gKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQo+ID4gKyAgICAgICAg
cmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9u
KCZzLT5pb21lbSwNCj4gPiArDQo+IGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNU
MTcwMF9ERVZfU1JBTV0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMt
PnNyYW0pOw0KPiA+ICsNCj4gPiAgICAgICAvKiBVQVJUICovDQo+ID4gICAgICAgdWFydF9iYXNl
ID0gcy0+bWFwcGVkX2Jhc2UgKw0KPiA+DQo+IGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BF
RURfQVNUMTcwMF9ERVZfVUFSVDEyXTsNCg0K

