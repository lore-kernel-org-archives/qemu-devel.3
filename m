Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB9C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0Vp-0005yd-5q; Wed, 02 Jul 2025 12:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX0Vn-0005yS-Ep
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:40:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX0Vj-00084V-5s
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:40:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562GBi4M031109;
 Wed, 2 Jul 2025 16:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7kLJaaMCqjD37C5SMVGbahWy0P0z5NKGr/t1P8JRDS8=; b=
 l10F6EprbIcS+w2LnvUnk2WyYnXH7sjd6cBb8Bgx6gXdjprCCADamWjnL4d3xA2M
 6KU4P/Peb4XQgyTIBZoX9CX0CYudKq0Eni+ojB7XV1Zk6To6SiL5RszhlyWp6Zka
 zxg4U9jDYadJHsI8FgYzPKM7KSI5g2EjZxt5PgIuD38RyOXPB5MOGAPNZF63L/ZM
 uAoDLpeD46wpo9m3t2QbNoDl3wcIcA3Ow3rfc7KS0Ntu/nnJPPv2w/cq33c8ixFn
 WXF0kB2DVQfGBKLEedZ3AfW0jsIb7RDNXst0h1Nih+JjAXIdetjITLef9dPWAxvy
 IW8IQ4qrmjWmaCIWfw1OVw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx7anw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 16:40:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562Fe2gc019242; Wed, 2 Jul 2025 16:40:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1g7uye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 16:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTaXKOU43zfV33fCmtZepCg/uVIhcTuvaXq8O47nctscb6O32qmBK11wH5wxLkNd+WgDvN5ECz8k4ZliGyivNwnclDzsNWYCQT680QBa4yaDcyWBj5q3oDW5ujHr4B1QNSyM1sUOuQUHaygLuNp0oqaIyj33+AYdPTo8FvCQm3r3vQQvQpy3GdjOq2syZ7wJHw8Ancmi0vVl+5MHxhvB5t3TMaPRE+VoTsGz4WtEMh7dmPHTxGXdE1Xm+ViaJRoSZv1Fv3tnvybMef52p8LD6D5QbTp8qE7lLZw4o94YbSqnFoRH+MTyGOHrOBhO3jDon1CPOPjYfCAuu/9B1WiU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kLJaaMCqjD37C5SMVGbahWy0P0z5NKGr/t1P8JRDS8=;
 b=pd6+z0qP5D4rYvTv7u2mZ1L91LwCYTYqcRBgP8YzRWJ5EBQS9puaMgw55nLzxdr5QaK46lG2YR7mlAJqRFxFoZfcfgWZuaC4qOFyP4TRb4QHiu69KvoIDMbu9bYARvYu6wI1JXyv7Ce5SDNUKmkjeGWDO4Wey6Lu8vZ9FHC8DnYGR7bvu/EfnRzo5m0dXxESmGDVip0jSGYKVdYVvccMVMGqbRo0qBE0iRcV7xwiPuwYw3iHkMnJPjOKYPn6AeYhx+8hCHFeuco99LIdowzeC8MX7ZZ1BEfXu4iFKb78g4Adx9If56inBB/tmdz9XxHPmCwTUBW522Fyz5oRK1ECfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kLJaaMCqjD37C5SMVGbahWy0P0z5NKGr/t1P8JRDS8=;
 b=z7f/7ZKdCmZ25hcr5reN+2ggXy0Hy6OQgwLrWLM7lJO3pxsOiNyW6IXhb+3J7p1i7kRKiRo9Yg/CMPTLH7lK/ltZRNuP8Bfsz6+nihzUTx6z4v9L/gdgZToV97Tjm216AHXt/Dkh6FXCKuoCxJOM0oKqT023JqwVYARv+yRgFTQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 2 Jul
 2025 16:40:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 16:40:29 +0000
