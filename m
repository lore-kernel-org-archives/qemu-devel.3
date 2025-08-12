Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C28C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulrIC-00027e-2x; Tue, 12 Aug 2025 11:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ulrI5-000270-2I
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:51:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ulrI1-00075X-L3
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:51:56 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBx1M007847;
 Tue, 12 Aug 2025 15:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6YZXAHMGb++HVCAwDj4dnBfNpjcdCt0My5IOW19kCCU=; b=
 ieIm3rfGzkT40fwX1KX07sYOzuqNE6OXKRQKIrLXmT+/TTJh77QaUWKzl2ZYwxye
 tFkitbZOOC2r2ay4Ce0k4Q7d5iWdcuaEWTvddngxYCHgm3iVW4e1ZZRLB3CHdapN
 zt8htpCuqFA5w4OVtdu6E0/7rYsLVAs12co5nJLfLJl1jIHIgWziiXWnx5+rwDcL
 687wfPdVy1UlH8OvsTFjt7UDoMEeUdaLg0bTDaCt19aalxgV5KIWJZP+C6WTdcur
 bskfrdMK6oKATYLHmNGCsj5P8SEDRPZuA8PiLMoD1icRFnyTA9eveg/iqULuoSmy
 DQBLBAbFFDTJNrRXlp8s9w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwvxh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Aug 2025 15:51:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57CFJrdV030304; Tue, 12 Aug 2025 15:51:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsa56dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Aug 2025 15:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onU3iH8lQGDUmKrG7sOA+YT/Jvh2QDMXbMTtlfPEhOerdtzaQTV+KL/o5qmOUG7AAkaONFequyZrxueoouDg+ANcdJsjFdJaQwMh86lXWgWVlib5nokh50YzQ+48cDbtHkW0xsNucDf3hf319vxcnRF9mkNl9UyTrVeFTPwGIR34e/9dJD2Hs4Zs8vv+5y6NPUVw1eV0BrMlJ1GSDd2xVoZP2CM1uZ8cdpcgDNHjIX7E/hPhEs8MHBaeg6b1zeEGagYqBlm9c05WX2C4bqkihiYQebSgrIlSEmW0sWi3JncHFhexJG0IVi3OH1JTUNRaZPqKmShu9jvUfq4Ptp0Stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YZXAHMGb++HVCAwDj4dnBfNpjcdCt0My5IOW19kCCU=;
 b=RfxAPmwMVNYhAOgzQDz8PamBC8y9DowUn++clFTI664VOnvsk6DjszQYVIHGdb2ohWeZ1Si4xWyzbgWyHaMu0v4fRGDI45m7DJCEEd1RqrlRS95cxyAeNn6vlW8tY9jIM/wsxm1jPswC6NibrEa7zwPl+pyuguFhknrHCf1LGSZ7NZPpLJNKcplkzgpX96TOSb6GZ93fCKBy+EAnEKMDQn/PCsLMh2y3HpIR0JUz4S6VUnBbWYPXzDxL2LIlG4dc7PvQvMP2jcxMV2HL84QGdK8wF9TcxwM0IfEpC36iV6sW1LBtY3lVcIKvz8MAPXA1lgP0hFp5Xa7fgxulsrx0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YZXAHMGb++HVCAwDj4dnBfNpjcdCt0My5IOW19kCCU=;
 b=t/Rs7OGxiHhnlKiuH3TvSuTVJY430uo+Bz0tORjq6WX52lRWI8JymMdNjtnrjZHGdDqTWqvzolVbOig5/VSuRE7PWocGAPNzpDVdRcX+JNAZJNbhnhUDA3qDIL4bRhBe4gPtBVsvYQHXGCf+/KP4O54JSoCqRDftCN9T1ujrYEE=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 15:51:38 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Tue, 12 Aug 2025
 15:51:38 +0000
