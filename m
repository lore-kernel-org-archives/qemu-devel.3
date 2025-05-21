Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71343C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHoIT-0006dr-Ph; Wed, 21 May 2025 14:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHoIR-0006cg-IR
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:36:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHoIM-0007rL-NK
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:36:07 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIUAGo011704;
 Wed, 21 May 2025 18:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OSFxMZ43DLXVhxGoh9LhZeMpWQRSHwEdlGOtVCqGIyU=; b=
 f4hgwR0YhuEgBQunhOcjgN5U/1TJNGv6nZSVJoOV/qvzWvtV/Ef9JzStGWrAjJZN
 m7BFEGLXttvUW4TwgETp5+4sbkFQTev8LzJuVdeJaSpViVdzgNvHMEgGdv6j09tN
 Cwep53Q6Zy14/26Le87HOr6C/UsWuBibKJmDnbxf/nmdH3PYZHtbUJv0FcO1C2rS
 3iD0rYv2g65k9kqzXFv5m9EwowqO6fnRtnvGwhoSgdv5XBe24EpHZggseLQPozcV
 eaLaDObrlcK3hczAwlWW3GoW3+AGQTdq3hn/jHTEBefahpmazg3S4Ev7XlquqRK2
 aPAG1uGTWmc4g1cRZutidA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sktw01rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 18:35:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LH1mtp020216; Wed, 21 May 2025 18:35:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweu7us4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 18:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPHMkTx8F9wXUy5WGB/1i5Ni4hIxZwL8tqjijdrNg/6TP8NELgJdVlHAJFlHWXXD6BKMPR0fgtaDYMxqdu9GPIYYU+3Nf8Ie3cJMMi7AOiw9m8dtBFdD0wQNt3grLQ9rt5ywgZWBV8nzT5Y2s+JnldUyxTm5IbDofREb/Qxx8mb6qmVJieW/wsPerbf0+Ai0QCA4iwk4D9Fb6miho8PoglGKMYHtcU3IQPgMjMRNZaquvWVvX4L2/7saOAKIi1zRaEkqc87hmJT9his7QqoDnnAUvZuOi2EKOmNU4Qmnk+pgCW0b9qpULiWt+TZfeua+luqYfmdp46lqfxaL7ijhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSFxMZ43DLXVhxGoh9LhZeMpWQRSHwEdlGOtVCqGIyU=;
 b=rfjOJDF7EWBApcTRTeVt7+OYp60ylyucUjJuOlMIAV6FCGJTJQkfgn2xCFlLyaN9PwAhQcxWwfB8yq/MY6t0BdfFXRcpx+8NgI7glRv9b+Dm5Dmf8aZUYHyxD4d28VBjxkKbYycN5weph6bxXJgk2vvtbsoKVuqcvriLzYGVbxkXRmmnmnv3S0Agu+d5ksIaC6/P79UEo/ikKsjL9RjQsL3NEzPpuGwclTvrIIq3iahUwHwFSuPKpTy57L9v8vTTVcpoX6hwD7FmgxYd1xlim7FqURj6Ly3fILHwiweDeiiSU1B/GyPpFkZz5n/oYoPf8IIfSl5vvRjJthxpISnZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSFxMZ43DLXVhxGoh9LhZeMpWQRSHwEdlGOtVCqGIyU=;
 b=vmhnF+MQ9qXgazTejXMv6x4PtIyu4J8FrLlHCeV59o0jP5/9wk2wCGBVQ/64eYwRXdL6ONXmDF8glslZ1vYFmwnrkNhVTD3NHRO4bZJsVdTH+h3OPPteiQLiW5IfpDZZq7H5ckgvIbbZJfdIOvso1SvW69G7nZ9e0RuMiQkuLvw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 18:35:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 18:35:54 +0000
