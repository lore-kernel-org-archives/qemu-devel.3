Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3841ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwr4-0006BR-Pe; Tue, 10 Sep 2024 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwr0-00067c-R2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwqt-0004HV-BF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8tX9Z002403
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=corp-2023-11-20; bh=iaEde3A262yS1d
 OGGNt2DtmWRu78P7dy5+H33UhdE1I=; b=RqbWYtW6DcwFgHb5L7yY1kU+icyyTG
 8Zr6UOBY0SVA0KikYHBWEuh4nylxbF8+IEw8mPPUEH3UfIWtf6WCeWuxkLJSF/nb
 YV9EUyUTdlJQjT2S3959kIaRvJ48pmBg/YZGc8p+cUbuKAmWnUBDARNVQKabTpAb
 7eF13YdP8UaN31MTOpIDcdjYTX5+IupqXtIPwlUQcdFR7d5GQBhh4QMiQi3u1Wqh
 nWLf/uBPOS0bBQHoj++UykL6QK+VB1S0hPCGJKVTDy5Eizm8QbFIGgSXQxwIVzXD
 yrAcEI3RF84sg9iJWSXnEkXBC5358XLrIIbgp/OW1qVce3kxvujulR5g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctd0mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A7NVsp019767
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9esda7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mci8I0aGfJ9y7KK+Zic47vAIMWrvBH8xqzHbHsnenB1n5VgXHzx01/k0KBJZbMGnUdhdCEsTnSR8S80VUZvU7k97m+I0TKRSD+U1ghvPpp2KTXjQMdRaCvxPcTjrG53ystn56MG2AyDtZ7pjve+UhuaeKlmbBe2f2uZCiU4mP6IapE2EYVqEuDN1U8E91dsixO9d/DZqBK6vU5jN5vnV+tNAZZOSF+NBQEN5diS3XUVpWTH25gxseH3KuXGbTeQZGCJobUJWDrZ4Pv+cM0B206hkLtlzhtaXdeR92MMi3hTq0KDglhe8OOZ5i0QVYm/e6I0ZrnvEMTR3eDHqUsqnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaEde3A262yS1dOGGNt2DtmWRu78P7dy5+H33UhdE1I=;
 b=qonm+dOysv6wINQbRObPdThw4Duixsm0wj4QHRazEfNmwvXIQQqyDpmNyibKAwwmkauoWDxVE/J82uhyP92ABGk0SSDPO/tOIBWyl03w8HvxJAuKr52mtilQrwI9ovql1fa0Q3mYzm3IsokGHEGA+E40oi6NF93sxEjayDJ1HJN8cMBoxMsaunIGSrl7XAMKM6oq6Xm/legdPzqoAEvutv1jWRSkNZNq4y+65k94mP3r0v+C97a5BLDiMvqf4l+ZpCQH+TsqfUurdKA/MkDEn3OJEM2dDkT7Q2dUW8dAvxwiSUfEC34x84Ke17CNEITUS7mX2FA84boCcnCJVMMY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaEde3A262yS1dOGGNt2DtmWRu78P7dy5+H33UhdE1I=;
 b=QlxsEKADPCGCEmSGYpOr6jfIt/2NBDK53bgz6ZhgkO4kW4nSluW8H7Da7D5U8jHRlow6nJC18nvQ1bDr/frWXy7plPsK0K2gcBUFGHJCd1kqzYD/XzmX0QWJWDKx/oL9ev1zm0qVIZYWDzW+4RmbLMjhJzzdr/D8LUyvI5C7jGs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:07:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:07:50 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 0/6] hugetlbfs largepage RAS project
