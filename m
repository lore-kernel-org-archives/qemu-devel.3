Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5EB606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=p/CaH/sH;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=EzsedDm5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQL8b-0006lm-JW; Mon, 09 Nov 2026 03:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQL8Z-0006kv-QI; Mon, 09 Nov 2026 03:53:59 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQL8X-0001Hr-QZ; Mon, 09 Nov 2026 03:53:59 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96BAcn555340; Mon, 9 Nov 2026 00:53:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8PYBFHkJQ9dP4HSOxuTsHA7Dr6ofahTEg9lT1E5MU
 7k=; b=p/CaH/sHzObu++OCt+wpNKqKFsTP4GvYoJjRtWRLlqGtmHHCel4WfDdAX
 KYw1WLI18Q0JZPpi2d5eatj87HoO+hfWOgmQdpYLOC9WLqIqI0Z1xh6yWjm365Kn
 aoixckVDmPUP8bmkMckIWmNLtAEPoWSHHZ30d3Jl8Wq5nGckBM7qJf+oFmNo0Xdz
 ZJCONnTs3rXF/O4j4CO50ziN1VCpRDQ3oRQxcll+My5UhPj1DISLIL+j7cFlKRHR
 Fc/beHhjF7gij4vxlMeSASo4vr0I/RGTd+r4o5mq8EqLyzzwT15xqbhiNrTxukZ/
 NYfEqeAQH6mq6odPyQh+0Ojxzj/FQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023136.outbound.protection.outlook.com
 [40.107.201.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht2d9jesb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 00:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVh2QUwx42zq8heYqvQ8VMK8Sv56vJNfoeTav9EjPtSRhE+2gBuL8wHc1A2zBJgU+EYhHZthc30pVwZBniC9DtO0XZVdNuIftzc3PdAIP2Mj90fKUsLzm6SwLrgY0gnusT1pibvvFSXRnzcCVnnOTVD+qa3Usb84biD0AIjxubrpOgt87K0ZcmEym8a6/8mkg44V1UOqCNFJ0YnvNO2jAFP2NG4qPCNs64hg0hbIVvrQRbE2Xp49PiQxYJ6X/K2vYjruZR5EGH72uTcDdD6D8kEpliovAXjw4UgFeRNZaGaGzGEiA0ElLBoQAK1RFw67IpdIqGD2weWHv49OxG70wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PYBFHkJQ9dP4HSOxuTsHA7Dr6ofahTEg9lT1E5MU7k=;
 b=OAfBWbaEcQvJN44mbyozM7722HlSEZzHCsGVn/Ah7xjZipVXmDgw4A0J/vv8TrnZMEpbOEpCYhHZhXS8i3zjB9PhfOgZvTZykTG9YiaKFNsmFCDnKnTfGlN1ZvfRah2/dLz4sPJ7UIGhoOu28wvFFMLDS7MDPj27goLjwQfr62gHN+FIwRZ0jMRMo63lFleukiNC+SgKHkmqxTh6sPkc4/46s0Rt9ZIVpID2XIS2Zm2ZgCUj6RRyRc9Ll4NdklRSLd6KtK6RZRofpvtjqIi7cIerm385dXTa8ripwmJenrHWeZvmTkNXIvlbQ7fkNNs3JDYfaszciKvZhDKZhCTITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PYBFHkJQ9dP4HSOxuTsHA7Dr6ofahTEg9lT1E5MU7k=;
 b=EzsedDm5QcuonaupSUlJ4Gwt8h9C663rVgnyOpmnx7I6j5oFJV3T05fBrxV2pfy6pAdfyXPG3hhWtktG2ab3+TVPP4wW80GOzpokeHxoIJhnSojwsrdAAGAp4phhluNniD2tjPBOp/sHcB2/6v6Q8EkQdnXVC22eegKUkmySnPDVW9b4XCft6V0C32CCXMHWNpSYskQWUPnf+dTyF0fgFRZv5Sepw+DpT8udLCcpGrkhHl908tBru2Gw4eCEKn+SaIrvUiUJnBMPkQVrZScAEM3RRCoT23v2I1dG0HkkazzprZgHLD6RPB4xtfyfdD921wAHdDevDI2cd9JRJdxfpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA4PR02MB438772.namprd02.prod.outlook.com (2603:10b6:207:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 08:51:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:51:43 +0000
Message-ID: <73afe23b-4f22-4165-bd74-ae33b8f8a865@nutanix.com>
Date: Mon, 9 Nov 2026 08:51:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/gpio/pca9552: Convert pin and led properties to
 class properties
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-2-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA4PR02MB438772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d92a31a-c6b8-444a-92d4-08df3e3eadf6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: uoFwc1tUC7PrlaD87dOGdGVRjWsu4H9No1uJYI8L02e2pVG423fO6Qux6fbbPjBTIb4nzX1/MnLC51mWUpON0bAZYQ9jvQdKmh6K4NwD44aR6r41YJo0qamlBTfpUsDMLmBn1Pq2Bc6OdUpevCe3xuT9KhyIEiY1cxrat4G2EuzqD48B5PfE2c2HcdA6UAZvt8ZGM4aTPRYa3OsKl1u/H1iHiO4P7wQcik3bAYTsfqvJZvUepOEOk80cU16k6UQVJq9uh7e1ClboOyYB10jml+TF3Edt8hVMcHou+HZleAzXENpQhk5CrRffMpjVFLhkz1N/ceCcT6LSXPGsuTSifWx1uxrodxCcHXt+vCSDyRiKaKiSTb9dKk2DAWGFAUETS7fQdLSqLEPSnRRlUQFr5Bo0q4ONs2G9sT9a0ER3nbabeYajzo1OL81ug/ttl4WyAv3Q0hLwyjvMvAlrgbVHpOGkJjI4fTewHkqhmHMQ6RWZoU2TW15wHcjl5ugjKnc+jnp63KEyfVVOWAgbC/UgqbZtshxsb+Api6Omnt8vlT7JhUflkXq+/FEnqa+AhjDdym+2GKGHWNCMZ8wpgWR2eYaI1dsbgr5X140JhG4q8cccEboLne+OcQCc124uT3V9n3cvkOhzVB1DeYXOgckAfPGNFbxRxV4EvsRdgr8uBPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXIrZHJJSFc1L3RlM1R2MVBtUDhHQWljU3NPTWlESnBoNmV0c3kxeVdna2dJ?=
 =?utf-8?B?aVYrM3lSSHQvcEJ4QUl5VTUwayt1NDlhbGNDOG95dEVJSnYvOXh6d1k5d1ZB?=
 =?utf-8?B?WFg2bGRrSHU4MW9HTXJvZnZnK3V0TkFpb1RHUVA2KzEzYllOY1pJYmFpUU9v?=
 =?utf-8?B?TWhNNWR2eThUS1cvVnRaamRJL2tMVkVZOU95SDZnQW4xajFFV1htcWU3a25F?=
 =?utf-8?B?djdCdTAvTk4wdDZIM1BWc0JjUVcwNzMyclFra1llUnVwVXk5cCtsSm1RWkZ3?=
 =?utf-8?B?cWJXRlkwOUlhM1RmUmloMHdkT1RQRHUxOUZQbEF4UFg3anUvMmNUaGtTdzlR?=
 =?utf-8?B?Z3MxME83WTRyV2tObDA0WlhOVGZhQmxXV25wdXB3VDJWa3lYKzkzbzhZU2dW?=
 =?utf-8?B?YXdDbUZQeHJobytXdkl0TGZUT0VNT3oyR0VzSmdXL3FrczJ5UzZOZGg2aDh5?=
 =?utf-8?B?T3lFQUNEdmdmMFFaUzZiVE1nby96T2hYZnZvTEJ2SUR4bFJvR0NXOEc1b2VF?=
 =?utf-8?B?ZDYwMW8vU2Q3Rm5sVGV1dy9XV1lybmlHRDRxWU9lVFkwRThaNVJTTlNvd2VE?=
 =?utf-8?B?WWpabXViYjBIM0JjelduRmNXRzc1ZnpLNk90b0xpZ25ZZW95azJJMWJyaC9r?=
 =?utf-8?B?d0ZEN3JnUzJKVm1vSXB1VVNWTXh2RUw4cjhzQnVBQS83dFFRdDREK2pvN2NB?=
 =?utf-8?B?VnVWcHRPdklKK1k4aEQ1b1RCcTFXaTNUSkNwM1RqeEwzRVAranMxMTJXYzJp?=
 =?utf-8?B?WDc5SHFpS3VCbnFlUTVrM1hlZDMwRmlCcHdqZ2gwRkx4M0dDdGIzUUM1cWpj?=
 =?utf-8?B?ZGU4S2FDL3ByU2xKNjJSMHQxWTNESEJsMHAwM1Byc1AwbnI3SEhiNFNQVGRt?=
 =?utf-8?B?dHRTdXczSmFlaFJyVDg4R1A3V0ZGd3VLMHVWamxyN2k1N1ZmVEx1NWVIYWRR?=
 =?utf-8?B?VzBHOXAwNVZqLzBOd3lNbG11d3hudFUzdUhVRS9FR2QrM1VwbFFRQWhHY2xn?=
 =?utf-8?B?cEtRT1ZuOFE0N2NiY2FCYVVMemxDdzc1aFprOEhBQ0NRWGdUMEFlODlvb0E1?=
 =?utf-8?B?NnlKbUowU3ZEZGx6ajB3NVlEOE82OG9NNEdCVnB0MGhURVRPUW52VjNzOGE4?=
 =?utf-8?B?WUtmN0dTakxsTUlBM1VlM1NUbTUvZVErNFJQNTF2STRPYTVISXljSGorSXJR?=
 =?utf-8?B?UjBvTjIzakF4QjkrS01rUXBMbnBMcW1VaGdQSTJPTE84RU8wVHR2bVlvRnlq?=
 =?utf-8?B?cm9YL1NDaTNmOXZCTks5cGQrYnAvZFNsV1FST3dBTmlaSVd0YW50aDQ5U1Iw?=
 =?utf-8?B?aytlS3J6OG9QNG1jWWh3a2RHMGtkMlZKZmk0KzFDc0ZOUDF3SHZyQ2JPV09X?=
 =?utf-8?B?TVcxbTcveE4xY0VDYXI5QWJyd01OWWpMelZZVFFOVEVyeXNYb2xiYXBvblpY?=
 =?utf-8?B?QXd3SVRVTXJlME5GWUxsSG9xNDBvQXA3RVpVQ05YaXpERmUvV2NmcjZ5RHl3?=
 =?utf-8?B?cGJRWXl0RHhSdVZaR3RlMCtJOFJQaWhEaDdmUFlhdjRyaENzbGRiNks0ZzU5?=
 =?utf-8?B?cWppYzY4K3VKL0s3RUF0ZVNONXpMYlFXT004NWtleDJ4SStrb09RY09RWFBW?=
 =?utf-8?B?Ty84bUkzRDJlNDRqSjNkQjR0Y2tTRWdKa01zTVY5SkNBd2l5SkhrNXBST3d3?=
 =?utf-8?B?R1RkVGhHSDV6ZGpMWmdyWGtSUHJERzRDbnU1UDFiWnpwMUFlVzBvVzBGTGQ4?=
 =?utf-8?B?RnE0SnVXY3BjTWpHalJWVDRVSlBRT2t0TEdBV0k5WGEyZnN4d20rNDdSbGRG?=
 =?utf-8?B?Qm5TeTdtT014SUtMWnZ3VUQvdzA0WFRjQ1VXaG5HV1ZZUWNRMXFOby9lMDJF?=
 =?utf-8?B?eXdaU1hteG14VDB5RUpDcnhiaE9TdkpNWGYzKzRVV25lVzQyUkxOVXFpZlpl?=
 =?utf-8?B?alp3d1hwb0dwVElZcExBMG9GOGVMNlNHZHN0Y3NRT1VVS1Vjb1NFS2tsV256?=
 =?utf-8?B?eXVISDIzTFhndEtBL3N2bXpHWHQ4YUUxamtSbTRuUVRKNTduY1lleU55L3lC?=
 =?utf-8?B?eTFMZ3dTVGh5bDNOdlczMW9iNmVvcUkzRXlWNHFOUm1XQ0VBRzZSdmlvUktL?=
 =?utf-8?B?c01WNXNwalBpdE8xTi9uOGIyYTA0YlhEMVZHY3VCcEZoSStxYVFERytCM1pN?=
 =?utf-8?B?M3M0c2xPWkRzYUQrZGQ1WmtXMStOa1BhQkRuV2p0U2FvN1Zrd2luYW5uVlVm?=
 =?utf-8?B?Y092bGovcTZNSVY0MUpsOE45cm01ZVhFSExmaDU1ei9wNVhwZ0RtRGJqMTho?=
 =?utf-8?B?ZkJaQkdPTkpaWXhiWnpCZmxIMnVib1JwTGJtRXNOVzFVTitmSGF0b0c5NVVs?=
 =?utf-8?Q?pNK8nlrITiPblFvQ=3D?=
X-Exchange-RoutingPolicyChecked: vGmnp6mq8ncBGySpTly2T9QRuPv+b7MhflEUXtNEyA1qda+4j+WFdKZZxpxNNoNyBMWLv6fVMEce2R1iNkcJa1XZSzOCMzRfQ6gbMLhyJiNxhYaUafWBa8tJh1BzSCem4HYkNs33Fue6V/criB6GSuFFageof9nD2IIM3aNJ0wAKYG5GZWJMbbjshC4P3dOGmoq8o2JwefILwEiymuUmnRghgyWn9iPo+PPU1BrFj4FcW1ts6OAKE3ueKn66YmhyPk01ePNdAsdMTrShW2Dn9uDjTNJVyUuRff01B0mpDwmy0qgLno6nv/dNHZb+ud/dcZ5DCdfuq+lSeUU6KTkUlA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d92a31a-c6b8-444a-92d4-08df3e3eadf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:51:43.9029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7ndIPO/IgJmzJpa5tjBPNOEC8ADzt8Dyci1xNwL+Xj+icxBwGvbfJICpFm43vFHcwMTagg8H9Jw+JIjnKa01JE/BPABbSXGXxQZtjRGf+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR02MB438772
X-Authority-Analysis: v=2.4 cv=U5IHnuru c=1 sm=1 tr=0 ts=6af18a1f cx=c_pps
 a=Ec8ZIgkrxK8GE6F7YKoxaA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=5hhQwk3i11Gfv3amEC8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX/cp7dh5qEWE3
 5WnmiRDoHlGzrsMTAZUqkbPntlzgR69gbbMg7pTUbjCZkGYYpNU5NollV1fYB2EewwKMw4d+qFB
 TxisiQMre1eTQhRcWwz3QRhooKPWiCk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX2fVMXldwXtgb
 x/58MGhsKoKVBJL6jsXVepBuzH7gw0xQjoMqz1eozwrx1o41PUD/Eh8yDmYbtXllDrYOeZuqWff
 4D36WdM2NMeDuyEPOg5fVIJBb34F4OT+CpYPI3Nt5k2tELBVbEZ0GgOoxAJkm6/9Y3o+IOAZeVh
 V1BYsdli/jh/mr1CApmUvEsFwFy0W9hgqWq3ZjzyrndtzwaLVf8w+yTPVZc3hHX0xIQXGxWNY1y
 7b8l5Uv3oONCxh3dL25qhozHdSi4zLOO7vHtSb0msuadLfnT3gvDVnlNepVVAJR8e/DkBPBiQS3
 /afcrur3YkP7VRiBjfv/XPlBDurKQqs6xBbE30ISy7ilKyGqagKSEGJ022hveoraKR5rVk4soIc
 1JEObt9ZNtihfn6KSRWvBMjLlV1hcdsKR8C6xA62wPSlnNvdzbKy+U4578plGfHsq7nE2IqvKz6
 ShNLoeTXZi2qwks3ujA==
X-Proofpoint-ORIG-GUID: s90ysKpQ5intnUVapoi5WuCMhcq-1KrE
X-Proofpoint-GUID: s90ysKpQ5intnUVapoi5WuCMhcq-1KrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 11:04, Markus Armbruster wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/gpio/pca9552.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 90ccf5170e..65a718ef31 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -557,10 +557,8 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>       s->len = 0;
>   }
>   
> -static void pca955x_initfn(Object *obj)
> +static void pca955x_pin_init(PCA955xClass *k)
>   {
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -
>       assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
>       for (int ix = 0; ix < k->pin_count; ix++) {
>           char *name;
> @@ -568,13 +566,17 @@ static void pca955x_initfn(Object *obj)
>           if (k->has_led_support) {
>               /* LED variant: expose the LED selector state as led%d. */
>               name = g_strdup_printf("led%d", ix);
> -            object_property_add(obj, name, "str", &str_type_info,
> -                                pca955x_get_led, pca955x_set_led, NULL, NULL);
> +            object_class_property_add(OBJECT_CLASS(k), name,
> +                                      "str", &str_type_info,
> +                                      pca955x_get_led, pca955x_set_led,
> +                                      NULL, NULL);
>           } else {
>               /* GPIO variant: expose the pin logic level as pin%d. */
>               name = g_strdup_printf("pin%d", ix);
> -            object_property_add(obj, name, "str", &str_type_info,
> -                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
> +            object_class_property_add(OBJECT_CLASS(k), name,
> +                                      "str", &str_type_info,
> +                                      pca955x_get_pin, pca955x_set_pin,
> +                                      NULL, NULL);
>           }
>           g_free(name);
>       }
> @@ -640,6 +642,7 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
>       pc->max_reg = PCA9552_LS3;
>       pc->pin_count = 16;
>       pc->has_led_support = true;
> +    pca955x_pin_init(pc);
>   }
>   
>   static void pca95x5_class_init(ObjectClass *oc, const void *data)
> @@ -653,13 +656,13 @@ static void pca95x5_class_init(ObjectClass *oc, const void *data)
>       pc->max_reg = PCA9535_CONFIG1;
>       pc->pin_count = 16;
>       pc->has_led_support = false;
> +    pca955x_pin_init(pc);
>   }
>   
>   static const TypeInfo pca955x_types[] = {
>       {
>           .name          = TYPE_PCA955X,
>           .parent        = TYPE_I2C_SLAVE,
> -        .instance_init = pca955x_initfn,
>           .instance_size = sizeof(PCA955xState),
>           .class_init    = pca955x_class_init,
>           .class_size    = sizeof(PCA955xClass),

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


