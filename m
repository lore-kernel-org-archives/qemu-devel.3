Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CEBE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 20:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRQ3-0001A4-43; Thu, 02 Jan 2025 15:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTRQ1-00019N-DJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:03:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTRPz-0007BN-4J
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:03:45 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502JXkBo022099;
 Thu, 2 Jan 2025 20:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=W6M0qZRyVtX/hcverTyViajibl/xk7KWexhhakTy0Co=; b=
 R5FSHzo3WbGv59QxYqz6n3fsubl0Mhc9kv2FkGdJ4nWL7NkqCEB0Ymc5Vd0pSTTi
 eIVAvy9WY0L15lDBYgKDFEqd/JdsUHcxId6sSoKL29bWvB16piGT0yyUg9XlLcry
 QpUV9vZZKY6TvMtXcZgI7iDwQCssCJ8AZCjPnwYxbIs6l0ptPtbpEP9FMKo3Mj36
 84oqJ8uBW1TXGWZC7DmlYCAAa1PBPqcJwIYJ79Aje4RjdhOhXmll+6s2cdmWs6zw
 uaE10XR1HA8N9ioTNSYV+ccg16BkTQyzQZMgPEPrrwET6G0akegJqoJBjfi4+SIy
 +K0tQPBKcFBPphRMBoHHbw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a74gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 20:03:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502Jl9Q4011786; Thu, 2 Jan 2025 20:03:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s91m92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 20:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTPfNtCF4e4a+OGluSnP/J7+mWWEGesxNMT+HoL7uMmrBX2Y7YtSrIaEQPHqlpDNd6rSBa4ES9Cl4lmwohkHEqPUnQh+nangnKqGlo3Fgj8zanZRK++iXVr9I/8BtmIBorHlA/Jc6bYplTL7i3ElRgNcz1wYiDbr52JW0+aKxxxPzSKSchMYXWHkt9dh+g+revK7qJxEBh+eHQSz77IRUz9NfE32ptnD48bwghXXwLIvCFmJJidL7L4vES3exUUo6w7vXj5YZDgIwB79pzaLsWw2aZe0grNHsmuk0hqWXL0hIUC9zI1ydOZ6G8OgXtVdNcUUly8yB19rvpPFTXNC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6M0qZRyVtX/hcverTyViajibl/xk7KWexhhakTy0Co=;
 b=HiyC1sCffC8g464wuOwte6AsBE3Ze1C+32+rAo7rabjB/hxu3N+e2qjoMvyeSBt8Dd6TZkkg11dmIdD7sMvBKUa9X5I4ZP2jjyhWixtsFA73tCUa98LQ1NPIDCBNXUtMMPH45/l2fa1KxDL3YtfI26diQ44XfJCLmXsNdevkL7JuBBPS8eW/IHlNv/rKSznHg1uaiywm9/+/yIjggsiDgfKGrHJF6VY4Zz5XrPxUfBf2sGg1oYhmYVzl36l9YjV8EPP2rjLytZZZLkfL5wpnOmMMD011qMFqklnzY4Z/wRGxbfUSCnwN/TemBVWWMSv12dgbxwDprwX5kmt1uxgsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6M0qZRyVtX/hcverTyViajibl/xk7KWexhhakTy0Co=;
 b=sm4ZRlEqj5vL8CmKjJf88YEFyJLy1UK8lh3dn/shVkA3pc3bnYCNVT+liXTNSvYsTtFtW7HR7IFz6jQoNBCdJziuVIUAP3m9e/izsystA518SNTcUXm1M+usIKGn3ytDCI0gpIxP9Ffl+Rg0B2zixAlmV9EENeixTF7Vnqr1qyE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 20:03:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 20:03:20 +0000
