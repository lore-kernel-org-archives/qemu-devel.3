Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F4CC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIY6-0002U8-2K; Tue, 21 Jan 2025 13:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taIXr-0002MW-AG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:00:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taIXo-0005wz-SB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:00:11 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDwke019300;
 Tue, 21 Jan 2025 18:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=2tavNFb/Xou/Wplh
 xRSDG4EflNQReQXTHjdnq3zewi4=; b=RWiNVOeEcpjOEZ+IMJGBTAPVRtvnAT5F
 VCnNF54so/t66lszi5q8Ixg68RkysBm8EK/AdqS/FpggR+Za4dwuB4LiV70eERdo
 D6yp89M2MbrQ78yoKPl5V6NTXfK+q2lqbhnhjKbSb9n1Jov/0w4vsagmnfAeZp5G
 6sJ0iG/qsjE1nhXIrQ/oYZs0CA9ZM2DqUXawffkSvKlLv8aec7WMrN/PpvEWF07q
 BYz6IXT4yhSANHoUJSjIgPBrLdKOPzDrwV3Ovh9peotkD/GRReKFMZPy7xVI19QV
 /6TmZOB5nzqLp+0ha9dj+wvJbZXxDGFEJm8RR8UdFK3jhq8/13Yi+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qap4qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 18:00:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LH4OKp030323; Tue, 21 Jan 2025 18:00:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491fj4s9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 18:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3mNrrMdIk6qn94m8JJBEK481YoTyNpJ67cTC9ukTofVsxN5iUBdBAebIGrPXeDpIoeCtz7inwzVWk2jRWxBFKEpassWU77V4oa6KmRE17CSezGBzMJ8VLTiiYwFHM9LwKRnTd9R69Y3seycoY4ebhbYIdQG7yyKsS1UZuw6eOZlKzUPSoR059F+MwqcVGrqelMdi334+6q0YjLOXsHcz6fy20RBwOOGtr8Ev1ohVzoRieh0ztOOA6MM3IT75d3/phCeEDL3G1Q00bp6iZRM230SljErQBoZMcJ1PSoUEkIBxSPqlLq/OrI0pQb6nTUMvMDv8Pm7PoLUduUaQFiC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tavNFb/Xou/WplhxRSDG4EflNQReQXTHjdnq3zewi4=;
 b=hIC6zZZLpJcbNkMdWOdYMV5D3Oe7OlxCzpAtY873t+EGJpoeRdMawfxfoIsx0jo30iRadf/RqHcRpUgHy5p/l92P5r3S7iWW2urURQxmxCYcr2MF0tSZW/fCauC51oLAnm37PhjrqCPh6Gr0tPv0ii/Pqx4jO6grwrGFBRLucKrMbMf4XczFdQd/Psiw2vGnwtSIhf6muchyY5J2G3RGaUlLt5b5dDiiEC0o469AU8sgBYPzFl5PgT/m2F3VrH4LsLrTaO+IYwV+Dm287mGpufppRPOI9vxSaXabnBpbS6sNHRl3Eqsmgb6egp2kVtNXn5DkaYfJetem2meWMChsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tavNFb/Xou/WplhxRSDG4EflNQReQXTHjdnq3zewi4=;
 b=azB09DmocrA+nfrLMe10oaeGWy9cQuwz3LXO7aaLLOZgcRe30M8VSZl2cWjmM68sYNVmlrVLazxbgHlaqv8El45weqWpE38kfdYFBZw8Iy/LHQjOtpELyXh0J6KBhlJeklw079cpdVghEkC5nRDeeq9GxBVyIcvto+4tDca/XHM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 17:59:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 17:59:57 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org
