Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69489C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcIz-0006Qu-NA; Mon, 09 Jun 2025 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uOcIu-0006Ou-1Q
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:12:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uOcIr-00064r-8J
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:12:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593g173005992;
 Mon, 9 Jun 2025 13:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=JIpnc3DeGeNAB0YYrijb512zpP9TMTxgu4E8wsSN5Os=; b=
 oRGMddbKeJ16iyMJZozQNFmlyEd+ETK1pp2G8J7WP87AlqFH/XLSA0O2vbtbxYfj
 mD4f1yX7nNE4BbJhzMPOEPmMX85A72pHEbMKAE2p7MGZFRB1YjuOnrHEWwxvXyXo
 SqIW8R/VfwnTSE98t4xxmPuewM0dCBnfZdMNGihsXQPYcqXKte7pK/MbGA1rTzIY
 btjJIK+uQNh6xuSckEA3a+H5BCsJf0zi2eZVMhXRA8ELm8H5xhvH4lc4LJjkxoY5
 dg1XwxT3B5KoTYQaOYedqV0IdDmFEACIfijdfWeIDWfTnDJJCMEmiXZK0LNOLTMR
 thSDaIDq3SieGQ50bj6FSA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad22ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Jun 2025 13:12:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 559C49Em020697; Mon, 9 Jun 2025 13:12:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv85c5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Jun 2025 13:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAOfN4LCwWu2dwTCEQP/C6QkrkIgXFmqOnqpyXIZ90e6rVymKL6UxVnFM+4IHx1vGtdnkigb3TT9zBJYSUVogfsPt+PVud4fR79flBW5r2X1u1d5LQBrOkbLYfeGBOBAnNZ80KydiYCrxTOlcbP8iHG/YzaPtM3NeUI593crKKO0qOBJNcQ2l9qXJCp7ESYRiWDr8pmWeZBigCafpOzqhIrFzEDmTeNlD6cI3wV56byA/JevpqLKB0Ao0xN5+sXU/l7rDdCaG9+GIEV/9aXTdxtH73Ds8MCjYXhma8lselpkDFXGYLVwecql6KhQ0wV8YDlz2u4N3D9Cs/54atjwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIpnc3DeGeNAB0YYrijb512zpP9TMTxgu4E8wsSN5Os=;
 b=bxfTddrI10aqYfkekFBAOiZnQEdRsb0WFeCXwUJNA18ZKNdr2n6WZLfOzIwNAHyJ56n9SHhdfmcrE4ysLTWY2kpBmLfm6dpRGphGFo2BVYZN+/fjBJovE7ryTcedB+k7D4MRjtvsD+8RmtqLHj7fERfqldM5210dLn3tM7I0HhNB7MK4QLPpkumMHv0n1wf64deGrdl4TVCXulSIi7SgqU1Cp2d5vIJ4lA3HQQ0GgzkuniPhe15CHzBu/haZA88NpT0qTlQXc5fRR1PaNibVmp1kcK+ONTpDChgWDR+qsI+u7cwh9an5QVcZOHjKxJWZmkEfixVREI6y6H7jDkWgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIpnc3DeGeNAB0YYrijb512zpP9TMTxgu4E8wsSN5Os=;
 b=NR73wnyo7b2QA++x/IIYsdjljA7HXuU+qhnN63WUl5GAwKhn6NqdVt87/jgo6pwVsdwNnEA15PaABlCKq4OeqtkjYOfYZvNKijg51xAvmm7ru+J7aGbiIH4HBA5EGgZtJ0Eo3k2b+r0XamAbVrJ5TH7OY+qg64lXrbidH+dcSA0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4766.namprd10.prod.outlook.com (2603:10b6:a03:2ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Mon, 9 Jun
 2025 13:12:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 13:12:32 +0000
Message-ID: <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
Date: Mon, 9 Jun 2025 09:12:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
 <aEaWC_Lc6c1g821f@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aEaWC_Lc6c1g821f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c03a667-80bb-49f1-cc61-08dda7574ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UldCTzJSdjJBNm9EM2RpRzdIamhaRmRQaERxKy9EWG55T3FBQ1piQ2hET0ZL?=
 =?utf-8?B?blJxajNTRUg1NDhDOGJwc2pqTXkvM3RUTjRsY2kwaFR3NVNkMGNwb1NFR1ll?=
 =?utf-8?B?RDNhL3NETzhoVlhieWJVcTlwTnlvOFV0aDhIWEpPdjAvNmtiNEZsbjVHZUhm?=
 =?utf-8?B?c0c4MFMyZ0RtekxWdW9Gc1Vzc2t1K3BjSGFibnFFNnJqbTF2SlRBK1BHM1FH?=
 =?utf-8?B?dGVwdjJmY1Mvbnl1NEg0eWc4TDlUckZCUG1pSDExUTE0ZHZIY0VWZ1U4bE1m?=
 =?utf-8?B?aVB6QVdpS2poQkZuSGs1Slk4L1dHT1o5YWdrRE8yRkJHK1k2YXRtRXFRc29Q?=
 =?utf-8?B?UW93cWhHM1haM2lzOEZOZStaMmVIMEhYbm5TK2dLSk03Tm9lc0tsaUdzZnRL?=
 =?utf-8?B?SDdkVW1kTlhHTXhsQlB0ZEcwVDZOODFOTklMRGZFWC9HQkZXZTdQRVh4VE0r?=
 =?utf-8?B?QXZ2aCtIc1I0aEtLZjRacGFiZXJRQ1ErZXlleEE3eUF3MGdaaVJXWmJOcEEr?=
 =?utf-8?B?dkZXejJhV09WL0M5cDJ1aDc2cEZoQVNadzQzemtYU3IvUXpWK0ZZd3VtZmpr?=
 =?utf-8?B?RVpiYVR6OWJ0Y0RzZmpqeXFHMmZyb0tPK3NLUHREY3VWbDlLY2taMDBVa1VL?=
 =?utf-8?B?OG01WnoxRU8yS0dZK3hoYUxFaHYwUkNuQmJpMm5JVG5ydHR1WEZ6aEtNbW1h?=
 =?utf-8?B?VEdwM2htNFBsTHBpNUh1a0lGRllGUi9mOXNRZWxHNGdrMERvSEh3QzRhUnM4?=
 =?utf-8?B?ZnhCOHg4Ny9jVEtuYTNLR0lIOXM1ZFdidGJpaERGdVkwY0dJRVJuQmpUVUE5?=
 =?utf-8?B?b0pxMUZCbW8vU3hyd0U3RzhOdXA5V0t6Q29mTHhhZDhRUG56MnlKQlRPRkFK?=
 =?utf-8?B?OHVsZDZWUTE1S0Q3anRCSzk1bGp3VzFqU05vbktRYzdFSGRLS1FyNnp5dGh1?=
 =?utf-8?B?cHV4b056ZldwR1FwVVl1M3ZiMGViN1hUc0RNVGZDSUNPZHcyL0x1cEpkYVVi?=
 =?utf-8?B?ejBwUzhsZ002d01LR3pyM1ZCdk5HQUV3eWVNb1gyMktuMDBkSmtaNE1nVU0x?=
 =?utf-8?B?WmtRdDBaVUtNMlNidXNOTGRRMzRqNnhYbVluTS95ejd6MDBUeW5tb1BVb0Vr?=
 =?utf-8?B?WXg1MWx6SDdESENDZWhoVFp5WGZybk5ZeGZ1Qm1pS0RuZ1pBM2RGdGZzZGZu?=
 =?utf-8?B?eFA1bVNpdm1nSldjQW5lSjd0Uk83UGFiMnpjOXVlNkxYNG52SzJZUTlPcmlZ?=
 =?utf-8?B?VHk1MkJ5UjdsSTQxdUFNU3BxUjdqbG96N2lDOEJGSUtHbVJ0cC9YdkE3SmxJ?=
 =?utf-8?B?RVpEdThzdnpEUC8ycllsbFZIaDE2ckhBODNpUkFQRDdaS3RYRWJ4MUtsR25j?=
 =?utf-8?B?Uk5xNUNLSUhIZkgvbU56WmpJb0F1MksxMC8xTi9xMHRNZnUrbTZGQktjVWZs?=
 =?utf-8?B?VHplaFhSOW9PU2JaZWFyNVlnUjh3WWdtVDhKWEs1SDNEbCsxa0g5ZVlvSTJK?=
 =?utf-8?B?R1FYRTEwOEF1UjhpWHRXdDNYbVFkVGNXYm9ldmZBZCtQdnMvcEduajE2NlNO?=
 =?utf-8?B?bldFcmRHa1pjSEpjYmo3WFBNRTVVcWxIYUppVDYrRGJTV2hBbjlSVERRcnpo?=
 =?utf-8?B?eUtjaUJ1SXNiQWwxV3JKVVpmdzlELzZNY0NrdVhqdG53ZWlXa1JUVGlqQ0ZR?=
 =?utf-8?B?TUxWZ3Z5c0pOYmU4TGJVbzY2N0hBa3R4SGJ3MzlNYVhYWHJha0V6MHhZMnlO?=
 =?utf-8?B?c3JlQzJPZURHYXI5RmZJWWRoQTlwQjZwZ0ZjRjlOODRsZTFLUjI2M2Nmai9K?=
 =?utf-8?B?MG1QQVN4Mm40SUIvWGJSbGd1RHc3MjJ2L1NrZnJMOVNLU1V1RENDLzVWR3ZV?=
 =?utf-8?B?b0FwU1U1dWxxOVVCQ0VZRXo0RksxOVpXMFhjNEUxK3ZpWnRCTnRNa1ZuOTZy?=
 =?utf-8?Q?D8XmUXLVHVI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJTZzJRcWFWQU5xMGlUMEd0Mi9UK1YxbFhlQ3BlK0o0eXBKNHVnVXVVVDNH?=
 =?utf-8?B?Qkk2SE1GbHFPbTJiaTBmRGw3WFc0TWR5Ull1ZGNQanYyWXVXYmtSRVNUQ01z?=
 =?utf-8?B?cXU0b2Y1WC9pbmZEcldYSFF0R3lRbVM5ejJzYm1aUDNCTG5rTmFWcnk0bVli?=
 =?utf-8?B?a0JxYWtZQXkrUDEreEVUbUlKbDNQMExPLzZ1OTBydUVlNFJHQXYyUTJSYnN2?=
 =?utf-8?B?RldzZDRHcW0vcmMyMnVKOVVNYnRrTHBKamdFZWVKRmh6dWxwSnIxbGdYQ3gr?=
 =?utf-8?B?SndFTmlvTm5qUHhuQnVIRVA4d0kxdjd0NzZCd3NBanhuaDYxcHZ5dGZJWEtC?=
 =?utf-8?B?TnN5UUJ1MWNmNjdxaDNCRnVoY28rb1hEY3dpNUhFVjJIaFFuWHhaZkZBQW5K?=
 =?utf-8?B?Mk92RmhDY2dPSEFoM2F2bnVjVk1rQzU2RnVFbzhqODFBZzdVVEdRdURndmp5?=
 =?utf-8?B?eGx1WnJoSGppM0UzRE80L2tiMlM4VHhZVitXMitqNVdYYlhrRy9HTWx5MUFa?=
 =?utf-8?B?a0M2WjczYUFyUnV3d2RTcjVBalNxbThXelJVb1Vwd1pMWXVUNTZoYVRWSjJG?=
 =?utf-8?B?Y05HU0VTRG1iVGhnYllHUzNEZDdieHhkODNSWVR1Y040R3JGdkZ1S2t2b2Ju?=
 =?utf-8?B?bHBLMktWVDRMZEFxOVVTWGJuTlpuOElGbVVOMzBTR2NCWjBvcE9iVElHQXlC?=
 =?utf-8?B?cGc5M2dubUVZQWo0UUI0Sk9mLytkbExUYlhoK0VLMzVGaUs2MWVUZDNQM3NI?=
 =?utf-8?B?V0tudTZ2V29pTkVXSU51c0RyN1ZuNVB6TUt0Ull5aFhOc2wwM3dJdlZBUElZ?=
 =?utf-8?B?RzdaS25mSCtIUEtsUS9HajZ6QXdIamdtM3FNSFVvZVFpdVVjSStUeEV5S1Yx?=
 =?utf-8?B?TVBjN0UyUmt3aGwvOGk5UEtIYlJhbERRUVBxU3k1K1M1clY3Y2U4d0dKcUVQ?=
 =?utf-8?B?ZjFLOE9YZG41RHB1RmpSUCtmdEhNbndGWWhXdVNaUGhMMFdsWjVwMmEyWXFB?=
 =?utf-8?B?bDdGak9taU9nNEFqbnYxdW5sdS9JRDh2ZkJVN21KNUtBNzQ2QXJkQUhTNUlJ?=
 =?utf-8?B?aGdQbHVGSHRYMFRNTkFOSDNaM0ozdURLSGwya05SNzlYQnN4M0NqdXIxaFBQ?=
 =?utf-8?B?OVh3VDY0enBEMXNsWFBXN04zMGFlaC9wNDYyejFySU1XZHF6bzlwM2xqMWxW?=
 =?utf-8?B?clpzVy9mS3ROODUwZEJsc2cxL2phQ3Jycm9KZUUrMzQwcUtTcmU1Z29Ba0h3?=
 =?utf-8?B?VXkwYW9pZ3RvZGhoRkNBVjhjOUZpeEZKUVZ6R0IvWktWMjY0ZDQ5YWVPcm1Q?=
 =?utf-8?B?aTFhU3ZQamZ5RmlmeTBvN1JCQk5wUmpVS01sRkhXZ1NOcTNidUp5Y1FqMXZO?=
 =?utf-8?B?blBieWtHT1orTFNkd2hKU2Y4bVZDRUJwc3RMektmOGp3YjdkSWdOMHFpL2d0?=
 =?utf-8?B?eXM4QmlkcXJFZGpIOCtIOEQ4TFNaV0ViZ1NIYXVaci9mYnNRWW4xQVVHUXk4?=
 =?utf-8?B?L3ltMml3bm8vWUVyWkZ3eHJJNzBBcVNJNDQyZytSQUJuaExmL0hvTCt6Y3E0?=
 =?utf-8?B?ZjZzbEpERzZ1SjZqb1R3MlluZE9GYXNZbHNKOVQxK2RMS2NuVWFFZjMxMi9q?=
 =?utf-8?B?ekdGb1c2NS9kb2pFOFdQNExnMWhCZUo2ZnFUQ0UyTS9qeElDdzdreVppNGJC?=
 =?utf-8?B?c1o0NE93bHJwNWVpVkVTazlHZG1Ga0tXZFNxajUwREJXbEFkclFZRENJcGRJ?=
 =?utf-8?B?aHVnOExEcC9ucEVadVhsV1ZXdys5dkpRZ2h2U2FGaTIvamdWVy9oWXliZi9K?=
 =?utf-8?B?VUNycTJSQVNJaDFlMENDZnkwOEFzZEMvMkNveW1xbzY0UHBINFFWRDlGYzBh?=
 =?utf-8?B?U1RSc2wrblVtNlRqZDV2MHZKSHhWMktpL0l2cC9rTDkzMVRYMkhscXVZdHNn?=
 =?utf-8?B?aVYwRDV2Qml1anoya04rRzZkaXJzYmtxbE9DRjBKSndJeGl6UTVEZTM4T1FI?=
 =?utf-8?B?UUFZRk93RitzOEtyVkwxNDBLVFZXNE5hZzlwVGErQzMvVXZBNjFwVktRY2Jr?=
 =?utf-8?B?eVlOdFhqVERXOWdrVnBiRFBMMVpMSzJ1MmRib1RZaERHRXJ0emZtV20zTlcr?=
 =?utf-8?B?R1o0S2lOODhHaEVuSzRoQlhyRzhaUkl3N1N2Ti91RzRqZStlbTBuL3NnMDhW?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G6/z5yF81aTBlKXWMGxEpyqgsHEdJMo/NKZq/tAuN4/UT5OrPoWf1sUc8bqNwRHVnTN2YuBQDDPo4yL4iyX1EW/0uzO3Sj2OrFd5hbcKIMy+ihtG6L2xdMpqIrx4FaWqiIAADM/LuJgvTtcfCu9ZiRcLUgKMq2RSg20vVLHSd9ARtepH5y2+4ok0DUJq81cC9QiE21JQmwNdr1yw4n9aaL/qa6oMtq9c44cRSCGO+vHJ9TkLIZK+9pO7ICRPXnv34WIUcmykd2uhHZG6VID2/kguLRWZTTmIXMVNk5cAKKxdWrn1iLMqrpgKKl4q6mHacMY9bFKn1uq4kbYuizDK0UxEv5wUOX4wC8jZtx3MykKuHmyfJaRMcZhkh5BpOEQdNApY6tJ+qQxE5ghgJbciBRvnDZldPtGIZsxI29/ktd192rTrCVcGAp3r8djZX09OTPt2BcRMessAxEq8N1fUnbR75dvqXXLnbLnCwTQL4C+WMpIP1SBggjBBc1P6CTzomZyJa2BBc8ZRoiwBSHegnwN/skIm0DLR0NJ78XaWLrw2HTUPjvlGPkhPalerVfa7WJXSm1pEYD3ZPbghRnHvGobTN0YhmgJNO8g3erLODQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03a667-80bb-49f1-cc61-08dda7574ad6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 13:12:31.8895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RRnLFYmMufJWCj0wqY/kmTwZ1QpD0F2Q/DTgASHMSEdeJJWPTHz2Tb2y5LF3EGdEb3Fzl+XJUm0WkiTKyEptPpi2UzNyE60gQTN1ISas5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090096
X-Proofpoint-ORIG-GUID: c92kSIFZPQGZNtqeMgJ-WEWZbKuf9Ebh
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=6846ddc4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=30cimH9egXG5ACOZwugA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA5NiBTYWx0ZWRfX6nHLesnp57ne
 zbMDMxkDuhZ/pj5NmHSsCKu0VNbxiPfvTtRpsw5kvmz9e2bJ3yFSEShry8WGu74fzEF8bFosgze
 HMTRX9jEUwp6KKquG49lvhrcCyPsAcuF9UrYA+JUVMI72E0Yny8tzH3mH6O2wZXcR4mjbmC/H8k
 JNGnlBFHzLtNCmLguE0eChxzxum4lQaDS1FtBf0duTAhOz4HCsO0Je58fv/g8imAQYCY4IrjiJ4
 KWy6Jj1qe0Zi3+ol3L+Y020opwNDY9LLh+bY33gD5zpDHeb/6SxWuNIjt+A4Nf2Ay0jlu+Q8z+q
 K5lWRU7nlXm38+1gk0gOVeaOXZctV+gn3Y/7PNM4qcO51f2IFr7bcZX7LXo5KNC1jM92xsUTg39
 lGeRP0IBYF2UHiQz7vxaukO4sD1WP+YXOHJoVT+2W0usD7xFivOtYLMhEEzsifAwa4VC37TP
X-Proofpoint-GUID: c92kSIFZPQGZNtqeMgJ-WEWZbKuf9Ebh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
> On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
>> On 6/6/2025 2:06 PM, JAEHOON KIM wrote:
>>> On 6/6/2025 12:04 PM, Steven Sistare wrote:
>>>> On 6/6/2025 12:06 PM, Daniel P. Berrangé wrote:
>>>>> On Fri, Jun 06, 2025 at 11:50:10AM -0400, Steven Sistare wrote:
>>>>>> On 6/6/2025 11:43 AM, Daniel P. Berrangé wrote:
>>>>>>> On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
>>>>>>>> On 6/6/2025 10:12 AM, Steven Sistare wrote:
>>>>>>>>> On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
>>>>>>>>>> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>>>>>>>>>>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>>>>>>>>>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>>>>>>>>>>> When the source VM attempts to connect to the destination VM's Unix
>>>>>>>>>>>>> domain socket(cpr.sock) during CPR transfer, the socket
>>>>>>>>>>>>> file might not
>>>>>>>>>>>>> yet be exist if the destination side hasn't completed the bind
>>>>>>>>>>>>> operation. This can lead to connection failures when
>>>>>>>>>>>>> running tests with
>>>>>>>>>>>>> the qtest framework.
>>>>>>>>>>>>
>>>>>>>>>>>> This sounds like a flawed test impl to me - whatever is initiating
>>>>>>>>>>>> the cpr operation on the source has done so prematurely - it should
>>>>>>>>>>>> ensure the dest is ready before starting the operation.
>>>>>>>>>>>>
>>>>>>>>>>>>> To address this, add cpr_validate_socket_path(), which wait for the
>>>>>>>>>>>>> socket file to appear. This avoids intermittent qtest
>>>>>>>>>>>>> failures caused by
>>>>>>>>>>>>> early connection attempts.
>>>>>>>>>>>>
>>>>>>>>>>>> IMHO it is dubious to special case cpr in this way.
>>>>>>>>>>>
>>>>>>>>>>> I agree with Daniel, and unfortunately it is not just a test issue;
>>>>>>>>>>> every management framework that supports cpr-transfer must add logic to
>>>>>>>>>>> wait for the cpr socket to appear in the target before proceeding.
>>>>>>>>>>>
>>>>>>>>>>> This is analogous to waiting for the monitor socket to appear before
>>>>>>>>>>> connecting to it.
>>>>>>>>>>>
>>>>>>>>>>> - Steve
>>>>>>>>>>
>>>>>>>>>> Thank you very much for your valuable review and feedback.
>>>>>>>>>>
>>>>>>>>>> Just to clarify, the added cpr_validate_socket_path() function is
>>>>>>>>>> not limited to the test framework.
>>>>>>>>>> It is part of the actual CPR implementation and is intended to
>>>>>>>>>> ensure correct behavior in all cases, including outside of tests.
>>>>>>>>>>
>>>>>>>>>> I mentioned the qtest failure simply as an example where this issue
>>>>>>>>>> became apparent.
>>>>>>>>>
>>>>>>>>> Yes, I understand that you understand :)
>>>>>>>>> Are you willing to move your fix to the qtest?
>>>>>>>>>
>>>>>>>>> - Steve
>>>>>>>>
>>>>>>>> Thank you for your question and feedback.
>>>>>>>>
>>>>>>>> I agree that the issue could be addressed within the qtest framework to
>>>>>>>> improve stability.
>>>>>>>>
>>>>>>>> However, this socket readiness check is a fundamental part of CPR transfer
>>>>>>>> process,
>>>>>>>> and I believe that incorporating cpr_validate_socket_path() directly into
>>>>>>>> the CPR implementation helps ensure more reliable behavior
>>>>>>>> across all environments - not only during testing.
>>>>>>>>
>>>>>>>> Just from my perspective, adding this logic to the CPR code does not
>>>>>>>> introduce significant overhead or side effects.
>>>>>>>> I would appreciate if you could share more details about your concerns, so I
>>>>>>>> can better address them.
>>>>>>>
>>>>>>> Requiring a busy wait like this is a sign of a design problem.
>>>>>>>
>>>>>>> There needs to be a way to setup the incoming socket listener
>>>>>>> without resorting to busy waiting - that's showing a lack of
>>>>>>> synchronization.
>>>>>>
>>>>>> How is this a design problem?  If I start a program that creates a listening unix
>>>>>> domain socket, I cannot attempt to connect to it until the socket is created and
>>>>>> listening. Clients face the same issue when starting qemu and connecting to the
>>>>>> monitor socket.
>>>>>
>>>>> Yes, the monitor has the same conceptual problem, and this caused problems
>>>>> for libvirt starting QEMU for many years.
>>>>>
>>>>> With the busy wait you risk looping forever if the child (target) QEMU
>>>>> already exited for some reason without ever creating the socket. You
>>>>> can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>>>> for -ERSCH, but this only works if you know the pid involved.
>>>>>
>>>>> One option is to use 'daemonize' such that when the parent sees the initial
>>>>> QEMU process leader exit, the parent has a guarantee that the daemonized
>>>>> QEMU already has the UNIX listener open, and any failure indicates QEMU
>>>>> already quit.
>>>>>
>>>>> The other option is to use FD passing such that QEMU is not responsible
>>>>> for opening the listener socket - it gets passed a pre-opened listener
>>>>> FD, so the parent has a guarantee it can successfull connect immediately
>>>>> and any failure indicates QEMU already quit.
>>>>>
>>>>> For the tests, passing a pre-opened UNIX socket FD could work, but I'm
>>>>> still curious why this is only a problem for the CPR tests, and not
>>>>> the other migration tests which don't use 'defer'. What has made CPR
>>>>> special to expose a race ?
>>>>
>>>> For normal migration, target qemu listens on the migration socket, then listens
>>>> on the monitor.  After the client connects to the monitor (waiting for it to appear
>>>> as needed), them the migration socket already exists.
>>>>
>>>> For cpr, target qemu creates the cpr socket and listens before the monitor is
>>>> started, which is necessary because cpr state is needed before backends or
>>>> devices are created.
>>>>
>>>> A few months back I sent a series to start the monitor first (I think I called
>>>> it the precreate phase), but it was derailed over discussions about allowing
>>>> qemu to start with no arguments and be configured exclusively via the monitor.
>>>>
>>>> - Steve
>>>
>>> Thank you for sharing your thoughts.
>>>
>>> I agree that busy waiting is not ideal.
>>> However, considering the timing of when target QEMU creates and begins listening on the socket,
>>> I think there is currently no reliable way for the host to check the socket's listening state.
>>> This also implies that FD passing is not a viable option in this case.
>>>
>>> As for the 'defer' option in qtest,
>>> it doesn't cause race-condition issues because the target enters the listening state during the option processing.
>>>
>>> Of course, to address this issue,
>>> I could create a wait_for_socket() function similar to wait_for_serial() in qtest framework.
>>> Since the socket might already be created, I cannot simply wait for the file to appear using file system notification APIs like inotify,
>>> so busy-waiting would still be necessary.
>>>
>>> I would appreciate hearing any further thoughts you might have on this.
>>
>> The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
>> with this addition from Daniel:
>>
>>    "With the busy wait you risk looping forever if the child (target) QEMU
>>    already exited for some reason without ever creating the socket. You
>>    can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>    for -ERSCH, but this only works if you know the pid involved."
>>
>> Daniel also suggested:
>>    "For the tests, passing a pre-opened UNIX socket FD could work"
>>
>> Note we can not use any of the standard chardev options to specify such a socket,
>> because the cpr socket is created before chardevs are created.
>>
>> Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
>> { 'union': 'MigrationAddress',
>>    'base': { 'transport' : 'MigrationAddressType'},
>>    'discriminator': 'transport',
>>    'data': {
>>      'socket': 'SocketAddress',
>>      'exec': 'MigrationExecCommand',
>>      'rdma': 'InetSocketAddress',
>>      'file': 'FileMigrationArgs',
>>      'fd':   'FdMigrationArgs' } }           <-- add this
>>
>> That would be useful for all clients, but this is asking a lot from you,
>> when you are just trying to fix the tests.
> 
> Note, 'SocketAddress' already has an option for declaring a FD that
> represents a socket.

Yes, but if I understand, you proposed passing an fd that represents a
pre-listened socket, which requires target qemu to accept() first.  The
existing FdSocketAddress is ready to read.  We could add a boolean to enable
the new behavior.

Or maybe this is better, no new interfaces required:  qtest creates a
socketpair(AF_UNIX), sends GetFd to old qemu with the writer fd, and
specifies the reader fd in FdSocketAddress during the fork/exec of target qemu.

- Steve


