Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FB1CF0427
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHOS-0005nH-5j; Tue, 08 Oct 2024 17:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syHOQ-0005lI-HC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:05:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syHOO-0007dD-Bj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:05:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Jtasp004859;
 Tue, 8 Oct 2024 21:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=NHAkSiUcgcZ1hevyQFXf4YuWcXzPIvlT8iNRpPPhbpM=; b=
 gEAQla4fKn5vTCoJTOGMu/mpX86o1HtheKSa9vRCaPQSprEXp0cKkka87D89WFnq
 KqXbKPPQ2IMUK1kjKBSBWifymBoF+X6G+QQQ7EGivbdiYtFvSSV0fFKy9DZZVAsy
 K40qe8ZMMyg6ZZSJSlkjM+AbfKVB52ggQVdNOFNeO0o2FADG4LiaNaApo35hcyWz
 O6gkqCgVTRkt6wmXuB8sogr9r+oARDD+BQ4qA0fV+sdn/FO9zQYGiZUDC2HBbnuw
 lea5V1nr4Pzyx8ddAeagedXi6V6YjKNJ4OwROdyLmrRZx+y7Sc0PTa0NIEdth+0r
 62gaAkoXPP5XaKTv+g5+Nw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv6v87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 21:05:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498L0hsk022865; Tue, 8 Oct 2024 21:05:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7qkd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 21:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou2pNY4Hc4kVKRF0pXvQx6cAdQmqU9kjNUb/MYA93udo3ksbu8bw4di9VjPWhnXINYkOUKYJDvTy3Vg35blB52FUf1/FjxRFu5CiWlQgXVIvFYVUpk3LZeUWBWo84w6kHmktURmIp1cFjdIvLS3CYa8HiDDr6T6G9M6z7DAB/bcPtBu4xjt84w/osw4ndIq2QHydHQgSvEpt1yxHQ/1cssCJ5c07Z0zVcf7u25CMz57OsM3jmNg/AyGOlv4+ufBOJdVBoFHtSo9DYJzmiLWXehkuXMN5J/amkBxmq1VopFJV+XFlw0K4qImfp/A/ahUZ1Evpf/178pbpAVjGAaXaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHAkSiUcgcZ1hevyQFXf4YuWcXzPIvlT8iNRpPPhbpM=;
 b=cnYVfEZO3pkPmNW8fNQRKvt+A911k4yyke8jT/IE08G9M0nY69qR+spvi15bwPEH+8QQO0MPd5PHvlPbIQZQKMi7ExHTELm/7fpd7orVXRihArxGvWVa6Nfnhi3SAqi/1GEcjYJw66BhAuT9BT97ewnKvyhc7wUf/UKNfE8/5Mp8vdbXUxkzzUTtmrY/dB3C8ez67EIZ2GrrEuQK4WuObC5lWK0cBSQHLp7LWvWaN4/D4v9fkOVaTY4i60fkRNBH349j1uLtcej8rlor5EjfUreju+7xv1B5hefonbsQN2r+tc9HmgYRxPMwra91fwIPh7L8K5FJV6qCJRUUNmjS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHAkSiUcgcZ1hevyQFXf4YuWcXzPIvlT8iNRpPPhbpM=;
 b=vhN/bc7kfclJRaxfQ3c48qNNnz4YC1YBiesB0pr4/nWaXyxj/10S9qa6mB6QsppzrRpRtF5oKkdvyIQ87SnHmSRtu9v47wDF4vFw7QSKNgx1R9x5uBHW+TFnAGI0eOoDn4Iwpjp1l29vPWD8NtHKEs86r1tisYhRydYL+mTt4m8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 21:05:08 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 21:05:08 +0000
