Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF89CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3eBA-00086Q-OT; Wed, 23 Oct 2024 12:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3eB9-000861-45
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:25:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3eB6-0006Vd-Pj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:25:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeVM011132;
 Wed, 23 Oct 2024 16:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=sNKbfqn/sawmneiC2XZ+X1+a2SwJm5WuqBdCpRo0/3M=; b=
 Y1PRxt4TQNkFwwFIzrCwLYGhXxS/vZK7Xl3qZm6oJzWI8j+TN7Hoi9qJMqNbIumi
 HwlfhE/76AeuJp0EfygZ2Jtv5iExQ2BFbwIH/dk4Cdg2FrZOKCNavcRaQ+2mYJGZ
 cbzdd4qTawwAW26ZP9xVLvwuFjQ9CKOfeRTfLAw9cYzLbMcnxBZXrI1pdyWSDFDG
 IJ7B0BJQRQ+kTHonRE1WgViqnZwBVM7hzeLR3ReYO6pWng+oETVBEzuWihqaYa/d
 5GKB3htFdckZ3OfREvxeA05cCst1Yj5oFCHt2oejTPOsaTTDM5mfXEPB36a0o1B8
 gYrm8rP2AA6vZQGiUK8Q3A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3fqeq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 16:25:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NGJ3mk035737; Wed, 23 Oct 2024 16:25:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh2rcsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 16:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3gTBNbPCndy/g0x94/4rwJiVLfi5Zku/eTHlM+1jLDqAV6UtpEy9lardU/ZhcfCaaM+DXHdeWF7BYuK+abw2fyeZHvJYdfhMwUuIq5B8E/V0QkgaMJ9pkXlZT4bnY59FKnkdo8hR3OHcmpWxfCgAvd/v3Nw53XkXZTM75Mz2DUzTnTsAekFC6SMJztpRE1nzZF9ZvBixXsFl6OsggAZO9QJPtYGgCxKR/yyRvo583Pa0lhKyVxskgGycksyp3tDlkluVnSZO39u3hlLvTQ2pjB97yDJVA476mIeCYFQW0zf26TpobWB7aooi3AyBvwZCG1vyIdwsB6Lj95NzwV3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNKbfqn/sawmneiC2XZ+X1+a2SwJm5WuqBdCpRo0/3M=;
 b=ITLBoWgqiFCIyr6b0m/XupMm2IwkUAKnL7RZlfc+BkIu4E4ekNY0IT9AsY3gGCsxlvdCwTZVzTo2e4zPLlKBEMMTh3gsQKk/0EgFhHRVQIaJ0l22gsIOq9WpjjVcQY8ZzIngOY9R76mAoQzlxl89fkiltnwB6iW15JiCNTzv2gx1743mxHfgpWBIuMPQT6HqQ33z4r45toI6S5xf4hzQiCoZS2r8h9R3ofgd4sr4Pj+HJ1JjJh6UwSUE+o7Edus9GBTtEEhVU7OebHEkJ9mDjZyPUrOQSE7fyU1waARhvER06lei57Uxli6m5ebo+UqQNnayRKgWO1zg0ttXon0xIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNKbfqn/sawmneiC2XZ+X1+a2SwJm5WuqBdCpRo0/3M=;
 b=kpwgFmRQnTW/Dgvk8uQeA0pjDwrcLUAsS3zDc93paLwIywKIp0bfnC/9EOV6qDmArCJKs63geGCkkD/ItKdN/V0fWhFP1geqfvNAPKKz0mQp8DCJElMqNdG7ECYB52oWyjU+l4eApp8uh9IOvJlbLEE9C2KYvh0EGe0Eoa5smpw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 16:25:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 16:25:35 +0000
