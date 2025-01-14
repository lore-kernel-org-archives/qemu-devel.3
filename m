Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64539C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXoFe-0002xJ-06; Tue, 14 Jan 2025 16:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXoFT-0002uC-9p
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:14:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXoFP-0006pu-IY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:14:55 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIYG4m000749;
 Tue, 14 Jan 2025 21:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=IuDZ+A7w6e9xAdqwT7O/Ucn0gRDQcz9Ar5ZxvlN88ew=; b=
 bZ+xRma4xRBeXH57+oLQaYefTX27uisoN62faa/Rjk+y5/DmUftaoO/8Fb0wuYFb
 hcQtnsMMjEdhnmeNNMpDGJHlFVoHYU3lIB2e91sJAb1yUkpIDGbM7402kd0OGUBD
 gHIcihbNK9/+1CxY3wE3xx4kMg/NBxk/ENdts1iMHt+pV0ncZfWB1cXS2SnZ+zY2
 ixFy6NioJnMtqcnY6jgSDvJLcXtrM3vNJ6L+DY72CV9WXuqpPSHhWW5QQpfgIJ4D
 5PpkxAUxv1cCwADj64s7AuiGtQVqPb4S4r53wNmXQXtIeOKOZqia2h7VKpP6HKyK
 vr5TfTWDzWLOBS1T/gXmow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y6mxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 21:14:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EKXG2k020411; Tue, 14 Jan 2025 21:14:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3exwpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 21:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMVKdDrNx9Ox00Z0AaPc71XvYJVcLVfh/16r9HBLjVRqlhwCUH24/U0P0no1gDpXD4zAz69Fg1GHDGkeeeFeOHfDEWdH062VL1Rv9L4TfZsXbfieOMCoJwLDNWSBFCbAzqqRafS6VbgcRJAGQhIHM1r1vZfvA2/W79e6OwJk80w8ioyCJyvxqr/NXToXRzT28eLAQ4TpQYpLfOm/hOphWLrPRUJ8pWCqBIcgIUF4vDmaqjE1bUCV8kqln34rqtsAPYib7S2CyG5I2BrQ4f2tI5YZnWxAmoEH8ezc0PVz7QWqMX0TjA2a6NT5L8zVwpvjxDSJIDIAwL7APxwb6CzOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuDZ+A7w6e9xAdqwT7O/Ucn0gRDQcz9Ar5ZxvlN88ew=;
 b=OlzTCM2gLFtzeQqYH35n3EN6aaBwlNMfbh57fCrnz6F3+Ms4z6J9aqWbPhZ3fAVKpjysCjspWJ+szte6YjRDqB1JZETVB75ZaJXmyaQVdWUMYTkLrbuje+0koAPpaNldBlGxxW+T7q/Ii7O0WncW7cxb3nOmaKp3OUe7EXRLHnUx3DFsUg9VpVWbHG9Q43azNWGMLKsygcLFRANN4gX+j2imbJfa7UJKtxClkS+altLzr7RuhL2FCTm2XkNMgMMoruT/5/j8GHIiPc4FHZppv4yg05N8pduFigow+ELyHI1y+/WvW7EGJ7sAOPu2CiPQ1tXT696eHXRkJMH4rTggdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuDZ+A7w6e9xAdqwT7O/Ucn0gRDQcz9Ar5ZxvlN88ew=;
 b=mo85wDho2Lt9YM2mkOWHTMfxwIo1zyXNV6HyP3rFgsRRA3LsI+QQmyjDDg3hq7Gp9ZDx2Ls+qb3bTBBpp5AiRa3iWzHgKhfS8hSH421lhqkccD/+J4rMwRsJp4tHfZa7v5rnnU7DT5q5qHrDIL1WQDrLv8GoCREGFxZ77uJruyc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 21:14:43 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 21:14:43 +0000
