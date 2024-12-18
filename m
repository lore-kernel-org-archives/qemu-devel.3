Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6BEE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx0m-0002Oz-SQ; Wed, 18 Dec 2024 11:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tNx0m-0002Om-0Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:35:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tNx0e-0002ip-9K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:34:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIFtpke011718;
 Wed, 18 Dec 2024 16:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=faNyIA130TKvadg0fzwltBgc3S4yMv44rzknteerqbo=; b=
 IkKjnWA4e/XKw8NcgNQPC3gu3DZZfwKOTjSsU7dBODf4BCemOZWVxoxC25q2sAPK
 CIenGhGdL/hsXgpTp90QUS22JOUxHLjAlww5HZakIVB7Z9fKkdL/blNAo3YrgLQT
 GGCveqPUFbMU/NuHeP0Izv1Awcjz3YN9yPsd1weew0hgcSwesjlGyuo4Nqb6Ilpb
 s9hs14uR2IZxUeYFnzg2ndLEcchQKgy37Sf9X6gva319jt53Pac4kTarqwam1O1f
 FF22dnWfnUFSDpcrWWat/MzTLe3EZ5/15o2kUyeVsrtIg0UOmsgNq48h3kKt+NxV
 HmXrjMuVIlybuZgc/Q2FFA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2h2et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 16:34:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIG0nIx008366; Wed, 18 Dec 2024 16:34:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f9wrvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 16:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5IRdASG8upYRe9vwDshep5v4iddpzmH4MjBB8GDdURD6OlkJk4Ma4x09r9oBg3j2oZEKwqqf29vbE+Mq1ubh5xmA6nHXWnH2SPzBuGKxVDR9NhuqSOu0yEnnb3PRcqI81SCFUD4F1TdxA96SvmTLbNv0gmKNNVir/qRbMQUFfgZYhCu4GRPiXtJRJts7G/KR6s7yzGRQrwtf92ufzO+W8O5+7xY1kVup1sRan4i5CSE0HmitWPEg0pgDZkWcsX6cooHVvQ/eokHKF5CSAoOerWxCMITx7FE2b6QlhdjGRSmZr0Bo4R+AcWZ+YwWUd4SjR1XDa2why76VyQNqmt2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faNyIA130TKvadg0fzwltBgc3S4yMv44rzknteerqbo=;
 b=OPcbQNGwgKl0HngFDtRa7ephhZ6FmEr9csNwIOEQk8kGfXWq8HdnO6Gswhl5MXV1iqcw37QVGNiGP8wI7BvpRCrY+IWAaqym5qfofTmm4G4NK2gx8BIbIdxjBtXsp57WjU1TykeqGdurAScSUZLcEIi3vU1cDSZkod959/39SKiUjhIFMf5x4H/SA+JiZWFTtUorEm2NamDNYw/BN++bFRmqQYOwrCcGUqWRtuZqi+yABS6CmHL0tRJRfovPuSDLOIIFyEWeWALwjgvjrDeD1OnsslFI1to9PrXrBhgUgTvWGrKIhc+c7uWy4FYWGuw06/dY/pSJHpYjA3ZKCxFSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faNyIA130TKvadg0fzwltBgc3S4yMv44rzknteerqbo=;
 b=nGuoGloCX8DI2bexbLqwyGULeEoxoJo8scSc+LcZJ+WL1wtNy4L/bnTfg74j8VSXIAR/WKZzueeA6KOBNIAiV07+N9JdGsSlbLQLDqV9I/BrC1ecppdeyyF8IPqNg0EnBLADdb73VOkxkp4/dI57XjRgU08rbZIjcUOLOtZSw2E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 16:34:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:34:42 +0000
Message-ID: <8406c79f-b7fb-4536-8d6a-126bb03a6c9f@oracle.com>
Date: Wed, 18 Dec 2024 11:34:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n> <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
 <Z1toIxDzI56ODYcC@x1n> <Z1xREcVCi-hn4BlW@x1n>
 <58935fbe-bb53-457d-b4d6-70c1d7b09e8c@oracle.com>
