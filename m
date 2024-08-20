Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7B0C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 16:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgRkB-00009e-9n; Tue, 20 Aug 2024 12:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sgRkA-0008TK-44
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:30:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sgRk6-0002W8-VH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:30:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KF6HkJ013436;
 Tue, 20 Aug 2024 16:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=gBujWqd2D442UZRn6K/ScH5RDavGzjX6IJSwm0IwqlE=; b=
 eTJ7GDqAYy4eUFgxkNEXWnZwrCcK+q18QIMC8RvDdB/+k2ks3eluLqCaAvlQ32Gd
 R3SW2dzFausCcdnAK/HUmSDCA3F0Ynb7dla3ccXwzvpPYsa+e+9PXl2QpQEFtnFS
 CW1+lr4BnyIYlZTKbWtCdOCLchRCdbyNDZWsK5FM0UCsbNNPlSZ+aYD4mH8tPaKa
 7Kq3cuTbmbVWBpqBbabvCsHyokxTsSf9IJwQrsO53aYIncDXim/ZRsUrva9L+WHM
 Egjlo0x8sagCXwtBhfZeKX+0x7C1pQ49wq7ARCPlZrDmOUq6Bji052OKnSV3RSG9
 h5LyLICYHVFCLPMzcT/1IQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hngua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2024 16:29:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47KFOKQZ028572; Tue, 20 Aug 2024 16:29:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 414wrqb23d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2024 16:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Akl+e/3RpNI33iOFZIkoO0NfM7OHBt8dS0ObXH3LQAAmkNqLCpCd2F4ht5wJ7oUnqJXqxTqXeoiSHyj9HXW2bAHxm8C3WI5LS8+cmuHRp38Zl/KqxOyhCxTVjErQ6Pv4CJSnC4oKEW34TKIBvTTYBpuq8LBR0QuM21FtWMHjAV3enrt7vHunYt4Qu8HLml1xLXVTA6Cag/ouh7tJXU/SPyNZFpuhR0avpgy/4qF0MQwRGzMDjSRRPzd5+zn0nmbOG2lCLL9Web3LAaqhVQiw80+ZTV5rfNzUBZBjc6/hSvzgwB5rDCMdcYrdZ3842CD05CSPSBRvCQ7N0Y6HibpGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBujWqd2D442UZRn6K/ScH5RDavGzjX6IJSwm0IwqlE=;
 b=UaLTJ6YtkhhfYEEv1/mCxo3ZvkdOvxxmdHdUbXaT898yb94tfsIuLXgjmHhMiiBAzVwmeTJMYuXifeDwAK3QOjLEDOx/axGsYaOhBZRzPYD2kiCEBozLTnPzzBfENIzmyjh1HZdM+N+vXlK+xiHFqskWfteh5bg0bQfVF0mKC9f01ubZ+Rdxl/S0YM96XHV0yPTn7UY1zK2Okv+0uc5sChg29wxHgNNrfJ6uRnnLYmp15QS/YMirl2tq5Lm1HRiPoEfYkBPgSWZ8a2er/NpEWucFeBRcqQEFV4Xngmm/aD0ppqhGHyszpFLMQAD0fV5+8ts3n9x0YuXZEzTCFUDHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBujWqd2D442UZRn6K/ScH5RDavGzjX6IJSwm0IwqlE=;
 b=mNY8n3ZiMa5VlFq1qGr0RIQAQ9PcBSjMhjjGQ+ZwEIOGJMU+549knJEJPANLMgnGAaeII0xceb5GqFcivzpdv2xeV9thX8Mi0rS9BRYptgN7Q6o+yV9GNlNGm4epqa7O5jjSzFuWmeCSpxm3QJppwZ18honYYOs0pfwX+ro/4aY=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 16:29:13 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 16:29:13 +0000
