Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE714606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=MNiHqiLd;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=GL4tM6g7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULy6-0002SO-Le; Fri, 20 Nov 2026 05:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xULy4-0002SG-Ne
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:35:44 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xULy2-0000BM-6m
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:35:44 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7ecpR1280044; Fri, 20 Nov 2026 02:35:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AwjofFU0/EsJ78iZj+52RpU4IVmR5btRMETN7D12f
 Ow=; b=MNiHqiLdjcq9kjCk8afbi1vFU8Q2Ce5KGWX9Hlj2+qVdKHIhO50AIGNnp
 K2rsSe0OYuWyG7Drq1iYlTSbnhJ/RAqg8+eIAJnVVJV3Z8eRIAX+A2vevLojJiGv
 3HWzgHQ3jWowQ2VyfEsm0YC2clqAZq7O4uvYZNSvWDEC0BGHVyKRp4lfOytgJYQx
 iWJIGj6YmJvYeUFNZIJJ+t3Yy49GIk6lfMy1Fwn2PimaUNgMizTL3MU+8+HjC/og
 JPzjASuTPuWO66bMgR9r1pMppywoh8gzXxNO2pabCWcxlt7qNaJHfKzZdVdZoVvW
 Zc0pABlzg7i2Bx5oG+Ip60zt8rV4Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021140.outbound.protection.outlook.com [52.101.62.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4j1qsfv9c7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 02:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8TJff/7hix1dIPYst2u3YA5iC7AYFJDJbnX7z0YCtGEn7+84PwqK247GLtCzjDLwXwBd1AE8+2awwrQlqaSTFRy2NLHqM39+ZhiPRgaV9Ry4OtXLb7IHw903achHdPeckRN19s7wrNQef9Cw0JHknbG1AJEDcVbcDIYg/dFQvuq3SH4lvqZutPn+xI/NzQ7qvRSxCGYmLrqBeEsmJtUtLjA2SAVV0BriOVDYTwMZWvzsL56GHcLbc5G8ryDRpfnwX4+I4euxaQNn5oeR5nFMWwGxemVZvv7gwCDMqRJpa0v/NvJ42u1WEUxJOprFaV26LnDfND3uANxVpOT4oaspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwjofFU0/EsJ78iZj+52RpU4IVmR5btRMETN7D12fOw=;
 b=xJ+1k/RSZxmWq34jg/A2lF8DQpDXQFDTFIf6oOIpOR5Lspl/uwf6ud9cZa723+qGe2l/VN4Szu4YROijdBZiI6VvwlSyWwxy7+8jq/1EEQJg9oi+gcmA6i0qqz+ex8civ20v4CQAvVzKFnVytIVXt/KE6qzClE/swHXdkY8H/kwIb/5/kngTJkm/SNSDRGe5E19pQBU3IofkYB3dW3fPM9S8QGldUJzZR4aPTWqerQiXn9RiL1VNcG/VUwChIX3z7G83lSZuz6w/XH/Z9r9bXclGvducNyqGhEl9NPkx+gnqp8N3lma2AxFCX+bpMcyt2zc56K2b0l/H19ok7K9zUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwjofFU0/EsJ78iZj+52RpU4IVmR5btRMETN7D12fOw=;
 b=GL4tM6g7wC9ybIpts7H1rW217lFeT9fZsXLz4rIDi82uwqIiNCR975kCzknwmNhd9lf9u/mMyE2nQyGK1dQKUu3Qdr0BZLlRuScvz+uzkQyhxayi7gMRRxz3C9f39PoJOt8w63Lfl/cqeQVi6rorZAPOiPxCcc9JWDI8zTYT9by66h+RKFfgLvRnHQxG4wL6onBZNKQ9DeCBn/0hvc5Pv1L0QH/QPTMtV+zcOH5dmlgYu1zR7d2OTzT+WnPwGvlgZbAHemHMPei5uANB39o8JPSuIB9Gsa4L9qvpaTK0qXayy7wn4wJPND++azMZGpPkybX4CJjtr6LC6NDxJX84ZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10269.namprd02.prod.outlook.com (2603:10b6:8:1bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 10:34:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 10:34:58 +0000
Message-ID: <5a5ca2ba-5ae4-4cec-abfb-584e623b6600@nutanix.com>
Date: Fri, 20 Nov 2026 10:34:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: rust build dependency ?
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <f1471b2e-fcff-40a5-9bf8-077d3294cf6e@gmx.de>
 <09c45745-553b-4acf-bb76-6b36df221764@nutanix.com>
 <6431a291-a22e-45a4-b707-ba1daf6c0eb0@nutanix.com>
Content-Language: en-US
In-Reply-To: <6431a291-a22e-45a4-b707-ba1daf6c0eb0@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10269:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f1fe79-47da-496d-ee4b-08df46f1ec85
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|4143699003|56012099006|261009221227099003|261009223027099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JvMCVLDszFXg/KYFyl9spXO4HnjHLQ5XP1VxkKQK8SJTV2jFJkwI5z2ZSb16Nu6te7mRW3eb8UGkdjEmcW29/2Ro8oHUHEyWJjT5Dvri2IG8I3piwUV5pRJJcjhLBzZD2TXqrExdSLZ2gtraTnHXc6qV6/kVaEhRz7Eou8KqBN95BOHGEc94dCO2i4SnhronxE7qoZT/nO2Zm9GFuC/qZSzvL0eV79+ylBpOaEMVM0q1EwOqnfs2Ma+J0hnP4UaJOpWm+pONcuMajmc9A+f0adIl+2jQ8VxsBoiN/SB1jqAaV5l9Zu721YUl362zMvUaIgBXV72/sJzbjITBSyqZyq7QHETrrcFnHZvLfTyoKb7/kHsIv8P6Lz2Dn+O4naiti68zrW9edYAYN9OHMF9dajBp0tsWOa2cBkGfobxY7YqjRXCpBKJGrHQgJ9pWoSIemSKyN4cxBnigApcm6a55inaRuRFX5F70y1QnBRYB/qtuxrWYvn4n+5uXbxI0N0mFprkNdHpc9LViS3ME3UC+UPiJJ9eoSxxMEo4jjy0NISMUvB5UXr1s6uR/RSIaRyhW1uqnOiEcyBvyQikw0U8PmGaeX9wQrg7omwJ4KFqqtiyaQKy1LTBwrFtoMd0omqwXLzdOjMsFXdNXkcbxd7OURMH/tLIlN+etOtJtWwbV+sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(4143699003)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVk0RDVTcGlWcWtHWlRUWVp1bHhlTU1jd2JpK1I2V1ZIc2lOaWd5VzhCa1Vh?=
 =?utf-8?B?cC8ySDY1UWVNeW5ORUNXN1BUMllZdW9RNzA2dEpJTVVlQ3ZuNnUwSHFyTzhG?=
 =?utf-8?B?MXZ4OVl0aFkxdHdjSzE2VDlQT0xJdkxpb1hqZlhYSHN4WVRvcUJsV0V2UzRY?=
 =?utf-8?B?cXRpSlN6cjBNdW9RaE45cVI5K2tuMDFvUTNBZy9RMm1HL3FJZFBxK0JoTEZm?=
 =?utf-8?B?ZldTMmVNVU5MWlJRZ3Q1b3RvV3h1bVJvRXRkelFYYXVYdXVRL0lxQTU1RHBV?=
 =?utf-8?B?T1dVcWJUVGhTRWJpc2FpVVQ1UWVyMWNUMjgvRmFLelFBVmowcFdPZ2xZMXlv?=
 =?utf-8?B?OXJXT00xRkUvUi9tV0g4bUdJKzJubTJ3MHdSNWNvZkVlVnk5WU16SGoyR3J4?=
 =?utf-8?B?SHR2VW1mdkFuUWlQZEtUWFlLa3cvaGVtMHVsRG5NSkYxRFkwOStKdDNvVEdr?=
 =?utf-8?B?RGo0azh4VHVvdml6R1lHWTQ3NEoxcmdndzVmRUgxWGF4elpEZDluelBDeGpV?=
 =?utf-8?B?NitvbDAyMUczNFkwMTVLajA4d01RcUZMcmlIckRBNEJVL0lXVjh5MXdBanlM?=
 =?utf-8?B?d2xvOE1BRGtmVXFWelYrR0g0eVVSTlBFc0wvL3R1S2VHdnU1bm5nRjRqOE9H?=
 =?utf-8?B?ZzI4NktGanpMYW1XMjRySDU3MkVlcGlkZktLUHp2bXRMYlRWOThzMS9JU1p1?=
 =?utf-8?B?MUZPZWlXRlJIZHgvMjU5dGhrR2Y5K2FqWHJhWDJGODA3L2lvZVNJNFRBekZk?=
 =?utf-8?B?NGpNTmMzZXU1djdEQ1lQVGg1Mnh0ZC9PdDE0TmNjMFJzY0V3dHFxcUx2S3ll?=
 =?utf-8?B?cFNyemgxeGlPVTNoYkpoRHBmc051NkxwQWkybTR2ZnAxZVV1VEFVNVUzQjZa?=
 =?utf-8?B?anh5TW9wQzRBcEsxT3FpbkRVdGZLaFoxTkpqYnA4VmZqaUJFMXVRNWxlTUti?=
 =?utf-8?B?azNhQTBNTExUbE9Pdm9wNTY4aGtXd2JoaVFGb01kQlpJQ2RXaDlNY1gvK041?=
 =?utf-8?B?Z0ZOUUFVemk4S3VNMWJNTHFFNG16UldpOTBLQVRNYzZzbEtZQUtEd25HMkl5?=
 =?utf-8?B?S0N3VkZXcUZtekZjbTBzT25JdTRrK0Z2bWpWYVNhejlJcThpWm1DQlF1R3hz?=
 =?utf-8?B?ZVRwU1lHa1FycEdHYnE2WUxZNGMrbVQrY01EUjV1U2kybkxuUUZ2QTVZUjVu?=
 =?utf-8?B?eEl1NXhDTWN4aFNUZ3dYc1lyaU81anNiZS9SbUVteGkwTWEzRGVBeGJ2V05T?=
 =?utf-8?B?U1AzSWhFUVM4ZVNaSmh5RFljY245S2V2bDV6SEdQK3hHUUZldmVNUWRab3d2?=
 =?utf-8?B?MElJSjJUZjBPR3FpL0NCOVYyTHdJZkhrZnh1ejRRWjlOR2hwdTdlTW9LSkYy?=
 =?utf-8?B?MitVSUsvV3RyOUZIcEIrWmQybk4yRGUrZzJ6U2dGbi9UTTZHd0xHeXcrTTkx?=
 =?utf-8?B?YWxFWm14Vkl4L051VkdhMjJudjFOMUdOV2VnMUc1TTRHRHRzUUhtZ1RWU1RT?=
 =?utf-8?B?TFlFMVY2dmpaQmVhRytmSHozejhINlIrZTFxbjZETHVTSEwzZGlqamgwUjRW?=
 =?utf-8?B?alRHMzQzdmQrZlZlNzBWbk9uYysvSll3cmJnVnN5dWRIWEgvaWxpdGJCbSsz?=
 =?utf-8?B?MFRuRHdkSmJQdFZKTWlUbkVNZTBleksxOWdVdXJXVDlURDFJL2liWUVlQlZv?=
 =?utf-8?B?WmM5dFFxKzFrQWZ0RkZnaFEvQnhVakc1QkJVczUvWDRadkt1R2hDQVFaS0tj?=
 =?utf-8?B?Qkx2cEhYeWhWL2h2VmVtS28ydjZTWUtzTnJ6SFl2YzBvSHQyQUExb29icHN3?=
 =?utf-8?B?dUUveFpuWFVSUnhuaWJmNkVlbjk4b2F6elloamtLdXhwcTVWUktIaHJNSmVh?=
 =?utf-8?B?a2ZzdHliL2xuNExUdE5BVVcrSE9lTE9TQmROMTEzM2gwR3FVbWswWG9vWDJz?=
 =?utf-8?B?MzZKMEZRTXdxaXQzL3RVbm5iUnEyemxmb3dZejdkYXNYUGp4LzI5bW9hVVJB?=
 =?utf-8?B?RGtvU0VxVjNQaE5GMzZJNVBBa0FiVWpjOUVLRlV5ZkUvNzVjaDJndzlNUnJI?=
 =?utf-8?B?WkZOY1ZucGxtbzVHSmJQNmQydlJjLy9lU3MyT0NwNDI5alB1WG5Nc3UyL3NN?=
 =?utf-8?B?QTlqKytFdGpGZkdTVzNJV0NESytVanpsUXU1S3ZtTFFFWlRjR2pDUldPZThD?=
 =?utf-8?B?cURkSEJWWWU5TmNlMEowSlNGdU5uL0M1STZJNFo2Rm11Z2UySVkwWVNjcmt2?=
 =?utf-8?B?RmswYlEwUThkcHBDMXcrV2dMeEw1Ty9seTU3QmFiMzJEUHIvdFpRSjV6WUlC?=
 =?utf-8?B?a2tIeXVjK2NJR3AwYWlCS1FXWVU5dmgra2xwbkw1bFlBRElEQWxwa0FJUW9Y?=
 =?utf-8?Q?Oz94/m5GVvlSYqIA=3D?=
X-Exchange-RoutingPolicyChecked: Pa2jBNp8YpMpaH0HCybEmG6vcuoxEWX+w0k4P/OruxHeU55cF5pfumOVYzKKfRgSbyN14t233XjR/NB5DuOUfWEn+foPncT5KKUgDpTzktvKv2wUFn1FBO1fQEdbH5j0aG/AtNOHu+alN/uEuPjUwmVHuf5aGiBDTw8bZz3kJ1Telwlpd/Pi1hwwXTfJj3tWolfUns9nH8vgKG5vLWYdSNtZq5dXO8W4pridYOgHeRYmP0jhihRM9vtmIZNvYeEkkWW1Ay15+Yi1mkLbog9y9IFpbXcHDjkoz8vVqF26ghAFfE17vc3CYaIbM8L/o6ZCGyOLeY1KeUG0tsJvJ0AixA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f1fe79-47da-496d-ee4b-08df46f1ec85
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:34:58.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4FW8ru81EgDs+fvlmVAw4Mq0ZAQ+U+cOFM1Klinnp97M26HMZdHaC4u4gmy8AjMYbnTcYBtvMvOCeZAO1yA6nn/ilxLdLw0WJIEuJA1sjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10269
X-Proofpoint-ORIG-GUID: C7-d1-2Wwq6f9u1lRxsbh96ZeKTkATiJ
X-Proofpoint-GUID: C7-d1-2Wwq6f9u1lRxsbh96ZeKTkATiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX48oYp1fKi2fI
 LVZ6yZkUYyqfDemidDrhpT2rvBns7mdS00z+lstxFcTmM6m0CXSDIcrvOX6w5dyZPIZfT7heg9r
 9MpzGEtqHgZEWDs6EhqlSKRI1cKimnjeiluw7cLRrVF6nPS4NRBvLMykaU8LtuyDecq0GNBLvks
 hHaXVqrBZ8HkeTavFW8Yy9nevvfnfzjcheu5LYdlAtvb7xzNBVXw4KwUQMGeUup5ArFxwZ3RSoL
 7FU6zhq0+SsEn1bwdp5vQQsdkFILHewgoOfm1qY/ssecqyO1ikgLCvxVx4BDcjA0/LtP9tKXRTq
 iPSGLpqlPRWDttW/aDzKbk5oHDw5NwMXr/5b7ATjnsZ6oLH32pSckpc/8/E/oXN4GEkxD0hwoNR
 6s8hx+h6x5hbTHXflNntBSjeT6rNYb9PoUFaT9Ud1wPMXVTUqk3/Y9t9Qm+Ris4cCfi1CHeoISy
 XKhzDWeC4YYBNTERq6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfXwkENJCqfT7Vf
 /wuzBk7mSD1j8Y+l4BlNs3cS2srdjT0JbF19r0DK9GUoeu5umIbDuVMSUOijahuW6kGQ0RQaRBW
 h7FASNYjTaiZZtCq90NSE9r+NZX7rXc=
X-Authority-Analysis: v=2.4 cv=ItWL47/g c=1 sm=1 tr=0 ts=6b002278 cx=c_pps
 a=3OKKl51w8sN2have8IVhxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=cYpEwbB2vMfTBnFJdYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/2026 10:25, Mark Cave-Ayland wrote:

> On 20/11/2026 09:20, Mark Cave-Ayland wrote:
> 
> (added Paolo on CC)
> 
>> On 19/11/2026 22:25, Helge Deller wrote:
>>
>>> With git head, I'm suddenly facing a dependency on rust, which wasn't 
>>> the case before.
>>> Am I doing something wrong, or was it somehow just added? I'm on 
>>> Fedora 42.
>>>
>>> deller@p100:/home/cvs/qemu/qemu-build$ make
>>> /home/cvs/qemu/qemu-build/pyvenv/bin/meson introspect -- 
>>> buildoptions / home/cvs/qemu/qemu/meson.build | /home/cvs/qemu/qemu- 
>>> build/pyvenv/bin/ python3 -B \
>>>    scripts/meson-buildoptions.py > /home/cvs/qemu/qemu/scripts/meson- 
>>> buildoptions.sh.tmp && mv /home/cvs/qemu/qemu/scripts/meson- 
>>> buildoptions.sh.tmp /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh
>>> Failure in scripts/meson-buildoptions.py parsing stdin as json
>>>
>>> ../qemu/meson.build:96:12: ERROR: Unknown compiler(s): [['rustc']]
>>> The following exception(s) were encountered:
>>> Running `rustc --version` gave "[Errno 2] No such file or directory: 
>>> 'rustc'"
>>>
>>> make: *** [Makefile:134: /home/cvs/qemu/qemu/scripts/meson- 
>>> buildoptions.sh] Error 1
>>
>> I had exactly this yesterday, even after destroying my build directory 
>> and re-running configure/make.
>>
>> In the end to try and diagnose the issue I checked out a much older 
>> version of QEMU, attempted configure/make which worked but then 
>> aborted the build. I then checked master back out and it started 
>> working again...
> I can reproduce the same problem here again this morning on a Debian 13 
> VM (meson 1.7.0) as below:
> 
> # Switch back to earlier checkout
> rm -rf build/ && git checkout f71afb409a87c4ecd0f9d63a5963eb645dfab780 
> && ./configure --target-list=x86_64-softmmu && make
> 
> # Switch back to master
> rm -rf build/ && git checkout 08c9bbb825148dec9669f5184ecf18823bb6d631 
> && ./configure --target-list=x86_64-softmmu && make
> 
> # Keep trying to rebuild master (as many times as you like)
> ./configure --target-list=x86_64-softmmu && make
Temporary workaround here is to remove the direct reference to 
get_option('rust').disable_auto_if(not have_system) and hard-code 
"required" to false:

diff --git a/meson.build b/meson.build
index 4d267e10b5..3a8d5179ec 100644
--- a/meson.build
+++ b/meson.build
@@ -94,9 +94,9 @@ if host_os == 'darwin' and \
  endif

  have_rust = add_languages('rust', native: false,
-    required: get_option('rust').disable_auto_if(not have_system))
+    required: false)
  have_rust = have_rust and add_languages('rust', native: true,
-    required: get_option('rust').disable_auto_if(not have_system))
+    required: false)
  if have_rust
    rustc = meson.get_compiler('rust')
    if rustc.version().version_compare('<1.83.0')


ATB,

Mark.

