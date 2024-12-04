Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA25E77169
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 01:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIeOR-0007I6-IS; Tue, 03 Dec 2024 20:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tIdhJ-0002Xn-Ef
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:56:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tIdhG-0007EV-Vq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:56:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3M3H6j019199;
 Wed, 4 Dec 2024 00:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7Yo+cDtmTEfFi5vhZp6MwuESJS+7MO6w6+dyZ/iwyQc=; b=
 hPvhzRq18NQJqeNoRNlvAxz6X5n/K2O0ZUqBgzVH6jsk3XZwfQp6iAhRVy/gFIOv
 pXIei3yUKUVLaDjw6KlCFL64tJ5uvroWXXBM6ExiSujj7zec21owg84Y75Wsdwe6
 bQ6z3lCQQI+zqCLYDPTCsPes6divAMvFDxob/GvF2qQ7wUeVDVuxkUW5lJf42kRe
 NjL/NK6wJngNXklHftVXB6q8Ggiy20mujLKwcNn8Z80GSg6lX8XKOARuGAuuPnOK
 smtrvpI1G22kDOcBg1XYW4BusK97Zfj12wAzk8MFx9zoh6T2KiWa3zTHjPH6ulpC
 hLndLl1ZyAA3UKaMFzjFRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas79fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Dec 2024 00:56:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B407fLs031610; Wed, 4 Dec 2024 00:56:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 437wjd9tjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Dec 2024 00:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCM0TWN3C6zDGIWDs1upIoVQi3wtTvE1g4WOc879UVNZPD+cTf00extah56YlILqIB/dYPG+4nCi7giRS39/sVj5OUr4zJPyMPO7CeBfNi+n6r6FJxjJcsYwDCaSqX2mR6EFX01cXw0XdOZPPqs7EIgJIGjtGTzZ5CSjz9ugh9wANME/3/LdEgysIpv8IAWzcItzaYE0LFG/SAMPQQWCJMHd78xSrZTPIzk6yOzsfcFjGvtRXQM1fcK2ZlB4OCyYgUXEGw/91ZA0VMUyDEjvd8L+Uu46Cicpyzc7CgEzGhinRORUCcLdG1XGuzk36E2aQbuOYd32aQmsIsIJBKWpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Yo+cDtmTEfFi5vhZp6MwuESJS+7MO6w6+dyZ/iwyQc=;
 b=lrwmb3q5PipIdKMMy/onJqSYHc9XPDHa2gQ2dcyDQbtvAUOmhOqIGBRmZzuIxL1pKZyQ3kDGrKagI9uSVmk7KE8A9ec0sqAoyPQWJ7f7YwJmUyqpTtXkUb6qYyKkB2S28CUGBKR2Qsc61TDF0XtV/XXhgM4M5SQ3YdBUK+0J4mWoT69Ehjf9FR/wY4Da44kWDIGR+jCuGuvZQsvGAECrHfDsylT2ZJfFukYHR3VfoNpqdoVUQ0gYoM8fheFWcyiXC0P2BxnC7fnBLuo+d4Tvb9ukiAutWsLE1fCZipcogl0rgZ8/Kkiz9Pjjptvt6SpK5OARXilF7s85X0yu0GGIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yo+cDtmTEfFi5vhZp6MwuESJS+7MO6w6+dyZ/iwyQc=;
 b=E+3jEbdoC/psoH7rPssU3HFLCGVGHFud3SRyxXJxUBnV6vLDgIs3Y0INwo86xG/lZS5KqebjoCjshPj2oxHG/w/jkXdxm5y4Ap/GwOMTQs6WoMZBfK/VaAi8i7fs7jE+ZdRHLmFjcFkHh8MHe2LdFuGmUldx8LaW8BYQyKcppqg=
Received: from MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8)
 by PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 00:56:48 +0000
Received: from MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9]) by MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 00:56:47 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: qemu-devel@nongnu.org
Cc: boris.ostrovsky@oracle.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com
Subject: [RFC PATCH 1/1] ACPI: Enforce mutual exclusion betwen CPU insertion
 and removal events
