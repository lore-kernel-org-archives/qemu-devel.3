Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054CACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EGe-0004rC-KX; Fri, 10 Oct 2025 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v7EGb-0004qx-Jl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:38:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v7EGK-0003iu-AB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:38:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8tT8j002822;
 Fri, 10 Oct 2025 14:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=V91G2tWFcg4blGl+T4T7+CUnw0Ge5hFKX4qhdUUIHZQ=; b=
 DyPPJ7S5G5ib6cKl9zxcl+SfBfB9sLjs5xW2MgDOsNsQeymyd2g+lwFwqY6B+tFt
 2zEaLAyTLpCkExSiUFAduDLpM6tbARAsClcxkYfFfKUL1GHlMztByw+1dOGxCV4G
 +vo2qwTGPIafOm9iaWLCcHTvIfo0u6Lvqf+vtp1HAhK9+mknfUK0mfIGKRmDNygE
 JSjTM9w/ZvUBI+UvVx53IKgKLXD0M53VauGglLcOg0dGJYzvtm3a6i+JansqU+hc
 Z89FoeUyj5kOC7o0kiadvaUjEAqT87VU66Htp5nxXZiLaUDfr/B9bVmboaw4JP6t
 WXkmqK8t5MbybWcWHE9Zlw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8puwaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 14:38:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59ACbRa7022944; Fri, 10 Oct 2025 14:38:03 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv642e7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 14:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5pgISRzUeyAyS8YcaLDyC6IU+o2kmegG4UHrb5FSVzca9jm24VF8g76n1kLQWtjKmOhSYIyvpFNrLttw0XqKTmepzLPASqdNWNji6ry6fw0af4c2uph5eoz7Fes2aJS7lFRPtvp0VQAo3gaphWvW6P6O/tQ+01LTvgJmq++b/3SLxd/B/RuABNZ1Rjv0p7muud/wFPEJqt4VnZXLxn+0pJtbgvEbFheVT6ZtSs/6Ema2YkGWihXs3meaAd34PlSsPZRCL+PwvFdkKKINC+yZeuRfzcmSIzxH8MbLT3Ix5i7GfWA4XJRD7vGJ0Wm/feGVpZgJDFRiyfsYPjlua7XuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V91G2tWFcg4blGl+T4T7+CUnw0Ge5hFKX4qhdUUIHZQ=;
 b=ZipyWKndUaBf6qtRQu8zCJ7K/8kIIKQayVi+o4aNvVgDd1+cUfOextqVpD4eTmDsuUFcaC5QFK9dh99lS7r7zBu67+Ms8tvB1eFDGktgnoJtVPR+g5YwpvtnK+aaRBhToREJ4705ijzHXsU/Zd/E1xEtI9CL/BhGwpZHNLGkA5X00Tq1VVCkguIe2pDWuX/T8VnHtNubosCbZ3TeVor6PogitZvu/ozkfHRcGgnaSjNjhH/RGAtTd0Z1jp/e+JeyEPDF0SFal71gmzdfy2E7aYDMcPMxlxP91WnuH4lW6e9tf4/+iT+A7nLM4kPO0xw+v3InlgyW07hNf+1VoEmGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V91G2tWFcg4blGl+T4T7+CUnw0Ge5hFKX4qhdUUIHZQ=;
 b=z6mutdMkO6TjyIVg/rm7mOcRc5WKdfLsAEglTcVg1agf3fygPv386CktqZlEuus7Ul2FVLo0ocqga6OiR4fmV/5QrV4R7EzBI5bQGFBUafwjy9JzMwPMCVh8nHE9sfmqCoJRVxsuhlqZNsuXgO2MyDLCR9mOxjXJNq0VEK4T3tc=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 14:37:57 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 14:37:57 +0000
