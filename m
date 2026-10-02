Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CA1CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdfV-0001X6-VC; Fri, 02 Oct 2026 09:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCdfK-0001RB-J0; Fri, 02 Oct 2026 09:51:11 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCdfH-0006Vc-R2; Fri, 02 Oct 2026 09:51:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfSrWZbWBdyktMJtBUeJhmTsk8OHu7I5DFgo9e62ZetgEAEh5e53gqcHZ6YIOMF5k6+BS2L9+2O4ERNh9h4BAT772ncFb5Cg3yM5e0JSkuXEDV8gkshKTDT15DTRH/P6HDxs3kRshSzZ1UuUtsj4zrPctCkXIeLWY83QVSGgPSJS6F123rMC0fd594qnbdsASAe94+bcuZngopB9XYpUyYMJ/aIvq+UEYWIqFoJtmrqOzwMEi/J77+KPNySdOk5Vx5j1NjqS7ZMfv6mz2qFPRa/Tq0bipwoXLenLp+r60J/AMog7NVoX8dxykDqmGqmW6x2yJsh+VaIH6tefBCGd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuxAyZ4s3+fu823shSsBe4rV6BaOGHEGSUCAI2mk0vM=;
 b=nGFsuySkFmZSNuTp3v6rrtZajgZ1m7kjouFzs1aZSGoIlLfGQWampd8KxyvZzeovGoNC7H75gexiOeDDfuDd8e3N01EkJwC/wAvrpZZqC46Oae9JUxrd7dIg+YtLo9i6XXXycSK/Jab7mZ+0Tlt1D9vC7/qOQDOfZrtD7WbbFZqMvv0i3tHuPrr+cE17f59IroSsz7r9kx5yljGOBZpEE+tKb1BIXKiGLfHHoFfbw+XczAXphQ/CX/nkjvDk2jkCGFlhZY1z/c5OI7Vy2ZR0mhQ7cbcxzSYIwSF2EwjIi5iapxvSz7ukjHqkRdSS2psX0Hf8KQG2qE5gQ9GvQnHLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuxAyZ4s3+fu823shSsBe4rV6BaOGHEGSUCAI2mk0vM=;
 b=pUhrZ2pskVYx2ILqi3tTalsg/Gnr53CznqNso0u80HF5BBuSjUoHP+VGECiGqS2jxtCdsccYYMCtdgTLGKpdRHUe47jBKe3PtI7u24IhW1p5Ud0DkXZbbART3T9ZwFVx0P6DrJRm2Pu0r7x5J3FypPJuhWPh/AamCLv50yrnfAw2OCcAvm48yB5iFWTnSlL0dFaG9M1ZUc+ZLVs6Ezzhqv7aR8ytFK5Omraj4CVAjt7jVjSOP2v+GwyRw3KZcLUhgb3PTOMSizFNiLPHPBz9O7RTerqxuZE9f6xcP4MGyxRfoJEGjbYrBOj6YDjZxy/qdGVSjSbnuQ5DRWpYm18UiQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:50:59 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 13:50:59 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>
