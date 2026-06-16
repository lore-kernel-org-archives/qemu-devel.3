Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132F7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZN93-0007U0-A4; Tue, 16 Jun 2026 02:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wZN8z-0007S7-7h
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:19:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wZN8w-000843-0d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:19:28 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FLDnZf1392585; Tue, 16 Jun 2026 06:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6elzRQdvaciVTq1lc1GdeXpsK/0uEEeSQg63MdFngFA=; b=
 Gt9OBn4jZfxU72IJHJBsH0tyNLxVmHqCIqwIfA2cQUohXj2A9T872Kq5E2zFK2pu
 b5yk0crZKIMZnjkL6ncJJJvXnICnX+tOFm9quak5ORxC4CmvvTe/ihnbu1LaEjN0
 Q3fU//gm93oF8+N65eGF0m8Mbw3lDJKhwvyMz60mgx9FSDAXGk+1en8ObaPfCDSO
 nGPAlc+djbqEW/3OoVY0QCXaTgX8+z2vQYHSxArG8lFB1lUpRDBDYwCR9SEktN/9
 bwnrJCUWMvmJHeSuD25aXV5rYkCwnzdmXSmkLeQJHxFQ1qNGqzor650eeRTfXcCq
 obYIQH7gjTR9+yVuD1JBgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es182bunm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 06:19:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65G6DVSS008553; Tue, 16 Jun 2026 06:19:21 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4etq672t35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 06:19:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJOkmgE0WIvtGFXiCVJgONiE14HXX64cFYuPADDWZPyCG7VWxNy4ofQNG1c2MiAd/2tFEEcNI0Iecz/ex7W57dK1S/Z5O6SI4I/4Ci08F2LgM09it68rNKVzwivoLMx3edwdhh8LC4Y9dTM8EoY2AtqpC8w6614A32UQdGqr1LYDZtM9j5siVXrZ9IEigCnG29ZbWGrhfQeETQ01V2h2Il8Ewhzz4NapqQbMADHybCremABwTF3GD/vDh679YDf1s/bfVZnXhZj6Gpj1NWqmlyMNMBbBQ6fvOqCJfz5IOuJSG8voeYToRq4OI9Ue8kOFj11oUcIl/i55OmVLGswMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6elzRQdvaciVTq1lc1GdeXpsK/0uEEeSQg63MdFngFA=;
 b=sE9o7R59TT2Zq4+zRZEoaOUrKEFRiX75WzzhGOvAqULWpXBbF2Ok4zPayWrVFfewZKF5cgNlI5ePH3VZ0ftPoFotEguMv0t1SxrTpDn+t8Y/Ik5u6LNMiVAjmFfvMq4U9ypXPm99OYRXgQfU+Jz+R48w13On0Eq2nDinPnh/jFXB6Vrvp4Ypf2NU0MuMQ01vm89RdpwAV6TtSgvS8uaIkqrFOqR1wTxrxAbQWeWtShW8bKdosTI0NJooZYDNQuv2zxcKFKQdRWSKsFZiT85aXgKtfpvHwpNgyn/7Lg3jCtj9FHkbrW7oVqjkySckzLzgWxgxpcbLBYg6KdSEKdhh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6elzRQdvaciVTq1lc1GdeXpsK/0uEEeSQg63MdFngFA=;
 b=B7J4DERMtHTfJLLtMkkiRU10I7rGfGnRdAFz6kmeo/ZR0MhVV7LBFOyZKzcj6JQHnJMICWyZWXF7doYBdZ02deeVMg57kPp2Getx8ibHJbeJIqwLgHdElNIt6lAPoLklbJCZcdzV5uNoq2/dtopEDqFIwMAGc8Ikeim8tVxtCPU=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by DS0PR10MB6773.namprd10.prod.outlook.com (2603:10b6:8:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:19:16 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 06:19:16 +0000
Message-ID: <1e0a1d0a-a5d2-4b9c-98a0-9875c6147bd2@oracle.com>
Date: Mon, 15 Jun 2026 23:19:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] migration: stop VM earlier for CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
 <20260612165110.431376-3-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260612165110.431376-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25b::12) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|DS0PR10MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d937d34-c7a1-4c69-2e95-08decb6f317d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: z6ikt1dPIHyQNps3/hypGyW0W6MYsFzjTMwjQz85QLN99BvTET5pHMUXDmrcvj/c3j+o1sc1UXnrh/vw+rwwHN0Jix5jwdCQ4S9IGk3cdeOxkTXSjAzyv1m1pzIMOiSIp2vW+Nh6ZqwpehdYaUy2rNqJpoYet375bS4Cesrm8N0X6OwlZ5Az22IJ4mfbQNOOHhZu5qbacjNEAMNxgPmzBKTj5WFDnv/urNRWyYzSaw8Ris4iR2EOUZabZcPpMwC/qtOcrcvzSbghtIV3Mubl9nGcRMZi435Nu0ZjidPJ+H/7pJAdpm0qRguRXewsjphgbrPCNx85ImqMGQvfywkJa+qjJaEpeZqjOanutiBvrJtlSaIxThftbvpORzyvPiQ6xPrhhhdRnHRoyjc0ZXkM6gy1hIUqUZr8NwRySqxidaX1fv2913BhqD5MkE7coLYI4nwCBZ1rYfsvTwOOqmtLifcd9p2NXz5pT6ws2Es6grvLooYB+k3Lo7F4LCh9c1ZLKRp4VWq4Lxp3DfJNn4XV/VYQ+QaAdK/Ps4qQQXZWj4g1IdEQwvQJPEMEAlJNHu65a1gxTqOzRp2UN+SpSQOFmzixZmnhIc5dtDqyhvFzFv2IA4jWjI8lk5OOVAvxDVyzedvTyvRcqQ0rHt6HpvezDmtc9v1qGkPdqDpmdl2XHQ7wTguOXbU2UVpQSxULtnVYe2rgZr1fY11RtLUJIIav4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4133799003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtJTTRSMlYrSFlESmlmL3J0NFRSajg1ZlpFQ0NjbDdCRVdDN29IWmc4WU53?=
 =?utf-8?B?SG9SVjBQQmpTcEZaUHdMNk14dER1VjBnd2Q5SWl1Z05VYmhjdmIxdXJrUDh0?=
 =?utf-8?B?S0NlbDZZSWJRemZrdHpQbHZtRU9Od3h5L2hCSXJTZmdUSFlSR1BRNm5jNi9N?=
 =?utf-8?B?bXgzd2EzNytLa1AxcTAvSytNcG4rekg2aDJJQlk1UEVKbENyMEgwOGFjQXpp?=
 =?utf-8?B?TXR4OVlVSGRRYkcxc1J2YW5NN0xTTEJSTGUxWjE3ZlpWN1BGTXRzMFNOK1Nn?=
 =?utf-8?B?dVdmaXBkT1pLNnFGWVJzWFNBM3pob3c2bFlJR0dFaCt0MFR6WHN0dUNMalJH?=
 =?utf-8?B?QkxqNWNaRXh2M1RhQytEbmtDMlBQOG5XRXkrUnpGU0kwSUxMazllWm96cTZl?=
 =?utf-8?B?TGlwNmpIRW1sYWMwM1pEbzZyMDdzT0czQnlGcmNKVkhCQjdsNE1vUzQxQ1pa?=
 =?utf-8?B?VGZTUUFwUVBBc3ljSkRRK2lUVW01SzloRE1ucjB6ZThTdjhzd1RSKy8vTGZP?=
 =?utf-8?B?QzZMUnB2M0hUY0tvOW9SdHZhd2xxNkZXUUJQUTA3aDBNblgrY2RsUHdsT2FD?=
 =?utf-8?B?U0M2eFliaDBDeVJ5NDJLK0c1alZSQUdxWWc4ZEVHUWl5bnFUSFhDckpXVXFK?=
 =?utf-8?B?eWh2bGl6dUU2U2pSY016aUc2ZEZmT2pxLzFETDk0VEZFQ0dqa2tzanptZXZU?=
 =?utf-8?B?QVI2LzhldlNHejFoamkveklQWVk0ODZKWTR1SXlsZmxqQzVEcHZYaW5lV2VE?=
 =?utf-8?B?cDB6MnJsQ0t0ZkdDdEZpbkwrMnNEdUxTc2RiK2NsdUVJQzdSZ0E0RlAvNjJ4?=
 =?utf-8?B?RElZRnhPTVk5ZlNNWEpXZ3NlY09qYnZsVXJOQm5xc2FOcFI0b2hHREc3L1V5?=
 =?utf-8?B?MDcyVG9HMmdvaXZ1VGVTSXJPRjBkTHV2OUJqN1JjRDVvVWw0aTlrRklYQ2du?=
 =?utf-8?B?bnRvTHI0dGFQRGR3OGRNc3pZYUdHZUZzd0paN1dFRTJkQ1F4NEZoRDB3Q3VI?=
 =?utf-8?B?dE51QXRSNk9hVUZhNEF6ZzFZNGJOcTYweDVGZnZoT0ptVFAzNC9kelZ0a1Q2?=
 =?utf-8?B?TzRZc1JnUHY5ZHhEVHI5R2J0UWliaG1ESVlPdmZ3TGJVcGJHT1Q0VnhqeGNk?=
 =?utf-8?B?QStCNVBxYzVXTmhNV3hvc2NuclIzMW1uSmRZZlg2L21WWnkzcHRlUnp5OHhm?=
 =?utf-8?B?bjMwZ1MvUkFaeVJaenBodFNIeWtJbVQzVjh6bzJSNXZxbE0zaEtUb3JsOEc1?=
 =?utf-8?B?S043b0tKb3V6cWE2NGVTbStkS2gwa2hOWmZsZWhhYVVpUkZXRTM1RTQ2YmtB?=
 =?utf-8?B?bVlqSnY3UldmTEJLV3RFQkpyekNXc1NnMW9kdDhtS1BjUnpSRkYxWXM0RmMr?=
 =?utf-8?B?RmNwaFUrUHowdjNBdmpWWGczSkVpejEzSitmQitNWktKYVN3bHJYK2MvSmdV?=
 =?utf-8?B?QWRZTGNDN3JOOUtmSVNsVHBPVHZ6K0ZNY2xUcVZvZG1malQzN2poam9CY0N3?=
 =?utf-8?B?M3ZQRkIwQ2N3dWtLOFRnMTRhcjVObEp2aWpOUUYzLzlHSUduZzloZXBVMkd4?=
 =?utf-8?B?MXJXdTZOWm9RVmYxOVc2VTNQM1IyTUEyUEQ4VFYrOTRqSE8xaWFBQzc2bjRO?=
 =?utf-8?B?MUhwb1FGVU83amxuSTZaR3hYUk1SbEJqVUdlOFdMRWZwV0VyVy95UlJ1dnhE?=
 =?utf-8?B?MENVVDJtcFh5STl3bnJpYktITXhsN09DN0YxQmpZVlp0NE5nWDdud3lyL3ho?=
 =?utf-8?B?dW1WRlYvNlRjRUo4WUw1U3NIWlU1bzZ6RjBKTC9tLzVPa1RSekxzRzZTU1kw?=
 =?utf-8?B?UzhBcW85blZNaDdReUtwR1hsdlZrVS85cDYzODlmMTc4Qy9FUUsvS3lHZlBq?=
 =?utf-8?B?NlZnbGNROEdIcytFOG9ackZjSEVDNWpkcCtPT1BrdTd0ZjVmY1FGcjlJVzN3?=
 =?utf-8?B?YjNwY3U3UVJmWVJpdXoxU1cwaW9OSmxSdXpGQWFjUjMvV1J4eHBoY1pRK1VR?=
 =?utf-8?B?eGg0SDZ4cnVOWW9nQnN6bXlKQ1hhUmRNMHNHQTlvTS9Kbkh4T2hER2lHZHVB?=
 =?utf-8?B?d3dSZzFWQTNXbHB0MDRBTThEdUJ5R01lME12ekVLUE9hUHBneUhJUVA5S1E1?=
 =?utf-8?B?UWlKczBqVTZ1N2JRODZkT0V0czJGSk80VTFhaXhpTWRlQmIwMjBib2ZTSUE5?=
 =?utf-8?B?N2RYajFuUXNkR1VwTDlUc05oUWRpa2ozUzhFSWdiK083ZVpKUUhSRVpnaGFa?=
 =?utf-8?B?dmhLeEJxeWNVRklPZWNrcGgzRUtMRjRGODdVUU5jYVA2WWJ3a2NSNkdxanJa?=
 =?utf-8?B?cUw4b3lidnE5OHFSY0NNNGVsekpWdWpIQi96L21PMTgzTGhaT2VYUT09?=
