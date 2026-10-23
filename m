Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12E606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=sCythyJc;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=tjlV7Wk4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkn-0008Lr-5r; Fri, 23 Oct 2026 11:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkk-0008C9-QI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGki-0002Rd-W7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:18 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5uJ23969197
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Yw5en1PAuNoZDYvsF4vV4Dia5fAISzQMeuOhvf2yy
 Mw=; b=sCythyJcLScFbPZMO5xQVRc0+4qIWy7Us+mn5jeWQqFRepr3Y6Ys//dp2
 8ZUXmh6qlR9ddd1SOWSKsrWD+65BIo/ukDz03R1ZzWnwKSieSBlsPwANpTsLNYDz
 rpNFFHxZGmx2bf4x+jESfpzId3Xc8utKk/N0He7IzQNzYdEIOiUyo4ivy5SBrB04
 KJmybG5SxwgHfuj8dh2HiswZP6G2jztZZmdYrgRkpYMLJvefPeukkKquVCXSzYfU
 viFaDINpNsOdma3B7RPMNMh+thUxssrpJRoF5K0UiW5lX+Nd0bQfvD5tFNN4XYTn
 oGvcR4h4Jon3E10KesNSikv1Ggc1w==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021120.outbound.protection.outlook.com [52.101.57.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf973mycy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ng4KFTN02BmpHvvc2id0XLjKu7QHGvRNRWVcNsBEl3+poDmqf3V38PK4ziNdmrFP+LuQvYVyQbv6FQ4ewSVYYmOXxayAGD6FKKV5XGbZGa+v5GF3GITr1eGX08qk0pJyeXN1vtjkEe77g63oMPHXNcZ1buI3bi0+gEEUXDmyQXwLuXmbpKUUeUEHpg7GOcM8s0qbCEwZvVAgCsmiwTbRvhDlBnYDpYb48vy7X5JvtgG1EEL1MiUSmKwlzghOl12ntltvypjZYA40aGukv8X13SNLFTtkLtaikugOPM5BWuHO9qj7OO6JXeXKnGj29PrylGlOP8jYuMNZpUJndCmW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw5en1PAuNoZDYvsF4vV4Dia5fAISzQMeuOhvf2yyMw=;
 b=VqdnlYWaGZq/w3J09F3tzJJAQx6V6hxOo4+ajoEv9nhLAP0HscFnmi5J6aP9s5+FcNouDjpiU+spidKRFUXyuM0N1XDicnuwq0RonMr7x9PLUzDXe1ycZQa12UTMGdgSQ5rTHF8hurcWkOoRkx8oxRRaqllYqI3KiB4q4xJ0U/A7BTDCHyI8lJTFccGGhE1hqRizq7oJBZwChhGDj5xLv/t8baA0AB9AcBqc+PIG+9lleRjKQXEWdMwoXqFxflPNB6NKv8STsjuN05UfnPmInfIj2T7wqftYeFX0FlNAhFLzhjPB4aqkQlMSif97JFDnBtQcsYyiBUWab+rhgwQ3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw5en1PAuNoZDYvsF4vV4Dia5fAISzQMeuOhvf2yyMw=;
 b=tjlV7Wk4ZSR9ZzPVbH4pEr0lsYlHhpLEfWFu7rJmnISbD9LU3O0lq3xcmxDJ9yYcV01JFArHAnKCpsrCLHZb3REl/1ACJWU2n1vRN2rKm6Fb8Q2whHi+ZmO0Ebk4zboxglxWQhjcQEifo+N5s5pS0fmC0+pssVdSVZsqBv9ky+imq/0tjU3ZZ57rGAdpwOAqlmaeegVHd8OAn5XnqNcFwOLRfjpDHPIoz01YRkVsOMlzeFwybYET0SNKprQ3cDjZAVr29zL/HOAqfEWyhQiUTzhCFBGpGLF60EDldBbJ8hnPqQ5x5xWXWDp+58t84lyO/APLvBPk8QtWvmjHneh+7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:00:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/28] i8259.c: properly cascade secondary i8259 from primary
 i8259
