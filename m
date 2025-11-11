Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8A3CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 07:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIj25-00028V-8O; Tue, 11 Nov 2025 02:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vIj23-00027q-BJ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:43:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vIj20-0005q0-MQ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:43:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB79VSA015764;
 Tue, 11 Nov 2025 07:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=4TTX52aYjicNqOeK6//BRIo1aPci66sBJKeh9zJjbLg=; b=
 KNb5n4xwwyAwDcUFOO/NCVUSOGpKHPscVyd9uClCb6RrxVXd6rcvlfH3+dTuR1b1
 m2fPkt2HVagfWBHpAxjLskkgL+29krj+UFmpbI2QVguoJBz+UzahxVa2hKp2h505
 Y+7FyXYqjSgRVMMFZ4OhBValZjbxay8Fqn0DjpLHTNuxaYA285X2+HuKEQCFKWz9
 pJ6xcK8hfLr0RexHt53mmv30MQtOIp3XSjgV3n9qAnX+MlEB2q5uUJywKC9vhuiF
 aQL8xIFKKrMQEcd7HyoBh0+W6TbHKm+woUdLvQvNV/1tuE22KX/bhTTuKa2yITHt
 UKTMZiXK+nfPdDdqhIQJ9w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abw9wg9vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 07:43:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AB75cAu000794; Tue, 11 Nov 2025 07:43:00 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a9vad71cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 07:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL2uHVNoxTNGGoCOXPhEjEe1j/8pkkx+CqfAIFjZYOZOZJnr6+Odt83BOTnNeTBI5dqubfX4pE9ZGf3Jo3yFFt4Hipe7pZlzq2uc2KZv5EpNQ1mwy8uEpo9G55ewiJXXsF+HCjTRD9CE9cJnh36OCiYA3CN1/HDi3Ya+iiV3s/PDhZKyDBXw1UhjsfgjxAEI9SN1j5k2dcxUp+cFPBvrZyf6Bssdf0RjFzqlYtp1sTSIbreTMnPq4iv+WZHcrdK1RlHZpNuIGHcPAeJdXIv7Onofik38CNgYlTEXBv9qfSMCmjR1cMHsqlvz+aPIw2JPJVqT0Kaa9AErsMHJ0UDa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TTX52aYjicNqOeK6//BRIo1aPci66sBJKeh9zJjbLg=;
 b=Ctam3Ji09m7ryWwTFoDekczSQ9+6LTYLCDw3Y82lbGnZzlpz8Aen6AfJejL3DzjktmisfbxuUON2QfD+wgWcwx1QwAVkd5QMzvLTgx0Yw8K8eYfrtf/YlupzpovMi2pl4CmjgI5MBLZLR9yUmHCsNd1L1yMOS3EHWpTijX5fRSQ0AOUbGU4qWk/oboKOJ8DdqFLnpGt7ELgUiaxLVvo1CmsgaK4sgmbtTkcoCqn2zN3MUDus1yrwG/9J52Sz5RtFSRnzMsYdEFw92GtwOS71t6/Eb1KZ+kXxgP6Tr1sX4SPmbf7GOakSNJzK/AJ83Pt4haYYwrftREYDa1FDXXfjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TTX52aYjicNqOeK6//BRIo1aPci66sBJKeh9zJjbLg=;
 b=hqsvkaAEoVQGr3kv912f73dZuP3/j8mCKqh7fXGi5v2NGxE8ifVsP5MRM0h3wOnTFjofMS7IXk7VDR1Ikcog6zjsQocrqPzcvlavRwoykVILgRd7PlhjZIQi6GcwQfjVMFVayVcYYVZ7rkRqBqB55SiRSdmlcchQvFqIWHPaeN8=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:42:58 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:42:58 +0000
