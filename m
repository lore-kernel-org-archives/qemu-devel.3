Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44A1CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYft-0005Br-E0; Mon, 08 Sep 2025 06:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvYfc-00052C-9f; Mon, 08 Sep 2025 06:00:21 -0400
Received: from mail-dm6nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60c]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvYfS-0007Oq-Fw; Mon, 08 Sep 2025 06:00:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfm9IjeGyMhRjJgxEOvmsW76+zePTE9bYdys/O4X7+1nu41F26KLW2dEH6IyNXcz1Nvh0P7h9FrW5UBJERrub9s3Q3Dm7hyOLvSng0eEtS+2OrOoLxqMlLL+qAcZHOd/F6/4Fmc3xjkDI2L986UeUjx3x3XFeNqbeWvqIS4DCzJjO0lBVx1d2+zd9z3ahS/H2MCKqX3owr4sz8MSwSkcmV42eyFmDUse9RRS/elbnrxAT3XI5lSAWkEYzMIHTUbW5YpzYQBjJX/AOgciFNSL0c+OgQjq6I0oZSm0sGMHqHZ/NOTgFehUVfxIPmPCXfGXAu7H5eMWUgEKjpIFSRKyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svMmmHf0QLppvlBnm7jbkeMFifkg+WXlFmFPbvOSXes=;
 b=mnL2W+9PW1FYbq5oRfKONxaFrG7wPSM85BTxTl5gchfdUL9++LNm/tW7GtKLMKj8adD6El07j6e7Uw4aYE8O89q1q0MvwGMXmZFxIz2kSVJ0gs/MybKadZHxqRoep6fWG6OcP8lZU/A1Ar/3gOTPd/32HGzjtcMBofYdNvtuh2T/LmTlD/b9ZzO4AQvIYxFVtrJwMcEGkzhpDaSbC7A5QP6/cfJ6JDpao4MOjJaQrXkuMpmoktIdTOB4eeg/M0DSnQp3dGKsOvqBkVxPAZASm8O+d2NyRTJ5VlLW8hugvzO2zDlz4sywBzKWSAl87Sl9f0T4114nVSLUNGsliP/wqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svMmmHf0QLppvlBnm7jbkeMFifkg+WXlFmFPbvOSXes=;
 b=nBmfGHjop4D4N+wpkJSyEas+Kn+CsLUDd/Vo1UoLTO6kZAJDrsChfFkvthZ5qWvmdjpq2n9GSuzhe8KTV5n+HfTKux2sCssNaXmahS3+021rduooyjn3CSU1Rx5iqa4S9IDbACDnovgQA72mPtGtHt0SOKHiAh5BoKG/2hUjtFglQxaW3W8k47F3v97KnmgU1G9KFy5JUxmdvak/CRGmgIGntny/qMCjdC9/HDcUdffD4pMmXzXQBoV5IYQLi7Lnm+jP8M79AeeyNBHnd0RHdf6DV/9uFN8xY7pMa9cvTg6YCwvWIakRoiZijo+/ZZGsuH38RXdXJTxA2AnShgBnPw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 09:59:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 09:59:55 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 12/15] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Thread-Topic: [RFC PATCH v3 12/15] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Thread-Index: AQHcHlA2kwsuqMv1/kutxsdhpq84oLSJDi/g
Date: Mon, 8 Sep 2025 09:59:55 +0000
Message-ID: <CH3PR12MB75486D76AC47F611FC646510AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-13-shameerali.kolothum.thodi@huawei.com>
 <c2935990-ac0b-4272-b3aa-92a555d88e99@redhat.com>
