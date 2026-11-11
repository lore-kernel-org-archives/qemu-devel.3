Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A9606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=selector1 header.b=Ub92lvBh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNS-0007uv-1e; Tue, 10 Nov 2026 22:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1xQzNP-0007uX-C2
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:51:59 -0500
Received: from mail-japaneastazon11011028.outbound.protection.outlook.com
 ([52.101.125.28] helo=TYVP286CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1xQzNL-0006Ue-Gg
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:51:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow3bB+lBt6HzznaaKAMriUTE2vO8sg1yxB9F1MPVq5F8JgDFYcgGmogTCNOFdH6oWEe89I9wRfoO+kl7e+0bipFi4wOq+f9jeWDoVZx0ngbhwo+n2onO/lHzcVJsnub1WknWg6gHmJJVethkJjBPzaiENMpYtghtPE9gdQDotkopgtjHHPWIOFyIea9WzhanFrrgLh1H4faeceButif004XsR99hHVmn/V9KtgWg158p/YHtk1HkJotJNe1oJmQ2G5Ghv+c9zMm7G1lfr7KlCC/zdoClOx5V8rhvpaxrkEYjSgjqnkTjf7U/J/ngMjORSt2Hgrpkb429guGkO6GFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXQo/zNmRLpr1jZbo9rk4PHzokYImqB9MJm13ySVzsc=;
 b=QHYLB6TQ3TvPEdyr2GtQoF3CqXA36rOJtr0DY0UtkWccm4xTUfAyaV6SkJ3Erbo9qb2CWK4UUXKxUqP5c0ZZTt7yA3E6/2qNqqoZaFHaTUVNKKas1hwY6G5CAoq3wojS2gxUqYFaSN87+i18IV9E4V4FCbrInYyq2rs/a6IoFtPJyefsQ9ACJVCuU4m1M8dH3SLMb/3+0WWBJbSO6FDQCqWNVqHtFXYeG2CJckcckwN/pT3oPMMqHwbRP68uGFCW29NpxDm3zy/saseYFD9S9rulrsNM55QDg1sJTYzNUSfgvOZBBsd8dzaH1bLnOcuwBQ7s/unL+y2t2JGEQUSR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXQo/zNmRLpr1jZbo9rk4PHzokYImqB9MJm13ySVzsc=;
 b=Ub92lvBhHd5T5O7JWvWRF3CC8NzxjFbxs7ujVFrAe0c5b7m+yNdEAlQrZtU3N/gUNJnqqjVKoE741rwQUqmbOmutBfyJ780AL8kakQr+1ovrOJUgO5VNXrBl6YEc7jBn1/IxUVkD25s87KOZrmOKhhiyyE/gD+VcIe0A9YgVAXjmGicP9NcLqn4GmiSN2c4V/caaCTN2kdq8nbYo0MTx2puHmlzFjb5k8w0W/Yasq3WwkA4dpMqOtoxygyzHXXpa5IOhvj6b+pPW2g9/cl3lJziGdIb4GccGqqvpFe/MKH5V++C0GDcjtR2Xj2tveCiib2JQOj9Kt7Y4KhnY8Jevjg==
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com (2603:1096:604:2e6::7)
 by OS7PR01MB15130.jpnprd01.prod.outlook.com (2603:1096:604:370::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:46:46 +0000
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131]) by OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 03:46:46 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>, 
 "yanfei.xu@bytedance.com" <yanfei.xu@bytedance.com>
Subject: Re: [RFC PATCH RESEND 00/13] migration/rdma: producer/consumer send
 path
Thread-Topic: [RFC PATCH RESEND 00/13] migration/rdma: producer/consumer send
 path
