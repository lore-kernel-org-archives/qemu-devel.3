Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7EECEFC24
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syC2W-0008Qh-Ur; Tue, 08 Oct 2024 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syC2T-0008Ma-JO; Tue, 08 Oct 2024 11:22:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syC2R-0008Rz-OU; Tue, 08 Oct 2024 11:22:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtcYn020504;
 Tue, 8 Oct 2024 15:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=oXJdVPL9L7takE6guObPCXGH1NfXTSFJ2LAw5pLM8Co=; b=
 HA/oePgB6eQwbCKSDntq5JzqTXqHGbzB/p8BW0RCYwhYNwtu8yx9nl2umfoFIyVU
 n+j8ynSWSRJReTkDsKUsQpsuij9Lo77vwmqRN8bDrobvsh5x+g7AMLsx4Fi30qKm
 +xxLs40A9taSPEugEdK61ANPdrO0Ye92g9GBA9OLJlWeps3/XOoIEeuxF/+tZ8pw
 FNj/jWSe1JzasQ+bSwxG/QnrDQ1Mdg38YFznenzKYNGoTL8W2ciOhBNHhXEug3PL
 Ler+djiCs5IwjAwZEbPnCQXPKfDRICN6oTf/oajkJ6PhfeVgdtUjhWN4Q62Ss1GN
 xIIv5gEfsBX7u1xvhkpcpw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063p2xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:22:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498E8Jxw012028; Tue, 8 Oct 2024 15:22:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7avqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSgVscTtS/aqGA1KQK0N9yDoph0ULaz98BNOhJpeoctLdpwPY6vk13P1WgspcG9RiJwuT2SToP3c/cLvhLK/tb+Mtw2kEO6nCKto5VX2lA0VFtk6tdhFjl7yuJ1lDWvTuMsxETm8uvQFwdx99c2NHAZ1ohlkWurRLdBRoF0IXL3XYu1OGccZyfOYcnVF/y2c9whCN4A9aIAAhdwsbKDDzQc0Xnn7Ez5sBQylGRYftknkzJwFcl5LodxZaOUZNpkcgiIxpSEuHvEMxAibZGloGBQYGU1mEQlBxKqjrrqts/t4n35m6tfKMZQQb1bBxSPF2y+AGI5Pfpv2+CvyXX6KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXJdVPL9L7takE6guObPCXGH1NfXTSFJ2LAw5pLM8Co=;
 b=T9ioakYRbWyswuX9E5py8JTX699aYo2FfikMsBjI4LZJGWDbnR6VMHfaBhIXL+p29Ky78/cnOK3R4ZsTsQUhdp0C27UBBGjQSjKJob1a5cOFW+VvFD1NTiz9Xphu4FW5EbvYW7uQLjCU2XkvtrK7GMmu5KCFdVU5zu1IhZ1PQ2jE0eWRJuzgRdoyVR1+L7XnOH2jzq4BFdycu7N86h4pxbuiyZWpXx2Aivlx9oU8GW1iF8tItWHaWB/klCzV0K+8Qx4XyBvjwsamBzVJZMwuZ5pvW/6k1LHqLCALNJlnKOZ3r/kJB3gT8JC2faW0nhvZd1y9RC18CV7CfJjAemwQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXJdVPL9L7takE6guObPCXGH1NfXTSFJ2LAw5pLM8Co=;
 b=Zb8wZDPPRyBeYPuET+QbYN+HAMzpq7L2FCIvCrWexy0ZuTv1IhO7nY40IAP9hrmMadQQuOEBt2jM2rFdESehTTQ8I6TqB9oYdzYcgZBdBYGXgQqWXSTJkga5OC3EEPO2KI7n6SOINQ+pnejRMxXx+jsmHBmJwEWljWN63NcmYjA=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 15:22:01 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 15:22:01 +0000
