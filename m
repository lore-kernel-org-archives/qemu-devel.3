Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E28C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3jj-0002sL-3S; Tue, 11 Mar 2025 13:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ts3jO-0002Xf-Nu
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:49:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ts3jF-0000yJ-01
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:49:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGQoEC022330;
 Tue, 11 Mar 2025 17:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ku+sdcWMG2UCYXTEz7JiYyOt+N5EDHV900whapTg00I=; b=
 E4ndBJfkc+HhZnwAvi7hXSGwF4HkSbeR/qi64hAQUkL8+W15Ag99t9KIzG05DgwN
 Y7o9mGswAwP7dnmAiauqFixqmUvnouxzrAej3doygzVJ8ngoQqEMAxiMnbeBl9fB
 e5EHsT++QpbDCEbX1Yp0urgSaySMhzlbbznUFD8l7GyOUqTdJ3HSavalo5wfj0Ik
 vfuNk7iEVSYjJ/RtPd7U27Z8dH499aqRXMJL61tgD6FpIl1u5Ti6UHtjrwQnypPm
 b/Jp7zbrhZkKAcswMQXefGx68UJR/pzrRrW+Y0eC4hpMZIs3MZ/JOLePMSaP1ram
 M5U0GJgBMnGBo18Iwi4ppw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacdewq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 17:49:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BHdLVq030680; Tue, 11 Mar 2025 17:49:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 458gcnqumr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 17:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVcGYSihoggbz9N+dA9X8O7C3Tvk5aUMnuUwotTIlFO35FU3o2YdoB5EafOgTULNxNYXooOdlUTIFDANz7yGReQsdQd/3WZyTXc7xrc29C9gIwpZad4kRR8l9nX+3BAfLyqG/hfSDwR9nv10j7RyzZSE3iEEK8H8ejPozKb1EY1Xu/Syyi7LFq5oBqXXboLORAaINQ8dtl/kHbkeBVVm5+g5UyV9xKKP/JvPyPmPAbHo1xyKhcRl3Ez5NJet6VtNAJhLeKeDOBXhsmt6/jpQaKhOJaeBo9k0uxOZmeDvarNKPL1KHe2uf7e0UWTU6zi9uirimuWl4+ucFCWgkpA2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku+sdcWMG2UCYXTEz7JiYyOt+N5EDHV900whapTg00I=;
 b=Gua4gL5v1fl1E4Tsd0n4+2qk+E2yIYtIx/eJnB8xgIIGRdT5DOLtOYbYFhmbyBSxgG5C65dE3pxXL16MeoWhg0qAx1V2YxDNum5/Z1WQVPtnTjQs941h8ua4rDe+nuKfg4Pj8jgrQKP5f3il8P1+noha2N/wt/yu+VqdxTJ41oBtWPgdNZx5+aEFq2NB+DWBj8lda+IU0UE8hdz5pUytQBradwy4PowzJxGuzIpIfJ/WgcK0Wox4qcxQG46MxTxJpLRITFhMoh9fmwXsJubWsKIWe/0htnKL71c1nsEPdJmGiB3F+fx4/vY6gsEHmGjW+0a3aeQkvy6ZbU9i3dxdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku+sdcWMG2UCYXTEz7JiYyOt+N5EDHV900whapTg00I=;
 b=tCiOqxu/D0xtxzrkS7MIccU8fbdXpKCbiwiupGJnyKOXk4EPu8SelNM2FclLuka85kFbsM7xWDyPPp6dx0oSl95Z3mKmKRQbBh/X1DjHpLNCquaPvtoJOdCGLMwUJvZsxANz+W7JBkm+AqECUiDD58G2Rtrf6m0/1ARCTEaEJ3Y=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 17:49:08 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 17:49:08 +0000
