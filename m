Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94027C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bLt-0000IV-BR; Mon, 13 May 2024 15:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bLq-0000Dx-PK
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:28:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bLo-0008Lp-Uv
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:28:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJ2Cgj005157; Mon, 13 May 2024 19:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/4cii8BUp8Oey5ESbU6Ev1JA4jgb3AMjxSXTrbCoOiU=;
 b=WIZIK7YWhpDFTtnCWicjrZuJ/Iw5cQLwKYgDhqw+ZJcTyMk+3ja40tB4+IPvGMWrCNNy
 Ujwc3QCveovdeR/UTBfgAqDpEfgI6WlWhjm1X9tdt9/RHxHUWx1YnRoz+Z2KKkJVzvNX
 UwwAHaDP5VO0kdWxGNGo885+a3ZEzazaaJCkNLRzMaqRjlfowUDKmL5SNXpGtyn0UIEV
 jddZSrQZjwjDpcJhwPqf4PkzrVjj6OdIQZcZt9aBUCdNI3xmrbZ8PLijWoe/ZX+7bkM8
 mMThKzGL/sI67C4AV5eNkqVVd/8JnIhjRQRb5zJEbjn2TxivWSDpGDNvGcWF1jcKeIdy OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rnng2d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:28:39 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DIBRdI038288; Mon, 13 May 2024 19:28:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y24pv2pnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR/rlW6qkY+FS2T85kODnL45wBZZiGsK9rDE+NwLGjf++l6v4a+2vujVgBBjzgVpXoxUCfw5OEWQJdhKMYqMDIOiLZcEjL2hGy3lAYrVtf8Yy66bXlWGpAiLvVtb9AYy2G5d/XXL5YWKnmAG2zWDZXCd4W7K96oJ8xse8z+FJu1b4HBKjm+XvpeYsgyR6HyCr6tXPIL6we+LctyvYUlKC0pKoRL8sZ87TZosxfQP77FG414KSs/VTePsp2jEXa1+UIvURGHWrkghghwkzIMhmRcTEUPSATZUoRMla6s3JrydwGvWmBeGGMvGaTo59jQg8Th9HoE01h34G2791zstSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4cii8BUp8Oey5ESbU6Ev1JA4jgb3AMjxSXTrbCoOiU=;
 b=KgzM08WiQ7g0/2C6oGhkvL8q7lpukimDD2IIc9i87hAQ4U6BTapBaRKvdSKRSnTtOVzKUWYAsIR4hl26qBPJYJRG3Fhzj9CkNgrOlmPGivV+TttdNEJln/XrW9x8DXUxffHoLyBqsjujiaULS1GQk/+PLhuQ2KRnMSE1S8KjZ3WF0W1EN8gi49A345mdZo7qGDNUHF34zyuoLUgzrOOt5dB7RhwLT8xP9uDA4h4EmXty0opufI9YAYRcbG/z+zMwOo+QPlmcd9ODK7izE503wQb+/ZDIPN83j8hbtPn3ezb9oYF/lLQbZkPnubiqHGciRwHk/gPc6kXdRA1Rx94/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4cii8BUp8Oey5ESbU6Ev1JA4jgb3AMjxSXTrbCoOiU=;
 b=jYqgdq6OvyRtaTKBWJGhiW6ce1s0sOp2OfVtGqjbEfjkbOTFwtkOlcPCRzqjTsjOZd7i0flJYF5VxTP3FjTAWFyUrvqUj0RzabgQ4R/3dl9dhIlsHvkaJB0voYLOB+F0wIBTz+c3+UjsZ1knK0HOFS3zDUFAN8DvUIFuDETWW9w=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:28:23 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:28:23 +0000
