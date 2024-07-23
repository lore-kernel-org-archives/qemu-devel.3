Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB338C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAid-0002dB-0A; Tue, 23 Jul 2024 04:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAiZ-0002Vj-HN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:17:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAiV-00089G-Qz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:17:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BSPm010064;
 Tue, 23 Jul 2024 08:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=PUB/I0aqLO7etTH+b560xDbfS5Pk/8wXzAC8LUchtx8=; b=
 CQcd0viLhrsS+VDPAgtfp7nPhCwnyJtdPoxmfC8R4O9TrjOGJH5vZ+mIsw3Ssb6v
 lVzZiKkofMwPJBdYuru9yPCwlvkcNWz9IhQFddXydf/WzrXQus0g1nqNuesfFtdt
 S5tlulXI8gqXvokgmnl6yTUetZEHzNLMqBNF7eKLfcbXgUAWz/+QOO4Xy8Ig6Uae
 TUfp72G0dwxNdTipYBvBwdjQg+Mo4XxWMI6rsNtz4URxVig7278A+NOX+fBsi7Al
 bzIz28u/Yv/Q1fOcjri8Md2mTpcF7HbzDC88L87/lVo50TASJy/+2HrcTEBw3TOA
 dtPI1L5atzsb54z+II2JuA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkqwfbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:17:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N7JIhm040387; Tue, 23 Jul 2024 08:17:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h26m41qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zL2zZ05y/hcLVhsxxDedba+CdToeZMZyhHQIoNKmwSrrlCkdELAYlalPYGdZtkxFrTkkL6WoOOmsC73i5awF/xjYDBh+OCQAYPymKs4k7FGwRaqXprPm7OCPLh6R+aLf/8j9uLDcwdlRwoVQqeucfEyiBrTItY+bwxEZBpDS3zn7iwbtyL+OX/hej4aWpPMrUr1gPy3AQFfgKwXNPXb4Kt4ISodAWZCQWHHB4wDjjDt7cDEpuwZSv6X9QdzothbYRzlosNGCHMq/qNgpYCGQ1Yps9jOIMQ04RMtrQzCx4fhjtsy71zsgpqRE3A0W+XMGBOQVAeU5WRgRAfCtp/tBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUB/I0aqLO7etTH+b560xDbfS5Pk/8wXzAC8LUchtx8=;
 b=jIw7eyS6wZBfIlDDjbPffrnmW34AjvLsB0Ksw1vqqb7eaqzJXZtmMtXyjd8BHYJin3vhP36hRSLp67gS0xGT32C9IRgwbrqVZ9HxtOEX7fWSNS0myBzS2/1GtaTZqYGaaSE7DaVEG+NSQkJfn+oz7e56D2zjVM/iEpbzQeNQb5sLiHzwRNGZoOOQ6gp8Rn+c0q7U4W7ewfcX3Eo0MVq6wSQ8hOubi6wuS0InMaCkyK2coPCSKgVGW37tSErI9rZaqxLzIjM9CNQVacGSlm5gN6sEK2FCEBxrwWDgTEDrH9zTyWtiIN4cUgYvKunjnHKAVqKhpE6ivRQg5pOnTTbSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUB/I0aqLO7etTH+b560xDbfS5Pk/8wXzAC8LUchtx8=;
 b=juLxvcuJOG0rzzUCgxH0Bc2zjoMoegYfZH13jjz8QWBAEJpTJwR8VhzasuEGucrqYhcmoRhbE3KCtnDoFekpF/OUxpdPmE1OQ/D8kfIn15N7eUEa8Z2XVtfcqrBOzSGUD2UytN+gUUie8Zcer9i1r0kZ1RxULnuB2ZZTGTR5VCE=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BN0PR10MB4821.namprd10.prod.outlook.com (2603:10b6:408:125::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 08:17:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:17:44 +0000
Message-ID: <158ecf9b-e81a-43d6-a4cc-f434ef04a516@oracle.com>
Date: Tue, 23 Jul 2024 09:17:32 +0100
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <2fd72e9b-c3b1-488c-a532-546ddf3612e0@redhat.com>
 <832a6eab-1f63-411c-a827-018b12264513@oracle.com>
 <9245593d-4347-422d-8cd1-d1e694e93562@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <9245593d-4347-422d-8cd1-d1e694e93562@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:205:1::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BN0PR10MB4821:EE_
X-MS-Office365-Filtering-Correlation-Id: bc686410-8ef7-463d-31f5-08dcaaefeda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzRya0l0d3F4SFBCV3hLQ21rbitHMlRLUkZPNDZoUDMvcWhlem15bFNDTTZw?=
 =?utf-8?B?U01ZbklMTEY4VnMxaS9SV2I0cW1UMmtPS3FXNmZFUnZxb3Q1d0loK1FmM25a?=
 =?utf-8?B?VXQvekxyTjF0bzJvd0liQ1RrYUlzSmx5UzZnVSt5UHpUZVV0RnBLcVBvNkNa?=
 =?utf-8?B?MkhlRXo1M0tvLzJPSkI2a0hQNC84NVFQczc2U2ZqRmVKR0FJOEYxdVhwa3Jr?=
 =?utf-8?B?aEJWU3hvS1lJckltdDB3NTlTZXVRcUttM3hlNWhxNW9WMlR2OVdGN1p1L2xY?=
 =?utf-8?B?SXJrMDVVdVhScWZuUmRqY1dwbUI4TksyMlNGYklHQktlVWpSc3hibVBjYXMw?=
 =?utf-8?B?ajBWdmZneGlvREc5aXVRL1F3eWRCdndDc25YU3VTTndGVmNWOE1YWXdHZStX?=
 =?utf-8?B?S0hSaWMyTHU5Zm9tWTRTN0ZuK0ZZWXlCeVcyKzhsQ3JxTUdLSnlFNGRENGoy?=
 =?utf-8?B?NWNXTzBOK1JnODliQk9rK3NOUGtUUnYwU1RNOVNLNU5JWlN5UUZwY2hMUU9v?=
 =?utf-8?B?VFBUelFzZUNPTkt5djdwNCs3UEtyLzNlVGZGMkJQUDVJTjR4Y3N1K1pqTTBG?=
 =?utf-8?B?bmhMZGpnYmI2TkpEczZCTEUvemdMTzlXYmR4VGtubUQ0cHZHNmh0Vk1wZGE0?=
 =?utf-8?B?TVlMUjM4d3pKbzBMYkRsNm1GQ0w2aVdxWjQxQlk4MU5uM2lGQXE1TWYrMVpj?=
 =?utf-8?B?aGNQNVRuaUl4WnNTOExUTXBBRjVlQlppMTYvOENNOUVuYTFXMUNZLzJEUmtD?=
 =?utf-8?B?eHNmNllWa2NuaTk1c1E3bEttNnBNZ1I3YlRWZlQ1MUluY1MyOEZIRnV3Vm5H?=
 =?utf-8?B?OUJwaTU5SDRIdlNiMWFTRW5nRmZaa2JXcnp4NkNWUFpnNVFUQldCcGxacFJr?=
 =?utf-8?B?MG9KZ2Z6SWhEQmxGamw2WWpDWmdWR2NacGYrTWdUN2VOalhXNWx0dkNnRFY0?=
 =?utf-8?B?cHVScVprME1xaVhxeWk2UDF4T3B1b0gyZDQya1F2UTczNGMxTTZIRVhKU1VT?=
 =?utf-8?B?VGFmTnpXb3VDZURFZmluWXplZ2d3QmF5dVFxVDhBa2hEOFNZd0VJUWFIR01w?=
 =?utf-8?B?R0EwT0xrdU5NdlZXdHhGVTh5VnFZNzZTdDYwUEpUU2RBNDN4UDFOdGN4cUVa?=
 =?utf-8?B?SkxpcEw3Mk5KeGtRNFdXeDgzZ3loQ29aakNIZXZRWngvUFdmSUVtYWUyV0dP?=
 =?utf-8?B?V2dnY2tFcGZCTlFuQzRJOTZrcE45MXI4MUc1bHYreERNY0NIYnJYdXQ5QlBm?=
 =?utf-8?B?dTIybmJ5U0EzWWIrTjVzRTFrM1B2R1BHeHRUMkxXUExlT1QzelcxU2Nvb0tn?=
 =?utf-8?B?enFoWlVPL2d1Q3YwditWT3pIcUtWQ1pseitNeExvSG50aU1VUTZnMUlyQUd3?=
 =?utf-8?B?enB6YW9neEFacmRBTFU5bm8ralNFU2RJTEF5bHJqWllrU1BDNjlmVHNCUkJu?=
 =?utf-8?B?aEUwZE5lVjh6MlkrdHhWR1BFZlg5b2cwd0UwQ3kyRENneHUxcW5SUmVDblRI?=
 =?utf-8?B?WnBrNzZXdWhXdGh0Yk9ZcWM1UTNDTXhqckc0NlZOVEd1Y29uajBjT3BOejVi?=
 =?utf-8?B?NURkWHZjTWlIbHZoWUx2Z0JxZ0xueG93Q25ITFJmWHhIWWg5TFlQQmlObGh5?=
 =?utf-8?B?a1FsOHR4ak9KcVE4ajV4QW9KRGhSMFMvem5QUTd2VGl2WmZFRFpDV1B4Rzl6?=
 =?utf-8?B?aWlqRDJUNi8vZVlaVTdDODZ3SWsrYTlHNk1mUURFMHNqOHJvaU1QZjB4RWdD?=
 =?utf-8?B?MmF6NVNKd0FhWnZ6ZVhuUWE3Y0ZFdnJnSXNJQWxyMHU1cmlQUklrTFU5dXdJ?=
 =?utf-8?B?aGJqQkdOZHBiMmpwNElCZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJ3SVd5aGxjRXZrcEFwc0lMT3RnS0RzRWIxMEFYR1pUUUVVYWtWYUVqRlRF?=
 =?utf-8?B?eU9XUGdMdzMrTGhzclJ1VzBFZXF5cGNjMXB1Nlliek15dW4ybXN6NCtTNVlD?=
 =?utf-8?B?c0tpV1FPS1hWL2xEbGxBU3NvVlJlbnhpM2JCcnJ3Q2FQM1N3Y0o0RFNFZi9w?=
 =?utf-8?B?NmJmSmY4QWNtbFVjaUZYSDgydG1vcmtIVGdDcWVZMStkL0VrRS9IS2hIOXFF?=
 =?utf-8?B?VjQyR1A5bzd0Vm1XS0puQ1BheVRvaW8zSnNHYVRyT1JKSFJjL0lRM2VhUHJK?=
 =?utf-8?B?Q0kvQU1XREordmJuVFE5d05ibS9HZ2Y0WDBXcnpuNEN1TU93NmVwZWk4VURR?=
 =?utf-8?B?ek4wd08zbmdWcDhCTGEvRFFhOHQ1TkF0Q3lNemxEL3krSTVQTVpvdHZqcDlu?=
 =?utf-8?B?VzRmYjBQb1l6NzdiSGVxTXF4LzdYNGJTT2kwV01MSDdZajQrdHJtTmY4Z0tw?=
 =?utf-8?B?SVlKeUZPUitzMjRLdzNJV3ZyeTZFTmV3ZVlxT2tqUUxreE1mcC82V1RnRGNC?=
 =?utf-8?B?SytIYlNpa2p2N1VSV2s3dXZGdi9PcWlSWjFFcEc1cklRcWxwT0RDT09aMnZL?=
 =?utf-8?B?MVZRbGgybjdUMDltbXBkaFVTTmVEVEpEbUptZmFqSVhTSlBxNjdKRktDV1lp?=
 =?utf-8?B?c2JXZUg5eUNHUS9qNG5abFVJTWJ5RkRqaG1qR0RoWGRpWS92T3hsa1N1T1pM?=
 =?utf-8?B?aVRmKzRrRE5GTHV2VkQxcUh5M3dPVllja1ZFdXludUd5bVlSVUNidzhEWUd5?=
 =?utf-8?B?VVlDTzFRL3NkTGlKWmowNkZXNDF1eXNxaEVyRDVWK1J6VWRRZ1kwcm14WkN0?=
 =?utf-8?B?azArelhJV2JEem81aGRreVZKb2lyUjJicnpQdHFOR2FQaG5DNGErbFgrY2la?=
 =?utf-8?B?VWdwY25oQ2NBVXcyWDBjRmFzOUZnSDNFcXh2Y2xvN1lMY295aUF3eVVvb3Ew?=
 =?utf-8?B?d1NGMUJrcGNKS2NUQmpXN25HOFppSi9Za1lCR3pFT0EzMmx3Q0xwc0s3WkpF?=
 =?utf-8?B?TkFLUHhvd1oybFhZZG1NZjkrNjVBOUEvK3VJdjJoVllpeExlZ1d2SDZpVnNJ?=
 =?utf-8?B?N0ZZS0E1bUI3cFRMUm9LRnRDVWpjQjBEQ2hpTXorV0pvaC83bUpKYk45MDRN?=
 =?utf-8?B?d1A3M2lIajRUVGF5aEpZd21MTlhmSjJNRWpRdnk0eERXUzdtYlFmTkJtaTU4?=
 =?utf-8?B?WDh0NnZ3aFYvdUtjWjVFaVlVcVZmU3h4YkY4cm5QZnZUeEgwRmwyUThlUGJ4?=
 =?utf-8?B?aUQ1OWE3VmhLMXhxd1h1THluU0ViSHh2d25vSFFoNVBUSnFGWjhoM3oxM1g1?=
 =?utf-8?B?NnhXaC9seVVMV1dNRE9WK1BqcUxkV0ZSRnlKNmpqV1pxWnZrU0RLY0VLaGdn?=
 =?utf-8?B?c2NwZlN1NDM0K1lxOGxxVWk5OGE4U2prK1A0dDNRUVBKKzJQQzEzekpyQ1lJ?=
 =?utf-8?B?cC8wUmV3Qm1VUStDazBoLzNPVk9RazJrNUdVQkJsSnZobmtNcmZMdUtvVklT?=
 =?utf-8?B?SFQ5dHdJOG8wY3duOTRvUVdnTTFya3dYRytEOTd4Qng5V0kwczdaZmg1VXFm?=
 =?utf-8?B?dlRyQUVwZG5RTlN1NE1EYlFwWUFRT0VHYjdPRkRqVFJDNzlaQ0hqTjl1UWF3?=
 =?utf-8?B?Wk1pK1ljSjBVSG5SQnVXbWxrUXFqWXJRL0g4NksrS1VHMjkzdjAxSjQvcFJD?=
 =?utf-8?B?bld1ZkJOU3o2em9hSWpzSU1PaXBQZWhmc0pPQ01SY2lFOFc2OW9JTENmVVFT?=
 =?utf-8?B?M0FlY1lnUmliaG13Y3dIcjVRclJWNU9DalNOQVFWSjdiWHFsZW5qZFdCMnJF?=
 =?utf-8?B?dXZ5TzIwVVZhVFlnd1NDRFd5dGNvYTFWWmp0UVBmWmxMeDA5ZDE5YUYyMjI5?=
 =?utf-8?B?MGdueWx3QldsLzJPL0duSURPckV6dGpTZHhhSWU3WG1zTXhJQVV0Sld5ME4r?=
 =?utf-8?B?S2s2VEljVWY3bXRWUWQvZjR2L3dTTWppRDF3TGRENmNPN1k5aXlOTkJyNkJ1?=
 =?utf-8?B?UTF1MjdOaUREd0p1bzMvRHpnR0tOV2lab2JWRzNKQ3BEK0U1NFJOYVdZRTho?=
 =?utf-8?B?NTdXYlNMdWkyclVvRkordkEzelhRTzZTYklpM2ZpRS9qSW5aK1FRcnI3NC8v?=
 =?utf-8?B?TEdTUUNRM3VkZU55anZBb1BnWjVWenFueVk3ekN3TVBSb1FqcnpBRXRzT3Z6?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gk/4YO3fBm2Pv32wf3P1ouRjf2sX2DSMj7GGcbzRVuEkgb2MbNa6L129WtuuIUHiJEH1u6PoYQIjRk+EqH1mAIlCuxg31JAmkAUVvztDNEcKCMRfcVO/q6fZ+bNZgm+Ahm6sRdQnX+3CBkyHtcWQTObpm6IMRDdvK0xKgUnZL6iEga2k4KgbmTI7AqnLD1BZU13QmH9Elw/lKbYAK5J0bPJ14OQV9E55qS/RjVUxp7iFoSPmCQb0HB0tzLlp3uSqMv4FcjbxTg6dD61ckpf1WUnEEbIyfKfRfsSqcS2aytQ/oYtvAYEDSA5FgzY3I4BPVuPzWSZ8cYjSJbubw1UgJDDsDya65FNvRm8TKmxWCnqpR9074/EnqcuYPHj//hkYJ3IfOzr9BBN9yvjfRbA/4Vald3h6B2tQGILC076/rwXmVUfpFSBf9cgAxTrN8m0cdTxtC8VIaRlyRwEgycSYjwL1OgYnaAPKyclvA9i6u+Liin/KZlfvqB5YKV6v1BaTnDmrmJiZUgwHjVtPlK+jMlhrtocOdwDNuG99IpE6Sqnx0kJ66GL5nfxA/B8l+3qq0C33izqfUYElpB3/KwrInTKyKkux8m+6rVNtuEApAwc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc686410-8ef7-463d-31f5-08dcaaefeda7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:17:44.2993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNVJBpQ8jLyfTK1YjgqbyXQU40Nczk5AEvc2qbAKTfYZShwe0g2YqzpuYr5dgzmWjn2XdvBOMQrCFLHKUFuEMg7jnB5+sCFEEGBByl3iNGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230060
X-Proofpoint-ORIG-GUID: dTbM6K_n46uwSOf9cqh-p6vuASaVWYxz
X-Proofpoint-GUID: dTbM6K_n46uwSOf9cqh-p6vuASaVWYxz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/07/2024 09:09, Eric Auger wrote:
> 
> 
> On 7/23/24 10:00, Joao Martins wrote:
>> On 23/07/2024 08:50, Eric Auger wrote:
>>> Hi Joao,
>>>
>>> On 7/22/24 23:13, Joao Martins wrote:
>>>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>>>> supports dirty tracking. This is done via the data stored in
>>>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>>>
>>>> Qemu doesn't know if VF dirty tracking is supported when allocating
>>>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>>>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>>>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>>>> dirty tracking it always creates HWPTs with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>>>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>  include/hw/vfio/vfio-common.h |  2 ++
>>>>  hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
>>>>  2 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 4e44b26d3c45..1e02c98b09ba 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>>  
>>>>  typedef struct VFIOIOASHwpt {
>>>>      uint32_t hwpt_id;
>>>> +    uint32_t hwpt_flags;
>>>>      QLIST_HEAD(, VFIODevice) device_list;
>>>>      QLIST_ENTRY(VFIOIOASHwpt) next;
>>>>  } VFIOIOASHwpt;
>>>> @@ -139,6 +140,7 @@ typedef struct VFIODevice {
>>>>      OnOffAuto pre_copy_dirty_page_tracking;
>>>>      bool dirty_pages_supported;
>>>>      bool dirty_tracking;
>>>> +    bool iommu_dirty_tracking;
>>>>      HostIOMMUDevice *hiod;
>>>>      int devid;
>>>>      IOMMUFDBackend *iommufd;
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 2324bf892c56..7afea0b041ed 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -110,6 +110,11 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>>>      iommufd_backend_disconnect(vbasedev->iommufd);
>>>>  }
>>>>  
>>>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>> +{
>>>> +    return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>> +}
>>>> +
>>>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>>>  {
>>>>      ERRP_GUARD();
>>>> @@ -246,6 +251,17 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>          }
>>>>      }
>>>>  
>>>> +    /*
>>>> +     * This is quite early and VFIO Migration state isn't yet fully
>>>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>>>> +     * whether IOMMU dirty tracking is going to be requested. Later
>>>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>>>> +     * instead.
>>>> +     */
>>>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>> +    }
>>>> +
>>>>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>                                      container->ioas_id, flags,
>>>>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
>>>> @@ -255,6 +271,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>  
>>>>      hwpt = g_malloc0(sizeof(*hwpt));
>>>>      hwpt->hwpt_id = hwpt_id;
>>>> +    hwpt->hwpt_flags = flags;
>>>>      QLIST_INIT(&hwpt->device_list);
>>>>  
>>>>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>>> @@ -265,8 +282,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>      }
>>>>  
>>>>      vbasedev->hwpt = hwpt;
>>>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>>> +    container->bcontainer.dirty_pages_supported |=
>>>> +                                vbasedev->iommu_dirty_tracking;
>>> Is it possible to have several devices with different
>>>
>>> iommu_dirty_tracking value in the same container? In other words would they be attached to different container/ioas?
>>>
>> In theory, yes, they can be in the same container/ioas. But I guess with IOMMUFD
>> it's possible that we can allocate different containers for different devices
>> given that we can manipulate/pass a different IOMMUFD object.
> Yes I would have suspected they would end up in different
> containers/ioas but I am not sure.
>>
>> In pratice I don't know if such HW platforms even exist where different IOMMU
>> instances present different value of dirty tracking, given that this is a IOMMU
>> feature, rather than endpoint dependent. In x86 it's homogeneous, and likely on
>> smmuv3 server too. There are indeed endpoint related features which may be
> on ARM you may have several SMMU instances. I do agree that the
> likelyhood of those instances having heterogeneous dirty page tracking
> support is low but well I don't know. Maybe we should add a wanrning at
> least, later on if this case arises.
> 

Yeap that's sensible as it's not immediately obvious. Something like:

@@ -345,6 +346,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
     container->bcontainer.dirty_pages_supported |=
                                 vbasedev->iommu_dirty_tracking;
+    if (container->bcontainer.dirty_pages_supported &&
+        !vbasedev->iommu_dirty_tracking) {
+       warn_report("IOMMU instance for device %s doesn't support dirty tracking",
+                    vbasedev->name);
+    }
     return true;
 }


