Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A330606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=czGT260e;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=qEehOMtb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjO-0006Fz-KN; Fri, 23 Oct 2026 10:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjM-0006Fp-Po
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:58:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjK-0002MG-IK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:58:52 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE84WJ3704990
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=xjC4VTwiYQp/7
 MAXc1ULoCOhVugBrtS+t7/cszQPDOk=; b=czGT260eGG0AUi1WpUqp9fEi0I08r
 hybvL5uIvDMx5clexV57UWzWJ0c+yB09L3Mph+m0lJN6yNbJ/XVQ68F5nvGNvM+o
 1X0yC4NLVzNdP9zRv3rz1vFRY4+qOvkLrhHGfTJKOiDn9nryf42wyshCvWpcDQby
 njEM7bo0jRaYcuCOuN+ggBLiHNWXN3E7y6CYKxwGUHzUrOcmEZ0QEBO+VOZiabdZ
 +2HTiFRbODVw0HOWqRPQVkyIwi66KMrNr2dTnLJ1BPR1AGyco5/p9MALjWTovaYK
 L2vmDhWUh85ZY1p6ukoYiMz9WI5tiBqntgMOlc7BbcVv5Mos8Q83cre+Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022120.outbound.protection.outlook.com
 [40.93.195.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974w0cb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE1ovz6e4W9XXtEwg2U//BoleZ3ACiKwkKOh59Xdf8NYfReaCMZ6msO+EJel8Ff2VDOXhnXxQn9PTtH81KHROUQWqZijifBNhxk699RAkWH8tZf2OVoCj4b7HxXACXNPmTFTcSMo0aFgviYFiBziAcgCt3AQjDGkPS6ftl2LPZdWPKd6fdERXHUS2Uf/fXqNOilBk59949NcgvXgNyIsOZvR7HcRq7ThJxck234YsK99A3QYj/jf1h+HSzmsLdmIOd5JMIDAPVHXLONKzDwk4qVcRjvFbg3CO/nJ84jdTQNQG/5VeCYinmFJXF73rdn9OPJ7R7VFkuYeuUozvDVPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjC4VTwiYQp/7MAXc1ULoCOhVugBrtS+t7/cszQPDOk=;
 b=lbFbbf7GT4DmO8dS24TbLjalLznROK/CSe+sAg9xVGogQ4+AI0fCfGbvP9LteYSE0juvi9Bw507HbkOL73mpPkJyvCmHlO5Kr4+1I+GbkUXHY1VV7YT1DrL05Do/D9B+glZFP+K/aShh8GejJdQTVomaC9jzqKFovJOcYQlYHYEeKxPwiiuSA3jmRlH5SjYKcX/AUHUK6Pz3yjMyUIQHo0EU+Fm02rAAm427gSwrI0ttp/qdmKz/xX7eA8Rp0q0GTOMqU6QbAZhcVCUlKNzth5Si9OAax53wzqO7fZJUG//Qa783DNYOJl4mxdsWQdGLb8KbdKu+BAt+RQ9L+0xmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjC4VTwiYQp/7MAXc1ULoCOhVugBrtS+t7/cszQPDOk=;
 b=qEehOMtbnz6oog8YjeKKB0nl+ZPco6zj6ZRvrK4grhOaSvHVlSbibgY8tZ0r7MLzdYt18nRskP3T8tWMFglq3wNHg8noUP2pDPkEq/NPep6saP4LcP1tWn1dqApFdbLSJOrM8LqnAooKfWwXyvk46f/KufqfbbqyOsInOUVt4uCqXVfMpuNc2mTZwNfoDmnvys7hejFhlcoNU00Mu/0+LhxK17z1VNq32Kl2eiVqOgmOYVptZtr/OG1lfSUgXWOFEx4/h63+r/GCAYKd8TRNSXPc8HqU794mQAeAaAdl0ILke2YjILRY/aAspW+6YDkst2eEjV+qiZAf89X/kWrERQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PPFBA4959B56.namprd02.prod.outlook.com (2603:10b6:f:fc00::85b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Fri, 23 Oct
 2026 14:58:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:58:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] qom-qdev queue 20261023
Date: Fri, 23 Oct 2026 15:58:06 +0100
Message-ID: <20261023145839.34909-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PPFBA4959B56:EE_
X-MS-Office365-Filtering-Correlation-Id: dccdf6be-5f82-4543-98b8-08df311621d9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|261021121427099003|18002099003|3023799007|261021123027099003|10067099003|261009223027099003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: 99JshwLYP6Bc0/kkK2q9mo43VWbCK9YhFCWKjm4Nw7ams7gblOpmuG/4zHIqSAIwPVP4KibCdTQeM1pxQtwLSw6hp6Yi+kNjPXvwD4Fhkln+7BU8NyOsr3/LWnFKNIc4ejEX8rzrwRqrVrP28zz4Q2OF5f7UzdurRhJ2hqw5BEAL7UtIbFnOL48o8FF7G9mEDJxGvirJfyHZcJ5rr7v1SDHJP3qx18D2oms1HiqlNddEfuana0ToZ5rl0EXYnd0IYKVBbiUvoZv5zLpdgaM9qRpnSWG9BflH4PEMkpH344I1DKAMb0qUwkAm6ej6x1T/l5SvNm3urAbR7EWbmzKRw849DqANAKd1/fUHIbTuitnIpDDgkkt0NOmOqCGG+h9QqzIPMfDN6Yu5KdT/g8J7YtZWSJmFLC6lqcI++TZEMQ9SJEF5BmYi5mskLNQsgk0eKbTFUQ20soOSk5GITj2w48sPsiD3/3MCxDKJLMfXYjCNQTZ8ZQNA2PxuZRDsaH5q2EHuTlbetxizqX6LX5mtoANsiUYhbduQ3S+2x7bChbaNLlsgORqRki5BmkToeMbKAzRAPQ0OvzZ2bO3QyrVy4WaxaLdXMX9fvT54Cx8qN7Fmwk6gOxcHf8pZFqm02WGRjyWClwlOhOtRxojttMIBZdM/N7JtV91hV3QspSJOJ9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(261021121427099003)(18002099003)(3023799007)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlaZOVxZ1+XzKutGVC8RfzG/eHknBZ16PrnhjgPJOXV0tWmF8uqDaSX8EUPa?=
 =?us-ascii?Q?Npd9T2FthGgU3KqGOQgxzMKabuD1y2PgQNLgj7AKOGbYh7wqBsIupStYiHWC?=
 =?us-ascii?Q?o5EVPoJ7/1fDlYtUpczD+jN66elHblty0EDtDfAlC/d9vK/zZc+Qu+TwyF35?=
 =?us-ascii?Q?wFWy743WhE574mNFscYJY/8tnQx/BxP34VWkeW6LPEPlsMhZb/pBNJRQnS2p?=
 =?us-ascii?Q?2D2hjrd/D8J5sLnTln+geWDCOCnjHNkVMEC2vi7Ag1+W8pZAyqkhjTmj5Sxk?=
 =?us-ascii?Q?7J/lPirfjpnlXh6xlVkO5YHF+GTCEKRrVKPWGcJJuYPgIDLySd1kSnGDEkXa?=
 =?us-ascii?Q?XcO+jS92A5wFStwd0xmFrNdcHLc5fnDKFml2dZRoSVrgSxcjekAPY+b3Gazn?=
 =?us-ascii?Q?r0PUrCrQUgrebUU7IKdCrOFxsVVZ5U147vWPuAM7DH3tvFn9NRgWJuf1RWdq?=
 =?us-ascii?Q?oeKdXVlHjJT7w64rGLts4Y1A9yw37/3U8DNTpQg4urDIYIXFVL53BrIHM4Cz?=
 =?us-ascii?Q?BId2XV5pCxv2V7cj9KsOiDda+fVcKIFpSG1Gy+9PgrrpIX/Fu5JryODpof+S?=
 =?us-ascii?Q?7VY47dwLmGHInb2tSeHbGaB7t7dMjwTGQP6KvvoQik51ugMap3yIEQConoWh?=
 =?us-ascii?Q?up1gv/1RQ+fhK4w2XOf40nDz9PRdajM4xN3rQXs8u8i4XyEd4NWcVQOx1ygF?=
 =?us-ascii?Q?RvFx4Ok8ok+tlbMIkpcdFoYqoIch+mplMn3WF6Zx+idyz8EaUhA9sO+bKrZd?=
 =?us-ascii?Q?iZCasoyMXAJlOB65iAJegqgk5+mGmQOD//Ehkc+/a5rKTEneS5jFSfBQwmnL?=
 =?us-ascii?Q?p5qNgd31rTlpdolmoV4tUbzoyfIgDry6nGOhYVjQG/+pyloMmi8HUTBg47hc?=
 =?us-ascii?Q?238qTy7PBFOwHuEF9oS1Wml2rNQB0gMIRNuxH+M29r0j77aXSMKIv12xCa6W?=
 =?us-ascii?Q?8akpKOYp3LLshQPnzND2dfHdZFlCfdHLGb+kBB4pLwDht08L0hBH4efj0+3j?=
 =?us-ascii?Q?SFaY+wwPD3n+70qSYtPWOJ0Fq/OSWj7lioiDOIRAJpm1xSmTUFaBN5rmKmvG?=
 =?us-ascii?Q?6zy47nl/MEdZPkxNzdR/xf5faDVXPyRkdrUKZxsHmXhRsgsPpvGKWUTqbkWb?=
 =?us-ascii?Q?zys+NjpugW+r3h/0zIoaXoE+WEHvnflOCXW1aC+B7BjMsp/CRbqizve7rSVn?=
 =?us-ascii?Q?ETN7r7MYc81c7Fd3v7MhkPpXeO1d1pbQSvsvDrVLH2aASg5TB8FWK5nzhPgl?=
 =?us-ascii?Q?2Sp9A3+QqZ8qUeD0r+hucWYR4Cm+rvLtm+6zB8HfVDN8yyx35W1AQKrWV64Q?=
 =?us-ascii?Q?YPLSD8NGyYdGQcEqs6zKxPvxzvmC4dlPmgINYCsuSnylLYqWFci7oAAjIWSb?=
 =?us-ascii?Q?hTAlHx+NoY1oSik5YlojHLkDj8l4wF+/TAOxX+RaOakCyHKXA4bqAnVrbbFL?=
 =?us-ascii?Q?i4LBzHAS/ZQScbuE/PFsV/dHnaYn2GQNfRMPgbXMy02uYneM59PGRgCoUVvS?=
 =?us-ascii?Q?Yw7XBghQjWY5teVF8tbfB7WWDgNTOk36wU4aCTb9nAm+JruP4X0yNj9B3KZe?=
 =?us-ascii?Q?4+lb7O6gxTi54oxaaaovMHSpP83dJIzCtteA3BF0+VSkk7fpR6iwTojQlz3N?=
 =?us-ascii?Q?rQpm/r6srfXEuVXhWQ7MSyBO5AZAhhh/buC9an6qrjv/eNnRN2/CSubAYcvM?=
 =?us-ascii?Q?CyL4yEJXVP/I3N4T61dHAyrI0/IYJUQylfzUT0F7Cbd19owTxxeTAZNtq5aP?=
 =?us-ascii?Q?vKJ0UK/CGh45n/ywgDNb87svN2oEUQs=3D?=
X-Exchange-RoutingPolicyChecked: p4gEnZqg8rnEmBI5Rf6p8lhN4+1wvMH5HYClF+YFhsiyAcMBuqlNFbIuyW4eARY2Dvy5RbCCeFFm+L2akefxOjPjQQX6QWKXGJOj6tPPwNf6ClSxizXNygG5m89XKVVxQlTn2gjaH0+OosG4x0ZFnFBns2m6hz2SLCpQwWBg+/E2eHtetf6/+67YND8abHRahG3oi6cAOqorhYWHZyswF0saft/FxxOUREDCRG0HwucJ1xd87IOD9aAHP3Orziq7zDv/xCNzbFYSmuVeQa7a6x8sXBA9gNvCNpnU7Jjg5tN/ZW445n08CxteTqi20nC1ftItX33Xq8zKS5vSV6QSAg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccdf6be-5f82-4543-98b8-08df311621d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:58:43.8158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCxuwu8z2PCsrRZp7F0kz+AG6Kota4moalAIVhjCH7/mVGkaQkKSEESHG8mY8BQOCotOgqXLzgtxrZDtQxof/JX0SED2SkkGY4ElY2rbAxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPFBA4959B56
X-Proofpoint-ORIG-GUID: CKmqPw59Zgu-2laKOpGij60asipQEQ4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX3eTE4VxKYjKJ
 iOFsnPv5pHW1gFYz7j4KpXuOYWkgR07qT5ytZVa3utOgL8SaVdLz70CPDDNQ8ZNQnj/hikU//kM
 fSyj8oX2fT1j8SzboLm3TsRQJlanObzS6DJbdwiC9JhotRd80UQT9SmtClopOah4Dx4bSpXF5yb
 yp3igIh4sE8hQx2oBpH/NhMs/JCW2HzyHBmPYKuHti97VzhXVPP8/yHcqFRjvus0eYwI/LQXpCE
 BpN0rj4NBCBghWgPYtsw5NJEjZjJVoFcWUuefipj9sF9429IKiKqdy6moA4JNemGHZ12bUR1oHG
 P5p/PLNFwb857IjIYoi/EshPplf3CeGpusEtXIpywIQ0ngR3kg3MsOE4LpUlWIGkFZthOKfV/9w
 306pOl7WQf6a/hRiQur6nGcHN08EVYeS+QCb61sG8sICkHqfeCVo9BuqyalLzIlUw0fQw9cz/ke
 5CIS/MQuUNRj9JE1iVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX7qnMBe/cFtQO
 sZROR2wO90vUqJ5QAaCRxPI27HhAN1VsB5yO3xMf5Ciaz6JgS0v8Mu/yfM13QiyvPWXvTZAufUC
 nQJOkCeaw8LfULoVgVlcJy4DT8V/c7M=
X-Proofpoint-GUID: CKmqPw59Zgu-2laKOpGij60asipQEQ4K
X-Authority-Analysis: v=2.4 cv=TK7Q2Fla c=1 sm=1 tr=0 ts=6adb7627 cx=c_pps
 a=mafLo/wATi4HPiUbedi6XQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=p0WdMEafAAAA:8 a=nBcSzHG1sGT9XIk_YmAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:

  Merge tag 'pbouvier/pr/tcg_tests-20261022' of https://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)

are available in the Git repository at:

  https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20261023

for you to fetch changes up to f2855f7fa88e6cd871f5a3671d38e4af70afed5e:

  i8259_common.c: add missing 0x prefixes to "info pic" output (2026-10-23 14:45:31 +0100)

----------------------------------------------------------------
qom-qdev queue
- Improve modelling of i8259 PIC

----------------------------------------------------------------
Mark Cave-Ayland (28):
      i8259_internal.h: rename PIC_COMMON to I8259_COMMON
      i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
      i8259_internal.h: rename PICCommonState to I8259CommonState
      i8259_internal.h: rename PICCommonClass to I8259CommonClass
      i8259.c: rename PICClass to I8259Class
      i8259.c: introduce TYPE_I8259 device
      i8259.c: always use cs for I8259CommonState variables
      kvm/i8259.c: rename KVMPICClass to KVMI8259Class
      kvm/i8259.c: introduce TYPE_KVM_I8259 device
      kvm/i8259.c: always use cs for I8259CommonState variables
      i8259_common.c: always use cs for I8259CommonState variables
      i8259_common.c: use i8259/i8259_common prefix for functions
      i8259.c: use i8259 prefix for functions
      kvm/i8259.c: use kvm_i8259 prefix for functions
      i8259_common.c: convert to use DEFINE_TYPES() macro
      i8259.c: convert to use DEFINE_TYPES() macro
      kvm/i8259.c: convert to use DEFINE_TYPES() macro
      isa-bus.c: introduce isa_realize() function
      i8259.c: introduce TYPE_I8259_PIC device
      i8259.c: properly cascade secondary i8259 from primary i8259
      kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
      xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
      xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
      i8259_common.c: remove unused i8259_init_chip() function
      i8259: move InterruptStatsProviderClass get_statistics() from i8259 to PIC
      i8259.c: switch isa_pic from I8259State to I8259PICState
      i8259_common.c: remove static irq_count and irq_level variables
      i8259_common.c: add missing 0x prefixes to "info pic" output

 include/hw/intc/i8259.h         |  11 +-
 include/hw/isa/i8259_internal.h |  19 +-
 include/hw/isa/isa.h            |   1 +
 include/hw/xen/xen.h            |   2 +-
 hw/i386/kvm/i8259.c             | 250 +++++++++++++++------
 hw/i386/pc.c                    |   2 +-
 hw/i386/xen/xen-hvm.c           |  40 +++-
 hw/intc/i8259.c                 | 470 +++++++++++++++++++++++++---------------
 hw/intc/i8259_common.c          | 225 +++++++++----------
 hw/isa/isa-bus.c                |   5 +
 stubs/xen-hw-stub.c             |   2 +-
 hw/intc/trace-events            |   8 +-
 12 files changed, 648 insertions(+), 387 deletions(-)

