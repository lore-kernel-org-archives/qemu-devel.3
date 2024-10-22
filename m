Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D61CDD0FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MXK-0004yw-SQ; Tue, 22 Oct 2024 17:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t3MXG-0004wp-BO; Tue, 22 Oct 2024 17:35:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t3MXD-0006j9-Pj; Tue, 22 Oct 2024 17:35:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQbop009989;
 Tue, 22 Oct 2024 21:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QjLdDOzpyzpQar1dq4jBorEfxd3CpWKsJJV3wEsSNXc=; b=
 a/Hj0kcRKIKbqjY58WtvKu+gjd8diyUkBJ7efsVTV7XYhQVUnKM8sy+FbQzPbDiA
 TdAJ4gWJC8ULTE1fpKy6qi8o6RmKGcsoyHKzihINeJ9JYoGnim4ax9ZPmK6nxqd+
 lATk2+iIUyXmDjmy9OkSrdR5xAiWHTxSOeivsVkEHcDZXY1VzWm/XGn0T5HDiihC
 K1PDP+zm+5rJL/PqIBPS2WAueweA7MshIqVbE/iQmjECvDQCe7Pgz63uSjwwLjKF
 SdGzfyCeeF/kZgvLGrJOa/a1XSnVU00Hz1swEmUMSoKOMbifnB42sUx+J5U2Fzu0
 OtiaFhxJmSDNXBSN//K+Rw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uxr04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 21:35:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49ML4swK020265; Tue, 22 Oct 2024 21:35:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42c37egyk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 21:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kySt6/0Wb9r88wQK7c6YRn7zGGSxQADcXespadkFEuoMpJ5b22caxGCvKwOSftJOMkHIgCnPTPNsy1nQRvDs0r/GCuPrDYWZpZ9DGzrrGEm6hreWYK2VEN+afO2l48rPB7pQ7INNto52BYPDrykCMUJcDEQQoPQa8o81lVVLoGwwfpFnwMXAjTqE6s8Hao/GtzE7veJyzRE0tnTnLto+SIIef0YsZDwgXsMgccwfVBB9+vMBkoV9KZqeBWTUWNBVvXlzf4KgcQ/kJjlt1sCXazKReRWnW7KouAVNFyub9bUPOK3Ins+uhqiINpqedVRsfCV0ld33/i/YwCdeb9yKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjLdDOzpyzpQar1dq4jBorEfxd3CpWKsJJV3wEsSNXc=;
 b=xkYEuYLlg3dyKI6e5ASTXnDgW/hhP37nPmDG8jwaYrIVufftJejGfUEY5hmBq/QrEKrbVJU+mY1R2mKe1qSecFsFnO6eO4E0oGaJNG7QAuanqgYt+DW3XjKRu3lqoryDIQN6f5MO9z2mJd+ZnKndQ8K02mDwofXGuFRBKz+dKZSQ280lQYwmiR86RbxMLh6RyLok7npFYHAwK0nQ2kxyauTHaYolqJgakI8TqGUQ+LXnkLxEokpcGudGKmH8/u4i5bz37PkaJBxLOG9FuW/C/402ekterQJetxt4AngtvQ4IvxHvFDTBcJYzLOvsyMSoW39zSqiJocxHzn7CdvB2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjLdDOzpyzpQar1dq4jBorEfxd3CpWKsJJV3wEsSNXc=;
 b=cH0ZPQcZz87BUrc5TDgzQcymFzJlCDqAIs5Q6Fa+qNd/Y4zufr+qCiHNgxTaRzaaE2mBGKIdsTkWD0G7nQPUZRjC/5FhHrlsmBNUWLuxwsW5TSEG7ZvcfQNDB7s1EG34xOXMF338S30MEDpMWwbxNhQn3SH6d5WA/8ucbH8L3f0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 21:35:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 21:35:14 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: peterx@redhat.com, david@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [PATCH v1 2/4] accel/kvm: Keep track of the HWPoisonPage page_size
