Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A6FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQwZ-0000wC-G8; Thu, 17 Jul 2025 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ucOyS-0005gS-90
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:48:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ucOyK-0007CF-DB
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:48:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7gT3Q026225;
 Thu, 17 Jul 2025 13:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=r1Ck97U97GflMVeJAqNEOV2U9BdrdcEu0HyaWrliCkg=; b=
 fmE0Xd5PoK1qiS+o3b4YvuaGZPiwvhuU4toESK2S9XuVHh47zM79Rp6U0p2COJVA
 K8Ryo0RU5Or0ifONu7T0WeL50qFHe4v81kbZChm55xzy4OJN12G1zt3jGIGoikV5
 HGXNSAlsiQtFOg3irMzIwmn01Yw86pJYNhCTcZ6913NxQtHXCccAekxZlNFvlsUc
 vGUhICxV8rzdpgYytshMyOTOjho7+LTI8vdlP0Y5AB0Zwc5Bfscp/ydwzgOJe6uN
 hSNRo/SNQQQbMCAY1QbWECoRbV2mGmp9UhYOVQroVJUudsqq9AQ6BmL/taBOZtJu
 38NCD7IypRpaab7X1hBQfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx8394f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 13:48:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HDJJVc011593; Thu, 17 Jul 2025 13:48:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5cs2k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 13:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkMzB7ObS8FWFj2b+yblUVeohvSgIF7ZgJ5oMN/gX7Hslq0XH3zVvbvC+wSjtfu6zauwUJyB8KATX3231Lxo8o3ptN05erwRmoTZd1Olw4jjaWMFQNMubdwudea/z4NPpWVJr+ttKWzqRDdl91nPNhK4EqqS8rveFDkwkxvmCxHEZShGkSz7UEBXbXS4WXpnIbMALOXz+K0FIii/s1b9f478JsMi0hQqS3SqgTWxBYBMUUUPa5q/eNt7cIRV3jr7DaKH7JwxF7GdAelWq1KBqOPcoQDeTFFH97M1niKV7tKZ81cdpCCwI76ZTgfpJizPjCz0XQEgJAeNXaUMawr0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1Ck97U97GflMVeJAqNEOV2U9BdrdcEu0HyaWrliCkg=;
 b=Dua+UR0qX6dEodSpvekLuComdgRxWhzrvpw7pK11TbfnL4YNRQZPcgfBs/M2NS0cz1XqUFCOO+o9d83VDdxWo8OvfuN1oR2AcTWS4VVQ34Tki4fikwIhgIUULf6lCRaoG+WxELyCmySMDypq/CmewlJvnwWSWyL1bmmqu0n8yAhxApHOuqZD7xwkCQpefC/OtkkyROPe8gdlDveZcClrPkSAWJykIBsuWjFqpgQJSBqM4/dpxTfJe4vqd2PXmtxr+o2QGVwrSR/mIcZfcKvGPspcHAdEtSYVDvy0vI7Ay6Wq3byITi73d6uillCI6PkAWyaFkE222P1it/MbLmpjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1Ck97U97GflMVeJAqNEOV2U9BdrdcEu0HyaWrliCkg=;
 b=yZd/tvyWMovjJobq4QQGR8l13mFtOJlZANUNS053ub6tRIqyMu+mkTz5MMRcW5cxMdrfdTu1NrbrfEeumvaC/JscGm9zOOfXKGUULQaGylMWNhevkdi+YWpbvRBStym+1f4se8DacAlBFaWbWHAf9d4MEv0voR5UPV+pFvZUDRY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 13:48:17 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 13:48:17 +0000
