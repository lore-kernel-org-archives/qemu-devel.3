Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AD0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpFk-0005uJ-Dj; Thu, 11 Jul 2024 04:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRpFj-0005tR-5l
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:34:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRpFg-0003d0-Dh
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:34:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tdal006762;
 Thu, 11 Jul 2024 08:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=WyMDmC7e2PDJAMsK9bayp9pJ7TV4pEIeQ+m0bFT1g5Q=; b=
 LYDNOygB+iZnQtzRqhzZGq9JI5nS0y8POqHm+rXs0SNJhXlgiPf4iU0nR9RljnSv
 MW5qPSJYFptyXNVpSxxLsrpkkC98/sG4y0VNDcE8Oim2MBsnopueEn2CL1hdQPxD
 EQ+HBiYVHkgpYAVrZfqI2rNHmAY6uUOabOKE8svgAWRRbeemZJjJxzDmaUDnl/ki
 gK2g/iUuXOsApKgpRZ+SRYv77c2rhxp3yD0IZnxOQ2Fdj9YAbVUl/g50X4aYXu/I
 PewDkWL/Ia0fUR333MW4anXit3NtIMl8S2JS44s8ARvTFSXlnbbXk3K/q3ZBTlVc
 mqSloEPKWaPcQzaDvjIyiA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq148g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2024 08:34:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46B8E9ie008728; Thu, 11 Jul 2024 08:34:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv47k5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2024 08:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGHb+bKMxGxxbAHRJ8hFISmH8uOLSFA4vjBUVgd0nSoxHECb8hB7uw/azHl0eCUkyKLAGze9FJetbDMT1qhjB8OiFKqxb80Siffby6Reh0NzX/fqy2oWVTYo1KCqkKFTGK3XUu5qvnLDhUDMn7/jnJuK1WwyRTHXLPYmK+JVCJeSIh23O+tsR9VX0vk1NK0cdy9OCic9i83r8gN37MANBM5R7LScM0/PIMWB3sN6t91kbPORsWxXWqjb345ak0NcN/Qjh9LJxXKQuxC27JY+4pfAyVDMglbsclTMEHfohFhTB6xjRUHkmAYBzVCtMsbtBogmuENB+3ueZBENIMYz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyMDmC7e2PDJAMsK9bayp9pJ7TV4pEIeQ+m0bFT1g5Q=;
 b=Cl6HTlbAvfzV5JKWQKsE/liIgX+xOJEQ33DyJv0DhZ/6qE8p04j1s7OgTHhpKAwPFGHTIoON0D/NnkTi4crX8xqCvaCn6Jh2+cX6T6CuSL/ez7dkiv0DRiwSECJXand5F3hYUf9zNJ2VNTAu+9Id2osuq3Pnx0Ky0/7cSrzPNYYSpoyacPjoEeTJTn4B4XA0vwZf0Ru5PpcGKRYrktbYXM8WqvX4wqo9bZp71U0OJwyP/DwXhtUWknF68PuVS9Wndx3YA90wdTbGFxJZbkc0kme1W7UN4yNB7jDz3c2LCbkES6VkaSpPrpQrEl7GplKLUl45i9F5x0pvhqPWYYitAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyMDmC7e2PDJAMsK9bayp9pJ7TV4pEIeQ+m0bFT1g5Q=;
 b=LzI4Cbu56kjiJ39BXAfptm5q1mPu/CYbeZTGOZht0pkCEikWI1vfJuZFUMYH6dselCj9bRzdBga+UoPaWY0CLgy6722n7JeIPknfaN2yIQ3ANIPQDwzibhZ1oH+5auW7I7VCt2Tjk7XA8fu4rtr0eWLOBCUbdZJF15qvXNQXWVg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB7343.namprd10.prod.outlook.com (2603:10b6:8:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:34:00 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 08:34:00 +0000
Message-ID: <62aa04db-35e2-45dc-af0e-aea3acc332aa@oracle.com>
Date: Thu, 11 Jul 2024 09:33:54 +0100
Subject: Re: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <bf7bbf89-2930-42d0-9a3e-edff8e6c496d@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <bf7bbf89-2930-42d0-9a3e-edff8e6c496d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::22) To SJ0PR10MB5891.namprd10.prod.outlook.com
 (2603:10b6:a03:425::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4d772c-91f3-4b03-18ee-08dca1843602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkluQUdrTU9IWHdsTG5oNjM5SkRQNUd5a3R5Q0hQcVhucjJSL1UrSStDWlk5?=
 =?utf-8?B?bUFNOXRhS09ud1hMMTNmVGFwNWswc29ObXNUMjR5Tm5yb0hyZFFaVXJib3pL?=
 =?utf-8?B?cDlxeHZHTk5TV1Rpb29TK0FaUzYrNDVqc05jaGJvaGt3cC9zOTU3WGdRWnds?=
 =?utf-8?B?aFVkcHB3OVRVM0NrQUQxU21TYlZ3NFltRitLMUMwcGdjVmhBSGl4TGg3dnhX?=
 =?utf-8?B?Tlk2b0hjV2lBTEU1YWhqUEdjM0ZpZWFSOHhQTHhTbEppOHo0bkpQUXRkUXkx?=
 =?utf-8?B?SHVxQk95RWtiU0M3a1UvSnRKTGdmYi9hK0pERVZUcGN6Zm9JVGRGSkZMMGNa?=
 =?utf-8?B?eWtCeWdjREQ3S0QvZ3VOUFlXNVh0bkI1SHE4d1cyejErdmNKZThObWNwVEZv?=
 =?utf-8?B?d3BUWkpLdExZVGczcDRBY25rbndDS0NhSnNGaE5vY1o0SFg1U1VtWEI4Tnh2?=
 =?utf-8?B?bUltWnZlTG9XYWpNbXFPbXVWQzBGWDM5czl6R0NHOTNMb0YrQ1FEbkphSDMy?=
 =?utf-8?B?V1ZiQmR4MWlKM21UMnJPTWQvT2lUaW1QamZFYng0QXhDNWwwbUNrTkpybmJ1?=
 =?utf-8?B?VzkwNzdKRTgzaVZRY2RtNGlkWXdkZE5rSTUxZW41b0h4M3NCU1lPRFYwZXYy?=
 =?utf-8?B?eGNPVXhJT2l5WWZZTnRDbmMxSFN2OC8wL1NpNWZmZU03OTB2RWdTZkovbjBJ?=
 =?utf-8?B?MVphWW81U05Za2l1UnN5M3IvS01ldFBTMURoQ3N2VUdDNXhSR2xMTEVmMFJq?=
 =?utf-8?B?WXJIUm04ZFpDYWZjU3FuY1Bwc0NxSkJCNG5rYmdsM0dnbVN1S0tvcjBpdVdL?=
 =?utf-8?B?b0w2Wk9CL3I2TG1UVXowaTBYZmhlZ0FOcE96RzRQTFl6Z0p2NHNhRWxXMGp1?=
 =?utf-8?B?S2xZSSs2RkZhUE11eE1SNjZ4TmJYYmpkakZ4eVFNSXV5eTVlYWZWQzF0OVV1?=
 =?utf-8?B?Uk1hcVFmNUdEWmZERzlVR1hUMERTQnVMRk0wTlFQd0gwT0s1K3ZhQUJXK004?=
 =?utf-8?B?WUFMQ1psMTdoWGZWY2Z3NzE1cnEwV0pHaEE0TEFOY0Jwd3MyS2g5VkZFLzdl?=
 =?utf-8?B?Wk50cWIveHdNbmJWd043OTF4MEZPTkdYVmxSaFVmK3pGb1dhbUNWSHN5NWQ2?=
 =?utf-8?B?TmdmckJZVlB4K2tHc21iRUNoNm85NDAwK1R0aWEzTEJ2ZmxoWEFVb2JwQ2I1?=
 =?utf-8?B?MFNmVkozczUrajZXMlhLTXJxbFlrcXFSNTlqSW5SVGpmaHNoVDVWRVUxRStp?=
 =?utf-8?B?T2dzRWsxdC9wbkdCYzJxVHFnZUFacEk1bDE4TTNmRDFjNFlUWHZrM3NHa2ZP?=
 =?utf-8?B?RGV4TlZ1bnRBV2JPUjNCbTVBcHJ5ZlZCSjVSODlWWVcwUUVjeXpLODNUQnVW?=
 =?utf-8?B?R3EySHFtQ095NllpWVF1NmlKNFY5Z1VzT1VCV204WWNlQnI4YkNmWEErWk9H?=
 =?utf-8?B?bkZNbVBqNDFuQVVCZSswbWlxRWEyd0FDLzFSUW51VVdYUmdTT09qaVYvUXRo?=
 =?utf-8?B?dUVxcHoyUkZqVjEyWGYvOFYyZm1JcDRNMkZDTWFvbDB1K0ZUYm5WR25YQjZ3?=
 =?utf-8?B?SDRzc0tGQWR5TU5zOWszQlFnekJSVUJqVms2aG4wemZFa3VVWmtmYk5kQ3dG?=
 =?utf-8?B?c0daallIN2ZSNDhrRmwvYjIvU1UyeU9GSTVuN2JFVVFUYzhxRlBDaERYWUhS?=
 =?utf-8?B?STRlY3YwZ013TFBsUENBb2xGUDNtM3VJMGtDbFQ2Z2l3SE1IRHdWMUlMeTM1?=
 =?utf-8?Q?+syngIiFtAyTurI6kv728l5j1nJf0ZLHKd0BCnC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUQ0Vlk2RlZWOFNVR2RQa2UwaU9sbmdZYjliWEZ4WU5EeWpGbUhQSkdoQVRO?=
 =?utf-8?B?T1RpSmZBNEY1c2I5Q2JwbnFIK1daQ0g0Wm1RSUtkTTZBdFdmQXFNVHF3WUVK?=
 =?utf-8?B?bi9nRmc2a09SU2RGYWwwdngybTVxRmJnUjhrMkhZSllhTzk5L0RKSVlvS3ZX?=
 =?utf-8?B?MnNsbWQzR01DTVBVYzcyRHpyeFVjZWw0NytKYTU5NXlzSk9McjVsZ2hKcVNk?=
 =?utf-8?B?QXFIQ1J1M0o5YnRuVlljTGVubnVsdEpuam9SNVppVGcvdXNCdENrMVRLU0ww?=
 =?utf-8?B?ZXYyR3ZOQXZzbXd6c1E2UHB1MCtZZW1kdG5ZYjNGYlRmZVdnMHVzU1h3a2xS?=
 =?utf-8?B?c2lRaE1VMWNlN2ZKc1RQb1hMaVdJR3p1a0FIRDNhZENKUHdJNkFVRTU2VnpJ?=
 =?utf-8?B?QmdMWXJla2p6Y2RCTzF5OWIwczVnNW45T05JaDlzUjJETDUyQmh4ZVBsVERv?=
 =?utf-8?B?RHBvelZhMCtNTGVTRFdYUzAxUlRsQjVpVnltZHdVa1A0elNVdE9HUit0dkNH?=
 =?utf-8?B?czRoMVhPTmxBWk5leXloQ1pVdHR5cTdiazJZb3MxNytnc29iZS81SUo5T1VU?=
 =?utf-8?B?eUV3bFp1SVNHbUNsUFhwTG5TWm1zSHhFVnVuMzhsVGh1WTdBNTUxN25yUjBN?=
 =?utf-8?B?dU54dzErVEd3ZnlBbkJYTkZUa3FrVStPb2dORlkrYWM3N3BUOUM3dGxqUUp4?=
 =?utf-8?B?bG1laE5XSk1UdDRoUlh4cWVpUnBGN2dPSXpNT3RMK0lMcmFPKzBpOWZTU09r?=
 =?utf-8?B?NHdGcjlJaElIUTdYMDZwMEdIamNOcy9XM1g4UnRUaWNPKyt6V2tEZDFka0V6?=
 =?utf-8?B?Ly9ldUo0Wnhyb2gvUnZ6WUZsd3dyNWxlQmJ1U2I5dVZLVzB5b01QbEVqUzBn?=
 =?utf-8?B?K1Z5V2s5SlVRUEZ2emxQN2UyaEtMMG5YVVhtbW8zQko0N0hyZDBSU1JJbzND?=
 =?utf-8?B?VmgrMURBc0lzS3NYWHg5ek13MFltTk1xdTlSRDVRVW5TNFIydk9XTWNJV21a?=
 =?utf-8?B?UHpQUjR3VVVPQnNKNllBS2FVRUVaanNaV1Z3WnVCME9VRnlUa0FFY25Hc2lY?=
 =?utf-8?B?aHNobnJiQWlJMDZrUjNZbFdyRDVoQlVIK3RUQ1V3UDJEUU5EUHpzcnNUb211?=
 =?utf-8?B?MW9OL25mUWxrS0ZMZWZ2eTRKaWladEd2cHhHelhFSVdxUk1uT1RsQkFLeUkx?=
 =?utf-8?B?RXF5OWx1cEIyTFdJRHg1ZlBBQkJwVzE1Mi9kcUg3MHJiMEMzQVBZUGxrbUxi?=
 =?utf-8?B?bWVxK3pIRDR5dlJGbUVwUmlMZUxHaFFzUWx4TjZzNnNJQW83RW4zWDh6TTJs?=
 =?utf-8?B?UkV4VzRKbVFVd0FoZ3FqQVBMR01ZVllNQzczWFlIQ3EwbXQyOEhsUVp3VmFE?=
 =?utf-8?B?b2o2Nkg2RlFzTUtWQ2hGZ1Azb1YxWDAyYmRPTkVpeFBXSVhaaWU4cTlEMDNH?=
 =?utf-8?B?NFZZU3d6RFVkK2ZvWEgvNHVlZEgvZFkyMFMzWDV2MHAxUURUM1ZTai9xUStJ?=
 =?utf-8?B?ZHBjTjRWTHlZbjNyTzkzeWcyMmZWVWpTOHFKRENqVFRJaFlxV2FNYndFWTBl?=
 =?utf-8?B?UXJQUXNaN3RQVWFJdlRqL3l1RXMvWTl3Sm1SY2hwYVNmMzYyS1BONWU5dWx4?=
 =?utf-8?B?dm10cTFtMlZFVnRobjFUZi8wVjM5cTljQmZKbmJlTkwzeHpuc3lzUzBKWE5j?=
 =?utf-8?B?VWRzVC84R0tGN3lrckRIYW5ldjdqbTY4cnRjRkdkK0NyVGxVU0xvUVp2S2tC?=
 =?utf-8?B?aU14MWRnMDkveGk3ckhYSDBkWUV0SHJ2dUNkbzJ2K0JTTWtreGFMcHA5RnBP?=
 =?utf-8?B?dS9wZXVjOGJEcE1rWnVhczM0UnBKWExoNHJZbnM1UzJmZmdHWldEckVUa0hl?=
 =?utf-8?B?WVBPSE01MDVBdVZQYkdDSUFxV0xDUVBVNkRPYlM4ZkpUbXg5akpud3RaMHp3?=
 =?utf-8?B?TUYxZHpZMjdIL0xqN3ZvckhQZTNJckp0d0Y4ZHZzcWwzWkZTRkx1eU9qOHhY?=
 =?utf-8?B?TUdwOTg5V0xMclQ2ZnVNQXFReDlOTTFrUGNjZW94SkE0Qkd2SkFRNmdFWXJ3?=
 =?utf-8?B?TzlTejd5MldLYlNOYUYzYnRUcUdndHpPdTNDSGNCVWx4WEIvcm5JMlZad290?=
 =?utf-8?B?eDNkK2txVXZRUjhxbDdseFFyd1daODA5WHp0aitkWDhuT0xYSHB2NFVqakgv?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bLYGtAoWwF9MMpECP1SukIcbo+spUeN926BQ/GfijY29jECTJpyzr9Kuzr1f+nQ1ScsV4BjNfK8Bb6jsCGb1ncsU19gzIx2eafkZn7ecn7rh2k6/Pf/yJAJr3W0l40QD3oT4SJrigrwsYpzz689bU6cZcAG1eNCL1FyRLr/9PWBzejGBvXFBI3vRtYC/3Jbc9Vq/MhmKR0hr0MRYgMPTx8KVX14mCiqG4paUjT+XtMqj+emnREF8pUnV85c8K7yj8odYegJavO/0M+lK+RxUYDZ9bwxHvGkB5pL+VVfkCV+f70Cs0nKSm2FDedZxpMgzeSRDfrbnkNIWmWc05u27IlpF1B9DWbbTR9KeIDyRFqkBxbh+67+bp3TFIF5a8AdG72VSjzihqPI/RpbEg2u0sSwFzNEHDNJjprNu3XLQD6Nv3V0jtQ0GutLgWd+Zu3B8d95mHCh0c76bNwoDSwsac0HnpectygH3TIGtCSf506Nv/BlA5ZyKMb7n2MetQOKVDoUjPZKXpje68uSOCpQQvI1euYxHAmizsN+LR4h/77BFu9owuNSOSoZ9yBNGaSa7fg0knbgLNXU2CfarnQYS+tNXyeSVFCT9T3gO4v1gBMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4d772c-91f3-4b03-18ee-08dca1843602
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5891.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:34:00.0949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZyUk0E3wTq0ujxRVxP4ZeCq98dHL1i5gy11YjPc1Fm4h46pvPiIZ88xD4lZYAT4XDhqdQnCd5zwz8pKf/DNYoYZ/S3a5Ix+tBKsm1WrthU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_05,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110059
X-Proofpoint-ORIG-GUID: SBZEUzWY--nj5RcglkVdOWrzEVSa9FK3
X-Proofpoint-GUID: SBZEUzWY--nj5RcglkVdOWrzEVSa9FK3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/07/2024 08:41, Cédric Le Goater wrote:
> Hello Joao,
> 
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> This small series adds support for IOMMU dirty tracking support via the
>> IOMMUFD backend. The hardware capability is available on most recent x86
>> hardware. The series is divided organized as follows:
>>
>> * Patch 1: Fixes a regression into mdev support with IOMMUFD. This
>>             one is independent of the series but happened to cross it
>>             while testing mdev with this series
>>
>> * Patch 2: Adds a support to iommufd_get_device_info() for capabilities
>>
>> * Patches 3 - 7: IOMMUFD backend support for dirty tracking;
>>
>> Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
>> we will find and attach a device to a compatible IOMMU domain, or allocate a new
>> hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
>> workflow is relatively simple:
>>
>> 1) Probe device and allow dirty tracking in the HWPT
>> 2) Toggling dirty tracking on/off
>> 3) Read-and-clear of Dirty IOVAs
>>
>> The heuristics selected for (1) were to always request the HWPT for
>> dirty tracking if supported, or rely on device dirty page tracking. This
>> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
>> tracking even if we ask during hwpt allocation.
>>
>> The unmap case is deferred until further vIOMMU support with migration
>> is added[3] which will then introduce the usage of
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>> dma unmap bitmap flow.
>>
>> * Patches 8-10: Don't block live migration where there's no VF dirty
>> tracker, considering that we have IOMMU dirty tracking.
>>
>> Comments and feedback appreciated.
>>
>> Cheers,
>>      Joao
>>
>> P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
>> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
>>
>> Changes since RFCv2[4]:
>> * Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING even if
>> we end up not actually toggling dirty tracking. (Avihai)
>> * Fix error handling widely in auto domains logic and all patches (Avihai)
>> * Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
>> * New patches 1 and 2 taking into consideration previous comments.
>> * Store hwpt::flags to know if we have dirty tracking (Avihai)
>> * New patch 8, that allows to query dirty tracking support after
>> provisioning. This is a cleaner way to check IOMMU dirty tracking support
>> when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
>> device caps way is still used because at vfio attach we aren't yet with
>> a fully initialized migration state.
>> * Adopt error propagation in query,set dirty tracking
>> * Misc improvements overall broadly and Avihai
>> * Drop hugepages as it's a bit unrelated; I can pursue that patch
>> * separately. The main motivation is to provide a way to test
>> without hugepages similar to what vfio_type1_iommu.disable_hugepages=1
>> does.
>>
>> Changes since RFCv1[2]:
>> * Remove intel/amd dirty tracking emulation enabling
>> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
>> [Will pursue these two in separate series]
>> * Introduce auto domains support
>> * Enforce dirty tracking following the IOMMUFD UAPI for this
>> * Add support for toggling hugepages in IOMMUFD
>> * Auto enable support when VF supports migration to use IOMMU
>> when it doesn't have VF dirty tracking
>> * Add a parameter to toggle VF dirty tracking
>>
>> [0]
>> https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
>> [1]
>> https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
>> [2]
>> https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
>> [3]
>> https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>> [4]
>> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
>>
>> Joao Martins (10):
>>    vfio/iommufd: don't fail to realize on IOMMU_GET_HW_INFO failure
>>    backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW
>> capabilities
>>    vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
>>    vfio/iommufd: Introduce auto domain creation
>>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>>    vfio/iommufd: Parse hw_caps and store dirty tracking support
>>    vfio/migration: Don't block migration device dirty tracking is unsupported
>>    vfio/common: Allow disabling device dirty page tracking
>>
>>   include/hw/vfio/vfio-common.h      |  11 ++
>>   include/sysemu/host_iommu_device.h |   2 +
>>   include/sysemu/iommufd.h           |  12 +-
>>   backends/iommufd.c                 |  81 ++++++++++-
>>   hw/vfio/common.c                   |   3 +
>>   hw/vfio/iommufd.c                  | 217 +++++++++++++++++++++++++++--
>>   hw/vfio/migration.c                |   7 +-
>>   hw/vfio/pci.c                      |   3 +
>>   backends/trace-events              |   3 +
>>   9 files changed, 325 insertions(+), 14 deletions(-)
> 
> 
> I am a bit confused with all the inline proposals. Would you mind
> resending a v4 please ?
> 

