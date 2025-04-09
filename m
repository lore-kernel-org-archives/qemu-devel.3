Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CF2C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 09:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2RSK-0001MC-K4; Wed, 09 Apr 2025 05:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u2RRs-0001HT-At; Wed, 09 Apr 2025 05:10:24 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u2RRo-0008SK-4i; Wed, 09 Apr 2025 05:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDD+pH2JGZYIwT67M8cdgVZUCIC2rX+MNWcMC1fKzEYl9O1aYfhV+nLWDouS8QWDE6Sm7q/3sKwTrFNTc9037TEE+VxtYCdBFzMO12uSLj5E4AWQcQxpKrkxm+R9fyDjRhTOsSLKzCvLYyUko75ORk1NkzEBEJ+Jhoh0rv7F7dbMVY4zKpESx4PF1IKGhzaZg64ro4uB4vdNvjS/vFN4ZrT9oGqsk1+KuxOb8XluAR8ducA8TTmS+St9JxTG1jXn4AsNxB8mrqfSivXniSd51imCVcXpxgtF+xyRJHV7S4FdusCjVw3feUuNdYCz0AGiHSfVBfvXJWkxtnSe3M1nMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifgVMsbGsyo4FpraR7IV5yjU46dF+lrZSQJ7CgPtuB0=;
 b=M0/CEoDzWvrCSoznq/ME00sSQR6vYtQLzZx1Rh/Nz+KLeeHhY2ESqZZCDZoALvArU5NShOCZC53bboIPNtZkACJwgK5OOjLZZkaougb3KngsZcbF9JNBadIF4EM3rlk+tm6X8VgVMMNj+fhHn8ayGKFPWHNrG0XrUBI+6tDgUuH8qM6Upc7jYOBu5bmmnwnYzM/m5Rr3H9UoC1WrFrt5EcTObPBsfvkhiYJe2rDs5fNCeK6r9zCgm2yngpJIKU2Xe2+Z9zti03ikWd07Av/3O0dOQdkeAY1Kors9SBuKPhVEEfx1wSbqwSZwoKTuhB5SYZU6SR11LoytMXGJUkpH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifgVMsbGsyo4FpraR7IV5yjU46dF+lrZSQJ7CgPtuB0=;
 b=ShtreG6w7XOEAUPwXAG2VGrejNh8detg7m7ofmnY58mmhfb86m3l9t9Cwn6rgPccY91b367d3+BGyOaT0opDAVMFgG5Kw4WfqdAlYI48DHlUIe6tTmQ1tKXM5G7tSk6ALel1QvV/qTlX/XhWFyGqEGfkD+zs0jh8aFS/vGfFg3C2u+GkEGlGcgNoj+wQk4BHtck5HV/x+WBbSy3STwi4Fm6laRgXG7grsAVzTIMyRxXOrgcIrL6NYSXiUS3V2oRmlOThS4UVI+CP+h9hC2PsTDGBZSFJdWkD4zCPGDxshcvtU0MnDGkj9gMrBUGK9RbRwQ1OVo+Lds97BLmod3U/PQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5429.apcprd06.prod.outlook.com (2603:1096:4:1b9::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.35; Wed, 9 Apr 2025 09:10:03 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8606.028; Wed, 9 Apr 2025
 09:10:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Thread-Topic: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Thread-Index: AQHbqF/AxGlF3OLqIUu6xvdrbqhw7LObC2tA
Date: Wed, 9 Apr 2025 09:10:03 +0000
Message-ID: <SI2PR06MB50412DDB7CEE6844C1E5B953FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250408082504.3060742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20250408082504.3060742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5429:EE_
x-ms-office365-filtering-correlation-id: 3996d845-3646-43bc-1389-08dd77465020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QzdMeThOQTBjbENRTmUrQ0kwZWtjSllkdDNqaFFYMkl3QURCUkdyV0JzRGhF?=
 =?utf-8?B?RVRGMkNRQktHVkI3LzJWSXhOU0lFQWQ0blhVUkFhVGFKRXduYnJJc0JvMUNO?=
 =?utf-8?B?cXplaGpyTHBwdEllMzJsZnhLOVNyL1NlQ09QSWFqWDF3aWVDNVcxN0lLOVl1?=
 =?utf-8?B?VnJsSVROdzQxQ0ZDeCtocXBHRHpBelF1Qzlaa1o1VGt5b0FaNks1Uy9QZ0JC?=
 =?utf-8?B?YkRTZ1dMSnFCWWU1dEtnUGpTNHQvNlBnOUlSVm93a1o1L1hNTTRKdTNOWjZi?=
 =?utf-8?B?cWV3Nm5tOUhGa1hwUVRrZzkvcHBKbGNZZkpuOGRhdDFobHBlSGc1clFuY0Rw?=
 =?utf-8?B?Zm1mbW9EV2tpYUdIejMza05CcTR0R1Yxd3pwWlRuWW90KzJYZUpHcW5Yc1pv?=
 =?utf-8?B?MldvVFNUdDVYdXJjMFZuakpuV2dDdzNsY2lYbTRhVlJhTG1zWG0vblVoWlV6?=
 =?utf-8?B?bXZibEZXMUdrM3k0NjY0S1pPYmp0UHBwNjV5bVNIZVFuRm9obGNtUUZJcnEv?=
 =?utf-8?B?OXNORk5jMnNaLzYzdENlS0hFaHo1TjZOQng1QkdlV1FWOWQyT05ObThsc1hz?=
 =?utf-8?B?TllVQ0JteXRvN2lTOWJNQ2FFTXN1WlNzdWFpTTZORkNSd3JtZnhTbVNhR2lu?=
 =?utf-8?B?OWI4aE5JRWEraUhyaUFsZE5BT1VPYmRIaUhyVFgvdkJVcWpHNEkxNWhYQnFB?=
 =?utf-8?B?ODYwNlNOVllidWQ4THlvWTBFT3dudzNFZDNsV0ZpUTBGalhUcVV4Z0Mrb2di?=
 =?utf-8?B?cVgreHlwNCs1NHJVN0hzekl4Y0tjT1VpYlloUjNtbzN1bVlwSFh4SEpiYStq?=
 =?utf-8?B?a3pSWkZiYXhiOGJ4TDVvTHdQUTdBVFIvSVhnazZNZkRzckViTmVsZDF1eExi?=
 =?utf-8?B?V0hxVFdvU1NuVWtINDhLb2NEQVRPdExWVU5lRVVGTmJQd3lDRk5oMXg0SzUw?=
 =?utf-8?B?Zmw0aVNBYUN3U2tRVzJGRnVHcW5EbzVkRlUycE15UWRYWDZ1ek41NkE4dXhX?=
 =?utf-8?B?OXAxZU5VV1ptd3dIR3M2Y1J5LzB4c1JPdkxDTXNDMnllcUpVclFYWHM3L1RO?=
 =?utf-8?B?c0FZbmx5ZTBrL2ZnOVM4TVcxZ3g4NFBsNFl2UEpVZkhMaVdZVGN5a0lMT3Vk?=
 =?utf-8?B?REJtam5LaTdkSytOeUw3d3FYRHlZcHBEZWpTeE9Lcm1mY1FtNjQ2aXZKNUFk?=
 =?utf-8?B?M0xjMW05Z2lWYVhKUjZncElaQ0V0cUNVYzhSaGhRclpPQ1lnbXRZb2tES3NG?=
 =?utf-8?B?eVhJSzh1U3libjVJdUlHaTE4Y09GWlZDMHhUYW9wbnRKdDhwL1RRTXVkeUpt?=
 =?utf-8?B?VkZWNUEzaVFGZmlhR3RhV1pTQVJudXpsVURPZk41djA5eitFeEZlZlBhdjVB?=
 =?utf-8?B?SGZIZ0hDNHJwSm91Y0dQWloxUXMwTTg4clNDK0xPcWV5R0ZCWG9jeStXT2Vj?=
 =?utf-8?B?WDArNVNpbTZUcDJvSnlQOW1xZzFlOFh1Tm9NOC9qelZmd3p6M1JUQXdRUzA0?=
 =?utf-8?B?M0xHeWl4TmdhaXIwMnRVTVdxTnVtd2FyYnJKZFN4aG0rTlA0Ty84Q1JJS1d2?=
 =?utf-8?B?ejlzZ3lQaWQwRGJEYWtaaFBuc2VVeEFrbEZCSk84MUdJVDByckptbzJqaW5l?=
 =?utf-8?B?SWJGbDZURitqSVdUUkJ3QUZUUmJxSFNnZ1hYblp6a1R1Ym9rekc5eEtBWG1U?=
 =?utf-8?B?Y0tobk16WmlybXZNeFFPY0VGOXNmeFBBVFJDOFNFRm03VDVnVlRBa1RvQWhM?=
 =?utf-8?B?SC93T1BLRW9sS1crQmloRGxoRnhqOEJTbnpYcnNQUUQzS0FLRVNoRkpHSHZC?=
 =?utf-8?B?NDN6Uy9rOW1Bdi90UWUyMDNWdG1RZDh3SzlBZ1hoUHVXRnk4YXFwY1JIblBt?=
 =?utf-8?B?NnFpME96bkhUU3BYdEhubG85WE93dlM2WHZLam5nMmFnUFpYdUxKTXZPUXBY?=
 =?utf-8?Q?rq3zoSO+/jZobPqkIImO6viZ7IYQFAnZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck1NOXNWZ3puSndjWGk3VmkwSFBxckJ0VXYyUVROQndEZnVock9Ubm5GSkFN?=
 =?utf-8?B?N1lRbkFqSTd1d2FSUUFnZVVmdGxUZjZjWDdkTG9QTjVFeG15Q3V2ay9POXRX?=
 =?utf-8?B?MUp5V25Xc1JlZ0FYdHFXTnNqTFozK0dPTkxMVForL0dhTUYyWHpLNjFXbVJH?=
 =?utf-8?B?cUQyQTBHN1pWUjR6SS8xNGd4OEFPZ285ZlBuM0VsU1dFa1hMMmpaOEN5c0ow?=
 =?utf-8?B?Y0o4aUNzSWt0UzRvSWFVL0pTYzRSSDBTU1FPeXc5U0U0ODVpOElrYUlxTFly?=
 =?utf-8?B?QzhRRjJhdEpBNVZGZkRLOXJJb0E4R1lsQkZwaDRHMG1kZmdPcTIwaXFCMWx6?=
 =?utf-8?B?Rkh3U3NTSFlRaFkrTFdmUEJJSXc2aEtlQUNGVVFvTWo4OWVJb2xOa2ZjVmhG?=
 =?utf-8?B?d24rSTlUejlvR05MT2llNXJvNlF1eGhwem9GWHJrM0ZTa1pYc1JBTWljSXJH?=
 =?utf-8?B?bVNta1p3OEVPVFVhVTVtN2FkV1N5NFBwM3NJYkR3U1I1NEEyajVBcDBzL3N3?=
 =?utf-8?B?QTczc3lKNFNxSGFieiszS0J4WEdKak9VVEZuR0taU2dDdEFLRVhXUVdFOHNU?=
 =?utf-8?B?d1kvQjZmcy9VUEhhVWdUMDN4NWJQSEphQTVrN3BsS2FDQStsZ3R0SzNMUXRk?=
 =?utf-8?B?NFcxOHBSSjZmTmtEcVdIaFRwVlMzNEJsUnVZYjFKUmJVTGtHdkxPdXhFcjFB?=
 =?utf-8?B?YXl0bWVEU1JSa3ZBT3VTTXMvemNvVVBoZ3hEWUxXUWlqb0NmSjAxa09qbXk0?=
 =?utf-8?B?U3VZN3Bkb1hlZUZWMnMveE95VkUzZ1kvMGNNS1JzK1JuaGpXMWtYUEc0YVMz?=
 =?utf-8?B?aDVRa1YzK2toRVNDQmNMQnRNRW0xVzNtWFZnSWlpOXMvb1FtQ2dEVDVEQjlm?=
 =?utf-8?B?NDFuVnhVekg1cXVVUkxRWFVMWGxGYnQxNFlOV3ZVYkgyTmtwVVpUMjRJdXUw?=
 =?utf-8?B?N202amF5RFB6UTMrZnV5RTkxY0N2MG1NcFNsQWdTT2c5RTY0N1ViTWt3dU5p?=
 =?utf-8?B?YllXK3RROFFjWkFlOVFyYS94UEFkaE81SEczZ0lWa0FTa1ZsRDJKQnEzWTFI?=
 =?utf-8?B?bDZKckJvR3JyeEhESXBHT3hiR1dabUJQcUovQTh1bXpRUDR2M05kaTB2MkFy?=
 =?utf-8?B?Qzh1YTBzK1lRd1hwQjRRcmNySVpFZ0p4OENvNDBzRGN4OElheXVlblJhcTFC?=
 =?utf-8?B?bVVTSWdjRHd6ZmIwMUd0bkZWZkRFb3BpcDVMQk5XMTFWODVGaExJT2dZNmZ1?=
 =?utf-8?B?bDVybi83ODVoVldZSDdqZjcxS2xGVGMrc2x3Tzl3NitsdHhPM3VjZ3pVYXFR?=
 =?utf-8?B?eC93NlNLS1ZCY2RWbXZtcDdiSDI3TGlUdDJCSS9EeUoxOGczZTB6STVQajVT?=
 =?utf-8?B?eTAzVWZLRkJLeStvYkk4bWNmdElZSEZza01EMEwwVklkcXM5UEdwZER4Q1hW?=
 =?utf-8?B?YnUyWlJ1dk9qcWorT1JDcmZGNmg0eVlCd01Rb0ZJWlNJaGxiSVZTMGZaUncv?=
 =?utf-8?B?Wmlocm5UL05JYll1eUJEVDJydVJyR0VNNnhCUTlQL1QwRUpkc3hhU0NFT3pt?=
 =?utf-8?B?SnFNZ2tiYjg5U0EzUkRnTG5JVVJObnZ3dzF3bXUxZlZHQ1BhR0g2Qm5ZZTlw?=
 =?utf-8?B?Z3NLa3d0S216eXlrN2tyYVVDUFBmRVNmZFFCaTdZODgrZVFhUml5NWtzR241?=
 =?utf-8?B?N0N1M3pwWXVwVC9waW9ubTdlRWpOT3BreVhQVENNOGJiV0Q2MExPTGRlRTdM?=
 =?utf-8?B?NldKTmVLdkh6ZFZ2aGNCa1J2NFpaWkdYaTd1VHBQbis1ZFNuNlVpZzhkMWFO?=
 =?utf-8?B?ZlYyNHVhVlhQUUcrYXRodm5BQzc0VktOR29iQ0lucjdmWmlqU2xLVkdtR2VU?=
 =?utf-8?B?MGJwOHladldqcjZxelgzK2Nya0podmVKRk1UZ0NRdm5VMDRiZFdiUDFIbDE0?=
 =?utf-8?B?WlZBNnovT1RsZEw4SWtuS2Q1SFd2SXRCSkxLUmxoaVRkY3ZqRkNlTHBaZXJ6?=
 =?utf-8?B?aG5jTXRXMEZsaTExeG1DOEJBdzBOeDIzUVlucTQxcUF2cUlPVEJmSlFsMTAv?=
 =?utf-8?B?akpMZG4zVHA1Y1haNktha2hRS252OEtROEpIOExJVlpGSVd3enhxSWVGV3hH?=
 =?utf-8?Q?Y4mOQwkd1LdijRBv6FlW5rFQV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3996d845-3646-43bc-1389-08dd77465020
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 09:10:03.1741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJ8JsFELndsgbeGsWhrIGkTdXqZav1A7x8erlPFAQvcBSaC/Fw3gX8ZxFHxCQuUEknTv42Ej/O15p+BDpKKx1F2BE3djltT8KQyqlfdmrGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5429
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQpBZnRlciBkaXNjdXNzaW5nIHdpdGggdGhlIEkyQyBoYXJkd2FyZSBkZXNp
Z25lcnMsIHdlIGNvbmZpcm1lZCB0aGF0IHRoZSBJMmMgZGVzaWduIGluIEFTVDI2MDAgYW5kIEFT
VDI3MDAgQTEgaXMgdGhlIHNhbWUuDQpUaGUgZGF0YXNoZWV0IHdpbGwgYmUgdXBkYXRlZCBhY2Nv
cmRpbmdseSBmb3IgQVNUMjcwMC4NCg0KSG93ZXZlciwgcGxlYXNlIG5vdGUgdGhhdCBiaXQgMTUg
YW5kIGJpdCAzMSBhcmUgbm90IGF2YWlsYWJsZSBvbiBBU1QyNzAwIEEwIGFuZCBGVyBkbyBub3Qg
c2V0IGVpdGhlciBiaXQgMTUgYW5kIGJpdCAzMS4NCkFTVDI3MDAgQTAgd2FzIGFuIGVuZ2luZWVy
aW5nIHNhbXBsZSB2ZXJzaW9uLiBHaXZlbiB0aGlzLCBJIHBsYW4gdG8gcmVzZW5kIHRoZSB2MyBw
YXRjaCB3aXRoIEFTVDI3MDAgQTAgZXhwbGljaXRseSBtYXJrZWQgYXMgdW5zdXBwb3J0ZWQuDQpJ
IHByZWZlciBub3QgdG8gaW50cm9kdWNlIHdvcmthcm91bmRzIHNwZWNpZmljYWxseSBmb3IgQVNU
MjcwMCBBMCwgYXMgaXQgaXMgbm90IGEgcHJvZHVjdGlvbi1ncmFkZSBzaWxpY29uLg0KDQpJIHdp
bGwgcmVzZW5kIHRoZSB2MyBwYXRjaCB3aXRoIHRoZSBzYW1lIGNvbnRlbnQgYXMgdjEsIHNpbmNl
IHRoZSBvbmx5IGlzc3VlIGluIHYxIHdhcyBhIGZ1bmN0aW9uYWwgdGVzdCBmYWlsdXJlIG9uIEFT
VDI3MDAgQTAuDQpBcG9sb2dpZXMgZm9yIHRoZSBpbmNvbnZlbmllbmNlLCBhbmQgdGhhbmsgeW91
IGZvciB5b3VyIHVuZGVyc3RhbmRpbmcuDQoNClRoYW5rcy1KYW1pbg0KDQoqKioqKioqKioqKioq
IEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNCuWFjeiy
rOiBsuaYjjoNCuacrOS/oeS7tijmiJblhbbpmYTku7Yp5Y+v6IO95YyF5ZCr5qmf5a+G6LOH6KiK
77yM5Lim5Y+X5rOV5b6L5L+d6K2344CC5aaCIOWPsOerr+mdnuaMh+WumuS5i+aUtuS7tuiAhe+8
jOiri+S7pembu+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7tuS5i+eZvOmAgeiAhSwg5Lim
6KuL56uL5Y2z5Yiq6Zmk5pys6Zu75a2Q6YO15Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA5pyJ
6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI5L2cIQ0KDQpESVNDTEFJTUVSOg0KVGhpcyBtZXNz
YWdlIChhbmQgYW55IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBsZWdhbGx5IHByaXZpbGVnZWQg
YW5kL29yIG90aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2
ZWQgaXQgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwg
YW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgd2l0
aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5b3UuIA0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA4LCAyMDI1IDQ6MjUgUE0N
Cj4gVG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBQZXRlciBNYXlkZWxsDQo+
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVl
ZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgQW5kcmV3IEplZmZl
cnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBq
bXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+
OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3Jn
Pg0KPiBDYzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZQ0K
PiA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gaHcvaTJj
L2FzcGVlZDogRml4IHdyb25nIEkyQ0NfRE1BX0xFTiB3aGVuDQo+IEkyQ01fRE1BX1RYL1JYX0FE
RFIgc2V0IGZpcnN0DQo+IA0KPiBJbiB0aGUgcHJldmlvdXMgZGVzaWduLCB0aGUgSTJDIG1vZGVs
IHdvdWxkIHVwZGF0ZSBJMkNDX0RNQV9MRU4gKDB4NTQpDQo+IGJhc2VkIG9uIHRoZSB2YWx1ZSBv
ZiBJMkNNX0RNQV9MRU4gKDB4MUMpIHdoZW4gdGhlIGZpcm13YXJlIHNldCBlaXRoZXINCj4gSTJD
TV9ETUFfVFhfQUREUg0KPiAoMHgzMCkgb3IgSTJDTV9ETUFfUlhfQUREUiAoMHgzNCkuIEhvd2V2
ZXIsIHRoaXMgb25seSB3b3JrZWQgY29ycmVjdGx5IGlmDQo+IHRoZSBmaXJtd2FyZSBzZXQgSTJD
TV9ETUFfTEVOIGJlZm9yZSBzZXR0aW5nIEkyQ01fRE1BX1RYX0FERFIgb3INCj4gSTJDTV9ETUFf
UlhfQUREUi4NCj4gDQo+IElmIHRoZSBmaXJtd2FyZSBpbnN0ZWFkIHNldCBJMkNNX0RNQV9UWF9B
RERSIG9yIEkyQ01fRE1BX1JYX0FERFINCj4gYmVmb3JlIHNldHRpbmcgSTJDTV9ETUFfTEVOLCB0
aGUgdmFsdWUgd3JpdHRlbiB0byBJMkNDX0RNQV9MRU4gd291bGQgYmUNCj4gaW5jb3JyZWN0Lg0K
PiANCj4gSWRlYWxseSwgdGhpcyBpc3N1ZSBzaG91bGQgYmUgcmVzb2x2ZWQgYnkgdXBkYXRpbmcg
dGhlIG1vZGVsIHRvIHNldA0KPiBJMkNDX0RNQV9MRU4gKDB4NTQpIHdoZW4gdGhlIGZpcm13YXJl
IHdyaXRlcyB0byB0aGUgSTJDTV9ETUFfTEVODQo+ICgweDFDKSByZWdpc3RlciwgaW5zdGVhZCBv
ZiB3aGVuIGl0IHdyaXRlcyB0byBJMkNNX0RNQV9UWF9BRERSICgweDMwKSBvcg0KPiBJMkNNX0RN
QV9SWF9BRERSICgweDM0KS4NCj4gDQo+IE9yaWdpbmFsbHksIHRoZSBkZXNpZ24gb2YgSTJDTV9E
TUFfTEVOICgweDFDKSBpbmNsdWRlZCBidWZmZXIgbGVuZ3RoDQo+IHdyaXRlLWVuYWJsZSBiaXRz
IGZvciB0aGUgY3VycmVudCBjb21tYW5kOg0KPiBCaXQgMzEgZW5hYmxlZCB0aGUgUlggYnVmZmVy
IGxlbmd0aCB1cGRhdGUgQml0IDE1IGVuYWJsZWQgdGhlIFRYIGJ1ZmZlciBsZW5ndGgNCj4gdXBk
YXRlDQo+IA0KPiBJbiBvdGhlciB3b3Jkcywgd2hlbiB0aGUgZmlybXdhcmUgc2V0IGVpdGhlciBi
aXQgMzEgb3IgYml0IDE1LCB0aGUgSTJDIG1vZGVsDQo+IGNvdWxkIHNhZmVseSB1cGRhdGUgSTJD
Q19ETUFfTEVOICgweDU0KSB3aXRoIHRoZSB2YWx1ZSBpbiBJMkNNX0RNQV9MRU4NCj4gKDB4MUMp
Lg0KPiANCj4gSG93ZXZlciwgc3RhcnRpbmcgd2l0aCB0aGUgQVNUMjcwMCwgdGhlIGRlc2lnbiBv
ZiB0aGUgSTJDTV9ETUFfTEVOICgweDFDKQ0KPiByZWdpc3RlciB3YXMgY2hhbmdlZC4gVGhlIHdy
aXRlLWVuYWJsZSBiaXRzIChiaXQgMzEgYW5kIGJpdCAxNSkgd2VyZSByZW1vdmVkLA0KPiBtZWFu
aW5nIHRoZXJlIGlzIG5vIGxvbmdlciBhbiBleHBsaWNpdCBpbmRpY2F0aW9uIG9mIHdoZXRoZXIg
dGhlIGZpcm13YXJlDQo+IGludGVuZHMgdG8gdXBkYXRlIHRoZSBUWCBvciBSWCBsZW5ndGguDQo+
IA0KPiBBcyBhIHJlc3VsdCwgb24gQVNUMjcwMCBhbmQgbmV3ZXIgU29DcywgdGhlIG1vZGVsIGNh
bm5vdCByZWxpYWJseSBkZXRlcm1pbmUNCj4gd2hldGhlciBhIHdyaXRlIHRvIEkyQ01fRE1BX0xF
TiB3YXMgbWVhbnQgZm9yIFRYIG9yIFJYLiBUaGlzIGFtYmlndWl0eSBpcw0KPiBlc3BlY2lhbGx5
IHByb2JsZW1hdGljIHdoZW4gdGhlIHZhbHVlIHdyaXR0ZW4gaXMgMCwgd2hpY2ggYWN0dWFsbHkg
Y29ycmVzcG9uZHMNCj4gdG8gYSBETUEgbGVuZ3RoIG9mIDEuDQo+IA0KPiBUbyBlbnN1cmUgY29u
c2lzdGVudCBiZWhhdmlvciBhY3Jvc3MgYWxsIFNvQ3MsIHRoZSBtb2RlbCBub3cgdXBkYXRlcw0K
PiBJMkNDX0RNQV9MRU4gd2hlbiBJMkNNX0NNRCAoMHgxOCkgaXMgd3JpdHRlbiwgYXMgdGhpcyBp
cyB0aGUgZmluYWwNCj4gY29tbWFuZCB0aGF0IGluaXRpYXRlcyBhIFRYIG9yIFJYIHRyYW5zZmVy
IGFuZCByZWZsZWN0cyB0aGUgZmlybXdhcmXigJlzIGludGVudA0KPiBtb3JlIGNsZWFybHkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gRml4ZXM6IGJhMmNjY2QgKGFzcGVlZDogaTJjOiBBZGQgbmV3IG1vZGUgc3VwcG9ydCkNCj4g
LS0tDQo+ICBody9pMmMvYXNwZWVkX2kyYy5jIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ody9pMmMvYXNwZWVkX2kyYy5jIGIvaHcvaTJjL2FzcGVlZF9pMmMuYyBpbmRl
eA0KPiBhOGZiYjlmNDRhLi5jNjU5MDk5ZTlhIDEwMDY0NA0KPiAtLS0gYS9ody9pMmMvYXNwZWVk
X2kyYy5jDQo+ICsrKyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gQEAgLTYzNCw2ICs2MzQsMjAg
QEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfbmV3X3dyaXRlKEFzcGVlZEkyQ0J1cw0KPiAq
YnVzLCBod2FkZHIgb2Zmc2V0LA0KPiAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgIH0N
Cj4gDQo+ICsgICAgICAgIC8qIEhhbmRsZSBETUEgbGVuZ3RoICovDQo+ICsgICAgICAgIGlmIChT
SEFSRURfRklFTERfRVgzMih2YWx1ZSwgVFhfRE1BX0VOKSAmJg0KPiArICAgICAgICAgICAgU0hB
UkVEX0ZJRUxEX0VYMzIodmFsdWUsIE1fVFhfQ01EKSkgew0KPiArICAgICAgICAgICAgYnVzLT5y
ZWdzW1JfSTJDQ19ETUFfTEVOXSA9IEFSUkFZX0ZJRUxEX0VYMzIoYnVzLT5yZWdzLA0KPiArDQo+
IEkyQ01fRE1BX0xFTiwNCj4gKw0KPiBUWF9CVUZfTEVOKSArIDE7DQo+ICsgICAgICAgIH0NCj4g
KyAgICAgICAgaWYgKFNIQVJFRF9GSUVMRF9FWDMyKHZhbHVlLCBSWF9ETUFfRU4pICYmDQo+ICsg
ICAgICAgICAgICBTSEFSRURfRklFTERfRVgzMih2YWx1ZSwgTV9SWF9DTUQpKSB7DQo+ICsgICAg
ICAgICAgICBidXMtPnJlZ3NbUl9JMkNDX0RNQV9MRU5dID0gQVJSQVlfRklFTERfRVgzMihidXMt
PnJlZ3MsDQo+ICsNCj4gSTJDTV9ETUFfTEVOLA0KPiArDQo+IFJYX0JVRl9MRU4pICsgMTsNCj4g
KyAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgIGlmIChidXMtPnJlZ3NbUl9JMkNNX0lOVFJfU1RT
XSAmIDB4ZmZmZjAwMDApIHsNCj4gICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LCAiJXM6IFBhY2tldCBtb2RlIGlzIG5vdA0KPiBpbXBsZW1lbnRlZFxuIiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPiBAQCAtNjU2LDggKzY3MCw2IEBAIHN0YXRp
YyB2b2lkIGFzcGVlZF9pMmNfYnVzX25ld193cml0ZShBc3BlZWRJMkNCdXMNCj4gKmJ1cywgaHdh
ZGRyIG9mZnNldCwNCj4gICAgICAgICAgYnVzLT5kbWFfZHJhbV9vZmZzZXQgPQ0KPiAgICAgICAg
ICAgICAgZGVwb3NpdDY0KGJ1cy0+ZG1hX2RyYW1fb2Zmc2V0LCAwLCAzMiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICBGSUVMRF9FWDMyKHZhbHVlLCBJMkNNX0RNQV9UWF9BRERSLA0KPiBBRERS
KSk7DQo+IC0gICAgICAgIGJ1cy0+cmVnc1tSX0kyQ0NfRE1BX0xFTl0gPSBBUlJBWV9GSUVMRF9F
WDMyKGJ1cy0+cmVncywNCj4gSTJDTV9ETUFfTEVOLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWF9CVUZfTEVOKQ0KPiArIDE7DQo+ICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgIGNhc2UgQV9JMkNNX0RNQV9SWF9BRERSOg0KPiAgICAgICAg
ICBidXMtPnJlZ3NbUl9JMkNNX0RNQV9SWF9BRERSXSA9IEZJRUxEX0VYMzIodmFsdWUsDQo+IEky
Q01fRE1BX1JYX0FERFIsIEBAIC02NjUsOCArNjc3LDYgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVk
X2kyY19idXNfbmV3X3dyaXRlKEFzcGVlZEkyQ0J1cyAqYnVzLCBod2FkZHIgb2Zmc2V0LA0KPiAg
ICAgICAgICBidXMtPmRtYV9kcmFtX29mZnNldCA9DQo+ICAgICAgICAgICAgICBkZXBvc2l0NjQo
YnVzLT5kbWFfZHJhbV9vZmZzZXQsIDAsIDMyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgIEZJ
RUxEX0VYMzIodmFsdWUsIEkyQ01fRE1BX1JYX0FERFIsDQo+IEFERFIpKTsNCj4gLSAgICAgICAg
YnVzLT5yZWdzW1JfSTJDQ19ETUFfTEVOXSA9IEFSUkFZX0ZJRUxEX0VYMzIoYnVzLT5yZWdzLA0K
PiBJMkNNX0RNQV9MRU4sDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFJYX0JVRl9MRU4pDQo+ICsgMTsNCj4gICAgICAgICAgYnJlYWs7DQo+
ICAgICAgY2FzZSBBX0kyQ01fRE1BX0xFTjoNCj4gICAgICAgICAgdzF0ID0gRklFTERfRVgzMih2
YWx1ZSwgSTJDTV9ETUFfTEVOLCBSWF9CVUZfTEVOX1cxVCkgfHwNCj4gLS0NCj4gMi40My4wDQoN
Cg==

