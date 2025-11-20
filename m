Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AD6CF58D1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLtbf-0004Hk-UK; Wed, 19 Nov 2025 20:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vLtbd-0004HL-Jw
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:37:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vLtbb-0003De-3B
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:37:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK1NbAC013300;
 Thu, 20 Nov 2025 01:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rBPLFZ1MBNigDootXIZf3Zm7nM7M1VuLSjZANwiX5MI=; b=
 kdGrlra62Fu1f+sP+8KqMLZ21GfFTPBWlDYHSy79tkAq5CRgvlfhPX9XFoT5zq3u
 /3F14HmlBZQvBH7j1vwA4Cf6Vz5L7sh2Pdf1wjiB3uU5Ji/+gNGq19XWmU7zR9B9
 X+75uBTPkliMvcVHTJ0uJOBc8tOemSQaDx91aDYqnCtOueQ5paRLTq+O1tdvyChD
 OVCsjRuRWGroTBxAwebONtKA4pMoZoQXQTLWEUlD05Bb5FBnWHG3vBJFF112x0il
 qFE1L6GJZHJ/ewqVLZV/EJsRpcii+ZDQ93KWGS219lnt2gOUv2NJYHalnZKd/KTF
 c+xtQR1qbhWyVPK4uaxE0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbur5b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Nov 2025 01:36:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AK0rifx004524; Thu, 20 Nov 2025 01:36:54 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4aefyb57w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Nov 2025 01:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYZE5GJj37JCLo2DWmnZcj0rVtwsUM19uv291i+pdaZgSGV1g+cg/HryfzfziHmN05Do9dv+TmCl2DUzY3W5MOIbwCQfKMcirzj20fWtEsO77mgvO1hbtiAO5CRR4thK0ohD0PLZ7+n1w+fBGglLS1Z8LQZfFbIpIOxorNqXMxEl1xwkLIfmgiZclqtsNyKKEDPgZ0lOf7oUA6el5rm5dZsrKZtE3JpZubsOKBiZApzyR35keYGUNGXQrd5jDYc2Wh08A1W3U7ILkbtriBRBvrs2eMfw7uSNfKl2e3hiBMS2GwdxPXejW2pXUKM2zOCiYQZW288t/SQBRAsEgmBEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBPLFZ1MBNigDootXIZf3Zm7nM7M1VuLSjZANwiX5MI=;
 b=KdrdQM5n83d8yLBia9tpyYTjWx2JB95TBb4mQsY8KCzDcZxBf6msEMQj+DAaipASwIq6bZ1N48uVCpZxaQdcoErs7ysPV+MRJLUQutAkHF7Ir4UId12056j2vhLOKT2NwWj1nMSrNT1yHRJaxlEVBtkp4jvMIbAvysfgiL7hcaJUfY5XJrS6/bQjM27vZtH/wbtiAfhhS/9CNwZyA+HAO75tc9KOlVnebrROvz6xLYT/T2LvGXfqVcN/45GRiZlPEKjCDKJgsvoYY98i0J3OaFXU9rXcW/ZOUKjaeWVTKmOM0HESvSzrgmSlBCJzDp0IfI2Y1YjeRhQrN6vB3oDgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBPLFZ1MBNigDootXIZf3Zm7nM7M1VuLSjZANwiX5MI=;
 b=DgKcXs/z7fk0g3R12+o7WpRMKzpeFTp9ijvxyZHD1ehsOvTYA4c+7a4o4/TdgGqOtgiiy3pxV8Bkh+X2w7bUvL2qGmOCOplQyZGTUJCRkB93lzDpVaI1rQt/JtaOn6C//D6SugAJNXTMsBdDCAsV7KRCHlf7KdEuvS3u9XzeGVM=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH4PR10MB8171.namprd10.prod.outlook.com (2603:10b6:610:242::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 01:36:51 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 01:36:51 +0000
