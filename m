Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8880FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHPyz-0006hF-7V; Mon, 27 Apr 2026 13:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHPyv-0006gs-2X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:42:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHPyr-0006i6-LX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:42:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REN413215103; Mon, 27 Apr 2026 16:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=ZDcTFt/wCILKiPKI
 SErMLZFaW64rgiXWOpHBsjV26AM=; b=mhsaJS238tt5p0wt+5clKmARn+fG9Jqc
 6IXsQPi+rPnvNtIaLw65bBrf0Hg3Ll/lEhci6ZfkN1vj1kexmW0CoX7wcANOAN++
 FvG0Nrq6YirOPiytqsCL07vUmubUhvtEKvycIjzq7wGjUdtvirF6JXOUMkyJngFR
 lLeDky9HsVp3Edjux3oafKzjwSpukZKLXo3mhPvfEjQOAuss1QTZSexJU7WMHFzU
 DvbJJDBkSgrTNxYBhFzZUgEPurC1JRw5A9XgPy5jILPxtk2Ww84/ta73YLCK9xyv
 rswu9TAUNdVUXzJZZotiyluFATDB9jOIYmrRMeIzRo96zZJOHZT6Vw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drm6yuhmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 16:27:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 63RGL9Mo011280; Mon, 27 Apr 2026 16:27:09 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4drm2bn252-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 16:27:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbjEPpRpHHvrGG9Tq6nUda+tLXo2gxT9F1qO0kIkuIuR6lqDu3+yoDxD00R1Gsl7BDM9b2D/Drnvuv46vScFV3uvDyrlNNemRM63HKdIZojYkAL18baBLrS9pIkHn8mxTZzl51X91viZmSixJc0a3iGWwsX91qgC9q60xkkwyJ9iBpi7SK8OZvKECTsnDLrZcuY6CIzIOcj6s4X+a/eDMnqKnmqYDJmrR91vZK7zqkExcLYkNd3Pm/3jOj7sNeBRxY28posZVpVdr3WzglxvdsRHUufzLVR3elNgsn1PgXOMKu+p4MeVkyBrqPRqgiRgYeevwI3l/JE78J/B3imcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDcTFt/wCILKiPKISErMLZFaW64rgiXWOpHBsjV26AM=;
 b=uXJi4RNfkA/Vstk0S7KU+KoK7Gb9Xy4/9BW+d6PPU9kGYTjS9D4po5LnpPi+US8jBxHT2HKaUlPmVA08gvBeNtvVgIWbeu2H2GXfJzLuu9LD/AqVBiCpx6GFHLA7CqvxTFJ9wChKjZJb7giX8fYtGsulxcURM/Kpz6XOtVdJfmdn3ykGGVGRGt/89ckpG42Jao+q3TMSNj9ZskqarW2wQDeSy8V8ZQh6I5NKD6OTa14Oql4GaK9j8QRHEp5DtF7ndtSiFIeV7GjUO5Q99/g9R4WQobeBRKtI/srd6ZmYbl6NDjZAwfSq3WNDyL4TYbc7meMQZPz+Av0P04kjLKreZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDcTFt/wCILKiPKISErMLZFaW64rgiXWOpHBsjV26AM=;
 b=YVxqyq6xADKC+npq3TZKMg7bO9VupO4ey6MYJUDqDB9Rxln8y52l4y2XYmsEvpL1I8glXJrUVYV41Vx7/SQse9Ox144d/euKdPzxRQJaAK/uPglnOyGteIewz4HZqXBJiHwDLjCBiA1U3rsQEF+IQKG1lyx36ccr92xZC/FAN/k=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by CHAPR10MB997699.namprd10.prod.outlook.com (2603:10b6:610:2f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:27:04 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 16:27:03 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH] qdev: test if DeviceListener is in use