Date: Tue, 22 Oct 2024 21:35:01 +0000
Message-ID: <20241022213503.1189954-3-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022213503.1189954-1-william.roche@oracle.com>
References: <ZwalK7Dq_cf-EA_0@x1n>
 <20241022213503.1189954-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:408:80::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: f041383e-1884-4edd-5f39-08dcf2e16a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FWvpEBaHP0t/eIk0LwXTCONH4Q1TmBBmjm958RyTKGbztMJImQ3lPQYTEOVf?=
 =?us-ascii?Q?opLSu5KTcYvzenPDSvvpmb3ARbOaAIzTSooLhTBVto2S064j3mLG/Jb3KTCv?=
 =?us-ascii?Q?BVQOJTnmHXgun917XXfKVADHePFWftp4XUCzWMBt1qBH1ixbeS+jVQByJzBC?=
 =?us-ascii?Q?GZn2czA1v+pbTEtalDf3hcsIOwuyRJkESX24UPZENZhtVymT+lNTM3+2ME6S?=
 =?us-ascii?Q?CUuH5SSY1/JO5LNs/uAyQAQfj+jgQb43ojT9lkkAc6qvj/3TzyWaoHuL9gSe?=
 =?us-ascii?Q?+MNooXR8JA3QXAGxkJ7V1cBg+Fpsm3Psf6GzfGURIcwOWXvMkuKAPc6WK1kD?=
 =?us-ascii?Q?WFvcsZNcy8IJrpZwGM1conBSrtdZJ1rx66fIspH3f3Ax0c737W2kKewlZo8j?=
 =?us-ascii?Q?ik8yZp/Mt3Jp7+ElR0p4iOY58q4+dK/9L+SSW8zOhA7E9nYqkFi+SXVE9/Xo?=
 =?us-ascii?Q?fhjJIfpz41rMO/oDCF84mFQALcbUG7ohmZDEqeVDXcLKtuuEz7i4aocwDN1j?=
 =?us-ascii?Q?uoq1+8iRCwG2yVAdPPVhHL2InHnm6HrOTuRMAWiaYLPTIwrPGj/qHykIiTac?=
 =?us-ascii?Q?9ZvDjqjA1xn9MnSmzbGLV4oNXP7AcTcWFV4FMnF4tDUat4+/GtymSHeuU4R3?=
 =?us-ascii?Q?OV80SMD4BDT30NXmAczlIFluahEAqCaRrTXo1pH5wOpiq8r6tYbSZM8q014d?=
 =?us-ascii?Q?xLNsPgdNxCygg8jb8y8pDjGSgcaXFrmo+WYM5j3PiOSLY4q0n8yrRKBg19Wu?=
 =?us-ascii?Q?PW5qt+6nMHSxUe2abTaJOO6ax4X25tGEf7DoENpZ2Lt79rMzH+UCK2XTMR1m?=
 =?us-ascii?Q?sMEtBiJlQAkU6WH8J3fG4iWekhg8S1LxHkXjDi8DyW1Pl3RzpYhXBaJ3hCkM?=
 =?us-ascii?Q?BirfJMHrU4fqDuHlRdZqOrZucBW/eoWq0HCiuWlYOyYIRjb3lXm1mCGDk8Da?=
 =?us-ascii?Q?AXysv25wTN0qXT4AcBYBsM4rF+Jsjp0s4olGfEaYUkF9zgYGhSotjMPreWNm?=
 =?us-ascii?Q?h6/kRlzw5gz1bXzp6SPCN64A8dQF99zvkflqpBISZ1zYLE9Sa6U5vCZPzlzZ?=
 =?us-ascii?Q?ZpFhQa+9Zv4/sifoKbDAMpnnmK/ye6i3StiQ3Cu1r1xHHX3IfYrfZE6K3l6A?=
 =?us-ascii?Q?SUXLJ9nfnp1bGXE3gOaJ/eIf3fllj8vgXB2F5C5Dxaw1aJjzxBw5hF5yzGW/?=
 =?us-ascii?Q?yFnTMxyvXTvRoaD+0g+i+5b/Ah4OvluAOb0AhI4c8VMcfeyCqKOHhhHKGWPe?=
 =?us-ascii?Q?lMtz24a/m/CxMCgougiO13Sz0ycYKEHY3vM/PkJapTb3+wnYDPMOWCJCyBkP?=
 =?us-ascii?Q?8qkVPDOhzp+tSpvDkCzIqwIRVzJyQCACToB8Fo7XYIswMlJBI6WIrK27Rmls?=
 =?us-ascii?Q?VjNlei8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llOAdOaaA/+YJsSjLxm83wEwn0hM/YZSZ0ERtjWcmrPHWhf4HnewKxHgg3wZ?=
 =?us-ascii?Q?3ZN0Njaguodf1Bk1Usmy/V7n7aF+cKTXAE87IZAJkIM7v3elbXmxzl6QxT+1?=
 =?us-ascii?Q?ofmcsoLgTMr2QG/HKvhS/kJ9LrQ3pNdUxMFJmI53witQUUH8ZCSZUrqpjiHX?=
 =?us-ascii?Q?Ngcc9t56hoQakT7EulW5iZ9KZHmIBohN5JVhVjBzn9HupLSfpH39DYUq+bzU?=
 =?us-ascii?Q?NKkzVpq0JzIRurgt1og8HVC3KWKIgHT9jhPxAAmz865QUzmQ2iCijp27oQf8?=
 =?us-ascii?Q?w+96pRxiyMMpKGK63SJ3w95C5SJaxLTvIO6xcL0N7pNULsPhAh2CzflJQ7hA?=
 =?us-ascii?Q?hYGEBTPZ5Gm6IysQwkqeb4bRAo3q3aJWrCjJz4aKjBg2WQLfkcexgwl1EAb4?=
 =?us-ascii?Q?gXblSyIYrhK7I+rf2H+QVDtx/W7R1i6lS6KVXcWL/OwpZXtIPZ2huez8tjZh?=
 =?us-ascii?Q?6QazGhNgOrOg+GWRfAkUIujvK8N6nPcGyTO7SRVgrxusK0/zDZlfg4ciLNSP?=
 =?us-ascii?Q?DDiHHzOlsIc5aW/XxHGCFrjjvRIbNfP/FecgspS4QG5ay4wjOhKCTfCgb4Jr?=
 =?us-ascii?Q?eJBM6UR1vO6Tx1lidX7Km+8qt6ajppVf2g+2NnqRSCVW07G5S8toiVlDflkV?=
 =?us-ascii?Q?222AuaaQqeEV7n1AK2x4GRU68xvIIRKTapY6XouwHjATeH/4IGucvKJcBlDo?=
 =?us-ascii?Q?NeTXxhFu2fGLc4/nTk0KiMbLJJMaBDLhPZlnilCqkor4kiMyJa7ZxmfwuXwM?=
 =?us-ascii?Q?i07LP3EoprAf12+qWwoErq2lQ5/kx8tOiJCvg6dQ99loi+/g0qAlwKhJdW+N?=
 =?us-ascii?Q?a3EyG4UhvDsuKEkHjhFOQoT3aihKvsOfbA2DsZ8lDvsvewtb0K2SgHJa0eHR?=
 =?us-ascii?Q?XqDXN7bzhvKsBFfS9PNtgqwAkp3lZL9PyHq3jOVoNtw+FSnVhcYp4yZkfEX7?=
 =?us-ascii?Q?1X+DThCo9CtEj4kTjqqjxvy73A1y3d6eJWaUin5hqlIpcI9SB4Scl+OgIhYz?=
 =?us-ascii?Q?oVFrRNRBELdiUvq+pDa83I1AR0pcsNEjPwLxqlXLRvXyU4ochQLcIENQCUPV?=
 =?us-ascii?Q?8NLUDuD0KpEgTOMN4wyPkvnNpJ3tJBoLc3Fo9GWqaJbpBM/Fs1hB0WDPppCi?=
 =?us-ascii?Q?TOIG7DTk7PxQNT2uqg5bmetVtAGN1/wlCTj7na8hCFHMU23BMpMsqTv2ekWl?=
 =?us-ascii?Q?1iaD4dKG0SRfTosx5w9Dz/gvpyYKZwbv58NkodxWdFFLc29CognV8kF0pYet?=
 =?us-ascii?Q?JVK2oct/GSbRq8Un9tqqndFlg7M3lQpPTFHXupjeds0QZzNmvg1l0mY4j93W?=
 =?us-ascii?Q?iqWkcuIhoMe3ruJPIM4B02fJe2b2FtvwhkYdiNhOyJ24jTWtUaIc/H1LL7pL?=
 =?us-ascii?Q?YM1Cz5e70GEtRzXxEqAbKrHImW0+gbGUxlyWIYOLfRc4FTASU6fOYy94lolf?=
 =?us-ascii?Q?dnvqfW/JfxaE813sUiUnYb4BvbLikcqpKz/RKUH760adX8yvUL2i/1WihxUc?=
 =?us-ascii?Q?A09TIHT9V3FYG+6G5Q7K9CKFu+2bgC+0SeJKxhd4Ca+UGdYgDRFKKbb9G6Yr?=
 =?us-ascii?Q?0wAwUEzeWg1XoZry/x4G+YxYEsbfFePlZZHifEOTWWeKG1yfXsQReRemrzQh?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6ydqlVt9JpA95vkRog6tsKcOr8qv4FUvJv+HxDhOBjbSHtBJO6mOwjJMV4OQedv2GsxwR7x/Oe67jwu/Eent8aE4kPZXFsYlCDJjzebea3fXdCB9mbj2RvXkrWCHxWC0P8HhjXlxmousLds7mxl/fXV1HMnmUnqyavmhec0GCsYMBugQI8tNl23AoHkU9XmEAFF15HJh7IiYJbEX5FiaF0x6B/C7H2tGw56rpzJG6EX3rprQ2IwE/oXCzkbv7ZJ2kgYJfLexniuApZywhWlpEWxM7yLc6fk6u19CEjyJE7/KDF6ujNlogpyu0os01gPhgPvJSgLywBLjQwzO2Cmsa0bsOD8aNuHkIZtcNWZnuvylmCyrZdiFlTzrL++c5DNDyzoJT3tfZpztNCBv5by8I8WQoDn6YdVJjhJWswIprFA6vgTqzhcy32AGjrObjQkfokeqca8IYf8op+hVAzxJ5BkIcqHYm/4g2kt1zGx++u/6q5TXWBfam+ZDWnodQDs89CoUVJ0LeL9fD2g4YGANzhSs2pvgrqEmHCZZB1gDUq/KOBWljTRDoTIUUHVuF2O3lsAqkHlF1FSH5jAZL6ZBN6K7vO1dpz0vJVzVQB2yfkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f041383e-1884-4edd-5f39-08dcf2e16a04
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:35:14.2261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1qOUysTo6jm5wHPdPp6rdJWr91z1uHtfoZ2TIcQBkgZE8ciZ4KOb60eaXEI57j7B/NcQNVYrRFQwgYKDd5+AnvhhH02ITcxBjNWqzs3kNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220140
X-Proofpoint-GUID: NB8wrCddT5O5Tsy1MiXv1Obpi1lUwzNN
X-Proofpoint-ORIG-GUID: NB8wrCddT5O5Tsy1MiXv1Obpi1lUwzNN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

