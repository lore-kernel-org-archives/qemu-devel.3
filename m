Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CF606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=VnPOrjFM;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=u6mc3iA4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGke-0007XV-2o; Fri, 23 Oct 2026 11:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkM-0006cV-UM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkI-0002PG-OU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:54 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6XVp3757984
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qMjJ4YXzXqY/6BlctmpHQPTxPPeexlY1jN4e2qmf+
 Ic=; b=VnPOrjFMlb0ATvyghsFVFSmR2pPqa0Wy1evUSbpDEQKXUMK4x8E+N9WN0
 IRbKMiWPEiCbCF97tGoFk47HwjKLBWEsw3+zeN76RqR62rNhMEZmNNdz/v+59Wpo
 /vjvIMWnpwI6gO2qLy2gBtm4M2G+EyYjkObGkxs/Rxz3b9sWID7PqLktjaSxcQUM
 /dZ6e0pJTBGxRp1RK+V/yjpdQ3X2hXKR7hRMOvWv8Rzk7w43rztxhvvZGqgYb6tG
 1ge4nAhGBlNypu2gZMJ1ctGByvLa/52WZru9KGg5aHXb9zCMBEnHsX2z+OSclwQ2
 ewyLSHXEX0OTA5We4bYkH0BIxXerg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022097.outbound.protection.outlook.com [52.101.43.97])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975cyx9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+BKTj5VIlc98syhzgEHz+lgIuC6oHxquI+79kFMjUinkPGJE3RXlrH2ocRxnIRBG3T+V/b3tN4OYpXws1xMP7jajlbB1gcsN4MX1rdTvhiia51gYaDnXu+vfq+u6rGPRqJo7ZiqesOkmuVq0MbdYDyIJIMCRJL9mmFhN97Idu33XmuwM1bLXdLZ7oCdrFCTKwsgr7cS8NuYTjEI0PIDwE8xxhgKs/7Sddf5SS0qTa08PUfpWORZ+nuHRfKOefIoRCKrh8c8aYCSRdA6DR0gsLyQRxpY6iwlOko4aiGUqDQEI56t5juv46Bc3FWejD2adM+4vAGd3GE8GvVb9FBelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMjJ4YXzXqY/6BlctmpHQPTxPPeexlY1jN4e2qmf+Ic=;
 b=Ga7y1R5sRio+XCgtyYn5p8kgayn5KjEPCTT0t5rxiYOCHKmNhkX7gZWEYODax1VnEf7yNUEmMuQ6iSxhzd2cUGkofGwsM7CPKtcB0wkybc3GVzxi27vz4rBtN/aYmrsTbKa+EdjQqVFai8Um4hVepCuEB5OpNYxO2nTWC4rMXWIk94GFJdi8PgdTk7Jt/vkF6Dg04iWe0ii0slQ3r19Addpw/eUGn1JcI92IQUNjVx2jyhMPGMnu6Kj7mzhRiTm6/Z0tiyuToP5BnA5qHWWHOxSNSGgvO9j9w9RtOsvCmFpO6lVNzFT5v2TgkGBQBxVVRvHvYCFNFjh4OgA9ZD396A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMjJ4YXzXqY/6BlctmpHQPTxPPeexlY1jN4e2qmf+Ic=;
 b=u6mc3iA41lW+pnSNI4zskL+C0Fm1UD4UxP5HLopkOqMvjKh5yhKb1+Z7PrlfnP6Su23S+FtHCyJxVs40NJzj7K+pA2OHcAPR2aV5peSB8jwqez8uyqQNdK1e6oqeFgH10BIzqzWOD/jwJF70SUnQR3/XiDwD+g2eenRgSo7HpAZ8HF1OhMoJzUUTBbEWv78/Dmk1I1iAfkkLahicc90uAYBb1C4XD5ey4TNYioc1glRS2Q/+hvniVU8aKR9azNF2N5vQ7im20lrZeAwxzv3WLmVc/u6Z390FmTjLmwKM7k9ZwPc5czIPFRFLCyTRaU5tXjUB7GVWnhXQpu7LEZx+Zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/28] i8259_common.c: convert to use DEFINE_TYPES() macro
