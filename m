Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC3FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx6qw-0004na-VE; Thu, 20 Aug 2026 13:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wx6qv-0004nO-C9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 13:46:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wx6qs-0001Ab-RJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 13:46:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KDOZ5Q4191359; Thu, 20 Aug 2026 17:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=YrF1i2jbYbDhKnrzUJ/Wj+r4Tt9tg6NWVX+aEdIG7+s=; b=
 Z6blv6gah966qeLLU7B05W++08Q8NHI3NPRFZVFLHp1oZFEFsJeVIaPu0o4E6BsA
 023kJ8R2QUA6ii/hmQCEx6ar8Z2y8A81VnBFHBjYveojZelmBmzfKb8mpiUdFgWq
 sItUOXByTb44Z+ArKFoyOMHz1Cvo8uXk1llKidOEGiIps3Yxwv0xIv8RSi0cSUSC
 Cr+Ow8Y8RngFbhAyAntrZOk3U536L6hSWBri+XOGYvHtlRU2MCVjJFOv9DHyx4wd
 wqi+46vaGtAgvgfVuJ0JYoapbHbhAaVcDcU8hiFvi+GQvlGP7ryFlLmGfsTfCNjm
 Gts7qFJjNhckvYoBYFcKpQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydektd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 17:46:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67KHeffd019437; Thu, 20 Aug 2026 17:46:50 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g2ejtgx14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Aug 2026 17:46:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2vAo7tdpSwDu3fHXey0Gg42mSc+flwS5arhd0JWiv+alZraXNRHsvs2M4XxczT6bugCdojuHw6dmlIz594voDdxEqnCHRvvxEjDFVTB0yrADoArjAqG8a0GlbjRs1fzNcs4LNo50WKihPatVhMgbZuQtv0js7OCTZ6i9qtoFkBtEP/plbhB6Qo7K+lQOm+G9kuzQFxqhhNaJgDytkNtbtmHSEWlG4pRwVxy/Y9hXtSI8HJod5prhdq93MB4Et65VIW4ETuaO+b5CLmcRAm5zmly+sPaV80D4M4cF951xPhOr0FsiPPK0D4aOHz7l7wOcdd4M/PEN5M8YjKo8Bnl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrF1i2jbYbDhKnrzUJ/Wj+r4Tt9tg6NWVX+aEdIG7+s=;
 b=S25j731W02Xva4QdVxqruutP+8XMpmUVNORhS2qNdYW87hFTZj1fQzgQE3onXZBquxtSrxzQAUVGEsgdtpqCZcgdzFYi2r/VkQjd6TY3CMn+wfk9VqUBEP00dwJYhusg5vcOGfh8fwSE0xNvGs75QTcIkMA4wZYuRb/eIV5P8a/PnE9vWyn36rZTMIerQtC97NSjZMVsyVthyHMNfaVizh+6czDjhJvQGMEAd4Wr3G9sf0boDdFNx+n/HVTqBPe+vQGjO3PAl9J9x83Bf1yHVFXlbhaVnWo1yU6VJ78+pQV+vBlQD4JqAfo4+e3L0hPYISCEbOuDtlaLcN7NHXPUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrF1i2jbYbDhKnrzUJ/Wj+r4Tt9tg6NWVX+aEdIG7+s=;
 b=APcvwz7VIFhQE+U1xlaXeoP/PyPeaVqauOaorB73AfIGO6zNgpxSnxq170U+RwX+ZlgE/2NbudTJ7k4fiUGZoM3Ajjdmj6vgBknJOAJVesjb8nCx+ER2d61HZROcT/Vl4udoFU/iYGrzys2xO0crfgAG7RVobR4cUrk12zH9KXU=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by BY5PR10MB4322.namprd10.prod.outlook.com (2603:10b6:a03:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 17:46:47 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 17:46:47 +0000
Message-ID: <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
Date: Thu, 20 Aug 2026 10:46:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, maciej.szmigiero@oracle.com, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87a4qh46ao.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:33d::20) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|BY5PR10MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: a02f691e-82c2-4d17-99ae-08defee3019d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LTIcc/AXGN2p8XMKVseLI0wfr77G6V+cn1S7HunB9lH6iDWoCG3CY1wtnol2MpWr2mvoQ+PDwr1xioyhNVL9oWQUbkjnm968d7fhxMBxOy8AYWNdxAod+69d7+e8MklHNqi8Ph+K0ENg1uLK4hI+UNTcBhkRNFC9u2djVGDXnIh65h/7mzk4fgMSqK11qgWefLAtf8TqG3pCkROsTl85rzv7Q3asZlv+vBUK73zJsJaz8f2zbuvI2cJXkZx9lqio/xrBimjKEVSfpdWJ0bSjnNC5gdCZQv8nyESxzr7LM/KQC6EW6lmQY8fHVAVcosShRRejD0Rpll9GNjUmdhxPJ29PKzEMGNKhvlg95WrWgn1fdcJBM/JXvIsIjA3Vg7DSeZcTKIkgCQx7yWymRPKZWHtWE9ezZSgX1meVu0i32R8lYakTFUXltC41EnKPTlTEiQe4Pd3m+nPlPkikK/DsGXfbeZDbZT3IIMT1DrsY8+N++lYLRjt712PD92N1zSFHApVeAt5AadG1IDOIOW+bi8d3MbjOcISqIqTa9/FfpQR6F4/BD7kVipt4SFXKy0J4yMlXt9GwmIMimHZE1qVMdrLclMFZJg/ORWQuSYEnqT/1dzJYIoW21JjvNYO2rRq0zaf1xYC47DJ3r/C8k91Glk3mEgXXtsEttRRsZ711Qlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmdSdTR3cmNkWlJ5d2FVQzJCbDlIZFpraVgya21MTFlkMGpOSklHRnpQSGp4?=
 =?utf-8?B?N29WKzFlMmorek40bnJOTVVKbGZoU2VtUHQ3VEYwNStaRmVRdlVQcGEvbW81?=
 =?utf-8?B?Q1FBMlU4N2ZTdFV2L3dGUGVaZk1rRGo2dXVZalhBUHJnM2U3aDZ6QXV6UlZN?=
 =?utf-8?B?R3Vld0JhRXZnbTZSSjRabEl6QnJxWFdnbWQ4SHdyeTZCTTgwU2FPTlFnU21n?=
 =?utf-8?B?eXF3NURlRjhuWWw1cHI4UFdRaldGRHB5OE1XcFlMLzhwNXFXMExUYTJURVow?=
 =?utf-8?B?bE4zRjk0c0h3N0IvRTJTbWtNanBpVVRvbU9CVy8wc0toVWhuN21SMVU2VFpY?=
 =?utf-8?B?NDN5VzJDVVVLRnFsRVZhVW1IRDZ5WFM1UFBPc3BqMk5SVkJ0TDkwdWMrOVo1?=
 =?utf-8?B?S2VTVWFZSVFxRXlhcWh1Z01nWDBlMTdVd1FvcnlPbSsycjdYNVljK0k5ZkY3?=
 =?utf-8?B?bWpuNStHQVBTUDRWTzBLQUx0SnlCam9xc3lrV2Rod1NjbGJFaXpIOWNEYnFt?=
 =?utf-8?B?SVZ6MTBqL2JhYTVGWkZIdUUyQmF0MFZlRThnUTZyK0pPUjZTQXlES0w2VTQw?=
 =?utf-8?B?QXpnVnFXYVRvWmhabFh5SHBWTEF5MnFYZWpwRmhXNGRtdklPRi9qcXBPVWNY?=
 =?utf-8?B?ZFY5NFlLN1YybWx1SndQMmxUQk9aTGVQRW16WWNTVlpJNE9ocGM3MWVQVzI2?=
 =?utf-8?B?Y2lHT0lBODZiWXpBaFRNbEhUNTBkdFlLdTJSbzRJN1Z6YTZHbzJqd1hEN1dv?=
 =?utf-8?B?cjcwQ29BWS8yMGRxQlZEdEhhZUw4UklKQVpKcWdMVlZXNUtCN0VCMFFYaTgv?=
 =?utf-8?B?TkozM3R5NVdiaUdsOHM4OXRRNk1oM1pZbVZLbS9iZnZLVFVDVVBGeE5Fa3Z4?=
 =?utf-8?B?YWVZazJ6Z0FxRTIrZmRId0FIUDd6WUZ2U2xnRjg5Y3RTS3JaWSs1eTVlYVhG?=
 =?utf-8?B?dlkydmowWVFYekFYVGsyb0NacksySjFSSzduaVZFdmNFK2d1Y0hBVE5lbFE1?=
 =?utf-8?B?TTB5bHMvWis2aHRnangveE9PM3ZheVlBbFVtOHduRUh4Z1gwZk51bi9xTXRp?=
 =?utf-8?B?a3RSUllscHZVUkllelF6RXd0N21XaFQzWFJhbEl1TGd0STVLTU9mbHhTeGo0?=
 =?utf-8?B?WkoxSGN2VlprNlh4UFhIb2xiRXJ6MXczbU9ycHVpVXFaMXhkbzFqTVorTFBw?=
 =?utf-8?B?bTB6K0FEaFErSTlTYVNnRWNvQXpiOGtPQzVsQVk1K01wMjRVTUkvTlpjYzZa?=
 =?utf-8?B?ZG9xUXhmMGR6aVIvZ1gwU282ckRLQWVzYzI2amdrZzkxQTdic0owTHo2QXFQ?=
 =?utf-8?B?bFAwKzRTdEFVeHB4Q1l6ellNQTBnYlprVFV6bC9oblpqS2pqN2JtRTV4THJY?=
 =?utf-8?B?NU9vSHBtcTVNR0VQdm9iNE5jSk9heGZJaGtCRWdubTRYb01wUEd5N3kxMC9V?=
 =?utf-8?B?a2NrZnFWUkJUV29TM0hvc3RYWHJBbk9CWFppUFZlb3lPSDBHNDNlVy92U2FC?=
 =?utf-8?B?TFBXbi9PRXp3VVRybkF0ZVh0UUF3Z0hROUdaMVQyQXZvQTRrOUpLUExuUkdn?=
 =?utf-8?B?OSszRUIvOEZ4NGlWdzdKUnFRS0J0YVFqYVZWOUVnM1FhQ1pFNXBGR0oyUy8x?=
 =?utf-8?B?VEp4ZDNGbll5QzA5VzhuUHErdlVKdStJd2pZUkhsUmdKQmhSenBpVkxlYmNM?=
 =?utf-8?B?Z3lsOVlIaGpLQytTSFEyWlJhOGhldXFiYldVZVAxWjBxL0plK1hoRmhydCtL?=
 =?utf-8?B?OXRmY1JZdHVoVmFrZTkvalZzd3FzUjBvRjRUMGhVTXBxVFBuYjlEVUZRZ1gy?=
 =?utf-8?B?dnJrT2hvbEtpYWU3cEtxY29vZFFuRjEySXNRZUxyQ1lEK0pudUM5SWVSOE02?=
 =?utf-8?B?NzkwQ3ZBYjVwMnc2OXBpaXlmYTVmNVlHQVFTcEc2SWVCZVZoTU10Uys0Wkht?=
 =?utf-8?B?T0VRUXlGM0FkNkJXMnJEUFl6TzdLb2JBWFo4K2xIZnNFbTFvSlUrWXo1eVZP?=
 =?utf-8?B?NU5kSXpFeFRDdkVXdE1SakpFT1U4TmludGlWMDUrZ09aYlhvdlg0L1QweUhU?=
 =?utf-8?B?TW9sZE5KUUZocDQyS0ZXbGFSM2kyVkV6R1A1S2dCNDNuQlJWV2ZUclBQdzI1?=
 =?utf-8?B?bFIzRGYvTC9JcmExMEVSWHdPZG9wMGdNV1ZwbzNPNFlHdkpOMHlMelU1WUhP?=
 =?utf-8?B?Y2tnc0QwMkRIM3ozUFJTRlJXYURqUCtSM25ETWNLMXBNR3g0bWhVbzQ2dkh3?=
 =?utf-8?B?a0xtdGFPY3dmREppZndBdnBUNG4yYVJRcVBGdlBHSkZNdUdPeVVaaHhKWUkv?=
 =?utf-8?B?VmVPYnVsa0NIQUFmZkdIdTQ3ZFVINnBpdlJWZmFXWkp6VnhPMU1BUT09?=
