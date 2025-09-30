Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171F9CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bi1-0002dD-Dx; Tue, 30 Sep 2025 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3bhz-0002d2-HL
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:52:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3bhv-0002eV-MZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:52:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UEnbiY012247;
 Tue, 30 Sep 2025 14:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=RIXe3+4h1tycdQeue22BJv4EIFqeYv0Z4RNHDsT0pxM=; b=
 km9YQtnD+wsQpVsQ79W6RWFvtrjzUwGxYdTubQ3Mt9+AfP48dG3oVIDMm/VGxldA
 A9oj3e8Zycti/4B3gFOGPrw+3unkmyO5qmFDYTrkD0WVpjzDwxqbxNq9hi1WNq3E
 dc78+0S0LPcLj9SEGBuryAXOkujWwTzpK0384avPEIfCpwtWz90womhMCfO3+R7C
 1BM5WIBZyHAdDyTIxD8TNPiXmw8RUCevgiMQ4xWaJq3n5LzvYmCPdnzbb/1f4Fiu
 z4jnpG9wsGWokX7/yVflcSsIIJ8NHX1vaLVqSaRPCAuSi2Lm3mlw3WDoJpg7bsFV
 STd+0SyLcc8iaHS7dobLlQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gha8r04v-15
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 14:51:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UEAJGi011552; Tue, 30 Sep 2025 14:35:10 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c8e01s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 14:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKF2rYHZjZ9lnwWfcYuOe1goMaQjkk48+aAMILlayF2kbCEHpPX2hu/fZAdG258gcvRiDB5vm8vrmtZA+hY0D47jOTt2VmnoSJzVMppPqztdAfFkvcxF/2Uhe5ctD4NdBhSoxpyH646cgjzqVCXfXCMVhoI8HJjjqFtMqci5hjaG7r9biqz/JGz/VgtNMk1v0Qa8wkwe//MohmQZ2v2bHWC1QUuWrJ4YDK7GwMvgJM5SC4zGb6nDPKnYocxrazTwcUiZMhTbNJo9ko6qgq93bZ4HNnhtlTEDZpT21vzkfYYPUIUZ5BpgZ25Ux5tUoDUcd1zu4YCsyDNf5gM4p+XOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIXe3+4h1tycdQeue22BJv4EIFqeYv0Z4RNHDsT0pxM=;
 b=gqzhtQsQ5epfnvEjnPkmvez3XAV/lMCsQfTvIdn2V6/R11R1ZqxXmX7QXgq3UUYEWLbGDnAwH1nu9cGEqUIv43tIkuVqA7JwpZbuRjT8ILp1oJTxMKAa+4g7f8Y3J8cI6MOrqK9egszzBe6ItihvUvEJU6AUZoIF9cI3LRPhQGkDOLSeQNu9y91DxN1W/NY2v1wC+TQEnKxiu3gqbXqae+81bqTV/MF9PetlQfc4pamT+JFo9qfsKrz3ZJ8e2i0eRnUYctbYcgCiKMBtTs3xCY28m4S1ZjgiInHWQdHX56MgIwQ2megzDSvyVecK9TccRh9ghpSpCAUjGllCpT8JYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIXe3+4h1tycdQeue22BJv4EIFqeYv0Z4RNHDsT0pxM=;
 b=M/mmmVf8OCH6A8bHeRztkXghhV3rGGuw2VJZfabuKL2h6jGI4X8msja6cMb/igXPX++WrDEOZvmqC+scbCzFDkuEkfnb+fhF9LZsaNGSTnnw9rdDOHqRCveO/mT/ZBPj7Sth03zc0WSgaWuzVj8jtG4bOnzjnGrSdIgyRnkwiVs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BL3PR10MB6090.namprd10.prod.outlook.com (2603:10b6:208:3b6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 14:35:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:35:06 +0000
Message-ID: <0ec6a844-73c5-4790-bd5a-325b83c96768@oracle.com>
Date: Tue, 30 Sep 2025 10:35:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 09/11] migration-test: migrate_args
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
 <87ikh1uhj2.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ikh1uhj2.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BL3PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9b2882-e9d2-43a8-1ded-08de002e8ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmxWTFdpUzdsTXROVjZIYVdHRklQRTd0ZHdQUVRhTHVaTzc5R2dHdkx1TDVl?=
 =?utf-8?B?d2dSVEZiRXliTEhSK2JDUHRIOTRpRjRCb28wTkdicVJ4bytndks2MjdlUHkr?=
 =?utf-8?B?SDVPbFBpUFk4NWNZQjhGL0p0cnQ5clNxRGxkcHdLNXd4WklHci9ZVlc3eVdm?=
 =?utf-8?B?RnRRVzN0SmtmWm9wcHFmNkdHbTV0enUxZmloVlZzTmk0dldYZUF1TjRPaHRk?=
 =?utf-8?B?WHUyN0VpR0xIMWx0ZGU2d2hHQXFQUkkyZTZ2dm9ZZW1VT1VEb3l0MHE1Tk1B?=
 =?utf-8?B?bGpZUlo4VnRUejBTT3prbjB6NWcvTTZRdC9BUEt2WEovWFRTM092RXdpRFVV?=
 =?utf-8?B?emlnQXk3dFRmQlFQSGt4alhUQW5uSjlpWEhTWU9MYXlHSm42MEErU3NNcmF5?=
 =?utf-8?B?YjRCOEk0K2xvajJqSGNxdzFVeDJwbjRQMlA0L05KdVpPeTJPNSt2UDltMEdu?=
 =?utf-8?B?OCs4SkxoR0Z1bmRlbFRhWEMxNSttRExCbUtrQm1mbXN5U24zQ2VHWC9EbzdL?=
 =?utf-8?B?L0dBbDh0bTZpV3h6TCtxcjdZVjhGVGNBWnFJYWhEMzg1c01VSk00M2t4Qllo?=
 =?utf-8?B?SEVnbnZKSWNuck9qb2lqWVFiZ0VSYkt2b0doMFBKTnBRSWtmZVJNallDeHA3?=
 =?utf-8?B?cmJlTjd1clJIUUVFNVRVdjNDejZXMEVydGtibzVPMlZpV2hpMWRlNkdJSUVG?=
 =?utf-8?B?VmhyQ09aSURRL3doamUxS1hUMVA2Vk1WTk90dzNROWFJaDhDYXZ1Q0NKNDJm?=
 =?utf-8?B?K2h3bUNncU04SDRDRjcrSE5JWFNNWmV5ZmNLLy9aOXlDeWZSaVBmUDVyKzBJ?=
 =?utf-8?B?K3RmRTBJNldSUGtxbXByS2ZnT0k3S2F5RnZIczN3VHN1bDRDbXlUVWNYNG1o?=
 =?utf-8?B?NUQyenVEb1E3azBrTjNTcFc3SmZCNlBueUczcThUYUs4Rml2dXVsWHRtYzFZ?=
 =?utf-8?B?RnFsMG9pbVFlZmxLNnNiSm1iZDU1OWhXcWZ0Qm8yNE8za3I3OHo0Qk80T3hX?=
 =?utf-8?B?cFIwdzZTbS9EdXI4SWc2NEozbCtjOXVHTmNwNy9pTWVza2hvRVp5TWxJaHUy?=
 =?utf-8?B?Y0dKRmNwUm9mQkhXZUUybGV3eHJUOVZXZFluZlgzN1MyaWhSU2Z0aVNKWmJS?=
 =?utf-8?B?MEI4NHBJUjgxVDR4RWlGQko0bW5UQ0FsS2lTUXl3NFNxNXU2UFRhdXIvY2d0?=
 =?utf-8?B?Q3ZLdEhtaWFOOHlyanorNGFPQjhHaG5uQXlSUHdnR3ZZeC8vcUpUQ0ZNU2Q4?=
 =?utf-8?B?TkNkYW9aRCtsbHY5bHU0ZTNXdE5OMDErcXlFYzl2Tm5pRko1WTJDZVIyR3Zl?=
 =?utf-8?B?Y1R2OHdnWm0vSncvdmhiMTNMa3k3dlFVdWNGak1QemJUL1djRDVhZitxSVo5?=
 =?utf-8?B?T0xjN2RESnkyTFNVTGMrRjRtRC9ZTi9IM0JnM3g2Q1RJUU8xL293bEJ3d0to?=
 =?utf-8?B?RzYrdUpNOUJnYlpkdUNhVGh2UUFmT3N3MHRTVzlaSS9XRVEvYVg1ZzJGcDNQ?=
 =?utf-8?B?UkxDOUZaQjVIWW50UWZsemlFeFVsRFdLaWw4Zk5yQlp4T3BCdGxmWkZJWitF?=
 =?utf-8?B?YjQwUlYwRkZYN0ZEbFB0SHVZTkFJNnZOanpzY1NBc0hqcnJKTnZ1cHltZmNH?=
 =?utf-8?B?VkZZYkV0WUhGZnE5YlQxTmlvdHNSQ09FT3RpNm43dWhEQzhqMmJXNm9xbU1J?=
 =?utf-8?B?SXNPZEZtVjdmRzNkYWt6SW5pRlRmNWJXZjIzR0hubEphVVlwbkY4bDQwclhL?=
 =?utf-8?B?WmZmNCtyU21tZ3ZxOWdyclh5T3FMTGJwQWhWQVl2WHcyeDBheTlaRXdFS3hL?=
 =?utf-8?B?Mk5OUWZ3Nm5IajFkMmkvQ3ovV2lXT0RmVThSalRLYVVvWmpBaDVUMVhXNThh?=
 =?utf-8?B?bnJnMkV3UGUwQlkxWFNJR1Z6VE1LbkhQZjE4cDVOMWluR0Jua2JOSFlCOUlp?=
 =?utf-8?Q?g7L6kzHqUY+Zs8888GgSvUhmjnr0C1SL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWJkRXNiSzJPQjFTSW9mT1FJd3JtbThpM0I1VEgxSE1NY3h5MkRpZldRdkZ6?=
 =?utf-8?B?WkhxRlJnSHduOVY2bHM1WENpazVRUlE3aURYZ2ZKOTVSVzc5cHRHVi8zL2VZ?=
 =?utf-8?B?dlF1MU9BbEZEMGk4bWZvUmRYRmpOcXZHZVJXb2xvNWMxV0xtSWl2TmQxczVo?=
 =?utf-8?B?bGdKZDJGampWT29OZHIxdlFTYm1LMWRuV0pqcUR0SFhMNmZ0MWJKcnNkOWhz?=
 =?utf-8?B?Um5Pc1hCZW4yOEE0cWRWRlB2NWQ4R2dlOUJwR3c2SmFDZTVIbU9EbmVxYkx6?=
 =?utf-8?B?eHpEaGU4M054OHpwWjA0cVFFc2twZEE5djNWOHp0amwvR1FvcjNuUjhQeU1Z?=
 =?utf-8?B?VVFEZ3lkUW1GK28zVmtzbExBZlZ2K2RnMXE2ajdCZ2RkbUFiL2NEcXdMcTBZ?=
 =?utf-8?B?ZlErclRFdXNKWmk0b2VYczhZcUVpMlVyN04xajhScnh6a28wdndhZDVaK2k3?=
 =?utf-8?B?UGtjWE5hWXhqcnZhRzYvcDNGTkdUUGxmaS9JbFpuS1g0eXRldmtNc0t5RElD?=
 =?utf-8?B?Tmx2ZGJLTWZjMVkxRmhYWXZUNUtpWlhHbDFTeW1kOUZldUJ5M0pvV2lBa1BE?=
 =?utf-8?B?bG1WRlhVY28vVGtGd3dzbU5HdE9sb3FVaVFDZjVIbVlVSkgxUkFhVnZRU09X?=
 =?utf-8?B?U2ZJNGtCckFFcERORHVFTlV6YW1FSlIzR3VXOWJVU1NnUzBLWHZnWFNpL08x?=
 =?utf-8?B?UzgwT3dxd1pQZWJ6eXdEN1FUR0dKZG9hTkI4aG8waVV5dVBrdUFLU0xKLzBT?=
 =?utf-8?B?SnFUaVRkd3VoSWlxNENCK0VSTWxWSDB6SVNEUUpkSm0xa1VpTEdsRzBvZVg5?=
 =?utf-8?B?cU5RdXBOdVJLcU5nd0dNRklwUjluUVBNZkcwdVUvTEdLQmNpT3RTODNFREZt?=
 =?utf-8?B?S3QreUhKc3FzbldISzh3cnNvZTZmckJRTUQrdjh5T1Qxb1RHR0wzdnFiaHU1?=
 =?utf-8?B?dWltZHhIeERCQis3ek9kajZYc25tdEpsVUlZcEk5bW81WWZJOEFpaEFIOUwx?=
 =?utf-8?B?U2FPd3l1RFc5akdsQVJwOVdNT3FNbGljLy9zVW1LTkUxWDYyWU12a0tsMnhp?=
 =?utf-8?B?NkducjVkK3NoUjR1VURCbVZQWFlraHJ6bHNMRWJ2T0lvTTVweFUzZFNzUm1m?=
 =?utf-8?B?d1RNdHF2ZVpaMTZibWVnVy9ZMklWbTFYSDhzOTg4c1UvR3Y5UkhwRHhOY1JI?=
 =?utf-8?B?elEvb1BwclRzQ2xsK1hwNUxmbjQrNHlSeXd3MGtlSXk3UG5UUHVaMWYwemQr?=
 =?utf-8?B?eHBKb0k0QU9WVERNbUdIa2lPUnVYYXI5S0s1VUQrVERqKzN4Ny9ZWFl2WVU2?=
 =?utf-8?B?KzJpU2pSdkt4cUtRYWtmWVg4dDVnWWFSUVM0RFAwNFpIWTBqZmhkeGFISXlq?=
 =?utf-8?B?d3Fnc1E5Yzg2ZkdXTVRQVURWeXlTRURwU01qRnRxV200b0g1R3BidWkwcm5G?=
 =?utf-8?B?a0tBT3ZxemFUaFhWTTZ2N2FjOG1hbmc2TlZLKzk5ekZxSlpDU1UwMkpkZzFm?=
 =?utf-8?B?cEY4OW9UT1lHR0dHOUdMWEdpSTlVVkZkZTEzY3NSSEdVeXBBdjVjaEpJNGtj?=
 =?utf-8?B?dXdRbUVVSnFBS0RHNnpmSTNOUkhicEhEK1dVZFZZdEUrNXA3aGFZWkYzVnRv?=
 =?utf-8?B?V01KQzJ2QTM0ZFNDdGROVUtvenRDaGhaUDdZakEzblhvaEpQSjFyeUdLRFZn?=
 =?utf-8?B?YkFpdDBFVkFXakEwQ0MrTVlaNFkzT0o1TEdQNThQTmNaUDdqYWRiWnNBVHYw?=
 =?utf-8?B?Q013WXRaTENOTW1VU3FCMTN2Q2QwVytOdTNYMGlNaFdEazNrYVQ2RUllQmNS?=
 =?utf-8?B?czlOTmNaNlI1UjFnd0VVNGphY2FHN01tcWJneUpVSm8ybmg4aUFYdXNYTHBu?=
 =?utf-8?B?c0NKR3dIOVArQmRmZWFYRDFKb1BLdUR4TWlZY1p0RHphRzk1eTZIS1orc25q?=
 =?utf-8?B?c1RWU21LUWdUMG5IQ0J3QUZDZllxaWg0WG1mdkdtb3Q0ZW44QTJibjVVV0ZI?=
 =?utf-8?B?ekF4bm11MmlLQTFZQlN1WVc3M2tmVURFOThjMnlaeDZuSnNCMGpnV3lUaVlo?=
 =?utf-8?B?VktMckhoZ1pqN3cxbGRTNmxSWVVQK2xmaENDZDF0dThWNmV2SWlESEVYY3Jv?=
 =?utf-8?B?UkJSeWxibTUyQnZSQURpa1YzeVkvcG4rbjYxQ2xLV3pPdnpaWnp2b2RMZ0h2?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qo86n3/CHYmuXy8VhBNGMbEH7NkLljUwB5lvqRUf2q7GMKUSA0yaOKR9Edc1DiwcFTwH8bCmKagEdgXBHtASVCqFAfrwM/v6+Hevgl7FztsldRL9SU0+KRzohPf6zqkUG5sUy+BXyrEEYIjKwUQJrT4r1xaepTHLTePpC9QRruBRPxOosHoYb3zyKxLr8Ji7Cmpbg/0FkWE166wG8Zdjjpy2G3QFY0Z9LWGwhEvwVhmE4WS5yga+x+R7+PUFEVVhdYe3NkIDoE8xgvOl5oPxK5E1FZ2Bkbf51nW7YyXwj13Y3F9ybwP4cZMKEQp+x+tkIMu6vrPuf9X8sd3iCCXmKcO9PH8uRCZLPtI51QWU3rkGfUBaVAS9+bytrH+zDsjDK97THhyaXyBuA/NFbp+oaqMM3mrdg8HUAWJSRzpJfD6R/yBtVZLsFaUhscofrs+RqDWEvVz2yRZyugn+OIVpeJmFXr5isx//mlcD5sYJ4JlGpDfHkAwQhLIvEeGZ3NzY8H8/7FCn2zhzqNnrM56AZ4Qfo8pwOMTtzvOFV3cvUyEbbEmXwUVbqLtQ12s84vgG6Hldvzv1HxFwKegAF2GYZsAUtMqw23HoSe5ATXLLExA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9b2882-e9d2-43a8-1ded-08de002e8ce9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:35:06.8572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b173mYnd5GvSsPWzCiDxmQkc1IFpFEd99b/zyb7bN4q7CIO5iHK+hOvels7gJjlh0QHd9g4LcOAVjusG4PMfgNudskPPoODIsv1jaMxaiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEzMyBTYWx0ZWRfXxAgUseUYMi0k
 LgpcGWEuTxTd3gLH4EaZniltXzja190yJ/f2Vy2x/413bF2oZwMFaGLH2Tx/1CKXcpmw235Bzte
 kARnyIVTf5PFtLhO9RKVJmiAkzJwBRzB0MvB9XYpD1VlpDqPM9jks3y/ycOjn2h9npjTuyxlzv9
 Y62Enh0rXBs2KnWt8vNGrB6FyF8+6WUKzlYwBCV/CCqO6zw2CsAoUjGLtPNosko0B6HuYQbMDXy
 /nQJdTd87hFxGuLXX/9VuAZwgLm+ECyeCx7N9E7ibU50r5qHrN9zfFXRiNjX3La95tNNQhDcIWm
 UgkKl9nYQwWURfZ1bXTG6YRETANLocwvDL1jTleBw3cRhMZIT2KgYnoZ0CSUjvgDlQtohxJmCRq
 MA+51q+cP1MYeU/j+BYL5ENhR9/yuVhDOlu5uOjqWBcZq4YqW6g=
