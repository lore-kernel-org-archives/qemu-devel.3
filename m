Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58028D3C912
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLnD-0005Rl-Gj; Wed, 10 Dec 2025 10:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTLnB-0005Qw-5l; Wed, 10 Dec 2025 10:07:49 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTLn9-0006yz-Dd; Wed, 10 Dec 2025 10:07:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvmXiKcdgU+4nSwp9KT70DeGo4K394t+nf4RH8StK7U1+w7zGtwR1dHv1txpC8rppbVHgldhT6leKeFdPPu9nFf+zHJpsQyfa/YzB5iRcx8OcttQDl7UA1+MpjTUsSZk5UecEtSAN2q2L+q/gqsZI7q2ja/wummdIQ56DPjQxfWCHcuoXhg4JE9qLVCZnP66YJK0JEdlFNiQ6IAreBUW8Zrj/K/4qvmTOidnJMn+PfCXRYxwPV7lWVFkjXTQL7PZD6WyttPTDgKLjJQ0S/9/nBHynbPWCPPvjZyV6sJgD25K/hHo8TfyaJOlaEjmuiOTs1/jNaNL/GBzHsH2ncW/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgXuZWE83WACWNzEACFh81t3Qs9wwAw3GB712n6izjE=;
 b=SDERs7tOsRAvjA7K904q63u3Ks5CtNxbm3kACVzGa/g+Amu40KYZ91s3Yedj4dGJbLWu3pCIL8ECYd0q10oKPGs3D0duI7JverA2HIsFirIQiRhuNPH7ppi5NUFVhMFmVDuWYhLjMIS0Dov0cew/G6130VKtdUuTMZXgbwfmpcDsx78gEK4LDq97qzwZ1Y6fZW/sA/F0xKasJ5zLmMgP2tYiDLX/x0xdKA1Cu2qnWPTS8G2K58Oi3TkYJ8Nsqy5E4HrzVqdMLBeyU+G1NDwSNY5F82jt/IpA+Pv52Jd1czByAIy9ZxHhtU8cS7k+IvumLxuk/3qO+9HntqowSuwwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgXuZWE83WACWNzEACFh81t3Qs9wwAw3GB712n6izjE=;
 b=Xwv/yLtgBkHEyKgOMD3WNNLGQaQyxBbCWdkmA078uM6n1buHLeTg8J/Um/orwJbQBmusF7T/emqDDj+er7WIJiF2VqWP/eQ0jAAQLki8OGpIJb8Noyf2ZZoXiOVBlzx99Hx+usALKoxpwNG+JWECZrOdhVDgG/mORhu6cl7inwBsZe+Z2Zc45iuXaczklsxufyGKfvDey8vTAijiGlDvGjTer9d5ejpv72ryPfylvkx3/vHDVCY+QxOVZvIuokxWjqrcij+zKahhbBDnxy0kcvylTSreXCLdlA7op9aPJ255E8XAQEcDmNnNJ/7fLs4twfz5lKbO/NSuaRGfPnKLBQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 15:07:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:07:39 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHcWiCazp4qsH43iU6000IVdgrRfrUZOceAgAHdIjA=
