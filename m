Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B97109B46D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Zl9-0001vN-Cr; Tue, 31 Mar 2026 10:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7Zl7-0001uJ-Ib
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:07:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7Zl4-00043t-N0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:07:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VDE5ej031016; Tue, 31 Mar 2026 14:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=QBax5yey5JUfRXdbWF1n2Q/lPX2xsPUz3UdsyxJyi1Q=; b=
 m5Nllsui7ZvqNF/bZTBp+XHd2FneHFTG0OwtrWaRoTmeOho2yBTtHPDdVDC4vaYX
 rO7Pw0NU0TPxJl7cq7ITQ4NpqULYAgD8u+lka0ZgQ0iT5KR1lfucXgkROdQiTwS5
 msdwisb5g7QOXHEISr8GjF4ypqFfwnO+PPPhYM1e4J5zqHik9Uvh2zmaOhaY+WKo
 hFTL5umyGWEdOA68IQQFpvjHci4MRV5PnRsWEI4PI/sdE3VeKmu1bJI3ww+vydBZ
 18DdycfIrygQuUrdYJP7D1ukGWDt4V4LTBeuwUMzqF56c5M5bxF37V+wQncuhwe5
 7m7LLwbelLsjKY/G/PA0qA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d67hqc7js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 14:07:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62VDRiZ7008088; Tue, 31 Mar 2026 14:07:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65ea7pbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 14:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w28dinCvFyoXr9/K/YqPgXcf/AcrUpKiZySj8+BtCxy3JloWJW5Dq62m0tAunXZeKcjjDXqClCcS68EElINndE3d3SSTWAlT0uQ1I652ANklT3uLqZyXaLzCnvZsMehzcTthYLs9FGLau5ihttXcPnHICkefZEDctGO0qTNe06ysNtPdP58JfZ1FownVSQ8JmAbBXCpXNRmOt4opwFd/HVQKY5CnC3DoH9szntnb5fxNIe7JamI1iqQvhsIKDOT0RgjbptG+eJF39fUiflw5BIwxW5eg+OiXAKL7vy4BY+8Tvt2ayg8LkUqyBcMzLe0Sryz7LK3hyTR8IknjMA49pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBax5yey5JUfRXdbWF1n2Q/lPX2xsPUz3UdsyxJyi1Q=;
 b=W+abXn2ejt4j93VkUqnnwC26LcciUBxJ04KI24wW79AGEehfjCaigdPefPjJKEJy6rCZwAeSSlghR2nPlEQD7h85ZxGmMlOFib7HeBO4IvBd2zK0kBykUrI7ulWtx5wZqfKYNromm/XCfQlFSnx/kHTMFASjJhiuKuiPZSNeitEkwjKiKgNBz3B8EjOpawg0M8aEzSt6DMGAZ4bmqJeTmDRLtUOv0SZktoHWUYwdBcHox93liM0bFdWXk/C+VIC++n6Z9snzkgjjmcrkJhev9cnG7iGjBi3j+pHmNFbsjvRs5rFVGKEYflaiqozifKG6KYL6xeMG6Rg04DwfSTVP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBax5yey5JUfRXdbWF1n2Q/lPX2xsPUz3UdsyxJyi1Q=;
 b=WUrXhnJVd82QISxYeW9xmWVCiCS7NKibxxs+PUbAUOTKnpoZ81U4s8lycTSPP+yp/g9sOnS/h5HdkgkqAaNzY6hYqqQ4FFwq3xMAnhG5+Md2zqtnvNn6+eieyFHZ/gC+bRr1R4FgcavNGeBVcH1O8nOwLTo3GNOo/WiYMVckguM=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA3PR10MB8322.namprd10.prod.outlook.com (2603:10b6:208:576::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Tue, 31 Mar
 2026 14:07:41 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 14:07:40 +0000
Message-ID: <709d96a3-3e9e-4e18-8c33-65500298fe09@oracle.com>
Date: Tue, 31 Mar 2026 10:07:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/2] amd_iommu fixes for 11.0-rc2
To: Peter Maydell <peter.maydell@linaro.org>
Cc: mst@redhat.com, sarunkod@amd.com, qemu@demindiro.com, qemu-devel@nongnu.org
References: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
 <CAFEAcA9tmFbxt0Z6GrvMGz38=S_MWtMA7W1P2wVD9seSajchpg@mail.gmail.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <CAFEAcA9tmFbxt0Z6GrvMGz38=S_MWtMA7W1P2wVD9seSajchpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:408:112::7) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA3PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: c534ac58-38ea-4c3d-dcde-08de8f2edf0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wcM7ff68lDkqFWigrQIkQ5Z5L6IkKt5gnBkO60irknCeRRTycK5bP+W3sLGwUJecDEl9Fn64lxkpuov1XWYQfcKtLVElt5lmSPSkdR1IZQY6NPSvg23jdSqupBIGc4ET9egoPWl7lIxDWvuFC0LI68GA8o9OkD8j5cdxgWIDpi6dLvvA3cdQCfvnfBbDPyvi5m9emT25CKb+KIZUuGFIk/RA71BfPetJL43khSPk0zjIXlgMW7wo+i3GA/xGejgYCMusi+2+Xn6mhi8ViXk/s1UENdBfv1Yxxg7xPNOYTz/Sq2Xtxm5U2pF+G1hh2CA/vHtMaZE9XW5WzSl8j+AjzXTqx2tOlFOkOIerkIzeYmJ1bZuH8S+BBCxcOZK22qMZunfnZZ3/do9yuESxlBIOcb6Hn5qbXOa7MphCv/wIOlvdQ3CXKMFcO3yOI8CuzlTygBlIBZ2dwCvueH0SHrK3/DW09Spj/SKwA9V0WGTPJ4MBkfrU7S8TGSBRiGqCoTxP/2gotk8BgnVC9SxTwn2NZGO/eYyvMjLxuyZG4yrV2D5LUwYrQDnWL2FVLzfvcnRcoEdk+D8n/D+a8rotfZMMyHbGyoLIbmU9/ycDqoav3FiWLXgIwGazCJPFxtmxyP5CB/PKgdtBCbqzDkNb7zE5kvimLTOT+evid+NHrP3j46IoMQvk0j498kw5hpWjeyVz+rOEe2kDNqTwz/gb9V0nlJ6J3wtlcCf5mA7XcVIDguJZRvfY+fdNsy+9EaZeGNNh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dpaGpYTGQ1b0hRZ2RPTldUWE5pUG1MdnlLSnZRcUhDbktrU244MnlrdCtv?=
 =?utf-8?B?R3JFeDFkN0lMV0s3enNIakJHM09WWERTVWN0czdld2VnT0RFYmJ6TENjYmRZ?=
 =?utf-8?B?UXpweE5uM3dFQ21kS2dpbFVoT3FJQ29FRTlWOVpRN1RRQjMvUUpMOG5XWWlv?=
 =?utf-8?B?ZXhHcTlzcFZWRXZTYlIreXlOTzVndU8zR3QwNzl3UmlGYTg3MGo5T3R6RkF6?=
 =?utf-8?B?c0s1bFg4YVVOZHFVWlhWc1diam5aeVZUSjRodG5aRjNhTGVFRTI5aFJJVmNT?=
 =?utf-8?B?K1g4NTRyVCs4Q0lzUFVSN3hhL2pvQ3RQSERoelpJVUdyeHJiN1F2YlRjWXdG?=
 =?utf-8?B?SEhWSUxTK2hEeDJrVTlrL1YwbE5JckdEZVBNOHgva0pEMFNYSm9VNmRUY2FQ?=
 =?utf-8?B?Q3FERUg4RFFma1ZUSG9XVSt0Rk5XQjlMeDVzZ3hGZDVNL3FQSDFtWXpTU1NV?=
 =?utf-8?B?T09ibDU2Sm1uYXU4YXlPU3hwNnJnOGtSZ0Zxb1NDUVpHam5NTGxEM2IwZ1Ir?=
 =?utf-8?B?WEVkRHFtL0FnUnYva1VxMzFtTTU1TWlwNE5uRUgvanN2Z1dYR2pCNlV6a0pi?=
 =?utf-8?B?UkFFUlEyenhhbjZIalg4T0pGbDNnS0QvVUJVcXowdjUvRlVMa2ZZUEo0MW9G?=
 =?utf-8?B?R0hOZDRGdVVYWTNBdjBseUZoVld4SFdVL0xESzNPSUt3NkhaL1FManNhUlA3?=
 =?utf-8?B?Z1RseS9OMkw4T0lXanVPcCsvTmF0VEhhSEp6eExXa1JnUE4wdjRvTkhoSGVC?=
 =?utf-8?B?WktKRTJOVGNSNFNObG81ejhqTlVYQmdETDBmRXgraVZLQm8vaW15WG1NSW85?=
 =?utf-8?B?SjJJRjYvUzliQzR1NE1sOE9rNEZxS3FLb212b1kzeHBmZnM0ejBsNVVhTzQ3?=
 =?utf-8?B?YVdkaHVwditpTGw4SStNMTZCRDl0WlBuV1ZaMVNNa2J6VGJpMnNTZGt1TTQw?=
 =?utf-8?B?R0NrVnBuTmRYNmxWSG8wNmhSRjR0b1A5NEtHVUdaOVZwWjZKRDY1bnQ0K3dN?=
 =?utf-8?B?bkxNb0xTRXU2RlhEaHYwUVFROXVQVi9KSXN0SVZNall6Zjg5TmFKQUUyUkZG?=
 =?utf-8?B?aUhlZGpadWtaUjJYQ0gxUEJ3TzdOTTlhQ2xGb0xGSkFUM0pjSlh1a2xWU3B1?=
 =?utf-8?B?VEUxU1h6cmpFZ0xnL2czSVBqNWFJdCtGZTByUWhLQzBmQWdIdjQwM2hoRHdG?=
 =?utf-8?B?K25vOUFBOXIvdXNZK0tnZDZyclVKZlorN2ZCQ04yeUFGN2V0d3dMS3JEN05v?=
 =?utf-8?B?Nm9XbHBLQ1BSV0hKQmJJWU1COWppL2lyb0p5MExSSW9uVzhWNkxOWWRDa2VX?=
 =?utf-8?B?Zk9RSDYyeVBKNkdhYUVkVW91VU1DZWQ1bEVZaGJmb2kvOWJVVWJ6YUF3cUxn?=
 =?utf-8?B?ODI1cGtHbFNlb1gyb2NaNDRrZ3RsVDkzOG5MbytaR0UrRUhVYW9tSGRGQkhi?=
 =?utf-8?B?c0hYS2xKajNhUTc2N2JYaW9YNmJtSkM4dGlXa3V6Y3FQTWMwZ1hNcWMyWWxE?=
 =?utf-8?B?aDBnMERZY3ZKUkdvZEVEMWZUbmhvOHpKN3ZDVTdBd2xRUVFpN2FOT3M3Ri9p?=
 =?utf-8?B?alJXajF4RnhHWnNxb0VabFVGbWNpTzZuTlE4RGNTcnhLZkFITkRjdE9PTk1y?=
 =?utf-8?B?YW8yRE4zT0ZLWGNHaDlsUzFRZWJURUFoYkN0VFEzTW5jbnN5aGFBUkQ3bHlW?=
 =?utf-8?B?Wnc4Z3JRY3VxbWpxSi9HSTF1UnRnNEtRcklGaEVad2dYQmhoRjhoVVNZaWxP?=
 =?utf-8?B?YUFlN003V2wxOTlXSGticytjODhwSHdNcy9RZkNMZjAxUVo1R1N4TkNvMGhE?=
 =?utf-8?B?QVoyNkxjK0tlNnpTLzdMMDBub0RHUFRteXIwUk5hRjd0QWNWdTdZV2pLZUdN?=
 =?utf-8?B?Tm0xU0VkNWY5bGN6bG9rL2UyUThHMWg1UElaYk13UUkrblVqb25nK1JQcWZP?=
 =?utf-8?B?MWFzSW1qSDlXK1grTnJPaGNWKzJ4SzdRRmdRYS9qRVVvcHVMSUhmVXJFN01T?=
 =?utf-8?B?emg5NTVzRHVqczFQa1FHRTFpa0R6VTMxcFJjY3l4OFIydW83ZnN6akZiNFV2?=
 =?utf-8?B?Qy9JenJHOTdVWjBMMVd6dWFyNGc5U3k5V2gvQTFvSENhckY0R0EyVW9lNzFG?=
 =?utf-8?B?VDM1ZHJrTDF2ZzNielg0ZG1Vbmd1ZWZyN0FsTHRXVWhlanNqQys2MWJXZDNB?=
 =?utf-8?B?NlU5ZWNJSTdwdUlTbUl6SVk0eVdkNGZYYldMMk9Od3NjNTg1TDUzWDZUdmc5?=
 =?utf-8?B?RDFBeGM3Uk14RExlRzltSjYvVmpVeHp0bk1tQ25QT0tPTGU4cUJTWmtkZHRh?=
 =?utf-8?B?MkZrbGtJL25vWkZWUEpNc082ZkxHeFhqbWl5UnByTVgzTE54cjh0R3RBWDU0?=
 =?utf-8?Q?RuDeCUa9KSfVp0V0BewUyXAaGzl8CNLGpqFxZ?=
