Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C074C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtRu-0005Qw-Jq; Tue, 30 Jan 2024 14:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1rUtRs-0005Pq-Ee; Tue, 30 Jan 2024 14:07:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1rUtRq-0000us-CZ; Tue, 30 Jan 2024 14:07:08 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UHRr2R021250; Tue, 30 Jan 2024 19:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=MhDdhgVHyAi7zIMBbL9O0vvjtCGildFl6TnwEXIcCQI=;
 b=GhuKTg+6rmNFOjeiFo4qgFFjD5AmdR1/Kgjdoh6FMzE280Vab4zu0ONjtRBXIB2w+KAx
 bgKhetw9OfsSdI/acQjcKb9GKGOwrysovc5QD5zjT09lzr1wWBJxq8tMCsNqEqnGQKJW
 7GpMSrGp4vIhf7VL5LSL71WoCZAMj+InM9j7HMf1FDIwd5qVTOtySP1p/OZpwGel+hi2
 mewgb0EKn+KvS+I31mvPLsrmOSUKnCaHC46rHNOKpRMTitBBRmCXg8zuMBzShUQGNx+H
 FQjfQr5OKdl7W2T6dFmAeyudX8UPpHxpXeWHvPWoT3wHS5WtDJ412zRO0y+8R56ltbfL MA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuyta1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 19:06:59 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40UI4bIP014630; Tue, 30 Jan 2024 19:06:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9dxpg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 19:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0o/gZh86mV26V17XDehmw0KGOkoSJN7ba2PTK3QK4Z2zC1RgbDtHguAbbcZkxFVuF5PiHvUgnIaE9qftxqT2tuKw6xPsUkINMLtKBXv0isAT1Gxu7aEfjsK4nbTq1BlADZT312/frZk+5M/TSCeM55n8Q9OciMkiFbm+2vkAWF6PwGDl8uj1P1VAeAiDVBw/DBg9Q47/zWdxg+biZBHlsevKf9zcx0IjbHq2Cpx4tJwOs+yfLytao5kAS9F9mHplMiEWtWcB6ttBcZuOyQhaAYQAtdhrMJQ5hBnIgec8SVTTH5dL9gNX7DxRy1ODTdm3gKyeTGKv/sgMc0GlepArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhDdhgVHyAi7zIMBbL9O0vvjtCGildFl6TnwEXIcCQI=;
 b=jSO6n4HsPeHP9fFc5K+4ct+1MdixRXc71xbORQPKMYkm4F4UvZ5EGT6Lu2ewS+5QdFonSWGOatdLfk2pFjAMTQ7MKWG+bosyBV62TCBfNFRW6HxXS/9VQNBoGMxBjV2x2rpytUPOofFv0/FnhfKSb3CzLkB7HhzGgE6O0CXSGmghkkn+FatersxA7NNdTipG/HTWu6JABj1jfdI3WwI3VwwuU9UeC+cHFN5XsyMOnEdGsMHCz/iozyXYBqE15kUI3MgGcSIGCdOPNW5AljzQEgbGxpTczpwfuvUBV/EK4w5jGNsKihfDNw7IVqzi8E2e0+tpAK9EThYxJihENUVhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhDdhgVHyAi7zIMBbL9O0vvjtCGildFl6TnwEXIcCQI=;
 b=nhBqGTrvpuxz0O/V71tB0oLbXkZTAuZvsXWtJyLIvkQkN9mFPkRVd+5omSlSQeT6q3Zqj09qk1x7IynnaGjxL2opkv5bLBGCoXBQzidr6N9bFGZzD+rlk5tlBU3V4j5tAEkqe2Mpb1HO4peBcUC4Lrjec94ga8BbC+p1eit7BQ4=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by SA1PR10MB6469.namprd10.prod.outlook.com (2603:10b6:806:29d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 30 Jan
 2024 19:06:56 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a1c9:d6c1:b94a:595]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a1c9:d6c1:b94a:595%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:06:56 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: qemu-arm@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com, william.roche@oracle.com
Subject: [PATCH v1 0/1] Qemu crashes on VM migration after an handled memory
 error