Date: Mon, 27 Apr 2026 12:26:59 -0400
Message-ID: <20260427162700.89750-1-jag.raman@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:5:14c::32) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|CHAPR10MB997699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5e09c3-9fa1-4082-6fe6-08dea479d0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: d9Km8d/zEoJLIB4JvD8Sds4NJamF0crzI3ci5KTFI0YTwYSc3dkfk6+WSlA8RNzVB0lSDQGYbmpKZE8cX3COT1fyCcnF6Oyu0bGSEa/sY0ea0pJb7DK5ayhS2jyLfaH08m4TfNVT2NZFy2x0Wa41ATC+kz2zk9WB1c9LCvir7z66CHgO8ePdqRyel6KBtOHYv9RIyHK715f3bHh/1A4OOwk132ndJck47qy3eoZCIOntywVEeO54kdY4faJZS9vnQ1Wm8OGVcWRrBJoQZzL0/2eKSyxtD9GwsbMmUns0kMX6eIOItZL7Ck0f6lB5Up1iaTVxEx7hg+87/yeMSB3h+xH5DZDbklwFImi3Q7JuoVAcFyaS51FpGj9DnSXLxU0OhEgNiO9dsRxx4pPendoVpqcIBCxYpFol+03g4gidA7tiVwmTBBLAmqhi/Eb7FJ2muOBOUi1FiQE4Vzv5q9JGbMNNaIqApYnWuIap4WibHAk6Xgs2YM03gWaE26apFhpFaXTBbUZu7cbigm9x/cOtoPcj5DLBGxn7PWWryMMLTHRYWu7e9Zlv7zwPLIcnBQ8oDYQxlZEdsr9jwMIdU1ka6ZtueTHkJh+jcx2KvhAtBZpJ41yf1pNPw8cXH0jacejYMdO155BM8HOgbD8UDR8r674hpsDNnDmqkr6s1BU/JMzJPMouuA97KP22WMF4Zdac
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVeOb9V9p04u8sxkZg7q55m2bI3//YF6eKgqZJtgTw6XajY1vBh2gKn8UFwi?=
 =?us-ascii?Q?0Xi0y1dFa4kmKHuQ2Qy70znyTeA6fPr37DnL8ZTgWBEOlk135+1vi7Gjkspa?=
 =?us-ascii?Q?oUjBYFUUWiKWSoEHrYhW3klXjxrHO7QDcb9DkTC1kxo4vnnpNqN/jOCPlgax?=
 =?us-ascii?Q?U0ZnIGEyHoYm1hfYmwkMtARQuQt5SRjTBoc+KCdurpZnVw07rHTA65bXct79?=
 =?us-ascii?Q?uM20nk23/ihpF9LsMw+4m1ItFMUYs133CwnYumJlmPhbGlvupTXz2gC13Eaq?=
 =?us-ascii?Q?klhEnB0Z2ERBGJitcZB3aeAMUjNGz/ef7sk60kYhOwC4Q5NLszdvEvWqE76J?=
 =?us-ascii?Q?Rnb9JQOo9kv0vcGu/kGA5kg/3TbkyM8DKyq7Fj9Hc9oNxUTebvu07BSdDQu+?=
 =?us-ascii?Q?GS0m24ULjHYSNggT1CiNwtPckrvEyulTHWRA1HZp9puKZ/JO/5tJsVdTfj5y?=
 =?us-ascii?Q?dhsYc7H+APxSWVG1moPbfDOSAHFsjGXih7qtWPY3C4ztPEqHnBHzdjcW5nUU?=
 =?us-ascii?Q?fmPfMr9LAWi0y1kbV0qNw0kYuXFmWyMh7yV87GfbwknrQBlni8H7JeVsc8qD?=
 =?us-ascii?Q?NI5on1h2GOaXTJcAJPtz6snjHyyTUaFH0qvL6LE+W39jqclw4EZSalCE5beZ?=
 =?us-ascii?Q?wHZr7tTDAVdx551EccEJWA/PeY4JlE0Ak257UHc6wnFLKkYQdNDLEOJ/7uXf?=
 =?us-ascii?Q?7/cIbXv5+KYlmL6aE0hex/V3KGdn2KmYFwQQ8LgOYoMfPNwqTGXPrztQEv/e?=
 =?us-ascii?Q?liEWiFvwAoO58ijTayNBGFtb/veL8yFWyac4SYJ4vu2rKjD1pKV8T3p7zxAk?=
 =?us-ascii?Q?IKB56xd4h3kXgJO8LT8rmL3foda1X2XwdXWl2+qybm25NWUx4U54SbjqfTQc?=
 =?us-ascii?Q?EmeQF0bEal7GK7trvqPFuJ0BZRTDsPFAdZQ0R0G1KxZINrTazoApwJ8LrYfY?=
 =?us-ascii?Q?nCY291H1+VDpEDA3NDnSSoG4WJ/Ow3YouhNs2dUYVrcvaUfo2ndcQwb7CbD7?=
 =?us-ascii?Q?R6bqQPuZiAeISgv9j/o92qkH7hn81RLO6MQOun+3KGJkrmN0aFzg4LvZhw5H?=
 =?us-ascii?Q?Xm0nvZFNSPJ5PtXkCKSptUSnl1MafXHMkD/CLaOdVpRsTlZ3aoDzgMz+LS/Y?=
 =?us-ascii?Q?ts6VI3VJPxBrrO8kQNEyyoUTvqUf8Opwc6cf9lg/gLcjfeInhfEqn4vXUBwR?=
 =?us-ascii?Q?eoo6s0k/229zKJ32C8F4zcK+PMLBgq01eqRvuP90LhKiyBNAd7vQtt3y8zMX?=
 =?us-ascii?Q?02Bgf0JwgphNx77Z9wm4SgCnihPNH8fsbuSlRXFjKRRrRrKSh3eh3/EnbQMe?=
 =?us-ascii?Q?faLNfWhqx8h9UATMg5s6BLWMaZrv3xeik/+6O5p7TTVhx5m1CN3JHaclMBg0?=
 =?us-ascii?Q?OlC37OEB8OqtbVJT8RHyCH+Gw0CiEQrTK35I3iBAbf1pFm+raQrSbjs+r0S7?=
 =?us-ascii?Q?XszFp+NPXWwkNMwepdg+W3z7l73MFQLGw0EyJ1SgBxjQxrbmwaTV6QGtonem?=
 =?us-ascii?Q?7YiD9YCElfLbU0qGmC3SCPV8iLPCVGExoeBydZw0KgDx6EkkYZTKq6/ICO3J?=
 =?us-ascii?Q?oz9e1e4lt+JiALwqjvQRO5L0KDkEQEWIzMGqRn6DTYWbcMkM7CBC8wzf1kIM?=
 =?us-ascii?Q?HNcmBAJhsER+g6WZGWHhbvvOfrFV1SlOqCqvwzLT4fqKo9zG4FzzLTCiv6Ol?=
 =?us-ascii?Q?ZZLFHuZz7xPnF8tt6r5YSzSClh/+cH+dCAs+b6huF+VKXCxHKY82Dn9Y04nE?=
 =?us-ascii?Q?RTsHyJG/8A=3D=3D?=
