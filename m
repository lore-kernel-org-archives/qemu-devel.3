Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16661606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=AxyvP8Vn;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=EOwu2aNK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNzJI-0002cE-BA; Mon, 02 Nov 2026 16:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xNzJG-0002bw-QW; Mon, 02 Nov 2026 16:11:18 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xNzJE-0002nF-GJ; Mon, 02 Nov 2026 16:11:18 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6jPe1853356; Mon, 2 Nov 2026 13:11:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TabWKs4yFN51H7LPnBGZ3hFeOMJPZJWcuFNHdnZ0U
 zQ=; b=AxyvP8VnZ0VxHaS0tZYO/gfATlKQlZUr6ROgqwZsSqTeodXOzzpjFYnhs
 Kk+Lk1YDDzNEoUb/XzNvThSDCclaJ8l21MpHgF/QtzhK6yqVy/HV9mQRH2w03Sv4
 VKja1SrvLsLWx2dNPTtAfJ6MYvnZqyukG3STtRpirVnHs7QkaIBgjigQ8ilbLk1V
 x1EcWYltT7qhXThjCqXmge8b5c4jEqtPgkoZkm30c9lUeb29slLcMlYoj4DLR7hr
 dNKF6YrMg66vD2NGY3+aTmW8YH+Tb9os2PeQPpndkDktcJ+Ba5cKuwkve1OSvM1a
 44CuXLm66BbcfpS+MKS4wSgJAEzRw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021072.outbound.protection.outlook.com [52.101.57.72])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hq0c6g7kk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 13:11:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XudXVQNHXS3jTrjbQAdgC0SuWpRgmZKmOX3731S1kMm5kQRwpEPsszGBDk3Yx8tFuW+NOlMpW/glLjyLidKyYTEh0VH9zcNaOWiitxQxald4npHp4OQGOF0DTWnOxtmpHIFQ0ZkVr1ntrIr+sSsiOO1xDilu30y3Z67RFNasVwdMQaiOCURx4/dXqstAiszqctKQFm+F1dEUFIE+/bY6oMpF8BheDAuh6A59mdDGgZskl4XPeSiv8NXvj1T/zLG2B+cv8jDW72Il5tS7/Uv5UtR2ucL7rhdPZCbhY8RMwpegD7JfppM0O429zPc//PIWs4DRtsd0xIhZsLOgnkgesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TabWKs4yFN51H7LPnBGZ3hFeOMJPZJWcuFNHdnZ0UzQ=;
 b=icPkiFoty9IDu0RQL0k65BjHxUQxgEhkdx4eW2eTO9oU0/JB+OHsd0KJIPCMGhvv7qr/ZMAkf4rpUtL69AwM8wbHt4ipH6mh8MBfjxELrNZOhjreesohPo5Q82HZ4I6e+XcqmSDDPyMQOxMOvRCJ2dNERPV+LYuOV7DUJ4lrvbtjYEFiJYxeT/TjFKPkAkl7dG0xpjiieJKUGkHJtPJWuEHoWDZAMv/vn+8nMEXlkpjbQRfzo11Rr75d5U6VqOIwxIIS1Ve1ACMx/5AC5qv1vtr+B58VraaFoEGuFF5GH/cSZSo/93O5PpilOQxPEUc/MXpgKiss8YT7LI9+1HIByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TabWKs4yFN51H7LPnBGZ3hFeOMJPZJWcuFNHdnZ0UzQ=;
 b=EOwu2aNKElPtOhUbJ1pZnq+VDCgjWQYjpf7EuzqEzDLRNm35Wj2cSTOZPsklakc8BB1ipnzONASOaRu785T0KSpTaTPMytOe6S9Q9ANt+wOArTvWWTXElffCsDt5+GNUqlRc4LmFQKareBsutoOevAHcBC5Hi7xejmyr8nz10CV0eR1QoMjmBZkZWiEY0rACcIe0KJsI6cMGo+EeMWp+l3qsTenB4STcKsWJCHQFCeds2nt+BNwJW587GDXxAGVF35C386UAcL0CIE3/9YWEfQkUBJq+CaKJMFY3qljzbxLabY2WFx9Irj7CwWB1xuaaW0j1j4TrcaeL9LVJfOPzqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7254.namprd02.prod.outlook.com (2603:10b6:510:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:11:07 +0000
Message-ID: <74048555-8631-40ca-9f03-9bd87926869d@nutanix.com>
Date: Mon, 2 Nov 2026 21:11:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: Check Bus Master before starting DMA/FIS engines
To: Abhisek Panda <abhisek.panda1@nutanix.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, den@openvz.org, jsnow@redhat.com
Cc: andychiu <andychiu@synology.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20261102181901.329008-1-abhisek.panda1@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261102181901.329008-1-abhisek.panda1@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1b6e16-51fc-4fa1-92a7-08df3925cfe7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|261102123227099003|22082099003|18002099003|4133799003|261021135927099003|56012099006|261026130827099003|261021133027099003|261021130227099003|261026135527099003|261022075727099003|261026140227099003|261021121427099003|261022115727099003|261022105027099003|261026121527099003|261022113327099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: lNuR2q8hj2D+g7KVlHzeKkwJKULhfClY4PNIf3d2Tm9oHFiIbzEN806n/bvz41L83Ry0Ejy3txDmNxQoE4nteoLarvEGkY/OFqNsQvXybG5ed5pmeCyRy5fdgYh75OszZZM1V8uHwTN06Acnw4JB+xGRb+jtUwCdPoTqo7vZ4vkAGh/kRErgoo+uaJHd8TWPWaPxOV+doI7lM3uyVIc79r1PV4E14Sy5N91rtQs5ja0sEYlYm2xDZggJ3nxfOAuFbQsMp9Shrk+kZNmnsHAeKX6UjngNM42YlwXKc001j54P8pVg6Hq1uF+yxX9SiOmQwvtwtwbl730vVrEytvXMWoTHs6SlegPDsjcpT9FoR9+g0wz+qvuEutje/s8npeAir5+arSIhxC6Ag1+J47+6/5y+owtGA7tLpt81tx1AKfoBwDV3Q3NS5pPzJUudhnnMNSvUMHRp/5VTI+Zck7MbNevNKRu/syNORnuAaGoWoiL6ly5/J4GrI1pNECxNnkmiJX5jr9xYL3YyYZxMJe9JrZA41RfYrQ0uSY2zUR8x/nEq2QHkq1HRkPurJgaBv+anmso1sZsQPp8XAceP+Tv6ldexVlPPOC9KLa3MEqz34sAZCMLC6pjFwdGKXEpZEfznodW4PyEBdv9Y8ok3OgzleManEgJzhY/xUcmlRgJpSRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(261102123227099003)(22082099003)(18002099003)(4133799003)(261021135927099003)(56012099006)(261026130827099003)(261021133027099003)(261021130227099003)(261026135527099003)(261022075727099003)(261026140227099003)(261021121427099003)(261022115727099003)(261022105027099003)(261026121527099003)(261022113327099003)(261028144727099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFF1Yy9jUFVadEUxMnZ0cU5FZnV6TTBJamlJU0ltU0tVTmJGZjZGV2FPWm5P?=
 =?utf-8?B?c1RGYkVoRGtrMGtlaGM1UW9pdjhNUW0vRkVpN2N4ZGNkdXFTNGJ2WlI1V05F?=
 =?utf-8?B?U0lUL2Z2NnVYM0dZRnNINTREN3ovaW5xTzIzNmg3RTRES3M3Qks5NU11bkly?=
 =?utf-8?B?Mmw3T2RQMnpaOEZ6RjZwbzBDMXVXNVBWRzlXVk9vZ1JrVHhYV1ZFb0VobkZy?=
 =?utf-8?B?bW12MWxvMVVUQ3NsMU9RM1M3WUw3OXAxTmwyM2MrMzNuQzNEbmlTdld1Wi80?=
 =?utf-8?B?ek9iZXQrSE9QeXlxb1VVQWFIZFJKNzZqcGI4Wk03UVJZR1ZOb1pySlhOSWZv?=
 =?utf-8?B?bUJoNmN0Tm1OWFVsaDY2YStEREhMRUZYYkkwQ0lHdFl1K1dWT25nVkpYUis0?=
 =?utf-8?B?ZmdaTHpQRmFyTHBsTVNzbFY1WkpXcld1NW1FVUd3TmpDSjFCUGdZKzZ2R0dX?=
 =?utf-8?B?dVFYdSt1dEYydkxxd09BZ3QzckdvVE9WREFkZXRXUFBlSjlucCtJaFpwWWtp?=
 =?utf-8?B?OTVsWjB5Zm5nWUk3ZWdYb2YzbEs1SS8ySDVCMWJYeTMra2VkM2s2Q1p5ZnFY?=
 =?utf-8?B?d0M3THd2WnEvbFBuM3htejFyYTZ2SWxETkx3VjIyWmF4RzNRNVJQcjg0WlQ2?=
 =?utf-8?B?RjkrTjJZT0p4VVFSN0lSTEZkWGVVUGlqN2krTWlKZGttMU9iL3RGZklabGNt?=
 =?utf-8?B?NElaZDhCbHdDaXBkcGVWSDBiSGxGK1JGcy9PR2J6YTZnbkxrQTV0K0Q4Tmoy?=
 =?utf-8?B?eUg3MXl0MmVLQWZUaXVOQmhqRmM0UzNuWFVteUI5eUgwV0Z5UVZFRW9vaEpS?=
 =?utf-8?B?ajRMVDJIWDZCWE1PMTlyUDg3UmZlZ2VIcVI3ditDd2ZGTXd1ZmJMZWxxZExO?=
 =?utf-8?B?a1lMOWdjbVZuMnlGMElvVUxBdkUvcXZ0N2hpdStOVFl0Ui9uN1ZsSjQvaWhV?=
 =?utf-8?B?NGUxNmpPWTk3UVdEaGRyQ3FuR0hYeTVNcXFYSFpRcmpGTnNSclpKSDkwdmh0?=
 =?utf-8?B?UFRiUmVDT1dOalBiYkNjVzVEL0hZajBCTnJiTlU1TTlTMktQc0hzanE3SytE?=
 =?utf-8?B?Wjk2elFDMWFKdlBWL1RpazVKR2FMazhuR1BJOXZwbHYvbHMyZlhROFJtNTNs?=
 =?utf-8?B?SFFhYmlDNmJsaUxqRUNETldESnJacndYK3ZPZ25JR2U2WGU3UG92djJHcCsw?=
 =?utf-8?B?citlZ2R6cnA2TXRmNlh2K3gyck1vQUY3V3oxR21yRWVuQkFKeVhTeWhIOWpo?=
 =?utf-8?B?Z2VCSmhWd1hQRVdLN1pvMERTNTR0bTZTTTMxOVlQNXlyMnlOaG9renEwWEIv?=
 =?utf-8?B?UlBLTEdSWitZdzZCVUd2R0xkRGFyVmlETTJodU1VRHNuUUxmT25jcWZ0a3hx?=
 =?utf-8?B?Ui9aTEgzUmY5bU1TYWVrZ2hDam42MHJCYmc3emNhOEZoeFVSR1RBK1BkZnVK?=
 =?utf-8?B?andYTWNkalVsb01icHZJNDB3K1V0U3R1RUx0NlNORXZKS21XbmxpWk9OdmtD?=
 =?utf-8?B?SFliam94UjZCZE1BeVo0cGhzamNIdnRXQWkweEpBN01lbDdUOWtEWXZBU0cv?=
 =?utf-8?B?cnNTdm5KVVlDcHpueDVLazg1YU5jNldRVHZjcU15c01XczZDTE1DVitXRTdO?=
 =?utf-8?B?OHZ3anppUzVZYUJEWXVuWUhRZ3lqVllFWGF5ZERNcGU0cnpMQ0dCa2lzWmEy?=
 =?utf-8?B?UXNhMHVENHBFaGNmR1NqdWtiMUgzRXhDUUk4QTJwVGlGWFgxUExmZjY1Zkto?=
 =?utf-8?B?K0hPN25UTkhsbFlFMzlnaVFmUnNYQWVXb0t0Q0lYU1VGeU1DTFJMcGc3aWpx?=
 =?utf-8?B?T2c2c0FVYlMzaHczTUpLL1QzQmt6Uyt6ZTNMcXdoUmhoVlhPblJJRlY5eXNy?=
 =?utf-8?B?QUVMY1pvakJ4c2h5dUsyY3hWaW10MzZua0xxcWtRTEQ5ZTVvenZNS3R5OVc3?=
 =?utf-8?B?cUxPY0xjNGNzTWFiTFNHKzJzTWpKYm1wMUorR1hNMCtyR3lqN1I3Yk10YTlm?=
 =?utf-8?B?NVhnSFRVcU05S1llTzVKMmZrL2w4MGI1STlZck5pNWNHbzZKS0REV3lOTmJw?=
 =?utf-8?B?WkNOS1AzS2o5UWVsU1ljUjRFNXd0ZmdtSW1jc3FYUVBIeXRLZWFTOUJ5aDVq?=
 =?utf-8?B?UGxLRStYVHNhRE5seUlGZlkvYUdINytzSFBwYVh1NnpZc1VjRXNJcjVDQytv?=
 =?utf-8?B?Nm1SejZSNC9uS2kraHFhTXp3TzZtVWxNQ3BFdndHM0NuY1g1ZUpRMUtTNXBa?=
 =?utf-8?B?dVJ6SEUvOFdQN0xpNFh3eFdpOEpJblp5WWNpaWZ1YnFFSHhEbnQ3QVMwQ1Vi?=
 =?utf-8?B?NGVLMzFwTVhiRWxKWVQ5dXc1cEF0c24zSm56YW40Z3VEbFpwVVZMRWJXTnpB?=
 =?utf-8?Q?1m29ECF5LcBFuNYY=3D?=
X-Exchange-RoutingPolicyChecked: jiuTWaD5WpYiZ6GGlO/92C9E86fcVXjw9XLJOymZtY325c/VUhnAwjh0wy3Pafjev68YzDBQFFiMEk+u4R/Yu/LAy5SokXd7O3Bz18lYdteFPxBzlOlt5ViKMHNEW0nhmUhOfw1vNnJnIS4WApPXUA/tRHyoTGfi/eZ6iPUT8V1U+ZnLmnwtolSxMWHs9WkajEdHgn2vjOYWjNJmLFfqdZ8RrzaVaVmvyTYjRv5DwNG6Q8IR7i0NJO9N+2XoJuG6SDj0zrfKQ+wnhvE/TCihtKP5CNkJtLs1Zcl44Zx/TGfBIstXFr483m3LcM22ZkxJ5e9tMMjSPUXPpRaheXMqhQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1b6e16-51fc-4fa1-92a7-08df3925cfe7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:07.6055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDVUWBlW9Cs1VMuzP7z+HQV639YrDHo5fGYfn0dq9mgPSSGMu1cZvN0jFYML+nPj8iNJJ+bG/ZrfWZKwescwUaKhK6jkuikaYVCQMQEhyVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7254
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NCBTYWx0ZWRfX8p7KCKX2vnYv
 uhmz59psy7RpV/CsnRi5Ut2xYaICPz5oQyJgB1d7JBMXV/wClcjFhxjJ9/ZUmRotUVEEAltnT4U
 XbNgg5rWbUTJAhiRUBCkk40+NRyFQd8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NCBTYWx0ZWRfX3HQ87l4iyhdB
 3imowuud9Rlt2KPWmtu7H3NhTl1Wz+h1vAlmFtjOvVvNb/2fAU2ExnmwYlHjwXXUG/x/5t/7M4X
 ec0veOwQFaoAArZAAIAI1ZhDEIc/GIlAf46/leSYgMI4xg0kPJ72x2nNj3qhF06Awm6Y4qlwSj4
 X4KaivSGXU1em9t6s7MOc+ZMPMVJKxIeUa6zScPonvw5/qTZ+IoNRu5XUBWTF/fMrgwdi8L5aXu
 QXJBU3NGIsIysQ1sjIGeQT0orrrX/bWhfQyEs29qZ713VM+2ZAwzGQ/A9Y73BRAlQirUsUOFxa8
 rCfxYyXca8S8kHHy50Kyfi66wkuSWpqfObUMluK0+N+nzG0eF8v2NGHGeKRMS/hWxxczG6FGV4D
 0YOVICopRw5MKcouxYc/+VkY0xqqO985rjvrAyylAEh664URKT8JcdxGC8pMeDmo16UFe4zuXaz
 1GLmNLeHUI2sL18d4Jw==
X-Proofpoint-ORIG-GUID: X8D8jGSli-c5sGQvCSuOL2DDdzNkXaFg
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6ae8fc6e cx=c_pps
 a=Tmenz91GMLKLa+Z4vsoKoQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=mDV3o1hIAAAA:8 a=LM7KSAFEAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=6rqHouBjAAAA:8 a=4DtSZnbbe-7fo3FszpcA:9 a=QEXdDO2ut3YA:10
 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-GUID: X8D8jGSli-c5sGQvCSuOL2DDdzNkXaFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
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

On 02/11/2026 18:19, Abhisek Panda wrote:

> When a Windows guest puts an idle SATA drive into standby, it disables
> PCI bus mastering on the AHCI controller but fails to clear the port
> engine bits in the port command register. During post-migration
> handling, QEMU's ahci_state_post_load function checks only these port
> engine bits to determine whether to start the engines and map the FIS
> receive buffer and Command List buffer.
> 
> Because PCI bus mastering is disabled, DMA access to guest memory is
> blocked. The consequences of this allocation depend on the bounce
> buffer budget introduced in commit 637b0aa139 ("softmmu: Support
> concurrent bounce buffers"), where each PCI device receives a 4 KiB
> bounce buffer limit:
> 
> 1. Silent Guest Memory Corruption (Budget Not Exceeded):
>     To start the engine, QEMU allocates 1024 bytes for the command list
>     and 256 bytes for the FIS receive buffer (1280 bytes total). With
>     one or two active drives, mapping requests succeed by allocating
>     private, zero-filled bounce buffers, allowing migration to
>     complete cleanly. However, when the guest later resumes the drive
>     and stops the port engines, unmapping writes those buffers
>     back to the guest memory regions referenced by PxCLB and PxFB
>     with zeroes. This leads to silent guest memory corruption.
> 
> 2. Migration Failure (Budget Exceeded):
>     When enough ports are active the 4 KiB bounce buffer budget is
>     exceeded. The mapping call fails (e.g., "bad FIS receive
>     buffer address") and the destination QEMU aborts migration.
> 
> To resolve this issue, skip port engine startup in
> ahci_state_post_load() if PCI bus mastering is disabled. When Windows
> 10 re-enables bus mastering to access the idle drive, traces
> show that it explicitly restores the state: it sets the Bus Master bit,
> rewrites PxCLB and PxFB, toggles PxCMD to restart the engine, and issues
> a COMRESET. Windows 7 does not hit this path because it does not disable
> bus mastering during standby.
> 
> Reported-by: andychiu <andychiu@synology.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: John Snow <jsnow@redhat.com>
> Link: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2019-2D09_msg01544.html&d=DwIFAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=OBPqoZYPB5MuKHaLu4K2N7eQxIwCnBLt54cPkiXtGWmSb4NT4hRk822tulM7nuXo&s=2F6eTWfiPqvM_reWn9mPV5JIzf8nl6v03NNyPln8APU&e=
> Signed-off-by: Abhisek Panda <abhisek.panda1@nutanix.com>
> Tested-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/ahci.c         | 17 ++++++++++++++---
>   hw/ide/ich.c          |  8 ++++++++
>   include/hw/ide/ahci.h |  1 +
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 86f6297dc9..5f842eff13 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -172,6 +172,11 @@ static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
>       return val;
>   }
>   
> +static inline int ahci_bus_master_enabled(AHCIState *s)
> +{
> +    return !s->bus_master_enabled || s->bus_master_enabled(s);
> +}
> +
>   static void ahci_check_irq(AHCIState *s)
>   {
>       int i;
> @@ -1625,6 +1630,8 @@ static const IDEDMAOps ahci_dma_ops = {
>   
>   void ahci_init(AHCIState *s, DeviceState *qdev)
>   {
> +    s->bus_master_enabled = NULL;
> +
>       /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for now */
>       memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
>                             "ahci", AHCI_MEM_BAR_SIZE);
> @@ -1792,10 +1799,14 @@ static int ahci_state_post_load(void *opaque, int version_id)
>               return -1;
>           }
>   
> -        /* After a migrate, the DMA/FIS engines are "off" and
> -         * need to be conditionally restarted */
> +        /*
> +         * After a migrate, the DMA/FIS engines are "off" and need to be
> +         * conditionally restarted. If PCI bus mastering is disabled, leave
> +         * the engines stopped because DMA is inactive.
> +         */
>           pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
> -        if (ahci_cond_start_engines(ad) != 0) {
> +        if (ahci_bus_master_enabled(s) &&
> +            ahci_cond_start_engines(ad) != 0) {
>               return -1;
>           }
>   
> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> index b00987f08d..8e8c2e108d 100644
> --- a/hw/ide/ich.c
> +++ b/hw/ide/ich.c
> @@ -110,6 +110,13 @@ static void pci_ich9_reset(DeviceState *dev)
>       ahci_reset(&d->ahci);
>   }
>   
> +static bool pci_ich9_ahci_bus_master_enabled(AHCIState *s)
> +{
> +    AHCIPCIState *d = container_of(s, AHCIPCIState, ahci);
> +
> +    return d->parent_obj.is_master;

parent_obj is an internal QOM implementation detail and shouldn't be 
referenced directly. The right way to find the reference to the parent 
object is via the QOM cast macros i.e.

     return PCI_DEVICE(d)->is_master;

> +}
> +
>   static void pci_ich9_ahci_init(Object *obj)
>   {
>       AHCIPCIState *d = ICH9_AHCI(obj);
> @@ -117,6 +124,7 @@ static void pci_ich9_ahci_init(Object *obj)
>       qemu_init_irq_child(obj, "update-irq", &d->irq,
>                           pci_ich9_ahci_update_irq, d, 0);
>       ahci_init(&d->ahci, DEVICE(obj));
> +    d->ahci.bus_master_enabled = pci_ich9_ahci_bus_master_enabled;
>       d->ahci.irq = &d->irq;
>   }
>   
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index cd07b87811..434a6457b5 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -46,6 +46,7 @@ typedef struct AHCIState {
>       uint32_t ports;
>       qemu_irq irq;
>       AddressSpace *as;
> +    bool (*bus_master_enabled)(struct AHCIState *s);
>   } AHCIState;

ATB,

Mark.