Message-ID: <4413c937-5bc2-4cd0-ba25-617e757a07fb@oracle.com>
Date: Thu, 17 Jul 2025 09:48:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
 <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
 <20250716092916-mutt-send-email-mst@kernel.org>
 <9570378b-0084-4acc-bb87-7ba4c454ddc6@amd.com>
 <20250717020716-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250717020716-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MN2PR10MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e266781-c9e2-4775-ed5d-08ddc538956f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0F2Ky9aS0NTRGZhK3ljR1FnUWRMWHFMRHRIamwvalJkczFCRW40NDErVEdT?=
 =?utf-8?B?RnlNbEhUOXlPcGFDNzVuMWNyUGR2UVR3R2p2dk5CT1FNRXhLNmY5d2llNlJt?=
 =?utf-8?B?Tmc4NlB0Q3NJL1UvYk14Z3gzcEFFUkVTS1MzUm4vTjVkWUNWWitObkJxbzF2?=
 =?utf-8?B?bzdGK1c3LysxWHdQayt2QnNTamJ2MWVPRm9uNm05aUZOKzNDMDRsUzBmb3FH?=
 =?utf-8?B?cVNrdVpnZHlFRmJVQkh1VEtiTzc4QTZ2TzhBNW11UXcxM0ZLT2pMSGd0TkR0?=
 =?utf-8?B?TFZZekg4WWdzc0hPTm9LU2hPRjBCZFZ2ZlNkSjh0MlhzeXA2NFUxUFc0Mkkz?=
 =?utf-8?B?NmFONUJoNFJaazhjalhSVHQwa2xKcHFocmhJVzB6OVJsT0NkenhBdGZnSmR4?=
 =?utf-8?B?dGgxaFBHMDRhOGJtOTFoeWpEVkJzMUxzK1Rja3RWNjUxdkRNc3BXUkdNdko0?=
 =?utf-8?B?ZzRvc3NEY0J1REdjZEM1b0dwY2VUUENXUmVqbFZVSDU1SXhUNVB3Y3RjdnRP?=
 =?utf-8?B?Mk5iZ1RvM0dzTUw5K0tWRDJNVmdGNm1SYkcrZkkreUtLcGxOakZiZjhPb3FU?=
 =?utf-8?B?RW84M2xCa3c2WFovaTBHTy9Gc1RrYmdwc2duZ3dhRGRaRm0wU1RnU2RSR1lp?=
 =?utf-8?B?Q2ZEY3ZjMXkxZU1KeXNQanJlRjBlY3luQjZLMkFTK2JCVUE2UytJYmhkcEkv?=
 =?utf-8?B?RjkvbXNscE1JNnJMeEovT29SZDFmVE8rNVB3MGp5b3RUdXk1anFSd1RIcFV0?=
 =?utf-8?B?K3Q2ajdUVFJyY1loRTVlQXBOZWt4TVpScmhCQ0lqZVRhclFkOU5KNmxZSkZm?=
 =?utf-8?B?VDhKSUxLMHlSRGttK3B6cmlOZHBkaTNIVHdlNHVKNFdPTGJZSGRmNnF3aGlM?=
 =?utf-8?B?OWNCcWh4NENoNlhFWldCUk9tTzVKMzk4RGsrQXZYTUZjdVZuSXhiOGRXK2xy?=
 =?utf-8?B?MDdQcUxxQVpRVnMwRmw4MUZrZWVPQmdNWXlRaW11YjFNbml5OHVHaS9VNTZB?=
 =?utf-8?B?b3J6VHVwZ2FCd1dPTzBJM0xSYld3Y1gzYVdUMjhxSnRFR0xWVFVtWElUbndl?=
 =?utf-8?B?ejJkMmo4a01OczdSUkE2UmxTMDZQWFhMV3RJVCtDSHlKdmVVZGNQZFZpSXph?=
 =?utf-8?B?bG9VY2tVeUlRenZLdzZYdFp0ZSs0aHE3RWxYMkdyTDIzNFlFZGxOaHJkY2h2?=
 =?utf-8?B?aUd4d0dPaDR6RWNiMmVZZW5JaGRvZit2WXVwUXovcy9BdW5aNEpLbWllSVUw?=
 =?utf-8?B?cTFNZlVDMEVjN2xWbVE4UEwzVnA5b1l2SWtKZHZjbFBCK2o2SUpOaEN2Zjk2?=
 =?utf-8?B?bnN3YlNkcmFuZjlVUmZOYnE3MTNsWHVNbDVqbmlLQWpQbkVPK0NSd00vVGNR?=
 =?utf-8?B?N01NejJCOGMySDArQ052VzdBZDgzTU85Z1B0QnNiUjBnS1hCUDEwNkFoMEJH?=
 =?utf-8?B?UGl0Q3BZenVSN0F4YWt1ekNDSTRZV3ZNckV2OXF3NmpXbU1DWXFXU1k1cThL?=
 =?utf-8?B?T2U2NDZuZUwvbXJoNnBxZHU5UFRadmJrTE1TNXJnVUhPZzkrY0xFeDFWUko2?=
 =?utf-8?B?ZWQ0RVU5LzNJK1BIMTFXRUFPeWI0MEVzR3RvZm13M2RsUTZ5U3ZuejExUXRQ?=
 =?utf-8?B?Ym5ZbldVVDFjYnhadEJra21SVXNkYllHcWdHVnNOYTEveEZNQlJIVm5wR2xY?=
 =?utf-8?B?REVOUWMxcGNaRmxIUFNLMEZ4NUVhcTZJK0ZCMFN4aFM2Yk1BNFFYQmdjanhR?=
 =?utf-8?B?eFVFTXlqSEJaM3Erem9QcWFlMC9WQ1FJTXBBWFJUUnNPMmI1SkZLcng2MGlX?=
 =?utf-8?B?QVpxQ0JId0NQeEFMb01XcXpMZ0dNVVMzZ3J0RzQzSmQ4Ynd4VzhlaDJHK0c2?=
 =?utf-8?Q?xDZk+onRsFqPE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZiRk44MWFwTTlSQkhWYXVEcmU5WHByNTVCTTIvTjlEU1hPRTNnQUM3Ykpv?=
 =?utf-8?B?dUE3bjh0dSs5RjhRRmh5aGg0bFlROEdmbmdEaUF1d3RKMW9SNm5VNFdTcFIw?=
 =?utf-8?B?cnB3NFA1NWhqdDFXSFdsWnRPa2krY2k3SzZGYjEyWDhHanlKZ2YwbmhBSlVz?=
 =?utf-8?B?Zit6Zi9pdi8yVENYSFZVZG5SMmxuU2xEdkQ2SEtCSkdPTjRvM0QvRGc1WG8r?=
 =?utf-8?B?ZnVHQ21OaStFd0huOWFTeUo4Mk9Ed3pmVGozN21EZ0Z0V0hFa2Z1VTcxeVI2?=
 =?utf-8?B?U01DTW9yU094SXorVklOTjNYVDVWNzQxTnlXOWdXZzJWelRMT1B3SGljQWUw?=
 =?utf-8?B?dXU0dXNGMkxJdG9pQWxTS0cvN1FDbWhJL2tkQWpWMmFlOHFYMDRPQndKcnIx?=
 =?utf-8?B?aXA3NVJSK2V6bmpaM204b1lEdXZnRUIxTVNkbXlueWhGY25YVTl2T0N5dldj?=
 =?utf-8?B?V0Z5R3l6dUg0aU4rVXBIc1ZTd3M1Z0Q4TEdoWUVOdXphWmErQXhUQjY3Y1RW?=
 =?utf-8?B?YzJuMzVIcFhLVVY1UGROeWhqNXdLanZ3R0d1VGVESGFuMjltL00wbWd6WjFM?=
 =?utf-8?B?eFZheU1VK1NTZFhITVhsMzg0cHFXZnducTc1WVZDUE51eXRpNXNZOTlEM0l6?=
 =?utf-8?B?eEZOOThJNEVKNDdqNHVkWGNzUk5MT1dtQXNSd3l2R1p1dVIvOVZrbjhLZnRF?=
 =?utf-8?B?elFGMWpZeGRtalRENlV0Rm16RXBiZzRQaU96eGNCbFFEMU5pZ2NFRlVFaHkw?=
 =?utf-8?B?b2lxempVL2tBZFU2VVBlTENDOSswc0dtS1FMNzhZdVRWZlMzUGpXTVNYRVg4?=
 =?utf-8?B?bEFUZ3FYQ2FYaU1ZMFdxYjZ6OWZybTlSNW1FQi82WURPMENUaFEyWVJzc0NX?=
 =?utf-8?B?dmVpY0ZDZHlrdDZsWFhlbTJKNFo2SWFVRXUzazN3NC9JaFlwemtKQ3l5a2VQ?=
 =?utf-8?B?QWRsYnpNVHYzQXlZVzFiR0dodE95eng3cDFOam0xVnVrVUdPN2xRckU4ZjQ2?=
 =?utf-8?B?NDFMLzdtQ2M0cG82SGdmRDEzL3prQnM2NGlCdktuYUZCdVVLRzFaLytXNkJk?=
 =?utf-8?B?QzRHRW4yc3J2VDVCUEsvQXhNYW14bUVhdkcvZlBmeHhzVm9mMnovZ3JCOUFT?=
 =?utf-8?B?ZTJwZ1dTenBZYTBVR0twZFVNNmEvUjVHUVlTblgyL1NWbDlMNGhPMktUNGRP?=
 =?utf-8?B?dGJnaXF3TGpsSUYrZTVBcWJ0ZWpJWjAraVFWMEw3eWozenhnTTZMUlhhdHFE?=
 =?utf-8?B?T3hvM1M1RXZDS2EzRm5XTmR4Z1BwaWZXOUtGd21XczV4ZjBOOFJHWENpYm9i?=
 =?utf-8?B?RGNlSytHZTZuaUhoRUhKQlZZVlFUTGM3czVkTkNCTDJSM004b2NMM3dPQ0Qx?=
 =?utf-8?B?UHMwYnlpU3RhZFZMKzQwSTNiZnJyZEZMamp4bzJWUHNXSjQvYUxMc2JLbWlV?=
 =?utf-8?B?Rjd5QTRZQ0xmZWZjQ3djS1QwOTR4SzBlVE1HRURCYlpCWWpqak9SckZHVy8z?=
 =?utf-8?B?d1N6dWhpK2VnYytLWjBuSlRJSitSVVdLS28yK2hEaW1Rc3JtVlVRZS9JZ0FK?=
 =?utf-8?B?b1dDNWxiTmdkdVBDTzFNT3JkZnRoQkNXQzByRnZMUnc0UjIxTTkzV1RLbytX?=
 =?utf-8?B?YzZheWhZUVVVSEV4M1M4bTVJYjFISDVzM0l0Qlg2WnpEdGxzZDg0bzd6K0tN?=
 =?utf-8?B?MnZIK3dmeEJCUTB3NU5rYjhPM2Vsb3lwU21WcTRJdEtTMWcrbkZybnMrZ3FS?=
 =?utf-8?B?UmY3ZU1hZWF5OXVKVE5vWWUrL0FyYVZJWU1BOVVKTi96eVRFdlVKd3hvVWJN?=
 =?utf-8?B?TWM4aFBnWmQ4V0pNTXJINUkwSVRvaUlHZWRkak8wWTNibmUyODVveElJaU5a?=
 =?utf-8?B?R0R2NHNYWVgyZVk3YUxFOUZxVityUm1BeFpCdU92WXpRekVUY3pTV2xuZGxv?=
 =?utf-8?B?YUNqeWgrNXg5Q05GTGVoM3pLKzBsNTRqQWJEWW9PSmlOcFFsRFZHRTNkL0d0?=
 =?utf-8?B?dmd3cm1zb1VzbDVyUlhFR0xQZG0yMnZ6T0lTNWpWcTZrTXVQMnF1bDBCYTJz?=
 =?utf-8?B?bDIreWlta0RwRWhhYmg5Z0lLMG9VaXE2bHNXdld3dUxUbWRjWExuYkVwVHo1?=
 =?utf-8?B?TXY5S29tL2hrVnJHRjhsRGFCNVdGL3NxNFN1cnNBTCtiMXFzZkprb29CaFB5?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YNZTDU+Bm24sfhU7i5vExvOqERjUyC+9sqaLS5P8/MTKWlWHLM/PI6G93LBCT3GWT/SfLAUjUyRWufLGsMHAj29R33ls7TBoHzedvO4ENJD/jSsVtqiJAM4Wh+IBstzSdKIdU91sqZqq7sLxJh/vNcrPpK103NfOeSFM9h6oz9zAUTB+i+nzcKzG/qEgj0hQUsrIu4islVPwVotB/61Rin+2mQV7rKgMFXnhgeGdtQ9znpOElEJ1hKRc9Z/Ea6lT89wen3oBtyKrt+o0W/hiHjDU1RbSvyQqKrX9ZJymZloe3KKKEYxYe4sBOC8tkvjUCP9sYqU8W+aVPH3GwaluI13womfQ+whHqaR1G/sCgtszH+ZG7sd7D9vbmCTCj2j28tKBv4QIdOTGdQTENJH/JtzGYT0o8gsX9PqaVRjMdSZU5qORL2h2ln2+sMulreXsWRg9T+nxBAgZJYNPhbcAgHoTMEKD79ouGep0Ykx8lqb88byyuYXfhFJGQw+0t+g4xNP/ErdmCNxhuJAWLgHLD1Z1/Kw62BSCTVztTDbfU5WevkA+/glswv9oZ3G9wRGykLdUHhsGv9NAeF6F3v7XQfukNrkkmXgjczs+FBTSeEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e266781-c9e2-4775-ed5d-08ddc538956f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:48:17.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJLxaYkteQdP5wvxdI3KXAG8zxHV0kbzcs9pvAckvXoYI+TFFMtJhTAurzIWJwV6E62xCTj6wegDKHJ540H0csqz+NKoC3DcIeHAxIBkOWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170121
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6878ff24 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=eIis-2BVaMUETDHvP5EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: o5W-_nCiXkOgpaXC02F9t654UkvZmSyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMSBTYWx0ZWRfX3HSLKto+yaBJ
 nd6ZbhlsgvqCbDreg1/uIM7wnkVfpee5C27ac+bbuvCVac5Ci6nqAyruVx90t+mFpvUOboF2Yar
 4iiyLTVDY36tjeroXE4IOSxkusjUmwDR42udhkg06PSZZo7u41P4wAdCuRPz84GqO8xrgt8+nz5
 3G79pTNt45gbbraq1KPTfENyMEiKgWS9ZgxLkw2FMmopWtftPA7ZzFEAXjuI/XEC//oIxr5KbQq
 25Azq1Z1Gq76UjNAiYO8VxEqGfmh/o1oSijA7z2yRzc8HtYmTZPbiS+FIVHOslsCczURrg18h38
 wkmNgoTbCcz8TKEfuCF95D+x8vLm3eSbsOFk52FSGN8X1rex2UFJ7izSKXaNLlDNi3INTqlTcN9
 HrfO6BpBTtmNQidcCnYhsePtqmd5sl+YX6YcJSrQbHnowypNuP9CopbhzEwjmYlDNEBOUaHt