Message-ID: <7f0a34c6-eefe-4bfa-80cc-d1c9a3b5148b@oracle.com>
Date: Fri, 10 Oct 2025 10:37:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Cleanups and fixes (PART 2)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 santosh.shukla@amd.com, aik@amd.com
References: <20251008164324.21553-1-sarunkod@amd.com>
 <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
 <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::16) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 6284f990-99b3-4b9f-c8ae-08de080a9ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UCtBNCtiMzJPdDdxa0d4U0djeVZhdUlaS1B6Z1krSnNkdElDRXF3Q24rQ0Nm?=
 =?utf-8?B?YldVZzU2bUphTjQ0aGgzUHMvU3plakZzVDJ4Wm9kdnhUUjl4SGZNdVpuVWRq?=
 =?utf-8?B?RUhoQkx4Z0x5cmhKWSs1ZUVtUjhEWTUrY0VFRVBaV0c4elAwYkVCczFueXJv?=
 =?utf-8?B?b095UTVXdGsxZnZJSTBlZkNIQ1FuRk02dnBqdVp1Skg2ekpZNVlpYXlYRWdE?=
 =?utf-8?B?V0IrM2NObmZLR011TzAzT2g1eXp1Syt5Zk1oNFBQOXJwL041TXFqUk0zdnBQ?=
 =?utf-8?B?RHMxbVZxSlZLb21ydGZ5S1IyMDREODJadEhsUG51U0lQelpTaytTTFRnbS9s?=
 =?utf-8?B?MnNmUlB4Z3Bab2cxMjc5SWtVZ2VuQXJtTXhFSEVrbnF4RUpJZlNFUE5VZWFN?=
 =?utf-8?B?VVhZN3RoMXVidGRaaHRPRUxWd3VaVXR2UkkyQ2J1d3AyK0h5RnRjd2lvWW9z?=
 =?utf-8?B?QmxTRUZ2L2llVjBiNWdzSlBEUStHVzBKajJIQXlpWUJhaFJZeUZWQ2haWVBk?=
 =?utf-8?B?eGtLYjhkalpUWUI3RE9xU1N4a2xZNFQ5Unh5b3Ird285NnZ3UGNETVVDWnNs?=
 =?utf-8?B?T3JyTE9uT3R6OUpJbGlUY3FnQzg4WUw0Uk5wTGc1YmR0ZEZJR3Y1UGJUcjNQ?=
 =?utf-8?B?cjBkRHByWkdWRmRrbjZkcDhrYWhleHhxOVdqQWRlLzJPOHBlL0pXcWNLRkV0?=
 =?utf-8?B?UThYaitUOFRJa0pWbnBqcG9PRzhERmgyNmdIckpUTXh2ZUZ0Y3cvSVo0ZjhI?=
 =?utf-8?B?bmgzaFlmK2YvemlWQzhFZ0pWQWVkWTY2My80MjhXL0V5M1BDekJDbmg0M1RC?=
 =?utf-8?B?RHBGcW5WRDB4WDNEbVVWUEdmeU0rd2dwWHVuWVF5WXI5dWZPQTJtUG80VFdB?=
 =?utf-8?B?dUl4V284S2NaRW1Hc0M3akt6Mnk4NnA5VEtWdlQ0WWZYRHVFWk5DS2JobDdp?=
 =?utf-8?B?Vm5WTHRuQWZCd0t0OFNjOEZqWFIzcUFTcWowRVlNRU9KRHpHS1BYUlp5RUVG?=
 =?utf-8?B?UkZzN2ViMWM1ZTBYNFMzM01XT0JsajVEdlhoNkxEU05vbXZvK0RDV3c5MlhY?=
 =?utf-8?B?NlVGMVVTRUJBYW52U2RBdTBCTTZCVHhIUHhURVNRTzdtY3ZWd0lOYUZWalhJ?=
 =?utf-8?B?bWw4N3dHWVA5VjFQR2NVZm5CZHp2OGJpeENLUmdvTDR3L0cxUDQrbVpnUkdM?=
 =?utf-8?B?eEkwN3hEcS9ScEd2cGs4UzFaNFM5QzZjcXRZeUJGemdYU3FNNVJOVW9HNnlH?=
 =?utf-8?B?djJRalNTTzkvRWJhM2dsVVBPeXdRNTdDT3hlNzdsN21QZTJXMkJESTVHS0Fu?=
 =?utf-8?B?eFZxT29MbmR1MTR0aVdBNnVyNEpxK3d6TSswdjBMSnZuVlpyOENmTU1hWGRa?=
 =?utf-8?B?QkVSdm81ajBheFUya3JmeVlpWUhhdHBhZGc0d2ZNQmpnemwyYktLcGFzZVJa?=
 =?utf-8?B?MmVmUitWTHhYekVvbkM1eWFpWWxBTzlBUzNSeDRua29hQllGSXNnVERSenl2?=
 =?utf-8?B?aTlaTnpFdUJVVWVVTnBVdTFFa2VFam43Qm1lamx2R09QZkJLRmxlbS9LNHJW?=
 =?utf-8?B?Qjl2VHZCcmM3clhZVUlYeHhrRk9QWFJQSFJTQ3EzS1dNM3NTWnpnRTRXYWtK?=
 =?utf-8?B?NWt5VEdwaUNqYnQrZzc2NjhDdXRhbWVwWG1DeUpGZG9WWStMUXorRy9lYytQ?=
 =?utf-8?B?VmZVNk11K29XY3ZsaWhkbndrQ050dEU4eVRVVU9ISlR0SFNLbnU1VXlXSnRT?=
 =?utf-8?B?WmZmTHZOaktRdGVnQjBDS2cwWnh4Mk9ibFVGcHJLWEtDaFRqZ1NCS2xnV0Rn?=
 =?utf-8?B?K1g1UDhFWTZaU1RQMlVxdVRaMXZHNVdXS1RNUjRvYXlYUDIwSCtNakZ4a1Yx?=
 =?utf-8?B?UDdEME5hdm8ySTVDeml3V0drYTJzMGZ5L2g2akJJb0RxaEM0bkdIMGZpNUZ0?=
 =?utf-8?Q?QlKA3RVhbdh8qg7K3cgxpySW648kJZqY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVhwN2IvZTduaXpxSFJmaUNLWEdVRkF5OWxlamVNVlFZVTFiUVQxOVdTN0lK?=
 =?utf-8?B?dmlGQzYxTkJEajFPcWJmTlVLVGJMQ2JRZHVxbWRsb05QSU5uT24wQlo3WTFj?=
 =?utf-8?B?RUEvOTV1QUM3NnNMVGpIbnQ5ZGIvUlpQdUFKQnpwWUVtZ2xWOFNRRnIwZWJE?=
 =?utf-8?B?cTRWK3ljV0xYZ0hBWGhjRTJtYWhzK0M5Q2hXKzQ0bFBIZHVNZ0h1MnhiU0Fj?=
 =?utf-8?B?amc4OHZmbENla3VmWFF0ZkVZYXZyVDlPOXNHOFpHWUphWUdrTkNyZXd0Mk5l?=
 =?utf-8?B?eVVPblUvZnN6TC91WCtic0lEYk9TSnFGcUt6a0pSSUFiYnhTNjZieWFIT0hx?=
 =?utf-8?B?aC9yUWpzT0Z2dmtSbHJIRjRGYlFuVmx4Q0pnSWVEUmlKOWlNdzByOGNwMlhQ?=
 =?utf-8?B?SWNBcGY3VWVQSFY1Q0c5UmV5SjA4UE1LUFJkU043ODV6QklsUktvZnRDWnRS?=
 =?utf-8?B?cUpVSmMrSmFCdUJwWFhUNlNKSWEzRk1rcWNTRkhac1ArZ2EyK3NlSG9iQTBi?=
 =?utf-8?B?R1FPOHBaSEJ5UExvNGVSaGp0UE11Q1NRZ3ZXTlRvSHQ0ZUE0cHgzeFJ6eWw2?=
 =?utf-8?B?VFFZQUliWDZaZ0dSSlpNVVYyajFXTjBWRlBhRzhYTE8xR1N4RUlEQmF5dnVa?=
 =?utf-8?B?VkhlSU5LZTFvcVdqcjRRNi9ITThRVEJXM1NqMVp2WmhJNkpSdWRVVnh3Zy9h?=
 =?utf-8?B?SlFOd2RjUzZBNGlVRUN6eFh1YVc1Ty9GSVFIZVA5S24xT0dWWE9wZkpQbUdI?=
 =?utf-8?B?WG9YMFI5Vko5ZU5rWHg2VzVEWG11UXlGbFVnMTlkbzJ4eFZYZ0pkdE5RTEt4?=
 =?utf-8?B?aU5ibXFOZk9LYnI4eTJEYzB6VVR6KzlqNG8vSFluNHZiM1U2c2NVVXdoL3FQ?=
 =?utf-8?B?dmt4TDJYNG1NcXZVMk5uTlMxeDVsUTgrc2VuRHluSm1pcHBCRWxoUjZMWnk5?=
 =?utf-8?B?RHlqNVNlWXJQSXBRMFpENlFhMnpTTzJDbXdwaUVzd1hOaTBrREs1Sjk0YW5u?=
 =?utf-8?B?dlV3YU5LcTUwOS8rS2k3RUxPVzFKL05oMGgxaVFyQXY2OXBESlcvQ3Z1YUhq?=
 =?utf-8?B?US9teTR1SzVpOGZDWXk2NzBwaWNSK0ZwOUMxYk1jaEZkM0tVeThhVHIvYUhi?=
 =?utf-8?B?akFvaDQ2WTh2WXVyUTkyNkZRTzJYUjRaYkp3WkpEV0V6L21oUmdhejFvNy9v?=
 =?utf-8?B?STJVNHhZWmFSbTZUdWN2WUZuWjY1MTRwVHFnVzJmR2ZoL2UxQ0FFREk2OENN?=
 =?utf-8?B?T2wxaDFnZllHSUZ6NEN1MW56bEZTNGpvbVlUY1FFQzc4WGZpTmVlUUh5ZjFH?=
 =?utf-8?B?VFhVTHlpTmQrc1ZkTGVZdC9NVS93aWRBN3FON3FFdHdwTENxMXlSQ2lMWXN0?=
 =?utf-8?B?N0ZmTXJSTU9kbE9CSnBTaisraDQ1MWlTc25CV2lxQmxwK0tZVGlzdW9NWitz?=
 =?utf-8?B?Y015MzlZUFJNelM4RUUxZjVMazZ5aG1rWDBvYU5WTHZZYmpqZFBwc3NjdERO?=
 =?utf-8?B?Q3ZtVmRiM2tXOUFLRXFKZzNzVHA2cEhCS3hVKzBRbDFOTldscHAzQVEwUzRE?=
 =?utf-8?B?VUp1YzBBYUFieGtNRUcrNUZJYTA4cWRJSWs1U2doZDlYNGxUcFN4c1FsU3RZ?=
 =?utf-8?B?dVpZTHVBbmh3VmhyOXU1dnZvNW5nVG1iRFloUUNyNGpBMEowVUtqQzg1aEJD?=
 =?utf-8?B?emJHRmRFVEdaSUZDVnBVUFpBYmV6Vkdid2c0elZIU1ZSZjhJcVBMZk9ad1Fj?=
 =?utf-8?B?Q2xjVFZQc3hoYlZmckFLNUFJRTRxZkV0SFZCQWtrMzZTWEVodHliRGI1clBV?=
 =?utf-8?B?TEVQb2ZCeTRZUFhsYXJzT1FhRkR2MkFEblovMmN1MlhDV2NZYmdXZVFKNHp3?=
 =?utf-8?B?S1JzZVkrQVd4M2t2RE13SlBmTTBkUVFGQ0l0L1hOTW9uekhFbEliMi9jdW1L?=
 =?utf-8?B?NGZVMVp6RHg5ME9xYlEzOUp5QUIraU40eXZxaGJuY2JzOGxpNC9NQ091TUNx?=
 =?utf-8?B?WUtYQk50bUhTWjdXeCtDRWxIelEwRDJtZk9jT3Y1STkyQkRvQWpsYkRxSnVF?=
 =?utf-8?B?VFUwZVZITU5ndGh6NHhRYldKa1dPR081aDNERnF1ekpZY1Y0eEVxVXBCV3V1?=
 =?utf-8?B?OWFVUTlhR1hOQW91Ujl3SHdkNVZJaGVyeCs0bzFSVXhyaTE1Zm9qSEljalUv?=
 =?utf-8?Q?F0Arz8qTTec/UFLrAlnMuLM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5+g/SLaz0Z917YEQhmytXBGT+/NTEHQHJnZBvWxBL+q6RQE0D4duaQGwY1einQCF76xlG1Avh9oEDq7PbMnnYNCQAacTTuQcylgjqj7Mt3XvTdeni+ppOYoka8mAQufAS06B9poaJ240s5QZu9NIrE8NEqhw0ZSsaUxsf22JCLLE2lt/5sJJ+TO0faf3rvk1h89KO89Vvb1mazjB5jIaHNZ3DFSLjd2zizDaG3rq9TBL5FHyEkh08jLIF9qazRnIVns5czICRVMCibmb3of8OzpmME2XqF7qJGrEwDuU6RvffRDShArhyyl/zNaLiNhw3dAh3iUedhEOPunBB0zAqmwLANT5M+4DtNgKuVk3I5W7CFPpyfUlUPDnPOUpwL2cj3FtHCZu1B9XS8dfazmkIN0LXPZYu8oF9NjjhKlzefwM6fx5XIZuP3llaN2SBNsc9uKYEw16i3FmVz7hB6hFlpK+qV9j9jarAW9TypKv71YAzddHFhXzxficBiEr67D8w9s62Cs8Tlz5WElIwT1NvJ3qugA3yE9Mf308DK+unyY7k6ZVuSlIb0gn2prrh0Sixt4Cyaya0LTlqKzGB6iZknECPRg0b6qDbHGZi3y6BQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6284f990-99b3-4b9f-c8ae-08de080a9ac4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:37:57.6202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPwAT5AJd4ccx5W4PPxYaj1777+YQxoSaADkrcqeV8x1gupRcUy7bAb0DEN6XHbqp7yB7kPjcnYYyAb/oSjOlsrq7VaaG3Zvf2mQMwBHwN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100084