X-Exchange-RoutingPolicyChecked: MkMA29OoG2Hp/wM8DP/75MbfQgz3GV8WXu+n2ddskLiv4+L4KKIBZ7hseKjKoXITAkE4mj/Iw06DtgSXU4OOm5o8qo23YyjygoSIjYRAYf0TCTFUQtwUYk6kbsM6pSNHwm2qHVs3e/Pua1r6AaU9MwZkS1ik75i+n0uOx3RlM5T3Kr6HCx/KqkSpRPbFbV9zTbxB9zunfgcsgofdX/tuarluNaG7Gh9lMtIS545bnRcxhPWVl65z6gy4Nb2+oR7eahVWUq8rlUQQay+Erz18iDxx9RlA378KL2Nj1ODaD0uS15WnPE90XANwncHWa9B0BvKYP/dqCa9uGXoSbGbphg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DtRTnsQFv0IPPFQgijT5EJkzOoMr7Uz+wbWxRALtZ/KMQvZz23ueAaSI3ydZkxgywbc4ZZPfyRDhbr0g7rGVjdLNbN4Ns8Y7x+U/O6x289HWbnRXYd9sciZAkHxghKB53f0D59B67y2MAqWQFplyk321bFvn9AZJBdVnkT68DfS/BQxtHpBmnNgq2+0fJJHil0NxU+/y5JWg+5ljsco+zbKf4QOgyDiQ57WXxp2oiywHXCNLbaQdBQQmFySU3T6fuZ9J7HDEmCJaDcHwlgTDHOidYDGFokLpfJ4LoMpn8c0Ed8nmNXH23adwzEt2JdIJha6ofvQCIxEJqDSgWUfOt69YAE4D/TE+qm1jbKkbQBXyJi1vpk6vITsqaU6MMrOuOViei7d9ukQPOSATuWj9uzO/VpBErVZp0hqWClHNsE3lGn7oU6tVy2rl+cejwMNbvBRiIGZkON75eNroGzVX8f2JeWmTKgHFrudHUr91zrUD8biivNs31YMPwh6+Xsh4iG5VWWmvnXup0pftHH3utZNQBu1ecuFULdZtgpLrdaeZ+sM9P10zDzZPUIc6Zcpht/6tXK0my5dZzk9S8v2WM+nrkx98MTW3K0HBCZVFMN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02f691e-82c2-4d17-99ae-08defee3019d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:46:47.3145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR9jDhqzWi44ZNGAsUegWvTqRPdyGQs6G4vUUTLOrf57IqKQir+bUbi8dkfiEeggiDaKSoGc/XsdxG2lyGIo4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200133
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzMyBTYWx0ZWRfX4zmOQjjt6g/n
 sbyzjqJXLfvxEa4/5YcIMayEHoEKUxc4VZOPLA66Wrs+S7hqSzFFcP3jW5Hr9wEBZzy8v52ujVA
 k6hAxK7oRQDPclboC2/bQiSFjxdedu2vddwqVfN7lFtCoQpjQUH3
