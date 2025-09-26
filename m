Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29MK-0001ER-Ir; Fri, 26 Sep 2025 10:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v29MD-0001Dp-OH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:23:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v29M3-0000KI-RJ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:23:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEJecs018842;
 Fri, 26 Sep 2025 14:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=VxWIasDWZa6dZhYtWiwpQHgM1LXxUkp1EbmU2enAIeQ=; b=
 YBW6Sginl5MqfHdY9Z7haVBSxOqKsrONtXzdAuCF0Jx5j2g4VlA03N2/Aa7gxjC+
 0Wf1iwkaoRP/F1/5DK5/ZMuomTHaD8vHlhd3WTkp+ndN1L83Z0OvfrqAoF3325Un
 Cftsdt28D1TUGkcl4GsVvFFAW7MF5RhHXKFVXY7QimeZln352UzP+8TWqUc/cHKB
 WPhBEWSV9pAejzJ/ZGCjmq3CHY5ldFTUUuq2lF2iEW2O7mf5ZKP1r4ioxkchnqHE
 E1Dp14wSvi2SIA8WQj/VE6Y311rNRzfcEp3U2wB624OQHJb4sZKqOeinJl82Cu/d
 7y4DwtnHBNh2gxYSFro9Hg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dvg7r03h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 14:23:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58QEIwsQ036960; Fri, 26 Sep 2025 14:23:14 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49dawkhwm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 14:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otVcFvIhxREyEsyJro+ILrjIrUqBTbiQPJwEJPG6S5QHyOCp2heBPgx4bxSAsMpBkpbrV5zN1nLyqJqrFkTo3mdQr2ED6+dtGPFnIhQUn5T6t4NdXqVLuqQ/OeGelOuC4lpZ0wetu44wP8l42ROJCSWsQcCcQqgwJ0WTB4+v1e62XCeiO3wBJQb+frr0cbYMhGPWb4hfzEBoyKgvy0d1mR1z799pauAyuqsdowHg7RBKfOieAdY6VXsDnRDQ6v2bdW48H8le84cp5jASEAbCLM4uXk4qCN9fNsI9UdwnpiwERgIotZQLWKW1veROkiEX2CwCobDQ1NEwOm0JT+dHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxWIasDWZa6dZhYtWiwpQHgM1LXxUkp1EbmU2enAIeQ=;
 b=pgjWFjJZB7S3tH2fnFvNFzmsRj4mS4qAnI8UT0X4WEpZtuTml8hF95qpu3W82pDmLruwZ9bF8bMfji07/qkGO3ju7ckFv2XICL0Q5GYxhtMRQr02l+wRKBoWQqcG5JFXfzG0SraN8PGZjlLjbmbIHgJxpe3qBa9RKI+FD448fCDIozGldno7NBx/OuHBjA+lo56ZX3eVAzqOxNU6y2vDGw6wXQDxCOKgojXkkcfpIyNRu4nH2WICDwf38SEXRZXdWBBQNkd/aQFIZlbfLcAdgZos6tS4393AwOKRqSCd9vRehxjPtyx3ZGms2kOd2bw0ocGR91czyi0Y/wDDO8CeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxWIasDWZa6dZhYtWiwpQHgM1LXxUkp1EbmU2enAIeQ=;
 b=odO+Qes8aODTfLXqUL7+oAqYf8GHEds142z9LfgMpbBjoJhytPIMqGzyl5IwCHgdml6FSxQSOuu//yiNu6cgigYcXOfxKhbbYmEeNqgy5fGV/VcTOBoMRp+jzIuHYB1YRqC2jU7WIgpT+1avGtL79VT4d7JurSddBUjUk6l/HUI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 14:23:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 14:23:00 +0000
