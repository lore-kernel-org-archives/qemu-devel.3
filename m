Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=d35e8jDY;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Q5Hk3KQB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlw-0001Kn-Rl; Fri, 23 Oct 2026 11:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl7-0000IM-OA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl6-0002gE-17
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:41 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE86Mw4158258
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iJnCmCGzw1XvGopRMoBMdGW6zazgTNwmK7Uqmi2aT
 Gc=; b=d35e8jDYSGcG2eVIq6+JqJ2RnsVdt+8zb3K0jRsqijIm/fOyH8UzmGrEF
 pA6Y1twam5RCx5eiy7LgSZRSQHqzkqROGQp3oikY/Q9ei86eM38Du2ELZs42ZVQc
 Fmu5k//T4trWOa6iafwQ1Phd6AA72BoF0HQxnvDUpLcsOUcf4XBVY3i9DP3Hvq9U
 8nfb6Lz9Gh1xPJIkYzZLGqGGDnMCXrmpHBvdu3SosLbdjJsrb8L/yXSFp3BfA/zc
 vS9jIVX2EPJgUqgKLIgS8rb7TMzgFsgD1QQxMLhaWrl+M6/YfNUYwV8aMp2bjVCG
 gK1KDLlYgukXGhjEo+3TqVp+G95kw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021075.outbound.protection.outlook.com [52.101.52.75])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972n0pv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKD0pijeuuAiM97dfQSD0aShFhjo8D1nnevYprqjeUJV9pyUnyZJ9rpqykWfx3AlW0bdhOHI7T/zHawK5oaBK7CPIDQC/8FH0wR98oq6Fz/6/cxaZ7Erb1CVA8w0V8g1Um1p4XgqbxDxlhJk/3m8vWPjycP4/lL7btVyaQiKDNonNfaQA7U3fz9EfPjsXN3FXI5b87lOQZozHcwV3Ez0Q9Q8tDvhpuG016vdMkt7uKwzoF3IzP9ZvIOiyeWFweJJNLMgPpggIjgjMP9U8xqVBTCAXeqUDenJCU2srZXNSIt8jwW0xCrRGCrFB/2JcO3r1djFGp7LXj7FWANvRsAsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJnCmCGzw1XvGopRMoBMdGW6zazgTNwmK7Uqmi2aTGc=;
 b=B1zSWgPaATlS2E0exB9scZX3Z8KS7TDXuXaBmksCUqjqc2P5OpLWFli393mg/VsGiJ0/mDaPKCMbR7ei97lkd/Boss23uYqWhE9VNre/gCfHNvhX6s9y1gvGOeAsrJ7az8pchAFVSZpbxoSESc8v+uzkFJNZWvLhgEm7Flldm0HYY/oizRJr70YlbCJRtG4MP18fGcPqIOWUWjZ4ZbPUbPgYWYVwjETJ/Hrjn/dCcd7o4IlduB2JKuRWI+HeCRtF+vmgASeGtrdE5/jaIHO+rOpeOB9fy5B2YK/6KX8usZiylZDJZtvGpgbG/lLJZYSelXQKLmmqon1BWolnQ/hdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJnCmCGzw1XvGopRMoBMdGW6zazgTNwmK7Uqmi2aTGc=;
 b=Q5Hk3KQBqiYnulDKmcdlDfxHbsVSfAXyJvlQIzRJE5a3lhGR9QbQX7D4U9Y9gxc9YpojWuoOgkHElnGw1YSXGJs8g1pe6/0wXRJmcoSGepMwr4wuAFJhVyjHT/L8lutGqFJl6v0YUuaiFr1pdNxAuz/lmRxinBP3obuSI1It1oG27Bcgh1QXftsLWXpCHLm7rsSFVrcuuJ5MYdCFZwPaXM1t4Zu1g/CKvgqVZqb2CVpW8k/2Lg/LVPnG3h5QUPlqPeq9haHKPdOZrjwMqmGsreVELM15xILfpH6l7LBai0dhwgF97nKXM2WO6W/4RoF2phUk0ubRwZSfHccHEZWseQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:00:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/28] i8259_common.c: add missing 0x prefixes to "info pic"
 output
