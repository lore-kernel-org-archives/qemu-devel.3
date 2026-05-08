Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FA3CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLH7U-0001BM-Q1; Fri, 08 May 2026 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLH7T-0001B6-0s; Fri, 08 May 2026 05:03:39 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLH7R-00020l-8D; Fri, 08 May 2026 05:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmHHLuBZnY7ehk29grtGoN7zGaThWGe3+54Q1ojktf8C9FPfL6Dnx+rnLafsdf2pR78oYFoakJVv49OTBxlNUvQDLDIedgulvcv0R0JrviOB5rk0EwllYcK5rbpcLo0XYQxVfDx+qa59BXrIa/HxivroGYcChLQSZAwAAyGP67mAt4LDmKSvW9Du31PzYhfyzooIN9Lu6mBLeDAwanBDTSa28AwzRG4c50NTr2i+OWxyIz9PXnm67OUxesqf3s3NiABOitwYLCaA9MG0pQoB4c7KcSV89d04VsDdTx46QKQUzBHa7306p+36UC0BV9E4rW8StcKI/cTux9SfKSpdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRptLq/BuX3Gdsw0ybymwfVt55/AhhFvK0HnLIrb8P4=;
 b=v4IJpGjBQweBt0kt9EiziWbP0HSaUDOE+mVX/Wxuhqkvc0Th277Rbyj9jimT4MkpTi5nhypoLmm4juS0Iagl7uT3h8F2c0wiSdHEAtNw56yggOKI9qi8BRO1IBR9aGtQGg7yYh5uY3r9sF62nAmBucZtV1oCN0EV6mohNclmbcsBBaBl94KZiKMmO5hN0ITMQIOCWfqMG8Xaj63h2BRi/A3GzkyLPqvLg6RET1c9BwjhrjIC7QNtIEupm3YVU5qAVsui3WS2ybsEnIf1FbqWvZ97WT/61MQC2odCYPX2m9FfIGbp/mn7T39+IWGLH1R2UG5vXjuIrMTopKMSP9RHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRptLq/BuX3Gdsw0ybymwfVt55/AhhFvK0HnLIrb8P4=;
 b=H+isOMEZBwOggse3m+IZPNWkHTAyLtN8d0fURdpCRXqmIkiCGZLnvQf0ApiyEHSfULcTgioDQ1ny8j/VVutba9oqaSINyKuRjiJp+tXhYnL5jKpaG1l6iyeSWLQx3fqmbSCuMZ/QUUEhC0mw+o53GHbLD7VJr6s6XcCAy7AZzbXDQPFZ6N8GJzJtwCOETUUJjE6kIMy6xpEbJ2QNtsLsNj9l4kmk+Hu4tJ2ji0DU9mtrfwitcs3DdE+DJu0Jb2Qc15rBcOenq39ODgf1gFE8VIs/zAEylZtXs9Fdi3khOYauqdvJGjJNUe9v/nBMUb/iSghU/BpxFo7hEADTAmzwyw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:03:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 09:03:29 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Topic: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Index: AQHczMbEqU/zgTI+9ka08AG/nQw53LYBErsAgAAZPMCAAbZdgIABEU5g
Date: Fri, 8 May 2026 09:03:29 +0000
Message-ID: <CH3PR12MB75488E10D03A85E9F0C0D622AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-23-skolothumtho@nvidia.com>
 <4918654a-7c79-474b-9ede-5418460a5a76@redhat.com>
 <CH3PR12MB75486E45A43C6CD5A203D03BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <73730082-679d-4cee-afee-659684e420c2@redhat.com>
