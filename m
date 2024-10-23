Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF11CFA45C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fVt-0007kX-8c; Wed, 23 Oct 2024 13:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fVm-0007kA-3A
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:51:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fVi-0002Rf-Ow
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:51:09 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeP7012097;
 Wed, 23 Oct 2024 17:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=MyxzOFGHtI9p3nZ5lMa6MpdAsXb4dYcTIDiZyp1MdKg=; b=
 hs6JKygPDAGkM9aJ2oKBZc/WqNuaa+u0L+YwxbRtbWaSH2AYRbbJph4r2j4zV6Om
 zvAb43wA16W8zEiM5aNkRdN0XI1PY4uBuuUdNpHLE6NOHStzsxqstPDy0LIZoZlX
 CY4cvYnvGTFRyHo4eCBbvJtni3pY5CMr4mt+h3wa50DjBFKP1hhzLznmr6EvC8lC
 Y6CXUP/rKBh1aeejrmtEJmsgxCaerj4X7PBGkOYuDkj0JKJjpx9bmt4QIjx0ItdM
 zU54an+qGJAPmFyosGqHo55UrfB+lJo+AZikNQ0c/XMpshSo9EaTPPu7/+nq23Gv
 TurbHPA+jNTnzA2KLY+TXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urr3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:50:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NGU3qf025421; Wed, 23 Oct 2024 17:50:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh9uj01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPvDqrYfpC9OB7nIdhKFlaeurZQa/70u/xGxgIL0wIUL0Zvv4J/zFehw2mZZYXRcUtBeJKCS4wl8g3WQ/CrfgRRbf/tDgyiL/2cR2+uE/KknJsTX7LIZ8Z+PSaegjzoktCi2G8ns2ZsaTNh+S1m5Wby4visdhMt068OYlukx6Xqf9piE7oHVDJD9ct8aGFSZVXSo437ykgKmgWGvC3WmgXawQ7N2qNl7ZwLVGllVMWyVGGV9z5ubPKucneEumdj4m1BZSjIa8XmX/R0PgqW/RWZD7G23ecQNaEdTRQJOnO8zIks3zBg38KqUlrY7LtmRLpesiTm6vjmHDQzsMtlmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyxzOFGHtI9p3nZ5lMa6MpdAsXb4dYcTIDiZyp1MdKg=;
 b=y4L/pLsRdNLloV85SUS+X4PQVkyYH9hgNx3l0I90GhB6+0sWTfDG6Raf3us3fQys+I/u3D7gvAIZZ00o/f1HL6ZwS+rmGfFGp2qAPGSnOxaDqEjW+IzGXC6lyUGuDJM2EdD6S6yrbVlJuIQkkw31iLZpcZE4AlRJ5k53f+1U4ywn6AipReMpCL8ozP13e3eDOmAtXMaqjnvLBR6mSRfAOQ4E93/gQV7xgR3o7vHMqEfpI4RBDTtuuqe3nBG2kOThLKLWoNnKZPOj2jl2rVSs4w/bj66ljZAV6AwwIF1QrO4jimo3Og63AwZ1ATSLpeixB354G4pXyBiiYlX2DIW/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyxzOFGHtI9p3nZ5lMa6MpdAsXb4dYcTIDiZyp1MdKg=;
 b=QX6WNnHM1Vt8tr+1rEC2+JMz6e299KK3XNtFUv0lmJrwKrZ4WCwOc6Syn7j+tOPflKWO+8jIRdNBPr31RzUYiqrP1G2HmiSdAWcIun1QNzV0aG6A3eNV/OU0gN74J8lE8Ks4xEyW/4B58pNUZ5AewSTNeQvzLbwdif46d4Bw00g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 17:50:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 17:50:56 +0000
