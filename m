Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4825D35E5D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zeE-0008N5-R2; Thu, 07 Nov 2024 05:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t8ze9-0008LS-54; Thu, 07 Nov 2024 05:21:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t8ze4-0001xl-Ps; Thu, 07 Nov 2024 05:21:47 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71fdCC031344;
 Thu, 7 Nov 2024 10:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=BtL4wPizEP8e0OJHbaX12oEPFzRBndiK9nPlM1//Xp8=; b=
 Rm82Yfge6gPmunN+UOk+wKfIb6S/r1/4nfsalpBsrwJNpwQVKGhghsLmM4zizvhN
 YQZglXNE4+zl0YMybfZ/EmLNL6yxIt+eUm1slgN8pxrgRNtck0gWwhBnGY0kGX/N
 9hwwoGflhEtyJjbT63L6zrvf7BPV6Fh16qlhTQGKNO4mk+NU47wXlhFtlGsamg2w
 jtACSXyE+T8WfhGs/m5Gg1QpBakm/r/DtJ5OaFzQfyOGJiCf29ZgYHzyF72gND5J
 gkzt3WjTYijsHrFpV7fd6rYefrGqz1mPjKRjpCLx6eGZS3jajRXfbg2FntHxJjZZ
 fWXg9lAe80NzNEiGUIw5nA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0cj52q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 10:21:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A78xK2T005030; Thu, 7 Nov 2024 10:21:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42p87d7d4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 10:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjS6eZALuq9m4oEzFwBb6UUUdrO43v0+rWBALCJDMtfoX4XwGrQR6oKDMbxnYMspijRPGaEl/Y57J0hKlHNT6D0ttaHfKHZHALo7EhfvzwtHiOg5o6UL6rmxxxYXC5bbKFFUwNnvzi3zB1JgFUKu6SW0d+nNn0RFxmO0/Ibw4NkIP3g7POXTwPgQzrtEJSjwfQtRBXhtv59EXlKUPnEEw3UnoV3ofhNkcD1LCIvgumVBc77/pWqSUIj7tOhciLkxRngJK3HnUJtf5Y/0ioc6WdfCwunWiPL8QJcjtVzxz1mapV936wRkoHZK3hChPVWuNMQUpY820nft7FbAEud1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtL4wPizEP8e0OJHbaX12oEPFzRBndiK9nPlM1//Xp8=;
 b=KJ8H70Q9BuiPgvbwRCpQIfEefhUn86UAmzWTsN0q11wPxWGacJ4xz6JrxC8ysZWuz5qjb435lSh518Vdyyj1WEUVCIbL3URYD/16JKd1tQg8YPyws2mQIXAbLBVDdi/ouptSUKEDjfIwuHrFZdcCeM27e/h2BUgqoqBEp+N8qNNpdIUImw8pcanhSUDcdhaFDODjPceZcG8S1ujGMiMOcbWYiRDUVipPfxRmLEZ2AGBSFuSOOyeXssKGZuSubxVd3AbdtM98qsOKspabRMtloCvyPvzOFv0N7sXbv9w0tUuUPh8p8QCRit32QqEkVb0CXsYRnVTMpisUMRFp4OC2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtL4wPizEP8e0OJHbaX12oEPFzRBndiK9nPlM1//Xp8=;
 b=gEU9DWoeJX9nAHihwcmCnww3IbQGcw9nbpLB5AbhaLRYTJO9u7pMf9k8RkJnxdyUI+Jw4eG3csvZ5r/fiRY6UOnV3coWNY+ubVl9LPFGZC9hXxbyGmN+Zzc283euta3uqJttNwEEa+7vrQWO7E8nyOrgxEy/WI43/24r6sNxOfY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:21:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:21:33 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v2 2/7] system/physmem: poisoned memory discard on reboot