X-Proofpoint-GUID: Y2pecQvIOAviaRStx94V0Y2pDeJmX5FC
X-Proofpoint-ORIG-GUID: Y2pecQvIOAviaRStx94V0Y2pDeJmX5FC
X-Authority-Analysis: v=2.4 cv=WNBPmHsR c=1 sm=1 tr=0 ts=6a873d8b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=y6SUY02Ifst1XN8_WesA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzMyBTYWx0ZWRfX717Wgx9VPJaz
 RExcMjorQTHR3o+sh3p4tdcq3vlXJ1oug5IUmksUCVPbcDkHm1MP7bpThFMnQW6DVlIUE9SvTJ2
 kqKBwrs1QSNyQgUGV8Bf9bjhQDDJfT5A+LRwpb/ZySS61Fs42XcLLb6RzBrzb3iIO/duBYqD4cw
 Q193CdGhU14Ek7iiAeOnlkKxkNtarGW1MC7p3gkpoDqpIEu4LRGWmlkhsuuTc2RjIQJOlVWPCpz
 EMM37qC5a0VxrsUdEM+pB9Ht+VTJYlOBI+My/QumzxEkBEh3LUwO63ebD+UYE30jndyaPqcfAoE
 M1W2JF46ScYIckhQJ0p1rIgea+gXp4JjbDkNeeI0X0DyLwjVe9MGY4vkeFFfQKZcQmqTFQA+X5t
 YxPnPzzJTauQs5bK4UWtFfxixbk/R2QNeqm5s3CXmXRIJFUq2vubh93pig5YiGtKpL2uLZnJN4+
 DfkcLR/B70InsTVMzDAwpl6NWy3eRQT6XZkxpigk=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> Add a memfd migration transport to the MigrationAddress QAPI schema. The
