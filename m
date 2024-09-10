Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985C7ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwr9-0006Mn-FS; Tue, 10 Sep 2024 05:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwr2-000690-1L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwr0-0004Hu-CB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8tZNe002423
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=iUpJfFkmzvcResM42CgeM3OXvVIAkS6DqN2a6mWjScg=; b=
 FMbE3HIOMm8HBhWuhhfHzAj53rFgU30ytjYemz29q9Xx8+x4lxskKQnzzfry9ah+
 U9H4soCC/yOHVkCz8RwJu+kNfWuukAmYK5WUS8TDxmH61nbxAgN/fJZP5YGL4rWf
 2ksUr6HqxQ9jlaKGGTzx9yfigOyrIuzCQ7RKUj+iKwmCRbChING088i/jJvQ200L
 aQwHT3dWajpJQ/nW1qiz3sU5uk7iPe2nhIkoTL1eNZT6aF5sOk2BU6S70KC7yNZo
 O1ha3/bZmSmMn40Y2C3P+akvTjp16ENvXLNuwWVFhJ+2LWbyLZ0idRZSIJuRTThQ
 Llcc/SuyBC48MmI4yf6piw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctd0n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A8j1T5006205
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9898dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljuja7oc5Ezh3JCGAq27UPv1l7HS3feANmX5Gk1PDwMA/jLu50MPIdy8Y8dJ9cIjqkd399Ef4YhstL05/M1HzrKOEwB4JQM5fx6r6QxhqB1Fuyn1Kr3J1yLQSvkwQWMlDUDyXaiewH9T1lRA2O+V5awp9gQRu8rOx6UtLNFH6ifZIFGZIY629Pw52eHEw8HlcsxYGPr0J6E+UI0hgIa/nl3UvgrgmCnB0XqOkrh6I/ufkMAxFx1dhYUrUVYcZvJGS38Cm3ENkRDzAA3mU+e/TcRqNcosfqDQ1j0uSme8XQUivuNBvQYiurMAQZ3e7tHmATA/20ZPi29iPPhmEUwnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUpJfFkmzvcResM42CgeM3OXvVIAkS6DqN2a6mWjScg=;
 b=MqaqikAQYywd3E7Wmd25p4EWt/f92Ufc0Nq/cdIPk7ObUlYrAI9FlwEpEFG6Qg+36b8stHXeyyk/apMeOF1+N9MsSnUFpc9JzCH9ImlQ+WJFgcQYT8rFRsMipccylTwHs/kVYmvrw9F8UZaR2C6c4/P0LDnhKyYr0U3lG5Q+AaiNwPnCuD1JFWsh1WKzSC0MJBmcBZaYwnwbroJVESR1/iv4InAyXYM5tFmX9+OXwJnBf5+0Q6aN4dSR0j+WQSJKhUFKeZYIMdtqjWUaJ8r+0pigbxlCgaTvkUCFTafX0kuMr7UsX9ZTUEW8jBRUx4VJz2S+Z3+0kFvntP8y9sCeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUpJfFkmzvcResM42CgeM3OXvVIAkS6DqN2a6mWjScg=;
 b=zX1fKwNu4hDWFpQO9j1g+qK4eTFvJz/gP4gYPQaiALxKB9wuEr3rHC8HiTPNi0ok9ABrwiAYVllSFc1suewXSBPxSJ1FBOg+nnlOf3He5DmBxGFdwrAsVDhUUN/xVA8fkPISB/SqIt3GFUyiGqDQXC/v8buhp5jBCIgwo8RNVIk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:07:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:07:56 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 3/6] system/physmem: Remap memory pages on reset based on the
 page size