Message-ID: <6566b5ed-1ef8-4532-882a-a3c4c6f60c1b@oracle.com>
Date: Tue, 11 Mar 2025 17:49:03 +0000
Subject: Re: [PATCH v2] vfio: Add property documentation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
 <995ef2ed-a5e0-469e-b780-6800f26d7b22@redhat.com>
 <6985a62f-a091-4087-887c-361570170ef6@oracle.com>
 <8ac4f034-3e68-4c8a-9a63-9eeacc0de113@redhat.com>
 <0d6e9836-328f-463d-9db4-c7fa57196781@oracle.com>
 <f2c2d64d-976a-414a-ae5d-8bd0f0ed9bca@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <f2c2d64d-976a-414a-ae5d-8bd0f0ed9bca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a6f88f-5258-4291-a3eb-08dd60c505e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEZNUW9HSy9QK2o1QTRpSklHVXlRaGxnNUhkSnVnK01yUW9MQ1JDMHpHTHJH?=
 =?utf-8?B?R1VrSllVdEppN2pxb3hMeHcwVzVLY2ZtVWtuRTdqWFhuWWF6RmhlY1k2QTc2?=
 =?utf-8?B?eW5CN2VnMnZzT3FsczJWa2I4NU5Wc25UWFg2UGdWbnVzM2hONHpsdHJCNU9x?=
 =?utf-8?B?QmM0aktib0E5dmRpS1M5dHIySDJCa2YvNE5TRVpCUWhscVZNbmJYSkFwV1dF?=
 =?utf-8?B?ZjJUdEVWRFhaRE9ob2c4end2ZWU2aGtUMzRaL0FCMkp1bXpvSUhPZ3FUQTQ5?=
 =?utf-8?B?WjNFWDJ0Qmdwc3pNQ1ZFNGFEcWh0czdVRGozT3VvWnFaNzgyZkhhc01Jc04x?=
 =?utf-8?B?OTFjREVIRVc3UC8rbVlvZWc5a09FNjlZTEpoQzQ5Q1lIUDkyd1FvYkFCRy9L?=
 =?utf-8?B?d3ZHSjR1TlJhTTdmQUlmNWcyNzBtemx5MzlLa0M5RTN3UGpwMzhvRkoxWjNr?=
 =?utf-8?B?LzRMQitUbmxDM2t6QXNEbnNzSFAvSURtWG5QeHl0d2U5VGVaOTdxVmFyL2VQ?=
 =?utf-8?B?TnBrcytiYmNCanVWOFREYkwrWDdmT0wxd2NkVHBKSXg3M2NMR3Z1K3EvNDdv?=
 =?utf-8?B?eHVIZmY3YW1XRUxVSldZYXo2azR0V0wxSkF6WThOVEMyTmc5Z1Jhbm9HbXdJ?=
 =?utf-8?B?TEFiamxmYlRlQXdQUnUzOFhYU1kzMFRGeWYzTHNIeUhFWHlHTnl0QkxVUHEy?=
 =?utf-8?B?NzZNRzdyYlc2djZrWGZqc2VZa1prdDNwTG1maEFiTDRUSXB1QitsYmc5WEYy?=
 =?utf-8?B?NGJvWFEvYStlNm9ISG9iUklZR3NyRFk3UUNvUm9EV0ZLT1lLTWk5WEgreExD?=
 =?utf-8?B?RVNJazUrS1JJR1Z2OHNaU1FPUDlhOEZleVlhSzY1aFRFMVFhL0N4WXNpVjRu?=
 =?utf-8?B?MFF4Y0F6cGFyVjViT1FWSzdQQzVHZG4vTFdvb3I4MEZYYUZVWFhqcXAvbjJV?=
 =?utf-8?B?c3hZUnpFOTUwQnRhU3FWWWF0ZzIvazQ0OFJSbXR2V3czMzNsMTJlays2aXFY?=
 =?utf-8?B?VzRDTktZS00wQXFkMDlJWDRpakwyRUdZUk5EanR4cGVNZWduMDlxblRlTHJS?=
 =?utf-8?B?SkJlaXJBWWNzZE9Xa25UMjBBNjJsL3I5SWpyV0hCSTk2bDVORmp3QU5qaXl6?=
 =?utf-8?B?cDJ1R3NTbXlFc0dPcll0Wm5RYWlJRW10enFaNUt1K2ltRGtuT3loV1VUVmVS?=
 =?utf-8?B?c2xjdE9SYVFueE54U3dSeVEvd0czdTh6UzhPbHpFRFZOSmpFMFJqNlBBdVcv?=
 =?utf-8?B?Y1pZTTdOUllLenFKa3RLTENiYkw3UWtMZ3IreWhBeEdlRStjQWo3NGRXQ3Nk?=
 =?utf-8?B?UzdwaTR1UjhSK3JjeW53Z29Ia0FOYktWMlhnNVNMMmRpTXlzWmF2ZUZUYnhz?=
 =?utf-8?B?aEtUSGpJVUZWZGxZd2h0NjJWMW1nV0F4QTdyVW0vQzBZVDVwR2tzWm9ZTy9v?=
 =?utf-8?B?YkNoNFhOaU50L1p5dEljNDltTEU2SUlBOER4LzMrNFVFUTBUSmJyc1RuN1E5?=
 =?utf-8?B?ZWtmVVJzMmxRNVFBL0Z6WFdGYmtBTGwwU0pRa3VIekhWb0MzMUxUbklFM3FW?=
 =?utf-8?B?aGtmZ2w5SzdFVTQ1KzJBRUM1bUdSOXdnN1RCQ3lEQnZydVNWdk92c2pCZDl5?=
 =?utf-8?B?eFAvcE4wc2FjYW5lN2l5YVNPekw2eGJrcVdkM21ZQW9pM1crUStabEh1N1py?=
 =?utf-8?B?RWgyZCszbmNNcGlGV3h6OW83UXUxVEJZNk1rT2Z5ck5wWW8rMmNGTzRNbVhJ?=
 =?utf-8?B?VnJZRFZSMlNJdE1ReTBENjJWOEZBbk9VVVVGVmt3cDF3OTlvTWRYRjZwVlpR?=
 =?utf-8?B?TzYvRXBSSlpOckpINml4eDVYVWlHclQxR0syQnlmNDdnakl0ZmRiM1Nlem95?=
 =?utf-8?Q?u189vXohhIglV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ris3Rmh0aFZlWFBqeGNhWHA1NUw5Q3V3YnVTa2hlb0xYYURiSFN5c2M5Z2do?=
 =?utf-8?B?ZGlnSnJ4K0VIajRIbllnYy9DQjRBY2Jwbmh0ZUdlbzRmV0c4eFhLQ1J1NHB0?=
 =?utf-8?B?OG9ici9TeDRzQXRDVmV2U3Jra1FpSkUrRlhCck1FTUttVGFnRTRXMGIxUHpu?=
 =?utf-8?B?a1oyeklmMEZEcnFRNEVWRkl1Z0lMeEE4WGxWUWJYVVhMMldmeGQ0Yk9vTnlC?=
 =?utf-8?B?SVhPdXFteXhQZjQxaE43MFNvNU4vbitjTHc1KzBzdkZ3NWhBcXdlcGdXejhx?=
 =?utf-8?B?bFpHOFZ3bEN4eXRnaVVYZHkvSW1KRGprdzh6VmhmMmxVVXcxV0dVVmU0R1ZM?=
 =?utf-8?B?YXZpS3RTNUZ1SEhDNjhHdU5rdnFlblhjTlU3alRnY0x4V2o3MmVTVkJHTndr?=
 =?utf-8?B?bWtNSnRUYVNPY2FTaEtmU0kvODF4Z21WaytVU0NxVys4citUTUJDOVFtQ3Fi?=
 =?utf-8?B?YkRCSndMcks1UkZYSEhqMEhEaGtsbkZzaFhGUVI2ZGF1dnhHWnNXcjRhcWxw?=
 =?utf-8?B?L1AvZy9DQ0RIRnBOVlpHaWtRSEwwbVpyQVBUck1KWlhLQk0zMk1qWkNBWE1h?=
 =?utf-8?B?Zncyc25qYVpmWW56bzJubFVmR0ViTFNQTGpjVThzREM5SlVzZHFsejlUMnFY?=
 =?utf-8?B?MlFyR3J3WDU2cFpTN1A5cUlBSHhWVDhMTmJpKzhNOTRKd3U4K1h4akIzV2Fw?=
 =?utf-8?B?YSsxN1k0OUZtVGkrVUZkeXlKWnJQbUVTQ05JakFRcHp2WXhWR3MwL21XSmhE?=
 =?utf-8?B?Tk9jR2dzcllkakNQcTdQRHR4SC9sdVpGT3lVVndjbHBpNUV1NVZwZXFYMFJ0?=
 =?utf-8?B?UE02VTdMY3ZEejRyMnZ5eEtRZnVpT3FnSHptWCtWNTFVZWNsRmZ2WGg1YzM2?=
 =?utf-8?B?ZDM2ZVRtN3FVMHgwdTlGTkR6SWU5OWNoOUIxbkovMGJWZ1VqeEtTTFRJeCtq?=
 =?utf-8?B?YWdRbi8vUmR3N0RsL2pZRTFibjZtM3dVQm1GN1V1eW9GS0RSajJZQXMyUytm?=
 =?utf-8?B?OUw1akVxdEoyeFhlUmFRbzlzY0orVk9VL0lRaWV5dll2WTBqT1BpZEN5aE1D?=
 =?utf-8?B?NHVLVHUxQlFyQUVJLzh4dmcwT0dJT2V3SVR2ekZyWW9UWEtxRlRhRGNOd2hR?=
 =?utf-8?B?cHJEMFF0ZS9LbFhjcE9CcE9LNG9IMURuTzA1akJNMnhneTZBUytsVWtMVnZy?=
 =?utf-8?B?UVBMaThvNnlGYSsrU2oyenhxcVpKVW5sbUhIQ1dPMnJoYkdhWUlSNEtQSWhM?=
 =?utf-8?B?YTZsSk5LQ2ZHcEw3V05CeDdJLytvRDdFb1VUcC80ZXJFOFJwWnFFajVTMTBz?=
 =?utf-8?B?a0pNRW5YM3MzNHhwSkQzaWtGMXRXd3JEZ01qQXRtUlNmNS90QUpJdnRzMFh2?=
 =?utf-8?B?VmhxRkwwV3JnSXZObHA0dWJxdFg2VHFLTVZDejZYYkFQWVVIVkdKcWxKM2x6?=
 =?utf-8?B?UFdJTSt5Mkl1S21ja0JhQjlWbTBvTGR4S1FHNU8vWnlDMjV0ZmFrcExRQ2ZL?=
 =?utf-8?B?WEY1R1l4RU55eCttNVM4WDk0cndrOFJwN3hsUjRDOHJ1VERXaHcvMjlBcGl2?=
 =?utf-8?B?ODRZazUyQWNNL1BNMFdQZFNWbGZYcGpwd2o0c29sTWJoRit3Zlh0aHZZam1n?=
 =?utf-8?B?K0xJVVN5WG0xM3l0aE5rMFZyTkV6NEpHc3VFZUdTaVZjUE11WU10eCtiWU1a?=
 =?utf-8?B?VVMyQkNodC83anhSQUJPeDJhZkZoUTBldy9HQ0YvZEVyeXh4bkhGc0VQYlpt?=
 =?utf-8?B?amRqaEk0eHJHbVJMdzhyZmZ3RjE0ek9ib1Npc093azRMdisxcWNRZjNHQ2wx?=
 =?utf-8?B?Qi9pOW5NWnRZMWxsWWtQMEFCYkp1czVqSHdCRHpOZm9QUjJPZkxDR3BEUEVn?=
 =?utf-8?B?ZGhISkk1dkN0RHFkMDZDcEVyVE9sNUdPNHNkcFZad2o0Z3FnQ01NaENyMWx0?=
 =?utf-8?B?R0pWYTN4UzJZczJUWGRhb3JxdE1QcklCWDZoMFhGWEdNK3FJaTZndGZWa1ZN?=
 =?utf-8?B?THh5THgxL1BMNEJjc3VlQlhsZU9ZdHNwcmdCeDMwamFKSmRXVklTc0RiUWNG?=
 =?utf-8?B?YVpyNkRCaHJNR1RZWCtwdko0ZENjZGRTOThRL2ZwOFI0VFpSeWlSRkFtTXVC?=
 =?utf-8?B?b2NROGtGMm03ZEQwWlNkZjVRNS9wY0pRQ3BvODYraS9oUVRVaENaOWE1WnBF?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oL8WgSJEJBNyeXtdGUHgf38AEFNTF7mGwrZuSxC9bstsuiSzU+SPv08wCoe8yRoSRTCy/dP84P/4YpelV92SIh4A8gsWLEoxYbF9qvnR08Zrtqt/5usnt4EmD/TAnvBAbdf5JTNkMaMbMZ95TKl+G47Z74SjKdto7w8gIvGjl6DmcUQcPYvxSLsVBF5w2v4nuqBGM2Bm56pUvfn1M9vGpGATs2JXDd2SXgHXs+R9MKa0Kuu/AAuGy9DinFJNHzMWynnmmIhg3jSQyUuNbhFcLz7T56s43qKoOC/69+XjyOWhBTrkkUsnBnkdNRDKt/kBvuMci7QjABq5BcBmpoiYYWe0z/PTRvypo9ketpRVYKUqWuSOG706oVNn7WGd17VRCGA6CyBZMOj7I9XRgLSHxYNBIIVKi9XjRTkjpUOI62EHfolVniEz61QdCuwTZrqlv5yAtuJ/6JAmR3Plov6OSfXgRpAMzmRow2dfKM8i+uJuZdkj52W4hfSgBf+3i7VyZ4F9tJNhRB/VthuyXdY1J7Lt3Ve/XCnmXMO3qz49VrcpV/5DdMnN1STt3SPjKG4PgnVythJ1dGtbcGzg3c9Lp1yeWPxOk0FzNYb9mIbIGJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a6f88f-5258-4291-a3eb-08dd60c505e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 17:49:08.3587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgGdCWCX/WahHp8z6VATpq9c0XfTA1TWaEKCJIxTwN4ai/twodEntCiHK6w2IQX0yvaN3Bc8+DKn7lsK2ViFWvL0+Y77A6TYW+1RFsubNOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110114