X-Exchange-RoutingPolicyChecked: mAjM/hAy7ZGg+oRoQLMj4fI5m5q5+vCfCEFr5IAMxm5iL9ExAftxAnyL/KrbvK5VxqBSzcpxbM1nKu71zlX8CZ78bW78TdOx0u5NhAt11U+qQpflylTMUiZAtBmd7BZRbZdow6pX+ZFAhWnu8ykVHioqecLkWSYIlMSpX9o4ncqHdi3/fbhIU3k8TRPP9wv6cDVSO30G+J+gWUf9dKbCboCUOwQGROAr8E93d/dY6laexLLSFhPwpsW9ncHpnoF7Dy9WJsSmBzjxRkkfk1I4G0SacnfPA0x9GK2YpJwNZekzWYAcBxENe58ETPlnbG8S+bpwy03MxNztuBEcP/9BhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tCGjr4iCUn3ks0zOyLuUU0kdBPMlrDKD7odXBkFupZZMyYDS8NjFFxOEv/fcWwjtGunoW+lL2EOilKmLFFs6cH64nXGGiJay3q814ag+718FpP2CQqbI1QNumuHn2inslyQIrPw1QWZhgxE+SSeGBJWqcqyLGldAQ5xFW5Wt+G3FsnCijeIC55w+FNlltvEamzd9qBO1ckKatI52EqnLsPcSwvJlVXYbvLQxzHrqeFr6NWryakaJF3x2GSEd6Ky7GnshKbZDHxuy9zTkzXKoW0ApQi+fkpNNIqcDlbc5g/MMesGra3exh/BUJ+o+sy1SUPWOs+kyaFtM8Ew7NkOKOIOryugqD3cgjCTSRt27FAUppRUaop5Mm3LwbfuqYN8fJkp4CDGZvp8tTafWKBd1VBQogVk46ENj3IjaCduEWjV50lMKxECVG/qt6PAHZCcJxoIVb5tqI40M3VmYaNfbwr5mgzWofCK09dvO510bcyLln9GpeTkWneA4u6xiEsqXb6Cn3Yh2z+NIqE67TeaPlLFq1CtRZukEOos8D+xZShKqMkNIYiShB04RvBAQx59Aky/PvekJ0NujYtsNww2iGk3JUd0GxqXdY3BM3riGXbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5e09c3-9fa1-4082-6fe6-08dea479d0fb
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:27:03.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDEOOQu5sH6l5W5Wt/WQ0cZCJodoCVOqFbq9vXlCTfbGITBBpL83oJZ9U/vSVgbb7BNhpOLdVLBwJzS9bGMEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604270174
X-Proofpoint-GUID: pQABOvEwSC5J5FBlyXfUgMondWHwrpTz
X-Proofpoint-ORIG-GUID: pQABOvEwSC5J5FBlyXfUgMondWHwrpTz
X-Authority-Analysis: v=2.4 cv=BePoFLt2 c=1 sm=1 tr=0 ts=69ef8e5d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=Vt2AcnKqAAAA:8 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8
 a=sh4QoRqUDDCyMhvlQggA:9 a=v10HlyRyNeVhbzM4Lqgd:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE3NSBTYWx0ZWRfX6gYnID/+BpeG
 zFVlKyfMl2hT575KXp/TvYS/FLaNLCzFpGaJmOiWpAuz6WNTe5JWnZ4k3cswG1oZz/NlRRHf+nv
 +x+ffd0he0h/wyS/1XGOTBjoi7ndpl7KFPxE+pX2TuhfQnfO/CWcw0+ukCJSgQFvT1MpxiD55ip
 siX4Sk/ZvZNFMkOHCOGaRIiVPNJ3HAFk2E3883AHWd3TRWFuDBS69Wk+5OEzad+u7z9xWMtsxz/
 vHAM/LXUE3NeqftHnuMMNE/CCPVDpzX1cwj22W+p3VqoXIWfe7rmmYvaHEbWn2DEn6AdIO5EkV3
 OZqDvsGKteYbnSZKtDWTLicKuUniUptNUfoTkflqwrmOIWaDIaFGpRQua05CcyFZCxsNxk5ct8x
 DJ9X4oPSnL4V9OmDmWQvHJrP+l49kcjAhCC7RzhlI08wQFYwj4Ri0h+hXOqFvdNXt5QLBguhlR7
 KYuMmPtYwhC2kjNmDgw==
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