Date: Fri, 23 Oct 2026 15:58:26 +0100
Message-ID: <20261023145839.34909-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0e123b-d7c7-479f-964c-08df311651f2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261021123027099003|261022075727099003|261021121427099003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gzYkjRtN8pEjgk5JefOWnNANHh3rWnsqEJSkWXlQxFrve49YAAo36b7A0TzkNBXZCZ2xPRPQTyql8rIZRUvc8uKEDc1Of4H3L5/BFOfsEOBNSoMCppk/bVB2ddexgYpm9aDiYplgHeGb+w79uEXYiwgas8O7h/MkEay9GaUVWAkaBbsxlJPu6eO4rTikBdTEpj5+5oEhNyIY99rORLsD1IVlYlX7BPONGhLViGIb9BDu7YPB8TXqU6R7kgdv/jQ2mmNQN00VLKhQ0c8i0ZqWhh2SWHs1m3g/ghyQ2osjbdurR/w1gR93y4S5VsDNPIZaQRY4wtQ9KSUHvxzCPF2Uk+o04z0qrdct+RImIxKf1SjAXcbKE/gpnVhV5ObdEDEpg3zo8KjySMiTdvi9AT1trxCpvZOHd/TMOzrQZZoSPcr0fo/8LJWN7K/tcryCTOvAnqODXNsA7YwNh0T7p3Swa/8nvC2KT7arZycOWVO4ZbLv6oRw8hI+Hiqj3XkoRsgupWOnsvrtino7v1C5KyZev8/mG6DnmQ67eKkr1zupYaGY9OCdQCPD7sJ7MfugdcWh5h9NG7pSyiKiiwGUNJTtkXHDNdiOgOVhmwbPWxRz/Fa4LRn9okE805ced9R0piMQsMAMJKG6/iylwCGirC83Yf2FYnb7MYvT0Fd2LrHIPgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L6taT4iNt0gE6oFGCRfqc7kc7RunG9GwOM3PauWOJ4W3VETmh5IqBCGOQO0k?=
 =?us-ascii?Q?xaN4FonI24+6e03O5xXpoAxOPXAeelbPVA42RRtclMcP9gBUF+DM5OYtk/os?=
 =?us-ascii?Q?TSLnzlbl+Duyz8lpTZqc3Uy/VSJ0SKeQpDmygCbZRvftPF4KNBSK0cSInv4g?=
 =?us-ascii?Q?Z7kzMgvEEK0+OzcnzEQMYuKxGh9u2eBsx7Q0ND3X/UZTUMkjIW5WvjXuoe0j?=
 =?us-ascii?Q?WnJRzNwQQHKWDH4O9WIzcfkkSmE5XniIupkiUdmmU8L4Np1ZH9xrj6mz5JFc?=
 =?us-ascii?Q?yf/51r9HuTTbdiTVPfoMiTrZDlj7XK5cS+jQlenklkX3OOmrQ9aherYzP/B3?=
 =?us-ascii?Q?C0NWyLY1unyhRUykt64l2e1+NhDJVQIJowHtfv94OY0m3+yyoomIOfnXvR/T?=
 =?us-ascii?Q?OTyln7mMvQcsMtBibKHw5IPtihyRDN5Ct2jAq5rLCidhfrkdTsPTgO84znYx?=
 =?us-ascii?Q?FY6BDJ/Y9/XglHKsG3L69xxMDVCpm4dufAVfjygXJzoRCez1qrZCOQoIXxzk?=
 =?us-ascii?Q?9q1XGrDoQvtKScHIETfwr7d9jFolyD7MQFU6bT3Q0uGqbnE+mnI/I5kW7UFw?=
 =?us-ascii?Q?mYMqRk+IELwR+8WbI4UF64Zdqqks8FR0T/IPcJ+1MaVnhrJGPsb6T+AfBdQk?=
 =?us-ascii?Q?SU6hPuhomfOKELz77tujEcC3NlgtRUqB7vuu8nOaxfIWxVcwRpNaFpe2szUo?=
 =?us-ascii?Q?tbl5iYcwTTf0KRh8nO3kKWVUkY0uCElxA9XD5Gz34gZXwBtpguBtzrO0Ko1K?=
 =?us-ascii?Q?KQQv8zfu4/gO6bOMfwIgAel1uchYGBPOrT5H6hkN/aELaYQLu+9MeNMufYG8?=
 =?us-ascii?Q?1guWh+HNvbthUAWmWT+y6aXnk+npr/SR2/fDnByV81U54q/oKZVHwxqUcwEC?=
 =?us-ascii?Q?xcCkFsW4LfcrfK5IdzZjAkAkHoDnhe3/z9n4azn7s8bcFXfEOl6faPpONd7l?=
 =?us-ascii?Q?HdbbInrI6acP5XKVI3wItxCOZdSDQRIhVo6pu6BnKJVfC+9JgB2m8meInJz5?=
 =?us-ascii?Q?8BW3ra47GeGbrVkoS2PHiT7i+NCvVS4jJyFICM7UIjWSNMkXF/R8ySIrMQU8?=
 =?us-ascii?Q?sdKZRZEjO9pQsxK7ED7YPwJErrDqIWpyH7FjsSxycuFTttyiHLANEUzMXXvQ?=
 =?us-ascii?Q?Em791o0glp+sktStaKGfUisrYWDGQVhyZcrlymBj557a1SOEnJYheiiWQR1L?=
 =?us-ascii?Q?LYj+r6OspcKVfcpQfSGU+XSdcOrm51kzAFdvuAb6ifbMYtKWKdPhMofrztAO?=
 =?us-ascii?Q?EKx+r0ARYMe6Sl8//0w7LOUF0nOBvDm4nGonluv6GueFQlcodOQasSGC2ful?=
 =?us-ascii?Q?dwjk/mrrCZGRO7bsDCvKumtnxP01L/f9kpUxpxxdY91k0QVvJUPdE8pdbkBk?=
 =?us-ascii?Q?tG9oowKddDlPdWuAELqPZ67wZawETwKB91HfkIF8HiS1BEPx8dAEqPVnwdVY?=
 =?us-ascii?Q?QVki0oSFUJPPxkxVBzigI4LVuTRZ/L//0W4rhuZtyUz/3QvPUWo1tgSEAZKn?=
 =?us-ascii?Q?oRHCdAoVtL44YnZVebAPm0ze0dDvvB9Qntg51z6UTtzntIsBRgQnaGUfKi/+?=
 =?us-ascii?Q?Yn/0dq5F19EYtvvKp1oVmknbPQG2MtaWq3pdvCdhW+tWnWKqhL3DJdVKAtch?=
 =?us-ascii?Q?jp/y2hg+y8P/9USmz2259D31fQVtybdzbTuHynpxhLg43+YdT5kVYuo53Njy?=
 =?us-ascii?Q?kHHMmYoxEAWFXe8hMInEr6ccOCQAU+4Q6QeZO6JPjnf4voCPMqjUkKiZzKzM?=
 =?us-ascii?Q?lkA1679M1/DjKAJSJQaJH81QH2i6e1w=3D?=