Date: Fri, 23 Oct 2026 15:58:34 +0100
Message-ID: <20261023145839.34909-29-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: fb82cd01-108b-4827-5d3b-08df3116646a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yDu6pO5Q0ovtDoPHFkxERd4sGIA7qkDvHD1RgE3D1s/7hh3T/WHsOO82VS5MwasaGOTsMcvjvUSZ3gQsSsEG6xquHHGfp3ZICACKn2bYEQ/MV4h5z3hxQUxHyD5vfxMet5Dq9zNtTu/ngRRJexlit+ErBGL3Rlx4jgaURzXZLVKu32SaQUT7V2QzxiH47CiAx7lDpeTQToB1wf9pdJRsG3yGfqmVe0GKczLQ7koi4mLqbpCQqeyl6hfO2Q82lRVUfN1pe1lkGjwSQ9NF+Z7XiEviM2xHffB8CwMcOLpPYOuCFkSZKwYyYk0WBRpvrSOTmOWt7Rzp7POw80CvTfJfMFIOp0CiS6idf1M/tDJekBXuW7caufExbyI9pHYQTLq5XbLm3TH8udbXFNM1C3Vi1Vu0mG06FSYkfwlGR81ByBKXOs7R2JAVy70n8886iLTgoyNyneFdUKHTHViX5NRQV4ccpPy9RpeNf9d+7ksMGrCht0u+awj4d/8EWhSdqvGbU3kK59L1kSQW0XkAWNe0OcOmR9+lckC9YTUjgX0Ld0KYU+2kyriRf7UUyYemCbGg5wnl4SBfojCVqU4GiY9atPfT45IQ0KSG84AbH/6v8Oz86kVsHgan1uLT4CYhx8je14wqEleFZ0itvywX7IyHoIvOpL0b9JzdurQcvKe15HE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjaLFJSCIRnFvxrKJl7+kUSf7BuBg0kwBxpBMKhTy9BdTZqjlJyNNxNc5wN/?=
 =?us-ascii?Q?op5BGHEIlc47BXjidX4uGGqYVK+BaoeowcxtmYIS6tv30VpPj7TPduuot2L+?=
 =?us-ascii?Q?oer77L48ozyTxCuEFE8ZXrgMMOHoEJJEoa4uZIoGL34sFNk+KvdnHebgK4Sr?=
 =?us-ascii?Q?GE6pZOdWDo8/WQBQKP+9oLGepuAoJA0z8vDC0WJ/EDMPaoXlbeb+Dqwf9TUY?=
 =?us-ascii?Q?+w9sgubgSeAS5nP7SwBVFwBQGsUyt1TBUFhiIEYCcRokh2wy5RvJs9Cq/G5o?=
 =?us-ascii?Q?Yjp+1pepEI2qjTtxe/2TBj/DWYPfvGGNjZsmAedZMaUd9w36VKu03A1BpWCh?=
 =?us-ascii?Q?YOTQpv4yRAmi/KnZPnzHMl5QZVwoYGvTufLIQbKkWkFCtm3i0Z+wJ1G46sMB?=
 =?us-ascii?Q?9VwcGOg9RcXs1+ZU/g0HCCFaYO3GiUQwJZTzvBDhMmTyX3ucg7Q3wuQx8R/l?=
 =?us-ascii?Q?VGPXGtqadojf2DE9RVknMqN+R4ClCwTNDtgRZbVMhRftwipcWxvntIP8edzn?=
 =?us-ascii?Q?i9sKnaXHar+lpgUlo5bpw10qkb/mlk8QP9oQZhesvaDD9Ra6tHUjfKKEIT39?=
 =?us-ascii?Q?GexP4Y2YbrPUjQ91jHISqLyO4AdZTUNDOGK0a9DkSR0ftvG2qfrJMt0s8WqF?=
 =?us-ascii?Q?hjxZAZl6WLQgBYiEEpnKqYtjWJ2LClbtMnm23AScNv8vSrzpYSPCdLvzQRpz?=
 =?us-ascii?Q?612Dg70B2p3tuKEGYh3rK7dQUM7KVEOd9hXeGQcH1D+4p0hIdk+9EHhh2fc3?=
 =?us-ascii?Q?YkVlUf1yCvH8eAdDu/Yc9jnwgqgPp39Xd0XWz0GduPJYtGNjCgJ4NLoU1MOO?=
 =?us-ascii?Q?ZUMrXZC7JqV4skEt8Yz8PNwCHVq9ebaGkqE9pUasn7M2nLLCRWIlEATLcl/j?=
 =?us-ascii?Q?MUkUTgg9ClwoeqKO4jBAq6zP8/Z0Yo1W+KF39/lXiReckhugOJ8g6hcJPHfK?=
 =?us-ascii?Q?596WK3dLgY2SGJXIWLpdehdVXc7wtL+xjSl/IyK8hnQ1UEK1vUYKU+cElbNF?=
 =?us-ascii?Q?t2UHbALKntn3FdPbfjp4zhMIGy+TAgjTWDyWD/OKAL05ea6qLfRrNsP9JtlY?=
 =?us-ascii?Q?q7LugvBxwRqzGIUTBBH1KKf7N5bN303iFEM7R2VvbwnAUzFWzgXupSl0OgwF?=
 =?us-ascii?Q?ymPOlZ3aGMbAr8dg4CG1A4aLYr2AzcU8CYjK7wHo5M5H/Uw/1SsqaruBIhUp?=
 =?us-ascii?Q?pFFdY8Z+ojHMuTf3WPUvxJKeNaTn3RLz/TsuWjL8OiGceOK8hetkjqiVGYrI?=
 =?us-ascii?Q?w5yzNj8O4aDzsGgrHzvC3kXCKQV3eX1GrjCZVm5HHUZYNKR/2e3dvSZZt+yE?=
 =?us-ascii?Q?pe6HB3FQ4VQFr61T6eTbhXndXlzU7WZqG8/CCc9GNZIkfeKHCL9eYKxRhee6?=
 =?us-ascii?Q?yotbfZTDxhzJ5uZxql0RvpD717w4LBU2Gw7o52r7pt3WbwyIHlVOiEnRzN4u?=
 =?us-ascii?Q?F/Vy+eGeC0v9T+UxLewIYkKU/4t0q4kChcoE1l2iqsLfb2AkM6hHS9XLjsrM?=
 =?us-ascii?Q?DAFRR8jcdhuEe0HDABuWEM5dB8teo3FdeU3Z4epBQWLqLUxhTPT0Z9LpwVe7?=
 =?us-ascii?Q?Mcuk35+YeSVzcBNrkPDkZt+tdZbdNJBVIrkKFVsXqHVZkddn8OsLhs8El5DJ?=
 =?us-ascii?Q?bf0ts3Tg3JoYSUTtxjYDA4lCWtehubLWpBfmNWmOfAZbNJrpvy1IW/G2+439?=
 =?us-ascii?Q?5pme9KA6ZNtZkMdH710GjAy0OX4Jvmg49otFpyaZPcEDabPmPiIBLWbtkT1k?=
 =?us-ascii?Q?zC3kVOsSMpaZ2fst3QEe1vw15ySQzqU=3D?=
