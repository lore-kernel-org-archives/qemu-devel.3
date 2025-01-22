Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 19:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tagb5-00007U-IE; Wed, 22 Jan 2025 14:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tagb1-000074-U9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:41:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tagb0-0006fr-CX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:41:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MJZZYp015479;
 Wed, 22 Jan 2025 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=eN66mwkCKnUqqG/qJMPMEcWfZGtOFTaREsdRRObWx3I=; b=
 jlMxgvzFm6RUXYC6T9SWj5mvqCItexSprxeDQXffEuAamkyFfHgvLG9FWLANTBxm
 uW3yhcI0M2vkSZQw2v6kNyoqtcZ0ywDLITlUx8vFdSl563A/BSgp7d7PGVvadaly
 +z7WPsIavy3lN95AhM9EtgxOI2WzIDccUlxtg4W1Ddp4xFbLeBDxdDawc5OFTqOX
 ezlpqZdAZS57X5iyf/STZsOuRXhl/GSVexNGpHypR3hznn+W/BnYQFcxknjMWyoZ
 GMQQAs3MNGs6riSwnD9ajV4IgyrR5xEeOP85meDrG+7R2JpKeUYgnI5mwV+NF/P7
 iGiw/hO6TCu/kTEfgq7zLg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qm0fm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:41:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50MIn9OS018644; Wed, 22 Jan 2025 19:41:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491c42d3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyJlG8RfMJyolWgWOMIvkdNP2Y14BzqgkVFxLG6uHfAB69MKIrQ3xBTF81Oy9ZxVZgaQU6oVrS1OcREQRo69c6qh6UwfmGSr2iioPac5vx2JAA7Z9GpFdfoTBWWhf00P24bY4nDqwgqc7ESspAnbHqebcF3G8GpVEbds19A3LzlVoLmsaBNTqJeAOBfDEfZ3TgddwEJJ8hlyb8Nkl4XEyveTcQjXBLr1kQSlsh8t95fNMrysOq7IePxB7GAO6TrmYc3xJmvgUP74dIXwYgQj1sJpN8zJH1k+wQ0rvlNS4X4V3UiSV5h/RtZh9k612YE6G8DdqP/ztrV90pwUHxQFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN66mwkCKnUqqG/qJMPMEcWfZGtOFTaREsdRRObWx3I=;
 b=Sd6d9hN7gWJ9tvpRYGV/puDJpongDzSqO+inX28HLHejxa5/pmtjoiDkGvoYhzgPv4IN5pWKe8NpmN6fx/VPzjuNkO1GYPCmpkJHW4Lti4SoU0Iiq9bKyNgJa8O/uWuVFS2IcnLdHVDs/0qrB8bxyy5dwve2OwUIP4q7ejUAUApO+vgL03X4Ll8I0WjhwQCQCu1s/fRTbpkTs2rQPB97tFrM+WVlaojLUocFSV4Tnwz6i5OaL/vyRxx8BDdx4vRvaTxYl/uzX2pI8tfv0qUk7WNrRPiyrQ47xRhwEsjtbv9kxOpSz/O9jaa2LKVUXyaG2fcFfVS6T6KUVdDNlBvsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN66mwkCKnUqqG/qJMPMEcWfZGtOFTaREsdRRObWx3I=;
 b=g1zDtSxURzDQEH/LNTka1UQISqBV8swC5B+rBgySD0rfIe9ABytpHfm6RB0E8x1xucc574iwHajCNi9hAyEALGbnFm3z09UzZduCyigbkOoLUjSDfDHYww4SzSYf0SuH74pTP2tRLiWWce5ulbqQeC13MrGekatlLUBVdltUSGE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:40:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:40:57 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@linaro.org
Cc: william.roche@oracle.com
Subject: [PATCH v3 1/1] system/physmem: take into account fd_offset for file
 fallocate
