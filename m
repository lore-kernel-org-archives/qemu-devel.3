Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A487C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 22:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf3ye-0001w6-6O; Thu, 24 Jul 2025 17:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uf3yV-0001tD-Ca
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 17:59:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uf3yR-00016l-Pu
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 17:59:38 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmMj7019869;
 Thu, 24 Jul 2025 21:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=76HPzS2MDWILV23mzrbGgc6UDK9xZCS2XUiaV9eXc5M=; b=
 Qrrlpe4RRcCp8G4LKZqfSvGQh58oXJbKLjdLgFqMJa6rv7p7n8pLLkRyBFXLeHAn
 LJ234TItxZI9ZKiwzKUX0ML1a8FVBTV3QeNYUbwyJqQTSRVGyvkMHzVc4CpBXpgR
 U/m67hCxoi9VybbB0IcJ5GWaWyCJSv62jxPAxViLiCggMP7/hlrEMsp/8YyH28tM
 nBOOPATpG2j43I8yyWFXQlBrtAArcMakSbP9AwfnfAMH+48AKaP5xx6IWfpDr9VY
 1PR7IP9WRZ2Pd9MRKNsh2pYDTIwiG7OCjzuP3Nqzy6yW4SaMYW0SO7Nvzx+qX8tQ
 dh2mToEef/ZZJTNeTiqTCA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k00b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 21:59:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56OKREI4014457; Thu, 24 Jul 2025 21:59:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4801tjq8gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 21:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDPB+u7DsBaaflZwah/XK9PEaI0xYr9xPUJo4Kfy3UYyOaEriCKgXpPV+ETwkr3kgXtuTehQcwOvlPgzwKs9BAx8mDK7kh9TNqmidWBFvSd6np6E7gGG9GspiFlsBP6B3uRndEjY2CXpX9a+ytgJtVv3yN+vVvNArkdXK9VAtpaAbF9XVKPMYQ+b7kGKpmCnru6QkR0ygFJbIKYWg+hikkWE5xNy2cjfNY1IHvVFYCUO3x+lzvL+LH8SiORxKTOWIzfh/r9EHZvIuQ/AlYKhMDhlZdrUNLrrPzvjWrV1waAX4dH+wHzOV8CGADfI4EG4Yrmv6Zpp/kqECo4Itr6dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76HPzS2MDWILV23mzrbGgc6UDK9xZCS2XUiaV9eXc5M=;
 b=YobG1h2i/Rl2Sjd8LMuZyHKVbUWWNTos7y6mX9MH6iMRHITbk08RuUSSRBE43B3xBFfXaT4Lwerj98YTMKVXjdgr6MPKtXxnSxQ/Q/OnTRWg2kW+///FK0OxeU/y2C9iYYeZA6foPDarqUxO2pRQ1OVbzCjZcvrOVb7aAru0+VkpIiDcBmVFwyi7d+v0gMxmgjfqePE8xnshAh9+XEgXbAs2XPskIXn7/J01hz6oDGD+tmwtoyBCsZGQbDMeLgODO4tvRSf1fjqbUtxcdTJU3HHmSQl2SpM42KloIogpnRnhznbvqE2x4rG4qXb+P4IGZYw/KT2xK3T3CuU70q/y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76HPzS2MDWILV23mzrbGgc6UDK9xZCS2XUiaV9eXc5M=;
 b=G77f6d5FD+ETS1b4nA2mRIhYvNw1I5CIi+Cr+g55R7DzsrxdrYr6lP/vQVrSTWrMGG7JKmQOzVY64/1H+LrMsC6A7EDIrrSibwXT3CXLTXJIjecunlK4gCuOB1FnMECefMG6AAzWf1FMk3o31Q+T9agELwQzdXEY/Tb9kQPEvGU=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by BN0PR10MB5094.namprd10.prod.outlook.com (2603:10b6:408:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 21:59:23 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8922.037; Thu, 24 Jul 2025
 21:59:23 +0000
Message-ID: <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
Date: Thu, 24 Jul 2025 17:59:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|BN0PR10MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 771ee927-31d6-47b2-c0b1-08ddcafd598a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTEyaHNTSHd4TVFuL0F3MWQwdEtDNEFySW01QmhOWk4wSER4TW1NZ1JuM1lo?=
 =?utf-8?B?OXFpZmVYZHF5OGttYW1lWE1iNlNGdnA0RVU2YUNMY00ydTgvMCs4OHdwUUZu?=
 =?utf-8?B?emJPbGxpK0dBZkY1UFhqWWZaSUovTHB0MzhtMHI1Y0FzWUNFdmZiN2plU0Zp?=
 =?utf-8?B?QnUweUpKazVOREJQSVd0M040TFVHWjBYeWdUdjluL2NleFRkdThTZU1QZGVL?=
 =?utf-8?B?Zk9FNDhva0NoSG84Kys5cUZMamxOTFNlb2FzT0ZmL3E4WVBRcVp2V1BFei81?=
 =?utf-8?B?Y25IWkhHYU1aeisxRGRvWlpoTWx2MldLNlh2Y0pqY2JGb05UVEVKai9ab3M0?=
 =?utf-8?B?VWMvOWFuWkhpOGNBZFJkYkpQdjNNc1puaVAwVUt5UDdxSVJPYmFaVFVOQ2Ro?=
 =?utf-8?B?ck8wYjBJdWlZcjg2L2JGZTJacjVjY0ZqOE04Q2Vkbk9HdHh6eDE2cFFiazhv?=
 =?utf-8?B?c05yZmdkbzJvUzRXYkZPalkrNFA2c0xTWE0wR05DM1FMVDVZNFhVS1JySDd3?=
 =?utf-8?B?NUx4VFNZajNLUjFuOW5oSTZBZUcwcmwxNStRZWxLNUU0aEY2RWtqd3RMRmxO?=
 =?utf-8?B?NnhVL0ZubVZtUGRGSVJ0VXU1RzlRUVpiK2tCWkI1VUFoa1Z5Z2VhMkxHZVpw?=
 =?utf-8?B?MW9PZG81ZUFBeUJpVXFGSm92WCtUc3hQZ1l1anhiWVIxQ0RRT2gzZVhTMGZR?=
 =?utf-8?B?N2c0cFN0cTZhcmMyRTM5bUp0bWhkNVpCQXBYbXhVYjdiK3JybDJwY3dGTEtC?=
 =?utf-8?B?S0E2Rll6OU94YVRFSVlMYzA3TWFVUWlIZnpBY1Y1WklEQW4vdGlnV3pSdmJS?=
 =?utf-8?B?UnZUczIxMGxNTytxc3F0NFEwZVdlZEFnRm9YcDQvT0pSK0hBenZoK1RSS2Jp?=
 =?utf-8?B?WCtjei80bUxxSVJwWE0zWEZuTFB5Qmo3TVpVeU93NjJPNFVIZEQ3cmR4VnJH?=
 =?utf-8?B?MkdpU05TdjJkMjY4ZmlRaTVpVUNmN0NEQXRFWkQ0S2dMT2pFNnFSbXVCVVpN?=
 =?utf-8?B?NGpkSTFDZGlZNXlxZmdFbG9VV2lxak5vZnBlOUh3THpwZFZPdFlnb3hBRmJF?=
 =?utf-8?B?NTBpSWIvU1d4aWFiZWZwcEZ1TW1iMDRnZzRvYVRVWFNOaGU0TkNuTTMvbHp2?=
 =?utf-8?B?cGN3bEhjWWRaMkNXNE5uaUVxQjRBbWoxRUVTZEZtdzJ1Z2w0YXlLM1BtTE9i?=
 =?utf-8?B?VU10MTlST1lNSlF2eTRTQ3pOWE5qdmRFM2ZaZmp5N1U4WFcxWDFRTWRqbnhr?=
 =?utf-8?B?Y2hQanhWWDlUSHVEMWJ2Z3ZQRjFhWEVNSmdpdEhKaERDN0Rxd2FhdjFNRlNP?=
 =?utf-8?B?OHB4YTE4VmI2RzI3V1ZOa0J0VWJqOThHMUlFRG5Bc21FYlZ5aEhHSUFpLy8y?=
 =?utf-8?B?STYxUmNrbGg0K0hrd2hBUDUrZmNlc3BZdDZpMy9wQ21zUDFjeko2QXU3eW1u?=
 =?utf-8?B?MjFoVDVjYW4yRWFLSU1rUjQvOFpPVnBNeE9VUDJUcGJoSlBMWHJHZnBRcVJR?=
 =?utf-8?B?cGdnMi82eXg1amdQNDN3NldWUCtyUlV1dHhieUhscWFBcDNCNGU3NFFYWEtq?=
 =?utf-8?B?enpJaTlYS3RyRDdPc3l3WmxtSUJ2QldHZ0ZrWDNhbmlVd2V3M3NvejVJMlAv?=
 =?utf-8?B?UzUvUWJoS0RMeE5ZTnU5UWdWZFV5KzZFRUtUSlpyZmxxSjE1eW9mdzN4RHNP?=
 =?utf-8?B?dmllc2ZXRWx6Tlh1SWJ3dXJnQlVFZHV3SmNoUHhZS2I3cG9rRzUrSjBQOHlC?=
 =?utf-8?B?VXdrK3ROSG9mclBDN04wQml1OHNsem1PdjlwQ2prbFFyMmRQUE9yS3REZ1JZ?=
 =?utf-8?B?S3p1ZUdHcnYzM0ZBZjRpZmdLNi9PcEtOV1oybS8rVjRIcjkvNjIycm5BY3hB?=
 =?utf-8?B?RWdlcXZ3OFNNb3Z1MnhoUHJQamdGSG5PVHIwYmtpUUxUZCsza1l3Ri9IeE9l?=
 =?utf-8?Q?0pekMlsCRYA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJBVWRyc05ITkE4ZTZkVUJCbW0rNytOMW14Ny9BaFYyb2RIY043VVk3Z2dr?=
 =?utf-8?B?bk9CbVV3MTNvSWtXa2I1dFJJQ2w1ZEprbU5Ub2hFZ3RXVmhRS3VPOHJrdUhV?=
 =?utf-8?B?UTJUU2F0S3RWSk01aUlQbTN5MUhOeHdMNCs0emJ4ckZGa05uWUpZdUhDa2pY?=
 =?utf-8?B?TmZybzVERTl5TXNVRHY5YUd4VHdqV3JxOWtRalR1RVVXRS8vUUxWWWw2bTZQ?=
 =?utf-8?B?TjRBVzBBTUR2amd5ZFcveVJVNWl0R1Q1K3VMVnN6c3ZSNE9XQ2p5WUgrbWE5?=
 =?utf-8?B?UmVZNmYzcW42dEltbEVGNXBTNDJGbnlGQTYycVozcE1FdjhndlJsUDRuOUZn?=
 =?utf-8?B?K3NQMDYrZEc4R0czeTV0SUNMaXdwTjdSWTYreTM4V0laVUFtSm5SQzB4V1Jx?=
 =?utf-8?B?aStsR3UwcXBHY3preUgwVUZBTFpvclRNYjJTSjdVR2JmUWNEZlhaNXRPNmhK?=
 =?utf-8?B?aTBPU0tqUkJPbUhJVVJTeWMvR091K2l5K2ZRY1o1Mk9PeUVHLzhaSG82aGVQ?=
 =?utf-8?B?S3U5Um9tTW43QlgvRGU2V1NQb0VVQ2VXVDJlWUh5YndndCtrMHI5TW9VM3lv?=
 =?utf-8?B?SjZsc09tQk42TFhUUzBNQ2JhOEFrSWkxTUh2V1h6VW5XbG4xK1lIZE9HV0VK?=
 =?utf-8?B?NHBlVnluZ2xpVWszbkVROE45U0hGdW03RlIzV1d4dXJGS1JNZ1Q3aktyakM3?=
 =?utf-8?B?TEZBSjNKQzhraEN1L2VJUzhCVDN6WloxMTZsWDR6YkRoK0FWWEVpMEFMRXZD?=
 =?utf-8?B?eEJCbnU0ZEVnUjNCalZJbEhteVZjVG0rOVFnS1d5M2ZWWDQ5cWRSNmMxcGRG?=
 =?utf-8?B?MmVOV3V6eVlxNEw2NWNxa3hJVWlRQjVkaGpKbWFHVlFLZFMvRzUxZkVuVkVT?=
 =?utf-8?B?RmFFZGdaRjJDVm5SOEdNM0lnNmRZOHJMYmMzRFkvRWpkOWltTVZrRnV4ZC8x?=
 =?utf-8?B?aXR6aGU0OTlHOHExRFFza1BVMFE3Y04yQk83aGtKNisrZHZ4WWpLT3hBWG9n?=
 =?utf-8?B?TW04bVBPYXl4d24rN0J6Z3pueTVxa0ZtejBOWjhNSm45LzIzSDZRdXBIT0kx?=
 =?utf-8?B?UndBbzBHVVJXWFNQeG1ycXdjSk5Xck1hV3ppcWtyeFF6L0pMWUx4MEZyTm1w?=
 =?utf-8?B?TGlQOUhuKzk5Njd0NVBVTk9SY05xK3JDRU41dGJxOXN6TlRLRzdWbEhDMlUz?=
 =?utf-8?B?TjFIL1gxbmJFUURPWlZTb2lnbXIwNXFVR3g3UFUzcHdwOXFaOE5xMmg3SGlx?=
 =?utf-8?B?NjRrdkF5N293b0J5bCtqQ2FhcnNPUjk2Q2RROUQyTmwyQVFYWi9zUi80RE9t?=
 =?utf-8?B?cytUR2Z1YjZGSDFtckRRQUo4bjZhckJkRFFEY1ZGcE10OWFHN3lwblZraGtM?=
 =?utf-8?B?NFdrM1NaWHIyU1pTeThsUGFhWXBiT1FWVGd1YUhNWitlYjN6dk8yVmt4bG4w?=
 =?utf-8?B?YStmWmpUTzJrS3MvUGRzaG1jUitZQzRIR1RuWjVHcEVMZE12NFZhRFRudERM?=
 =?utf-8?B?VkdDQUJzQUMxZHQ0VDJIK25mbjZNcWkyb2FJM1NTczUvUnk3eDdHZGpqVmVT?=
 =?utf-8?B?anZMNzh6M2luMzFHanAzUVVqWDZSclJnNUZqZEtHeXFMU1Y2OFRzaTZjZW1P?=
 =?utf-8?B?dnVaNHpucllFZ3hELzFDeXc2SDYwS0lhc2hwbGlHTEtUK2hycXNYbCt6N1Zu?=
 =?utf-8?B?SExJd050S1N3ODlhWWt4a2dYRk5XNWJXMjZEQ3NzUXhXRUEvcGpqYUdNdTAz?=
 =?utf-8?B?b2JuckhhWkI5Y1U4Sm1aaVkxN2JRS0ZDdTBqSEZRWkZiRHcxeC9Vb1lhYUU5?=
 =?utf-8?B?MU9ET0JTRm5uMytzK0J0VHdzVkpEdU4xVEtVV1FuZmtlcEsxOXpNT0JiR0wv?=
 =?utf-8?B?NFFCTU1wSExpWENzWS9KZDJxUzNXNGRDOE5id3JnazlLUHpjQlJpeExXNlFp?=
 =?utf-8?B?RDQ2aG9RRURDdG1xRXRXS0ROdjNLZW9uMGJWdzRqWHFZRjB6WUFHUFN6VmtL?=
 =?utf-8?B?NmwrVDZKSWtSMlp5TDlnWFZYWlMrZURSaGhodGJJSTVMeEhtc0dxbFRReklm?=
 =?utf-8?B?alVQWVNLeVZEMkU0SmZIOFlBdHFNRXU0eHBLZEFQc0lJVEk0L212NnlONFBG?=
 =?utf-8?Q?irNv2usylk2UVap5PnLiQ72Z/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6URmQ2os+CAxbmeLPJYcBDfNu6s8u0fKuZGpcKW80PkLymN7NX7GDdn8rRxZ5EbYbETHQ13Ko7Q3khIL9bw5rktGCf7nURH7/AKLmDgAHF/8Rlk/PTkUFU/h9IMWI8wasc57K+crnVS2ASiLspb152cglQHwEAW8k8JCGYW+TMp5VBGLyK9OSJOrfvVrNDAcH+kSsCzqpT4BkYohJGFtJ0AMNexCLG+/A89W2MGsLHxKct6ffOv3jFBdxUEy6wr56/GnOj0tmjbqwcULTGbnQzzFBB7FwLKYLT2FaQpQBJ/6k6QBJxov1V2Nnz29VY0GmtH3qAkpvUskEUpaz+2jm8xt4pus6XfI3JZVLWWzQAnbIGa3jMJaHoNuNuFwwTt/2Hnb/M/Cls79J4KbSI9Lb1ulQWwT/+ImbDhh2/jB+9PUW5zA/i2bxHJuo6oxylJmID7iVMGsOuUeweucxUyTxm9ZE5BwVdEYmCh5UZ2K+qquubTq6SyXkDfzqr7HklVvr6B5iMiidSgD4D+Jz05w/jt5A2ldcPnF1wBdWORXLIXdtZU+AeIaTzSWU19X4EbSTLr5r/3kgqMilxtzhB0ehSPbp5QvEnQiznGDycMtDIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771ee927-31d6-47b2-c0b1-08ddcafd598a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 21:59:23.6397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RJeb10RCklrzuodjMNwRgpUbrjiUT/y6x+B/lbYpo+e5ByqNyKCLAy2OYpNOQ7+eSm7GGzCBOUghO+K7yJsyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240172
X-Proofpoint-GUID: sR4MtAsvV5Vs9sihZTmAwU4SJSjvI5f2
X-Authority-Analysis: v=2.4 cv=LYE86ifi c=1 sm=1 tr=0 ts=6882acc4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=h0m-eUshs4MiWgnnmqUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE3MiBTYWx0ZWRfX1limXWXvQYFc
 Ye6MPwg1UClQG5+TBJcVyDCACR5+0ldLp5pXbVpkX5agPSBA8oXECCbWBmv9KxJw3LHFkF/MqfI
 JjCGwezrcwiNxmsRJaeUUHYfiNdBuOqg7b7CkowyIvBsf6qfvNgdUbhkowKsXrq+4pwjHaLKkcu
 dKJIYNalUZXJYp5ypR2tdgup2IJ/EWBtKwaiMKxeoTzSNLtcPlPyKrbR3/GQVrRj0qkmyGjSNlS
 hugvu2aSwaeuU8fKSOXwjXCDqb8Fh1PQofgGw6uKjKSBz9avyvJq4XVc/vmv7l72549OSUwGz4M
 7DwTgeLk7KGkM+1dVnLaOThknnJIHPX7/wJ6PnfRKeUY0mm2LXqwqeMaAbz2IfLlwQNITMKC4so
 ZLuxIcdG3X6r/eiGAIWYsHnJKXs8Wl2aBcWxAThGKsn0H3dSyEjPtrf8aBBbseHBukzgf3F7
X-Proofpoint-ORIG-GUID: sR4MtAsvV5Vs9sihZTmAwU4SJSjvI5f2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/23/25 1:51 AM, Jason Wang wrote:
> On Tue, Jul 22, 2025 at 8:41 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> This series is an RFC initial implementation of iterative live
>> migration for virtio-net devices.
>>
>> The main motivation behind implementing iterative migration for
>> virtio-net devices is to start on heavy, time-consuming operations
>> for the destination while the source is still active (i.e. before
>> the stop-and-copy phase).
> 
> It would be better to explain which kind of operations were heavy and
> time-consuming and how iterative migration help.
> 

You're right. Apologies for being vague here.

I did do some profiling of the virtio_load call for virtio-net to try 
and narrow down where exactly most of the downtime is coming from during 
the stop-and-copy phase.

Pretty much the entirety of the downtime comes from the 
vmstate_load_state call for the vmstate_virtio's subsections:

/* Subsections */
ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
if (ret) {
     return ret;
}

More specifically, the vmstate_virtio_virtqueues and 
vmstate_virtio_extra_state subsections.

For example, currently (with no iterative migration), for a virtio-net 
device, the virtio_load call took 13.29ms to finish. 13.20ms of that 
time was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).

Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueues 
and ~6.33ms was spent migrating the vmstate_virtio_extra_state 
subsections. And I believe this is from walking VIRTIO_QUEUE_MAX 
virtqueues, twice.