Message-ID: <9eee231c-4b51-49bc-a89e-f44891174eac@oracle.com>
Date: Mon, 10 Nov 2025 23:42:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpus: resume hotplugged vCPU only when the guest is
 running
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, Joe Jin <joe.jin@oracle.com>
References: <20251010213639.1634-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20251010213639.1634-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|BLAPR10MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7401a794-6723-490b-4424-08de20f5eeac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2RJNVJCVkRPZE9Yd1FDUGF5ZnRKTDdYRzNuTnY2ZG5KNzUvM3V1Zk9lTDU0?=
 =?utf-8?B?MHNkUTRDY0s5UHNhTERxRzF5cHNPL2hWLzhxOWhzRFFWK1dKRElGTFdqL3pt?=
 =?utf-8?B?cWZpZ3BwZ1ZzMlR0QU8zM0pXQjdLUG9ueUR5ZitGSU1oYVRHbElNU0Yzdk94?=
 =?utf-8?B?RmJ0WVNmUHQ0ai95SDNjNXduRmRqcHhkTk02cVBRS2hIRllJZzljR2pBZlRT?=
 =?utf-8?B?N0dwZVhvVSt4OUk5ZEpFZDBCaHlTMWwyeDRUSnBYZURzZXJCS2FLSXpGUnhP?=
 =?utf-8?B?aTZuZnVnbGRSMVN5OFJIemRLTVNZVEFkYVVLa0tqdnFYRDZhVXRQVlVHRFNq?=
 =?utf-8?B?UzZwcU9qQ2NBRXlxK2tMeE1DdUp0M0JRVGp0RkxOTm5ONThGYU1Ya0ZiT3NH?=
 =?utf-8?B?M0JnYVJQVEdkNkQzMmU3SkNvdWNmMkVoYkZYb2tpRmtuQU4rd3hTTmhnSDB0?=
 =?utf-8?B?TW1WL21qMUZPQW9IZU4zWUpLTllnV1doOTArWWVZMFdCdGl6K2JVYnk3MzNw?=
 =?utf-8?B?ZDM5UnVhVzRzSGZKdVFaTnZVSmw2cmh1QnMvRi9YSTNJNVFFdEU4clA4bHRZ?=
 =?utf-8?B?dnZSL2lWM3JJSEkwSlpRd2QzTWlxZzVYdVhYckRveWxVK29JQVI4RzNIb21D?=
 =?utf-8?B?NmxqSFBsME9jaWhrNy9Nd2NwQWk3VXRyN0FCcy90am9QMnhGYnBXVkZTTGlu?=
 =?utf-8?B?bFBMdFFaTmVhaTdIZ1BCZkl4MUhlVFZ5bGt0ZGtuTmR6SlFrVTUwcytsMkc3?=
 =?utf-8?B?SG93V3hXS3hWY2tGRHQzNHdXL1JUZTlLQ0x6dmxLbTBLRjVVS0xmRHBScytu?=
 =?utf-8?B?cnFuOUNJb2RhT0FlTmxtTk12TnFMQ0RHeWZFdUNiS0tBTEZWTzFvNHppc2dF?=
 =?utf-8?B?UFBpMHFBdDhWbXhvMFgrOGdSeFFWWW5IODBNSVBJSDdFN3kwbGhLSldiclA5?=
 =?utf-8?B?UVhhMWpDa01UZmtnL3BhL0JFWHRReUNxUnV1OWtKMWoycGx6REM5dEJPRERq?=
 =?utf-8?B?Yy9sRUlEcTF3VkdtV1ZVZDdsdUJZVXh5WTdMdFJjR3A3U3BEOXUxTExva2dK?=
 =?utf-8?B?TE1YM0xIOVNQOXQxWUd1MTZSSDBUMXlsMXFoZWdxdkVuc25pU0hiZHMrODRX?=
 =?utf-8?B?MnFDM0ZYMExlTFNpRGxkMXZYd3NQcW5pbGFCQ1ZGRTlJU29UbGRjblhxcG5P?=
 =?utf-8?B?Zk1zK21EZlI5Vy9ZNGVJZUtYblVhbkRkUVF4NnBKWW9uNE44TVRTM2FMeVpt?=
 =?utf-8?B?T3UzUWdIOEd0d0Z2L09sTmlieStqakpVc3RBQlVTRnpCZm9tRGtObnFOWWg3?=
 =?utf-8?B?NHJkR2NyZ3JoR0RJNGtCTW5iL1Q1VHhXZDYxYnJkRUNPNzErS3E5QjBKajJU?=
 =?utf-8?B?RXRaZmtUMTZCVDArVzF1QjUrZG9Bb1djYjgwTDlyUWdqMTViVjJkSDZkWm1T?=
 =?utf-8?B?MHdVZDhzalNzQ2N0S25KNDQzSml2RzBDOG5mNkgxcEQxS2g3cVBuaFhkWm9i?=
 =?utf-8?B?VVE4UmJqL0JOK3NINW5Rd2xxd29ib05UKzlXZEJjaThQbStkeHdDRUJvc1Q5?=
 =?utf-8?B?YVFxTmlGcG1yY20zUG9tVlBpSk14dzZkd0xvUm5RNHV5bjllRTBmVUo5T1hH?=
 =?utf-8?B?QXNPSHowUGhkOVgvMWhyRUo0UTVFN1RydVBtVlk4Sy9GQTdNejZDWEJBV1pk?=
 =?utf-8?B?RjhCQ1U3M2ZXSjlERzE0SzZRY3dOeFBpd2ZKMlEvQVV3UWxpWnJ3Ym8zWmQy?=
 =?utf-8?B?RTZQbGJJUEtHc0l4ZnpGdlcxeUtEVnpCWGUrcVJ3WnVuOXhiV2FiSkhWUW5v?=
 =?utf-8?B?bDkwOEg1enYvUWVFVlBNOUdFbVhVN2l1OEM2UVA2YlhQMlB6ZEJNNE5wcmFE?=
 =?utf-8?B?NTlRUEVjVCtNeDUzZG4vMm1yM3pEWEEyVWNXV2VtQU5kV25DUDNKSHU1T2RC?=
 =?utf-8?Q?3/WlH0LU2m1IS8/62GZpdasFcwgh+kyh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1lGVEJEWE5hT28vQ1hyOWRiZDJWZit2NDE5OFRvNmVyRGo5OEQ2Qnh5OFBN?=
 =?utf-8?B?QkxOVEFxK2dGcGppanRoa0hDSzBnK1VJMEZ3RzdPdkEvdXl0MjhRQzZqOVZB?=
 =?utf-8?B?bUlPZ2pLaXhlc3h0MkovRktQV1I2ZDI4S0tnYmhrTFpCOGFyKy9GVEZORWRI?=
 =?utf-8?B?NXFjL1BBZ2xVOGtnUnhOUGQ0aHRHbDNHVXZaNC9pTXRCS3VXNGpIUVpVTXJi?=
 =?utf-8?B?VmROVmZYVmdhVmIyWU04Q01iMzVFRGlQYjhacWw4N3FBSUxPZU9TVzV2VlR4?=
 =?utf-8?B?bkl6RGtUSUtPR1N0Y3dGYmJLU3dQeFVvTnFyVEtXOXdtUFZlellCQm9YVDA5?=
 =?utf-8?B?b2twcWNmWTJyYVJkS25zL1MyMitjYmVlODBxcTZWYTNjRzhyZ3VXbEk3aG9Z?=
 =?utf-8?B?YkNtZDJTRHZtRWxvYmU3Q0N6ckRyc05rdG11NXFqYXRBTmRWS3ZRbTRaZnhk?=
 =?utf-8?B?d3p3dEg0Sk1welhMeDEzM1NQVVg1N1ZZeWtxUlI3YmtLYU1ncGp3Q1d2QVo0?=
 =?utf-8?B?VCtFa01WUVh3Zm1tV0VvYkdJY0dEQkxaa09ZUzcvbEV3Z1lUVkZPRmhLSmlm?=
 =?utf-8?B?OHZTS3pPUzBRcTZGamJhNkNEbGo0dlFNOEJqcDd3aTFXRVpSYWRLZzF2MmI0?=
 =?utf-8?B?dXFxekFWSHNxUFdJN3RiWHhoTm16eEMxeTE0WVpROXZta20xbExjYnowNnBy?=
 =?utf-8?B?N2tkNEE5TnREekNLTkFCU05NZkkxUDNpd0VkajM5bWlQamhFL0JORjVaaHl4?=
 =?utf-8?B?MElFY3dXNXlqNzR3TTc5WkZzZ0JLR0pCdldybnZJaXlDZ3ZvLy9xVWxIOVh2?=
 =?utf-8?B?VWZMSGxCc0ljcjV1MVFVR3F5bUplb1RWVXRNWGFEUW52cHFiK0Q5NFEvWDRu?=
 =?utf-8?B?UDdVRkpPd0cyeDJwS0k5ckxUYWRKdS9ORC9vZGt6UkRyWHBWSmZyUVkxOTU0?=
 =?utf-8?B?M21oeWFGakc5K2RlYlFQOFcya2w1TkYwUmE0RDNydFQ2dVRXYmlrVjN3bjk0?=
 =?utf-8?B?TTRRaHlwcFA2RUdrWnJvWUl3Y1RaN3VDQ1IvbDRFMUMzTEtsZTN1RmlxNGpt?=
 =?utf-8?B?ekJkNFhmSHdZankrMHVBYnBxQTlVV2taaFl2Wkg0eUNCTElmbmduRHVkZ2wv?=
 =?utf-8?B?clBUWnJLRzYrZ1NjYnpTS3pxNlJHdFBqQnY4K2xGWVRSSFhoUDFmelFIYkox?=
 =?utf-8?B?MkpLQ00yQzk2L1l1VUgxeTlKWk9YRHQ0Ry83eExZN3BtVmtCK0JWVGpsR3Zk?=
 =?utf-8?B?amQ3NCtETktNdEU1SmJkZ09kS3BpdGVzVDFxM2Z4dCsxWVhiaGcxVVRlQXdZ?=
 =?utf-8?B?M3NGYTJOMFFnRzJxKzh2M0tYWmQyeDVLdExjQnlKZFBKM0dESXVFa0NqTXJj?=
 =?utf-8?B?ZmVjdFYzSjg5ckhKY05wVnl2VWtIajIyQUR3UUZzanBqRW91U1FCQ0t6Q3dY?=
 =?utf-8?B?U29MVFcvaUwrbmpMdVZjSXcyUkVjcWYzeDZDS1JEWWx5VjRXV1M5TGhXelR0?=
 =?utf-8?B?NlhmQm13UWJTdTNuWE5YTFZSU1VrL3IyU0JJcWdCdlFNV2Q4dHpscE1iWG5k?=
 =?utf-8?B?Z2w1MDBsQzVKUWdScUsxSS94bnN2b1VQYzRac0VvNWkyZEJOTEhYUzdZaUVW?=
 =?utf-8?B?THcyUkk5RmFvbEx5Y1R4S0l4SWZMODlZK0Z2NkpGK0FrVWRLYmdNVjN1b0w2?=
 =?utf-8?B?Z25ORk9yc3JTSzhjeWlNOXQ3bmxGNHIxbzlEWTN3ZWRib2srNVEvemlhMS83?=
 =?utf-8?B?bHl4aHBXZ0FYaTdGNWYvWGFQUzl6blFTSGM5cnk2ZGg0SkJ4U2JUT2pZelZD?=
 =?utf-8?B?VktISlcrREp4aG4vSGZPSWttMEFSMzlNQWxoK2gyUS9UOUxsT0dvdVdUb1k3?=
 =?utf-8?B?a0JlUlJuOUl4TExSNzJYRHFwWFdsWE80NmtJdlVBSzdaNERPZm9PbWU0SlBw?=
 =?utf-8?B?eFhVb2VudkhtOEJneEF2cmVrWnhHSU1EV013QVQra29GS2grT2orMWMwb01J?=
 =?utf-8?B?azBDc3I2MVo0VEJtdHErQlVXWE53bnZLdXpOMDBBZkxkNFVBdmVzbEJmbHhS?=
 =?utf-8?B?Qncyd2IwYmJqdkJRQkRTbGhiV2E5VkZoWlZReS95c3dzU0FxeVM0NWZRNUQw?=
 =?utf-8?B?T21CN1FTKyt2ZzZMTzFlaGFNNnRJSnN4OXR6aG1QMmFkVyszYXIvY0V5WUFM?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f0SE7jwVB1O8h3jl+edh1nGizv/W9IjdY96aXFXR6hkQ6TIFKxAr1+YjHMq6XQZDfvCFc6Ibi0gvDkDxhiNV+ZQVDIALIMflV9rp/tUrPImfBZzv9+LvDBInJHl6RP29pYWl/t2h1ZckGR+PaVUh6k6ws0573GM7bElArg4Mvn5M7JFnZAI+PZ0lSocaOPa+AYL4ICtPm4dGX125uRnOFDqqSd3tWVnJUjPoRTnFRwpOM/9JtloJ7ZygbNSEACp03FtnT4Er1/gAA0f11g4i7aq8LDu6hNPA+kiatgKrzpo6tWRkmztJu7XOAtOp3ttqjfyhCGEjBEi/gj0F5xetaN08JV1w+tBAe0idUwhTOE2TLtnOBHtZLiZMJ45koXBwC6ZSBhk+XKV5JDmr8f2AKeZmJXqEOJ1y3XWea7LXOg9AkAwq3IDB3Eqa/6O8GYX3A112JjgOxdi3v4clvVxgyeHlbs40r/YAZpP0+om4mJp1TGhNTtGWsL5sDscwSC77AdRf0vcVYgHAElfiZEekXjwbXmWwhEq9nJMb4ym1DPyKG+kn7NaCIpxLbd3atPmEvo9yRuZliKE/NpLP0hrC7hUyZfnAlWuvacCmjaqH7cY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7401a794-6723-490b-4424-08de20f5eeac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:42:58.2046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul6vaxmh5HrVIFYdD3UfRKEu1BdckZJPK+Atkcvi1jDnWkmiV4Ll6LgYNDo4alnY3LjnZtEiz9i7Av6J62hfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAyNCBTYWx0ZWRfXzqXwkfJabvxS
 vcKF2Syh/skaoHOP+jVItTUisB0YKbmvaL9tb2yvXU/Ht8z50N58XROM1UeKShhQ0vJn/q3OikP
 Io0PqsnCZE5S7PfPkxXVASGVmdmISt4um3ZYI1TRrESaSK6YYGA18khC5B5Dxv8LkHuv6QryA9L
 dXeD+OMn668Br8PXPavxQHJH3OCuO52RphJG2OQ7cCq3s5+F1qnjXKAWJc8wtGVEsjQULrsSQO3
 X+xySa+AqGt5j8Tsf/2odvzDZh/4IkiTNp7voMPFkN+HzklWnu0OH0VV18zPPTGA2XN6fF/e4LJ
 Y9vmsYwj+smnuzxYne6DRdqnDEzoz9MxByohAvhe02GawfKUpP92/3z2RFhsxHxeR0TVdHR+EwB
 jTOQP/IrDwnLLQg9DiC+U4HYJdpGZMB/5W+6xnKf3Ln6ff4eXMk=
