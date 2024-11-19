Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D217D6C28E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUFk-0005te-Co; Tue, 19 Nov 2024 14:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDUFi-0005tH-DR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:51:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDUFc-0001dq-0L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:51:10 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMY2w021785;
 Tue, 19 Nov 2024 19:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=3cCx4D5qfuragunsMyvoWu89KUI406bzaSIv1O2SrE0=; b=
 X5COTP1QmMpXkX9nasKFRrAzniV3P0M6ShQxAxY2ll7ZBC9RJuqSjVkS/Y6o3tAm
 vlhLExaVK8yTIcME4sgmggRHzPunxYr1qAdhG2N691aEw5c70zjidYKWdoNqvNeb
 YKn5coGq4cMH5xgMQonYSZM4Npjm1ksPjv6CejVubdD0a1+NVuXAUc/0bSUKz04B
 YPeyhPHQaL7E5+gp9VI/Y8siZDG85q5r0mLL4JQX1OFxXnWshEZhgZel3Pa+LXJf
 epp1PXU/OeTyK6hTBqtJDvj4mXEsT7xKemp6D/OuISoEt3MLsv84r6XcEI9MlTy8
 4EU53XhipItmmaZW6OGrIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa5vud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 19:50:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AJITmFj023074; Tue, 19 Nov 2024 19:50:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhu9f0fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 19:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRWzPfr9LZDb0RqD4cIB/oLRVr7/z1cXhB6Ta9PaX2xQI9m9PqlqXMQv0FWMFcfAFUu5UPoLqr2YVw2/fZWw8OuCDernkSP8y0Uad6kGk9WjZ4L8sk+LcrmorxAcDph97B+K5SAQmvn/cUM1D3PuzPZaVXDjiXsnKHHIeyeOD1zuBPNajyeHelCjlL/t5zpXbYAxu4cKuztvjth5T5gtLA5+XSrzVRAvfO2ar8dYNapNjldt1EEufQCn5dTnzHzM4e7Lmzpc9kbx03JpM7aKc+7nlyFOnPRVdiq1Yce821mZj9UPmgi3V289M38pHriC3iBW9dGT8AyoMs112Qk34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cCx4D5qfuragunsMyvoWu89KUI406bzaSIv1O2SrE0=;
 b=WI8Civr2aADoCAc0zbzr8JqhZkZCJC+2RhYWDGcGQnFCSvxaJ4oitKghZO2EcKSZGeE8U5tuvZlKvEynpT8s6vmqZ+O9w2NobdrSiZvdxNDH6rOBTyUXqr8QhJ56Te1jIgBCvBjpHWgeIiyPGPmzqv6Hsf/6I/WZbDzgMAVX0RgnwrqWY7OjRdHyMp4kKc3RTGwX/vnAFbhlaZ/4w+mhwzcmBZ/Hg3qRZ2h4hHFKSUz6GL4xyHCmSlaPOSiTrk8P1PDhwEklvjtIWihJPqItZx2SWAX/YSVYviIg/7zQINBfNRB1QnsVuUDxAwK01vSnLl4uGUtsGu3BdfpV3LAZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cCx4D5qfuragunsMyvoWu89KUI406bzaSIv1O2SrE0=;
 b=GPtUE9Uj/KGF57jnqR130V6hfpix7UUw14d6X1ZBg4ZbzXmvMzkl7sk7sZHcziH6kvFGgwS52IjE4S7cwGdABQ53BAF6c0/W+RxcFRorE+uQ6lL7cDIuh5gc7OLw4WwmWTBk5UwByYNEMtTqsBfWNj72pufKqlNtMLBhsSUIH7E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 19:50:50 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:50:50 +0000
