Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62833C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 23:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHW4t-0007Lk-3w; Tue, 20 May 2025 19:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uHW4o-0007L3-3s; Tue, 20 May 2025 19:08:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uHW4l-0004bG-QG; Tue, 20 May 2025 19:08:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KMvV15025011;
 Tue, 20 May 2025 23:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qEkLorkMIIkEJHR3yfggebszv8ToXfcLqDqxOTm1LCw=; b=
 ibzMVgZW43v3Pvsre+xL+2RhMphXXJlsM5X+c67pIm9izsciVeqkzrUcSByyxBcx
 uPLgH/OX0DFgQLxbDRvtGkKT1VBk0ydIHNgvM/sP/Kx/qSnM9t9a1ZyAGeYXzqEV
 jnIoM0c/E4UKwXRU+pzWViq/NEA1whf2hF9uykK9UZR3Ly5OhsOMKfQikkrHUOmB
 pzgYUBYZ+HpDBFN4+iQqVLv3E5yft0Crh5KsfBT0Qk7zPvJQo/oveXlitX+1bxxw
 HSUkd537vVxyMZHc9QQpgCAfSiGQ9p7Iq9lua5L0LNbFERXDpGKibvDp8Zi7Ds2u
 sCocxO0tH3DBW80Q0R+5bA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s2yx00st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 23:08:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KM2sHx023787; Tue, 20 May 2025 23:08:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwekndwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 23:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol2ResPT/YfzVKsig04Op4wmfdA8mI2n89TbYWiEtqnlHxSX2/2gywhEeYKA2sAlv5APCdXA8p6Trk6P4Fw7aSh9xlHUWpnWqvVfIosX4UKR/oIyYpbqrCuSk/7MS2cYeiFPzxEyLMyngsARCwTYXzMpVurP1SIwULRxFdlDbFYr1AQKt2KEs4LlwQiwpT9Lac/aaxw8wfTbuYAvH+UB9+s7cHIkjw97FU3tE7SefsZ4FuR6MUE/iarZrDSUZS+R7vVBv2m4ZaxKBxwpepoc4byxrQPz6/r8GaeNTHiBfdXwpXjdmqaEjR22dLcvV6MH3PxMnbRdwOUF1N+Qk5hTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEkLorkMIIkEJHR3yfggebszv8ToXfcLqDqxOTm1LCw=;
 b=pHMQFr6QruZ/6DUxGrwy6GDhQ9FyD1/FORialhsaoHiPSiQ7cIE9RUkKCb0Cs2LBHr7nSqOoNLetIvHG6XgWTWcWuBPPl9nZg7MwZPC5H8lP7iuxQVmVAgWOAKrifFSCfJ8YhHnEn19JynO5VM8nO8QarF0pCTsJSXGFbza7mckRDBcBSrZd0v3BzR5ncwVlDfkEDiVEJMReGSaXwKpBkFk5zw0bm4IVnlIPU4w+Pud6HQRESMCGuItWInx8Lm+D813Dr2s1ewSIoDojYBXLq/pNcpzOgaNoPpITsu+BGy+R2xnBkd4VbuwLRib57iwmw6g3J2VTfrEXF3ave6PfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEkLorkMIIkEJHR3yfggebszv8ToXfcLqDqxOTm1LCw=;
 b=nYVMA8ZpYFiLKLSmICtBOUUKULqP0RPASnRLlTYNJrHzYI6+O0zdOOZyqVT1/iURcIbOhA42dfLM0sBzW6yiM0XmvbFZNAlAaXI8vURcWUi+vn0TGkMqg5/n502iJ3C+qdMaGTC7Ek0TeTF82qOlCJHaUe7TL748uCyDYK8jp/U=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 23:08:13 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8699.026; Tue, 20 May 2025
 23:08:13 +0000
Message-ID: <e9ef0efc-b1f4-416f-b7c5-ff172513d05b@oracle.com>
Date: Tue, 20 May 2025 16:08:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hw/nvme: CMIC.MCTRS should be set automatically
 for multi-controller subsystems or by parameter
