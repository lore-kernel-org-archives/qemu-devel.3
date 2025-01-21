Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B571C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 22:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taN8m-000053-6A; Tue, 21 Jan 2025 17:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taN8k-0008WE-Kk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 17:54:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taN8j-0001Wv-2r
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 17:54:34 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJJpJt025758;
 Tue, 21 Jan 2025 22:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2JebKhSaeSsCDp5vm3YQQekzOPweuydSZzr5zMP6Vj0=; b=
 YZplHiQN+dJs0sQ1wzZ4w223jOHaLpcEP0K1Vy9WKVlH5+H/L/lsvdluVkqnrid2
 wAlpqD4vdMHje7P6pEz7MxMTf8bze8i7G29vq7tuggmzB0TNXaYU7SRYJERj4a9D
 5wgb6MS57Jk9Gs+brSXjZkTI8AdDymGAsL0hH3z6lmYqj5jLV3oVD+XBaa55X9Vh
 /xz1P1W9Achd+wqjUvdWW4MEjla7NPiYnJF8Par429fJ4BxFDardgSdzsOjCgdlI
 0gMnuGcPS9AkDr0mnylx2SV7DGAE448LfOuz2osfJ5bSudWdVWSWFFkTBNoKEUgG
 SzVCY16LT205ZPNAQ5IqaA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkxje2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 22:54:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LMUKTb030388; Tue, 21 Jan 2025 22:54:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491fjem4e-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 22:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch3hkRQNk9BNhLyp8olMDuQzEFegnBjZanSrfFYqfFPB201R8KXCYtGA1z6p/n9c+iPbYgstMSzS4aLsbd0JzDtqrob/qlVqganTeRy5aZW1mBsvGVzHMoDWr/KZPHPNiE0hsxmJCDoashJLfugJwIxEZKM87XnYNQ0CFw/c7DBJ9FUz4BJRqI35U96NUor6eOsjs06TqhLx4GsHGALUvwX3Jkp6ifE3cwtBtttk8q9nh49yAY2/28e4dWVSRjYpQcLxpb2vzrB//Q3FCsUUSstPn1OPSGOepMoL9YIptrURSRZ2FK6TBWLwLD8Adu15yHCBvxu/V9Y8SAgERVTxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JebKhSaeSsCDp5vm3YQQekzOPweuydSZzr5zMP6Vj0=;
 b=XheoNon1HitBUhI4+KbsR/QsXd7Gtl6bYO2XZaejUnkCJCEo8I6cGUopq3RR+si202XNj02PCh75i/n4s0VIev6VmYus/Tnb6+UN2K1fsFn7QRv0tCRMPSHuOvrh2xvdRs3dv2IU02QoDMih/cgvhiFnwKNO0HmxmMpt0hyHtUiEJuiQmLFP/M+ki+5Me7btHn5OhTnzuSUAQv83J6Ge70y6CRJgUGwgbm9WwsX987aUk8Fm3sC+1wt0Hb4i9YqV+f/4eTzndmOWxxmBQVSEFNcTRX3Jugk/Y00ELxh9p6sMw7PIJctG6uwugYO34iJWiJijUDzZoC2YKq6HgtlNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JebKhSaeSsCDp5vm3YQQekzOPweuydSZzr5zMP6Vj0=;
 b=s5D/Us/yoCWqWBKEaJSRIc4n1znADhPisj2nknpPnEYRxV7zk5roo6bLEDWlz6T12qqyx5P6jPPL3Fm+nAUi5ftEzFf1IARuAL5Muqpv5uM0ChnFqdecfSBepzPsTK20mZQarrhFN+AkRm5bk3Q62Wh1wkJFTkJEOViwgDGDShM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 22:54:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 22:54:29 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@linaro.org
Cc: william.roche@oracle.com
Subject: [PATCH v2 1/1] system/physmem: take into account fd_offset for file
 fallocate
