Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73420C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 19:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tagb1-00006d-D7; Wed, 22 Jan 2025 14:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tagaz-00006G-N8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:41:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tagay-0006fW-2v
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:41:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MJYjaW015478;
 Wed, 22 Jan 2025 19:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=3WEjTXMqCC69PZbl
 6xVoBkRbitk/6kv8PBqZTn/U8OI=; b=IAXmDKee/W9cfuVRyH3e/0vv4/1iN2g4
 mb/VCsoY1ohT6p0uyfhXLD1YnyAOys5xPfBez7K1vclLYJGTMp1uV6O7v6t3xJKg
 eXlYYQaie1EVWHiuARrl8iUxQfxHkWdGtI++mb//GS5ltEaHdvfJH12DuJwnSDwv
 JIUJotWxlJo2z2m0MRoCUJJFq92GNhgfZEDOB62V4MYoNQS0CirIwKSPatr2V01c
 SIEnJfN5MsCabyHNLkTNx8kmH845lypsUgExAPODBbIqhp/kTGu/qFLmeEFddBms
 NXYIfB+iHVf8wlqouCpUzeReZ7JPiw0qmlA1fP81YbkY+yJ41WP0Ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx18st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:40:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50MI2ai6038014; Wed, 22 Jan 2025 19:40:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4491a1rkcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:40:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0ZXqL9d5OTI19Yqk+toVFaWt9q1YAFbw9+fD02rJy9TcwgcZalwcBh/zEoy+NykvfcA0SHFPHJDsBQghYUZ/yIWQuf77yOx0v/3Yk6aB3SyA5TCHlPu4+eq6f7c+fG7CBbiFYxI4B1SRJ73WZJLnI8U1xpb/cSIu8PIGJ4KzozFylpmfHof1sy+eRUtQ609V0mv7WfOmauFIBz5ftI4+sDy2d3MDtSscFgY1PTdo/1xUmRwq6tus+XgukSikGLIK/sTLeLDa9aO+hqW6vOvC6v6htCqMZBLgd2QRsCTYNioCuGi2oBKVjw5DroIA9kkGKUgIf+zXUOjqawhwECmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WEjTXMqCC69PZbl6xVoBkRbitk/6kv8PBqZTn/U8OI=;
 b=Sb/fCad0OyRL64ctLh1m8r3ycnF1NI13zul8MF/I26W+Emh6apekr5vfaE7ja7UkeXr1Qs4qkZhqyZXSKo1cn6nXDBnPDFbdBKLmNeuiANGduYy0kH1pahUQ1c431yUzhjcZp59FPTmksiGzxMwtpveMQJdntxCAPGtpmECBb+/KmU+ROFvBo27xYbw8rUemcInlnKPmJt8ghiH6wRF2+vI2oE3O0IQJq9tVeMpVrNvhsf4/DcOqsFO7pcD2t9ewGP7cmZRujmv7qsEq2KBY5ILQl938FrVVOnuJvRvlKmMu+BFiLVvRUTSWv3WAFx6+nrb8d0OL6Kru/bi240IaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WEjTXMqCC69PZbl6xVoBkRbitk/6kv8PBqZTn/U8OI=;
 b=JdWDa7qOAEbAS1IkYIB73V1fqy+Ns9w4HdEkYi9tvdQyGMyA0GbZ9jSX07LxdHzQ3/U4AxqH0sMs/c0wjOMOEsf5fsjQTqhODukArEF44u61dhNuBS9txTZc5n1B2DyJeQng/KBMJa4ASQbjnz0vL4JVk0QcDiuYL/yosvrTXPA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:40:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:40:54 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@linaro.org
