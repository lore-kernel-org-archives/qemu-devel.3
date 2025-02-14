Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF54C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwrd-0006A4-Fp; Fri, 14 Feb 2025 09:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwrM-00066w-HV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:40:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwrJ-00010s-Bp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:40:03 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECuAN6019643;
 Fri, 14 Feb 2025 14:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=v8AeiBczkBcI5Csc4PMX7n+sV7nvBZa3zG0gr4RzR2s=; b=
 axijBsIYCB95h1M2rITqMxbK0EDRn497sjtVdCavdqih9pyqY/FXKoSi2tfBD5Wu
 hwZDOpsrZsptal0EFUhiVf1ykhUALHqLfcn65JlqvIo96OHnwx37YyyFuxL+xpyB
 lYjHAdhg/RDw+9i8IdfIbCQy4406y6QH38+S13g3KI5UDYhsyriVVFscU8uKI1Uq
 bs86anr57tstsBhaXajz0S8WflD533z43+ZFUITT6P48p2kLOMSQoebKEhI9vdCf
 2BhsdVobgkA73T1iCCK421TDktE3QfhCYoZJH536z6ZBUpHbp8kfA0v7M5M1rbVk
 lNicigmwsGvlo4TyhRD7RQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4bp8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:39:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EDCfGc005123; Fri, 14 Feb 2025 14:39:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqd70w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzRJPUQWOHCC1gqboy1/1i5ycW0lhBlvYxLNoEmb7fEIOjtcAWXMnAY/+Z1Mm9xjj5RFHmu5XbJBT2i+VT3AjZPR8T/fZ5sZ9ZxlbxRvnKDy/bxUf2F3cP1F/aOtJMSu9F5A39BiMIKuPH1JTxaSf6HTVGt+DTfeY4E5GkqWibnDzf1a2VinrUKE8XGdidGCVfQZilMkmqhXk742dEhOp0FYY6sw28VOzwPxHTQ8zeXXFUSwI5xqPDLCd13xwNQitzE2G8eUAQhzafodxcbyJnXmPiFYmXAl4b1yPT0ISuLejoPQ4ovzHnN+28U4fFp8UtlyUVG9pjmJG44KYrnoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8AeiBczkBcI5Csc4PMX7n+sV7nvBZa3zG0gr4RzR2s=;
 b=gn20Aw8in9r+k7I2QTo0QJlDegn7UCVcXIcsbmdsiIrFWEC3W2aneMculUmC2qzNX8KoxjYtb/8qS+j7aG8ilJbGH416/2zGjh4tYiS8CUVZTQfmxBXWDmO3UyNLpfzEatpzvCpQGxSlIhPIZ9kGVrnxR6uUZO0jynU1UTp/RKIl5/WGEsFwoL6cwJsVXRnuHwLm75jxRE1b7bbawPXuA9DSjfTvh44cExzhGnbdtj7XtwRA3ym6or2UAVj7XmuqVtN42/ZxndJHCJaWyPV5QYlw29YiTJ8hFZgZWlcJr7lRQrDw5YA1CBEvUEasfec9mVyerF6Ts5ty8jwgBs+v1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8AeiBczkBcI5Csc4PMX7n+sV7nvBZa3zG0gr4RzR2s=;
 b=WmJgYl9OZmTa9FpOeuCFurQncAJEHRVfP6Fz87yUA8o0gum05X2HId84oh7r6g8zQ6oVRYboXrfU1FMIS1A5fxzQu+fdOkUO+PyvdET1Uw+6ByqPgOxvNRmx/bji7sbDeOPKTqTpyoKxoXMszA3wIfUsbWz7BAUDzMCfDCxr/ZE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 14:39:53 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 14:39:53 +0000