Message-ID: <0f8bb180-7e72-40bf-a1c1-a8d9132af86a@oracle.com>
Date: Wed, 23 Oct 2024 13:50:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 14/14] migration: allow commands during precreate and
 preconfig
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-15-git-send-email-steven.sistare@oracle.com>
 <ZxatTbs30qouLDO8@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxatTbs30qouLDO8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:408:fc::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: dc39c131-b214-4417-0ede-08dcf38b3f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2xKd21KVkozNENmV09QTDRUa1Q5Y1dTTjNqK1hYV2RaM3pvcCthRldLRlVr?=
 =?utf-8?B?SzNiVUgyUG04YTRMNHh2b3EvTGFsRzhVSGk3cE1ZeUJsYUdtV0dOY04vWkNB?=
 =?utf-8?B?TjZmNXJrTnlZNjJ5ZzZjemlwWURVU1hhcjRka3VhcThtVlF5TzZlNk5rSzFY?=
 =?utf-8?B?UDhGRHpnZXo3UjJDY3Q3ZDllazEzdm9WdlZ6dUFxU2hwbEtHVnNHS2V3eEZR?=
 =?utf-8?B?UllYYkphaUM0WEhWa2VqWS9FalIvQXdHM2dnSU4wVVN4Q1BuSERQUzRoMjI2?=
 =?utf-8?B?MmczKy9hUkxVSFlnWE5hMmRDZ1dpWXBpYTd2dmo3U1N2ay9sR2htalVkQjll?=
 =?utf-8?B?SThpbVV4WjNKZytGSnBnSFplRW1paXpwUGtKRElSZ09wdVdqeDdrbWZYWmdI?=
 =?utf-8?B?b1NDYmgwbWtRTlNUNWhMYTdML3BxMURUczVNUDUzQ0h2WFVoQ0NXcEFWTFEr?=
 =?utf-8?B?ZlpwREJkTWVtN1AzbFBWMldOa2R6NTBpQ2g3aXYrMkJXN0xoKyswYXp6VytN?=
 =?utf-8?B?RWlCcy85YkhFUU9DR293WmhzQjk3SWdSTmRUeTVLMytJMk5Jay84TnlLYzI5?=
 =?utf-8?B?M3pvM0gzQmVKaG5UYXF3ZEJIcXBXaWVGaXdHSHNBdnRNbEY2b0gvUDJERmFX?=
 =?utf-8?B?bWdPVUlLUHFSSFUvL2lSd1grY1dTUjhvYTBMa2NydDRTU2paWVlyckZINTYw?=
 =?utf-8?B?eklsclFxOUswRUlVaXN4czk4Qms4ZjdDK2JvUE9oTjFkZ3h3ODhrVkR3WnBk?=
 =?utf-8?B?RGg5cGd4WVV1SVJQdW16ZUdqZU5PbFpCdFB4WnQvL2Z5dG5IbHdrSTF6aUg1?=
 =?utf-8?B?Q0M3b0lGSU9pOVBSWGUzKy9VSnl3b3dZbG5jRHNYUkhpRVRIa0kzeTRGUnZi?=
 =?utf-8?B?bU9VK3F3MTZqVE02dFBhcFV2N1NXZmxIR0pidkE0dVo1OGFGc1hpQWdwRlUz?=
 =?utf-8?B?UU8wRmdJUXlsVTZSdTI1SUk0REdXT3hzeGdhOEJjUmFlbkVGTm54bGtnNTE0?=
 =?utf-8?B?SjBSK2U2QXNuYWFDSGlxNHNObzA5UWJGNENHTWhmUHdZU0hTejd5QWdSOENn?=
 =?utf-8?B?TWFhdUQvV2ozWndmUU91S05OTjFnM1JrZzIyOEhORWgwVUF4K2xFbHJlTFdF?=
 =?utf-8?B?Q3R1TEk4RWszSTIvQndHcUVYd2NmUk9VcHFUWS9lVFJXWi80aUpOenR1eStK?=
 =?utf-8?B?bHJoWENtRnVXVnQxSEtVNkIvcFFLeXZYMk5jR1NZa1dXMm9pNndFZzhkTUI5?=
 =?utf-8?B?L0FLaVFuQWJvYlRSOHpEbTYydkVMVitLb2s4SWtMRExHclpDS2lJclBwRjZ4?=
 =?utf-8?B?UnB3WEZwb0FrWlphRktGdjRkK0NQYTdUUlQwZ1NpckhFblk5My80NVFya0h6?=
 =?utf-8?B?bGpzR1M4OVlORkxqNHZaVFlQSmZLRnUvdklIdUtNZHNoMldXTmtkMmUvN3BX?=
 =?utf-8?B?bmVIa2cwcDY0TFVUSHJGVFRNOWVkeUtSa2JjWi9yWjkwK1FpVkVJTS9lbElW?=
 =?utf-8?B?QnBiUU5pUnJwcEI4dW4wa3BIeFB6aEhrQkR3K3lxNFVjbUxDNGhkZi8xTnZt?=
 =?utf-8?B?ZkQvYUlTVXhCbU43WC9ZL0RMdTErWld6eEV1NEpoeHVWTmZ0NEdiWUNFU0Ju?=
 =?utf-8?B?UlpRRndVaFZBTnRudWZVbzYzbmVDeUI0VUxTTFRNNCt6MWpEeWgwcUFSakI5?=
 =?utf-8?B?bCtubnV6cXMxbUN4NnRLeHV3Q24xZUlETlVSTzBUK0Q2UmhOS0hwalJNMGdi?=
 =?utf-8?Q?n2/XAnI1TL9t1iSvyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFzOGZUQmhwWVBVOGhteUtPRkRlcFgva01xMGVwamNrVWQvM05pRGR5Nm1H?=
 =?utf-8?B?VkEzdHlWU1dtQng3dzkraVFJOFBpN1NjakhMa3g1SWJKblZsNmJWc1FIdVN1?=
 =?utf-8?B?a1VRYzlic2F4RWdrUlB4ekY5TURmd2JLSGY1Nm5vU3Jza2crQWtzYWF4NHpW?=
 =?utf-8?B?azNrcjQvRnQ1ZHUyK1hlVXNSVk9OOW1oRWs4NTdUdlB4QTRRTGc0aGhieWt4?=
 =?utf-8?B?b0tsUVdLL3JZVnJUWjI5SzROemRCUmVqTllFSlhzVVkvUDR1Y3h2bkZMQlkz?=
 =?utf-8?B?UWcrdVFvWXVEa25jRHlCYk1hQkk5Uk5lY1dOY21DcCs2VkU3MDQzTUZocUcr?=
 =?utf-8?B?UU54clE5ZFZoalhYNWg2ZFByd2VLNG1Jb1RIbXRqaHpwUzJSaEphQm9mZk5D?=
 =?utf-8?B?MVQzRXlPTG91R0lWWXhRazZVMzVaa2dMUXNIRkJPZmtZTmJIWEtjaXZ6Z1Yz?=
 =?utf-8?B?QVB0N2lqMTlucnZ2VGJKR2JDdkVQbWxDME9vZ25HakM1UUVMcGl6anVtSm9h?=
 =?utf-8?B?RHQ4bWVpblY4ZGRNb1lRSVlYNDFSbytDYlNsVnB0RUE3dFVTc1ZSUWtXWGVK?=
 =?utf-8?B?eWtzdlpUOGV3Q0ZKMkxRRlc0MWo4YlBzdjRvSktjRGJHVTZKR2x0YUdpMVFj?=
 =?utf-8?B?TTIyNXZWeHc4NVBGbXR0RFY3VE14K2pMTC9mVXFsK0ZNUXZEUk80eXlkcmhp?=
 =?utf-8?B?RmxHNS8zUTZTU0Jlbk9aa1VIV3FJdU1PZmVNL3A2MnNWYnhwWVkydlZlalVn?=
 =?utf-8?B?T2VXdURQODRlWE13MWsvS0lDcHhxTUNIMDF6Nnh6M2lMR3ZCWjduVFpzQXZX?=
 =?utf-8?B?NXNFTnNVVkhrTDFhY2c2YkE2RFliaFN0R0xhQUx1cWdDVE5xREtKaUFuNFZx?=
 =?utf-8?B?Yy9nOXd5TkZyUCtSVis2VW15SEFPOG5pL2RtQnQrZXBkeUhjYzNldFBGa0Fm?=
 =?utf-8?B?Zk9RRWhsY1J2dWZNbEl0MFFBVk5MV01SV2hXL1p1YStTQkF4SWxLdmZaMlFr?=
 =?utf-8?B?N3lIZFJBOFdHS3dzVHdsa0pQUFN4ckV2QUpUc1pFR3AyUzJMZ3BGemRidSs1?=
 =?utf-8?B?NUlxdXhjR3Q1UE9samZ3V0hWakMwckptTlpJQ0dRMjViS1dTUEliQkYxVVdl?=
 =?utf-8?B?RVR2VTRaczJrYW40YUM0ak1ScWpCZHQ0dHBCMTJmTUx4UDZ3VEFZR3NkVUdk?=
 =?utf-8?B?bnJtZmZIT3pmSHpWM1dMTTZBbXBuL1RZQ2oxSWJlN2h2UUtWT3FyUmhrRC90?=
 =?utf-8?B?dDFhK0V6T2hFcUhGM054dWZ5SlVkaEsvTEs1MHZidTlSS3ZaZkN1NlRRU1hH?=
 =?utf-8?B?akhpMWhtdlNKbWdqRXZvbTJvWTBVUmJoRkNqbXczUDV5anJaQ2lydkV3R282?=
 =?utf-8?B?VkMwcEdlenRNTjR5RUpnaGFLTmhEV0VzUjBYazRtUzJEQnQrUC9iOEZVQUhP?=
 =?utf-8?B?bDRIMWxOZkF4MWJxTmc1dXBzNmU3ZXhEUU1OVkt0VE5DLytBK3NPSHJwVHEy?=
 =?utf-8?B?cERZTjY1RTdUdjZBYVJiU09TKzAvcXNmcXNWbmNSZnY4UVY5VlM3TUhHd01y?=
 =?utf-8?B?WkpWTmtuckhrdEJwZWc2Rng1dkExWWNxQnBMZ2o1QUxZdFN6R0ZmdWdXMWxI?=
 =?utf-8?B?NEVmWXlUTHVIRkVHMkxSMElCRkp4QldGRUlHQ2ZXSGN2Kzh1dUNNaVBQQ25Y?=
 =?utf-8?B?VjQwTUFsK3UxSEVzeXNGcFJVZkt2N0FCM29PR0JhQk5hQ0J0bUZQYzc4OWk3?=
 =?utf-8?B?TDFHTmFGcmlUQVF0N3B0L2JZWllTM3ErMitNaUpaeDBlL2gxNjNKRndsbUlo?=
 =?utf-8?B?OXpVaTRxR0FjRGwzRzBqWWx4b05ZZStqV3k4WXYwSHhRcDViamFVbitIaUNC?=
 =?utf-8?B?dmxZUkZJVzZ0dzNwWXhDZzFhS0xKaUpjR1FMSFBxenpnM0xzcnd1aERndUhR?=
 =?utf-8?B?Q3U2TTdEQXFKLzByMjJHNS9Wc0EzaytxYm10SDZlM1VrOTBhWkk2L2o4bDNS?=
 =?utf-8?B?NUVRS0pobnZWaTllc2diaEhCTFpoc0w3TjhQQmdBV1U1UzBWbk9nazVOVlJl?=
 =?utf-8?B?TGZPVjRQeHorNkM4cWRrMlYyVmJoWlhHMDdMRTQrY1ZSaFFUUkpqRmRvMWsv?=
 =?utf-8?B?UUlVelRFemJXckdwaGRWdmlEZUdzczh1MDdmYTRRaVg4Uk9ZWlNTYlgrVjBx?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wjmvcI4iDTMncxmRFGam2g1SkRlVyA7AbOtbOcnjNQQ1+OJ8TuAukT2eCwLbJB9pwmh8LHCV7/q21mtL3qyvoc/mUEUfpqikPBnwvGqA6RUXvyOUo/7q+2ha4sZLRRVEFfgBmUNqJ/5OYoEQyHlu2Tqek7tuWavj8BUgZ5u0Ej0EB5s2cfq+fYyVWRivRMdmLSUpBLrcuOnznEVy9cVSVUONXWx4xjpJ8D9r14Xevf1mfVNQrls8K8gpb749XC0Cm+MxS8hpNQmfud8MjO7uUUYyIXUBSOAo496JVazljSn4uORW49MjSS0X0JqQQ9pia/C6gEtenqc8JpG38yk/a8JlTz4ZxLURm39gxsIJJCvR4cPuZDyYfHMmjOk+xWD7emtzbTDmKh5Gik6PZM6NZ6j/vyFMMbnvAqygzUNPU45hktQhicOqwgqZh0XyrnDnMmY3OgvILyKgnPvgnAWo8w37k1dcF/zCJHfEQtb/HWDp7Xj5WPLbbYT6//NMrzyhnEHLxB0c5EjofZLzlI4iYhOiS8MbCr+CUEI1pAw1sor2gl53I7boi2HQDyvXK+qeiPaKuoTAB2uIrIdtkhJbGzehjP1jJt4fVhJtSrOQPJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc39c131-b214-4417-0ede-08dcf38b3f05
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:50:56.4339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l70LzLteAiw/WRZnZWuYehIg8uN/4f71hqoHw1Q+ouIvHrlc86QwZQZr8Yo6rchJgjYoNYqxTyghpXvn381PtPtNTr6Wa18RdBs91KnhU+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230113
X-Proofpoint-GUID: pIBP7-vTOhq5oopFzZ4VmTTWizH1k2jP
X-Proofpoint-ORIG-GUID: pIBP7-vTOhq5oopFzZ4VmTTWizH1k2jP
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/21/2024 3:36 PM, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 08:14:15AM -0700, Steve Sistare wrote:
>> Allow various migration commands during the precreate and preconfig phases
>> so migration may be set up and initiated at that time.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hmp-commands.hx     |  2 ++
>>   qapi/migration.json | 16 +++++++++++-----
>>   qapi/misc.json      |  3 ++-
>>   3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 06746f0..c0f34e9 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -959,6 +959,7 @@ ERST
>>           .params     = "uri",
>>           .help       = "Continue an incoming migration from an -incoming defer",
>>           .cmd        = hmp_migrate_incoming,
>> +        .flags      = "p",
>>       },
>>   
>>   SRST
>> @@ -1000,6 +1001,7 @@ ERST
>>           .help       = "Enable/Disable the usage of a capability for migration",
>>           .cmd        = hmp_migrate_set_capability,
>>           .command_completion = migrate_set_capability_completion,
>> +        .flags      = "p",
>>       },
> 
> How about "info migrate_capabilities / migrate_parameters"?

