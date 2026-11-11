Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E2606A887
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=PQYOLQHR;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=t7cyknxT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBWF-0002QO-QH; Wed, 11 Nov 2026 11:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBW6-0002MA-JF
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:49:47 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBW3-0003LV-L5
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:49:46 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0ifU3674838; Wed, 11 Nov 2026 08:49:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=elvpQFjqsKzEaJ82jBOy+nHTpBrR460aVcuAJQhIZ
 V8=; b=PQYOLQHRuWwnUxNJ5FRPLf2lb78niiIrL7tGEN3x6Tg+vm3qhyWkapGAm
 v1fFfAbTDYuSEt0cE/+50868CY48A8HbYb4i5o/c9jPRod10GZ3HRZD/B5D4z1QK
 HPy50XBt+oFBWvPEhPcbegKWzRV/MmAAgsmecie6To8wAPg7qIpcMOCeP4VRIZq4
 a7tVqVXMU+Co1v81V2RrR08hd6WlTAaA8MiZGCK1TSPYtIbyedKAtXGjNTkV3fCR
 1kGaHqNwV8c0ZqEG5WZBe12xPNn9cyJSJSHwKKfvfKUhqR1hsZyfV2nxuw8bk0rT
 1UXKdsJnIWUnmDXwRTnpK+mckzHjw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hvjvb1b08-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJIeBXm1zoTIkLVtldHc23VIB3N6IR3lpsyZIuXNWDXYpKF4pjENHjyMaMF/8rb2d7ue8RS2psd9lFXdoYS49D/U3vjCTnkpFj8h4RxSoWDvyLCjSdBZXkp0xgNlcX9zx3MaWK658HdSt75Y72ztdHEV2vXVCZF6mS5Fh2E23+D2PqDXlrvkeN1FGTRYqGoZNbqEJ6pdvX8iBKCK/0LaRoZYvgPtJOrEO9XPBnRoyu+u/+jfAz1bwR4AMfyy64JuqE1QdONMhk2MBnHfIBEae14/xq2EIHm1+7BRP10XS5GgE8Ps/x3b7afZj8s0JUpPpe35yHLljeiJqlmKQ2nYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elvpQFjqsKzEaJ82jBOy+nHTpBrR460aVcuAJQhIZV8=;
 b=rUduNyK6o+8smJpoHICgr4UpPkky3oSIp2bS2/rYO+eE/d97rGXz9NcYIbBWuK1la7r+LiWAXcY3Dtn3aKUMD728OhxuDCKBHyWQY/cudw6xlw5tENEvaMqqU/mjZ/gE4U+vN98e7C6fVhLNr62S9Zmpq57HJO8mSbuhGH4J6IsHpPuWNfTT8mDYjZXW4FmKyd8WHdDZAJh2pxjT8X/fTct1ss51+qTFrH38vuyJrcIPcX6anJYT/P9KijpRsxyhUYUUjJn/3jQG+bXQqch+CGGVQxwqbAVc6QkzXpQgqv+0YsyNakljF4sRdFrlTuUa1ufQsg8Q9X+iF9dsh9YQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elvpQFjqsKzEaJ82jBOy+nHTpBrR460aVcuAJQhIZV8=;
 b=t7cyknxTAHR6knIRymZZjXLeb3D1lGPa/nOA5lItt+ITYlSb8CwZXB7LCDGG7TUIQdkqLQSItzixa/aXZULIUizLWNiCrOt5x8wlrjKh+apOpZ74JnjcSocnziq6k7mOGNT7hd0cCVJ9QS8tls7QEdWCEE17hFSkQe2F94rDCvlZ9nA8FQzhIcKR30QfLRugpw4TsmJ3UhrMZ8cR71cZZfumEoNwMUpCB4Z48tiKFjMN3XHN7PDLpTOOi7AvXG130XgwMTnOd581Xr8ByYMJC6pWBKYGAECaumxEKr7EEZIejP1r6Vnm7ywv0BXxNZ8EezXiCvYLi8dQCDzRgBU3Xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSSPR02MB11372.namprd02.prod.outlook.com (2603:10b6:8:374::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:49:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:49:35 +0000
Message-ID: <35e76d6f-b4e5-467a-bbd4-d701803ec028@nutanix.com>
Date: Wed, 11 Nov 2026 16:49:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] backends/hostmem: Improve error reporting when method
 alloc() fails
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-4-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSSPR02MB11372:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de29ec4-c736-4d6e-51d5-08df4013c463
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nW/pt4Zc7YP7aQSbUsC14cT4OwZnsJiho6P8r5lR9ByN0xBddwvurfbpeTO90X5xf/15dHQHL+f0KOtaV7tq8Qa52yrNEyIUIUV6zpBhF3EqW4l8/MVmXrxKXSJA7kwWugQ1hYojI1L0FMZxExZ2e8M5AiiDyRNjxhXPKQKJUQGKBRhryTzOkCM/fEmyfx+n88UAER44XvzRL8+X/R0q54k3SkMm+UcPyM66/l1P5ucYjcRpB49o1R8ieQpgVoQQlfYdjZKOwh0OUy6NOLO+PamaqZ3qz5SHgva72ppdWEeU2ZVnaKgH4dYwTKa5nxt7BnTDtyft6gW0la6sfxP9zKYlC4dpeeUflfvCWjItflMsDnaYApCadxw5/c0hnieGiAlry5a27ugvI+gerl0sZfboywUfC2gmzmPz35mMNGviXnSYJGLHhaQMrYo5y5r2MPml5r2cxmxSw2B6GKdP6JjtkJxoS/7ocZU4FWdxtdSqTM9MpNXNbHyg1DbIdqgaBKpcN6kMBEbtONfCj4upI0E7utkGAaXQF6P0Pzsl+2JgF+XvZ8qt4H2UuKaiOspQvph2z6TmFjNdsp5A0DHJYEUw9FgwDvybBAIzezjc8wXbEL64A42IRirFCErKNPFdk0qnmjHOx4h4o2mfnejikMBnSSFmZCsXGtglbS1QA30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJha2hydlZ4WFdFZGlsTlFFbnR2Yi9hZTNHcjRBcWhEQ3ZnT0dIRUljQWhI?=
 =?utf-8?B?bFloTHZ6UmhsMHFBSTFXOE9wOUQ5OEJCd2xlSGNDUUljZ2orZ2ZpUjQ0ZUp4?=
 =?utf-8?B?RHU0U1MrSGxScXBZUUhvaEFNVzNXS2hFVXpmUFFGN205SExWeVYyb09YVGg4?=
 =?utf-8?B?VDBaUW9hSm9FY3RJa3pJTXNsNEZRZ05YZnZDT083czNTRlc3aTBseHhBR283?=
 =?utf-8?B?UVcwaFhOb09MK1Y3Rks4alJ5djZCQlVlaFR4ZzZsZ0haVG5KaWxlQ04xNDhN?=
 =?utf-8?B?NU81YkRmVzhyMGw5VzZIbXhQb1lJTFFIVExlZXBMbnlxSVZBNXlDRXBDVWhk?=
 =?utf-8?B?WmNTcFBrenowSnUrVWFKQmc0T2tubFl5ZmdxSHIxaTdjZFI4TlZVTHQrajZY?=
 =?utf-8?B?QWVSdlVMV01sNDg5czB4TmNKRlM3MlhTVVFGOERhSHl2VE5qSHp2ZCs5QXpr?=
 =?utf-8?B?THQwaG16SVZzQmVXa3RhcVNRYjlmZzdnRWo1OVdaRmpxMkYxdHNNQTRNSXhS?=
 =?utf-8?B?ZWJ3Z0l0UUhlQXN4TThUNDlnWnVwOGpxMEdDVDVyU1VycFpvcWxoTUlkUllY?=
 =?utf-8?B?NDhuZ3kyc2hsT0pRbFRpZkR2WVA2ZXBSWkc4bERiQy8zNjRZSS8yMWo3dGlh?=
 =?utf-8?B?ZjhENnZhSGlwN3dabVJwODZIVlR6WHhIU0h0ekNQODM5REdNdFhUUXc2Wk1U?=
 =?utf-8?B?UVU4MGpFdStTWUVqT2hFSll1Z2lBT2R0RVN0bG9RV2J5c3k5SmZhVkhnNWg1?=
 =?utf-8?B?QTgzdkJ4SENIZCs5VjBRbkpWbldnQWVGbXhsd0ZmK2wxVGNLV29nVnRvSi9n?=
 =?utf-8?B?d2I2a3VzcDBkYWg1SDd1WXlDMjRoYXdyS2poZkI1S1QvTVhua1VVWFUyM1ZW?=
 =?utf-8?B?c3pGeHFObCt2dStsQndmbkdMaS90TkxMNlJVc3hRcm5LL0YrYmhBQy95ODZ0?=
 =?utf-8?B?Zk9UalNJZjZNV0RzRGZVSU5uMDdVMXdaRVFEbldQZzhLNS9neUcrNzJlSGtX?=
 =?utf-8?B?b2lxYmo2c3BjeEdMTEQwQW5INCtFNURpRWlhYURQODRVb1pKbEZVOFJzTTkw?=
 =?utf-8?B?LzRxRWJhVEY4TFJ5SHVzaXpMd294b0VJalA4eHpwQ2N2cHVFVWliUlh5R0lL?=
 =?utf-8?B?M25EVjMvOUdMMjlGMDZQc2llVnFBRnVCdXNyWGp3ZHBvN1hZWE5Tclc4ak9K?=
 =?utf-8?B?Uzh2Vldoc0lwd1dDd1hpRkNCSVFzTkg4RlpvRTJ1bU4yWlFST3pKUmpmMmQw?=
 =?utf-8?B?MWRhYXFNWHgyVGM2UEJYcW9IMWtscXZEMUJKRUFZaERMaHlyMHZIMUZnNnN2?=
 =?utf-8?B?Z3J1M0ovTUFXY0xnQ1Btd2NVWTlpZFkvOWNuOW9qWTlERlI1SE44aktmak5v?=
 =?utf-8?B?VlBuWXNNYlh5N0pxa3hjK3g3Q3RHcENEczM4RHZMUldFYVE1SlAwSkxpOFFX?=
 =?utf-8?B?NEpCQ2xQd3Rac1FUZHhpUk5rYmdad0pkKzVla0VqRjFkY2ZxS1pnR29LeStG?=
 =?utf-8?B?dkdlcXVXVG15M21VZDY4d2RwdDJUSVp0MGFjK1pXczU4VEltb25HK3FSL3pM?=
 =?utf-8?B?THM2bkZteEZ2ZVFmYk1lTm8vQ1JIYjl1K3RhSGcvMTlEMHZqQU0vTnFpRUt6?=
 =?utf-8?B?ZzhTNjF0dUdmSXhmZVdoLy9lODhVRFhlNEZaTFcxWmU2M1FsVWlCRHJUMXZi?=
 =?utf-8?B?ckNhNHBmUE9PMGU1RnMxN01iVndCTWQweVlVN2k5b2s5Q1R6TnhaRXNOelAr?=
 =?utf-8?B?eksyUlk4KzJpL045bjJFcFR4MEJTbkZ5bkoyM0VsQlF6T2RaTlFCU2lJa1dF?=
 =?utf-8?B?QVpHUlYvTS9CT0dsYllyem5RN1crQ3RiOFBrRHoxZGw2bjF1b1BZMFFKdzJy?=
 =?utf-8?B?aUNaQTI1ZDFmMWh5TkFheG51TGFMK0RLRnQ4Q1VkdVF3VWhWVHJKZU9xbVJt?=
 =?utf-8?B?ZlhXazFaY2JzcG1tZTZMY0lIT1plbS9VYyswakJKOFhZOVFnekp0YTRSbG00?=
 =?utf-8?B?SUx6b1VuNy9HTEw5WlByQ2E3bGozb1MwZ2lyUWtEU1BuZG9QWEs1THFEcWg3?=
 =?utf-8?B?VzlqbTRxbHAvbWYvU3FjanNtcTU3SlQ4WUZ6clVIcmJoK2lGNEFraDVhZDli?=
 =?utf-8?B?Yk1ZY3VweG5nQmtSU0RJWkNjSzUwclhvTy9ncHhxdXQvTHYrREtDY2R2eDJV?=
 =?utf-8?B?dUE0dUpFa1k1eU5ENDJpOG4rbTdWZW5Oa0czaXU0TzRKd2VrOExIVE00RStW?=
 =?utf-8?B?dmYxdXdBWmZRT2QvY2dFMEdPVDBjOEhyNmVGZDBJQjMxaHpDdTNZenpRWlBh?=
 =?utf-8?B?MTA5djM0Q3JHU2xKTVN5clV4QkJNTTlzcENZYWxxK1hyclBjNzhzL2Z6QmlI?=
 =?utf-8?Q?NpXGea97V8rYKS/s=3D?=
