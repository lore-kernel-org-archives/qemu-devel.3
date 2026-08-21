Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83BAC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxIV7-0000e9-GV; Fri, 21 Aug 2026 02:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wxIV4-0000d2-2X
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 02:13:10 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wxIV1-0001W5-OC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 02:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1787292789; x=1818828789;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kjblzxMD3U9TYdAopeurdiWKff0BahZi+you8U7hLfo=;
 b=j9BWStLbXIgJihlrHHsJf5JhfSFM1q2ZXR8mWOWx7A49JLCt9/2xDn6v
 F8SSXfsVsdDlFU5MIgFzg00CmEib5CvaR3rvmejNNaiZv0k2MMGbolF3P
 02xBbKiX7LZ0lGFQZ+ohZ5VHQLgc4IYyvzNO1vtl0ICTyeYIxJPvFzhrS
 6xW6FRCQkUNdi7xtwZ6kXxA80ExYyx4R4eIGKuBdS6huv23KcasEeIeLg
 KthpEz3fyN9HmqrFVPtod6odlKV/o0OXgBPU+OzlAPUZPURkJryTrwSnu
 DvW+54s8DRqgjyQuueoW/ZKFo3vCs9GQxDDxUIgT2BPWrWwuWHKsv+umz A==;
X-CSE-ConnectionGUID: GCrFrLnHT5acgbgMbilKlQ==
X-CSE-MsgGUID: aiViwSF9S2OP78Kpuxi2sA==
IronPort-SDR: 6a87ec6d_XidTaF2fgdUiBTgfys/Ip0vrqJmYmlA0gAtzc/kANnOFbO9
 kKk7gmQgUIeZ8ELil8AII9SfO3B4sPCP/JXPBdA==
X-IronPort-AV: E=Sophos;i="6.25,234,1779141600"; d="scan'208";a="48620893"
X-MGA-submission: =?us-ascii?q?MDFFHjn7ohx7FIml/UA9zA2pcD5G9k7kZCodTZ?=
 =?us-ascii?q?xz/SkzIQVpeetwjN7jApXrmXeRkYQGI1FLcbEnNlPO4ml+9/f5M3TAMm?=
 =?us-ascii?q?VsfE1K6azd69hvU+3BO3l1jHQO1QuNB28rWTlTIyAsaXQFq2trEb8Sr3?=
 =?us-ascii?q?EIhY27oFqw31nPLx5YZ2/UEA=3D=3D?=
Received: from mail-westeuropeazon11010053.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.53])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Aug 2026 08:13:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7S13IINmV25hWlqyL9cC3G550ViZp385w+Ku/aCYTSj2UlI/hCqiXnCZp2DkXO3SkqpiUx7R5WE8PzdyWlBTV+BSZhe7Urly9+u3S4E5qRoJvvis2Nf+n0q2ePqX1dZ0WAQNhxBmoWYs0h46qf0zRyV00UnPFbwBoZRo7Ua2yWFLz2OsS8a2H/ZE4dmhaP+3CJGLvzConyNcPhWrFdSLXFG9MmVztlmvhb2zeOW3tgCoB8Q9Ze+3nuRTqe+Wfq8BBwsGgg8NUCtsPOH+y8nXt89PSDwdakWmq6HMMTLXNArhrms1jrdYeLXwY4jjGSVxeGI8EM60+/ptfPqmXAfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjblzxMD3U9TYdAopeurdiWKff0BahZi+you8U7hLfo=;
 b=i6oagtgGUqRtWfD4rsaf10xfgBCtUQVZcwwhhZCqGmIle2ir6NE4IUqqD4qkUaEHwbyDdYDeC9pkgXroYmczqV8kCUt/D93aCvrlp8InRlTqWxIUQIB18XRZEYmhkPAvivdAcjlGLJuRTTxUkFY4bfwrnCPP3TOlP3JM02vq4kmd6xRU+uP/gFk4VcnX80hNz7bNvwStE7p//wmtdW5gyDJmZf6kMgDg/XnruWwPa7ScYHqHYzsni+3kbg5MLZKSK4tMJ0agb6l67tn8gXRlOfKEcKYVQAunYrAKDftFuJqL6by5ZHvaKToZsGGSi+1QQx+dfy8N6rmvTa4zpmQO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB11226.eurprd07.prod.outlook.com (2603:10a6:150:2c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 06:12:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0360.003; Fri, 21 Aug 2026
 06:12:56 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaknO6gra3UQkST2flmIiB+OLaUUwKAgALN34CAAAZzAIADSi+AgAALfQCADWYGAIAAOkKA
