Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B3606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=wdVkU3hN;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=xc7Hxil+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkY-0006rf-2E; Fri, 23 Oct 2026 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkK-0006bk-Lr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkD-0002P1-80
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:48 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE67Sc2350435
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yA6KIyRBfbQjCLPbkA0G8UIph7xX4iD8LBEtI0RL1
 zw=; b=wdVkU3hNWwm9DmL9w8HhjAzulfrccMbOjady5XIylJueO3XC374ITloDi
 vJBeNVkjRfKzDFCmlvBsrwMgUaq7WPm6hd/dVQigAe75lpYW8OcS0RYZVfxQtNNY
 z2b7Uv6k0qwzim6kq/VUw0o2KEmPVuQsdirsWIuNjXZPUro6pCMbaiuaNxmDgLEs
 soIBzAyg95T108w2eHM8eYFx91HYkNmfNhZMxvodomu0hAczHG0nLXN6TPNVUsrV
 ICNxg6kK2NDfT/oXa6M9LW9XnHA1npyz9RQ7Oxw5cTjoYYdyJz0AawZ4Vk0r4Wem
 FXqoOqn+sXtsShTirq4pPC5riRPKg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021141.outbound.protection.outlook.com [52.101.57.141])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972d2sq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je8PwjKDrhumJKQ6TZfKAugpENoDnLn2988pH1It10RM2cXuVLQ1gPavL1BApfKkj0ufUyi8+iZV90ACBi4aLxAGI2KybZY5AgIfoQKnPtKQLt6cV/NIUC7KbWX/wdc/wQlBSHZOSGLPwEqF2jfl11sYliLsrbIrGxIZf3+gt7yns+u2VAlGJyL4Tkhkd2gM7qrWG0bScJaKnzFG5sLSfGUoVmwb9vh2KMOm06basN3c8U7XIlv2KtsbpL5+qP5B2ECSB4fZIxsOIWyfOaXLDoMFPviLXERZnm0o6eHZERGWq5LB/r7j0armNz/arNUzYqOu9rDMhPqZJXaWPJtp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA6KIyRBfbQjCLPbkA0G8UIph7xX4iD8LBEtI0RL1zw=;
 b=llXDk1+coxpxX7I+hMGsyoMq5aQZgF2/s3idxUaviK5LGyvNgmmv0fUzlY7zVQnQeVBza8+QvI9FW2/Wtezsar6r8uRZfOSOe3OQgt1nh5iM+18U/9BTnZgwyTTexhLKMMYEHo8a0mP0KV4w9Xq8LrpzVhjB/JfrNlG9Qjt7Cj/r+FevPY4QIG30SrveBRbMjpSe9eZDOThKt5ALI5wOcDI/1v1MmRE1fHMjXu2J8o5lBhXp6si1VKAHhUAbcjoV9HyFWAOY4i+sa6W1g5Dwziw7lEnZVq0z6YHAOiqNAwyfwaHb4WYBGKCmVBbK++ZrbX4jBu7EY1wz3yEw2fMZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA6KIyRBfbQjCLPbkA0G8UIph7xX4iD8LBEtI0RL1zw=;
 b=xc7Hxil+N3BgF3lp+1B6RSWAuwkqZiNykUIICNPqstEwcOlPI8aTlGxUls/9i8GpslT7EaWaQXuBGObiRiGeJJWQqlCiMlbhBxfkeIwkRy8yKhNLfSBOpqmWuZJYYVozJxpU80eU6jOBSHGm2LJL/i3m8WZKIlVgch2P2V6DpdGuY+1K+p3Es6hzXpw8Q3nvFt7v1lJ83mc/T5o1+0uQm63eEkIrV/6tgnIPi8BDrJBKhsW2bi1qCU1XrSepkgolXAZwc0iWJVqj0JMkAJqM/k6aO97n5c5V4x2lRgWEdf8XVyQOdgdzq4zu88SBc4n+vlOrIquj5dxtyM5IVrNUdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:40 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/28] kvm/i8259.c: use kvm_i8259 prefix for functions
