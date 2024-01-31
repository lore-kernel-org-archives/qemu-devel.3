Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B167AC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVC71-0005tm-4f; Wed, 31 Jan 2024 10:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVC6o-0005pa-Ka
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:02:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVC6W-0002jK-Ng
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:02:30 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VEwq3j005475; Wed, 31 Jan 2024 15:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=APiJ5xnwS0W0NmoJ1J0/Bq1qWxGZOIGk1zTwyJH8FFA=;
 b=jyWlqvzvFIE9UIQMVmQ5fHZAjohIaO9MriqjimtChvjMueRiXqLzQ+8dYajsm6I8NNXS
 iD/vYVwf3xd7YV1JXxsDJbq93kF6XCKD2fBOlNq2SY8VVilhyj4tPK2fJm4ewYlLuDNo
 6bF685XZfw3NI8VuZx5ErT1/glIVr/IeREFjXFlC3eQ7wJsYp/EMkQ4o8we2Y/nTs5Nk
 UcEGZPTQ3u4zg/+oi7SmRqJjUwY1UIR4qLZEpPmTRuLMljAuEGRV+xAVIepRmmxk2iL/
 DwKhAWtiXKf+g9veCsH7bYbp6B7raPchjSejQRkQ7zyhUG2BoAbTtfQkOt82TJNQjQEZ xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdt1fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 15:02:15 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40VE8co4005325; Wed, 31 Jan 2024 15:02:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9exm5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 15:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA9Rn7tkbSpNzAmJjE2IUxlWrmzaKH1i2La2B55jyRrHwUPvJmsFjrmIRRgn+PePrOs7Ra6rQ2iZghCemhHqYMZmUpNuFe60lLMP8bqZJw2w/uoUpKgBfO3szOoGcyI6k1zcuNaUeM0QXpOcKc7Lx3DUdMYjs1KpmM59HRUv8JdHIcYzv9AvwCuNaVI4N/UW9BFPKZsCw0Ua3hMUm1zxSwHOiOmt54VVPwTJswKC3uHcBrDFqN9UIQTQ46LfZwH+BN7xVkK6DCXEuxluY0iLNkdtH0Gd/tuwaED0mOQAENm3BtsPlRMSIHRCPDZ8iWjqyuYEHERIU+DO4onywIiboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APiJ5xnwS0W0NmoJ1J0/Bq1qWxGZOIGk1zTwyJH8FFA=;
 b=XBsiHNXWPn2hw5N1Sy7oBBEEgl7+kDgwdWDbSgzGtS2cQ+b5mXYO+y2j51IjhnshEiuEW0bMzkV+vmbCNnZeEPlP5JtpB6ialJSUY2nOE3qB1JJE2KAlXo4CTuKL4KBLg8EwN0aseqcM27mRGoS8OkinK2Zc4dEOzKM8M6/RyO9FAbCcNhAu6ccUn7r1KsOa1Ei3EA+RsNB/HEeS1bd06AQWrj84XHp9zSiTUK86bIrjzJcHUXBj06xP5eUcfG5JQ0dw6HLq3wEnQbW2D0xHxqJSJXMJuC2fBQq7hE4adGG/HbatJDVIClEC0HHRwC0oPL5sokvMa9WadRULiv9dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APiJ5xnwS0W0NmoJ1J0/Bq1qWxGZOIGk1zTwyJH8FFA=;
 b=mKT8u1qfXzE1q3//kUZXVosPpsLiRMzys+BFi+MtGHDLvd5n4LsTfmyMSDbc/u/ePmCobj/TiuytGg8x2WxDbqubVO0A+gC5/HcEFd+jwzFVvjFLmn4U3obt9bdz5Vl/1RNzygWPqmqVw0BvQATBmIwQzZhmFI2k9v48vlEwTTs=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 15:02:12 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%7]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 15:02:12 +0000
