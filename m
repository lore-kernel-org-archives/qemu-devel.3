Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=mJpLNx0i;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Twt6VxYM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjy-0006OO-Uf; Fri, 23 Oct 2026 10:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjw-0006NU-Em
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGju-0002OI-EK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:28 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5uxa2349979
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h9UM17b9n2SsTVHsyOaJ5pvvt9IDHXwu8HYp+C6qH
 iY=; b=mJpLNx0iNk9X0EDUpNJFYC6dZa8kc5ePVwzkA/XpS41KArDbpqdefBBq1
 mP/rwgFjZ8V33KsZBe7wyPeu+mdPWWhaNZpLn+lxgg7cpnRCtooQH9ur+8X+gJFc
 qTRt+LlQfBXAe4WORfmF5RJt+G8y0qaEUpJzO+QF+r8Bdn5huXxRjZtdZs5Jy5PT
 kJtWBevNukEYDd+mFPT/DSQ7WkSyKXZ+nbg0soWqQ1sMIkNtwhTINCdbCrHUW/LV
 81aqNuRVymU8T6BzU1KtBxU4sO2jakg5/YqMBDhH5XJBlI7fT2AR4vPZJQvlXmsc
 c0veWUZL14BYRURkS0JfO9oQvrCsw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972d2sb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO8A7pgTj1bRGZkSx0yozwd6Y6+zIsnh+9l0qFBjc4IaQLldrpSfPQZKku4Q023WuSvlzwwit06A1m0lWFlve5SmRW6VkYei6l+/Lz6EKao9nzZPZcz+NwF3x5lqSKOstHhgSc33RQCUtoRxDTq8gqWkpCXeUdcj8YWyMZFpcd+mw6L3gL4Fpm5VrXeACK5HWxe81U6cxkC2aMnlcufVZDAwaospYEvA9D0OJ69efEyuGHVFIRPPX61z1vEDnYMo+ZutnLFrd66svD7U+tdi/y5i9WzJDv1i8j+THGDsYR8kgMWt9c6ngy8eZOqj8TWSZzlnNr6zs2Fy9mMTiZcb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9UM17b9n2SsTVHsyOaJ5pvvt9IDHXwu8HYp+C6qHiY=;
 b=k1yKx9AOxzIQaVwufEHo/pwuPep/eyPJmsqkGSQYeh7XJT+Y2kn6G1iz7XRGXRV6KqaFuN0We+juXf2K6l1srXIpk0EgWdFy9IJV5aP43zfLZvIAQzcCruFSb8MTl3OlW+H5aB8DvSA8n2TQ+VcK5MVcftUWZMNW8Me4kqkWmHimRTtpr3QWCLa+8VSpizgkBqiZpWtpNK/8Z5ynbAsz9lR09n6N1tsHRzm1YJFTehtJb+KeKkPCpNM0wSPNv/LUTXzjMaUX9zCk5lpSD67Xngb5C+qTZV+GAVWtHXyTJ+EANSPbkGUS6nZVJ04rrI/qSn8cG7OZm+eSDFPVjTDfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9UM17b9n2SsTVHsyOaJ5pvvt9IDHXwu8HYp+C6qHiY=;
 b=Twt6VxYM6A0UyhVr2blA6QKZ7R/A2KYnPDvuaHlADwWuNvZ10dSwxFk3C+qz3IqDXGgoO8bx0IIRY9+kF4xmgty30yhNGEiO7qK8ib5GaQ1WmtcggiFzE0s3cP7u+0h+R7aeldEcgRl9dgEAJeZTwG/BU0bKJsvJAXkIbsIpuEZmpWJn3oqMN3G4mtSenvhjoS9pxEq3zqkwoHKp14k8sreY0IG8PiS6OMtRf1s+FtSIgvoouGgYFFwG+czxi5yz3eL2D2SasCvGIZWlJUxZJcov1QF2XjoVXGprrXd7X/itldPmUsWlnkw4ISbvlOf2sXjFyRFE0dcXRgQqIRzJaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB323931.namprd02.prod.outlook.com (2603:10b6:5:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:59:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/28] kvm/i8259.c: always use cs for I8259CommonState variables
