Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42CBEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 19:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so6u4-00032S-53; Tue, 10 Sep 2024 15:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1so6u0-00031F-04
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:51:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1so6tx-0001mF-9C
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:51:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNZGE032612;
 Tue, 10 Sep 2024 19:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=6HJNgAsH3enWhV8aphcQinmAni/Oyd0PcllyjIcyPTg=; b=
 WljZpWGoo9C9zgPEQc01z1eq0kYjMnKiuXb1NeBpTTaxq/oWm/RpIlUV00G3n10q
 Xd4pEKYrhm9m48Fc7257HAED70Alv++b0bgvBNGbpsNVaqzBeGnZGro683uWWeqm
 fyzhpesEAoGff6jdrVOqEpnLInaBFbm3AUWcPQT6w8EDUpWdN308oLk7ZV+hlFxi
 T1yjPZ1IyACY40IkAg0fD+KKjyBXqCtpqf5joY9qwuE0ziadaqMPl0FJIkKr5WeN
 xM9zUFZdH0O2zmCdyjdwywKWtgOeUVm/CPl/tgVZ1ZwGzdINMRMVsNrBzPF1qGZ7
 rWvisOsvceDDiBGIdVMUmQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9pgk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 19:51:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48AJl5ZS004165; Tue, 10 Sep 2024 19:51:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd992rky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 19:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC00yH1vWWyx6qMXZA3X0bxkvQKPDs50ar/CaTDeg60MTjsv0t4i8gGekTc6XHiR284IKfN+Dkv83lkJnvOu4Gy8CcBXtfmZpaiqtthL8I+ssURNrdyPKHpGmyzSPAhdhFoRgIIA+2PpIgJFSWVpf3Q3Yg0/65mSWcuDIP+ypmtS7e9X1EHnE0KC2fDGMusXtYgG99+rfzeDwtDXLGotmb4SFCmEPevJ95Tme9PlMxv8wOinZUtxmsiCfBBltAiwRO1dxceNtxbJ7XdquXyLYGBphllztq0/hTgHZaeTQz2JO3/xKajl2P6tkNEUq0EYSJTKKzsUMAkKuqGPnE09Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HJNgAsH3enWhV8aphcQinmAni/Oyd0PcllyjIcyPTg=;
 b=SYlq0rYxQorg5EObWwZBet//9JyR24ivCGc11U+wu+Px9hW8yJCwjKhMNfVVgUvzIvlPZ9iECFcEk8sRZ1ZMWp4e671Bm3nx0AEgXlhS0PePnzxycJSZdZSbYdAPbmXBNcQDfuStUAou5gLJhpaiibu1I/BuSUYcSXDEzo8Nf+cV/KcedwreELBiLY3uGUHV6SKc671thFIjEYfmBj/SzEfwBR7J9UrVEyY1PvCx35XY32LO8m8sAT8rytR8wYbjKSUNsgudTqjQNkptZJSmlqVmcbq2rJ4LvWAoiwyLh9cgtLw75ZdPDcXH1YE8DJ8ds2we5cmEJE/zzq3wuPX/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HJNgAsH3enWhV8aphcQinmAni/Oyd0PcllyjIcyPTg=;
 b=VV7Hj4Zm6G+KCVh97QDrF3P7kvsODQT0bxm+7NNNXrNda53hm2NkPi1n6x2ZlSV4Cws1U7kHVVtOWHj3kkvt77QERx4D63o6g4rgIGOPRo4huznsYCMsSQIri7mA1/dFd1XdpEbTaFgAG/wB7zNprMnvW2u4LhHyVAj6XQh5BcI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 19:51:43 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 19:51:43 +0000