vmstate_load_state virtio-net v11
vmstate_load_state PCIDevice v2
vmstate_load_state_end PCIDevice end/0
vmstate_load_state virtio-net-device v11
vmstate_load_state virtio-net-queue-tx_waiting v0
vmstate_load_state_end virtio-net-queue-tx_waiting end/0
vmstate_load_state virtio-net-vnet v0
vmstate_load_state_end virtio-net-vnet end/0
vmstate_load_state virtio-net-ufo v0
vmstate_load_state_end virtio-net-ufo end/0
vmstate_load_state virtio-net-tx_waiting v0
vmstate_load_state virtio-net-queue-tx_waiting v0
vmstate_load_state_end virtio-net-queue-tx_waiting end/0
vmstate_load_state virtio-net-queue-tx_waiting v0
vmstate_load_state_end virtio-net-queue-tx_waiting end/0
vmstate_load_state virtio-net-queue-tx_waiting v0
vmstate_load_state_end virtio-net-queue-tx_waiting end/0
vmstate_load_state_end virtio-net-tx_waiting end/0
vmstate_load_state_end virtio-net-device end/0
vmstate_load_state virtio v1
vmstate_load_state virtio/64bit_features v1
vmstate_load_state_end virtio/64bit_features end/0
vmstate_load_state virtio/virtqueues v1
vmstate_load_state virtqueue_state v1  <--- Queue idx 0
...
vmstate_load_state_end virtqueue_state end/0
vmstate_load_state virtqueue_state v1  <--- Queue idx 1023
vmstate_load_state_end virtqueue_state end/0
vmstate_load_state_end virtio/virtqueues end/0
vmstate_load_state virtio/extra_state v1
vmstate_load_state virtio_pci v1
vmstate_load_state virtio_pci/modern_state v1
vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 0
vmstate_load_state_end virtio_pci/modern_queue_state end/0
...
vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 1023
vmstate_load_state_end virtio_pci/modern_queue_state end/0
vmstate_load_state_end virtio_pci/modern_state end/0
vmstate_load_state_end virtio_pci end/0
vmstate_load_state_end virtio/extra_state end/0
vmstate_load_state virtio/started v1
vmstate_load_state_end virtio/started end/0
vmstate_load_state_end virtio end/0
vmstate_load_state_end virtio-net end/0
vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net 
instance_id=0 downtime=13260

