Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25629C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwwU-0008HK-Gj; Fri, 14 Feb 2025 09:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwwS-0008Gs-Th
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:45:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwwQ-0001qd-Pq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:45:20 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtWtE011579;
 Fri, 14 Feb 2025 14:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=R5zQoH+Z3uEM9JBdb6LOn5EpuiUQYqKQ5pm1+DWuaa8=; b=
 fwQjK2xNYNf3ozneqQKTsBYyjp987Aj6zKiMsAUjo/Y63mxD6rfodhra/2MVdizn
 sDJK34j0YdyaPcsx6fT5LTyAVGM/OlzvANqrOrLUfeDXHJL9hm5geR/8yM8gUizN
 WQkB8uNIYch79DcZhrxs47VlMV1/HmkiYAD1fWUqmMi+VqViX+QCNaZUf7YRFTP2
 x203EK4N3qKRZuY/COU5XskOzusUMXbzSo59ojvyC7M0K/B8igmR50rV3XhVMfzP
 bm7iDhBSZ9+Z1b2utv4OPGB6QTpf5Rn6wMvfLDlZr/GBgOR5oe6d4uazoCkxQH1G
 l5qeBkor2A6pvOhdFH7KvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqbyk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:45:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EEIpdC025381; Fri, 14 Feb 2025 14:45:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqktjvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhyydvYquqZdzMAppyaTnKCbtlHqy0WbiKgH2mf942WPR+j9g+Lk9BpinI+mFAZw+Q939DIJ1aY2QHzbqjtk0Dq3JM2gqkwNAFaLC5i79POBohla4Bmh8wR4t1Ncixrl3ftexadO5z3bsT/ez56ZbkfcW8lzGzCftwps+QO5IOTZlObrDuKZyoLMwWjAoLWpJvsiVoOKDSBTsS49SZ7RZE3xd7378uXFPQnetomkBWgg6BG1VAhn+UQQu9OQjyltAAzGn/B6AniPHu/PX17KMc/p7Wm2384j3XNl4RqcDtA1xJK4p3G0tyg32YBDINRv4Bpxy8FBMJoKg3Px4tGULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5zQoH+Z3uEM9JBdb6LOn5EpuiUQYqKQ5pm1+DWuaa8=;
 b=HLBAHHNB5V+0rmFatkKw3hj3gYs/oVwQCh6oDjS4WnXBH4eMg+l0fAJG9lN/bVTnZzcfuIxO1d5/X0Pv6QTcu+arK0mhOFYS3pNKQV7mBFOqRdmfzwZqEzalgFXLPHFUdWFyxDaK5VRQED+KhmTPNSdfplFFV1UB/oSHolRb1xSCzkD+Qba3HEpqOfU+3JBSPpA5il+nuLvJT0LjgT3BFrmN7+ey9gzSb1Je3Ffa2l/1htetFPgGl9hboROXjJyqjX9UyUs3iN/KUQL5cgZQFGggPLA0pAjerXdd5BtCo5ZYCCGW3ZpgIl5k2Lhu3RVoJ8yBg059Pp8Y6uFkFXFUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5zQoH+Z3uEM9JBdb6LOn5EpuiUQYqKQ5pm1+DWuaa8=;
 b=CZh5yDt4RHcCZadsuKSIslfAwfDPkbbmFCQGZV3lTvB/2MaCa7NXewec7AFTy90fun6l7E2Y3YtjBsrNM9JPS1pkrgnJceWKL5WRdt4/WGN9RcAQo+EN2PowTQnJUUJ+ZcDqNenm5lXIkH7yrFhyRPxnVe820TOZEITnFnWPGFY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 14:45:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 14:45:11 +0000
