Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FE2CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLGaQ-0002Y1-PS; Tue, 18 Nov 2025 02:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vLGaM-0002Wu-Er; Tue, 18 Nov 2025 02:57:10 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vLGaJ-00027Q-Ka; Tue, 18 Nov 2025 02:57:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJnor08GPefcjL6qu1SWNSaag+XZ9PKAuw843I4FHnB0a8Ojmuo+7a5YnjBwY6IAm+4yaTQDavBt1OU98tOtXi7WQcmQRKb1+972k/Uw4BKvST7uZ42xb1KpwDJwJ7NXz5Ndr8AgIa3T3urBaJovP1M9dduQtGGgcufH4qC64qO+1xsTM/uy2r/8zxUFrLadBsQGy5LC74tSh4BVcWefufv8n90xPnFk/E7XrG8G2eJ+90aIlgOJbN81Wen92oygjae4OZPGEntY4Bt4/9ouvKSh3ca727LWozeM4Xw8+cZ/qq9roPWpPGMcgTcaRI5RK7C6GfTCIIF5zACSfA6KEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RdrYS1ay/W2S4uFDUXwBIpIcpXd8/njndcguAJaaMA=;
 b=BE4WFTKX+x32ErxUQeWj9z3kK45+B5Zvu2TW8zYWwp+E4bYTSEaoEjFBTW3m2dvPVLVgxmTU3ZO5oDKbsdUTpbbRuIrTQBIUY/YXqhzNf5LQccXCNQSnsOzgwIq1zH01GXmWoeg9xVDfrusJ6Pl0V+8pUEOCDXrvphJfXnLl338P0ND9sthjS/qBrZfFlf3KKFxJfdr/PkoLsSVUegCUTXXlYVSZZT+J3OeUudVAcK6Z6M4AW53EWMTxHl4mUo2IRJQyxrWZ/6mzni/sQUmChCtFDwLQq4mUVMJrX4OjxvCEfdMNAUeRUH+Ua4qZeLL77QdkS4qNanpcI5O1Z4wBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RdrYS1ay/W2S4uFDUXwBIpIcpXd8/njndcguAJaaMA=;
 b=NXiSmQCQj0tURt2PJTSI19uFsl94kTAxH8JdcXJ+9kUBgsLk+mgLB+2FEUxyiv/F04dfc2Zm43zw+CXEr8wiEtE9DjE/WEViCM/YqfD2mKPJqprln+rNwZ4wKQp6ZgjDwVUGTjgzvbAgmz+UO6nW29SqPuAUFlMfBFFPtIytNgaRsTbzVxNxi2/3ot8dWyGwaPaj7t6QKf+hFsH9XGtZ35dXOZO2ShFi0RcBDSRbOYgnI449sZLsjiy4S1lhM77OWZo4saC+80RZol3o1T6wXKGvTx/CDpRqFTJlG1r/lfPIT0mHuN50NPfD+rfVyMWBnfa+612igsOTHba9RaXOYA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:56:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:56:59 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based
 hwpt
Thread-Topic: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based
 hwpt
Thread-Index: AQHcWD5os7DYqlnHykS4mDYey1zwGrT4EM2w
Date: Tue, 18 Nov 2025 07:56:59 +0000
Message-ID: <CH3PR12MB7548AE8D724A8B4D8DABFDD4ABD6A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-15-skolothumtho@nvidia.com>
 <CABQgh9Fk2qHkHbpepY0j8MaLe-TkxrVaMi_R3C-oD2HihK-wGA@mail.gmail.com>
