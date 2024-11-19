Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30535D6C299
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUuT-0006zX-Ao; Tue, 19 Nov 2024 15:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDUuR-0006zO-Dh
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:33:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDUuO-0005z9-Tg
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:33:15 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMYUo005984;
 Tue, 19 Nov 2024 20:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QGxa904dXkmyZKRmqhVAwR1YstDW0p47rgzXCyTDYyE=; b=
 DJGB+F7FUtx39IVXcc9EDg7G1w7+/a9aHt4XKzjlmkxVknVCqxlSjNndOu+Wubo+
 NGFQxX7C1+DPiU1WVFp3Jwnw71npb6ybaBKbcexXhpsKAcyY8by4weh0fHAKypWE
 Eh2MrY2UF11ckE0yHATWVlwpPWPCP9ljgmmnx+36Y26D3n8PSNy3J5v0+ghfLXOl
 FjMzfhcZU+22vl+3yBI+Ph2Hq3g7rk87pOn4HdvFmRMgTvKujr2VUxizB9CUyoCq
 ZAq4uwZAV9Pb0eyZYx9UOLB2LIn3Ghm0tCUF3yz4K8gN6Orn082RbXwaOuy/UinZ
 GvNwpogewCdZ5zooct7Dkw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430xv4rg52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 20:33:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AJKUxuO007758; Tue, 19 Nov 2024 20:33:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhu93h1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 20:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+WHqus3jtrNPoPDGN5f2l1yTx3NENttuGPelI806gqzkhvjfd3qZJd3e0ecyibbwtxXRyNq8g5diEa3FQL2ICXmFfZe8AVsW56P6TeQQF8rDUjp/9a/e97B3N+Cxg5U9R7iCK40VTf3FMBdKM+bZuc8MCq/GE4+phIivoRiIrEn39Zr0X962U9U7Cit+ztMPyqchObSynnz1FpcmyHuxJN1zOlA53c38Gv2Kc5zm700+J+BKD2cUeGAxfHIFZZ7One0P3Fdihhq8OKRXHGtpJ9DQ9Sl6X2wVKWP8TwPZSwTzPNCVL+FEw2iieyUAmvi2rT3f61g/m9bE7MhWrkeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGxa904dXkmyZKRmqhVAwR1YstDW0p47rgzXCyTDYyE=;
 b=gR04mpz1kv9g6B23ssoKfwNCK72jhpJ16a94clbB7kvEfRo6kbVQllbFpuA8GMCcDSSCQtlA2FA3wlUVWfPHsTij9djVGMXc6BWSUL0eaSfsUTviA/q24HWkyfu9YD8/3MyHXAlpJtgTs4ogdgs/ZUKtMqWJinjwJajO48k/AyxU5EXTcCUEoyxIgIDFOxTXITPQme+CEfgLKhfWra6hUA92c+jiTt9/HUTxgtzYlQp0Aeo2DKeF3Z+RMoDFtWz3c4yQitbQDOEX1TWezY3OYvBuj3NHkSUOFS/Pw28Z1dyl/jS4OQD0cUdz3bdXladyt6KJeNBBakewjHO1UFu3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGxa904dXkmyZKRmqhVAwR1YstDW0p47rgzXCyTDYyE=;
 b=qydfZWDNmTF+v+bgFhZrWn8vQ/VVO2wumPOLRaUE8rpFzAFdfH7YSDC7aO/OJ1pfnJFYo2A1wB9GiExHDZBlvczB3pIWXwQ28wepXeAYC4D59RWJO1dAcuXmJSn57ivTcwzTByY5cE8spENeRn43eaUQQ7k33knklD7b6iq631E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 20:33:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 20:33:05 +0000