Message-ID: <6ee0a0b6-06e9-468d-b1a9-9dea834b641c@oracle.com>
Date: Tue, 20 Aug 2024 12:29:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n> <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n> <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n> <Zr9yGoXBpHIzrDak@redhat.com> <Zr93bOr1zrSZadf5@x1n>
 <dfc000d3-3728-4d1a-9558-943438abf2e6@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <dfc000d3-3728-4d1a-9558-943438abf2e6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcc170c-4465-4b90-cbed-08dcc1353a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzN6bzFvWjBIMmNkVnBiSkJLWUxrVFVvWWhGSHVFa3FuMU1GSnJqOEdLamtW?=
 =?utf-8?B?MTR4NHZjYTA0Q2twbDZzWlkxVHFVa3lLTkdtVUhPN0lzKzdVdnFFakZSamxQ?=
 =?utf-8?B?WUhnVXNvajBrUDN6M1NIa2lsbC9YcWtWbFZqc094dkcxSlE2VXZUVVVXWkUw?=
 =?utf-8?B?UnMyc3ZzSjFxQ0NQaWFGTTFNMU5XTmovdTVkQlA3aTJabjh2aEpiTU1mbzV0?=
 =?utf-8?B?SUI3V0xBbEZjNVAyd1dTbHlFWXRaZHlDeHlFeTBsN0w4YlQ0QVc0TW5uUWFG?=
 =?utf-8?B?VHNvaktlQWtVNnVINVVGK3ZQc0t2Zk56Ry9JNVk0UnJ3RDBVOXZDUlB5N2da?=
 =?utf-8?B?UmlKSXlHUWIrM1RBYUJtWGZtMU9Mcm5uRmtpdFMyUVFneEdDemR2VTZYUGhn?=
 =?utf-8?B?aUlObDR4Z2Jrd2FKdys4R2dEMkdtekZMdkZlSG5vTnFRcnNSWHIvUGw1em5B?=
 =?utf-8?B?SkpNS0w3ZmFnNHE4c0xjNTZEOTBDRml5eWR6N0tOSWx4UVZORHFJVGZxUHdX?=
 =?utf-8?B?QTM5cVZuR1VObGJad1VYVXFLZ3NwRHBQOUhkcnN4Q3Rucmk2NFh3QjRXMVdy?=
 =?utf-8?B?bXFjZmN5YmZCZzV6SFUwN3ZhNjlnZTk4aEU2ZTBCTUFQcWNodTBDT3ZURnI2?=
 =?utf-8?B?bFdaQ3NZMjJ2Qlg2YXFmYncwSTd5VW9DRkt0MHlLNlp6aW9BTlFCZnJjZlc5?=
 =?utf-8?B?amxxUC9XQlRGQlNPejFKaWplSHovSnFJQjVkM2VEQmRYQi9INVRBcC9FbUVR?=
 =?utf-8?B?bUFyeTZEMExWRHNnMVdFRldqT0xzcENUTUx4OHhyRW1VNzNidGthMmlPYjFI?=
 =?utf-8?B?OGMyOFRlL1E5RDQ4R0VCL1YvblhlV1VpVEdybGozRG9rM1p3QlAwamNZSFFC?=
 =?utf-8?B?YjZUVTFxWjVCVHhocjhJN2ljOUVoUngrR1R5ekFvYWp4T2phODE0WE0wZ1ZZ?=
 =?utf-8?B?eHgzSmlkaFgzMWhRK1RWU2QvUGdLcEJWcGZ4WjlQclVIdi9GMVdQRlRxRjEy?=
 =?utf-8?B?U0EyUGk5WHVRMlpjN0ZyRTd4K0E5R1NBT0NWM3JKSHQ4ZlF6UVZjWTBrUnVy?=
 =?utf-8?B?N0MyY005SnV4d29HZVo2WGl1Q09adDV0WmtaSE52U1FidVlrR1RqWE5UQ3ZM?=
 =?utf-8?B?aGlYSDY5TlBPckpka3IyV05GbzJuc0tMVU45UDVBZ0xwbGM5WWFIekJLTzBr?=
 =?utf-8?B?QzBkNkNOOWZhcnZPMWZCM0JUVEVlbEVUV2NKeHltNitjUzV3RDI4U1l5Q0gz?=
 =?utf-8?B?VDc2N1ZMR3FGOGZqU3RXcVlNM2RTcmhzdVFQTHFXQjdyKzUxaTAzeHdPNkx2?=
 =?utf-8?B?UlpjbkZ0RzZPS0ljN3hob3ludHB5d1NldklibWRNWDVLTUxWVmJ3a2tCSU02?=
 =?utf-8?B?WGRTbzU2VkdyQ0Vyd2piZ3NHN2FaSmNBYy9CRFFtVjA1YUo0OG11ZEVBTzRY?=
 =?utf-8?B?cXlrMDcrVFdJTGcrQTdzc05Da0VsM3JoK0svYWdhSjg2UXRkd1FraCtnQTdi?=
 =?utf-8?B?TE1vUmZIb0p5TWo3S1g5MWZLQmlNektSS1JDRFdia1czZDBtQlJvb3JYWnJ5?=
 =?utf-8?B?QzRVQ1pETVROK2dLWG51OXYxNUQ3VlRVNUdJMmpUMGJ0MnU4SFA0VnIxNDFo?=
 =?utf-8?B?a29JcHNwVVF0dmZmdDdZT2JnUGVjTEpNWFYxUWo1NFM1OGVCcjFISmYra0JX?=
 =?utf-8?B?MEROc01uV1ZwT21uVy9hZDJXSkFKV1o4OXprL3l3U1dDWHNGOTdjZW04RFpJ?=
 =?utf-8?B?Tks5S2UyLzJpdElrZXZYaDYwa1p4blVNUDZYYlZuSGVzZzA2TCt2T0Rxa0la?=
 =?utf-8?B?cy9vZ3JNSmZUeXh3Q0VCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkovQ3V2cDRHTlBDZHU3VG9ocHhCczE1NVk1NFNyMElUVXpXcEhTZzhKa2t2?=
 =?utf-8?B?cERWSWw3Ni9uZC9DSlhraHNNNmZNMnpnbUtGY1RIVVFIVUI2cDh6aXZPT2R3?=
 =?utf-8?B?TEpRYzg5eStpOWdKU2pQZnBOSEY1engvQitYYW0wQnViaGNGQW16enJKdEJI?=
 =?utf-8?B?SGFibFFsWUszdDBMVUtNRU01Um1uN1pIcnBxdDEzUU81Z0N2N3RWOUszYXpz?=
 =?utf-8?B?cUVXZkhyVGVYaU9pQjBrUzRyQnVWT2hNcEF2QUJBeGpKZHJmOGNZWnhEMW54?=
 =?utf-8?B?cU1tcWoyTkJxUTFneGlTamFqdEhKZFZLZ2tXVnc1OW8vd243MDlBaVkwVllM?=
 =?utf-8?B?ZWdiYmtDUlhzblJhWGJDeWwyVDg1NzkvUHoyQnRBaE4rdnpFN3RMaVROZjQv?=
 =?utf-8?B?VzdSdjRqa1pDY0VZVlhNWjdUTUZaSTBQTVFPSS9PcTA0VG4rYVpudXk5MU9n?=
 =?utf-8?B?M1puR2hveEpiR0MxYkUyQU1EeVMzVWkvYXYyWnZKRUpTRmpmMjRvbldFOHo4?=
 =?utf-8?B?eFNvcnAyTVRUQTNIdXVzZ3JodStYbjJmOVVHN1J3aXZkMzZtQXpPT1FGb1gr?=
 =?utf-8?B?QmhpcHA3NG5TeFJ3NmNQUTRFQWRZZGlnZ1dwZFJQSlFLUU5YVmxocFJiaGxw?=
 =?utf-8?B?R0pBYnhaNU5zTGhPWFpXenZUMmJETGJoLzR0ZTlvVW5XZEhBZE5SOUkrUzlk?=
 =?utf-8?B?ZFk2T3RFOEZndGU0bnlqeVlRR3NVVkUyb25hZTNFaEdsV3J3Zm81QlBlZDFW?=
 =?utf-8?B?VjhqQS80QkpvN0FESGpvdlNTNkxaeG50YmxYV3c4ZXIwUEpIUzVQVlhCV01R?=
 =?utf-8?B?a1BSaHUyeVlTdkxHcFJlVUhqYVNmcVNLam9jaTJWY2FrckxGSm1HR3E1YlB4?=
 =?utf-8?B?Qkl1SVY0SmYzWEdNbGswdEJGeTkySFc2a0hOZ0hqcklzenhPR2lsaVA0OHdE?=
 =?utf-8?B?d0dMU0xLKzYzSDdiR0llWnBicmhYWU9hQ2NZbEVqQTVqSUJUVkZ4b3ovSGoy?=
 =?utf-8?B?SHhHQ2lrOCttdy9OQjhGUDdxc2RiZGZsdzUyL0dOejlrZHRLaVpjR2ZOekFh?=
 =?utf-8?B?Ymh2dFkvWnMvL0E4d0JzQmJUendqZ2hYdkxsLzh1Tjh4eXE0aWtqdHJDbUpq?=
 =?utf-8?B?RjRWZUFMYkRXUlpibGMycHo1M0dYWjJWUzBBbWZKUkNHdUxQZ2M1dXR5c2pK?=
 =?utf-8?B?eTBFbVQzK3dDOVdIL0NUOWJ3WHdmNjFMcng1UEh6aTVUb3ZQVU9jb2dWUGlF?=
 =?utf-8?B?U3A0aFpaSFVzOCt6dlEwbjhrdUR5TW04MUJGdG5uYlNnbUdVQlU5NmgzQVhj?=
 =?utf-8?B?czY2Vm0xWWtGYUFGOTBQZUdOUVU3VFplSTVmQ2lDb1pFRFB2YVI1eVRLY3o4?=
 =?utf-8?B?SkNaUndIL1FEWTRZWnlnTjQ1Rjl6dVNONnJUbTZJWjluaitLWXplcU43UjdK?=
 =?utf-8?B?dGx5U3U4UUc0OXlKaHJSNmxqYURVRHprL2F4SHFEbFJUVldld0hpcExwOXlh?=
 =?utf-8?B?UkdwSktXWXA5U0ZhMjdiU0ZLTkxCVVZGVmgyaWRGWVpJcWJNczB5cWJPWVpl?=
 =?utf-8?B?WVJaL2F2L2NMYWRJeTRqSUZaRGNIcGtWS1BiTXJYeDJUODlveE1vang0d0Qv?=
 =?utf-8?B?S0NGY3BFaTVnT25yd0NMY3lKcG8rZmF4bGFhbjJjMEV0aWZGK3gvY3dnQllQ?=
 =?utf-8?B?cXNzWWF4bGk4eDFabGZCZE1Eemwrd29iaHdxbDNvdWZwczcyd0dCcE15ZGFN?=
 =?utf-8?B?eXkwcThYMExpSDRJU3ZEUjA0UU4rbW56VVcyR2xHNitLSEo5L2NHeU44K2pq?=
 =?utf-8?B?Wm9UY0dicjFYd0wzWFlQcTZLdmZZUVRRRnhNUzhpTFJRbjZuOHk0QTNVczZ4?=
 =?utf-8?B?bld0bUVrY1RJeVJ2aHRPNzFISlFDZ2JGT25FK0JnUlVlcjR0cG9Wb3RvNkhI?=
 =?utf-8?B?ZngvREQ4NEJ6dmFXWnVYWllBRlNqekJyZ2U5dlVSWlduM3lVaUZmZEJRZFNR?=
 =?utf-8?B?RGlteEpJckFac3dmZDJzd0VZaTduN1h4dVc1Ty9hTUk5ajlqQVFWcEsxdG1R?=
 =?utf-8?B?VlZ5U1AyaUVTckdBajBMeStHMHoyUkZIT3ZJdmxpZnNQcElhMGV4REFMQjlS?=
 =?utf-8?B?dlBMbjFlOXR3VzBYSU11YTNqSEVUWFBUaWp2Z2RBUUhZUndCTDNyVCtQVW5y?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZHYyGaujfJi+XXG0bysVUJ4Jw+43EL1mtgXYyvlqcp1TpgfZ3R9QGoAgaSSL3Q0tH5PeptvyXxSHuM7QwLZw7d5/WOyEXu2UqKvYzL5lIgpY32I3KD3gmwrgF8worFnnI+xrGdi3EOKmG4ub80slzGDfE74y+HoESC7+kf6b5ZWnj7Abzi6KMIMjSfa1XsmDpU4oDE9bYo58IOfWNJ50KY3+hl0i9sd3MxWZfJv6t3+8gLT91NSme+PKi1Dat5GZT2grD/YTEDXZbPkbnJOxE1oHIxJMp4Oz2GlyJWZrKaksd9QKfyRZxIaEtlXmvJJzi+FR/FKs0V56F4tQRPV6WVY47VBWZXiqf9bKEqlsUR34Lvgb27f68gwTArWSVM0TNh/sOYIGkMiiBx1wBLSVHPzDydRIYPipZA+Sg0h7YBz/woLLzwt3BFQBUFK2FNvIDIjw1OFNtpGaFBqKcC/YcnNbxha/7/Owa4TCCUjSOM+H+hyt6R+hAAiFnjURTWTOCPSQYELABTysvOAU04jgm4XO8bvXRGHuGsKwrBJmeqNApnQYQiFlAUeTztxnofLKski3tmaMeFNw1JeDY2PyffGSiB6K7hFz/7dMjogF2N0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcc170c-4465-4b90-cbed-08dcc1353a1b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 16:29:13.7052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w40DHAOscA+MFoJ8O88oYdFlUAKeFOw6iO1PUbyM7i7Hl5EeG5rUaH0dPbQJnON9x0Y9g97CktEzxNE2yrpq28/hUHHFpCFA65mFrkB4YQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200123
