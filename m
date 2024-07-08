Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ECBC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqMI-0004zY-If; Mon, 08 Jul 2024 11:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQqMH-0004ym-9k
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:32:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQqM8-0008Ub-Kr
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:32:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWle004202;
 Mon, 8 Jul 2024 15:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Dq5tXGooBJkBA98/btNurqKU2WtGFp1lR7pYWjTX5ro=; b=
 YOEGpMNZbwx5/Dl1Bqa/1mC0AMDbTgp1zrB0XpVlg4CuUh8I+95PTlCq9DWRWr/1
 D+PMIUj0aA1HKNswcU01z3gc1KFIdPc65PbAISWqvMvtAUPsa3bWef879oaloML1
 9m98JfzdNcqhROFO8/W9gYbMXVUl+g9vL3T4ZRoJQys0ZEnrnDe1LGIBaUP1U0Oi
 /amH1x6/r0ASZpEzBvlyjKtv/A5/1zWBUM07k0Y+cYdkPgELiG3PktlS40RFZHWv
 qiPXSwmHROKSspVDn/7/7feHfv4rgxHSchyGufweyCHY/69IlyyiGlHJylvy8rbf
 v6xGsmh3PDEt7U5hw7PBGg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8ax1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 15:32:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468F326h013662; Mon, 8 Jul 2024 15:32:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txfjr8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 15:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUhROAw5ulXbVAq6Zw5BVFVi4tLpdfdpTwgt4rLZ1eEEUP/w7WyiW9RRN3rkasHKqmvi1az5J5jYI/tmVKOKZH5coGIwAEmXa0oheHJo0PU9iLz2m4HPlWs8ABMEVKYGt11s6qoTgXAB6lnM/cfmsjDGV055M7XNn61zcy16iRQe2Ay7U79sGzeAnBu/AZ6GNZ2iN6jKZE8VnHh5AXLIqPRzqvu1hzkee0CIoNnzrExjo9Anw9yIkUD8bxpR9OMs9XKpC+XsifJLTEn8R4J57Ws0MmvYKZf5twB+JI9wxiBbEsZHqdARdZxvhQj1CSxuYVsCAoWCehxBW72w0zJDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq5tXGooBJkBA98/btNurqKU2WtGFp1lR7pYWjTX5ro=;
 b=Xd7ZZnDiamOzI2LGquzvuSEbbW5HkxW7lcOzmC3TaKRkq9tFYBMcU8dSwpHybL1sVUKY6UfDixIFCOnSn8WQLjHGI9E4iLvkw3+z2PwSaxDz8uWOyBdzAC7+hKL64EznFM4ToyzRxlT5GmTQxPQEXOSsDzh2ILJp84u8HYbJBQHr1Ov/z/y1/k5IIBbqzfUmjNDH8HttVkvd3PiLTx7Z0dr2hr+aqOscqpfpqgr8Mlvizd5uPapKha537QK0bl92g0ktjiOFh4eSZoL2dhPE2LDVi8LKEmtvuVZPQGN3WVgm1Un+s5oqAcZk5a5R0wHLpO6syaKtsLrMQ3NzCSPOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq5tXGooBJkBA98/btNurqKU2WtGFp1lR7pYWjTX5ro=;
 b=A9+BAKbn+pMnytnQB+f1Ma6r4ToR3Aryaw6n3lpPE6L+wTqrRSGpJtYfg6o9J6n9pkQHlXXqF2nI1DO9Tc/UtJOOvmoYNGP1qdICsmB+gaojlAjSrRE4unXq8e1vCnJMY47ZQQP17naQHGvYRr8YBrWQaH0mgEYg5v7zi1LXpj8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 15:32:37 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 15:32:37 +0000