Message-ID: <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
Date: Tue, 19 Nov 2024 15:32:55 -0500
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
 <ZzzyOJT_mDh37_Py@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzzyOJT_mDh37_Py@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3dc96e-fe15-4f4d-bcd9-08dd08d95f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?by9SMlg1Umg2bWEyM0ppdFhtTVdWNk1KdFJQdzYxMlV1TTJSeDQwUFdpSUw2?=
 =?utf-8?B?SkF0ejJaNFlIUHEvRkZMU3FBeHN3a2R3STV0RTFwZEx1YTlnQUpVNGNoMGlT?=
 =?utf-8?B?ODlhbTd6NzZxUHNBZnlVd2pVaCtYYTZsQnk4V04xS1I3TVE5Vk9IMFpLbkJt?=
 =?utf-8?B?VlNRWGdmNHZpK29CTGgwQ0pSSm8xZWduc3grNXFzTGdzRzNmUG1XOU45OFhF?=
 =?utf-8?B?emhuVTJDcitLelBnb0JLTVRDUlp5eHNoS05WOFJSZWwzTTg2UWhQZmlTVWZF?=
 =?utf-8?B?Zm10Mms0V0xGU2pUYnhMVHJ3UVFDbnJrbHFURW1rTXlyUE8wZ2JrYmVMdFRF?=
 =?utf-8?B?WVVpalJNL3lvNnE3WDVQQ3VxeVB2NHMvcEhWNW53YXorOFVQVEFERVMxMTBs?=
 =?utf-8?B?T2hKRldFWWozRW5UVWZSaFI4bURad1FsYlhqbzV2eEp3LysvUlV5MjlqdnJv?=
 =?utf-8?B?dEN5RTR0ZGJ1YVkzNVg3bmRwekRMSlFiY090eWVvc1lZTlBuTEJVT3cvWS8v?=
 =?utf-8?B?MTNZdHlQcTAvM2FBcDFtdFVsSCtrL3FUTHJkSWV5Q2F0VVNKNG1RUm1zQTZp?=
 =?utf-8?B?QnJLZWlHRHQvMUJpdU1WUWJ2R3ZoZ3dreHpGcFQxSUhpTGd3alB4aWZYM1Aw?=
 =?utf-8?B?M0d3c2hzTjhydElOYjN6SVMrMXR5Nkx0SlpzQko3VWttWFRVWDFNaWZWSG9z?=
 =?utf-8?B?R3E3dHEyZUpEV1BzYk1Mb0NuWGJnN1RzYlI4cEN0MGs5QnZaSHpUSHhxWmgz?=
 =?utf-8?B?akFkR0dEMTNXUHpoQ2Y2akF3Y21yYVNQcGE1dkRieW1zU2wzb0RNeUlTeTdZ?=
 =?utf-8?B?amZsOVZlaWxoYXlvOXhRaFgxZmdHTUNTWjl4ZWVNYXJ1SHI3bVpkNjFKdTd6?=
 =?utf-8?B?WFVGUWtHT0ZOUzJNTm0rRE96SUd1cFhka1Eyd2JHdkNVS0xjc3pjZExOKzJD?=
 =?utf-8?B?dy90Z1dTODdXQlVLR3EzMEpHSnRoRnFnR2tWUmFGaGp5UEJHMG1YazNoLyt2?=
 =?utf-8?B?VXVOMXYvbm5YdmJ6SFFZc2s2RzFqNmxmak9hQzJPNFcxNERycXFCYmhJRnZ6?=
 =?utf-8?B?ak91QVhnZ3EyR21INCtHS3NvTlFHc3pHYlNSSWZOYkpyS1dsekFJS2xRcnZa?=
 =?utf-8?B?MVp4V04rbDkwenRrUncrY0R3WjU4YThvVG1aM2piUUY5TlBibmxXWFMrZU1t?=
 =?utf-8?B?bHB0d2VyemFUTGwrdTBYb0xXQjcwTlIxMGdya2VOU2dneEZhVDhPdWJEQllE?=
 =?utf-8?B?dDcrd1Q5dXFPRlhQWXg1cCsrRndwYlRsc0VGcHRqbmk3L0JXN3Vta29ieEhj?=
 =?utf-8?B?V0Y0TW5jN0ZEOVMzQU9kMWtWMlJHUGlkNHg0OTNVTkJ1MUt5NDFNWGZhTmlQ?=
 =?utf-8?B?UTBRQXVrcldSQ3AzMmV3RGZMY2RyRzRZQUFFL0VlOGxWS2RoMHNCVWxRalRF?=
 =?utf-8?B?ODFBZDREa2sxeFhNblBzMllVR1diNE40TzFNNGZHTUlHOWRFWjdOUXljaWZq?=
 =?utf-8?B?UGRpaWdYemozR2R5blZwaGxGTTNHQ3FSczhLTy84UExWcFpKNUUwVUMzTzlP?=
 =?utf-8?B?Q1lDaWlvV2lIMnNZcGRyRzZucGZtMTVPb3Y1ZlFJaUtoTVlFTXYzVE00ZW9G?=
 =?utf-8?B?WHhnS0NNS2p5eGRJM3lFZ0pUalpwSnhPcWRJZ3MyU2hFM1ZjRWtXMCt4SGVE?=
 =?utf-8?B?b2dzbjlvTmx3TkJJUXlNU2U5TlBTcGg1WHd3eXhYTTlDdGpGUTVWWHZqa1hY?=
 =?utf-8?Q?1EGiao9QMdnoEigXb7TrmntATCEvckYrKqNEhaD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3A1OUxUbjBKSnh5QW16N2tuNytJTWIwRTBrRnpmN2Vab1dLOU9JbTk2V1VS?=
 =?utf-8?B?WnRTK0grWHlTS2xUc1F4TzVROUtNeGVxNWRaOGVtSlozckhFU29lRnVXRnBN?=
 =?utf-8?B?NlJaQkFXRHFHelFoSThNU24zNVVxR2pQNUxwODlsTHVTUE5NY0pIVXZGSkVj?=
 =?utf-8?B?bjRpVFNjMU1taUhOenZPWHN2V2pVMnRnUS9xa0RKMHE2cVUrWkRGTG5KUFlR?=
 =?utf-8?B?SVZNVTNvelA2djllRFQwanNGbW9FVjlFSFM0MHlobDUzNUt2RndHOWdPVExB?=
 =?utf-8?B?c2dWeXRSaTU3eG0xQlgraGI3Q1FpYmVYUFFXbTUwMWtoVGF1NTc1czdYeXlU?=
 =?utf-8?B?WHhxMjFUUlJDSks0dlNDck5kYVR3alF6eXJDVDRnZ1NWb1AwQkNrZ1hvQVJR?=
 =?utf-8?B?T2xTUkdNcWhwNUxsNlJxakpNMEZhbk5Kb1Z1ZWtiTDhsOWNaSm9Nc25xSXVS?=
 =?utf-8?B?SmpRZ1Y1NjlMakRqYlBtSDNhWkpZYVNWWlo3U3RMUmR1TkpnMnhOa05STmlk?=
 =?utf-8?B?cWpZWmRYVWJOV09tN3Zhc1I2Sk92YWhnTnNzY0Ura3I5Wk5pbzNSaUxIQ01z?=
 =?utf-8?B?SisySldzSys0Rmt3OEZDNHVaNzEvLzRnVXA2Ti8rRmxOSXhUeEE1dmNoYTlO?=
 =?utf-8?B?b1o4eHJSeDVidHlNN3dFdWtuMVFxa1dIYVBuakd1VCtESm82Qm5oRHNjQklO?=
 =?utf-8?B?ZlhhUVo5bzVER1Q3OTg0d3ZUUWV3eUk3SGFNd2lweGprZGxzZUtCK0tRT2xV?=
 =?utf-8?B?ekNpQzh3SEFlNzNUQnhZYktVOFdrck5yUVdXNDEvRDVxSFlaS1lnYSsyQTF3?=
 =?utf-8?B?ZER5Q2x3eHpuTW9QUStHQXFOa1ZzYjYwYVppYllQNllIRHdTR3MrNDdHQVZ2?=
 =?utf-8?B?Um5OZWEvN25GdUIyZ3VqWlYyK1NLa2x1ZzRnUFh2bCsrRkpYcEtSY1N6dGVF?=
 =?utf-8?B?RnF4ajROL205cjN3T0hXN20zN2t6alF2empLYTU0aktMaThRR005aGd2VGsy?=
 =?utf-8?B?d0tWL3pPUTN3TDUwM085dWVrajJZL3k5QmVjUkFVUmpIVVFoOENVUEQ3MENv?=
 =?utf-8?B?Z0ZKUUpGTEtDbUlzaWVRVFNQcS9vZnlITzNhdUl2UkpsaVpvR3hia0NjOFRG?=
 =?utf-8?B?RjRURU1wUEEwbXF5Y0w4K0dPUFU2NVhMM1QxeDZuaEFxbmcyZUFmeWYvQ1I5?=
 =?utf-8?B?WjNTSVFISSsweWlJNjRrdFh5ZEFqOS9USjdIMlliTXowM3FOdVFMY3FTK0tW?=
 =?utf-8?B?ei9TNVJmY0M1RWVYV3lKWVFBV3ZwTk9NdGYzVjBieEZrNTVzZDRDb21KR1Vj?=
 =?utf-8?B?eEVnNnd6aDJXZWt1OUZnbW5tK2N2YjhTMWxmbW9lMlRVUEtYYWVkNThHcGxn?=
 =?utf-8?B?UmJ0dUJLWStrUDNMN2RZZEIySm0rMlJJdXFvb2Q0Q3djUndqTHE5ZkFpUngw?=
 =?utf-8?B?bnpUUjV1UHdKQzlOT0pNOEdQME9iVDZETHFPOEFkQ1J0V3RlZjh0TzFCUUcx?=
 =?utf-8?B?aExmMWUzbXhMU1RpYVhVdEt0dHZyeHdmcnNVYUpGaHZ4YzBETFFNTEo1T0s4?=
 =?utf-8?B?eWRtWDBEdXlIYTZScEtEUVkyRjRNTitNcmh6c1BubGRhWU9Rd2VKM0xzeDV3?=
 =?utf-8?B?cWFvQ0xqdS84dlkvMnA2MHFvY3VvT0k4Mk1kcWloY29QRTRYRnZLcWRsQnVI?=
 =?utf-8?B?eHdITXJjeHhtUGFwcFI0bnlKYmMzR1hOd1A5cGdGTFU2K1E2MnQyWDJKZFZR?=
 =?utf-8?B?dllYRUVsSEdqWUo4MHlLTThSSDc1S05OVkd3NUFqTWtaTWRabHpXWW1hOEZO?=
 =?utf-8?B?c1BzYVBEZWM1RThQZkRna3EwdGNtbDZCVm1SRE5xVi84MmRhVFdQOGlTYXVm?=
 =?utf-8?B?VGs1WXFkdk5Dd2U3amorclN2bTArcy83RXJoRExGT2g1N0dDZzEyZ0Y3OWMx?=
 =?utf-8?B?anhxT1dwTUN6UWJZWGVwaUYraHFBdHJZUEtsMWFFSDNrZ2tiY3Myc3Z0Tlhp?=
 =?utf-8?B?S0xiY245dkVjY09QalZLcWVvK2d2RWYrUWtpWW9GTG1hNkF2ZTBRSEtJRXZG?=
 =?utf-8?B?MTlVVDhOWnZTL2tRaGRyb0FTTmY0Z2lFSGRyN0ZDUG9pMFBISzJKQnErN0Qz?=
 =?utf-8?B?Q3hBWkRGNlRxZnVwb1JIY3RwWkUyY3dBMy82VUVwckR3T2VSb1lqZWErR2NY?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fk9CXrldtaVRS7p4bspw7NN7vcVnAqSqFZRua1jhFRX2GHSvf1XqKANJpgnWLp2DtqC8SBL3uFQAJWA5O/O+o27YX/WL8Drm6+/wkZYVXr7QgrXmODhVz4kBa/0qhCSkHsmkgFOpYe2RNJS1PiCcjl3q4rdVzIBlvcoUZ9rQ/YSFHCfO1Kgu6MKhtjoRm4vHPfUUgtbM/sBbv7AVlVlnX9sIjJno2rcmI+9bvSJvau5S0ipnb51nLuEQ9wheLCGDgtB96xC62wROl9lFsLSEH+s2ZzyksJpsygDdKZM3c2yrCxHcDJLWz54idVGTDApVNohDAG1PdWC7a102KDWDOTYusgxL+kQRfAZyts1ygaJNAnRl//bKHQ4zeubuiFq/dt/jC2YePnCvKcpHgM2WtrZexGqHhUaUKWbTR+OYOil1O6sFfxbTzfMwtUtqcKura9NDd195rpEFT2oobXpLk2DexGcIVPW8c8H++0e7Hk8X8s4CdPg0bD8f5GNSXaEWSRspbuJaZ6rusWGGVYEq7dUeE7snt65wPmnwLkZ6sMc7RXCUrrwGYMU60RAwGVk5kySAdJioJurPjulJ/jYRMZ0BFeXimfu/zJlbOMYj+J8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3dc96e-fe15-4f4d-bcd9-08dd08d95f10
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:33:05.4557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMX+0i9rNvZBaArzYgkUpSWZgbAPE76cnjbhcxl0upFAd1yjqqjbUspdeYOOUOyMrnvrBlYIqmUdNB0sBrMrqvGTl0CW9TCDK1M5c1V7XpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190151
X-Proofpoint-GUID: 7zslvdVoPAaoHsKhOwuyWIlHykfUer7c
X-Proofpoint-ORIG-GUID: 7zslvdVoPAaoHsKhOwuyWIlHykfUer7c
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

