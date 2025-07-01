Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D5DC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwX-0005Vj-6j; Tue, 01 Jul 2025 10:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwV-0005VJ-OM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwT-00029O-HC
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9CnA019339;
 Tue, 1 Jul 2025 14:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=5Zr2W5CgHxGLsbs1OqRCXdJvIqaUXD9tgVkLSUYZZsI=; b=
 LNvnjyZDgD0U9C1GVhQdh9AaA+04wVRXP5dzYR6RVRIE9YxGG9kHT6q0AyTPgdv7
 rs3MyI8YpAf25ypoc7wrpF17oTuaR/l0xtmOwjg6+6girSKCUNYUqbQ1oX3c0hLQ
 62o54XrQ+Gyq12qqGiuIjsEHwAHZ73QU4GFLyFvmy9O1wZO6BWu0vLwulfxEiHqv
 ZIVd5ea2au6RAPdgXuw6i6ksXenEHogCett5jS3Mc7g/3PuR6QMNzXvZ38cdKQBO
 pjL5y5tnBoXRCxCa/Wo6bvhAwAO4vC4vYL42VHmZriz7RqqUXI6kkhosl5mjAM+G
 ZsCvt9DdiZI6iSyGEBVXfQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4w7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWIFl025238; Tue, 1 Jul 2025 14:26:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6uh3dw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQpnTm6SdWKcT8oyCKI/Z9eXpck2WSh+at67XX7c6gCgMdU0PeZGwzCf+VE9AUJDgnmDfaHQtG6dRKYRCPD/3/ietZhPKNrJ0rpaUblOT0VqTfxXkR39t0VORjb1LT+0iLQmg2iUEyjBC7WEFiwFBIf9PzsJiSyuBmjqWSndZeUNAvBXBKku2xOLRNspExWhx2vVifftLy6qyk84tafJ9YsdAhVtOA3k9lD/wWWU+Q3T/n9tWbfT28IF7l9aniS8x4XX59qOjr7p39Te388UTrIq7rWfUFBrSuzlMckzCuSrY8l0wvAbzKH/nGIOuzFp5UIcxOLofALn3ld1xX9NFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zr2W5CgHxGLsbs1OqRCXdJvIqaUXD9tgVkLSUYZZsI=;
 b=stnKmfb5vEwOpzArRHZvoVgwJLb9stSp9NRmNwbW/ZtrBGBMwld4BF/HS2tjoGoPhtwFGMJP8tYyMc2qlATS9k3LLonJX0R5F99fhRraE+ahJT4QDHnsV9+cG6j0cmbLVQYUmhep6aSLD9ZluBcVADpUF+xFIQLnNJxBZPtaKIl+eWq/h6kLr18NJeAu808OD8bARePP0rNIbNBKEWcAwebOudLF3+yhA8/PEkcRak1w2/RUCZubppDEwjtL6T6Ru7IH8xlAsLpFBwWRW7x8/POrrwK9XWpB3HKSrWjpsg4qShD7IDJBNfVTwIIxDNml9eh365m2ncqr68EiAJKwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zr2W5CgHxGLsbs1OqRCXdJvIqaUXD9tgVkLSUYZZsI=;
 b=pcCBdREjoHmDbDP/bNKxSFNQ5mYuc7hdbRI7uPYW5691NvyhRC+QOfq5PFjPi3yQ13jJ7vtW8snV0KQ9PzzhRan7VKcb/aJrkgX1roJ51XIO6/4jxCcVaevSMsONJSyZcdgN8yDGiGgwA27VkD+F2iDwTOffgd6r2UWBcgOZ0FE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:26:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:30 +0000
