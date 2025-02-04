Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9622C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLYu-0003q8-Tk; Tue, 04 Feb 2025 11:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLYm-0003nF-Cu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:14:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLYk-00070J-Is
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:14:00 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DSIxV013476;
 Tue, 4 Feb 2025 16:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Vi+ZB7hP4hBl2xdFLgl8TON2dZfxG31mgh00DR5NXlw=; b=
 Rk86fTNGAS3FomnWzlVKWAXAONOIXy+GM/AgZM95wJQPllmkHSiP/bQRiaOkcfg4
 GCLtk8/PBaYvVSxjXDVf4ZPwWWqFSdJ3whkUJVvB8JgWD3IspD/ksybv1H9HGM2E
 UQUyduBgG528EocsZGYWQS3PCwm0l31mDBpdF0Ut1pJ4sZWPIEzE1o2tyXf8SXeM
 Kp8MLRogl4fh0qL4YS5w6s9l7GIDen0A3s2MkWv6+AgYKiDQai0dC89ogDEtaZ6Z
 b+A62y7cDwasMRTWTK/7mcL4+VZlQu133bo2InSxh7lobCy60NEwd+lP5F1Pk4gv
 SBaXJ0AO1IoYu5pHKE6jLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgwa9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:13:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514EpcRB038882; Tue, 4 Feb 2025 16:13:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e7w6d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii7napuZMORJv1wEtCGbA0CDt1Qho3IgBcLGHlmVrs9qMYy/G9zIPoN0whAQBl18WEKxd6AeM1t3z1mlw1PyJKRci+MdHMpp+q31GnOuIZJs5eUyY+zqvDct+CFbNzUPjuhzgsla0OAhlgdK1tilyrSYcjRZA/n3nsepvkxqS5/wlug58Lzuu3pg4rvSeVU8J9DshXwvDvrMR02+UJyI8wubf1x/PksHJPSCdxarA6J2OSmpo+r1Cm5IxWpnWfa4LFEIcwmA9nh4wBNwRAHByhe/NxL7v3tJT5LcLhzncu5bJW2sTyyLGhEt/cxbdX00pcPJ4zP018cAsnkB3rn2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi+ZB7hP4hBl2xdFLgl8TON2dZfxG31mgh00DR5NXlw=;
 b=cWQacwqftt+ZqhqwkI1RNq6hQ2VqvHfSN38l8YqKy86FPnC1KoZuPxASziE4F4FXxJ9fTRzCZWf4Qcg+5sG0c+PtzxadBlBLblgljH69Wxo6atuyloF4aE8AGeZJdhwVFl/vsHUv2hJst6Z0hKFjVJFC6wj0AvmRMobaeO4NqC26SJsO0c4r7SspKazh8BRi6+yL0gqZgvlp+9zeA+G9x765JKeQX9Jz7cokWhEGoC8ounm1SdlP3iFHvoD6v/CyAqcAZRyoeJjtE4e/qhYINwHfSA6CC665aRTZRfQTJxcc1ZbAIkxYTdH73LrXQ6Pwl6qbM3ibb+tihBOlBNUhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi+ZB7hP4hBl2xdFLgl8TON2dZfxG31mgh00DR5NXlw=;
 b=O1DTtJeuSAXpWCTeWF1jpvwiiZVVVWuHCqPGomj3FkTsLydK5K3VZQMwFYhghmNzbdzK01Dmf9fQeiW+aoSHbGh/GZm8BX9NcbQZfIwn4e5soT4Q6/wIseKB/9+nB+B+W+0lru/ivKdthd8ORq1hFKgF+oZ/0VtqA7LZtXEk4eM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 16:13:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 16:13:50 +0000