Message-ID: <5d7a5a85-bd95-4aa7-841e-0bdc8d726180@oracle.com>
Date: Tue, 12 Aug 2025 11:51:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <aJpm4-JfmevsI7Ei@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:510:e::29) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|MN2PR10MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: e725d18d-f256-49b5-a365-08ddd9b81f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OExxd1FrZVhIZEdRSmhWRjVQK3NFVHQ5Q1I3a2hTT1lzczNCYzFsaU1LTVl2?=
 =?utf-8?B?eVovR2hWOFVaclc0cU5LK3cyVVJIT1hkUmFpUE9PSnVTcWVvaFlZVFRNYkdy?=
 =?utf-8?B?NWVtOEZTVS9GL0RoL3ZMaTNMWGFZcTFtQ1RvWG9PYnlGWW8yb0ViempoWnFN?=
 =?utf-8?B?KzJqNW1DUjhuRG53R1BEekgwbk0xRUR6eEZ4Uk5jb0VZekxiQnM1UVZ3NkQ2?=
 =?utf-8?B?REtKZ1hxMVJFclR5b29meFpDUGMvTlI3RE1nZTZhc2d4UGdRa0lCV3Q5QllK?=
 =?utf-8?B?bURqdFc3OThJZzFRQlhlT2E2QjhwcnFYT1RPMXk4bzNURG1oa1FOM3JBeU5N?=
 =?utf-8?B?ZjhLUHZIcklHN0cwNnRHdFAwaWI3L2cxNDhPN2hHQWMrKzVjR0tqQkNoOEhh?=
 =?utf-8?B?WEwxMStnV05vbTBhaTEyb0I3RWEydEV5WHA0c1ZDRW1IMGJ2Z0tsZ2E4dTFq?=
 =?utf-8?B?eHg3UmlhaU1yRXBDL25EdGhTcDVTVzFPWmVUcnBFN1ZES0ZPOG5UK0hEVWpZ?=
 =?utf-8?B?cHFSV0oxUVBWaDdGNVcwYWo4eXp2d1NMbFdzNVI0bXpMSFcwb2pwSUdJUHpk?=
 =?utf-8?B?Z1BkZHZTU3JXMWRjQ0g0MURWZnBiOXVnVDB0Yk0wT1BMd0lNdDY1QVkyUTgv?=
 =?utf-8?B?OGFLTHJ4U3U3NzlJTkxDa1crdzNSVXFjWWxHTWhBQ2U2VHM4ZnlMUEJnbEVU?=
 =?utf-8?B?aEVmS003Q0MyalpUc1JjT21vU1FENXlrZ3MxOTh5OXY1Yjl0UDdDWjdzaGJh?=
 =?utf-8?B?Q3dkTWFWWlZGbFByT1NwV09STEwyUzlWL2ZKQWRlNk1jcUFsSGh0RWoySlJo?=
 =?utf-8?B?b1VaQnlhRzdsRnRYd2VEVmk3UUV3Wi93TWMwSVcycXU2bGlPTVRqbnN4eWpH?=
 =?utf-8?B?YXBneGdtd3ltNnRveVBSN0lEaW51VUtCNWNtQjJ6KzZKOUFoaTZnTUtEa0tY?=
 =?utf-8?B?MmlvT1ZIVk9rczdtUTdqOXFRNmNIZzkxendEcEJhazZYZ3VtRThpdnI0MmU1?=
 =?utf-8?B?YW9mMktPM2VZVXY5QnVqWVhtQWluQlNSQjBETkY0dHpMSWVTVUlaSkwzdTdi?=
 =?utf-8?B?d1J2SjNWZm91WU9tWnJvUkJKbWhmcC93OXl4TldBY3VXMDF0VHpsRDNDdFY3?=
 =?utf-8?B?UHphRjRQdXA3aW40SWMxd3R2WWpjZ3ZJeVhYYWRGVDY5YlBtMDV4NTVNL0Ni?=
 =?utf-8?B?d3hPejdoUmtSUmxOMlNrelhyWHRpNk40ZmhPV3RaVVlIMjlvZVlVc05oUmRX?=
 =?utf-8?B?UTVlRU5TYk1RSUM0cm0wUGp3emtSUWJtYjg3eTNhOGtJWTE2SUV4MlZsdVFu?=
 =?utf-8?B?OHh2QWlyblVUWkhPbjh0VnRrUHFvdE9senBFS3FBUzFIY21WTjk1WEg5TFc3?=
 =?utf-8?B?VVFLSSszTWZ1SEZsSXFpTkEvZFF5WUhhOEFDdk83T1BCSEhveFYxQ3BhZ0NW?=
 =?utf-8?B?bDFkbnkwSnRvUGJlQUEvWG5qSm5USGZSY0hNSmdhczNGaWRHWUVmbEhEK1Mr?=
 =?utf-8?B?dXhiaFhkMVFjQkg3QXR3M1dEd0l6Zlp4YjF4ZTVTTUxDamUxM2JpS0pMcXht?=
 =?utf-8?B?YmJZZ3ovNS92dHV6NFZydGgwTnIvTWVDeW9BWmVpeGc2eERZS1ZlYlN2d0E0?=
 =?utf-8?B?ZTMzZFNSUnV6NUZHcDJXTUd2RnN5VG10SDh1cnlQSkxDUE5kOFZHMmdzeE9l?=
 =?utf-8?B?b1hQS2cyL1loSHJ2Z1NkVlBNU1RTVGtubUFSd1dZeVhqb0pDcmplSTdYOWtx?=
 =?utf-8?B?ZnJSYjVWTFc4VlZ4UFV2RUZFUm9IQ2lIdmVhWW9CM2x1WjN2VHpsWG9GaVVM?=
 =?utf-8?B?bGIxVlF3cXlLbXlFZVdTWTFQRmRJUUx3NmgrbGRQTDJlbjBsV3g2OXd1Z0Vx?=
 =?utf-8?B?Y1cxdnZ3S2ptd0lBQW9jSWdQSlFVcEMvOWZkUFN1M3lhdkZ5bnRaMWgzTThF?=
 =?utf-8?Q?mEY/jxULZNk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdLMzBmWUZFSUxHa2dDL1ozbFpPQlVRRm1MVW1Kd25wRTI4NXVnYkt2a05Z?=
 =?utf-8?B?bHZtb1M0QkxSUUxQVnRaVU5zemJLTjVUMmhobkVNb2xKZG9GVklRUGhvWXVL?=
 =?utf-8?B?bHpoZUxkWWRXamo2b1VWNGdRRjI0VVJFcUlic1JDaHFoZWRrYlBiU3pCYVh1?=
 =?utf-8?B?L1FRdFN2Y2pOZTk1SHZRVW1rdER3ZzlCeWdLL1M5bVl5TzBDRURkUk9aZDhD?=
 =?utf-8?B?V2xpVzZudnVZQTNYTU5GMHFDZTlycWprM1dObWRIb084OHhCNEErdUtsL0d6?=
 =?utf-8?B?V2pkZDAvbTYzaFZFUzFhWHZLVGJtcWN2WHNDTDFrVy9aMkR1N0t3ZjFoekhq?=
 =?utf-8?B?aHFxTVZMbXN1MkxpRzZoaWxHWmlKWFFldHFlcFB0UElNVTh4RHVNb09PR1o2?=
 =?utf-8?B?NkcwQUhGYTE4ZHFaWFYrUXZSekNuSGZRY1hnb0RrUnI1NG5KU1M1UGJuN0Fw?=
 =?utf-8?B?dnY2czVLTm00NERzc2x1TjJ4aFZMQnNUeEpSNXhWbUwyTTdEWWdiQ2RhOEFN?=
 =?utf-8?B?b0h5dTRXUXFmN3hWbWFLRHlLWmh4dzQwdXE4WGJTOHIvT1B3MisrcjdzOXRt?=
 =?utf-8?B?M1JyQWJpSlM1clFqb21HTmxaT05jL0U1KzFDYmJncWlRdWk2VnE1NGI5RWFr?=
 =?utf-8?B?SGU2K2dQRjlYUU51ck1mVXlLK0crckx2K2JKUjBVRFhWU21lTTNEdlVJNEpG?=
 =?utf-8?B?aTloSXFOaUdQUnVJTmxnYnQ0YSswdmt4VkwwdEh1ZG53T2FDcFJyVUhVblM4?=
 =?utf-8?B?ckRMYTROSFYxWE5FbXZJOXhERGJtckg4MFpPWVI1R0VWaVBrNTB6S0tIaVdP?=
 =?utf-8?B?SlhPQmEyR2pSMFlnTXJBbU9XMzRYWlY1UjByVVJUMlliU042Z1dFSkhpclFr?=
 =?utf-8?B?Tm0rVHdlNTZZSzlXSUh1UzgycHRQeVlPMnpwVnB2bmlyOUMyeUpyODJDK0dk?=
 =?utf-8?B?Q3VLaDZ6N0oyRkdYQjE0MlBFWW5zdVhCOEgrZmNuT25iaTdQOENCdGpZaUkr?=
 =?utf-8?B?Z3MyMHdlbG81Mzl4SlJLdk9pNHVVV2FpWTdCZlNiOWlwWXBKZ05IajRLOHIy?=
 =?utf-8?B?YnFscm8wUENYNlBJZjdwTTJTbTZUSW1PazY4bVVTZWU5bkdja2c3L1NxNS92?=
 =?utf-8?B?bG5jRUdHL0NudEZKNUNnK3krR3BxemQ5MXRNdDBrTW1xaEhWblZsNitZdS9Z?=
 =?utf-8?B?WVBweW4zN1dGcVNGSFI4YXUza2Zsb1Jab3FlM1pJZFQya2JPVmdFMGs2dVdu?=
 =?utf-8?B?cnViY3crRnVnZmhOdUpXY01CTXZ5Tm9wQXpnd3dwRHNmbjRWczNiTlFoYWFN?=
 =?utf-8?B?YkcvRzQ2anp6MEEvMGR1U0dFTjV2Q2p5azdkTHFyeExXMThxRHRIRS9GNFJo?=
 =?utf-8?B?TE92RWxJQWF1UkVjYW4xRXJzaDRsVndFaUdHR0pNaWZTVEZUZjRScWwwKy8x?=
 =?utf-8?B?Qk1nMTgvczJTclJvZWhkM2x2WDNwczVSQUthY1FyYmtLYWwybUJNa3M2dG94?=
 =?utf-8?B?SlBCa0JSMlJXaUNsT1AzTVY0WFkzM3J3NllRcmhKMURLY2RqZnlXTVRrczBX?=
 =?utf-8?B?WXZOa3hqM3pWTE9JOEhXUGRRNW5LK1MxZ0Q5TVlObmVJTVJQd0VFalRneW5l?=
 =?utf-8?B?M2hZbXVmY2ZsUUJvSjIzdVdvRlcyRmVSc1M4bk0xS1N0enBtdGlsRzNPM0hI?=
 =?utf-8?B?YzFiRmxQbEREMHI0M0ZtRStjY1czMXJRN1VWUU5MLzVYME1GYVpsVUtiVlFQ?=
 =?utf-8?B?Q3RDYmJDTm9xZEdTU3FjZnR3Vk5RTmVvdnFqYWh1cklLQlFIL3pDRFNlME9i?=
 =?utf-8?B?V3NSM1VlU3EvSW1nZmxLZm9rMU8vQm0rRHQ4OVovNnJpNTZNVURuT29OaUg2?=
 =?utf-8?B?cFMyMFIrUkVPTWxQeml2QU9vNzVDLy9sOFFjdW9ndUgvQ3hEUjNzTmF2R3hz?=
 =?utf-8?B?S09iTDFDRytLaFo2N1RMNVlMNjl1M1hTczlRSDRTWUpNdTFvS0lWSlBacnE0?=
 =?utf-8?B?MVB2dnFCeDdtZTZhZEpXTGVFL3kvK2lLN0pNQTJMMS9peW1HcWdCUC9NMVBP?=
 =?utf-8?B?SG4wNXNpME8zYWVRbUJFeUJaUnB1SkNtNk9iU3h4TkxvdWNWOXEzeWZ0SGR4?=
 =?utf-8?B?cmhVa1lNT2o5SU9XSkVpaGRxYUtYZEVmMVpZME5YM0xLRlYrdGI2UVZCT2s4?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nI2Vgm0u7Yndios3QIn7xK7QS7QKfBpSm4oIA/xfqSdp6Lnm5wfu4afevGQmjIWJA/tdPZtLd99zaxzTXnSaDLSDlNWX17J8ufRP7VfsZcCvOB0wtw2xuD8g/jAUBaHifUzvZbIZRbcY/oL9X0wo8UIIijnGpqJ9CCTafAU1PpnSipGGvLcu64J2v92+VXeR+mNRH2UVFrIyuYRDP2RiOsdCELKCZESz3gJLrOxRHxxJwpNNO3em1d2dKlBSRPoYdzp8os/VTq0QoQjaXdt8V7/6ktri5hvthoK4IE+jkbry+sRjIW1TvMnCypoU5ysgT6p/OqIZRVWv6bfpDK+OQgoPqL/dxxgusHeCH+MYkk3hitptmlPI/22nEvWXxHwDQ6LqQtOztohdkFt2f1WJf/K/rkYRWm2ZRef8G/1enM48hxFhOQYBXbupp+uKLAyF8sYJ8PXNERnrlhvEr5mzlUiZQzEKNuMLcBLhsEtd/8AOkuqQ8XTcb0kVNMCQdF7r2RMidK6ChRJxZvqFiGzHiEdCmKop7IWjQ5lTSpXEOMt7B7CkKj0LC30pGiw89rt0yBbAb1J7dZUHVyI6FvZB1wDsL65YDrDbASDsM5xL7rE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e725d18d-f256-49b5-a365-08ddd9b81f98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:51:38.6338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq3JeP6G1uAoxG1HifWOW2GU2tqvGaI/EqC+/MFLpBZ/rbm71V4yJ1nd9OoHgtMQFAFvXhs7jmH76EXSLqPzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=947
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120152
X-Proofpoint-GUID: 7kf0iqKi0xxqLFS8sjNwrVm9quQzURpv
X-Proofpoint-ORIG-GUID: 7kf0iqKi0xxqLFS8sjNwrVm9quQzURpv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX/s8508jbQFzy
 sD9Z0f9UQ1/aWcsbH+NCfVjO600km5bSzd7EO26Xev0Rvp5yKZRO+45X2k8T0V+wTsqAj5Mi3BH
 RVFLorbohHfHBb8JtzLik9iYDOOtcaEPzRGz8eVl7MNW0GaAFnXJLVvpIqWtNlE26pLaqD6axgr
 cVZkl94uxxjQ4XqgC0mIPNmafUjuuHaltWHLc61BJecAUrdIpF6BoqglQntcjDrRPYcWjlf7x9J
 /386Ne0kiTI0HI3tj+DatXI7n9pJqyZwDc2mKWdTonaXB2rJstI0Vd9pHyycKwEjn5NrOHoKly2
 qAuAPZwujT14uaH3RyT5wr5KEpw1GVA0GiQfVrj0vlYjJB9aylRQ24tkSnLei6YFTInsYl6ei2o
 zPpUhwNdHO8KMn1585I01uVK7sZDCXdK69rVak8ZMdCOHVmci4bqLgzK5X5+JZC4pJT2oMjB
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689b630f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=e1X4v4M6vOgMd6Xu3-4A:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 8/11/25 5:55 PM, Peter Xu wrote:
> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>> This effort was started to reduce the guest visible downtime by
>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>> vhost-vDPA.
>>
>> The downtime contributed by vhost-vDPA, for example, is not from having to
>> migrate a lot of state but rather expensive backend control-plane latency
>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>> dominates its downtime.
>>
>> In other words, by migrating the state of virtio-net early (before the
>> stop-and-copy phase), we can also start staging backend configurations,
>> which is the main contributor of downtime when migrating a vhost-vDPA
>> device.
>>
>> I apologize if this series gives the impression that we're migrating a lot
>> of data here. It's more along the lines of moving control-plane latency out
>> of the stop-and-copy phase.
> 
> I see, thanks.
> 
> Please add these into the cover letter of the next post.  IMHO it's
> extremely important information to explain the real goal of this work.  I
> bet it is not expected for most people when reading the current cover
> letter.
> 
> Then it could have nothing to do with iterative phase, am I right?
> 
> What are the data needed for the dest QEMU to start staging backend
> configurations to the HWs underneath?  Does dest QEMU already have them in
> the cmdlines?
> 
> Asking this because I want to know whether it can be done completely
> without src QEMU at all, e.g. when dest QEMU starts.
> 
> If src QEMU's data is still needed, please also first consider providing
> such facility using an "early VMSD" if it is ever possible: feel free to
> refer to commit 3b95a71b22827d26178.
> 
> So the data to be transferred is still in VMSD form, aka, data are still
> described by VMSD macros, instead of hard-coded streamline protocols using
> e.g. qemufile APIs using save_setup()/load_setup().
> 
> When things are described in VMSDs, it get the most benefit from the live
> migration framework, and it's much, much more flexible.  It's the most
> suggested way for device to cooperate with live migration, savevmhandlers
> are only the last resort because it's almost not in control of migration..
> 
> In short, please avoid using savevmhandlers as long as there can be any
> other way to achieve similar results.
> 

Oh this early VMSD is interesting and, at first glance, appears to be 
suitable for what we're trying to do here. I'll take a look at it and 
see if this is something we can use instead of the SaveVMHandlers hooks.

Thank you for mentioning this.

Jonah

> Thanks,
> 