Date: Fri, 23 Oct 2026 15:58:20 +0100
Message-ID: <20261023145839.34909-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e8dbe6-e7d5-493e-1a92-08df3116438e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9dWLPj15A0AT078idE8UIzRtBXGuzePsUCKOqVhuFMnDl4aRkXbk24nVzPkrm4bRXH0vporQGarVEOzHVXVOQIOhk+VhqkoY7rITz5AcCbu3dZ7Xzcp7MSwK64uNGrbORRdts0wn4mLrOPFp9MFuRfidp2+n/XgMyVgkczyvJYDQ4alPimVmSy4MzRUMfcxu9kP7gqj7+qTwnTdjLJrRaVxQLgrJowzRv0Pa0yDYLUB9kzL97yv5XEzuH43jv7vdpo1kL4lgVAHIWBqiioKdCs8iLCwCfalmItekxO8L3F1hc3x9I+YfHVHhtSWPCPCr8gGu6wxMAmfdN8C6trJxrFixyt6KCzbWmGavzrd0bEWiOeO4FmInN2CXSuCX7F5HxBh+K+g6aORlBuORcXgXfXMMz3pBtWhabQB1fXpRlSm6tjY856UUcxdrWcEA0Sx+tC0LzvFaRNW+BkaJC9643R+eFqJ5xoqrm+j+p/lwfVL5tJ+/VVMVh9FXUHhxZBm4RgKiFMyD+naV/5WXIs2oQS7u0498xZ8mVEmUvlwkfdbh4Yz+GVOFNB6lnC/8JnXc6rzWOHlu8tB5VUmhzVQhtIXmWJc3VhrFWbilj5RpYz4iNavtSfc8t82YB1D/b+/VZOUGVROtMuBjlMmknHGJ4ZoqLvVdT0Vl0MsRtzs1MM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NSnxED1anHqDWS9TtWclXN6g9ZK0MEA/W43QUWspfXRa62nJcQM4GK/9loVK?=
 =?us-ascii?Q?ug57E4RAHqx8SKqPebjLH2MInrfv76xfbJY+HXUYlpT6tJIN3fKZ6v1OZ7tS?=
 =?us-ascii?Q?VvQIE1ThuZdkqMacLzEnUW7p41i69ims4P7Kmq/1XljvP0VWiz05pCI97ObW?=
 =?us-ascii?Q?62P0Uh2TP7dart9VXRQfp6xbIkComM9XijkOEGsFKD3wJBjk7cM5NjUeaUKw?=
 =?us-ascii?Q?kKUGjGr9EFhVJoQwrYhXxPKUPypxQcL8iqozUVmxL5wRCEty2wkf3eSKiXhW?=
 =?us-ascii?Q?6k8FmJRDshvzwn+DWyri9PgS3QXW7Z0OEv1ZhPKSy3o890wsjFcuLRsBuisr?=
 =?us-ascii?Q?EvZw1AZJAbGYG31LCxgk4lHtJwWV7BFNdvXWCeC727NLsMofHPsi+noW4CaW?=
 =?us-ascii?Q?ouDuq4SdJCXoCS3JxcuWVoH9Ne92qswfCGzRMjHI/8PmqeY5sGjGzb3lEyGw?=
 =?us-ascii?Q?0E7t+2tkqP5tR9UZetHsC55FCJ/3IoZAFCG1ohAYS6xrZ60ECB6JeewDr052?=
 =?us-ascii?Q?M/JSUUEniq5fgIore+g6Yp5fQ8mSgpWorHP01dwgtONv7dQg+wn4jbcfCipe?=
 =?us-ascii?Q?nJ32K4K5zbPR11Eru5+VmclyvOLy2PC8man0abt7Dep+oGDimAg1K6iseGup?=
 =?us-ascii?Q?zXauDFCEvPj56KaSHLscOgVHIsqJoUVIByAPU2ShS1eRuCNEiM5VIgUBwdKg?=
 =?us-ascii?Q?dG9uGcMCHLjlfF7gz3Y87L6Yuy8iWOCtPRDl2rErg3aAHZBzYSD4y2DTD3A/?=
 =?us-ascii?Q?VwLTUXR2Iu/UbIEfcLWyYstwOKJeSqLwwKFWxA/uLPuSGPbFBwBLsudvesEO?=
 =?us-ascii?Q?zPylSg4tiXYIaiCJbWaSCeCIFb70m6dAQjqL/U42MDdtwEfUxnQGOlTzicOC?=
 =?us-ascii?Q?UJDARunZhVS8pkwMuQSEXQgF+FqDUT5sv/5Qrq5cedhVJk6PrSojwj14xD9i?=
 =?us-ascii?Q?zVaTHl586LjzVsUNk/QCwVzSwUGFpzhnebO+AuZFNABo+8RnEoNTzfnCohRP?=
 =?us-ascii?Q?mZfpIG7OvSn4XqZVsduf1fintNdLl8gy5IY6kmPfOMSmiOVYJ4WSKRsQaFST?=
 =?us-ascii?Q?nD9nfnDFCrefWf4at94XvB2k+7SWHl6nLjzDFuaAlY3rqJPYcAwu/1WW+eTo?=
 =?us-ascii?Q?UUaXVWpIP8oeGJ/mUeTPBYT2gH4JE58nJmIhJFNcNRt6QgiF1e5VJR/P5oan?=
 =?us-ascii?Q?mSbHKI12l9GgrzfEaS7j3y4a43FN28S+zRR//bbkvvydjTOmbW3F7MjhBsqH?=
 =?us-ascii?Q?96klnI+TVi4NqM2Ou4LvcIUxwpU8A5tFv7sr+Yl7bdh/zMOiSg0OcX/LOy2R?=
 =?us-ascii?Q?H0zL6ur5Up+muD/DEqI4HzcmOUZ8IRqdYxwE6pXMltgJqKTI3DdHjs5ZTXZD?=
 =?us-ascii?Q?J9iWc4ZtfYPziujPGfEhAJhnyxJLOzvTTKWqNMKlovdvXVZiUOYcxvk7iCxF?=
 =?us-ascii?Q?f4dr4/gXxx6xEbG8pPDcPhj55WjVnsteKGX9lwuuknZKHoKSi1cWDv3h5qiI?=
 =?us-ascii?Q?fq6Q6xTDQQAEH24yUnXx471mdX0vKkFIWJ7r2BDenQp994scN7cbkunKCvFY?=
 =?us-ascii?Q?oFg/hsgESVXdaT9xyJMk1oEWGeBF4SHMjc1buet4dYIIhBnnWo9SDXlnZFSu?=
 =?us-ascii?Q?U7OqeRhfqybczQqEuFtSg88eU/ffJuaa6s9red02Zn8D9pnNrV3GswkzHUbI?=
 =?us-ascii?Q?uaM82b6DORRgyWNKlHCQ7K7zqF+5/NxSq2qA8SqCI5dNQljISsPkngNAxRAQ?=
 =?us-ascii?Q?6/Ri9SVX92yrEl/1ucL9ZtqRSW7VJEA=3D?=