Message-ID: <e54455cc-d702-4ab0-90aa-5035708322bb@oracle.com>
Date: Wed, 31 Jan 2024 09:02:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] oslib-posix: initialize backend memory objects in
 parallel
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131134843.3074922-1-mark.kanda@oracle.com>
 <20240131134843.3074922-2-mark.kanda@oracle.com>
 <46fc0732-8735-4440-b14a-13e2389d7d6c@redhat.com>
 <578395fd-9538-4d3d-85ea-f5e9b95b8bd7@oracle.com>
 <7686daa5-c175-4b2c-a6ad-72d3c78b2249@redhat.com>
 <6a5773e2-6887-4cd6-995a-209affd71b74@oracle.com>
 <00584dd7-f89f-4595-903b-54fbff260983@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <00584dd7-f89f-4595-903b-54fbff260983@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|CH0PR10MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd398c1-be27-4e94-364a-08dc226d9afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRY/T10OG/ZnWpuFmJ6M3VOjRNkUZN9X/DFWHB5zajO5I6Gg6NmjvvwasUpgYwl7LdpDny4gqVlMsNntxTsV3XAJC2+J9riA+ixYQ8VrkjyWsnvfiaqycVzF/lOs3F86tni3JbEA/wwP0YarzfRSkvngmA5yrzPDNp+Z/mWQk2jndhszsbo+wmiY0jrddNiF9PrZiiO+C+Bpght/x6XoEkyMOAeTu8pRHXAUCNOFtvv4GlzXxX5/FR4So1PDyNDc8O/USXXUoD7dpApB2he/lcPDU1ciqNPBxjXgI1ZjiRm+P9+3w0KHIskXhP+mAnju3MlJssuqy8nM/ghNr07Xi4zW3kYVYVIwIFEjC8/ftjEfVPHJTeQCfU0iKDhemp7r6+kNYHcxqV1tqPnXjUizOG9EYEsLFBkFBKnhGaJwzsTgCYnsjWJIysfofVvTQdsHb6nHvvRd25BdGYZIs2bd3uqBXil2HVfVOKMQ1hiHUGGTo21p2Bdu+gjNRlLHwYnX13echrwITZ8c2czTaVIHdUWqtXJv1b3YqNC1lJRQEuHdMqSlRkM3li89/8KK/qkCiUon7TFrZBRvVhGIjT8ZEVs3bmlP12+6f3iwB6bCCDieUhbLaSJrK3ZSXcfsVkvDDVCeBPEFmfdmSZ1fkGxLPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(36756003)(31696002)(86362001)(38100700002)(2616005)(26005)(6512007)(6506007)(6486002)(2906002)(478600001)(53546011)(66946007)(316002)(6666004)(66556008)(66476007)(44832011)(4326008)(5660300002)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGFLZXpvMkFkK3RoWFdzc0xQemxscGhKZyt4cXM0TWM1M2JZemxBK0hQK0lD?=
 =?utf-8?B?K0pLcVQxMXdCYmNKbVI0WXdUQ3VaVG9GWXhoR2w4cVVzK0tmei82SmF5cTl5?=
 =?utf-8?B?QmpLekZNbXpOMFAvWWhXc2FBQTRCRUI4WEtvQ3dtZTg3Q3ZEY29Xb1dvckVu?=
 =?utf-8?B?R1hmcGhoS1VBZG5zN1lSaGhCOW5EQ1VKWWJpdUF6ZzJHTWozVVc0TzJ4d0lN?=
 =?utf-8?B?UHJvMTd3eDYvanl4SVlJSHdrUUpIbFRMbXZLTjZZeHNWb0V6U3NIRTcyQ1p6?=
 =?utf-8?B?azZwaDlYaDQ0K0oyUXZiQWJzaWlGa0RmMHc2Wm5iQTl3bDFySlZLM2dSYjhw?=
 =?utf-8?B?Z0EyR3JPTUZxb2dROTVyaW9iOVd1Q2d5L3ptZXE0VFBmRHo4b2IwaFFKdDha?=
 =?utf-8?B?TVJQQnFqQ05rZjJUVzJKaGl1V0N5d2FiUTRpV2ZiNzZzRWh1VklFZE5xczFu?=
 =?utf-8?B?VmNBaTUyQkxEQnQwU1JRZm9MSWFMRDgyTFkrdTVDbzl3YkNwbG5OLzJ4YVJ1?=
 =?utf-8?B?dmNmdnA5MVJkZnJoYzJLc0d3VElwYVI0ek1iS2pYZkJoRVQwbFR5YlNWcVZR?=
 =?utf-8?B?OFRwOEh0MWhNTytjVzZyZjFzbHhIODF3b3VpM0hHUFBhdldKTFlqcVltc1dj?=
 =?utf-8?B?NDdKZlRhWHFCc0ZZdm0xeVo2YWk0UHFCalE3V2lqWVg5WTlCdjdkNkZyZEx6?=
 =?utf-8?B?b2djWTNLcGFZcGwyYnB6aFpuQmk4ZWVpTmlUMytIMWYyTTRRTmtoOUdVVTNO?=
 =?utf-8?B?YXVoRUJiMExPTHFxQm5JUCtqYWwvNEdnVjFCb3RQQ0MzYittRzlXejY1WXJZ?=
 =?utf-8?B?RFdubXhneXRTa2pYN2VWcnd6Qy9WWi9Ndzd1UFVOQ2ZJMGZLcm41WUxXaThq?=
 =?utf-8?B?UGlLOThSM0VJblpiRWtJSkdGY1VVYWViRktKanlCK2tpNmZTSDUxQmxRZkR3?=
 =?utf-8?B?Y2hlQ0VzMzcwWFNJeWc0M0VLRE4ydStGQ3YzbTFBcEZhUks5UXhuTHJUTStj?=
 =?utf-8?B?aElxY3k2K2gzQXgxVHo1MnhIYXNLNlVDT1Y0R3RmZVFlWmpqVEYyMUpVckdp?=
 =?utf-8?B?VzU1UVFqY0dZL1dSUzM3ZnoxeTMrdVR1LzZGcmJEODhMWEw3eHd4SHFIRW5Y?=
 =?utf-8?B?ZENzbG5vRzRVWXlGalN1NjJOVC95ekw5K01yWVNGbWM4SXhsWXVkMUQxaE9L?=
 =?utf-8?B?NEQrY1FPdE5MY1NmZXBHRm5MbkxicnRJM3pqaXdoUzAvVWhWTFJudVBPcVhJ?=
 =?utf-8?B?R3JVM0xya2R3UHNrNnYrcTFlSFVWZ1BHVTRpZlJNdFhCUExVenM3MXpUcnp0?=
 =?utf-8?B?SzFGK0NuMDJpOG93cnpmTmt3bU5samdyaktGTEtHK1o1VVpnNFgyR3BLRkt5?=
 =?utf-8?B?NGkrbWwzQ3FDQjY1NVlqSEU5M3RkR3puMGZROEdldXVldUpqbjh6alk3aCtt?=
 =?utf-8?B?ZW9JUzFKaWpmeWxCNEFBdDQ1YWtqNFlOeTRQT0hZaElPeDFRdjdjdEo3TjVn?=
 =?utf-8?B?VGRBNk5qMVE0TDhob2RSR0pCQnlaYlRObk9PZHpPQ05LaEV1Njk5OC9lOVFH?=
 =?utf-8?B?b0k5QXg3YW1URm5nTlVnOU80Z2VrQWtSRmUxMkdZN0JhOUZXWDR4S2NpVHhW?=
 =?utf-8?B?dkJTREYwTzJMS2Y4RUpPNzR4L0kwNEkxMmNScXVxQ3NuTDZkUmZNcmM2V0M4?=
 =?utf-8?B?RkF4WU15aTVQWk1tVjg5ZVRrSUF2M1d1Vnphb3p3SEdNYkZDNkVuZ0dzT1JL?=
 =?utf-8?B?YS9naGQ5b3dkU0dpQ1lCTzNnckw4M2JlM1BVa3Z1M1dBRW9lTXcxa25rUUov?=
 =?utf-8?B?SWFyV21LZVdxWlpEaENLeFB5STBQbXRFdFoyeXBCcm1OSEk2S1VmeitNUEtD?=
 =?utf-8?B?ck9GZEw3SUFKa2JXdEhKbHM5ekRHM2lIS2grRVhja0dDYWZQQWx5U3duYiti?=
 =?utf-8?B?UFE1YTQ0MFlqUE9mZjJmZk9Jb1JQQzZVbyt5c0VMamp0dis2T0cxTDRGNEli?=
 =?utf-8?B?QU8yNGF3d2tWTlc4c2RaOTJRSE8rbGo0T3JDa1JzVlozYWR5clQ4S2sxS1l4?=
 =?utf-8?B?VHdtNUNKWCsyMmpGdk01eWRsR0dXeTZVdGRUVW8wRUVYb21MWWFvNkNMek1D?=
 =?utf-8?Q?jzC39lV+Gey8RIrvn7cIepjEq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ctOhv8zNmiFv7Xu8+yU/Td6ZUoAKSE9uTRMJl2QLtfXa0I74uISnoBUDX1JByo28onmRtVaFwYd3056AYMXuTO4AmfEd7PwIi9Fu4J5oHK8MExuLGqJIqY7U7s9pcLyCn85pfPwXcXg4VwPWNvgI3+Jxj2/CaleU8J7b1tdoVuTRJ4c6at7SjkUe9CXCzNYHmbiQ+h5iRrKmPcnohPzU+7pGesL0KgFqPLbVcyi2cwtXRUvaJWCrVWs4OqXXyk5unOuYd8PdJQFChiCfcIBj6oObb8V4ydk5CDdYv2sX6PQa3BE2Hq/Z0T3lvtWAsS4g8i5jjyZowDQy8NW5pNrya3R4dyf26yzACiQR114TwqXvUjA5oQVGMgufn8GHwewj4XMx9/4E5QZOF71jbMZg+bs8WmndMDDPIg7KBH5R8Xa3pAoQ70V1fxymObe6uAXmFfJLjYFUBQv3Vpn4vlAx+Ye61r6VbtU9fkRXSRUxA+lMljYGF5BXgC+FGTyohzFPV+bGkM5mli3LqcX30nCA8CXUsj5N9yMgnhOFWgJqgEHml5WZxZx3xh4O2yPzhmZScwYJ5Gm5hfyA5ldDlN+AOKrGuV8hjmhAJCxJTSUahfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd398c1-be27-4e94-364a-08dc226d9afe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:02:12.7961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzorrtWEFxWYc75Tqq2Zkk5Hsx3Mh7LC8n3m/2Jvnbh78KPvwG9KuLry2TvK2kazyUNesKeyu/0Xl9Dc/ZUg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310115
