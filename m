Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616A3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNV-0003mI-2q; Thu, 02 May 2024 11:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNQ-0003jF-Dz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:40 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNK-00060t-9D
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663774; x=1746199774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Qy+dDCFr8EtqKzLzd6rPk2x+cI0Kod24gn2AwSbFlT8=;
 b=xWvk1V9oIOIGEpqZnZZN7x2116Un0F5Ai/j8rhnjwwtDwOx8VE6fUSr4
 UiyJQqdB2P8zNCR+rNr+45Yf/OY8KpcSHzczgTK30gq7rjy5FxP0+YzO/
 Lm7AZ2YfQ+Py0R6t9K/eMWkyg7RA/AAuQfM4+ViWGdeO7LbYyk6mgVtiC
 9spbei13Ggf9bbEK3WjYWsMQNGYAtPnwcACxBVcgQHlFPoi3vSQhS3FIj
 x90lCPhTJKYQL4weoywxgaTOLtuBB3NjVShF4IfHArqLCOPrpEi0lL1cn
 yQ2mGv9DkglM0EmWkBnzMMiMz4hQmCysqKSFs9wlIQKUCEHHGIGiiw0Sh Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730625"
X-MGA-submission: =?us-ascii?q?MDFer2e/lzIURv0zLCxMB/nco9tlFPP2MPZwCS?=
 =?us-ascii?q?D9EX/fCFzjl3kX6QEr87Tvr6m3KDLJGGK2G1F2K3cVPnBtEhy2q0QpQY?=
 =?us-ascii?q?zkXEnT+6PTEFjCIP9V+SuuiOBZX7B3VTep87nXqgUEqXmswJuyMClbvW?=
 =?us-ascii?q?xYME1jlKasRffKWxxwjWyP8g=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9oUagOxuPv/6IdqsNtRo1Qn+EghV9wEn35XXRjOsc+TtGG1sxlto9awU5rZkmTHYb1RF0MRTTYIMKeBy+YPhztay8lmvFd/oD7Z9DwFTQX3ysMI1OM2aedpbGFxX90f6rsddbc6IYFyqHQ2ubcMDS7ILHEVcx9iDrI4G74C4zbRvlpXX20ie2Cg2ZloldK+0h/nkCSqzjCBP+KGEw35PbYKtF2eN0rHAqgxLCJIlxqLRAPus1N5RWAFZtEPK0rjPfMdzxBTGaxzf+qTMdBrNgG14JinOksKVy+TzVuB7Vl4rYvnSaaLMflgy88EceAdsogOfGDCdqPdsBziQTY+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy+dDCFr8EtqKzLzd6rPk2x+cI0Kod24gn2AwSbFlT8=;
 b=BKFmmTNz6QiGO4xrBU/ZOv+2yi521ySpGPD/yGYYl3KsVT0Ng1/9CWODH2xNKD+xScgJC9rcxisZ+thANsGT0ciGd9f6kdHhx+QIadTjjQYXptvXTGEsFkQ/zyVCowTT0doNvY6udxsTbn9n2fsFUDor4qtYNYgybxZqm+qMQ9dQfa9CpBK0MT30Xhy70j1CfsT5taNesrzSU8CbrBVDQvWH5yl1WxluPeX6+Ys38EXsYkh7yUhrc5hd4Pif+B9IP/dZ/OB3i3nlhQnlWSF6gcc/0kpy8AdjzlnCiefawzSsPyTWu4voOa94dGokM4/Sr3731sizFYGRGDh3jJXo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 24/24] intel_iommu: add support for ATS