Date: Tue, 30 Jan 2024 19:06:39 +0000
Message-Id: <20240130190640.139364-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZUwCZdZj-vZD1NJC@x1n>
References: <ZUwCZdZj-vZD1NJC@x1n>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|SA1PR10MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c41730d-f326-48b6-4379-08dc21c6a04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVyl9ZgVN1rzr2aJMZu+40FDIygzMBTmpD6BeWj7XYQgIEsqpgBYx0oQuGvXAXWdToHER145eg1gRXDbw8bCTMknGkLLrNe1R6PJUgvDIqw3cOWRaQTeIFrJ692YQT9BsWghI20E18zH0frurnZXueEv4NkkgRhRijNxm+tISGF6pF3MBb3V7XCOAK+QgmT8A/l9fLmwvI+ZTUqPj2QkZn1Fy0bHbv/XLqEP36cHzpgYC2BuxcuJVDLGyhWy6pl31ab+pcJWrTlksBEOh5q6GVJLNTBQno1NdX6EjDeHKtdbLDVS9wHSzLYU/TVh4+uju/SyFYeM7XCIXLMJHrtQ39O5+GKZx9HUUgrsMBZcp/LqqfIg5EIpI2L/EDwNZRgDlhABhvrHMaOemZbhjXqGy9zCokZzAp6b3+RVPcN8HL14P6C3QLijNW06jn3lQ84/knlParQA21WNYV1ADbNPJHoJnWP2rF58CmSZfuxXLyT9nM4jtfepEIa0U0RFfZtHdack4801Y2nSiUfr8xz3MIOh4DRDr49to6TgE5jWEW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2906002)(5660300002)(966005)(66556008)(6486002)(41300700001)(316002)(4326008)(66476007)(38100700002)(2616005)(1076003)(6512007)(26005)(8936002)(8676002)(107886003)(478600001)(66946007)(6666004)(6506007)(36756003)(86362001)(66899024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbPE98BUobtMdI9Meof1t/zzrB+JfgFvUXPvohbVhWM1XYUkLgBwUvUmOnLH?=
 =?us-ascii?Q?MvSIJ3A9uDy0atimEfjsGnp8s0aGjFzLQSgUOXxa3xMpYWzAViO/q8I7ZFaM?=
 =?us-ascii?Q?0PNXI7QAAN841Cb2dKoyFnz7QHUFg9aquPc9rXMJ6dvahd551yGyLRjHAfLX?=
 =?us-ascii?Q?p89F9+IFrFflRQ6tAQCesIIJ2kc+QYfGcFBYmPJmsnhVUdJ7maXsgoXga3Es?=
 =?us-ascii?Q?obCBOtXkosD6wGybd8vFdV+kM/K1Le1e2kXq+aqSH82p+qLVhFLfL9U1gP4U?=
 =?us-ascii?Q?zumGMT37uFIST9CrA3tec/QUy2R916oFm4pHNKqnKGnYmhJHsnzyvl+Tkcmd?=
 =?us-ascii?Q?Ph7r4M8nrt4m2GJMhN697A6axV2Eb/nqnLImD2ct8xsdo0MkkBC1XM7MEeHU?=
 =?us-ascii?Q?bnHQWv70sxAY0eMHW5A8TXqhETFW6D1X6fWgeun+E/bmRguKWfNK3Z5b+mTZ?=
 =?us-ascii?Q?d/DzsUulh++xVW/q/Gxt4t7KhUTlJHPugUrVFSP7x8BRx4VE8v8E5U54jVqB?=
 =?us-ascii?Q?7n4WOzIhFzXlcLrWsrJOGEeyGHqrdDX19YO2YmNUduwIiVAH72ANYBs6dFza?=
 =?us-ascii?Q?Af2lgMHwenRNMN6wh139bSNj1NU4k4dtYGmGu7hjHBC4ZLvSrowKOc/Zth7v?=
 =?us-ascii?Q?MFWiR/Yct5XsRjzuHm7VQdxjTCMdclc8fPu3C4Fn+aoAyp9NyCsvsoaP34Vp?=
 =?us-ascii?Q?m6kmxfQFvL0jO9bDLkqK6JnEihr7dFrkgpYcmrkScHpd1qM5prV59m1XxlRX?=
 =?us-ascii?Q?LbdmVlBm2tbwdRKld/U2cf8IgEU9cQa8BpkVsgPir5IQ8D9yreIoBfK6MQjH?=
 =?us-ascii?Q?+Mp5nxF+KD9bKuxbcm6h9xjpU2VU/mlukfjDXVWEPE1FdPGxhVqrAtnu84FG?=
 =?us-ascii?Q?8GHb1BLom1gKSu1rNcn8BLzvX0UaGCzb9eeL6d49WA5xBmaJs3biLqFs/avx?=
 =?us-ascii?Q?ro9hnXSiRkkiUDQvyv5BSW36ugugrWtgyDlHAXsHXqiTF09WVol8IlFtcXki?=
 =?us-ascii?Q?we5lYMc09egVFI67hFMAIpoBinPNfTdFNn47K8WOJC+cesJd3Cutnqi6Libt?=
 =?us-ascii?Q?gaLUooshy1bo6Aqezw1irRcH78fLS68tRC80iRNlYPjgDLLCX/slXJUg80ef?=
 =?us-ascii?Q?5Mb3NAyeDYzPMnG+2wpJ0B5wGoQsGlswN6gtrEhCjSEooSmSQ9vwdIPGXQOe?=
 =?us-ascii?Q?+mQtMyC+shlUfgUJmR9OjtKTKqJzdPLE25MJAzmZn5TG9RLvmlHoYXpeBOWm?=
 =?us-ascii?Q?3fdqis+vITTKhJaU5MSWW50SrWBoXtE86gkZGJ346R1uGG2c3RG3cWgtY2F+?=
 =?us-ascii?Q?/2xMXl9bAPvjQ9SAOxmwm+xuT95VnwWPBcPBMHgjtnZjYPa6O2OCovsMw39E?=
 =?us-ascii?Q?qIzczacFfqE5jH0UaywsRhfxN+zSmeaST0IwHzGJ7CAZ9W1jxSQ2LonsaVt8?=
 =?us-ascii?Q?63UkmZck30iECtgTwM8NRKFyTzBrkvrM72DmlyiwXsVJbw48NxrvX93zQ/s1?=
 =?us-ascii?Q?BkuDvHFmFpEMcPwDXgPuPHl9SpdU77I1HBr7gP2l4d0XNGvSbyOfoUIbHYks?=
 =?us-ascii?Q?XqY+vkLk+V6RM3M+42klplQpZRLrabWdEVAYIDofUdjKyGMDlhujMV+qJ/l0?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +BO1IeHnaWHcBQAhCbQxXbocXbjrzGo4fcLJOkp/oL8LisWiLESWtzlSZU8VYNVQLxoTEsSXF0MLdp3sfEwzKmIFnC/DzLdO5pXZakCz5+bjYxsPlNOW9sNffjRkbUe7LXUgqIpzvP0v940vJNSVoR2rK5EqS9QL2NbFvQxh5p89GhMnI/11dh7iV4ZKw0D5BBYuzUPHPCa0pRX9OP5Ece3DxKm+QRuYgUBa3spA47QmPrPAWL2+xh1M2uUc5F//FIP2RILA9uLInYByYVGSD1qsYPB3aM/TULozTGg85+jdP8q6fCxt86lE8hSr5FGPT7CXB2aQ2KzDc1lIrODcChAb/YdNRqdD8m0bgOzwQiBEgJ/tb/ptUAwzNbywIDtqZqiQiHruTEcITLenLekmmGTMDC9O7OXHCgSxo5uFB44O8yIQVY/BsUxMlVlAgeSOKhk4veeY8SfZUBbC+4CL6A659AysqUnGe5OQsNG/9mzqVMhoAMZoljl9/8qAhkuA8Ky3GuG8yV4WnHU2uO3Sk7Kl2ZFPey4xe3RLAiGzgI06QfdpZa5tsxaVQrg8dhWDpbPNsWEKBE3aW8T6xg21Tmk6/UsVb3JwB//UOa2xW3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c41730d-f326-48b6-4379-08dc21c6a04f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:06:55.8557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMF7wK2t2ofrS0NlaFBns6TpqezBcG3gCoe2rneWKP+hUjaLfiiGU4PPwhbvOJWzKmYgH57OjcLOqZj5SoPfg63OOYdO27zo7c6bkVnl9qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=852
 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300141
X-Proofpoint-ORIG-GUID: H78oidmYzE4KksUJx139d0AD7w81F_bx
X-Proofpoint-GUID: H78oidmYzE4KksUJx139d0AD7w81F_bx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Problem:
--------
A Qemu VM can survive a memory error, as qemu can relay the error to the
VM kernel which could also deal with it -- poisoning/off-lining the impacted
page. This situation creates a hole in the VM memory address space (an
unreadable page or set of pages).

A migration request of this VM (live migration through the network or
pseudo-migration with the creation of a state file) will crash Qemu when
it sequentially reads the memory address space and stumbles on the
existing hole.

New fix proposal:
-----------------
Let's prevent the migration when we know that there is a poison page in
the VM address space.


History:
--------
My first fix proposal for this crash condition (latest version:
https://lore.kernel.org/all/20231106220319.456765-1-william.roche@oracle.com/ )
relied on a well behaving kernel to guaranty that a known poison page is
not accessed. It introduced an ARM platform specificity.
I haven't received any feedback about the ARM specificity to avoid
a possible memory corruption after a migration transforming a poisoned
page into an all zero page.

I also accept that when a memory error leads to memory poisoning, this
platform functionality has to be honored as long as a physical platform
would provide it.

Peter asked for a complete correction of this problem (transfering
the memory holes information with the migration and recreating these
holes on the destination platform).

In the meantime, this is a very small fix to avoid the current crash
situation reading the poisoned memory pages.  I'm simply preventing
the migration when we know that it would crash, when there is a
poisoned page in the VM address space.

This is a generic protection code, avoiding a crash condition and
reporting the following error message:
"Error: Can't migrate this vm with hardware poisoned memory, please reboot the vm and try again"
instead of crashing the VM.

This fix is scripts/checkpatch.pl clean.
Unit tested on ARM and x86.


William Roche (1):
  migration: prevent migration when VM has poisoned memory

 accel/kvm/kvm-all.c    | 10 ++++++++++
 accel/stubs/kvm-stub.c |  5 +++++
 include/sysemu/kvm.h   |  6 ++++++
 migration/migration.c  |  7 +++++++
 4 files changed, 28 insertions(+)

-- 
2.39.3