Message-ID: <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
Date: Tue, 19 Nov 2024 14:50:40 -0500
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
 <ZzZJvTldpe3D4EO5@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzZJvTldpe3D4EO5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8eddfc-beb1-423a-7efa-08dd08d377d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUpWVHpSVEdMV2gyYWw1b3N0bzR2czZ0MDZ5WVZqeEJxNHlYTFBUN2xSZE1L?=
 =?utf-8?B?Q3h2a09nSVpSV3JxTXNBZmF3Y0dtWG16SGx6VzZKTDZYRmdPcGFzNWgzMGZx?=
 =?utf-8?B?L3U0UWdLOS9iMnA4NDlCMEU5cXNQRVlHM05EOS80MmlCcjJUREdjYkcvbVY5?=
 =?utf-8?B?OURWeGpqcHFUU2QxcHp0ejNkUFVkTUpoMVhJcHJzRVBidXdiMXVqMWFhbjE1?=
 =?utf-8?B?L2F2ZkR6M0I0WmdUaW1rWklNMzJPZVFTUkcxWSs3dDFGc2tTbWQwTFB1TzRh?=
 =?utf-8?B?UVBtdXdGOFcvc1FFVWlwa1NSWVF0dkhLbXAreFh1VzFjZkxmV2lNZmlySnB1?=
 =?utf-8?B?ZUN5R2h2aEtyQ2xnNHc0dElHUmt6a0pRTFdWa0JKOGFjbkMzMHR4NnFmb0x4?=
 =?utf-8?B?T2JFQVVvYng2OS83MGxJTWlKbUt1WkYxWHhrbVJVeHJ2d3I4YXdsUTlsTzhw?=
 =?utf-8?B?WXQxOE1OajAyZHVQWVYyZFJ2TVREa0N6aWhmdzVCbHZrTUpuY29wWkxDemE2?=
 =?utf-8?B?R0lnQk1xL1FFdndMZzA2WW04RThLTEZ3Yk93M0MrQ3FYRDRMbkE0NnVyWEtX?=
 =?utf-8?B?Y01xaFovWmR0LzlwZDd1eTM5T2kzaGFJWWNTNXo4N2IvQzR0bmFJYk5KdWlJ?=
 =?utf-8?B?R3Nwc3FMNC9OT29jQzRYVDd3TUVYNC9mQ3pxWERpeGh3TTg3OTlISVcrNU9h?=
 =?utf-8?B?OU5NcGU3cHRkTG5FZTJVVmtpaVlFemNCUGxWTFRNSnV3d1JvbDlZWHc3cjRO?=
 =?utf-8?B?RFlhMCtMYXRFTHE5d1AzWGZpb2dXeXJMTW4zZ0JkakRESUQ4N1RaNFdtMCtx?=
 =?utf-8?B?RkUzeHdLa0VtZ1lQQkVXcmhhNWcxNEZwMFU0aUtYWVVsRjRIMjJ0U21PNlQz?=
 =?utf-8?B?OWl5V2Z6MVJGRFQxT0Exdnpsc1J2VXdTNkZpQ054UEtPYmowRmp3VThvY2ZJ?=
 =?utf-8?B?MHpRSVRRVTRBbHA5T2ZMS1ZSd01mcmJJMFlZdVM4cndHVXh6RTdzLzZLRkkv?=
 =?utf-8?B?c2ZnSm5DN05ZTFBJVFJ5b0RlWXgrNHBQNzU3R3c5K2Qrb2NUVEkrS1RaK0Zx?=
 =?utf-8?B?RmEyM01KNEsxbXZWSmY0bmM4OHhQYlNsK1pySXljZTJMM3R4ZmhRU1VQUW13?=
 =?utf-8?B?d1RnUFloaTl5UWVqaklSRFdDSzRKNnVOZkZLQjBxbUVPOTNYNEFObjBGWVE3?=
 =?utf-8?B?VER3ZE5oNy8yK29TV1AyNVYwWGxuRlNYaXJTY3NBR1FVYlFRak5TUDVmYlQ1?=
 =?utf-8?B?UzBRRzk5aUVQeGZZbWJtdmhuQ2hSKzg4YkpSOVVINDVTMnhBR1V3M0Z1dDFo?=
 =?utf-8?B?Zm42Z0k1bHRYTmNvYnlkcmNPTE1TSXRzUUk2b0R0QnZUK3RFVWpuYjVmSWh4?=
 =?utf-8?B?eU5OZWw0cVh1UWp3ZXJYY2EvakhXbHZBRXI1ZmRaakVmaVE5SE5zQ09tQUVu?=
 =?utf-8?B?QWlIc1V3elhzdmw4U1JXYzcxcEpKbmN2elFsVlMydGdMb0FVNnd0WUZwckJ4?=
 =?utf-8?B?QXMySSsyNDNsTFNvNFJPdE5hbkw4MGR4RHlORE01TzNHcGtEK3dyK3FMZWxI?=
 =?utf-8?B?RktObnh1NTdzb1RxaUZjelhteDJ0bkVXYi95eFc1VTFqeVpnUlpXYkYwVXBH?=
 =?utf-8?B?QUI2VmNGV0hDVTVDaVFDb25RMmtOQTFjNy9STWtZVnZFRkRCRUpsWG9vZHcx?=
 =?utf-8?B?QXU4c0lSc3J3THpQQ0ViK3JsTU9HaU02MUZPYkZHdWtKVEFRb0VwVG9UMVFo?=
 =?utf-8?Q?SKJIv+dD+hYmESDuqezUaVYDO76BF6hxH/Zu+ok?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1BpcExRSHBFU095SkJrd25zelRWdG91SVdIOXN3elpnZVZqZm96YmVBWlND?=
 =?utf-8?B?Ykw2clZMVFFkU3pjdjhnOXcxZjFPN0JwUDJXSys5MTZKOW5zWU1TQUczdmpG?=
 =?utf-8?B?VTdaVlZQSURwd255ditGcUcxcUlnYlU5Q2lhRGl5TG5KSVFXa1VKSmFySkU1?=
 =?utf-8?B?Nkl5WkZvcU5lUkVCMWFod3YyVmh4dXMrc3FuVGk5OXBHV3pXQUlzNzhkU0lH?=
 =?utf-8?B?VjZvV3hGdHNLbWg0NWhZeU1BblI0OHUyMU1pUXo3M0JNN1F0U1JGb1hLVEVp?=
 =?utf-8?B?YTdXdGZRRm9WZGlvVm1RcFZ6SDczblhLUFVpaXJkNzdwTTNJRFlvbENhVGFT?=
 =?utf-8?B?R1h2c280VXN5QnpjMzRkNjU0Sm52VTFuYml3ckdVakFaa2hKdEpJeVpNZ0xR?=
 =?utf-8?B?RlhsUFliMEFDb1F3VVA4RVpKS252NEk4Zm5TUjdCM0ZQbitRWTlTbUhqOXdZ?=
 =?utf-8?B?T2w5alpSZElXZkFFUDFjSlVscDhLQTJ6ZGZnUnNJVERtcEFIOWRBaG5ta0Ex?=
 =?utf-8?B?S09ERE1hdUJ4cDlJWXRVYUlOUTh3TzFxT1NreFZoR05iQ3labHovZGFUYlB0?=
 =?utf-8?B?RFlrcUpiV1l0RkJmQnF0Y0JDYkluZ2xoYkt1allXLytzREFNdXFLMzJjTGhy?=
 =?utf-8?B?Q2VXZzRjWUNqUU5XK2NDMTFjUVVWZjFqSlNoT1A3NTZnU3ZzbThFUEhaK3hI?=
 =?utf-8?B?OE9JaEQ3R0dvR2pOMS9RY1JYbWhhUWxMV1U4Y3ovVndKRkJ4VXJmb3ZIbDRr?=
 =?utf-8?B?ckt4bVlEcGsxUzJKN1EzYStRSFAybVRnQ3N6UVRFVUgzWWpsUTVCc1pVdUUr?=
 =?utf-8?B?bXRDNm1mVTcyQ2F5WmhEUkF4SjhzNUNtaS9FM2duNzhReDlnbHNHNVRPbjFj?=
 =?utf-8?B?VU82aEtDZ3dwMWtFSVlqMnNuVjZrZ3Y1K0VRTEJscXY3OVN6ZWN2eVE1dURt?=
 =?utf-8?B?ajJnV0M3S002eERaaDZOd2RVV1RJNEVqbEwvQWFCTy9TM053Uy80Z0duWjQ0?=
 =?utf-8?B?bjNNVnBhaEE0d1V4K2tzOHl0V2xaU1c5QnljaUczTi9Pb05YREdSNjNMbUdC?=
 =?utf-8?B?cXZSNU5KTEprUnFUMWVkeGExNWh6dmN3dWQ4SStaNmRSMThGZTlMb0VLZW9B?=
 =?utf-8?B?L1hrRVdkMTNQK3RKejAvazkxOWRyZGlGR1RVa2JVb3JwU0JuWU53NWY1Q1h4?=
 =?utf-8?B?YjdDKzU5aVlEWDkrWDVsYnZHSDgrMC9ta01jODZwcmFEMjUvNkZENzV5NFRQ?=
 =?utf-8?B?WDdSdXZXc3FjWmx0eGZhVDhSejZOa3FKRHlqeTBiRTlMbXgwblhmV1ZqcVdl?=
 =?utf-8?B?Qk0zd0YreTkwdjhKMlA0cFRXU1lZRWp2b0FBT09MeVo0TTI0SFJEQkpFUktp?=
 =?utf-8?B?NXpidDJOYjYxQ3JmTVNZNnhpQ0ZCU3BNSnRlN0ppWExwaERXMlVoeUZ0UE1T?=
 =?utf-8?B?dktqTzdCOUhleTh6Q0dXcmppRXpxQTNoSlRvM2lycFhLQzE1aFJUOFhrZXhI?=
 =?utf-8?B?b2s5WnZHajhnQmN1YmU3OFRUNTVkV2pFNlZLb0xESU0yREdNU01rNnI4aEYy?=
 =?utf-8?B?NFJ6ZEk4TE5Jc3hCaW15VUlzSXFHSXRucDgzSVJtMS9Id2w4VWNvaUZockxr?=
 =?utf-8?B?RUwvZ2J6TWIyY29zeHpRaW9mZWFiT3ZwZDNqNmpIamprTjZHanRVeUpNQXAw?=
 =?utf-8?B?WWRMdDlZdnhNdlhkNUU3bGg4czhqUERCbDhrSGNUNzVRNlFKaDRYQmtlMy96?=
 =?utf-8?B?Q1B2aVJWWXltRk5DLzdOd3JhSzZ2a2hqWHJNek1rd2srRUViL1dzK29HRTBp?=
 =?utf-8?B?clBxckhiRklubzhrK2hkS3lZTGdkaDBoWHJZTGlpTnhrMmZQWDFTZE04Uzkv?=
 =?utf-8?B?WmJNeWNWT2FCcjlLMHphWFNsQlY1N0FaRWg3dEVIbEFhdlM2RldBV0NocVdq?=
 =?utf-8?B?Zmh4aFhjQ21kYWFyZzk2cVF3SHZFM0RGeEZqZy9oQ3Rpb0o4c2RMaU5SOVVL?=
 =?utf-8?B?ZUxGUXNjbXBvMjlWdnFxRkxlR2VTL2lKZ2VlU3BkQXdLdU0zOGFBTnN6cGpT?=
 =?utf-8?B?TlNFcStoQXB6TFNDZHd0UFZUV21rQ2tTNDkwUGJ4MitDblEyZGcvTmFsRjZ5?=
 =?utf-8?B?bFRuemhRL0pHZXpYR0l1SkhSdDZGcjhmd21VM2RBM1RZLzI1UDhFcTY4WVN2?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r4o2nmN4CUY0hifu/NNZTilBycGk1MAcDT/6rrcKZyeJd2lqoz8TqRAqmNlpBphAYnB3kAtE+u98Ir81GhA4i3r+HLbUDL/qQ/8B+d5OOT3SIigTNp4LD7LWQGpTJCwgA8V3TH8qGTP8GFbTehmp7st3uiOkJh8Fkf41saSFTURPNiIrrkmlXACPbAlb0zbdpl3ItEyxPWYxhAI4LEHUM9yfmuV8RxKjIQwZ/4R3/pjzJ11wlfiuVmRMJ5fkfZaFm1uH/FEkNi+CGM6JryKHGvqAdyJEO5SIwpZIKb1OYa5Vy/Qi8xhGqzOzOt8vcRWsNgR6Ncd0ypmXr0csG4KzBlQI9ObT6uLcSkKZXymOQEh2nRXf0hN9tivrRe0lhP5EP5/rlmcFylbTa488w9CqPoMjvWNFC3zPjqVuPoLLT/dXLUi+utG6iOMtuVXW+jdSKOpemqriZWWH8/BwWdXFKhuEZjf6btRrbmSmO3B1dC1gBR8vkd/wdwwLxyIiU+szHGeYfXoNoikTsWq1QphQyADguvr1FF6lG+8U4b0S6JjK8vJ3eAB/R493mlIZAbdYidNSg/EL9moNw7KUq91b/EhnI6Lr5yn1cubluFPMyOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8eddfc-beb1-423a-7efa-08dd08d377d7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:50:50.0437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DQWP/YCg9eBDCKu8JIUU18Xhl/S//jb9ntFcYRfZ1db4URPiDaSIRSAQXejtZnBmCxsHhWXQM9Z5vbKTrGma6mKYKV7xI2m/4lESVf5zQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_11,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190147