Message-ID: <ee59365c-707b-441c-adb2-4db4e7758cda@oracle.com>
Date: Fri, 14 Feb 2025 09:45:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 15/45] pci: export msix_is_pending
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-16-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1739542467-226739-16-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:408:60::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: f65ef08a-8bb7-46b3-5eba-08dd4d062f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlRlR1AvYTVlSjF2bFpXYXk2VmFMdXFlbnhDZnlZTG9HTUZXb3hxOEZIS292?=
 =?utf-8?B?alBISFJHbUp6RWN3dUlEb3k2cGZhVkRjMk5wNTFKVUpUa0Z0eFR6RXdoaGxE?=
 =?utf-8?B?UHFpYW9BSGwvV2RJcnJzaEV1bFFCc3NwUU56NkpaR1JBM1pBRDJSU1hLaE9I?=
 =?utf-8?B?MXNjcW04S3FXV21PcUh2Q1RlL0FDT0czR01IaERnNXhrVVhhcEh2WEJXMmR4?=
 =?utf-8?B?UkczTC92aG1NZTIxYkdXbHpoR2pNdnI1TjExNFhLVlBub1hLcWI1b3dyTDYw?=
 =?utf-8?B?aWVzR2pkNFpIUzlnOU9HZ3VuWklNMVpTNmExZ1hvYU9TbmlFRVlFUHQza2hT?=
 =?utf-8?B?Y3F4SWFQQUlBWjV2QWwxVGhGK1dsRVZrNVFoZ1FJcGpWa3RRQkoraUpEOWhp?=
 =?utf-8?B?ei9kbCtVVDIxQ2hzTTRmS0FEeTAyRmljazBrVmpPeTNsaVhPZUZlNWlJM2I2?=
 =?utf-8?B?TFhYNmJ0RDBuTUxZZlVOZ2dMOENCSmVvL2J0elBOK1puNFRFUGhBNWFZb1k1?=
 =?utf-8?B?T2VLTWNOeWRydnptUG03bzBrcVVxZDhOajNPenpHMmQrVERiMlJPbWdRbmFX?=
 =?utf-8?B?Qkl2TVNNbys5RTB3My9rN0hRUVU4K2lRRWM2cld4Z3R4K2k3SFBwOVRuNVp6?=
 =?utf-8?B?VURpaVdidXo3emd2NHpOTXZVWGJYdXJWNFJPdEdwWmlYeVZqYkd0QUljTG1a?=
 =?utf-8?B?UVFlOFlPWWpuUUNEaUluK2I0emJEaUIxc1NhZjZNcEpPVTZYRzhMMm1XMy9H?=
 =?utf-8?B?bUZRbUY4NXpSdmI5ZTJkSGhQQzR6Z1dzb3FVZUk4b1pQK0tzL3I1U0Y1eC9T?=
 =?utf-8?B?ZlBtWnhIVm5VN3ZCOFpmdHFOdS9LeXRnSUpWekJYeTRLZGNOdFd1aW05UlJR?=
 =?utf-8?B?VmMwcnpoeWE0UGJVWjRnUTBqNnkyclJXLzc1YjJuZm05QklqVmo3VDBNZVV3?=
 =?utf-8?B?SEhFVGJ5d2JvUllURm1tT0JNWitGZVcvUHBma1FwZ2dPQVRRUnB5d0Nlc0Ev?=
 =?utf-8?B?Nm5zbUhuTW03TUlEU2hhV09DcGxzZzErRC9BamJHYVBRa3ZlMFIwYmhPZ2tO?=
 =?utf-8?B?VTFyREpCaWVJVk5zaHg2a0VJemhFclBKYmptNS94bjlEbm5yMVV6K0JVZUQx?=
 =?utf-8?B?QVRNMzcwMzR4VlBhS3BIbHZpN1A1RXdEV3Jvb1pVSHJOT245ZDNVOFN3N2ZL?=
 =?utf-8?B?MThDeVJXYWNSL3Y2emVHcTNoSEpGVnptWkhCdGVhOXFhNDFFb0h3a0NBM1NS?=
 =?utf-8?B?Y3liVkMrWEQ3MFlmQXEzSFVuYnZ2NmxrTUVnV0JaR2haWHRHQ1hDRHhjTFFQ?=
 =?utf-8?B?NVJVY0E3b0IxWTdLRnZiSXFvWWcvaCs4dUlpUGJXWW1zSUVMSmppL3UxcGZl?=
 =?utf-8?B?M3VSeXArbUp3WTFuVm1LNUFMOEd3NlcwSEZtbEJTaE00U0NKd0N0ODlwRCtF?=
 =?utf-8?B?eGxzQ3RXYitvSTJLWkNPeUJ1L3gxSnNKYXFzN0pwNmwwUmJ4ekZhdWoyN1Bx?=
 =?utf-8?B?d2swOXV6MG5lTjh0NjA1MUhxRXdFWmNDYlFIN1d0eXM1L29LTWRQMXh4M2hL?=
 =?utf-8?B?SUt2V1k5ZkdDZ1laSC9DdkhIaGRDOXFGMjdHSkkrdjBuRDU1c3dqZzYxV3dm?=
 =?utf-8?B?NlRjU0IvK3N2c09WTXVQb2NwV3FsdXZwdG1DeHQyTThJM2dXV2FCdGZEL2oz?=
 =?utf-8?B?TWlpR08vSlcvZGtzaFphWmlzcXBIU1VyVnlTb0RoSVRWdHptRyt0Q2xqaW13?=
 =?utf-8?B?Q3J3Qnd4Y012OEUwYlgyYUVRU2dPOE40aGdYQW5vZXYwV0FLSFZtazAzdkRP?=
 =?utf-8?B?NmJ1aFVBYVpEd1FUMEg1cWVBREt4WCtOQjJEQlBuVlVLbjFTYzJRME1EZmRG?=
 =?utf-8?Q?A+CipL8UlUVtZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWFRMGhpQkM4bDExQndWeFg4WDFNQThZcHpqOEs0YXNaYlZ2M1R5a203WTdr?=
 =?utf-8?B?OHhNb2F0SnZFZEVac0lyWk1UUDBYdXhORXJpdm90QmphcGt2WDZFTncrN3JX?=
 =?utf-8?B?WThlZVlzbk92UnF6Z2U0MzRGUXo2Z3U5KzhnWFlvVmJzY3FPRzFINWxhR2lo?=
 =?utf-8?B?MnBEdmFjUWNyRzJweHVhdERxYjlucEh2ejNnRmZmblFVZGNWKzRNL2ZZUDJE?=
 =?utf-8?B?aG5oMWFmK2ZKTjYwbjU5TUVLZHhOdU9kQ0U0YjJxaFoxeXU3NmNRWGU3Z1pi?=
 =?utf-8?B?d2RxeWJrcnRiZnkwQzVZQndBNVVLNG9SVFR0K2dadGhEbGhKYldKTzNXZWdO?=
 =?utf-8?B?UjYrZFUwdzF1a1VvRXNVWlNBRy9SMnQvZms5VW53Z05saDlXVVlsMnJBR1V0?=
 =?utf-8?B?djJkcnZDRmZxbDFMelNnMzRrOXpoamZHTThKMkwwbVZQZnIzdm5keWMwQ0x6?=
 =?utf-8?B?aW5pQlowV01HWlJLNTI5UmMxaUhiRm0xVG1ybmY4TnNKRUJIdlhmZHE3bURs?=
 =?utf-8?B?emxIYUQ3cU5qdFpQcm9xN3JHUHRKU0hkNUJ6NWluenV1RjNwUjRGUTlRRG1z?=
 =?utf-8?B?ZHRmMllPbFRyYVhvMkNXa3I3eXJIbG9ZUDhEMWgwUEdkS2xHRlVpTExDdWdl?=
 =?utf-8?B?eXdXM1VYNlc3cDJKSzYzRG9YOFRGVzljU29ScjdjL1ZLd1RhZ0NqU2srY2kz?=
 =?utf-8?B?UnRiZkJReWJuTkliQnAwVkFwalRaL2ZYMWhzVVNlUnU2cC9aTGdvOEV5WlNj?=
 =?utf-8?B?WHgzdE00aUg1YjJTaGR4Y253YzBEcXFpOEcvSVRPV3AwelIwT0piREVUaFFm?=
 =?utf-8?B?WjFMbVg4b1hMK1k3SXR5RmlBTmdJZHZ1RnBValJFZ0UweUN1YzBaSGdOdDRi?=
 =?utf-8?B?d0loTVVIeDFIK0oyYS9DV1VwdHdHTkJHZXNiUnk0TzV4U3Z4ak5JRmpHYVpS?=
 =?utf-8?B?cEk1NUVURGFCK29RQjdwTGN0UWI3bHp6YndDcGU5REdDLzMzVXZJRGs3RjY3?=
 =?utf-8?B?cE8rK0FzMTBCcEsyV1p2UDF6amhWWXBpZ3BYWEptNWwzWTBKenU3aFFtWENY?=
 =?utf-8?B?VEcydVVZS04zN21WektTWVM5aWFwUk54dU50WXM1Q00xTVA3dkh6alhXOENW?=
 =?utf-8?B?Y0VBYkNPbFpjN25mVmE0V0o0MDJXOG1jYWZ2ZTVLNkNFRjRIWmk3VjJHTHd2?=
 =?utf-8?B?U0lxUUYrSXV3Z2wwZDhLVmY3UjhRR1J4VzkxVWZrYmNkWG4vamdsdG5OM2FY?=
 =?utf-8?B?NU5va0xrU1ZESm05aVlGU21EdmlHYnEvR0pCcWdxRS9qeHNSQktoSGswdUUw?=
 =?utf-8?B?bFBtQkFhMkdweUxiT0dQSG81WjRXT0FzdlpNMHIwcWgxcFlJd25HY3JVSWdx?=
 =?utf-8?B?MzFtZTNNOE5vNUZMNFIyNVAxdVRuZXorcElNM1h3Vnc0cHNkTXdrL1ZUWFo1?=
 =?utf-8?B?MXJVSEpOOTRRQWdNZGZjOEJ0QUVPeHFSakZCeVhRWFcralFER2UwV1Rwc3JN?=
 =?utf-8?B?T1JwRGhydkJsTFdOSGllNGozRUZ4cVQrTGlxTXNXYnh0dGhhVEpZV3ZjOFZr?=
 =?utf-8?B?RldtbHJHVlpoa0QvS3NZblcrN1ZDaHJwZGpiYTcyRE5ReGNIazZhZFlyUUVm?=
 =?utf-8?B?U0p4WHhCYzF5elVCbk1ZaG5oUFJ3bFBoZ2hVU1MrT0FYdjBRUTcyZ0lnd2VB?=
 =?utf-8?B?SnhCRUpLTEwrMElxRHdpRlZLejZTc3NKOTBYVlp0Nm02MkJaRGVtckc2K3RL?=
 =?utf-8?B?NDY3a2hqWWxMY3M1LzRYb01YTURzaDF1ZlJKSEh3VUdPMEVBWjJ4MmhYaWwv?=
 =?utf-8?B?MTZBVjNnVTh2clpzemVIWE9zS1JvajlscDVlVWFOK0RHUUhjL2JhODQ0a1U1?=
 =?utf-8?B?RytyK1k0bXd1QWtCNnduVlZLMERnU2R3ejFsRnBvMjdYTlErZm9GR254N1B1?=
 =?utf-8?B?UHdrVFdhdFJZUEpuMWZVUnFaWlpBV1huTi9CTW1RZVNZeEhaRFpKYjJiaE55?=
 =?utf-8?B?cEhuSkFQYlRxV0Vza3NnSnArQmhRRkNURVNaUEJoaXdub1pKc3lrQW45VEps?=
 =?utf-8?B?ejNUNkNuQlFxbUlsMGc4NWN4SEZ0cWdBQTIvdnl4cXVmOWwrQXkvSC9XM0c0?=
 =?utf-8?B?UzF3VXBGWE4xZ1paSGpFNjQyVmlCV3lKOHE3NlgwSzVkU0Q0WU5zYVJEZXpk?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LilrMWoebjX2tH3RPLCtSzixBcxKDxAItWuWksm0TwSJgZUbODhmT40nmGhNmf4tYSgT3Cl5VtFmrd54dbanMfKJwLOzxGxFsbhtW+l15m2S/uAxxW0DrKFf4zlc6F5s7jqrBmVPugU3W/E+1TGznDOfPxks4CMttFvhRlSF2iWfC5Tbrj/hr1MvX1y8Qs3nWQK4H+N6aw8r4E0zstWwyUUza0E70fzK8gcnLrVsNCTfxkhKENR634ztxzjpOW364Hf/ilZ7fCeMUx07Eq37AAspRRYsTrGuh7sEoYGovcbG5qX7XOC816HbIJWid4NLS/gX+eVqOWDRvsN/a+UaFhDCZ7UKfyd3AIahIUbIrYoCXkuPHnADIjYKSIzBvJaGi5cECUTu05u6LG9iTPTlrN4A+V/1rguLAH2AQiZZqrrekA3tng05yR0ph0SYPjgfobaRq40tMb2KmEVh7Rmo8kJ4A+s5XahxszyrNWBcJCs9sSbMSTFvQdGeQSpgSw73GX0arxQdN3IurH0SKJsIAPvM2wOinMGfE5wdYyvSPUXzeBNaV1aB60d60U/8FtqfWKrhqY52ilcCdNabIy2MA7tZPLPYiD44+pOnDgRhoFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65ef08a-8bb7-46b3-5eba-08dd4d062f4a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:45:11.6441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+DaTp9fOnS1amoVVg8P1VpkAzIQ6u0hVcVAIw8aQiV9W1yOK0m3LjSP8Gaf2Bhm0hXhR2WPrUD+86b/H8GYzFNUIBQ2uoc0ZD35lfjyXnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140107