Message-ID: <31ff4dc5-d51d-48b4-ba39-58d864f9ecde@oracle.com>
Date: Tue, 14 Jan 2025 16:14:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/24] Live update: cpr-transfer
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <87plkpf8bn.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87plkpf8bn.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:208:237::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV8PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: aee32f05-04ec-4efc-c8d0-08dd34e076f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3kySmZXLzJrZzNzVWIweHZ0V280czBlZERjMmNMdk0zbjZERWkxUC80clB0?=
 =?utf-8?B?S0RqVzcrcGdJSHFIandiTkVKYlJXMUYrTHJkTmNvNWp0MGRXRVhYSllMVGMr?=
 =?utf-8?B?VHNRbWJ6UncrZXIrc1A0RGY3blZMcGg3Ym11bk82WW9MVTFRNEszTXVpWkMz?=
 =?utf-8?B?WUxKUTErT1Z2YkViVUZ5WnI3OWdtQ1Y3bGNkd3E2ZzRYb0lMdWo1dzJXbnFm?=
 =?utf-8?B?WVJoSTIxUjR0YlV3Unk0bUg2RmNMcWVaVWI3OE12RHJNVkV0L1RIdUhMNVlt?=
 =?utf-8?B?NlFEM1hpbWptRE1lTE5XSkhRNkhiK3YwS01pYlRVTEk5ajF2ak1ZczlMT25G?=
 =?utf-8?B?SFBtdHloWDFvNmRFVmI5N2VKQ0RYU1NycTJBdFRROWtPM3pabHMrNkp5NWRw?=
 =?utf-8?B?bXF0bG1qQXphUUlMMi9qYUV4TjNnUWVSbFpZNlZ3OTBPcE9iTi9SNkV0MzZG?=
 =?utf-8?B?WTVnUXBuZjZBeGZ3Y2Z4UWM4ekUxd0xpMGpIVmhLcVUzQmJmaWRoK0t0MHhM?=
 =?utf-8?B?aEtuZkxMV2lJcWpnL2dMWEY3SG5kaUQ5MFlJZTRBMGtVekowRVFnZVhtbWZN?=
 =?utf-8?B?ZHZpdHlIUldRdDNSaGhRQ29WdEY4dm8rL05QOHl6aC9WMlBmWk9hV0JUSUFL?=
 =?utf-8?B?bXp6clBmY2Z0eUJxakRoUjg0Q3hydng2akRsRDN4U0NFZEZhcWQ1M3o0QXBL?=
 =?utf-8?B?LzFKK0prSjVYbU9GTUwxVjUvY0JtRmd4dWVYeHRFaVdkTDBZbFlPSU1obHd5?=
 =?utf-8?B?bnFyclorSmE2b0F0NjRzRnJORWFRcmRDZ2hMVDByV1c0Y3g1MTFOK1FGcjBT?=
 =?utf-8?B?Nm83Z0NKcEpHZ0VsZmdlSmpMSW1MMVY0b3NNQmxZdER2YVZHZWVqY2JuWjFr?=
 =?utf-8?B?Ym9BYVdEc2RzUEY0S2hwQUNqOUVYbFU0NzE4OGYxS1I5U3pMQ1JsdWRxRkli?=
 =?utf-8?B?UWVDSDF2eU1sMHpjMElEajZmYXJwOEhSU01BNEVTby9aTFFPdjNKMXJGTUtI?=
 =?utf-8?B?MGVMT3pOemR2VzU5UVlBaTJwa1M5cW5Bam1IclppaUZuWDhsK042RnVzMTlH?=
 =?utf-8?B?SjMvS0RVdHowWXVHQ2ZyWGZHTndBbWZxamZyVVltUDdiL2w3cHpVSU1MQTZt?=
 =?utf-8?B?Snd3NElnRUF6TmowVGtHc000R2JFdzJlWm5zb0c5Wm1PenZzbWVJRHM2NEFY?=
 =?utf-8?B?cWtvbU1ieEJqcGFDcnM3MnVlSzhLbks3cjM3ZnBzYjVBZ2V1SzNFK3A3T0lN?=
 =?utf-8?B?YUhWOUx5cWVKUFgwTTQzeXVYd2pienpPU2U0TWJCQnViaW8rcCtNanQ5ZlYz?=
 =?utf-8?B?cllsWkJZWEIrRW1PQ0NJQU8rQW5kdVFNMmIxUnF0Um9GR25DbnNCbENOSVJG?=
 =?utf-8?B?NkVIVXVlV3UwR0pCK210MFBEZ0d0S29YWlpPZkxwYkhNcVJBSjI3WVZLa05Z?=
 =?utf-8?B?ZkcrVzUrRGVBVDlsZG1GQmMzY2NpVXgyK2N3U0ZhVmpKR2tjbVJRa285Nm1B?=
 =?utf-8?B?cHE0T2pXVUkzYzdoNVNXZ21yUGQ3NW1sUnprTGlwbG9nc3B3Tlc2OVBwM2xG?=
 =?utf-8?B?RFc5bURQbDN2QWt2UHY3aGdOdFoyNlYwUFFITklpWXdvZVIrd2s4ZkRtZS9U?=
 =?utf-8?B?QkpGMTJVWGVyeFZON1RkRUpIL2pNZ0J6RFowTEJWRnV3SVlBbGNYVnBXWEdZ?=
 =?utf-8?B?K09HQ0ovbE5XNjYvL3dubUYrTUJVM0xTSDgrQ2xJNHJIRGRaZkdwczJzamN4?=
 =?utf-8?B?eXRRU0VzeWh4NHdKNnE5d2hQazlMR1VJWVNTUnAwN2h6blhkZFhLMTY3c0pG?=
 =?utf-8?B?T1MxQTBQZnYwTlM3WjJxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ZvRDQwVVV4UFJ6RXJVcTB2akNTVllZM1djVmZjYXNCTU9MdzdEV25zMUU1?=
 =?utf-8?B?bEN4MW5xcmV0dmJqNDdCVzJDNy9YbjdXR1MyMUx3Q1l5NWJRTkZ5ZUo3bTRn?=
 =?utf-8?B?VUsxTEpnTmZTRXVGZDIvMXFxanBGVys1dHJIbGMyUGhaTnhoZVhRTzVBWXdq?=
 =?utf-8?B?NXNHSXpWWlpLenFHeG4yTW1CYjYreVB4YU1VRFkxYS9Fd3A0UkJRc1oxaVJF?=
 =?utf-8?B?S25GclpBSFZ6a3JPeHBwajhPVktLNVZPNHdOVHpXZVpaQi93R0N3Zitqbkkw?=
 =?utf-8?B?OXhlUXFXRjR5c3pwTHQxeE85dHZmalp1b0x3MTgramNHNE9iSysya2NCSzNa?=
 =?utf-8?B?dTlRL2F6T0plZXk4TktycHREd2JMRUlkaE9FZmhId2E3S2VEM2xiUGUzeVJ2?=
 =?utf-8?B?VFFzMlU3dS9uQ2UzNTNSNXY5MmdkalJaeWU3TU5XV1RLSkROc2llSWlJNnU4?=
 =?utf-8?B?blF5T3NWSCs2aDFoL0tMc01vaGZNQW41WUIxVGtxT1p5NERHMU8rU2cybSsv?=
 =?utf-8?B?YnZmTDZLT3hDTXNHcDF0S3U0ZnpOYmRsZmtBcUlselIrRDNDZ01hMEZ0UlFI?=
 =?utf-8?B?aElKVWErYWdJanllUlExZS9kTFVSaGUySS9iWkxKV0MyOWlBdE5BZHAwTHdx?=
 =?utf-8?B?QWlNYkVKM2FIS0JSYXhBb2lUL1dhOXRDTGU5U2lGeEhCUEpxd0hGeTNoSzNR?=
 =?utf-8?B?WFVSbGJLWkdXM2NvVnF4UHBhM2VJdzgvQkJtVHVGUUhzY0pmL0E2K2dmZkkr?=
 =?utf-8?B?WVBwUXZWTmEwdnpCMEI2dEhsbVl6WWYzSnZmT0ordFZrR2REWU9NT29mM3di?=
 =?utf-8?B?MGVVdkx5cUlUTGZhUmFWRXBDOGxkUlFpTVQwdGtpUnBXeDR1Qlc5SitrZlI5?=
 =?utf-8?B?dmIwSjNBdnVWNnE2VW52N0JId29GbURBR0J5enh1ZVJORXFOUm1Ib2ZnVTNp?=
 =?utf-8?B?RWNVT2FOWVcrTlMvL0tkWFZpQzA0VmVMOEVQS252M3BITVQyV2g3WXM1Tnlz?=
 =?utf-8?B?amE5R1VkYjZmVTR6U0ZTR0R5Y0paVjVMRmV3WFRsVW5KZ3QvTmJraEVJc01x?=
 =?utf-8?B?U284OTk2cGZOZGdneHo3VW1sN2xOUGszMWpLdWdraHd1QzNGOElaOXAvN3Js?=
 =?utf-8?B?T3dMTEcxWTNUVEFXTEN3clJ2ckFJcWUwRGhha0FsRTgrYkgvWHVSNWM4VzVG?=
 =?utf-8?B?ekdhODZwOElyRzFLVjRHVStqR3pWYkdlMU9pTlUzeG5oYVJDUUdNcEQwT3dJ?=
 =?utf-8?B?b282bFVHQkJOSUJjVU9kTC9MbVpHRUhqbHdFbTV3dHpJUVF5YUVtaDZra1Y4?=
 =?utf-8?B?R0hPbWlVQ0UwOWFnTDVlczE2VWtjT1o3NnltUmlIRlV2Sm1VTHErVDM2cXlt?=
 =?utf-8?B?djMrMUZid1hGVWR6aytkeTNRZTdwVnpUQ1E0UzR1UTNpcTY0eDhSRmt0VzNL?=
 =?utf-8?B?ZkZVRU1qNWtDR3gvaUhBYjVkVllKS1lDVkJGR0RPNm1vQUpDcGo2djhMMDVt?=
 =?utf-8?B?Uy8rM1J4R25kelRhbDI1ZjIvRkt5SWV1c09sYlY1OEtyVXJycnh2eDdyUVhU?=
 =?utf-8?B?dXlDbndvZWhRU25pa0JTWDBjMzJBZGN5dXVVdzRTQ1NLQTNzWlVTSEw5bEtn?=
 =?utf-8?B?bnBHd3N5dTdvNnlKQmtTeld0ZmltdXlKdDFRQ200THAvVzdOdEI0SlF3T2dK?=
 =?utf-8?B?MnhXQk5vM2Y2V0c5bTJHellQSEp0M0JmbkZibnd0T1dxNkU2VHM2bVlPWStz?=
 =?utf-8?B?cXlMcVlSbWRKaHFtanZBVXRPa1VyR0p4N1hmYVcrNU96VmtlZlZQd0hnM3Vq?=
 =?utf-8?B?TnFRdkhxVWIvRnd0MUQ1aytFMm5WQU84ZStLdVJHZzZpTnBvdTRjNDhVcE5Q?=
 =?utf-8?B?V20vMm90aTkxZ2RIZUR1T0p4VHMrdWlyRjFzTlV2MjBYVW5sbm1XZ0svaW5T?=
 =?utf-8?B?VHA2VjZ4dE50L1ZTaHQrSWEzaHVPMDVWZUxlaWNlMDJUbFdxRytnZmp0ZTc3?=
 =?utf-8?B?bExHVS9sT3JIV2hnUFU1dDZCQTZjSW80N0ZoU2ljNTdsdi9Tdy9FSXF2MUU1?=
 =?utf-8?B?SHNyRnJrcFltRFJHaXpOUG44UkpJOE5IQ3JpcHVxKzJ4WndnTVpEeitTTll5?=
 =?utf-8?B?YjI2ZWZXTGk4N3N0QzZ5RnJaaThSQzFZN2NCWFdpdksrUldXa2NEeFVWR1Fm?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qs3fCrWKucr2x58PHez53ZdRg+oEm5y5ngatR+zU4oR8wvelL8ak87yde+5ET4o8jF0A6CWfZ3kMeXoT54f4XVc4o1D9nNPufQWwRQyEJM2ejBcjcBPpoTiVFIdS2DX0vQHobrJr8yEoXpunQCacmxIoNX4D1iKdMlAER+x8Jh0pETfG7xTeh8xBL8phH+z14V4FEFOO7NQmOZZ1vlLEuEa3WlISPK0z3z+8doLMFXbOHqiEcI0f9yvoEfRloQ4VidFp81YtGQ09uHe0iSNkXHRw1djyRGV0nG2I6msdhtFEYQFgmSi5DcOWDYT5C4kOe+ifcVgybPxQYFWgNBs/qniSmSceZd/znY88FNP9nyQzRsqR6mc4lST88sQrgQFTUuPyILkeKrRfk2gi6EYbksnsw4cu6NSjqX3RxxaCythYpMaoabnhJRm5K6+/22uKE5REm6GB+QgcHhWzihFow61KFTkVB7zmoDCjb38ouWR+mM7MyrYqF+N0ysPo3qmFPLJ2K5N8SomIEzkf2LWvhTNwQyVPp1he2LGqXyuRMqyvigA91+54LZFRnTGgo5sbtTHHANNEgzKNadwf3j4+KnrAiMR/Sz6he3yjEpf55AI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee32f05-04ec-4efc-c8d0-08dd34e076f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:14:43.1092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GotkQyClSLy3hGzBXSaVFKU4Q7rPXiVhWpdAECRNC+ga82evGxp6BK9XvnBDv9jIPJ/vDTQ2MmEa97ppKypBI8gtIvpcSswKVKZOgeFzqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140160
