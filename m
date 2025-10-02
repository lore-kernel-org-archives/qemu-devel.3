Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A67CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FmQ-0007rT-9m; Thu, 02 Oct 2025 05:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4FmM-0007qd-FI; Thu, 02 Oct 2025 05:39:15 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4Fm7-0004ac-T4; Thu, 02 Oct 2025 05:39:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0hGxVtr0iTGKCq+1bJgkDsp2p2pBTMHIOfo7OLe/6Z9F8iKV23iL4ou9J5DnepTTFSbnXsvHrYB46SB8KVvBxcTcuDk93hcDsuSFFYrnWdzessOYNpRg8wfTBHsXFA565iamLR9+kJ86Au1QLMEchOb8AWg+74ZpkjzegPKCWLcOGtw2OvTgV3siJQmUAIKiFjp0bxWrXmBWEOgf6+vwitsys/orzYbdYj39NNIitCTFWsFYDtjKK5BqesGsD04mGJI+WRMd1Ed+5glG0SDqdHhJ5lPFhGCVjIgDzvM1jXkyDo4l2d3eWkmI6z8BqHGxICSSWdZJoQz0mGxlTItGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbQMRF8JAf4Y9Qdda5er7asVbc+iJoCNgVPO7pTjrjQ=;
 b=PEycssSrTphItLeADpoxjN2tkJkSyHdsG1yjyri/xCbMyXdksZ1Q0yhWdxLyD9cy77zAqYHzbWg/i0qAO9osJrAvSwfgPlhTkb2zd1beHD7gbaqC65FgmVsEpB+2+F7nQ7HdFmOB77TaNk2gbaxCL58eKih5J3xK5U85wkgOPFfGs9UB8jT4cNnnF/KP2xaYn4t4SHXR20ZIv/I8FdXMEJhhazmMkfQBRdFnxB+2Amp2r4Hx3dz2w0ZnbE69V7Tj0qamDqdVAfpyiFFIVJDNTdGpqgzxWGBbr9B9HzGswhQa/A9qIsPRdbDMaBYUM39TQ/vToHsUSrUXssqyyzeDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbQMRF8JAf4Y9Qdda5er7asVbc+iJoCNgVPO7pTjrjQ=;
 b=XNHGD9PG8yQ1N7axHqI/eK+jLaXHQZ0eDbizjNpYEPWUGJZ7r1CqArG7/n7iU1UrnAVr8vtmY6dlSSi6jsQ0d0m65WKwV/9GVEN/BlzDHLyLJfj/fbyazoqga7Yukc74Va0+qRP+JdiNYCiIH94ef6JwVL8Bqt372EX/ZsSoL4xqmMfYU2ws/JUczlQQvTawQHMkvIxadUod4/OB1jptwu5wnIzJeIOnwUza8BYpVFzTnkIILquQXcmVIoY0i85X7/PJ2AkPXK2I1Z52Bph247ixNLanL+d082Geb+BUGFhqH5PpRTMB5ng5W7xq5m52Ucm0tdt0fT5/bhzLg+uL9A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Thu, 2 Oct
 2025 09:38:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 09:38:44 +0000
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
Subject: RE: [PATCH v4 07/27] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Thread-Topic: [PATCH v4 07/27] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Thread-Index: AQHcMvn2KiEpuWsEjkm0y+nsfZoJJbSumLMw
Date: Thu, 2 Oct 2025 09:38:44 +0000
Message-ID: <CH3PR12MB75488A0A98B26690D5A573B5ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-8-skolothumtho@nvidia.com>
 <55de40c2-7d33-4806-8eb0-e4dde8d0c84f@redhat.com>
