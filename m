Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99165CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 21:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8mZf-0005bq-2o; Tue, 14 Oct 2025 17:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mZc-0005bQ-LW
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:28:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mZX-00083s-Ap
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:28:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf7hE001747;
 Tue, 14 Oct 2025 21:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=V8c8TRBiSdJ1GX+gLQP3fvgTAowWdH8eaLxlvP1wjV4=; b=
 BZa0FpdKq2qoFk1UMIbn8V/7im6v9z/he4KwuD1JvzDglwGER5hs/Ja+QGP5u108
 sbclRsrcBIoxX4Cn3i5ASP/Lt4Tf4T6/aNdyTG7JyiqLazXH9cBgIqCmRAGPdCNw
 KESpkaq2QrtMGeo/qofj/U+1W5FqVAsVa7NASwOZ7Crgy7qZTXW6Vk898PiYE5KB
 /tMIhIdnE7NVY5/LLuXCIW7RNGEqnresrk/BX3WelPqJSq1JJhrPJvk2UKaSAmEK
 Xgn4BiP4p6DylXX42CHRhOq4/rSwYenU0fJsh7Su7PICwVWY21GjUCyeeAbeUxQU
 WnuIo+2sJN46TOw4TuHtqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtync5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:28:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59EKAIul025659; Tue, 14 Oct 2025 21:28:31 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49qdp98sfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7bS3VKOAW3IbuwkRgtPiiaGBXillgmO59UB6caNaMtIzgh1MjxVFEeMqrHUSuJsrhGG/EWfaiLxkxjKWCQiqWnET/8ivX8ricJjfwQ0+CI4oqjuvJy/hqsAYmu0crPt53dO6MDR+3zX70S2i4+YpRw8Wafv0tDBuoV5u9AFevdm5AqjQEpIePYzo8zWdr+mtz4zDP4YzUcqYtYDbJ40/ojNAHpQPF7HGd59TOQ2dYXjWnpDyZggSLbZa9ICJuhgybNIYlhiSigfDlPO4dJqc1kFODWUgUx4x6DD1i5Un2HyQt8K2eMNr8Hs7KzWhnty9gQt68IgwMUGWDyxo7UrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8c8TRBiSdJ1GX+gLQP3fvgTAowWdH8eaLxlvP1wjV4=;
 b=HWfEA+3V1EytAvnzMqy4zZ7FtKywIq0kRdnu/MGTQUTvrINWo2mBWqbVNFVaWBiLU8t9kw8Ojka0WyDSopzpTFjOC7BBZe/95Z4Rzk7+gaCbv2T31ab8HEPH1w8CBg5DOShFf1+wRxnQl/d+mXqxvt0hMWXsatS28AWfmrCaYPzmpD9Hx0Zmvic+00RWxHm0qEi9B0/QH2+zdrKmOmtjsZJ2IoDgdNuj8HLUG/Srckml0C47a5KG/UGAGDMAlJO4OojWgjoKM2KL5K6APiEOXuXpaKIJUfQbRGWbfb2HLJHNpS6rcm1rOyX5Y355Y7EloYZSqTTdL/01+Rf45s9S/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8c8TRBiSdJ1GX+gLQP3fvgTAowWdH8eaLxlvP1wjV4=;
 b=Dlw5aOVAFfg2nwo5dn6Gbe0RHZ9YKGrmyE1Qr7z2ErnSbfSwu1Ju6rYtzNK5u3Bq9jBVF4ncKnWbZxEWc48/p1b1WlAvhQRF5jhbdFYqd5Wb9yIWoFWm16SCh2AQBvuq60LoidLFOQO+u0fPC0wsW4t3N9FzWd4iyo9zXr7ePQ4=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DM3PPF1BD38130F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 21:28:04 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 21:28:03 +0000