X-Proofpoint-ORIG-GUID: ELV1hjiIg1pDuKPTKiJFwTn6Etc3oPq-
X-Proofpoint-GUID: ELV1hjiIg1pDuKPTKiJFwTn6Etc3oPq-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/14/2024 2:04 PM, Peter Xu wrote:
> On Thu, Nov 14, 2024 at 01:36:00PM -0500, Steven Sistare wrote:
>> On 11/13/2024 4:58 PM, Peter Xu wrote:
>>> On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
>>>> Add the cpr-transfer migration mode.  Usage:
>>>>     qemu-system-$arch -machine anon-alloc=memfd ...
>>>>
>>>>     start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>>>
>>>>     Issue commands to old QEMU:
>>>>     migrate_set_parameter mode cpr-transfer
>>>>     migrate_set_parameter cpr-uri <uri-2>
>>>>     migrate -d <uri-1>
>>>
>>> QMP command "migrate" already allows taking MigrationChannel lists, cpr can
>>> be the 2nd supported channel besides "main".
>>>
>>> I apologize on only noticing this until now.. I wished the incoming side
>>> can do the same already (which also takes 'MigrationChannel') if monitors
>>> init can be moved earlier, and if precreate worked out.  If not, we should
>>> still consider doing that on source, because cpr-uri isn't usable on dest
>>> anyway.. so they need to be treated separately even now.
>>>
>>> Then after we make the monitor code run earlier in the future we could
>>> introduce that to incoming side too, obsoleting -cpr-uri there.
>>
>> I have already been shot down on precreate and monitors init, so we are
>> left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
>> on the incoming side.  That will confuse users, will require more implementation
>> and specification work than you perhaps realize to explain this to users,
> 
> What is the specification work?  Can you elaborate?
> 
>> and only gets us halfway to your desired end point of specifying everything
>> using channels.  I don't like that plan!
>>
>> If we ever get the ability to open the monitor early, then we can implement
>> a complete and clean solution using channels and declare the other options
>> obsolete.
> 
> The sender side doesn't need to wait for destination side to be ready?
> Dest side isn't a reason to me on how we should make sender side work if
> they're totally separate anyway.  Dest requires -cpr-uri because we don't
> yet have a choice.
> 
> Is the only concern about code changes?  I'm expecting this change is far
> less controversial comparing to many others in this series, even if I
> confess that may still contain some diff. They should hopefully be
> straightforward, unlike many of the changes elsewhere in the series.
> 
> If you prefer not writting that patch, I am OK, and I can write one patch
> on top of your series after it lands if that is OK for you. I still want to
> have this there when release 10.0 if I didn't misunderstood anything, so
> I'll be able to remove cpr-uri directly in that patch too.