Thread-Index: AQHdcSSydl4Dr7yV6UWJg12N9MpU2rcoPEAA
Date: Wed, 11 Nov 2026 03:46:45 +0000
Message-ID: <b4a682c3-ba7b-4c6e-83d1-a72f49d6168a@fujitsu.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12148:EE_|OS7PR01MB15130:EE_
x-ms-office365-filtering-correlation-id: 45b0dde9-6ebc-4943-16f5-08df3fa66883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|1580799027|261009221227099003|261009223027099003|3023799007|10067099003|261028144727099003|261026140227099003|261102123227099003|261021123027099003|261021135927099003|261021121427099003|261022075727099003|261026121527099003|261022105027099003|5023799004|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: QJV0aKdEqok9w5VGjwc2BaBeVQK2yARdy2+xMuQ5CXQObRCLWIiuDW9pc1fulnZESpoP4vwEOLwNFFekPOVi7IG9jRgwXT+q4vl4SM2p1sL9UBpWRrqbrl8bHM7UTpNxluI7LQwpam8Lbfqi7YQA7xAPvW5gOlFG4Z+AMXAqRCwthgWZs37HUyCoTfKXJgzihnZzJ2zQaTYAdfrRmDcOY/NrzVGGPKEVZXJaRzC4FELeqSP43fhwp1F45eOK+JJRns7l5F+RUOwwJAQF/KpDo8WBMI70DR9lkPgx0cYABe3/PZjn9Ssvz4yWyHmMF1SxhWIzPCPPE5KM3HMV42kYfItOSEPdEZIojnEqR1gB4fC6QvNestVp+JQTntwrFPsarxyQZmzsR+gBQCZE2NcSCwcdgIUcxbuXTDaL2LlbZAxzrvBBqD/ODV1Qvo3iZ2vM1i4eSKfXjkRf5q6Q3Ncp1NU6vPA5vR0NvUwczRhQ5scnXv+P9Oirnn1TIF3Y9gckLWPI6Nnm3tmNTE8HfbbTMV5RFWBCdIO7Sxeep3dq6FFPMp2A64TlhlmgpJoMQBFGDH3pDqyxHVapIcftllQ2ydJi4l+b7fymXscH/siVJjpFEXyZ7xkCoqIgz1DXuD7CcNCJW0y3GOGzov1LRPmzkDCrZX5VZy4f5jFAxhfNy+6qmHwaNjE+mDrp3tzDJQWdoou1ZH/rD+OnfQj5iDGsoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS9PR01MB12148.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(1580799027)(261009221227099003)(261009223027099003)(3023799007)(10067099003)(261028144727099003)(261026140227099003)(261102123227099003)(261021123027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261026121527099003)(261022105027099003)(5023799004)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2xuWTR5V0Noa1pyWnhISnVWWXJmSEpaTXBpUkh3enZHOWdCN1VVejlEc0hr?=
 =?utf-8?B?bEJKZTljcTNPV3hnS3BqMVdFQVRwQ2Nla3ZNMk5CenQzRnlvL1JySVQ0bUY5?=
 =?utf-8?B?YktYSUxLVFVlMFJjSG14dG9MMU9BdktHeTJ5ckZBbDhlSGpqL29tTWtuMnAr?=
 =?utf-8?B?UW9rWkk0eDR3QjRMRzNjc1J6MUpLZWJTQWJVdTV0bG5TWWlmTjNraHo2S0NJ?=
 =?utf-8?B?WU9DVElISHlva1pCVUl3eFlDa1QyY0gwUktTKzUxRkFIWmhQQlM2RjBDblRM?=
 =?utf-8?B?WGFoNzduZjZpNjZWUjNqQVJJeFBldFc3bHdFM1RXME53WUtLSk1jZXNGRDUy?=
 =?utf-8?B?OXdDYitlSVVUN0pYNTRqUmpyVys1ZjkyblhhOVVhdExhT2I3WWVHeTgreDB5?=
 =?utf-8?B?MmwrSE02dVZOTnpjT3YydzNmS2FmM2paeHJ0Q3Z3Qy8reXpnWjNXaDR1Q0pD?=
 =?utf-8?B?M3R6am52MEhMMjFMTWpkU3RMQllMRDFEK0dPYTMzN0IvTjdtcjEvTXc1Mnd5?=
 =?utf-8?B?Q2hMcFd3R0tQR0RINjdCSnVlaXFrSWJaYTZ1Tk9UZXllamVPN3gxelRNNUJZ?=
 =?utf-8?B?bTJjSEFUNXUvd08wN3prRC85S1dFS1RrNWhnNWRIV2YvcUx0L2V2WktCTGRD?=
 =?utf-8?B?N3ZGOVVISkRjL21vWExhekNEb0NxSEJJbExSM2F4NjN5SjBLTWJOYkxuUHlD?=
 =?utf-8?B?eDhXR3IrNW9HSXJ3MTQ1NUhtTHZWLzNPWXVzQWl1eGhMTjlvMUFUckNFZ0or?=
 =?utf-8?B?L0dDaXBGRnRkSnJ0QnpJakU2U0wzbWs3TW4xM0YyTitZU2dnOGJSU05sd1NB?=
 =?utf-8?B?eCtEVFdDUWNFL3BkM001eUxuT29Yak12bmgwTFpJNWxSNGhrQlpNWVFmS0tB?=
 =?utf-8?B?WDA2NnFCOG9PSmE0QThka2xEUGFqR2R6SzZsbGR4V1Rzc2VuNVJScWRMZTQw?=
 =?utf-8?B?cDkyS01UWnhseGp4SHdIWXdZcmZkRWx3R3NpL3dENDNwVkZNRmpBQXdNeVNK?=
 =?utf-8?B?SjlWbGJvc3VFUHpaeTN5WGZlNnNJRHRLME9FS25qWWw2TXZabDdyRmdXTlg0?=
 =?utf-8?B?OE05MktqVXRBNTBTY0Y4allwckkrVit6aGViMXc2L1FCMEdTTGc5SjBvRlJT?=
 =?utf-8?B?ZDZmN3R0ZGczTFNxT0t6TnJXYUVka1Jyb1ZpRW1OVVNJWVNkNlFnSWJaVmNY?=
 =?utf-8?B?SEpYT0FpOGIrb2dvVm1Mc1Z4RHJXemRieUdEeHMvbEl3RCtzMFc4WEJhSHNm?=
 =?utf-8?B?WS9xeGRGUi9qSmlRcFJIemEwZlFZRndTNXZSUzEzZndiVHMwTVVWSmorN0hs?=
 =?utf-8?B?eUpCQmRvYlpIVFV0YXRUZ0RNUUJrbTkzdGJ3VkR6aWZTckVKUDdHemJTL3VZ?=
 =?utf-8?B?VDFUOUFaZEc2ajg0SzFRa1lFa2xBRU9xSmpGUmN1NlZCZEJRZTFOUWhlSmxq?=
 =?utf-8?B?RjNmU3NYcmo3S0s0Ry9XTm1mVkFQSFJoL0ptQnF3b2orODBqUFRpZ292RVQy?=
 =?utf-8?B?TDBONWZhVGp6VFlLTlE1Z3dwRFBYSzJteTNrRDExbWxYSGV2OFkzN3FLeHBL?=
 =?utf-8?B?cUI1N0dyZkNFSU9RK21lWnB1Yy9BRFdzK0pHenFqbXFwdWIxOHlHL1g1OEN6?=
 =?utf-8?B?YWx2bVZtVDhNdk11N01GSGttRHBybllFeDFWWWVDb2J1Y2ZUdUt3Yld2QnlU?=
 =?utf-8?B?a3YvRHhaNlh1aVhkU0ZINitVd2dkUThwV0lZRmEvdzNXc2pJeXA1ZGdmZlF3?=
 =?utf-8?B?dmRGcGpZVUN0SzhRaWRIakoyZmw1NldzUnBEa2ljenRSYzNCRGhzc0NEU2ll?=
 =?utf-8?B?dkVHWEtmZkl3N0J3dDhDaUJLa2dydUcrek1FUmF4WmxlUk9kS0N0bmNjMngx?=
 =?utf-8?B?L1JkdzlxR0cyYkZyb3d6UXBnaCtCY2RnZm1pTHVMZEJnQ3ljNkZ2cDVOMS9G?=
 =?utf-8?B?bUZQdHloaVB1T2QrbFVYc1RmNDRkUlRHZDRWTnBSb0kvUjNMUHd3WWY1ckNh?=
 =?utf-8?B?WCt4SmJaeGVvdzExVkFNSUgrWERvbm1jLzhJaHJHd1A0WWVVMUNMcVB3YUR4?=
 =?utf-8?B?YzFiRDR3NjVXd2FDa1lCMUMwUDJFMnRsVzM5UnlJcm5hd01Yci9CcmdUWkhV?=
 =?utf-8?B?VGhFSk15WktPaEtTTHNaemptN1RrUWJndm5qQWRJa0dNWkZGb1lKUDRFamRl?=
 =?utf-8?B?dXEra082SktlMTNoV0FvZHhxUCsyT28xaWNhNnhnWTNWMEV0SjRZV3gwdVBj?=
 =?utf-8?B?WTJWczRVN0wzRDVtRTkwSzZYK1NYdUQ1MU9mandrSVNGYk9sSHlMaVVhcGhC?=
 =?utf-8?B?UXQ4NlRtUVhmdzdsR2dBQnV5TEZnK09QT0ZMOUg0ZmtUdFcxa29jQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C091D3A3736434383F2DB130E532A71@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nTUiyCXvrgGlpU+ABiqx46BTYDY7ohniJG+RcIPlAw+s6ViiE8XbXcQDmBThQ+0jtifq8W5RDGyJKT01IYTaaAsEtLZe+3cHnQI5RcNohQWfDnPpGELwV1nYOVrl1DluqlInMsrPApvI8ew65HyM/1ezJZAQNwbNxX6GJeCHKD/8ngiDq21psPvWVZVQXPZZ2SHKC/MNcpIr+J8Jle7lgyVe0PHSkbViRG5xhbZfUdfemMaFybl8lO4wWh6HCs2CFXiX57Su8rtOw6yHtzHH1SocYGXuXxBq8CKtGubwNqEwne7X7+4OTdaewHc9KH6Js0Wlv6RMXxa/BlN2dA+iuw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12148.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b0dde9-6ebc-4943-16f5-08df3fa66883
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:46:45.9486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+rfJjkppS+HGjcrh4SELNHSFx7iLf6czEhhKOJCAViTYb18NEEjKbKZFYJr5MpSDdiQby+GRoRJQtKQcDX70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15130
Received-SPF: pass client-ip=52.101.125.28; envelope-from=lizhijian@fujitsu.com;
 helo=TYVP286CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RG1pdHJpaSwNCg0KDQpXaXRoIHRoZSBoZWxwIG9mIEdQVC01LjYgTHVuYSwgSSBoYXZlIHJldmll
