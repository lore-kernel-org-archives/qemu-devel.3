Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B63C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 22:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRIiy-0005Xc-My; Mon, 16 Jun 2025 18:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRIis-0005Vd-JC
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 18:54:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRIil-0000jq-Sv
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 18:54:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GMMPCe027735;
 Mon, 16 Jun 2025 22:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=VS360A01q287oJURxDk5TNZ7Y79LvawDq6WjNtaHmk4=; b=
 hz0wNBvvghi8bihEeikRgn9hgVXKK/24CENZPZyEHaQgPcMUbqUnRpxIL/CG427i
 cVgOFxvLW3ucPMb1xfigGxjw8LivSHpsxAFXOFg6V1/AYC/xg1sSdaa7+bE2WRMA
 h53rP2V+iBTiowv68J4H8l1OQjnATI3+VgykEVog8IfXXWujtP83Abr0Ki1DSpR/
 yzln6U7SZVye10h7AhwfnQwbhYKJar+lDCXcbE6hOIk8mmlX8Qj7LsCKHqJu9yhP
 6yVTDm2gsZJq0b/JIl0K7K1xPeXwDptRShpvFimjVxEFXdKWu98pMXFd9OPMbAau
 M6YKvuR0zRBPPW7o1Lm0WA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxm5x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 22:54:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55GL8uKH035184; Mon, 16 Jun 2025 22:54:21 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh89evx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 22:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2v7qNr7OYEoym34SBQZCTSgm6vhtvQ6rzF5M/nNocCmhxIkxR70nd2mWMO1omE2pywPU5eEg1wpNd2VKlar2bt4UlCOrot3q15zWQR5zAljJNA9XO+eNjpcY97Y75XbeVdHwDySHEDu5xySGc3d3rJmBoMfZoyp7iGREaFgsynL0uAULFCZMopLm6/LQOfN1v2gQCkQWqa9dtlU+FKMwFIDEAOetnMwkoNM+KPHSXcOUXS3r2sJPHl8jBaYyQI/e9iSoil6hVmwVAZ/9Q/z4QkMYMkHK3FYLH/FjSRTMksp41MIixYdBR19Gt3ny40VLRk1NdbA4iI1q7bBhwpOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS360A01q287oJURxDk5TNZ7Y79LvawDq6WjNtaHmk4=;
 b=l6KiyTdzAu0PWD3g3UpQFqTxVPT/m9qZWj5EMR8HMUnxr/MzX+t2Afh38nIe6oquK8zwXGOIlcLj13whrgpqpI2rFemVcAj16743IY1+Ag+ffWqT1ovYjJxiVFIICuIZ29Dqpvpza7T1tMiS7DRAuT13CIopNTGBaxaBJFLMyMRkHXklqHLxkm9THmWN6lyNhGPS1uWbQO86BO7Qe2usByVTN9kl+ZApSSlU16b4FUzd3N4dWyPKtJwYWT3rRQ+V0MVJcLs/vSrNveH58pMLLaCjeZTpCpgREPpYeEYJY/XsrjY6rcyA+tcb//G4rCcyIftKKrmCX88e1tyRWkQ5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS360A01q287oJURxDk5TNZ7Y79LvawDq6WjNtaHmk4=;
 b=NhUm58G5JDHilvexoZIXW/n1gJDQKHh703EX9XrjISnxo8qHJ32363S7pYHfGZFvlN7xH2YL/jUdhH8YAniKjsX1Phq1fTuAMAecloy3Aa5qbFoHXv/ZaImUl20G+moKFAI+VnfMHCmr0MNW60V5DY79B9DJ1f1Hp6t8eebmdyY=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 22:54:13 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:54:12 +0000
