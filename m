Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A112ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwrC-0006OO-Ba; Tue, 10 Sep 2024 05:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwr0-00067b-Qw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwqt-0004Hf-6i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8uEWS003988
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=lTEL6i972hm0brpxKiBCC5Jh/AaomVcIwAnTkmwuThc=; b=
 LY2kmDN8nLq7iyA0nwMbX2jxE7pGFV7vOw033IcKjQg9B22wJqn8vWTRC98ysNmd
 hYReeMGVaKnOWYhVueD8Y2mu30SA4HrZ9FGxIAgUcGOou0FBjem1QUOvOH1Sygci
 NJ9aseSezDYPGtGSvMVnyjXYkPzWVbbxbWEJFgdM1D4gy54qJpamBLE8nQF03EIU
 u7lL8l/SoeTmZPhviaBrK29wzYyuT+vtddU01IGT/6Zm8rvNxp0WwinTP5k62P2r
 YZ2fhFj0ZLJ/e+yuVzWtynYQ1Gj6mragYcpkwWg+/FiQ3juuFB9/oevw91pJCm5T
 MwG15K0Cco4ZBnH0TI1aOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcn1b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A7giFs019825
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9esdc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER0bIrNJNLZoyRP+J6XAScN35mdL6+DWMgCqwKOM1emzv9agwikwTnQWI/YuGoffY8Gc2nyQJuURy9Yjwazv7Ifl5AkgD31sjzSdE1zfS/yz35bz8clxKmwHs0g/5Un88Q9CtM3Vx7uINLjdwWFIWUqO51mfAqNAIrdSgqAHQRCBqPBBym1kFWkhaqQiXEcvLW0ApANDoHGdX4KxKJf7h+Jvfrnd9EotvI6ZBOWXDkgN8qaFK0Y/YUlxS+mn3Kp8k05SAPMSZ7if8xpsYghhoq0sx/mAXM2PUlWl6nnexPyTilUXJppN6v9yqh1sRTFkeqVFta+rnsPdGXXJSfKPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTEL6i972hm0brpxKiBCC5Jh/AaomVcIwAnTkmwuThc=;
 b=sOYtN7tOU617TrCsWgV8J0JcsbdvMjzokAVop12/r5eeqoAtbExqwhUD3LJaZognEyH2lRywVfEo3A7vE/4J49ecCO/+WTYlXbwG/qP0ogqztqk0UrAlvjqMFlX0ns0Awl+I1hxV7w98YGbegzZc0EzpBbhen6woOXjdDJe0+P0Di0BjAmpdcpBYecnWAHD8P+ztQxHBXeNPNJZPoMjpMFVgIh7StvD3QgGKmUIU8GRGTeMhZkjekuEZB9joyXWVk1x6O6RDUlKDngAR0lD/CgwdTFt2luoSleatDMaWWPz4AFFdMrCBm2bX68QLTqHl7Rhbh10BWBHAujm9KkGszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTEL6i972hm0brpxKiBCC5Jh/AaomVcIwAnTkmwuThc=;
 b=yU696/foQWjpkiYBz68Hn0ggIfpYJo/lwOareuG4nnwUrm+0MQAcjKXQoyd/qF5clX6rTR9g+0BfR+MBn2nkpfEgHMkxgc3J2Ln6THJescllrEuF4LJzJeTypF2wkE0SkKpN5u0ga4UTeMvNZ4Y2mOpQPZQbJ+hcGHiz256kFRM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:07:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:07:54 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 2/6] accel/kvm: Keep track of the HWPoisonPage sizes
