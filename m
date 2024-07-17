Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D71C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1M4-0003KS-M8; Wed, 17 Jul 2024 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU1M2-0003Jo-RR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:53:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU1Lz-00044i-Vk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:53:46 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9Zh0l028904;
 Wed, 17 Jul 2024 09:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=lG/SJ325tjRUfW3mel8yT1QNlVb210oynFs6iL6d5FQ=; b=
 CSIVBFoCasFm5D9atn/dz1Ehbk5ThpC7HkbcdB4zsFmt1Zo/PYCBKfI98NdNYNNU
 V7Wpda51pI8p5dwCeV6jQ029lvTVVePn05JxMVoUH/N/Zfbv6+/c6tU7Ppsl1TnI
 Lh0WOgt4rIznnXCuvI1QJy34UF8F5D6Iqdf/fc7EPyNXV6lHyw7MRowiHWKSWr64
 dNqzCiMn/guTt9xpYVhp6grBQAm8IwskKPsFfzWA6tTxB4rvPweU0MlHsgL/Hv9R
 lHtlnj/FGhvMUM01zVOobjz1RhwvofgP9WuOE5IWDhb2y9RwBk0nHkuq8tUtUvDc
 27V1cfmDRQ0m/fkspYVgcg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ebf001bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:53:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H806DO006911; Wed, 17 Jul 2024 09:53:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexbj2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTqKQqiGZb1rGKsK/NQ16fRYPbs8Eyf1HKyLvGN8SoA+LikKh7FW38Yso1UjFKg4Wf1WZu3Jei7DHtH9fm4zQ+eD6A964hH3UZUCMepVuDuTzmdnjwl+ZpgDczO5JepSnBSzzFDtW4cd2Tqd4DSXNQWf5UmR6PHoRLz/4Eprlj2naaF53agsALIF8ShTtqPSkDs9LIhCkFQHam9UdwCXvkL0KB8d3Cqj6Hskoa/gT8q8KlWKbTn8BKzVGTXs8i0ENZHw801NOG92CJOjAm4G38foNs4qaH7WHMyxbVtrCaEm24j8WpLXnLSpQsZgKUoLNElv9luVLHEeSSFsAbFCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG/SJ325tjRUfW3mel8yT1QNlVb210oynFs6iL6d5FQ=;
 b=gIGafE8FCYEqvEpxCnRvWXMO6l5mfPOetF/ngcvp7qXH5U2yORNgw2K0Cl579yENLzP8TiLRqqW87kq5KZFcLbK4q3eAD96rhuV5YAr4qmLqVBvVX/BQpbfqGDt6sfpbODOB8uFHHXbmHcxCaRg2lEYgRCk6u/7Hp8TIOsU7+D6s90mZs5s17S8Ub63tp34Aes7DdBMGK2U+/ZZQ05Ylffcu8OZc5gFR91NTSeOE151N3t/txFSIk+l5tyV2lFg0qYawUkPYLOjD2Vcw/RWn7qg4pbjxK4mEGLKVY4gZYJLjeA4Umzcay3Fsx0DF9pAWLitLinnl+AgJ5ts+dHwS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG/SJ325tjRUfW3mel8yT1QNlVb210oynFs6iL6d5FQ=;
 b=u+60mA9ZoQYc+1qQNjQN6X74gYrZzP0QlThQeK13d4j0DQNarqXAJt+WlM6jvUgv2wUPDqPQki5nk4JnUUyaX+E22vWwdNXdixYdJJpj7A3K6+Qu3qJMuEzCHP27nesB42xcfkIe766B6Y7b9GlqP8qZKQg6xu75OKw+Ws9wM64=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 09:53:35 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 09:53:35 +0000
