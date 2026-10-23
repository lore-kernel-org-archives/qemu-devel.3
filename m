Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CD606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=FQAl2Wyq;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=DA0CnnIj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkd-0007Q1-2b; Fri, 23 Oct 2026 11:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkY-0006zc-Gz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkW-0002RQ-Dp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:06 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5u6p3969182
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DZ3jPHVtHEUYAkbpngxMcuU8B9nicqj5xayNgWC6l
 70=; b=FQAl2WyqvPUf5DCegAjtcL2i2j0nE3RUqtt1DR1twUf6hJm58YIv/q4fa
 AebnLPYFTuU6GoNbaHo8tvr5m4zPUTmhSnMkNwUpG5PZ5msuP6PgPR525LPft2Ck
 SXms8KdEhUr0j/f4JNCVwLpM8ZQIjVlh+N6XLf4Bohp8dMf+U+dUuTPcikPbO+Y0
 kg1/Nbky/ENSsHJXkS9+Xhe7U8bqKE6cM5LgvJK6bsk5/dl7Wq1l9KZr+aiG8cMr
 mO8z+9TKRmTXSXL53Ub3WSkj/4xxcB4u+LPrv6jZkiU1IREWi9CX7uCciQzn/j4b
 fZkKyNnRnDGJUrN1gYsWm9rZmlvdA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020128.outbound.protection.outlook.com [52.101.85.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf973myc7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld2d6jR/Mz+E30XdXqS/gXy1yGtFBHwyEHRlyTeup2DQ2XnWK1iInBddnjTy2QNX7LrUOUqCjerZCBeuQmnQ98bkpH8ZtOMuIE+Tcf2eYtgQeA6mkgzBqLPi8J+9ixoNR0tSsPQ4ockYtsdjR22IWPrUlROGUb1MsmDj9KM96tE373jgqoloZUD83We0ZvRxyc/QgZEpkn8VT6QGGNCaZH+YPwzoCbFMDZzxN0y/J3QQ42TeLohv738NDk1LkUKFhyV/EjaYUnoGkOKD3kMBKeErW7gC17a9q4hghRhWnpRJqj64aj/LSok8SgrJiKequBIJenTR3NnUboh4lnWZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ3jPHVtHEUYAkbpngxMcuU8B9nicqj5xayNgWC6l70=;
 b=HArenyaVYPpYoWNb2BCIdGWc2/6fDYBbi4fVrUzMHkuYw8gKURyxrlHRQrD5tV5KfFpiTDPr1tAcV+5zpFQfXbPjVG1q0L8TKR3FsR6EFWOcnzoFoFPba0H7dR7DqeAjFxH90LKzPauOD4ncDl7h7cyo5WzjNkz7YyY1k7F8VXPcwpP9Q45CHk2F4/0KcJBrpbtNOhB6Ye+ijldxdSZ8wG1z71eP02t8vf70RIeP5/VOY1/DbC5WzgKawaRAWeHocGurKRCW7Iv75pM3xUR+jAqYaZ3gCEYKrUIUSN4gFCNq1cO+oqWWwjB8FJpxZXczG8++EL6rCDvjyet3EqPpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ3jPHVtHEUYAkbpngxMcuU8B9nicqj5xayNgWC6l70=;
 b=DA0CnnIje1FU5bJBnu86KrCTugI1iS14mBQFp1BERlF02qWPw70MoFC3J7sl7jCVU5EjDnTm293htaVxMggqtKRSsHaCBRx3YDMpYcBu2i3Cwl9N764xTiFQ8ro5Gp4MrcHOzj+h4juSov+wL6lAhlUhFZlyM4P0vqLhHQm2VR4WxsTh8fpK+kbezOHosTvhBibO5g6WZaDKOVDxLtMx8eMFfETQtDgJQg9UcZ0PoTuehnSs7/PARtUN/3jrWu1uTZFzw2TxZd6YX69rM1gPGMqd0h2gpv32nn2tCHIQIkD+kXThVQGZPJ9X+cqnoYwh4N/xINRFdc/oReBLki3mWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB323931.namprd02.prod.outlook.com (2603:10b6:5:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 15:00:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/28] i8259.c: introduce TYPE_I8259_PIC device
Date: Fri, 23 Oct 2026 15:58:25 +0100
Message-ID: <20261023145839.34909-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB323931:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a21f4b-4823-4100-aa26-08df31164fbc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261022105027099003|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: LthdA+xdWRmDtgeub2OZcx5MUkMRLpbZDF2StNIgB1ojes/mHgSrw0B8kFnIOkVvBwH2eKJOAz9XTMxDoKf+P1F7vEAM4KmIZGdLcCDHuoA9SPNeiKswT5fLMUwb1Ukj6pi/Rc35DnwzgAJ2gEdyTjEq8+a6I9hemCqSxoPh6KijoxgEJp0wLmf3U83EWb/1j+jobkzioDt1QhirZ3InfdXPymI8nm1NfK5Z2ndgHArpNkyHvtuMyTy9MyMpe0N3zogzguZ96YOPPXP0RjfB3hkF3BBb0flnyU53P7Lski+2tPX6If4DyChH88rvcp7HzTWnhlpTzSLPinwrFlZAE1yNrJrRY+0sXX6R2H9/6XuLWAcCfg6dCHSlP5gi9SzWm8vd11/N8QdQYedptOLYk+Zkktrz7zkzfgaO8SWnzvPXh/dOLHThNJTwX3KmeymaH5f2GB9XIk3DfZJRmXZgd56JAiYGDyc6zLCzG1jpS7j2uvZmZK5rEOcLq6zlAV6EfV2zVw9csmiVgZJjPMlvVcFN1Gwbqg5EdyVqEPZ3w+zowCoqx0VDcAjYrwDZyfDDMynGh/rEYROsngtJdlSsuLBYI9OOaq9Xw2VwHj5Pz+zzdigPHIt4FVYPXcJvaBTv44UV5csCjBYHRTRQuObRYz+J0dVVlj/Vo+cQO8lNDjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DfcGkppAtJ5ONdrtoAN1NeJmp6dbn08fKxu2g03RhkE7ukpZu6fG1TtWMLW?=
 =?us-ascii?Q?p/8hF6V/jNt8OI6ctbm8BfNI+qT60+Aaml5VjQC9CgLbXnZazQ2/EKEmpW2U?=
 =?us-ascii?Q?bzjyqSYlymKB1zGBQppLP7VZakQzIjKZnIHF3vCFPPdp7BZ/wtq2YiwZOOkg?=
 =?us-ascii?Q?X+xUtANiE05N2xKfar8+QAM8D+riSFR2s88W3KEZNgBvxRw2IJBEvYIDCMjZ?=
 =?us-ascii?Q?r+wsDeb/cIaEOJxwLxzCtZCUjLeQjMQGLILI9Ngc66RdQrGrF4BNaaMZXFYI?=
 =?us-ascii?Q?mpK8FDtsimy+yrRjqqPyZJ1bY6H3aNzwHInxXvhjGk4LjoUvqXw0zHsmHuqZ?=
 =?us-ascii?Q?XN0vz73TMrgwdUWCdOuzai30ld/alEt53eNQVm58+Tij0dz/3jVP/i/zvlp3?=
 =?us-ascii?Q?KpoCUCTyk3SlKVsrtpmdBoUeDI59wNhNlDmevdQZRO9ePshcobpFAytlDdfO?=
 =?us-ascii?Q?dP7gfDs/z/eqOvrINyWa1ixcK/BFgJTw8hwwtgMC7TNyhq6W3iwrN6eswa7m?=
 =?us-ascii?Q?XXtKqgcmoiddUoZpZHH8/nDSqKj4wv7OrxeJD9YHnm/cE1ulrUVtuycSkJgA?=
 =?us-ascii?Q?6LSB7zkbqzK1J+4O0q6KLcxO6kin4xxLcEpEaBwViBLaaK/llvvU0iLFiWdJ?=
 =?us-ascii?Q?1A0xZah34curR6UFWquMbWz7kElZqqvZCq/KvugXnQIoUCgKiurKeZUbBvBV?=
 =?us-ascii?Q?8d/wQjXm8wfpPjewmozNg4G+wSYtf+WhU0zJyf9GrPh0SMH1u+JmShh7EyYo?=
 =?us-ascii?Q?SYBPA26lO/GHl9mP+4E7Y18/vtk2ZwXYwiAY15NL/a6Hh0IodnehkZz9Hzs4?=
 =?us-ascii?Q?qAVyctlLhSP1T6BgPdXzjiFCFX6TVYyO915/tdmaNgz+gKCxBSZlO4HK6okr?=
 =?us-ascii?Q?lLEiLRr9eqlEknmpoxDSB92ZBKkc/HmlUY7o8BaJFnr3MMuCXzlkQ/EmaK8X?=
 =?us-ascii?Q?pB3xja7jss8vovDgW7uvewnm9HgfzlJJWa7a/1O0tGXKI2I4sdNchFP525gW?=
 =?us-ascii?Q?Oa9u6QWfmSyWY4sV7j7jJq9rhC+EBM57LUqGIr+EznK+Ru19vYKNblanqkJ7?=
 =?us-ascii?Q?ww7cp65a96NZitNkdjGQzhVTVnIP8HJoJmhE5TCoHO1jHYDQmav56kxknTQ8?=
 =?us-ascii?Q?EEscQggRsok8X78Dki6nUQx8f17XtoNhPuv//JwE6Pe4bPiqpIgGL0lwHBtf?=
 =?us-ascii?Q?lrkp1lasZF9fH8IcJaaDR3HIa/lBJ/ViXyFvqeEi6spgVv2G+ArtDApt7fAz?=
 =?us-ascii?Q?KZSpHhF6Z8NVEPw+UN9p3fJlNTdcFKuiIjkt5tamw3BHnTBV9OD5NfPbusZd?=
 =?us-ascii?Q?91ruTdk8lMovSsjW/g078yBVs+I5i23COWaSmOTv+7A0edYqCyxVuxhNRytz?=
 =?us-ascii?Q?EPuOz34shvPcIEPrYPSl1JjQMPu2p1tbb9a3eavwYk3KovRZP4JgbSwMb3Yw?=
 =?us-ascii?Q?fCWDEWDPnpUh/TQXw8fABHWP6mTgb1MCyawIbC3a3qcWDf325BDrXfnSIHYX?=
 =?us-ascii?Q?mVLJPuBxLOeE8z0NllB5DY6D5SHRmxEFNQ8r3itkSl8LUjl6jHRdBOAkFCSm?=
 =?us-ascii?Q?5pJxUa0mB4eHqBuGDoVYynGZ5+y3b58KGiC0im7aFoIRNEKN90pbTu/SCZww?=
 =?us-ascii?Q?5TzC5j8+VdqaMe+utoqCS9soCKGMlQzLS4FZyhzJWhKADHhhKJgF17QGBaNu?=
 =?us-ascii?Q?yI3hgaYXmtOa3T9qWpqqjgNiVeZbKmRMuFqlCRm0wb1VuLeRyCgIDL7xC5oE?=
 =?us-ascii?Q?0MB32BSl8ncb0F5YZI7Sf8KsB1kIRSU=3D?=
X-Exchange-RoutingPolicyChecked: pAbqpCn27chHQykMWz9z5jacDh1aOoOPJm8+KMDh+2o7kV6TUZIvjAsDDnc7T3yelaWFtwCqt/9S4CBIGAfeQtit9X8QlQBsbCJrcZUrSWW6OTcCCqVL5HP+3tPXxSqNzwA1xC3OqEa6eCEVybenqj5Xv/vsOyGByu3mP3bEMW2Y+8pn8Lp11OIwn+wKLCgTxD1AVSq98S+8r+L3mqbm6fT4Oi43ZA3dOVQ+4pOGiJktpk6hjsjIXMC9SJWt61K6LiZvsZB/YLLwSorw64dpMps9xR+tSgraWjIGnQGX0aP+wtG7rfNMybjv4ihsiAwTXXXlUM2D4RfSfqEM6CDGcQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a21f4b-4823-4100-aa26-08df31164fbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:00.9147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oS6Xl1jfTR/UYgbI/g5vpcohmsATVSZl4AEiiKcoL0a78JwN3pXVE2XlktYw4PKVvppaKauGlHCFhS3sonh5D1ynRmQlS4zDyp9aWnenbB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB323931
X-Authority-Analysis: v=2.4 cv=E8NYNqdl c=1 sm=1 tr=0 ts=6adb7672 cx=c_pps
 a=rJ76FBf8UdibaoD+N2q2jg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=0XGB6JmbSUb4YdcodAIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX7WU0FBcF/HMB
 vU/kCUB5z94o/YpC1qvxZLElnyPVLMeMCQfV+de7WoBhvDUov/+XCW5cNA6jyLpLz98m7Z/hLGm
 LYoR/u+hbqsW6iV6VECxXGDN4n57vSmSC8yrPLYMuh8XS4n+o425hMqpYr2JyNYesSvUeeBYGIy
 tZ8Gvt8NXm0yNilovZ4HwxcyoY+Ly2fuUfewyyyUFowUBaj9IdQi6GFvTCZC4fIxi75E5F3Dvsg
 F5zZiGz4hzQaUBVzPLL8ULBItgm7S0sF8F4kc3RQR/SWYnTEEHo2ne8JYVfIQltBWrOcnIOO0vW
 QlonQEDf0w7UH3KVnNZZxadkNPZm71Rk1/1wFePiH0VSbZ5K9wce1QbOrV7Cyj5njfNNbd25Kex
 1ejfROwAJZu1E6CSHr7bv4LoUXVFj+ciadKlrf2YqUH9WXEyVqaHU2p694o5eFvtyEihYz30Fb7
 /xwouqqZBQD6W8aDwrQ==
X-Proofpoint-GUID: UMhsTic2gKOFmsMVdJnh5CQC07VlOZk3
X-Proofpoint-ORIG-GUID: UMhsTic2gKOFmsMVdJnh5CQC07VlOZk3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4mrIu+YRXKiH
 DOEsN+cqiNtQsDOCQLt1psJAj1ZATnpAFj7nARTbSXBHevB+PujDVl/VdSrB8wJa4r6jQWZh9Jp
 RzJLDhDcyaDI1iNtRlvU4TJsSFbJu3k=
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

This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
devices wired accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-20-mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 133 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 15 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index e5fa0f2e5e..fe524efbce 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -25,7 +25,9 @@
 #include "qemu/osdep.h"
 #include "hw/intc/i8259.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/isa/isa.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
@@ -51,6 +53,22 @@ struct I8259Class {
     DeviceRealize parent_realize;
 };
 
+#define TYPE_I8259_PIC "isa-i8259-pic"
+
+struct I8259PICState {
+    DeviceState parent_obj;
+
+    qemu_irq pic_out_irq;
+    qemu_irq pass_irqs[ISA_NUM_IRQS];
+
+    ISABus *isabus;
+    IRQState i8259_primary_out_irq;
+    I8259State i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
+
+
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
@@ -410,30 +428,24 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    ISADevice *isadev;
+    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, true);
-    dev = DEVICE(isadev);
+    dev = qdev_new(TYPE_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     qdev_connect_gpio_out(dev, 0, parent_irq_in);
-    for (i = 0 ; i < 8; i++) {
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259(dev);
-
-    isadev = i8259_init_chip(TYPE_I8259, bus, false);
-    dev = DEVICE(isadev);
-
-    qdev_connect_gpio_out(dev, 0, irq_set[2]);
-    for (i = 0 ; i < 8; i++) {
-        irq_set[i + 8] = qdev_get_gpio_in(dev, i);
-    }
-
-    slave_pic = I8259_COMMON(dev);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
+    isa_pic = I8259(pic_obj);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
+    slave_pic = I8259_COMMON(pic_obj);
 
     return irq_set;
 }
@@ -447,6 +459,90 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
+
+static void i8259_pic_set_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pass_irqs[n], level);
+}
+
+static void i8259_primary_out_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pic_out_irq, level);
+}
+
+static void i8259_pic_init(Object *obj)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
+
+    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
+
+    qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
+    qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
+}
+
+static void i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    I8259PICState *s = I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+    int i;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    for (i = 0; i < 8; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
+    }
+
+    qdev_connect_gpio_out(pri_dev, 0, &s->i8259_primary_out_irq);
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Wire up secondary cascade */
+    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+
+    for (i = 8; i < ISA_NUM_IRQS; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
+    }
+}
+
+static const Property i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", I8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = i8259_pic_realize;
+    device_class_set_props(dc, i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo i8259_type_infos[] = {
     {
         .name       = TYPE_I8259,
@@ -455,6 +551,13 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init = i8259_class_init,
         .class_size = sizeof(I8259Class),
     },
+    {
+        .name          = TYPE_I8259_PIC,
+        .parent        = TYPE_DEVICE,
+        .class_init    = i8259_pic_class_init,
+        .instance_init = i8259_pic_init,
+        .instance_size = sizeof(I8259PICState),
+    },
 };
 
 DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