Date: Tue, 10 Sep 2024 09:07:44 +0000
Message-ID: <20240910090747.2741475-4-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910090747.2741475-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 258c3698-79e9-4cee-36cf-08dcd1780f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Eg8FkcKCsLL8jMmOd7zUdDVAU0lSLAGJGH999dLg1H4BG9TZkHlGSUWzhelW?=
 =?us-ascii?Q?8D0xspavkqiIkCnqenLSV7kbJWCTGw+WZGLGaQYpeQ7nHbWnuvaSsFvLBMoV?=
 =?us-ascii?Q?tgkkbAuWjdf7HecBvRNoB3dkV01o+afk3h13ZzKSlMXHfMpG2cdESIArQnpr?=
 =?us-ascii?Q?e3IvojpCOKd/7Bzz6ukfGvttQoCQKb7CZI8109Xy84SYkUm6F4n3K1z62GZz?=
 =?us-ascii?Q?aweUzNAhya54SvQyHpfOrQl6Eg8xiYRSJvMAWHwbOxMcjAaS1bmIiskTgOdN?=
 =?us-ascii?Q?IM7eWf0iuwz62Zv0DdlEH8IlU6BydFKBoyUGS5Va+XAV+GAC0MChCcJJdquA?=
 =?us-ascii?Q?CYXOKbsSy+cMxmoEbJ7izP9weancCpB3PN0etO26QZI4cDXMOG4mi5DAbQxq?=
 =?us-ascii?Q?OtVGkHXfpApB+iQSnoz7X0dEWpZpmldvhl3sarByXSxTQomUw2TDzjYhycbn?=
 =?us-ascii?Q?PfBU70J6OnmyudO+5Cl36Q8Zk0TWf0m5hTYl2e/oydeuWPpI2alIPLbcZ5q6?=
 =?us-ascii?Q?CpbvLd8wcAia4oW68Jheo+kV2xnkYd+4cgFq+a2H8/p7CCcsGMolvzfIkSFC?=
 =?us-ascii?Q?oHLEUsRwXdeNnNa5eTGu86TqYEOPMpt5slnFHpF9kiFULx6uoYznsi2joXBA?=
 =?us-ascii?Q?4Pc8v6Jlc7LgZpAXxOqEC/Cp6VJhH+suxx7xroSGTzpiUnUeuvkKWnYXU2xX?=
 =?us-ascii?Q?uZkvhXKp2SnvR1han6qMtD8ptuMAvrdqIMsrRyju6MKK7j5PNtyJu6ta0xLR?=
 =?us-ascii?Q?8Vb8fDw5l7WxODijsUwAQygyMP5tOC+TtUj1ta4hXJ/Zd8HuKWSWAptn/vTi?=
 =?us-ascii?Q?guAmeLm4LBQcClWE1koion9gWirnf7jhNQNIoWNkAa+/VrrKmnDh+BLKvsUj?=
 =?us-ascii?Q?M9SHPzceV0ayj6wtbLcaeFcfqx/KOBXNG5b5d242Pn+xwcBayWivfY8cL4Pc?=
 =?us-ascii?Q?qhGKW9QI+jzQmclV5bv3TSXCOVHmIt6EwCpZ35EcJuFBlvfdOnWovpNztrBF?=
 =?us-ascii?Q?TdO3ivM370baB549ZIobXaGS4FzcRo1u9Dades26r9agG2P35zxnzAJ4YFh1?=
 =?us-ascii?Q?mneZD5owvb9u0iEnWQwIfo3hGpjIGTR4H0SeqwAUXsNSxFwBifhqdhs0wI6j?=
 =?us-ascii?Q?k/KyXPNI+pWyh7Hrgix0xMQ2XgunkEk1Ajd0+a007V4LiFXAVIjoRJfm8+NC?=
 =?us-ascii?Q?8sXOsNg0okJLgHBnAn/4yRgQAKLNjn+36vwC+IPoAGJzBaPzeo/bLoXHBQlz?=
 =?us-ascii?Q?h4arXeSHhG4m2OsKy1JCmx8RlPtnPYs82mnLIXhasRgMrNBUy5Pa7dAYc4h0?=
 =?us-ascii?Q?b81ylh5PVNGagteyCDlgNoCzNhb7usd9gi8Qe4nSEuBnTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ainwrLeFVwJGN/fWTwraYnFKtUm0+/BB8NG/h/0GYwTEMLon+3vv1quhFq9?=
 =?us-ascii?Q?/Q4F2UW7+y23+XgyKlztcespG7ez1cBUiSTNPy+HZCW6zbf6ckHpP9dWI8WP?=
 =?us-ascii?Q?rUxcdkJjMPKrftD09k8G5Qsib8KvXerIrAjHfR0X325P3ta7BffuhaAvIo26?=
 =?us-ascii?Q?l1MG8PyQx7yZhkb8AaRKa7RDuy/Q8RfGIRPUUmd4h+KBb6YAX0oF57cmQydT?=
 =?us-ascii?Q?y15+bP+Rtm8yJ2bcoPQX1vzRjqBU2RrWWjBIqeK16n9t5efxKKBX61iByf2n?=
 =?us-ascii?Q?aVdxsn2kGqh9u6dMNCWWoRV3eZ4bbpRZQ6NHDEq6D8K0gZ/LlybT5o9CBMU8?=
 =?us-ascii?Q?sz1i9+RNk8HYkyrh8Kx7JLliw9AQT14H3HgOyLasD98K/uQsfCXp5+1vPAaP?=
 =?us-ascii?Q?QKh9QR6lH+ReK2uZJKae6ekMVRl4NNPviGYk8VLdLN2ESTiuA5HPyfDhIW8B?=
 =?us-ascii?Q?k7m9J6JkK5HIRD0Lra2lfotlRv+U3D31XtBjdar7UZdKqJ01LC+ZbTGH+e6a?=
 =?us-ascii?Q?rGwgZax1N1P+O8BdBTquC2HDXyWP+0/QG0yhirDTAPJZXJ2hg/PTN/YkYREz?=
 =?us-ascii?Q?txCesSXYsEUg4gLi6TAyW8+gxIYnxN2eprS22Rw7BA9/YHd1N6iET4qJKZe1?=
 =?us-ascii?Q?fjVM63GjEkp8yJFrE3VWv6L1rGmqNwTcg5co7JCWmY/Gc6qSi/AaT3WR13ck?=
 =?us-ascii?Q?44YT0gojNfZKNa08aIwEwcvfFSGsUQ1Mr+BSDof6KsRye6s0kcMu5Xc+T/9M?=
 =?us-ascii?Q?DmhGd37e79v6fFWPhuNAa5O/dfektywOgihhbcfiBysiMdzXZKxLyKGxswaH?=
 =?us-ascii?Q?+ESWZX4YM723pNJKCKpaQhWe0zAtdWdKu+rBK+bi8aIHP1+DAl5iidSFtT5E?=
 =?us-ascii?Q?EhvGInoTvFTUaM13GOpqJr3Rk8KIpauUnGS7LZ8a0lc+UEtjySBp4N9UJIYt?=
 =?us-ascii?Q?hf1566i3Y4U4nSJU5Qeu0OoUwViB5pUltQ2d0eYcw0rccN7TkjhdaOZxt4g6?=
 =?us-ascii?Q?2p8l/+UFyYUW74tm3xGzp0yVO3OPBFvzkbJ/PnQOOS2eBaBN8jQeKCyYdFV/?=
 =?us-ascii?Q?F3r3f06nV0Z8IwlATzh3OAFSY+cD89yr0THp36yYGdDhzdmvFohrr/6e7MXi?=
 =?us-ascii?Q?GD7sJSLUOS07QVveKTt+ZR5n0u2r13cQAXnN6M+42AiRvwrSwjV9EyJARJ28?=
 =?us-ascii?Q?ZP0XoLoOiLlXjRhm1d/m94NwJdJF/dOLq8izv3wD+xSJLWuw9h8BTIzmhuWH?=
 =?us-ascii?Q?Oz0TRtF9nUz+lta5siJGZf32G4JECcNFEG4s5a3YDDhbyqk0TaZz0Q6ivHMV?=
 =?us-ascii?Q?J+er+dqppjaEbHARE8xj/ugh6A8D2ZKuH70h2X2nJhFeOWgaGaFxxasDPAFZ?=
 =?us-ascii?Q?WcrJ52gYoYyC7daqR6DvmE/I6JePr40uH0xF9ao0EgxZQ/iCJQXNyN1C+oUz?=
 =?us-ascii?Q?ORWhDf5xNt4o6fCkajSAx2hn0tdh7AOW5q5yIxN5c0Zt/Jg75sssLLRwgYX5?=
 =?us-ascii?Q?7l2EqkT70kdDAQJ8y5anl04/qHjXYU9ssHZeTbHV/MAJzVnshIZLWN76zPL9?=
 =?us-ascii?Q?AufAgUBCtabGI4kz1X36n+JYFZPSJISh2WROZAFipfL71OBvKzsRSIVWD/J+?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ppi35nugdvttUINiZ5K6Ymd9y93r0gJgbUO/ENwRlsYLWANGQ3R6Pqg5Eau+pth+36eTdxkA49UckMZbJIAgG6YBoJbnFX7DRbOxtOTe1x9/IbwWR1d4Yhk+/lLifUJOaei5BiiTBtmgwVM5pY3yjXPnwDFvSpbZJAaMurnX8VHQNBlo+hCPq4MxEMUyzK8LgCef4DoD9hPdUZ99E45n0qZXQSZ7QccdBa81q60sXTyh1kzC45RZL8ZS2faOEJhp+jeKIZ7mq5/jqOVfw9kdQWsw+2P+g6g4RTvHu5NZEO/wDe01a7mtJ7Vb2jaN5NUez7l1zyuAAoDpPvUqu7E1VIKTZX6WFREztlI71uh2i63oORl0rWc9bgLlsaBqvHHcIFhkKicjUwEFTIx2uk9AaYQyd08AsnoVHonL9GNmn7vIIZD0T/5aaARpbFAYaB9AF0zvh7kNwaUu08PXlJ/9cU7n0oLozveVY6iRipnmcd3DvRwxKCrRDYUYIFE0mjUS18HW5ADh+YTepoSdl0GD+SRrbDu5NM2slctd/fcOJFb6p9E7AxYAbKA5F2dVLoE7J9T3+CBjYBILy9U7imH+cQJ+4MgEQzUrCyz7JNN+ajo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258c3698-79e9-4cee-36cf-08dcd1780f70
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:07:56.6808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqQxxgEBcSx4MjavdReb9lj3voFqoXsKVf6HSkQv6SvQku4lmcki1r6pnLH9d1tBGzYFLWQnFrOGOVvL2RZ3yC44Q6SeKH2o3g6hfzdTxmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100068
X-Proofpoint-GUID: NncZa5EChgctiqQ09YiMqhw5G_r9Dbti
X-Proofpoint-ORIG-GUID: NncZa5EChgctiqQ09YiMqhw5G_r9Dbti
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