Date: Wed, 22 Jan 2025 19:40:53 +0000
Message-ID: <20250122194053.3103617-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250122194053.3103617-1-william.roche@oracle.com>
References: <20250122194053.3103617-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:208:35::37) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9ab5a3-9db2-4439-8fd4-08dd3b1cb146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XGiGKxs0TQqd/Z6jaQG62ocVuBTJzApMTyxgCxU2yf/LzjfOGSyk7FWpSG9M?=
 =?us-ascii?Q?L6gsL8I6qQLOc0sCdvclXt+d+EjFrjwar3SPYvaECyCU4vuGKo35u8bKpcNm?=
 =?us-ascii?Q?mo+TXZQIFZVBKvHN+jlQrOoyTaDUkPR90cG8XkuhMPvUHLwaSgOzRGkI5IO0?=
 =?us-ascii?Q?xKz4kKA7Ya1bxYtf0yO7DAyW9cZ9wD6hq5abHUSz5nGPMJOo+XSx+4cy9wMs?=
 =?us-ascii?Q?YtiGzqEaUonIDbevBETrVUb9r4FZmGNLBEkiBtc1htORuNKf/3o+lgQh4mBc?=
 =?us-ascii?Q?rnUGiaxKNmuCTv9z4EczX0rEiqehC7mZzBPxilQJTKUJzRznSlyX/7BdzQ5b?=
 =?us-ascii?Q?NOkG+0YgIChPXk/UZMryMj1pB35NOOMbJYrg+WtVaVKmRBHwZx3AwNF3pp+W?=
 =?us-ascii?Q?7a6xcGiExeVgpBUtCh4Y2IEIzDyUsusvOxzvazYgyHuOAPNqnPU63DsT8s8q?=
 =?us-ascii?Q?JRIHIssSphdRpoDM2BiRdNUnHSO/eyp32uAZqphi1jTF66pWYZqA7MHC6At4?=
 =?us-ascii?Q?e8kPI5hOBh+vIS3EIRx2+85VSSHg8jqHPY4Ym7GBovR/oJMGBFre0Q00WHey?=
 =?us-ascii?Q?hLplyH72kZkx8gjDDWG2VOrCOZ9H/zMped+Qk/XbyAoonwuECODyFUo/SK1K?=
 =?us-ascii?Q?zmm4s6wZL6m+lALvm1ao3kAcyDsMIeW/cZeLZq34PBJMEoCJUYnlCYHERRHg?=
 =?us-ascii?Q?7IKh9bIp5FxPCdVkzM639Yg5AMahovh3AxQuYHXe97mj4Ypi0OhnSe3SNT/o?=
 =?us-ascii?Q?3kzvFu2m+KFGa5abKK8qbGmIfmhWNiV2Y7KSVjEnr36hM3UPRiere3pv21q7?=
 =?us-ascii?Q?6VSTX3N8oiPjnrZ2U8LtvfHz/yzSpURlMUSHT/qJbZkwOqj7mPzYRxNL4qi2?=
 =?us-ascii?Q?uCHfcFvULk93f0CYdChqAZLFbLk/Hts+af6UQVLrCwyfVhdJu+tbNIZ/gfSP?=
 =?us-ascii?Q?YSHIg6bzV4f3DDSiUjHn0Dks0sY1yDFEOEsoc4j8dc8/onYD1M41btIBkWZZ?=
 =?us-ascii?Q?SiRMfb5FIVF/wiGgdsL+m556onIuRvSpO/GMHCSjXqggZIoSJrrI/e3M6GkK?=
 =?us-ascii?Q?QSjrBIjJc1D3276JX2TBxUvt/txZn4HjeH3LYFjDFq0jBgepHeP+wDUPQK8U?=
 =?us-ascii?Q?H+wI6FQTGFyU7X2/f3So2ewcj1heE4YpBnkWa28pND6LUuyME1SXtLFX8Het?=
 =?us-ascii?Q?HVaRGsVyL/c9Qm9Tfu8DyVsKWHTu8kgIg1Nno9Ey6T+0qVgH74BrPplnGCUd?=
 =?us-ascii?Q?YlKSBPKOxLmzQivUebWsjUtgPzERg6OQ+nXV8QamNfW/NjyRC3urRiiOj75f?=
 =?us-ascii?Q?RNa8MhZ634cvqFW9WGXXbhV96vZL2+UffS1UUoZZrL0BwLH/29YyzbopQB1w?=
 =?us-ascii?Q?/WVmyvzweQuiaNSGnA+G1pbs+jbA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5qL806eAZx0IrHKPtTtw0IQFfQHWQCFcwqROZ84JaHffYrlA5Cw6PCj7gja?=
 =?us-ascii?Q?NGFi6q1fJDnbcRBo/zVqH9DeZgS2qfXWtQodr2bLZUSAfV6iHnwS7pyStUX9?=
 =?us-ascii?Q?Ebz10hj3BGeEoTMpfeOZDiCobRGEjRD1WvaMB1C2WzguVSCd0Wtom7VlcXuq?=
 =?us-ascii?Q?/W6VH8WJjVs+5SThE5CzYMvAn1EdZ1dzjX0eCPboUsnodQiTFyHz+oWZ0Z36?=
 =?us-ascii?Q?YOSY15aTZ6/7bUHIZpBJm7FlIkrOHNb2zuwF0MQR+XzEp5ZvZm/oPgwzOz/R?=
 =?us-ascii?Q?VbSl3HXP0/Kb+rCJ2BJPFuEvrJddunzbZBkAiLIcgtILULsZEJVYVzeaaMSa?=
 =?us-ascii?Q?OvMLO39ZpZKOmXX9xSMkdPldfGByXd5MAKM8N5JWMxB27WRTwD3zJFdCWUYC?=
 =?us-ascii?Q?wKwQgKNX3HHPPSwj+HPrIUSKeOu2EKAvF/n9S+qB9ANjxmfgSnbX4ZZgkqzM?=
 =?us-ascii?Q?keQ1etUsoVWECXQDFceRLFCX55FpZvNyjvukHic2QoianXuAGTTrhM+qGhUt?=
 =?us-ascii?Q?xaEPHgBZxprgJLgZvQdLqL6ysB7ZUrj1bUsKcpfls/AOLuK1/Yzh+Jv76wWe?=
 =?us-ascii?Q?3uk7Poa66J8yUY5uz6MDt5qebUW/xeH7JEqtsyS/kM5h3wUU26c1UD+cT8rM?=
 =?us-ascii?Q?wOanf9MS5RJkUx6LWbFcJdbP9stirboLW6mPd+A85LfOjzndrr17rFdMqeeZ?=
 =?us-ascii?Q?GvB/SRRfUgX3yHsoPJ9MLTyfZ+fRU1UNXRneiDssOfsdvvwwKj5X1MOtFYr/?=
 =?us-ascii?Q?chy+utrw8HAlMwcIdvlsv36FlC0pbIRnxIgdXQBY8UoRDw8ZXXFydJGhCCau?=
 =?us-ascii?Q?JH4DB+B028uctJpyMLiepacfZGO0VgWDEbODcYLB0/YqzImmP2zdM0VmTqdc?=
 =?us-ascii?Q?r0pIU0KJFgv8SAtvIkLE9xItSu47MBVapWIETKWWkyRtNG343DYwt7vqGr+w?=
 =?us-ascii?Q?G35Nq6XGUZdGam65EZCsU6sC1ha0gYD3dw0wpFfvCQb7Jx359qXKZB4FBTUs?=
 =?us-ascii?Q?sXwnRpXK7et3v1Lp1k8zOhwq87LQG8zgGbjEyQKa6LgYveX84vrPZ/OMUkDJ?=
 =?us-ascii?Q?lwrHvWxJMCSXVVgYE0Xt/SYzmqasAjnryqs8V54bKRqYF4w+1+ha13m3YD5h?=
 =?us-ascii?Q?km3mll9g7eUOF2Qg/EUhugtpNycAhjPhfCXphlrroLS3sa6W9O9izv/2O0qV?=
 =?us-ascii?Q?zQH/WWInlhvtvSb6P1zo6VegKuFZxDOiQd6g1P5Lr9aA/YqVbVXWFbWSmYqr?=
 =?us-ascii?Q?NatGCiAXGehqEs/r5DyU3jV8WG6z0feFX9TXPObNK6Ud3jpqiDyLINQZJ3p4?=
 =?us-ascii?Q?HuEQoncdmK/rmkqMEcnX1rw/c5mMBWK4e41XPMLv2ZKP1RDiaIPReDpl3tjv?=
 =?us-ascii?Q?9LUdfm3psUnYS17ec4n+1DL8sf1PlV2MvJd1wQz3Zv+LmQaHUCUgbv9a5bLz?=
 =?us-ascii?Q?Xd68nCkEH9vQudH9P5mrjx+hOspNo+XV79284yWyqjF8tol/PAM+jMFqcSeC?=
 =?us-ascii?Q?osN1vNhjqBvZ0BAEnCkFGx91AakI4lY8oUSmyf8L+5PgNHqW1SGkQMmIeqW4?=
 =?us-ascii?Q?SQxNDP3HYx1hdbFXk//M5rH/tYjF4BwMqMJVa6nUdA1D5f0Z44QsPpbn6wH+?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PBTUT+rWetybChiS2Jl48N9NUIf4Qn4YqJfRu6NA0RelpTWJcmn5OsUXh6P2EhLPQhb7aOKkqkGKVEYUDV9SSpcQSVLqPjJ/FUHFaipmVNLL3xxHg3T6Ex6pKTnedcCunnDCfpDqsYsY/UWbq0mNSA8Q4LUweMTyXwJOmAQe86X+o2c+mL+VJXMCiwCfCeB1NqJgqMgbx7fwBtpuq4ybHWKWofEqFh/Xfaw+kG5AHhPKx/1iXUo3Ppd3IVfUGoIMxYEXbUMkaX8osKN95gFx2g0BLfCPQeBpWiRixiM6H9kJ8jUiLXX18u5OwJbl7S7XRY2xmufSVDuEwTdpMW46w7I2yjCqAXizcYsf4NiCigh7mS4r5vgc631D7Xo0QYW7aKEYd2Fu4oP35sz3ZB0tzrvFcC+HZ6mIJhavTUqyW/BVdAITz0Uv2XuuNUO3PbwptIvIpPc8RKlRxsO3EqyhCCQYSEzgoccB5CynbqwSUpXAWEgpMZN/1mg5kqIockp97IKBwl5sKndhMaFYsS1unfSdSKHqlTGbvFQkw7IlVOopMVr02Lci4uvESoaJz72BxabEe68jfYiefm9i/Z7aR9xFNIYlrycN+S7J6HGsBAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9ab5a3-9db2-4439-8fd4-08dd3b1cb146
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:40:57.7042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsRbJnSPpN0Y7ejMrWeDGZmtYO9aWnkB7v/pJcJ6Ih54a3VTnj5fSY79QuGGJ3sFA1+CWsY7mt3YeTDUmEleyYporwLhE4EC3BfSSlut9Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220143
X-Proofpoint-GUID: ua-YUOGiLVVT0wPMJSHN_PMbw85keFTA
X-Proofpoint-ORIG-GUID: ua-YUOGiLVVT0wPMJSHN_PMbw85keFTA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Punching a hole in a file with fallocate needs to take into account the
fd_offset value for a correct file location.
But guest_memfd internal use doesn't currently consider fd_offset.

Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..9a449ad4f9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3689,18 +3689,19 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                            start, length);
+                            start + rb->fd_offset, length);
             if (ret) {
                 ret = -errno;
-                error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                error_report("%s: Failed to fallocate %s:%" PRIx64 "+%" PRIx64
+                             " +%zx (%d)", __func__, rb->idstr, start,
+                             rb->fd_offset, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
             error_report("%s: fallocate not available/file"
-                         "%s:%" PRIx64 " +%zx (%d)",
-                         __func__, rb->idstr, start, length, ret);
+                         "%s:%" PRIx64 "+%" PRIx64 " +%zx (%d)", __func__,
+                         rb->idstr, start, rb->fd_offset, length, ret);
             goto err;
 #endif
         }
@@ -3747,6 +3748,7 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
     int ret = -1;
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    /* ignore fd_offset with guest_memfd */
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     start, length);
 
-- 
2.43.5


