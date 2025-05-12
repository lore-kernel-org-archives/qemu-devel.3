Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPgd-0005ZA-4j; Mon, 12 May 2025 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uEPgZ-0005YW-TK; Mon, 12 May 2025 05:42:59 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uEPgU-0008Ej-Fc; Mon, 12 May 2025 05:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ36bl/4ixQ4qr0DLLz7Ma9hy7QE4fxXSGgBkXQysMn2/HDtmBvz+VNmJpR0kvr4Ndy375GQMTf5wPPmGL/KEcpEN4R8kQz7GW2ywcE4DNaVRWMZkUuHXnVV5j/8BfJO6TX0OA7mFkhkCwEMGVjqj94VfAATV7I2YyotTryZkIJJ70mM6A7ec6SNSmsBuOVJZ1CqsjO77EZR0QFmzWfOKc8VqmbTym5gR0Eb9voEqYGdLUBAKczw1a1e2N3vvu1rDKpze4QnffDRmuooCmr6FcyizWZ1UfJTAm6B2K4bjg5f7iQBTb06fLDsIGab8aYM+y9GHoRVmCC25UL67uBkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orsd3+NDT/SQIPI5mOT4rZxUVNt8w2QHrjPspdJLVA4=;
 b=Pc/RnQi2nI8m02CUeexqfbskoA9VZvIh9suTqXhUFxs2BZ00ymJFKvN7Aavugf0WViapON4NRA0FNjZc9fU69OofMCT2h2ttIY28DsIXToIiR/yOmQ85rI59dvb+1xMyeoKvt76ij7EcDLu+a2UYHAPnXqiENcr7G3yiFetFmW9iKp6IhgGFGSEf7CTCcwjYH7HX4tY+AeKreBiygjFcl3TUuIHVfWPe69eOcnqFqa6vDSR1yNma2AoyS9p+h9Qsxmkwx0EVL49tPJ6J2gHo1xxWFgA9qu28kv9BQbvMW7CzBTBqNj3DdQ2xm3/Zc6KEzXBuvP70SUL4QPLJ8gknyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orsd3+NDT/SQIPI5mOT4rZxUVNt8w2QHrjPspdJLVA4=;
 b=BwJOfpEGaMMfRFYreZOcPxYBIx3z5wvdL8eKoSKYf3z02Q0m2QjkyyvBZr2U6G6G38/LL9+iUiOTrJPJz4/acKiSoWZ7lUnLX8cLM8xg0qBS+Gc5JvzHYSA43h6p0y3dolqH4NZBmzzrorV+PvRrAcZCCyMViM+QY7SmlOxuN5fCGb6TG4L8rTlGRf98ABs+AsbxdECxSJKiv5PlxLI+PSm4J3jLl5c5IEEEDUxTJ4LzfBFacLxln5dVFkglArcU2PgzEddBPXaY/nKBAXR8yZPqnSJ5WGF5ndI74jGmBqSWlm48UtBTIu6CV3q696YatWsxQ7NnjccoRugOEfOZ5Q==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB6720.apcprd06.prod.outlook.com
 (2603:1096:101:183::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 09:42:44 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:42:42 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 3/3] docs: Remove ast2700fc from Aspeed family boards
Thread-Topic: [PATCH v1 3/3] docs: Remove ast2700fc from Aspeed family boards
Thread-Index: AQHbvzg3ePeDD8Iqk0SBHD5oIBMHUbPOouCAgAAieiA=
Date: Mon, 12 May 2025 09:42:42 +0000
Message-ID: <KL1PR0601MB4180AC0E1F0C65EEA1802E8C8597A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250507101005.1474823-1-steven_lee@aspeedtech.com>
 <20250507101005.1474823-4-steven_lee@aspeedtech.com>
 <bbe8174d-0834-4f21-8566-0c24ba9b8a6b@kaod.org>
