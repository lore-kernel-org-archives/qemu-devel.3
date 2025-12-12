Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9A5D4336E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 05:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTw6q-0007kl-Fr; Fri, 12 Dec 2025 00:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTw6m-0007k1-Jc; Fri, 12 Dec 2025 00:54:29 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTw6i-0004Je-Cr; Fri, 12 Dec 2025 00:54:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnLTKl96BVk8g+cY+bLRWqGRAP2qFLjgmsnwiu9EEtflNK4TwFfBBCWWJPhNT3NhTwSub/c6QhCnn5zN1X2YQTPYF5WCHBrF/g98eomTycKL2VFNXNUyzeRWlHO+rqQmBgmpfF7yf+AvOIKV5kBmOk4H4SvS6xmE7ZKrcJc+rilienshVDVD5XX8A1yG3e3kWCWmBdlY9RKKtUo77KhUfbCCwUCiRw7eyu4L8/D/qmRLsQC3X3h4HSt4YSNP47qA84uRs0MG/MkezU9jZ276/4Ak6yKdO3azlC1O3OPx6uMge0nleW8Ut5xcs1KOqGoyO7wQiDNMCXZeU4UgXhVX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDtMF/YXgj2NqYjbZxpwmoc01WK0V45tkcAuRSZwxPE=;
 b=D5mEyjDhXqDxcuBZjqSDKF75ME/1Wn+r4YqcthQIjfyukwmRnJwizpaJuS3vStm+Rdl74BmGMjsA+avWz8/9M1Yp9ZmBu8Tuut3j5uupB5MIYjwix0utf0lIzyiE6oy2MbAUJC8WsDGKXG0rTbUZzEvxek28luK/c19Z6vIc/WzfG0MSeJeyyxRpfbYLb/isFD7tA+e3Q51asD7cF25HqZKRgeyeomMdkxX6eoeefo3sTdVqUaddJp8nymCm8ux0z/mbhV1aWSOxDCwaMFAB407NE8Gc2Vex4J0n5MWNXA6zrA83T2C0046mscKR242tualI6l0I9oIU9L7MFXa4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDtMF/YXgj2NqYjbZxpwmoc01WK0V45tkcAuRSZwxPE=;
 b=LIT8rjYuVX9XqrGDPB4pLmCq6MC0j0RIRvO2cMCuZif4bMwpB7D7aoGqdTV5sLm1oXLfv6dCXY1wAAFP7jsHOLqOAXHkErdfUEVCCTH9fEQzcB8wcgReeU3zH+NdqIx+xgw3I+3cNLmzNDCY+LXbCNFNeztVIoZL8q5FPLg3JXDsYs4GPgH+jolWuuaLUJefBqFY1lkR6yaT13sHXUIiDH2Rsae1+0C3EMJ0eJ2SEKWmc9SEamv0P8NQLuHATMXhpd8+4UOBQXBm35YdSIcvETiS2pFJeLiZTd2uEbRqNNvMzQVTAk8k9R7HKpynL0qFgnrdzJViQ82876336H53kQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 05:54:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 05:54:18 +0000
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
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Thread-Topic: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Thread-Index: AQHcWiFC5ZutjosMpE+DcYfPDxJ0SbUco9uAgAD+RpA=
Date: Fri, 12 Dec 2025 05:54:18 +0000
Message-ID: <CH3PR12MB754853F04A2EC378033533B5ABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-9-skolothumtho@nvidia.com>
 <52ad0c7a-29a3-4222-ae94-05400ad38796@redhat.com>
