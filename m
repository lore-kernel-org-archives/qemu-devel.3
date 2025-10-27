Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB77FCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMGX-0004pd-J3; Mon, 27 Oct 2025 08:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDMGP-0004o9-PV; Mon, 27 Oct 2025 08:23:53 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDMGN-0003oK-74; Mon, 27 Oct 2025 08:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfli/NMONhEPCkX3KS+KwcuwygbXZQoqvCNw27CS+cuQhSICy7NQxR2AJU4ry7KVGa2gS9B9mc+cRml2irnGtOA88V5qculPT/StnDwhPcqMfhNhcxKyS5Ieaq8C53QaS/oS42k/8HIivtJagYsiBYu2J7i6oKE7co+tQABeu/udPQM8m94Euv1xdps3I1B4wOoKuf9cITNDwO5mQleS8xk4a3nSkB5a78+cFAv7Dr5j9Sr3NXxfsd5gaZ8f9nGCJoj6k4wVIsSJYE2wx8i1gNaX29K+nQ0HF4ilYNE17ISAXJjbZR0GjbHNRTAvxDIpiO2KcjxmrbR2E/ioGETRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGDhYNP9Umvom7/WjzBh8al3rcZZQeQUxBelXcDSWHE=;
 b=eLh/ABW7cdSQF9eo+PQ7qfGvsvshCZp3UaX4PE9mhHl+aYsrN4GtgH93ZbhazxYXBiSEcPk7XomP1tglSFb4yjg8Yci2U8V2vWVXhM0P4F3cOmlIfkAaJgbZzNzbmDYe0rkPC+L+tRVmSPO8b+vXrMVHB8ysz2J98vXbVkDZWWV7X1ZUm+vgjKYpEa+l7DMjyaDGz0vXpa4AOg75iWZkjc91tZZ/3vnOnyTvklxSE8/8kB2EXJqs3Dz1EUD+RCzOrf7+zFl3FLR75665rLM6BNmUzG6/UaXv6w4XHiwiuQwv/v1n/UQu+n2HLETM2/xlaFFYZJFWuM7YO6pDDp5lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGDhYNP9Umvom7/WjzBh8al3rcZZQeQUxBelXcDSWHE=;
 b=dh3nlT8tht64Ft5MtNzX2n1ubhgEykIqZFX5LaObe0oCj4tMv8O3d64EArUC/oTLD3Pp64t1hIpif/8iccFWCQf6esThaXgEJtJoVSI2uxiHGbTyNgX4ZZe7sYt+j39s9Q4QB7OZQ+KXfKsyFYvsPgHPfCzMwoLwQW8YSDFnF5WeIWRqCMht/xr2cxYlEmRwJfqKKOGYs36XrKP/INEPeokhQZdiBt29SKpFvPRY7W8ffHNPctC7l+6zPqrX64u6/LB68Ve6w+PLaarT7fBFzQxoDrgKI2q1f9BmA6qDj/iws5fBXSW+4hLzHnCU8gtB3jP64H8mF5HKEVJFNcQwcw==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Mon, 27 Oct 2025 12:23:41 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:23:41 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Thread-Topic: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Thread-Index: AQHcMtLEPA/MgQKh4UGAmorIYeppLLTV9v0AgAAbgTA=
Date: Mon, 27 Oct 2025 12:23:40 +0000
Message-ID: <IA0PR12MB7555F3F96B075CAB0AEF315DABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-15-skolothumtho@nvidia.com>
 <20251001135604.00006776@huawei.com>
 <c7253b37-23bb-4147-8415-3c05aa7c15e4@redhat.com>