In-Reply-To: <bbe8174d-0834-4f21-8566-0c24ba9b8a6b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB6720:EE_
x-ms-office365-filtering-correlation-id: d3eeceef-60bb-40e9-6aa8-08dd91395795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ampzR3FJd1UwNSsyNk8ybU1jYkpKRVNrUVc5M1lKQit5S1ZjYThLMjdmVFFO?=
 =?utf-8?B?Z3lZUE1ZQmxib1lkQzZaQmdEcHorSTlYTDhoTEJQVFVKVGY2djQzZHk2ZmRC?=
 =?utf-8?B?VThVNnZLZWczL2hIUU9heDVZVTdwKyt1bm1FdldybDdwYjFZNk9XRWk1R3BW?=
 =?utf-8?B?SDFLUytMVjRKVjFSbTNiSTVlUEFFWUVOelBmMDcyY0p1dmg0UlBUZGtoTGJX?=
 =?utf-8?B?MTZIQ0lKL3FCT0kxMDhQK0pvVkVpOHk0a2h0OUFTLzBPbUdoTCtTQlN5M3V4?=
 =?utf-8?B?NGVNM3kyeFlyZGhWY0h3OVlNTnQzRjBqQlhEazZDN2FCRnJFelJQcWIwcVhQ?=
 =?utf-8?B?Z2tjY3FCOTVodjZoSC9yUHp3L3NodWlzd3d6L2hXTVpuYXpXWDRqaDlncE8w?=
 =?utf-8?B?ZGlVMFFnQ0M1bGV2SlhKam1GUXFwRHNYR2RJejQrZGljbVFLc29MVlhaN3lk?=
 =?utf-8?B?bHA4b3lqZmp0ZXBSNkUybDR5bmlseVJYTlBoZXRyNnhuc1RpT0l4bDl0ZlJF?=
 =?utf-8?B?NDVKbHZXSDY3REJqeVZ3bjhsVFNLYk10SXBPV3B5WmZOTHlOaU9leWJoSVQ0?=
 =?utf-8?B?bjdrNWtPWEQvVTZ4d0tQOGMrOUIyeTJ4RHh0Uk42V0lpL0tOb2hsYTBkbWs5?=
 =?utf-8?B?dXpHNHdQT1daOVh6ai9ka3lwV2xET2FmVjg3czI1L0R0TEZpUVNHMjhlemly?=
 =?utf-8?B?NUxnS1pxZi9lem8rTklDcGtsTUZQSlpBSzhxaUFEdVQrNmdKZXB2aE5UZy9G?=
 =?utf-8?B?UVBVb1pCK3hrTDRZYS85blZwUHZoZ1ZqV0RxYzBFRDF6ZHNsdXBVWEY3T2l3?=
 =?utf-8?B?cTJKSzBBVW1JTTg4NWsrUW1UbFFBUW1GcHpsLytiL1RpK1ZBbmZGT01LVG9q?=
 =?utf-8?B?R3FOSTIvbUZkOXRPVXg1NzE3aWZET2lCWDQ0T3hFU0tJZnBsQjFSbzE5SzBG?=
 =?utf-8?B?bGZYaHQ4RS9XOUxWRUdVNGFYVUJEbUdLTDhOTEg5UnZhU3pwVDdyYkFBenVU?=
 =?utf-8?B?UG5Mbk0zanVUQ2cvVDdmOUtRYllodm54RUhCL1JvaFNzQlRUenpuTlZ3bElR?=
 =?utf-8?B?cnlpZmhNUDJyQ3VQY0F0ZFA4ZVRYVURzM0hTK3Z0clI3TzhHNlVHdUV1MmpO?=
 =?utf-8?B?T2pxcFU2WXE4d016V2xYVmxrVmNuTFllc0VDbjhtckxrNERDN2RyazZ4aUZo?=
 =?utf-8?B?cjNkQXlZQ0RFdzJOZTRFeElCengwVk51NzVLbTUyK2hPVXhwNGxZZWJzRExJ?=
 =?utf-8?B?NGEyeXR6SzJzM1U5QmYxdDdNVWMxLy9iSndCL2NuSTB5Tk9BSE5BVEdWWWVU?=
 =?utf-8?B?N2k5ZlZ4ZjNTeEl1QmFKNTB3MVhTVUI1Vi9qc1ZGOVExRW9HMFZXd3JWbnZY?=
 =?utf-8?B?Ny9PVzVPVldTV2dET0xKVGxEUXRQNVg4V3hBMXNpQk9mNTFYZTdHNGUyVklP?=
 =?utf-8?B?TktZNXNLeWs0WS9GTFR6ajI3R1hrTnpZUThsSk5FTXcyenIvTG5ranVZRW5k?=
 =?utf-8?B?aFNKa3hhYmxHTHl2SnpNWkxscmFrRjFBQ0tSVFBkaURWSWVnbU5HWTJSdlhu?=
 =?utf-8?B?d29UajdBZFF1UEw0Q0ZWRC9RalcwVjNsNkl4eHF2VFkzZ2ZMMFlOc0FxSDNH?=
 =?utf-8?B?WTlPTUJ3VVI4SFFNbDZ1MEJNWjNoN0tLRks5YXAxejd3Q1FxSCtybTBOOC9G?=
 =?utf-8?B?Vm52RnBsVWdsWEtpQm5ROHVacUc3VHVKcDhlMG4vZHFoTmFLSUFpSklhWXZ3?=
 =?utf-8?B?d2d5YlFMN0RKYUNrQWhHWW4ySThIeFFKdWpzcUg5NTdDajRET2QzL0xuNGpk?=
 =?utf-8?B?MG8wMVZ5SndCUXRPU2ZQRHJHTE5ZUmNUUGs2MEV3bjV0OTZWc1E2MWw1dzYx?=
 =?utf-8?B?cDhGalJBZnFmcDRTZmNOaTlPOGtOK2pxSmF4WURFRXVPeFJONEpQUkV1U0Fv?=
 =?utf-8?B?TGtmSkdlU1Y4c2ZDS29nbHFtbHZMQkdKOHhlRjdFZFBkeWx6NXFnbW9rQVR2?=
 =?utf-8?B?YUozaFg5Y1BRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmtTOEJyZm9TS05RdWRuc1RhaXpaS2RtTG8zK1VpMjc0R0dtbE00VUl5QkZy?=
 =?utf-8?B?TU0wOEF3T0FxVlVyWHc5RDJLTkN6bXpZdDl3U0J0S3NpMkE1MndVN0tnVDAv?=
 =?utf-8?B?eXpXaDNMY0lPU0JTTnE5UDBiSXJmQ3E1TFNzNU1uaFZWMEdZQmVmK2YxM3FY?=
 =?utf-8?B?bVNjNWs3YVFudS9BRElDZ3N4L1dyTTFheVVTT09LdDBFeGwyS0lHcURGU2dN?=
 =?utf-8?B?UGtMcVFlL2tKSnZXOEFTN3loZ29XZHAyZ3Z3SUYvYndyMyt5eHM2bGFBaEUz?=
 =?utf-8?B?K3dhU0dEaFVyRkZjUTV6T1Z0dHRUN3VPRmdEQVJsb1Z4VnAzOGYxZitLelh0?=
 =?utf-8?B?TGM5MGJTVnJYSENXT0NMMk8wdlZiRi9NM3pyUEkyT1FYNkdtS2d1WFVXYlRB?=
 =?utf-8?B?SHc5ajN1UllSVzh1TGtYRzZ5WTRGNjIyQnRtekJENzBRSEVHTno0OXM0T2ZO?=
 =?utf-8?B?NUZWQjlzcGRURENKalM2VHNRREJMNDMvTWE4cnJJWERjMUliM29Ld0I3NExU?=
 =?utf-8?B?dFcvMG1RM2VnbFBTMUJSOFVzczlQSS9hN01uS2d2QU1LNnlDNVhLb011TGZl?=
 =?utf-8?B?SnFDOUpVdWh2UFVRS0pMVjBWLzZCc3pWam1xT240R0J2dUVPRG5keGE5MXp3?=
 =?utf-8?B?Y3V2YmF3SlVzcHhwc21BWG4vcTFmNFdRTFRycS9LWDFUd2VkSTFzZWZpUXVq?=
 =?utf-8?B?QjNqUWh1Rm5SR2pYdmJsMG42SjF3MC9IL3pIT21GMnVrQlRyc1dxZDlPM1FF?=
 =?utf-8?B?ckdwMldwVFFiNkNJRXBsdjlCTUEyWmZOSDAzd3ZjK1FhZm95emlwTnAxQ0lB?=
 =?utf-8?B?Ukx0VDdEbTRhT3JXN2pNSThvZko1UThtaWcwNUVYNHROSUNmN1Q0ZWtueWEz?=
 =?utf-8?B?VmpTM0Jtd2dndFBrWXVERUtFekp1TE15QUlaSXNXZ3RCaUxKVThRbUcrcEFI?=
 =?utf-8?B?RXNRdi9ZQk9rQnlOUEVtYitMMDBiRU41YnN4NTJHRTh4alNJa2d3Y2hwZmJq?=
 =?utf-8?B?OVVKM0RuZ1gxdk5XU2E2QmllUmdrZHd1a0FXRGQ1WWN1d0EvNE5RZ3l5TURX?=
 =?utf-8?B?WDJUWXl6a0ExSkl4Yy93Mko4Y2lZREwybjFycExXRmNTenMzNGYyN0NTK0ZS?=
 =?utf-8?B?dDd4UytlSGdwaEZKT0lGSmExMlkxN3ZUNk0yNVhVcGFINHdzcit6WlU0TnU2?=
 =?utf-8?B?Mm0zWVV1UFlNdVhhWmZpSzhlanZVWDJhRVViOHJZeTFNQW1EdVpVeDIyWW9L?=
 =?utf-8?B?dVB6S1dNR2JRcGlkM2JFMUtYaEkrNFhiZmtKaUd5QlMxTDExZ2hqVkYrV210?=
 =?utf-8?B?Z1dQblFFeHBpWER1VDJ3ZE1mbFB4a2F6RzBHa2lJbk5KUmdrcCtjZGM0bk9n?=
 =?utf-8?B?MlM4d09vQ0g1TUJFRVhIMEF0d0ROYmo3ejA4SFcwMmhYNFdnU2p2N21ZdFN1?=
 =?utf-8?B?VzhrU1FscmJONlRBMW0yczZuNG8wRlkzcFczcE0zc3hzTTVzTlpJanN0Z092?=
 =?utf-8?B?KytSenk5ZUxFQ0dWVURLeDQxSTUvSElQdmhXbGE0ME5KWldBUFM4aHd5c01F?=
 =?utf-8?B?ZXBobEIrV0dCY0l3WjR4V3BUZlUxRSsybVh0MlAzai8vZUJBVFg2b0dHUnF5?=
 =?utf-8?B?bXMyYlpGb3NUUi9yT0Qydy9LWEROMW1lcmtHek85S2pTL0czZGhaNjh3NnFu?=
 =?utf-8?B?N0ZqMlBrMkZDbnMxaVZWNWZUZ2JRU0phYmlSbk5ZMk9kcFFtM1hNdGNiN2t2?=
 =?utf-8?B?N3FCS1lMQ0FyQytIZElpaThrS3hIbmpUWm9Ba1pIdTVPaDY1czhxS1FmdWQw?=
 =?utf-8?B?ek5Sb2F6WDM0T1ZuSnZUUk5jSEpaYWk1S3F3SlpFWlQzdDFMM3NheHptbVlU?=
 =?utf-8?B?aXVGVUNGc0J5VW9JMDNzV3gyMUU1ZWZrQ3Z0RWFjanJ5QUJGT1ZUdGdKQVZy?=
 =?utf-8?B?NzRBUW1IQktzUEhSL3c1U0dMQXVnQUV0a3ovem5KaytnYVdwT3VBZXF3WEps?=
 =?utf-8?B?UUlZUldWWkhNR2NDbXEybUdteEQ0TUVpQ1BYOEsyU2VPUEZKNDhObUYxRFNi?=
 =?utf-8?B?QnhEczVlQStzUVFCOWp4RFJnNEc4VFRZUWFPVTFpL3FsVVFjaEFFU3pEdHg1?=
 =?utf-8?Q?7X1Kw1lrSw0d8178uaWXBHuam?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eeceef-60bb-40e9-6aa8-08dd91395795
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 09:42:42.4983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDVV0PmiYO24jKieTVsohbVFtopVFTVsNB5fvlcddaVGGyv6Pq+5ieW3oM+hVfHD+ummGe+aUB0Lrho8i2RTz+VYQUPv//rR2bb5UXu78eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6720
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=steven_lee@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSAxMiwgMjAy
NSAzOjM3IFBNDQo+IFRvOiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUgPGxl
ZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBT
dGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1h
cm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+
OyBsb25nemwyQGxlbm92by5jb207IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0
ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAzLzNdIGRvY3M6IFJlbW92ZSBhc3Qy
NzAwZmMgZnJvbSBBc3BlZWQgZmFtaWx5IGJvYXJkcw0KPiANCj4gSGVsbG8gU3RldmVuLA0KPiAN
Cj4gT24gNS83LzI1IDEyOjEwLCBTdGV2ZW4gTGVlIHdyb3RlOg0KPiA+IFRoZSBhc3QyNzAwZmMg
bWFjaGluZSBpcyBub3cgY292ZXJlZCBpbiB0aGUgZGVkaWNhdGVkIGFzdDI3MDAtZXZiDQo+ID4g
c2VjdGlvbi4gTGlzdGluZyBpdCBpbiB0aGUgZ2VuZXJhbCBBc3BlZWQgYm9hcmQgZmFtaWx5IGxp
c3QgaXMNCj4gPiByZWR1bmRhbnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGV2ZW4gTGVl
IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IENoYW5nZS1JZDogSWMyNzg0ZDYwY2U0
NjgxZjM4MDU5ZDY4NGY0NzdhMjk2MmNjZjhiZjgNCj4gDQo+IFRoZSBDaGFuZ2UtSWQgdGFnIGlz
IG5vdCB1c2VmdWwgaW5mb3JtYXRpb24gZm9yIHRoZSBRRU1VIGdpdCB0cmVlLg0KPiBDb3VsZCB5
b3UgcGxlYXNlIHRyeSB0byByZW1vdmUgdGhlbSB3aGVuIHNlbmRpbmcgYSBzZXJpZXMgPw0KPiAN
Cg0KSSB3aWxsIHJlbW92ZSBDaGFuZ2UtSWQgaW4gdGhlIHYyIHBhdGNoIHNlcmllcy4NCg0KVGhh
bmtzLA0KU3RldmVuDQogDQo+ID4gZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQu
cnN0IGIvZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QNCj4gPiBpbmRleCA1OGE4MDIwZWVjLi40
M2QyN2Q4M2NiIDEwMDY0NA0KPiA+IC0tLSBhL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+
ID4gKysrIGIvZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QNCj4gPiBAQCAtMSw0ICsxLDQgQEAN
Cj4gPiAtQXNwZWVkIGZhbWlseSBib2FyZHMgKGBgYXN0MjUwMC1ldmJgYCwgYGBhc3QyNjAwLWV2
YmBgLA0KPiA+IGBgYXN0MjcwMC1ldmJgYCwgYGBhc3QyNzAwZmNgYCwgYGBibGV0Y2hsZXktYm1j
YGAsIGBgZnVqaS1ibWNgYCwNCj4gPiBgYGZieTM1LWJtY2BgLCBgYGZwNTI4MGcyLWJtY2BgLCBg
YGcyMjBhLWJtY2BgLCBgYHBhbG1ldHRvLWJtY2BgLA0KPiA+IGBgcWNvbS1kYy1zY20tdjEtYm1j
YGAsIGBgcWNvbS1maXJld29yay1ibWNgYCwgYGBxdWFudGEtcTcxbC1ibWNgYCwNCj4gPiBgYHJh
aW5pZXItYm1jYGAsIGBgcm9tdWx1cy1ibWNgYCwgYGBzb25vcmFwYXNzLWJtY2BgLA0KPiA+IGBg
c3VwZXJtaWNyb3gxMS1ibWNgYCwgYGBzdXBlcm1pY3JveDExc3BpLWJtY2BgLCBgYHRpb2dhcGFz
cy1ibWNgYCwNCj4gPiBgYHdpdGhlcnNwb29uLWJtY2BgLCBgYHlvc2VtaXRldjItYm1jYGApDQo+
ID4gK0FzcGVlZCBmYW1pbHkgYm9hcmRzIChgYGFzdDI1MDAtZXZiYGAsIGBgYXN0MjYwMC1ldmJg
YCwNCj4gPiArYGBhc3QyNzAwLWV2YmBgLCBgYGJsZXRjaGxleS1ibWNgYCwgYGBmdWppLWJtY2Bg
LCBgYGZieTM1LWJtY2BgLA0KPiA+ICtgYGZwNTI4MGcyLWJtY2BgLCBgYGcyMjBhLWJtY2BgLCBg
YHBhbG1ldHRvLWJtY2BgLA0KPiA+ICtgYHFjb20tZGMtc2NtLXYxLWJtY2BgLCBgYHFjb20tZmly
ZXdvcmstYm1jYGAsIGBgcXVhbnRhLXE3MWwtYm1jYGAsDQo+ID4gK2BgcmFpbmllci1ibWNgYCwg
YGByb211bHVzLWJtY2BgLCBgYHNvbm9yYXBhc3MtYm1jYGAsDQo+ID4gK2Bgc3VwZXJtaWNyb3gx
MS1ibWNgYCwgYGBzdXBlcm1pY3JveDExc3BpLWJtY2BgLCBgYHRpb2dhcGFzcy1ibWNgYCwNCj4g
PiArYGB3aXRoZXJzcG9vbi1ibWNgYCwgYGB5b3NlbWl0ZXYyLWJtY2BgKQ0KPiA+DQo+ID4NCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiA9PT09PT0NCj4gPg0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID09PT09PQ0KPiA+DQo+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gPT09PT09DQo+ID4NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT0NCj4gPg0KPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+
ID09PT09PQ0KPiA+DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPT09DQo+ID4NCj4gPiAgIFRoZSBRRU1VIEFzcGVl
ZCBtYWNoaW5lcyBtb2RlbCBCTUNzIG9mIHZhcmlvdXMgT3BlblBPV0VSDQo+IHN5c3RlbXMgYW5k
DQoNCg==

