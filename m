Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=W8MEEujC;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=NJqymOT8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGje-0006Im-Gm; Fri, 23 Oct 2026 10:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjc-0006IK-8H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjZ-0002ND-FZ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:07 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6OZV3970499
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hNea1Q2VRWEuw+5GUc+3Y2CRhhSzW9YnLB9acfQDP
 dA=; b=W8MEEujC1RdZtGMCi62agpvaaPC3IXG+BLg9TdCjHuTl151vc6kE8zlPM
 Zq1wnYn+94wu9M8pBsqmeLufDjYgPyZ/kr1XozbUuAFQyVBVQD+oa3liO9keOfrp
 RANNRErajvTHZLx75E2QANrle1IHpN/VnRNQncr/enCTL1z2AqQSBsSQsVJuiXPQ
 mYJf4PSF/UxIsoY0dySP9SsyJlF3aHY4QqZSJb6q8PLiRUr6dWCsf+QoNmaH/F/9
 0Mxl7IrWrtZtudcdtZ83cCcCSVqfJNL/0kUm/X7LB7TqP11PWrdcGYd3/aCM8Txh
 AwqhQy0oq7VOvtFtFJFMwcbWnBFwA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023095.outbound.protection.outlook.com
 [40.93.196.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf973my9u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyBERKg0zic6+p0bk6P+C9zwjy9YuXAKr1qEWRDAXBEMql40apxVwk2IEtxWmBUvYDhVuVHr8x2nRwdE5/4MHlJc/BfDpIdNJZ9zxP1LfUbdSfh5ri/VN8QsTLP1iLW/X+6YgFzB2NkBqNQi81GHHSJb44kctmYvZmrB7YgHGEpA0eounF9vHMhzBjfcoHIR2WHcsjEdDs6k4QFkZvrbPZU5nKPdcKQ4SLhLORhOc/sy086Ui8zMDnJjvP0LcpWs3KdRMomBb2tERpyfnyGYEixsufa6chOjwevAjNuSQoDta2Sj15enDo9z6dnfFqzkaEhYuTKSgJlciaGQktHtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNea1Q2VRWEuw+5GUc+3Y2CRhhSzW9YnLB9acfQDPdA=;
 b=A9+2cUuhpDO4Z6ZvzcGlPH3ixAafzH1IjP8e53BEOlCpsDyi9P6u/tOha15fXr6mMUGQO0MhuX3C17mcj2uWPnQjOY5DSc2EXGQz+doqqwTUeEWfrFeuEco7/KHbY32CWketiyTaFsPE+cG+pw5mjtYOBqnzs5LHRmKlJUguqjNnbzlDnPT9gkDSiyNIjPodWoafwM46oNg8P5Vn98umJxurdYhQnQnuSHEgQ4RVJc1g6lVTtQLLLyu9dx2FeEomqaiCUUld4lVV1n7JacIzfK28ovTk202UQ6TtnlRNhRvlALuqVUa7fSzZbAiC+A/4FE01be+X2sefoNX6IYSeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNea1Q2VRWEuw+5GUc+3Y2CRhhSzW9YnLB9acfQDPdA=;
 b=NJqymOT8xyS1+OFC6swLoI3FTux8fHEjyNzWTUGuCKo0CZzia/oU/BM0wJUtSQrZIVNJfktSBf8HZBR93EKrlcOoO9c/jm0P3BRIiuAHaeVhjMk6SszAnlalH9PNdJ/Ljf/F1Yt5PTeQVZsFM4cNntgwPt2sBDtujrzMB24R55Qxmmel8VNGNkUlOYoNPvla5SkcNULW0pUR2OQ7QlmirFQJP6Cn3V0UKtqqMzYDr/vu97vki/iVi4v3NTrTyyHkHUlXi0F24v8or23GpCIh2Rq8eIRm/3pYsnDNXeS4SPlchStlNMzizUYkutYGtLcfDfgAB561G7oDp41zVTGYHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB889703.namprd02.prod.outlook.com (2603:10b6:208:5a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:01 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/28] i8259.c: rename PICClass to I8259Class
Date: Fri, 23 Oct 2026 15:58:11 +0100
Message-ID: <20261023145839.34909-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB889703:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac38232-afc9-4eaf-8008-08df31162c2b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|56012099006|261021121427099003|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ZzvaJvBhBwAYKJHKP1R4A5wMyfLQbtX6YS/AR1bTRqzyhd86i9/lcwlsYoy0CmXDElDzLxZ/W2+NqkqprVqvwo3ZsJb/3Gy1Y3Xj2JCs8JCfluAU86pmW+OYyf8K20oTlDyNxDhgJ0Z/tjFmkPlBhDjFopkJLGbZcwiy6O0UVn3Rg0VfW08N8U8v/PUqHImZoKtZojYN1wizCUghdAnbiOO2PMFqSmRMf2V1+ZEbyKvTsf4vxH25BMBMdvEqYuvax5tKe3VvEpYezbZgP7E5iMtQx1pqIk/infodGuMDx6QFJTFvDzdDJIiJQvwgAXFJHdNIxE4AGTGd/ED4u/gzvq9N2OIfJsQ+nEdEo9YYIZvaIhBduYWCK7bdqAFs8TBuF/93lftXaPj+j7eYdFl985cOoOWOaVodg0UFmHqUz6hAYhHZgugyGRWkhlLqN7H47iNfp7gEUSuc2sQaa76kMoWwmB35AHSbOAkMypBG6aKoP8a0ChHgpydTTUspBtNTufb2S3/e6dPdh+9UiQUf5wzDQf57nLgP94xc7qvscoqVHeFSqbag8vAYnroHdWSRB/qhpP7dAul5S0dzVK/+FCwTgbvB/O5iIj80g4UrzUHaIIdhIYctK+XHt2GO7ZJ8EkAvZ3rMLCeOjMkC6eirGB9smFNXYeCJ50jlR3xCLAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hlBlS9tRkGKTGAQeesTpht7Ult1oBSMBPJxSV8xkMuCp/UahExxOwqZr/oQ?=
 =?us-ascii?Q?/je9Kae83LaKdVt/DaAnsaEkzOSR1kzOezLacTn30NBdK+4MpQVc/qpt+NS6?=
 =?us-ascii?Q?6+xxicgXZcZ9nB71KYKgk0/EUwm/9yyxpnfFkFgEMk7QGW592SRO8u5BN+jH?=
 =?us-ascii?Q?Sxyi+ufY5qaeuENHFIcLmfOHv4Emp2uKYnhQDjvLCmifUDXwM98ArUoougdb?=
 =?us-ascii?Q?jfw496KC3Bxcd08OWUBVHrSmwA8jFTgzpCuekNEUER9ROZeds1teeIEcFuiE?=
 =?us-ascii?Q?XBQfhe7/EHMV9uz1txA2Ccjv48e/f//9O/mKBQK8DRUpfE5dgo4CY+fJ3CL8?=
 =?us-ascii?Q?VQZACt/D8u6m7LlqrhuqVbR05y8hFUyBpdN1F2qdXMthfKJhqPAvZiPDSC7q?=
 =?us-ascii?Q?r1JVi0aKYq/Gnr6MIfYa/RKh988sQ3tkItHSIwejRxBaMIhjm1XJVZ16Owbi?=
 =?us-ascii?Q?0+tCbGBs2WxK40McYcfxguWp7kQ4RxYwlpPS0cofBLsFBC/YbTFaSubF0TkV?=
 =?us-ascii?Q?y/4zgWRubYRyN8JaY7uU2GVtmpcgO3Jd5LrIq9MvwlztfdwxidMWUByDV7Br?=
 =?us-ascii?Q?oUP+oHqkhQE/o0EKD1wkZVes9YQ3lszMc5O8V2NKosUJkhlhKQTWKRZWUQ8/?=
 =?us-ascii?Q?AfylbTMp90/tbT3JjOd2msOWmUhBXJFk4lV+SLvfra311g50p90PZPq3ekqQ?=
 =?us-ascii?Q?Oz9UG4zY5/fUhRf6ldTnBnSdwfMmZQLm1UdzHQvivrRxe1ulF/6TkUyxE/es?=
 =?us-ascii?Q?OcsYiAYoU9gZPGgiE3wJNzisGy3xG/kknrdr/yDoE+ISMqfLFXfwGXAJ0Roa?=
 =?us-ascii?Q?sTe/BcWMDsA1t082o7p33Smz2dYcIO1z3yij3AE5bGS/Rn1yXgelXE2QmkFR?=
 =?us-ascii?Q?SYvIQYivXA5mbmd9GDIVd+EH3p0HltXAyNsgog4RSnM83QQi76ITUN1USR0O?=
 =?us-ascii?Q?cVeCpVfVXqx3ReKlt5uyeFB65+5gIeK3xuCTy7QNQnlDIRrSQYu/wiu/CYve?=
 =?us-ascii?Q?BpiFfAKs37R2jXsMslUuYihH8zLiJCPGh/9lJOvvw9kraeG5hca6knlgtxnh?=
 =?us-ascii?Q?dEWOHz368YnIa956KId0oa8iMCy+rpUEcth54FpAfp/iBfLERAmxzCc8twJu?=
 =?us-ascii?Q?DZIko398W162cBccAIIOSpAMKwl+EhxDhbSSc88U7Y+Ka0f9cfuHqV0nBqMf?=
 =?us-ascii?Q?Gf7aTAJY2Pk6BkxdCtjfunY7xbPsz+Ib8fWhTr1/ra8zC2QSLI5BfE9zzyJV?=
 =?us-ascii?Q?Kj7Mdypt+Vt7QzDK8q6LXVU99Gp+rBf5xF1aq1R7bf83KFtAM70yjLdrmgex?=
 =?us-ascii?Q?HbF/LeIFxNITldmj7gHz/0OkwUT3arqbcj32g/eeq2SWHKEgrZGCIDrWc3xS?=
 =?us-ascii?Q?rDr8mP/X06Q+nYeY5X111Vz9Lmc2wa6r7HFMozqOo7M82dnWpnKrBwXZLjOh?=
 =?us-ascii?Q?NxgzPaoE/hXhJqpUd3bZyqfW6I/lMugkO5TjxgykZmGNkWSYrrwUvXg/IOqT?=
 =?us-ascii?Q?+1YCPrt7gfUvtL6h6lrdzt99eN4je6BIJh+T+Emx0RlB2oWaoPLCYYz1/a3w?=
 =?us-ascii?Q?YaiImQTTiunuse3RWUCxoEC+LqZJHHuTLtzngYF/ZgZNdhiigFzvuOJlCodp?=
 =?us-ascii?Q?VuJPKO0VUkZFGlWx0THvnZqZ+00RB0vgJZ5Lhx/zDDFKV5Bk86ZUodGmNVjq?=
 =?us-ascii?Q?gXgtdqO72xgtuOmRfLQsFYctzT13APIJJBbHu3pQPhf4tZ1/jJhogB9Tztof?=
 =?us-ascii?Q?3rdQI5DsWrBh5UbXrhwPZsLLelQVBQA=3D?=
X-Exchange-RoutingPolicyChecked: cV2A6X1oCPV/HEu7qHGcKlTWK6jaZFEYSqBmo283j5l4rP6hve0gGqayx6T3tmQaPZR4AUYWiyucKtHZVLi1+K9uQQqML+qQFEAYecPK084MXS+1jBIuAFkkm8T3IAaJHxjouyTqrhXmEd+yMzEJzSSnYyvdysVCU1+zps4FoxEpLCSr5UL9oZ71tye8/AiytOtrVqOJv0LiCcsCi58wZ4zeB5NepkKXu5G+8h20TQzXcHZLZvrkOgSaHUYv4fsXMpzzXLBBARnYXKaVoHsKlMySBA3K2dJVKi4qP4Um9rxS86AnQKPylI0bRSPAITuh2sq+GTyQjZjxe+Px9G+ubg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac38232-afc9-4eaf-8008-08df31162c2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:01.1975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+qLcfxl4o6UkVsEJn+Zm5krFlGGbB0eeP14rmKyAPTkebfI6G1itF0nhKNW0x0KQxs46ZMZXnVkfZutrwpzwiIQP143LW/e7602HGwHot4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB889703
X-Authority-Analysis: v=2.4 cv=E8NYNqdl c=1 sm=1 tr=0 ts=6adb7637 cx=c_pps
 a=zeqdZPKWhHZd9PAB2DpU+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=3XFHsOGY_CSE3CcXMRUA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX6TQjx5BXvgCz
 O9uFKXkmQTD9lt2gBeW77SJr2mZ4PPtPMIxYO2DFR0gjI7DneUQ0X7DcOnIs08k+i3I063mNZv0
 1DbKDB+UR4rziRkckglkGgkqxFx9UdVdUsgZnEe7TCqt62jOmrsj5L/aT3Lub2ZfG9jXIe6dXLm
 xWjk4z2C1rl83H+o4g0W2btRk3AHh2SyXWYN7oRyeYVj0ph4Op8ecEJIvXbA5beavC5N5mz1K3c
 Ohx5ap/ROP5XkPrAfd5K7HWm5NB/2/x1NChBJUIOTxJI5TzfPbdDk8JD016UGFOPECHuG4jpH5c
 5mC+4a62kbq/hrN1fZjWxz0B6Z8ylti/0lQ6txUsVijImxFn9bTDXYKIDQDB3diDNP8DI7vwHgp
 g829ikEhA8p6kinEYU3Ivo85/yf7CkPFjN5oET8kvlZrX8kl/3SeLGn5vdHlo8aUEnrZd9ah88Q
 0PzagDP6mjy8WnCfaQQ==
X-Proofpoint-GUID: UQVApQCytIG0Vy72-F08fgPaxBAD93Ex
X-Proofpoint-ORIG-GUID: UQVApQCytIG0Vy72-F08fgPaxBAD93Ex
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4T7aXzbsNewy
 IG6yGKvYEFT9ezjxduw806GjOeACEuy2Py6wXtb4Elspkn6FzO/nHPUzM0GanrMdTWM5LKedvv3
 9qwabIB+qmlbPpioCm/rDaFah4pxwDA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is in preparation for its use within a QOM type presenting a single
emulated 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-6-mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 547e86c5f4..856075a754 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -35,15 +35,15 @@
 /*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
-typedef struct PICClass PICClass;
-DECLARE_CLASS_CHECKERS(PICClass, PIC,
+typedef struct I8259Class I8259Class;
+DECLARE_CLASS_CHECKERS(I8259Class, I8259,
                        TYPE_I8259)
 
 /**
- * PICClass:
+ * I8259Class:
  * @parent_realize: The parent's realizefn.
  */
-struct PICClass {
+struct I8259Class {
     I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
@@ -388,7 +388,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 static void pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    PICClass *pc = PIC_GET_CLASS(dev);
+    I8259Class *k = I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
                           "pic", 2);
@@ -398,7 +398,7 @@ static void pic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
     qdev_init_gpio_in(dev, pic_set_irq, 8);
 
-    pc->parent_realize(dev, errp);
+    k->parent_realize(dev, errp);
 }
 
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
@@ -435,7 +435,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 
 static void i8259_class_init(ObjectClass *klass, const void *data)
 {
-    PICClass *k = PIC_CLASS(klass);
+    I8259Class *k = I8259_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
@@ -447,7 +447,7 @@ static const TypeInfo i8259_info = {
     .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
-    .class_size = sizeof(PICClass),
+    .class_size = sizeof(I8259Class),
 };
 
 static void pic_register_types(void)
-- 
2.43.0


