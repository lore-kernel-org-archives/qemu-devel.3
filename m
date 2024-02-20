Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CF8C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 11:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNsS-0005wS-8W; Tue, 20 Feb 2024 06:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNsN-0005vY-0b
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:01:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNsK-0005cM-VP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:01:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8xAG2015125; Tue, 20 Feb 2024 11:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ki4KR/k7RzgyxWQCNue6fVlrRZzGEWlML0FFRYGD3NI=;
 b=BGV58q6DCzM7yyGgyF3mFaPY9kw606qNGJfXqXT35DCoN4EnOLco8kln1ntVf/xfYA+4
 6u2MJjyCkFCE7tAEb+49PEXgpBFpWhuC3ifgi8Xw+ZJ3GotQtCnFPq81hQhr1juyDUGa
 z6oHz+dQZ9MvWFFSNrV1+ZyXRgSdoUmQsEwkzgprSP7LQWFc5OkeuiqCXXV/TUdj8bih
 EZst8m1OYXSh7vQP4WrwfMnopQ9V/ABzNao7SDv6HeKcH97Z7TrupHeByzor1OHvhB1j
 D+GEiHDBRq+Yl6IrspGAIyEG+/LNtUTsyVS7Fpo/Mndc/5xoOIr/VRV+H2bNhYJOHgLC Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7eec7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 11:01:21 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KA8Anh038067; Tue, 20 Feb 2024 11:01:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak872h86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 11:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLBRebcxVpTasyXVAYee/RlyVs4a+WKDPPnIKsesEwG0aeo2eWtHm4/geZ5sPeJshyCvChDi49Fji8WzumJaMcTnjcXYl81zN5xTYbke7L5VLWZdQty6LjSM6CRKRARWRTBqPRbqNXuoOkvjY6WtsL1V1GdZASqMrR8snpNucKD76p0PMeFSUiN2JRWTWWRq5eiqYjscW+OouUD9UKEe+rVP7qKvkrDt+g6Ndgpx+ay79Or08fGNMmOrJ0EuZecLBC1prff+uzvTS9Pq+XnBePk9N/FKiY+Aj0h/s0UPszrRuotqUVc5XJkuF/3s0CCHkhBU26G+Ma0e5oAuRm7blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki4KR/k7RzgyxWQCNue6fVlrRZzGEWlML0FFRYGD3NI=;
 b=ikiCYQ0H/CQVBRJQQvZvyZ1w9xHfrz5qWMZbgYUvaoFjs4pLFIxxr1fkQlAuA8v8O2QralttOoc/NV0blhcodPaio1KQ+U3RaXLPWhYS79IHmvLTcgqlh9EDKXmIBW9xMnqzfptweE9NkkusoowuHo+yYtA2JkORHaSMdL9EOzfukeaWCCNV1XGok8o6P4HH1OOqbbFVG/DR3oeiCfj5bc3Abq0CgKAomjuxV96X4JYROQ71OXlwpcT1JsMwNIObPIAfx01PKW+PZyKPuozs7aEik3WoMNEWJ9zTrxVkU9JOUjvO3p88pkcXpI1OgO8aWctdatK6CFUtnoV/kuY8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki4KR/k7RzgyxWQCNue6fVlrRZzGEWlML0FFRYGD3NI=;
 b=Wxyn+sbbOasqt0ZM77IWnuNxLidOzlX6IeqvAH1STItorQP4Xydynsq5Xn2L61dCsWSj73Mj7SkNIdO5AiVThI4yCQAzmNf11tDkLUoXrcYQ+g2kk2k08DqSSyVOh42WRz3KZP0ODXGelx/qD+3xLeU3vcm9tHAf/jS7gHTPDEo=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 11:01:18 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 11:01:18 +0000