X-Exchange-RoutingPolicyChecked: qqLJPDiKp3hhEfO0XJIGpussnTytWwuNp93iWg70AtzLXGUcsHXC5QcX9pQaHi9AXmjYch0sTpdC9F+w18gAODxIsX9QbmEOtQN/m8lCVp9os7lGbgO9r0n6eSWdOZrQeABxgZhJML189KpV/0NfTkIPt2Rb6+QjPTEshUwI8U5AXe0XxWK9YLDbChqCHVbZUQ81AicdKHpMabxYTy09vJFzAQKo1M59carBwk1MikdT5sMNQY0CZVuAgdK/cRf+p66arMv76dnF2UXi29DR/XYCkvPiDP44yaOKGuNr08sy6ro1OOsq7DCvMTIHY2XicHHvl630e7+nldabboYh3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T1jtJ3xksFqpXOmkK29i1JXbjoWZrr3+fNMZrVV+Okl+I3PVRxKfLThN9rMO8TDxI18S/lyL1brYmSRqCrwQGcEVcUP8uz98JQZuQGjvJc7BsLaUqUj5tqzoukFwHLy4ROHLMy3sAM2e4UVf1aEDQfjud0z1+qYmTwi1o5TjE15WzQ93kKnlZeBGp+CiFQQHWC4rNm4DjSmYG9RPBKd25qxi2bU93MBT5Quy79DMh1gAnUnp2qtf1LBWaS/crsuD24FovePiEoGe5uY4eiyu3kAI6RdcUoflhaoJmO3rYfEemtw6kr1IIYwinjoHfpL1n6uAA6EzNnohrmQQsGKV2cRXVlphLr9bU4R8aXwqqaGGA5C166cERWd84o9thxMFzE02tsH7Kgfe32x8mzkEYyUyWxclDWXkfbRjzHiHIoP7nnMYhSc9fAWTDCkXzjj+WWfM2B49yqFARnfWC+Wb6WzB0KL8V77XGunTtPHheYx2WiBRwHz35NA4+Ruhi2QlabfN/IH4KAiOjH8R7U4sreRzljiLj1xJ7Me8+APtrHY6DkKD0ChSFAyTpRHHuomGyZno99qSJhH8YNEx3jrg4NMGBi0ltAeECzHnqf4eauM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d937d34-c7a1-4c69-2e95-08decb6f317d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:19:16.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYPo2O3XCIEwQUWZEezzsGIWbKQle2mKt5SAYAI1JSqHKF5nQb1w1TDbUtnnc9fLXb8M8x5XkK/B93iFGHwRRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606040000 definitions=main-2606160059
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MCBTYWx0ZWRfX9OjhoXvzSvrY
 CSXm7fNrwzdmTfEoONiWCpoXBiKWeLbM0zC5Hn4sox7ofLseSuXbrULK9GqKroLpgDBuSIyS81M
 vdhvIhLv0lWJkODJDKwtpuXXKrACFRBGyyet9SOGHc2dutnAOh6e
