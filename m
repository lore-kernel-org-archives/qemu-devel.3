Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A090C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjCV-0004gS-57; Thu, 30 May 2024 13:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjCT-0004fs-6I
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:04:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjCQ-0002nE-HS
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:04:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44UEqAYN006318; Thu, 30 May 2024 17:04:14 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DqtK7sthIGw0wtZphmZtKpRtVAxCDFF2TCophHPXFhk4=3D;_b?=
 =?UTF-8?Q?=3Dju0PwD4IHi0altldBTBNC9X/3zeK3TP8J5XaTWD9T2ezwnfMUoLHdFVnyvMV?=
 =?UTF-8?Q?bw+ad5is_moJ8WX0tidoaYkoAdb75IKdPfqo7T4uK87rSU+XsnuUFFV1C/4GSFL?=
 =?UTF-8?Q?QegJqAUwqwUAPc_zoFtiGOL77bwQZdcFdeyHoEfn1z47aCbyS7hGCBSmMR6pF+7?=
 =?UTF-8?Q?w31y95Ca5TJc3rLESmkB_P3sRxY9lNcRhUj7DwxdKAIuMlKinJm8wEotCZ4OsFk?=
 =?UTF-8?Q?k+qS+E9YkIm472gZhpscyd4DOo_eCtYBwiVXXqk9Gia2i+9xZBwXf3EX4GKiWVP?=
 =?UTF-8?Q?mEW97uKp9bqvbV5S5/AZ9sm0sBnH3uBJ_Gg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7se74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:04:14 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44UGb65M026759; Thu, 30 May 2024 17:04:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc508tywm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FteZtrv4BfPMEdebBFZ/OlbV36YiDxcDv3HKGS2plYhjJnZd+Wn+8+HdftPFITj4Vew5U3//SZ37GV4Lk1yCfSpUHXsq6aHswWxbGMVJQo+WlrwBCEfKfUhPH8Ft72itSWCyjPXZLcPAZfJ79wSENaWexd6a1Q6URq5dwp0D0sWnRvHaSD/+njxeBMKvYRXSkwfHeJ67ajat0jmWOf1vH0qswDfhgT7yrXaefW2Bf3QrngBYxrqOQ4CxwlYCt3f0MfhJzI1Pm3TLSjJFeCdlvZMksrhSrTQCnEvj/cBH+fAYwz+8GTkiQhl8QJRyBqY9vlp7YQqBc4F5dwa/TRQltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtK7sthIGw0wtZphmZtKpRtVAxCDFF2TCophHPXFhk4=;
 b=gGOQy9elSZpgGsneHGX2UqYxqnx/+DLpNd1OBwhg/hPMPi6Kez+hsMgIgOveFt7/+eNZFKg3S4fJZjW9pfeZK8yS/IsHN1BWmPipmjg03e3EyE/RyHUev8oLSx216acBDMIsUGiBEEiXUM397IwA/LwtAhEz05cTEymQw8FXJlF85N1TEF9HxfG1kzdWEH9CYpMDNIxE4EmjIfq24nsyqR5CIhhT4dfAmMQ78Tlu90D6uH+JKRZvX1aZNmel/Vhv1r1EsYRDVvKg6QPbuc7XzwlfuJ8R1eNuNSYS9BPwIwTIdgP2TucSdKKxHLgf0b+yJlqHHwxUkYCrVBmKMHUScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtK7sthIGw0wtZphmZtKpRtVAxCDFF2TCophHPXFhk4=;
 b=E488GptL97iIF3VSWnPDIRimxeAQNPQY60u87PJWD/JTlHG5sPk0/ywZn6N5S3o94Lzv6IddOK7kJel7TklTNs5xfK//Rn2HOW6S7e0Xl2P5ZFZE1G7aXxfNqBL4lQHcaE8b6PFNQqGJFqgHvqdzOqcjiL59AkVPzgq/EvP72+M=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 17:04:11 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:04:11 +0000