In-Reply-To: <CABQgh9Fk2qHkHbpepY0j8MaLe-TkxrVaMi_R3C-oD2HihK-wGA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW6PR12MB8833:EE_
x-ms-office365-filtering-correlation-id: af65c9d0-d496-4341-48f3-08de26780d1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bDlkaVJxUFhJUGNna0RiTGpPR3JsSHVaTnZXMXZSNmFaVWZmMlVWYkdiakoz?=
 =?utf-8?B?cGRJbmRQcXVTeWVNK3BWeXFUT2liWmFqaUtwSWViL3dRamFsb1k0RGlQak16?=
 =?utf-8?B?UzJKT0dENldoWFIrcHU0YXhJM0YxMWg5em9sZGVKQmFMRTg5NlZMTEd3dEVU?=
 =?utf-8?B?R0lncFFZWjB0VzlRejV3SEtHQjhibVdYWDNFd1FrWndRN3RiSko4ZzRneU5i?=
 =?utf-8?B?NHZKVm02RXQrR0pWdEpRMlJRTnc2TkxCam5ONkg3WGQ5Vk96TFpqaFp5Yzln?=
 =?utf-8?B?QUduNHZFTmE2R2J4akRnSitDNGIrVEdOWFVhcTZDSXMzM1M0SE52MjRoQlgv?=
 =?utf-8?B?SXBQck42VGk2aCtvOWdBeGdNd3pjc0dIaDBENmFtQWp2L01PTWtPZ0d0dkxa?=
 =?utf-8?B?RVRBTG9lRUllNkRxbFlra3ZYNzFNeHBkSVVlRmlMZFNmR3ZORFYzdmVCNmg4?=
 =?utf-8?B?RjVjQ3RrUXhqMjBvSXN1KytxRENHSFZoQkhSTHNlUVljSkJoVmhGeXhvZzFS?=
 =?utf-8?B?VlJ6N2dkWE91NGhQajhveEp4c1FyZHEvZjBJblpHNW85VTlqS3lWNDd1SmFV?=
 =?utf-8?B?SWRxTlNqcnJONWlyQldOVUFuK3orcmtDK3ZXenZwbHlWNGxNL2FWUHVENnBB?=
 =?utf-8?B?THZzTm90ZDhvdHh6NG1MbStlZStVUnl0Y0hrNWNBMVcwSnZ5bkVwM1pvTkx6?=
 =?utf-8?B?TXJUUjhwRnV2VW8rU2g1ZXYyU0ZaR3VETCtIQ1IwRzF3T251VU13cXh5TGoz?=
 =?utf-8?B?amhKT2hQNEt1ZE1ObnNpMmZhc0EzMmp4a3pRRkk4ZWZmbVo4cEkvRFcxQ0xa?=
 =?utf-8?B?UUE0bXJlRko4K3poY05RMVBzQ3lkMm5nZWYzbmVGLzh0ZkpVb2F4b2ZFOVJw?=
 =?utf-8?B?RE9FRnpVMDg0UmZOWkRyWjcwNnhxc2RpZG5FMVpwODJwY201cGxnaFczQ3VX?=
 =?utf-8?B?NmNZN1A2ZkUrLzRyMVp2RG1vMkRleEEvaUp1bmk3eVFGVEhrNmJkUThvZmU4?=
 =?utf-8?B?cTdZcGJNdVYyOFNwaFdOWFd4UUhoemQ0WmRwbWpZMDVzQVR0WVNlU3VEOFhZ?=
 =?utf-8?B?QWd1VDk3ek1zekN3MGNTVGE0RTg0L2NVNDZMcys3U0ljeVBobXp0eFAvZ1B5?=
 =?utf-8?B?c2QzcmZGUlBZRWNDN3ZadUkxcndpckI2WW95SFRhc0pXT0ZweFF4MHNpMHNY?=
 =?utf-8?B?RVN5M3U5VllyMDBNZ1Ivd3UwNzNTR3oxazg5TXhOSXBrK0RUZDFvNVQxUFQ5?=
 =?utf-8?B?UXZVQ0F2RmtObG00elBaWkptU3lWemI1aHM0T1p6bThJaHdicEpGZkZvWkIw?=
 =?utf-8?B?MU5uVFZ0amw2TUxYekZ4U3Fpa2hPMGI2UklOTkZtYUw2R1lOTWFhZkI0UDMw?=
 =?utf-8?B?RkE5amdtTWJnaU1aemNaa0xWMlZpdXROWDdDU1VPNUJiaVVQcDVJS0x5NVBS?=
 =?utf-8?B?OUVNcXovM24vaTJDLzltUnN3VDlPdUR2NnFEdlZCOExLdWZSZnFoRU1GNi93?=
 =?utf-8?B?d1Q4Wlh1NndqZW9mVThYVEIyMGFmSFhLTTZPcGpKUkU3OGtzcFpueVh2OW9I?=
 =?utf-8?B?STRheXdQZEdJVVhaQ0gybkFjT1FTK1p4d2Faay9yNXEzdHM1Q1pxRHBQamRv?=
 =?utf-8?B?Y0VJZnBHdnFrVzhTRHI3OVRrMDlvejViT21XbkpiQ2hFNkY5WExaaGE1YnJy?=
 =?utf-8?B?STNWU2FjSHUyajNRSStyY2wxSFdCUUdIWUFKV2lIcWdVWEZmT1lSRnBIVlM2?=
 =?utf-8?B?QmdmTWNWUFNqQzRROTFGOC9kUG0rdGZXdHB6bXFQZVFJdVhGOUIrTmlpV1Qx?=
 =?utf-8?B?ZFhTTWo0dFhaVHZmSEt4VEZJbllXSjdqaDFrVE0wTkF2bEV6dm5XOS95QVRY?=
 =?utf-8?B?dUp0bmplZUd6UEhUYnFiYVBIRVUyaEgyODgya0dyaEJHOGl4V1pLNEN6bXUy?=
 =?utf-8?B?L2pUcVlVc2o5eExhOFBaWFJGZzZvM1FVN21CQWdKcW54Qkp5cC9HUHYxUTRY?=
 =?utf-8?B?SjI0TFZjSXMyMGg2SDlBOCtjRHJ4SzN0SDVJSU82djhmZnNWek1RWExkbUJn?=
 =?utf-8?Q?gKT0pu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekRTVzVDZDRyNDNLaWhkY2RQaHlKYVc2M3RzdlQ1YWpvSFkvMWlXcCs2MVBp?=
 =?utf-8?B?VTd3ZXIrVEh3eFZGU1BPNm5hSDcrQ3hYVFdsVFJzaHdHVzZkdW04a2cwUXdW?=
 =?utf-8?B?QzgrQ3hPK1diWDBMbjYxQXEwTldGdmY2cXFxYTFrL3V6WklEUzcvMk5JeGFt?=
 =?utf-8?B?bFJOMWFPTFdYcytQN2FaUmFiUTFwUDhFVjhaclJPK0lKNDdvQ2JrdGtEWGQw?=
 =?utf-8?B?OExSL0grUUhGRi9ucHlkTzNoMTNnZFM5ZVJ5UHdBNUdtY214bVdEWmlSNnYx?=
 =?utf-8?B?dXZLd2lRMEU5RzBMYUQxSUVhMkxQcExqeHB4UU5BWk1RQ2Z3TVZFdGhGMGNB?=
 =?utf-8?B?UGtGMENMaHpRQjV2UzM2WVBWZEZLa2Fta0lCOUIxNmFoSjNOaEdYc0RLMGRJ?=
 =?utf-8?B?N25qbjhoYzVBQ3NTYUxsMGFyTnRUL09ZZnErK1hGNEsxQ2hIajQ4YlJNaEYv?=
 =?utf-8?B?MXRlN0dRQ3N2c21RU3A3QnJhVitoeTBBZzBJWkQzZmlUT1FrWXFWU3FtQVh4?=
 =?utf-8?B?V0ZHYms4Sk5Oa09HSWg2UzV0V3l2djBpZXh3THB2MVB1eHlBK1d2Rm8zNEZo?=
 =?utf-8?B?M1JLbDcwTWQ0QjJGbWxSbm52ZHFScVUzcTJpbmVqemNvUnVHdU9PKzhhVE02?=
 =?utf-8?B?Zzk4UG0rdDluZjBKNU1BT3JHWTlQRU1tL2gxRG5IY2lmaGNXWWFRZm5jVnFi?=
 =?utf-8?B?TnZaamVHWXcrN1JrekErMkZRWGJueDdzYnkrcjZrTUtHODZUbzJKMkpCelB6?=
 =?utf-8?B?M3pmT0l5KzMvcEdIMGVKUkNkN201YjMwUldzL2d6aHI0SmxKNHRuWE1hVlg3?=
 =?utf-8?B?a25KeW1ZTDEwRjVJaTduRUtrME1BSmFvRis0V3dSMEF3U0tCMkhWM0lDUzQy?=
 =?utf-8?B?V2g1dzZwK3czSDlOY1B2OEdLL0VZUlJQYWxCbjlKV0ZkU0ducmFvOFozOTd6?=
 =?utf-8?B?OTlob2twNVZDcGtzMCswRnkxMVhNOXYxMHh1VjcrVTNVeEdGVGx3ZnozcGpU?=
 =?utf-8?B?TVNtZTBpQTFzZ0RCY2dhdDFWeEtJWXluT2lBaVRid2htalNmclJuMWpIUDRH?=
 =?utf-8?B?M1pKVG11SUpBcHhrUk1LS0dBaDhoSGRIcUp0dFhuUGZ1dXRWWGk0M3p6N3B3?=
 =?utf-8?B?UkdhbHIwTERPZTZFTU4xWW10ZWRsQitVNGNLRXJWVFJlTy9DbkRLS1JieXg3?=
 =?utf-8?B?c0t4clA3YnF4L01US1ZsWnpIcFZaYTZ2ZjFYWHQ0UEJkbG1PMklJOENUeDVU?=
 =?utf-8?B?c1BEanpzdzVSL1RKZGNFZEZaeUhxVzVMU28vK0RWcWplRHJ0Tjd1UUV4cGo3?=
 =?utf-8?B?Z1lsL25vVWdHZEJyK0R1aFpLbEd4cVhtS0NJSGxuZi9XWW5Fc2M2N3FqUmRz?=
 =?utf-8?B?Ym55NjJYWUJRTjZmMkZ3UWRJZzhuWW8wTURnaVNqZzlHcWloNVVOak9iZVFH?=
 =?utf-8?B?dGFHeG9nQXo3QWx0RE8yb3VQTTdSWkpPelR3Y3lvdXFxMmw4bGtMUjdrVHk1?=
 =?utf-8?B?b2V5NnJHVlExTEFwSWVrd2RpVWNtaHBiajd6UUdOdHEyODU2K0dnTkdLbGw4?=
 =?utf-8?B?b0lNbGx4V3JEdVFBWTBuN2FGazZ3SFFKT1lWQ0FLUnY1ZnNhaWN5NzlUdVlk?=
 =?utf-8?B?YXY0WElGWDhUZS9mNllhTnN1R1pXZGluM3pzeXI4MEpDM1VPTjlLcE0yZmll?=
 =?utf-8?B?ODVkSXJnb243WStUeGI4V1lqZzI2c3FXUDAyQzhmSHREUzljRXZlNWRHTmJ2?=
 =?utf-8?B?TDlHc0Z4NURBWERwZFJ1OS9iZm9iSXFyYWx4d0ViOTYvejZFOHVPd0Q0R09R?=
 =?utf-8?B?TkR1WktxcnJtYUkvZHV1ZFdwQk5mbE9mNW1oZkFXRm5nSmZUZXA3YURUVHE5?=
 =?utf-8?B?MEpXdHZRMWZkVjY1WFNYOTBEYktEQXhja3pFYVErYWZGN1IrZVAzaEgvbjZo?=
 =?utf-8?B?a1RkdFEwdnRyVTdYYU1tR0tWV3pxWjVib3JaTjMydFE3TEltUWM4Rk5LT2k3?=
 =?utf-8?B?eEZRdGlUL3lKOGpSQXdBVHlQQjlJUEcyOWwrY0pidHNuNjVjeW9yeXliRE5q?=
 =?utf-8?B?dHBzTUVVVWpmQzR0MEpYUmtDSytYQmMveksyUFpzekF3SnlVZW1qYWgxVVNZ?=
 =?utf-8?Q?q3gFmhBsWFy1j7BkuIPNfZL/R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af65c9d0-d496-4341-48f3-08de26780d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:56:59.0787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJJbpa1wRwem990byrCppC9Cm2mUYLf2HXgFhgvkS4ATpVvAadprrVKnPSZh33dE/lHku/60To7PP09wIqP3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMTggTm92ZW1iZXIgMjAyNSAwMzo1MA0K
PiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IENjOiBx
ZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGVyaWMuYXVnZXJA
cmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUNCj4g
PGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4g
ZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbg0KPiA8
bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21v
c3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3Vu
QGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhlbnpob25nLmR1
YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtq
YWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTQvMzJdIGh3L2FybS9z
bW11djMtYWNjZWw6IEluc3RhbGwgU01NVXYzIEdCUEENCj4gYmFzZWQgaHdwdA0KPiANCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQoNClsuLi5dDQogDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGlmIChzLT5nYnBhICYgU01NVV9H
QlBBX0FCT1JUKSB7DQo+ID4gKyAgICAgICAgaHdwdF9pZCA9IHZzbW11LT5hYm9ydF9od3B0X2lk
Ow0KPiA+ICsgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICBod3B0X2lkID0gdnNtbXUtPmJ5cGFz
c19od3B0X2lkOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIFFMSVNUX0ZPUkVBQ0goYWNj
ZWxfZGV2LCAmdnNtbXUtPmRldmljZV9saXN0LCBuZXh0KSB7DQo+IHY0IGhhcyB0aGlzLCB3aGls
ZSB2NSByZW1vdmVzIGl0Lg0KPiAgICAgICAgICAgICAgaWYgKCFhY2NlbF9kZXYtPnZkZXYpDQo+
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gDQo+IFNvIEkgZ290IGEgd2FybmluZyB3aGVu
IGFjY2VsX2Rldi0+dmRldiA9IE5VTEwgaW4gdGhlIGJlZ2lubmluZy4NCj4gIkZhaWxlZCB0byBh
dHRhY2ggR0JQQSBod3B0IGlkIHh4IGZvciBkZXYgaWQgeHgiDQoNCkNvdWxkIHlvdSBwbGVhc2Ug
Y2hlY2sgeW91IGhhdmUgdGhpcyBrZXJuZWwgcGF0Y2ggYXBwbGllZCwNCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MTEwMzE3Mjc1NS4yMDI2MTQ1LTEtbmljb2xpbmNAbnZpZGlhLmNv
bS8NCg0KVGhpcyByZWxheGVzIHRoZSB2ZGV2IHJlcXVpcmVtZW50IGZvciBHQlBBIGJhc2VkIEhX
UFRzLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