Message-ID: <835fbcaf-a46f-44cc-8007-703d438db45c@oracle.com>
Date: Wed, 17 Jul 2024 10:53:29 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
 <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
 <a67edbc5-68ce-4967-b8b9-a440904ed1b1@oracle.com>
 <SJ0PR11MB674475CA28136228FE93072A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6ce29c92-d9f8-413d-92f3-8a30e937f746@oracle.com>
 <SJ0PR11MB67441FC5D86A654B695416E192A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67441FC5D86A654B695416E192A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::8) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MN2PR10MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd7f27b-b5e3-46a7-eda2-08dca6465311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2N4eStVWTd3UE40YlM0NWhqckRaeFhuSmhmM2ZsZFlqZEZwaGtZUlYwZ2xm?=
 =?utf-8?B?M3FaRW1XK2Vlc3RwcWRkZklHUWhQU2FsQVpjNitjb3djbnIxT0dBUXo4MlhP?=
 =?utf-8?B?b0ZvdjhpeUV6NmpORHp4a1Z3TVlVT0JxWGNULzhMZGhwYzJMbis5N0YweWFU?=
 =?utf-8?B?RVpUZVZ4azBrQlRpT2xIVm0rUnU3bTk0RUZvK3lZQk9sektJMUFQTmUxOStY?=
 =?utf-8?B?L2lkUm40Wjc4OEs0bys0UGNWTEZyTmxXcTVoYnJYV1paSnpjWUpMSkJRbG9K?=
 =?utf-8?B?Nk9OUlhpek9QMWo1dXBuZDVvZFhxZ1lQbGNkd0pFaXd6SFFTdEw2aXJWelV6?=
 =?utf-8?B?MFpwa0hVMDRENWQzRjZhZHUzKzJpL2lGc0VYNU1nNGp3K0lpOXRrbkY1Tnh1?=
 =?utf-8?B?SE9scDdNazhiYzBOdE11c3ZQNE5qcXVDS2VZVGpTcHJoZnFvbURVUFdGTUgr?=
 =?utf-8?B?YWdEVEZQbzIvRDA0enExcDR3SWd3VWJBWVl2MWFxQlFvaCsyRDV6S05yaDNJ?=
 =?utf-8?B?QjZpd2NzbEN4eStjV0F0Z291b09NMllhR0lkN21UWXkvQWgzRTErWUtOQ0Zk?=
 =?utf-8?B?OUJtbzFybnZ0ZEYzVTV1aFF1bEZuN2tLdWtXYkVrK1RxN0Y5VS8vWTVSZ2FQ?=
 =?utf-8?B?SVJsVlFYSTlON3owRGVCNm5INEtUS0h2Q2VGRG5EUUdoVElickJTRFI1WWJW?=
 =?utf-8?B?YUZRWlRvUXJzVzhHNFVsbXluRkJPY1ZVV0dzOVVoVDdnQlEvY0ZhTG1lOHp0?=
 =?utf-8?B?N0ZrcjhHTDdVWXRXY0JxdHlya1JyalJmZzFKQ01xakV6NXQycnd6VlhOTWVz?=
 =?utf-8?B?TkNSZGh3cklsRi9HZkJsWTVCd1E3MFNzLytYQVNNUWJDdEZtdS9BR3c3ano0?=
 =?utf-8?B?NTFGZFJiTk9PY3NGekwzNVhRTUd0T2JmdjFPcWVjM1JIaTBVeEhWeFJlczNk?=
 =?utf-8?B?VjQ5VTM3Z0ZGTUhIeFFoUWZyT3RnOWkxV09ZRWp3c3A5Q0tqdUsyT1BGM09T?=
 =?utf-8?B?RzR1Z2JCdHZoVVBqcm92d1RtRk9xa0xlQWZCM1ZFWGFsb2dQTTFGQzJ6QVBI?=
 =?utf-8?B?YUY1cXc1U09NYU51K1FPcHFtYWJWZFpvMmovRUp4aVdvdjhpRzV2dnNCL3Ba?=
 =?utf-8?B?QjhiYTBtN2hNV25VWnZmaHF5T2FMVGJyc0wrUW9VaWtsMXBJWUVuK1BJRkdn?=
 =?utf-8?B?RHFLRVJNUERZSHdKbTFCR3k1QjNNWGhTaTJXbDF2cWM5SFVqQ1dtRit1ckY4?=
 =?utf-8?B?WHV6dll4aXBqbHFmclBGRzVOOTV2RVhWazcvQnN3TEprellMZE82VGNOampj?=
 =?utf-8?B?bzRoS1JuTTY2T2JkVXVtWDlZR3JBeHVXbVNpWElRQmhxRXhDNEFWMUFOY0R0?=
 =?utf-8?B?RVM0SWluMzYyTHZvcTg2Q3J3Yzk0VVN4L1ZqRmlpeW5qMXhDWlR6QW5XR3Zw?=
 =?utf-8?B?KytUcVlUb1dWRmNPQ2tiekx6dkVYT3gzUDllWTM4V0QzZzJ0SHllVG1BWTJk?=
 =?utf-8?B?ZWp3RmptRWFJQ2QycEVibzZTWjBZVG0rUWFqWmcxa0k5UW42K0ZUMjhQY1Rp?=
 =?utf-8?B?THZlbGNVWUd5M0NJdnZSWWtQVithN3JkaEkwYkk2RzN5eUlZU1ZsUHVrU2Jp?=
 =?utf-8?B?bEx4b1d6NzRrNkpqZDFKcFIvMnk5dXZMeVM1bkNpdElyaG9JK3lFaGo1aTRR?=
 =?utf-8?B?aFA4RGt4di80OW9EYVJDalRiZ00xdDRBWDViOVRRaXdJWFExWE1IMW9haFlJ?=
 =?utf-8?B?Q25mTHdhVUVQZDNZU3BiQmRKWFpIbnE1TElON0F5VVpWTzdJNy9VMTJPTzY1?=
 =?utf-8?B?Vm1zZVpnekZLYUpOMSt4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NqTThHWlk4cGFJajJQVkpRaTZqMHlFOWdMb2VBS21yM1RUOEFpUGRmNEJ6?=
 =?utf-8?B?clhueTQ2MnhaOFE0dEVSQ0VlcW5vazF6Qkd0NHJRemlzNmhaRGo3ei9iajRr?=
 =?utf-8?B?Q0dCTzE2dEp0SEMyTTJOZ2VoVUNvQjJsQzczUGtKeWFaZW9ydFlhMUJlTndR?=
 =?utf-8?B?ZGJxUVNNSmRDdlVIemRPY21kYmZzaXg1MVlHQXplNHZ1RGx3M1hOSGRkbmdV?=
 =?utf-8?B?ZEMwbGRtKzBHVXNON0RSb0lVTVJzdEJqYjFrOWUwUzNydUkxS3crT2RHbElo?=
 =?utf-8?B?RDgzdXBIUzd4dGlwSkd5UytFQXB1NUtCQWp6a1VhRVFWc2JjZVlINDRJbmpX?=
 =?utf-8?B?SUlSY0x5andoeEtGeExIWWQ5TFNZVU9CajVMb0dMN1N5SEZRVUdLRzBQWktl?=
 =?utf-8?B?NjNiWnhJeWU5QWJobmdCQXBJNzAwcXJka2NYQUVyV01YaE1yb00xWWxDdVh2?=
 =?utf-8?B?SUVvdFYveHNsNTBYTmI4ZG9RKzFVNldDZ3hRNFlsOXJJcFlXRnRySlEzNDgw?=
 =?utf-8?B?ZUduT1VGRHFHOHVqb1dDQ3BPUDFNZGd0azJjNUR1UWg3M1NGQUdwMG44dEtK?=
 =?utf-8?B?bHRLWWxENHBUeWR6eVNHdGhQOU5mNEZ1ZFpObmVYTCtqNm8vK1dYbVZ3RU0x?=
 =?utf-8?B?bWtNeEJyS1krNWU3OWNPUmEzNVRMVGZPdXlGL1kvZThZZXdTZ0VNWEtFK1ZO?=
 =?utf-8?B?SG5MOFo2dWMyYkQzOEdMSy9lbHNSQ0FFZllqcEg2V1hOZWhVdGQ4OUlVUmEw?=
 =?utf-8?B?OWk1QnR1bktuclY4WUU0cCtNYU5xNUswM2RzVkpCdEptVFVlczZpUnFjN3k1?=
 =?utf-8?B?eDdIMWd0QWR3WndnVTZ5aVg1d1JTN25peW9NUlVKckI5Y0RsZmVDUzJnWlUw?=
 =?utf-8?B?M0o2UzI1YTg5ZUxsV0VTQTZpZjhMYmo3NXdrQjVBaEE4dUJiVCtmUytLTFEx?=
 =?utf-8?B?ckIyTlJWWlhMbmVBdFVGQ1JaNFM4NEo5b3Eva2R2NHprd0ROS2NacXNWVWd0?=
 =?utf-8?B?NlZjTEFnb0VEeGNyNERSZVg3b2NVQms5dGRwdnFzcGRaa1FKWE5VQUllallk?=
 =?utf-8?B?T04xRnlMcmhPTnJldzNlaDdkU1U0WVBCd1VhL21pWjUyS0kveSsxMWtGSW9k?=
 =?utf-8?B?TWx6bmhaWnVOMm44WWMyQXo3b2Z2TTdOaVFFZ1JYQjF2dkdPUUhZTEl0QWZM?=
 =?utf-8?B?ZnJHaHUvR0UzUFl0enVPaFN2eHFGTWtORUVqTnFYNlZWYjlReXJSZjJmKzIv?=
 =?utf-8?B?RjJNMzhWcmhtMmphR3ZxRURpbWVHeFhhcVhTY2FBbk1EVTQ5VU5hdWNwekM5?=
 =?utf-8?B?Wkx4UmlxdkkzY1VzK3pYQlNYUjh0R2MvencvcXQ1clpwb1Z2U1NBR0JreXUw?=
 =?utf-8?B?bTh2QzE5ZDJNWjlPU1NmZmM4WjE1ZFIwRzQ5aEtkN3oyd3M1L0xNYlpKZkxD?=
 =?utf-8?B?YXBDOHVwMDRIVHMwTm11ZG9Ea09ncXR2NHlpUjNGRVh4dlp0eFhRRDl1Y2I4?=
 =?utf-8?B?d1dFMnNFcmxlc0trcDJoaFhVTVgyd3h6QjJxR0ZGZ0pSbk1uMG1DTEwvV1hT?=
 =?utf-8?B?VEl6WHBXaHlsaUQ3cFQzK1ZGeVh0bittSmoxTEh3NnBEN2ZoaWR2empQMEQw?=
 =?utf-8?B?WFp2ZGEyTmRGcVRnRWpBUGY1RFJITG85c0Q2aCtHTDl3VFJaWWdZLzJGS0o2?=
 =?utf-8?B?dVZveXJkVENGTnFoODlRanlZTWJjWDRDMEhHQThQZEp3Y0ZuVFI1WDR2NGx4?=
 =?utf-8?B?T0h4b2xidExwMnVEMFhwdm12QUhOSWw3bmV3b2pMSGQwVzRUYW9ESDg3dEIz?=
 =?utf-8?B?eTJrZW8xVjJtMXBGZnFlSW84Q0RqQVVaQVpXTHdXV0pIUDFjMUJFWXhrYXRu?=
 =?utf-8?B?QW5CZ3NrdFRJcURCSEFlWUwyanpkOWwyckkzOW1hVmNFTkVFU3BlWjNhU1My?=
 =?utf-8?B?VjhEeWMyeFhCcGh1QlBKK1c2YmN6ZUU0Z3phazVmcnlwV0FSYWVyelEwT0o2?=
 =?utf-8?B?NG1Ka2dDc0NpVlZBYXBFRnlWd2RjSlRoOUQvbkwwQlljeGlPNjA4QmtCQmFl?=
 =?utf-8?B?b054UkRObXJjZmVLTTV6MWFWOFlrUHZpbjFveVYwczZTYldoQXN1ZTVSWmdC?=
 =?utf-8?B?WXozSVlwSU9YeGppOTMrM0YvYWI0Q2Q3T2VuU0dxSUFNUjg5ckJic1IwZkJC?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6qXtNeCCRIn05PMpST8FimzyfVQ+uwe+OGRr7K73I4Wddum7dYs7NBcLg4EyedSHiA4aLxzR/l4MVeEucbz3rQjwywfewmRw1Xxgh5SJ4ZTBp8lq9+KRStO3Czsqqx5xaGAZPCxJCw+Kq1KomiIAZ0bnATB47gQ+1O6q9biYMZkUjL8iQb3jOOYJL2wLrlSLlkrB77t+VR9BuH9xnV7Nk3UaIeVUpwsjTesthCcFxKLF7NQ6YxZMp4lTMaN/SMtl/RUwg0EH+jCud8pkcFMX32D/cipHFzquqoRxIIhufQ1Y0+0Psom86UmAAgJoZM44iuxOxZ4589HrutoLQYYfdlCR58TtoDMS7Hb1Dqd4hXVY4EufgvF5KGh8F42FjSGA37tILP1EJeCkxGDwh0iwN62BHuLiVOrqlQMCW2APydDCaSKMRojSpQH73XtidvNwCc4f0avYMnB3FH39AJKodvkoDUAjbwDjy25bRZoYMS1d1tn1S2ViTWOH4jHGQ9PNLJmvjtDvy7vuaRMY7AGpXhlNpFqmMl4pSBMVeD/IBto8xY13VP8gdXuTerAZlOcyREv0RgFyoPK+4N5V9cKvZfb40DIhZm2yHCdXgvZU6R8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd7f27b-b5e3-46a7-eda2-08dca6465311
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:53:35.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC6AcORR0PPKAOQPpxVo5pY2Yl6SjOfiRTu91AWrxQwvlujC/eunPVhDOm3IgjXRgEDnync1j377u85F7i7l7Q2mhbSJG1ZTNYMLGhJWu94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170076
X-Proofpoint-ORIG-GUID: wNMC-uVOYXLs7In2tfZZFnzNY7FPCcQr
X-Proofpoint-GUID: wNMC-uVOYXLs7In2tfZZFnzNY7FPCcQr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/07/2024 10:48, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain
>> creation
>>
>> On 17/07/2024 03:52, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain
>>>> creation
>>>>
>>>> On 16/07/2024 17:44, Joao Martins wrote:
>>>>> On 16/07/2024 17:04, Eric Auger wrote:
>>>>>> Hi Joao,
>>>>>>
>>>>>> On 7/12/24 13:46, Joao Martins wrote:
>>>>>>> There's generally two modes of operation for IOMMUFD:
>>>>>>>
>>>>>>> * The simple user API which intends to perform relatively simple
>> things
>>>>>>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to
>> VFIO
>>>>>>
>>>>>> It generally creates? can you explicit what is "it"
>>>>>>
>>>>> 'It' here refers to the process/API-user
>>>>>
>>>>>> I am confused by this automatic terminology again (not your fault). the
>>>> doc says:
>>>>>> "
>>>>>>
>>>>>>   *
>>>>>>
>>>>>>     Automatic domain - refers to an iommu domain created
>> automatically
>>>>>>     when attaching a device to an IOAS object. This is compatible to the
>>>>>>     semantics of VFIO type1.
>>>>>>
>>>>>>   *
>>>>>>
>>>>>>     Manual domain - refers to an iommu domain designated by the user
>> as
>>>>>>     the target pagetable to be attached to by a device. Though currently
>>>>>>     there are no uAPIs to directly create such domain, the datastructure
>>>>>>     and algorithms are ready for handling that use case.
>>>>>>
>>>>>> "
>>>>>>
>>>>>>
>>>>>> in 1) the device is attached to the ioas id (using the auto domain if I am
>>>> not wrong)
>>>>>> Here you attach to an hwpt id. Isn't it a manual domain?
>>>>>>
>>>>>
>>>>> Correct.
>>>>>
>>>>> The 'auto domains' generally refers to the kernel-equivalent own
>>>> automatic
>>>>> attaching to a new pagetable.
>>>>>
>>>>> Here I call 'auto domains' in the userspace version too because we are
>>>> doing the
>>>>> exact same but from userspace, using the manual API in IOMMUFD.
>>>>>
>>>>>>> and mainly performs IOAS_MAP and UNMAP.
>>>>>>>
>>>>>>> * The native IOMMUFD API where you have fine grained control of
>> the
>>>>>>> IOMMU domain and model it accordingly. This is where most new
>>>> feature
>>>>>>> are being steered to.
>>>>>>>
>>>>>>> For dirty tracking 2) is required, as it needs to ensure that
>>>>>>> the stage-2/parent IOMMU domain will only attach devices
>>>>>>> that support dirty tracking (so far it is all homogeneous in x86, likely
>>>>>>> not the case for smmuv3). Such invariant on dirty tracking provides a
>>>>>>> useful guarantee to VMMs that will refuse incompatible device
>>>>>>> attachments for IOMMU domains.
>>>>>>>
>>>>>>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>>>>>>> responsible for creating an IOMMU domain. This is contrast to the
>>>>>>> 'simple API' where the IOMMU domain is created by IOMMUFD
>>>> automatically
>>>>>>> when it attaches to VFIO (usually referred as autodomains) but it has
>>>>>>> the needed handling for mdevs.
>>>>>>>
>>>>>>> To support dirty tracking with the advanced IOMMUFD API, it needs
>>>>>>> similar logic, where IOMMU domains are created and devices
>> attached
>>>> to
>>>>>>> compatible domains. Essentially mimmicing kernel
>>>>>>> iommufd_device_auto_get_domain(). With mdevs given there's no
>>>> IOMMU domain
>>>>>>> it falls back to IOAS attach.
>>>>>>>
>>>>>>> The auto domain logic allows different IOMMU domains to be created
>>>> when
>>>>>>> DMA dirty tracking is not desired (and VF can provide it), and others
>>>> where
>>>>>>> it is. Here is not used in this way here given how VFIODevice
>> migration
>>>>>>
>>>>>> Here is not used in this way here ?
>>>>>>
>>>>>
>>>>> I meant, 'Here it is not used in this way given (...)'
>>>>>
>>>>>>> state is initialized after the device attachment. But such mixed mode
>> of
>>>>>>> IOMMU dirty tracking + device dirty tracking is an improvement that
>>>> can
>>>>>>> be added on. Keep the 'all of nothing' of type1 approach that we have
>>>>>>> been using so far between container vs device dirty tracking.
>>>>>>>
>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>> ---
>>>>>>>  include/hw/vfio/vfio-common.h |  9 ++++
>>>>>>>  include/sysemu/iommufd.h      |  5 +++
>>>>>>>  backends/iommufd.c            | 30 +++++++++++++
>>>>>>>  hw/vfio/iommufd.c             | 82
>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>  backends/trace-events         |  1 +
>>>>>>>  5 files changed, 127 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>>> common.h
>>>>>>> index 7419466bca92..2dd468ce3c02 100644
>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>>>>>>
>>>>>>>  typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>>>>>
>>>>>>> +typedef struct VFIOIOASHwpt {
>>>>>>> +    uint32_t hwpt_id;
>>>>>>> +    QLIST_HEAD(, VFIODevice) device_list;
>>>>>>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>>>>>>> +} VFIOIOASHwpt;
>>>>>>> +
>>>>>>>  typedef struct VFIOIOMMUFDContainer {
>>>>>>>      VFIOContainerBase bcontainer;
>>>>>>>      IOMMUFDBackend *be;
>>>>>>>      uint32_t ioas_id;
>>>>>>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>>>>  } VFIOIOMMUFDContainer;
>>>>>>>
>>>>>>>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>>>> VFIO_IOMMU_IOMMUFD);
>>>>>>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>>>>>>      HostIOMMUDevice *hiod;
>>>>>>>      int devid;
>>>>>>>      IOMMUFDBackend *iommufd;
>>>>>>> +    VFIOIOASHwpt *hwpt;
>>>>>>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>>>>>>  } VFIODevice;
>>>>>>>
>>>>>>>  struct VFIODeviceOps {
>>>>>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>>>>>> index 57d502a1c79a..e917e7591d05 100644
>>>>>>> --- a/include/sysemu/iommufd.h
>>>>>>> +++ b/include/sysemu/iommufd.h
>>>>>>> @@ -50,6 +50,11 @@ int
>>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t
>> ioas_id,
>>>>>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>>>> uint32_t devid,
>>>>>>>                                       uint32_t *type, void *data, uint32_t len,
>>>>>>>                                       uint64_t *caps, Error **errp);
>>>>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be,
>> uint32_t
>>>> dev_id,
>>>>>>> +                                uint32_t pt_id, uint32_t flags,
>>>>>>> +                                uint32_t data_type, uint32_t data_len,
>>>>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>>>>> +                                Error **errp);
>>>>>>>
>>>>>>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>>>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>>>>>  #endif
>>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>>> index 2b3d51af26d2..5d3dfa917415 100644
>>>>>>> --- a/backends/iommufd.c
>>>>>>> +++ b/backends/iommufd.c
>>>>>>> @@ -208,6 +208,36 @@ int
>>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t
>> ioas_id,
>>>>>>>      return ret;
>>>>>>>  }
>>>>>>>
>>>>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be,
>> uint32_t
>>>> dev_id,
>>>>>>> +                                uint32_t pt_id, uint32_t flags,
>>>>>>> +                                uint32_t data_type, uint32_t data_len,
>>>>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>>>>> +                                Error **errp)
>>>>>>> +{
>>>>>>> +    int ret, fd = be->fd;
>>>>>>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>>>>>>> +        .size = sizeof(struct iommu_hwpt_alloc),
>>>>>>> +        .flags = flags,
>>>>>>> +        .dev_id = dev_id,
>>>>>>> +        .pt_id = pt_id,
>>>>>>> +        .data_type = data_type,
>>>>>>> +        .data_len = data_len,
>>>>>>> +        .data_uptr = (uint64_t)data_ptr,
>>>>>>> +    };
>>>>>>> +
>>>>>>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>>>>>>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags,
>>>> data_type,
>>>>>>> +                                     data_len, (uint64_t)data_ptr,
>>>>>>> +                                     alloc_hwpt.out_hwpt_id, ret);
>>>>>>> +    if (ret) {
>>>>>>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>>>>>>> +        return false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>>>>>>> +    return true;
>>>>>>> +}
>>>>>>> +
>>>>>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>>>> uint32_t devid,
>>>>>>>                                       uint32_t *type, void *data, uint32_t len,
>>>>>>>                                       uint64_t *caps, Error **errp)
>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>> index 077dea8f1b64..325c7598d5a1 100644
>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>> @@ -212,10 +212,86 @@ static bool
>>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>>>>>      return true;
>>>>>>>  }
>>>>>>>
>>>>>>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>>>> +                                         VFIOIOMMUFDContainer *container,
>>>>>>> +                                         Error **errp)
>>>>>>> +{
>>>>>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>>>>>> +    uint32_t flags = 0;
>>>>>>> +    VFIOIOASHwpt *hwpt;
>>>>>>> +    uint32_t hwpt_id;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    /* Try to find a domain */
>>>>>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>>>>>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt-
>>> hwpt_id,
>>>> errp);
>>>>>>> +        if (ret) {
>>>>>>> +            /* -EINVAL means the domain is incompatible with the device.
>>>> */
>>>>>>> +            if (ret == -EINVAL) {
>>>>>>> +                /*
>>>>>>> +                 * It is an expected failure and it just means we will try
>>>>>>> +                 * another domain, or create one if no existing compatible
>>>>>>> +                 * domain is found. Hence why the error is discarded below.
>>>>>>> +                 */
>>>>>>> +                error_free(*errp);
>>>>>>> +                *errp = NULL;
>>>>>>> +                continue;
>>>>>>> +            }
>>>>>>> +
>>>>>>> +            return false;
>>>>>>> +        } else {
>>>>>>> +            vbasedev->hwpt = hwpt;
>>>>>>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev,
>> hwpt_next);
>>>>>>> +            return true;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>>>> +                                    container->ioas_id, flags,
>>>>>>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>>>>>>> +                                    &hwpt_id, errp)) {
>>>>>>> +        return false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    hwpt = g_malloc0(sizeof(*hwpt));
>>>>>>> +    hwpt->hwpt_id = hwpt_id;
>>>>>>> +    QLIST_INIT(&hwpt->device_list);
>>>>>>> +
>>>>>>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt-
>>> hwpt_id,
>>>> errp);
>>>>>>> +    if (ret) {
>>>>>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>>>>>> +        g_free(hwpt);
>>>>>>> +        return false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    vbasedev->hwpt = hwpt;
>>>>>>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>>>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>>>>>> +    return true;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>>>>>>> +                                         VFIOIOMMUFDContainer *container)
>>>>>>> +{
>>>>>>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>>>>>>> +
>>>>>>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>>>>>> don't you want to reset vbasedev->hwpt = NULL too?
>>>>>>
>>>>> Yeap, Thanks for catching that
>>>>>
>>>>>>
>>>>>>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>>>>>>> +        QLIST_REMOVE(hwpt, next);
>>>>>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>>>>>> +        g_free(hwpt);
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>>  static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>>>>>>                                            VFIOIOMMUFDContainer *container,
>>>>>>>                                            Error **errp)
>>>>>>>  {
>>>>>>> +    /* mdevs aren't physical devices and will fail with auto domains
>> */
>>>>>>> +    if (!vbasedev->mdev) {
>>>>>>> +        return iommufd_cdev_autodomains_get(vbasedev, container,
>>>> errp);
>>>>>>> +    }
>>>>>>> +
>>>>>>>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container-
>>>>> ioas_id, errp);
>>>>>>>  }
>>>>>>>
>>>>>>> @@ -224,6 +300,11 @@ static void
>>>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>>>>>  {
>>>>>>>      Error *err = NULL;
>>>>>>>
>>>>>>> +    if (vbasedev->hwpt) {
>>>>>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>>>>>> +        return;
>>>>>> Where do we detach the device from the hwpt?
>>>>>>
>>>>> In iommufd_backend_free_id() for auto domains
>>>>>
>>>>
>>>> to clarify here I meant *userspace* auto domains
>>>>
>>>> *kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT
>>>
>>> If the device is still attached to the hwpt, will iommufd_backend_free_id()
>> succeed?
>>> Have you tried the hot unplug?
>>>
>>
>> I have but I didn't see any errors. But I will check again for v5 as it could
>> also be my oversight.
>>
>> I was thinking about Eric's remark overnight and I think what I am doing is
>> not
>> correct regardless of the above.
>>
>> I should be calling DETACH_IOMMUFD_PT pairing with
>> ATTACH_IOMMUFD_PT, and the
>> iommufd_backend_free_id() is to drop the final reference pairing with
>> alloc_hwpt() when the device list is empty i.e. when there's no more devices
>> in
>> that vdev::hwpt.
>>
>> DETACH_IOMMUFD_PT decrement the hwpt refcount and it doesn't
>> differentiate
>> between auto domains vs manual domains.
> 
> Yes, missing DETACH_IOMMUFD_PT so ref count isn't decreased.
> My understanding is freeing hwpt will fails become device is still attached, such as return -EBUSY,
> But may be I understand wrong as you didn't see that failure.
> 

I recall exercising *hotunplug/hotplug* that working it out, but the error
likely could go silent as it doesn't does fail higher levels. So part of the
reason that although it seemed to work it might be my oversight in seeing that
the errno was returned from free id operation.