Message-ID: <08778487-e070-49e2-8f77-a072c2ec8ddc@oracle.com>
Date: Tue, 1 Jul 2025 10:26:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 31/38] vfio/iommufd: cpr state
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-32-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913698E6A59B6531BEF5F60E9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB913698E6A59B6531BEF5F60E9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: f03c1b68-3592-4349-bb83-08ddb8ab45b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDh2YkVNQUx5bFh3bHdVdGFLbVR1eFpHWFJORm9XMDRrYzJwaWlVaUowV2kx?=
 =?utf-8?B?TFo4RFRHZk1nd3JZMjYyelpqMk5uYVRoMFFqZFd6aHV3OWh0ZU9mT2Uycy9s?=
 =?utf-8?B?dERDcFBmWG1IVFVxYTZzOW5GQW5hOEJMMXNHLzR6Nkx3ak1pNVVZOFRPNHZP?=
 =?utf-8?B?M1Z3VFlNUzlSdURRMEI5elVWUzZnd2ZFNjhmMU5DTVVwWDBwTTVLVUNDZngx?=
 =?utf-8?B?YnRpQkVqYXJBbmEzWjZ5dnkrck43aXNxTnduaUZNUGFpZnNmNHBLSFVZcUdy?=
 =?utf-8?B?Q0h6VnpmQXMrcG01ZmI1SDJFeGFZcEV4U0VpRlNjQXJrSWpaM2dWSy9DMEdI?=
 =?utf-8?B?bHBXSlJLcmJZYnErYk8ySmJ1bDU2OVVKSUFSK2kwSDBjQUcyOTFxQmJnV2du?=
 =?utf-8?B?eWFzQzVCb1Z4RjdxZStjSGpSekRybEpUbk1DSXZLbmtYbW1aeGxyc3Fucmhw?=
 =?utf-8?B?dkw5S2MwSVV0dmlEZDVvT3M0cFJuekF0eFdWK3BKK3lSTTU5UEZhT0hrT08x?=
 =?utf-8?B?cnJCcm05aTZxWXB0cWdpazZ3ZnlTQ3QzMnZCU25VTFRXelFqTjFycmpZK25W?=
 =?utf-8?B?TVhhVTE5b2lpaVNpZ2Y1SEtDMStGeG81SFZzWEZGODhFMkZvcGpjeUkwdm16?=
 =?utf-8?B?R0x1dnF0M0pLTmxMcWFTVUgxN2FydWZmWitNSXpaQlU3aWtKdURLdGxjZ3B2?=
 =?utf-8?B?OTFKOWI1U1hPSS9JQkRkMy9IUlhNR0RzZk8vWEU0cXlGOWNzMGNtZUQ0c3pp?=
 =?utf-8?B?Z3V2Q1Q0ZzBZcVlIdVJ1S2pKVW9yMWhkZFY0WCsrd0VCNkdYV09KMW1FcDh6?=
 =?utf-8?B?TVR2cHFzcGJ0bWlDaHJwNzBDMXlHL3JlRFp2WlY0TnJiOXRiK1J3M2FKcC9X?=
 =?utf-8?B?dFVadzlhc1diU3NYaC9VQmRuNlljeTBseXdSUVBCNHhkUkRjTG9QaUd5ZE9I?=
 =?utf-8?B?T0xQRXhuRkUyT2c3bUNqVzljR1BXZktXWWMwZk5kbzJTVHNsWkEwdFpUODdk?=
 =?utf-8?B?bUlIR3FCcjhMWVJwZlpoK1ZXOG16aGlCQTNYSjE3Q1Q1TDk0Wk9MR1J6aS9U?=
 =?utf-8?B?TjBnZThkTGtldEttaW5pU01LNUJieVVQbkw0ZmxPM0NudW4rRnBQc1BFUVA5?=
 =?utf-8?B?czZlVFpCMzFIM1JuaUpGS00wUWFzUHJ3TDZ6ZnZwQXNXNG94UzNTSXJnSEhQ?=
 =?utf-8?B?ZXRkcVdRU0pDOG1EQzd5UlgxbW5CalRhMm9aYmxXd2hHZGdvS28rSEpJY1Yw?=
 =?utf-8?B?MGp2aWw0YTJOZUVUaXhsYVNRU3EwRGxhYndpOG9YdnNzclYyc0o3MW82dkQx?=
 =?utf-8?B?WnVPWUw4MEwyU2pCVnpERWRuT20rNlBQb25jWkdMOW91MG1aUHdnMHgyejBP?=
 =?utf-8?B?SzRkaWh3bzZacVpEOGYzbXNhNDM2d2Zac0R2c0Ewd2Rmc2Y3SHprMGh2M21C?=
 =?utf-8?B?S0tXRWhFa2JyKzdmS3d3UG92Q29WTk9EOVl6MStDUzA0c1gzMDgveDVIRUZ6?=
 =?utf-8?B?TFFUME5nN1FHenNISzVwL1gyWDEyK01pSWhPeUJxZGJoUk9NVlRWbXE2R1Q5?=
 =?utf-8?B?MGFLUDUwcDFGQ0NIT1dBWG9aN0Y3S2R2NDIzSGhiZjFIRHVLckE3bk1SWTlK?=
 =?utf-8?B?RUY5aHh3MUdqMmc2OU1XOVJhUzFCQ3dUdnBjN2wwa3BLQjNxR3FWSmZOdlYy?=
 =?utf-8?B?eW5XMU1hZUNzQU9YSjhFcVh1c0c1b0JtSlhORjFYQXdkT0pZNHpsQzg0MFNa?=
 =?utf-8?B?U3hDdkhKMll3bmJvYnlPd2Vndk5OQnNJc0RjSnJlL0tMeG1na3VYQnpHZmlw?=
 =?utf-8?B?Rjl4Z0NhR0x2U3BBU3R2by84ckorUWo2cG5tY2hEWmd3RmNJeDJsaXFlSk9O?=
 =?utf-8?B?MUMrOFNCVllBMHBURFo5S2ROWmI4d3lOdHdub3NwUVhvekc1UlNsaFVIY2c4?=
 =?utf-8?Q?58qdmMol6/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhZVG1mbHVaZ3NHNFZ6REhDSFh1TlBnSy8xTEhWTmh6Vm9NZzBwYnpBM01m?=
 =?utf-8?B?MGlrU2FnelR6U09LNU83Y1pGVVRtSGsrUC91dWZVNFdYejBBY2pITnNua21C?=
 =?utf-8?B?Mm1LVjEzU3Y5UkFmQk9teFNJeVJQSVVhUmJ6VDI4UFFlc09HZEhmbUdNTTF6?=
 =?utf-8?B?Q3NnWENkMXBVT2NiS1JtUGpHVFBtNjNYbW1WV3czRTZJNzhwOEMwM3MrR0w5?=
 =?utf-8?B?c1lVNmQ5bmpWeTA5aXRRYmtxT2k0WTdDbWV3dHIwS3JlVG9lcmZsb08vTWdN?=
 =?utf-8?B?d2hSMndrSDkyUDBzWGh2dFp3c1JxNWhJYVpJVXZ3ckxScGlLamJrMktrRU90?=
 =?utf-8?B?QzJ5TVVzT1pSNkNFeDZNOG8yaHRQeGV1THV3ZjN0MnU4ZjNXNGhENDAvc3lZ?=
 =?utf-8?B?LzE3VTZPV3NWbmhQeEpnS05FdURpK1BPcUpmTkR3dURuR1g0Um1xbk9saWFh?=
 =?utf-8?B?T2YvalBNK3hiU0paakYzZTFCTDdONk0rQmMyNHpYeWZQZSt6NHZHWlZKZ29N?=
 =?utf-8?B?YnF6dFRZZkVpdFF6VXM5dmpUNXNSaHRSK1J3eVExOWRKLzMxT1c2QjN5S281?=
 =?utf-8?B?bzh0bEhRaFR5RVhmcGhoRDVHTHl1YXFWaWVCTUNnRkh5NlNHeVRPcGZPYkFq?=
 =?utf-8?B?ZmZLMU9wYVVkQml3bERrK1YyS3NiWG9Fd2FtU0h6Y1J4Z2gwTFA5TGNkMlln?=
 =?utf-8?B?ckZSV3J5ek4zMitFVm5BSnNPUGErc2wvTTlUV3IxaEthOWxrRVNlZnl2Q3Ay?=
 =?utf-8?B?YjcxSkRUd25qOWRVU3RmYUNzQzFVR0JValQzSzB5NDFscm80blBLazlmRHFv?=
 =?utf-8?B?bzlibVZYR3d3UU9EdlJMcklrWjNlZEs1NVFzZitwbnlqck9oSkw4bkxLWEtE?=
 =?utf-8?B?MXRwQ3M2OURkNDFuZSs1bTZRZ0g5MS94YjlYbytISkNkUFVJWEhqV1VsVHRx?=
 =?utf-8?B?WDV4VWlZSjV5Y0pacytXSUJtd2N2QW9ON3FSWlcxUVZ4dTNXRW9sTEcraXMy?=
 =?utf-8?B?SUFWU256VTUycENJVWxtcjNIMDBkcHFubWtncXBnNTFqOHlGNmhTc2xUVlFN?=
 =?utf-8?B?TTNBWmlPZWVSR0o2SktpSXAySDNPcGdiRnBXUkowSkIwUGQzVFJJWTgyVXEr?=
 =?utf-8?B?c3hJWTRsYjFzbmVVNUFSVzg3bWswNlloWDRrcjJaeGhGYlJUQXpkUXV1WWw1?=
 =?utf-8?B?TW83b09FcnhxNHBwZkE3NVFsbkZjRlZCWVVhWjVQeStLbHR6NGE5cFdHRVJO?=
 =?utf-8?B?U3NIUHE3WTNiQTdScnVWamlzVTlsWWoyeG1hcktCOGtvdkRUcTN1VVFFNi84?=
 =?utf-8?B?bFNjT3UwVkljWHNnNmx3dUdnWUMrSkxIdjE0M085Sms1bDB0MlFWQnZ3bDVW?=
 =?utf-8?B?TE9nclg0TnU4bFhDWEdnWUdJSS9pZnU3cTVXc3ozYU1OSHJuTEpsZS9ISjNP?=
 =?utf-8?B?b0RnZ1NaL2dNc1VhalpDZjhFNVJkTFlOcTZXenVZQVZMN2IvTllyeFZqdnVo?=
 =?utf-8?B?MTVKU0wxdE1zQ3UremdNRU4xMThueHhLbXpkUFlwdHZkOWt6ZEtUWU5DTVZh?=
 =?utf-8?B?Tlh0MkpGbXZiT0w4MkQrajBKckJPT0Y2a1Q2bmc2TjZ5SE15cWo4ZnlNb3JC?=
 =?utf-8?B?c0JsZEJ4K1FhNUZoWU9qWlRWZTlERzFEUDg3QVlJWDEyTm1aOWFJVHd4SVhy?=
 =?utf-8?B?eHJTV2wvcUZQaWpMRXRIZkgzK1MvTXdMaHBmTmdYTGYzd1lHUXN0dzUzVHdB?=
 =?utf-8?B?ZEkzZjlqaHU5UEk1YkQ3cjJxbmQrZVgwWUE5SjRiUEljUzd4QVNBbU9MU3di?=
 =?utf-8?B?dXNFT1lrZk1XdGZpVnNCOGI0bXNZV3pWTU4xQlBUNGtFMWdvbVhjQ0VxYXps?=
 =?utf-8?B?SlB3RHFYOGRCSzBtMGNHRnp6QXdKWHdOYzJXVUJxMXUrbGNrajQ0Umt2aXM2?=
 =?utf-8?B?TlR0ZmNOTSthblpEdWdCdzdSL3dQc1NvbmtHcEdmdWhyaWZmTkg3N3RiOXND?=
 =?utf-8?B?Y2NFb3FFRkg2UFRqL0ZYYWtTWGhlb2Z1b1lpZjZJNXFjenNpbm9PZVRqb01Y?=
 =?utf-8?B?Tm55RHV6Q01waUFOd0xpYXZ1VnBNY2l3c3BKdVVDbFJ0TWtMbWN4OWxvcFVD?=
 =?utf-8?B?WDgweWpHeHNDajduZ2pvSjA0aTFhaFcxb0YrTzlKUm1Ca1lxdElUQUZ5MjZG?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fbw6qIfIVxJGQm7vXnCW5hhnIC/6p3c0aZ+6cTCZkY2wwWtpYigeVbNubHzSGtNVOt6cKFQS8Z9TC3c2rRfHkDkInwvyA6jCnxwCaePiDwBPqWMS72AKiLp/tbieVpGxxflcKubWd3dIC2Ob24MSJFcvZRAZKE/wlS53hDPhmORR/o0lhKTBjI67zRumjNAKe8Eub4bRT1osALq3wGghuQfXVC1pEGyuZDzQoGXLUEmuYY54z7eMjEmuBI3zw/5p4egjWErF0Ca2pRWmhB/WXTDhIHpH5kruxAHZ80oJPReuzqa2CPxRdpug8fNIm+BZLzotXub1nHm3QRDgWWS3LZ4Kb2NeS2PR5SFrahWP2qTCFh8PAz+YBjbr3xFVlDIa4GOyGDU11eaCaUeyKFoip5O5nm24/I7Qxq71PA94s42mUKJqw0XmB/9fmgyeoEY3nf27NzUifB1jqXOHulog9pshtLf9a0gI9b0OTxL2qzdiaAJWGZDx2oxU8HjEbj95kJKVB6+SIDalskliRI9p7TS3+RvPROEdiZZ4YHb2Dr9V5fNGISBpm7vUoHD68H/M1oOrs94tqCddUaktKUJPG1ZtABNQguPm37L/ojXt3jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c1b68-3592-4349-bb83-08ddb8ab45b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:30.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwwTNEU7iZzHS5WIR20c5SbeBaZxMf0pG6Y2vef78GuBYipPIyYElefedaz7CGsHQjGurUzF3FOO5hyLAI0QQIdTRcOYY9mY8icb3YTGvHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010094
