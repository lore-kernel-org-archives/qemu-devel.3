Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8202CC6B21
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8D3Y-0007fw-Pr; Thu, 02 Apr 2026 04:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w8D3W-0007ee-5m
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 04:05:34 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w8D3T-00084B-44
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 04:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1775117132; x=1806653132;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HBRlbKDctCQ90cVY7dUoj9ir2Mjfi899gFPrsCDz1IM=;
 b=mHJT3CZTCioZBCN18kd7JjZ8oduoDcCEa47LxfTQzLBQSh3c1b7xpBEh
 I1qeKiNyhuApJQGLP/TrfbFR3UXUyDDJ6IhVkcIAP9FlVzhGYhCsfCuhA
 v8zX68tw5vKRCnK6QPQOjnI+HOPovur0gUJZrC9le3f/Fb12qCiQr/Nj3
 3k0rj5hNIKYBNBjgsDaCeA+aMjTCk9Ec9BJqNa+sXh41nJpC0sHfiLkEg
 3/lyW5Xe/IOV3wAcTmoskyYDrUfue8t7FmVJodDgfxZeGU0oBFoOatqR7
 8JEgX3h5kMrxGfCAcHEAF4JlqtUaKiVdnFXd0KPZqvenyXM46j/O0f1hf Q==;
X-CSE-ConnectionGUID: dK7EyKJ5Q6KZ3m/zxQU8hQ==
X-CSE-MsgGUID: rDA0X9qoQDSbL6rBBsqBkw==
IronPort-SDR: 69ce2346_ginEYjOx3oFQcG4SnmcUIHwYJSEmPg83PUKNOhe0noNRvKb
 +/ARiEJIrzjAXm5O18Fjj6W8fMKHz+S5O3mXvbA==
X-IronPort-AV: E=Sophos;i="6.23,155,1770591600"; d="scan'208";a="47333998"
X-MGA-submission: =?us-ascii?q?MDF5BPkviqjxrWXBTBFdUf4mSC5WSky917Est2?=
 =?us-ascii?q?QnR/xneDPyYRbROWm7jBmCC3PxgHt7GQU9p7n6DfGyahqADYtrba3HL+?=
 =?us-ascii?q?OyNEPFPCSZciNh+5k/elyXslGjEhBb7I0Lo13jDw5H8STN9f2G2HdBdY?=
 =?us-ascii?q?PX7KU1eyc3mqFpyCuLsT9PJw=3D=3D?=