Date: Fri, 23 Oct 2026 15:58:21 +0100
Message-ID: <20261023145839.34909-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f00dbb-a100-4c57-9e06-08df31164626
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L8NeRgX/LloQbRAm/7jSaUvEP12IeRKrIHja97n2Xhxp0jZg8CgStFFXyV3DhCWhkVSH67kp66vzwMsVN595IViH2hbDI6OdGqoJCGIbd/aSwiXbRXW//nNRXSJ+caUdM1RdHWe7lPpqNcijwP7KleKJGpsvqWtaeEMH8MPm6vi5oHZnAyNTBFFR0G1ThFjNKuY9MelW76JKSxDgOHjUUUXfqe0kMRMyXpqQkOmdXLEOnoYeqP3rVzCbWLs1YuO1Ocvs3OXIP34qYRAHBELU0EKElipCu4r3mu7jHpR1az5N4X8AJ8Em5AuH2VURHxrKdOp36wqGciZxEDnr1Dj21sFnIaNbihjGmHTXiOk8m/+YGUj+7tHP0ahkJzvs/90PXJReBGng03h1g/Ay9nOvYfqGJMH6HSbnTEs7n4iK924KMal1DTowPTidJ92G1vElNB8MLW2f6eNS5NhBqWQcL/lBpQoWDfnrBrS2Q7eUlH4w2S0DwB+YbTnlJC7nu+xj2V2NQoLWefIrOtpcKb+QWW/VHOfavbACs6EWrzhROTKTVc/N2t3mbWjqJRaSRfEeMkH5+c2yEgvrndoI37Xg3kJ2cAbmRobh2cm59/fWE7hwejf1EE3ZfJa750ak6nXki2DnkjkNSv/tFQgrA8/PLjFsZQzpQluq5tXcGKEa7dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IItoaRD18a9MQqQHOeJOuMG/V0lPD6s9O9+tWcSxUdBn+Wzn+l7Q+gDWYMbl?=
 =?us-ascii?Q?xif4YRBBU9/pdcauB+FRhLw3kxLlf57PEPwLEaplL0YhnQItQYjt/v39xXzX?=
 =?us-ascii?Q?+eRUudoUWfvhSWp8giTy0wiXq/bdVPE84htLNq9pafOYFmBbdw60pEYQcvyy?=
 =?us-ascii?Q?DueIDJM0WkXmAzSePA/9SwoeQb6+EkT+HPVewVws7wvl/Z4D3vwe2VHWEUUt?=
 =?us-ascii?Q?6M2W4Z9BoG6biKhXkDjQP0w+JxhdcmlMOZNNiuoLBQeT11TUvbe3SSISMDuA?=
 =?us-ascii?Q?7E0yYAlzaagnMqS7FXe4DgeJfFV68eP+DzHRzJXZ5zZcT9Vdlc1I+FNd1JyY?=
 =?us-ascii?Q?sb7TvKLJV1c7PtLrt27Pdwibam7iawQaH8ixGaCP2byFMCCWxXttpWfAEHcl?=
 =?us-ascii?Q?4Su9ZaBJ2jwLQWN+kFz+jFVxaV43m3IlVdqeJlJoShlji6ZxA+1PCyBGRKzJ?=
 =?us-ascii?Q?YL9iqMJW7S8Ij9wzUaSzoLmGI23UvV6qFBjnbitqWizzcxl8Myu43k4O7InN?=
 =?us-ascii?Q?Hf953lMQffafYEjb2q7MRvMKNUa7KIEOorEDdgK3PcgVn3y21g7tFgoQHdpC?=
 =?us-ascii?Q?GTQPKx18875DNbikBa0RSFs0RT7WkQX3u5NSjsbtTAsXI1NltpC5SKlBNPAW?=
 =?us-ascii?Q?MT4IThvg16PAraCur/nzJz6NDkcsB6PYPw+LkN95ElF5IPZuORvrBHZsgr7j?=
 =?us-ascii?Q?R5IpuMZKXwDSUiZehCHKNOj0q80YsCxrafeR8wQT9DYIchomXaeZTwppaa1s?=
 =?us-ascii?Q?xGqWVnPQw/WiJ4/LkHQ9OsJ+xtpxRePcJY8xcVFooDS+DhY9Sg+Lud7chbGC?=
 =?us-ascii?Q?D4z5S1m0EiNwkVKykQ4+JN6+aU2KFl2fechq6/W+yyv4O6FEhbkXFofPFHH7?=
 =?us-ascii?Q?tkp7Rig2klvI/26UXMtgH05YuMC+ZNYGG1eLXE9Jz+GKppSUZcWZbbrTKz2m?=
 =?us-ascii?Q?+r5eNIAwKw58HWL4aTkvMyWTh0qAfdveJgPG5SwmKmB0rnjWe7YNJ4KnVzBQ?=
 =?us-ascii?Q?2TttpDCigPLLqcxlB8PsB7i1MNXFygj4rgUn0i76/f+ejXPeIRXbPvvS1dV0?=
 =?us-ascii?Q?b0TnOiYWxw2gtPTs7CaQ8aZAnb/bdgKovknvQxeY0vqnD8cehj8+vt7m95N8?=
 =?us-ascii?Q?hga/VSlW8I0NVCGLScJPHqByL665+WDXFyQ5wFVzZNOLMnzhLvnwsPZNAGOl?=
 =?us-ascii?Q?RXrutMG58MTHqj0MGJITVRph/HKacdJ6mPtyDhsllnjj9hy+QOk3P7Dd0UAf?=
 =?us-ascii?Q?Nd98OZ6V87JfNydZakFqKRyohZIq+kEKxJyc2gJisJ52rZyV0BWkEjacO6a/?=
 =?us-ascii?Q?0QejAAlLsKBIZgN4WZqbRAqHMuA0rUPQbWwKe2KZNyqXsgcFCaHjJSY7+EM3?=
 =?us-ascii?Q?Lx/dutggJJgNK0mNKXN2fXYJ7bFquYAbdqhj2tUcXEdEzbV96N2dqqvMAemI?=
 =?us-ascii?Q?zZIiG6DSbCJw4EOZx7aSrEyNJaA+bdr/eVxPuwOtAbgVqD7itaCLHaOb49Yt?=
 =?us-ascii?Q?DDSMh8pClOKLMfesRiL8QX6d53VMfUQMalQs0CMPGosbgwniQkDe9ChhhUrz?=
 =?us-ascii?Q?Uyr4Upvkyq6v+z2FFN15/gySUmXkmW7U6uuu2+EvAb8Pqw2Xc1a3VT4ZRJEF?=
 =?us-ascii?Q?Dvyzdl4mXd1kDBSmR5PHqhoFYyKX3Rl7DJjCXejJnk9YkRKVXLDb+ZbUUgMy?=
 =?us-ascii?Q?+ISus0x0lx9Zn5cmf+gjJUoe3C/NjF0PmWDXG3+cLvIvQGMnzLJuTB7c3kZ/?=
 =?us-ascii?Q?10d3n1U7DHXRkmsgx/fvQs6AUpfl9W4=3D?=
