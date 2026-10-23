Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270F606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=ZbqkzHnQ;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=cfgncaoh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGk2-0006PC-8p; Fri, 23 Oct 2026 10:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGk1-0006Oi-1Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjz-0002OW-5r
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6X913757989
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lmOB5zx+oCaQ++fA1I84PTUL2uEajog+nKh1qW9pO
 NY=; b=ZbqkzHnQOTUzndS/IWHlRNP0lp5AS7Bycu5F0iptXDoRdjLaGpT6r4CVW
 9NHMvK5Uud2wirH5dStLcqIV5TW05RTkgmel+pJ/ZpodUTOyylHRoeoJgfsWYyV3
 P5m920pT0RkM50/lwgvTm05CH0YN3Yu1gimBndzAtc0pO5tf5VtUtoGZNEbeeeqr
 FPZKVQlv28StjLwQX10dmvHQ+GZAqz0iO6p/gtVqnksKrNNV7tO65pYpfG+7J9y1
 WSShQLkmnlR6+13BRlRwj3zgf85knhH0C4wFlhG2YMKDdvrcYdFMQ79lzE8YTK2s
 YkbmYe4oOqgR73qiKZxLAEVxm/3GA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020076.outbound.protection.outlook.com [52.101.85.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975cywr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcTxeXLdOvoNmaslLvKGY9/TqPyi9WFaqSZpV44M6zSHNaJwPJ1u484W2i/xj0a7F6g820zXwCw21+4OZ+5SrAhtyzQnM5oOc55bqf83FULnRiievvE4hh3ycwS2vUmJzUxzdtwMDS9fLMEKbZyKZt2AoWVLY54fBCMT4o0ZMXVIhZM3XTlZXMII0OrSSMz++1PV19mYpbtue/+4avX64tg8fAIkPtA+1QO3/gaa9z1Sj4SxGmNF9v566W/kddXBLF4o8USfY4wrDw8pS5IBKYNdbQM8s947IHW9ScDQ/5gtUzoPK87fara5DiAdQYEt5jJsoBTg115FreoPslJpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmOB5zx+oCaQ++fA1I84PTUL2uEajog+nKh1qW9pONY=;
 b=Njj2osVlIblkfI1/lA7MTFED8nApr1lm3hZZRPVMFxXvp8TOR0+FqayAZWq0ANwSlxdJxdtpXQ+CBQmdpPC5NJnk44kIa/gK/NTdEsBfx7S2KAI1vE2Fkn5PoIFo0jHxYZ3OgZfx8NJo49DbfvSRHbVtQh/Z9sK87Nj5D2WoWCWcPh0eL/5kmEMkc+JNLgpUMwyXu7xb2d9Iwd/rHwyevB+i/TMUycZoVWbpebityabD5t9cB4a0ZXVS/PFQJWq1ot7o5N43fBqTHOqpBu0SR8DSPy3WYbSSoYcTS1soVb6AX8TdwizMHWhASdY3sd4QicRDYEhBTmU8vJf7vRVe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmOB5zx+oCaQ++fA1I84PTUL2uEajog+nKh1qW9pONY=;
 b=cfgncaohJyo3G06fDlB99yQIZvkAcJsWPszs2jIyHNsysxuv3RSDYNX1E+fxXHfDSHO/eGoQwRtlLHL6NSLD945cX7boGJ0fOyuCUC8JdUnw5UQKxgc71/Wcy/3XLgqE6xPPg8YJGdT0veh1I72IFBRevgvLkP4+snXN/uA+2f0x4oxtNIUnMosBxI7O7YwEP5WO76eRxJyFoWuVda0/IkTgBRh5JJxP7XtRkzEhH4NqzKHR2YU3SbyB75TRvcFmcjZ1le1K9vtCgcUc4UVhGnd7+kPukxsExwOA5YUXflYfWpVck3x8407372WGJh44VHVZMsR0hq3cEhHNGqBE+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB323931.namprd02.prod.outlook.com (2603:10b6:5:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:59:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/28] i8259_common.c: always use cs for I8259CommonState
 variables
Date: Fri, 23 Oct 2026 15:58:17 +0100
Message-ID: <20261023145839.34909-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB323931:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe7e565-dd3b-452f-33aa-08df31163b9b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: VqdZXbIM7vGg4Z+00pmryA0XAsfgXWupLVnEK9vLEpA7nclSN2Pfaqgsd4zDCF11aHXRzlDxuHouwlwVoSGpniJwD4QdnXJnGfB7lfMHYMuVdj/efFgKRCeYQQa1uv/crXylp2wLEXGSh8VqwZKuXIfg3FSM/gxRR5ZpOdrhcwF6XTIAfoGCnGzwlyJZ0xdTcZjFRUFJ8O7oYHbPruvd8KtgqUinaEclNYtEaSagJT9cTStsHxiMQt6Jt/05nFxuploOVgs9mZFK+/bRXftHIYcKbirk6RihtudzYMpfTzmSbp5Mv4lxl13kGX94jvnba+KykzN3QIlE/KC786e0IR07BH3MCZagCjlhj8VrpClWvn+NlcfwlnKFx+LqC407dESzusv3TCnvWdSR05FnnkxwGJKy4bg8yoSrUSY/Dwc3JaCvwkZi7l/eelMPN+Fb75rXi3/gqlNSJq42v9UizNiml5Kyt8l49MQs6ZAk1TxPU1ujhPeDYUToQgLM1o5+wKd1F8ew3Pdj5890skAts5QJ1zowIYbQmJ9wUW2d5X9KNrocpOsq6N62LNqOOfwcirSXzO/6zDPkoFxLg9XC1feQpxwFt4+m9qNI7otQX9S1/3otHxpwSiu/2qlaDRlNUeskLIYwqk1NBYhLokDVTBxtaM3XEyboseIqZtgh5gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/gAkUzCbnZF2wSC8B1ne9V4DxpwymGf0Eu5gRkWE+4kvpGS9Ntx/GcguhAt?=
 =?us-ascii?Q?Fdt/Ho62NU/QbPPaF3+SEz9UVQry228fPFu4MChbaAbGxMyyYAv01gkW6xcK?=
 =?us-ascii?Q?HybVI32nislwfWqKsgQsDUiujFjcWyCY5ERziFfex3dFo9eNEfka28Xq+phQ?=
 =?us-ascii?Q?/bgjaxQqHnTsFDzl4iUTV8Kl3yasqCH/9iCs1a1CwC69Y6glCocvx1lPhIcg?=
 =?us-ascii?Q?Dw7jol3Y9mht56g2Lv2fxMlvia4Xs26ypuq4Y0f3w7NOFT4elDJbX/GeRAHN?=
 =?us-ascii?Q?GVbasDtEoP8ApAoBWK9EaDZ5RlJPL/Uydzbm4kGE6qPrjqGVbtO9sGuKGziS?=
 =?us-ascii?Q?Yybp6SnNST/nEeOt5isj3mYaMs/iS8VR2S9kfAgJCAmAMERpgQFaRYQAO5nW?=
 =?us-ascii?Q?K8uLI2ty96euc23L0OsrpeIUaYoejif+dCHW6g7ZTcMdxEkT+LevU7oRYL0K?=
 =?us-ascii?Q?K9LMpQyxQUeDclma089tbFvu1i/deoT9fPC1O9SJFdgehLw0m+yiXAnCJV+u?=
 =?us-ascii?Q?1YR+p90mr3ZQzLGcBCoE5CrgnUQGw+J+hEQGe9VGisMNA+aSUvnPgUtS+QPE?=
 =?us-ascii?Q?+cFRwuZ2NjIrC7SVRGfQPAKusPR8gY6PMyXkWP/WpBOSwDInRywxDPUjRlF4?=
 =?us-ascii?Q?da3AdoKEDQbruAXZVLGCCXpV8HG21/8WP1EG0IxeBCYcslaZnwAlZHvKbqjD?=
 =?us-ascii?Q?xaR1MRigK0Kd93pg9OHHR6wZQkHy7fRDaPJ3X+RXjgpwPhruWI+sXyk31Uyv?=
 =?us-ascii?Q?nQ0ted7ODJjLYKYhuY3uKmT3SV9CLBzw+YVjgsrxLRqjA+YvSdG8r2A7lLFC?=
 =?us-ascii?Q?SizRcFGy22BeV2Hukg4PTLZ4e/ydYlAsph0M6JoTqKnVyoXOvH0yIGA2ob9z?=
 =?us-ascii?Q?SW2wxeIDc9BdAI6nltEQBPYGuBGatGZDhdQkLloV0Bv4zR2r9rphNfwhn/84?=
 =?us-ascii?Q?KzTnIhpw6D2ls/bnyMYA+w3D3+GU0TElgokjmH0puY/switpZLioRwy2T5aM?=
 =?us-ascii?Q?j6V66W3sPtHqLIqUhXo7e2gaSTqIboOs/RWolmuUrBQ5PkVYg3emcNSbO1gA?=
 =?us-ascii?Q?tCQGKJit7nfXEXBDIcZb/KBqlkOWk/qjpw5tIRkP0QQAX/UATZ/62DjpWFD6?=
 =?us-ascii?Q?9/1ouDg3Thxoo/RoAW2cvJ3Loijzqdcu8u0sV3bxxydhSTNb2+ulyzrBTolq?=
 =?us-ascii?Q?388G1ZfEyuLEsYJfdJ4kEBdJ6G8rMwIhLi7Qoz2hX9PnJrk37FzW7FrDLtyk?=
 =?us-ascii?Q?o/GmZhcF1PBKUQNv6duzjIM6hFCAOKl0v6N4ZkYismYTVW2sH2edJeyRX80t?=
 =?us-ascii?Q?06BrLGz1MmOuZDPre6/TE9WdTrZPdbqi7L034Jyk3yxccNsQuJkj/SiQyUTr?=
 =?us-ascii?Q?uECcaNj5qxhOtWFYG+Xc0kWeara1iMyArRj0tFbpKDc1+UnNcEA04+I/fJNC?=
 =?us-ascii?Q?TWRKl7zCkR+xFRK3Q0AMwvdcY+Js5H9wNeSsxCYyOCsa3U0Hb3oU58O1fPhK?=
 =?us-ascii?Q?ZeTMuFzJR9L6c8//OIicExd4niQQbHxv+JelozX8Vlxf4E0r8kLDDL7vwszf?=
 =?us-ascii?Q?d6XcorZJvfgeZe2Ea/wZTkzkTUmyOBfhG4+Sv2yLROku2HYYltkidUmU13Kg?=
 =?us-ascii?Q?kpYH6bqcntlY75JCmT5Qaoc8yKICGwGY1yJ2XylteI1wBotSt9l2TkuNLO20?=
 =?us-ascii?Q?mtNdvtCjI5iknjrX5jJOCZMF9Cuzpm+tz3VI8bTQpq237ecwSrNljliusXYJ?=
 =?us-ascii?Q?IyAFXVMA56npJCfpDH3wXuF9a+Vvcwg=3D?=
X-Exchange-RoutingPolicyChecked: O7dEGCSZ82sIyAl2dLN/AFZueiaPfPt1egCXclvkp1Wwej4aHihRIapYr0yj8PEGyFpZW7ZGfjwtovBrd6hGbgny9NPRNVourl2CI+9IWxJE7y29lBTW138avNmIMG1CJqOVTm53DCi1IkmbuwG30DnCQlPNXBgO3gASu30ebZgL9E8kRPv0xJ36n5sWJf6tfX+6U1mEkjvaFnUJX+h/hk9JK0Eo1PVc4N70T9agRTMgxkbGgphK2i0ufAuo7+LmPPwvdfrIQkIHw6Ijxgvmy6agQcAZUjal+E8pLkpMZYX81QBCLP494TLOFVQfy8hVnmtP5c0PI6uaQpy3PXnkUg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe7e565-dd3b-452f-33aa-08df31163b9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:27.4509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM2PxMODBb3gx0C837ZjCoIz0C3UnTnY1GxYTUgDAGXqMl9BSzpquRdjQ0bLQ1efvAqvEZy/+plsBrJYeuS8/uEZi1dbetcUv8rWmvfY/6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB323931
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7652 cx=c_pps
 a=PU2v30DqrLDYHXTVxoobRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m1qT39pvC01PgN2II3AA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX+ed9neXa6a9S
 KWLIXKZbIPhEL9V6B+RlaC2AkJEkM8xhI1pLbdFUNjF1lloy9yr9VJQmT0jG+cX0A7/x9uGdL6Z
 rx85kHzaEcswAE1ju7cVI3o6/M5wu/VvCYfJCAKZj9jysHeoilArY/0sGud+rALlmFzQytkb/L1
 VDoFixyemasbYaTx4NMBTzYlUd8P7gRZ0ZlpsolGRodRtuEu/o2GYSYvo1rv76Gvbi5r/qFmh1Q
 i0F4AV70bfJcA6MkJMHWg+Uk11am+Av9NQlwWNPl5623iKuWWJ/LW2e5GwM7tvgGOAH2RQXfdmE
 Zx3XslTC5GWHm3IZqrWaObzaagqLqUbru+dhsKk2/NZh6q3Fo7II7tq5mhCc/qqfbcgMwuGfIrA
 XBlplkuzDB02dH1bjSJkOs6UwWKbW2i89UJRjqPcIDcTsTE5+N+MNNhq6Jwg4DDkyuL7HfSff0U
 fPB0XvZrNaxZmUE0VFQ==
X-Proofpoint-GUID: 1_o4mng0rSDam-7TLeP9B6BqAXmV1g-m
X-Proofpoint-ORIG-GUID: 1_o4mng0rSDam-7TLeP9B6BqAXmV1g-m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4hXLc7pUY7Lu
 BQGGrSqaHRv3O812ACsyFnDwm1drUGW4DJ2F6cg4W8cgrxAJELgCbXTLp65XL010fbEu2ZXa5KX
 FHa1t1CkZTlI+Ip7GIj5KEcOEPuNEPE=
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

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-12-mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  6 +--
 hw/intc/i8259_common.c          | 74 ++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index e039d6f067..71fdd74266 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -37,8 +37,8 @@ OBJECT_DECLARE_TYPE(I8259CommonState, I8259CommonClass, I8259_COMMON)
 struct I8259CommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(I8259CommonState *s);
-    void (*post_load)(I8259CommonState *s);
+    void (*pre_save)(I8259CommonState *cs);
+    void (*post_load)(I8259CommonState *cs);
 };
 
 struct I8259CommonState {
@@ -70,7 +70,7 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *s);
+void pic_reset_common(I8259CommonState *cs);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index ac8dc7cf00..705a28ecbf 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,33 +33,33 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *s)
+void pic_reset_common(I8259CommonState *cs)
 {
-    s->last_irr = 0;
-    s->irr &= s->elcr;
-    s->imr = 0;
-    s->isr = 0;
-    s->priority_add = 0;
-    s->irq_base = 0;
-    s->read_reg_select = 0;
-    s->poll = 0;
-    s->special_mask = 0;
-    s->init_state = 0;
-    s->auto_eoi = 0;
-    s->rotate_on_auto_eoi = 0;
-    s->special_fully_nested_mode = 0;
-    s->init4 = 0;
-    s->single_mode = 0;
+    cs->last_irr = 0;
+    cs->irr &= cs->elcr;
+    cs->imr = 0;
+    cs->isr = 0;
+    cs->priority_add = 0;
+    cs->irq_base = 0;
+    cs->read_reg_select = 0;
+    cs->poll = 0;
+    cs->special_mask = 0;
+    cs->init_state = 0;
+    cs->auto_eoi = 0;
+    cs->rotate_on_auto_eoi = 0;
+    cs->special_fully_nested_mode = 0;
+    cs->init4 = 0;
+    cs->single_mode = 0;
     /* Note: ELCR and LTIM are not reset */
 }
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    I8259CommonState *s = opaque;
-    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonState *cs = opaque;
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
 
     if (info->pre_save) {
-        info->pre_save(s);
+        info->pre_save(cs);
     }
 
     return 0;
