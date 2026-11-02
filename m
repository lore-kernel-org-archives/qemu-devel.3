Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9D606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=tcU7GmB3;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=iu8/4ybk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNp0t-0007to-0o; Mon, 02 Nov 2026 05:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xNp0g-0007mq-1d
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:11:30 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xNp0d-0005K4-GU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:11:25 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AIoO391708; Mon, 2 Nov 2026 02:11:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PYVL+5siwuF+6uHER0IxAjMepaVGhNPofW0t7MDI7
 EU=; b=tcU7GmB3TYIZSdgPa4mhwg7TKfjbbxIHq3uBdIbhPkHj3hJ45YHyVs5A6
 /vlmk71T81J+FYmukaI7Z+aJGPM8wYldxkqsad0p6ipCx3cdrpHphuGAvUPPq1vF
 Gd8LSxq4RrdIWu7/vLDhU9YsyGS3fgr9xcR0AVAI9Jewm6+dZ21k+VSbGXSNt3Xs
 uSlvGpXI2KLoawwCl19tqCBU9hxQeTzz6lpjfAjzEsWbFxLz2GscAOQgbLn1L8eP
 wJsM0dorwF6Q42104oMCmN61qccg7McUVn1zfp15FHKkNHmbQKhqusKBYt4ILCmi
 PIKyrCDaqzEvg9D0AF1rGZGay2gJA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022089.outbound.protection.outlook.com [52.101.53.89])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hndv7u5rk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 02:11:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE1sVege6tD2QzZskLl9OlZIoIJ0fv772wBcAPOvRORc7zffKH/4XQE1XhyVJbyDup0MUPBVJGQ443W8AX6jjhwWODpWLmzhKlNMIwM0v4be1dMytQhXdZnocygdN+y/lCBQBbS+g81ekV3lx//pZN9aJPmJEZuVBgZ0oGOy4MeonEJ8cYGKBqWX03TRJfwn/ZOWVG/j63Ek0QggDH8obxDJIiwqTnTdY2aWUzQE9P9K3JW/TJhWYkbdmlV2kRtcrMaiG7RZSGmkrICDek7jYMZLugnPp16yun0eMRErpeHljuJejs16iRwuqVBHXjRnsEiOLf0ctketX+TsI+GHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYVL+5siwuF+6uHER0IxAjMepaVGhNPofW0t7MDI7EU=;
 b=jbwKslFQCltPil36ZPJRdaSlq4oCsi+IcVmzennbtxnEIhowDgCuQ8B69HkClsEdfyCG05rYfVBMFjEb8PsHAmXCCMC5PGqhddtgV3LAZ72dUMIXYTf3QBPD9tb1pzBWAG8jLKhew9QgZaLR06sluPcaX9vlJxEp4MOfg+jRfvd7oZp7d0O6QdA2XNl6mnU6jk7S1E82pV76FWfOOkNNou5S39EgrkG/SMrqPk87WsEzYLRCgN/BEVeBKa9iYOjmWPbhJ7K9UIyJ+Ief/rrXTNpGs7cFqB/4yNaDbr3jzdiTfAAuAW4Z2mAQdcDkxPOFEXtNdBXmvheX6odzAtFOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYVL+5siwuF+6uHER0IxAjMepaVGhNPofW0t7MDI7EU=;
 b=iu8/4ybkZVCDfUNBLS3dYv5QjkcCWr4Gx/GWVqLPD4ZcJCojv+NE0v/kOjVztr9phNB4oFqHNWkaC7g1Ydd6la8TUnhxs3dhjjFO62BK6LMspn2dKQjFaerGiVx5s4zdmjf1HXgwxCS+1TpjDuhyt4kAt/+mv/T1BxyTtBv7zLJ61R3Srzzp6FAIdz0Xcx7qff3FmLSzd1BDYLMmnU0ZZDYyVjef52a+sUkgqTcdkJosz2dg24Ewe0zfHcgtpKIv/cKTCVeApdwIfTN0ZSXA3yVHT5iNfwaWC8F58IQo/eRjVKhC4bnCogtd2ySaL8By7BaJsdYnT4BfLY9Sl8GhUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by SA2PR02MB7612.namprd02.prod.outlook.com
 (2603:10b6:806:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:11:11 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:11:11 +0000
Message-ID: <2f95e624-974b-46e1-9d00-490a3e690534@nutanix.com>
Date: Mon, 2 Nov 2026 11:11:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] ui/clipboard: keep track of clipboard peer side
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
 <20261030141442.264308-3-lucas.kornicki@nutanix.com>
 <179343138750.2067999.4231298981143140799.b4-review@b4>
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
In-Reply-To: <179343138750.2067999.4231298981143140799.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000225.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ea) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|SA2PR02MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 8badb1b2-6f61-4f80-934d-08df38c99eb4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|261021135927099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: YbNVY5Qbo7UecDqHjOcWOPsahGhBua4GLJSRkBYAjXVOfNq7HwjO4THYYotaiTazUevkrrD5NtvCjmN+CWTdf41OXnaPKIq9EhebyEH+0X8r6J2+PDd5vsflKPappwcMFXajG0QG4v/QxYqmF16zHDiYcbwUaj0/uGqp0air+KISg6GLyWHZYHCB3ffDACweIWb0yLzvHyX+76uhm9z5vyckrXD2HxPtlcKWUTHYegwcgFXM/aZOb6F66elcUHNvcEEXG3yn5BYEbkHshhXmBXOIwjZMX1CcPYeKEN7rQUYixIPJw2c+q7Arn0ciZpqO+ZEiP5w3CkWkHsZ/8Wp8o9OnvsJYRXOXsm5VrmfALCf5P4vVJXCCnfKS8s5fkeJFjX+SsuiCWdvjDqkLvSUCiFi/ap9MW/Ha0mZh1nd8ZJckjnXmsHPVYFKLUraWe8hZ0cQneniwGu6dopOlKprarnHzALm9BAVFAhIM3pOvcmgnZO0Tbf+NwIVqR9/3kMuW1hmwQozcZcg+DRKNddJva/L+wfqwDjuTQwcZdgWMBK+ltjd8LRESRbtwfxEj4BC57cN2jvw3d8nBC+bdENvCmSjz9iwJGSAUS80HlQs+N/z3XP5yxjZBDZTOox0AJkmFxA3hi71qqIqWFSMptC7WRWTXzJWhrB/fmzzhZvwfxF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(261021135927099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9CWFpxMmxHck9DSUpzL25saTBuZVN1QmZCUGFTUlFRNUVpM05XZVQxa2FP?=
 =?utf-8?B?RzdhSEtxcXlMcFczdW85ZzRzUnhKN01LQ2Zka3hhb1F2TDlkb2JxVHdGbzUx?=
 =?utf-8?B?aUllK2lsOTRqZWtaL012blFodjRQZmROQ3BQTzlKdjljZXRxRUZ2Z0VoOTlV?=
 =?utf-8?B?NUYxMTVPNm9ueW1lRzlCTzAycGVFUmRqY3hUM1o4TkZwcVduK3FRZlU1SFh0?=
 =?utf-8?B?bzQ5bk1GQ0JXRmtSS2RDUmc5YllRNzhVUEorYU1HQW1TVmxDbncrMmdEbGpF?=
 =?utf-8?B?WVVXTUJkazZ0V2NwdWlDYlFYcW1tVGZJN2VGOGx4anFWVHVrZ09oSmRyWVIr?=
 =?utf-8?B?S1N2UDlTbVpyaWdpTXl6QjVDTXZSMklpN0dZaThqQnJLeE8ydUdMenJqRTVQ?=
 =?utf-8?B?WjJMZlhZODV2T3RQZklxb3BxWFVOOHAycGJMZ0RLakdSQUZnMkkwQzFoMEhJ?=
 =?utf-8?B?RjBNUkhKL3lkVVZIN0ZuU2RkZXU1MUJUWGszclBVSlFqNDNKOFdSWnplSENt?=
 =?utf-8?B?ZS83UFBWd2tTSFN6cVVFSGJCU2Zzek1YSUpxY0UxNS9SNGlDbDFUeDBaekg1?=
 =?utf-8?B?YWVINkpWL01xVG4xQTA5SHM0R0dVQmp1dG51eVVuOFU4MHR4YUtZQWcxOFlL?=
 =?utf-8?B?cWYxNHQrQnBtMDV6MmhhUGE3Q3E5TGFJMDF5RXl0VWJwVHk5YndUbVVFR0RZ?=
 =?utf-8?B?V3ppL01icHpVL0lrTktydEwrSFkwbm9lUkovVUJIY2FXSlBEaG4yY3oyNHc3?=
 =?utf-8?B?Z0dxb2JGZGxOYmFOdCtVWHBJZnlYcklHWk9lb2xpUFVIU2pOQ0lyL2d3bEs1?=
 =?utf-8?B?aHU5RnkrcnZNQ2svdEdRVnQwKzh3WlpyNzY4akZoekJsNDF6aFdBWk82Q2lM?=
 =?utf-8?B?Um82bEVYTk5PTGJOM1NKajliaG5Jdk9LbUpaVmdQbGs5dEd2Vk9sUDg4ZC90?=
 =?utf-8?B?NUd5ZE8yZGVDVU1SOUIxTE1DSHB4U2grdkY2bGw3bGQvdXhKZGhuL09odms1?=
 =?utf-8?B?S1cxUVRodXByQi9hUkIwTzVISFJBMllsMnRhd3dWb3hjOExVc1FiSzVjeU85?=
 =?utf-8?B?OUM0R0RHSVpzU3NUbFBFS0NtY0dIVWZqRzludWw5S2ZXUHFPTHdQa2F2Ti9q?=
 =?utf-8?B?N3lFaWZOdFpodUQvTkJuMmVhT0lXaS9VL08xTk90ekZISXN4dTFLa1luSWJI?=
 =?utf-8?B?Zmo1TUtleUVQajFCWU9nK2VrUktaZkJoMGZFYjg4WlI2eURZRE55UXo2SUVq?=
 =?utf-8?B?V29jNUVYeDkrS1YyU1cwdGNHbjlUaWpiMkp6Q2YwaWVWbWJmYXJjWHQwR0FX?=
 =?utf-8?B?R3p4ZW5IejBRVVB3REd0cDVJMk8wekdTWkNDeHY4djR0L3prbTdCcTRyNzJJ?=
 =?utf-8?B?ZjlLQU1BSllkRkRXWCtUYXFwM0xOQzVwaXN6SVMwTVBVYlh0azgyTDI1N1A2?=
 =?utf-8?B?MVRPM3krSnpiVEVtb2tzL2s4S0ZmTEg1V09JVlluQjBaM01UQzBmTzZMWExO?=
 =?utf-8?B?dmNIa2pjMlhaMEVlemU2UG8zUEtaRlJFZExVakJiMVc0QVcrdXV2YW00aGx6?=
 =?utf-8?B?bW9TZndQSzh6NmE5VWZhTVNHOUVsQWxkSU9yaGJCMEhud2tQUWZwc1JhTzRx?=
 =?utf-8?B?QUxZdndoTUVNTlF1dEx0dzJVNjVDR1NvVjMzbS85U212Ukx6Q0Fma3FoejU5?=
 =?utf-8?B?V2ZMNURPRkkvYURqY1JqUUhUcFV2WmR0ajBUYU9wRnRSbFFhUDF3azFqbEpx?=
 =?utf-8?B?cnZZT0pJWm40TEFXYU1ObC9FbmVUVEZyRFBhT0Ziem9FYUFqQ2RWSTh1VDl0?=
 =?utf-8?B?UkQrMlhyK3U1Z2xkdFRqbDRZUC9uTis5SmFPRm1mQ0pyT3Z0a2wyNjlkZjlD?=
 =?utf-8?B?NUR2dTV5SEFjakdhS3lJNjlSSEE2VmR5d0JIbzl0L1JTSy9rOVRYeGdwSzRD?=
 =?utf-8?B?WnFhWk1wZmh4YzhSeEFQbmNvbk9QYm5nWENKUkVEWEQ3cFRRaTQyQ3BRekFG?=
 =?utf-8?B?Uk1xUHZwdXRZdGxkbDl4TW1mYkpmMWRON1E2ZTVaRnZaYnVHbFNIMjBpNlFW?=
 =?utf-8?B?dExTb0hYVU51QkIzbENZMUw1cjl0bFJ0T1dYNCswN0Vmd3JCYSt6Z3hZQXdU?=
 =?utf-8?B?NkRrR3BrT1djQ0FJNUZDWjVBaGY5WHBnTkUrZUJSa3hZMlk4eFJock1KUnIx?=
 =?utf-8?B?OTZZQ2FRRTlia1dnRlZncDlRSkNEdGxWd3FSNFAvV3hZTnFRMnFlTWFqUVli?=
 =?utf-8?B?SUdVWWdqVWd0QTlOYVVMdG9qTUh0QUhsWHZiN1JMUDdHTHdBTVhHTGtKajBV?=
 =?utf-8?B?TWRkMXpnWXl2dnJyRTk4azJYSExxR212R1RPMTZlZ1NtK3FSbzZzL1NhaUVB?=
 =?utf-8?Q?RTdvrv00hFi0/XhE=3D?=
X-Exchange-RoutingPolicyChecked: iwz/bFACSuMY2zmEWnh9jvANO6XiQph6uEidofglmQVEpwrytJHHKzx4aiOjFXm+un0kDBy4XIubdSJFlpnS2wTLCGAyPdJBk3ueoEb5TrWHpP2QjQqX8wzOr8gPLhhLjOKGER8CyXFR2rPsvF0SOevc2dmbi1ybV1l8MMTX5hwWkK3ev4EkBOcnQB31UVDwtsAmo6dTeZTb/wTDu2Q/ZVUMnntjuNZunUXiVXbsnHuvHQHKz+Tyr0KN5vk4zofAsisyfaAUBPT7i2jbfYeum25oxF3KoRGmM4jahksWiFP7yw1bitIVI3fh78O4WQKQVdYZa1zbxr8hTQBhB0YSBg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8badb1b2-6f61-4f80-934d-08df38c99eb4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:11:11.3968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W//owTVCbI3zhCMM+fiAxKcIFtNulDyCDxrR8yr5U9eTdkSyQIiLZFYKH3GgC+4a1OQ8+gDj3Q12YRL620/vy+isqx3JisL1u9qx+DQrbxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7612
X-Authority-Analysis: v=2.4 cv=Wta+otfv c=1 sm=1 tr=0 ts=6ae861c5 cx=c_pps
 a=eNyQiorQ2xlxnIB2M60cKA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=g_B3cWMxSFDp0DCbsCgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XmnEcSnKyPDSeXHO-Zjmd2XQ9JnfflI0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX+iN1nSyousA6
 AU9w0C63xw5bhfqkrwGvQIfY4f1jRY/XqszXd9OK6aCk7foDDtr30gLPv8OqfqckX+CYdNG3vAO
 RxPgdhk8isYnlIuu89+/WfvUKiYgQsILRLNKGmjQCSyi0N/6xLHUcBr+R1kE6rEQkBY7Un3ZrP1
 MrH+krG7KFVAan3D3y9b3pgEMAoPZ0i+L1MXUTlMESB6wwnVLOSRbLd0QeFP6EH3np0ZcZAgAkv
 wsIbRkfb4UmgLMagWfC38hp/r4gtw0Mb+hyI0CZML4xjm/vdGNH3XSUonSyitwlMRdNZ9Qv93qZ
 IzxWm+q1jLMoXXl0o51B4E4zIdi/e3D6OEIt+XM3SAAKu2qnHYwbUVVpIzwUhkBuFGHEAIfdbdH
 q3tb2mplDXQQ2zm0xpCYyGjc/94MWKmzqBKwPwzxAzaZ4qEy+wW4MttezeAQxOpv/Lz5PdBRsjH
 qzPfOSyUuyvr7L2re+A==
X-Proofpoint-GUID: XmnEcSnKyPDSeXHO-Zjmd2XQ9JnfflI0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX3wftdGLw6Xom
 xajcVwKiKiv+u+Vmfdv1XBvy9ulzHCahMtKQyN5alY7AuOfA3KuNQPVmyikeRPXND0nJvmtMSrY
 3slRcCTfy52axhrR3ndZkgrP+4SgvAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/31/26 08:23, marcandre.lureau@redhat.com wrote:
>> Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.
>>
>> Use the flag to keep track of number of registered guest peers and
>> allow to query for their presence with
>> qemu_clipboard_guest_peer_present().
>>
>> This change makes it possible for a clipboard peer to determine if
>> any guest side peers are present so they can tell whether a guest is
>> actually able to participate in clipboard exchange.
>>
>> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
>> Message-ID: <20261030141442.264308-3-lucas.kornicki@nutanix.com>
>> ---
>>   include/ui/clipboard.h |  9 +++++++++
>>   ui/clipboard.c         | 17 +++++++++++++++++
>>   ui/vdagent.c           |  1 +
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
>> index 6166af513906..250f1d8ea53e 100644
>> --- a/include/ui/clipboard.h
>> +++ b/include/ui/clipboard.h
>> @@ -62,6 +62,7 @@ enum QemuClipboardSelection {
>>    * struct QemuClipboardPeer
>>    *
>>    * @name: peer name.
>> + * @guest: is peer guest side.
>>    * @notifier: notifier for clipboard updates.
>>    * @request: callback for clipboard data requests.
>>    *
>> @@ -69,6 +70,7 @@ enum QemuClipboardSelection {
>>    */
>>   struct QemuClipboardPeer {
>>       const char *name;
>> +    bool guest;
>>       Notifier notifier;
>>       void (*request)(QemuClipboardInfo *info,
>>                       QemuClipboardType type);
>> @@ -179,6 +181,13 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer);
>>    */
>>   void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
>>   
>> +/**
>> + * qemu_clipboard_guest_peer_present
>> + *
>> + * Return TRUE if a guest side clipboard peer is currently registered.
>> + */
>> +bool qemu_clipboard_guest_peer_present(void);
>> +
>>   /**
>>    * qemu_clipboard_peer_owns
>>    *
>> diff --git a/ui/clipboard.c b/ui/clipboard.c
>> index 3d8f58a85508..f750b494eb6b 100644
>> --- a/ui/clipboard.c
>> +++ b/ui/clipboard.c
>> @@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
>>   
>>   static bool cb_reset_serial_on_resume = false;
>>   
>> +static int guest_peer_count;
> Rather than adding an extra global (that must be sync), why not simply
> iterate the clipboard_notifiers?
>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Good question. I wasn't positive if it was thread safe to walk the list 
at the time,
hence going with a global counter felt like a safer bet since there are 
others like it.

It looks like this is not an issue and cost of recomputing seems reasonable.
Since the series was pulled, should I send in a separate patch fixing this?