Message-ID: <a2ccd6d4-e296-4da1-bdc1-c3550d5698cb@oracle.com>
Date: Tue, 8 Oct 2024 11:21:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
To: Igor Mammedov <imammedo@redhat.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-2-annie.li@oracle.com>
 <20241007144449.457d304f@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20241007144449.457d304f@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: afdd5cde-3eac-45d8-0e41-08dce7acf4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEw4N1RKRVRxSmNFY1dSRE5OM1B6M0hkZ010WWlxNURyaDBkRFVwbnp3cGtr?=
 =?utf-8?B?UGoybytUY3BtRUVzREQ4dStaQUNmd0JRMDBuNlpQYXlpRmx2R0JHWEVGY0xT?=
 =?utf-8?B?M0hMQUJBb09yTkpQQ0Qwd21lTjJ6SVNjbGEvd3Q2V1VoMGxWTkN2c1kzWVM0?=
 =?utf-8?B?dVNzV0RUQXJvMlpqZy9vOGRNdVhlV0RlaU5nZXBVZ2JWTFoyc0szWEJnOWR1?=
 =?utf-8?B?azNyTHJGUm5vYkw3aE15TGJBRHg3Q3NqbitpZzRvd1lQdXEvNEk2K0t1c0ZF?=
 =?utf-8?B?SVMvZ2wrVk96RU9ram05U1M0YkwyMjJDdHIyTnQ1VkdhaWoyWjdXQlNwMDEz?=
 =?utf-8?B?c3RCVlhNbUJOdFZpWDFMODR2OTZoZU01SzNrS2lBYy9EbFpadnlxdExFOC9v?=
 =?utf-8?B?Rk9YeW04aTYzaGVGbFllNHZ5bk9Id2Z6SGNTUUlPbnJuNnh0c2d1cHdjbFRo?=
 =?utf-8?B?Vk9XQ016UFBVYmVuWXVKeTMzRUZKeURRVjdLaGFkWGVVSGgzNGxxWWZpMTdT?=
 =?utf-8?B?RGV4V2Q4dzBBVkdaWHd0dXFGVE5UdzdiSklRa1liYnN5UEZ6NVMxVGsxNFRm?=
 =?utf-8?B?ZE80YTVCYVpyTDlXeHRLMnFhMXo0NlZaRVJoN0d6bVpzQnAwNEUxMWwwSGor?=
 =?utf-8?B?K2lWZWN4KzNtcVoyOE5qSnpIbjVEVzd1dFhEWGJoUWRtVmtUM3RQd1U4SWZj?=
 =?utf-8?B?eDlXQ255ZmNtVkJQd3FqcWxmNGY2aTU5RElTZU1Yb2lJQkZBQXdYQitiOW1Q?=
 =?utf-8?B?NHlLTlpvU3hTSlVWajMvSUQ2blVZQy9TWnJ0QkViQUpEbzVxQXRtRTU4M0Zh?=
 =?utf-8?B?MUQwMExQVENuUlJENnJYREtGTFcwQ2UrT1FvdlVvWDZhKytvbVJvaEIxV2sr?=
 =?utf-8?B?S1dicWo0TFVyd3planMxdDZoZlAyZ0QyeVViM3FwUXp6dloydHhBdkRid1JV?=
 =?utf-8?B?bjdqcTE5NW0ycEVQaUhPa3UrWVZ6YTJuNFBpajhlUjVTWUY1QnB5WjhmTjBv?=
 =?utf-8?B?R1FVaVpZaVU5UGR3cXYwUHBab1N5MVNQbjB5V0lTTlZjaWMwbWc0dHhFOHNI?=
 =?utf-8?B?VUNVekZyM3A5TW0vb01IamdxQ3o4K0FZem1yOW5OaUlsUEtzRENDLzh4Q09Q?=
 =?utf-8?B?Y1RPZkU1YThtZDAreSs0Y0JpUFptem51cDNSSFgxUERZMzhLK3JEUU5UMnZL?=
 =?utf-8?B?UVg0ZjJrcFpWVFBkeFJpNXhiaWczT2Y4NFVHM3ZvemZXQVZCcis2ZytaeHJ6?=
 =?utf-8?B?Z2E2Q2wveng0bTFRWktkUDVIaHJ4eVdzYmlsVXJ0NWdmTFROQ1FHelFmNnkz?=
 =?utf-8?B?Z2hPSXl0K1lQMUZFd0tvMGcyMk8wWmJYTE5wOXpmaU0xaXBub2NwakZxcE9v?=
 =?utf-8?B?TXBRaFM1dzk3MEg3a0RhUGw4bm45OTYzMXNBQm1QdUhQQXNTcjBURkRZdkNS?=
 =?utf-8?B?OXU2b1NSak9qZE5kME85N2w4aXRZNHhRSkJXeWNTOUVIMVVsNzlkMWxwVjRE?=
 =?utf-8?B?aHRpTXN0b1RhVkdqSWU5ajdwSVhnaFBNMGh5YnFxRlhuOUdSVnZkZFp5RzFE?=
 =?utf-8?B?Q1JaelR3MUxSQXplM3lvVXRBT2wrWUhLUmdvRDZqL0ZCTXEvSmcxcHhlRGdr?=
 =?utf-8?B?NmIxaHc3M0lLQnc1Vk40aGFuVnFPY1g1RDdYVjFmb0lGTWg0cTY4R1NCR3RQ?=
 =?utf-8?B?VzR3SnlQY3c2Q1VqOEZTeTkzY0xSSjJuUlpxN2p6NFZseTRjMXA4anN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpIclBNa0ZFVXNwZ3ErSDFsQU8xandwUGp1MklEbnZVcFlQRFlJWnpheVZt?=
 =?utf-8?B?REROQnQ4SVZwQnZhN1dCYW9JTHcxaEhWVlJIZ0hPemRxOHN5bzdHc2M1cTdz?=
 =?utf-8?B?SStBSmZ6ODdmczFYVitCMHpZbHBXbk5wTCt0VW9qZkxHbmRMOGt6c1ZvMWFT?=
 =?utf-8?B?S2RYWjNYSjE4NEMvUTJKTDFnNE92WUVrZVNvb2JsM0tpak1objFkOWVyRkJV?=
 =?utf-8?B?ZVZiYm4yRkkxbVpTa2FqZEpyZzBsMytOZmFjVlhGMUpac3Y3MFZwQTlpOUNl?=
 =?utf-8?B?MjVjNUcyT2s2MjNmYndBMk4rUjVnTFhkOVEwaXNmNitDM2ZTS2Z6dUhCWUpk?=
 =?utf-8?B?aVJrYkRhWVRpU3BDVlowMFRGbWYveTBxVWJyMExKYTJuQ1hVK0k4NUlLVDkz?=
 =?utf-8?B?OXpxMGpJQmFUc015dHhoZk5TZlM2RVhEZEw4ci85SUkwaVlpZGNkVnlBb0ZY?=
 =?utf-8?B?S0kzV3liZjBUUHE1OFhCNnBGNWYxMlk0ZFpaN1JlN1ViQ3c0eHZPQVFkYzVu?=
 =?utf-8?B?bExCSFNiY0ZVWWNEdFVIVHhHbERHdE15OXQ3VWhrVFQ1ajJ3a0F5NTU3bkR0?=
 =?utf-8?B?VnJ3SXN2dW1ySlRQZlJwRThJeUVnVXplWTRkYTdjNUw5d1lPTEFjbzNHbE9Z?=
 =?utf-8?B?Z3lkVDVIY2pZUUNMY1NRcXZTZ2hMc1dOcmtVWWlZSysvV1dMUEp1YVBmRjFa?=
 =?utf-8?B?dENDMElPbCt5MTJxOUZFb0EvaXRCUEFONFB4cU5lYmtUWllnY3F3Z2l6K0hE?=
 =?utf-8?B?L3d1SlV3N0pERDJwQzMxWWM4THBvVzA5QWwrZTY0cmVUT1BoKzFLdzh5cnBr?=
 =?utf-8?B?N2xnQVNUcFdPbnFOM1FPQkJDNGRhWTlkYnpFZldDYmdVWmZnUTlCcGp1UHZE?=
 =?utf-8?B?c1d5SFg4UjQrK1ZoUnB6T0pnRGdJNFcwb2hCV1Q1OEJiSys3d3FQUFVIQzJu?=
 =?utf-8?B?dFYyVmM5a01ER3lONC8xTnZwV2JSeVIyYTVtbm9XaFdUQ2FxL0RyTlhCYVg0?=
 =?utf-8?B?YUpDc3ZJVFI5VEhTeFV3YWlmUFh3UGNra2UxUFJKaTJ2TDRhaXZac0VSa2dM?=
 =?utf-8?B?a2REaEVsSlQwSVMvOWxmNGptV1VRY3JvTzV5aXNsTU10RGxIcmZ3dDNTOWI3?=
 =?utf-8?B?RkpCNDU2VEpFYm82SmZSbzQvaTFvM29Dbi9HY1A0c2hTZS9WVjRtZWMwRkcy?=
 =?utf-8?B?dHlKU2RhUFo1OFg2cEdkSWdYazkvK1JQOE50L0lGaTIybHlmVzNJSXpnYUdp?=
 =?utf-8?B?SHI4M1lFK2xqVncxT2Z1N2VIQzZwQU9CdXJpdWFzKzcwSEI2M1g5V3hVMTNK?=
 =?utf-8?B?dHM4UGhDRWR1U1dGS0R5eHR5cWJXeTJxb0hvK3BTTnByeDV4dHJjc0NjOWZ5?=
 =?utf-8?B?ZU9NUWFoMk9UemZRZnRacncySDJrUmU3Q1YzbWVtaFFjRDJxaTZ5OUU2RkFp?=
 =?utf-8?B?TEtuWTdrSGMvMUlNV0E4KzFqK3pvUE5WdW5pc3hSVGRpdERLbXZ1OFJqUnA0?=
 =?utf-8?B?UzgrWlVhY09yVVRDc3hNR24wdEdhK3ZXSTdJb3l4N2ZuOWcyN2RjZFdtRTI1?=
 =?utf-8?B?MU1FUnE2bnFrOU5GYnBPSldSSU9EejMyQmpRdmVaeDJocHBiODFmWUwwUEE2?=
 =?utf-8?B?V040M09xRHByVmZHT1g2WDl4ZmowU1hibHFjdk52cUZsYkdzUU4vNlE2aUxo?=
 =?utf-8?B?UktUekxRSW14Y04wbi9wNzY5cGgxVEZvL3Qwa2F5THJhL1BHVW1CYS9CTU9t?=
 =?utf-8?B?ZUp1Rm5ic2pUT0xwWi83NFQxeE1JVm5ZNWl3V2srUGNTQUUwbEx3dHdGdVpo?=
 =?utf-8?B?RW56bEJLMTJEaEhJdndoekRsTGZJRzBIOHZXOVBSK2F0NGhXajV4K0ZML3hr?=
 =?utf-8?B?TTU2dDlNdFY3c2FQbmNwYlhjVURyQmQzVjZjQnFuY09LcXE5TVVlcGhQd0la?=
 =?utf-8?B?RjdhWFZhQnhSUno0WE9iTFNLZVJnR3lqT2VLNFFVWUY5YU1NS2l3dmxWL0ND?=
 =?utf-8?B?bE5zelVUMFBsK1JhU3ZxYnh4S1F4UDh1V0NuMjQ0VEZXYUZPRjIzeThqUEtw?=
 =?utf-8?B?UFVBUkRTZDg5bXcrRnNEdE93Rkc0c2RIc3k4aSszSHNjaDJWV3piR1NXazhT?=
 =?utf-8?Q?BxIMFv52D5d9Tx+eZtiAPGVy4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kHb6soVtcEa5KcpmVYB8pomTs3/5+zdU5WN6lHtiYq1cS24GdCXXpOHw2L8wQdpdZtPDAnVbZ1lODt3ca5BZ3vDFj1ZkgYOlkkPQw86Duzq7+Xub13glIMOCuQrSYIQQbJH8jzkLAqqerAQRJPJDuwFwwtp4FHogu9mIA+B2xz9EQrbTbAzt8mnRx063ceDLgAHOSxmdxwx4I+ALlDmcIJVKZnUX03viimS6epS4WwBp13du8JkLOKkE0jD9xi9KjhzFZ0gSrTzItozgwGXrOHtdagihh2dNw+rp0SXNg92lhgcnjnjsKKDYUfORKyaS7HSC8ePKVKYBvE0CrbcaE7hGHfKU1Mgs1LgCXsqyIKmJtDliUovvuP5Z5BlBhSZ1GjTviFUNpajc9XKWHmTJ6x32+pB/j80wLrdJRYYRDDRrVyDp52gDQWaxfZSRNCApkkTz0keyGSyATQEyB2mbm3GdxioJJcm0qNY1XuDgxq7mUZAMtK4GnTZxe6qQ2N6fD5McwddYs+cOMXOpItctL+J+PMWq6PuIEIGkUgrH5lygJz8il36OhRvCfeTwtLHzTsUhHTO819RH5fN83qfMpKQkVuKQwxyKLSA/xg6C3HI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdd5cde-3eac-45d8-0e41-08dce7acf4c3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:22:00.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaJqo3FhNnxxkkZcW4/9S7nLrSLp3JPvQydUqsljSUwR/B75HyOFPZRFSXeusPexW4miZLtXaU/asDVMypJZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080097
