Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC06AC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tct13-0005Im-UU; Tue, 28 Jan 2025 16:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tct0u-0005HQ-2O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:20:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tct0r-00056z-Kg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:20:51 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLBkHW013396;
 Tue, 28 Jan 2025 21:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=06bwHF5wmfruBZ2SZ34aFcZsZK0aeLkqfmveZqGOJzM=; b=
 aDF6qorLGvf4MjVYy/NNbSTDUKyM4lA0faoLeHEN8dItxfGcHLggMCtp4j9QRstc
 lHREGGACnEEYWhZgImTp6yZE8tNyIJOQADI30ZBnkSqM/7poo6zBs0RrrmbMStHT
 dhGdUTHEKsPUW493GfO6wlMavJnjobh7cKNGTMmOwhPxm4/1rgrzVwJhioY3glDj
 /J4hkBKoKEPd0ej0oZ8qbACfozi5R8dvA8QUm2HEaP5qITnoECg7WMRss+7xmPoE
 LQkrn+h7BEpSKqTp239yWAEkiCuAD9vPdPCFlAg8nvvvkXpuxlNvXnSWj/Zb5U2j
 5j/xi+tZMCIWkE1hu2x/hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f6btr3dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 21:20:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50SKaYuj034229; Tue, 28 Jan 2025 21:20:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd8w9xf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 21:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDST07yopfIOgg3s5ZjUEO22f7KqUDSCig9jH59fr3r1MKsKJulrgy7eKvrW2p6fmIf71yF+MatFTdb+WSDvUCLevF5s8YBASdpEXE9rMPAfCM5s9toBdCZggdcCjXlPjESleFUDoc/vdSM6o3wtsthYvgj4fnQk6Em4HcvmKQ+uRW19f+3GGp+sfYIV7+3gnuuQ+0N95Wd8j+zvAeTo/GtFIisjmUZjUBHKVPSAiIcml6yvPzZi44EBoQK4RbIsq2At7fc/IXut+GMuGCzDyGghTftZ66ioD5Zl4Mk6ilWX17VO5JGVN+S6btAAuPoUGjP9fstit57MHhg7EKR2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06bwHF5wmfruBZ2SZ34aFcZsZK0aeLkqfmveZqGOJzM=;
 b=K7Zzqjp6UVNAYDIVh1gMc3uj7eJM2Wu0re7rhwAyOMKmQ9caVfitDiqkAeZ/jSNWen7VrxCGEtS7db4rXBJMf6fYDp0S/PdrNqlXUY/aIjDZPAcn3IE8QaOjzIjkaSWSkW018TLShieBj0/wqzCx1FV+F/nGIlPUXZiAASALaKG/wxtEQQkuTJ5yD3Dm+8+6y0J8hXmuFMcYRntoHpNY33yXOTUjfhpleUPMxJE2NdkXn3rR25i2bkOqmtIvT1smCVTy3DxD12F0X/Ax/SoBYkC3Fib2lCU+ym6bTh+Sz0rvXPWjXMqSRKo5Ofr3Zf3hyWnnIhCdOHmLccNTKDd0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06bwHF5wmfruBZ2SZ34aFcZsZK0aeLkqfmveZqGOJzM=;
 b=Rr5EmrN5E9dvhpFuXF5l0DjbD45IsKmEIoNdyg8cfEZ6pLOcyy7k8kYK7Flnia79o4kcGvZS8XktN9FBE2a4uBfxdh7RunSkjkd5n20TIoVjjiUSQ4SiikcQlOh86K3VV2+BBabG1emnFnjZ2vmw2M5ViskauGi720bVPFKFv8Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 21:20:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 21:20:41 +0000
