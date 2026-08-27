Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B51C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBs-0008F1-Fp; Thu, 27 Aug 2026 10:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBq-0008EU-7l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBo-00021M-FF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:49 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8mJj4152300
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fPVFikUjOu5vxUxgDcOeXKugA3KCXR24xfLQHSsfU
 y0=; b=ujS6/828TNjvbI69S3GZHVmuNK+S1wnMtDclPWutHac098tMtkfiViFIC
 d4rdIp2em46WQozQFfMWhYILq7ZcgSfwNCJwgbaNP+j1M2uNxZKR+WW3yrQ35euf
 XHJegBtsyDRwfXOZK7CfPwhVewu3zId48LR/bKYZ238UxShSiJhWg0ihDGAosDwD
 y865ZwLToR+8zkf46zusugtg6kJdJ6BHlqHZO05989eZ+f5nAvX1z7s8e7ALPMtd
 wD/gfCF6ohU10NqWEDcO8V90MvZfI7KymMJg8Ztn+RYWtqFXUaP9Qqdr+M+cqx2M
 jH3RW3fT99MSnJVygWd1mFBtShF4g==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021089.outbound.protection.outlook.com [40.107.208.89])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9e1udwf4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss/znutTBKC54d++QotZvk0U3YcjiRgsAbLKWeyiEjPaPTwIq+qxnnzcYbl79nKL064Eh/Hu07d69JkL9TU8DFGsSWG/J29t1dZaQ8vuMq2HrgHryB0whexZaGNVDfc4U6aGpoyFlh5JzqWvtExjjUILgYcsVskX2bGD6bIlL8mWOyU1jRQTn/nPSAx/IVAU/PldwkrryDx72GtumiYim3U/ZQ8oiIU7oB0uNFfPjM8b7G/6sllv28DMb/em5/ZSFdzTX2FOuip1756Dw0bfTDJDHI5oqLQKbWlvo8l6L8aFW79VRI56aslZjA+Kn8k9jzQdTnlabj4/m2BwezPLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPVFikUjOu5vxUxgDcOeXKugA3KCXR24xfLQHSsfUy0=;
 b=iEY4WyFNn3gdiPlWBT/bhDO18xxo+4yldq8EeBpOX3K4Fk9VPARJrD1ThfkaU6hmDLzgKzHWv2hIlGlhFn06wn5Z8ojEI4v53mmLin0ob+B+dbtKwDE2Oa/hzhknK5+Mh4VQ7kf1DTa4PWpXVIPMbazSaj6s4uqVxxHMSeI2unY1zDWGteOoZEeaa0zyX2P15h0u/SmbFV4fQFaw+N8kaStYUz44e5XcthGV8GBcNcclZy2JR81yfnslEX2M3WTNjEuxSaZ2RfQLXf30KTNC7PIEpTNSsOQ3aho3VyaWDFIYDyWU5PcD+n7fw98FpY5wtpWrThjAdPltq1qYM/uGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPVFikUjOu5vxUxgDcOeXKugA3KCXR24xfLQHSsfUy0=;
 b=ORjb4cGd4LNrYQzC0UaXQZEyqp0xCy3w/HPQXk9fpcYa6DKPFUL0cCMSoTixT3LNVXxXaPiPt1UlN+XrDuOnMsdjBhtXTgQuP36CnpfnqPJgUDK6d1OWlJndLqDEvPQsEaSdq1qQ085GmN4il++Mz/jsii9dqjOjz0F5/v6DajddiBX3htpMEnTLatjNZNdVQpU3ZrnrNw43ESQZE3ivxHbAoCGE0ZT8y7BJ7QH2MqvPPTsI/2Q3v9EnPkK2vF3mv0XbUeoWI/CrUYQdb8KxmxwGukY9fTx9eDfw22jvywPLEJY3msuhup8Sc67dssuBtOqb448eGROgW3aIrjUORA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9251.namprd02.prod.outlook.com (2603:10b6:930:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 14:34:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to a
 static class property
Date: Thu, 27 Aug 2026 15:33:30 +0100
Message-ID: <20260827143404.1393166-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c9c8aa-5799-4f76-f09d-08df0448525d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KZ51z/w6MY4xZcUa1a5oJZ+/AkDTc3PcXY39kU9NNbZ6jYau1G2fO9iRKbduUZssWV03wL45H5nrgqY/2r9VZWACdIzfl04nEbv7Wg/wdHL6IaZN3hfkWZWjDwCq+IE9CTj+jzDcFfMwAwvGj60zF5v8IV4EKIp6ldU2nAF4W+BwNo/mMTP7M/JDkEKzv2WQ8FSvQbQiRs/4taIzOC5JsSg0mLzHUS+6T3T39nvGmh73TMKzcgGWHAhL6VWC/63Yxmb2/F4NuSr1sH7boSe3UFi31cpo1IFfo8O/tz1GT2s8hOypKIZFXSemcUIZysC/MERZzNIATZXTpzb0TYhdHMLoEkxxO1FZGLB78TbgKtDijLlaTzVwS//2M9vHT/D99r22u/2h1wMDTZq1kMBeB++qHOux5n/Axq+xPc4eH+YHDtSf7SvVXztrDi4rR+vGD9xCM8W5bDlGC2/rOfgh32MI2zrtMZIPc6ZNa707DlH7FnhlW2oPTaSi6rRnAOD49u3/EKOfK7pD05AdBooFwsc7K9cDl/R+GULmFykNBlS70lTtM3z2yqoxHwx+MZSsgMC+/Prl+bV9wdE1ijiohItynniHewm3bkcvlrkPrEMQuU0uCgycggLZtDINs2rmynOrgEHZOr8LWOYgOjoaQZ1W6N/2Kn8EE5GeQ0LvcWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RiMndjRmpDYzIzQjdZNDFXNDJCclBxenYrazJubjh3MVVOeFZGZG5WM0hh?=
 =?utf-8?B?VklwOVVPZVAwZTdsSTNLQUlZd3VuR3VoM0cwN1NJOGZkN1lLN3RIRjk5Z1lN?=
 =?utf-8?B?dm41SGdHajBaTnhDM1FETVFnaWZBbzRGZkdkUUxFbXJldWk2VFE0KzJSYld4?=
 =?utf-8?B?dnpvL080QU1nb3p5KzhsUmlESlgrUkVEK3BGUGtXbVhyekNHTS96ckE5S2U5?=
 =?utf-8?B?Q2ZDVDMxemhsdE9sZG1QdERMRDRtV0RPY2xDNi9PaURubnJqbkloZW1XWmI0?=
 =?utf-8?B?Ti9tRmQ5cmxmOC9SUzM5a1plZ2F5SXJ5RkxtUC9POUM0cUxiQ1hQRkxnOXNh?=
 =?utf-8?B?VjJndGZMY0NXdWFJdFlnVTJ1OVBReXhYZXBSU1N1TWtoMFRRRUJKVFloR2pB?=
 =?utf-8?B?KzF6dldKdFczcjd1cTdld2Z1Ly90Zk5QNkVzYzlzOU5zbVJCK1FCSDgwdHcv?=
 =?utf-8?B?aEJQYVJ2Wmo0UXFuTjVPb1hrK0JaYng1UmlqeDdaU3lDM09UOFBYOFlSb0RC?=
 =?utf-8?B?ZTNqeFJNbEFWZnFnd3lKYzlML1RUeUc0RFVqeVB0dW5VWjYyeENDWk5JNjBC?=
 =?utf-8?B?L2NPakU3OVF6b0RNZ0s3ZlpqVm9WMGdoT2hIOHIvUkplWlZwNjFoMjRRMHVO?=
 =?utf-8?B?N1FNRm40eTFYVTdJbm5iQXJ3U3FQSElpeEo1dlIyc1RGUTBzc1N2d0hFMDBW?=
 =?utf-8?B?Y1kwVzRLTEFyTUdNUkRsbzN1djJlRU9tZUQvMU5jMmg3aEdYL3gxMVVVeUdt?=
 =?utf-8?B?MU5OUEJJMXhYSklnd1dmVG9qQjZFL3g3cU9HVFI0VlRwUlFxNUNQeUlyK0di?=
 =?utf-8?B?ZmpIclAxQmttbEFvbVFpamdFWkFXQ0U0SGl6RzlWT0x3NElXUjhCdjN5QVdG?=
 =?utf-8?B?cjZGK0VacDZGYjEwM2ZwUVl3VHpVTVZLTCtzV3FWbEtFMTNBbytUQzV2MFFu?=
 =?utf-8?B?c2NSMEpwaUk5b1lLNnZya3lETFpQQ0RaK0pscjRtTFBpanIvNEVwa245VTBU?=
 =?utf-8?B?OGEvWXJvUVdLQmZvU2lCS0Vta1R5a3JvNWhxSVQ4MUxmQ21rRk8vMWlsNUhk?=
 =?utf-8?B?dEdETVByWlRpcnk4YnJQbzlZUXV0S1NWcG90K3pGNGxXa3Rqa3pzSzBUR2Vn?=
 =?utf-8?B?T1h4OTNKNEttZ3o5WCtGdHRFcDZCcXBwd091cWZkYUhDRm93STEzMG4wbG1D?=
 =?utf-8?B?bEZHTUZLaGZFbGFDUFVuWWh0dk5iUDhkTUN0elNJMWdDWHpxVno4YTlBdlZt?=
 =?utf-8?B?anVjdThOWkhDeklJcGowdUlGWWh3RDRZQ0llYjVFdlNIVGF3aGtiT1FsL1dl?=
 =?utf-8?B?Q2ZCZjd2RTdIZHhoRmVIeGdkUmwyTHpJMDMvaFlaWURUSmhvNWUreG14VDN5?=
 =?utf-8?B?SDc0ekg1UXBxUUo0ZEpXVTdTWWtYOElkdmJKVHh4ZjViVnFlNWVzVFdmZC9p?=
 =?utf-8?B?K3BKdExqZjVkU2J1T2srdHpNTTZaUDJXWkpTSmJIYTBkTEY4NXpubjNodGt5?=
 =?utf-8?B?M2VjZ2RWME1tLzhLY3pPUVRlc0ZvOHdhZWlLeTZXZ05sbHFTUDhVdWEzNXQ4?=
 =?utf-8?B?VTUzaVpTSlQrZ3lLWWpsWDVmVFNudDRGY3BJeko0NFF1dmRiaXRTam5Vb1J1?=
 =?utf-8?B?WVBOMUVCZ0ovSmpGd0s4S0liK0RQT25BRm5oVWtEcmtBbUkyZHlJVUp4dW1O?=
 =?utf-8?B?UHJFUzJoTUQxMloyTmdJVmRRWFYvYks4Z3BXVTVaeklqR285SUtJcDUrMzZy?=
 =?utf-8?B?aDZWcTVhTEE2YW9RTGdEZGhNNnFLOHdPMjN3Szh6ampzRHg2QjJ0ak52RSt1?=
 =?utf-8?B?ckJDaSttUk1LZzNkdHFyNkUweGdJbXVla1IxUC9IQTI4bXZjQWgveGI3MDZP?=
 =?utf-8?B?dDlEU0w1Mnd1Z2dsSGpNaVFZSk42WWppVzhUcXMzRnk4L0J2dVVwUlFGZkM4?=
 =?utf-8?B?ZVg3NkQrMGNaMEREcGlmdFlTTTNVR0MvVG1sMEp3TTZLQkI2eXFROHhud05n?=
 =?utf-8?B?VUNiZU8xV0UyYjQ0ajFhNGhhZlZNOVc3VGE2Qnc2WUUxeHpWMGV4SHpWelRj?=
 =?utf-8?B?SjVrdnE0ell5emY1NkZCdjFOVk5oZkRWYzM5U09iM1B3aVFjTlpDcVd4RUt3?=
 =?utf-8?B?TGZ4TW5iU2V3U1IrY2dqdG1FZmVVajVsbEZ2dUo0U0hYODZtcUd5dmRzV3BM?=
 =?utf-8?B?elJtUTJITyt6SXQwU1pBcytOR3RWSk9IMjQwZkhsaFVQbnVWbFE0T3N2ckYx?=
 =?utf-8?B?eUxmdkhLbDFEVlJiK2NzWUZQeUlTalZJZDA0aWZQZndmVEticzVEK21GTWpW?=
 =?utf-8?B?WWlzTkZwQm9NLzlOMXM4c0oyUzVBYWJwWEhKQUE2TWl1eWVRNXl5QVNhQXRZ?=
 =?utf-8?Q?/f+6RQ82xZLlZIlE=3D?=
X-Exchange-RoutingPolicyChecked: g/pupY3zoWQZ/326NW3HlXt4hPFYcx5G40c8dbBwzK3Dhyo/tkK2nIN8Oud16PDWjF3Z3bCXNfqNXcB4R43Rc7QijYigNR2AizyJ4rEyQu0ZK0PlU6KEjBTs32lf62QdQh/nCqpQf/qQNeZNChNmADOFE2vQexPaeWkrLjIuoK50YDJC7p9S+aUaBsnj89LHUEDYoA+athwBjqJDYtAk91CauvF97u6Q3Cx7HU6RwowgwXK1o1ZVHM7PE1zsTgXoo0N9mOHIFYTOKl1cilqdcMZMn8SUuAGD3SPFc4N6+LOUG3zPUeVYSOSyjT4xURRVdqtT0QOCV5YgsyrLdRbrVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9c8aa-5799-4f76-f09d-08df0448525d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:37.7606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8Fs5ZxvUTX3FK8KOzimczH0ZIQv3c3Y82VgQvX+vLYfipc1CZwOBruo2NjS2X8M21h+g7LPxzMMiBmE2RmJ76yp70Y9efpXFna49Hg9O6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9251
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX9EAfag884hAJ
 Vo3zXQfQh6a6CjRdxlOGoHIofuSaut+rEk3gt9MzzJzLsJFPMEO0oYDePBhUnrAYv07K/DkwoSq
 jMs9a2xeUDEbHjyDM8hjmSxvMcFb+4k=
X-Proofpoint-ORIG-GUID: aIqpKlJZtL7pN7e5UQE87FUibD3xlZiS
X-Proofpoint-GUID: aIqpKlJZtL7pN7e5UQE87FUibD3xlZiS
X-Authority-Analysis: v=2.4 cv=RJyD2Yi+ c=1 sm=1 tr=0 ts=6a904b07 cx=c_pps
 a=rgmdkwC1tPsVJMj+r4rvFA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_dIhvDIfpQVvNhxktcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX0RJ3CTYcf9+P
 1zf1hz4WIVJQ89Ck9xe4pfQigrPhs6kpUc/5utHkfGDjHMXP+4vc94FmaSCvGdglAGEknM3gDcu
 v8ELFVldAGt/HmsMex8pfbeRVTc8RlsxYqkXpDwtmKDlzst0dVvC9S0iZjLlVhpb/6n9qa1E1AK
 yD8Y3WAsK5BEasUKF+EvTX0ghhjxkvnqMXDlvnVstx4Q9Wb0oQsRJl3utBjBIQDH4hXYOoeLN4/
 2gA1Q4FuWkoetBXV8pcY0t/QNlaDmphzfLSuR3rmsYeU6+yNiA71Tl6z+bvy5LOB+0VIp2lz2Uk
 erU/u2PmDkKX43f1wts1JsGJT3RU0OQIavjh3gLWtKl8niGKnIBqsi2m0EhcNt5BMKojLbZnE+z
 cFbTYZ6JqObvbRDcBeIJMpyQMJ5n63vtXSCjSeN9g/QItSYFZPvCFqHuarYibuwF3NP3mONbBv4
 A5M9AWt/kFIKnVmUnFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ACPI_PM_PROP_GPE0_BLK_LEN property is assigned to a static variable and so
can be converted to a static class property. Introduce
ich9_pm_add_class_properties() to hold the ACPI_PM_PROP_GPE0_BLK_LEN property
and soon all other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-10-mark.caveayland@nutanix.com>
---
 include/hw/acpi/ich9.h |  1 +
 hw/acpi/ich9.c         | 14 ++++++++++----
 hw/isa/lpc_ich9.c      |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef5..3fb993bb9e 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -84,6 +84,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
+void ich9_pm_add_class_properties(ObjectClass *oc);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index ac3f452dc3..774b34195f 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -402,8 +402,6 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
-
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
     object_property_add_link(obj, "bus", TYPE_PCI_BUS,
@@ -413,8 +411,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, NULL);
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
                                   &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
@@ -432,6 +428,16 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              ich9_pm_set_keep_pci_slot_hpc);
 }
 
+void ich9_pm_add_class_properties(ObjectClass *oc)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
+
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_len,
+                                                OBJ_PROP_FLAG_READ);
+}
+
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 07c9509cf4..d3f1358887 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -919,6 +919,8 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
+
+    ich9_pm_add_class_properties(klass);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