X-Proofpoint-GUID: dYo3WjR8KIpWHnMf2_yS8I_04Cdb9Xfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MCBTYWx0ZWRfX6UG5aiFIirJm
 WBeCj3ghOMkOTVqO1kqteZ2iAEK/xtWMkgTsDfg+xPvsBdF7WkCdTge621M+2AZTjMVzuOQ5lDn
 YlbMdCOIIDDc9f5POe+i9/1RrMX5e9nmmPSdSenZNhXgvyrXwhdMGfTn93e+bn+MDmTOJWKr1Pd
 2VXXY97Ev/0HtAc/qzMwtgvcqN5NuNwvd+ky/2MEiZLLn7CGBjDqrAU2fHdDaZNDg2IDNGQw6Nu
 5NbS7WHpkVfahKjDjdMkEN66hciy0g8DokRR8rZHFUSK4dy7lRr6ZONzhEpwghjBxys8Z4q5MOx
 dzeWwIfaZMAvg7cfdFDI7/mG+Gp9FXWGnA1tO/aUWCTcqdsaMwkufpu7d/Fx8oizDBdYQOQmFM0
 XFkQK88wOjfTSQmW7ACCv6YFICNA2LhldAtgv1FKPYffb93d82vPuX8vF8IB24LeVrhtxZBFeqU
 XhtkXDm+Eszo7qXg2Uw==