Date: Tue, 10 Sep 2024 09:07:41 +0000
Message-ID: <20240910090747.2741475-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1154ba-2e21-4908-5bd0-08dcd1780b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fn3ZHqRTbI6R7f3ktTaO/GyDYhyTXH5PCTS5WjNtns5utkEr3Oi97cg0+fXS?=
 =?us-ascii?Q?Spu/woMixK7yYd9EcANHXUc9Cn3hxvYU0hnnCiMR+n+nDOFxcnnbqz3KFr3X?=
 =?us-ascii?Q?zUWaITn9wHPNVmmNVq3n11+mHA2RGdIJhjXdZOIDqBeoIfrpX51DBB8R2jkp?=
 =?us-ascii?Q?eRBNofRazPHA6o4cxJ9qKEm9XW/zgVRuKyT14gzHSI6Pz5ZTAzDUM+iKwSrg?=
 =?us-ascii?Q?LzxAerluTctnCpn444hwz2be78uJgs3hcDXRw66/4pN8NGeXSPh9PrXpLHvr?=
 =?us-ascii?Q?hyc+dAuhakjR0ok76WuGN+2vYhatMxIenCB8TrmMroh2b33LkT2HGd4//3TD?=
 =?us-ascii?Q?xMlNKDwBInGK2PoQz4TeJ5H5ybzereiq5tJ1u97zBHNxR26DC3tuwAZ97wsb?=
 =?us-ascii?Q?9OPj2NO6Ok3HI1RFntcZeqJCIPKQeBIPTGuHUWLtYvroyEQOmBygCxoOhYy5?=
 =?us-ascii?Q?Rpe1bOtin8z+m7+r7M3gOAmY+HUmcopoRRi2mu+rzo0+1WbOJt5gNnfkrBLl?=
 =?us-ascii?Q?RyIe0fvypl41+OZ6pA4zLkYmaRMuWmHXUWPKhyHFC74nZyYMi47RnS6dSNoD?=
 =?us-ascii?Q?busd4Ku+1ww7JLedRQTLojoOaTet72Ye38SVHbUIY7xTmFVkl0Z5daekVTTk?=
 =?us-ascii?Q?jsB8GtEbk0VSnrwwSQe/pS89K2glI5YFrlJxADvwziiBRaWQx3A+wyMY43Wx?=
 =?us-ascii?Q?5hPeDu4fTRs4aq/HazCDBWhW1UsFphJZ1GcboR01X8YpYMI+6Y9eebS4+Qep?=
 =?us-ascii?Q?4ULvXOoqlAPO28wsXpQLA0gbbKVpMMsM67X0PI/xRLQOfPTpRXoCmtEmCDPH?=
 =?us-ascii?Q?qbq4Y3H8wslk927mXqkTBWcpvaKCQ8K0RjNl/E+vp+gbzam722heiU/RM18m?=
 =?us-ascii?Q?qtnbDzqfedav0U9N8D8bKLPicJHA0DrgzPZ8qsuzDPsUAxbnsyzDWE3UyFre?=
 =?us-ascii?Q?x7sulGfWiF1dqfguWve7HkXizTja9/AaDpkudE9Ubmc2CFqApSonQ8M3iXAA?=
 =?us-ascii?Q?UEBb6C2rCjoztxmkWoQa6SM1tLvKf2HdxYBJ20PPp2hYWx0TEFGxbqLqd/aZ?=
 =?us-ascii?Q?iV+3d6bzbpDlDGgA/z7OX9JbENDMKRm89hVQRryCLRhNiTbw2jSfC0XQL2XZ?=
 =?us-ascii?Q?PYp2ew6jpoqQ2nnFtMwsBFqJcmM/hKTI41Oz78pMpZK519gQtMtfUIPSf0U/?=
 =?us-ascii?Q?oR10LPS3OHbQm3I8dS+5bvndgtsipnf9ELoTHWBMbUFV80eZQi+Tut61V5Sc?=
 =?us-ascii?Q?UbBVnGcdepBC3Gl1E11N44GZ+bUy64jbbEmSWgn6WOMkPX1cwrpQljj3XvPp?=
 =?us-ascii?Q?cCwjfztPNmAYxUZVOaO6xmG5O+fsnKN6PU7rdxGhOJagkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSF0y6Kp8cyK0DXWJsvfxIDTekcK2EdXtJsbgH7lquk31ZN2Gg+Ww0RoHigw?=
 =?us-ascii?Q?GGhsKW3ItQAxX9Awhkgaj1SG5KlatW5OxXqM9bXdMNxVwW5cmxDse3rZYB05?=
 =?us-ascii?Q?py5GBbH8k3PDBfmONbGGoCeSITvuGLfUNexDXP97+ai0UwC/f5wGaE1ocir4?=
 =?us-ascii?Q?OKXS1htkJxsNgtvnHZEZ0opf0a990h/I6B2C39fVC9bNpWiz2T4zlPhANSeO?=
 =?us-ascii?Q?TVdBlPxHGW/XcdyAT9mfy19bDP5RCnRaM5/aCvA8dCyaZPXznvCAwEKDMqQ1?=
 =?us-ascii?Q?M5bToI3H1d6xzFsSqg4QxFiwTLL94ehDnjD8hAOdIGRMmsH/14VakLrxK3zQ?=
 =?us-ascii?Q?LVnjbMnlBQEq1ZIhX8Rckz3YkyFMWdNh9rNCK6i+LiYYoWd6q2IVryQc8j26?=
 =?us-ascii?Q?7N7GK8H3bB8QqebBPDLGfPRrzSmjMhL5YUvVYChnp04/r9d3V/IC+PO2A6FK?=
 =?us-ascii?Q?MD2wH3WzCHi0wUFcFGpvx6TGZbugb3E25T+4Yavep4pyUOOqXo9gQXxe1s8F?=
 =?us-ascii?Q?+ZsOY9scgCD2bGUIPAY8/8LpjAz3ZyuWACdhb6e/msUvDSx07wK7ezmUALpS?=
 =?us-ascii?Q?xkqVc1WFKSl/sjwErKVT6uUOHv8UvkPtvWd+QjIHuS3miCLyGaaSQWH96feI?=
 =?us-ascii?Q?/T3rU740EVaEe67qoRXFw87kMjVGQTX/OQDayKeFczf21unXSzrnk5l110SL?=
 =?us-ascii?Q?DpuMZUuzGgBhRABtNZNWnpBSCJJJF3FFOROEaMDlYNlcCyUHVgQY3DOoahHE?=
 =?us-ascii?Q?rmS9IlGLR3+7aFYuh9tYpkGnicPu4CnJFXLiQGal/pma3hPnY3UYhcS1kdoV?=
 =?us-ascii?Q?qqgqnZ2EnbZ7J/U/kWQjgYbQhDaC6QS+ehonW7L0ZreOVbgp4CCeaJd2LbtN?=
 =?us-ascii?Q?Sfk9REHO64YpWn0RQKEpvP3/h9JlCucMrbnYWSnVv3tQe9P+Z9iXBL+biSgd?=
 =?us-ascii?Q?zbMd65KxT61CB4FltN6PLUUnMYblx5Dern+dK2PQwvqvgkBqgM/3+SrOlQdq?=
 =?us-ascii?Q?liLSYOMMmsfgYHQb6m3VUW/H1SeGZMllqFGG5sEE230r7JQ/R2SinKLyqwnT?=
 =?us-ascii?Q?IFty5DlQMbCSLCAMGwR74fY8+iiXtkbxAASiNyQuoH6oUtVJKre0ro6vRlYu?=
 =?us-ascii?Q?1QIxKb6/L6MFoaoU+b7A51JbJKH9hnq4Dt53WBbaGVvUGkHmLLz+BJUF6TU3?=
 =?us-ascii?Q?MhYos6mwat1tSJL1OEL8boCfaXJLGjSZk5fukjCwJyveWXgAS6D2X2NG5O0Q?=
 =?us-ascii?Q?ylrjfqlTFal1gC1JmAXwAvvJH2WbAuyKumbgJy+pkT/dtKCGobfyyCHdGeeV?=
 =?us-ascii?Q?GGdjfA7/aqGiFD9aKm5cPq9oD3PH8OdiRv6TRyQOOWJXgUKOUvNZFsvjjWqm?=
 =?us-ascii?Q?ZqurVGil38JMjE5pY9UDMNVsw6m7xVrcAJkBFXqbq1T5VEu5fFFUubWb+tam?=
 =?us-ascii?Q?Edjsex7vdw+ysCmsGkEhEM4WXOlC/XrAyDjJjCFCySW0eEz8VxJGLV6x6/Zo?=
 =?us-ascii?Q?hfrVFQ8cAYUrKCyOQkSJF0AJA/d6UViY3ZO3vJFsq1DQRmIXFzcWKghNIfa7?=
 =?us-ascii?Q?z+QKbcmm4hU4yBG10ByyX6lMMfviQRMlm8eE1ge0nUK7qwukcFf8UtA+9eMM?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jYGOCLOnTnb+qtTFDPeMgZrz4MF9EW8WwFFTO5StYKS5sUyEMN8ibrbz1ogzfrCrP4hQjOGqwWlRYSHqnsNZPCrIoWOiOH0HFV3hrhPw1j1Ojxg7z6OFU8KdfwVSUBPD35lf8HJaHAJS6b93CfmzrypKq2gA7z94hTvjXrS6UCAIzjC7oGnNbjAcJj0z4O1RhZw8bJf86dZ7B6tGPGLZqpRAZtSoSyupo6P6J5i+3tEBw2h+IxaWkYIXIzJ7pWgnc0lK0NYXu0R2XM2BfZk/2ZHMJL220GSEQSqniQUY3TlEyk1Obzi76K6Zfk8Gl9HP2AYWmJLmBB9YGR8Z5Pw3Z0q5TFIXpRf56V56ipBm5Gfh/+8t59PiVxJxAfH6N2eX0sJHTh0NdFu4e2xy+ae6e8u8/+cNXX5DIdNWPQBpvjMaLvje2V8dus0PRoE8SunuN+UqCLKBIQmXB9wxtZlZCbPYQB6yRBIF1F4egeYJjHdyrGJAd7823/trLLuujoMo7yV3H3JlNyKBuJrzugewstGcNn3PMVd4aEx1dmphDTcrldQUOtvH3/iOf/aE1NvwvlaYAJ4gO67K5qq6oFuvVOlDk8ThFKE883utzJkAGto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1154ba-2e21-4908-5bd0-08dcd1780b68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:07:49.9938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC0JBeWr//Tz5DSXPbnAmjNtHJqpAuCXxQoKgu4V1oWmAKzQft4GhS5kYR4fdHCxF+b0dAQPFZFvBZOCA6DxLb7k090SBcDQzVppuczbTKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100068