Content-Language: en-US
In-Reply-To: <58935fbe-bb53-457d-b4d6-70c1d7b09e8c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b9d88e-5ea0-46b2-d48a-08dd1f81dffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHFNWVRpZXpRY1J4TlEzbUJ3M2VOTUZPa0JxOXNySy9VYzBxY2ZPMTNCV3M3?=
 =?utf-8?B?VXRuSEFTNmZ1bzMydFJVZ0hoSWVSOFZNNGI4RWdDMHFwa0hPQ3ZkQ3hMYnV0?=
 =?utf-8?B?dE5iUXBIZVNpOHNyK1ErNFNpMWIydmhnVk5Cb3VLOEFTSzg0V25PekpaK0lW?=
 =?utf-8?B?WnoyeFVDN3FDRFNUMEFWMWYvZ3lQTVZ4czBnWFoxMWE0L0FHWVNibElOU1R6?=
 =?utf-8?B?UklNN3dUSExxMVYzNk9Ka0g1MllWcXJRMDZXUFRCUjNMVWtjZjRUcWhiWEcr?=
 =?utf-8?B?NVNTSFJOZzZ2blpMbVQ1cU0yWjZ0TFBvWlQ2d3pSUGM1dk5CemtQU1hva0Ru?=
 =?utf-8?B?dmNrd3dyTFRVTnlHdW5VQkIyNEpRSCs0UExMZkhzWitpc1I0cFVFNldWWEdE?=
 =?utf-8?B?TGs0eGxWUlEyV0tVZ25JcDdnd0hadENzZE83U0ZXam15cGF1NnYvM1QxQ1JP?=
 =?utf-8?B?UEhqbkdQelFRcXRSUUl5aWJIWUZ4V0dObnFLa0JlVlZIWUw2ayt3bkNvWndr?=
 =?utf-8?B?OTlsYUdjaVZ3Mk1CNVNpUWxENEJiSjN6NVB3Slpqb1NmSTl4SEtWdkhmcFVO?=
 =?utf-8?B?aEtTMjVDR3IvM1RLQjhxckh2dG1ycTZQYks1ZC9YbzRNSlQ3Q29iU1RsTHIx?=
 =?utf-8?B?ZDNDN1AyaXdxODhRS1U4bzJmQlpLaWRRNzJEOWM4NHdZRzUwV1JpTk5oQWNa?=
 =?utf-8?B?VzBXRmMyNlRLZWxpbHNrSC80c2p6dWNEVlFpU1lBTkYxNDJtelJWcG5XUlVI?=
 =?utf-8?B?TUtXTmhlcmU4MG5oR3I3RUVDSDdSL1phRkppYVAydnJmMzZIWGhWVC9GYnRE?=
 =?utf-8?B?VmhxLzA4dnU5eURuZG5Jc01aQU4rWHpSd3RYdlBTNnhXRm9kODNRWGhyc1Zh?=
 =?utf-8?B?bDVLbG5rSGtkQmtzODBZeVpENE9NY3FQdlFOREkrVm9WL29qTmxCb20vM0JI?=
 =?utf-8?B?OW50OFczODFCQU5ycDgvb25WUHd3TTh6Y1BqZnpwblY1OVVyQ0ZCUzV2UlYz?=
 =?utf-8?B?YmlKK051SDZSNCs1MHp3NVF6UUFGbUpCNWtibzQ0djdVVVpIY2pRTWNlVlFU?=
 =?utf-8?B?Z1NoelBNdFlna1F5QUxDcE5FN0srV2dtdklib3Q3bWloelRTd2wwdGx5cUpR?=
 =?utf-8?B?SVpuRjRNNVVNVFJkQW1ycmFmSkV1VHR2YzJvNUFPTE9oaHcyM1RQYWlQMC9B?=
 =?utf-8?B?QlRqQ0lycWtJK0NzZExxQkpnUnhWRG9veDRrZURGRnVHaEZycFkzTGRBUEl5?=
 =?utf-8?B?czNNUUFZd01JWG1XOElYRy9HWU42UVQzZFd3NHZZY0pIT3Y0YnNTRHRxcURN?=
 =?utf-8?B?N1VyRFJYOGxZT0NPdmJQSEdFL1E0QWtPbVpyZlRhOXIyTDJUNFFKNGhyaHF2?=
 =?utf-8?B?OFNtMUp1RlJCRlBrOURHT2N2ZUpJdzJqWlEvSlE2SzQ5Q0I2WS9wLzhudUE2?=
 =?utf-8?B?U1hBQXJycUt3bVdoRVJoQ2lqcldWOEsrYUtDRnd0TExMRHM1emVLR0ppSlVy?=
 =?utf-8?B?ZG8xYy8vVGs1SWgxeDNzQnRjY2dmUDF4M2VOUUlNd3FDSUNiS1lzOTNYRVFO?=
 =?utf-8?B?bXNQcGJDZEF1OVBOM0ZMb3JXRFZtMVZ6ZXV5QzBmWjFRM0d0bm1PelFEK0JJ?=
 =?utf-8?B?b2dhWE9QTUJKSGROcVFGdFBGMnIzRUY5UE8zaFpXQ3Bkc01jUWhUNVRCREE5?=
 =?utf-8?B?OGc5eWNpaHBuTWtmUGNObFdIT0QvWHRTUTAwSFNTRGV0L3NOcGhuMFU1ZjFP?=
 =?utf-8?B?dC9qajhVRVZpbzZBaHpOZllSMFRsWVBweW8yKythS0NKQUd1c2FSL2gxZWQ1?=
 =?utf-8?B?UlBvT2dnNkZsTDJKQy9INWNvUUs4UjZCRmdoajdIVGJoL0dzZEsxaFJmMHox?=
 =?utf-8?Q?ZJdX3hndpFjZu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRBeVJJWGwyNmJSNXluUUplVkVDRjRHUTFzWVhnbzl4NFRFT1hSQlpUbkFS?=
 =?utf-8?B?MG5VZXlOYk1sbzBEdUNnVFNDT3VRVCtPb1NPVzBrSmpSOFZlbHBHWlZLbHdy?=
 =?utf-8?B?L1ZGenNiV3I3bGhOcktxb242a0wxMXI1MDZaUWpRT05OaVYwdEgydm5SUlVq?=
 =?utf-8?B?SlR0Q0ptQXRrbGpab2pFUThoc2h5WjFCTW80bjR1YjdoR3Q0MHdIaWpaT0dO?=
 =?utf-8?B?RFdZNHl0bEhnajJMdWRHd1pORVZLTGgyQ2d0RXM3N0JvY3FjSVdnWUZnL0Yr?=
 =?utf-8?B?SWF6U2JjeEdyU3loRXZVZ1F0My9VMjIyM1V3cmVOS2FzRTNCSkp4VFI4clpJ?=
 =?utf-8?B?bm5BbDZOM0l1SkVwSER3Mm5QbUJTaGUrQnlsUFBkRHFZV0k3YXdQUlVoYVlR?=
 =?utf-8?B?T3d4TjErOWZYN0g2S0l6VEQ1dEMrMDRzWE9lNDVkNUlCN2d0eXowUTR4ZmNh?=
 =?utf-8?B?Qk1WM21JVzMvNUV4a0l4T2o3VzBPMnovOGI0cWhHa2ZwU3RBWDVYbC93b2FK?=
 =?utf-8?B?dkpGV3AxTG1seFp5ZndtT0tCVVZlNVFna2NYSzVmdW5Wd1IxajY5bmNSbVRS?=
 =?utf-8?B?MHY3SFNxdEZrRGdiREI0cmJrN1Y3UWlQcVN5K21aaWdQK3FEYVF3cTRPRjdV?=
 =?utf-8?B?TU9uS2tXRGltZGYwVUhMak5ZR2xaTHFNNENnTUp2QVRnK005ZnVaQzV0KzFj?=
 =?utf-8?B?Y05GTXNVWFE2d0dQYzBoNlBWZ0tLT3llVnVuNWZJcTlFMFB5ejcxY2R1eHB3?=
 =?utf-8?B?aWNTelVrMzFaTjk1RGNMWVBuRVVpUGJNcUhPWDNVdDJwWGVDejY3QklnMk96?=
 =?utf-8?B?RDIrSDdtb29YelFKREJudjlKKzUrUEpCc0lQYmxCT2wrd3BRN01zazRrazNy?=
 =?utf-8?B?dHVZbmdCMnRZeG43dmg3TVJpbWVPWFluZWNlMEZRU1I0Z1kxNU96cmVNZ0hI?=
 =?utf-8?B?YmN2U1lGY25YQlhEUnNuYm5XNnltVUxoMXBwRS8ybWcxYmdJTVYzamtwbVBK?=
 =?utf-8?B?SVMrMWMvcnI0MEJaVG5adjFHN0MyblI5NUQ4TGUxd1R1YzUyZzNuTit6cGdI?=
 =?utf-8?B?bTJZd0xsOHc4UjZ4R1Z2MVhhcVhaWVFMbVNucWY2M1pyRzRsa0tvQk9RYStX?=
 =?utf-8?B?VXdQNGNHRTRqaGJkMmw0RWRUVEVUVkEvRHF3RmNZbUVnbWdXRGFlc0hSMmMv?=
 =?utf-8?B?QzhJMjh3RllKV1l0cEI1M0tiRTJ2OGtkUnQ3dU51YnRYc08wTitEVzRzU2FK?=
 =?utf-8?B?NURhTHBBdDlwRXFzbkM4VWNaYTRNN1RjMWQrZEJkSUZxNGx1dzJpT2plSEhE?=
 =?utf-8?B?cWxqYkZrYkNwMzg5WVYzWEpObk1UTDFyTFcxT0dNNVNETlhwYW1JbTVvRzls?=
 =?utf-8?B?WGFNYitUU2FiRXdISVozeVd0cGdkM2ZlMHRpTkg3d3g2Um5STFhhaXdReE1q?=
 =?utf-8?B?UWZtOXdyZ2VUZTRDWVB3cGkvdWlkUlVERUxianh6VzVRRmo1Qk9DQjRzYXB2?=
 =?utf-8?B?K1NrOGhCb1lVNDNLdG9pSlpmci9Ha0swcGx2Q0t3SXUxcGtxY1RlSWl1WEpk?=
 =?utf-8?B?cHFNZ3dPclN5NjkreUI2a2JWUld5UjREL01KaWJEbTFIb1FWelBmYUhoUXI5?=
 =?utf-8?B?UGZtZzA3U1pnME5QZWNQaFFGSGN4WllBbFdla1B6WGdRWnFwK2tUMDhFNzd2?=
 =?utf-8?B?d2NQVnNjZ09PcWptR3QxU0hWMjFJS01zU2R0YUN4VEJ0S0o4RjI4Y2VXNkRh?=
 =?utf-8?B?ZUpZSHdTMnluMXZkQTZjanptSkhYSVVzWTJUY2MzUXNCcDFteURLMW91cEJR?=
 =?utf-8?B?RzZmTXpkNHdyOHdBeGVaN25GZ1pZZmEvL1o3SHV5VkR2ZEdxVTNEZ0FSc0RM?=
 =?utf-8?B?dU1zbTNxQkx6cEt5MEZNZ1lPcWwwL05nTHZaNWFIRWorMThZK28rN1J3WVVN?=
 =?utf-8?B?ZW9tYVBibHg3d0dPZ25aTzFQNjB6K0NxOTNPaDQyd1VobGNpbFRmeE5GTElt?=
 =?utf-8?B?bEw1M1BYK0NvL3hWbmhlalNORVBFOWtLa2JvbjFTbUZqNWEyYkJFWkRrTzFL?=
 =?utf-8?B?Rm5pb3M4aS9QMUFIem55bHlvOXVPbGNnejlFcDBrTmx4ejEvMlBXRkpXbnE4?=
 =?utf-8?B?a2FmZ0V1akRjU0c4Y2VlQ0g2SHVROWhIU29DT01yZ0pPc1R1MXpCbjlMUnh6?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5KrAZ21qR6mdBe0WTPlYUeMp/afnKopI5zfa2B/OHdQBBoCgKsHOH/6EKIB2dKh3lHwyBhNoEcVf/nOEM8kdkjw9HvNPCj06uSA+N75oHxtO6GdgGjqDkn6zKARz6MW2lg1PCRyPlpqWRAN4a0zScFVEXSk9WOCu8k0xiFO/Lm2XsOsU3K/WpjRSy/vqwbHhCbnID5GxJojNb71EYeAgC8truSTQqhOG/8Uo6YhHXYI6rBTW0oMNulNNjMb/GcVpYRSYnNyTzZTQdqrNZNz0yinuOx7VUpvj+p+2WU8tF/2QVMY9NoAKCOoU2WEZWr8GLDO6SP0/3m3PVJfGoplLqnQ69OU7imZMtFQanzKS2+1Mxn8LAnyfbeHSpULs6SyLJHyuw3PjjYaAq7B8E3qeY/bUkN1wHTPhqglfn4LHSWJz9PGn+UlNBWS9KyNMBk7d5FqIEPg+PCSlzvP+V7Jta6zmH7jbNtmWaPbHQogHIXe8FqJ+DsVSRljCfp4u/nLUdbm5Nb4Ef304MirZVgE2/567z4k9Oba8OoKNtMsQotx+DZZrxsb1FXUkYYuyrjEUcPM1SLeNowX/e4/xx4jpAm2DLgSIp3CHrJBNazFqs68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b9d88e-5ea0-46b2-d48a-08dd1f81dffc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:34:42.7373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyTovWTAyBGGtZUnnhOJUtXqOLb2ti8MfmDeJpXBVACKLcDlPtN/09TEFvHjKv7X1D/pWnscXq8atcXExKRifOFHiDuEZVH0iTtgBEBfMTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_06,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180129