Add the page size information to the hwpoison_page_list elements.
As the kernel doesn't always report the actual poisoned page size,
we adjust this size from the backend real page size.
We take into account the recorded page size to adjust the size
and location of the memory hole.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c       | 14 ++++++++++----
 include/exec/cpu-common.h |  1 +
 include/sysemu/kvm.h      |  3 ++-
 include/sysemu/kvm_int.h  |  3 ++-
 system/physmem.c          | 20 ++++++++++++++++++++
 target/arm/kvm.c          |  8 ++++++--
 target/i386/kvm/kvm.c     |  8 ++++++--
 7 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2adc4d9c24..40117eefa7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1266,6 +1266,7 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
  */
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
+    size_t     page_size;
     QLIST_ENTRY(HWPoisonPage) list;
 } HWPoisonPage;
 
@@ -1278,15 +1279,18 @@ static void kvm_unpoison_all(void *param)
 
     QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
         QLIST_REMOVE(page, list);
-        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        qemu_ram_remap(page->ram_addr, page->page_size);
         g_free(page);
     }
 }
 
-void kvm_hwpoison_page_add(ram_addr_t ram_addr)
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, size_t sz)
 {
     HWPoisonPage *page;
 
+    if (sz > TARGET_PAGE_SIZE)
+        ram_addr = ROUND_DOWN(ram_addr, sz);
+
     QLIST_FOREACH(page, &hwpoison_page_list, list) {
         if (page->ram_addr == ram_addr) {
             return;
@@ -1294,6 +1298,7 @@ void kvm_hwpoison_page_add(ram_addr_t ram_addr)
     }
     page = g_new(HWPoisonPage, 1);
     page->ram_addr = ram_addr;
+    page->page_size = sz;
     QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
 }
 
@@ -3140,7 +3145,8 @@ int kvm_cpu_exec(CPUState *cpu)
         if (unlikely(have_sigbus_pending)) {
             bql_lock();
             kvm_arch_on_sigbus_vcpu(cpu, pending_sigbus_code,
-                                    pending_sigbus_addr);
+                                    pending_sigbus_addr,
+                                    pending_sigbus_addr_lsb);
             have_sigbus_pending = false;
             bql_unlock();
         }
