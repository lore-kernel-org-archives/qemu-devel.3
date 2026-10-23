Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9F606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=LCZTgrIa;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=G9sXCdUq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkd-0007XA-Ux; Fri, 23 Oct 2026 11:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkM-0006cW-Un
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkK-0002PQ-Nm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:54 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE645h3858554
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ps7C/KBqDkMeZH3XrbHu2+P4KIjD48DPncEjFohOw
 SQ=; b=LCZTgrIaOLC/bGBiQZtrFNt0nnTRP/Pet/UmauasTRLQdzRkezPyYo940
 kvwSC91pq4KkNwU34SlIbkgxBuTWpEpyYMP4chCNFcpmJNcjAsetHVGYOoFuxrCr
 E4zG2xtkUZWoWV8vVa+b6atyBQeLQLvHOofRa5WcTwocL8WvwEzJujkizJtUQJJE
 aa7Nr1X6Yt9zjLtdnGfnl4VClFS4PRUP/8ALsbcAa8CYLEqa0tn+ceXUN0X9MfDv
 sgNLpFPOrAXk/SOHuwroyu/RkSYc1RwnCPHFFXvNK0wKaSxJiVOM95j1ob4ewTsD
 1DMeKjW4wMBXWdvuX/2QFD/+XceJQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022077.outbound.protection.outlook.com [52.101.43.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974cyyr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhYRJPzfRigY4o5d+6uiHZHwP3+2CuG8y3VULpUGMLqo80tmgqAoe37eFqnyfi4kY345PfYkExRwqzdTNgdkvBjrTiddNo2p2t7T7NKaddpOWQDffkpDdKVvbjhoX4QM86fjmxV3pvwx8uCg85Y/tAxRPS5FE40e4fwCSWGilexNhWEtZgvghdrjdDD6H7tmxyv2gGuvB4+9kIF7OIMG15VdoBKrbGZ8ZfBE3HyRgGjYBcINI6oaeV7I4PorgXWXRvN97LQDiIklc7/2WkdY7YyZ3I4ckIkLKgEVqicQuVCk6lStgQqem+DI/e0E0d13XRSS0s6FvTvMBjqhVOcXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps7C/KBqDkMeZH3XrbHu2+P4KIjD48DPncEjFohOwSQ=;
 b=ilBZI16/mm1mAuK2vhKZYFGNDlpKhhRDTMdqhaGDKb/kY2eIcvO3MEvTJBi+UP+/sxHy7VYsH5ZzC2o2nTZV21ZKtqURETrR2BiEd+TrmTvG0UeYstTcaBexZDr3GAWepCRRfXC/0aU3kjO/qYmvxhc1ejX7DUxqqIxXbktzuS8W94PKaR4dpjFQDLd23FNgUn2AZsAp9cYlLbQ18etovP9+jb5DOHMrfhhrmjFVPURKnLEJZvkJXXqljRqW9pSOQJAgrVxaGuW9KeiGf9GVvdmQzowC5GaBwtf8FZAO9NA4XTHiKcMi1ZBISG3RgBK6eamQMr6Z1kTeLmsj4pKrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps7C/KBqDkMeZH3XrbHu2+P4KIjD48DPncEjFohOwSQ=;
 b=G9sXCdUqOw94MiOhqEtEVkzZJYxBT1B78B/wTNzBU49HZViAndw5uXryM+zCXqW2QZZPxE0UjyXTOm3RdkZQYQ23k8hikRcNj484cFZMfx4X1e7/8VkdhB6N8QNTq+Uxa46J4BMxGz2knqAelJLDcyF6Os0viCZuT0dX+gAEX031GrXlQphizuWyAD/CbaFFsnkCVpQmOBCT1RHxXA65mmZmeTFDAlsAA4Uv+MKyuIP8QPy7fQuuU9epuqe+oBQpst0+DTdkeM7mSVJR+4nhWAXJPOSHtE6jvXfY7Zz8os43b3USrEO8opaf1KDzFLj3WQOAF4iB5EP7lcnrN2zq4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:48 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/28] i8259.c: convert to use DEFINE_TYPES() macro
