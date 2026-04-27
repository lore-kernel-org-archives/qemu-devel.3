Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67BBFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSjX-0000St-FS; Mon, 27 Apr 2026 16:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHSjP-0000SN-Dl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:39:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHSjM-0004A0-Mn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:39:03 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REMOBa4150162; Mon, 27 Apr 2026 20:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OVqZI/3CyBg8s3G2Y1lExgkB81YoZ5OVHHBHYeMU5IM=; b=
 dr0O/zLLTAQJOXp6+Ewp+EZRUuCZnkreNl8CEGDYX6tCzH1gkSxduuiMpVNalexm
 tqWZWpBpQx6RnPyZj+UZIy6b7bNQXG7+wpHVe2SxOMyhN5S+GRFG8WUNa4x9B3CU
 AXQJ6AlDompLEBmwX9/AQ8K5aSU5FIZe5KmdttrMYg/Y8NHxTxuCYXm80ajftnBa
 X5pYVHb8pHG2NIDsNzUW/zYpPcZIaK68XgZckYl0R5WFwVfxxDGLAFIl5oAW7FAB
 Ke1+91Jwum9JUXX3wOd/UEh43K/Muka8E/T3lSTv2yIZP0SQ/Nz3JEsjr6PkMXJt
 gMe08+DOrrJgB92j9VKrhQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drnnecc9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 20:38:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 63RKaDul025062; Mon, 27 Apr 2026 20:38:57 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4drm2bhssx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 20:38:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7qhwHcUbTvmk1/hRMryRym0pvLt8TSPtPv0P8j68+NYq5pNUZVesn2OH2VkO8XBvjpJLJFMjiHyRZP41sPCzKAi3waMKh6S821SSa5n0ogE7MPI038cBqVjEkAAdOucF1Q9ofjgW0sMBOESbWoLjeinNZgRI/oB/GOpCwOBttfi0X7kSCgwVJcZyRYwDpThqIMUeRY3JD7ZDqiYaJf3i8t1/7EOK+YpDh+j6O5Fi3U3HI9BTOD40Ec5INpA5EW4jwycw+C1yU829M6kIUDuIvR9HCLaj+JDxCDEYjqKZ8rAtN3y75jPPetWlZnKc2/ZC3+n+zHoQxlteBnqLHqy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVqZI/3CyBg8s3G2Y1lExgkB81YoZ5OVHHBHYeMU5IM=;
 b=UaFiMxgNZcQGoJZ4MCF+ipFYsRIdTsnTBd2qGa0Gmi+SxH+5A1V4oE6YuvguzVv3Fd8/uA4aQNwidPwlqC0wQR5gFqp9EPOG5fAVRqVBflwUbgRW1OV6UEirRnfy/9SnAKZk0BAcm1cOSf30C3Vh5AJKQrIaoPll1KPNgTdohY16riZGaesdJhvogNw3BMiTWlUKXi8ZnsulFM3vl0JqCiXLomKLh8MIDUvaoMO2//8aOZf1WPXfiN3k389q/RF2OUWIOfeH09txnBKO1Lyd4joHw4kZ8ojPWJCdHQgzCw1F8lgQ8lDgoNIxPUs1BTj/dYU4Yn23rhFj94/KmLnH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVqZI/3CyBg8s3G2Y1lExgkB81YoZ5OVHHBHYeMU5IM=;
 b=t2Y3qcUNh2q8p32oEH0GMMZTI11r35OfKFcqFm0gnf0e6RbhSzziSukA+zgnWZ11sDi7WhyXz4jkGWtrxgKYQK2+rR5jKySgdm53VGgpmTVgHu6T12YXxZIFxPOzXaOUz7jOMxKwcKeIyX4xrbn5p/pM+pW65y+SHxwi35m8JA4=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 20:38:53 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 20:38:53 +0000