In-Reply-To: <73730082-679d-4cee-afee-659684e420c2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL3PR12MB6596:EE_
x-ms-office365-filtering-correlation-id: 64e61636-a44f-4d23-1377-08deace0ac5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ViWpXtnfR3FqInIwkRrenXKmPAw+7l9Oaj20nu2LQjDVGTdqK51Yh2GuBZTnqkw8jmrg7RMSc+Ryr4Y3MUx7I9cY3PIzTpmMa4F8jKLu2dsyyXJZ6tBT9b8RvMc9Js9LopEllXywN7eS+QCcI5fLlx2JMsS+Nh2jixjsRPD8lGrep/YetoQ159ea097cvD+wX1SIqunQc+zNJ6eQqIE7j8lNcvnvrMNSBIuddidBf1DprcYBzSi2BG2o6Atl8HRNtXePEcsaSwm8pq9cCPcLZfy8VpibPMWHHRM2n/scCz5xWsLvNS3ml7VdMscVmmGlS9v2paCuGq3qUMuWQcRMOOWsHKbGpC/vSwdMqBCT81TzoMw+aUjOmeAhaArWHK1RzcH6KxAkMDAACZv0ll4kWWnsnjC3CrSiHQSBgUFKmAR/nNoaEmID+rTXUs5z0xxmoWkM8UPmbK1DF9r0+5Q7dcMee7Mwc6wHxsiS/Dcx6hV+JfDsg7IdGh8DDeUiUAxJV/dppQojsZiaSpt4pXJsOi15XYBW8vh1VmbMXRHtjCe2DB0OFOb/kqjnPJoA0XunGHuLjglwbNFlMhvtgko99qBoTSBVDM35IesKOVf2RqMFWVAxan94ckAtLOhyp+gaZt6faH6ZBPqdvlMAviD2PwiZW4o6/tAOi1H1DGrUvGx2nn/mkw3pWWCtmdh1EHaOYYB95Dh2wIZ5s3LrGZdZNkLaerXy+kOrhrD1gKEjtb7T9YIWqsH+fb9HJWa+jpHu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0dYK3FSd0VYZnNBQXlRZ2lPSGVjSEVSdEZHTGJhL3YxWXpBVlhyMTF4Zyt2?=
 =?utf-8?B?Y2RKQlZCZTJHN244NGFIdU5XZGd1Uml6bm5UeEs0UFErdk9tM0dOaE9pTFpl?=
 =?utf-8?B?UTc1WUdZeHB4MUxYckYwSDB2QUhlcjRjK2hFQWQycG50Yk9GVm1vREZVMnYv?=
 =?utf-8?B?NG1pSDZWSHdYaVJlZWZwUzZTNUFiWnhURTNVNHhyWi84ak5tRVF0UDBCN2Vo?=
 =?utf-8?B?eGdRSFdtUldtWU9qMjFvSkNnNEVZcTh6cGNOQk5DajgyTjRybThncEthcy9U?=
 =?utf-8?B?T1NPcGlhbzhlb3dXNVRqekRBTVpDcEZNdTRGZzVYK3V2NnluNkcxR09KM2dp?=
 =?utf-8?B?QnRpb1lkNWUwWHhxcjVVUCt5UVZ0S1QxQlk1ZXpLS2tlREdRZGR6RFFHU2My?=
 =?utf-8?B?dktaSUNLaCtrMG8zNlhWYlYxaENvcXZrbmU0UWM2TURQcmR3ZU9qd25scGJx?=
 =?utf-8?B?SHZIMDhoY2xYTUxDd1VmT2x0NEhXS05xaGhoWnJTcE5rS2tGSmI2bkpPWmFk?=
 =?utf-8?B?M3RLM0J6Q1c0cDVpU3lkOFVIMGNYK24yVElYVzZMUmQ4TkhpcXVuWllFRkJt?=
 =?utf-8?B?eTM1U1NGZWtkQSt6VzIxM25ndis1T200VTd5T2hhc2hmL0VDbitpYkJQTzFx?=
 =?utf-8?B?MHBjOS9LWExLeFR2bExieno3Vzgxdmh5WmIxQnZTQUxDTEtrSU5iUUlmRTFX?=
 =?utf-8?B?OXNZR2JkWE9tWVZPTlBTWGFTT2YwYnhMY2x6QUdIR0doaysyejhjVm9kTTZX?=
 =?utf-8?B?NkZrYk5jKytRbE91M2VnNzFmNExOWjhGa2NKMmhkald2YzVLczBuVEdUTnkv?=
 =?utf-8?B?U1FxTWJKRmJiZG9tVHdjdUtHVEEzcDdvN2NaQ00zRlBqS3U2b3FBUkZaR0lX?=
 =?utf-8?B?eWc2cGpzYjBpZXplS0NoVlBGUzBKRnNJOEpLZE12d05yd0JSYnA1TGpvb1Iz?=
 =?utf-8?B?NDdoTWVRQ2paeFZ3NXQ2QmNWVldIdUdsTk5iS3RLcXJJOE5iM1BRR3JHa2RB?=
 =?utf-8?B?aGhNM2hzQVJvSEFzMWxFSEFJYUZLSWVqMlFwOElnTzBrR2lOM1FvbmNIM2xx?=
 =?utf-8?B?V29jM3dWeFB4MVQ4MFJuZlRXRmJFYmRoY254eGJ6NFBCZms2Z001UlNFUkhH?=
 =?utf-8?B?aDdWdHkzNXprZGlpVEIwUFovSE43dERLeXNBYThSQ0ZDTlEyeE4vNlMrak0y?=
 =?utf-8?B?U0MyQmh3cU1RWWJTRy93RWJza2I2Qm9Zb1V5V2hWd1pmaXFIYTladEJZekZD?=
 =?utf-8?B?S3puRHZrQm4vMSs0WkJ1NGc0UTdvaWFXMU5TV0dMT0ZTOEFUUzJaZndMV1Nr?=
 =?utf-8?B?SHFTOWs0Q2k0OFNIUTJuZ2FKU1ZFNFI1M2FyRTJVbUVodDgyWnBsRVdxVXg5?=
 =?utf-8?B?a3ZEMUZyZUVrUUZVbDRxR1pJRGo2QzZzaEFjTkNZOFFaYlF1cjVYRWlrZUth?=
 =?utf-8?B?a3U3NDNudlNhKy9tNmorWlBvVUJXaGt4UDJjbGdSWEtEcWNVQ21maEE3WFVm?=
 =?utf-8?B?cFJ5STYwZlJZQUgxdHNlaTlWeWswUU9KT2tnNnNLVmNZQTB1QVFGajRzMU5O?=
 =?utf-8?B?Mm1IVFNDK3NHVUNwalZ1Syt0anBxWjkxSXJjTjRJYVBHT3l6cHhzVHVmSTI2?=
 =?utf-8?B?TDN4MzQxNmhUd0lxYmZxYUQxT2ZadnYxallhMHU1REFLVFNUblBsQTdxZGh1?=
 =?utf-8?B?K0tPYnBPYXRVRVhpSzBzc0JzOWpxYXFjRy9lalh2VTZCTHg5V255TVNvTWVT?=
 =?utf-8?B?cnhvaXlETXJ1SEVmZDd4blExZGhsZzc2MkNrOEFlNkNWNWhzQ0oyM3VWZTBo?=
 =?utf-8?B?OHhuNDc0YkQrSmNDcEFGNGFNU3hyK01oc3d6YWQ0NkZvRVJVZmVCWGl5WkMx?=
 =?utf-8?B?dS91RHIwRG1JQW9yWGw5SVdYS0hjemhaODlGTStsQm1zekU2Mlp5azB3RGlo?=
 =?utf-8?B?OXo2ZTF5VEg0YlZ3cXBjSTd3MVZkaVh1MUY5eEFpY0RQM0tTVDMxMWpnYVE2?=
 =?utf-8?B?bVdIT3dwb1Y5TEpRWFdaeVM4MjBuSnZLWHdnTVVVSm42ZWtONm5mNTMyS2xp?=
 =?utf-8?B?N1RpTEs3RWVhTlVRdWJpQjVmeHJ4cU04Vi8wWC91SmRUeithL0lYSlhQcXdz?=
 =?utf-8?B?R0gyOHZKK1o0aFpNQUJ3K1d3NDZvTUVrM2FVOUkwc2Z4dWlpQVFiUFVoUi81?=
 =?utf-8?B?Smp3b3VwVi9UMGx0Y1AxbzFBa2xkb0ZUSHhiK0pDVVROaFVVZit2OGlXVEo4?=
 =?utf-8?B?ZTNrRkIvZEJzTG1TT1dCdzZ1MTJJWHk0KzlFRlhoZDVrbGR2VFh6czJkMXhr?=
 =?utf-8?B?REFYd2xoK2ZGQUpORGFZbitCdHNGc2I0R3JFN2xxUXY5cnNWb1M5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e61636-a44f-4d23-1377-08deace0ac5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:03:29.7508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YdViTlARp9JOa+bPDA+GfVxY4r76IChPiiX/dP/dGmWBEdu0UI9Hk8SaPyvRhtQag+5IJBoTlpVt3tWKLm18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA3IE1heSAyMDI2IDE3OjI0DQo+
IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFl
bXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4g
PGphbkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpv
bmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBL
cmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPjsNCj4gcGhyZGluYUByZWRoYXQuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjIvMzFdIGh3L2FybS90ZWdyYTI0MS1jbWRxdjog
TWFwIFZJTlRGIHBhZ2UwDQo+IGludG8gZ3Vlc3QgTU1JTyBzcGFjZQ0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiA1LzYvMjYgNDoyNCBQTSwgU2hhbWVlciBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPiBI
aSBFcmljLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogMDYgTWF5IDIw
MjYgMTM6NDUNCj4gPj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0Bu
dmlkaWEuY29tPjsgcWVtdS0NCj4gPj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KPiA+PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBjbGdAcmVkaGF0LmNvbTsg
YWxleEBzaGF6Ym90Lm9yZzsgTmljb2xpbg0KPiA+PiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29t
PjsgTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQNCj4gPj4gT2NocyA8bW9j
aHNAbnZpZGlhLmNvbT47IEppYW5kaSBBbiA8amFuQG52aWRpYS5jb20+OyBKYXNvbg0KPiBHdW50
aG9ycGUNCj4gPj4gPGpnZ0BudmlkaWEuY29tPjsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
Ow0KPiA+PiB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUgPGtqYWp1
QG52aWRpYS5jb20+Ow0KPiA+PiBwaHJkaW5hQHJlZGhhdC5jb20NCj4gPj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NCAyMi8zMV0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2OiBNYXAgVklOVEYgcGFnZTAN
Cj4gPj4gaW50byBndWVzdCBNTUlPIHNwYWNlDQo+ID4+DQo+ID4+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4+DQo+ID4+DQo+ID4+
IEhpIFNoYW1lZXIsDQo+ID4+DQo+ID4+IE9uIDQvMTUvMjYgMTI6NTUgUE0sIFNoYW1lZXIgS29s
b3RodW0gd3JvdGU6DQo+ID4+PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+DQo+ID4+Pg0KPiA+Pj4gT25jZSBhIFZDTURRIGlzIGFsbG9jYXRlZCwgbWFwIHRoZSBtbWFw
J2QgdmludGZfcGFnZTAgcmVnaW9uIGRpcmVjdGx5DQo+ID4+PiBpbnRvIHRoZSBndWVzdC12aXNp
YmxlIE1NSU8gc3BhY2UgYXQgb2Zmc2V0IDB4MzAwMDAgYXMgYSBSQU0tYmFja2VkDQo+ID4+PiBN
ZW1vcnlSZWdpb24uIFRoaXMgZWxpbWluYXRlcyBRRU1VIHRyYXBwaW5nIGZvciBob3QtcGF0aCBD
T05TL1BST0QNCj4gPj4+IGluZGV4IHVwZGF0ZXMuDQo+ID4+Pg0KPiA+Pj4gQWZ0ZXIgdGhpcyBw
YXRjaCwgdGhlIHR3byBWQ01EUSBhcGVydHVyZXMgdXNlIGRpZmZlcmVudCBhY2Nlc3MgcGF0aHM6
DQo+ID4+PiB0aGUgZGlyZWN0IGFwZXJ0dXJlICgweDEwMDAwKSByZW1haW5zIFFFTVUtdHJhcHBl
ZCBhbmQgd3JpdGVzIHZpYQ0KPiA+Pj4gdmludGZfcHRyLCB3aGlsZSB0aGUgVkkgYXBlcnR1cmUg
KDB4MzAwMDApIGlzIGEgZGlyZWN0IGd1ZXN0IFJBTQ0KPiA+Pj4gbWFwcGluZy4gQm90aCBwYXRo
cyB3cml0ZSB0byB0aGUgc2FtZSB1bmRlcmx5aW5nIHZpbnRmX3BhZ2UwIG1lbW9yeSwNCj4gPj4+
IHNvIG5vIHN5bmNocm9uaXNhdGlvbiBiZXR3ZWVuIHRoZSBhcGVydHVyZXMgaXMgbmVlZGVkLg0K
PiA+PiBJIGZhaWwgdG8gdW5kZXJzdGFuZCB3aGVuIHRoZSBwcmV2aW91cyB0cmFwcGVkIHBhdGgg
dXNpbmcgcHRyIGluDQo+ID4+IHRlZ3JhMjQxX2NtZHF2X3JlYWQvd3JpdGVfdmNtZHEgZ2V0cyB1
c2VkIHZlcnN1cyB0aGF0IHBhdGguIElzIGl0DQo+ID4+IGV2ZW50dWFsbHkgdXNlZD8NCj4gPiBU
aGUgc3BlYyBkb2VzIG5vdCBwcmV2ZW50IGEgZ3Vlc3QgZnJvbSB1c2luZyB0aGUgMHgxMDAwMCBw
YXRoIGZvcg0KPiBhbGxvY2F0ZWQNCj4gPiBWQ01EUXMsIHNvIHRoZSB0cmFwIHBhdGggcmVtYWlu
cyB2YWxpZCBhbmQgUUVNVSBmb3J3YXJkcyB0aG9zZSBhY2Nlc3Nlcw0KPiB0bw0KPiA+IHRoZSBt
bWFwJ2QgdmludGZfcGFnZTAgdmlhIHZpbnRmX3B0ci4NCj4gPg0KPiA+IFdlIGNhbm5vdCBtYXAg
MHgxMDAwMCBkaXJlY3RseSB0byB0aGUgZ3Vlc3QgYXMgUkFNIGJlY2F1c2UgdGhlIGtlcm5lbA0K
PiA+IG1tYXAgb25seSBiYWNrcyBWQ01EUXMgYWN0dWFsbHkgYWxsb2NhdGVkIHZpYSBIV19RVUVV
RSBpb2N0bC4gSWYgdGhlDQo+ID4gZ3Vlc3QgYWxsb2NhdGVzIG9ubHkgMSBvZiAyIFZDTURRcywg
ZXhwb3NpbmcgdGhlIGZ1bGwgZGlyZWN0IGFwZXJ0dXJlIHBhZ2UwDQo+ID4gYXMgUkFNIHdvdWxk
IGdpdmUgdGhlIGd1ZXN0IGFjY2VzcyB0byB1bmFsbG9jYXRlZCBWQ01EUSBzbG90cy4gSGVuY2Us
IGl0DQo+ID4gcmVtYWlucyB0cmFwcGVkIGFuZCBRRU1VIG9ubHkgZndkcyB0byB2aW50ZiBwYWdl
MCBmb3IgYWxsb2NhdGVkIHF1ZXVlcy4NCj4gQWN0dWFsbHkgbXkgcXVlc3Rpb24gcmF0aGVyIHdh
cyB3aHkgZG9uJ3Qgd2UgdXNlIGEgc3VicmVnaW9uX292ZXJsYXAgZm9yDQo+IGdsb2JhbCB2Y21k
cSBwYWdlMCwgbWFwcGluZyB0byB2aW50Zl9wYWdlMCBvbmNlIGNtZHF2LT52aW50Zl9wYWdlMCBp
cw0KPiBzZXQsIGp1c3QgYXMgd2UgZG8gZm9yIFZJTlRGMCBwYWdlMD8gSSB1bmRlcnN0YW5kDQo+
IHRlZ3JhMjQxX2NtZHF2X3JlYWQvd3JpdGVfdmNtZHEgd291bGQgcmV0dXJuIHRoZSBzYW1lIGNv
bnRlbnQgYW55d2F5Lg0KDQpUaGlzIGlzIG15IHVuZGVyc3RhbmRpbmcgd2h5IHdlIGNhbm5vdCBt
YXAgZGlyZWN0IFZDTURRIGFwZXJ0dXJlKDB4MTAwMDApDQp0byB2aW50Zl9wYWdlMDoNCg0KIC0g
VW5hbGxvY2F0ZWQgVkNNRFFzIGFjY2Vzc2VkIHZpYSB2aW50Zl9wYWdlMCBnZXQgImFjY2VzcyBk
cm9wcGVkIHdpdGggbm8NCiAgICBGYXVsdC9JbnRlcnJ1cHQiIGJlaGF2aW91ciBwZXIgc3BlYygo
cC4xNzIpDQoNCiAtIE1hcHBpbmcgdGhlIGRpcmVjdCBWQ01EUSBhcGVydHVyZSAoMHgxMDAwMCkg
dG8gdmludGZfcGFnZTAgd291bGQgcmVwbGljYXRlDQogICB0aGlzIGJlaGF2aW91ciBmb3IgdW5h
bGxvY2F0ZWQgVkNNRFEgYWNjZXNzZXMgdmlhIHRoZSBkaXJlY3QgYXBlcnR1cmUgdG9vLg0KDQog
LSBIb3dldmVyLCBwZXIgc3BlYyBwLjE3Niwgc29mdHdhcmUgY2FuIHByb2dyYW0gVkNNRFFzIHZp
YSB0aGUgZGlyZWN0DQogICBWQ01EUSBhcGVydHVyZSB3aXRob3V0IGdvaW5nIHRocm91Z2ggdGhl
IFZJTlRGLiBNYXBwaW5nIHZpbnRmX3BhZ2UwDQogICBhdCAweDEwMDAwIHZpb2xhdGVzIHRoaXMu
IA0KDQogIC0gUGFydGlhbCBhbGxvY2F0aW9uIGNhc2UgKFZDTURRMCBhbGxvY2F0ZWQsIFZDTURR
MSBub3QpOiB0aGUgdHJhcCBjb3JyZWN0bHkNCiAgICBzZXJ2ZXMgVkNNRFExIGFjY2Vzc2VzIGZy
b20gUUVNVSBjYWNoZSB3aGlsZSBmb3J3YXJkaW5nIFZDTURRMCBhY2Nlc3Nlcw0KICAgIHRvIHZp
bnRmX3BhZ2UwLiBBIGRpcmVjdCBSQU0gbWFwcGluZyBjYW5ub3QgbWFrZSB0aGlzIGRpc3RpbmN0
aW9uLg0KDQo+IA0KPiBCZXNpZGVzLCBJIHdvdWxkIHJlY29tbWVuZCB0aGF0IGFsbCBvdmVyIHRo
ZSBjb2RlLCBwYWdlMCBhbmQgcGFnZTEgYXJlDQo+IGNsZWFybHkgZGlmZmVyZW50aWF0ZWQgaW4g
dGVybXMgb2YgYWNjZXNzb3JzIGFuZCBjb21tZW50cyBhbmQgd2UgdXNlIHRoZQ0KPiBzYW1lIHRl
cm1pbm9sb2d5IHRocm91Z2ggdGhlIGNvZGUgZm9yIGdsb2JhbCB2Y21kcSBhbmQgdmludGYgdmNt
ZHFzLg0KDQpTdXJlLiBJIHdpbGwgYWRkcmVzcyB0aGlzLg0KDQpUaGFua3MsDQpTaGFtZWVyDQoN
Cg==

