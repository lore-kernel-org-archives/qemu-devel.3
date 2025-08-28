Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFFACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEO-0007eJ-1U; Thu, 28 Aug 2025 13:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1urbkM-000482-SX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:28:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1urbkJ-0003Go-Ni
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:28:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8tqOr017709;
 Thu, 28 Aug 2025 12:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pW3RyN6doQ/iF2qM9O8dQge6hsNdkMy103SjwNpRGSc=; b=
 J2q+LIpQBTj75/r540nPf9D2ANamlQa5q+NALCBj5EgmkUcrg1ys2KgTCQv2BDD6
 C6eHDFyo3eIc74YCB3Ou5OzGn5f4KJekW3UaVr3Jr4oZY1A4fc8BB40kEv8xRux6
 8YKaoo8fv/oqu96C7n2lAz9zQ6P1uaBsh1u9zWsqlfo+2jjKBHIxAB13+lAaTiYB
 65pOGDMLAuKKe/xmvUYtgTR70ipgKZT0Sr55rHb9yPW9X2Zp7vEdjVQp3v6NrJS4
 aWsWkv69sD7KFMYctyTFcZ5sT+1n4wLEpeYYY4O1TjljJUHVy1tjbEYS3GgEIKKG
 tLOnPt7DkxKo8zqwfQEByQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48erfpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 12:28:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57SC3TVU005068; Thu, 28 Aug 2025 12:28:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48q43by44w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 12:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSKPHqE/p5ap0afyYihZOoaUETqkRK8kw6i7Yj9mFIa2drqvlEqvBLsOJXFVFU5tvB8KQqLI8v22X4UDuWy23dAd2nnnLhKh0L4uf3lMNj7rK7av/sfl/4li9VjwwG0kLtHa7ByEmGgm1sbH+f3f87gNQlJ+scp4ZFH+twJivUhapM9Pn6LEbsrUrUJw2gkP/WH/HjdD+JHfMqrgEWrUBFwFrLS7vWMwuv7BPsNu48m6reebofYUXXWZIX5Np4osYWGBH+9cp9LYoVwwyvbmgnubsIyY5H0RJ8Hep53Qw6T6yGIrW0VMFo/YNk2aiBEvEEWqEjavEIVi2FJy7Npu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW3RyN6doQ/iF2qM9O8dQge6hsNdkMy103SjwNpRGSc=;
 b=LFMxxGULdH/TtgbjsS75GDXcD1A1mwmAQ/AXczNgUdQFoLnvAd01zqLzY2bpMHUcn4XnoajwjWpj+Y5B2Mf5JADonXk+0HnzFsuecbjAC1wwh4PCBfMgpDBKrrC+K4L6hpSfVcC5rhYIbPLcq2cUERuQKNpCAUWDr0MGa+EB5ko0TkMsR9WQOxA1HUvpXDyUO9nIno6oJm22wyINX11SNvodVDcQeaUUa91PeOL1fgLBt2s7Fm6lEy/vUgTvWjXcArd0MMRYDKUdoEc7jplQ+SiZyzm3kkCv4fxGjBEdEOrk+H8NEMR929Xdw8EkxDDxFnp29osh0wEtJ3VYYIOcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW3RyN6doQ/iF2qM9O8dQge6hsNdkMy103SjwNpRGSc=;
 b=A+JTSjcoqAgzQH7OkjXS6hKsObOt+e/l9PnBUJgWBZeWdgQPDz/F9qNYTQdjp/dNqxgmvqKEGxftZD5PjcwYur4MnOVUR5AcdhEmF2cuhA/l/nRRVZD99fyoICtNK+VOwEARlktD4sWyfyDIJCt1lBYJOU4qBP0tEAZ7JfUmYxg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6454.namprd10.prod.outlook.com (2603:10b6:510:22e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 28 Aug
 2025 12:28:41 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 12:28:40 +0000
Message-ID: <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
Date: Thu, 28 Aug 2025 08:28:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Remap only populated parts in a section
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250814032414.301387-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: a997ff17-5686-42b6-bf5c-08dde62e6b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUw0dzVwTXhoL0krNmZJUXRlZURWd0toR3hIQ3BmeitNbmxTM3JLeGluU1Jm?=
 =?utf-8?B?R2hySzhDeGlJUzdkelR1OU1BNUhCQXQyTjdyRHhJQ01xQTJwK04vVUJxUXJP?=
 =?utf-8?B?eEdLTTVGb1QzRDBhWU9CY0gxZC9sSnVOQWEwZVpjTlVHQW52SXlmYmdJbEFX?=
 =?utf-8?B?QmRyOFpyeFNlM2JId1M2YVpZZDVxSCtDV1dIRVVxdm1BREFTbFllWmtqRUtS?=
 =?utf-8?B?RkpOVUhvN2w1WmJLalF6eUR5RzU1ZFhNaWxZZHd2YmpOOVFtTkRrRmVjV2ZK?=
 =?utf-8?B?VWlUeXlSYnVWNURpSDkrRGl4TzRKVy8zNVJOcEtDdzZoY2RBRjBvdlNBTUxW?=
 =?utf-8?B?d2VLWStyT3k1ZlhJNU85aGUyNXc3ZWhkRG9uQzBJUW5sRloyZDRRcU9oSFBr?=
 =?utf-8?B?NGtiZlp6d0hVQUllc05kbXlIdzNUNFlEOXhub3UwdUhldElRSzRobWJNVWF6?=
 =?utf-8?B?dUUyYm1HVFJ3TWF4UVRlbTc0dHJzZ2luc1BjWEw2SFZrZGlxSWU0NjBRTGVL?=
 =?utf-8?B?Z2FXYWgwdkxYM2JBbUV3dTJEajEwblcwVGFPUUpXOEZuRW1GY3lFQmw4K3FF?=
 =?utf-8?B?M3NYY1RvbzROUWRLSll5U01vLzB2SkF2RGZjZEZYSnBnb0hRbjNPYzZDSkdy?=
 =?utf-8?B?K2FYQ21hZWo0WGY5c1QweVdmWkU5eXZLd2FUUnV3SVE1ZkVLN1k1VVNSN1RU?=
 =?utf-8?B?VHNsTjlCaVduOGVuMHMrRDdyeGZkVlAwakx5aXJsUDlBaUNMMkRoZlhMWG1S?=
 =?utf-8?B?dldoNDZPYnlzbkw2WE90NlkyY3AyQnVUNTY3cXlJMGFoRno4YUNTU2lIa0xU?=
 =?utf-8?B?SUtoMkw0YlUrclk4T0l5Zk5CRm9EaWNsUTVhTE5wQk1jWjczaFJMaGJHU0dF?=
 =?utf-8?B?dm1MU0tHUzFBcjVTNVNFNGtXcXZ5UlpDMzJmb1FiUmpCZHVlSUpIbnpyZ1gy?=
 =?utf-8?B?aEt3NmI0UnQzZ0UwbDlQSTFoUVk0TFQ4bkluZWNVL0k3L24vOGJKemQyUmRV?=
 =?utf-8?B?aVVXaHpiUWkwZmlRVFlhNXFwMnM0Ym9ZYjcrRDROOFhmcEVhNEZPeDlsK00r?=
 =?utf-8?B?RndqOFc0TUZhT1ZnVGJFTVBtaDdXM2lSRmtBelA1ekNvU2c0UEFMNDBnLzha?=
 =?utf-8?B?UzZuNmNXbldxb09qNG1nNW1ibUhITmQ3OTF4WE8vdGZiemlwSUthcGgzUjBh?=
 =?utf-8?B?eDdscGVLSnZCb3VqeG5KMTY3RmFBMkJQSWtLeVJxdDBzRjF0NW00enNIWkJI?=
 =?utf-8?B?eWRpdEFtUFcxN1pmbk9BNUFjcU44eXBWSjFMR3pZYlFBOHFEUjFlQzNvakVh?=
 =?utf-8?B?TWRaRU0xQ1hmTTBJWDlESnJpdGU5N2VCRUFkV1VNVWRHQ0dFd3Q1eVpvK09y?=
 =?utf-8?B?SlpieWQ1TGdhTThudE1wY0JKVDdzMEEzbE1IM0FWZnp3MkxDZDJGWUo1cXBW?=
 =?utf-8?B?NFFtL3pIQW1zMHc4THJxOFBzZDFMR1ZQTFRJM1Z3dElSL245TlphWXo0cWk3?=
 =?utf-8?B?ejVrdWZEeG9DaHFtK25LVDI5T2ZWUEZxVDBaZmxIWGROc2w2aDhCeEd6UTJu?=
 =?utf-8?B?aUVJRElqSWltR0tzeEh3Q3JsbW5mK2loS29ON2EvV0ZCZndFY3hYbzYyVXNF?=
 =?utf-8?B?a0NoNyt6b3BmRTVjbjNVc0VtN1ZkV3RMaXRZK0hhck5BeEY4WG42V3duRFQ3?=
 =?utf-8?B?SDJsVUhENkhoYVQya1RZUWpWK3hpcmp2ZGN6cnowVUdwQ3pyMUdjWU13Vjhn?=
 =?utf-8?B?Rm9aT2E5M1BVdFFkblpEdG1oUkNWM1lLYWlQRFlSVy9kTmp0SjlEcVpVU1ha?=
 =?utf-8?B?THYxUGNsUU5xcEk0TkRHY1NhbzJWaEV5SkJnR0Z5bnF4T2RWLzNOY3B5SmpH?=
 =?utf-8?B?OENDK3NGMzRPUEVIUFc2QnZSa0RCeW41WlBQSURYaE5Cd01KNktXa3F5UWlK?=
 =?utf-8?Q?dxx/hv6zwdo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZ5ZEhQUDNMeHVxNEs5SW9sMVM0bWpuNXdYOW5GQS9uczUrNzBOdGd3VHln?=
 =?utf-8?B?dU5vKzNlY3h3dG9Sd2ttQkI5VG1jcEYvcERPcndPSzduRVhPT050bWk2UHdQ?=
 =?utf-8?B?azQySzlsY1pGU3lXb056QWg1QmZndmhILzFaalNhaUdKdUlJZFNEb2VqRkg4?=
 =?utf-8?B?WHFpVkd0ZDFoSkZUcTdVcGliRmpWWXJzN1dRdGc5eVloOWxSVjRpOE44ZHYr?=
 =?utf-8?B?T2dybXB0RlNvOVVYTVh2RmR0UUtpUFk0QnNQR3VUak50c0pYdW9xZ3cvU2Z5?=
 =?utf-8?B?Wi82cDVMOW9iQkxGUlJtZUtzOXRaY1hnUFZuRVhjWERXZWFWaDZpUFNQWWxT?=
 =?utf-8?B?eFpWaU84UXBZR3BxQWVMdjdkdlYyV1pRM3o3eTh3dnkySWNlaE5iT0liclB2?=
 =?utf-8?B?bzJKNXQzMHErVUVVZFZMdTRCTjh0aC9qejJrL3BpbFZtdCtGTjlLc3A3T2h0?=
 =?utf-8?B?dUkyUS9kVjJ0bVNGbDZxWkZQMkpIVk92aTNoZG5qMW1IL1A5UTN0aGU4c280?=
 =?utf-8?B?UWFEK3UzVVlBeGxZOEVtd3hmTUkwcGNnamJQZ0xZRG41KzNYdExKUGlXVjh5?=
 =?utf-8?B?TEZFd2FEazQrQi9MQnhVbEhxbWM2a29acHFvSHlLR3JKdGE5RCticXIwcnVK?=
 =?utf-8?B?ZWJVYWVEbEoyTjlNNlZhZVYvZzRUeGxwZ2VvckxjRTdEcjhUdGlOVzNuZzBF?=
 =?utf-8?B?WkM4U3ViYkVFcXNacVMvdXNjSnJXMnJyZGlSTFdCdUR5Znc0WVRKbmxyeUls?=
 =?utf-8?B?TGxJdWFoL3pINmJMMFBrWmVCM2o5dkFDRjNWMGkxMmxiRFFQbFkrcTlSak85?=
 =?utf-8?B?NnpEekE0dUM5cE9pZWgyNFdlcnBIV2VleFB2QnRRZDdSS0dxZEVLUVZjc3FX?=
 =?utf-8?B?Lzd3N1pCTHBjZldIa3BKMkY3QkVmL2ljWm5mV2FGWThlUnQ4ZFdCTlF4b25Z?=
 =?utf-8?B?bFlQVFZuMlgwdUg3NnJ6Vk1mLzdXL00rZ09MK2VBNHZTb21mcithUkVMeklQ?=
 =?utf-8?B?NWpYY0tONGl5TjBoTW9KMzBTcWtLTWFpaGpVZFR1ckxHQWpxNXQ0eTByaG5I?=
 =?utf-8?B?VUxTZjd5UHhKdG5HU2FsV1M2c1JkUTFxY3N3bmxxaFo1UW1CUWFqRlRIcG1w?=
 =?utf-8?B?Mktoa3VaUW1lc01WTlBnYVk0dGJPZVVFQXdDWDhDUEp0T1NCT0JWMEJGUkx6?=
 =?utf-8?B?NW9WUjZjSkxEaWJHL3hLMndzVzBPYkhzUzZHbnlUcXozeUR2bTZId1NqYThw?=
 =?utf-8?B?c000bVMzSHB2Tlc1ZFpLdk1TNTFpQ29iNXVjbGZjWGlhMHRyVlVFNmZlNU9j?=
 =?utf-8?B?dFZlLzcyMUk4bkUrc3EvQ3FNRWhWWUxDTS9pT2dRSVBNNXNNMlp3bktCQlli?=
 =?utf-8?B?QnlNVFlzd1E0Zit2ZnZTSnpOMjZHWGFWU29EWGhxUVZkNUhYTlRFSzU4dE9L?=
 =?utf-8?B?VlFOa2c1ZGNEMWVJTVhhOTkvNUJlellhMkQ4c2lWOFQ0eENObDZKUk1ESlFp?=
 =?utf-8?B?aGVOc2g1WExkSURvR1JzSDRCeVpOMEtaNnN0c3BZVDBzYWxPNEhvRkpDREJR?=
 =?utf-8?B?cis2eThNblBHUE03UVFZeGsrem9JRnBkTCt3bGU5eUtyaVF3SDFNVU9jbnNh?=
 =?utf-8?B?T1NNZkVlRXhBcUt2NlluVDlEejkvUCtJR2thbG5nQXFpZlFXT1A3Nlg2Ynhw?=
 =?utf-8?B?a0tCUmdheTh1cWJqNHhJWU56UnNHQUc3ZmNzbnJxanA2M2dCYnNxOVFWV0cv?=
 =?utf-8?B?ZWFuMVpmdkJMbXZCYlMwWTVyeWFYeGJvelFRR2paaXRhditDSWZwWHNIL3VK?=
 =?utf-8?B?RkxuVWJQbnFqY0U1N0d6MlNYQi9xZCtaRW9jZ083OTJGQ2NkNzExeE9tczZN?=
 =?utf-8?B?T05sRUV3NDVYMGIvZktqTS93RkRCaVZ0b2pXS0YvQ1Y2ZDcwYVNLc2RwYlN1?=
 =?utf-8?B?dU5PYnZFTU1oMkFuZ283NC9BNHFPS0wyQVBJWXdKdi9NSEpFRkx1ak9RYWVM?=
 =?utf-8?B?c255Q0wzcGs1bm9MdzZaVTdQQkEvVFM4UlpqOEYzZFZ6RkxNZ3J1K01vVi9S?=
 =?utf-8?B?c1k2RSs3V25lMThNNGQwOVVEVXhoL3RRUE5ZdlJKNmNJWkUyLzV2dWVXZWtJ?=
 =?utf-8?B?WlIwSkw2Vlk5SmFUSEVuZiswNWw2MWQ0WXZtK2dSMWpyYUlTNmdRU2ZoMzJx?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x1cM+G4VPzilpDmtIliUDLZoQzoO7tqKtfmjV7z850BNGEE4c8T+mJm2r714tJWtN5RapcUwBdjFtEAmVpmeU0Eid87F7UYzXAm82GEHwmucoiP9BooaBxu05UPr69NbLnxzc6zynqXdpJiAd8b7gpxX7TK+Rc7pZ0ypWD1qpuw9Jb82LGploniPFTqdXJi9J/nePft/gi6VY8x8sX7umHOXvo57sDaQFI6TLicpcHMBRZa0oafn1isdXO/46m6pc5PLfuJzIIaYij2GSukpoDQ+VGJBNASQOmF9bN4XeY9gZ3ff2ukGonvznHL/HAXG8AoV4k/F1dmbfKmWCZssWgCRHYvVWVd9ZREWx8TdreuNUKNcTfHrCCmGrKd73pA3cjozgPTxYFYVtaMN+iL9sAAA36bwaICiZzH/C9g1gw7fDaxAYuhxx4G47Xyc08RRkRfVSxx+AbDqyNQJvkCPj9nOrcQtB28m1PWpIQHQbtFP2qCHJfPl61EE/43n9RxUmYd7cFm1UJMlEJwd5efP17jk++7Pzgds+iKfJ4+M+hd14VfwaxBQK+llykb0aFX4btO36tWQMQOkUscHW6FMtE9vMGE11tq3D/QLa6hjO8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a997ff17-5686-42b6-bf5c-08dde62e6b9d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:28:40.8886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayNuuSHaDaCLsAuNZwD8aiDxaRGuLTolZ8EazbYTF73Eyf44SxPHGDLOTN89GZjGFSsqanM661g8UZj2lV8TmsqIgKyzEVVIYcSp/Ecmk0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280104
X-Proofpoint-GUID: -eukFZqUwE3W6_j9_BfxLPYi7jLnvsw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX27JggZufMuR2
 QWgaX9n1IZBfefbB4EEd2KAIutYiTZv9Ge2/HZWvaccwiQ3j0ZDx9o3ILwrDDWR0XrsFkMshd/A
 Fq5u5S9GbscxVJrgjtae9SOF9NzqWLPxowkH6cvWj6m1it5uVLBUiaMAT3/PVtmhrzLjnJDt3QB
 zsGgUX7wAUnOKFc5rMM+i+oQoJXqnuvbm07s42py4HB0PiJ3vMmNIW9HXRNEcAol/hP3znfKlXz
 rwUaPT3hfv/EmITlT/M7o8lDFoyIGK80JRcaXWJAsbbRyX9jHHF1R8UNAR4up4wi2aewiY/FC1M
 qsURoNBgXwV+GW3T1yKYjTBYmKJ/cnLjyQnxnBVqm22XljoJ3DCKHaN+8AJ+XgHmu8lCuevOE95
 wD/4MTO9
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68b04b80 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=QC_ezbJ6CxWCFPOl7q8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -eukFZqUwE3W6_j9_BfxLPYi7jLnvsw-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 8/13/2025 11:24 PM, Zhenzhong Duan wrote:
> If there are multiple containers and unmap-all fails for some container, we
> need to remap vaddr for the other containers for which unmap-all succeeded.
> When ram discard is enabled, we should only remap populated parts in a
> section instead of the whole section.
> 
> Export vfio_ram_discard_notify_populate() and use it to do population.
> 
> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> btw: I didn't find easy to test this corner case, only code inspecting

Thanks Zhenzhong, this looks correct.

However, I never liked patch
   eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")

I think it adds too much complexity for a rare case.  In fact, if we
examine all the possible error return codes, I believe they all would
be caused by other qemu application bugs, or kernel bugs:

vfio_dma_do_unmap()
   returns -EBUSY if an mdev exists.  qemu blocks live update blocker
     when mdev is present.  If this occurs, the blocker has a bug.
   returns -EINVAL if the vaddr was already invalidated.  qemu already
     invalidated it, or never remapped the vaddr after a previous live
     update.  Both are qemu bugs.

iopt_unmap_all
   iopt_unmap_iova_range
     -EBUSY - qemu is concurrently performing other dma map or unmap
              operations.  a bug.

     -EDEADLOCK - Something is not responding to unmap requests.

Therefore, I think we should just revert eba1f657cbb1, and assert that
the qemu vfio_dma_unmap_vaddr_all() call succeeds.

Thoughts?

- Steve

>   include/hw/vfio/vfio-container-base.h |  3 +++
>   include/hw/vfio/vfio-cpr.h            |  2 +-
>   hw/vfio/cpr-legacy.c                  | 19 ++++++++++++++-----
>   hw/vfio/listener.c                    |  8 ++++----
>   4 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index bded6e993f..3f0c085143 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -269,6 +269,9 @@ struct VFIOIOMMUClass {
>       void (*release)(VFIOContainerBase *bcontainer);
>   };
>   
> +int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
> +                                     MemoryRegionSection *section);
> +
>   VFIORamDiscardListener *vfio_find_ram_discard_listener(
>       VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index d37daffbc5..fb32a5f873 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -67,7 +67,7 @@ bool vfio_cpr_container_match(struct VFIOContainer *container,
>   void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>                              MemoryRegionSection *section);
>   
> -bool vfio_cpr_ram_discard_register_listener(
> +bool vfio_cpr_ram_discard_replay_populated(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
>   void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 553b203e9b..6909c0a616 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -224,22 +224,31 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
>       memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>   }
>   
> +static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
> +{
> +    RamDiscardListener *rdl = opaque;
> +    return vfio_ram_discard_notify_populate(rdl, section);
> +}
> +
>   /*
>    * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
>    * succeeding for others, so the latter have lost their vaddr.  Call this
> - * to restore vaddr for a section with a RamDiscardManager.
> + * to restore vaddr for populated parts in a section with a RamDiscardManager.
>    *
> - * The ram discard listener already exists.  Call its populate function
> + * The ram discard listener already exists.  Call its replay_populated function
>    * directly, which calls vfio_legacy_cpr_dma_map.
>    */
> -bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
> -                                            MemoryRegionSection *section)
> +bool vfio_cpr_ram_discard_replay_populated(VFIOContainerBase *bcontainer,
> +                                           MemoryRegionSection *section)
>   {
> +    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       VFIORamDiscardListener *vrdl =
>           vfio_find_ram_discard_listener(bcontainer, section);
>   
>       g_assert(vrdl);
> -    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
> +    return ram_discard_manager_replay_populated(rdm, section,
> +                                                vfio_cpr_rdm_remap,
> +                                                &vrdl->listener) == 0;
>   }
>   
>   int vfio_cpr_group_get_device_fd(int d, const char *name)
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index f498e23a93..74837c1122 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -215,8 +215,8 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>       }
>   }
>   
> -static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
> -                                            MemoryRegionSection *section)
> +int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
> +                                     MemoryRegionSection *section)
>   {
>       VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
>                                                   listener);
> @@ -572,8 +572,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>       if (memory_region_has_ram_discard_manager(section->mr)) {
>           if (!cpr_remap) {
>               vfio_ram_discard_register_listener(bcontainer, section);
> -        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
> -                                                           section)) {
> +        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
> +                                                          section)) {
>               goto fail;
>           }
>           return;