Message-ID: <89575bee-ccbf-478f-91c7-fb7759e47703@oracle.com>
Date: Mon, 27 Apr 2026 16:38:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/41] hw/remote: check visit return in
 vfu_object_set_socket
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-6-c413f3605311@redhat.com>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <20260427-qom-tests-v1-6-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::15) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ecbe59-cd4f-4ec8-d12e-08dea49cfeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: G1BxDs1hi0du+drqo8X9OF8MDTsh6V+tiGS+psH57nXVLsWpUvpISo3AqVc6mB9tsTMTKhSq03Q1orZo7uO4ukOayfKK/hjSuQd9yyhrTwMs9Ox3brB87Z7K0MLyLPmO5H3GdXeLLngdtDi4U+5ssn0rmxHHNN0ukLGocWWTPWlq1IPv/Lz+sdg357eWhGIqYXURGZAzOhP+g8qJt9J0fv5IdORyVvZRpzapEsUPM0o90nOJJw03GuR/lUnsK6INQB+EvV0GJRltOeacTaYIS/FI1EWqzCvPGR5df8h6g9iebSvimGTboZxI4hs5nTDvQKebF6bSiS57JWBMO4bw5aMAAHUqdMSidopbETSBh9lnUe5jQOGmNCktPULBuQ8dFWq3qQIiN/4+UagfSbBFTLpex9BqgffETJSv3awQi9ni+aKlxOQ9EWiwJeKQ3wQTmx2LLgzc7BoIYhYERDRTXNeZHzvmcKSyFLh91B8LH+N9FyJr8L6E85VZ5YMnizII0VIySeOQljoQOg+JCAeaiE1NhxuehkMMicVqSvulTvSZ1JqagzuVu+IsHCUCsvlczFdlwQ18lptgpZ4sTC1aOjC3SrxqVGAX0hXp26tnajoVQbO2AeYv6C3/d5t7v1lH1OMCa/KQLKT/Hm073HkVgWEG3bv2P/6zzMPXbbhfj4lC1gtEYAEIyXJyZ/Qw1LBXRo1xKRZbz4cJTaEMAbaW8rz1SFKV6JGlI3JZlfEqKcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZXR1IyTDJDN2ZwSmlHTUpabVpvdExhYkkxMW41ekk3MlQyQWFPb3FBRXkv?=
 =?utf-8?B?SG9pZVpzUE9qNVZUR3VDZ0Q3YUpXN0EwZEw3aDhIN3NpTlBEVHJ6dFkxZEhj?=
 =?utf-8?B?TkJ0Z01ac2k4MDU0d2hLakIwY1l6OTI1Y01HYUpibFl1N3hEOXRvRW9pdHh6?=
 =?utf-8?B?T25HR0xEczNDT1FRMFoxQTB2N3dnSnBBa1ZPUmp4L3EyZHNnQXE2d2taWEJY?=
 =?utf-8?B?VXp3UlhQWEkrTm1aWHd4eTVjaHNwTjBwczR0bHAzM25jcS8vSklmZXo5dXJx?=
 =?utf-8?B?Qzd1cWhaUmNlVlhpQXJjZnYxakZaL21uT3NMdTd2NXdOSFlvOFJJSXdtRmIr?=
 =?utf-8?B?KzErVVVYd0xBVXZZZzBSdXgya214dXlvOXB5blE0enk0dm9OSW9GSGFjUlhn?=
 =?utf-8?B?TjhNVlNmcHB6MSszUnNscWowL2NKNk1QMzBwdDdtVG0waVZlZzNXcmhFc1ZW?=
 =?utf-8?B?WTBPWHNNSUpFaVBycngxMFNrdTMwZVV1UXo1MEhLbTc0MWwvRDBmTXd1cTR1?=
 =?utf-8?B?Q1VMaVhudW1nYVJDaC9DWUpFTXB3bHV5RHkxd0N1Yk1aTXFVTFpWZXBHRU4r?=
 =?utf-8?B?Kzg2Z1ZwRXpKVW1pMlpRQXdpblVsTkxXWHlaUE5FZk1MWDREOXdRem1TOGJp?=
 =?utf-8?B?bjVid01uakllWThXT05acVVNeUl0Qi9vcmFjdW5LSmcyc25PNkNwTTUyN1FM?=
 =?utf-8?B?bHdUOEdlY21Wdi9KVEp6NHB4TTNibk02SGEzN29PMDNZeVpZb1gwTkwzVksy?=
 =?utf-8?B?dnhqcVpiSVM0UE92MkVrSFpMcmFMTmpoZFBoV1F5bytOb0k4QUtMSlhrVmRM?=
 =?utf-8?B?SnhlMmYwL2gvR3Z5UnQwZ0I1RDZTUTVYallDZkhFZFowQnM1ajlBMm82bksy?=
 =?utf-8?B?bDEvYnBCU2NDcU8veVhxQkk5RzZpRllrOUVlRmRWV29PSDMwQTZHRGVleHdm?=
 =?utf-8?B?dzdWS2JCakRZUjhpZkFpaTN5T0FTK0dET0VsR3pGcWRtS1J5T2diUVk1RnNt?=
 =?utf-8?B?RzBQRUpDb2JieGg4UnEwUVpIQXZyeHBhK0FEVU9jeDY1ZzlUZWZxcGtDSTIx?=
 =?utf-8?B?WDBUb1A5QlpuTEk4TEcvTkxWUkNRcmhHMm9raXBjOTJ3bHRMMG8zdW41QjFV?=
 =?utf-8?B?QkhaNEN3elRTaWtOS0pUVU5uZGEzSEJnbHYwRkg3WVhDdHhBY1NxZHF5dEh1?=
 =?utf-8?B?NUdxVG4rM2c5YzJWcmc3OEpEMm9KOFNmN05sNWNWSlZGelgxaFNtcW9uc1V2?=
 =?utf-8?B?SzhXQVM1UnF2NUZkc2FLMG96YlBubE9BUExEQzNMdUEwUXJDWVgvbk1lS0NZ?=
 =?utf-8?B?L296ajNkSllDUlpjVWhycWRvekRrVjlxR2ZsWldBSW55eDREQnppUUdYdFYx?=
 =?utf-8?B?N0xOSkFZcmxITXFlTVRnSnc3cURWRDFCelBUZGNpZm1hRlZES05IWnQzdXdq?=
 =?utf-8?B?UG5UaUorTk9Oc2UwYThlWUFxZXFZd0ZyWHpRZ0RBeUF1KzlDU25uZ0w1clov?=
 =?utf-8?B?Mnc5SXB4YWNlZ2RWeThLaTFxZTJvcGpJTE1PZzl5cEYrdEJldGNaRm5McE9x?=
 =?utf-8?B?S2IrcjVCNWd1RTF1dG84cVFZN3ZhU2NyZHZxOTZLZTZkbGdsWXllZm1tQmpR?=
 =?utf-8?B?S1ZnUmdEZ050WjlBVGorc2NNbkRYdzYxRUZacXNYYkYwRTRjRDZJL3gyYVcw?=
 =?utf-8?B?eGRNeUNCUS9JbmRIV1NIbzN6SDdiQ3ZrWDNERkh2NzJjZURHaVFWZXhHc3NI?=
 =?utf-8?B?N3ZHdDZkbEJaWkNBWHNIb1JSM0ZjK2R0bkk0MDBMblR3eUF0OURXb0tLS1hw?=
 =?utf-8?B?em1DVTBEWHFMWnI4S0lnUzRQUWcwc1pqMWYvWUxlY3VWTVYyWUpHb0lmU1hO?=
 =?utf-8?B?MDhjNEVVNmhsaDVhUkIyeTBXbDludU8rMytBUGFYa1pSb2JOaG43WjVrUW9p?=
 =?utf-8?B?Q09tNmFpZm0zVHVXL3luSHlYRkhpQUFjUjFZQ1M0c0JCcTg4dlEvUWZZUGxy?=
 =?utf-8?B?aExKODlicHhBeEZ3d0lUaHhiZWU1dWxod1l2S3ZOOHExV3grYWl5cFlHbmQr?=
 =?utf-8?B?cWZOZ0VsQ28vUTZyTmlkbTZWalY5WmFFM1hraHZoVTdNQlB2c1htWWpsWmR0?=
 =?utf-8?B?c3UydzVlcWgzWWNMMmdRK0lyZGdkTks0b3JvanJEdHN1cG1LRDBhcWJhUGJI?=
 =?utf-8?B?NlZJT2RNeUZqbnM0ejVxMVNnSzFYcXk3TWlDNjdMSFVCTmNuMDJTQWlMbVkv?=
 =?utf-8?B?MFp2WERjYy9OV2tkM1JBelk2cjU2VWRKSVhBQndXQjBxSVUrb2JYTVdVYUVG?=
 =?utf-8?B?bFZBYWV0M3RZeTlBNmVHbWx2NHJKa1c1M0VFNldwYi94YkhNSURXQT09?=