X-Proofpoint-ORIG-GUID: oyztlDCUNFpPomETjrCN9UKEJ051_bJT
X-Proofpoint-GUID: oyztlDCUNFpPomETjrCN9UKEJ051_bJT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 2:34 PM, Steven Sistare wrote:
> On 8/16/2024 11:59 AM, Peter Xu wrote:
>> On Fri, Aug 16, 2024 at 04:36:58PM +0100, Daniel P. Berrangé wrote:
>>> On Fri, Aug 16, 2024 at 11:23:01AM -0400, Peter Xu wrote:
>>>> On Fri, Aug 16, 2024 at 11:13:36AM -0400, Steven Sistare wrote:
>>>>> On 8/15/2024 4:28 PM, Peter Xu wrote:
>>>>>> On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
>>>>>>>>> The new user-visible interfaces are:
>>>>>>>>>      * cpr-transfer (MigMode migration parameter)
>>>>>>>>>      * cpr-uri (migration parameter)
>>>>>>>>
>>>>>>>> I wonder whether this parameter can be avoided already, maybe we can let
>>>>>>>> cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
>>>>>>>> in the same channel?
>>>>>>>
>>>>>>> You saw the answer in another thread, but I repeat it here for others benefit:
>>>>>>>
>>>>>>>     "CPR state cannot be sent over the normal migration channel, because devices
>>>>>>>      and backends are created prior to reading the channel, so this mode sends
>>>>>>>      CPR state over a second migration channel that is not visible to the user.
>>>>>>>      New QEMU reads the second channel prior to creating devices or backends."
>>>>>>
>>>>>> Today when looking again, I wonder about the other way round: can we make
>>>>>> the new parameter called "-incoming-cpr", working exactly the same as
>>>>>> "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
>>>>>> be reused for migration incoming ports?
>>>>>>
>>>>>> After all, cpr needs to happen already with unix sockets.  Having separate
>>>>>> cmdline options grants user to make the other one to be non-unix, but that
>>>>>> doesn't seem to buy us anything.. then it seems easier to always reuse it,
>>>>>> and restrict cpr-transfer to only work with unix sockets for incoming too?
>>>>>
>>>>> This idea also occurred to me, but I dislike the loss of flexibility for
>>>>> the incoming socket type.  The exec URI in particular can do anything, and
>>>>> we would be eliminating it.
>>>>
>>>> Ah, I would be guessing that if Juan is still around then exec URI should
>>>> already been marked deprecated and prone to removal soon.. while I tend to
>>>> agree that exec does introduce some complexity meanwhile iiuc nobody uses
>>>> that in production systems.
>>>>
>>>> What's the exec use case you're picturing?  Would that mostly for debugging
>>>> purpose, and would that be easily replaceable with another tunnelling like
>>>> "ncat" or so?
>>>
>>> Conceptually "exec:" is a nice thing, but from a practical POV it
>>> introduces difficulties for QEMU. QEMU doesn't know if the exec'd
>>> command will provide a unidirectional channel or bidirectional
>>> channel, so has to assume the worst - unidirectional. It also can't
>>> know if it is safe to run the exec multiple times, or is only valid
>>> to run it once - so afgai nhas to assume once only.
>>>
>>> We could fix those by adding further flags in the migration address
>>> to indicate if its bi-directional & multi-channel safe.
>>>
>>> Technically "exec" is obsolete given "fd", but then that applies to
>>> literally all protocols. Implementing them in QEMU is a more user
>>> friendly thing.
>>>
>>> Exec was more compelling when QEMU's other protocols were less
>>> mature, lacking TLS for example, but I still find it interesting
>>> as a facility.
>>
>> Right, it's an interesting idea on its own.  It's just that when QEMU grows
>> into not only a tool anymore it adds burden on top as you discussed, in
>> which case we consider dropping things as wins (and we already started
>> doing so at least in migration, but iiuc it's not limited to migration).
>>
>> Again, it looks reasonable to drop because I think it's too easy to tool-up
>> the same "exec:" function with ncat or similar things.  E.g. kubevirt does
>> TLS even today without qemu's TLS, and AFAIU that's based on unix sockets
>> not exec, and it tunnels to the daemon for TLS encryption (which is prone
>> of removal, though).  So even that is not leveraged as we thought.
> 
> Also, the "fd" URI would not work.  We could not read from it once for cpr state,
> reopen it, and read again for migration state.
> 
> Nor multifd.

Am I wrong?

I still go back to my original statement: -incoming-cpr  has equal or greater
"specification complexity" than -cpr-uri.  It is not simpler, and comes with
restrictions.

- Steve