On 11/19/2024 3:16 PM, Peter Xu wrote:
> On Tue, Nov 19, 2024 at 02:50:40PM -0500, Steven Sistare wrote:
>> On 11/14/2024 2:04 PM, Peter Xu wrote:
>>> On Thu, Nov 14, 2024 at 01:36:00PM -0500, Steven Sistare wrote:
>>>> On 11/13/2024 4:58 PM, Peter Xu wrote:
>>>>> On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
>>>>>> Add the cpr-transfer migration mode.  Usage:
>>>>>>      qemu-system-$arch -machine anon-alloc=memfd ...
>>>>>>
>>>>>>      start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>>>>>
>>>>>>      Issue commands to old QEMU:
>>>>>>      migrate_set_parameter mode cpr-transfer
>>>>>>      migrate_set_parameter cpr-uri <uri-2>
>>>>>>      migrate -d <uri-1>
>>>>>
>>>>> QMP command "migrate" already allows taking MigrationChannel lists, cpr can
>>>>> be the 2nd supported channel besides "main".
>>>>>
>>>>> I apologize on only noticing this until now.. I wished the incoming side
>>>>> can do the same already (which also takes 'MigrationChannel') if monitors
>>>>> init can be moved earlier, and if precreate worked out.  If not, we should
>>>>> still consider doing that on source, because cpr-uri isn't usable on dest
>>>>> anyway.. so they need to be treated separately even now.
>>>>>
>>>>> Then after we make the monitor code run earlier in the future we could
>>>>> introduce that to incoming side too, obsoleting -cpr-uri there.
>>>>
>>>> I have already been shot down on precreate and monitors init, so we are
>>>> left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
>>>> on the incoming side.  That will confuse users, will require more implementation
>>>> and specification work than you perhaps realize to explain this to users,
>>>
>>> What is the specification work?  Can you elaborate?
>>>
>>>> and only gets us halfway to your desired end point of specifying everything
>>>> using channels.  I don't like that plan!
>>>>
>>>> If we ever get the ability to open the monitor early, then we can implement
>>>> a complete and clean solution using channels and declare the other options
>>>> obsolete.
>>>
>>> The sender side doesn't need to wait for destination side to be ready?
>>> Dest side isn't a reason to me on how we should make sender side work if
>>> they're totally separate anyway.  Dest requires -cpr-uri because we don't
>>> yet have a choice.
>>>
>>> Is the only concern about code changes?  I'm expecting this change is far
>>> less controversial comparing to many others in this series, even if I
>>> confess that may still contain some diff. They should hopefully be
>>> straightforward, unlike many of the changes elsewhere in the series.
>>>
>>> If you prefer not writting that patch, I am OK, and I can write one patch
>>> on top of your series after it lands if that is OK for you. I still want to
>>> have this there when release 10.0 if I didn't misunderstood anything, so
>>> I'll be able to remove cpr-uri directly in that patch too.
>>
>> I made the changes:
>>    * implementation
>>    * documentation in CPR.rst and QAPI
>>    * convert sample code in CPR.rst, commit messages, and cover letter to QMP,
>>      because a channel cannot be specified using HMP.
> 
> Yeah we can leave HMP as of now; it can easily be added on top with
> existing helpers like migrate_uri_parse().

