Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64FD6C29A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVNv-00026I-3h; Tue, 19 Nov 2024 16:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDVNg-00025o-AM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:03:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDVNd-0007Hk-K0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:03:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMcLO018915;
 Tue, 19 Nov 2024 21:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=dqzDbbe7V+GXhXoobNzhTWC5v1Mi/mdkcFlASR+30pw=; b=
 MhgKl2icQgfhanOFE2yIvJ57GCUuFqbZUlPioZ9/yIm2uqHxMbsdO9wIpJ4G9Pj5
 /5XDXDDStS1CmDlxaY0sBHtxgZu1sYaGCCi8xdJ4c3Yf5+jI+wmmNw1UdGCZh/6s
 1KctxtJzJURoCTtqq0UAPSu4r3KaLavZBJCExmMqV942RclcleYpc9QBufVXf23t
 jOi/9dO6rkKLlmuX8gWhk9EVOZACaSDKQ2Tf8rMIqQ8L6DmudjrDaNFN4pCUdZMX
 vbB7yAKwTR5wVaLUkhJOd2qnXW8oqroSp6LAIunzpi4H60+GOHsWgD/1pxsgqSpw
 eoxpxMGTMVs9HItCpOKeeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc62f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:03:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AJL0xTN037262; Tue, 19 Nov 2024 21:03:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhu9ad59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUSqiP7YNI+Gh0bUEUwk/wh967BlRt/TXdXsDCH0EV/APOxyZSUNZeV/K2Z2NJAPIp1lRlSdPnUueWQKw+Ib3OUSyZh5QGiM7Voh8LaRq/MJhSBinbhjEs3GbVb6Kzd0t1jTYsFWP9bRV1znzAw4Q/qp2QFQmQ+jltZd9gQo6R5EcWjrnVWOcm4xMljtTx/s1FWEjlvXwmbu/QgM0k8nybxESTMX8BW6oaSrkKoc2juRY5vZ0yfWHytRsO/Qkx07IuEA12GSxgQ3xNomGtAuJBrI5Oqg9pjlHaXbXv2gCUPVbUwmo2OavRd7MKs+IupwgWAH2gH6sGH6QHUL11BGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqzDbbe7V+GXhXoobNzhTWC5v1Mi/mdkcFlASR+30pw=;
 b=MJKruffgKPOygtacjpTjxQQF4u4JXce2kSEB1IeBjUSEODNnzAkv1iZ49P3Pa6vHrQQaMKosANXsKhQ2tcM4d9q+hLLUBAnpu1tpoq9j1noFduE967Y5IEjw3MbZDKgvdIjuR3xi0VsPczg/XJXUFyU7kxMiCFSu3vzJlivnWg+7MiGMSSuQRMzVuquNVncN2r16Qo6PWYx2cYIXmimZZIL5I0j10M/QL7HA29PuynjIAv+fUrQsuv20T2GsO0GB/GazjdM4PP/now/NmR2dkc/BQ+GueUwo/40VWc5O9oL1HF0IeqQUmN+cbuFPn1wZjYLNTPvDy36vjLqTTbcBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqzDbbe7V+GXhXoobNzhTWC5v1Mi/mdkcFlASR+30pw=;
 b=G9nGDBXZJroqkl8QbEHhhAZIapTMtWXNttWKDeUNKcubvGMB0Ofi3uspbU2vBJ0wPIATtvL8F/3j1y3a82OftSIdQIaZ3/b4x3Aim14cGSXkCCFAdOH4p9JCpmKDLpBOq86D9DQUFB3DvabDnC+Qj09TRh2n531DeI9N3GZaSH0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7862.namprd10.prod.outlook.com (2603:10b6:610:1ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 21:03:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 21:03:17 +0000
Message-ID: <8c56ac9c-c86a-48c1-9172-8f014220c37d@oracle.com>
Date: Tue, 19 Nov 2024 16:03:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n> <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n> <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n> <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
 <Zzz6NVoJss4JdEHh@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Zzz6NVoJss4JdEHh@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eead1b-4644-4964-964f-08dd08dd9706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzdReWRUZW4yWm43U2hhSmxQdktpbnA3N0t6ODRCVkJKRHhVRG5tSTFOM3Fo?=
 =?utf-8?B?LzR6eStUQk56M2J2V2NxclVEQWg4N3pNUzg4MDhLTlhSL2pYYTRZSVZhRGJV?=
 =?utf-8?B?eVU4VkpHZ1VQT1BuTU1XcUl1ZThHbUk1TFB5RTViSE01cWlwVml4WlVZV3N5?=
 =?utf-8?B?TmoxU2FJQ1lLaU8zRjFJVVRVTXFxRWs3UUZsRGIvbHVSa0QrMjhmL3VlZ3dK?=
 =?utf-8?B?WXNPc2MvamhzbklpN2QrSEJnUVVWQlhTa1crKysza0NEeHJPQjRBYmRMcFR0?=
 =?utf-8?B?MlhlMU1qVFRSWXpLUFRYYmtTNVRKdkpFNVNQWk9sc2EvSVlpS0t6RkhXQk9G?=
 =?utf-8?B?NFFnektQMGNqdDV0MVRZTE9hZWUwd1NmWXdDVUlCbmJQQzM2MFpZcEVLNU1X?=
 =?utf-8?B?OUFNTzFZMlZuNzFXU01xSFM1RE5BK0dqYTQ4ZUoxdUFvdXdnanFWNDBPaUZu?=
 =?utf-8?B?Z3FlM2h1WnRHNUxjQU9ra0ZQY0xsVjFlem5ZMlN3V2gyU2JsQ0k2RkREZFNM?=
 =?utf-8?B?KzRUOVMrQ0x3WlFnZ094bWU5Q1NQUnJCMDRSWFZKd0JKQWE1SXlNQWlvbHJG?=
 =?utf-8?B?SExsNlNIT0VCci9ST0Zmd3c5L3h5TXZKWTFBcForNmpWdC9xSWRkWmVvaFp5?=
 =?utf-8?B?cnN5RVZGQ3RTRnJrNmplMkt0Q0tMZHhIL2ZtNnZKL0F6WU0yV3o2THJ2U29B?=
 =?utf-8?B?U1FaQmZhQ1lJaW50a2M1S2diR0Y0Nk5lVVNmYjlOSjd2WW1kOFVBdmowLy9T?=
 =?utf-8?B?bkNBa0pUdS9yUytGamhkaVNYZi9lQ3ZYQ0ppYjBtRDQwNWpoOHR5SFRNZ21O?=
 =?utf-8?B?cXBFWktvb0pKKzh0YnF3Rnd6MWZEVkpmQTB2YVlWcExTTVhWV1BuNG1DR0NG?=
 =?utf-8?B?YTlLK1Z6S0xtQUowc2tqRnJjNHE2dzVZaDViek03WXZZV0ljcW11SVo3MDF5?=
 =?utf-8?B?dHdYM3I0MDN0STVOMi9GYXJzcEtLaExGQWgvczlaaTN1ODZtV09Uc3UyZzlt?=
 =?utf-8?B?Vy9wWVEyNnI0Q3AzeDdQd1VISFFxSG5SYjEvZUV2VUlHSGMzMVBNZVBSb1cw?=
 =?utf-8?B?TGVORW9ITXNKRnJFcTlWR2kxbXlTUmUvZXlIc2pQQ2FzaWZzc29JWDhHSkVu?=
 =?utf-8?B?dHpJQkUxRG9FNWgwMFEyL2QxNVBJTWVsdzBFYWg0dlgzRytCNkN0cGx5aUFm?=
 =?utf-8?B?Kzk2RGdzcGUwWWpwNmpONEdhUmdrRGI1ZFdjVnJMdE00Q3ZNaUNNZ1JlT3VY?=
 =?utf-8?B?eWo3SGNlOGJaUUFTRW5aUm40bjdJUnB4ZWRMOXZDcm1NbnVySlpOOVY0d3JR?=
 =?utf-8?B?emFULzNWcHhFZVYwRzdiVHlzUEZSaXJEbjJYTHpCNXhNOEV5UHdsYXJyczEw?=
 =?utf-8?B?Qy9TdTNvQkJtd3VPM0pQbVhldUg4QldDYzUvKzdMTmRSUlI2S0FCSERxOU02?=
 =?utf-8?B?TkNOTXVJNW5panUxY0NOa2ZMKzNUc0QyMjA2NzVzQUpRY2JDWFh6eTMrL3NZ?=
 =?utf-8?B?dzYxSmdXN0NwcER2VWtGUlpWMkN6czJlRzVHMmpKM3pBRDBnMW44TG9oMUtN?=
 =?utf-8?B?Smx0RVJZNVpZRjhsMU8vb1lYeGFPWlNkSjNWTDJtWVlKY2cwUnZWQmZ4SDIy?=
 =?utf-8?B?R1ZlQXFCdm45cFFtbUFOZUFxL25telgwRGpWN3hPUFpUMW9TMlBWUHNFRE5P?=
 =?utf-8?B?Z1ZXNThBNnM5cTkweWwxNUpmemc5azVueVZzbmtLUEtQb1FBbkpEcDc3L0FU?=
 =?utf-8?Q?QlEktlj5GlcEWjL76ZzgLn3B/YqEX3mhBPfnHKD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHE2OXUwa1hkb0g0cE0rYzc0RFFyOGJyOUdzMG9zV2tRenFtM1ZidzU5VXpj?=
 =?utf-8?B?NHFodEZrUVFEUDk1bys1c2txY1hBOE9TakdjSSt6Q2V4U3Bzb1JHT3A5NjNG?=
 =?utf-8?B?eU42TngvZnQyVk16eFFXdkorMDdYd0ZldEdTV3lMeks3L3VGRWNkdHIwenN3?=
 =?utf-8?B?Qmd3Y2J5ZW5NWjQrWWc0WTdxcFJ3MEZyUnVyWDVXdUI1cDBwK3R2dzlpeW5w?=
 =?utf-8?B?aTgvbm9pbkhZT2lkeUZPY3NhYVdJNVd6cC9MWjJ4WTlOa3dobDd2NGhRVW9G?=
 =?utf-8?B?ZURkNFhxYWFnMms5K2lXL3lTQ3l1ZVBCVGhDL2xmRHRoQUNabTVyRmpOWlhp?=
 =?utf-8?B?VXpqc1NIMUdqTktQSHk5VS9rZjR4ZngwblcxeGtxRUNYMTFDUW10S2psWlNn?=
 =?utf-8?B?Rlo1QmpaSXQxZHExeU9mL3FDV3JCOXNtR0VGa0pmcUgyZUhxTEx5dnk1ZU1q?=
 =?utf-8?B?bWl4TXdEMmNtandNM29GSGVSMzdxcUM3L2xFZ2lUYnN0MngyY280QUU5V1o1?=
 =?utf-8?B?NHIwWXpFTTNDSFRBTDZhQmp5TDlmYmtKa1FYcVBZVEdXeTNMWmxLd0FNaU94?=
 =?utf-8?B?a2s5K3hZbk1TQmhLYmJqanQrNVVZTE9GZzJ3L2FUSy9odDY4QjBTUWQwRlEx?=
 =?utf-8?B?aSt5U1JHWFJVTnhPWDRVSUN6Z1BzOXFvaURGM1FGQUduNUxxRTZNd1Jacm4v?=
 =?utf-8?B?Mm1xVjExZkxUMUNicHNmOGhuRitQSWxWeXBNc082TVlZRWRGTE9xWlNwZ0Mw?=
 =?utf-8?B?U1VGK0gvS2RwRDdZTWVxQVZ4b1VzRnR5cStYTDdTN25qSkZIVnNwOHg0MWdI?=
 =?utf-8?B?WVdkeVdhSW9TYUJ6QXQ4dTFvZkxsRzdZSXlQc3lGQktFQWxQd2xxa1ZlVUd6?=
 =?utf-8?B?bEhQelVVc1p6N1BqNStKdFd4dmJmdHMvN2F5NWJLeEhIZFU1MytYN2JPVmhR?=
 =?utf-8?B?UzJESTIvRE5ybGxXblJDR2ZPZ09ibGU3ZFVxM3pnendpZmFvalpMejNqa2Zn?=
 =?utf-8?B?YWRNL1g2VTlSY1dnKzBkdnRjYis4RUZ1LzEvN3hULzhPUDVOK2NmSmh2dm02?=
 =?utf-8?B?dFQwR0xSamFHQjE1WElTV3pCa2sxUmdSc3pqUDhZQUJLWitCZGt1aFBWMGdv?=
 =?utf-8?B?OGxvVHIzNUNlRUJzTFlYVXRjTWRVUWFlSXVrWTFhNWIvRmtUNTkxNXhoMUcz?=
 =?utf-8?B?QXZuSjFUQko4M21FdFFLSkF3ZVN0TElKUlF1c0lpK2FGTVFNblJTRjJvdDMv?=
 =?utf-8?B?T3h4M3o0S2I0c3hBRFQ2ekRkZ2wzV1JQSTZUbE1LVHlDUXlLTEE5enRnK1lX?=
 =?utf-8?B?bGtzVGJpMDB0UDhvUlFWWWpMdDYySXVCSXpQMHpQK0hPNWJKbks3Z3hOcTBm?=
 =?utf-8?B?eHY0YWltdlI5elpQdG9FdTRsSGtJdVR5dncvc1AxWjlsWElJMmF3QWoyb1BQ?=
 =?utf-8?B?V2NNYjluNXpIeUdITTMycUtXQS95Qm9ReFNUUHMrQnMrTCtuSURHTjFCQlkw?=
 =?utf-8?B?T0JxT09zanRsZVk4WGk4blNuRSsvQU90amZCdk1TWm9Hd1k5ejlxQWRLekFS?=
 =?utf-8?B?RUVzTDFDT0Q3enF1VDVrWmJMT1hVOFo0ZHhLRmhFdEVOVktDSWcyckp1Tmd1?=
 =?utf-8?B?WnM3WXE0dEJCeTlEbFB0NWFrZVpmZXJmTHc0SFlkUlFYR1FNbDV3T1FmdFB4?=
 =?utf-8?B?Qmk3dE9sOTF5NXFkcFJDV1YzazJOVHJzREhFM2YrTktycVpvd0hBcWJwaEJJ?=
 =?utf-8?B?MXdOYmhKTndwbmRIOVU0Ym0zU2srT3E1eUVodGpkajBKZjFiQ3BaQW95ZHNv?=
 =?utf-8?B?UUNIWnB2MXFPdkx3dE9sZU04UXVLTi92NDRRWjdiQVhDWitKVTZ4WGFGTzhJ?=
 =?utf-8?B?dzFNVUdOMHpJNGQ1NkVudmcyRjJYOGQ5Y0RsTVdtcjBhV2NUWnNLMjZMNkUw?=
 =?utf-8?B?MFJMVDdjb3NRRFVLRzlUOURwYldya2M5WVRyRVVpT0pSSWlVWEpxUmpaUmNV?=
 =?utf-8?B?YWlHVWlXV29GVGdSS3BvRWRBL0FzQWQ4aDlrUXhwT3lGQnVSdUdDTkZJZExz?=
 =?utf-8?B?ZTNvZWdnVUxhOTlleU9BMVp4OGZXMyt6Rm0yMWF4dmVuN1JUbzhYd1hqWGlX?=
 =?utf-8?B?aUpRa1p1VG5ycVhodFd6cjVLTDhFWmE4R0QyUWhHMXVkUno2RnEyZVhSdWxs?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HwN5mu48vDus3x48+O5klMIKOjwufyJsMvyi5lRegWMCg6EslyUz/4JVAm8yqnHg0hdEC5oWjm5ZQeEo06Qjpc4DMpVOVkKzF9+xzTwD76NxsBmDtu3i1QDiCtgtXuY2XX98BN94n3AiyD4nOTHAJeoOVjlhwis/nKumBbYiL09HUch4ZUtqTR8JgpvRzURU5Ibmc1yvayBGrwg+m3PbhaMAie9fdNBevbZ0wWNz2aIjuLsEWqziYcaWxMVxIgTpjlP+3G1nBzH7ma1KC83wpgZuyMs2Bxpp5PEFzVYW+pDRG9jH0iANAo5Q4Qk2h4fbv+Y47hMTgt1OiuTXGWJyiA3DRRJHY7+yYGAA3VpIlNt5uy3eVmt6+XuvZjx63Gue56xeWoPlqCRYevUspLPKQVbxCjGdV8xoZ7zdgNXQ+ratnhsUrdGlNToH2zIQw0uVwzTWA661mIoOna/gGRAaAz3qFKBluBVg3wCCxG88pRttYQKJSNEw7zzIfTqZr4amw/tScrKobi7WTX1kitlE/2VRyh7Ns5DtrCAa5T35emkKGhRkSLOf2S/HBWXdjdp4+F4c/AKpWfn2cJ5C1xM5rCT78yKKg8Pujvs2Lt8LlDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eead1b-4644-4964-964f-08dd08dd9706
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 21:03:17.3477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAJQ5ngrm1cfxd05WYQpO8f1Hy3qoE/H5sxbnfsHafWNtdTzZzBxGkQ3ZQvBR8+3Q8Gn7E+frasNRdw4E5t8mQp9qU1czIKDx9AMUguf8E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190153
X-Proofpoint-GUID: KZs9GM_3h2J6ZXfoWcCk6CXJBarjWeQz
X-Proofpoint-ORIG-GUID: KZs9GM_3h2J6ZXfoWcCk6CXJBarjWeQz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/19/2024 3:51 PM, Peter Xu wrote:
> On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
>> This begs the question, should we allow channels to be specified in hmp migrate
>> commands and for -incoming, in a very simple way?  Like with a prefix naming
>> the channel.  And eliminate the -cpr-uri argument. Examples:
>>
>> (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
>>
>> qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
>> qemu -incoming main:defer,cpr:unix:cpr.sock
> 
> IMHO keeping the old syntax working would still be nice to not break
> scripts.  

The channel tag would be optional, so backwards compatible.  Its unambiguous
as long as the channel names are not also protocol names.

> I was thinking we could simply add one more parameter for taking
> cpr uri, like:
> 
>      {
>          .name       = "migrate",
>          .args_type  = "detach:-d,resume:-r,uri:s,cpr:s?",
>          .params     = "[-d] [-r] uri [cpr_uri]",
>          .help       = "migrate to URI (using -d to not wait for completion)"
> 		      "\n\t\t\t -r to resume a paused postcopy migration",
> 		      "\n\t\t\t Setup cpr_uri to migrate with cpr-transfer",
>          .cmd        = hmp_migrate,
>      },

That's fine.

I do like the incoming syntax, though, instead of -cpr-uri.  What do you think?

- Steve