X-Proofpoint-GUID: gAatfP-Hsr3J4-eyW_RJHQqT0KjOVdjS
X-Authority-Analysis: v=2.4 cv=M49A6iws c=1 sm=1 tr=0 ts=6912e906 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=TpFyzyTL7qCKQcCO:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=O_D8zxagIDzBWypiaPcA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13634
X-Proofpoint-ORIG-GUID: gAatfP-Hsr3J4-eyW_RJHQqT0KjOVdjS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Ping?

This can prevent un-predictable symptoms during Libvirt/QEMU live migration,
especially when hotpluggable='yes' for vCPU in Libvirt XML file.

For instance, vCPU hotpluggable='yes' is equivalent to:

1. Create source QEMU with "-smp 1,maxvcpus=4". Keep QEMU in prelaunch state.

2. Cold-plug vCPUs=1,2,3 to source QEMU (prelaunch).

3. Continue source QEMU to running status.

4. Create target QEMU with "-smp 1,maxvpus=4". Target QEMU remains
prelaunch/stopped.

5. Cold plug vCPUs=1,2,3 to target QEMU. They are expected to remain in stopped
status.

Unfortunately, due to the bug, vCPUs=1,2,3 are in running status. There are
chances for them to start running in KVM guest mode before target QEMU is fully
resumed during live migration.

As a result, anything abnormal can happen.

Thank you very much!

Dongli Zhang

On 10/10/25 2:36 PM, Dongli Zhang wrote:
> When a new vCPU is hotplugged, cpu->stopped is unconditionally set to false
> by cpu_common_realizefn().
> 
> However, there are scenarios where the guest is not running, i.e., when the
> guest has been stopped via the HMP 'stop' command, or when the instance is
> a live migration target started with "-incoming defer". In these cases, all
> existing vCPUs have (cpu->stopped == true), except for the newly hotplugged
> vCPU.
> 
> Unpause the hotplugged vCPU only when the guest is running.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/core/cpu-common.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 8c306c89e4..789382cad5 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -30,6 +30,7 @@
>  #include "qemu/target-info.h"
>  #include "exec/log.h"
>  #include "exec/gdbstub.h"
> +#include "system/runstate.h"
>  #include "system/tcg.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
> @@ -263,7 +264,10 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>  
>      if (dev->hotplugged) {
>          cpu_synchronize_post_init(cpu);
> -        cpu_resume(cpu);
> +
> +        if (runstate_is_running()) {
> +            cpu_resume(cpu);
> +        }
>      }
>  
>      /* NOTE: latest generic point where the cpu is fully realized */