X-Proofpoint-GUID: o5W-_nCiXkOgpaXC02F9t654UkvZmSyi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 7/17/25 2:07 AM, Michael S. Tsirkin wrote:
> On Thu, Jul 17, 2025 at 11:17:05AM +0530, Sairaj Kodilkar wrote:
>>
>>
>> On 7/16/2025 6:59 PM, Michael S. Tsirkin wrote:
>>> On Wed, Jul 16, 2025 at 06:26:37PM +0530, Sairaj Kodilkar wrote:
>>>>
>>>>
>>>> On 7/16/2025 6:07 PM, Philippe Mathieu-Daudé wrote:
>>>>> On 16/7/25 09:31, Sairaj Kodilkar wrote:
>>>>>> This series provides few cleanups and fixes for the amd iommu
>>>>>>
>>>>>> The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and
>>>>>> Alejandro's
>>>>>> DMA remapping series [1].
>>>>>
>>>>> 56c6e249b698 is 4 months old, we are about to release v10.1.0-rc0.
>>>>>
>>>>> What is the point of posting obsolete code?
>>>>>
>>>>> I'm not going to review further.
>>>>
>>>> Hey Philippe,
>>>>
>>>> sorry. I missed to add it in cover letter. Intention is to get feedback
>>>> on this series. Since this is on top of Alejandro's series, I will
>>>> rebase it once his series gets merged.
>>>>
>>>> Regards
>>>> Sairaj
>>>
>>> Merged now, go ahead and rebase.
>>>
>>
>> Hey Michael,
>>
>> Sorry, I should have mentioned which series I am talking about,
>> https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-\
>> alejandro.j.jimenez@oracle.com/
> 
> 
> Alejandro said he will send v3 of this.
> 

