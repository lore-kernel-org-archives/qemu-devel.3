Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=FGLA+F9y;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=YgYNLmaj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBPH-000516-QH; Wed, 11 Nov 2026 11:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBPG-0004zw-GK
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:42:42 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBPD-0002k3-7J
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:42:41 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0hW93674831; Wed, 11 Nov 2026 08:42:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fOtuMvMfS00LNhRniGZgqPSgZl1kQoEUF/cHJAElx
 wo=; b=FGLA+F9y0jIM7/dI801ji1zVNvD3zzatONJ7fnQ70rafeeVUXOHt2pnl4
 q6skhFNfg0lOddm3G47rJ/ZTNmwSPCz+5C0jTdJkof9/rgk2YDSU+ARiiGl1edxA
 4VZj/I6shlf9/Z2h0Gw5pl4hn27jCMaQ57dPeGmDiA4N7ndHTjzL/NTN3+TxZg58
 7ZbmZmCSelQoBf9CVtZzCr+etUCVsBeMrxDTqxaCYeNPy+ZOMJkICXDKajRBwW7P
 JO78blFLQ/CtgBSF2PofzgQrXlBwfIMqBcB7TxV3uQhN3bmSg1hf2jRC6U4+dpLn
 6a4jcLWjM8+c+CAe7D6sFh7ZAt1Sw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020109.outbound.protection.outlook.com [52.101.61.109])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hvjvb1a9p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:42:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEQ1CoCSS/KrjehvX+Ilwt4Q2MVo8pcoW65nIG7oZMw3NnrKqWbFA28CxFtC9KWKbADwgomulPOP2tj+LIm8QCcOITPt3PCl6i6GCe5d+LD0kYQ92mTE5uubmgyR05XZKsbNUTJrQFkb8mQg6OIY7tWUWUNgXUUrpqPr6jgjp3PNRXf7uKefzRLuPVGQOIJhDGylOP+KNzCLycFNwd0Es6qn1ZO+pKnHvubpzBfhKRL8BbCTZnst+hGxr9r8b52qmHFvhneYf063bCdzigINbDOpAS40J4Gy6pzFBxFN9tCWAJR4Wut0YV3J11GHT4cUbEiIYien6m29q8SE+RokWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOtuMvMfS00LNhRniGZgqPSgZl1kQoEUF/cHJAElxwo=;
 b=X7FqaiurBv70+feuDbbiB56DmaeJ+XovW6NgJcE9g5pe1Ck7YNAdXwSsmSxWONP6TodgG1vgmRDltWlfMbR9u/b3TlQcsSyG7+xxuS4kly4TaHXvvdY4ILlb8pPv145PpdK8Ua/m/fT6nPB/xXjkzSFmFZWqD20RKslCQ09KkXv/VgjGtFqrO60QO9z3peRDUUqcT0VsBzXpWarwa3rqB/65/qf0zY6xKBdJcC26R3a1wyElx/tn+yCS+s7b3MZq7b/vUu3LleVu+f1fN+KVx7vDMH45PDFOqlMU91Xq+3XsURVCzQrUEiOmCkAy4YZj5Y2bF1qSwFMU0g6027fVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOtuMvMfS00LNhRniGZgqPSgZl1kQoEUF/cHJAElxwo=;
 b=YgYNLmaji1p0QnnMD9mMRDmyJseZ0MVDXUt1JzsWxeP3B7Q1YqqukL80xZnNX7hujG8KSnp6tkX2r12kUY8h7fGoHcbDw98NrcK/X/IN8a39RZjJ67U8z5WuUp9fD7q9Xfa5kqZZsAAaCgCogNvI6/+5U23w0z5WBYCM7a4bhGBv5t4Se/vd710TKMZndtO5QabymJTC8qB7RGHj4do2iguw5JDI0FSaIdhzG+nsj678eX/jaE57H2GbZ4eb4W/5i2zpo155vVIdfVhTtaZ1Qo1gf9APg30d4Z2ZBNqMbt2Zr1gaw4cYvpZHMGZQFYtyWp04Hcxcrj8ofxmgAahcrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8777.namprd02.prod.outlook.com (2603:10b6:510:f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:42:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:42:19 +0000
Message-ID: <f8ef681d-e3cc-4453-acbb-58f6133f2e36@nutanix.com>
Date: Wed, 11 Nov 2026 16:42:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] backends/hostmem: Drop redundant validation of
 property "size"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-2-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: a675c9b7-2bc2-4b77-1344-08df4012c0ad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|261009223027099003|56012099006|4143699003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: GcTnFN+gGkYQYOpvrKm0TZ2fUu2br9zaRe/omQfCvhmDqeaRbBf8w8oRNsiYsuCdhiqFcVfLudwPlFSoJlK/OW2qC3VCB33pvnMlkOveS7wn9LHpYDBs5pRIeZrfjAIYGKNSh3bHPAuWNLclaIQq7a8Fob87COZjLL8zX6WpaMKD6w4Hk8klQL+IHbdttlMvK84hLyRl/OtYYeE332UCZ33jmvoeVOnUCTwXv8kSFYu17spHRETagK69p8zRTQlUJ40wNaS2WbdQPZH+vhEze1vt5To6dScfD9gq2RQ+c41dcAajzuZlDB4zw+kywGOfn9dCe/So9jgsaXUaCFhXLtj9Dc8B61/tqJwacbbHCjVDpCaGHiuIXgRnu3GYeac8G90sPk79Mxz9XhYYIEyWww6CSXSf0Mz4mn0b6mAkW1tMXi0DMOJ/LZgiyOgngKJX6Wu4SAVUBgUnNFVXP6wiO3RUZHQPHogHN5kLqAQVMF0UhXE8FPPHJCWg5Zvv/ZmO+3KUGvttQ3DAquzGSXoYSStBpA5B2lzcOe/EnCR/yEARvDdF41FJWE7S1lgzhrtVZ2IudGTjChmPszJHo2WowFNsBdXQlmYbnrJGN9qEJepIPRWoETFJ8PE85n8GO2gwCbMlNEHEE8VKHOl0P9geIZvkUWHJ9NS4MRErrwjF6vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFAxYXRWU25yRVdZTWVhaS92MldJc3dPWk1obEZXRlVhaTRCQVh6cGFZeVlz?=
 =?utf-8?B?amt4YWljRmtnbmkyL3NxbUg3TGVBbk1qUXJRL0RpQmpFTVNHRlBPSWxJSDJM?=
 =?utf-8?B?QXh5WmtRYXMvRDExNEc2UDZPY0pXd0p5QW9iY29MbFhTeDVTTDdzVi9NSllT?=
 =?utf-8?B?KzV2U25qYUZuMVZMcGU3V29VclpUSlBPV1VONkxnbjVUakkvRGRRSDlYK3dD?=
 =?utf-8?B?RU5MMWhiZ3dJN0NyYllQc2RxZnJoUjN6Z1V4RVpPaFRDOW1Ka3lCdGZPYW9V?=
 =?utf-8?B?SnVuKzRUN3pXaktEM1hiWmV3cGcrckl6eGg4eUVyMmtLLzRmSElHWTFBYXhK?=
 =?utf-8?B?Wm81VFNyQlJyaGt1Umk0NkRDc3NxOE9VaU5WLzlvd2kvQWxWbDNJRDlXL1Jl?=
 =?utf-8?B?bGpHdXFHSGlwcmZ3U3djbWx0aWUrL1VLM2d6dnY3NDh1N3lRVmZCVnpDQVVh?=
 =?utf-8?B?bDFna0V5RlFEOVRsUVZuQWxYYUhJQU5IL1J2MU9ScnhQcDZ1eGZiV05DU05k?=
 =?utf-8?B?WU5wYmlHSFpzcWRRMmF3YW55SlVSRU9UQUJ2WFdFL1cza2RnRnRaOENMWHlP?=
 =?utf-8?B?MjNNYUNGSUhvVWZJMXdDa2VwZmNXbGYrMUZwbzRscUpsMW9oaERzc1RLM2xG?=
 =?utf-8?B?dDQrWWRmSndGZTB2SGdYUXo3MDR0UldkMnpuc0xVcm1XRm9lU1g2cUVwTjJS?=
 =?utf-8?B?bFl1Z0JzZlBJTWxQMFl6eUhOVUlzY1h2dENudFBvNU14QkNlMUNIWWkrY3Vs?=
 =?utf-8?B?WUt1WG1sbDhHZU9WTFhSSjd0VG5JckREb3N5cjhHbm9jWmVoU01hVFNoQXVJ?=
 =?utf-8?B?aWtYemZmMGM0a2IwbGxoOXhrQXZRemtoYzVMdUhxSjdtSGJnVUJZV2JDMDYv?=
 =?utf-8?B?c04wV1BiT3FrUHNyTUFwMWRTMkVMSlB3OG51L1hjaXA3cFUvam0ySXRKSDZM?=
 =?utf-8?B?Y2FlblF4VkYxTkJQdU9WMFNSTDZ2WnpFdHFuNjhDL05jZXc4dUhVYU9VWm9y?=
 =?utf-8?B?SXdoVXczcWFvWHVJNU12NUJnQzgwb3JtOWxpdTdRcHRQbFdWS0hnaThDL2Vw?=
 =?utf-8?B?cnpHRHc4N0hsOG1sZFJUT2hocGJrYmxVeGFXWFpUWFcxaHJIZU43Y0gvMndU?=
 =?utf-8?B?YStVMS9kNjRCb0Jid1l5cGdPMUNDT0ZmWFE1V1RNYlNXWFQ3NjRWRVVzazk0?=
 =?utf-8?B?Y0JlVm1abTN5RzdKZUxGejd5TC9HWklXUG5nRlBJdXFJRk81U0FVZkV1UjU1?=
 =?utf-8?B?K0krL28vandYMnZOZHZIN0FyUGxQSVE2RWNhU0VhRCthSHcvSDB4L0swaGVy?=
 =?utf-8?B?QitHT1F0R1NqSWJIamVJV2FvUVVaWHFQMlRBWkdiczErNXJhenZCTXI2cDRp?=
 =?utf-8?B?RHdOR2dnUzlXVkVtLy9lWThXQ1BoTHF0Tm9hY1JkaGkzT1M3ZWM0b3J3WEE0?=
 =?utf-8?B?U2JUcUM0TkpaZDlQbTlMV0poVTZQTW1pWVUzZXJieWxGQkVsdkp0a1dLMDhD?=
 =?utf-8?B?YlFXMEdEajI2VC95UlpTWFFZYS9za24xdG5na1VVZHZyMVR5dXZnMUZrbytN?=
 =?utf-8?B?OGVIY3V2TUcxeWdEd29NR0FHRWR2MjB6TEFZS21yblFwZUNLS292SkdJV1Jq?=
 =?utf-8?B?VjZpV1ZFazZWS250ck80UktlVFJqb2VxcDAxbkVrRTJxcEEvcU56cyt6dmRk?=
 =?utf-8?B?aFhMNmIxbzh4V1dQRTA2UVNkRTRoWVBYMisxR2FmbHV6YWhHaGxTVHFBNWgw?=
 =?utf-8?B?M21WMW80YkU4UGlkZEpDWFZVRHNsSGNUckxTSkVyVWx1SnF6cnJMRUJMTEhU?=
 =?utf-8?B?OXQ4d0VrY0VOdGU3RlJTVkpFUmhnVTVZcTRiNUFrU2ZpTW4rK3VYa2hVMkdB?=
 =?utf-8?B?OS9LVTQ3N0k0YWhLS01lSTFRRXpEQUEwcWh5aFovaWZ3ei82RENNUVd0TW8y?=
 =?utf-8?B?NEpGWjJhSnRSV0lsV20vTlFGWitlTHU4ODNZem5INkJlMnI3RU54TjF4VTVB?=
 =?utf-8?B?RWtLaE16WjN0NUJoemh2cGRoUEhhUHJ5WTBINmdvcUdaeGJ6VXRFWEtGcHNZ?=
 =?utf-8?B?UzliaUlyS3JSYXFhUE9LTHVBUHpCazh4cGRnajg1RkpFKzZodTk0K3FLU2hY?=
 =?utf-8?B?Y2Exby82aVlzSklDTzFWKzZubnRBeFk1WURHNEVQVEVWMmZLcmJNZXk5UHlE?=
 =?utf-8?B?YkpVRGp0NFpOaTFLc016dGhMNmF6bS9TQ0xsTFZCdmVMSkd0TElhR3g5OTMz?=
 =?utf-8?B?b3hWRk52MDdqWElOWk1vaU1MdFVqRVBudWEvR1N0MEFSNWplRmF5QnI1MkN2?=
 =?utf-8?B?bjJWLzJQbFZmOFpIZXNlSGtpOXNrQTdSSUo4VnVCNC9NTXVCTGROMUp4bUNM?=
 =?utf-8?Q?k/UNTu1UWl2uZUFo=3D?=