X-Proofpoint-GUID: RgO4IMyYjJrIdiU3tuUiJwgvOHKFPuSf
X-Proofpoint-ORIG-GUID: RgO4IMyYjJrIdiU3tuUiJwgvOHKFPuSf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

This is a Qemu RFC to introduce the possibility to deal with hardware
memory errors impacting hugetlbfs memory backed VMs. When using
hugetlbfs large pages, any large page location being impacted by an
HW memory error results in poisoning the entire page, suddenly making
a large chunk of the VM memory unusable.

The implemented proposal is simply a memory mapping change when an HW error
is reported to Qemu, to transform a hugetlbfs large page into a set of
standard sized pages. The failed large page is unmapped and a set of
standard sized pages are mapped in place.
This mechanism is triggered when a SIGBUS/MCE_MCEERR_Ax signal is received
by qemu and the reported location corresponds to a large page.

This gives the possibility to:
- Take advantage of newer hypervisor kernel providing a way to retrieve
still valid data on the impacted hugetlbfs poisoned large page.
If the backend file is MAP_SHARED, we can copy the valid data into the
set of standard sized pages. But if an error is returned when accessing
a location we consider it poisoned and mark the corresponding standard sized
memory page as poisoned with a MADV_HWPOISON madvise call. Hence, the VM
can also continue to use the possible valid pieces of information retrieved.
- Adjust the poison address information. When accessing a poison location,
an older Kernel version may only provide the address of the beginning of
the poisoned large page in the associated SIGBUS siginfo data. Pointing to
a more accurate touched poison location allows the VM kernel to trigger
the right memory error reaction.

