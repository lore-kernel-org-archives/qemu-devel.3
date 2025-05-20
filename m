Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A64C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNGg-0005m5-G0; Tue, 20 May 2025 09:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNGf-0005lm-CY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:44:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNGd-0002s7-9O
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:44:29 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDMn97013762;
 Tue, 20 May 2025 13:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cKxVbJIRt9HD/iqvx2Fw6zLNNt0j64bzJVC94yp+Pss=; b=
 ewrD/QgCjNFPkSTwOvys6jwb2QZn4mHG//H+LQpyaswznqzYnhc9wM1K0jZQLtBC
 cZeDMieSJLyFEWZd1PD1lDUrMpvUadDrJqY1adlDN0GK94w0o4ozcmlcoRJoxXTl
 YTZI/b8mQDoNQ8saZTvA0UxF2Fd+oAHMfJnJR2CTm6x2Gdv2gIFY8eV3Xv22beXo
 UCITFAZo3naG6YblVpd03Y/r+JEzZhCSJX54AGbboRK6XJMjDVIBNEwBT7Z4811A
 bv0ZvRDalQAoHv18qLDV3MrCb8M19Ld1WwypbLR5WKdEGmbRQMkLECaCLiNBbvuP
 J/Bm/z6/IQwjYO/7Vo76Hw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rtjb81v0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:44:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KCYEjR037192; Tue, 20 May 2025 13:44:22 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw8sajn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAThAs1k+t+I0DXYlF883ZWkJU8u5duDsIW+9BjuOzNHaiYV0RQKQE4meRuet3/WEKTjTF5UjWjKFiR2eH5LuoxVJuRpnhXIR3FPji9ujWMk9T3PGn/hVzVCi8k4umY6ndu6jmK8rle+dI8qhoON9ki9/+JwiZqgLTVOCkVJOJWduMESQuo9IcdY3wi0fIS/lmCfgNjJ4ZMeymKvv56irr20Mj0PyIAK4PaeemmUq61HXi8B0jiwfeJQOG0EkuieG7JUdK3T95Vvg+EMaBm8TvTCStog7Q5obfKFKWhuJGfO6qdWYU+x+jxyC2AS3FKFjn1aa1mNC9X+9ZUNuKxMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKxVbJIRt9HD/iqvx2Fw6zLNNt0j64bzJVC94yp+Pss=;
 b=fwWH/+1WnULyef7u0QeAInXv6wu0UNSvlZAtr7VFQGVKszax020P7BrH/tuhjCANh6OV6IUUH5P4PJAm+T6UIPREftrfatS1KOkefr6+QKVxkx2Qi++50l62qcpI7g4ZqTivylzpYdJIHWDmsMptv/Pspg61jCeoTDt7aReLJ2CKctTkfcDgKp8RNC8JDRVToJlpUVCHcaL6PKhMZ0OFrzPP/hykuEbv11FngnkjKVRykWe95td6o+FixE4EfDSAX+WeU5ZOSNORroqO4dvOY5iYHiP+IUTLxAfQDEU5p+KctH45dINRT5LBI9DaJVvc2Ssx6p//vL6nAwpHmqtAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKxVbJIRt9HD/iqvx2Fw6zLNNt0j64bzJVC94yp+Pss=;
 b=tvQnBMoY09PcmOYkmMdPeSGbsw8JYtSGftNYKxYLesVnk5CafV/brQ6tZKCu43wO+3GZ6FOGBJkhGLCGCXxOsR5m7ITHkFMknQHC+gKFYl4lbRsjDjntCIwelFkndK/4/Hrw6N6PSBZbxvocAWAeb5RgdSD9AEdzm5hMo7FkoTg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 20 May
 2025 13:44:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:44:20 +0000