X-Exchange-RoutingPolicyChecked: i9tcvgRVFAdLPZeeUZHytILGUTo3eWkkGVX5ZTmHa5AGhFiczmiJiW35ap1kgWGn2uBZL+qQN7YO9C4NhMPyfDF0vLJtVNygFK3Lm+MqpJwYc5Lvbn8WYn63t6VGJybYM0F7hZFgXEMlNZkipbHfkV0oYjKkEQEw1zbCWr6bPpkGepL9ijxwh6gvc6vi4oV8Qx5jdW/qO5fe8zmguOFtqoc1azIFMd6lZxr975XqN9gxN31n4fqkt+KG9o/WCFYWRabHyRBR/BMFddl1u3YwoLHh31wiGA9ssv3GKjcIfwAt4jgzqG5OQ+0rzk2U4bcx/2D64AY2Ya5Nk0vW9QqweA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a675c9b7-2bc2-4b77-1344-08df4012c0ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:42:19.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +itqOizqGeq/6Nj8Ahkz8skmxwNWp+VJmwtFNkdmybleuspo/ggnCQ8YI8tkLXEYfRkL9LXJb9If2ECRHlCpmVOGH2XAzanisyNH6LLS7ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8777
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6af49af2 cx=c_pps
 a=qWtZlk1y+0YHnbN0PxcX1g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=qkatBv_J1rNLDSLE5nkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wQ9rgpMW5ZHj3CEvEI_WnfdvDESqAXne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX+oeC0GNeKaM4
 8EPQsuKkxQd+ISN8mRZajLP6VGjvHK9d3Yc1ErkXsZHomdY2NBMiFY/D8CsKukZNnRO1UADoUaC
 owu5HvieFjNaTmdnJf5KrpkkmrKhVV/118LrYsRLNIeDvlIFk/ozTbSMs0Ihgci0LT41gWWdYoM
 dGg5UMB1Zz9ckW/F2kW+pZDHk5Mi81hRMp2z4uXR+SZkfsiubdY2evCPO9NgeOAjy/uf41XG3HS
 ro1qqfscbDbAM+rQzuEkXREhvzqQfkW3pVsvt848xi4JjZ7D6RMzOGvdkVbQTay9o/1QutPzfJp
 tTOzS3gOFsoOx8YJVeLmn6EEtNcUcSvoXCzZWONzxNlRAV3ilZf4sic0CIL/Dg42MuNSZguNob+
 17BxNgIaHbMWY2yml0X02alFzu0ffrSAoG+nPUi169Qeeu4Ols/1NpguRe00Frwyj2rsqMXL80T
 297IHX1MO6NQApTJelw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX9U1skNGC1ZQQ
 Oirnc9yZWQrSWtiyPzG6TNYx7rXJ5DN+xALNbQdtsbx7uz3YjjafVyM0x0fszhDnBs8wStYYo8K
 lKTCo7g5QisCCcn2X9HnvJC507+l6/8=