>> new transport has no user-supplied arguments because QEMU creates and
>> passes the backing memfd internally.
>>
>> The initial user is cpr-exec, where the main VM/device migration stream can
>> be stored in an inherited memfd instead of an external file.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  qapi/migration.json | 32 +++++++++++++++++++++++++++-----
>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index b1eaf7b054..1505c201ca 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -702,9 +702,11 @@
>>  # @cpr-exec: The migrate command stops the VM, saves state to the
>>  #     migration channel, directly exec's a new version of QEMU on the
>>  #     same host, replacing the original process while retaining its
>> -#     PID, and loads state from the channel.  Guest RAM is preserved
>> -#     in place.  Devices and their pinned pages are also preserved for
>> -#     VFIO and IOMMUFD.
>> +#     PID, and loads state from the channel.  With the @memfd
>> +#     migration transport, QEMU saves VM/device state to an internal
>> +#     memfd instead of an external main migration channel.  Guest RAM
>> +#     is preserved in place.  Devices and their pinned pages are also
>> +#     preserved for VFIO and IOMMUFD.
>>  #
>>  #     Old QEMU starts new QEMU by exec'ing the command specified by
>>  #     the @cpr-exec-command parameter.  The command may be a direct
>> @@ -716,6 +718,13 @@
>>  #     as a file, that accepts all data before old QEMU exits.
>>  #     Otherwise, old QEMU may quietly block writing to the channel.
>>  #
>> +#     Alternatively, use the @memfd migration transport to save
>> +#     VM/device state to an internal memfd inherited by new QEMU.
>> +#
> 
> Any guidance on when to use @memfd?