When the VM reboots, a memory reset is performed calling
qemu_ram_remap() on all hwpoisoned pages.
We take into account the recorded page size to adjust the
size and location of the memory hole.
In case of a largepage used, we also need to punch a hole
in the backend file to regenerate a usable memory, cleaning
the HW poisoned section.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 94600a33ec..5c176146c0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2195,6 +2195,11 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
     RAMBLOCK_FOREACH(block) {
         offset = addr - block->offset;
         if (offset < block->max_length) {
+            /* addr could be a subpage of a former large page */
+            if (length < block->page_size) {
+                offset = ROUND_DOWN(offset, block->page_size);
+                length = block->page_size;
+            }
             vaddr = ramblock_ptr(block, offset);
             if (block->flags & RAM_PREALLOC) {
                 ;
@@ -2208,6 +2213,14 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 prot = PROT_READ;
                 prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
                 if (block->fd >= 0) {
+                    if (length > TARGET_PAGE_SIZE && fallocate(block->fd,
+                        FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+                        offset + block->fd_offset, length) != 0) {
+                        error_report("Could not recreate the file hole for "
+                                     "addr: " RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
+                                     length, addr);
+                        exit(1);
+                    }
                     area = mmap(vaddr, length, prot, flags, block->fd,
                                 offset + block->fd_offset);
                 } else {
-- 
2.43.5