Date: Tue,  3 Dec 2024 16:56:36 -0800
Message-ID: <20241204005636.18705-2-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241204005636.18705-1-eric.mackay@oracle.com>
References: <20241204005636.18705-1-eric.mackay@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:408:d4::36) To MN2PR10MB4269.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4269:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8d8f71-a57d-40f9-6987-08dd13fe8791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D0ezJOYRh53KGz+UbAuObSZeC2Z9SauiCuDwkWfVhYjxUOaCtHt9lFesELoh?=
 =?us-ascii?Q?HBjYYZfwUW2Ipi2GUmELIkp0mKlOl4BlgWVHgS0iS7aD4Wkd1lUWGXXAdw1z?=
 =?us-ascii?Q?KNmdj3u/1pVdBgjfNB2xz89aodZ21E/FzEl1L1iLUZdobJOrXMwyHwYu+suW?=
 =?us-ascii?Q?NFR3wdhNUWHxSZMB96UWelf84tMhvqT8Wi4/DC5zXmkhkA2+eW/ecLvcaSbq?=
 =?us-ascii?Q?Y0F6aDBadPYva1Bq1kyKed8NvM1batlBKmPDJWM5vnhvQm00yHBIDubXXkSv?=
 =?us-ascii?Q?LO5YJEPYkPU65k14aLUocB9VNAGlw16qkR7EhNANOEngLX8FZVjvOeVxmain?=
 =?us-ascii?Q?tbqEVuFEhoiQoke6nX4iGkuAWHigD8BfdQUOIXhzthFXSPhyLjIjrYbv4hDt?=
 =?us-ascii?Q?vAS0XaZqnLmmM8539HmL5VbRuuzFs4L6UZnQLAv5sWGSbUqgNZG17Ul9tkNV?=
 =?us-ascii?Q?tv4lFUj+ckyUpwjrPSVOGwhbka3CdtYQV6Ko5j8hpgh0aW7VSEcC7veWPxqa?=
 =?us-ascii?Q?0W3B7rg1GoCzubSgC2VZomEaUM0vParzZVNwmG9lLw7mD2+cenKJ52ibJ8JG?=
 =?us-ascii?Q?m0FWBHfVQBvIF28QS/IB2jFBVTpB+LYic/3cvjiyBBnWnTJUu9B/E3n4a5yx?=
 =?us-ascii?Q?PbMnAIP5ljtfkyuh5YZaNI6FFgvn5TuV22nEXQW/+HYNZjC1q6BFldoFyHm6?=
 =?us-ascii?Q?fq7MCT9HwdeiWCBuOwPLCRKXJMc5sAtGFKBgh/adVDt7ShkUcvT//y0wp9ew?=
 =?us-ascii?Q?o1rf8IMBvXaRRRyEaGF+tdtsG+RV2qeokdHgGDZ6MBUVg2JDKlWma8YalArx?=
 =?us-ascii?Q?R1G/YyejEmtLAFyc1lwKovRID6hEOzx509tIWZ5xcVUInn8W1pWqBotJRS/Z?=
 =?us-ascii?Q?OF0ajiFk9f4PoSyUlK2lYzEU9DgV69tRIFBd1s2lW5zGdTn9KsXBwWF1SgfV?=
 =?us-ascii?Q?BN/Pl6Du5zaB0QIY0j9+wvJpoyVCQDzMPl56OUegPVqn79awegMZ2VfJMyWz?=
 =?us-ascii?Q?y/wZNO1JlwYpLCHPtwdwo7FsTGNXqDTS9gzcHs8Cu1ryZObBCRLrVAMHM8fc?=
 =?us-ascii?Q?DybpurkbDl90d/k7yzSMcgrMVRJMyMMX6i7xBCFIiRROvSquNrtR3Di+1vp3?=
 =?us-ascii?Q?3PbT1lJi9sh9OOJ4WCAwW2Ncwy9umBIog7jKdd2vyXSSVHFWCaVOPl/RISWs?=
 =?us-ascii?Q?Sp2tZHOOeMHof7rXIZ/ug0mg9t+SB6geHDbUvQSnK28M01bcixT0qy2QgxYT?=
 =?us-ascii?Q?lICYhj+Pys/E5Z0dFHZJ4YSdnWkDNzFkeA1ClZN5g2UjtwNhHTQ6AWhBxy0A?=
 =?us-ascii?Q?IjUmuBXeg98fVGjXN/HNlPgtH+SnExxrGDb71ElXlT7kYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4269.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fHwBe+WZPFhM0FkviG15t8HgFWD0PKuKEiieOJOq6j3rG8kkq8ovVb342iVr?=
 =?us-ascii?Q?JNHnERjTrAhee7eIKxHWpdusj/4s8Hk30ihAQIEHR0gieIOQ2WqFjI4pFZHJ?=
 =?us-ascii?Q?r9up6IJe/wDVwC30L7PN/GrYdrgbzASHZgC4Ng000QC69U2Fsp8zv6wKeZpv?=
 =?us-ascii?Q?NSNlRkNLG8cYIXBWSQ3jw4uSR2R4N9lKAaVdTt0UyVep9AoI/Of6ikBMApCP?=
 =?us-ascii?Q?JrO2iX57lXw1UCQsOSds/ICYTQcXxa4+BYpu0SLU7c045jJLjZW5aa4UjYiM?=
 =?us-ascii?Q?F/dgHyj/rwux8gU15/Jc7sPFpzCDAqEKbKNPssmWYH9QYYBm+9GVMrCiKRwu?=
 =?us-ascii?Q?0C/jq8/Lf8dFqYUCYy15nAz5550A2znDekGY1cYFxTljk+HlhcFaesKLqkwV?=
 =?us-ascii?Q?O6C62ol2clwgKgke6/0ZpBzGN2u035AkwxMlYTK2Gsye1/cD+/1kuGwAGZlH?=
 =?us-ascii?Q?VYQdQzFDTmzdnildVGhQKI5M/CMbGhUgtngQX1xt6gLWguqRE5bLZVfZrFZq?=
 =?us-ascii?Q?WEt/4tgZtDaluOEZs4f4/uXFiA+tKxKpZ+5CTG3Q0nsn57OLl67e0+xL5its?=
 =?us-ascii?Q?Dh+gHMeBMHGxuR4MYbTY7NnkaO6C0vaTZ1ue9H2BFdszE1dwuFf+NBgtOoTW?=
 =?us-ascii?Q?cGWTqpfYotgPaM59qG9fSGRViFxCCEpyM4ksWHsY4YE5BrE7fZIqHemImX2F?=
 =?us-ascii?Q?6OogwXWEmN9XkcfIznuEGM38gTOgMvN8ntbWKcmqykOcnGKL9GjEn7p6iGuD?=
 =?us-ascii?Q?Yx3zkDmm2yuHsyQieXzL8lY/Z2ieNrDP68mhc2yB5Fw7MggyXQYyeqkb6pyP?=
 =?us-ascii?Q?Tph5BT92cPzF7OKnNg/tj5Q4KNz/34fN3B5U0CiGMGzpgwUm8DOgHwN71ckk?=
 =?us-ascii?Q?IftAvgdjyIkK8xO1VCN1a/uaOitS6qy1+9MxIgCNVtSZqukceTbjDQK3cRcT?=
 =?us-ascii?Q?nPCwB442lmlz3tSqY1QO5o+ejd46FpoROTpWP25AVrDtUpNvHfr0wHJtksJq?=
 =?us-ascii?Q?hVGhUJdy4r4CJ59nDQI2BdNU744Vy1ADw9HLTTGp/hNbwno1REUlgZyMzVjH?=
 =?us-ascii?Q?rDTjBU4cijDoHwgCh0VhdzqX3la1fJEdiSCrHu1Dzq5KmB9zoRyfxMGOg08q?=
 =?us-ascii?Q?qk4jA3fBH/07AOrMTqdq08DYcSwYM+6m1WHyN0VG8xn9vDVY3hNuDJSwR9LV?=
 =?us-ascii?Q?tt/yJlW9Mq+DGYyrx8tN/n6Gzfj1t0vE17PlFBGrhZuEtxte64g8/xot8UNj?=
 =?us-ascii?Q?iyQOlZ4wA4t1u7mZ/GyjQ+wS52G2GOffMknQNoplRXsizO03vhT6ta8O6ICq?=
 =?us-ascii?Q?wIJ5Cr9dm3HFMJPdR7u8oD5+2nbFPfA1q4c9djAJjivfHFIvy61h4A8VwA7x?=
 =?us-ascii?Q?c9J7wu6nl/KlryYBfWUiEFBNSxScuZI0U456zHwl7jOMiyQdSqqfLssmNUsS?=
 =?us-ascii?Q?h868m7P7UCRK4Rn6JiIBqsPCvll4ubkaArDxvrUQ8Km2/g4chlVwa0xkRnuw?=
 =?us-ascii?Q?qKVgtdS8GQWc+Cb/VlqAiHBxM9E2RgXI9xGZ3mkf8+bXn/2Q0H4DZyHq/2ka?=
 =?us-ascii?Q?vjC2M42b2JY6nqG32CQjP66Mq/DfX8ih2FgH45/H68MlwnzVwDoNShu4iBoZ?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yOOw2JCzjLOhtAcmvM5L4EcUa+B953qBzAzKQetJUPXvN/WOgpD0bctyAzTOzTztfIbd12zfDaEggk/UuxWVJnYH1dGyl+LelmRMlAQTUpHlR4ayQEDqjZW8raEDIKn3wT16RQ6AtSs38QG0OoKn9lD6QIHe+O47/fejbHftKcWC55TnFq8JOCIzPenxSKbDmbc4xM7glmNCDoOT5NQNRaEfpHj9BfZSLGWmhD1ZvLCnJimcoxtQ2IOXpm6tt9au+PKjMRz3ZyHR8VPsRUcV0fe1tj5HPJAzidkEmGcR0/Zdf2FouQOVR89xUpMxJrtfuXnJQeI/G/WLLiW+Hb8FZcMqT+4wadlas4y13kUQzJ+xAgmE/qhqhHH1wSkSFTa3F3oRdHRSWvXYwuqw3Kz7xGMibYC6WpbxOteTaKx/vnXEKdliWHiURwTcB0m9Xbrei6T+R7s1xFliC3/kKuU2cd9FY1vXYVapHjwkTNGr1+fuAykvHFR5rcyfvOaYYWyz1J7hzpSQ27p0PEWenNW8v+QsMvGELank+g5Al6jpNbyha2RO/fWt/Tx7JM6bcviT53bSvb4nuvFNeNXC4D3Vq15b2h6EIjQfRIeI0JlDp6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8d8f71-a57d-40f9-6987-08dd13fe8791
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4269.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 00:56:47.8284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Pv1yMEJ9TYnsl4XsnoEr6MbEjKHv2paQXgFMtG2QD9dUAUNNoTJ6ksD5UdQwslSiKtK6f2A2KBe6P20xVu3UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_12,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040006
X-Proofpoint-GUID: XfkFtNK2FDTMQqt0fxqrcdoVu5uEcpo1
X-Proofpoint-ORIG-GUID: XfkFtNK2FDTMQqt0fxqrcdoVu5uEcpo1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.mackay@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:41:29 -0500
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

