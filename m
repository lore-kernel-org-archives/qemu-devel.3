Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419DBC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tctAF-0000RR-2m; Tue, 28 Jan 2025 16:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tctAC-0000QE-C1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:30:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tctA9-0006fU-0N
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:30:27 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLBild022790;
 Tue, 28 Jan 2025 21:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=9qVP7EAIhdAjZrj3LfRPWw5ChIOjJHr3Cz3WE1cQ9JE=; b=
 Vh4GTvkZYtW97LxDhj+4sa01YVZ7oggBJzFrSyTHaHeWDElBsX2pInzlj7Sfv4JM
 UhQGmPlMoOFW83mdjdeCH1fIQRmZ+Lg1pwG+cREONE+6jkkyeZK1f6fosb1xSPyX
 h8e70za7B39NJ8k1DUCvDwNm+3ZnyRwwkUkUBo7dxWVv47sKlgRShNvGzKGXuX53
 +pxLngKClLafISXUd/KyEksRs5yVMxe1gxrN7DYpJ8t4yQYjdPfMiok1ofFnNy2i
 OYSCFSCy4xW0eeXmN8/B1vZtA7rbnPtNikLk2MU1fU+vmw/c/cQRbg0Eo1nuhaY4
 kx86VT2iO2EKUFTwpGL6PQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f6n6r2p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 21:30:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50SKB3ih036003; Tue, 28 Jan 2025 21:30:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpdexwg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 21:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fitzNDFsHUWFcCzby0aFXvSubP++qCSJrw9BeIA7/aIbVZfIazR9lmVMQIGQkiU8N7tNUodLUSAj2wLWaItatYgtGDOTex/XA3cnqFLQnBjwT9S/0cxvwIiJFJefYYrkhZwNiQaHISuw53XvvaSYhn66C+/8th369eIeJimAkX44uW5MrHOdsw1MxngR3qO17z7mWAaab/wX1DsO1rX3YbyZdeembLo48lo9Pd08LqVngkSzZRvkblqa511B4dfFry5fTprBdyUtQ0mpZpKkzJN7bLdmiiw+iVzzt4m7OGbD1xdBNZoCD44RtMMAX58B+EmyuqS7RJI/rEGNDhMhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qVP7EAIhdAjZrj3LfRPWw5ChIOjJHr3Cz3WE1cQ9JE=;
 b=xsRJoD7IHMnZmmQ+9SAco5w5ISOyFje4SZi/bOISvJ87dCX4hJI9Qsx5JGFmBqYxGzNo66PqYvM53QZQEN3pB6BEm/ULWZ6PoFOOHO0FOnNDufx2RzxYXnVd/mllgOIdQpgY5LEcK9QLkrXNpjfEiHHbK4pVRPuoxKqhifstWsAbHw1D52Keov+d4SEfryCEutQTW7Sv97rh2+YnUT6HdSA+jVn9ljLsWpauzz4WnfeCoCbJcFZq6fde5k6EAecKnHwT+2BX1CS8FIylMpkw8+FMStJh1bANWlVDgudmnzAy9Q51RrOcBvbWQif58jsBhpmsiQTPyyTWqc8c8ZWGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qVP7EAIhdAjZrj3LfRPWw5ChIOjJHr3Cz3WE1cQ9JE=;
 b=op+y0NYTWwwbzYTbGIlvSGKowGpkbFNFbLgJPOGpUz0j/guM96cKVyjq5MDqQwlR0OywcVgPNUc8hb0BO1wvrzmgWMiXFR/KRitrscLjipopKCePCUYB3NXARW3V8RBZIYpTHfR4d5KSxrnj5hdNX5SVGYwUcnftPYjuTOCxLaA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7539.namprd10.prod.outlook.com (2603:10b6:208:448::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 21:30:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 21:30:15 +0000
Message-ID: <ce113ecd-832f-4d34-bb42-452b9f666609@oracle.com>
Date: Tue, 28 Jan 2025 16:30:13 -0500
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
 <2ae6c272-837c-4d88-bcfa-fc7719cc447d@oracle.com>
 <87bjw5tv08.fsf@pond.sub.org>
 <3c5ef58e-8f2d-401f-9cbf-42598ab6287d@oracle.com>
 <878qqvgnj8.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <878qqvgnj8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c57056-3c0b-4958-5771-08dd3fe2f44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTQrRS83Tkk1eEh6bnFVSGsvNkNSNGdlWUduTGtqcDBodG9pRGVtUjdFUHg3?=
 =?utf-8?B?aHlyV1hzWGM3bHppVnJ0OEIwa1V6NU9CWDBweW5xazZsb0R4cjdVWVB0c3NO?=
 =?utf-8?B?U083TEhuMUIvN2dPdklpck1KS2g5c3ZSRjc5VzdqWTJJT0hPM3hJb01UN0dD?=
 =?utf-8?B?VDFWOTVrYVhjaHF6aUpETUJKak95VUljeHczTG1zZzZXc2pUM3JDbjdIelg0?=
 =?utf-8?B?dmNlYTVTSnJ6TUVUMnlCT250MHVLazNWQlVLeDVOaW9POUErcWIrb3lMb3A4?=
 =?utf-8?B?cXFCSWJ5dk9IdkN4ODFoQjFXZE9PMjZzNUZpKy9xalBhNlVVLzRVUHJ2Q1Zw?=
 =?utf-8?B?RmdCTjh0R3ZDajZYL1JEUFRkWGI5K2gxZCs2OFk0WHRUZFJ1VVNmRWpjUHov?=
 =?utf-8?B?K2pRZzRWeTRUdTZYWVp6aTlaZXUxUUdIYi9POXB1ZDlDdW5KMlRmYUZUeHAz?=
 =?utf-8?B?L2FhTGJGZ0xNWFVMb0oxbGdGREJOZjY5RUVCTFlKRHFiRXpBbUxPTHU5WHFY?=
 =?utf-8?B?eDl0djRYMWhialFqNlloanBoS2REN1lqdzdJSzNPbnllSW16NUlKTTN1TzFH?=
 =?utf-8?B?bUtvUmdqdjZJK2tmaVZGdE9Fakw4S2J1REtyMEp1ZTh4Unp1a3ZtU1BQbDRp?=
 =?utf-8?B?dDZpYk40dGY0V3ZPTVJmU3BqNGRRY2UxeXVLWERhY0FVaEE5aElGK1FYRFlx?=
 =?utf-8?B?alNQdjI3aWw4K0hTeFJNVVVPNUpZdUJ5RHlOdEQ5bjR1UCtwRTR5V29mMVpq?=
 =?utf-8?B?Q0RxbXdwbWtRYzB3NHJjam1zMDdzUnVva1ZjTXJJVVVVUnhGWGRsbDRoOEN3?=
 =?utf-8?B?YWR2aVJuVGlHTzgxZzRZL0p6RkY3eVNiOEVjRkw2Y0pLdWtnNHJmRmQwODcz?=
 =?utf-8?B?SnJtQitqYkR2VFlnUFJoRFFjT1B1aHFjSG16S1NSV3BxajRBQlh6YlFuc1ls?=
 =?utf-8?B?c3FkNDZycFMrLzFQUTdWcEVXRVhEUVZWSmZaN2tVNGVQMlVDaWtxcFlDckVx?=
 =?utf-8?B?YTlTWmZkdndpY05GendtTjlsZ2w0YmpPM2hXV0t1dHFueUlDR2dQUE9yU3FO?=
 =?utf-8?B?RTlzTUdod01ER0RtQndhOUxjMzAxbkI2SkFlbmhrZXVpQkswcTRkZFpUYXpL?=
 =?utf-8?B?c2M4a3d2WE9lSERjaEVqTDdpQzBuWkxYdnFlNjhVZmpaNU1HU1VjZ3pTZjlW?=
 =?utf-8?B?YlJLdy9oOVh4NzQ2M1RKKzlsWHpubHdrOGhhUXVyZDA3dlZ0TWYvNmRmeVg1?=
 =?utf-8?B?SFlHVG9vck02T2ZoMWdWVEl6eG9EUFV4dGRPZnN6cGlxTHd2YitsSmo5VGQ3?=
 =?utf-8?B?TERJcVd0eUdsQzJHUTZnbncyRFRlRitqeGRuNi94ZnN0MHRMOVJJODV5UVIx?=
 =?utf-8?B?ZzF0cCtQUmZROVh4QXA2N25LNjdCQVNPVlJiRTNheEduRVNpN0pSR0h3ejk0?=
 =?utf-8?B?SWxLR01sdzVYWUU0UDhDTC96WU5lRXlKcFBnc3oxNkpjUXU2VmhLT3IrV09o?=
 =?utf-8?B?NFdnaDJhMXdUVGxMSkI4bWRIbXhqclpHaFhJK1d5dnRmUjVtN3pWWDRhODRv?=
 =?utf-8?B?ZXpuOGlBa2JYT0ErZ0l1VjhnYklZRGt0L2thbDdDMUlvWlYvcGp4WVFoM1BQ?=
 =?utf-8?B?UUpSV1JuZ3hkVlB3SHZYQmZCeXJ1dGpIbm02OHFtQkhBUXdmUDlzRlZXajRE?=
 =?utf-8?B?WDBqdHA5SXNUcDlQeTdJZ1FhWG54bmFWNExnY2hhUTZaemhuQ1N6YU0wc2Fj?=
 =?utf-8?B?YitGUjEyODFFZnlVaytmRnF3YXNxQUJuUDBxRHM5ZWQzN2kwaWtxU1pxYXQ3?=
 =?utf-8?B?Ung5ckxnWmJKWElMV3J2ejZLSTNPd3UzN3NqME9qemF0bVY0SWRrUTZKVVV1?=
 =?utf-8?Q?c+b9JCTCL9I1J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhqYk5LUkIzV0syRFp6VzRWTFRwZENiaFJEUVNHNWEzUmpIQWc2UEg5cjlx?=
 =?utf-8?B?OU1PQys5cHRVdFZ3MGRlM0lKL3VDYW9XSVVPaTI4ditUbWpxQ2pMbjIvbUhF?=
 =?utf-8?B?eXlneVVoL09jblZTaG9BNnJDN2M2bW83Tm1CbXBIek9EV1lpZ0M5a0ZldVpR?=
 =?utf-8?B?VzY1Z3k5NStkL2kxVzFjdHNuODd4bFJtQmM2NmJLcCtwcThvUTFramV1dzV2?=
 =?utf-8?B?bjl2QXY4a3QvZDJXSytKRWFva0xMckNJc1VNdEwyZkY1WkNQelNmaXQ4MXFs?=
 =?utf-8?B?ZDhjK3ZlRUtNL1c4K3RCSzErS2dscW14UTcvRStHd1oyemFQUWcrSXJFUzJh?=
 =?utf-8?B?UVBPendzM3paS24yL0JYY0RHdjgxbWprcHd2aFNZOXFueTdNSldEY1F6T3R2?=
 =?utf-8?B?cHpHQ2F5c0FabHIyZkFKdTQyMnFIRU42UjM2cDFhN0dwbkMzVytWYU01QURO?=
 =?utf-8?B?dVI3U0JKT3B2STBmb1E0eUE2NHhCNXpiNlZCejVSR1p2YjlOSSt1OEtrb3ZO?=
 =?utf-8?B?SmpsNElVVTQ5dUY5VHlDZUkvc2NranVhWnVuK3VEVVNQclhtbUk2MWZ0czFC?=
 =?utf-8?B?YmZlNy9pWWVncDlHdERtVExUaFR3MEdkY1JzTW1tZVpZWFp0N05Td01RTG00?=
 =?utf-8?B?Ymx3UGlDUldGckRZWktnMzhVWWFVU1V4R2VWcGU5MkNWWTBNTGVBQWxDaHJv?=
 =?utf-8?B?MFRQVkM0b1NzWWczQjhUWHNlakFFcTRPZ21KTHFXT1dES0Z3YkhMTmw4RHNB?=
 =?utf-8?B?WkNHQ3g1NTF5ZkljekhUdHNzdCtieCtJWXRENlNGWGRhRmpZeVJNcmdYNFda?=
 =?utf-8?B?TDBiWU0wMlZDY1BBcDc2RGh5ZmZVcDZUV1RmKy9vNVBxVS9XSWZRY01meUJG?=
 =?utf-8?B?TWlUbEpqUzBONWRBMHZsZEVjbDh3YW5rTkQyK2FWRWJPOXpkbk1GQUJ0MERp?=
 =?utf-8?B?UHZ3ck13Nm5qUmQyc1NvMDk0V2JLZE9kRC9raEZNVTlOZGpBTEFMZUZKeE9p?=
 =?utf-8?B?SmMvVXYwYlB3ZzZTb3NsWEs3R0IxUTZXMk5hd2srQm5LbHA4bWdvRkQ0Yk9M?=
 =?utf-8?B?SWxJUDRUMjB5L2thNnM3QW03Rk9YU2cwZm1UejdVdWJrbkpnc1NqUy9oVjJh?=
 =?utf-8?B?aUQvMUcvakl1WS84VXRHY25nU0VRYXFldlo0MWhkU0ZOREpuREhSem9hdGNJ?=
 =?utf-8?B?cTh6U1pKcXZMSGFXZG1odE94VnlHa2N6VnNkRk5ielNRSTRsRGNHaFRWK0Vz?=
 =?utf-8?B?T0daVmNjS2h3NmNlbmYxYXJoSGd2aXJ0K3Jra3Z1MTRWbjRqR3dMcloveTI1?=
 =?utf-8?B?dURpaHNwYkRZbGYrcHA1LzFnbTBYalIwR1gvTjVFMmoySGV2RFU0WWZPTUZJ?=
 =?utf-8?B?UEtOaVN1bmlBZFNDVmJKeXVEbmtKNWl5d2VNd2cxcll2dC83cllXUjJsR1pD?=
 =?utf-8?B?d1lGZ1VibHRNc3BBL0VyRTFGTVNKNmZpTkFPdHl2K2I5b296Q3FnRzJtN09p?=
 =?utf-8?B?WTFock1Zb0lNUlE1anZrd2svU2c0ZGx1NEJGSFR4bG1sQW1XN0NjYWdUeXo1?=
 =?utf-8?B?d1RHQ0h4Vmp2SWV0eDQ3dzdiOERucEhvRlNpSmlLRmU4ZGlMNUN3Y0VoUFQr?=
 =?utf-8?B?eEFKTWxiV0RJS0dsTk51Y1hFSjNkNXVSNG5nQ3FvdXZ1aDh5VHUzbmxtZjM4?=
 =?utf-8?B?RFkwWWt2NUtXaWpzSE9ldFBpT0xRNHVGQzg2Mk5IS2Nrelh2bS9yNk1jbEE5?=
 =?utf-8?B?c2ZaY1VSUVdkR3JaL3QvKzgvYTUxdFZOOUllZ3RZa0lwT1hVYmQveGZDM1Vh?=
 =?utf-8?B?NDBWbnA3R2ZPNEVDbzRudnU3eTc0UGpJVzQwM05mYjAzV0syQ2xoMitZVkQy?=
 =?utf-8?B?aEllZU4rS2ZSQ2hVZ0VhdzZ5anJDRUFBTzhNZm4vZ0tpTWl5REoxaUJxQTNG?=
 =?utf-8?B?NjRaYTAwOVZ6NTJwemhlVUFyZE9venp2eXNTeGVpK3cvR21wS0VQc2g1aVVq?=
 =?utf-8?B?MnpxQ1dZMGtrSjhueDV4Y3B2b1l1WGtPOElJVC96aDBOUGVtSkpsRG1RS2g2?=
 =?utf-8?B?d1FQRUFwc0xNbG9PZDRHeWRmNGNSUXRLcldFWDdVVU5Qa0hnbkVoK3Q2aVpo?=
 =?utf-8?B?eUNYb3MwZUhqSmhOZlB2RDdsZ2FYWm4yemRiV0IzdGVxSmtlTHRueG8ydmxh?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ho4CDusExqInFckzj1tIYa21KxJuAD0N5lVMSt7dglCsvlQrvrMiw3ClJ5JU31xGW2d7SP74gW4Pls7rJawT/4bqqpGM/emC3HlWCsuvLEr14eGo5ZQhFyUmhJ/3/bEnyusgZ44EMY0TJLpDOA02j3/xkwkbVhdSzHAOBEnzS2At4Ik0e0LCunwybrk+wRFbliZ0ipAyODVVOIZnBSzF3Fwsoev2IUFJPMH3aUJvTchvXmcx/t9in/i0CLxgqeq/rOsB9AIpvYpek4q56sqO345QF8F/nFtBfgB8lIe8EeprELNMIgJcGk42Hyp5pxVf6Mt85v3Rfzvr3UaZWTTO9Pu15VaQsl0UIAvRuThJ3qaziNe64R0EjyNRnFPEk3SRwL6/y82D0o+t6R4N8tFHGKCH5OBTX7aUXvD9xLUI/s3tZGPleqZNaST6Cx+AwNresJCRHw/V067TMAlPw2CmFizkUm5x6jyDQf6d+muzwH/93xNuYcgSScACBAA2XeG2DIG5huqSw+IrxzZzlGO1tUThdFBuzi+uxLQnb96kcuxct5M6padQMF5ug+TVpoIQHU7GpM0g0aKsTpqF9D8XIBDylYSkFlrljeX68wLXFLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c57056-3c0b-4958-5771-08dd3fe2f44a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 21:30:15.3158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSij9lN44MWmByuSJENZxbmVrksopmdTojSzmpMF9tUHsHaEJTd+XWP68CZGRAJUkiQR6jlbFLlV/acSruMCCB2IbkJHzGgYsSE2xZWBq38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280157
X-Proofpoint-GUID: b0SBh9vXSs-JaQvTQ2L0K8MlkrVNRnsv
X-Proofpoint-ORIG-GUID: b0SBh9vXSs-JaQvTQ2L0K8MlkrVNRnsv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/2025 6:56 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 1/17/2025 8:44 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> On 1/7/2025 7:05 AM, Markus Armbruster wrote:
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>
>>>>>> Add the cpr-transfer migration mode, which allows the user to transfer
>>>>>> a guest to a new QEMU instance on the same host with minimal guest pause
>>>>>> time, by preserving guest RAM in place, albeit with new virtual addresses
>>>>>> in new QEMU, and by preserving device file descriptors.  Pages that were
>>>>>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>>>>>> descriptor of the device that locked them remains open.
>>>>>>
>>>>>> cpr-transfer preserves memory and devices descriptors by sending them to
>>>>>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>>>>>> be sent over the normal migration channel, because devices and backends
>>>>>> are created prior to reading the channel,
>>>>>
>>>>> Is that an artifact of the way QEMU starts up, or is it fundamental?
>>>>
>>>> Hi Markus, welcome back and Happy New Year!
>>>
>>> Thank you!  A late happy new year for you, too!
>>
>> Sorry for the delay, I have been heads down preparing a new series.
> 
> No sweat :)
> 
>>>> This is a deeply ingrained artifact.  Changing it would require radically
>>>> refactoring the information passed on the command line vs the information
>>>> passed via monitor.
>>>
>>> More on this below.
>>>
>>>>>>                                               so this mode sends CPR state
>>>>>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>>>>>> prior to creating devices or backends.  The user specifies the cpr channel
>>>>>> in the channel arguments on the outgoing side, and in a second -incoming
>>>>>> command-line parameter on the incoming side.
>>>>>>
>>>>>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>>>>>> which allows anonymous memory to be transferred in place to the new process
>>>>>> by transferring a memory descriptor for each ram block.  Memory-backend
>>>>>> objects must have the share=on attribute, but memory-backend-epc is not
>>>>>> supported.
>>>>>>
>>>>>> The user starts new QEMU on the same host as old QEMU, with command-line
>>>>>> arguments to create the same machine, plus the -incoming option for the
>>>>>> main migration channel, like normal live migration.  In addition, the user
>>>>>> adds a second -incoming option with channel type "cpr".  The CPR channel
>>>>>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>>>
>>>>>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>>>>>> a second migration channel of type "cpr" in the channels argument.
>>>>>> Old QEMU stops the VM, saves state to the migration channels, and enters
>>>>>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>>>>>> resumes.
>>>>>>
>>>>>> The implementation splits qmp_migrate into start and finish functions.
>>>>>> Start sends CPR state to new QEMU, which responds by closing the CPR
>>>>>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>>>>>> main migration channel.
>>>>>>
>>>>>> In summary, the usage is:
>>>>>>
>>>>>>      qemu-system-$arch -machine aux-ram-share=on ...
>>>>>>
>>>>>>      start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>>>>>
>>>>>>      Issue commands to old QEMU:
>>>>>>        migrate_set_parameter mode cpr-transfer
>>>>>>
>>>>>>        {"execute": "migrate", ...
>>>>>>            {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> [...]
>>>>>
>>>>>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>>>>>> index f31deb3..2210f0c 100644
>>>>>> --- a/migration/vmstate-types.c
>>>>>> +++ b/migration/vmstate-types.c
>>>>>> @@ -15,6 +15,7 @@
>>>>>>     #include "qemu-file.h"
>>>>>>     #include "migration.h"
>>>>>>     #include "migration/vmstate.h"
>>>>>> +#include "migration/client-options.h"
>>>>>>     #include "qemu/error-report.h"
>>>>>>     #include "qemu/queue.h"
>>>>>>     #include "trace.h"
>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>> index a605dc2..35309dc 100644
>>>>>> --- a/qapi/migration.json
>>>>>> +++ b/qapi/migration.json
>>>>>> @@ -614,9 +614,47 @@
>>>>>>     #     or COLO.
>>>>>>     #
>>>>>>     #     (since 8.2)
>>>>>> +#
>>>>>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>>>>>> +#     new QEMU instance on the same host with minimal guest pause
>>>>>> +#     time, by preserving guest RAM in place, albeit with new virtual
>>>>>> +#     addresses in new QEMU.  Devices and their pinned pages will also
>>>>>> +#     be preserved in a future QEMU release.
>>>>>
>>>>> Maybe "@cpr-transfer: Checkpoint and restart migration mode minimizes
>>>>> guest pause time by transferring guest RAM without copying it."
>>>>
>>>> "Checkpoint and restart migration mode" is ambiguous.  It would be
>>>> "Checkpoint and restart transfer migration mode".  That's a mouthful!
>>>> "This mode" is unambiguous, and matches the concise style of describing
>>>> options in this file.  Few if any of the options in this file repeat the
>>>> name of the option in the description.
>>>
>>> True.  But will readers understand what "CPR" stands for?  Do they need
>>> to understand?
>>
>> No, IMO they do not need to know the full spelling of the acronym to use the
>> functionality.  It is spelled out in a few places now.  It could be spelled
>> out in more places in the future.
> 
> Alright.
> 
>>>>> If you want to mention the guest RAM mapping differs between old and new
>>>>> QEMU, that's fine, but it's also detail, so I'd do it further down.
>>>>
>>>> I'll strike it.  I agree the user does not need to know.
>>>>
>>>>>> +#
>>>>>> +#     The user starts new QEMU on the same host as old QEMU, with
>>>>>> +#     command-line arguments to create the same machine, plus the
>>>>>> +#     -incoming option for the main migration channel, like normal
>>>>>> +#     live migration.  In addition, the user adds a second -incoming
>>>>>> +#     option with channel type "cpr".  The CPR channel address must
>>>>>> +#     be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>>
>>>>> Permit me to indulge in a bit of pedantry...  A channel address doesn't
>>>>> support SCM_RIGHTS, only a channel may.  A channel supports it when it
>>>>> is backed by a UNIX domain socket.  The channel's socket's transport
>>>>> type need not be 'unix' for that, it could also be 'fd'.
>>>>>
>>>>> Suggest something like "This CPR channel must be a UNIX domain socket."
>>>>>
>>>>> If you want to say why, that's fine: "This CPR channel must support file
>>>>> descriptor transfer, i.e. it must be a UNIX domain socket."
>>>>>
>>>>> If you want to mention SCM_RIGHTS, that's fine, too: "This CPR channel
>>>>> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
>>>>> UNIX domain socket."
>>>>
>>>> OK.
>>>>
>>>>>> +#
>>>>>> +#     To initiate CPR, the user issues a migrate command to old QEMU,
>>>>>> +#     adding a second migration channel of type "cpr" in the channels
>>>>>
>>>>> in the channel's
>>>>>
>>>>>> +#     argument.  Old QEMU stops the VM, saves state to the migration
>>>>>> +#     channels, and enters the postmigrate state.  Execution resumes
>>>>>> +#     in new QEMU.
>>>>>> +#
>>>>>> +#     New QEMU reads the CPR channel before opening a monitor, hence
>>>>>> +#     the CPR channel cannot be specified in the list of channels for
>>>>>> +#     a migrate-incoming command.  It may only be specified on the
>>>>>> +#     command line.
>>>>>
>>>>> This is a restriction that could conceivably be lifted in the future,
>>>>> right?
>>>>
>>>> Yes, but lifting it requires the big command-line vs monitor restructuring
>>>> I mentioned earlier.  IMO that is far enough in the future (and possibly never)
>>>> that adding a "Currently" disclaimer would be deceptive.
>>>
>>> Now I'm confused.
>>>
>>> Earlier, you explained why we can't simply send CPR state via the normal
>>> migration channel: we create devices and backends much earlier long
>>> before we receive from the migration channel.  Correct?
>>
>> Correct.
>>
>>> Here, you're documenting that the CPR channel can only be specified on
>>> the command line, not with migrate-incoming.  Isn't that a different
>>> problem?
>>
>> They are entangled problems.
>>
>> * cpr state must loaded before backends are created
> 
> I understand this is fundamental, i.e. CPR state is *required* to create
> backends.  Correct?

Correct.

>> * monitor must be created after backends are created
>>     (because the chardevs that define a monitor are backends).
> 
> This is an artifact of the way we configure monitors (use of a character
> backend) and create character backends (all at once at a certain point
> in startup).
> 
> Some management applications would prefer to use the command line just
> for setting up QMP, and do everything else in QMP.  Understandable!
> They need to use QMP anyway, and mostly eliminating the command line
> would simplify things.  Moreover, only QMP provides introspection.
> 
> To enable this, we need to provide a way to start a QMP monitor early
> enough to set up everything else.  If we pull this off, "monitor must be
> created after backends are created" is no longer true.

Understood.  This is a big change, hence my guess "unlikely to change
any time soon", but "if ever" is too pessimistic.

> Aside: in my view, QMP and command line are transports wrapping around
> an abstract interface.  I'd like to have them wrap around the *same*
> abstract interface.
> 
>> * migrate-incoming must come after the monitor is created
> 
> Fundamental.
> 
>> ==> migrate-incoming cannot specify the cpr-state channel
>>
>> This restriction is unlikely to change any time soon, if ever.
> 
> I wouldn't bet my own money on this :)
> 
>> I have documented it as is, without speculating about future state.
>> If users do not like it they can request changes.
> 
> I'm not objecting to your doc text.  I asked to better understand your
> thinking, because I needed that for a competent review.
> 
>>>>> What happens if a user tries to specify it with migrate-incoming?  Fails
>>>>> cleanly?  What's the error message?
>>>>
>>>> It fails cleanly with a pre-existing error message that could be more
>>>> descriptive, so I will improve it, thanks.
>>>>
>>>>> Maybe simply:
>>>>>
>>>>>             Currently, the CPR channel can only be specified on the command
>>>>>             line, not with the migrate-incoming command.
>>>>>
>>>>> with a big, fat comment explaining the restriction next to the spot
>>>>> that reports the error.
>>>>>
>>>>>> +#
>>>>>> +#     The main channel address cannot be a file type, and for the tcp
>>>>>> +#     type, the port cannot be 0 (meaning dynamically choose a port).
>>>>>
>>>>> What's "the tcp type"?  URI "tcp:..." / channel
>>>>> addr.transport=socket,addr.type=inet?
>>>>
>>>> I will clarify.
>>>>
>>>>>> +#
>>>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>>>> +#     with the '-machine aux-ram-share=on' option.
>>>>>> +#
>>>>>> +#     When using -incoming defer, you must issue the migrate command
>>>>>> +#     to old QEMU before issuing any monitor commands to new QEMU.
>>>>>> +#     However, new QEMU does not open and read the migration stream
>>>>>> +#     until you issue the migrate incoming command.
>>>>>
>>>>> I think some (all?) instances of "old QEMU" and "new QEMU" would read
>>>>> better as "the old QEMU" and "the new QEMU".
>>>>
>>>> Maybe slightly,
>>>
>>> A second opinion from a native speaker would be nice.
>>
>> I have appreciated all your feedback and made many changes, and it has made
>> the code and documentation better.  Thanks for that. But right now, the V9
>> patches are queued, pass CI, and are ready to roll. I would hope at this point
>> that no one would consider "old QEMU" vs "the old QEMU" to be a showstopper
>> that requires new patches to be posted.
> 
> Certainly not a blocker.  If we decide it's an improvement we want, we
> can easily do it on top.
> 
> I routinely point out lots of little things that aren't blockers.  I try
> to be clear what is a blocker and what isn't, but I'm far from perfect
> there.  Thanks for your patience!

Thanks.  Sounds like we are good, and Fabiano can proceed with integration.

- Steve


