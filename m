Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF83606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=0tF/ZK1v;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=nio0VwlK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjc-0006IJ-5w; Fri, 23 Oct 2026 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjZ-0006Hl-81
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjX-0002N3-9l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:04 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE7vQ63704834
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yXVciN/QP8X8giY9hKoQaS4oPl4/Jf3EltUEinKvi
 u4=; b=0tF/ZK1vEYjTAuWVXyEAaLd9BDLl5bHGNWSVP6nvzp9PaYSGibLjx7+8V
 +/zCGWse8S1EJYRPW0fJ5xfMQgFocqWvHrE6nRPU8nIQ3XSnUGSjUYSGV4nnf+nG
 RrmSz7yWvJGDpH/SC0a6Z537y1QnXV/pGnA+3iaU8CbYhrLCqC9xlUFsL2pSQCvX
 H8E+ioxwlDunEEIideuddDZkVxcadlvW343gVbXFnz0+la0Klt/B1HpuYy33kIGB
 hht8KgN9xy5uGEIQBbXO73v+NM3dPZf1Nx8WbcRLciFQMlDb0g+xvxnrrbQ1IGLH
 kOoFGWUvYtCx4Fh9PnSPAHi5QNN6g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023128.outbound.protection.outlook.com
 [40.107.201.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974w0d2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk+7Gr/nneLjxuzYoXt50omiFUZZvVFIt1cSeh/a0G8R7jk2gAnipExdgC/W5NH64Ybg/8rU0Ba0U1Uumfbgh6Mff4rKdldbubJYFAKB8zccw86T0Z70Phn53uFgyjqOGOvZeug5VJPApSNHg5AgglRHfWieJB8NZ8YPndijQPAAyeDU3N0jPMdYN+JaY9PxPqxhygC+E+peOhreY/g76TZMKHtqvvTOxpRPgJABDy7/j8CW+3nalxx7S/9wG1Ve/OIQICFLYfY0Fr+xZVy2RMFfmWIuT226wIdqP0Ar/L4yH0n5XYyopyTAe5+GOZa/CN1/FqRi5uADddqQMtIdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXVciN/QP8X8giY9hKoQaS4oPl4/Jf3EltUEinKviu4=;
 b=WMIbg/7PuwB0j7sLp9WmTZe+YOrfmrSFy+7q2RZUzKTFhoHdANhEy7L4I06YGSmDhJ4a3xNNHjy+JbO2NT4G6VLYxxF1bgH3a3XqEGSyQGydl5a3HyC3FwFfMXhjDT2P3yr+wkJL9JUYjVytYO+p/CdS5Luc7Hu5vF5AF8IpxWHUa/ab7qHjj0mDQkisjneTcUSymcdMRRiEBCEGUg1AvDhYyQZ4wWoZNTbQswg5lD/VcCrnd59wIoc8jJ2fWyelM3fMr0tbdUXy0QAZ8QIReY+zFhp7yvLTIg44RrN/8VMdrCVa21FdnPYVOMHhKQvPcWEdyvhdzelDzQkF60gygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVciN/QP8X8giY9hKoQaS4oPl4/Jf3EltUEinKviu4=;
 b=nio0VwlKnGUkAvVRRAhCd8v5VaTcU0ELE8d1ekDdbMGbRx6PeXjN9qw831och74i93dU+AC4ZcT2T20QCQ6Qk/v1JHLmaMHIND0+6oepEErbUiPvrfxuONnuAQ1CSajtCRFOPoXtnHMKy54DhtLP8rwb1x611Q26sAGWS7RzjX6VQNdkz8lLRevDOdBliq7IvrGyjEDu43mMLURbHjNdY/HecEpo6AzXWWDVcGPuO13itdi6JpLp/DCH9I2tn9xJ683D1zi0KEFlvLzcrniC81jAOrgrKN+UuKFRb3hyuX6N5ky7EI+whzauh8xu3lvAFvmyaYKgBr47nuS+PCMi5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LVUPR02MB11490.namprd02.prod.outlook.com (2603:10b6:408:39c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:58:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:58:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/28] i8259_internal.h: rename PICCommonClass to
 I8259CommonClass
Date: Fri, 23 Oct 2026 15:58:10 +0100
Message-ID: <20261023145839.34909-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LVUPR02MB11490:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9a7777-fa4f-41ce-2e1e-08df31162a45
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OaBkqNfozWTP8zRdaRQyI83GHu5jUllRaZOpGQRD3gLCfdqwZE9/IJWJaGHKgtdLBSqgAYDIRN5oj4tw84FXeX8e/MWcbbsFJkvBHD1pqQgrrIe47+wIDaXrHDAfpVqlSAHycRHa5A37ZApsYSRiSqNdUsefEXEACWWjwYhFcUBriLnnmyaGxVM2Hn3ZoRUgHHT0eUjyIEa2fuY81rehgkJDwhG2SDEawlm/qzbu++7wTS863p4xdkRTvCMnWV/mCMJi4plL6F3YaN1HoZnILRPB12K4D73yKKvC3xOTlyt959NOxGGHmAMKMon+O7B24PLJ6TRGmsohkdA3yiFjT9Kk57i40cLazBaJ1b7C74HyQZ6eJzK3Rzlzn1GlGJ4FhU6e5ZpEodEGCS7PE2fFDYyicY2++JEkjZlgj2TpIjViMS1ywsrWAh/MOvyGlhZDIIFA3sXYmOChBnBtqWMpmvvGwJdyaUzqml/+ykEkAo+Pfri7AtrMvf02rpSm+U66r9xZCflVkcMtKEFKruVFXvUcCDjOdlx/MTXO54+Oug+2MVSU49HXswhgZtbZJQJ44f5alyUDTU/d2vBKT6GJfImc4D4SwnF4tQvQKMYMVnauka4fwxEzoF5TXsZ9HObwa4KltfJcEpMwzLQ2DprYP0uCgQpxpfhZA7k5sg+SIkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvIGvi3dbY1vwpkS90tPqpmylrZ8sooU4rFTSkyBUhAcoVZv3nrHTrEt7s+D?=
 =?us-ascii?Q?/Im2rLekTZ/hYRkpmHxOVEAivtqOMsfkTbb/MYlhbKyw0vyjC9991odSlIMN?=
 =?us-ascii?Q?Q8xUYnyL0aDXaf8CE72rsKdR5+WG5O6djsXCOv1Lo7YLVAckRsI9j7iV7Uqc?=
 =?us-ascii?Q?2EEipP0jnoMfmF3t3r7Xmbk93LgWl7Ju8uH23QxBDTJhziImQ6RHn5hFBUex?=
 =?us-ascii?Q?bv/m+kM2x67SC5tN61/bpv61OYBHnN9EUOoHiYJ21jCpLR4+CZpnIjK3XJaB?=
 =?us-ascii?Q?NThPsJG2lUdEdOCo/k8nO07AxEkgc0NaIM6x5ME9TIpLpYWE5xSn1kjd2IOE?=
 =?us-ascii?Q?JjE3m5WvGMmVS0YXbDKpqW0EVgusShpd236v64KzU5CKaGNcAz0431ed72vN?=
 =?us-ascii?Q?H/gtYefQVexTu/2qG5YlPK6GC22Lop6rbeJnaQS05xnr4skPeMox1lMCSt28?=
 =?us-ascii?Q?Z76Y8tuIe/0li9eUYdiia50nE6CrUPkEYnMOewYWv1az1qg+ZjU9KMHFzqe6?=
 =?us-ascii?Q?CaJ290RO2et7FG0SYVTGCsWnn1K3ZauwMnlUwj2L1w3Psn4k9F8onJHuavZe?=
 =?us-ascii?Q?T5QbXEJLTInFfsG0MvT7+55KVRpwa/fJ91Hu6K49qiW4I9fTYSKP8qitocPZ?=
 =?us-ascii?Q?nOR9DUPG6AEzL1hj1IXzba/l/ed8Wsmk7KSHN9euXnI5cfS7hTK9YY1mZ6Dg?=
 =?us-ascii?Q?c3+JKi1BDU1QnEFEgRyXX28XN/RTvuMY8HN8BE7wzvjOhNBxGuVOIuX/qhMz?=
 =?us-ascii?Q?YxqG1Rq+/dzB02QihZp7N2dOPyaadQw8OPeRt+dBCY9eKNdxyqVUXYDeTrnN?=
 =?us-ascii?Q?K7ANWwaLJuFL3Xt2sPNxqxfI4pZ2iC1kmDYPALGnWuPlkmgqWC6WPPV5N5TR?=
 =?us-ascii?Q?oteDgM0Zh7sIxORhg8R8mmJR+vtZSpb/w9WaxOd5ESiDXunVr2xKgtspw/Fv?=
 =?us-ascii?Q?FU8DBI/pEDRvgrwli/hT3tzHTcnu7QVboSAcXaYst9r427jT9Qw2na53LQLw?=
 =?us-ascii?Q?v621jc5gr3aE1UEhov8uzg/8v1iQXMl8+T/9uzVJe4BmPHZDq4WjM8wBqjAz?=
 =?us-ascii?Q?eCjF/5vJ26MiXsIgCenN3MV/n5mLWMs+JisFrwv1W9mSw8QgGbLNccd0Ml5Q?=
 =?us-ascii?Q?vyzS/k97BxdR8Y8O9UFpLzdXofSaHanweS1VI6jBHWREYNGBXFj7C+sh/FTM?=
 =?us-ascii?Q?dqrLZLpLpfETQD3xPu/X1/7FStST79927/zHCEa0yggc31y8SvuxnGPQVzmX?=
 =?us-ascii?Q?cPmVEiG14/ofLHbkTb/dQVy1+Md6OHzcuzuhwKk01r2mXzzSPrUPN1hxdvtO?=
 =?us-ascii?Q?owfBNHE+AQ5Uw3y7323ANw9wl02zrV5m9zfCks5f5ImS6o5UgLXFv++0muey?=
 =?us-ascii?Q?jQBYVHVS6wc8kFDMCguXvwISgfv1q02jphlH1QKrhJi4r4+Im6hsRXyb2CgL?=
 =?us-ascii?Q?URf2tk2qmelt1+Y7a/kCq2jTbv24NY/SJD6P9HagJANiXdUqzZ8f08vvI69i?=
 =?us-ascii?Q?3RIR2IpXMXyMIL7R0W7qCZ4SMBPVcI1WVvJnYkViFsiE9E0jECOVERLkZm1o?=
 =?us-ascii?Q?OSXeDwViwi3SdCq8LPA1SAHCcjztzc3rLbg8i2spNIdNu2zvIkWWBk/AL3F9?=
 =?us-ascii?Q?jNgAlnrowGABsbETbEhL/bSL1aVxgTar39/l/g5GyStjPagb72Bsk4RkBtKA?=
 =?us-ascii?Q?LGuMIGWA4Fd5DU5lYkfbdhpah26uK+rXkQAoY01Z0NAVFkz2Z+R+uPsq9OkI?=
 =?us-ascii?Q?YriH9cliQoTlKbugpNBU5yNZuwmXBT4=3D?=
X-Exchange-RoutingPolicyChecked: lzek0gLGe8jywHz351L/in5K7B7V0USNiuwGKBnMKUXulPIU5sZAyA+WbgfnDHjG/TDarF6Mu9ITTzksI+GX8fPplhEE1L7oOZoMbrGUP6OVUL2KK8djTxLGtlxdhc5+wUjCezyhFo7Z9zol3X6yiqdM9xZM3B3WKZRIDiUPROSwC1Ovnte7LbzdW5lTC6MJtHRuM5vr/DMuBMfCvJ5m+JAc8+RTyhQWKSuGMg6YQaqMnZ1nftyUNmK0B/GV17AVpHa6Xhge0hthTP5MytPxbn1ZGF4a+W56zG7lTAyKkA3UZRWrpumUwtwAhBL2qkZgCbQOHYdxaPeV9WsoYe8TcQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9a7777-fa4f-41ce-2e1e-08df31162a45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:58:58.1004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqY4y31dE4RzBdOzwJdS6xfVthw5P4juXJQdrPkFDSQ89DA0Rr4RhWW+N9kZHHx5QYYLvYVASF/jAM+CyhTw/xNAofD6yFnwjjO/CMrkClc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR02MB11490
X-Proofpoint-ORIG-GUID: IF-OP7deAm2Xj8yQA8vya1-fzRM_vKY7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX5RLSd/gygVMY
 Ikaue8CgM0Ln5jpmX2l13ukq4WcKZ5RD8z7pM7T93tfeQfP1+jlIXzVnOWzFMkBL8nXmwnm8/q9
 BeOQcbfohxYc75JsHL7gW9xQ2BMr/rT1Z69lqVzoXx1++z0sqdy1IVS7DTlgKSUpwRGT521X+O9
 /ja6l1gCZSxVh9/CYzNjwnajt0ZYKimebVxStJvw4Uw+kUXnkkyg+KM7CWZiFavCYMJIv1XkEUf
 viyJwcg5LFUgRyESgb9dpYea7knGeFsMzrsYegTo2YoVzrhk/vpWuyzBq1I2jSW1qXXmtKRUR4x
 FNzrISdGSwxfsR9/Vc1Z06Yl7qvrN0BTOynl3gVLBFwEU55+YfrmhtfqCyN/COgWnsJ85Rc69NE
 OiBRBBsSNP2F/NYzLOf6S3sPcb29hTbXb+lAXXRLRFROU1fTEix3WFBfut6JwZFcI5R9wLbMYvq
 RsWOjrP3spwCXeDR6sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXxmEBuVzeD+uS
 4sxdPf7uipHB5oI5XucCftIh4qUZnGnfpBBWsecgCWT7gsywK/3j47eh47TD7Oc9ThwAneu7qG2
 vjudnEhw3h7EtECT5f4q1oB5yOC6PqE=
X-Proofpoint-GUID: IF-OP7deAm2Xj8yQA8vya1-fzRM_vKY7
X-Authority-Analysis: v=2.4 cv=TK7Q2Fla c=1 sm=1 tr=0 ts=6adb7635 cx=c_pps
 a=oKUGrOEB3UyG4cVvJxNfUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=qh9Ixq9Ib_qUO60TQ2wA:9
 a=cvBusfyB2V15izCimMoJ:22
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-5-mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h | 4 ++--
 hw/i386/kvm/i8259.c             | 4 ++--
 hw/intc/i8259.c                 | 2 +-
 hw/intc/i8259_common.c          | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 7a2f9addaf..e039d6f067 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -32,9 +32,9 @@
 
 
 #define TYPE_I8259_COMMON "i8259-common"
-OBJECT_DECLARE_TYPE(I8259CommonState, PICCommonClass, I8259_COMMON)
+OBJECT_DECLARE_TYPE(I8259CommonState, I8259CommonClass, I8259_COMMON)
 
-struct PICCommonClass {
+struct I8259CommonClass {
     DeviceClass parent_class;
 
     void (*pre_save)(I8259CommonState *s);
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index f10643a120..68607d721d 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -29,7 +29,7 @@ DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
  * @parent_realize: The parent's realizefn.
  */
 struct KVMPICClass {
-    PICCommonClass parent_class;
+    I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
 };
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = I8259_COMMON_CLASS(klass);
+    I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 45db87a2ad..547e86c5f4 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -44,7 +44,7 @@ DECLARE_CLASS_CHECKERS(PICClass, PIC,
  * @parent_realize: The parent's realizefn.
  */
 struct PICClass {
-    PICCommonClass parent_class;
+    I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 17040bdb1e..ac8dc7cf00 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(I8259CommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     I8259CommonState *s = opaque;
-    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     I8259CommonState *s = opaque;
-    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -223,7 +223,7 @@ static const TypeInfo pic_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8259CommonState),
-    .class_size = sizeof(PICCommonClass),
+    .class_size = sizeof(I8259CommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