Date: Fri, 23 Oct 2026 15:58:16 +0100
Message-ID: <20261023145839.34909-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB323931:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b04ed34-c0f7-4661-585f-08df3116378d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261022105027099003|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: ft7vu11Rt+m8iNvwsHg0gRsfHw0uq1GSJP9uUCvzuqNIVEOAIobz1krbvAUhe6nms9eipOuXrOr4E/MKywpSGQusSs1Np/FJ5KkjFNaq+96AQyD2otyxlahaGt0DOfDC9LI2Y0mhzcRthikso6OPntl4RbjyQNVXMHxLaAuVeRs/yao4Lq3DpVInuhkeNW5hWgH4U2c34ERFHzN1R4496kImVnVoippK8Zew1RcYL6DouP7210xRjpsNB4m5P8Lsn/saida7GbvLnNIDRkidg+BpIDFq/RBlzPVgZvMHIkqeaJHHV+9lLeMz5z1nk5vthTtRYqxxdaM4w6MjaKZC/CmKcgPHbx4QHolvaqjay7zT1vnueBetdESY10OrRcoUIZxV5UDU6KPGiTEWiPuzuTK7pJcyJETPGM+lq3WuNpMnr2iCIp5iyNLURqP8qZAgk6hlcgapo45kE8VLD5/V7jYfXYt7dJD81kiODyN5zfPotvLVu31cvRJqBWer4vCNXhuxyuZk7CCoRFyoRS5q5VcbmC/4Fl8JtM5b0SmGO/lKuPqWM0drdyOgj+jl/mu8bC8T4ZWRKI6rpdtOeJn2oJNOmTJs0DkmmS5iWIxT3HOz0qfEo7c1duq7aaEzOsFf638stPYUQxAFxhwg8WL706tDB5P25qkzdc02K5GK+LM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHcHbBC7Lv4Pc2If30l0q/cdGVPVXfk4Qg6Notg7J1fGafaVAQckfSfXtGs3?=
 =?us-ascii?Q?PA/aw1y2A25Xazbhmi0rDaNuzcOtc723BDRjwmx1ROSN39wQtvQfNcd/hQ3X?=
 =?us-ascii?Q?GnT4HDfqzo39j2ydLK2hUrMLA76xZNkXJLkszM5IJRB1A5Z7py2DMtk/BL5n?=
 =?us-ascii?Q?9nE0nCCOIeBcWGIN/qAlwoOKf17puPhLRqZ1Cg16Rr+diRqVt+6kQRYXo2Yr?=
 =?us-ascii?Q?gJ0C2xfHsupJD/5S4Trv+OL7XULrwLd12E39mgE14WtuIuMZNRSp0Z4aUej8?=
 =?us-ascii?Q?9WDjNNbTx7aLEGeSibpUxV8n3xQtdN/xJ0FDZC8fbjchI+oo+r6Os7WLYikT?=
 =?us-ascii?Q?86OdEk+BnKcq9l4uiSc+Z8aLc1XhAgaRO3HoXvTs7D+Ph7cZU64Wftlh3hNW?=
 =?us-ascii?Q?18liyp8Oh9RnDvfP5ssQQV0XZW2foOVlvTkAy4Xn69LQRAP3sihwVJjIfssj?=
 =?us-ascii?Q?BrvYGElB9IbSQJjerNzHTZRux+LXiL1cMqNZt96VTieKPCo9DA+j8mLlDq5l?=
 =?us-ascii?Q?EwREqxSzT+eMmHTpji8J5XYDQJtGg6+OY5rKJCh6hwBhOWjgCPxh1P7Nu9/n?=
 =?us-ascii?Q?RGkZ5f6dbvCvwRlVjODx87lB7P0i/SUTlt4vdOngnEgrm+YUu5Q/VrVNAJ3V?=
 =?us-ascii?Q?fePlKSdpzxeLKHrj67dQlxks0wvT1QQ0/y8GEzJmMUTr24CGrQnhh2CIM586?=
 =?us-ascii?Q?UVUrhTI1yrOBZgoSdvwSpn34IU+/ha9wXaxdIDURqK80rvFeFaktydhSNkDU?=
 =?us-ascii?Q?db+ASPJC5R9PXaAVry3zdubicEYfLuXCinN0jzzvcFDDy7/hEK/TCvhTH8DO?=
 =?us-ascii?Q?5JomY1nsiIuPxQgO+szUnIvW1UX1G28H8LIkBbML4b4lDs9nWDeA/8ZT4q72?=
 =?us-ascii?Q?pcUYe3bByz3cbe076SyhQOgOoLrgNe3mbkp45ZLjbzJqj5e5n/KOMv8sjpce?=
 =?us-ascii?Q?nNE1m68yjNLawWEGfdpBt7FIVWZnxnSxSSMRGVq1Mk9So7DmJ8nivNeWhLt2?=
 =?us-ascii?Q?VTC5ZNFwq1mHP3aVDt80WQYa/mAdGLY9UyugoYQ5Wlhm4rmDr1xI4UW7rKqX?=
 =?us-ascii?Q?KY0ZgwaBt9zbV5B/aEWVo25tn3lwQfFOOlpkT8U+3l8RaKn5DgQuhLfq47ea?=
 =?us-ascii?Q?boTKsY6es8KqIHcdJFfCt4rHF6Xex/K8U7xqMfAHOOS+Ee7swp5tLjcHbaKi?=
 =?us-ascii?Q?Ur6IbahLubDDABF90BU06tLGdWLRQcX5/aOdPH8EGAK8L8NZQiLQrW7C2vE2?=
 =?us-ascii?Q?LLP6VJImdIHqGduUd582iQoZvFuce2QY2LaAbUbYJw098Fm0YixyFc5C0cPG?=
 =?us-ascii?Q?sSPpyiWUEvg/Tw2KK+vtqF1Iq0r+T9D6ks+Fbjj4IThktHIEjLAKTGbuvw8/?=
 =?us-ascii?Q?48hYI4stA8YpKjnaVIXflOmYHUF4nd+Zwj9qHqB/ObRxUdwm0u3nk5plpcIQ?=
 =?us-ascii?Q?IfpEi8Klw/cgwFBj34+alL3GT5U4qRoq8QGOEqwKW73LEjX0E/pFtPz3ktlQ?=
 =?us-ascii?Q?QU/ebP4vHd/KkpOQeKEn9/ZQyhAll+q+tY0kmxvbrOCaQJrcd5q2xyXe352l?=
 =?us-ascii?Q?zXSoLyAg6nQsT75tMQ5/hlE6obRXkYrAbjuWmI8WvqM6vdggGIBgB9pq61DZ?=
 =?us-ascii?Q?mINUJ0Tm9U7YlFxSG9mgNcwrvdMzphC+gu19XFhh2DEJAvovO4fHpF5ZfTfb?=
 =?us-ascii?Q?iF+2Tv3v6YpRMGPLNvlBe65vyiAcaMGYxZVnO+EikqacACQd9DBDoBk6kNJA?=
 =?us-ascii?Q?2TA+yIo7YXbi8AbE7Q4CTL0y1TcvEBo=3D?=
