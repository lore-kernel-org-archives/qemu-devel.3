Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E63CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4Xy-0000K8-4R; Thu, 21 May 2026 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wQ4Xv-0000Jk-H9
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:38:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wQ4Xs-0000Ld-6e
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:38:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L40B7j1900274; Thu, 21 May 2026 14:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=J1i0VIvDKnFM/ZQE
 vywvQS9Pp0HgyAJqmVePbF4itDM=; b=neQ+0rkGxLMJsNNsue6sFntpWQmcKgkz
 3son/eQB4e9bQq3RvG/8Gkr9m6M44mMf1cJ6Zb/vV3msljbfWv3720ZHPmxEP5MZ
 9wVgTqNj+DSgbqCFKgDnA9lMZz9NkC1Uc2iK6Z5DcQYgq0OPwmTt1NC8+iYVY01r
 Q0Fx79Peq4zbI2xmOQ4HnAkeHFJXBdMgySBl27M0TpdiQOQNRFZGPLgl6sqz8P1e
 e2ePzwIRDGkDlgxNieOgJrMdC1Le3WLQ/J8I1F9xVp6y5xc7E1rZKJ0NMc0jFhVQ
 906Zvm+mEnDNbYsXpxBauEiCMbQpaRoWDIzLVBrMidp8U+IiKv+uFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxx199q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 14:38:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64LEYxam034103; Thu, 21 May 2026 14:38:36 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4e6f1jrsxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 14:38:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLx097G4Vj8VDsFrCEKLLSCpg1g576Ji3AdmZV+eEItvwsn1dkAFWQ0r2WnklVWwbL3sUC/c/Es5wh1V2vuupJHWOaRrNo7Y0IkD3DDb+RPv3MBw7tsVlkZtBcmRCp/P79ckGagHbXJNW7sNhaI24MJLuUH9iSkBmF5FGARbsxi+XH9JJid13I0Pyu6p3kOOhUfFURH0iErg9aUFswbDutJpE0tenb3o1KGPRf+OVXZRqY1HONyguOIxK4MmRw6M0f71RmUfL4j3y0cq31HnJ7GrnrIe5+5bkoytM/flCnHi/ZUz3QGwpd9QMdeEQ8yilCbhsTtwqxgR/fk9C9ALqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1i0VIvDKnFM/ZQEvywvQS9Pp0HgyAJqmVePbF4itDM=;
 b=N7DZB1bqGWeu9NbNeMBRjZoUiEn/6WQFdwpnyQDYiMGKIwKGrEkMZLeHg8BtfH8Anh6zlzapD1pMj2F5vHsg0Euz/Tm5PxT1K5271ncajKul5fXTTSu5XHBFGMgNSrAA3LsNkgqQmxEFNU8I9Gfa8Y6hv0qvJtsy01wzMyqSpt7PLFxStHtZv946AciDEVhP8r1LnshRUXmfN9Zl5wSj4LRcg80sJRj1IUxd2MLYs81KeRqu9oN/pXMbdVaR4i8cD7vtk2EfewFobWEbpdjwrHPVlG0BzeQBJML8jo8aCFCYuJUP3q+2KvuQjWeZHwtskWZqoIjNZdo0lL3PA7QFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1i0VIvDKnFM/ZQEvywvQS9Pp0HgyAJqmVePbF4itDM=;
 b=kPE7clL8wAeDLNgxA/aU2cdjs6ad4PXzj6+Uj79kGJ1kAgEd+dTsDLYN23SzhfvepjcduI4ETAdYJcG0xkY5NfSOJB6txEgZy76S7A4NF3eyuouecE5HruHKu7lD3HQ8Ul1KUTScYeRuwWDvuDnXPTHVwFDU0KGHANg3mZg3iMo=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by IA1PR10MB7539.namprd10.prod.outlook.com (2603:10b6:208:448::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 14:38:31 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:38:31 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, clg@redhat.com, elena.ufimtseva@oracle.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] MAINTAINERS: Mark Multi-process QEMU as Odd Fixes
