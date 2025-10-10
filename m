Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFE5CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 01:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v721L-0003Qm-IO; Thu, 09 Oct 2025 21:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v721I-0003Qc-VY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 21:34:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v721E-0005kT-0X
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 21:34:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A1OuSp026243;
 Fri, 10 Oct 2025 01:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=/ROdLgVuUXMSfa0I1ThU6vXZXfrxX0OYrqZ4fqkuOpI=; b=
 fvEn8udkZ38eqt0F8boTRInV78bUKw6ny4XBbxh/L5DBPMNjNmwJizBULVowUakV
 6EiU+snDfj2PiEVs3Z4jz01KVb0yDCwTPi4d5hsOex5p2ehh16DIHpWPs02+sFI6
 QVIXTHmw/EWjRhdAMKs4n7ZuW8a6o+CQZSsfZXNE3msEzZnLMqcL+88asD9zdzn5
 u560EXmMc30UK8FRVUppimKsUeW9RPj5+3gopB0EeCJrdgT9Yr73t6I6Ue8CLMo/
 y0lfm0MlyV4TDizF069vpJuXa8yELdqVd8tAhxcKqBxi52kOLNtAzP46vHz6b7nU
 cZukWbKgqypL/IxDVStTFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6btrgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 01:33:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 599N5KSc010244; Fri, 10 Oct 2025 01:33:53 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv67mv8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 01:33:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDG9gczh41X2Lh7LIr8nDCGwBKEF0W1YDv1txi6lwunwjZnbtCvNSsXFWyRP0jDZ3aryY7QYlDmHXAB6fckMO/lzI0+yYgy6DG3nqpxcWT3sYST2Z/xSfyXNvPFtMBnheJvUryEI5uyZIIe8U5rv64YrzmZh4J/2cnFCYvtb/VrXrBqNh9CIGJK2Plyn3g5OBz97mzovWmaveAwheijYBPL/NukjJOO2T0L6zHjeA3COlFJRG1h3xntWgv8uyAe2vyyyHP83oVSys0D1CUNwh+8wAxLkg87AYjJSwJAXPNkmOD0q7SSbc9rNXy98iz994EdCO8Idl/OBPa9zi2axzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ROdLgVuUXMSfa0I1ThU6vXZXfrxX0OYrqZ4fqkuOpI=;
 b=lECShfliFwEO0lQzgedMYLHvNi19Lm6K0daApmMQ4KYPzE8HYNINoQuG8v1wTfRc4sctdKR0hvWZW3+0tD4JKYv//WfZNmOrrtt8ujaAQiLN8eZaZ6jInLN2EWbZTMbEZBj51MY9Pw1FnXhLQNH1/Ug4LIU2OOJZSLo1hDDjrdhAHYE5vuVYWkqDK8331GYnTYPdLR2AYISpfnj6E1cI/q387kmRxxHdwqgnYDg9R3vuxaP+sUhlBH33GEwZS8xRpyKl6SZ7mMmr/WEB1oqIJbkm/ndh0FCYUd/miGXmwCk6aJYnqMPru1cWFLrzi5lr0mkWImui+YSl/WcjkDSnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ROdLgVuUXMSfa0I1ThU6vXZXfrxX0OYrqZ4fqkuOpI=;
 b=D1L1jrQNndxFWN/lrJM0y91VFYoDYL/0kV8kDUuhcu0j+i5Gq27NxgjDQ3SHUuDj9DFc8yXB5dNaP9fpBIVBwvWSXgVP8tF175fGappqBor/8dSnIMb8zAEkOWzxy4YrjJvgEdMmq3JP0yz8nOwuph7ePPAhQycQK9Stw1TuKx0=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 01:33:50 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 01:33:50 +0000
