Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE3AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 11:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Nx2-0003Bt-CR; Tue, 21 May 2024 07:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s9Nwq-00034s-Sy
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:46:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s9Nwo-0001eE-5H
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:46:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44L7xEv6015921; Tue, 21 May 2024 11:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DNlorQBXGWFH4mUmaDw+XexQSGIfZuB7/lS6Fy2d0jg=;
 b=AamItNpvOQ/D/plSXrlnhlbphlDU0N22MRoSnl3QeOEt0RK9JQ/EWrPqjABrWeiNBWal
 LEL8Sxd3zMIKFWVWG651pliZkCcQ9c9ggJu1+c3jkQd28vHaPp7LGkSaTcUFn5BbUAzH
 UxuXZxms2Xx7o6uYAoKS4YOJRXHrfy4kMAXSy0vGzW3WrkERHRiSxU8GjaeuaW7ZKwHj
 HPclzleyQ8iAhhCjJ+IKU+8PqXmmo8OCRsQCR9GvxWkZUPnk/x4PHV0Qf9yAViJFlPTj
 mE8T+rhKDnyJCmNeHWGXKEM5PL2j7R6Rxjojuw/lBq1LE+SOfhj/ldYCnbGyWzhpyjhc +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv54dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 11:46:19 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44LBZ6Eg002698; Tue, 21 May 2024 11:46:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3y6js7k3d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 11:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmIG912AWEffbtL2y8t8u355q+oMrBtvQ9TEcR/7U1hnHyuWUiQlW0/0/vTCY4fPT6OvP9630QUpXO3RQIvdeKEUzYLDL6yksmFad3hR95CEfW0VShnSS66rUR9UGv3CUiHdAwQV9WYc+N6PX5tX+6Lx2kv6wvJai2Hnx7ukbwpuM3b202iKYyE7My7h4CfzinilhXzmx7IbPUAybl+3aUbdTElt+1BvvIdFR0B+i+Ofuo7G8ifWrGS+SKtvyFZ9EauhfUH4VewuKzPtvg/EtpI8OMYcLVsY8Tr4kdjNU/rrOh+82YscQKYtZ73mp4K68VUffbvTKU2WGfPsODcOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNlorQBXGWFH4mUmaDw+XexQSGIfZuB7/lS6Fy2d0jg=;
 b=bqtQGfmQ8iHDhmRjIHVzAmTmd6qIdk+Z3526R3BOsl3+b11WPWaNYutq6HfNG2d/st0qqG8Wpu2Qly3zlpbvm1sV8B1drhQOGCtOj5R5Ewl0XANBZwfoLZ81CDqWXmMX9cOafU3dwvvmIjkirOrZPcZFnaiue6gMbpMqEZoaLysHf+g+KKex9EIM2UWgWl+u6/u5uaUmKdr7m2L81VtuBMTOxtncTQBIFSwYeRJijt/QTsRgrRIgXwiBKKiKQgCjecW8JLReUadJKDI9iP404/R50BZryE6ijmY7I/VOXT9V3yCw6fnb8A4/oCA91byYA9glAROxxOdWfsfHLszyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNlorQBXGWFH4mUmaDw+XexQSGIfZuB7/lS6Fy2d0jg=;
 b=vWnxT0rocO5COUlutWNJacUKw2YVI/SltDgkdRN6PuSGR2zate3rK2bq6hpPBuzYoVBbOqofhrUaiZJ2ilK4q3Bj1ZjdoWnIU7KoobSSeAtfNUafJhXX0TgbFv6f79X3TMH6S/Ch5RIKsLy7Zj9JAUQxInzlW/Hb5pcsDMYys1s=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB6367.namprd10.prod.outlook.com (2603:10b6:806:257::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 21 May
 2024 11:46:16 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 11:46:15 +0000
Message-ID: <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com>
Date: Tue, 21 May 2024 07:46:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com> <87ed9wjey7.fsf@suse.de>
 <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:208:23e::31) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d082163-eb7e-4e6a-a537-08dc798b9f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFovT0dsSzVmK3RRYTNMUW9Yc3Q0eEdsZlpXeDIxbXV1WVF3bGdIVmlBRm1Q?=
 =?utf-8?B?UWxJeEJkSGMybEY2MlByajJRQ2p5c2R6aGlMd1l6UUNISk1MZjQ3TDFpMGVJ?=
 =?utf-8?B?dGtlbndNWXZJRVNYVmxoUEt6ckVzRVJUWndoSmRjb3RoV0VKUGxmNThnT0xl?=
 =?utf-8?B?K2dGR2Q4U0dqWXpaNGMrN05iSURNdnRTVjRmTGFUUE5CbFEvN2lIYlVYMC9q?=
 =?utf-8?B?dmhEaUd3ZExHa1dhMnp1YjVWaVgzRGgyVEs3bFVFUzFOVlRYTzhjUTRpRGlM?=
 =?utf-8?B?TVoxNEZPY2ZxMzgwMXpwOFM5am0ybHFMOFdrdjJOaGR1TnB5QVVOV1hyUWhy?=
 =?utf-8?B?WjJDdEtQU1VoYkFjR1VqOU04M3RuZUxKMWVSMkZOYk0wb2x1SzFOczM4dnZG?=
 =?utf-8?B?d2xKMC8yMkVDMkNxeHQzVDc5aVpEcERNbVQ2WjJOQi9vWmtMOTZ4bFFpUEJP?=
 =?utf-8?B?ckVUSW4rbE1Bb0daQzRBaGFrL3ZLaGt2dndnTkl6OWtmWVJqclF1Rkc4UStJ?=
 =?utf-8?B?TmRPOHQ1eTlhck1GZXlkVTFJQzQ0cU5qSm0rbzN1ZUdKWU9nS1J0R0Zmbkdm?=
 =?utf-8?B?alNCclpjalJkQ0N3ZFAyTHpjdk1jRndkdDJuamVFZ1MvNnIxeUp4YzNkNXdX?=
 =?utf-8?B?dUI1ODlMWWpnSnpqUk51dVcvMUxCME0zdnJWc1NBTGNPcjViZHhCKzh3QU5B?=
 =?utf-8?B?Z1Nja3kzVGdrU1VKZEVvdDBMQ2xaLy96a0hsM2JNWlBXWXBEVUFvWDZPYXJR?=
 =?utf-8?B?V01YVW5jcEZGbU83Zkgxd1U5UEppRDRDeVNQSXZVQms0M0IzT1k5VXB6QWYy?=
 =?utf-8?B?bGtvRGZXV1FsMTFNYTFFY2lMYUQ0MmdNdGNkam0xK1FFbDNxWGNscy9kckxN?=
 =?utf-8?B?VE05VVFhT0hoRnpaN1hNT2psN3ZjeWlHd3IrTmN3L1hQeG5NMU9nNXNwemFY?=
 =?utf-8?B?ZE5jRXV3dTJMQmNHenVkeXJPN21USTJyWlVIeS9LZExIa2w5NTUwL2szZDJH?=
 =?utf-8?B?Y0ROWnB6NVI3dHNlZ1MxOUIyRFhvTnp4anRuNWVJM2NVSTJiL08zZjRtOW5k?=
 =?utf-8?B?M3p6cktNL254eDJ0RVRiVFFPNTJvaUdweE81dEtNWkJ5Q0hna1ZQMUxNUmpz?=
 =?utf-8?B?RU1YT2VPdXlGK281OGRrNnp2VUlQMnl6QTREcGtRYTM4d2huSTNMYjR3V0JT?=
 =?utf-8?B?SmJiUEpTMkg4Q0ZDanU0UVdHRGtqTTRHQ1lIaWhBajFLUjVJRy84SitXNjNZ?=
 =?utf-8?B?dW95WjlwRitoNEFnejZRUkJSdW9aTzBpTEc3U0lRY0hkR1lSdEpQcFBNZFBD?=
 =?utf-8?B?TXR4eWZ3dnNIeDR3WElGdWVUV0s0bjMzRnZGOFFmUGpNMldBYXNJMUNOOXJZ?=
 =?utf-8?B?NXNnUThSWTBZWDJYenJKOVN4S0VVQWg5YWQ5RjhsY01pcElrbExQdnBvUWZN?=
 =?utf-8?B?N2pvWGVPUExTZ0plZE1WdXgzNTExQkxkejJBMXRzM1QxT0tFQ3NjMjBjRUF2?=
 =?utf-8?B?aExSU1J4eGFYU1RrbEt0Vzc3NGdNV0tnY010b1Z3M0dYc3FhU2VjQUp6RStR?=
 =?utf-8?B?NzVPelhaMVZBVHZJNmpndGhkekF6Tnh1aStiN0hOclJnalFxeUppemIzcERp?=
 =?utf-8?B?VzNpdDgrSEl4c3dHSU9PdEVUZW5ld2VTM3lTQXB4ZTBqd0NyeFhiSDU2SG15?=
 =?utf-8?B?dXIrMVNBRjdPckJnd1lxZUM4N2pUN3FKYWF5NUluaWJLYjhZOFh5T0d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpmb0NvYVN2YjFpMEFRbWkyQ1FNVTBXYmcrcGJIL0cxeW9VRTJ1V0pPYmdk?=
 =?utf-8?B?RWZzYXNFTUtXWnIrRFJCZE4zVVczMzdycndpM1d3dFA1Zy9WekVXNVIxQWtU?=
 =?utf-8?B?NGNlVXZkQXlNVEdvUEhHRmtrNHhOMjhCczJRMUpLSm9JZU1ZbHZjb0hJNWln?=
 =?utf-8?B?enZGT3h3QWRWVWxBVk4wQng4aGxsQUZlOEh2Zk9WcEtHQVJWQnV4WjR6cHBu?=
 =?utf-8?B?RGk0Tjh6T0NiL2hodGszaEduTmR2MmpwK3NqZEhvV1pHVHJSdDB4Qmt6dVBs?=
 =?utf-8?B?cTlZU3hPRkF1RVhyK3ZOQzRreXhqZWlaYkNPYk0wc25FMkFONENiZFJmQ1NJ?=
 =?utf-8?B?QktEWHdBdHRNZTlXT0JGY1ZvR1I3L0Q4bDNnbEdMWjZ2UWVFRVVBT2JrZ3k1?=
 =?utf-8?B?MGllNWJ6WDAwaHprbGVTQ0tLZEdNMmFjeWVPSS82NENjUWphbHhRQUR5ZkhQ?=
 =?utf-8?B?QmJ0Vk02VENuU0t4bXpiYU1OUFIvWjE2OWVpT1BJc1hjVDd6bmcyY1B4NHcy?=
 =?utf-8?B?ZENuTWIyNHhIZEdEVEw3SXZUVzZTZE1kd3A5TnJoR3BpSVlCWkhtTUtEcGQv?=
 =?utf-8?B?V2JpSFpnN0svM0k3T0cxaGgxejNFSVhBV1oxQlN5ZDRxUUtBZUp5aEVSaVlN?=
 =?utf-8?B?Y1VUUyt5c25pRGZEaWpWb1F1Q2M0NndnbG5Ga0VZcVQ2TTFoMTdVOEZIcnYy?=
 =?utf-8?B?NVRkRC9KcXdWMmREZ2sxenUxWThGNDd1Q2JycE9iTitrTFdOZzlvMCt3ZktR?=
 =?utf-8?B?THU3dThSemlWcTNQOEpVdE5laktTNGFPd04yUFZOQVQ2OXZXRnpzNk1DY0Vp?=
 =?utf-8?B?NmIrS282Z2t2UmhpN2l5UlY3UmNwNzc0R09la1VrelB1MC9uNkhQT0QxdXB3?=
 =?utf-8?B?bVZaMkM2cklVS095YnR0VHBvTDczODdkZTh1YUI3ZFh3UTQ4eVlLSmFEZW1C?=
 =?utf-8?B?RGxhenV3VWExNnN3UWhlanRzWHpEZ1BQVldlSnFGeEJXbjJyRWJVYktOZTNk?=
 =?utf-8?B?bVY3QUdSeWVqQWlmOVZaMXpMSHg1UU96TGg5VmNGVDBTZTUxWGVMVFlFL2p6?=
 =?utf-8?B?aGFZSGVNejU1QUhFZ3YrNnlNSnh5Q0F1U1g1bFRkNUVHcDQ3VWtIREF4b1lI?=
 =?utf-8?B?eUVGUENqSW9nY24ydFFnb253bkh5ZUFHY1NrRUY5SFh3Y0JoazlLLzNqc3NC?=
 =?utf-8?B?enpQQlVyRVQ2QUJHY0MybjNPVTVRclp0Vm9SMENMTkk1UWdaaUUzUXBwUHNJ?=
 =?utf-8?B?M2xCYkZ0YTIwaU5LaGdOM3ltdTFISnI3K3Zia1k1R2U4cXV4dzhuRms5ZlhK?=
 =?utf-8?B?Wlppb3ltOG9xUzVwM3RXbWtHUnI5TE5OOVErZFVWeW1icUtCRWpacUtvYUsx?=
 =?utf-8?B?TndlT3lVTGZTdXAvUzZMeWxiQmRyekNEdzBKT2ZHMWdpeEU3TXFRSHlKN01G?=
 =?utf-8?B?Tm5qMlVWcjc5TzdKaThLK3F3WndzTlZLcWdrVUZ5ZUxZL0ZscGNZajZFeVZM?=
 =?utf-8?B?MXdkaC8wNDBzbGFZc0FwenJPY05nTGxnR2lFVC9ORkxHbUgrbGdsSTZjUzRv?=
 =?utf-8?B?dy91a1ZTUlcxZnM5OTIvT2J1QjQzc29yTWZKbi9lU2c3UmtyNXNuSko4M01n?=
 =?utf-8?B?QnpyckY4ejNKL3VVbkorZ2FLMmpoZWQxVVlJN3lLSXlsMTNqNGYwUFgzWUl4?=
 =?utf-8?B?ZDBTTDFBTkpVKzBWNGF0Z0pGSGxydEFwSmtYbmg5Z0NDc3JRc28zemZibnZG?=
 =?utf-8?B?ZjJEcVYzOWtIRVk4V0FzNFVJTGhOTVRDREVacDBwbFBtencwNG5uTVlnL2Fu?=
 =?utf-8?B?MG9SZVZwd1kyREViSkFFVlFjNXBFUFNXaHQrNjhqUU5GRldEQ0M4aitUd0tO?=
 =?utf-8?B?dzRKUGo5MW56TWljR1JRUWI5TDJYdCtmVXdtKzhVU0N5RklFMVQ2V3FScGxr?=
 =?utf-8?B?U3FoZDJnbzc1K1Boc0l0dUt0dmppWVJBVHJweENwblVYUEpXVkpYdUluOUR0?=
 =?utf-8?B?WmRRSUVaODhaT3NWM21NKzZuTVBJVFhxVEU0UDJRZktDK0NMZnJmMENtL2xR?=
 =?utf-8?B?N2tnamxLa053L1Bzc3h4T2ZSMWpGbTZGYjJOR21Sbm53eU5RRXhqZUtGMEhC?=
 =?utf-8?B?ZExNTlNkQzNhdCszWmloWDk4SW1FbXp1dTBLQ1phVFdBZEgvalFTZ3ZwWkFs?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tSsOhyikTaUGBg+swseRhR/wiPedaplGfFfZWS6aUw6vjome8JqwpU2CPI29YjgJhgXJLR176ezh1H9F8pHAQo4Bn5uHByWJumpQkc7WkoRACGWGSWWhiDE4yciAyXOcIRt2QEWqxficX4eVJBE8M/YFyaf6R1F0GyYfDavfCnguPNN83qOf07qebAQa1jbljZF+li9LJw5Qty8NrVB+RAg8JhwcExkrc8ruwv+LjJe9Id56UYW4Wa/plmb1KC5eBbqpY01g9DobroXrUDf8rUtWZZxqlfnxUQeWsnpk9+zJjTlts2ISw0Mp3N3EE/sHgl/wySyXscDG6lyf+gQ6pfAESb3+dztjy6ZYkAD7sxyMWWOJXwyM7CRI3B0nKWt6h6niTZTjyvLTi7gYlQmp1/d0psVOFsY4km+tqrPgRvsDSGxrhI2opMivI44JGbQc4VDcOvU5k4PjnyYPPdyQBw5TKUzr66AFQ46ms4E7IQdqyoVGoII3+MH9yfPPGmhO/uO4BrXvfiZKjk2ZYX6khtDe7d5XQLDdCS+NX/VHW8kAnVMAXN8ejGS5BdV1am/BDm58mT0dAo6g4jxoCjqDk2h4wj26rjom0yJVwrP/+Ic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d082163-eb7e-4e6a-a537-08dc798b9f0f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:46:15.7049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uaki5fMbXy6cuV0qvFkTts1PJpURw4NIVzwGiyiJ4T9AMnlsIKLZICaQHuw5yVYpEiSdIhu1YETODpp8AJKtgw8k81GVy32ISzVzGh30Fik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_07,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210088
