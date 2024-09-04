Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A292CD4F32
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slx5I-0005NS-F3; Wed, 04 Sep 2024 16:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1slx5G-0005Ms-5R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:58:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1slx5D-0000s2-FK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:58:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Kek7l028538;
 Wed, 4 Sep 2024 20:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=JScAbAjqiU6Mp0fssYeqlKNgirqEy981aekxhs35HBw=; b=
 a+M+LS55n7G8DkAwpe9TfKbuGkusPaQqgE+EpsISdJ8Ij7yjkrHtncwn6zXwm1Vm
 xWI2uhWawBsEEH6PfyS8ZbPapfnlY6hBKzmvjCP8za8nCOtj5HHYMIXkqJOJq1SB
 53JFgsGNRnqt8Tol24pMI4nULJLi6H4M2nHl/nQspfFse2NVndlyk8u+gWkarcks
 EIXgECQo3jx8Nt31J6Ns+ljRlLUUCfvUIp1lnnUOgp0RpLYJ8XiEIYnr8/HFIjpz
 vLEpPw3D57WicLWpDum4A3wr+NewDDzWGXPcKEbgSMfbblEGNAhSYaPxPtOMMXSP
 AQSTgz56E4mFH1rFt1oUGQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7vm5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2024 20:58:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 484KetxJ036694; Wed, 4 Sep 2024 20:58:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41bsmakxx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2024 20:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy2DduGOSSpsh7Hcj8jG6BGgPlNn29vSsFnM7OsNLYqfXR5georzYZCcT0oYk14rAbwNLZjIZJRyXSCq2ZVcqb0YkrfcjGuY0qTFhIwkjSjyWJpLt7RnQw6fUeijaJYcYS9nbYTFeJoM01pdKWVcUa5kguHXpZLGWoNmkIytzbWe0gSy2XhlMj15f3dgsJj5c7AzJxuhgKa4IhkotI+4W9LUtrbab0UKtTWLfECTx/rW9xqp/d+CDVkR2m327RPW+ggBdHL8LGpuUIRHsxF6cTSbPZLpIRTlcg73FCU1Ag7+bLZDH893rWRDfakEoUoNHxAW9HEHl9kSvm/+Jlx/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JScAbAjqiU6Mp0fssYeqlKNgirqEy981aekxhs35HBw=;
 b=WH1W4riZNVBAf3Mev8IzqPvdT8EXDhQq9WjPc6CntDX+loIgZSHV9c1HXJ7vf1bUyZT75atZM+igBh+yeepmvxqe37NRrs89dJ5/p15qVnLNapp0fvwFWSHVPYa2q+KckggrII9TSK4Ua/OZPhPVytqAyVu/uAcBKcS0PrTFKvJKztBquWi9v8ARDVCoH2rl5xQZgVxSUyEsX5JLiGSxfyJ59XnBwznlF7J/wrHDhqlQLlQxlt1DR/Nshmc2larAnub6/xz999IjbHpfNaRhG+sae1xmqFE1HeLx/4QyuPqKxeKayZ8xRplqW6MSIU6c3NVQmsG/UxEjjM3tMKAsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JScAbAjqiU6Mp0fssYeqlKNgirqEy981aekxhs35HBw=;
 b=u3/5d49u2vLLocA1WXJ4lIQogObdzgYsOzjkMqq7E+he1/r0gKBTd2SmpkRfRqtvJ481HCqq1gKAzRHCjaCu6K4NKEnbfTLg2ac/6qjr7maRbVeSREqwwiiPdy9qWfcq1yG+tfeHxj6Tl3PIFO7Cmu1qq8KSw7RlxClWKbj9p2k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6264.namprd10.prod.outlook.com (2603:10b6:930:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 20:58:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 20:58:19 +0000
Message-ID: <e1284027-6860-460c-8f3c-5b9c34e2c351@oracle.com>
Date: Wed, 4 Sep 2024 16:58:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com> <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com> <Zr9q4muKZmYCf9mv@x1n>
 <Zr9tYsmy8j2t8fq0@redhat.com> <Zr9xcmUfkYAWnXH-@x1n>
 <Zr93oOn9J5JLs2Rn@redhat.com> <Zr97ms6Ur9HH_EXG@x1n>
 <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com> <ZsYzIN5pM9Ad_DYn@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZsYzIN5pM9Ad_DYn@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:207:3c::48) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: a06e11e7-d3e9-495b-52fe-08dccd244e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3JUQnlob1ZCbmYvVSs3N081Y0wweEZ5TXRaRGlBdjhUK2NXaUxLamsrbmVB?=
 =?utf-8?B?L2wxTWhaVk1sL2xkVnJmT0ZHV2ZIV0xRa3FBc29mcklvc1RZYnJhV3IzalFu?=
 =?utf-8?B?SzY1VnY1U1hnRVhrWG5hM2ozbXhIcTQ2VW5JbG45a2I3aFNWY3lmU1BkaFdw?=
 =?utf-8?B?eVhZQXI5T1RRNko1czNnQ2txa3JuN1drSzVFNGNUc0ZUbGNUQjNCaWtEUU04?=
 =?utf-8?B?Rk40a1M3VnFncStzRXpRRjZjbUxmaCthaGsvOHVNampoNWJ4d3k2eXhBTGhO?=
 =?utf-8?B?VjVqZHVOaUdPclQ3MWNLRTl1Z0p0VGZKcWJZR0xESFNrWW1hRmdJc2lUb0RB?=
 =?utf-8?B?cFJ1Tm1YUVpuVllVVzNXeHF1bGtqWDQ4MFlsN3B2SVl4SFhtOUJubGJJZWdk?=
 =?utf-8?B?M2UyY200VC9uZzE4b0hwUjkycEVKdHdobFdZeUYycjlpSkZhQjQvUTdPYzRI?=
 =?utf-8?B?NFN2azJGS0RPWWRMMUpoS1E3U3dwY2Z2cmR6S2ZRd3RlUXYyeXd4Nmx4Q3lP?=
 =?utf-8?B?SG4veHVsOGYrZXRMTVNaSWFwZWNrVkQvbkNVRlFHRXY2QjhscW83QmJMbnhq?=
 =?utf-8?B?R2s0RXRlSVB5L3NENEM5N0tLYmVTS00yWkxWRDdnNlhhVGxVU3MvdU5hNER1?=
 =?utf-8?B?V3dMellwNGVNb2V4bEZ6ZjBRTTJPTnlCd0JEcVRTUy9rMmlqQ1BEcmU1M0tT?=
 =?utf-8?B?QzVRSFVBZm0vN1FqS1lGTjNOV2YvSjhacitwOHZuRGFaNFZPeVVBTjh6STN4?=
 =?utf-8?B?Q1kxaGNHQnNhdVJjaGNkRGVkSXBpNGlxRnhObmRUNGNtODhnclgxRkMyNDg2?=
 =?utf-8?B?Rm9nM09nQmpQb1dhc1JnV2c0VVdCZ1JTUTc4OVZXaEJqcEg1N1NKTUFwU2dp?=
 =?utf-8?B?MlUrelN5Ly9WYVdrWkdzT0V1cnZLcHAzWWwvMVIvU01Sb3J3RFcvTmp3b2Rm?=
 =?utf-8?B?OFR5Z1hLWm1zYUVwMzlWRy9WNFVKdG92OWdMRk1KaXdWaG1HODdlTmlsUkxn?=
 =?utf-8?B?ci9pQUcySVhnM0tJZFdva09icDRvVmsvOUtuVjRubk51ODhGbHkxUFV0MHlY?=
 =?utf-8?B?b2JrcWEvZnRBWXphckdWUXNncUh2UnBXQTlTRmNtNERtb0RsZ2dFMVJNazMx?=
 =?utf-8?B?OWJXU25PaEJQbzZScHQ1RE5NSUd5NkVFbCs0TGxDanBEdTdWNG0rbUJzTEhl?=
 =?utf-8?B?M2FKR2lsNDlTeWtEbHNCQ1JOQmROWFpZZ3dEWnJOcU9NUEpac1E3Z2dPR3Ju?=
 =?utf-8?B?ekJWOWtIWWdnSUpoRFBHRzQ0ZWcvMWw5WE1WU0plNGNoTGY5YkpaeVRPY0ll?=
 =?utf-8?B?WS9DU1owNXk5YmFLQTRKNStjYXFibGZBNmtERTZZNlRKY08wZVNTd2dabjcv?=
 =?utf-8?B?d0FFTG9melFxQVZtT3R6K0tJai94blZKQ0R2eDVjQUhIMmpEQU1aL25uVS9x?=
 =?utf-8?B?RXJjcHVmUGU3b0lsMTMzVmNmMHpBTEZWWmg5UUcxU25qaHpuNVdtck9PU0VG?=
 =?utf-8?B?azc0TUxIYWpJS2MyNWh2cFVyMENLdGFSeTczQSs1RkF2dWFlRkM5YUhycE1J?=
 =?utf-8?B?ckt1UDJvRExxQm5KZnJSTEdyS2tpeHpPeHkyMXhqa09uTDh2eHkvek84UDR1?=
 =?utf-8?B?ejBmYVNjSk1JaFkxSHcxUG5vN2ZTcmlGM3FwMUxyWGJWcTQ5Z3JNemI3eUlD?=
 =?utf-8?B?ZExnNVIydFp3blJEVlZOZnZ6cjlEMCt0MzVPeTBEcDIrTXFEOUNIaUNMOUNE?=
 =?utf-8?B?UUMvemRmdlgrMmNWSDN6enlyd2kyWlNjTTVIdjhmQzZna0RTaS9zZzRRZS96?=
 =?utf-8?Q?1h53zqsbIh49JP67omcSvIsPY4UN6ZwfL4x0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3EvcklYWmxONTBWb3NyS2pEbEV6ZVZlbDdsSXRZVzh3bWVMa0JhaUV3VU5H?=
 =?utf-8?B?MEJjOThRY205WFV2WVR2Y042OGQ5SFJrOWxVOXZiQmZ3S0JzWk5ISUhwM3gy?=
 =?utf-8?B?UUZIVEs2NlkvNFZ5UVhyMmlwY1pvZWpVanlqUlQ4Zk0xbmVrWi9UZHpWNHFm?=
 =?utf-8?B?bUhFSmd0OUJ2dkJmMmVqUDkwb29XcllCQ3N3RVJGVWhHRitZT3RNV0c2cDg5?=
 =?utf-8?B?Q01BUnFpbDh0N0dERnJWVkhNN2tFZFE4MEJZZmM4bjg5cFhxNFZidk1zeXQ4?=
 =?utf-8?B?WmV6dVF5aS8wdlgvd1NzUDgyRm04NkdqanRaTldpRUc3SHhuc2ZEc0NCaE5N?=
 =?utf-8?B?SnZ3cGduakhBZk1wZ0x0YWNsZGUvU3pjeldBdDAxaGszU1BVdGZjNTMxTWxi?=
 =?utf-8?B?QTYxYlZBMjFMZXp3VmFzSjN0Y3ZPUmFTamFISkRGTll0RmMzalZNUjArZGVv?=
 =?utf-8?B?VUJhMmlBWGdGSzh3eWc5ZmNLbzJWMzc4N2pvR1JoZjRJenkxb20vS2d0VUJP?=
 =?utf-8?B?SmEvUEFQSVl6K2J3clFpYjJtbGxYVW54ekJPZFMxdFFIVXdkVWZnazVpSkZz?=
 =?utf-8?B?cm1XSWNZNlpzZ2s4NzZjekFOYzVWSkFjZXQ2TDhPTWFOZWk1Z1hkMHVZaW0y?=
 =?utf-8?B?UEFMZG40Ym1HVmZJTUVjZlgzT3ZtcExsOW5weGJxckZ4WllnZ1VjRzJhY3RR?=
 =?utf-8?B?ekdkemJQdnY4N3lkUmo0WThFaVljc0diaGNNdmYyMnpGaFFvTmMzSzNVNkY2?=
 =?utf-8?B?QTl3VUtuWFZweDdXaVBOeG1VYitPL0R3M3ZoWXgyakZtNjE2S0diakNLY2lw?=
 =?utf-8?B?M3d1TXJXR0NWK2FSL0hKTkpCNjRIMHFJTzdBSmpBOWRHWGEvQ2krdDdKUkRK?=
 =?utf-8?B?WnJCZDE3OTBTaGFzTGRyT2MyT2VCVDRJSGZUQW5VMXhoVktxbm5uWWovTnB5?=
 =?utf-8?B?WVY3dVNjdWtZWDFTZ2ZLVnFCRzNmc2pRbU13SFZBYVhQVnJLT2ptTUZDYjAx?=
 =?utf-8?B?SFgycTZMRFc2cXc3V2syTjIza2xMQnp1c3RkRkVLU09Uc08yR29HNVgxZDYw?=
 =?utf-8?B?QkpaMlU1RktmTlZ4SUM4RzNnbzFNa2ZOVElGUU10cTJNNk5TWlBUajlNMDdP?=
 =?utf-8?B?V2lnTmsrL2EyZmFrV24vQVlEeXdveU5GdXlOSHZxaFVXeHlNZ0JFKzdlMEw1?=
 =?utf-8?B?cllra205ZHFXOTNVOTdzQStIRlZPYWVWVHcycFNYVklhNlRSRHVONkZmSUd5?=
 =?utf-8?B?enRob1cwd255MkZLZ1Z2dUttMUNVbzdiNUhtSjFDdmYxR1ZrK2tlTGFUTUxy?=
 =?utf-8?B?ZnRZWEM0SDE5YW5iUUV0c2JreUQ0SkR4cW40OXozQzlSMU93bjFVMG1XL25h?=
 =?utf-8?B?Rmt0V3Vkc3RKUGN6MG1sczhkVWN0T2VYWlNhcWRRdERpaWpLWEdXUXlRZEtS?=
 =?utf-8?B?eXpOTzhHL21pUWRuSWVIcEZsRlBEMnJPTE1McXpjMEI4U2kyOE5zMTVHeGlC?=
 =?utf-8?B?UWlXbEplZ2xMTUVmaHZhZUNxRG1zQ1p3MjBuK1h4d1pRVXg4RW5mVDQzZUxU?=
 =?utf-8?B?V25tUXdIMkM4SWMvOEpqUmtCQitTK0ZaMnRTTys2c01QU0ZFeTkvOHJ0QkJG?=
 =?utf-8?B?MW5jakQzQk0zT1dqdTF1ZW9lNHNDUCt3bTUyNXNITDRSRkJwOHNMMFp5ZWpS?=
 =?utf-8?B?blRBSUFNL29QWG5xck1IaVpTTG0rU01vQkJseU5jR2ZxZ2NMZjdsTU1HaHdG?=
 =?utf-8?B?MmdrMS8vNHcrbURNVVp5Wk8rb3NicldBK09SaVUzem5vTUdyclkrSEhicGVt?=
 =?utf-8?B?NHdUby83NWkvKzJxakluOWJCV2ltenQ0NGNxOUh4TFk0UVBuckdmQkdrKy9h?=
 =?utf-8?B?SW1odFlHajZ3aldiMzVlL2VyWnpFS0lVRGpPTkpGYVZGVHNzWDd5TTZpRXVM?=
 =?utf-8?B?c2UvTit2RXQ0RjFLOEwrZW0wd0NxK1UwUk1CcmJuYXI2aVI3TUhhR1VZamdi?=
 =?utf-8?B?WHJjOXlaVHh3bHVFMmlLRkpYdVhwK01jakhHN0QzQzBMNVVCWW0zLzFMSTdI?=
 =?utf-8?B?U0hMTEh0SG56RkFyTGRGdUlzZDVYc0FzVlBFakxaK1hxeC8wb3FPK3RSbFNw?=
 =?utf-8?B?all0dXZlelVDZzhuaXV1OExhWUpKWlpiSWZ5S1RrNjdSOEp1SGRJLzRTd0lF?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0yZ1i9XngNTAAEgxXwT0nEj6tQSN6Lv5Mg2PlmGJMPtA4UwU8qtey3HBWIDs8pky/cp8CsCEp1Rzy/9Jjs6HGNRW/7W8VQfe7BQlGEMf58bkVeOcUWZqgHQsyU+fC+wOWUXXb+p0whqgoidtSOxtDEiam22jfqoxdBUclI2uNIGLnoqn2e/JU0uQ8D9bEPXAGhYufaCeDszqjZtgq+RiECUYefEWvTak+MiJJoYrpbRaVRos8Q7qtcgedL8QPhYJFIaie/gnOC9SQUZPYgn1jNN71/zu5aU6h0/Pm02hsQ8jiz0+MuWwrAK8fF65A5qHYrobMSKzM22nFLa+ig1IfpcZRhzsVvA5pUBUPvvmfCca+/vIUTqJWt+0O1t9qjsM4L74GTkvA9xDJgTkolG+am7hG39i7zatbKeNPC+rZWpKVC3Lwao2cB2kniizkHM25fiQBcLXzM4G7/WN674G4SZw5jkVQSHJnnaQWD0eItOOFGOuYLbjRGu1UvtgTk1WvTw3JNT1D0nRaE3JxhPFSfwXQKgi3lv7eRxJVd35M1BkmIswgub5OF47usrUNBZwfGNvx6EUGZWuZifSUtR5HKxOykoarAwSsJDgc47HWkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06e11e7-d3e9-495b-52fe-08dccd244e62
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 20:58:19.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Y6hDI+x4jTQ4ff3T1suaBKf17GTDXUmzYso00L+5ape3Ih/nOrRNJ2pvV87YiZ/4wWG8kobxw5atAzyQ28RrCuBlJlY+6ow3lacUvGBW4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_18,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040159
X-Proofpoint-GUID: 4IwByhCeAGzQD-O_S917ijDzZz-jgqbk
X-Proofpoint-ORIG-GUID: 4IwByhCeAGzQD-O_S917ijDzZz-jgqbk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/21/2024 2:34 PM, Peter Xu wrote:
> On Fri, Aug 16, 2024 at 01:09:23PM -0400, Steven Sistare wrote:
>> On 8/16/2024 12:17 PM, Peter Xu wrote:
>>> On Fri, Aug 16, 2024 at 05:00:32PM +0100, Daniel P. Berrangé wrote:
>>>> On Fri, Aug 16, 2024 at 11:34:10AM -0400, Peter Xu wrote:
>>>>> On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
>>>>>> On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
>>>>>>> On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
>>>>>>>> On 8/13/2024 3:46 PM, Peter Xu wrote:
>>>>>>>>> On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
>>>>>>>>>>> The flipside, however, is that localhost migration via 2 separate QEMU
>>>>>>>>>>> processes has issues where both QEMUs want to be opening the very same
>>>>>>>>>>> file, and only 1 of them can ever have them open.
>>>>>>>>>
>>>>>>>>> I thought we used to have similar issue with block devices, but I assume
>>>>>>>>> it's solved for years (and whoever owns it will take proper file lock,
>>>>>>>>> IIRC, and QEMU migration should properly serialize the time window on who's
>>>>>>>>> going to take the file lock).
>>>>>>>>>
>>>>>>>>> Maybe this is about something else?
>>>>>>>>
>>>>>>>> I don't have an example where this fails.
>>>>>>>>
>>>>>>>> I can cause "Failed to get "write" lock" errors if two qemu instances open
>>>>>>>> the same block device, but the error is suppressed if you add the -incoming
>>>>>>>> argument, due to this code:
>>>>>>>>
>>>>>>>>     blk_attach_dev()
>>>>>>>>       if (runstate_check(RUN_STATE_INMIGRATE))
>>>>>>>>         blk->disable_perm = true;
>>>>>>>
>>>>>>> Yep, this one is pretty much expected.
>>>>>>>
>>>>>>>>
>>>>>>>>>> Indeed, and "files" includes unix domain sockets.
>>>>>>>>
>>>>>>>> More on this -- the second qemu to bind a unix domain socket for listening
>>>>>>>> wins, and the first qemu loses it (because second qemu unlinks and recreates
>>>>>>>> the socket path before binding on the assumption that it is stale).
>>>>>>>>
>>>>>>>> One must use a different name for the socket for second qemu, and clients
>>>>>>>> that wish to connect must be aware of the new port.
>>>>>>>>
>>>>>>>>>> Network ports also conflict.
>>>>>>>>>> cpr-exec avoids such problems, and is one of the advantages of the method that
>>>>>>>>>> I forgot to promote.
>>>>>>>>>
>>>>>>>>> I was thinking that's fine, as the host ports should be the backend of the
>>>>>>>>> VM ports only anyway so they don't need to be identical on both sides?
>>>>>>>>>
>>>>>>>>> IOW, my understanding is it's the guest IP/ports/... which should still be
>>>>>>>>> stable across migrations, where the host ports can be different as long as
>>>>>>>>> the host ports can forward guest port messages correctly?
>>>>>>>>
>>>>>>>> Yes, one must use a different host port number for the second qemu, and clients
>>>>>>>> that wish to connect must be aware of the new port.
>>>>>>>>
>>>>>>>> That is my point -- cpr-transfer requires fiddling with such things.
>>>>>>>> cpr-exec does not.
>>>>>>>
>>>>>>> Right, and my understanding is all these facilities are already there, so
>>>>>>> no new code should be needed on reconnect issues if to support cpr-transfer
>>>>>>> in Libvirt or similar management layers that supports migrations.
>>>>>>
>>>>>> Note Libvirt explicitly blocks localhost migration today because
>>>>>> solving all these clashing resource problems is a huge can of worms
>>>>>> and it can't be made invisible to the user of libvirt in any practical
>>>>>> way.
>>>>>
>>>>> Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
>>>>> supported local migration somehow on top of libvirt.
>>>>
>>>> Since kubevirt runs inside a container, "localhost" migration
>>>> is effectively migrating between 2 completely separate OS installs
>>>> (containers), that happen to be on the same physical host. IOW, it
>>>> is a cross-host migration from Libvirt & QEMU's POV, and there are
>>>> no clashing resources to worry about.
>>>
>>> OK, makes sense.
>>>
>>> Then do you think it's possible to support cpr-transfer in that scenario
>>> from Libvirt POV?
>>>
>>>>
>>>>> Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
>>>>> to consume it (as cpr-* is only for local host migrations so far)?  Even if
>>>>> all the rest issues we're discussing with cpr-exec, is that the only way to
>>>>> go for Libvirt, then?
>>>>
>>>> cpr-exec is certainly appealing from the POV of avoiding the clashing
>>>> resources problem in libvirt.
>>>>
>>>> It has own issues though, because libvirt runs all QEMU processes with
>>>> seccomp filters that block 'execve', as we consider QEMU to be untrustworthy
>>>> and thus don't want to allow it to exec anything !
>>>>
>>>> I don't know which is the lesser evil from libvirt's POV.
>>>>
>>>> Personally I see security controls as an overriding requirement for
>>>> everything.
>>>
>>> One thing I am aware of is cpr-exec is not the only one who might start to
>>> use exec() in QEMU. TDX fundamentally will need to create another key VM to
>>> deliver the keys and the plan seems to be using exec() too.  However in
>>> that case per my understanding the exec() is optional - the key VM can also
>>> be created by Libvirt.
>>>
>>> IOW, it looks like we can still stick with execve() being blocked yet so
>>> far except cpr-exec().
>>>
>>> Hmm, this makes the decision harder to make.  We need to figure out a way
>>> on knowing how to consume this feature for at least open source virt
>>> stack..  So far it looks like it's only possible (if we take seccomp high
>>> priority) we use cpr-transfer but only in a container.
>>
>> libvirt starts qemu with the -sandbox spawn=deny option which blocks fork, exec,
>> and change namespace operations.  I have a patch in my workspace to be submitted
>> later called "seccomp: fine-grained control of fork, exec, and namespace" that allows
>> libvirt to block fork and namespace but allow exec.
> 
> The question is whether that would be accepted, and it also gives me the
> feeling that even if it's accepted, it might limit the use cases that cpr
> can apply to.

This is more acceptable for libvirt running in a container (such as under kubevirt)
with a limited set of binaries in /bin that could be exec'd.  In that case allowing
exec is more reasonable.

> What I read so far from Dan is that cpr-transfer seems to be also preferred
> from Libvirt POV:
> 
>    https://lore.kernel.org/r/Zr9-IvoRkGjre4CI@redhat.com
> 
> Did I read it right?

I read that as: cpr-transfer is a viable option for libvirt.  I don't hear him
excluding the possibility of cpr-exec.

I agree that "Dan the libvirt expert prefers cpr-transfer" is a good reason to
provide cpr-transfer.  Which I will do.

So does "Steve the OCI expert prefers cpr-exec" carry equal weight, for also
providing cpr-exec?

We are at an impasse on this series.  To make forward progress, I am willing to
reorder the patches, and re-submit cpr-transfer as the first mode, so we can
review and pull that.  I will submit cpr-exec as a follow on and we can resume
our arguments then.

- Steve