Date: Tue, 21 Jan 2025 22:54:26 +0000
Message-ID: <20250121225426.3043160-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121225426.3043160-1-william.roche@oracle.com>
References: <20250121225426.3043160-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:207:3c::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f57127-73da-4f3d-0e26-08dd3a6e8fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gUZgc2GpG+hC/1EzlGup0OZGca9IjCvUI2kCoE8Z+1v/iI7GwSKVEw+bPB5l?=
 =?us-ascii?Q?kYmBny/BBqC+2pOs6yEEB+xqUVDHgUdLhwhpPGqg0VE2LaKd5TTqs4kwe+33?=
 =?us-ascii?Q?k/gpWx+yXUMk3wHvmO2OeuCDHAdZ6+NllpysJN/GV8+BKNzhmi6Kc+Z/R/FT?=
 =?us-ascii?Q?b5Gr82v/AkrdNYEAx399G2nTh1HuQAizMl1eneKu4MIa0hVOBR44paCS6TtM?=
 =?us-ascii?Q?BZEV7sYdzZF6/mNECGzTMR9I3VhfVdj4mtFmspYeQNL3yCHUo+8ySluukKt6?=
 =?us-ascii?Q?ebJR/AiNo/0hPbEOaKFsktDIdd1CZQWdHXvPRFArKRZr7NUipEu8doQ2RsAR?=
 =?us-ascii?Q?HDJy61XXPPOtNipGB2mCdQkGcioH2AOC17MfAz1UJJc7y8d/yR283iFsPYXc?=
 =?us-ascii?Q?bHpLmHnWA3+iuJ23GPKSP+1WvcGvgrgHdsBW2e1slEOZvhwPCBTwcZcB8ADL?=
 =?us-ascii?Q?c30ztZajEtWLZjUfSj9dwa6Qg08O0WdUJQ0iaAizuqlGfQWzOQLwV3EFZ/7/?=
 =?us-ascii?Q?pUguFfa7wEj0wz4idI9aubYvjVYFJIBPlyK5M8kG5TgzdNV6Gcgf7DqD4NFS?=
 =?us-ascii?Q?PtpU7UKqPatmR59QKZNCh8LGphdfqnXR+T9oBwrSyS2IWZoWTUcGvYo9p05L?=
 =?us-ascii?Q?G+wYi5DePzXoYYiv9hN0FYvrd0RyGC2sz9PnBttiSjViWxWCUf4WkANCv+Fw?=
 =?us-ascii?Q?2h4Y5GQGLBC4OhIzgqgfNADzxiWjjg88mKzPDD3v4kVsclvWYA6ZZ0pOpLIo?=
 =?us-ascii?Q?Luf1bMYT5xB4AEXiKz4IkYyUW0FIW0SbDxINUI6IAr29DlnYXReyr0Wlu2Yv?=
 =?us-ascii?Q?XfpART/M5HS25QiAMJzQgAu2YXNt6hYlWcoN2Yg2y1koXRwcdfHyegmKPVGV?=
 =?us-ascii?Q?ceWj84wlDcfU25QM5dxq7CbHsNZDc69JKiKbZtL5shCo/AKq4bry1azrcfkc?=
 =?us-ascii?Q?20U1I5f+bopbR9FIin6jNyV0R2e1RRCsqfC1eneAn9os0tsTYOVxP77K0iKF?=
 =?us-ascii?Q?QP8Jk/75ryAWm+iHa4oVYgZ1kvXIuRXptOdewykPwNcQztEh39oQT6QOYdaV?=
 =?us-ascii?Q?YpL176i8fERaGzh7hALpYS/MEjAYpVzFzROFXwqHf9ISIlyj2G5ulfASqXhk?=
 =?us-ascii?Q?0CDM3dP09YpDzC5BYFUveMHCZF36YT93yV7X1OzNVIgk6PCKsAmQLxidewhM?=
 =?us-ascii?Q?T5DPWQqVR3cssHeI3xCgB0qZfRzlRv8vBIoRY66oSw8poHKr4IzKamqvFyVh?=
 =?us-ascii?Q?D/ZnOsYMU/ZfSRPk8i8HNUUmbAAPzNcIVRfopOvxubYY4VVMISen+4AS8KNX?=
 =?us-ascii?Q?SrGLsxV8rVvXLpNGVVJ1ktyKloZOBYRQwo7XlEml9bgCuVCaORJFIJ8Pm5pb?=
 =?us-ascii?Q?mMx0LdNz7wPdLvMFZgkt/ag3Mi+7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6jPHzv/XLuHaliPO2yJ19pEjLn3Djt9yGHLyBMVr0MWQmUeQDelZf9XCQyl?=
 =?us-ascii?Q?Zk2EztnjNl+tbaL8pMHtJ9BPlxCkIvjrQOqmp1BAukMYiwTxhBaFOAC7tXLM?=
 =?us-ascii?Q?xeC/oa2SkmbjLmdBwz2JqESt9o38aHWMBHugZZPqmNd1OL9r56DIQb67W+uJ?=
 =?us-ascii?Q?r7sPnW1JT7MuTItrOoK5Q5NX9GCOuNmYjgeII9foDnaqoXyD0QwFNvkHCcPi?=
 =?us-ascii?Q?M6yJob1bVYWePdXnNbighXfJEoKWNHeg0dZy6Zw0SiDTvSxcjg2LFPWwcf/s?=
 =?us-ascii?Q?HMVPXHwQK5ofQWMyyZUB0xQJKUBja6wh3hVSheJ1HnOmusl5tfTxGgIYl59y?=
 =?us-ascii?Q?md7LK9MJ+WRR1EPDolIWnfN6zw5FEfiGeQtT4w3GqWSAAaK0yqNr3Hh/pNsu?=
 =?us-ascii?Q?0Czs1GX7Z9ae24+1Lcwpzxhm3+ZOGwT0WMGooLOCxTZFkRkRz5Tz7WjqwHN5?=
 =?us-ascii?Q?GVMnAcR6I/8jJ/1qhZN/bIIxby6vM6baI3bC4KS+ryRXQtTnpQi3i5Y+gvFN?=
 =?us-ascii?Q?FhYu9qxqmTHZ38jTGG4dXcgzQvqccZdpoFl0zB819WoNYyAzV/ukPdDATmNy?=
 =?us-ascii?Q?z6k4gCYOgp9BBB3PGNbJ7PrBuBMYrp9QB1Sq1n1SSaO3vcmEsmEGDmB1fiFH?=
 =?us-ascii?Q?hlPrmCT4buIvGuNMd4kADW3t1271/dSgQ4O2HJn2471gkGqbDnlWdzYm5cer?=
 =?us-ascii?Q?RtMlZ+8WhcN/urGA+rwCctTJrD3RjUrVRR9OlksJB0J1HTZDcZD0TgViuCQZ?=
 =?us-ascii?Q?Wyoso1Zkg8rfQe/YTZXXLLoc1TD+Cg/S73OoRxY8aRDcms5fFNG08PennvUS?=
 =?us-ascii?Q?Tks0p/KLnB8oXUrsxRvW3h/rJEUIpn5AQBIADtUQye0p42iYSwTtLJWI2dCG?=
 =?us-ascii?Q?b571JfOVAPH7dXg1rXObakVcMvnJEVTguMYb6FtPeIF61R8SdXNzv6a/DtgJ?=
 =?us-ascii?Q?ohHO6PlXn2pPEFpAberqkZqisGw6MV6uULe5AKyLhQ0XkMOi/zQI0vLivrk5?=
 =?us-ascii?Q?kqHTMLdlrGq7Xrs3tyYF/P0DXW4GKa742a5kAyUG7hJgYENEJzoU4ime8lpF?=
 =?us-ascii?Q?PEMRW8wrdvzwN3PTBtogA7Ij+QdLtc1TNhMwMFJ4ElwivmmAkE50+YG3cb7G?=
 =?us-ascii?Q?Z/HO4QtTNmp3AulYzFxRtNQ2keRe0V61E1ey2r64JUdyZXjeBIsAt2/vFHPg?=
 =?us-ascii?Q?awDUCjy2jvG+ZOpswsQn1Yc3K05nu/pBeZs2qRL6CmI4ok8LEcR9QcwDa47U?=
 =?us-ascii?Q?Q1hfd5Aqdiu8QFE9XC6hRIHdRcjk9muSbsPzGBHxFutQutLeLtNEfYTGtqgw?=
 =?us-ascii?Q?CpIyItxNV7oFXSz8V9xK1y+V3XLHvqCs7EPHQUqmL67VuQXFXRqaFWELm7Ru?=
 =?us-ascii?Q?Ray+LuEroG8OeDKwfCp1Kvd2PNb6+jOtxEfzMu5fg22Mfpmky+n2Vy5Wk0iA?=
 =?us-ascii?Q?a/0rIhCzfz/qgEOsu9OWWanOKpV+O7M7mFred+eoYe1LMkDdD0d0jfgfuWmC?=
 =?us-ascii?Q?JLnKqW+zjFdqWRnMo9ERHAYP3l/8W5soqpAoo8D3iDs5XsIOccF5MwaXsWvj?=
 =?us-ascii?Q?Z8IXa2SS/4Y1hgmXgqdO+RC88D6ZSHDBhFodbP5bT/OjY/Rhfn4+B+Kkx1Pg?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LVoe83vtNjC22t6jN6SvghPerqrKJ2qPCKMfbFWjRbLPvLKcaI0DLkQjF9E6FmtGAKXz2Ppci5pjA2VjixzKbpFKS9nkV5qfY8P5rNxqeI/3WMtc4y4/dYl6jFBP9h1sVbscvAqVjTP7whD/r/D0EDe/EDT4Hwti4YZiVr+xdVREmGPKNpQvQo26IOvHLChgm5uyBpqXGWaGaS/Ng92QKpjikcS0m8N9EG8MlH0GhRZNZJYOGJg5Ic8as1NxJCgOXDA36B2Np63pj7uwHQXGOsRtUzx+L4oQsotmyLgnjWE2FGyWu3+IW+J60fNPG2+TAsKiAC5/y9a/FzcfBsHr4UdtyyhSLvNENCSuR/8uuPKcm8duvEFBPR6JPGrOQJX9uqmWEXBzGyMGIZYtU/q7/K2UUqI/AucPvmqAxUtIAycjQDtCkRIFbobc7iyu/ME4fvdFMb2WX1bzEq1ivNe2MhFXUF36EFswAGkmJx9RQR/gTQrPC23nIL+7N2FR0srI9jW2WLY7F97ZP+K5ciIkKhzYRZ/Ymx9KURLvxWavKrmxK3Di+5KKxaHRPDuaOdqy9+5U9XpU4e3F9ttjF3zDBd6eTd4pZAKMJ4lGQka19pg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f57127-73da-4f3d-0e26-08dd3a6e8fbc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 22:54:29.0094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrTbpd+8Eo8UUho4LBWOSKZc6H3+JslM3oA17pL1tyk5gR/scWAhq3DuthtOapdWU7TRwMhXXdwq15VoxSCVZ3LYZKDh6Xz49dxZf6pyq7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_09,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210182