Message-ID: <f5a8e3b0-a7e5-487a-82c4-d54d565a657e@oracle.com>
Date: Mon, 16 Jun 2025 18:54:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] amd_iommu: Fixes to align with AMDVi specification
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ethan MILON <ethan.milon@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
 <af1423ff-24ad-4a4c-8a42-eec5fe77a66c@eviden.com>
 <ca5c935f-adc7-4d9d-930b-b8a4e71003ab@oracle.com>
 <eba82f72-fd87-4f47-b5a9-86dbccb6b90a@linaro.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <eba82f72-fd87-4f47-b5a9-86dbccb6b90a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: a252baeb-b999-48a4-28db-08ddad28b628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG1sdGtLbEplYXZzTkRNMnVNZHZrc1dRaHhVaUhLOU9xVCtkNStScGRTVElt?=
 =?utf-8?B?QnRZOHNDekFEckY2eDNhVWRtYmVvTGhGa3FkNW5aT0h1VVJzL2M3bXZKWHlB?=
 =?utf-8?B?a0FZWkxUU0l3WXhycHl3UjUxS2JacUhhNU9KbXF2WVhLWjBtNkNaeXJGczl6?=
 =?utf-8?B?VGJ5NjlEekVIaXJWcFRQNUE4dDUrZnEweEo2UzNTT0FVajlKd0FvVmpwd2hL?=
 =?utf-8?B?Y1VrVDFlNDNtNnRSRjc2MkhsSmtlc0RISHNXUjZxcFJ1bkR1OTNwNFhXOXN6?=
 =?utf-8?B?VGVWd3JudHBZVXBVMFJVeWcvMmhpakZkU01sMUtRVEdLejNra25LUk12Q0tB?=
 =?utf-8?B?YnlaUGY0RHlkbStOaCt0aEJWTnlWSzRYcjN0K3huRXUrWUNLaDVEVjdrcFJ1?=
 =?utf-8?B?bWFaNVloZ3lMSUEwOHhURm11bDFNK0VDOFYyTGNCR3B1TTMzVE9iUSt1aklz?=
 =?utf-8?B?dGZNMXRpUVV5b2pmNXhyOWtnQVpxeEd3NDgzWnBkbUdIcWFuR3h5ZnBVNUZ5?=
 =?utf-8?B?eEFreTdIN3hJK3l5ckVRbmlEWlhRWnB4RER5cFN3Y3NQdE1SWjFhdEtpYWtQ?=
 =?utf-8?B?L2lqTzhkTXh6SGsrbmx3U2E3cWV3YndDKzdFT2liL3BFZE1aV2xIUHc2QXZu?=
 =?utf-8?B?TDlIUnAxaUlBaXkwUVRLeUllWno5V3VPd3JOS3lnOHRaSE5RaHVkRExGRHhp?=
 =?utf-8?B?R3UvNkdMTGtJMXdCL1hKK3VadTl0ZGRQdDhJa0ZpY0tJbk5zN3Q2Q2FRUURC?=
 =?utf-8?B?b2JLYURKT3lxQlJyUnF1N1NTOU1rMlVtd3k4OUFVQnkzb0xUUERDSjBua3hW?=
 =?utf-8?B?eFNJNjI0U1dxN0JmbE1ETE43ZW03WUZzYVgreGM0bWYxOTY5dUtVUzRDcWhm?=
 =?utf-8?B?M1NWeDZIVmJVazgwc1lNaTBWMDd4aG5EZTZGTkNGU0J3T292djB4K3pvZXpn?=
 =?utf-8?B?TFZzc2pOUW03cTRianQ5SG5rSGNYa0c5N0NRSytJRzN4dmRGemlzL21NQ2xl?=
 =?utf-8?B?ejlKY1Y0UXRUekxocGMxb1k0Y2o0Q3dmbnVvdkdyQ0tPYk9GL3dlL0tMdmxG?=
 =?utf-8?B?NW5sdG1iQ3Z0Uzd1N2JMUXVsaWhFKzJkV0FDNlJKSHB4VDhiYjc1c3o0T2JR?=
 =?utf-8?B?dEhXbHA1NXh0V3VHTGNxMnhhaGtXZ0oraHhmdVFwbU03dkVIaVFsZkxmK3gz?=
 =?utf-8?B?Y0JvbVZ4cEJ5NmQySzA4YnNjVUo3ZFRaSkI4UllScFJVaWMwRVl6Qk1mdkFD?=
 =?utf-8?B?WUZoV1h5SlovUm9XZng1Y2tyL05JRUN0VUhUeEhCUW5nSGZ3UUhRdGU1aGtk?=
 =?utf-8?B?T0FXNDRvZnZBWWI0TExYK3JDc1NtOFdhTUVGQlZSK1VOQ2NwaXRWMXNxZXNw?=
 =?utf-8?B?VGp3SHhEd0lXaXBJdHFUeXZtKy9zYnJXVStqRlNNZktWSUw4c0dRSmZDM1E4?=
 =?utf-8?B?TlZZNHVqSlA4K3c5YnllNmh1bHREdGRPeCszMGRxK2FMWHRiU3M5OXMwd1dp?=
 =?utf-8?B?OGZkMTY3ajVTLzkxMHJ2VEpldTNuQ00yNnZLZmNnMHBMRFdqNi9OWFM0QUV5?=
 =?utf-8?B?SS9WOTNXU2JGYTgvZCtuWVREeGsxSS9zWDl3TytET0lKWUlJb1B1VUdsMXZh?=
 =?utf-8?B?bGkzSDgyVmlWQm9aeDFlai8wZWYrdGtUWFBQUEVPYWYwMGY4MHhUL1I4L1JI?=
 =?utf-8?B?K0Z0N1phMFhyUUMyYXZsaEpKblI4R1Vla3M3blhZRk5JM0M2bWdnWVhJbDhk?=
 =?utf-8?B?eDNYRzBhcG1Ebm5scHRrSXozWmxmeSt3RUxYbGlNMUJtZ295VSsyR05uM0dm?=
 =?utf-8?B?SlA1eEdPVWlCS0trRGljU1RsQndnV29LWGlrc0pQcnkvNFlmbytQNU1ZdFRi?=
 =?utf-8?B?WmtGaVNadm5xWW9Bd3RjYW0yNHRkSmxvQXNDK2ErdUhwaTlEcmFmTFFkWndq?=
 =?utf-8?Q?mM/+TI4O1nQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRpREtCbUlnQmhpaGkzaHlYNHZIOUszSTU5N2plUnV5NWZxTVg2UGRjdEt0?=
 =?utf-8?B?elJQYkU0MDB6VlAzeEgzYXVHQnp3RGZIR1NjdythcWUrNC9lWitkSks4YVdu?=
 =?utf-8?B?Y1hRV2lxMmFhMnB5eFhUcDBQdUN1L2U0ZGNENzlQVSt0MDVmTU9TTUlBQ25U?=
 =?utf-8?B?WVJEOFZ1YVdlSlVxcGdDbUlhRXZ6TlVlSHhJRlpqaGlMeXlMR2NjL3BTNDlP?=
 =?utf-8?B?Y1p0T0dlZnNmaVNQakI4b0NDUEswaytFcWpEMmZXSDJDRHgvSTdXS1NRZ2Nq?=
 =?utf-8?B?VktNUng4YXN3eG1qdXhxcUxISFpCY3JraWsvd1RvcXVBc0F5SGRrNFdMQW5T?=
 =?utf-8?B?UDBDWTBYaEZicXlLcWo3MWNIWi9PMWc2ZHpRNUVXMVRxb0hUdW1WUG9rT1c5?=
 =?utf-8?B?WGFmQkRxcS9nKzV3UXhJOG8yMzFvN0k2bk1HRFNIOU1Jak5KTFlIR0N6bGxM?=
 =?utf-8?B?N2hiVE1YZElNYURLekVKSTdaaVdzTXpDSWZkbk9WVDIydFlYTHMxdGRHRTNi?=
 =?utf-8?B?V29pVTFQcVRETEVqelp2ZURJeDlVM1Y0OHl1V2JCR3d6WHpVejljclVlWkRM?=
 =?utf-8?B?NnhnK3lXTlpzS25lZUIxQXhHSVJ4OHo4Q1d0cEhUcjlHT1I1cFlYeklLNGJY?=
 =?utf-8?B?MWxZYjJ3RFBNR05DeS8xZXVFSndpeHlMU2o4TXNtVmlUeDlzSXZPSUZyWVJZ?=
 =?utf-8?B?MmV5dVNHK3BDUzQvYjBHVUhDdFdtZThwWG9TMzZ0Ym5OV0U1M0VBLzVlTFoy?=
 =?utf-8?B?VitqdkZ0K3F5blBydEVINkI4NFdqcjVuY3owd3ZyVEJqM0NsNVFjekh4WVk5?=
 =?utf-8?B?cGdiZnozdjdJVDJ1VzBUZ0hvK1JYbVk4T2JndVJtSmx5ZFhUZjVMY1AvYzdY?=
 =?utf-8?B?RTRUTDUyWTRTc1RTd2V3OTJlRld5UE5vSDVQVGozTjB5TlhOMDZWUDU3bE5M?=
 =?utf-8?B?WGI5dDRBWnZOZmdYaCt2RlJRQmwvSmFieWlCR1BzSGIzT28xeVNJM3VsM2hi?=
 =?utf-8?B?R01RdHIwN2p2c1FUK3lRa1BTamZTREVEdG9OVGJWaHFtemNabVVYQnZsWlpD?=
 =?utf-8?B?bzdHckhablhRRzFmemtUZWt4aS9iQVVPWGEySy9hWHBnQ3FJck1CbDJ0MzJ1?=
 =?utf-8?B?aXhLZitaOWNOUGlDOWpIa0g1YWhlS2xPV1dFUEUxTnUra1p3SUlIRjVPODUr?=
 =?utf-8?B?cGhqK0NqZnNIaWZKVURjaE1TSUt1VWlLTU8wcjhGQ1lFc0RQUEN0QnIzT0FE?=
 =?utf-8?B?WHNTeGRvK2M2NGhrTkloeXJFYU9xTk5nYk9Md2s5NWZ1dS93a0Q0NzlvWVpG?=
 =?utf-8?B?WS96Mkd2WGkzYjdwTE5HWmtrbjQ2Y3R5K0xSQzFxWkdHN2ZTVnlSaVdQNmlB?=
 =?utf-8?B?VzFsZ3JvQ0Q3V0lpME5QanlsYmNFMnZwSjRBMmtzYW1rNU5vWFU5RWFacmtq?=
 =?utf-8?B?TzhHUlV2bUM2QXBrRnpwRDg0QStIUkxKeWkyZ2M2ak1NSERnM2RHTmt1cndo?=
 =?utf-8?B?T2kyRVlGMHZkQ2xyeW1ObWdpcDdmQk9NSGc4b0EyTkhsOGRrWnJrdmdxODNw?=
 =?utf-8?B?M0JaN1l6NldKbFBVUWFVOUxzNFo3UXkzNXJMQm9aN2RheDZDamFobi82K2Vu?=
 =?utf-8?B?Yk11MHBBUGp6dnFUZzJpR1lqeWJCQTZuN3p5YXNvWWRMdU94aTQ5SFhrd0dM?=
 =?utf-8?B?RW9TdUhYamt6NWNWeG5CZ0VQeW5IRVJFUFhPT1RYSXY4NUNleWR1YjViempO?=
 =?utf-8?B?SFJMS1ZiYjN6VlFwWUVMTjFLYUlYdVBsSUZjS2FLZ3hiVG0zVjdRRVJoMkFq?=
 =?utf-8?B?c3ZDYnJyT2d0MitoQmFSbVlyQWtQbHM2RStBWkFTbGtQbk5tOGlMSHFhd2Y0?=
 =?utf-8?B?Y2hsZlJLaFNlNEliQkZVQ3NNaS9pUncxaTlVbDg4RmNrRzdBT3hiY1BlUnBZ?=
 =?utf-8?B?Ymo5eFZ5VWVNdjNlcndNdUpCRjd3eE51SDZ5OVNWT2dTQWhuTlQ5eE9ETHhV?=
 =?utf-8?B?WHNDQWdkeEhvZ3k4M3V0ekFhWSsvN2l1alNodFBLZEhUaHZtWnd0N0xxWHI3?=
 =?utf-8?B?UjBMTzdxTEhaQ1J1Nm90bmJEZzdUZE9SejlGWlVIVG9FSmxLWEtXcUpob2F0?=
 =?utf-8?B?VUNmM0gyNWQwM21NZ0tDQURsdUR4YlZDc1YxOGhmQ3phRzF0cVV1Q1FIaGp5?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rNL2dzVcCYRYAdfP6XRzqu1PQgLnb86yn3A2UlrE2kv2n2nfc2N5kgIjsea1KXzwtpwgzqDKHHu5KypzRvLwyayS0EaJY9uPkPt9olAqmO3nQ3657cG3tt1SsY4OnrEtbPVcIvmuc9OSa5r25rCGFj7kH6bVpKG7sF83RusbB70P7s79rNxvx7sK/y3XOaZYLJQG27MbYFzWJf7em0X5vV19+NSLIkHR5XbYfH/HP9T5O/O47FnHx49u2gXYVBub80L6IL0msbY+gEtj1HEa9KSTqB9xned2QIyvAVIrKPBmpoLlXw+95g6Dr+3XE0ZBMr7s64WQtc4NFNM5ErTb8IlUKN1YgOMJ5+wAc94jGx6BxcC0DG2qCVsp+S68ZkPBnvPb1RUNmLAb5bgPJjWAWjMh8sifIgtJgva+DHAaHWkj3SAwT//xGe2LZ59KjaCGwRnEdcLWuefK/jAbfWAyoefl5TyDRxEPlaX9woAOa5d32wRz3tpMoYBVMF1hYg5dHypgJBYQMwKbjoB+bUmDNz5XWl9XkjR54/JyMx6aITcnz53oJVrieQU0C2TAzewDuQoobEdaN7CSquprmZHUAsV7L9+7TFDg+mSW05F5oFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a252baeb-b999-48a4-28db-08ddad28b628
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:54:12.9038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSWpvsWAIQV+MixjJJYDhqNtXb6StXhKmu2xGoBADmM6Pk+sAYttsQN6+OMKPs2KvOs71JWRtkOI0ZrUdLYfSh4fA3cmpHdw5Cghs9WgJcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2NCBTYWx0ZWRfX9IXPKynYx6IW
 uQsqaf0uoBI/9RunY99D4TBWu59+zLsROjdb1F/A6hE3ROUMlaopTrdCwzpQuP/jA8Q0grbEryi
 e4WhO8Zh1UHU9Q7gA+Xp+DaVn6ZeCX3Jj7q2gf/osYBi32JjY1T4xrijnoTMo6FxC5vb/w8n94A
 4V4lQqV8i9EJD5xOIekiQcVal0evKxXk7f9vBwLy5V3U6xMfR1FcJArM6KOkhlB+OrZEqXf2gdy
 5AYxf0E2cZ+7dg8w0jSnCkeilNaSOcwiVnHdE7Tlkzri2M0ybWJ4I13LPTGJfwJ8AOuFgDGpGnD
 z+yY5AGexs6w+T4pLOIByCktFRuP+kkoE6dc9cAImUVG0cuU21HpzhvpbkXucXoGpfDnHk3mAsT
 jKgPe1jKWMsVv8c0VGzTDMW/pLBNQ/Zjqe6lJBYvKExh6fVcfRIzrjs6SHIpd+UeEoGjRnD5
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=6850a09e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=CCydYvSpi1wDkXdEFy4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3grKjq6-_C-tghICZzuMTRZ90qzAiKFy
X-Proofpoint-ORIG-GUID: 3grKjq6-_C-tghICZzuMTRZ90qzAiKFy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Phil,