Message-ID: <a7af45f7-cd65-497a-9b20-eae6a0dab361@oracle.com>
Date: Tue, 28 Jan 2025 16:20:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/24] Live update: cpr-transfer
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <87y0ywqna1.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87y0ywqna1.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f58b18e-8c24-40ba-43f2-08dd3fe19e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlVkbVQzektiODNaQy9tZHFJM295bFp4RGpzM21KRTRLMkNYMDEzQ3NEQUNC?=
 =?utf-8?B?NnlNUFcyN2oxTlE1b3U0bXE5UjNxem9SUDZEa0NwTHhEK0JyMEZZSkJuUWwr?=
 =?utf-8?B?V1R0N0VoMzRXUE1HbUpzYy8wS3lJbUVBckczT3hHWXppaGhBcElWRlYzbllo?=
 =?utf-8?B?eDlmZjM2WGdHdTZWd1lhcXBKSXYrNWJ2bUQxNGNqRmNKYTFGSVhlVnhYMmFj?=
 =?utf-8?B?SnVqNDBKYSs4dk0yZTVEY0xWRkwreGZWWTRqNkptcnJ2WnJIS0x0VXd2Q3FC?=
 =?utf-8?B?WjFrTjlraGl5a0poWnc0ckZxQ212L3BlVEdpNFFzN0xnQm5oMHdCbndxZGxH?=
 =?utf-8?B?QnYyb29QdjBRdHVtdjZPNzk4YWZjMWJJYWZ3TDd3bmY3VUR0T1cxSFhpZUtu?=
 =?utf-8?B?N25VVTd4VUZ6T1BOZkI1T3k2TDVzaEJDRWVRQWFZcDZhaFBWeWYyTUpCT2pI?=
 =?utf-8?B?emJUWmQrSkY0aDkzK3VOR0pHd3BxWDRvZDVFM0JMcDJoOFR3VnZ1SzFMN2JW?=
 =?utf-8?B?YjQ3MlBHcUVtTGp5YmdtQ0dXdXp4VmZEMXNxdmZnaWZpTkdiZTRWV3JKUzE2?=
 =?utf-8?B?cXBDV0VmZUFXVXF5T2JyOUczM21WWm1rL2g2aGRHUWZSWllsWVRGMGdOZXBm?=
 =?utf-8?B?OGxsczlUN1VtbjFDbW5OTkhHcE5uYnBvKy9LSExRNkxwQUxtZmt1TGVIVjBy?=
 =?utf-8?B?emNtUHBYWUdFOXNUZmcvRU9iZVpSMVVwTTJvVlppQnpueGczdUZucFEvQmpE?=
 =?utf-8?B?c1NoaUhnUkdsbVdaN2YzYmhHZ3paLzdNVTZDYmRQdTB5ZUUzbDd4eHVYWXFQ?=
 =?utf-8?B?eDMrSFo0aUh1QVo4c0RNV2FXQWlsd3BxNEZENGE3NGh1WlM3TDhjM1lra0xJ?=
 =?utf-8?B?THlIS1JmVDBSM0dENStqaUl2OGE2QmF0bEJyKzdmdWQ3YllFbzYzZlRRV1NM?=
 =?utf-8?B?NjVRMWs3bG0wK00vVFNXTUJtMjhDT003OGlPZkx0TWJVNDZqbFBvZGVQYTBn?=
 =?utf-8?B?bnpzMnZ4enU2VjBSVkVUUHA3S0R2b3ZhNU5aZy9DeGtKWmp0QVFjUHBtR0hB?=
 =?utf-8?B?VHdyOEdKTUNiQ2JVNHp1Yi9xWWRMTmdCcHU4UHV3OHpVb2FUczVqQlE1UnR2?=
 =?utf-8?B?Y1ByKzRleml1OFYybnZaaENtS3RoWGdtYjR3eG1udW9ObHE1dFdpNGg2Ri9B?=
 =?utf-8?B?RlU0NmU3T3R6VWNHd2FPQjdoL1ZBdTJNcDRvSXFSZjBlc0ZkdkkyeTExbHIw?=
 =?utf-8?B?V0FxQ3EvZjdXenNta0Y1azhBaTFaVWFyZFVJVXBLeGlvNU5nL05razdNLzda?=
 =?utf-8?B?akQ1SG9jM2xUcWkvWnplakVFTmtqUWFxM0dORldnRTA5SUUzZ1JQcVdWZGIw?=
 =?utf-8?B?K05GaGwzd1J5ZTZzVmk5NzFRZTVDenM0akwxMTF1cUF3REE5eFVNTUliYlZw?=
 =?utf-8?B?cW9iRFRxZmRkc3haTnBtN2F6OERGREM5U3ZlQXdmSEFWRmdkSTY5ZFoyKy9y?=
 =?utf-8?B?dDdIWnltNno5WitTWTAxOTZ2elI0MFZYc0l0bmoxN2FHa0lZZGZsNk9XMnhk?=
 =?utf-8?B?YWY3b2JnOUFhTVZVM0wvaHRLQlZ6K3pob2pUU3djeXBKQjltNnRiWkNMK0E5?=
 =?utf-8?B?ZG1NMitJY3U5NjBtaGVtYlBBWERrQTQ5a0c5S3BTaVdOSDlaaGx2NGlaZE9B?=
 =?utf-8?B?VS9CWHkrK2VLcFBEQ2Q2aTFyTThRSXk2dEdoeGliYi9XMDkxYkZtaUFic3Q0?=
 =?utf-8?B?d01MRzBJckM4VmxaVG9Udm5iNUVSTTNxVjQ4QmtjcTFtSHlJelNPRG14V2c5?=
 =?utf-8?B?bEFDUGQ3RHhWWXpVZEVRd3REeDE4c1A3bzB3QzZaVk5FcWdLcnd4ZStHVDRS?=
 =?utf-8?Q?dmeiZ7S5X/sYJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9raTRMK3NqWHQyRTdUODhZWlBoSHd6NEhFM1orZlFwdmsyUVdxRm5abytQ?=
 =?utf-8?B?NDlQRkx1aHZWTkNEYVlXVytDSDdjanIvL3hBVk9jVlBzaFdRa0k0ZnJXYnRz?=
 =?utf-8?B?SzBvNnM4aEEzZVMrVmRPVk9nMXNTTWJKR3BFY1c4dWlibUZscXpWVGtxWjJC?=
 =?utf-8?B?dEZmTlk5SHNHNEhqMUQ0YjVqclRmeWlCLzR5bnNiRStMWXBJaWRxbTAxenNF?=
 =?utf-8?B?K1VxZXpnS2MrSFVEUnNTVDdRclF5T1V4WHhxODVTV21KNjhmU2VZbXFNMXlr?=
 =?utf-8?B?TUVTaDQxdXdUb3AzV284bktvWm4ybWVhTmVpWVRpQkV4Mmp2RE5KeVpmemVv?=
 =?utf-8?B?WG5acHl3Q0FnOU1IUEpkSDNtVGNxY0VnTzA3dUdvdjU3ZlhuSlgxaHMyMGJE?=
 =?utf-8?B?VlRFOE5Ub3kzVmg0MGRDMENzd1pwcC9HcmZaV1dJaTRiK3lOdi94aFp4R3V0?=
 =?utf-8?B?N0Fxd3JKV2hDa0NQR1lnUVdTbWdHdk5oWTF2RWU2YzNpNDdoeDI0eVc3aTRG?=
 =?utf-8?B?ZVNFc3pLNEtjTTNiTFN3VWdEOGY5MEVDU0EvcDZkdzdmb2NWRGtKR2RsajFQ?=
 =?utf-8?B?aDRRVHNGRlkxSWVZcFZ5QUVYTjJLVDRKV2t1K1ZJYzd3aHdka0FBSW5zcmNy?=
 =?utf-8?B?TXhYTEdDcVNMK1o1THljVGNYYU9LaEV3QUxQbEZwNEVoaWl2bEhZbEc5VGN1?=
 =?utf-8?B?bWlRcnE3RXl3NC9tQWJ4N1NPYThVK0VlS0JqSyt1WlcwRDAzQTVHSmhHWUZN?=
 =?utf-8?B?UlViVUxUZ3c3OVFETlUxR0tWRXpFeFNNVVovQmFrWTRNTW9MSFJoSmlGZDlD?=
 =?utf-8?B?MVp6UXB5Z2NkWnVSYlMxWjN2UUtlbno1TWN1ZWZtVWJYa084Zjlna0RpMGU5?=
 =?utf-8?B?RE0waTRpeTlITXpqRzkwcy9keVBwOUU1L2ZTemljUFV1NHUvL3RkZS9weGxi?=
 =?utf-8?B?WDkvNWc0aDdDRFJPc3hsUmdBWWlpekVlWVo2MDdBTnhlNFhaYUlaMGVTS0d6?=
 =?utf-8?B?alVEaTcxZHJUbHVrRFhjYTZYT3Byd0xSbHlDOS9ITTV1UVlvWHY2RG8rQ2VE?=
 =?utf-8?B?WDlzUUZSMjJtaWNoTFM4akxmUDc0U0NraWJMVjQ4cmx0dER2R0gvdGhaRkZj?=
 =?utf-8?B?eFBITzhpUTFaRVo2VFRNUFhuVTk2bmphODN6SG5WQm9wSlQzLzA1SSszUVJl?=
 =?utf-8?B?ZElCTXZWWlozdFVFVWRZUlREbEQ2c1FsZ1NQdjBWNTlLVXgvYW9kZG92OWZV?=
 =?utf-8?B?TVpEU1VsTmFvckJnL2lscGYzLy8vNGlLaGZYSWc2cTF0NktUVnI4T0RGQ3Rp?=
 =?utf-8?B?OTdJSVY4c3B4b0t4UCtNTzBuL2h0eldLQ29XVFU3aURjUks3YytmckVkS25p?=
 =?utf-8?B?MUxZM1dYbnNUdkRKVTV4WkxMY1gvbWZSa21wNjZXYjlqeUNrNUoveW0xUzVu?=
 =?utf-8?B?aTV3OUpwVVRKM0tIazhTQkszU0xzQ3ZVNVBrUis2Lzh4cWdQbWFMdnR3ZmpZ?=
 =?utf-8?B?MjNCQTNidzFGanhGVlZ0K3lGNTk4dENXd3Nva05GQWJHNzNrd0ZMR3F5TFlw?=
 =?utf-8?B?MjFPQ3ZQZ1VHZTJtZCtJZWkrV0VWcFZCY2NkK01XQUJrcWpvOUg2dDlDUjBR?=
 =?utf-8?B?SlFOem9WMlhIb3JpL0hGcmxkc28xMUovanBRT3BXMzhkRStmUWNnUWJCSzBV?=
 =?utf-8?B?V2tidmwrTm92OWlRWWoreXVNclZqRXZWellTVVNvNmp6N2lyeGpXTDFQMUI5?=
 =?utf-8?B?Y28xYStjdGltN3hhS2h3N1E3S1doVGJ3MitrZGR4VDRSWnJNeTJDenJEOGVT?=
 =?utf-8?B?ZTd4VXBoamtoRmh6UVFJckxJS2NTSTdYaW1zdko1RUN4bVJOSjJyOW9wTHBn?=
 =?utf-8?B?YU1Qci84TXY1cUQxbStaSXZIUmtpNzUzbklVd050K0pOMXpNcmJ5VTIrbC9I?=
 =?utf-8?B?MWQ0OFJSZEdlK1dCdkN5Zm14LzlBQVZWbkZkRWxQM0drRUJsbmpBQnVrMVh6?=
 =?utf-8?B?Mk92MFJ2ZVNxbWxDdHp2ODFIK2tkdzRCOWd3RllBMTJjU2VIWDhWM25oL0Ns?=
 =?utf-8?B?RUJqYUc4bXREYjBwV3RvZkl4MldGbUNQUnNwREZvQysydHo2azlYcGY4cGp2?=
 =?utf-8?B?bXNUT1oyV2ZLZlVQNWFkQ3VrblRyTTJHWUxQS2VHOExyWUJlYXRrbXNuTFdV?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oykKW5NVE/qrQL5eUfkD/0vk6W8VfjK655j7ypTD+Ufv+QKXMAM79yN2D+LdWK/HoFqAyeMp2vUVXJQWW9GOvvcyeOcVLwdw8TixOfsWVu44ttnzfL9/h5bg2UoNNaLzpW42FGD+MvvwzDNhOI3PM2J7r5M/p+GIFS6AMuXucbskkrexjy7Xc83/tHq5uJ1ZkK3CFgFiswwyigKhVy22NPnnKDXQob5R5YAKx1xSK1q2D0lyz2I6S0fTSSYH5OzdNlym0invK4WJSUojcMfvwYYrCcVaFO/OauLQwmXQYLq+03du8W1A1eDMfaeyMHxnEK5/skWhj/csswAOwoCIaORTJhYeGFDsvuFuP/0hoKQp6OfhKkE2K2NYIBPwn0W5GMVX5HDJyqh8lD02ewKq3fmU48qBJ/f4xm5a/FmbWQQHR+BITP3GvrSHoc6UyRwJvuPf/UOrqfR7VdmVReE1NncGqF7h6S1u8/QxSCv7wwng5ux92/KXT1XhXsNTLgDIK/hDcZb6fZrwNvgiwVLz4fe7ZFAGAjUegLXSs0bMAKE0l6OYqkS8UD+p2YKsdNT7y+fIWFgPJgzCZuiwVIMVkflz/nWPZXlQKy83Kukn+fc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f58b18e-8c24-40ba-43f2-08dd3fe19e33
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 21:20:41.2809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZm7Yqt7blZlnmAFAUt4kIPhBnn0+8yf0L5VJfAz/kG5arOCDM9XV1O4fACVKKlioD5/NLZO0jLaI/riQjyFj/Qj1cCJgsLF4P5uiSJqJFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280156
X-Proofpoint-GUID: buF6Uq9rFu66Fbc7RRb4TRqcL_vhfbpb
X-Proofpoint-ORIG-GUID: buF6Uq9rFu66Fbc7RRb4TRqcL_vhfbpb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/2025 10:39 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> What?
>>
>> This patch series adds the live migration cpr-transfer mode, which
>> allows the user to transfer a guest to a new QEMU instance on the same
>> host with minimal guest pause time, by preserving guest RAM in place,
>> albeit with new virtual addresses in new QEMU, and by preserving device
>> file descriptors.
>>
>> The new user-visible interfaces are:
>>    * cpr-transfer (MigMode migration parameter)
>>    * cpr (MigrationChannelType)
>>    * incoming MigrationChannel (command-line argument)
>>    * aux-ram-share (machine option)
>>
>> The user sets the mode parameter before invoking the migrate command.
>> In this mode, the user starts new QEMU on the same host as old QEMU, with
>> the same arguments as old QEMU, plus two -incoming options; one for the main
>> channel, and one for the CPR channel.  The user issues the migrate command to
>> old QEMU, which stops the VM, saves state to the migration channels, and
>> enters the postmigrate state.  Execution resumes in new QEMU.
>>
>> Memory-backend objects must have the share=on attribute, but memory-backend-epc
>> is not supported.  The VM must be started with the '-machine aux-ram-share=on'
>> option, which allows auxilliary guest memory to be transferred in place to the
>> new process.
>>
>> This mode requires a second migration channel of type "cpr", in the channel
>> arguments on the outgoing side, and in a second -incoming command-line
>> parameter on the incoming side.  This CPR channel must support file descriptor
>> transfer with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
>>
>> Why?
>>
>> This mode has less impact on the guest than any other method of updating
>> in place.  The pause time is much lower, because devices need not be torn
>> down and recreated, DMA does not need to be drained and quiesced, and minimal
>> state is copied to new QEMU.  Further, there are no constraints on the guest.
>> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
>> and suspending plus resuming vfio devices adds multiple seconds to the
>> guest pause time.
>>
>> These benefits all derive from the core design principle of this mode,
>> which is preserving open descriptors.  This approach is very general and
>> can be used to support a wide variety of devices that do not have hardware
>> support for live migration, including but not limited to: vfio, chardev,
>> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
>> to allow a descriptor to be used in a process that did not originally open it.
>>
>> How?
>>
>> All memory that is mapped by the guest is preserved in place.  Indeed,
>> it must be, because it may be the target of DMA requests, which are not
>> quiesced during cpr-transfer.  All such memory must be mmap'able in new QEMU.
>> This is easy for named memory-backend objects, as long as they are mapped
>> shared, because they are visible in the file system in both old and new QEMU.
>> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
>> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
>> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
>> the device that locked them remains open.
>>
>> cpr-transfer preserves descriptors by sending them to new QEMU via the CPR
>> channel, which must support SCM_RIGHTS, and by sending the unique name of
>> each descriptor to new QEMU via CPR state.
>>
>> For device descriptors, new QEMU reuses the descriptor when creating the
>> device, rather than opening it again.  For memfd descriptors, new QEMU
>> mmap's the preserved memfd when a ramblock is created.
>>
>> CPR state cannot be sent over the normal migration channel, because devices
>> and backends are created prior to reading the channel, so this mode sends
>> CPR state over a second "cpr" migration channel.  New QEMU reads the second
>> channel prior to creating devices or backends.
>>
>> Example:
>>
>> In this example, we simply restart the same version of QEMU, but in
>> a real scenario one would use a new QEMU binary path in terminal 2.
>>
>>    Terminal 1: start old QEMU
>>    # qemu-kvm -qmp stdio -object
>>    memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>>    -m 4G -machine aux-ram-share=on ...
>>
>>    Terminal 2: start new QEMU
>>    # qemu-kvm -monitor stdio ... -incoming tcp:0:44444
>>      -incoming '{"channel-type": "cpr",
>>                  "addr": { "transport": "socket", "type": "unix",
>>                            "path": "cpr.sock"}}'
>>
>>    Terminal 1:
>>    {"execute":"qmp_capabilities"}
>>
>>    {"execute": "query-status"}
>>    {"return": {"status": "running",
>>                "running": true}}
>>
>>    {"execute":"migrate-set-parameters",
>>     "arguments":{"mode":"cpr-transfer"}}
>>
>>    {"execute": "migrate", "arguments": { "channels": [
>>      {"channel-type": "main",
>>       "addr": { "transport": "socket", "type": "inet",
>>                 "host": "0", "port": "44444" }},
>>      {"channel-type": "cpr",
>>       "addr": { "transport": "socket", "type": "unix",
>>                 "path": "cpr.sock" }}]}}
>>
>>    {"execute": "query-status"}
>>    {"return": {"status": "postmigrate",
>>                "running": false}}
>>
>>    Terminal 2:
>>    QEMU 10.0.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>
>> This patch series implements a minimal version of cpr-transfer.  Additional
>> series are ready to be posted to deliver the complete vision described
>> above, including
>>    * vfio
>>    * chardev
>>    * vhost and tap
>>    * blockers
>>    * cpr-exec mode
>>    * iommufd
>>
>> Changes in V2:
>>    * cpr-transfer is the first new mode proposed, and cpr-exec is deferred
>>    * anon-alloc does not apply to memory-backend-object
>>    * replaced hack with proper synchronization between source and target
>>    * defined QEMU_CPR_FILE_MAGIC
>>    * addressed misc review comments
>>
>> Changes in V3:
>>    * added cpr-transfer to migration-test
>>    * documented cpr-transfer in CPR.rst
>>    * fix size_t trace format for 32-bit build
>>    * drop explicit fd value in VMSTATE_FD
>>    * defer cpr_walk_fd() and cpr_resave_fd() to later series
>>    * drop "migration: save cpr mode".
>>      delete mode from cpr state, and use cpr_uri to infer transfer mode.
>>    * drop "migration: stop vm earlier for cpr"
>>    * dropped cpr helpers, to be re-added later when needed
>>    * fixed an unreported bug for cpr-transfer and migrate cancel
>>    * documented cpr-transfer restrictions in qapi
>>    * added trace for cpr_state_save and cpr_state_load
>>    * added ftruncate to "preserve ram blocks"
>>
>> Changes in V4:
>>    * cleaned up qtest deferred connection code
>>    * renamed pass_fd -> can_pass_fd
>>    * squashed patch "split qmp_migrate"
>>    * deleted cpr-uri and its patches
>>    * added cpr channel and its patches
>>    * added patch "hostmem-shm: preserve for cpr"
>>    * added patch "fd-based shared memory"
>>    * added patch "factor out allocation of anonymous shared memory"
>>    * added RAM_PRIVATE and its patch
>>    * added aux-ram-share and its patch
>>
>> Changes in V5:
>>    * added patch 'enhance migrate_uri_parse'
>>    * supported dotted keys for -incoming channel,
>>      and rewrote incoming_option_parse
>>    * moved migrate_fd_cancel -> vm_resume to "stop vm earlier for cpr"
>>      in a future series.
>>    * updated command-line definition for aux-ram-share
>>    * added patch "resizable qemu_ram_alloc_from_fd"
>>    * rewrote patch "fd-based shared memory"
>>    * fixed error message in qemu_shm_alloc
>>    * added patch 'tests/qtest: optimize migrate_set_ports'
>>    * added patch 'tests/qtest: enhance migration channels'
>>    * added patch 'tests/qtest: assert qmp_ready'
>>    * modified patch 'migration-test: cpr-transfer'
>>    * polished the documentation in CPR.rst, qapi, and the
>>      cpr-transfer mode commit message
>>    * updated to master, and resolved massive context diffs for migration tests
>>
>> Changes in V6:
>>    * added RB's and Acks.
>>    * in patch "assert qmp_ready", deleted qmp_ready and checked qmp_fd instead.
>>      renamed patch to ""assert qmp connected"
>>    * factored out fix into new patch
>>      "fix qemu_ram_alloc_from_fd size calculation"
>>    * deleted a redundant call to migrate_hup_delete
>>    * added commit message to "migration: cpr-transfer documentation"
>>    * polished the text of cpr-transfer mode in qapi
>>
>> Changes in V7:
>>    * fixed cpr-transfer test failure for s390
>>    * fixed machine_get_aux_ram_share compilation error for Windows
>>    * fixed size_t print format compilation error for misc architectures
>>    * fixed memory leaks in cpr_transfer_output, cpr_transfer_input, and
>>      qemu_file_get_fd
>>
>> The first 10 patches below are foundational and are needed for both cpr-transfer
>> mode and the proposed cpr-exec mode.  The next 6 patches are specific to
>> cpr-transfer and implement the mechanisms for sharing state across a socket
>> using SCM_RIGHTS.  The last 8 patches supply tests and documentation.
>>
>> Steve Sistare (24):
>>    backends/hostmem-shm: factor out allocation of "anonymous shared
>>      memory with an fd"
>>    physmem: fix qemu_ram_alloc_from_fd size calculation
>>    physmem: qemu_ram_alloc_from_fd extensions
>>    physmem: fd-based shared memory
>>    memory: add RAM_PRIVATE
>>    machine: aux-ram-share option
>>    migration: cpr-state
>>    physmem: preserve ram blocks for cpr
>>    hostmem-memfd: preserve for cpr
>>    hostmem-shm: preserve for cpr
>>    migration: enhance migrate_uri_parse
>>    migration: incoming channel
>>    migration: SCM_RIGHTS for QEMUFile
>>    migration: VMSTATE_FD
>>    migration: cpr-transfer save and load
>>    migration: cpr-transfer mode
>>    migration-test: memory_backend
>>    tests/qtest: optimize migrate_set_ports
>>    tests/qtest: defer connection
>>    migration-test: defer connection
>>    tests/qtest: enhance migration channels
>>    tests/qtest: assert qmp connected
>>    migration-test: cpr-transfer
>>    migration: cpr-transfer documentation
>>
>>   backends/hostmem-epc.c                 |   2 +-
>>   backends/hostmem-file.c                |   2 +-
>>   backends/hostmem-memfd.c               |  14 ++-
>>   backends/hostmem-ram.c                 |   2 +-
>>   backends/hostmem-shm.c                 |  51 ++------
>>   docs/devel/migration/CPR.rst           | 182 ++++++++++++++++++++++++++-
>>   hw/core/machine.c                      |  22 ++++
>>   include/exec/memory.h                  |  10 ++
>>   include/exec/ram_addr.h                |  13 +-
>>   include/hw/boards.h                    |   1 +
>>   include/migration/cpr.h                |  33 +++++
>>   include/migration/misc.h               |   7 ++
>>   include/migration/vmstate.h            |   9 ++
>>   include/qemu/osdep.h                   |   1 +
>>   meson.build                            |   8 +-
>>   migration/cpr-transfer.c               |  71 +++++++++++
>>   migration/cpr.c                        | 224 +++++++++++++++++++++++++++++++++
>>   migration/meson.build                  |   2 +
>>   migration/migration.c                  | 139 +++++++++++++++++++-
>>   migration/migration.h                  |   4 +-
>>   migration/options.c                    |   8 +-
>>   migration/qemu-file.c                  |  84 ++++++++++++-
>>   migration/qemu-file.h                  |   2 +
>>   migration/ram.c                        |   2 +
>>   migration/trace-events                 |  11 ++
>>   migration/vmstate-types.c              |  24 ++++
>>   qapi/migration.json                    |  44 ++++++-
>>   qemu-options.hx                        |  34 +++++
>>   stubs/vmstate.c                        |   7 ++
>>   system/memory.c                        |   4 +-
>>   system/physmem.c                       | 150 ++++++++++++++++++----
>>   system/trace-events                    |   1 +
>>   system/vl.c                            |  43 ++++++-
>>   tests/qtest/libqtest.c                 |  86 ++++++++-----
>>   tests/qtest/libqtest.h                 |  19 ++-
>>   tests/qtest/migration/cpr-tests.c      |  62 +++++++++
>>   tests/qtest/migration/framework.c      |  74 +++++++++--
>>   tests/qtest/migration/framework.h      |  11 ++
>>   tests/qtest/migration/migration-qmp.c  |  53 ++++++--
>>   tests/qtest/migration/migration-qmp.h  |  10 +-
>>   tests/qtest/migration/migration-util.c |  23 ++--
>>   tests/qtest/migration/misc-tests.c     |   9 +-
>>   tests/qtest/migration/precopy-tests.c  |   6 +-
>>   tests/qtest/virtio-net-failover.c      |   8 +-
>>   util/memfd.c                           |  16 ++-
>>   util/oslib-posix.c                     |  52 ++++++++
>>   util/oslib-win32.c                     |   6 +
>>   47 files changed, 1472 insertions(+), 174 deletions(-)
>>   create mode 100644 include/migration/cpr.h
>>   create mode 100644 migration/cpr-transfer.c
>>   create mode 100644 migration/cpr.c
>>
>> base-commit: e8aa7fdcddfc8589bdc7c973a052e76e8f999455
> 
> I'd like to merge this series by the end of the week if possible. Please
> take a look at some comments from Markus that were left behind in v5.

We discussed, and Markus agrees none are show stoppers.

- Steve