X-Proofpoint-GUID: 1V3MCZPMj10Ypo0A7lDKwepolhbPsyzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfXysKIop1BXB8Q
 9Ll8jbOwmOfGcDMllE0PKPlXtU03Fb7YO/U9w3idloz/1yLzILKEbqq3a1nZ/Iwm9Vi0r9Bb1Fm
 qM+gRjHDpxYcVcfuwptH28hEau5EQ6tu7jbaGxyRmdAAAGlwN9N/UsJoE7QNJQBzgcEgxsI+q3j
 T++3rDscHmUyFa4Gs0vUZEjJ4C0jewoUiOtfg4l6/zD+9G+J9mEhPdwglACZmXzYss+ivNeVbuN
 RRAIsoXS16HFN7c2svDbE2jUi9jwpMflMiKhkN69U9jrjIw6PKgsulImO5mhaixhYDuMMtsr1sS
 JYt0M1AHDAdtZZcyeE99UntQanz5JKz0NmXoBrNMsIZ/SQ4ACRu4YEG0v/6KSJ28k5ZDckUijJc
 mdfD1x4W9oBAEXSz5aEnJyHvPCYir7/UvA0JdQzDPnpPnVgWw2s=
X-Proofpoint-ORIG-GUID: 1V3MCZPMj10Ypo0A7lDKwepolhbPsyzC
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e91a4d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=3GnX9RwCAAAA:8
 a=HVAl2jeKcOqDNsSpuocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RF-RJRjNljZ93lortB_0:22 cc=ntf awl=host:12091
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