X-Proofpoint-GUID: TIfHnYqnvno09WvwemofZo4OOxHUczD_
X-Proofpoint-ORIG-GUID: TIfHnYqnvno09WvwemofZo4OOxHUczD_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NCBTYWx0ZWRfX1Kqvpgjk9sV9
 UHoJ3oyRgpKje+W+yAdLq4I1mPytTsZkDXb5D0IZ2rK7bYaNakKUwlctvX1cbPrDWl6+78vLT/+
 R4KYyIhRVVrNdGczbffKDVP2mAMph40V8j+2OiU99zjmOL3cN3e+Fw7/AZLoGIx638JS7NkUX4b
 LQmqKgfKsBGCXo5Fmc1ZXOMGEc+hbtC8vlcIIbX75qnz8wRrJeQlMUfnic0XwYC4Va/STlm86VH
 6qv7peNrx02oqKWHuBKpxurtnU7ZYXG8M8PsTK/su1atcY8imSc3bPHPLMEekLPsSQnMkHq6e/V
 A7o/h0u2s6xzrV+G3cxx4u+I2pP4nAnoApxiCbr/4pnmEg14FWBjanxWXvaqfeFGhkwBiKvOxx5
 rZIc3zwxwVXd63df3R/SkTaoY2SSClWgcXSN7ZSfb/C0C9znSYE8rlC+jKgdnCsSA3YkGJih
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863f01a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VNNcEj47k5kFSB_te-IA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 6/23/2025 6:45 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 31/38] vfio/iommufd: cpr state
>>
>> VFIO iommufd devices will need access to ioas_id, devid, and hwpt_id in
>> new QEMU at realize time, so add them to CPR state.  Define CprVFIODevice
>> as the object which holds the state and is serialized to the vmstate file.
>> Define accessors to copy state between VFIODevice and CprVFIODevice.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> include/hw/vfio/vfio-cpr.h |  3 ++
>> hw/vfio/cpr-iommufd.c      | 96
>> +++++++++++++++++++++++++++++++++++++++++++++-
>> hw/vfio/iommufd.c          |  2 +
>> 3 files changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 619af07..f88e4ba 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -33,6 +33,8 @@ typedef struct VFIOContainerCPR {
>> typedef struct VFIODeviceCPR {
>>      Error *mdev_blocker;
>>      Error *id_blocker;
>> +    uint32_t hwpt_id;
>> +    uint32_t ioas_id;
>> } VFIODeviceCPR;
>>
>> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>> @@ -54,6 +56,7 @@ bool vfio_iommufd_cpr_register_iommufd(struct
>> IOMMUFDBackend *be, Error **errp);
>> void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
>> void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>> void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>> +void vfio_cpr_load_device(struct VFIODevice *vbasedev);
>>
>> int vfio_cpr_group_get_device_fd(int d, const char *name);
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 3e78265..2eca8a6 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -7,6 +7,7 @@
>> #include "qemu/osdep.h"
>> #include "qapi/error.h"
>> #include "hw/vfio/vfio-cpr.h"
>> +#include "hw/vfio/vfio-device.h"
>> #include "migration/blocker.h"
>> #include "migration/cpr.h"
>> #include "migration/migration.h"
>> @@ -14,7 +15,88 @@
>> #include "system/iommufd.h"
>> #include "vfio-iommufd.h"
>>
>> -const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
>> +typedef struct CprVFIODevice {
>> +    char *name;
>> +    unsigned int namelen;
>> +    uint32_t ioas_id;
>> +    int devid;
>> +    uint32_t hwpt_id;
>> +    QLIST_ENTRY(CprVFIODevice) next;
>> +} CprVFIODevice;
>> +
>> +static const VMStateDescription vmstate_cpr_vfio_device = {
>> +    .name = "cpr vfio device",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(namelen, CprVFIODevice),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprVFIODevice, 0, NULL,
>> namelen),
>> +        VMSTATE_INT32(devid, CprVFIODevice),
>> +        VMSTATE_UINT32(ioas_id, CprVFIODevice),
>> +        VMSTATE_UINT32(hwpt_id, CprVFIODevice),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +const VMStateDescription vmstate_cpr_vfio_devices = {
>> +    .name = CPR_STATE "/vfio devices",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]){
>> +        VMSTATE_QLIST_V(vfio_devices, CprState, 1, vmstate_cpr_vfio_device,
>> +                        CprVFIODevice, next),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void vfio_cpr_save_device(VFIODevice *vbasedev)
>> +{
>> +    CprVFIODevice *elem = g_new0(CprVFIODevice, 1);
>> +
>> +    elem->name = g_strdup(vbasedev->name);
>> +    elem->namelen = strlen(vbasedev->name) + 1;
>> +    elem->ioas_id = vbasedev->cpr.ioas_id;
>> +    elem->devid = vbasedev->devid;
>> +    elem->hwpt_id = vbasedev->cpr.hwpt_id;
>> +    QLIST_INSERT_HEAD(&cpr_state.vfio_devices, elem, next);
>> +}
>> +
>> +static CprVFIODevice *find_device(const char *name)
>> +{
>> +    CprVFIODeviceList *head = &cpr_state.vfio_devices;
>> +    CprVFIODevice *elem;
>> +
>> +    QLIST_FOREACH(elem, head, next) {
>> +        if (!strcmp(elem->name, name)) {
>> +            return elem;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static void vfio_cpr_delete_device(const char *name)
>> +{
>> +    CprVFIODevice *elem = find_device(name);
>> +
>> +    if (elem) {
>> +        QLIST_REMOVE(elem, next);
>> +        g_free(elem->name);
>> +        g_free(elem);
>> +    }
>> +}
>> +
>> +static bool vfio_cpr_find_device(VFIODevice *vbasedev)
> 
> Better to rename as vfio_cpr_load_device

This is already called by a function named vfio_cpr_load_device.
The usage is the same as cpr_find_fd, so "find" is a consistent name.

>> +{
>> +    CprVFIODevice *elem = find_device(vbasedev->name);
>> +
>> +    if (elem) {
>> +        vbasedev->cpr.ioas_id = elem->ioas_id;
>> +        vbasedev->devid = elem->devid;
>> +        vbasedev->cpr.hwpt_id = elem->hwpt_id;
>> +        return true;
>> +    }
>> +    return false;
>> +}
>>
>> static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>> {
>> @@ -79,8 +161,20 @@ void
>> vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>>
>> void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>> {
>> +    if (!cpr_is_incoming()) {
>> +        vfio_cpr_save_device(vbasedev);
>> +    }
>> }
>>
>> void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>> {
>> +    vfio_cpr_delete_device(vbasedev->name);
>> +}
>> +
>> +void vfio_cpr_load_device(VFIODevice *vbasedev)
>> +{
>> +    if (cpr_is_incoming()) {
>> +        bool ret = vfio_cpr_find_device(vbasedev);
>> +        g_assert(ret);
>> +    }
>> }
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index ff291be..f0d57ea 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -515,6 +515,8 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>      const VFIOIOMMUClass *iommufd_vioc =
>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>
>> +    vfio_cpr_load_device(vbasedev);
> 
> This can be open coded.

vfio_cpr_load_device grows in patch "preserve descriptors", so I would
rather keep it closed.

- Steve

>> +
>>      if (vbasedev->fd < 0) {
>>          devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>>          if (devfd < 0) {
>> --
>> 1.8.3.1
> 


