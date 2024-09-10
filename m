Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E708ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwrq-00006t-15; Tue, 10 Sep 2024 05:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwrW-0007to-0m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwrS-0004J8-SE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8tZZd008924
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=6zRKVP0wxYzEad+yxt0t268SLIx2OcpPGkov/2Pn12M=; b=
 J+eu4MyxSGPSsKyWxa0N9XO9Goge9HlAdkuzVFMXYT++hGQQkBpT7EOAkTYeDi3Z
 GAWEKZdmVPfMGHy/B7SHEYTi4zoKZVURxTJ1j5kWw9i/SYIxWa0hjgNH2poq5ECF
 mcPG0Y5EwcxKyab05XFKnAmbXMi3EhNKJMdNZgR7Z17KjARypg2ohoSuxJ7XKILx
 61pdygwFceS868AtiRc3IyVE5r8dwjZlwu/9ZzsdyE38/NAE+GCBjBwpriQFBtFO
 KPrE48eIDffNAEmplk901ya8+jdP6h/84ZBzjWTE2WSlzpKQTXZgdKGINNgmPfel
 LfhiPI7akl9BU8AOKst2sA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9n07u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A8ao8S005070
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9898f7-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYBVtjY4xfdtG+fdZLCNlOHTdZ30UNRcwOT4Nqj3eYG7YJSZleYpT+/TNt7pmrNWiaGTKrPbuZwn8BFycNnOlC9NrgdlOkMwQkEGpByUdn6ARAjR95VX5GLx06myVQobCXFZDExkXBIe1lqqHpngavTPwijysw3fukvcPjn2DqN0PVc+7d0SXxqZzjq/1jRIT/YkdLdbTHpV1CigkIZW0bPIBoYMf/gvPg4XmQ+bpAud9wTj3wr0PGPtW65NYHWYjpt74t4YMkI0t2FENDlXgNDCqlR6u0f0HzHhcPICSgQE/JjcKrDSv8ohjW5d5SIR2IagjcooE2Y0vR0whJSJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zRKVP0wxYzEad+yxt0t268SLIx2OcpPGkov/2Pn12M=;
 b=flSU+nL7PbJlk50SthsdbLb4Cs57mcbHboFKkJgX/02PWEWp73QOJV0yX7mZt54BzfW8wnHaeVpPcsmPK3K54KJbko7lsqqGZ+20BcMNeT0ulaFc2bbYFbBiUSjKu1WULrNXLxCDdTxPBnX5IGBRuKGw/r6o5z6F+qG5pvF8dGrWYjvekebpreY9TO06P6T+AUahGY65HfAb5jWpBHDFyc2thBJ9ZXdI9lCDCdKpUzJnrrImLm6L0VqmVlgSLJrNfsu5JyBRl5eZBuNMc5+zuxDrpx3GDH1I7u1zFTzr6t1N/gQADhCCgw4aRM2BYmcQD4F8XC79d4BENnf0s1AYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zRKVP0wxYzEad+yxt0t268SLIx2OcpPGkov/2Pn12M=;
 b=yZ53M1QSnzc6uGfhb3lsovdFq9CvIN8HDpXnoYXk1ckQhNiuXPW6cTAQ3E7l84SB31nLD8zvWz0sH/NZDGA01xID/ziTG+V9li0bwhnSc2shvG3FSUmPqAmqSExPsVoG31A+NQksBAbscdMmWUMT3Lqa5LlFm9b5TEhyQOAiAYo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:08:03 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:08:03 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 6/6] system/hugetlb_ras: Replay lost BUS_MCEERR_AO signals on VM
 resume