X-Proofpoint-ORIG-GUID: F4OsdpV10J07F8MGBsmpJR4DXgk5QEEK
X-Proofpoint-GUID: F4OsdpV10J07F8MGBsmpJR4DXgk5QEEK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Michael,

You previously acked "pci: export msix_is_pending" -- thank you!

This patch also needs your attention.

There are no other changes in the core pci area.

- Steve

On 2/14/2025 9:13 AM, Steve Sistare wrote:
> Export msix_is_pending for use by cpr.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/pci/msix.c         | 2 +-
>   include/hw/pci/msix.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 57ec708..c7b40cd 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -71,7 +71,7 @@ static uint8_t *msix_pending_byte(PCIDevice *dev, int vector)
>       return dev->msix_pba + vector / 8;
>   }
>   
> -static int msix_is_pending(PCIDevice *dev, int vector)
> +int msix_is_pending(PCIDevice *dev, unsigned int vector)
>   {
>       return *msix_pending_byte(dev, vector) & msix_pending_mask(vector);
>   }
> diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
> index 0e6f257..11ef945 100644
> --- a/include/hw/pci/msix.h
> +++ b/include/hw/pci/msix.h
> @@ -32,6 +32,7 @@ int msix_present(PCIDevice *dev);
>   bool msix_is_masked(PCIDevice *dev, unsigned vector);
>   void msix_set_pending(PCIDevice *dev, unsigned vector);
>   void msix_clr_pending(PCIDevice *dev, int vector);
> +int msix_is_pending(PCIDevice *dev, unsigned vector);
>   
>   void msix_vector_use(PCIDevice *dev, unsigned vector);
>   void msix_vector_unuse(PCIDevice *dev, unsigned vector);