Cc: william.roche@oracle.com
Subject: [PATCH v3 0/1] fallocate missing fd_offset
Date: Wed, 22 Jan 2025 19:40:52 +0000
Message-ID: <20250122194053.3103617-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: b49cfbef-8a3f-494d-36fc-08dd3b1caf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?slPlIaJ+q3kABU9kSb0yK5RAEKbwFEHA0gvZ4AEZCO1pwWCzSeTXrptxnOwk?=
 =?us-ascii?Q?aBqxmiDS4YdpTVnht3laFnyTjAEfPri2zIenvD9HBbe4mJD7WuJ3S80woqgQ?=
 =?us-ascii?Q?4IydW9oTsxsLe3KUqA2A0uoVnMu2qj2ogRcD+m+hko1pxycgn/HMg+sANb4O?=
 =?us-ascii?Q?Fp8ww63I256PQBtYAQWLD4QwtqBJ9C0oqHVJ3YiZj/WgkCPWYLm234wnpyOP?=
 =?us-ascii?Q?HJZZCTVqL+u/OQux6qOc0LdpbkwBP0KmVxLNfTY7Avkebsw4wFl8vSWXkIzz?=
 =?us-ascii?Q?wsD7SkWokb4nKqZKL0ykpHxJOiHX08cbbnxZ5SAURnUhcgj7gOUkpZimoqp/?=
 =?us-ascii?Q?VBvB+0IsiTSIP3B8Xr9XZYr3pdP3ZqnY40yPzgjelg+oxOs2fS6fui0cThRV?=
 =?us-ascii?Q?V3vQmxYNczk3menbPsImhTjII8Ldn87IgxUF40v6Y+/GShlUWJBYcbz166b5?=
 =?us-ascii?Q?tAf/uF4aHn+3FqsIgMwcE7NcnsENkn9dG6QVLh6v29vrXs9VnTDYjRAQbX5x?=
 =?us-ascii?Q?9qYA5HfWE5daxXZkyyIuS8VNayCDaqC9GReVuu5QM3ysc2BfPA7ZAcSaTB6D?=
 =?us-ascii?Q?Uig4TnV2lNfusHbY9z6EEizpfF0z2df/uFBsO0+thaLJq9xE4oGGh3sNyS78?=
 =?us-ascii?Q?Umig3JiGrbqV3DRQfo5XAFFss9qtMX7Au8KeO4B8Y/xT5KWVAZ59lGf381GG?=
 =?us-ascii?Q?4PyXrIIblaIdK/O3l+Utldv1CCUh2KcGyHSeUr1x5wNpVkAwMQsbEDXAdp+z?=
 =?us-ascii?Q?yZziOYCFhANgFQjXKKtxrutj1jxQ/prznT9xKq/qB1dZfmuXjQ3JN+hpujIB?=
 =?us-ascii?Q?poHHveuJR3QOCpLRMvB/6uJbtEPs7b5AaMnsHMK5Cz0SCMMTjfJjwPvvmxGX?=
 =?us-ascii?Q?bqn0IImq/SPfbV/HTpzKOGC1jI4bv5+DBVSCyb5vkB28qZu/XvA+tTocJNh+?=
 =?us-ascii?Q?HWZ/o5Lt5Lm+Mj+miRQx0MqAs/qFGdGIH0UXi0IZGDM6K04FyrXE4iVqRMUj?=
 =?us-ascii?Q?3u79sexG77za6qXsqwGG0mAjo8FiQT4GrVXDzkQPZT7cvFoL51WRMja7yXyN?=
 =?us-ascii?Q?w82b/9YnMfQTEa3jy8RcS86E1AgfB17v7gAVT0F4Kc00OJgamyJdS2+0MYEy?=
 =?us-ascii?Q?xQGh4xrdeTBeh2ff0D1i9U824VWg+D/NNdud7dIzTVp9dyEUxZdeCRpOaqWg?=
 =?us-ascii?Q?GpvTP5VD9i8pbFaxdLFvCu+/ZGVOG+X2sIApW67/8oqHZnb2uOc3h0llTE/V?=
 =?us-ascii?Q?oMqIhx8UY1yguo9eEijqCcK2oNRKVSoguPLQLVyRbWdKnyJIH9n+9mK6PVpV?=
 =?us-ascii?Q?dw0ytHoI5gO3QsP04Nh+wPygHxW/W3oMA2alvhFZfgEATQY0GkFuByJA1h2m?=
 =?us-ascii?Q?Zyo03LGd38w8Q2mNj0kxh9rOyFyS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3CLgl/07akQJ0ec9rkttLM+B1yeyqxSHk9apbfIfMJ5R9N72zLLm+YRaqJ81?=
 =?us-ascii?Q?JjZcxuL0qsNiMgVpPG+qmTOhwTaXxzY7Bm8YIynJ60sAU5tO3cxl6xUmU+gc?=
 =?us-ascii?Q?V+x7TuInIuCHI7mwd9xqz1612JNDvHLyhSADWOVhvkuVA7zvpfs8OFlRfsiQ?=
 =?us-ascii?Q?iAVVWMi5OIYF6vdPKoS87usVkPuOuD820Bbfa5y+GunBMvk2YRzDRd+oRlrc?=
 =?us-ascii?Q?q2mkNMK4uSCOI9Ikqz5mL6c/Z9+gYdtGGVINoSgyS1uItKi1rTOCusuDfPMb?=
 =?us-ascii?Q?RPAnZrYcq/3iSOydkGK/NLjuTKJx4zeZf2XZImGf3cIxl5jf2W3HrG9pt89u?=
 =?us-ascii?Q?TrpjclkSHI1nLm/Ws36hbqoN3yNPP6V6YgeG92k0WfAqJejkt0IQYKuPsIIh?=
 =?us-ascii?Q?837q9Ff81D22+WLpUcPFb3HdxP6XKdT3MZYzn7KPLJxIeDnerz/25OzEEuxO?=
 =?us-ascii?Q?9i95EC1UANC0ngW4qpsxZjYj9dCbPLvgAjrdUC2Y2GDfyMzcFol9C8+44ifU?=
 =?us-ascii?Q?eRNLTQH6wgrLP9+sMq2wT0P7NPOn/7OFwx4t4LRfSsrfdU7rOlPmothgSWWT?=
 =?us-ascii?Q?bO+YHUkj/3dHExVn3wo8N0Dt8ODbXhx25b0zpzQ49g1Zm8EfNx6TnYzvqKbc?=
 =?us-ascii?Q?HKUoBJuZHiyOfDGFrxvBmr3Omlzd30RuQhK+XQlBkJeZVglUMwbHxmtrwnt+?=
 =?us-ascii?Q?2wDC00OdKHaiq70LWrAp707tgWf2qkMa+PFsD7bL3jcBqubpgnaRFHfelHy0?=
 =?us-ascii?Q?VFajCd9KRKPS12hr90mKgp3g5EcN5i4FGUmLOot1TBHXbCu93hNjLTOgIKvU?=
 =?us-ascii?Q?OdTQ+Y5Uy9CuFPzY7aMXCZisjNgaFVlV5I8yVqA90/38dgpdMhC1tRt079ao?=
 =?us-ascii?Q?AfUmSsXsIkgzlCNk48bQIQwcuq/xT1IpSB4L89oQFx4GP2I1ap6gd6TKOGcr?=
 =?us-ascii?Q?+ooDBxApKsq49KKTwaywL4ELn3v7U849xXh/dALCknFGrIjjdH9C4PNE8SAY?=
 =?us-ascii?Q?d0zgmpnKQWT4SR3L2rYcPIV1PgfvPIgF0aZRBzxDP9NWmFnPX6trD03ktmU1?=
 =?us-ascii?Q?gQe+zdvnoS7IU8/Rxd02gAIlKB2xQgISQtINb86QWmiSuq2Tk9KV9IhwdZT2?=
 =?us-ascii?Q?CzLv2qOu88/b7Fwm1nvja844LAzG2zz/XzqndLoQaf5+2WVKA5LGcpLEG9fX?=
 =?us-ascii?Q?TEKCL/E1S4zhP4SEX/Tzqnb5QTTBh7pdwmZ4oNpSlCnxduTNHrHQ8b1c/Kb4?=
 =?us-ascii?Q?A/gV4JPhkoKvqndItD4Jy5Pnf27CE7IRWxIVtPqLX7uO/ygnAfGBa4KiZZqy?=
 =?us-ascii?Q?ADDpA/13auuxXclnQ9G9YBvphqtIrtx6Y1Zi3UvVUsgkWI7WWzuax+CEhtzg?=
 =?us-ascii?Q?qdiEKik+FLICF1HoHkgBTj9dM90mBn28qCQTcrAmRp4e4Ba0whRCzwzGIHhL?=
 =?us-ascii?Q?4i9+WyJPYyE5ofqLeWw3qzSIs0tBJ/VdS67ScZI+bUgx4R7iy+sx8jgpl17d?=
 =?us-ascii?Q?0Gjm4SpGSDhz6cF6uW5E229/LVWxLOeQ8950dRR/6n820Eujpy1/8LWz6+b4?=
 =?us-ascii?Q?aehagbqqW+J8J6WZVGRt6KdpLcHsZFoG7Sh8woh3/PohKFzsRy6itS7lvKfA?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U0q+vuPxlzj+WviYAtiRsuLwa2alEJ4V/vaxCCRWuCRUuVigBC8X4wFmyKvQolkhkNC/UDKX+R1YP/ygadHy+8Wynxj2uSk+hK5+LNah2GnM95xlouZOWp2JVCDX9JjkHZRMk+vbXq2nAwDVk5zbk9SatmXDbE4XkOpbdiJYZ0odl+dorzyIOh5oguEnn4JkFh1PKNuqpRXle6sAfEIW80CC2KUN4viPHsQBQsI8oiS+aMHVBtm8AGyYch2ZCBiSmyw8W59FXfRmM2XoonqCedZBGihZPEx2ko2+HP9HSmIDshtPgLs32Bvz3A2JJkN14iMsFHKVxaRVl3MPQZ0//58wsaCY76O0bWbdSn/O0V0/9XS6RojsluaT3U1EopVCIjAs3B/AIHYetfpeaI3WrtkyGQd0CR58Bf9iqXKMIketd/DCygPL7s/+9IVxC00l2ohVvJLQPzJJbin6pFgMOXRmDEVW/kaKVNSYfTt/PQXg/BJTTO+8SHD07hrhsnABzYGhvgbXXy+saMYD/oLGMqUL2MpwsWkpsGX8LFg9uQksR3mqjHiSnVSLFuP0dYZUCEEnZNcqP164BbEaga3kbf8YQSBw7fcle5RazV2GbUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49cfbef-8a3f-494d-36fc-08dd3b1caf64
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:40:54.5434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTwbKNTvdEPivTIxCKiX3JjmkZ+NsccNH+FrnNoIwqfnf59ECWlpiVm57lHhStXqhaBKMLBpytKANUcIzPr5DtGiWrcSnLo4XvbSkHsuMW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220143
X-Proofpoint-ORIG-GUID: h4MaVOLWQUVroNd09hYZ8-y8lcmcFCvz
X-Proofpoint-GUID: h4MaVOLWQUVroNd09hYZ8-y8lcmcFCvz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.043,
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

From: William Roche <william.roche@oracle.com>

Working on the poisoned memory recovery mechanisms with David
Hildenbrand, it appeared that the file hole punching done with
the memory discard functions are missing the file offset value
fd_offset to correctly modify the right file location.

Note that guest_memfd would not currently take into account
fd_offset, so I'm adding a comment next the the fallocate use
in ram_block_discard_guest_memfd_range().

The version is also checkpatch.pl clean
make check runs fine on both ARM and x86

v1->v2
  . replacing the ram_block_discard_guest_memfd_range()
    modifications with a comment.
  . use a local variable for the global file offset

v2->v3
  . change the error reporting messages separating start and fd_offset
  . the local variable is no longer needed


William Roche (1):
  system/physmem: take into account fd_offset for file fallocate

 system/physmem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.43.5