Date: Tue, 10 Sep 2024 09:07:47 +0000
Message-ID: <20240910090747.2741475-7-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910090747.2741475-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 688e1f75-be63-4cf4-1aaa-08dcd17813a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P9fMdBl8LiogQHjdVms+rCv6hqM2mQfvOyTdpMWQJq6RzIFrylHmi3jy7CfZ?=
 =?us-ascii?Q?LHyCu5n/fgtSu0VFk2LjhA/ageAXdtJSHF/Xj8ggYiOgKIt95vYfUsgNaMzJ?=
 =?us-ascii?Q?GaUkIvhblWQ+v3mOTZ/phZQ1CKkcGtbxpjfqk45AMgjLgV5VF0renMCo3pPc?=
 =?us-ascii?Q?ntjNdLk6QVvzN5R07aOPSsv0y46CA/xK9zpsNwS0nhn0zibgcwouLd0IwQpK?=
 =?us-ascii?Q?iIw/8LRQEiOWX0m3qEWrQQbZUcELHRTDWTnseZpdyUEGSVXyXPlu+4fGSiUN?=
 =?us-ascii?Q?ty3GWDVpv5VK0lflxnSq067NoFozM0K63TOk7IT/4NOOiYBhycbbq3dNHwlO?=
 =?us-ascii?Q?MFf9yYpaIWm6WdT3WTMQ+otawDG/TtT8aTK3cF/1RVRyr1lLPs1ZJS2+I6Dv?=
 =?us-ascii?Q?iTGXITRlnicD7UY7SWJW8rW3k4YhsXy+eDo6v5pBQ/53D9M0XlyT2yiBK4hI?=
 =?us-ascii?Q?5xxgu2JJSk/kjzmJ7GTjH8AZNsL3BYnl4QlSSo5yA/FtnFclnQZ5Zb7y1UZ1?=
 =?us-ascii?Q?K8nI9OKPKAt/Cf5CV568b32h9z8MlaXfnCL4pkD9Qc4fGrqfuo9K/En+iBlS?=
 =?us-ascii?Q?hVIevI8iXRE5dGOmOHO1vxruaKs+XJV9oOQedtVQWi/6Q8wpp8BSTzO3zZpd?=
 =?us-ascii?Q?0V2OPqpdKtO5SD3eorh/qWd6zazKlAtE8/H3vxkNAIkBuev5h5BPQ82fEHyL?=
 =?us-ascii?Q?We7nwu7fH6ggjDqLQ2HTcrYhBlMP4vhkEUc39DFSNgWhDsD2kVYlREqkn69i?=
 =?us-ascii?Q?RREApKXrWF/TKTHVu38OVr858Y1wG5WWm9Hd2z4Q9LppB0LnUzd5gfRVxXlN?=
 =?us-ascii?Q?ywkdq+r8bFm0k8nz08MQhEsKAcuqFEoTG8zbwYDwNeqaImWO5n4uPEAar3Z0?=
 =?us-ascii?Q?QBDkUO672JVLolxz/g77RwzLY63lwjTnYPrl/L/zTl6/U+6z9T9swyuELIcE?=
 =?us-ascii?Q?h8nvsvxF4KjmZC423KkTrBwTMJxXzKQVbYwDEX6+W/e4zhe/QU3NqkimJtNZ?=
 =?us-ascii?Q?yDPjDVJ5UfNlOX+GeMiu7Q7SlH/Ydy6t9HdM2ucSbzkzCHxdvekFbLGTSuv8?=
 =?us-ascii?Q?rJrOFKe5bMgRaBwaVMwCX+FTiM/haV0zuhoj6sDgQvV0MdDK9cNOjeNSyUOn?=
 =?us-ascii?Q?/mwkL/ORYS7JbYXbJujScoy3nIfsRoypzSzRL+RNHwPFnI6nx5dCHCMDK2G5?=
 =?us-ascii?Q?5jrCshlMnlMHt4cuTE7S6E9dZGL0Zky2Ld0rqtDD3zU1knr9IrAtbP814iWW?=
 =?us-ascii?Q?8+YF5fXm7+fg1qLq0cMLXphIb5OWFXpq+1bV0pyHSKWT23HhN0pTlaXv28zn?=
 =?us-ascii?Q?jzNlfuYw0Py7pJI+SVKZwlHEUgZ6VUdufZ0wujo9Ck9cxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQeIBgPrtpIEGgH7dXpjIG5aQnQTLbTzc1aq9tAYWohHKxHYuVzi/HwsPJN2?=
 =?us-ascii?Q?gld3tfjviUzhmQOkHmBN8DaSkYDPyddm9nLmc8/SqueN/A/hLu9wURd9+XKY?=
 =?us-ascii?Q?aAtCAFXeDp1wqv7596N5miVQOJAepIm/R9n379tfBlxi/fP85AlRgd9CefBh?=
 =?us-ascii?Q?ju9qCWEb09+dG96sgIaNU2XGY/q6NQt7D/xIIMSCWaSUmFCVK/lQme3Pxzi8?=
 =?us-ascii?Q?fd+gu5c0TXNpQBUWVLoKNceBkXem6QxChgqG9hpLFj+tGJ0Cg+yh7te1SlU5?=
 =?us-ascii?Q?iuCQQa5YT1NwybLHA5IDhG6KpHqdJaRnwhxL/R4foORD457PU8kCT0fs1da0?=
 =?us-ascii?Q?SJEZR+yoMv7LFvgLn4H1dDyIZorohjmvycCW593OrwoybZG5POrrXfac7Acu?=
 =?us-ascii?Q?lOA3SML/albUc/6W5GvUwjJ8S2mb/kDVjuHIteCYqMo1/XMUAqqsNI2xRpAj?=
 =?us-ascii?Q?oogMqn+q7tv2VLzS71kArjDEjSnMm1mRDrFugLMoQ4Urmkv5GZSS6tMTBfCw?=
 =?us-ascii?Q?M3YpS9iDMuQ4lhVd2u6YGoPBnarl3h5xcKZgik21QJSFx/WV7gh/7Uh+UWST?=
 =?us-ascii?Q?7kq2WJbJOHAh0BKSox2BcB4RoWPl0FAn5kZfwNshqCXbvE+2Auu8yV5NE036?=
 =?us-ascii?Q?wks61kcEb0NfqYUoCJK3pGjhWl0xfEyrAr85+DbldfIKvGvnV6xTYJ0SRp/u?=
 =?us-ascii?Q?uu7cujhBhu6+4rw3k9NrFnCI2KC29XkcH+rdhui5Iu4SteAOiLQTw4x3CCA3?=
 =?us-ascii?Q?qWRviLSJrCs7+jUVehU/K8567drAb0glFmVkOI8r0dtQBNwkwqGZm2oTnsWb?=
 =?us-ascii?Q?0AbbGooK9+nuLxxPbn+J8pMkb3sGgji1wK5/2EGJ6+IaEiKX/QHV8hcA1egu?=
 =?us-ascii?Q?g1uwxXmZXyZTPRiOZd5SQpNezrEkPVozgMFHa2pXfxQGb+7uwFpLMxERc+Fm?=
 =?us-ascii?Q?1M3Gio2jGVFBYzxEHhg8aXrIpgwlo36RmDjd41U0VtSS+drTTxrVr7Lf3nsU?=
 =?us-ascii?Q?tnduyL2lZnTLfd4pXDW2qKtqyKQ+4pm8LMG3BXM6zndZHuR3PV2sE/DdKFS/?=
 =?us-ascii?Q?0+sqRmezX/0iW5nV+6fftdH0200e6CzeublS+tFXaRsk9GJ6x7QaYewZHTCV?=
 =?us-ascii?Q?4/b2R+wpIrhmj8CEP/GbzjxRF5r+b5cwpA9DD7haYegx+imToikFq5XUplxD?=
 =?us-ascii?Q?vTDIa1sCVgZo0bGzV9bth7WHeRbaStOQPlUYtGEVRNV6l5TQIs4WaGWcCq6O?=
 =?us-ascii?Q?4g3hH2DVGqoub5o/DXGL1sIu2F6a1C7nZbmBEb+tKC33rjLEgyxXaIneq41n?=
 =?us-ascii?Q?MX+rX7uJj5Mb+3XcAJs4DARwbWlrm15FGTPW8zoyIFGwEoh3qVGCQnZk80Vz?=
 =?us-ascii?Q?qL9iXxDsSd3wsCo8Rv5zVBkuLNFIc37tUCT5oaDIDF/GFYCwRLWdDyhYc4+i?=
 =?us-ascii?Q?99tG3n7m5u0HBDcCbCQec2ABSAZYrX2NMVuXNbmur7ZB27GoFwF+gCv+gJPn?=
 =?us-ascii?Q?0A5PmxHhfsk4mMu78mAvgIzp1H+N3uSATUHd4af6AOQzNJUDYSalG/iVivVp?=
 =?us-ascii?Q?RGBMWs5BH+M6OEvCy9mO3ypwSOrbh7GxZzFIxplZ+5xoAAV3N9va0AFBJD/5?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8thEDtHZz9snR9Ca6XKpUnK8voXvl1JuCkoVuiJWOoruKexN1YoySPS2TkgJTMFRzZl66CdEir1x6QbWjJ+CUJ+6URNeXNGJ1wbYd4o8wdaqdtKMktybd5D+7jnJtqxffbQLNpl8ay0pFYC7mpLTrLvb5zABrSGZG5lPNs8Ec3zZlecHqGYk2rHV6akUpj7aM4x7oY7As09IDWGHLLkHlpi23sZuJdxwMWgg4HXStLxnuy2y8nz52KpRWIb0rXXx6G+01lAWUZGpgCNU3fU5um3qOKAnq9jLU/ukBOC26GOb7acOIJHZK1qmRBZ8i8i3NFv6BCbjyyxLXEZ2LkJ4lwx4U3WYU070iUtzaqdbDPd4SYQYiDuebaGroJkbjE3gwi3mY/faWLekDzaEVmekgjrZIjmoHLyvXh7srOIec2THtuEKCWJ0VA9DcwAQG5LZIpf6AffNEY+TbCMCevWaeNkmY4QfcaIQZ8J1xjCJ/Q3xXjwhA81TgKUZKH8Cpm4omaawVP99YeFl3R8lTK/g9x/a2rnZ5OKCAuNxSuV9pgxKruaZ6cH2Px5RklZv/HixhxUbp2/LpTWLtB//gCEhZYQH4Dw8/61Sj8ggq27TmpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688e1f75-be63-4cf4-1aaa-08dcd17813a3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:08:03.6984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTUme79k+Z87R7F1dcoNYO1GAdfiY9AYvKvo+lXYBC8RTyb2OfKbifQjChWoSHTIJZSzpJIRJ470xyOLFwhazIpsCs7seqlZ6aLOVRibEzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100069