Cc: william.roche@oracle.com
Subject: [PATCH 0/1] fallocate missing fd_offset
Date: Tue, 21 Jan 2025 17:59:55 +0000
Message-ID: <20250121175956.3030149-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:408:141::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f35e7b-da29-4056-dfc5-08dd3a456aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kzOIelG/XxylHbNUhBU6oNnc+xIbBYXPVdi8DdcJwJOWqqimGEWxgpyVoZuF?=
 =?us-ascii?Q?XU7LEqm5CczBlHgDXy1FPdFGAvJHnXyJScLz6N2vWx+zb+FU5us0E5tS0XTM?=
 =?us-ascii?Q?8Du9vZAFUlb9MkHRWez3KtfmGjL3P2+wgN49Uh7weAjzrHGonzN3p9kQttd0?=
 =?us-ascii?Q?hDgQgnF//XgrQW1XBqnmRmpYFaigXZDrGAJ4Jy0rC4Bb4E4B8euU0mitu5uX?=
 =?us-ascii?Q?HsFrsFNKXQnTVSm+nWyUHvEjdns1lSvyT/O4WqwXTJEvyY/En0FxF78NQBuj?=
 =?us-ascii?Q?ADiSKnHyerW1zjbeNrgix4OBRnZTMjl9BRn+XZhBLzzLmGZ2XhWjV3YHHb+X?=
 =?us-ascii?Q?EkTy3rFu67B4B4vnkY7Z22CtVvgje4CyDIbCkyJEzK3vOcqcrOOHaiRpnR+4?=
 =?us-ascii?Q?4nRkD8r5JDbN5W1oSt9FskzpZZStHZw2GK6018H8w06GlkyheRctffB43g0p?=
 =?us-ascii?Q?V0xVh6MIPCmE2U9wevbaXxJIL0hp93qFQVI5rXfLvz5/UIo0htliKolBqaZN?=
 =?us-ascii?Q?kF8DF7dlfDrQgz8P7uMccSS1Cet10+up7WlfJOY4PrEJc7gjcvTCnM2T6RI/?=
 =?us-ascii?Q?xNrBo/A0IPO+q8drQPpQBGJPREMs4vXMZk5+XHlm1iNZJlk8jiPmfK9JtD82?=
 =?us-ascii?Q?b04+iS0NjttVF/QB9+XVkP0WPoHgbxSYG/OkBGSuivUwTH91qAo5nI2R0nZx?=
 =?us-ascii?Q?tRi7+INpNHk/jDCB2Gk0Qkb4J9yRU74onl8RN81Hp1x4eOuJMeMcMIR9Ov0U?=
 =?us-ascii?Q?ciSj58YyTzdnNY+MLYXTo5r5w8YhPsWGrTV6nJQ0mrScUzpegJtQR9mhhaKe?=
 =?us-ascii?Q?Ni/b+1XcxK4hVM1mbA4gjYqvNR+g2r9fbLyqTJWfYBPWccGglbyiWTwrgzgg?=
 =?us-ascii?Q?8U7e5A8KbtotPm4tpChWzNzQcUlCoometrxpfb57yLt8W2XR//zok7JEbj/j?=
 =?us-ascii?Q?T6nCEDGFofpKPD7kKGEf0/x6+VHcFzzg8Im5cA74svkgO/FsA7E1IOEpVH/O?=
 =?us-ascii?Q?UVb8CsXBrGy99P45hfEL3SlOzceHdCzSoilAP+UCaateyxvW2FQlVxTWKI5d?=
 =?us-ascii?Q?pXPoSKxE75MQiJ0RQGpE/6cxXb8VKe7vjqLTFD278r9WPQtohsrnKDQnNusP?=
 =?us-ascii?Q?Pq0LFX3b8IrklusvQzkmOzCtnUzgBk4J66Giep05l950t2S7+vX7YBAk4QbR?=
 =?us-ascii?Q?IKQ6o1iHkC6evaE0KPU+WjdHDNku/WePVeJQozzUuS2eF0ZWUcYFKtdXs0RC?=
 =?us-ascii?Q?zP6j0dMn5Ida/NHP0TLD2RP+TX3zOeG65/gHMyqY0MOSoLg87C4uMF4HfYBE?=
 =?us-ascii?Q?36mU+ntt5J0snWx7DefhZIPvnLcSUQx0CdMy3+sTl6Ey4HPHxGuz1bW8b3xJ?=
 =?us-ascii?Q?1z1jzV0LZX9s/98o4PqEBL4WcM8M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFWqbfHlRicJJ+ZkvH1tlTHoa5m0pG7jMyEVni8aJ+oy2MshFSua4H5Biqix?=
 =?us-ascii?Q?EQUt9hlDD0orCrm2Ot50kLouHeoBwnxVfAkLrCi/iL0oDXZKc6iMR7EbGgzJ?=
 =?us-ascii?Q?xpqFsE1dZixK1PfdSIXjPJLbORpGenygtunRLO33YyfymFmAdK2FcSC8nL38?=
 =?us-ascii?Q?5mt2zvMwKwAR6KU+vx7+DaiyTE2WCcc3XZvrWfIiCM3B3pToI955UVdhZTx5?=
 =?us-ascii?Q?Xf+LNlGRfXx0/W0JwnWB1fjgydwfooPgXBBMtQeq9m/akWEvx9w+X4Z1Jmqa?=
 =?us-ascii?Q?JUfyy+sPy8zL+KwBWYQIblTo6qY3ru/otSbGZV6HMqwkhs4e6OeMRkEUsHWS?=
 =?us-ascii?Q?zqmMMnlmtHP6b/I69HRyxeBRD0MEX3GouknNBQFJXyQMtKXCDhHZEnTQElyw?=
 =?us-ascii?Q?DcwGQNvbpK8W9H8AHw80Mk62BXTd1HcIhKaS58I1XVwqVDo7N2jaUyzKIXRn?=
 =?us-ascii?Q?l2zGmthgQeNwVx2vbylVU1JCobSMhWqz8j3QbnCKQtcOmzQi8B019tbhEJn3?=
 =?us-ascii?Q?FdbHnFh1fcKH/1ed/J/c3ztIEB31heOksTeuvOmF8Ztd/A/+MAAnDMRBLJxQ?=
 =?us-ascii?Q?jmy/WVr4dgEJNeSpsaEZB9yoBvxg43Rs2vN1+pfm99emUR693Au+qT/1Wxkh?=
 =?us-ascii?Q?GdY6YSu3H9L7P07bKSEQO+TGoAbTNOHwqlzsqVv8z2edM9E2Mm9gbcVxjVdz?=
 =?us-ascii?Q?w8c34nLjEWrO5dupar9Z3YLOeozJcT6kmXa0DT2FDe8SqSZZKTYFyHyoeTWA?=
 =?us-ascii?Q?sRDC5/usTXpXu6t2BydRB5qirOBBykV85u7JTyMmMFei7Jxuko2XkReePCBB?=
 =?us-ascii?Q?KqABSQaP9Ea0IHhLosiF4NhTxz3emn4MyNnCfMQPF5I2mqNvdXlolFb9ivkM?=
 =?us-ascii?Q?bZV952ro1y7IWToNT7XhB6zgLNY4VGzr6+mhh+pLprwE5isdTFtnAp+dQIQb?=
 =?us-ascii?Q?KUWLxD6v2BI4gp6yRKBSUh1Ic1Vo8lGvXAFkC3/dzoTFr83vcQKDJQF6kmL5?=
 =?us-ascii?Q?QPK2haeRNHgpKJOENYjHueEpKEcJW2s1cTOvjYrr0Mq+JEOj6in6Wmpumikp?=
 =?us-ascii?Q?wDRcFpE68PqMzK8OgjOq8s1KwucHAlBWOainR3mNCAEU+Ob4pm8iqHxZC9dU?=
 =?us-ascii?Q?nyD2n4Ffh8Lqhx1WPV4m9/zMnx1tLdsa5UT6OzZpIZ+SzFmtRjNm54w9Eq/8?=
 =?us-ascii?Q?mAQCWJ/P+8ftiHMTqH+0j8Dte735GRrS9UChKc7SN9+tPQaCtMjKmrvOgGA7?=
 =?us-ascii?Q?8C4Bd4n4thkw8vI0TRGdO8jcl6cmAsAetnLh91gAQBvmfMMwsgir+xsxInRX?=
 =?us-ascii?Q?9diIH5eCpBqRFG799fYMf7RalEjUbWdWChjDpm9njr5pDcuiaNaBxvd4wfdO?=
 =?us-ascii?Q?Vz2tuPK/dGvvrfXQ5XFBd4ENv2FXgJk55NhaniwqNXOgGlcXFNxCqSAH3LlP?=
 =?us-ascii?Q?EXFKUM72CT+nEx4hAQTggM56WdphMYkjrpJph0VxMioxBdwuPqQDGPaxavaC?=
 =?us-ascii?Q?7vXQF9iUTM9YYbi1Vo24cHc93xM9BwZbezCvGn6eEYMbPXcg+9R926oj5Jbt?=
 =?us-ascii?Q?F3+h5a4O6q05JxCRquEPMwEkdJ81Awcf8RDKH1/0G6diTo8u4089QS4vf/eS?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8DZRHOI1f9LLXA+BKUodJRN2XXBvvUJgr1xNLF4y4uT3z1cRFO6w6AMuealpHT33Kmf93uX0heqQ5eUqwdrTHYwrWXGKKrmw6ZEP1bkmGJ0ngB9qQ0W38b59qEbrFO6OQR0ui9VFzTG5HnXQTMHOGb/pz+XGYhxf2BqXiTpK85VpiJ57kkmAx/iLsisZESc/DIlDE/SyO/Qy8g//YDiEGdYR9V2chYFDvUEYQkInDq2HjWg93RLUiOZgAIT99tmss2kn/g1Z1d73eXLIbEwyxRrasWvFKFUlUy6ErZQ7Q6GjBj+KEdlClYTe3DQxNdIFkWRwMZATrJIV6/J+NISNJeikuRJOKslUttPFqM42b5EJlILE+qYXZqPJ6V7knnyg45qLyOOZWt+GBykrUQ8VJTQcFPo8WbziDRNFZMiIRKta+b0nDhWph+EKVkndxDbbb3Wu9eJ2JA9Po7DODkEkDQ5Xy5KlcRO+pcCCa7iB10M5OIaigpa678OesqhOFM9uoQdND3S23EGevXV7xjGMYVZ83uf7w+/IAj3amWq5xmpAIPYsGF3yRNDDZ8vgahaLg6ZECI4wcPmwEMjdBr1RtI9n11LQqPwnWV1envg2Dmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f35e7b-da29-4056-dfc5-08dd3a456aac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 17:59:57.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+cYYqHiJmu+9gOsD/YAgviMQjPnOUnuwistoVSd5hKcvqYMbF2miYexXmVATxsk/t2GGsAUGTTku+T40ciScTTQe2zKpZnhU5qAuFvVsOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210144
X-Proofpoint-GUID: GGTGyBZKjKMTHPaG9hODfKKxQg1nNsfj
X-Proofpoint-ORIG-GUID: GGTGyBZKjKMTHPaG9hODfKKxQg1nNsfj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.086,
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

Working on the poisoned memory recovery mechanisms with David
Hildenbrand, it appeared that the file hole punching done with
the memory discard functions are missing the file offset value
fd_offset to correctly modify the right file location.

I'm not sure that guest_memfd would use a non zero fd_offset, but I'm
also modifying the ram_block_discard_guest_memfd_range() function to
include this fallocate use case too.

The fix is checkpatch.pl clean
make check runs fine on both ARM and x86

William Roche (1):
  system/physmem: take into account fd_offset for file fallocate

 system/physmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.43.5