Message-ID: <22321990-d30d-4ab7-8c3b-f2baea662d7c@oracle.com>
Date: Tue, 8 Oct 2024 17:05:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/13] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
 <ZwQDBc-8niK2A0Vt@x1n> <ZwQMRlSSqP0i0ITb@x1n>
 <025423a6-8cf8-4300-91f2-13be32ec2c5c@oracle.com> <ZwVdGZtmZ27tX6gS@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwVdGZtmZ27tX6gS@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: f2feba27-dba8-400d-ddd0-08dce7dce3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3BmalhWMjBrVFlvU3JObHBscXkvUHpKSWJ1TmFIOS8xSjROZ3R0ekdUWmtC?=
 =?utf-8?B?TGdZTFRJYWF3cFZVZFFvSjAwcW1sOEJkSjlIUVdjbkhGT3c0cGlMNjZlVWdJ?=
 =?utf-8?B?bEpmd1IvZm90VGRvRHlncnd3cmFiQjN1Zk5VVVVlMDh2Mmg4T3cyUTA4Wm5R?=
 =?utf-8?B?UGFZT2JQUnNqdGlQL1NVVHUzczRIM0dHUStPR2h6SGVCM01nRmVzanRKS3Z1?=
 =?utf-8?B?Z0ppZGVpZlg0YXpLcFNFTlVIS0cwd1Jza0ZxZUs2bzNZSDg3VVFhbVZ3SnZL?=
 =?utf-8?B?azVtYm5BMXVOaDZHNlc5VDN2TEdqU0szRk9xVVdyWmNiOVlvLzBmOGYvbnZE?=
 =?utf-8?B?Qy9EZGZOekRzbjkrOEFidEZQTWp5M2tld0NzbXBsR0xLbFNVOTNSVHJubjgy?=
 =?utf-8?B?VTQ1UmR5ZGNQaE9XaExoYlk4U1EzOFdiVmJUUmlUakZnb2EvTk5XaU1rVTBT?=
 =?utf-8?B?U0pmVWRsUm5UZTdXcHlrMXc3bnpHajZuMGVDM3Vjd091MVgrbVFJODZndHhy?=
 =?utf-8?B?WWQ1MkVBa3p0VDFtU1J3aWV5ZG16TXIxV1ptdHFyU1VDRjdlOGdxMTljSzhE?=
 =?utf-8?B?bGsvUTBua2ZwRVJURkRUNWhYQlJnblFNdE1HZENpdnpsYldtSS9aMU90Ym5S?=
 =?utf-8?B?UStmU25nRDlXQXRHM1lOUVZjbTdZSmc1S1crVHBwemRHTDVudGdXaVZJUmlw?=
 =?utf-8?B?TlEzdFRsTlNRQ2FVbTh4SjJzbHpFT24xK3dabVdaTjltcWJhVXE5TTZyQlYy?=
 =?utf-8?B?K3BhVmxHTnpWVGVhaFArcmppTCtCWUJiOUlPMSt6OXd2RzEvUklMelVFUUF3?=
 =?utf-8?B?dW92cnZ0QkhJdHE2eCtTMitDSWxsV0tTenRkdGJiRHBUbmExYmllaVU3NVIx?=
 =?utf-8?B?TWFLSmpuK1dQdThiTS8vUXJaYXVCSW8vcml0VFN3M2Q0b0wreTM4S2ZUSVNU?=
 =?utf-8?B?dGp6OC83a2pBR3lFcEt6YUxnaS8xdjdkWU9LTjd1RHR5WGFudXJ2ZUxyRnZY?=
 =?utf-8?B?YlNydTdkZVdxMnd6dEt1ZS90aFN3Slg3enRabkVWc1lTalVRZ21SbmMwbnMy?=
 =?utf-8?B?N3lIOWltZTd2T2dzZ1pDTE5RZ3MzRFpPU3ZEZzc3Z2I3ZGhjdDZXT0VFUFpz?=
 =?utf-8?B?SGNRNU4wSGlYdzBXMHpmN0ZqUDdzREFINTdKSExVak9SUDl3ejEzS21JYWRO?=
 =?utf-8?B?Q04yN0JMMlZ1UndCUEZyWERzZkJpNmlsbitPMGlzQkEvRkhXQmsxN0hvMzU0?=
 =?utf-8?B?OE9zUSt2R2p3M0M4SysveCtpTVFseDFJVkxJQitmaDkveEwrc2U3R1B0RnZ2?=
 =?utf-8?B?Z3RHSjNwVnM0TkV2VjNMSG5KeUtsMG95UFhpOWh1OENoWmpsRy9kekg3bGhO?=
 =?utf-8?B?UXVjMm5VVW05VmloajhKSjR2K0JvZ29NWTFtNTNQVmZBUzErdyt5QlE1SUpF?=
 =?utf-8?B?RTduU1Q1U3BNVnA5ZlFTdXN4U3RvR1Q2RVBtNWZxc1V1U1NPVHh1Yk5OUGlG?=
 =?utf-8?B?VWNYMzBFTUppTDl3bzl0Skx4a1lsRWsra1h6YzI4dnprMVdpN0pZcFFObXpJ?=
 =?utf-8?B?RmVCREpsUFlOYlVHOFh1UTZvbzJWMDM0SUN0VXcrTGRoVVhvZkxyMDEzNXlh?=
 =?utf-8?B?T3FNM0taSkc5aW1VVDV1eEIwUGlhTUZOcWVia2d6dm50ai8waVhOT0hlYjhT?=
 =?utf-8?B?TnNzMWJsWHR1U0JlMHBZSFI4M25rK1Rsdno5UTY1aEVjdy9PT00ydi9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUk3OURaRW9hV0s4MGlZbUJqeUxIcHNMZllBMDRsdTJ6VVJaemRZd0ZkMktm?=
 =?utf-8?B?WkV3bHp6ZEdhQzdvS3dZa1RmeXVuRGtoZUxwQlpGcFl4MlRIWGtzU0Z2endD?=
 =?utf-8?B?K2xYN1dma2tUcEMraENEcDViVFFMRmdReHVuTWRXSjhjRm4vR3VQUkFpN3Rx?=
 =?utf-8?B?L25ranFrMjJWMU82SjJjZy8wQmo2UUVQNFo2NnZTaWcyL3RWY3BmNjZOUDJt?=
 =?utf-8?B?Zm5RS0s5VzdvamdybWhhNmpoY2ZUTXYzM0lJZk5MRW9ESkgrYTU0VnhHMVFq?=
 =?utf-8?B?QTk1SGNzRHBQdmtudVo3UXpVTkl6U0NmaUtVR09uRWIvLzUzZGdFcFdibVJX?=
 =?utf-8?B?QUZaZFBLaU5BOWhXNEh4TlFubzBVSkIyajJibmh1eTFLSjl3azE4bmlvYmJR?=
 =?utf-8?B?MkRHb3lCN05ycVFEdFJ6amFEVVRuVnZLdVhoSXlvZWNTVm1zamNMNmtqNlFS?=
 =?utf-8?B?UmN3dmgrK2QxK05HN3l2VW5TNVVVOVZwMTV2WkxGL1lyTlRkUXN2ME1NeTlt?=
 =?utf-8?B?eDNRUUxUb3pUSjVoQjB1RjZvMTNZbjFycjYvdkpDUGN1cHNmVXA1R25LcTdZ?=
 =?utf-8?B?Q0FmUW9FYmJVM2dZZ3BmWHU0OWxra2dzNWswRWtDeEhpMmszQ1F3RDREVHJL?=
 =?utf-8?B?VGZmU2JkQWhKMWFYNUI3UnVYMjV6RzBUSGJtVVlGQk1RdDNNdi9zVUNIcHlG?=
 =?utf-8?B?cXBwL1BsbnhkMmZzN0QwUUxtWThMWklDVlA1TWlORjJWM0hqVVYvSmVmcStD?=
 =?utf-8?B?blY3bFZsNlBwQ1kwTmFwWUtpcG1GVGEwRnJodGdEMFdlcFprTllRMHhWYlI3?=
 =?utf-8?B?NWxQT09jblZTa2wrbUc1bHZWbldXRjVEbkdqazlDSzV2QWFwZjZPamVSOEd6?=
 =?utf-8?B?SzByeU5iRHE2Q2NGOEJObUlGSHRzS2pRUnFNY3BZSnVXQnlnai8xeWlPNitF?=
 =?utf-8?B?SDBmS1VFWmhBMktLRGhCbDZZSEtxUUlQVEo4WlRJcm9zbjZhTGVkeC96Y25J?=
 =?utf-8?B?RmxXVkdJS0JzcEVBOCtOWDZFMFVadlltQW9QR3cwZ29saEw2SWlNaUY4Ujdv?=
 =?utf-8?B?T3RXSUp6NDlFdUJyT0duNlZSNDlGRzYxc3RYZSs3Lzh1eGJpVzY5YU9WOVZT?=
 =?utf-8?B?T0FJUTVkQjBnRzRvMXVrTGhqc2VrRVhpbWhhTU5ZL0pvSjZaSmlRd2dVaUhB?=
 =?utf-8?B?WmlPak5VMEJNSUp5K0k0ZlBFZVJQQm1EVklEWnM1TER5Yk9HcW5BRS9tQlQv?=
 =?utf-8?B?V1pGWmh3cGhYSk43aHJ4anhNTlkrNW1sK2tBQkpMcVV4WWh6d0o2SytDa0lF?=
 =?utf-8?B?ZGgxL1kyWDRuL3pRVE1qNkpFS1Bad2xvcjZka1RBVWpYME1QZ3hXcmIzVUNO?=
 =?utf-8?B?NUxYMnpUdkJ4R1dCb0VuYW1Ma2NQNld1QUpsMmZSeEZVMzBGcnhLNGtrQWF1?=
 =?utf-8?B?N3pkSjE4ank5bWNUd3A0aFAyQXo5c3dBbE5BTjR6NU1IN3FvbGpzK3BpQjRp?=
 =?utf-8?B?REtGOFY0SCs4by9VMFBBQmZEVERWU3RkS0RGOTN5cFZsUmlFY0RuMjM0UzhX?=
 =?utf-8?B?QUJLc080VUY5TVJ6V0R4TjlNemlGdFVJVy91V25wcVNiaStpWGpOQWdVTDZa?=
 =?utf-8?B?eTNNREVsYWRsVUY5YnFIcHM5S1lud2IyaG1vRkFtY2FWUzA1cTI3WWcwbmd0?=
 =?utf-8?B?c2UvTEZFdVFKSlN3VmFWd20zRDM2dlpwelExV3BKQkVTckVhaHRLZFNwZE1T?=
 =?utf-8?B?SWxrbm9iSkJOR25MeVBEcUw3ay92bnh6a29ldlJ3K1NmRXBvN1M3V3pZc0Ew?=
 =?utf-8?B?RTQ5T3BPRWhBOXNTMkI0QlZOOE1qNDBRUTdobHNpem1qOUxqY3d1QUhhOUdZ?=
 =?utf-8?B?SE00QVkxMUNQT1Y3ZW9XdnVMMUx0M1dmQTltaURWQ2I4aWxOaW1UNXZmRG5t?=
 =?utf-8?B?NGR2KzkxT3VEdGZFS1BVVFlNdytFQ0JxTjRPL0VjaEpQZStvUWJDdW1sNEVG?=
 =?utf-8?B?Um5WTUlxOVBXekhpZkZwazJ2YkUzdmVIZTRRVldwRUVxRHFYaitVYU5iSm0r?=
 =?utf-8?B?RWVNbXRsRlF6VkljTGdlMTlTNEkyZitMMmU4NkZCaCtkZmFoblpIUFpTU0xG?=
 =?utf-8?B?U1dnNWlRTDlVQW1rQ3Y0TzBJSDNvcndSdjExN1lqV081d3cvQm8xUG5OMWoz?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: toDxUWiIfk4gIcUAo0UhGPr9p3Hgd/nJs2p3ALyFVAyeQCmMIRUyxkcbwIg/OsL7RBhVZrX8XKz7hMqZNa/kJbb1Ealrt2E1IrrEYgKCUsWBGPsa40Xh9vLuJ8tJR0QIWFPolhai9gcIqyGMeYmLw/2BeOeVTI34iTVbjcI1MLm+1h5VM2kccyEJCQO070wrVqSfHZ77+gZyDCivyOGqk4l2mTadI2yyhtNORWCHFWlUwAoQEW6443RQ0ksUoxwLvgQDgjc1L8XXyPKY8Fk7xzs+tbymxR0QxXcLIaFRb6UyTpKOjz1bTQC0soBSamdFYikPuxOOoPbnuTvD3xFIriDDAmhy+4XGLJ/gYJ0U+4wY+xftkxeCjl8i0Xfnv4mToFyxuDrABm7YpWm0jA61nev3Z0xgbQ28DLBWbIFfKfjSkBKJD5/pqEV+LEjW9x9MneYsXmcpUHTXfgSZXGtT36dkBBDc1jNmMcLRXv70oMYkxAlyjoRBZI4NgFwuFCaoPT02W/XWZVEurTTVeoNX4YDYiudVaobUIwjEUG6ZeWQle3Undv4ZukrzpcVMDH8Y2V2Fq8fuctt1mP3G51AbLUiGLbrrb6NdzKrngxB6oUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2feba27-dba8-400d-ddd0-08dce7dce3b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:05:08.1118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvU9tZ71DnvadKCGYfeou7s8BJJlDM2WyvEZKcCT5cdn1vtx9JmNdcZJu3NA23nCGhe+IE4LJij09sFho3JbdxQsHGoHOOkqaGiCQhW4ry4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_21,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080136