X-Exchange-RoutingPolicyChecked: A3R+ams389r3gVWZssnnUhgfFmnCqCJ0nF65f/BAW8BDznrH0wzTTFwMIVM3QhRvW8boW/y+oCZ6EM/TVyOKBeRDjzUMxp5aMZOv2nNcybthrNeq9ZCYd3C1tTcIgWedB2HTticoPQH3tcxcrMUhboBDps5PHpMZrsDSNdrZDbh3NKBQlKxta/rTUTHxvCeFRM7dwFjDZ3OEyFMGOX/gwagYtv5cK9OEIGM8c69xJpIf6i8wMY3kH3yd1CEA5FpKnRMiwwsqtYZFyZWiyIHJ6DT0ZZG6Stx/cyzYcGW88PGw6Qqnp8p7Z7Ogc34u2d6W94sOJ9G9DgXjyq4PhYj/GA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EkhGyzZu0vLFxXS66GfXoExT3bsmRdjkaoXnK7r141gv+2P+FBqipiw9sYRinOBT4Z4KMmRiZi7rPDDaDsEfjvjQAkfhmNr0gE7kPOxTlGGrlU+wBN+4o5gcwcI/A/qn8Cqq648Th6MO+5Jo85hvqMM/yKZZfYJSBVoGIsT2rwnGBjQl/AY+Fm248eqTBwPX661w5pEp0FVhC+zinhnPR8HG3zFRGcLCQOSbdWh7XpQMDwRPGb4E+R1z0s4v+wTr621MkoAcxoXTJ9kx5DtEzotga9IBZsP00HWuLoOmxbacrz/bQVPSM/Ez0cT982jdxo7Xn24qWzVDTOuM/nS+lw8cCvgoeJFGibCjwoP06EBFsUFGwZqUrUNvkBNqMKc1w9TrMQzVO5SUCsKJ5VrBG96JVThDDveYFFUSSixGYWVbXqG4oH5o+A7pmKj8qspIwxNOzpUJQBMZu7fjCw+4idET09BRTw3akgCFrxxkTGiCshl5JOPE8fYZ34NVOim+Vt1isNnFrdBCE39tq8yLhlkT2SLpu+75Ft8II0cnEcbJeb5nDhnpo0Vmd8WTjLMUko6+ccFfFvhG+SncNBf0akO86N9PsY2grxRWoxQs+Rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c534ac58-38ea-4c3d-dcde-08de8f2edf0f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:07:40.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XmXG2OJw4Zj5XDnVI+sGIwCyLOV+wJWPi4s8vv9WMz3W+GDr+mClPjymQc+v3izlaT1uL79DloMj4NstWMW8fSGCXbDhoT0nauNBG1wcsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603310136
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=69cbd533 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=RWxpEp7VAAAA:8 a=p0WdMEafAAAA:8 a=yPCof4ZbAAAA:8 a=jBo449p8YSOsO3h8NNoA:9
 a=QEXdDO2ut3YA:10 a=3unh6Pbajv6CBnL1DxgC:22