Date: Tue, 10 Sep 2024 09:07:43 +0000
Message-ID: <20240910090747.2741475-3-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910090747.2741475-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caa6945-3fc0-44f6-bff4-08dcd1780e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DXpgbSNdZGSBudWcq2XfMht25kCCnJxCpTQk3Uhv6vkSNRHXiQtKKJ3MCP7T?=
 =?us-ascii?Q?5C4G+PltlDFsAgz8gSLU52+6q8tiMuSASeOa+89nz5oJR4HEYNkAwN1+Gr30?=
 =?us-ascii?Q?4ob5RaJEM5YBh1wlA5NpjkLy9Jn5ovMtihXHINYj/WNkFb3gAxfq2kwpzQf/?=
 =?us-ascii?Q?YaZsOwHmTTB7zR/LoVwwH6diHjjgDDwxXicj4WlXUEgh9abZyb2NXgwM/mjr?=
 =?us-ascii?Q?vk4P3fEjUhw6lfITAKVQ4GybyNH4S2ezSnm5DlE6I9QitvZ9vwourYYunIFb?=
 =?us-ascii?Q?PZxAU3P0HMeN1zTlnc9lH7seRpHloreFUA0OwJF3RcrKyMSt+Sg1Is5VXslv?=
 =?us-ascii?Q?Bt8vAKfyhSHKPahiNbkcz4m68qOKEWXsdmC6RetYsQUeDDZdX34yPpJA5pzT?=
 =?us-ascii?Q?h9ygFv+MhWOv0ES8Ib2yoCeGFNCRZ1xhx4IU/zfGmg8R06As4zUegl4WvfcK?=
 =?us-ascii?Q?asCJk74vCy3amLri94Eski55o2I2I2d8Rs1UDbQT4oy9DsnwSYaajFnEtz75?=
 =?us-ascii?Q?p6rwN/oIxQbHln9e74+oWFEVlhLMPd6FsNfMJ2vz/x5N8PgqVE/fy+U28euH?=
 =?us-ascii?Q?+bfcvKgN1lfOqZ4iKVmFNT0ojpumFB75bypPsJ9kmAYNxZK9dxMFlEJaTlf7?=
 =?us-ascii?Q?3vi5FIuIWMrwndphc3WsgAYY9DiVLNAFDaGIuvQ6H1Ipw2+ecxmdUOeUhBJP?=
 =?us-ascii?Q?+M5hQHzQQUCMHcQP2Jms1b1FIVcoCyerQvgO0JTrgX96SWUqH4We4ciGtxkP?=
 =?us-ascii?Q?ig86o+nZmy+mPCtlqr4Bv8bU7w1ZzX7QxI561oxBXEJJUUGA/FK3wuO7qrbp?=
 =?us-ascii?Q?Nlycsdm/I/fii6o/2KJtbsEILXZDImUDODtSd9kNVBOa04p0wRSGE8Hu2h1+?=
 =?us-ascii?Q?TkLP4Ib7NcVD6X0nbW0WNDrYt5cSr7WJHGE3iaNXv14lXvXklqUdIy48n6Lx?=
 =?us-ascii?Q?0pcnWJHmumHB7JThkHO52Hv9F6iqb7HM9yBHNoMkAnvksEPtGUGWaLpDkt7G?=
 =?us-ascii?Q?PMdY6wYLkB7BNd/sMmGn+4AoXWmdedVb53BqqJc87llkrQQjjTVMnZ2Baq5u?=
 =?us-ascii?Q?GbJ3S5oJOXFRRF8szHw82o2UM0ED0jN0xUxsT2t9GYGRCdqmTHgkb502+2Wz?=
 =?us-ascii?Q?C/FfUw7QmDjWNuG/AKXfCk/CcQhV4fY17nMV56wKdjjpCHzgqcUGZdmJG9oo?=
 =?us-ascii?Q?5uY5QNPcF4/ksMcjAfNn/jBGCPj4DZp0lCLi622Vg9b3WB0fhCrccwAdo8MS?=
 =?us-ascii?Q?Ac6Jm1lUuXDa4riU+oQbRvA7iSZnzHHTMBvJjKHZLu034KAZmrppzFJSd/P/?=
 =?us-ascii?Q?E08PRuvQPd5UMMk5GINkKUTOswXbiQZQsff6V/iB/Z8nlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aqhq+R/HFnig7EFL+HH0f5mBZBdHfFcTO1D465jHhbwOkCz0WlrTvHGwMmDC?=
 =?us-ascii?Q?MDI0DaCy8EE6OiYTu3C6ahcUi3aRMhTWgtJeBJ67A9OeNGlOmR9zk7CCEYuu?=
 =?us-ascii?Q?n1IWwKSwyEFO/yD6iIIFPIU523wlwEd5KfyO3l4TvbaTfw187vsJWw2gr8oo?=
 =?us-ascii?Q?GkBTvcDP3D+RMCXzobzN+8SyQT9+Y3KvOd9Ogo+UdHpLQejSEgCTVwK5jtV+?=
 =?us-ascii?Q?7eYxavbLiXFEAB9rFt3R0nUlDM2HKA8T7fDN+soZ5SqdXRLWBlIi6VOcSihl?=
 =?us-ascii?Q?oVi4m3/hftlJSDqMSIHo9blPK10VKoiKS6BrB7ZL7Mo1WbgPM4wc1V5NKEGx?=
 =?us-ascii?Q?U9ZF0c2Poynj6CCRwjvCA/hCZP8dhWSX8EDMwZbObH+hl+gBfNzwt5+W3Wcn?=
 =?us-ascii?Q?6nmIAPOHj9KFlkXxDHD6c4uR9nDwelYGYJeuimgykyEu0MMGHGCpOct1tgbh?=
 =?us-ascii?Q?6ykr8f0B7wbJj6Shp/6UT37/tQSFttV6Yhf5WAlh1M9/WAY7AUIYKqLOHe2a?=
 =?us-ascii?Q?8pyY0oSjBbJgcvrftRXKIGb2fMPszFv0vHNbTGKk2LNNcsUPV7AXze4Ebakn?=
 =?us-ascii?Q?fSHIN+/xN8GBKs0HeKCKBCdf2FJsIkiTubLBgQuw6I5RQduFT0CQxvqPoU+2?=
 =?us-ascii?Q?qKa5So7laHJICOB15j+AnSs1ONX4OaQRo05u3HBTgK1R0BtzqlgglURjHkPf?=
 =?us-ascii?Q?RoDKpv31cFcu2c9Sb/ZV1MoR/qhDLFGnc6g2pqvu8fsqvvU2/6K2jFoWB1TU?=
 =?us-ascii?Q?EDxR6xvXGpQTc8dQ8RMDvCoE1sGRG/ZVjryupuVQi+dcp2pYWYV6IUhf+QBE?=
 =?us-ascii?Q?zF3UfCVkZmwD9LIzCmCU3JR4TnF+v0DJyZz8NJi6tV+9dM4PVLWkFiFuxOq0?=
 =?us-ascii?Q?gmRC2GTPJUbS+3qpKUxwnXZ0sxTGaLHU+JsEAUwh4LZhg1jh7njGi9TZbosc?=
 =?us-ascii?Q?LZN16yvZ+VYRVYAzDGKZVG+kHvMh+9XWZpx/CUNj/zRzniuvavHU/hMNHBOc?=
 =?us-ascii?Q?Ml6ZifAqHq/lX+g6EKUutqTlyd7s9iZIAP3UY/zvsLzkISQmZaUlwC6a3Dp4?=
 =?us-ascii?Q?8dbw748xYVUxMbjY3J1gGb/8+AjGPftwIcL+7L4xRCAmBM/rajUZ9OnUJ+Qh?=
 =?us-ascii?Q?PH2LD2i0kvVcBgt8UPv6rwYaCYYIEf7j5YYHXMjEvQuAjF0aaoC6SJprInD/?=
 =?us-ascii?Q?JAl0rfPPcIP3YM16vHj11By1A80IJGZJ8u0SW9M7A7pDKP/TmEdKNBTCH3fR?=
 =?us-ascii?Q?su81ek9p0PPS7yvL3xAIrfY8eJBpvJOCowZjaAsrSx7LEE1XRw0lr8bUqhcB?=
 =?us-ascii?Q?1HDYvdCPOMVA+U/wxIR6VaLMv5fEuFkmt7o1ddmY0CFIWjU4Yx8wcrLIp4Hz?=
 =?us-ascii?Q?i0D2VKN6BDdP0SKLmxmP3aQaT7RxEsVTk/zs7ELJu677uYCDzSoN+pg+6OzC?=
 =?us-ascii?Q?ZJer8iX/tWS38ZLQ/IcioqbrTup+cWhYjiZnoCFUP97eG/Bz9AkYXWEwKalD?=
 =?us-ascii?Q?l/SiIs54hLLR1MsTP8r2nbCJ3BdtNZoCVKI5kDEHnhsF6UCEd3sNPUU06dXn?=
 =?us-ascii?Q?Z244f2njCLhod6OyEkK/imJNjBq/nTUWXZlnDewiajytvslzSsTkVp92kzb/?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O7ADp0MI2I4COvJahpyOnp2brwXlooHs3CGRCaGWZf3IuzLNh4l5Ag/FNHiSusalHYzhaLI7A9XDsK+dqhrWOWr4XzanJNeKrwPKFTPEf7XSnlWl7Gn9MPw+yHSxFelqJBS0uH+RQ4jUmtmPkfJ+Sm+bt2PfJHAIuqfevAdxRrgp5pW3tQzn3m8n3ivZWGCTqulu0y+wXyVt6vU3visom687dH/92qqFSG8/rT/YDRIEIQxguGtFA3KCpUPFRNaXvXLdETQzz/cK3huI3Vr+TiANqEwMiL/VpMYYOVX2XYx+JqGTfDIH90Yi/qGOWntAMzP3OsCwiJ7CRsJfnOgE87HOO9skEiajYt/FGJQsWm+0/rbKAlbdOir9n99L2+/latW2/QCrmWGY7si4VS0NaVgtTZmImtZjasFJR/f9hAtIEz/ZAo3Q/yh3raDPJKT3Yd3dtKlu6QLv7BTSLHNkgtI6bs7yImV8VvN9S7UycqmhWWPEv077Bz8lYYxaOoGVUogutvu/vo41rP2PQWSmjzI8sqA+nKQ25QQUqcwYzi8g8nGewfPpGjj4KfDJcoH/CZu705/ZWtfxAyDshedPRpVOUIolDPejx3WPVdb5kpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caa6945-3fc0-44f6-bff4-08dcd1780e26
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:07:54.5060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOSZQ8UfLlR5Q6QZvjMPJILjrGvLebHVdk9kLkvbAG9I8wqB6j62uYWpx1i7ODJh4JVd3BoJ/aexwZCkmnJZv8iWB69oMAj9FEyTJ+2hLC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100068
X-Proofpoint-ORIG-GUID: 5NHfYzZ4zghzv3FwKEz2bQOv-tfE2E95
X-Proofpoint-GUID: 5NHfYzZ4zghzv3FwKEz2bQOv-tfE2E95
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the page size information to the hwpoison_page_list elements.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c      | 11 +++++++----
 include/sysemu/kvm.h     |  3 ++-
 include/sysemu/kvm_int.h |  3 ++-
 target/arm/kvm.c         |  5 +++--
 target/i386/kvm/kvm.c    |  5 +++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 409c5d3ce6..bcccf80bd7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1200,6 +1200,7 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
  */
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
+    size_t     page_size;
     QLIST_ENTRY(HWPoisonPage) list;
 } HWPoisonPage;
 