Message-ID: <eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com>
Date: Wed, 19 Nov 2025 20:36:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd_iommu: Use switch case to determine mmio register
 name
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-2-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251118082403.3455-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::14) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH4PR10MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf7fadc-9357-4b68-b2e7-08de27d5474c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cndjSTMrQ2VCYUx1dXJmclh1NTNEdmJKNkY0TDZoREhyZlN2UVp3L3JYUmd5?=
 =?utf-8?B?T2owSWdHM3NBMnhvc0pEMTRITTF5N1p1ZXpCcWsrYjBvTlBPTkVGcDYzakdh?=
 =?utf-8?B?TkoyT3FyU1RCTFpVcDIyUEpnVWpTTmlxaWJhNjBuRFV6bTZpWlRrRUJ5eG1v?=
 =?utf-8?B?MTdrMDBva0JDTG1WdEMwcVp0cVNjWTRVVDVORnNPd1JSSVNtWjRDUzVRY3ll?=
 =?utf-8?B?RkVwNlMyamFob1JBRkhBTDVMWjJqZjROamhZTFJNa1NqSkdyelNXTGFaVDFD?=
 =?utf-8?B?Q2VUMEJzN3BKK2ovV2srYkwza255MWpZN0ZvaCtxVEdPUlBVNERkTUR4TGJK?=
 =?utf-8?B?V2pnR3VFY0pDU1R2QlIrUE15UmkzVWh1RStYaG1wSGhBNHNiZ3MxbityNUdL?=
 =?utf-8?B?alBRRko0bDV2VkIvQ3NMQkZ4UitwOUVHMEFNZ3o1bWJ3b0R1R3hENkpmZHhH?=
 =?utf-8?B?QmVzQ0xJL3lFWGc1R05FZEVBQ1hCd1pVRzljU3JqMGsxUllNdnRFbHptYjUv?=
 =?utf-8?B?WXJqdENrRkg5SmJxMnAvK2tSQ25rTmRiM2ozQXQwSDREUy8yVXRMMHRmcEJU?=
 =?utf-8?B?UGJhY21zZS9MazFVN2lEVU9vNFVIb3FoVUdXQXd0cVpuTlRlazF5em5sQVQy?=
 =?utf-8?B?RUl3L1Q3bG5yMTJCRmZDSW9kVnpiNHJPMHpGa2NreloyRUxtcGZSV3c2TjFq?=
 =?utf-8?B?eGJPMm9id3A0VTlRZTIrdGVsQUpmUDVOVDBIc0tGRVl4WDdzWVdZa21POXJz?=
 =?utf-8?B?Q1lybVdmTDhFVEM3cjZaRFozSFdvS3Z1V0V1YVhva1E0cFNJcGZXQy9DRDdv?=
 =?utf-8?B?K1hvSU53MW5CVTk2RkEwalRPYng4a3pqcG9jNWk1Wk5ock9wQU9SYms2NWc2?=
 =?utf-8?B?MFAwLzlEYkFKUGp1OWN0eExKTUhvVWg1QjZNa2lBMDlNTVUzUVUzM2ZlUTQw?=
 =?utf-8?B?R2YvWFVNSnhyRHMxOUtFWGhpM1RNQ3lHZmtJUEg4ZnV2N1VoOUU3SXVGbDU5?=
 =?utf-8?B?QUNmR3FwRWd4dVJsQU1LK2xHeElFNGVEV3QzSUQ5YnhiRUpRQklWZm9MaUda?=
 =?utf-8?B?OGsvbDgwczVDZGl1aENjU0JVd2ExUWxFVllFbDN5akRTOEtNQk15YU9wOHVL?=
 =?utf-8?B?eENFUklndmZ2MitybHV3R3lLZDcvdjNZUENHNXhKQStvMjdtMjdhMGt5NWRa?=
 =?utf-8?B?azZEeFdCOXJVd2NwS2ovZlFFR1A2YVZTbEswcTBoMmNJUHEzWUgwQlhCaTJq?=
 =?utf-8?B?VjY5U2lSb1NYLzNMRjRxbzVoWFZvamdwZjIrTFlaSWhPSzJBNC81cFZ1eXlP?=
 =?utf-8?B?TCt0a3JJSXIwYndYT2U3ZVgxNEZWYVQ3Vm9qQ1AwdVNxcjhzWVFrUHk2N2Uy?=
 =?utf-8?B?ZHoxUkpLN2NRTThkZjhOUVVEVDFwV05GSkd1MG5CQUlMSHp5S1V1TjVKTnI0?=
 =?utf-8?B?aXRMa0lkTDlqandLNk0xTHY5Z3RaK016K1RKUVJCRWNVYUJYc004VDZiWGIz?=
 =?utf-8?B?ckxSMURvYlhLSjI1SnZhTWZTa1B3OE9XcmhiUW91ZExucjNTU282WHFkN2N5?=
 =?utf-8?B?YllQbVl2aEFJa1FrVXNTSkVrNVIycTF1RzdmRk1DcFpMM0c2aDFMeEpwbmF2?=
 =?utf-8?B?alA1OHF5VVNuTUk4Y0pXZVhteExWZmQrKzFWMTVvdkVsOElKellJSFo4UGdQ?=
 =?utf-8?B?QXcxQnRMa1RKZStOYWptN20vbjd6YWtsVUM1cHJGV1Nrb0Q0WXJRMU1CZ2Mz?=
 =?utf-8?B?QWdnQ0dzQklvTmVIUmdHN1NxbFordk8wajhGRXpIR0FucUozZXlvbXk1MEdB?=
 =?utf-8?B?K3JPZStoYXI0RDlvcUlTMThxMDV1MHZpTHR5bEQ0bzFuK2dUd0J2OUFmd2Er?=
 =?utf-8?B?SEFmazBxdGFjUHpvdFRRcTdMY292OHd2ODIxSVlaOXc2R1ozWVNmakpGT29H?=
 =?utf-8?Q?WGtzd9OlJ1SJigFVX4bs4uvdZcru3dhw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K00rN3p3V0RUNmpabE5RYjlKSWx2MjFKK3Zma0FoZzcrenRUQStoMXN1WXdI?=
 =?utf-8?B?ZHBZMW01SjJGc1VySHRrbjNWWmQxbG02RXJoWlBBaytJVktpa2o5MURLdUsz?=
 =?utf-8?B?ZWlEYXByQWxwZGIwS1I5MzAzaDltZXpRT3JNUTdZWTBuUkVMMkp5MXFmNzZu?=
 =?utf-8?B?dDJRSXNhMGQ4OURyNlJrTWlYdTZLSU1sZ3NsSHNUWDVyRlJYZWlZWlhOc0NW?=
 =?utf-8?B?ZnBsakJtZllYekhkN1ZldnlEWVBGTm1hS3Z5NTRvOERQZ3RVQzlja2JIVU5k?=
 =?utf-8?B?Z0x2SEpwdFJaMWZnMWNjb09nZlJ6ZFB3aUgxMy92bmMwb1UxR0FYVmxxVVZ1?=
 =?utf-8?B?dFJIWDgxd3Y2dWtTd2VnMmZ2b0pWTHJTTjR2YjhpNVR5QXBuT09rbWw4d1NT?=
 =?utf-8?B?UE14MVpEZ0Q5d0ZrQWFUcnUweXBZcm1kdEEyUmhCMDBSVEVLQlJscVg3ZjM0?=
 =?utf-8?B?MC8rMGRWY0c4QUZ3NHFESjdMaUlrV2FGWFYvSG9wd2wyZ1h1bVZFazFpREdN?=
 =?utf-8?B?NHF0QVFleC9YazdMNDRCazFZcWg1ZE9nRGZJbWFZRFFRU3ZRYzNmL2djanRZ?=
 =?utf-8?B?azl4Zm85V0hkU2JNcWZQOXY0a3VBb3hRVmRZdE1tdUw0OU9WcmpXamgvaU0z?=
 =?utf-8?B?VFUvVXVsMmtkRWFWcG1kSlhRVWpJZnVrRmxTVlZOMFhkVGtETktMQUhxTE5h?=
 =?utf-8?B?dmJ0MWRKRVFldzZ6WjFrZ2Z6UEEzSnNEUjNEYkdlaEpKVGVTN290ZUZsS29R?=
 =?utf-8?B?bzRCUjZxL2g4ZjhUbzhZbUcvaGsvT09DcmYyejZtOG51bVFxUFAzNnhQM3JO?=
 =?utf-8?B?QlMvRkNqNHZRZWFFaG5WaURkR2xuNXNHWUltUTBFYlFsVms4alpKc3ZwYzZX?=
 =?utf-8?B?OENVenV2aUl4VkNpMVd3ZERqdDY3Wm42UlY1dVJMNG9TR3hTdXRxblVpRTRk?=
 =?utf-8?B?bEVaWFdrdFZ6OEM2NytpQ0NhYkE0eEI4b1czdWtXU3R1eERoeDRtSlIzY3NT?=
 =?utf-8?B?Z0V6aWRIQVRtUFcxNzNWQ01UQ08xaTlSVDFSMTRMVVJqR2pnUkFKSjNTN044?=
 =?utf-8?B?QndSWTNtNTdQTUIyMzBkM0FWWGlLSE5BRFpJSXNCMG01S2x1Wnp5d1hxL004?=
 =?utf-8?B?VjFEckozcVc4c0xRSWRmd2ZsQUxPelVCRVFiUFdDN3lDKzIxTXFSdkZLVmNm?=
 =?utf-8?B?bndjYlZOUmk4T0FnblRyaHpNMDRHTjZBaFNXZ0Z1Tlh5Vk5xeUV3MGRsN3J2?=
 =?utf-8?B?eFhUOEdQWWtTOTdZTkNrU2pOb1p3OCtMNm9VVCtjcGwyb3JYaXRKamtQU1FM?=
 =?utf-8?B?MnhnS2ppWXJ1Q0hLZG91Yi9td2wxQzRUNkluOVl4bFVoZlljQlVhZlQ2MFNO?=
 =?utf-8?B?Y2RRVzhqT3BKajEySGp4ZkhKU1VOY1lsWk15YlFkUXFLUDhvams3a09reFA1?=
 =?utf-8?B?Q01QNStQM3JEeHFLNVFDMW0xMXU0RlZiRFBVazBmcXZZM3o4b2NNZVFxN3Nm?=
 =?utf-8?B?SVJYWVFxTHdaV0xkZnJFdFpSTXB4TWo2eThOcEFWWXNYVEprZkE3dk5ISVdP?=
 =?utf-8?B?U0krQUhXVEFxNzJMVzN4QzQzYTAxNEdROGNRaTY0cFdIN1RKbVBVL3Q2Q0Ji?=
 =?utf-8?B?Y2VBU0tBQmJGVEpJcVc1U1dzTk1EQ2FId0Yyd3FGL2hyOGRWSjJNVWc2bHA1?=
 =?utf-8?B?VjBCUlIvRXBDdHpzN2h5RzZ0aXh1NHMwUjdwS0tMTTc5V29jcktCZWF4T2th?=
 =?utf-8?B?RnNjRlYwMnkxRzVRR2RMdlRtekZaRDF3UjYrY3VoaFNUZ1BlVklKS0Y4aUda?=
 =?utf-8?B?aDJKVHQ2cmFIUFplMEYrUWNEMFR6UWtyVjJoYnhXV3JoTkZjZ1c1OXdqK2Yr?=
 =?utf-8?B?YTF5b0JyTkJRWlR0eDFwamhXOHBHNWhoYnAxUmliNkFQbUlYL1ZUMGtsZmF3?=
 =?utf-8?B?OStFNFhpVUJVSVhJNElrSHZFUEl1UmxXQXZBeHF2ekNMRURCOFQ0QjYzejY3?=
 =?utf-8?B?Y0Y5MmhTSlU1TGg4VkFqNlBlWWVlbVQwYm5Sekd1bDB5TUU1bjh6NldwWXJu?=
 =?utf-8?B?Wm1PS000b3o0T0dKUXVmaXMxUmNxNnRXTVRvemZ3VWpvQ2c1VUdoam00eUk4?=
 =?utf-8?B?U0c4V3E2ZW80Z3hLRFo2aFg3NUd1NDZXei9VYlIwUEd3RkRYUU1PbE5PdGRR?=
 =?utf-8?Q?gewc9tGRzg235Fj0GXZhtdI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4eCGDxesYsS+n676W+QRAcNyIGfiVL7Gxl2WBu0KAeJ8v4AMZ8xWkoMyNrfbCL0T4UJRoFsgQs9nv5/aS67hAWH4zH5ncflL37t97FJcJqZ0fOwAkfPFLfH+AlXYsMOiaCt/aJFBPAywbaD9BhU1GufsXnul8WQWeABS1QQwt1C7Xd8ouO6QaBds0710w4WF79H2p3NhjLLGRnrxIFbTweqXT2ks+a3WTDKAluQ6QSH+WI6g5eLWue8q5XJFZGCPyHsm9NKSC7q0Ol1w4Mgs0tBeVOkFHHK9NmLx+dWkkZB1SqtDFo1KGwKxIRHADd4b9crOPmp+FTBgW0o8Ro9qwhxw6l0Mr5bXNCZgRVMbQH9UgmSYCrP95jI+i9ii1t2CPVviWTg0uLjoVGlwRVCpdmN4tQL60YTBNNeBfBXefNo6L85Ys2wZpwl0JGoyEKVxMXYqNzoPBB/8d9nR3rJxyiSM4arvxiTmHV+2h31zb0TCdQtElva/QW5jF2NA9FkMgM6BlcEWw4JNv8KXy3V8QH2Awey9f61k/9gG4zHabG6ZFiLMt/uZYj4sxowErxTnGB1RtseMDDSNmJUPSBsNR6wN9GZaLYOSBknRuzDBmtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf7fadc-9357-4b68-b2e7-08de27d5474c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 01:36:51.4317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9HOcBs/taTuv6lT2pshE9jwOX3HycACv8nD6aGho2xt91shIIiGqkS/gF1iDaBmUnHFcJO6sqcfx9AcZwH/rL9lGDBw8lQevC9+vC9LsIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0ibQMbduKKFM
 EuLUsDGZDlAUoFBrhGsBM3po8koRuqdVDso26FGpG/VYpG8gX4d/SWu9OFMe9dVEpE7oYgKieLs
 qo02IqD+29998I7aaNeU9b15mMrmtKn8AnryUbjhj5yirFcym5/gyRzZGTsM2YlRqCwtztt6wYJ
 pjAoxsbcUKpvxabLZcQwxnKy2kjtQOHjIF/jFxcELK36bLTkYD/5K3l11XBVcLN3ifDnqFRG8Uz
 XTne3fEupaHai0a3Go6rikCrzT7HF2L34+j0ztqVxCQJ9M2vufibEL51yWlO5p/3qC+JvTJiurt
 sE6wmHO3KfA5LtEnMfXP/TS3nWqfdGd3dMmLZvSce/2geuV4xiHgBUG9rs83ebnvAVrhdU4Ad56
 MEIzXGhqohZSINp3Z50HHq/vzfJFvg==
