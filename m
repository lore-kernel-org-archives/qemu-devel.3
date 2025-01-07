Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6293EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBfW-0001CX-H6; Tue, 07 Jan 2025 10:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tVBfR-0001Bf-K6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:38:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tVBfO-0005gh-PX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:38:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507FMnom007215;
 Tue, 7 Jan 2025 15:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+3ysTKP1aab8C9d8mnHZ9+fHgdmoPqxxz4RPlPY01tM=; b=
 IA9N5j4iCWekfjb4DKX3U+57u2XNq1Uiqzi3pAmJ9i5sSUWyNt8S9D7ucgS3DhSK
 5n0UMH0+/kCyDL6dxQNPDGGn+5an/dD+02PEGwi65pF9Hr2uyqRCOUR67uRFLL6r
 DjmhGOJbL2umQcWrzNL905Z8K/04KyJyjdTt2LRExVvhjdhGKMjKDpnr1L/AMg+L
 qjBCV8lu4r+60mwh6o+BX5Cb/k5VR554/XSkXN9n0QO+RcTFOdegzOQDun8GTHQO
 ze/rHL+vuzVMM9EHbkHamFnMiZ4I7nD9UInOZbCWLMSr/pSg0IuodLEUNTSKenTB
 nf2WMCCM4ldKQaBD078Vww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus2d1cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2025 15:38:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 507F4Dk3004808; Tue, 7 Jan 2025 15:38:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue8msug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2025 15:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdh3joDvnC0G7+fAPCVK82dJayGVCwidu3vP4GUqKLOIw4gKxKE+B2eLE/JAdN3ZfymkWOge2H41nGTLaUJKZwdj8aoS0Cn2t/Tmsduj5ZNVB2oKBDROlaAjBb0X6TMhvFsdCw2ZWmnzy5+LjoU2tTzAjDW1iOBwwUq3DGqqsIsKxKjNOqRfDVboxhaoa0Fbu0h/PwccXUgHSk7db9M8P8+58MRsWooU9BLRF+qu2OVSFZxhUaMKU7QVi9x7wYweafHhg1h9BJlWUrF8h/QSrUKK6+yBgG9S/tj7eb4vvb30znVJ/IgILhanGAarheJe8/XjiM9+1bwF985xPy3lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3ysTKP1aab8C9d8mnHZ9+fHgdmoPqxxz4RPlPY01tM=;
 b=DE+vy5rvAGLEsIIXaAusYvO83HvSU6XcuVKdLmahOVlZxQAL1dc9eKWDHzPKIaelHmp11dXRiRhzLq+vtTr2fURriTgw4hD3GSqBmYN8aIm8r01ZJgHH1H9XLPOYzavaDX+UM6cuOZmt83bEv3SWFTA6QHSO/UgwzTdLkvQ/neRrifdtNKOWkJFJijO6ruN5ig5EqlfUacUc3EKvmBu7N/QNcpuD8y5OMpti8YLK8zAcRb4ieQJ9wLhPQHYGhBHDe1cPirGN8YV9T8VZ5FBoVnji6i44yUX8/zBucYfdBynxGEEPvxfVzwHyxhNND4jciD2+Bpo82EbSMjRJB9wRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3ysTKP1aab8C9d8mnHZ9+fHgdmoPqxxz4RPlPY01tM=;
 b=vY2bIl+MW+liVyl4SJETg0zDPKOjI2CXL4Aq9JCzOFliV+Vzk+Zm1+LJ0BTC0jKeULngseiv4cjEBAB4Gy5CjwRebsKU//4NNT3CLf6Chb1dNJxsqi4FhvTmJsx+tRtxmHGqg6vSMbJxxJ1Fgy4x/bHBFQZOWgJs5Afr0uqbhtQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:38:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 15:38:37 +0000