d2VkIHRoaXMgc2VyaWVzLg0KDQoNCk92ZXJhbGwsIHRoaXMgaXMgYSB3ZWxsLW1vdGl2YXRlZCBh
bmQgdXNlZnVsIHNlcmllcy4NCg0KVGhlIHByb2R1Y2VyL2NvbnN1bWVyIHNwbGl0IGFkZHJlc3Nl
cyBhIHJlYWwgbGltaXRhdGlvbiBpbiB0aGUgY3VycmVudCBSRE1BDQptaWdyYXRpb24gcGF0aDog
ZGlydHktcGFnZSBzY2FubmluZywgUkRNQSBwb3N0aW5nLCByZWdpc3RyYXRpb24sIGFuZA0KY29t
cGxldGlvbiBwb2xsaW5nIGFyZSBjdXJyZW50bHkgc2VyaWFsaXplZCBpbiB0aGUgbWlncmF0aW9u
IHRocmVhZC4gTW92aW5nDQpRUCBvd25lcnNoaXAgYW5kIENRIHByb2Nlc3NpbmcgdG8gYSBkZWRp
Y2F0ZWQgY29uc3VtZXIgdGhyZWFkIHNob3VsZCBhbGxvdw0KZGlydHktcGFnZSBzY2FubmluZyBh
bmQgUkRNQSB0cmFuc21pc3Npb24gdG8gb3ZlcmxhcC4NCg0KVGhlIHdpcmUgcHJvdG9jb2wgY29t
cGF0aWJpbGl0eSBpcyBhbHNvIGhhbmRsZWQgYXBwcm9wcmlhdGVseS4gSW4NCnBhcnRpY3VsYXIs
IGJhdGNoZWQgcmVnaXN0cmF0aW9uIGlzIGNhcGFiaWxpdHktbmVnb3RpYXRlZCwgYW5kIHRoZSBz
b3VyY2UNCmZhbGxzIGJhY2sgdG8gb25lIHJlZ2lzdHJhdGlvbiByZXF1ZXN0IHBlciBjaHVuayB3
aGVuIGNvbW11bmljYXRpbmcgd2l0aCBhbg0Kb2xkZXIgZGVzdGluYXRpb24uIFRoZSByaW5nIGJh
cnJpZXJzIHByZXNlcnZlIG9yZGVyaW5nIGZvciBSQU0tcm91bmQgZmx1c2hlcywNCmNvbnRyb2wt
Y2hhbm5lbCBtZXNzYWdlcywgcmVnaXN0cmF0aW9uIHN0b3BzLCBhbmQgZmluYWwgY2xlYW51cC4N
Cg0KSSB0ZXN0ZWQgdGhlIGNvbXBsZXRlIHNlcmllcyBvbiBpdHMgZGVjbGFyZWQgYmFzZS4gVGhl
IFFFTVUgYnVpbGQgYW5kDQpnaXQgZGlmZiAtLWNoZWNrIHBhc3NlZCwgYW5kIGJvdGggZXhpc3Rp
bmcgUkRNQSBwcmVjb3B5IHRlc3RzIHBhc3NlZDoNCg0KICAgL3g4Nl82NC9taWdyYXRpb24vcHJl
Y29weS9yZG1hL3BsYWluDQogICAveDg2XzY0L21pZ3JhdGlvbi9wcmVjb3B5L3JkbWEvcGxhaW4v
aXB2Ng0KDQpJIGFsc28gbG9jYWxseSBleGVyY2lzZWQgaW5qZWN0ZWQgZXJyb3JzIGR1cmluZyB0
aGUgbWlncmF0aW9uLg0KVGhlIHNvdXJjZSBRRU1VIHJlbWFpbmVkIFFNUC1yZXNwb25zaXZlIGFm
dGVyIGluamVjdGVkIG1pZ3JhdGlvbiBmYWlsdXJlcywNCmFuZCB0aGUgbWlncmF0aW9uIGZhaWx1
cmUgYW5kIGNhbmNlbGxhdGlvbiBwYXRocyBjb21wbGV0ZWQgYXMgZXhwZWN0ZWQuDQoNCi0gY29u
c3VtZXIgd3JpdGUgZmFpbHVyZTsNCi0gcmVnaXN0cmF0aW9uIGZhaWx1cmU7DQotIHByb2R1Y2Vy
IGJhY2twcmVzc3VyZSB3aXRoIGEgZnVsbCByaW5nOw0KLSBjYW5jZWxsYXRpb24gd2hpbGUgYSBi
YXJyaWVyIHdhcyBkZWxheWVkOw0KLSByZXBlYXRlZCBlcnJvci9jbGVhbnVwIGl0ZXJhdGlvbnM7
DQotIHJpbmcgYW5kIGJhcnJpZXIgc2VxdWVuY2UgY291bnRlcnMgY3Jvc3NpbmcgVUlOVF9NQVgu
DQoNClRoZSBvdmVyYWxsIGRlc2lnbiBhbmQgcGVyZm9ybWFuY2UgbW90aXZhdGlvbiBsb29rIGdv
b2QgdG8gbWUuDQoNCkZvciB0aGUgd2hvbGUgc2VyaWVzDQoNCkFja2VkLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCkhvd2V2ZXIsIHdpdGggdGhlIGhlbHAgb2YgR1BU
LTUuNiBMdW5hLCBJIGZvdW5kIG9uZSBjb25jdXJyZW5jeSBpc3N1ZSBpbg0KcGF0Y2ggNC8xMyB0
aGF0IHNob3VsZCBiZSBhZGRyZXNzZWQgYmVmb3JlIHRoZSBzZXJpZXMgaXMgbWVyZ2VkLiBPdGhl
ciB0aGFuDQp0aGF0LCB0aGUgc2VyaWVzIGlzIGRlZmluaXRlbHkgbW92aW5nIGluIHRoZSByaWdo
dCBkaXJlY3Rpb24uDQoNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQpPbiAxMC8xMS8yMDI2IDIz
OjAyLCBEbWl0cmlpIE9tZWxjaGVua28gd3JvdGU6DQo+IFRoaXMgaXMgYSByZWJhc2Ugd2l0aCBu
byBjb2RlIGNoYW5nZXM7IHRoZSBwcmVyZXF1aXNpdGVzIChZYW5mZWkgWHUncw0KPiB0d28gUkRN
QSBzZXJpZXMpIHdlcmUgbWVyZ2VkIGluIG1pZ3JhdGlvbi0yMDI2MDkyNS1wdWxsLXJlcXVlc3Qu
DQo+IA0KPiB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkyNTE1
NTE0OS44NDM4NzAtMS1kbWl0cmlpLm9tZWxjaGVua29AY2xvdWQuaW9ub3MuY29tLw0KPiANCj4g
VGhpcyBzZXJpZXMgc3BsaXRzIHRoZSBSRE1BIGxpdmUtbWlncmF0aW9uIHNlbmQgcGF0aCBpbnRv
IHR3byB0aHJlYWRzOg0KPiANCj4gICAgLSBhIHByb2R1Y2VyIHRocmVhZCAodGhlIG1pZ3JhdGlv
biB0aHJlYWQpIHRoYXQgc2NhbnMgZGlydHkgcGFnZXMgYW5kDQo+ICAgICAgcmVjb3JkcyB3aGlj
aCBjaHVua3MgbXVzdCBiZSBtaWdyYXRlZCwgcHVzaGluZyBjaHVuayBkZXNjcmlwdG9ycw0KPiAg
ICAgIChibG9jayArIGNodW5rIGluZGV4ICsgZGlydHkgYnl0ZSBzcGFuKSBvbnRvIGEgbG9jay1m
cmVlIFNQU0MgcmluZzsNCj4gICAgICBhbmQNCj4gICAgLSBhIGNvbnN1bWVyIHRocmVhZCB0aGF0
IG93bnMgdGhlIFJETUEgcXVldWUgcGFpcjogaXQgZHJhaW5zIHRoZSByaW5nLA0KPiAgICAgIHBv
c3RzIHRoZSBSRE1BIHdyaXRlcyBhbmQgY29udHJvbCBtZXNzYWdlcywgaGFuZGxlcyBjaHVuaw0K
PiAgICAgIHJlZ2lzdHJhdGlvbiBhbmQgYmFycmllcnMsIGFuZCBwb2xscyB0aGUgY29tcGxldGlv
biBxdWV1ZS4NCj4gDQo+IENodW5rLWdyYW51bGFyIGRlc2NyaXB0b3JzIG9uIHRoZSByaW5nIHJl
cGxhY2UgdGhlIHByZXZpb3VzIHBlci1wYWdlDQo+IG1lcmdlIGxvZ2ljIG9uIHRoZSBtaWdyYXRp
b24gdGhyZWFkLg0KPiANCj4gUGF0Y2hlcyAxLTEyIGFyZSB0aGUgcHJvZHVjZXIvY29uc3VtZXIg
c3BsaXQuICBQYXRjaCAxMyAoSmFjayBXYW5nKQ0KPiBuZWdvdGlhdGVzIHRoZSBiYXRjaGVkIGNo
dW5rIHJlZ2lzdHJhdGlvbiBjYXBhYmlsaXR5IHNvIGEgcGVlciB0aGF0DQo+IGxhY2tzIGl0IGZh
bGxzIGJhY2sgdG8gb25lIGNodW5rIHBlciByZXF1ZXN0Lg0KPiANCj4gUmVzdWx0cw0KPiAtLS0t
LS0tDQo+IDY0IEdpQiBndWVzdCwgc2luZ2xlLXBhdGggUkRNQSwgbWVtbG9hZCB3b3JrbG9hZCAo
b25lLXRpbWUgUkFNIGZpbGwsDQo+IGZpeGVkIGRpcnR5IHNldCkuICAiYmVmb3JlIiBpcyB0aGUg
c2luZ2xlLXRocmVhZCBzZW5kIHBhdGggd2l0aA0KPiBvbmx5IHRoZSBuYl9zZW50LXN0YXRzIHBh
dGNoIChwYXRjaCAxKSBhcHBsaWVkOyAiYWZ0ZXIiIGlzIHRoZSBmdWxsDQo+IHByb2R1Y2VyL2Nv
bnN1bWVyIHNlcmllcywgc28gdGhlIGRlbHRhIGlzb2xhdGVzIHRoZSBzcGxpdCBpdHNlbGYuDQo+
IA0KPiBwaW5fYWxsPW9mZjoNCj4gICAgLSB0b3RhbCBtaWdyYXRpb24gdGltZTogLTE2LjIlICgy
NCBHaUIgZmlsbCksIC0xNC4yJSAoNjAgR2lCIGZpbGwpDQo+ICAgIC0gdHJhbnNmZXItcGhhc2Ug
dGltZTogIC0xNi4zJSAoMjQgR2lCIGZpbGwpLCAtMTQuMiUgKDYwIEdpQiBmaWxsKQ0KPiAgICAt
IFJBTSB0aHJvdWdocHV0OiAgICAgICArMTcuMiUgKDI0IEdpQiBmaWxsKSwgKzE2LjYlICg2MCBH
aUIgZmlsbCkNCj4gICAgLSBndWVzdCBkb3dudGltZTogICAgICAgLTU1LjMlICgyNCBHaUIgZmls
bCksIC0yMy4xJSAoNjAgR2lCIGZpbGwpDQo+IA0KPiBwaW5fYWxsPW9uICh3aG9sZS1SQU0gcmVn
aXN0cmF0aW9uIGF0IHNldHVwIGlzIHVuY2hhbmdlZCBhbmQgZG9taW5hdGVzDQo+IHRvdGFsIHRp
bWUsIHNvIHRoZSBzcGxpdCBzaG93cyBtYWlubHkgaW4gdGhlIHRyYW5zZmVyIHBoYXNlKToNCj4g
ICAgLSB0b3RhbCBtaWdyYXRpb24gdGltZTogLTUuMCUNCj4gICAgLSB0cmFuc2Zlci1waGFzZSB0
aW1lOiAgLTEwLjklDQo+ICAgIC0gdHJhbnNmZXIgc3BlZWQ6ICAgICAgICsxMi45JQ0KPiAgICAt
IGd1ZXN0IGRvd250aW1lOiAgICAgICAtMS41JQ0KPiANCj4gUVAgc2F0dXJhdGlvbiB3YXMgbWVh
c3VyZWQgd2l0aCB0aGUgbmV3IG5iX3NlbnQgc2VuZC1xdWV1ZSBjb3VudGVyOg0KPiBzZW5kLXF1
ZXVlICJkcmFpbiB0byB6ZXJvIiBldmVudHMgKHF1ZXVlIHN0YXJ2ZWQgZW1wdHkpIGZlbGwgYnkg
fjk5JSBpbg0KPiB0aGUgdHJhbnNmZXItYm91bmQgcGluX2FsbD1vZmYgY2FzZXMgKDI0IEdpQjog
MjY2MDkgLT4gMjc2OyA2MCBHaUI6DQo+IDYzNzcxIC0+IDY0MSksIHdoaWxlICJmdWxsLXF1ZXVl
IiBoaXRzIHJvc2UuDQo+IA0KPiBUaGlzIGlzIHRoZSBmaXJzdCBzdGVwIHRvd2FyZCBSRE1BIG11
bHRpcGF0aCBtaWdyYXRpb24uDQo+IA0KPiBEbWl0cmlpIE9tZWxjaGVua28gKDEyKToNCj4gICAg
bWlncmF0aW9uL3JkbWE6IEFkZCBuYl9zZW50IHNlbmQtcXVldWUtZGVwdGggc3RhdHMNCj4gICAg
bWlncmF0aW9uL3JkbWE6IEFkZCBwcm9kdWNlci9jb25zdW1lciBzZW5kLXJpbmcgdHlwZXMNCj4g
ICAgbWlncmF0aW9uL3JkbWE6IEFkZCBzZW5kLXJpbmcgbGlmZWN5Y2xlIChubyBjb25zdW1lciB0
aHJlYWQgeWV0KQ0KPiAgICBtaWdyYXRpb24vcmRtYTogQWRkIHRoZSBzZW5kIGNvbnN1bWVyIHRo
cmVhZCAoZHJhaW4gb25seSkNCj4gICAgbWlncmF0aW9uL3JkbWE6IEhhbmRsZSB3cml0ZS9mbHVz
aC9yZWctc3RvcCBvbiB0aGUgY29uc3VtZXINCj4gICAgbWlncmF0aW9uL3JkbWE6IEV4dHJhY3Qg
cWVtdV9yZG1hX3dyaXRlX2ZpbGUoKSBhbmQgZGlzcGF0Y2ggRklMRQ0KPiAgICBtaWdyYXRpb24v
cmRtYTogU3dpdGNoIHRoZSBwcm9kdWNlciBvbnRvIHRoZSBzZW5kIHJpbmcNCj4gICAgbWlncmF0
aW9uL3JkbWE6IEFkZCBwcm9kdWNlci9jb25zdW1lciB0dW5pbmcgaW5zdHJ1bWVudGF0aW9uDQo+
ICAgIG1pZ3JhdGlvbi9yZG1hOiBkcmFpbiB0aGUgc2VuZCByaW5nIGluIGJhdGNoZXMNCj4gICAg
bWlncmF0aW9uL3JkbWE6IHNpemUgcmVnX3Jlc3AubGVuIGJ5IHRoZSByZWdpc3RlciByZXF1ZXN0
IGNvdW50DQo+ICAgIG1pZ3JhdGlvbi9yZG1hOiBiYXRjaCBjaHVuayByZWdpc3RyYXRpb24gaW4g
b25lIHJvdW5kLXRyaXANCj4gICAgbWlncmF0aW9uL3JkbWE6IHRyYWNlIGJhdGNoaW5nIGFuZCBy
ZWdpc3RlciBydW5zDQo+IA0KPiBKYWNrIFdhbmcgKDEpOg0KPiAgICBtaWdyYXRpb24vcmRtYTog
bmVnb3RpYXRlIGJhdGNoZWQgY2h1bmsgcmVnaXN0cmF0aW9uDQo+IA0KPiAgIG1pZ3JhdGlvbi9y
ZG1hLmMgICAgICAgfCAxMjc1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4gICBtaWdyYXRpb24vdHJhY2UtZXZlbnRzIHwgICAxOCArDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA5NTYgaW5zZXJ0aW9ucygrKSwgMzM3IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2Ut
Y29tbWl0OiA3MWYyNWM3NTQxN2QzMWMyMTRiYTJjZDI2YjI3M2MxMTRmYzk5OTg3DQo=