@@ -67,26 +67,26 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    I8259CommonState *s = opaque;
-    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonState *cs = opaque;
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
 
     if (info->post_load) {
-        info->post_load(s);
+        info->post_load(cs);
     }
     return 0;
 }
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
-    isa_register_ioport(isa, &s->base_io, s->iobase);
-    if (s->elcr_addr != -1) {
-        isa_register_ioport(isa, &s->elcr_io, s->elcr_addr);
+    isa_register_ioport(isa, &cs->base_io, cs->iobase);
+    if (cs->elcr_addr != -1) {
+        isa_register_ioport(isa, &cs->elcr_io, cs->elcr_addr);
     }
 
-    qdev_set_legacy_instance_id(dev, s->iobase, 1);
+    qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
@@ -118,9 +118,9 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
+    I8259CommonState *cs = I8259_COMMON(obj);
 
-    if (s->master) {
+    if (cs->master) {
         *irq_counts = irq_count;
         *nb_irqs = ARRAY_SIZE(irq_count);
     } else {
@@ -133,22 +133,22 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
+    I8259CommonState *cs = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(s);
+    pic_dispatch_pre_save(cs);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
-                           s->master ? 0 : 1, s->irr, s->imr, s->isr,
-                           s->priority_add,
-                           s->irq_base, s->read_reg_select, s->elcr,
-                           s->special_fully_nested_mode);
+                           cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
+                           cs->priority_add,
+                           cs->irq_base, cs->read_reg_select, cs->elcr,
+                           cs->special_fully_nested_mode);
 }
 
 static bool ltim_state_needed(void *opaque)
 {
-    I8259CommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *cs = I8259_COMMON(opaque);
 
-    return !!s->ltim;
+    return !!cs->ltim;
 }
 
 static const VMStateDescription vmstate_pic_ltim = {
-- 
2.43.0