Message-ID: <06b37c3b-125d-4bb3-96c9-ed6da694820c@oracle.com>
Date: Wed, 2 Jul 2025 12:40:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 18/38] vfio-pci: preserve MSI
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
 <131c53a1-ab58-460f-a47c-facfc256a7bb@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <131c53a1-ab58-460f-a47c-facfc256a7bb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH3PEPF0000409F.namprd05.prod.outlook.com
 (2603:10b6:518:1::4f) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a96761b-36f3-422f-6541-08ddb987279b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d21ud3B6d0c3NTB2SW9pcGJ3WERoNXZKZ3lTWlhQZXVqNmwyM2ZZVVBSbkU5?=
 =?utf-8?B?VG9zNENBMlBZK0dSNmFxdThWbzBoVnNQVmZTOEwxSllSdzFyVjZtRmxRcFk4?=
 =?utf-8?B?ODdUSEdIYk50Y2NLZTFhcFRUMkprOS9yNHBsOTdUK0ZNK3VnZEx5MmpZUlEw?=
 =?utf-8?B?WmNZdno4N2VWTnk4UDN4b2wvRXJmZkE4TDN2ektHaVplSk8zd3BYOUJCcXBj?=
 =?utf-8?B?ang5a0VPVWovYXQ1MTNHVVZFL1VMTUZzWnRtZ0VlcEdlbG1UVE9Sa1pFdjVI?=
 =?utf-8?B?MGMrb2xtMDhuOEljV05NMGtMNnJZQi9Nb2o3bTBWSVYwbi9FbWYxdDVRb1Vr?=
 =?utf-8?B?d0ExVUpucEswZDlXV0FUTWtjU1RRUlAwY2kvRVA0SEV2N2crejZuajNrL1VF?=
 =?utf-8?B?NlE0K1R5WUpUWC8wSXk0eTd4dk43TFJDQ29vdnJvVjNJL2N0a1ZNRlozdDJL?=
 =?utf-8?B?NFd6Sm1aR2lZZWl0N09sdnIrYmFGemRrZytJeUdoQjZKRENxdTJGKzBBckNw?=
 =?utf-8?B?RW9TZ01tcmJQekpCQlV4UzZ3S2tHVEVjSE04akU4L1BPNG5Idi8wNDlhWk5a?=
 =?utf-8?B?Zk1MZEp3QklNQmVHZk5uTnBWbkJxSGljSGZyMnJwRWxMMnhxWFhpNlQxUTZa?=
 =?utf-8?B?cnkzcFRlcmQwY3l2dnFDRzRFdFRPUXFvZnRVNDg2M3FnaHQ0eVlpTUtTaXRG?=
 =?utf-8?B?dzJ2S3NwUlZGNHo1RjRXQWlaNTNzc2V1ckNWeDY0Tzd3VC9QMWhlYmQxZnY0?=
 =?utf-8?B?M0lnNW9Fa2NpVFRRa3p4bXM3aFh3SHc4ZG42clRUbzJNL3IxTUlMSm1mbUd6?=
 =?utf-8?B?NXM2ZkJvS0JNOExTMVVUKytXOE5EYUQ0N2RtYlFaQ0p1bDVVUmU3L25SdU1w?=
 =?utf-8?B?WGt5N0w3SEo5UXBIVUNqZk5oNnFXbWF3WjhPUnNXcTVvY3ptRGZhbEhadlFK?=
 =?utf-8?B?aUpqTERyaVQwR3QwU1hHNTZYMTBLS0ZBanBUQmZsSy8yVFZYSWFMaWRqVGJB?=
 =?utf-8?B?Q1lCbWxMTUdlU2tTSzVZSndCNWpFRGh1MXNZeERiSnY2RnBOQ0tMOFNQT1Y3?=
 =?utf-8?B?V1UvdXRxTStZdlFYQlp5aXgweDA4YmlCUXl5V2FLZ2tRaWdqczN0Q1VvR293?=
 =?utf-8?B?WFk1bGphTzdWVzY3cENPZ2hPU2ZjMlZ0aUVaeDNkMHAvdTR5QzBCNFVmSldI?=
 =?utf-8?B?SDBCb3Y2NXcrL3A1ZWgvaWYyVnQ3d1Uxay9McnExNERQZEtEbTJLOVVqYlhU?=
 =?utf-8?B?OWcvWmx1NzZpcU8zNkdMN2ZpWk1XTGtaMFg4TDNYMDJXR09NQkVLMW5LbDlQ?=
 =?utf-8?B?TVNaS1hmL0IzQ0FjN2VXMnlzazJ6Mk1CamdWaFRFR0ZKcEpuOTlyb1JMMlE4?=
 =?utf-8?B?VlQyMDNMdmxNV2JYdisxREZmRjZFQURmZWUvZUFOR1JjTW1SNGRWMUhZNkhC?=
 =?utf-8?B?ZU9oQkRaVkU3Uy9YSWh2YzNVVVl3ZlVsc28xeFZmY20wcGNQVDg4T1NwMU1F?=
 =?utf-8?B?b3c2UndBK29CeHcrRUlkcGdSZXpDTkVFR2x3bmhMS2VOb3VuTE9Ncko3d240?=
 =?utf-8?B?M1d5TndCTUVxVmtFWVBtS0pDWHhCQVlpbWh5RzF0VFpXYTdSemlETG9pK0do?=
 =?utf-8?B?WFJhd1RrNGVpYi9pWnY3UkxjTW43VGkwQjdXV3BPM24yOU92MXV4Qmt0N1JB?=
 =?utf-8?B?NktkaEN3QW5xR1FWK2VwYjYyK3lHVHY1RFd4Q1FpUldkeXpINy9EZlhsenZx?=
 =?utf-8?B?OUJFRUpFaEEwYUtDQnQvMWlIODRuMjNNZWV0bURINmZsMWlRcWthNm1DeURq?=
 =?utf-8?B?VnZWVjBoUEM1Z2FMNXZSbGNJR2pjb1F0SGI0SEhhOE1zM3FRdmxJc2wzWEU3?=
 =?utf-8?B?Z3hMdnpyWTZCK1hDdWY3Vkp4TlpNWDNmUEFGYzk4R0hrN29ROHQ5TitVeXdO?=
 =?utf-8?Q?KbSdpRsiH7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDI4c1ZPYjhBZzBmeVlqUXJWMXF0NTZPb3R0L0d4eHZRWVhWWVJhSGtNT0dL?=
 =?utf-8?B?YTlnTEkyOWtLRVcyR3lxdUlEY0R3elF0cXlYT2ZDdFN2dHJ5NkNFUkI3WmNk?=
 =?utf-8?B?NW1uU3NuTUpaSENVU3BYV2JIeGlsbDlxS3A5ekhPc0ZhZnZwcE1OWGlyYWd6?=
 =?utf-8?B?dFdoU1pEMFZoY0lTOUQ1NHlKSVh6S1NQVFMyWjl0aXd4MGZkSi9oeGVHcFh1?=
 =?utf-8?B?eHEwUzdtYmZyZ3VMeXNyOHlCNlhScHFIOHZQMG55WlBwS09LQ1hsS01NQTIz?=
 =?utf-8?B?OUlBeTVmRlU5Znl2UWlYbHZuUCtJVm5OQzdsREdsMzdjN3BOSHZFekpDNks3?=
 =?utf-8?B?ZGJkM3ZSUXlwSDZadm5qdndpZ2NxS01vVVVKRC9iNUVlSnZSNjdteTgrRGpk?=
 =?utf-8?B?bnlRc0hHU1NLWXJ2MHFFV3BtcGdGY04zdFptRkNqRVoxK3BQbUJMQ1lsakJC?=
 =?utf-8?B?MGdTdVhBS1RYVjRTWi82SFpySWNMdzVTM2dreWFjTmRvR0syeUx6ZkxNdkVu?=
 =?utf-8?B?M2NIaGxodnRBeXdGSFhWd2g2cjArY09PNnpoWTExK2l0VmgwUUJkWk1BQ2dV?=
 =?utf-8?B?TlhRVDJiU09Sb0JubTdjZEN4V3RBT0JUeGNHRU5JL05mMktkT3Z4U2t2c0Mx?=
 =?utf-8?B?YUh0OWVtKytBVGwybHVJZWI5OFJXTlJWNjlKTUdKT0tZTm9hY29SajBrdjVy?=
 =?utf-8?B?aC9RRDk1MUsyN1p3S2JOeEpHNDFPdmw2Nkx2THpEbVlsNmJBYkc2S2JPYlBJ?=
 =?utf-8?B?NGRPMHFQMGZjS3ViaHF5VFU3WktlelJCZ1hIUzZCVzJ0ZFEvWU1Yc3lkczFx?=
 =?utf-8?B?TEl2YzQ2MUJnSjUrazM3c1NLNG8yajlzV216T0I2dHE5L2lvM0pPSGRKWjVk?=
 =?utf-8?B?NXQ1QzhHdFdyd2ZtNElmN0M0elJlZnlldHcwaDNabUYrMFBXcWNQeDVBNWQ2?=
 =?utf-8?B?SElPYjl3bjNyb212TlB0VkxZWHJpV29GV0RBY2RNRzFlSm84b3lUR1kwaUJa?=
 =?utf-8?B?U25HRFVka0w0aEcvREFwZDZiMjd6RFZINEhlNC8zSzF3dW1IQnlvbzRRMGky?=
 =?utf-8?B?aERFSDFwSzhTT1JjTlIwTWdJT1hWL0M5L1ltU3hqRXF3Y20xZUhwRk5RN3ZY?=
 =?utf-8?B?Z1VOd2NNcTNVM2g0clJzZGRJTzZnK3RhY3FweG12UVlRYWpNMjdIdmNVOXl2?=
 =?utf-8?B?VU1FWE5ZVGdtZmlJZzdyclBCbE1XbUh4akdWQ2VGaHRhR1pxWGs4a1cxcWpJ?=
 =?utf-8?B?TXRkNVJRSnUxL1pXbUV2TndnYitvZ1FlRE5jczA1VHhnQ1g0azIvVzhxZjEr?=
 =?utf-8?B?N2RRM0hpb0JTTHFjZEJySVNDV1RPQVBSY2RSSi84YUs5MzhXWHMxSnBCdTNJ?=
 =?utf-8?B?YkFTVUFtQ01nYmx0bG9WODdyaXZQWStaeFE3bFNYNVkxTXZwdlJmaC8zTzgy?=
 =?utf-8?B?VldLWGNzdnBjc0NzallJV2hVWVhISWVSVzc0L013Z2YxYnQ4dkdmUkptOE5X?=
 =?utf-8?B?aER2MUNrbVV4dXhMMDgzdVlzUTNzaHVNT2ExNlNWRWVHTnI0cEhWamhhOWpw?=
 =?utf-8?B?MjYwYnVMT3VtRS9JZ2tZOC9PNVdpWmJNVGtkeVU5Zk5HT3ZDcDQvdVNZVUNp?=
 =?utf-8?B?MUozYktzTDNVSXpvSHZmdWRXN0ZkSHlXaERPcGUxd0tjdFRxSDc3NUpCeHhQ?=
 =?utf-8?B?cXMzb3hXbVR5aU43a1ZpYUdCaDVuTVdpZFBZN2tuWURiQk5wZy80ZVBjYjh0?=
 =?utf-8?B?d2FIRmN2MC8vRG5qQWV6UEU4UnpaS2I1RkZFNEp0eGkwVUxpa3FvWWdyelRZ?=
 =?utf-8?B?TUIwVzk4THVDSEVlTFVPYjhKRER5R3dhL05kSy94L1JUc2VsQ0dIcTg3TFVY?=
 =?utf-8?B?Q3FTU25rUUZYTzBLc1BMOUNvd0p6b2wycXhVUDk4NlBWQmdEQ084UlFBWjRX?=
 =?utf-8?B?czdqZDJITTFBNE1US0pvZ2Z4THc5ZHlzNC9jVUxDRnBhd3dYbHpSV2tqTFZq?=
 =?utf-8?B?cjN6WmNVQVpFbDdYbTdRU0JpL1dnakVKdmJpaUV0Qkh1dE9IV1g3NjYyellC?=
 =?utf-8?B?cDBrZU5ZUEYvc1U1QjM3aVN5RW9yWmZvZ1FTOE9HLzdyWnNWVkJRK3pseVdQ?=
 =?utf-8?B?UkFubXg0M1k4emttUW83RG5TN3NtUVdkcVNuK2poeG1DendzYUxxQ2FFZVps?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: STTjRZx6iAc+2MBBDQk7CRsN2+8q2IiUJdCtEaMYa/SfLBZu+AgBb4lr1xgIRt5r1jbJgpTKocVTEFiCmmVkOc146y5s1tinLOh7Gg8e7+lRd5VSQ5yQXQjHPoSK/qEtQZE5IgWJXpXwM5HhrZa7iVUWncHzHEsytT5Zss9C1dIgD9O60nteO9ZVsOcgQXsLfaFoP5v/tBWPUu5R4lKT3YpfZXOBgXWrnk2p2FtGEAg4l4rxBp2NkYKbSvkESoUalsYhRGafl3+fCufECJZ9KpsLrN9IIpqTm8VJbsQNFsLlCD6PiAb7EwLt0Ite4q9iyHhCud7JPVJFIRkbhvu+rTgxms16WmcxOszNkpWJYR8/nDgO206gWESDvEOUWjhb6+kBPpPftFxZOpbBw7uZma62+XKZLLakYhOUk93OyPw4pNmlQtaPO2JhJJtb68RrYuqszd3XG7qAoJJHQdfsSVdflB827vVkVupzKv4dno1UgXtgGre0auYQCuc6BtgvYSTieSZworAzOAaB3tubGdouhFM/zE3TBeF27L07mPSAQqnlJDBleNb4iYvg45NAcZwpXiJCyAAQewm224dvt0WrFz9lcLd8DBcNa7CeODo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a96761b-36f3-422f-6541-08ddb987279b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:40:29.4737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aPFSYRaUqbOsDVU0JmyrlqV3FCUQl/L0VlzmJR5aRVz5+o9OAfSRES5/WWOawSDMX26koQpYQ6hHVxpBxDMmkESkBq4YcMzDBAar3d526o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEzNiBTYWx0ZWRfX+Lqdrv0/Avl5
 Oet50DNRuLHriNvbk8/YKHkaOfm/LWCMOvZsE2KYyA/H+LfMcoYxn5XujFaZHW6de5FhqwFFwVB
 O8RzPhKNNDzQY1bd+zzRHNXvFjWebu81LSFV+QzWTOsRWWlWyMUkaEGSVXTFFbARN15eT1tMtzz
 aGpuLNwZ2vp/aT8QxfdxnaDQGY+G13w2Rmq9SjJoaQxquiJpd4jFvDVTVihUbwIXgVAssSbjhdd
 YvxNFzFSceXX4MWXMO7NOXPg76WnF32b43ChTN2fnKVzUl6v88iBkh8Itcr4lIQzERsNEIC7yIs
 sL8Gao5RshjpAzddPnT8d4kJnCgncs8kWF1ytaYbeEYjn2bUp4meh/K+22c2GXUS2FJHxX3w8TN
 mpgORa6I8YrABnR4gECG3TsC6AKWMwouz2Jtm0wP/WfB6wux6iK1hlHKmJwWcMH4HD/dwjYh
