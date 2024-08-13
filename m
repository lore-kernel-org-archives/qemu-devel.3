Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9CFC52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 18:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdwXj-0008Lo-Qv; Tue, 13 Aug 2024 14:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdwXh-0008Db-Vn
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:46:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdwXf-0000gx-0U
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:46:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBVoE022308;
 Tue, 13 Aug 2024 18:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Ii7+Ij06IpjCR+0G2X0FVrcHeFF7OvHS+RXreUGzXfY=; b=
 SaseEf0bOsy5kLLaa0Bp4ZkELN8+7Jf8M5cU4XKabS1klEUxVxnV2iHyY0hl95Z/
 CqVMPyW7sAhx6C6QP0ZXq3ueUnU4V6s8ITD2owxL7JdU8UV5KE2fq2Jle5Vgqt5h
 0TRv7QWrdvXqN7+bRXDlRCq6IdLIuWKmiovtxvHfiFls9iEyZ2FEVdDWDPt/MpMV
 zpPuOEnpRNrBchj2rd1mTwfGGqJnX5FG4XLnyrPl2nDWIIhirTAWWat43bAfpAKY
 lkNFt5+T/4gLdathRd4vITr0G7plYuf1HjxuWQ1sfqk6mrcLirK2KSvSJvxqCp9m
 M7GQiVEB7QYI6x1QlvXL4A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396k3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 18:46:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47DH2VY2021781; Tue, 13 Aug 2024 18:46:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnfe0x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 18:46:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1U6gN+hHIbsw9IEmxjba/UpPb/QtwdmPC5bv1JCpB+PjBu79ERrihns43bAf44GcZwRKuK3uoqRz/M0HNWxm4Bqopu92VIGLsF5WTIIrOm9YE9Enju0MXa9ageea8FYW2d5xfM/MFqqr8K7nwNRdpvKfuwpcojLw6P3ne9DDjJdExkdbHBjbvJKXGxoWtbbrT1Q5QXMaqv9fkDSBndphECwnmQ2A0f50WE3+XBB9q+rfFSca0fs7/H+sI/ZGgY6IHuQuww0Y0M2SySW4fJytVnCwxtobupy9ZY1mIyCogqextizQrR1jnQFXRUyYG75/0g1/DFKenRBiW58Ff8gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii7+Ij06IpjCR+0G2X0FVrcHeFF7OvHS+RXreUGzXfY=;
 b=KleiZ3BswWAHTx33PztHRHKVg+fuaB3CqadoeldGTfU/fWqPzkEO4NNVPAQblFzktLNk1a9gXx7fQSR4+TdIyp60zjjV5tr9RvoEDKU/JrWGDPMnC7orQV6Pww/nuDVDmKQdH2nzDmQzvTQA9h0fiuk86PdIutZj6vzmsTSOxd3zCOo4+I34GuLVROvhLQhVI8e3oqGs214RK4vdfwI/GrST2RVfSow8jrx2b+zUbRwc4Ul5LPQjgnqYkZc/YsSvLq/otUYMgRQZUswoyK71HEgkH6e8Apb7MkEAtQozKyN+elx6qdoNqXadbPB80w/O98VHG64DC1pdyrvhvZlHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii7+Ij06IpjCR+0G2X0FVrcHeFF7OvHS+RXreUGzXfY=;
 b=pzvPt3YjfwkC0HOdu3ZPBr0cqQUUaSmte+mIO7zylmmgoweO9MJfeBxaS+G81wpknKNXAZclxA97GniZ442OTVimNLAeerrxD8pj4tiGCKYcFaaq+IWJue75CEofgjYTnnKWgLz3K27NVEhIuZpHIoG2vxvL5sCeZOCuPra4xDQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CYXPR10MB7975.namprd10.prod.outlook.com (2603:10b6:930:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Tue, 13 Aug
 2024 18:46:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 18:46:05 +0000
Message-ID: <8083e11a-365c-418e-9d5d-de4529c48c71@oracle.com>
Date: Tue, 13 Aug 2024 14:46:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com> <Zrt9M00rDk3EUdNM@x1n>
 <20240813110037.6f04ffe9.alex.williamson@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240813110037.6f04ffe9.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48)
 To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CYXPR10MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 90253832-3e4b-43f4-56dd-08dcbbc82fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTI5ODBDTFZyd2hCQlFMbEVIOEtNa3hOelYvdUlCcWo4V0o2T2p0UU5yQjlz?=
 =?utf-8?B?N3VoUDNGUlNwOU9pUWhYaVIwYXBzdG50WThIdjk5ak93WnpyNFJrYlA0WnRr?=
 =?utf-8?B?RnkrZWZMdlA4T2MzQ0dXcnp0Sk1yNkZJQjhMMGx0em4xTHZ0MjJCOU41SzdB?=
 =?utf-8?B?dFB3OURJN0J4d3Q3djBkcUlZUnliWFB6bUg0em4yNldXWjBoVEFZWCtGdFNq?=
 =?utf-8?B?QzBPbVRPTmptTDY0QXBqRFk2WXJlWFZaQm5Hei9QU0NIWXNWbHNrV28rVzJR?=
 =?utf-8?B?VEdmVnQ4c2FUM3ZiWm9KL1lrNW42d2hueCs1TzdIYy80TnpDeWNxTXhrbldn?=
 =?utf-8?B?OEtJSmlEN24zL0dCV252amxQZE15cm1rTUMrTWdSQjM3VzJEWm1FZDJYY2lF?=
 =?utf-8?B?aGthOUZaMjRpU1dkcXNpZ2p3VzFqYjhEeXhyWFVRYlJRcWVCMEg2MmlyTW9n?=
 =?utf-8?B?QmpvZEZSbndsWkJNYzhNZE92RjhLNEhuTVUvVUdRZUNZd210Z3BkY1BVY2l6?=
 =?utf-8?B?MmJkYzgrRVBJdWhVa0xKQWd5cVpIemdPdEZUQU1iTXBIa1ovaGI0NGtyZ215?=
 =?utf-8?B?UWJyTjJvMzI4RSs4d0hBS2ljb3orTnBKVU1rTTVIT0N1aUdoZlJuOGRHVGZq?=
 =?utf-8?B?aWtKcEhpdyt3U21aeHpvSjZwVURoQ0VKVU85L1o1Y3VMNUV3UndQNmpUdFNq?=
 =?utf-8?B?RWZjc3JCcU9NeXJUSUJ0SHR6RnVuZG5iSXFVSVhIS25vR2ZtZjkyNjlScDlV?=
 =?utf-8?B?WXgrZ2dMWUM4VUx6UzBrTkxUdzFkTkVwOE00dW5PM0pBb1RKVDVIdktiVVgr?=
 =?utf-8?B?bmhpRmlHK1p4VVR0NnNzSWVvYWhtMU14b3gxSVAwcTZMbThHVk03ajNlc1hQ?=
 =?utf-8?B?VjFZVlR5RU8wOFkzemVmNWxrYU1ab1NweTUzTFNCQzF2aGtwL2ppbWR2eWc3?=
 =?utf-8?B?YUdtaG5XZ2xoaW9GRStIc0t0Mno1aldqMXVRS1R0VHZTV3NtL0xEZVJjSEdX?=
 =?utf-8?B?bzZoa25RcU1mcEVFNDlCeUpuRUpVWTBsWkxIZm1aalplUy9tWDVaQ3VkbWJY?=
 =?utf-8?B?b0JZUW9Nb2lHSDd1NXIvcG0zMWtzRlNRMVBtSjhXL1U5RVY1VG8yT2VSTVF4?=
 =?utf-8?B?bXdFZW02L0tNMURxV3dHbEhwTllTUCtGajRWKzRrTGUxL1RnTTNrK05sL0Z6?=
 =?utf-8?B?YXpxajB5TFZwM1dPOXdJcStvWko5L25FR3lLdDRBSXFoV2FvZC9pMDFSYkl5?=
 =?utf-8?B?NUpEcnkwZStybWtxT2lPTlBScWl4ZkEzM3BHRnFsUW1EUVNlc2RuSVh0VTQw?=
 =?utf-8?B?WEx3N2grWFI3N3pqRmJHR2JOMXVwbTh2NndrNjVnUzk5K0FTeFIwTlRLcTJW?=
 =?utf-8?B?OVVBQ3M3UkJrWjF0L09ieFNaVERBbmlCRDRKT0NaSWlMbHIrN3ZHYktwUnV6?=
 =?utf-8?B?Lzg4V1ROSXMrWmVHSWZIVFMrdnhUL3d6NVdqTmNKOXNsZExqcUVQZVJiS3Bm?=
 =?utf-8?B?UUVUNnU2NXNSUjF6VFd4a3REVVorR3MrTnB6VDI3bnBsQ0FkdUIzS1dGekhU?=
 =?utf-8?B?UTZCQi8yQUxHcWxxQTVSRlFmMW5hNWpQaWlUT0RQQVZQajBOZ2V1ajdlZ0dG?=
 =?utf-8?B?dnp0SDVuK3NEam5abVlCYkNaZzNEUHNYUTZPMEFFazc3SmtsM3hVWWp6KzVX?=
 =?utf-8?B?cGlBSnp0My9mNk1kcTlic2hwUUVDTEEzVTVXMXBHU1NwTXduTTdYV2tuN1dY?=
 =?utf-8?Q?vNiM+leuEbju6Gt9BU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FEMmNxMTdsM0dPRW5hMVU3YjJJNzJTQUVhdURiVnM1OTVMZnpTeDNRU1lL?=
 =?utf-8?B?T3BRc0NWOXNLcXBTVC9URnJ1MFRLWFl6TVBPNUwrUVdJaEdYQXBCcm4yQU9U?=
 =?utf-8?B?Q05yaERDUnhkcE1DMGpUVlRZQ0M3YkczZ3B3MVlOb1BsNXY2NVJETllMWkhV?=
 =?utf-8?B?blVxdWE1UEd1bXZ3MWJiUlVvMUhNQ2VueWtNaU5reTVLUDhYa0FGQnJ4Uy96?=
 =?utf-8?B?dVI5ODgvVnRzd3U1TENRUHJBNFpXVENGcktaNkNlNGxJY29zQ1dFcmdReUxQ?=
 =?utf-8?B?aUFuK2JNZUk4UUNFM3NHOG5iQko5OHdyY0NvKzNmcU1rQjRWdGNlVEdYdWdE?=
 =?utf-8?B?ZHJzL09Fcks2b3BoWVlXcnQ5SFpBeWM3RHV0bFQza0ZsRlMyWmdJQ2RVTFlE?=
 =?utf-8?B?c1R4d2tWZkxpaGVPTHVacHo4RmVEbkxUN2hlcVhRaXNybGdrQWdzSnkrdWw4?=
 =?utf-8?B?T0RDSm1lUWhJUWhHRFdEOWVYNW1CQVZHZEpKeVVUSDNwNkVsQy9mclRoam91?=
 =?utf-8?B?aVNhejQrYTBMdU5pWW5yeEZSNkZTaWNibXJPeGZpTjJHSFVDSDdkSUQxazJD?=
 =?utf-8?B?dFhZajVIVFNyVWVwbDZOTW1oTGloZXJ3bHUxci9aWFpBY2NQei8rTXJ3RHpQ?=
 =?utf-8?B?Z0M5czFybVdnRGU1KzV3Ym9lZHFqcWFaODhSYUdqMHlGcFI1aVVldU5VK21q?=
 =?utf-8?B?WkU2ODQydkZQeTRHRUpBM2c5RS94cmNvRFJzVmcxamtuVVQxdFF3MEVTSTZ6?=
 =?utf-8?B?eHgzL0xieFZoam5aaTNKcEUzeEdtOU81aE93WTF3c2dkYU1WQ2FMcHFXRlcv?=
 =?utf-8?B?cXFjakJ4YnptRE1DaTdjU1ZxSm9MMTZLUFdQTkd3VUNNNlUxRjFVaWdkdnQw?=
 =?utf-8?B?U3lLTzZJeFZqWFhnWHlQOW1SWFBwSE5zWCtDeEdDUmJwaTlqTGFhc0JtWDBJ?=
 =?utf-8?B?bmc5emowakJIZmFnOHUzZDFJZkpIUHBNSmJZN2xKYkVaTTRwb04zemo0TGhW?=
 =?utf-8?B?T1RWWFV4c0hBYThGbkcyazFwWld5UU1MYjFaMjVLNUNWYXFuWEthWk9PUm8x?=
 =?utf-8?B?NVlWMENKR2FheGtGUTh1N24zOGd3U28wNlBHbUVXTEhibFdUNUVWRmxSZXlr?=
 =?utf-8?B?TnBsaitIZ3IrRFQzVXZ6c1RKVk05VGVTV1g0ZUdBR1BJTEM1SFQ0cll2OG5z?=
 =?utf-8?B?OUw0L3BKckFxcy81NHB0d3gzTkYxeXpnbTkzQzFDcTBqSjFSY2dRWFFBZWhF?=
 =?utf-8?B?QTJkR1FQK1JoRGZNQjJLcHZZYjZCeEhVekFXOU0rREkxdWFpRFNzT1RWZkY1?=
 =?utf-8?B?NEJDWGZlR09YcXR4L2Flc3hBQjZNUUJyTWNNcFhhQkMvTmYxUkxwaWFhTFVP?=
 =?utf-8?B?SHlKM0VxQTY3cmJwcGw4aDRwQVQxc0pWYjZ4aWxZV2dkdktORFpGM0pqYmIx?=
 =?utf-8?B?TDVKQVFzTkdqbGNwS201R0JUNElLanlYbk10aGRGWTd3a3hYS0FtLzN4aXdu?=
 =?utf-8?B?VWVyV3RabmtnUm81MDFFZDE3R2xmRkdBa2hRUUNWVFovYjB2K3lnWVFYdGxk?=
 =?utf-8?B?bmY0RHE0WDNBUGZjVytUY0hDRDFJMW9MaFAzTHpGY3VvUXNJSlRWeDZKZVZH?=
 =?utf-8?B?UGF2eE1wcWkzU0hMajZ4UnlwWG8wdGk2QWllTGRQR0QvSncxcDd5SGxyT2NS?=
 =?utf-8?B?RUVJa1Q0RnZxVGxJVkhjSG5aOHBZV2I3cGU3UUJWQytaN2xNa203cElWMng5?=
 =?utf-8?B?M1lWakZ1VTUzVW5qYU42VHhYOU42L1czeFNQRHl4T1pXN3czZWlraXpCemNG?=
 =?utf-8?B?cHQzV1VvR2VBY21SYmt1VzNqQmtYcS9hc0V3RkJwbHVhMnV4ZStSRDFqOUtO?=
 =?utf-8?B?alpIdXhnaDNidk5OblM0T2pGam5hd0NseXExU01DbmtIZzlwdjQvNi9Qd0Jz?=
 =?utf-8?B?Nm9CQjQ3V0w4OStOYVVhL2lwbXdncmRYVVhwVHNtYVF3TDlVQ2RXeFV5N2Jz?=
 =?utf-8?B?VC9MdFEwbS90eGJTWkV3bEFmaGZkZ1BPNG9iZjJoYTd2SXdoVmJIRHdLSUZT?=
 =?utf-8?B?WHNiTzNSWXg0eURwVExhSHl3ZU9QeFRkcFE4dEZTQjZMNG1GdlN5b1V5NXIr?=
 =?utf-8?B?N21xQlU1c25tZ3FMM2xVTEFyNmJIemZadXQ2UWlhRjAwQzRPb29aSnlOa2pq?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EMJGmFJZF1cEQ7VUE8PsFE+6gAeY0sbVDNusrY89nx9MNy2UNAife1VTtbKnTJXOhH2WMppM+YiokLX44uWn8bPwr9VXdvXKMdGBLT/VXWsGOdSpV3Gmscv3iBa2k0vo9M0zRs7eieZHdhCZVWYGW5zf1Cy1/SK0edGyWZ8z6UAnsn8VfeArj3Agptsvh4uRoHS94IQs4YB5aRWv9vY7bRqe/GNjVuAiIXDCyj26cdeoqfXLq65fe8aswRfqvqiDZWx+LFhR91J+rHaDvdRmczfIIZpXFNDn5sumGT6m6y4CyYRTmx2ZnqxD6KsIt88bTW+X4xlHOqAKv0Yb2oxJJTi6+pihDn+c20AouNL1mDDoFt20HJPHWS+yIEdXe/2DqFJfkVt3syeyEggLodqsnDrKJW24cREB9f5uLMrqv+bDS6gSFkXtRAOFC+F0EFcHmzZskBJQab0eTm+a2a/Hh0DS6csLAVpWzdd/lGH5TVU2+5BcWtASVavbE83X8kzXR3CtSvrVScl4EMoUhZ/Pm43JE5zST9zCxjKl61Ne6ilJe5+MMnSQ1hK2XQDdkFdcjN0/ZAtJuHx36ABtvWhnPa6UAsFqlUNc4ZqR4tN4KyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90253832-3e4b-43f4-56dd-08dcbbc82fc6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 18:46:05.0041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwnxtOsWA4fFnnbpUc7+GuzdIUDwo0+Z7fCvFFq8TO/+UjkqzeCXNRgSXJlccTTZDQHbk2qzs8pCUMKJ/bo/2dk9iFhVzRHyc2/aFbOcheg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130135