X-Exchange-RoutingPolicyChecked: ddU70+i8Ro8GThNqB88kqVsc+se65XU03wVMT1n94DIZdwf8yoqIznmscXhzMeJbZ2Jd3B7g9kXwvuY03xoGP33xk1Lz3/h1JEJgA1TKQEmUSsBmWAmrEpaFBSaF5JnlqSLWXiF2Decv6dzPnoAcMffwZNeBd4kE9D3Ax6k55u/kNOBgCvi5+hUE7lfSRDIQIybYXaYPFOEfy9sJJhgd827zzph3nAyaLA0OghqMLzdTBxHlam5Q7EAhemi6ye+BrtjVqV3yyE+CxUVPOHrSDbJEF8XyvZzoC1V6epQxuEhzs3wLNGEwd69rfNxo38n+2GNWDfA1Cxh8e9Az2bKaYQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de29ec4-c736-4d6e-51d5-08df4013c463
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:49:35.4492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKQEYOVQrdN/qzAC1jMSKTJfuNjkqXHoBzIHERqokeCeCbTOg05fP4elD+51K3tHBT2cMW1vxL7FAsDX1qlAl4mY8ftwKNVe3ebIr5lg4L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR02MB11372
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6af49ca0 cx=c_pps
 a=cLYCveKuP4lckQHSrQKrbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=a8B256S7u-WoC_B6LV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JJMY-y_0SB-Fdjk9aT0GpsTqym__jZ1O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX4S+6SSyDIaN5
 tegx+v9g0OPjHi00YKH65HCjAXBm3mhXhIfw0EJtzs8USny4AHnPknJuk4kZ7yaXXjyE464djqx
 /CuqcIu+XAV/Yiz7ZJTqGU9XGJwizKjo1kavqesOWp4tWwVnZmeK85nTg1XX4VDmLY7AatFCPc6
 O5/piyXNZ2oMdC6BvAp8c3wlu1BVBDw+2omK7deo1Trww2kCkftubIR5uB101gOkmABigzCrUc0
 uK6gJCqykqzv+bSmcfc9LhrnBmbRi9NpS9EZwPn7OdyzecotVLpIWYo+8fBwLagsP7Bidrsc+Gi
 wYTh52GibQwb35J2XIxMfKBN3ARbt4fg0dsbq2zOW639+US+wMmKSGqQs9d6ucVYQKeLwXUYMRB
 /fY9nMvuGy3vR5vmkJYOeOxkI+3CDUPlgQwkiKNaDwjdd3BG8VcXEB2Te//142Pk0p4gjTme/vK
 EoDlaytujpJG9xXWCdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfXwNzfTUYj4bKr
 Q1YBGzEeGYMFJ2+jQ+CVctUppKjIkhpoCKiehi+KmVOqs5+FhL/1RsgmFk45hF/WVvIZlSoiRNy
 gYg1wGJuyj/cz1tyXi2xx+np6TS4VD0=
