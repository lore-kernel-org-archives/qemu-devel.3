Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4123FC36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyQb-00060T-12; Wed, 02 Apr 2025 09:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyQY-000601-GB
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:46:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyQW-000352-KU
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:46:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN138017878;
 Wed, 2 Apr 2025 13:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=6rtxXMswkSxBtIR9yjamn3hM3vlahyo+D7cpgzrLS9g=; b=
 j3IUNvOpesEAQ2z641zo+laTY2S79RE9NgYHkccA/oirYROeqhZw2Zet+V4H8JCz
 69qCHxFfewEohywdh9pYPY8zyF4VNM1qP8N+TWmn7sEpnILjv8oH9Fu3u8NNeMjn
 AjAQ55Y8G7Awu7gP4G/n2epUElIC3Wi5WHu5+vH3KAw9ylUl9qzBbZz4mdakGeb3
 nD+Sox34yavS5ifqz/5VJDTfbK4rvpxyR1/ofhV8t4Kb7y8M2dtSNaprpAUWv2TX
 j7X9jtawPw/4p9UH+RiNZji0VjRED46hKM11b56oDWH6rARuEUP8kTR69QZWFHmj
 uNJ+70ya2o/BW1mjTA3vng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsasfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:46:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532DNLrS017096; Wed, 2 Apr 2025 13:46:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7aapyqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5OuM6xOEyLC9ZOz4x2Sj6BuQgJMAVR+xMLXb7HWHQD+BKWEx6yQUEH/YmXh91Y/uzyIGyf6F3lJJW8o6/A0T2+GgAjAcB+5Ns3+LiFJ0A1lQlby5S5MDbGSnRvj+nZw/4fXK+/nrbJI7V2kxkXZxeQHyHudxmp2JNR0W7ZxR+o2UIAfRWiS3qMmNhvI/CCwYq1Q8FkuqH6SajVUkJh86gPKI9AJ81/nNZCGd5Lc+yCW9S8uBKCM/1omBPMf/aaIgmpWAYzmCpgZwLR36Lo3t0oYFc/mnOrVlYOFNhtpCyzz3TpTHpTA/cApBY3gm/R2Pk83xnHUqaHNtR8elBE57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rtxXMswkSxBtIR9yjamn3hM3vlahyo+D7cpgzrLS9g=;
 b=eHllAdSavML5j5LBYLBZoOX49tMU1EmJ3Bo0Ucy6EkLkjxFOnyoIdS6R+tsZwDul+nIxczdMY1Kg9fCSzSopD6T4E8LQklw45Zf798YCXsua7R1VMv3IyaJC9dmkpv40MSv7mzAQT2KZ+itwURq87hLzM8tAd0XVMQ5tQpc4FD4NrKy+DgEBu68mve5Y0YCsTBHWaiEl354rwq3/w4e3n8NBJvB65//qAkmZPQWKlTVANinRg0VRd4Fwk9G0uhjdMky3MpXkw//9QXIQQ/vduR8IHYAI1hLtZVjbFDomViuA9YhMTkeQPq/VxW0paWyQyY/PD0UWHbuv4zpEDKgK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rtxXMswkSxBtIR9yjamn3hM3vlahyo+D7cpgzrLS9g=;
 b=hQ5ipSztOTzoEtHcqLaA50QyC3Tujpjs2kh3yBp1cbsxtHQjYY+/B1KrTrqj3ddS/JtpsXYYVFYrex1aIhEKnYdi0AnUA/rC0UDa1IIy7EFc1J2q7GV+0Xpc/KXbWLfOcJI6xrpJYcwSTrPjab0YIKEj9PjN+AL5rehkCj4kQYo=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH3PPF5EEF2B425.namprd10.prod.outlook.com (2603:10b6:518:1::7a5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 13:46:39 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:46:39 +0000
Message-ID: <3149dee1-6489-4116-bbd4-d8f60713d275@oracle.com>
Date: Wed, 2 Apr 2025 14:46:34 +0100
Subject: Re: [PATCH for-10.1 v2 27/37] vfio: Make
 vfio_devices_query_dirty_bitmap() static
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-28-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-28-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH3PPF5EEF2B425:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9fafc3-9471-4e47-3e2b-08dd71eccb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVFS2k4YVJ0V1lhWUxwY25mU1ZabnozT3JudERWelVWcnJlWTNFTHlnOXNU?=
 =?utf-8?B?MVQ4dTJHTFhaU21pa0lVOElKRW5LNDBaNFlOd1lpQ2J4UkZqUjQvYk42R1dL?=
 =?utf-8?B?ZTlLRHFpMVYrL1dmd1ZlMmhZemFOZUdha2tsRXdjQVBoUnJuYno2a0w2dGZO?=
 =?utf-8?B?eDVHRitveTJGdnBwcTlncG9HLzlrcDMvalFkbEo1WkhqSVpvRkNNUWlvR2lu?=
 =?utf-8?B?VzVLSTNiZnlKYmJQcVpuM0NncEdhdk5yeC9lb1FYQkN3TlZBNlAvcWJ1M205?=
 =?utf-8?B?NnVKdlJXTjdydG1JVHdhR0laeENtdDY0ZmZoOUdVWFRyTHVPMVIrbDNOMXhQ?=
 =?utf-8?B?WXV6MGNFWWR3TmlOdGtlZHN4YkNxMk92TzhXa3MwUUw0K2o3cjZKb1hKTjNY?=
 =?utf-8?B?UGZmUkdQOFlNemUxZnNWdXR3Q1NCTUlqZHh4ZGlhanVDNVZ0QlNSYXdBK1F5?=
 =?utf-8?B?eGZhSUk1U3Y1elAzNkJWa2F0OHJmWkQvbk9YcWxmeXh1YnZNVUFNSWd6YjZ5?=
 =?utf-8?B?Uks0anM1MWtYVHFCQ3JzNjNMNjJkZXVwcGp6bTEvUGc0bzlpb1hlUVovNE9E?=
 =?utf-8?B?WkxYck94eE12bVRJeEgraEJkaFRXL1F6Y3NkcUdQZkdVdE5PeS82MDdZSU51?=
 =?utf-8?B?ajJEQVJSRTNYTTRkRkxHZ0tNQUdNcy9hK3B0eDdkWVV6ZWZKRjFScURGUUFh?=
 =?utf-8?B?Y0Ftc1NzTFlIS2FJcHJCTkhFQmtnUEFhNG5vemFCVXdkNWVtbzMzYnRYb2k5?=
 =?utf-8?B?RWNNMzN4N0NPT1FhU0JBZytDVHFTVkFxMnNMSXpTWG93NmJvYndGN1p5MkQw?=
 =?utf-8?B?MXFYQkxFOGlZaFdJU0NYUHVtL01JRHpsWUF6VkNzbFdDbnQ1ZVZCMXN2MjNH?=
 =?utf-8?B?RUdoRUFod1ZCelhmV2xiUkN3ZHpraHZQa1pUSE5RMEtSUXlzVTdnbkNZbHRw?=
 =?utf-8?B?Y0NGMmtXZ2JrMWRWSGpibWhuc3VFd1psSGs0WnU4Y3FQVU50bm51ZjdFUDM4?=
 =?utf-8?B?VzdKbGxyRHBTQ05VSDRlZERLckJ3VmNpVlRmN3lUWnc2MXRIV3RLOXFIRkxF?=
 =?utf-8?B?U3RFQzVPVXVrbFJoODJJWlEzTnVpY3Mwdlg1b2l6WXpyNExWVjF1OEFaWmNy?=
 =?utf-8?B?ZjZaVGt1cXJ6SXlURGNpOVo5UjZQMkNjZnY0aENjVDM3andlN0Nrb2RObDBO?=
 =?utf-8?B?OFpUUE9Eby9jaVNydGVnN3RiQ2xjRlVhcGhwc2t4TDZ3S1IwZGw0QzNrU2JY?=
 =?utf-8?B?cUkwUUlSc2tiWkJ3bDF5TTRzUitpajVHb2dhamRVcTlTQWJESUF2SlFMczBq?=
 =?utf-8?B?WEdQT01MeDZkWjErTG4wVXZvM3FQbWZpUGU4VXRpSWVmZkxDYjlCRXZGdFpl?=
 =?utf-8?B?UEVMaHBOTjFLOTBPRnZlOW1vaFAycTFPMitNU3IyUG1wSHpOOE9EaDRWSWwx?=
 =?utf-8?B?djU2dTNDMmJBaVRnYlBmSmpCczBCV2h0U2R3NXJsSVVOTFFjZ1FSM043TUpH?=
 =?utf-8?B?VXk4NUZCV0ZqQUZ1SktrY2pNRGZieHpiTXFDOU1ac1lnSUFONitFMUlkMjVU?=
 =?utf-8?B?c1pRaFprTlU1NEJERklnMEY0U0EveXUwWWVPTmtzdU04RVl5TFRjNTk3VG8x?=
 =?utf-8?B?YmFmQWpKN0ZXd2U5ajVxTzZwdGdyNGRuaGxCWmxtUUxSanMzdVR1KytCOFhF?=
 =?utf-8?B?Yk8zdXFPK1FvWFlSQUQyWXVMd0hKanBaQkM0dXE0NmViM2xGMUpmUytlMkx5?=
 =?utf-8?B?bXo3UU5WVTVRbmdKV2Y3bVJBS1BmRC8rQ0VpTW5WVnZSTlZ4VWIzVzVKOG9n?=
 =?utf-8?B?aThMcGJRYmx5dHJhSTl4Z25GZElsblpra1RKeThMZGtCNkxSci82Q21OYVUv?=
 =?utf-8?Q?7F2wm3ugXh5Tp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXk4V0V4VFduVmE4OEVER3BPUmptaitOWXlyT3c4TVBubEZ2UDRyZDNRaTkw?=
 =?utf-8?B?UUtaT0pZRG85bWxVaUVnRG4vSHJHdy9WMEVja2NyL2hZQ2QxVUJoMmhIRTNw?=
 =?utf-8?B?UW92Wkk2dmFCTThGTnN3NFp1UWdMVXZud1hmazJ3TE42aVZLVXNQbzBQd1ZJ?=
 =?utf-8?B?MnpYdUhRZ3hRNEVOY2FMZVF2bXR3aHU2VktXZ0M4by9ZZnNRRUIyQzB4eFhT?=
 =?utf-8?B?NXF3Qm5xdmFCaGlyQWxQNWFLM0d6V3NVakU3Rkx2c0tUTW8zaXJRS3djMEha?=
 =?utf-8?B?anFQVy90VUhKcnVLaTdUanUvdmdPK0htc3RsNnFIRXEyL1JaL3pla1MwSWh6?=
 =?utf-8?B?cmdPS1dLTXRrN0JSTmg4WXB0VTI0ZnZQaFdqV0ZtLzdrQ2U0ZlV4KzVJeHNV?=
 =?utf-8?B?ZlZibjB6a1NwNTdueWd1OEVzVkdiaXVSdGFKa3ltcUZwbythSkpiSEVnVGd5?=
 =?utf-8?B?d1V0SStpKzlHYWlkWDFuTGprQVZ3Z0JOdTVKY1JibEEyMkFvSmxVeHZBcENX?=
 =?utf-8?B?YzVYSlE3QWE0Rk5YNklwSVN0U2RTT0ozaUpuN3Nta1ZpOUpEVmtoeHZHVWkw?=
 =?utf-8?B?QVRldDNJblZwUkVzQ0RuWG1qYU9adG0weEZxRlMyS3BBYnpDVEpNVTVGTTJB?=
 =?utf-8?B?Z3ZBNmlLN0t2SkVCcktMcWcyd3cvWVhQTi9EWWpvR3BDbFlsMGN6cjhNTUlB?=
 =?utf-8?B?SGNvNlBRYVVTVDd5WU4vZVBpdzdtK1lrbEppWkV0Q3c1R1VEUFZBV2tDQmor?=
 =?utf-8?B?MHZ5V3kxeUpmL3Roa01YcXpMNzhjS0VMOVhkTUFDS2FDMU1BTmJkVVJmQ1h1?=
 =?utf-8?B?SUpDLzRuK3orblNhR29wZko2UlNRK08yQmw0Zm5ZUDlFaVYyWUJCWWZQZldI?=
 =?utf-8?B?VEhRSUN0aG5UcU1SU2gvK2NlbDNOeDBHS1B5dFFyWnBjWE1tcTh3R1Evc2RY?=
 =?utf-8?B?dE14c0JiTnhvRUtFajUxT3p2TGpQWG92cVV2dUlsV3IxVWNPUFJhRFF0czZX?=
 =?utf-8?B?dFp1Sjd0OGREWXc2V3J5THl0UDdsOTBqWUdNV21RSDRORUROMmphUUhuU2tx?=
 =?utf-8?B?SUNFUWJvSFk4Wm1PUXp2TGFVNmpTYmNpRC92VWZQSTlBdXpCblhpUi9IL09P?=
 =?utf-8?B?VEZBNk5NRkE2TmJENG4zZ0s1TTBKYSt6dlBwY3FYZzlFVjdvKzhYVVIwNFJ4?=
 =?utf-8?B?VnROa28vR3RrMi80TGVPK1RDYXFOMmdBcVIrbXloVmdKYzJiQm40dG50ZUFH?=
 =?utf-8?B?a2ZVMkhoSkxuUFVBVnZLK082dkVqTGdNeFY3ZzN4VlRuMzRRYVdsby9vQjEy?=
 =?utf-8?B?c3dxNVNCMmlPKy9zQnpaTXF1T1FMUVZnQk94L0JQajlTcUJCd0RVbGpaUzRX?=
 =?utf-8?B?S2xQUFhuemZkVmQrWU5XN3phSjB1am50Z0p4UEl4VENiMTc0R2hkRGZvWStE?=
 =?utf-8?B?NnE3RmsvN21JWGhUUmE5RzNHcENNQkNXSEJmaWZNYVZiY2hLQ0tMZ3plRTV5?=
 =?utf-8?B?UGVpVXRuaFJCazVYUWVYaXJJck5sT1F0bjFSNWNxQTlqQStnRVNobHZJVFFr?=
 =?utf-8?B?UG1KSjJWdnJlMDA4ZW12K2l4NG9qQnphM3YzemhOTnB4ZGtOVHN0dE95TWpW?=
 =?utf-8?B?a0ZvZVNCa1Mrd2dMaXd5YWdDdEVjTkR5dFFNeFdPQnVPV3cwTXc3cUM5bjVu?=
 =?utf-8?B?clBpamUwaWNyMWVhTDhITUttQ1c0RE93UC9WNFdtS3ZINGh4NVg3V2FzYUgw?=
 =?utf-8?B?RTZ0R0NZUW1kRzNKZVJiaUtVVy85clFlaTJ4WEl5WVpWMG5ybDdqTGRKTTlr?=
 =?utf-8?B?ODBlMXJTNzV6Z3FvZjdvZDRLdGNVVC9aWU5EVVZKM1NZcXRLYjZ0SnJ4bVFQ?=
 =?utf-8?B?OER2L0tpZFJ4aGZ5SEhTanhCdkg2Q3JTaXFiN3FJUmJ2ZE5CajN5NGtyWGxR?=
 =?utf-8?B?Rk1xUTRVdWxjUlNzYzRwMTZmV213bDN3WEltS1FzRDdOakZrQTduR21hNVdj?=
 =?utf-8?B?WmREUW5VSldWdEF2VFJTUzE5a05tRUh1RjNIZkJyalJ6RG96QzJJUkVWNUt1?=
 =?utf-8?B?OVFIYVhxSWNjSzBRSjRzOUJtUVFtZWE2akk5WkhZYkFWL3N4V1FicjFkeFpL?=
 =?utf-8?B?UnNtdHhzQXRsWUxpV0o1WTNFZHQrYTVEZ0QveVh6YXI3Mm9KZE9HLzVlSEJV?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TmABWT6kNbfnrFUhP4v/qwUJTX2o49s871pelpgcjJNwPxHiCRzPJOOEmXOeHKPkfy+6mHMcKcU/LTg3nNmU8vJd+HxF1YuKZBXoV6saJMH5Ts5ojqRhbU3pM7cAj43lkdOocKSYfV3TIzCLvJ/ogXG4COwTfV3Dfd3lifQlH8PL2lxabDNzotYCUbf5OEK53IBntoyCcgxTFdvNt5dhC63e8BcB4OrUgUhPvVOSJWOwEwmhvYAVEQMzFyRcKgjnnBv3RE9kcasFi8HXhPQ7WrPVcvW/0t2EFEbfCx+ldQECMVxddNbW42E4eQi5rKx7t1x64o2/ixaWrsYdjhrwPXq3W0F8SVDvk8WQqq7YtWQnYvCfmuaJvuhwYMtpHreP1Crv2Ff81A6tuam85HPEPLNqipYH4StRZ9KnICeAKxGbhW86Cgyf4D6/U5uzSpRhVS+rLrJSZ4T8cw2Mq+jmJGmi29ujAfK/ltFoQYvYZjzptEh5DV7EicHXBcXK6R4FYcmL2knxRxgZNP4L99Npd8jfvOscGW9Jl1yxKMpgDfny9hzJODGyLT6oyFOFuqFPBvUPDMJf7B3TediFdfiPLkPn/52TawJXV2Y3GjDI7hc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9fafc3-9471-4e47-3e2b-08dd71eccb40
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:46:39.5547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8yt1Z0I2WSpTF07ygm5Un3EtXK+6bhFEnnobJodchqKe3ts7tVAVTTwAm2UoYJjLv94cKM1AZfEHlOIbXl3VCS0hgCw6JkyQw0Zmarv2As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5EEF2B425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020087
X-Proofpoint-ORIG-GUID: -jTD3qdAIBbVLikMzNMjqABKNa-PO8Du
X-Proofpoint-GUID: -jTD3qdAIBbVLikMzNMjqABKNa-PO8Du
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> vfio_devices_query_dirty_bitmap() is only used in "container-base.c".
> Also, rename to vfio_container_devices_query_dirty_bitmap() to reflect
> with the prefix 'vfio_container_devices_' that it simply loops over
> the container's device list.
> 
> This rename also frees the vfio_devices_query_dirty_bitmap() name
> which we will reuse in the next changes.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-container-base.h | 3 ---
>  hw/vfio/container-base.c              | 6 +++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 8575cdcb587dfe803808d452c7dc6c81241a47cf..1227771dd896b5917366ef578109b0ad92da2375 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -93,9 +93,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>  bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
>  bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> -                                    Error **errp);
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 2844c5325efffade43022bfb517a43ac372c4125..4edbd39185375dee42ee6e6410da7b94635b5ab8 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -214,7 +214,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>      return 0;
>  }
>  
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>  {
>      VFIODevice *vbasedev;
> @@ -260,8 +260,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>      }
>  
>      if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> -                                              errp);
> +        ret = vfio_container_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                        errp);
>      } else {
>          ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>                                                  errp);


