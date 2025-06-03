Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A0CC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 19:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMXCg-0002Qm-3C; Tue, 03 Jun 2025 15:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXCd-0002QZ-V9
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:21:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXCX-0002HX-8s
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:21:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553HY16T032261;
 Tue, 3 Jun 2025 19:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=AZv6zaMU2Qx3ao00RE+095qkKxDwPt6pelu5Q07n4d8=; b=
 bwBfd4gQuwWqJIlcXQRB3zli44w51mG1KmutWOiQZKKgXY4xAYgE1BqlnP3cmsRH
 hFRVrcs/rVr7UuoykhbrOofhu/AIRAy4wX1unU/AM8ySVVmnB6xdYljhBHVcdWbN
 KMQy6UNdW8HXVuxRjEFOVlZx7XvQlAbtbrY3CYADjqw2hsECfxw64v3sPFQr5ews
 5yflK+km6BpIRid506Y5FttxY1nd5ds1Cy/3sZwK+CzTQrXAW7GBXZonhrB5DfaB
 kzrEvkAJx/ui/FX0s1jiz+BcjH8iGcW1GR8iUOKaIGbzpwn0XOmik+ceR3j+4CmK
 B66/L1baIDXX6REG7P2mew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gajxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:21:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553HnuAj016369; Tue, 3 Jun 2025 19:21:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr79ua8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qxbv0Zw1Xt2kMO0IK8GfVrIw5Rup46NxmtQapvL7ZmE2tFIR3sgPNKMysBvUfskdkXCCB3wNNMY/cy6RdN3Kej1GhAg7IqyYZ8ar3YCUZSeDxM4FnoIAInDEpOvWRGN5xB2jKUI86cNiJK9VzYLm9buC4mE73on/rPOuHmu+Aoe08XZmfpfvlTEDA4LaIXAo3AeGRVHrb12Jj5mnBXeAofthoR8cQCv5BuXGIa078X9btg7kH3nin2Gu6uJoV5ORtMVBRUguPl9BxqoBfGBgqiA8plRboBPsQ2yRnuH/kJWsQrL7QrgJ7zEbd/AH/FRZdI9xPLTAmVQZRquxfOssrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZv6zaMU2Qx3ao00RE+095qkKxDwPt6pelu5Q07n4d8=;
 b=VcCGW/6TgsO9EppDHYbIP5qIyNEsLOBK/kYU5409ot1tqTXjg1bAn2CepF1TKzArn6EO1MN2LMys7TKkKetFylCK3ZvuBFayMyjYXA5chnE/tv5qAqiRRtlZNvE5TJW9LSCumzZ7LCI8Q0p6bMRPyuUpDZFpztGQ0/hKaaI4p8g8N/mv5xJploYNqRR6FLlpGMQ2lz9cisG8OwlXEdKVDc9pf0OyeT5A2Wjc2QVQOQ55xwJ6rTXiE0aLHFuo41uep6e3rnGwyV0oPfC1MR48ke4yo0ExzgexMSfUgAP972G45i4Ye+L9stFJaup+4SwVzcnhie0DheGKryvWO3mpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZv6zaMU2Qx3ao00RE+095qkKxDwPt6pelu5Q07n4d8=;
 b=Y3++tn7L6gCDurtWl2OkbiMMWEPzf/s90bTWjIL469mIcf75y3fbtv2BH/T8TsA8w+SAnYzDha/JTajK6+oULcKeXhDWyS3GF52yn+pAHcbYq/WwLg9/JZV2PHIU+lgoDFFdVRRrS3o4LTivWTVPgQ43bOgEuz40/GI3MPxse00=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by SJ2PR10MB7656.namprd10.prod.outlook.com (2603:10b6:a03:53e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 19:21:20 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 19:21:20 +0000
Message-ID: <0712f9be-cd98-4e57-963b-6e6f2ab30b44@oracle.com>
Date: Tue, 3 Jun 2025 15:21:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] acpi: Send the GPE event of sleep for x86
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163953.2183-1-annie.li@oracle.com>
 <20250603143431.1ba917df@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20250603143431.1ba917df@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|SJ2PR10MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: d58ba775-59fa-4636-f654-08dda2d3d1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXk0bEx2dzBhazdmSFg1alZ2dFZMNnp4YnpPTFo2WWlzMSt3TjhWandpc2xs?=
 =?utf-8?B?UE5nS0lRL1hldVVHWHZXbEdUMHhRdTJkUUpaREhLbkQzOWI3MlNLelYwYzN5?=
 =?utf-8?B?U3JPWXdlcDB5alZQVEx0SmZyU0NyVnZ5L0thWGZUanpvcU9ESWVxL0ZCUFdG?=
 =?utf-8?B?dkJja3YzaHFRakRxcUptYm1OV2diaVRsZTU5Y0hHV0lvckZwOGxtMW9JNGZF?=
 =?utf-8?B?S1ZNbHYxQzdmRkxSdUZjSlFyNi96ejhXc04vRlQxK2JRbVVtUW13bElGUlF2?=
 =?utf-8?B?RlI5LzRrUy9PcTk0Q3YzeVlVNHc5bUkwK3RrVk5WdS9UbHRLbmNUMnp3Y1V5?=
 =?utf-8?B?ektxakVQUlNnb2lLSjE1Ym54V21zUU9DVHpPbk00L2c4L1Z2SkJEdS9ZZDdL?=
 =?utf-8?B?QXNPYkx1Y2VXWTkrRGdOM3hoa1hOWDVnWkIxRXlrekc5RDcxMTdWT0RBVS9Z?=
 =?utf-8?B?T01qcFpBaDVrOWt4L3MwNDI5MFhEVzN4UGFINTExTC8vbVV0MDEwMjY3Njly?=
 =?utf-8?B?d3d1UlFHTWxJQXdoMG4zYkJpWVIxdFdYR2swSGsySys5YzZGMmNydk5pckxm?=
 =?utf-8?B?c3drRDlBL2tTMW41T1FhRjNxRm1LRUZnM1YxazI4dWxoSnhhQktuUEpIeEwz?=
 =?utf-8?B?bW5pQnJkQkpTSm9uOHJnVXZxb1JpQVJsMzZkdGYxTlpJWFdoa28vU0l3OG8x?=
 =?utf-8?B?bVZqZzhzTGY4akk1SGhFOGJGSVBYdEV0WU1iUm14enRKWGRBUjkwQWdCeUFa?=
 =?utf-8?B?OTA3TjV4R2d5YWxNbE5HTGx2RmZ4Z2J2QUVOSUpGc1RGOWV0c2Y5RU95VWFQ?=
 =?utf-8?B?ZEJSZEJWMWJTNWZSRjFqd3h2Z1M4V0FxaVViRzNDcjRRemVPUDdwTVIzL2pD?=
 =?utf-8?B?VzVTU2NXZ0ZLblhZZSt5WFI3eE9SZGhTR3Y1SUVFY1MwdjhSU3hjK1ZNTnR6?=
 =?utf-8?B?TzU4aUNNa0Z4UmRCalI5NUpKKzQ3SWQzNytQWE9OT1RTbm9GYUJsNVkyMzla?=
 =?utf-8?B?cTlHcm5EMWpLYUFBWVFFNHRNVkRPM1greUNab2lOT0w5YXo5TzBJQmNQRC9r?=
 =?utf-8?B?c0F6d1AzYmRqTElHTUx6ZEVVMFBieGdSMFludFcwcHZldEoyYWJ1bk5KR2w0?=
 =?utf-8?B?c25WTW9aTm85MnRORGpJNjhsWCtLL09oUytBQ2pGWDJkUTdSY2t1QzdIWnpa?=
 =?utf-8?B?UW9scEUwSlhaT1pHczgrcnZzWFdBdUVNL2VzY3NNMXJkc2QzR0Q2b01PYmg2?=
 =?utf-8?B?bGNBWGw1QVpLczZ1bldCRjMwM0l4SmZWR0l4UUlRMFQ3MFZhZjJGZ2owK1JX?=
 =?utf-8?B?QlU5ZUJ4MG1TOUc1RERtU0R0SmFTQ0ZIVlQ1UHNFUWpjTUsvOHJReEt4SG9o?=
 =?utf-8?B?SVRkdmZTNU5xU1pzT2FoWFVYNnhJcXNLblV2QWVzR1hvU1djSXJhc0UvQkM5?=
 =?utf-8?B?TExFTzZwbjRrc2JYejErV0dRZ2VvNzhHcEd6QWRKK2d0S0IvSE9vWXQzSEpu?=
 =?utf-8?B?VW9RazZ2YTNWVDBKKytSamQ1NEZPRGxwM1A1VzZLNWF4SzAyK0xPdnJzSEFh?=
 =?utf-8?B?d2tWTFdWQUFzcjJvSTJ6YlU0NVU3SU5FMC9hRFpNZW5adGdURVIzRVhFQ1Zk?=
 =?utf-8?B?cHVMMTVWUVNyZ24yK05rbVhNTkdOQytnQ0JUdUpKdk1sK3hMNGRGRGViUGlB?=
 =?utf-8?B?NVNjWEhmaUs2ZDFJZk5uTThWSmNPZHpOZU43bm5RQjVlcWJxSXQ2QTFWTEVW?=
 =?utf-8?B?NFk3V0FLSGk3cnBjMjhEVUVOS1g5NFFaR1FZMCthUVlYbnZWdWtTNDdidjNi?=
 =?utf-8?B?MVZ1K1lEQU9jVWVRR1dITWYxWUhtMU5xRTAzcjcrN0llYmo3SVhSaGtNTnlx?=
 =?utf-8?B?V2hnOUNZQ0pVaHRwZC91Q3lGVUhVVFJweXlEa2NxeXFSNkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhLOEpqWjB0VytMNjl5RndtZkxIRWNJTWNJcG5YRHR6MTV5eDVzZUFLdmFV?=
 =?utf-8?B?OS93d2hVQzJJQ2FwTVUvMlp4ODg4YzVHUUFWbjk5SlM2Qld5T0h2bm9vN3dK?=
 =?utf-8?B?TGljemFHMXlsMnpiV212c2lVVE10S0d6elgxZ1Z1ZjhZVFhId0FKR0Urenda?=
 =?utf-8?B?YmpFdFdJU2VBbEd5bVpaNkFDZ3o3NkFSaDlhVmxYeSsxVTBmekFmMzNIQnl4?=
 =?utf-8?B?UGR6OU5KWVdvWjZkUXJ6N0kwbC9mZWowVGhNU1ozeUM2ZnVBNFRtWTJoM0Ns?=
 =?utf-8?B?L1hhQXRsVU9lYi9kU2pEZExCZUhKLzFDM3p6NThjQXBwdWwvamE3V1hjWUg5?=
 =?utf-8?B?Y05VbUt3Q2lHWDlCM1l1elBlaUlNZlYvdU4yQm9VR0JzVXJ3bUMrN0RYamNh?=
 =?utf-8?B?Mi80YXB4U2VnU2JNdVlYL3FjNFV6UFQxMGRmQjZYM2RrbEw3bUlIVXp3cFNQ?=
 =?utf-8?B?QVRwcStLaWFldVN1V2ZJSy9jRDFMVmE2QUVxZmhzb3h0TGtHMjZiTFpoT2x3?=
 =?utf-8?B?Mm1tMVJlWmJOTzNVM1VRUXRxUWp5Y0hwOXI3UUcyOGNqWm1laE9yTVpRYWd6?=
 =?utf-8?B?OWxnQUw2QWY0VWNxYUtpeTRnM1hVS0wyU3NjVndPeDdxS3pCcWg1S3JDU2V1?=
 =?utf-8?B?a2xZeVorWEJmOHNXTlM5ZUJSbjdHSnphVlAvRTgvcUY1ZlFsNVY2SDlQc0xv?=
 =?utf-8?B?UU4xTHZpWnJIY2Z1VElxU3AxTzI5akNaNm04cW9DU1dxc1NVQWVLWHJGTkVF?=
 =?utf-8?B?emhDQkd0Y3o5R1VjcnFHN210VUlFRHFNVTZqWmhucGZjRy9UR2ZxcWpFbHVM?=
 =?utf-8?B?c25IbS9UWndrRlNHZmRVcThzdnBvdDV1V2F5NGd1QmNudU83L3lyc1ltRUtE?=
 =?utf-8?B?ZVNybWZPN2RTSUFFa2R2VTBIc2Ryd1BIYzIweDg2bm5xTDJoZHdCOWsxbHRQ?=
 =?utf-8?B?QTJRYjU3bit4N0N3NW5rR1NIWWQrbDRueTRDTk1MVExlak1EZnU1RDJGaFRG?=
 =?utf-8?B?eHVOOHNjc1Q2a1pWMy9VVGpreElRK3RYb2FRaXFFblc1dHRsOE5COGlTRGI2?=
 =?utf-8?B?a0FBTG0zOEtpcmplYTJTdGZ1RUFXeFdOemdLSHdab0U1TUtNSExXWWdxZDBr?=
 =?utf-8?B?RmlzK3BHaitJdnRkVkFRTkpZUDM0RkdySVB2SVhRdkZ3L01kMDlraTl4RFJq?=
 =?utf-8?B?d2w3bWZPMWYrck5PNXo4ZHJHSHFwQ0NPTXR4K25aZVE2MHdhZEpCSzg3WG1P?=
 =?utf-8?B?emZUR01jbVVTbnIwOVREZ1RKRlZBTUJwSURSY28zVTAyVm5IOUdhNHoxRWtp?=
 =?utf-8?B?ZUFoaUVJMmxTZEVSRXI2c29LUmR2Z2pBbkxrays4T2hlNndBQll3enpSTmNU?=
 =?utf-8?B?ZDBIMS8xZUdRYkVHZHF6VnZnTStlU3JmaExwYUE4dzMrc3N6aTJLaFllWkh2?=
 =?utf-8?B?MDNPRDFqMjdRL0ROTWE0Wm1zTGtLblJSbW5SN3k3cTRFa3JpS2krUXQ3UE1k?=
 =?utf-8?B?N2NvTUpFemRSMUNUU01VY3FFM2VlSEpYNDVERFVoM3U2a0ZndXAwcndjejJ6?=
 =?utf-8?B?WHJDbjZpalFUVjVIdDY5M1dxeXRHcWJ0M2hGTVRkOWJaNEROb2FwYklxeTBJ?=
 =?utf-8?B?TWkvbmRZTFVONVNnb1Y5ZFBEb0ZicE4vY0ptWGJYbTAxY2VjNEhwZG5JSndJ?=
 =?utf-8?B?aExkQ1Qyak53YXcxcGwvdEpBQmtjbkx2cTd4SDdDSDNNVnJ4aGtPN29PWWtz?=
 =?utf-8?B?WWFQNHd1QUY1M2RPR2QzUHJwOWJ1QWcyN1djaFB6N0dRK3ZVek5NQjBZanRt?=
 =?utf-8?B?YXJCUFg1c2UrY0VkNkUxZTdxN0FtYzVKVllSMjVhOFloT3BXYktNcG9tcjlq?=
 =?utf-8?B?NlV2Y2lPYUM4REFoZkJTU1VJWTBOM01LVVE1NnEyeU0wZEJJRVhocW53bjdq?=
 =?utf-8?B?c21qOUpwdjZOeFN2RDFyY0ZYdTNPUEM1Y3ZXUHZJbkdDNFJqNEhWaU1HNGpF?=
 =?utf-8?B?MFc3OXRtaUFDZWlhNGRldFA4ekwvV3FIdXc1cHJzL0hseDRPR0luVUVnaHJ4?=
 =?utf-8?B?MFNMUEcxRXZtU1E4Y0MxMlJNUkhqeDBMZzY0MXZodklDam1ZclpHV2hmUzhn?=
 =?utf-8?Q?tAkPsclxyfxkSKClWbxBri3WB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 58UmNNBDS8pRdnMB/vhJkRMn+hPct74HhZi2kddYQ6bBg76SnDOJdLPse9d3eLBEw07j3qG9zNrTcOe7+6uZDOS4xFWvqO57EVt1g9JtOBfgdLsd6QOVfHgoojOBL6ZljoNHpuG067nWRNxExbVazoMR3kUBNurqyvzwBQ87S0c6qZ/gVe/GYaVN5XyjKM6RwwIv6YamweAMYK++HOLfhQUKz34p4TAR78tb3ta47Ssepw2U/o3I1kmdfJhc252I+iZGPmkTdvUkrWqvExWC95Ho5eXCEBZ/bVknbiucskYupZwgL1FyCHd1JRy4k5Htw5NtKr0Uj1KgBzQIzoOqlbqEwSG3plyK/LtJCvQ/+Jj6+Oy6vPbYSZ4tADYG3jMiLSgnk4nq6pj/4P1gxlpwkhhd8CNlLThffb6o1ne4faULkR6Sn0iwItUpY9c8LlN5sTA65ztYJlVclrcLZvcsL1mj5nKiQyoDcVmFehL2WaCkDXWtYE9TJ76+1nPBlmSisSSg2n7mDIf7Y2aiAXy5wPJTjgeqnzY3ZqMxHFrp6pkpl77q89iVmFfjZE1D0bWJLLKXYMz38d2ejQq2yH6+Pu6G0H7DY+hybYRFTWhYgoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58ba775-59fa-4636-f654-08dda2d3d1c6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:21:20.0897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAA+OkcqwMZQVVKGKIoBxOKls3FUJmtW9HtvJBNpIb99I8rdIagH5VV4FTCCRLPQ6g3917VfPVYks/Hu61qhvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE2OCBTYWx0ZWRfX2lINWXU0HNar
 EJM3mf8/EAgybHO5GXVWMbWGknoJe8tL8n6YPhLdmO9WM6wweTKJAU/LAuXcxALHqvrs49a8wQS
 v5ZC3XJvd7osIWueonXlS5pexp0j/60+SIUjcNOnDLVJLo6jLQLiyyygkihbVcNB6+ysv6UKlrB
 d/49mjQEqcbr1tutlUeZS23xKc0yEZJF6Zprvx0c7WCrRYjh1Z3+c5RAbQyNdY38MGti6upNAF1
 z6X/bBUuwvHuspBURgXOfnvmKkCirawlEVnfpXkx47EFqWpNEBaajfiv/coyTl5iyOvhCJ/UYfC
 I0TRUPK76Om8zcnltdeklMtASX4Bpc+pctHkkIRIDM0JTKB7h8wEzDgdfmi/GMjzdXWr6ZpoXCB
 IOoo4PB3RLRLOcsuXQW2+cOvmp3UXgHIo8t06iODTtTh0X+EQFGrHhF/+GGPggWATdWUixJq