This begs the question, should we allow channels to be specified in hmp migrate
commands and for -incoming, in a very simple way?  Like with a prefix naming
the channel.  And eliminate the -cpr-uri argument. Examples:

(qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock

qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
qemu -incoming main:defer,cpr:unix:cpr.sock

- Steve

>>    * migration tests
>>
>> New CPR.rst:
>>
>> -------------------
>>    ...
>>    This mode requires a second migration channel named "cpr" in the
>>    channel arguments on the outgoing side.  The channel must be a type,
>>    such as unix socket, that supports SCM_RIGHTS.  However, the cpr
>>    channel cannot be added to the list of channels for a migrate-incoming
>>    command, because it must be read before new QEMU opens a monitor.
>>    Instead, the user passes the equivalent URI for the channel as part of
>>    the ``cpr-uri`` command-line argument to new QEMU.
>>    ...
>>
>>    Outgoing:                             Incoming:
>>
>>    # qemu-kvm -qmp stdio
>>    -object memory-backend-file,id=ram0,size=4G,
>>    mem-path=/dev/shm/ram0,share=on -m 4G
>>    -machine aux-ram-share=on
>>    ...
>>                                          # qemu-kvm -monitor stdio
>>                                          -incoming tcp:0:44444
>>                                          -cpr-uri unix:cpr.sock
>>                                          ...
>>    {"execute":"qmp_capabilities"}
>>
>>    {"execute": "query-status"}
>>    {"return": {"status": "running",
>>                "running": true}}
>>
>>    {"execute":"migrate-set-parameters",
>>     "arguments":{"mode":"cpr-transfer"}}
>>
>>    {"execute": "migrate", "arguments": { "channels": [
>>      {"channel-type": "main",
>>       "addr": { "transport": "socket", "type": "inet",
>>                 "host": "0", "port": "44444" }},
>>      {"channel-type": "cpr",
>>       "addr": { "transport": "socket", "type": "unix",
>>                 "path": "cpr.sock" }}]}}
>>
>>                                          QEMU 9.2.50 monitor
>>                                          (qemu) info status
>>                                          VM status: running
>>
>>    {"execute": "query-status"}
>>    {"return": {"status": "postmigrate",
>>                "running": false}}
>> -------------------
> 
> Thank you, Steve!
> 