To: qemu-block@nongnu.org, its@irrelevant.dk
Cc: foss@defmacro.it, kbusch@kernel.org, qemu-devel@nongnu.org
References: <20250501184505.3630283-1-alan.adamson@oracle.com>
 <20250501184505.3630283-2-alan.adamson@oracle.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250501184505.3630283-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::36) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: c14644c2-bf83-4436-bcfe-08dd97f33233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDRkWFo2ZE9Ia3BEMjJRWmNTZGZnMllVM0UvY1h5ektRSVY1NGtkNmZmYjJY?=
 =?utf-8?B?UE5uN1djOGJpK3psVjNESXE3SmNUTk9ZTG8vc2RHOEEvb2twODZKZHdPM2RJ?=
 =?utf-8?B?VFRpNnpLOHA1UWNQSFZPWjVFNlFLbXh5cE8raTFxNHo3VExTQklGVmQyei9j?=
 =?utf-8?B?MEYrbFpOUGJWNHQ4d3AxT1BTQUp2ckRyZGhLTi9jdDB4U2JCWnV4MmxFQm1a?=
 =?utf-8?B?K3loNk1oQUtZRUxLNDlRbXJSWjNzK2J5MS9UbUVrOFFCZWNOWDhHMElWaFFr?=
 =?utf-8?B?a25oR0VMa21lYzVhdENha0Vmd0JvV0h4OXpwdElNSDE3bVRJeE01SVdnbTN0?=
 =?utf-8?B?ZUN4cWZOYUpKWms4SFcwa3BHNzRmanRibjF6WWtTWXR0RUY0enFpZFJjbzJK?=
 =?utf-8?B?RGlMZjJKNnY4TGllNmo1dVVRUlNMOWdYRU1IZFF1SnhTVS9BaTNzYnBPNzIx?=
 =?utf-8?B?dG1jYWN5N0dBek9XMGtrbDJPVFNBUWE2SjhlUlQrZEgrTm0vR2M2QzkxeW9D?=
 =?utf-8?B?S0xXMkgxVFg4ZmcyMDNkSCt2a0lWRGlKQkhFK1IrbXJRMVcxZkQ0aEIvWVEv?=
 =?utf-8?B?a0RkajVFTVBmemtMSkl3Q201OVpWbmp0ZE1YSTVRUDc2TkFPcVhqYkZWTEFL?=
 =?utf-8?B?UklRbytZa1kvejVBeTF2UThjdGo5SU1vMnpnQnpkYVhicmg4SHBzYW84UnZ5?=
 =?utf-8?B?MlRqL0tKdkdlWVhmbm5sWE43cFZGdGhCZXFvak1JQjArR2pPbG12L01yb3U0?=
 =?utf-8?B?T0krY3g0bEdYeFh3Wnp6b05NbG5CVitGb1ROdzFrM25LY0QzcmtQVzRnaE1M?=
 =?utf-8?B?VTVDaThMcXllTE0xWmlrYmF0NTQvNUU2MEt3NEptUVFKN2Z6TkpXcmU1V3dD?=
 =?utf-8?B?MDF1b1ZTTFEzNjVacUhQNlpqc3M5WG4xbnZBbVN4TDgrcS9tVUJDMTE4N2k4?=
 =?utf-8?B?TFE2RWtyMThHSTdnVWZ5enN4dC9sYzM0U0NIbE5YTXBZWmU3U2tnTndlZVlX?=
 =?utf-8?B?VXJuZnN5S215d1AzQlR6STk4WFRrKzMzTkhxNWIyTHV0MUMxbEw0L1dySjU1?=
 =?utf-8?B?b1BoU2ZXdGxSTFF3djJnSWU4WWJPTEQ3T3pma2RWbkxwVzBSN1FtcU9KbVVM?=
 =?utf-8?B?ZUpqNTJLenFCUk0rWXdoTmpOcDdpeVJ0QytsUzgyd2g1T09DT2NzMXNSdXVG?=
 =?utf-8?B?NEh5aEFnaGlKaDVLS3M0YzJLRGd3c1lvWTQveGIwbDRwYlh5VExxY3ZoR0ta?=
 =?utf-8?B?OGZBUnAyR2JyRWlGalhEeitjaml2RTZyUHZKck9iRWk4WkNKeXk5OWxVajgr?=
 =?utf-8?B?OFNnRnRoOEo1RzVNWGFaaWM4dG9vQmprcUdQVmZ2ME00VnlOdjBoaldJU2Vh?=
 =?utf-8?B?N05GbWVOS2NPVk4rZkFFdk9HdlJIdDNnMTBwZHFIRCt4MWVIekxsbHJpK2tz?=
 =?utf-8?B?NXh3dnhVVUVIMFVNQ1IxMDEwM2krQ003QzZyMzVqSkdaZXIrQU5rN1YySUpG?=
 =?utf-8?B?T2xxNkttdlE1bGk2L1c0a2d1WEpFMjVQM2x0c0RyejFnWjkwY0hSWUMvL21I?=
 =?utf-8?B?R092MTFiZjd0ay9aaGkrYldiWGo4RDVzMEkvaUFpSTh6eWVTM2NTeFpRWFNS?=
 =?utf-8?B?UjhwNlRhemZMejNoSms3SWV4WWZTVCtJc3NEK3REampZQnVTcTFMYnAxZzgx?=
 =?utf-8?B?a2RqTXlGd0NJMk10MjJXaHA0ZzdNVEtGV0hqV3V5TDdMc2VTaHYrS0M5dS90?=
 =?utf-8?B?eVN2UzIzZTk5RVNyRzBONTk5cGxqeEIxeVM5MTk0azZEV213dDAvVlpidUpq?=
 =?utf-8?B?R0VkWFZrREtHT1I5blNIWFYxdUdEZ0NaYncvMDBIT2lDckthWkhHQ0JQbE1m?=
 =?utf-8?B?QStWeEtLODBiRldUVmFSWXhXR2RweUcyYSs0eHBSRVI1YnI2SzJCcDhxUE1E?=
 =?utf-8?Q?hicZOeFucD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhqUTFtTmpvMS9MMFZjUythTkFWYkFYZ1ptMmtLU2ZIVGZBNDNiS2NyS1dw?=
 =?utf-8?B?RkVmNnFTemFQWGxwaS8xY2FzUHA4RWRBWHQrSXczK3p3U09XWG9PSlJEdEVJ?=
 =?utf-8?B?SDZBU0orZlp4bnZ2b0lLaU5OYlN1V0Vqd3p0V3lVVkRISlZwelZpWWhGTm1t?=
 =?utf-8?B?Y2pqMnR1bW1EUEsybGp5QWQyYUt5cnVBbTF1UXEwWG5rVVRjVjhTN3Q4OUNh?=
 =?utf-8?B?NXU5ZUpKREZ5KzlQa1dheTd3UldZcVgvZGoxZGxCdlY0OHpxYmpSSmZZaFlN?=
 =?utf-8?B?MUFKbWo3cWdLMThkemdvQjFKS1ZxajAreDBXeDZ4Wlg0SDczUkVycm1rMnVy?=
 =?utf-8?B?dWpjUERSL1hNUysxZDBkVERETmFVZjFVeW5BalNvRFJpZGhJWGFldWpKMXJy?=
 =?utf-8?B?a2tpNlpqdTYremFLbTdpNktORkRKUmRQQnRrU3FjeE9IVFBaczZETEEvWVNa?=
 =?utf-8?B?MHdId0o5MVFYUEVjTnl6MzVWS1dRbE9JS3M4Y2ZBTDRWcTNGQlZnZXN0NzBJ?=
 =?utf-8?B?bDhhNHkvenJiRld6T0ZpWVpvTFRQWWh5em1kQVdBaTlkZ2NFZDZGMklLWFov?=
 =?utf-8?B?Q21xR0dHNFJqTUxrTVYwUVBVUlUrd1Uyd1RYZ2Z0SDhFb3NQRlRTblBiRjBj?=
 =?utf-8?B?WGdUYk5GRE5TUjBOZTVqRkNObnVQWVNGNTBvQ1p3SEFCM0cvRmJqdHEwUko4?=
 =?utf-8?B?QktGa3NQWTJMUWF5T0VrYjkxeEIxbytORWhWNS9XYlpnTTU0QlJFbjdMWktk?=
 =?utf-8?B?NTVHRDE4bjRXbTFad2FaNWxMUi94d1FVYTVVTlNycTA4dWd2T0dJUldFdi95?=
 =?utf-8?B?TTBBdm5BeWY2OGVKTjlLVUozUGlpUFpyemtMbzZIL0JjdWlyNlBPS3Vhb0xG?=
 =?utf-8?B?TDg0ZVMrMkdycmVPaFlKcUJSK3VsaDAwUkFYTk15NkNQZUVLL0l6eGNxM0lP?=
 =?utf-8?B?N21vanlSUDlIVkRGaTFkZzVGakM4dHlMR1Zwcy9Ra3owUjgvZWpuWHdsdXdw?=
 =?utf-8?B?aC9ESU02SmxyM3ZtYW1ySk9VdjlTb2J1MmdWc0ZWaS8zN1dGOCs0c3RNd2RY?=
 =?utf-8?B?a2Y4U3dFd2NiWUpEZTZGc0NCL3JTaUJWVHBNUFozU3ZwYnF5elhRMiswMktN?=
 =?utf-8?B?WklYWEplanBrTUw3QU85aGhRRGp6b1NCcTlUQ3lhMHlxMXVDRG0ycnQrRS9E?=
 =?utf-8?B?V0o5OGUyT052UXJ2NXVuN3ROUEFoczVYbDltRkQrRWJsVkpZNGZ4Q1I0L3R0?=
 =?utf-8?B?c3cyaDdRc1FrUGd1WUNoYjRoQzZ6UEZoZjBVNC9kSFdMc2k0OFI1MzRCUGdp?=
 =?utf-8?B?all6Zkh4YzBJa3ltempsOW5Da25wb3dra3ZUaTduRHN3ZHNFOXVzaDBiRFVr?=
 =?utf-8?B?YnhQcWhmSmZQTWNuR0RncVREU0pDZW5mV3I1YWdQOS9sY1F0UW5yRFVaNUNM?=
 =?utf-8?B?YWVNQ29pa3lXSXNreSt4allhZUMxeHdZN0VRcjh5SXVPU1ppQmlrK0NqOWl1?=
 =?utf-8?B?MytEU2ZjYTVMalVEUVAyUEJ1dDBVcVlPVUYyZjllNndNY1dHbmtSbnhSR3Jm?=
 =?utf-8?B?WkJSc3FaakYxdUNhNTc5a0VLRFFMWUxWNkZnYmZGMGZDYko4a0JRSlhxR1NS?=
 =?utf-8?B?WVlZaU9nbk9FQmNyMm5YVHdXamc3REhiNHUwYkFjby9DaDk4cUtOSUJGaVJn?=
 =?utf-8?B?aFBWUGVWV1pYODhYd1puZE9ZUnBKWHFSQ0FQNEpFTGpDY1pUdWx0bTBEdTBs?=
 =?utf-8?B?M3AyNU1adVRJUWxPNkVzU0hyMWpScjR0UjZQcDJ3VUJUMGJSRzFSV2RvZmpX?=
 =?utf-8?B?eWVQaGZ4amxmQm9GME9YaFRwSnJFd0JUMjhwMVNTcElIdVVOTmZ6TWVJNnly?=
 =?utf-8?B?Nk9zWjREZkpKTlpQUVF3dzI3d0R4dXhoS2wwNFo5QXR1Y2xkcHpEMjhJek5m?=
 =?utf-8?B?NjlMRmxPdVNCOFl6dEQ3dFpNOFZ6RjVYVzVNNTBWYUdqbElkTTF6TG1qTVl3?=
 =?utf-8?B?aG8xZklCOGVHSk1iY3BwVnJKemtrRTFEbTZwQ3lHUkNHZHRzWVNDYVdERzhl?=
 =?utf-8?B?eXlpRWQwT2ZWc1B6b3U3Mjc2aTFWb2QxMkIyNXdMclBiNnFNVnEvL1l3azZw?=
 =?utf-8?Q?/eaTQ8NXlSaurkcjsp/omMDi0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y0xU1meUz5CA5rHmIGZ0uQtHxcI0pPChbmxtovWt0WvQktzYH+L7JcP1h8mQqBTA60Cl6uBDadBhxiKX2zL3JH3X8G+u6Dv7ZlyrePVLi+k2fQ+TL/qLPxiSnhxINL7KK/ZxFNC6648DICaAaaaXqETMzx4HcKDGSri+6yi3EFnZNoEQQTLZri9uIzF3Tkl4R4kxnmLjc4l2Ej2PsK4OHlhixVnaE8gDSS6IvG6I7eUsNIbUDOQX5o8kSdmW56+QOsO7SfhQX8eLLAHQ0XNWDc9ZeH55HiW8Sgj7dLSMGxtOUzPHgPeWJF/cyWTn3FWCzzaNPZAsAF9JMVDqyJi8hLqm68MHMcX6lbA0lpn+b50Mg2Zxkd5bDD2JraUtNowJ6+wK6Bnkf/P+7heQzkZOYOw4UMQ70TGTCz43g4E/6LEkSZsJkjEdvsJJNcjj1hP/lalt8bMmNvfBpMvTDZxFoL9GR2d1eWG9yQcdrCaHPeeh+QUChXkgDGMR7h+OazNH1vweGu7c6+z4WvQQHVt9HYocmf6RhTntXWO3y/Axfl6cyeeiFPZPFrA4gcLg3jNFXzn4qKLbWixPOZvBXKo5xJPIyXMptmRV0FDArnlZPzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14644c2-bf83-4436-bcfe-08dd97f33233
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 23:08:13.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwSoYh4m4p5J8bMuk7xalEbohxrm3uxpmFnAGVq7APCtcWUtFDxXsmPXKL1Y6q/jwPSBDPeBZmak575c9ydgNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_10,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200188
X-Authority-Analysis: v=2.4 cv=DpBW+H/+ c=1 sm=1 tr=0 ts=682d0b70 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=j-VERsXHdBY4i-CFgSwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -eDw_s82sUiy8RlI7Uq-bgn03GZs6D90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE4NyBTYWx0ZWRfX+yi1Ncyw5CTs
 OywFEc6Xm/jsksWBUeeeDTxzJ19+2c/6c3SF3aOER0jK3Z/OFyeaYHLYL1YSStSJuwO6InfWUPW
 Wj/xglOyCoBG4yUQCAVNayh/gK7ABMA5aDXQ1N2+apEVGYAz+nzdew8BBiyvmToy6uvruJ2MWsg
 LYrRkDXUm+gn0M6cnNITADfc4mZ0BA6DAoSdpAbvhikUQAGO1Qs9Esn03KJGF84F0QJZgVrenht
 uhESLkNCEgKOq8FdngDuBKwYdkA9sf1USSnl3U71SSkXLnWyTj5H2ZENvSb5UjbPOhOqu1hYnAo
 8OJtJIJMNp1/OE07ckNY7jwp8WTGYcwLXHjWpYFLbAWjmIEDhCwavqfyPqLINjI6/O9/WVexXDq
 Ww2sQXcHgnT4hOulWb41R0U9pSk4UXRYGysk8EncebpA78zJRLFA05IwrW08z6bpmhJChAqM