X-Exchange-RoutingPolicyChecked: Hq/Oe1IkbTKk8txp+YlO+NvyMUsGcsyuleaMshXmSSKkmckfPrcrZiWDhTizAgHVNfmvkFPkxPdJSZ47Fhr4gI2lDsaBHCV46vpICl4upVeMBo7QeSXSUXQPOw4wu0BbwpOmqPXhyzWK05ISnAyXCJu7mM36XPMuog+xiU1Eki+G8POkJy5TWHiLqB1tr8Q9ZUSDQcjTcprqIneOEHjbqCf65Q7xJT73odl3f+dC6ARm9E1hT8LnlELmFwGkGzcqWUQCJSSoUWMDWwVoriVJ6z2uPvvtOdqd/KtdeayohVd5j6Xo1yutBB46h4KIW3eJ89iDpLZxAak3aSE0RUfKYg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f00dbb-a100-4c57-9e06-08df31164626
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:44.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2RgMzl226WJSlOabyfzWxhlyu8hk6kRzhU7SwcUE//Qr5H1JRPVxxIm/3T/N1p7cpXtZ9+IMmSUyOoik7rQh3a9/bxlH343FuLqVqFUI94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7663 cx=c_pps
 a=V6sUqnxsgDMRanywjcdTsw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=bPck6Z4TT5Um9jj7BtEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4gSICMOl7Kd7
 w3+bxkDgFoBtHtxlUBrfqm9ux9clRXo3ZJ9MgvW/S+o9U+KkGG0x0hlCX0DYzY+KNSqXYsgGa7o
 l+zesFtLIT3DLtG3axEa6mSiALXugm53dbYblj95dyYDkc0cAAe7o8/41L2+51OCeCHcAH96Khb
 4ZjWBO6DQnEJC9MMilBDUQbSSboNXnwXDkeU4xP+O3nBgIgS2vOcEv00fk69EdYlCNz3iHoh+n3
 rV+iBIjMuOJM24KzguHArWRbSrSPgyUtJ7b95XWFTHZR09W5wve+McHB8NVRB3nSWYCB1MHVJFt
 HRfbzfSj1q2Kvia9RMr6IXfc1FJbTyPpfapA+N+kSD0uWX8KBvCRT8C8mZMFIKTNtIbLxErzkHv
 PcCJuXrGuOMJXowJtFra/BLYNzEJCiE3bU8mJAlFlXY034DWbAZERN6Jcew1637/W4DnlCc/qzs
 aUv2ObrLSsSoz6BdG3Q==
