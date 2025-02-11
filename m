Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9DCC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thxmv-0002jE-Gd; Tue, 11 Feb 2025 16:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1thxmq-0002iD-II; Tue, 11 Feb 2025 16:27:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1thxmo-0002HX-NX; Tue, 11 Feb 2025 16:27:20 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLMTs6012927;
 Tue, 11 Feb 2025 21:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=voVBWGs2k/ZVQqENSRmhT8AvSqYp+yVm6LiELDJUP2Y=; b=
 gwrgzw0OLyOIowY2IAq+B+FwwaqXnTPtI1voLZk8aS7m+GM1o64QzHsPnmaIaq/0
 sMXSKzQAG7Z6tVfpusAdXGurIlxts+QElkIrALMB/+iWUtyxkvvw6l0jRZD1ETN1
 7N9HxKk/p/AS/FFVVEwOqBGu58aXtneMHnYKgWn3M45O/Ezdk4nRjTj7RMfhqHp9
 8sKrgtYP90Z9uqVj2pQGWJsPoFj0yIa9zdl1oaP32ws6azJc5NCtOsdZk80tl80b
 gM6WfTGPy7IjvAmcauG6eJ33QinDDQVBppNCyfqhNWeteX2RT+NfWnifQYKMoF9L
 RquIj2Eks5ULyBRkStw6hg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq68m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 21:27:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51BLPlGl009778; Tue, 11 Feb 2025 21:27:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqfp0vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 21:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtcJA7uAivjSHgzBfRfB3hBqL+pCtW1MVmKx8wZ0jhhDbrd/LHDUowABcZ9r2s2JYhptGNnIZS3Z6gpziCcfJlTsx0wrjy4XsY+O+nywopmdHFmySkZvFpVGB9ADU5BBXdZBPBNd7bUtS26GZtcRZFdwXi6Xi0SzM9h4U6uNzdjnf64uUp8aAEXZ7X74a/XPHzZ5HI7E1OyMtElfHv3e7DhNduZYP93kVbCdnt1hVf16wWY8C0r32v2/V5GyYci/YZJVrxY7QlTxdsMIHVbO8TfFSKiz1nByRm8HrjU4NOmqasYmDcxUCjqnzlj9ssUlnMjSMoqbeqq0PsZ+VbH43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voVBWGs2k/ZVQqENSRmhT8AvSqYp+yVm6LiELDJUP2Y=;
 b=pRa8ulFVZLgmNnPfRExaH/olNWQHlu4hbg8bA+bjPTbT/0f1be21wNNMYieT9+WDkdgDo8LYodOrVVYvJsM5SKJ3lcuJnCYnoHmcpnQYrQIsRCmZpfijQw7/hXsMCNx05bQ7+oIA/a/J45/xFYH1UGBPgbKlJHusA18dHZ1wsFp8KMoK8SlJ30DyOLqBGDOI8e7rzHCPgefCwxJikK9U1uYQTRnYDptJ9dn+40d/EhfVOm5PUWMHILaqrtI2dPibklCJNI90xpPt60u+88bQOFROvKNV8IsKvi6YXQFioCPGisLbVzuYmJ2cVXHdwO6XkwNEaw9d2RvnIYJlirwlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voVBWGs2k/ZVQqENSRmhT8AvSqYp+yVm6LiELDJUP2Y=;
 b=o6pu9rW/HsrEqbsz4wDMBWY75A2HvS1zbJ+/4v3reBeOyDEjxoM997+sKSn4y5veiA6z69k7AdmG2JflGjBkjV2zqa2DWYqDsnLSkPJcPALyThZDVKEi5hF2OXOxqlFUlC5auPpfpooyeN+AxW0sd9SzMdIoRsRBtzuCTgVMglg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7538.namprd10.prod.outlook.com (2603:10b6:208:44b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 21:27:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 21:27:14 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: peterx@redhat.com, david@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: william.roche@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, joao.m.martins@oracle.com
Subject: [PATCH v8 2/3] system/physmem: poisoned memory discard on reboot
Date: Tue, 11 Feb 2025 21:27:06 +0000
Message-ID: <20250211212707.302391-3-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211212707.302391-1-william.roche@oracle.com>
References: <20250211212707.302391-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 2320a3e9-1619-4716-be8a-08dd4ae2da25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6JgtMHZase8cWunzc4nYxE97UvFBmmQ8USYSAhtWALuArquSG+0vfyQ3pFVo?=
 =?us-ascii?Q?3YQYh41MpRczc48Uu+Vl/sZY9OXCL4o0LV+FbzsAcQBQHEaXC0s62Kmm9IHY?=
 =?us-ascii?Q?Ja2hDPLBI7A6gK33OUvXkCz2N1yC3mgPXQ/DSQEVUasEDvD4dCU4bp6oPy3i?=
 =?us-ascii?Q?9TDQhtNgYdHLMnWmiS2PsGZL2vzAR/9JKDfDfE02XwaoBLUOTJRwJyFvaOcN?=
 =?us-ascii?Q?4r28FN9QvsBFhKIS3e5wgK2xyfuQCttmpGwzCREtkyM7oE5Y8LOJXZBncPpK?=
 =?us-ascii?Q?2XB/LuTnKatME05A9I5nh1TogBLYl6Ad6RBf+SxjcCtiiBgK47BjTYYpg0JI?=
 =?us-ascii?Q?9TIooALmDs1SxWDS1d/ak+wgIxIbawtF9KwLBzC0mFWb64qMCjlGDv57pPDy?=
 =?us-ascii?Q?uh433HmS4cMVU5D8kTvgejR9Da+kSH3G7eapGFt1xV2J12R9+2kmeCdVbOFe?=
 =?us-ascii?Q?Um/jnHCrAokr+c710SxQaCGRjWM22Q3inbQkQAotbvsfizRLhCbaKaLU6/Jq?=
 =?us-ascii?Q?yOBEBCJST+lPDnxV0EvHE68wRJe/sAyzDOGnlHOzz7IT4RIM1cdor1OqLZ7Z?=
 =?us-ascii?Q?w1awM/9wSdJdL19T0LmEctJUHNpT2djvVF+0cBJRDcqouArJiz0I8TjaAqZT?=
 =?us-ascii?Q?0KkpK57WNfoAiiiytPhmLBm0tp9lkDndIziiXt6ZA3JZiF3Jtp8O0GOwIID4?=
 =?us-ascii?Q?TTA1+qdC4n+GxWAvzas2dedK63/06415TJIXwSz1Zv9IVJRpWOiLqA48sa11?=
 =?us-ascii?Q?YYBHb58APQZ4NqHGXKzrMjPn4/EFRiZ+UQ5UHm9CkGocjOMVq1CpGFr4wx9y?=
 =?us-ascii?Q?xnSL6Ux6zF1eNBxrYkc2kjMPIc4cvwxO18Gk+d6b8bZekyKFs6whBxDEGbs9?=
 =?us-ascii?Q?JFUf/UW/CG3HHmhcNIGz0FS5tz6zjwfpNmamyF2ZhA7x3dih6+rs1FywpnGu?=
 =?us-ascii?Q?GLY7nvlO9q4gRU1NUzMEyxqRsLNHpUeNAczY8zLVzta80HQfr2bC1a7fI8rI?=
 =?us-ascii?Q?q8pY+S+x1FOWuB2Bow8as2pAF7s2ovXMqgfpXrJdWiMT+mtGrPnCkdc/c4aa?=
 =?us-ascii?Q?9QBvLGhcWQoMji+fLIUNFCptxxgsmZSWzzRKaeRMzJEk0FpZrM9cJ9G4y1lI?=
 =?us-ascii?Q?WFuYZv6OsScfEas17hSuQ56T4Ho2rUY0ILOJB1p7OeSygZrE1RIdgtDJ9Mbc?=
 =?us-ascii?Q?TOSbA+toFx118zO8VR7ptBxh92Y9iPLBFVpbLTL03MPulJH6Suc556A1nbaD?=
 =?us-ascii?Q?goB45DlN+F0a8CGXqFzy8dg3hLIAFDGZPKvwlLbc9VIhIEdBrisRXzgKUtug?=
 =?us-ascii?Q?JXdAtpB1cWQ5GmdjPa9YrdmHUpHcBeIsOxtQIGFJOKlIghg5Rj8FKy1VZfNR?=
 =?us-ascii?Q?MKPbYZDW28oJNmfQA5/dyMFyxFo3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cl/I+t/noiQtnXcFnf+ejNB4yMJz22acZXEv2OX18lvp5mE7wpUrn8V871ZV?=
 =?us-ascii?Q?IhZL5zh2OnuouWprkTlrX23kKZrT6rxLyxf298UMWjDjfEN9mz62gGSlJeZ8?=
 =?us-ascii?Q?CHKJofInLADtE2HV9XTb493SqYFnBQ6+sKYDtdmtegeeixRRR/O+WJQqrZ0q?=
 =?us-ascii?Q?Hx08QHzkXNnrzADkPh6dnFl8+Cg5JhBLSbjKfoaxHHGUT7vU2JIQBVFD2WjN?=
 =?us-ascii?Q?0F8K3Jf/hwP+1Tsc2hoYCwu9TcIF99/lm3jxnAlCCnGRhczwRNGWPVJCQ6h3?=
 =?us-ascii?Q?1va6PTyucGPHqW+vP5oCHjunmIbRKXtEUfhVWAatsujWnU7cfR9y87HOR46Z?=
 =?us-ascii?Q?L04HddzCJkQXo309kz+/byuuuYjZLw1LKIZPbkHeSHJ8FybwLxpe7siTmS2i?=
 =?us-ascii?Q?89lHFR81eAJQiys5FCrmllKQssl9HKet1xwq9GtJjG232npcUr/lNOwoZidM?=
 =?us-ascii?Q?UbZOH9W882wAoLiw2P3sJB/8J7r06kHJyUEMIxCC3JtRo7CyJUPw4KhNOP/P?=
 =?us-ascii?Q?Fi/qyFa1J95C6MCOBuSuhOgwl971rBid9nrQ9a7ivrbSEuTxuzcxL8dFMfd8?=
 =?us-ascii?Q?7+QPTmXVgyOKHhoxTXjWG/pCDhV1Cu31d0btWIV1caYAbj2y98R75J9MMYs2?=
 =?us-ascii?Q?mpdogaNUrvV1yPVlVq5n7hskEcHbLFIZUU7MZZbXqGPTvJCGDWsDo6cReDbL?=
 =?us-ascii?Q?Zd9OCDaCAEEO/VXeJQEryuxn3pO/bBtr2SrOrGNspDMu8B96mgqWXd3dadds?=
 =?us-ascii?Q?UbMxmYE/SF8oEIt0QcdrNKOUZzqlvcup1ojM2bx7julVbITMgNjVN772fyzX?=
 =?us-ascii?Q?W8ySTrN/MKEeXCsw9KITG/nhTQsgG4S7Lhivp2qRf04hIwy6/i2h0hMRHfd6?=
 =?us-ascii?Q?eB/NgCO8LR0kntIwdihCwAjajyfju8/qrVQ91BvHizhDgZzyNy86XonuDKhR?=
 =?us-ascii?Q?FkMCOGAJHmRsP0Sn7ZxrMYUAXjpth6zAl2eRFp2nsdJTmo+45Pzp8TfZXKRK?=
 =?us-ascii?Q?AtmGoW9UZWFEsUTY0SpDf/041AEXw3GonTPPMp70ihtM0fSjiISP1g3O6OQr?=
 =?us-ascii?Q?wlbNR+zFqWa3SqYh3fEkjRneWiIAO0VaVPTj7FQRkPP8FL1GhWvw6mCn2cMZ?=
 =?us-ascii?Q?Yz3Lyobv6NGKaZg8oknu0LRhm7M2OCzHb3cTIm7j9k23HfzuSl0rkZ40sh6u?=
 =?us-ascii?Q?zWYAte4wZumWpCBc6uAD6KizXFUiCEifr7JvpqlkF3BL2tvPmiO1sYVkj5VU?=
 =?us-ascii?Q?iQly5Q+xYtuuVTxSZcLPlg0eMj+OP2O7dWmOI9GnjeNrJTyOjoPrJNKIW054?=
 =?us-ascii?Q?7+lA8d2EAtcBFCkmpH2lyN4sux4gFM6uyMcpQ6eHoJiyfz04D0argLFViizC?=
 =?us-ascii?Q?GJ548rN/xEYpJSgEIjHmsTlJW/Tg5LhHPMEzWaBNNRdYf7wqtOMeS1c8httm?=
 =?us-ascii?Q?doi/5tYPNhKcMUUrquI5eWDeB4kLYhDhdDfkBaAN/85HDLN1XWEOvAu7Qo/g?=
 =?us-ascii?Q?KgXvf9l88pbt3YCpSuCbdBYmc3tJ1ricwi5mOxY7VEpQ5NNh5RS8uF5ERGE4?=
 =?us-ascii?Q?UVFcl7+nB2BXRS80u2eGIkhgL2hw93KJ/iEC/Yfjsl3cETACO/yHoLpj/FWO?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JAMocwUsDuU2QWZYw/rNW9I8qjIOBdf7yW8/Gy8ocLng9Iz/SWzFGhjyUaVHMVsZTvDTIoNe5IDekly5Q7V41pDmWQYTM6EJl57jKqV3weZ9E0ywTFbVmqYF1SUwj6am3KD/MV08yg5HK7Ew4rn8FvZnlOvYHphxbIMGRpF+m1Smra5KPZNpDOxUXo/RURF+J4MfLVRhtdo4YgWkhyAHnqcVQDlquNMRzYdiv63Mmp3lqJ5VqUFbRurl6wTEHehmPA8TN0AZIAEr9ZYDqP4t/z9BaM7+ac3G7vJeky/DUli0kAQehqzrAIsY6we2cwHun0Cp9XQk2zXu37H2aAWndoOoCNV7wvIXy57S+cezcK9u/vCSyIrYVUJzU7SS8S/pHqelEAjxMrO3gO092VBz9MPdp3Ns2YGWK+cFqMZxFNGfOfzipVNhElgOxZReNtLwwl2qFUU1uFWVY6abbJM+G4/UQqafx2svs059sd2e07yROxgn8sxm8xl3a2YAq8URwkIWyb40Dqq/US+fcHRd1Sifh9Tf651vy1GfS0gg7ZbXaK+VJAn40330/Z8d9pUeU77vuZ09D+KEmJx5s4Fg0NvTAVOQ5d9DllM4VAwEOSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2320a3e9-1619-4716-be8a-08dd4ae2da25
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 21:27:14.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoiZHxFiLaoMqtqO2sr8CwKMEBg+L5pLvCWY7lsJ1+yKiKaIswM8MzSuYv3j9Pmhq8wZ007S/IirTXM0QvT1VuXy1wPZDakZ30Ir+wvT4Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110141
X-Proofpoint-ORIG-GUID: kEXGXLHweWhKqafhsQOws0bCGM1gEC7v
X-Proofpoint-GUID: kEXGXLHweWhKqafhsQOws0bCGM1gEC7v
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Repair poisoned memory location(s), calling ram_block_discard_range():
punching a hole in the backend file when necessary and regenerating
a usable memory.
If the kernel doesn't support the madvise calls used by this function
and we are dealing with anonymous memory, fall back to remapping the
location(s).

Signed-off-by: William Roche <william.roche@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 57 ++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index a5d848b350..5d97a5fe11 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2275,6 +2275,23 @@ void qemu_ram_free(RAMBlock *block)
 }
 
 #ifndef _WIN32
