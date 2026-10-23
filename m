Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=I2b6gklH;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=loYVkZhX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjT-0006HC-4m; Fri, 23 Oct 2026 10:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjQ-0006Gf-Or
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:58:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjP-0002MX-53
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:58:56 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE7P5S3886097
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=10LeJ6YKLhaJcimZcKSGO/cigEtOMFyMSvI+7ZJKy
 gM=; b=I2b6gklHxmNjLPrAfUwca6mjkHJmuf1h51c5XTOdXi4FZi2njYrD8HpjJ
 N6qlOP7vxnvCy3sh3uTD6HMIFRnMCzzVqNnGWROxxexZ9dA8AkgZ8/isSSvMZt3E
 fMbxG1YRIyDQW3WEIel8TErdAH/oN6JoGEd4hk/WWgQVErJdh43XALfPkEI0IjF4
 r34dEiRS/W52F03w9Tm0lQl4wdzWSX+GDI77V/G4Nrm+TCKxSmthrjgNk1iE0Ewq
 ujfL99OQhkJqzVpak7pDwz3xH2DR8VEgtL8Ut0I2/wTQozV88mZo8LJUHEZB3zGA
 xRvJWhGJ0fduyexGOVyvuQvoupraw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021108.outbound.protection.outlook.com [52.101.52.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972myt7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEKE5+ELinnRz2BQ5PwkCM5sB/RAFoggOCJW6gGakg3yW0KyvxgQ4h/K0braXWw9EaNLGw83OknSVeDkWy6m3XcBwU5reEpslvVzJIPljncEIQLN8TJqybQwehOh5+j/rRa8z2jr0/5yAEKSH1gKTUjOMdp4HR3POmxf7WMiL5vFZbKVUFrL6C7L5mLnZkiMtXeC3D49FiCavb9Cuaux3L+ivrMSf4Zob4YakxBpT+42TBvbelg2YDd8jzfKKhkMXFJhPOfhv0oIWb3rKwebRDhTmvMmVCs7jLUhHOd0PlkSW0zcTWtuSiHXSLKXfOZDhiz4KTvfyFSqgGt1QUCQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10LeJ6YKLhaJcimZcKSGO/cigEtOMFyMSvI+7ZJKygM=;
 b=p7YKg6Rlnh7ywC6X5i9DgiVrGVhnedQbEGsIlTv2YGNfoTSPYgR1ICiauLdDhWfPHF4diM0TKqggD559gyWCbnEsWPtQsJLQG5C9uufWUNBToSWJtnRN/YAjzlzjQGGAa5tatXimbEmrb2Sk+V7Mykc8fqMqnu9efiNkuBc5RCNxXVmzvZs5KAwqjQOwSmGUfO4ZVKgRTrOkzTB1WEA2SKEoRn8yB7Xzl32OPp1qL4dSxLYtUU109Vv8gLZhXWoUnFksJN3uMICFYiKjNredb75O7dh4nAT6ALlO29PakeH86Zn7g7vuUQxJAfFOFMiopC+mZ2G2koscmKyXAhEXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10LeJ6YKLhaJcimZcKSGO/cigEtOMFyMSvI+7ZJKygM=;
 b=loYVkZhXQAgSXg1CjAy+HQo3z01HauITnlYmAV1dQdfsnxlfXij2aJrdEctMKb/iBJsN2Sfmty9y3ZtkwgUzTpanuznE6/UbMmMnHsmj4+gIUMuCbx/xVTAOFbBX5zhxZ0Mz9jHGr2KaH67bvfGDn0wyW823liTO5th2vLC7KvEfy0DdhDk3RglOkop11jyKJGIQ4DqLNog/eD4VkQ8/+peb66+Oplofz5j8E970wWNWKKdP2x2Fc0W0Q3Pcs9iJ8NlknWkq6WU72J9xcLWtbD7T0MBWhDpA/QWi1cl8SJzrwdJmRsl9Ekay/VMDuB9mQMCEv681Xfks70qgz0ewAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB11361.namprd02.prod.outlook.com (2603:10b6:806:4dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 14:58:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:58:50 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/28] i8259_internal.h: rename TYPE_I8259_COMMON to
 i8259-common
Date: Fri, 23 Oct 2026 15:58:08 +0100
Message-ID: <20261023145839.34909-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: cecca0f9-8d22-4652-f2ba-08df3116260f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|261021123027099003|261021121427099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: IeUeHPqU9xUSR0XT/U/GgVxJf3l2TJE0SINdzKgmsCCwuMoYBH+BsG0HDnmDMZpwYX2CGWpUjarRlSG7muAiW3kdvVFbqWkYeouLXRmq4cXkUonS3pyJvdT5uAkhlDh6H6nSlmcsd1T53MjJUos7/bABYUKqzs9gV3PqM/Te3ZEWlN/NrjEqZSwcaJtuHr1shkB1dqtoofwNy9+DEc1pMiWmiMc4HnU0dlex57avWmzcxASkzHeFMYOk5+x/5TOdwey2dPdfDF/kL0y63xlm12Yfo1zt3C939+iawMdh/Owdz9ZHSYqr3owfAxgeSDLFGPejSSEMq11VTXsZqBA0ytJRGM/1nyRhlw21cTsf5CFE+UGLVJaUdHBSEmbkxYo9I6HZ/0CkRUcWGdLbIkje9WRoZ9EtQ7wzPSKJ6J/fYqpLbbmrjWTeyByWuy/+jb6mf3G06eAJD/v3FM6UvNM/SlWob7U3sL6PwjfKESsVkRN0l3Erpa/jNnVN8h/ZyTCmJBa+zfihVH3r8GZYn+0yebW4BWe1hED4h7y5dVrnq3oaRKKaU7+IhS5wHc9aZqgNhIbG0mwaZ+L1A1KZ7z8+oWSEy9MMFAJ9JMSYCr+ka7XxCgWm2/OPy7Ytk5L0s8sN59K6syK7GBXIetWun0IQNugQnHIeByFj+XX6v3odKeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ehmj+E0lJ9kNLnyiw8W2TDxBqDURKlpYf/wUQ5pm9ds50AsHYg1/P/rg5EJc?=
 =?us-ascii?Q?UwybU4vBjtRoZUFF3YVkx1ui0CVCjC3GSBUYKLykGhb9Gr8F3zlRKAfIEbWF?=
 =?us-ascii?Q?IgShLuGjhvwfZnae8uKni31hWpIGMLmJzvLZDPkJFYZRf4NLo7b57vJ9nZfs?=
 =?us-ascii?Q?qP8FZe1OWiENi7X4+cMyMnfDFdHN85UnQTStxbQH1N07bAq+zfjo8ddCplNC?=
 =?us-ascii?Q?IwzSacvtnVZwT75IRWt5Bl1uHCy6yIpC9cfQMoLQjrxyWcdCjdMelp8VU/ev?=
 =?us-ascii?Q?NiddMlqrdngJpu0NkYXmNhfSsziJqyJIPJ6HXHBlYK2u9QUdLpzMabNSn9Wz?=
 =?us-ascii?Q?EgyRXd8z5eH2EICSKre6xOsW4tATRmsXbzqvoD812LHRgC2UyP945JZdMGnz?=
 =?us-ascii?Q?PwP8rNpP4fKuNt6nuzPY2fOPFyCCoLO/r8IOh1cXFhL3dCWxu2weJ6KryfZz?=
 =?us-ascii?Q?O8jwFJP847myTnIhhk0uFmiB80cXY0WPoSx2xOjBnpjMi4fRBwA43dOhsfAx?=
 =?us-ascii?Q?bwt8vZ7TI6vSqkBoKi/7LCnvTLdSXaMdY4XwHacS5LobiLzgv/YKpi/e4QRA?=
 =?us-ascii?Q?A1xvAWU5fbSdkn9CXX69yTCMY7XXldvFRhsPzi0gMeFzlxewFThFebBGV6gQ?=
 =?us-ascii?Q?2yysVdohSWTcMRkxCN5GTasnLHkdT1MLeTtFKePyyDrkmhDRE+vC+N0Q7ygJ?=
 =?us-ascii?Q?gnaDz5hBAyrjcwmQmRKMrNyt2/3a+YuUDKXSdtH//lZzw7/xA4tgxvJUPyag?=
 =?us-ascii?Q?IQtikfmra+o3lXmzZoUAbRCDKdVJUCrYwTtE6cQD5UQ089e9HzNB8QWy9PyX?=
 =?us-ascii?Q?zNSVz0pQhtjRhkWrKNFqGVeoNdlQCrbipQj9ivSgbtv8nEzX4Z0gfciWmHPY?=
 =?us-ascii?Q?8vna0+w+otXdL4WfLiN1m01wUhBbN6s/Dz0ATDisGkcyqiH0A3dnVIAOdxt2?=
 =?us-ascii?Q?qFt7ynfW5QltlGesrfLwmnkixA6Gjd+N8dpNdS9G5r5V8oXNnIMh7PoLr+QC?=
 =?us-ascii?Q?+nq5SgSuIm0JQdXB/TXsi5wZoVKZiadYqrrcqsHru2gkmvZGOllL97lyZep6?=
 =?us-ascii?Q?WYwPeGcvydp7pfOX+M7dRhZ9uoiUlUeLDjaS/pH/BJoMGxD1Yb7YsAWTzni0?=
 =?us-ascii?Q?jnGpAG4l6jx0eqgFps0Unvm4H/KSEtc4r5gQFsYvSYUDr8v4WUeo3QJ/Fdf2?=
 =?us-ascii?Q?MogpUxkcupbyj+mRjDL5IgqKmPMA81Mot4fO/tob5g4sYpAuGvxYjb6GgEOW?=
 =?us-ascii?Q?zCMuwex1lofLd8EluskvBWp5RRf5i/MG/Q0RcpcJj/RU+a0JBlIkwdHD3p1T?=
 =?us-ascii?Q?F8EWauymF3sklm6jG89/o/0f3vNv0gn+sK+g1Dos1vYIL24vqO+Xg2/9YXw+?=
 =?us-ascii?Q?mFOg/fJTbdf6w7VlUFZX8TRQxU1+3kXH70vilz6j69qeJ4aUa4VcRERIyUI9?=
 =?us-ascii?Q?CozJbF8cpiMcoPXqI8uEZaEun8SuDg4TcdA8alSNOpVcCjojqi6rjkCPs/uV?=
 =?us-ascii?Q?ZFdM58JFzFCyk2mS41Cmy/GR8CU/ZlLtupWN8Mhvt/2GGL4nca6tdUCCsjeP?=
 =?us-ascii?Q?ep6yJ0Yk3YvGn8IAp1H2bks4OV44TIThQrHZ8+/Pxrv7RmylDCKcPqMHnsi1?=
 =?us-ascii?Q?IJ9UkNJlIaJs5fk8gn8hacYWJqncLqzZBEpLHLrl1b996v1d5RuTPYToBuA7?=
 =?us-ascii?Q?Z/Gll2VJLXgWxCPGrWLuV0byjwVMKK788LEP1StpIFqRWZaoyxdqHycfpE55?=
 =?us-ascii?Q?cg3PAwPDjbB7plOp056ppdM4f4//iXA=3D?=
X-Exchange-RoutingPolicyChecked: cw2O1ENDqzi3tXxczpRglYIGwS2RW13HnSoKsVNMdRC7aoVGREvKMw1CCyObIOB97Iuvjsg7Kp8P1ofNMGAEy825RG4NYBG+0C6vhBHmlQluQuQMacc7rsmC17oR8iSTgpZ1t2ukjLzqXhY8Wx/da/7Z5q8I1GB/xoKt0s0DeIKGx4ry3KlOMg2HFbAS5rUBxr6dpgMMLKrgQEzPD72bxMmuj37oGFDSrn53Usk5N8GJA/HET+3zJK2fzSJsnW9KHsOY+jrQQW6Umrqo8QZa3/fy7JISBmUbYfK36wJkODvfLd0YSpkrUqXx8OYIY9au+Z+LR/QkUvf42wc6XTuOIg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecca0f9-8d22-4652-f2ba-08df3116260f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:58:50.8172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 562LZyiiceJJCOYn+EhSy6L4scVrMrlTqNs2EDMzBf239Vwx9TkJ8tBjt9mKCT4eiYglLesMwPnt92+RGYY3u7YK2/b/BPzsCsYfydsh0pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11361
X-Authority-Analysis: v=2.4 cv=burZl0ai c=1 sm=1 tr=0 ts=6adb762d cx=c_pps
 a=YAKI/8xHzFBsvVJXN74WDg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=xWlEjtkXqD840QCPih0A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: v_AHGjaN4Zck-1JyxyttfH48yqDiVcZs
X-Proofpoint-GUID: v_AHGjaN4Zck-1JyxyttfH48yqDiVcZs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX7QOTef8oDByG
 YbqamGmZ7eDeqxhCawclIXnnSlR+b0zJc82brTSVtll/NqXHEed0TE4tKTfRVHr9D2Entvz0VGo
 v5QZEsklAveKfS66oVSE0SxGumvt33s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX3SGF1RP4E3lr
 2hENdRJa3SZlkyymIanI+kNdUPAhChJDa4QG+gxg0ZzrqMyJQ5qhy20oqgpqU38aiQglV6A5m4a
 F58zj+/2l8oc0UAGkcxpxomV5kiH8oBaxdICknq0Hsy30TkA4AReQFoIG6qavtT4OoFoulAUAb3
 0/rok23VxkVuGEsP6vidgaEQdazoVcgFPTDQe04AUHRJGrSyWXhooVcQzBDqzHEhkgiad4j2d/m
 Xloa6jOme8c7zbKbGgrdWM1T9WggcJblhOw1gpjGRZr19mM9OdjfARwf9rFV3X68KK9xoN8Pi4m
 e22bPVndG4ilZYRTD6xG4DYyC6mIj96h0wwD+z7glsy1kYl9Y3mQPi+WiRIgYzqjKYbLL3P362a
 Q9+ro+RXNZeiWwd99dIPIi9kMMfkrRFeUZ2s9FBleEZyBmSOOdcTIuORcowreg216KS2lgmZrgz
 aBZkYUb48zKhjaCZtog==
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
Message-ID: <20261019120517.1448687-3-mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 54dc9036cf..289d08b7d7 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,7 +31,7 @@
 #include "qom/object.h"
 
 
-#define TYPE_I8259_COMMON "pic-common"
+#define TYPE_I8259_COMMON "i8259-common"
 OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
-- 
2.43.0