X-Proofpoint-ORIG-GUID: UhaL-XSNmh4rapdFJ2905O53HYbLqQfe
X-Proofpoint-GUID: UhaL-XSNmh4rapdFJ2905O53HYbLqQfe
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 10/7/2024 8:44 AM, Igor Mammedov wrote:
> On Fri, 27 Sep 2024 14:38:56 -0400
> Annie Li <annie.li@oracle.com> wrote:
>
>> Followng hmp/qmp commands are implemented for pressing virtual
>> sleep button,
>>
>> hmp: system_sleep
>> qmp: { "execute": "system_sleep" }
>>
>> These commands put the guest into suspend or other power states
>> depending on the power settings inside the guest.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hmp-commands.hx            | 14 ++++++++++++++
>>   hw/core/machine-hmp-cmds.c |  5 +++++
>>   hw/core/machine-qmp-cmds.c |  9 +++++++++
>>   include/monitor/hmp.h      |  1 +
>>   qapi/machine.json          | 18 ++++++++++++++++++
>>   qapi/pragma.json           |  1 +
>>   6 files changed, 48 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 06746f0afc..4c149f403f 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -639,6 +639,20 @@ SRST
>>     whether profiling is on or off.
>>   ERST
>>   
>> +    {
>> +        .name       = "system_sleep",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "send ACPI sleep event",
>> +        .cmd = hmp_system_sleep,
>> +    },
>> +
>> +SRST
>> +``system_sleep``
>> +  Push the virtual sleep button; if supported the system will enter
>> +  an ACPI sleep state.
> perhaps comma after 'if supported'
Sure thing
>
>
>> +ERST
>> +
>>       {
>>           .name       = "system_reset",
>>           .args_type  = "",
>> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
>> index 8701f00cc7..3ee529d8d5 100644
>> --- a/hw/core/machine-hmp-cmds.c
>> +++ b/hw/core/machine-hmp-cmds.c
>> @@ -189,6 +189,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>>       qmp_system_reset(NULL);
>>   }
>>   
>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
>> +{
>> +    qmp_system_sleep(NULL);
>> +}
>> +
>>   void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>>   {
>>       qmp_system_powerdown(NULL);
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index 130217da8f..770f8189ba 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -276,6 +276,15 @@ void qmp_system_reset(Error **errp)
>>       qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
>>   }
>>   
>> +void qmp_system_sleep(Error **errp)
>> +{
>> +    if (!qemu_wakeup_suspend_enabled()) {
>> +        error_setg(errp,
>> +                   "suspend from running is not supported by this guest");
> it's machine and not the guest that doesn't support, isn't it?
Not the guest, will change this
>
>> +        return;
>> +    }
> I'd reorder this after 6/11, to avoid adding function that does nothing
> and then explaining why it is done this way.

OK, will do.

Thanks
Annie

>> +}
>> +
>>   void qmp_system_powerdown(Error **errp)
>>   {
>>       qemu_system_powerdown_request();
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index ae116d9804..e543eec109 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -43,6 +43,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
>>   void hmp_stop(Monitor *mon, const QDict *qdict);
>>   void hmp_sync_profile(Monitor *mon, const QDict *qdict);
>>   void hmp_system_reset(Monitor *mon, const QDict *qdict);
>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>>   void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>>   void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>>   void hmp_announce_self(Monitor *mon, const QDict *qdict);
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index d4317435e7..b32d231aa9 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -362,6 +362,24 @@
>>   ##
>>   { 'command': 'system_reset' }
>>   
>> +##
>> +# @system_sleep:
>> +#
>> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
>> +# sleep button.
>> +#
>> +# .. note:: A guest may or may not respond to this command. This command
>> +#        returning does not indicate that a guest has accepted the request
>> +#        or that it has gone to sleep.
>> +#
>> +# .. qmp-example::
>> +#
>> +# -> { "execute": "system_sleep" }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'system_sleep' }
>> +
>>   ##
>>   # @system_powerdown:
>>   #
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index 59fbe74b8c..e2c5dcb829 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -23,6 +23,7 @@
>>           'set_password',
>>           'system_powerdown',
>>           'system_reset',
>> +        'system_sleep',
>>           'system_wakeup' ],
>>       # Commands allowed to return a non-dictionary
>>       'command-returns-exceptions': [

