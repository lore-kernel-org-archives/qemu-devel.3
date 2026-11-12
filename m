Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76F606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=gKR00pno;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=rTAwWYUc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRPk-0001MV-04; Thu, 12 Nov 2026 04:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRRPi-0001M2-7s
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:48:14 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRRPg-0002sj-Bh
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:48:13 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2Zdbf1971504; Thu, 12 Nov 2026 01:48:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=QDPkdi8arBnwo
 KblB2Ix0PTtqmsqvAdAIehGDAzV0hc=; b=gKR00pnoEqvQ6ms9t1kTWISwxW24C
 A8WB98LnnuNNBEGhHE/D7i7H1WcDzc+I6St0x6xQKO7YwClzcNdbVdecQ68Zeyl6
 39jOmqd4uEtwFtQcg+GgxWVuJ2CZ6AKyM8FcmswPaaVHNzai4KWE3rnWfYwlyJoE
 1T4+38EDgzB8Y1kJJJFFh2YSLVMWh0N4ZxQAP8/zQ5tulnMoWGtZDcjo7YBEmGPf
 K8Dk4JMgOc7OZN+oLSOM2alQDBFe3xLcQZgBsVbi6xvNBjoMj2FmP99wF3BOrUdv
 8AlhzzY6f5i11AIvPKiggNKzH7EZCx9jI+9PM5P/7vbmnyczhmPsggkMg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020107.outbound.protection.outlook.com [52.101.85.107])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hvqdetjch-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 01:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjLqA5pK7yGopDM67WDcpBAIil05+LrdhlNrTthv+YXzkQNjvpXCmMGLQdifMfNRqV2idO1VeGD0ie/SoCbW37AfgNElLaxU8GAkah2724m3YnpGtjLP/FTOW0zvWQTg/dr5wPPFcRpfyW5oNqO8ZHFu7JCpjyzM3HbQVI+xW8DITH905dGpHkcLfE5z4XsnwgcThwdVuw+M/rUwbb1nZMSGzgTJ+e/lRB+JL43WdHMXBOtakWsh9khXY1aBjqmFbzf99iPj6gAx2nUpshJZemnw95b0JMm2kMvFVOIwDVV4QXJDczEmL0T8n1L61nrgI2gkbzphgz8KV1IGhNTcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDPkdi8arBnwoKblB2Ix0PTtqmsqvAdAIehGDAzV0hc=;
 b=AzsFUdbPPxP9xSItwdGwrYrpkTmqUIKLFHSwbbBzdY4upmzn1uMZEggHoitW/1aO6NVTdKxM1KlUb7J9XtEyYF0idgXivCEDH2pzAOG0UjWYIrWD+jem+0bcJ2QPHH876f6/A8E99G6s8PLwTJ8+OSiuYuTCAWyfo72VwjsxM+6snzYeqXD49q4lplsfzYKvFof62njUM4UiNiUjxRmci3IXY+NRrM9eU/TD2unDtkFf5ckE2Pwa7q7/uINoiCeQqBxPCVmRYfhL42n99ZqAwCEmaLZj00fc1CMP4v9klNDHS5y7t45ZfPuukQa11gJooWf8vx4dDnY0XvCU6SY+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDPkdi8arBnwoKblB2Ix0PTtqmsqvAdAIehGDAzV0hc=;
 b=rTAwWYUcfOaTIESNRenVXpbcrNa25cooOCXx/oIrTMcqoGB7FgHX6+5KIQJgE/FGwWl8/oSs8BeVAZtU/WOGyv05oeyh0yJhVxfJ1yLYCfbZTsym93ycTsJ+FMrEm2I74SlY+cJUK7z8v3S/5nRvdo6Pam98QEOvffd13Mja6P1WVElemIbwnDLyj03nnrIMeCTpUP69KUntUsA7BUD8eKiZQMyyyxuSY2ZFDMfyqtgKyGtKZTXSqqRiFr33/EtL3cNSxaMKjgaW45930H+1A5xZdZxocdIMfDjP9QWYoGl2EWQ7sxX5FTnUzDawRSlApMPsGX3yovq16p5XZQRV8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6811.namprd02.prod.outlook.com (2603:10b6:5:21a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 09:48:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 09:48:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: alex@shazbot.org, clg@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] vfio: fix memory leaks during realize failures