@@ -3678,7 +3684,7 @@ int kvm_on_sigbus(int code, void *addr, short addr_lsb)
      * we can only get action optional here.
      */
     assert(code != BUS_MCEERR_AR);
-    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
+    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr, addr_lsb);
     return 0;
 #else
     return 1;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5..b971b13306 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -108,6 +108,7 @@ bool qemu_ram_is_named_file(RAMBlock *rb);
 int qemu_ram_get_fd(RAMBlock *rb);
 
 size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize_from_host(void *addr);
 size_t qemu_ram_pagesize_largest(void);
 
 /**
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 1bde598404..4106a7ec07 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -383,7 +383,8 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
 #ifdef KVM_HAVE_MCE_INJECTION
-void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
+void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr,
+                             short addr_lsb);
 #endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a1e72763da..d2160be0ae 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -178,10 +178,11 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size);
  *
  * Parameters:
  *  @ram_addr: the address in the RAM for the poisoned page
+ *  @sz: size of the poisoned page as reported by the kernel
  *
  * Add a poisoned page to the list
  *
  * Return: None.
  */
-void kvm_hwpoison_page_add(ram_addr_t ram_addr);
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, size_t sz);
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..3757428336 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1665,6 +1665,26 @@ size_t qemu_ram_pagesize(RAMBlock *rb)
     return rb->page_size;
 }
 
