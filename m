Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BFC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNL-0003hd-Uc; Thu, 02 May 2024 11:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNK-0003gQ-CS
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:34 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNH-0005zh-Iw
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663771; x=1746199771;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PEzIBq9lDZaXfLf0WUXeN4trwrfZyhyn417eRg/Zhek=;
 b=E/ZV2T73bOlILIbjZsjmMGArJx5Tf1Fjt9al0f14TctTVlgNFtN4LY4T
 SHbV3x1xQBlOAKiAsaPHVNnsVyw11udsxYK5ehwhLmMOgF/MzyT1BzLbc
 CbEcpjuj+mcMnRXBacn4i+xKGUGrrvKuyUFe1xYrFuRBOnJqfz1fVsDtB
 6INi66mhC53hheMO+3sL5TwO9Bxj4MIZHiuVoAYc3JJf6zelTrHbbY5rZ
 SKmqZmkNqptIthZiKG3A4LmiTCZc43Bcqby7VM0TfGgrqmk7XYIhoVrIR
 juV947hJfwzfpqdyVSoFiLLTRPZiYOIgWs4OyWMdSO6KxlI0PWKdZOtM7 Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730670"
X-MGA-submission: =?us-ascii?q?MDGayLYUZl7AF5RudSH0C4/9kh7YGBbbqC+MYM?=
 =?us-ascii?q?QylglOm9WiJsj0UfXR04X615TflanUQzwiQYGdefNeEEx1o2IvfDaVC9?=
 =?us-ascii?q?CWvZXIeAnxerya07Q8dEo5Wt20sbBplLAPlqiMKbjk5YRLh5T1oS5ACA?=
 =?us-ascii?q?JmE40XriVuYzNboRjBhbPK7w=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmFa+5meWKRQsn2aTJvtnYWg5RfInB3UnJ4tGOFCuYp4MpbZulk0qEeiEB7FlDgcPIjr2apd/STQ3fuF7Tlom97nyYDSkTjS3Y0edMsE95xTxq8fGABOvokk1GnLKdLpYy79ao7tqeLFEjMe3zuQEWfED/CI6WrpUiTs4JNMvwFxm2rEwuKGqMF3qjyUCOLro5mXNMEa7VzfaM9ON7tHhKYkHXdHA2YbzLPVEPkqsHeFfvA1n4xQ+NmmrKLC7wBUgYW9wjPmHGb7kguzJIz4fY8LZzaRP1k5K1KuJYDb/39bWMgfr3EA2txjfWxg4TVq2Dlf+DidMKp5R0SX2NqBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEzIBq9lDZaXfLf0WUXeN4trwrfZyhyn417eRg/Zhek=;
 b=i4R6hAT744FNaRJJB/tucXOkAC7jhOzuMWMPmOLXw9i2CpMp7P2j4XVhcLnHVXkl/6/arhUKUjiRLQCZmbaL/tWgJL+HXp6HLIkTGs+QdP2VUy1Eez7zycBiHTWmeokbpkRiTuj0wPDvx8yHS+Bmr7lML57hkV7A05BQOJ1PfFZmKb7oZwRjc87kauULQEXk7+MrHzj8j4abpXhsLM8s/CZG+xtpwWk+h2SlUOe5h50bhixiwFp4+MysGgD79KILmXVmO2U/BCvRebGGEToD5HMXCGRAGEDRaiE5eWgY2G2Bo3NYBaoupvrbZK2cWOmSBvlFxk0qhlV25VQdCW9fTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 19/24] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v1 19/24] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHanKWBZFgBt0AaL0q4Tqeu9PVqZA==