Date: Thu, 12 Nov 2026 09:46:52 +0000
Message-ID: <20261112094802.2904005-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: d86d8f13-1719-4eeb-40a1-08df40a20d4d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: HKS7/8LJNulT4IWDrMenhw/xQz36tU5ZkmAvUeeTXZKTsFLNGrSqnOLYeXhAljRTRzDxZ2M1IxRfXaeOzYMj8SLoOaCccyiKPTyQKyHuqznT+DVaSsgCxCwec/Z+/OBt9iXtsiA+BFk/MdX7QV9Pi5oxBoBh0iB4mSj3wWjh9EIw1KwATG+5dx7B754Fmz3rBeW1bLG8p+QD+o1f5oIQgsC/oVPycYRI0kFVCNTIQvRx9WwJ/I/CkZfThigMhJAZE8P+7D3l/sKEJUwpDLvRI7fHuKSwWYWe8oJxUVoT5xRd+OXLUXY8nKhq+xphhHm7EMzV8rpoROWpUd+uYmWIm9oNUeUlkZtrWUmVT4ksbV0qkg2C5pb+9Gm1P+5yhCMiY0cxaU0osdTrxMR9j/w3q8wcpbBXQzEW5gKD72odVaicWpZG2XkkQIqYiKSJ9SwmnXYuFvBOUzjs4587gq7ufNSATQ/grn7OeiOE5tqXgb8SSBzZSZiYHnNBtJM9/ZiTzVJZX7BA2iM1Uy4BA1FR/ufBDyCvlLcEOPa6z7QPwsJ+B66uFcY7uTPzLZP2XxBl/EuS/o/FBwx4hpyY+LZgewks3UcZN4TjM/aaxNN+NmG4AsQTdSHBeJ0b+YYzbUx67bLe5kwwKsI6YfQjyddpg0ZB3J07vvezzb9MjhBlscY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KU4L7Hva9vDeZzK+r0xMkkPnrdITSUyzyUEjpyZRq1L6K/hZtcUxfOkNsHYe?=
 =?us-ascii?Q?ZHbb2dZCjN5TjCio+gVrY7yL2uqBkFpS6S6qj90KreKzW1hBeX0V+c8ghArG?=
 =?us-ascii?Q?4Uovux+gpesWq58XgVBQhPOOdRFByvwNlMnH2W9HPBSsdHwzlJ3LvTjAmxD9?=
 =?us-ascii?Q?WUCZ8Hedsitkl01JHvhYbt5cnQ70/5xY0IIhi1tcND+K+TkN2kePjzHrQjGY?=
 =?us-ascii?Q?U3OmS7MSI8DrCf1B4kMyZTIAkgRyspmazf0c7KX7+rxSgQsE7fW++6TN4ex6?=
 =?us-ascii?Q?F0OHPn9p8pAdC/lseCvxmSvow/OmcBeRQOjKoqKnoteGWFAGgXofhE5UvizJ?=
 =?us-ascii?Q?6tQxjEUWuXXtAUMR0gUsB3a14yOV0iDvVwjj2aNk7PrGx2Bza3ybpIjbQC2N?=
 =?us-ascii?Q?9vO9Nb0V45iHlJNc74WUKt/+Mzro57/vsrkHsgWKi7f4DCQyxtsVTw1MKqvR?=
 =?us-ascii?Q?Es0bwlmAYb7NcVcHIzyxSC05Yv18+xyXVARYdDYVvdBSW64wwjZ9GGLDKFau?=
 =?us-ascii?Q?VTO80wFVNJbyFcDlr6ZqL1KmDYqIg55VgVOlpc45687e2H8k9ZaunGDQKNtL?=
 =?us-ascii?Q?PmcUrnSW21S9liNznmcd0kix5Y4MICrpt28nLIEPQ/NOttjRkQyGEU5HLk7U?=
 =?us-ascii?Q?VmpHqQ+sVYKUmRRu0bc+63tXZLHevlZpdjiNuSQWFIpMmq7SUMdaduaAa0UT?=
 =?us-ascii?Q?U3aqLenHx5rqf3IVD8/SJzn4rMCpUf0wTbCLEjndHBWpKANTPie2T/e9pmcS?=
 =?us-ascii?Q?vdKBLyzN016UjS+rabEWj4z6Pq9KpprobK587VkknXDz32bND6RvFvEG1aKJ?=
 =?us-ascii?Q?64sriBBdL2tMDlVP8vkuXQS62CMrwfdM3p6M4sOxziMccHAweu0duR3DCd40?=
 =?us-ascii?Q?FxLV6hdWMCw2aiAdcFYCdItgCOg17v5zaCGis7tx9Uugtr7OvePXMPuU7VQa?=
 =?us-ascii?Q?r/T51a4HRBG5mu5TSgQnHScTt1BM1XvFcl05mNTH3YRbVU/P3AfVwUp2rLz2?=
 =?us-ascii?Q?Pu3jsv2F/Av4ElbiI/q3uZFFliSMAZKJHWe1NndKIx61rGXfz1weFj27erl9?=
 =?us-ascii?Q?zkwQqc/bSDqpA9F86LTRO82Fz7wCvMai/vXrHfdreC0rTFg+Kx8IXb5q9pBq?=
 =?us-ascii?Q?X6J+ZTfFEZNGqrmR3312OujK9dOP3z1niYyqWZrrDrpO7g0OMl6suOgGzmLT?=
 =?us-ascii?Q?Oy1uA+x3KIOS/36xeFbBTO3hEK6EmTnSki9JIbizrdUrdZFuH31xduxy7p+m?=
 =?us-ascii?Q?oEXyiuc9t3q5TL924NJeZpmGZbhUJZEAonSTbTKLFh8qglQZNwxR6C4oRGWM?=
 =?us-ascii?Q?zi8oN81HB+LZrZ/d24mtaBICEC99xU+TL9YyegDT3JfavaWLNC33m2bxIDdb?=
 =?us-ascii?Q?xLDB2n0xBrxwlJI6j7YnRC4YsRMLLGUQECvCQfMC6HPWMznwOHZG3bwwRGH5?=
 =?us-ascii?Q?0jZetNI7ozgLQtSnChidCMyTE2Wuq2luLAkaV+hP9A00ys5hoGnsO+vVpIUj?=
 =?us-ascii?Q?Q8Jx0s7GHF6AIM9TH/M8/vHa020H2XtwNgOZ1Qck/2A4g/SUUG2yd7Lwn8CG?=
 =?us-ascii?Q?mToDSJV4gM80LRqO7JQBk0BcJ4qkK/6lc03iUkjU4EB+eGI0ibkD1p65jx1J?=
 =?us-ascii?Q?+xCTgIn73cKnan8bSBLx9YdjH4J+ga5+YTIFOKEKSy6YQqZLHfPZ0Ipj8yl5?=
 =?us-ascii?Q?DME21Ev1YaHRNPI5Gdi2gI4LYES7mKrASR/U1ZieLbZsY6KTgYb5e5WRCe/s?=
 =?us-ascii?Q?DS4xLYn8EmAmObZy/9QqKO6ipB5wAC0=3D?=
