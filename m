Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFA9D43360
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t937W-0006e3-RC; Thu, 07 Nov 2024 09:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t937Q-0006dV-SV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:04:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t937L-0001vs-KN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:04:15 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7D68Kv021962;
 Thu, 7 Nov 2024 14:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=CuPHqKsiTNgN9tHSQ+Nf5QBMesE3tfSBKt9zbcvBN/M=; b=
 WpUbZlBkJbAqC/yLu+i4NqWqJ53PnulpdwydewfSqFBgPAZMZs0xUIGzPiE7GPW8
 kFQoCaK7nDqFV7cl/s/RylRVkRABk4uIg4WN+NUvFYo3zFQG/yNp1SQ3bIidIyD5
 YVtXBXjUTpHEdK84aKfvSb4PoyX4RIzFCwyTHgPqXeb9kPF2Yk15KxND75YcZhtw
 LsnxRrVtdd2u2b7Ydd5kzeWTW0w67rM5UPrz1Vx1kiPMBjbhMBBle3qtNk2XAMMa
 9Q1+6Fu9RpoUeAoMP1dxB6wW5r3CqoBnCeMloXob6iJk80eRqo9rqByQPWZDOudj
 UwXrPAJxHByAB9tk5fQ5BA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsthnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 14:04:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A7CUJ7U009089; Thu, 7 Nov 2024 14:04:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahgce2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 14:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYC5yF8n2Xkbt/ocPVEI/Zv8cOLPCA8aoXcGR1ubYzFY3DZIWKJV3OQI5kqbQKxAknKsB5YnCDAyfz7EiBOsVBYWaiEFslLxqmVqKlSsO4lOSms1f84oUbnvOJhV6DxhYOxYUolzDYrh96nNf8KBNf4TzCFBFmByWcWMiVZqOrzDkjr8PBUl72PEhdRZfmwRP9d/JwlnEWAFAPZxlhjvGQEG+GREtF0wySDByUOQcsAjguJRHVTG1qX7V6jt9gf3SWa/SsF2FarLsdrmgAUH1sqi3kVqrMC+BGkIJ1G02MVLfRyparmuDJ2C4DJKqWPFa3sobiz6Qe7ZE6vmmNeKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuPHqKsiTNgN9tHSQ+Nf5QBMesE3tfSBKt9zbcvBN/M=;
 b=yPygs64g7HBjEuNoaGLKs8fEbpn57yC+sf4pWU3ZGjnJWEiAYzh/I4TWDoOxPGBLsk4OXIEujxRWbxXsX7k5bL3jcuYejFpL8mNKAyz7WjBGR0kJsaqdXUxMWPogOY8bygEUT+UpKYlHNH8kJ+ni6DoMRaUIiEcLsJPR3bkrgiYeVnZVYfClq6QyvWnTW1aFuH16Vr5EzjJ/plPowSx4V3icBPrdv7TgjaIXM66fixXwnGSPa7U1Knf86udV4xmTV6GFc8EUwusqO/ElBpK2q9mzRZY8Tk08d5l8ePvI46ZEnPmH3NexhxMDvYAZ44U//qY5VeUBQeoOQpIRWrULlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuPHqKsiTNgN9tHSQ+Nf5QBMesE3tfSBKt9zbcvBN/M=;
 b=M96wNVoYkoON9ShGWkdpoMI5pUBf8Xy+PL53SBXL10bGKg9+MiCPgPvkiPqCAo5cp6F6r/RxirMpgDRQvzF2gtP5YGWU7vob/1s9chYw/7dUC/TT0aw7WONVJ5SU1RpPl8XOuLawNsLTDvQXgQFg/UepkPQgdINoxwCPZ2P8CJs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7863.namprd10.prod.outlook.com (2603:10b6:610:1bd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 14:03:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:03:59 +0000
Message-ID: <2378615e-814a-41e5-bc25-fb68c6af9556@oracle.com>
Date: Thu, 7 Nov 2024 09:03:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com> <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com> <Zyvdyra7_neyE8Vz@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Zyvdyra7_neyE8Vz@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a8f8ca-550a-4e4a-364d-08dcff350693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGgwVGVzeTVZYkNtbEZrS2tvZzlCSVlqNmxMcGUrMVViK25uNDF6YnNWaXpN?=
 =?utf-8?B?RnkzbGxES3dXMWNJcVVXd0V2T3cwQS9RZkJMZ0VSQnY5aVltMHhnWUhaanY5?=
 =?utf-8?B?QjlhM3RkVG0xL3c0Mkh1ejFhZGNWajFvaUFTS1g2NTNIVDFabFpQQU55eGNT?=
 =?utf-8?B?YURuY3pVc1NIUnNFNkJPQzc2MUxnK0tLb1hjUy9wVVdyV2s4MjFnbDU5a3Q2?=
 =?utf-8?B?dHIzQzg1ck1TUnNMdEhGNW1KSnJDeGVWOGRScFNZT0c5bm0rcURpSGZyTFY1?=
 =?utf-8?B?L1hoU0ZYbjdkM0FRR3d2VGFKZzdrMzlrUVhtcEF3NDd1ZUQ5ejNva3B1Ukgx?=
 =?utf-8?B?WDRVakdYZ0s3MTg2VTJvQUZPNG01T2tKOVE0VmxmZjZZdzZCSW95ayswSjFr?=
 =?utf-8?B?bjVuR2pOUEp2M3RUYXNPd2x4amMwQWJ1Wk52SStsL2U5c3NYK1dMS25lMVhM?=
 =?utf-8?B?aWtXRVk2WEdjdnlTZWVWS1luN2g4R1lhc1VUanB3dlBkOWI1ankxS3Y2Z0tG?=
 =?utf-8?B?NUtjUklNZW9VMHpHdXFsQnZyMDFMbmFkSWhST3BBeEc0bmZWd2ZEVStQVUxy?=
 =?utf-8?B?RURSdHJTb2l0OTFuTnkvdDQrdm9EeFR4UTMrUXFOVTQ0Q25JcmF1MmxvcWtZ?=
 =?utf-8?B?S2xRbGdySkJ2THFSUTQ4dVkwUmh1NXowbU1IS0c0cEdlS1hXN0NUdy9IeVI2?=
 =?utf-8?B?TWo1bVMxbUlkZFhqNXdrRXlJd0IzZDE1cGtkczhMdmoxUk9aMHo5OENZaHhr?=
 =?utf-8?B?SGZjdUVHVWUydy90Q2RlLzBUK0IzRjIzMjY5TDhjZ0JHcWNYSWMwY0Z4MGs1?=
 =?utf-8?B?NHUvcm9SYnpyUWlQbVBZUS80dzRFUWw4d1dOVDdJTUxRUDk4TmQ0Uk9TeXRC?=
 =?utf-8?B?TGFDZ2FMSWd3bi9xellrNWxCTk9hQURjUVJxcG5vMGhFelJzRVNaWi9IUkJa?=
 =?utf-8?B?M0NuKzd4VEVqeVhyZnI3Sy9nRGZHN0tONnFHMzZnaDVhalczOXBlKzUwZm95?=
 =?utf-8?B?QS96c01UL0JtdDlhazV0anYwVkFQUE10QmlObnNUL0tHTFVpS3pRUmVFKy90?=
 =?utf-8?B?eGZqUWYwQllkZG1UckJGZ3R2R3JmRmkzNE1TdGlRRktKQ3dkNkJMa0hNK3BL?=
 =?utf-8?B?TjgzblJEd01zazdrRFFHOWZjTzdPaFlySXdLb3F2RGZHbm9hVHVXTEdHRVI2?=
 =?utf-8?B?bVRta0lxaVNQUFFvUlpwWXc0SkNTUlN3ZSsvYkxzc1pVMzNkT3lVRUZKTlRl?=
 =?utf-8?B?YTRoTGVkNXdtS2lNQUppUjJ2a25JQy85STR2cGhhblZDVDM4RVZiS0JDNEdx?=
 =?utf-8?B?SW40VFU5bDMzMHdzQ1cwbTFXYU9NYjhZQ0g5OTJZVGt2RVZrSkZIeTdPd2R2?=
 =?utf-8?B?allDemdLaDUyeld1eEN0VHk3aFg1MlV0b29xdWYzOUNkV3VuQ0hGYXh1citr?=
 =?utf-8?B?ams4ZE0yK0lQak5hcEhQMWlDNCtLdHpHQWg3VHVxR3JQVWtLVEdXZHlUTUhF?=
 =?utf-8?B?SHVWSFFrUkdIdHE5Zkh3clJlTk1rWkl0VjVSYlBreEVFY05ySWRrajR5L2p1?=
 =?utf-8?B?VFlGSlJNK0ZwN2Jqc2ZxWFFkVUdtRnE1WStobFBDZ0wySzRaeEs1SmM1QzJr?=
 =?utf-8?B?OEM2ZkpSQTdxVnN1bDAzWnBGbG0rY2E2bmxEUG5mMlJRaElBREhkR3hlWHZp?=
 =?utf-8?B?QjJRbFBHeFFLdE9YQllPU2ZTMHlXTTRubmZLdXJGRGtQYXIwbDArYWRXNzBZ?=
 =?utf-8?Q?CFm8OM+yWutBdSJkq+tPNkgDkiNHhO91MzxZ9/m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRoY2NtMHBGMk45Nzc3V2NmbmdXbjJrbUZVcjlhNVdodlo0S3dVKzJnNWgx?=
 =?utf-8?B?MnRUQXlPUVgrYytCeXRQdkVLRy9iUXcyeVZ2UG5jZ0Q2c2EwTThrdnNCOVho?=
 =?utf-8?B?RnBaK2xPNElkMndBRitncFdmLzlhWFIwT00zNi82aEt0bm12eEtwOUZTWWV5?=
 =?utf-8?B?akQ1MGNyaFVuVWhoQzl4TXNiaThjbkxSV0dUZTJDdzd3SVFWU3hhaWpFUHRq?=
 =?utf-8?B?RG1sRDIwc3RGNVFBQStxdng4UmpTM0VKdEcxbXVMUjM5MktBWFg0MlduMGc3?=
 =?utf-8?B?RXhCNGVMRkJGdjZzMW5TcnZIN3VpQWVQZWFjOElZT20vcEFXWE9hTnFqTENP?=
 =?utf-8?B?M2I0bjlmRThFUmxFa3N3TWthSWpXOGNvNFlQeHBsZFAvNHhsYStYL0FHcWJj?=
 =?utf-8?B?ako3bTkwZ2dzSWdTU2QrcitsQkJYcm16VnFSQlByUkpkWGs0Z0ZYdXBFWjRR?=
 =?utf-8?B?TW9RNVU5Z2E2YzJneDBwMnR6cGVZMGlnTXJ4d25FOFUzMGlKWVg2ZXpSdHg3?=
 =?utf-8?B?Tmh5UkloT1p4K1dyN1dFYVNnSEh6bGJKLzhVS0dSRzJGcnp1K1c3QzkvWllh?=
 =?utf-8?B?MFRlV1VIaGRFbHp0VEo5dDQ2NEZ1UUovK0pTaDQrZENLV2JOdzhrY2k1YmZ4?=
 =?utf-8?B?MXFmVlNCYUc1TE1tamFaMWJQa3ZRNDg5ckcyNnJUZ244b0N1T05RM1hlK2J6?=
 =?utf-8?B?eFViUmJHZFJjRUQ2THJqTUI2OEM4S2FSdmxrUzFkTWR4UFpIbkZlRS9EKzVO?=
 =?utf-8?B?Wm5OWWJURWs0bTBtL3AySHI1UWJRemF5eXR6dm9rYm05SFlKNEJmd0Nrb2gw?=
 =?utf-8?B?bmFZUUNTYWhLWjJHNUQrdTBZcS9aQllPNXlJVnE1d0EwTUg2eWtpbnRLMGhh?=
 =?utf-8?B?SGhXYTJ5OUpQQVVTSmJQazZvSERLVUI0bDNaK20rVjZOOHZ1U2RSL2laVnZX?=
 =?utf-8?B?M2NpMTk1QlhqNmRwWHVHQmQ4MmNIZmp6T3pTRVdkcEJueGtWeDBzMUxzS3Rl?=
 =?utf-8?B?Mlp2elhjamczamtHRXQ3bC9GRXh6QkllSXJyQ0NpS0trdGRHdzNpRVBoejBl?=
 =?utf-8?B?bXFmUFk3SEg0UjhtamNUVlBNZlRPSGxsTHAwb2gxMW1LYUttWWlVdlM1djk0?=
 =?utf-8?B?NWxrYU9tQU56V1ZDR2t6N0ZMaEVxRkVFOVdFU2FlQmQvVllCUXJtUTBUbzlI?=
 =?utf-8?B?RXpvalNFbjd1MFJxNlNJSy9qTHRjYURWTkw0VUZSWHRjaTRVYjFwV2oyYVJt?=
 =?utf-8?B?SEJWejVGSnRzSGFsZGJGUjI1UFRPYW9YSWVOc2FoWEVwZUUzYnBVekFoR0N2?=
 =?utf-8?B?THdoS0NIK2RnU1pVNVVFQkpvaThSWW1sQ3I4TmdqNnBhNXhNYTBIckdablpF?=
 =?utf-8?B?My96UW1GcnBNczk1TStub1U2MDZ5QTk5eUdpRTVPYWs4NVROOFlnTGpxREVH?=
 =?utf-8?B?YUpiK2FNa0gwZTZYRk16NTJJZXhiNUdSNStxS3F4anEwUWpSenY0S0NiaTlL?=
 =?utf-8?B?Y0g2TjRTRmx2WWVFNU5uVk03d0lJcTRQc3hnb3NKcGlyS1dtZFg1Q1dwcnVQ?=
 =?utf-8?B?a05wRHRFWkZ6MFNIaTlqb0pVNzFlTDMrelNkbnlscUpvME04Q2pnbXZGRXhk?=
 =?utf-8?B?SXUwcnoxVHd5ODR3ZGp0Z0Jscy9SMThKekhiSTl3cFB0S2oxdCtzOGVHTGhK?=
 =?utf-8?B?WlV0bnBaNzRsOTQ4d001ZE51MDlWTVZPTkVGZTIzVmo2RU5BN1ZMTHE0UFVN?=
 =?utf-8?B?L0FIU2xOTG1LR3E2SVh0Sk5Ta3ovQnVMd0RjNUZUNVdSa0tVSStQUWIzVEFy?=
 =?utf-8?B?Smh3MER5aWlwOXJmYXZTbXlSOHNkSHNrdnlYRS8vV3N4WjFlRzdWYTAwV0Ny?=
 =?utf-8?B?cUgvMHhHaWF1Qjg2czY1SDVZYXZGTVFhYW0xTXBMRGJNak9hUlRuUzMrTWR5?=
 =?utf-8?B?MDM2M3NtM1lLdmZZOGhINDZxdTE2K2dDdnpwSnB3NWtYRzVUZ3BBelFQazNm?=
 =?utf-8?B?Q0czRzFvZmhra3I0WEg3M2ZpK2gyZFc5N1pCODRQZ2c2OWI2ckhKQ1Exd1ZC?=
 =?utf-8?B?eThzOEVIYWlwbzZ0Z0VUazkrMDh5UEIvL3FGZCttZktlRjB0b1NISUdsUE1O?=
 =?utf-8?B?WlhLL3VvVGQ0dVJydlpZaTVvK2s1bCs3a2c1VENTdEFVRWpNemJ0OFpzZThq?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8uZnhVQOsmWOeP7GDdKjG+GkcYp9awVmsArvfQieQ6Pjr7q13OFVnQFSyt0YjshTSSFzj9rHAzbNkNYijTC2V2kgVK3MyZievs1m8WwAsPs9LbTxIQZXOrS9Ez8JLROYGJp12pezjfxJ5PZN9uwly9UIecEgzufn+/x6tOwfEVg4ZDzfon/9VclHzXiqL0u7mmTsASqr4QTVZCJjYnD1FqcHrHKw1X6I+Mzd1s6WgDF+aomEzu8IMiNmtwCxkRPZyus+zPQpr3ZyM1tBdbPIalB7e5NnRkyQCJsmsa49m5hwbIirN1MKdX3jR3yKTwPCo3AA77vFwRFHVBmF+1V/vwDccFOjlLzZWNo4f7Pntv5UAYtNSj4Cekkos5m/EA59oD0OdIcM+8jKHNT/gvqqr1xf6yBzL4C3jpI6V7ozxDbgvNyVOSrmUUhlW1vNdajrZD4iIcFSfGbfnUy2WLaqPOXMmVMHsd74Jw6IHJliaW/WNM31p2rqxHo6AlvMu5U7XJqw0HyLQ5/S3gZ+UwD5cDjT+vh5CoYPtJATuzvFC1BPq/sTio0OGjQzOOsVN/ZajRaoG8D/FPepJr7JW/P15a8wkltRfBKLYOKuHbx5bOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8f8ca-550a-4e4a-364d-08dcff350693
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:03:59.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7abQjMBC9Q3CCBBMfOtdTU+K21zuGaGMum5bq07zmHG0I1bkoxMQX49PcbfiWb4HHpTEf0js4MT0dqHxfxIM65YaQlH9XY8pi9AtU1Ff5UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_05,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070110
X-Proofpoint-ORIG-GUID: xdnTQ1wx7_TDoFwu2E1wBl1lQVqng6dL
X-Proofpoint-GUID: xdnTQ1wx7_TDoFwu2E1wBl1lQVqng6dL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/6/2024 4:21 PM, Peter Xu wrote:
> On Wed, Nov 06, 2024 at 03:59:23PM -0500, Steven Sistare wrote:
>> On 11/6/2024 3:41 PM, Peter Xu wrote:
>>> On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>
>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>
>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>
>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>> details. See below.
>>>>>>>>>
>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>
>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>
>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>
>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>
>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>
>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>
>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>
>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>
>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>> -- memfd if available and fallback to shm_open.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>
>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>
>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>> of options and words to describe them.
>>>>>
>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>
>>>> Hi David and Peter,
>>>>
>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>> for simplicity.
>>>
>>> I'm ok with either shm or memfd, as this feature only applies to Linux
>>> anyway.  I'll leave that part to you and David to decide.
>>>
>>>>
>>>> Any comments before I submit a complete patch?
>>>>
>>>> ----
>>>> qemu-options.hx:
>>>>       ``aux-ram-share=on|off``
>>>>           Allocate auxiliary guest RAM as an anonymous file that is
>>>>           shareable with an external process.  This option applies to
>>>>           memory allocated as a side effect of creating various devices.
>>>>           It does not apply to memory-backend-objects, whether explicitly
>>>>           specified on the command line, or implicitly created by the -m
>>>>           command line option.
>>>>
>>>>           Some migration modes require aux-ram-share=on.
>>>>
>>>> qapi/migration.json:
>>>>       @cpr-transfer:
>>>>            ...
>>>>            Memory-backend objects must have the share=on attribute, but
>>>>            memory-backend-epc is not supported.  The VM must be started
>>>>            with the '-machine aux-ram-share=on' option.
>>>>
>>>> Define RAM_PRIVATE
>>>>
>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>
>>>> ram_backend_memory_alloc()
>>>>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>       memory_region_init_ram_flags_nomigrate(ram_flags)
>>>
>>> Looks all good until here.
>>>
>>>>
>>>> qemu_ram_alloc_internal()
>>>>       ...
>>>>       if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>
>>> Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
>>> that's equal to RAM_PREALLOC.
>>
>> IMO testing host is clearer and more future proof, regardless of how flags
>> are currently used.  If the caller passes host, then we should not allocate
>> memory here, full stop.
>>
>>> Meanwhile I slightly prefer we don't touch
>>> anything if SHARED|PRIVATE is set.
>>
>> OK, if SHARED is already set I will not set it again.
>>
>>> All combined, it could be:
>>>
>>>       if (!(ram_flags & (RAM_PREALLOC | RAM_PRIVATE | RAM_SHARED))) {
>>>           // ramblock to be allocated, with no share/private request, aka,
>>>           // aux memory chunk...
>>>       }
>>>
>>>>           new_block->flags |= RAM_SHARED;
>>>>
>>>>       if (!host && (new_block->flags & RAM_SHARED)) {
>>>>           qemu_ram_alloc_shared(new_block);
>>>
>>> I'm not sure whether this needs its own helper.
>>
>> Reserve judgement until you see the full patch.  The helper is a
>> non-trivial subroutine and IMO it improves readability.  Also the
>> cpr find/save hooks are confined to the subroutine.
> 
> I thought we can use the same code path to process "aux ramblock" and all
> kinds of other RAM_SHARED ramblocks.  IIUC cpr find/save should apply there
> too, but maybe I missed something.

Yes.  qemu_ram_alloc_shared() allocates and handles CPR for aux ramblock and
memory-backend-ram,share=on.

The key change that David suggested, that allows this unification, is to
push the fd creation down from ram_backend_memory_alloc to qemu_ram_alloc_shared.

>>> Should we fallback to
>>> ram_block_add() below, just like a RAM_SHARED?
>>
>> I thought we all discussed and agreed that the allocation should be performed
>> above ram_block_add.  David's suggested patch does it here also.
> 
> I was not closely followed all the discussions happened.. so I could have
> missed something indeed.
> 
> One thing I want to double check is cpr will still make things like below
> work, right?
> 
>    -object memory-backend-ram,share=on [1]

Yes, this new patch makes that work for CPR.
V3 did not support CPR for memory-backend-ram.

> IIUC with the old code this won't create fd, so to make cpr work (and also
> what I was trying to say in the previous email..) is we could silently
> start to create memfds for these, which means we need to first teach
> qemu_anon_ram_alloc() on creating memfd for RAM_SHARED and cache these fds
> (which should hopefully keep the same behavior as before).

Now the fd is created and cached in qemu_ram_alloc_internal -> qemu_ram_alloc_shared.

> Then for aux ramblocks like ROMs, as long as it sets RAM_SHARED properly in
> qemu_ram_alloc_internal() (but only when aux-share-mem=on, for sure..),
> then the rest code path in ram_block_add() should be the same as when user
> specified share=on in [1].
> 
> Anyway, if both of you agreed on it, I am happy to wait and read the whole
> patch.
> 
> Side note: I'll still use a few days for other things, but I'll get back to
> read this whole series before next week.. btw, this series does not depend
> on precreate phase now, am I right?

Correct, this series does not depend on precreate.

- Steve

>>> IIUC, we could start to create RAM_SHARED in qemu_anon_ram_alloc() and
>>> always cache the fd (even if we don't do that before)?
>>>
>>>>       } else
>>>>           new_block->fd = -1;
>>>>           new_block->host = host;
>>>>       }
>>>>       ram_block_add(new_block);
>>>>
>>>> qemu_ram_alloc_shared()
>>>>       if qemu_memfd_check()
>>>>           new_block->fd = qemu_memfd_create()
>>>>       else
>>>>           new_block->fd = qemu_shm_alloc()
>>>>       new_block->host = file_ram_alloc(new_block->fd)
>>>> ----
>>>>
>>>> - Steve
>>>>
>>>
>>
> 


