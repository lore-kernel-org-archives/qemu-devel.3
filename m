Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DF606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=TqthTR8I;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=uo3zHPNT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfCc-0002e4-UZ; Tue, 27 Oct 2026 07:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xLfCZ-0002dQ-Dg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:18:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xLfCT-0003cF-7j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:18:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5Z6EQ2402041; Tue, 27 Oct 2026 04:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iey/KyHAZ6pbF8SMJepNMsEcN2it5T40OckDNMKGi
 T8=; b=TqthTR8IZJCPsOegMRel6R3UgKRtzgNeGJMqAusyKw2BbowvVIzkcnAlx
 qv9BVha6Xh/0SfIVhECS2l8iALKcMPzMoyvrFSF17V58aV761DZ1D0xMcin2q2+O
 gWLBRZmnreWICqK4z0uQwN8bMti2fEOeARyKkrEYUJdWxzbb/lUhnx1E/jaY83PE
 NCn83o1lYljvzTblzRV0kTGanA+YmLUD2KfBdYcACdP3DBJxfV7iziReBY9M2rPs
 j8UW2l2nXPF9/iBO1KTejGC83/JqvvW5WcHp06YtmfToYTkfcFKcR+fwqtVaag5D
 ng7X45iqRGwAJcuxE/ZRBWcm42wXw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023106.outbound.protection.outlook.com
 [40.93.201.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hj45qukcc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 04:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dinvbo4z7FUtMct3v9INqo6h8rg64eOVarv4CepA+UoLULaZ0tCN6TN2Ps8+3o+8j2CwWCCPKnwJ1URY/eSoJbQJScdoKS2xpCDVZC+x+qCGTXchMgNvZUe+wga5HcOXuu8mb8cK1Sd1gR4rOcKRai/sIsLLRmH58xkmKVDnS//Zeo396whQSt6gPSL66WyVyUSck5r2415RRz0xz+cT12It+vQwUmGW1COuqbFB7LKTI5CV4Zrq3gocmGdIv8+Wu0RFSO7c+v3pdiPIW6jzFfEkSsCCoxv7On6UiNz0GS6GH+xFutnUVkDSHLpbR2hWfiHl0ZpdUCABJWaN2+k+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iey/KyHAZ6pbF8SMJepNMsEcN2it5T40OckDNMKGiT8=;
 b=GMk5wDEbQSdsMPNKFMit9Jd5Q8CL6703Oh9rmDiI/am3BVYutr/MdmYYrISPtetiff4P8TIgNRbFbxFCStKmdVxlNaE90tvzyxc6RxMNBIjPwThy/ljmJHd//5p2k7l9nYG/PtfLjSaj+/sK3NavJg7P8jlkeQZJOGROJjlsxG15jzSLtc3xjSUogBUhTD1bYcU8a1cNHOgeVtWMtqjaV4CRwFyaplg7999kE5J51H78dCr5YzMQ1CNss8L3epmADkEEfq5OzTXyqSQssI9xIZN9y4WGgKXpsFiuFh1duoNmcOiO5RxZWACouqeIf196jd5NeLEODA7aO19AKNTa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iey/KyHAZ6pbF8SMJepNMsEcN2it5T40OckDNMKGiT8=;
 b=uo3zHPNTy4v8QC2hpAIHnvlOuTs5qaHgm8uWhfZizoucUpmzCBYBwheYRjzYlbHi3iGUTOkIA9JkTzNGpZoy7nbim4z7xyuazo+SlDLJX5rglGjWpF4GejXYDgin7F2NZFNfQO6IaSQ4G9wvtQPxBqT4lscHyNVNRkigCFpCZJ6MG9GOGTCqQD2kbhEe13EVlpmqVk09mH9tydBOCrHT12P0uqXvqd6qLDsNDqkBPao2VwjAM3BrdsE/EXxqREZYjyYovuefz4i2x9dTf/jHGoBNfp/3/Kag+A/yJrTYuYR30SMbYsmstegok1vhziAz93T/dUxbifJNn8BSZ09TXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by CH4PR02MB10657.namprd02.prod.outlook.com (2603:10b6:610:242::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:18:31 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:18:31 +0000
Message-ID: <712fbce9-8b13-47c1-b0cb-b9f20807f05f@nutanix.com>
Date: Tue, 27 Oct 2026 11:18:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/pci-bridge: Configurable apparent bandwidth for
 the PCIe topology
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
 <6fa1a07f-afbb-4c65-85e0-ddcebd9bddec@nutanix.com>
 <20261015101016-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
From: David Vrabel <david.vrabel@nutanix.com>
In-Reply-To: <20261015101016-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0328.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::21) To SA1PR02MB8368.namprd02.prod.outlook.com
 (2603:10b6:806:1f3::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR02MB8368:EE_|CH4PR02MB10657:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bc0612-5725-4721-a5e7-08df341c0809
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|4143699003|56012099006|261026121527099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VhWVB7oyd0aiPO7ToSvICX0z4mCHrfRasfzAJ0qhlESqW9ybpY3JMJaEH0mkFJjvem6yon0swlte4OH1cwVZlkUOHwAgR0LAk1r7z6VcuGYdcHjZu/Q5T/U0pKip2mHI0DCGOXZlEw9cfdX8/bjoz3MOoitC5ffM/dYuyNSNypEbuGMuAsrS6H6e0gCzATouo/ZP4f1DVw0EW9CsHOr0nkXNShsjei8PEzyrI0c0XrYSu/eEbEo512Q1XiLycLZn0f/INn/j5fsLFeOkb/L/SGSs3xIqrVqLczK2iEoMeLzDrYFUWKfvu0sQfoNXGtr2dxwQOhY4oWFGukTiN9XTKSZDtYRju46WCELrrN4bLB5xWoNjxbQFDZed9gRZ2975i11IRTW3K2d0jxsXnQLzZNrUVgtHCqo3eB3CKzzMF16KvBi0Fefv8xjmo8VZr7WghG2gAJtcZGwDohk6Yn95PFkvGWRPbdOuqg4PXNCyXIptNou4RJE/E5qWtkYSMoGw0euxMPSFQ44p7F9NTIxvHciqdjgnfl2jIZCu9VwaTzryTnsW97dFrB5GlrDdxnbkJNclnc3HItyFRo0VK/YV5K2cCwcwKcdLBIgSNTFuB0gTpXLqsXaGSaq5Ys+gE79zKTX05H1V7GB2ewJcK8819UiYHH2xl9I4OrprpkIYMbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(4143699003)(56012099006)(261026121527099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0wxSUNGcUhsaWlWUHFjY2RYYWdJTi91bk93ckRiTXZGZ1k4QXhxTldDYWFs?=
 =?utf-8?B?dkw2SXJaeVlmVzNCenVTQ3gwc2hlYThwNzhaejM3TXBjdFdHL2p1RzZlYVAr?=
 =?utf-8?B?bXh3L09ud25ucjg2SUJPeDRjNUtySzBvcjNDVjV0QU85OHU5RGtWK1hmV3Vj?=
 =?utf-8?B?bmxEWjdSNGlQZ3RtRWFkeEhiWFBGK2lTRzZXaGg0NkNLT1dEeHJVbEZpZG5v?=
 =?utf-8?B?TWlWcFBPbDRaSlIydWU1YXdwYk4xTXdOS09NNFNzT3pxYythc0tPQm9KRlhn?=
 =?utf-8?B?Wll6Z1NlbXFxZVMvNHJQS201OEI1dnpaQlhWWEQ4bCtsUjhRUXJ3Y0Q2YnEx?=
 =?utf-8?B?QndxMmd1LzRMM2p4aUljdlMydmZRaDRDNWpUQkFqblh5OFZrV2w1RDVWb1dl?=
 =?utf-8?B?RDhJUHdzTS9zdURMSFB5Skd2UWhPT3lnQnhIYmgwa2VCYmhmL1dvOSs4N2Nm?=
 =?utf-8?B?MTJzWWUvMlhsMFBHZXRjRzI2VkxOK1RHWW44eEVCN1dPVWlJdXd1ekVHVzht?=
 =?utf-8?B?L2djbUhMQ1lrUVhmU3NMSlY0RzY1czlQRm9xMHBlc1dwVC9ib2JHbVBLZ09h?=
 =?utf-8?B?VTNNV0FjTHVqd0NGM2IxczNXVk9yTUhDelF5M2gyNmRXcldNM0ZuemJpdno5?=
 =?utf-8?B?UW9OeWtFTTBrMjRtQ3RqQlQwNkFjYkloMmNRUllPdGVDZDBONWxsd2VmWDQ2?=
 =?utf-8?B?djRlaE5WT3habXBWaEdlZTJ5NzBrVUtyYnYrRW1HZVBiUFgvcnBNL2ZYUjZN?=
 =?utf-8?B?REVZZEcxU1FsTEFyOGg2T1h2UWY1dzZJTytkSEJmNFdzTy81b1V3eG9JSDBa?=
 =?utf-8?B?ZzVoUnh6eC9uc1psSHBMRmdVY0FQc3Jzb1JBMTJ6U01iaG5ickIzWm9EcXlt?=
 =?utf-8?B?YTdSbFdXZVZ1ZWFUSC85MEVpZmtoQXVkUFRmWUZDaXR5V1RSK0pqR0pkN1Zr?=
 =?utf-8?B?b3M3QitiSHpiNVBaWXZYVzNqVmRLNVdMcndRSlNqODY5cExQZjRyTnhUSEhC?=
 =?utf-8?B?UmI0UmRwVW1yRnZOdGhkOEtZZkYvTFFhUTlaSzN2N3dJUVJRUmFBSHozelpI?=
 =?utf-8?B?STh2UVR4MWpWdXhTNjJHQ3UvTU1uY0JQRHhMZHVnU1lMVnd5UUdZUlI3RTlQ?=
 =?utf-8?B?ekN5bVVBcmpZTzJVWUJUUTAxMGNZYzRtRWlPRUdqMDZQZHVZSWFpdy9UOUpk?=
 =?utf-8?B?QWFVSU04MGlsRFdXUlNYY0p1QkhlZlVFRUpHMDdNc2lndEd6Qk5uSUx6STA0?=
 =?utf-8?B?RU5tQUJuSXZOUzZ2U2tGT2RFS0JWNTJjY09KWlhGV0FZTHovMEpRQTg3RXV5?=
 =?utf-8?B?cFdlMmdCVzF5TGhZbHQ3NUNiRlJ5bURzT3MvUWlCMFVDR0E5L2dVbS9rZ0pC?=
 =?utf-8?B?NWpqZEhqRTNUMldBWndYM3FvKytkTEtsZk5pSnVQeDdmK080RGkvMXZGWEJU?=
 =?utf-8?B?a21HQ1Ria2ZrVkRGR0M4TTdUVXlMY0xGbFdXYWNFRTVYWUlBM0JPUUZXRm44?=
 =?utf-8?B?WHZPa1p6WmV3YUpib1NzdlcvUG9lZnQxbHpnalNoL0xtcDJRUVpHU3oyZytQ?=
 =?utf-8?B?eE1Vd004Q3pYSW03ZCtWSGVjU2dxNGprWm45MUZMbW9VMGxpS2ljdWRmZnBm?=
 =?utf-8?B?T0VwbzhNMVRJaXN0REk3VEp4VytuM3dTd2d0d0M1aURxZUtoU1I0cFRBQS9l?=
 =?utf-8?B?aStKMU16Z0VEbXdEOElKM1BuS3N5ZlhETHpYNkpKSnNIY2lwK1Y3OU0xcHJC?=
 =?utf-8?B?UU1xVTUvK01FREcvRG1MaWJZeGJhSmpSaUZkemxsSVR5bnk0OExQZ2E3SUxL?=
 =?utf-8?B?RTEwbEg1M0dWaWZVRGxBZmdiTGZPcTc4OXFCRWhzS0w1Y2hZL1hNdml0OTFs?=
 =?utf-8?B?eTlHTUgyOUpqYW9aNktjdTdnL2Z4dzJwZ2I0ZXREendvZXQyV1NKV21qY2xq?=
 =?utf-8?B?Y1lzTkpTR2lVYmNqRWtINWkrMlBkTTc3TVdhaURvb0hvdDNIVWpndHlodjVu?=
 =?utf-8?B?cHdLVnBodURmMW96UVRTU21wTUFRQ1E0TE1xWjBzM21QTXpOTHd6TVFNSjhP?=
 =?utf-8?B?UGVraGlWZGJHK3NDR3M1dXVUamFWRFZGSDZqWnhsYlFZSU1rb0ZVYW5Genk2?=
 =?utf-8?B?RGd6WWxTQVBTRFhrdXNVaEk2NllyVCtPbEJ6b1pKczJnUWJ2M003Z0FYWk1D?=
 =?utf-8?B?Tkx1NVcxZzBiMXVvSW8yM1hBdjRpQ09vV2tPbTUzRUxOeHJGRnRnYnRBL3NM?=
 =?utf-8?B?Vkcrdkl5bEZQbER5dm5LL1dMWG5wZkJ6NFhHSXk0eStZRmloYjVTU2VyYzZa?=
 =?utf-8?B?YUFoMk10S2IzWTlyQkliSGFkRkkrSXIvUUxBWTJRMEdoQmNSMDVvQT09?=
X-Exchange-RoutingPolicyChecked: it1E06pSPyBfHlf4D8prxiiCS55pOetElY/4rP+tim/Thtwi/KV+zniTUL9S6CWzjLKqJ/npWNALweDCvcTPY/WsdYTG87ai7Ygve14gE+MSV8scXxxLMDCPM4LFVaWWOItteqZlWI7gvC1O+4n6IXLDh8dbIB9ierhYPf4uDtdZTBJTURhd9+RwpJI5GDAIHb9E5pYSdn3VPMbNSxNyuX8G/W8dAxZUKcI5HEGbg16k8Q+ao81su5VrB5tHEOmWu1lCKAP5y5UGQ2ncxUsL2JD2y9uGuFBLgcqrwjpfVDY/wRc6ThlrY4B24H5TJeUQJnKHSg11TMVQArnHBv1viA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bc0612-5725-4721-a5e7-08df341c0809
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:18:30.9521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiMqXeaxSK7/eJcrMeG95GcjJVO4Cww6MAQnsDFHaoNvl04bY8lf+VYV67LGqzhu6VT+LVgo2/gSnqxD9YUqoi+ISPSV0HY6wl7w3L4IBCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX0ERLh4ZSAyCE
 l6UuwT759H5PS8XzMpALVtAXQSykdUuqw747xmXosf4kZjgtZnRCpo4+1IZ9vtYChnub3t2gU2P
 zcfk5qT9SEe6rHx0FNEvoROb1TpNx4uy/CkFH2rt2IFXtG3niFDxZpSw2W4275xThkOlLNeqZ8J
 mu9jAV7/OFFiQT+ZEvXLF0pZ1hLWKsnfcpNpB8s+zdov6XfZJ/QKkoGBlL6VoX0VcB9rO9e2LO/
 mamJMbMcXhtfphI8anfDob+aGp+I+n+7TOCTjOUaqRkXRslzkUVe5LUcSeTAJdQOFYY4vREeqE9
 4FuNCgkCIha/kP5aMMn0gdN6LX4xiIYCoPrM02lNI52u57AN27Hub1AhS6h8WwOYlbFS8CF3PuG
 /rxULELBXxcj0B2pwoeLjODA315YlXJAQ4eVLhBgzh6ZTkrvbvS1XNV0hmxx5niYHJ+/odVp+qQ
 ZTYxD0BgVwXf2hg/JAw==
X-Authority-Analysis: v=2.4 cv=KJrPn1Fo c=1 sm=1 tr=0 ts=6ae0888a cx=c_pps
 a=h/zdu8LGojurgwVeJVxNZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=YaWIxhn9J4kMFGl5Zg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfXzbUI3lAccXNR
 zY6yolKidNQLP94UFjs4ROlgEH6OLqHaOqo2sL+5Vl2cBe33lZtCZMDKqa2heAkQ7FaavEUhfuo
 VfdMiK46XpbQ2Jijh7sKf4MBmzzz7G4=
X-Proofpoint-GUID: 7fp4NRDNLU2CMrRM9kiEBV8cPefhc5y8
X-Proofpoint-ORIG-GUID: 7fp4NRDNLU2CMrRM9kiEBV8cPefhc5y8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

On 15/10/2026 15:10, Michael S. Tsirkin wrote:
> 
> On Thu, Oct 15, 2026 at 02:41:55PM +0100, David Vrabel wrote:
>>
>> ping?
>> On 28/09/2026 16:24, David Vrabel wrote:
>>> When a VM has been assigned a number of PCIe devices behind a common
>>> PCIe switch and the VM intends to use peer-to-peer (P2P) transfers
>>> between the devices, it is useful to be able to more report the
>>> apparent PCIe bandwidth so it reflects the real handwidth of the
>>> underlying hardware. This allows software in the VM (such as NCCL[1])
>>> to make better decisions about whether to use P2P or not.
> 
> will merge, thanks!

I appreciate you might be swamped by a pile of AI-generated security 
work, or perhaps I'm missing some QEMU-specific process (merge window?), 
but can you estimate when this might be merged, thanks?

If it helps I can prepare a gitlab pull request.

David