A warning is given for hugetlbfs backed memory-regions that are mapped
without the 'share=on' option.
(This warning is also given when using the deprecated "-mem-path" option)

The hugetlbfs memory mapping option should look like that
(with XXX replaced with the actual size):
  -object memory-backend-file,id=pc.ram,mem-path=/dev/hugepages,prealloc=on,share=on,size=XXX -machine memory-backend=pc.ram

I'm introducing new system/hugetlbfs_ras.[ch] files to separate the specific
code for this feature. It's only compiled on Linux versions.

Note that we have to be able to mark as "poison" a replacing valid standard
sized page. We currently do that calling madvise(..., MADV_HWPOISON).
But this requires qemu process to have CAP_SYS_ADMIN priviledge.
Using userfaultfd instead of madvise() to mark the pages as poison could
remove this constraint, and complicating the code adding thread(s) dealing
with the user page faults service.


It's also worth mentioning the IO memory, vfio configured memory buffers
case. The Qemu memory remapping (if it succeeds) will not reconfigure any
device IO buffers locations (no dma unmap/remap is performed) and if an
hardware IO is supposed to access (read or write) a poisoned hugetlbfs
page, I would expect it to fail the same way as before (as its location
hasn't been updated to take into account the new mapping).
But can someone confirm this possible behavior ? Or indicate me what should
be done to deal with this type of memory buffers ?

Details:
--------
The following problems had to be considered:

. kvm dealing with memory faults:
 - Address space mapping changes can't be handled in a signal handler (mmap
   is not async signal safe for example)
     We have a separate listener thread (only created when we use hugetlbfs)
     to deal with the mapping changes.
 - If a memory is not mapped when accessed, kvm fails with
   (exit_reason: KVM_EXIT_UNKNOWN)
     To avoid that, I needed to prevent the access to a changing memory
     region: pausing the VM is used to do so.
 - A fault on a poisoned hugetlbfs large page will report a hardcoded page
   size of 4k (See kernel kvm_send_hwpoison_signal() function)
     When a SIGBUS is received with a page size indication of 4k we have to
     verify if the impacted page is not a hugetlbfs page.
 - Asynchronous SIGBUS/BUS_MCEERR_AO signals provide the right page size,
   but the current Qemu version needs to take the information into account.

