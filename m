Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BF606D82C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=U0YLW3/m;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=POKuidTx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOv7k-0002jL-5o; Thu, 05 Nov 2026 05:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xOv7g-0002ie-PO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:55:12 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xOv7e-0007Ap-S0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:55:12 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tPaE4162831
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 02:55:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=7RQ7lyvowNaNM
 t9lGSY0E8+t6x1InRV0GzoQ+rR65Zo=; b=U0YLW3/m3j7kKo4LCieCKcQP9fk1s
 EwHjgNWKXj4bRGo4Ls7iDp+MLBJGlkq60YBiS3mzfCVg8vaoh0Lrr+G5vMSEi+Yb
 +5mTP9FwirpaLKviot8Mz5YJR8ihBjF8CtLrDbDqLWIu6R/8+Da0v4aJ++PMHImg
 ZnOI/HrFlrA1XEvTszWD2f4bxSymVtOaOpkAPuDuco+Z/sO+iNCDx5JRrEC0ceoW
 TfExK9UsbpR8vio74ximSTpzzkp2rm8ViIaxLpGzVXz2VV1VZQNIV13+fnU5sT0l
 mGw4CkAiNIbu0WKXJ/HKd0NqPIScVwbx+a3GtNG1JqVwNkTbj4SFx5kQw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020126.outbound.protection.outlook.com [52.101.85.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hqk2yng09-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 02:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnYG1cnMPUCey/pWVXZaEQYot2moLL3j9ZTT+lncdHNUGIv2zr/h/JLNy1Ft+ZJRwP36GKLXBoBTDHJTPsWtWEZ/7LF3X6edNHjNr7tOBL/xkUzjnsDvzhYwulRxmdDdgiI9Jeyd+mpyu3OrW4TPI6M6dqARgM68ChxgWOYABbVQ/CBcOVDtQ02an1g6rAe3RPgzCdTaAbUG42a+afs7Ui5iS1dK8RUeU/+j9TUFJY6AChvKjtVKzCFX/49OH3XGM/sTwVPBoB0Xv8BsGtAAwiKg/JKsXVc/rTOq3fRU3/7UMRykdTnIjXpYX96RDEEf/T3fcE9DYMZ+tY0k4Y4v8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RQ7lyvowNaNMt9lGSY0E8+t6x1InRV0GzoQ+rR65Zo=;
 b=xwX738tsuqJYXeiKRxHFhEWs4cDBjhs+hyrYs7N8bDhzB1SpPRkuxcnQ//WAif2TYa7cdrein2flINKoSSYvmoau8RXPgwW7kHy9mCZufGCr612eNgF2XMtEho0XuOWa1ntD8UH3mibHpCV5XFNWDV0SWeRxkTEKx7t4Y6x4acSvdQqlUyNjKXhyV18Mvh/5W9rYHvB/cGkXulcb63aAhXm++uqUCG43Jd9btAgBxGowjfJdPdlKRl28JV4coNA2RXrUBOGT2mQouIFKWaKpetpANELDGWrv8+hf1yP3Oeprl2lS5x6IYAbKZvlZvL3mjWVpjJIrLZC5HlCyAu5+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RQ7lyvowNaNMt9lGSY0E8+t6x1InRV0GzoQ+rR65Zo=;
 b=POKuidTxbRm8phOpZpI6ZHhP5ws1FG6k6Xy5rjyMMatMt+VPLEgnGH4Cx4SfVJ+XbVAosZMWxZMA4uuYhqbTh08vHMZ0JIUjK4p75sc5B2WTcKqCSgg2ZsGTnWpTfumF2zetuKn5uzjAhi1lewlYn0OJ8PaYegW079QZNMTO6GH4OMT0YuEYTVNMzohGQCLTMPsq+wrmQ3brx3pVBaZk1R8UGw302XQ7Zm3AEwTloR7fdnU4aKivuOZT8TjbukfjvzM2g8erml9LoxicRrJIcbIGIYhf+DPg3PxvWO47Y+EKb7l8pZjBiBfY29SHHfCN/n7J9ZBSKp7SyMXHp1ShGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11574.namprd02.prod.outlook.com (2603:10b6:8:4e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 10:55:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 10:55:05 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] qom-qdev queue 20261105
Date: Thu,  5 Nov 2026 10:54:46 +0000
Message-ID: <20261105105502.1786431-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5985d1-a0c0-445f-3634-08df3b2b4008
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261022075727099003|260925022911599003|260925021311599003|260925021911599003|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: it0WpWhzaS/yw57O5aFqse4+PRCwhh61VtsIkyZ8hUE3eJvAL3peaX5qQ0e0BYGXj8746uJtXjqsD6RYN1Gf7yeZGfBvcsdG1NROmq3fPppM1QExE4g4WaCN6n/TxBW/EnORi4TYoL8rhlNUx4YSREnu+8ixBD9+f0mqe138v1DPCNhD31vVvtY8L783WKix+WHatuaVL3lyLswjG7fk8w3uHS+C5Clz/bsOO5nczbGIwruAun7gSVHehD+ln5/J+EMS9cNew+uWXIHhYV865TFd3GQDtRXS+hgRF7YGbBjjOx9p5Lb/u+yQVgvKzDSgBqvdZOOXvf+puQFgh/93+bPWTcvTOlz+FmEUkSDTnQRwro9Tgw6UDewT3Glgq3zRXc1zg2NeP6TBz5juqF9wuv4HMnVWpU8X9Gd+HLU9NBpSVaQVwpKhEHNRLIJSbBKjPFpysPSaoP/xc3SWfAaBsrbHm7Gg5kZTRt2Fa73uKOdhdv+4lcFN5Djs7nNzWbRPBrYRfEb+mTvETZh2gVQpbAnLKvcdvl0ydG6KAgipiCB/E3StkA0K2w4YQfJwusU+k2Tay382NjeJyrUizht6MNgbypTMDXBr4Xk14OjalMNxOtBU6ozbjrqe8MDyIVeuZXtg03Efbguwm/sz2d9iY/9+tVUho6EzPBPqNEeCfuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261022075727099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNQweniLDEkRcAXA9vNFvRtO/IrvSV9elw9EgetxqO+eVO8cMg+ZCaLdSwPG?=
 =?us-ascii?Q?dmX3sZ37vindUCY7X6KetlHh1EJ+G5mK2EgMUnEJlCOZ9lcEKjWcURPoNe+9?=
 =?us-ascii?Q?8q+ur7pbJIPEQTgwtdDAgAgbymnHrmldMhujDs5d+56tjg0fpE12a8KQ5vPs?=
 =?us-ascii?Q?v4b8Yo20Dr3ce6zeyF2nhYiUm3xiKn6bmLLefCb2YLcFeLhPclOB3TVbo3cw?=
 =?us-ascii?Q?EBZwx0lPHpfRjvG5RLUmwx30nga6kJBaa06PhTlNPef/QG2ftSZC9U6btyyE?=
 =?us-ascii?Q?oMKoeI3xnwn2ozW6eiS3ZglBvCpRnxZ1NhypUaA16kWZ0G515X88uY+Ym68x?=
 =?us-ascii?Q?h1kdO6ebwuA3XpomMIU49hCVFSrKAR708uJ4rJ+63wchB5KdrasIaDdkwpPv?=
 =?us-ascii?Q?XQFbwqEm6Wkq48hFKXsB9dXKeWVgQKtynDyVjjkArKXeg2glG9xgnSNRIyF2?=
 =?us-ascii?Q?V4RC/c76mAhQxq0jFe47jdXHGfizQ4VMiMQGC0OYkwwTCMt+WNrpv+7E43ID?=
 =?us-ascii?Q?fjgpmZB5yI3EyE4hlTsVeAilmA2Gnr+NQa073vSNh8n31HypIrXikapXT4S2?=
 =?us-ascii?Q?D6K8ezni7ZCoVyLvivKv6ZwN6CLWSm5l6F64gsgRecrgyvhuRIrSMFAFAdit?=
 =?us-ascii?Q?6VNXcMxEhAt4De+H89D159BENh+1WUocb3q/SNxukyQVfyOFzkUk9MocwMgJ?=
 =?us-ascii?Q?q2tyJogOvLArn2YqMheA5bPdqQAyR9fGC1MUG1tqAx6yiMmEDrqh0ockQCua?=
 =?us-ascii?Q?C/Jd1wLF8W0DAZW2AwwZ74FCFrK3W/uHSDOIqXOq5M7lkdt3/2k+76WZr7f5?=
 =?us-ascii?Q?zFUUcJydfx3g+8H/rVa9UUp2lge0wT7i79xXMjK0Nf4uIur2ZHm2b5jvtdB4?=
 =?us-ascii?Q?ozf9r2F3Ygue0al+cJLtW961kNOnBOhfj5YcTUlofSoeIoORFm2Vum9/PBmx?=
 =?us-ascii?Q?xZ7o4IuJ32IAhaWGnP3DLgBZFb7ES8g+mEyoqTaioLKwnVdKChw9gvr3mfWk?=
 =?us-ascii?Q?VFAl/SSkTy7W4rpNlSsHFNE32eY28pXN0I2mAloA1t1f9S9pYAWv7s97Ws13?=
 =?us-ascii?Q?pQOLhABk331Djp9MaRtKbz2ZHhtGOtLeDPSx4ERyDMrEig/Ld5wbfNb2OYGU?=
 =?us-ascii?Q?2m7GQHp1V+ylcqIwxPxP4DoQZuv6G3IMaqeNg5G60oxAAa9cLwPshuQH4qlp?=
 =?us-ascii?Q?BHnjV6CKDwgb/52365Hd4burk+HmfI7QBRhERZBOGL621lJ/olNV4M9Qifsw?=
 =?us-ascii?Q?jFoXKntXsT7fK5QyXm2kcIeZun215+Y9/DVgfSWHWLMu6frjg7fc9RWDSjf5?=
 =?us-ascii?Q?UqnBNyCPQ4GJGdCKCQwDw+WNY7yIXPEBVjEXfyl8CYh3USa1yXn3yvN3C8UU?=
 =?us-ascii?Q?ZT/avCoQt9FzIUBfQem0SUgTwX7IiQyw4O9cc0buJq6nTtW9sz6Cr5q7AuTW?=
 =?us-ascii?Q?qDlVLgUjvtBWW/HsIu+ChwQfgjrOFz4kvcE/F1tPvyEWwO6O1HEkkbNdmOKx?=
 =?us-ascii?Q?L0bOIMdYE0xt0UW8JiQp4nd4jjdPPARWjcky/x/QH8k8zJu5j4MThQf3caUw?=
 =?us-ascii?Q?GuT0yPLsxJaBkZfIN+pndxVkEhDWnsBn2QRJOYl160ldgalmoQNpKSE/1W33?=
 =?us-ascii?Q?Dpao5V8UeC6NTln4yQUvuvN1nL1+6elGwwaShMBfdCNAEpSrbmoaH3/9DPPf?=
 =?us-ascii?Q?7e9953Ukqrma4bbwuZZ+xWQxVDPDkUkMuOZ3g4uKP7M4gzzIg1cu6b6sBME/?=
 =?us-ascii?Q?WYtF1gbLjdEIrtsa+VSmtcDjoAgrvI0=3D?=
X-Exchange-RoutingPolicyChecked: GaEbyAOibNkmJVNlXDWc/9Nyi7yTN09qnXfCStljMhqZtWaASsyzlI+LKvUlBNEmlOWGvGIyjC3Nx3nQL+xowpoV4+OeZqK/JnQSJ0+buFFDai6Tb5W6fAuEZCVCkbySIyfD/qziGVoVyyZv0K4pQ4pb5M+4CJdaeMp/CM/OMuMHhir1TNi8ngKiIS8Tc8VsDMNbEOLv+MNSqQu1bdUZGMsrFO3o7xsDk4O+YIRgNT3RLqMMTCb/g0oY9gWWOpf2/VYtrkLf69mEmCXC3b09xq/lEqnAbQqf8L++28vgb/kqUyb8PJ0UZIc2qTrW3q+05wMgR2xpmqHZLVRkPgDoxQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5985d1-a0c0-445f-3634-08df3b2b4008
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:55:05.4523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqhs2lOxeIHPmTRai7NeZibYEzLOsNJYHbsxkPDa0ja7qZ2Sir7bgmna75WmCKXBO1KPMtFUq/oHyGPRwfqO97LiHBhflaCaZAiomDTQomM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11574
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX653Y3Sxa896h
 cRoRwItSpl1rgX1chu3CF+0+/9N1yg4Yx7S01hbe9xHywyvX5TfVeCcRe0zeT7HX1L2bXVREqkR
 YdrexgM6nns/w908pXeTJJj398CihNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX3OEPWLiWykN3
 jaskpAA+EjiKPfhBYaer62ifC38gQCg/U5USRxTeezKKehIvkM/Ga7XTUm48nP8O4NkWFU62uw1
 b2PMDO0b+FdWmd/XY1zCSsP3LUfBzsko1zvCkU2RMs6YuUMISy1xpBl6r3zOKhEnF+1jDkOZ73W
 2wplorhGRsjNtGvQ4vMuZPJH8L1MZ1U8LOLmD+gB7Vep+jljMxzPn1yC3A8j+UL0DGRfoxxEImm
 M9Fx+xYs1x+amStS0DDgKXTaPurWj7liJEqnqYjRjtV+RP3+tPqPOFkUjzmqSxsynpRhl5z2YgW
 FdqKz5wSQnFuqbHOVmXM2l+BTFRoEkiYV2F0WXnymyEWAHRnjrrRKAuRQ8t37wk1NKL/WHBzSnr
 2DTrpvfodKapNw1DU9VEhunCClnWOJ657BoTpM5RSBWpoR8hNcEBvO1gWv3+GugpjQAUTDI4HOw
 brz3k/C+950NpTrdTHg==
X-Proofpoint-GUID: BNK4CSvA-vqAo8hNaDunBB-r03Q8_-fR
X-Authority-Analysis: v=2.4 cv=HeWB3SE8 c=1 sm=1 tr=0 ts=6aec608b cx=c_pps
 a=w1Ugl8llyohtshnQLMHy5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=p0WdMEafAAAA:8 a=h1AFD0znmrQ_h2UT61IA:9
X-Proofpoint-ORIG-GUID: BNK4CSvA-vqAo8hNaDunBB-r03Q8_-fR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5:

  Merge tag 'pull-11.2-misc-fixes-031126-1' of https://gitlab.com/stsquad/qemu into staging (2026-11-03 14:44:10 -0800)

are available in the Git repository at:

  https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20261105

for you to fetch changes up to 24ce0031350003bfb70676f47937dac8fb3f8294:

  i8259.c: don't leak I8259_PIC output IRQ (2026-11-05 10:51:55 +0000)

----------------------------------------------------------------
qom-qdev queue
- Fixes a memory leak in the new i8259 PIC rework that was generating a
  lot of noise during "make check" as reported by Peter.

----------------------------------------------------------------
Mark Cave-Ayland (1):
      i8259.c: don't leak I8259_PIC output IRQ

 hw/intc/i8259.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

