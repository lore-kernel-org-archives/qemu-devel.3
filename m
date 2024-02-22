Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFEDC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd94S-00018U-IY; Thu, 22 Feb 2024 08:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rd94Q-00017l-Ma
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:25:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rd94O-0002fB-RF
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:25:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MBto7b027873; Thu, 22 Feb 2024 13:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kocmRg+v/OEsE5XsPiUw37YmF+RwKb1ige1saFryZc0=;
 b=kU80MYpU7VCWthPZjNEMWyX3irQ76Rx1BDox8YpTXUTFWQonIat4ho4k6VGDvwmR+tcj
 32ecfRfw6fqONmoV3eA82kxLihWtVNvxFjIvd0I+80n1SeAaf/eJ5TiERVAIDPC5ekao
 bjNlgI4Wl1MigA3JjBpU8DSh1Xkpox48cXEGSndiHSiW67ks12ivJcEArWViQNxtdpaP
 Y6/+4UbNxNxd4Oghxjxff2iOXUHEz/m+S2Dmpe8JRy19CXfVyDVAYB+ZNMs9ExtwnwCR
 6H+NJNxe8BdL8fl54XX2z18wXXxk4ZK1Gd6nZvG8oaQ+qZP6R7e5qxZpCCWQNAA6ja0B PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knvbrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 13:24:38 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MD7W2q022473; Thu, 22 Feb 2024 13:24:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ak1d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 13:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgfoskkQIgFy3rwxl/Gxg0bfnD+1LpxnFt7yP8JllWpeY6rzJjhTwSfxuYelgsIFPocwraGSJkZOdWAG2c3DGzGyeX0F2iIFfN6fLZ5stthfnkAHyF+zuyQRKT84q4N7zFwLVOnhkOzkJe51aksvk8/nMX4+A7Rd7isXOjtn8tXLQrUXdDKsN7WJ5MEEHsoB4U7rkmCXRkt+fEou9uM1uHUGaDw9+iGXZlICpMfnFqbgNal23Wx0LnLeVc61Ae3pIGZPU0FwGN9XTqeacJITmbo4QX2vTY/jr/0+CFBZBshPkl+EYLLbcsEUZxG//xFhw705YvB5NoAJ/ONK/8f94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kocmRg+v/OEsE5XsPiUw37YmF+RwKb1ige1saFryZc0=;
 b=oN8LSeV8oMf88KELrPYDxIEDIvGClC79uxpGbgp0jTVRkilUCThYgwRDB5pKHhv4JCVaK61tx2g4hrZSWXL22h9Gtv1+0xPV8qNN3aIvJS7D38be5qLoap85QDuHjI74o5uMN6Q3qyLyxA7HO8b8qTV+beP/6Kqc1dk+FNQJZ178TK6FtoPBMYZJMXtQz3AUiNr+0cnsR1am8rKwfUoU9cbHmwjE1KUnMGafCBDksge2w7991sxyWqMtv8AY3/5nNm2oam61QNDo6snAGFsI/G9HbHCbybpCBzrvY+hZmBy9MbPq7NTpP61N8uokBPG61nNof4/2gTn0lcRYY64w3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kocmRg+v/OEsE5XsPiUw37YmF+RwKb1ige1saFryZc0=;
 b=SJRjP8c+f2Nws9WtzcUAHpjmt8m3j0+i6kRDcbRCDYFBzu7G35BANGVmKx+hcCM55vkxJeXR2gaZ8neCaww2b3siJNJdCwB0zy73lusnp3OsVST5/ps6WVWEx3clw+zbf+qQk8n/VPRAgXPdhgchY8OBfXby1R0/lmeCXKCSr84=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 13:24:35 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 13:24:35 +0000