X-Proofpoint-ORIG-GUID: lCjAYdaFi9FkNbxAai_8ZRX3KXLTCcv_
X-Proofpoint-GUID: lCjAYdaFi9FkNbxAai_8ZRX3KXLTCcv_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/13/2024 1:00 PM, Alex Williamson wrote:
> On Tue, 13 Aug 2024 11:35:15 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
>> On Mon, Aug 12, 2024 at 02:37:59PM -0400, Steven Sistare wrote:
>>> On 8/8/2024 2:32 PM, Steven Sistare wrote:
>>>> On 7/29/2024 8:29 AM, Igor Mammedov wrote:
>>>>> On Sat, 20 Jul 2024 16:28:25 -0400
>>>>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>>>>    
>>>>>> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
>>>>>>> On Sun, 30 Jun 2024 12:40:24 -0700
>>>>>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>> on the value of the anon-alloc machine property.  This affects
>>>>>>>> memory-backend-ram objects, guest RAM created with the global -m option
>>>>>>>> but without an associated memory-backend object and without the -mem-path
>>>>>>>> option
>>>>>>> nowadays, all machines were converted to use memory backend for VM RAM.
>>>>>>> so -m option implicitly creates memory-backend object,
>>>>>>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>>>>>>> or MEMORY_BACKEND_RAM otherwise.
>>>>>>
>>>>>> Yes.  I dropped an an important adjective, "implicit".
>>>>>>
>>>>>>      "guest RAM created with the global -m option but without an explicit associated
>>>>>>      memory-backend object and without the -mem-path option"
>>>>>>    
>>>>>>>> To access the same memory in the old and new QEMU processes, the memory
>>>>>>>> must be mapped shared.  Therefore, the implementation always sets
>>>>>>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>>>>>>> user must explicitly specify the share option.  In lieu of defining a new
>>>>>>> so statement at the top that memory-backend-ram is affected is not
>>>>>>> really valid?
>>>>>>
>>>>>> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
>>>>>> explicitly add the "share" option.  I don't implicitly set share in this case,
>>>>>> because I would be overriding the user's specification of the memory object's property,
>>>>>> which would be private if omitted.
>>>>>
>>>>> instead of touching implicit RAM (-m), it would be better to error out
>>>>> and ask user to provide properly configured memory-backend explicitly.
>>>>>    
>>>>>>    
>>>>>>>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>>>>>>>> as the condition for calling memfd_create.
>>>>>>>
>>>>>>> In general I do dislike adding yet another option that will affect
>>>>>>> guest RAM allocation (memory-backends  should be sufficient).
>>>>>>>
>>>>>>> However I do see that you need memfd for device memory (vram, roms, ...).
>>>>>>> Can we just use memfd/shared unconditionally for those and
>>>>>>> avoid introducing a new confusing option?
>>>>>>
>>>>>> The Linux kernel has different tunables for backing memfd's with huge pages, so we
>>>>>> could hurt performance if we unconditionally change to memfd.  The user should have
>>>>>> a choice for any segment that is large enough for huge pages to improve performance,
>>>>>> which potentially is any memory-backend-object.  The non memory-backend objects are
>>>>>> small, and it would be OK to use memfd unconditionally for them.
>>>>
>>>> Thanks everyone for your feedback.  The common theme is that you dislike that the
>>>> new option modifies the allocation of memory-backend-objects.  OK, accepted.  I propose
>>>> to remove that interaction, and document in the QAPI which backends work for CPR.
>>>> Specifically, memory-backend-memfd or memory-backend-file object is required,
>>>> with share=on (which is the default for memory-backend-memfd).  CPR will be blocked
>>>> otherwise.  The legacy -m option without an explicit memory-backend-object will not
>>>> support CPR.
>>>>
>>>> Non memory-backend-objects (ramblocks not described on the qemu command line) will always
>>>> be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
>>>> The logic in ram_block_add becomes:
>>>>
>>>>       if (!new_block->host) {
>>>>           if (xen_enabled()) {
>>>>               ...
>>>>           } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
>>>>                                           TYPE_MEMORY_BACKEND)) {
>>>>               qemu_memfd_create()
>>>>           } else {
>>>>               qemu_anon_ram_alloc()
>>>>           }
>>>>
>>>> Is that acceptable to everyone?  Igor, Peter, Daniel?
>>
>> Sorry for a late reply.
>>
>> I think this may not work as David pointed out? Where AFAIU it will switch
>> many old anon use cases to use memfd, aka, shmem, and it might be
>> problematic when share=off: we have double memory consumption issue with
>> shmem with private mapping.
>>
>> I assume that includes things like "-m", "memory-backend-ram", and maybe
>> more.  IIUC memory consumption of the VM will double with them.
>>
>>>
>>> In a simple test here are the NON-memory-backend-object ramblocks which
>>> are allocated with memfd_create in my new proposal:
>>>
>>>    memfd_create system.flash0 3653632 @ 0x7fffe1000000 2 rw
>>>    memfd_create system.flash1 540672 @ 0x7fffe0c00000 2 rw
>>>    memfd_create pc.rom 131072 @ 0x7fffe0800000 2 rw
>>>    memfd_create vga.vram 16777216 @ 0x7fffcac00000 2 rw
>>>    memfd_create vga.rom 65536 @ 0x7fffe0400000 2 rw
>>>    memfd_create /rom@etc/acpi/tables 2097152 @ 0x7fffca400000 6 rw
>>>    memfd_create /rom@etc/table-loader 65536 @ 0x7fffca000000 6 rw
>>>    memfd_create /rom@etc/acpi/rsdp 4096 @ 0x7fffc9c00000 6 rw
>>>
>>> Of those, only a subset are mapped for DMA, per the existing QEMU logic,
>>> no changes from me:
>>>
>>>    dma_map: pc.rom 131072 @ 0x7fffe0800000 ro
>>>    dma_map: vga.vram 16777216 @ 0x7fffcac00000 rw
>>>    dma_map: vga.rom 65536 @ 0x7fffe0400000 ro
>>
>> I wonder whether there's any case that the "rom"s can be DMA target at
>> all..  I understand it's logically possible to be READ from as ROMs, but I
>> am curious what happens if we don't map them at all when they're ROMs, or
>> whether there's any device that can (in real life) DMA from device ROMs,
>> and for what use.
>>
>>>    dma_map: 0000:3a:10.0 BAR 0 mmaps[0] 16384 @ 0x7ffff7fef000 rw
>>>    dma_map: 0000:3a:10.0 BAR 3 mmaps[0] 12288 @ 0x7ffff7fec000 rw
>>>
>>> system.flash0 is excluded by the vfio listener because it is a rom_device.
>>> The rom@etc blocks are excluded because their MemoryRegions are not added to
>>> any container region, so the flatmem traversal of the AS used by the listener
>>> does not see them.
>>>
>>> The BARs should not be mapped IMO, and I propose excluding them in the
>>> iommufd series:
>>>    https://lore.kernel.org/qemu-devel/1721502937-87102-3-git-send-email-steven.sistare@oracle.com/
>>
>> Looks like this is clear now that they should be there.
>>
>>>
>>> Note that the old-QEMU contents of all ramblocks must be preserved, just like
>>> in live migration.  Live migration copies the contents in the stream.  Live update
>>> preserves the contents in place by preserving the memfd.  Thus memfd serves
>>> two purposes: preserving old contents, and preserving DMA mapped pinned pages.
>>
>> IMHO the 1st purpose is a fake one.  IOW:
>>
>>    - Preserving content will be important on large RAM/ROM regions.  When
>>      it's small, it shouldn't matter a huge deal, IMHO, because this is
>>      about "how fast we can migrate / live upgrade'.  IOW, this is not a
>>      functional requirement.
> 
> Regardless of the size of a ROM region, how would it ever be faster to
> migrate ROMs rather that reload them from stable media on the target?
> Furthermore, what mechanism other than migrating the ROM do we have to
> guarantee the contents of the ROM are identical?
> 
> I have a hard time accepting that ROMs are only migrated for
> performance and there isn't some aspect of migrating them to ensure the
> contents remain identical, and by that token CPR would also need to
> preserve the contents to provide the same guarantee.  Thanks,

I agree.  Any ramblock may change if the contents are read from a file in
the QEMU distribution, or if the contents are composed by QEMU code.  Live
migration guards against this by sending the old ramblock contents in the
migration stream.

- Steve

>>    - DMA mapped pinned pages: instead this is a hard requirement that we
>>      must make sure these pages are fd-based, because only a fd-based
>>      mapping can persist the pages (via page cache).
>>
>> IMHO we shouldn't mangle them, and we should start with sticking with the
>> 2nd goal here.  To be explicit, if we can find a good replacement for
>> -alloc-anon, IMHO we could still migrate the ramblocks only fall into the
>> 1st purpose category, e.g. device ROMs, hopefully even if they're pinned,
>> they should never be DMAed to/from.
>>
>> Thanks,
>>
> 