Message-ID: <29cf42ef-ce82-443e-becc-7c8f7e80627f@oracle.com>
Date: Tue, 20 May 2025 09:44:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 15/42] vfio-pci: skip reset during cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-16-git-send-email-steven.sistare@oracle.com>
 <bf1d2c34-3995-49ad-a259-2c4f7380b2fc@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <bf1d2c34-3995-49ad-a259-2c4f7380b2fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d043a5-6233-4f40-7633-08dd97a46c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2NFNUc0NjlsZnB4NEg2MXBKVzR6Skpla0xsd214NVloMFB1S01zV0lnVUFo?=
 =?utf-8?B?ZjUza3VaUTVqRWpNdEkzbEJWUmJJR2x2cXBoMi9pazdHMlJDeDBNNkt6ZXRv?=
 =?utf-8?B?bjBubmFaMlhEZ0FyQUdsbHFGSG5VdENnZndOTFJyWkR5eVgyRjFQUFllZnlt?=
 =?utf-8?B?dGFESlRaQmtnbXhKUjBIYk1nT1g1RENJL3VmM2o4WUIrQTI5bU80aFF1bFJW?=
 =?utf-8?B?bldsU21uWGNSWGNRVkkxWjA5OGxVSDJWOGZjaGYxUDBWQ1BaTU5ubHdJTnFM?=
 =?utf-8?B?UTcrZnd3VUVWOFF0bEh0YXlSM1IzZjVzTFdrblY1R2ZpNUZFemRza3pKcmcr?=
 =?utf-8?B?Uzh0V2taWGpRMzdGZmlDUlJNR0Uwd2ladVFrdnZCL3JmVk50cGQycGUxZStZ?=
 =?utf-8?B?Zk5rV055UDFHdDB2aTAzUHEweHFFaGgxYnVWd296ZWRhUlhTWGlPc3FYS2N6?=
 =?utf-8?B?am9vcXpUZDdZZHlHUUZKTXI0L1ZTdzZuQktXcHluQS9LZ21TTEVPK01ubUdq?=
 =?utf-8?B?SU85QnFSdnhMdGp0Smtpd0c5WVo1SStncmI1bFF2VVZ3KzkzUk92Ylh2dEZa?=
 =?utf-8?B?SlJQVW9JNU9WejQvNU1qMjh0TWpsT1pUNXMxTVp3aHBVY3owcFgzWGg5UkRW?=
 =?utf-8?B?UUxjblkxY3Y1MVNUY2NjRGhlWWRveDhyM1hteVlPUVdzWjh3bVNWSi8xczAy?=
 =?utf-8?B?c3BwaldoUmNsVzUxM015S2ZZWWxnd1FVNFJMZGdqYkRqZTcwUUVmdi9JNzJa?=
 =?utf-8?B?YW9TRXVZaUk0ZnlsSFEySkIrV000TFJMS1Rxc1F2WXl2N2FTdHVxdEs4bkFL?=
 =?utf-8?B?SmY1L0l4dU4ramwxaGcvTjdxODA5MmZrUnVVSzliS0pWbXR2NDc1U2Q3Yzdz?=
 =?utf-8?B?REVzbXlMeEpsYjZ0S1F4L2ViaEZWcXQ5SEh5R084ajhNbFhpa0EyNEVjU0Uy?=
 =?utf-8?B?NSs3MzlGK1Vaam5wK3ptRFBkWTNodmJFd05WbUN3dk04WkliWlg2OHNyRHhM?=
 =?utf-8?B?M3NUOFZFYUE2L3Q3R2cvTGUrSTkwdkRXdFNveGw4SVhJSXdWK0RJYnRKVHoy?=
 =?utf-8?B?Q2FvTmdVNnR2SXI3cVc4YVVnWDhYeUFtZ05tV3VrWVVTTXluTEVvWk1Bc1hq?=
 =?utf-8?B?ejBhZHlPdFd5dUQ3RUp5WWp5dkpyTkwweFJqRFRtcmlpM05mbG53YjdCN1RS?=
 =?utf-8?B?M1l6VzZ6K1ZFWW9LUEc5WjE5a1hKQW1JK1BMcmF2b2hRekZwSjdZQmhNSVhK?=
 =?utf-8?B?cU1PNi9BTGVrNW50WGFPb3J3SmFVZTdna25HNHJmSkJtcG1takV6UWljZTEv?=
 =?utf-8?B?WE95Q2lSWkdYbGpJU2gyUTJHUGRUek5mVGtjUWpTOFByNGVFWWxHR1hONG1Y?=
 =?utf-8?B?Q0p6d3lZMi9lVlpYREdMK085QWNIZWdTa2JtTE5ZSkM3VjVBNk5mREtEQ1FF?=
 =?utf-8?B?d2o2bm1KSTRoa0NYNWhZTllPWDNBazNES3ZpdlBPNnNmZ0ZSd0FYb0Mva3V1?=
 =?utf-8?B?RVEwZXEwYzcycVBuQzFCV0hsaXp4UklSeHV1bmJEcVpyYzY0TUVBR01Qc2x1?=
 =?utf-8?B?K09SRDBzM0JkNWdySnhMOUFWMG0yYmJMeDZhTzBZU0dVMWNralVhQmpWcHl3?=
 =?utf-8?B?R0xSTUdFRngzVXRIWTBwSnRyTmpJUDZxSmF3VTRlVnVwc0U0Z2dZTzQxU3Zz?=
 =?utf-8?B?NkNoeEtTY1d0ZW1GaVZqazdPOEFZWjUwaVlkR1lGdGRJYkpaemY2clFVMEJY?=
 =?utf-8?B?SlVEWkZyY3pNQzlNQ3VIeUp2cWJFV2NyS3lDY09ZdlpUM0hJczRraG8yZUZ6?=
 =?utf-8?B?RkZtaFJ6c2V5UUNZOTZwa0p1VjA3bzhzcXVJQUU5UzNsWGp4NkZlK3lxanlH?=
 =?utf-8?B?Yk1Od0JlWElqOGJzYWo3VnJnWlNMR3BWQndFcTh5bUNEWlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BwTmRxNDg5L28rWjdsZmJGbGFCa2R6a3RMTFJUOHV4STgxL2pjU3YybDZw?=
 =?utf-8?B?TWt2S3JDL0pWZFh6M29mNzNOeDRiR3M2MHNUeStFazExZFpoTHNRMGZlcDNq?=
 =?utf-8?B?eVZJbzhWVkxLd0pqM05WbGc3enNBdXRFelBnTGhILzlNMDNMTzRmWjNwQW9G?=
 =?utf-8?B?QUJ3dnlzaVlBN2lIaGFUbURoQWdmU2tTUTZId2IxOHNFQlYvSDd4b0VieURZ?=
 =?utf-8?B?T2t5ZUMvUUlRNGxtSU1zdE9LakVKWlUxL2syb1J1ZkZvNjVqTi9HeldSMGVk?=
 =?utf-8?B?T3hGNG1kWllWeThjYnIrM1ExOUUvQmhHRC9FS3c5V3loV1JHVUI1MUM0S0pC?=
 =?utf-8?B?TFNQOEpYSDI4NGZkNWFPczhaMEpUd1dFcE1jVzJqRktScW1uYTN4eEZUQjRS?=
 =?utf-8?B?R01GUnRZaEJXZUhyNklWdWRvNi81dUo2SzhaMFhqNHJ5UEpKVFNXSXBoTXN3?=
 =?utf-8?B?NVQvc3BvcDIzcXMzZ0thSnI1SHpiSmRvdWZFSjNLMG0yNSs1V3hhOXN0VmQx?=
 =?utf-8?B?Z0xsOGdPY1E5NnEzSEZ6dmNwdHIyd2lIbUlaRGxxUXUwRzhLYkgwbTYxbXR4?=
 =?utf-8?B?K3hKano4NjFLdkdkd2ltb2wvUDlWYk9obXpqNVNpMUZ4aTJNWlhhbnJKQXV4?=
 =?utf-8?B?MmtKYk9VclF6OTBRdFc1VW50djQxTmlwS0s4eFp4ZUU4Qk42RHZkRXBHc1E3?=
 =?utf-8?B?M0lnK0lwL3BrR1IwR056UW5zWFJua1pNeWRpakx0SVdCczJESTA3aUpmSk8z?=
 =?utf-8?B?WXc0cElOWktlc2VsVUpVM0dFMEZVSCtMMUlycnFVTlBIanZmUzJxNHpXc0RH?=
 =?utf-8?B?MTV2a1UyS2ovWlNxWU1tQzlGUnNXenZRNWd0VlVNS2lwZEFqNHdEVzF4Y0F1?=
 =?utf-8?B?S3dHdHNaaE42bmx3eXJwWHIrdmlXUHRpKzcvTFlOeGc2THlocDR5WGF2YkRa?=
 =?utf-8?B?V3dRam9OK0JtaXNlWHR1REFxQTNpZ1h0VjJYeW4wMnJzOFNGbC9WYmdzZlVk?=
 =?utf-8?B?UlJtbnhyR1NReE05M0ZSZngycW1NOE05eEk1UUN3Q0VuNUhpdVFZa2p2SzN0?=
 =?utf-8?B?dHlNWGR5UW50Y1Z2R1AxdUIycVVHUGNLQ2NOYlR6Q3JuL1NJK2Z3SnhnWWhU?=
 =?utf-8?B?OTZ2UkZzS3VBVlpWY3VyRHlxSTJWUWpIbHljRWg1Y1BkaFhXQjRHY0xHQ1NS?=
 =?utf-8?B?d3JhSlRMSlFzNXNXS2JFZWZHamFuRlp3NTl4eWQxTWdkWlZ1cWxGdEk4OTJj?=
 =?utf-8?B?Rm5POFBjQ3RHdUczdEZJMEZsdUhqTkE1aTF1dTZGaTZSNG9Za2FvV2J1VHBs?=
 =?utf-8?B?blZGMDIwWExQbGVUVUgwU1RnN0QyY3JHZEFyeUpQOTRTQXpJc1J3QS9hVnZx?=
 =?utf-8?B?ZnFINTEyTmpjNU1MSXRMTG1NUllpUjFvUk1NOXBhb1pOOHoyMXZLQ2hOVVVi?=
 =?utf-8?B?dWlKT3ZFNVU2V213WEtHYXpPUVI2aTlEaGVqMkN4cW1UTFBPaUFDNDZsNGlL?=
 =?utf-8?B?R1hIcDZ3NWJ5WkptTFhoYUQrdFVtdjRWUU5GVStLZGllcEtUNnlDclZUMDdF?=
 =?utf-8?B?QjNISDJsVDBvdFlHczcxamN1bzk1V0FJSEUvcmVjbkJPZHR2THhCS1hZUjhU?=
 =?utf-8?B?NDdtbWJyWDRGSUpRL1dwRmwzbnpiSW9QRklnNkRlM3NNUVh0YTJLTHB4Nzh4?=
 =?utf-8?B?TEdSS1FKcXRvRmJ5LzdxSVBudDFtQkVkNjJGV21DWWYwWVFDT3gwUzFrRnhz?=
 =?utf-8?B?S0RCdUVXczJkYVBIV1VORktUdUprYVEzM1dGQmtmU0V1QncreTlkeEdvK1pK?=
 =?utf-8?B?Z3pnMStpMHN1ZWVRWk9sUVQ1c2ZVTlJyRzQ4SlRTVmpHRXNLaXJZb2xOV1RI?=
 =?utf-8?B?SnJNZnFGT1kzMk0vV0FCTE1HeXc0d1cxMWI1UHM4aHZuMzVWUUF5K2FEcVcy?=
 =?utf-8?B?aWJJMGdtaVNuMDZ6WFllRHM0K2NOQzcycmZ2UTFqOFNoYy9FV1dtR2VOTng3?=
 =?utf-8?B?SUxQdHQxc3BNT21VVnV5eUp1WmlaVHdhZUlWZnkxb25zS3JmdGtEWWp2ak9U?=
 =?utf-8?B?ZXVDbTFNK2dMeCtYR241Uk4zZ2FaYnJEVlZCMEtXUnlPS3AweWVydEFQRmdG?=
 =?utf-8?B?dW1odlNwZVRmcUNtUExsOGFic0U0N1BvVlNNSytFSGRJai9Kd0NESmhkUm01?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kD0VexPPspxeBUI0vHXUm96yRK94c/0NF2KPshpZRydqwWl2DyHHqTrgrOK5XdisT5kbejePY9GZr6b/cM/+xcIkCzEHd+pvde+p2ksdXn3VDv3avGbHhgUo2nk12zXMD8zpuhYLIsmPBwyJmqaJGEikgZEyfpnDFfiz7qKSczVOgud4t/Taw/3X6JuPzGJQsgG2ZQfdoNnGQpFMFhgVvYDad00OhMdOte06A2xgzkutkpMJanmcSsBmeam4pGpPkbA8s6eIgd9Lqu/avE6+KMpw0djdBF5ZKQxDsA9kOl2SskMrJUTxvLmWm6mATaUINAZEaHVhj79HyUhEIaFQCpcyY9F6wBDfqK95M7naxLao9X8VZQ5GNwe8oK4r+tH7TED0/7gNSUKZfnL108/rFHZwTDRb+pj2mz1H9GAE0riuIZ5SPS1mRu2C6E87OJIgOeLi+vCdZQZgg2J+1a5s7H/avg58e5ptz6mPVrXxVnhwCQ1ob3cIVLtRLuKrIeYlkzusngKKz8Tfy/g4zGvrv8rAs1021pkly2NgFQjAbnptZtq+aG5RxXgXmjDrLqXEl0GjrBi8JcC/IxjE6vYHHzD8DEqSvl1pnhpaSmhcmqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d043a5-6233-4f40-7633-08dd97a46c08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:44:20.1348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVJ/BiV+1F+vIHHx35HUM+2TP21fVOK7uskSZrbuD7+eXIIpiRhaZsrSoln3vJF8U3n/0tUTa6W3nytYnNp+BH1WngY8cTEwOm2iyM9v+WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200110
