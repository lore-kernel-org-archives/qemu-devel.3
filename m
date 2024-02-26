Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXx8-0006hZ-9u; Mon, 26 Feb 2024 05:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1reXx6-0006hJ-CW
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:11:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1reXx4-0005tI-Dk
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:11:16 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QA46HR025373; Mon, 26 Feb 2024 10:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+SNiAbRqMviWXgHYTwI48cIj17Q9+rw2Y4El6Zq362w=;
 b=G3skCEZ3rKg9VQBqP7po+mmPvm6CD/N1lfs7FDE3r+h8hFrChTz+U4TmvBlzd+qWSk5B
 B1bRa8P+ShYmZCWPuCYuXs3F1mLqmsjepNNSaptBjhHdiME1KPd2JlO4k9x4gNrOvToV
 m1pFdOF571S5wy7EPIMBJUo1UnkUQFUDc8Cwn61cUqbXSzXWgvCQz0SZ11PkWcrPOVZR
 njNENxs5xYD13/0mOgYC8zCSFEMV4GQDf+8SinAllJpC8e5pTjA9DLuR/2hT1ueXoAYb
 1fKNlA9uqNCObOWSmPeCaRzwohqQS9NyDgzTTVRTnS45feaJR5Bc/xFpF0PR3TatmxYr XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784cb6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 10:11:09 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QA74KH040687; Mon, 26 Feb 2024 10:11:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w5ehyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 10:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzA26jMVqN5h2d07fiAjm5kPURJVIlZQbeHOEb1AndHCSNx0YZMrObMRgPLjRZ9Zm61LBnDGfMDv1vAGg1EqkmPrK05X9Of8xR3AtgtqcUHvJut3oQKhxaihMC8jHrpKnJpwhYYKqzhq8ukoRh9JH8OFlfvVqerpSOetgL10LBx52Kbk+6gaT+o4Y6dqPz0rFs01crXvSUbTlTf2IkGvCrYP+z+ndkMKf5vrZ5Vh69esUyCHq3pfyCD3roI7rnQ8OM5DIAgMpembKYFtei37LQO/4D132BTgdxu8C+gogA4EVtJXDLAqEf1nX1ouP2wi5rKUqDi0H5BPlayU6lYE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SNiAbRqMviWXgHYTwI48cIj17Q9+rw2Y4El6Zq362w=;
 b=UzEdb2klp0/udEPwi85VM1jINGAqsDCdrz5t0/fwSc/rV9rpIFjYpTS0gOHRSnahNm6Hit1QcyaD08PVF07K5muRMne07XalxWb4hTQcRva+s3qzlZCUij2tnIJGOH4dZ6PJ+KQs6FQVbBf2rNia6KniDQu4B5VQvTsj8pNav8AqaYPenuO32gs6UAh1whSZQ+nBVdget2lRbi61TMM9ImcLsb/Et4VxrTA/mQbdy+I58lLpWNzWmK6sUNjXSOovzi5qwqsEs/G3GlxZvRG/VzDNaOg/sU3ZjmRCiUlAXJQa9ezvslk02l45L364GOnUSPD2Er4az6pTr2hpUCO9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SNiAbRqMviWXgHYTwI48cIj17Q9+rw2Y4El6Zq362w=;
 b=WavkKVjg4njJBpQWl9Xq9v7FID4vbY+niJ6Ce00lgKuKsp0gK15Fo6u/4p5yLErhW3zBu6UcDPdh5rzU0Vf8S0I7rmbfR3DYOtk/ZOp2paaUg3wC9dFjQGUsOF1g1wsAhv3NpLw7+TcMzOO62D5z275HuXVOSpOBXzwNSJpvaaU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB7545.namprd10.prod.outlook.com (2603:10b6:208:491::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 10:11:06 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 10:11:05 +0000
Message-ID: <03e4a92e-ccf7-4659-b9be-6530158b4cfa@oracle.com>
Date: Mon, 26 Feb 2024 10:10:59 +0000
Subject: Re: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
 iommufd_device_get_hw_capabilities()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-2-joao.m.martins@oracle.com>
 <SJ0PR11MB6744CF6315A3BD4906C115F8925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744CF6315A3BD4906C115F8925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0249.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b47720-c92a-48b4-7c4f-08dc36b33e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LFzqVEAuOL+qpCohFkSsLjtuuOxgzFN8tnPJbnrI0djkPE4o8SOrpM58Wph2b1kDaEE9S5kTTyy3LYEvBbndH9VVYc5EGEfTZ3Z0Vd5LhCPo2pvsd/q2hXGf1Ww6n2v1IfGw5r83bHz6psY+2pQvVd0ZKcJX3Jm/HpAg52oalj8v+4pXp54IEcq5uEuoLTtCp1XeQDqT/WKvTFSn6nDvA/qyLeJkDDeF/1wxexKmxgOF6Vkv+xnGJpKEdBksWTVokqDN3GteyvubdQVZSTR0dtTUymWXSEACo897qOCjEJvUPoV7/ld78vvsfI4M1DyRSjgLwlFOe1wW3bNEbb1KgG3/Qkxwpcii/qBbUO6LBYFT9hn0g1+HlyE8PIN0Lb8+2T677QBx4H+/3NHCUlj55f6iOT2U4KtQDEyAUpMj6YS6w/v2X3fW4SFxXiRrJ8kgWQwMvZY5hAD+ldj8c4P1hHN8ST0zl8YMsb4r7/oortdnU3tQ7C6rCJoplJigJHbKLdcf8Z2+huJTcb42GiULOfImazcuB+c+RWky4oN5VlM1p13YJ1Vj/6rCTCKleDgoGVOM9Qw7nd5AuJcg1+Z0JChPt2ZoDmlfLuOdW1LUmjzm5kVK211tRLtXj3mDE5o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpzSE1MU1o4VFNlRDZOdGlYVmdEMnBsaGo3OFNtZDU0b2V3UGlXNFRScVVJ?=
 =?utf-8?B?RVZxVks2dGRIaXlFa0wrQ0J6OG9wMkxEZnR4cTRZOExUOTlUNVplUnN5cXJu?=
 =?utf-8?B?M0JzdTBlZ3BEbDNiUDBmUjVKUW5OMGxZN2ZvNnlxemx2dDFweUVsRlpBSUhp?=
 =?utf-8?B?RnZJVllqc3dyYTgwa1dJdUtqTitzbW5YMDBHdENzcmlyK3hYNmRienhGVU9F?=
 =?utf-8?B?ZHRraDJjc2FWVC9KcUdCbXRMeUlBWXhiWjdES1o1aTJjcFZYWktQaWFJd29F?=
 =?utf-8?B?K01UQkJtMDc3T3kvNy95RE9aUDhNaEtGVUYzTDNFRVlNTjF4ZGNwakdqL0Fv?=
 =?utf-8?B?bk5MN1B1d0JWQTVTdmtCdDZVblppa1lvUGpXMnFLNDlrWXc4UERGdFRSOWhi?=
 =?utf-8?B?QWZ3QnJXSExaUzdHV0FYWkYweG9obE9uTnJ4WmlNK1k0VmJIdFlkWmJ2R2pD?=
 =?utf-8?B?YlVoL1BaOW5MV3pCekFqQ3RKdWZsZHNoK0FsMEl4d1UzUmJlaTJ6WnplNVJy?=
 =?utf-8?B?SXpRUm41eVd2RDBDNXI1Y2huZnVMTjN6bHV5NG0wbytiYkIzUHMxcEdFU3pH?=
 =?utf-8?B?ZlNhbEl3Z1BpTlJjTFZ1dUJ6SjVsRm1vd2Y3TWRHdms5c3lTaWViZGtKemUx?=
 =?utf-8?B?SDhvazRRR0huZEZvZVBwUmF5aFF6dHpSYnc0ZzJLTkxSeUdBclVMNHVBVzJK?=
 =?utf-8?B?czNteXlrK3U4NFFxaUxWa0hXOHgzQldMNUw5THg2QytIOUdBRnJDSEIwa09K?=
 =?utf-8?B?a0VPdHQ1bXN2YWtBZkE5VHBTamRQUm9lOWpPV2JwUjZ4NExlMzlScWFKOU1v?=
 =?utf-8?B?YmJoL1BsWDB6OHF0RnR0OGIrNXA1d0t6dG1RdG9EWlZLNFE3U2NvdTVCanlx?=
 =?utf-8?B?LzRKVEFrb1RXTXpib1NQdDNlc2FELzNJZXZvS0k2OGEwSXFDaUFzV2Y5Zlhi?=
 =?utf-8?B?cmtCVXNMSFYxTC9MeVM5V0tjQS9waGZScVJ0NjBHY0E5czB4YjZZekFuS3kw?=
 =?utf-8?B?bzNzY0FSa1FMYWNEakQyYTlEV1Iyd0kyVHRSVmZvbWE1K2lXVDdhRjJFbWpM?=
 =?utf-8?B?d3pFMVN1azVPdEhBMG5WU0ZPUllLWWlGSWtSa2dGYldBdjl3Nmt5YnVtN2E3?=
 =?utf-8?B?em14ZDAvbFpMcWhMb0Ftb21MRTMyWkczSUh0UUNHZHZHWUxKZHpkVFlGRW4y?=
 =?utf-8?B?S1VuK2JEUmhnUWxnbjgzN0paNHU2NjlrSWdkeXVpVkJlNUJadG5LSjVHcllR?=
 =?utf-8?B?dU1LSnB4b0o1Q0psNnUrNDBjdk52bzl2NlRzQU9xSDhBQzVCNTZoYjlTdlRY?=
 =?utf-8?B?OVpncTM1eDEwbDdOSVBpMjlpdzltbmwvejl3YVk3Yld6czVRZmprUHhaVFlU?=
 =?utf-8?B?eFJOMGRuL3RsVC9TRjNWNmVvTTNSTjh2eHZ0Znd5ZVVSS0cwK0JRWmpaSjRK?=
 =?utf-8?B?R05TY3MvUFRZMmRVc0tHcmd5eW5ORWdTZndYUVUycW5kd0FKSkIxTlRZU0tH?=
 =?utf-8?B?OFNuazRtY0ZiN3BJSmhsTjNXTlNhWFZGVzdFcDhNN2hwanRDcTVLQi9ScVlx?=
 =?utf-8?B?Q0tpY1JTUEUzaEEwZlNGMWFaVTFGdkoyYThpckpsL3ROOVVMZUJ0NE9sVWsz?=
 =?utf-8?B?dVM0Z0hGTVlNVEJYZkswbEEwVHlqTUtUNENjK3JYSStRRStHc08wRmZvMW1C?=
 =?utf-8?B?SGtDRnc0WnBNR2hxZTZoZGdNdEJ3U0g2NG5qd0tHWjFmeEdjY3BYSnZWUkFG?=
 =?utf-8?B?djQ2N1ZDT0FDc3lwb25WdkJyQ2QvSDB0eG0wOXNVM3FwWTJiOVZabkhRZFJY?=
 =?utf-8?B?NVUrcFVjYktHZjNEYzk1aCt0Wk1XcFJqTnM4R1gycHluR2RNUytZekpSUmdG?=
 =?utf-8?B?SWhRUkgxdTdwV1FxSVFieVhnTzcwekZSZ2lRNnhMZGdkdnpMa2l2V0FFVDdk?=
 =?utf-8?B?RElTb2kxK2tMUGhvNGRXaHhnNWdzZmhXSExkRFpTVFdQREsvNnJVaUFzV0Fr?=
 =?utf-8?B?WDBHdng3eDhla3AreDRCRFlJbUZLQ2pLVU1XZHFiVmk0dVBXMmNLV21IQmli?=
 =?utf-8?B?SExOWU5aTXVOSUhiVExVMGVCY1VqWGdLWkdqbUJPV3RVMlQrcG5CenRQL0w3?=
 =?utf-8?B?TTU3K0ttb0R2cXVxUFhkUFVBb0FJbXcxRkI0U0xaeGx1eERjcWs3emlRaHNu?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cL6DIsUEIkXy0+h9nBY4jCe/CbKCgKLJIUfQ4epGnZhGTu7oY40nIrXvCOcsRiPXW43IzkgGru3XrQoCmJS6v1O08T40F0HkemCcYmNaXr7LyZ2Jh3cFeMsRYEHp0U5KAIFfdX1FmQ//da/4dLBD5O5biJwZ+DBAz7FVXFcY+QXIsfymadUdJHjC7efnRM5L9sfMnsPXQgJY8tmxO7FOEX3T3ByBn4RBRy5k4Y55jEBBKaKWdW7MBy4yGjfRU6M/QXEOrIAdLCfmuNTtBH5UhSQaDHEi1v0If8pyh8wACMFuX8SzhB8OwOdDEEVIgPJ9Z+N4jIzYmnjlK12mIoUAInFj2dZZH+R3hH2SgD5EJBXmqNZ038HTmafxYYV8aE+WurLjwFDC60+M+gRdVf9uIUAHQqsbYiWXpPD8uCQhgVUKJ9xZkISm5ZBvOKhGM62mz1wy1wNNYL9TgyTqCgI1nyLDshGJrBc76m1bz5G6HKjU4T0uSHUhVRIOBqzX4AFd+IIND7CzNyLdgm6EC+rf9hD00KnxLACO0opKRL2+XUKohI2ND3Fnt9YABxj+4Poo+lIxiq0esSA8aTSYlmLjJ36d2kKTVu8r/XIo+Muzfg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b47720-c92a-48b4-7c4f-08dc36b33e77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 10:11:05.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmMdP65pHrmJfNShmvHcoung9snI9tvLU6DWeOS384BDBrhVGKLnnRMaGhmE+zsO2kyHouArUDAH13w4BJvXHWQbduAglgq7bwa8esfqH9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260076
X-Proofpoint-GUID: La2g3ZbVEL_hYP45uc-OK2NEsGxd_ANU
X-Proofpoint-ORIG-GUID: La2g3ZbVEL_hYP45uc-OK2NEsGxd_ANU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 26/02/2024 07:29, Duan, Zhenzhong wrote:
> Hi Joao,
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
>> iommufd_device_get_hw_capabilities()
>>
>> The new helper will fetch vendor agnostic IOMMU capabilities supported
>> both by hardware and software. Right now it is only iommu dirty
>> tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> backends/iommufd.c       | 25 +++++++++++++++++++++++++
>> include/sysemu/iommufd.h |  2 ++
>> 2 files changed, 27 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index d92791bba935..8486894f1b3f 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -237,3 +237,28 @@ void iommufd_device_init(IOMMUFDDevice *idev)
>>     host_iommu_base_device_init(&idev->base, HID_IOMMUFD,
>>                                 sizeof(IOMMUFDDevice));
>> }
>> +
>> +int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t
>> *caps,
>> +                                       Error **errp)
>> +{
>> +    struct iommu_hw_info info = {
>> +        .size = sizeof(info),
>> +        .flags = 0,
>> +        .dev_id = idev->devid,
>> +        .data_len = 0,
>> +        .__reserved = 0,
>> +        .data_uptr = 0,
>> +        .out_capabilities = 0,
>> +    };
>> +    int ret;
>> +
>> +    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno,
>> +                         "Failed to get hardware info capabilities");
>> +    } else {
>> +        *caps = info.out_capabilities;
>> +    }
>> +
>> +    return ret;
>> +}
> 
> This helper is redundant with https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00031.html
> We have to get other elements in info in nesting series, so mind using that helper
> Instead to avoid redundancy? I can move that patch ahead for your usage.
> 

Sure.

Btw, speaking of which. You series could actually be split into two. One for
iommufd device abstraction part (patch 00-09) and another for the nesting bits
(10-18). FWIW this series here as submitted was actually just placing it on top
of the iommufd device abstraction

I am still planning on adding this same helper, probably just calling into
yours. Mostly because I disregard the data/data-size as I am only interested in
vendor agnostic capabilities.

> Thanks
> Zhenzhong
> 
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index c3f346976039..4afe97307dbe 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -47,4 +47,6 @@ typedef struct IOMMUFDDevice {
>> } IOMMUFDDevice;
>>
>> void iommufd_device_init(IOMMUFDDevice *idev);
>> +int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t
>> *caps,
>> +                                       Error **errp);
>> #endif
>> --
>> 2.39.3
> 