X-Proofpoint-ORIG-GUID: JJMY-y_0SB-Fdjk9aT0GpsTqym__jZ1O
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

> When HostMemoryBackend method alloc() fails, the error report isn't
> always clear.  E.g. "-object memory-backend-shm,id=mem0,size=1E" fails
> for me like this:
> 
>      qemu-system-x86_64: unable to map backing store for guest RAM: Cannot allocate memory
> 
> Leaves users guessing which part of the (often lengthy) command line
> needs fixing.
> 
> Let's prepend a bit of context:
> 
>      qemu-system-x86_64: can't create memory-backend-shm: unable to map backing store for guest RAM: Cannot allocate memory
> 
> This makes an error message in shm_backend_memory_alloc() partly
> redundant:
> 
>      qemu-system-x86_64: can't create memory-backend-shm: can't create shm backend with `share=off`
> 
> Change it to
> 
>      qemu-system-x86_64: can't create memory-backend-shm: backend requires 'share=on'
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/hostmem-shm.c | 2 +-
>   backends/hostmem.c     | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index 0a01c760551..d1cba22cbeb 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -31,7 +31,7 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       int fd = cpr_find_fd(backend_name, 0);
>   
>       if (!backend->share) {
> -        error_setg(errp, "can't create shm backend with `share=off`");
> +        error_setg(errp, "backend requires 'share=on'");
>           return false;
>       }
>   
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 173d042be35..1c2a5d42fc5 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -335,6 +335,7 @@ size_t host_memory_backend_pagesize(HostMemoryBackend *memdev)
>   static void
>   host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>   {
> +    ERRP_GUARD();
>       HostMemoryBackend *backend = MEMORY_BACKEND(uc);
>       HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
>       void *ptr;
> @@ -346,6 +347,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>           return;
>       }
>       if (!bc->alloc(backend, errp)) {
> +        error_prepend(errp, "can't create '%s': ",
> +                      object_get_typename(OBJECT(uc)));
>           return;
>       } 

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