Message-ID: <d17c7d2a-4572-431c-b6a5-379cea19d166@oracle.com>
Date: Tue, 20 Feb 2024 11:01:14 +0000
Subject: Re: [PATCH RFCv2 6/8] backends/iommufd: Add ability to disable
 hugepages
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-7-joao.m.martins@oracle.com>
 <a44e354e-f157-49db-9e60-5014afc605a5@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a44e354e-f157-49db-9e60-5014afc605a5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0388.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b49a95b-225b-4a3d-1695-08dc32034363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZE4QYsktzY6n879kKMuDLOCz+M5ZmhurnV32T+aDNcG8GBKC9IwoAu3GOvl2kk9h5AkapsMEOpgSkotSWDrQUCogusV0pa+lHNc0XSwNYuIjC3xzr15d1s+r1Jlpska6z2GDVZyz/5/IayijZpHREWKkSwMeoVdAm4OlBrQIJTFHJqFPKvXTCPFOvaJWt3PskmBGU+sKolHEeWIkmyfeZ5NllZJ26n3g6MqGQjtzB0vprm5hLkbdJ4dSxZWg1NPX8XELe7e60x/hf2t9K6lCDiJRLrg5uq69GoKjLjgu+O+LuUU2ASheID+gBsGeypS2bBtv6mVPyx1nEKU9XWxlgXmjnsQD6bP2iZJUnL02PeWNhiuO/l8zVXrCT9ufkDJX/mtEw2YZ6xFmKf3kaiMOFRhk01GHuR3Fh+Z7ZQKjcqeBxCBrh+w4c4bdf830gm4NRFHaAH62XyItaEF1ib1wmtH5PmNr5AAAvIr8f4GXhurlta7LB7VaXaFYRkO2FRGwHJs0OMMQsXmsrtM/iayPJtkU2hj198VOtucCGXIFS4BZT+GrlTVxD5909/UcMsAz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJKY0Nud3ZsYkVpT244N0VTL2x2ZnBoV25XbjZjMHE0L094NFBNRXdYb3A5?=
 =?utf-8?B?S0Q0MkhRUms4ZzBiWnNOU3dyY0h0SlVTbHNnV0xiaE0vV1pEOXVlZ2FBa0ZF?=
 =?utf-8?B?ZGtxMnJhbTB0dmlVNitLb3J6NW9GVmMvYmJyVTNFNDA0UkxSOXA2blZZYXFk?=
 =?utf-8?B?Zkw1dWxlYU1hZDhHNi9KOWt4WTcvL0EvZnQ2STJsOUswSkVoRXJHZ3hnQ0Zn?=
 =?utf-8?B?aTk0U05nMEp4N0hVNVd1aCtLN0FwV25wdk1jMm1mWFQzdk5sSk9yNmZ0QnBQ?=
 =?utf-8?B?ZklvSmFpSGpaWVBJRFFvdXM1cmxzTHJvbU5tV09TQnB0SzBOUGVIVEVoL2Nt?=
 =?utf-8?B?NlVOOE1LMFVZTTRiZGIyaGkvUlZmUFdsQkVXc3cwYjNFenZrd3k3Y2tLbFB5?=
 =?utf-8?B?ZkpGUlZsT0xiNVBjK1o5NHB3QmNoVkpvYWxKd3dtaHM1VEVGMlphcmt1RE9V?=
 =?utf-8?B?U1lRUkJjOHIwc0xyL3RDTDlkVXBicm5oTzRvVjRTWkJRdGxPTFNDZDhUQk9v?=
 =?utf-8?B?alF6amM1eGl1MGd0QnBYR2JIREVtUU5rNm1GcG5PejJVK1lBMXhESWRzbTYw?=
 =?utf-8?B?Z0hvbnM5OE8wMFF0allNV3R1UmlXL2ZVc0RydENpV3ZlUlRCWXJXcjU2bnht?=
 =?utf-8?B?SFZGV3MyWUFwSlJZbXlIUjBReTJmd3ZOeEdMU25RczNXME03WHNzWVkrMytJ?=
 =?utf-8?B?ZnBYMHlZRlBRQzlTaVo1bHhyeUNlVjZQL1lyY1dOdjcrNFBrT3llc1dvT1FF?=
 =?utf-8?B?bkhVNUozc0t1RmtKWTVOYzdQK01OODlJbmRuNjR4KzV6LzdRa0tuYzBLREh3?=
 =?utf-8?B?Sm93U2tZQzl2TjE3QVRTRzFhTUtZd1dhUUNRUm1TVHJzVWpTRXI1b0FldXQ1?=
 =?utf-8?B?WVkwcWk5WXlKcUM4QTVJQjdYWmtOSWMxcjVVdDdvM3VyVzE0V1NjSWNUTkN0?=
 =?utf-8?B?YlJwMkdsQVM0M1FuTk1aMi9id0Q4aGRQZkowREhRR0x5dWhwV2JnT0dPbmk3?=
 =?utf-8?B?Z3ZNNmQwcW5zVWpvbG5Uajlza25wQ1ppSFRiNkJsTDkxZUdPazJ5YjdhWENS?=
 =?utf-8?B?SnRIUmd1TDZkNGpmZ1ZQNEY0aWVubHBMYVFwS0VLbWtZTGRsSy83dmk1c1pH?=
 =?utf-8?B?aFNVRlpyUEZucDNYMlloWUlPWlBvalA1R3Bqak5ZdEJDaDQwUUwvUVdvd2hz?=
 =?utf-8?B?THZrOFRtZkx6Tm5zVFVEbkFUeDBsaFl6eGQzaitJNFZ3T1FPL0laODJYZmdi?=
 =?utf-8?B?bW4xank1aGFFNEJ1RG5kcDVBbTZTclNQbkJ3N1ZsbnlUVDFleXU4MGlBM0dQ?=
 =?utf-8?B?end1VXN1dmNYdFVJUlkrSzdiYlpsUDcyKy9kdXBaWlk5UFFUYmVnVkVjclJJ?=
 =?utf-8?B?emFqTWZ3cDJlTXR5aVpVeDlYQXNNbytnZ2R4Yzh0UWszRmhwWnBwN01OUElZ?=
 =?utf-8?B?aEZCcmJlOU5oV0RHZ2doSExiWXlDNXk2SytmMEVLZFE1SGxoY2xZVk1KUElQ?=
 =?utf-8?B?N0VUSHRGdGFtU1JTRWY1UUo5a24yeERGbnZGUWkrMjhkZVVUckZNOGNRMzBi?=
 =?utf-8?B?TktqODF3RmRBdDRlZVROVmFFNlVQL0MyYXcyMTVIOFE3WC8rWC9KYlF4SUR1?=
 =?utf-8?B?NWsyVUtFb0EyVmJRVUdrYU45ZUQ4czA1bU5KdmFHRzYrT3N6VGZKLzBLeUQy?=
 =?utf-8?B?UXpyNUxCSFIyOEo0RThyVCs4dU5obHY4V1I4dlJ2N0piUXVWY29lK084ZXBI?=
 =?utf-8?B?QVcwTGl4NE1TaWFtdUFmeGk4S0wwckd3ZFZlQXJGQVI2ZCt3MGxxNFV1alg1?=
 =?utf-8?B?ZnZYMDFPNmlzT3Jpam5YTE9NRUtNa0hRQUZMT2I2SzBkZWNFM01TNU5mTVBR?=
 =?utf-8?B?TmEremNMczkraVNGamhlQWt6MnU1T2dHeGNqMTdlY1JOc0dmZ2hlNDFXUHJX?=
 =?utf-8?B?WGVTanl5Tk5TNDcrUTk3RTZvMFFXa3Z2a2NLT0xjSEVNTXRSYmg4aU1Pbndu?=
 =?utf-8?B?QUFvZXFaTVRQQWgrVUl1ZmYyeTEzZVRSMm9KN3Y0ajBlWWNJNGtCUzFSckRz?=
 =?utf-8?B?a2JSQ1V3UUhGSS9uRG4xbGZjL1FUYkk3VVhteGx4VlBYTkJOU2lMckdyWlJ4?=
 =?utf-8?B?T08reVlWVTduL09ud2xadFplazNiOU5aS2dXSkdSY3ZQUWJQNjVJVlMvZnlv?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VfEVdRu2kMi8MwHTgg4oRcBepNCncKNMjNBhY3OoEtSHXU+kWciUHFIG3DWobiZGgfA0giNMhIJR9Jmk/SfWsDez2xj+YaZy8Qh+Bu8ngeMZojmri3zkRX4rKMiye8G/7El81PDYu29TfYEnUoMdkVP7RGYtgwMeKPeZ4VYv3lgQ5/gPQFYZLxaFTmHUdEIkByxbKmSjT/wpS3HSmdKALg7f/Q60mZspruGLxLfPpk6NhPn6VHTjkWPaOqwhpFu+0XcM+nK0RPhuyoY5ioymPJhw/NPw19nc08TwDBIbgTinhZkevzeKk3tp6VAhacOUWiJeEQV1By2GawvUoNpUN5OJ9EKKmNplE5nSkKVRICrAhGn5dZ/4QRJKGwVDeyvSvo2EPxKBmSxBXIoCvbaFUCDVL6tizuYuzVGHbaFeOoqPMibt8Bszum9lhbMwk8RfXcMM8Bm18ins8DMmi1G+xOx35g35bUiD/q9x29IsmnlL72oOSFk5rwt0cvrToMXxptxxHtVP7LHQfvRAPFpgP/vY1IrdLx+RRYDjLvC8LwkZOkuvKB8XfswaFuMGOol5INW4qO6kiKpmiT7kloXS34tDFbV0eycEBlku/B5XVlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b49a95b-225b-4a3d-1695-08dc32034363
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 11:01:17.9087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AE+KNtNKTrwK738hUxp8pUtIJgMzCPy+86Im6O35tCQkHnSIv9XkHvueUa+i30ASifWGk6eqoFsD0M/dveXz02n0WacOub4hQrCvejJVQaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200078
X-Proofpoint-GUID: beEmYUjhK4NN1bVILptiNk5ig6G8wxKT
X-Proofpoint-ORIG-GUID: beEmYUjhK4NN1bVILptiNk5ig6G8wxKT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 19/02/2024 10:05, Avihai Horon wrote:
> Hi Joao,
> 
> On 12/02/2024 15:56, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Allow disabling hugepages to be dirty track at base page
>> granularity in similar vein to vfio_type1_iommu.disable_hugepages
>> but per IOAS.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>>   backends/trace-events    |  1 +
>>   hw/vfio/iommufd.c        |  4 ++++
>>   include/sysemu/iommufd.h |  4 ++++
>>   qapi/qom.json            |  2 +-
>>   5 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index dd676d493c37..72fd98a9a50c 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -29,6 +29,7 @@ static void iommufd_backend_init(Object *obj)
>>       be->fd = -1;
>>       be->users = 0;
>>       be->owned = true;
>> +    be->hugepages = 1;
>>   }
>>
>>   static void iommufd_backend_finalize(Object *obj)
>> @@ -63,6 +64,14 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
>>       return !be->users;
>>   }
>>
>> +static void iommufd_backend_set_hugepages(Object *obj, bool enabled,
>> +                                          Error **errp)
>> +{
>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>> +
>> +    be->hugepages = enabled;
>> +}
>> +
>>   static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>>   {
>>       UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
>> @@ -70,6 +79,11 @@ static void iommufd_backend_class_init(ObjectClass *oc,
>> void *data)
>>       ucc->can_be_deleted = iommufd_backend_can_be_deleted;
>>
>>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>> +
>> +    object_class_property_add_bool(oc, "hugepages", NULL,
>> +                                   iommufd_backend_set_hugepages);
>> +    object_class_property_set_description(oc, "hugepages",
>> +                                          "Set to 'off' to disable hugepages");
>>   }
>>
>>   int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>> @@ -106,6 +120,28 @@ out:
>>       trace_iommufd_backend_disconnect(be->fd, be->users);
>>   }
>>
>> +int iommufd_backend_set_option(int fd, uint32_t object_id,
>> +                               uint32_t option_id, uint64_t val64)
>> +{
>> +    int ret;
>> +    struct iommu_option option = {
>> +        .size = sizeof(option),
>> +        .option_id = option_id,
>> +        .op = IOMMU_OPTION_OP_SET,
>> +        .val64 = val64,
>> +        .object_id = object_id,
>> +    };
>> +
>> +    ret = ioctl(fd, IOMMU_OPTION, &option);
>> +    if (ret) {
>> +        error_report("Failed to set option %x to value %"PRIx64" %m", option_id,
>> +                     val64);
>> +    }
>> +    trace_iommufd_backend_set_option(fd, object_id, option_id, val64, ret);
>> +
>> +    return ret;
>> +}
>> +
>>   int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>>                                  Error **errp)
>>   {
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 11a27cb114b6..076166552881 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -15,6 +15,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t
>> ioas, uint64_t iova, u
>>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64"
>> (%d)"
>>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id,
>> uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t
>> out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u
>> len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d
>> ioas=%d (%d)"
>> +iommufd_backend_set_option(int iommufd, uint32_t object_id, uint32_t
>> option_id, uint64_t val, int ret) " iommufd=%d object_id=%u option_id=%u
>> val64=0x%"PRIx64" (%d)"
>>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
>>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int
>> ret) " iommufd=%d hwpt=%d enable=%d (%d)"
>>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t
>> iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 79b13bd262cc..697d40841d7f 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -521,6 +521,10 @@ static int iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>           goto err_alloc_ioas;
>>       }
>>
>> +    if (!vbasedev->iommufd_dev.iommufd->hugepages) {
>> +        iommufd_backend_set_option(vbasedev->iommufd_dev.iommufd->fd, ioas_id,
>> +                                   IOMMU_OPTION_HUGE_PAGES, 0);
> 
> Shouldn't we fail device attach if iommufd_backend_set_option() fails?
> 

Let handle error correctly and fail the attach.