Message-ID: <cd82dbe7-0b0c-4696-8845-6ab54d63a2ed@oracle.com>
Date: Thu, 30 May 2024 13:04:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 05/26] migration: precreate vmstate
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
 <ZlTOCLFNF894T46U@x1n> <daca5ee5-87a7-4a07-8161-d5e133c9443d@oracle.com>
 <Zld2ZqscwwJg7fkE@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Zld2ZqscwwJg7fkE@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b8cd3e-6fa3-43c8-c619-08dc80ca86b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjZOcHlCd3JSUWNwbzhsVFpHczVZNnBCdE1VVTFRa2VncG9TbzlDbVJjUTB6?=
 =?utf-8?B?eXdGa2tsSDdTd2loeUlTNUZOQ3ZxYTRlYk1LT0ZTWjZhd2tKc2drQlJlNnAz?=
 =?utf-8?B?aXBSTHFPRHpySnduN00yV0MvU2pQUG43NVh4VVhkVUlTaFhDTmZOT2tVdTRo?=
 =?utf-8?B?RWhVVGJtd3dzYUpxM3o0Y2w4WXlmSk5tVmg5UlZDQWl1R0VKZHNVZDlSbU8w?=
 =?utf-8?B?UFhwakE0ZHBEME9aMEFwcm9WVmdTdUJCTUZkMzMzQ0R4Sm9MTjZDcUJtV3pW?=
 =?utf-8?B?a3o1UGc5cEUvV1NuSDJoMnBtTU1aS2VXN0pPcUlBRlNielJJK0FkQmlGNGFw?=
 =?utf-8?B?SGF3Y08rc0VOS3V3MDZWUk5XRkdiTklqb2JVVVpZK0pUUHk0NjVMTVhzRFlL?=
 =?utf-8?B?RzJVZ0E4MmdkV25SMmJVejEwTmEycUJqMFZEMzIyYlRMQkVFenlVN0liN1hC?=
 =?utf-8?B?V3ptdU5iclpMbGZDLy8weGpqTGIzSC85YTZCd1p4eWhPL1F2YWtsaS9uVDRi?=
 =?utf-8?B?MG9lZkRHbjk1ZEFxcGMxZFREMlZicU9tQTh3MnZZbzlOUXFpSzBwU3h0cVNV?=
 =?utf-8?B?ajRsOUxXY3phQlE2OGxZQmJJZE1wa29kWElkdXRRMEo0Z3FXK3IzdHo5QlEy?=
 =?utf-8?B?UjNWTjdCS3d0MktPRmdzUm1wdTA3WjJGSDFLckdBQkJNaEFBQ0pJVGJRZzNq?=
 =?utf-8?B?Y3BGK0NhK25sbkFFZDdCOTFOTmVCK2JYc0N0TzdvOTVCMHR2Q1NIeXBxYnJ0?=
 =?utf-8?B?R2RLMUwrNGFRc0VhMjEyMzU4Y3djMVRwY3BNQ3FIUUM5YlRPbC9pazFjL0Ni?=
 =?utf-8?B?SmRoY2h0V3lBcXRnWHVxaEhjdVVEQzZNTEQvWWhod2t3Zk5DamkreE1iN1dV?=
 =?utf-8?B?K1JmbkozUitsZWVJekZOakFOMjlOYjl6Z2hPeGxBNEZsd3MraW9LTWVYdW05?=
 =?utf-8?B?c1czK0Y4RmlFNjNBS1NtWnQyaEk4MkkxUXg2akZQMWdXMGdSVXNkc3JGb2dP?=
 =?utf-8?B?UTVGVmxQK3YxOWJuVDh0eSt4Tnh1L1pkTGxsQXVaVG92WjZkVjJxTkcvQ2RL?=
 =?utf-8?B?bG1OTTRES1dUOGZlNjA0Ujl5WHozTzAya1RpKzVzVXE3WGlvNWM1cWs3RXBE?=
 =?utf-8?B?R2o2QUs1RzFhZU9QZ0x1dCtrai9uZjF2T0I1cURNbjZOZzZxSnVqb3E4ZlBH?=
 =?utf-8?B?YmdpWHBJUzZWNGVBU3owbXVZMldXdFp4bm04Z0lZVTlVQUQyZ0pBcStvVTJi?=
 =?utf-8?B?aVMyOFVlQmt1M2ZHMms3TEduOEJhdyt4ZjQvWVo2QUEzQ2c3dVJJemlkcXVw?=
 =?utf-8?B?SU5zOU4xUTNRai81Sk8xcldNVmxlRW1DQW5KRnlyc2JUbmVpeHZzQ0RuL0xi?=
 =?utf-8?B?Z21lQ2drZ2MwVEozbE5aUWhlVmZZVE9CRFVLUklsZk9nejVtSXF5UmcwTmh1?=
 =?utf-8?B?ZEdEZHI5WHhoclRQTkxtUlIvSjlwSWhxMXdZYjNibXpYQkZpZmlYM0hIeVV3?=
 =?utf-8?B?dzJYT2N1alBHektDVkhQWFpmUWRjQ2haeGQzcXdFVzRCWU9zMGdVZzVDOTFt?=
 =?utf-8?B?aDNSRXBqa3dyODYrUXgrRTdlRWhTNTAwWGdvb1VxbVAvS2tUbFlZeGdSSy9a?=
 =?utf-8?B?cTZyakhXRlhnamRkNU1PVkJHVzB1a2VJUkNwK3VJNi9jVE1DMTNZdlZEKzJN?=
 =?utf-8?B?aGlUakFtek5qNGhkNUw0a29KYmFnQkYvMVg1S0lFLzhRbHM3M0JVcG5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0wxWllkaXZybkYySWd5VU12Y1BpbWhZcGMveFcwN2lOaGsvZmJraVB4SkdX?=
 =?utf-8?B?L0FCWVNqN0ZaQVRDR0dkbUxSMzVPaW0wOTBXdTRXVHhmeHRqdDYwOStYZ2wz?=
 =?utf-8?B?aW5Rd1A0U2pCRk11dTVFeVlhUVVJc0w0NGNzaDRRL1BNc3BtNXdsdnpkOGNx?=
 =?utf-8?B?eE5CS1ZhL0dJNm43YUJGY1RsaEpQWVNPelRncXRtU2pIbGc1bm5ueHFwdkRI?=
 =?utf-8?B?dXhzSCsxejVmdU1NcGsyR0tYM2xYekx6QTNoTHM1cU50eW5GRWhNSVRIS3l4?=
 =?utf-8?B?WGY4Rjd6ZVFHZThSU3BsVHBFRmRVRE1WSVdDd3Ftb2RjRjZDZCs3RmlqbUhU?=
 =?utf-8?B?R1BTdnc2N2NCUlVZNTVtaW53TjdiYjVMWXRoSjArVmVmL056ZVZoR09kdW5o?=
 =?utf-8?B?Zjhha0lWMy80ZStkVUthU1ZUbUFtc3BlVHhHcml1L3paTXFkcnI0N0lhOXdI?=
 =?utf-8?B?R3FCZ0tpMkJaWEdrVUpFdEg2emFia01YRGxidGdHVDUvZUNLRFNQciszTTlN?=
 =?utf-8?B?MTdvNkltTXJhRU10RDJCS1FNU0xwZTlCZkN5WXI5c0hsYitKaC95aXgya084?=
 =?utf-8?B?ZnlRc0RYQnVETm5DQllVT051RFdjcUpKemt0M0FFVkVSOUloSzNFeFF1WTc3?=
 =?utf-8?B?UFdFRkEzNGRKU3l6bDZ1ZkNZbldTZDB1MHpISTlvTjR0MVlqSHFRMzFKVnUx?=
 =?utf-8?B?emxER1VxRnBNSW1rdWRPcHJXZElCbGpmZVhXQjE3aDdOREtkTlVkeHVIQ1Jn?=
 =?utf-8?B?TmVvSFRBTDVYYVJvdEFFNThpampzSU1FUU5NbnlIcWxiQ0QzbDJ2YmpQdjZJ?=
 =?utf-8?B?NFA2MmV5RklnNUtrZmJvSUg1LzcrREE5cU9aWXpuQ3NBOSs0cndpUWQxZC9o?=
 =?utf-8?B?Z1BialE1UkxMeUFvcDZLeUM1MzhGSStzaWxhU29ZbmR4Z3hmQXRqWjJDUW9t?=
 =?utf-8?B?RHV2T09EM0NoWjFJWHJYQm9wRDhXTVM0MkZXYVhYeUVXMHhhTWVZalgzQ1pR?=
 =?utf-8?B?eURrNGYyclhRMHBET2xmSjV6d0taME9WekRLVWU3a0hhRFppcnRCZitvbC80?=
 =?utf-8?B?MG9TNllQMGJOMVlIOHVaMlJwSGFLeXordkxpeTVGQkJhbkliODNUOGxMcFlm?=
 =?utf-8?B?L3BGR3ZGcXJrNHYzUStVMVpMNDRra1JxUUdScGRnUkF0em1jL2Q1SHlEYXNl?=
 =?utf-8?B?Q1EzbmtpTXp2ZnpaOElaem13NEcwK0FxWUQxUSsvVHlwam93OE5pQlBIWlNn?=
 =?utf-8?B?Sjc1M0xOWXRjbjBmZ1pneGZ1ZnNGbEdid2FHUzJjeFJtQXJ6RWpTTDkwSUhR?=
 =?utf-8?B?NzhabzBNN1hwMEpJL3hLbUp3enRNVUxSc1pKLzA3aExsWFFrU0ZzcWo1cXQ2?=
 =?utf-8?B?M21VWU1JYjFzdEgrZG5rQ0ZrOTdWaytadEk4Zk9DbHhvSXJMOHNDQWNMWTZO?=
 =?utf-8?B?V29xakM1a1QzMWdJZDBDcG1MZ3Y5WU5oaTZlNFcxQnBuSlVyN2xBdU9WRktJ?=
 =?utf-8?B?c2pmZG91ejB6ZXUrdDZmUFJ2cVBvdGdNbTgyS3pRMGJtNHRoQ0I1OG42RzVQ?=
 =?utf-8?B?R2kvUldGRDFnOHdHaWNQZkE2bUdzakorVmxNb3ErVVZ5UzVtTGpVQXRPZ3NL?=
 =?utf-8?B?dUlIeVpubjFKUUpRZFdXRE9UejlhWE05TXZpenpnSGlLVWV4WFdrQnlZZFpv?=
 =?utf-8?B?dlhzdUJ5OUVNSVdUQ3dWWUk3TTJmRE9jeGJiVzRHeFUwM1lJK3NsOHFhd3o2?=
 =?utf-8?B?bk9IQmhuLzhJOGdHVFFOMXhNVTJ2OHBySTF2V3cwY1NBR3lWNTdQcFN1UXBu?=
 =?utf-8?B?eFhMYUpYZHA0THJEVXRPMFN1SFUvRU5EOTd1enVDTGhING03d21FaU5zR1hP?=
 =?utf-8?B?VFZDaDg1YWovWlc3KzNCZERrMVpBdzJuZkhITjFrbFo5cUdtNHA0bWFWK0xC?=
 =?utf-8?B?bWdmeXhNd1ZYSy8vUGpWbUMwd2pqdGpOTUVwT3crWlEyZURUblVyc2V6cS9w?=
 =?utf-8?B?VGl0dU1lSHhGYUNqWThybTJQOS81dzRrMXQxeE52VEJESWd2RGd3a2pvWGZk?=
 =?utf-8?B?a2JUUWFWVml5ZE5mWkFxRTBXb1IwNkZ5MmE4VDk5a0lxUGVFN1RRZlBTSWhL?=
 =?utf-8?B?MFdQMk5NdCtkRUpiVExLWm1WWDNtUGoxZ0tNS2p0VE9XZlpNSDVnNzlKeHdo?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KxL6vfQewIaciuKSZr7U5jweWtNu+nx7aRiKqE7odTKmYRU/lCdZ+XG6R+CP86SFWpYG97AXrFComauZupv9fbw5I64irvz1p1npQ3cwuXdyA5Mp5BbNul/1nzLAOT0Eh4+G/uzS253KzkGWNWFCiylfNIluWrQdb94J2fxJhSOySSRxG4TEkhis57lF6qy+dvBdmz/dwmT/QPLt0fn0EYtNvOstqIzLhf4jG7sg6P1GCE9qevEpFB8zSTMM9XkHkMKTFYdZgD1S09oWNWBtj1Av9XJTsOvCESpfnQ2f4kp2xV2pKf/8ZGujq3USolFvXutt99rOWAxepbczX6Y6VrUZfRR8rRg7TGWtiTj/t65BN0l/gC8R/IEkNrKOmkRoxa9dpej71Arh8knEEaf1awrRIg59jy9S0NvKAzUMKnYVEkQXusmqbm0JKgF+VFUlayqpxPAqqKDPBTZR4PkeQxLAR6VXO8tK4X0KkYWAnzMX0p+SdjeoT13upUeBiOGbTtVEm986bhmIxICRNQxZ4mmmF+wq8fzYEpvKLCBTk7gVCHYiveAZyFrGHlDZU4NSNDbrQhnCEsgudMTncpMZ5GpBld9AOk3w9IzwgohyLkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b8cd3e-6fa3-43c8-c619-08dc80ca86b3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:04:11.2794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlbkO+oXnllsVkhSFOGpaomkmnixK21c5SYgoOzXCfVt2M9gIhZ7JVxJGOlV4jbiP6BX0XEUn00ivzoQMtXLxeBrFLh+51uitIQXyJuktMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300126