Date: Fri, 21 Aug 2026 06:12:55 +0000
Message-ID: <ecedc1b02ec279c36e84377f415730b44f879df8.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
 <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <2d811cf876963acc75673078a869a63fdccdaf06.camel@bull.com>
 <IA3PR11MB9136C8AC130468162F9EE8A992A32@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136C8AC130468162F9EE8A992A32@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB11226:EE_
x-ms-office365-filtering-correlation-id: c555f5e9-8c44-49da-9e6c-08deff4b3de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 7sAvvdTadvozlDuMVB/BdLzp9p5AEnQllhRnS4MOfoIH3arpTzIPriplwG2nk74D1ZOvniy/ubbKBIe/dLRDDg8iA4Xr8IF6SECv9MP9tifrzZJqPAlkjZhuaJpdmfAWcL/m1RKjBJZyXxFT6Y6TDnuS3DIxEUU0HozDn9iXGs1uqD1IfiMklW5mY2K3FNwxvxkA/tlXySfIXbFvnt2Y0+zETiHvdxCQIkJTq/OtdEABP1rbq2yOjhMQXuT1lnW9VQ8wCAf+cGh9leSUjb1ByzkG/QQmD78ybJuuHzlV3hGZsoZYTWBXtJXa/zkudFfKzd75s3md6hOFaIndEmOKWtJB7FkHtens2nQtmnTFTc7QLbA0Gxk0VbHrrZerxhARzpVvPPvF5zgX5B423ryDqIwoKP1Zz5ysT2+9ayS9UsijUYBBrYaA29pG0Hgh0D5zhmgocXN2jiNxAjXed3rI+btrH1I8IvX43/sg2VSxKq1bCytgE+DLaaKe6rrpS6K1zOZPUeGgHfo6PBVOyhyli9zobHlxIHQQJxSpjur0NzgXyAFP5fGzqdHl3PYw4m/pmkAatXM8km+VrdaFDCrmygEVlO+GzFGerbxUY6mK28No2jVml8Ndfu6u67VQRvFOg+c/SO68xqbiWT652ac3kHve7aaOFFmdyqbB/sC9O3QvCOLQdqIcWsrHcDTPMLPD8BBl2gPtkagBmT26Lvl/J0q7uh0dwAl/GMSV9JhCFqg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJNNkdwSE9jRkszUXRWRmhtWnk3ckVyczZ6REV5c3lFcVNGYlgzV2VTWGRK?=
 =?utf-8?B?aHYrNjN2ZWpFaXdtU2dka0Q5Ny91a2ZGTGFWQ1dJckZKRUlnT29UZXlEa0Na?=
 =?utf-8?B?RSsweXNKMW1ENGxtUU5MOVZpUTBLUGxRdHdoVGEzUnBLU2dIT3JWSWRtSUkv?=
 =?utf-8?B?OE9mSDVndERhRGhkU2hSSkd6VThhQ2NidkpIbUw5ZDlNb3FRUDVrYmNmTXND?=
 =?utf-8?B?TTJ2MVZaSE43UUpwNVhFY2gyTFlDSWlmUlMzeVdmSCtGRkZHYkQ2K3hna2Rh?=
 =?utf-8?B?Zk1yOHBuMUVZYW5yRGFHU2VBSzhKOEh4a3FsNVIxcUJIVWw5aTNTblBSbGRF?=
 =?utf-8?B?UE5GNC9xaW9SMWpNdzBqWTd5ZWYxbUs5Ynk1a1J2WFZHZU9kNlRKemdjdHQr?=
 =?utf-8?B?bGhiZEhFZHYxL2k0WVZGNkx3Q1F4MjRQMWNKUnJxVzE1SFNvSnJtREJjVlBS?=
 =?utf-8?B?dDNZYktQWkNKVXhFT3NEN2RTK252WWZkenh3RTFTbitGUDUyZ25TdUpPN0dl?=
 =?utf-8?B?VW81cjBFQXoxeFFVRDBhT0xLaDUxZE8vaitWaTNSWTk4Y29RZ2FaQnhJc2hL?=
 =?utf-8?B?cXJsRGJRVFN0N1phU0tWNXQwdG11SllNOFNnS01yeTJXdkhOZExBZU43ejVM?=
 =?utf-8?B?VjBSMCtWcC84ZFd2M3JKM0o0U3U5YXpERWdtVlQ4SjVFSWliMS91ckkrM1px?=
 =?utf-8?B?MHJ6dEJZNXRIbEkrTlJKNUFJNytOUFM3Z2VqUDdsRkgwZDNkVVpsRmRmUEkv?=
 =?utf-8?B?TkU5WnJjWkk2R0tabUlCTW9JU2dYUzk3bUdrMFkyaHlwNkJjM2VHY0tvdVpy?=
 =?utf-8?B?NGhSSU8vNTVtT09Ba3RiNHB1eHZud3N2WnU1dDFPa2tPTHllemJOd3JkR0FJ?=
 =?utf-8?B?d2RaYTQ0aFd1K2pwTVkvQWpFOC9iL1JCeS9VZzFNd0lhUE1iMFBIcW5MUTZX?=
 =?utf-8?B?ZDl2bk1zWk5Ec01yK3l0aEswQmZqdlNlamc4VjZka2xraEk2MisxSStmQ2pE?=
 =?utf-8?B?a3FhQyt6MmgwS2RJMVhhbHNWTnNFb3RsNEdPeWxXTDYyUmFCNllFaGJiaXAw?=
 =?utf-8?B?ejkza05OTmtUVjNGRG0rdkVmOHJ3NWhqK0VBa0pMZXZ1QVIzNitKZ25KU011?=
 =?utf-8?B?ODNISlEzeHc4TXFZYmkwWHdCcnVsT1Y3bU9WSURtcytSaFI0UmNVUStEdFY5?=
 =?utf-8?B?cmRJdFB5T0xaK1IyaTNsWXJtdjk5T0t3VmNHeXZtNUVqNkZMY2JCNXlQdlF0?=
 =?utf-8?B?Y1BWZEVneUErYkN2clpnZ3R4RTJuc0J2a1BjbGZGUnQyME9Deks0WmgxMXB0?=
 =?utf-8?B?d05xeXdWUjUyaXE4a1JpN0JMN2VySHlTMXlPeVR0a05ibU5TejNrY1RENCt5?=
 =?utf-8?B?djlqRlFRKzFTdGRUbCt5TGorc1dmalFkazBFZ0p0VS9WUjlWZGVPN2dJVEhQ?=
 =?utf-8?B?dUdLTUpzWHh2UUprcjNUR1NLMWxNZjk1RStOSW5mejBvZHM3eGpSVWluaWNZ?=
 =?utf-8?B?eDhCcVRVQ2ZwUzlnSE00NGdBWUd0dGdLTlNYL1NHVlNQTnRKYnhscUJSQmx4?=
 =?utf-8?B?dFp1aUxsc3Bld0VuZ1dxSUIxbFVTR3ZEeFV3REtPMm9vOHIydlVkaEN4cUV4?=
 =?utf-8?B?UEZ2OFJ4Z0FqQWE1SHZHTEY1U09QUUFZWVpMRXg0UElJR1NnUnJKdVY4bkxV?=
 =?utf-8?B?V1RHMWgybFBBZi9oMlRERHpaTnNnbnpIKzZGb2V0SVZmeklDZnpkWFVubVly?=
 =?utf-8?B?dFFCV2ZwSEJHM2I2Z3pERkg2SkpaSHpUTVVZS1RlSFBXTm9rRkR2bUU2S1JR?=
 =?utf-8?B?MDQrc3N3SG10OG11MU5TU0tWZHUrVmJPaTZ2ZjAzeEVhbkVCWjhmelRSVnRI?=
 =?utf-8?B?clh3Y3hVa2RSNmZGWVBjSkd1aHRKSVlCZ0Q3MU52c1BPRnlzZ1FzTXBVY1FW?=
 =?utf-8?B?cFViR25oRFBuMUMxVitSaXBsODA2SG1vdW1JcFlwaUNOQ04vODZWNWV4ZExK?=
 =?utf-8?B?bDd3OXAzMitsY2RSL25VM1dBYlJBMUhibXR0dVVHT0tSOWY5bm9xVkhDUDdh?=
 =?utf-8?B?c1hIanV2bEkvenp4LzlGcEY3dnB0T25TVDk1VkFIL3NCTFlFZ1k1Z2R2TVdY?=
 =?utf-8?B?TUZDYjd6dlRIWi80YnkwY0p0aFZIWWJrQ1Y2ZHdzcDROc0JKQTJ1aFhtczU2?=
 =?utf-8?B?dmlUME9XOVpFdyt6OS9MZEJ2SGdCVUNjYThaRjZoamRhRlNkV0lGOGpOSnpu?=
 =?utf-8?B?YzFMSm5PKyt3RzJDMU94Y2FDWkFWVUR6aUxMd2dvVndlT2ttSTRFRDRkbjc5?=
 =?utf-8?B?ZkVJQVdGRkFGT1gyVmpBNGp5MHh6dXEvdjlxY1d1SjZQT215V1FKdFZvMkNs?=
 =?utf-8?Q?UuYXxJ+9BVGiRlHCzlZ1Etz6XoNvy8/oppV+Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDFF6E32DB26A945AE8702D4D73956D6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n8HUIWXAAyiEA3bOigW52eQ1UEc54gyrPOsIpALgts3wyx2FeIznlA2KBIwakwTTY0oOEmpQBFmTd7lvYJVtLuo2Jy39zHV9L/PFfEvH5gi059dX7+Gu/mtUZppgYPzlKfiYL7MIBA9BFLH3Vl4n9X2d7XGshjQIW6etFPZNE1t0cJ33M+VW8OIS/aiFZuAnUPo1zD7BKuzRqnkMXp/tTQxAcPaox4iR8ISi7vTA+9XStLW+Q240H8EJ2+n6jKf52zxHJIi+exm6vMxsQ0OL1OM95sE1tlsEN7gfIJO9B9rN9EU/5VvnOII4GEwC+zFi7cE/rdzfDbWfszSgCsHPSQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c555f5e9-8c44-49da-9e6c-08deff4b3de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 06:12:55.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waVpkuZ4d8GDrG5RhRpd0kQVgsZkktOGyL4hCHqfT7Aac+i2oRgoMOw8LwMXJsUkVz7VSRgWogaBgxZiD0kNuLcfmlVqzW4b0/0gTYZdt5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11226
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
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