On 6/16/25 2:59 AM, Philippe Mathieu-Daudé wrote:
> Hi Alejandro,
> 
> On 12/6/25 22:59, Alejandro Jimenez wrote:
>> Hi Ethan,
>>
>> On 6/12/25 4:36 AM, Ethan MILON wrote:
>>> Hi,
>>>
>>> Is this series the right place to include the following minor fix?
>>>
>>
>> I would defer this change for two reasons:
>>
>> 1) This series has been reviewed and tested already. I was hoping it 
>> would be included on the Jun 1st pull but I sent v3 too late for that. 
>> I think it is ready so I would like to leave it as is unless there are 
>> any objections ...
>>
>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 0775c..18d30e1 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -140,7 +140,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr,
>>> uint64_t val)
>>>   {
>>>       uint64_t romask = ldq_le_p(&s->romask[addr]);
>>>       uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
>>> -    uint32_t oldval = ldq_le_p(&s->mmior[addr]);
>>> +    uint64_t oldval = ldq_le_p(&s->mmior[addr]);
>>>       stq_le_p(&s->mmior[addr],
>>>               ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
>>>   }
>>>
>>> This corrects the type of oldval to match the return type of ldq_le_p().
>>>
>>
>> 2) This fix is needed, but it is likely better as part of additional 
>> changes that are needed to cleanup/fix the XTSup support. i.e. there 
>> are unhandled writes to the 0x170, 0x178, and 0x180 MMIO offsets, and 
>> those depend on MMIO 0x18[IntCapXTEn]=1. I think the truncation of 
>> oldval that you found is causing XTEn and IntCapXTEn bits on the 
>> control registers to be ignored, but ultimately things are not broken 
>> enough (yet).
> 
> I agree with Ethan it is better to avoid hidden truncation, because it
> just makes debugging experience harder.
> 