Message-ID: <7bef3208-9960-4bb0-93e8-b10d061e4578@oracle.com>
Date: Fri, 26 Sep 2025 10:22:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] vfio/iommufd: Restore vbasedev's reference to hwpt
 after CPR transfer
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
 <20250926022348.1883776-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250926022348.1883776-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8c4d60-b067-4f06-a9eb-08ddfd083237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVhJYmxFVGJFTXptMys5Slo4THRGS0RsdUNDMUxSUUtrK2tXWTNSM1ZWbkxV?=
 =?utf-8?B?c0tXY1dTTndnT0EvVlZoMzZnUUxKblFESGNHWDBKVXJBVHBkTis2ZzJYVGV0?=
 =?utf-8?B?L2R4SS9zMHFTekFXaGJTNERsR0ExZWg1VU9zMk1hamZEVnVRYnRGWU9qK3NO?=
 =?utf-8?B?T3NOaWZFSzcrWDFLVHR1dDFiMmYyTnB3N3ljNGl5cFcyWFVCc1cxVjBjc3hp?=
 =?utf-8?B?SUdpVG1HU1VtYldqNC9vZEpLcEdFSVRqeTVIWm96d09nMDVLdHdtZG5XNnYv?=
 =?utf-8?B?ZHoyNm1GUzR5dGQyTG1yS2M1aVFOdTU3Smo4Rmt1UFVaLzdtWG5VYzhPdktB?=
 =?utf-8?B?cWJsdjM4MjhEQ1QwMjdUNDdySmdYc25rbCsxNFdCdFl0bkRnaGthdHZUbWxF?=
 =?utf-8?B?ZXF3UzFVYUNwZ0VzU2lvc2RMTGlzZlluZ3I0UXkva1R2QkZRcnpTM3pvVjI4?=
 =?utf-8?B?bVJMck1pUWltaDdOaTdXekVtL05DaFhDQTF3SFpTaDR0YktqOW14bWMrODYr?=
 =?utf-8?B?eEdseTh1RW1iVkVFZnJ5ZkI5dSs5SDIzb25UcHFUT01QZ3hJeHJnNzJXUkF3?=
 =?utf-8?B?OEdldnhyNFJXY2R3bVFnQW1lTDlMUXJLUmNRR0ZhbWdhWGpZdEVmWnBoOHcw?=
 =?utf-8?B?QzZJSEN0eHVmVldhRFlYeWJYajVBN2s3NnArbS8xbGViNm8zTTJmOFBWNGdI?=
 =?utf-8?B?dUVjZDgvNXJDTjd4L2xWREFyS0pYcmN5MEhNWFI5TWp5dS9xM0lDOGVjdS9x?=
 =?utf-8?B?WlVmMlJYbHRyMGFBMWZUNUhKRHRsVHEyUkgwR3RTWjMrVElVOHg2bzFIY1Ex?=
 =?utf-8?B?dndyOGxiUFlCaXVJWjhaUVl0WlhtVGZSKzBWZVZGb3N3MDV0N05GUUlwY0Vq?=
 =?utf-8?B?S3lGNmI5ZUdkR1VpdkpiSFNueTdvVUdnUmFEckg0ajR0VW42ZHdVSUFqSDgw?=
 =?utf-8?B?NWZDbldnSFVVaW5YZmN4a0pKRVNMaDhVblhYZnpvaWRTRVJlc2E0WXZPRFlH?=
 =?utf-8?B?dG5YMFNvdWNxd3NlbGlwTlBTaGZSWHlMNTM1K1dIb09SQnh4cjdDMEVhY1hU?=
 =?utf-8?B?dGIvYVc3RlQxd0thSUpZMURiODdVekIrYk0zVkorMzdVcU5mRE1xQUd3djg1?=
 =?utf-8?B?TSt1allBS21GcU1uOTRqWHk3RHhLRDZYTXYyTXUxOVpWTmN0RnlWZzFMUHJM?=
 =?utf-8?B?QlVSaEpBM203cGd3TUxoQlJMOVFVVGtjNXBSamlDcDZsOEo4VlRqN1d2YWF3?=
 =?utf-8?B?TzZGQUhscXlSdS92a1lRemk2RVY2RWRNUVdpYm9xSnhOWlpyalEyK0QzN3ZJ?=
 =?utf-8?B?Uk9Hejd0VDdndDRMbTR4MGRrQ0ZGdzAvZk16NFJXNHBKcnZmOEJuckNkL2R5?=
 =?utf-8?B?aVNzbjd2Y1RNMEdWdk9va2ZXcXZTU3laUVRzZWNWaGRxYnFsM3E4aUxibWNn?=
 =?utf-8?B?QkxSZ1FtN3Q5dzFMbjc5R09GZ1VocUpiUFNSSnFyMUFIUUM1aHpSeVRHYW1O?=
 =?utf-8?B?NzY2U2VBd3djL2tBTW9Cd0twYThuY0tjcU4vdy9ySkJzTG1CYVJabVRLcU5B?=
 =?utf-8?B?eHVvV3JRR2pGaW5sYTZvV1BlV1ZrNk8wY2NKdnVJU1p1TTltaE1pNFZVVFE4?=
 =?utf-8?B?THJFRnJ5Y0JDb0lRaFkreHFDcUUwbnByeFpHT0hxQ0tRdjVJZkRnUGVod1o3?=
 =?utf-8?B?WG9UNUZLT3BzdUdiWEw5ODlYcWlybTVxUWRSNkljMFRleTJEQ2MyZUlEakpN?=
 =?utf-8?B?MG01MWZnZHpaSlFlcVJaUkhWQ2lnNktVMXVtdEQzblI2WjFSdStCKzh5YXBp?=
 =?utf-8?B?Ymh0cTdITkdranlIK3hYNTdvc0tzM3prVkZFWmJWQ0FZWld1MlhjaVJabVJ1?=
 =?utf-8?B?b2kxdmFOL29QRTdjcXR1VFNoeHRXQzBMMHFoU2tQMDJmdXlXSWM3RjU1TlVO?=
 =?utf-8?Q?ONmkNxvQgZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEhHMHBzektVNDRVMFhlNUNNY2ZnVStDYTJlTGJ0d09tL0NRVUFaTGhPbG9V?=
 =?utf-8?B?cndpdWRkOGxWS0FMQm1ISzdtME1DK3hXQm40eHJtbHJpYlAyY1ljWVhWZTRu?=
 =?utf-8?B?RWhSZnFLanNnYlR3WlJFT2c0Qk04R1NyWXB1d1NFTEl1clNuVWs5czdsdkxj?=
 =?utf-8?B?aTJrVk9zRjlYTnE2VGllS1hRQ3JVSTdnWjFnUUM1Zitabk9KVGhGUklxbkhR?=
 =?utf-8?B?WmlhWm9SWlhvZVk4SzhTVlM2MUFHNGdTdGMvZzdUTHlxenZ5Vko4Ry9yclRQ?=
 =?utf-8?B?RGxRMWNUM3UwWjEyWjRJUjJaVWl2Q1ZVY1dBUUVsZGFtWDJDcXFHcTk5VUNz?=
 =?utf-8?B?dWNxejU4MkxzT05kMHk2QlNpUmFVaG96bnNkWHFEeWphM25iSi9VNW8xUjNq?=
 =?utf-8?B?V0ZDOFRXWnFsNTU1SGQwSG9DVlRnZGhaWWwxV2Q0c1hJZHJJd2k2bE9va3Az?=
 =?utf-8?B?dGJQclRwQXR5RlorWXF6d1gxVzNwTW1qWTU1Ti9MSWk2aU9ONDFid25CNk1V?=
 =?utf-8?B?dUkzdVBoZVZwdFU0Z3VmeUtFcG9CWk0xZDZMK0dpZFBzcXJ0S01WOUo2ajY5?=
 =?utf-8?B?Zm9QS21YbXFoWEk4WEoxWDlGZnhiS2lYU3hTOWNDNmE5NFBMVjBrN0NzZG52?=
 =?utf-8?B?R3lyNjIzTktJdHNLU3pYdDQrKzNVL1ZBNzFGWkczRWdPSGR5eUhxcngxMDE5?=
 =?utf-8?B?SkxlTGorUWU1WlV3T1Z0dDFmVWhoMEVaY0JxZFlja3FIYWFmMVNNNWpKcGZ4?=
 =?utf-8?B?UXNQUENkSFhIbzd1Z3laY0FPOGFrYnBkUjBMZWQ4UDREZUQzQysraUpVWmpP?=
 =?utf-8?B?bmpTY09XbEdMZzdqTWE4MTUveDYyVWxjemlON2IyU3hDbyt3YWN5WnNXYmdh?=
 =?utf-8?B?Y21pWXJZM081UFJZeForclFkQjA4YTg4NFZrcTJXMEFreTZ0TWcwMzQyaXZu?=
 =?utf-8?B?eDk1Rk1MaWExaWY5QmtUZGt3cjFRdjBwbG5WV0lRZnc3TWtMa0liOGhmOHBT?=
 =?utf-8?B?VmhqYlNSUEFPeDN6dVpDSTEydWNSTmVzN1V0dFRGUDkxVGtaYTUvSWdLK2Q3?=
 =?utf-8?B?ODRuMjM3a2tUUUtrUUdoaVFOb0pVMWtSM1B4WncwUkMxQzJscE9yNWtKbnRu?=
 =?utf-8?B?aVJ3SU4vdlJ3RWQ3dmZHQTB4Z0I1S3FvZm94Vm5Kb1dMWWxEdW85RWhlQjlR?=
 =?utf-8?B?WURhR0pvRkwyeXp4SlZtN2ZFejNiZGdkNWEzeGpJeUdTZGJEY0w5ZUlieDFH?=
 =?utf-8?B?MDZVRlJVQnFQUzkxNmU5Z0pUNU9TUFRUUWxGb2JvakpQVDZ3RGZFVXg1NjZM?=
 =?utf-8?B?L3hwS1BockkrVmllY1VxMmxvVGR2b0RRMWtqZEdORVpVRDVKUjBOK0NoTFZi?=
 =?utf-8?B?WEQxRkp2aTU1WDlrbyt6bVFpbzkvcHlUOWsya0tOaWRDMVREUlZzcmVzbksy?=
 =?utf-8?B?RjIwUFNXQmlpbVFRUHloZzVWWmJ2cDQ4RzhBMUErcVlLeW1PUDJrKzNIblcr?=
 =?utf-8?B?RTZtdFg1WHU1WkpxQWh5bDFmV1VQaWRwY1o2WFFkdzZvUzhyYk93ZVdweG95?=
 =?utf-8?B?d2RLTUYzNzZhNGljMGVRR3dGWHN4WVl2b1h5OFJFNGY0aWJsTGxVZEQyQkd4?=
 =?utf-8?B?VGNKNXpHM2VzS0pQWGN5SEpaYmlqek8ybTBURDBzcVN6UlVuU3BQZUxYNk10?=
 =?utf-8?B?czIvNFdabEkvVVNpY2lpcWxqNmd0K0lUQlRianZZUGxqbjJXZ3JQYVdCM3hS?=
 =?utf-8?B?aTRreCtLWHdPK1lwZFpTRDNlVnB6eEhVZnh5WkRSMVFWWUl5WVllaDk2bkRD?=
 =?utf-8?B?Vk9sS1NBYUYzdGZ1dE1DSkIyQ21iWGF1TWo5NHpxcjhieUx0QVZDWmZFUVRs?=
 =?utf-8?B?NkF5akREYVlIOHZBS1ZwN1pZcWtudmJUc2NvWko3NUphSGNQdW1iVFlYMFRz?=
 =?utf-8?B?VlVvNEhYK1FqL0szdU53b011ZXlzajdtU3M1dUtKamxJMUlDRGJLQTVLbjFa?=
 =?utf-8?B?L0QrQzZxWW43ZEhIc2Q3Y0V2Yy96WGJveWNrK3A0KzN6N3RkRDN1amRGaXU3?=
 =?utf-8?B?OUtDakU2eFdUdFJ5MURkWmNQaFZ6eWJWckp5L0h6VjhjWlprb2hOdm4vVGlw?=
 =?utf-8?B?Mm9mZU5HRk5ieTM1STk2YmYxc2lOdy82V0dFa2RhRlA4T3pDWVdjaVkyQXgv?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KH5yOGdVKLwXM8mbRW0ZzNmWiZfeg1Qj5H7lQ5RCL9ZO4pcdYoSmhBH0d2MQT5qv5GLTvXvMtsHIMD97bLTXm5vg9hoWV90BborEKr0REx/snIYYCbzWz8T5l40s2oji3QXnfJIPH5Bs8pgfJTacdZvNWXS3C/I1GYCmvfP/tcP/wxgDXwxsg/cxVHV0sW5Py/9GfdVUO3NdKsvQBj+fWp2G4pUcXzDEXHe8Xd16LEbzwaj+PQQcXEIQXpJFs5dgRE707vzjfSEsnIY2hxiXT8tpl1UXqj0MXp0fTTbeF4GO3Q3TaemNJPsQqptRgPN561wEu78Ylb3uLDnqbxXEVycX4CO9zlKyia5mnat6SjQ+8YK4lKS7NxjnX4K02e0CrUjiZ82B97QdTnUofJR5M3yAFmcHjl2fJ+xtcuUU8rhgW/+1W3d2lDfWStkKzGG9TtWKHTepTS46rQqaO3Ivz9r5chyorikHMW5E6DCcxNlrfCIfC5PPN2kBtacpBW70bCSPIIEalaMovsdcCjPG5myDo3LapJ1MBuvrhjLEyVsxJsZgvJbskibDg8uq8kR44aVrxzh8fVbil7LQY9EAvIOf7W08/Y4uIKz75PEzXWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8c4d60-b067-4f06-a9eb-08ddfd083237
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:23:00.3214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ijaz7mSVRAE/x95XNWmHy1ezAYXUWIdKnFoSLgPIPbuLVSF1CumqTWGPnqk5yJ3K5Be+cFDmn5GaVuaZ/mEkkep3Y4DonID6fJ12OYOAs2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509260132
X-Proofpoint-GUID: HPGdazJ2LZCHe8cODuYo0jCClyfBHGmo
X-Proofpoint-ORIG-GUID: HPGdazJ2LZCHe8cODuYo0jCClyfBHGmo
X-Authority-Analysis: v=2.4 cv=c/+mgB9l c=1 sm=1 tr=0 ts=68d6a1d3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=8GsVHmWbNEM55XU-hvMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEzMiBTYWx0ZWRfX0AyDoVYUfXdC
 mrTSPGyVDaDbHz2NLjaHgf+Hag9UvmKZm/UrEiP+Fq1sManjKPNfL7x7B4eoOHWRdPRRWaGi6hr
 o0epsZSYnFJ8LDxhENYovY9LBuHJUgM0/dQQeNdKXkgH4us0104yMkSGaArnXYwca/p/a8hRWlm
 KpfRrnwBINqyYh3qephW4TJxnnimqbpWT/P+2MB00qC865UzS9GP92y/onLt3dSfENMK8GhTtFo
 lr+7qlnkCHNqy7JSAEW5yivGgKV9KdLavoJEoyOzKOeqnCMFa1euMmkD7fMRBrAKStAKm910JPJ
 uOQnBaceGUaS0DGYMakgQSPqn6cNMIgYp5ylLdJqVB90dxkFQFsqfN4IB2vldvS52132zVkI3LL
 NrCVadFBeM9Tl4cmLeDGo1t6YCVmiA==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/2025 10:23 PM, Zhenzhong Duan wrote:
> After CPR transfer, if there are more than one VFIO devices, the second
> device's reference to hwpt isn't restored on destination. 

More specifically, the device is not added to hwpt->device_list.

> We still need
> to call iommufd_cdev_attach_container() to restore it after a matching
> container is found, or else SIGSEV triggers.
> 
> Fixes: 4296ee07455e ("vfio/iommufd: reconstruct device")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks again.

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

> ---
>   hw/vfio/iommufd.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 103ff43426..6df99d3aa6 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -565,10 +565,9 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>               continue;
>           }
>   
> -        if (!cpr_is_incoming()) {
> +        if (!cpr_is_incoming() ||
> +            (vbasedev->cpr.ioas_id == container->ioas_id)) {
>               res = iommufd_cdev_attach_container(vbasedev, container, &err);
> -        } else if (vbasedev->cpr.ioas_id == container->ioas_id) {
> -            res = true;
>           } else {
>               continue;
>           }


