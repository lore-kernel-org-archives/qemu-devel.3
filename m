Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0396C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEeiE-0003Wk-1W; Tue, 04 Jun 2024 20:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEeiC-0003WS-8P; Tue, 04 Jun 2024 20:41:08 -0400
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEei7-0007s4-IB; Tue, 04 Jun 2024 20:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDn/jtSehXv9UAKHRhmkjBQXKtXjmKZZuNhSbaXBW9MRNp2PgWELdObnC3Jpk6vLk8+Q5NJdVUMbCvaRN1hbIIgm6sjDzBihrXf0JfBuN8oCDi3xpJLhu3gHSjA17BsnWC9DfdeA7gpPSRwIm9ZBdQsAodVOiNPxqMbHLfahMo2/q2U2I3Xqb4CfIMFXxf4qggU6iH9pL8pQYHpq5KocbwqNzb0fmcumwzRvvxTMZsXZzOJ0+RRi6v6ueUE5rOaNbn8JFBChDKaqvxPSxaXy+CH69WIXbKa+x56w02k7WnEg6D5zsHkZ0zTtv7QQEHb74HTY83RxXpfDeEjH140Qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7cEnb0YCOXbvAvqlaek6EWJ7PmafJpW+GT0X4AmTmo=;
 b=mP6GwZ93v8OWpBNccL+hLBxW5D1TtQ/knFR4tPXwNlPY0tQ6a8nBeibpPLhNwG2esJid3//URKiVMKqq4QI519sB7VTAXKkmWu8egyKpZLDg73R6uqwJr1W0hSIHwPPyyMYOnb3fQ8sxTS3TjD3hiLyQuYkQYkHDx7pdypmHHoAqCItzQUMnKaQjhwCcXBgKxuNdh4T27/RuiWP2i5aR7PBfLATy3xh9Tk3bw5MvYeRsIxRaxAD5ZrdpXV1ketWK2JonElb4BFdZxCJdT6LIMswi7ySMzkuNT4EL68k1Xo+dBzXKGgJ/E9PaSQ1iakBrv+K2pOzRF4DVS2GD29VKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7cEnb0YCOXbvAvqlaek6EWJ7PmafJpW+GT0X4AmTmo=;
 b=RKifsKN4oFBecy9FTHlAGofZHzloe/36y+ngYYyrKXF/AWdgmdUi6iasf6/OC2xltc+7g4kGDx42PVU+D2LKh4KwB1RUBBSREZW6px/ZT6wtMkL8JTYFFGsXNZcGIE+DuAFxMSkXNZh6J1nnU33URdI3dzKQnUxHqfEkeUtApbSZaTXv4AYsVxe1F38S9kSuH0PCZEQ2hPNRnsoTZi6Ybd7OMq7wXtWMzFBgmtEWc0xqVEfVT1jjqpql1QjLTWY2b0jMgOedg0DqeVx6sLOc64mC3fq7G30ZK5pfuMEha7P0uv6INV3x12pU+1K4Xbp+a5Au5Sk4gGryYVqFXQ2tQQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Wed, 5 Jun 2024 00:40:55 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 00:40:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v5 00/17] Add AST2700 support