X-Proofpoint-ORIG-GUID: dYo3WjR8KIpWHnMf2_yS8I_04Cdb9Xfx
X-Authority-Analysis: v=2.4 cv=Rr/16imK c=1 sm=1 tr=0 ts=6a30eaea cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=X7Ea-ya5AAAA:8 a=yPCof4ZbAAAA:8 a=TYBLyS7eAAAA:8 a=NsVI1WquneSrNn1qDy0A:9
 a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026-06-12 9:51 AM, Andrey Drobyshev wrote:
> For CPR-style migration, we need the VM to stop earlier on, before
> cpr_state_save() fires.  That is to prevent the race between source I/O
> and target device init, as well as make sure VHOST_RESET_OWNER and
> VHOST_SET_OWNER are fired in the right order (cpr-transfer case).  Thus,
> for CPR case migration, let's move the stop to qmp_migrate(), directly
> before launching cpr_state_save().
> 
> This patch is a rework of the change originally proposed by Steve and
> Ben at [0].
> 
> [0] https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com__;!!ACWV5N9M2RV99hQ!McDgSIuX3a-mCdNkiaf0TCITdQB-bEHCppcpig8fe6BPBWlU7qkvjW5FhLN0twb2fq9pC2qDYPH_FQZJYglJy4C71FMad5DMog$ 
> 
> Originally-by: Steve Sistare <steven.sistare@oracle.com>
> Originally-by: Ben Chaney <bchaney@akamai.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  migration/migration.c | 73 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3c70467d314..c02f1da8b0e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1380,10 +1380,13 @@ static void migration_cleanup(MigrationState *s)
>  
>      /*
>       * FAILED notification should have already happened.  Notify DONE if
> -     * migration completed successfully.
> +     * migration completed successfully.  On a failed/canceled path,
> +     * resume VM for the CPR case.
>       */
>      if (!migration_has_failed(s)) {
>          migration_call_notifiers(MIG_EVENT_DONE, NULL);
> +    } else if (migrate_mode_is_cpr()) {
> +        vm_resume(s->vm_old_state);

In migration_iteration_finish(), the VM is resumed only after
migration_block_activate() succeeds. With this patch, CPR failure handling is
moved to migration_cleanup(), where vm_resume() is called *unconditionally* for
failed CPR migrations.

>      }
>  
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> @@ -2130,6 +2133,45 @@ void qmp_migrate(const char *uri, bool has_channels,
>       */
>      Error *local_err = NULL;
>  
> +    /*
> +     * CPR-transfer  ordering:
> +     *
> +     *   SOURCE                              TARGET
> +     *   ------                              ------
> +     *                                       cpr_state_load() blocks
> +     *   |                                        |
> +     *   |  1. migration_stop_vm()                |
> +     *   |     VM stopped, devices quiesced       |
> +     *   |                                        | Waiting for
> +     *   |  2. notifiers (SETUP)                  | FDs from source
> +     *   |     vhost_reset_owner() releases       |
> +     *   |     device ownership                   |
> +     *   |                                        |
> +     *   |  3. cpr_state_save() ---- FDs -------> |
> +     *   |                                        |
> +     *   v                                        v
> +     *   postmigrate                         Device init begins
> +     *                                       - cpr_find_fd()
> +     *                                       - vhost_dev_init()
> +     *                                       - VHOST_SET_OWNER
> +     *
> +     * Step 3 is the synchronization/cut-over point. Target proceeds immediately
> +     * upon receiving FDs, so steps 1-2 must complete otherwise:

Complete successfully?

> +     * - Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
> +     * - Race between source I/O and target device init
> +     *
> +     *  We stop the VM early (before FD transfer) to prevent this race.

How about move some of comments to the commit message instead?

When reading this comment in the final code, I found the race description a bit
confusing.

The vhost_dev_init change is introduced only in the next patch.

With this patch applied, the VM is already stopped at step 1 before SETUP and
before cpr_state_save(), so a future reader may wonder why there is still a race
between source I/O and target device init.

The race is the motivation for the change, not the behavior of the code after
the change.

It may be clearer to keep the comment focused on the required ordering.

Thank you very much!

Dongli Zhang

> +     *  Unlike regular migration, CPR-transfer passes memory via FD (memfd)
> +     *  rather than copying RAM, so early VM stop should have minimal downtime.
> +     */
> +    if (migrate_mode_is_cpr()) {
> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +        if (ret < 0) {
> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> +            goto out;
> +        }
> +    }
> +
>      /* Notify before starting migration thread and before starting CPR */
>      if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
>          goto out;
> @@ -3482,13 +3524,19 @@ static void migration_iteration_finish(MigrationState *s)
>           */
>          migration_call_notifiers(MIG_EVENT_FAILED, NULL);
>  
> -        if (runstate_is_live(s->vm_old_state)) {
> -            if (!runstate_check(RUN_STATE_SHUTDOWN)) {
> -                vm_start();
> -            }
> -        } else {
> -            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> -                runstate_set(s->vm_old_state);
> +        /*
> +         * For cpr the VM resume on failure is centralized in
> +         * migration_cleanup(), so don't resume here as well.
> +         */
> +        if (!migrate_mode_is_cpr()) {
> +            if (runstate_is_live(s->vm_old_state)) {
> +                if (!runstate_check(RUN_STATE_SHUTDOWN)) {
> +                    vm_start();
> +                }
> +            } else {
> +                if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +                    runstate_set(s->vm_old_state);
> +                }
>              }
>          }
>          break;
> @@ -3903,7 +3951,6 @@ void migration_start_outgoing(MigrationState *s)
>      Error *local_err = NULL;
>      uint64_t rate_limit;
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
> -    int ret;
>  
>      if (resume) {
>          /* This is a resumed migration */
> @@ -3944,14 +3991,6 @@ void migration_start_outgoing(MigrationState *s)
>          return;
>      }
>  
> -    if (migrate_mode_is_cpr()) {
> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> -        if (ret < 0) {
> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> -            goto fail;
> -        }
> -    }
> -
>      /*
>       * Take a refcount to make sure the migration object won't get freed by
>       * the main thread already in migration_shutdown().