X-Proofpoint-ORIG-GUID: 3M8GgfddFjT1pek9xf_cRY4gjKxKc9g8
X-Proofpoint-GUID: 3M8GgfddFjT1pek9xf_cRY4gjKxKc9g8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/31/24 8:57 AM, David Hildenbrand wrote:
> On 31.01.24 15:48, Mark Kanda wrote:
>> On 1/31/24 8:30 AM, David Hildenbrand wrote:
>>>>
>>>> OK. I'll call it 'PHASE_LATE_BACKENDS_CREATED' (to make it consistent
>>>> with code comments/function name).
>>>
>>> But then, you should set it at the very end of the function (not sure
>>> if that would be a problem with the other devices that are getting
>>> created in between -- if they would be using one of these memory
>>> backends; likely not).
>>>
>>
>> I think I misunderstood your suggestion. I was planning to add it a
>> 'phase_advance(PHASE_LATE_BACKENDS_CREATED)' to qemu_init():
>>
>>      @@ -3703,6 +3703,7 @@ void qemu_init(int argc, char **argv)
>>             * over memory-backend-file objects).
>>             */
>>            qemu_create_late_backends();
>>      +    phase_advance(PHASE_LATE_BACKENDS_CREATED);
>>
>> And use PHASE_LATE_BACKENDS_CREATED (instead of
>> PHASE_MACHINE_INITIALIZED) for the async bool in
>> host_memory_backend_memory_complete().
>>
>> I was planning to leave this call where it is:
>>
>>      @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
>>
>>            object_option_foreach_add(object_create_late);
>>
>>      +    /*
>>      +     * Wait for any outstanding memory prealloc from created 
>> memory
>>      +     * backends to complete.
>>      +     */
>>      +    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
>>      +        exit(1);
>>      +    }
>>      +
>>            if (tpm_init() < 0) {
>>                exit(1);
>>            }
>>
>
> Yes. The only "suboptimal" things is that if someone where to create a 
> memory backend between qemu_finish_async_mem_prealloc() and 
> phase_advance(PHASE_LATE_BACKENDS_CREATED), it would never get 
> preallocated.
>
> That likely won't ever happen by any of the remaining stuff in 
> qemu_create_late_backends(), especially not with "prealloc=on" and 
> thread-contexts set.
>

Yep. OK, I'll go with that.

Thanks again!

