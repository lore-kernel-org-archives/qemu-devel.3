Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8DCC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 22:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taN8n-00005U-IE; Tue, 21 Jan 2025 17:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taN8l-0008WM-B2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 17:54:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taN8j-0001XW-Nv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 17:54:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJKs4P000899;
 Tue, 21 Jan 2025 22:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=PAsrN+frazq9MZ+P
 11h+Iv68z5m4Zd/MbTsJZrTj7VU=; b=hSgTbaNTOjKBlc59qcAS/f3svAeMo0hK
 c8+cwLjHfMWJB9lg7APpdo48aK4IF/ggPg+GL7xQEHK6JpSGWhXC0hgp8Qn6G0zR
 CIokZIBhKPdvEENptvb3rZ9tae9NE3Cr60ohyvPNXAcsMTOiwkpIA/aMB/epebZn
 UH2LEZBug6ZNbi2lb/Hm8iNuhKQuUATATbjz6C76mztVHPwo9R8SKRWCKV41IDwm
 sc/HZzMcilSMW4u0e9daWKuo3Odzvf4qWmyqg+I8jbBxVtgISateiwMEvIDpoKOH
 OwcS7MhMa649FvQ9nwp+3DO5SyZa1q949QtqtTyyZGT0LFKnXitjnA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485q56qmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 22:54:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LMUKTa030388; Tue, 21 Jan 2025 22:54:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491fjem4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 22:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzag1WEHzrrTqlv6qYyE1f3H8fHR9t53UBWOmdpXmB70jylZMOBwjp9ZErEWxdRZcBnEHFWaXB/x4RyizSi+YDfGN3T7ZuFTYnp2Maae/k4Rpgb+4pZL4EXUhms8EjFXUN0Tww17OYb1PEGhyF0+1FmqoSzZfW5vmWSsAOSKj/1r4U0QwqX626lBdCBYe3bAJfEJGzM5VbIYTtBQCWRj7DPguqrPOwK5OCMAisN9/C/P/Z7f6/lfv2CBeGR0AUk8+537OIJjVp5vF5WRX0QaQNl3XIgm8uQlIgRwak24ZGLO8O+k7mivzW9VORfNEbpLv6S3/x3k31/861XsMehVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAsrN+frazq9MZ+P11h+Iv68z5m4Zd/MbTsJZrTj7VU=;
 b=lvJETkKIf8lSh9v5RUvxKUxsEktgsPajcjeARb8Nu3G5frZdozNsIPEbDKY/APcjftZDwfAvf9cuAmu3o/xtngPUI25hXAtxazbXb8XxIu+AkDct2sK9y7uSeZl3VqUlNdBF8sPhO78Noam/BH1XmMmdEKbi4x+3niIOVKSLp4M6H6Lo0crLzVa2qcc8Vd8pinnxO8aKi9yZl33NQEK7NzrETUJcswxKhEHwU2AYOO9Ta1tO2wBSzlxAOeXqUzQNJ+1So3KNa0FvpwgBo3i3NUBgTpuzZkEVbfq7COGKF5b7hvCNHIpRXLVPtAeH1kS11z/MINYO2ju90otpu5MkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAsrN+frazq9MZ+P11h+Iv68z5m4Zd/MbTsJZrTj7VU=;
 b=M9OXDPIJVrF9YEZVOWx0Zep9AajG6wZvqEUHtV4SedJ9S3NQcRKVF6H9o21dJ4eeh5tK1uF6uF2TRTjaSA/1biW81CoWcgLu0oRf9u/oLTUVx0+TAMF2Lq8enslTBoinIGjoxJGcaBchSvwJp8rkiGSdw4aIT0C0C//nU1Kn3dw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 22:54:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 22:54:28 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@linaro.org
