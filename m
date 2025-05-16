Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A99C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 19:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG131-0000z2-QL; Fri, 16 May 2025 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uG12z-0000sD-N1
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:48:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uG12v-0006sN-BP
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:48:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGftfp006962;
 Fri, 16 May 2025 19:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qQirLRTwU3YTLMfBpReMgHYOPa1helCrYrJ3dt3yFQc=; b=
 AK5rmQUM7az8FBDhaddBuiV82daJIMqANXsQZTUtzyk2nN32h3yE8Wuce07id6TZ
 e+M/PyFZdv5CY2a7vZH54uY8Q2AUUeqi9+AAsJOfvv2cRqGSrDk2MQE7ff03ip41
 RyS71jTu6QtTN1Ilkh5YKbB7J/c9/s5ZOSKdeGe8eGCv1P2DeCz08JBng4Cx2wD+
 wc2YGzapHTy7/7qMCvij+5mH2CcDmjgnGid8khLG0JrWVvG5a05czm1OsUJT+Rzy
 AyHe92smuiiL7PMks5n4T7VM/C0C0ZZJn1015boACmKXKYja0Ux+X9ullQBdJtoP
 7zO1sU/6aQMUAa1gWPMdBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbkt3dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:48:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GIZrD9004456; Fri, 16 May 2025 19:48:36 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mqmf2dyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUYX4xXpt2TBpcuJ0eDR4W1YZYZOz7DNoZ6iOvXE7UaX3sdHC1snJWns6rAZ0pDOFwjJTlNAA87CXEjxzm3cMNbO51mNs+RhS8K5tSbTy/gRhNwFHdBYTAM4coBeOg4t1dlbtsKnWUR9iL/mpm0nEmGQh+lvP3S0siBPlcKkwYjXe2SWwb2mdYYVlj6PAwnnF8PVatOuMNriQfIK/meZRFQUUqiiUng5b6FnBjMwjmbn+LKT3ouKjNCOAPuVY9F3ek2N7jYFNu9lloFvgHF2fl9Ce2dvHQynTTdyFkR0DhANxRsPa9a89zUWoXAip3TXyRfZzV9Dx3CeA1VuHiEavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQirLRTwU3YTLMfBpReMgHYOPa1helCrYrJ3dt3yFQc=;
 b=pv2VG9xTp+gpFrKar8ZvImm46HiTNUSzBd8ibcC94bgMHomqOOG0xPj2sS8c5AgZ9FlE1HubKChdBbey3tdqJmF8tKHvWWAa/UD/WC8AEUKGCZoFGJNq9L5MHfTlZfjMu731CRTkL1VJ0yEOtzSTqW+U2xV/BDkFfsDwmOjX67CJw/zJVo2Rxnbc2fK0Z+5CFMlPhYCCQyoHyNqRZS2REZ4vh3I9gc3LwTigmadrtGkaRARSjDI1IcnmbKyJURVc+VV7Zl6fvphJ6RDz6ljHc4I03kQwTo4Z/jbopzpMQe8WS8O4ibaQtagJD5/5fUHp3Vs/Q9zjQP4sjVe3vATyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQirLRTwU3YTLMfBpReMgHYOPa1helCrYrJ3dt3yFQc=;
 b=O/24nLl5p095BGKKA5+f+TBPwGxA3byZUBsoXCjpUA5uNuSQT9v6iNYoUoEW+MSgh9RE9jGaOHuQGNMzDcLOib1Q8hxfj3VtY1GuoHphEpl0sr+Xefr2zXyXB9EzryiBXKd6k9eFSbsa8aQg6cKgq2uWWdyZO5GrOi72DEco05g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4760.namprd10.prod.outlook.com (2603:10b6:510:3b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 19:48:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 19:48:32 +0000
Message-ID: <0f6632dc-7751-417f-a37d-b476a47ae60f@oracle.com>
Date: Fri, 16 May 2025 15:48:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/42] Live update: vfio and iommufd
From: Steven Sistare <steven.sistare@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Levon <john.levon@nutanix.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1ad33986-dac9-4d89-ae54-e2ba31cee748@redhat.com>
 <e13a8672-9c76-4739-89fc-91033b0a031a@oracle.com>
