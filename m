Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ED6C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfJf-00012U-HM; Fri, 21 Jun 2024 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sKfJd-0000ok-78
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:32:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sKfJa-0006MA-Qi
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:32:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEQnZf008683;
 Fri, 21 Jun 2024 14:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=corp-2023-11-20; bh=PyMHojrHlzHmlf
 oFaUCIsYOmqKPQ4QIKkf4bxf8zV+U=; b=FVjRIcHhlwVRynEuWUvkbhcBXTporn
 WhzblOjEvrIi85NtQ+p//3KHmWjQJMmjmM4BVlk9Mj5Sqnd7UUlEmhjq9Le6hnqZ
 lHJuYHEU5nMKss8wGiNp32pP2hyLah4c0g8hqT11r92fZ9gjH63MEv9V5rQtdWaC
 RFfKsYnhpkXNQWhBmf5T6aLg4edN5f5LPZLjMwzl2eUjffsUs85OVK+R0I8pCa1k
 RScDZA7MiZd0Q21W2vktH4nbCCvFgkkQr8OxOxn9Wv8/Ak2Mf4pWfqsagAmjqBvu
 VlAaGUh46XSD0BDZU5jEF3AASwNiR/7FvOTNLY++ZLjYJ3Dk4UIifcCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgswrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:32:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45LDFNMj040113; Fri, 21 Jun 2024 14:32:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yvrn4djnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnGnjXeoLEQkqWSIjp5ytPT2GBPq9q1u/GwLYtHKd5gt14Ciwgk5KI5GGSSiFZEyLzIGL+JUbgoDAKzqNbqJCauYuEgYJI2fsxIug6fjYlnSTymuwq/VqWaJ1UksyYEW3URYKlQ2HmQAsBVODhcdHycsMujHs8JwO72hsKYeMDFH1YKgHw6OixUw+nZdrMBqj8Z1mXqcvZO0gRDG/En/TVFBCTX13ilqtSD4FjiJPfk3ZX5rSj1a3NPETerIZdPeil5SFI3Rwfyb71S5qtFd6PA+mhx+t9U9bdFTMpfv9e4+RgymY7VqHOVuyFL3bZSQIvuLJkHxz858wLxfsHcPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyMHojrHlzHmlfoFaUCIsYOmqKPQ4QIKkf4bxf8zV+U=;
 b=PHX/fhJep0X5u5PU4PpL05YBx6xwpWc+5wLPqOQcDXFBNxJ3umwn63LaRnrZBF2LkQV4dzaVNCE+7MvqIA8DJ565SJrRINEL4glN84Sr9tBnB9xiwzvPIfmZbeQQpPOtkHUKZrvRSt6fteGwMqV1TBz++N+FLNdGLIDN8X4JgaQwNU3k0bJwE1o5w3n0Aq0iLc1jRvbMh52109a6ezeY8gNYOIdyspl70qjGI976LD1FiF7vAnbinpMBpkt/wyDZ6lvfAj3tcgjBujsNflpsKiv6NuyxBuF/gQVQKyn0T6o1KDzLQQESdpZfa4qEyTosuPHJwKvjNS9idlRYo17R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyMHojrHlzHmlfoFaUCIsYOmqKPQ4QIKkf4bxf8zV+U=;
 b=eby4r7Qs8yx2EZ+YS+vFOGsf1MCLxpEbCsdWs8ljb3lgiRqtK0I+RelNb1YnCAsN45x1Qre4t5pIN5CwubQ5JAbzbHEijqGtJjd9qRoqX6ZGAKlnfBELQGW5bU2MgXGpoQK9BJXupq7/UhasxLonLu9zy1cr9eo5xr8zqaPVD28=