Message-ID: <e57d4d48-0908-46f5-a2de-615c4c1edb5b@oracle.com>
Date: Mon, 8 Jul 2024 16:32:29 +0100
Subject: Re: [PATCH v3 03/10] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-4-joao.m.martins@oracle.com>
 <5420483f-03cf-4383-be73-e3a8ec2a4378@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <5420483f-03cf-4383-be73-e3a8ec2a4378@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0030.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: cc95d159-565c-4f4d-668d-08dc9f633234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SklmbUdGVUxWN05WT0NTaGhVTGwveUMrMUFjbk04WmpFME1hR2tTb1VmM25E?=
 =?utf-8?B?eE5MSEMvRVZGMnRTcEdGZ3J1MXJVNnVUamtXSkVGSDAwY0YrVUlnS24yOGNr?=
 =?utf-8?B?RVMrdEprMzNvMkRwWEUzTzg2azJEY0tYZ3JnckFUSC82TFJ4WTUwWjFhOUpV?=
 =?utf-8?B?VEhlbkZHMmpRejdEOW0yRExvOFRESnpzYldUbmRRaVNmcTlzdVdkSFBKWmhj?=
 =?utf-8?B?aXB0Q1dLSFZpVE8vT0pqWXJJWjhPTk5BN1VRYkVVRVFQMWtqcmxoazh0amRs?=
 =?utf-8?B?MVowWDRYYXpWVlA5QzBHVWFMTkZSTzRiakg1WVR3MmJMTDhCa0o4Ym5CWS9n?=
 =?utf-8?B?dG05SFRpZ3JzTGd6UG5BMGdlaTMzK2h1SmREZzlSRU9IWHpVQXVtM0VHa3V4?=
 =?utf-8?B?N2gwM25xSmhRODhWYmpQTFhnWVVoVjgwaXVkRnVMZmVRdU1KaGdkS1p0UTZ2?=
 =?utf-8?B?NEVqZkw2Y2VxNHloSlpEOVJPSWdVWHRmakNnZVFPZkFOeHFSRmhSd1lUWnR4?=
 =?utf-8?B?WHFtRmlsM1hRNkhYM0hjcXYrZnNCTVovY0FuQkFSei9TcTJRYldMZmxpcytZ?=
 =?utf-8?B?Wk0rUTVudjVMYXNSdWxjeW13eTNsVFhveng0WEhjQ3ZEMllvOU9VWU1GRGxx?=
 =?utf-8?B?ZG9McEREemhkSXFJcVRnTnEvdFM3QUgvU2lwbjM3T2g3YVBMWFNqVThaUHpL?=
 =?utf-8?B?cWp3S1dvL3VUMVNnQnpwUTVPUGM3SDlYUUFwN3VXWFhlTEw1VmJGMmhUZ0Vl?=
 =?utf-8?B?NDdsN3RObURtOEpVTHV6Q1MvcEhQL0RJQnZDZmxUUk5uaGxpa3ZSUGo2U1BI?=
 =?utf-8?B?ZFNLcjNqZ1NpWW91T3VualllRmdJUUttL3hVenlweDN3S2IrVUxpRDhiMzFz?=
 =?utf-8?B?T2Q2UnNUMTQ5VDJwbmExdFV0VGptcXEvcFhkOERNRHRmYXlMZ0R5RitUMUdx?=
 =?utf-8?B?TW5mTWNlYTRMZE10ZHNrR0ZBQjZVVll2NENDUkUzenN0NFU4WENUWW5EbWRz?=
 =?utf-8?B?RXl4OWhtT0czclAxOHlDWmRNT0dmd1Ewcld4a1oyaWcvK3Y2TWNqckJ2WGJa?=
 =?utf-8?B?bUd5ZFdQNWcwM1Zjb3QveWtnS0lDZEZCYUNlNTVuNmNmL203QnZJOWxMVmtu?=
 =?utf-8?B?Mm1wRWJEQ2Z2T3BuYmJzdUN2Vncyc1diZ1ZPYzgrWEgvZVFEMTRDN2JtUlF4?=
 =?utf-8?B?RVlvdytIWUNEK1JvS2c1M0VUMGlpak9FcTcvTHM0SkpkWGZQM3RyYkpEUWRG?=
 =?utf-8?B?ZDZjQkZORG9pTVRLMHk4ZUtZT3IrY014MXBxamJsV1JWN1VHeUsxYmVjRjVo?=
 =?utf-8?B?Nmp4K0N5eWwzVnlhYVFWSHRDckdoVDF5MkZKMUJldW92WEVYZklWMnJMRTVS?=
 =?utf-8?B?bkRXaDdKK2JPd2oyT0MrcDVlTWk3UEllUjRXaUZyR1ZRY0xlekNLTjlyM1J5?=
 =?utf-8?B?UCtxUXhpNVlLcEp4V2dvbXV1L3gyOVVrMjBKTlhobkVsdGE5N0M3UEZYUTVU?=
 =?utf-8?B?S1krSzhzcytFRzQ0bFhWK29HZ1RQTlAveWdVM0tUZ21rSTYzc2IySVdyNFZT?=
 =?utf-8?B?ejg0NlNYOFVza3pKak5XWnlxZlR1cnNSaHpCdXVYVXMxMGlGaUNxN2NVZW42?=
 =?utf-8?B?SlcyZnJXTmN4MnJRODVKdDVORWF3R0hJK20wc1pWVGkxR0dEcDhVNlUvM1kx?=
 =?utf-8?B?UlRSZ0VXR05lZnNvYitlamZCSTl3bGx3ZGxUY1g2L2Y1bWk3LzhRK3kxYWRa?=
 =?utf-8?B?Z2FVQkMwanVNdnNmL2ZOSFlhMDViSHE1MEcvSzh6UGRIVHlPdm1keTJ5OFlq?=
 =?utf-8?B?WEtrdU9LRXBoaS9heGpJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZWZkJkb1hMU2lzQ2dwUzd6a1pXNDRDYU5CUXRMeC9PeEtKQW1TQ2lwOU9y?=
 =?utf-8?B?UW1zUmhVVWVMRUJRc3pqWXJsaUZMNlFpNGRmZTVtbnVJMzA4NWhXeHoyZmx1?=
 =?utf-8?B?UVdiVk94NDhpYmpXYmJhcjNJWkhpVXB5V0xnYUNjcXQzNHU3WExyMkEvUTFj?=
 =?utf-8?B?bHVmdlhCNVhMdlUvRENnNXpzUDNoc1kvK0M4cXhTNEh0YlR6eDVVOWh4VFBs?=
 =?utf-8?B?SzhMc25YRkhTZFBLZ0NkR0pXK0N2OFYySVJqME9WZkdRbW01ZXZlM3VQc2R6?=
 =?utf-8?B?VHdBY1NTb1F6T1NxdXpIZnFsaFFBREJwZStDNldNcUlaUzdMU0RuRzNHV211?=
 =?utf-8?B?RFgyYjZxSWJxMXFuQ3ppMXI4cWhiZjFkbUgwNTFoSHlqSWVsa0tMd3g0bFlr?=
 =?utf-8?B?Wlp5WE9EbmVGdFZyeUpWVDJoQmF1Vk41QnhYR1BNbVlYUWRVMWJaKzZOeEFL?=
 =?utf-8?B?azFZU25tdG40NTBvWk1ESytWMlAzM2RUbE1IdUVxUFpoa0pzNUhpMElzdklK?=
 =?utf-8?B?d3YyeDd2QUhyWmFGMW5sRG9FQmNZMG4vcWcrQW5hZ1FiUUw1dXlKeWhsdHZn?=
 =?utf-8?B?TlRPakJnWXN4amt3RzYzdUM1UitQZklubTZwbWdYclNkT21WL04zbitjTXdI?=
 =?utf-8?B?emlOMkNlUnVpcHh0VVdxRGNFa2d5UUJiTkQ4dWJrS25XVjQ4SzZXTjkwMlZT?=
 =?utf-8?B?Zk9JMXNFM0w1bEthUGpZd2xVTXpsQ24yUWxySWV2V3dsZEIxaGErSGlGdCs5?=
 =?utf-8?B?U2ZZb0NIMkNBUUFsak1wKzdvdFZBY3AwK3MxQk9pVng5b1VNcTFFZTdkWGJr?=
 =?utf-8?B?Zm9jZ2N0VTg0TWt0czNyQ25ZenpQczI3V1Jreit1MXZ1czhIUEZlRUFKYkx1?=
 =?utf-8?B?aUpSYTd6SVpIS3RlQndzemhvYlY3M1FmcEJacnVyUGxLQlNOUTIraUcxdXdl?=
 =?utf-8?B?ZFN0L1VmOGhOME9FdzRjclNWRGFCanZ3UDgweWFiNU50S1Q1a2FSNlRIYzBq?=
 =?utf-8?B?aGRCa0hGb3Uyd2ZiZUt2c2RDNEVuYnFodjZNY1RwVHpZbmh0SWtKTGx2RXYy?=
 =?utf-8?B?bzIwNE1TTlVLK2Fqc2FOSlo2TW1GYmhQMTNqYTBnZS9RNkxDejFWeEsyQ3lP?=
 =?utf-8?B?NmJaTnRvT1g4ZHhSQldvUDJqRnNYK2lZclRTSGYydE4zdmhrZFBPVUhFNjNI?=
 =?utf-8?B?QTNQemo4Y2tmMDEyc2E0NWVMc0I1bHpIRkxhWVlVc3ZQMTZHajVqMVZWQWhm?=
 =?utf-8?B?WlIwbldBamIvbGxaYUgyZjhwY1dlSGhGVmFnL2dIOTZHV1A0WWVFc21Db1VW?=
 =?utf-8?B?bndiSHROd2l0U1I4ekxST2djNEZaMGRBMCtxUVFUTDl6ZDdMVU4vR3lYL0c4?=
 =?utf-8?B?a2FEWGZHc0FlMXQvdUxlWlFpcEorclRPWWszeVdtZzVnWER6eUFjSUtXSktC?=
 =?utf-8?B?L2dMZTdJRkhMVjBlQXVIVXJleEVOdExUa2ttTXRYOXgrY0RZeWxMa1VXblVh?=
 =?utf-8?B?dVZyMzduR0w5Y0E0SDJXOStIVFRLTW9OUHYxM1RjYkw0cUtmRkdRNVpoNURQ?=
 =?utf-8?B?TFpncWh6U2xpWXkwajl3ZkFUTm12dnQ3RzFWWE11MmNCbjRwR1BVOU9uVHBu?=
 =?utf-8?B?WUxuTldBUjVYZkVON0VsOGMzbklHQmZLTFp3NVJXOWJxM3NOWnNSZElqVjY0?=
 =?utf-8?B?UFlpWitHSkRrRmxnUTE0a1RmTmhHSjcxcGFPRzB3R1dRTEJ5QlU2V1lqZGVi?=
 =?utf-8?B?MmtYYTBKaTZoSkZHb1FPNGJoTDRjTWpoQytVVUgxUEVHU3BXNEpmeENLZWdO?=
 =?utf-8?B?dUJiL3ZRK0taT1piM0VDNk93UHdNVUJPaUxwaWtuazd4SGJxRmRwMUZrYlJH?=
 =?utf-8?B?VGZmZmFVTVFFd1JlcWlUNjJ4dWdnZitDZjZsTzZBWHJ4alFmSzFHN2t4U0po?=
 =?utf-8?B?VjRsN3duTG1GV2gveThENHVHRmw0QWk5MWFnUGh0bFRYNFZ6RUJUQzZoOXNT?=
 =?utf-8?B?REFRZFZtWVJsQ2tNWXBOekxjcDAxamF4N0RFRTJsQnUrS2xHd1hoQktzVWFG?=
 =?utf-8?B?YTVGNlNqb2ZjazZ6dHlPeGZMUzFiVFpTbnJGL2FKc0hTOE9mSTlsSnpEVEcv?=
 =?utf-8?B?d1NuQlBjQTI2VnlmbUEwZTNCK2k1WmFKbldYOVgrY20rUCtGbjlCaytIeGx2?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8+auMScb7z/tZu7dlq9MXOeRv1aiufZ+W/ggNLw+blYWgvOJiVP6CssjhXn49vjHtPNE9AIcRfE2ZQvYW5pnfhCz0KMDMS4Hoi2TRnO+z6I0pFCSE2iV+8f698BodRKhPRM/nGjVob8n+XocJvjIrNNITZrwZPb+gQA3X/abxa7Fr7qFHEGjQ1z4WgzZAsayTbvVGW8hJidMoqdLrERo8v4keu99yvRMHFxpI3E6IGG/sn0L1kmbJwsFooFyXBhau+VFlj3KES93NICQYOeQAvPpxFcMbfOBlHaP8/Yvt2lttzMEJQmH1RtRkd+zAJQLaQ9UvuK1k87lqwXsNshRWdT01oN3UOR5483wFSq7eM1LaOetut6XuF3A/x9Zmf9MpikuNdVLtKU3pAdY+VO96Z7gq1GVioWiYCmmarvP8RsU4V3jnrfKH9hA5KghwUvC/R719mKsVGwLGXKQ5nZnGwiGMmHQqEig6Kd60MnzukotkJhSmrVDFwoRjrRR0OTRqEa7WdFEgCECILq4HgUVE6s0q2Gk3BHJ1aB7jNYK4i4aA9wpP4gl+M9MjGvoswC1QRSQSeTY3VP7fb6W6nEIW4VLkueWefkIW9C8JXkCqeQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc95d159-565c-4f4d-668d-08dc9f633234
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 15:32:37.5466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59N2/faHWavES1W6fJiG9TqIuATPQRdoAM20LMLPX32hwLH60gOQyUryXQrnMHVidC/rWfz8Tc3+fyHoKx6v1XAdHkukU1T6ISCryDunxk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080115
X-Proofpoint-GUID: 1Qu_Xzh6UNRyj_BbnzolcqWnPW5z8NxK
X-Proofpoint-ORIG-GUID: 1Qu_Xzh6UNRyj_BbnzolcqWnPW5z8NxK
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

On 08/07/2024 16:28, Cédric Le Goater wrote:
> Hello Joao,
> 
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> In preparation to implement auto domains have the attach function
>> return the errno it got during domain attach instead of a bool.
>>
>> -EINVAL is tracked to track domain incompatibilities, and decide whether
>> to create a new IOMMU domain.
> 
> Please leave the return value as a bool unless there is a very
> good reason not to.
> 

Error* doesn't store the errno, and thus I can't actually test the number of
errno to know when to bail to the next hwpt. Maybe the commit message wasn't
clear enough there. But not sure if we have an alternative here? Or maybe Error
does store errno, and I totally missed it.