X-Proofpoint-ORIG-GUID: -eDw_s82sUiy8RlI7Uq-bgn03GZs6D90
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Reposting.


Alan

On 5/1/25 11:45 AM, Alan Adamson wrote:
> If there are multiple controllers in a subsystem, CMIC.MCTRS should be set to on
> for all controllers. For single controller subsystems, CMIC.MCTRS will be off by
> default. A new subsystem specific parameter will allow setting CMIC.MCTRS for
> single controller subsystems.
>
> New NVMe Subsystem QEMU Parameter (See NVMe Specification for details):
>      <subsystem>,cmic-mctrs=BOOLEAN (default: off)
>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>   hw/nvme/ctrl.c   | 15 ++++++++++++++-
>   hw/nvme/nvme.h   |  2 ++
>   hw/nvme/subsys.c |  1 +
>   3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index fd935507bc02..72e45f3a7f78 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8880,7 +8880,20 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>       id->psd[0].enlat = cpu_to_le32(0x10);
>       id->psd[0].exlat = cpu_to_le32(0x4);
>   
> -    id->cmic |= NVME_CMIC_MULTI_CTRL;
> +    n->subsys->total_ctrls++;
> +
> +    /* Check if there are more than 2 controllers or cmic.mctrs is enabled */
> +    if (n->subsys->params.cmic_mctrs || (n->subsys->total_ctrls > 2)) {
> +        id->cmic |= NVME_CMIC_MULTI_CTRL;
> +    } else if (n->subsys->total_ctrls == 2) {
> +        /*
> +         * When the 2nd controller on this subsys is inited, CMIC.MCTRS
> +         * needs to be set. Also need to go back and set CMIC.MCTRS
> +         * on the first controller.
> +         */
> +        id->cmic |= NVME_CMIC_MULTI_CTRL;
> +        n->subsys->ctrls[0]->id_ctrl.cmic |= NVME_CMIC_MULTI_CTRL;
> +    }
>       ctratt |= NVME_CTRATT_ENDGRPS;
>   
>       id->endgidmax = cpu_to_le16(0x1);
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index b5c9378ea4e5..061e7046550b 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -116,7 +116,9 @@ typedef struct NvmeSubsystem {
>               uint16_t nruh;
>               uint32_t nrg;
>           } fdp;
> +        bool         cmic_mctrs;
>       } params;
> +    uint8_t          total_ctrls;
>   } NvmeSubsystem;
>   
>   int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp);
> diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
> index 38271d78c8bd..c644fdf0be5e 100644
> --- a/hw/nvme/subsys.c
> +++ b/hw/nvme/subsys.c
> @@ -216,6 +216,7 @@ static const Property nvme_subsystem_props[] = {
>                        NVME_DEFAULT_RU_SIZE),
>       DEFINE_PROP_UINT32("fdp.nrg", NvmeSubsystem, params.fdp.nrg, 1),
>       DEFINE_PROP_UINT16("fdp.nruh", NvmeSubsystem, params.fdp.nruh, 0),
> +    DEFINE_PROP_BOOL("cmic.mctrs", NvmeSubsystem, params.cmic_mctrs, false),
>   };
>   
>   static void nvme_subsys_class_init(ObjectClass *oc, const void *data)