Message-ID: <e881ea72-4e6b-412e-be84-e9db5a3bc552@oracle.com>
Date: Wed, 21 May 2025 14:35:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 32/42] vfio/iommufd: export
 iommufd_cdev_get_info_iova_range
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-33-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-33-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c4d8c5-738c-4428-7ffe-08dd98965211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2hvRlVFdjcvRFg0dEU5VTc4OVJiMVZ2ZDlCZlFKbXBmMnNiall3ZXRjN0o4?=
 =?utf-8?B?MklaVDNkOTZycnVDRStNVUlrcHlkckFUbzk3KzJOUDVKS3dTQTU3ZUZudzNi?=
 =?utf-8?B?b1A5bmU3djBFV2NiK2QvdFQxQ0JidDBhYmRyRkZqTndvVDZhVlRJMXlGMFFH?=
 =?utf-8?B?Ti9panRYYjFFbHZrU3pFZlBDcitkTFBrZ0VMaVYwZ1RlTUpHZnE4Zzh3c25t?=
 =?utf-8?B?aEZMTnZuRFRLR29pUXo0K2g0WnRwLy9jeU9qU0N0RTdsd1F1Y3ZwdU9vSnZw?=
 =?utf-8?B?T0kxcXZ4YU44d3YrMk5qR0hIeXl6aStWZXBSUmNmUzIrMldVbXcyT2FkamFR?=
 =?utf-8?B?eFczU3k2UE9QL3hwYUdTVDRiSmxMV0FSMjRlc2dZQUc4SGRRVTJ3eWsyN1A4?=
 =?utf-8?B?UmtEZStqQ3o4YWVORDVYUTIvQXRSbC9FbUNlNEljSlF5MlAyU1ZaS3hBOEpS?=
 =?utf-8?B?cERQOS9JWjB6Y0lBMDg0MHRGMmpJYlM1QjIzVlBNcUptZmVENEplQ3pQZ1hk?=
 =?utf-8?B?NURvMzlxL1g1cytMRzZvcnpUVHBRNHZjbWM2aFZVWnd0aGR2bGRncmNGUHlo?=
 =?utf-8?B?NWovbDBobkxFTlFzRUNEcldpZ3ZXdzBBUjhxYm9wdVh4VEpDek8ybXVqOHMr?=
 =?utf-8?B?NSs2ZUlLY29iMUZIR2RQeVNCVmtuRnlQN1BpcU9naHk3Tng0MW9rM3RubU9E?=
 =?utf-8?B?b2hFMFp2NnRUcE43Mm1pK1VRS3l1UU52UWF1Nis3MklsMzVrQ2U2TU5qLzZJ?=
 =?utf-8?B?clRiK1gzcHdYNHZlNnVtcEtJRFdIOVV4UXh5eXRsNmhHRmRJalZKQjFUTEty?=
 =?utf-8?B?OFA5Wm90UUVXcW9tRWh1cVYvR0lvQ0tudTFjQm1MU04vTGpjS3YvdXkzTXFU?=
 =?utf-8?B?M25uS0lYcmZzbis1QTNENUhhdFJLU0Y2eG45WTJPeUxkdVBLazhtY2RmTjhQ?=
 =?utf-8?B?emZjVUFPVHY1TzRGOHR5Y2JCN285REdTejZscnhtNnR4ZHhsTkdrZ3VaY2ZL?=
 =?utf-8?B?Uy9XSEdNR0hnb2FuOGdOOUsybXdaRnNYRDVSQWt2UmptU1QvRFhIQXBuTHlw?=
 =?utf-8?B?Nzdnb21SeXVxV2RxNjhxa0JJN1FOd3J0d0JreEJ3SngxUk9tOWM2eERRc3M0?=
 =?utf-8?B?SEJGRmJQaGVaRGloTk9xNVo0eEJxZy8wNzRSVmVqWmM3VnJkdHFTb2JBWVhO?=
 =?utf-8?B?ZE45elZNM3J5eFhOKy9jZW9KcGlkVmNFTy9LbzhXWmtYdjJPZkFEUGxnL3Zi?=
 =?utf-8?B?M0s5UnM2cWVFcTRRYUNGUGJ5c2xRRUg0bVZmdGZBVFhVaEp3eGFSNk1jSHpT?=
 =?utf-8?B?MVZJV1lTRFUvZzhxK2J1bFpPN0NyQVBrVmttbmNQcEFyRHFLVTRLNTJGcTRi?=
 =?utf-8?B?VDZCOWN5b0UrSk5JSCtCS2tRRVhvemF1azhUL1Z3MEU4MVJkb0M2c0pHTDhQ?=
 =?utf-8?B?NURvdDdwQUVxdGhCWUZEMkl3ZVdhQTRiZnRVelFPWHh5czlKcFhqYkpYMnAz?=
 =?utf-8?B?MjNhaUZvU0RBMk8rdHVoa3RJYUV4VVBXMFdjUStHcUk3TjhSeFZoUkhnK2VX?=
 =?utf-8?B?M1BMTlFETjNDbFdVeDFiVlBvV3RHb1VTUW1DOWhqbFkvbzhTRHREdmp5MkNr?=
 =?utf-8?B?TUtSdnFWRVFKeVVSbEVJY0xkcERuVEh6RTU5V1pXdTZaQ3Y0UVdnTEdYZDQr?=
 =?utf-8?B?OWRkWEs1U2FvTXFzemgrMHFqVXNNdzJ3Tjc4cjJjTGR2K0ljaEpWdGYwN0Ex?=
 =?utf-8?B?ekxoTlBaVmNOcDBkdnB3K2R5aDI4cXNjRVRJU1ZTUWdTUkYzRytMQUNVSzg2?=
 =?utf-8?B?YkJiaTBoTUxBa2ptN090N3NPVUpqc0gwYWpQT2trNHRkUnNoeDlLZ0JVR3l6?=
 =?utf-8?B?Ylh4RHRiYVBLdDRObkpQaU1KWkMxNGkvVUV1UEVQMWhyV0xQemoyUG83WE5Z?=
 =?utf-8?Q?1znGnQFdEzw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWxMaHQxTFVuQTFsR05SQmpkVVpkRVpGMWdwbTladXhVOU00M2s0UkgxWjdx?=
 =?utf-8?B?VGZudjhXQkRNOThKMFB1cnFSQVo2ZjY0N05OT3NMTnZzZDZVMk81SVZyangv?=
 =?utf-8?B?YjQvaEMyZXRvUXV2RU5CUCtHNzhLaTRwL1ZtUVZlRU1hM0hONlQxUEtBR0o4?=
 =?utf-8?B?clpUaGhSV1pmcGJFbDZZMDdPTHBNRU5Zblhxem9rK1JrTGdQWE9Ec0xOVkR1?=
 =?utf-8?B?OGppU2NYamVSS1BqeGFOTUxUYUhvRXEwN0ZoRzZ1WXgrNWxnU0VjbEs3TVAx?=
 =?utf-8?B?ODhYVXdtbTQ0Y0xjM3hMT0dFRVlxODNKWTFNVmtOa0lqeWNodllYNGFKNkVC?=
 =?utf-8?B?UEpOa1JueWhrSDF0cTdLVllkMjNoeGx4SXQ2UkVhWDJvZFcvNkF1dWdCM212?=
 =?utf-8?B?Uis3b3ZsN3F6SS9BNEFpNnkzYnJEc1lVajdwcThIMW0wcDJvYWwxRWlkWksv?=
 =?utf-8?B?K0Ywbzc3amJ0OHBIdHdEWWRpQ2huZjhLNXNLazZmNWVrMm1hak1PMFJLc0FX?=
 =?utf-8?B?QTEzOWViemkwbXVPSVBLNkdRY01DT2wrdEtKUDFYMDB2YUVhTldkMHJncVVo?=
 =?utf-8?B?N0ZDSUxVNmIwcmlSbSt5YW01eDVicGZ0VkNud0I5THltTlFJWkxjc2NhUGNo?=
 =?utf-8?B?UlhVakUxNTR6a1daYmVxL3F3R3NWeDVwNHpocHBEaWpmNE1BaDFxNy9FYXNj?=
 =?utf-8?B?eW94eC9ENVR6Z2hlWnN0cWdJeGNuRUNEVkF0TU9GbnJXV3hMYmtZUmpCM3gv?=
 =?utf-8?B?M0d6YnZYdjhmcXNaM0lDNjBpU0JWaVBqOEVKZ0xyZ3l0NGRRcjBUalBha3NN?=
 =?utf-8?B?MlQyazVJT1Z4Zk5SMVZiMGdXUElDbDZ1NElFYjBmYXUxZm5Ma1ZhNEZ4VXVr?=
 =?utf-8?B?eFBLK1JPb01TYjQxdkxrZ0lYelFhUDNYL3kyejlaZGE3T0xyY3RJdENuYUhQ?=
 =?utf-8?B?dVl2RGE4QWxncU4zM1I5bEhOVkFXbVdWenBqVmw4L3dlQXdUMnJ2RUszS3RH?=
 =?utf-8?B?ZG12VlJlcGVOUUNNZVpmVk5tdVZ3ZXhxRnhuZWVrOUkyMjNwaDg3d0xRakND?=
 =?utf-8?B?R09nT3lSYXB1RVdsNXNwbHpFd1ZKRWxHd2lQTEcrNzFaMERKQm4xUTdCNTc5?=
 =?utf-8?B?YTY3L1Y0S1NhWjRtYWVUYWJSQ2Z6cXJHd0pWT280NllORWVoenhyQUlhb2tm?=
 =?utf-8?B?cUZHMUhwbWhuOWVKZTllSVBLeWZaRzkrckRlU014QUx3bkFTeDRmcUU3a1VX?=
 =?utf-8?B?bXZjUzMyNmdMeTdQcDU4bVBvOVJMaXlZKytMYzRBT1Vad1RyREFuMTBPTTBn?=
 =?utf-8?B?N1Y1am9veXptQ2wvd3lqNFNFRUZtUzdOTFZlaXBzcDBXWm5pN2pCUmt5RDBt?=
 =?utf-8?B?ZmRvTkIzS29Ob1I1UU9jY280YkFsVDN3b3FaZnhKWXk0d2hvZEthalBYeFRm?=
 =?utf-8?B?ZEt4WmhzNVg4VzlsaU1aNzB3SWJDSE5abnJwNFRsanJqMGJuVDFsa05QY3U5?=
 =?utf-8?B?dVdmeCtXclBPZFJieHV3NGdDemRwVjV5ZHVLSk42eTVxMnErMHNiV1N4akdP?=
 =?utf-8?B?QUV3RENqUkRFVjloTWFvdGVwcmJYR3c5RFVBRTIvVFRIRUNLOUJwZTIrQ3gw?=
 =?utf-8?B?TGkzeVR3cjQ2TWNadGsySWJ2OWJDR1dVbVdpeHVFSE1CK09XcDdydjBzQit2?=
 =?utf-8?B?am9wSGh0dUJkNnE0dUh5VkJSbmRzRnUzdkhUeWlwMFdIaWZYZW1Qdm1nZU1v?=
 =?utf-8?B?dFo0Sjl2NXFMb2U3d0UyNWdQVGswWGw4MUluT0ZsT3UxRWx4MkpmWExNL0tN?=
 =?utf-8?B?cGVHeTl4OWdFQ2dFNkVIVExFVDdSdXh1TnNyVEtURGpycnFDUjJnYUVlUnZ4?=
 =?utf-8?B?N3pWWHNkem9iY0dEUEFEMjMwcEhwdTJlTHlEYzJzSE9PVkg5ZGluWkQ2Ymx0?=
 =?utf-8?B?Mm1YdkJlWlEwK0FFSVVFSyttTSs0OG9wQ0lMWFdXNFB3ZlF4eW44QkxKcldz?=
 =?utf-8?B?dXdrdmZvek1ETlQxb05oOWlQOFlwajBzOTNxOW5iZzMyd25xYWMvOEc5WXlX?=
 =?utf-8?B?MjJBRnpHajZIS0UwL0J5VTBkUzE3WWNuMmNQZW50VnpTbjFiVXRwbVIzMHEw?=
 =?utf-8?B?SkwyQ2ozWndYaGJxZ1JvQzlmc1d4VURCeTA0bWpIT0x4TWtBNnIrckVkRUxt?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9loiIq3UBCsko1uGGdz0g6MDvTh9qf97GfwS9fGTjJN5+9k9VUnqR2AKrbyFyEDrFANab52AEhHdceIKX14qOeVSdFAZIG19h/YrNm6F8a0rlEqDmamgn0hwKCz+ukWLERBL0sUZCzhQnkIelHc4Lf92PGtPSVokvSFV+mATByc2blLHiRoTnZGGmq6T5YhCDGguOZbRN2jR3llxCr/YonLzwNGxf6Dntn1bjMewXG4kVy2ZJ0i+9p8Hy9H3VYQxzxRWbA6WrlB8IqWUa89HB5N1sM/WBzE7PYTrdhUpiiRT3YBtE7zTiYUmwCWyvy894CouNWzAi4SGf7GTz41+C/e5kp6Sy86ipz3wEgwtWJxB7Esinep+GLEkrblhX2grnNMRUTYM4Oxk0X2pud0xTIStSWyBhGi6Gu7J+bzc0hiDrHQdPlxRLpeoSDeOpaW86mqZywKn49jKPuRFEgxpMgduU1KC7yM8XxDnAGktq3f9+pEm2Lp/wrwWIdiKY5KsuFM8thQWOMqo/nDmZvzYh+NCbsfnHhs01aSmIe1wvn9MFrYD7JrPIhtn3CJrXCRYdjCSoWoJZ7Tynq0rY+gmKfFNrwuJZcRwOOdx3x2u1As=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c4d8c5-738c-4428-7ffe-08dd98965211
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:35:54.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUXRksyNWj9GPZf/KW8TW3PV5oNFca6xnBOfihCA6OF3VGn+DiR976zww6eqIP87YNHFJY/pZDgrOWaKBE2Q4bJgFAwzkrCMcMzsxumDHvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210184
X-Proofpoint-GUID: qFUKiarAQGDpd8Kqwpp1JBo-uvqFkT-w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MyBTYWx0ZWRfXxMYIKGg+ejfB
 OD4nDLUR3eMmCpZljXUICRz8J/z4k7SZzuFkxQselYim1AJGDrslcPwcVrQjMBXTHd7uUUUg9Y8
 2uMwuW90S5KXKimsMobw7B5JAGbjsvlrrltSBfBNGVVfneSXWw8WaHjIlgFHLF/2bFdbrHhBTU0
 KACl1d+w8J9r53rW0wmTe2QJeR0xsD2XcP1WMOmyRjZ2unDpev/kbMvNhGNvwy+XlPEi9dxpG3/
 1fHSO/KK/NzLgPjP4of92ebjl8Z3fxnh4I8u72VtvNFrrlR6kJQ95rgzq9tyf2Ih3mvJHeZlOUB
 UYN8XJs9N1Iengfg6p5F66R4SQbgJpkOxS0w4L3yrpwqmDAag1+CKqfUdvlM7P/EaYkAjsnCGea
 2DOIF0nS4oYDSL4gcQ5YbiVf0TTyT0ImuYKPn2z6lIVCiGnOjgBLRRN4at/a81oNKUJ+LNVq