Message-ID: <0883bf67-9f04-4844-a88b-8111de30ce6f@oracle.com>
Date: Thu, 22 Feb 2024 08:24:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
 <ZdRVz7gvh-qGNxXZ@x1n> <b573d625-154c-4df6-9e86-2b1bbff38ac0@oracle.com>
 <ZdcN4L0nNhsrkxB-@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdcN4L0nNhsrkxB-@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0388.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::33) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1a7a23-83e1-4392-8e33-08dc33a99cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nupz1T5ASVzV8tO2HPpQ7lyDBMlE6gDABe9SXwiTaW4HTABJm/9Bl+A4PqAsqScUiX/jMuVblF4mA77zOb16TazAtnLKRTrNg0FS7vKU4R6jUkMcZqhCCJNWCL9j6kPFdB2xc+v1QNmIL9pBQ4hcBxAM6xvoQu5d7KkocFTgXdYXu+KOwB1Bf2phzqWYm2oEnjyI6pFBcsbvibDH5uVFt1M3DjVhae4ppCYvnpiqah86jqlB74CPSLGWVR1yu2j8HMjdywVVZp/wrWsivQSHLuRVijqfu4J6Sr1LrJ+9F+BLT06kLaSZfjB5vGRXXrt7mSeKPfOSpLSDqZPtMWzCwjK26E3Olq9z2eLpeSbbNU4bUg4vuNpx4ENr9tL1uc67PzfI5jQFmWvZohPj1grmMeSJwj5erRjDKRnjLOOpPJWDCLWaoR0so3SShOQ4SdfVzJiJGH3IYS6wQ4nqOWMIzRQgRMiNU+RSTLSYCora7UXARdhG32JRlz7/J9M3oPFe8TwNmc8U0HdLjUQ8gceQvUiJzqpw2kypQX9Dj2FzMvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllFTTlVMXZNa0FrZWt6a09Za2oxTmZlUTYrOGNDcXhSUGlSMmVEWFdodzli?=
 =?utf-8?B?R1NQckY1Ym9QOGdCUUg4ZzVhWlI4ZUs3cVgzbEYyQWFwS2QyK0lta2R0aDVs?=
 =?utf-8?B?Z2xGTVJtWUhVNHh3K04yYk9QWlhibWJRZzZKU3h2QXdsYUZ6TjM3Q0hURmFX?=
 =?utf-8?B?NitQVlZkcWY0WmNKZW1qaUQvUjlHNEQ3QUlRUW01VFAzbGMydFJFSnRpQ0c3?=
 =?utf-8?B?T0NNYWM5WStrV2hiK1ZRUUpKZkhOVDh3YmVHOUhHVUllNTI0MUR3bWdFeE1V?=
 =?utf-8?B?NEtFZ3h6L2dHdkp5TVRheExQNmZxM0lZWEpRTEpCaHR6L1N1NnRkOUY1NFVk?=
 =?utf-8?B?bjl1T1gzZEFrZENFOUo0eEpVdHZIQjEvVUlxc2RsN1RyNjlMc29BZUdMa1pH?=
 =?utf-8?B?Q29LSlBhRmhoWFJ1dkJtS3pybmVXSXBKQTVvcjNXUnFwdlF1VUNiWTBua0xk?=
 =?utf-8?B?ZWVMSEs4cVB1N0s4TGYrUGZvK3hQbDh0MEZ5YzB0Rmp6SklnS2pHWVljZGN0?=
 =?utf-8?B?eG55b3FzajdyUTEwS2ZlY25WNEFPVzJLNkp4aHI1ekluYjk4ZDREandlSXEx?=
 =?utf-8?B?emRsYmF1NFhSMXZJenU4V3kwZFQzM0l4cjZ0MmtYWUlncEcxdURSdzNnNHZt?=
 =?utf-8?B?b0NPb1lPcENTK1lFczNUNlE5aWJQTnRoZW9XMksrb3VZa1VtK1l0ckZ6OSt5?=
 =?utf-8?B?K2JmQVdyREk1OGQvdGh3bHYvU1dTSWxhWlExaFhqVGpUYUpsMmMrZllBYkph?=
 =?utf-8?B?dDErSlluMW1mUkcvcFpnR3Z0NFF0T3JaelpKcmoveFFIRHJBeVFDYjRCb29S?=
 =?utf-8?B?VjlnTkdNUlYwOGV2WmZoekx1eWhoNXFpdmFOTHlhUUtXSzVHRVo5SThmSklH?=
 =?utf-8?B?eVRyRnN1aW14TVJmM1B6bThlUmVwYVBVcUc5V3EzekVkdUh2Y2tVcUVsR05X?=
 =?utf-8?B?c05ERm53emF5bkpOSVMyUldwTk8zWkFLMTlpenBVay91SDZUK0RscUJRYVlX?=
 =?utf-8?B?RWxtT3lXUUZHUXBDS0NteG1xUHlSU3U2V3FJenZrQjVTT05lNStpakFLaWM4?=
 =?utf-8?B?YXdPWmlGb0NqWWZQbG5uazhvc0M5RUZ0MFJoMnFZSEJlZkl5SU9wK2IrRkcr?=
 =?utf-8?B?S05GWXNXMEJ2SE4rUzUyNjIzUmUveENTMDVKcDcvY0UxOE9JM3F6bUY4SUFK?=
 =?utf-8?B?NEdSd1NWb28rN09aOGFWS20vMnk0U0hLR2VjRXFlRHQzWjNheEhTeDZQVTJv?=
 =?utf-8?B?RVp5R2ozWkFUN0FoaVJ1TENBOHd2azhFOGo5VnRsK3BPWGc5Q2J6QTRVaWls?=
 =?utf-8?B?RHVwTkd4dUp3bWI0Y3oxQlZ3WnV4ZzFZeVVyYiszdjArQkUwemlTS0lqdm9P?=
 =?utf-8?B?OWZtVVp1eFdHWGYvbk9TclhTclhKR05vd1hjMXNQNG9Ta1RMUW1Sc1lRdkRZ?=
 =?utf-8?B?REdNRmEvb0c0RTR2d2JBcjVtTi8zZU9oS1JjZ01VZEw0NzNHM0oxRmRFdjF5?=
 =?utf-8?B?Z2JZbml0OHJ3VkJBT3cvY2NJL3VuS2orVEErMkt4bjVQVjF1UmZwUmx5VTYr?=
 =?utf-8?B?eFkvK3drbUU5QnhpYzBNdnVPUXhZSmhDdjFOTit6K1dNNldaUmJUS01wZWNy?=
 =?utf-8?B?dGI3bjBDTy84cFRpdzNSNGpocEJtSmR2QW1SdnZwRUlKRUJNemlpaDd5bDlR?=
 =?utf-8?B?K0dFSEtsbENRc21qRVkxazg3dUFoVDZUSXhhdlRGK2FaNFFjelVpam0rR01P?=
 =?utf-8?B?MEw4N1ZHL2dxbUpLSDc2UStsUUdqU0U2NmUrZXpPUFYycDJXTnhTU3RkQ0hu?=
 =?utf-8?B?dEFCQXc2eDk0MGxSYW1FeW12Q2wyeU1PMXVUdEdZZmdDMWtUSmNMTzVEWkRw?=
 =?utf-8?B?cEJZWTVXc0lxajJCeWFpSEZsaUNzL0RRYXRVUGVmdjg1UkYxOGhHV2QvdlMw?=
 =?utf-8?B?WWFldG9hbGhta2g0NG9TQzg4Mmk1elFWSlk1aWhHVTIzT1NVVDBCYndPOU9w?=
 =?utf-8?B?TXhlTnhPM0lQRjBYMzJwNDhmNUFOUXNEZU1rVlB2aGI2d2FqUzZtZFB1dWdp?=
 =?utf-8?B?Sktrd3NWZXRqaGkvaDkxV3ZNVzhYVDZmVkJuS3FsZ0F1QWpsa3lkajJWZHFz?=
 =?utf-8?B?OWJZY2VPMTZtaUlKUUJ5amFsc1h4MGZHWWRmVnE4UGU5a1J4WjdnTFUzcGZi?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hvvFsaCrUF8U5L93X0trhmpBYYdpJIk8MNkSQ/Vb5qX/zc4g5kI2Pn8ZVvJVyGagUH7lStkIKHohWxskKIPf2TdSjOxnjp0g4I63BZ2VmMP9N/IbzG1hLEz4AaYl9VQDi7sz7aNue++qOUmKqEXwBeZKuE4DNxebK7gYdWbkA/JZ1cKDVuoQQVR4M4REmipmj/9m36iB4T23kXbf29fLCfN46am3hkCCsk4SwmZwCvgn0AXP6LU9uM1EXJsl4Jyx7ZeN/RVPp6q99WN44d6jniVaRU+2Cvr09W+NHVxHVkMoXHmf4H9XT8Cfu48zH83aMxO3bCKUIGEhqGAS48wvBVUMBw2/+FDHHTyqpD9FPoNlA0aU+J2GhVbLTus1kSqwo+Bf1tzTu73keHVkl4vOnyt5GML0bixYImLEDr+GwQnKwwenGBjKmTOYYCv+wyqY/u9Hmvk2X5i5r2+DDZUPMnsHNLypRLpthm1I1v0tTpyg1acb9X1ucn8jo2qeltwsqZSBBz4cj6dswsOQAwIqwZSI7em/q0RweTLplZtctIegPTiAcygBj1lNCuZoCcxbh+QELW0zr6SY5brca0RkmBzCk0IwA7ccmSQzDvyYpBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1a7a23-83e1-4392-8e33-08dc33a99cad
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:24:35.2225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNiK3RTZhClu2mGAxCKk6G4sv7g20hI1gk7jDkznpJipOQ+MWkv1jY1bjL1hgIWNeIUis0lp8na3mZ1pgu9tgb73bXhTy0y/bRRxV0I3XJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_10,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=934 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220107
X-Proofpoint-ORIG-GUID: eBW2q8Z8o_GeGkcpRXwvY1eWnBRW-sHo
X-Proofpoint-GUID: eBW2q8Z8o_GeGkcpRXwvY1eWnBRW-sHo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/22/2024 4:03 AM, Peter Xu wrote:
> On Wed, Feb 21, 2024 at 04:23:07PM -0500, Steven Sistare wrote:
>>> How about postcopy?  I know it's nonsense to enable postcopy for cpr.. but
>>> iiuc we don't yet forbid an user doing so.  Maybe we should?
>>
>> How about this?
>>
>> -------------------------------------------
>> @@ -3600,6 +3600,11 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          return;
>>      }
>>
>> +    if (migrate_mode_is_cpr(s) && migrate_postcopy()) {
>> +        error_setg(&local_err, "cannot mix postcopy and cpr");
>> +        goto fail;
>> +    }
>> +
>>      if (resume) {
>>          /* This is a resumed migration */
>>          rate_limit = migrate_max_postcopy_bandwidth();
>> ------------------------------------------------
> 
> migrate_fd_connect() will be a bit late, the error won't be able to be
> attached in the "migrate" request.  Perhaps, migrate_prepare()?

Thank you, that is better - steve