X-Proofpoint-ORIG-GUID: eeTNbU0ywurDNPkBxXGxFsXOKpMMuoEN
X-Proofpoint-GUID: eeTNbU0ywurDNPkBxXGxFsXOKpMMuoEN
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

In case the SIGBUS handler is triggered by a BUS_MCEERR_AO signal
and this handler needs to exit to let the VM pause during the memory
mapping change, this SIGBUS won't be regenerated when the VM resumes.
In this case we take note of this signal before exiting the handler
to replay it when the VM resumes.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/hugetlbfs_ras.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/system/hugetlbfs_ras.c b/system/hugetlbfs_ras.c
index 90e399bbad..50f810f836 100644
--- a/system/hugetlbfs_ras.c
+++ b/system/hugetlbfs_ras.c
@@ -155,6 +155,56 @@ hugetlbfs_ras_backend_sz(void *addr)
     return rb->page_size;
 }
 
+
+/*
+ *  List of BUS_MCEERR_AO signals received before replaying.
+ *  Addition is serialized under large_hwpoison_mtx, but replay is
+ *  asynchronous.
+ */
+typedef struct LargeHWPoisonAO {
+    void  *addr;
+    QLIST_ENTRY(LargeHWPoisonAO) list;
+} LargeHWPoisonAO;
+
+static QLIST_HEAD(, LargeHWPoisonAO) large_hwpoison_ao =
+    QLIST_HEAD_INITIALIZER(large_hwpoison_ao);
+
+static void
+large_hwpoison_ao_record(void *addr)
+{
+    LargeHWPoisonAO *cel;
+
+    cel = g_new(LargeHWPoisonAO, 1);
+    cel->addr = addr;
+    QLIST_INSERT_HEAD(&large_hwpoison_ao, cel, list);
+}
+
+/* replay the possible BUS_MCEERR_AO recorded signal(s) */
+static void
+hugetlbfs_ras_ao_replay_bh(void)
+{
+    LargeHWPoisonAO *cel, *next;
+    QLIST_HEAD(, LargeHWPoisonAO) local_list =
+    QLIST_HEAD_INITIALIZER(local_list);
+
+    /*
+     * Copy to a local list to avoid holding large_hwpoison_mtx
+     * when calling kvm_on_sigbus().
+     */
+    qemu_mutex_lock(&large_hwpoison_mtx);
+    QLIST_FOREACH_SAFE(cel, &large_hwpoison_ao, list, next) {
+        QLIST_REMOVE(cel, list);
+        QLIST_INSERT_HEAD(&local_list, cel, list);
+    }
+    qemu_mutex_unlock(&large_hwpoison_mtx);
+
+    QLIST_FOREACH_SAFE(cel, &local_list, list, next) {
+        DPRINTF("AO on %p\n", cel->addr);
+        kvm_on_sigbus(BUS_MCEERR_AO, cel->addr, _PAGE_SHIFT);
+        g_free(cel);
+    }
+}
+
 /*
  * Report if this std page address of the given faulted large page should be
  * retried or if the current signal handler should continue to deal with it.
@@ -276,6 +326,15 @@ hugetlbfs_ras_correct(void **paddr, size_t *psz, int code)
     if (large_hwpoison_vm_stop) {
         DPRINTF("Handler exit requested as on page %p\n", page->page_addr);
         *paddr = NULL;
+        /*
+         * BUS_MCEERR_AO specific case: this signal is not regenerated,
+         * we keep it to replay when the VM is ready to take it.
+         */
+        if (code == BUS_MCEERR_AO) {
+            large_hwpoison_ao_record(page->first_poison ? page->first_poison :
+                reported_addr);
+        }
+
     }
     qemu_mutex_unlock(&large_hwpoison_mtx);
 
@@ -522,6 +581,7 @@ static void coroutine_hugetlbfs_ras_vmstop_bh(void *opaque)
 static void coroutine_hugetlbfs_ras_vmstart_bh(void *opaque)
 {
     vm_start();
+    hugetlbfs_ras_ao_replay_bh();
 }
 
 static void *
-- 
2.43.5


