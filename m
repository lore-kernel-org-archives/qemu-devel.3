Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E41C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDqw-0007Er-GY; Thu, 06 Mar 2025 11:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqDqr-0007Dd-4y
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:13:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqDqn-0001J4-9z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:13:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi6Vd007638;
 Thu, 6 Mar 2025 16:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=WKKHVi0wkxLYqlOhgZf83X/eDoXoNoOp9aNHLCn+LvM=; b=
 HnlPCVfdpMf0worHTfmaxfti7Bfru8KSp5FyCZVhJYB1LXnQJVnxoKGAuf4E+nKM
 Z2DU11TcwjAlV67Le3+6/eU5awW9EaGdN8hGU0R0koc1zhOhggeHLWREOAew+xJl
 BsHuLQkBpUEvmU66i5QV7qmBm+HFYi1Q3rxfbP9hqWvz+u1jRNH+Ma+Ns+vVRp9o
 Z0HNuNJtitERNlLftJaYXsxcgG4uWXt/pTl+5RuCVJyyeIe1H3vXFoTqidCANx2C
 kchiMb8JKbP/ar0kD+F+fVyTti78Jk7Kr7eUlOPdgqsa8GyZAURGUzvdOar4C9pe
 Qz0LnnyZNEXWUoyEkzRCag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u822gjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Mar 2025 16:13:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 526F3n2Y003199; Thu, 6 Mar 2025 16:13:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpcadj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Mar 2025 16:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfX2HDd9cmWQgnU3CsHsQqqUvEGLLGlk/jY8+EGYfKPVIm0O7G3N7jQhTWXHfqugdsArUjjb6mkIeH9Bjz4lo95Hg0YlQEtzxxKyECfy22hi4eM5+Hbfk2OfVifWhk67DgND7fycqDO3ETtmDrfRmowaC5nQ8S1njr7iw+dIahjpjDNiARM93FxuEu5DrNHdoPUHBlu8oWlzqF5X/GnRuST/m9eMWYJadTWEewdyIoRHI89k8uheIVmEqdCn8NQgLs7hSh10YrJ9GbnqFeIQ8KT/z6r12nk124qsyoke6LB5WLic0ZB5kzZpL9/65VKRbe0WoASUpUhgNa7I9hznnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKKHVi0wkxLYqlOhgZf83X/eDoXoNoOp9aNHLCn+LvM=;
 b=XefevxH/FVPAKfIDNWME6Sb/LavnxNZbZR1z8BbSJXkOwzwbWmDW9yzD+05toHEZ2ErrtqXbHF2JxVgCTbDszDT/IX5rXL9IYSRG6mveVbhz8nsvSFdn2UjQttqd6w4Xu+lwPbiOzocTYzSq5+3NbX8wLuttnfBYr+4UXP6O5QWqbuM6vIL4CUTcdo6D2KflVvc4nXXvwch0qYE+4uPub8NEd8C/02U+/KQSIkHWsSVeurznHcLdffASlLbg9oAXAMnFwCEGgzogWXgaqBxeu/MAfUxFW1fNMGNDqprAAVuMS+Io+VOkh/MskeF1H9wLLVOhzvlC8gFcsAfYVkUpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKKHVi0wkxLYqlOhgZf83X/eDoXoNoOp9aNHLCn+LvM=;
 b=oxhAROfJW+B84ij31+3BssrVDhbGerZDD4A3dyPoiT6DgVdloWTuI1u8S85q/YCKQckHkeS1/dnjX0ML3bfzQ2cobWnmiZrMeskzJc0GYxFDnXx6MzZ8YonKYNctNxz+WKlMiAByXfZIpGOou9T6NbL434SQoLI2e163G6YShIU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4830.namprd10.prod.outlook.com (2603:10b6:5:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 16:13:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:13:25 +0000
Message-ID: <849106e8-1e4d-4a0b-8c79-6988b4cd8b0b@oracle.com>
Date: Thu, 6 Mar 2025 11:13:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: "Denis V. Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
 <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
 <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
 <9f3fe262-fdab-4c01-9117-e9795444fe20@virtuozzo.com>
 <24677eb1-dbe6-4e0a-980b-9c38d4decde8@virtuozzo.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <24677eb1-dbe6-4e0a-980b-9c38d4decde8@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4830:EE_
X-MS-Office365-Filtering-Correlation-Id: 725cc3c8-f334-46ff-d1dd-08dd5cc9d2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHA4aE9IYUNLcytTS1lZQ211SmVOckxKQnBpa0FuenliMkZ1RTBLSk5EcXpt?=
 =?utf-8?B?MVlBSE5nMkJUZGo3di9VbTFieklEUWhleVVQNkw4S1RGMkNTZ3FhdHptUGFE?=
 =?utf-8?B?ejNKY0JHczdsMHNzR28vTWVOeWU3Z3dKS3ZCZXhzZW1TK2NmS3p0UW5IMVlw?=
 =?utf-8?B?bkFpNHhMR2ZKV21XM2p2Wnc0R0pHek5VQmlNV2JEVzJ3Vmt4cWtYT3A4ejRI?=
 =?utf-8?B?d2x0dHExeHVjRXlLSWRVekJ2TGxETVM4R04relpxakFFQ0ZxU3BsQjRRaWRy?=
 =?utf-8?B?L01obnRrWCsrUDF0c1dDeVFBc0dUUWxLSGtmS3c3TkppcGNFa0dhZzhTU0hZ?=
 =?utf-8?B?Mmg5ejdsNmg4WWU2RzYzdG9DazVLQ2tWZ042R29HYklCTEJUZkhuRG9jOVJ2?=
 =?utf-8?B?TlgyYXF6UndWWTdYSmRCb2dXVlpWVTFUQTFld3BzT3ZOM1VwUWFSRUF1NDR1?=
 =?utf-8?B?aEl1WnJ1M08yMWE4bysrTXplbFVRMUJmTFFReTFtMG5rdGtkYkZDQitsdVJ4?=
 =?utf-8?B?TlV4QzExaERqelQvVHRxQ1NzSkpkbTRTOHAzVnVaS1hScjREYThRaUU2bEVa?=
 =?utf-8?B?eTJTYjJhN1N1RFFDWTR5WEFWZkFIRFNTZTJMVGJQdEZXOVV5R1NXM21Dc1ZH?=
 =?utf-8?B?NEY4OFJXTHdITEJoYnZJb016SERKdy9QWE1ZVkdHWEVOMFhwVmhhTklVZ0FH?=
 =?utf-8?B?RWR0TTVpYWxuaUN6RXlpNE85SmhpTW5JR2c5OGZoMkgzK3dBU1IxdFYrNlBv?=
 =?utf-8?B?SVd3RUNBbHh2YVVPSTBmdUh4M3pMSVoyYWdHWVZteWRqUndpUGdHNElOR080?=
 =?utf-8?B?akxnaWtVY1VsZ1dkRThya1EyTVBYOG53Tm81NTVEUVpIblJWZGJPbkd3NnlL?=
 =?utf-8?B?WmNidHNNOC9NOFR0MTlSZXF4MEFSdGJUNDJRQktBSElqajVjMzU5Q3lOcHd5?=
 =?utf-8?B?R0Zka2xwZWxlSyttSURnclhvakNETlMrWHFiZC9tN3B2RTZ0VlAxaDZmbkxm?=
 =?utf-8?B?VlJjaFdsOFIybVJMVXlDRVZnTXY3M3VGK3lMWUFaeDNhamdYZ2RzbnlHODZo?=
 =?utf-8?B?UmJuUVU1WXhqbzk2ekI1RUNsL1hhWGNiTTNhSERRcXFPSW1nZ2dYRlBHaHZn?=
 =?utf-8?B?WDBYUHY2SWNtckc4b1QzdWYxM1RmWGhUaDUyc0JBT1VuT0piNGhVL0ZySVdW?=
 =?utf-8?B?VHYrbXE1ck5ZRzFpeTZ5WEUvMlByN1hhS0dNbElvbWUxaVVqNEdYajFHckdX?=
 =?utf-8?B?alp6QzM1aS90NUUzMld0d0JHZFUySXZGN2hGYVpDTWtXcyswamxwbnA4azFV?=
 =?utf-8?B?c092bXlyRWxPNkFCQnZybGh2MjlZbmpzSEVSTXRWaklGWmF5Ym9WbS82eVdE?=
 =?utf-8?B?REMwUm9lYitQUUd6aVAwTUVQU0wwVVJOU20xV0REWmNjNFZvdW9tb1JGMXFR?=
 =?utf-8?B?MVJiN3lvZWVUaDZkQ3E3NkVPYXVhVktOMWRUa1BNVkR1MHJxQ3pRQUlZQmpP?=
 =?utf-8?B?Nm1YczllM1dsNmRKdGFTdHY4elVJbzY0M2d0OUJYdGdPeUdDd0pzYVpWcXRK?=
 =?utf-8?B?ZmxTT0FzamZZUEpxUFl4VXlBa1ZCRndZbnZQNlpPLzlLcGdBbUttQ0wyckJ6?=
 =?utf-8?B?S3lEREdZS1I1K2Zudm5RZ01QU3lCUzlWTitRMittUlA2Ni8xVUZJMndldk1N?=
 =?utf-8?B?OWR5RDRxc2ZWd2dRaDhPSmF1Y1ZSMGwzMEFjSVNlL2RDNFpHTmcwK2FaUklx?=
 =?utf-8?B?NFZWbHJ2Snlvano5eFR1Y0VjbElPemt5Snp3bkw2UmV1TEJURmhNeHZ3bDdO?=
 =?utf-8?B?TDZXWGp5ejlzazI5anNBQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1gwVStIT3FVdkpNZ0FFUFNhS29aaDlBVHZ4RW5BVWdwTm16OEpsS0ExQzR2?=
 =?utf-8?B?SGNQVTVTZUpETnBKQ0Q2NEF2ejYzUTNRa2ZodEtWL05LMFlkS3dYSmgxQUJN?=
 =?utf-8?B?ZSsxTlJFd0hMSGJ3MEhOam9nbGhieFFlK3JWYzNPN0FISE1HeXFZMFFrRm1h?=
 =?utf-8?B?bGF2WVI4dC8rbkhvcW5PUnZGK2Jwd2tLTXN0aDhLdUpVSENEeFdlejdYZkZx?=
 =?utf-8?B?ZkZDaFFGUi9CMmVrNnYxZHZQMUNIZFFIN2RTeEVmRGVCN3I1RklmUjlIYSs3?=
 =?utf-8?B?Q25QeTRkc21oZWhUSDVTRnZUZUdZait4M2lpVUVqcmhZbUIyNDRmdGg5eHNH?=
 =?utf-8?B?LzdRUm01UjAvUitNQU1OYW5mSmtwRlZ0a3JjR0toMkhRQnNYcVI3bE9SdU9U?=
 =?utf-8?B?azhTN285RjFmN2xGb0Rab1hyRUV6eGtyZzNVRThUbkw3VXVDNjFYSUh3d0pZ?=
 =?utf-8?B?NmJFZ2ZmdUl2VEJOdVZzSXhmek83V0oxUVNBQnoxemdBZ1h6RTZabk1kbVFm?=
 =?utf-8?B?TlZVZjlaZE1YMnhjWXM2WTB6b1Ewb3MzRUhjd0tqb3Q0U0hXN0U1TmJFWnkz?=
 =?utf-8?B?T0VhRjNBQktNc3E4TDBYeEIzN0owVmMvT0UwdSsxRW1pRS92THM4TjNLby9G?=
 =?utf-8?B?QTZVSlNxMHorSmpuNXZjb3NLcktTMU1Vb05sQUUvdTFDL1lxNS9UM0k4TndY?=
 =?utf-8?B?Y2F5KzJnOUVxYk9mVy9handSVEd4ZzV2YXFCMHRZeCtWa1hpY3RidzZuckh1?=
 =?utf-8?B?TWFEa3dsOFM2QzF5UWo0TnNVY3FNbEdzZG5TUnFNdzErOWx0Q2VGTmpySGRm?=
 =?utf-8?B?ZDdzTVNpcnFBRVdGd2dUbFMxQ3NzUnNqV0VOZ3hrZDIrQXZUNFM3ZUlwbDl4?=
 =?utf-8?B?SXZtQ0c1UU9UeitOVWlIcFhtTHdEYUhmUHEzM0R0ZXljOVkrUHRjZVdIazF2?=
 =?utf-8?B?ZkpaanZXY29lMGF4SGdhVytQWjFZZStYQW43VHBmbDAzbnFoYnU4TU1WVFJQ?=
 =?utf-8?B?eDRUakFTSnFJaDBaOSszMHlUSXQ5UnhLa25hSElOWnJGUTNXY0FFKzVxc1ZG?=
 =?utf-8?B?YkEvMk1NVjRXeFNEdm8wdGRtemtJVmNHS1dyQy9LZ01KZjFFTFIzeWZmV0hY?=
 =?utf-8?B?aENVR2xWaUxhbktybThreGlpbFlGcWlla2hRVFdmendwcXNFVEJNTHF1b1A1?=
 =?utf-8?B?K0ZNa05hSjU0T3VLaTZHS3BvS0FKNHUyOW15eFQ5Sk96VE1GYmI0ajRvamZT?=
 =?utf-8?B?aVQrV2VVUGJHQlNlN3JPbHNhTWMzdjlYdHl3K0FxaDFsOFZja09Gd0MvYXVI?=
 =?utf-8?B?RHhWM0cvalBzTjdXUGQrNU12dGRTR1d6NkpKRE5BbHFiOFB5WmRIU3liUXhk?=
 =?utf-8?B?VytQcWJCZ0YxQ2tmSXZlK3h6WkpUaEgxMTFvYTJZa1JYMzJKazBwcUluaHFU?=
 =?utf-8?B?eHc0UFM5ZG5xZHVCankxL0tyRWh5OTVac2w1WU82VkFxN0NTclovbDRWY28v?=
 =?utf-8?B?ZWE5Sm16MlBPUmtyV25kTzY4Sjlwa2ZGeXJPUzk5VWZrQzZqczI3L1IwQW5Q?=
 =?utf-8?B?aGxMUC9KYjZmZUFFbWFmUXRqd2RVb1N6N2hvYmNpN2k4RS93UlR5MmltbzNC?=
 =?utf-8?B?NXFmR3pYdVRyMmN5NWNtT2drYTdWUDdEYXc5Rk9pMDR4STVoZFJRUmQ5MlRO?=
 =?utf-8?B?Q3c4OEdENjFxSWJ5QVV0WXNDT0pZYmI4QW9VZ1kwZnlzcldsYmEvSHY0QzFn?=
 =?utf-8?B?QWtYNE1pRm5HZTg1d1EzYnNuWWo2RDk4eFJRQ1dwV203ZFNqckJQMHM2bFZL?=
 =?utf-8?B?T21URGdoelM2Z0Rzb1luMlNNVFZGOW9NcEFGZ3dwdHAvV1QyZmd2Z2xoRDVm?=
 =?utf-8?B?N2R5WkRSZlEwcW4vUDdqeTByTEZYMkx6Vm03K3dtdnczUGdJdUFkV2tGb2Rm?=
 =?utf-8?B?MjE2S1JLblNrdVRBNnZZcldaZmt3QWMyOXdqS3d5VWgvdWFDUHQwM25xTlov?=
 =?utf-8?B?QnZsNG42Qy93cHhDVGZ6RHlLTUtNSnpaVXlxNDdvQnpQYWxERGJ4WEtVUVYy?=
 =?utf-8?B?aVVtOWxIYTVpVHgyTExianAvRklsVUJNc1ZHdzQxK3BCVzBFZHl1aGx3L2Jj?=
 =?utf-8?B?Y3RLYUdKYlhibWxOdm9OVVZyc1RLMmlMYmVTcEUydFNvR3VGd0dYY1g3Zk40?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gxtXd2jsN18K3k5WQeKSWvV7R12wJ7G7m9XtUsfkMNw5AfapyTyPA/hEB2TCD1pp324zckmw1RYN1CA6CUVEbwptgS4O0BAjzKeSXx1wITm1NmdQO1GAfXaS61eTBpaTwjfLMI7P+Q8rvreHhiLIS+W6mu5SKqvo5IUGJdyMAHBb/vf5cdxS7phIjQlpXI6eVwxjhJcU4t5JlRIo8P0WrRNd0sDf6DLVk2j8cWz7RyfylUT7jAe7khr60193GTDkPux1mkDCnDcVVSj++kNfgysEQ6dzy/yTX1zCWWtRzOMs7ArrCcG0NJE0vYkin0nmLXRSI1suRlMwgphpF1zNHacSscxe6QoBSKRZwv0YTtZRyn75e03FWdwNETjPKSu2kLDY5QXASxCzmJ5msY6N4lERok9iIgf9GUTnB8TbX67SOq9yCZ/hqkAQalW1BAm8pYKm6ll06ybF2zEk5+uPuxEJ2jK7vxx46sjvJFTN3DTbcE8Y7zJe4bVGWgX2qD3t9wCusw5XWPhYkdjs3DRkAf5tuyjcs6nMIDT5cBZaggiOOhwj3PoBDKqZJPje8igjoJmOu8MQZxUEOQ5/aSLkCIpJJL4eNVYtfJ2EXDmmxEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725cc3c8-f334-46ff-d1dd-08dd5cc9d2a1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:13:25.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqRDtBxeUXcRYcrOg5lfz5Uap6ALcBQNpoetrIP7gIVi38opMjkpXWqOdkE1ZPDyjuzIyxMtDKWV1KmZfmwkGAX2WRxHV+P5KfjGDSgE+Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060123
X-Proofpoint-GUID: kaCqteXea9mxXPGlNiToXjUwuaNv11lf
X-Proofpoint-ORIG-GUID: kaCqteXea9mxXPGlNiToXjUwuaNv11lf
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

On 3/6/2025 10:52 AM, Denis V. Lunev wrote:
> On 3/6/25 16:16, Andrey Drobyshev wrote:
>> On 3/5/25 11:19 PM, Steven Sistare wrote:
>>> On 3/5/2025 11:50 AM, Andrey Drobyshev wrote:
>>>> On 3/4/25 9:05 PM, Steven Sistare wrote:
>>>>> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>>>>>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>>>>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>>>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>>>>>> Hi all,
>>>>>>>>>>
>>>>>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>>>>>> and
>>>>>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>>>>>
>>>>>>>>>> Run migration source:
>>>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>>>
>>>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>>>         -machine q35 \
>>>>>>>>>>>         -cpu host -smp 2 -m 2G \
>>>>>>>>>>>         -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>>>> dev/shm/
>>>>>>>>>>> ram0,share=on\
>>>>>>>>>>>         -machine memory-backend=ram0 \
>>>>>>>>>>>         -machine aux-ram-share=on \
>>>>>>>>>>>         -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>>>         -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>>>         -nographic \
>>>>>>>>>>>         -device qxl-vga
>>>>>>>>>> Run migration target:
>>>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>>>         -machine q35 \
>>>>>>>>>>>         -cpu host -smp 2 -m 2G \
>>>>>>>>>>>         -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>>>> dev/shm/
>>>>>>>>>>> ram0,share=on\
>>>>>>>>>>>         -machine memory-backend=ram0 \
>>>>>>>>>>>         -machine aux-ram-share=on \
>>>>>>>>>>>         -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>>>         -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>>>         -nographic \
>>>>>>>>>>>         -device qxl-vga \
>>>>>>>>>>>         -incoming tcp:0:44444 \
>>>>>>>>>>>         -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>>>>>
>>>>>>>>>> Launch the migration:
>>>>>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>>>
>>>>>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>>>>>         migrate-set-parameters mode=cpr-transfer
>>>>>>>>>>>         migrate channels=[{"channel-type":"main","addr":
>>>>>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>>>>>> {"channel-type":"cpr","addr":
>>>>>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>>>>>> dst.sock"}}]
>>>>>>>>>>> EOF
>>>>>>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>>>>>>> following messages:
>>>>>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>>>>>> 0x00000001)
>>>>>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>>>>>>> allocate VRAM BO
>>>>>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>>>>>> min_halo@163.com/T/
>>>>>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>>>>>
>>>>>>>>>> (the latter discussion contains that reproduce script which
>>>>>>>>>> speeds up
>>>>>>>>>> the crash in the guest):
>>>>>>>>>>> #!/bin/bash
>>>>>>>>>>>
>>>>>>>>>>> chvt 3
>>>>>>>>>>>
>>>>>>>>>>> for j in $(seq 80); do
>>>>>>>>>>>             echo "$(date) starting round $j"
>>>>>>>>>>>             if [ "$(journalctl --boot | grep "failed to allocate
>>>>>>>>>>> VRAM
>>>>>>>>>>> BO")" != "" ]; then
>>>>>>>>>>>                     echo "bug was reproduced after $j tries"
>>>>>>>>>>>                     exit 1
>>>>>>>>>>>             fi
>>>>>>>>>>>             for i in $(seq 100); do
>>>>>>>>>>>                     dmesg > /dev/tty3
>>>>>>>>>>>             done
>>>>>>>>>>> done
>>>>>>>>>>>
>>>>>>>>>>> echo "bug could not be reproduced"
>>>>>>>>>>> exit 0
>>>>>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>>>>>> that
>>>>>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>>>>>> lead to
>>>>>>>>>> crash on the source VM.
>>>>>>>>>>
>>>>>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest
>>>>>>>>>> memory, but
>>>>>>>>>> rather passes it through the memory backend object, our code might
>>>>>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>>>>>> corruption so far.
>>>>>>>>>>
>>>>>>>>>> Could somebody help the investigation and take a look into
>>>>>>>>>> this?  Any
>>>>>>>>>> suggestions would be appreciated.  Thanks!
>>>>>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>>>>>> Try adding these traces to see what is preserved:
>>>>>>>>>
>>>>>>>>> -trace enable='*cpr*'
>>>>>>>>> -trace enable='*ram_alloc*'
>>>>>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>>>>>> compatible with cpr.  A message is printed at migration start time.
>>>>>>>>      https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>>>>>> email-
>>>>>>>> steven.sistare@oracle.com/
>>>>>>>>
>>>>>>>> - Steve
>>>>>>>>
>>>>>>> With the traces enabled + the "migration: ram block cpr blockers"
>>>>>>> patch
>>>>>>> applied:
>>>>>>>
>>>>>>> Source:
>>>>>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>>>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>>>>>> 0x7fec18e00000
>>>>>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>>>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>>>>>> 0x7fec18c00000
>>>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>>>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>>>> 262144 fd 24 host 0x7fec18a00000
>>>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>>>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>>>> 67108864 fd 25 host 0x7feb77e00000
>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>>>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>>>> fd 27 host 0x7fec18800000
>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>>>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>>>> 67108864 fd 28 host 0x7feb73c00000
>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>>>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>>>> fd 34 host 0x7fec18600000
>>>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>>>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>>>> 2097152 fd 35 host 0x7fec18200000
>>>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>>>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>>>> fd 36 host 0x7feb8b600000
>>>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>>>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>>>> 37 host 0x7feb8b400000
>>>>>>>>
>>>>>>>> cpr_state_save cpr-transfer mode
>>>>>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>>>>> Target:
>>>>>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>>>>>> cpr_state_load cpr-transfer mode
>>>>>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>>>>>> 0x7fcdc9800000
>>>>>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>>>>>> 0x7fcdc9600000
>>>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>>>> 262144 fd 18 host 0x7fcdc9400000
>>>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>>>> fd 16 host 0x7fcdc9200000
>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>>>> fd 14 host 0x7fcdc8800000
>>>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>>>> fd 11 host 0x7fcdc8200000
>>>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>>>> 10 host 0x7fcd3be00000
>>>>>>> Looks like both vga.vram and qxl.vram are being preserved (with the
>>>>>>> same
>>>>>>> addresses), and no incompatible ram blocks are found during migration.
>>>>>> Sorry, addressed are not the same, of course.  However corresponding
>>>>>> ram
>>>>>> blocks do seem to be preserved and initialized.
>>>>> So far, I have not reproduced the guest driver failure.
>>>>>
>>>>> However, I have isolated places where new QEMU improperly writes to
>>>>> the qxl memory regions prior to starting the guest, by mmap'ing them
>>>>> readonly after cpr:
>>>>>
>>>>>     qemu_ram_alloc_internal()
>>>>>       if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>>>>>           ram_flags |= RAM_READONLY;
>>>>>       new_block = qemu_ram_alloc_from_fd(...)
>>>>>
>>>>> I have attached a draft fix; try it and let me know.
>>>>> My console window looks fine before and after cpr, using
>>>>> -vnc $hostip:0 -vga qxl
>>>>>
>>>>> - Steve
>>>> Regarding the reproduce: when I launch the buggy version with the same
>>>> options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
>>>> my VNC client silently hangs on the target after a while.  Could it
>>>> happen on your stand as well?
>>> cpr does not preserve the vnc connection and session.  To test, I specify
>>> port 0 for the source VM and port 1 for the dest.  When the src vnc goes
>>> dormant the dest vnc becomes active.
>>>
>> Sure, I meant that VNC on the dest (on the port 1) works for a while
>> after the migration and then hangs, apparently after the guest QXL crash.
>>
>>>> Could you try launching VM with
>>>> "-nographic -device qxl-vga"?  That way VM's serial console is given you
>>>> directly in the shell, so when qxl driver crashes you're still able to
>>>> inspect the kernel messages.
>>> I have been running like that, but have not reproduced the qxl driver
>>> crash,
>>> and I suspect my guest image+kernel is too old.
>> Yes, that's probably the case.  But the crash occurs on my Fedora 41
>> guest with the 6.11.5-300.fc41.x86_64 kernel, so newer kernels seem to
>> be buggy.
>>
>>
>>> However, once I realized the
>>> issue was post-cpr modification of qxl memory, I switched my attention
>>> to the
>>> fix.
>>>
>>>> As for your patch, I can report that it doesn't resolve the issue as it
>>>> is.  But I was able to track down another possible memory corruption
>>>> using your approach with readonly mmap'ing:
>>>>
>>>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>>>> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
>>>>> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
>>>>> (gdb) bt
>>>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>>>> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70,
>>>>> errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
>>>>> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70,
>>>>> errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
>>>>> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70,
>>>>> errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
>>>>> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70,
>>>>> value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
>>>>> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70,
>>>>> v=0x5638996f3770, name=0x56389759b141 "realized",
>>>>> opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>>>>>       at ../qom/object.c:2374
>>>>> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70,
>>>>> name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>>>>>       at ../qom/object.c:1449
>>>>> #7  0x00005638970f8586 in object_property_set_qobject
>>>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized",
>>>>> value=0x5638996df900, errp=0x7ffd3c2b84e0)
>>>>>       at ../qom/qom-qobject.c:28
>>>>> #8  0x00005638970f3d8d in object_property_set_bool
>>>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true,
>>>>> errp=0x7ffd3c2b84e0)
>>>>>       at ../qom/object.c:1519
>>>>> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70,
>>>>> bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
>>>>> #10 0x0000563896dba675 in qdev_device_add_from_qdict
>>>>> (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at ../
>>>>> system/qdev-monitor.c:714
>>>>> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150,
>>>>> errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
>>>>> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0,
>>>>> opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/
>>>>> vl.c:1207
>>>>> #13 0x000056389737a6cc in qemu_opts_foreach
>>>>>       (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca
>>>>> <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>>>>>       at ../util/qemu-option.c:1135
>>>>> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at ../system/
>>>>> vl.c:2745
>>>>> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40
>>>>> <error_fatal>) at ../system/vl.c:2806
>>>>> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948)
>>>>> at ../system/vl.c:3838
>>>>> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at ../
>>>>> system/main.c:72
>>>> So the attached adjusted version of your patch does seem to help.  At
>>>> least I can't reproduce the crash on my stand.
>>> Thanks for the stack trace; the calls to SPICE_RING_INIT in init_qxl_ram
>>> are
>>> definitely harmful.  Try V2 of the patch, attached, which skips the lines
>>> of init_qxl_ram that modify guest memory.
>>>
>> Thanks, your v2 patch does seem to prevent the crash.  Would you re-send
>> it to the list as a proper fix?

Yes.  Was waiting for your confirmation.

>>>> I'm wondering, could it be useful to explicitly mark all the reused
>>>> memory regions readonly upon cpr-transfer, and then make them writable
>>>> back again after the migration is done?  That way we will be segfaulting
>>>> early on instead of debugging tricky memory corruptions.
>>> It's a useful debugging technique, but changing protection on a large
>>> memory region
>>> can be too expensive for production due to TLB shootdowns.
>>>
>>> Also, there are cases where writes are performed but the value is
>>> guaranteed to
>>> be the same:
>>>    qxl_post_load()
>>>      qxl_set_mode()
>>>        d->rom->mode = cpu_to_le32(modenr);
>>> The value is the same because mode and shadow_rom.mode were passed in
>>> vmstate
>>> from old qemu.
>>>
>> There're also cases where devices' ROM might be re-initialized.  E.g.
>> this segfault occures upon further exploration of RO mapped RAM blocks:
>>
>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
>>> 664             rep     movsb
>>> [Current thread is 1 (Thread 0x7f6e7d08b480 (LWP 310379))]
>>> (gdb) bt
>>> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
>>> #1  0x000055aa1d030ecd in rom_set_mr (rom=0x55aa200ba380, owner=0x55aa2019ac10, name=0x7fffb8272bc0 "/rom@etc/acpi/tables", ro=true)
>>>      at ../hw/core/loader.c:1032
>>> #2  0x000055aa1d031577 in rom_add_blob
>>>      (name=0x55aa1da51f13 "etc/acpi/tables", blob=0x55aa208a1070, len=131072, max_len=2097152, addr=18446744073709551615, fw_file_name=0x55aa1da51f13 "etc/acpi/tables", fw_callback=0x55aa1d441f59 <acpi_build_update>, callback_opaque=0x55aa20ff0010, as=0x0, read_only=true) at ../hw/core/loader.c:1147
>>> #3  0x000055aa1cfd788d in acpi_add_rom_blob
>>>      (update=0x55aa1d441f59 <acpi_build_update>, opaque=0x55aa20ff0010, blob=0x55aa1fc9aa00, name=0x55aa1da51f13 "etc/acpi/tables") at ../hw/acpi/utils.c:46
>>> #4  0x000055aa1d44213f in acpi_setup () at ../hw/i386/acpi-build.c:2720
>>> #5  0x000055aa1d434199 in pc_machine_done (notifier=0x55aa1ff15050, data=0x0) at ../hw/i386/pc.c:638
>>> #6  0x000055aa1d876845 in notifier_list_notify (list=0x55aa1ea25c10 <machine_init_done_notifiers>, data=0x0) at ../util/notify.c:39
>>> #7  0x000055aa1d039ee5 in qdev_machine_creation_done () at ../hw/core/machine.c:1749
>>> #8  0x000055aa1d2c7b3e in qemu_machine_creation_done (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2779
>>> #9  0x000055aa1d2c7c7d in qmp_x_exit_preconfig (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2807
>>> #10 0x000055aa1d2ca64f in qemu_init (argc=35, argv=0x7fffb82730e8) at ../system/vl.c:3838
>>> #11 0x000055aa1d79638c in main (argc=35, argv=0x7fffb82730e8) at ../system/main.c:72
>> I'm not sure whether ACPI tables ROM in particular is rewritten with the
>> same content, but there might be cases where ROM can be read from file
>> system upon initialization.  That is undesirable as guest kernel
>> certainly won't be too happy about sudden change of the device's ROM
>> content.
>>
>> So the issue we're dealing with here is any unwanted memory related
>> device initialization upon cpr.
>>
>> For now the only thing that comes to my mind is to make a test where we
>> put as many devices as we can into a VM, make ram blocks RO upon cpr
>> (and remap them as RW later after migration is done, if needed), and
>> catch any unwanted memory violations.  As Den suggested, we might
>> consider adding that behaviour as a separate non-default option (or
>> "migrate" command flag specific to cpr-transfer), which would only be
>> used in the testing.

I'll look into adding an option, but there may be too many false positives,
such as the qxl_set_mode case above.  And the maintainers may object to me
eliminating the false positives by adding more CPR_IN tests, due to gratuitous
(from their POV) ugliness.

But I will use the technique to look for more write violations.

>> Andrey
> No way. ACPI with the source must be used in the same way as BIOSes
> and optional ROMs.

Yup, its a bug.  Will fix.

- Steve

