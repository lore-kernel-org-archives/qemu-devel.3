Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13FCC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHgy-00009a-Ot; Wed, 26 Aug 2026 13:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzHgn-0008II-U2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:45:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzHgj-0005Ye-VM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:45:28 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QEu0nS2686123; Wed, 26 Aug 2026 17:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ZEZbW/ADvP8XaW472Jfqvtxv40CHfP2zrZenohBUzmk=; b=
 VqTIabqBlfF6YDcNXPRIYh86ZOiMgCB2cn/X9RgwU6ftF6N851xzgPaKALESsj/b
 ps2vXZyFf+2CWvQxM3PoHi53yGTH74VQzT7SG3lV5cS2+EZSZSeHcT4F/YhNGWBc
 7SmOCFhDU0a4mJIHv/3x74/hvv5BeaKSakkJNLBZ7/3IZ6ocHnZFHdoPc6yHnqgR
 W7pIZ4+y5Vf7nHnb5SVheK/rN8jxUiDB1u12TCJ/hvryAYr+d5lyVs8qN5X3h7M3
 76Ef0nirKJUQQydmpe+S1JDqVS1tccGz9W/3bsYNy86N7lVpuos4jkZ3ifsoJ6IG
 AOoixOGL21tx0qjyfcrggw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72p9xkun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:45:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67QHidQs023823; Wed, 26 Aug 2026 17:45:19 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kmnjqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2026 17:45:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnOXHPhrHzkcFg/dzIB7DJ9NvlprvQxtkAfU6bNknHwte1u620SDFfU0/9HlfROGEF4Tn6/IiCoB+x+ldvQFqxZl7ifuTGjwt0f4MjDO/+E2CRQj3nPm54Jhyh/N8dNHlU6pAGnEPXxGuWGzfJjC79j/yrSZz1XcSMBhhhOMKFBo0tKeVwjTM4PHxUOELxZ5fX5673drTcTDTlFZFVph8SuN6cepVsQK8FZXiTQybi0S+hp8O/jcnLnZ0pSfYNbay914ZAF1h0MZnqjumBC/Mxq6eFnt/V21UwelcVyym0exMwOM8BpOw6b4RYjGNeyCgb10DOiOyABpdCtHLqL0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEZbW/ADvP8XaW472Jfqvtxv40CHfP2zrZenohBUzmk=;
 b=dFIkT5+YrwPSa6Tl3xf2UGNOqjqEiiE4L68TGxF4iwf6uH25bF0H+4unFd/IPZDpMFmI0db8X6SI8jlV0iKMvGP2HHn1R8QXoltah3I35znplhX1Zg+KCb9nsUWNaJlUh7Wn5AONMjAetVpH9Dof9mlrhNA92TbrKQpFBktwWmQ/BdmnEtiNp6/c6Uz0l/PiaKlml6toGKINRKX01bfLZBBMr92F/pQu2EMmgwdC0FVbagekFeMthI1f5kCc8vai1qVDr1N3GgT0QIRWB28L82Hv4PFfBYBbtJ+c0UdmRb/JMyxRSADLP1kjwG4Kru+LcAFeXCKSP7tR/g3U3FaIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEZbW/ADvP8XaW472Jfqvtxv40CHfP2zrZenohBUzmk=;
 b=mRHOKM9vSFgPylqla+o8nS8ush5NFWy+Qon5kxp5RqYOEsYihOW4ewdPpVhDIIZv6JEPxZZa4Ajs5yOR2Z0LePp/u7SIVzPcGr1L+yhLpJHh8Pdo9fucuouaPYNn53/mbACy3f+262+6Zj/VgEEKajBpIL7fKrWHoTxZhFJptcI=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by PH7PR10MB7719.namprd10.prod.outlook.com (2603:10b6:510:30c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.6; Wed, 26 Aug
 2026 17:45:13 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.005; Wed, 26 Aug 2026
 17:45:11 +0000
Message-ID: <7d7496c2-79f0-444d-a843-5f5bba467560@oracle.com>
Date: Wed, 26 Aug 2026 10:45:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, maciej.szmigiero@oracle.com, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
 <87a4qg0wv9.fsf@pond.sub.org>
 <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
 <87h5kkvxni.fsf@pond.sub.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87h5kkvxni.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::11) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|PH7PR10MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d334ad-efc6-43e6-4ec3-08df0399c6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V7xXEmnPmItT6I755MNvjhcI6oMj+11QnzEFO9c1wqtkX1EirTpKQ2wvXRmWFl/LdKjWaGqp6OvKYCxvs24aGoihKvGK1iTJrV079njRZ3gq+8WwZZxPc+MIwlrsq8CUAUxjyjOQRX8AI2wdq2/WZkenfAWYmrB7F6r3YoSTL7iE/Zfc8St7LxKUpN78vGpVq5xSXQULKVtz9t1vlEo+8SQnHV6S+4jR1t1ci2SSF3Um9g1IYkoYPNVK8gKWMQelUlEGcZrcwyEmCgY1na3kmlx+99USy2eRpeVnb520BISBfZMALSjmwZNYYKavWTpMa5//I6tcZi1k6KJZenvEsYEbLMR1SxOnDX48+I09TNYIlVx9C51t5EByksIYSBJZ4O+UMuaqNzFXetDZBkEYGnne3hjXInL/uPg/rgBHQnxr5YW2sVlmbLAqbWqS9aebSwxu+O4dSuujzBbEyLgUmb1cdg3/YFQ/tlbh0Bodq7fqEj8eBG8OQXWs/fiuKA2fu+5W+7IA/g0cpI/0bYXoDpDOFvosDRFGlJKsUvcl5ODEdWR+1j5//H69EXbWPLbHCgobQp3PG8W94xqzCzGezcvdKRdZj5ZAYUiTHkMzmMyVO15ncg2iVc1NZhDhyEx3jk1ISz/5gZwMqKU+6LPJ8f8DApTQ+uHN0+FPczrOhy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUY3NHd3eGRVd3NhMC9qTWRuRzg1ajVSd21DU1duUzFNVFZHTGFTSVh3SE5H?=
 =?utf-8?B?RHNmZ3dmQ3pxdGlSd2RYVlZ4Zm04dTNKalAwcUFFcG9mVWUyTkNHWU4rREtk?=
 =?utf-8?B?TFpGTXd6YWdGMFRUUXlNWTRTZ2xvVlhHZzV0UFhRMkZuZnFnclFaYW43a2dV?=
 =?utf-8?B?Z0JGZUhTTE8rRnFmUlFMSzVTMjN2dWpUNUNsRzBnaytGaGkxWFI0amwrejIr?=
 =?utf-8?B?ZmZ0bkFlMGptT2doUWtRelJRMjdTdVFrc2Z5UU5xcnBnTmdGb1hDRmFYOTJI?=
 =?utf-8?B?cUx2UGZycDRYZUJhTG9vbWROWGFwRmRSenFJaFdyWGV4MFRzRklZUFVaZGI3?=
 =?utf-8?B?L2ZtY3ZZY3hQWDFSTlF3dDVac2xxNE8vVFF0dzVVR1MyaUMrb0szaGo5eWNr?=
 =?utf-8?B?a085MHNZVHlKVnp3S0k3UW56SkNELzhPOWl2bzFlZWZZaUw0Tm1GNXFMditt?=
 =?utf-8?B?RVRuSVA0dVZtcnhiKzBrUFVnWGFIT3piT0d2dE5qVTRJWjhPVG53aG5FRFZC?=
 =?utf-8?B?OHR5Z25KajFqWUFZclRBR1orbXF1REVCUXRSaHVlUzVhb29zcDZKdUx0WjEv?=
 =?utf-8?B?WlJhais2WUVCRWVYQzVEV1BuenVZUGl1MWZJRGMwY0JaN2ZqU0FCSkFlTnE4?=
 =?utf-8?B?c0paMUhRSDB2aldCdmtOTVNFRVgrOVVzK3NwK2RUT1E3TFB6ODU2NkJnOEQ3?=
 =?utf-8?B?RGUxcHh0RnZQYzVoTHVraEwyeENhTkxyM1psbDNHQ1lDMmR3SDNSVG51WjY1?=
 =?utf-8?B?R1lHNlRvYmhlTC9xalZQdDdXRjNnbFlGRnF6WFcwamQwSzJDYm5ZOFpTOGM1?=
 =?utf-8?B?RitXblZkY1J2ay96T24zS0hwMFpmOFg2NTBLMmV5L2ZCWDM3QjlkMDVqbTN3?=
 =?utf-8?B?K3BvWjRSS0M4T1BGZFhQRVpoYVprY1hQamtSN1U5S0xaYUhmTEFTam9Nc0FX?=
 =?utf-8?B?cllkTUdWSnYyandRUmdHVURYbnczandVam5kcEg3T3pDdHFmUGxZdCtDRHpR?=
 =?utf-8?B?Vkk0cFhDS09xc3N3eTRDckdRT3pTNHNtZklVOWJFNGRiQVZTMzJBeWxqMS9p?=
 =?utf-8?B?WGRNbVlZZUFKV0VGS2pCVEJVS3F6KzMvQzBCckFmUVRPNmZtc3pOTHkxRjJC?=
 =?utf-8?B?Rk5BV2FxUmtQMTB0Syt4NmdoUlgrWlZ1WXJvU1lkaWFqZVhmbTZtTnpYTHZw?=
 =?utf-8?B?akxVV214MGpjUkN4WTNUVXVmK3ZyVkVsMzh4emFWR2ZEVmZZelRTa1pNQUk1?=
 =?utf-8?B?dHlVWjUrMlBjd0R1ZjVRaW9wWXp3VDRpR2xrUHFCWUd0c3VVNkpxNE9wU2hh?=
 =?utf-8?B?N09Va09NRElnazJKQnVYNlBOWndXZ2dXRGVqTzhjeDl0R2xRdmRnWTN2bVNw?=
 =?utf-8?B?YlZtYm1aV0pRTXhyQU41NXhXd1REczl1L3hhQTBUbVZ3cGZDOFllMmpKZnJF?=
 =?utf-8?B?a091SktkSDFocGFUQXBYM1Fja05KVmUrTWROSk5aUFMzUm44NlY2NldCb2Ry?=
 =?utf-8?B?M29oOVhVdm91SWEzU2dwcU5pRmxGSTJQSDArUDQ0RnRSUUdFSW1oZjdLbHVh?=
 =?utf-8?B?TWxPaDdDZlVqNW1mVUlML0JRZDUxb0Z3V1pFeUVSWG5SdVhiTDRVMkFvVlFN?=
 =?utf-8?B?QURTY2N2bEloYTQ5Qk85NEEzc2FabWpJS1V1MFhaMlBaSVhZRlJ4UXJ4VXNW?=
 =?utf-8?B?cUlLblF0bXRONHdCcFNvejJ1TG5iUHZqa2U2dEtEYlJnS0lRbjRFM3VkdDcr?=
 =?utf-8?B?YVhSQk9PbjNGbkwrb1cxQVo3Sm52NmdvREhNbFNSSE1jclcydy8xdVBGekdD?=
 =?utf-8?B?Qkxpb1RzNmtjZTFoUmF3UUVBRkFSVlhQaXhyUDc3Rk1OczFIMDdIR1o0OWZo?=
 =?utf-8?B?T0FCMVhOSThmVDRPUktDa1hUZU1GeUVuOWNhMWVmWktqREQxQVNtN0oyc0J3?=
 =?utf-8?B?TE5DTHpwRDQ0VlN6blEyKzBYa1dENEtpUElSQmVobEJHV003UzBCWEhuN21m?=
 =?utf-8?B?M3VINlNaUFk2bTQ1V0JwNEo4a3ExbnBSWWF1a29TemIrZmJlSVduRFB2VUMz?=
 =?utf-8?B?K0U4S2kyZnN3Rmw2ZTFySEpYTGVrZWFUU2MvRnRhUWRXdy9pMmJHMENWcjdX?=
 =?utf-8?B?Qm43dU1pempPQzB2N3VJTVNOdC9ONlFReWtHNEQzQmZBbStDWTl6aGl4cjll?=
 =?utf-8?B?MWFOTnZQQ3BveWZtNjNpaXQxWitRNHM2ZUZqRVBVakZ2cjF1NENyM3pMakw2?=
 =?utf-8?B?dGMwV25CaXVKaWJZZUJhaUZscStXNGdpNEdlQ0hlM3BMYTdBdy9ONmx0cXZh?=
 =?utf-8?B?MGZqYzJTYW92bEhISXN2ZXZ6dk9QTGQwTFVJb3F5Y3lldDlmRGlxQT09?=