Message-ID: <75cdee91-9306-4f85-96f2-392f187d1778@oracle.com>
Date: Tue, 4 Feb 2025 11:13:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 08/26] pci: skip reset during cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-9-git-send-email-steven.sistare@oracle.com>
 <8d675900-2a3f-43f9-8e54-331934c7aa02@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <8d675900-2a3f-43f9-8e54-331934c7aa02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7e8de9-83a0-48f3-fe5a-08dd4536e963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHZXUGdzTHJmRHRScUhhUkFaN1VRUXMvR2ZvQmhsSEZSSWRXL2tDL2lJajNz?=
 =?utf-8?B?VjlQVUNTTDBNZkJFYUNSRkFyU01iNEZZZzNoS2dVeHRJK2pQZnl1TzQxb25D?=
 =?utf-8?B?NDZMR2RFZjNNVlJ4bzZxMFREUFpPdUoyRi84eEZLVnRVcVlGMlpNTlQ4TFZR?=
 =?utf-8?B?YzhOT01ZN0oxYlh1cEkyYkdSc3lLRWhENVVtUDdtN0U5WXBWbzQreEpKamd0?=
 =?utf-8?B?QzZoanFKYjFTckNVczloSmdMcEV6bHE1WHN3NWtSb2Q2RXpWTk16RlY5MUYz?=
 =?utf-8?B?djBoTjh5eXA3TnYvanM4YzhicVl2aVp0S1VaYzQxeThPZXhyWUYyNFg5bGxU?=
 =?utf-8?B?b3E4L0w2SWVwUis3QzhvT2dyRmtsVXlKMTRFMnZEdDZaQ3U5Q1BTT0QwNk9C?=
 =?utf-8?B?bnl4VUdvdGQ1Misyc3pjUllJOFIxUGJSREVBYkc5ckRFNU1jb05CaUJ4Mnht?=
 =?utf-8?B?bEJ1cW1jaTRweWJKbjcveml4NW9BRHhUV2w1bnVkUXVuREM4RzFwZEhkdEYy?=
 =?utf-8?B?YzhKUlNsSEF0cUtRNE9JUmZYVU5aSjZHZTJZMjNJdUZqamxuc1JzcGJaRHFS?=
 =?utf-8?B?QXIrT1NTcDlhNjdyazFaN3pDanpQczNoTlZqbCtXWWV6ZFFBbjdNNk9YeXFS?=
 =?utf-8?B?dlJocVlNTHliL1NaQndqT3lhc3Y2NU9UemtWMnZkRWxOMm0xM3pZSmd5WUxZ?=
 =?utf-8?B?TnZFNEg5MVNhNkJWNEZ0YlFWeGlicjRsTzUyRHJhSXpHS3FCS0wvZ0xJdzlw?=
 =?utf-8?B?K1NqRFNNMFNrMThHNExpRU51UmY2RmtEUnYyeHVKY0g3ckp4YW1xM0FrUkYz?=
 =?utf-8?B?ekpJT2tuL1hnSzVrY242TzkxZC95ZHBSY3JtRWY0Wnkvb05pNlpsZ0Z5ZG9x?=
 =?utf-8?B?MDEwQldVY1U3R002bFdScWJWV0NxNmlnaXhSQnEvbXIzYjRtVVRmaFErQmNt?=
 =?utf-8?B?dEgyS3BEUjVQbXlwWC9RRlloRElmQjlYMWdTMGVlUVpkeG0wSDhRWTd4L3di?=
 =?utf-8?B?VlZjbEhtOFJGQWNqRTh4Nnp6MDRueUFUTkxEN01KL2UrdXYxcjhDc3ZmcFBP?=
 =?utf-8?B?SEQxaUxzZ2FxZmtwaGtwYWs5TFhUN1Nack1xK1VvQ1JyOHpXanVPWlFpOWE3?=
 =?utf-8?B?NTBoTDZLOWFIa1UyaXFmUWJRRkxVSzFDSEE2NWJOVEpxL0o5czhUVkVCV0JR?=
 =?utf-8?B?eXJaUlJwQjlGZTF5dGZGd1FPTWp3Y2hDUEV1ZEdNdzNyZVJWMDA5OTZqR3h2?=
 =?utf-8?B?T2FacmlNU0dJZG1PTjU2b0R5TGR3T0hPL3NhbW9vNFFRMEZqNGxYbzV2SmpW?=
 =?utf-8?B?MHJ0U2t3YlVrV1dneHgxNFNScVlkWXdldW54d3RDaTJreVJRby9Tam5wdkRm?=
 =?utf-8?B?VjdxMktPRmVFZ0txVFRrZWJ0elhEUUI1MWFWQzZtRk12R2NQci9TeDIrV3dG?=
 =?utf-8?B?V0JyQldpNnlRZ3FTOUdJOW11UDZZZVFvKzh0MmR2K3FaczFTc3Z2OGtCa0hy?=
 =?utf-8?B?VWVOb2JRSHpHTzFrdEhqQzhkdi9HSUtFWjNtM0dJd2hSWWwxcklmK21tTWsz?=
 =?utf-8?B?ZTBnMi9aZTdlR2xxN09vZGFvTUJCOHIrdFh3SWY2V0Q5cENPakRlc2VaRnRF?=
 =?utf-8?B?ZTJlQmc1ckdDWE90VGw0bktyRWM0dTdkcHI1Q2lieXFFblJZNWdGeDZqRTRs?=
 =?utf-8?B?UE1yT0k3YjYvUG1oem50Tkx6UUxZVXhoWjIyOVhKL2ViRTNWZUtOZlNKanZ6?=
 =?utf-8?B?amc5WFczNkxBdmxrTklkNjM3ajdWQzZGL3UzbjRGOEdJUGNlZDMzR0pKcldu?=
 =?utf-8?B?SzBGVVhOSitNMXE1QWJESG9JN1oyMm1oYTk4b1gvSVE0VzhOZ0Z4YTVBSUxH?=
 =?utf-8?Q?NG1DPlDx9aHil?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEQzbU5odHBvd3J2c0VrMXg1eFVsM1RlaVhIby9WUWRkRCtVdFI5Z05ud2x2?=
 =?utf-8?B?cFVBZ2FZNnZJYkg0U2ZjckRhR25LNnFlMFkxZHByRkZyU0VTbFcrOHQwa1ND?=
 =?utf-8?B?elFBN3JtWlFEYWx3TDUzaERmZ0IvZVF6aDlremsyb0FkQlo2aXlBeUU2VTY1?=
 =?utf-8?B?b2tiTFpuWVgvTDg2TGFXejh2d1cxaHUvdkhvWFEraWJabVlGL3o4VjB6emRk?=
 =?utf-8?B?enF1aXAxWEpxM3Y2SnBKQ1lzS1JMRWl3ZW81azdZSVhPZ1U5N1V3cFdyQnZN?=
 =?utf-8?B?cDVKZ1N3UUhKa3RTam9nTkwyWWVyNDBtUjN6RXRzZDBkellFdForR0w5b1dQ?=
 =?utf-8?B?QTFTS002OVNQV0pSMm1aSFJ3MmZNd2thbnpMYmlDcytnVXBtOXplODdQSFFI?=
 =?utf-8?B?QVNsZWpCTlhmZ1g4dGtpZHJlaDZndjAzY3ZTSk8rblpsUUphL0RVdHdXTlFW?=
 =?utf-8?B?ZTZpcEwvY2YwcFcxTHp1Y2ZtQktVSXAzSEZRZkEyTzVQRzJscGNlZ2RBOGRC?=
 =?utf-8?B?NENzbE1mSmxLSTRvZ3ZTMi81b2dZZFRwSzNCdlFNQUJiQ0ZYNzRtTkEvZSs0?=
 =?utf-8?B?d0wwRC9ZSW1sb2FzVjlPcFE3OXN2blNLZzR1T3ZFclpiRTFIV1I3dzMzL3BE?=
 =?utf-8?B?RWxNdllHZkVNY00xaUJEb2hKWjFzNzVWUDNkbFhlYmt1ektrNlVHRGZHR0la?=
 =?utf-8?B?WE9DSFp0R1RRUXBpK25wMTBZNEN4T0lHTDVzOHBDbThHT0ZQYkhHZVpJSUp1?=
 =?utf-8?B?RzhFaXZ1QTVjZHpVT3Z4YmIwbGVKSnQrR05WWHJoenZVK0VVSkRCU0ZBd0Nj?=
 =?utf-8?B?MVFIQ2s0bEE4cC81Y09POVQwWks3RW5UdDRHc0x0QVErTHNnb2RKMURZWWpz?=
 =?utf-8?B?cVdkZHM5Q21jMzdHOHd6KzY3SVdHTzg0VjZOYVF6MkhKUnQ3aG95SHFVRlJ2?=
 =?utf-8?B?dWF6eW1PODRGNXY0ekNFNm55Y21HVmNMd1VBZXhDUm90aEdFNzlicnRqSFA1?=
 =?utf-8?B?ZW9pb2J0UXZDbDlacU52cXpQME0remVqZ3YxMXIvRXVYQndyOUcrWWRVKzdv?=
 =?utf-8?B?TkJlMDdUbGRUSWtGSTRMZ0YwUmVYUG9NckR6SFB0NFZaU2VBbnB3MVRvVkhI?=
 =?utf-8?B?M09xSmxqaFA5ZGVXeGxnUnY2aFIzODE5UmVUU2dzNzJoUk42NHRiV2cwVlNR?=
 =?utf-8?B?VFJkbkJ2Sm56cThkdWRuZHJLRHU0L1h6NW9YdU56ajNNUXpac04zU0JNbGF6?=
 =?utf-8?B?QkdvUElMclFBNVJDR1lyOXF5bk5weXFZTkNZSko0QTU1TzBMdTdvOWFNaE03?=
 =?utf-8?B?eUFucS9hSnNETzFyekxKaWNHaDRDY3BKYmIxS3pyL0JmSGFVaDZ2SFQxRG9q?=
 =?utf-8?B?dSsxY0tNaHZWdmplTVFFbm5FT00xQjlYVEhhTXBvM0hmQkFJYWdjNkRCU1J6?=
 =?utf-8?B?K2VxRGVpTGo1aVIra2hNZ3JKNmVMdUFSTlZXMFAwZW51WDFpV2NYRExMSzFQ?=
 =?utf-8?B?QkswcXdEc3lWWHB3aHZCbWpUcGUyWWJDYnR0MFJVQmpVYjRCWCtES25aMlRR?=
 =?utf-8?B?Yjh0aG8wNmJhODJTbnY2WEdFS21ONk1wOFdYRTFkWU11a3ZjQ0ZKRHo0M3Az?=
 =?utf-8?B?aFJXbGFMRVViOEk5clVmYWtUZjRHUFhGYlFTSDRsMmlBNy9Ma2VhQ01OakxO?=
 =?utf-8?B?dzJQeGZhTTBTazBwUGZyazdaUThWNHRIanc0b0FvbEhCa0lLcjJjbWFXR2FR?=
 =?utf-8?B?MmR2RWZvQ3ZZa2tidGxhRmFpbmlldno0dm5JZm5pQVVweW1wZEtDbVp6SW9Y?=
 =?utf-8?B?SElsY1pGNW40MWJnUW1zRkQxbTUvQUh6U050aFJGSUFMcDgxTmErLzM2NERK?=
 =?utf-8?B?ODlYWE5kYVZvVmJaay9NRUp5Y0wvUGY0WFYrQ2x6VkpUVDBhbTFnaDNsSStC?=
 =?utf-8?B?WjY3L1dob0ZUWW9kT29kcWMvZ3BHL043ajhUaUN0Z2lxU3ovWmtXYnpnSHp0?=
 =?utf-8?B?WUJvaXFmNS9ZWkE1dEtQMi9MTUFFd25hdjl4NGFLbGR6YWUyUUVIczY3eDVF?=
 =?utf-8?B?N01zcDZVUkNTMVZpamdFTXJwOFJGRVpxL3VvUWp4VnU2K00veXk4OVQwYVFK?=
 =?utf-8?B?SGwwd3dmYTdvaldyUTFscndSa2d5WUU2bU5YVFVKcFZrWGQ3TngzQzIwaUQw?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SYrPofQpD/mi2VWtlCrCanusKIEuIsSoGrOy/L1svR6DZg00gMxlNQaAsqWwzbzrkuMaEheOFmNre4UsegLNZCmUA8QqbEzoTRpL02Rehjsh1k+drHjm9tAQ/tU3lK9TwTAUJVrPmzfGkkQA7hao/7Lt0LXJhK5MAQ/OvqCiUpQ/p+yHXnyVSw+b785fvmMQ6xnV5mk7SQImI7z1Ie2z9ojkdApUWa4eRiq1FBfdSIN2brJDTZ5rDQ4jeLFBc0Z7K2tVhlHTyV9gPSyw2hApUGtjBdWOR1FjYW8UuWaTEx2k/IFsDcC+65Ss0ERDg7f05Aht1buCYE11Wig+3J+6+cdaR4QWFbc2uRMxOyQ2oCtww+kSDYBRvXGQtfoghqlAjKKWKbwpkZga9ufQPJ4Jk8rKPLUPuieHUnr0NhrtdlMh9jLmEMBAKE/O1xToO2HTNy1E7H+Yjp08EoUhQskXtBe03kV2MD40SAmdxZwz+mnOn09f1urmkk5z32/oRXgvnro1dUXGBKRBSmuOueHtLjz3BX8Hb0PQeU+xbjLfN5VeK7Y0PXBYwVkVzuo76MECzCQNtXxjh6/bfIpEW1yg8/GYp5NS60ek5MbEvNTs+0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e8de9-83a0-48f3-fe5a-08dd4536e963
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:13:50.4566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jV55VEZQLMG93F2upMGcgjkU2K8Octs0P37bwpWVnfGJSsijvmpiu499Z0wT/RHOOZwa0Hpe1PN2rugPrSTmvrWxIvzy0uDBFvL+82vKG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502040125
X-Proofpoint-GUID: DJA4Xyr0f3VovvHyHOVS2QpcCmpDSYIr
X-Proofpoint-ORIG-GUID: DJA4Xyr0f3VovvHyHOVS2QpcCmpDSYIr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/4/2025 9:14 AM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Do not reset a vfio-pci device during CPR.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/pci/pci.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 2afa423..16b4f71 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -32,6 +32,7 @@
>>   #include "hw/pci/pci_host.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>> +#include "migration/misc.h"
>>   #include "migration/qemu-file-types.h"
>>   #include "migration/vmstate.h"
>>   #include "net/net.h"
>> @@ -459,6 +460,18 @@ static void pci_reset_regions(PCIDevice *dev)
>>   static void pci_do_device_reset(PCIDevice *dev)
>>   {
>> +    /*
>> +     * A PCI device that is resuming for cpr is already configured, so do
>> +     * not reset it here when we are called from qemu_system_reset prior to
>> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
>> +     * safe to skip this reset for all PCI devices, because cpr load will set
>> +     * all fields that would have been set here.
>> +     */
>> +    MigMode mode = migrate_mode();
>> +    if (mode == MIG_MODE_CPR_TRANSFER) {
>> +        return;
>> +    }
> 
> Please use cpr_needed_for_reuse(). Or an appropriate helper.

OK.

> I would the test under pci_device_reset() and avoid calling
> pci_do_device_reset().

pci_do_device_reset is also called from pcibus_reset_hold.

- Steve

>>       pci_device_deassert_intx(dev);
>>       assert(dev->irq_state == 0);
> 