Message-ID: <a50b49dc-d35d-4db9-b177-9901bef6ed75@oracle.com>
Date: Tue, 14 Oct 2025 17:27:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] amd_iommu: Cleanups and fixes (PART 2)
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251013050046.393-1-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251013050046.393-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::28) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DM3PPF1BD38130F:EE_
X-MS-Office365-Filtering-Correlation-Id: 062cf5fc-bc45-4d09-6720-08de0b688f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW5aajdhZE5VWnJvWUQ4YXAxbW9LMi82VXAxQlExMndsVDV3bUk3Y2hnb0E3?=
 =?utf-8?B?cElmclYyU0dvSklrR0FpNmhmVDBmNmxPY2pnbFVES3ZMSTJJcE81RThLeVZS?=
 =?utf-8?B?WWllelJnNm53YW9La1ZUeEE4cTRpdWIyT2NJNmVXamJaeVZsU0hoQWZ3RFAx?=
 =?utf-8?B?aDhuUmRiVFlRS3RrK0crNGZnMmJIOUhrbEk4ZUg5WHpaRW9FOHUyZnBNMUJr?=
 =?utf-8?B?SWM0RFZ3djk3VDVhZjgxWXRpdExKSHRJblRPdmhuL2ZlVUlBbzdxMVpWbTB6?=
 =?utf-8?B?TkRSUDY5UHhCL0UxM1p5VnVURDlFL0NGYmxxYnZkdXJpazR5aXB6cGwzWUdE?=
 =?utf-8?B?YmV6bkZWTlpVd210d2RKNGVIZVlySG1aMml6TU4wNlpvTGtubXliNkJDY2dU?=
 =?utf-8?B?VHlWTTVpSUttMXdMajhrNlFlamtCV1dyQVBDN3FYb21nM2toRDVrVjRhWk83?=
 =?utf-8?B?WVNnMFA5OEN5V0lDazIvSmtmczlHa0I0eU9kdzFCTWRuWXNqT1djZVhZaTJ5?=
 =?utf-8?B?UWlncHVnN0NNQzJTbDZxbDYzTTVhUTFQOHFsM2hjSkNQWVpEU21leEZTemVs?=
 =?utf-8?B?VGRoTnhRemt1Mm4vUHc0K0sxRFF1RWlPYzNmMGUrR1MrRDdYaUhza1JUTkVV?=
 =?utf-8?B?a1pOL0dNeXg1aVlRaU9OelIxMllkbEpkWXh0Qi81UFgxMHlLME8xZkdhc0Zu?=
 =?utf-8?B?eDd3ZFZSNUNyRldVcTh6THE0YWVtT292VWdTQlpzVEY4bjIrUjcxZC9DTGhV?=
 =?utf-8?B?QjhHZ3dtWFU5REJyQXYvbUkyUXhhUFRJa1BvVEN3NlgzOFhmaG4yRkpCY042?=
 =?utf-8?B?VC9LYmUweU5QK04vai9KeWVOR2toTHg3a21Xa3NVV0VjakZ4VEVwWXFnc2h0?=
 =?utf-8?B?LzcrQkFsUjk5NXowRTR5Z0ZURnkySktEUFJmRi9PZ3EraVBzSitqMUlXdGFi?=
 =?utf-8?B?MTZVMmVLNXRRZkt1MW1nOG5qdkdtQ2k5WkxHYXQ1N2EzbUlKeUJvYkNVNzBG?=
 =?utf-8?B?cXREWEo2VnVRVEp3NGdPQ0hXc0NIZW1ZZTMyY0hLRnpZbE03ZURwbUY1Uytr?=
 =?utf-8?B?eHF3Y0ZsUldtRUpENko2NHZQd3FhaEdtMWNkQ2xnYXVLck1tZWJFSEI5VFFh?=
 =?utf-8?B?M1FhZHFMKzBXMlpVRVRyeXJLWmFrclF0emFVRjhaOEoyVjNsc29iTm9LMU8x?=
 =?utf-8?B?eVJmRXFaL3NUQVZMTk44dk4ybXkwUllCMlBPdzFTOUJDVktPTzlvTUR5VUo4?=
 =?utf-8?B?TG0wWTlKSk1XQmQ3V2huWG5mKzlQNlJIYlFBN0xYSGY4WVpRQ0FmLzdsWmdJ?=
 =?utf-8?B?Rkl0TGRSVmxqaS9qc1ZrWkEwYzZoeTdwT21vOFhvVGkxWjRrZ212ckMvK2gw?=
 =?utf-8?B?M01wT1RZTG1BRkV3SnN4cDlmVHVsY3JMeXJjZlAzZ0hDaVZzSzltbTNXaUNw?=
 =?utf-8?B?QS9FUmx2aTFWNksybUIxdldTUTlJUFcxMnhKOS9UMTNCc0VEOXpOcWxHeDVJ?=
 =?utf-8?B?c1pFT2hOb2g1NEYyWWNQTkNoTVlYeDFocGVRTncxb2JRdllYZUhNNWcvOHpK?=
 =?utf-8?B?aE9OTEx3RkFTRXRObFFkdmFnbkRVeVU2bmZCZU9DQ3F0cUFWVmtWSnI3WlhI?=
 =?utf-8?B?cTZIa1NsWllKc0wvT2tQbDByczIzUFp5V1lUbktPZG1uRm5HdTFSK0VHbm5F?=
 =?utf-8?B?TzlzaXhydldPcmNaN3dnQk9RUkRVam15M1Q5ZjRVRTROM3RFYU9hR3o1M0ZP?=
 =?utf-8?B?Wm9JNXdtUnV1eXd5ZjZpUTQwK0ZjVWpMbEMzNlpzS1diK0RwdE9lNm9LWDl3?=
 =?utf-8?B?SjBaakhLQXlBL0JBbExIRmFidlQ1VHB6QW1VQlRja0lMVm56UENiZHdlZWJE?=
 =?utf-8?B?OUVSSnlQZ3FOSDNOT2JjS05rQWM0NTRQeWM4dFM2NktHcU1obW9uWVY0Tmlw?=
 =?utf-8?Q?Bip+Di9u+w/rsBEcNz8DdMOKvXO9EXJm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZFMHhPRnVDYlhENEE5STM4OCtoOFpOdXpvUkRLenU0UTdOZzhOUTJyVEkw?=
 =?utf-8?B?WGNrMHJFdWJ3TTBMNldEcDR3MVhBUFp6QVpjaEFRNEc3RTNKd0RzdmNKeng0?=
 =?utf-8?B?aVBHMSsrNEdMeGFPMEFySDBBU1NHVFE5dTVobVphOHRXTHkwSzdtK3JWY3Vs?=
 =?utf-8?B?NG5zOGhlRm5hSXBMbW5OOWRzY21EWHZZbUhrRG5Zd2NPMXRQZGZrZURJQWVm?=
 =?utf-8?B?T3FCZGs1SGdqay9IbnBJWWZ1aUdPQmUyU202KzVjTXNJcW56R0xuVDE3NHdl?=
 =?utf-8?B?L0tQTjhoK1RnZ1RkREFRdzl1d0xBOGFabVdoQXE2ZGRNQ05kd3RVUDl2a0tL?=
 =?utf-8?B?UnIwUXYyY3d3YVRIbVlKYm9IRWdBQnRtTlMvSTFwbXZhTU11Zk5tOHhvNU1W?=
 =?utf-8?B?cmducm9FcFE1c2ZnRjlRT0J4UTBXREo0QTFFTGwrL1hJbjhoVFJHaHZGNXVy?=
 =?utf-8?B?aDJEc2RNS3B3SWtnaU9jZFNTdFZoWUdIK0s3aGVIbDlYTmplVVY1ZXIwRUhC?=
 =?utf-8?B?M0Nxb2RMMzJKZ1R2a0N2ZCtTTllxWXVydVJOUXh0Nk02cXM1UCt1VTNKa1M5?=
 =?utf-8?B?VnhjVHlRRWtkNkE3N2Ywbkx6RjlRK3lMaTVRbG5tenphODZyZVpJWlVTY3dD?=
 =?utf-8?B?ZjljdmdabUdtNkJZZWFOTWU2dHdpVEdGUUM3YVpNOFU5WWdRekRjY2xiTGpJ?=
 =?utf-8?B?UDhmaFoyY1E5R05sVVZYVkVsYS9DeEIyRDdQYm4zRjNZSk5XSkovOHZra2tW?=
 =?utf-8?B?MGo2NmFaemJWeURRaE5yLzJnQUVGUHJZVDZ0SGMrSGJqRGRsZjVSb1pyakI5?=
 =?utf-8?B?eUtLM1NKdlFWR0NsZERNV0h5QzM2YXc4VEJSMjV4OG1sRWI5bUVtdEpPbEVX?=
 =?utf-8?B?NUcvblRFcVh0VFFKaUw4UXN0a0tKUmpKZ0tXdWJBSXJibGZuRFVwcExxQTI0?=
 =?utf-8?B?OEplQUE1WGhPdHMrMncyUUlNTm1VRlI4eHYxZGg1QTJteFVsRkk0N1NjR3JN?=
 =?utf-8?B?dzFVdkVYMFJIcmVaQU9ucHVsbVdaaWlualQxbUFlNWM2clBkRUx2ZFdQbjdK?=
 =?utf-8?B?eHV6cS9vRXpmY0FHQlJMd2FoaXJlZVBRUlptNlVydnlXZVBoTnJyVGFaa2Mx?=
 =?utf-8?B?R2pSV1J4NEpISjZaK1J6OVc0aE9HK0dLd3hPOUpGT0laRnQ1TTNTNG5QaVo4?=
 =?utf-8?B?MU5UY2kwQTBoWVJ3OE5tdXgyUmRucUxOU2JFdDdrWW5nTXJteUxHdE9PQVBG?=
 =?utf-8?B?OXpmOG43N3V6S2Q4N0lMUjBCSlBrMlFmNjZ5YkNPaE1VK3JGcTh5WHVSRGNV?=
 =?utf-8?B?K2JjZVNhaTN1YkNIOGhDN3RZZkk3OGZjaGZaRUNOQW9zREp1WHJNbkFxTG9M?=
 =?utf-8?B?dmlCc2I1bGpaT09YcnhPV2U4eTl3NWJkd3RTNDdkMkJzUVQxeFBzWk1OTmo4?=
 =?utf-8?B?NGFzYmE5VW9NcUx0cXFVdXZxZGRwMlhzZkZlVlcxOVF0QTBjYlVPR2VBT1M4?=
 =?utf-8?B?RGtVaFppaDJHZnBaRS8zNWxBUHQ4WkdkbCtsMnlZNFhQbXp6Z1VFNC9RdS9u?=
 =?utf-8?B?KzZBVU4ydkdlUURmMXY2V3ZkMkZVUWp4TXJYQVBhbDJSWHVpTVVVZFZXR01C?=
 =?utf-8?B?clYxYVZIR0Fva0E5b2lxSTNOY2RseUF4dTUvY3BIa3lRNk9VZ2pDbkxPSlMz?=
 =?utf-8?B?eFcrMlNkNXF5eVZCWHNKUnpwUHpoSkxPUzFJVmhTL1JJNm5ROGVqbktoWmFS?=
 =?utf-8?B?R3E5amdXRk9kN0YwTjloSnd3djI0K1c2bnExWnNCYk42Q3p4cHo1cC9JbXQ0?=
 =?utf-8?B?L1BDTW1SZFExTXFkRWRUelVvOUdzcmJyNFY0dWRRZXFha2J5QllJOS8xeExL?=
 =?utf-8?B?anhSeEM0aDZadmxtMmhXalA5ckQwTGxvZXFBVG1hZEdTeW9HMy9GR0Rta3lM?=
 =?utf-8?B?TGhrOUhFelVuMWpScUFlMzU0SHB6L2EvSUlnRG5mR3dTTGFsODZDWWgvT1g3?=
 =?utf-8?B?U2kwNC9DdUY1akRXN0FnUUw0d3JlQ0NwTzhlUmszc0ZhTWZ3dWhwL3AwNFpS?=
 =?utf-8?B?Q2tuSDdJR2tRUmN5YzVSMTVFQnZsQTZyamZQbW5ZQitRSjJKZjNyRnVUanNI?=
 =?utf-8?B?M01nVXArZ1VrR3NrcUxEYkExUEVOVEpJUDhMd0x0OEg0bHRzZDU5RDhFOGxn?=
 =?utf-8?Q?sYLc0Wk38AvVZ8uEguuCeTU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8I6IJ+sYIJnLXtH1ExSSj+HcYv7q+9OEFWOKCRJ2befkBTPP6luS/co7vW1fdkzRn9Mr2WJgbQOXQPXDzZxukOQSKeDxi5V5XABpjUaoOfuvtRNdTPVJkIIdBhtSkUYAOBD7a9650j3LIaBzdwm3Ezvn3ZaO9e16OcJWlfLu+NM6yoR52KEVvfLktmRuF2u9IsqAE0QVOqt+W0yIsbZWNwKA9zJLVvk+SSIcX3mjK+AT6XRC/uGJW4s7UR9n8IED2l1FaIJS9NCvBlQQP+RKP6RV7Pu8EBBOQW7zAlSgVvgwFTbZPN9bv9Nz0tPneL1FKYwpekpiY72Lo9MW7st9vSuZVZp25OLgMT3Q/WDbJBBjssMXdPi8ndhfPm1wmcgj9olcBB54kBveb/yShDuVkWL8w4Mwk886tFGkiYMT7PyzdiJ4h84r9woAUDUrbZBasHC1HATMRBGsyoVDBiOPqGmOUBZoN4bMFLSzx44QdvmjO5R9TSxP8zhHa2dxb+L/bfAEtU317j1kvKsrH5bfFals9AYvmhcT3vOrOQ6YaRD7tdwFz1adB7S/n2Zm5lg/Wzb7e7CHJ70N+kwcMea9I4cTJvHqHcDOSAF6uvwACM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062cf5fc-bc45-4d09-6720-08de0b688f0d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:28:03.9108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv9qhovDryxp7pxk7YqIMz4YkrqoBcHOTO2Vka/Z5XFrTUx2800wJwGoUPsebxx8MgVFMeSijNalhRlC5lP8yObvedljo1Si0X78bxG85o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1BD38130F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140146