+/* Returns backend real page size used for the given address */
+size_t qemu_ram_pagesize_from_host(void *addr)
+{
+    RAMBlock *rb;
+    ram_addr_t offset;
+
+    /*
+     * XXX kernel provided size is not reliable...
+     * As kvm_send_hwpoison_signal() uses a hard-coded PAGE_SHIFT
+     * signal value on hwpoison signal.
+     * So we must identify the actual size to consider from the
+     * mapping block pagesize.
+     */
+    rb =  qemu_ram_block_from_host(addr, false, &offset);
+    if (!rb) {
+        return TARGET_PAGE_SIZE;
+    }
+    return qemu_ram_pagesize(rb);
+}
+
 /* Returns the largest size of page in use */
 size_t qemu_ram_pagesize_largest(void)
 {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f1f1b5b375..11579e170b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2348,10 +2348,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
-void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr, short addr_lsb)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
+    size_t sz = (addr_lsb > 0) ? (1 << addr_lsb) : TARGET_PAGE_SIZE;
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2359,7 +2360,10 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
+            if (sz == TARGET_PAGE_SIZE) {
+                sz = qemu_ram_pagesize_from_host(addr);
+            }
+            kvm_hwpoison_page_add(ram_addr, sz);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
              * synchronously from the vCPU thread, so we can easily
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fd9f198892..71e674bca0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -735,12 +735,13 @@ static void hardware_memory_error(void *host_addr)
     exit(1);
 }
 
-void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr, short addr_lsb)
 {
     X86CPU *cpu = X86_CPU(c);
     CPUX86State *env = &cpu->env;
     ram_addr_t ram_addr;
     hwaddr paddr;
+    size_t sz = (addr_lsb > 0) ? (1 << addr_lsb) : TARGET_PAGE_SIZE;
 
     /* If we get an action required MCE, it has been injected by KVM
      * while the VM was running.  An action optional MCE instead should
@@ -753,7 +754,10 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
+            if (sz == TARGET_PAGE_SIZE) {
+                sz = qemu_ram_pagesize_from_host(addr);
+            }
+            kvm_hwpoison_page_add(ram_addr, sz);
             kvm_mce_inject(cpu, paddr, code);
 
             /*
-- 
2.43.5