In-Reply-To: <c7253b37-23bb-4147-8415-3c05aa7c15e4@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DM4PR12MB6010:EE_
x-ms-office365-filtering-correlation-id: b0fa625d-07fc-46cb-d45b-08de1553a9e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VWNyTyt1Mmh5U3RWNmMwTGNCdytsOTFOejhPa1VWTkloNVhMME9OdnR2bVUz?=
 =?utf-8?B?WENPZjJDeDlGQWxVM21Kam5VR3NDdE9DNHNjc0svRGRVanF1SHJadnByRVU2?=
 =?utf-8?B?Uy9nQ2tPNEdrNWkweDFjVzhJeG94U2FJbkZxNDVBMXliTXNWaExITDYyU3VF?=
 =?utf-8?B?TkUyMlN4bUc4YUlGcGpnZ0lCSSsreHVzY0pVSHhKU0RrWFpDcGxYQkR6cUJ0?=
 =?utf-8?B?MDVFbEVBRzdrY29XK29jK2NSdWg2OUhkc0RneTF0QjZrVHkrVXhtM0MvN0FE?=
 =?utf-8?B?Z2h2a2lYdUVEdWZFNVpOcUFaZisvUmdvZ3Urb0Mwblc3OU1VcStkOUcybEtl?=
 =?utf-8?B?SVJwTDRYR3ZNdUM2NC8wM255VXRCMUZMUVNMaGhNUnpkWkRJWVBGS0tneDY0?=
 =?utf-8?B?ZE45a2dwRndTVGkyb2Z5dDA0bHhyZDE2S3dWRVpWb2VQc1BqVStiZllYREVG?=
 =?utf-8?B?R040VW0zZkcwbDhKTlBERkFuRk1NSTRJd2RWVHhSaDQwUjA5enUxdlVWdVJ6?=
 =?utf-8?B?aHNGeGRxUGhBdTJVV2dEd0VPUkdXU0NqZHgzSEduc3lLUVV0ekFNWERrMnFx?=
 =?utf-8?B?WjNhSTgyME0zNnBaeWVvM2RWZHA3VmttckdOL0tvUTd1dkluSXI0UmM4T3ZQ?=
 =?utf-8?B?ZWJKelB3eUhOd28xdFBLRE1CRjdndUtCRUVPakZjY0pvZVB3c1hxWW1WNENT?=
 =?utf-8?B?VERDaHJ1SkV4MHdvQ2hRTUp2Wm0vSkJ4T3FrV3JtUlNlMUUvWS9QNHFJVFYr?=
 =?utf-8?B?VmNFdVF0UUhNQi80QVlrSTljNDRzYUt5am9ia1VQODBOdDlKaVFTZ1BNdjdM?=
 =?utf-8?B?b0pTeElRSGMzOElrd1hFbmhMWXJMeFUrSWk1Ym9vc3k3ZDBFSFBXMkh4QVBQ?=
 =?utf-8?B?QURjYXR1dWdIVUgyUFppUlR6c2xEOS9KRjd1RXhvcGU2WnRmbUptVkVSM0o5?=
 =?utf-8?B?c2MxaWpxTmFwNWtjakx0WUhDSFdVNTM1RzVHNWNwck1nMkxFeFA2MlZpS1V2?=
 =?utf-8?B?R0lndVpHd1A3N2ZaQ2ZlMVJZRy9VWWg5Ull3emVVTjFzc3BMMTZyTmhpKzFm?=
 =?utf-8?B?cVNCbWZENlNQVSsxK3lKdEZqdFZKcU5VTkFxR05wdkgvRFVhYmcvQkJkbmdt?=
 =?utf-8?B?M2pQQzlvOXlMRGpORVZJa0tMc0xCZHJWRFRzWXo0NHE1YjdKbTZjUldxOURI?=
 =?utf-8?B?YXExOXR5bkVuTEZhZnJwNWV1dERZTVlvb0NwMHRpMzZzUzFvd2ZxaENVaFRq?=
 =?utf-8?B?QTFnK0crUG4yK2tDR2ZBZ0lIV0VubGhWWXZnNDg3UXBwemRqalR4d2IvaTJR?=
 =?utf-8?B?c1BQMDVqbE5zcXVNeGRXZFpaeDNiRmRiT3RtRmlSMHBTdGtKWTVhWU9kVWc5?=
 =?utf-8?B?N1VjcFphTUhRaTZkSlVqU21BcjVMQk45MU1OU2NGZHNpd21lS1ovcXkyeFRo?=
 =?utf-8?B?Qk0xMVA1bFdlcUFPaWRzaHZXM2J1dTNvWmF2aE5tNXhYUjE5V29WMkYzdGgv?=
 =?utf-8?B?R2NUZlhjbjFwTXJYMVZMMDVBSW95SzhHVTVvL0lTU01sK01tSjI0eFU5S2Zv?=
 =?utf-8?B?UjVmV1VicXQ5a0tRZkNDdWhlUWNUSElNaVBvaHc2dVVJdHpTSTN1VkQ4cjVI?=
 =?utf-8?B?VVFKL05ldTFtUUtNWmhOTTFtNXBmN3ExS2JCVTdCbllYdmorV1ZkcDRqQXNx?=
 =?utf-8?B?VGlBUHd0V1dab2dCMGg5eTJJeVJzelhpcGJpT0lkZlhmVGhvc3kvN2htcWxF?=
 =?utf-8?B?eGxqNmpJZ3VTNCtYU25mNEplMVFmQ1ZpNU8relQvZGJDSnVIRVhmN1RKWFYx?=
 =?utf-8?B?dTNrUkk2QXhVMTlpLzAzNHRpMGxYbDRSaU5USldiZmhXRWphQnVJM2F4V2wr?=
 =?utf-8?B?NHduSUExOHVmbUtZWFNwcVdMRTh4enRZTUpnazdrTmUxaGJ0cU15TmF0NFVS?=
 =?utf-8?B?RStCS2dTZ0NoWFpIM3ZxK3paLzdBZDRrc3FwODczVml3bFVVcW9uRHBUSGpZ?=
 =?utf-8?B?THUxTERkM0ZJVnY1cE13TUNPTTBsWXEzdW5ZaVJEVWJpQ1E3b0JnaWdmK3J2?=
 =?utf-8?Q?oAYB/Y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTdIc1hjd25UR0NLWlBINkxSUnJiRUJWam1UNUQxT1RyU1pPVlh1SkFXMk9l?=
 =?utf-8?B?L3VzaEp5NS9UZ05KMmZYWUppakVFRlEvaElKSmc1WE1CWUpyaFd6SWVsTjNk?=
 =?utf-8?B?Qkt4ZS9SNUV5Ymp5UHFWY05ORHgwVkhhbU5ndnQvM1VwYkIzU0I2R3NNaTR3?=
 =?utf-8?B?aG04eG5WWm1Ic2pCSWw2bnN5UmptSUpZeGVtMHcyWFhxb0h1TWFWakplNXFZ?=
 =?utf-8?B?Z0tMM3dLSjNSKzVzaEFxUjBOU2IwcGp4NFFYZWNOK2MwdVc0QTJSRnJXdHZq?=
 =?utf-8?B?NGhXL3R3VXdvOUVtL1pDNUVDNFdJRkFRRW1tUHM0NklmeUJVL0h3LzN4MFE0?=
 =?utf-8?B?dGJYVXMzRHBsL0loYUlEeFROakNlcjFNK2IzanpjWUdlMitzVUFCdEtnMFV6?=
 =?utf-8?B?S0Vtb09XL3RiWG45eXVqUGdrcTNXbjBkRm1FWldtWFI2c2xYZndaTmVTeXUr?=
 =?utf-8?B?di85aG42UGZ2QWp5OVpMTXBXYTRUTEozRkhZVzRaNytpV3VyYVpWK01oemN5?=
 =?utf-8?B?TkpmbTlsOUtmQ2k5YVR5WUMyRWZjU1ZWbHBjN3lINjJXTXQvVVZDZkpmRS9N?=
 =?utf-8?B?UWt2aFYzdDBNQnJmT055dUpPYkV5Mis1dXBOV2o4KytpaFpaM0ZZL3pJZERC?=
 =?utf-8?B?bnM4MVV4aXhFZjl4ejZrQUVxTlB1Mnd6aUhZT0RzaDFzNnhlMU8wM0wwSFJI?=
 =?utf-8?B?R1ExUUZlODIvMG5OMW1BYm84dnpIRGNPZjF4aFM1clFHR1A3VlBhVG52MGNU?=
 =?utf-8?B?djBIR1R3SExkVmZvMi9QR1ZWT0wyeUxESEwwZU16YkRRSWFOeG1IaFdQVlFB?=
 =?utf-8?B?UFN1eXFlZFowaWF6c2c2eXI2dlFOMmkvUnVIeE03K2ZxVmsweHBYQWdZS0I0?=
 =?utf-8?B?dUFYMnpPSE1MWm5TaUNRVFZLMUx6aXN6bmNtUlZqUmQvcUJzeDNYM2NzRkhH?=
 =?utf-8?B?S2JVZmFpbEZhdVViRUR6RUNub21qQzZhWEM4Vnlrb0NBUkpuYnlTZzA4bGVy?=
 =?utf-8?B?L0RTRTJVRklhQUMzK0lNQ1B0M09LcnErSWJSZENjNUxZK1hnZjQ1MitxekUx?=
 =?utf-8?B?bzk0bG1KbURsNzZBenpwaytsOEZ2T05HOXVPRXlrWjdTU3cwd3RpZEdiVnZa?=
 =?utf-8?B?M1JTNm1hcDI5Y2hRVjU1V3ZuZGRONDVzRWk3Y2U1RktHdDVlRkcyYTN1dVRv?=
 =?utf-8?B?WlhWejR3NTYrVmlPR2pqY21TMWN4c2JYNGpPZ0VTR1JKQlVkTnRYaGhJTFZl?=
 =?utf-8?B?bmNNUGNGa2tkcHh3STVOakdsVWYxYVVGbVk1d1p2cjVHVmdhaUp4UWJ3Q1pV?=
 =?utf-8?B?alZuUTM3QkNzUENwNEtUMDZ2L3pkMGZuOWZ5QTh0dEVMd0g0QzBBVDA3ako0?=
 =?utf-8?B?Wm9UNDBHZGUvUWVsTFlQc1VxRlY2NDlqV09pVXZHbml5RlBmcUF1SU93TnhN?=
 =?utf-8?B?Nzc1Y1hkWmZOZHVvSmpybjFsVFRTcmxMdjhMK1hXa3pMdzA2OTdGa2Y1dWF4?=
 =?utf-8?B?bDQrZzJNZVJFWDcvTE1Tc1lESEF2ZXdEL1JMUUhOWXBDYjBSOU9sbHR2b3l6?=
 =?utf-8?B?ekZjcWRwK1labUxrU2tiSWl0Z1hUaWVadVlRTHoxU3FqLzVhT3Rna1YxNGxV?=
 =?utf-8?B?WUN6ZS9EeExvSU8xSFFDeStBZkNGOUU1eVJ4VXlhc0tHZUFyK20wT1p5RmlJ?=
 =?utf-8?B?VnIrelJKRlpDS3lQT0RFUHJPcmFrdUppNkdNU1YxcDluNHlrMjR1M3NGTm1y?=
 =?utf-8?B?Sm11b0ExWGNZQ0o2djVocGJRN2JBSTRab2hSb3ZOK3FYckhFakhRejJIMmQr?=
 =?utf-8?B?aThnTEF4Y3NncjBPWXUyQ0FXOUUvSm15Y3l6QVZEaldLck1aYWw4VGVJTG1C?=
 =?utf-8?B?OU9qemkwck5qVTRGdnJBb1NJME9CQjUxNUFsQWRwWTBSeTdrK3pXSkJHU2wx?=
 =?utf-8?B?cFo2SFRhdzFLKzR1eGhlTmJ0WTE1WC9jc25YeVRzRGxtNlZMN3hISE56SnMv?=
 =?utf-8?B?clh3RWluSExpVXlEOHJBaFpkNFFzYjBjS2p6bnl5d3Q2VDJoQjQ0aWxVMlJH?=
 =?utf-8?B?emZrcmVsczdHMUVEVUpFNXIzVzlnY21aUDJFTWVYWlV5QTFKY2lHNUVIdGRw?=
 =?utf-8?Q?9vfg9KuvB2yWtyODRtH064ybx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fa625d-07fc-46cb-d45b-08de1553a9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 12:23:40.9762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhr7EC3IS5us7zTlIUCE9jIyaJVaglJP5NUxHj+izyaGALEIBZgNjVpKloXG5pz/DidoW7YAgIO7Ztg6N/b+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIwMjUgMTA6NDINCj4gVG86
IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IFNoYW1lZXIN
Cj4gS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9u
Z251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4NCj4gPG5p
Y29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5j
b207IE5hdGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hz
QG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29u
LmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7
DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFt
ZWVya29sb3RodW1AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTQvMjddIGh3
L2FybS9zbW11djMtYWNjZWw6IEdldCBob3N0IFNNTVV2MyBodw0KPiBpbmZvIGFuZCB2YWxpZGF0
ZQ0KPiANCg0KWy4uLl0NCg0KPiA+PiArICAgIHZhbCA9IEZJRUxEX0VYMzIoaW5mby0+aWRyWzBd
LCBJRFIwLCBTVExFVkVMKTsNCj4gPj4gKyAgICBpZiAodmFsICE9IEZJRUxEX0VYMzIocy0+aWRy
WzBdLCBJRFIwLCBTVExFVkVMKSkgew0KPiA+PiArICAgICAgICBzLT5pZHJbMF0gPSBGSUVMRF9E
UDMyKHMtPmlkclswXSwgSURSMCwgU1RMRVZFTCwgdmFsKTsNCj4gPiBUaGlzIHNlZW1zIGEgcmF0
aGVyIG9kZCBzaWRlIGVmZmVjdCB0byBoYXZlLiAgUGVyaGFwcyBhIGNvbW1lbnQgb24gd2h5DQo+
ID4gaW4gZXJyb3IgcGF0aCBpdCBtYWtlIHNlbnNlIHRvIGNoYW5nZSBzLT5pZHJbMF0/DQo+IGFs
c28gY29uc2lkZXIgcy0+aWRyW10gYXJlIG5vdCBtaWdyYXRlZC4gSSBrbm93IHRoZXJlIGlzIGEg
bWlncmF0aW9uIGJsb2NrZXIgc2V0DQo+IGluIDIwLzI3IHRob3VnaC4gSSB3b3VsZCBzaW1wbHkg
cmV0dXJuIGFuIGVycm9yIGhlcmUuDQoNClRoYXQgaWRyWzBdIHVwZGF0ZSBpcyBhIG1pc3Rha2Ug
ZnJvbSByZXdvcmsvcmViYXNlIGFuZCBpcyBub3QgcmVxdWlyZWQuDQoNClsuLi5dDQoNCj4gPj4g
KyAgICAvKiBRRU1VIFNNTVV2MyBzdXBwb3J0cyBSYW5nZSBJbnZhbGlkYXRpb24gYnkgZGVmYXVs
dCAqLw0KPiA+PiArICAgIHZhbCA9IEZJRUxEX0VYMzIoaW5mby0+aWRyWzNdLCBJRFIzLCBSSUwp
Ow0KPiA+PiArICAgIGlmICh2YWwgIT0gRklFTERfRVgzMihzLT5pZHJbM10sIElEUjMsIFJJTCkp
IHsNCj4gPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSG9zdCBTVU1NVXYzIGRlb3NuJ3Qg
c3VwcG9ydCBSYW5nZQ0KPiA+PiArIEludmFsaWRhdGlvbiIpOw0KPiA+IGRvZXNuJ3QuDQo+IGFz
IEpvbmF0aGFuIHN1Z2dlc3RlZCB5b3UgbWlnaHQgYXZvaWQgdXNpbmcgdGhlIGxvY2FsIHZhciBo
ZXJlIHRvbyBhbmQgYmVsb3cNCg0KRG9uZS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

