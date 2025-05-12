Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FBAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 05:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uELce-0003ND-OH; Mon, 12 May 2025 01:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uELcb-0003Mk-RI; Mon, 12 May 2025 01:22:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uELcZ-0002wJ-KW; Mon, 12 May 2025 01:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOG9pluopQikOlrYPTB9R2l8eQmxdRe8Fn4Ltj+DqD6J2rZ1OVv/Mc4BHBZ2+c4XA6RUU8Ac0mIENGwCz+tzoIW3BTWgMobz1lxQ5pB8IftaCi4QozWVg1YUdFFmcYVAQykJKojBNXAeXZlBvI0rXJWNpDooZrmhpz9d3s+iWmiqF8Wc+9C6HXpTPWi7ziAh38/YoeMt3/mXRTthu/1Y+svlm5GeXtnfMxQs5vMr9hw4D9o2z2bKQui/WJRQ4ob4jsL7Q0BFtMKX0AG/bMyppAnYs/4mEOSBFvXJt5A7VaaeTczCMhQ8oNp7GfHtJOSzson/1Sd/Xmc+ghyWKaEcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39s2YFhqJu9ZO3xD7sK94JJMu2LXzAzNxmpesW3m1zE=;
 b=DSHTD8uLbH+DM2V+iJw4pZAIITjwsRvPPMlTqPDl5oAjHQLXoQqA08c97FiEqA6pNBml/jEViT1530zI/K0eGb1iUIMCZYw/AsYKAGCxHunc1Wzbkrf1t9j6wZL46ud/hjD289FylwmCJ0qdz1VWqlK8wplN/mQEzRlmwP/jLEmYTt8mZc2kk3t0oazzaHBTXdAK6etc6War8nKS1+OxhGmO0IKwnljYeEL+d4/SgYdAYjT2Qc9ozDf2jX47GRJjh2MtlY6G5PJC9ieyahSgUIlQU2dRfiBoEyXsHJ5BlRidrCamZYrHQxb4bdATea+cOBF0MWw//OeVp/V0oM9PVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39s2YFhqJu9ZO3xD7sK94JJMu2LXzAzNxmpesW3m1zE=;
 b=d1q/9tpWyw8LWFyaD6O0Hsn6VRchjGhEL5nKcWoW9pXeD3exat9/Cx+VanD3mYbq1F5Vxl4LkswxdDGIolOfzLVXvNFqsE55yX69Is88u68SQT/AXd++p93OIAB0MIgaD1o1XamI2Tv8BqnrAUJYTLwVUiWhpN85DXQfCQiYKabc0oLwH3suuAigvDyAiTV1epPBt1TP35vt1qLez9VlF+2+Pr77VF3QAyJpvVwKvH/gArM7zjrooz0Al/hYf0l+xwgzhk+EAK7JmkcYPQoY5kO/ZK69I4tkE5DL+p2MU+mvFrm3l8VrfNbk8x4cvvqrunawT1u8pkoO9wfY4PsPXA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5239.apcprd06.prod.outlook.com (2603:1096:4:1d9::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.24; Mon, 12 May 2025 05:22:26 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:22:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 12/22] hw/misc/aspeed_hace Support to dump plaintext
 and digest for better debugging
Thread-Topic: [PATCH v1 12/22] hw/misc/aspeed_hace Support to dump plaintext
 and digest for better debugging
Thread-Index: AQHbmkNYC+eZUdBukUCmRNlYaPrCY7OQF3IAgD6vUHA=
Date: Mon, 12 May 2025 05:22:26 +0000
Message-ID: <SI2PR06MB50414A600B96C4D843C3478DFC97A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-13-jamin_lin@aspeedtech.com>
 <726eba25-0c1b-43b5-afc5-32cc96e8dc8a@kaod.org>