Yeap, I'll send it out today, or worst case tomorrow morning.

> Regarding my comments on error handling,
> 
> The error should be set in case of failure, which means a routine
> can not return 'false' or '-errno' and not setting 'Error **'
> parameter at the same time.
> 
> If the returned value needs to be interpreted in some ways, for a
> retry or any reason, then it makes sense to use an int, else please
> use a bool. This is to avoid random negative values being interpreted
> as an errno when they are not.
> 
OK, I'll retain the Error* creation even when expecting to test the errno.

> With VFIO migration support, low level errors (from the adapter FW
> through the VFIO PCI variant driver) now reach to the core migration
> subsystem. It is preferable to propagate this error, possibly literal,
> to the VMM, monitor or libvirt. It's not fully symmetric today because
> the log_global_stop handler for dirty tracking enablement is not
> addressed. Anyhow, an effort on error reporting needs to be made and
> any use of error_report() in a low level function is a sign for
> improvement.
> 
Gotcha. My earlier comment was mostly that it sounded like there was no place
for returning -errno, but it seems it's not that binary and the Error* is the
thing that really matters here.

> I think it would have value to probe early the host IOMMU device for
> its HW features. If the results were cached in the HostIOMMUDevice
> struct, it would then remove unnecessary and redundant calls to the
> host kernel and avoid error handling in complex code paths. I hope
> this is feasible. I haven't looked closely tbh.
> 
OK, I'll post in this series what I had inline[0], as that's what I did.

[0]
https://lore.kernel.org/qemu-devel/4e85db04-fbaa-4a6b-b133-59170c471e24@oracle.com/

The gotcha in my opinion is that I cache IOMMUFD specific data returned by the
GET_HW_INFO ioctl inside a new HostIOMMUDeviceCaps::iommufd. The reason being
that vfio_device_get_aw_bits() has a hidden assumption that the container is
already populated with the list of allowed iova ranges, which is not true for
the first device. So rather than have partial set of caps initialized, I
essentially ended up with fetching the raw caps and store them, and serialize
caps into named features (e.g. caps::aw_bits) in  HostIOMMUDevice::realize().

> We are reaching soft freeze, in ~10 days. There is a chance this
> proposal could make it for 9.1.
> 
> Thanks,
> 
> C.
> 