X-Proofpoint-ORIG-GUID: Rwwo6nE2RP51HYWWHSOB5liu49M5ZvWJ
X-Proofpoint-GUID: Rwwo6nE2RP51HYWWHSOB5liu49M5ZvWJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/29/2024 2:39 PM, Peter Xu wrote:
> On Tue, May 28, 2024 at 11:09:49AM -0400, Steven Sistare wrote:
>> On 5/27/2024 2:16 PM, Peter Xu wrote:
>>> On Mon, Apr 29, 2024 at 08:55:14AM -0700, Steve Sistare wrote:
>>>> Provide the VMStateDescription precreate field to mark objects that must
>>>> be loaded on the incoming side before devices have been created, because
>>>> they provide properties that will be needed at creation time.  They will
>>>> be saved to and loaded from their own QEMUFile, via
>>>> qemu_savevm_precreate_save and qemu_savevm_precreate_load, but these
>>>> functions are not yet called in this patch.  Allow them to be called
>>>> before or after normal migration is active, when current_migration and
>>>> current_incoming are not valid.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/migration/vmstate.h |  6 ++++
>>>>    migration/savevm.c          | 69 +++++++++++++++++++++++++++++++++++++++++----
>>>>    migration/savevm.h          |  3 ++
>>>>    3 files changed, 73 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>>>> index 294d2d8..4691334 100644
>>>> --- a/include/migration/vmstate.h
>>>> +++ b/include/migration/vmstate.h
>>>> @@ -198,6 +198,12 @@ struct VMStateDescription {
>>>>         * a QEMU_VM_SECTION_START section.
>>>>         */
>>>>        bool early_setup;
>>>> +
>>>> +    /*
>>>> +     * Send/receive this object in the precreate migration stream.
>>>> +     */
>>>> +    bool precreate;
>>>> +
>>>>        int version_id;
>>>>        int minimum_version_id;
>>>>        MigrationPriority priority;
>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>> index 9789823..a30bcd9 100644
>>>> --- a/migration/savevm.c
>>>> +++ b/migration/savevm.c
>>>> @@ -239,6 +239,7 @@ static SaveState savevm_state = {
>>>>    #define SAVEVM_FOREACH(se, entry)                                    \
>>>>        QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
>>>> +        if (!se->vmsd || !se->vmsd->precreate)
>>>>    #define SAVEVM_FOREACH_ALL(se, entry)                                \
>>>>        QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
>>>> @@ -1006,13 +1007,19 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
>>>>        }
>>>>    }
>>>> +static bool send_section_footer(SaveStateEntry *se)
>>>> +{
>>>> +    return (se->vmsd && se->vmsd->precreate) ||
>>>> +           migrate_get_current()->send_section_footer;
>>>> +}
>>>
>>> Does the precreate vmsd "require" the footer?  Or it should also work?
>>> IMHO it's less optimal to bind features without good reasons.
>>
>> It is not required.  However, IMO we should not treat send-section-footer as
>> a fungible feature.  It is strictly an improvement, as was added to catch
>> misformated sections.  It is only registered as a feature for backwards
>> compatibility with qemu 2.3 and xen.
>>
>> For a brand new data stream such as precreate, where we are not constrained
>> by backwards compatibility, we should unconditionally use the better protocol,
>> and always send the footer.
> 
> I see your point, but I still don't think we should mangle these things.
> It makes future justification harder on whether section footer should be
> sent.
> 
> Take example of whatever new feature added for migration like mapped-ram,
> we might also want to enforce it by adding "return migrate_mapped_ram() ||
> ..." but it means we keep growing this with no benefit.
> 
> What you worry on "what if this is turned off" isn't a real one: nobody
> will turn it off!  We started to deprecate machines, and I had a feeling
> it will be enforced at some point by default.

That's fine, I'll delete the send_section_footer() function.

- Steve