X-Proofpoint-ORIG-GUID: xa6G6JR4Ia4p283P3k7KjCOr_ahqzJGl
X-Proofpoint-GUID: xa6G6JR4Ia4p283P3k7KjCOr_ahqzJGl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/03/2025 17:43, Cédric Le Goater wrote:
> On 3/11/25 17:44, Joao Martins wrote:
>> On 05/03/2025 13:13, Cédric Le Goater wrote:
>>> Joao,
>>>
>>> On 3/5/25 12:16, Joao Martins wrote:
>>>> On 14/02/2025 13:05, Cédric Le Goater wrote:
>>>>> +Kirti
>>>>> +Joao
>>>>>
>>>>> On 2/13/25 22:45, Alex Williamson wrote:
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * Migration support
>>>>>>> +     */
>>>>>>> +    object_class_property_set_description(klass, /* 5.2 */
>>>>>>> +                                          "x-pre-copy-dirty-page-tracking",
>>>>>>> +                                          "Disable dirty pages tracking
>>>>>>> during iterative phase");
>>>>>>> +    object_class_property_set_description(klass, /* 9.1 */
>>>>>>> +                                          "x-device-dirty-page-tracking",
>>>>>>> +                                          "Disable device dirty page
>>>>>>> tracking and use container-based dirty page tracking");
>>>>>> These are really debug as well, right?  They just happen to be
>>>>>> migration related debug.
>>>>>
>>>>> I suppose so. I would rather keep them under the migration topic
>>>>> and add 'debug' in the comment.
>>>>>
>>>>> Changes :
>>>>>
>>>>>     commit bb0990d1740f ("vfio: Change default dirty pages tracking behavior
>>>>> during migration")
>>>>>     commit 30b916778517 ("vfio/common: Allow disabling device dirty page
>>>>> tracking")
>>>>>
>>>>> do not explicitly explain why these properties are useful in any way.
>>>>>
>>>>> Kirti, Joao, could you ?
>>>>
>>>> Sorry for the extreme delay but I was out travelling for the past 3 weeks for
>>>> vacation and work.
>>>>
>>>> The property is marked as x- but my intent was both debug/testing and to have
>>>> something that allows me to select the dirty tracker between device vs platform
>>>> dirty tracker if something is wrong with say VF dirty tracker or if there's
>>>> some
>>>> limitations around it. These days we actually use it a lot as my default to
>>>> have
>>>> IOMMU dirty tracker in use. I wouldn't label it exclusively as '(debug)' just
>>>> yet.
>>>>
>>>> The precopy option might be to avoid dirty tracking at all and it's generally
>>>> useful when you don't have dirty tracking at all or say snapshots or 'offline
>>>> migration'. But I have never seen real use of it, or need for that matter,
>>>> except the early days of VFIO migration during testing.
>>>
>>> Could you please send a patch on top of :
>>>
>>>    https://lore.kernel.org/qemu-devel/20250217173455.449983-1-clg@redhat.com/
>>>
>>> This would be great to keep the information in the git history.
>>
>> I'll send a patch shortly.
> 
> I am about to send a last PR. I will check in the evening
> for your update.

Ok -- just sent it

	Joao