Message-ID: <2ae6c272-837c-4d88-bcfa-fc7719cc447d@oracle.com>
Date: Tue, 7 Jan 2025 10:38:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <87ed1eakxr.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ed1eakxr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 21da498a-3f2b-4cd1-1183-08dd2f315a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXp6c1d0UEw4bWRUdlYxems2QnFmeHZpTXFwQzJ2WVl4OUdudmtqM21nSVhr?=
 =?utf-8?B?Snh5YVVnQmwvbVdadUpDaWN0dGQ4Qis0WTdybEQ2TnVhUFNLRmtQbEMrYi8x?=
 =?utf-8?B?WUswamgvcnlPNXFpb0tKbXRyamR2bnRqblIxMU9GT2VaM3BqdlRvN21mMmNX?=
 =?utf-8?B?NlVQOVl5dmhSNkRDb2x3MUpxWkJxUFVsK093dUtpbjY3endSbVlOdHVWU3NX?=
 =?utf-8?B?cjduOG5LRUJuWlUzem9aRkM4SldkUkVsRkxKVm82YjR6Ymh2SEZzSHg1czNO?=
 =?utf-8?B?b1Roa3NEdnhJRE1hMkF3RllrTWJzTzVNYTlsTkY5WGVNTkM5aWNKemhaRFhp?=
 =?utf-8?B?Q1hJYzMySEpFMm5Ndk5NZDlpUUFYaGs1VDdCR3Mvbnk0SFB2VWljTUZ3bVIv?=
 =?utf-8?B?bmFHaEpJN1Z5eDgwMlFQdWVyVEE4NllDUjhQRTZQWlpKMlNOajZHZHM2dUl1?=
 =?utf-8?B?VWkydFJWd0MxbTA3aWpkVkNOZnpBd1crOElkTkpBSXptOFJIWU1KU01ZTlU2?=
 =?utf-8?B?Q0hmM0lsSktpSWl0bWRmS2NQWDk1RnNFUWF5T0ZCQUdTLzc5cUYxL29KWUlY?=
 =?utf-8?B?YmpJV2tKcFZLQmpEbGthUXBCTm9ZVmRXQThhYVRuTTFVbVFGeDFEZ3Q4REVD?=
 =?utf-8?B?bGhFaktoK0FCc2dkRUxNSDMwcGZqVTNaVmJqRmh3b0EzMmVZRTRJWUEyWjFm?=
 =?utf-8?B?eFg3NDRIMnZQOWlHa0Y4dW5lZmF3QktHTy9PVFF4eFVUanFQb2NaQU1la0Vp?=
 =?utf-8?B?anYvakRJY1JjZVAzNVJDb0ZPS2JkbU5XSjFmUWlsTDA4T3pvNVVTODU1N1Ny?=
 =?utf-8?B?MkVOYTNBYUdwZys5cVB6Tld0QzZYRkNnUDM1ZGtsUC84V0ZkN2lXcjJIUEw4?=
 =?utf-8?B?dXJXSzJlQ0J5Vk43aFdHZFg3dms5aUFIMkNiOUxKUDQ4RHJzOXMyMzJWeWw4?=
 =?utf-8?B?cCt4bnhZVFRmRnhCSllHWGsycUdUVXdhdWovWTJJWm1ieU9pWklIV0lpZmxP?=
 =?utf-8?B?RWRORWdaY2ZkSTg4L1p6QU4yS2JXcGl2ZTllU1FXdFZBRmJRT2JhZ2lMbTV6?=
 =?utf-8?B?MjRFRExvQUxGam9tNXlSQzlUN01UZTllS2tXcEwyY2NwVXEwMTh3WHRTd2dx?=
 =?utf-8?B?bk41NXprY3hscVFaU2xPUVRTdHp2SFc1ck0zZ2J4NG5VYkROelI3OUdmcEtK?=
 =?utf-8?B?WFRocXFZWWVOTzVUcmRYZ2paM0d6a3FsdXRkajhjVDJwRmdZcGx3S3crcDh3?=
 =?utf-8?B?cEc3cmE1aGFnVjhOcjZNazg2ajlOY3pPNTNBdm1wT212Q1hJbXM3WTd1QkRV?=
 =?utf-8?B?WG9CVzY0NFdPakN1Z1UvNEdHYUh6Y2x1ZnlHck56UGdaMEozSllZSHpseTU0?=
 =?utf-8?B?SW9QVVJwbjNNbXJLUlk5NGxYRjlIbHFYZDBNRmhGaWkwZUF2eWh3aExHRk1M?=
 =?utf-8?B?SHFHWVN5T0sxWmd6Q0JERGQ3alhRZmdPWVpiUnE5dlN2RHBFZkpLZ0RhYkRW?=
 =?utf-8?B?elM4RG5pZlVCYmVlWHlLeEd3am1NK2tnY1g3NWZGS3Yrbkk3bHM3djNSVXZ1?=
 =?utf-8?B?WmN4OTZFVjRaM3RiajM2dXRuc1FJc1hPYUI5WlMxMlNsQ2JoTFBaWEQ2dkp6?=
 =?utf-8?B?a1NnSnBNOVBrNk5nMG8zQXJyODNzb25EWnJ3djlzRGo1ZmljWFd6SnZLT1N2?=
 =?utf-8?B?OXYyTnNkVmRMZWN4R01YMmxmWnJlcmtHY0ErMHNnUVpObThHVlBQMG15clVa?=
 =?utf-8?B?NEIxd3lpV3pQR2F5NmJrWW5zbitSSW9xU0hRVVExZjRLOHR2S2hqcGJseWlQ?=
 =?utf-8?B?SUxpb0IwNDIxSS84blRpM3lNY2Z6TUNJL1BJOUc0Q3lIMmJkbmdoUUpKRGo2?=
 =?utf-8?Q?va87ObCLaax2E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNqRS96YndMdDVuMVcvUSs2RCtMb3M3d2x3MTNsSkN6d1ZSbXdKV05nbzNu?=
 =?utf-8?B?WXhwSUZnaUNWcXhtQW8rRm9CTmpWWkFMVm1LSVJyRG1mbURLQ0JWUVZmRkZz?=
 =?utf-8?B?eERIcEdXdExodzBzOFZwL1pGY2xRWWFkdldXVnExNUwyVFdid1grcnJnQU10?=
 =?utf-8?B?YXY4amxnWVlCK3Zob1dqblhaOEk4NVRxRnNsSEROcnNMRWFBbzlCYnNGeUhD?=
 =?utf-8?B?OTQwQjQ5MWJVZWVBSC85dEMyMnRjTStmbmtaR2tqWkhrc3FhWkFvYkVxOUdE?=
 =?utf-8?B?ZWR3SXJQMk4xbGhJWHlwQytzWmltWDMvQlgrMjRPc3prelFmTVE3allNcmZv?=
 =?utf-8?B?Ly9YUVh0M1RobHJBaUM3Ri92S0hDRjdTb0NVMFVoL0RGdzI4azVaSkt2K0VP?=
 =?utf-8?B?ZGhUMmRvSk00emt3Kzd2VDBVWVVrMEtEQmJzU1NNZldLUkNXdjMxUUFBand5?=
 =?utf-8?B?dVVxeU0yNHg5OElhQUI0Z3hrMW5uUEE4cEhhSFBFVm9UR21mQVQvbElFTXk4?=
 =?utf-8?B?OHcva2VSYUhtd1pzY0NSY1ZnMXhnU3F2OHRqUVJNSEZJM3FkRkw3R1krNTVO?=
 =?utf-8?B?dGlOMDM3dnN1SFJhaXg0VitadEpUd3ZwZGxNQlRkTGROVy9ZbXFoSlNmYzdO?=
 =?utf-8?B?OWNDeWNVMnFLNzg4dlEvTGVBWlB1WHRwVE5xVW1MYXVBUjY3VWNuQ1Z4bVhQ?=
 =?utf-8?B?RnpBcHRYUGY1VkYzdTNUcGNRaS9rUFNDUlNrSXhaVGI3TkdyTE1ZV1d1YjZu?=
 =?utf-8?B?aU1DK0QxYkRhc2djV1ZxaTdOY1NtUHlnY1E1d3F2cVEvOENYMU5VNnprL0VT?=
 =?utf-8?B?Mkx5RUs1eUsrNHVCcjliazNsaFZjOFY0RjlQQmNiN3BqU1BpUm00cGpybmZm?=
 =?utf-8?B?SjhBcUlqaXd0bDQxck1LdXptNHduUG1JNGpMYzZjTVZtbUxwWDlZZ0g1UEFm?=
 =?utf-8?B?c2NXODNybmZaRGs3TC9wOGlZeDFTdDJhKzFVaXJWZ1BpTjhsaHE5a2tPVTRC?=
 =?utf-8?B?L2xiWXdGc2E0dWx3S04wM1VVWVgrVVBLNi84MHl5MnZ1dVJxMGp0TUxzRzVC?=
 =?utf-8?B?WkVYSERRV3ZNTUxmNzU2OXJpTGxRb2dzbk1PRHpyTWJNTmlUSFdwbzM2R2pE?=
 =?utf-8?B?WjBDb2lZZjN3TG1JMWRnbGdrcTRXcEpaQm85MUhMeWt5a1U0VjQ0cGtIMVl5?=
 =?utf-8?B?OFhhMHlMd0VLK203UEkydnZoMVZYMlBtUmZ2VjJMem5qek05MzFPcy9nV1R5?=
 =?utf-8?B?Smcwdll4TEZ4ZkYwK1hLZ1ZhdHBjRFVUTjhwbHJ4K2tyd1pYaHlYUHdMdGM1?=
 =?utf-8?B?UGVWbWRDRTF4ZGNvMVVjeWRHU2dBU1oyUW9lNG1oUU9LRlJRaGd6RUtJalhH?=
 =?utf-8?B?aTBmZVp4Y3dOWW5KWlZhOWhCQzU2U3k5dWZBZytGbzIydFMzbC84Y3hrN0Zq?=
 =?utf-8?B?OUZQVVlCVXhEQVMxc0g3WnFvZzF4RHJDc21HcWFoaG8wSXlwUk9xdm1HSXJl?=
 =?utf-8?B?bGJnbHl4SXc4M2FaK1YrSVdyTWxZWDMzRlpRdlYzdEY0SmJhdGVxNnhGQnA1?=
 =?utf-8?B?VlFMeHI2UXAyLytycUNiS1lhQm5qOGVHVFJPSytTSFRXR0ZhbmFyZVB2VDNa?=
 =?utf-8?B?VnJRMnBZeitqSnh4Y0tmNHlhcWhwd0lQTFZBTGxMNnd2b0x5c0hmUi9sRUNM?=
 =?utf-8?B?UlZjYnFGYWpXWTZocnd1amQ5TjJjbGw4SDd3R0pQbTZoNlBtcXdseC93aUJS?=
 =?utf-8?B?M3dyV2FrWU56NVUrbjFnV0dxaHRTdllDV1Jsc0RoV3NKeXJ0SktMejdwRzVM?=
 =?utf-8?B?c0RMZmRaMllWeDQ3R3ZvZ2oyMnhUaTRPTmU4T1RSTVNZcGNJWWlEbUVDeHN5?=
 =?utf-8?B?ZkNpWDZpczhRdXJ3Y01XVkQ4Y3VyV0NMV0JZVjU2bVF4bGVBY1hqVlc3UTdJ?=
 =?utf-8?B?WDlQRUxRSEw2OXdINEVsSk5oS2pHSW5BUnl2ako4ZEdDM0NVNVQyS0VldCtx?=
 =?utf-8?B?c2VaMm9qRW12dmtqelJwL1ZmdnVmVnFYMnpuUm5mZDZPUU9uc2dKOTZaK3M0?=
 =?utf-8?B?MjFFdmxQWXRyQ1FUcGFFUjVudnFTdTF4VDNXYWlrREZtT2VkRUVuZXRDVVFI?=
 =?utf-8?B?Tjl3Q1ZvYVVncUdVNUY5Z05LN21jajFINnZwazc5ZUJTZUdnSlBrdUVCb3BD?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ICMLoZ91gB/G+BoLasK+WTNC31TxJ7gjX9LS6pgCwvPr1CSR7Qy0vx1jcgzMpGBFPynhz+e26O//5w6rP2DgEx7ay0TujTGuzSCsRvDL7g/9mUrFAaug95rv1tw/I8CUR+jLLIRsmYvP2/W2iUZHyM6Py75dYkNr3Rq53cZLa5IcqGXRZMtZ2o3uLWjJVM1Y6Ntmn9t8vpiyGTYKjIhKkQM7h2GNKS6/71IZ0sK0YDh8B454BDKjxoxUi+lb8U+MaMxIS8Jcn4CpulutQzu/eYNTS/P7e7L0MSz4pjJLU0mu8emRQdGVJju5KZKSWLCG2jjkHm9y3LotkBJZreskc/0gbnB6p4usKg0oMPiBn3m7u5DOUENcFwaOn3D6fBXKJPa7dgSzju660N/jtwVzqjQjz/o2IHWVfGOsTUhkT0e9wB1h1F59NLae7VHKudIg7UtrjzKMnav5UgCnoy84C65jyMWkPcz3NO7E4NSgyPKXQGrlv/oWXFVMb1GyXNJMGdBN53YFubdrXvx++ipSFtGJg00h7izmvibfwztLorlfPdImFFQjREfsQF5HcovNE071EjRkGXRwveh3FZA5gr5myNsRo6a12X9pw811o8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21da498a-3f2b-4cd1-1183-08dd2f315a2b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:38:37.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5JGGY6KZf3AtAbDv40OqAafHxeuKPHC2ECbMmsE4fq614PtVGdwt5HLWjVi/zJLLVfn0HntJeT3NZwnh3BQKDK3Y+n86vjmGy9XI0Vssqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070131