Date: Thu, 21 May 2026 10:38:26 -0400
Message-ID: <20260521143827.64285-1-jag.raman@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::23) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|IA1PR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b57d073-138f-4d2a-208a-08deb746a138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: aY9FzX1Q5es+znbqlz6EOBkLKqIf8qMk3MKt345mVmNwSp5Q+3GPz7tUQTybulHD55NWm8EBLfdxMT0EaT48CVt/kOWuEOObBxpV0REDA/fVjlrCoApVWZ7Q8bIinLROuqdGUHdewDiqy0Y/z15BEay5lxS52Fa7q0hDmdJC6t9jHAV0NYYk9jZgMfmdSPVL0RCxvc48qIjezbSEZQdpY+STrpDOhfB8CfjyBvHLvWHx67ycA1KynOK5X00CQJ1BQJXyMNDVYea/aTR5dIeepjMz2VomijX3ATQ4XVg/qtFPeQZAXZ0cq4jHelsBIrf133xvQX22aJ7Fs67rNBzsvQeKDoexSwrT6XIpo/sz2DXwhTsQ1KFnliZogg3Q8INMLbQkgzZXL9wyj3JF2pTgL9P2j1Cww8k89/wu0uue6Jb6vkyRRsJiah+k3zmu/G1qHZWmggM3aEDiHxokBwWLwogSb9KMrv9jhehfR1AjS6pbApF7m7jHvWAbZtSF/LjoFewT1JiXJr3RBCg8clRBDtMZPLQh/QhGI7IxVCIROmtAa63Fb7pYHrHI0p9BfINynviuRg7evQ6IuZHXox8xobHywU2zqkj+uaYUITMv79q1BCl+hAQafd/fjhpiiB+yRrRqE0vxFmSTlB7/2wZ5x0MvhY2YIbjJmUCgPv1jR704hX7uK25SAFk6S6+p3EVL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7XQjc1hNBM+cdzE+FpUE0Cob1rfvliG4HYobVQTDZa+lewrX5ETYss4FCmC?=
 =?us-ascii?Q?n3U3916w/JdmgxHahFai0OF0K7dX6KAQPjL6FgJ/A8wH15kAdphyJS01jKWD?=
 =?us-ascii?Q?YPeh4imypZ/l9ANBocingYfjYqsk0Odv1UrJ0i6gQ4vSFlNC/AYJNNYIAe76?=
 =?us-ascii?Q?mrGOwEEv6329KGQBJERChMuwfkuNNTTnvgm3D/aMRc49EMoXk56tb9nk82iF?=
 =?us-ascii?Q?3IhSGAukkpijyiBJPXDtV44tb26OuMg8jk8urvGCi35p14DJFSEpvKhgo9sF?=
 =?us-ascii?Q?lLCsJCn2+Y92QtWbwv18hzOY0bNHzKI0wmzhqidyJsIju4u4tp4ZoGc5Bmo2?=
 =?us-ascii?Q?CQtp8sK06OGqARPH4dYRoCcXTPkAFIDabMK2k8VAanJl/XbrbYNnfASfgvza?=
 =?us-ascii?Q?F/r6h6exk4Ibhw8HAY+3Wfw1LPbHnAl6UWhnXrh7xFalrk/uoDnnVwNkz5H1?=
 =?us-ascii?Q?UUMIZb/1bwBGhX1o/TO/CSKhJ+lHjVjoZTpATjJS8ZOGHbBH62PV+EYlLgRE?=
 =?us-ascii?Q?WyQyUsRAJMOPYWLVO+mSy2Q+on5UFHsA9HZl8r382A8XEAjhKGVKCCrtLx+L?=
 =?us-ascii?Q?I4GYiyIb0Ae710D4KAbGz6vkgu49sgfxMxLJA1ddwJsB+qURDkKkAGTlr41d?=
 =?us-ascii?Q?1cbtW7oGTd2eBSBYLPewrck7lWLB9OEiFZlqEuaiCHVGIReVPMTYgKyYOItH?=
 =?us-ascii?Q?p6ELVZQA6P7Gd6Ls190V/qoqtO8ZvR4IUJ9pHYTfe9VA2OnJKCqNVGVngRUG?=
 =?us-ascii?Q?jBc4mYGEZ4TOmnW5Z/lkuYm1WAglJvBXA2Q1+mwo+YCsDOxFkfh29riqBViY?=
 =?us-ascii?Q?DrspB6qBnsw24j1BV0TaSHD/2k6mwnB/vkoNOSSXUv+cAyazAbCyhO5us7kn?=
 =?us-ascii?Q?Um4Kg5s5IFinouDwSqQ7pQ86nEeQPDY+LkvEHW+nIrYcJshtCIcBz63P311q?=
 =?us-ascii?Q?+hYM42XDIfI1dBlmvg4RtI9bJSYICwdN3q87XNcj9+xnOQIqmd/B7VoFrZHa?=
 =?us-ascii?Q?1cZSSp0rhXGiCv4GbzQIO77xzugwJfV2k4KdRmfuzow8G0UCym2K6f7eNaBl?=
 =?us-ascii?Q?BxtQ+TKkC/rHbvhmrDo2WGqAbprRJaNE/imL9d+u9ADrz0pp2pr4LqHUnJPf?=
 =?us-ascii?Q?STD78SpnJP+VmuOfR+XDXnOZXJ9mleKVMp2c5ho5crRDN97A2ZqEXH0Pf8mu?=
 =?us-ascii?Q?+/E476szcvtvPNhiQlE/gXm0gl7JXwpAcRiS4CLBMS0b9jNIXV/PFN/QQiTT?=
 =?us-ascii?Q?vdwqHwk4ntQL+i+lLBOXYcVz48sZK6hBrqJabHEHFudfTuenEgrItLc3wMpQ?=
 =?us-ascii?Q?pMOlGPJZbQ70dfi0TDYeD3F2W1mkDMxUaA1TgH+P7cEUavcf0h+sXsCpf1Bn?=
 =?us-ascii?Q?Mrkj0H/YmF0D2Herf85wnoMqHnJtC/qL6gVviCMBrjfRe9BY+YSMQI7NH40A?=
 =?us-ascii?Q?DVr35nacYoCxc5XYQ9/OfEt0ZqGjns1xTLChiIfcJTk/WgH/tTG3gGN2tF+B?=
 =?us-ascii?Q?xV22aUeOEJTtIRIao93lOcyn6Q0NgO6ToqpkEk6wmqsWG9ISx/NS/WXy1pop?=
 =?us-ascii?Q?CfS0X+PQxcDd8GNf8HbrI0ZLmZNPao7Ot9ZQMuMbnx4JY4GPRrMTYdJ2HNQJ?=
 =?us-ascii?Q?ctagXDUWXIHD3rx7MBGu0Flg3qU5Y4FnMtrtq5JT0dGXLL9vhvHWg/Pk5hAc?=
 =?us-ascii?Q?zEY2CHtyeXmcIBrhZFJ3bvls7mrOIrBmL5nLmCPR24YTyy+R16cBHx+3RQax?=
 =?us-ascii?Q?4fKWd0wHHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: nmflRynl9l0ZpR79coi8WizpcWyOol/eGiDL50H+QV6yHhgmCzef99y/AlzYv8Epw16pzgyjr/gpajWpwfJnEp+Pyz4zOvTKpa8RGtvOVSJFvoE8vyAYUcH2KrR+677U3gneruTjQFh2/b7r/pGz7uWSV3yJcG9fCAenn5ss0BVFyf5ZfJcv6oMnePG/71tSrEfqiCta7btppaYCvOop4ssR0vzoxQQ1wRZ1a1Ulghd/HygT4uV1yCGpRB2muK9fNItfFC/7q0C6Qg5mqEF9U25cXzaVvgaPeQ78BEDfsH1zIcNg6eyhPS8S+bKR0jhL/D41w+YX7icOwkklBu1rMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sYE6uZSonfarBSL+pFAioJ6PtXqIW7IQlKmoTHjNkBOhnTUNd/h+IREKJlvcSspaAlIOjgGjkjNAYvVohQlkUMd0jGM+Z9XUBuy9Hh/xIDXXP1OLkRfUO005BsW9FCIdGIzZ7+KmdbHdOE2l/meC5s44MsNJJLGIDFpn+LuOx0X9hnieXkueUm1/+NUeCoCtWvbrfPQz/Vm6e6atW12yHQmssVfKCU95GPQxWV7NIosZ7x+/chf5CNVogSyvPJiAcStvQP90tOLO4IwMr8w0KMhG++ck0eyvNvzqcavdsrrGbmN+Pm1tV8quXFw/F5SVe7JORycA3c6qyJ5vgZBXydno4JYSN1mqBkD945uaIJ7VFljW2INmDa03DW2ElQkc3FQi6AQge8EHsu1byEhf3aJ41yB+nbZfxj8390YeMz232Sggqf1oov+5kvTaKQ0agwusfnY1aI4ufHfCoCWMf/KXORwnLE8vIW38CD6lnYzkfPneR+vyf1/J+yDj6Vg8cVaK7BiaI9LST1zIbh6fMiQ6XQnqZxreD9nNpUFMgjR0+k6gVkXWryKeG54BuPLF3xTIMFiRAY5wbUtmrCW0xdFDif2EvN5QLYaAbs4uSa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b57d073-138f-4d2a-208a-08deb746a138
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:38:31.5837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAaVuiURuVC0MmyUoFL25Zc8MtmQSKQDk3idUmJu8PyVQdHEEbsZ95pNAaaSDvVzi7Q0pC/zR+sgIDxgCISuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605210147
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0f18ec b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=ArLS4cty4vrEn8FGXf4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12299
X-Proofpoint-ORIG-GUID: yL1-oqCdtiYosYNJIEBds4iF0zb6UyoD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0NiBTYWx0ZWRfX+W4+LOo+a9Kk
 MCOJu1g0u/ojS4E5YtQFrTdfwex47gxbwIk2Myq3DTG6lEmk2F0bDFAFy3+AG6SdRY5mio/cOMQ
 mR4YIDntOKIa5XCVCL8n6iOpC3Z/gOLAF69UnaaPRskWcYHRZerlWluDiopbNmP3XWxOO/7Msmg
 Q8i0lLcp7LESNV8AKo8W+BQC+C20w4wSxFFbeymlwG0PMn01lZ85/XIsQOFf19KBXli+0PGWg1I
 dPxYsGHMg3glU5aZ9AbACZNQOcxn9wqRgIpsaI8pD66bK7p+hrmTuSHabzVng+DQzZNpL3sYy8K
 ErEFcZGA5GL8H6kIh/+nguNp//YBk6kE35g1JGrF+vEdJJeb+8OS2JWPOynaCUphGRC39rZt0w4
 qe9rH91f/p2bbo0Lw0Wk353oLqb2wdGxL0MvEG1xKXBdGOhoBhad2GRPM+BwDSQo8jXTKZwS4et
 vlzE1pcJ62whE8tWGMFX4iZTwBbWccR5R4jkYkmA=
X-Proofpoint-GUID: yL1-oqCdtiYosYNJIEBds4iF0zb6UyoD
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reflect the current maintenance expectations for Multi-process QEMU by
changing its status from Maintained to Odd Fixes.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b75f3222f2..863d409dbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4447,7 +4447,7 @@ F: tests/tcg/aarch64/system/semiheap.c
 Multi-process QEMU
 M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
 M: Jagannathan Raman <jag.raman@oracle.com>
-S: Maintained
+S: Odd Fixes
 F: docs/devel/multi-process.rst
 F: docs/system/multi-process.rst
 F: hw/pci-host/remote.c
-- 
2.50.1 (Apple Git-155)