X-Exchange-RoutingPolicyChecked: YPhlZZFGnzLZ/DOzEibrE1VZGLV8n5JjhWjrqQ3vKHBBhBa1X0Y7/O1dFwK941mVv8ymrIgYEPH8gHtsSWhTTqJmfeOjAqAsuXGu3zprHXRQJ4aGsj/FTT8nBEZ8Gfia4XJvI1U0E+jELSqzg1VuR4/Lpeb4U1ecp81TsdAsJyNAD6wBSNRuTH2ueaty8hrpV6UbFjYinuUvVIPJt5pp2YtSTY3L58dMe7EQdD9NFpZs8sIyLSZw50rKBwTblJGuk7HbFOQpw9c7vgvj1iKPBjcW/Kz/Zh9YlQkjTCEtSBVCDYxm9sMSk1wdJEjGP5dXoBjNJCAU1EON/9FJsMxPmQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d8f13-1719-4eeb-40a1-08df40a20d4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:48:06.3244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIV/NNmZOIa3XK6IW526wgCdI26Fkcmt3PcuWSzF2/o0to18JOw4Qjmf2Y0eQWLpzXns9NeRVwx92UwXYGPrUazV26BQrqLgLnYgRqXjGaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6811
X-Proofpoint-GUID: Dlx6e_OqV174v2eDtvHyOYNFj0AUyRfZ
X-Proofpoint-ORIG-GUID: Dlx6e_OqV174v2eDtvHyOYNFj0AUyRfZ
X-Authority-Analysis: v=2.4 cv=efmo7LEH c=1 sm=1 tr=0 ts=6af58b59 cx=c_pps
 a=YibUBhyYyO2Pp3CK5Oblqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=Kx0d66m_L8w6UN1NMeQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXxKBRDPSCJry7
 NiL1AOHQGkK9x/UrjubQ+Cu9IUV6clVTi+k+a2GYEfztp0zIqPeApcmXRf+jYTUgcyrhkPoi7zN
 4qzMJ15JuJtZddjzwE1ShNNKDg5xBlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXy+8dpqK+ltsC
 gE//+ysFap5QIce+YHXAbyqNZ69irPKnBUudc1Xq66NBWEW10qf8T6jXrlzssR/wIA9qMNGp5Sy
 OxapCkvqZf+e2lxvZOHnC8KfJDDqzUDwB1dZKGniGfkXRYK2iMFU5wJLrYl/SzRXjtkHGH+3rVU
 xh8uhDAkVUDvoTcI+K6DmT3FfhqNGRCvQyMtCrabOp0ybe4sbaC2rmdF73MdgxkrdrJjNZlulVb
 LEWxhwYmYi5QNHmASrX6prznhuGbmp+uUgjRAmLCaytza44h6Wdqe5r2+AsxCwXvfUnhguwGAKP
 If9SeXKJttSDQeSO9Oq6W79RPOUBzgkQps3r9uHQd1C6gX7voZwmZCiwZ1mw9KMURSXQ1repqgt
 jkv64T6KNP1/khGLspDATvw1vo8rDC6CeP2FjFPwFk9ZHHJ91uahEZaqEJOR6wMBbDTx73XC+/J
 a4JM6C8BznHhDlsecIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Both VFIOBAR and VFIORegion allocate a new MemoryRegion for use with the owner
