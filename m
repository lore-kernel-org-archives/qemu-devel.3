Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB5DCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRQm-0008An-AS; Mon, 27 Oct 2025 13:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDRQh-0008A7-LP; Mon, 27 Oct 2025 13:54:52 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDRQT-0000xO-SN; Mon, 27 Oct 2025 13:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VksX8A4yY/vvgc2Xe2Ehse0C8EZTzfdh7bZhF7tOoxk0HHukBd0hSthNsYGLU0wFpLq64f4vE3cXUr+sSKxeQ+zU0kSA4l3oSAdCyuIMl3UoVGmEHz09cDM966wFc7hTvWhDSsdO/5PkrploRZLdMPW+GgM6FE/+wKnx63NYcAUY/sQaRuG8k+RTfDwrktTHC66b4zcD0DEzxg3pH7S7UgzZH+t+dM5QKy2iX+D45tPdc38mdJT7BGwzQGpChzMeO8n3DaNfPW46NlpNd3VFtlT3Bl23fXc/kwRqmmGXprMk74heUkhYddNyQggo94hoLxBMYNH5ot615duw62DSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+bLDocHT5uPtPByb02fAZHoXpO1s1MjP9VFizasfxY=;
 b=GEuOjGKMS1SQCKlM4FUnemhV86kZ//s1QArExQClyCzMto7HkYbm7RLTQi2Zoj6QVjLwnSdeiOvZmNIJtVnGCXVTjunWSyN5Csxjm/4aljwsDyBjBbxDeC3/KGHVJ2OeGvGEkPC2T08+3se+EbE95cAmQWWZbmADXQ41yHPq6X21Md8OhmLSr+N4/CBrQtlS3nGZYyq2NKOPH5IhwjqOYbdpk1srnwW+Ipknec8+ABx5xDWuPYgTIb6MLiMRjCbPWemZnhAvJL1RD920aW5cIbO4kFVTANW7VqPUeppNkHwOEl0L8QJ3VMe9M2Fv2EY0m29jn5MZG2LBuHurPIn6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+bLDocHT5uPtPByb02fAZHoXpO1s1MjP9VFizasfxY=;
 b=g8l8dkqNVM9HJ9Rjhcm0nlVwRBe13m83rpimy3NcZ4UTxKqeprTucZqUXNbiOZMPfNZnPk4XuKEliBQsBNMFypq1Sp4radhtkPa4R6UH1w2hARwUQg9sxH5lghFnSI9PjpxDAOx+DvXVCUgoq8wh1aiD3qXBX1ThZvr2lUKhLFtjh0QHLZpU4Bv8Ul4Jiq+jUnEIuH7ZzyYyLvvbnCNsWIn0a7GqXWoBHhQJAEAkXkiNWNXsXW16/cL7vLCQ5n3LQIGRaNpe/2iVwx9GyMe0HTtyl1hBjLP9V/BN4f5+OFY1jgnX7SeGyQ7KVWL6irPf91RdqcGXuUi0rO3+agWFaA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:54:22 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 17:54:22 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Topic: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Index: AQHcR2MFngFyUDoiY02aRyWaAGA96rTWO04AgAAG1gCAAAA/wA==