Adds a function to test if a given DeviceListener object is in use. This
is necessary to confirm we're not unregistering an object that is not in
use, which results in a crash.

Fixes a crash when we execute "qom-list-properties" QMP command on the
"x-remote-object":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg1185472.html

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/core/qdev.c         | 5 +++++
 hw/remote/remote-obj.c | 4 +++-
 include/hw/core/qdev.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6..97b09f6e7f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -208,6 +208,11 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
 
+bool device_listener_is_registered(DeviceListener *listener)
+{
+	return QTAILQ_IN_USE(listener, link);
+}
+
 bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp)
 {
     ERRP_GUARD();
diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 86192dc8da..122e30af7e 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -154,7 +154,9 @@ static void remote_object_finalize(Object *obj)
     RemoteObjectClass *k = REMOTE_OBJECT_GET_CLASS(obj);
     RemoteObject *o = REMOTE_OBJECT(obj);
 
-    device_listener_unregister(&o->listener);
+    if (device_listener_is_registered(&o->listener)) {
+        device_listener_unregister(&o->listener);
+    }
 
     if (o->ioc) {
         qio_channel_shutdown(o->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979cc..150113584e 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1146,6 +1146,7 @@ static inline void qbus_mark_full(BusState *bus)
 
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
+bool device_listener_is_registered(DeviceListener *listener);
 
 /**
  * qdev_should_hide_device() - check if device should be hidden
-- 
2.51.0


