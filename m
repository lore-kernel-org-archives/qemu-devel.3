Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF92BC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7V-0004Ho-KL; Tue, 22 Sep 2026 06:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7T-0004HL-FF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:53:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7R-0004Yg-KQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:53:03 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03Whm2262377
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:53:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UiUm1XYXmhKQHaCLSRu6k1MPGMhlvdQIvWcySU3k2
 S8=; b=yHJjrwJRhzHJYnzuf/e3hvS8F9qXgqI5x8vf4Kqmf3+R65Vaoic2UVN20
 3B98Lmh+EYaOwqDMaIdvL6UAogXrpSyyV5mysP3FnzIOWJA+q8ygrIRWeCo98dw7
 toh1/TynOefNFvqCwkcrslYfb2dh1xNJf8++Vu+eN76vchNGnl8M/ZV1boEofv+B
 1kXe+IJcjvBMOSmXofK1on0KGL4r7LKbt5DpIIL6/J0xpXXiQfMwHINJ46fCTvnD
 VSvwF1ApPo/LMxKDuJhlr1ImswVrxTGmc6ZbQZVhcklmlJo+P8H0rKxHeqUw3fN9
 fd3l3ocorkejPiOKFeLcPuYy8j2zw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021119.outbound.protection.outlook.com [52.101.57.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gspqsedrr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w48hXky45aZNXqYQy+TcxwCTc7MftFZTxrwMgALDeG9jtZrzTEGt1m0ur69R+OdWW4lSCLEkliUpi2TXEfBFPQ4yN1vg0zVvBMK1YTacFlrBnh2qUkD2M9ILHpy5r98KeQa4pjFfjXKDMVTa1/f98WXjfDxXTpb7s0mjROCKODVGf79F59pPak+0D8HqX/GxmZZEVxiBA2UJK8riZo4BapUYGxQQvt4cy2T/By0jNyQ0Kb75aYvdcA0aX5kxvaHxqDsz3uqHfOsIXQPrH6CCiM4scMkdUWM05e0G+s8tf0o8Qbzs0QwPstVtXt6KrbMrhMaAJNS/6dzBc5v4ZPyvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiUm1XYXmhKQHaCLSRu6k1MPGMhlvdQIvWcySU3k2S8=;
 b=ELK3TLIazJiglvfdQI6kSv7KEA5s7odTPkxygZJuL77bFK96qlSD2HTwY2WjTEO9wQgZIcKqAWxiSDMHu7EKKVizuVB0TxONBd6Wo9BbfkW0Vd8jAelDbrxLEN0WBb2hs56G4hD/VNmbYe/sYuCkqlw0XsAp0yKdf79LPGdqhu5XT5PIeTshPbNMGURDH0TTUg7ENevPg9MAWGVqrMpcK9dH2wIn4i2X4jDwaoi03lqqvtbPsKfU+JWuM2QKgZ/1yf7PYCvJkU2uaq4sF399gFvCo+kgXdR/YBU2ZyCkU8i1hOWBGztTEml6Qclp3rIk2RrrcjWNb8bbRd1obw679w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiUm1XYXmhKQHaCLSRu6k1MPGMhlvdQIvWcySU3k2S8=;
 b=yFxDWFiHQcElJGdcAA7YOoPdXV75MFugPXc4bY+7JISvJxeTcNqJGUFMUJBAJHXs1tDJzbwHTdvuFWrKAUmSZGS+oJpZ+/k9Navi9aHwb2qbAVIH7Y1+sVb8bP0UXShMwbduPEEnIiCWPOAMQeUgIM7N6cyMUen+5J5HI7f1a+WBAIp19YkM4+C7iFd6mw3fWsevFk6Dw7f9oBEjyYHBn16M+P2hfQE/iVerijOm1kfPsNrmZ5rOaUUyPWivgkLl8Xg2SM7w5VZwSMnjA3rnimcjvyoQhzI4Ni4I9sQ5UqA6kHO09WOWNXseTLIPDU7eF4dQmbku1IPLs9/d4d7L5w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object
 props to class props
Date: Tue, 22 Sep 2026 11:51:37 +0100
Message-ID: <20260922105223.1607725-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e52085a-50a1-4f7c-fa9e-08df1897aa40
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: WZMMPs/7PzGzSMKSQJsWt6JCGwYaw7qWxM7WsLoLbzq9dVn8GXu4Swidx4g9BL5wbJp1k2szL9e0Ja1lsVoobud7s7wWSaDPrCYbvXmJbwtMq3YhJc98B121xE57fbZLqBiAl2KNl+3jNnVolKrRupQ+GK45jdUJJekvlx/B9aWUm9BUAiiBUd9Y7iwO6AQkefxZkmt0+NaE2RML5nAyaoc3dNXo11YOOhfynu8cLAmy18JaLFGGETR7iNSSorFo2Y91faU/M5W+oFFO7Zk4WUuVI0zbTpoXAFut9xQbsH2QGy0HgKxWL62tX1YBmfVEZ9lXGJQv0mRUOSIRFHUMzJ52V9zlte7Jc9z4hl88T+PykK7bk7bj4TMgdtuMXa/JbmpTRu9CbmFBkXBeokBi93wad5jnpPstFJ0pPdD1jZ8GNIFnV92/IGuiHrATIm/pAlubxw47QEZjgz1KKq+cefCkYm9jeFDnur0gXQXptdkHzddlMG442VujZWNTO3RyeLkbWL30sf6AZvghxynfnxFad/vkjdYBfTP1TUrMK39Yxbq5PZ2BZf6DuLOnuHXX+NDRqOERKH3givAG9IYsvvUeWekHJpxUCZlJBdeMvLRzEQhvilOfp7815JsEDZ7Oy60wxBDhjWnn4D+tWCub150rs5V9RiL9b5UnbsfcUdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzAybStNeXo1RkY4UXR6dmZtZDY2NmJxU1I2LzB3Q3ZlWmVmeHduYUVSUWc1?=
 =?utf-8?B?dmxjc25OU2h1ZzRpVXFwWTUzTEhJZmZrZXJ0STdKQVFQNURPdVlDMWtNTjJ1?=
 =?utf-8?B?eDJxaUFhb0IrMmtNeTdzYk9paW1ibGUxWkVONnpYUkVaZFU1SDJsWTBqR0c2?=
 =?utf-8?B?RGliVmJSeWxrenp1Z0k1Z0FZU2pBRW5NZG83MmVIM2NZUEdCRnMwb3llbFNk?=
 =?utf-8?B?STRkNUFmOXZZNlZaNkorVE9PWE1ycXdyZXlmUEVDVGxlR3VQTVNDcVFwV2JR?=
 =?utf-8?B?ZmtDT05IY2hSMjkyYW5GdURTUHVPTVVxUlk2WURJM0lqZVpzZFRlZEYrMW5r?=
 =?utf-8?B?NGpOUlgrOXZKYVRrbDE1RUF6MVlmSGFrWi84T1NmUXFGYWQ2UnBrRWZBaytq?=
 =?utf-8?B?U0Nicnd4TWZSblhicXl6WGhmcmYxN0Mvd2phRTJEZk1FckRxcEhRT20xY202?=
 =?utf-8?B?Y2pDVUQ1TnA3SFE3TjQyZFh6amdXYmNVRloxSjBzOGlDTTViSk5BU3pTOHVN?=
 =?utf-8?B?TkI4TXV6Y3kyOGtiWWRUN1drcHpySUVXUU00SC9VNzM4NGhWK2pIbHBiZUZa?=
 =?utf-8?B?Zi9wcjNnQ2owTFRIbTVVU0piQ1hlWU1UT2dDNjY5anpSemFqUlIvc0l5MS9U?=
 =?utf-8?B?ZTM5dUtOUndLYk9BbzZTQ1pITWRzcnFpbVdabXo1QzF3VWxidzJ0VmpFVU00?=
 =?utf-8?B?dlBweXo1cVQ3N3REZDdhY2dXYXhSMlVpTkZLTEdIOFdkMkxKbU11UXM0YWdZ?=
 =?utf-8?B?VFZjSFRhRGsySFJIbGJ3N1J0VGtXd2RVOUlwUVduNzRCajByWlo4R2ZOZllm?=
 =?utf-8?B?QkNzZXZXa0U5YVhRelkrM3B2RFpBMHVKUDB0OE5sa216RC9KYmFIVG1DVUhm?=
 =?utf-8?B?OFNsSDg3SzlsTTVZOGtqMFVMdEx4SlJwQWQrdXZiT283Y0NmT2ExdHpZTWpz?=
 =?utf-8?B?bWY0UklDSUFVcGtjNW4yOE5QKzVTUDNVb3liMm9lTjBNaVdmemFNN3dUckZM?=
 =?utf-8?B?R2pxVnFqUGhUUllUaXhOYzNsbnl0RURta2ZtaENCbnJlU0gxbTN0Zk5ZelVC?=
 =?utf-8?B?YnlLVHRyRGszbjdwL2ZEbzJ0dmZpYjh6d3Fjc3JOUjR4cG84aU5rREhtNXdu?=
 =?utf-8?B?TkRiT0IwaHo1dUlFNXA0Q0dCTktNOHdQWFpnZEhqS2RZSlB6cEY0UVZIVVhZ?=
 =?utf-8?B?d25IeDh0anptVTFMcktGZC8zcmZZd1FzOER5V29uYzRQNXFMV0R4VjNiMDVk?=
 =?utf-8?B?dENURHRyUmc2T1czaWFINWZYVXJaOUZucmszeWVVZmxOKzI2MlFsVDRpMkQ5?=
 =?utf-8?B?QjhISmZxeitaaXVHd0VRV1VkeTVQYUltQlBOYW1yUkZxNjBHdXlsU2ExM01s?=
 =?utf-8?B?QzVFVzB0R2NXU1FwdDRuNkF3YXVHbXJCWVpWeUI3RW9sZ0VrcmlMZ3FxYjQy?=
 =?utf-8?B?Z1VJWGw0VU9JQ1VZcy9WNWtXcSsvVmROL1FhZUhVM2xRSmEvZVVJMmwzM2g1?=
 =?utf-8?B?azFLb21jV1NLRmhMVkN5Tjk0RksvV2swbDBrK3FNbnRRQ25WYlptck9PM3VE?=
 =?utf-8?B?Q3RGVUN2cWtSbS9uTXNQNjlNVFgycjROVityNmRxOTZXc3FKOXpPQkhRS3A2?=
 =?utf-8?B?VkFlVFZjc1JaVko0RlBqYi9iTGMrTFlaMHNybHJJSmgvWjArbk40alpWY25i?=
 =?utf-8?B?NmlpMGVRcnVUb21CeDJwNTJOQW0xTnlQL2NyWnpXK1pRbWFJQ2RkcE9nci9s?=
 =?utf-8?B?bURFRHFtZ1R4bjNnWEhUQmxBTGJQM2hpZkxHYi85c2lRT2lUNkcxT1lOc2Js?=
 =?utf-8?B?T3doakZLT2MzMDY1OWlVcXd5MUhWUGkyQU5MZ3pVUjdaVDV2Znd6cXZrWGRZ?=
 =?utf-8?B?VTRQbFZqbkZvYTdqYzg3cU43dkl2M3E3R1dScU5qYjVsM3RvZTBhMTFFa2xz?=
 =?utf-8?B?TE02Wnh5VldybUE5VHpNemJlK3A4VktTQWlxa3NXYWlFR3NiWDlEa3k1eElz?=
 =?utf-8?B?NU93RHdUWjQ4K2RaNFRkRzhvNjlXUzlFdmI1UDRBT2FTc2RQWURyQ2xmL21x?=
 =?utf-8?B?cGJRTjRkU1ltT2VRMEhvaEgrQ1FPRUlKM3NiUmxyNUVBRnhwT1lMeThFZCtN?=
 =?utf-8?B?QzdMRU9sUkpHcitHb2RGdGMvSlFKTFRSOGRTY3h0MTZ4MmRvRVFuRlpxOFEy?=
 =?utf-8?B?ZkNQTXdVbUlHNDQ4K3pXbDY3eENrbWgwOWNZVzliVDBLaEFodU9NekhSUW5k?=
 =?utf-8?B?cDlBN3VqSjV3SFBLNFZUdmFETTkwRVdPN2xuMzBoQnFpdnNvK2JTRUh2M2hh?=
 =?utf-8?B?bU5ENForeUtlM2x3YVYralZJRkJnbmZuQVJoSk02cmVBcEpHT2NLTkpucGJr?=
 =?utf-8?Q?SkKcfkXxHFKAmwVc=3D?=
X-Exchange-RoutingPolicyChecked: vGaiOhpZq+KOtlyLqN898P4roxoQayW/ui9YNYCcDLCfKPK+tuh3KBnaJXzOafITANvONX7HAwWdyMi7NcAGI+zX50BRNY4/IIq+O3E3+ufniueUL31GosrBgrcFRUZzovDG7IiKmWVzWqhMPjpDlhb9jY47OVhMKpQNHtE4c01ggByxTKuQaG3BOM4hDtRmUvg3HAX5wnSsP0hapnT6z1PzdMKo4WgaQb9XLcnKqTWOyP6XyQL1aFWDsRboqHdrGXrpSjCm3dTr2I78KCtmMUKmESlg1MgOL1n3qY33vZBLRusv8v/TdKGn58HLaxUmcOxoPcxkqjBkUBYxjigzDQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e52085a-50a1-4f7c-fa9e-08df1897aa40
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:58.7779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kJ+PwTgWzUOQldaG9FbbgTwGrkcREFn59JxnbLNYsZvqTX4Ge0fouREQiYoG7FSdHneHDQVBZXNRLzcaO0VZXw9VApg7njIseDzI1V9+2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX0Ld8Y3yiUC1v
 l7jBoW3Ppqz62fJ10l3yHZdevn+OYH6/nFba2RhbS8v/232O793Vq/iVsFflyps62n2lexdttg/
 NdSFOfKsHMz+UzFIUJUoVuR8C/jh6st+7flANkqtYqZM5ztNyDCOmgd3fxVZIYLUk7EpdrVsIb5
 eHbE9h9uKyPHAuHeBI+7td0+xszxGWeAJ87kOpIzSn8Oz23S3yjRLA244JVFr4hrrHV4G9Nl8WO
 ZxBxYFEfSbr1VGSaG2xWNZRf+1au/w6q2M5Syt+12beI2Tntz64nOcA9gGCZSV7H4aU44zUxQSC
 t5NDur9VGmNJVqyuSZIO76La0pnHakyfHC2XIpnwR22Km6sQpjZ7RC+Bur1Qx57ju2hSqV+VMfC
 9CRQsPHVN/mAxH64XC2hQh0rgFNdk3t/lWe+EBTtebzJqjknCveoeEtSwMi3C3FPfKr3w2VdATE
 ral74OueyyR1WalDzTQ==
X-Authority-Analysis: v=2.4 cv=E9BYNqdl c=1 sm=1 tr=0 ts=6ab25e0c cx=c_pps
 a=iRxRSAF+HohKiaZghI2QEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=BvxeoMvQQwQtu6Qdv9sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX29IR3kINrxvd
 P5W67yo0R562E+arcR2htrmyClenRZhjVrE1Rk97L6uHOZZxhUvCMnxvgw6ZDeZgsefAoDC3Gvb
 aTEIyfI9PPD5KkFbItkqh+LNLNFeA88=
X-Proofpoint-GUID: l5TXRs3NDq5kg1KPLbpbTucTBpu2f1dg
X-Proofpoint-ORIG-GUID: l5TXRs3NDq5kg1KPLbpbTucTBpu2f1dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that the pflash0 and pflash1 machine properties are class properties, if
they are unspecified then QOM returns an empty string as opposed to returning
a property not found error.

Before this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
Error: Property 'pc-q35-11.1-machine.pflash0' not found

After this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
""

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921113559.1299740-9-mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 8 ++++++++
 hw/i386/pc_sysfw.c   | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index cbe88a1788..8edec62a1a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -40,6 +40,8 @@ typedef struct PCMachineState {
 
     Object *alias_pcspk;
     Object *alias_rtc_time;
+    Object *alias_pflash0;
+    Object *alias_pflash1;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 37d199f2dc..b649f184de 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1800,6 +1800,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                    offsetof(X86MachineState, acpi_dev),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
+    object_class_property_add_alias(oc, "pflash0",
+                                    offsetof(PCMachineState, alias_pflash0),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
+    object_class_property_add_alias(oc, "pflash1",
+                                    offsetof(PCMachineState, alias_pflash1),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972b..441e777191 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(pcms), alias_prop_name,
-                              OBJECT(dev), "drive");
+    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
     /*
      * The returned reference is tied to the child property and
      * will be removed with object_unparent.
@@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
 
 void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
-    char *prop_name;
     int i;
 
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
-            prop_name = g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name);
-            g_free(prop_name);
             object_unparent(OBJECT(pcms->flash[i]));
             pcms->flash[i] = NULL;
         }
-- 
2.43.0