With iterative migration for virtio-net (maybe all virtio devices?), we 
can send this early while the source is still running and then only send 
the deltas during the stop-and-copy phase. It's likely that the source 
wont be using all VIRTIO_QUEUE_MAX virtqueues during the migration 
period, so this could really minimize a large majority of the downtime 
contributed by virtio-net.

This could be one example.

>>
>> The motivation behind this RFC series specifically is to provide an
>> initial framework for such an implementation and get feedback on the
>> design and direction.
>> -------
>>
>> This implementation of iterative live migration for a virtio-net device
>> is enabled via setting the migration capability 'virtio-iterative' to
>> on for both the source & destination, e.g. (HMP):
>>
>> (qemu) migrate_set_capability virtio-iterative on
>>
>> The virtio-net device's SaveVMHandlers hooks are registered/unregistered
>> during the device's realize/unrealize phase.
> 
> I wonder about the plan for libvirt support.
> 

Could you elaborate on this a bit?

>>
>> Currently, this series only sends and loads the vmstate at the start of
>> migration. The vmstate is still sent (again) during the stop-and-copy
>> phase, as it is today, to handle any deltas in the state since it was
>> initially sent. A future patch in this series could avoid having to
>> re-send and re-load the entire state again and instead focus only on the
>> deltas.
>>
>> There is a slight, modest improvement in guest-visible downtime from
>> this series. More specifically, when using iterative live migration with
>> a virtio-net device, the downtime contributed by migrating a virtio-net
>> device decreased from ~3.2ms to ~1.4ms on average:
> 
> Are you testing this via a software virtio device or hardware one?
> 