X-Proofpoint-GUID: 2ekKEdCUnLmuqZy0C1-rn_cnA0dh3LWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX38u1QoX5Z/tn
 j5jkUifgxINyBk7yZ8LgwOkGLyhra+ph6RsVH/mjvM6x4JvAiTFrHhsgRNXdTjNFNOT6I2femus
 huuELsWQ3KXG87DjsKDbZ7kb4JGgUb8GQGC4PKQXLzvaMt+XrguHvk30YG7OHAr/oIAjI6eSG4x
 e2ZTOf1XSdiI1t2QemuD4TEAo4rRXplcGLuguidNQ85DfvNqTCpkGxsnwSHCUveu7588L4kKXFx
 WlBZR4ypEwBAhmyOPWK9LyoVKJ8kKBS0gIBcQO/jaxw8mLzOuo8N/ZItEblsFpup/5zbF/JFuQJ
 rGv1McfvXtNIMxKBqaRy/5eYGpDbaBT3Yf6F39zW4Infwq3XEvQ27nYd1hmlJap3ngFVi4emlth
 j3rxgm+yfkz8SE3Z+AKvg9ndXzriHOzQ7HRqDzewuRUQbdCRamM=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68eec080 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9iJdX2It-fa-udBqlP0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: 2ekKEdCUnLmuqZy0C1-rn_cnA0dh3LWe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On 10/13/25 1:00 AM, Sairaj Kodilkar wrote:
> This series provide fixes for following two issues:
> 
> 1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
>     bus id != 0.
>     e.g. With following command line, dhclient command fails inside the guest
> 
>      -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
>      -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>      -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \
> 
> 2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
>     setting up the devices when guest is booted with command line
>     "iommu.forcedac=1".
> 
>     One example of the failure is when there are two virtio ethernet devices
>     attached to the guest with command line
>     
>         -netdev user,id=USER0 \
>         -netdev user,id=USER1 \
>         -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
>         -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \
>     
>     In this case dhclient fails for second device with following dmesg
>     
>     [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
>     [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
>     [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago
> 
> -------------------------------------------------------------------------------
> 
> Change log: > ----------
> P1:

I generally like to include a link to the previous version. Not a must, 
but makes it easier others to follow the series history.

>   - Use fixed type uint8_t for devfn
>   - Use uintptr_t instead of uint64_t
>   - Build hash key using lower 56 bits of bus pointer and 8 bits of devfn
>   - Use gboolean instead of int for amdvi_find_as_by_devid
>   - Update comments
>   - Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE
> 
> P2:
>   - Reword commit message
>   - Correctly initialize `struct amdvi_iotlb_key`
>   - Remove unused macro
> 

Before sending a new revision, ideally you should run a smoke test (or 
more thorough testing depending on the scope of the changes). But at the 
bare minimum please make sure a clean build is done. There are trivial 
issues in both patches that cause compilation errors. See the replies 
for details.

Thank you,
Alejandro

> -------------------------------------------------------------------------------
> 
> Base commit: (qemu uptream) eb7abb4a719f
> 
> -------------------------------------------------------------------------------
> 
> Sairaj Kodilkar (2):
>    amd_iommu: Fix handling device on buses != 0
>    amd_iommu: Support 64 bit address for IOTLB lookup
> 
>   hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
>   hw/i386/amd_iommu.h |   6 +-
>   2 files changed, 113 insertions(+), 72 deletions(-)
> 