Message-ID: <075b5a11-54d1-4791-bdf1-133c9dc8595b@oracle.com>
Date: Mon, 13 May 2024 15:28:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 05/26] migration: precreate vmstate
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
 <87r0edl4ip.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87r0edl4ip.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3b5981-7b20-4b89-f534-08dc7382daab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm1qVkdYVkQ2dFpzbXovR3U3NE5Td0VqWW13bDVQTklrcWtNSTZ4NkNJaDdT?=
 =?utf-8?B?Y0lWY0I3NDFWZkpNMGlYdXdpRWhSejRoMnh3UnBKRDA1OUlhMGpZWVJmdDA5?=
 =?utf-8?B?TEZYVTVobG1MOHJQZUFsN3FJeHUxSzVKeW13V1lhTjNHai9BSGNuQWM1bWdj?=
 =?utf-8?B?dS9YYTNvcllhQ3ZDUGkxc25VUG9xWFNEMStUQTdIZjh1OEVIeEhhdDJaUHZD?=
 =?utf-8?B?eU5SS1piT0hWay93SkI2dFVtdSs2aW5zVG8yd2Zxb21rcWZXeC9mUko2MTE5?=
 =?utf-8?B?cDZkYmhJZWxnWGhUT3dIVkhVWTBLSU1LVnpOdW50MmJlbkpRUXNqUndtb1lq?=
 =?utf-8?B?QTVUTjRLdjZpM0JTUlRHaU85d2d3SlVOZkVSKzZjYXpyUTExOWcyN2pScTJh?=
 =?utf-8?B?ZnFvdVVwcmpZZEk0UFFxdUpnSGM2V1BCbU1iUzRhdS9NaHlGMkxsZUtMUzFJ?=
 =?utf-8?B?L3ErSm4ydzd5aW0vM0NlK1BtbmZCeFhhNWhYMUttUmhCdS9OelpLNjBJUzlC?=
 =?utf-8?B?WE1VYTJSQzZsVWtJMS96S3ZlU0JGOER4dnBVYWJNWDJydlIwUmtkSHdzajVC?=
 =?utf-8?B?bG9NYnovRmVSNlhTSXpxcWIrUHNXUTBLM2g2ZFllVmc1VnozalEycm9lb1N0?=
 =?utf-8?B?dys0NWhxUkFibDd1amluc1lVLzE1ZTByOHllTWowSThGUnFTN0lWMHN0S0hZ?=
 =?utf-8?B?Q0tzcHQzSHJtWGJTUzZBNHhDU1pubTV2T1VWNFdTVUw1NlNKSEFDemlvZERN?=
 =?utf-8?B?TlRNZlE2QTVQcEZtTXNNNVNvTUsvNnNkL3NtM3NNK1dCNUpJVXV6K0hiYnND?=
 =?utf-8?B?c0NrQm5VMVV0azk2WXJmNHFKclYvMmJwVGllK29VWU81WGhZTG5BTmJxNDl4?=
 =?utf-8?B?QXRremNNM3BncWNlRWRsanRDVDNKQXZlT2M2U2FMS090Q1B0OXBvaTQ1eUI1?=
 =?utf-8?B?M3d0ZFZXYjk1OXE5Q2FjTUw1OXNTZEFlbmdsZ0luNVJadEtFUEFOZEtwaXg0?=
 =?utf-8?B?bElxSXh2dnA3dnZ6Tk9LK1BhZjBqaDRIM0VXbXRiL24wazF5V3NZTlhQaXpD?=
 =?utf-8?B?NHhaTTdJdkVoelBRdFNEdkhGaUlyQ2RGQ2RYM2NDRmRsa2NtYzhLMmE3enlt?=
 =?utf-8?B?NWsrYVZmZmIxTm5nNWVYaDgzdWx4NVJWWGlYZkg4Z2RLSG1Hd0Q3amp4MzRS?=
 =?utf-8?B?elZuOXZKVEoydUkvMTgzekxWTnRIR2N3RzluS2ZKU0lUMFo1L1lMSkVkQjVS?=
 =?utf-8?B?a0NTT0dGTFY1NEpDQUpZY3ZIVURHeHI3ZFNPdzllQkQzVk9aeHQyZ3FIL0Nm?=
 =?utf-8?B?R3FsZ216YXFRUjNvcUNQSXpoUnBBMnF3U0RSZlFvdW53YlRKV0R1MGdnZkhp?=
 =?utf-8?B?eTZjL0xvUWlod3Jrc0NqOE4rSGxWQW5aRHVLQzY2ZEplKytsNXo0VVp0eU9M?=
 =?utf-8?B?MEJGTm4rRzRwOTF0NU1MVmVPUXRuUVF6SzNBNndvRmVUc29ucjl6Z0FEOEVT?=
 =?utf-8?B?MmJUWjltSGZlQk4vNEtkdSswd0tnaW9zakJYL1RHak5hOTlYK1Y5b1dMalhT?=
 =?utf-8?B?TVdwdVZ1cTEzb3Z2YTlaQjBwSy9VRmxyand2c1BQWjl3UmtuUVp2UEpHUkpD?=
 =?utf-8?B?dlBSZWRiMkFNZEUzaXRrdUtOa2tNT09QZG5LenNRY1RMTnFwaU1wdlZmaXFE?=
 =?utf-8?B?a2ZjUVJBbGU3V0dlWXF3Mi9DSStyTjQrc0x6SnpscjlMRE81MW1CUzNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FONTZQRTNNYUtmWm1vWnphODdaeW1vN0dRL2labkMvVlJ1UG1tcStCcjZW?=
 =?utf-8?B?RXJ5b21tbUxxUG5JSlZnZWhMSisxaVNJUXBYQU11cHV2VjEwZHpmTmZkRVFD?=
 =?utf-8?B?NGJSVUtMZnVzWHdTTm9oWUFJNkpMUlNBVDc0a0FDR1ozWDdRVDdKOFY0Kzdt?=
 =?utf-8?B?YlBxNXdSWEozVjV0RUg0ZlNEdjN6SUhoOE9WcktOa0cyd1lXY0pmYUJlUUdm?=
 =?utf-8?B?QjRTQmg5WHRwWWROWkVhT1pGbS9tczBnTWR1c0lsNUg1Z0NEUlJhWVVXSkph?=
 =?utf-8?B?SmV1eG5JN2QxczZBbmZmck9ZNkdYYmFwTGpidGtVTGJNQWlLR1FtcEJ1TjBI?=
 =?utf-8?B?T0cwNGt2SlVtNUFKajdoOTN2dnZNSVhQRUtDVFc3OGI2bXU2R3Q1bzFqaFlB?=
 =?utf-8?B?YW5nOU9XSHJGcGhzSW1Nd2NGMml5MDNPZVExbFJIYTJ1S0dqK3hTalpUQndm?=
 =?utf-8?B?VmYraU44Wkk4M2NzZ1BlcHVla2hvY05IVkJpVkdnc2tOUVZOcVhSYWh4emJM?=
 =?utf-8?B?aFBjZ3lWWXdwMlRoY3ZnN096UkhmNEZYbGM1UENTc01QWElxUE1uSW1YRjg4?=
 =?utf-8?B?bFJTLzZDRXV5NjdBZE0rNm5TSHJVTEtudktnOVJCZFU1ZXJVT3F3c3RFQXVY?=
 =?utf-8?B?MFlkdXJydGVyRGZrRGRwbXE2b1FiN0x1NXJ1MzFQMW5KWVV0L2k4M3M0UXlj?=
 =?utf-8?B?QlVvM3RvT1FtelJaaWpKYTJyZjdQZE04MGNxOVRJOG9qbEZIYVVtNWlVSVAy?=
 =?utf-8?B?VGcwdGNKV0ZVT004NTRjNDRYdW1ZU2JoYitlUWxaVmZtU0gxSUUrQ1JoRzBC?=
 =?utf-8?B?NEttNXZuaTE5QS9neFdlaXMyZnE5M21jRGNQZndUVThpbzVKRUFmalh1eTh2?=
 =?utf-8?B?QUZ1aG9MT2JGYlNjc0lkbUgzMzdSMGRPekQ5UUJmQzg0RFVySnp6bDY5enlG?=
 =?utf-8?B?MTN0akljM2VqYmdoS2w2dkZDbWlTSmROdHJiWDQxNUV3bS96dHBITFZZNjBv?=
 =?utf-8?B?aEMxSHUzSTV6eFQ1dDYxc0hZeWJuRi9KNXZvd3QrUDdjSDU5RXpBSDUxdG5D?=
 =?utf-8?B?dEtOSkZIUGhQYmJjdlhvcVpoeGEvTzc4RG5CUG5VdzRZV1p2OUNRb09FdCti?=
 =?utf-8?B?a0xkOTZrWkx3cDl0L3RNOWlWY1kzcE5CdG5NWEZwa2NYendiUHRVUEh6bHlM?=
 =?utf-8?B?MGpnbWFTZ0tvVHRlejFBZTQ2WDdhbXcxcnBZb25VbUpOUTZ0N0k3QnA2MHFX?=
 =?utf-8?B?VzZoNTFGOEhacm04LzRkVGRxMXhqNEJVYXlNbmFOaDlsUzFrNy9Wc285ZUlB?=
 =?utf-8?B?STlCYnpvM09rVTd0aEVNTDNua0dWVFJONzUxRzl5VG9yWStpWXFndm5RR1dN?=
 =?utf-8?B?aHF4ZnNVbnZKVVlqT0R1YXJJYm1UVnovM2xLb25RUTNxMTR2dm84dU95MkNm?=
 =?utf-8?B?Z0szMUlGdzJaeEQ3cThhOU9xbTBHOC8wUXRUcTRMdy9Tc2IydjQxd3prMGY0?=
 =?utf-8?B?RGhoaGlCSjNJb3k3dEQ2cjA2aC80Vmk0eGVjSzRFaENGa09naHdyQytnL1o3?=
 =?utf-8?B?ME01U1hDK0NocUZzTnQxTmo3M3A2K0ttSklCUVVqUWhKUitMdC9kMFNlRHFr?=
 =?utf-8?B?b1R2Uzl6VjlsN3hmUHNGOFgvZVdmMGVhVUQ1d3VrcFBGTUR0aDdFYnVVU1px?=
 =?utf-8?B?NkpIWFlMQVVoZGNWNTR2K29JVmdXd3RmSWZ2WmMzOE45TWVUbElGaXB0NlBr?=
 =?utf-8?B?WlM1YUZycWFJSmtoRE9RZW03VnlKTDlzQ2ZoZjNISkEyaXlDQW1XVnFJbTFM?=
 =?utf-8?B?YUVtZnU1dXZIZklQYStZRjFHcGhOUndjbmU3dU5zcmNOeDNCMFltMlRrS1Rv?=
 =?utf-8?B?RHRmcjVRRjRwUHFHR0hpTGVvSi82c2t1d3VmZElBYWU3SzV1TXZqVzdVdThk?=
 =?utf-8?B?YzBZenc1Si9IYVJOMndhZU5MUFlBdlBNbTZ3M09KRDBCa2wxQmwyM1ZIUWpm?=
 =?utf-8?B?STIvRmdnbUVrNTJpVlVqUlJ2V1lvK3JscFM2eVVjTlgvLys1VisxZmxmeVVu?=
 =?utf-8?B?dnF0a1lxd0tXZjBDWTJVWWZFaDNHR3hJdVZRbEFSaFdDSnhqckROR2VLaGNF?=
 =?utf-8?B?ZkpkSjNEQ1Joa012MUowandYVHNmUU82OW13MEUwL3o1a3Y0UWZhaUxiWG9J?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UH4urV/yuvp9SLz5smOlPkEkhnePJxK0ys5L+0jlqLvzMM+Nfl24l2Bgi2f0RkQiv6d8Ijs7HkNf3s+S2UVDtvXQFTjSQWBuIPWwTNR6dbhMHgXQJqDSBI75XaLMe/fTgi8WcQsAnyWtnYAIYrt5dBjOKIynCtNMFYc0fw5/ZtqnQqpdxyHKaE1B2gFHr7G0qPj6IHBY/RiknvhPFRog5pFUubvnizKCWdWO9xQMjBtXBwNJaE59JYeBKhh41c2SNaHu4Y3EvR2iQjJyXBVsBuT8olQVncraMwfWjjrAyKgqHITUm3U6VDxU5GMIiVinKQRPl/AYsdbLdv/YXGsgUrGd0CXK/YFPR+CZV9T1NrUoNkR9o6CrlPKXVc0UH9/yuRNrbM3Xd08Edd8G/5LqgJUgl80B7xRnYvXtu/rTL/7rUB6LOV52a+6Xwewrxtz+IfwMBEcU8nawvaaMclcG4QxVOKstSG6oQnp3BKqymoJ7l2Hr0aY8sTVjA8uzroGmFfOHGlEcaeGOSGM+GgM4lA3yVjI2VKLNYZWe5B3Qf5ACaofASK4PmwojpdyiDf//HbOD3kUJtI6YEHMvirYhge+uvsjuea0noxUGC9Ax1x8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3b5981-7b20-4b89-f534-08dc7382daab
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:28:23.2710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gfmnuVVnYOMQxUxvm/BebSrOnTCWO7ZWiUw8/hCtJmmjtcAZHopYLPpZ4ge0/5YpUP6+W5qcoZy6/GgeO4ewkYyciMkjeZ2xQTOXzoJrWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130132
X-Proofpoint-GUID: dxLwDu1QgMafRsiRwkRcrlqy2pUGCcxo
X-Proofpoint-ORIG-GUID: dxLwDu1QgMafRsiRwkRcrlqy2pUGCcxo
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/7/2024 5:02 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Provide the VMStateDescription precreate field to mark objects that must
>> be loaded on the incoming side before devices have been created, because
>> they provide properties that will be needed at creation time.  They will
>> be saved to and loaded from their own QEMUFile, via
> 
> It's not obvious to me what the reason is to have a separate
> QEMUFile. Could you expand on this?

The migration stream is read in the calling sequence at B below, but precreate
state is needed at A before chardev and memory backends are created.

main()
   qemu_init()
     A:
     qemu_create_early_backends()
     qemu_create_late_backends()
     migration_object_init()
     qmp_x_exit_preconfig()
       qmp_migrate_incoming()

   qemu_default_main()
     qemu_main_loop()
       fd_accept_incoming_migration()
         migration_channel_process_incoming()
           migration_ioc_process_incoming()
             migration_incoming_process()
               process_incoming_migration_co()
                 B:
                 qemu_loadvm_state()

precreate objects could be emitted first in the existing migration stream and
read at A, but this requires untangling numerous ordering dependencies amongst
migration_object_init, qemu_create_machine, configure_accelerators, monitor
init, and the main loop.

- Steve

