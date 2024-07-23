Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD65C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAfA-0006Dp-69; Tue, 23 Jul 2024 04:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAf8-0006DE-J3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:14:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAf4-000762-VC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:14:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BWWT001359;
 Tue, 23 Jul 2024 08:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=zJpNENvy4r1OHAt5YcsT8cNZFhpoWI7yczReKpVVFCQ=; b=
 AIhmkNrzH/bM/g+e95MoOYyDpJQN4T5QmRtg8pFo7UrR8+dW15BltYuhCt4NJolp
 10I1gF7IDudIRzxcRqJJHZ2XWbQj7vjnMf8VlALwPP8keEdRXgL0m8c4uu1QPuJy
 GPLcjmNslCDPCnmsZfFHDUy6w66Ze8mQy76IyHNbmbmPeOcFltmAnzYQbuG2jA6b
 BO4TnzY1YrGGf42BwZHTv+YTCHLXebbAXZvcz+KR95kiksIfc+YJoIlAdFJCJG72
 XF8V+aW/koQBXLGnPODQu119UQ0BL0R+1hlbKOiVzUcf97xknEihwvJ/w4DAfm2O
 ZGMUesl7sPW9rQZNR29Faw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0dmr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:14:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N7SK4K034333; Tue, 23 Jul 2024 08:14:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h27m6qjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8hjgnj/AHfNw8rg2BYq/PvxqSKUJ6iROb+e0sIl+NBx+VObeXyC6gXNP3Yo9uTuC4qE8X8VutU90iIgABd1Ihm8JhpP/C6e26yuMz36thAwGlHEGDz/f9q03bv6Nz7nhyhDWBCs8MBMU+sc1ffJHAOVZ8D5fXJZEfu+AP3B3caHIEAL70ujE9wRZX9skROm//GF/3swCZFpgV2pYzhsnKzgjEwJe7NfK4HO+lypn82l9HAbhj/Gj7TkqLe32B/fr52SGurNKb9LOzD5j3e9ww+Uh8cfgsL9FwdzxIoXBxxyOe21VKgiECV25W3seDlv1C2/9P5M56Zxw/Z9IIx1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJpNENvy4r1OHAt5YcsT8cNZFhpoWI7yczReKpVVFCQ=;
 b=nAzj5hHc2oSnBwmRUBOWjsAJWSWhIrqoOrUhUWkh5vOZxs1uxdfC9MGPqcoTZEMlakXs8jUCZLb1U4mysPkqKhYlktIxPjEEs0LyBjnSUl+vUVvnixTsFIvBZ95Lg8dwxwMk6MDr0yaZTFfzIHn7LfTCS9qH0gtATF8iNUah0a4ijt+RSFPS4alM60RecRc4BzxVf9/0UyLkTZKikEzJ5Gxrpnsh80PVDBHvykiNc3V681LTAxIteq7w4At8k1T2sq4kgBVAxC4D7W9QhsR3+efa26sxZjeF/5Kjt1fYUNIDlxDGlxs+Fef4jSQ4aNqPNo7R7SDOPk3wEWLTTO5YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJpNENvy4r1OHAt5YcsT8cNZFhpoWI7yczReKpVVFCQ=;
 b=PVWa/1ZxsMB0eA2m8D6+NX8LgwpMAM0C1Lzz1O5qT8tulBiheK9w0+ys6CrOkppBpz4oVzZVxCEenqAbiu0V6YkuhLnoaySHtU5XIMF6n1z+Ob81mzBwGkWPpRjqHEv5B0KbYD0gbWN9sUWvTBQXkYtswBIlOg3sGCZGQ7sd+UQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6281.namprd10.prod.outlook.com (2603:10b6:510:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Tue, 23 Jul
 2024 08:14:12 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:14:11 +0000
Message-ID: <17085e0a-3145-4be9-9670-cb9a9292cfc6@oracle.com>
Date: Tue, 23 Jul 2024 09:14:01 +0100
Subject: Re: [PATCH v6 6/9] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-7-joao.m.martins@oracle.com>
 <0a1aada1-ad2f-4e4b-b690-b78ef55c849c@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <0a1aada1-ad2f-4e4b-b690-b78ef55c849c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::23) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 5459fcbe-2582-45c3-3c9c-08dcaaef6efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEQzSVVHN25qNEQ5K2cyY2V3ci83VkFWcVNOWjZHNXNDQ0pucmxHNXZUVHo1?=
 =?utf-8?B?dlZKd1hjWFlSWXlpaGpVdHRMbTJLa2tlaFdPUGlNc2JhYkN1SUtYQW4vNlNq?=
 =?utf-8?B?R0xTQWFmangzVlFzeTJpYm5hMytTOHZYU1hXVnNDZFNCVDBCbWRSTXRjM2pS?=
 =?utf-8?B?cjdyVHJUTE9kcXh3Um1yeW1US2RkRGdUbW11dTVEOUlFM2hDa21DeXZyRFNZ?=
 =?utf-8?B?ZFRYaDJraE9pTmVHb0dZcUt4a2VaT1p4M3BJdFJpKzRnR25MeXpOMlluZlZE?=
 =?utf-8?B?OU9ydVZRL0tZMndUVGxsMWVpUE1DaEZ0OUpIVWZ6ZitQM1N6ejJPVU9wYVUy?=
 =?utf-8?B?NC9LcUQwNUk4bXcxSmxyQ1ZMNVpYbHZ5Y3JYSzB3c1FlcDdrSmE3VzZLY3Bl?=
 =?utf-8?B?bG5VREY4Z0VXeVRzOG8zVGx1OWwydFJmVzgyRUVINENhaFY3QXFndDAxZ0w3?=
 =?utf-8?B?dXNobGp4QWFidEhQRlNGZ3ljRkJHL1JnOHZnSHptNURJdlIwNm1meWJnb1ln?=
 =?utf-8?B?dExYcGtvdkxwYXA4eXlNenh4V1AxQ1A0eUJqNytqTEZ4dDVJbXRhVC9FZ2Nu?=
 =?utf-8?B?S05tL25rS2JZUmVWYStSNThaMG9xRkRleHU5YlR3WklmNGo2ZHdCOG53YWZq?=
 =?utf-8?B?RkpvL2hCNGFyeW9OdkNVeWRKQmN3MC81bWtLblNFZkxIMU9oU255NEgybnFa?=
 =?utf-8?B?NmYzQUk0NFhnK3VYcjU4bFUrdis5dmYwaEptenkwQ0pLUE5YVjhUdWdUT2Fn?=
 =?utf-8?B?TGtMblNKek10WWswS3M5MnFYYytVRnhPWGM1TzR6eUpVZEdPeXVVem5NaGJF?=
 =?utf-8?B?RmMwWEEwYVV5SjBkb1ZabjJyNFZ6aDJuTktKZko2dG95Q20vTUJMOTN0OVg2?=
 =?utf-8?B?OVg3d1ZMbWwxS1c5WlozeVdCZVBBQ3NoMktKOHNQRkhHaUJPVEx4aVQ4cGwv?=
 =?utf-8?B?Wm5pSXFWK3BLZjJyV1AvRWhkWDFkUTk2aHBoZWdzOUsyeEdCWCswSXMxemh4?=
 =?utf-8?B?bmtpVWt6U08xMVF1L2RnUGErT2ZueTZNd2xVNVRnaTFXbVR4dVFCTVZwd2RL?=
 =?utf-8?B?ZVJuNTBidGRlOHp5MTR0L2FQT3BrdS9LWFptL2ZZZjM1NGtycUN0Y1VTK2JP?=
 =?utf-8?B?aHhnd0pMZ2dKcXYvNk4yM1pMMndHeTUrZkxiOFBoYTZjT29zU2FlQmQ1WHUv?=
 =?utf-8?B?NjY3WVN2YUR4RVczSnVadjZYSDF5UlZYY0gzbnVrMktiUTMwVUJEU1hjRktJ?=
 =?utf-8?B?S3JzU0FPeHNRVm11YVMxRm5aZkVZT0lFQnJMRFZVMXRHbm1BMDBxQ1VHbHdN?=
 =?utf-8?B?UHJWUnlEYldBWmRENzdJUlo4QXBOc2czWGphUDJFRWtNMG55SjdRWXVPQjds?=
 =?utf-8?B?NjBJTlBxNHZ0TE0xYUw3QXh2eHBNNnRlVmtxcmlJVldXMnpTRjY0aTZ2MjFP?=
 =?utf-8?B?Z2NIU2hvbXFvam5kaUhmSUF2aUJuWllUQVVLT0RIdUdMejM3YURqQlRIMTVX?=
 =?utf-8?B?SURwcFM3V2lKZ0kvczJ5cDJ2MVB3YnN0aExMMlZEMWNZV1lndlFOUlpaVGJj?=
 =?utf-8?B?eldybUl6OG45c2ppTm1uQnE2Nm1xaGc0TDFGWGdBMlZ0bzZRN0ZSOGNoRDNT?=
 =?utf-8?B?SzVpNlcxTkhKRWNORFR4ZWF3S2hTZXQwYVdXMEFwMEYxSENrUk9tandXRGQx?=
 =?utf-8?B?a091QWxIelRmQWdHZ0xFMGdOdlgzMlh5ZTJyaEVrUWNVTnpMa2JNVTFibDhW?=
 =?utf-8?B?Sjh0cFhQYjNiRk91ODYxM1dCV1BaTVJqblkreG84TVhGM09hVnBMVGFvS0hw?=
 =?utf-8?B?Vk5pS1JKL3hhdDBqS1JkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUo0UlRSYVYvcHpEVmlaRCtLd1hXZXFBUlRhRnpWMmdOTjJOQXZ5SE8vT0lK?=
 =?utf-8?B?WVYvT2xWYkVnaGMyMjdyeDdDcDVsYituYW5RYS9oVEI0SWw3TU5EcWdvcGRt?=
 =?utf-8?B?SmR5cmxaSzBMM29PejBORDd6am91VStuLzUyOUVqemlEV0dzVWFXdHRhY0VW?=
 =?utf-8?B?QlpLdmhBbHFoYlhxZDVYdzg5N21sWlZVNGwzM2JnNi94VmUwR3hXRkxxemlw?=
 =?utf-8?B?WmJpZlFPUW04NE5VQWVIT0lKMTN0V3lab1ljUFErQ3RXWWpDeFgrWGtYVnUy?=
 =?utf-8?B?czR4OFRBcHFGdmRSWkdLMmREdmp2SklsQXVtM3hGUUxJOXVvYW5wd0tGQjdO?=
 =?utf-8?B?MGhpazl2ZDI2Z3o0RnFQbk9PNVZTNm80M0dxRTRHQW1wWDdjYUtLZk5vSEhr?=
 =?utf-8?B?NkVvVXpGenFKeEtZbm1NcFNmUjJhZWRsVHpDR015ZEQzQVBsck1JRm9RWlA2?=
 =?utf-8?B?WUxtRVBJcFdiRFZLVyswVFVlTURYa05iMmtCbmpRL01ZNy9MakJRTEsvZCt5?=
 =?utf-8?B?QXlFTkNmUkJhVkxoblpZcVFOcFpKTHZ4bVZsTEtaVVcvbE9tbnVkT2VoUnhL?=
 =?utf-8?B?MCszOFNTWmpmbTBrZjV5TVk4Vm5tc2hZZmVCN0w1OFNIUjRqWDVPakl3czNz?=
 =?utf-8?B?Z0ZnRHd2MGJZMFBpdnUzc1RiUlQ3Wk9iaTZ4WXRUTTVHSXV5Ulg2ZG5pVGJ2?=
 =?utf-8?B?RHJlZHRZWUZpZEVrSFRseW9Gbnh4VkRERHBGWHNBWG0vMEdTYjRpYkpxRlVT?=
 =?utf-8?B?aVZBanlIU1ZSb0YxZnFvaGs1THhxeHZwS0tVZmpmK3VsN0wzTlVnd0Vza3Ew?=
 =?utf-8?B?QjFFeUNHS2g3Y0I5dVVDRVZSdlAwV1NrWUxCN2hWcERnZnF0NFloWDdBUE5C?=
 =?utf-8?B?UUVCM05EdU93TEFydHNLU3hZYWNFRU5GWURjN01zeUJ3L1pKT3VtY1ZUdEgz?=
 =?utf-8?B?YXNINHpTTk1JSGI0eCtYTVhad1JFMk1iY1pOZDFudVFJYStoWjdKUVh3aHp2?=
 =?utf-8?B?cVhBTWpiOHRJZjJQbWxlR3RYL3RzMzQyeWo4ZVpZL3FwVFhIZWFUdU1DWFIz?=
 =?utf-8?B?MkczM09pRTBDaFlHeGRseEROVGZMNXQ4ZVFRQTZuRUpIRVZxTnRMSG12R3Uv?=
 =?utf-8?B?TklTTjhsNUJvcmlrcHFtYWVFTkxhb0M3TzloMXFFamFzcTNDNWNiWnVTZEI5?=
 =?utf-8?B?UzE3WEtyeTR4N0pnV3YxakVPcXNsSm1xOE03K2w2ZGlGS3puUUlnRGdKRWVS?=
 =?utf-8?B?LzM0U3BaOFRXajBFZS9BODZETWptejVSMk9VdHcvYys5eTZmRnpjS0R0cVlG?=
 =?utf-8?B?dEJqZlZLcnFUMUNjL3hsMnNFWEE3WUcwbGZWd3N0OXZxVnFLeVJxNEV6KzRK?=
 =?utf-8?B?N20zdWt3cUtQemh2bHMzd2k2aXppNkhkdFY4allGMEt6cWJod2tTTFZ0cjJV?=
 =?utf-8?B?aVdYdzlWcFZ3clorMDFuVVB6SVBrdjNMdjRENFB5a3ExMkdlK3RjYWQ0bEVI?=
 =?utf-8?B?SmN1VGtZd1V6ZHdHL1NERzFzS25vNUF5aWk1VTZaUC9haGlxeVl4ak1xUjlU?=
 =?utf-8?B?a2hoeVV6bGdPK01zMDRLcUU3V1Zaa0dpRURHYXdtTDFuaDBPUlRvTXpCaS8r?=
 =?utf-8?B?cHB3dDY5NkZtS2p2blhqL3ZTRjJ6OHhiK3RoKyt2NmU4enFOVWhyeGJSTFZP?=
 =?utf-8?B?dGc1dVN6ZGhxUG5ab0xjN3BCVk51QTlZMXNyUzFVb21vdUc1NXA0RFo5YVBt?=
 =?utf-8?B?Tmt2Umw4T1J4bnB3NVBEM1U3ZW9kOEZlT3lXdTdIK3dhOStlTHV6U0k4cjBU?=
 =?utf-8?B?T1l1N01aQXZPeUEvWGJkc3VjSHc2a0x2WlVSMzBIU2hYRXhXb0FHQ1FRaDgv?=
 =?utf-8?B?WERKZVlTNDU2WkZXUTQzZkJaaWNLcHhaQklWZXVYZGY4eUdQTjhzMnBtK0M1?=
 =?utf-8?B?OXNTWFFoV1NQeHkyMTIxa1JIL1dVR3BFbmJWdU4raGRvempralpwcmU4dmtC?=
 =?utf-8?B?bTNseHBVZ1AvSXRCSk9kdDRLWXFyakxqRFZYcys0Um5URWI5dGRWd1RKUG1i?=
 =?utf-8?B?RmxmbGZqRE4xRlZwVys5UzE2aGVZUzEwc2lOSVpKQm5PU1diRWEyZ2J6SHBS?=
 =?utf-8?B?R25sY0oyajZpZ1NUdUhTWEZVY3JoaGV3a0ozK2dxZS9LYm9SU3JJWTF6em1W?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lWBLiT1+/AQbHpjRbXOfn+IigAlm4di4QjjYy1Yl7C796qcLBo1pW8IQNNyG5ISHmPXxUeRUrCKj6QrjnPk0s7n59y6UXwJcc8GlVEBjMGGas8Uwvy/uiNT5nrNIRwQCxqLAYRyWN4WyhI+YtxqTAg9Xfgi7djZh2B1oW6jy/hDz44YVQ9FfKUbnjT+LSd+wxidptrRU9gPZJs3cUeq6dU7zz7deBUyCJF2Im5nm1dISxCluhQU9i6eVeJRnpa4/s4pS3HH4SL/L+1IZU248oHi3RMFF7EjuLUJ9Td5szheDhY32k1J/gpxvsuDMJEYfLCSsHvXzUMwL0PPThmo/YntBbkYAaKqdZImhdGgDznAElcPZoKejewQ6udmhJDVJG7N9dlcd7xeGNj/h+ty+LUW/C3dRVS4im3cTgJ5RLHfB9uXhZ9t4+PRCS22LR6zS0Zy4qtuap9Ri+tHpwjGQx6i4tAR3hToXkuaSe76FXo15jf9+s4qk0m0G4pBVQTQlZR482FjVvYbb9/fAmw7KInirU2hBQMdYlDv5X0rAdrUBpRIdNMCO9EqipXfqg8GnyzOFnEDEiPa2SI1BC7/jJTxR6rG3yGDpEGlPtNe7YrE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5459fcbe-2582-45c3-3c9c-08dcaaef6efe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:14:11.8509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gxu/aJed3cKlNK4wSyzUBc4RA9DYCHJbh3IvQBr+kCSjkHvc6pRSKkqLrG9TvRYikENOyp21EueIswrJ+osuDHdH0+ac0ExIow7854rvdlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230060