On 10/9/25 10:19 PM, Philippe Mathieu-Daudé wrote:
> Hi Alejandro,
> 
> On 10/10/25 03:33, Alejandro Jimenez wrote:
> 
>> I know the commit log is not consistent so far, but going forward I 
>> propose we adopt the shorter prefix "amd_iommu: " for commit 
>> summaries. There is no ambiguity (only one arch has amd_iommu), so the 
>> full path is not required (i.e. avoid 'hw/i386/amd_iommu: '). Shorter 
>> boilerplate leaves more space for relevant details, and helps people 
>> like me who struggle to comply with character limits :).
> 
> What about "hw/amd_iommu:" to keep 'hw' in subject?

Is there any tooling that relies on the hw prefix? Skipping the arch in 
the prefix is confusing I think, since hw/amd_iommu is not a valid path 
in the repository.

I was looking for precedent of any preferred format in the commit logs 
under hw/i386/ and there is a lot of variance. But specifically for 
IOMMU emulation code, my interpretation is that the short prefix style 
is most commonly used e.g.

Common x86 IOMMU uses "x86-iommu: "

The VT-d changes are typically in the form:
"intel_iommu: XYZ", which Clément also pointed out recently in:
https://lore.kernel.org/qemu-devel/f97bc435e8ed1c295919350d300068e45ab0bb67.camel@eviden.com/

virtio IOMMU uses "virtio-iommu: "

RISC-V IOMMU uses the full path: "hw/riscv/riscv-iommu: "

SPARC64 has a few commits with "sun4u_iommu: "

I don't believe the 'hw' component is required to avoid ambiguity, but 
perhaps there is something else I am missing...

Thank you,
Alejandro