X-Proofpoint-ORIG-GUID: OuEKRFkE2qaUabakcOWF4PQbhAOW7Fwa
X-Proofpoint-GUID: OuEKRFkE2qaUabakcOWF4PQbhAOW7Fwa
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/7/2025 7:05 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the cpr-transfer migration mode, which allows the user to transfer
>> a guest to a new QEMU instance on the same host with minimal guest pause
>> time, by preserving guest RAM in place, albeit with new virtual addresses
>> in new QEMU, and by preserving device file descriptors.  Pages that were
>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>> descriptor of the device that locked them remains open.
>>
>> cpr-transfer preserves memory and devices descriptors by sending them to
>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>> be sent over the normal migration channel, because devices and backends
>> are created prior to reading the channel,
> 
> Is that an artifact of the way QEMU starts up, or is it fundamental?

Hi Markus, welcome back and Happy New Year!

This is a deeply ingrained artifact.  Changing it would require radically
refactoring the information passed on the command line vs the information
passed via monitor.
                                             so this mode sends CPR state
>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>> prior to creating devices or backends.  The user specifies the cpr channel
>> in the channel arguments on the outgoing side, and in a second -incoming
>> command-line parameter on the incoming side.
>>
>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>> which allows anonymous memory to be transferred in place to the new process
>> by transferring a memory descriptor for each ram block.  Memory-backend
>> objects must have the share=on attribute, but memory-backend-epc is not
>> supported.
>>
>> The user starts new QEMU on the same host as old QEMU, with command-line
>> arguments to create the same machine, plus the -incoming option for the
>> main migration channel, like normal live migration.  In addition, the user
>> adds a second -incoming option with channel type "cpr".  The CPR channel
>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>
>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>> a second migration channel of type "cpr" in the channels argument.
>> Old QEMU stops the VM, saves state to the migration channels, and enters
>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>> resumes.
>>
>> The implementation splits qmp_migrate into start and finish functions.
>> Start sends CPR state to new QEMU, which responds by closing the CPR
>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>> main migration channel.
>>
>> In summary, the usage is:
>>
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>
>>    start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>
>>    Issue commands to old QEMU:
>>      migrate_set_parameter mode cpr-transfer
>>
>>      {"execute": "migrate", ...
>>          {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index f31deb3..2210f0c 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu-file.h"
>>   #include "migration.h"
>>   #include "migration/vmstate.h"
>> +#include "migration/client-options.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/queue.h"
>>   #include "trace.h"
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index a605dc2..35309dc 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -614,9 +614,47 @@
>>   #     or COLO.
>>   #
>>   #     (since 8.2)
>> +#
>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>> +#     new QEMU instance on the same host with minimal guest pause
>> +#     time, by preserving guest RAM in place, albeit with new virtual
>> +#     addresses in new QEMU.  Devices and their pinned pages will also
>> +#     be preserved in a future QEMU release.
> 
> Maybe "@cpr-transfer: Checkpoint and restart migration mode minimizes
> guest pause time by transferring guest RAM without copying it."

"Checkpoint and restart migration mode" is ambiguous.  It would be
"Checkpoint and restart transfer migration mode".  That's a mouthful!
"This mode" is unambiguous, and matches the concise style of describing
options in this file.  Few if any of the options in this file repeat the
name of the option in the description.

> If you want to mention the guest RAM mapping differs between old and new
> QEMU, that's fine, but it's also detail, so I'd do it further down.

I'll strike it.  I agree the user does not need to know.

>> +#
>> +#     The user starts new QEMU on the same host as old QEMU, with
>> +#     command-line arguments to create the same machine, plus the
>> +#     -incoming option for the main migration channel, like normal
>> +#     live migration.  In addition, the user adds a second -incoming
>> +#     option with channel type "cpr".  The CPR channel address must
>> +#     be a type, such as unix socket, that supports SCM_RIGHTS.
> 
> Permit me to indulge in a bit of pedantry...  A channel address doesn't
> support SCM_RIGHTS, only a channel may.  A channel supports it when it
> is backed by a UNIX domain socket.  The channel's socket's transport
> type need not be 'unix' for that, it could also be 'fd'.
> 
> Suggest something like "This CPR channel must be a UNIX domain socket."
> 
> If you want to say why, that's fine: "This CPR channel must support file
> descriptor transfer, i.e. it must be a UNIX domain socket."
> 
> If you want to mention SCM_RIGHTS, that's fine, too: "This CPR channel
> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
> UNIX domain socket."

OK.

>> +#
>> +#     To initiate CPR, the user issues a migrate command to old QEMU,
>> +#     adding a second migration channel of type "cpr" in the channels
> 
> in the channel's
> 
>> +#     argument.  Old QEMU stops the VM, saves state to the migration
>> +#     channels, and enters the postmigrate state.  Execution resumes
>> +#     in new QEMU.
>> +#
>> +#     New QEMU reads the CPR channel before opening a monitor, hence
>> +#     the CPR channel cannot be specified in the list of channels for
>> +#     a migrate-incoming command.  It may only be specified on the
>> +#     command line.
> 
> This is a restriction that could conceivably be lifted in the future,
> right?

Yes, but lifting it requires the big command-line vs monitor restructuring
I mentioned earlier.  IMO that is far enough in the future (and possibly never)
that adding a "Currently" disclaimer would be deceptive.

> What happens if a user tries to specify it with migrate-incoming?  Fails
> cleanly?  What's the error message?

It fails cleanly with a pre-existing error message that could be more
descriptive, so I will improve it, thanks.

> Maybe simply:
> 
>           Currently, the CPR channel can only be specified on the command
>           line, not with the migrate-incoming command.
> 
> with a big, fat comment explaining the restriction next to the spot
> that reports the error.
> 
>> +#
>> +#     The main channel address cannot be a file type, and for the tcp
>> +#     type, the port cannot be 0 (meaning dynamically choose a port).
> 
> What's "the tcp type"?  URI "tcp:..." / channel
> addr.transport=socket,addr.type=inet?

I will clarify.

>> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine aux-ram-share=on' option.
>> +#
>> +#     When using -incoming defer, you must issue the migrate command
>> +#     to old QEMU before issuing any monitor commands to new QEMU.
>> +#     However, new QEMU does not open and read the migration stream
>> +#     until you issue the migrate incoming command.
> 
> I think some (all?) instances of "old QEMU" and "new QEMU" would read
> better as "the old QEMU" and "the new QEMU".

Maybe slightly, but I consciously standardized on the terms old QEMU and
new QEMU to be concise, and they are used everywhere: cover letter, commits,
comments, API, user documentation, and in already-committed cpr-reboot patches.
Adding "the" would require changes in all those places, for consistency.
IMO it is acceptable with or without the article.

- Steve

>> +#
>> +#     (since 10.0)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>>   
>>   ##
>>   # @ZeroPageDetection:
>> @@ -1578,11 +1616,12 @@
>>   # The migration channel-type request options.
>>   #
>>   # @main: Main outbound migration channel.
>> +# @cpr: Checkpoint and restart state channel.
>>   #
>>   # Since: 8.1
>>   ##
>>   { 'enum': 'MigrationChannelType',
>> -  'data': [ 'main' ] }
>> +  'data': [ 'main', 'cpr' ] }
>>   
>>   ##
>>   # @MigrationChannel:
> 