X-Proofpoint-GUID: VzjWDOlrgwNLhTtKXKP3pcnXbvNwUgzb
X-Authority-Analysis: v=2.4 cv=Ko9AGGWN c=1 sm=1 tr=0 ts=68dbee82 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=yj11p8XFjIVOT936HqcA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13622
X-Proofpoint-ORIG-GUID: VzjWDOlrgwNLhTtKXKP3pcnXbvNwUgzb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 9/29/2025 4:32 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define the subroutine migrate_args to return the arguments that are
>> used to exec the source or target qemu process.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/migration/framework.h |  2 ++
>>   tests/qtest/migration/framework.c | 64 ++++++++++++++++++++++++---------------
>>   2 files changed, 41 insertions(+), 25 deletions(-)
>>
>> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
>> index 7ff3187..51a8a7e 100644
>> --- a/tests/qtest/migration/framework.h
>> +++ b/tests/qtest/migration/framework.h
>> @@ -226,6 +226,8 @@ typedef struct {
>>   void wait_for_serial(const char *side);
>>   void migrate_prepare_for_dirty_mem(QTestState *from);
>>   void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
>> +
>> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
>>   int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>                     MigrateStart *args);
>>   void migrate_end(QTestState *from, QTestState *to, bool test_dest);
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index 8f9e359..2dfb1ee 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -258,13 +258,12 @@ static char *test_shmem_path(void)
>>       return g_strdup_printf("/dev/shm/qemu-%d", getpid());
>>   }
>>   
>> -int migrate_start(QTestState **from, QTestState **to, const char *uri,
>> -                  MigrateStart *args)
>> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>>   {
>>       /* options for source and target */
>>       g_autofree gchar *arch_opts = NULL;
>> -    g_autofree gchar *cmd_source = NULL;
>> -    g_autofree gchar *cmd_target = NULL;
>> +    gchar *cmd_source = NULL;
>> +    gchar *cmd_target = NULL;
>>       const gchar *ignore_stderr;
>>       g_autofree char *shmem_opts = NULL;
>>       g_autofree char *shmem_path = NULL;
>> @@ -273,23 +272,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>       const char *memory_size;
>>       const char *machine_alias, *machine_opts = "";
>>       g_autofree char *machine = NULL;
>> -    const char *bootpath;
>> -    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
>> +    const char *bootpath = bootfile_get();
>>       g_autofree char *memory_backend = NULL;
>>       const char *events;
>>   
>> -    if (args->use_shmem) {
>> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> -            g_test_skip("/dev/shm is not supported");
>> -            return -1;
>> -        }
>> -    }
>> -
>> -    dst_state = (QTestMigrationState) { };
>> -    src_state = (QTestMigrationState) { };
>> -    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
>> -    src_state.suspend_me = args->suspend_me;
>> -
>>       if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>           memory_size = "150M";
>>   
>> @@ -365,7 +351,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>       if (!qtest_has_machine(machine_alias)) {
>>           g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
>>           g_test_skip(msg);
>> -        return -1;
>> +        return;
>>       }
>>   
>>       machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>> @@ -386,12 +372,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>                                    shmem_opts ? shmem_opts : "",
>>                                    args->opts_source ? args->opts_source : "",
>>                                    ignore_stderr);
>> -    if (!args->only_target) {
>> -        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>> -        qtest_qmp_set_event_callback(*from,
>> -                                     migrate_watch_for_events,
>> -                                     &src_state);
>> -    }
>>   
>>       /*
>>        * If the monitor connection is deferred, enable events on the command line
>> @@ -415,6 +395,39 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>                                    shmem_opts ? shmem_opts : "",
>>                                    args->opts_target ? args->opts_target : "",
>>                                    ignore_stderr);
>> +
>> +    *from = cmd_source;
>> +    *to = cmd_target;
>> +}
>> +
>> +int migrate_start(QTestState **from, QTestState **to, const char *uri,
>> +                  MigrateStart *args)
>> +{
>> +    g_autofree gchar *cmd_source = NULL;
>> +    g_autofree gchar *cmd_target = NULL;
>> +    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
>> +
>> +    if (args->use_shmem) {
>> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> +            g_test_skip("/dev/shm is not supported");
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    dst_state = (QTestMigrationState) { };
>> +    src_state = (QTestMigrationState) { };
>> +    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
>> +    src_state.suspend_me = args->suspend_me;
> 
> I've been thinking of moving QTestState inside QTestMigrationState, so
> these variables are not loosely kept without a accompanying
> QTestState. When implementing ping-pong tests the current code got a bit
> out of hand. Also the "src_serial" problem later on would be resolved by
> a new qtms->serial.
> 
> What's stopping me at the moment is the amount of churn. If you spot a
> better solution let be know.

I had the same thought, or having QTestMigrationState and QTestState point to
each other.  Perhaps the latter would cause less churn.

Thanks very much for reviewing my patches!

- Steve

> 
>> +
>> +    migrate_args(&cmd_source, &cmd_target, uri, args);
>> +
>> +    if (!args->only_target) {
>> +        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>> +        qtest_qmp_set_event_callback(*from,
>> +                                     migrate_watch_for_events,
>> +                                     &src_state);
>> +    }
>> +
>>       if (!args->only_source) {
>>           *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
>>                                !args->defer_target_connect);
>> @@ -428,6 +441,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>        * It's valid because QEMU has already opened this file
>>        */
>>       if (args->use_shmem) {
>> +        g_autofree char *shmem_path = test_shmem_path();
>>           unlink(shmem_path);
>>       }
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>


