Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3138D5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Q7i-0000g3-TO; Fri, 08 Nov 2024 09:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t9Q7Z-0000eG-Jt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:37:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t9Q7W-0003tV-FT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:37:57 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8EbQNR005803;
 Fri, 8 Nov 2024 14:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=8mVqbwZ3StCr8Lz0O7VRTOuEfMpuNol1qw1jWnENaMo=; b=
 EeBuIMwCutGB8q8+uv89LWe3v2QzpeeSQGo9htq0kyCYnfZCBnayjAQNt+pOPUGk
 CmBH7HgJjWCGDwCRjk1JOKFbuueHdrCEFu+HbpykS+D3yMP+Ok1OnE8yHW/JRInM
 2GGmXbuOatksKtbuerQWK4slfVNZBexMPTeaVqpEla0PwR9Q9DLM16Kpy6p/Pzek
 DgIbUkD/wvc063la2fnPY6y2LalCcLDUjdbJ4n/zwDybvrUAmct1e0MoZXpwnt/3
 ntO4UgziDny/lP/P1s0jaOihgY/eYU8f05xC7YerwHzq/oY2m5yXOoMH4H8IbUo3
 azrM1I0lPPYSIuUceA9oPw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gn1jsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Nov 2024 14:37:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A8CUTuN036479; Fri, 8 Nov 2024 14:37:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahhu6wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Nov 2024 14:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1whewsoft03ropg0UjMgPhYI3Kjc3hIufNcBf3lOe6n4YJSzUym+aO36AvifySC4EhdmtMUc+WfuDLzos21IDAy0cGHD0Bsd3dYR5PeCtA0TPt4/mXanBqtQ7Rk2W92NFthWH6/mM0ST6xXF0cvzkxru6dQF5l3mzaw+gaEAyycRWKB8K51LINDx5JAviQrWmRgm4ZdoivHlHtt+PLpp3FigJD9h7/pqEEmNmEqhQZovqyEMpaSo4DcI+lzZBBOlIJzeiqUfXKZisNeQ4PmW4Dl4n0hTczqeD52MMYnOeEVJG+JT6yML0Uf/VW1NuMTQsX5/1uERDz+wvsnMYlFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mVqbwZ3StCr8Lz0O7VRTOuEfMpuNol1qw1jWnENaMo=;
 b=xMX8Seqy/Ht1Ip2OH6BO5UX8Q2EqoRA68n8vN6uZIW6sPjJlQNodq9zLpEKUN+DaMMsIkjSsJmzK4gbYKgGUQLhXCvcKHzSlrBj5ETK+tD0iev9Tq40mVcb6XyjmRDZmXK2v5OA0bvl02Q7EgnGw7sDmGl/jiKyfgtTo8PlIpSePB8aN7eKzcLJNohKLagsQlt1KdQkI2WoTfK2CmnIbjqLK49hZs5WOpNxDCMag5E6qe2VQEaYLgxwkEjOnt2eH6NBkl4cyvuE6Dte4Wsfl/KK8bmse3GxGrVbTwSX40SmR/4DolUADPFSYWDTEs916pZbJSKPkwei2lKxcao8o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mVqbwZ3StCr8Lz0O7VRTOuEfMpuNol1qw1jWnENaMo=;
 b=eJoFv2atT4TDrJ53V72tdcrOet56Im4cpXe7sRDku7sNRSMSzkT/x5X3sCfN2u3e6t50szgm0BMAAUfI4F/D4Ft9pNBlyRfwTiqr/IAQD6FVmQnCGUsuZI5CBn6vsha5lxS06vsqc0VWcoRNpIX8oGjBpf9v/TuI0/0AYoOf0PU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 14:37:45 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 14:37:45 +0000