X-Authority-Analysis: v=2.4 cv=FrAF/3rq c=1 sm=1 tr=0 ts=682e1d0d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=lgpgWkLgXp2f107DXQgA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13207
X-Proofpoint-ORIG-GUID: qFUKiarAQGDpd8Kqwpp1JBo-uvqFkT-w
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

I withdraw this patch.  It is not needed if I save ioas_id in cpr-state.

- Steve

On 5/12/2025 11:32 AM, Steve Sistare wrote:
> Export iommufd_cdev_get_info_iova_range, for use by CPR in a subsequent
> patch to reconstruct the userland device state.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/iommufd.c      | 4 ++--
>   hw/vfio/vfio-iommufd.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 6eb417a..f645a62 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -459,8 +459,8 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
>       return ram_block_uncoordinated_discard_disable(state);
>   }
>   
> -static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> -                                             uint32_t ioas_id, Error **errp)
> +bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                      uint32_t ioas_id, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
>       g_autofree struct iommu_ioas_iova_ranges *info = NULL;
> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
> index 07ea0f4..5615dcd 100644
> --- a/hw/vfio/vfio-iommufd.h
> +++ b/hw/vfio/vfio-iommufd.h
> @@ -31,4 +31,7 @@ typedef struct VFIOIOMMUFDContainer {
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>   
> +bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                      uint32_t ioas_id, Error **errp);
> +
>   #endif /* HW_VFIO_VFIO_IOMMUFD_H */