Date: Mon, 27 Oct 2025 17:54:21 +0000
Message-ID: <CH3PR12MB754817705781C75530974DB1ABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
In-Reply-To: <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ0PR12MB5611:EE_
x-ms-office365-filtering-correlation-id: 11d17a50-be69-4e17-c157-08de1581dc10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?enI2NlRFRnZ4K3NmeGR0STBVRXFvUWJFejFZUThjUW5qRlpiWmxXR2JuSTMr?=
 =?utf-8?B?TklHM2VoalFOY0tYaDFXL3k5Ui85KzVBVXgzL2xqR3U2YjVRaytXWUpneEtP?=
 =?utf-8?B?OTVSalFtQjQ0bk1zb252ZDVZU1hzdmRvWlQ2Q2VXNkdjWWNQYnlKR00wVzRT?=
 =?utf-8?B?ZWtNbS9Ham5WK0c5ekhyb1hESmo2bEVDODJMOUZyYVBnczZsWkhxblNBUE50?=
 =?utf-8?B?QUx0alB3dDlVekU5V2tvNmFDbXh5TmVFM3I3OUJsWEk4Z1lWT2dHZC8xb0Fr?=
 =?utf-8?B?YlpkNHk1UDVUTm8zRWRMUllnK1o3QlR4Zmdjc3hUcVVhdnQzVml3Q0I5Q1N1?=
 =?utf-8?B?d1lBYkU5dGpQVHJpTjZjL0E0SlZOSnRZZDAzK2hPaGtCcW5sV1VnQ2pPdWFP?=
 =?utf-8?B?bjN4NEJKS1lWZHJkTkRPM0JONndEclgxaHF0bjBQZ09kK2p2OG5OY1NRcktE?=
 =?utf-8?B?YXpBTWpoQUgxcW8vWU1UdG1WbFI1ODNkbU9DWVpsckNuR0xUdERQZVY3bnBN?=
 =?utf-8?B?YzZOTzRPbm4rQjZUa2J3ZGg5U3NqdmhRYUZSOEMwOE44VFpzKzE2T3NEcWRT?=
 =?utf-8?B?WVNSVjJyS3FsZlhjZW5yUzI2bm0wZm1KakFoTHRQV3VrbG0yTGN5RXJadXk1?=
 =?utf-8?B?c25VMXQxdEJVRWlOTFJlamdJZEZETzBQUkJ0MGJ2b2lWOUc0aEQ1M1N4RlND?=
 =?utf-8?B?SCtibWw1VjNhd3BwSWJSNHl0RGdFbXY0d2JQbThGbC90aVpTYnFMUkRZS3Fp?=
 =?utf-8?B?K0lGbFFiTjdWUGVOdVczOVpqcEFVemQ4NllLaUY4WkpTdFE4OGUxN3MrS0ZC?=
 =?utf-8?B?K05SckFFZ3d1V3Aya3BqaTdsS1lSZ0Q2UHlkUTlpK1pvcmdsQ3NadFhNSndq?=
 =?utf-8?B?MWRaRStaZTNINnV0YitPZGdLSmkrSnAvUHlScVZqTWRjaUhKWmVWeGsyaTRR?=
 =?utf-8?B?Q0d1M3hoQmVjMHBpWFdzalZ6TVM4alRsT2pDK2RXVEFWdFFSdXUydzN1eStv?=
 =?utf-8?B?MjEzWDhETHdrNy80bFBPekUrWDhLUzM0SWdjNHhKSmRJeWdnWDRaaW1tSVZX?=
 =?utf-8?B?MjYxcWhYbzZOd0ZaN3pwWTVvdEI3akJTTzFTNFczRXlJa0hjZFJxOW1ibE5j?=
 =?utf-8?B?UkZyc0ZBUlVnN25LczlsQWYvME9RbDcrV0xFQkwzaHZZOTB4dFRRNDB0cU10?=
 =?utf-8?B?bXdoZGRWdFBzYS9GK2dJRk5PYTB6NTU3ZDJFSmlpc255Q1gzOUJGRytEQzlW?=
 =?utf-8?B?QUFqT2M4YWdsTlVMOWtLRm4ydzNOejJRSVVlaFNxdlYvTFdnT1Yyb0FoQUVI?=
 =?utf-8?B?UmU4NXBGeEk3czViTjFsSFdQUUhkWEFjVjRPbDFSV2c0aXBCbHJ0SVFOMVlt?=
 =?utf-8?B?VHpDaUVjYno4TXcrN1h0dVFFNm5wUVFzbmlpb0dBamJqK25rN2M3ZDVVT0ND?=
 =?utf-8?B?bUhCMWhXN3p3MlZzbEIrL1lOT04xZkpiVmREbTgxU2FYMnFtUUFCUktyZitL?=
 =?utf-8?B?R25mR1FUSmhGL0dFanFpaCs5cXhKOGRvOW1XTXFEYnYxNVVBbDRUcmdsSzJv?=
 =?utf-8?B?ZzVDVGJ5VldBNnQ4QkM2aUVBeUdUOWZIdlo1WU5meEprSWlkSWFzbURFSlhT?=
 =?utf-8?B?anYvdnRSd3Q0T1hVOEpxTWVwRjZrMUVMaVphYlF0Yk90bktrS1BjWHl2ZFI2?=
 =?utf-8?B?ZFp5MHRvTFFIM2R3dlVmNDlVMmV5aUM3SXFIS2FqUStzUTB6OC9BaTJrcU5I?=
 =?utf-8?B?S0hqSGtkcXdiUFo0UWtCWGZrUXorU3VRd1pSdFBxQ0tOVmIya3AxVnlsNmRs?=
 =?utf-8?B?T29wSmlKeWx4VitYUEN2WEdWeG9DcDlYMmhZTWVTS1lNTXdLb3gzbVQrM2lM?=
 =?utf-8?B?UXViMTZvbUV5U2pmMk45RUxCVzBDemhLU0M4UDkwNnhVajUrYjczckhUeUpw?=
 =?utf-8?B?U3pMUXpxNWlxVzc5RWJFaDdzUEFlUU1nVlMrdWV3TW1BY2FvcWN6RXoyb2xz?=
 =?utf-8?B?bFkrUXcxSFRBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QldUcUNENGtIckJSRVF1QzcvSVA1UElmMS9xWERYcDR3Z09hamdlRnJKYVVP?=
 =?utf-8?B?aTBOSjF3UmY0bVVuZFgwcFdGOVN1UHJkaGMwMGtUUEErSFZlai9vVU1kZVJI?=
 =?utf-8?B?bktNMktVTk5TQlhGK1ZqbXBhUi9kZDBKYVRZNStydkNkMFpjZnlxZ0wyZVNM?=
 =?utf-8?B?NlhDNXhReGp3TStqYnR5Z09WS3ZPQUEvL2pVdHRrbkZYN0ZBWnBNcHpZdmV5?=
 =?utf-8?B?L1ozd083dkx0U2wvdy9nM0p4cHMzTXgybmhnK0ozM1FZb0E2WmN1ZitYVDlI?=
 =?utf-8?B?NGxhdnN3WXpmRUVGYmFjN0w3RUd6K2U5RXVmem9uaFdodEtBSzZBajJySTJQ?=
 =?utf-8?B?SzdHRjFQcnFOWFY1VGp2YzZMRXJKczhNeWZCMWJoVGpYRWk4NHV3SUY4SjJL?=
 =?utf-8?B?TVU3NlY0OTRVN0VQVUlCb0tlQlM5UEo4bG9KVFd5N29ibUVublNQQ0ZydWQy?=
 =?utf-8?B?bnZLSWYzTHVnWnZWeGtNTFJUektwUHc2ODFNYTFBWlRhcVZLSzllNHBWVFNx?=
 =?utf-8?B?Ym05ZEViVHFqT1RPeDI1OWVuSDFSNmo2RzZvVWc1dzk1SDk3K3lyS1Zqa3Rr?=
 =?utf-8?B?ZUtoVTZIckMxakx3Q3h4bkZ3OGhjNVVJcmhOaC9UQzZwUXVwVnJZOFlGVGxG?=
 =?utf-8?B?bkw0eVNuMUJMeDJjNERrQS84Wk1EeTNKTTNUdkN4bFdsd3Z4K3JXaVdaL1FE?=
 =?utf-8?B?VW15Mkl4cGRraDhyQkxRdHhSWWlVQmxvSDA0c2VNNGtmeEcvRE5nK3N5bEo4?=
 =?utf-8?B?OG9nQnBqbmdXZzBYdTZBWWZHUGdlTUhhQi9URTZxWUp0QUgvcmpseHB1Ry9O?=
 =?utf-8?B?TU9POHYzSTVFeExoU0RBeFVLL1hJbnI2Z1ZUeThPWG45M1I0YTFaSmpmUXhS?=
 =?utf-8?B?K25CMENqSlpsam1xaVgwYm1kb0VFYmcvV1RjcGdZMFpQY0xzS3ZuLzk4SWpY?=
 =?utf-8?B?SHBUS04xNHhtWTNJYmlQWDdpYnlvNXVPbEVCTkwzMy91a1JVY21HTDNhMW42?=
 =?utf-8?B?WVFLNXR5Y1lJejF2cHcwN1ZTdGsrTHVqeitsUUVFMVFpYlFmUk5FQWdqZDdR?=
 =?utf-8?B?RklLYXlmOW9uN081NlFSa1JYenN0MUZXV29pOVZFL0FIKzl6UHpjUDJ4enJt?=
 =?utf-8?B?WG1oRy9PTmI0alVydlNldjhkdkEreGI3d2tOd2VTdUxRSlZlMFNhaEprbVZu?=
 =?utf-8?B?M1ptVHhSU2xPaTA3aVVYT1JyOGNXeGlTbk5SdXpWWWJJclM3UFlETDI1aW5x?=
 =?utf-8?B?V3dzaWs0ZURiTkRyb0VnRjFxYmU2c2J0dE5GNm50YVYvWlJmektKcmRrbkVo?=
 =?utf-8?B?b1lKZ3p3SExzOVJpZ2FEWmR4WTY3SjdJV2RIZTJCR2pQREhxelpoK1JYTC9Y?=
 =?utf-8?B?OTNyQ05HM0RiN0NtSEFFOEtMYkgrMndVd3RON2hoRkJJYmxhUVBuQ1ZzT3I1?=
 =?utf-8?B?ejNTQW9qRmcyMElVYURNMGNXTmoweW1zdEkzQ2hCUFRDKzBYVVk3TmRHZE9q?=
 =?utf-8?B?Z0RGUDBGTTBGMFlVd0VPMkVnK2w2UlNkem9rNmt6UzIxVWZFcVdyQVE4ZlJa?=
 =?utf-8?B?T3RGaFVnZ2lRWUYxelNPMk5lNkd1eHFYd3JVejFXanBZL0owQ0RBRWU0NWw3?=
 =?utf-8?B?VWRRWGp2MTJEMXk5TkRvUTVPM0pSQmhXQkg1RG1aTmM5WWJDVUVESmlOZmtK?=
 =?utf-8?B?cWNqd0VtR3doRWtmOVRsMFM2dktCNHBmd3ZiZEcxSUErZ3RDSGZuOUMvRTB4?=
 =?utf-8?B?Qis0eG9NSkRaa2dwSDNUbGQ0bm9rREpiOTc4ZlQySWFoUHFFbGpMT0Y4dGs3?=
 =?utf-8?B?YXRydGdvREoxZ0c5M1QyT2xyVGFFTi84M2lGc3dyYjBaWGhibk5XdnJpSlE3?=
 =?utf-8?B?dEhicWg2NEV2dkhyZE9HNmtZb1d5RHprb1JUMFdERCtPS3g5cVJtRURkc1hK?=
 =?utf-8?B?UUZnZys0MW1yVkZ1OUxXSVhLOG9MQ09hSUVPT3RDczZSaVl1RkJQbW03Z29r?=
 =?utf-8?B?Y05uZEh0dmdMZ21rcVNuNXVnSkJDbUpxYXpUeWxxWnRwcHIwNW1wcFdUSU9D?=
 =?utf-8?B?Y0pnREZUYkpySm8wa2o5b0ZCNG00Tnl1T3ppSjJXcnViUEZqRTZxYTVhU2E5?=
 =?utf-8?Q?JtgF8Nz+iynUn0UcnSr6qDUty?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d17a50-be69-4e17-c157-08de1581dc10
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 17:54:22.0002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qlVVOFrRGhMHzVOyY6Rd4BGqQnmc0k/q5vpjq6JjF1zU5pvxIg+fjA92Jnjkt+pEmCxdPlZI/cC5ew69WX97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIwMjUgMTc6MzgNCj4gVG86
IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IFNoYW1lZXIgS29sb3Ro
dW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiBiZXJyYW5n
ZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hz
DQo+IDxtb2Noc0BudmlkaWEuY29tPjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhp
c2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFtZWVya29sb3RodW1AZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjIvMjddIGh3L2FybS9zbW11djMtYWNjZWw6IEFk
ZCBzdXBwb3J0IGZvciBBVFMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVu
aW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMTAvMjcvMjUgNjoxMyBQTSwg
Tmljb2xpbiBDaGVuIHdyb3RlOg0KPiA+IEhpIEVyaWMsDQo+ID4NCj4gPiBPbiBNb24sIE9jdCAy
NywgMjAyNSBhdCAwNTo1OToxM1BNICswMTAwLCBFcmljIEF1Z2VyIHdyb3RlOg0KPiA+PiBPbiA5
LzI5LzI1IDM6MzYgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4+PiBRRU1VIFNNTVV2
MyBkb2VzIG5vdCBlbmFibGUgQVRTIChBZGRyZXNzIFRyYW5zbGF0aW9uIFNlcnZpY2VzKSBieQ0K
PiBkZWZhdWx0Lg0KPiA+Pj4gV2hlbiBhY2NlbGVyYXRlZCBtb2RlIGlzIGVuYWJsZWQgYW5kIHRo
ZSBob3N0IFNNTVV2MyBzdXBwb3J0cyBBVFMsIGl0DQo+IGNhbg0KPiA+Pj4gYmUgdXNlZnVsIHRv
IHJlcG9ydCBBVFMgY2FwYWJpbGl0eSB0byB0aGUgZ3Vlc3Qgc28gaXQgY2FuIHRha2UgYWR2YW50
YWdlDQo+ID4+PiBvZiBpdCBpZiB0aGUgZGV2aWNlIGFsc28gc3VwcG9ydHMgQVRTLg0KPiA+Pj4N
Cj4gPj4+IE5vdGU6IEFUUyBzdXBwb3J0IGNhbm5vdCBiZSByZWxpYWJseSBkZXRlY3RlZCBmcm9t
IHRoZSBob3N0IFNNTVV2MyBJRFINCj4gPj4+IHJlZ2lzdGVycyBhbG9uZSwgYXMgZmlybXdhcmUg
QUNQSSBJT1JUIHRhYmxlcyBtYXkgb3ZlcnJpZGUgdGhlbS4gVGhlDQo+ID4+PiB1c2VyIG11c3Qg
dGhlcmVmb3JlIGVuc3VyZSB0aGUgc3VwcG9ydCBiZWZvcmUgZW5hYmxpbmcgaXQuDQo+ID4+IFRo
aXMgbG9va3MgaW5jb21wbGV0ZSB0byBtZS4gQVRTIGlzIGEgYmlnIHRvcGljIGluIGl0c2VsZi4g
SSB3b3VsZA0KPiA+PiBwcmVmZXIgd2UgZG8gbm90IGFkdmVydGlzZSBpdCB1bnRpbCB3ZSBkbyBu
b3QgaGF2ZSBmdWxsIHN1cHBvcnQgZm9yIGl0DQo+ID4+IChpbmNsdWRpbmcgZW11bGF0aW9uKS4g
Q29tcGFyaW5nIHRvDQo+ID4+IGMwNDliZjViYjlkZCAoImludGVsX2lvbW11OiBBZGQgc3VwcG9y
dCBmb3IgQVRTIikgd2hpY2ggd2FzIHJlY2VudGx5DQo+ID4+IGNvbnRyaWJ1dGVkIHdlIG1pc3Mg
YXQgbGVhc3QgdHJhbnNsYXRpb24gcmVxdWVzdCBpbXBsZW1lbnRhdGlvbnMNCj4gPj4gKFBDSUlP
TU1VT3BzIGF0c19yZXF1ZXN0X3RyYW5zbGF0aW9uIGNhbGxiYWNrIGltcGxlbWVudGF0aW9uKS4N
Cj4gPj4NCj4gPj4gU2VlOg0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA2
MjgxODAyMjYuMTMzMjg1LTExLQ0KPiBjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbS8j
cg0KPiA+IEluIGFjY2VsZXJhdGVkIFNNTVV2MyBjYXNlLCBBVFMgdHJhbnNsYXRpb24gYW5kIGlu
dmFsaWRhdGlvbiBhcmUNCj4gPiBkb25lIGJ5IHRoZSBwaHlzaWNhbCBTTU1VLiBXb25kZXJpbmcg
d2h5IGRvIHdlIG5lZWQgdGhpcz8NCj4gDQo+IGluIDA2LzI3IHlvdSBzdGlsbCBjYW4gaGF2ZSBl
bXVsYXRlZCBFUHMgaG90cGx1Z2dlZCBpbiB0aGUgbG9vcCwgbm8/DQoNClRoYXQgY2FuIGJlIHBy
ZXZlbnRlZCBieSBwcm9wYWdhdGluZyBhbiBlcnJvciBmcm9tIHRoZSBnZXRfYWRkcmVzc19zcGFj
ZSgpDQpjYWxsYmFjay4gSXTigJlzIGFscmVhZHkgb24gbXkgVE9ETyBsaXN0IGFzIGEgZm9sbG93
LXVwIHNlcmllcywgYnV0IEkgY2FuIG1vdmUgaXQNCmZvcndhcmQgaWYgdGhpcyBpcyBhIG1ham9y
IGNvbmNlcm4gaGVyZS4NCg0KPiANCj4gSSByZW1lbWJlciBzb21lIGRpc2N1c3Npb25zIHdpdGgg
UGV0ZXIgd2hvIHdhcyBhbHNvIHJlbHVjdGFudCBpbiBnZW5lcmFsDQo+IHRvIGludHJvZHVjZSBz
b21lIHBhcnRpYWwgZmVhdHVyZSBzdXBwb3J0LiBJIHRoaW5rIGluIGdlbmVyYWwgdGhpcyBpcyBh
DQo+IGdvb2QgcG9saWN5IHRvIGhhdmUgZmVhdHVyZXMgZW11bGF0ZWQgYW5kIHRoZW4gYWNjZWxl
cmF0ZWQuIFRoYXQncyBhbHNvDQo+IGdvb2QgZm9yIHRlc3RpbmcgaW4gY2FzZSB3ZSBjYW4gYnJp
bmcgdXAgc29tZSB0ZXN0IGVudi4NCg0KVW5kZXJzdG9vZC4gSG93ZXZlciwgQVRTIGFuZCBQQVNJ
RCBhcmUgdGhlIHR3byBrZXkgZmVhdHVyZXMgcmVxdWlyZWQgdG8gbWFrZQ0KYW55IG1lYW5pbmdm
dWwgdXNlIG9mIHRoZSBhY2NlbGVyYXRlZCBzdXBwb3J0LiBJ4oCZbSBub3Qgc3VnZ2VzdGluZyB3
ZSBza2lwDQplbXVsYXRpb24gZm9yIEFUUyBvciBQQVNJRCBlbnRpcmVseSwganVzdCB0aGF0IHdl
IHByaW9yaXRpemUgdGhlIGFjY2VsZXJhdGlvbg0KcGF0aCBmaXJzdC4g8J+Yig0KDQpQbGVhc2Ug
bGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBzdHJvbmcgb3BpbmlvbnMgb24gdGhpcy4NCg0K
VGhhbmtzLA0KU2hhbWVlcg0K