In-Reply-To: <55de40c2-7d33-4806-8eb0-e4dde8d0c84f@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB6342:EE_
x-ms-office365-filtering-correlation-id: 062f58d9-6ec8-478e-fc38-08de01977ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OHlyRU91RWtVeW5YOW1nRm04aFR2d2tpMGhDNDFvamlOUEpPR1lENjhEQnFk?=
 =?utf-8?B?SmJ6ZCthQmlhbEJIbVlNUVdadXpWT1M5dDRzM2E5RFcrUWthYURFWHJ4U1NO?=
 =?utf-8?B?Tkg0alM0QnVPMmpUQ2pHUWZjZG9EMVRiV29lL1dzL0I3MkppOExFQ3lhWHM3?=
 =?utf-8?B?MEFUODY2cHJBUVREYU84VG9ucVZGYlhjalE2aGhhUzE0TmM5R1ZLdmx3MkVW?=
 =?utf-8?B?OEtUMUl0NWtPNDF2NUJhY0YxMm9uejZEUjJURlFzajRSU1pTQjlHanRhS1Zi?=
 =?utf-8?B?bDBLY0o0eWFZZVBmSnhncFBJeUxtbmk0VVJaVm1XR0puWkNaek4xdW1XTFl6?=
 =?utf-8?B?cHpkUDFQQnNlS2puTENnazVoRE1iaEhRc3dmTVhzVmFYUGtFU1VDakZnK3ZT?=
 =?utf-8?B?R2FPclA2bGRXNUhPM2xCcGdnbHZCRmhqeGJMZ0FBbCs3QVNXVXZqQ1dacWIy?=
 =?utf-8?B?S3k3RnZJSzJ6RkZNekpMcStHVXFWNW5YY0Y0TE1UR3J0ZUc3SUFKQUZIVks4?=
 =?utf-8?B?TTY5dG9aZ2RQTnMyd2crbVp6UFNPOUNyUFQ3V2VJYi95eUlBa21BUUhQSnNV?=
 =?utf-8?B?c3I5TlFmS0hZZ3BqMmJHNDhMWFBxUENWZHdwMHo2ZkRyVUtneXdrRGIxbTQ4?=
 =?utf-8?B?MFgrNEh3eE0zRzRYTHlZRlFGZm1XSlVrUHk5WWdqMTNKQ2NMOW11RUJWaU9j?=
 =?utf-8?B?N3pKME1nVk9OSG9ac0lNbGkrVy92RjZYU01vT1RmRzIwVXgrNFVUNGQ2UTFa?=
 =?utf-8?B?aTZHWjFXUEZCOVhIUGdSUzZWaXZDRWc0RStxUWo1SCs0TWtOcEZybnVCWGk4?=
 =?utf-8?B?Y2J3ampNVG44V1cwb3ZvL0poR0pQclF1aFIxSlc4L3hoR0pFbzFTNXhFVG5i?=
 =?utf-8?B?SjY3b1lWRUlRclJzejRFSkJDTmZkak1OckxWdW1IS2dwQWNNcVVROTdCUkZC?=
 =?utf-8?B?ZGRkd2lQWUZ2WFhzODhicXkydzFjbFh2b3FDV2l5Z0FodGR4UXI0dGhNODBT?=
 =?utf-8?B?eDRETFlJajNhUkYySzlTWmtXMUt1MVRENjJ6WTUxaGZYUllBV1dkWHczd0JP?=
 =?utf-8?B?ZEMrMDM3ZE8rd0IxUUlucHdTL04wcGI5ZEg5Q2VYRW9wV1gwak1KdHhKVkhZ?=
 =?utf-8?B?QU1BdFhaMDhXT3RxZGNDbEc1N1NkamFHV3lGWUlkd08vdmRlSHVoaVY5VTFQ?=
 =?utf-8?B?N1VDMlhmOWZiWlk3RDlHNGZhbkxsZWx0Rk4wdjlXYzBlRlpnVDJtK1JQQVRN?=
 =?utf-8?B?Z3djRjhYVFJFNUZVWU9Nd2NYZVdBbkQydzd3bFhDckIxcXJ6VHFoanY2dHpQ?=
 =?utf-8?B?UEh0SUYzREpOSFYrVkg2Zk1JMmJWMWtucktySXZwRHFTOG5VUGZ4QzNLc2Ft?=
 =?utf-8?B?Vzl4SDJ5V0dKZXZaVU5oOGRXYWNqcTNtTHBaK2gzR3RjaDh6c29xUWw5QVA4?=
 =?utf-8?B?RmxOY2NOZHRjNE8vRUFJZnlTKzFBYWVqWlVvNWRlTTRIWjY1cFdtM1I5dnZp?=
 =?utf-8?B?TUZtRWsxYkU3ZWdURVlPNkxyUjFGV1pvT2hDL1VRaGJybUQvZDR5RnArZUJX?=
 =?utf-8?B?L1RnWEFrMWxPL1FZQ1RMdEFyR1c3K1FDczJPdjR1eldSUDZ6OElyOEhXS2NJ?=
 =?utf-8?B?d3M4Tk1yK012dzM2TkFlSjNUenF2eE91aE5vd2plQ0YydlVaYWFvTmVTYzFB?=
 =?utf-8?B?cFlUODBFZkVVQzBaSXpjaEppS0ZzYXp4YWtGZk4wQk5lVUFFQUI1WUloWTJL?=
 =?utf-8?B?OXRuN1Z2bVF6NlJjZkJyMU5DRzQwbGpiUnNxY1JFK2tHN3puRGtSNkNJdXo5?=
 =?utf-8?B?dDI4bEFLOWE0bGlNcGM2b2FiNkduZld1NVZPTXNmYll1TWF3N1UrK243R0lH?=
 =?utf-8?B?L21FTUp4LzQyNVVSbEVBR2RFbUplRno0bE1JVjg5aFR5aXdRdlV3Snd1NFZP?=
 =?utf-8?B?SHRpMXErWUQ2QjdoK0J1RkZPOXI5UjhqdVlXWlo2MUUzSzhhQWxZZGJLbXJB?=
 =?utf-8?B?SkptdnJrbjZramRVNjVrZ3VISSs4N0lzQVJoN2RkWm5ZWGRPNG9kWS9IQ3ZG?=
 =?utf-8?Q?z7C5qe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmM3TnIzYU8zUDgvSXE2SGlZK0wya0k4RDdDbVJDZEJIQTdBVnNybGlHWnhG?=
 =?utf-8?B?UUpkYWJ5ZGJ6eWtWSVFSUTVnVDM0cFp1MjczSGZzTkczd2JIa2Vqd1Z6SGkz?=
 =?utf-8?B?UGJYeGlOK1Z4RmZldVJ1cnpxdGpMaG8vZXhEejZxTXBrMFdPVThKWVhPeVoy?=
 =?utf-8?B?ZGdlRmUzam1rTXd3Nll5cGdVRUF0QjQ1VjVpemVvb1FLWUl3b2I5azdNRmh0?=
 =?utf-8?B?alNEbmRWc0pBaC9rVmhyTTdDUFZyMCtPTG9wa0J4WmhZczVIcFhaZnJqaTFN?=
 =?utf-8?B?UlArUFhMVjU1NTk0M0hLdmRESVhHb2hPcVFScFI2QmJnOTZsOE52OG5TZDhi?=
 =?utf-8?B?WEdZWUNwRUlsT0VtaEJoRXNEQjJrOXMxMjFZNngxSlpybkk1bUZxWHhrOFZZ?=
 =?utf-8?B?eHRIY2gzSWVVK1pRRjBibmROM2xOOHNYUEZYcGFMK0p0ekV4WXBZSkg0bHNp?=
 =?utf-8?B?L0RXNEdpamdkalMwU3dBSmMzSVJ5VE5SRVE4MlVyRTBSUDlYREYxYnBJR0ZR?=
 =?utf-8?B?d0lOVC9tU2Q2WnlwNG1FRHZXcmJPOHorY1Y2U0piUzdzU1A5bStVcndTZjVi?=
 =?utf-8?B?MXlFc1lCSzBRdXN2djRsN3VhdWFxaHp3dVV5bHd1Z1pmRUlaek5Ob0xCVC9k?=
 =?utf-8?B?cmNJUjNJQXBNVmpRdDBGdFBvK2lXTzYwQVdUYUxBVktXK3hGUmFkemlkYlVv?=
 =?utf-8?B?S2hpYUZ3ZDJsYzk0ZThKWldlc2IrS2xaQU5kczFZSFlETXBRTllINWFWcVB1?=
 =?utf-8?B?aHFXVFdwTlVoQzYwUzU0MEYvNUV2V2FaQmNCLzZhVkM5eld3ajhMQmlydkMz?=
 =?utf-8?B?dFJYcGZaUExBeGhtQW5YVHhPc0pDZGFlUTZGdlZrN2lzeTdpcnJmeXpCeXJC?=
 =?utf-8?B?MFJOSnEya3dNK09sVWdDVEc1YjdUVjRyeVpUSFRFbXBnYkVjdFlGK21tazVD?=
 =?utf-8?B?Njk4dXQzeTk2WmZjVE1meWI1cCtQeHFONFZoc3lIS0pFa0Y3UUw2eXZlK1VX?=
 =?utf-8?B?R0p6Nlc5cjRZNEdVT3h0dEIrRHkzdElhaW9aRjdUMWpJZFZiSndIQzZLUyt4?=
 =?utf-8?B?ZXZnL0g5cmVnVXU3cGZlTSs5N211T0ErekE2Vit4OEF6K1YzWTZocGd2ck1y?=
 =?utf-8?B?dkNtZms5Y1hWelk4T3RiaTMxcTBBTjNSQUNZTXZHaWRvMGI5WWJMN2kxVktX?=
 =?utf-8?B?U2hnSjVobzgvaXpPMjJoRGd6cW9QVFpvQlBQdnF5cnRDMWt5TmM0YzdhZ0FC?=
 =?utf-8?B?aFRlM1dlYmJNdS9GZmxLeVU1T0tYYXpoaVRTYXF0bEM2MkV5bHBtaHZESVN4?=
 =?utf-8?B?UTRsdFFLNjJabW5tZDNHZWxJZ1NZY2Q5SjFkYmVjVFk0Q1BBeE04Q01iMUZt?=
 =?utf-8?B?K0FEa2pUSzVUNVJQb01oZXBxSGRPV3F4Q0RSK1AwNVMvT0JKVW1hWWNiaDZt?=
 =?utf-8?B?VmFBaCtOZE9VVFhCVk81QUxncTIwSGFSelNYZEpJSG5EWTlMWW5LcW4vbWwv?=
 =?utf-8?B?TVRqYlY4cm0yV2ZOSTZUcGtwSlYwNHhEeGNJNElGOWkxNUh3NURYdldUUjd2?=
 =?utf-8?B?R1ErcnN6M3RBVUkrQWt1aEt3b0dJNFM1ODd4MHVmZ2NXbk5JSXprbU9WTXJa?=
 =?utf-8?B?c3VWYmVDOVAyNC9QdkhVM050bjkzemc4VG94ekVKZEhzdVJxaW8wM054NktG?=
 =?utf-8?B?a0lKNzlIdXNpZWIzYlZjMHRNVWZDRlBjekFTOHJDK2tSUWhQeXEvbld2ckhl?=
 =?utf-8?B?ZTdUekFyV2JuTDhVR3hUUHBXQnF3YkQ3RUlXMklRSWNPQWVkb2hQc1gybG41?=
 =?utf-8?B?YzI3RzlPT0t0SXJXQVdjeFRZNmxDUDVJUkhXb1hvNWpHMjRqMjNDUk56alBV?=
 =?utf-8?B?Q25VRFlDYXpNSVE3Z3B1QVJWOFVMSi9GWmlFL1E0QW1NT3JhVVlaV2RGQ3hW?=
 =?utf-8?B?R29ZZ2plamxEODNhTzdWaVhZSm9STzFJellYbk1sekVoMzdkM05ZZDNXTDBm?=
 =?utf-8?B?OTIzMWc3aG5kRmtwUlpwNnRGVnBBZHYyQnhNS1JqQndkZEtZQWZxNjN1dzZJ?=
 =?utf-8?B?Uk1CNGpGeVorL2w5RWxDajEzUXR5UFU1VWVuTG5nOVp5dThlNnV0VVpEcytV?=
 =?utf-8?Q?3/U/qRxQHT58k3wesFcQOMwI3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062f58d9-6ec8-478e-fc38-08de01977ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 09:38:44.4441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChLHS/fJDTFk9yJRtIo8vYftQMLfXIik/EP/9ZodIE/ODYtad9qflBICMLAArRWXdsz16aR5dHUQHEMbX7y/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwMSBPY3RvYmVyIDIwMjUgMTg6MzcNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbg0KPiBD
aGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hz
IDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhp
c2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFtZWVya29sb3RodW1AZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDcvMjddIGh3L2FybS9zbW11djM6IEltcGxlbWVu
dA0KPiBnZXRfdmlvbW11X2NhcCgpIGNhbGxiYWNrDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhpIFNoYW1l
ZXIsDQo+IA0KPiBPbiA5LzI5LzI1IDM6MzYgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+
ID4gRm9yIGFjY2VsZXJhdGVkIFNNTVV2Mywgd2UgbmVlZCBuZXN0ZWQgcGFyZW50IGRvbWFpbiBj
cmVhdGlvbi4gQWRkIHRoZQ0KPiA+IGNhbGxiYWNrIHN1cHBvcnQgc28gdGhhdCBWRklPIGNhbiBj
cmVhdGUgYSBuZXN0ZWQgcGFyZW50Lg0KPiA+DQo+ID4gSW4gdGhlIGFjY2VsZXJhdGVkIFNNTVV2
MyBjYXNlLCB0aGUgaG9zdCBTTU1VdjMgaXMgY29uZmlndXJlZCBpbiBuZXN0ZWQNCj4gPiBtb2Rl
IChTMSArIFMyKSwgYW5kIHRoZSBndWVzdCBvd25zIHRoZSBTdGFnZS0xIHBhZ2UgdGFibGUuIFRo
ZXJlZm9yZSwgd2UNCj4gPiBleHBvc2Ugb25seSBTdGFnZS0xIHRvIHRoZSBndWVzdCB0byBlbnN1
cmUgaXQgdXNlcyB0aGUgY29ycmVjdCBwYWdlLXRhYmxlDQo+ID4gZm9ybWF0Lg0KPiA+DQo+ID4g
UmV2aWV3ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90
aHVtdGhvQG52aWRpYS5jb20+DQo+IFdvbmRlciBpZiB5b3Ugc2hhbGwga2VlcCBib3RoLiBJIGRv
bid0IGtub3cgdGhlIHVzYWdlIHRob3VnaCBidXQgd29ydGgNCj4gdG8gY2hlY2suDQoNCkhtbS4u
IEkgZG9uJ3Qga25vdyBlaXRoZXIgZm9yIHN1cmUuIFdoYXQgSSBmb2xsb3dlZCBoZXJlKEkgd2ls
bCBkb3VibGUgY2hlY2spDQppcyBhbGwgdGhlIHBhdGNoZXMgSSBoYWQgcHJldmlvdXNseSh2Mykg
SSBrZXB0IGFsbCB0aGUgUy1ieSB0YWdzLiBUaGF0IHNlZW1zIHRvIGJlDQphIHJpZ2h0IHRoaW5n
IHRvIGRvIGFuZCBJSVJDIEkgaGF2ZSBzZWVuIHRoYXQgcHJldmlvdXNseSBhcyB3ZWxsLg0KDQo+
ID4gLS0tDQo+ID4gIGh3L2FybS9zbW11djMtYWNjZWwuYyB8IDEzICsrKysrKysrKysrKysNCj4g
PiAgaHcvYXJtL3ZpcnQuYyAgICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0v
c21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBpbmRleCA0NDQxMGNm
YjJhLi42YjBlNTEyZDg2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0K
PiA+ICsrKyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+
ID4gICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiA+DQo+ID4gICNpbmNsdWRlICJo
dy9hcm0vc21tdXYzLmgiDQo+ID4gKyNpbmNsdWRlICJody9pb21tdS5oIg0KPiA+ICAjaW5jbHVk
ZSAiaHcvcGNpL3BjaV9icmlkZ2UuaCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS1ob3N0L2dwZXgu
aCINCj4gPiAgI2luY2x1ZGUgImh3L3ZmaW8vcGNpLmgiDQo+ID4gQEAgLTEwNiw4ICsxMDcsMjAg
QEAgc3RhdGljIEFkZHJlc3NTcGFjZQ0KPiAqc21tdXYzX2FjY2VsX2ZpbmRfYWRkX2FzKFBDSUJ1
cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+ID4gICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgdWludDY0X3Qgc21tdXYzX2FjY2VsX2dldF92aW9tbXVfZmxhZ3Modm9pZCAqb3BhcXVlKQ0K
PiA+ICt7DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogV2UgcmV0dXJuIFZJT01NVV9GTEFHX1dB
TlRfTkVTVElOR19QQVJFTlQgdG8gaW5mb3JtIFZGSU8NCj4gY29yZSB0byBjcmVhdGUgYQ0KPiA+
ICsgICAgICogbmVzdGluZyBwYXJlbnQgd2hpY2ggaXMgcmVxdWlyZWQgZm9yIGFjY2VsZXJhdGVk
IFNNTVV2MyBzdXBwb3J0Lg0KPiA+ICsgICAgICogVGhlIHJlYWwgSFcgbmVzdGVkIHN1cHBvcnQg
c2hvdWxkIGJlIHJlcG9ydGVkIGZyb20gaG9zdCBTTU1VdjMNCj4gYW5kIGlmDQo+ID4gKyAgICAg
KiBpdCBkb2Vzbid0LCB0aGUgbmVzdGluZyBwYXJlbnQgYWxsb2NhdGlvbiB3aWxsIGZhaWwgYW55
d2F5IGluIFZGSU8gY29yZS4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgcmV0dXJuIFZJT01NVV9G
TEFHX1dBTlRfTkVTVElOR19QQVJFTlQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25z
dCBQQ0lJT01NVU9wcyBzbW11djNfYWNjZWxfb3BzID0gew0KPiA+ICAgICAgLmdldF9hZGRyZXNz
X3NwYWNlID0gc21tdXYzX2FjY2VsX2ZpbmRfYWRkX2FzLA0KPiA+ICsgICAgLmdldF92aW9tbXVf
ZmxhZ3MgPSBzbW11djNfYWNjZWxfZ2V0X3Zpb21tdV9mbGFncywNCj4gPiAgfTsNCj4gPg0KPiA+
ICB2b2lkIHNtbXV2M19hY2NlbF9pbml0KFNNTVV2M1N0YXRlICpzKQ0KPiA+IGRpZmYgLS1naXQg
YS9ody9hcm0vdmlydC5jIGIvaHcvYXJtL3ZpcnQuYw0KPiA+IGluZGV4IDAyMjA5ZmFkY2YuLmI1
MzNiMDU1NmUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3ZpcnQuYw0KPiA+ICsrKyBiL2h3L2Fy
bS92aXJ0LmMNCj4gPiBAQCAtMzA3Myw2ICszMDczLDE5IEBAIHN0YXRpYyB2b2lkDQo+IHZpcnRf
bWFjaGluZV9kZXZpY2VfcGx1Z19jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQo+ID4g
ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgICAgICAgICBpZiAob2JqZWN0X3Byb3BlcnR5X2dldF9ib29sKE9CSkVDVChkZXYpLCAiYWNj
ZWwiLCAmZXJyb3JfYWJvcnQpKSB7DQo+IFRoaXMgbG9va3MgdW5yZWxhdGVkIHRvIHRoZSBnZXRf
dmlvbW11X2ZsYWdzKCkgYWRkaXRpb24gYW5kIHRvIG1lIHRoaXMNCj4gc2hhbGwgYmUgcHV0IGlu
IGEgc2VwYXJhdGUgcGF0Y2ggb2Ygc3F1YXNoZWQgaW4gdGhlIHBhdGNoIHRoYXQgZXhwb3Nlcw0K
PiB0aGUgYWNjZWwgcHJvcCBUaGFua3MgRXJpYw0KDQpCdXQgbXkgdGhvdWdodCBwcm9jZXNzIHdh
cywgd2l0aG91dCB0aGlzIHdlIGNhbid0IHNheSB0aGUgdklPTU1VIHdpbGwgc3VwcG9ydA0KdGhl
IG5lc3RpbmcgcGFyZW50LiBCdXQgdGhlbiB0aGUgZmxhZyBzZWVtcyB0byBiZSBpbmRpY2F0aW5n
IHRoYXQgdklPTU1VICJ3YW50Ig0KbmVzdGluZyBwYXJlbnQuIFNvIEkgZ3Vlc3Mgd2UgY2FuIG1v
dmUgaXQgZm9yIGxhdGVyLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