X-Proofpoint-ORIG-GUID: wQ9rgpMW5ZHj3CEvEI_WnfdvDESqAXne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:23, Markus Armbruster wrote:

> Property "size" is mandatory, and its setter
> host_memory_backend_set_size() rejects value zero.  Delete the
> redundant checks for zero in the .alloc() callbacks.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/hostmem-epc.c   | 5 -----
>   backends/hostmem-file.c  | 4 ----
>   backends/hostmem-memfd.c | 5 -----
>   backends/hostmem-ram.c   | 5 -----
>   backends/hostmem-shm.c   | 5 -----
>   5 files changed, 24 deletions(-)
> 
> diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
> index ab20b182331..e1c784249ff 100644
> --- a/backends/hostmem-epc.c
> +++ b/backends/hostmem-epc.c
> @@ -24,11 +24,6 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       uint32_t ram_flags;
>       int fd;
>   
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
> -
>       fd = qemu_open("/dev/sgx_vepc", O_RDWR, errp);
>       if (fd < 0) {
>           return false;
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 6ad9cad0320..08d0382d76f 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -48,10 +48,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       g_autofree gchar *name = NULL;
>       uint32_t ram_flags;
>   
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
>       if (!fb->mem_path) {
>           error_setg(errp, "mem-path property not set");
>           return false;
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 46489212a23..11d456e3ebd 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -49,11 +49,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       int fd = cpr_find_fd(name, 0);
>       uint32_t ram_flags;
>   
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
> -
>       if (fd >= 0) {
>           goto have_fd;
>       }
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 6a507fad77c..0ae7b4ae759 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -22,11 +22,6 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       g_autofree char *name = NULL;
>       uint32_t ram_flags;
>   
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
> -
>       name = host_memory_backend_get_name(backend);
>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index adf60957c3c..0a01c760551 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -30,11 +30,6 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       uint32_t ram_flags;
>       int fd = cpr_find_fd(backend_name, 0);
>   
> -    if (!backend->size) {
> -        error_setg(errp, "can't create shm backend with size 0");
> -        return false;
> -    }
> -
>       if (!backend->share) {
>           error_setg(errp, "can't create shm backend with `share=off`");
>           return false;

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