@@ -1212,12 +1213,12 @@ static void kvm_unpoison_all(void *param)
 
     QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
         QLIST_REMOVE(page, list);
-        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        qemu_ram_remap(page->ram_addr, page->page_size);
         g_free(page);
     }
 }
 
-void kvm_hwpoison_page_add(ram_addr_t ram_addr)
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, size_t sz)
 {
     HWPoisonPage *page;
 
@@ -1228,6 +1229,7 @@ void kvm_hwpoison_page_add(ram_addr_t ram_addr)
     }
     page = g_new(HWPoisonPage, 1);
     page->ram_addr = ram_addr;
+    page->page_size = sz;
     QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
 }
 
@@ -3031,7 +3033,8 @@ int kvm_cpu_exec(CPUState *cpu)
         if (unlikely(have_sigbus_pending)) {
             bql_lock();
             kvm_arch_on_sigbus_vcpu(cpu, pending_sigbus_code,
-                                    pending_sigbus_addr);
+                                    pending_sigbus_addr,
+                                    pending_sigbus_addr_lsb);
             have_sigbus_pending = false;
             bql_unlock();
         }
@@ -3569,7 +3572,7 @@ int kvm_on_sigbus(int code, void *addr, short addr_lsb)
      * we can only get action optional here.
      */
     assert(code != BUS_MCEERR_AR);