Message-ID: <29d21f54-38e7-43a9-86fa-586bd6f957be@oracle.com>
Date: Fri, 8 Nov 2024 09:37:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
 <44b15731-0ee8-4e24-b4f5-0614bca594cb@oracle.com>
 <99c6d0df-4ced-4fe5-bc87-2682d1ceaa5b@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <99c6d0df-4ced-4fe5-bc87-2682d1ceaa5b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5d2001-0296-4de9-4a6b-08dd0002e8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFp1YVREMzY0aU5ua3ZEQW5VenVhaGRSbWxJMTd0by9oVUVDZkZRQVU1Mito?=
 =?utf-8?B?NDdqVkV3aEtqVlpHUlhkY1pzalQ1M2RjTG1Zd3NhVy9WanhObStsUlczRnFI?=
 =?utf-8?B?QmRaN2VSMnpqcExSUnhNdVNGTEI0M2dvektKVEJ4eTVRWWJWK0tFdzNiVkFL?=
 =?utf-8?B?S3h3ZWx2MUJtUkVJNGtROEQ0bTBQVlFsQkgybG12dytLcFFMODZvcE5LU0hQ?=
 =?utf-8?B?L1E0S2RYMWZrNmZKQXp6d0NWVzFvT1JQQmU0ZVlhUVB2KzJOZEk3Q1ZiTEs5?=
 =?utf-8?B?OUtTaVpramYyVDVNSlNHSDY0eVdYZ2FwdHlyZ0pCbEsxdXVKMnVzRUV0ZVRq?=
 =?utf-8?B?dm1BV29EOXRQekpkSTVPeXVlMmlmbUFMY2lOaHZoTUZ2RjhoQWs5MjVMV2VS?=
 =?utf-8?B?dHUrNDBOdGd3VXV2N2FwTXhMcTBTOHZRblRJKzUzeUQ3Zm50SGNNVTJxRWFY?=
 =?utf-8?B?UGRVc1NMaUpxanZxQjZ0RVlLcklTUDZKaEsycDdLa0x2MWV3RDlsTkRaOXB1?=
 =?utf-8?B?UmZNcVJMdUJlVjgya0ljWjE0QjhwdDVlb1ZLS2hVa2cwcVIycHNobmpGOFQz?=
 =?utf-8?B?Nm03d0hiN203TmNhTmF0TkdvNUl0TXhHeVR3TXZqYWl5RWJIWlJGVDQxTjN6?=
 =?utf-8?B?QmZ4bHRSS3RqbCtXMWZIVGtnMnE0b1ZKam5iNURpbk8wNzBCU1dudWtWV0JT?=
 =?utf-8?B?ZTFwZWMvYzQrYTc0TkNOaTlZRVVJSXhYQjhGcll3K0tqNDY1ZnFuc2g0eEZZ?=
 =?utf-8?B?VFUrTW93blE1K29sRUQ4NzgxeUVFNXpMVytHOU5QbTY0Y1VKa0x1TGxZOVpk?=
 =?utf-8?B?blBRZmREYTBudC9MVDBuNTJhRGhPbExneXppWHIxR3pTcS9wYVBZekR4Smlz?=
 =?utf-8?B?c2l1RDVBVENkcE9pa29GYjdSWFNJVGJDS2N2WlN4K05qUExXdSsvQW1uS3lB?=
 =?utf-8?B?RjN4Uk5NVWszek8yeE5kRTE1bkpNZXo1RG9heDcyKzJSSUdXaXk2ajBjQjd3?=
 =?utf-8?B?UytCNllEU21JUHZqVU5HUGJ4RkF6T1RrWVdTVmFUZDljdXBMWkxhL1hQMmVq?=
 =?utf-8?B?VWZqdnFEWHdXdUg2QnZoV1p5Y3hxMlFEZC9PK051TzZoVVBPSDF5Z1orTTlO?=
 =?utf-8?B?U2dZQTZ5TjdqYWV4dmErZXpYdXplS0lBQi9tcHBnYWNnOFRXOEJCVHBsL3lK?=
 =?utf-8?B?SVk0OXRPbEoyeTF3MHhtUFZWOTUxeHBJdVRSK0l0QWFJWEVrMW4raEk2L1dM?=
 =?utf-8?B?UG95OWViL2JDL3VyYzJLWkNLVTBmclNHTzA4QnVKMjVMaUx0dHRab2IzRVN1?=
 =?utf-8?B?bExDcElpRVpjNUdEbHhXRlhnUTNhU29Fdk9JVENZZGI0dFdWNFIvZmtHd3dN?=
 =?utf-8?B?MnE3MFA2a21rcDA5dnBxT0NPWHFwL283M0UvbGY4d2RZMUlRcGxvWWVzUFdF?=
 =?utf-8?B?c1VtUzB6YkRDcjRKeFFTaEJMaWRnWTE5MVFoOHptU2VTMnZUTWlYL09Qa1Ja?=
 =?utf-8?B?aVJrdUlUeVdwT1d4NXgzeUJEajJlNm5ONnZSMFpXVU5SWE5xSFZiUzk4a2sw?=
 =?utf-8?B?S0xldUViRVNDc09MU2lFOFhIQ2wxeVozZjhBSXZCZnVhd1l3bXZ0SlR4dmdC?=
 =?utf-8?B?SlQ5SjhTV2RmY1VwSlF2ekJqTmRmRDIxS0FwMmJhU0tZRFc4UUlveGNvUDdR?=
 =?utf-8?B?S2haS0ZoeHAybG5HV0Ywd0RTN09OaXVRTnRTRDRFSUgva1Njb05tUk1NckN0?=
 =?utf-8?Q?R3z8Smvdc/xxqzo3ZFbgpplNJZljL2bNJ4oWF/z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhDNUgzMHN4MWQ5dTJVTjhsbGxBeU55RTZ0eGF2UFhGZG0wN285eFlqamht?=
 =?utf-8?B?d0lnNHU4ZXlvZlBFOGxaMEhsV014VWxvUVhBY2lsLzdaY2pxc0szUzVDUzND?=
 =?utf-8?B?OSsvdjFjYmhtSms5ajVqVEFmYjN5WkpvejJ2RGJWWi9OdWRscG52T0VnWFBK?=
 =?utf-8?B?b1lObjA1cENlUXhjU00zZ2VJdm5WNkhTNlAyeno5U3hCODRVSEMwM0FLK2FH?=
 =?utf-8?B?elBxWGFFQnY0VWNRL2wyaituK2VwODlZRjVpR1RXMlF0SFBqa3I1cmJ3cTNO?=
 =?utf-8?B?dWVGeHNxR2NkbXRDV2djMTAvaGl5UE1TUTBBb0hTNXQvOG0wT1NvdTFZRmQ3?=
 =?utf-8?B?MDIrL1NXR1hSL3hmekxIZnRlTWJhcjhpbkJFcHJHT2NFaTFWMUlDU04zMC9S?=
 =?utf-8?B?cDBCemhFcS81eVZyWU56TU5wcUtOV0h5YmJEbWd5dlNwMmZjcyt6NlhOSFRh?=
 =?utf-8?B?ZlMvaGVTY0tsSEJYVlgvbUlyOHV2WlJRWUsyMmZJZmFXRWJRUUl0aEtvakM0?=
 =?utf-8?B?b3hZWldERXFRQ3cvSW04eEh4Q2g5MXU2SjdiS3ZzMEJXc2NBMEIvU0RYNU5O?=
 =?utf-8?B?TjNISFhDeEpRTWwzZndpWnZiTEwxZHUvTVZOaEpPSmNnZjJLY1ZLS0pGNHpD?=
 =?utf-8?B?ay9qVFFCbjE4aFVVTHRRcHNnR1l1em5QOWM5ZDFUaDVSVFlGcmpZbWJ6SGNj?=
 =?utf-8?B?bExlcm1qSVBtUTVOSi93M21aVW9HeGZoT0hZTEFSTUxmaHVBMDdOZFhMQzVy?=
 =?utf-8?B?SVNVQ0JaaVNya2NmZU5CQjNXS2RjcCtXbWFodzVhQ2JJT3dkbE5EaWkyZWky?=
 =?utf-8?B?bnlTa1dFRWxJaWh5M2dVV0p1R2Fqdllsa0RJZDUramxVcnFvWU0vQytIZzM2?=
 =?utf-8?B?dWpZbHYya09BNm5xNDRGTlNRL2FkQXdkU1dWMTVES09qRnJ1NzNHNS9LWng0?=
 =?utf-8?B?Q3VVS051ZVorZUhxRURoMHMyUDkxQlpvZityOGN4VktWQUFyLzVhczdYQjRX?=
 =?utf-8?B?aFMwWnF6Yk9EdXl2eXFpMGhXYnB5U2x6ZHA5NWVXR2hDS01EaHdtUURLQ0pY?=
 =?utf-8?B?VFZzbDN4V1QwM2EyQ2dUVDZ1dC9aZ3g4MWdHcFNrTWZRUEpSMFV6TEZLQjNp?=
 =?utf-8?B?cUh0b2w2czJ5bnpGVDNET2lFOFNXR1RlU1lYOEtIcGx4SUIvaG5ZVVl1TlNN?=
 =?utf-8?B?U3ZublRCTnpDZ2NobGJpSTZZMEZKQi9xRmpIZDN3Y1ZMZDh0Um1IVDI1SmdR?=
 =?utf-8?B?cmEwRGhORC9XMW9DS1RIYTU5R3RWdkN5TE5YQXRBYVBldzhmZHFaR2VMTkdm?=
 =?utf-8?B?dGRpVnZxVDgzY2JJVlJCRndBTUR2N3BiWXVYTFZCOXJ4VlJoMnEzN0I1bGh5?=
 =?utf-8?B?dFNDbzZCc3VuVU9UdVJvcys3N2dRVE9sU3h3UkhiZlNXS1AyYjVGVHpwYk1S?=
 =?utf-8?B?MllldHlIVzNENndHbUdqdGtoVDBycVFXNEVyNGNTUmN6NHc0YUNkTUZ4MGJI?=
 =?utf-8?B?TFp2eGJCRVI1Vms4K25sNkphU3dBeDlZZlNwV1pjelk2WW9WN205VURWZHpq?=
 =?utf-8?B?NWQ0d2tXU0paM3NDcDg4QTZWRkZGWmNodDdDTUVxQzFTNVRtYnBnR2lPekxQ?=
 =?utf-8?B?OGJZUmpJblRjU0RjdXJ0SUNCTHR6dElqMVJobmNjN2lJMUVaTnZ1K3NnNUls?=
 =?utf-8?B?NmQ5VDFTL2JSWE8zc2d1dWVnTWgybmMrdmJlNHVXL3VHYkI5SURJbjNlTm0x?=
 =?utf-8?B?T210RC9rV1FOa1VVcTQ0T2drbzkzcEh0QzR2Z0hmYno4Z0pJL1VacDkwNlo5?=
 =?utf-8?B?dTVCbWJtK0RwcmthQnhucHlEQktxdE1VbUVUMTM4TTR3SmYySWttTllFSnc2?=
 =?utf-8?B?bnpmOGlRcGtZMllINkE4STV2STVNY0s5UnBJMGRmRkdieDU2dWlML0FHbHc3?=
 =?utf-8?B?Z3JkUDBlb0V0NVc0bWw3L3Nyek8yVzNvajRjdW91ZFlVMHVzWjRMNVVLQjhN?=
 =?utf-8?B?MjNNS0dOWVRCV1Jyc0FRb2QwQ2JQZU51aDZqcDdqY214REhYejcxcmtJRzda?=
 =?utf-8?B?NEl3SXdqRkZSQ1NMWXRHRXBSbTV5RFFJOC80ZzZrT25LMEZGcmlYMUgwNGxl?=
 =?utf-8?B?NHYzcE5uWVBLdFNCUDZGbkxJZmNWSHNBWUU0OTVXTUowN2NHRFgvSzlObHNs?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: edfQzXA++vFNfR0VxUBVLvoXOUgYBJAiDIKOW2EFwuwRYBQnpUPLJyVXGjOeTSRnwFOGxkGjmPGARkGW3FCq9xb459dhsBBxcbCuy80LbvKtnEZDEJVYp9NxaS3fJMAE952q7Mhw5q/SgKztOSKCG8d9Pmu5p98zVrrTAx1ZmSv+n+PlclgxBvn3ER0fjfz3qZ5QPdGYD6z+nMDkA2cNQC4cYxQTg2hbQTw2uZvxR9235t3oTmC/oL6ZH4yGTWn0Zf+L4bj7l3rYOrNpbJ5mFBrR6llob8xtfhP9SlY86/IAHbWpnPdssDpRqHpE9ecaym6hhZW+PFY4qmOuOEKNF4yORHnCE7kFtjh3NFDHKjxFOpq4GurkMJZubw9ftC134AC13QEtJepe5Kkt03f6OwfLUKRDkpp0LBdCIgpgwZNFu6pCPeX4WLkFHcuwIsqZ1KMQpuMrEShHYB7xfG8jP/Y0b0SIzXreLf6S95rI/oJ19uVFXjW//HsS65fWDwSybOwzrtlZTLiK+P6JAC/1XY0osislMiYbL8xW7xU2xQ+cm9D4wiM6CNVBlWISRZnDbJwPjy6aEQSiwWH/sDWHSz05t/GFteIQ1TCg/9xy4EY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5d2001-0296-4de9-4a6b-08dd0002e8a8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:37:45.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ab0pb6I/VPfje82dJ9oiklFf6s+ZqtN49HFCNmmD8XTn8hwUGFW3xU/m42ZNHesT66oO0cSEx7bRancZmclFXM/S+zbCKwhuJm2kIOyRrgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_12,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411080122
