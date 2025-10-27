Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA155CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMDO-0003W5-9c; Mon, 27 Oct 2025 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDMDB-0003US-Fx; Mon, 27 Oct 2025 08:20:36 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDMD2-0003LX-6k; Mon, 27 Oct 2025 08:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx877gVSvANxwjXUJ/N525uB/hOR0zg+ILTCmUH5kZQZjbYGyICKfXPnC546LGLeXlI1CyPtileeoiqH1zKAnclDiAAO5Mms/lW73sr1jruKxxwysGg++WXlcos6d5iQgKn+k9rP/tD2EyEEbOXsHZrXLuwuYiSE/349jdJOh6AYKNVmSKimimbVWvGRYKZqVXJJVpEP7GuuDu3rsVEJP/XrJxvlwj+s8+UYwwgu0kVze+R4KiGxkCwkpDcE/srLhzWWF3x3qtxzCnMGrtYMPXyCjHvrE/oHaNfs8StmAFsIC0nukA6UtZaf3q4AI3spwvt6AMXZKqnzM0k47Jz+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29cOoOv6ky1gtQ+DWVGkdyRAMTROwc1tIR4eWHdxxLM=;
 b=ZTrX9qoiHXqVqrSnMAWHoAwH0jQ3qbFVCBovfBerj0R6s55obMrkZZVoqYRIPpP/MlpeQpp/XqbaJ3wmPkJsz/GbUYbNvsS0eHt+0mT/mePouEKNb0Sfx+V9D9VpxlU3HO12TivuFUzfdw5nTTF+Y/BtqV0g7CHktwfuuURdopJIVuwtuMpsc/B2t/r1PbLs4qI2zEPkxv6GwYG0RT6TE9GzYiTPeeO8mUOdt2P3n5iq8YNPwn55wN2Dv8DWADt6hW8/B+A4IBrQl0W0CYtEwWaOIUJqb4c5rrLo+esU/rBIQidyjLvKsp7jNHE4y9IBQvQ5DFmaipJjqPMZFMxIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29cOoOv6ky1gtQ+DWVGkdyRAMTROwc1tIR4eWHdxxLM=;
 b=hQWadVYLDUArNFoXxP1yANH4c5/pMdMdEKN8lnbeGpGMVNu5EAUOTy7w8WFrlwJ01DnNj/HeKGLe5OMyEra9Uu5GP1KSzSia7xPZtdieitf0TvMSW7EqrLwB7bUrESOrS7Ev6Uvbi45OAHxHX/wrUfrGi92nAqUSRdQ+6MoVhb6Q255lngFnlJbZp+vsmuv6mVMhbe/YvAO09ozD8MlPDNoqUGxm7cnaQx+1m7vQ/7EvHE1a559VomGw2ufSFV900XNYTH8BRmSD18Zj9PTut+9usaS7hRQAitpPkxnVUTvb3nHaiji7Vw0YgtEpJkf0tHKqDUCTR5u8G6LKMAcpug==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:20:03 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:20:03 +0000
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
Subject: RE: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Thread-Topic: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Thread-Index: AQHcRyphSMgBlTMwBUuLP0Sgl2fvnbTV5HVA
Date: Mon, 27 Oct 2025 12:20:03 +0000
Message-ID: <IA0PR12MB7555A43B79F8C8B2B7ED18E1ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-14-skolothumtho@nvidia.com>
 <ae832b8b-5f37-41d1-b259-5bff0843eac0@redhat.com>