Date: Thu, 2 May 2024 15:29:21 +0000
Message-ID: <20240502152810.187492-20-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: c7f5c3f4-9197-41f0-f61a-08dc6abca397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?U2NWamo0MlVWYjRTdUFMQ0lRazVOMHlEYVFiTG1lWE9DZE8rbWZmT09wc0k4?=
 =?utf-8?B?YnljeWc2UHlzcXRTdnlIdDNuQlRKV2ZJbDdDNzBrQlFSNk5wc09qdW5xUklr?=
 =?utf-8?B?SWpXMXAzR0RLWXpCbXUxOGZ4RUVNbVVienh3OGVQRDhrWmJ3Sjg5MXpmRW9x?=
 =?utf-8?B?YVdjMk12RHE1b01EdlZKYk5mQkJIWDdoYkFYZDBDbGhxTHd6aHVGYUVqS2Zi?=
 =?utf-8?B?TWwzcktxL09xbTJ0MUZFNWk2N21KWDRhYTRpVmpHcUVRb2VzcmJMZ0hFYXNF?=
 =?utf-8?B?SytQMEpKcVczS0dTazQ0YXZlWVBDOS9qeTlZNVFWQU9DdjBiTldCTnZ4bGQy?=
 =?utf-8?B?ejlEc2FTVnlsT1RSRXBuQ2ZvY3RXNjY1Z3RLRjUzcTNzamxDVENsZm9ENDJ4?=
 =?utf-8?B?SFpYYkxDaGRQamY4aGh0dXFYdlpYY0VvUm5hMHBQcUFKOElwb29ndDhEZGxK?=
 =?utf-8?B?Ri9nMlZ4MjhMLytwR0pyRjl5WWszSTJHcm5sNlQ4ZStwSDd1RDlQcG52azVh?=
 =?utf-8?B?TVZyWWo1UmVBOG5XL0lHNW5kSy9wMDdqZVFvYXJzM1FoNUJxZDZIMFRRaXd3?=
 =?utf-8?B?QitSUDJRc092VVdCRUprclRrakxxRlJHZUZGZFlUaE00RjlJRWNmRzRoOXpG?=
 =?utf-8?B?RjZoV0czY2ppcUN0MmM5VTl0WXFKWXQvVXRSTmVkcTVKVU01L3lNZTRTTkVE?=
 =?utf-8?B?WFV4Z2dVRmVieWpheml4aTFWMWhtZElONHdUNWkybjhrYkRhc0luWVhUQm5P?=
 =?utf-8?B?Ri9WYU1NdXdNQ1JWQlNGbUdwa1F3V2NLcUxjQ1g3SGc1eWdWdHRhYmxMZTlh?=
 =?utf-8?B?bUlZcjNTRkNEZWhNcVUvZlFQbitnNWlhSUdSMFNNQzFpcVdCdWJ4MEpLTmN4?=
 =?utf-8?B?aVFXa2J6YnB6QU1DSGFZdEE3OFkzVitBdlQ4bnE4V3ZOMENwamRmR1JMb1VO?=
 =?utf-8?B?Mis5UzRaZ3BXcHNsMHdVVmlLZkVGOGFpM0RUenY2QWMxYkRSKzk0Uk9PUHAw?=
 =?utf-8?B?YTFreFBiSmlqbzZ2MEE2OWNmMHI2SDJuUlRCZ1ZFSUEzVWdJN1gvMmozdkRj?=
 =?utf-8?B?cnNHZW1XaHNHLzNPaVVzMitCSy80VVF4LzVvc3BCR29ycU5OcXZjYlFaZjlk?=
 =?utf-8?B?RnBtK0VBeHNTck1FTERvNVM3N3VuUVJtOGJKaVdZVjRUUENTaDdIMVUxSWk1?=
 =?utf-8?B?WldhVk1PZCtKUEVMYko2N2hOcVhDMTc4dVp3M1ZUSldoZWI5MVNNSHFEbERX?=
 =?utf-8?B?amVPMTRGQlJwMFc0V0ZvcWlXdVROSytSUk5GUUpzbmVtNmY5QXRGTEgvZGVL?=
 =?utf-8?B?TmFMcGhOOUZrdHJEYVg3M0VPVEErMUkrenlqSm5QYnpsTmlWQVRMam9aNlNL?=
 =?utf-8?B?djBQVTZ5RFUzK29raDk1NmNMZUpYOXZOM1RhVTdUTkxDdGlzZFAxV25pU3Jj?=
 =?utf-8?B?SEQzVm51QkNzK0lsbi93VDVxTko0em9FYVhNc0xyTStsMVhvMGxPbFNMbHpC?=
 =?utf-8?B?bnBGSFpBbjZpKyt2cnRqTHh1OVpTM3EydDRUa0RRd2VQaGlqV29OSkVpSzNH?=
 =?utf-8?B?RDVYL0RFRFplMHY3YlQvTHkvSTlBVFdtelJTOU1DT1dQWUZmTDNqOEtBdVRt?=
 =?utf-8?B?N1RUaFZ0ejd1Ym5yMWNSWG9JbmlUQjA5V0RGYWJJSTNhZUV6OE5XU3BVZTBl?=
 =?utf-8?B?T05hU0pqUTNQQXN1cytOMTJDYzBHMlJaZHlnREtQamlGNGtyVzh5NG5hbVBD?=
 =?utf-8?B?V2lFSDRjZm1nU2ZEQlNHZEszOU9BeTFkUnhhbzlPVkxTVWZjZGlyRDM1bHNx?=
 =?utf-8?B?NjJwSXB2YjcyazNPMUFyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rnp6QWFMRTIyRTg0QS9BWXllTi8vcHZEQzhaRzBXLzFEQ3Awd2UzRUF5amxO?=
 =?utf-8?B?QlVHdkptMU02M1VzVldzdGIvMHd1WmFQT2QreUVOSGlUL3ErRDY2enYvbG1Q?=
 =?utf-8?B?QjJ2TGlHWkRoYUxPaWprYm1pUk5peUxLZ09KRklhamJYb1RLMVBHWjNqM2tS?=
 =?utf-8?B?WkFZRUhFakFZUDFKR3dISXY2aDU2bVVFc1BmbmJodU9lVWxZTkMvOEtkQ090?=
 =?utf-8?B?OTVyNlZCTkpNMTZPemdGYjZTN2U5WWk3WVJEZEM2VzVENXU4L09zV3BMYWVH?=
 =?utf-8?B?Sk1nZHFIMXpmdkpOeGZIZVZpVXlZSUYrWm9GaEZXY3hpU0FKa2hQMU1ENHR0?=
 =?utf-8?B?RFhneXhsci9GUUxVR0NuQTdsTXBHTlZRbGVCTGowM2l0UmRzVFdiaHdPUEJW?=
 =?utf-8?B?YUl5MXZTSHRtSTZtbjVJdG1nZjF1ckdZYStoM3B2TS9vS1ZtTVRrZ2Vzdm9t?=
 =?utf-8?B?NE1KcHl6RUozdUw4ejNWWEo1M045WUxoaXV4WEhWeEFwYnFFUVVOTHlNaHhP?=
 =?utf-8?B?THNQa3M5QWw2VmNOaHU1dmVhSm4yTXlwVmYwQjNrK1FjaUhrUmYxQ3FuUThD?=
 =?utf-8?B?Y3RqTFIxWFJleEthYzJCR0k2RmVJUE54UEhSRnRGM3gwMFQvRVJqMjczNGY4?=
 =?utf-8?B?RGc2dVV0L3k1R20ybTM4ajJUMElvVnVqeHVrU3g5WWd0eStQZDRteEFQZ0R0?=
 =?utf-8?B?WkRnTHVTT0IzQUh6MjJNbDNVQ0JlOG00c29pZlRSMXk4am5TT0dIeXF1bzVa?=
 =?utf-8?B?OC90QkpFSmx4L0pReDFHMmVvZEFTM0NVWkkrUThnampVdlFpUjNMblpESDRn?=
 =?utf-8?B?YnF4cGx6ZmNmMTZPSGJvSVcybElOM0NTYUlLL2lUTndRY3pKa2c4c0VFaHJX?=
 =?utf-8?B?NFlNUlZYSjRVdVd1dmJZQVd3TnMyWEJZTmx6WTlTc25mVnQzb08rSXBjTlUx?=
 =?utf-8?B?dmJ6VEJMQU1NakkySDdxMFJxdi9YSCtPMHN4ajZVVy8xU3VKUngvMjRPZVNK?=
 =?utf-8?B?T2dZSFhXdmtqd1NVODJac0h3cHZEL1ZmemExZENrN3cxY0M4N2dlVG8xYWJY?=
 =?utf-8?B?dlJzcTdBTXRML1RjenNWTWg5b2R0UWpMZ0pnZTdudFBmVSsxK1dTVW5MSDRO?=
 =?utf-8?B?TE45cmJDQlNldnFDZExtakFYNlcrUjJONDBxVHNNRzZTTjVaM1VZN0ViMVVx?=
 =?utf-8?B?UkE1SXoxdC83QmZycHVKSGRQV2tEaTJJbmxNUzJYZkJWQnZTUjhsZnZWVUxn?=
 =?utf-8?B?VVBtR3R1SkR4V01XNm51SHhWbnBzYW9Rc2VlWFBYL1hpaFBtT2hlZldsV1Rn?=
 =?utf-8?B?SGN2dklGR0p0OTl0dmduYUlLaWtQUUk0aTV5YmtPMkQ3M2w1U3RsOXlneWdE?=
 =?utf-8?B?czNtSDVEOXR6a3haemVIY2JPN3RUaG5IMmRHbThRUzlNSVlVVFVaTmh2VWo1?=
 =?utf-8?B?RTE0d1lIcGtVNHF6NUVHSmNzWkV0RFlSbGt4cG9KSnJTQTYzb1FOT2xXdHFC?=
 =?utf-8?B?aXRpcUc4Tjh3c1I5ZEk0bUFlU25hb2pQcHVtODlRODNzSVJCWTZ0MWhkMG5s?=
 =?utf-8?B?WjF1SzhrQWs3bFlkaml3UnBWNnlWdTFRa3M5L1Q0allIRm5nUG12YmxGRlB1?=
 =?utf-8?B?QWhqN0k1OHVEN1JqR2hKcEw3dTE4cUlURVhtdWoyNGlwUnpVZ04zVmJ2SUNU?=
 =?utf-8?B?Mm1Sc1RyYU5kcjRaMm1tY2lCUkFscExOT09pTVpBL3F3MGhPdHRQRU1TWVBC?=
 =?utf-8?B?dndORlF5VERGUko2dk1vOEF3ak9jcVovZ3c5YkFqN3JkRDdUYVlyWmxMRHVv?=
 =?utf-8?B?eXA2ZzRFbjErenRwS1ptakM5R0xCcnB1aFJPcEk4c2hJWk1zclZ5SE9xNU80?=
 =?utf-8?B?RHhsRzMxaHVrN2hZSUxQQ3ZxU0F2ZUtlNE5BTHhwUnFHRFZJemFhMXQ1TDdN?=
 =?utf-8?B?NkpKT01FYjdsRXpDTnhQQnROQkRjaG5pZWZ2R2xRWDlmZ1JEaFpycCs0Rk1E?=
 =?utf-8?B?VU5CQWdGdjNVMlNlQUdOS3NYaVBmeXRlNGJML1ZqVFJXV05PTkp3NTZjNEI5?=
 =?utf-8?B?dTBNM3N6MG9NbWxyOVp5S1EzeWx4dVlJTVNXUUR2MkdwbTEwRWZCcXZ6ZmFp?=
 =?utf-8?B?a2VYRFlZS0pDQVJveGluZk5ZeEtpakxLWlhjeU8yTVdreWJrclBreTFGeXNG?=
 =?utf-8?Q?VpIdHHmlqbk7X4KqkI2oq/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55194E1E493CAC45B137755E0A182A12@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f5c3f4-9197-41f0-f61a-08dc6abca397
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:21.0598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MINmG1/XkSCW0x7Hbr8IMiK8sfOES6CHX2wNAbphaJTIbUw+Uvv75BUahEcDEEcXhVh//sdHnHeXynqLxuygipgkevqy2MdAj4EdOGrkL9YECU2iXkRyVB6Iq3skBscc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1ICsrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCBhNjJjYmYzMDNkLi4w
MmM1ZjBmYTRmIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCkBAIC0yMzAyLDYgKzIzMDIsNyBAQCBvdXQ6DQogICAgIGVudHJ5
LT50cmFuc2xhdGVkX2FkZHIgPSB2dGRfZ2V0X3NscHRlX2FkZHIocHRlLCBzLT5hd19iaXRzKSAm
IHBhZ2VfbWFzazsNCiAgICAgZW50cnktPmFkZHJfbWFzayA9IH5wYWdlX21hc2s7DQogICAgIGVu
dHJ5LT5wZXJtID0gYWNjZXNzX2ZsYWdzOw0KKyAgICBlbnRyeS0+cGFzaWQgPSBwYXNpZDsNCiAg
ICAgcmV0dXJuIHRydWU7DQogDQogZXJyb3I6DQpAQCAtMjMxMCw2ICsyMzExLDcgQEAgZXJyb3I6
DQogICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KICAgICBlbnRyeS0+YWRkcl9tYXNr
ID0gMDsNCiAgICAgZW50cnktPnBlcm0gPSBJT01NVV9OT05FOw0KKyAgICBlbnRyeS0+cGFzaWQg
PSBQQ0lfTk9fUEFTSUQ7DQogICAgIHJldHVybiBmYWxzZTsNCiB9DQogDQpAQCAtNDMzOCw2ICs0
MzQwLDcgQEAgc3RhdGljIHZvaWQgZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NT
cGFjZSAqdnRkX2Rldl9hcywNCiAgICAgZXZlbnQuZW50cnkuaW92YSA9IGFkZHI7DQogICAgIGV2
ZW50LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0KICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVk
X2FkZHIgPSAwOw0KKyAgICBldmVudC5lbnRyeS5wYXNpZCA9IHZ0ZF9kZXZfYXMtPnBhc2lkOw0K
ICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2Rldl9hcy0+aW9tbXUsIDAsIGV2
ZW50KTsNCiB9DQogDQpAQCAtNDkxNCw2ICs0OTE3LDcgQEAgc3RhdGljIElPTU1VVExCRW50cnkg
dnRkX2lvbW11X3RyYW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRy
LA0KICAgICBJT01NVVRMQkVudHJ5IGlvdGxiID0gew0KICAgICAgICAgLyogV2UnbGwgZmlsbCBp
biB0aGUgcmVzdCBsYXRlci4gKi8NCiAgICAgICAgIC50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFj
ZV9tZW1vcnksDQorICAgICAgICAucGFzaWQgPSB2dGRfYXMtPnBhc2lkLA0KICAgICB9Ow0KICAg
ICBib29sIHN1Y2Nlc3M7DQogDQpAQCAtNDkyNiw2ICs0OTMwLDcgQEAgc3RhdGljIElPTU1VVExC
RW50cnkgdnRkX2lvbW11X3RyYW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRk
ciBhZGRyLA0KICAgICAgICAgaW90bGIudHJhbnNsYXRlZF9hZGRyID0gYWRkciAmIFZURF9QQUdF
X01BU0tfNEs7DQogICAgICAgICBpb3RsYi5hZGRyX21hc2sgPSB+VlREX1BBR0VfTUFTS180SzsN
CiAgICAgICAgIGlvdGxiLnBlcm0gPSBJT01NVV9SVzsNCisgICAgICAgIGlvdGxiLnBhc2lkID0g
UENJX05PX1BBU0lEOw0KICAgICAgICAgc3VjY2VzcyA9IHRydWU7DQogICAgIH0NCiANCi0tIA0K
Mi40NC4wDQo=