In-Reply-To: <52ad0c7a-29a3-4222-ae94-05400ad38796@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6204:EE_
x-ms-office365-filtering-correlation-id: 3e1c3564-fe3d-40af-7a10-08de3942e3de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?andYbHJtNkU4NXBzZWFJME8rVmQwTVFPOUQrZU4rVUVmeGhPdXlIQjRGQ2U4?=
 =?utf-8?B?cEV3dFovU21ueUxCRFIzakZ1Z3FpdWZ3NnVXQmxZcWNnMjRxcmZ1YUlzNTFH?=
 =?utf-8?B?Ty9QcjVSa3QzK3lZOXV4OXRsbUN0UGRwOC9OMEZhZi83V2dmUDN3eW9ia1Na?=
 =?utf-8?B?TmduUWE5dmRsVldQcnZBZExOdXRCM2h2NEk0OW8zUDZTNTE5Zk92R0RxTU9Q?=
 =?utf-8?B?d2l0ZDNCbkJSdXBGSGxhUkJIOFJUais3OWFBV1d3eElaZkh6UmhEQUgrL2hx?=
 =?utf-8?B?OG5LcTNxc1FvZmNqam1kYW12S3V0aER0YTF1ek9JaXlqeElqU1lqSzZTcVBo?=
 =?utf-8?B?REFkYjkzVituWEJmTTNQZDIvZlRQTk52ZVFsanEzbUJpcDY5RVBLbXFCcVBZ?=
 =?utf-8?B?Qk4xdnhESHRydkZHbG03MlVjeGhldjMvOU5PMmgwYnF4cWFxaWlRQWZyM2M1?=
 =?utf-8?B?Rkt1a1R5SUZSeUoveHpWaEhIZG9rRTJjcm1HTmNWWlloS3BxYTZuTm85Tm5C?=
 =?utf-8?B?RjNDT2dNdFNxd25MeTQ2QUNOWEV5U245S3oxWHVOMmEwdUc0cFZmNXNZa0tj?=
 =?utf-8?B?OUxSbkNwUXYxMjVHTVJwd0hObjBHeDJiMTAyU1VUTzA2azl5N0NpVytFR0Nk?=
 =?utf-8?B?ZVZSWVhWOXZickxMSVFnbXJhMUxlVWc4RzluUW1VSjRNMG4xdVoxMFpnbHZj?=
 =?utf-8?B?eGNXNE5uUWd2a0gwaWpUZmVubktVUGpEMnlFV1BvZWZkQmRjOGttb3l0ZjQx?=
 =?utf-8?B?cXpYWm5FanVmT1c5dUo4YmIyYUtjSERPUzVYQVE4MjArSmx3NEZhRE5TL0hC?=
 =?utf-8?B?bWVNUkNjbHhxMzZoK204N3VaSGtmb1hIS1JLVERka2xRN0J2SDVWNm9TNVRa?=
 =?utf-8?B?SlNVV3VmeWNmUmVzdlVQQzhtM3JPWnZKekVrWmVJYWczWnBpeTk1YWdrZGRP?=
 =?utf-8?B?dHZtdnVDenp6NS85bmw1cnByd3FCN3NYOENHU3VzOWhFaGluekk0aEdaODcz?=
 =?utf-8?B?dWF3MmQzcUh5Tm5RU1Azd09yZE1KdVEzUmRLN3A5QmtwQ1NSS1k3YVFMS09C?=
 =?utf-8?B?dVRlUmk4RkdRM2xwMVZhRlJZeXE1NnVhZHVDdnRPVGZKUS81QWJnYTgvTHlT?=
 =?utf-8?B?aENKRlp4VUtDUkxzRzVTL2dLeW1ibWova0xUSVNJT29UYWRjVEJ3N1VmV0or?=
 =?utf-8?B?b3dNL00zNlEzcmJ3TnpzMkRkMnhyU0pUd3EyU3Mvbkg2ZlVYNC9jYzJyK1Rx?=
 =?utf-8?B?R3JXNXF4STNMdVhUd09DRFkwdFBnc3dRZzl1UTlaWWZ0V1hkL0RMbU1heUp0?=
 =?utf-8?B?dGRuVU1HU3BFYUVDKzVMb0puTitiRXFUNVRVTmp6ODlPZ0xrTkpGVEQ3UEtv?=
 =?utf-8?B?T21yQlBqMm5EUjZiQk9HZmZTVkNtaHhUWmowd0lZQ1pDYWlSRG5zMzluUWQ3?=
 =?utf-8?B?eTBKSElGMDlQYWJjNjJuSVJsNGx0eHZEZG5LNThZNkZRa3B6Mm9TeXNIdnNv?=
 =?utf-8?B?R0FjRmJFZ1lvMStNdDVyUzQwV1JsUEIwRjEyaXVKQ002WkZTSmI1VzFMdUJO?=
 =?utf-8?B?Vit5TUw0MW5HQU1Cc3RoMlRWeHd6dWF3QWZTT0M1S1E5WWRjTWRRRGk5WXFD?=
 =?utf-8?B?NzZpY3FxYUUycGlCcG9IalpKbU1FYThteGRIbU9GczBBL1lNTjVROUZCQnF2?=
 =?utf-8?B?aGxDUFYrYzFFdlN1M094K0xzbDRqK0twQTlaY3MyQUZaMFhkZ3IxWUpNNXVa?=
 =?utf-8?B?aHd4ckVSWjBtRjFHY0lBa2RJbXBRTHFBeHA0aHREaU1EdFdTSVVSM0JINkQx?=
 =?utf-8?B?OHlwc3V6TDhrMXpRVVFjQ0VaTytUeG14NHlqemU5S0ZMK2s0T2V6V0VPdThO?=
 =?utf-8?B?RHpRUUtKY2hRcUFic1M0VEphRzlLZThJTFpDYVhYQjlwM2xxdSsvUzhWKzRN?=
 =?utf-8?B?dFhENFFlNHNSZHZxS2RCSTd4N09kTm0yNFdGaWs0RVhWZzBiaTlELzlUeTBr?=
 =?utf-8?B?cDB4ZUltNHV6NlVwQWMveDc2N0l3SldxSTU3aFBwVXNTSVNzMzJMeVVUbml1?=
 =?utf-8?Q?/WzrFX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1d1QlRsSkIyREs1cWxhQXFrNk0xVkFVSVBiRjFqWWc0SS9OcjdWbG9HOTQr?=
 =?utf-8?B?dktpY0MwUVE5NHhDYmNsYWNhVkhDZ1FJQUhCN2xYVmpUSjVFQ0lWUFh6T2tP?=
 =?utf-8?B?SnRWYkFxTnFBSTlUb2c0QVprcnRPMStUUldDbEUwYkpZZDh4WW9WTW9aSThj?=
 =?utf-8?B?QW42OFhiVkFqMy85bXgyUktZVFJNL0FEeUoyVFZXeTV0N0xTRkgzS1hUNm5a?=
 =?utf-8?B?TUQvbjlxZGg5S2hzOUZEYWJ1U1E5UStBREtFeVlhVjRHekZSUmVsQnFFTkdq?=
 =?utf-8?B?RTl2YjRIOHZha29WRFIwVjc2N0RRS0ZlRmoyNnpOMmF4ZXFOS1FiaFppZGhj?=
 =?utf-8?B?Q0VFWTVKVFRtZVRiK3VxUlFGRzhoaVRBZHMybjI5ZzBwdVVOdk84MktLNkg3?=
 =?utf-8?B?VUF5N2Njckl5allObDFtVERRR1J0b1ZaS2pJNjgwTU5PMjJEemMxbDE1ZHVz?=
 =?utf-8?B?UnJTMDNVa1MwR1RVYWJEQkJDdDY4cis4T0VtcHcybEZvSzd0Y0VpSUQvVXRT?=
 =?utf-8?B?cnRMcGZXTExoZThSaWQ2WXdxalhaeVRtUTk3Z3A0bXRyNWRocGhHaDA0a2Fq?=
 =?utf-8?B?QjhqY1RQcXZNaEw1Tkx2Z0I1L3pGZE9JV1BXd1ErbkVMSmoxbi9sMjNiRUtM?=
 =?utf-8?B?aXZOSm1YS3gxajF4dkZaSWI5eklnU0hEeUdPQy9Ob3ExaE5yNXpCeFFEcWVT?=
 =?utf-8?B?QjJjMHJUMzcvaHF5Vk5Zcjd4RkZINjVUbkJodEZzdlVQUGpUeWo4Q0Q0bURl?=
 =?utf-8?B?bVJvaHlqZHg3cWpLOHdYWlZLZjBEbXdtUFl3WVRIanpxUERHWGVhYWNvL1Fj?=
 =?utf-8?B?bTZsOVVNZ2p3SjhIQ3ZpUFlmb250Q3ROMStLZmE1aUFTSm54THpzdGZxMFdE?=
 =?utf-8?B?RUFuejhkdjFMMlFOeE1RdVJIRlE5dHdXbkZ2bmZrM2dwazBKUG85M092ekcw?=
 =?utf-8?B?MVlXWTdFM3VCOU1lR0xyMktCWFFJa2dwVXZUbEtBTVVKQjBLd3dXb29WNlpY?=
 =?utf-8?B?ZXlJdHduUFlqSXBkbWhyMjBvYUhZaUx4OXVNeHhRVEdGZTh5YXdxU0x5T0lV?=
 =?utf-8?B?SzZHcENLQVRMRlJsdldiVk10NjBFNnUwUjlPZWVvdzNRblhEY012OFkzNVg1?=
 =?utf-8?B?SkhKZGNYejRlcFhlaS9SNURURCtuTHE5STlCQzdhZXJLcS9JRXQ1MnkxOXhR?=
 =?utf-8?B?S3R1aFNoaHRnc09SMlc5eFVwcExxOVNqaHVxbXZmNlFoWEtNWUZmK1lvb3dw?=
 =?utf-8?B?Mk1HMTErY3NhaU53MlBCNWJKMVA3UHRHR0JCbmE5Z3N5TUtuNUlKdVIvb1p3?=
 =?utf-8?B?M1laOGpKeGdOb29HREt6OUU2Q2tQRFFOQW5yWGFFMGtMZ3V6K1hyZEJJdmM3?=
 =?utf-8?B?UG0venVUU3JiRTN0MC9FQTBCc2VvQms5eEE0d1psU1F6N0lnREE5OFFpR2ps?=
 =?utf-8?B?Q0NsQ1J5QW1HTEM2OVNwS1J6aWdkekxFeDRHdFczbHErQUNobDVWaVYzTlVS?=
 =?utf-8?B?eEV4ZDlqTVVyczM5bm1paGxYSUtTV0FrcnlTUHlFOVVnbUpQdE9GVjRUcHFQ?=
 =?utf-8?B?WkVqTkxyck9uaTc4dnhjMytENUpOZVNuVmV5alNKTGxHd2puNHJWNEoxVG1F?=
 =?utf-8?B?MXVUbEhUVUs0Vk5iakJxWWxYdFVUZHg0UkRwU1M0ZDZBVjFiblNYMnZnMnVo?=
 =?utf-8?B?cENtNkxCSE5LYjlRTUJ2VE1XbjlZcXhIamlNZC9Rc00xUWwyRm5IeUJlUmRR?=
 =?utf-8?B?dnJjRnFDbTFWdFVZcmNkdkcwenZZNTQxOXZUMVhpZmZPcjU2R0dKMHcxQ1Ny?=
 =?utf-8?B?akJiR3loYjJMbUxvc1M3MTlRcThuNUlsSnZOZ1p3UlJsa3Y0NGNZaWRpeWhj?=
 =?utf-8?B?VFZaOEFZa0M5bEdkMkJBSzJlLzlQOFppc0Y3MlZITUtmZG5KMzVhWnNXbUsr?=
 =?utf-8?B?Y0UrN0xRYnJaZU1NSXV3Ri82WW1nb1Nhb1ZLZkpUOFEvbnM5MkNjbWNMaDFs?=
 =?utf-8?B?SVZDTytKNmVXQ2RVQmVhZUZGdlJ4TWk3U2xwbU9USlh4UkZrbFNSekNsYUl3?=
 =?utf-8?B?NURUYU4zelNjVWZXcGp3WWFuSFJTOE9lU3J4MTZid3YyVllrdlMwZkpmTjVE?=
 =?utf-8?Q?EKmqJ0mqKwZDHrKJJwvhfVHbP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1c3564-fe3d-40af-7a10-08de3942e3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 05:54:18.6703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxFYZDhNE9NpDDHYgb3G6mDNPZaucmK1mwx2BGX0NKwxgpDZ6RtmHw+yD+lIr4k0nUHAnj7W7s6b1ik4zUuQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