X-Proofpoint-ORIG-GUID: olrs9c7KcDm2d4g1L9xJHmIKauRQ874B
X-Proofpoint-GUID: olrs9c7KcDm2d4g1L9xJHmIKauRQ874B
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

On 12/13/2024 10:30 AM, Steven Sistare wrote:
> On 12/13/2024 10:21 AM, Peter Xu wrote:
>> On Thu, Dec 12, 2024 at 05:48:03PM -0500, Peter Xu wrote:
>>> On Thu, Dec 12, 2024 at 03:38:14PM -0500, Steven Sistare wrote:
>>>> On 12/9/2024 3:07 PM, Peter Xu wrote:
>>>>> On Mon, Dec 02, 2024 at 05:19:58AM -0800, Steve Sistare wrote:
>>>>>> Save the memfd for ramblocks in CPR state, along with a name that
>>>>>> uniquely identifies it.  The block's idstr is not yet set, so it
>>>>>> cannot be used for this purpose.  Find the saved memfd in new QEMU when
>>>>>> creating a block.  If the block size is larger in new QEMU, extend the
>>>>>> block using fallocate, and the extra space will be useable after a guest
>>>>>> reset.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>>    system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
>>>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>>>> index 0bcb2cc..aa095a3 100644
>>>>>> --- a/system/physmem.c
>>>>>> +++ b/system/physmem.c
>>>>>> @@ -70,6 +70,7 @@
>>>>>>    #include "qemu/pmem.h"
>>>>>> +#include "migration/cpr.h"
>>>>>>    #include "migration/vmstate.h"
>>>>>>    #include "qemu/range.h"
>>>>>> @@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>>>>        }
>>>>>>    }
>>>>>> +static char *cpr_name(RAMBlock *block)
>>>>>> +{
>>>>>> +    MemoryRegion *mr = block->mr;
>>>>>> +    const char *mr_name = memory_region_name(mr);
>>>>>> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
>>>>>> +
>>>>>> +    if (id) {
>>>>>> +        return g_strdup_printf("%s/%s", id, mr_name);
>>>>>> +    } else {
>>>>>> +        return g_strdup(mr_name);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>    size_t qemu_ram_pagesize(RAMBlock *rb)
>>>>>>    {
>>>>>>        return rb->page_size;
>>>>>> @@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>>>>>>    {
>>>>>>        size_t max_length = new_block->max_length;
>>>>>>        MemoryRegion *mr = new_block->mr;
>>>>>> -    const char *name = memory_region_name(mr);
>>>>>> -    int fd;
>>>>>> +    g_autofree char *name = cpr_name(new_block);
>>>>>> +    int fd = cpr_find_fd(name, 0);
>>>>>
>>>>> If to use the proposed patch in the reply of patch 2, here this should be
>>>>> able to be moved to qemu_ram_alloc_anonymous_fd(), IIUC.
>>>>>
>>>>>> +
>>>>>> +    if (fd >= 0) {
>>>>>> +        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
>>>>>> +            error_setg_errno(errp, errno,
>>>>>> +                             "cannot grow ram block %s fd %d to %ld bytes",
>>>>>> +                             name, fd, max_length);
>>>>>> +            goto err;
>>>>>> +        }
>>>>>
>>>>> I remember we discussed something similar to this, do we need ftruncate()
>>>>> at all?  I think not.
>>>>>
>>>>> This happens when booting QEMU, so I don't think it's relevant yet to what
>>>>> size used in src, as this is dest.
>>>>>
>>>>> It starts to get relevant only when cpr migration starts on src, it sents
>>>>> ramblocks at the beginning, then parse_ramblock() will properly resize any
>>>>> ramblock to whatever size it should use.
>>>>>
>>>>> If the resize didn't happen it can only mean that used_length is correctly
>>>>> matched on both sides.
>>>>>
>>>>> So I don't see why a special truncate() call is needed yet..
>>>>
>>>> You suggested truncate:
>>>>
>>>>    https://lore.kernel.org/qemu-devel/47d6d984-7002-4086-bb10-b191168f141f@oracle.com/
>>>>
>>>>    "So after such system reset, QEMU might start to see new ROM code loaded
>>>>    here (not the one that got migrated anymore, which will only match the
>>>>    version installed on src QEMU).  Here the problem is the new firmware can
>>>>    be larger, so I _think_ we need to make sure max_length is not modified by
>>>>    CPR to allow resizing happen here, while if we use truncate=true here it
>>>>    should just work in all cases."
>>>>
>>>> ... but you suggested passing a truncate bool to the file_ram_alloc call after
>>>> cpr_find_fd.  I could do that instead.  However, if qemu_ram_alloc_shared uses
>>>> qemu_ram_alloc_from_fd instead of file_ram_alloc, per your suggestion in patch 2,
>>>> then I will still call ftruncate here, because qemu_ram_alloc_from_fd  does not
>>>> take a truncate argument.
>>>
>>
>> [begin]
>>
>>> My memory was when reuse qemu_ram_alloc_from_fd() in that suggestion of
>>> patch 2, it will only create zero-length fd (with fsize=0) and leave all
>>> the rest to qemu_ram_alloc_from_fd(), then with that:
>>>
>>> qemu_ram_alloc_from_fd:
>>>      new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>>>                                       errp);
>>>
>>> So that'll always have truncate==!file_size==1. Then truncate will be done
>>> at file_ram_alloc() later, iiuc.
>>>
>>>      if (truncate && ftruncate(fd, offset + memory)) {
>>>          perror("ftruncate");
>>>      }
>>>
>>> Would this work?
>>
>> [end]
>>
>> Please feel free to ignore [begin]->[end]..  I guess I didn't really answer
>> it.
>>
>> Now after I re-read the question.. considering that we have been very
>> cautious on the fsize here:
>>
>>      file_size = get_file_size(fd);
>>      if (file_size > offset && file_size < (offset + size)) {
>>          error_setg(errp, "backing store size 0x%" PRIx64
>>                     " does not match 'size' option 0x" RAM_ADDR_FMT,
>>                     file_size, size);
>>          return NULL;
>>      }
>>
>> I suppose your change makes sense.  So please feel free to keep the
>> truncation change.  I wished we could already auto-enlarge the file size
>> there already instead of failing, but I think I see why we're over cautious
>> on this - we want to still provide some safety in case some wrong file path
>> passed over to QEMU, to not easily corrupt the file when that happens.  So
>> we assume the file must be pre-truncated to say this is the right ram file.
>>
>> Though if you wouldn't mind, I'd still request a comment explaining it,
>> because it probably isn't obvious..
>>
>> AFAICT it's only relevant to resizable RAM and also the fact that it'll be
>> able to present now in fd-based ramblocks.  Maybe also mention the fact of
>> our cautious on changing file sizes on fd-based, but not avoidable to do it
>> here to make resizable work for firmwares.  Any form of comment would help.
> 
> Perhaps more to the point, for the incoming cpr memfd, the file size is not 0, so
> the logic in qemu_ram_alloc_from_fd does not right-size it.   Calling ftruncate
> prior does the right thing.
> 
> I will add comments.

After adding resizable support to qemu_ram_alloc_from_fd, I can also tweak it
to grow the file while preserving error checking for the general case, and
delete the explicit ftruncate in its caller:

     /*
      * Allow file_ram_alloc to grow the file during CPR, if a resizable
      * memory region wants a larger block than the incoming current size.
      */
     file_size = get_file_size(fd);
     if (file_size && file_size < offset + max_size && size == max_size &&
         migrate_mode() != MIG_MODE_CPR_TRANSFER) {
         error_setg(errp, "backing store size 0x%" PRIx64
                    " does not match 'size' option 0x" RAM_ADDR_FMT,
                    file_size, max_size);
         return NULL;
     }
     ...
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);

- Steve