In-Reply-To: <ae832b8b-5f37-41d1-b259-5bff0843eac0@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DS7PR12MB8348:EE_
x-ms-office365-filtering-correlation-id: f4814a52-9383-40bd-8307-08de15532808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V1Q0c01EQ2Y5dytkbVo3V2N0akN2S0xMNmh6RzJVZVRsaUhsSHpCWnJYbUZY?=
 =?utf-8?B?MG1kc0t3YVdxemM3dm16a2RJbWcrdGdaQmQxWDJjMFkzYlhlOUtNTlVZYTFS?=
 =?utf-8?B?VTVxM3QrTi9UNEVGcVFXbVN4TTdHY0tWTllucGEzZ2R0cEpqbm5KNXppRTFi?=
 =?utf-8?B?a0EyZUk4M2RIMm1CMXA2ZmlKVklZc3lGSTJ4eW1MY2ZWcGtpaTlyaG41WWlQ?=
 =?utf-8?B?dXNKVDVEZUtudjA0ZEhseDZKTXdRMUtwemV3NUhUc3czT2wyaWxCWUMzNU9q?=
 =?utf-8?B?Ny9tcHdpYW13V3VSNWE4aEtnbU5MRTVZRlp5bjVudlpRcnlwdEwzdUhaRExo?=
 =?utf-8?B?K1lWblplOHppTjZQSjNnMjBIRkh2OTRXQmk0NXQ5b2VxOTJiU1VDdGZ1Sm15?=
 =?utf-8?B?WFZrakRic1l6SnlyK2hsSktDbFBSK3JsOWJqcFAvUjNlUnBqaCtkYTlyWnNz?=
 =?utf-8?B?d1BHdiswUVhFVmFudE0xcHNNenVRQ25NZE91Z3hHTGpSQU5FdTdMRCt3WmNr?=
 =?utf-8?B?ZHo1QWsrc001SmZEUXE0Q0U3cGhjR2ZDaWViaURTbnFydEVnNXBUa0hYNGMv?=
 =?utf-8?B?NVZ2K3Rva3JRa2VUNDY4REYraVFXeTVkWjZPczRuV0FCajFiekU0SlE4aG05?=
 =?utf-8?B?Qm1TTVoyVk1JS1JWcVlCaFlzWXh2SXVGOHE3TkZBR0NrNWxneXh6TEF2bkQ0?=
 =?utf-8?B?LzVvRGprNXZzeDdiamNWRVVZSmtKNDBkbGRxbEw5R0xEV0U1R3JJenU1M2FK?=
 =?utf-8?B?YWdLV2o4TWJ6S3ZPUFpXS2RtOVBHZ29tUnZtVllsdExyTklkbmhGV2x1aGUy?=
 =?utf-8?B?Z2c3eDVyRUFiaE1kd3hReG93K3dtUVhpaTFyQk1iK3pjaUxDSGJvcUgrbWpN?=
 =?utf-8?B?QTlPcVRaVnRkSm9TeE9ITGFNamFzd2R1MGpzN0g3ZjJSNHU0UmlKL3BBRzl0?=
 =?utf-8?B?dk56YVFNNzJ1N05BWWdybXdSaGcraGp1R0ZPTEd5S1FwMEMxUWdMOEd1QVVZ?=
 =?utf-8?B?OTJKcS8xSHFCVU4xZWNFREQwbkNKUXZuVDI0V2hLQXgvTnh5Wlg1WDd5c3JM?=
 =?utf-8?B?MzA2VjdYMXRWNzNVc2o4bndVa1cyMUU2KzRORHVSZ2FQUk8vMndRdmZMdEpT?=
 =?utf-8?B?YVVUMFRyNStBQ3dTUHl3Rk9iK1FBQmIvMytBK3hQTWVxakJPOFpqelFOekZs?=
 =?utf-8?B?NDhQUkdZUEc0U2Q5WlBYaTNEWTF2WjQvK1Q2cnlEcWcxaXpDRnNsOUhCcC9t?=
 =?utf-8?B?WS9EOEZSWTBMNW9hc0hIMEVUQkFqY1MyR3ZvWlNiRXIzR2VHL2QrRDdIRW5K?=
 =?utf-8?B?QjVDOXQ5a21qdnRJaWhsUHdIWnpOQUVKeG42M1hMeTRTU2hkc3ZvZmc5RUVP?=
 =?utf-8?B?RzZwWnRHbTE4UjVibi9FeW9TVi96SEQ3cmQrbCtjTmwrZVJOd2N1SjlZSldk?=
 =?utf-8?B?K2N1d296ZG95T1dmVldxcEUyd3V0N2cvekErNGZZTC9nRGx4cnByV3QzYmZl?=
 =?utf-8?B?UWkxNEtHdmtEVkhXQitKSmMreG8yeHB3UXNlcVhhc1VlenZxMDN5eEhKWXFC?=
 =?utf-8?B?OFdwMEhrUzhWUXh6NGhkbWgrMXVGbTJkQ0d3UGQyZkk0MGswSExqcVl6R0tz?=
 =?utf-8?B?SEJiTUxsZXVSSmVOV29heHUxaElDVisyWXBkOGhyclZqVHJEb0tHcVp5RTdB?=
 =?utf-8?B?M2JyN2dzZUVmZnhNb2lpWjdWcUNTZ0IxNCtSOStiandKRGVIZ2t6SzZUaDFR?=
 =?utf-8?B?RVhXZ01qVTkxeWFpQWhVZGVIazdmNGtBTmdXL3EvNUl2RWtXeGZwdENnZ2lj?=
 =?utf-8?B?NldhTzdLVkhnOTFaSHJSU1RWVHd2NlhpVUtRaXhoSVZKR2NhWTVaeEF2djBy?=
 =?utf-8?B?eng2V3RiU0c2NHB4RE5nZXJvQWw3em80UWg3TVJOMDJYMFEvSXNxaXN6STIx?=
 =?utf-8?B?eVUzYjVKZWEydmVqRnhESUJocXA5c2lMb1BiZmJ1MHltUjBkb2s4eGV5TTdH?=
 =?utf-8?B?b3c0VUxIcFErTWZXL1Eyc01BMmIzVDZRTE5rZFhocTRJMm81YU1lbmJQTDAz?=
 =?utf-8?Q?02aCKv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFLbFhQOWMvMVkxcWZLNS9sNCtYUElsRkY4OXlQcFJKdlpYUE0wd3d3aW9Z?=
 =?utf-8?B?NnE2VnB0MFIwN0NwOGwrVzdyZHpSbXEvVS9PTUQrbmJ4T0N1UkExUlU3RlFi?=
 =?utf-8?B?K1Y1TUk2Q0FKeVVMemZzME9zMmRkY0V4eHJOUHNqZm5iSmhjVFhQd0VVelVs?=
 =?utf-8?B?eFg1anlwd1VhclhESWw0eTdDVUF4UlN3eG9Fb2dCRC8xTUQvUjVuRTVNemVx?=
 =?utf-8?B?cUh4amFXT3ZaeHZpU01SQ3dwRHFCV0JWNzUrRjRnVzVTSGEwcWRZTUNWd1Yw?=
 =?utf-8?B?M2NOTXR5c1FkSHdtSGRjbnhDZlMyOGZqRTc2TEVqZkNMU2FBM3pPYTN6RCtS?=
 =?utf-8?B?UHlqc0hpWUZ3VFRmYW5TVG9kamhadDF6Q292WDhiN1JEVFZxYXYyQlZZYURj?=
 =?utf-8?B?dU8rQ0dPSmJhS0s4YWxmREVXL1FSc0pqOXFnV3BWaFZMRVgzWjhaaWxRWmFv?=
 =?utf-8?B?bGZlK083MjZjVlRiekh0U2pQekFoNDBzTTBkQThIYlJTRVd3OEx6NE5Ca1V2?=
 =?utf-8?B?UG1lTkxqZm0xcGplVWJxckhLa05ZUXU5ZXVmU0haYjhKV2hvU1I1WDZwcGJ6?=
 =?utf-8?B?U3UxU3Bvc1RpNXVqckY4WUE1MmNuQUk2YmxwbjRMR2lKS1F2WFRUdCtlZTh1?=
 =?utf-8?B?cDlyTzRaRkFzZC9LUUlwU0lSSGVqUmpXZERvK0w3TnpwSmlib2VjV0M2Zndl?=
 =?utf-8?B?Z3E5S2V4cmJvRkZjWDU1aUdVQ3kwK0pYNU05aE5DRmh2WnZGRmdPTk01STIw?=
 =?utf-8?B?elVCaUc1by9HeWp1UzJPaVJCKzhrYUFNOEpLUlpCdjN5SFkzaDEvV0JqNHMv?=
 =?utf-8?B?aWppcVNVaWtneFRWZ01qRXE4SjVlN3RTYnhZajNHRnJhSEpJeExzck1rRFJh?=
 =?utf-8?B?R2dJb1E5dTFLQ2xmdVMzZEY1ZUl0WW1OeGFPcnFHQTN3eTJNYmM3T3l2eWxz?=
 =?utf-8?B?ODEya1VITXppMWI1R0F5a0J1a2dqeGY3bTV1WlpVMmxDSUVNZkdacXJWcHlx?=
 =?utf-8?B?NGhiQ0VKN2ZuK1VVQ0RNOUQwNnNYd3VORjducDd0bVBDSGJ2cXM4cEVYZnY5?=
 =?utf-8?B?UVdGYUZBMDFDOTkzUWdqMWxkaDJ6eEVnbVJHREhkbGIxS0ZrL01Sc053OFNE?=
 =?utf-8?B?cyswcGhkZzJiVG14NE5UaFhweWhRbjRtT2poZ0h1MFlKMEFDVHJNMEg4eHd0?=
 =?utf-8?B?NXlTVHV4UUxXSFZyS3Blcm9ESkNvZ1JQcjVtNDRLaktMcm54ZFpsRUExY2hw?=
 =?utf-8?B?b0lkeUNHV3BESUlBR3JFaEhiSSt6VEtmWlRuc09jZTltVWtBbnJyOG4xbHdp?=
 =?utf-8?B?NUtXNmRRTTJDb1lUWlZSQWpoWEg5ZzRIM1ZhT2xFWmVmUDJ2cDA1T0ZGQ3ds?=
 =?utf-8?B?UEllMVpGS0s1MmJOZVNLaXBPWE9PNWJGSGtVdjN4VHd2ZW5UTmJqR3Z6MWR2?=
 =?utf-8?B?blBMMEFOSEp0bUtYTUgwRkdNUE1uSEMzR2xYL0hrWnV4R1RiNEF4VlpCVWQ5?=
 =?utf-8?B?UC8xOG1RU21udkkvV29MU3RncFl5NjJBL2hzVzN1Z2wwampzdEdTS0dnNVc5?=
 =?utf-8?B?c2NQbXdpSzFBNGgwWHBRTDVlcnlpR1lKNzhzeUpSUDFFT2tNVCtjYTFPcjU3?=
 =?utf-8?B?SGh4am13T2hTL3hhNXdud1Z3QVRYZXJQVDhCVDk1eGJhVzNPcFQ2Z1VNRlBs?=
 =?utf-8?B?bVJZTmVhNTEwMDMvUmV1WExzWlc2M2dHRmsvcUxRWnBwU3VrcmIzRHpkbmFC?=
 =?utf-8?B?RTBLSy9VMy9XU1I5bU03SEwwb01nMklQUFFDelFFNmFwTm1IY1dzbnFwd211?=
 =?utf-8?B?TXJhbjRNN01nOG9vcGFHVEdOL3dNb2V6VnlsVmV3NXliNXZsOWJUbGtpaWpC?=
 =?utf-8?B?RllReVdZQkwrd2VFTitOUlZHTFJGaC9CZHNCdXZlcmhSTWowdmR2UEJCTEpv?=
 =?utf-8?B?Q3hoZ2NYSmpNT00rZTYwQ0QxbE1lZktPVEN5L2hKYlJhMld6K3JzZDdqS3pJ?=
 =?utf-8?B?V001WDBEY0dVQWxjSWYyU05yMFBEWDV1bS95MVdLTkJ1MnhpRWQxYnlWV0kv?=
 =?utf-8?B?c1ZFKzNVS0dCUHpHZk9ZVzRqWGY2VGhsZ1N6cmVVVU5JWFZUYU5YNDBTRlRS?=
 =?utf-8?Q?gloEkNbaeIujNwxWI0V2M6aVz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4814a52-9383-40bd-8307-08de15532808
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 12:20:03.0963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xp45hGmjAeLqiRF4kU40v3la61nfmLRUpXp6WLzgUS0Uky38YY+O/T01hULjyj/IgzWXamrzBiQ0vdVZXv2kwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDI3IE9jdG9iZXIgMjAyNSAxMDox
NA0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNv
bGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBN
YXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5n
emhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25n
LmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBn
bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxMy8yN10gaHcvYXJtL3NtbXV2My1h
Y2NlbDogQWRkIHN1cHBvcnQgdG8gaXNzdWUNCj4gaW52YWxpZGF0aW9uIGNtZCB0byBob3N0DQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA5LzI5LzI1IDM6MzYgUE0sIFNo
YW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gUHJvdmlkZSBhIGhlbHBlciBhbmQgdXNlIHRoYXQg
dG8gaXNzdWUgdGhlIGludmFsaWRhdGlvbiBjbWQgdG8gaG9zdCBTTU1VdjMuDQo+ID4gV2Ugb25s
eSBpc3N1ZSBvbmUgY21kIGF0IGEgdGltZSBmb3Igbm93Lg0KPiA+DQo+ID4gU3VwcG9ydCBmb3Ig
YmF0Y2hpbmcgb2YgY29tbWFuZHMgd2lsbCBiZSBhZGRlZCBsYXRlciBhZnRlciBhbmFseXNpbmcN
Cj4gPiB0aGUgaW1wYWN0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1
bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2FybS9zbW11djMt
YWNjZWwuYyB8IDM4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIGh3L2FybS9zbW11djMtYWNjZWwuaCB8ICA4ICsrKysrKysrDQo+ID4gIGh3L2FybS9zbW11
djMuYyAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9h
cm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMgaW5kZXgNCj4gPiBmNGUw
MWZiYTZkLi45YWQ4NTk1Y2UyIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwu
Yw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IEBAIC0yMTgsNiArMjE4LDQ0
IEBAIGJvb2wNCj4gc21tdXYzX2FjY2VsX2luc3RhbGxfbmVzdGVkX3N0ZV9yYW5nZShTTU1VdjNT
dGF0ZSAqcywgU01NVVNJRFJhbmdlDQo+ICpyYW5nZSwNCj4gPiAgICAgIHJldHVybiB0cnVlOw0K
PiA+ICB9DQo+ID4NCj4gPiArLyoNCj4gPiArICogVGhpcyBpc3N1ZXMgdGhlIGludmFsaWRhdGlv
biBjbWQgdG8gdGhlIGhvc3QgU01NVXYzLg0KPiA+ICsgKiBOb3RlOiBzZGV2IGNhbiBiZSBOVUxM
IGZvciBjZXJ0YWluIGludmFsaWRhdGlvbiBjb21tYW5kcw0KPiA+ICsgKiBlLmcuLCBTTU1VX0NN
RF9UTEJJX05IX0FTSUQsIFNNTVVfQ01EX1RMQklfTkhfVkEgZXRjLg0KPiA+ICsgKi8NCj4gPiAr
Ym9vbCBzbW11djNfYWNjZWxfaXNzdWVfaW52X2NtZChTTU1VdjNTdGF0ZSAqYnMsIHZvaWQgKmNt
ZCwNCj4gU01NVURldmljZSAqc2RldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApIHsNCj4gPiArICAgIFNNTVV2M1N0YXRlICpzID0gQVJNX1NNTVVW
Myhicyk7DQo+ID4gKyAgICBTTU1VdjNBY2NlbFN0YXRlICpzX2FjY2VsID0gcy0+c19hY2NlbDsN
Cj4gPiArICAgIElPTU1VRkRWaW9tbXUgKnZpb21tdV9jb3JlOw0KPiA+ICsgICAgdWludDMyX3Qg
ZW50cnlfbnVtID0gMTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXMtPmFjY2VsIHx8ICFzX2FjY2Vs
LT52aW9tbXUpIHsNCj4gQ2FuIHlvdSBleHBsYWluL2RvY3VtZW50IHdoeSAhc19hY2NlbC0+dmlv
bW11IGlzIGhhbmRsZWQgYXMgbm8gZXJyb3I/DQoNCiFzX2FjY2VsLT52aW9tbXUgYmFzaWNhbGx5
IG1lYW5zIHRoZXJlIGFyZSBubyB2ZmlvLXBjaSBkZXZpY2VzIHdpdGggaW9tbXVmZCANCmJhY2tl
bmQuICBJIHdpbGwgYWRkIGEgY29tbWVudC4NCg0KPiA+ICsgICAgICAgIHJldHVybiB0cnVlOw0K
PiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgLyoNCj4gPiArICAgICogV2UgbWF5IGVuZCB1cCBo
ZXJlIGZvciBhbnkgZW11bGF0ZWQgUENJIGJyaWRnZSBvciByb290IHBvcnQgdHlwZQ0KPiBkZXZp
Y2VzLg0KPiA+ICsgICAgKiBIb3dldmVyLCBwYXNzaW5nIGludmFsaWRhdGlvbiBjb21tYW5kcyB3
aXRoIHNpZCAoZWc6IENGR0lfQ0QpIHRvIGhvc3QNCj4gPiArICAgICogU01NVXYzIG9ubHkgbWF0
dGVycyBmb3IgdmZpby1wY2kgZW5kcG9pbnQgZGV2aWNlcy4gSGVuY2UgY2hlY2sgdGhhdCBpZg0K
PiA+ICsgICAgKiBzZGV2IGlzIHZhbGlkLg0KPiBPbmx5IHByb3BhZ2F0ZSBlcnJvcnMgdG8gaG9z
dCBpZiB0aGUgU0RFViBtYXRjaGVzIGEgVkZJTyBkZXZpY2VzPw0KDQpUaGUgdmRldiBpcyBvbmx5
IGFsbG9jYXRlZCBmb3IgYSB2YWxpZCBpZGV2IGRldmljZS4gVGhlIGJlbG93ICFhY2NlbF9kZXYt
PnZkZXYNCmNoZWNrcyB0aGF0Lg0KDQo+ID4gKyAgICAqLw0KPiA+ICsgICAgaWYgKHNkZXYpIHsN
Cj4gPiArICAgICAgICBTTU1VdjNBY2NlbERldmljZSAqYWNjZWxfZGV2ID0gY29udGFpbmVyX29m
KHNkZXYsDQo+IFNNTVV2M0FjY2VsRGV2aWNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Rldik7DQo+ID4gKyAgICAgICAgaWYgKCFh
Y2NlbF9kZXYtPnZkZXYpIHsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHZpb21tdV9jb3JlID0gJnNfYWNj
ZWwtPnZpb21tdS0+Y29yZTsNCj4gDQo+ID4gKyAgICByZXR1cm4gaW9tbXVmZF9iYWNrZW5kX2lu
dmFsaWRhdGVfY2FjaGUoDQo+ID4gKyAgICAgICAgICAgICAgICAgICB2aW9tbXVfY29yZS0+aW9t
bXVmZCwgdmlvbW11X2NvcmUtPnZpb21tdV9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgIElP
TU1VX1ZJT01NVV9JTlZBTElEQVRFX0RBVEFfQVJNX1NNTVVWMywNCj4gPiArICAgICAgICAgICAg
ICAgICAgIHNpemVvZihDbWQpLCAmZW50cnlfbnVtLCBjbWQsIGVycnApOw0KPiB3aGF0IHNoYWxs
IHdlIGRvIGlmIGlvbW11ZmRfYmFja2VuZF9pbnZhbGlkYXRlX2NhY2hlKCkgc3VjY2VlZHMgd2l0
aA0KPiBvdXRwdXQgZW50cnlfbnVtIGlzIGRpZmZlcmVudCBmcm9tIG9ucHV0IG9uZT8gSW4gY3Vy
cmVudCBjYXNlIHdlIGhhdmUNCj4gZW50cnlfbnVtID0gMSBzbyBtYXliZSB0aGlzIGlzIG5vdCBw
b3NzaWJsZSBidXQgd2UgbWlnaHQgbGVhdmUgYSBjb21tZW50IGF0DQo+IGxlYXN0Pw0KDQpPay4g
SSB3aWxsIGFkZCB0aGF0IHRvIGNvbW1lbnQuDQoNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGlj
IFNNTVV2M0FjY2VsRGV2aWNlICpzbW11djNfYWNjZWxfZ2V0X2RldihTTU1VU3RhdGUgKmJzLA0K
PiBTTU1VUGNpQnVzICpzYnVzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFBDSUJ1cyAqYnVzLCBpbnQNCj4gPiBkZXZmbikgIHsgZGlmZiAtLWdp
dCBhL2h3L2FybS9zbW11djMtYWNjZWwuaCBiL2h3L2FybS9zbW11djMtYWNjZWwuaA0KPiA+IGlu
ZGV4IDYyNDI2MTRjMDAuLjNiZGJhNDc2MTYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5oDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQo+ID4gQEAgLTQ2LDYg
KzQ2LDggQEAgYm9vbCBzbW11djNfYWNjZWxfaW5zdGFsbF9uZXN0ZWRfc3RlKFNNTVV2M1N0YXRl
DQo+ICpzLCBTTU1VRGV2aWNlICpzZGV2LCBpbnQgc2lkLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsgIGJvb2wNCj4gPiBzbW11djNfYWNj
ZWxfaW5zdGFsbF9uZXN0ZWRfc3RlX3JhbmdlKFNNTVV2M1N0YXRlICpzLA0KPiBTTU1VU0lEUmFu
Z2UgKnJhbmdlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4gPiArYm9vbCBzbW11djNfYWNjZWxfaXNzdWVfaW52X2NtZChT
TU1VdjNTdGF0ZSAqcywgdm9pZCAqY21kLA0KPiBTTU1VRGV2aWNlICpzZGV2LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+ID4gICNlbHNlDQo+
ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0ZSAqcykg
IHsgQEAgLTYyLDYNCj4gPiArNjQsMTIgQEAgc21tdXYzX2FjY2VsX2luc3RhbGxfbmVzdGVkX3N0
ZV9yYW5nZShTTU1VdjNTdGF0ZSAqcywNCj4gPiBTTU1VU0lEUmFuZ2UgKnJhbmdlLCAgew0KPiA+
ICAgICAgcmV0dXJuIHRydWU7DQo+ID4gIH0NCj4gPiArc3RhdGljIGlubGluZSBib29sDQo+ID4g
K3NtbXV2M19hY2NlbF9pc3N1ZV9pbnZfY21kKFNNTVV2M1N0YXRlICpzLCB2b2lkICpjbWQsIFNN
TVVEZXZpY2UNCj4gKnNkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkgew0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiAgI2VuZGlmDQo+
ID4NCj4gPiAgI2VuZGlmIC8qIEhXX0FSTV9TTU1VVjNfQUNDRUxfSCAqLw0KPiA+IGRpZmYgLS1n
aXQgYS9ody9hcm0vc21tdXYzLmMgYi9ody9hcm0vc21tdXYzLmMgaW5kZXgNCj4gPiAxZmQ4YWFh
MGM3Li4zOTYzYmRjODdmIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMuYw0KPiA+ICsr
KyBiL2h3L2FybS9zbW11djMuYw0KPiA+IEBAIC0xMzgxLDYgKzEzODEsNyBAQCBzdGF0aWMgaW50
DQo+IHNtbXV2M19jbWRxX2NvbnN1bWUoU01NVXYzU3RhdGUgKnMpDQo+ID4gICAgICAgICAgew0K
PiA+ICAgICAgICAgICAgICB1aW50MzJfdCBzaWQgPSBDTURfU0lEKCZjbWQpOw0KPiA+ICAgICAg
ICAgICAgICBTTU1VRGV2aWNlICpzZGV2ID0gc21tdV9maW5kX3NkZXYoYnMsIHNpZCk7DQo+ID4g
KyAgICAgICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+DQo+ID4gICAgICAgICAg
ICAgIGlmIChDTURfU1NFQygmY21kKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgY21kX2Vycm9y
ID0gU01NVV9DRVJST1JfSUxMOyBAQCAtMTM5MywxMSArMTM5NCwxNyBAQA0KPiA+IHN0YXRpYyBp
bnQgc21tdXYzX2NtZHFfY29uc3VtZShTTU1VdjNTdGF0ZSAqcykNCj4gPg0KPiA+ICAgICAgICAg
ICAgICB0cmFjZV9zbW11djNfY21kcV9jZmdpX2NkKHNpZCk7DQo+ID4gICAgICAgICAgICAgIHNt
bXV2M19mbHVzaF9jb25maWcoc2Rldik7DQo+ID4gKyAgICAgICAgICAgIGlmICghc21tdXYzX2Fj
Y2VsX2lzc3VlX2ludl9jbWQocywgJmNtZCwgc2RldiwgJmxvY2FsX2VycikpIHsNCj4gPiArICAg
ICAgICAgICAgICAgIGVycm9yX3JlcG9ydF9lcnIobG9jYWxfZXJyKTsNCj4gPiArICAgICAgICAg
ICAgICAgIGNtZF9lcnJvciA9IFNNTVVfQ0VSUk9SX0lMTDsNCj4gPiArICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ICAgICAgICAgIH0NCj4gPiAgICAgICAgICBjYXNlIFNNTVVfQ01EX1RMQklfTkhfQVNJRDoNCj4g
PiAgICAgICAgICB7DQo+ID4gICAgICAgICAgICAgIGludCBhc2lkID0gQ01EX0FTSUQoJmNtZCk7
DQo+ID4gKyAgICAgICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+ICAgICAgICAg
ICAgICBpbnQgdm1pZCA9IC0xOw0KPiA+DQo+ID4gICAgICAgICAgICAgIGlmICghU1RBR0UxX1NV
UFBPUlRFRChzKSkgeyBAQCAtMTQxNiw2ICsxNDIzLDExIEBAIHN0YXRpYw0KPiA+IGludCBzbW11
djNfY21kcV9jb25zdW1lKFNNTVV2M1N0YXRlICpzKQ0KPiA+ICAgICAgICAgICAgICB0cmFjZV9z
bW11djNfY21kcV90bGJpX25oX2FzaWQoYXNpZCk7DQo+ID4gICAgICAgICAgICAgIHNtbXVfaW52
X25vdGlmaWVyc19hbGwoJnMtPnNtbXVfc3RhdGUpOw0KPiA+ICAgICAgICAgICAgICBzbW11X2lv
dGxiX2ludl9hc2lkX3ZtaWQoYnMsIGFzaWQsIHZtaWQpOw0KPiA+ICsgICAgICAgICAgICBpZiAo
IXNtbXV2M19hY2NlbF9pc3N1ZV9pbnZfY21kKHMsICZjbWQsIE5VTEwsICZsb2NhbF9lcnIpKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vycik7DQo+ID4g
KyAgICAgICAgICAgICAgICBjbWRfZXJyb3IgPSBTTU1VX0NFUlJPUl9JTEw7DQo+ID4gKyAgICAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICBi
cmVhazsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAgICAgY2FzZSBTTU1VX0NNRF9UTEJJX05I
X0FMTDoNCj4gZG8gd2UgY2hlY2sgc29tZXdoZXJlIHRoYXQgYWNjZWwgbW9kZSBvbmx5IGFwcGxp
ZXMgdG8gc3RhZ2U9MT8NCg0KU2VlIHBhdGNoICM3LiBXZSBtYW5kYXRlIHN0YWdlLTEgZm9yIGFj
Y2VsPW9uIGNhc2UuDQoNClRoYW5rcywNClNoYW1lZXINCg0K