X-Proofpoint-ORIG-GUID: SklYeCuuDZTVsMRPghtibOzSf-w7UbF6
X-Proofpoint-GUID: SklYeCuuDZTVsMRPghtibOzSf-w7UbF6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
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

On 1/14/2025 3:29 PM, Fabiano Rosas wrote:
> Hi Steve,
> 
> The CI shows some issues, please take a look:
> 
> https://gitlab.com/farosas/qemu/-/pipelines/1624984802

------------------
I will fix this bug in V7 tomorrow.  Same failure for each.

cross-armhf-user
cross-i686-system
cross-i686-tci
cross-i686-user
cross-mipsel-system
cross-mipsel-user

In file included from ../util/oslib-posix.c:36:
../util/oslib-posix.c: In function qemu_shm_alloc:
/builds/farosas/qemu/include/qapi/error.h:335:43: error: format %llu expects argument of type long long unsigned int, but argument 7 has type size_t {aka unsigned int} [-Werror=format=]
   335 |                               (os_error), (fmt), ## __VA_ARGS__)
---------------------------------------------

I will fix this bug in V7 tomorrow.

cross-win64-system

hw/core/machine.c:467:13: error: 'machine_set_aux_ram_share' defined but not used [-Werror=unused-function]
hw/core/machine.c:460:13: error: 'machine_get_aux_ram_share' defined but not used [-Werror=unused-function]