X-Proofpoint-ORIG-GUID: XpfLLOwduvzCf9VEUaUfDFnYEP2F97ST
X-Proofpoint-GUID: XpfLLOwduvzCf9VEUaUfDFnYEP2F97ST
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=68656102 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lJKPsjULG5Vb2BGNpY0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 11:35 AM, Cédric Le Goater wrote:
> On 6/10/25 17:39, Steve Sistare wrote:
>> Save the MSI message area as part of vfio-pci vmstate, and preserve the
>> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
>> then the vfio-pci post_load handler finds the eventfds in CPR state,
>> rebuilds vector data structures, and attaches the interrupts to the new
>> KVM instance.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/pci.h              |  2 +
>>   include/hw/vfio/vfio-cpr.h |  8 ++++
>>   hw/vfio/cpr.c              | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c              | 54 ++++++++++++++++++++++++--
>>   4 files changed, 158 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 6e4840d..4d1203c 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -217,6 +217,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>>   bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
>> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
>> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
>>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>>   void vfio_pci_write_config(PCIDevice *pdev,
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 8bf85b9..25e74ee 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -15,6 +15,7 @@
>>   struct VFIOContainer;
>>   struct VFIOContainerBase;
>>   struct VFIOGroup;
>> +struct VFIOPCIDevice;
>>   typedef struct VFIOContainerCPR {
>>       Error *blocker;
>> @@ -52,6 +53,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>>   bool vfio_cpr_ram_discard_register_listener(
>>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>> +void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                             int nr, int fd);
>> +int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                            int nr);
>> +void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                               int nr);
>> +
>>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>>   #endif /* HW_VFIO_VFIO_CPR_H */
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index fdbb58e..e467373 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -9,6 +9,8 @@
>>   #include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/vfio-cpr.h"
>>   #include "hw/vfio/pci.h"
>> +#include "hw/pci/msix.h"
>> +#include "hw/pci/msi.h"
>>   #include "migration/cpr.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> @@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>   }
>> +#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>> +
>> +void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> +                             int fd)
>> +{
>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> +    cpr_save_fd(fdname, nr, fd);
>> +}
>> +
>> +int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> +    return cpr_find_fd(fdname, nr);
>> +}
>> +
>> +void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> +    cpr_delete_fd(fdname, nr);
>> +}
>> +
>> +static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
>> +                                   bool msix)
>> +{
>> +    int i, fd;
>> +    bool pending = false;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +
>> +    vdev->nr_vectors = nr_vectors;
>> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
>> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
>> +
>> +    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
>> +
>> +    for (i = 0; i < nr_vectors; i++) {
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +
>> +        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
>> +        if (fd >= 0) {
>> +            vfio_pci_vector_init(vdev, i);
>> +            vfio_pci_msi_set_handler(vdev, i);
>> +        }
>> +
>> +        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
>> +            vfio_pci_add_kvm_msi_virq(vdev, vector, i, msix);
>> +        } else {
>> +            vdev->msi_vectors[i].virq = -1;
>> +        }
>> +
>> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
>> +            set_bit(i, vdev->msix->pending);
>> +            pending = true;
>> +        }
>> +    }
>> +
>> +    vfio_pci_commit_kvm_msi_virq_batch(vdev);
>> +
>> +    if (msix) {
>> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
>> +    }
>> +}
>> +
>>   /*
>>    * The kernel may change non-emulated config bits.  Exclude them from the
>>    * changed-bits check in get_pci_config_device.
>> @@ -58,13 +123,45 @@ static int vfio_cpr_pci_pre_load(void *opaque)
>>       return 0;
>>   }
>> +static int vfio_cpr_pci_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int nr_vectors;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        vfio_pci_msix_set_notifiers(vdev);
>> +        nr_vectors = vdev->msix->entries;
>> +        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
>> +
>> +    } else if (msi_enabled(pdev)) {
>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>> +        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        g_assert_not_reached();      /* completed in a subsequent patch */
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool pci_msix_present(void *opaque, int version_id)
>> +{
>> +    PCIDevice *pdev = opaque;
>> +
>> +    return msix_present(pdev);
>> +}
>> +
>>   const VMStateDescription vfio_cpr_pci_vmstate = {
>>       .name = "vfio-cpr-pci",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>>       .pre_load = vfio_cpr_pci_pre_load,
>> +    .post_load = vfio_cpr_pci_post_load,
>>       .needed = cpr_incoming_needed,
>>       .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 4cda6dc..b3dbb84 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -29,6 +29,7 @@
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>> +#include "hw/vfio/vfio-cpr.h"
>>   #include "migration/vmstate.h"
>>   #include "migration/cpr.h"
>>   #include "qobject/qdict.h"
>> @@ -57,13 +58,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>> +/* Create new or reuse existing eventfd */
>>   static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                  const char *name, int nr, Error **errp)
>>   {
>> -    int ret = event_notifier_init(e, 0);
>> +    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);
> 
> Since this is a "complex" initialization, I would prefer it to
> be done ...
> 
>> +    int ret = 0;
>> -    if (ret) {
>> -        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> 
> ... here :
> 
>         fd = vfio_cpr_load_vector_fd(vdev, name, nr);

OK

>> +    if (fd >= 0) {
>> +        event_notifier_init_fd(e, fd);
>> +    } else {
>> +        ret = event_notifier_init(e, 0);
>> +        if (ret) {
>> +            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>> +        } else {
>> +            fd = event_notifier_get_fd(e);
>> +            if (fd >= 0) {
>> +                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
>> +            }
>> +        }
> 
> Instead of preserving the ending return, could you please rework the
> if statements to return asap. I think it would clarify the routine.

Sure.  I can also simplify because event_notifier_get_fd is always valid
if event_notifier_init succeeds.  The result:

static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
                                const char *name, int nr, Error **errp)
{
     int fd, ret;

     fd = vfio_cpr_load_vector_fd(vdev, name, nr);
     if (fd >= 0) {
         event_notifier_init_fd(e, fd);
         return true;
     }

     ret = event_notifier_init(e, 0);
     if (ret) {
         error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
         return false;
     }

     fd = event_notifier_get_fd(e);
     vfio_cpr_save_vector_fd(vdev, name, nr, fd);
     return true;
}

>>       }
>>       return !ret;
>>   }
>> @@ -71,6 +84,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                     const char *name, int nr)
>>   {
>> +    vfio_cpr_delete_vector_fd(vdev, name, nr);
>>       event_notifier_cleanup(e);
>>   }
>> @@ -394,6 +408,14 @@ static void vfio_msi_interrupt(void *opaque)
>>       notify(&vdev->pdev, nr);
>>   }
>> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
>> +{
>> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>> +    int fd = event_notifier_get_fd(&vector->interrupt);
>> +
>> +    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
>> +}
>> +
>>   /*
>>    * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
>>    * fd to kernel.
>> @@ -580,6 +602,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       int ret;
>>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>> +    /*
>> +     * Ignore the callback from msix_set_vector_notifiers during resume.
>> +     * The necessary subset of these actions is called from
>> +     * vfio_cpr_claim_vectors during post load.
>> +     */
>> +    if (cpr_is_incoming()) {
>> +        return 0;
>> +    }
>> +
> 
> This test could be moved in vfio_msix_vector_use().

OK.

(there used to be multiple sites calling vfio_msix_vector_do_use).

- Steve

> The rest looks fine.
>  
> Thanks,
> 
> C.
> 
>>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>>       vector = &vdev->msi_vectors[nr];
>> @@ -686,6 +717,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>       }
>>   }
>> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
>> +{
>> +    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
>> +                              vfio_msix_vector_release, NULL);
>> +}
>> +
>>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>   {
>>       assert(!vdev->defer_kvm_irq_routing);
>> @@ -2962,6 +2999,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->err_notifier);
>>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (cpr_is_incoming()) {
>> +        return;
>> +    }
>> +
>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> @@ -3029,6 +3071,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->req_notifier);
>>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (cpr_is_incoming()) {
>> +        vdev->req_enabled = true;
>> +        return;
>> +    }
>> +
>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> 