Received: from IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 14:32:24 +0000
Received: from IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950]) by IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:32:24 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH RFC 0/2] migration: introduce strict SLA
Date: Fri, 21 Jun 2024 07:32:19 -0700
Message-Id: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To IA1PR10MB6172.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6172:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 416bb084-dda5-4ac7-f25e-08dc91fef794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kI4SIckQtGQ8sAtcbIN60ptng3PwHYJ2j9AZrQVkTTmQGI8ZO94ldTZXM51M?=
 =?us-ascii?Q?iXsVlkkdUSqjYyPRcQ7LGk3Dg5+rOptyuXYcb2XJOzj+bmloh2hyLZBvLjnR?=
 =?us-ascii?Q?25WAXup7zMsnjP6YmL8Uz1Sr98itOhmJBBcXoNDqaux2fiyU2oT5qhZSv+1g?=
 =?us-ascii?Q?PEbHKclnZRqt/hOjKLmO3DAQRewwxndYMI1gSeITfrf7Yny8fPmSvdXiSfaD?=
 =?us-ascii?Q?gXh5OqoM5YDeti59dPNTXfFv9AbZQI+3/AwotxbFwjGWBtbYIK895qML1bTI?=
 =?us-ascii?Q?xfTs137lte8eABLlfxkcJoZ2MYIKeFVcxgvlwMV9lduuE4u3pSQktmotBUcq?=
 =?us-ascii?Q?hDdwMyYWQocL9CWT3AsYmXrxrm7Ormsasj9sJLQTs0w1bzOlBCCxl95F7wEB?=
 =?us-ascii?Q?FqFIPdBNQesFUr4UFGrBW4U2vnuygeIp8UwfOPa313IxM7zEZDpUF+k6HMa8?=
 =?us-ascii?Q?UTvOfadszh6hEljU3BlvevlsGyK+6Snz7SgO2Fcp2DI6Y2zJDNPzdDs3FRew?=
 =?us-ascii?Q?QX+yo5jV/DoC4RY8qzu/M8Dw6km54Mzefg/u1IssmVPfD5Kh+xsfSUmgOxT7?=
 =?us-ascii?Q?HjyHUEsjfpr4Okjl2+ViioLTncZVGSEZxc4JYoMwp4ra+d5fT88CpMqC2/Th?=
 =?us-ascii?Q?hYPkTWW+yTo5dbOYjU8MMoTXyajyPa1jjCipGILvD/RZAGsZ5oI0qmr3V73k?=
 =?us-ascii?Q?PaKz/7bsAOgPxNvsHezmJSnp21GOIEB5AHEQx0bo4EeICIiM5bmIl2iW56Mn?=
 =?us-ascii?Q?Yy+hmFniNPnXkdSTefgkFWu4p+7DaGGSPHp8VGdLd8Rej2pBvctTi05oF+l3?=
 =?us-ascii?Q?nk14iDHLUe2M+cUxUrt5cMvvQlfyg+BBoPcd91zpH0B1drUf64PZKg54eab6?=
 =?us-ascii?Q?43F8tEJ0px/jnJFxUk1wkQRCr9W57DK00B8JWfms8MVegMvp6MDJzPA01L2n?=
 =?us-ascii?Q?3KUaFNSECBFMiLWtyQ4JL9baQj+Vfr2VKqTT7j64kgyXzgx7ZJJGifC3sPny?=
 =?us-ascii?Q?/p8zTLQ7PxPQT6RpZrV8wYiaTpShTGse0R8etleuWotXRFCbSVvrCbSiTWeg?=
 =?us-ascii?Q?BWAYZqPip5uzP6/61QWcbtvJwfgks0PEdTOPmabU0woW+ZAZbWbPIfO0gEO8?=
 =?us-ascii?Q?DlNFnpFf6bZxdpvrEOZR94hZcHU+C6bHu2bHXjsG0EU5mgf/6RDAyiyUuvM1?=
 =?us-ascii?Q?vZoyXYj0vROT5b1dYXPWpbkTouTuGLok97REn5+RBRzyYyxS44Qh/USBmHKX?=
 =?us-ascii?Q?/jmfJ4Y9Ps4otejTGU/DArKpR59hKAtvedGzv9kHODzaEMbZd7brvd/6rRxl?=
 =?us-ascii?Q?ed29g3lid28LSlh+wjYZJzGW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB6172.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7o39wmXIln/5U4jyiq7LkP4xDh/lYrswWZUxnc3qj2PFp2W6Wg2fOuuhVBb?=
 =?us-ascii?Q?NboqIfrlWRaO0Z9LF9WhZmpgbx6VErNSmcsokkFrtADFlsltNaF8S5otyL2c?=
 =?us-ascii?Q?FLBD4ufVoau/KOWTFnWZn1gmx05fjggqRf7+I4gSDsSy3gLAbXG+IdJG6uNM?=
 =?us-ascii?Q?9Qn9Oc2uwy3kZFK0vmVMMfnY7mVJBclS48+uE3m2/pwQkwDQ5bnaX6OfYqOQ?=
 =?us-ascii?Q?7HxD522ECNG/FhOdq5mOzDxPXiDijBzHbELDyqhnlFZIeG/bUp/VirEE/vov?=
 =?us-ascii?Q?Z/8bG2qoIc3bxepSMUFwmapoNttABn8wtKZQZ9Dh6KEbAMTOEiOiYN3UOdEc?=
 =?us-ascii?Q?QaOqAwFIhlJWCyF+VaM3qJV62KUGx9V6RcLzuSLR72ekiTE03AGJgYfsYkfc?=
 =?us-ascii?Q?sTlHvdaAAEWIS1oBqzC8Fl8Bq+oslmnUAA5okCSdypWqCb/9pZAcaiZysj3/?=
 =?us-ascii?Q?fgoDGa7j6BPfFx9lKdzMEEAIspU/U+J24/smwRugEGU13YZa2w515NiIEijU?=
 =?us-ascii?Q?1CWHIvgo/SSlhNcnPdo99xKeil+KT0LOHlA4wrnUJGOY44xRepxG7aT9AygY?=
 =?us-ascii?Q?VTDFTodpoQlhk+WLBkA+UQJFy/70Ww+2rguVAy2b3EEEoIR0PZ6amJENjRFB?=
 =?us-ascii?Q?yZcu4BQ2xaRNzhIfb9Q2c1PVVQ8QQQORv3ABzaOtmP1WnhwpyzX9Mxf4iugn?=
 =?us-ascii?Q?ui0OLrP7+GR8Ljmcb20TSQY0EXfab4F81wGMfgsuJYzIHB7XvOvU871Tt1Ng?=
 =?us-ascii?Q?2jg477/ZCPvkpcypdmp3ubhp9K7FuypNGTk5Y4jomQE7vlwH6NF6IbTRbRm1?=
 =?us-ascii?Q?5lCl5m3G77v7oJ46IMmcdeoqMKpNMTzDEWt1mHgot5+7HVGW3oLXQMv0Xgh3?=
 =?us-ascii?Q?Exgp7nj6hBYlyD2omUknyVPz6RQy0GZxUsr8y+mTZfV0AvQwjy1xK6nZSkED?=
 =?us-ascii?Q?VwVAtfNl1A7oe9UCPPpHMPtlt7OXvJiaKu5d8KHlMXVOdVnGjynLNKDNzOf0?=
 =?us-ascii?Q?UoMl6BMVu5xGnrFH2FSHFcaAq+/oDKjAYrgRlZ3cjXs7h6QLZRcqznJJoadd?=
 =?us-ascii?Q?qMkaArQt0D632EMGfiuFa4l0IyBwSPI9nFmFcHNmUmD7jzp72VR1LLu8PUcs?=
 =?us-ascii?Q?LSr1JA+XoVu+7GVHLz84fY3f2G37+Ko9BgXyh3dGQ38ne/Z1d21CzD38w2W+?=
 =?us-ascii?Q?znzQ+hSyqL/Xg/pCQjbG48mUYKhttbWFXsE3j9jzF493ErQ579DS8ejdQdbc?=
 =?us-ascii?Q?aMqb/UD3HKAI0iDfA7JwNLKqNt111kAErf/Tg6pJjTf7FgDBNSxN3lC5ay3R?=
 =?us-ascii?Q?R4EPv+s/y7EFttSc+Oo4G+Hk8kPnxM/FipxPS0h7hCBhK27SKC9ZMynhaDUU?=
 =?us-ascii?Q?+Tzr190jvMb16b7lRgofQkS0t6DYQw9z6Lam2zYK6cenLFDK+jkbBHFsxGJ8?=
 =?us-ascii?Q?zkhUjO+t5xwNqPIYlrPinbH+1N+gqJAF/RFLdUtcUKIFz31ypaprtj+CxdmI?=
 =?us-ascii?Q?GQzkRRmf37P5TRoVX9roUSghj5PA1bBDi59fORC8J6AMN641cSsiZs6i9oaJ?=
 =?us-ascii?Q?CSQDgPX74w6HA8c3hLfIPcoVjaOWV5KA0bvL3xZleNipiVc7KbD5+UBKTKce?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XUcd406zaXOpQn2VKT/FzeF1GJgpzvZ7/y1fIIPlOIeqzKEKYUDu1ZE9MmBGhpcuAGqSCYjx9i8HJvKQfMMOtMvmCWV34ajrLxWhk/2LEThuDQ37WBUzNaQEsXMiprjAr6+uBZPfK5UER72qtFVCo/CAH/5Po7YvdxIMywSS5opa45Z1EGKuzFshHNi4s+XgmDcqWkowLC9IpHcYJux6gc9cP/Mx/JrR2jqjHfHlZC9TmRC9tXkLaZQ5NTxB+eU1hsXU46/7UX/+2y7VGwuScdaBovIWla/aQ6F1ziaOhuuVcbSheZEbzug1yHSu+IXE67ps65Ift8+DHCFr9GJcWYlu20I5SDV7gEgz9gWVF992PuKFB24y9daADOVeZolGR4nl7nz9b8FWR9l1/QWuixeIu5YE6ghHBdI7+BqNzeb7tDqO2d9jRrOFcRbNu/EVnevEZT9zWcYuBayZuPV6ahv7V5DIT2OA3yoLPic5KPNcqLBDwbw2pW9B994m2YuXU7D4rishdEtY79Xaq+T/p19qjhWl9xmB8zj320w1ASkO/jRAYD/hf2WHCEOa1acirN6akT6Oz3CZeLCoE6EbdD4KexbIYZBgS+qrAVgbGhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416bb084-dda5-4ac7-f25e-08dc91fef794
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6172.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:32:24.2856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMJNc614kIGHAxGm46QJ9YXMYaUIn7bkAQV3et3RAPQKsNkaLoWx1F6TPtQsfxRErABYeAwqK88SJbdE8EVWEJzuGZdZonfq+gyiJTuVoYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=970 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210105
X-Proofpoint-GUID: jiACADXq4f5G43qPzCr-G2KjhX3SVSPe
X-Proofpoint-ORIG-GUID: jiACADXq4f5G43qPzCr-G2KjhX3SVSPe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hello

