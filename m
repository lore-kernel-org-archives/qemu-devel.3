Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F68CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQnT-00057G-5w; Mon, 27 Oct 2025 13:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDQnQ-00055y-LX; Mon, 27 Oct 2025 13:14:16 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDQnF-0003ZA-4w; Mon, 27 Oct 2025 13:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJJhXLpqi6m3de54MhsoTA0yIZjVl1wzFNUYgiuFuHF9DzsSZxoU6bAEB3jJnmv3ihKo/yNCEv0LuDcJolH5xMPr2x5WrL1buAOv+oI0Vd0vPHhyUtr2roeh+iu0p0tBKplqShnTcDAEl3hytt68+YN3bWSi448GrfzAckzgllwSh3d/2xzTZRwHSR5mqejCYRGU0jp00ad9rEEKDKFPx/dUfohHiv6Qdzc3puFZ4zEqVMTEXd7D8RXFpJgvgUkrdtYEafsFc5XagQBDiV+e8sx4Q7bD8aVbvqAE3rU71poYKWMIW/hq5cN7vMg6iluAdrPkC1q2315KrfzvOyMyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFF70OCJ6Onk05A0c1AJ+7K2eMHWNPTVTpokY3OaNBs=;
 b=vRHAJFnmshoYXt066ZbbdL/uqdNITsBDc7mt9xBpq/eFfQlCsD6ShfXG46901oKWe0UGAUIA9Ki7dHHYDL62EvIVrxjEO9W5KGOx6aRBpckhJKuBDjCrkUZyI6I0vPVf2JB0c+4cwF5WQl/bvxPnoOmxgoEnOerYiqPrQpaHYmCZz9zh6vYDpWwYlwKWhkX0eCkrTy3gZ1shjJVOa83tUgJKcVl3xMQ0zDJv2GsKSVQkAi2yzNO5gCtuCtBayVFqNaKWiWkjPMYrKalDMw09hiMmuBFt21rWdJ3huWymAodQ4lJJYWjQQmW189Ns5RpvGIGXENihB2yQFjlItWXAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFF70OCJ6Onk05A0c1AJ+7K2eMHWNPTVTpokY3OaNBs=;
 b=ng472Z62+w4USVkUs93hk0nIr1UvLfwvM/ms0ipwPW8jPfDUL6PZHLY49o157zvikzakwcK5w2yEwf7c3Fe0VWZzKCfUC+MRaODZmcrDKVSsDjHfLWU9D47I19PxU8ELD16pQSZaiIlMIfM1/LyBh1YuvWJVOLNFShx/jPxACdpZ1Ggj1qMTlQKEBekifnRKzdZK2qVxszdBJwtAdNCBjhCsBTpqya27gxIvL4+z2dU6yBxbVbvzuOEl3kKOXJJoCKqqs/UPhr5zojXaP0cZNCEqbr3/zRul9jXjtilHpZWWAckjVstmpqCPz6O8A7oj8l+8EeFWPd0QJkGjPKLglA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:13:54 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 17:13:53 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Topic: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Index: AQHcR2MFngFyUDoiY02aRyWaAGA96rTWObMQ
