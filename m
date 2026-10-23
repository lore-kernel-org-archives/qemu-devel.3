Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=XwXFsQGG;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=KNTEIQ+S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjQ-0006Gd-5A; Fri, 23 Oct 2026 10:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjO-0006GF-Ot
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:58:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjM-0002MK-Ia
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:58:54 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE7WVq3886236
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UVQ8icL1THPYl+swTmBIsYUq+XC/lhqNM1v3t1VRG
 xo=; b=XwXFsQGGQkOtMMh6xkrmd/374UwWqwHlpY9mIMlMF9ua3Bzpr93igg7xI
 4QOuKerAAlFbrGc3NZzhMiBXrffA4/ykfTUwsWVKqiC/KvfIkrHBnyTrlolp7PNX
 vlPnS6I/OLISjbkLE8OIQ5HlhxfepAdLmklNndtDmcwmjLW89RPRHFM9US4cbI8u
 45hJJnW67IqPpbABdABd2Uo1dSjuX9S9lPNh2P4hyL+neEtEgyRL9Z6fi9SoUeKY
 nK/DgnPqiI6tmcnOpBMo/gGcJVmv2zeWzRynaKRO4rJgIQ1j00TQsK6RxH/MwEeR
 MsKh15FkD5Cw8FiEDqhvWSATDnSMw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023121.outbound.protection.outlook.com
 [40.93.196.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972myt0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z14aCmh4e2wIR4MnIK5MKLlJxTFYz2GrPNenVJ1gIZXp/ckB38ODBcj1Vs5DieGUdaMZyM3GqvUmODIFyIlYQiOYPEY77UCROdYb//C0cgsX4oQGRW9rKmDsWasM0e56jpY9gkkbo1QdUmBiOY3TbJaDBslh7Sbd1FjnqYPxzOm9cjJAkY07um2oL32w5e++PS99+d49Sp6BPnes/Ak4Eyyw/I/YMKXQg6QnySoDXThf7uhkgUOsl3CsCeYck0RhpPxommGWZvyoRdR330HrxijztfzhbbMlbjAeXgrK/23ndbMGqPELLsjtWFFbtzMXrWsbXcBjdwrL2F4aXDeFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVQ8icL1THPYl+swTmBIsYUq+XC/lhqNM1v3t1VRGxo=;
 b=lqofVnafNkZRV6Ay0NSpVa4Rua4WPTXHsoWRmZjXdJDFk05q2PgggF+lNLrklXUrAMHRIl60C30sw5G5PD1f7l93zbiyXi/Se6Rm54RyK/9ivnJL0UKTBRuPaNxToASExrJdJWDSHNrwrpw90olvGazWJ5LbgexYu+sPOFUbkaIqVhp62DvKQvCyKHSBbQyicB9pchaOx32LbXRKWIxltkUs9Nqonlq+tZ9gaNau4qtUJHrwRd+TyPMkZeltwFgT7jd5Ey+ZFDANy+a+swTCjNsYV1ZRUpO5hhu5rURU+hsmmeAviGuUsZ+65Mq6haVcSX/W+y18K4KwDL0HTmOlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVQ8icL1THPYl+swTmBIsYUq+XC/lhqNM1v3t1VRGxo=;
 b=KNTEIQ+S1KWyox1co2L9rlr6FmvdLcQDog/ghy0yM8Vky3/x8GujIwrX53zQ4D+JQrfiZrKeR9LyCXCV1OQUeuAUhdQOEbNq/6sXRyr6d64I5mRNnmnaPP/nlyuPdUMn3D144LGJuRAHmlqNZo/xG/cQzOBXZKxbb0vhgNfxbog6EOG13rzzzec6jXsANEeLDOCqDMO/2T0lquzz/V7PAH1Ap3FU3/c7j5qXQ0yRpdqX/WzxYnUJIFJ/4GJwZViVGwMvIiqxnMO3/3JnnsfPI8F2+qHYWmGy5oXHZPJf9PHbZS0Kve5rwOH4MJN7yFUuOyDpnZg8kMvLHvS8YJlmhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH8PR02MB11976.namprd02.prod.outlook.com (2603:10b6:510:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:58:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:58:47 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/28] i8259_internal.h: rename PIC_COMMON to I8259_COMMON
Date: Fri, 23 Oct 2026 15:58:07 +0100
Message-ID: <20261023145839.34909-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH8PR02MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3421d141-225a-4174-bc69-08df311623f2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261021121427099003|56012099006|261009223027099003|10067099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WHozsq+fm1aAoB4MrvxUDW+N6QOBDRijIU/W00vXg8E3hLgSe167k1WSfOSbmNQtNFIcDLBro8AUL2w2tjqNmki0JMujHrmrkBMhJ/Pk9wVrvGiT++wQuQnvmm7QnClZl5g71JHJzzgMsgdH48qDXuzvpmeVphw5/d/gRvtpU0ApbGVbN+DwNCDSCnQTPp7TjE0dVCu6MCp42gHKv9dkWuzNPIGxAFhYtKwpAuGKzlttx7gcbxHkQOI/Y93Z+HyorY/JZqFCfiFhaqlWR3mnHDmmTwRZ4WGWwNdbMTQcehossfWcRlF4RHeL7CqjqhEdW0WAGgQ8GbcjU3LH934Sl4Vj+wCmNQYNkuznXNM+a6TvpqInH+IxllYVZGwdHfuRVJEqJLHYrJIsoqV8MQyqZzBkpd7tTLAnjYWi1KR0U88rcFIeCD3A10TcR8P4WrANU4zE55Y/7pAGshdtTH8jmBb1ThayrmEKQAh5JeYtKqNcL8mJxCnCISmY64gQaL3r7r22XWOg0MuRwoTc5pwRlzjS/WDLw4xJKehR5n+snGxaVCrf7Xh2EKkCUAgFNDajXioI3Nu943+sGiuVpfAIjvG9OxqliueF3runMluspboEOMSmGCgZbcdmrOuXX2cCrQXs17FrbenW4in+hyVrS4bGIbqmirEU0X5Llw0gWpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261021121427099003)(56012099006)(261009223027099003)(10067099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t93S9NUeG0f1MUqHkjPsqIrUHootRknmC7+p2Bwt1pgorfiEbI+tjzw7xpAz?=
 =?us-ascii?Q?NFry6X/FX9hJGua9cq9K0nr+3E32Q/0QEVmEmrvFP3LKuqmLkA37RSoJRdDE?=
 =?us-ascii?Q?piBc5H04DIhT9BwsFEc6KTUNZ/1mY1KNBcU4a65FQj2KnnEHfPe9pGsGJKiL?=
 =?us-ascii?Q?3MUukYzDH/QXYu0XNTyeo35m39G5Qgy+bv+QP4kq6g0zW2Vu+QvBM45lWOG9?=
 =?us-ascii?Q?2dyEwVHfrjq8EyEyOh+EF5d7aNw6NFVnqKSi1Y+mrwLVAm0F7xYyAVtH10SU?=
 =?us-ascii?Q?K9+fBsIAommONPkIbs3Ycs6dPcc0BuIrC1aExXJT026bbS3IPQ0Thp6WW/os?=
 =?us-ascii?Q?HcPgUaGbxQ0z5LCZR2b5J+kZ2hfO/34M1qEFDjtYddXzFhU7NZtOcqZSTMv4?=
 =?us-ascii?Q?VM47vqWYigF2fbru+X96I+vWhgycqm21sZZmecDkpPnsOQZeynRIvCfECBbQ?=
 =?us-ascii?Q?OSpyqbxv4IIBgfPvIZu18h8pr9GyXfYdDxjWh1soLj2MEJblAcZABYSn8mJS?=
 =?us-ascii?Q?Yso6CuGtV5ZnrpOFtho0TJ7XVrp2rXifeZ2wIOjWLSEzdkpBVSDELcg2Vrn8?=
 =?us-ascii?Q?eML9dAunNsyGbfpIWR1EXkl3q/M95mB9xeWi8IxA0LCpPeMxPpKO4zLooOkp?=
 =?us-ascii?Q?/kg0Y6oRnYpRjz5//uBbMj/ws6Zt1mbHUm8ZQaXCD4/Ekw1J/gOrPkGorhKD?=
 =?us-ascii?Q?aBuojjyauCMJNE61lOBaRkZe60hymhnKe/lxdYt6cuasLB0mccdzrow4dL9H?=
 =?us-ascii?Q?bTN+18WiheMsQJmTTBhYk4gncDqq7SWgkQG4jtXFRtYjWAp+eDaOb7RnxLa/?=
 =?us-ascii?Q?ACfn3V1xPcN3HkhrRkM3aXYA2GKY0LiQ1n0HTePT1EE7jHiQDN/A22V7lHIC?=
 =?us-ascii?Q?ty29b5GVzllV6fwE3ZN4DIB1l53JuF+ZwD48FIrk6G62WFsYkFbaGVEaZE9A?=
 =?us-ascii?Q?5V0UiYVscOTSLnq+9RUBore7zOr+nBArWjBb6AVya58+ffqmMqYn6hgelTy4?=
 =?us-ascii?Q?9oBgU5NTunh47zq3II8jm8/He0j5abC85RXeIkKkHxBICO/JibE0LJuJThaI?=
 =?us-ascii?Q?xauNHtgx6H/DrfatCl3Z2BeCsHOlKjoI4HxfBjozS+xcnAR/r75s0ktswJqD?=
 =?us-ascii?Q?qmBDa6GdY1YLMTwnMJKpkZgqs1z89yLXyJmk8lHb+yE/MPwoOvppsnHp4FKH?=
 =?us-ascii?Q?iKvEjvzItDeBb5jLlVLY1gOEQgsbhU/H0nDAonNH3OaUMPik8UXMRfTFLPze?=
 =?us-ascii?Q?mxd4eYBytNo6H1IdcbDSdo98bHnVXIAigVQP/RsBr/4yvdU3joR24vfFyf2F?=
 =?us-ascii?Q?fsn3ZqiBVtWKsH4rlQqXuFurvFYlwehRz4tqKU5xgxUrvHw5AcPtlQD/ySXO?=
 =?us-ascii?Q?anH2r0sK7oYt6XCjDADbmENy59GUY0A18roarmt8F6OqxzSqWz0rcqxkMphk?=
 =?us-ascii?Q?a26sV905VMNiYIDDBDo4BmFL2Y2UU29/VVxwueEFtQ9gvym9Rzb4B9mk8Spm?=
 =?us-ascii?Q?HAoiHfMbgFX4X1Jz8HUgEZVSO1n9nx+cJGeCqNzzl0UyaLo+iwQsJnqgxd4W?=
 =?us-ascii?Q?A9RE8FIUPlJiAyTGJTuCm1UWrjUtOoyMWPcj0RhquyD/nd/ei2uMc/X11wXM?=
 =?us-ascii?Q?UOAkSd7rDiRGOW/JO9e0rci3Sz4ZENHYdHq8Zl8bdEoat+NvsQkqEBK02bWW?=
 =?us-ascii?Q?EfcP96PfDAWJyyNfj0k9R1cTfVDNTIthicEBnAgXvJ+jZ3o7s2+2Ty/7gFlO?=
 =?us-ascii?Q?C1wt1YSXkn2JiBiiEB1i2y8uwwVHt5k=3D?=
X-Exchange-RoutingPolicyChecked: Hp6kRgecJex3q054d/fzjDxMLUDxF17XwSO2j2NBORnyNZ9RcI3Tvt5QMZLLkGj/c2X1dLyHVZ3udY3YFDPk18UNdQxfirKq35R+jK7yZOidW3Uf+W/C8YvhLi3nek/Ne8Xwiifq8Dn5S189tJ32n7TJ6ZNn0wsd0eC+9pYqhcn9z/2SA5fMvL7gdgOyFVOPTayLCzaFiAWslcNYAPDSzl+8kLQ2NHGWWNcxIJ8YPtFm9fQ24ZR89VhnmyQ2AvmVVnHv0VyMC2JtyDMnI/iy6tZMj9NWtz++pIONnG1zwPRCy9Tq/+3a5Hex+69Q5H/eoxcMZ3+lBSwrQDeXaLDo6w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3421d141-225a-4174-bc69-08df311623f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:58:47.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvzH89N5ifk+lbA1KXq0c24ADVzHp/Ykd+DuDbS3Gn3QOEZ4dw/LnI6R3jhDoI6HaxzD+Ba8UWIAOC/9fe1zDM06RHRrzWB9gKTqUHYeJ4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11976
X-Authority-Analysis: v=2.4 cv=burZl0ai c=1 sm=1 tr=0 ts=6adb762a cx=c_pps
 a=ZDePlyM4ypdfO5fYno2TiQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XF9Y1ugsmyLceZbb4BIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oj0ZrM2pcc98tsr1QwzKpldJNZdHgmcO
X-Proofpoint-GUID: oj0ZrM2pcc98tsr1QwzKpldJNZdHgmcO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXxvc8/+U0eHGd
 PG52k0Q1W9OcxgtneFFbswigHYHoax/bT8tM9gjE2ZoeuMzDl1ezidoCeFz2FR3COl8/hFwKHsb
 C63Qx+SE1Eh6+k3D7kCDP5gD1toEpEQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXzY21dh6gx/vj
 hFYuQFAKuzkR+uUfYGqmieQW7ZysyDzR4NMghLw7RL5ZO22HuDBKeRRJNI8oBUj0HimCPu7HF86
 lJ649BH+sf1j0acooM3QlmZsVYSN0jYtnKXh3kocFEpbY/16KdGOJFVXrK2cbFppm5VAcoIYHzk
 7sJJbSq//I06iG0imhMGVrQgdM3LRiAlGkmzfydiraG7x4+OBscQEQLyYeFanyW8QeHSjUUoccZ
 bnM868AmLJmq24JW5svY+lVK7ypsGqFyFGCGvRAw8a6wf7GE2uM8rEGHhcdgV6Ezv63MUwrZ4OX
 EWWXoad3ieoM6/KOGsdnEzlWKxCrFc3ZboJsgNw/9X2xeAi1OV+/o3yp4NBXFO39n9qpXcSByrd
 R0E14hTFR76z89hlFvwj/ei+sq8vVpuQBBUA5vlN04rDzxOkTgTbokzh6XWyK7wVZEHHVLrYSsH
 WynCW+OQ75+A4E4PgDQ==
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-2-mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  4 ++--
 hw/i386/kvm/i8259.c             |  8 ++++----
 hw/intc/i8259.c                 | 10 +++++-----
 hw/intc/i8259_common.c          | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index f9dcc4163e..54dc9036cf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,8 +31,8 @@
 #include "qom/object.h"
 
 
-#define TYPE_PIC_COMMON "pic-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, PIC_COMMON)
+#define TYPE_I8259_COMMON "pic-common"
+OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 66f37e1303..14029783e5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = PIC_COMMON_CLASS(klass);
+    PICCommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
@@ -153,7 +153,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
-    .parent = TYPE_PIC_COMMON,
+    .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 8f2aa1f0fb..52e24d333e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = PIC_COMMON(dev);
+    isa_pic = I8259_COMMON(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i + 8] = qdev_get_gpio_in(dev, i);
     }
 
-    slave_pic = PIC_COMMON(dev);
+    slave_pic = I8259_COMMON(dev);
 
     return irq_set;
 }
@@ -445,7 +445,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
     .instance_size = sizeof(PICCommonState),
-    .parent     = TYPE_PIC_COMMON,
+    .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 8ceb5841b9..e2f997e161 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(PICCommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = PIC_COMMON(opaque);
+    PICCommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -220,7 +220,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo pic_common_type = {
-    .name = TYPE_PIC_COMMON,
+    .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(PICCommonState),
     .class_size = sizeof(PICCommonClass),
-- 
2.43.0