DQpPbiBGcmksIDIwMjYtMDgtMjEgYXQgMDI6NDQgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhpIENsZW1lbnQs
DQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IENsw6lt
ZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0
bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC82XSBpbnRlbF9pb21tdTogRW5hYmxlIFBSUSBzdXBwb3J0IGZvciBwYXNzdGhyb3Vn
aA0KPiA+IGRldmljZQ0KPiA+IA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNi0wOC0xMiBhdCAxMzoy
NiArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiA+IA0KPiA+ID4gQ2F1dGlvbjogRXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxl
c3MgdGhpcyBlbWFpbA0KPiA+IA0KPiA+IGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJv
bTogQ2zDqW1lbnQgTUFUSElFVS0tRFJJRiA8W2NsZW1lbnQubWF0aGlldS0tDQo+ID4gPiANCj4g
PiANCj4gPiBbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZAYnVsbC5jb20pXShtYWlsdG86W2Ns
ZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJp
ZkBidWxsLmNvbSkpPg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgMC82XSBpbnRlbF9pb21tdTogRW5hYmxlIFBSUSBzdXBwb3J0IGZvciBwYXNzdGhyb3VnaA0K
PiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBNb24sIDIwMjYt
MDgtMTAgYXQgMTA6NDkgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiA+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBh
dHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj4gPiA+ID4gDQo+ID4gPiAN
Cj4gPiANCj4gPiBlbWFpbA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBjb21lcyBm
cm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGkgQ2xl
bWVudCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiBGcm9tOiBD
bMOpbWVudCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS0NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBbW2RyaWZAYnVsbC5jb21dKG1h
aWx0bzpkcmlmQGJ1bGwuY29tKV0obWFpbHRvOltkcmlmQGJ1bGwuY29tXShtYWlsdG86ZHJpZkBi
dWxsLmNvbSkpXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tDQo+ID4gPiANCj4gPiANCj4gPiBb
ZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZAYnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQubWF0
aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNv
bSkpKT4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gaW50ZWxfaW9t
bXU6IEVuYWJsZSBQUlEgc3VwcG9ydCBmb3INCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiAN
Cj4gPiANCj4gPiBwYXNzdGhyb3VnaA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gZGV2aWNlDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEhpIFpoZW56
aG9uZywNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSB3aWxsIHJlYWQgdGhpcyBzZXJpZXMg
ZWFybHkgbmV4dCB3ZWVrLg0KPiA+ID4gPiA+ID4gdGhhbmtzIGZvciB0aGUgcmVzcGluIQ0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBidHcsIHJlbGF0ZWQgdG8gdGhpcyB3b3JrOiBoYXZlIGV2
ZXIgc2Vlbg0KPiA+ID4gPiA+ID4gdmZpb19kZXZpY2VfZ2V0X2F3X2JpdHMgcmV0dXJuaW5nIDQ3
IHdoZXJlYXMNCj4gPiA+ID4gPiA+IHRoZSBpb21tdSBzdXBwb3J0cyA0OD8gVGhpcyBsZWFkcyB0
aGUgZm9sbG93aW5nDQo+ID4gPiA+ID4gPiBhdyB0ZXN0IHRvIGZhaWw6DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IGBgYA0KPiA+ID4gPiA+ID4gcmV0ID0gaGlvZGMtPmdldF9jYXAoaGlvZCwg
SE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFMsIGVycnApOw0KPiA+ID4gPiA+ID4gaWYgKHJl
dCA8IDApIHsNCj4gPiA+ID4gPiA+IMKgwqAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiA+ID4gfQ0K
PiA+ID4gPiA+ID4gaWYgKHMtPmF3X2JpdHMgPiByZXQpIHsNCj4gPiA+ID4gPiA+IMKgwqAgZXJy
b3Jfc2V0ZyhlcnJwLCAiYXctYml0cyAlZCA+IGhvc3QgYXctYml0cyAlZCIsIHMtPmF3X2JpdHMs
IHJldCk7DQo+ID4gPiA+ID4gPiDCoMKgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gPiA+IH0NCj4g
PiA+ID4gPiA+IGBgYA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIGdvdCB0aGlzIHdoZW4g
dHJ5aW5nIHRvIG5lc3QgVk1zLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVjZSwgd2hhdCBkZXZp
Y2UgZGlkIHlvdSBwYXNzdGhyb3VnaD8NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gSSB1c2VkIGVkdSBmb3IgdGVzdGluZy4NCj4gPiA+ID4gQW4gSSBoYWQgYXctYml0cz00
OCBvbiBib3RoIHZtcy4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IFJlcHJvZHVjZWQg
dGhlIHNhbWUgd2l0aCBMMShmc3RzPW9uKSBhbmQgTDIoZnN0cz1vZmYpLg0KPiA+IA0KPiA+IA0K
PiA+IE15IGNvbmZpZyBoYXMgZnN0cz1vbiBvbiBib3RoIFZNcy4NCj4gPiBXaGljaCBrZXJuZWwg
YXJlIHlvdSB1c2luZz8NCj4gPiBNaW5lIGlzIFJIRUwxMC4yICg2LjEyLjAtMjExLjcuMy5lbDEw
XzIueDg2XzY0KQ0KPiANCj4gDQo+IEluIHRoZW9yeSB3ZSB3aWxsIG5vdCBydW4gaW50byB0aGF0
IGNoZWNrIGlmIGZzdHM9b24gb24gYm90aCBWTXMsIG9uIG15IGVudiBJIHNlZToNCj4gDQo+ICJx
ZW11LXN5c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDowNC4wLGlvbW11ZmQ9
aW9tbXVmZDA6IHZmaW8gMDAwMDowMDowNC4wOiBGYWlsZWQgdG8gYWxsb2NhdGUgaHdwdDogT3Bl
cmF0aW9uIG5vdCBzdXBwb3J0ZWQiDQo+IA0KPiB3aGljaCBpcyBleHBlY3RlZCBhcyB3ZSB3YW50
IG5lc3Rpbmcgc3VwcG9ydCBpbiBMMSBidXQgaXQgb25seSBzdXBwb3J0cyBmc3RzLg0KDQpPaCB5
ZXAsIEkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCBJJ20gbm90IGF0dGFjaGluZyBpb21tdWZkIGZv
ciB0aGlzIHRlc3QuICANCkkgYWdyZWUgd2l0aCB3aGF0IHlvdSBzYXkgd2hlbiBpb21tdWZkIGlz
IHByZXNlbnQsIGJ1dCB3aXRob3V0IGl0ICh3ZWlyZCBjb25maWcsICANCkkgYWRtaXQsIGJ1dCBp
bnRlcmVzdGluZyBmb3IgdGVzdGluZyksIEkgZ2V0Og0KDQpgYGANCnFlbXUtc3lzdGVtLXg4Nl82
NDogLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwOjAxLjA6IHZmaW8gMDAwMDowMDowMS4wOiBGYWls
ZWQgdG8gc2V0IHZJT01NVTogYXctYml0cyA0OCA+IGhvc3QgYXctYml0cyA0Nw0KYGBgDQoNCkp1
c3Qgd29uZGVyaW5nIHdoeSBzdWNoIGEgMWJpdCBkaWZmZXJlbmNlLiAgDQoNCj4gDQo+IE15IGtl
cm5lbCBpcyA3LjIuMC1yYzYsIFFFTVUgaXMgdjExLjEuMA0KPiANCj4gDQo+IA0KPiA+IA0KPiA+
ID4gDQo+ID4gPiBJdCdzIGV4cGVjdGVkIGZhaWx1cmUgYXMgZmlyc3Qgc3RhZ2UgcGFnZSB0YWJs
ZSBvbmx5IHN1cHBvcnRzIDQ3Yml0IElPVkEgcmFuZ2VzDQo+ID4gPiBhbmQgTDIgd2hpY2ggdXNl
cyBzZWNvbmQgc3RhZ2UgcGFnZSB0YWJsZSBzdXBwb3J0cyA0OGJpdCBJT1ZBIHJhbmdlcywNCj4g
PiA+IHRoYXQncyBub3Qgc3VwcG9ydGVkLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIGRvY3VtZW50
ZWQgaW4gdnRkIHNwZWMgMy42Og0KPiA+ID4gDQo+ID4gPiBTb2Z0d2FyZSB1c2luZyBmaXJzdC1z
dGFnZSB0cmFuc2xhdGlvbiBzdHJ1Y3R1cmVzIHRvIHRyYW5zbGF0ZSBhbiBJTyBWaXJ0dWFsDQo+
ID4gDQo+ID4gQWRkcmVzcyAoSU9WQSkgbXVzdCB1c2UNCj4gPiANCj4gPiA+IGNhbm9uaWNhbCBh
ZGRyZXNzZXMuIEFkZGl0aW9uYWxseSwgc29mdHdhcmUgbXVzdCBsaW1pdCBhZGRyZXNzZXMgdG8g
bGVzcyB0aGFuIHRoZQ0KPiA+IA0KPiA+IG1pbmltdW0gb2YgTUdBVw0KPiA+IA0KPiA+ID4gYW5k
IHRoZSBsb3dlciBjYW5vbmljYWwgYWRkcmVzcyB3aWR0aCBpbXBsaWVkIGJ5IEZTUE0gKGkuZS4s
IDQ3LWJpdCB3aGVuIEZTUE0NCj4gPiANCj4gPiBpcyA0LWxldmVsIGFuZCA1Ni1iaXQNCj4gPiAN
Cj4gPiA+IHdoZW4gRlNQTSBpcyA1LWxldmVsKS4NCj4gPiA+IA0KPiA+ID4gVGhhbmtzDQo+ID4g
PiBaaGVuemhvbmcNCj4gPg0KPiA=