Yes, I am working on this task, and expect to send the new revision 
soon. The pending issue I am working to address (failures on reboot when 
guest boots with forcedac=1) also requires a change in the VFIO host 
kernel driver, but I will send the QEMU patches as soon as that portion 
is ready.

Thank you,
Alejandro

>> I know Alejandro's cleanup series has merged. I was waiting for
>> DMA remapping series. But what I'll do now, is remove the patches that
>> depend on his series and rebase remaining patches on top of master.
>>
>> Thanks and sorry for inconvenience. Will take care of this in future
>>
>> Thanks
>> Sairaj
>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Phil.
>>>>>
>>>>>> [1] https://lore.kernel.org/all/20250502021605.1795985-1-
>>>>>> alejandro.j.jimenez@oracle.com/
>>>>>>
>>>>>> The series is uploaded on github:
>>>>>> https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1
>>>>>>
>>>>>> Sairaj Kodilkar (7):
>>>>>>      hw/i386/amd_iommu: Fix MMIO register write tracing
>>>>>>      hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
>>>>>>      hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
>>>>>>      hw/i386/amd_iommu: Support MMIO writes to the status register
>>>>>>      hw/i386/amd_iommu: Fix event log generation
>>>>>>      hw/i386/amd_iommu: Fix handling device on buses != 0
>>>>>>      hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
>>>>>>
>>>>>>     hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
>>>>>>     hw/i386/amd_iommu.h |   9 +-
>>>>>>     2 files changed, 146 insertions(+), 80 deletions(-)
>>>>>>
>>>>>
>>>
> 


