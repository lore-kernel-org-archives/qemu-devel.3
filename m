Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF06C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtpz-0001zk-Um; Tue, 27 May 2025 08:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJtpn-0001xM-Bb; Tue, 27 May 2025 08:55:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJtpj-0003Ye-ML; Tue, 27 May 2025 08:55:11 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjdXR008389;
 Tue, 27 May 2025 12:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=VQLlhASqffQ0SAMA0p7tbhdT+8CTOlFDLBXnSaMk9Js=; b=
 se6CQoJvEIbLMTUEhg/QC/XwY3kXMeQHgddkp6+6Kr34lSaLql9PbAugtDUhnOcX
 vOWRfsnHo4PV9FDV5aWJ3Hp2b+TK3MrOlf5tLAWSYi2fb9xXfyvusSiYe+2UufCf
 hHuFpzpcNRNUWgdJ5fxPbz/Ho7IteyL7M4mO0oL2z/0z851xi5gzPMKwfwuprUgB
 yRzqB6qFwJ0oA3928Icmxi8uH/160ncmiumST2jq8ovHBe1LEYug5HXO6w/ugEBJ
 +ocRkIccL4PGdQsDRB2JXOBvLXntrVjP/LqZzqlUIKJ98gWmjb62aiwVU/5luC/h
 mtZQYnirAk58fSkuFuTRBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2b65b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 12:54:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RBO7hJ028417; Tue, 27 May 2025 12:54:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4j8urkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 12:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPBV8hmURdMXu7KKSg6JErn2Kky+LoHDHdynpUDS6/hRSRde3HW2Nsuvzby8gVLzzXDVJ3dnlJz4DznnU5ltMF/tRmSg9KdqV1lXkWtNIK0zIfEELVSDXRJx1OqRgvYbLaYrHAb0batG8sA8IHbPP5/2PaT13R/APWn7F/cqlAVc3CDgDPRQ8GbVdsHzYPLQ3sflkIRsvxL8Ln7tRS2aJssEC2PNNBYf9zMoEfaY3FSwVCHFoOzAs+ZFZacLIP6xrCqIoJKPsg9eMrY9xU3k9roIf54yhEmGvbUkku/8mXBdFfiK2jUm2AOoYpMq5eOfRWHXhHr6ILFzj5UTsezPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQLlhASqffQ0SAMA0p7tbhdT+8CTOlFDLBXnSaMk9Js=;
 b=GrolZUYY6h4zlq3tDJLHgKc258zKmrPrvDR4LQj0ELe+MnUBFE/4nLVBUttbJDAd9mqltfPtGK5nQiVG6az9tk+B2XiAQ7z4yZ2LFkPc8CzSdwvbGbOLFI4aFZRN4pRhay05XZ0DruI3KQQwNL1qSLCXDFLxrSXluCxooxc6R9/ntVfsxVvLfJfS+Hnt4lquryRW8IPTFfpmwKC/OIgiXUyAvSnxx1H/wiGkYPMihmcW1H6lQnC7Fvn1s7LW3B2vcKDNtWyiKGucN79xHOSgbtbTmE4Yg6yYt/fLBqVpaAqvdgWcKkw68A9x7hM68ihaK1xDKzXNO2v7y1LSzb14oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQLlhASqffQ0SAMA0p7tbhdT+8CTOlFDLBXnSaMk9Js=;
 b=U0Dhs3WfuudkkFZPWu+ucG/kxxi6FShK58fwa2pyrK4seHO7jviYP8Z0CktabVwX+Hdm2MN5Mo3OH06J3hi9hEyZ61HF5FBYqbETUQ7XMpWdMA4lDCIU6tSWTBZb1cxm2wllaP6+bgHaqBmceIQMtBQMrpCL7KwB0B49SiR/Uy8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7978.namprd10.prod.outlook.com (2603:10b6:8:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 12:54:54 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 12:54:54 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Marc Zyngier <maz@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "gkulkarni@amperecomputing.com"
 <gkulkarni@amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmWKEAgAAIBACAAA7CgA==
Date: Tue, 27 May 2025 12:54:54 +0000
Message-ID: <822E77EF-9802-4F16-B8D4-A48F3A624151@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <C10D9293-32F7-4834-9CEE-6AFD4BDBC30E@oracle.com>
 <86ldqidzyl.wl-maz@kernel.org>
In-Reply-To: <86ldqidzyl.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS0PR10MB7978:EE_
x-ms-office365-filtering-correlation-id: e93f7cc6-5c67-4dbb-a17e-08dd9d1dad5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MDRzc3NqcWlhNGdNek02Y21aTWlvZC9MWldzam5XKzQ4M2xmTjRkTGd0OTQv?=
 =?utf-8?B?MlJwdzNhbnFVUzBnU1NMakpxSWZ1Sk1vM21TWVBzakthS24rekpLdVp6TlJ4?=
 =?utf-8?B?MUQ0ZDI2TzlndTlLQXFaSHBBZmY2K0JEN0RMb3BFdXBXT0IycXZ3ZlRqMnJm?=
 =?utf-8?B?UmVUTzIwUDBwVHh1eHAxSzFDOVhWVHNOaGxjQklUQzNtNGtuQ1pyQW9obzd4?=
 =?utf-8?B?dnRGOWF2YXB6M1RhYmUvN29FVmJoLzBETXgybG5UNDhGOEt5NVNQQUdUMHFD?=
 =?utf-8?B?RXFzdFF6aFVTM3R6TjVzZi8rM2V6b3NRdHZGNXRPK2hvZVo0ZGk0QnBEVWpZ?=
 =?utf-8?B?cTkzdTBwL0I3bVZEamVOYlM2T1dmQlZPdTFYR1NFRi9mVjB3U0FINHZXTCtI?=
 =?utf-8?B?eUlpVGZYUzc4aEptdUpoa3JLVFZKWVhIaWFJUFZFREgxdXNDRDBLcjNzbEhq?=
 =?utf-8?B?UDRDdmNRSlhkSGJLKzJ2VjZDL3BNTHpZZ0hhM1hKclRtY0htSHc1NHBmeExh?=
 =?utf-8?B?QWpXU0JvY1o0dThCVlhUV2FLMExrRkMwM2hwakg2UDJUQTlhbmJHMHV6aGpZ?=
 =?utf-8?B?M3NMTlh4TEJNeDc1Q0dXQ2h5NHN1TmZOWTFwdmU4SGN5UEw2ZXRabUJhVS80?=
 =?utf-8?B?eWRvaFpEYzREYVdKY2QrNmtSVGkvV1B2NXBMMkRrRTltczhWUG8zeW5KUnBo?=
 =?utf-8?B?MC9ZVFVMRkg0bVpycHlRV0ttb3NaaDZ3QlAzbERDb2Y0K0hzYlRJYzQ2dkNZ?=
 =?utf-8?B?K3htaG9EZVJsRCt6ZHNBZmI4NTArS1VkTW9NUDF0RHcvOXdTQmY5TWFtUmFQ?=
 =?utf-8?B?ZGt1M1BQSDNFbExyUkhPb3NjaGdjaXIwTFcvenQ4WEp1MndoYlNRODlKaGZj?=
 =?utf-8?B?ODhpbDZSckpVUzVLQzIzWmJQaGRtM1A4ak9GL09lOVNsblBFSkw1ZzZ2Y0Vr?=
 =?utf-8?B?UjI1dlFVMldQTlV0c2FWOEw2cVFzZXpIaWRvbnl0TUpjMDJrWmphS3Joa3la?=
 =?utf-8?B?K0E1R3B4VnNFQmNQbEVzWHlGTjVndDhFR2h2NmcxMGtXOTBIa3oybXQrSHo0?=
 =?utf-8?B?aGEydzVTQVp4cmNEdmg2ZEpNalN1MW1hSCt5eDh2VkM3OUdwQysxMndjTEt4?=
 =?utf-8?B?bSszRk5mS1E3am1UYmNhdUc3bjJVY1BTZnB1NVN4L2tKN3ZJRHBTK1JIMFRz?=
 =?utf-8?B?TFdjOEV6enc1c3V0a1dCS1pDVkdLMzNzRnBMQnlCTGtKeVBickNCQnVSUnJs?=
 =?utf-8?B?WnhHendSMVJ0NEZ4dWdHeHZjL2FjM1BjVnJUU3EyVVU4TUtjRHFOMmxQdllN?=
 =?utf-8?B?Tm1Cd0JKa3lzN3B4M2ZlUXg0QWRCTjFCbzV2eEV3RDFkQUg3NS9rN1NGM3JV?=
 =?utf-8?B?N3BpdTVSNjlEM0I3SGxhbldXYkkxU002YmdmcDZIR0lsdkdTcmxEVjVlUEFa?=
 =?utf-8?B?WHJndm5xRFpwUWdKRjE0M0QxN1dXaVlUdXJqMFJPZEYxRTMvOUhHeEs0VGZY?=
 =?utf-8?B?NEljOUptV3UvNDgzT3NFWlMrL0Z3SUc5bUxQSWNWSjFmbUN2MW9Yc3M0NEZB?=
 =?utf-8?B?ZUV6aDA5bWhTV2dGS3picDFIVGRBSzUvSEJkOUxVWlI1akFyS1QvZ3BwNVVa?=
 =?utf-8?B?S2dNV3h0ei9sUzU1bTE3UTBaSEwzcythTVlEbVZDdHRNdnBzMTBlQjRUeVFF?=
 =?utf-8?B?Q2JTS3F3a2c4SWRyNmp0WmQwVm42dEF5QVZUUFhiUm5MTUcvaGJOWExzcS9I?=
 =?utf-8?B?NnJwaXdYUi9BR1VIYnRXVmM5L3Z0bkpZYzlOdnhERVdQbUhtaDlMRmJiSUlw?=
 =?utf-8?B?UTZmS0Iwdk5sRGxLM3o0WVJhSURXTnhQNFY0SW54dEU5aGwxSitxZnV1TlZ3?=
 =?utf-8?B?emV3UzU1SHZST3I4UWhTZ1VLcHlod2xCZWNiWVBQMi9rVkE0U3lDSFhORWxK?=
 =?utf-8?B?b3ZBcy9yMk1UQXVHZU1rZTRhY1I4U0JIQTFOME5OSHlhdC9jRHZRTEg4RktS?=
 =?utf-8?Q?R8F8a37lxAq6tS3DUjuQs8m9x1MiM8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1FqOE9DOE8xRkNhTDRMaTBPTFZDTmZCVXhzSm5TTlJOYmczSmEzRDdjL0RH?=
 =?utf-8?B?dEtRWVFTNWVKbkpEdUQ0Sm12VGJOM24yS0xsWHlKRDV1d2Mxem1Tc0F3S2Rx?=
 =?utf-8?B?NlpIVmRabnRDSGtZUmlub054bnZmNUgyU09wVHpBNTRmbnJDUlFkbWMrUC9l?=
 =?utf-8?B?cXU2QmNGYlRjcmJNcUlMelZGZWlnWnMrZ1l5SlJPaXVyVTZrOFNELzZKTHdp?=
 =?utf-8?B?eHZ3cGxEcFZMeWo4Rjh3eG5qWWowc3VjWW5oaHprVVRsb3YrdlNkV1JlQ0cr?=
 =?utf-8?B?b1BxOVlqaU5NSks2OEh6cWxPSHhmWFNITjl6RXpMRTZ5czlsMGEyOUpqR3Vn?=
 =?utf-8?B?Z2daazBvZ2pkUUlYNUw2emRiSlphRGw1V2YxS2wrVEZ1clo2SWFjZzNUMnRl?=
 =?utf-8?B?aXJHVFh3dVQ5UEpYTjVvUkEzRFpnNkQzTS81d0tuelhMeDJLaFZ0VGhrMTB3?=
 =?utf-8?B?N3ZJeUIyNHFYMFlTVDZYTjJydzdBaDRVbi8vbm01enNhNXEraFhqZ2NyZE1W?=
 =?utf-8?B?WC9oYi9ad3dJdkJFUEJicWV0ajA4Uk9pVThFdDhkYTFJV3JUYm9aWklOdVZv?=
 =?utf-8?B?QXk1RFp5MUFoU1h5ckNDMlVYazFrZnJ4T01qUEw4UlJBMUoxNjVDZElsRUQ1?=
 =?utf-8?B?REx5dEQ0VlRVdFY3YWs1L0JCRWYvbEExdStQR3VnZGlVeHlIWWFmYTJMTHJY?=
 =?utf-8?B?ZDYzOEJURklONTM1QUhBTW4xaExaWVB4cW9ITkR3NCtwempCbUl0WG1VZ0dw?=
 =?utf-8?B?eTQyVzlLZHB2Z0tSZW1vMHNzOUp1N3ZVU3QyblQza3dBMWpaaXczNzZmMjZP?=
 =?utf-8?B?S1FESTl0SlNXUGJZTWFJWm5iWE5MdGoxWEI0eklMNUZlM3g3Z1o1R3N4bnl1?=
 =?utf-8?B?Rm9DTjhvYk1VSEIzQll1Y0ZNeStHdDJQaTJrTWZ3WVA3Ni9WREc3M2tGQ3U5?=
 =?utf-8?B?TFd6WHExSmpWQXNIdnh5cjdycDJsZmgxWk9pWGFTbzN0eHVhR3AwMXdIcFlv?=
 =?utf-8?B?T2ZUdy9zQXJxTVpwNURWMmE0OUJoN1V4Tm5QMDZGbHJia1hlb0ZmWmJ4SkNS?=
 =?utf-8?B?ZUE0SlpLdis3VGtiNjZVRVkrSUNrQkdTcEY4TXI2WEVINkV1cUZjV2o4Z0FE?=
 =?utf-8?B?OXB1TDdTWmY0QXdMM3lrZkhYRS9WKzBzNGdveTJXR0luMFNBampKL3A1U0JL?=
 =?utf-8?B?RklIUjFsNXVxdGEydjdiL01jaFJrRSsyeFBlSGlXZlZnR2lOZjh6TUcxK3Nr?=
 =?utf-8?B?SXVxUzVLb3AxN3NVNnVycTlybVB0V2FZM1dScUdKWTN4Rmkrc1pZNm1aeVVh?=
 =?utf-8?B?MWt6bzR3RXFYMzhTanQ3ckdjUGFYaXN1akdhQ0ZZTzJKb05Sb2d1d1NKU3No?=
 =?utf-8?B?SUJrZ0U3aVRTRFN3S3NjVmdsemFUWTZFZ1RtbFdIRWVURE8rUWgrY203U3h2?=
 =?utf-8?B?VVIySXE1SWtMT1MzR2pJeWIzd3MxSG8vWXJRQmRRcmRxQU10dEZ1TTljK2E1?=
 =?utf-8?B?b2FaeDVhVlk0TTJhUXc2NVNCNGpkakNTNGF3WnloSzhaK1JEY1QwczZkcjQv?=
 =?utf-8?B?VFdDOURTNjVHcjRaTzNhNTArK3Q0RWpPZDk1V3laZGt0RTlJeDU0NTlxeGRQ?=
 =?utf-8?B?UkE4K3IzbjMydTdhK2lCL1FqUEc4NDkzblRtdjk0b0ROMktrWFVleVpMT24z?=
 =?utf-8?B?Mlp4T1hOb2R5bFl4dUI4Ymx1KzZVT0FiZDlqV0NMTTc1VE0yVk45N2V4TzJM?=
 =?utf-8?B?SFNqb1NNcUc1M0RlYm45VHRPS3lDS2ZmejFRMm45NjVOWEVLNWlPVzRzTjVX?=
 =?utf-8?B?aCt1UXdTYVp0ZmVrclhVVXVNRFJUQVF2NmFZQ0F5QlQ2MkR0eG0wS29seWFn?=
 =?utf-8?B?MDZaRXVzSEJLdVlmZnFvcmxhMzRkWWhycDdEaFp1L0JzeGozWEk4Z1JFYXFI?=
 =?utf-8?B?QUpmVjRDS05DbFZ3aExEamVLdm42SEZrSUc5Y1ZZR2pJOEhtK2dSdWxkbHhy?=
 =?utf-8?B?QmViRmtGSGlBMjlyZENnRGRtM2Q0RjBtbzFYNDFGQk41UnRlaktCTys1R0pP?=
 =?utf-8?B?WmFCbGIxK29VSmtEQU51c05CZXE5VWJmOTRJRnJJdlZGNU94d0NlWXRQS3pY?=
 =?utf-8?B?Q1RmYnBOczJYRnhlRldZUVo0RFZNYTNKUDY0cUs3bjdObU4vcHkveG05a2Mw?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <141EEB0C68883E418BAB5C824365C0BB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qq9CxaeP5nvDfZkJiK7OfVnnASq6+2eDvUBFV0wx0hyWUE9UkAVG07fVyxRpOoolFDyTh6tqgswC7oaExxnj/eUr6/W7menRGjWsTBG8IjlZ45M21Jkx0ckg+BYNreeB7z7MrY6s+n8kbZ42dfbaAUA+H8oTd18MDWSX5bgei2oQ1U3qEGWLL3xcH1arOm13oPKpifnzTwDIjdRUkQPWZUsfOWicVWTRTAsQn/gkJQbMiGgBotctk8hk2koF6S85+8iq6GEZhMN2qUDK3xw9Yo0eofziAhf+Ak4rDwcDzBlEfcsS2KRLSDCvC6LdyQARphBisE5RfKPOAc1n0z3RIwtl6u9oCYU32k1MhSrHNX6n1iEaoWPQXNrrJjNr9VHz0aa2n+5mzEVQHdjf0fyLMsskOwmUaXEBmJpC3z4PdwUVc7XU43rTg63VHxua9fNhT1ovkBAvE1Fl+RfNmMM3jLS6ajMgrNJT66Pj+LyXb2kIPiQY8R0xhxqnQHt2UjYGfLisjyx8R0PFYJZC0eOCGKjbK0Dex6Nk/MsPwHmaG0YmtaevB+kvgRo1+ynNeOdrcA5MRWhZcufA4Y9aplY9p00Vmykq1kDVWIcZaieJcGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93f7cc6-5c67-4dbb-a17e-08dd9d1dad5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 12:54:54.4362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Yf81htvHASPNeGlg63bgMLuvIzRuMZhT1c3UksiXbBqDQmNVYaMZUQvGUpCiyPVdd4JX2AYPjpY9wycD5tMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfX0WfoIrA66x3Z
 +GStRJ7tPdIkCDw6uErppUHELxfBDp5mLM+NwqQTk7iIPQvaIrlTt7IMFcgYahYRS1kUZJ0rTUF
 Qap/QPxjXL0sp3tQbSNrhFc/lz/RKwdRchAzIBG9F+8wjo2wiTUDun1OUDTLu4YjjSJ3YGBsDIQ
 hryMxbhIS3bPt3UEpZrJg5g/akHUtHUYGxYR03Qc/l1Jmrjzt9jdg5gXc6buX3+DaGSxJjMpCSX
 o8N/mkXT6vLDHUrKGuJuODwF+V0r/eZksGWKAxrMAx5QlYnmG2gvLgNfn3WKOCeM0IEL5aGw7MT
 f1oQhMIs1qEtee9poaJ4QmfQKgL6d4oOD1uzU9LdL4iYWB2fosxX/E9ymx8Rd3IHPF6DzaPO64D
 KYk+TPb2ow0DgnD3uNgyZDUAE5tu2wi8rSNrKeJ3iF007arTOQkxrjScKRFtfMOFV4KIaNRS
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6835b622 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=qt17rBXQqE4oQHMBpWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Lc_VrHA42OUVy5R_KiyYudb5UQEefMv7
X-Proofpoint-GUID: Lc_VrHA42OUVy5R_KiyYudb5UQEefMv7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gMjcgTWF5IDIwMjUsIGF0IDEyOjAxLCBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjcgTWF5IDIwMjUgMTI6MzM6MjMgKzAxMDAsDQo+
IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gSGkg
RXJpYywNCj4+IA0KPj4+IE9uIDI3IE1heSAyMDI1LCBhdCAwNjoyNCwgRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBOb3cgdGhhdCBBUk0gbmVzdGVk
IHZpcnQgaGFzIGxhbmRlZCBpbiBrdm0vbmV4dCwgbGV0J3MgdHVybiB0aGUgc2VyaWVzDQo+Pj4g
aW50byBhIFBBVENIIHNlcmllcy4gVGhlIGxpbnV4IGhlYWRlciB1cGRhdGUgd2FzIG1hZGUgYWdh
aW5zdCBrdm0vbmV4dC4NCj4+PiANCj4+PiBGb3IgZ2FpbmluZyB2aXJ0IGZ1bmN0aW9uYWxpdHkg
aW4gS1ZNIGFjY2VsZXJhdGVkIEwxLCBUaGUgaG9zdCBuZWVkcyB0bw0KPj4+IGJlIGJvb3RlZCB3
aXRoICJrdm0tYXJtLm1vZGU9bmVzdGVkIiBvcHRpb24gYW5kIHFlbXUgbmVlZHMgdG8gYmUgaW52
b2tlZA0KPj4+IHdpdGg6IC1tYWNoaW5lIHZpcnQsdmlydHVhbGl6YXRpb249b24uDQo+PiANCj4+
IEZvciB0aGUgY3VycmVudCBrdm1hcm0vbmV4dCB0aGUgZ3Vlc3QgYWxzbyBuZWVkcw0KPj4g4oCc
a3ZtLWFybS5tb2RlPW5lc3RlZOKAnSBJIGJlbGlldmUuDQo+IA0KPiBObywgdW5sZXNzIHlvdSB3
YW50IHRoZSBndWVzdCBpdHNlbGYgdG8gYmUgTlYtY2FwYWJsZS4NCj4gDQoNCkNvcnJlY3QsIEkg
Z290IGNhcnJpZWQgYXdheSB3aXRoIHNvbWUgbW9kZSBjb21iaW5hdGlvbnMuIE1heWJlIHdlIHNo
b3VsZCBkZXBpY3QNCmhlcmUgbW9yZSBicm9hZGx5IGhvdyBOViBtaWdodCBiZSB1c2VkIHdpdGgg
ZGlmZmVyZW50IG1vZGUgY29tYmluYXRpb25zLiBJJ2xsDQp0aGluayBhYm91dCB0aGlzIGZ1cnRo
ZXIgYWhlYWQuDQoNCkFzIGZhciB0aGlzIHNlcmllcyBnbyBJIGNvdWxkbid0IGZvdW5kIGFueSBp
c3N1ZSBib290aW5nIGEgTDEgZ3Vlc3Qgd2l0aA0KdmlydHVhbGl6YXRpb249b24gYW5kIGEgTDIg
Z3Vlc3Qgd2l0aCB2aXJ0dWFsaXphdGlvbj1vZmYuDQoNCk1pZ3VlbA0KDQo+IE0uDQo+IA0KPiAt
LSANCj4gV2l0aG91dCBkZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBv
c3NpYmxlLg0KDQoNCg==