Date: Fri, 23 Oct 2026 15:58:22 +0100
Message-ID: <20261023145839.34909-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c63ec3-4cf6-41ee-bbbf-08df3116487c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aw9x51uYL8hqdDVxG6epd5iQD/0Xx73u/VYUWsQs73kDClQ6ceSFrMxzFn9UCgY4HW9q/nzHEHhtlRI40EJuOQnb53tjy1tFH900T88geCqKv5VBr5nScwt9LkACSzihKOD64q1Wsx3pObiHqGdrs1XjVR4XguICglhcAvvOjGrk/+kyVH5j1hkl5LLN8HzHrinue4ZHS1jKtti9mnYQ929XUJEalf3Bsxjobmg0xzuRgXefNsHwucqNrNfwYIN734B+ore3GUjfbY9YkJfh9w2+Q/xkx0NdOoyA7bPVBBqkX8E9TLSy3gEgBGiSKAhyVFZYoCkHGfoimSs70ymw38Gu8k+f3/Wm6YtgSDE6yifFw2Zp+KqA4Dv6s9cuy6RT0QF5PmpV0pxIn8KH4QLvAo6gKdn3iH0xOghV3ASxsu19H/d9WaCT24AuUxuLJgjJuKQu8Nu50CxDo3Pju4C8YkfLkDZajXPjwCi3SutDx81lN5eGvYyD18jHS3vFcEu35NIjZW90nso6PorHjGz8RzdwbvxHQ9ZVgzE7mh1p+PT7j11LdZeSDDnKWr+yDhcJo4IWbks5KjAv/iwYDGLuybV/SuWq3JUNGO37tP5UyYnFm4g9d+eCeqXVHEzPWH0DrsuLdLg/9M93qHCZPORzz+SGpcg2YG6wCHFMBasQJ5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?di9ZQ5Lol3hTd5WB5jklbZahc/4hEGXoDW8HOMrTueRAEYEr/SNFoB1uvLB8?=
 =?us-ascii?Q?2kUOObBjHgXKat5cCIu3IDpVj88gezqrqzJ5NGqc5+dSZT4wsjXr5sO1By0J?=
 =?us-ascii?Q?5VVnw+br7pFXwusFTWpTZXvR3/M5Po3pJepPyXaxhDzqgdUM15L7cr/t3apm?=
 =?us-ascii?Q?Q/rKqXhFuanEyRGZPWcEf+2Glvf4RbbVfu9bAqH9xMwOki7un+I32nhFmosP?=
 =?us-ascii?Q?Bc1gh9CrYVZmSnhHk1KnLH7C95piRwcRX7gyMuP9cSaC+UvbsGtR+EXjq8Wj?=
 =?us-ascii?Q?lNEVqVUFHXlYK6g3KFocHIrbg7xIpDoVGGHifslwF1IQyqN4TD81fw7wFAhe?=
 =?us-ascii?Q?0m0Sldw7Q0Q4CkhKPnaVo3CM8/Mq015amdVrCfl1ZD4XwywahE+z4blxXnlL?=
 =?us-ascii?Q?w19rDP380oPJuGTIRsKwKovzD0rjZqgOyu0mQjQZ3ZDETNa0stoi+xZm4TIk?=
 =?us-ascii?Q?ICSOJWiNO0+hSpcP5CYBCU18wVfjXbQpEmegbGr0MlQkEPb9oF2Y9jae2g07?=
 =?us-ascii?Q?Mr/DCv3kFGbBu6oKKBvstyqz1fTmnPH/MObHr3NGOCIytv/FWv0xoHs9LNr/?=
 =?us-ascii?Q?NRYnHV1ra47HNVqZcDuBycvecUQrNREJ0M4arOQnD0eENeuExx12+zVqkkvi?=
 =?us-ascii?Q?j6DNP7z720U42ZyGPMXbwCJtzukwsgkt8eOpk5ygvf8eBpc2dfMa/81vD9xc?=
 =?us-ascii?Q?D0PqbwYh/z0sOpLd+TfdjJ/vUlvNGGyF37Zkk4erq0O9QXyqe9Lu2ShcUj6i?=
 =?us-ascii?Q?j7iasoXXJfAKL2j7TMLuhLXYuvlyR37Pw3UrmT3cckeMsMJo7gNtbzecrUKF?=
 =?us-ascii?Q?5cT6V+zglQEwyizkbabTS4fX0WEp78h+7KsWR+V5EwT/sdj1DqSbSHr0ZV0w?=
 =?us-ascii?Q?58z/J1MjH1ip3LGrjqXluEHNDSvZQmYWcK2OHWnPZIDazzqaCBvjcew9tFGq?=
 =?us-ascii?Q?tP4ozfvcAQO9wc121GAZs5XWRn91UiIGu6KD8ROaDhuv8ssMfi1xk8t1mEd6?=
 =?us-ascii?Q?wQNAwvJYWRv0QD2dcgqMRHOpITMPP/p0vyKLx/EbCop5ww1FqBa33R8iczu0?=
 =?us-ascii?Q?KixgN46v1fUULHMR6JuyN5INsEYa9KC5mTYe97FpXvMiLKTVbP+rAGQDxAKr?=
 =?us-ascii?Q?r6vWMmEyf8pXdzd3Z1JS8q3KWL1ed0F5p4JfV3xYVO2M/+Z9Z9wXdp6K3S1i?=
 =?us-ascii?Q?rVdxX02fzQ1lrhYGuD8snU01d7EED8f4/d3pLff8lNJR6RmGOSwf+rrdP7Jm?=
 =?us-ascii?Q?QxmmdOwgM6q0PqhnSZaxEEh9Q/JwhTkXo9MnDBw7YpwUuHkvpWA1DdDVAKaJ?=
 =?us-ascii?Q?LSbyQlZEXWeby8a3+Iy0s9auz1OuHlrT1fhn4ARaEQE86OReOf/9fT9LEf3e?=
 =?us-ascii?Q?o69qo2A6W8hZlJhqMQWVCuQcP06KueG6aSO1tl1YgxGZASn0FaIacVk5zEQ0?=
 =?us-ascii?Q?khivrMkU9S/AgJRWuMP2opKmd0BsI3j/sFZLOrVEiJ1t6GGTOKiECBQjhJtw?=
 =?us-ascii?Q?he4TMhDfGY+pIQeKD4sa+cK2NoDALk4LNAGTFmgYFHXzecxDcaoiQA5aepwn?=
 =?us-ascii?Q?myKAn18vGCY00JZuCI0Bfs25zmoAVoMmjU/B36JR3fJMy9oKJrtE9YtAlSQe?=
 =?us-ascii?Q?PMwBxTkjdJTaWHCqWuCEXho/9akE57gttWuZbftq9Iz+BBmDXfBsQ4sa8+z/?=
 =?us-ascii?Q?mRNQsxNcXef7ppMmRlyjIOyIVv6y8gvla1RbFYUAuS0rcSi+Bg6+RtDW4EHj?=
 =?us-ascii?Q?cOF0+tSJkyZV7sSE1zGhIavVMKYKQBM=3D?=