I made the changes:
   * implementation
   * documentation in CPR.rst and QAPI
   * convert sample code in CPR.rst, commit messages, and cover letter to QMP,
     because a channel cannot be specified using HMP.
   * migration tests

New CPR.rst:

-------------------
   ...
   This mode requires a second migration channel named "cpr" in the
   channel arguments on the outgoing side.  The channel must be a type,
   such as unix socket, that supports SCM_RIGHTS.  However, the cpr
   channel cannot be added to the list of channels for a migrate-incoming
   command, because it must be read before new QEMU opens a monitor.
   Instead, the user passes the equivalent URI for the channel as part of
   the ``cpr-uri`` command-line argument to new QEMU.
   ...

   Outgoing:                             Incoming:

   # qemu-kvm -qmp stdio
   -object memory-backend-file,id=ram0,size=4G,
   mem-path=/dev/shm/ram0,share=on -m 4G
   -machine aux-ram-share=on
   ...
                                         # qemu-kvm -monitor stdio
                                         -incoming tcp:0:44444
                                         -cpr-uri unix:cpr.sock
                                         ...
   {"execute":"qmp_capabilities"}

   {"execute": "query-status"}
   {"return": {"status": "running",
               "running": true}}

   {"execute":"migrate-set-parameters",
    "arguments":{"mode":"cpr-transfer"}}

   {"execute": "migrate", "arguments": { "channels": [
     {"channel-type": "main",
      "addr": { "transport": "socket", "type": "inet",
                "host": "0", "port": "44444" }},
     {"channel-type": "cpr",
      "addr": { "transport": "socket", "type": "unix",
                "path": "cpr.sock" }}]}}

                                         QEMU 9.2.50 monitor
                                         (qemu) info status
                                         VM status: running

   {"execute": "query-status"}
   {"return": {"status": "postmigrate",
               "running": false}}
-------------------

- Steve