X-Proofpoint-GUID: cgDciwI145LtZ8jVWT_Ua5MtYs9VsBAI
X-Proofpoint-ORIG-GUID: cgDciwI145LtZ8jVWT_Ua5MtYs9VsBAI
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=683f4b34 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=DeNaylJhju8rhfKi:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=Npnpv9fuEh6lfMm5yEgA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Igor,

On 6/3/2025 8:34 AM, Igor Mammedov wrote:
> On Wed, 28 May 2025 12:39:52 -0400
> Annie Li <annie.li@oracle.com> wrote:
>
>> The GPE event is triggered to notify x86 guest to sleep
>> itself. The function acpi_send_sleep_event will also
>> trigger GED events on HW-reduced systems where ACPI GED
>> sleep event is supported.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/acpi/core.c                       | 12 ++++++++++++
>>   include/hw/acpi/acpi.h               |  1 +
>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index 58f8964e13..dcabe881bf 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -359,6 +359,18 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>       return -1;
>>   }
>>   
>> +void acpi_send_sleep_event(void)
>> +{
>> +    bool ambiguous;
>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, &ambiguous);
>> +
>> +    assert(!ambiguous);
>> +    if (obj) {
> Can it ever be NULL?
> If not drop condition.

assert happens earlier if it is NULL.

will drop it.

Thanks

Annie

>
>> +        /* Send sleep event */
>> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
>> +    }
>> +}
>> +
>>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>>   {
>>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>> index d1a4fa2af8..64d3ff78ed 100644
>> --- a/include/hw/acpi/acpi.h
>> +++ b/include/hw/acpi/acpi.h
>> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
>>   
>>   void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>>                            AcpiEventStatusBits status);
>> +void acpi_send_sleep_event(void);
>>   
>>   void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>>   
>> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
>> index 68d9d15f50..1cb050cd3a 100644
>> --- a/include/hw/acpi/acpi_dev_interface.h
>> +++ b/include/hw/acpi/acpi_dev_interface.h
>> @@ -13,6 +13,7 @@ typedef enum {
>>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>>       ACPI_VMGENID_CHANGE_STATUS = 32,
>>       ACPI_POWER_DOWN_STATUS = 64,
>> +    ACPI_SLEEP_STATUS = 128,
>>   } AcpiEventStatusBits;
>>   
>>   #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"