Message-ID: <80f303fb-b4d0-480a-bb4e-fd6ed67b764e@oracle.com>
Date: Thu, 2 Jan 2025 15:03:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/23] physmem: qemu_ram_alloc_from_fd extensions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-3-git-send-email-steven.sistare@oracle.com>
 <Z2rs4nYtuXfFW4sT@x1n> <afde28fb-fad5-4ba7-8c28-bf9f2a05cd1b@oracle.com>
 <Z3btlLk4YpljgS4R@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z3btlLk4YpljgS4R@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: fa876670-fcbc-42e6-6dcc-08dd2b688120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUJXTUw1TWxRL0JjZWdpQ2d4OVJTbGFPZkNvSzVSQm9nMlcxU3lpQ1A2SGt1?=
 =?utf-8?B?SHBWM1FvWGh0NWVxZWtPbldCMnFoK1RsdHV1azFTQmpVSktnc0ZyZHZFSjFQ?=
 =?utf-8?B?Sy9UQVdyZnZhWmFLa09mT3pBQnRhbnNaTm01dk1ISkh6Wk1ZUVlIa3dNdjNo?=
 =?utf-8?B?OTY1L2Y3cjY0ZkpKVW1OSjBURnJhL29CY2xDNk9GcjQ1Vi9sTmI5ZGpleEpn?=
 =?utf-8?B?aXVGUUNxZXBwZ3piZDA4cjFyMWdvbExDM09kZ2plSnZDKzZocXVYbFAxNEo3?=
 =?utf-8?B?aGxVZGhCYWJpMUZmdXZuaVkrdzFXTzhBejRyS05Zb215cnk5K0xwTFhsUEdn?=
 =?utf-8?B?TlBPZVZGdk9tRUFwUVNZNnUyMlJsWFM0b1V1VVpMU1RXcG1hWjBqdmRBODBj?=
 =?utf-8?B?VTlKN0o2akZ5YjFiUWplaUpLcWRNamUwakJZT2FxenJGNWRuVmMvRVBSNlVD?=
 =?utf-8?B?SmRrNWpSVVpJVzBOaklzMnhzdVd1N1hMclN0di9PVDFBSmY5cTVyQ1J0S3R5?=
 =?utf-8?B?bDdXNHJDeFV6eXgvVFJ0S1FwdjVyRjJORmtUZjZYRmlLem1tQnRDMmRWeFlS?=
 =?utf-8?B?a29iNkEyQTI2NkRXSzcyc1J3NFVlUHBxVjZkWmVjc2N6Ym5tcTRYZ1EwZXdU?=
 =?utf-8?B?NGxHRnN6QTJFTnRtWjVVUkR0SzRkZDV4czdIZGhSV3NYcVJvSDliMUFvbEVE?=
 =?utf-8?B?bE9VN3haQ0c1blNSSit3Z0dRZ1NMK2FJYjlSY09RdUpTMVoxNkhFeFhKaFkx?=
 =?utf-8?B?ZXp4K282eDBCTUhpZ29mWFcxb3k2NnlBeVdyNmxMTWRua3pXWjdNUkNrdGZN?=
 =?utf-8?B?QUx1bDNlU3hsVDYyWHdRbnBkQzhwRVQ1Y0dyY2d2LzM0WktDM2FjWUdSNkM3?=
 =?utf-8?B?MS9MRjFxUU8zZWxwTEVHa2wwRit1TGhKZGF4WjA2blgvemZkU2xTSUx2dVoy?=
 =?utf-8?B?MEJmM1lnb3BDWGwwTHR1Y01nZTAzV0NVTlhVU05KdHNNQ0piV2pYS21iL2Vz?=
 =?utf-8?B?SXFpZmhzcjBacm44VG1RMWwzY29nVFpyK3hhZmhPNzZVd1NrRmRyb3FqWDVr?=
 =?utf-8?B?cGFBZmMwOVdtbGJENGJ3d1hZNk16dVRidFkwRTBLSCtOcmtwZUxMREFYZS9i?=
 =?utf-8?B?T01XcTFlaThpeFFvSC94bzFBS0ViZXlwRGlJYWpFcldXZFBMSWxlSWVhamU3?=
 =?utf-8?B?TnhjRmJHSERyeWVFYkFNVUVic0QzaHZJb0lhMjJuVkEybnBmUDZkUXpkQ0gv?=
 =?utf-8?B?UlVqbXJmL0RpSE0ra3cyRGFTRkJOQVNIQU9ZRjczZENlVUhQTkNuV1B1Mit5?=
 =?utf-8?B?cU5oU3Z2YVpCZUZLdXJUbXo0eEZtYTlHRUhqazFQUHhrdnFnS0w4T1cyVm85?=
 =?utf-8?B?amJ3M3Q4NEl2NDhLdllRcEREN1IvZkFjMEwybDJUY1NVM0kzYko2cm1tT1pa?=
 =?utf-8?B?c0c0ditNS1NkckV6ZnhyNlBiYUtZT2E3a2h0OG8yNDhyazNCMTFUYUQ2QzZR?=
 =?utf-8?B?Si9VZ0s3QXE1ZzBaRXk0MGFDd0doellFaktsWldCK0VUZWlLV0tNNFFvaS9a?=
 =?utf-8?B?Y1ZUMzFzMElSeC9ubHVBK3lhanRDQUlrb3picTNwTWF1d00waUhwbXFXNzBP?=
 =?utf-8?B?a0pDOHMzL2NQV2s2akpxOE4vT1JjakRhUXJMcHlSSEU4d0FIaTNvT05IbEkv?=
 =?utf-8?B?cThMV20rdnpKNGM4cXV1cklRMXVMYmYwLzZibE9aSXNEdDhQTElJRGEzTWFK?=
 =?utf-8?B?UzNTb3k5TzArYUtrQmhkYjdwS2JOSG12N1c1TnFIWktpdVlsRmkzbWxTdGw4?=
 =?utf-8?B?TVJnb1loQWVXeDcwUVZuTXFJSkJlRklxS2ttZmNzYUxyemJ3U1lKaWtvT0dC?=
 =?utf-8?Q?DTWT5rzWqFx88?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhwejd6bDI1RmdYZHQ5Zk4vT0xseWtxVUFJeEFOWWJ3S2owVEpYYno0cmYr?=
 =?utf-8?B?TE1PYnUzMFVUREcybHBVbnpzb0UrZTkycTJwVURIVFIzWm9FbVV2VzRpZ0pV?=
 =?utf-8?B?Um9xa3ZTOEE2aFNabHNtM0F6ZTJxZkxsT2FXcEJnME83VFNZa0tDK2cyeWgv?=
 =?utf-8?B?V3NIcW5YQlp6UE5DTTNxZ0JpdXF1eDBGMnhLQkxuSEdqZ2Zmd2dQWEZMOWNK?=
 =?utf-8?B?ZTNSd2hxVmhmclEwTFgvV0M2cmlubHpLR1VzY2RxRFRVemUzWTAzRFJyUGY4?=
 =?utf-8?B?UXVha0crb3JvTVp1SXptM3hTRmMzeHNRazE0STBtUEgxdnBpUUg1bzJ1R2xv?=
 =?utf-8?B?b1hHKzZqdndqMDJwYVhXQVJzcHRxTEdZRHZMWTRrd1QvMzlaRUxPcDVWYUt4?=
 =?utf-8?B?OEJrengxQWE3V2swbXVBYTk2U2hHWElCQ3ZIblVyZzJtOCtyYXFBbnBvVFh5?=
 =?utf-8?B?VE5KZnRIQnBzT0RJUkxEZEZxeFkwVkRjWlVXejg3L2tBVEYrQkJkZzJzOThO?=
 =?utf-8?B?ODAwN2YxZ2dqTXAxTkhZb3VpRmQ3ZkZsaU5QVWlOV1c0azRhWEpFaGwwRUM1?=
 =?utf-8?B?ajdMVGJZYzc0Q1ZHSW9wV3g3cEJJYVhjYVVnQTdwdEk2cnZjQnVzUE92L0dt?=
 =?utf-8?B?Z0h4alhZQWE2NTBySVg0NGJ6YXNhMnR3MkltUzFtOTBSNVlCQ2svQ3ZDWU50?=
 =?utf-8?B?NXBoTHJQNHRLWUhrUFJqVEd1YmpjeHRqRU9SRis1L1ZPcmM1WG1RUmRIUERy?=
 =?utf-8?B?NEFHRkd6UVpTSDQ4QlcxY1RLR3BlWng2QTZ5YkUwb2pKVktHL3FrR2oxckJF?=
 =?utf-8?B?S093ZTkxbzJXUFBFTGZsTUtsc3g0L1MrR0JLR0Y2QUlzVG1SdFJvMTlWMUVM?=
 =?utf-8?B?MGF1MWdHUG1WSkxGR21vdS9UU3IrWmtiVEprY3U4aVdOekRtZFlWcFVDMjNw?=
 =?utf-8?B?a2p6R1NrRHdXTng1bHVBa3hHeUpoa0hlcUJXZFFLWFNtR0p3SGZiYTFOZkNZ?=
 =?utf-8?B?Qlg4MU8vWWRyL1prc0owRzh1YlBWQnpubG83ejQwYkxNbWRXK3hDMVkrYm5u?=
 =?utf-8?B?NjZyWEE4L3JBRm9PWXFGMkFYUEE1bkh6YjBac1hmdi82VWZmUEpjUGhhSURN?=
 =?utf-8?B?RzkzS0ZmVkhEWUo5cFM2SmJoSE5aZHREb1JmczFYKzNGV2tlNWtyaGdYZlE3?=
 =?utf-8?B?ZmdhWG9MbFQzbFEya1ZsOFg1MHlibS8wbkZPTHVycFB4azlVK2xUdDFlVWx4?=
 =?utf-8?B?cFkvWEFZQWlMZlQxSE03ZmpSMWJBeWtiYWJrSFBuc3pEQ3VPd0RDQi82M0kr?=
 =?utf-8?B?Y3FodG1icURJZTNCN0dPcVBIK3M5aG9OV2N0OFN5MWdHak1tTGlvWkFHbnF6?=
 =?utf-8?B?d1NYdzNwVFFZcEFDamJQQkhGWWMxcllPN0NaK0ZqeE5jR1JoTmlvTENadWxm?=
 =?utf-8?B?bGxLS3NLanpEcmM5OElKcmx1cFhsN1Axejk3WjJaTGw3cVpYbCtVKzRQb2xE?=
 =?utf-8?B?TVNGWTVBSWxqZnd6NGxvdlBrOUxvMTBQNEppSVpQbzArYkdUZkFzS0FFSjJj?=
 =?utf-8?B?N2YzR0NQS29CVUpNdjNSUU5Kc0ljZDR0cHFRa3R4RGVmL21aOGxSOEtOSFBK?=
 =?utf-8?B?b1E2T3F0ZzhWSTExUzdkaE5wUlhJcEY4ZE02a2tJVXhleWpick5DWE94UFcx?=
 =?utf-8?B?a0xDZUFSazI0VCs4WFdpcktmd09oK3JkQnhXeDVKa1hZNHRIWG13dG5jaU9k?=
 =?utf-8?B?RFZZcWpuY2syVDFnOGZDU004U1ZaT0Z5UEVxNS9INFhzcUZ2cDFBckxOQU5l?=
 =?utf-8?B?R0x4cGYzdE1vU2g3ZFV3WWVqQmRDNzFhdm92S0cxcWdyNlZSM1N2M2xaUFpv?=
 =?utf-8?B?a3pzS2FsVFA3QTMvc2Erc1RmZTlVTml4L3lOMGV2ckgzN3FLOXRrdFZHMXlH?=
 =?utf-8?B?UjRlVGRmeTRCc0hQQk14QWRaTVhLa3UrUDlPQkRKTldTZVlSMExoR0sweGd5?=
 =?utf-8?B?T3Y0Nk9KVndLR1dSc2VQSGFadnNEMWZxL1oyRy95c0pHOUxqcG9SdnVCTCtQ?=
 =?utf-8?B?Q05pNjBtOHVuVGJDd0FOTTN1RzVUVUdONDFUQ1R4SGU5Y2dGSzVjNWhxeHp1?=
 =?utf-8?B?c25IeDBwamh6TERLNVZuS3FXNi9ZSDg3ZFRHSzBJcHJzM20zcG92clZKRm93?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8mvURf5aK2iI634D6fCTqMyr4n6AsVH7Pt0qR2LynVg7VbLM6FqvuGZW9wyQ0Y/8N6kVrAIJ8WgPolu+v8ad2M39dMO/lNYw+5C8kiNbuwJeWYKemxsuwaANRLB4dDWtGdLKgEQDm7tmNl8B1+LGsdLxhGtdhBmU4D0MrB16EgMVwKjbX0PG7GaobmnGDjwVWyOloaUWvNxKfaSpNqrE+uUhD0XLyPrfshcIvfGI3TTY9QubUhHqvLSn0EreXoLgoLh+WpHZXoNSlOeCwl7x5J71hNfSK1ETYsghJWAn64busj10kkeauXRMYnggnCoMAjqNl+JOyZwDUNCUkW0sPayjLnhbm61+POZvZ5K8wFDk2Q4os9Mqn1h+qwxbOQI7xBgcL6igLUclTHWwUbq3UB7hVjghlar6/vX/Htfa873CRRsGrqpkBwUhCUdwmbuc/kRt6/9V1Hcdu6cyTq6YLIoyXRNDKwfh3eLRik/0q9rcpI6MwTojnLpmkDqYcF1VZf8XwSVW0uvJGxZ1WpmdISzLfOGsj4r+plGL5rmxCxQo5pSX6uwLenHQOZzV0mFMfYTtoAnGbPpRtAO+g1tTobRdt4wtoy2Os5Cfb+QENdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa876670-fcbc-42e6-6dcc-08dd2b688120
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:03:20.1450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToX93ZP7kW/hlLW1kczuDwzxOs5B3xz62aLCsQKCL89FDbXTNNvYdO+e1BDYanMW+gw/ty9LATtD2StUfz9lsZCX8zGIfGqGjSERnryeluY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020175
X-Proofpoint-GUID: 13Ki64erUWcn-r0By0g3pciE-7xWD-IP
X-Proofpoint-ORIG-GUID: 13Ki64erUWcn-r0By0g3pciE-7xWD-IP
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 1/2/2025 2:48 PM, Peter Xu wrote:
> On Thu, Jan 02, 2025 at 01:36:01PM -0500, Steven Sistare wrote:
>> On 12/24/2024 12:18 PM, Peter Xu wrote:
>>> On Tue, Dec 24, 2024 at 08:16:47AM -0800, Steve Sistare wrote:
>>>> Extend qemu_ram_alloc_from_fd to support resizable ram, and define
>>>> qemu_ram_resize_cb to clean up the API.
>>>>
>>>> Add a grow parameter to extend the file if necessary.  However, if
>>>> grow is false, a zero-sized file is always extended.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/exec/ram_addr.h | 13 +++++++++----
>>>>    system/memory.c         |  4 ++--
>>>>    system/physmem.c        | 35 ++++++++++++++++++++---------------
>>>>    3 files changed, 31 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>>>> index ff157c1..94bb3cc 100644
>>>> --- a/include/exec/ram_addr.h
>>>> +++ b/include/exec/ram_addr.h
>>>> @@ -111,23 +111,30 @@ long qemu_maxrampagesize(void);
>>>>     *
>>>>     * Parameters:
>>>>     *  @size: the size in bytes of the ram block
>>>> + *  @max_size: the maximum size of the block after resizing
>>>>     *  @mr: the memory region where the ram block is
>>>> + *  @resized: callback after calls to qemu_ram_resize
>>>>     *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>>>>     *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
>>>>     *              RAM_READONLY_FD, RAM_GUEST_MEMFD
>>>>     *  @mem_path or @fd: specify the backing file or device
>>>>     *  @offset: Offset into target file
>>>> + *  @grow: extend file if necessary (but an empty file is always extended).
>>>>     *  @errp: pointer to Error*, to store an error if it happens
>>>>     *
>>>>     * Return:
>>>>     *  On success, return a pointer to the ram block.
>>>>     *  On failure, return NULL.
>>>>     */
>>>> +typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
>>>> +
>>>>    RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>>>                                       uint32_t ram_flags, const char *mem_path,
>>>>                                       off_t offset, Error **errp);
>>>> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>>> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
>>>> +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
>>>>                                     uint32_t ram_flags, int fd, off_t offset,
>>>> +                                 bool grow,
>>>>                                     Error **errp);
>>>>    RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>>> @@ -135,9 +142,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>>>    RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
>>>>                             Error **errp);
>>>>    RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
>>>> -                                    void (*resized)(const char*,
>>>> -                                                    uint64_t length,
>>>> -                                                    void *host),
>>>> +                                    qemu_ram_resize_cb resized,
>>>>                                        MemoryRegion *mr, Error **errp);
>>>>    void qemu_ram_free(RAMBlock *block);
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index 78e17e0..290c522 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -1680,8 +1680,8 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
>>>>        mr->readonly = !!(ram_flags & RAM_READONLY);
>>>>        mr->terminates = true;
>>>>        mr->destructor = memory_region_destructor_ram;
>>>> -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
>>>> -                                           &err);
>>>> +    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
>>>> +                                           offset, false, &err);
>>>>        if (err) {
>>>>            mr->size = int128_zero();
>>>>            object_unparent(OBJECT(mr));
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index c76503a..48c544f 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -1942,8 +1942,10 @@ out_free:
>>>>    }
>>>>    #ifdef CONFIG_POSIX
>>>> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>>> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
>>>> +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
>>>>                                     uint32_t ram_flags, int fd, off_t offset,
>>>> +                                 bool grow,
>>>>                                     Error **errp)
>>>>    {
>>>>        RAMBlock *new_block;
>>>> @@ -1953,7 +1955,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>>>        /* Just support these ram flags by now. */
>>>>        assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
>>>>                              RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
>>>> -                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
>>>> +                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
>>>> +                          RAM_RESIZEABLE)) == 0);
>>>> +    assert(max_size >= size);
>>>>        if (xen_enabled()) {
>>>>            error_setg(errp, "-mem-path not supported with Xen");
>>>> @@ -1968,12 +1972,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>>>        size = TARGET_PAGE_ALIGN(size);
>>>>        size = REAL_HOST_PAGE_ALIGN(size);
>>>> +    max_size = TARGET_PAGE_ALIGN(max_size);
>>>> +    max_size = REAL_HOST_PAGE_ALIGN(max_size);
>>>>        file_size = get_file_size(fd);
>>>> -    if (file_size > offset && file_size < (offset + size)) {
>>>> +    if (file_size && file_size < offset + max_size && !grow) {
>>>
>>> Is this a bugfix for the case offset < fsize?  If so, better make it a
>>> small patch and copy stable..
>>>
>>> $ touch ramfile
>>> $ truncate -s 64M ramfile
>>> $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
>>> qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
>>>
>>> So yes, it's a bug..
>>
>> Yes, it's a bug I noticed by inspection.
>> I will split and submit to stable.
> 
> Thanks.
> 
>>
>>>>            error_setg(errp, "backing store size 0x%" PRIx64
>>>>                       " does not match 'size' option 0x" RAM_ADDR_FMT,
>>>> -                   file_size, size);
>>>> +                   file_size, max_size);
>>>>            return NULL;
>>>>        }
>>>> @@ -1988,11 +1994,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>>>        new_block = g_malloc0(sizeof(*new_block));
>>>>        new_block->mr = mr;
>>>>        new_block->used_length = size;
>>>> -    new_block->max_length = size;
>>>> +    new_block->max_length = max_size;
>>>> +    new_block->resized = resized;
>>>>        new_block->flags = ram_flags;
>>>>        new_block->guest_memfd = -1;
>>>> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>>>> -                                     errp);
>>>> +    new_block->host = file_ram_alloc(new_block, max_size, fd,
>>>> +                                     file_size < offset + max_size,
>>>
>>> Same here, looks like relevant to above.
>>
>> This line would not be part of the fix for stable.  The pre-cpr code should only
>> truncate (allocate) if !file_size.  If file_size > 0, the fixed conditional above
>> verifies that file_size is large enough.
>>
>> The fix will be a 1-liner:
>>   -    if (file_size > offset && file_size < (offset + size)) {
>>   +    if (file_size && file_size < offset + size) {
> 
> Indeed, this should work.

I will also fix the error message, which should have been updated when
the offset option was added.  With the fix and your test program,
it says:
    backing store size 0x4000000 does not match 'size' option 0x8000000

I will change it to
   backing store size 0x4000000 is too small for 'size' option 0x8000000
   plus 'offset' option 0x8000000

- Steve