X-Exchange-RoutingPolicyChecked: OJyC/uXQEX93eHlmrlLE262+962O775CnR1iDxBdDT+sVCRRqsCgk13knV2A4/HAwuYWjWxGTNvt41bGoV5wkerRHHTSxKKwlCVaWpt2f0Plvju8OHVb2jC2nH0+IDC2lHAUGsfBdHwOYroABJFSN6Sm1qQFXajT+ZiewC0Pe5/6V2lqKUcDMy33WkyGt081nctFVoaboLIGqD346FlNXKfeZTMrK+jd36QlQD/ZHIhUI+GkIZeOo7B1GCWkcD+jznOYmDgtRPu43JrtAXzedjpzi17IGZtY02u5pOqsmK13pIFD3tAyBeTFst7FQe5xrZRzH9scP/3RBhGq3RBTxQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb82cd01-108b-4827-5d3b-08df3116646a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:35.6285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7528Pyy2BjArsVPR3nnHkQAPnIOTC+PdwPjv1x8gPdQ1WHMYa+YRLfwc0nEZEUxqWUEjwye66MFyUkdrFIj/PkJqG3QNontdDQkqRN3A60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Proofpoint-ORIG-GUID: 87XNW9QztggeLtqWXs3Z7X-J-ADn9kkY
X-Authority-Analysis: v=2.4 cv=D4jSufRj c=1 sm=1 tr=0 ts=6adb7695 cx=c_pps
 a=+Ua/q5Qdf9RbITHm97vdGw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=4lKoNvaWMPz1F08twPcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXyXvBgGfi0GfN
 UyoGNI0qYRBZit3PEZ0y0jgXONnjs9t9EKIgI3w953SYCycZFj8XOfLdBa1z6V01517M99RH80I
 9hG41iu6FGY46CkrQMRKAWRbSiBb3BEzpONqdfa69EVCIeuBEQxEvdWfEFicX4aclrBogbjX+GV
 Y0vY4/cPsU7fejAc+3iZ54dGf5dP5v6pqwEu0r1EAgX68G3WkgoBRppnqW1CG6AceVElfx4FVdt
 ptR/0cll9RslxtFBKvbB1+04kKgDhGnbujf6SXFwLI8Oz/ksC9xtfFUlXfn7dEQNct3mGTxKT7N
 6W237CjXSoSKFBKKeniwKI+hFLF6gfDlaFXM1WnEre7Kz9YHY7OkcLWSTRU6llYZIK07E+L854i
 HKlSbLKtWzYL5z24A0K3NgL3AoOvAFKMX6DwjcNb6G5rLB4mT20qgFNx3xbCjkvsXxA5kCLCWwX
 9q4j8+D5twGZJ5lqpWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX+o3hnzCiU3mB
 YG7NOncXAx/A8kGkQmyt/89gjx9YplrJDqJrhFxxcRYy8tvQhsvT6+iTKA54V918BKhsAq8ggju
 myNMYAY1r8IYdCrvaI7ckJwD2nddzbg=
X-Proofpoint-GUID: 87XNW9QztggeLtqWXs3Z7X-J-ADn9kkY
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

This indicates that the specified register values are being output in hex.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-29-mark.caveayland@nutanix.com>
---
 hw/intc/i8259_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 3bafd81ea7..ee325a659a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -119,8 +119,9 @@ static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
     I8259CommonState *cs = I8259_COMMON(obj);
 
     i8259_common_dispatch_pre_save(cs);
-    g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
-                           "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
+    g_string_append_printf(buf,
+                           "pic%d: irr=0x%02x imr=0x%02x isr=0x%02x hprio=%d "
+                           "irq_base=0x%02x rr_sel=%d elcr=0x%02x fnm=%d\n",
                            cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
                            cs->priority_add,
                            cs->irq_base, cs->read_reg_select, cs->elcr,
-- 
2.43.0