Message-ID: <bbb4b2b0-c029-477c-bbff-dace465ab617@oracle.com>
Date: Fri, 14 Feb 2025 09:39:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 32/45] physmem: qemu_ram_get_fd_offset
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 "Philippe Mathieu-Daude\"" <philmd@linaro.org>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-33-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1739542467-226739-33-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b821ee-ac95-4d90-25e9-08dd4d0571d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDg2SEdzem8rSVlVNnhsRUxrU0xUSzFibDBpaGtFMVhuTUlURTF1bHhxaFBK?=
 =?utf-8?B?enJhR1cxcloxR2pPYzludkVSMDFJLzRZd05oSzB5dFpZVDZDV2ROTVZnWThT?=
 =?utf-8?B?eExnejI4SVZTOTZOMlZoMjNLeGNQbGJ2UFdVM3doeHhvVDJlQjJmcmRsWE4x?=
 =?utf-8?B?QjdhNCtmdVdMbzNJb3VyeUQ4T0YwUXFiS1VHWEVmT3NhRmlVRkkrc3llOXhn?=
 =?utf-8?B?VVJnV1BjRWFRQjNmU2tWcDBVaVJhRHNUZkJYM3BzZCtlbFVkYnhaTjM5M2ZQ?=
 =?utf-8?B?MXRpSjU5Zkp0Vmx4cXdGUmppOG9CY01LODJpOHZMRnErTTdBNmhzbllLQnJa?=
 =?utf-8?B?RklNZnRIbXZRVVgyY1dCRStubm5HeHo5RDR0TjBCR3hGODRyNUdBdzFWTElU?=
 =?utf-8?B?RGxKQUFuM0g5SVBjaTJER2dGdHdlbGNXVzBqSWJuUlppRXNKZkljbGhEeEVv?=
 =?utf-8?B?bWRwTTgydDdOd29XOWxlYnhHRVdEL0dDTm5hMVpWSW5NWnQ5a1prbWU4Q3Bw?=
 =?utf-8?B?L0IxQ0RtcktmV2FPNE5LY3FpOFhtR3cwRk53cVZNQVpKRDkwTHJtb2t6MGxP?=
 =?utf-8?B?VG9kM1dQaithUUc0a2VmZWNGRXEyWklNUzRrRitKUHYxb3BEMWxLUkFXRjJD?=
 =?utf-8?B?WWl4dkdFNlJPSGUwQit6QTAzTTlyTHhPOU01ak5jbHFEV2RicFREQkROV3M2?=
 =?utf-8?B?NUVReWdiZkxhZkVSTklJYkpkZTY0ZkFxRFMrM2s3ZnV6cFRPV0FYUzFRNlpY?=
 =?utf-8?B?eEFoVVBPQXFyb25DZjUvWWoxam1OZHg2OGxPVXZtZzU0TThhaXVxZkdSWmdv?=
 =?utf-8?B?SytlWE1kczUyTGFmcFBzeEx4STBXdTE1MEJKNUJhM0RTdVBOSHlOQ1NNeWZ3?=
 =?utf-8?B?U3JOakswQkYrVTNMcWozVEJhcFdZMTRIaGZvVnd6dkgycWdSeVpZaGlNc2RT?=
 =?utf-8?B?T2dEVzRhSEZveUhJTnN1NUtjbm5kVG82U2ZBSFVWbHQ0MXVCNFNxRVpKOCtV?=
 =?utf-8?B?WTdvNzFZYlBQYzNianlnbTR3d21wN2Q5am5mOXlFQndURzQ0WnZmYW1BZSt2?=
 =?utf-8?B?Y2FzUnNZSFdlNzRpSDZ1bi9IcUJJQXZZbFNnRml4ZXNzcHlTK2tnWENZemZ0?=
 =?utf-8?B?ajhkMnRWZ0lsK2hoY2VHaTVCT090dDRjdndnNll4d2pTUlNqS3lEYVZvNHZW?=
 =?utf-8?B?eFJGT3lpZ2FRK0sxT2NqbFArOU01cVBxUllKYUd5MmxQcVJwYmloT3pOYWF1?=
 =?utf-8?B?TlMvNkc1dFUzS0VkdU9zTUp6TDRRVTd3a2lVeFM3SFpkL2Z1cHk0TUxKMTlX?=
 =?utf-8?B?Y2l6VGJNS0JXTXMzZEVZVnVPKyt0MWpxUGNTQ1pvNGJNL3M3aVVuZHZBd0Y1?=
 =?utf-8?B?Y2p2dGd0QkFqSm9PS0xvNDFRdUNyV29yM29vbjBibHY2R3A5L2h2dW9SM0Ey?=
 =?utf-8?B?VnEyWHlQUGh2ZjdUQjdVS3dQd0ppcG9jZVBqQ3dCalJ6dzJSYkZFR0xUTXp4?=
 =?utf-8?B?N0ZlL2lPZmhvKzZWaGtoYy8yZUZCUmdaVGJZZFR2dkEwUVBvamFtc3hjaTJu?=
 =?utf-8?B?V2RnOGNSWkc3WHpCbjF4NlphZ0V0T0dIM2ZPemxQZXl5eHhrbnBXZ3NWQlV2?=
 =?utf-8?B?ZWREUFBmMGVlMXQ1T0xWSG5MZ2JJQ0ZNQWlpVzduOUZ1dVBSTm5CK0J4Qito?=
 =?utf-8?B?ZnY3dXlSYmRjTFUyd1lHdkticXhxaHVFV3NPKzJtWk4vYTN5bFZEb1BTMVRr?=
 =?utf-8?B?YXA2TXNkS2hmRFlLc0VJYy9NTGVUMzhZVTdNb2dsNURSdFpmYWNHYnZ2T0dy?=
 =?utf-8?B?ZE9uQ01UN21NQ1k5eWtQUlVOaFFjQ255enJPN3VnMGhzbEdmTldTUlFhb3pu?=
 =?utf-8?Q?974sUqB1YnkLg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2g2WFkvSnY3Q0RoemhFQUhDT1F0Ty9VUVd3UVJyQ2hKNWxPeE5WektBOHl1?=
 =?utf-8?B?b0R5VGsxUW5WV1RuODhJaENGQ2xsV2l6ZXlaQ2hKNVE2V05tVVVnaDNvYnUx?=
 =?utf-8?B?YTZJaGNremx4R0Mza2UydzJkOUlocEZqTkxRdWxRTlBjWUwrK3F6TnBCZlZ0?=
 =?utf-8?B?cmRCdWYzaHh4TFd4VktJVUZ0aHNoLzZSZ05xaTBqOXNoSU41ZFlGalJwMjZt?=
 =?utf-8?B?MVVlcFIyUzFaeGFOVTRWRTBTSnljOW80THZId0JMSXFYdFduUGR6dm16a3Ux?=
 =?utf-8?B?Ukk1NEp4aFdmdmFZZENQdnd3anFia1k4ekl1T1pyaXMwYmJLNitzNHNIKzh2?=
 =?utf-8?B?ZUpwQTRvbkpnN25JanhYUSt1MGZkSkVOMHJ6dnhyOG9ScDRzTVJHR2trcVlZ?=
 =?utf-8?B?L28ydnhCYUxCTERkN2xjQitpcUE5eXV2c0xTUmoydnpVMTM4cnZMQTVVSG9j?=
 =?utf-8?B?OTEzZ3h0OVFKOG1oNDFPSHI0d0lib3dwY29mL1dYR2pjc3kvZzY4VHZnWUtP?=
 =?utf-8?B?Rnc2dXNTaTMrNmpyb2sxOGtUaml0QlF1L2tqMkVEd3RPS2RqQkRZSWcvRjhV?=
 =?utf-8?B?WnU3UUJkQUNpWk40UlJzTnc1eGxWUjl0dHBERmtIMWdkNkJRNitZNXlRSnha?=
 =?utf-8?B?dDlCS1BrSU0rZDBQZlI2VHVXUGJzUzhxNy95Y0czQ09EQjZoc3hmbGs4b04r?=
 =?utf-8?B?K0hHNnViTHJaeGVYV0Jib3JKaGxsVnZhNW5SNFhuOERHV0NEUFZ1ZFNzbDZE?=
 =?utf-8?B?L2ZNSE9RUUdXelo2SXExV0tadGhpZXNtTFlkcUF4Y21tMDgvNmZGZzdnQ1pq?=
 =?utf-8?B?ZTJDbjA2ZXJxc2U3bkdBYzhjTllMOUpGd1J1aUJLamVsdzB1Y0dFOU52M3BS?=
 =?utf-8?B?dXBYTzVJQXAzSG9JS3NIblZPMXByTWhTZ0dkUUFyUFRVVkE3TktZbzlUWE1T?=
 =?utf-8?B?M0luRFdBNVZJUk9HU2NjUC85RkVsSjBIV1FiTkdmSnBQV2daVWIzeXlraFF4?=
 =?utf-8?B?VXBpSldaVWJ1ck83Rm9qZXROcUxOaFZXaEYxemFTOHFiU2lxNldUTUJIbUFL?=
 =?utf-8?B?V0pVaThyWCtXb2lkSWNaYXJuRExQMjNrcVJydEtJV1dOV2I5NkllckJBaDdJ?=
 =?utf-8?B?dkdXWlkyQnZMQXh2OUhuR2VPaTdpV042S2VLRzd4TEw0b0JQOHM5SWxPbVVn?=
 =?utf-8?B?ZVdsUGx6VzduV3Vad1pvWG5aWTFpTlF2Z3BjbUxVS2prRDZYbFd0dE5tUnht?=
 =?utf-8?B?WEdvVTY4NWR0bWRST0VoY3drOHcrYTE0YllXV2lqa0xadXphTGI4dEVyRXBK?=
 =?utf-8?B?RGFxZ0NnWFNUTyt3MnA5WkpydzZDMDZ6ZUVmRE1lUmw2bVR3YkMvdytEL2hT?=
 =?utf-8?B?VDh6TDhjQTNxOTU0UnZiS2dtZ2U3aC9tYURrejBsbFpCYUZxM21iUk5zS1B6?=
 =?utf-8?B?cFdDNmxZVURNQnZoWkJGYUNaOHlUWDZody9wYkFsV3F2TU5RbnB3RW4wQ1dJ?=
 =?utf-8?B?L01yMTRSOG5GMVQvVm9TbWd4cXZsTXdxRWJ6UjVNeTlGQU0vaFJBTUNZUXNK?=
 =?utf-8?B?K1VXTXYvNHVtLzZtb3ZuSGdvbThXS3VESXdiVGIvTC9nVXRMam9IZHF0WEtV?=
 =?utf-8?B?T0RlSlFhZ1ZmM2dMRVViMnVMN3paSzBBNVdZS0oyTHIwNFZ4VnVFbHdNRUZn?=
 =?utf-8?B?Znp2UWh0ZUErNDBLUmVMU0ZKRmFEcFFteXExUHJLU0haQVdJUjlOTzlORm1Z?=
 =?utf-8?B?NGNkUjV0a1dmdXRlcUQ1QkdWQWNCV3dBMXJqcGpLem5Tck1heHQ1cjdHRWhu?=
 =?utf-8?B?c0toUm9MK2tMcFBIN0lEZm1oTWgzQnNUaVpTZ1p3YXhXQjBmQlNvYnlnOXV4?=
 =?utf-8?B?YkloNUFlSVBrMkRuWTNJc2prYUhrWk9GTVpRbEhvWm4vS0NXdzEwVS85RktL?=
 =?utf-8?B?cTVidThHNml4S3dBbjRBNWZBNmhidUcyd2pSN1hjTzFLQ0x6QTc3ckt6Vkw4?=
 =?utf-8?B?aC9NMy9ZOFJtREFraGY1TnZmeWt3RnNXc0R2OG9QVVdOZXoxdzdMTHE5VFhP?=
 =?utf-8?B?M1F6NDMyWmwzWEI1TmZhb2lGalVsT3pGSFltOXd4WmtyUDRmOC9XVC8zWjNm?=
 =?utf-8?B?Qk1hK3ArUytZYTk0OXRVVE9STUlDeXpJZkNxckl3RXZHd001Nzg2Y3JaVzBG?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EU9v0NhtAU5sBSctb7J6YL54wy8RrOS8tquBr3p2qgU75SmbjCM6o+loYBSlIUKGOZ3PEmYCQR1VRfFhgMondNgsvAom9ZAh0v452Lo8qVZmPq9LuVB8JdoIVZS4sXXGxjbxOv3v5bhLqcabhNxmtZ4G8w5Fh3I3f8CUMRHKlY3c872Y3w/1p4PFi3FDMTpUZdkwuphUEvMLP7j//St6SaomgnpWcxtZCt1gHG/3Bu5dJRkcOiyKOq9/ZDH+GvarmtQ1UriSXFVdgA1gDjxzqmRfTh6dtKfEEQy+2nH3S9yu6/yxLTi6+n4IRmUVZ3B4ctHLMbD0ilUcCxtuE6ZRdPTDsgghYdRrm/ipW0RVbQy1tMsy/rTGtZ0EMHkwP8QzI/9jUAWJfwo+Xd61vhnMjVzgAiY2Y2Gufu4x0OmLgk8oj345wNEpyvP7LNAhF2y9/2bd08NKBZFCyKL93Tc9lJohf3idoTfGuWuNjSf18ig+lEqOEgwdPI2QLKkf1n7pLY2k/bbKjhc1N+LSMP39L+bHsDOBsgM7wjQcHf4eq0KUT4RuxMZqA4ObVzJpZXrvAdJNtqqTjMFOWXlZavtZk10g1AI8iX36tYIsObvEP/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b821ee-ac95-4d90-25e9-08dd4d0571d7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:39:53.8485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hLHqNJqx/Q4KyBzg4SO15ZZ1pxLZO59HhmY+83g1UKbGcZlZr5VMEXyX6dDhL46Pu+nEaXmHFLQbm3EL9QMyXagtaNCpubbFmquBRvupno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140106