. system/physmem needed fixes:
 - When recreating the memory mapping on VM reset, we have to consider the
   memory size impacted.
 - In the case of a mapped file, punching a hole is necessary to clean the
   poison.

. Implementation details:
 - SIGBUS signal received for a large page will trigger the page modification,
   but in order to pause the VM, the signal handers have to terminate.
     So we return from the SIGBUS signal handler(s) when a VM has to be stopped.
     A memory access that generated a SIGBUS/BUS_MCEERR_AR signals before the
     VM pause, will be repeated when the VM resumes. If the memory is still
     not accessible (poisoned) the signal will be generated again by the
     hypervisor kernel.
     In the case of an asyncrounous SIGBUS/BUS_MCEERR_AO signal, the signal is
     not repeated by the kernel and will be recorded by qemu in order to be
     replayed when the VM resumes.
 - Poisoning a memory page with MADV_HWPOISON can generate a SIGBUS when
   called. The listener thread taking care of the memory modification needs
   to deal with this case. To do so, it sets a thread specific variable
   that is recognized by the sigbus handler.


Some questions:
---------------
. Should we take extra care for IO memory, vfio configured memory buffers ?

. My feature code is enclosed within "ifdef CONFIG_HUGETLBFS_RAS" and is only
  compiled on linux versions
  Should we have a configure option to prevent the introduction of this
  feature in the code (turning off CONFIG_HUGETLBFS_RAS) ?

. Should I include the content of my system/hugetlbfs_ras.[ch] files into
  another existing file ?

. Should we force 'sharing' when using "-mem-path" option, instead of the
  -object memory-backend-file,share=on,... ?


This prototype is scripts/checkpatch.pl clean (except for the MAINTAINERS
update for the 2 added files).
'make check' runs fine on both x86 and ARM
Units tests have been done on Intel, AMD and ARM platforms.



William Roche (6):
  accel/kvm: SIGBUS handler should also deal with si_addr_lsb
  accel/kvm: Keep track of the HWPoisonPage sizes
  system/physmem: Remap memory pages on reset based on the page size
  system: Introducing hugetlbfs largepage RAS feature
  system/hugetlb_ras: Handle madvise SIGBUS signal on listener
  system/hugetlb_ras: Replay lost BUS_MCEERR_AO signals on VM resume

 accel/kvm/kvm-all.c      |  24 +-
 accel/stubs/kvm-stub.c   |   4 +-
 include/qemu/osdep.h     |   5 +-
 include/sysemu/kvm.h     |   7 +-
 include/sysemu/kvm_int.h |   3 +-
 meson.build              |   2 +
 system/cpus.c            |  15 +-
 system/hugetlbfs_ras.c   | 645 +++++++++++++++++++++++++++++++++++++++
 system/hugetlbfs_ras.h   |   4 +
 system/meson.build       |   1 +
 system/physmem.c         |  30 ++
 target/arm/kvm.c         |  15 +-
 target/i386/kvm/kvm.c    |  15 +-
 util/oslib-posix.c       |   3 +
 14 files changed, 753 insertions(+), 20 deletions(-)
 create mode 100644 system/hugetlbfs_ras.c
 create mode 100644 system/hugetlbfs_ras.h

-- 
2.43.5

