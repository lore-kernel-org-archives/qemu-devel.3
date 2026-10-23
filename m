Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CF606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=SxyMiSIA;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=By/M5jck
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjl-0006Jc-7x; Fri, 23 Oct 2026 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjh-0006JK-L6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjf-0002NT-9Q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:12 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE64ZD3858553
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=X1REZ1mvsC2x1t1kfcp9LtiYLrIfjO8qdMRG7Fs36
 Qk=; b=SxyMiSIAmeSotNPRptIBWOkitRzmiiWCI/KAG6On3l/2xSHpWMwhd1wnG
 T1dAEaaN/AH3PypBSUP+iXvsNEOOv46CEsCl94+RZq8PDtp9Jc2DjaqK9A+67JIK
 KcFS4YDdrqagHzLDslIs6liCLLcUNVszNka98mVT9H/lunhEvzRl5jUz1EHS2bGk
 8KyHBTWV2TiYBCrzLuyWBrMhVEEYO8k7sbhYfRqJchXQzg7Mo1ZAgJM1rLU8Vn8u
 lB2+8W3p4wk3VDTmm+AvX0LdPU09ygySRgGMltc8BGb4+uhEj89fS5OY2w8Dxnpa
 JKCkHjnsBFMIOuoWr0H3Zf1e3h27Q==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020122.outbound.protection.outlook.com [52.101.46.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974cyx1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWg7XGDN05rQRRRfq+rDog8jWXsRHKn+QnSGl09rjPWTmIPHqLkygWyngTbwrwg+Dor9/wh6it8CFpckPnkTdhnBrBPz0ZTMXrzRZF7tQ+sKY7jI2lHBUpGuMLgzP/2/8cMOzLxhR6oUSSJtcK5eKtLw7oZvJXzIuGcNT9Hygl3uXGdrlOzoLYswF21+YDgPFpXbtqPe6Bjchm5BTZfZv5ZGZ6+NLIrx6fpJH+vLflNX6y295VZ+ZsyBXohfsx+qk4DeY7n+3DHq1Z7E00plWrxw8Jc0eeHKdcmyEUuu3hHY/ITG+EBeqrvC4EquArt3baRsV7yDOvE7g2lalR5sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1REZ1mvsC2x1t1kfcp9LtiYLrIfjO8qdMRG7Fs36Qk=;
 b=sWBlNS24mlWcCXS6Q0ZwZRQzlh+lnhx2LG1z/96VhgpVsMTgVLpsm+Sdv3eVq8hYM5ouixK2X4yHypro9CGGO8Rq73rDXPczJXnjoymqo84mYYgp1AfZ2SeaRIyJwzCjA2rsW4lulBHPF4Ab++vLpFkRvopvhc41oUGrmQ2ti/yYuW7zOZlW5ISSfh/F/Ww6TBTq0a334UTa/7nxOnmWZhFESNnSIz8e/6BrdfWz9amgbSwuJip1XQj2ozu2k6xUP9JZo5AQJ7ZU9nl406WbeKr0XspHvJp1s2EI1T/ndDr+/B5L4vRi8YIkbjcNrP53x68EhS1GQKdu1hdIHgiYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1REZ1mvsC2x1t1kfcp9LtiYLrIfjO8qdMRG7Fs36Qk=;
 b=By/M5jckGk7Ru4SBDG8gNAgEqXklOw6G6CLGni4cz8C8xF8LrO+n0pbrYpUgO+gxjlNLWCp0Mz1POU4jj2OCfH0Kzalast/pfCl2mGImtV8ifEZaOG5u1r4iChAcY3IK8rQMsdfIghM3c/qJ0ADXDu194rta/MfOm+5jOIIaignfmBfIq5HU2h/OwqbIHwVqMzPk81ZK0jwNKTO/apa95sxBm48yl5JXJ7OlI0AqDR81kZ05LaAGVFzv6bsnP9RypFQ1G5peLf2sfnilbGB/gTT5/++cd4QMpskdLTKaD29DHcw055D5N/ynn+WYF16S3eE6gg4510XnTODymgTHXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB11030.namprd02.prod.outlook.com (2603:10b6:208:5b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:59:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:05 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/28] i8259.c: introduce TYPE_I8259 device
Date: Fri, 23 Oct 2026 15:58:12 +0100
Message-ID: <20261023145839.34909-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB11030:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b384cb0-8899-4a24-c482-08df31162e6b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|261021121427099003|10067099003|261009223027099003|261021123027099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: U3ze26OEtw7evAA4aembN5rony36V1BsAGa3XhQsI0TnxhcWTBUXpHPQAYydq9PKwK9BD/6FGGzg2K3sGsQREqqXa64wnjiXNWonBz1Am7Ak8hT+zUIRrxryahd5YNorNYhg6cHULIC0fz4/nWVs4GklLnhk7kBv9cAnWxzIgsY925YLF62MvC3fgeVXvSyAjX9mA/HcxjDj2h6ZUudN61dGATe8JpMOKL2OEr7VXi0++Qo8G/22Y7BRkzqFi5yk4pGArL4AzRQzjVhWnm1KkrW9B0Z2xtVkJOCdJITFAhR07nooOcEV3Ym3T3+9wijAJm0u10jygSSTu4Y87bJIvRyj+e9y5EU5RENIk0tIGRvtUQPL6DmhFUnBLne7c0QWIT3oL3x45KZITwKGmxMK1VgGYb7qEVWKIqN05yJ/aVe2SqDY3yrAbC6v3jIwxNowDXydPKD1rWogg8XscSzZAVVCLkKBjTvwENh+Ha4HH0e6HfOPTERcuSJyGbbKVqN0WSD+P2ZchoBadB6T8zqyOF9YgmxcH3hydHTARFaoIsccgLEFdIUVOOp/18nDNZv8CwC9UGgkhnGbOQrspFTyv+zwh9GcyDllXypSeCXWBcjQowNKWQbj9nC+P08/uhP+JYHtyvbjHpZkrGs1aUmfEC355qaVrjjpSmyJKcL2LBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(261021121427099003)(10067099003)(261009223027099003)(261021123027099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRVv9IQ7UCn3qN3DkUn9pRRPFIi4dJBurAZxpQ59O2+luiPgJsu8+RqX1K/e?=
 =?us-ascii?Q?BntpcBVWC1a+w89bLCdNKBoDQQFTz/eYo7cSMvh/jjxJTr1VGm3dum/plldK?=
 =?us-ascii?Q?d9cvGLQ3OOftyW8SCytPW4jMBWocS55JzkJvy1VAG3c/XxsVG0z4ASLXzl8t?=
 =?us-ascii?Q?6/wOTCBQhmMuLkT2MR5U25m4bgCQ59x55DxREP3HTp2dyTph79NB2Yl7PT55?=
 =?us-ascii?Q?tpoclrT3IMyRWAztyzPw3D7DeWB2Wcs7SpMp5/H9cgw/uEBdK0Pf/EPYVPhD?=
 =?us-ascii?Q?nwhyGG08/+8w1y7U0kRZ6NnyEfmia9w0+T4wrO7xhnho5JjQnsCvXNxAu+cG?=
 =?us-ascii?Q?W0dj2d3yLwr3KVPAkqHXBgqR1BpZA/nGPAM3sL81t++cFOUiQkqW/dDfOyUx?=
 =?us-ascii?Q?8cf25Qfx8vTCHKgXdmHe391NlvsZYU29qKJRgY+V500syp8GpBW5bhromTn/?=
 =?us-ascii?Q?YmIwYx0gNkKNSiO1vPk7xAoE0qmENHLW7JYE48jPTubSRThtNhmqgkNNVZr2?=
 =?us-ascii?Q?pA2ZtQCFpDJl8stwPqvAnEf09AoN12vSDY5mmElc8l9KaqQrlTSl1f5r3ZYR?=
 =?us-ascii?Q?QI/vGjeO5SMpNJmyfAYGe6ZS6iJ0EJ5lSMwJ/uTAIS10vz/bkFJMhYryxEnP?=
 =?us-ascii?Q?KoXCYUUjclkaBbP393BKgCkAc+EBPvOtVVi6EO7kCVzkdmx8DA7ixwpB31Lx?=
 =?us-ascii?Q?LkPumM19tVqqcPKa0kwneQ21UzoCUURWpEZmVy+/X0IuhIcJV+Cjt7dCI3yv?=
 =?us-ascii?Q?qW1oPy4cbAPM2ietv/lmO0Y3adcxFTNUYmDuhzzoGev+zzcloLoCEszXOm0L?=
 =?us-ascii?Q?uqJ1/YR6UdAWi3H3iXyZ5GHSEU0oq9zffq1T6P3zXwEA73LxnIa3DSFoDrhR?=
 =?us-ascii?Q?Q/2PhMM14CAnRdh3VF60Gl+MIIzy6V718anqk63xSknPSEWydyE6LpW9mdos?=
 =?us-ascii?Q?1R5Fj0+4QZJJXF2vMoLaMJ5SnMRPSwpGDXFgh2mLCSSwdxImBxSotgq6HzaF?=
 =?us-ascii?Q?Lte0buACTh36+XbfmIkorvnoasRtZx/03ahf8+zSOqtKW3ErEIDbZ6xNNrr+?=
 =?us-ascii?Q?PiFzewWnUxUtV9etO+OfCz6Y3eutpb2ffgWiXHHorWfbKo29TKpH97FSbA5O?=
 =?us-ascii?Q?6Xm9FZK9MgLdVeWLo51V/VkL4BKS0+UKPr9sB3R2n4UKTE75RDqRdm97W33w?=
 =?us-ascii?Q?+8TDS88tp+rBeF7vLVGW61mUDSwkxAhGZRRfA/RBFxNZvXTFwzhIYaERMC8S?=
 =?us-ascii?Q?om12vdIctYbDc48PpV5CmfBUdNPaV2cIEcPHjXZaK+yvshKUqE0HYofY12+R?=
 =?us-ascii?Q?PBiIpjS2Qmw0tHkoKjChXuMD3dbmPiSDrqRzm9RpNYoQtGLHhzP+qN+7rDEu?=
 =?us-ascii?Q?jAZDR7Qn+BT4Lh5nuybX1NC0FPVW2F1zfp9266xxlC/O3iEB/FB1/McFIgGr?=
 =?us-ascii?Q?ukWB1F/DDSolhLyJZouy7Xoi4tplK2TCezb3k2dNW4D19JTONzm+UlW3Ykn9?=
 =?us-ascii?Q?bRDoeC+sKZrOwQPpuNwudTR62N9Gn8omPuQetlZo/+utkHyOUUizNnJSFuag?=
 =?us-ascii?Q?ikjCtMgLuyjXx6QqvJcx61VGjgrxrwCv4IA0IrV6a7lxQFw0vWdQx9q0eVzf?=
 =?us-ascii?Q?OArgLyqObHwC4YLxfaqd7dWpd0phrXdWecu8XDRYg0zwcTiKhskSotThM13Q?=
 =?us-ascii?Q?8b9Lfs3XGqpjYptFbwR3hhnP7VjePJ6XNTY8d+UCNl2fo+Di/QODL1RaJ8wC?=
 =?us-ascii?Q?OmgZgKENIY20wLm3GcJKDVcAHvdaj4Q=3D?=
X-Exchange-RoutingPolicyChecked: xDOFab4ZKUj4wyorNj/WaOE191dWUZQRuDQGo/QCmTq3JpmnLSByIr9GvCQJIUJ2Ld0g71iKZDZtqW1teWgd3XXgMoC0gq/8y/5QqCAZuP4ulDgC7wCWv7Aiif4K81Qx2woool9HISNsS0cF2A8qq+WsqmEFuo6Z8fqThT80BytMjNvgC6Ulxgogg2NlWALA+Ki+1taIzqp7qs0XtPd6bP1Lm/f6i2GFikud7yW4dw8dVFYQdXmomTf2pI9/1tWU71qOgVL7n6SmWWn8Van2W7XDJzAhfCTWk8rNu2qUHPQ3NQhNkKLJxzZoXqC3Nhp2v+4+m5ercqHvv3DuW47ClA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b384cb0-8899-4a24-c482-08df31162e6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:05.0158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxb6ibJ5xvRZqa/5Aahz+0xC6Wz+pYegn9IhOmPqpcIc1SJkm5KbqD+M8J78yUKwULQI5fakIlvQDlaOROzlZIJ3OKXEteyDJjLOxFqUny8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11030
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4U0uO/ELmWdX
 1MgexQbJhUYs5VYHi2+lxPPjrmYECvfHn6BUCYvug0waJ7JJYILw2zJXrz/DxIrQQ3PxbSYGS7z
 3H6r9kE1vJiqT+x8M7N77NPae3EV4CkTFU0Met4MKd+UofI7XiXlRzX0ZzsN3GmTz/0XY/UC4Eh
 Nr0uS8WerXgtdjszP9nP5tQji6Rrhg9THGXdhxDJMkEW9oL1Akjomc5UEnsulmihjKqrbUpw2n5
 Emk6qmy2O5/pKKSw33yVwvFtdIpvPk8w/kGfDuZd+7b4vyL59v/9Ol5iYGgwEUZYCfe2RBnT8Hy
 JV/T61vgBRzsuJEq0F1+qrgNyDxfnAlR1lPxtm4BCr2CgsO0JpympaVewlsxNQDed8HOFnL+Sc1
 XADlRTeuORxcPPk5+shCk/I6MFNxgfJsENBHIgB7y/di6X320pmYS91FVKSkFEGUWTcUbjfQA3H
 egAIuSdGW0asaUOmVFg==
X-Proofpoint-GUID: eeCJiAD8RKVYGdgI2zxBI0R6ojBf9Qhi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX9n49KUEHiUf1
 qs3O9M4xtkQNjA3IUtNJLzK5Zh1/NSC4mBB/RwqI4rRypmnkRogulvjwNYNFRDdcB2AmYInxMLT
 HSEE8pspjbzuJak3WZ+tIT4Cq25lOCQ=
X-Authority-Analysis: v=2.4 cv=VaNir1p9 c=1 sm=1 tr=0 ts=6adb763c cx=c_pps
 a=Ov5XJGn/dQMl/+TwTE/lXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=RO_YwWr2CJXTu7lAkVcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eeCJiAD8RKVYGdgI2zxBI0R6ojBf9Qhi
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

This device represents a single emulated 8259 PIC and its associated class and
ensures that we can safely embed the device within a container device.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-7-mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h |  8 ++++----
 hw/intc/i8259.c         | 33 +++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1921a30371..87ccd55a4d 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct I8259CommonState I8259CommonState;
+typedef struct I8259State I8259State;
 
-extern I8259CommonState *isa_pic;
+extern I8259State *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern I8259CommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259CommonState *s);
-int pic_read_irq(I8259CommonState *s);
+int pic_get_output(I8259State *s);
+int pic_read_irq(I8259State *s);
 
 #endif
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 856075a754..81827f2734 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -35,9 +35,11 @@
 /*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
-typedef struct I8259Class I8259Class;
-DECLARE_CLASS_CHECKERS(I8259Class, I8259,
-                       TYPE_I8259)
+OBJECT_DECLARE_TYPE(I8259State, I8259Class, I8259)
+
+struct I8259State {
+    I8259CommonState parent_obj;
+};
 
 /**
  * I8259Class:
@@ -52,7 +54,7 @@ struct I8259Class {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259CommonState *isa_pic;
+I8259State *isa_pic;
 static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
@@ -170,11 +172,12 @@ static void pic_intack(I8259CommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(I8259CommonState *s)
+int pic_read_irq(I8259State *s)
 {
+    I8259CommonState *cs = I8259_COMMON(s);
     int irq, intno;
 
-    irq = pic_get_irq(s);
+    irq = pic_get_irq(cs);
     if (irq >= 0) {
         int irq2;
 
@@ -187,16 +190,16 @@ int pic_read_irq(I8259CommonState *s)
                 irq2 = 7;
             }
             intno = slave_pic->irq_base + irq2;
-            pic_intack(s, irq);
+            pic_intack(cs, irq);
             irq = irq2 + 8;
         } else {
-            intno = s->irq_base + irq;
-            pic_intack(s, irq);
+            intno = cs->irq_base + irq;
+            pic_intack(cs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = s->irq_base + irq;
+        intno = cs->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -348,9 +351,11 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259CommonState *s)
+int pic_get_output(I8259State *s)
 {
-    return (pic_get_irq(s) >= 0);
+    I8259CommonState *cs = I8259_COMMON(s);
+
+    return (pic_get_irq(cs) >= 0);
 }
 
 static void elcr_ioport_write(void *opaque, hwaddr addr,
@@ -418,7 +423,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259_COMMON(dev);
+    isa_pic = I8259(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -444,7 +449,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(I8259CommonState),
+    .instance_size = sizeof(I8259State),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(I8259Class),
-- 
2.43.0