X-Exchange-RoutingPolicyChecked: uJ9i8gXicTDjkEx+6ZuXrQIj/rXeGxgZ0J2knPzqifBgI/qB2cFO0yrZA7z043RWKalyeCSHDXEGoMXwew9pCpaJyxIwPbUz1vv99cqaCa7lRJcbxbO2ClVUM8k4Yv12G9G3E8uX+BSjZBb9CY5/eF1ShPknd01jBJEBQikHc1xb6anMv6hogBJbXU4YKiNghTEGdNa9c0hjxWAN8eFdcNprsRFLBgdFo4UwOyQLspY2Pai5upQurRQgdBRUxGQEb+w34uBRezFbTaGm+uAu6tU8wKiYUr17nvK3PfYX+AOUD9b2eSXx+AuaHSRqvd2Gk7xY1jrQ56wCITJRV7sGGw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nemF1qzUqUAQqhDD2wYSpRwXTkVR3R7TXFdENnIR+36Nw/FnIyF28sbC1y++/Kt7kmnuzoFqzzlWNt8glPM8shxPk0gyR9M4Rg3Z+M+NCdY5eJmudbxETcQ4VZ6Ynvypwsl/YVlrrDVoZc+jmbIpSnZOr2iDTO5mB839k1t8dva1MD4dNvZ+Gv0o4KA69D5neLm0l51Jl6EWPAvCUbo9VdWAF9XeJ+cs3H+AmkUDCk4bEXm4blQfx6CZNa5GtDG91R5yqCdbGyHgKs6Np65eOc4kHSy3JFhzfulFVDk1ecbL9VPEeybNi24O/73ra02LuUF/7mQxIagRy+Vf5jsa+iQpPAEPKyI7T8DC+GMSqPhdiPcZid8wMwNckIAfw2KtQtXJB//pptoIFpNwGVFY5jBgfjI1BKa/TdiykZ9pMirBwaGpbFEqs8/TAKM8bh6/+6giCC3kdo/nshmdY4ox+84GP3d/cIvX+Kr/9xk6/NiqFkt9nHCVDnEUaTEn/pAgHLVRSy9f5pw4m4HpWxEvNYXY669BjCqxyJbw1nJH740FEp7I5UtUmzCZp+k2a47yFUvq3VBO9TUAPm8ooB0s91q6bP4hbvm8rZSU65BuK9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d334ad-efc6-43e6-4ec3-08df0399c6e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:45:11.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umBE8LZrleR9gKxUW1FD7/qrubuychyH6J5Pi1SWaleDBZUNPIRZFKAnwWVy50NkASxWBPRVT+5IHif5Ili3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608260148
X-Proofpoint-ORIG-GUID: iSd1CKQ44zC6FM9Ya1ALiJgBZO0AZOS0
X-Authority-Analysis: v=2.4 cv=EqfiaycA c=1 sm=1 tr=0 ts=6a8f2631 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=npi6UjYAG10CQnxpFNwA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: iSd1CKQ44zC6FM9Ya1ALiJgBZO0AZOS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX6vvT6w1xPJEN
 fzq8puw8SmtXA/47MlKGevNdN/4jJilslgkeMdYFRrCQdZ2sE3rkJbg2gWarHjOLdYoz8w5rJw1
 kyT5+/U+sw7ubffvaRk3pqBd2jDBni6jCyXYNsZvXdAuA2quMolqVOIj6cg+AgzHgH/lGk2CVaw
 gJSbV5EwNBbaW9ZlISHW2WUKkzsMApS9F2rsRcG3wFxbGS+1F2d139VhynnA85j/dW3O05CEnCX
 eWNj+sH/EHmybAt6CSg4htMHwUsEk+iKa9BUbgBUyFbSssN7oZl24+ftOaEClKp6fXh6mMV6ojg
 x/F4kBf23vN8ezHcT3aS/xg5RUVdVArew+xkcAhaDZQaDuiRblCjfUBnzW0JbvghnVXznMhxhNc
 oGGwz0mevJG50H/b0OXyHlnyu2BhGDFfNFGhuYBZCxVEC2zOL5iyrrLIdgntcdHI8KuazC9ew1s
 DyTuwC6HpsCXsDu3T9qNMvlkvvxVd4XyjCIcilFk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX0ZiJaLQ47hCQ
 Y9BXq1W/lsLsn2hv/IIwEGHbK5yjtpwZohWWs0UY0F4amz2lUuHcQK8MC1m+j5qw9Cip2mfPy9t
 Zk+8wqloxDvEzRQUxIYTjiS9UXrH8O0B0VYPJ4NeB3lhGhNM5l5e
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On Sun, Aug 23, 2026 11:29:53PM -0700, Markus Armbruster wrote:
Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> On Fri, Aug 21, 2026 12:13:30AM -0700, Markus Armbruster wrote:
>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>> 
>>>> On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
>>>>> Dongli Zhang <dongli.zhang@oracle.com> writes:

[snip]

>>> message.
>>
>> Sure.
>>
>>> 
>>> We should also help users decide whether to use the feature.  I gather
>>> it's useful with migration mode cpr-exec.  Any other use cases?  Does it
>>> even work with other migration modes?  If yes, which ones, and what
>>> happens when you try with another one?
>>
>> So far I only added support for cpr-exec. I have not tried othe modes.
> 
> What happens when you try to use it with other migration modes?

If I use memfd transport without cpr-exec mode, it will be denied.

The code checks that only cpr-exec mode is supported.

(qemu) migrate -d memfd:
Error: memfd transport is only supported with cpr-exec

> 
>> In my opinion, cpr-transfer could also use a memfd-backed channel, but I am not
>> sure it is necessary.
>>
>> For cpr-transfer, the source and destination are separate QEMU processes. If we
>> want to pass a memfd between them, we still need an IPC mechanism that can
>> transfer file descriptors, such as a Unix domain socket with SCM_RIGHTS. That
>> reduces the value of using memfd as the migration channel, because we need at
>> least one Unix domain socket anyway to pass the memfd fd and coordinate the handoff.
>>
>> If a Unix domain socket is already required, the main benefit of memfd would
>> likely be performance, especially when the device state is large.
> 
> We'd want to measure the performance impact to see whether it's worth
> complicating configuration and code.

