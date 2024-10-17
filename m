Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BBFD374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SPi-0003Zh-9N; Thu, 17 Oct 2024 11:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SPh-0003ZT-Hy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:27:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SPf-0002oB-PV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:27:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBuf3017814;
 Thu, 17 Oct 2024 15:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=8h/cPvUtmO5l8A/8qtnxrqNEF4T71aIZrxZ19ZT9a6M=; b=
 V1AohY0yoxOIl+A+ORuxdEaREI2gpzMktvfNZL8HEmB+vH2+cu2jjEuBEJi8W3A2
 X5FoskowRwYuzRQ7mTZQTk+JEu7an+7BL21pvaXcgyN4hWJOz11vHVQ0v/LHQ4ED
 GIN+XBT4W9l/nX2mJ1Hz9Me8atuWiR+vrh/fARYVnwCUuLH8QH2R43KfiWcEZUCE
 u3+M2C8TFGaDQ7mCYr63UgNr5TnbKT35C5Aa7b4JygwaXj9WOVp9VxheJD2iUZDL
 rhSyQCMIBOyzP03y0/sYDRx4jotvYzqTKHMejYpGM6rpSN3xMZaO8jhQJQOoksrh
 E6SmEJAZf82oIgJ0mpENiA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnter5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:27:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HESiw6036038; Thu, 17 Oct 2024 15:27:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgv9sg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntIsgdiI0v+F27Lk02YrluEwL3Bw3PW8Kw2ebL1MmPlZYwA8N5ahtklGv0Mr6JprNL1cxEWdsxrWrsKmBhdrDvI1Yg8qEBB3Feg/fngPLQyyOiJxFpAiYoOMVOk5ylrnrudo2zBuwAejNHrPMMIrrqnvMfZNniTHtXvs4cm1b5exFHzaPvr9y5vW/vFkQ8kuKniBdfbKzXVjd+eOW11dfMIVoeUAh3ZaYAQy7iP9+YPFLV4FoK10L6anF6y1lOJtgFjWYx0pagoLA3MohZ/Ok5mpyet7ClYiTfyw7Ayyr9m6p8U3cjT/A6SK1SFAp5ahaPJlTvwszjg4VFXQRJM3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h/cPvUtmO5l8A/8qtnxrqNEF4T71aIZrxZ19ZT9a6M=;
 b=IZHvgMcePvZSDaIR1vc9Hp84ejOH1b8HaG1BAl+yteVQBHPHI5Fv0J4+JxgFDhGLFFi5BZvDMD0RnNOyjqw45Hu5fbnSHezk7briC6oF8OXkiXDaRZkkVYO03v0tAl0a+miGr2/wqxZ7g3YENO3jZEs+HWUQPmdPRATuaNU5XSYATs07c5rdmsn5bjDJnmw+13ogidCv1daU/N+RzOUSEgCP+RcyNpQGKzD+rBsqj1IB3eg9mcKolf67IV1xSsGTxrmoTejC78gURW7rZ5nirUHPHGFVGnmgZ5yJ7z097k75cJz74775LF9BoqH+BfpT4i6oh0bKShaCmUURUqB4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h/cPvUtmO5l8A/8qtnxrqNEF4T71aIZrxZ19ZT9a6M=;
 b=fjjo7T+YYUafisKP2LwhAeO9HQbmwUEPnOeYpe7gwHAz01VouJMdHSjq7QwwZ3gDIVfYhMG6I5uQMO6yWcvf7HLlHmYPXDNEeRPUryAJtBc3yHdIqoBn2kabGW+/y/YWkUovheQAm2X6ypViNkqTSElm9BPVhu+CZiTAqzo9NBg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6084.namprd10.prod.outlook.com (2603:10b6:510:1f8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:27:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:27:32 +0000
Message-ID: <520cd056-c028-4279-9546-f7b6a1be20d7@oracle.com>
Date: Thu, 17 Oct 2024 11:27:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 13/14] net: cleanup for precreate phase
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-14-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1729178055-207271-14-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:fb::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c307d0-4c7f-48d4-187e-08dceec03877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QS81NHdQZGVNSU50VnBIenA1WTFwT2tQTlF5S2Jla1dadzNhblhZMTdkdmYy?=
 =?utf-8?B?Wi9zYnlXVTc3VVVkQi9NWVJGK3NyQXpIbnVqZE5nbUtkVnNWSWNCQWZhUHg0?=
 =?utf-8?B?TWw4ME82NlVHZlN2NzBTS2dRRUJmVnFpVkE2TllTZmo5eElwUVliL3FkY2xu?=
 =?utf-8?B?Y1ZRRTNFNVRqanNyeXZqdUROZm5Lb2kwcUVYbUl2c2tUWlJDVm5UWUtHQTgv?=
 =?utf-8?B?RVByVjQxaUw3Z3dLdVhNRStyNS9WMEpLb1NnVi82T2QxQ1lJZVYyb2hrWGpr?=
 =?utf-8?B?dGZyTm5TWXBXcTFGZHplbWFXUHQ2bzk4WEpnV3VQeGdVeGtQRXZyUDk3dHZt?=
 =?utf-8?B?NlMwSGJ5TXFJSlBwUHM1U1JIRkxEc0tXQ1l4Vy9mdFpKbENjUFZyVzJ6cEIx?=
 =?utf-8?B?WjhvT05tWDM0SEVTZmtXcUI0SkFCSjIvY2lKL29VdnRGVDlldUNzMzRYaDBj?=
 =?utf-8?B?blViZ21Ha1V1dHZNVVJlTG1uSVZ2bllpcjIwdURRS0xBSXRWYVU0aDNrRjFE?=
 =?utf-8?B?REZTbTBnc21YVzFSeW5tUmU2OXA5RVVwNjI5MCtBMFo2dytBc3pTVldSOGhY?=
 =?utf-8?B?cCtidXVnRzJ3SHZsbCtPOWRvRG52Wkc1VmdaOG9WdjFXbjBqdUhHVEtpbzB1?=
 =?utf-8?B?QTFqdkluYmV6dUF1ZXN0OUxsMGk0eEVMYzQyeDd3eDZnNE5VYTNKbmZ1ZzV5?=
 =?utf-8?B?T09yUysyYkxRR3I2QzdPN29LVVlBSVZYdnFNMHk3MmR5YjlISTFSaGFuRzZk?=
 =?utf-8?B?VS8vdy9JVUl3WmFiZTFYZFhGai93Zi95V2NQdUk0bmNRbWI1VEIxblpPUlFu?=
 =?utf-8?B?MGtLUFBrZi9xRGN3WVh0WDloZUpNNWZOdmRMUkFnWE5zYlAwdlFKVWZrc3p0?=
 =?utf-8?B?SlMvYWptbGpmNC9lUk9HZ3BFdk1XQVlRbFl1bGVWMWJpNUl1QU9pRVpxWmxN?=
 =?utf-8?B?dDVtay95WUFCK1JjQTB5QWF1eTk1S3gwMTRHbkQyL3FMZ3psSTJzL25DdXV6?=
 =?utf-8?B?ZmxvSzQzelJTMlVUblFLVWV1MFp2dGl1TDdkUlROOXVUV3k1SnlGa0FOTE81?=
 =?utf-8?B?c2pOdkNUdmpWNCtiUDcxOEk0ejh6MUhFL1EwaVBHN3lHTndvVjV4Q1R2eUNn?=
 =?utf-8?B?eGV6ZXpDQW5VNmJPV0w1Tk45MmN0SXRnRmRYWllYS25QN0wzRUZla25sbkpT?=
 =?utf-8?B?aFRqV2NldjRHSmhUaGFBdkZYZEZmZXZsaGFjNDJscUE3aWFGdVNVY285bHhM?=
 =?utf-8?B?L1FSb0tUcEZWTEJreXNueGdtaVlPTkhBV3NqZTZYSXFDbFdKR1hQNnFpZGJh?=
 =?utf-8?B?a1dEbWkvWVVRaVhYMG5kTGFhTk40SUVEOTkxNW5UNFd0OWM3MGt2V016Wjhv?=
 =?utf-8?B?S1RuUk8xQjNBcEJWdXdCNTZ0bFZGMzcxektBUzB4RXFJbXpyWTgrUmdZRDRP?=
 =?utf-8?B?MS9IUFVkWU1UU2liSDBXUGFkZVVYcWdNbkkxUG4zVGpmRyt4dGxvVVArOEhk?=
 =?utf-8?B?NU5jdlE0NXdySmlKeHNJdDZUZEJGcWJwSnRKRHFCUkVsVmRqT1FaM0RDelNT?=
 =?utf-8?B?ZkZlS093MVJwUjRzV2ZwdGY1SGUwak5IbHQzc3VVNEsvOUd5UXIzbUMzQWI2?=
 =?utf-8?B?NHBocTh0bG1sVUdnb1dqSktMV2t2ZmdsQUdnMWdQb0I0bTl2L2gwMjNjN3Q2?=
 =?utf-8?B?ekNkb3VPbjdXLzdTM0lBU0dBeW1kUVpQd2djTGR6dStqRzZMWTRwUWZQK0Vz?=
 =?utf-8?Q?imbIhKgc20tMK01OABf9qyGiIoqg+QFW4vjBPf/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VmbHFoMnZ3clRLUkNmY3JRcnBRRnM5bUpab203Q2oxclNXN3dWTjlTczNp?=
 =?utf-8?B?Kzd0bUE0U3NzNVhkYXVlWjFlS3BHWjAwd0IyS3h2clpBUElEOEV5ZkRXcnMr?=
 =?utf-8?B?TmlIRjhEU2tqdEhLRmFnM0Z5c3ZZd2lVY1QxQXhncjNoSkMycEZiRDRUQlY5?=
 =?utf-8?B?S0NSbGhkT3B5UmN2bjIwQkJncG1BbDl0TUlRUmxRbDRCQmtKYk4zWUV6OUZU?=
 =?utf-8?B?SG5LS1ZsRGVjaFFadVdjd1dCUWYxYisyQ2pML1kyeXhJWFh4cmI2SW1Qalp0?=
 =?utf-8?B?cktldTJ1c084eFdLNGxjRkNjTEsxektCdUJqYlZXc0c1MzRUUy9oMjhJZVFk?=
 =?utf-8?B?VUIrNktseVBaOFh1WWhwUFVNQlBXQzBmYVprQVlxN3hlMDBEZW80cTEvOVVt?=
 =?utf-8?B?V0pnYVYrTC9haFNRWWJUaENROWdXWGVLQmprRXc2dCtjT2sxZUYxaEtXOXJt?=
 =?utf-8?B?d0piQWR4bEl5d1FEZmQxQUJkZG44UEhZalROM1J5L3pSY1N5cDdCZ3lhYmpW?=
 =?utf-8?B?bFZNUC9OaFJCVnFZYmtVS3d1Nks3bjhoU0ZMS0J0aGdGVklVeWFTN1BDVS9F?=
 =?utf-8?B?alltd1dyamJCSFpTdkIwMnBoSU1OcVN5UlFZMU16c2NKcURVQ3FGTjNzNGNR?=
 =?utf-8?B?b2w3RWRCTzU1bVJIN1dFVzkrNTZnMkFldjA5aHIvQkxXOS90QmdjV3pqS0xq?=
 =?utf-8?B?ME0wcHB6cU1wZWNFR0VGcEdYV0pyUFVudW1panlpMmY0NjNwOXNyOEVoSGE4?=
 =?utf-8?B?WHlXbTVjWDBnb2hldE5sTzRPMVdRSzVhRU1IbElzTVp6dlpHVVVTNjNFclQv?=
 =?utf-8?B?bEJBazdkRFF3THRCRVZUUkM0eVBHOTNLcTIrODFqaGRVVmt0anNEVVE3UVBJ?=
 =?utf-8?B?UnR5bm1IcWtnK3FXek9LeDFIejYwVzlPL2daZTVmM2V5cm1kSDcwUmhWb3F3?=
 =?utf-8?B?LzlZMlp5N3psRG5HMUFON2lXenpxUjdMRFVlK1pZNiswSHA1bDRRR1BmWk9E?=
 =?utf-8?B?VXFJQnpkYVJhMWwzZE4vcnhBQ2NpK2pNUkhqbVBPOGtLeStHeVZ6TUNFOGJK?=
 =?utf-8?B?NndyZmY0VkMwVWJGeHJGdFhHbWc3TFAwUGtLd2FqWjlGMVUyVGE4WlFTamEx?=
 =?utf-8?B?QUpZaWx4WHM5RmVWWHJpREs4dlNqeVpzMk1VNnN5SVVqMGJGSURSVTkvR2lH?=
 =?utf-8?B?aldrc2R0RzZ6REtyTlpURVFKQzB4YmRNZGJCdnVJbFhUaThob1h2TGdEUzFB?=
 =?utf-8?B?MUYzVFAyNUVxYjJrVGNPRGJJVWtsVUZlSmpZSGtZeGFBckk2dDMwRVcvaktU?=
 =?utf-8?B?YzNFOUlKKzFJdGN1TGl2N0ppb0JWbU44QWNTdzRVVE4xTVMxOTVJY0pOeFV4?=
 =?utf-8?B?dzhVZXg5bDgwTXd4QnJtbndTUm04OGNBN0JHTDBGTjM3azBrV2tGRkxGMXhE?=
 =?utf-8?B?RDMvaWJpS0ZZRi9sS011MWZKOGdjZmFITzdER0lKazlhZHBQWUYvb0tPdHFI?=
 =?utf-8?B?Z3Nzc3lRbFEreTQyWFpZb3FUeVpPSlVrUW9ZM09TbEx2VnYwYW4rMSswYlly?=
 =?utf-8?B?b3ZudndHb25CYmVnTnBINkkrMFEraXNHV2J1MnAydTBWbTZOc3Z1R2k3Tjhh?=
 =?utf-8?B?YVd2akdpbHNGRU8xamxBOTJaM3IzUW80TFBGM0J6OGc0SklZL3dLK2JLTDEv?=
 =?utf-8?B?TnNuU2VYdDl3WFVqYWFva0VhVXpYZm5CMHAvbk5WL0xET2t2VExvaG9sQ3l1?=
 =?utf-8?B?bDU0L0ZSOWswb3B6My9VelNCY2xUM2UrVVJSbityZnlOWDNrZHpSUXlrMEZ2?=
 =?utf-8?B?R054ekhwRlIrY2luTkw0NkhmVGpQd2RGc2I4akZxZnNrejg1OXk3L1NZZS8z?=
 =?utf-8?B?b1hUTzMwdVdBOExMaFplMDRGMGdML2d6dUN6bDF0czNFY1ZEVzVZM0VNRXE4?=
 =?utf-8?B?QWN6WDZ3T2NSWXRvRVJ1cExxa29LQk0yMllvbEY2USttRjhlQ2VrRXZlWlA4?=
 =?utf-8?B?ckNEOTY3NU1URmhvWWMwMUkzUEdSQURVZ2FJcjFZM0dLZ0RyTTRYa0FlM1Ni?=
 =?utf-8?B?TXlMbGkycVV0WXV4d2RkbFdDM3FPUmV0WDQzb1VOT0hQRVBtQTV2OU1RS0Rq?=
 =?utf-8?B?VWZIZFB2L0dGTnpSUHhNNFVlOEFnbythTTNYSzJQMjNPbk5KZlpFRnlnVC9p?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wNv5GinWrUODFNhHbtDJLlMvck80YyzHoeiwUg3hZvcFu1ECRTXObO/wwvacDuZq+wTmIWlWw4+ke5JBtgjVZ3wCSnP2eaERYGZ2IsV9p479RpfIpIarB2gbEFxMLr68UTO6h9XATxBlDGX+746UassxFdHHkiBHgQvMEirbvbaf58fERMTfaYSbaCNVSoXDh4NhLlSOLJblIdA6fJMuIK2Vy+rVdMiPzrpAmMGzy9kXJTUN62U2M/+P0SoMRSyivEhYE13pUPjR4Poe0R2/UYs9aONgfZ+oDAukUXOQQFftJO6nAqykqqq6SHHw39LxGr8mQ+TTdUuUp6k8OhXS0JBDn973iMYusUPrSMhSZZKs8tM2Q+bJcwBdqDzxv8zEuEykBgLTOvs+gqUfSW8Il3MDuIgpqwam2O3/3hYKW1WG+OGu5TQ2a8nOheJydD3qfQbUEU4pSPMZMVGdosBZ/r1lhqRZEwA+SfuTmQqYDEyCHdXGyRCQbeAX5kPB1OqkpgO3sDoLvJDOWhV8vGIE7qnyDmUHQDPHMW4SUWlbNR+GJJmenXjU4vZsDEVYT+ySiLBp3pwSKEkUbK8+GRcBmARK4zhy5B8NK+KyXPiDi4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c307d0-4c7f-48d4-187e-08dceec03877
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:27:32.8942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqAJeMmgMi/aR5c91jG2iGQ+z3go0TubDMMiYOS+frc6lQommfWmDyET+4vo154F5/heXtJaZNdnyhqgUEXk35koCtVWTcv0hGvI0PhIL4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170106
X-Proofpoint-ORIG-GUID: 13Mp9TcEqc7GZ3b75iCqsvEIm-ci54nZ
X-Proofpoint-GUID: 13Mp9TcEqc7GZ3b75iCqsvEIm-ci54nZ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

cc jason.
The cover letter for this series is here:
   https://lore.kernel.org/qemu-devel/1729178055-207271-1-git-send-email-steven.sistare@oracle.com
- Steve

On 10/17/2024 11:14 AM, Steve Sistare wrote:
> Guard against unconfigured state if cleanup is called early, such as
> during the precreate phase.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   net/net.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index d9b23a8..207fdb0 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1687,7 +1687,9 @@ void net_cleanup(void)
>           }
>       }
>   
> -    qemu_del_vm_change_state_handler(net_change_state_entry);
> +    if (net_change_state_entry) {
> +        qemu_del_vm_change_state_handler(net_change_state_entry);
> +    }
>   }
>   
>   void net_check_clients(void)