X-Exchange-RoutingPolicyChecked: 1kFmWn72SiFquQW/4lx+nXsOOT51Gu5Ip0Bo7D034VB17Ga2e2I8N3Y6zO1+TdyPn8pFkP9AAgirrximbvQDWhpBNRfFFiC+RUYczyMshzxQkIuh+cHYcNU8sIQAwy/S6qrgS3k94im209998fxu9kp3uBNDcpmQ6Pbwh5V7tG/UWO+8yt/j8rvnhbbS95vfgd8kmRjU3lrAfnbDXvzRSk6ko+Dj13zV+c7c56vAY5hgcgX8zWPcaAKldDq68iUR2pAW5V95HJsEQykRU7TZ1hm+JrIJC0LWwKjH1cQJzY2jMX8jmIClW6t2uIJJ8KqrvJxsUH0j7zTojPnI2xc8Lg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8dbe6-e7d5-493e-1a92-08df3116438e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:40.5269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjHVWvkS9t+FAONuYVYwbmmkrZBjP/RqFgKO4UHPDba+6otJQ8lt1D06Kgq20F/4398G5CB1LsJXdUbERaGcAze1Cke51TshauCVyL8czRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=SpMFe/O0 c=1 sm=1 tr=0 ts=6adb765e cx=c_pps
 a=IXZk8buBm3K+4cvqFqH88A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=b1AWVSNg6wsnrng390EA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2kbr9NmlfTAe-LjLRavYMz3U9VpdEoHh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX3VRJ+bH9VSvl
 XsBuaPvhl4CzaGtAM92KGIakKNqX02Oou8mrF0hzUb9w9/eaLpv54jJUoHkgAWldeoSOEpWcY2j
 vGT+MiIP6F2cnRO9/n8w2M+LqSRNJOs=