X-Proofpoint-GUID: 8Lm3in35EGqiTAcxv4PPmo6AOrhxovO2
X-Proofpoint-ORIG-GUID: 8Lm3in35EGqiTAcxv4PPmo6AOrhxovO2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/07/2024 09:03, Eric Auger wrote:
> Hi Joao,
> 
> On 7/22/24 23:13, Joao Martins wrote:
>> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>> enables or disables dirty page tracking. The ioctl is used if the hwpt
>> has been created with dirty tracking supported domain (stored in
>> hwpt::flags) and it is called on the whole list of iommu domains.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/sysemu/iommufd.h |  2 ++
>>  backends/iommufd.c       | 23 +++++++++++++++++++++++
>>  hw/vfio/iommufd.c        | 32 ++++++++++++++++++++++++++++++++
>>  backends/trace-events    |  1 +
>>  4 files changed, 58 insertions(+)
>>
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index e917e7591d05..6fb412f61144 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -55,6 +55,8 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>                                  uint32_t data_type, uint32_t data_len,
>>                                  void *data_ptr, uint32_t *out_hwpt,
>>                                  Error **errp);
>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                        bool start, Error **errp);
>>  
>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 06b135111f30..b97883503884 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -238,6 +238,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>      return true;
>>  }
>>  
>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>> +                                        uint32_t hwpt_id, bool start,
>> +                                        Error **errp)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
>> +            .size = sizeof(set_dirty),
>> +            .hwpt_id = hwpt_id,
>> +            .flags = start ? IOMMU_HWPT_DIRTY_TRACKING_ENABLE : 0,
>> +    };
>> +
>> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno,
>> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
>> +                         hwpt_id);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                       uint32_t *type, void *data, uint32_t len,
>>                                       uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 7afea0b041ed..b882a3f59a6e 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -115,6 +115,37 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>      return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>  }
>>  
>> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> +                                           bool start, Error **errp)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +    VFIOIOASHwpt *hwpt;
>> +
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
> so here I see you handle the case where we have hwpts with and without
> support for dirty tracking within the same container so I guess this
> answers my previous question. So do you want to tag a container as
> dirty_pages_supported = true as soon as one device is backed up with a
> dirty tracking hwpt within that container? I think I miss the high level
> view of when this case may happen and why the devices do not end up in
> different containers/ioas. But maybe I completely mix up things &
> objects. Eric