Just software (virtio-device, vhost-net) with these numbers. I can run 
some tests with vDPA hardware though.

Those numbers were from a simple, 1 queue-pair virtio-net device.

>>
>> Before:
>> -------
>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>    instance_id=0 downtime=3594
>>
>> After:
>> ------
>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>    instance_id=0 downtime=1607
>>
>> This slight improvement is likely due to the initial vmstate_load_state
>> call "warming up" pages in memory such that, when it's called a second
>> time during the stop-and-copy phase, allocation and page-fault latencies
>> are reduced.
>> -------
>>
>> Comments, suggestions, etc. are welcome here.
>>
>> Jonah Palmer (6):
>>    migration: Add virtio-iterative capability
>>    virtio-net: Reorder vmstate_virtio_net and helpers
>>    virtio-net: Add SaveVMHandlers for iterative migration
>>    virtio-net: iter live migration - migrate vmstate
>>    virtio,virtio-net: skip consistency check in virtio_load for iterative
>>      migration
>>    virtio-net: skip vhost_started assertion during iterative migration
>>
>>   hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++------
>>   hw/virtio/virtio.c             |  32 +++--
>>   include/hw/virtio/virtio-net.h |   8 ++
>>   include/hw/virtio/virtio.h     |   7 +
>>   migration/savevm.c             |   1 +
>>   qapi/migration.json            |   7 +-
>>   6 files changed, 247 insertions(+), 54 deletions(-)
>>
>> --
>> 2.47.1
> 
> Thanks
> 
>>
> 