I may create a VM with many virtio devices to maximize the storage overhead of
the VM device state. However, I don't think the goal is to improve performance.

> 
>> cpr-exec is different. The new QEMU is started via exec(), so the memfd fd can
>> be preserved across exec by clearing CLOEXEC and passing the fd number through
>> an environment variable. This allows us to add a memfd-backed migration channel
>> without needing an external file or socket for the device state.
> 
> What are the actual user-visible benefits?

The goal is to avoid the VM state file used during live update with cpr-exec.
So, the user-visible benefit is that the file is no longer required. Live update
with cpr-exec no longer relies on a file on disk.

> 
> Performance?  Provide measurements, please.

Not performance.

> 
> Simpler configuration?  Not sure that would be worth the special case.

Yes. No file required.

"migrate -d memfd:" vs. "migrate -d file:vm.state".

"migrate_incoming memfd:" vs. "migrate_incoming file:vm.state".

> 
> Anything else?

No. Writable storage is no longer required to cache the VM device state file.
That's the only explicit benefit so far.
> 
>> One potential future use case is LUO/KHO support for QEMU. In that case, device
>> state could be preserved in memory as a memfd and potentially survive across a
>> KHO kexec. We won't need to preserve anything on storage. Indeed, I did some
>> internal tests using memfd to preserve device state across kexec although using
>> different implementation, and it worked.
>>
>> For other live migration modes, or even local migration, I do not think this is
>> useful. For example, saving to and loading from a file won't use memfd, as the
>> QEMU processes are terminated during the this process.
> 
> User documentation should spell out when memfd can be used.  I recommend
> to make it usable only when it's known to improve things in at least
> some scenario that matters.  Code should cleanly reject attempts to use
> memfd when it's not usable.
> 
> User documentation should help users decide whether to use it.
> 
> The commit message(s) may need to provide additional detail on how
> things improve.
> 
Thank you very much for feedback!

Dongli Zhang