I agree that Ethan found a bug that must be fixed. I am answering his 
initial question of whether this series is the right place to fix it by 
pointing out that this bug uncovers that there is more to do than just 
fixing this specific error, and it could be included in a series to 
address those larger problems that I mentioned above.

On the other hand, it is probably better just to fix this specific bug 
now since it is simple enough, which is why I asked Ethan to send a 
commit and I will add it (he should get credit)

> If this is the expected behavior, better add a comment, or use
> extract64() which makes the truncation explicit.
> 

It is not the expected behavior, the truncation is a bug. It doesn't yet 
cause any issues because amdvi_writeq() is currently only called to 
handle MMIO writes for a few offsets/register, mostly to 
AMDVI_MMIO_CONTROL, and the romask for the offset is 0. This means that 
the bug doesn't really change the value that is ultimately written to 
the emulated MMIO register, but it could cause problems in the future.

Thank you,
Alejandro


> Regards,
> 
> Phil.
> 
>> In other words, I think there is a lot more work to do in here, and it 
>> is something I am looking into.
>>
>> I suspect Vasant might have spotted this problem already, so he might 
>> even have some fixes queued up...
>>
>> That being said, if you want to send a patch with your S-b I'll add it 
>> to this series.
>>
>> Alejandro
>>
>>> Thanks,
>>> Ethan
>>>
>>> On 5/29/25 9:30 PM, Alejandro Jimenez wrote:
>>>> Caution: External email. Do not open attachments or click links, 
>>>> unless this email comes from a known sender and you know the content 
>>>> is safe.
>>>>
>>>>
>>>> The main reason for sending this new revision so soon is that v2 
>>>> included a
>>>> duplicated [PATCH 5/7]. I fixed a typo in the commit subject and missed
>>>> removing the old patch. Apologies for the mistake.
>>>>
>>>> Additional changes in v3:
>>>> - Fixed typo on [PATCH 1/7] subject line (s/Miscellanous/ 
>>>> Miscellaneous/).
>>>> - Added 'Fixes:' tag to [PATCH 5/7].
>>>> - Added Vasant's R-b to patches 4,5,7.
>>>>
>>>> Thank you,
>>>> Alejandro
>>>>
>>>> v2:
>>>> https://lore.kernel.org/qemu-devel/20250528221725.3554040-1- 
>>>> alejandro.j.jimenez@oracle.com/
>>>>
>>>> v1:
>>>> https://lore.kernel.org/all/20250311152446.45086-1- 
>>>> alejandro.j.jimenez@oracle.com/
>>>>
>>>>
>>>> Alejandro Jimenez (7):
>>>>    amd_iommu: Fix Miscellaneous Information Register 0 offsets
>>>>    amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>>>>    amd_iommu: Update bitmasks representing DTE reserved fields
>>>>    amd_iommu: Fix masks for various IOMMU MMIO Registers
>>>>    amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from 
>>>> DTE
>>>>    amd_iommu: Fix the calculation for Device Table size
>>>>    amd_iommu: Remove duplicated definitions
>>>>
>>>>   hw/i386/amd_iommu.c | 15 ++++++------
>>>>   hw/i386/amd_iommu.h | 59 +++++++++++++++++++++ 
>>>> +-----------------------
>>>>   2 files changed, 37 insertions(+), 37 deletions(-)
>>>>
>>>>
>>>> base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e
>>>> -- 
>>>> 2.43.5
>>>>
>>>>
>>
>>
> 


