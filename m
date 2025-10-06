Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A765CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 18:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5qCd-00053J-PF; Mon, 06 Oct 2025 14:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v5qCb-00052z-NZ
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 14:44:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v5qCZ-0004Sc-I6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 14:44:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Iath9000795;
 Mon, 6 Oct 2025 18:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=XVQL2vOTY5yZle2fILDKzV6wDVBA/8nnYBlQWqIHihg=; b=
 jlQvzL99FzBTXFoOe+/2wridtZpBpmuI1kVIbrWLgVDmM7u9M9z7h/4K19JsrJpk
 Z0FovGCtPxFhC6ISstFLtkAwW8SlVrzyrhfYj2IJiOy3Kj+4NWmUVFCUDZTUi6hG
 1W73Yr4pZCnp7U+Yz03yOjbjgOmWx2WgukWn9KFEEjeXxiXwLMP8vzqhCIhD/yhy
 eDmz0gxEgoLceg3l9UMJ3R5n3ReH3U5BfSLF4//Oh3QtrEgjGp/QaNXl4wOYEZi8
 GJ4nSpc5JxIvDcwC3NuL9Rku9nYH3jEeIKxKYr3hpNhTJYybmGRByICexHt1FNEX
 iK1tZZwEsmuAymVD04Re3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mk6s80hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Oct 2025 18:44:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 596IWD9c040890; Mon, 6 Oct 2025 18:44:39 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49jt17fe26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Oct 2025 18:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg8Zt6JwsqtcdLvbqGE3XQkhISAa/neoa1VwIc8jDiuUORVkpPdc9V+aPEolL8x2Hwm05iHrl5g3h28+XZDeg2/XPvYKLXztncbXPmqAKRI/D9jcPhdnca3AmjSKrga3anbMoAUoNQJNBf2lmJ/qR4JZVtdgDnN1TMUC0SBR81SAyDl+9fc5LukYl5HPtR9kBiT0UETwiyFx/KDUMN0u/hKMViOfKEzwcS44/qbofKz8iUMrC/tEEoBrVHev0PjVQ+anoxRhoZksiBhVSZJnQWhuEjUk7fJCCfnVnHIF69hK026oWCGFAMnwIZ0jgHZOyFZJA1KJck0KOa7sV7in7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVQL2vOTY5yZle2fILDKzV6wDVBA/8nnYBlQWqIHihg=;
 b=v17mGZemE8UydBSoVE7t+MgwCARVC0zmoe9is6F4Ei3dZ10o0OgAH7O+WMZFNcpjLNGWgI/60Bp9kz6JyavQfghjUg/eVQf1JQ3KPYUImqgxzEN4aNZ5MLV9EGsCECX33zn8GFU7z5ASKOddO+ebGo8DhuC1fFHxIOkue/XFLXuDtA0rZxrTTKNxDCOY0NMJBDRe5LCSQvN/tNGI9Bfr+xegTUeoUThn8QcvO7oEnTet21QHyXuOmd0UOTYjJl9WAHiOrF36j/FKPnMXUko0PtwkzOmZSw8G3TyX45FsTuejfWTzfPkWLY2gdnsENSVFQkwVFh5kj9jKyGXRjD0nrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVQL2vOTY5yZle2fILDKzV6wDVBA/8nnYBlQWqIHihg=;
 b=itGLyfStwyGztg4qAIAYr28oK1V2VpRQXn84tdx/WmgGApxQfzlcgLWEb/CCq88FMwNHBhPaCFggJI7s5ONmIATaPqeyF7GUh1uMH72wYM+1cUolGaKbmOTOGRTWO4M+u3NWCdFJOmgbXRLnSbLaYcvd0VUlSk2vY67Zn6I248o=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA3PR10MB8298.namprd10.prod.outlook.com (2603:10b6:208:570::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 6 Oct
 2025 18:44:36 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 18:44:36 +0000
Message-ID: <8e48a225-6ea7-4aeb-8f8a-58955d113319@oracle.com>
Date: Mon, 6 Oct 2025 14:44:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA3PR10MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 931756d4-b906-4fea-3c0d-08de0508660b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDM4TGN3ZFA0aTVXVzA1cExSTEE2dEVaRmdSZE0rcy9IbHZwbjNDeUVEK3FK?=
 =?utf-8?B?T0hlQWxFT0t0VUpldjR6My9sbkcxOUFabXQwZlJhUUVBdDZwcURvZGxIUGdU?=
 =?utf-8?B?ZEUwT2pGY0xuQ1psMlU5bmQ2QXIxbU5iWjF5TlozbmUxeXd6TU5YaG5QV29L?=
 =?utf-8?B?bk5ZcUFPVHM0WnRMYjY2U3ovWnpmUkFkaXUwVlBVVlhXUDBjTFNPeTB5OEJT?=
 =?utf-8?B?QWlPTGRHQ3RLSWNKbTdsaTI4bW1LR0xOV0NrQlVGV2ZvdmdNTUR5RFlnQi9G?=
 =?utf-8?B?b3EwNGp1MVBoeVVyUHhjWmxlMHVVcDlGdDNqaVZsdm5sN3FNVmRlR2lwL0Zl?=
 =?utf-8?B?b0RKZi84S0FMR2tiL05qdDV5U09sZkcxUlJQck91ckxCYk1oeUtuczRta3lj?=
 =?utf-8?B?ODljUCt1NE9hM05NSFpxQ2EySWprMXpyWXlwTkN0bS9iU1c3Yy9obDc1aTRL?=
 =?utf-8?B?blJwa0l2aUplUXdtaTFZSDBKWVhjWDFxbEQ1QWJxcXQxTVd3Ymx4WHdIdHlD?=
 =?utf-8?B?WUxtZTlyS3NhcXptbjJnUXRXeDFiT2paS1JsQWRlM3BoNGFjUkwrU1R1NnY1?=
 =?utf-8?B?MVNCSU5Kb1A1V0drU0VPNWVNdTBBY1Rvdk5pRmsvU3h0MU9QT3h1ZWlRcE90?=
 =?utf-8?B?TzgwZDByL1JacGRUaURMRG8zSktYU2VrNld5Ty9IeUpRWDdZdEpIRnNLOStl?=
 =?utf-8?B?YVJObUFOOEFUcG9SWEorMlZvVUJldDljSHZmUXc4Qi94dkFGNWNETFNScFpE?=
 =?utf-8?B?cHdINlBidnUzVWk3dzlvN2ppODhrWlhha2pGaitKRkNmNlM5d3ltTDZRZUFW?=
 =?utf-8?B?dVdrN3k3ZmJlSFFkZ0YvMTlieVFEY2hnVk9wMWIxRjFJaDFhRlgrdkMyYjBl?=
 =?utf-8?B?cDliZ0FuUzA0M0RhdDF3U2NucTdjZzE3OHBTYUdmVmpGWXE3Vis3Umt4UWc5?=
 =?utf-8?B?aVUvY3VhSmdETHlZeVBvV1NlNmIzQ1l0NHNGV2RDNHhLMzA2c1YrdG5zU0Ni?=
 =?utf-8?B?ZXp6enplQlBBckFUcWVDMkgvMmNibXFwdXJSQXNUNkR1Nkd1a25xdGpJeUhR?=
 =?utf-8?B?TmJNa09ac0l6d2dQdmp5ZGNQdnBLVmViNE1PWUxteEtDaGNJTTV5MXJBOVpM?=
 =?utf-8?B?YnEwcmhqcVlVY0xMOUZBR1V6WlRjOTJSY0crY2oybVlyTWpMY1RSZXZEczNN?=
 =?utf-8?B?dHI5czBrZGRzZlBTSHFlN3A4ckRSREt4NXU1WHFNTmljOUtBeVJWRXJIeXRE?=
 =?utf-8?B?SThIVDVSdS9MMTJoR3dlcEdtei9DdWtva2Z4ZGwyZHZZSDUrNmpsbGhOdjdj?=
 =?utf-8?B?VG5aRkQrTGtWODZCaFZmNDhXT3E2dSswbGZjL3FRbW5KMmRHOWl2RUc5S0dv?=
 =?utf-8?B?TVNYbFU3MFQ1cXZJYURVRHFmM0Nyd1VZeGkwUjZyZVBtSk9FaWtseWhxeXFM?=
 =?utf-8?B?ak82T0R4d1hvblZyQ1dYOGUwYUNjN2hzaWNTODcvaWtkS29XZjhDbFRya0ZL?=
 =?utf-8?B?RHU2cG1HQ0VBT0Uyeng5ZUdpWDJqTWVGK3YycDBOdC9uQUVzbjhFek9LNERs?=
 =?utf-8?B?WTN6Z1c0TjBNcnpMZEVoWmlVdWljNVBkZkF3WjBIWWE0VkY1RXBuaitFTG5T?=
 =?utf-8?B?WGF3MFUrTHZOaTZYK1dMSVQrSWpDdmlvbDZ6VW5UcU8wY2xMeFllY1grcExS?=
 =?utf-8?B?OXE5eGRBSEVrYVA1bnFOYlpKdkVjK2hueTJ1YzdtTXVqUkdIcDhMcXNFeDNw?=
 =?utf-8?B?QVdZY21mUi92YVB2UmtRSmhPUnpSM28zSUR5TXhjcXpRYkdVeHVOQmRaTVZJ?=
 =?utf-8?B?cHpxeWtVRHk1Q1dvS0lrNStqcFJYbFBPNmREYmJhTG9QK05JcVJIQmY3cm1J?=
 =?utf-8?B?aHFvSGg3M3diekpSSk1IbjVvaVVlRWl3VjJ4ZzFMODJoMjVtZXZhZGprRzZS?=
 =?utf-8?Q?7ejkHnxZdeyD+bAGq/xZicyhbvh6k42z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVDemRDeHlZNXhHZzBpR015TXhYYWIzMVJEaW9KczdjcE1tVE5vaDFxSWVW?=
 =?utf-8?B?OGZ1NnZrTmpzY0M0YUlvZFVMTnJxWmhLTzlENFI1RHl5L0phM0lQMWNXc0l5?=
 =?utf-8?B?aENYZUE1RDhXSnpTM204UXpBNVFsbEowSzJtWmFzTU80STIrS1JGVFh5VmVp?=
 =?utf-8?B?VXBtTjBRaXVyWmwrUWhiS1BRT1IwaVlmN21vTU9Td1pBTWdvRGpDUkdvVXhR?=
 =?utf-8?B?NW8zZTQySjU3M0Z3RUphUzI4dWtxVG9CRmt5cmhWSXZDOFFLeXlJeTgrVU9Y?=
 =?utf-8?B?cGxjNjAxalV6OWhVckxHa0RkUjFVYk1qRDBxU3VUTi9XSnlJaWFlVEVBYStN?=
 =?utf-8?B?WmlEbGtSMlpDQjYzQ0llSHFaTGJUcUxQTGZIYzJrdDdtRHZkL1N5YmJXb2lx?=
 =?utf-8?B?N3JEd0pDaVdPdllCd2JJeCtKVjc2MVQ1VFZDaFFLbTZQNlJ1YW15R0t0MzVs?=
 =?utf-8?B?YVRZbUxIb0pwOHNYSkZpMlZHN3hSSW5JWW51cXZpa043cDBqelc3M1hKNjRi?=
 =?utf-8?B?YVhMUFR2dFpJbjVuMEluWnRHNFI2VlRoS25yRWs3cDJ3LzhOZGVSb3NIUFZP?=
 =?utf-8?B?Q3laV0svVEljQ3JyQ3B4Z0ZLeFp0THo2bng1QTJTRWhib3FRUEFrSHNIY0Zx?=
 =?utf-8?B?a2tTRkQ3cU9mOW1KS3Y0dDdqbDA1TFREbVZVRzV4ZGxjS1JacFc2ZEZpanRl?=
 =?utf-8?B?RnZvb2RQVGhXdG5uRDRhYVJiV1VkRGQzL1RPbEw4bWZCUkppcGFza1B1ZFF4?=
 =?utf-8?B?cVF2R1U1NytyM2RoS2pndjRPK2s1aW9hTXk5WnF0RlE4K1J3MkoyUlZDNnFx?=
 =?utf-8?B?bDVLdjNWMUw0MVFqbWNzZXM4UkNXVDQvM01CRFF4Nm1nQXBXbkRpMEREQXRi?=
 =?utf-8?B?aTh5bkhtSDZLZC8rWnYyRGU3WkxDTGZtbGdWcnRVRDl2Sk83UC9vRnErVWRJ?=
 =?utf-8?B?Qm5sWTJSay9sK0JXdmY4SnQ5b1JvdnVwNFArMkRGQ1p5UVFBT25TY05kMm16?=
 =?utf-8?B?d25MeXRFeTY3ODZILy84NlJGNEJjamJBL2ZjY3JDTW1jWXNicnhqc0hzanZt?=
 =?utf-8?B?M2JrU3NpUTZBblFja1drSmxFcXBjZEN2L2xkM1hqTTBBMTBZbkJaNDhORE0w?=
 =?utf-8?B?MjZGS0V3ZlZuWm9Bb1hlNUdJUVlUWEFUOVg4MVNGUHNON2VNSHo2VXNXNFVI?=
 =?utf-8?B?Y3NtZk9SazlmRGlOaUlLR1BMdGdaYnM2dUx4all6eXlXK1p6Yk1oRXY4Ky9m?=
 =?utf-8?B?OFllUmM4S0hCV1Y4U2ZUNUFiY3dtOWlVblRBN04wN24xWktBQ2c5TmlwZjJD?=
 =?utf-8?B?Ny9EZFkyVmtRRzdkUW5oS09oS3c5THAwaFdqaVVmV1FxRzh1WkZyWW5TM21Y?=
 =?utf-8?B?RHIxKzNYWTgvUzdGd2ljazJLOW1XeFBRaFlNUkVySnVRdDZqR0ZlOWlCQTRM?=
 =?utf-8?B?ZmZDWnZYajBVNWlZa3N2ZGhtdEV6RDB6NTEwbzRDb2VveGl6OXpuSDY1ZS9o?=
 =?utf-8?B?c3VSZFg1MnYvY1loWWVpSEVjM2tKdmdzUDRhM2hDTWJvby9Jd3daRGNCdTUy?=
 =?utf-8?B?VFVGbUt4cjlYeTM0UXd5RjNMY0lpNXEyZXd5RDJrTjN5WDQrcWdmR3lielBC?=
 =?utf-8?B?S0g0QkFJbDZCRmljbUFBU1NjZEd1L3VPaEJSN0lmTmVOTXB4d1VEZGdUOHRG?=
 =?utf-8?B?RjVMRTBBMzRzL3F3dGVhTlJSRk9uN1R6eEl2WENSTzhMN3U5eEs0T1RUcWxT?=
 =?utf-8?B?SHIrYkpOakNoWE85T1RlWGdSTTRqcjV1dmJaYmxxakEvRUN1YjhwVklqaTdv?=
 =?utf-8?B?TzZ4WmdUN2Z1bVAxcGU4TWE5ektpVXVwcG1YYnkvZXJyS2lLNWR5YzBtaUVG?=
 =?utf-8?B?Tk9zSW81SWkwckJXcU5mZDJucnFWN0xOVDVTZWtMclh2VGc5dy85RUdJSFNN?=
 =?utf-8?B?MjRRN0FTS3hhRTJHVWRlSzJsbFRpMmwwR0lqNkc2MVhnQmI3bmtCL2tMSnFu?=
 =?utf-8?B?UkZ2MU9vbmNqak9wK1ZXTVR6ODRRU0JKUCs3M3NGSE9wMERqbnNsaDJtc3Za?=
 =?utf-8?B?S0Y3MnRTZTEyMUgyTmNWV1k3K1kyeWtSRUVGb2d1aEZCcVR3RmVBbzRCZGw2?=
 =?utf-8?B?cHRhaFdJeFcxbFFXN3pJTGVRMHhhYVBBdEJUTEw5UXplWnIrL1ZrWEtkUzJx?=
 =?utf-8?Q?7FYz8fJiZSxx/M1F58E9WZA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uQl5Mj+xrMRmb1+/C+wyIoBSuFXV7ZPjphkIYj1cAzhavSADAPW4td8V8MwFioEY/bPrHSSjjCnTUj8KQ5Mz1lkf/n/FWj66KwIySCRWYFdfWtdvW7N8ked5ApO+3UnaVQA44+3P32sNpdmrm77JXR8FnOnet/T84PmWoAqjcAbjW4AmyRp68cS07r7nPxqIX+R2K7EVVtfIrslmti1NyYdJd0g5LlD/O1pf/1PehvpRyKAEGn1Q0bq0U8wmjqddgi//R0cBr+t2hwKXBe1ziFeXoiFA/JtmvNC03dOAkA3twyZIprgEeMIfL8j68UYlN6ShjYzi5nYDy0YN0CUDUiUi79RJ0Y6rpgC3/OD3ArDFqaA1t7SJGGpGYYfznjoqHufEfg4oLBxp6hd77vggNIGeejg2LwfCd410MH73EY+D5ueQt4z5sEjSxY1aeM2zSiaTfDjvzMeakNihWIkyDYlaqJpd9uKFDfx/DylLhW+GFwFpN65tL5ABqMEDsIwyMeq9zrXaS8rhtA1z/KV4KL6/EhtJCMDgoojvPsPvapTU1AGbcNFjiMqpBjocZfjQexntQbygTFS4upZzuat8RBErx/mpFr7hodZdwtcPRDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931756d4-b906-4fea-3c0d-08de0508660b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 18:44:36.4583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glYW/f6efYHriYZIB3iMsYqKSCsfXUA5B1tJx0zY5jNeXotN0nwwO3+PNjtrIFTMLrIMWNsnQU3Kiy0t60IaPI3IWXFV6y9g4EFlb8eFvUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510060147
X-Authority-Analysis: v=2.4 cv=S87UAYsP c=1 sm=1 tr=0 ts=68e40e18 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=XlW8OQD3_76Z3SK2a5gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: Rk2KOEXeGVh2mO7rocCPl9QiZ0Cp-EdY
X-Proofpoint-ORIG-GUID: Rk2KOEXeGVh2mO7rocCPl9QiZ0Cp-EdY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE0NiBTYWx0ZWRfX9V+7rnXZVhRD
 YHvgGW0VeeCJeaOonvNjfoYW/892wR/eRk0bTYTFkrV0diYB8za7XUFH+nuW/TM/c9jIG77YLpX
 At91arHi+xKGQbXpsJDu9Ij0H4VpLSyKQ1OeklcHKyrXqV0hsb+erAJSSpanG2JeQK709rR4604
 5068YAtnUMAmZFDUVhdyd/Q4Uuw+UKqx0RXBnUMJOtUi4/uFWe77A2SXUs4NUMaD0Y5VAf46rEF
 qMKqBN/pLJuZY2MhQGlQB6KpYGrBlbmi49ljWtXAAyd+cl9m7FtbWed9Ur8Oe2nSIAqzn4BUmgS
 LpUofrAwbLv6QG4BMBjtxokW/Ztt0xIA++oiTDcEkKroafVAOKEb63wOU3kBkze4HowiAPdv2EJ
 Sl9fSlnlXUzOjOPluiylGM+gglVoOg==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Cédric,

On 10/6/25 12:07 PM, Cédric Le Goater wrote:
> Hello Alejandro,
> 
> On 9/19/25 23:34, Alejandro Jimenez wrote:

[...]

> 
> 
> The current status of AMD-Vi Emulation in MAINTAINERS is Orphan.
> Since this series is about to be merged, should AMD-Vi be considered
> maintained now ?

It should be considered maintained.

> and if so by whom ?
> 

I volunteer as maintainer. Assuming no objections from the community, I 
will send a follow up patch updating MAINTAINERS.

If there are additional suggestions/volunteers for co-maintainers, 
please reply to this thread and I'll include them on the patch.

Thank you,
Alejandro

> Thanks,
> 
> C.
> 
> 
> 
> 
>>   hw/i386/intel_iommu.c       |    5 +-
>>   hw/i386/x86-iommu.c         |    1 +
>>   include/hw/i386/x86-iommu.h |    1 +
>>   qemu-options.hx             |   23 +
>>   system/memory.c             |   10 +-
>>   8 files changed, 999 insertions(+), 154 deletions(-)>
>> base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
> 