In-Reply-To: <c2935990-ac0b-4272-b3aa-92a555d88e99@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB8358:EE_
x-ms-office365-filtering-correlation-id: d1d01d63-e3c4-4f59-2b80-08ddeebe7697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RHJ0aDBDWWlCOGpHUnJRQ0N5Q0F3ZVZxMTVSQ1kwcjVVTkZ3RFVhcGtOcFNx?=
 =?utf-8?B?S0JJc09WOGJtdXBYYml5UlM0TS9tSElDUUNlVjdheXVxZGdXSXNDRlZNVzNy?=
 =?utf-8?B?QVNxU3FHNk9FY1hJVGNzVTNNUFdjOFlJYUZ5bVlwTWRKNWxEbkIzZWY5Q1Ru?=
 =?utf-8?B?VGdpMnpEck1rZmIwVUo2eXg3dWdkeWpUN3VScVJHK3hpenoxMkM5d1JXQmM0?=
 =?utf-8?B?c2tIR2JWRndpMjl6UkpCVTZiYmpxUVM0SmR1NERUbTgzOXNJTEtMbDJqVG5O?=
 =?utf-8?B?Q1liRDdmM0kvVFVNYk1OMzlkdy9zbnhZRVJlM1B4SGNyQ25GTnhIR01PSUQz?=
 =?utf-8?B?VUJsa2dKNzdOeG5DNC9tblVzN3lzV3ZScVNleDlMNC9VUDJXbFJxQVJicVlp?=
 =?utf-8?B?bzhCVERnNlcvKzZ5RnRteFE3bDNtTVh4OU5Wc2RTblBtQ2lIU1FBbjgyT0NL?=
 =?utf-8?B?YmlaUnNxanZiSWRDd040eVlMa1d3dzNYengzL3dHalE3L2tWRUNBZXpYRmtM?=
 =?utf-8?B?U3FjemxWWnllTGVFVlA4Q3p6SG5sU3RwMkZIUnFvK21henhCU1Fnb3d6Ymhn?=
 =?utf-8?B?amxOSW9remMvMGZlbTFJcmJFTE5hVU1aWHUzQkxuOTFUUGFQK2VtenFkazBU?=
 =?utf-8?B?aXp3M2F3REJxUEpyWEpZQzJqS2NrWWozelp1RHdiUkppdHdjUXBZQy92bklU?=
 =?utf-8?B?QXNaS25ocUNHQkF4blJEd3lXTU5TYnJ6Y2xmTERRUzByMzlrbllNVXh4c0pu?=
 =?utf-8?B?R0REcDZMNFNTYkJwT3A1U0NnZzNiZG50NXFYQjdZQ1djeGptMWlSWUtKKytV?=
 =?utf-8?B?M3MrbW5MSlBTVU95djE5WTZ1UnhlM1EwWjl0cmxoeWV3czk2elJzQi9vZzEz?=
 =?utf-8?B?eExSZVJQNitNZGJDd0tQM1lxeE51bG9XQTJuWVNBOEt4dWpwU2xtckwwR3RB?=
 =?utf-8?B?bWpQMXRPU2V1bXJwalpWWWxyaU5hM3RsYnpjdEdianVVVmloMisvOXRKVm5V?=
 =?utf-8?B?cTJsYXJCM1ZqTjJXM1ZISm5JTk8rbnVnajBvRXlRV0tDQkNZcVpWMElMeDlu?=
 =?utf-8?B?N1pjaGQ5RGRHRXZkOEhKKys3RUtpd3dERGRnSzZFcFNXaW1aWG9Zano3Z3FM?=
 =?utf-8?B?OVpWWVlQSmljdHJYRW0xei9OQVM5TFdWZWlLRmhqR3c3YUhadnc4bGs5ZmFj?=
 =?utf-8?B?U1l3VHppMHArakcxd1lrOGxjNlNIWGtSaTNoSzZwSmdNVnNXQjVwVzVHZEtI?=
 =?utf-8?B?TWFQcngxNGM3SEg0UERmVGIxUVZJL1pJTDllMFBtQVlMbHc5K0NCK1pNb0ls?=
 =?utf-8?B?LzhIV25mWEdSdUxnTGNyUThCZFhnREZRQjBvUEdXVmdsVFFQaGRhWjFJMW9V?=
 =?utf-8?B?V0NRdGFSYmoyMDhCMGllQXBnaVdUOFNyYnhPaW5qM29VNXlHekIzMXNER1pP?=
 =?utf-8?B?OUlhQzA1anI2YTdnQXNsUXloeThWNU1rT3dWamdadHVPajgwWEdneU9aRGhZ?=
 =?utf-8?B?dS9vUEplamYvQmhlakt2cG5kMUUvYzRKdnNzeUI1ZVV2U3lwU2dRTlRzNnBn?=
 =?utf-8?B?TVpFNmNuOS9ZandpR1RjQWlid29QZGthL1NXYkltTW9oTHBPdi9IOXdubEly?=
 =?utf-8?B?MW9MMlVLcHZYUUp5c1hGelF6ek1sODcxQnFLMHlUYjhsOUl4Uk84elliaXVo?=
 =?utf-8?B?elRySTczRlZzMmMyWGErRlBJTTZTR2ZKd0xneW5wY3JhcVZtZTBPVm9OWVBa?=
 =?utf-8?B?aHlueWpVZ0ZzWFhMUkxLRG95NXNEU3lkWXhoK2ZLZ2xMQTRQOHd2aWk1VVhq?=
 =?utf-8?B?YkZKU3AzaEVQamVWVDNEN29zSW9mY3dVUGQ4WmRRM0wxTjNwYno1cXA3WnpQ?=
 =?utf-8?B?V2VEWTc3a3JXSDdtL2pOUVk0YzFzR2hpL0Q3NFVkdjk0RmFyRnI1Yk52RjRq?=
 =?utf-8?B?TE9UL3liVnVVQjRVS0JQUml6cWpiQ0JFQURDakd5ZGhjT0lLajZySktLaGlx?=
 =?utf-8?B?VmZCemgyMGhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlRRY0ppUFBJTEkzWWEzbGhuc0QrYnBIZGhhYjZka2FuR1dzcVRPOURxZDlx?=
 =?utf-8?B?QTVvYVBzK2dSV1hKeXNyTGk3djNLRXp5dWNtVmtWZjBVVm5BV1dMMkF1cUdG?=
 =?utf-8?B?SW9hSVhQSEtFMjh3ejJmSEVwd2pHazk3dkZGTUF6L3lKT3diMVR3QnZYRmU3?=
 =?utf-8?B?UzV3ZFM2blVYZjJ6ZWg5VTVVYXFpWmxkbVFEbDJNSndvTm9NbUZFalFTRVV1?=
 =?utf-8?B?M0dpN29KSGcrRDdpcEU0UUVLQ1l6NzJHU1NJS3BJYjRsN205OHgwU1NpQUlD?=
 =?utf-8?B?UVB3NnpRS2hPcnVCT1FvQStrWGF4dVgxZ1hFUkZQY0ZsaDd1S3NEOTN0R2dn?=
 =?utf-8?B?aXUydVBuS0xXRFZ0WG9qVHJ2YktRSkFWaUpxRlMyMlA5UlJaOHY3eDRwTjlW?=
 =?utf-8?B?ZCsvTUgvcG5IY0libzdsc014akt0dXgyVWI0WHRpZGFBb1d0dU85clJSZENs?=
 =?utf-8?B?SU8xTHYvZFJTeSt6OW1vY25PTWNlSWRLZWZ6Q1RZYXVkSHRSWmRFaEh4Wksx?=
 =?utf-8?B?TzVNUzR1RmlMd2x2ZEhBVEFhMC9NZFNnOVlqSk91bDg2TmhaVjFTSnZRM1JI?=
 =?utf-8?B?dEpkTWJINDNCQ3ZNMWNySVFwaGkya1hnK3JXNlBaUUpDNlVZTFROdno2R3BU?=
 =?utf-8?B?SzJscFR6TFowRDV3M2xsOGpyNHFVWFJScVliUUxMaExHTkpoNXBBR1Yxcyt1?=
 =?utf-8?B?em5CMVNhZTN5Q010REFLNUZaRldmNXF0TnZXOFdoVmVXdWM3cnR0K2I4cWtt?=
 =?utf-8?B?aGt4SlIrK29Vc3FNMjNwVmgwWDM3NkdweXdDZ2djNFowdkRTL1JweFAya2o1?=
 =?utf-8?B?emVhVkM2RUxMOHFwZVlrT3gxWGJZRyszeEJKaTBSWlA2L2psbHFMaUJmeGRs?=
 =?utf-8?B?eUFnbEF0YThDazA0dVFTcGZVVm5XNDFRL1pjQjFSL2ZrK0dJWEJQWk1jbzlB?=
 =?utf-8?B?NnpzQzBlZlRiVjROOXF5UDVjZXg2RGNTckNEdHhucFc1RHlEa09PWjVOSElV?=
 =?utf-8?B?MUFBLzNsYUQrTDljSTFXbDFTRjRuYmV5QW1Zb2pPMjZVZjV1dmJtUUhOOG5i?=
 =?utf-8?B?NElDajQ5OElmSUVMbWhldlZodDhpRHY1ZjNMT29JVUNuV2lJd2RMaWxBVDl4?=
 =?utf-8?B?TzhNeTdob2FRRERlRy9mS2crb3RuVmd3TEQ2TTlXcElGdVdZU1B5Qnh3TGdQ?=
 =?utf-8?B?WjdUVUtWaDYwMjdOK1lKTWFpcUp3MVh5Vk1td1gzNmtobzl1ZXFBOU41RG40?=
 =?utf-8?B?a2xKNEJWTUlkMVhlcitWbG1DRFo1azJsME42Y0YwYTdVK1FlaHpvUzBldFJK?=
 =?utf-8?B?WGZrbWhoWVVjL3IzaXUwc3dWZ0VLYkJjR2FYNUx4OE1sSG16dUc0cnpWSVRo?=
 =?utf-8?B?QmhzQXdkelAyL21qV3VLa1EvOXMvQVFNa1BsK1JUclVGcXIrTW54b0IyL2pw?=
 =?utf-8?B?bUtqVHpOSldMODZYZ2hXaGNxSUU5cGx1NFBlMWxBay83MkJyQUlzbTRzTGw0?=
 =?utf-8?B?b0RMWnNaTkJ4bzc5cVR0eU5nak1FTUc1ck04VGM0OGYrQnBPQzdpRWxXMHJN?=
 =?utf-8?B?cXBlb3lmT2NXZWx4MnBMQm5Gb29RdktYUzQ2aE8yd1lVbmNpRFJxbnNUc0Jt?=
 =?utf-8?B?MUdjcWJlNVdDaEFsaHlxLzJNMU5UQktHSHZidkhKakE2YjBWMWNHSi9PaEw2?=
 =?utf-8?B?UTlycmpPaWhZOGR1dUYwVmhXVjBNSm9VQ3ZFTVZOZjlCMDM2NWQ4NjV2NEkx?=
 =?utf-8?B?UzdEUnBsRjVxR1BrMzd2RyszVGo4eGNxS2ZzaUIzaWQwSk1BWmN2eFJXRmc4?=
 =?utf-8?B?L09IcTZXcmtnTHhGVlg0Q3ZncEg4dHMrdnRKUmFPOXBtZjEvL1A1a2tNdXNQ?=
 =?utf-8?B?ektiT280VnM3QXpXZ0tpV0xHR0NuNTM1K3k2VmlmMllEZnFNQUFSQ3pvcnNX?=
 =?utf-8?B?T0RkSCtnQlFHbHJ4d3R4N3lXWWFQd2REOEZURDcwTVFMT1hVSlVvR3hiS2l4?=
 =?utf-8?B?YjVNMVJLdTI0KzQ2M0NZVlEyS3AvbVZUcGE3VFVzM2Nka3JxVmF4VStSTC9a?=
 =?utf-8?B?aGJNZHZpOVhPcjlRVUlSMmNya0N1LzVKWHcwSndSWXRvQkZGaDdaYXQzTDNm?=
 =?utf-8?Q?kpc3YUrU4nE7DnnLWje584olS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d01d63-e3c4-4f59-2b80-08ddeebe7697
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 09:59:55.7160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8AWnhlsor+L6Q/z6/rXzTg2CB07huPX+Cw48z2trQ2CUiE6izhiapGlnVMOqe4Pmt9ZJWVQZSe+/08HieA5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
Received-SPF: permerror client-ip=2a01:111:f403:2413::60c;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.131, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBTZXB0ZW1iZXIgMjAyNSAxMTozMQ0KPiBU
bzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBTaGFtZWVyIEtv
bG90aHVtDQo+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IGxpbnV4YXJtQGh1
YXdlaS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWku
Y29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8u
b3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5j
b20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMTIvMTVdIGh3L2FybS9zbW11djMtYWNj
ZWw6IEludHJvZHVjZSBoZWxwZXJzDQo+IHRvIGJhdGNoIGFuZCBpc3N1ZSBjYWNoZSBpbnZhbGlk
YXRpb25zDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDcvMTQvMjUgNTo1OSBQTSwgU2hhbWVlciBLb2xv
dGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+
DQo+ID4NCj4gPiBIZWxwZXJzIHdpbGwgYmF0Y2ggdGhlIGNvbW1hbmRzIGFuZCBpc3N1ZSBhdCBv
bmNlIHRvIGhvc3QgU01NVXYzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVu
IDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3Ro
dW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4g
PiAgaHcvYXJtL3NtbXV2My1hY2NlbC5jICAgIHwgNjUNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmggICAgfCAxNiAr
KysrKysrKysrDQo+ID4gIGh3L2FybS9zbW11djMtaW50ZXJuYWwuaCB8IDEyICsrKysrKysrDQo+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgOTMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2FybS9zbW11djMtYWNjZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IGlu
ZGV4IDA0YzY2NWNjZjUuLjEyOThiNGY2ZDAgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5jDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gQEAgLTE2OCw2
ICsxNjgsNzEgQEANCj4gc21tdXYzX2FjY2VsX2luc3RhbGxfbmVzdGVkX3N0ZV9yYW5nZShTTU1V
U3RhdGUgKmJzLCBTTU1VU0lEUmFuZ2UNCj4gKnJhbmdlKQ0KPiA+ICAgICAgZ19oYXNoX3RhYmxl
X2ZvcmVhY2goYnMtPmNvbmZpZ3MsIHNtbXV2M19hY2NlbF9zdGVfcmFuZ2UsIHJhbmdlKTsNCj4g
PiAgfQ0KPiA+DQo+ID4gKy8qIFVwZGF0ZSBiYXRjaC0+bmNtZHMgdG8gdGhlIG51bWJlciBvZiBl
eGVjdXRlIGNtZHMgKi8NCj4gPiArYm9vbCBzbW11djNfYWNjZWxfaXNzdWVfY21kX2JhdGNoKFNN
TVVTdGF0ZSAqYnMsDQo+IFNNTVVDb21tYW5kQmF0Y2ggKmJhdGNoKQ0KPiA+ICt7DQo+ID4gKyAg
ICBTTU1VdjNTdGF0ZSAqcyA9IEFSTV9TTU1VVjMoYnMpOw0KPiA+ICsgICAgU01NVXYzQWNjZWxT
dGF0ZSAqc19hY2NlbCA9IHMtPnNfYWNjZWw7DQo+ID4gKyAgICB1aW50MzJfdCB0b3RhbCA9IGJh
dGNoLT5uY21kczsNCj4gPiArICAgIElPTU1VRkRWaW9tbXUgKnZpb21tdV9jb3JlOw0KPiA+ICsg
ICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICBpZiAoIWJzLT5hY2NlbCkgew0KPiA+ICsgICAg
ICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmICghc19hY2Nl
bC0+dmlvbW11KSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgdmlvbW11X2NvcmUgPSAmc19hY2NlbC0+dmlvbW11LT5jb3JlOw0KPiA+ICsg
ICAgcmV0ID0gaW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUodmlvbW11X2NvcmUtPmlv
bW11ZmQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
aW9tbXVfY29yZS0+dmlvbW11X2lkLA0KPiA+ICsNCj4gSU9NTVVfVklPTU1VX0lOVkFMSURBVEVf
REFUQV9BUk1fU01NVVYzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKENtZCksICZiYXRjaC0+bmNtZHMsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiYXRjaC0+Y21kcywgTlVMTCk7DQo+ID4gKyAg
ICBpZiAoIXJldCB8fCB0b3RhbCAhPSBiYXRjaC0+bmNtZHMpIHsNCj4gPiArICAgICAgICBlcnJv
cl9yZXBvcnQoIiVzIGZhaWxlZDogcmV0PSVkLCB0b3RhbD0lZCwgZG9uZT0lZCIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgcmV0LCB0b3RhbCwgYmF0Y2gtPm5jbWRzKTsN
Cj4gPiArICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGJh
dGNoLT5uY21kcyA9IDA7DQo+ID4gKyAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+
ICsvKg0KPiA+ICsgKiBOb3RlOiBzZGV2IGNhbiBiZSBOVUxMIGZvciBjZXJ0YWluIGludmFsaWRh
dGlvbiBjb21tYW5kcw0KPiA+ICsgKiBlLmcuLCBTTU1VX0NNRF9UTEJJX05IX0FTSUQsIFNNTVVf
Q01EX1RMQklfTkhfVkEgZXRjLg0KPiA+ICsgKi8NCj4gPiArdm9pZCBzbW11djNfYWNjZWxfYmF0
Y2hfY21kKFNNTVVTdGF0ZSAqYnMsIFNNTVVEZXZpY2UgKnNkZXYsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFNNTVVDb21tYW5kQmF0Y2ggKmJhdGNoLCBDbWQgKmNtZCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmNvbnMpDQo+ID4gK3sNCj4gPiAr
ICAgIGlmICghYnMtPmFjY2VsKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0K
PiA+ICsNCj4gPiArICAgLyoNCj4gPiArICAgICogV2UgbWF5IGVuZCB1cCBoZXJlIGZvciBhbnkg
ZW11bGF0ZWQgUENJIGJyaWRnZSBvciByb290IHBvcnQgdHlwZQ0KPiA+ICsgICAgKiBkZXZpY2Vz
LiBUaGUgYmF0Y2hpbmcgb2YgY29tbWFuZHMgb25seSBtYXR0ZXJzIGZvciB2ZmlvLXBjaSBlbmRw
b2ludA0KPiA+ICsgICAgKiBkZXZpY2VzIHdpdGggR3Vlc3QgUzEgdHJhbnNsYXRpb24gZW5hYmxl
ZC4gSGVuY2UgY2hlY2sgdGhhdCwgaWYNCj4gPiArICAgICogc2RldiBpcyBhdmFpbGFibGUuDQo+
ID4gKyAgICAqLw0KPiA+ICsgICAgaWYgKHNkZXYpIHsNCj4gPiArICAgICAgICBTTU1VdjNBY2Nl
bERldmljZSAqYWNjZWxfZGV2Ow0KPiA+ICsgICAgICAgIGFjY2VsX2RldiA9IGNvbnRhaW5lcl9v
ZihzZGV2LCBTTU1VdjNBY2NlbERldmljZSwgc2Rldik7DQo+ID4gKw0KPiA+ICsgICAgICAgIGlm
ICghYWNjZWxfZGV2LT5zMV9od3B0KSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybjsNCj4gPiAr
ICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgYmF0Y2gtPmNtZHNbYmF0Y2gt
Pm5jbWRzXSA9ICpjbWQ7DQo+ID4gKyAgICBiYXRjaC0+Y29uc1tiYXRjaC0+bmNtZHMrK10gPSAq
Y29uczsNCj4gPiArICAgIHJldHVybjsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIFNNTVV2
M0FjY2VsRGV2aWNlICpzbW11djNfYWNjZWxfZ2V0X2RldihTTU1VU3RhdGUgKmJzLA0KPiBTTU1V
UGNpQnVzICpzYnVzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBQQ0lCdXMgKmJ1cywgaW50IGRldmZuKQ0KPiA+ICB7DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2FybS9zbW11djMtYWNjZWwuaCBiL2h3L2FybS9zbW11djMtYWNjZWwuaA0KPiA+IGlu
ZGV4IDIxMDI4ZTYwYzguLmQwNmM5NjY0YmEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5oDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQo+ID4gQEAgLTEzLDYg
KzEzLDcgQEANCj4gPiAgI2luY2x1ZGUgImh3L2FybS9zbW11LWNvbW1vbi5oIg0KPiA+ICAjaW5j
bHVkZSAic3lzdGVtL2lvbW11ZmQuaCINCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvbW11ZmQuaD4N
Cj4gPiArI2luY2x1ZGUgInNtbXV2My1pbnRlcm5hbC5oIg0KPiA+ICAjaW5jbHVkZSBDT05GSUdf
REVWSUNFUw0KPiA+DQo+ID4gIHR5cGVkZWYgc3RydWN0IFNNTVVTMkh3cHQgew0KPiA+IEBAIC01
NSw2ICs1NiwxMCBAQCB2b2lkIHNtbXV2M19hY2NlbF9pbml0KFNNTVV2M1N0YXRlICpzKTsNCj4g
PiAgdm9pZCBzbW11djNfYWNjZWxfaW5zdGFsbF9uZXN0ZWRfc3RlKFNNTVVTdGF0ZSAqYnMsIFNN
TVVEZXZpY2UNCj4gKnNkZXYsIGludCBzaWQpOw0KPiA+ICB2b2lkIHNtbXV2M19hY2NlbF9pbnN0
YWxsX25lc3RlZF9zdGVfcmFuZ2UoU01NVVN0YXRlICpicywNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNNTVVTSURSYW5nZSAqcmFuZ2UpOw0KPiA+ICti
b29sIHNtbXV2M19hY2NlbF9pc3N1ZV9jbWRfYmF0Y2goU01NVVN0YXRlICpicywNCj4gU01NVUNv
bW1hbmRCYXRjaCAqYmF0Y2gpOw0KPiA+ICt2b2lkIHNtbXV2M19hY2NlbF9iYXRjaF9jbWQoU01N
VVN0YXRlICpicywgU01NVURldmljZSAqc2RldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgU01NVUNvbW1hbmRCYXRjaCAqYmF0Y2gsIHN0cnVjdCBDbWQgKmNtZCwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmNvbnMpOw0KPiA+ICAjZWxzZQ0KPiA+
ICBzdGF0aWMgaW5saW5lIHZvaWQgc21tdXYzX2FjY2VsX2luaXQoU01NVXYzU3RhdGUgKmQpDQo+
ID4gIHsNCj4gPiBAQCAtNjcsNiArNzIsMTcgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4gIHNt
bXV2M19hY2NlbF9pbnN0YWxsX25lc3RlZF9zdGVfcmFuZ2UoU01NVVN0YXRlICpicywgU01NVVNJ
RFJhbmdlDQo+ICpyYW5nZSkNCj4gPiAgew0KPiA+ICB9DQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9v
bCBzbW11djNfYWNjZWxfaXNzdWVfY21kX2JhdGNoKFNNTVVTdGF0ZSAqYnMsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU01NVUNvbW1hbmRCYXRj
aCAqYmF0Y2gpDQo+ID4gK3sNCj4gPiArICAgIHJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBzbW11djNfYWNjZWxfYmF0Y2hfY21kKFNNTVVTdGF0ZSAqYnMsDQo+
IFNNTVVEZXZpY2UgKnNkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNNTVVDb21tYW5kQmF0Y2ggKmJhdGNoLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgQ21kICpjbWQsIHVpbnQzMl90ICpjb25z
KQ0KPiA+ICt7DQo+ID4gKyAgICByZXR1cm47DQo+ID4gK30NCj4gPiAgI2VuZGlmDQo+ID4NCj4g
PiAgI2VuZGlmIC8qIEhXX0FSTV9TTU1VVjNfQUNDRUxfSCAqLw0KPiA+IGRpZmYgLS1naXQgYS9o
dy9hcm0vc21tdXYzLWludGVybmFsLmggYi9ody9hcm0vc21tdXYzLWludGVybmFsLmgNCj4gPiBp
bmRleCA3MzgwNjFjNmFkLi44Y2I2YTkyMzhhIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11
djMtaW50ZXJuYWwuaA0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMtaW50ZXJuYWwuaA0KPiA+IEBA
IC01NDcsNiArNTQ3LDE4IEBAIHR5cGVkZWYgc3RydWN0IENEIHsNCj4gPiAgICAgIHVpbnQzMl90
IHdvcmRbMTZdOw0KPiA+ICB9IENEOw0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIFNNTVVDb21tYW5k
QmF0Y2ggLSBiYXRjaCBvZiBpbnZhbGlkYXRpb24gY29tbWFuZHMgZm9yIGFjY2VsDQo+IHNtbXV2
Mw0KPiA+ICsgKiBAY21kczogUG9pbnRlciB0byBsaXN0IG9mIGNvbW1hbmRzDQo+ID4gKyAqIEBj
b25zOiBQb2ludGVyIHRvIGxpc3Qgb2YgQ09OUyBjb3JyZXNwb25kaW5nIHRvIHRoZSBjb21tYW5k
cw0KPiBJdCBpcyBub3QgdG90YWxseSBjbGVhciB0byBtZSBob3cgdGhlIGxpc3Qgb2YgIkNPTlMi
IGluZGV4ZXMgaXMgdXNlZC4gSXMNCj4gaXQgbWVhbnQgdG8gc3RvcmUgZXJyb3JzLCBob3cgZG8g
eW91IHVwZGF0ZSBjb25zIGluZGV4IGluIGNhc2UgaXQgc3RhcnRzDQo+IGZhaWxpbmcsIC4uLg0K
DQpUaGlzIGlzIGhvdyBJIHVuZGVyc3RhbmQgaXQsDQoNClRoZSBjb25zIGhlcmUgaXMgdG8gc3Rv
cmUgU01NVXYzIHF1ZXVlIGNvbnMgY29ycmVzcG9uZGluZyB0byB0aGUgY21kLiBBbmQNCmluIGNh
c2UgYmF0Y2hlZCBpbnZhbGlkYXRpb24gZmFpbHMoaW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVf
Y2FjaGUoKSksIGl0IHdpbGwNCnVwZGF0ZSB0aGUgYmF0Y2gtPm5jbWRzIHdpdGggdGhlIGluZGV4
IG9mIHRoZSBsYXN0IGZhaWxlZCBjb21tYW5kLiBUaGUgY29ucw0KdmFsdWUgYXQgdGhhdCBpbmRl
eCBpcyB0aGVuIHVzZWQgdG8gdXBkYXRlIHRoZSBTTU1VdjMgY29ucyBpbmRleC4NCg0KSSB3aWxs
IGFkZCBzb21lIGNvbW1lbnRzIGFuZCBtYWtlIGl0IGNsZWFyLiBBbHNvLCBJIHdpbGwgZG91Ymxl
IGNoZWNrIHdoZXRoZXINCnRoZSBhYm92ZSBzdGF0ZW1lbnQgaXMgdHJ1ZSwgYW5kIHRoaXMgaXMg
aW5kZWVkIGhvdyBJIGhhdmUgaW1wbGVtZW50ZWQgaXQNCmluIHRoaXMgc2VyaWVzIPCfmIouDQoN
ClRoYW5rcywNClNoYW1lZXINCg==