In-Reply-To: <726eba25-0c1b-43b5-afc5-32cc96e8dc8a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5239:EE_
x-ms-office365-filtering-correlation-id: 034ca30b-5d39-471f-3e89-08dd9114fbca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QTFjdDEreW9qRUtVcXh2eUo1R2prNWlsaGphQUhNblAvekkzS2JKTjNEa1pk?=
 =?utf-8?B?ZU9zOGd0WkhYYVFta2o0bFIxSTljbTQvZCt2bWZOcnhaL0lHK3grcXJod3Ft?=
 =?utf-8?B?cGczMEY3RmF6TXVtV2ZLMUIxTkNZS1F2Z2l6MXBMR0FlV1VyRDFHb0c2VTBL?=
 =?utf-8?B?YnVWY2pCS0NGeHZuMDRMcGdqcC9BRzhBNnhjdzlLTkJyV0VtZDFhUWhIU0da?=
 =?utf-8?B?bUxubERTbThHVlJsT1NZandpOEtUUk5SRTNrOHozUWcwbGdqV1F1Tkg0cWNM?=
 =?utf-8?B?aG53d1RtRHlIcEdINmdOZkR5Zlp3U1dUL0wzOHhxUWtXZ1MweDdsWXpZOWpx?=
 =?utf-8?B?MHkzYzFMNlY3MGNyREt6N1c0MmdpcmxsbnJ4Vi9Xcy9QK3NtdHZRc0Vqa25F?=
 =?utf-8?B?OHBIcHRsSDlJWHVFTlJLeTltMk5Xd0ZlYU9acG5yWk8rb016U2RqYmg4VFp5?=
 =?utf-8?B?Q0FRZE1sbHgvTCtQSy9GSGJTNFBsQjhCTzRNZDhYeDJTRFF0Mm1QRTAyWlBj?=
 =?utf-8?B?b0JhMlg5NDhWSGpha0Jvbi9Uem9uN2QzUjZkb0Y5OTE0YngzdS9UWHVXUzJm?=
 =?utf-8?B?RzhOV0FWZ3dYT3lsOHFNSm1Rd28xdGw5bThZM3JldnNmT3dSb1pWcnRIMDFk?=
 =?utf-8?B?VHNKMFFpMVp5aVBlN1FCT01ETEt6MGdTbmZ2VVYxb2JkQmFZRjZ4NFphRVBN?=
 =?utf-8?B?VEd3YWt2bmtlSDZCZW51dHVvVjBRWEVOdnJzL0h5aFplR3VxMFlaTGh4Wk1O?=
 =?utf-8?B?czhEWXJvU3daT3QvYnJOVGxJcEhrZGZCVVdrSVF2S1lMcFEvaEg2cjNreWMx?=
 =?utf-8?B?empDWE4xeWNOSnU1dXNzeDZXcTJHREc2dk1pNThPMVdhQTExeHY3SVE3L1Jq?=
 =?utf-8?B?YUQ0TVVoaS83bktFN3lEM21CckhBVEd3WDRqWndwa09pVmR4L0tldDBoc1ZL?=
 =?utf-8?B?Nm4ySWhOMzN6cGxhWG1NQU55emtodnR4U3BEb0hVNUYwVDQwaGJBTzYvOEJW?=
 =?utf-8?B?WCtoWXBQZWxxSnkzYm5VWllKdURHMTJJcElUQWc5a3BOQUdwUjkrWjZTL2lu?=
 =?utf-8?B?TUpCZGEvRDVtb1FYd0pCOG5aazJFZjl4UDhtTWxlS3N2cllGd0VCUk5wKzM0?=
 =?utf-8?B?NzRLVHdYMU9zZDByUzNJa0xmejgxVnN4NGZPQzkvQlM2cnJEZm83bGQ3Z3BU?=
 =?utf-8?B?UnBMZ1NSTkR1QkxQMndaV2k5d1N1MmFqS3ZsQjRnem5sVzRYOVdRT0xwaTlr?=
 =?utf-8?B?Zk1qQ3pvRmdQblNTeStXWWRvMkNCVnQrY3luN0N0c1daRlVabGdxeU1RSWFS?=
 =?utf-8?B?ZjA4b1ZqcTEwd0hwR0kyVzBWMUluR2VnN29LSzZsNXZ1RDhPQWM3a1JkeFFB?=
 =?utf-8?B?S05mdStEYWpDNjA4MHo1QlZZTkZuSzF5cU5zNWNOUDl4Mk91MXNNTFd0eWNl?=
 =?utf-8?B?T1k2VUc3Q1pXMTFtNE9JZVdVdmVjR01ITStwM0RtU0FINk5PMGNTSkUrV2Vs?=
 =?utf-8?B?dTkxT0JzamROckttUGcrNjZIV2M4d2lxQVNPL2ptT25CbjZGd1RzQzQ1NUNW?=
 =?utf-8?B?T2hXR050RXdiaG41SStRcHExenJUamUxSkFwRTRzQlBlcUN4TTdqRVJhQ2Jj?=
 =?utf-8?B?WXhnSTE5SG5BSTlHVldKa1BnNkZmamxZTGtzT1VkbE85emlhTHRQQkZHY0Uw?=
 =?utf-8?B?Nk5RaGVoQkNtTEFaNjJ5d0FOTFVpZzhoWnh0UXpZL3YxNGRiSkhGK1lncVg2?=
 =?utf-8?B?U3dSOHYvK1lkSkdEbExXZ0lCTEo4M0QrQVdxdFEySkRYQ2FWdDJ4WDJGOVJ5?=
 =?utf-8?B?SU91VldLaDh1cGtBOTVBK1U4SDlrSUMwYXNhNUJ0M0dRWUlRMEk0blZJaTBL?=
 =?utf-8?B?cmhQZWpEazFoZWQyUXJQT2p6N1o1OGl4ZEpMYUVuNkI5bERjSFZSemN6cGR1?=
 =?utf-8?B?M0tEcTJzR0t4UVZjRzZVUmNQY05jSVhwdWFpQTVYcHZqZDM2K0FwMWtMMFhN?=
 =?utf-8?Q?2w4njNMlOqJQoTI1USpD4CNizABTQk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDR6ZG5sZ2ZraDhlQy80SEl4UXN3dE9LaEVkbVlFZXdLdE1yekRsMGJHR3Bu?=
 =?utf-8?B?YnZKc255L1ZCYXQ0TUFtaFVRMFY2Y0dQU0pNcHZYcFA5LzZrelBtaG9sUEhk?=
 =?utf-8?B?RmVpSTQrb1VWdjAxc093a09DYmZmaGYwMDNhMmg2NmJZclpadzhyaUp3ZFRp?=
 =?utf-8?B?NXRhQllEaG11QVRoRTZKVElPc085UnRwRnJ2Q3VENGt1dUNWY3l6ZHZEMWFq?=
 =?utf-8?B?R3Rrb3ZzczdYSmJPckpDejBTNjNKaGRLQUozUDVqM2pxcXZSeTlVUWhnYVhn?=
 =?utf-8?B?TmpTS0ZxalNLOS9YZ0NDUStJSzhwZnNMc25yaVdOMDdwQStTalJ4bWIvb3JG?=
 =?utf-8?B?dXp1L2Jhb0wwN2g1Vm5tN3dkb2lBaUNyeWNMTGdSeFptUHVnemkxOFBYb0JI?=
 =?utf-8?B?b0MxbHZDYVpjRVpJc29sSFF5WGI0blhoTG9SUEpSZnBqNm1PeHBKSHZWMW1M?=
 =?utf-8?B?WDZPeDRFbmNpVmduS0l1WVFFZ1NSaDlCVHVuMEM4aUUvbWNwZStCM0oxMStS?=
 =?utf-8?B?MEFuc0xTamxDZkpVRUZWREZvUThTR25XSkdncGdnZ2hoRzNaUEJIdWNyNmJL?=
 =?utf-8?B?b3ZhTkZZQjRHT2tyekpkaE9Oc1pwSWZNQStGT2ZvbjRublFFbWw4UkVxVnJ0?=
 =?utf-8?B?SVFMUmFKRFQ4NUJpam42QlFJNTBlR3dOS0V4RnI4Nkp2UmlhckdVZGtNM2pz?=
 =?utf-8?B?UU5iNklMUDU3U3d1c1d4Z2dDNCtMWkVRYno2QWNUNHc5UHVYb0I2SSt5Q21W?=
 =?utf-8?B?aVV2S1VNWEE5WFl3YVo5WUFuTHNQNzZ4WEozMGt3YVBLaUtHTUVHQVFQaDRT?=
 =?utf-8?B?ajRMZGdqdXExcHJFMkRxODJNOHFqeU9aM3pjOE1OLzBwbzZUVklRZG9Kb3Fu?=
 =?utf-8?B?aHlDbCt1VVNTTTBBa2pNZzRNOXNHaFBweTB5UkdIUEJ1alpPM3BLMXNwL3Z4?=
 =?utf-8?B?SnhNbWY3MzdIMjk1ZGdZeGhoVzhBVkVOSHFwYzFVYkFLWXFuMmF3MFF3Y3A4?=
 =?utf-8?B?ellya0c0dDU5ek9rZFp3eWJpTzJySXhwVkNjdzNndGNoMkw3NzB5VXg5VkxT?=
 =?utf-8?B?dTBuUlpmREdjL3V0MTVRc0xQKzcyUGJySmhOZ0FiKytOZzRRTUc3ZVVnSS82?=
 =?utf-8?B?bnVsV0c1NlViK3lpSDNzU3B6ek1hR3pVc25lNzhCQXZYTXJJRFhDdHVxVjNF?=
 =?utf-8?B?WDlITUJ5S0lTVWVPS2N3dkdvT1VwdW1YQ1RaR21YYjlnYkt6K0Zxd1kwVFpZ?=
 =?utf-8?B?ZS9yN1BmSmk3ZVl3Z3dqQXR0a0VqbnpmUTlnRWxsWU02NllpWUx5WlduaWNW?=
 =?utf-8?B?eFVsT2xnWW1xM1pMTnVuOVBRcGttR09uM2VFc252aEZZbmJlWGxOclN4dW5u?=
 =?utf-8?B?VmhHUXUyNWt0L3VDbEovOFlCRzBSWksybncydXprRTZJOFFSMnpMamxxOWhn?=
 =?utf-8?B?Z3lWNnBFcjdSa2ppMGpWaHN4MmpVa2pkakZ3Y0FkZmF3Zzg3ZDhhYUowdmU1?=
 =?utf-8?B?d0hvbEtvSWZONWpTWmRCUHZKZjZaRm9pNFVzc1NFV2FQNEgrSGxjQnVacXVr?=
 =?utf-8?B?M21GSHZEK1hoUDZjdzV4NXdUQnlIWml2TGJBamp0ZUtpejJudzBVbDNrNWlu?=
 =?utf-8?B?WXVqZjVZM2ZhYzcyaVg3eHBBdnFMUmpkTXZvM2owTHpXZEpzVGxjZkJXVmpB?=
 =?utf-8?B?dmg3YmplQ2Q2OHdqT1dEbFgxSU5COWxLRzcvcnJPa1lWcU1ubmVRMWI4WWxX?=
 =?utf-8?B?Y29qN3dqTGxXVHlhanFWMTNPMHgyN245MUg4SnpTcEhqeWNBMkNVazdiTUtB?=
 =?utf-8?B?WkM3UjFiNXlaMXRyNFRQQjk4cUV6S1ZSL3d4eE9mMTBMVmhQbjNrcytVb3lW?=
 =?utf-8?B?UExHMm1rS2hhZlY2d1hVNmpoSk40UGE5ZkR1bTVCS0FhN3NRZnU1QmtxbXV1?=
 =?utf-8?B?TmhaV1lIcVlyWHErQnZWR20yb3BpVWFNTDRhWnZtdktEdGRDQUYzREFmMVE1?=
 =?utf-8?B?a3ZvRzVvcnM1WDcxSW9WK1MvaGhlc3BlUGNWZ2FzbTdKRzl5WjN6aldUQ3Q2?=
 =?utf-8?B?dC9HVjhETkJ1dmFTZWkzTHRKYXUvdUptOWRzeklTVEZDUysxZDBmUW55RGMz?=
 =?utf-8?Q?JetM4lsqmuG4xb5N4IyxMsP/l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034ca30b-5d39-471f-3e89-08dd9114fbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:22:26.6128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUo2l2U16iWtf8qN0Zge5pQkoJiHq5E1RzzCMa9UqdKhxTxfLBtoJ9SIQR092eVyAQOiR1RuxTefhWR77QM5/0Hd/oYewDGDGF9JvAWhT0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5239
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTIvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2UgU3VwcG9ydCB0byBkdW1wDQo+IHBsYWludGV4dCBhbmQgZGlnZXN0IGZvciBiZXR0
ZXIgZGVidWdnaW5nDQo+IA0KPiBPbiAzLzIxLzI1IDEwOjI2LCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4gMS4gRGlzYWJsZWQgYnkgZGVmYXVsdC4gVW5jb21tZW50ICIjZGVmaW5lIERFQlVHX0hBQ0Ug
MSIgdG8gZW5hYmxlIGl0Lg0KPiA+IDIuIFVzZXMgdGhlICJxZW11X2hleGR1bXAiIEFQSSB0byBk
dW1wIHRoZSBkaWdlc3QgcmVzdWx0Lg0KPiA+IDMuIFVzZXMgdGhlICJpb3ZfaGV4ZHVtcCIgQVBJ
IHRvIGR1bXAgdGhlIHNvdXJjZSB2ZWN0b3IsIHdoaWNoIGNvbnRhaW5zIHRoZQ0KPiA+ICAgICBz
b3VyY2UgcGxhaW50ZXh0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9taXNjL2FzcGVlZF9oYWNl
LmMgfCAxMiArKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9hc3BlZWRfaGFjZS5jIGIvaHcvbWlz
Yy9hc3BlZWRfaGFjZS5jIGluZGV4DQo+ID4gYjhlNDczZWUzZi4uYWU0ZDJmYTY4NyAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9taXNjL2FzcGVlZF9oYWNlLmMNCj4gPiArKysgYi9ody9taXNjL2FzcGVl
ZF9oYWNlLmMNCj4gPiBAQCAtMTAsOCArMTAsMTAgQEANCj4gPiAgICAqLw0KPiA+DQo+ID4gICAj
aW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCINCj4g
PiAgICNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiA+ICAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVw
b3J0LmgiDQo+ID4gKyNpbmNsdWRlICJxZW11L2lvdi5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L21p
c2MvYXNwZWVkX2hhY2UuaCINCj4gPiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4gICAj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4gPiBAQCAtMjAsNiArMjIsOCBAQA0KPiA+
ICAgI2luY2x1ZGUgImh3L2lycS5oIg0KPiA+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4NCj4g
PiArLyogI2RlZmluZSBERUJVR19IQUNFIDEgKi8NCj4gPiArDQo+ID4gICAjZGVmaW5lIFJfQ1JZ
UFRfQ01EICAgICAoMHgxMCAvIDQpDQo+ID4NCj4gPiAgICNkZWZpbmUgUl9TVEFUVVMgICAgICAg
ICgweDFjIC8gNCkNCj4gPiBAQCAtMjY4LDYgKzI3MiwxMCBAQCBzdGF0aWMgdm9pZCBkb19oYXNo
X29wZXJhdGlvbihBc3BlZWRIQUNFU3RhdGUgKnMsDQo+IGludCBhbGdvLCBib29sIHNnX21vZGUs
DQo+ID4gICAgICAgICAgIH0NCj4gPiAgICAgICB9DQo+ID4NCj4gPiArI2lmZGVmIERFQlVHX0hB
Q0UNCj4gDQo+IENvdWxkIHdlIHVzZSBhIHRyYWNlIGluc3RlYWQgPyBTZWUgdHJhY2VfZXZlbnRf
Z2V0X3N0YXRlX2JhY2tlbmRzKCkgZm9yDQo+IGNvbXBsZXggdHJhY2VzIGFuZCBxZW11X2hleGR1
bXBfdG9fYnVmZmVyKCkgPw0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlv
bi4NCldpbGwgYWRkICJoZXhkdW1wIGRhdGEiIGluIHRyYWNlIGV2ZW50Lg0KVGhhbmtzLUphbWlu
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiANCj4gPiArICAgIGlvdl9o
ZXhkdW1wKGlvdiwgaSwgc3Rkb3V0LCAicGxhaW50ZXh0IiwgMHhhMDAwKTsgI2VuZGlmDQo+ID4g
Kw0KPiA+ICAgICAgIGlmIChhY2NfbW9kZSkgew0KPiA+ICAgICAgICAgICBpZiAocWNyeXB0b19o
YXNoX3VwZGF0ZXYocy0+aGFzaF9jdHgsIGlvdiwgaSwgJmxvY2FsX2VycikgPCAwKSB7DQo+ID4g
ICAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgInFjcnlwdG8gaGFz
aA0KPiB1cGRhdGUNCj4gPiBmYWlsZWQgOiAlcyIsIEBAIC0zMTEsNiArMzE5LDEwIEBAIHN0YXRp
YyB2b2lkDQo+IGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywgaW50IGFsZ28s
IGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkX2hhY2U6
IGFkZHJlc3Mgc3BhY2Ugd3JpdGUgZmFpbGVkXG4iKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAr
I2lmZGVmIERFQlVHX0hBQ0UNCj4gPiArICAgIHFlbXVfaGV4ZHVtcChzdGRvdXQsICJkaWdlc3Qi
LCBkaWdlc3RfYnVmLCBkaWdlc3RfbGVuKTsgI2VuZGlmDQo+ID4gKw0KPiA+ICAgICAgIGZvciAo
OyBpID4gMDsgaS0tKSB7DQo+ID4gICAgICAgICAgIGFkZHJlc3Nfc3BhY2VfdW5tYXAoJnMtPmRy
YW1fYXMsIGlvdltpIC0gMV0uaW92X2Jhc2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW92W2kgLSAxXS5pb3ZfbGVuLCBmYWxzZSwNCg0K