Cc: william.roche@oracle.com
Subject: [PATCH v2 0/1] fallocate missing fd_offset
Date: Tue, 21 Jan 2025 22:54:25 +0000
Message-ID: <20250121225426.3043160-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:208:236::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8fa502-dcab-46dc-31ea-08dd3a6e8f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wi/fkOTJNQCAxgj7mQGfgcW+WrD/q2vhk4baUv1+ejCldaogKqjQd0Txbuk8?=
 =?us-ascii?Q?Fre4CXuJ90Q6dFtoJ22HYLfKfXcBPq93c26Vo/zgnhjIu9t+WpDZCeA5Pasp?=
 =?us-ascii?Q?juxWvcEKBeYypRLvcW04D+gGBSmn1cVdmc+Ppd61RStaYjCgikQcHCw46tMk?=
 =?us-ascii?Q?rvIjEFOtTyMC70rBrLKROWGCyK5mp1vqjvDCklAqxqcQOkCE7tGIAQRKHqSE?=
 =?us-ascii?Q?yJm1Jp8t3oBip0LExCCnz1PwPv+r+8RAhH9AfTedDTEY08mEWyWIXQE34gTz?=
 =?us-ascii?Q?4H3QJJTX++mt4SRsZPkpJ2HX7UKpTRdCp+zqEy6Big1OSxl+Q8Zk9/H1VsWn?=
 =?us-ascii?Q?x68Ue/In1xaYut2KNdv61Jn7haKZewqpKUpFz9ar1NGpZqLxYZRgs2mE941D?=
 =?us-ascii?Q?60xjgFOgfk6a8VaJZ3bEeS3GP8c7JAOW6MoMkFqMZerQc6QDpcqfb0PsV4r1?=
 =?us-ascii?Q?DZTgb6OKyIAzx2VN8eYks0Cw9TcFpIrLMmIWmE9IeNkHIaF5Q3k7pAxnHyNu?=
 =?us-ascii?Q?tSpW0hKDFFZKZi0iTwxjENw3x1NNPV9UUPBF8UQaPro1LzPu/pHSrMl1XdZU?=
 =?us-ascii?Q?uSLDpdB8sVQ/AFTtrclCFNhxadw3EyfXR4/tHSLAuaeonCwPLCSDPcNvgq3x?=
 =?us-ascii?Q?TxI7a+Iu+E0wc9OaCZQhHwwoBbMrrXfLE+7X9WirTUbrGq7ILJpt41NicLdi?=
 =?us-ascii?Q?kTiXorKQ4PHJiPep68KrxZxyL8Pu1F/gqRO3PRbhDaSucyNr2tgXLP6CK/lT?=
 =?us-ascii?Q?+b4+VEA4sfD9ROQ9dLb0704133GDUSNroVV5fPOoMck67QgM3hIKKT38Juu6?=
 =?us-ascii?Q?YpnCbu84Jnc3sOUZZozidsCEmQARby1s3LjapDUoI8uEZcDRApsKy2RUJA8T?=
 =?us-ascii?Q?pSJz+8VdR9Efkn03EII5dVfXF1tmEYrnkhVVN89MZ113iW27GXaBvqqaVwmx?=
 =?us-ascii?Q?sL32qTP38DcTX1kEYYVeqCDptkhEmbDHAE+ghqIQ9yKKmVNNnVgaCodsHx5i?=
 =?us-ascii?Q?32wtx7XGb++hC304EWT6Piv8trM0eFI7sFX/ylB51DJsolwhcC60db+en106?=
 =?us-ascii?Q?qUfZVDJExsNO0fkcHD+MCmTB1YLvMvVm2qmptgDy52RI2d+4DbOZD7aHB0Fo?=
 =?us-ascii?Q?EHjbNsMv+G/DKm8IcdAAb66LOWxjXdAu4BFRhFlQV9IW7BEalaZDz9ZVaIZD?=
 =?us-ascii?Q?figv4zNbgQur0Pk2J/dJH6lxRhOM5g2cFbwi2LIeT5YHC9saDAM6Pn/R/4lP?=
 =?us-ascii?Q?EfpXvDiAU4jKQqip1GbJgNxjL+aJjC72xzrTmlBy93BJJnIBrLz8yFXg9MwW?=
 =?us-ascii?Q?KR1gg34xJUH4O9DEL5hu54zzuBXH7yNaGVMAZFmD6d8y8yIoIaDVqeRUEyqD?=
 =?us-ascii?Q?ehBEtQWQKHEpOtI55heJmzi25X1R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YudkySPo/SHkQpRj+/maIAS2FJ07RDm15b+qHq5aoPnLDJ6lQgvfKCL6k2WB?=
 =?us-ascii?Q?Ae3SDeh1rCJwiEguTtoCLsz4Fezfr6iEtXRbn9ngXvcVk75KEk1cP65ozRd0?=
 =?us-ascii?Q?SllzzKwAL8JJo8bnPYgTqelMwjOXSPsAk31xwCdAeMoGFHEwSx7Si7OpfAsT?=
 =?us-ascii?Q?nts1Tb7QYw34Sxdm0Lx/ICLemKfgTbmyHCupo4K3mMBJUvMPKHlnjs4QIqAU?=
 =?us-ascii?Q?Rir//xmqylH+tkAm8En634CPv6dMfrdpOTZxezq0Y3nvIUN/nn8Toc4VQBhY?=
 =?us-ascii?Q?Ey2e/lSF+9zAH8N5xHqyjEW7AanNO7/ZL+LAMAXptzN0yVdYRCw7n0cOcnEF?=
 =?us-ascii?Q?+30BuOGVd0G/78BrMaL7j7lIgfZ8VhYyCSuAiEUGad7m7xaaZz/z5uYglHE1?=
 =?us-ascii?Q?7NFpdJrE5ZcOEtRSRVds5bZhebs8AGuXdKxIIa1GqP3AV50dpE/d3H4UGzZL?=
 =?us-ascii?Q?VzwdhxPBcwkqxPReaTuG+DO6DV04Ee08yiOR/6TagbQYjvJbxAy7pUkshHF1?=
 =?us-ascii?Q?9v2O5iyN4DWwiIK88Dp0IQisKZ5VOqyJwqzBcM41gBquoMTSgMcZ/6RtFWfZ?=
 =?us-ascii?Q?3CfGPCm4FBrELUATe+Jg9xz8qbcrK59r4iEHsYfRb5IkoTyC7jp4jJAIAVvP?=
 =?us-ascii?Q?AEbAOOJ3Ayn8XSV7CrY9CIQLReuA5myRsDXSPQBhD9mQXcAbPdA4b/yY8e5x?=
 =?us-ascii?Q?YtASOzTuhOSOM1j2bpUmLHsO1YpMrsQ5sdLy1pi4dV2V80bmzVGqR6NSTKQo?=
 =?us-ascii?Q?G+k/i0ZJhQu8fkwB8PTW4aS+C1LmqYVQXzrZZEn8JtD2klkVkoqyrAoZH5s6?=
 =?us-ascii?Q?lCzeG0sCoYhU5DHCZQvelaC3CAHWEYlEjKKca/LGPqCFeWN5OeDCSx35/7e/?=
 =?us-ascii?Q?+yZZdy292q69iMr6KGkX2FUMdlqlDsKT3Mb4ASdv12n0uF0MXwoSHRyU1cyT?=
 =?us-ascii?Q?B5VMHy0WAPtsxXqHpuFJ0LUjfHDg3mdEhlL2N5JDiUKGgOASq2Q1LpbFNzxC?=
 =?us-ascii?Q?qSmO+aUx4jjW/4Abcdc9D6aW7XxmV6V6qY1faP2DgTjIQr8TfBiOzGR9FAb/?=
 =?us-ascii?Q?1rJZ8yoNHPWEiAaOf+K7A9hrm8YKoM1SXuPFfPoqJR4pvuRlQ/YHtO1RyVhJ?=
 =?us-ascii?Q?36cXT4MtqCfBjBFL9R2dj1CsGn083K8lKu5qaD1FafsKr9vyjW3xH7Bit4qk?=
 =?us-ascii?Q?OhScrg+IxdilMrDQ9GwdDJgmK0Vxl9w8yGtgNc7TeLRqVBW5riJK1Tqq06gS?=
 =?us-ascii?Q?T/KdISS3k1NAALHXjaT2X2ypuwadKYCxVEf+xXbXJPxvXF2IYJA2m7DTsKzj?=
 =?us-ascii?Q?Wf/fRJjFelsR2+/pdqEJbKj/2Sn0taLcFmPCpExlH+tNaU95uNgMMLY8eElX?=
 =?us-ascii?Q?thueAMM5+Y4Bgx2UXE+x2w41FGgesfokLQPE6RA8oOYF/B5gqU7xafS6tCQ3?=
 =?us-ascii?Q?z/0U/0Qt5wIa1wwz87MgGJipPFYHCe6Y2/3tDc2HdfDM7b5+fCV0DDZwd0x4?=
 =?us-ascii?Q?IlfDoDspkOVOWg+hDboMaQsilI0HEswGHAQJIWvRbW33cQdNEkE2F4ZBGjRP?=
 =?us-ascii?Q?xCC+FSR6rkHmDxXNDy/upcbaSOnUFVDsIVfsFy0VWNt+n83IiKjW0ObsAX4g?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O+gNM7TzUojOMru+cmQKmF+CZ6p3pA/lEcx4NZshWdK7msYPBRbsqrZ/MPIsx9tUK9ECXgXRhP6ETLuGE1Gp9JA45wZd4s2H/ZxgPmOTZThu9rgDl7w4YDOgD9f229WzcqpaL/Z0+yEkRf29pT7NsqlFlcDPzaXePrP9xunImsCF+iar7PS7Abai9LevYVvZWkSZhDTK5joz5SKnqTbhvR2ZvKWLzHMnsVDP0iXBaLRdytFRvs8WoLV3o89gnGcaKNkPR1OZULc7b1aq7AVcOOKCZDLk5F9y3UC/NWRy1TCxSJYMUXJKaMjSi3jBfXcpL6oQJjzcRYeOskuFE34WVNtVUXlguqqas5Hw6rJiyv9P2uTKa8KdUwNwMPqdt165eFeFrKp3M0A2KvWqwLk5yZIllLpCbcsV7oSjc2rEuitf8dTOIHtq2o+SES+ZRmGp6bXwB+EJpUiDHnexxOCxPOFeYTWIvAqiIPh4AOUgthrgXWUY0DRf3SKYJW4i/Q9vFaiaZ6dWkk+fHv6uGvHyfC2l7DA9rbIVZGGNSNyVWHmnU/c5oFlYyy7Wvwd5AK/wOozQap6VNCZfm21O/hfwZZez9u+hklFFpClidQAeyFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8fa502-dcab-46dc-31ea-08dd3a6e8f0f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 22:54:27.8553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9jNZMarWoRDmpeLvEqPX9wIRjxr/z9pidgC0ZTOZyM4Vv0OX6Sz+QqjcCoqWUUOvnyWv9cGov3m5NS3Lk5AALlbgMqkbvE6BKRsUrOzPco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_09,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210182
X-Proofpoint-GUID: 2xRn1ixtZEBsb0Zj-InIxkhnbic0h-r2
X-Proofpoint-ORIG-GUID: 2xRn1ixtZEBsb0Zj-InIxkhnbic0h-r2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.086,
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

Working on the poisoned memory recovery mechanisms with David
Hildenbrand, it appeared that the file hole punching done with
the memory discard functions are missing the file offset value
fd_offset to correctly modify the right file location.

Note that guest_memfd would not currently take into account
fd_offset, so I'm adding a comment next to the fallocate use
in ram_block_discard_guest_memfd_range().

This version is also checkpatch.pl clean
make check runs fine on both ARM and x86

v1->v2
  . replacing the ram_block_discard_guest_memfd_range()
    modifications with a comment
  . use a local variable for the global file offset


William Roche (1):
  system/physmem: take into account fd_offset for file fallocate

 system/physmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.43.5