Message-ID: <38e313d1-e567-4669-b15d-641cbff617cd@oracle.com>
Date: Wed, 23 Oct 2024 12:25:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 02/14] accel: accel preinit function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
 <82f35464-0f7c-4678-aa74-1865cf3d89dd@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <82f35464-0f7c-4678-aa74-1865cf3d89dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 5116bfe4-2dc1-413c-e05c-08dcf37f5275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2pLUzcxNGZVdDBtQlFmN3pEUUV0TGNCWlZ5MnNLcE02ZFJ0TkhHMkp1bk84?=
 =?utf-8?B?L3VlMVNSWmEydmVLbldiUXFHNXp4dUYvZGxPN1dvcmNWemNsWlNyTmRidzZ0?=
 =?utf-8?B?cUt2enJrTUFZa0FmcmRZN3FSMjJDUS9qeGtYVmtMVXROaEVTNUsxb3dqUU1k?=
 =?utf-8?B?VnZQYkRXYVdLcmRsWmFzU1JsdkZKZHY1dk5JU2Z1TXRrTzJQenlVODlZd0hn?=
 =?utf-8?B?RzBCZVFLZkhyYXgvbGI0TU5kM21aTFJvOVpFMlZDcFJNRWZCQ1h1b0YzMko5?=
 =?utf-8?B?QkVIak9CS3VxRExzZ3pQQ2NrQnAxckh4THFlemtQWk5QMkp0Y0cxRHFVcWVr?=
 =?utf-8?B?MmUyWm5KNUdtaTF4cXppcStOWnJWTjBueXNuNVdTOFVpVGFpSUl6VmFIVksw?=
 =?utf-8?B?VjZtcU9DZzZPbjVpTVVLb3g1RWZuR0JMRVdZWXNUampCRWpXejNpUG8xNDRD?=
 =?utf-8?B?K1hZU1cvMkcraTlJTzJaTU05Wjd0QTJOZEg4a1B2QlQzV3FLRXRrbFZzY09C?=
 =?utf-8?B?dGg2cFJpYWJ6alJUY0VGSDdsdkR6YzYwcGgxRExjbkdIeEczRjdRbGQ3Yit0?=
 =?utf-8?B?NVBoc3k4anZPVG1rMzV5R1VFRzZjdWRwaG9nRmF6ekRxUzlyZmtjRHFzNnR1?=
 =?utf-8?B?RDJFdy85dTgvNStMSjdMSzN1eER2RHdQbkRsUFU4V1pIRXM4dUxKNVlDN3F3?=
 =?utf-8?B?dzh0Z25Oby9aRklSN1VDNGZrbjhmZ3haTTl3eW9NN015dWt4ODMrU1c0TEhP?=
 =?utf-8?B?YUExaTlsWUI2cHRBWmlOM0ltU0JFdkJ4d0ZJRFE0R2tUVjVvMG0veTRWRmZx?=
 =?utf-8?B?OFFMN1QyelNILzhuMmdqWjErbCtDaTcwNEQ0UWx3M1RhZ2V6aDFUYzhlRWIr?=
 =?utf-8?B?YWVHQlg3STNkckpUcUpsWDFCZzdEQkRpa084ZGR4RTJtWnUzS2xLZTV1WU1G?=
 =?utf-8?B?TVdESXlXWjdJb3IrbzgydHNjS2VKd2xkcnhIZnMwUXFobmFvRXdlS3FDajdK?=
 =?utf-8?B?ZTJNVDRQck5EWEVKZ1lJbHJMbGQrVnp2Z1VtQkN0NWhCQmszK0Vialp4Y0Rm?=
 =?utf-8?B?dTRzYlpDLzBlR1ZucW5ZOWhOMTRxWDczTzJXTWt2RHhhcVBkQm1DNUVla3Vi?=
 =?utf-8?B?VG1sdnoyYkxPZkJ4a3ovbTJNOStBVFlkSDJDTWlhN3FUdmM1anJPOFQzZUpL?=
 =?utf-8?B?d1dhUHBzMTcxSTRlT1FRN2FqZE5MUWI0aFoveURDc1YrV3ltZVAyRDg1SUtp?=
 =?utf-8?B?WWdYdHNOOXNENExqWjdnZE56TTF1TTFSUjdjNEF4cWZtNzVKQlFxWW02UWFs?=
 =?utf-8?B?U3ZjRHFoU2VkU1pnVkFQL29vUzAvcUI5VDl6NXVVMVBZd0hpeWZJa2c3REsy?=
 =?utf-8?B?OVJqRVhxMUtPd3VMMkttbkg0WFBrMG1hc3ROTWt3aVpkNXdBdjZnRUhmZVds?=
 =?utf-8?B?all2bnRMZWlFWEF0Um1Jb04zcDZjbzRvU2pFanhLYkluL0RNdDl6ekZhRHNO?=
 =?utf-8?B?QWNEWnNldWdnN3F5QlY2K21YaWhLSVN4MnlkQ2FOZ0R4cjN0Z1RWZHBnRzND?=
 =?utf-8?B?UGNneGYxVmo1SWM0elRIUzZ3OVhPc2dIK2phL2xuZkgyUUlwdUI2dnEwdFM4?=
 =?utf-8?B?eUdmUXJ4UG4yQWhmb0hFcUg1cFdodldsSmdndGQrZmxPbFl4VlRoVEtONVZt?=
 =?utf-8?B?Q0FrVnZubmN3b1R1MUFLaVE0UXkySVkybUV2aGdwQWZXN0xrai90MjR1VDh2?=
 =?utf-8?Q?p0cVL1wHf7f5xwapkeOZAYpb7IXlZIQBkFXaupt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhtSVNXckpkNnVJQ2NWQktMQzFCMlM3WXZyWVRVU3JJY1dubEUvT0ZQbFhS?=
 =?utf-8?B?Z3ZWcEZETlFUNVlQTWdrMmczcXFGYUUwalhMWk9BdStBcnFXaFA3ZXEyTlV4?=
 =?utf-8?B?VWoxSDNadHJxZDJ0Mldja0h6ZjNJS3ZDdkJsSUxTVkhQVmE5WjAwbmZqcGF4?=
 =?utf-8?B?OUlHZm1DUWNmbmtJL3d1aTZSUXZ2Sis5RVBGL0JLVGdET0s4eWJKWHRsR2Er?=
 =?utf-8?B?YWhUYkcxUFZDelBPMGtsMmRBQUxpdDdBVFJWNVdtN21jSGY1YlI5RVY1dmE3?=
 =?utf-8?B?eUVCeDhLU1JLZURaMThXZE55eTNVVk9sLzU5aFBSZGUwUU8rN0tuYkNWSVBC?=
 =?utf-8?B?aFF0b1NzaWJ4d0NnS0lBamhYNlkzcmdwV0JjQW9ScUk2dHk3clhvRnIvSFd5?=
 =?utf-8?B?NnJxQ2s0OFBrcjNRUVZTcGx2SytFR1dlOVl5WEN6NFhpRVZsek5rRytibHJW?=
 =?utf-8?B?Z2tyUGoxVXh5ekR3QTJ4R05MOHZESElVZUt3ZVpyYnlwQmlrZzBRKytaYWpW?=
 =?utf-8?B?QUtvN2YrUWd5VEQwelBidmpiWGFRUXlXR3A0d2NFMDlOVnNtWEhlMmlDOG9Z?=
 =?utf-8?B?VFRtOEtJL1VLVW11ODlQSXhhb2FmbVhCbFM0dkVUa0pDUkNYd2duVUQ5SVFq?=
 =?utf-8?B?dGVONjF5WHp6eUFzd1N1NFBKYU1nNW4wcUMrdjFiUE01Zy9rNGtTNEYvRmda?=
 =?utf-8?B?U2xPS2x3UjNJdUhBbVZ5enFYTGovZ1VaZXhMUEErQmFTMXdXdjE5QUM4K3pD?=
 =?utf-8?B?ZElnZWQ0VHB5bHNNL3ErbHhqQ0FUVXJRNHZjVjAyei83RWkxOGxncTQ1OWlJ?=
 =?utf-8?B?MG0wcTdrSUdSZzlrU0p6czJPejh4WjVveXkzZ2tjcDFTQkcrOG84dGZaMTNu?=
 =?utf-8?B?OEJzVUt1NXZYc2hpMmxiQzBrVlNiTXVvNnBRYUNkc3pXK1hMQnRadTh2N24y?=
 =?utf-8?B?UVdNNWFHcDJaQTdVTkhqSmJYamlPN2s0aTU1Wkt2eXVyZ2Q3UjlHUUNVTVZ6?=
 =?utf-8?B?YjJCOCt2SGFFbkFvQ0JEUkxVOHczeGJCS0ZFZ2NHdE1mcTBKL1FKTU5tYjFW?=
 =?utf-8?B?STF6a2pnczNySDZONDl3QUlrdnAvSVpZSmFmVStjMmR2RU4rWmg3ZlhGc3F6?=
 =?utf-8?B?WTdxaUFrS1NxMHVPK3BpM2NjMGxRS0xIRklPODI3MGN0U3R4K2s5UUpIdWVX?=
 =?utf-8?B?b2pWSWhCTXdPTWpJK3NsWlBZa0IzY2k4amNidTJhcnZSeTZ6bDcrM3VPUkIy?=
 =?utf-8?B?N2FNMlhhQ1Z1QUtXRVdPZ09EcDg3aUJkWFdvYkdNMEN1S25vNnVzT3JMZ2pO?=
 =?utf-8?B?eVVJWktOMXJrNnZMUy8wR3dSMVVyL3Fac3hqL1IyYXdxQkU2ZFg2RGpZcVl5?=
 =?utf-8?B?R29VMGoxUWpkUzZTand2YnRzRzBMWVFZckdVU0RWYWVvSFVYeSt4czBZR2M2?=
 =?utf-8?B?emdtZU8zOWVLNExobUdRQXR0bS9tS09xczZRV1FDV0s4MHkxRVY0b1IraHVO?=
 =?utf-8?B?N3grVlRqNERoUFMzNktVVkRiNFJLKzBGUTNZSEZtQzROblIycVNaM0orS3NK?=
 =?utf-8?B?RmF6dnplNGRTa0dSd2RSNlk3VjhHR2Q1akhhSzlFZC80REtjY0NWQTd0R0Vw?=
 =?utf-8?B?M0Q2Vk1mb1NkM2hiNy9yT2ZtY0FiRjJVU2FRaFZKN2pKR3NMVlFWbjIrbWhh?=
 =?utf-8?B?NHl2bWkxR1VLeExPTFRuc1cvdCtxV2swYTV5a1Fxai8waytBeTBCV1FKN0h2?=
 =?utf-8?B?WENSTk9YWWxnWjVUZmY1SWtMVmJVNlNHOUpvRnkwamJxcU1sNkN4VEttTFdV?=
 =?utf-8?B?MmVKT3FkUVpObGJTTEljb3BHVVB2cUZTYXgwL20zb2xJSzlTZ0VKbG5kdHhx?=
 =?utf-8?B?eldMdllqRElhM0xmSk0xS2VrY2p1eXJsYkUvcTlXRmljSDdqV05yQ2NXejBL?=
 =?utf-8?B?d1hDUzJDMm95NGRmeUhlQmwxeU8vVzVuYUVTd1NqUVFUNjN1WFhwa0ZBNFZU?=
 =?utf-8?B?ZEw4QlRaOU90OEwvN1hYL01saXlFdVNGNVdQVUUvUmt0dGtRalA5YnNocmE1?=
 =?utf-8?B?enJaZ1Q4MlVGNUl3anlRcjVTUWowamg2VW0rZHB2dGxydFdpYncwMWR1QjA1?=
 =?utf-8?B?RFZmZ3pYNGord3gwSTArZ1dEYzlmL2pKSUxFKy8xdmpmdjlrRUEwTVpYRVZ4?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j67XyoNZACLbkgMCUabDqRfGpbeiZaHfze361msktcll5Kwyx43kVSjBHx0udp5EY2lQ5XTVCziti/KNuSn10oO5UyDPW6L9HvXGMwIabkHt1fN641DT7VapOeV+fsvJwgjdKDa+wZ9l4bqtce8HVcfjOIMC7xZNJ6Vj989P7UEZU0OayL0lVCC+2UkuHKvZIv7MFlsZoUbN2+Yy5pW7C6MNVS7xRjRay0+eDxfXbZ2ByeLzJOS/JA6RS5SlwffLiPidweApS89F93x31cRkO+bSTOF6oLi8fqivQVbIETy66iT3KOCi1e20yLkS3xR8nifTe/X8wmluP9cW5CE7mXKDOzzAeAvQb4LRmPipOwx94O+BqUPYWbcZ2u86UlpWOHnAainC3S6mcpmHyOkLvpRs/kycGIKvtWesKd1UU6HAXZzSyzRuIaXT2fl7Wopli15sbT7MhgdZLpq/cx8QhGhrUg0oWaamwZ+WznPUfkG22/J4n+UzEWKH/GEe+B5pL5GLhjUl52/KQ79dml8WHkmD+uyGWwAc1fOsxmlvF8+RmIuKp4m8sR4kXrZ/msLmyrDr3gKYyDzLgbMAtof14AnSnA28bovAbgnkyrnxcWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116bfe4-2dc1-413c-e05c-08dcf37f5275
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:25:35.0877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMZkz7lxIcRcyBUKCGxqCj574O57KokcSM61rQCmMTH+1pGz1gMhlaOipuvpNtJq8mMtSD6tKkM45RfhiBSRldBLbBJ6+p/FmgXw6uavgh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: 6LgE8ZqOeljyB0hdA1BaRHKkjahcjNpS
X-Proofpoint-GUID: 6LgE8ZqOeljyB0hdA1BaRHKkjahcjNpS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/23/2024 11:53 AM, Paolo Bonzini wrote:
> On 10/17/24 17:14, Steve Sistare wrote:
>> Extract the first part of the AccelState init_machine function into
>> a new function preinit, which can be called without knowing any
>> machine properties.  For now call preinit and init_machine at the
>> same place, so no functional change.
> 
> For KVM I would also include
> 
>      missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
>      if (!missing_cap) {
>          missing_cap =
>              kvm_check_extension_list(s, kvm_arch_required_capabilities);
>      }
> 
> With this change, patches 1-3 are okay as a separate submission.

Thanks, will do and will re-submit - steve

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   accel/accel-system.c        |  6 +++++
>>   accel/kvm/kvm-all.c         | 58 +++++++++++++++++++++++++++++----------------
>>   accel/xen/xen-all.c         | 11 ++++++---
>>   include/qemu/accel.h        |  1 +
>>   target/i386/nvmm/nvmm-all.c | 10 +++++++-
>>   target/i386/whpx/whpx-all.c | 14 +++++++----
>>   6 files changed, 70 insertions(+), 30 deletions(-)
>>
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index f6c947d..fef6625 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -36,8 +36,14 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>       int ret;
>>       ms->accelerator = accel;
>>       *(acc->allowed) = true;
>> +    ret = acc->preinit(accel);
>> +    if (ret < 0) {
>> +        goto fail;
>> +    }
>> +
>>       ret = acc->init_machine(ms);
>>       if (ret < 0) {
>> +fail:
>>           ms->accelerator = NULL;
>>           *(acc->allowed) = false;
>>           object_unref(OBJECT(accel));
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 905fb84..c7c6001 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2484,6 +2484,42 @@ static int kvm_setup_dirty_ring(KVMState *s)
>>       return 0;
>>   }
>> +static int kvm_preinit(AccelState *accel)
>> +{
>> +    int ret;
>> +    KVMState *s = KVM_STATE(accel);
>> +
>> +    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>> +    if (s->fd == -1) {
>> +        error_report("Could not access KVM kernel module: %m");
>> +        ret = -errno;
>> +        goto err;
>> +    }
>> +
>> +    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
>> +    if (ret < KVM_API_VERSION) {
>> +        if (ret >= 0) {
>> +            ret = -EINVAL;
>> +        }
>> +        fprintf(stderr, "kvm version too old\n");
>> +        goto err;
>> +    }
>> +
>> +    if (ret > KVM_API_VERSION) {
>> +        ret = -EINVAL;
>> +        error_report("kvm version not supported");
>> +        goto err;
>> +    }
>> +    return 0;
>> +
>> +err:
>> +    assert(ret < 0);
>> +    if (s->fd != -1) {
>> +        close(s->fd);
>> +    }
>> +    return ret;
>> +}
>> +
>>   static int kvm_init(MachineState *ms)
>>   {
>>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>> @@ -2523,27 +2559,6 @@ static int kvm_init(MachineState *ms)
>>       QTAILQ_INIT(&s->kvm_sw_breakpoints);
>>   #endif
>>       QLIST_INIT(&s->kvm_parked_vcpus);
>> -    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>> -    if (s->fd == -1) {
>> -        error_report("Could not access KVM kernel module: %m");
>> -        ret = -errno;
>> -        goto err;
>> -    }
>> -
>> -    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
>> -    if (ret < KVM_API_VERSION) {
>> -        if (ret >= 0) {
>> -            ret = -EINVAL;
>> -        }
>> -        error_report("kvm version too old");
>> -        goto err;
>> -    }
>> -
>> -    if (ret > KVM_API_VERSION) {
>> -        ret = -EINVAL;
>> -        error_report("kvm version not supported");
>> -        goto err;
>> -    }
>>       kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>>       kvm_guest_memfd_supported =
>> @@ -3891,6 +3906,7 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "KVM";
>> +    ac->preinit = kvm_preinit;
>>       ac->init_machine = kvm_init;
>>       ac->has_memory = kvm_accel_has_memory;
>>       ac->allowed = &kvm_allowed;
>> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
>> index 0bdefce..dfcb90c 100644
>> --- a/accel/xen/xen-all.c
>> +++ b/accel/xen/xen-all.c
>> @@ -75,10 +75,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>>       }
>>   }
>> -static int xen_init(MachineState *ms)
>> +static int xen_preinit(AccelState *accel)
>>   {
>> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> -
>>       xen_xc = xc_interface_open(0, 0, 0);
>>       if (xen_xc == NULL) {
>>           xen_pv_printf(NULL, 0, "can't open xen interface\n");
>> @@ -97,6 +95,12 @@ static int xen_init(MachineState *ms)
>>           xc_interface_close(xen_xc);
>>           return -1;
>>       }
>> +    return 0;
>> +}
>> +
>> +static int xen_init(MachineState *ms)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>>       /*
>>        * The XenStore write would fail when running restricted so don't attempt
>> @@ -125,6 +129,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
>>       };
>>       ac->name = "Xen";
>> +    ac->preinit = xen_preinit;
>>       ac->init_machine = xen_init;
>>       ac->setup_post = xen_setup_post;
>>       ac->allowed = &xen_allowed;
>> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
>> index 972a849..6b3b1cf 100644
>> --- a/include/qemu/accel.h
>> +++ b/include/qemu/accel.h
>> @@ -37,6 +37,7 @@ typedef struct AccelClass {
>>       /*< public >*/
>>       const char *name;
>> +    int (*preinit)(AccelState *accel);
>>       int (*init_machine)(MachineState *ms);
>>   #ifndef CONFIG_USER_ONLY
>>       void (*setup_post)(MachineState *ms, AccelState *accel);
>> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>> index 65768ac..ce858a0 100644
>> --- a/target/i386/nvmm/nvmm-all.c
>> +++ b/target/i386/nvmm/nvmm-all.c
>> @@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
>>   /* -------------------------------------------------------------------------- */
>>   static int
>> -nvmm_accel_init(MachineState *ms)
>> +nvmm_accel_preinit(MachineState *ms)
>>   {
>>       int ret, err;
>> @@ -1178,6 +1178,13 @@ nvmm_accel_init(MachineState *ms)
>>           error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_size);
>>           return -EPROGMISMATCH;
>>       }
>> +    return 0;
>> +}
>> +
>> +static int
>> +nvmm_accel_init(MachineState *ms)
>> +{
>> +    int ret, err;
>>       ret = nvmm_machine_create(&qemu_mach.mach);
>>       if (ret == -1) {
>> @@ -1204,6 +1211,7 @@ nvmm_accel_class_init(ObjectClass *oc, void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "NVMM";
>> +    ac->preinit = nvmm_accel_preinit;
>>       ac->init_machine = nvmm_accel_init;
>>       ac->allowed = &nvmm_allowed;
>>   }
>> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
>> index a6674a8..50bfc19 100644
>> --- a/target/i386/whpx/whpx-all.c
>> +++ b/target/i386/whpx/whpx-all.c
>> @@ -2516,6 +2516,14 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>>    * Partition support
>>    */
>> +static int whpx_accel_preinit(AccelState *accel)
>> +{
>> +    if (!init_whp_dispatch()) {
>> +        return -ENOSYS;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int whpx_accel_init(MachineState *ms)
>>   {
>>       struct whpx_state *whpx;
>> @@ -2529,11 +2537,6 @@ static int whpx_accel_init(MachineState *ms)
>>       whpx = &whpx_global;
>> -    if (!init_whp_dispatch()) {
>> -        ret = -ENOSYS;
>> -        goto error;
>> -    }
>> -
>>       whpx->mem_quota = ms->ram_size;
>>       hr = whp_dispatch.WHvGetCapability(
>> @@ -2713,6 +2716,7 @@ static void whpx_accel_class_init(ObjectClass *oc, void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "WHPX";
>> +    ac->preinit = whpx_accel_preinit;
>>       ac->init_machine = whpx_accel_init;
>>       ac->allowed = &whpx_allowed;
> 