Date: Mon, 27 Oct 2025 17:13:53 +0000
Message-ID: <CH3PR12MB75488D2E92A5787747BF9AE9ABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
In-Reply-To: <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH8PR12MB7279:EE_
x-ms-office365-filtering-correlation-id: 22c26545-520d-486e-2d93-08de157c34c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UmJFRkpwVUEzSHc4bzVhRU1HcmFIM3hTQWtHb0pnK1ZCU2VUOXN6Mis4L3hn?=
 =?utf-8?B?Snc3bG0xYmhad0w3QnljbWdXMlgxMnNkamNYSmtlUUQyQ0JqbTEvYm1VK3hL?=
 =?utf-8?B?bkNmdmJ4OGFDMGd1c2pmay9JOTQ0ZkhCQ205VHI0b2tGL0ZETjdJZGxMMEJv?=
 =?utf-8?B?L2ZBdmExaEdWbk9qTmRtNXhUWFg1eDluUVJWZzVBYWVXUXJHYmJJcE42WmVm?=
 =?utf-8?B?UDN5OXRqVkpYSzYyRTRHTUhCSklCMnNXUW9LWHJaRXhrak9weHp2YkJBTWR1?=
 =?utf-8?B?bGgybDlhK0xpSnQyVnM4YjlieGlWa1h0RHYxZGdMeWJ6M1NtNUw4R2RrM2lU?=
 =?utf-8?B?QnB2YnNCanNNVU9xWngyTmdIUkFDQzNKaEZYOWl1T05SUThqN1h3RjRPU09z?=
 =?utf-8?B?dEowYXd0NVBYYlVwMGVQZEtSS1BLYVg4Q0trSUlybExRZTFGclRRMGRWdzE5?=
 =?utf-8?B?VmhxOHBvV0tmZlVPZUltL08wM01JV2NKdEc5UGg5NWZuVy9xVmNqNVovRW9M?=
 =?utf-8?B?OGVjYTEzczExZko0VDBxZ05DS0d1dUQ3WUJ2Uzh4NzJLTHdzbUZHdFdLQm9F?=
 =?utf-8?B?R05pRkVhbkxDQmdwcFJwVXlaeWtmMTNoRGlsV1ZycHV1NndUMWVpR1ZrT1dI?=
 =?utf-8?B?SU1tTjlHd1NDYjFJL2ZUYW1KR1plZittMXVRMDlsRmV0MTNac1VSTktEMUls?=
 =?utf-8?B?YzhtSkpKYTZFVUZnU3Y1bXhlL1hINWVRUXVRQlJEVmxyOUdmeE9jMG5GckdK?=
 =?utf-8?B?dVYzMlh1NmVmazZaZlIrd2YvWTZMSTluNlJnNnZ1UUoyN3RpODBDMElvY1Z3?=
 =?utf-8?B?V1lrRUFhUGN0aEN2Q1RUc0FhUXQ2b3h2ZVd6NThEcFo5RHZvbHpLZWErMzRZ?=
 =?utf-8?B?QWlKYWZyTndadFFMU3hSNUczRmI3T0c2dXhMZWxqNUhvTzJjZUIwL3Y0bkFJ?=
 =?utf-8?B?M2xXeEVUc2pUczVSVlpudWswSERnOEhGdkJqanNNazhlMW5Vd3Y2SXUvMVpS?=
 =?utf-8?B?RE9KeWFiVGYwNHozaG01OUI5ZmVWZWZnL1BwNmFsbTRFMlRLb3BDdU5uZlpN?=
 =?utf-8?B?Sm8zd1JZWTVYQVhxSGgxQkZndnlDdDZjMG5wMFIzQ0xzQWlJeG9sRHN6dTB3?=
 =?utf-8?B?Y2tGZnUvRElGc1gvUy9DTlBZMU81SmN3VGtkZVZjMmswZ05OODBXR2c1ekRY?=
 =?utf-8?B?WDBMRjJHN3BjTytqWEFtVTB6TlFtdU5yaERYd2tIaFNZV0dRaFNMTWpsdFdJ?=
 =?utf-8?B?WnVlaThsZS9YNXNWTURLdHQzS3RqNVMrZmFROXBhSE9zdFR0cXMwUU1DTThP?=
 =?utf-8?B?MjJvcXZ6YnVkSlJqVFRRb0h3R1JsbWNjSWJiMkk5OG5OczM4REovNmtrc2R6?=
 =?utf-8?B?c3dZM1dOT3NrdzBmbVdkT3ozWkZxUDVQaUZGMytHMmxUWkF0WkdhL0l0dkZh?=
 =?utf-8?B?Y0RLU0FaRkJ6V0grdWtNNXR2UUFUZnJqdFdjQ2IvNERIaWNVMHozdlBVRFpQ?=
 =?utf-8?B?WGh0TVBER01tSktscjl1Yk1waU0vWGdVeU02ZUhpYlEzajA3c2pjZG5JcklJ?=
 =?utf-8?B?cmtkY1l2cDBlamZpdm5NeE1COE5aZ2RTN2NwU2lCTjdVOWZ4ZGtSYWJnRm1F?=
 =?utf-8?B?YXhDUUlpaVZXbnFyUnUxMjZHbENvOUJ2TWdFTnlnSDJ4bkcrTFdUY3lpWlZa?=
 =?utf-8?B?Mm5QV2dDRWx4NmNrckZMcCtBMDN5NTVoUCtnUFlhTkJWNFpFczBkbmZSV0Jt?=
 =?utf-8?B?RTIxdlpIRVVhMndFbENOYytCR3ZLYlhDZDB3d2tBUFB0VXM3NlpDbTJzNWhz?=
 =?utf-8?B?RTgybTBPWlE4UytKSGRyZU1sM2NZQnlObGJkbUtTTEY5d1BZZXphbFl2eURz?=
 =?utf-8?B?QjJsY2NrZ0pnMWxYOW9JeHNaYlRJbS9EU1lpZ1VWVW1aa0dOK1J3cmZaRU4r?=
 =?utf-8?B?bDFadEdQdUhtZnJFV2NuYVNjdW50cGgzL2ZGa040U2ZjaVdFdWJFV2oyUzBz?=
 =?utf-8?B?ejBWdk5oT0lBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUs3SGVXa1JJVFMvSGVkMkRxWDEzeDJ5Z2lyMS9LWWc0RzlIcHBld1V4ZUNN?=
 =?utf-8?B?TXo4dTRwaE5XZU9ZY2RGTWh5OVE4OUNZZTYvNjIvY2pXem5zOXMrN2I2U1Vz?=
 =?utf-8?B?eWhPcm9adngyU2xSekw1eDhTWWZhMmZDMFZVdFh6S2tybEtUR3o2clJEUUda?=
 =?utf-8?B?NUI0UFVSOSs0OU9wdkhuTXoxSDZvM1FQMG1MSGc5bDkxdmtLL3MwUEk5ZzRk?=
 =?utf-8?B?MFQxOEhkbHNYbGhOYjhqbXE5ejUxc1RuN0duclY5VEFYK0JYMjE1Rmc4eEJx?=
 =?utf-8?B?ZEh2cUlKaVpaRXNGaGo4c3dmTWkwQ3p1NElrU1dvQnFPMzlqVVZGM3FBWGZQ?=
 =?utf-8?B?dWR2bzJzMUorYUd1d2lyS0I3U2NrWlo1eXl4aCsxSU9LM2V5MVZlRWY5V1dM?=
 =?utf-8?B?UExySVFSR1VZakQxcnRmcGZCM0VkNkN6eUs4NDE1aDlWcHNWa1I2NXNGVHlp?=
 =?utf-8?B?UkZ6SVg4UG1WTkJyUDM0L3BsS0pLMVkyRVJSaVNXYTZ6YlV0cTdUNTBhbWhz?=
 =?utf-8?B?aGVTc0llZjBYcERsbE9VNngvUnpNa1c5ZERwelRlMnZzTzdzZ1lKL2kwdm91?=
 =?utf-8?B?c0lYYUFrRkZhblhhcGVtVWRXUGlncEdPcmxXNlA5RUNNN3JwVXdYRFJnY2cx?=
 =?utf-8?B?aEhSRDZnU3VaazMrclZwQnRKU0hGa1NEMVpCc1FPWS9lRHQyU1ROZy9kaGlu?=
 =?utf-8?B?WXhKWW04Nk5jMEM4MkZkRmlpOW1KR0pBa0N5TElDanBPdk11ejZWRnFNMkF4?=
 =?utf-8?B?bHlMd3BIOHJmc0dJd3hTbGlpWUJJYzJyZzIzcHhlb1hmREROendDdkxmdUll?=
 =?utf-8?B?WnBGamtlRFlTT0RqU2cwU2xhdGRucFZZSDNFR0VwMStlazI1a0wrUmxxRm9T?=
 =?utf-8?B?Z0pLNTJLMVRSeFZycnROdDhpSEwzUUxQQ0NBR2FmSmF5dThYMEN0Zkszd0FD?=
 =?utf-8?B?MFdOVDNPZWdGYWJ6NGNoU1NpRk1PQTVFQmNsejFuYnR1YldnT212TE5Ca2pM?=
 =?utf-8?B?Mk1wbllReDhOMXdQdWNHcXhuSzdCTEVocGFpVlBjY3QxQ00yVXd1N1VuTjQz?=
 =?utf-8?B?Y3BEanUzTmxxUnlNODJ1QWNBSDNjTWxhMVdNN2NSSXp3T3lEZGJ4S3JtbWVx?=
 =?utf-8?B?R2Y1aW90by9RK1Ywcm44WnBFTjdtL0N2NlNYMHZEQUd6VUViaDFWWGM4RmJN?=
 =?utf-8?B?ZGJHd1pheFlaY0JOU3p5TjFoZmZYSnIyWlkyWjZzenNNWVdWV2gxdWl3SU02?=
 =?utf-8?B?YXplalpFTVFsSG5VdzVGRy9XWnFSYzZvZlpCcU92c1hQamRsOE1nK29EYVla?=
 =?utf-8?B?WVdLMW1ZU0E2S0pCWGdBQUM5NVN6TWNYQlpINC91YWNmL0w4UzY3bHYvQ1JN?=
 =?utf-8?B?WnBHdEhOZjFVZlV1MkpjVkFTMFI0dlpCWEZmR2dnRFRKNmR1V2ZSZnM3cXFl?=
 =?utf-8?B?bjFRQms0cGhrQllic1B0UDl3WEN0ZCtRV01wNXVGQmh6VlFTSEw1N3M0RTdO?=
 =?utf-8?B?RnYzVGpQbEdxZExuUjZPalI0ZTM5YURhUEl3UmQramh5bzJwb0VXTE1RRnRs?=
 =?utf-8?B?SDRRLzhuMkFXMmRrOWFxVmtuQS90MTRqREQyY2dITXFDVDI3aDNhOERlWVRs?=
 =?utf-8?B?YUtZWWVFWWZ3RlZ2S0t1TlZiNUhkSCtMazl1aWxoRVQ2cWJJN0RtT29qMVdl?=
 =?utf-8?B?c3FRdkNyWWt3NmJMam5pNVk3akRBbjUwU3lqdWNaQndob0pqb3dEZXJCNUVN?=
 =?utf-8?B?ME44YTVBUVhaS1hsQlVzRXpHanFYenppL1NLUW9qdWFlYXNEVXVzWnRRcmhs?=
 =?utf-8?B?ZzZNQndTdGFQcER4MnR4VWhDS3ZBSWRGbzRORENQSHRGMlNaYUdBVkQ4aHFM?=
 =?utf-8?B?T29UYS9UOENDUjFXS3ExRHIxcCt4QnRWckhlLzZYVDEvSlkyUmZVY2ZsZHhp?=
 =?utf-8?B?aGNNM21aMmN1K0l3WkIvMGVhOUJoY1hUOXN3cnVvOWExTHpKcmE0N2tLL2RX?=
 =?utf-8?B?a1ViT1FVdGN5UWFMQllBVnhnYnRWQkFleHNNQlVRN0hja1NMS3JYOEtGZ0FK?=
 =?utf-8?B?YWgwQStNL1NPTWxReURrNmt2cGtaUzZnMkQvOTJIQnN4K3M5d3BUTkl6WUdS?=
 =?utf-8?Q?vX3aIVy48xuwz9ADxfZau5jMY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c26545-520d-486e-2d93-08de157c34c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 17:13:53.8320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unj86/Z4TeciYwex06sl4dNJpfH8JaQL2qBO4lHxUp+y879cPhPVLGDtTDE5Bk4GlR+c+/ZVmsrEVw/gF+nblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDI3IE9jdG9iZXIgMjAyNSAxNjo1
OQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNv
bGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBN
YXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5n
emhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25n
LmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBn
bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyMi8yN10gaHcvYXJtL3NtbXV2My1h
Y2NlbDogQWRkIHN1cHBvcnQgZm9yIEFUUw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0K
PiBPbiA5LzI5LzI1IDM6MzYgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gUUVNVSBT
TU1VdjMgZG9lcyBub3QgZW5hYmxlIEFUUyAoQWRkcmVzcyBUcmFuc2xhdGlvbiBTZXJ2aWNlcykg
YnkNCj4gZGVmYXVsdC4NCj4gPiBXaGVuIGFjY2VsZXJhdGVkIG1vZGUgaXMgZW5hYmxlZCBhbmQg
dGhlIGhvc3QgU01NVXYzIHN1cHBvcnRzIEFUUywgaXQNCj4gY2FuDQo+ID4gYmUgdXNlZnVsIHRv
IHJlcG9ydCBBVFMgY2FwYWJpbGl0eSB0byB0aGUgZ3Vlc3Qgc28gaXQgY2FuIHRha2UgYWR2YW50
YWdlDQo+ID4gb2YgaXQgaWYgdGhlIGRldmljZSBhbHNvIHN1cHBvcnRzIEFUUy4NCj4gPg0KPiA+
IE5vdGU6IEFUUyBzdXBwb3J0IGNhbm5vdCBiZSByZWxpYWJseSBkZXRlY3RlZCBmcm9tIHRoZSBo
b3N0IFNNTVV2MyBJRFINCj4gPiByZWdpc3RlcnMgYWxvbmUsIGFzIGZpcm13YXJlIEFDUEkgSU9S
VCB0YWJsZXMgbWF5IG92ZXJyaWRlIHRoZW0uIFRoZQ0KPiA+IHVzZXIgbXVzdCB0aGVyZWZvcmUg
ZW5zdXJlIHRoZSBzdXBwb3J0IGJlZm9yZSBlbmFibGluZyBpdC4NCj4gVGhpcyBsb29rcyBpbmNv
bXBsZXRlIHRvIG1lLiBBVFMgaXMgYSBiaWcgdG9waWMgaW4gaXRzZWxmLiBJIHdvdWxkDQo+IHBy
ZWZlciB3ZSBkbyBub3QgYWR2ZXJ0aXNlIGl0IHVudGlsIHdlIGRvIG5vdCBoYXZlIGZ1bGwgc3Vw
cG9ydCBmb3IgaXQNCj4gKGluY2x1ZGluZyBlbXVsYXRpb24pLiBDb21wYXJpbmcgdG8NCj4gYzA0
OWJmNWJiOWRkICgiaW50ZWxfaW9tbXU6IEFkZCBzdXBwb3J0IGZvciBBVFMiKSB3aGljaCB3YXMg
cmVjZW50bHkNCj4gY29udHJpYnV0ZWQgd2UgbWlzcyBhdCBsZWFzdCB0cmFuc2xhdGlvbiByZXF1
ZXN0IGltcGxlbWVudGF0aW9ucw0KPiAoUENJSU9NTVVPcHMgYXRzX3JlcXVlc3RfdHJhbnNsYXRp
b24gY2FsbGJhY2sgaW1wbGVtZW50YXRpb24pLg0KDQpJIG1heSBiZSB3cm9uZywgYnV0IGZyb20g
YSBxdWljayBsb29rLCB0aGVzZSBhdHNfcmVxdWVzdF90cmFuc2xhdGlvbigpIG9ubHkNCm1hdHRl
cnMgZm9yIGVtdWxhdGVkIGRldmljZXMsIHJpZ2h0PyBGb3IgcGFzcy10aHJvdWdoIGRldmljZXMs
IHRoZSB0cmFuc2xhdGlvbg0KaGFwcGVucyBhdCBoYXJkd2FyZSBsZXZlbCBJSVVDLg0KDQpOb3Qg
c3VyZSwgeW91ciBjb25jZXJuIGlzIGNvbXBhdGliaWxpdHkgd2l0aCBlbXVsYXRpb24gc3VwcG9y
dCBvciANCmJyZWFraW5nIGFueSBmdW5jdGlvbmFsaXR5IGhlcmUuDQoNCj4gDQo+IFNlZToNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNjI4MTgwMjI2LjEzMzI4NS0xMS1jbGVt
ZW50Lm1hdGhpZXUtLQ0KPiBkcmlmQGV2aWRlbi5jb20vI3INCj4gDQo+IEFsc28gaW4gU01NVSBz
cGVjIEkgc2VlIG90aGVyIHN0dWZmIGxpa2UgU1RFLkVBVFMsIEFUUyBza2lwcGluZyBzdGFnZSAx
LA0KPiAuLi4gSGVyZSBJIG9ubHkgc2VlICBTTU1VX0NNRF9BVENfSU5WIGFuZCB0aGlzIGlzIG9u
bHkgaW1wbGVtZW50ZWQgZm9yDQo+IGFjY2VsLiBJIHRoaW5rIEkgd291bGQgcmF0aGVyIHN0aWNr
IHRvIHRoZSBtaW5pbXVtIGluIHRoaXMgc2VyaWVzLCBpZS4NCj4gcmVqZWN0IGluIGNhc2Ugb2Yg
QVRTIG1pc21hdGNoIChmb3IgdGVzdGluZyBwdXJwb3NlIHlvdSB3aWxsIGp1c3QgbmVlZCBhDQo+
IHNtYWxsIGhhY2sgdW50aWwgd2UgZ2V0IEFUUyBzdXBwb3J0KSwgd29yayBvbiBBVFMgZW5hYmxl
bWVudCBpbiBwYXJhbGxlbA0KDQpJIHRoaW5rIHRoYXQgaXMgdGFrZW4gY2FyZSBpbiBrZXJuZWwu
DQpTZWUgYXJtX3NtbXVfdmFsaWRhdGVfdnN0ZSgpIGluIGFybS1zbW11LXYzLWlvbW11ZmQuYw0K
DQpJIHdpbGwgZG91YmxlIGNoZWNrIHRoYXQgdGhvdWdoLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

