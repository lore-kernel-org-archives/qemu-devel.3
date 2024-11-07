Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC35D35E5D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zeO-0008Ta-A5; Thu, 07 Nov 2024 05:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t8zeG-0008O7-Pl; Thu, 07 Nov 2024 05:21:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t8zeD-0001zQ-0Y; Thu, 07 Nov 2024 05:21:56 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71faqS021962;
 Thu, 7 Nov 2024 10:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tMm7sfsa5tMZm+9vPsMqJy+JU6H3ZOklscSFRUBodPg=; b=
 Xh//7UEmu0ak9LE34UCKZmNBk6K3icnpsFDj0Q9MzaGRQH89s9c6yrP2Ihq9DGeQ
 GdS5gKV4vrH3yojWZk4R4lU59vRScSo+pwqAX5t3gxPKWUkI+1TM4cPydwZ2s6tQ
 4TDLxwqQ2AkWScU1KnIImA4sSpVe1YIdsVqQvLoKhEJcn12Xusf4IwbH0DxZKDR3
 TdQrZIsmAuBTJcFMefJGQSKXOJMNYWOOpWKNZI6jIgXZPCiUHh1wMCSTNuZxNjh7
 9yipXr6CM4uC2oOiuKHn4HGgXIb3b8G8tsMEWaY4okJuhXmNes4RhD/UvzWBuljX
 Di5uzZk7bkO+dFWbIT7LJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpst3ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 10:21:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A79LanJ010012; Thu, 7 Nov 2024 10:21:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahg53bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 10:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUMu30hc4zkbfwDkv48C3f63Y2W+W7Jqp4gTelWx4wgL9uc1esK2PFuMIaDIMnftMSjb5Yw8fQ2ondv1jF9/Up7OKZSvfSbRyDCASjRLkBR4oW3Z1UknY7DmXVO/2ocaSqyLJBH4RC5gIaaEKzwioIe/iLxan7oPP82Wn00YxkoOofpgdzYdSgi2dDg/aXV0tLzSVzu17uc4E/Z5U+63zHa6e28j7iFHi3I2kgnkXoBWJLKSp7gOSaObXSkfY+471rhvZrAlrKazn5c0OS748CXpvbmcu7IM6/9nmbl+tU0cyO53WPolh6yvY9TwisV0PsYRAEtqQZsgTJgCYjSAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMm7sfsa5tMZm+9vPsMqJy+JU6H3ZOklscSFRUBodPg=;
 b=EMaNK/Ktbk6mkb5V+59pa6PVS0OMZIe50QR82ylyfjU1MpwboA9/QfPUAv5u3XOsMqKTVJKM8OWPI+XZNAzK3pwRd5RdjRGpkm+vyfxRed9DyLQzL0KbRB63sFsLfD7eEZpX97y72BkeEkc1DJcFbiN3ziRT19B+Q/RDOrWD+SIVJk3iGOKeU3iFx9FVyDtpzoKg1Qm6rk/hJD9tR/HpHiZVAtkA3UKS0SR48r73bUEAbuid1s/mFBI18TQH5O+Gn+3FtwMLYrnGr+kaPvZOp7bKmEtAZErsXHeAmFcIePHqPkp+tDGPdWfBNuNOx1ip36Rr7Aq41a4Mj3j9GmQScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMm7sfsa5tMZm+9vPsMqJy+JU6H3ZOklscSFRUBodPg=;
 b=LRw1ud7R6gA1PQiE7QcloQXZpCmUB833d6mYj4A20tp1W+3fw6V71ZBkTVVALrVv4Ia/R58+3VpsNL9dRGn1a4yf0nv52gmfHGHJ6pWUFc62heeJFoBNNRglmRatFyTAOK8F2dX1QJLJccQtEwOWqjzpX8QbhkFZgoC/GZ+CR8c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:21:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:21:40 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v2 5/7] hostmem: Factor out applying settings