Content-Language: en-US
In-Reply-To: <e13a8672-9c76-4739-89fc-91033b0a031a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: d3abcccf-0368-4043-89cc-08dd94b2a30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3pseEplQmczKzRJc0VLYzBMbGVacGUwUWpOVCt6YmFQRzhsNGZOZW1JTmhL?=
 =?utf-8?B?eFhlUHBHNjZTbGd2NE95WDV4M3FyeVdKMnB0aWJCQVd6WEc4MVdaZStZeDk0?=
 =?utf-8?B?L2EyYkV6TlcwL0REWTEybjJFWUtDT2Nxc0x2by9BRnl3NTg0MWs2SFA3OUxa?=
 =?utf-8?B?eWtMRDcxQ1FXWDJiRG1IRkIyYSt3ckhOZGJYWDQzd3JaVEtvb1hHaU02ajhp?=
 =?utf-8?B?ZDhzNXAwNjhaaXphQTZNTERkVXZJQlNLeWdlS0pkdHVJNDd2UlNDbGM4STFq?=
 =?utf-8?B?Q2xUWmd6ZWdKOFNhSXlrVzlmWWs5ZXUrSk40T2w1Q29vR3VVZlRBakpjQ1RL?=
 =?utf-8?B?azhWaC9qaVpaeGJzN2p2UUlhRmQ0ckMzWUU0S0dYZjlIZnBybHlkNnlJRUFU?=
 =?utf-8?B?N1lUd3FOYnltRm1wSWFTbitjZkdrWTQ1U0QrVFNNWWpkS2JDcnRhaUNzcU1H?=
 =?utf-8?B?SDcvVzdLSXlGS0RRV3d4bjU2KytZQm45WnM2cWFOQWRpMnF1a2xMUVYrYjBK?=
 =?utf-8?B?K3pNOVQycXlGZlNBUDlUd2lNVTUyS0tNL2lDY1hpMEhyTzM3Tk9SVCtMTzZC?=
 =?utf-8?B?L3dwWXRibzNjcjR2dTNCL1dMRDF1VHgyR0hzUmRjTStTWDVHNm4rb284cENi?=
 =?utf-8?B?UnBKNnRjQ2FYNlRHRE93NVRaRGFRandVU0NFTDZKejFmYWZJTFErckpGR1JP?=
 =?utf-8?B?V2d5NTRnczJBTVAwRnoyUFI3NXdLOUtpYXd0NTljellNRW0xTU0zUGJCK2F1?=
 =?utf-8?B?cUtHcjlzMzFkYTZReDJrcUV6REEvTCtiRDBaUUc3Yy81SWZpeEtBUkNaMHNP?=
 =?utf-8?B?RmNoWlRVRW9TQ1lFUmZremRSalVhUlVtSHRDRnF1cUNsenZFNlVOM3B6UTd5?=
 =?utf-8?B?TmUwZ01ZdlQ2NmNJdnh4TWNOYnh6Q3g2KzhqcDdhaFRqWExNWnN2NXhPOXBL?=
 =?utf-8?B?NFJZU3VtOUdXRm9IVnhyUUJySmUyWW1Db0hocWpLcGRKb251dWJqWkVEeHJ0?=
 =?utf-8?B?Wmg4K1lwaDdoMW1sRUdkRDRpZjI5M2s4VHJPYWVaeFNJTVdSZSs2SzE5Nkdr?=
 =?utf-8?B?b3A3VVNSTFlaVnRuVkUzcUJ3WWxDOFNQMmZReHJnN245MXlkN2tycWF3OEl5?=
 =?utf-8?B?N1Q5MFpDV1ByeFp3a3BRWGVsaUlPRVhLbmJvVzFxKzAyakUwSW1QekpFSEpy?=
 =?utf-8?B?UURPN0xRMlduL1lLWmFqeHh4Snp0cWRBNHUxSkVraEtNNzV6OWx6Uzl3emtX?=
 =?utf-8?B?UHdaOUxOY3ZtVE1wOCtIOHN1NFY2V2V3VDVBY1BKK1F6WGw4cVZHTmdOZmpi?=
 =?utf-8?B?TnVKQ0JWdWh2cjl5Rzh0U2o4RklqUWt0emJjclQ4NG9mNDlXNU9aanJESVhR?=
 =?utf-8?B?T3NtZ1hybThvZ3JzTGlNVWFPOHRVZ0V3aWY3WHpyNWhyRlg4citXWlBLOUV4?=
 =?utf-8?B?b1U4UUdyb0k5S3YxOHNZMEhQWVFBa2gra1h4aGV1R1MrUHFBciswT29DYnJq?=
 =?utf-8?B?QUVMWDVPWlN5M3p1U1NXNGNrM2EyOXNFUWZkTVVEZW5oaWNLcWdNZmdkdllx?=
 =?utf-8?B?MHdTdFNjM3hSM0pUMFR0MXFXM25YOUFLTkFOVXdFU2thQ3lyK3ErSHVDcWU3?=
 =?utf-8?B?bHRtQVJNL3lEVUZUTWk1V0VZd3BwMHVVLzViN0JVTFgyVEkrdjNUd1YxS05N?=
 =?utf-8?B?WFVNOVNxeXZodkc5NmF0cjN6M0RLRzNuTDloOHp1NCtGajAzVE1sMVZJRGVn?=
 =?utf-8?B?NWVrVHdyekJyNENFODhLK1VCL0tVTm15ZUdteUNob3FPNDJHSUtOcTRiMkRj?=
 =?utf-8?B?RWVyRE5id3JVckN1RzA5NFB4SGhQR3hOb0c1aUNKOEM1YWtLdytUWTdKLzg0?=
 =?utf-8?B?dk5Sa280bEQ4UUF2WnVKZ3hNUjJOSk9hWU96cnI3Nk9EcUVnWHp1UUZvdXk0?=
 =?utf-8?Q?F/bS9vxkxco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhzaTBhZjdhbkFPU3prcHBHb3JxbCtNcThiS2ZyOEE5QnE2YVZtcFZGOWwr?=
 =?utf-8?B?bktKWU1yazBUeFNTT1JyUVFKRllYejFGUnFZeDlyK2VaTDJRNWt4b0p1ZjMw?=
 =?utf-8?B?K1BVRU42UDJwaVNlQXRGZEdMVnUrY3VTczZVM01FcmdhK0kzeHVCUVpjellk?=
 =?utf-8?B?cmlpcFA4YjZGaWh0OWE0SVhUNDFzOUR0Nk1kSEF4aldzbVpqUUY1QzlMMmxp?=
 =?utf-8?B?R1IwQWRmcTQvTjdlek55K1lOQkNJL1dVa2lvWVdwK3VLcUNpSEZFNHZQUlhz?=
 =?utf-8?B?S0hJM05PYS9XY2JldUNwZFFDT1U3aytjcWhQOWpkR2hSaUF6VDlMYjFSdllk?=
 =?utf-8?B?a1BNN1p4TlhCWWRMdkNVaXp4d1JMUlMrWGZBWis2ME1Wd1RVK3VxZ3RnUUEx?=
 =?utf-8?B?UkwxY1ZoVnowdEE1ZmRocjAwWjBMWnNKKy91eGg4Z2h4K1Z2VEM3V3dudkQr?=
 =?utf-8?B?UEM0TlZKYmVnQS9qTnZUNGozdGRzd2tCR01sVmx1dXBCUUprR3BGZ28waXBl?=
 =?utf-8?B?MGZoK3o2d1M3UlBzTTQrcElIVm81d2FDekx2NnlWSXJsbXY1TmN3QWgwenlZ?=
 =?utf-8?B?WThIZlNNYlZkV3lSL0RIYXR6WE5uVkIrelRUVm5Id0dSaWVhYjRlSGR4cXFu?=
 =?utf-8?B?WXlKdnp2M1N0SXZPV2VySXZPMzl2TXUydFVWYlJmNzVwR0N1U3lVdm1yRU54?=
 =?utf-8?B?Ynltc3FLQi9yK0ZFZU9aalNFWVBKbklweWtQRUtBU3RWZUNMRGt6MHMxZzRv?=
 =?utf-8?B?RHhiRFBOU0lNMDhqZGY2K1ltZ1h6dTRtL0oweU83K0NycFdNblN5SGpybUlN?=
 =?utf-8?B?MlA3WFlZOGR1OHhPK2NUY0YyTHhiL2F5R0oweDZka1JRc2hMZDlicXBWem1P?=
 =?utf-8?B?R082ekhxMFB3M2lXM2Y0TzhSYUxXUWVLRnNueUxiMXRpRlFmdDNHZnZHNldD?=
 =?utf-8?B?OEFzcDJycDByakZyNUdmaTYxZHNIZUxIMzVjNFpCaFc0WVR0TEJqVDA0WC9x?=
 =?utf-8?B?ZmJrV1JGSXpJZTkra053N3A1RVFYRkdYMlE5S0d0VXdOR01HUmVVdFFUMUFu?=
 =?utf-8?B?SzljS203N2kwb2drUUtOdkZaUU1hL3FaNmpBbFgxUHBOY2JadHE3Z1NPTXdC?=
 =?utf-8?B?OGxnWmJ5Y1loQUNkSlRBeUVMd2xqem5JaXEvdld5K1dXemFmemhEanlpSzF4?=
 =?utf-8?B?bUxHNlZ4Y2RkY09BSzNtZUZBS3BvTUd1QXZHYndkRFdwWUUxMHVDL0s4bUZH?=
 =?utf-8?B?SllCNHY3VDNOa3Y0Y1ZpTzQwK1lSMVRJVU1TdERQSmYwbWdLS1dGcXdCSVJ2?=
 =?utf-8?B?VzIycVBmY3QwRUs1aE9tajBWU0ZuSHdMQ0Z2VTBQRXJuMC8vR2c3QnVBN05G?=
 =?utf-8?B?eFhQL0wyMW5pYmhCQzVTUjlFcDdQbW1jVVExbzJuN2NWZ2llWkhSZXU4VEoy?=
 =?utf-8?B?enh0Tjl4MytpRHRuakxTZ2tRYXpraWpWVkFrVU40eEw1bTdzUU5ubGZjN3V4?=
 =?utf-8?B?OTc4UEdSdnQrbDFKcVlyd1lJOGtPbWx6aThLWFlwUXN6WCtsSTMxdndBVndR?=
 =?utf-8?B?dVVLN0l2UWY3ekdVNWNhUVV3bmU1ekhVczh5M2tjNXhOd3ljUUVhNEF6eG1L?=
 =?utf-8?B?NXNFOGk1Um5lbk1CbTBDYWVGYVRNNkF5dVRNTTJQMEJnN1lwNU1NQWFpd00y?=
 =?utf-8?B?SHRVTmlCT2hzbjhveFJ4czl6cGNUc1ZNWGp2QW81SmkrQit2NFpOWHhoalBs?=
 =?utf-8?B?Yk9DeDZBYVhvNVBkRDZGekxGazhtdlZtcC9hQlMwSDB1Z1Jsc3R4dUwyQVJr?=
 =?utf-8?B?ODJ1clVDQ3NzM0VIL3R1ZlkwRENOR0lqNWlWODlDc0F5dVM3UHFlZFpva2ov?=
 =?utf-8?B?R2RVQWtYcUNwZHRxOTZzR0hSdms2bXdEczVEUnN3UnB1dHc3bmhpQU9mbmxX?=
 =?utf-8?B?VzZsSnU3QkVMTHZlNVpycSs2SVZGb0NVamtyNVMyYjg2NGRtUERtMDlzbW1Q?=
 =?utf-8?B?aUd4Vk9qVmZSRjdQSG12Z2ZBY3EzU3lvR2RKeGlYSk5DYmZ2emZva1FtS1BO?=
 =?utf-8?B?dGY2WHpsYUdudWp6M3RaVW45TEFESUp1bzNQaUFGbWpRbENobi9CUEJqcXNX?=
 =?utf-8?B?bnIwYzNIK1Z3NTlsTEZtcnRDTmhxemhpdVZadjNKYzdRcUJQVW9yOWZmelVM?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ba02SZDilDRjiQHqe6arMdOngYk+VDrNYsRE6mCDwsres7mhLGzbV4gxtk9DpD2W6javdDCc0NfqtAPMLpFzPQlDhT/cZxWg+4SgGIkQWeihK3SbnRSI3Ww6FZgGLiJvV5aMAv9FFf7LYdXtpu/PB9/68FVArv28cRBR1E90xcEVgQbI2xnOZv4eO1K1o6zlmlH1TZsu/5BT6N1RRsuvBY7wTH8vLytfqViGWSQz5XnYdKinLiU6dMNwcTiZFGv25rUOZPuPPxsPkApCVzH3GQ7DSlDykOS3ZtXPk7TqO39dY4Cr5LerqUU5nye3XLmMnkDCL1ip8HNvQlKntLHl5y89SD3QZgE3SuoHC/h0BRikU6oDMJ+43yIWt2WdGB41jCPXMaAqZriGL0bqBpfd4BhKreFPKeULZ+FEbsFKDPzHIkmcN+u0dCko5+EQk+Qhd9pXI7LvSwqI6ZgtFTWV8IN0AQ91y+iBmYilejy/MNg0Nu840QLdeI4j3JTuoB9Po2sbcgd95Dwr/cvAdoO2NGyr1szKF9YGXJ28uqv+tXTTalISJ/izSw4QzqIV4cqUINq9f8TMdUjczk7T2sN2+GofqepcQtt57xaODelnp5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3abcccf-0368-4043-89cc-08dd94b2a30c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:48:32.0366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWjnWe8CM0kxLU4iTLPuv5UHOPrFJOPBd47ZGMwPeflS6IpdaZj7JemxXqixPvvK6IojA0WNC4u1u4BQ6VkCjWQqGMdsaA22sFtOW0FzXTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160194