Date: Wed, 10 Dec 2025 15:07:39 +0000
Message-ID: <CH3PR12MB754885FC0E83EEB2A2D58D3AABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <1ee20ead-6978-4c2b-9b2f-ad778107ad04@redhat.com>
In-Reply-To: <1ee20ead-6978-4c2b-9b2f-ad778107ad04@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM6PR12MB4481:EE_
x-ms-office365-filtering-correlation-id: 1d800ecb-e2a8-44c2-cf60-08de37fddc81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?N082QW1GMUdYRFc1NkltdzNsRHRSNzhGUkpFOXFFcmExalI2TGdUbDBDNkI5?=
 =?utf-8?B?VGRCdDgzanRWR2g4NSswUjZqRkI1ekQ0N0JEeUNJMlhPajZHZ2oveE04MmU0?=
 =?utf-8?B?bmxmVU9RZDU2NTJza2x5T1pRb1hnNlZ4NEw0WGJ0QXlCNDRza1o5UndZaGxC?=
 =?utf-8?B?dXZxOUd1ZkZoNzA0eTZsdEZ6WE9wcEZkOGFkcUwzbmVaSDFHN3dRNndYaFRY?=
 =?utf-8?B?YUxHMEJabVNJaW16QTIvRENrbFZRbmpIRUlJUDRUcS83c2czQjFub3JGSUE0?=
 =?utf-8?B?eXVrK2lyMWRSUjcyWTQ3d1g0K250azJNSTB2VlB0UlplbFYrdVdhZGpVWE04?=
 =?utf-8?B?R0VaZFZOQnpubjdWQk03YTVnMGZnN0tjVGh6SUhvZW9BZ1RwN1NIMG01Nzk1?=
 =?utf-8?B?MFViRGZZRjNKR0JmOHlKS3cvcUVURHBTQjRWNDRIdE9xZDd4R1RtYVlzTWI5?=
 =?utf-8?B?bnZ2cGx0WHdYQzJZNXluc25HN0Q1VzRJVjNJQWE1Rlh1YWR2eEI2QmRxL0d3?=
 =?utf-8?B?UlZRVU5IaU5UaGhUaGdBZzdKZS9xa1RFSjlvTmJ3eUxNeDl0RGpES2VsSHN6?=
 =?utf-8?B?QTh0cm9wVjhzeFZnUW1qYVpVYUxqSlBNVjdBNCt4V3JUaXRKNFZqKzdRVWtF?=
 =?utf-8?B?M0dFdm5YMGYrUjlhb0hQMEp6dW1QeDBMZTNLb3VlaGJXM0dFbEhRUVpKSVBC?=
 =?utf-8?B?M1hKVk1SeFVMZy9aTEJvNjQ0QlQ4UFZrd1lrUU5XcVIwN1ptdW1aK1Q0WW9D?=
 =?utf-8?B?MHFEc2xGL2hkYWlzNHBBUEVuRjRJMzB2NzBoTFRQNDJRbi8ySTNpL3RIdFZy?=
 =?utf-8?B?MWR6OCtoaEU1ZG90VVROT3hFbnNxbVBWajJuZTZvUUdHdjlUL2oxelMvd3ZG?=
 =?utf-8?B?d0swd09NdXJlcHhCV1crbGFrUWM2Y2hqNU41TE1aUC9DenVFVlBlY2lIOWxy?=
 =?utf-8?B?amJJRFRLcVVOdHl0QUxuQitLVFVLQ1pFRGwvYm1yMnJMT2E2Y0hwRUxKQUNR?=
 =?utf-8?B?NkxOWHJ1SyswcTcxQjJLV1VYc2xMaTdJMHRrZG1CY094bVJJaUl5NjRhMEhr?=
 =?utf-8?B?dElmNWZ0d2N1bnpTWXFFVHJjeisyWUVEUlBJbE5NUjBrdVJrMW8rR00vLzVR?=
 =?utf-8?B?WTNzTFNudTgvUm16VEh5blNYTzBma2JObzc5d0RGRlNmeHFPK21GVExLY1hm?=
 =?utf-8?B?MUdVMGR2MTREWmlGS2h5RXNDRDI4enRSK1k3S0FTQm5mZmhYTnFuZmUzUXly?=
 =?utf-8?B?eFdYWVRML28xakFyU0M4emdqVWNmUjNUNE9mQi9vN1F1akwwa0VldWRZOGdw?=
 =?utf-8?B?ajM5clA0RlJUMlB0NTYvZ3ByanpYMkpMQlBZYmExeVloVytvejNUVjBWM1lL?=
 =?utf-8?B?bU94UkJ1U2Vkc0pTL2tyY3V4UGovQ3I1K1pGSmliWXByM0lxVVFNbGh2T3VV?=
 =?utf-8?B?Z3J0cmdLNmMwOURzZTdWUmdBblBDUkxBczdsZ3Bjb3NwZExzRkxmcnY1eTNG?=
 =?utf-8?B?ejFHcjRWZ1YwVVBWOUZld0hXSndOd3BtUXNhYVJBbmJ4ZXhjWVlBd2ZwWmxt?=
 =?utf-8?B?cmpYZW1wOS9LZUJGTTFBaU1ITEkzY3c2SGVOYUpLZWRuSUVnZnZZSnpkR01o?=
 =?utf-8?B?YXZ3ZDEwMno1KzBaUUxpRlVHRGFCaEprN3kzM2VYcFJUSEJrbjdNR1FlZDl2?=
 =?utf-8?B?YTZSTEpIbHFBRVZycVE4b2hhcUpnayswUHhPcjhTUDNiY200ZVRGbm5aZWxj?=
 =?utf-8?B?TlEzMlRHR2dnb3lrU2piSW5oQ056SUlXQ1JnWEwxM2k2UW4rV2hTcmdENXJH?=
 =?utf-8?B?bENva2pVc0ErcDlOd0tNZjdyKzIrNTdtaUI2ak1rOHY5blgxcjNvd3ZHcHFF?=
 =?utf-8?B?N3ZUb3NpOFRHOHhpS3I3R3h2N2ZTT25VZThCazdSMGl4TU9EdHhnRm56TUEr?=
 =?utf-8?B?K01lcW5uQTQwaTYwSng5TnpYbkN4dmlmdFR3WmlKSFQxam15bmN3N1UrdmQ2?=
 =?utf-8?B?cHV5UWFhanBNcVVNU3BhSXBNUE9qSTllMDdoY2tkb3VybDdDeEZBbmtqWVFI?=
 =?utf-8?Q?564Kci?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW0yeVJlSzVzaWpvdU5hSk5UUEp5cWxnYUdoNHd2bkdwUUpIajVkOHRrTzJI?=
 =?utf-8?B?TytwekdNUXZMKzlqSVlNdExrUHVvaXFjYUxvVGVlQmpBUitCbnQrNlQ1R1p1?=
 =?utf-8?B?cGZBSW1PS1h3SDlMbTRmdFJiMFlwQS8wOUZrV0sxMGY1bTBLK0d6dzBTcjV5?=
 =?utf-8?B?ekVWMENZeDhuNmpNZUlYOW1kb3oxTGY5TkFVeVlRZEJrakF1WGZYdzdob2ha?=
 =?utf-8?B?enJVSHBjNUNPQkRYb3JpY1NZK3pEM2NZemlnQnc3K01kZjFkUUlOVCt0UXJ5?=
 =?utf-8?B?b2N5Z21yMjJmZFRzQkF5NVh5T2RLaEZRK1BXMjVsOVNoenlPdnRyL1VIcWN2?=
 =?utf-8?B?K0ZHSE5ZUFN3NG9rR2djVGNQQzEzbmpmVWR2UHBidmY1UWlicUE2c0UzdW00?=
 =?utf-8?B?ZHR0MlByZ1FsSlJXNnFlSTJZSVRGaDExL2FIdkpjb3d3VG0vc2dmMHhReEtR?=
 =?utf-8?B?Yy9MNThpZUhQcEEzcXVTSnBUMEFoYzk0cmd0QWVHUUJmS3hnRkoxaVRYNHI3?=
 =?utf-8?B?Y29mWUU5NWkxc3ZqRTRJc2JtVW93bVBYTWc3SVhKYnRwdEtyVjBpM2ZwWjNT?=
 =?utf-8?B?M1JpYzNyWGpnSHJLTHc3bHRmek45S25RNytTOFIxZllIekwyREVBUWtrbjJw?=
 =?utf-8?B?MVpVRkpYdm42YjV0YWFmb1ZNMDBzekZVQjJ5MWJaZmRIMVhReTMyZjZXTkNp?=
 =?utf-8?B?TzFGR0dpVGJRbGRPRTJTTXR4cVlUQTJWTzcxSFpUTE5GRXVzTGlUOGxFejZY?=
 =?utf-8?B?NFNiM1Rma1Z2TDduVUY5MFhtQTR2RDBmaXpOeXJVeVc1SEwrS2hNYlZ3c1gx?=
 =?utf-8?B?L20rV0V4MlZ3YlBNVXAvOExtNHk4cEJOYzdZNmkxRkJCcFlSaGZUTzFZOEoy?=
 =?utf-8?B?bm9MT1JXM25zQTl0SjZCRW8xZFVjSTQ0SjRuOXY2TVpoeHRJVklBbFZsNWE0?=
 =?utf-8?B?MEJJbXZrNmMrbm9rTVJDdkhVV3FOREozL0pBUkF3ZVhNT3NBZnpTajRoT1Vm?=
 =?utf-8?B?ZFNqMExhN1g0cllmaTk4V0lLY3N0TURZT3A0VldEN1J6bElQQy9yZGdQZ3lP?=
 =?utf-8?B?ZS9TcFBBNkNwbWMyRUtjTS85ZTRkdUREcG15L0c5N1prMlF4bG0weHk5OFpT?=
 =?utf-8?B?THZWL0tjeU9pc3o3aklmVm5wYnFHdVFmYVlCbWVFb1pnOUg3VEFzeGU3QTZw?=
 =?utf-8?B?R0ZrTWl0SmNKTTBSaDhjRHlmQnlQWkFzN0R0TXBHUCt6NkdsTEFFUUxqTjV6?=
 =?utf-8?B?cVgzQmFLUnJNNEl5QytTSjNoYnhtTmRJZ2dVTmVBbWxsRDRqb1JKb0hGeWwy?=
 =?utf-8?B?TnJmN0N6MzZpbW9CL21xbjlvM0FRU2F1bzY0VkVTYVd6a3BlQmVGY3M2TzlK?=
 =?utf-8?B?M0U3RmltaVpiZ1pjYnQ1V3VzemwxL1o0blNGdjBNR2pUVmQ1R0YrM09RYkhP?=
 =?utf-8?B?bFJ5N1ZNeDhFTXcyQkFibEZnZzE2SHk2d25hWWdNTEpLbFVQSUZZaXEzQWRz?=
 =?utf-8?B?SHhmcE9FT1dQcGlPNUZoaENsSms3NHUvZWlWcDgydTJzeWxZbXFUb09BTTZC?=
 =?utf-8?B?ME1JRUJ3VTNrTjBqZFpYQm5wZzVrRzdKbVhaUC9wQ1J4ODR1UC9VRzgzOXRE?=
 =?utf-8?B?a0NjbjRUTHFtL3ZmVy9aN1lYNmZvRzVGWFFYQnB5cEhUK0tuNjRNaCsyVHY3?=
 =?utf-8?B?YkxoaDg5OS96Mllja1NmeEhtd3BGa0NGMWxiY1NhYUpvc2w0enZDOTcxakw5?=
 =?utf-8?B?VE1tVmpJKzhBVWpyNkVuREo4OVQrTHJxTGdwRFVGeEVjdUdBbHVSciswSURR?=
 =?utf-8?B?YnR2RVgzZzFVYVhtZUUvQjZBRWJnUG1Ca0JHc3dnR1k0WWpIZDI5U1FwSm9i?=
 =?utf-8?B?TzF6ejFOS2lWb29DbGIydFg2ajFjRUZ3K09DakRpNmhMZG4yQVNsOWptVUd5?=
 =?utf-8?B?blZSU3F5enhCNnFiZHlZalFmWEhrL3VjZCtnVnd1MTBNM2dTMHp0OEFkUFZT?=
 =?utf-8?B?WXEwOE9VTlFvZXFCUjVnd1gvRDRERWdvdkhRR0l4YmhRZTlVZDNtVUh2WitG?=
 =?utf-8?B?Y0czeitEbFdaUUwyaWtGZ1loTElzNS81bDM3UWIvWVEyaTBDdGdHa0UzU2xx?=
 =?utf-8?Q?C2VH8zY3CEY+WrdRLy6VWY+xF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d800ecb-e2a8-44c2-cf60-08de37fddc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 15:07:39.8730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aw/MoH+p8Cd3u2NrYqLr9cr3r783KDgGvr+1+F0LT109lcZI1l9q5GgtKU125wv8Cpl+E3RWiGHVjUNPtNeuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