Date: Thu,  7 Nov 2024 10:21:21 +0000
Message-ID: <20241107102126.2183152-3-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107102126.2183152-1-william.roche@oracle.com>
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM6PR10MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: b744f9cd-151c-4a52-f139-08dcff15f3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2ulV84fBQRWB5I6RJHMnQ4npJdbC0xmQgjBbMFQhh9+ch9QMi8cY2Dlvr4T?=
 =?us-ascii?Q?Hk9BZy8nsARBdqwEbNt1G9Stbz3Wf8PS2o7fwpkzdvxjjEXFet+xruRUEUIn?=
 =?us-ascii?Q?uDpRSZXM+zpB1qari4PL9SOK7c6irQ0MxS35g2YNBYDDMyBLxka3iov+lePR?=
 =?us-ascii?Q?b/PPlY5nruy//NqcgbcX1R1WsX4+0DnesplNcMvP+GkreGOOjsw5hyU4xS9A?=
 =?us-ascii?Q?MnZcSB3Sb08Im4lhBzkANhHxFfQyCBYszP1U3NoxsJj0xfu6+pcWhpBymB2y?=
 =?us-ascii?Q?DF5TSORB2MTQFFXgNZP1LEpWjfu+SwT3sLMr/lswaSnbUyorz3nQVLC94E1N?=
 =?us-ascii?Q?13izFD5lEf6VynhtgTC4cKMAAb7kQoYhkzEWGzNFpQ4lwgpNbbyBqC9s0Wjm?=
 =?us-ascii?Q?Z0wUSxV3FBlwD4P9x5qibglFcEy7+/iND3L/pH6ckJOFxDyBxinx0HErb+nf?=
 =?us-ascii?Q?p7o0LmPjuL1mxCZmRG5Xa3UXnGOclpn3LXtkPvtQvEua6rnWMh+sh8at6Mc1?=
 =?us-ascii?Q?QktYBdBtJf0NP5q0l6o2xiyt+qnqY+9NYxHN/UDeb77gU950FU+HevEnKvdG?=
 =?us-ascii?Q?d86bDA9udOtkN807CS/Y2Vm5BHaGkGP3WDDKUTh65vYq0ENDCjPRYBvzHk3p?=
 =?us-ascii?Q?vK2apw+XeqbRjPY21G0YtuDpTemhG8VHH3E5qxQyJi3TcNK6Y+iHwuYtfCTy?=
 =?us-ascii?Q?XoxGa+XVnBdpOJcp7kebHSPCpJEkBE3chuJ1m1XGa9wvFVY2nTfj8LmVQAmf?=
 =?us-ascii?Q?HXzmAD76NSPwWpXEkW0BXoA/gDgndcwiEOfOnS5UmD6562HpiMukiLXcrmpG?=
 =?us-ascii?Q?rS2OxhTETfN3Pt+uC89bRq6phV449PoBEsokR6N2Uz4d6hx07N54hZ+cI/TY?=
 =?us-ascii?Q?Z8f7hnFHm4ww0sSSqFjNQjDBkOtUP7RXbzMZzFHdWnKFzhFFUivfE2Okr/yX?=
 =?us-ascii?Q?4uGppCGry49668B0RYJylbe9RYx7A16/ihZbSlXv/bvdEleVRGqkk0Y77kmS?=
 =?us-ascii?Q?wzvO3+UOC8MaOSYxrLKtBQVzsrqFZc5KpYDwN15RV0AXZ9FnoZ9qnQxIWHoP?=
 =?us-ascii?Q?MdYU96JT+CWlhl43JPx2WB3qmeaa8ouIPgWnPzwfq4pjfp9q9CZFKkf5uy/x?=
 =?us-ascii?Q?4+WlqcXVScSlTUkqCLjjvCA4A+oAmzIhKp4K0Rycn7RaoGBN5TpF5OnGJHXW?=
 =?us-ascii?Q?PaMb6HI6D/cP5OjVM/RoOHMUhq3rPy4qokpEWq+YaBO20kMtyMOF5h2Us03i?=
 =?us-ascii?Q?fmo2OjwQr2tv6ejTetL50+ZtjP2Qn1AssnG5+khZ5LVZugNWwtvANQaAGXrd?=
 =?us-ascii?Q?syZ6I9GIGITc5VON5SAv2Lq4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bvcYdh0+FIzr23oLIurpM2MuIytWJMT+rywYuqqbSxtK6MtI5V7/kPhbzTXg?=
 =?us-ascii?Q?4n7ATdbWFwShG5NWt5J5AnVDk7uTIIToiJQmJYKXFsoxI0IiBXJTOGkaeyYA?=
 =?us-ascii?Q?Sw0uIqLh+RQC1W/oqW5Kt6pME3hbmA/4b4Jxte80QjgoyCRrC6gbq+C+47j9?=
 =?us-ascii?Q?hKaNACfTOij8L1OWdOZGaEGrKkn29FTjbt4Aiyfai8mVnimq8NXx2NGmvnSm?=
 =?us-ascii?Q?8pjoGxTGUPc+WDBq9Ck64FB+UzdGBKvNwZI8HQ+BIVhsEdocd2SLARiI0Gxy?=
 =?us-ascii?Q?SucB+eXnY2u6RCB5/I63c+A9wyrHCruORTIwb+0KZIuPWB6q3qrm8ZqZz1cJ?=
 =?us-ascii?Q?eYggY+u8lNazRyHae6xbulFnywueb0siDeVIt+8nhGshYX0MXL36qMrZhwtb?=
 =?us-ascii?Q?ZVcFKwos+DPXJrhqRvSyw4ShpiV8Dhwz7gvqwn4QpbFWBs2YiM0r9XQ4GS9a?=
 =?us-ascii?Q?oAsWX+LSatFrOCHAPW+RwD2rnODNG8JO3lihRGN7nqQCvCy9HavCm3g1uQve?=
 =?us-ascii?Q?aHJtvI4xYvmHVd3JQ4pJxwaYLbKJhE1oxAejXBNOE6FcUdfX1K0FkZasPHOF?=
 =?us-ascii?Q?e3Z6AEmtlGUTCPzfIhuMbIPPIeZoZ/pNQoTcP9L5gOVb2NTbqsFnYCMDf234?=
 =?us-ascii?Q?PXsKwyFKs0B2XBaLWA9yboi+WH4B1B5Si2oweqSg9myvOQYfe87qrfb093zO?=
 =?us-ascii?Q?LcPH4O0lxty/j9zNKKCVWrH6kDjp5U/ACqLozvUpA+vYuW4D7jcvjp5nRpv1?=
 =?us-ascii?Q?4hpbRsQLiVPevaoagC4O9bl8RVbsC3bulbGErNW/LFQqOGDmpM1NgJJbzlPE?=
 =?us-ascii?Q?lq6HT2/PHr/Ho2smIBFRX3wSl4NnikG1zebMATg2H6FC2Aucziz8vAglaWjF?=
 =?us-ascii?Q?gHjMMGkcnNWEPyLsRWBw/8tHdqeafEVvh/M9OljmbHk9r+kv9eDaxV1Vodwi?=
 =?us-ascii?Q?3ESwlELHwDOg4Q44ZnNYjJP9jH/jVp8E7Jew5RfPLT+kxHY0FliFike8mm/o?=
 =?us-ascii?Q?Bwo6WJh4EptkeY+qWkdsaHRDCDPfINV+Uq6q+2uDRCPEng53OyGUKVyrEV1N?=
 =?us-ascii?Q?AXLzN821pGrcKRo3eqGkwuITwSt5vOM+rgHGlZhQCt0e4k8VInV99ZZ9llKK?=
 =?us-ascii?Q?pcNN7uEKf2C9MCpSAOsg79LMtf7jC04U445IYuKmbxQiFdcNkc2pcdHYO4Pq?=
 =?us-ascii?Q?kFqDojvG/01cva9qecpssdGX8cgok/3jSnSIkXgvLO37LckGUXqKaiCt5T1V?=
 =?us-ascii?Q?7l/3x5IbWJYNnM1p1NJX708kNvlgdl5AoqHc5cj45zQD3VwAB1JoJloG6AY3?=
 =?us-ascii?Q?PSZ6sdvIEGvpNuhKtjBB6ePzzHmmDl2j0RWmqWbmiA0sm9aPbzVZcpbUjL8I?=
 =?us-ascii?Q?HqTwMllusekiqwUETuh8chk5ZGsjR/ev0bUGury0+vicggrn1Pt6xhez/AtU?=
 =?us-ascii?Q?MXrXszfmOA6h3/d2KLSdEWYfr85m2s2EMfS48q2f4jcfRQD0Om6q5hvu24cl?=
 =?us-ascii?Q?m2FhxkPooqmmcj7hQxKlAzUAsiSp3dnK37JfejcT+zG9Mh+dHUJDoj2rZNrT?=
 =?us-ascii?Q?WHxxDOUJ/xn1d+y/ScySvC/z9/IBP7xYD5q/P2zIzahl/hP+Upiq+azpwTAB?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sEsbYBwMgxCwaTepzL9qSfBqy4Rols7vZEd1lvxbPRJuWu9BJypSosO+lHQmnYSdAU+YC289yfWxnOggxbrkP774ZfU2i7txbtWp7GvyFOuLfqiuUSyf7XrM6jYZY5DcceASog9RhOmI5TdtA6JBumJX4DWUWQd+FYyxBz+SxdO/BMXRWS2L11fm8huEu4Yvla4M7KqfozecyenMR1mNbZYOhB9Yuex1evagu5zvNw9p3Q1yxxNZwED4YJ+zv1iwbhjCKfImSV95h4w7vKF7YDG0RaWcP2m2GM/f83awBibiH0omKRQfLAhtNZRCEygtjXNCGvZqCIat33Wfa8NM3YvRKVSmHFmZLGtqd1exVAXR4dB7z2HgDiPxo4D9x448Ux933cYTc0bUambtExf4YSEDehXlYfAjyEbPSehna3kEvpaAaeo7sUWCWFCc1Ce3SgD8XsRrj3yGNO/2oa49BS07pJbFusbPZ1Ht0hTsWmJJi7JUPUmGQAIqB+XZG9HMNMskXx+fGs2UVoG1C4RseU79F30oStgQfimCsr30xlFjg5OrjJxG+SLMTmgpsptOT9/t4Vbt/qhNVrsMKfzKOPFj8nDC47MzKINaSgRCKn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b744f9cd-151c-4a52-f139-08dcff15f3e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:21:33.3101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7QemIw/xA459E4XAbGpZNKXNqWXNLsXcwEUBsGNFTrXHfADqPqo8WPJO1JEy0ChFg7DunNN8S69MJSPi4YozmYA3s45W54hK9igm5imkn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_01,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070079