Received: from mail-northeuropeazon11011026.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.26])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Apr 2026 10:05:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWRpArVIsOHPYcvmekZp0RAbBe01rH4QAjUXU7+yZle03QmrhEAWkMIkHUh0H/Flb/dTk/DHSqYX/Gvm/33KTT4McacjEjwCoqQaaIVr2h6vUGg9Va+t7NtVB5Ip2gLZRMdaeycMg8tBKu5g1R20gCg7uT2zV8QbK+bgD0JmPAWfGelNEjXLybsIVHrYjspaRtEK8P6dyJF5bWFLwVsINVK1pL+xMTkj6CAoIY9FQC0cUDGsmLyvcZ/gO10BUYEu7//kBkaNmYeneiC8ioVL6NgQAnzEsXsS8xg/480D5GvncuYLZ33UtQ6Jj40pCaUovBsmQQ3mloj8MYi3bdbRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBRlbKDctCQ90cVY7dUoj9ir2Mjfi899gFPrsCDz1IM=;
 b=VHNlLFtkCVxsA/sR/RS1XDGkv3N9KQir1058pGQqdjnTvOMOWn5ar8kD77GG2hU3RyDCepFhTcHdXaykiK1xhwSw5Ywlq5CVtJVb6+uSIGR3fP6M5WH+X33UD+ZJ/caFFCDI9ybI2F208jVE2jNY5pKRmJt6kqFo4Naku/IsVKg1Y2dt1Ra5ErgDfTm8PWVh3Pw5m/8XQNOvV4tB2oUhlYHPmictKqXzMukKAgv8qEi5+sb1rxsiuQiSQ/n1x6r2gMQLPOYPH7oxSQnVRH6T3NrVMiWvxBmeBkULjun40a8pvy3nXA1KXtcrqdA/M6Ury8yYAoV19QJ0ZQCDFQMXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB11657.eurprd07.prod.outlook.com (2603:10a6:150:314::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 08:05:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 08:05:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRucl+8w3w8Tvkaf2W6HYfy4KrW1kwGAgAASeoCAAT2GgIARd4iAgAAIVoCAAaMPgIAAEjiAgAF8XoA=
Date: Thu, 2 Apr 2026 08:05:19 +0000
Message-ID: <e2ef69de16fc315fdf0f1badd0119e47aeedc42e.camel@eviden.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
 <IA3PR11MB913601196392D72E02E5AB579253A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fb14a3f7f49e98683b666084aa3ae10b36ee4282.camel@eviden.com>
 <IA3PR11MB913614688F3DE7F70A09089A9250A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913614688F3DE7F70A09089A9250A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB11657:EE_
x-ms-office365-filtering-correlation-id: 66b25ec2-fb7b-4d0c-f0dc-08de908e952a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Oz//K1E7KEjD99Y+asgCYGwf0rnc4GbSFHqTjyK3P73wHN6HfBSe/DQwdnCBA5fAQQp8MwSqwl2/pDHyq/1o9s+DzEDSSy1IjzH0nWFvKciMK4pB78cqc/tgVUsPQvIWKuxT8kr+n/9nXWEPnY+m8L5NTftUQuQL5iFPPcqOJUtxxSNaYtC1c5+Fv1gR294dcA8PF65oHq2fHIyqb4DUACcwQTkT3pwRgTLa8csetKzF0zPmcs7LN65PZL4b3gSTuCaxToPw3T4jVLmhZEtGiEnXNOVg2qh6lzG+0Ib2Lg+7pZhEqsKO2/7D0dZE93sWuspfgambU/gtfanqwBcbEW4MJqkeqrLjs3gIzR6eWI2GXVscu9g1BGopBwR+L8K2kkEdwEKd+b/achBuZxepcu4AjU2tUnkCK9zmGECs7Tbm+f9YhcIPTrH0zBCo382sZSvlKmlm3h68WvAcWj4n8pL3KM5kxj6cZoOuwERCzjBvZEzf8xr1pURRafqWZbBahP9iKRS0OLFIiEDCnEwToW07yAnuowCwPAEjv8CCJT2MEhp2FFPaI7ZInfx2fNTtoixVMMpnk9Z9UQWYS1Xop6Ta6ZcGNOYDEFen70S8WrY6XE8Q3dXlKTSZ8QsEJP0jl6uSpGknj5UqG1jQBgnPbSWFIle4DarSTrFmj9KxV9wONJ8kRKfrboFe/JxwcJ90Wc0PvJjEL/qdLILBRgvlDVKIDh9yK9hVTIwy48Jv3YS9lfbpYkIRA1BZQumLyuo908My8zObtDaOIl/x6JDXm+RJRfAFltjeRl2unKQLPZg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NklCeFl5QnJ1b3kzTTIzM0ZyV293WEVsMHhKOG8yL2dNT0pWbU5ZaldjMTVr?=
 =?utf-8?B?bWhQeUdHWUxnMmRQaWtYVFdKYkNDYVAwQjQ2blF5d2VmNHprYUI3RGdOUW51?=
 =?utf-8?B?NjJMOUpFblNEekFKaGk1WWh1QktEMUx6Qit4bnE0V3Z6S3FObHlSUjJqditp?=
 =?utf-8?B?NVBzdExHRXI5Q1hENTRnT2l3R3lVT0tITVJoK0ExckJMMVkra2V1RkNVV3Nv?=
 =?utf-8?B?UlVFY1czQnoxMU8xN3RpNCs0RXR1TXlaY1QvbXRGeHRpSXE4dFVHNUplWXZx?=
 =?utf-8?B?YXcyaVpacTgyWU9XVHgvWDR0dkxqMytKU3g2MnRxdWMyMkJIaVRWTXVTbSty?=
 =?utf-8?B?MGxkMkwvNndOMGhpUzVQc3M2dkZqeVBwbXQwd2NFN1hxWFpGb3IxV29scXc5?=
 =?utf-8?B?VjJqNnlLT2N3b3RHSzhDUnhLcVJCM3Vmdm9TODFLeVl2WFgwSXZrbkg5VEgy?=
 =?utf-8?B?dFg2WmRwS1FNbnl2VDhSaGdySWZ4clVEL3oxSTRuM3RwTHJTVWtSZm8vNld0?=
 =?utf-8?B?MEJmeHpsRXFHTEQ1RVd6TkoxOTFDWGlsRUdvdmRicXhGUUt3RkF3TmJRbHUr?=
 =?utf-8?B?cXRsSFJMNzcvQ0ZzSlhncS9icVdseGUzTzBTaGZ3ZjVKQlFNdWEzZmhybDJl?=
 =?utf-8?B?eGUvd2VaRTlrdzBuYk12elF3QzArWllJMkdmWnQwTkUzUUdSWVVkN25zVzlr?=
 =?utf-8?B?T0Q2ZDNXZFBqNlhqa29XS1FYU2lKYUp1Zlo2YU9SNDF6V1J2THBpVUFqc2NJ?=
 =?utf-8?B?MkFjcklBaURDSThQQkg5cGkxTkNvWTRGQXlQVFVZMFQ2L1RLeHg1WkdEYW1T?=
 =?utf-8?B?TitsWHN6eHhqU3lnWktxVzkrblJJS2RzclNVQ1UzekwvcDJYTzJPaGF5QWg5?=
 =?utf-8?B?NVAvMlBaY01MWktyK3Y3cWkvRHNZZ0o3S1hiL0JLZHFQejFtS0FMUXdJN1My?=
 =?utf-8?B?NVZXYW5EcUxUa05HMCt6RFBlaC9PVnc3bS9SMVFqT05OQ0MvOXpGWS8vbGVs?=
 =?utf-8?B?TlFjWkJsVWVDTjR3OVpyNG9lbVZhU2tTLzNqNTQ1bGVIK0Vtb2tHNGxSRHJy?=
 =?utf-8?B?WVI3S3pJNUR2bE5veGN1VEV6bVlkRzdoSTliK2lCai9nbUJDTGgycTUrQ0pV?=
 =?utf-8?B?OUFLdUdab01YenRxOFYvekFTVCtGRmpmb1ZLVEsxZXZkck92NzVlZGk5T0Jn?=
 =?utf-8?B?Z2oxbWVDRzFPcktLVnRxUWhzNTBzbjhCbEIzWFFBTjFoV1Rxc0RBd0dKcGtH?=
 =?utf-8?B?eUhWWExiaWtDbkVBZnhmeVBYSTUzMTJoUXM5bERUeG9WUXdrK0x0dXk1eXpU?=
 =?utf-8?B?eTNBSDVoRjVjY0c1TzZDUTBQVWdDZ1NlU3JWc2MzTjgwNEE1aXU4dGVqVVVq?=
 =?utf-8?B?MnBESTdWMVYxc2tFQzdaa2lTU1ZiSXhydzhDYUFUL0NvVGhtYUF5L05HYWJR?=
 =?utf-8?B?Rk9PVVpPN2VHVlEycnZJbmNpcXZKTW13V291cVUxVm1HU2h6eStaajBlZnNk?=
 =?utf-8?B?WUM2Z0M3WEZ6elN2aEVZeVd4VUQvckJSU2puUTkvdEs5MVkzY1FpSWtMQVpr?=
 =?utf-8?B?QmVScm4rV2ZBbXJUckc3aTBiM2RxVUI2TGlhVXFIRVJOdEVzT1diLzAwM0tt?=
 =?utf-8?B?cUNyY0pHenNOTVY4b1V3SWl5dWhWc3doejAydzRDTjNicFUrYS9PeXVZOHVL?=
 =?utf-8?B?Rkl6ZWpIUmR0OXFVaE56UzJ2YTQycWV0T1g4cVVEOVhYWjNvTXVHQjdqL3kw?=
 =?utf-8?B?YU1FSkxBT1l1SXMyU0pLc2xhNzF0ZUcwblVKK0FQNEZQM2NrK05EL05PQm9v?=
 =?utf-8?B?Nm5hcGRFNk1LUU5RM1MxR01IV3FLMzhVbTFheEMzOGFhcHhQbVJGTGRYNSth?=
 =?utf-8?B?RVJDY0tpUFBBdU9hcHlyQmhwQjZ6eEJqdVZ4cnhlV3Jlb2N2MlovT3hhQjRV?=
 =?utf-8?B?ZTkxRXpSTUMrVEpmWUF5Y2IzQWl4S3drM1EwUHdrMVJFaHUrblJwUFU1WnRz?=
 =?utf-8?B?b1k1bitLMjlFN2I2VHBNa3p4dXUzaWw5c25Fb0N5eksvRTI5Y05yanM5YW9S?=
 =?utf-8?B?NUNGU01FYVBlSGh4QTlrRmFodnM2eXp6Z2lFRkpISHl0TXNLcDYzZXNLRE5S?=
 =?utf-8?B?SFdaRm9JM21INlFkbEZhejE1TE9TdzE2ME9CVWx2amhHMHFwUHFGUjh4RFp3?=
 =?utf-8?B?a0ltNGp4OFppYnFiSGkzQXZKS2crekl6VWVjVFk1QStXZkxtUGdyUjl5YkVv?=
 =?utf-8?B?dERrNEJ4Q1pIOTk1T3g5cy9MOHB1bjdFaCtQMGhDVDRGaVR2cmM4YlRxbWVN?=
 =?utf-8?B?TU1qMFYyTDBSTHlCUFhaYjhFeGU2clVLcWt2QmE1b1R6LytWRGd5dTJZbTBH?=
 =?utf-8?Q?sJq7A9iTXyTtSLgC7C3JS/18SyPRXh7jG9dK8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01138170704D9F448939B9E634DCC053@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SbSe1nIy3RhtvbKr//ec+4udeL0ffh+l/rcSmBnqeZGPbkcNaO7M0D9C/ZC3Z4E0m6MRSftKNSwfp6WApbTa8HqP9wn0CN90AkoxuRJPdQWc4HB3rHCHH/S2i/9PgeJb4t9lWT0gvkVAMEongrY03NbtqujS1e2Oq01VPWgPoi/z2011gtQqMfYFzWoIW2tryoXXu/3pCO+JZllbJr4u7kf9cQKSwgpvAtluI0vUUGy6PrSNVD7+nL5MytStZS+QMghezze9PFqPETQABqbXxX11f2BK3Yr/iD6cnNWhzP4S0+wcReVZioYZWmqBq/Z9B7iztTVYZfq0ebD4tdJ+Wg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b25ec2-fb7b-4d0c-f0dc-08de908e952a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 08:05:19.5200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6rb2RyHHlQSEWoHwTXZ4NbZgIOkLyUc0Sdb8u0OkYjKliplVz3m8tQqXEfySss1QrbFJJC8RRks44/eTeEUFXnOvznWcgklB5hpPJUw/ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11657
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQpPbiBXZWQsIDIwMjYtMDQtMDEgYXQgMDk6MjMgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gSGkgQ2xlbWVudCwNCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS1kcmlm
QGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tKT4NCj4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxIDExLzEzXSBpbnRlbF9pb21tdV9hY2NlbDogZHJvcCBfbG9j
ayBzdWZmaXggaW4NCj4gPiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZCgpDQo+ID4g
DQo+ID4gDQo+ID4gT24gVHVlLCAyMDI2LTAzLTMxIGF0IDA3OjE4ICswMDAwLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogQ0xFTUVOVCBNQVRI
SUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS0NCj4gPiA+IA0KPiA+IA0KPiA+IFtkcmlmQGJ1
bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1haWx0bzpbY2xlbWVudC5tYXRoaWV1LS1k
cmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tKSk+DQo+
ID4gDQo+ID4gPiANCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxf
aW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+ID4gPiA+IHZ0ZF9mbHVzaF9ob3N0
X3Bpb3RsYl9hbGxfbG9ja2VkKCkNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBGcmks
IDIwMjYtMDMtMjAgYXQgMDQ6MDQgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IEhpIENsZW1lbnQsDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gRnJvbTogRHVhbiwgWmhlbnpob25nDQo+ID4gPiA+ID4g
PiBTdWJqZWN0OiBSRTogW1BBVENIIHYxIDExLzEzXSBpbnRlbF9pb21tdV9hY2NlbDogZHJvcCBf
bG9jayBzdWZmaXggaW4NCj4gPiA+ID4gPiA+IHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9j
a2VkKCkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSGkgQ2xlbWVudCwNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gPiBGcm9tOiBDTEVNRU5U
IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBbW2RyaWZAYnVsbC5jb21dKG1haWx0bzpkcmlmQGJ1bGwuY29tKV0obWFpbHRvOltkcmlmQGJ1
bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSkpXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0t
DQo+ID4gPiANCj4gPiANCj4gPiBbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZAYnVsbC5jb20p
XShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1lbnQu
bWF0aGlldS0tZHJpZkBidWxsLmNvbSkpKT4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDExLzEzXSBpbnRlbF9pb21tdV9h
Y2NlbDogZHJvcCBfbG9jayBzdWZmaXggaW4NCj4gPiA+ID4gPiA+ID4gdnRkX2ZsdXNoX2hvc3Rf
cGlvdGxiX2FsbF9sb2NrZWQoKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gdnRkX3Bp
b3RsYl9wYWdlX2ludmFsaWRhdGUgY2FuIGJlIGNhbGxlZCBmcm9tDQo+ID4gPiA+ID4gPiA+IHZ0
ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4gVGh1
cyB3ZSBjYW4gY2FsbA0KPiA+ID4gPiA+ID4gPiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2Fj
Y2VsIHVubG9ja2VkLiBJcyB0aGVyZSBhIHJpc2sgaW4gY2FzZSBvZg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiBjb25jdXJyZW50IGhvdA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBwbHVn
Z2luZyBvZiBhbm90aGVyIGRldmljZT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gR29vZCBjYXRjaCwgaG90cGx1ZyBp
cyBwcm90ZWN0ZWQgYnkgQlFMLCBidXQgaWYgYW4gaW90aHJlYWQgY291bGQgc2VuZCBQUkkNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiByZXF1ZXN0
LA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiB3ZSBzdWZmZXIgZnJvbSB0aGUgcmFjZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSB0
aGluayB3ZSBjYW4gYnlwYXNzIHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24o
KSBmb3INCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBwYXNzdGhyb3Vn
aA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGV2aWNl
DQo+ID4gPiA+ID4gPiB3aGljaCBkb2Vzbid0IGNhY2hlIGlvdGxiIGVudHJ5IGluIFFFTVUgYnV0
IGluIGhvc3QsIGxpa2U6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEBAIC01NDAxLDcgKzU0
MDEsOCBAQCBzdGF0aWMgaW50IHZ0ZF9wcmlfcmVxdWVzdF9wYWdlKFBDSUJ1cyAqYnVzLA0KPiA+
ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IHZvaWQNCj4gPiANCj4gPiA+IA0K
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICpvcGFxdWUsIGludCBkZXZmbiwNCj4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PU1BDOw0KPiA+ID4gPiA+ID4gwqDC
oMKgIH0NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLcKgwqDCoCBpZiAodnRkX3ByaV9wZXJm
b3JtX2ltcGxpY2l0X2ludmFsaWRhdGlvbih2dGRfYXMsIGFkZHIpKSB7DQo+ID4gPiA+ID4gPiAr
wqDCoMKgIGlmICghdnRkX2ZpbmRfaGlvZF9pb21tdWZkKHZ0ZF9hcykgJiYNCj4gPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoCB2dGRfcHJpX3BlcmZvcm1faW1wbGljaXRfaW52YWxpZGF0aW9uKHZ0
ZF9hcywgYWRkcikpIHsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFM
Ow0KPiA+ID4gPiA+ID4gwqDCoMKgIH0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZnRlciBmdXJ0aGVyIHRoaW5raW5nLCBJIGZvdW5k
IGFib3ZlIGNoYW5nZSBkb2VzbuKAmXQgcmVzb2x2ZSB0aGUgcmFjZSB5b3UNCj4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiBtZW50aW9uZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBCdXQgSSB0aGluayB0aGUgaW90aHJlYWQgc2hvdWxkIHRha2UgQlFMIGJl
Zm9yZSBjYWxsaW5nIDo6cHJpX3JlcXVlc3RfcGFnZSgpLA0KPiA+ID4gPiA+IGJlY2F1c2UgaXQg
aXMgYSBmdW5jdGlvbiBjaGFuZ2luZyB2dGQgZGV2aWNlIGNvbnRleHQsIGUuZy4sIFBRVCBhbmQg
UFJTDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gcmVnaXN0ZXIsDQo+ID4gDQo+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+ID4gcGFnZSBpbnZhbGlkYXRpb24gcXVldWUgYW5kIGlvdGxiIGVu
dHJpZXMuIFdlIHNob3VsZCBhbHdheXMgdGFrZSBCUUwgYmVmb3JlDQo+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gY2hhbmdpbmcNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IGNvbnRl
eHQgb2YgYW55IGRldmljZS4gTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgZGlmZmVyZW50IG9waW5p
b25zLg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBEbyB5b3UgbWVhbiB0
aGF0IGV2ZXJ5IGVtdWxhdGVkIGRldmljZSB0aGF0IHRyaWdnZXJzIGEgUFJJIHJlcXVlc3Qgc2hv
dWxkDQo+ID4gPiANCj4gPiANCj4gPiBob2xkDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gdGhlIEJR
TD8NCj4gPiA+ID4gSSdtIG5vdCBzdXJlIHRoaXMgaXMgYSB2aWFibGUgcGF0dGVybiBhcyB0aGUg
aW5pdGlhdG9yIHByb2JhYmx5IGFscmVhZHkgaG9sZHMgYW4NCj4gPiA+ID4gaW50ZXJuYWwgbG9j
aw0KPiA+ID4gPiBhbmQgdGh1cyBjYW5ub3QgdGFrZSB0aGUgQlFMIHdpdGhvdXQgcmlza2luZyBk
ZWFkbG9ja3Mgd2l0aCBjb25jdXJyZW50DQo+ID4gPiANCj4gPiANCj4gPiBNTUlPIDovDQo+ID4g
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSUlVQywgcWVtdSBkb2Vzbid0IHN1cHBvcnQgY29uY3Vy
cmVudCBNTUlPIGVtdWxhdGlvbnMgeWV0LCB0aGV5IGFyZSBzZXJpYWxpemVkDQo+ID4gDQo+ID4g
YnkgQlFMLiBJZiB3ZSBkb24ndCB0YWtlIEJRTCBpbiBjYWxsIHNpdGUsIHRoZW4gd2UgbmVlZCBp
dCBpbiBjYWxsZWUsIGxpa2U6DQo+ID4gDQo+ID4gPiANCj4gPiA+IEBAIC01MzUxLDYgKzUzNTEs
OCBAQCBzdGF0aWMgaW50IHZ0ZF9wcmlfcmVxdWVzdF9wYWdlKFBDSUJ1cyAqYnVzLCB2b2lkDQo+
ID4gDQo+ID4gKm9wYXF1ZSwgaW50IGRldmZuLA0KPiA+IA0KPiA+ID4gwqDCoMKgwqAgSW50ZWxJ
T01NVVN0YXRlICpzID0gb3BhcXVlOw0KPiA+ID4gwqDCoMKgwqAgVlREQWRkcmVzc1NwYWNlICp2
dGRfYXM7DQo+ID4gPiANCj4gPiA+ICvCoMKgwqAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4gPiA+ICsN
Cj4gPiA+IMKgwqDCoMKgIHZ0ZF9hcyA9IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZuLCBw
YXNpZCk7DQo+ID4gPiANCj4gPiA+IMKgwqDCoMKgIHVpbnQ2NF90IHF1ZXVlX2FkZHJfcmVnID0g
dnRkX2dldF9xdWFkKHMsIERNQVJfUFFBX1JFRyk7DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+ID4gT3RoZXJ3aXNlLCBpdCBtZWFucyB0aGF0IHRoZSBkZXZpY2UgYWx3YXlz
IHRha2VzIHRoZSBCUUwgYmVmb3JlIHRha2luZ8KgIGl0J3MNCj4gPiA+IA0KPiA+IA0KPiA+IG93
bg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IGxvY2suDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBJIHRoaW5rIGl0J3MgdHJ1ZSBiZWNhdXNlIHdlIGFsd2F5cyB0YWtlIEJRTCBiZWZvcmUg
ZW11bGF0aW9uIHN0YXJ0Lg0KPiA+IA0KPiA+IA0KPiA+IFRoaXMgaXMgcHJldHR5IGRhbmdlcm91
cyBJTUhPLg0KPiA+IA0KPiA+IFRoZSBlbXVsYXRlZCBkZXZpY2UgdGhhdCBlbmRzIHVwIGNhbGxp
bmcgdGhpcyBmdW5jdGlvbiBwcm9iYWJseSBoYXMgYSBsb2NrIG9uIGl0cw0KPiA+IHNpZGUgYWxy
ZWFkeSwgbGV0J3MgY2FsbCBpdCBkZXZfbG9jay4NCj4gPiANCj4gPiBJIHRoZSBkZXZpY2UgZG9l
czoNCj4gPiAJLSBsb2NrKCZkZXZfbG9jaykNCj4gPiAJLSBzdGFydCBhIFBSSSByZXF1ZXN0DQo+
ID4gCS0gbG9jaygmYnFsKQ0KPiANCj4gDQo+IEkgaGF2ZSB0d28gcXVlc3Rpb25zOg0KPiANCj4g
MS4gd2hpY2ggdGhyZWFkIG1heSBoYXZlIGFib3ZlIHNlcXVlbmNlPyAgDQo+IDIuIGRvIHdlIGhh
dmUgdG8gcHJvdGVjdCBQUkkgcmVxdWVzdCB3aXRoIGRldl9sb2NrPw0KPiANCj4gUFJJIHN0YXRl
IGlzIHByb3RlY3RlZCBieSBCUUwsIEkgdGhpbmsgbm8gbmVlZCB0byBiZSBndWFyZGVkIGJ5IGRl
dl9sb2NrLiBNYXliZSB1bmxvY2sgZGV2X2xvY2sgZHVyaW5nIFBSST8NCg0KRGV2aWNlcyB0aGF0
IHBlcmZvcm0gc3ZtIG9wZXJhdGlvbnMgaW5zdGVhZCBvZiByZWd1bGFyIGRtYSBlbmQgdXAgcGVy
Zm9ybWluZyB0aGlzIGtpbmQgb2Ygc2VxdWVuY2UuICANClRoZSBpc3N1ZSBpcyB0aGF0IGRldmlj
ZSBzdGF0ZSBpcyBndWFyZGVkIGJ5IHRoZSBkZXZpY2UgbG9jay4gVGh1cywgdGFraW5nIHRoZSBi
cWwgaW4gdGhlIHByaSBjYWxsYmFjayAgDQpvZiB0aGUgaW9tbXUgcmVxdWlyZXMgdGhlIGRldmlj
ZSB0byB1bmxvY2sgaXRzIG93biBsb2NrIGJlZm9yZSBzdGFydGluZyB0aGUgUFJJIG9wZXJhdGlv
biBvciB0byByZWx5IG9uICANCnRoZSBicWwgYWxsIHRoZSB0aW1lIGluc3RlYWQgb2YgaXRzIG93
biBsb2NrLg0KDQpJJ20ganVzdCB0cnlpbmcgdG8gbWFrZSBzdXJlIHN2bSBkZXZpY2VzIHdpbGwg
bm90IGJlY29tZSBpbXBvc3NpYmxlIHRvIGltcGxlbWVudCBqdXN0IGJlY2F1c2UgdGhleSAgDQpo
YXZlIHRvIGJyZWFrIHRoZWlyIGZsb3cgYW5kIHVubG9jayBldmVyeSB0aW1lIHRoZXkgdHJpZ2dl
ciBhIG1lbW9yeSBvcGVyYXRpb24uDQoNCj4gDQo+IFRoYW5rcyAgDQo+IFpoZW56aG9uZw0KPiAN
Cj4gDQo+IA0KPiA+IGFuZCBpZiB0aGUgaG9zdCB0cmlnZ2VycyBhbiBNTUlPIG9wZXJhdGlvbiBv
biB0aGUgZGV2aWNlOg0KPiA+IAktIGxvY2soJmJxbCkNCj4gPiAJLSBsb2NrKCZkZXZfbG9jaykN
Cj4gPiANCj4gPiBXZSBjYW4gdGFrZSBkZXZfbG9jayBhbmQgYnFsIGluIHJldmVyc2Ugb3JkZXIs
IGxlYWRpbmcgdG8gcG90ZW50aWFsIGRlYWRsb2NrcyBvLk8NCj4gPiANCj4gPiANCj4gPiA+IA0K
PiA+ID4gVGhhbmtzDQo+ID4gPiBaaGVuemhvbmcNCj4gPg0KPiA=