X-Proofpoint-ORIG-GUID: Thwpbc02k7zworcv_NyxLCiRaw8C8vtf
X-Proofpoint-GUID: Thwpbc02k7zworcv_NyxLCiRaw8C8vtf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

cc memory reviewers.
The series is here:
   https://lore.kernel.org/qemu-devel/1739542467-226739-1-git-send-email-steven.sistare@oracle.com/

- Steve

On 2/14/2025 9:14 AM, Steve Sistare wrote:
> Define qemu_ram_get_fd_offset, so CPR can map a memory region using
> IOMMU_IOAS_MAP_FILE in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/exec/cpu-common.h | 1 +
>   system/physmem.c          | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b1d76d6..0cab252 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -95,6 +95,7 @@ void qemu_ram_unset_idstr(RAMBlock *block);
>   const char *qemu_ram_get_idstr(RAMBlock *rb);
>   void *qemu_ram_get_host_addr(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
> +ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
>   bool qemu_ram_is_shared(RAMBlock *rb);
> diff --git a/system/physmem.c b/system/physmem.c
> index 0bcfc6c..c41a80b 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1569,6 +1569,11 @@ ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
>       return rb->offset;
>   }
>   
> +ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
> +{
> +    return rb->fd_offset;
> +}
> +
>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
>   {
>       return rb->used_length;