Received-SPF: softfail client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAwOSBEZWNlbWJlciAyMDI1IDEwOjMyDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUNCj4gPGpn
Z0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1
dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbg0KPiA8bmF0
aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3Rh
ZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1
YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxp
bmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0K
PiBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY2IDAwLzMzXSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXItY3JlYXRhYmxl
DQo+IGFjY2VsZXJhdGVkIFNNTVV2Mw0KPiANClsuLi5dDQoNCj4gDQo+IEZZSSwgSSBhbSBzZWVp
bmcgY29uZmlndXJlIGVycm9ycyA6DQo+IA0KPiBUaGUgZm9sbG93aW5nIGNsYXVzZXMgd2VyZSBm
b3VuZCBmb3IgQVJNX1NNTVVWM19BQ0NFTA0KPiAgICAgIHNlbGVjdCBBUk1fU01NVVYzX0FDQ0VM
IGlmIEFSTV9WSVJUDQo+ICAgICAgY29uZmlnIEFSTV9TTU1VVjNfQUNDRUwgZGVwZW5kcyBvbiAo
QVJNX1NNTVVWMyAmJiBJT01NVUZEKQ0KDQotICAgIHNlbGVjdCBBUk1fU01NVVYzX0FDQ0VMDQor
ICAgIGltcGx5ICBBUk1fU01NVVYzX0FDQ0VMDQoNCnRoZSBhYm92ZSB3aWxsIGZpeCBpdD8NCg0K
PiANCj4gS2NvbmZpZ0RhdGFFcnJvcjogY29udHJhZGljdGlvbiBiZXR3ZWVuIGNsYXVzZXMgd2hl
biBzZXR0aW5nDQo+IEFSTV9TTU1VVjNfQUNDRUwNCg0KSnVzdCBjdXJpb3VzLCBob3cgdG8gdHJp
Z2dlciB0aGVzZSBlcnJvcnMgZWFzaWx5PyBBbnkgc2NyaXB0cz8NCg0KVGhhbmtzLA0KU2hhbWVl
cg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQo=