Thread-Topic: [PATCH ats_vtd v1 24/24] intel_iommu: add support for ATS
Thread-Index: AQHanKWB5uNGEVbEo0CeorZYk4jRwg==
Date: Thu, 2 May 2024 15:29:22 +0000
Message-ID: <20240502152810.187492-25-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: a0f1b1dc-4040-4b41-dfd7-08dc6abca472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?b3JsMHBWYlpLOTAxbnB2WVFlNDJlZ3k5U0gxb2ZIT1hHZG5OTmRqcGhyRGFK?=
 =?utf-8?B?T25HaTBSZGhoWGJzQjBRQkJWalRpZXk3RjFpMkt0eEp4ZkVCQVdxNVUvd1I3?=
 =?utf-8?B?bU5ObVBaeWs1dEhOVzhycTlvZ2QxSWNnNzQ2ckRxYkw0cWM3MDM3a3JrSGRQ?=
 =?utf-8?B?QTYxU3RndDJNRDR4VWJQNktWNWtiSWo1ZXdtVWVtQ3JPanhpcTRsUmREeEhz?=
 =?utf-8?B?T3IxeHRXMGhsZ0V5alVMWTNPbFdoNC9GMnliaW4xYy9abDZPc3lod1VnNXZv?=
 =?utf-8?B?T3VzLzNheUpXRWNXNVAwbDhrb01FYnBrNHpBMk9nelJoSGlNS3RTcDhoeU9r?=
 =?utf-8?B?Ny8vci8zUkt2L0dkcmlycDhxRkhmOVV4RXVEWWh5d2hwcVpIU2hZZlFDU3Fx?=
 =?utf-8?B?aXphZWZEOStjdUZ3a3NTK1dKSVF6RzZLZDJUWkNCcGJzV3IrOFhHK080T1JS?=
 =?utf-8?B?VVVjRmV3dTI4Z1lMZFI4aTZ4UVFzVTF0RlFXUkppNll2MDYxOVVBdy9PRjhH?=
 =?utf-8?B?Q3Q3WkFWSkFxdldEZEFPcGlUbGRTempEcFgyTXoxQXlXZjJiZWE4OCthL3NR?=
 =?utf-8?B?eWxwSmlmMjgwZHJsejNCNy9jWEZWaSthSEN1MGpqRXhpbjVSUUxLZVh5QzVL?=
 =?utf-8?B?VzAwek14d0FmSkRIMnQ0NkFXTG96em5jR1NzTkk4c1h0bUlTcloyZHZtZGVX?=
 =?utf-8?B?U05sWFV5YW96K05mVmw2UXlBYXFSUTNqS2hFWmxCbUw1ay9KYjg5UlYxK0k3?=
 =?utf-8?B?Qm9RWnJ4cGF5ZU1GQldPdVdsUnNuT1NoRXdpZXI4Q1ZUZTI4ajg1amZzMGRp?=
 =?utf-8?B?TFE0ZmNjYmlOb3pOSUQ3MjVCcXlSUCtGZWlXTkNJdTMvVU5GUXJORWpKeWRJ?=
 =?utf-8?B?ckVlankxczBFSnpGNWFTcVhsdUE2L2l2U2Y3WnNsVS9FTlo1VTVmaTc4bUE4?=
 =?utf-8?B?dDBQbXVSZkpqUzdVcXRETkNYUFNPRDVYRngreGdaWmYrZEE2c3dLSnpvbzQ1?=
 =?utf-8?B?amxrOGMwSTYxbXZZWWJ4L1FFRSthVEMxQVRHdlVycjlMNXlpNkg2NDd2aWlF?=
 =?utf-8?B?bDlicFJkaVVEOFl2RmtKOElVZ3cwTHVObmNYcWhjWElvTjdQU1V4NkZOOVhW?=
 =?utf-8?B?d1RqTjEzUW50NHduVmJMQXA5YmJIbWRLR2NUWjNJSW1iZ0tBWGNmVlhaSkNR?=
 =?utf-8?B?NlNpMWZ6TENsZ1dNTUxwNzFYbGU3R09LZnh1VnRIQ09saDI0MldncWRSVVAw?=
 =?utf-8?B?UWJiam53SGdaWkFkTFp3VGFNSTF5YWFDQUZDdFlERSt6dmdOZjB0MFJ1dnpw?=
 =?utf-8?B?eWkxMnFVSnRReDU4STJNNmI0TEk0TWMxMUVFdElYN2s1R0h2VG91YkllbXpW?=
 =?utf-8?B?VnNoM3FqTW00UnNsYmIva3k2aE1tTmFBdVFJVmdKbmpxNnVLV2JKcFpTek1B?=
 =?utf-8?B?UkJXK2pWSDFSMzJNR1dtaFVvbEFnL1poOGlrSTUyNkNlZjd6ZzBvd0dmZWR0?=
 =?utf-8?B?bnpPZ1R4ck9YRDBLY1B0UVp1ZWlQS1R2Sk5nQndpYU1hZ0lkV2x5WDlXUEw0?=
 =?utf-8?B?Sk1BajY3SEsyMGF6WVZWWnJaSkZVRFV4STQxQnVVQ1V3YXdYOVE3U2RIdGM1?=
 =?utf-8?B?ajNPZ09Bd2ltUmtWa3BCaGs2dHkyWVU3YjdmZ0E0b2drb0ZpaW00UlNhczN6?=
 =?utf-8?B?YkJOaTZFblRFckVWU2RqV1RwRER3KzU4UlJYdzZCUWVZTytrWjAyRDBub21t?=
 =?utf-8?B?eEtkVmFYNkhDdGhVTm9jWmxCb29vY0hFM0kzUmcxamxrMEtPcUJGaWF6bXpT?=
 =?utf-8?B?d3pqU3M3RUdkdXlvc2RDUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnAzcFAyL01MWmwxQ1puQzlCaU9CaS9lVmxMOEc3VCtWVEhoZVVXWXhmWjZi?=
 =?utf-8?B?a25EVWtkTS9nWnlUNmpMQ2pwN2dIQzdjcmptbDE2cGN1ak5ENHowWjVCNnB3?=
 =?utf-8?B?amMrbVdXVkVKTmNsa2lVODRySmRzN0RldlRsQ0RSNVVUcEdqTzlCM0JJdHo1?=
 =?utf-8?B?RmxSeVVDdG8wejJLblF3cTJqK0c5RmRCeFI4NkI4bVNXQzJsU0RNTTZoWFdw?=
 =?utf-8?B?SzdjRHBCa3VVOGwyVlBsSVF5cWcxRGhDTitta3h5NFNsSjMzZ0lkODdyeG1S?=
 =?utf-8?B?UUlRQkxoNDIxZXd0UzMwanl4RGhHWlVTU1BzakxxTTB5cnR6N0lSbmhSbGxQ?=
 =?utf-8?B?QXFXcm1UUWQvQWthSmlGZXhuTVY3UVpUWnhnUG83dlhvL284Vko2SmlaZE8x?=
 =?utf-8?B?KzQrM25RWjloazZIRExLdDdBV3MyTWc4RHB4L01rVFQ3anRGS2RmVzZzdlFy?=
 =?utf-8?B?aUcxQ0FkS3pFWGd2eExsTjdwMUQ1aWlpMmMySElNdWQ4b3UxV3F0WjZVUWJV?=
 =?utf-8?B?OG1IbnlBRHJLbzltUkw4bXc2bzNvUDVHR2JRWmpSdVMvY3J4Smp3eVRYN2dO?=
 =?utf-8?B?UlBuS2NINWFLWlk4cElDcVRHVlcrTCtEalhVS04wVkhZQ0FZK1JCcllpZ0dD?=
 =?utf-8?B?TTRxVDhUa1NFT1FOMDYwbXZQc1RqcXQzRk5EZ1A0YkNNZk4zWnJ2NGpjZGl0?=
 =?utf-8?B?Rk9wcER6bEhEYWZ4TjJnRlI1MDREaDg0dDNpRVd4YmRiaHh0NmN2NzhTWk5Z?=
 =?utf-8?B?a2w2TmMwMXRJQUlOcDdDeTFTTE0vcEdmUkphcTRGR2VJT25BaEpPZktwT3VT?=
 =?utf-8?B?RU5uTldXaGxNNVhWOHVJSytwNXQrUUloczFxNTQwbk01TDR2S0ZZRjlTS3A0?=
 =?utf-8?B?bmZmbDV5bElsdUJIZjZMbkJaN092bEJuK2Q5Qno4MHNuaVFpNVpOay9FRFZ0?=
 =?utf-8?B?WjFUdGI2cmdTd3RBaXY3R1dVL3BLSXVsaFpzaWVJZjdBNEkxb21NMnhPZmVh?=
 =?utf-8?B?dlNsTjVSN0VEL3RwYnhVVHoxdmhPMTVqejdBU2VQZnZhUWdJbU92cGtTUnRZ?=
 =?utf-8?B?bkpkK1pjN0dWWmRvUVMvNXBSRllBODJXNmcvZWVTMWRMdng0Q3BUNzBmVVd5?=
 =?utf-8?B?ZzBoTmlVZGRBMlVMNzdEN3RoVHdITFBLbkVmc2w4UWxJRjd4T3g4TTU1YWtJ?=
 =?utf-8?B?ZStDQ201S1JNWGhpd0Job2hLZEtvWHJMVTRMbXduSHh2NkE3OThrV1lTaDJD?=
 =?utf-8?B?WURhdjc4WnBIUGZvOXZMLy9mSTB2TlBRK1Z0a29VaWl3a1cxNnNsTngzL2Jo?=
 =?utf-8?B?L2FRQWhKLzZ2Mm5nRXg5cTFiUlZqN0tnaHdoTXJzRFFkblY1UUF6elFUb3F2?=
 =?utf-8?B?K1FpZUw5MjhjdmNEeThDSWk0bTl0UXE5ZWgxZHBzSlpndlUxcElJRVV2eno0?=
 =?utf-8?B?NE91MVU1ZllIbklzM2ZKaEJyZzdESDdjdXFhL05TMWdHQXJBcjU4eGM1aThq?=
 =?utf-8?B?bTQxRkx4ZXZuSWhldjBybytJZGdrejFiZ3gwWHU3NGZCVWM1dVltRFUzcitt?=
 =?utf-8?B?cVp1VXZUcmltalFLOWh6cTNlTUxJdktPYjUwVUcweVBwdmZyc010NTJ0OXIy?=
 =?utf-8?B?MmxHUEJLNWR2dHBMQTYwa0ZzNEdDNzUyeFk2VU5kcnlqdmJmLzN1YUMvdHZu?=
 =?utf-8?B?b3pLdnZNR2c5V0VwM1BDcUlTbitEOG9sTVZQY2tNc0hMZ1hpZmptSjJZaWNN?=
 =?utf-8?B?N0x2YWUzNDR6YnhHdzRDUXozL05hcE1uRTBRZFVWeXFEbDFQSjF0K2h5R0VV?=
 =?utf-8?B?QmliZmlXc2RCZFhtc1V2emh3ZEsvaENTa2tRcUtBSWpiTHVBT09XQzNITWsw?=
 =?utf-8?B?TndYZ2xNVVlWZXViUWVOOW8yeFQ1ZXM0U2NMenNCeFFxWDBFaE9vSVZpeUtz?=
 =?utf-8?B?NFMxYUZCeWJVREtOSkkvdmpnS1lsZGJMYURrZlBpNy8wRkRpamhtaHFGMVg3?=
 =?utf-8?B?WmN2VlRBQSswbzdjVDJpVUNYeitlZ3NnSTlpNGxvaldxTzk1eEFJTG9BZ2Va?=
 =?utf-8?B?ZWJGc1BJRlpseHY4WTNubzd0V2JEZnVUaVhudmFmemZjQnNIdkViTXNnelcv?=
 =?utf-8?B?RW1tOHBGcnBEYVp2dGtSQUptN1FPdVY0N25vcGpHK2hBTHh6YTNvTGlzVlZD?=
 =?utf-8?Q?uwxpqnYi7q4X9xoZkdkPlCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F6709242A64EC4A93A4EC0E4EF2501C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f1b1dc-4040-4b41-dfd7-08dc6abca472
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:22.3322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2h20BGHUHJ4JGJTgTRATEPpW6NdmfL3dPYbmRXUqjNGY9bDlc95hHjjzLvYaUp+JoeLZZIm8k54PxHcVw+U17zdK+CFTnsOtVs2mrd25pPkacmlEiFVJZyu/kPg1fXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggYWFjNzY3NzA2My4uNDAwYjI3ZmM5NSAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtNTM5NSwxMiArNTM5NSwxMCBAQCBzdGF0aWMgdm9pZCB2dGRfcmVwb3J0X2lyX2lsbGVn
YWxfYWNjZXNzKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLA0KICAgICBib29sIGlzX2ZwZF9zZXQg
PSBmYWxzZTsNCiAgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KIA0KLSAgICBhc3NlcnQodnRkX2Fz
LT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQpOw0KLQ0KICAgICAvKiBUcnkgb3V0IGJlc3QgdG8gZmV0
Y2ggRlBELCB3ZSBjYW4ndCBkbyBhbnl0aGluZyBtb3JlICovDQogICAgIGlmICh2dGRfZGV2X3Rv
X2NvbnRleHRfZW50cnkocywgYnVzX24sIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgPT0gMCkgew0KICAg
ICAgICAgaXNfZnBkX3NldCA9IGNlLmxvICYgVlREX0NPTlRFWFRfRU5UUllfRlBEOw0KLSAgICAg
ICAgaWYgKCFpc19mcGRfc2V0ICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsNCisgICAgICAgIGlmICgh
aXNfZnBkX3NldCAmJiBzLT5yb290X3NjYWxhYmxlICYmIHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05P
X1BBU0lEKSB7DQogICAgICAgICAgICAgdnRkX2NlX2dldF9wYXNpZF9mcGQocywgJmNlLCAmaXNf
ZnBkX3NldCwgdnRkX2FzLT5wYXNpZCk7DQogICAgICAgICB9DQogICAgIH0NCkBAIC02MDI1LDYg
KzYwMjMsNzUgQEAgc3RhdGljIElPTU1VTWVtb3J5UmVnaW9uICp2dGRfZ2V0X21lbW9yeV9yZWdp
b25fcGFzaWQoUENJQnVzICpidXMsDQogICAgIHJldHVybiAmdnRkX2FzLT5pb21tdTsNCiB9DQog
DQorc3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lvbW11X2F0c19kb190cmFuc2xhdGUoSU9NTVVN
ZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGh3YWRkciBhZGRyLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIElPTU1VQWNjZXNzRmxhZ3MgZmxhZ3MsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGlvbW11X2lkeCkNCit7DQor
ICAgIElPTU1VVExCRW50cnkgZW50cnk7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0g
Y29udGFpbmVyX29mKGlvbW11LCBWVERBZGRyZXNzU3BhY2UsIGlvbW11KTsNCisNCisgICAgaWYg
KHZ0ZF9pc19pbnRlcnJ1cHRfYWRkcihhZGRyKSkgew0KKyAgICAgICAgdnRkX3JlcG9ydF9pcl9p
bGxlZ2FsX2FjY2Vzcyh2dGRfYXMsIGFkZHIsIGZsYWdzICYgSU9NTVVfV08pOw0KKyAgICAgICAg
ZW50cnkuaW92YSA9IDA7DQorICAgICAgICBlbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KKyAg
ICAgICAgZW50cnkuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQorICAgICAgICBlbnRy
eS5wZXJtID0gSU9NTVVfTk9ORTsNCisgICAgICAgIGVudHJ5LnBhc2lkID0gUENJX05PX1BBU0lE
Ow0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgZW50cnkgPSB2dGRfaW9tbXVfdHJhbnNsYXRlKGlv
bW11LCBhZGRyLCBmbGFncywgaW9tbXVfaWR4KTsNCisgICAgfQ0KKyAgICByZXR1cm4gZW50cnk7
DQorfQ0KKw0KK3N0YXRpYyBzc2l6ZV90IHZ0ZF9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBhZGRy
LCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3Ro
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCAqZXJyX2NvdW50KQ0KK3sNCisgICAgSU9NTVVBY2Nlc3NGbGFncyBmbGFncyA9IElPTU1V
X0FDQ0VTU19GTEFHX0ZVTEwodHJ1ZSwgIW5vX3dyaXRlLCBleGVjX3JlcSwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpdl9yZXEsIGZhbHNl
LCBmYWxzZSk7DQorICAgIHNzaXplX3QgcmVzX2luZGV4ID0gMDsNCisgICAgaHdhZGRyIHRhcmdl
dF9hZGRyZXNzID0gYWRkciArIGxlbmd0aDsNCisgICAgSU9NTVVUTEJFbnRyeSBlbnRyeTsNCisN
CisgICAgKmVycl9jb3VudCA9IDA7DQorDQorICAgIHdoaWxlICgoYWRkciA8IHRhcmdldF9hZGRy
ZXNzKSAmJiAocmVzX2luZGV4IDwgcmVzdWx0X2xlbmd0aCkpIHsNCisgICAgICAgIGVudHJ5ID0g
dnRkX2lvbW11X2F0c19kb190cmFuc2xhdGUoaW9tbXUsIGFkZHIsIGZsYWdzLCAwKTsNCisgICAg
ICAgIGlmICghSU9NTVVfVExCX0VOVFJZX1RSQU5TTEFUSU9OX0VSUk9SKCZlbnRyeSkpIHsgLyog
VHJhbnNsYXRpb24gZG9uZSAqLw0KKyAgICAgICAgICAgIGlmIChub193cml0ZSkgew0KKyAgICAg
ICAgICAgICAgICAvKiBUaGUgZGV2aWNlIHNob3VsZCBub3QgdXNlIHRoaXMgZW50cnkgZm9yIGEg
d3JpdGUgYWNjZXNzICovDQorICAgICAgICAgICAgICAgIGVudHJ5LnBlcm0gJj0gfklPTU1VX1dP
Ow0KKyAgICAgICAgICAgIH0NCisgICAgICAgICAgICAvKg0KKyAgICAgICAgICAgICAqIDQuMS4y
IDogR2xvYmFsIE1hcHBpbmcgKEcpIDogUmVtYXBwaW5nIGhhcmR3YXJlIHByb3ZpZGVzIGEgdmFs
dWUNCisgICAgICAgICAgICAgKiBvZiAwIGluIHRoaXMgZmllbGQNCisgICAgICAgICAgICAgKi8N
CisgICAgICAgICAgICBlbnRyeS5wZXJtICY9IH5JT01NVV9HTE9CQUw7DQorICAgICAgICB9IGVs
c2Ugew0KKyAgICAgICAgICAgICplcnJfY291bnQgKz0gMTsNCisgICAgICAgIH0NCisgICAgICAg
IHJlc3VsdFtyZXNfaW5kZXhdID0gZW50cnk7DQorICAgICAgICByZXNfaW5kZXggKz0gMTsNCisg
ICAgICAgIGFkZHIgPSAoYWRkciAmICh+ZW50cnkuYWRkcl9tYXNrKSkgKyAoZW50cnkuYWRkcl9t
YXNrICsgMSk7DQorICAgIH0NCisNCisgICAgLyogQnVmZmVyIHRvbyBzbWFsbCAqLw0KKyAgICBp
ZiAoYWRkciA8IHRhcmdldF9hZGRyZXNzKSB7DQorICAgICAgICByZXR1cm4gLUVOT01FTTsNCisg
ICAgfQ0KKyAgICByZXR1cm4gcmVzX2luZGV4Ow0KK30NCisNCitzdGF0aWMgdWludDY0X3QgdnRk
X2dldF9taW5fcGFnZV9zaXplKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSkNCit7DQorICAgIHJl
dHVybiBWVERfUEFHRV9TSVpFOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMgdnRkX2lvbW11
X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1hX2lvbW11LA0K
ICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9tbXVfcGFzaWQs
DQpAQCAtNjIzMSw2ICs2Mjk4LDggQEAgc3RhdGljIHZvaWQgdnRkX2lvbW11X21lbW9yeV9yZWdp
b25fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQogICAgIGltcmMtPnRyYW5zbGF0ZSA9
IHZ0ZF9pb21tdV90cmFuc2xhdGU7DQogICAgIGltcmMtPm5vdGlmeV9mbGFnX2NoYW5nZWQgPSB2
dGRfaW9tbXVfbm90aWZ5X2ZsYWdfY2hhbmdlZDsNCiAgICAgaW1yYy0+cmVwbGF5ID0gdnRkX2lv
bW11X3JlcGxheTsNCisgICAgaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gPSB2
dGRfaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb247DQorICAgIGltcmMtPmdldF9taW5fcGFn
ZV9zaXplID0gdnRkX2dldF9taW5fcGFnZV9zaXplOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgVHlw
ZUluZm8gdnRkX2lvbW11X21lbW9yeV9yZWdpb25faW5mbyA9IHsNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCmluZGV4IDNkNTllMTA0ODguLmFhNGQwZDVmMTYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KQEAgLTE5Myw2ICsxOTMsNyBAQA0KICNkZWZpbmUgVlREX0VDQVBfTUhNViAgICAgICAgICAg
ICAgICgxNVVMTCA8PCAyMCkNCiAjZGVmaW5lIFZURF9FQ0FQX05FU1QgICAgICAgICAgICAgICAo
MVVMTCA8PCAyNikNCiAjZGVmaW5lIFZURF9FQ0FQX1NSUyAgICAgICAgICAgICAgICAoMVVMTCA8
PCAzMSkNCisjZGVmaW5lIFZURF9FQ0FQX05XRlMgICAgICAgICAgICAgICAoMVVMTCA8PCAzMykN
CiAjZGVmaW5lIFZURF9FQ0FQX1BTUyAgICAgICAgICAgICAgICAoMTlVTEwgPDwgMzUpDQogI2Rl
ZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQogI2RlZmluZSBW
VERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQotLSANCjIuNDQuMA0K

