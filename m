Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E3ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 14:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Q5X-0008T7-22; Wed, 24 Sep 2025 10:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1v1Q5S-0008Sv-KD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:03:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1v1Q5C-0000HQ-UW
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:03:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODRIOW011851;
 Wed, 24 Sep 2025 14:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Hke2Vw6moehdtYuW/XSyp5BsQ+uex2H34qVlreuGsxY=; b=
 fsLnX6NOxw2aIOluDiCEx2M9bj6eH2MlXaE7E2dw3zOW1zkzMwpstL/D259fUeFQ
 KLlKn2Y6eghcFVvRAlQGfoRmRMKbdEDrYZwOBmREAxDb1xgSC9FGfwyJ8TUcc6rX
 T8SXS6tIuoMgT7DZAn3wARSYR37vMwtQ4o5vR8qJ2LjXDaZruZcGbMFFlQsp6rR5
 Cf/bq7bVTBzLhmQqTN5RffbjGnYRNKe0F1jfvo9hgwAgl39l0DcXCK1SIV0vORm9
 u4Obvlg46Om2v3COOBR9GHvAnUGuXdxEQfQF2UJ9zq2J/++dVpRyAC/nTPsZn+bG
 svh4BTTR4GDy7Ua86+8+qQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt7um3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 14:02:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58OC3nVT030974; Wed, 24 Sep 2025 14:02:43 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 499jq9yy3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 14:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M08Sv3+/HhcMzvsSw/09bw95q5zzPka/ecXtDxW6aWta7+JFDXY6inX/z4HfoyYkRcpmhLbs1uWg7NN+pNgj3Vx1UkwiEOZSJxO/ejOvEUwaAjLvwRiaGha9727kSTM+kDd04zT9renmUZ2Mz+XW/6orrfRVxUqfRzzvgLbAI7v8iLHGX6KtN8o5Rh1oLVxOF2nFNIw0r6brDKvf4wFDxf+vp9MtlN3KdsvExp/hLzCfKscU5j3HSqk3+qH3QoKuMl88FHU9EB/2cAasjj77XSFPA0CGwNf0scwQ5YcoLlXSOmYmKLR2sB5KCPaoQtQPNFlRyTUeYm+9/iGomhZjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hke2Vw6moehdtYuW/XSyp5BsQ+uex2H34qVlreuGsxY=;
 b=I17O7kLlJVZw8VfVJxDoQHN5Q9fphv5AhtxKljfB2Mi/ku7mTiZfHnRSOdEIOpj1HQmQI+52xWYOLXnBcpBuNpUo47Mj+kYivLbMYcBpFrnzPiDB/BL2KhumlLvPkv70VWWbtJ76BvForO9diHWz0XO+MyLPZ2n3azxIMwWSk/NyskAzsGsy/0KIYpG5q+dYlZrKRx27UGenFJ0DxTe27EGiVuv5mS+sWPK3QhbHcOecsekWGX+81PGfGc4ceNNdmc+KbIMQc1KJBcl9K9E206SDRc+w2lPMOsW4lZpVYO+W4qeExPvRR5bcYN33CV6uGHAJOk7w6xCvbHvW4b3kEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hke2Vw6moehdtYuW/XSyp5BsQ+uex2H34qVlreuGsxY=;
 b=KS+T5i238A9CuQWu1J/OPaMSn6zm3h9J9IdHpzoxPkE5P3rt2mSnuec9dRcVbE4PZP2JGv3elGxhjSlZJMJ1fNCrgih0xrDF4vw+Jj3xt9gj8KIuIuzZ4s+rX0Ooq3aU3pDp59WxEjjO5inj9iJyuH4BBF3vgQVxAxE/tTAGflg=
Received: from BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22)
 by SA1PR10MB6446.namprd10.prod.outlook.com (2603:10b6:806:29f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:02:37 +0000
Received: from BY5PR10MB4356.namprd10.prod.outlook.com
 ([fe80::6978:9679:271d:c7d2]) by BY5PR10MB4356.namprd10.prod.outlook.com
 ([fe80::6978:9679:271d:c7d2%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:02:37 +0000
Message-ID: <1f818bd8-7164-42f5-a6c2-22c2384be64e@oracle.com>
Date: Wed, 24 Sep 2025 10:02:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa-dev: add get_vhost() callback for vhost-vdpa device
To: Li Zhaoxin <lizhaoxin04@baidu.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Miao Kezhan <miaokezhan@baidu.com>
References: <bf9c6885d0d425248a5765951a817ea518d92e8a.1758635007.git.lizhaoxin04@baidu.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <bf9c6885d0d425248a5765951a817ea518d92e8a.1758635007.git.lizhaoxin04@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:530::28) To BY5PR10MB4356.namprd10.prod.outlook.com
 (2603:10b6:a03:210::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:EE_|SA1PR10MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a96ecc-0d42-4374-0bfc-08ddfb73047f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzM4UHJyanZ3QkN5RlJMZkpTZWplRFRYTVJsN0o1MVVlS3dHaE5DaXNEK0xE?=
 =?utf-8?B?eVI2ZG9sem5KdmNZSEJGSlVRV0ZrUWhuamFQTUQ5NWVEUnFXZ0diTHZCYnNI?=
 =?utf-8?B?cGNVL01RekpScEZEdmNUR3hZNFd6VmtpNlpsTkJiVWVHQk9LZWkzbTJzdWlr?=
 =?utf-8?B?NTBYdHdDR1l3RFhZbkZ3S3V0UFZoN0xRVXlZSEQ0Z01kVkhLald1cnpZSTRh?=
 =?utf-8?B?K242ZGVqMjFDZnVkRjZXb05paWppNUFGbTQ2NVp1K25HVENJNWxab1Z2dFc1?=
 =?utf-8?B?bHV2Rk1iTDdiT3pSN2xwSk5zeGlrUzBvKzUxZytIYzRuSlluV2RtekhLaVNv?=
 =?utf-8?B?T1RjTVYyQllIYUtxZ3FncnVMNmlqU1BZeCtwWXNwcWZvYVUyYWowaW96dzh4?=
 =?utf-8?B?amt4S215NDNzeHFuMEU0TEVLSkl2OHFkeHBXSUwyY1VpSXJzZ3pBQU5iVmJo?=
 =?utf-8?B?Snhqam5iMzRoQ0x1a2tGNk1VdlpNRHNycG1vU29Ialo4aEM0eHNXbVZsRFpN?=
 =?utf-8?B?WkZ0dSt2UUxXR0J3K2Qzdk9ldHAwNHlwK3I2MkpjRjR5UVE1c1JsQjVkTC9t?=
 =?utf-8?B?Z0d1R2ZHakN3NDA5Y01QSmV6eWFPZS9SOU0wK3d5OWxZQUhKOWhldFRkSVhn?=
 =?utf-8?B?dTdCZXFDWnUzK1lGSm9BTC95bldqN0NtYTB6ejErblhyNktyc09oSFpBN0RK?=
 =?utf-8?B?SGNFdDNndEhvV1lreE9qdmw2TitkWkZpQ2xlRkI2RkJ2amM5cmlucVdqVUxE?=
 =?utf-8?B?VDZFWVlDeWU1Yi9hSFU4Mko0VEVYVnFjWWxWQlFYbUlPdXZsMmEzMk0xYWZ2?=
 =?utf-8?B?b3lmNWc4WVZVeFBJdjZMWVZOVXVKS3lBSEY5ZGo2SkNRS2gzS2JJdkVYbGcw?=
 =?utf-8?B?Z3owL1p4K0JiUzFkY1hDZHQvUU4xdmZVYXgybW4yTEsvOUtiSUh5WXlSTzFY?=
 =?utf-8?B?WW1TbFlRM2hZWTBuamVvZzAzbVV0NnZ4VStCNkVQSkRPbnF1VzE1aWpvUDho?=
 =?utf-8?B?SFdVb0I3eUhCbENPY3RhMWtvZFlvZzR5SGZidXNURXNudFFtOEZRRFNtSm9L?=
 =?utf-8?B?SGZyQzhXS2RmOUlEaUVsVnIwQks2a1kxc0kzOWZvZ2ROSDdvMG5xZTNKcmhZ?=
 =?utf-8?B?RDh4WUJJMUJiWnpBYTRmam9OMFJhTFF1b3M5K3ZOdDY4TnpHZXptZWVIclZG?=
 =?utf-8?B?YmFVU3VuTldScWtjeTdsNHdJVDRuYWc4bGhkbW8yT0JyN05RUXBpSVdCOHZP?=
 =?utf-8?B?eGFGZmVKL2tPUFBNV3NWOGVrbDNIdnp6Rm5zTUtzUHdPTkt4cnQ1VnZtT2li?=
 =?utf-8?B?L3VJdmV5RXk1YmYxbkU1QnlVejc0UExRblhLd0VHNXNTL2ovWFFxU3MvcnBS?=
 =?utf-8?B?WG9NNThhRVBzRU4vajh4ZEtuQWNIblgraDBUWU10V3BheTRvU01ZUk53WjB6?=
 =?utf-8?B?VXZDdDhTTnRPb0E4NkpKN0FteUdnNzVjTHRCbTU2MmRXRzRLalhWbk5xdGYy?=
 =?utf-8?B?TTQ3cVhQdlBxLy83emp4eUl4c0ppeHNCcmE2di9uTzNVUml4SVQ4cWJ1V2Rj?=
 =?utf-8?B?eFA5SXdNUHhxZTZXa0dPVkx6QngwcW5VYkNmOWwwVHRYTjRHOFE3ZGVaNGlG?=
 =?utf-8?B?TzhtdnlmUDhLa0hzcUZZV3ZVcVBZbWtmN2NkNHNLTmJQK0JsekVNZWZpdmJR?=
 =?utf-8?B?cTFjc1pzMVlHeUNOcThTVitmOURscFd1ejhvSExOOVVubDAvSHNTMWJNM20v?=
 =?utf-8?B?NGRRUmxFR2lEbkJDT1UreXBPZ2JqSE5zY0JIbjFwbTFzN2dXK3cxemhTL1pM?=
 =?utf-8?B?ekM4cHVISnJBNXZuTHN4enlRaTBDNno3UHVlRTZwV2owOGZxK3crY1E5TU5G?=
 =?utf-8?B?eUJMenRCd1BJVjVLQnNhOXFEMlB0cEUwN0o2V3E3bis0YWxCNWlYa0lHK1RK?=
 =?utf-8?Q?IjxmjPUUi9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB4356.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWlyekYrd29wZHd6aENqL0RKdHVvZzVZbzVqdGpqcXN0T1RLU0o2R1k2ckhx?=
 =?utf-8?B?ZjlmaHpzZUMxeVN4YlM2Nm5QYWJrY2I4ejQyL2x4N3I1THlKNUh1ODU1ck1i?=
 =?utf-8?B?WGZWQThVQUtUQm14eFAwcVFJamZiYUlyaVhjYTV0c0YyeHkzZ0hja3BES2Ri?=
 =?utf-8?B?UkVmUXlhOG5rTm01N3YwUFFBMG5uR3NiNkJQNXlaNHJrOW5SMlF1NHpxU1hX?=
 =?utf-8?B?WTJycytqdERxdzhrV2dmc3UwcDZKVTlQeXdpSEZXVEdxbTZnUlR0RGlzUGg1?=
 =?utf-8?B?VkRVcHhzUFA2d2NKMy84RkkvcXJSSFNKVW5zbjBjMys4UWxVS2tDV1hmcUVH?=
 =?utf-8?B?QlNrKzloRlhMR0RtamM3cVRBeFZnQStsSExZWTVyRkJTd1VOZi9wbjBGZE54?=
 =?utf-8?B?WVJZNjkrWkNyQVNFb29IUWg3RmhxZEJ0aXIxMUt6VXhFMVV4YmQ0eE1kODVU?=
 =?utf-8?B?UlRRblF5b3NLTjVJdDg5YjgrcXREUGgrdkFVZHo3VmlRZjhkaXh1aTJwUmJh?=
 =?utf-8?B?TElkcW5EM1NJbXZQUG12VkdIOVEzVzd1RDkwOEJpSlZVQVpXTkRveTAxS1dj?=
 =?utf-8?B?SHNla2ZLMjNoUER2T3QzaEovVnZoZFpZVnNma0toWlgxaFVQd3h3MzZLS3p2?=
 =?utf-8?B?ck9MZmZqRVp0SXRnUHM1ZVBqaS95NGVhRW51SlQ3bS9XcXpTYjlLYTVCRWZy?=
 =?utf-8?B?UVpSTFlxTEZVVjJXNWFic0xuYjhsL0cyVzJ2R2pHWjYxbTJUUHhGa2paVFFR?=
 =?utf-8?B?UlRwa0ZJMjlrYUlNOGw1Vm9oNStHbEZvanh3OWVTemd4MlBpR2pvQzlMMTVu?=
 =?utf-8?B?OENZRzM2d2ExTUlGb1FHdW54VjE3MVlGZC8xWitva1J1MzJ3dG9EY2U2Z3FZ?=
 =?utf-8?B?ejFGclFwY3JyMlRLdGswNkVoY29SUG85T3l6ZFkrbDQ3aHR0N2JBa2hhZ3NN?=
 =?utf-8?B?d1VtY2M4bHJ3QnFUTlZwM2NTbE4yZUF0T2VRQzhuR1lBVmZHUWFtTkN3SWYz?=
 =?utf-8?B?ZFAxUmI5Z0ZKTGczR2dVb1g1SEFOTnQwazRnMytMZ2NXeGR3WUVKSHh3ai81?=
 =?utf-8?B?VWZWeWI2cFJrQXRqTWQzanRDanUyNFdGZko4cTVacUVjd1JpQzQyNklGMUJI?=
 =?utf-8?B?NkE1dHBPRWhqYnBEalR1dE0yd0czeHVZYlZSREFFdExENU90V2NuZ09pQjBl?=
 =?utf-8?B?T2VjZXFJWHk5QzlkQzMrM3dGY3gvWTRvKzViN3ZOdTZDaVVySHJ5ZC9HdktT?=
 =?utf-8?B?Tzl2R1dYQVJMSWhTQWtRNVVzTlYvUmcydU5QTDVGbEpLTm9VWUh3WVBYenJ2?=
 =?utf-8?B?M3c0Vkg2MEYzbGpIaG1Vd3pzVjkvZUNIK2MyMjNtUjJ1UGFGUVZIcW9IV2tH?=
 =?utf-8?B?NVhVcE5SZE9SdW9hTGZLSXdqbUhIQjJrT0lLRXVWYUZHR0RGRnJ6YVNkdlBo?=
 =?utf-8?B?WlBoS0hsR3FFdS8vd0ViZ1pOc1NIZzRENUVNLzVOc0tWRlRXamNCQ0ZKcnV5?=
 =?utf-8?B?cmttSWg3ekN6Wk42aTYxeUtCSU5WRG5GK1F0M0hNQVNNak1ySEk0VGxZR3M5?=
 =?utf-8?B?bEhrMHZEaTl3MUgzbUUwUlNxOUh6cEsvR2Z2NTZhRGFuR2VDOG1VZytDamF5?=
 =?utf-8?B?Smxscy9wb0orNWNjRjQ0RkxldzBabjRKWjBnT3ZCcGJaYUhFSGZpVlhCVk1N?=
 =?utf-8?B?bTdYZldXLzZ5WjliN0s1QTNMaG4rVVR3QXdXc09PTFhEdDRzOENYVXA3eHdh?=
 =?utf-8?B?Y2tzMkNRUzNkQXdQOFptblJET2pCUmxhaURvaHRianZDZE9Mc0dFNzBTYkYx?=
 =?utf-8?B?L2NURGFoclUxMEhMM0pnMjNob1RhYjAycW1IT0V6cFYrSmMzZmJIaHBHVm5B?=
 =?utf-8?B?ZGl0SW1iOVRpRUFUTEw0OVVqNHFycXB1dUtURE5UaEhsaENkeW5NQjNQMnZp?=
 =?utf-8?B?RElBRCtERldBR1lWdlA0OGRZTWxuZHBrKzV2ME9tdExJVGZ5ZU5OWjRPUk1z?=
 =?utf-8?B?ZnphWmlCZXhPYmYrSFArL3JjSzNwWkJOaVBTOEM4V1pSVUcxWUp1ZnJzMVI4?=
 =?utf-8?B?M3NiSGFlQlNibDdsSmtDaWVYRG9KMnV1UTdOQStvNy9vb2FHcXlmWFZ3YkZ5?=
 =?utf-8?B?UEs5Z01vUy81TWRaWEFWc0w3bkNmTUZTdDB2UVgrQkRRU0hKdXpiWEZOelNH?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dskE+G+8KfSrU3/UK+S3btn7ZZHziWsFrE64NZLRbiNfw/6yBvdxLR1G4rlM0qTNtCiEDaQS+roXR9vD6nQ5Qb7i9jutEb53JeFxTlbwWuDbZ3ioGjnGxRkPrpbEgyFgfvM9L2Rk0e/sMeDDNeCiO50jCvwjmSajGfy/CmtKw8cPmcjI4rE3N4WiQ/Sm9uFyRYG4hrwJefFq8doqlU+7N4ZS6mRye8jcwAOiS6N/CBCRJAm3OlcZpHQ0LNyaA/QDVxXOJLIQGuD2IFQdJCN8cj8raSN8WEBeEcTx4fhNljiPqJpRjHwikHvpT+7+bLlpCU6rqKGTXu1c6UDD7bOux9dGwOT0113WjS85Wu81BDFZ7mMTEM50U6OVYHFHWylezU/qSKUBqzZ0gh4EZEgQmRjQapsXq2100p9yD++u6ETaoJPNP9fg9GBc7b7AVuQXNikQSnVs1mRTyrPL65zeLiNB8m/qfxnhOPXmBu/BUCIuSSFxGBkD0ScxnrtsOYywvaRD+1oad36TifXT9W8jXbGyE6OB7HueuhJh8oT6UnXu+DlHIW/O9UCrT+H5MPRp/D0Iz6R12bL04F4/DgSql4Q9Mvg2S7aYXcUq08uJWak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a96ecc-0d42-4374-0bfc-08ddfb73047f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4356.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:02:37.4826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNwmh9y9jXhseTMYKkxaOhFI49CdJzQ7TZxyv2TvJwzvBctnbasszi6iyOCQ+vnk3pAAsNouhY7GmO4loiIXfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240120
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d3fa05 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zuLzuavZAAAA:8
 a=97OUshZBmmVjPC04SMkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eu5589kVmN5OODmzj9q9Pr1LomW58bpU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX3jCvZ/EwUbL9
 N6Ob0uOsE26s+lL23eFXAPPC+jwCLywtOl2vH56hLX3B1YuQyV123oglydVQXy65+2MdYcJKJu2
 3ZpMCoPrgsiACt+tQQu10JWyrunhFDLweHXkUztpNkQvm6As7mRAaP0yy1A9ignk76VRJDB7lac
 au2RFWNIbuMODt5851a+IRJT1NoL+m6H5g3N06W8kdg0KX/405m9PyIlPlJkitq2iRwWH5oHNki
 4NnK9CnuP+7qFC+I6cy+tC717rShY6PTjgkXZa8fEolq7HU+PUuwIaWj1PXreovz3N1Zui6zCM4
 vmVUhJWqG7Xmd60mtirsyRkj3oBmyzrh2dfGDfHSJfIhYlDcq3XO8Fz8LQuWLw9TN0IU/FCn6sP
 7rRxvjje
X-Proofpoint-GUID: eu5589kVmN5OODmzj9q9Pr1LomW58bpU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/23/25 9:51 AM, Li Zhaoxin wrote:
> Commit c255488d67 "virtio: add vhost support for virtio devices"
> added the get_vhost() function, but it did not include vhost-vdpa devices.
> Now we add it.
> 

Looks good to me!

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

> Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
> Signed-off-by: Miao Kezhan <miaokezhan@baidu.com>
> Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
> ---
>   hw/virtio/vdpa-dev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index d1da40afc8..4a7b970976 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -338,6 +338,12 @@ static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
>       return 0;
>   }
>   
> +static struct vhost_dev *vhost_vdpa_device_get_vhost(VirtIODevice *vdev)
> +{
> +    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
> +    return &s->dev;
> +}
> +
>   static const Property vhost_vdpa_device_properties[] = {
>       DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
>       DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
> @@ -369,6 +375,7 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
>       vdc->set_config = vhost_vdpa_device_set_config;
>       vdc->get_features = vhost_vdpa_device_get_features;
>       vdc->set_status = vhost_vdpa_device_set_status;
> +    vdc->get_vhost = vhost_vdpa_device_get_vhost;
>   }
>   
>   static void vhost_vdpa_device_instance_init(Object *obj)