That's hard to do cleanly for hmp.  I would need to allow all info sub-commands,
then check and return an error for everything except migrate_capabilities and
migrate_parameters.  It is not safe to allow any info command, because some of
them reference state that is not initialized yet.

>>   SRST
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 3af6aa1..0468c07 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -373,7 +373,8 @@
>>   #           }
>>   #        }
>>   ##
>> -{ 'command': 'query-migrate', 'returns': 'MigrationInfo' }
>> +{ 'command': 'query-migrate', 'returns': 'MigrationInfo',
>> +  'allow-preconfig': true }
>>   
>>   ##
>>   # @MigrationCapability:
>> @@ -527,7 +528,8 @@
>>   #     <- { "return": {} }
>>   ##
>>   { 'command': 'migrate-set-capabilities',
>> -  'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
>> +  'data': { 'capabilities': ['MigrationCapabilityStatus'] },
>> +  'allow-preconfig': true }
> 
> migrate-set-parameters?

Sure, I'll add it.

- Steve

>>   ##
>>   # @query-migrate-capabilities:
>> @@ -551,7 +553,9 @@
>>   #           {"state": false, "capability": "x-colo"}
>>   #        ]}
>>   ##
>> -{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
>> +{ 'command': 'query-migrate-capabilities',
>> +  'returns':   ['MigrationCapabilityStatus'],
>> +  'allow-preconfig': true }
>>   
>>   ##
>>   # @MultiFDCompression:
>> @@ -1297,7 +1301,8 @@
>>   #        }
>>   ##
>>   { 'command': 'query-migrate-parameters',
>> -  'returns': 'MigrationParameters' }
>> +  'returns': 'MigrationParameters',
>> +  'allow-preconfig': true }
>>   
>>   ##
>>   # @migrate-start-postcopy:
>> @@ -1751,7 +1756,8 @@
>>   { 'command': 'migrate-incoming',
>>                'data': {'*uri': 'str',
>>                         '*channels': [ 'MigrationChannel' ],
>> -                      '*exit-on-error': 'bool' } }
>> +                      '*exit-on-error': 'bool' },
>> +  'allow-preconfig': true }
>>   
>>   ##
>>   # @xen-save-devices-state:
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 559b66f..ce60493 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -241,7 +241,8 @@
>>   { 'command': 'human-monitor-command',
>>     'data': {'command-line': 'str', '*cpu-index': 'int'},
>>     'returns': 'str',
>> -  'features': [ 'savevm-monitor-nodes' ] }
>> +  'features': [ 'savevm-monitor-nodes' ],
>> +  'allow-preconfig': true }
>>   
>>   ##
>>   # @getfd:
>> -- 
>> 1.8.3.1
>>
> 