Thread-Topic: [PATCH v5 00/17] Add AST2700 support
Thread-Index: AQHatkJPYnlt+ZTZ9kuAnJUSt8Fp67G3fp6AgADWHdA=
Date: Wed, 5 Jun 2024 00:40:55 +0000
Message-ID: <SI2PR06MB504156E8F7DF1BEF42D01175FCF92@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <59b2f10a-5ff8-41c4-b5a6-92846b0c31a0@kaod.org>
In-Reply-To: <59b2f10a-5ff8-41c4-b5a6-92846b0c31a0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5747:EE_
x-ms-office365-filtering-correlation-id: e35ce3e6-5b3d-4b01-ac7d-08dc84f82901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?UjJ0K0l6cnM1cHhOaGZDdDg1TlkzUFFockczaFEwNElnMU0zYmtxMVFxNGJp?=
 =?utf-8?B?NG5zbDNJNW1aR3BaSVArd1BDNDJ2U1hDZldQRjd4MTJ2M0ZKMWJvUytXMnZn?=
 =?utf-8?B?TTFyS2xCRjdCWmZLTVV1QlJKV3VjOVJwbjluSGM2M3QyU25wOEptQVE5U0oz?=
 =?utf-8?B?bGpVWlY3TGhZc2Yvb1pUVjkxUWFaWGhOZ3hCcTVQaDd6VjBwbnZFVDZydFc4?=
 =?utf-8?B?ZE5kVWxWQU1RZFd4QStEWk0vWTBvL29xSk1IS2RKcnlKQWhoTnErZHJQeDFa?=
 =?utf-8?B?TTJLSENMcTZ5dWtKZ2dGT0VzY2UxYXcwQUdNcXZZVk43QWZubjRtQzNMVnJw?=
 =?utf-8?B?ZzY5Z2tqU285WDJITzFvcWI0MUo2eGV1cFQ2VHBzS1NFV1BkTVk3WWRkS3pZ?=
 =?utf-8?B?MVVVWlNwbXg2ZlpYZWVWQVNZb0ZLVnhDdmVSRjE0M1YzbkhiWlpjb0I1UVd4?=
 =?utf-8?B?bUNlQi84TFlrc1FJRUtMZ1pVaWNCTmxpS25xZy9uTUFPcXB1dEo1eEJ3ejZn?=
 =?utf-8?B?RzlXQ2NhVklnTVFjQ0dFME5jblJFZnYzUGdLSXYyWDk2WGJ0Wi9mOVlMZlJJ?=
 =?utf-8?B?bER3UjRKcVArTnFBRytJWWx6VStySFVEY2VaQ2h3ZS9vRUpkNWFjYmwyK0dB?=
 =?utf-8?B?aVE4Nk1BSjE3YTlVS080aThOYjkyL3VIRWlVKzM1RW41RlFhemEwZGhSWlJ6?=
 =?utf-8?B?aHZaamp1THRsMjVHbWJ5Vm81TkJ6NUlkRUlKQkh4VVZwQ0RDTDJncFNBSGR1?=
 =?utf-8?B?b3M2SmlvV090Y2ZFZkU1R0VEclkvVzB6aTRhRXpWODdQcnB6WGp4a0poMjFx?=
 =?utf-8?B?WjFVVi9sbHgvVnV1YkFwUHhJeEU2TXZDUXI5VEt5OWZmdXlFUjQyTW5HVGcz?=
 =?utf-8?B?eFh3U04rWHBEVGtQMVNRM2xKWmlSTlV6dHZFVW5KSndaZCttV0FmdzFRTHlQ?=
 =?utf-8?B?VG9odUZZNkVuMVltTSs1eER3Q3ZCd21rZmkvaGhGMHNDYVZpUmFoY1JmdlEw?=
 =?utf-8?B?RzBpS2dGN09HWXdXeXB6ZVU3T1JvZjdWS1hIVjdLaFRjNmJZeksyMkdGVWhN?=
 =?utf-8?B?Um1pdDJsUG8xcWQyZ05wSmdDUExob0FPbk5vdFZnOVYybmVJdU92dGdtSi9x?=
 =?utf-8?B?VUVuTnVHNk1kQ243bGdVenNKcExnUm1vSEUydVBwOFVOb2lHU3daSUErd3k1?=
 =?utf-8?B?Nk5YTGVzRTlPVXRNc2phSjRPTlV4eXFhV3dGVmtBR1Y4UzFJWDc3VzEzaXlC?=
 =?utf-8?B?TTBOY210L2RwYytESWs2MHZVQmhBQWY0djVHeGdDcXhNT0pFWVRaeXNXUHla?=
 =?utf-8?B?Umo4ekVjRmQzUVoySFRDbGMwNElFZVZHbnNSS3d3MXEwVEJFMWlOeTRZOEIv?=
 =?utf-8?B?ZHhiVi92NStLUnpJN29KUUlQRDNIQ3N2TjJ0TWsrMk85K1JDSTkvUlFPL1Zs?=
 =?utf-8?B?WW5pSmZUMFBhNnZGc1BLbDFQdFhrSHhZK2VkTjJmNUhsUkZZZHJjQkwyMmJo?=
 =?utf-8?B?QzE4RDh4Q2hkUmFMQ3kyRmlnb3NzOTBWMDZUL3JmWlZJV0pVbVRLdVBLYWlF?=
 =?utf-8?B?VjJXS0wrWnlaYlB3aTFNWFNnZWt2NlVJcDYrRC9BUjA4VUF5bGh6b1BkclF6?=
 =?utf-8?B?Y0F1ZzJCTTAvK2ZkMlpza3d3aFg3UFE4Tlp5NHZmcVgvQ3BZMys4TU4wa1A2?=
 =?utf-8?B?N2xzNmV6VGRnLzhXUFdKNTFkTGtLaFBKUG1tSEFhY3pGYnVQTE0vbFpSLzFn?=
 =?utf-8?B?cGdEOXdlZFFiaWxNbGxOd2MzTXZVVlpKR1VRaUVmR1BRdERoQUFneXdNQ291?=
 =?utf-8?B?cGNpaU45WEl4Zk9FMGRJZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG9wWHpQa2htMWtKWTBNTlExWmJLQ3EvbXAyN1NTblVvQ3hWZ3NPL0U5bEZL?=
 =?utf-8?B?QmN2V0habFI2c0JTaTJ5WjlTUnhPckNFL2NZZ0RhWGQ4K0ZPeGNxUFVKWisw?=
 =?utf-8?B?b1MxYU1TSnpoT1J0LzMrYWhYVlNueWNWYVArRXR4QlVURm8xb1FxYlBESVlH?=
 =?utf-8?B?bnU4NWs1c0lFdUxBTE5hemRCVHBERE1YMzVETHM1aUZDVHl3eitlcVFZa3k0?=
 =?utf-8?B?SVAyaWd0bFpsRUZaeXR4RitXcVFWcytTYzY3dFlhdk9UcnIyZi9Dc01IelZ0?=
 =?utf-8?B?bTBCb3JrZ1ZVR1N4eXhpS2Y3T3doa1NSckx5U2RKdDcycjRDeWMzUEtRWEE5?=
 =?utf-8?B?RXVPZy9CMEpETEtmUVdBSkpENW5TampPSHFrdWhyOTkyV29vRnNlUGtSK0sz?=
 =?utf-8?B?OXkxdVdDelEvVlZzeGFxNTFBLzdna1cxNDVxcXVsTCtxRHF5dXdlUWZHejln?=
 =?utf-8?B?UWVHSFpxNmtybThaN0ltcG12bXA5Vkd3U3BXNTZKTmhpeHFud2kyVGk2bGNQ?=
 =?utf-8?B?bTZ6NE5VcFAxWEYwb1A1MWtReU82dThqRXZTSEx2a0hVRDV0QzduTmgyaDNr?=
 =?utf-8?B?K0pKSUhxS3lLUklHOTcybS85NGlnOGJySWtsQkZXZkViYUZqNzdCb3dkcTQ3?=
 =?utf-8?B?U3RnaTVyMllJNGl2YTlOYzgrUDlucERpMkZ6eXBYVVNycEtZRTFSRUNIekZ4?=
 =?utf-8?B?K2NMc2liejJmVmJHeVdEUHJKRkRyMStpQis3T0Z3OEgvT2ZYM1ZISmUya0x6?=
 =?utf-8?B?YkRkYU1kcXFadlNOOUJ0OVpyNHpwVWQ3UDR2eVFtTDA2WmRTQkJrNkE4Vkty?=
 =?utf-8?B?QWx5SUlXRm8vbU1lS0hTS1VubVhVZUFoUWVVMlN5V3gwKy9IdmpweEZaRHRr?=
 =?utf-8?B?N3UvQ3ZKeGQ2Syt2RkFReHdCVGNWbkJCN08rdk15Q1ZPWTlUZnRIOHcwYnBa?=
 =?utf-8?B?U0trekJMOGVZUWUza29QT0oreWRYdmZWRGUrVGdDODJGeVJpQy9yRkhWRGJj?=
 =?utf-8?B?bzk0c041UExDamx1ZlEyM0pBT1ZoQlNkVWJpYmZOQnZ4emNSUU8zRzF3ekhP?=
 =?utf-8?B?TTRIbmtLQVNMME9uVEtYM0ZWYU0yMVlYQUVBRmNKcWxRMEFxSlgrVndCU2xJ?=
 =?utf-8?B?ZDhCcDM4a1REUnA4S0VSVFpGYmxzMzNxUDFjbTBDd1JIODhnVHRkOUFGQ0Vt?=
 =?utf-8?B?cUhnaVhoUGJETEk5ZG9UNGs5VmQ1cmFOQXlpMVhiL0JYSTdMYm9CSm0wRDI3?=
 =?utf-8?B?cEo2eENIbzhJWlp0cG1ING1ncmJzcDh3cGxrdnZ5NUp1ZUVqbG5NV042cjln?=
 =?utf-8?B?MkhVR0tFb3lPUlpMMmlSSzlQM1ZyTEZLM2sxRHlobHpSWDdHajVvK3NPaDVz?=
 =?utf-8?B?Z3Y5N244SlVJS3ZHbnJJVy9ycXUrSkJFcUNobUpoMFFrS1BWNHA0bzhIL3NJ?=
 =?utf-8?B?R2lQZ3VlQVRiTlVkTno4U1R1TTBSSXhLVS9Na3o0a2c0WXBxaEZJUWZWaTVx?=
 =?utf-8?B?emYrTjRnTjA3ZUFiWVl3ckRRSVNsSUMrZTR3OWMrQ3VUc2hiY09NWkN4SGRo?=
 =?utf-8?B?eXlSeDFCWmZOOE8wRnkvaTZ3Z0xNL2hwZGZmU2RKa3o4NEQvckFndHZyTWU2?=
 =?utf-8?B?SFQ4Y3F1aWU3cVNpT1gvWEpQUC80Z09nVnpuZTdxUFhvWU1LNFl1cis0Y2lq?=
 =?utf-8?B?eFlxa0tGczhLbG40TVhzRWQ0ZmlDOWptYlhuWkNsQ0wzS0t3T0hJak1aUDFj?=
 =?utf-8?B?M0dsV3VGOFFLOExBTlhoZHRXUEc5enVXMlgvRHZ0WmVZVWF4Mm16bGpLUU5W?=
 =?utf-8?B?SnJBZWJZUzFGbzNPNjZ6MkpLb3p5UUNpVmppVFhKSmFncEdFU25LZ1F0WndN?=
 =?utf-8?B?ZVVSNTJhSEpOYndwM3RkdTQyWklqbERYWHFRUGhhVnFDbWtxdWJrZWx0U2U1?=
 =?utf-8?B?bjNWU25NZFhQNEl2Ulp1V2tia1ZrQkIxb21WNE5TZ0R5NUlTc2NlNmVEeDlR?=
 =?utf-8?B?WFVmVG9HRU8zSzcvWlMyYmw4UjlYQS9wMDg2S0tSVHNLVnNvWlV3QXdvTUJ3?=
 =?utf-8?B?bGRCOVBGYkZtZ2ZxamZlZEZBdmNzZTZwcnlMNERrZlkrTExVazF3MTBiMXg2?=
 =?utf-8?Q?BLtKPvS/K2Ub8978fJzgZ5wMR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35ce3e6-5b3d-4b01-ac7d-08dc84f82901
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 00:40:55.4043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2TkyhCt2tiur+wh/2YWTmK5uLx+T22fQAsDgqC03rxUSRP0IvOLjAJNhFlfn9L3G0i0rO/bL4Lnsjooncp/tRjQ97wUWNtV0L+MR0q6p5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5747
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFNlbnQ6IFR1ZXNkYXksIEp1bmUgNCwgMjAyNCA3OjUyIFBNDQo+IFRvOiBKYW1pbiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+
Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXJAYWxpc3RhaXIyMy5tZT47IENsZWJlcg0KPiBSb3NhIDxjcm9zYUByZWRoYXQuY29tPjsg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsNCj4gV2FpbmVyIGRv
cyBTYW50b3MgTW9zY2hldHRhIDx3YWluZXJzbUByZWRoYXQuY29tPjsgQmVyYWxkbyBMZWFsDQo+
IDxibGVhbEByZWRoYXQuY29tPjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25n
bnUub3JnPjsgb3Blbg0KPiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxp
biBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NSAwMC8xN10gQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiANCj4gT24gNi80LzI0IDA3OjQ0
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQ2hhbmdlcyBmcm9tIHYxOg0KPiA+IFRoZSBwYXRjaCBz
ZXJpZXMgc3VwcG9ydHMgV0RULCBTRE1DLCBTTUMsIFNDVSwgU0xJIGFuZCBJTlRDIGZvciBBU1Qy
NzAwDQo+IFNvQy4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MjoNCj4gPiAtIHJlcGxhY2UgaXNf
YWFyY2g2NCB3aXRoIGlzX2J1czY0Yml0IGZvciBzZG1jIHBhdGNoIHJldmlldy4NCj4gPiAtIGZp
eCBpbmNvcnJlY3QgZHJhbSBzaXplIGZvciBBU1QyNzAwDQo+ID4NCj4gPiBDaGFuZ2VzIGZyb20g
djM6DQo+ID4gLSBBZGQgQVNUMjcwMCBFdmFsdWF0aW9uIGJvYXJkIGluIEFTUEVFRCBkb2N1bWVu
dA0KPiA+IC0gQWRkIGF2b2NhZG8gdGVzdCBjYXNlcyBmb3IgQVNUMjcwMCBFdmFsdWF0aW9uIGJv
YXJkDQo+ID4gLSBGaXggcmV2aWV3ZXJzIHJldmlldyBpc3N1ZXMgYW5kIGFkZCByZXZpZXdlcnMg
c3VnZ2VzdGlvbnMNCj4gPiAtIEltcGxlbWVudCBJTlRDIG1vZGVsIEdJQ0lOVCAxMjggdG8gR0lD
SU5UMTM2IGZvciBBU1QyNzAwDQo+ID4NCj4gPiBDaGFuZ2VzIGZyb20gdjQ6DQo+ID4gLSBzdXBw
b3J0IDY0IGJpdHMgZG1hIGRyYW0gYWRkcmVzcyBhc3NvY2lhdGVkIHdpdGggcmV2aWV3IGlzc3Vl
cw0KPiA+IC0gc3VwcG9ydCBkbWEgc3RhcnQgbGVuZ3RoIGFuZCAxIGJ5dGUgbGVuZ3RoIHVuaXQg
YXNzb2NpYXRlZCB3aXRoDQo+ID4gcmV2aWV3IGlzc3Vlcw0KPiA+IC0gcmVmYWN0b3IgaW50YyBt
b2RlbCB0byBmaXggc2VyaWFsIGNvbnNvbGUgc3R1Y2sgaXNzdWUgYW5kIGFzc29jaWF0ZWQNCj4g
PiB3aXRoIHJldmlldyBpc3N1ZXMNCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2NToNCj4gPiAtIHNk
bWM6IGluY3JlbWVudGluZyB0aGUgdmVyc2lvbiBvZiB2bXN0YXRlIHRvIDIuDQo+ID4gLSBzbWM6
IHN1cHBvcnQgZGlmZmVyZW50IG1lbW9yeSByZWdpb24gb3BzIGZvciBTTUMgZmxhc2ggcmVnaW9u
DQo+ID4gICAgICAgICBpbnRyb2R1Y2UgYSBuZXcgImNvbnN0IE1lbW9yeVJlZ2lvbk9wcyAqIiBh
dHRyaWJ1dGUgaW4NCj4gQXNwZWVkU01DQ2xhc3MgYW5kDQo+ID4gICAgICAgICB1c2UgaXQgaW4g
YXNwZWVkX3NtY19mbGFzaF9yZWFsaXplIGZ1bmN0aW9uLg0KPiA+IC0gaW50YzogZml4IGFzc29j
aWF0ZWQgd2l0aCByZXZpZXcgaXNzdWVzDQo+ID4gLSBkcmFtIHNpemUgZGV0ZWN0OiBjaGFuZ2Ug
dG8gdXNlIGFkZHJlc3Mgc3BhY2UgQVBJIGFuZCBzaW1wbGlmeSB3aXRoIHdyaXRlDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgdHJhbnNhY3Rpb24gb24gdGhlIERSQU0gbWVtb3J5IHJlZ2lvbiBv
ZiB0aGUNCj4gU29DLg0KPiA+IC0gYXN0Mjd4MF9zb2M6IHVwZGF0ZSBhc3BlZWRfc29jX2FzdDI3
MDBfZ2ljIGZ1bmN0aW9uIGFzc29jaWF0ZWQgd2l0aA0KPiByZXZpZXcgaXNzdWVzDQo+ID4gICAg
ICAgICAgICAgICAgIGFuZCByZW5hbWUgdG8gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19yZWFsaXpl
DQo+IA0KPiB2NSBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gRG8geW91IHBsYW4gdG8gc2VuZCBh
IE1BSU5UQUlORVJTIGZpbGUgPw0KPiANClRoYW5rcyBmb3IgeW91ciBraW5kbHkgc3VwcG9ydCBh
bmQgYXBwcmVjaWF0ZSB5b3VyIGhlbHAuDQpZZXMsIEkgYW0gc3R1ZHlpbmcgTUFJTlRBSU5FUlMg
cnVsZXMgYW5kIHdpbGwgc2VuZCBhIHBhdGNoLg0KSSB3aWxsIG5vdGlmeSB5b3UgdmlhIHRoaXMg
ZW1haWwgYWZ0ZXIgSSBzZW5kIHRoZSBwYXRjaC4NClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcywN
Cj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+DQo+ID4gVGVzdCBWZXJzaW9uOg0KPiA+IHFl
bXUgY29tbWl0Og0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0Lzc0
YWJiNDVkYWM2OTc5ZTdmZjc2MTcyYjdmMGEyNGUNCj4gODY5DQo+ID4gNDA1MTg0DQo+ID4gYXBw
bGllZCBwYXRjaDoNCj4gPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNDA1MjcxMjQzMTUu
MzUzNTYtMS1jbGdAcmVkaGF0LmNvbS8NCj4gPg0KPiA+IFRlc3Qgc3RlcHM6DQo+ID4gMS4gRG93
bmxvYWQgdGhlIGxhdGVzdCBvcGVuYm1jIGltYWdlIGZvciBBU1QyNzAwIGZyb20NCj4gQXNwZWVk
VGVjaC1CTUMvb3BlbmJtYw0KPiA+ICAgICByZXBvc2l0b3J5LA0KPiBodHRwczovL2dpdGh1Yi5j
b20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90YWcvdjA5LjAxDQo+ID4gICAgIGxp
bms6DQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVs
ZWFzZXMvZG93bmxvYWQvdjA5LjAxL2FzdA0KPiA+IDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0K
PiA+IDIuIHVudGFyIGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+ICAgICBgYGANCj4g
PiAgICAgdGFyIC14ZiBhc3QyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gPiAgICAgYGBgDQo+
ID4gMy4gUnVuIGFuZCB0aGUgY29udGVudHMgb2Ygc2NyaXB0cyBhcyBmb2xsb3dpbmcgSU1HRElS
PWFzdDI3MDAtZGVmYXVsdA0KPiA+IFVCT09UX1NJWkU9JChzdGF0IC0tZm9ybWF0PSVzIC1MICR7
SU1HRElSfS91LWJvb3Qtbm9kdGIuYmluKQ0KPiA+IFVCT09UX0RUQl9BRERSPSQoKDB4NDAwMDAw
MDAwICsgJHtVQk9PVF9TSVpFfSkpDQo+ID4NCj4gPiBxZW11LXN5c3RlbS1hYXJjaDY0IC1NIGFz
dDI3MDAtZXZiIC1ub2dyYXBoaWNcDQo+ID4gICAtZGV2aWNlDQo+IGxvYWRlcixhZGRyPTB4NDAw
MDAwMDAwLGZpbGU9JHtJTUdESVJ9L3UtYm9vdC1ub2R0Yi5iaW4sZm9yY2UtcmF3PW9uXA0KPiA+
ICAgLWRldmljZQ0KPiBsb2FkZXIsYWRkcj0ke1VCT09UX0RUQl9BRERSfSxmaWxlPSR7SU1HRElS
fS91LWJvb3QuZHRiLGZvcmNlLXJhdz1vblwNCj4gPiAgIC1kZXZpY2UgbG9hZGVyLGFkZHI9MHg0
MzAwMDAwMDAsZmlsZT0ke0lNR0RJUn0vYmwzMS5iaW4sZm9yY2UtcmF3PW9uXA0KPiA+ICAgLWRl
dmljZQ0KPiBsb2FkZXIsYWRkcj0weDQzMDA4MDAwMCxmaWxlPSR7SU1HRElSfS9vcHRlZS90ZWUt
cmF3LmJpbixmb3JjZS1yYXc9b25cDQo+ID4gICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAw
MDAwLGNwdS1udW09MFwNCj4gPiAgIC1kZXZpY2UgbG9hZGVyLGFkZHI9MHg0MzAwMDAwMDAsY3B1
LW51bT0xXA0KPiA+ICAgLWRldmljZSBsb2FkZXIsYWRkcj0weDQzMDAwMDAwMCxjcHUtbnVtPTJc
DQo+ID4gICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAwMDAwLGNwdS1udW09M1wNCj4gPiAg
IC1zbXAgNFwNCj4gPiAgIC1kcml2ZSBmaWxlPSR7SU1HRElSfS9pbWFnZS1ibWMsZm9ybWF0PXJh
dyxpZj1tdGRcDQo+ID4gICAtc2VyaWFsIG1vbjpzdGRpb1wNCj4gPiAgIC1zbmFwc2hvdA0KPiA+
DQo+ID4gSmFtaW4gTGluICgxNyk6DQo+ID4gICAgYXNwZWVkL3dkdDogQWRkIEFTVDI3MDAgc3Vw
cG9ydA0KPiA+ICAgIGFzcGVlZC9zbGk6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBhc3Bl
ZWQvc2RtYzogcmVtb3ZlIHJlZHVuZGFudCBtYWNyb3MNCj4gPiAgICBhc3BlZWQvc2RtYzogZml4
IGNvZGluZyBzdHlsZQ0KPiA+ICAgIGFzcGVlZC9zZG1jOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+
ID4gICAgYXNwZWVkL3NtYzogY29ycmVjdCBkZXZpY2UgZGVzY3JpcHRpb24NCj4gPiAgICBhc3Bl
ZWQvc21jOiBzdXBwb3J0IGRtYSBzdGFydCBsZW5ndGggYW5kIDEgYnl0ZSBsZW5ndGggdW5pdA0K
PiA+ICAgIGFzcGVlZC9zbWM6IHN1cHBvcnQgNjQgYml0cyBkbWEgZHJhbSBhZGRyZXNzDQo+ID4g
ICAgYXNwZWVkL3NtYzogc3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbiBvcHMgZm9yIFNN
QyBmbGFzaCByZWdpb24NCj4gPiAgICBhc3BlZWQvc21jOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+
ID4gICAgYXNwZWVkL3NjdTogQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiA+ICAgIGFzcGVlZC9pbnRj
OiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4gICAgYXNwZWVkL3NvYzogQWRkIEFTVDI3MDAgc3Vw
cG9ydA0KPiA+ICAgIGFzcGVlZDogQWRkIGFuIEFTVDI3MDAgZXZhbCBib2FyZA0KPiA+ICAgIGFz
cGVlZC9zb2M6IGZpeCBpbmNvcnJlY3QgZHJhbSBzaXplIGZvciBBU1QyNzAwDQo+ID4gICAgdGVz
dC9hdm9jYWRvL21hY2hpbmVfYXNwZWVkLnB5OiBBZGQgQVNUMjcwMCB0ZXN0IGNhc2UNCj4gPiAg
ICBkb2NzOmFzcGVlZDogQWRkIEFTVDI3MDAgRXZhbHVhdGlvbiBib2FyZA0KPiA+DQo+ID4gICBk
b2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJzdCAgICAgICB8ICAzOSArLQ0KPiA+ICAgaHcvYXJtL2Fz
cGVlZC5jICAgICAgICAgICAgICAgICAgfCAgMzIgKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0
Mjd4MC5jICAgICAgICAgIHwgNjQ4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIGh3L2FybS9tZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIGh3
L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgICAgIHwgMzYwICsrKysrKysrKysrKysrKysrDQo+
ID4gICBody9pbnRjL21lc29uLmJ1aWxkICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBody9p
bnRjL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICB8ICAxMyArDQo+ID4gICBody9taXNjL2FzcGVl
ZF9zY3UuYyAgICAgICAgICAgICB8IDMwNiArKysrKysrKysrKysrKy0NCj4gPiAgIGh3L21pc2Mv
YXNwZWVkX3NkbWMuYyAgICAgICAgICAgIHwgMjIwICsrKysrKysrKy0tDQo+ID4gICBody9taXNj
L2FzcGVlZF9zbGkuYyAgICAgICAgICAgICB8IDE3NyArKysrKysrKysNCj4gPiAgIGh3L21pc2Mv
bWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgICAzICstDQo+ID4gICBody9taXNjL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgICB8ICAxMSArDQo+ID4gICBody9zc2kvYXNwZWVkX3NtYy5jICAgICAg
ICAgICAgICB8IDM0NiArKysrKysrKysrKysrKysrLQ0KPiA+ICAgaHcvc3NpL3RyYWNlLWV2ZW50
cyAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgIGh3L3dhdGNoZG9nL3dkdF9hc3BlZWQuYyAg
ICAgICAgIHwgIDI0ICsrDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAgICB8
ICAzMCArLQ0KPiA+ICAgaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggICAgfCAgNDQgKysr
DQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NjdS5oICAgICB8ICA0NyArKy0NCj4gPiAg
IGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2RtYy5oICAgIHwgICA1ICstDQo+ID4gICBpbmNsdWRl
L2h3L21pc2MvYXNwZWVkX3NsaS5oICAgICB8ICAyNyArKw0KPiA+ICAgaW5jbHVkZS9ody9zc2kv
YXNwZWVkX3NtYy5oICAgICAgfCAgIDIgKw0KPiA+ICAgaW5jbHVkZS9ody93YXRjaGRvZy93ZHRf
YXNwZWVkLmggfCAgIDMgKy0NCj4gPiAgIHRlc3RzL2F2b2NhZG8vbWFjaGluZV9hc3BlZWQucHkg
IHwgIDYyICsrKw0KPiA+ICAgMjMgZmlsZXMgY2hhbmdlZCwgMjM0NSBpbnNlcnRpb25zKCspLCA1
OCBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2Fz
dDI3eDAuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2ludGMvYXNwZWVkX2ludGMuYw0K
PiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNwZWVkX3NsaS5jDQo+ID4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmgNCj4gPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NsaS5oDQo+ID4NCg0K