-    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
+    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr, addr_lsb);
     return 0;
 #else
     return 1;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 21262eb970..c8c0d52bed 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -383,7 +383,8 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
 #ifdef KVM_HAVE_MCE_INJECTION
-void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
+void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr,
+                             short addr_lsb);
 #endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 1d8fb1473b..753e4bc6ef 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -168,10 +168,11 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size);
  *
  * Parameters:
  *  @ram_addr: the address in the RAM for the poisoned page
+ *  @sz: size of the poison page as reported by the kernel
  *
  * Add a poisoned page to the list
  *
  * Return: None.
  */
-void kvm_hwpoison_page_add(ram_addr_t ram_addr);
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, size_t sz);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 849e2e21b3..f62e53e423 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2348,10 +2348,11 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
-void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr, short addr_lsb)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
+    size_t sz = (addr_lsb > 0) ? (1 << addr_lsb) : TARGET_PAGE_SIZE;
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2359,7 +2360,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
+            kvm_hwpoison_page_add(ram_addr, sz);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
              * synchronously from the vCPU thread, so we can easily
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e3..99b87140cc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -714,12 +714,13 @@ static void hardware_memory_error(void *host_addr)
     exit(1);
 }
 
-void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr, short addr_lsb)
 {
     X86CPU *cpu = X86_CPU(c);
     CPUX86State *env = &cpu->env;
     ram_addr_t ram_addr;
     hwaddr paddr;
+    size_t sz = (addr_lsb > 0) ? (1 << addr_lsb) : TARGET_PAGE_SIZE;
 
     /* If we get an action required MCE, it has been injected by KVM
      * while the VM was running.  An action optional MCE instead should
@@ -732,7 +733,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
+            kvm_hwpoison_page_add(ram_addr, sz);
             kvm_mce_inject(cpu, paddr, code);
 
             /*
-- 
2.43.5


