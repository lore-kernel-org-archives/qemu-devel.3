Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E62C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revKW-0006EA-Dp; Tue, 27 Feb 2024 06:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1revKU-0006DP-R5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:08:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1revKS-00074W-Sz
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:08:58 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R9Jc2K012517; Tue, 27 Feb 2024 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LfvRVJR5MAuzs1yNCIZYfT/hMMfkXGflMwKLBcFn9Es=;
 b=LgrO7xEK8ODcA11UMLQZeJKojRyXBpR+niTe+uG8oxpEiEA7Z/mRFBnjxwnohD2wPOIb
 MJDUM7YzVJZb8jDL6FFavXNP8T1XZCAZQQoWmXtuF29NgdVEz01q5pc8qK3NIQutrc1W
 DQf1up/WjmTBhzeBkwjhlP+VcMCBvLT7FzK3YCHrkF3mnu9SsKyH14hY4zhWHt6sCdQf
 1cNajPWRtmCpl+zhP6PFujqByDrZoLB++DFghFarcKZ1Ep83mnSrA8IKI2TrkWKkVleT
 oc6vK6YScBciIlLNLKK7g1LwYuwhM/Qr05BifyWTMBcf2OeHnCDwyeP3OYog/5b7S2cs YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb6u1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 11:08:51 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RAa8iN022465; Tue, 27 Feb 2024 11:08:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w77ewb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 11:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR8B3U6CwsudZc2fjU4eUPmcndFBHFPie8UwDrVa/KjoyLYD7lrayRQWATA9tkLMaSTHz6IxSLvJ8IX/1Lr0DJ07Rp9IHDZfBlSM3uyurqRrJsTV+jLjmOUvT/w3ruml0Y0zVb6+n3GzmE4WR2tOJxbkdj8BcNbB4StDD7njU0BXmm5he9OH+z9N6Tt7cNDUL6dq9c7X34vUMObNiO2/tdsXqNYsivQaBTLk0NpqGhj3Y2jNX5RBx/2YqAlqGTmfZBTJmQ2oX5fwtbx93qg/CMFrdoNv6zLHnWyySI16R54HJSKst0a6meXkPpp+MpJ+Nb+O8Q/YCLRWlzGzh39+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfvRVJR5MAuzs1yNCIZYfT/hMMfkXGflMwKLBcFn9Es=;
 b=oXA9gjCxRjvj/AwZVig+A0sj6n2XhSqaewAFfgEQQjenLsoVU0dQdX8uJAiraYTBVv4bVFmULQNjgYxmeJtt78AqoIMCDba/3/KFhWLH3qi47bCOV+8Z06mEiTba+yfVjEXqq2y2a4Wn+787Vrs+6F3q1DjLaEKlLT0O5Vl6qJ3Ua8ar8dR5S9I2E3swRGWmwd1IHplcuVv1p+ec5PQ7gN9u0CtC5ZxC2b6XzHdIG0hBc6ydPNMRhRL6LRN0HJ0XW6ol1lTjlmDARZFojnsQcg/OOa7wcLVVDtjCVKdmKMlFJCyXInwD0JP9aGzJs6MrAjTp0p7C9m5+WIBaankHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfvRVJR5MAuzs1yNCIZYfT/hMMfkXGflMwKLBcFn9Es=;
 b=giGH4bvxY8EOqQq0MaHqBuxf9KO1AmBODNhjkhGfujwn6z81dZYCEgfk3r4olJtpN8RHnmTsi/qZNRCg7iiCk3qZFvQyzGwYR7RvWw0Bci3q2vFDuNNnCnq8Pr4W/fCxYygVzRJh4FCQiNAnqE29lZC5qOvJ/MaqsIYFDCXnjqw=
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 11:08:48 +0000
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::c3b2:b415:c3be:77f0]) by SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::c3b2:b415:c3be:77f0%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 11:08:47 +0000
Message-ID: <2446ce38-29c4-4593-afa1-014299bdc740@oracle.com>
Date: Tue, 27 Feb 2024 11:08:23 +0000
Subject: Re: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is updated
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-19-zhenzhong.duan@intel.com>
 <72642921-98d4-4c4f-8117-868d2ae29eb0@oracle.com>
 <SJ0PR11MB6744BF58C9C21D5778A2D15792592@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744BF58C9C21D5778A2D15792592@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0112.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5891:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 14256fb6-a758-43e6-6b17-08dc37847139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpOSrudI1thLbnwoUw+NPUp9f1EmQkC0aTJv4H57TM9Hy27U2V8bO38yGmpW4fMNRz0K1N8Tn2POzkqatQuDwncpTC82uIrSNRURqLZZxiLNt1SEhqKSw4ev0zT5pUhVnN9vjJ9NJNVFwM20MJsTo75o163Km176illH51xEJvI5vCoB9HSaGfnKNERPi/r1x3Y5TcB0XltPQrURYtoiU1pzr0uzndBupmWmajg4fGM9QTkqB7BhlvEHJIwvU41NdyI1iPnvQqfhU9hF5HsJu4TjYuHiEYSbogTPs6lMhJvxWkl5cHRVIPUeJ+SdcsAZU3R2dPFggp7SpvhGXwjwd0+cr29DW0kytBSV/JnYAToKohZqgwWnpLJO740TArWE4vsZvKErTuEh08zQXDXeATh6f1xcdIqtxFAAcTlLGxB5N7/586jXZIU3pXwJTm33Re6dt7k0WAlyvDnutlRQarHk5RN0T7xMo6bzp9sjlpcJ08NzwGYGDHtXSqP6NiDOMvqnQ/PWlskWbBhrVmklcNSmkZKCBQUKQG6O7BkC5TrxfLc1d/dICstAxLaqc65CUqQ9OiP0PrEnVTDJMQq4Z1O7zooMsk9HGWWS3oqNDc6Bg9bCbSINfAFKjBTDjT0TR9yJsgLgSOv8xOfPtMETPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5891.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRCUmw1OUc4aWNVNnVzbWNzUHBDRUFxYkxVZmo2V2NvOEp2MWVMNHdxSnpV?=
 =?utf-8?B?WlVEVGYzTlNOQysxdGM0bFNneU5KdUdEYllvelUzQ0dnYXFkT3FBanUxOWF4?=
 =?utf-8?B?ZGo1bFd2bDlSbEk2NW9vMnB0QWpOTXBxWTg4SWZUdmtKWmd0ZnJYaXFrT3dx?=
 =?utf-8?B?akNjaUk5aElQZ1U1UTR4a3Mza1F3N2lNMFovRmozblhVb1hwazV0UFl6cWVV?=
 =?utf-8?B?ZVoyV25GS2RrTFFRT3llSXpHUWY1OXlBcmttNGZTRnBBY0J4UGN6Rys3Mlhm?=
 =?utf-8?B?K3JjdU42R1VwdCtoSDhZVnpjamJQVi8vUy9GZHFFdXMyc2VHN3hrdTl3RWVG?=
 =?utf-8?B?WWs1bU5kYlFjRFhZMXZWUnUzY0tOSVZIUGZObStIUmUvVm5jWjBMY2VaNUVW?=
 =?utf-8?B?ZzBGOFBYZzc2aUhhNVc3a2RjWStDRjhDUlZLQnBGV3Axd3pYWm00eEttMEh6?=
 =?utf-8?B?eDRrSzZNc3M4SnFEaFo3S3d3bFkwMDRNVkV0SVRmT3FuUmdiSVBjOHVIV296?=
 =?utf-8?B?UnJ3WFlVTFJwblZKVG1lMjh4OFJCeUFuKzNNTWZwdTlDY3lSNWRUWUZ1SkFN?=
 =?utf-8?B?YjJOZ28xQTBEU1VUUDlBaEh4QjVtVjRHc1dnSUhkendRcHhjb0dvNjMrOWJC?=
 =?utf-8?B?aHIvTUtQMTZNMjJ3N2FrQ29ZQ21QT3B2b0JUTDdzOE92YlVRenhvT3hZbVk0?=
 =?utf-8?B?d3hUMDNaRkI1S3lrRGFRQXVkV3hUeFdCQWR6NFA0eDZPeDgralRwa1N2KzJF?=
 =?utf-8?B?cWQ0amllM0xRM3YxM0w2TUFXVEZjUkxSZ3ZaMjQ1RG54bmxyRGNrbm82eEV1?=
 =?utf-8?B?d3QzYy9Ld0kvR3RGZnRxaThCRE92K1JrV1EwUjBqREszN3dGTXdobXdLS1ds?=
 =?utf-8?B?akxlOVJub1VpQ244aVdYTXFJc21YTVhMaFlMbnVvV0l5dEE0UEs4YnRwTm5S?=
 =?utf-8?B?ditNaHJrNmRWVkw2M3Jib3pNSklEOS9PY0syVHpxb3I5b011SVBZSlpJTkNm?=
 =?utf-8?B?amVCdyt3WGpqYnJOdmRFQ2xBQnpxQWtZZGxpdEpnNExkbk9qbEhkLzBBVksy?=
 =?utf-8?B?dkpWakF1ajBpQ0FBM0J3VmZBT2xJS3VpWDNEZlFZSHBpMkJjQ1ZGTzZVZGJy?=
 =?utf-8?B?ZTBJcnlSZ2lVclV4SUZjNEE2d1dyWmNQbmdkc1VmTi9FRFUxdWg1YUFCbFh5?=
 =?utf-8?B?VEFLUThLU2VlNGlBdnFRUFU2VkcrcXJUeEo2VTFXemozaFdLRWVrWDY2TUQ1?=
 =?utf-8?B?WlFZbFVwcGc3dE5uUjR2TTZ2Vm5iNjdxTlYyWVo2VW1CZENkaHY1ZE5RZnBl?=
 =?utf-8?B?WUQ1NDFUbFQzOXJXN2h3V29IT0x4NTZteS9SWTRNb1VIR2VWS1lRcUx5d0k1?=
 =?utf-8?B?bFNHRzhmR2lZT3RuMXczeFlZd0JvMGh5d014Qk1Cckh6K2t2bHA3T1JpWXVM?=
 =?utf-8?B?enF0eFFRK3lNaEdORjVTK29nNkdVWDZyc1lCaGFmaG9JQU1Vajk3NHg1alhJ?=
 =?utf-8?B?L0k3TTJ6VXdoV2liWG1lRU11dTB1K2swRExvb0wvR0s1U3NNNmQvVzc1V2pT?=
 =?utf-8?B?WmZ3WGdINVFCUytSdktGR2hFZHhqc1JZNkJXckp5NllKdmdLd0c0alZUWFVa?=
 =?utf-8?B?ZkVvWnZQUzE3emRjNHhFUmkwbHJXSkNlNjVjRFRQQlJrTVRmYy9VVVFUZnRM?=
 =?utf-8?B?Z1plblIrUEtBU1AxWDdIU3M5Y0s2b1doOVNuU1g3RktCcVlpVlpFaER0Y01z?=
 =?utf-8?B?SENVVHh5c2lSTnhXN1V4NGNub2E3cWFXUStuOWRBaUNxemVXcGR0Z1I4T2RN?=
 =?utf-8?B?QVZPbzMydkJINm53dXp6SXJWaUtVaUVsTE5MRmJ6UWhDKzFkWTBnMGxVS1JJ?=
 =?utf-8?B?NEpLazRlMmx6Z3JBY0ViU1F3NUx6Q1F5OER0Q0ZuV2g0MWtnNVo0YUdaeHh0?=
 =?utf-8?B?UmlDNGptUmVCMi9lK3BkalBVV2FkNTFQOExmQ2ozZndNam5tZ3Njc3R1TTdy?=
 =?utf-8?B?UElNMVVURDVKV3lDR3duWjFLL0ZRWUFnRXc4alpSaGdnTTFBSy9lSUd1ZVpJ?=
 =?utf-8?B?NnZjbXJrejZJOTd4M1dtU01TeFdXUTUzejNjTW5MbGRFMjJpNXRPZWp3c1pB?=
 =?utf-8?B?dHFnT0ZXcEtKa2ZGdkJ4ZkxCMW9SbDFkOENzN3FJOENXdi9Tdkh3cCtqb2tC?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HlFFh0u1IeDCVdomcoZeuyuNlnxmExz8HLHCu83VyDvjxUG2B+AXRrlLiW8oFWi0GTcLGQoWc8wIxAm3vqYaDovnj39slhpmjNhd50aOnWgxXAexiqqMYqx6GZraRIUePf9zH88hdODUfqRfWIRAeOxdglMkDErU4qjosd/ERX2y51A/FHqqqQkbAgMF4YeVMMI/7Mqb+NR3CJ5Yh4G5XbZrOu7rCunf3k2n7ne+ypd7oOmI5CXoSWDCn5xLJxL+N7xHePkGtfOvoRX5uZ4GszYvHhOu4wzpcrM2iInguMBTvsNrKhId3g/4gQoK2MNjKi4M02m2xNTI/VZgGvL1keoAYTSgQpIAWDmsEEA1Zdkugf1GmkFyjvfNftiYhnMw2GARuJXl5D0fp4LCArF+B2iccrrJOt93yD+Ypp0iCOIek9xWmuoa7FNB8livF7LswrG8Iz933XE0YzTX8FHP3DECXnOAB8t1O9+jjIkEmfD/t7V7b8lpS95giiJ/pMRY8nvj4M111gEZIFgORUgiYblwwt84oskoF5uGgFMEtvkQDlgDtd4toh8cXbQL4pSmvlyU2aQraQhdgxcOmtnC/dDFKb+Fn2029G10S1S77NY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14256fb6-a758-43e6-6b17-08dc37847139
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 11:08:47.8545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yzu6ggK5t69yNQKYIX3yQi84HTgvYKU/WkSbGCA1MIpMnGIrXWO4NLKl3Yz8di3fzonJELJjPBcUNjQhnyQVPiQJWMCqD7ch0Amr6yC00Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270087
X-Proofpoint-GUID: uPcxRPFULniFoQr7nHctv9MnEz_bEhr4
X-Proofpoint-ORIG-GUID: uPcxRPFULniFoQr7nHctv9MnEz_bEhr4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/02/2024 02:41, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is
>> updated
>>
>> On 01/02/2024 07:28, Zhenzhong Duan wrote:
>>> When there is VFIO device and vIOMMU cap/ecap is updated based on
>> host
>>> IOMMU cap/ecap, migration should be blocked.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> Is this really needed considering migration with vIOMMU is already blocked
>> anyways?
> 
> VFIO device can be hot unplugged, then blocker due to vIOMMU is removed,
> but we still need a blocker for cap/ecap update.
> 

Right which then the blocker gets re-added after you add one VFIO device. The
commit message refers xplicitly VFIO device, why would you care about blocking
migration on vIOMMU without vfio devices present? Maybe there's another reason
but that the commit messages doesn't cover? like guest MGAW being bigger than
host MGAW or something like that?

	Joao

