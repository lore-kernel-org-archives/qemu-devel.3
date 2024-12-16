Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C255E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDAN-0007K4-K5; Mon, 16 Dec 2024 10:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDAK-0007JS-Vb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:37:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDAI-0002Z5-Lp
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:37:48 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEtrra031906;
 Mon, 16 Dec 2024 15:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tdRfVDYGlJnXsn4s16kFKVvQfD8bza1b1KYLrqMRb5I=; b=
 O8XtYAjK/ImhK9jlz6dsDA/Ei8qylbGmYNMmiqTS2dtAyXq5byrmMa3vmxa0pBPn
 uBZiASAXy6kynxK2HJAlJ6ySOCtRbSH4vy3rvovSHtXA5SB+3dTr58O0zwLOaOZY
 ZuiwDsPPvZ85R+mcjHmuul1Id0451MxYaYtfKVJEWRKGnRU0rcG6JU+zt9i8CP8b
 oQYhd8Z9cJEWX7B8m457/SrxVG6eQNB+CJaNCE8Sn2r18kmNpBMwSpK0XV2B+Blc
 iSjG921faUPj8qAkj18LoyHSvnIR6fmCGtQ3olYiRBiRfA+2GxV/eDCNeRUzel+9
 qQL4qlRvOPU/elB+qCQNhA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m03hxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 15:37:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGExOBh018341; Mon, 16 Dec 2024 15:37:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f7ebmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 15:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph4/cAWTkU1suOrPxDZetGUaSxAHbYVoMIdSqiAjRnEtGa2624aViYQUPu95qxv5Ir2C++TYMT3Ms8+JNeBaJKeNGj2AvitdO1kaz4wnpZD5ngazLsPms81sXxorlPe0j9URK9SyaAfxhpMeMsILsGmswJB8Jo+hHuB/cFFG/79fpKsp4B1SZBxQIZah34SWsBWFYVMWbtzvZh2SKBbvYNXIn+0fid01YtwGE6jHFwxi51I2aE0BE03Y/9sfjnCRu/AV8bNnssaswFRVhL7LaLGsTwHc0fnIo8yQlhNudOby4AU1mD6KrcTU3eaZ6vYiBKl15sLgCsTybLaeumtaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdRfVDYGlJnXsn4s16kFKVvQfD8bza1b1KYLrqMRb5I=;
 b=vxrVFyw47CZabDc1x5OuCBXyGDXqvK+9sb8yQN7mnke/+oiBXjPoRNoL1hekCfMfkhI6oQVrTuG7SFsSmeGzWFSGUtLsnZbWDRyKpsI8fim9ghnDLVNZXpvXPkt0oIzoTJhxLWwXusEydGTnCkKtv5Bjmo1vthAruBeLHjNFTrnN6r8qKj4aS4WkVJHBMIwlgLn+r8tbX/qJw7j77k8d0CnZXSdtolnx6PwIUVssrdKAe5UalVnTwaQxwINSaTIXlg/c9smaMbS0TugF/FJX81R9IgfUlNajuO1DroF4kQ+C8R4Pt4E1MFOQpY1I2ry+UBNtUvb2IOR5Y0jPsNE37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdRfVDYGlJnXsn4s16kFKVvQfD8bza1b1KYLrqMRb5I=;
 b=OdWzcx+UopSeGGyIbQBtAQmTRvud/1kF9wyMfR0n/ssI5coprPBO6JutHIWgCvsvtbj85wTd1EyOWL7b6Zoli6CcSm2/oK7RNLOmg19C03fTtF70T4AEk8Du2dZVKZOBwtM5OuhYEgTCixWRAa7nzBtRhohzeRyZ0CLoah6bCHE=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CO6PR10MB5603.namprd10.prod.outlook.com (2603:10b6:303:14a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:37:40 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:37:39 +0000
Message-ID: <a0e99b1b-f708-4e08-aa14-9fddf7da6184@oracle.com>
Date: Mon, 16 Dec 2024 15:37:32 +0000
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <934927b9-eaf5-411a-8151-7617218d0cad@oracle.com>
 <7d753d6e-a71c-4442-96e2-fbf1fd04133f@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <7d753d6e-a71c-4442-96e2-fbf1fd04133f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CO6PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c1f9fd-bee5-4df0-46b9-08dd1de792c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGpTMTk0U2JUY01UeXoxUFNtVnFsVGJ4bkg2M2RjbXVpK2w3M1ppMkU5RVRx?=
 =?utf-8?B?MDJxRmxzRmJFS29HUTdqbUhBN0Q4MDBGWlVtaFdCTi9iSkhmUGV4OTE5Z1lw?=
 =?utf-8?B?OGhJMkp1dHpUakNxanVlelBWWjF2SFBiR0VUSnZkdkNnaG0rKzd2QWZMZytR?=
 =?utf-8?B?QzdQRlNiUE8vOEUrWDNtd2Q0cGNudHpjWjI1ZTBjdXJ3MEJHM3NWd0FwY2hF?=
 =?utf-8?B?OXd3b2M3OFhmZjBxZ0MweG5GbjQrN2FWNU5pa3I4NzB3N3J1bjZhZExBRkN0?=
 =?utf-8?B?ampRK2lQblFiZTgxVzVYWjJNN1Bmdi9jSjgzVndROWJRdVg4d2E4bm40aldM?=
 =?utf-8?B?OWRDN2pwZEI4MDc0RmFjS2gxNXN4R3hqUDJFellybitzSFRYV0x3K3VFdTdD?=
 =?utf-8?B?c2lmR2FwTU1LdGlQOWs2aE5SN1dUQnRYZFRDNUY1V2RBaU1MUm9NMkF3UU43?=
 =?utf-8?B?SVJtcDBaaEdYdW1vQnpwQmZqWHd6ODIyVyt0TS94OFNkM2cxSFpHbktlUUpK?=
 =?utf-8?B?S09LNEdubTN5S3BRUmxEQk9mKzVldytibHJWdktPMTR4bHVyYjM3YWlCWnB2?=
 =?utf-8?B?cUlVRjFqbEdSTEVITEhRaVJ6T3FHYWRCV1F4Vm9aemM1ZXk3ajZ0WGtIUElh?=
 =?utf-8?B?bU93VG9CS1NxaE1PclNNMGp0c3V5V1pmMU5aOVh3K3Y3MlN4aDc0V0x5TTVU?=
 =?utf-8?B?b3NLcmxNaWI4WGV1Q0JpMmpSSEY4bmxGbjVXSnMzNFR1aVI5MDk4WjZtOGxU?=
 =?utf-8?B?aDVYQUZTLzVEcURLRVRMUkdkdGtaWWlWVm42NEI3YzJzYnA3dVV4SllseElD?=
 =?utf-8?B?azZNemdGaElpbUR0dWRXSUU0SCtLdmFaeUJBQmNPQWttYy9PcnAzS2NFbjlh?=
 =?utf-8?B?MnhBeGdSVy9MV0pnU0xCMFQ4QnppOHFyQVdLeU9pWEE2L2dKbE5HN2d5UlZ3?=
 =?utf-8?B?R1VKMU1BOGxIeDNDcHNrZlhqSXAxOW9jakl1b01Iak9kNHdvVHFzZ1V6bzNN?=
 =?utf-8?B?UnVzQ3VuazhZVVUydjJndW9jM0FqNXdYSUlzVzNIUnR0VFR1ZTY2b0pDRzZz?=
 =?utf-8?B?SjgwTUJzSSs1MzVtekVFRjBhajVPSTAyS0VnOTA0MjFBYUhBUmtLaUpmaFF2?=
 =?utf-8?B?MXlkaFVZK0h4SzdJZDhiaHprL3RrVEhOZTFuOGkvL1hkYW9JMG95d21zdFh0?=
 =?utf-8?B?WFAzNUN2WVl5eVl3SnpXRFdDZEFvSG1MQmNha3FaZ2kwUTNOL1RrUEdaWDNT?=
 =?utf-8?B?b0d3YXRtK3ZacFpEM0NRbjFtN1hQVmVMZ1hUVkI4Qit1Q1VZSWdGSk9oTEhC?=
 =?utf-8?B?SW5qcnhxUGxzVXBEbWxlWFl0eUJpbjBLYytYa1hMUGdwSk1PVEcwcTJKUEtK?=
 =?utf-8?B?Q1k1VE50ZTJadGNYSXpOUGNUaUdkSHNUUHptN25IZldXTGUxeTdvcWNnZTR2?=
 =?utf-8?B?MjlEZXY3SUIrZ1RrN2tpTGpPUi9FSnYwc1hESU9kRzg2cThTdWZwTmE1ZElk?=
 =?utf-8?B?eU56ajRiYUgvbjZrWmRqY2JjV1c4S1BRVC9VL1JuTVNFR2JXenRzNnAxdWJk?=
 =?utf-8?B?NWRoSGg5OUFQeGdXUTJoU2JVOVkxNzZ6WEVLalphMWVGZlR6K041RzFsamg1?=
 =?utf-8?B?NVJ5cEFRbGJUOHN5RjZBRXRIM0NNMllzNUp4eU1JYXVFQ0NVc0RScjZDcDN2?=
 =?utf-8?B?OU5IaU9JcjlGdkZaUHp4cmZoM21CNE1XeE9jL2JUdWRNWkdaZ1J5eVBYQi9w?=
 =?utf-8?B?ZjRwWk10MCtHcGQ3N1J1OXAzOTNEaUxuVGdCSFRSTGZhTkVXdS9YTVA1OXd3?=
 =?utf-8?B?ZUk4ZG5UWThuOE4zcnA0UVYvdm1Pd1JEZmNTUVJwdEhhZFNiR3VTV2dNQlFI?=
 =?utf-8?Q?mCGU7js0nxQ8P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9wSDR2SlpSL0Z2R2xVcVRKbXlyR0RhT0JBVkJzcU9YTEdreUpXbk50aWNZ?=
 =?utf-8?B?c0tPVmEyazZMNnFGZXE1RFZIcDVsUGNUUXFwNHluTGNZNFRiM3ZRZThucWZL?=
 =?utf-8?B?aERVQXJ3VGZ6dFNMbHVnSXE3VGxMdys1Y3RTOWNYVFNIdEtTN09kcCs3dFBB?=
 =?utf-8?B?OGFCanNyTEUzN256clNad3Z4UnpHZ3IvTFYvTjVVWWR2a1dwTDdGa1NJRXJh?=
 =?utf-8?B?VXJhNWFGZWVpdGh6R0QwYzAwbHBGak5FbTZVcFk2TUVIYzl1K1NUcFFtanpM?=
 =?utf-8?B?ZWpIWHE1SjRNVjVFQ0NNRmJ3Y2hEN1NkaHk5c1dwRi9hQm56cUpTcURScnBj?=
 =?utf-8?B?dnFCRE9GOWRqQkVoUHZvUTRvUnVWUlJrMzNrei9FYkNROElLc0pXWWNjeFVB?=
 =?utf-8?B?ZzYvRnVDMmVwVjZvKzhCSHNITkxTQ0RhYlBVdVpucXVVNzRpQzVpK3FkdmlJ?=
 =?utf-8?B?VkQ2RTlGek9JUnRYeEltc2x1dmhmQUg0WDlkdDI4RGsvY0ZvODFXaU8wZmVU?=
 =?utf-8?B?cDB2aTVHcTNHSzN6K1BpakUzc1pvKzl0Q2RmZzN1ZldscU5ITFo5UGMza1py?=
 =?utf-8?B?bFArWkhKMnBRM3VwMEppRENJVm9TOXR0SFJ5WTlCcHRCNGN2QnlxQnlMOEVN?=
 =?utf-8?B?TFI3U1RSS3RERUJhYStRazFaNkVhdjNvL1lkY3N0amxJallFUUdDQWduQ2lZ?=
 =?utf-8?B?N1VWV25EQzVzQXk5Uk0yN0t6RlB4R1V3bE9vTzl0UUdwaVVMQXN3OFUxYkdz?=
 =?utf-8?B?eXR6amhrbkFOTElBSXlVV0oyNHg2dlJ0aXQ3M0FlWGx3T3BvbGdPRzJsOXhE?=
 =?utf-8?B?Z3Q2SjlHY2x1bld5akRwTGVpMmpiaFlnN3pwV3puNnhHcXRQNnlaMVV1eVd0?=
 =?utf-8?B?K3JlSmU5bjRIQlRtWnZoODhZb1UyTGFibDB4YnRIaytFS1BRY2tkdjZEdFhs?=
 =?utf-8?B?NGVnNyt4NDZVQnRPV3ZZdlRGTDZxQ21oK2F2Um1kQ3crc0RWcjFyd2NQZ0VT?=
 =?utf-8?B?dmR0ZEU3S2JPWkpqc2Fqc0ZzZGIxWEtnaEI3ZlhHcnd5WCtPeWlmQ01vNEJQ?=
 =?utf-8?B?ODVUbEl6cG9aN2FWMHdVUGpZUXFiU3c2VHFwRThlWVIxWVgvZzZubUozRjdy?=
 =?utf-8?B?Y3R6cGpzaldSZ0QweDlrMmNpSUE3SEZIWmRsajNieUhVMjhQWktoK0YrNGJs?=
 =?utf-8?B?TmJZLzVLZHlvQk1sREFmaFJJK2IxeXpEa0VpNytHNGVrcnRhK3JJRmJFYnlt?=
 =?utf-8?B?VW1MQlVMdVgySytXcjhJUkJLa2MwakhkM0tRMVNaclZlRXVHL1NWbXNaQzAx?=
 =?utf-8?B?UmtsbmxJdVpRckh0ZGNJT1hLeDlyUkFoaldiNEdOWFdJd0VJMGZ4bCtmQWJr?=
 =?utf-8?B?dXVldmxJS05Tc2ZWbEhzMXova2xLKy9oKzBlSkd4VTZ0a2dRYklSaXVSMHdl?=
 =?utf-8?B?b1dJRHU3UnBJdHphVFVENWJpbXd4MnYxdy9vSDF6bHBSaXNkNFJFYlVQam4r?=
 =?utf-8?B?R1BDa3VGQ0VLM0wyZEJ5Q2NwaHdyb3NmZmNTUTZhaTRMVitiemY4ams4ZFh1?=
 =?utf-8?B?T0hUd25TUE85TEJTd1JsV3ljb0tOOGNMTUh4NHRNNjdCTTdEbWVkTm4zQVVk?=
 =?utf-8?B?TFhscklvZ0NUUVgxUmR3ME0vMjRMT3VTL2EvdkhsQUtmTlJsYVU1RXVndld4?=
 =?utf-8?B?KzJ6TDc0SmZ3K1NFV0hWbWhuSk1GVU9WekpFQjFMbENVQjRKZnJmRm13SmlU?=
 =?utf-8?B?ZlBSaWR5cFY3SWE1R0VhM1QyRW03bFJ0K2ZEM25MTjA3WTNtcmlsZkgwZDBY?=
 =?utf-8?B?Y2tXTmkySGFLRUR6bWdwT0hoOEJicmRCYytsaXVydE1HSGlhWTFLbkg3VDhr?=
 =?utf-8?B?bm5ybDJYcGw0bTFMTm5ob3ZQWnY2dGEyUEhIb29TcVY1YUhBcXBwSkpjY2NW?=
 =?utf-8?B?SGExVnE2Z2FhdVByOU1PVi9JZWpkV1dUblJDeW5xaTI2UEIrZ3BzNTdUMmZW?=
 =?utf-8?B?bHU3bHVud0crUENxeG1wV29BU3BrbUx2aGxYTWR0Y1dtQnMzZU16bmVLclkv?=
 =?utf-8?B?RnVOTDR1UytaWEJ1eXRwWEFXZFFXbTROYVlsKzMvVzdxdnVsaFRYNXNyWUl0?=
 =?utf-8?B?TjhCNXhJNENlNmFNVXdRTkFrSEhvQVA4SGdSazRqU3lxY3RLaVVMT0VhTzlt?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1+ygmnUwHXAjMnYzrrOv8ACp47/wgvdjPrB8vc0KumtR8UMzF0n0JbEd/0Hk5aULNvY69tB5UnKIzVh4gLwtNHMv9mBeuQW9OmeflvcoHMP3tSq5zbgHwK9bs1JUPqeH7CNtrF2Px6jknfOVTkCtLd7yFvpj1REiyj73F011XE3Bb9zwJosWU5M6j5XZvbx4ytMh+WVUikaYXOuInPrc6zNjdcUQJofmBuGlRgCAQlWCS0gYF1DYaHzAMGlWEjgQCgmtR9AlAQObpZyUYOXR0owa3olXzI/TRwRl6+cnyJirwsbFoLki5l60ZpfK1AFpCeP2p2GzS4AGs2oXMaNuC+eOLMMh37Kn86RAurqdhE6crO/LeQO623xfDcT6R0T67CmLhlW/SBAxAPFPvHyn5N8qTauskfB2U+v3vFsqE83Cd1rBLJPENCN0htEJsYmS0UZrTLg8JnbFPcYA6CmyF6kXXTvtwFfOoyAJEROeGvIfUn3wyb54Vp10awWA+R7Dsghn17ujf5mURztkv8B0JwhE/mK9LIBvK6mo4FZa3SvXY5YEB3cO6T/eUZkSjihmfHRPcB1rzqu1q4usTtLXtdk8vDleH2AjJpu8ppSDasI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c1f9fd-bee5-4df0-46b9-08dd1de792c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:37:39.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx1RmCS913wr9/Rbd+VSbCse3u2p24q7fqOml9FY/CakdTzA8t2lrH1r7ED5MmBbxqLeWj3qAPrrE+YLBOf5RY2RgwD1dJ/vlMSaxEbm1do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_06,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=976
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160130
X-Proofpoint-GUID: s_gTHmu4yKi4zuRzlCLV1Uw_iuKpKdYT
X-Proofpoint-ORIG-GUID: s_gTHmu4yKi4zuRzlCLV1Uw_iuKpKdYT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16/12/2024 14:45, Avihai Horon wrote:
> On 16/12/2024 14:00, Joao Martins wrote:
>> On 16/12/2024 09:46, Avihai Horon wrote:
>> I also have a much
>> smaller series for that sort of unblockage that I can give you a pointer.
> 
> Yes, if you have it at hand, that could be useful for testing next versions.
> 
>> Though, eventually the optimizations we will do for VF dirty tracking for vIOMMU
>> will apply to IOMMU HW too just so we minimize the amount of calls to get dirty
>> bits.
>>
>>> I didn't test it with iommu DPT as I don't have access to such HW.
>>> Cedric, I remember you said that you have such HW, it would be very
>>> helpful if you could test it.
>>>
>> I am starting to prep the unblocking vIOMMU for Qemu 10, so I can validate if
>> this series works as well -- but from what I have looked so far it should be all
>> OK.
> 
> Thanks, that wouldn't hurt :)
> 
>> If it helps I have some pending series that lets you test emulated x86 IOMMU
>> DPT support (either on intel-iommu or amd-iommu) that can help you when you
>> don't have the hardware to test.
> 
> That would be great, I didn't know such thing existed.
> 

I did post it, but it was some time ago (2y). While I got some comments, but
failed to follow-up:

https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/#t

The link above has bugs, but let me conjure the version alongside vIOMMU and the
other stuff I mentioned earlier.