X-Proofpoint-GUID: LqOUGmQQ7JIF-B-butT8bqT0H4xVw1_w
X-Proofpoint-ORIG-GUID: LqOUGmQQ7JIF-B-butT8bqT0H4xVw1_w
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691e70b7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=Ou_J2rQazAM6UOirIRAA:9 a=QEXdDO2ut3YA:10
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

Hi Sairaj,

On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
> This makes it easier to add new MMIO registers for tracing and removes
> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 76 +++++++++++++++++++++++----------------------
>   1 file changed, 39 insertions(+), 37 deletions(-)
> 

[...]

> +#define MMIO_REG_TO_STRING(mmio_reg, name) {\
> +    case mmio_reg: \
> +        name = #mmio_reg; \
> +        break; \
> +}
> +
> +#define MMIO_NAME_SIZE 50
>   
>   struct AMDVIAddressSpace {
>       PCIBus *bus;                /* PCIBus (for bus number)              */
> @@ -1484,31 +1469,48 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>       }
>   }
>   
> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
> -{
> -    uint8_t index = (addr & ~0x2000) / 8;
> -
> -    if ((addr & 0x2000)) {
> -        /* high table */
> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
> -    } else {
> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
> +static inline void amdvi_mmio_get_name(hwaddr addr,
> +                                       char mmio_name[MMIO_NAME_SIZE])
> +{
> +    const char *name = NULL;
> +
> +    switch (addr) {
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
> +    default:
> +        name = "UNHANDLED";
>       }
>   
> -    return index;
> +    strncpy(mmio_name, name, MMIO_NAME_SIZE);
>   }

While I don't believe there is a correctness issue, and it is a clever 
construct to reduce code repetition, I had some concerns with the 
implementation above, mostly on coding style and maintainability. I can 
go into each of the issues, but as I was trying to think of fixes it 
just became easier to write the code so...

I think these changes preserve your original idea while fixing the 
problems and removing unnecessary code. Rather than diff from your 
patch, I'm sharing a diff for the full patch. I am still working through 
the other patches but the upcoming changes should fit in with no issues.
Let me know if you agree with the changes, or if there is something I 
missed.

Alejandro

---
(compile tested only)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d689a06eca..6fd9e2670a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -35,28 +35,7 @@
  #include "kvm/kvm_i386.h"
  #include "qemu/iova-tree.h"

-/* used AMD-Vi MMIO registers */
-const char *amdvi_mmio_low[] = {
-    "AMDVI_MMIO_DEVTAB_BASE",
-    "AMDVI_MMIO_CMDBUF_BASE",
-    "AMDVI_MMIO_EVTLOG_BASE",
-    "AMDVI_MMIO_CONTROL",
-    "AMDVI_MMIO_EXCL_BASE",
-    "AMDVI_MMIO_EXCL_LIMIT",
-    "AMDVI_MMIO_EXT_FEATURES",
-    "AMDVI_MMIO_PPR_BASE",
-    "UNHANDLED"
-};
-const char *amdvi_mmio_high[] = {
-    "AMDVI_MMIO_COMMAND_HEAD",
-    "AMDVI_MMIO_COMMAND_TAIL",
-    "AMDVI_MMIO_EVTLOG_HEAD",
-    "AMDVI_MMIO_EVTLOG_TAIL",
-    "AMDVI_MMIO_STATUS",
-    "AMDVI_MMIO_PPR_HEAD",
-    "AMDVI_MMIO_PPR_TAIL",
-    "UNHANDLED"
-};
+#define MMIO_REG_TO_STRING(mmio_reg)   case mmio_reg: return #mmio_reg

  struct AMDVIAddressSpace {
      PCIBus *bus;                /* PCIBus (for bus number)              */
@@ -1484,31 +1463,27 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
      }
  }

-static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
-{
-    uint8_t index = (addr & ~0x2000) / 8;
-
-    if ((addr & 0x2000)) {
-        /* high table */
-        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : 
index;
-    } else {
-        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
+static const char *amdvi_mmio_get_name(hwaddr addr)
+{
+    switch (addr) {
+    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+    default:
+        return "UNHANDLED";
      }
-
-    return index;
-}
-
-static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
-{
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
-}
-
-static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t 
val)
-{
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
-                           addr & ~0x07);
  }

  static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -1528,7 +1503,7 @@ static uint64_t amdvi_mmio_read(void *opaque, 
hwaddr addr, unsigned size)
      } else if (size == 8) {
          val = amdvi_readq(s, addr);
      }
-    amdvi_mmio_trace_read(addr, size);
+    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr & 
~0x07);

      return val;
  }
@@ -1684,7 +1659,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr 
addr, uint64_t val,
          return;
      }

-    amdvi_mmio_trace_write(addr, size, val);
+    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val,
+                          addr & ~0x07);
+
      switch (addr & ~0x07) {
      case AMDVI_MMIO_CONTROL:
          amdvi_mmio_reg_write(s, size, val, addr);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca512..ca4ff9fffe 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -45,10 +45,6 @@
  #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
  #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)

-/* No. of used MMIO registers */
-#define AMDVI_MMIO_REGS_HIGH  7
-#define AMDVI_MMIO_REGS_LOW   8
-
  /* MMIO registers */
  #define AMDVI_MMIO_DEVICE_TABLE       0x0000
  #define AMDVI_MMIO_COMMAND_BASE       0x0008