My objective is to avoid using disks, or running QEMU with writable storage.

Both guest I/O and networking can go through VFIO, and everything remains in memory.

When I was testing these CPR features, my favorite was cpr-exec because it does
not require creating an additional QEMU instance.

Based on my understanding, the best approach to live update a running binary is
to replace only the code section while keeping everything else in memory, i.e.
guest memory, device fds, and device state.

Unfortunately, device state cannot simply remain in memory across exec(), so we
need to migrate it from the old instance to the new instance. I was thinking:
why not use memory instead of storage?

Initially, I added the change only for cpr-exec. Later, I reworked the change to
make memfd a new migration transport. As a side benefit for me, I also practiced
how to add a new transport to the QEMU migration code :)

> 
>> +#     With @memfd, the new QEMU command may include '-incoming memfd:'
>> +#     to load the migration stream automatically, or '-incoming defer'
>> +#     to load it later with `migrate-incoming`.
>> +#
> 
> Isn't that the same for any transport?  I.e. old and new QEMU must use a
> common transport, and you configure it for the new one with -incoming
> right away, or later with migrate-incoming.

Yes, it is the same for all transports. I added the explanation only because the
memfd transport does not need additional data or a filename, for example, the
URI is just "memfd:".

Will remove it.

> 
>>  #     Memory-backend objects must have the share=on attribute, but
>>  #     memory-backend-epc is not supported.  The VM must be started
>>  #     with the '-machine aux-ram-share=on' option.
>> @@ -1309,10 +1318,14 @@
>>  #
>>  # @file: Direct the migration stream to a file.
>>  #
>> +# @memfd: Direct the migration stream to an internal memfd.  This
>> +#     transport is currently only valid with cpr-exec migration mode.
>> +#     (Since 11.2)
>> +#
>>  # Since: 8.2
>>  ##
>>  { 'enum': 'MigrationAddressType',
>> -  'data': [ 'socket', 'exec', 'rdma', 'file' ] }
>> +  'data': [ 'socket', 'exec', 'rdma', 'file', 'memfd' ] }
>>  
>>  ##
>>  # @FileMigrationArgs:
>> @@ -1337,6 +1350,14 @@
>>  { 'struct': 'MigrationExecCommand',
>>    'data': {'args': [ 'str' ] } }
>>  
>> +##
>> +# @MemfdMigrationArgs:
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'MemfdMigrationArgs',
>> +  'data': { } }
>> +
>>  ##
>>  # @MigrationAddress:
>>  #
>> @@ -1353,7 +1374,8 @@
>>      'socket': 'SocketAddress',
>>      'exec': 'MigrationExecCommand',
>>      'rdma': 'InetSocketAddress',
>> -    'file': 'FileMigrationArgs' } }
>> +    'file': 'FileMigrationArgs',
>> +    'memfd': 'MemfdMigrationArgs' } }
> 
> Simpler: omit branch @memfd, no need for struct MemfdMigrationArgs.

Just to keep the schema shape aligned with the other transports. Will remove it.

Thank you very much!

Dongli Zhang