Date: Thu,  7 Nov 2024 10:21:24 +0000
Message-ID: <20241107102126.2183152-6-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107102126.2183152-1-william.roche@oracle.com>
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM6PR10MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a8ee8e-3aa5-4709-182a-08dcff15f7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1YoTOZaMPiJTppOAp4N/eNGYblZTfCMrOWtaAV9WpJVrtsWfGYIRZa1D75hh?=
 =?us-ascii?Q?xfvulWPYzvJ+ZmdS28kqpr1NhfNuxVVGqLQp3pBCx4viW32K4biUsVSXclSv?=
 =?us-ascii?Q?dlVdx1DMS0cpFd2LfrxZPFmbvR2smd1JzyuDs7Ujg+cDXzuUfxqvT/Zn/qbO?=
 =?us-ascii?Q?6gpKwicEp/pco4LubEHz9MYzt6+wYLv/ZySoUKMSZeUfIDLBvGYrhyf+D+I4?=
 =?us-ascii?Q?cpBgoAYA7eV2NkTElh38yCaB5bgy5vTEdYkBcQzd3Jy4rt9ok1uW2oe6PQzA?=
 =?us-ascii?Q?wrxBCC2YJwJSt40B8O+iq6iBRF3fUIyLHshFfQqwLGIyVFUyK4p1eoI20+9q?=
 =?us-ascii?Q?7xH1e6uLaRDcFnq9mYxkaI9BoNptEXkP341/4fCqo9DfSgNYEttvF4mKgfZt?=
 =?us-ascii?Q?eAZcfYgfc0OAjAtQgIOD5qjD7c5EqZSLKU/erihG0QupKOndU9bLrrRNSZZP?=
 =?us-ascii?Q?0sAQJEu6zrMpT7TC+i3+eExgspzQBdpCPSP2msS/tnNPOnjExmLNt+N9Wv4P?=
 =?us-ascii?Q?Rm70Ixz24OVeM8f69S4C0NN9z4Dc+j4TKZqzLseAPmnS7oixacOZ0b2TysBz?=
 =?us-ascii?Q?UzPEPiMfJWRVYMsg8PlXYm3yYf80FQNY0BumTEg1uOuC+7WnduwoGAknaX6L?=
 =?us-ascii?Q?f3n02D/gPZz8leSbNniX/Zm0F7Z7ZgEM8erNvMzHOgZK27JS/aoQ/D0hkc9Y?=
 =?us-ascii?Q?tZ3pnv3TOAQnxiCECQo2WExVvrNAnYs8SbXVRolSfQpDjbOHbMWx7uuLUgZ6?=
 =?us-ascii?Q?Gmpirk4WWSiB9zX2VUUz7BOsq87k+KPrV3xJqllG6YFesWM+huhPLaXMRpPO?=
 =?us-ascii?Q?TRXVNt4AxlhXriBrakuCrniYMfmm06Zp9Pswwc33hBeFHchR/xqnv12QiSEh?=
 =?us-ascii?Q?G+acfrqTMya7USOr+5wZK4aHJynYGJP8x8+d2TTNkcTJsx8EpUjf1IUISNEi?=
 =?us-ascii?Q?ZVK1CUW9LDn61KehuHFtLfgQZbk7CAQf93Yn2Ike4hmi6iIxHrxrm1NlI7aO?=
 =?us-ascii?Q?CKL76wZYdArExfxKFtVNsLFpHKDiXcHJi9s03Nj28lEpdnCCMyfHG1kZKufS?=
 =?us-ascii?Q?ih99tVj9lBn+7dpnmlZ2ReUKn2LNCgpX6UCqk1ScK1qepsslxEfOuk6gnAJH?=
 =?us-ascii?Q?fx1Ojt6cDyH8dFM7ifyGYZ/Y1UgOkPqO8n/XzRpL/Hg/W48VcERA6aBmtVzw?=
 =?us-ascii?Q?NafzOIXiv4oqm1gGpHXeFgFmGN0kNNaFdlhGJmeCb3LrZpECaRGBrEeip8M0?=
 =?us-ascii?Q?RXh3dG0ScQHTjy//C41iec63p62hUD7fOkPF6Gd+ASu76MwbRtv30TSIKeC7?=
 =?us-ascii?Q?nCU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sz9XJxwly131rmz5Z8I5ebLFwth8wrDZS6JKNcAiBXeDcp2M3jvz6ajZJ8Mk?=
 =?us-ascii?Q?W7S5US9sRksOLb02o5fO9crgMTIpzyZHuTfKKcpfZ4yOu4XhMMupC5pMSpPb?=
 =?us-ascii?Q?8NAo0NVdHGCzoPKKBVjM9nPafiulZ4R6/gsHtCSm33+pa3yXeF2MVMm047Oa?=
 =?us-ascii?Q?a6D6BpBS8RBZa/V7ssIcApHTryci2jVhdaIM26KnbsOnZplA3egzAG6tbaz/?=
 =?us-ascii?Q?Gz7o9WxtHPNuohqqz1Dn9hPel89h83faeiVzMAvkkbHjUrOi5aQzu4syzRfQ?=
 =?us-ascii?Q?QwG8QZF+G8U8gQOOVUT/B7BN5WW4S1dTGiZ3IPHhE5Vur+cFTcU7j9/qVNEE?=
 =?us-ascii?Q?U7COOa1wxbnwywKT0YQNql/tQBTOAB7ITGjO3e3kOUn98gqAcQ1FafMXjRb6?=
 =?us-ascii?Q?W5zzZufnv1tKE+raEL+bb8VJVW+879vZVEgYciyn25LJjNKPmoqfhdC0erA8?=
 =?us-ascii?Q?iA8ELwK/i00p1OH4wnJ/qV8yssgTNAsJ79zhU6Z8MdTdQF7oNHPjmM5/KJty?=
 =?us-ascii?Q?v5iojZncv9BNEUwLQz2XOzymDe++KGgIn/FsVDY6ahDT6gefYxQbb2Up0dS/?=
 =?us-ascii?Q?z0KNlsntqJIoQnUUPzXwHWVl5UjslkAuoo1qZprXwoqJjKcPfzwdLp44EH2x?=
 =?us-ascii?Q?hmtONTose4Fn7TxTecoxYltdfpN1bi2GbQGAxaC0MLa7SVUWf2fCbL8JfLiY?=
 =?us-ascii?Q?9SQ6A+Hj1pkQ43LUu5VjgfJ/S5c8ct9GSPjDarfupoA27SO0Yc7z66jPno5/?=
 =?us-ascii?Q?rS1Qtr7ocPWLv5CEB1VkOJmjpmbED14rCaXdy8QVAi6msuMFobHHeV+JyUds?=
 =?us-ascii?Q?5zkHnRy9tq1QU54pc6mTRI0m3gqQRDDCSGEtLGypqLYbjQCqdEjnYPhr3Dpt?=
 =?us-ascii?Q?idFNs68HZ1/hrYJ9vkWPEnB0QWUr5lLOcRhlTMJqSBo/EKlx06F+2UVovdv+?=
 =?us-ascii?Q?5x4F13ejW8/EEY5ei4QqL0Ovb4SZ6CQQwX5TS1YzqG4CvriFXEBAO7Y+NWAQ?=
 =?us-ascii?Q?hL8lKFTO41GV4tdL3eTXgmZNlrtUYET6ZXqf5LEZbrblY9mlK9OoEUlUbEux?=
 =?us-ascii?Q?OMIS/kGocUZ07k4VsINWvUy1I9ZrYWOzv2x/Cw7gp3nuGLGm88FDtuI35VGl?=
 =?us-ascii?Q?BFWCVfbsVpQ1njSY/sZIOR5mR3BfebHNaKv8toIR7/CJn7V7yeIUAYqS7oqa?=
 =?us-ascii?Q?evHb+DBpO8xQppbWGoNlRU3Sj7+febYKWiUugzMVSPuEVwknQ8YBzsfdZZwS?=
 =?us-ascii?Q?KEdwhC43lS7MtLiwx/I74btMfIa3TGTdKEnueRhd8DY8mW0TimUzEYAphEIw?=
 =?us-ascii?Q?lOLqXvcnLkuWydDqOeYwP85/xR8p1RXdD/4hZj7ojdhKgdLSNO2wVS7huDl2?=
 =?us-ascii?Q?Cyne61sUxAyzB997RGEPzmuNe42EmlBe9Qfd+kdViWJXc8mqDSqrJWF53RYu?=
 =?us-ascii?Q?jVIzYUroGE/JYxUjGWKtFbjBbNHzr3+P0RujnhpDzwKWAPO2KmFJfue8HL5j?=
 =?us-ascii?Q?7yVFLRVqkSrMMgLICAijzHeOl9AXOT3Myq1xgYl3DIHCIFTLWPQsbQQgtmth?=
 =?us-ascii?Q?aMznMkqz3cpO0BEiFR73H8pwxuZMDEhnzGEyLErBy/c33kesQrmBGJ3Og7eG?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wzDRmPDEp7FFQVrOfFTBTnHJVbqcjBjCZx1vhG5gTUC8pTpseAIBTWHv/+CHy1mjHXSNk8FPzfFfk8eXxmLe4lGHd8UhafSF5WAlWHM0BGhN6ZYDUBBRAvVG9Rpk2uBTZb3V3F+Fj8a2sjv/XGrZsyMRTD0kuJlv6ccH5da+Wqwc8X0AMPzzdAYOjVEQqcZcPtEyTyQC7rrZUa4J7u16thzBcp0L6HswtLoeByzXc98IR74dRZvCGOTHPJ0CIMtX/wkzsVzzrMOMc3XS6F1K66GVfxbNjQciwEfviEPqYk7Q+ivmmK7xGc9d8Zp+bx1xPDc9WtnDvsrjUn9sQ6o50+lGsAbwl5wc39BY0uutsvwUDZwrlnpw4EfHy2PGZQqxJRJGUl6vFmrQELs3xLuQQVkBNt9Vhx0l2YXvCOh04KYHJgB9weqD51XtJnYwsnWFYpqMxhhqvs7zwKv4TRfaGCT8OBZ/BCHy4e/rqi2NKOy7HtIF07f1O9O67GF210FOJqq/Ar25YAW2nq0377xIzDaFiuzDbokFLxQxV+pRu4P5vpw/RGCVcT19blZUub3rVH/ROdODIpmRaVs+Zro8g6Hx/GWUGuvRLXmYSfLbBZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a8ee8e-3aa5-4709-182a-08dcff15f7e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:21:39.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KVq142CdnkgtgYiLKGJxJ4YitHe1LyR71vOuwE1mmPsstbwZKyrWGZy4dNZrQmZ+VmVo4W+S+C3rRMsXTu2CE6gip3DfMMn5qKZsRPH0MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_01,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070079