X-Proofpoint-GUID: ogTWrz8YjnJZEMHPvSGGJiTs149KckD6
X-Proofpoint-ORIG-GUID: ogTWrz8YjnJZEMHPvSGGJiTs149KckD6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 10/8/2024 12:26 PM, Peter Xu wrote:
> On Tue, Oct 08, 2024 at 11:17:46AM -0400, Steven Sistare wrote:
>> On 10/7/2024 12:28 PM, Peter Xu wrote:
>>> On Mon, Oct 07, 2024 at 11:49:25AM -0400, Peter Xu wrote:
>>>> On Mon, Sep 30, 2024 at 12:40:36PM -0700, Steve Sistare wrote:
>>>>> Save the memfd for anonymous ramblocks in CPR state, along with a name
>>>>> that uniquely identifies it.  The block's idstr is not yet set, so it
>>>>> cannot be used for this purpose.  Find the saved memfd in new QEMU when
>>>>> creating a block.  QEMU hard-codes the length of some internally-created
>>>>> blocks, so to guard against that length changing, use lseek to get the
>>>>> actual length of an incoming memfd.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>    system/physmem.c | 25 ++++++++++++++++++++++++-
>>>>>    1 file changed, 24 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>>> index 174f7e0..ddbeec9 100644
>>>>> --- a/system/physmem.c
>>>>> +++ b/system/physmem.c
>>>>> @@ -72,6 +72,7 @@
>>>>>    #include "qapi/qapi-types-migration.h"
>>>>>    #include "migration/options.h"
>>>>> +#include "migration/cpr.h"
>>>>>    #include "migration/vmstate.h"
>>>>>    #include "qemu/range.h"
>>>>> @@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>>>        }
>>>>>    }
>>>>> +static char *cpr_name(RAMBlock *block)
>>>>> +{
>>>>> +    MemoryRegion *mr = block->mr;
>>>>> +    const char *mr_name = memory_region_name(mr);
>>>>> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
>>>>> +
>>>>> +    if (id) {
>>>>> +        return g_strdup_printf("%s/%s", id, mr_name);
>>>>> +    } else {
>>>>> +        return g_strdup(mr_name);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>    size_t qemu_ram_pagesize(RAMBlock *rb)
>>>>>    {
>>>>>        return rb->page_size;
>>>>> @@ -1858,14 +1872,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>>>                                            TYPE_MEMORY_BACKEND)) {
>>>>>                size_t max_length = new_block->max_length;
>>>>>                MemoryRegion *mr = new_block->mr;
>>>>> -            const char *name = memory_region_name(mr);
>>>>> +            g_autofree char *name = cpr_name(new_block);
>>>>>                new_block->mr->align = QEMU_VMALLOC_ALIGN;
>>>>>                new_block->flags |= RAM_SHARED;
>>>>> +            new_block->fd = cpr_find_fd(name, 0);
>>>>>                if (new_block->fd == -1) {
>>>>>                    new_block->fd = qemu_memfd_create(name, max_length + mr->align,
>>>>>                                                      0, 0, 0, errp);
>>>>> +                cpr_save_fd(name, 0, new_block->fd);
>>>>> +            } else {
>>>>> +                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);
>>>>
>>>> So this can overwrite the max_length that the caller specified..
>>>>
>>>> I remember we used to have some tricks on specifying different max_length
>>>> for ROMs on dest QEMU (on which, qemu firmwares also upgraded on the dest
>>>> host so the size can be bigger than src qemu's old ramblocks), so that the
>>>> MR is always large enough to reload even the new firmwares, while migration
>>>> only migrates the smaller size (used_length) so it's fine as we keep the
>>>> extra sizes empty. I think that can relevant to the qemu_ram_resize() call
>>>> of parse_ramblock().
>>
>> Yes, resizable ram block for firmware blob is the only case I know of where
>> the length changed in the past.  If a length changes in the future, we will
>> need to detect and accommodate that change here, and I believe the fix will
>> be to simply use the actual length, as per the code above.  But if you prefer,
>> for now I can check for length change and return an error. New qemu will fail
>> to start, and old qemu will recover.
>>
>>>> The reload will not happen until some point, perhaps system resets.  I
>>>> wonder whether that is an issue in this case.
>>
>> Firmware is only generated once, via this path on x86:
>>    qmp_x_exit_preconfig
>>      qemu_machine_creation_done
>>        qdev_machine_creation_done
>>          pc_machine_done
>>            acpi_setup
>>              acpi_add_rom_blob
>>                rom_add_blob
>>                  rom_set_mr
>>
>> After a system reset, the ramblock contents from memory are used as-is.
>>
>>> PS: If this is needed by CPR-transfer only because mmap() later can fail
>>> due to a bigger max_length,
>>
>> That is the reason.  IMO adjusting max_length is more robust than fiddling
>> with truncate and pretending that max_length is larger, when qemu will never
>> be able to use the phantom space up to max_length.
> 
> I thought it was not pretending, but the ROM region might be resized after
> a system reset?  I worry that your change here can violate with such
> resizing later, so that qemu_ram_resize() can potentially fail after (1)
> CPR-transfer upgrades completes, then follow with (2) a system reset.
> 
> We can observe such resizing kick off in every reboot, like:
> 
> (gdb) bt
> #0  qemu_ram_resize
> #1  0x00005602b623b740 in memory_region_ram_resize
> #2  0x00005602b60f5580 in acpi_ram_update
> #3  0x00005602b60f5667 in acpi_build_update
> #4  0x00005602b5e1028b in fw_cfg_select
> #5  0x00005602b5e105af in fw_cfg_dma_transfer
> #6  0x00005602b5e109a8 in fw_cfg_dma_mem_write
> #7  0x00005602b62352ec in memory_region_write_accessor
> #8  0x00005602b62355e6 in access_with_adjusted_size
> #9  0x00005602b6238de8 in memory_region_dispatch_write
> #10 0x00005602b62488c5 in flatview_write_continue_step
> #11 0x00005602b6248997 in flatview_write_continue
> #12 0x00005602b6248abf in flatview_write
> #13 0x00005602b6248f39 in address_space_write
> #14 0x00005602b6248fb1 in address_space_rw
> #15 0x00005602b62a5d86 in kvm_handle_io
> #16 0x00005602b62a6cb2 in kvm_cpu_exec
> #17 0x00005602b62aa37a in kvm_vcpu_thread_fn
> #18 0x00005602b655da57 in qemu_thread_start
> #19 0x00007f120224a1b7 in start_thread
> #20 0x00007f12022cc39c in clone3
> 
> Specifically, see this code clip:
> 
> acpi_ram_update():
>      memory_region_ram_resize(mr, size, &error_abort);
>      memcpy(memory_region_get_ram_ptr(mr), data->data, size);
> 
> Per my understanding, what it does is during the reset the ROM ramblock
> will resize to the new size (normally, only larger, in my memory there used
> to have a ROM grew from 256K->512K, or something like that), then the
> memcpy() injects the latest firmware that it pre-loaded into mem.
> 
> So after such system reset, QEMU might start to see new ROM code loaded
> here (not the one that got migrated anymore, which will only match the
> version installed on src QEMU).  Here the problem is the new firmware can
> be larger, so I _think_ we need to make sure max_length is not modified by
> CPR to allow resizing happen here, while if we use truncate=true here it
> should just work in all cases.
> 
> I think it could be verified with an old QEMU running with old ROM files
> (which is smaller), then CPR migrate to a new QEMU running new ROM files
> (which is larger), then reboot to see whether that new QEMU crash.  Maybe
> we can emulate that with "romfile=XXX" parameter.
> 
> I am not fluent with ROM/firmware code, but please double check..

Thank you for the detailed analysis, I was completely wrong on this one :(

I also keep forgetting that ftruncate can grow as well as shrink a file.
I agree that preserving the dest qemu max_length, and using ftruncate, is the
correct solution, as long as dest max_length >= source max_length.

However, IMO the extra memory created by ftruncate also needs to be pinned for DMA.
We disagreed on exactly what blocks needs to be pinned in previous discussions,
and to save time I would rather not re-open that debate right now.  Instead, I propose
to simply require that max_length does not change, and return an error if it does.
If it changes in some future qemu, we can reopen the discussion.

- Steve