This RFC patchset introduces strict downtime SLA for live migration by
restricting how long switchover phase can take and aborts live migration
if this exceeded.

Various consumers of VFIO Live Migration are bound checks on how long
the switchover process lasts. Some things are not accounted for and are
unbounded, such as:
  - Time to quiesce/resume the VF
  - Time to save/resume all system state
  - How fast we can save/restore VF state

These cases lead to the final downtime being larger than what was
configured in by setting a downtime limit.
In some applications it is important to observe the requested downtime
and re-try live migration some other time if the downtime requirements
cannot be satisfied.

This patchset introduces capability to abort live migration if
the downtime exceeds a certain value specified by switchover limit
migration parameter.
When a guest stops at the source, measure the downtime and if
it exceeds a threshold we cancel the migration and resume the guest.
The destination is being notified of the source downtime and its threshold
and starts measuring downtime. Destination will cancel live migration
if downtime exceeds the swithover limit.

The migration with this capability would be used this way for example:

migrate_set_capability return-path on
migrate_set_capability switchover-abort on
migrate_set_parameter downtime-limit 300
migrate_set_parameter switchover-limit 10

The migration will be aborted if the downtime exceeds
10ms (switchover-limit) and total downtime would not
be more than 310ms.

Please send your comments and recommendations.

The patchset idea originally comes from Joao Martins
<joao.m.martins@oracle.com>.


Elena Ufimtseva (2):
  migration: abort when switchover limit exceeded
  migration: abort on destination if switchover limit exceeded

 hw/core/machine.c                  |  1 +
 include/migration/client-options.h |  1 +
 migration/migration-hmp-cmds.c     | 10 ++++
 migration/migration.c              | 41 +++++++++++++++
 migration/migration.h              | 20 ++++++++
 migration/options.c                | 56 +++++++++++++++++++++
 migration/options.h                |  1 +
 migration/savevm.c                 | 81 ++++++++++++++++++++++++++++++
 migration/savevm.h                 |  2 +
 migration/trace-events             |  3 ++
 qapi/migration.json                | 27 ++++++++--
 11 files changed, 239 insertions(+), 4 deletions(-)

-- 
2.34.1