Message-ID: <329e22e2-9cfe-4004-8b28-1aaff79ab350@oracle.com>
Date: Tue, 10 Sep 2024 15:51:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: no hw_info for mediated devices
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
References: <1725990021-107183-1-git-send-email-steven.sistare@oracle.com>
 <73f10bc0-5e3f-412d-8e2a-44d013c4b7ba@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <73f10bc0-5e3f-412d-8e2a-44d013c4b7ba@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f0806f-7933-4564-023e-08dcd1d1fedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STJZd0NLN1loRnY1UEd3UFB4ZS9CcXJuYTdTNVVlVFlZOGl1QkFKaHB6UERa?=
 =?utf-8?B?NlUrMG5NNStkb1hsWitXcjRscXhJcDlaVnNGWlZzTUdrcFBtZzEvZng3cXVW?=
 =?utf-8?B?QlZHQnBoQ2c2aUVsK1ZyTStJQmlaTFIyY0Vib093RnU3UVNzV2JsSEZpVVFu?=
 =?utf-8?B?RXYrMi9URVRPbTFLWUN4cGFTRjEvZ0ZIenhWL1ZmekFDU3QvSUQ3aE9NUWJB?=
 =?utf-8?B?NlhCdGx0amVUbVhwMWdyYUgvMzdkL0xFLzQvWmxjUzYrYVpUQ3Y2NjdEZFpO?=
 =?utf-8?B?SVJ4NnRJbU8yblFySWFhK1dTejdBV2I3T09Zc3BYVERtYUFIMFQvTlFLYkJV?=
 =?utf-8?B?OGYyYTVXOGtMdWRONEtBNGZvYXpGSkxYMHdaQWNIK0lVZkNoTGNPM0ZUMExl?=
 =?utf-8?B?TWYybEVkQm1DMGlFdjlUODBqL0pRbjAvMFd0VVZjQ0MrMkFsZkxlMzR3aHhT?=
 =?utf-8?B?OGhoalQ4eGw3dWs4MDYrTm1acHVJMkZveUNTdnNpZmQyWm94KzlRVUhadWVj?=
 =?utf-8?B?bVdOekhRd2tFNVZIcURhM0QrWnNBRW1jSm0xVWJJV2Z6WjY4WSswd3haOTFm?=
 =?utf-8?B?cEJkU2RtZzlpaFVEb3V0d1ZjK1dMNHBLYmxYVERuU0o5MGljNEN1aXpDNXJt?=
 =?utf-8?B?bCtHTWtxcnBNcDR0OGtKWG1aUFhMb3pkSHZpT0N4NVNXdjd1VTVaRE5zdE9a?=
 =?utf-8?B?Vzc1eDlGYmhjekFOVDBQbjVxV3E0Y3lVeGEySm1LNGtHZlpqRDE2RkdJZFZ3?=
 =?utf-8?B?N1VMY3RLSXVaazN0U2pEeG9XWVVOZ0FDa2VCTDFtcFJWRGplZ0FHWlQrcGp5?=
 =?utf-8?B?RWFoT1QrbTBvU2QrVG41TzgwTlNudVgrcmovSlVCL0FwT0IwWVhqRHNqYmcz?=
 =?utf-8?B?ampXci8rOXExNGlTeE5PSFVDRUtpLzRXMEVmUHJsNGdpTzkyaHI5RklzaStS?=
 =?utf-8?B?ZkRabmp0MVJvZXY5dXJTZXQ5Umd5MXlQT2xOVkwzU29SNzN5NUxLVzFHd3Yr?=
 =?utf-8?B?VTR4S0EwR2FhbEc0bjMzQjIzNzJNeE5tVUg3V1E1T09aU2s2aFdLSGNpcUht?=
 =?utf-8?B?NjUzY3VmZklPdlR5TWdJcmxUVDczU21HcnB6ejF1UFZTczZwRmlSYk1pSDgz?=
 =?utf-8?B?ZFVpMDhHSVRvUmtaUEo2eTRqd1hRQUxxSk9OdU5kdUlRcUxud0dhSDJ3cGtr?=
 =?utf-8?B?eFlXWnFyM3JCQzZ6SUduMEsyOGdkNTZDdjBuSHE5WW43bWhhOUI2SlVRR3cr?=
 =?utf-8?B?N1ovalZVTC9jK3B0dVBBajh5TW4rSUQ3SVZ0MEdZenZtTmJZYm1sZ2NaVXB6?=
 =?utf-8?B?OW8zOCtUUVpyNE5GWFZXR2JJTlVqajY2ZW0zbTRxKzJGSlYwQ216cmFVWkly?=
 =?utf-8?B?bUMzTjlJRWhJbVl3TEtadXNHM3NJVlJnL3Z5a2R6anNQb1EyTHA2M2FmK0h2?=
 =?utf-8?B?VmtXL1dtdXl3SURuTzVEMnM3Mi9RWlNCMnlPWE4yT01EZEVQS3FPRjBYYWpP?=
 =?utf-8?B?QW9VSlplYnBuQXFtQnZ2OG90TjJJbGVSMlovM2oyOVVhZXRORTFidzJnbmly?=
 =?utf-8?B?ZVBRNlBNQUZZdlp1M2tBRFRESUh6TVpCeHBPRXRIUDRpMDkrMEg4YnJJMmhu?=
 =?utf-8?B?OEt5YUtXQVRPbjRFMmRmTFVJd2F5WW9SNUFpTGRSR2huVDkwb0FJN1l6cjlu?=
 =?utf-8?B?cGdER0RzVFlKZnRRNXdjNGQ4ZFdtQkRWZ09jeFlJVjNsaGpZTnY2a2NRaDFP?=
 =?utf-8?B?RjJrdkFyQnJDR1hCUkNLc1FkTWxiUno1VndKS2tncW1TenJkRVZvNHN6Yk0r?=
 =?utf-8?B?N2hRcDQ3LzBDQ2V4akFCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVVtenB5QmpGZHhWTHV6SmZFRDZtQ0JJZGZFNkU0VEF0VkZ5blIrandlbmFh?=
 =?utf-8?B?S1QwVUdDZDlWWFRLZmVCdzgzSEhESE53elBFYmZGd21ONm4wSStyQmpvQmJw?=
 =?utf-8?B?OTFWOFNGNkxoOTZUblp1NXBPMUZncHdKRDhyYjArcTFaWlhLbFUyMTRzRUxY?=
 =?utf-8?B?VnUzRzh2N1RybCtqbjJaTFRJWE1CbC9tQ2dDRFY4ZmtRckd2SVV3dkRVOUdp?=
 =?utf-8?B?WkFpem1GUUZCZkNLRS84UmZBQm1wbGtjNGkvSGJXTnR4TXI3bTROUk1xeXdx?=
 =?utf-8?B?YTBuTlNQbDhxUnBMUGVqcTRlVXNGM3FJSVlLTit4OXBYUk5LeW1zR2psalNi?=
 =?utf-8?B?alVzNERjYml0M1l4M2xOMHFDbjBlbXd1eWJnbGNrV0V1UGlrck9sdnBYTTFT?=
 =?utf-8?B?bTBJZHVsaUxEcU5RTXlQR3hxSFZrWmFGaUQrMFlvZjNBMGRhbVEyWHJvZmFM?=
 =?utf-8?B?NEhLQWtUVTdIMmFBT2piQjNZM3FMUmpaRnRzYnUwMFF5dFFEbGQxZFFscDI3?=
 =?utf-8?B?NUgvTDRXbWNycVhpMjFTT3ZVUkNJOGFSOGRkTVkrT1BiUVlJTzYzdXdLY1ZF?=
 =?utf-8?B?djN6N0lSVVFsZWlGalNIb0FSVjB4Z2hYa21yb25EVllESmc0NGl4dU5aNklv?=
 =?utf-8?B?NVo1ZXhBU05URndqTlcxU2lUZVV4eUowbGJLbVl2UkN4MmdKbnNQY0VkUG9Z?=
 =?utf-8?B?d0lqU0hjaE92OGVKeW1raktWQ3QxbldSUFJ2ZWVCa3h6bHplQjJiZkpOaTRB?=
 =?utf-8?B?aWNHSjNFOXNMSU1DMk03MFovbGxrc01yelFkRXBMTkh0U1pHckhLYWNVNE51?=
 =?utf-8?B?YWNoTzAyRk90UjI2Y0V2dkRKUXBhMlJRZjA2WFpkMVNzUFdkaURzUzVyczJu?=
 =?utf-8?B?dFB6c3JydmZLTEwrYzcwTzhmb01FUFpTYXV3ZUFrOC9sK3NOMzA1eDFwTGFK?=
 =?utf-8?B?bU1qS0xaUEJWMy9PVVYzbE5SOXJ5NTVTOGppbnVYdWhSbkVZTFlVL2hyd0ww?=
 =?utf-8?B?NUFJczc0dXhvMmNYWXdIUm13eUNlZHVVbXhkaTQya0Jld2RROVhjaU1SVUxF?=
 =?utf-8?B?ejluamErTkFJQitVeXFTV0F5Tk95cmxXUDhNUVdiMUZlSmw4SVdua1JlWlcr?=
 =?utf-8?B?TEJXeGV5eTlocVhBOGtaYS92Nk9wekUwanJnOWQ0QjA5U0tIeGs5dTIyN0Iv?=
 =?utf-8?B?dWwwc2UwQ0RGS01GZytnSjlhSTdsenFaRW5LYmQrYzZxVmd2eEV4bWdzeGNF?=
 =?utf-8?B?aDA3R2MzOFpwWDBJNUxabVRXSzhWMVpvYlBobXBlSFBrYnFneGtWN2Q5MmhQ?=
 =?utf-8?B?K1JsZVpKOWY1SmZPRU9UYjFLUVhwd0wrZWI1eUtzdTdCZTI5a015L1l5MXlH?=
 =?utf-8?B?c0ZLeUh5UGp6QXVyb04rb1VGbnhVVzhxNjNuRm5tbWRhWTZjcjF5QVdQQXlT?=
 =?utf-8?B?a3p2LzIvSktzcEl2cStaVm81Z2FlbkpVanRyU1cwSW5IVkZGYytVRnZEa0M1?=
 =?utf-8?B?c0tGY2RKQUR4RUlqeGIwRDZjRVRlNVNBL2M1dCtjL09JbTBzOGZOZnltbm05?=
 =?utf-8?B?R0wxNU4ycTkxQ25oeStKZmxhMXBWbGZFZ255dDM5UythOXFuYWUvQTFaQVBD?=
 =?utf-8?B?ZHd5d05tY205d1R2YzMvQmd0WWVWUUpOYjJMR3dYQTVlemFEdlJDTXRvRWl4?=
 =?utf-8?B?NmJnNlNnTjVxdVhGTXdWT0kyWWtJYmZvUmhlNktQZ05wKzhTaW84YjZ1bytF?=
 =?utf-8?B?N1g3N0RFcm43VTcrUHYwZGtYcnlKSWNGZG94Mkdja3E5MHZvMld4aVBPWUxD?=
 =?utf-8?B?R3VxTUJGUDB1RXB4ajZVdHhOS0RDZVF1ZTBrYWpqRFNKc2dGdTJWSlIvTkpy?=
 =?utf-8?B?Rkg0N3NwK2RjcnpIdFRXQzdzVGhSRzB4KzJIN2ZNd2FvYVhqQTQ4a21RMnNk?=
 =?utf-8?B?N3IzNDg2NXpNMFUrU2lTdVpDcDhUUEVrSUJvc2hpRTc1bnJLbWkzcnp5Ry9s?=
 =?utf-8?B?bDdZZ2I0UU5yZTY5N1lCUDRDckJWRFVsd2x1ZVNmc25KYTd5MkdtK1YycGNO?=
 =?utf-8?B?UzBLTzNwVVM3SCtPVzNXMWlURG4xV2dZUkJXd083clUxNFFUMnhrYWhXdHlX?=
 =?utf-8?B?R1RHK25lRVZoSGFScng5SUMxNWxBd0dvZlpzS1BaTUFtZEkreDVpZ201T1Jw?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RsK3mZmlXDnoQvlsWdnF/StIzAHiBL+OFYk5Mp2vtTlbfQFVNTH5hgjKUUxaP/b0HCYLxO5kTKR5AIX2qZWcgSHwxzfKupmFY+Wrc29pY23fLVZg2c7EJk4P1Gi00h8R/4osVjQ1VQcAmnZo/eW36rD8QkI3iYqLkHA7sqOhDXqupDdfVa1D7AG9rgkGkOHdjimxc0eWb/Fh2Xw1Sw1lWmLfxrmVYKZ4OIT2znTpVr1X3meyykDZ5wgHopiSNl9cRlVZu5PT6Lul7DHpkC5N/1BADykCCEfkcAA6XteeYXgf6OOAeCWpr4VXrcDq8AOq3K3N2JvM/OwCXzkpJkwySid2DU74isqsCHqaPly0Z8TTNDuEj1SLt5LIECPOAeSjZ5l0xeoo0SL456ehUa0jIDMcMVaPbXQqwUstOyfQtXoTdiE+A83NJsB78dJ/72VMiKeLz6OfqxlqmWggnpnMFh+t9xI/cM9fJH/knqqL5Gg28nay2Fw66me73ZH2UJI2QEYgStXDO8ZpCIabxZjsunjBSp+CK6sVPXJyU8MBpwX21ryYo113JCf0IUULrboLWRZ4DSI9bdCydeykAHhRXKvxXm7Uuil8Aq5CMi7MoRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f0806f-7933-4564-023e-08dcd1d1fedb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:51:43.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HY8YHkmnzNfElayxRrcO4MkVYdtoLCznNfB0hKmynsOSMC+Aqy4tletREu6Oa4CzaAJcthIJ3/V4ge1J3XKnFwRQPuiUfK6nHn8OU1KCnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_07,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100147