X-Exchange-RoutingPolicyChecked: w5/ypFxNTPKw+a3PjkjwgmIYA3Lx94IGcuNZrlFyBuFBaPMwc4rXzsI+OWuR8qP+QvfFDNwSiGizXCan051Ze+fOw1QuWfHoAk2BwFrOYiXkGf4dVVpv1b+sxEGJU89/TAlbsSacRoRXhXXcBSfvTjdvztQngpzFnUT+/mebA/C5Mg/+QlR8NeGrK7kk2pp4GDaP82aSfKqxsSpUDMUjuSOhgtBxXp0Ewo6z5m+wLp0Qff5TkKj8cWB1iZUUGwm2oYPoJi8/Lzti/3uhL57pAvu/2B50dUdJz4tsrqO0fZwipFxmAHx9GFCoytHeJ5ekg2d02Czau58ZXMcj2xiUzA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b04ed34-c0f7-4661-585f-08df3116378d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:22.9768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAMYuJqnMBJJeqRFtOCMzWhiw1cwjgV6snfYkmfjyaCNhkQfB+EzmU6XYddHOZqDsfc5NkUR1CcMxQzHsJa015gpzk2ooCI0fYRhoZuboQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB323931
X-Authority-Analysis: v=2.4 cv=SpMFe/O0 c=1 sm=1 tr=0 ts=6adb764d cx=c_pps
 a=cLYCveKuP4lckQHSrQKrbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=zNa_6NNZsa7Vo5epgMYA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JKbbM4eKC0ElqeaWihCQJ7dYsaPb3WR5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX62R7jmZDe2ly
 luH/fZcWAXGVLvRXS17TMcGlXTQmDow03OoT0Nuo3cP9kGTCw+guonK/GD108bhAO3g4oW5IW/C
 35vw84kLCuH5ZSAHnrKtfgUIOHY0Usg=
X-Proofpoint-ORIG-GUID: JKbbM4eKC0ElqeaWihCQJ7dYsaPb3WR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXwYGRaQEdkEqe
 SnbCbeyXIpL6l8pQcsSoxvkbiFtdRaNp65f9xhppWlrqJdybaZirNJ1ISV05O52e3cC/BWnu9XM
 MnaLsnttU5kbr0Qqoa+2JAXspH2cVQ6kigTuHzBDqz/oUKFi7KDeshZiF35Xo7378X5C+/X/w1U
 Ejmp3MxLKSqD/CtQyNk0W4HF6uUmF9gDcMGtktnRgVM4ZJVGZJ6yrNLw/jCgLNVoZPXLSYh703c
 MuoqW6XXkeemWx8S//LSfWKKz91CF97q4knnc26OfI3bjmd0Idv6yVhJH6WV5WzYeU64gbqtU7I
 e6yjTx2D4oq7yjr2jMAUMnmUqLpoStr5o+yPDPOZoUtNsNtWA4FVeHnYfJPpBPPEn02QS+n9AZH
 0uVsLfCwjWwjY+5h0Y25jQJUKj1RZe+1NG/dDxCnM6yB1ttwmIKqu1U2z58VBPoFLw2F47gPaY6
 YbrpO6fRAV4vh+ibDLg==
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
Message-ID: <20261019120517.1448687-11-mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 86 ++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 8ae5dd39b5..86b1ffea4e 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -36,13 +36,13 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(I8259CommonState *s)
+static void kvm_pic_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
     int ret;
 