X-Proofpoint-ORIG-GUID: SAPm_RPyCR6wuzyL5wjnVSBmpwdAYm92
X-Proofpoint-GUID: SAPm_RPyCR6wuzyL5wjnVSBmpwdAYm92
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We take into account the recorded page sizes to repair the
memory locations, calling ram_block_discard_range() to punch a hole
in the backend file when necessary and regenerate a usable memory.
Fall back to unmap/remap the memory location(s) if the kernel doesn't
support the madvise calls used by ram_block_discard_range().

Hugetlbfs poison case is also taken into account as a hole punch
with fallocate will reload a new page when first touched.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 50 +++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 750604d47d..dfea120cc5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2197,27 +2197,37 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
             } else if (xen_enabled()) {
                 abort();
             } else {
-                flags = MAP_FIXED;
-                flags |= block->flags & RAM_SHARED ?
-                         MAP_SHARED : MAP_PRIVATE;
-                flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
-                prot = PROT_READ;
-                prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
-                if (block->fd >= 0) {
-                    area = mmap(vaddr, length, prot, flags, block->fd,
-                                offset + block->fd_offset);
-                } else {
-                    flags |= MAP_ANONYMOUS;
-                    area = mmap(vaddr, length, prot, flags, -1, 0);
-                }
-                if (area != vaddr) {
-                    error_report("Could not remap addr: "
-                                 RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
-                                 length, addr);
-                    exit(1);
+                if (ram_block_discard_range(block, offset + block->fd_offset,
+                                            length) != 0) {
+                    if (length > TARGET_PAGE_SIZE) {
+                        /* punch hole is mandatory on hugetlbfs */
+                        error_report("large page recovery failure addr: "
+                                     RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
+                                     length, addr);
+                        exit(1);
+                    }
+                    flags = MAP_FIXED;
+                    flags |= block->flags & RAM_SHARED ?
+                             MAP_SHARED : MAP_PRIVATE;
+                    flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
+                    prot = PROT_READ;
+                    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
+                    if (block->fd >= 0) {
+                        area = mmap(vaddr, length, prot, flags, block->fd,
+                                    offset + block->fd_offset);
+                    } else {
+                        flags |= MAP_ANONYMOUS;
+                        area = mmap(vaddr, length, prot, flags, -1, 0);
+                    }
+                    if (area != vaddr) {
+                        error_report("Could not remap addr: "
+                                     RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
+                                     length, addr);
+                        exit(1);
+                    }
+                    memory_try_enable_merging(vaddr, length);
+                    qemu_ram_setup_dump(vaddr, length);
                 }
-                memory_try_enable_merging(vaddr, length);
-                qemu_ram_setup_dump(vaddr, length);
             }
         }
     }
-- 
2.43.5