X-Proofpoint-ORIG-GUID: lkehPEEsYqUW0udlAUOc7HFKiZ-AQ9Zm
X-Proofpoint-GUID: lkehPEEsYqUW0udlAUOc7HFKiZ-AQ9Zm
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/10/2024 3:29 PM, Joao Martins wrote:
> On 10/09/2024 18:40, Steve Sistare wrote:
>> IOMMU_GET_HW_INFO fails for a vfio mediated device (aka mdev), because
>> the devid is associated with kernel type IOMMUFD_OBJ_ACCESS, not
>> IOMMUFD_OBJ_DEVICE.  Assume IOMMU_HW_INFO_TYPE_NONE and proceed.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
>> ---
>>   hw/vfio/iommufd.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index cb7257b..d8928d4 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -635,6 +635,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>                                         Error **errp)
>>   {
>> +    Error *err = NULL;
>>       VFIODevice *vdev = opaque;
>>       HostIOMMUDeviceCaps *caps = &hiod->caps;
>>       enum iommu_hw_info_type type;
>> @@ -645,8 +646,9 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>       hiod->agent = opaque;
>>   
>>       if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>> -                                         &type, &data, sizeof(data), errp)) {
>> -        return false;
>> +                                         &type, &data, sizeof(data), &err)) {
>> +        warn_report_err(err);
>> +        type = IOMMU_HW_INFO_TYPE_NONE;
>>       }
>>   
>>       hiod->name = g_strdup(vdev->name);
> 
> At least we aren't supposed to call realize() on an mdev.
> 
> See commit 9f17604195c ("vfio/iommufd: Don't initialize nor set a
> HOST_IOMMU_DEVICE with mdev"). There's another refactor later on in commit
> 83a4d596a93 ("vfio/{iommufd, container}: Invoke HostIOMMUDevice::realize()
> during attach_device()") where we also don't realize() when vbasedev->hiod is NULL.
> 
> Unless the stty mdevs aren't matching examples, then this shouldn't be possible
> (I didn't have one with real hw behind to test).
> 
> So if you are hitting this codepath then vbasedev::mdev is false, which I don't
> understand how it's possible?

I exercised this with the mtty sample mdev, and mdev is true:

vfio_mdev  (83b8f4f2-509f-382f-3c1e-e6bfe0fa1001) is_mdev 1
iommufd_cdev_getfd  /dev/vfio/devices/vfio1 (fd=26)
iommufd_backend_connect fd=15 owned=1 users=1
iommufd_cdev_connect_and_bind  [iommufd=15] Successfully bound device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 (fd=26): output devid=1
iommufd_backend_alloc_ioas  iommufd=15 ioas=2
iommufd_cdev_alloc_ioas  [iommufd=15] new IOMMUFD container with ioasid=2
iommufd_cdev_attach_ioas_hwpt  [iommufd=15] Successfully attached device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 (26) to id=2
iommufd_backend_map_dma  iommufd=15 ioas=2 iova=0x0 size=0xc0000 addr=0x7fb80f600000 readonly=0 (0)
iommufd_backend_map_dma  iommufd=15 ioas=2 iova=0xc0000 size=0x20000 addr=0x7fb80d400000 readonly=1 (0)
iommufd_backend_map_dma  iommufd=15 ioas=2 iova=0x100000 size=0xff00000 addr=0x7fb80f700000 readonly=0 (0)
iommufd_cdev_device_info  83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 (26) num_irqs=5 num_regions=9 flags=2
qemu-kvm: -device vfio-pci,iommufd=iommufd1,sysfsdev=/sys/devices/virtual/mtty/mtty/83b8f4f2-509f-382f-3c1e-e6bfe0fa1001:
   warning: Failed to get hardware info: No such file or directory

My qemu tree is a bit old, I will update and look for the issues you described.

- Steve