X-Proofpoint-GUID: V6vQHoAxJovTDTXzM3jCN1q40n5YDAym
X-Proofpoint-ORIG-GUID: V6vQHoAxJovTDTXzM3jCN1q40n5YDAym
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExMCBTYWx0ZWRfX3bhkUEdiqf6w
 j11XSbFtE2JPi4UVw4zen9VekOP5RRwBzcmPL8G7bV4SINj6iS1yAv8++pBZCwp6D2sd5oa/W6O
 FuAgdqBWrrR1b9LNUomxQBkKTcG2QXFC2JVhbdPJOKOstrnaOgJ4Usd7WLraKVeN+3u4OqS4nMz
 r+jtiCYO1zk5wL1At+3fEHCmrb7vcCkfsSBvwcetGd9FkrYP7EK70aRaoig+QM1FJ+OqiV0F7IC
 WRgb3lH798ykn13bq/uRpGAGj0Iiqey/CeZwbVNsn9MUaZ59uO3vvVCy+M5nNc8Uq0w3Ld+k/sJ
 4+qLLtzGttA0+RqQg6mJfzeB/B5pt9gW9orc0v3HsDExTCFofFFd4jIPN8GDn7hZQSngQAW89Jq
 YPL9V/EQ6nNLbY2PI6L7DY11yUMmaR1Dt+1mUfmLWJv+Y2DjzlrYj16kdYgVQwydCSnkSw9t
