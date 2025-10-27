Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC92CCF9F0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOeR-0003ph-AT; Mon, 27 Oct 2025 10:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDOeP-0003oQ-7D; Mon, 27 Oct 2025 10:56:49 -0400
Received: from mail-eastusazon11011067.outbound.protection.outlook.com
 ([52.101.52.67] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDOeI-0001pc-7E; Mon, 27 Oct 2025 10:56:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr6EV3OCA8ZotnPWiV0mrL4fPMaQ4qI/fTRM6CNGk7cBRr54cz/HBczZlQoLdip8Q/YgLFt/AVFH9IqWwCuF0HVJcENd+2rIbSODUOznrmYFgmF2Z6IB6PZ/wapHN67rLMqWqFpQZLqjlAaxsJuQAv+Eka51OlYG5Qe/wxcA8lGNBX7Rz1ZmtxmlpdwcsRpWULvSRtjEdTL48PxponBVJ87TpI0IxHVih6O6yMjrsC3yY8qb7OKATHX9B984Ayu8uDzeKrWnd28Nu3JtKNbYqaAwk+2ve5IBmfI8XboHY09mNbbfL23ZHqTCNSLFNTVJeDyepFywHPw3LsuGYSc2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPQIYFyC48/sf/hZunxy1mWUNpjxnkBcXu+4quJUnCk=;
 b=fju2T+Vfrp6KTkpO/26fKe/E5S1gHSGMDuAWBrVyYaj5mAxQyKoVrl4/hCJDqoWadrM+6bQKBkxY92fbXQVjcKkyzP+IPoF0255KZvmXgGN+K3gXNU6PlBM77g9BmG3YfAm4NWhJ6LSmXbHhOORxcViwMPPXtJ9dWvcrRSwVUfufEJ6JcqxEjN8Bznab7jYGVbhwoqkbETOWdUbG0ox3UAm8Ji5tpLtevvRuQKo2Js8cPFCLxwg1oTmtHzdNqhqmFZl/LzOpPitvCjAePdVLYtUi1RUATY/0GdijBo211HPvV6hU0ZbGbMOMcow1t+13JIih1mBP9yRrDSVb5Mpjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPQIYFyC48/sf/hZunxy1mWUNpjxnkBcXu+4quJUnCk=;
 b=e0coc42dxk9cD3Dkl9nRBTyYSOqxYeRJX2rDq2W6zNNONpdnQJaLJc4+u+yVinqfnNYfhEl3gwbmcAxf/nvwWVB1ldAkNysWg2lIEnFemTRjL9MU3aptnCJQIpk8+L04MWYPojFLr+FyK2BkyVpkFVTS7OI5m0Ro749I4M4FzR2ssnKisIQMcGnuxSkGMkhvyyKoDxhqZSbHOm+y12pDcBRtdVraKtowzoSTVxnxer/GS9bp7Pt6qHNtWxdCeC6K24Z18C0EkPz6IJLgWGFgn4tzAaxn1hqvTQWes4v/fgJ+mjoPH6wlQMKlC6Bp9Iri5kX+oFNhLslFuGCVgbI02A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 14:51:16 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 14:51:16 +0000
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
Subject: RE: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Thread-Topic: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Thread-Index: AQHcPvNf8cNe0zISsE6Kcr2+CesP+rTWHWaAgAAEKcA=
Date: Mon, 27 Oct 2025 14:51:15 +0000
Message-ID: <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
In-Reply-To: <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV3PR12MB9119:EE_
x-ms-office365-filtering-correlation-id: f24e2c9c-ed64-4465-9bf5-08de156847e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NWdrTVVlUk45RHJ3MnUzSkR3RjF4eWJHZVJLSzR2d1d3aHluYXV5cU9RRzVQ?=
 =?utf-8?B?YlNRUkpxYU1wU1Mva2VzWmFpNGM1bElSa0NqV2c3dWhQY1oya1hXWkE4UDla?=
 =?utf-8?B?aXg2ZTlUTnJoTnkvU2JjWVdVOFE3bUlmOGpnQis1OUxnbVk4eitwSXZtRVlX?=
 =?utf-8?B?bU1ya1NYcjNNVU16RSt4NjRKZ254SHlLeDNhVGFBVW53OGZ6SloxK1B4QWVo?=
 =?utf-8?B?YW9NSFExL2w4dXFSRHJnL1BleUhzNlRLVUM5QnRnSWZwdy92TU0zS0hvM3ky?=
 =?utf-8?B?YzlOcEVhQkRub0ZyM2RHN2Y1cG1hbnUyN2ZicStIb2krSjVaVkNGa0IwNG1N?=
 =?utf-8?B?czVLSytUeUJuSFRqVUNiRTZ4dGpYdkNyUGk0b3BoOWNqeTJLc1ZyZU5YT0RQ?=
 =?utf-8?B?Z2NFY0xNOUl2YkxPeGpXUDJsV0xDUWZVRVMwY015UCtJMWtXUWthYUhOWG00?=
 =?utf-8?B?UXlPS3F1UnJ4VUFpWDRBdFdDRmh4QWRFT1lVbVNHbnlJTFIyVmk0aUdGQ1hq?=
 =?utf-8?B?M1ZkdUxhWnpGeHRSMzRjcHY3UThscVI3Tkh5dzN4OUFRVXQyd0Rlc2RMcVdC?=
 =?utf-8?B?a3BEbWIwM1RvaE5SRm1mem5UU05wRmg5dlNiSTNBMTBkMkx2ZVgvZFdtWUpj?=
 =?utf-8?B?QllnczB3MS9JZkkxQW53UFBoclVYdTJDYmtmWDA5OW50WWFZVGx6K3U4VUd3?=
 =?utf-8?B?T3NqNTJUN1NLWU5ZaEU3U21YR05laFlVOEVZejVMeHl2VW9Hbm56a1dNOWww?=
 =?utf-8?B?Vi84TzZWZ0gwRW5xWE1aSml3MFBmc0RjdjRRcFpkMytTdHVpL2xYd083VDNU?=
 =?utf-8?B?UWd5azU2NFZnaXZMbDZYWG1uUU1FQWo5NWRMTkg3dHl6Q1dWY1g1QVZ1RWEr?=
 =?utf-8?B?eEQ1ZzBHdVhZU0twQlB1czVpSDZmZUtDMkRiY1ZlZ0lhaUNmODc3czlVQ3k2?=
 =?utf-8?B?WEF2TjRLR3AvcXFzdllmVmdGSC8vT1lkM2RJczJiVThEMmx5SjRGSGM4U0Vy?=
 =?utf-8?B?OTNEMlRHaENQSDJ5UDVRK2UvUlpxRi9wQ0hsNU91alZCY2FpNmhVMkJyTkZB?=
 =?utf-8?B?NTUrKzJqSEMwU082MzN1RG1sNWRxRCtvWWgrbTh3VVVmckpqY0p0NlQxZjRp?=
 =?utf-8?B?TDI5L3l3QUtpbjNKeVUzTVJXc1FKcTJ5R21oYkU4bVg4TnRNMmYwT2xKcUNH?=
 =?utf-8?B?TVFnMFdTbVUrUW8wM09mRzhsVFJGY0tZSkU0Rmd0dm40OW5zVWk2Y3ZRQ3VN?=
 =?utf-8?B?eHNIUGFoYVBCZTRZTGlDUzBHRGt2MWVGTnFDcTNwdVV4dkRDMFNJL0diWlV1?=
 =?utf-8?B?bWkzb29Rb1FNODRneno1Z0Q1ZjhDYU1DVU8vd2VyQVgrYWVHU2t4djVtUjNt?=
 =?utf-8?B?bGhmT1pMWjVDMmpqU2JvcGNUUlZkTWpiTlFTbmRwSWpwVWcxTis0cHBSV1VB?=
 =?utf-8?B?b3pJN1hXZUJ4M09sZXRJOU9PaURhazNseWEvZFFTeithVFRvTW1jUjhOdGhT?=
 =?utf-8?B?Z2hLaHJqY1JIU3AyN0RhMUlTYksxT29oMWZ6TDZTRHdxaEc5cytGOUhRSVBX?=
 =?utf-8?B?SDFpYkZWQWRmQkFDVlRMNGswWEJOQ0IvNW5BRUlidXM2YysyTkdUYmE0MElQ?=
 =?utf-8?B?ZjZSUHNxeVJOQ3pFQ25TanNqZEFoVmJVVW8wWUJhM1V3K0lBU1ZRc2d6Ni9G?=
 =?utf-8?B?NkN5dW15dGN5OWo2VHJHemtSMHhzcVBNM3pLcnBSNFlBOVZpMmhQd1ZLTjdW?=
 =?utf-8?B?cDJkazdqaWw2d2N4RFJCUjh2ZmpGN0M3TjFIR1dzd1REN1FjS1FZMG9WQ29t?=
 =?utf-8?B?RmNHUGZ5d1U0RGdkVUdHR0hna1Ztbk1yWjNxaldzZkFPeFhkOWVJMHozV1ZT?=
 =?utf-8?B?WmxHV0loNGo4Q3dHTVpCSnRaeXV4ZkJaSkIyNlU5QkEydndvRUNRd2NFVDBX?=
 =?utf-8?B?cWo4SlJNUG9pQlpueUNlYnhsNzUvMHpPNEQ3ZkJEWjdRbVcxeFBTWGRZZjNM?=
 =?utf-8?B?MUU3OUJPOWtad0FYYmhLRnh0bXJPcWFVejA0cmcwY3V6VjFnU3dQd09hekll?=
 =?utf-8?Q?BByhd5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZTRmJ1OVRnWkJEcVlMdlB3Vk5qeHZhS1VNdGl0b0VqOGJEV1FsZWMwaXlS?=
 =?utf-8?B?SGNLUnpIaWtMRm5LdWwybUo0WWZFbE5XcU8rR3VyQTVLa3NjTi9veFVzL292?=
 =?utf-8?B?cDJlUktib1pKaEQyQjRncFlKclFVTmM0YjZNak9odXVoUmRZT3FJK0lWaGpV?=
 =?utf-8?B?c0RuOG5kNzBCM1RMajdQZ1VnYmc5WEkrM1dBUHVkWDhZbGpDVVAzUnFjb0pT?=
 =?utf-8?B?akVHUVpJSlVaNEg1K3hHbGdXOVlWL01wR3R1bllxQWNXMnBYOWxUVlRtbTdV?=
 =?utf-8?B?a3JieFpGc2l0ck80ZjBYbCt2YmM3MklpN0ZQSzFkRXYyNFVpMmw0bDlnR3M3?=
 =?utf-8?B?NFM5bjRNM1VhVnFTazUxOUR2dnZveVNuZkVtTVAzTVJFVkh4S01BNkNrRWRS?=
 =?utf-8?B?blp3SEtQN1ZCVUxwS0grQVVISXpWeE9XWWpZcUpnUUJndStXV21pREt5L1FL?=
 =?utf-8?B?dTF3ZkJGdkNvV2dwNzZ2QkNWS3RGc1VVbXVvcUhzVDFJT1VRTzUrQ3ZQWU1s?=
 =?utf-8?B?d2t3SlFWNW5iejBkWFV4WUNQYUc4QTNxeGZ4c09jRnZCeVVmRTZ1MkNHOUhF?=
 =?utf-8?B?S0daYVZoOGNDUllJR1NFMmFKSkYvWHRrdWx6RWpWS0U3QUpVdnZEWXJZajVi?=
 =?utf-8?B?RjZpMlJVNDZaOTI2REdhVFpCdGhZb0NkS2tmb3U0cGNLWUdVbllTYjR4aWdG?=
 =?utf-8?B?cHJEVGxzcUVqOENLNGJZRnB3d3FFYkpNeVFMaHd4b01IcHFLdm1ZU0E5WmM1?=
 =?utf-8?B?bWd1LzQycmMwVk9sdEM5eFkwb2M2WEhtWVc3MUxEaldYSUliOG9JblBZaVg1?=
 =?utf-8?B?RHVKZHpkcDNMaEhvRnNPNUU2SU5QeS81QzU4V0JKZ1ZzQWttUVRzOWVScDVh?=
 =?utf-8?B?UFc4V0VHbGtWaU5JbURaOXA3dXJiZlI4UVRmcFpGb0ZVbHFodi80VDR2VzhL?=
 =?utf-8?B?NktHMGFlMlhFR3RHNjViSndIU3g3T3VPc1FIZ2pvbWNyYnpsQXRRMmpYZUJ0?=
 =?utf-8?B?ZjJsUyttb05UWU1GSVBsQ2hBY0NxdDltTnlxZ1VYaVRwdjBtNGFSakZDZFhl?=
 =?utf-8?B?V1ErNGRGbGs5Z29JQ3JLNVJRQWQyNG50Z2JEejN0L3hEV2diQ05aZ25NOWlW?=
 =?utf-8?B?OGY2UjdtMUptSTI0aUhLSzlUY1FOSzczRmVMV0hGQ1dvVlVXQ3pUTy9EWVB1?=
 =?utf-8?B?RnVyUk1xRE41aGJKUGZIRFZEOVkyeldTVHEzVEpYbEV2NHVuc0kxanJXc3h4?=
 =?utf-8?B?dHY4S3Z6LzFrSjh6V045a2M3eGVUMFh2WWFMSEJYNEZ3SVllbWgrVGQxYXdE?=
 =?utf-8?B?WXJCZU9YTTNYVEExTEJnQ1Q2OWk0VVFTYk5FbHVacUlncmhzYzY0M3ZVVHht?=
 =?utf-8?B?Rzh1RlhMSFBsQmxLVzVJZkJtcmVRTlI3KzZiQVg0a29id0NXbTdJSnRic1BB?=
 =?utf-8?B?R1JrTkgxVDZJeHVIbC9HQ2NaajM3U1RFV2tabjFCMzdTN3NQTWN5T3FJbkpJ?=
 =?utf-8?B?RTN1QldsV3c4QTNaaUJnLzBPQjI0ME1VZVRjaFFXcVdFQ2JVeHJvNnFiYmY2?=
 =?utf-8?B?cUZ0QzBQRXd0bklXNUN2eS9tc1haY0RUZ2I2Z21CWm03MnhGbGxlV2RVbTRm?=
 =?utf-8?B?R0xrVk9LMG5pVXlHYzMxZVkxTkdsais0eFNoczRwQ0dpS0d5VXo4UHhmOVNt?=
 =?utf-8?B?V0QxZWpQNmI1MlhrUUYzdFFHZ1dvaTdXb0dKSE1UcHJXU3V6Zk5TUjhKaTFD?=
 =?utf-8?B?M1NVVGx1aTNzSHRMQWFIdFBWM2kyZld4UHZYcU9hdFNUSTg5OGd3cW90NTQx?=
 =?utf-8?B?SEZaYmY1U043Z0xSaEI1RDh4TDJha2RFcXR0ZmE1dU9FNncvWTh6VnA5VmF4?=
 =?utf-8?B?YTZtN2xYenFueUpCK2RDWEdzeThZMEpiVFNvMk9yeWZTVGtwR2xPNk9RNmta?=
 =?utf-8?B?REVUQkZZZk5YcXY5ZHlzSTY5SFpqZUVGVFg4VU5kS1kvV1UrMjNwNGQ2MjBB?=
 =?utf-8?B?VmFHSElVOGY1cU51eXNSSjFrU1pMbGNmakZRM3Z4SWd5V1laNWhLam5LcmJs?=
 =?utf-8?B?UVJRMmkzbExFQ3RWUkZsRGFlUGRMTWFxTWRLb3ZSdGZJUUMyaW1tM0N6U0JJ?=
 =?utf-8?Q?NT5qMdix0arN2HMVzkc7F5oh/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24e2c9c-ed64-4465-9bf5-08de156847e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 14:51:15.9681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYJeUX0XOBzO4fCMaiAwCABdwx41OT8/7WHLneFSBBI7RDh5PanFoPqpnJg9BQDWN3d2J7Tcnk8RW/uAtngMiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
Received-SPF: permerror client-ip=52.101.52.67;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIwMjUgMTQ6MjYNCj4gVG86
IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29sb3RodW0NCj4g
PHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVt
dS1kZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdl
QHJlZGhhdC5jb207IE5hdGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9j
aHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFA
aGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJv
bkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5A
aW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5j
b20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxOS8yN10gaHcvYXJtL3NtbXV2My1hY2NlbDog
SW5zdGFsbCBTMSBieXBhc3MgaHdwdA0KPiBvbiByZXNldA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAx
MC8xNy8yNSAxOjE5IEFNLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4gT24gTW9uLCBTZXAgMjks
IDIwMjUgYXQgMDI6MzY6MzVQTSArMDEwMCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPj4g
V2hlbiB0aGUgZ3Vlc3QgcmVib290cyB3aXRoIGRldmljZXMgaW4gbmVzdGVkIG1vZGUgKFMxICsg
UzIpLCBhbnkNCj4gUUVNVS9VRUZJDQo+ID4+IGFjY2VzcyB0byB0aG9zZSBkZXZpY2VzIGNhbiBm
YWlsIGJlY2F1c2UgUzEgdHJhbnNsYXRpb24gaXMgbm90IHZhbGlkIGR1cmluZw0KPiA+PiB0aGUg
cmVib290LiBGb3IgZXhhbXBsZSwgYSBwYXNzdGhyb3VnaCBOVk1lIGRldmljZSBtYXkgaG9sZCBH
UlVCIGJvb3QNCj4gaW5mbw0KPiA+PiB0aGF0IFVFRkkgdHJpZXMgdG8gcmVhZCBkdXJpbmcgdGhl
IHJlYm9vdC4NCj4gPj4NCj4gPj4gU2V0IFMxIHRvIGJ5cGFzcyBtb2RlIGR1cmluZyByZXNldCB0
byBhdm9pZCBzdWNoIGZhaWx1cmVzLg0KPiA+IEdCUEEgaXMgc2V0IHRvIGJ5cGFzcyBvbiByZXNl
dCBzbyBJIHRoaW5rIGl0J3MgZmluZS4gWWV0LCBtYXliZSB0aGUNCj4gPiBjb2RlIHNob3VsZCBj
aGVjayB0aGF0Lg0KPiANCj4gc2hvdWxkbid0IHdlIGNoZWNrIGl0cyBhY3R1YWwgdmFsdWUgYmVm
b3JlIHNldHRpbmcgYnlwYXNzPw0KPiANCj4gQnkgdGhlIHdheSB0aGUgc3BlYyBzYXlzIGlzIEFC
T1JUIGlzIHNldCB0byAweDA6DQo+ICJEbyBub3QgYWJvcnQgaW5jb21pbmcgdHJhbnNhY3Rpb25z
LiBUcmFuc2FjdGlvbnMgYnlwYXNzIHRoZSBTTU1VIHdpdGgNCj4gYXR0cmlidXRlcyBnaXZlbiBi
eSBvdGhlciBmaWVsZHMgaW4gdGhpcyByZWdpc3Rlci4iDQo+IA0KPiBXb25kZXJpbmcgYWJvdXQg
dGhvc2UgYXR0cmlidXRlcyBhbmQgdGhleSBjYW4gYXBwbHkgb24gdGhlIGhvc3Q/DQoNClRoYXTi
gJlzIHJpZ2h0LiBUaGVyZSBhcmUgb3RoZXIgYXR0cmlidXRlcyB0aGVyZS4gQ3VycmVudGx5IGtl
cm5lbCBvbmx5DQpzdXBwb3J0LA0KDQoqIEBzdGU6IFRoZSBmaXJzdCB0d28gZG91YmxlIHdvcmRz
IG9mIHRoZSB1c2VyIHNwYWNlIFN0cmVhbSBUYWJsZSBFbnRyeSBmb3INCiAqICAgICAgIHRoZSB0
cmFuc2xhdGlvbi4gTXVzdCBiZSBsaXR0bGUtZW5kaWFuLg0KICogICAgICAgQWxsb3dlZCBmaWVs
ZHM6IChSZWZlciB0byAiNS4yIFN0cmVhbSBUYWJsZSBFbnRyeSIgaW4gU01NVXYzIEhXIFNwZWMp
DQogKiAgICAgICAtIHdvcmQtMDogViwgQ2ZnLCBTMUZtdCwgUzFDb250ZXh0UHRyLCBTMUNETWF4
DQogKiAgICAgICAtIHdvcmQtMTogRUFUUywgUzFEU1MsIFMxQ0lSLCBTMUNPUiwgUzFDU0gsIFMx
U1RBTExEDQoNCklmIG90aGVyIGF0dHJpYnV0ZXMgbWFrZSBzZW5zZSwgd2UgbWF5IGhhdmUgdG8g
dXBkYXRlIGtlcm5lbC4gSSB3aWxsIGFkZCBhIG5vdGUNCmhlcmUsIHNvIHRoYXQgd2UgY2FuIHVw
ZGF0ZSBpdCBpZiByZXF1aXJlZC4gSSB0aGluayBOaWNvbGluIGlzIGxvb2tpbmcgaW50byB0aGlz
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg0KDQoNCg==