X-Proofpoint-ORIG-GUID: i_Kd1g5CvWzt5BZ5qzoReqGuQk24B_OS
X-Proofpoint-GUID: i_Kd1g5CvWzt5BZ5qzoReqGuQk24B_OS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzNyBTYWx0ZWRfX9rUqQelrDko/
 dUecoh4hfnhU2dm6/31ZrMnuDv3vcH5fBaTVT+dwrh4Jzm8f/zo1FLSW1you5v0L2BedusMJ92a
 ogRBbgkzRRUn2pyEkBcV9ZkHrK3qyHB3hpY9ATfmbW/kgOHbT5UGLzTMkHbbKJcUop35nuo7G7G
 BtVC0olhtuF3CFtuXFz9ZZHlheTv8Gr6nlZZEJZ9hVdlLtrB2iALkUIGQXAVKcmzIH4450cWxG2
 DBQJLND0KkzD0H39Ck3NORvXrmni40K2iiBGmIDdnoyyHiv3MjoSlreQpc503782PX/inb5tXbh
 +rLP/sgWndJ3DjLEmLI9ttZZO14qf32JrPjGA3KI9a99Lra0xNaQOLpB8b8XaiERGxmS4On3VsP
 A3zrkIaYJixyDZAqWFTtH9aohIq/zvrdIKK4lKsAgMPB7zgYxiaNexe4zD/lnww9dhllFS+h4ct
 mgLIfOCNacGfBaH/uSA==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/31/26 4:39 AM, Peter Maydell wrote:
> On Mon, 30 Mar 2026 at 22:29, Alejandro Jimenez
> <alejandro.j.jimenez@oracle.com> wrote:
>>
>> Hi,
>>
>> Please consider these AMD vIOMMU fixes for 11.0-rc2.
>>
>> This series fixes a bug in the current page walker implementation.
>> When triggered, the issue leads to extremely slow boot or hangs and missing
>> devices in the guest, as reported in:
>>
>> https://lore.kernel.org/qemu-devel/20260225145831.28275-3-qemu@demindiro.com/
>>
>> Thank you,
>> Alejandro
>>
>> ---
>> Also available on github:
>>
>> The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:
>>
>>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)
>>
>> are available in the Git repository at:
> 
> Hi -- please don't send pull request emails to the mailing list for
> normal patch series. It's fine to put the URL of "here's a git tree
> you can find these in" in the cover letter, but an actual pull
> request email triggers tooling that puts the patches on the list
> to consider applying directly.
> 

Understood, thank you.

From now on I will remove the git request-pull boilerplate from the cover
letter, and include just the URL, tag and summary changelog when sending
the AMD vIOMMU subsystem changes to MST.

Sorry for the noise,
Alejandro

> thanks
> -- PMM