+/* Simply remap the given VM memory location from start to start+length */
+static int qemu_ram_remap_mmap(RAMBlock *block, uint64_t start, size_t length)
+{
+    int flags, prot;
+    void *area;
+    void *host_startaddr = block->host + start;
+
+    assert(block->fd < 0);
+    flags = MAP_FIXED | MAP_ANONYMOUS;
+    flags |= block->flags & RAM_SHARED ? MAP_SHARED : MAP_PRIVATE;
+    flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
+    prot = PROT_READ;
+    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
+    area = mmap(host_startaddr, length, prot, flags, -1, 0);
+    return area != host_startaddr ? -errno : 0;
+}
+
 /*
  * qemu_ram_remap - remap a single RAM page
  *
@@ -2292,9 +2309,7 @@ void qemu_ram_remap(ram_addr_t addr)
 {
     RAMBlock *block;
     uint64_t offset;
-    int flags;
-    void *area, *vaddr;
-    int prot;
+    void *vaddr;
     size_t page_size;
 
     RAMBLOCK_FOREACH(block) {
@@ -2310,24 +2325,24 @@ void qemu_ram_remap(ram_addr_t addr)
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
-                    area = mmap(vaddr, page_size, prot, flags, block->fd,
-                                offset + block->fd_offset);
-                } else {
-                    flags |= MAP_ANONYMOUS;
-                    area = mmap(vaddr, page_size, prot, flags, -1, 0);
-                }
-                if (area != vaddr) {
-                    error_report("Could not remap RAM %s:%" PRIx64 "+%" PRIx64
-                                 " +%zx", block->idstr, offset,
-                                 block->fd_offset, page_size);
-                    exit(1);
+                if (ram_block_discard_range(block, offset, page_size) != 0) {
+                    /*
+                     * Fall back to using mmap() only for anonymous mapping,
+                     * as if a backing file is associated we may not be able
+                     * to recover the memory in all cases.
+                     * So don't take the risk of using only mmap and fail now.
+                     */
+                    if (block->fd >= 0) {
+                        error_report("Could not remap RAM %s:%" PRIx64 "+%"
+                                     PRIx64 " +%zx", block->idstr, offset,
+                                     block->fd_offset, page_size);
+                        exit(1);
+                    }
+                    if (qemu_ram_remap_mmap(block, offset, page_size) != 0) {
+                        error_report("Could not remap RAM %s:%" PRIx64 " +%zx",
+                                     block->idstr, offset, page_size);
+                        exit(1);
+                    }
                 }
                 memory_try_enable_merging(vaddr, page_size);
                 qemu_ram_setup_dump(vaddr, page_size);
-- 
2.43.5