X-Authority-Analysis: v=2.4 cv=SqeQ6OO0 c=1 sm=1 tr=0 ts=682c8738 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=GB5ZVZ8ZrYlKT0li8YwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13189
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/2025 2:48 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> Do not reset a vfio-pci device during CPR, and do not complain if the
>> kernel's PCI config space changes for non-emulated bits between the
>> vmstate save and load, which can happen due to ongoing interrupt activity.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr.c              | 31 +++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c              |  6 ++++++
>>   include/hw/vfio/vfio-cpr.h |  2 ++
>>   3 files changed, 39 insertions(+)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 0e59612..6ea8e9f 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -8,6 +8,8 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/vfio-cpr.h"
>> +#include "hw/vfio/pci.h"
>> +#include "migration/cpr.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> @@ -37,3 +39,32 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>>   {
>>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>   }
>> +
>> +/*
>> + * The kernel may change non-emulated config bits.  Exclude them from the
>> + * changed-bits check in get_pci_config_device.
>> + */
>> +static int vfio_cpr_pci_pre_load(void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int size = MIN(pci_config_size(pdev), vdev->config_size);
>> +    int i;
>> +
>> +    for (i = 0; i < size; i++) {
>> +        pdev->cmask[i] &= vdev->emulated_config_bits[i];
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +const VMStateDescription vfio_cpr_pci_vmstate = {
>> +    .name = "vfio-cpr-pci",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .pre_load = vfio_cpr_pci_pre_load,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index a1bfdfe..4aa83b1 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3344,6 +3344,11 @@ static void vfio_pci_reset(DeviceState *dev)
>>   {
>>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
>> +    /* Do not reset the device during qemu_system_reset prior to cpr load */
>> +    if (vdev->vbasedev.cpr.reused) {
>> +        return;
>> +    }
>> +
> 
> hw/pci/pci.c does :
> 
>      if (cpr_is_incoming()) {
>          return;
>      }
> 
> So, to be consistent, I think VFIO should do the same.
>  

will do - steve

>>       trace_vfio_pci_reset(vdev->vbasedev.name);
>>       vfio_pci_pre_reset(vdev);
>> @@ -3513,6 +3518,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>>   #ifdef CONFIG_IOMMUFD
>>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>>   #endif
>> +    dc->vmsd = &vfio_cpr_pci_vmstate;
>>       dc->desc = "VFIO-based PCI device assignment";
>>       pdc->realize = vfio_realize;
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index d6d22f2..e93600f 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -49,4 +49,6 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>>   bool vfio_cpr_ram_discard_register_listener(
>>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>> +extern const VMStateDescription vfio_cpr_pci_vmstate;
>> +
>>   #endif /* HW_VFIO_VFIO_CPR_H */
> 