X-Exchange-RoutingPolicyChecked: oerS309RpdUckwonckLTQcuRy6hAspxvmoLhpoeOEB+mvOeK7mNnyTp9cqL1b5MVlLe/P6rCz9+sIGCcgcWIs8ySr4diA1ZFQ/QJm61RJVN9OPeJ1/j41BV7wi507jNLCjuGyaTnFPSTNRKR03xgk1LaWgry78OkbauvKgAE321nMXS2d9fGvb3MkN/d0ieI4pQc42TO/4tBbqydTInkDBSjTe7mOV7VNjwW35DGDKDoFngJNHuMM4OW4T2y/ZH08c7LNl80KMNwgy8gMOxsL6P6ZmZbq+4Rc1QkAF5RoYLFCo4VJuk8Zuoqd86PtUMZ3Sp2WA8+YZSc7sbDum+Fxw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0e123b-d7c7-479f-964c-08df311651f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:04.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZyOhdhWXwGbLoCyqPamRkdAumOSR2ZwhhYIbo4Jep6CEOtQTNPPKMm4Wdzy06QQls3eY6SF28/hgeJd3a4IZD5pltnYZwO3wVJgYwd7TaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=E8NYNqdl c=1 sm=1 tr=0 ts=6adb7675 cx=c_pps
 a=wxNW0EeDzkm+khva1kiV9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=9VHIr0pmzsvXQOZnOXcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX3vAuzPPA6rPc
 6aAOHb3DiQGuKXMkj8WKfGWFHRe15fce1nh0BFkdA3i2/tcI3rm3Ui3JF6YZwALcBw3kqiVgnmv
 GsvzUEkvLqgStLQlUg2SgHsFv8N0imrBS1HQ61AQdgogCzMYbLcoIVn4V14AX39Ihx7bi+8bt0Y
 D/UWeyGDy6JSERpgFlE3Ld1mBBQQEKFQJ7QtKtByMk/DtDUqG4cd9Sz9J4u6LgeyVYa+VszT7dj
 CFBX2crdf3Qo93MRbSSqRe8vohySEG3vUTbmOwjdpxG3i2IhXIGre0FLDD13NqqrN/GHaGFwNQf
 /RAHyGhPu+Wwz+abBCm3/8NdUtstnTitpcbod9DEiRyeTWzwGeZsj3UpYbBHp1qCw/0iY/tMWs8
 m6e4KEZJHuKTCDQtBGx2Gq90DZtCwmrM+nCqiot5KaCFdYQNy3cmkQ9eppVp0CGn7vcrAdwSrBT
 3luDQ96zxO3h0LRnbrA==
X-Proofpoint-GUID: JadSTk7y-zLNki9ao3rsIFysrVioZ3Bs
X-Proofpoint-ORIG-GUID: JadSTk7y-zLNki9ao3rsIFysrVioZ3Bs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX6wZRg/he8XJ4
 Ar79lcGGaVxKsX2StC6xStxtoFFrQBavSOYdGm4UD5qQkRhDNBUfFo4GLGaHcBicnKJV3Fu9X/+
 P4NzFQOjg9oIfE+U4NmnBg3XpQOcgNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Currently the cascaded output from the secondary i8259 is returned directly in
the pass_irqs[] array, instead of being connected to the relevant input of the
primary i8259.

This is a bug fix since in a cascaded configuration on real hardware it is
possible (although unlikely) that the cascaded input from the secondary i8259
can be masked on the primary i8259.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-21-mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fe524efbce..d713795ae0 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -504,6 +504,11 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < 8; i++) {
+        /* Cascaded input is not usable */
+        if (i == 2) {
+            continue;
+        }
+
         s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
     }
 
@@ -519,7 +524,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
     }
 
     /* Wire up secondary cascade */
-    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+    qdev_connect_gpio_out(sec_dev, 0,
+                          qdev_get_gpio_in(pri_dev, 2));
 
     for (i = 8; i < ISA_NUM_IRQS; i++) {
         s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
-- 
2.43.0