X-Proofpoint-ORIG-GUID: 2kbr9NmlfTAe-LjLRavYMz3U9VpdEoHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX6tYY67LfCZyI
 wNKeRGH/cdmQ8TQ8kapK/RbrO7E2ZzErs45KbSaRpcLlcIlAjnWggdbNZ16SibhzhRpefXz6s5w
 Z5ZDLK8Uh/VkG36MqQAu1SR96UE/U266u5E8rJAWnz8T6Lhxhku+Cvk0Qz918G/zIUAaTZ9R1tg
 8eMswwcLvHoTPB6v5nAEPc4BY2ZE1YjYneLPAXNoB1J5DbLyOD4n4DQRdm18PJyaV9Sh6El14og
 KbARQtfB3ILzTBQyn2OJx60LFOzhZnoNoC6TmWE/Tdmx0XO/1FxAl1IoF9HzRJ7FbaESG/8rrqW
 IIWRuISsJD2mQejwYRLFmeJAUDF3p482SkmcG7/vqlxzQyWVhSn+KTso5M0/hG8XNrb2uPbENU2
 kING5xW7NcXRWeq6svw+lmasHxoxBTDZLfOcZC71DH5iXaQubLNfsSni7GoquEgLRElfOfwreC2
 YQJMqwymFCiKW47fCLQ==
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-15-mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 3a960e48e6..952f58be11 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -36,7 +36,7 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(I8259CommonState *cs)
+static void kvm_i8259_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -69,7 +69,7 @@ static void kvm_pic_get(I8259CommonState *cs)
     cs->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(I8259CommonState *cs)
+static void kvm_i8259_put(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,14 +103,14 @@ static void kvm_pic_put(I8259CommonState *cs)
     }
 }
 
-static void kvm_pic_reset(DeviceState *dev)
+static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
     i8259_common_reset(cs);
 
-    kvm_pic_put(cs);
+    kvm_i8259_put(cs);
 }
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
     kvm_report_irq_delivered(delivered);
 }
 
-static void kvm_pic_realize(DeviceState *dev, Error **errp)
+static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
@@ -147,10 +147,11 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, kvm_pic_reset);
-    device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_realize);
-    k->pre_save   = kvm_pic_get;
-    k->post_load  = kvm_pic_put;
+    device_class_set_legacy_reset(dc, kvm_i8259_reset);
+    device_class_set_parent_realize(dc, kvm_i8259_realize,
+                                    &kpc->parent_realize);
+    k->pre_save   = kvm_i8259_get;
+    k->post_load  = kvm_i8259_put;
 }
 
 static const TypeInfo kvm_i8259_info = {
@@ -161,9 +162,9 @@ static const TypeInfo kvm_i8259_info = {
     .class_size = sizeof(KVMI8259Class),
 };
 
-static void kvm_pic_register_types(void)
+static void kvm_i8259_register_types(void)
 {
     type_register_static(&kvm_i8259_info);
 }
 
-type_init(kvm_pic_register_types)
+type_init(kvm_i8259_register_types)
-- 
2.43.0