I think the only gap I have in this series that I don't catch exactly right in
all this logic, is when the IOMMU dirty tracking is not homogeneous, which
remains to be seen in pratice (from h/w perspective). That's where we currently
have a gap here. Other than that, either we do 'all VFs do dirty tracking' or
'all devices are backed by IOMMU'.

A container may have different hwpt with different capabilities e.g. systems
where IOMMU instances have different dirty tracking ability (again I don't know
if these exist). Which, on hwpt without dirty tracking, on which the devices
attached to it that lack VF dirty tracking should be added an LM blocker.

These checks were added from the previous cycles, but I was actually thinking in
making these g_assert() to make sure this is not exercised like that. But
considering I plan on improve a mixed usage of VF dirty tracking with IOMMU I
left them as simply checks.

>> +
>> +        if (!iommufd_backend_set_dirty_tracking(container->be,
>> +                                                hwpt->hwpt_id, start, errp)) {
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +err:
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
>> +        iommufd_backend_set_dirty_tracking(container->be,
>> +                                           hwpt->hwpt_id, !start, NULL);
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>  {
>>      ERRP_GUARD();
>> @@ -725,6 +756,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>      vioc->attach_device = iommufd_cdev_attach;
>>      vioc->detach_device = iommufd_cdev_detach;
>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>>  };
>>  
>>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 4d8ac02fe7d6..28aca3b859d4 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> 