X-Exchange-RoutingPolicyChecked: XXELdUc1W0JmcYrb8A/rxxi+0JsZrVPK4Fnnaa95/vgY2fjM+F4GxQaykZOdwoMJ/R40Ay5qA3qDRu03pF7DbdquHgphKNira8wuoIF4rNfDY8U1kP13V7k/NPXVqywoWjiSuH60RLT+bDBd50ZldvDaFZ9swQ5vJx3eykKsFWG9AbIj8PvGB+OYStdFPSaDJsVQxVhnLB3H/nFtrH+uXK+rUL6eHiESKDu2WeagoQmABFV5zkQmOcEBUyFcEE6htExFwe2C3jX60GabmUUWd6H7q+mIUN9DulxNhFSwASjvHVhC+BrBNbJbgvTItu89DDn/XPMGvuIdn+/leW8l9g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c63ec3-4cf6-41ee-bbbf-08df3116487c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:48.5890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/8B4j/NjKCG1zfvcM1TLIFid4H5IbO6vDPZ2GNNtPK6GzBG5qNhZp0RECUpLLeDCJd20b3NhALmFIaCbNip+FiPTslwzEhWK1a7RiH5Ic4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX8HzTdiswGXLy
 YOvcQjn6bjeF2F6XK4rlDxUiBGsPJ78OM8r7VclzSeIMF/Wju/GFswL1q+fUivjwoK+ge/iV4fE
 uvOJuP5bJa2INfXalg+F/ChBDMQ4NoKL1/8zHWHp+VRktGpkkWnfq7S9exSEOjZrwJVYYuqYTus
 kss36aAiQ5ZV5HdOWQ9liSm8gSz5wQFairkB0Z5UowvPI4EnBjCUYleaD0noWSkEndLvCSKv8vr
 t8X6a8Q+5XWAHBoKW+zOhRYMEUFF4B5XKQ6rRZSgaNvVWkTOjstr7cPOVaxJDMwjw9VVlzGaxtt
 fkuUlFmlauUk2T+/o5ydbn8QKeRqAeZbjUK7p8Dbe95G7kPnfcvt/niGA/vopYf9ZE8IU4jsFlF
 jzFXma3s4a95XULHb56vUS3wWn1FvIZkaDpmyWEAhUFc59I9G+aiyTfb/d1iFN+atDTTWu0Qln1
 IITkvz5kVHZv9Kh31rA==
X-Proofpoint-GUID: XlmKtYuFAjfHivUARf9-sxqAu6EAxBfj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXxWXn2dAeCUx4
 DM2e+7hWKYO65ZwaM5rEqccTT1dVVZMhTz7UR7hmM/6nq6859Cn3AJBUZgi1WcxZyod4JhbMtcv
 d4M6LcrDO3y+Fvbny/wg+ABuqlNkODM=
X-Authority-Analysis: v=2.4 cv=VaNir1p9 c=1 sm=1 tr=0 ts=6adb7666 cx=c_pps
 a=7Kp79o39qosEjZWU4lqIzQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=lKrOaJ4ZLGcPJhkerdAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XlmKtYuFAjfHivUARf9-sxqAu6EAxBfj
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-17-mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 4b34e5a649..e5fa0f2e5e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -447,17 +447,14 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
-static const TypeInfo i8259_info = {
-    .name       = TYPE_I8259,
-    .instance_size = sizeof(I8259State),
-    .parent     = TYPE_I8259_COMMON,
-    .class_init = i8259_class_init,
-    .class_size = sizeof(I8259Class),
+static const TypeInfo i8259_type_infos[] = {
+    {
+        .name       = TYPE_I8259,
+        .instance_size = sizeof(I8259State),
+        .parent     = TYPE_I8259_COMMON,
+        .class_init = i8259_class_init,
+        .class_size = sizeof(I8259Class),
+    },
 };
 
-static void i8259_register_types(void)
-{
-    type_register_static(&i8259_info);
-}
-
-type_init(i8259_register_types)
+DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