Received-SPF: softfail client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxMSBEZWNlbWJlciAyMDI1IDE0OjQwDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUNCj4gPGpn
Z0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1
dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbg0KPiA8bmF0
aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3Rh
ZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1
YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxp
bmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0K
PiBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPjsgTWljaGFlbCBTIC4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDgvMzNdIGh3L3Bj
aS9wY2k6IEFkZCBvcHRpb25hbA0KPiBzdXBwb3J0c19hZGRyZXNzX3NwYWNlKCkgY2FsbGJhY2sN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+IA0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiAxMS8yMC8yNSAxNDoyMSwgU2hhbWVl
ciBLb2xvdGh1bSB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgYW4gb3B0aW9uYWwgc3VwcG9ydHNfYWRk
cmVzc19zcGFjZSgpIGNhbGxiYWNrIGluIFBDSUlPTU1VT3BzDQo+ID4gdG8gYWxsb3cgYSB2SU9N
TVUgaW1wbGVtZW50YXRpb24gdG8gcmVqZWN0IGRldmljZXMgdGhhdCBzaG91bGQgbm90IGJlDQo+
ID4gYXR0YWNoZWQgdG8gaXQuDQo+IA0KPiBXaHkgY2FuJ3Qgd2UgdXNlIHRoZSBleGlzdGluZyAu
c2V0X2lvbW11X2RldmljZSgpIG9wIGluc3RlYWQgPw0KDQpCZWNhdXNlIGl0IGlzIGNhbGxlZCBh
IGJpdCBsYXRlciBhZnRlciB0aGUgbWFuZGF0b3J5IGdldF9hZGRyZXNzX3NwYWNlKCkgY2FsbGJh
Y2sNCmR1cmluZyBwY2kgZGV2IHJlZ2lzdHJhdGlvbi4gIEFuZCB3b3VsZCBsaWtlIHRvIGZhaWwg
dGhlIGRldiByZWdpc3RyYXRpb24gYmVmb3JlIHRoYXQuDQoNClRoYW5rcywNClNoYW1lZXINCg0K