-------------------------------------------------

This bug could be mine, but I need to investigate further and reproduce it.
It occurs on s390x, but all migration tests pass for me on x86_64.

clang-system

s390x/migration/mode/transfer - ERROR:../tests/qtest/libqtest.c:1362:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return")) FAIL
23/109 qemu:qtest+qtest-s390x / qtest-s390x/migration-test           ERROR          199.38s   killed by signal 6 SIGABRT
 >>> G_TEST_DBUS_DAEMON=/builds/farosas/qemu/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QTEST_QEMU_IMG=./qemu-img UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/builds/farosas/qemu/build/pyvenv/bin/python3 MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon MALLOC_PERTURB_=123 QTEST_QEMU_BINARY=./qemu-system-s390x /builds/farosas/qemu/build/tests/qtest/migration-test --tap -k

stderr:
ERROR:../tests/qtest/libqtest.c:1362:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
../tests/qtest/libqtest.c:207: kill_qemu() detected QEMU death from signal 15 (Terminated)
(test program exited with status code -6)

Full log written to /builds/farosas/qemu/build/meson-logs/testlog.txt
make: *** [Makefile.mtest:26: do-meson-check] Error 1
Saving cache for failed job 02:46
Creating cache clang-system-non_protected...
ccache: found 15435 matching artifact files and directories
Uploading cache.zip to https://storage.googleapis.com/gitlab-com-runners-cache/project/43309410/clang-system-non_protected

--------------------------------------------------------------------

I do not recognize the RUST test failures.

- Steve