X-Proofpoint-ORIG-GUID: 4K4v826o53Z9uUv6P93cWpL9wc3iiqqR
X-Proofpoint-GUID: 4K4v826o53Z9uUv6P93cWpL9wc3iiqqR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

We want to reuse the functionality when remapping or resizing RAM.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: William Roche <william.roche@oracle.com>
---
 backends/hostmem.c | 155 ++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 73 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 181446626a..bf85d716e5 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -36,6 +36,87 @@ QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_BIND != MPOL_BIND);
 QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_INTERLEAVE != MPOL_INTERLEAVE);
 #endif
 
+static void host_memory_backend_apply_settings(HostMemoryBackend *backend,
+                                               void *ptr, uint64_t size,
+                                               Error **errp)
+{
+    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
+
+    if (backend->merge) {
+        qemu_madvise(ptr, size, QEMU_MADV_MERGEABLE);
+    }
+    if (!backend->dump) {
+        qemu_madvise(ptr, size, QEMU_MADV_DONTDUMP);
+    }
+#ifdef CONFIG_NUMA
+    unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
+    /* lastbit == MAX_NODES means maxnode = 0 */
+    unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
+    /*
+     * Ensure policy won't be ignored in case memory is preallocated
+     * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
+     * this doesn't catch hugepage case.
+     */
+    unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
+    int mode = backend->policy;
+
+    /*
+     * Check for invalid host-nodes and policies and give more verbose
+     * error messages than mbind().
+     */
+    if (maxnode && backend->policy == MPOL_DEFAULT) {
+        error_setg(errp, "host-nodes must be empty for policy default,"
+                   " or you should explicitly specify a policy other"
+                   " than default");
+        return;
+    } else if (maxnode == 0 && backend->policy != MPOL_DEFAULT) {
+        error_setg(errp, "host-nodes must be set for policy %s",
+                   HostMemPolicy_str(backend->policy));
+        return;
+    }
+
+    /*
+     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
+     * as argument to mbind() due to an old Linux bug (feature?) which
+     * cuts off the last specified node. This means backend->host_nodes
+     * must have MAX_NODES+1 bits available.
+     */
+    assert(sizeof(backend->host_nodes) >=
+           BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
+    assert(maxnode <= MAX_NODES);
+
+#ifdef HAVE_NUMA_HAS_PREFERRED_MANY
+    if (mode == MPOL_PREFERRED && numa_has_preferred_many() > 0) {
+        /*
+         * Replace with MPOL_PREFERRED_MANY otherwise the mbind() below
+         * silently picks the first node.
+         */
+        mode = MPOL_PREFERRED_MANY;
+    }
+#endif
+
+    if (maxnode &&
+        mbind(ptr, size, mode, backend->host_nodes, maxnode + 1, flags)) {
+        if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
+            error_setg_errno(errp, errno,
+                             "cannot bind memory to host NUMA nodes");
+            return;
+        }
+    }
+#endif
+    /*
+     * Preallocate memory after the NUMA policy has been instantiated.
+     * This is necessary to guarantee memory is allocated with
+     * specified NUMA policy in place.
+     */
+    if (backend->prealloc &&
+        !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
+                           ptr, size, backend->prealloc_threads,
+                           backend->prealloc_context, async, errp)) {
+        return;
+    }
+}
+
 char *
 host_memory_backend_get_name(HostMemoryBackend *backend)
 {
@@ -337,7 +418,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     void *ptr;
     uint64_t sz;
     size_t pagesize;
-    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
 
     if (!bc->alloc) {
         return;
@@ -357,78 +437,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (backend->merge) {
-        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
-    }
-    if (!backend->dump) {
-        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
-    }
-#ifdef CONFIG_NUMA
-    unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
-    /* lastbit == MAX_NODES means maxnode = 0 */
-    unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
-    /*
-     * Ensure policy won't be ignored in case memory is preallocated
-     * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-     * this doesn't catch hugepage case.
-     */
-    unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
-    int mode = backend->policy;
-
-    /* check for invalid host-nodes and policies and give more verbose
-     * error messages than mbind(). */
-    if (maxnode && backend->policy == MPOL_DEFAULT) {
-        error_setg(errp, "host-nodes must be empty for policy default,"
-                   " or you should explicitly specify a policy other"
-                   " than default");
-        return;
-    } else if (maxnode == 0 && backend->policy != MPOL_DEFAULT) {
-        error_setg(errp, "host-nodes must be set for policy %s",
-                   HostMemPolicy_str(backend->policy));
-        return;
-    }
-
-    /*
-     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
-     * as argument to mbind() due to an old Linux bug (feature?) which
-     * cuts off the last specified node. This means backend->host_nodes
-     * must have MAX_NODES+1 bits available.
-     */
-    assert(sizeof(backend->host_nodes) >=
-           BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
-    assert(maxnode <= MAX_NODES);
-
-#ifdef HAVE_NUMA_HAS_PREFERRED_MANY
-    if (mode == MPOL_PREFERRED && numa_has_preferred_many() > 0) {
-        /*
-         * Replace with MPOL_PREFERRED_MANY otherwise the mbind() below
-         * silently picks the first node.
-         */
-        mode = MPOL_PREFERRED_MANY;
-    }
-#endif
-
-    if (maxnode &&
-        mbind(ptr, sz, mode, backend->host_nodes, maxnode + 1, flags)) {
-        if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
-            error_setg_errno(errp, errno,
-                             "cannot bind memory to host NUMA nodes");
-            return;
-        }
-    }
-#endif
-    /*
-     * Preallocate memory after the NUMA policy has been instantiated.
-     * This is necessary to guarantee memory is allocated with
-     * specified NUMA policy in place.
-     */
-    if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
-                                                ptr, sz,
-                                                backend->prealloc_threads,
-                                                backend->prealloc_context,
-                                                async, errp)) {
-        return;
-    }
+    host_memory_backend_apply_settings(backend, ptr, sz, errp);
 }
 
 static bool
-- 
2.43.5