X-Proofpoint-GUID: cwmjZwPj7SkyGmF-bs72C-rHF6x5fh7l
X-Proofpoint-ORIG-GUID: cwmjZwPj7SkyGmF-bs72C-rHF6x5fh7l
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: William Roche <william.roche@oracle.com>

Punching a hole in a file with fallocate needs to take into account the
fd_offset value for a correct file location.
But guest_memfd internal use doesn't currently consider fd_offset.

Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..7e4da79311 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3655,6 +3655,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
         need_madvise = (rb->page_size == qemu_real_host_page_size());
         need_fallocate = rb->fd != -1;
         if (need_fallocate) {
+            uint64_t file_offset = start + rb->fd_offset;
             /* For a file, this causes the area of the file to be zero'd
              * if read, and for hugetlbfs also causes it to be unmapped
              * so a userfault will trigger.
@@ -3689,18 +3690,18 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                            start, length);
+                            file_offset, length);
             if (ret) {
                 ret = -errno;
                 error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                             __func__, rb->idstr, file_offset, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
             error_report("%s: fallocate not available/file"
                          "%s:%" PRIx64 " +%zx (%d)",
-                         __func__, rb->idstr, start, length, ret);
+                         __func__, rb->idstr, file_offset, length, ret);
             goto err;
 #endif
         }
@@ -3747,6 +3748,7 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
     int ret = -1;
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    /* ignore fd_offset with guest_memfd */
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     start, length);
 
-- 
2.43.5


