Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C96C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 17:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaUs-0001xb-8C; Fri, 06 Jun 2025 13:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNaUq-0001xM-T0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:04:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNaUo-0005R8-CS
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:04:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556GjSIv030076;
 Fri, 6 Jun 2025 17:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fL1igFaDCD8hRML8zctiHQSbEi6xyzIwZJKKiSfzAzo=; b=
 atZZhkRVYed5RN5aptldA9TDskV/TVTxoRXrUTEqKOTb4uHl4K0A0eEvovQgSqsG
 /jsGquA+PZu/ghNpEMybWFePOs/TnVos+06HwXzM/UJRwOUHNRtos9kx3ZXzH2y9
 4eCALqNjd0JNLhzaYV0nHKEmy4hIB3GDemsJaQPxfC0piubjHnJrNEzfPK7Fa2ui
 dLOf1mRnVL2PT9atVhbExS5qAeUAMmfXWxkYt1i5WRI0kPeJPlP6IJcVbzVV4V8M
 4Z4IG8KZm2c+Ytboa4xisMDWSMGH/QcOgWvjEO5vH4mB3mnUmw8oJSIGGcmMnJn0
 3Bo+IPIgMANCarZbVJK+oA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8e0djy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 17:04:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 556FYIMr030803; Fri, 6 Jun 2025 17:04:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7dgj9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 17:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHRL96y3OUDosUnjiuhn+d/u0AMTp8K5VzXfvfvrUsbiTOgkurlBKLsdClq4aTCsG1mYg349VeDIkfDwXMbMbNcRkeSEKM+Id8C3jc9Z0jz6h7s/vYcHB9b8OhIDBFDQOAUvFADNMg97mWhl3/HZGO2cCoWRz+KC3xbhXoRps+IvEIWQOUMCyAc0MrWz5io3kBzMUxfyFxNDduXu0BW1Gwwl1HIO1kJab6yA3vAsF67XjJF8eAMYWY27HDyY3f+UwF2/CB6C2ZMf8aVR3+TcHcfhttXEeQ0yGRRzYgaKeQGOPnAngpOM7f4FSLkF+wNQoJ9ALFQwbJYzPifwzLXZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL1igFaDCD8hRML8zctiHQSbEi6xyzIwZJKKiSfzAzo=;
 b=GN6jTdBQ1JFxee1674rU/9488LCIlVWtvK40tYjB7LS4LOCEZpOm18+fdd6H0AlfiF1DXHhgQoW/qZY+ZLYS0+f7k6GCDjinJpFIRwfToT3SBncJS+Jzxq6Okg+GOb8R1kDj7JuiEF5J34sIZT01fpFXvKGljQQ+tOdm39Ip32bgO0CSxBZY+WXNgw1qFqCai+i2hWI3G4uA7b2Fn2vk2ixrGh2bmM9huYxEzDHJj1KmRUJsmAj+P195mRJQxGvRFaSft4YbdxKArQG2o0WewfHDhHo0lHHZqHumYRKbvbsGUevWvGRSLz+sjCmvoxzPP94sCFq5g3a758CEXbCXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL1igFaDCD8hRML8zctiHQSbEi6xyzIwZJKKiSfzAzo=;
 b=J2Gs8oWSCjwHGwWRZxYAZ/MAr/pQBjdEsZakYldSUXb5GQXcGB/pdbHqPm7ju0UPDUBXMT4ZfpikRED+emNlHJOmTqV44U+6vluD2YaPQlNLduvuSYQMvhnwPjockZE4WJMOkEIerV3OX4qVC4bc/CXLKVtbEY0smKieDAVStAk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB8155.namprd10.prod.outlook.com (2603:10b6:408:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Fri, 6 Jun
 2025 17:04:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 17:04:39 +0000
Message-ID: <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
Date: Fri, 6 Jun 2025 13:04:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: JAEHOON KIM <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aEMR6Xjs8tRJ8_sp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:408:e5::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ea10cf-9f16-4b96-103b-08dda51c38ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1ovODJ3a0twVGs0TUlPUHRadVdrM1NzTkJ0a3B2Ykp0d2g3NjhWUGQ5QUJi?=
 =?utf-8?B?eUhPZXhYUWxzWERqNXVsMm5WVzBMd2tGVFpFRjhUS0N1T3E2RURBcE1sZ0x1?=
 =?utf-8?B?R3VWdk94MStjSVlKUDJHUVJmOG4wVUtJTUpRS01LRDd2d25PdDlqd0cxbE9q?=
 =?utf-8?B?RWdCcTQwRm85UDRmNHNZYkMyR1B2T3ZEazNWR0JCTzd0SldrQ0U2ejNobXBk?=
 =?utf-8?B?Zjd0bjBNcmNvVjE5d28yMXdBdURRZm93V3FUOTJhaVRXeVNJZnhBSU1hYm5F?=
 =?utf-8?B?bmZacDY1UXJJeUxXNThwd2R2RElieG4yLzdlZWVHZGFhU1VNS1JwaVJ1Yy9v?=
 =?utf-8?B?RTJ0UWVEa1lISTBDQUZxVE13ZzBheFZydnNNbThQWTk3THFpTlpBeGZhRGVm?=
 =?utf-8?B?bElGeWVnZmd0SU9SYlFjb2dBeHI0aXlva1VIL05VZEJFNWtsRWxpaGVQVFRL?=
 =?utf-8?B?b0xqYytSYkVpa3Q4eGduWXZtR3lXMUttM1EyRm5jc2lnbjV5cW94d2VEYzR2?=
 =?utf-8?B?cWo1a0tXekJtR05VN2RSVjcwZnAzc0hIRmlrajF2eEpDaFdBNjh5Tms2UVNu?=
 =?utf-8?B?bmpwQ1hHdlRxUlVRaUJpS1lBaUQwRUo4ZVpESGVKL3pRazBsOFIyekE3Uk1S?=
 =?utf-8?B?bnQyODhvaHI2a0VWcThQYW5YQVFRL0EvelRIdmVXUjFYWGkyZU90ek9MZFU4?=
 =?utf-8?B?TG5NTXpuUUsrZ2FGSXFDTU42YXZueVlNeXBZVDhJR2E1anJUUFBtald4MCtK?=
 =?utf-8?B?bU9Ebmgxd3FzRzJhWVVDb2FNRktHWHpqSlFtbGpaNGpUaXRJNWd6QjNnTTFk?=
 =?utf-8?B?bTJCaFlBVEFsdjBobitpeWdET0VDV3JMNExuU0kyN3hNdGpVdUtLOCtGSUkw?=
 =?utf-8?B?TWJybzQ5VjA3K2VESEcrcytUbTZjSDBqbjR1SVpPUnJwN1cybVlEOEh4NWlL?=
 =?utf-8?B?bjBmRmdlbE1QZWFlMVhyMnkzTlVNMWx4eG1iaUhKbjVpVE1JNXpuWmpCS3hz?=
 =?utf-8?B?K2Izbnc5Rm9ITjJXR0JkVzFjb0NoNVRnKzJHYzR6bElkcHNkNjBJRThacHdR?=
 =?utf-8?B?TC8vN3NVakZDQlVnVWdWRVdPUDkxYS9sRG1oZ1dWOGZtRk1xQlZST2VVVkJU?=
 =?utf-8?B?WHRQM0dzQjMyNURna1hGUWtMRkl5RUpRZEp4WnFkaU81dkFOOVMrOXNaNDI4?=
 =?utf-8?B?dkFLbTJqc2IxaS9JSndQVzFJZ2R0TnNxM3k1bjNwVExXNDRLdnRqNU9kM25Q?=
 =?utf-8?B?enV0TXlkbVdSSHZHaHFEZmpnZ3JxMkpsQ3hiTDFIL2VGL0FNRHdGajJSMDZF?=
 =?utf-8?B?azluemZVRytsRDMvbTJZM1J3aEJncVBZSkh4T0c2ajltR0dLTVpUeFZlK0dE?=
 =?utf-8?B?K05uU2NINVFpNjBpWDZkZHNjSlJxWnZNUjdHNFpyNkVEdTI2aEJJWHB4MkRW?=
 =?utf-8?B?K0dsNGtCbHdINlVxdThRNHV1ZXBkWXNhTE00cnZHMHZIb2hZZE15cHpuNWtN?=
 =?utf-8?B?Z0NTV3o0cTA3WXB5VDcwV0ErcUxEekpkMGtDZmhBVlJuY1E5K21HSkY0VWFG?=
 =?utf-8?B?M3F1aWVIS0dBSlVOdjdJUkNmSHd2Q3pCdEY5NkpmMXRKN0p0ZWkwa09xSnEy?=
 =?utf-8?B?WGpmc1ROT1REb29vZlgwY21oS1AwR0E5RlpEeVpyU2xJYlVRWVg4NnFzaU01?=
 =?utf-8?B?WkxwdkxWQ01rVGk3Q2pxYjlxS1pvcnRKS296cFVxcUV3L2RIZ3FKcVpIVzNQ?=
 =?utf-8?B?VjcxL3Y2OGlhazlTN2VLSUhmalVua0JZMGF3SGxVYTYrTXVvNzBIWks5bmlD?=
 =?utf-8?B?WFg3ZW5zL1RxR2NyNFQweTJWUGhpY2RYem9KTDl4SjZWWUhXTEtHcnd5Y1N5?=
 =?utf-8?B?TTljbXVuWjU5bS83SVJyWEhvTVVRSSt6SUhMVWE2dUs4MDVMbkpWNUxNRE15?=
 =?utf-8?Q?1CRSn5/BxlM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW1rbmVXK3UrSkNZRXdmbUl6dG5Ub2ZEeVJHTlZlQkppUUtNQngzcUozTE1h?=
 =?utf-8?B?NkNHcFExZ08wSzZXRlJSaG5vdld4MTljV1llUnhITXkwN2ViZXRCeVp6NkhB?=
 =?utf-8?B?SUJ1ampORkNIVXlSVEFKTXhqNC9LT2ZrenZPd0RlK2xRTDFBaS9sbjFWKzB5?=
 =?utf-8?B?ODR1UzNPWWlwRUJOME9YTTk5RDhTK21IdEl2Vk4xN28ySmo2QmNlTmk0T1VE?=
 =?utf-8?B?MCsrT1EvOWVnRkJSRng0bHNKUDRGZHJvTkpKejUvLytPSXBIZWlQanVneHVk?=
 =?utf-8?B?N216YklxbkhlM29KTzlDazRsZFVzOUhqaExWMVBLT2VXU0I2eVlvQWlXR2Vs?=
 =?utf-8?B?TklrRDk1OXM0V3V6Zzh6Vzhxc2w5d0p1VDBMUnhKSFMwK0tEM3FIK1NuNzll?=
 =?utf-8?B?MnNWMkZ5WmZ0TUQ2L3hqVWdRdWdadEpZZ2tkN05BWk9iYytGaC9reDF5UHlD?=
 =?utf-8?B?NlJYZnRWeXlrY0xWNStRaTFrRTBaZ3RYOHU5UmxzeDExRHlUTGpkUDk5WG1h?=
 =?utf-8?B?dFdjQTBzajlrbWRhWUwvODhzT1U4K3lNdG8yaVhNVm5nV2pIZFhPOGJtNHZR?=
 =?utf-8?B?VDh1TUR0UUpDdlErTnYxY1A1SVE4Z2FEOVNLTjRRREFWOXcvVGFwYmpLS2ZU?=
 =?utf-8?B?K1BrTlU5VWlndmo3SkxYU1ZiS1dTQlBOSzU5eXhFajVNQU41WWkrZTlmdVBy?=
 =?utf-8?B?V29HMmVlOVF5NElSbGFVYVdlVE56RHFNNy9OcXpHSDRMMm9hSm9NelpKaExC?=
 =?utf-8?B?QWpVTDYxeTNrNHZaenFXTzNPUENRYWhhQnFmU1BnbTdpRXo1K1Y3RzQxMTEw?=
 =?utf-8?B?SUhTQUFDNjJOakxScHNaaWsybUdQNll4aGNwcko4ZkRpeTZtMDlYcWhHVmsz?=
 =?utf-8?B?NFY3M0JPYnROMjhhS1hQcHFWTXhZSGtlTldaa0JwTkV5dDllV29IUkpaWHhk?=
 =?utf-8?B?RlhDZm5xOFhvUkt3dDZSZC9OVTNkeGRNMlZBbFBnb0ZTTGNWQVp5V1BScTQ2?=
 =?utf-8?B?V1I2RzI1UUR3dmptUmh2aVA4b1JoZisyNjREeHhnWWdKRXY1c0J1WU9QRzVp?=
 =?utf-8?B?ekVBODlnelV4akpnY2ZNdEZoL0tSNGhocmlYNkJJb2lSZ0RWY2hZaHBMUjdW?=
 =?utf-8?B?UlJmVnZiS3lEWFFPemZEcHFqWTNIR000VmlnS2hZRjJCUFhjRm52aHRkZ0JJ?=
 =?utf-8?B?WkpGdHQ3Tmh2SGcyaExEL0VlUEVINEZaamxTUCtvUWwrVXhLT2hrdHprc1RZ?=
 =?utf-8?B?dTgvZDh3VXA4bVZMMzJvQmlCNXpHbGpjNEEybE11emJYd2FPOVdnRlkyUTV6?=
 =?utf-8?B?YVlWZ1FTR0ZwcmZZMGdSaU84RnFWNjVYeC90UUV6WUp5ZVlzSm5NcDYreDVp?=
 =?utf-8?B?cWtFanl6RzJ0bjNZa2FaL1QvbXBGSlhuYlRoVUdReTZlWTBXS1ZyTndTVmdV?=
 =?utf-8?B?d3kxZHdIOFRlajRQZ0VOZXRhY2ZreFNlUmRqaGlnYTM1Zjcxd2d4U2srVkl5?=
 =?utf-8?B?enlCSXArWE9JYjFxVnlsdVk2ZStENmhWblhZRkNOb0VwVjBNQk5yVEFqS2tL?=
 =?utf-8?B?b2N4eWVZb2VHWXd1R3FmRnpFZHVqRVNpYVRzTjdBTHVVVVdlUXVMVDBXc09V?=
 =?utf-8?B?MlJFSlNaQ09KaUtkOHorcHF1T003SE5WRFFCbTVvNEhjWDFoaWtZanllUmNw?=
 =?utf-8?B?bHBHT3pZbFdmbWV3dnJ5OERPaExLNFZlR0I5dmE1MWlYam51cjhmVkkzVm5q?=
 =?utf-8?B?b3FMby9GRnZub3JIdXJlcDdXT2diek1DNGU0Z1o5T1F4OVNJVTl4K1psQ0wx?=
 =?utf-8?B?TlBuQmtkeDB3Z1BsMjVka1JKd0VvOEFDRmNiQWQ5cEdCMkdycDcwaCtja09M?=
 =?utf-8?B?Tmp1NU5raXZ3Tk1ZOUlHTEpQbDc2NEphcnpCSnFRNkNQQ3hCZTFuWnpNcVpw?=
 =?utf-8?B?WXUwZi8yTHVJempnSWtnSmo3VFN2aWxyUjlmalMvYk9tUlhmN2ZYaDMwdGxI?=
 =?utf-8?B?bU85WCtkb2x2dGo3dWl5VlNib1pyOTExclVJT1crSSs0bFVWV0c2UFVDcTRC?=
 =?utf-8?B?YWRzc01FaGxjMUVYa3ZzalBia3daT0lGYk05Tkdtb0NyQU9xcHNDNU91VXFi?=
 =?utf-8?B?ZlJ0OURhLzhidEt3dmJjK3JXRU5EQlowa0grUlZrdklBMVNiWUJNODBKYmxM?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RvbE935iR+L9NdrJ9BTFC0iJbbTimYgt0FYlGELWBZjWVB74rJhMD+BO//I1QoRdvexUzipjhZhbdSe4S7oaFvM/SBoHpfOMnRlJHo8G5VLKTGRwM4y1HzfFfpTeaIFtdpbbf0L/DZD+zQAImdjl7bRAVq+WKPRqSL0jC+UhVKNhmf92bDuRTAXw6iSW8J8Lu3Q8K1D+HYl/TR+kQYOOsqqHfB0Rq0isTc6z1PfpLcnCRQzeFracoegpuJ1mhj1OOK/y4dMBLbRXEElf1oZH5QB2ONXddjgrP/iy7udi+d3onG0AnDknp9Sfa1pV/DjUth0u+bHRvanPIG4LhfaPtr5k9CevH5lLDHZtnNGHuT3MGSyK7LsYJfX/a0m7BwiGVri/LjbiOpzE5eW7Mncvv0c9nDCV5sXuUgRct8KgojsbYJHX6rACJqeT8dmCTN6vMmxyjiugxet3eyTeEr2u64FAuyRNMumxhzNP/1myvdmQFlxkcaK8UDEpME6XbieTSW/m2fSAhmnR0XqVtYWCRzkkXj0QLMmuo2x+s6zcJJFgxn1vJA9ZYJvYhCPp/2bcpOMEfBgM5PLjW2NSl11Bwb4BetceF4gNX4VEudPqvdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ea10cf-9f16-4b96-103b-08dda51c38ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 17:04:39.0788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FTrA8wMXNzXHS5mlZ/Y/wekw+L2SMdPnXfBRTs47UPczMzaPAvoednOoVzni7NL6Z6iHhd+zdfHLkx+QO7na6TidqhbopBCw8E61IqcBGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060148
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=68431faa b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=F2dmhqHey-cWQPDOQuoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE0OCBTYWx0ZWRfXzP4vEh3903ut
 r4yDZIIavZ3TGpqGUONpfLVLf0Oiqi7T0/Yf5GD1jyyE05kT6X/TYhlR+hOoRj2K4aHNAdl52gv
 pawjuM66LdqIoWdTcioR4eOfji8t0su8InvkcayEiywOLHcYdfSrTQTAP/ZzJLSLRG7S8l97hxK
 WUnuJtN+PszkOy12ylz4eqSelFDYiXsODd7duZmJ54LqXhG5EBI1hp/s7kZnCr890mONN6Iv6mf
 SGHS00ltULc6wutFUNfyMv8vfi9w2w/mjJ8UPPEqpB8BknY06X6bG0zKlWwZ2CHtZJZ1OpFYeZC
 JtknWkWo9FVtSnqNa3D5c6Gn9vy2u8m2qcPEL96TLmK9vVGPP3axxLb5JiaK9IDgUBDHKRNEing
 z681eHbllb1dLn0vB3s2dTkumU71ypwnIWxsGnF+iSRs851pRWMsVkb0J/l0I8vePTqKnxZW
X-Proofpoint-ORIG-GUID: 39moTB2j8QFgEVxmgiBd63uPYF1olUAn
X-Proofpoint-GUID: 39moTB2j8QFgEVxmgiBd63uPYF1olUAn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/6/2025 12:06 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 06, 2025 at 11:50:10AM -0400, Steven Sistare wrote:
>> On 6/6/2025 11:43 AM, Daniel P. Berrangé wrote:
>>> On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
>>>> On 6/6/2025 10:12 AM, Steven Sistare wrote:
>>>>> On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
>>>>>> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>>>>>>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>>>>>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>>>>>>> When the source VM attempts to connect to the destination VM's Unix
>>>>>>>>> domain socket(cpr.sock) during CPR transfer, the socket
>>>>>>>>> file might not
>>>>>>>>> yet be exist if the destination side hasn't completed the bind
>>>>>>>>> operation. This can lead to connection failures when
>>>>>>>>> running tests with
>>>>>>>>> the qtest framework.
>>>>>>>>
>>>>>>>> This sounds like a flawed test impl to me - whatever is initiating
>>>>>>>> the cpr operation on the source has done so prematurely - it should
>>>>>>>> ensure the dest is ready before starting the operation.
>>>>>>>>
>>>>>>>>> To address this, add cpr_validate_socket_path(), which wait for the
>>>>>>>>> socket file to appear. This avoids intermittent qtest
>>>>>>>>> failures caused by
>>>>>>>>> early connection attempts.
>>>>>>>>
>>>>>>>> IMHO it is dubious to special case cpr in this way.
>>>>>>>
>>>>>>> I agree with Daniel, and unfortunately it is not just a test issue;
>>>>>>> every management framework that supports cpr-transfer must add logic to
>>>>>>> wait for the cpr socket to appear in the target before proceeding.
>>>>>>>
>>>>>>> This is analogous to waiting for the monitor socket to appear before
>>>>>>> connecting to it.
>>>>>>>
>>>>>>> - Steve
>>>>>>
>>>>>> Thank you very much for your valuable review and feedback.
>>>>>>
>>>>>> Just to clarify, the added cpr_validate_socket_path() function is
>>>>>> not limited to the test framework.
>>>>>> It is part of the actual CPR implementation and is intended to
>>>>>> ensure correct behavior in all cases, including outside of tests.
>>>>>>
>>>>>> I mentioned the qtest failure simply as an example where this issue
>>>>>> became apparent.
>>>>>
>>>>> Yes, I understand that you understand :)
>>>>> Are you willing to move your fix to the qtest?
>>>>>
>>>>> - Steve
>>>>
>>>> Thank you for your question and feedback.
>>>>
>>>> I agree that the issue could be addressed within the qtest framework to
>>>> improve stability.
>>>>
>>>> However, this socket readiness check is a fundamental part of CPR transfer
>>>> process,
>>>> and I believe that incorporating cpr_validate_socket_path() directly into
>>>> the CPR implementation helps ensure more reliable behavior
>>>> across all environments - not only during testing.
>>>>
>>>> Just from my perspective, adding this logic to the CPR code does not
>>>> introduce significant overhead or side effects.
>>>> I would appreciate if you could share more details about your concerns, so I
>>>> can better address them.
>>>
>>> Requiring a busy wait like this is a sign of a design problem.
>>>
>>> There needs to be a way to setup the incoming socket listener
>>> without resorting to busy waiting - that's showing a lack of
>>> synchronization.
>>
>> How is this a design problem?  If I start a program that creates a listening unix
>> domain socket, I cannot attempt to connect to it until the socket is created and
>> listening. Clients face the same issue when starting qemu and connecting to the
>> monitor socket.
> 
> Yes, the monitor has the same conceptual problem, and this caused problems
> for libvirt starting QEMU for many years.
> 
> With the busy wait you risk looping forever if the child (target) QEMU
> already exited for some reason without ever creating the socket. You
> can mitigate this by using 'kill($PID, 0)' in the loop and looking
> for -ERSCH, but this only works if you know the pid involved.
> 
> One option is to use 'daemonize' such that when the parent sees the initial
> QEMU process leader exit, the parent has a guarantee that the daemonized
> QEMU already has the UNIX listener open, and any failure indicates QEMU
> already quit.
> 
> The other option is to use FD passing such that QEMU is not responsible
> for opening the listener socket - it gets passed a pre-opened listener
> FD, so the parent has a guarantee it can successfull connect immediately
> and any failure indicates QEMU already quit.
> 
> For the tests, passing a pre-opened UNIX socket FD could work, but I'm
> still curious why this is only a problem for the CPR tests, and not
> the other migration tests which don't use 'defer'. What has made CPR
> special to expose a race ?

For normal migration, target qemu listens on the migration socket, then listens
on the monitor.  After the client connects to the monitor (waiting for it to appear
as needed), them the migration socket already exists.

For cpr, target qemu creates the cpr socket and listens before the monitor is
started, which is necessary because cpr state is needed before backends or
devices are created.

A few months back I sent a series to start the monitor first (I think I called
it the precreate phase), but it was derailed over discussions about allowing
qemu to start with no arguments and be configured exclusively via the monitor.

- Steve