being the vfio-pci device itself. In the normal case where the vfio-pci device
is finalized, the refcount on these MemoryRegions is decremented as normal
causing them to be removed.

Unfortunately this doesn't work if the vfio-pci device realize() function
itself fails: in this case the vfio-pci device is never finalized leaving
these MemoryRegions still allocated when the QEMU process terminates.

Ensure that these MemoryRegions are always removed by manually unparenting
them in the corresponding vfio_bars_finalize() and vfio_region_finalize()
functions.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c    | 1 +
 hw/vfio/region.c | 1 +
 2 files changed, 2 insertions(+)

[MCA: I found this whilst making changes to vfio-user that tested failure
 paths in vfio_user_pci_realize(). In this case there were a number of
 leaked MemoryRegions appearing in the output of a '--cc=clang
 --cxx=clang++ --enable-ubsan --enable-asan' build.] 

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0da2e143b8..05cce1e252 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2062,6 +2062,7 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
         vfio_region_finalize(&bar->region);
         if (bar->mr) {
             assert(bar->size);
+            object_unparent(OBJECT(bar->mr));
             g_free(bar->mr);
             bar->mr = NULL;
         }
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 8de26f3d9b..15c8850072 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -523,6 +523,7 @@ void vfio_region_finalize(VFIORegion *region)
         }
     }
 
+    object_unparent(OBJECT(region->mem));
     g_free(region->mem);
     g_free(region->mmaps);
 
-- 
2.43.0