X-Exchange-RoutingPolicyChecked: cwcrf3LawSjKsslSoHVYGKwdu6U+H8Hr8Z0i0feQ72QC1nW9mMQ6PPXmB3nk9rsEhg866CYMUV91UxxJVysZar2nW2nXPf+0FuwcS9LY5L89gQyH0Y8K6o2lZxlN4no0bdukj/kTXAHHliET+DuxQOHP13wAXvCd0r1OTdhkmUBPr06bOlkzUo8Mzw6nvwePgoXVJrmVBaOIg2e4FMlk3kOec0KpBbF7MMH2NN/ACq1wT63EwrehKTM1yAeIlIx9qB03VdilXuDMUBe5vLQYVa9OjnP+NGd+jutkIuWpbMue1y1NR57bfasskcRiEyv/GMoWkN1myIwq6IPLdDH63A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yf3GkBct3dqzUEN5HeNIHyjxFFMkXX6ibeKnRAv+QNvrGjgaTG7cnw/ZoaZkqfratmVLNPTAkvAxBEGlMwpXZfC0lcRJJXr3Qr8nHKVayGOrzyVbIhbMhF14RfBVC8iV4bmA6EWsVSFsskxW40a6WZ415NpxA22fFyTT7OPMYijqLL7dHTfBRRfWz9NK7ZTmP+q8nY5W6TYox6fF6gu0mctnoRwHLc8nu7nFhZwJcBKBQjoNpEan1+akF2Mbvd5rEClCYWf6pNrXYTI+ViXXO8C3lkYHmUKZzJLzxd7oDQ7wSeezQXi4Dkv4veEjcNRp4e+X/1ZJVz7aTk90Q/SF/ABOggfYM12WyzdZA/O0S9fhgP+1xikutZV3BQIR4biDH/Ur/L15iqzVX/ev0GIh3DOhFAIFoiBEYe2zh9w37XF902qn5Q/wy5hdyc2YmP0rEVujc7ncQSvSvhJokoswPw9+ETi/mK/KVurhU8e5wZMBuNYw4IfgsW5ZCZsb6CYMj2bAmBSpNbTryRFwsXaoVghd7rELMwJ3d4Aq1/yYqLL7x1OBjq5tSCM5wWXwj+kPCmWO9SCG076YFX1tcZy7/55Ivhc06uRue9P2EiNLweM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ecbe59-cd4f-4ec8-d12e-08dea49cfeff
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:38:53.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVIZgAjLC6rxxTLG5R2iUR1NpOaznDULUPUFvGwFJiXhcbVNx6Ks8PrPpPJul2IA8wvIyP807qGzgjzNKY9C0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604270219
X-Proofpoint-GUID: JHR_ds6hypgClvGPVRi-nt90V4OCjV6Z
X-Authority-Analysis: v=2.4 cv=Y6XIdBeN c=1 sm=1 tr=0 ts=69efc962 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=J7F1AQohEG3dLYkMgbYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13844
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxOSBTYWx0ZWRfX65m9/yxjav6k
 d8jCOkogrk+JIBSqFTZZt63YTOjp21GP/10e3KW314+uVskBnjmHdl43gE9oaKfXQhWMcc8ic8h
 Y+Rl8CHEbdlUPQQy3HYSQoyhKIC6cNntjZC6/d9YB3gDp2WTjWEWh3MBMoOLq+CiohEodHJID3/
 BfID3NyiRR9KvsEGfkAxTCG7dA4BwGPwc78BZ/w2whpERiFQYgq1VtWoBVgAlPgzmhwXCTk1h0q
 KVgYfM5XO2rcR3oXGKT0Zvy4Xjp3ZtrGRJmD4nTJTNRk1m+bnAZ2FhO7DZjeSkz7xdi7nCmCk+I
 gymS0tpwCkRLK7BeIleMXCdiHwJBuRewFGn7AWqDmQoMr8BNhYBjHCco7w1fIzGTx1hTvJpQtjY
 y43RzrdYZn5xmeJmLyU0mHGgcYcdp11com+UjTEh8odUJ1lNWA/DVhSbE1jT992SuZWW4bUYbLU
 yG5Ljdr9L18oAxpCLGcy1Pz/tIOSpl9M7ZXlKSSg=
X-Proofpoint-ORIG-GUID: JHR_ds6hypgClvGPVRi-nt90V4OCjV6Z
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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


On 4/27/26 3:42 PM, Marc-André Lureau wrote:
> vfu_object_set_socket() dereferences o->socket without checking if
> visit_type_SocketAddress() succeeded. On failure, o->socket remains
> NULL, leading to a NULL dereference. Check the return value.
>
> Fixes: 8f9a9259d32c ("vfio-user: define vfio-user-server object")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

LGTM

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>

> ---
>   hw/remote/vfio-user-obj.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 12ecdab6dea..49bf5ecae0c 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -161,7 +161,9 @@ static void vfu_object_set_socket(Object *obj, Visitor *v, const char *name,
>   
>       o->socket = NULL;
>   
> -    visit_type_SocketAddress(v, name, &o->socket, errp);
> +    if (!visit_type_SocketAddress(v, name, &o->socket, errp)) {
> +        return;
> +    }
>   
>       if (o->socket->type != SOCKET_ADDRESS_TYPE_UNIX) {
>           error_setg(errp, "vfu: Unsupported socket type - %s",
>