Subject: RE: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
Thread-Topic: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
Thread-Index: AQHdPJgnxFHep9flGkG9ZpJw3a7LcbbpDgeAgAFhSEA=
Date: Fri, 2 Oct 2026 13:50:58 +0000
Message-ID: <SJ0PR12MB861462DCC5C7F9E93E6C2379AB892@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <cfca1664-2d41-4f02-b7cc-6e0e421426cc@redhat.com>
In-Reply-To: <cfca1664-2d41-4f02-b7cc-6e0e421426cc@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SA1PR12MB9546:EE_
x-ms-office365-filtering-correlation-id: 93424df9-470a-4d3b-f049-08df208c306d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|5023799004|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 5CCSkj21PdfuOjO31ZgNRN6zheVJclXceuUJIZBHStuiJpqDOuY1YXWuJGdfeMG5SJgE7BuP/I5FbCAn8Vnhsrvi7SUN50fJ88QTaK6x7t9BYFpLT/nL5ZFw5usYiKjHWQw2FlQleiZBDsudZhNA/844xcZ3iYLBH19hOzxCpuNJbKWcgjHhyEsQiX0Gu0qW43TacbBXY+1S6/Dt5sIH6/pCr0cfSQGtU+sTdxcIFK7lc8SEKCC7uzPZUUgf4CwzpG336/3W8NYi1l8WrH9UDnb78VHzckLxPYpw67gy+/hn8odAFc+dCU3F84MmK4F/QiBbx/6o4Nd/M8FVPIo1nRaidxbKFegfLyWOuwcayhgrdfu4DBfoy9iPaUQYbms7R9mFnog8kY9R4JjtwuYCtmWkJhTE7tdZYDg9ktSfSWCp1JMNshiV66tM9/GFlkc/ZnbdkeEGWL2r/wPniN+WxY73eBQNOxiduxZ8LhtGE1J+GaXuehzXhW4NyaMKqyLo7eOioetT22TOKO7eF7qvdAd79zAg+vnaPQv37pC0S0tepy/wt1K6SvG5qa2I9RTMXgDMuuCNEvh4oc2B/ZOGerBKOTVyC/LzLIsa2Zr6BEbRoKz0KjI9ioWlTthDMfI5JMpVw0uulVCoxOA+8k6r5DDPuZP62+wW/22gMCVS/RmiuS0PvzgeHqAimgXD1X3ZFd9VKO0829fm9kheIXVTAlD/plaV1e/bhG0u0nHL1Ro=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(5023799004)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTZ1ZDh1cThMMEFEbXJqaXRKbkJQSVhaRHo1MUlsUGpiOGtxeER2WG9uS2Mv?=
 =?utf-8?B?Q09OSG9DZnpaeE1BSndaZWRBWDVrTHJObFBERytSZ281bmVKNlp3QkhuSEtl?=
 =?utf-8?B?bmdGTUVNMjREb0p2clpuMEthVUhMbVFtb2c3TmxJa0tEbS8wNFBjTS9CK0xv?=
 =?utf-8?B?WUo1ckREbjljck1QaXpjaVR1MFZXVWRRbEZidUFvS05GMGZOWTVqbmpXYjVU?=
 =?utf-8?B?UUNPUUhucE1NK0lOV1Fqc29hN0VvL2xoK0xBSzlOTU9Mb0VHOGVNZk9PV2RK?=
 =?utf-8?B?eUtmM0RyN0hUZkRCWUVLTk5NeG9iQWowQWxTWkxaakNiZ2tBSElYbDVyK25R?=
 =?utf-8?B?eDZxdlk3NmJVckZYc0x0N2hLQXlSbXdIbGhlTnJvdEE4QS9hdmo1YlM2Zjlk?=
 =?utf-8?B?Vld5WllKTGFkUGZZRTIxckdybXBFN0pWaEVRWGxrMG1LNC8rMDh0N3dHSWdy?=
 =?utf-8?B?Ym91TEFBSlloQWFOcnIxR2hFRllTNXNGcHRSZzJ2ZktsbzI3cUdKT1hvT1Q5?=
 =?utf-8?B?OUtBNFVzb3h5L3crbGNhMUgzWk5WS0V1ZHp6d0toRG5KYmlzVTR4VTRHWHBt?=
 =?utf-8?B?UHRmQVFsN3E0VFdUUHJ0bTR5UVpLZklvTW10V1RGVUxycWp3UVNxeVBwUk5I?=
 =?utf-8?B?Yzk0M1IvNUlpaUc0ZVlpM2taSzh2M1U4UWltR1NpSDZSUkJ4SGx0M3Bqb3k5?=
 =?utf-8?B?QjZRRzNZRFg5UVF0MXdDaUg5cjdHVmc5Z3dxWXRxeVdQSEoya3lON3YrbWxT?=
 =?utf-8?B?cERoNUxLa1BrVllaeVhMODM4d2JYMmRmSjFqWFpBenQ0MllvaHZsVUZiY0Rn?=
 =?utf-8?B?SjBuTGhNbk4xa2xobSt1YXphc1pqRzZtd1AxMVkySnBvZzFUcElZd1hqdFIv?=
 =?utf-8?B?VnIwbEwyellyb09Ba0pwdFBzY0taalpSbjhLb3J3V3JnN0tNNW5sWlRTTW5n?=
 =?utf-8?B?MXg3U09qSG5TMFJUMlNzbmdzb2NSNTJkS1A4b2RSMGdseTcwQWlZVEorb1FX?=
 =?utf-8?B?NmVWeGM4UGcrdFY2U09US3VVZVQxR1ZTbDEyazZFSk45Rk12TjFhWUZYaTRz?=
 =?utf-8?B?SlRJTEp2QzdKTTRycjNlR1dJUFhnU2xBTEhRWDVGTGlSZmUyQ0M5dGZxK0hH?=
 =?utf-8?B?UGtDWHpHUUNTSUxnVTlXdzdTT3dIUkFCUGNVRkVwVHVncjVEMlBPYlpmTVlN?=
 =?utf-8?B?cXpxOWh6MHAyNmR1ZUMvTDZJQ1JxZzhmMFAzVE5FL3pKa2JxOWVlSzNReUQ2?=
 =?utf-8?B?K093cTAyTUdFdTVLcnBXdlU0dEUwdGt1OFd5eUlNdi9tL3hRN1J6d2YxOXY5?=
 =?utf-8?B?TGZZS0ZpSmU0UzhXNGl0Q3dmd0VzdGhaSENjdHR0VUxrNTF0WFYzcFp6anF4?=
 =?utf-8?B?enBaa3ZMd2pRU3lMNkVtSk52a2hyMXpldmJBMEFxeTZTcXEzalVqcHptcUlU?=
 =?utf-8?B?b0hGci8vZit1Nm95RFFRTGRtZEhReVFpYUFrU2lsNnBhNUMyb2tTalZyZmxV?=
 =?utf-8?B?WS83L1VUL3NaT0xzTjFNalBBeW51WnQ3QklnbXZnaXo1RHhTOGhPWkxuMFpX?=
 =?utf-8?B?QktRVWx4YkV1UWtNZlYvbmpBL0NGaWpLYzJtV0hzWWN4TVIxeVB3Nm1HSktN?=
 =?utf-8?B?SnNjV2JncU9WRU90MzNMTi9BbkFtclBmL1pmYkFBTEVaak5wK3crNE8vc2o1?=
 =?utf-8?B?b0NxZTdUZVlFR04yNjRycUFuWWszb3hvOURWdElDd1BuN1cvSG5rWllzRVlX?=
 =?utf-8?B?MUNiSlp5ZjhJOS90VGJKOGpZZlZhU3FHTWxzdHdqUWNlWjJpbVdvRHJHenRT?=
 =?utf-8?B?T0s1YmtSRCtrY0lOYm9vL0tLVzNpZ245cTBiMWxrR3hyM0NCdTB5NjRBWmxQ?=
 =?utf-8?B?NWhnVGlEVGo2K1N5dXdSeFU3L000SUU2MUFqWDFvRXI3a0tHcXAxcnJ4cWZk?=
 =?utf-8?B?ZmtFcTloYmp4NEFlOGxiV2VFWHZwbTNXRkoybHFKRnlFQmRCUHJqbkZVcTRr?=
 =?utf-8?B?ZEh6NC94K2gySGVHblFrZzFlbnhIVWNlM2lLVGI0akd0Mk5zWFR4VmIxMXlh?=
 =?utf-8?B?R2N0eHo0WnJiaE83QjhaTmU5OFRSbWlvdU9qOUUrYVhxVnF1eUpBYVVKU1Bm?=
 =?utf-8?B?ZXltUnpSa2laY0FCZ2hiVDFSNGw2VHplY2RNSG91RjJIbVBHeTc0QjZKUWJM?=
 =?utf-8?B?MzY4dTA3ZExyem5wTHhGR21uVHlwbUFPU0dnYXhVS05xaGJ0Yjl5eG55WGlD?=
 =?utf-8?B?R1VuM0lKRFpxR21ERDJPNGZ3aUY4RE1GbFJ3bldBTlZXcmpPQXlCb1JvTjZn?=
 =?utf-8?B?NUlDOG00TGFRQzVHUCt4VklCWjR3cFJIeDRXK2FPR216QTcySytuUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93424df9-470a-4d3b-f049-08df208c306d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 13:50:58.9624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/z5b8OzFNXg8YtBv/e+9/X/jxQ2/uUyJriFLodJzcm0tUcLCaR85J6QxbDbEe/V8pfx5wvBc1MxR2eaGxo1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj4gU2VudDogMDEgT2N0b2JlciAyMDI2IDE3OjQxDQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFu
DQo+IENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNv
bT47IEppYW5kaSBBbg0KPiA8amFuQG52aWRpYS5jb20+OyBqZ2dAemllcGUuY2E7IEFua2l0IEFn
cmF3YWwgPGFua2l0YUBudmlkaWEuY29tPjsgQW5pa2V0DQo+IEFnYXNoZSA8YW5pa2V0YUBudmlk
aWEuY29tPjsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5j
b20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMC83XSBody9hcm0vc21tdXYzOiBMaXZlIG1p
Z3JhdGlvbiBmb3IgYWNjZWw9b24NCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBv
cGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+
IE9uIDkvNC8yNiA4OjA1IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhpLA0KPiA+
DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBsaXZlIG1pZ3JhdGlvbiBzdXBwb3J0IGZvciBhbiBhY2Nl
bGVyYXRlZCBTTU1VdjMNCj4gPiAoLWRldmljZSBhcm0tc21tdXYzLGFjY2VsPW9uKSB3aXRoIHZm
aW8tcGNpIGVuZHBvaW50cyBvbiB0aGUgaW9tbXVmZA0KPiA+IGJhY2tlbmQuDQo+ID4NCj4gPiBU
aGUgZGVzdGluYXRpb24gcmVwbGF5cyByYXRoZXIgdGhhbiByZWNlaXZlcy4gVGhlIHN0cmVhbSB0
YWJsZSwgdGhlDQo+ID4gU1RFcywgdGhlIENEcyBhbmQgdGhlIFN0YWdlIDEgcGFnZSB0YWJsZXMg
YWxsIGxpdmUgaW4gZ3Vlc3QgUkFNLCBzbw0KPiA+IG9uY2UgdGhhdCBhbmQgdGhlIHJlZ2lzdGVy
cyBhcmUgcmVzdG9yZWQsIHRoZSBkZXN0aW5hdGlvbiB3YWxrcyB0aGUNCj4gPiBzdHJlYW0gdGFi
bGUgYWdhaW4gYW5kIHJlYnVpbGRzIHRoZSB2REVWSUNFIGFuZCB0aGUgbmVzdGVkIEhXUFQgZm9y
IGV2ZXJ5DQo+IGRldmljZS4NCj4gPg0KPiA+IFdoYXQgdGhlIHNlcmllcyBkb2VzOg0KPiA+DQo+
ID4gIC0gZHJhaW5zIHRoZSBrZXJuZWwgdkVWRU5UUSBpbnRvIHRoZSBndWVzdCBldmVudCBxdWV1
ZSB3aGVuIHRoZSBWTSBzdG9wcywNCj4gPiAgICBzbyB0aGF0IHBlbmRpbmcgZmF1bHQgZXZlbnRz
IGFyZSBub3QgbG9zdCAoMSwgMikNCj4gPiAgLSBtaWdyYXRlcyB0aGUgcmVzb2x2ZWQgU01NVXYz
IGZlYXR1cmUgc2V0IGluIGEgbmV3IHNtbXV2My9hY2NlbA0KPiA+ICAgIHN1YnNlY3Rpb24gYW5k
IGZhaWxzIHRoZSBsb2FkIGlmIHRoZSB0d28gZW5kcyBkaWZmZXIgKDMpDQo+ID4gIC0gcmVwbGF5
cyB0aGUgZ3Vlc3Qgc3RyZWFtIHRhYmxlIG9uIHRoZSBkZXN0aW5hdGlvbiBhbmQgcmVzdG9yZXMg
dGhlDQo+ID4gICAgdkVWRU5UUSBhbmQgdGhlIEdCUEEgSFdQVCAoNCwgNSkNCj4gPiAgLSBhc2tz
IFZGSU8gZm9yIGRpcnR5IHRyYWNraW5nIG9uIHRoZSBTdGFnZSAyIG5lc3RpbmcgcGFyZW50ICg2
KQ0KPiA+ICAtIHJlcGxhY2VzIHRoZSBhY2NlbCBtaWdyYXRpb24gYmxvY2tlciB3aXRoIG9uZSBz
Y29wZWQgdG8gQ01EUVYsIHdoaWNoDQo+ID4gICAgY2Fubm90IGJlIG1pZ3JhdGVkIGZvciBub3cg
KDcpDQo+ID4NCj4gPiBUaGlzIGRlcGVuZHMgb24gdGhlIGhvc3Qga2VybmVsIHN1cHBvcnRpbmcg
ZGlydHkgdHJhY2tpbmcgb24gdGhlIFN0YWdlDQo+ID4gMiBuZXN0aW5nIHBhcmVudCwgZm9yIGFz
c2lnbmVkIGRldmljZXMgdGhhdCBjYW5ub3QgdHJhY2sgZGlydHkgcGFnZXMNCj4gPiB0aGVtc2Vs
dmVzLiBBIGJyYW5jaCBiYXNlZCBvbiBKYXNvbidzIGlvbW11IHBhZ2UgdGFibGUgd29yayBpcyBo
ZXJlIFswXS4NCj4gPg0KPiA+IEJpZyBjYXZlYXQ6DQo+ID4NCj4gPiBUaGlzIGlzIG5vdCB5ZXQg
dGVzdGVkIHdpdGggYSByZWFsIGRldmljZSB0aGF0IHN1cHBvcnRzIG1pZ3JhdGlvbiBhcyBJDQo+
ID4gZG8gbm90IGhhdmUgYSB0ZXN0IHNldHVwIGZvciB0aGF0LiBGb2xrcyB3aG8gZG8gaGF2ZSBz
dWNoIGEgc2V0dXAgaGF2ZQ0KPiA+IHJlYWNoZWQgb3V0IGFuZCBhcmUgY29waWVkIGhlcmUsIHNv
IGhvcGVmdWxseSB0aGlzIFJGQyBsZXRzIHRoZW0gZ2l2ZQ0KPiA+IGl0IGEgc3BpbiBhbmQgcHJv
dmlkZSBzb21lIGVhcmx5IGZlZWRiYWNrLg0KPiANCj4gUGxlYXNlIGNvdWxkIHlvdSBjbGFyaWZ5
IGFsbCB0aGUgcmVxdWlyZW1lbnRzIGZvciBzdXBwb3J0aW5nIHRoaXMgbWlncmF0aW9uDQo+IHNj
ZW5hcmlvIChhdCBFUCwgU01NVSBhbmQga2VybmVsIGxldmVsKT8NCg0KRm9yIGEgbWluaW11bSB3
ZSBuZWVkOg0KDQpFUDoNCg0KIC0gQSBkZXZpY2Ugd2l0aCBtaWdyYXRpb24gc3VwcG9ydCBhbmQg
YSB2ZmlvIHZhcmlhbnQgZHJpdmVyIHRoYXQgaW1wbGVtZW50cw0KICAgVkZJTyBtaWdyYXRpb24s
IHRoZSBzYW1lIGFzIGZvciBtaWdyYXRpb24gd2l0aG91dCBhIHZJT01NVS4NCg0KSG9zdCBTTU1V
djM6DQoNCiAtIERpcnR5IHRyYWNraW5nIG9uIHRoZSBTdGFnZSAyIG5lc3RpbmcgcGFyZW50LiBT
dGFnZSAyIG1hcHMgR1BBIHRvIFBBLA0KICAgc28gdGhlIGRpcnR5IGJpdHMgaXQgc2V0cyBhcmUg
YWxyZWFkeSBpbiBndWVzdCBwaHlzaWNhbCB0ZXJtcy4gVGhhdA0KICAgbmVlZHMgSFRUVSAoSURS
MC5IVFRVIHJlcG9ydGluZyBIRCkgYW5kIGNvaGVyZW50IHRhYmxlIHdhbGtzLCB3aGljaA0KICAg
aXMgd2hhdCBhcm1fc21tdV9kYm1fY2FwYWJsZSgpIGNoZWNrcyBhbmQgaW9tbXVmZCByZXBvcnRz
IGFzDQogICBJT01NVV9IV19DQVBfRElSVFlfVFJBQ0tJTkcuIFdpdGhvdXQgaXQgVkZJTyBhZGRz
IGl0cyB1c3VhbCBibG9ja2VyLg0KDQpIb3N0IEtlcm5lbDoNCg0KIC0gSU9NTVVfSFdQVF9BTExP
Q19ESVJUWV9UUkFDS0lORyBvbiBhIG5lc3RpbmcgcGFyZW50IGRvbWFpbi4gVXBzdHJlYW0NCiAg
IGFybS1zbW11LXYzIHJldHVybnMgRU9QTk9UU1VQUCBmb3IgdGhhdCBjb21iaW5hdGlvbi4gVGhl
IGJyYW5jaCBpbiBbMF0NCiAgIGVuYWJsZXMgaXQgb24gdG9wIG9mIEphc29uJ3MgaW9tbXUgcGFn
ZSB0YWJsZSB3b3JrLCBieSBzZXR0aW5nIFMySEEgYW5kDQogICBTMkhEIGluIHRoZSBTVEUgYW5k
IHVzaW5nIHRoZSBEQk0gc3VwcG9ydCBpbiB0aGUgZ2VuZXJpYyBwYWdlIHRhYmxlDQogICBjb2Rl
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCj4gPg0KPiA+IFFFTVUgYnJhbmNoIGlzIGhlcmU6DQo+
ID4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vc2hhbWlhbGkyMDA4L3FlbXUtbWFzdGVyL3RyZWUv
c21tdXYzLWFjY2VsLWxpdmUtDQo+IG1pZw0KPiA+IHJuLXJmY3YxDQo+ID4NCj4gPiBQbGVhc2Ug
bGV0IG1lIGtub3cgeW91ciBmZWVkYmFjay4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBTaGFtZWVy
DQo+ID4gWzBdOg0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaGFtaWFsaTIwMDgvbGludXgv
Y29tbWl0cy9pb21tdV9wdF9hcm02NF9zMl9kYm0NCj4gLw0KPiA+DQo+ID4gU2hhbWVlciBLb2xv
dGh1bSAoNyk6DQo+ID4gICBody9hcm0vc21tdXYzLWFjY2VsOiBGYWN0b3Igb3V0IHRoZSBzaW5n
bGUgdkVWRU5UIHJlYWQNCj4gPiAgIGh3L2FybS9zbW11djMtYWNjZWw6IERyYWluIHRoZSB2RVZF
TlRRIHdoZW4gdGhlIFZNIHN0b3BzDQo+ID4gICBody9hcm0vc21tdXYzOiBNaWdyYXRlIHRoZSBh
Y2NlbGVyYXRvciBmZWF0dXJlIHNldA0KPiA+ICAgaHcvYXJtL3NtbXV2My1hY2NlbDogQWRkIGEg
aGVscGVyIHRvIHJlcGxheSBhbGwgU1RFcw0KPiA+ICAgaHcvYXJtL3NtbXV2My1hY2NlbDogUmVz
dG9yZSBhY2NlbGVyYXRvciBzdGF0ZSBvbiBpbmNvbWluZyBtaWdyYXRpb24NCj4gPiAgIGh3L2Fy
bS9zbW11djMtYWNjZWw6IFJlcXVlc3QgZGlydHkgdHJhY2tpbmcgb24gdGhlIG5lc3RpbmcgcGFy
ZW50DQo+ID4gICBody9hcm0vc21tdXYzOiBTdXBwb3J0IG1pZ3JhdGlvbiB3aXRoIGFjY2VsPW9u
DQo+ID4NCj4gPiAgaHcvYXJtL3NtbXV2My1hY2NlbC5oICAgICAgIHwgICAyICsNCj4gPiAgaW5j
bHVkZS9ody9hcm0vc21tdXYzLmggICAgIHwgICA3ICstDQo+ID4gIGh3L2FybS9zbW11djMtYWNj
ZWwtc3R1YnMuYyB8ICAxNyArKysrDQo+ID4gIGh3L2FybS9zbW11djMtYWNjZWwuYyAgICAgICB8
IDE5Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgaHcvYXJt
L3NtbXV2My5jICAgICAgICAgICAgIHwgICA2ICstDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMjEw
IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+DQoNCg==