X-Proofpoint-GUID: yyE-daEb9GJeZZS_nu2lamE_ADqo2YrP
X-Proofpoint-ORIG-GUID: yyE-daEb9GJeZZS_nu2lamE_ADqo2YrP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXzXCx/afK/8YS
 wcpMR4/GHIN4P+3eL81l9SUGs0jYH5WXiQeCzXn4OKq8D3WEh+9rfNBI0D0054VWX036yoSnVX1
 i2jZgDhr1ryXRHb1D2otFxj+EvxgIKE=
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
Message-ID: <20261019120517.1448687-16-mark.caveayland@nutanix.com>
---
 hw/intc/i8259_common.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 31bd663439..09b761321a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -220,22 +220,19 @@ static void i8259_common_class_init(ObjectClass *klass, const void *data)
     ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo i8259_common_type = {
-    .name = TYPE_I8259_COMMON,
-    .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(I8259CommonState),
-    .class_size = sizeof(I8259CommonClass),
-    .class_init = i8259_common_class_init,
-    .abstract = true,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
+static const TypeInfo i8259_common_type_infos[] = {
+    {
+        .name = TYPE_I8259_COMMON,
+        .parent = TYPE_ISA_DEVICE,
+        .instance_size = sizeof(I8259CommonState),
+        .class_size = sizeof(I8259CommonClass),
+        .class_init = i8259_common_class_init,
+        .abstract = true,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
-static void i8259_common_register_types(void)
-{
-    type_register_static(&i8259_common_type);
-}
-
-type_init(i8259_common_register_types)
+DEFINE_TYPES(i8259_common_type_infos)
-- 
2.43.0