X-Proofpoint-ORIG-GUID: 8k6PHLCaZu56eWQVRW_t_UqYxsAQaBy8
X-Authority-Analysis: v=2.4 cv=OK8n3TaB c=1 sm=1 tr=0 ts=68279694 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=zO3TjFvxrEb6y4yoovEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8k6PHLCaZu56eWQVRW_t_UqYxsAQaBy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5NCBTYWx0ZWRfXwkvwZoAZt1lP
 wYMTwzD9V9q1Kpg2DnRwGl9pYSXXjZB13PKw4FNi40g9M5W0ext5g42rBPeuLYfcYxiYJ4OFYXE
 B39nDCCaEoq/Ea66gIYB6v1eQigcsfNYuwZdKTGqu3JMFoyx0je5SdJjO5SJNF7M1VPP0BlwHd1
 gTNLHN3dcnXjPSGkSItvvTGBmmVJDPuNx7oj+4az3NXDzNT6EblLX0MZbANpn3OBFaM91YJ0lN5
 dZG5QA1pHgvg9UXN9gc502KrT7oQlX500MiUeOc6mDTT6zlS5T37yDStJTvKA4eX7tQXi7MzRMo
 5BvH+5iCDXhI+zAZDr421KPsk/FeCY5WCHFaQKh3V9q8Vyu7i8tYYsChjB2jheE/J8lDeMlhjHC
 tmo4B0iuBsz3Mr20zWliMV2cl9Fy8z4Zu6IWVuRnaJytI1QpCZRhke+2HN0Se3v79OtXkTIo
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 5/16/2025 1:17 PM, Steven Sistare wrote:
> On 5/16/2025 12:37 PM, Cédric Le Goater wrote:
>> Steve,
>>
>> + John
>>
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> Support vfio and iommufd devices with the cpr-transfer live migration mode.
>>> Devices that do not support live migration can still support cpr-transfer,
>>> allowing live update to a new version of QEMU on the same host, with no loss
>>> of guest connectivity.
>>>
>>> No user-visible interfaces are added.
>>>
>>> For legacy containers:
>>>
>>> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
>>> skip the ioctls that configure the device, because it is already configured.
>>>
>>> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
>>> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
>>> QEMU and update the locked memory accounting.  The physical pages remain
>>> pinned, because the descriptor of the device that locked them remains open,
>>> so DMA to those pages continues without interruption.  Mediated devices are
>>> not supported, however, because they require the VA to always be valid, and
>>> there is a brief window where no VA is registered.
>>>
>>> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
>>> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
>>> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
>>> data structures, and attaches the interrupts to the new KVM instance.  This
>>> logic also applies to iommufd containers.
>>>
>>> For iommufd containers:
>>>
>>> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
>>> backed by a file (including a memfd), so DMA mappings do not depend on VA,
>>> which can differ after live update.  This allows mediated devices to be
>>> supported.
>>>
>>> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
>>> QEMU, during vfio_realize, skip the ioctls that configure the device, because
>>> it is already configured.
>>>
>>> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
>>> locked memory accounting.
>>>
>>> Patches 4 to 12 are specific to legacy containers.
>>> Patches 25 to 41 are specific to iommufd containers.
>>
>> For v4, could you please send a first "part I" with patches [1-20] ?
>> I think these are reviewed, or nearly, and could be merged quickly.

Just to help you keep track, these are the remaining vfio patches for you
to review before I send V4:

   vfio/container: recover from unmap-all-vaddr failure
   vfio-pci: preserve MSI
   vfio-pci: preserve INTx

- Steve

>> Even if the "Live update: vfio and iommufd" series is not fully
>> reviewed yet, there are good signs that it will before the end of
>> the QEMU 10.1 cycle. The same applies to vfio-user.
>>
>> We need to bring together the proposals changing memory_get_xlat_addr().
>> It's important as it is blocking both the vfio-user series and yours.
>> This can be done in parallel.
>>
>> Then we can address the iommufd part.
> 
> OK.  I was already preparing memory_get_xlat_addr when I received your email.
> 
> - Steve
> 