X-Proofpoint-GUID: 8LwGnmQEPjq2hYc4ob-uj_VR-xpeLTbZ
X-Proofpoint-ORIG-GUID: 8LwGnmQEPjq2hYc4ob-uj_VR-xpeLTbZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

I understand, thanks.  If I can help with any of your todo list,
just ask - steve

On 5/20/2024 10:31 PM, Peter Xu wrote:
> Conference back then pto until today, so tomorrow will be my first working day 
> after those. Sorry Steve, will try my best to read it before next week. I didn't 
> dare to read too much my inbox yet.  A bit scared but need to face it tomorrow.
> 
> On Mon, May 20, 2024, 6:28 p.m. Fabiano Rosas <farosas@suse.de 
> <mailto:farosas@suse.de>> wrote:
> 
>     Steven Sistare <steven.sistare@oracle.com
>     <mailto:steven.sistare@oracle.com>> writes:
> 
>      > Hi Peter, Hi Fabiano,
>      >    Will you have time to review the migration guts of this series any
>     time soon?
>      > In particular:
>      >
>      > [PATCH V1 05/26] migration: precreate vmstate
>      > [PATCH V1 06/26] migration: precreate vmstate for exec
>      > [PATCH V1 12/26] migration: vmstate factory object
>      > [PATCH V1 18/26] migration: cpr-exec-args parameter
>      > [PATCH V1 20/26] migration: cpr-exec mode
>      >
> 
>     I'll get to them this week. I'm trying to make some progress with my own
>     code before I forget how to program. I'm also trying to find some time
>     to implement the device options in the migration tests so we can stop
>     these virtio-* breakages that have been popping up.
> 