Setting a new pending event will clear a previously pending event
of the opposite type, for a given vCPU.

Intuitively, a physical CPU cannot be in the process of both
hotplugging and hot-unplugging at the same time.

Signed-off-by: Eric Mackay <eric.mackay@oracle.com>
---
 hw/acpi/cpu.c         | 36 ++++++++++++++++++++++++++++++++----
 include/hw/acpi/cpu.h |  4 ++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc..48cb60dc38 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -23,6 +23,33 @@ enum {
     CPHP_CMD_MAX
 };
 
+// Enforce mutual exclusion between is_inserting and is_removing
+void acpi_cpu_set_inserting(AcpiCpuStatus *cdev, bool new_val)
+{
+    if (!cdev) {
+        return;
+    }
+
+    if (new_val) {
+        cdev->is_removing = false;
+    }
+
+    cdev->is_inserting = new_val;
+}
+
+void acpi_cpu_set_removing(AcpiCpuStatus *cdev, bool new_val)
+{
+    if (!cdev) {
+        return;
+    }
+
+    if (new_val) {
+        cdev->is_inserting = false;
+    }
+
+    cdev->is_removing = new_val;
+}
+
 static ACPIOSTInfo *acpi_cpu_device_status(int idx, AcpiCpuStatus *cdev)
 {
     ACPIOSTInfo *info = g_new0(ACPIOSTInfo, 1);
@@ -125,10 +152,10 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
     case ACPI_CPU_FLAGS_OFFSET_RW: /* set is_* fields  */
         cdev = &cpu_st->devs[cpu_st->selector];
         if (data & 2) { /* clear insert event */
-            cdev->is_inserting = false;
+            acpi_cpu_set_inserting(cdev, false);
             trace_cpuhp_acpi_clear_inserting_evt(cpu_st->selector);
         } else if (data & 4) { /* clear remove event */
-            cdev->is_removing = false;
+            acpi_cpu_set_removing(cdev, false);
             trace_cpuhp_acpi_clear_remove_evt(cpu_st->selector);
         } else if (data & 8) {
             DeviceState *dev = NULL;
@@ -259,7 +286,7 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
 
     cdev->cpu = CPU(dev);
     if (dev->hotplugged) {
-        cdev->is_inserting = true;
+        acpi_cpu_set_inserting(cdev, true);
         acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
     }
 }
@@ -272,10 +299,11 @@ void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 
     cdev = get_cpu_status(cpu_st, dev);
     if (!cdev) {
+        warn_report("CPU status bad in unplug req cb\n");
         return;
     }
 
-    cdev->is_removing = true;
+    acpi_cpu_set_removing(cdev, true);
     acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
 }
 
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..fde4ba4a37 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -39,6 +39,10 @@ typedef struct CPUHotplugState {
     AcpiCpuStatus *devs;
 } CPUHotplugState;
 
+// Enforce mutual exclusion between is_inserting and is_removing
+void acpi_cpu_set_inserting(AcpiCpuStatus *cdev, bool new_val);
+void acpi_cpu_set_removing(AcpiCpuStatus *cdev, bool new_val);
+
 void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp);
 
-- 
2.43.5