X-Proofpoint-ORIG-GUID: cWB5uf85Gb92mEx5smibKHj_D5tgTOrW
X-Proofpoint-GUID: cWB5uf85Gb92mEx5smibKHj_D5tgTOrW
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

On 11/8/2024 9:20 AM, David Hildenbrand wrote:
> On 08.11.24 14:56, Steven Sistare wrote:
>> On 11/8/2024 6:31 AM, David Hildenbrand wrote:
>>> On 07.11.24 17:40, Steven Sistare wrote:
>>>> On 11/7/2024 11:26 AM, David Hildenbrand wrote:
>>>>> On 07.11.24 17:02, Steven Sistare wrote:
>>>>>> On 11/7/2024 8:23 AM, David Hildenbrand wrote:
>>>>>>> On 06.11.24 21:12, Steven Sistare wrote:
>>>>>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>>>>>> details. See below.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>>>>>
>>>>>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>>>>>
>>>>>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>>>>>
>>>>>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>>>>>
>>>>>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>>>>>
>>>>>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>>>>>
>>>>>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>>>>>
>>>>>>>>> Yes.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>>>>>
>>>>>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>>>>>
>>>>>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>>>>>> -- memfd if available and fallback to shm_open.
>>>>>>>>>
>>>>>>>>> Yes.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>>>>>
>>>>>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>>>>>
>>>>>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>>>>>
>>>>>>>>>>> Thoughts?
>>>>>>>>>>
>>>>>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>>>>>> of options and words to describe them.
>>>>>>>>>
>>>>>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>>>>>
>>>>>>>> Hi David and Peter,
>>>>>>>>
>>>>>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>>>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>>>>>> for simplicity.
>>>>>>>>
>>>>>>>> Any comments before I submit a complete patch?
>>>>>>>>
>>>>>>>> ----
>>>>>>>> qemu-options.hx:
>>>>>>>>          ``aux-ram-share=on|off``
>>>>>>>>              Allocate auxiliary guest RAM as an anonymous file that is
>>>>>>>>              shareable with an external process.  This option applies to
>>>>>>>>              memory allocated as a side effect of creating various devices.
>>>>>>>>              It does not apply to memory-backend-objects, whether explicitly
>>>>>>>>              specified on the command line, or implicitly created by the -m
>>>>>>>>              command line option.
>>>>>>>>
>>>>>>>>              Some migration modes require aux-ram-share=on.
>>>>>>>>
>>>>>>>> qapi/migration.json:
>>>>>>>>          @cpr-transfer:
>>>>>>>>               ...
>>>>>>>>               Memory-backend objects must have the share=on attribute, but
>>>>>>>>               memory-backend-epc is not supported.  The VM must be started
>>>>>>>>               with the '-machine aux-ram-share=on' option.
>>>>>>>>
>>>>>>>> Define RAM_PRIVATE
>>>>>>>>
>>>>>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>>>>>
>>>>>>>> ram_backend_memory_alloc()
>>>>>>>>          ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>>>>>          memory_region_init_ram_flags_nomigrate(ram_flags)
>>>>>>>>
>>>>>>>> qemu_ram_alloc_internal()
>>>>>>>>          ...
>>>>>>>>          if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>>>>>>              new_block->flags |= RAM_SHARED;
>>>>>>>>
>>>>>>>>          if (!host && (new_block->flags & RAM_SHARED)) {
>>>>>>>>              qemu_ram_alloc_shared(new_block);
>>>>>>>>          } else
>>>>>>>>              new_block->fd = -1;
>>>>>>>>              new_block->host = host;
>>>>>>>>          }
>>>>>>>>          ram_block_add(new_block);
>>>>>>>>
>>>>>>>> qemu_ram_alloc_shared()
>>>>>>>>          if qemu_memfd_check()
>>>>>>>>              new_block->fd = qemu_memfd_create()
>>>>>>>>          else
>>>>>>>>              new_block->fd = qemu_shm_alloc()
>>>>>>>
>>>>>>> Yes, that way "memory-backend-ram,share=on" will just mean "give me the best shared memory for RAM to be shared with other processes, I don't care about the details", and it will work on Linux kernels even before we had memfds.
>>>>>>>
>>>>>>> memory-backend-ram should be available on all architectures, and under Windows. qemu_anon_ram_alloc() under Linux just does nothing special, not even bail out.
>>>>>>>
>>>>>>> MAP_SHARED|MAP_ANON was always weird, because it meant "give me memory I can share only with subprocesses", but then, *there are not subprocesses for QEMU*. I recall there was a trick to obtain the fd under Linux for these regions using /proc/self/fd/, but it's very Linux specific ...
>>>>>>>
>>>>>>> So nobody would *actually* use that shared memory and it was only a hack for RDMA. Now we can do better.
>>>>>>>
>>>>>>>
>>>>>>> We'll have to decide if we simply fallback to qemu_anon_ram_alloc() if no shared memory can be created (unavailable), like we do on Windows.
>>>>>>>
>>>>>>> So maybe something like
>>>>>>>
>>>>>>> qemu_ram_alloc_shared()
>>>>>>>         fd = -1;
>>>>>>>
>>>>>>>         if (qemu_memfd_avilable()) {
>>>>>>>             fd = qemu_memfd_create();
>>>>>>>             if (fd < 0)
>>>>>>>                 ... error
>>>>>>>         } else if (qemu_shm_available())
>>>>>>>             fd = qemu_shm_alloc();
>>>>>>>             if (fd < 0)
>>>>>>>                 ... error
>>>>>>>         } else {
>>>>>>>             /*
>>>>>>>              * Old behavior: try fd-less shared memory. We might
>>>>>>>              * just end up with non-shared memory on Windows, but
>>>>>>>              * nobody can make sure of this shared memory either way
>>>>>>>              * ... should we just use non-shared memory? Or should
>>>>>>>              * we simply bail out? But then, if there is no shared
>>>>>>>              * memory nobody could possible use it.
>>>>>>>              */
>>>>>>>             qemu_anon_ram_alloc(share=true)
>>>>>>>         }
>>>>>>
>>>>>> Good catch.  We need that fallback for backwards compatibility.  Even with
>>>>>> no use case for memory-backend-ram,share=on since the demise of rdma, users
>>>>>> may specify it on windows, for no particular reason, but it works, and should
>>>>>> continue to work after this series.  CPR would be blocked.
>>>>>
>>>>> Yes, we should keep Windows working in the weird way it is working right now.
>>>>>
>>>>>    > > More generally for backwards compatibility for share=on for no particular reason,
>>>>>> should we fallback if qemu_shm_alloc fails?  If /dev/shm is mounted with default
>>>>>> options and more than half of ram is requested, it will fail, whereas current qemu
>>>>>> succeeds using MAP_SHARED|MAP_ANON.
>>>>>
>>>>> Only on Linux without memfd, of course. Maybe we should just warn when qemu_shm_alloc() fails (and comment that we continue for compat reasons only) and fallback to the stupid qemu_anon_ram_alloc(share=true). We could implement a fallback to shmget() but ... let's not go down that path.
>>>>>
>>>>> But we should not fallback to qemu_shm_alloc()/MAP_SHARED|MAP_ANON if memfd is available and that allocating the memfd failed. Failing to allocate a memfd might highlight a bigger problem.
>>>>
>>>> Agreed on all.
>>>>
>>>> One more opinion from you please, if you will.
>>>>
>>>> RAM_PRIVATE is only checked in qemu_ram_alloc_internal, and only needs to be
>>>> set in
>>>>      ram_backend_memory_alloc -> ... -> qemu_ram_alloc_internal
>>>>
>>>> None of the other backends reach qemu_ram_alloc_internal.
>>>>
>>>> To be future proof, do you prefer I also set MAP_PRIVATE in the other backends,
>>>> everywhere MAP_SHARED may be set, eg:
>>>
>>> Hm, I think then we should set RAM_PRIVATE really everywhere where we'd want it and relied on !RAM_SHARED doing the right thing.
>>>
>>> Alternatively, we make our life easier and do something like
>>>
>>> /*
>>>    * This flag is only used while creating+allocating RAM, and
>>>    * prevents RAM_SHARED getting set for anonymous RAM automatically in
>>>    * some configurations.
>>>    *
>>>    * By default, not setting RAM_SHARED on anonymous RAM implies
>>>    * "private anonymous RAM"; however, in some configuration we want to
>>>    * have most of this RAM automatically be "sharable anonymous RAM",
>>>    * except for some cases that really want "private anonymous RAM".
>>>    *
>>>    * This anonymous RAM *must* be private. This flag only applies to
>>>    * "anonymous" RAM, not fd/file-backed/preallocated one.
>>>    */
>>> RAM_FORCE_ANON_PRIVATE    (1 << 13)
>>>
>>>
>>> BUT maybe an even better alternative now that we have the "aux-ram-share" parameter, could we use
>>>
>>> /*
>>>    * Auxiliary RAM that was created automatically internally, instead of
>>>    * explicitly like using memory-backend-ram or some other device on the
>>>    * QEMU cmdline.
>>>    */
>>> RAM_AUX    (1 << 13)
>>>
>>>
>>> So it will be quite clear that "aux-ram-share" only applies to RAM_AUX RAMBlocks.
>>>
>>> That actually looks quite compelling to me :)
>>
>> Agreed, RAM_AUX is a clear solution.  I would set it in these functions:
>>     qemu_ram_alloc_resizeable
>>     memory_region_init_ram_nomigrate
>>     memory_region_init_rom_nomigrate
>>     memory_region_init_rom_device_nomigrate
>>
>> and test it with aux_ram_share in qemu_ram_alloc_internal.
>>     if RAM_AUX && aux_ram_share
>>       flags |= RAM_SHARED
>>
>> However, we could just set RAM_SHARED at those same call sites:
>>     flags = current_machine->aux_ram_shared ?  RAM_SHARED : 0;
>> which is what I did in
>>     [PATCH V2 01/11] machine: alloc-anon option
>> and test RAM_SHARED in qemu_ram_alloc_internal.
>> No need for RAM_PRIVATE.
>>
>> RAM_AUX is nice because it declares intent more specifically.
>>
>> Your preference?
> 
> My preference is either using RAM_AUX to flag AUX RAM, or the inverse, RAM_NON_AUX to flag non-aux RAM, such as from memory backends and likely ivshmem.c
> 
> Peter still seems to prefer RAM_PRIVATE. So I guess it's up to you to decide ;)

I like the inverse flag RAM_NON_AUX, better name TBD.
The call sites are well defined.
That is what my V3 hack was testing (modulo ivshmem).
    object_dynamic_cast(new_block->mr->parent_obj.parent, TYPE_MEMORY_BACKEND

- Steve