Message-ID: <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
Date: Thu, 9 Oct 2025 21:33:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Cleanups and fixes (PART 2)
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 santosh.shukla@amd.com, aik@amd.com
References: <20251008164324.21553-1-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251008164324.21553-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:510:174::25) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SN7PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b4fb00-17b3-4578-1ef9-08de079d1084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJUZkkxN0lWMFZWcmlCLytpdVIwb2VsTllyVUR0Rmc4UTdTS0lyVzFzSW43?=
 =?utf-8?B?M1oyTzN5ZHUxSEJrNkFuNmdTemN1NWJ4YzRzNUJLS0ZOUE1TTkxOTnRNbmxE?=
 =?utf-8?B?NG1jaXh3amR3L0h5MVlwZXRYa0VQZXV1TDRSREQ3N0NRZFNiOGpidDdXa2xW?=
 =?utf-8?B?TytqV1dhcC9ETlhrcHlkVE4xYUs0di9sUXhDYnNxUGpaelAvd250czdLWDZG?=
 =?utf-8?B?WWU0ajNDWmxCcGpDbWUvMm9NU2Y4K25NZGRwYnBZb3EreTRMdDFuMlAvdkI2?=
 =?utf-8?B?cmdFV0QrVWcxQUwzMm9PNHpZMVJQTHlkS0ZZaWZNREV5N2NINUZlVitZZi9h?=
 =?utf-8?B?bmpBMzZWTDN4UHZySzF6UEprRkRCSlgxUG1HTGl0Mk1JY3RvMnhLeFFLRzR3?=
 =?utf-8?B?L2pmQkxNSkNNeDArU2RDTENBRE52dGVOd3oyY29TMHFocXo5L2R1dGtOelhx?=
 =?utf-8?B?ZFNHMUtMUkRoR09LRWR3U2VMRVJmRjlwMklrUnlGL1dZSjR1RHNjUkdaWGVZ?=
 =?utf-8?B?WU5ueHZSdEF3WW5tMlFhU00zZlJGdmxOOXp1bkgvTHFBQ092U3lNdjYzVDcx?=
 =?utf-8?B?K3p5cnRibXM5WVNkVXdOVHdXM29VOE1scUt4Nlo4cnhMTTBaU25udnhkeVRN?=
 =?utf-8?B?WFdqWUlMalFEQUZ0dU1qQlhxRXczRytkNzFybmZ5cEVsTnpMRUpXd0w3SmpL?=
 =?utf-8?B?WU9BQ1JiZXp4aU1rMUNWWjluMUZxWWdpNWxhVE5yL0kwYmVaSXRTVHpZQ1JP?=
 =?utf-8?B?K3F3U3hwcjdnRnE5TkUvWjFKbkxzOVFFNVkrWVdaUGo5aDVNWXp5MGM2aTVN?=
 =?utf-8?B?cFNMTFZLSllZd2lOeXRBRFZrdlJURnJDVGpKV0psbDQ5eEZTVi9GNkpEcGZP?=
 =?utf-8?B?TzRvT1o1ZFkycmhGRUdKODYzM1M4M2pGRElzMElwOGdHdzd3TGc1TG1hTHkx?=
 =?utf-8?B?UnZreEwvSlNNcHFBWk5WT0JKTzVUNXQ0ZzVTWTk0Q2hpRVJha2tlb3lnT0ds?=
 =?utf-8?B?Y3A1bE42U3hIMGliWEgxYTBCYjJRa1hlTElKVTNhb0JQb3JCME9MSEtRdWI4?=
 =?utf-8?B?RXhkY3VTTEVETy8rQTlHZ0Vxb2R5Y2pLZTlmTmw0K0VLbGpaaXV5YkpEdmhT?=
 =?utf-8?B?ZGlWUWFZbWgvd1YrdzdxUitRL1EyTENWUWtvWFJSQXdVdXhsLzUwcTMvSDAw?=
 =?utf-8?B?cXFxTW5yUWh4aFJQV1RQa2kyTW8xNXNOUVMvYUVtdlJMdURxVnZEUHZ2Y1Jy?=
 =?utf-8?B?SmJYTC9jVm40ZlVjYVpzTHlXNjhFN0tOLzJ0SThqcmdCYStQdUkxUWM0Sk9y?=
 =?utf-8?B?czdPWjEvMnBkeWlnamljWUJiSU1CZzgyb0JuNEhSTnRJeGs4RE1GcWUvT0ow?=
 =?utf-8?B?UmpBZXRzRHVraHg5K1c5MjhRYnNmc2pIOFFHNzIxZEJ3U0pwQ05IeXV3OUdT?=
 =?utf-8?B?aWkwWnVMWHpiREdFNG1BeDN3VnBtWTArS0d6WjBJMXA1ZjcxUFNubU40RUo2?=
 =?utf-8?B?ekNwaFkzUGp4VTgxUytjOHZSMXU2dlI1WFRrSmRCT21vZHZ3eHJMdC9FSnVi?=
 =?utf-8?B?TklFUWhJVjFZTk5vL2dKdzRwZ01YcXB4djRqQjdkVklObGg1WTdHbThLU2tn?=
 =?utf-8?B?ZHZjQWtxVUE5N0pzaGZtNDNMeFBiSVROVjdvOTFXazJJRDdRRmFUbloyTTVC?=
 =?utf-8?B?cThCZkJkNzc0UVdML2tVQmpjRzB4WGpJYmd0aWlJQitmL2cyWi9lV1RNdk9I?=
 =?utf-8?B?cm5ZVFNKOHlBUk5xLzhGZkV5OHE3V0hRamxEQ0pvZCs4Q0pGTkl6UFp1UFg5?=
 =?utf-8?B?UlV3QklBUitNa0tZV1NocmhJTDFmTHlGM2Q1cG5hK2F0d0pLVGV1UHRHOG8v?=
 =?utf-8?B?RW5VangyQ2pWeUUycEwzRnorWHBmd0ljTkwzWkRtZmFmWndwbi8zZ1FnYVA0?=
 =?utf-8?Q?hs/exa+0i/ln9kDfS4Ahb/VY59TX30HE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFNaWXppRHVKa3cyUVRXRzJ6NVh4b3FXUnNwRWk0NDNqZ2d2OHkzcGZRMzRU?=
 =?utf-8?B?czdpVVhVRzBRVXA0WFdvTWJNK0haRWJ3dC8rQ21PYUQwa2NtT1BVSnF5K1Q3?=
 =?utf-8?B?aGMxSjRjUTIvRW9aVDh1YmJMYlVOYnpyS3d0Z1Z3bkd6NlVReGExMFBJaXM2?=
 =?utf-8?B?OFpEUzZhdWNvcldKZ3A2R01jU2xuYWZpWjRqMWZsYjFMaGFFMHRETFdlYjY2?=
 =?utf-8?B?VktzSE15Y2g3akMwNkhYMHBPV1hYSk13YmJHWDg3OFFKUDA3dEVNQXZlSnFS?=
 =?utf-8?B?b2tqanYxTDcxOFU0eXY0UThHNHFjQndJVm14dWdLN2NHYTBnekdwcS9Cc2Z2?=
 =?utf-8?B?bkZIa0paN3Ezc1I5K25uTjNPMkNZNjhGS3JZeGxQNzB6LzY2eDdIWmJDMStM?=
 =?utf-8?B?dDRIc00wZ081MEJabzhENEI0ai9mOEpKa2NLSTdpQml2MTNqd2RoVjYramxM?=
 =?utf-8?B?cklRWUZvNGpzVld3bGpSYlVJTW42bjYrTkxSbkpJakxTOUtrMjVIZE9HTVB1?=
 =?utf-8?B?UVZVWGhhMmp5eEZRa2M1c0Y4RlZ6aEVnSkxlejJDYVU4YVBQVjlBdW95bGV5?=
 =?utf-8?B?Y3hyTjhXTlpucDdFclVmNDlXUGNzYWhnSzBoOThvQVJNU1BRLzZQL3R2dHNI?=
 =?utf-8?B?VGExWkF2S1VZUmtxdVNKQ1BLaFdMcDdWZ29TaGF1VVJmaVBMNjVacEVlZ2VP?=
 =?utf-8?B?TDc0SzRKRm8za3BxZVlnWHNDNHpXUmUzRm81WldUbC80aCtMeVlGcnhTSzFJ?=
 =?utf-8?B?K1RJM2UvcDEvYk1XakNucE1qRkVkNlRYMmtnUElleCtIajdDdDJBbWNpdzQ2?=
 =?utf-8?B?d1R2TnFVZ0lId3JNZUNPTkRkUGV5L3pNYXBWam5HTjVtUk1XMmM1bEhlUE1U?=
 =?utf-8?B?VW14REpNQVREeDRxQ1NDMmYvVjh5VVdFM2x0U08vYTVOczVkcXlPbkhqMDli?=
 =?utf-8?B?a2NJSWgwdHBwUi8xbUEzcW1pMkR4SGVNTWFyRWZ5VUpVaFVDUXhBT1ZRTXVS?=
 =?utf-8?B?L3o2aU9zUFprbXhTaFJVYy8rSEFkKy91aWs4eDMzT0hBd0VjbXBUMHFtbUIy?=
 =?utf-8?B?bVFiZHFDMTYzdUwrbmpKMUJNOVFSaTBCcm9xbkNQdnpsa2Y2bFkvelpiYTlN?=
 =?utf-8?B?ZUNuWjVFRFA0MUpPOGpIczFZZGRlVEtxaFUzcHg5bmFlUHlESG5KSGlMeklW?=
 =?utf-8?B?MndFNVZ2SDIvVXIxcHRUZDkraDRPTWJVanlzTm9VREM0alhCNmsyQTBFNkFY?=
 =?utf-8?B?NTl0N2J1ZHBVck9tZ0tCWFZOMEZvbktZYWUwMllXZUpxTzNWUUUwSGZSMy8y?=
 =?utf-8?B?U3phRXlVWXprbzdUbGhEcnlWb0ZjRDV0WGJ0dHN3bDUzNnYvTXB4eEN2VWVq?=
 =?utf-8?B?MkNtY2diQ3pBWlN0a3RNTHpxdjUxQWwxUTRSSmpZMFVncS91b3FtWU1IYnZ0?=
 =?utf-8?B?ODlua1hYZkdLenh2L3VGUnpYa3FHb05RcTgzUDRGSnNxN2ppNDBOaER2SzJG?=
 =?utf-8?B?aHlHY1hLRlo1dWpWbGc1R0dMdmhxT2h4RGJKRXR2YXVHcXc1VlhYTUJHa085?=
 =?utf-8?B?bzhaK0dPcDMxQnExcDVydXFrOUQ4UXFzOGMvZDNaYzFRYW8vcG0vR01FTjM4?=
 =?utf-8?B?b250Rm9Wa3lhR2FHaGRSL2hlUHBtbkZ3SVg0SXo3Qm9IMnh6bkZiRFJWMVBB?=
 =?utf-8?B?cXpzSFJudnhaQS9QclhBcnlvQy9YUEhNWE1xVWJwUzhNTFVhTUFPT2I5dUty?=
 =?utf-8?B?aTlSb1VIdEoyVTdGbWpXUThNR0swamN3Vjd0V2MrbXRDT1lXSFNQMm5lb2ZY?=
 =?utf-8?B?UFgwcnBTa0I0ZytXK3o4RU5FRmo5bngzT1VDYUdyVmZReVdtYXVLS1JLakN0?=
 =?utf-8?B?K0JWd3A5cjU2NFNjMjZ2azJ4djdSTW1id01FMzRFZmFBc3lWdDRZejMxaUVG?=
 =?utf-8?B?S1VQU20yMzcwMkpFU1VlUktNeXpHZWh1ajZOQjcvWDJLdTFtbUNReUlDNjJQ?=
 =?utf-8?B?aG5lL253d2xJeExiRWZCYStYbVhpN1BKUEg2eUxjWW5lS1p3aXZGOC9ZOUlY?=
 =?utf-8?B?SkNLRWUxai9ZTS9yREFFbG1FNWYwdGJQUGxoU2loSGYzbjhXSzlZNzdxcm12?=
 =?utf-8?B?TzhoYXZzRDRoeDdQSUNOZ3hXeXpINVZ1aGFUVDYwMXo1R2dLWkIxVk15RU11?=
 =?utf-8?Q?Qfv1ruC+6c/U1NDwfJsbl8c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vsG47Mu/1/OO4rQZYnt8LMd8DdUms/vjPVWVqoGH8dLXmLk0OKfZq+eSvn+PSp5xcb53ZEB/3R0yhNwWYT3JvnteTvk81njpCe2ff+ZaMHZKqjd6xR8BEJFiKQxeKvMQFDcgavvM+uLvUDzVxV1+RzQemRV6gMv3vKb4sQZJJYK2aCSTIWEOyVA+7av6qKZAK20qLVOTA0mFg/BvyidLoQ5Am9vnPClqxj91Hrx9/+ViEX1evdwxcq5iAKkVdWUcaKeW54bvEPlWb0k/eP4WisEYBmi2DXoialOINaT4DWNtic1KJZyTef6Wjl4PKMcUSoWpnzHWcA815x9QvKTePchQ25GgxCEGoZzO8gJ2l/dWLQYAZXM38njoH+KLR5I/R40ISCh8HPb9FfTDZ0C+B4An/s59Lgxz1OTASzMhl1hcjg+ULaTjM8ji7bzGrJvIndzJIPqEW36Pb95wy07pGsg5g57m5TNZP95DInlBq5bpYY6wktF2+2qGPitdf4M3KF7ijkziCyvKCOnL3b9ma1TcylOkVozMBoXmKZWoVYk+qXBPyBsz81wYlGDydSeKDdXWVGewIjWPxngCEXmodxfINPGPo/veB/19iJbJWIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b4fb00-17b3-4578-1ef9-08de079d1084
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 01:33:50.2972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7mxUd+RR1zgbLb9hTnyZS4CRbQqKficKmLVIN0OmNRC2wgj9p5yJFXoYfURVV3sVAd6Ggsx5eXxHxl9WjKk05pPKn2g2rurW3a6C8IhNj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100008
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e86282 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=EgHZg4ejM80VnCoI13gA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MK3GYbLBvwtfENe0RZtUypWPIaTy3stQ
X-Proofpoint-GUID: MK3GYbLBvwtfENe0RZtUypWPIaTy3stQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7p+M41PrK83h
 GWiShWhUHVSSWqVfRqNy4v8MP32cKJ6N3Vpop7BfK7XGkWQiivBlEk77b1Ce+wtp59gR4aZEHu6
 IpmkLUdDALGkaG9hSeQRBC8MwrkBVsnZHLRfvNccXzBDzmTGoQpyzQe4mr/pMOM+OXUZL3cQwSQ
 72YgIxObZL2ngRKSWbZt19Qa/w0cpmoe4plE1QfnVh3+Ki4t5fiQNRjXfsrqTClsRnRDO6OKncQ
 sFRZ1wH6sORzOkQ3ZrXyEhOaRrwTse2/ptszm/ghLjzKjuIpgp1RX39f9trP8uPb0WV2A2gL89a
 hBM1Q8T+mA3kFJIG2Ib9xKT/IJaqZTC4LSpsY/NE7PvXqmvxIq7wDM58X3s7MGH53CYeYR5A7cG
 cwIVDUpUhMgDhXi0Ip+4MlaOk3Ommg==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/8/25 12:43 PM, Sairaj Kodilkar wrote:
> This series provide fixes for following two issues:
> 

I was able to reproduce and confirm the fixes for the issues you list. 
Please see my replies to the individual patches for my suggestions.

> 1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
>     bus id != 0.
>     e.g. With following command line, dhclient command fails inside the guest
> 
>      -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
>      -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>      -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \
> 
> 2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
>     setting up the devices when guest is booted with command line
>     "iommu.forcedac=1".
> 
>     One example of the failure is when there are two virtio ethernet devices
>     attached to the guest with command line
>     
>         -netdev user,id=USER0 \
>         -netdev user,id=USER1 \
>         -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
>         -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \
>     
>     In this case dhclient fails for second device with following dmesg
>     
>     [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
>     [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
>     [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago
> 
> Base commit: (qemu uptream) eb7abb4a719f
> 

General feedback for both patches:

I know the commit log is not consistent so far, but going forward I 
propose we adopt the shorter prefix "amd_iommu: " for commit summaries. 
There is no ambiguity (only one arch has amd_iommu), so the full path is 
not required (i.e. avoid 'hw/i386/amd_iommu: '). Shorter boilerplate 
leaves more space for relevant details, and helps people like me who 
struggle to comply with character limits :).

Thank you,
Alejandro

> Sairaj Kodilkar (2):
>    hw/i386/amd_iommu: Fix handling device on buses != 0
>    hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
> 
>   hw/i386/amd_iommu.c | 166 +++++++++++++++++++++++++++-----------------
>   hw/i386/amd_iommu.h |   7 +-
>   2 files changed, 106 insertions(+), 67 deletions(-)
> 