-    chip.chip_id = s->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
+    chip.chip_id = cs->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
     ret = kvm_vm_ioctl(kvm_state, KVM_GET_IRQCHIP, &chip);
     if (ret < 0) {
         fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(-ret));
@@ -51,50 +51,50 @@ static void kvm_pic_get(I8259CommonState *s)
 
     kpic = &chip.chip.pic;
 
-    s->last_irr = kpic->last_irr;
-    s->irr = kpic->irr;
-    s->imr = kpic->imr;
-    s->isr = kpic->isr;
-    s->priority_add = kpic->priority_add;
-    s->irq_base = kpic->irq_base;
-    s->read_reg_select = kpic->read_reg_select;
-    s->poll = kpic->poll;
-    s->special_mask = kpic->special_mask;
-    s->init_state = kpic->init_state;
-    s->auto_eoi = kpic->auto_eoi;
-    s->rotate_on_auto_eoi = kpic->rotate_on_auto_eoi;
-    s->special_fully_nested_mode = kpic->special_fully_nested_mode;
-    s->init4 = kpic->init4;
-    s->elcr = kpic->elcr;
-    s->elcr_mask = kpic->elcr_mask;
+    cs->last_irr = kpic->last_irr;
+    cs->irr = kpic->irr;
+    cs->imr = kpic->imr;
+    cs->isr = kpic->isr;
+    cs->priority_add = kpic->priority_add;
+    cs->irq_base = kpic->irq_base;
+    cs->read_reg_select = kpic->read_reg_select;
+    cs->poll = kpic->poll;
+    cs->special_mask = kpic->special_mask;
+    cs->init_state = kpic->init_state;
+    cs->auto_eoi = kpic->auto_eoi;
+    cs->rotate_on_auto_eoi = kpic->rotate_on_auto_eoi;
+    cs->special_fully_nested_mode = kpic->special_fully_nested_mode;
+    cs->init4 = kpic->init4;
+    cs->elcr = kpic->elcr;
+    cs->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(I8259CommonState *s)
+static void kvm_pic_put(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
     int ret;
 
-    chip.chip_id = s->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
+    chip.chip_id = cs->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
 
     kpic = &chip.chip.pic;
 
-    kpic->last_irr = s->last_irr;
-    kpic->irr = s->irr;
-    kpic->imr = s->imr;
-    kpic->isr = s->isr;
-    kpic->priority_add = s->priority_add;
-    kpic->irq_base = s->irq_base;
-    kpic->read_reg_select = s->read_reg_select;
-    kpic->poll = s->poll;
-    kpic->special_mask = s->special_mask;
-    kpic->init_state = s->init_state;
-    kpic->auto_eoi = s->auto_eoi;
-    kpic->rotate_on_auto_eoi = s->rotate_on_auto_eoi;
-    kpic->special_fully_nested_mode = s->special_fully_nested_mode;
-    kpic->init4 = s->init4;
-    kpic->elcr = s->elcr;
-    kpic->elcr_mask = s->elcr_mask;
+    kpic->last_irr = cs->last_irr;
+    kpic->irr = cs->irr;
+    kpic->imr = cs->imr;
+    kpic->isr = cs->isr;
+    kpic->priority_add = cs->priority_add;
+    kpic->irq_base = cs->irq_base;
+    kpic->read_reg_select = cs->read_reg_select;
+    kpic->poll = cs->poll;
+    kpic->special_mask = cs->special_mask;
+    kpic->init_state = cs->init_state;
+    kpic->auto_eoi = cs->auto_eoi;
+    kpic->rotate_on_auto_eoi = cs->rotate_on_auto_eoi;
+    kpic->special_fully_nested_mode = cs->special_fully_nested_mode;
+    kpic->init4 = cs->init4;
+    kpic->elcr = cs->elcr;
+    kpic->elcr_mask = cs->elcr_mask;
 
     ret = kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
     if (ret < 0) {
@@ -105,12 +105,12 @@ static void kvm_pic_put(I8259CommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
 
-    s->elcr = 0;
-    pic_reset_common(s);
+    cs->elcr = 0;
+    pic_reset_common(cs);
 
-    kvm_pic_put(s);
+    kvm_pic_put(cs);
 }
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
@@ -124,11 +124,11 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
-    memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
+    memory_region_init_io(&cs->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
+    memory_region_init_io(&cs->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
 
     kpc->parent_realize(dev, errp);
 }
-- 
2.43.0


