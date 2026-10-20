Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF260A2618
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=ThxIMG4s;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=W5/t9bUP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBvI-00074w-Iv; Tue, 20 Oct 2026 11:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBvA-00071F-OG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:38:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBv9-0007Fz-5I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:38:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDCHDI2565374; Tue, 20 Oct 2026 08:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=gtU1ZgHUakagwp8
 XC6S1stiwMp20fKHwhwFq1w4wZs0=; b=ThxIMG4sYu2198gmVCFDyF2rM5tp4tj
 +cpeRIbLPLggCrSWkvKs/CSHSGgNsoNY42JoFQy28NvOPMq18FT8DhDYu7dyZwHN
 r9+Itdlj6mA1KdKVLCHreAjucu1Gp4vHmpViZKrqAlI7rh60KRQlksZvmC8Nlkh1
 jyIBkXNaHYThTpUXbc73uIsnBkxfhn9Uku9vQbihwfkWMWh0qD06JxkP/QenKnd9
 yNyLYqCPRhoXSwNWuJOVirVIYJhBInFpBpUn01om6plwHF6+kfAHHbcsS8dXAH2Y
 XBRlWDNCRNvvalQBjg6zNXtbhBj3qac9Aaq1SRplzz/IcZ6zOWvAilg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022139.outbound.protection.outlook.com [40.107.209.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdw5p9v71-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 08:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2rsuV22+Qj8AV1JRlS1adjCbjwgn+RgPHxxCSILxFdNve2v8YezrEu0GFpylZsiuObIr5u4DaIVUEbpDE+0+zIJBkiEi6/aQ+Q/z8SD+iqkEvvYf+dyhB3M8sELKVNAG7RnNou2HEmEayPh/Ff7p8VbEDMvLdM0x3SnO4P22MtE8DEPmplF9hCtcJyncz8+NNjJU2Ofw50LJt0AxqejP6fHCQP4QbkBk62TEPf0+7knwFK/QKcYwYrtP/fnxyNLhWPZhqJqhpTIzuBwW7NJ37IIWuIHiOMiwCp4RqErg3Xl0Iat+5SAPBm2OMIKJ0hvqW/5oTkl9lsmcPzpiNMUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtU1ZgHUakagwp8XC6S1stiwMp20fKHwhwFq1w4wZs0=;
 b=q9nbO2exPCtaP9STHAdA3mUIXS1ZpDOFjMbrlZgNeTwiydGvjWjhjG7F3PeaGvC3lU+sifyyWk+yrXk8czbk41GiThPBAD1jjzz5FQxtROBWiOWVQfVW76jTxKtMUS225DQwmZsSfYgRUj2Rkd0YhLV16v7J0YQgzmnU2zCtJWhO4DqXYw5qoDFvn2z/jRtV/LWhUQ/TqFkY055iJm04JRjZPUPbc/dGaNXHBPa/O5zLKsnPKt+IyVYuAjyCflBPdbP5zSLSq4wrnWDF77p5hr3NV0pqKSyKeS6wU9un5+A0zPl2MPJ1Z8vLfT2BQ/uuUrln9MxiqDpTFjns46O4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtU1ZgHUakagwp8XC6S1stiwMp20fKHwhwFq1w4wZs0=;
 b=W5/t9bUPzjZnCd5bMliVzvPFsLViIpwLbzWe09grAS3IGJ5liBngSgqBPK4Yy7Tq1fPXzp0gQKvlubTE7dM3TL8JUULvKiu7bSVui3VNr7JfnpW9BUX4J+otQntTj7qrQPXDVbVsTwa1qxYHAB989UR9EKJRsBfndrGHHtxpbWkzJoOlzPmuLQs/gwFvll+ZSc3rmJO+bBIXY80SNKdnRG0C1IskF1BYgfDlChrC/Xg3KocB3qyOstqVXzQqlLoT/i4vF18y7rvgx2FhX0uj2Jy0Z7pYgtnB9X4NRTZS1bp8qB6nyl+9LW/IEyG5ra2Z/MDU4pazebT0/JXFv/8Q4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MN2PR02MB6750.namprd02.prod.outlook.com (2603:10b6:208:1d7::17)
 by CYYPR02MB9928.namprd02.prod.outlook.com (2603:10b6:930:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:38:28 +0000
Received: from MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2]) by MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:38:28 +0000
Date: Tue, 20 Oct 2026 16:38:25 +0100
From: John Levon <john.levon@nutanix.com>
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v5 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
Message-ID: <ateK8UxU6v6gPzHN@lent>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-4-namangulati@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014211041.1087331-4-namangulati@google.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To MN2PR02MB6750.namprd02.prod.outlook.com
 (2603:10b6:208:1d7::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6750:EE_|CYYPR02MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 146ea293-de4d-4956-38ac-08df2ec03002
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: bLBx8/oH33F8ldA2CS82T8qldCDX1ekNAMmtNFZ+pW35X1CSfr97hQXtHoFJjK1LK11FP7f+R0G3PWvxERI6Cs/J7ISJujSXQ1ChLtukI4a8kTjnFovfpASTsbj9Ni9LPPiQBBTHryDWdR08v3g+rz7sceSHb0dcV6pHCPgXBci1lZ2Zn6NYKhnp6cXAlL4sMj/Wh2JoH7C3oYp39oUXm8inZUNJUOjX+EmJz98ITMDwJmPw0aa3v3ErECWrwQDdSFgMPq37hke5CrQ2VDPoXNQatxVH7ZkKf+Zg5ZWh5bKLDGQAW1Mz5iNQjkI0R0g5OdaeZyT9g3BetWOiTGEJQhWwU+pcd7PHGX7QO6Y3Du/egtZYe7xg82h2Zulp69+1COQR/FNUCOa14/zTivgkzw+nnW0LwMi2Nh0i74uJmaEKp0TYVoLjeVfwdht6lbLvB88HwiNjk/UDvIqSu4Om3S/H27l9yWjQ0aAhCPoL711dUSv2bhu8CH4VyuXWU++mG4Wo37J6L9ZhL9/X5Q/kf1A5cvVAkq4lpnRy28S7Vlp5UDgy5JHPSS6FCVqS/giqeQiE1xFISnVzFDYztCmpGjZhRpPwkMi0kgHuZfhcgSMJzrf9cOhwQwo5CzoVS9zT0j2v+Uw9bpkBGHKGT8Mmt9SYv2vXPXmp4Q4I5ExPWIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6750.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ejrbkk1MN47viT6/qky2/YkYc7OeeMDgeo292qu/iBIpf1syV7h3EjFY+Pn?=
 =?us-ascii?Q?TDeccUFR2dtLwOxi1iBUnfdu0ia3bRty4ImyDhO0vXExQ6o7Z28QyZhPQ5Hx?=
 =?us-ascii?Q?nKjXgJcB3EZ+h7GsmOVRAuQBgh8V2zeXKXEk229wwhAVur/WsRIaYHcJfREY?=
 =?us-ascii?Q?mKicbjA1wNCw1eqeqTSukgqHrMLdESSDnnTaT3vWqh4T76V2hxHxe8ZkcgHM?=
 =?us-ascii?Q?TIT4d5GYxGuhEH72++59IAtXeyK64HpAkjy/E1p04CLsjBIAkrzewLRViq5+?=
 =?us-ascii?Q?5+X1qoGZZSEeA2pLNqU9iSUZANPIWegxh7Q3M04/v0X689+xXB1z0EKOiQdg?=
 =?us-ascii?Q?VPEpCzAMBb7fLCkl1Kys0C6LEb0IkYL7W5po/DVe6B8byWAWNviE01+2GQlZ?=
 =?us-ascii?Q?ntsuExCWTGuIqRnlEUdj8F2IItDhfQx+Ia6MqD4qDvuCPBE1Fpv+YyULGlsn?=
 =?us-ascii?Q?W6lC/igeA1Rdm6uBRsWunpaCy4GXDS2aP2ImzbxI8C/Ev2+ZpjFugYLPxuXQ?=
 =?us-ascii?Q?UaWpsJNzz0mETnHppBN4z9rmD6Ji6Z3TPjM3m5s3Et/Mv6PVeZG034RoLYmx?=
 =?us-ascii?Q?h0UMAfv73R1FDxRBtLwI3F1Ko5I7h0Ptvc/ysjanYhCq3ZpUmLfJJ4ec9elX?=
 =?us-ascii?Q?hm+CgvVZXYmCnpWiQf1r2TeK02UXPppYT82XvbilDrjh1P8swdmFOtLd08dc?=
 =?us-ascii?Q?S5SJ//Vl+83nOZLEytkXBsFBWvmIdWXW+Dmb+Jbrx8djLRHxQjMV+l7qA54M?=
 =?us-ascii?Q?ZceE1cao0bvdko6vuAyS/AG2ZnscPmB/fRRLtLeCjopxBIAexVkYMWBL97uq?=
 =?us-ascii?Q?pD4sS88vZX+3Sg/2R/MP8P9vb+wBY0SiAVm4gT2zIvBhZZeMYlTwMxlJko8F?=
 =?us-ascii?Q?MZS5cms4R0ZSxWDSN+yb5dZs1lD3WByBTa1WpeCGPAylPLY1gVz5vyejhFA7?=
 =?us-ascii?Q?Z64Ab4MlJkFTMDI3c2H+ozKDh5v6sB2PbAPrJR6260xcM04h/iVPbzuksqsg?=
 =?us-ascii?Q?K1g0ziHrqTfdPjn4W4ytncRG2C8wBlHVfyoyJ/p0RbrYw1Gfm1bVEl6tR9rj?=
 =?us-ascii?Q?UA/YgfDtpvmPXmpZanzglJ5z0IDlmzHsNoslfZJMfr9HCbjzqCJjVX5YLxyo?=
 =?us-ascii?Q?H1OPKPQGBlCTcYk+yyEG0lUkVBJ3oupl7XgzLPsbt7vxR1g7zqUlSUaH0gKB?=
 =?us-ascii?Q?Fm4mX7KCvUFYGhp8vSHWmjXLRzklXRcPYVO1TALJ3ypSFCKsW6lKsL1lQPoe?=
 =?us-ascii?Q?e7RmqJPKHEuBEQXfeKWZan0lYpzPeCSi0AZjziAVdcRaV/3pN8XVOFQdEBGt?=
 =?us-ascii?Q?++JFb+8ik8VWI3W4ubo+i962r8lo8SfBZ995K7Ze76ohyDYemtsQXkZZRMhS?=
 =?us-ascii?Q?8Y1QrjEJtiy+l0aZ5uCJVlgw6W+kcWy61HNQOvmxs1xTuRKGWt4MV+n10IzP?=
 =?us-ascii?Q?CQQkB8CpgCk2KuHBwFULPsF87pwal/7CJAhK0xBpT/GCAbpRHyqUGF7vfuNe?=
 =?us-ascii?Q?bNtARsjtUq5lE0xg9RqWodSCVJC0h3XBrmejiheh0SUXt5+CxWR4r/zFhyZl?=
 =?us-ascii?Q?YLdrTEZ6+VrHwJ0w7E5n2d5r4yC/HsbxgS14Ky6Wg/6bA+XfQoDst8TyqWSn?=
 =?us-ascii?Q?LgxpFV3blhR9V25fWOWfdAg8qxVxmiBr561OfpR+nlUu4YvllyyuCcMQYEjZ?=
 =?us-ascii?Q?2QWGQwYrr9Lqovug/H9EUpTtnlmaf5lKm2Dhtf2hbryAMsGrDnyaHJOIZtEz?=
 =?us-ascii?Q?hkKnObuh/Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: 45J3sdMgOCtF0NBp3pRjgHX2uIY0XzkOLOpRAoXpcg3j7cUQ+lPR2opcDsjih+OB+FLjIbYaAfphkgmx0sALwwMtMIcloIPP2AcT5uuV5sRW7N8gFq1YT5Mxah2Cr9ofyRUGUATJHQW0Ot5ZUT1VdAm6iVSeRAgZGxwmWoYl93vdt07NI9/xu1S+wLaqkdAOmI90U9JMykw9y0+alMN8qwZwIlZLIdudkWGTjWzc/RzaabJYmEFAS59cyUE7zvtDxL5Twx8QULpdFSWYA9liurIupYUvUnjvez3AMxXufN4v/AssunlTJydzBUBzPQ5v8SGOw7vxGEcjoA3PSQYoWg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146ea293-de4d-4956-38ac-08df2ec03002
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6750.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:38:28.7144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYREXYNpRPPSCJw6nG98jnpM61DsQBVZ9iiaMXKKjImhhSb8eUZOXXFSDVa/OZELs9q2yiFFTPIPSWrQuTCFrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9928
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX2mLs9S4DO1gj
 osIi9VYWR8EDnYqXer278JI1NzSIvZuwBXbAb1c2MH3yAuQ7CeCVgh894gMHuzpl4lfMt13Pz6I
 VIJY6yaHRmeB5w/L7AMyOTeq6Eh+OGGebV6U5pTmha/MNKXSxHHgBs50QQpRi20KG0pBCYuqDz6
 tQqkKM7ccImDnKyALdhDhS0r8P1CNoPDzUm3Tx+wPhhXfVJEW9+Y3RmJuG5jW0g38yXCKqGo0UQ
 lKcjU79ibAWo0YhByHsGmeIaPGDKtLrboennb0OcHO2vakedCC+AtLNg/tA5Rwxym2iqhJAq2yD
 c9YabMGWZnd4VjlqXlrn3d5tR5Wwl5NjlC49ptfnyQ8DsZxnhQi2tgHPP4ZfACHViVsDOUMbvNv
 yN1kXOwH9rlJdQxldPkm543aFeR8WBnn2SL2vxlSPjS41fHp1mvoyqp6bIo5eDhAjmxSGnXtvDk
 AZKKqkBoPXLnWVWzUPw==
X-Proofpoint-ORIG-GUID: NHqReQUmjnfuY2VUsYdfw_zKgn_PNCxm
X-Authority-Analysis: v=2.4 cv=YMYKWhGx c=1 sm=1 tr=0 ts=6ad78af7 cx=c_pps
 a=A91p8pFdSY8iZOlwlHItIA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8 a=amCfYekhqCikH_6p6scA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXxaxMfrEJKAeJ
 nkK/bYzbYSh9iHU0b0PazgAjzdMKjmgQz8dSFKVCz0Ys9jltyP/3I0xGY5GqVytvi09W8A7piYl
 O6tMzZjYPojirX3BnnB598eEAU67mxU=
X-Proofpoint-GUID: NHqReQUmjnfuY2VUsYdfw_zKgn_PNCxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 09:10:40PM +0000, Naman Gulati wrote:

> Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
> backends (such as vfio-user) can parse custom sparse mmap capabilities,
> falling back to vfio_default_setup_sparse_mmaps() to process shared
> VFIO mmap capabilities.
> 
> Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
> Signed-off-by: Naman Gulati <namangulati@google.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

