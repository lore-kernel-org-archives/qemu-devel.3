Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82996606A605
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=pX7yPxB1;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=usQLU2FR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURiw-00033m-65; Fri, 20 Nov 2026 11:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xURir-00033F-MY
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:44:26 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xURip-0005O0-Ac
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:44:25 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEf4sj2081881; Fri, 20 Nov 2026 08:43:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=w6OiFCR6N+X0OkOqDI7Nu7C/nq70fJOOo/yv9SlXz
 Vs=; b=pX7yPxB1/EuXibUudZJD0UuldvvsMnsEdvRukLyWKbbPEjVuTzUjYjM3V
 ZJjk50de7ifG0RaHvIjFfb3lyfG48X5XnVcioqTvGs7A+4cx5O46/yniwGmrVEQ1
 2miseZgrZlRnIy0tcZTzLKm4bXZ7Lq2bvvbVOpSv+6DvZMMiwT+LDs5dlU48/913
 KDZEiHjSqb8cF+7RinNvHQLR9MLOy18V0SHs+0wBYWEVpj5M6rS4KDjZK3whXe1S
 wLPtK67wIHEczlsI/SwABp0esZMg1TFBEaFMHX1acHj0kEzRDYYSSaI8jI4KytnL
 IvcA/xztbFwOgY5cB02LQhHbZQ5cg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020105.outbound.protection.outlook.com
 [40.93.198.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4j2pua8ed2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 08:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbiSUmZoKuIRWu88fVAAAT86ArpifYKg2Whip/18WHnCg3Ri27GUGubd2NzJ+rxaa+PGS/YWNfEGtdWIVx9/cI6Q0gG5fOc9EXhlrorZHAVRbkp/ymzamGY7ygArhjuJs6IoxskxTmCukwR3OiA6HswVs2oZil35oa1B2JkNMIhlm0J2EVRE1muivvSK01KLkZ5Ielsh+01qgekXVBBrPYwJarGR7zIPcbTykvH/YXQz+L2BNTOxYaV9EB0EEj2Rrmu5HfUD5PqxpNUHowYxzYxIvf3kX+KIst1qeaZH3iMgbYaKwKKoQiWK9hwGGup3h1Q8o5xpkt7/+pp76DWz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6OiFCR6N+X0OkOqDI7Nu7C/nq70fJOOo/yv9SlXzVs=;
 b=zPIry6LLHJ3hsuI46TkltuHkEThE1tfVy1/kdTta043nWiLVwzrn0q1NBLKK2isSkcUALza3mDv8MF7xBUKm6XbQMblEiH4+Eo7ArnO6/zy1+UpQYMz5PHEtfKMLiB7K5K7uMHWMzSvGfvwp5ipwpKvEVJkppqnP6ULbMLZaIwEw9peeTAfO+DHiBlL9/gOQS3axHqXMavbvsuNEHtvkNsu+KAJvfXpUWaJKXD54NXJ07PxujbCnF4jCPAKa+MmrK65FwudQyagwY7JsZ9PaKvX/OBk5Z4h9Jqz0oiv7SJKeD348FMBe/ZCuuUGkmX4SyihJ4k8cY31E5rS+dhxrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6OiFCR6N+X0OkOqDI7Nu7C/nq70fJOOo/yv9SlXzVs=;
 b=usQLU2FRZYO7MzUbFHF/1VOhLrnqTd4gW2XXrT85Hda8s3pW/tayFQuJuvGxTn4tY+QpNTT0jGcX8g+yItak2HgkGvfcaff7AxHXqRjPGR9RnQqPdgiMWXygHaxBR0txGD4VK07uQh/3RbVCAbHAZ/Ri9pWald69yizJld4x87M3QG4pM9Ck4PnElTgmpCPHRt0zqRhLEyhlLz77S5/CZ5Rn90m+xSp9vzeL86aj/HYmIZNekteP7sU5kgex7TVSKEEE492BlX55QQYipruI4ZT4+ul2+txLgYrUIPQ4Qe0Uln8OFWnTLgHl5hSZDLYnNqbtr8iHpbjBSOLQtlF6cw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LY0PR02MB438868.namprd02.prod.outlook.com (2603:10b6:404:205::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:43:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 16:43:53 +0000
Message-ID: <8b0e292b-c27a-46c8-907d-3316ce16a667@nutanix.com>
Date: Fri, 20 Nov 2026 16:43:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
 <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
 <062a8d3b-44a0-4938-8fcb-9f755d92c21a@gmx.de>
 <b9ee3eb0-9a65-42c1-bf6f-078b0f34a5d1@nutanix.com>
 <71fa0d0f-6b0e-49eb-8044-9c4eb30b9f38@oss.qualcomm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <71fa0d0f-6b0e-49eb-8044-9c4eb30b9f38@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LY0PR02MB438868:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f4363f-3cc5-46c7-4317-08df47257640
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261009223027099003|261102123227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: Z7f4fXzoQ8FTN2iClY9eYIu2gFhqfq+E2oosvtxzGrOf7xIw96Dr0xeKk1w9rig9axtImuZjeVvO6V3k0EWnEs65YAQkKOOvriZZxK6Z0+Q827P9Ad5hY8cpkNuVVhndQp0M62mIAefMa5lgFSD8OK66TBt7bGBG6n6yHWUJE+6R7FP2hTflH/MBtxuOp0o3vdrv4FP/jV/SCJ/hj7fHK9p1bSlmSlmYakm8zp47rhzZZPi0nqhsQyaTfE1fTsfslY6gvtAXuYeLAVjUs9wNGxUycJoB8p/lQ25OkzY/VPgoqhb4B0Jxz4ryYzy+bVKFSr5cwCKAyxBr467QWbXvIcmaMxNHY/lOiVHUZMTSE82pluDBXxZ/57uhwBupJ5DKuKl1y+M665ClN/9up164h15aDNZgKLAxUGOAEfRUsE60rICF6umjak+5x692FrBwq8SCbcDTdvPvzZbtRtVFWyGPIOOTgaxXlKrjS+8T1rBvG0ebR0fa6BzmfBXNfl2ySmLwPmJgkjxPrgKe+zHE4YqQ4KP7AluTPSUPfJljbSEFt+SjRlauCvMmoIOOGSdTBKLS8DOey7dftWVTxMSpW4xrYXInPiqyVXUyU48PQYIZXwwrUJ9aQtDOvI9BycTO1OiGBenZyAuRBkLht6XdUszTC+/8x0d7UGXlWrr/Hj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZGQ1RQN3B5d1VMVS80ZjJHeU5WNzIyY0tHQlJHc0lJUk8xOXNQejhmaWlR?=
 =?utf-8?B?WVRxUEkwSzhDRU54QldPY0ZVbmw4VzRlVW1nNjZJaXJkTVJZOHRob2JkT2Zm?=
 =?utf-8?B?TlByN2NmenVwdTRJYnIwN0xPM1d2ck9jaVJDMGJvalVodTE5dzhiV28vb3RJ?=
 =?utf-8?B?bzVZRFpGczl5ZjI0UkVkVElDckt0a1VxOURZQ29MYjI3TUVsS3J0MFFRY0Nz?=
 =?utf-8?B?UHZqMDk2a3hCYkFwZk9FeHlaZVZ4UHNrbUZLdnhYS1B5SnV5ZGRRSVJmTU1v?=
 =?utf-8?B?SEp4ZkpVYUZYUHlPS0hCYW51b0VTM0JoOXFRd3h4MXB4cGdwMlFVZS9zL0xi?=
 =?utf-8?B?OGYzbXc2NW44NlNkVHNTckZZVFlIalpxM3hxcFdiWlljRUpCcVpPTDhkTy9v?=
 =?utf-8?B?MU84T04vNy9PbU1TTW1wTmFENDdHZUxvUmMrbXpGc0IwVXhVeTlZUjJ1NWRM?=
 =?utf-8?B?eUM1bFh0ZXYrbUoxSTlWMUFhSE02TEgzSXJsanp5Sm0rWE9yVnRjV0VZVzhl?=
 =?utf-8?B?UlR6V1VVQ3NPMW9hNVZCcGJHckNzdTA3Z05CajljZUs4Q0MxdXg5b0pTVjdZ?=
 =?utf-8?B?SVZ2cEt1akUxaWdRVktiSmwzaWVSMjNJKytnN0ZFcEVJbHo2Q2xPeUJqS1BQ?=
 =?utf-8?B?YTBSK3BBZ1VrMTczTUZlN3NXMTFoakpvcCtUU1Nla1lscE1YemV0L2FPcE5m?=
 =?utf-8?B?U1YwWWxCRnZzWmMyVkpOellabHBFQzJBU3RnQmlTQUdZWmxiUGQvbGpOZ2Rl?=
 =?utf-8?B?bHJNTWRtSUJ5dUV0dVZ1SjduSXNIbEpwMlNaUVZOa0FIODQ5WVQxWGRFY3FX?=
 =?utf-8?B?aVNxY29BQlR5ZUF0UVE2YWNqQ2tiNWcxRjVKNGRKM3FQMUgzMzMxYkJtMFRw?=
 =?utf-8?B?UWs0b3Z3dEl1dkg5dzluSjZzV1FhUnhsMGpOUXUxTDREQ3RTMTl6dnBtUXdr?=
 =?utf-8?B?c0lseUtxb2hJMlZhMlBOM216cVg3LytWU2lCZ1FYVkdnL1UyZ1pNU2ZzelR2?=
 =?utf-8?B?WENaOUFsVTNvOGxlcm1iRXMxbHZjeWVoRlNIcnZ1WDFjZ1U5aWtWQlZlV1hR?=
 =?utf-8?B?bVpvREFheHRUaGRnVXgxK0I4UHFkVkpIQ0F6LzZobEpyQkhTYkJtUkdEYmJx?=
 =?utf-8?B?SmJzdmx4QUZFMjlSTXY1M3MrUjdIZldIVkY4anhORjZSTTlvemtYMTJhZDJu?=
 =?utf-8?B?OUE0VTk5R3FMRk5TYnRXamxNOTBIMkNvSHQ5RXNnN3NUalozaTNtUlB3ZTdl?=
 =?utf-8?B?ajdWUFRkRnlqRWlkZEhTTkozdGpQMzdXWDhpTUczSFZQT0dKWXpnWDl1eHFQ?=
 =?utf-8?B?U3lQN0ltQ2pLR0tOSjl2VCtRZ3pneW5Cdng4eXZCOFBSK2hlZWhYbmhnaC9E?=
 =?utf-8?B?am1QY3RVdFhjVmhxeTVRaTczL0RsMkZZUGlhYUtNa2ZhRDJ3T2pRaSt0YjVo?=
 =?utf-8?B?bXpMR3BrektRc1pYamNkOXpCak9NQVk3RjVCbWp6VHVjc24wS0ZmT0VBZURp?=
 =?utf-8?B?cFpEdXBpR043bmNwNmxteG5TQVFDdTZSRWpIMEgwdVVzaHU4WCtmUlJNSElT?=
 =?utf-8?B?U1E4MDN2b3E2Tlg2bXdsU0ljczYvdEgwK0t2RU5oYkVzaThWblVLdG10aWRQ?=
 =?utf-8?B?ZHRaTE1qUzRKUkFTNDFNaWlXazhUcnJiYzMzVWx4UVhHUHFLZHRyWC9VZmxx?=
 =?utf-8?B?dkVvRzE0M01jTGkvNHVyOTlvZHZtaE41cHAvdXVPMEtEY0hXbXY4YW9QSE16?=
 =?utf-8?B?RkxyRDI1ZVFUV1EvL3VHMHBENWIvV3ExMzBTdlZBa1Y4OGsyU3hUdHIxR0Jw?=
 =?utf-8?B?OEJmdEEwdVRnL3BrNlFxSUw2TTZnZkt6eXZHelNIam1RZ1Y2QlpEdkE2aWhW?=
 =?utf-8?B?RzdTeDl0dmNnanU4ZGkybVVhOVo4eUN3dE01ZloyVTZCT2J1Q3lzUkRTT0pP?=
 =?utf-8?B?RGplRmxOUVBBS3UyK2N0R2NMTlJmZEwrcERLQjZESHh4U1BxUm1nSjhXQWJm?=
 =?utf-8?B?bmh6azZzVm1tck5Qdkd5T1FCSW5WWVRHdUtFcGxIbXA0bGdaSE5FMlpOZ1N2?=
 =?utf-8?B?MUh5dTdRRmlSVC9WZG1tUXpaOUMvV3h2T3dWWGREWWQrelpEOHJYNVJKSGg5?=
 =?utf-8?B?d0ZTWE5mQ1UzU05uc2pBUHNIMjkvQUlJa1NnL0RsbytocU9mdDVVV1ZSQmlk?=
 =?utf-8?B?RzcrRlFVVEtQSzFhbkNFMmJXK3YvRzdlMUJPdWRTcU1DTVczOHNZeDJNY3pz?=
 =?utf-8?B?VWRwb2JnNFNFYzd0NmVTOHZocFBFOElLTzZ5REFyczVWTk16MWVYMUNDZnZO?=
 =?utf-8?B?LzFzbzVKYU5RZ0dOR1FVcVVMVEFGWCtaUEo3a0ZZT1ovZHNocnFJcnJ5S0hP?=
 =?utf-8?Q?Dtuq9AvuZjS5OQnw=3D?=
X-Exchange-RoutingPolicyChecked: LTNjXuLhvWv9AqJeiwH+ZD3A04heqhEXDqhiwhv2dBgAxWBBNKYPa81SE7TBisf8VDl5Rk7WRB+rOCyZGSQ9BqZeiEAvxowXbK8mwDNZ4ht+sCONX3JZ1J5LivMfjoRSDEU8IjTy4w2OMwGk80w3Gky+4f2FzCOwWcuiPBEkkue0UplvmO69Re0QsNrX1hl0eKNkI9+Aarz9A5VM7/SaH8edRq//F6ZmxgSW5XM6XEpesu1vHT690KNMp5AjaWKxS4BSRQviFTPhQb8wKZGiXctLIY6DSDbopWRVU5FnIugSe2y8fN0RtYZ9+m2FlC9E1fX/mn7XfmCqDxZcOqqWgA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4363f-3cc5-46c7-4317-08df47257640
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:43:53.5053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbv1u4vIjsCu5ZVKwYABpMXugHI66iUMUSPgogQODOkExULioTCoSyy+aHjRDrjPvGacdt1ZuPKdnoUoWN0KPDU/3SnhGAaOFHM1FO/PaKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR02MB438868
X-Authority-Analysis: v=2.4 cv=f93dl+yM c=1 sm=1 tr=0 ts=6b0078cb cx=c_pps
 a=URhychnWC9B1Vwa060GvLQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=e-3uWgxnBYeC4iJrxYEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2NiBTYWx0ZWRfX2QePe7bEkZ30
 ST5DXpYv1eMdMg1YKgQq7ClAIq1YEmHGWOFeLUj+x/80fPA4E9gTqjoQBzGtLWVrDJdN4FM1pQ4
 bN0gDdyz1ulIRlLofhgAzw+KrvNDFsA=
X-Proofpoint-GUID: ITr1y9nXv0mIWWlgbU5E2pe8WkTS-sfn
X-Proofpoint-ORIG-GUID: ITr1y9nXv0mIWWlgbU5E2pe8WkTS-sfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2NiBTYWx0ZWRfX0Q69J82Xw8Wm
 rY1fXBEfc68QhcVeM66o8OpWiV6+18oIOOVcHU5HLXoStc6TrHk89zjWioiGhHAh6JxXaMtoDtN
 f2E/yc1vbJTGjOiflh42hoFUDe0sy7Ehs/Hmqk5ficS9NyAlt/hVhNifA0dDVkbu0dPZ4r8FEML
 RL7Rdaxh+3nb3EIvc5wcVezldKhmoFp75twKkgOM5hL04GBJhFULVWnsRQYRa/oTJibs8ygPlSN
 /9voeMQhRyS8/f1vUwZ5Micr6MzwPUzuV2cHOctG5qdwEryLZCIcLNyx/73w52IkzC++6o7y4Cr
 rdqPdEw0KQiZSLQuG4+zcb1hyyQ7Y3k1MXuH81b1RzsqS8qU75Ua5RE8F+ipLKDU5iyBKAguBpw
 luWjCDitd2xMQtssitI88EhAJ1CIa99R0wOFFsBn4Ysnb5U0pa0oAO+EKbTTCbso0442KfJg4Mb
 5V8RDAgwpXJDb2HsS8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/2026 16:34, Philippe Mathieu-Daudé wrote:

> On 2026-11-20 10:59, Mark Cave-Ayland wrote:
>> On 20/11/2026 08:25, Helge Deller wrote:
>>
>>> On 11/20/26 00:39, Philippe Mathieu-Daudé wrote:
>>>> On 20/11/26 00:32, Helge Deller wrote:
>>>>> From: Helge Deller <deller@gmx.de>
>>>>>
>>>>> This is the third attempt to replace the existing 53c710 driver by
>>>>> a new driver based on the code of the lsi53c895a.c.
>>>>> Patch #1 is not meant to be reviewed, as it basically just replaces
>>>>> the existing driver by a new one.
>>>>
>>>> "Please do not review, simply accept".
>>>
>>> Well, I agree, it sounds quite rude, which was not my intention.
>>> I basically wanted to say that it's a hard lift-and-shift patch which
>>> makes no real sense to try to review, as it is huge and replaces
>>> most of the code.
>>>>   hw/scsi/ncr53c710.c   | 3042 ++++++++++++++++ 
>>>> +------------------------
>>>>
>>>>> Please review.
>>>>
>>>> .
>>>>
>>>>> It would be great if this series can be included for qemu v11.2, as 
>>>>> the current
>>>>> driver does not work stable for any guest OS.
>>>>
>>>>   11 files changed, 1426 insertions(+), 2215 deletions(-)
>>>>
>>>> IIUC even v11.1 driver "does not work stable for any guest OS", right?
>>>
>>> Yes.
>>>
>>> Helge
>>
>> As I mentioned in some of the earlier reviews, I have a lot of 
>> sympathy for the submitter here based upon my experience of doing the 
>> large rework of the ESP SCSI driver a while back. In particular when 
>> working on QEMU as a hobby, it can take much longer to find the time 
>> to complete any changes requested during upstream review.
>>
>> My take on this is that we want to encourage more people to contribute 
>> to QEMU and unless you happen to be an LSI SCSI expert it's almost 
>> impossible to review a large rework like this - and this shouldn't be 
>> a barrier for contribution. It's clear from Keith and Helge's comments 
>> that this series solves real problems that users are currently 
>> experiencing with QEMU's HPPA emulation so I think we should aim for a 
>> more pragmatic approach:
>>
>> - Aim for a basic code review based upon our existing coding standards 
>> to check that the device implements a reasonable object model
>>
>> - Ask for proof that testing the supported guest OSs (Linux, HP-UX and 
>> NetBSD) doesn't trigger a sanitizer abort when built using '-- 
>> cc=clang' '--cxx=clang++' '--enable-ubsan' '--enable-asan'
>>
>> - Mark the device as not being included in the QEMU security boundary
>>
>> - Update Kconfig so that the NCR710 device is only built when the HPPA 
>> target is selected
>>
>> If these criteria are met, and given it only affects the HPPA target, 
>> then is there any reason why this series shouldn't be merged?
> Sorry if I missed your comment on an earlier series, I was not Cc'ed and
> try to not read all qemu-devel@ :)
> 
> I understand the hobbyist PoV and respect it, but that would settle a
> precedent which I'd rather discuss with other maintainers or during
> a community call.
> 
> I'll try to split this series using a LLM, since this appears to be
> an acceptable use.

Hi Phil,

I think this work is different from the ESP device in that when I did 
that rework (about 88 patches from memory) there were several guest OSs 
that I had to test on each commit to ensure the series was bisectible, 
and even then it wasn't possible to keep all guests OSs working for 
every commit.

The NCR53C710 is different here in that it only has one user which is 
the HPPA machine, and the submitter has clearly tested the set of guests 
they wish to support and has considerably improved on what is already there.

Based upon my previous experience above, no matter how you split the 
series there will always be at least one guest OS that won't work: by 
splitting the series it feels like the end result won't necessarily be 
any better for developer maintainability, and will delay the merge of 
some much-needed improvements.


ATB,

Mark.


