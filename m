Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CB6082BF1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=nGqbvOig;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=hX/pMDnV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQFw-00032v-B3; Mon, 09 Nov 2026 09:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQQEy-0002r8-7J; Mon, 09 Nov 2026 09:21:00 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQQEw-0002kD-12; Mon, 09 Nov 2026 09:20:55 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DGE0k1770003; Mon, 9 Nov 2026 06:20:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7cjzGndxdMSIVACln2pqL7tb9a3c2n8v6DcE1codn
 BE=; b=nGqbvOigo2L3gaON/G1sNF+ID+WCXdU1RFuL6+bXmjarmrV0YZPSIAvYw
 KRW0HHiICyJd3uc+o7k2Od8mO7hThJnlCHE+LF1VrhWtswkhrWthQ0QWmpmS6RUk
 1ldzk/YCIPsKovOpR9TwbQZIVcteHt1lt9TNN8bn8v93/aLqWxLEwuCMDioUVIbF
 BBanXwoSpATFa+nWE6KocBT04yA2RwAPDsEQmLLyXc4yjqvD9F2L96JnPeZQjT5+
 QF1LThAN+rx0fRbriqxMex3A0pQlyZ6zD/MdcixKcpj/xMm/omZ9g0V4vhakEIxn
 65jLgZ9zMSxlXrcNt6esrGyDFg6vw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022139.outbound.protection.outlook.com
 [40.93.195.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht4e1awq0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 06:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5MlpymxiCYZSegJKAAVMPn57aLNxOM4N3JkJNP7gyLETnOxFbWzmSTz30Nw9SToeZGEKX8l2wa+lCYPfVUQaWEY/yU2i+DdtmfojHGEJ7I9080s/BYBGDYi989F7egqAgFtoI3ETZFxKkQwda/z46u20V6h9Blohxi+UnjnXS0rCt/BddgxTFPfxKNAKazsSN88yg7ekdAA0Y1PevdlKa2OF/S2BX1U3f1030+ZpL6NGUVO6igVLF5bccKRRlQHG9t3xYTpeNhfBwv1S3YtRIFvjY7YJcSvEsc5sDmcwhkiPxGzF8pWZ8PTjW3eRFDyipN70B8DPBVgMpfM7Lbq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cjzGndxdMSIVACln2pqL7tb9a3c2n8v6DcE1codnBE=;
 b=tKqulJy8QDOnCWfmY2MUgaLNA6FbqgroRGboBJJmuPQNlzejLirL5cJGAF0RYvZoZtgRiAHiGDgJqQ63kajqtN8+oh0D7owvSP8HyQr7AOAwJ/q/ZOtlq6Nug3hqEz1/G8oEiNty6Iu2gS8Ji+BPmknhB6jGmIfT3DeA6RStFCkY0ExK4h0G03VIGmyTK4N3V+tkbxMv4Vcowxkn3qS4y7M1LzRcM/13tmKmJTkYNJpzberRCUFvG4Orf6kCrYwH8lp2I+MFNA/iypRZJS3IUXvgaD2CFCQQBAFMPA8/8n8DU6i6s69Gg554/eD9GG594W+o3p2swv8KRQoD/k4Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cjzGndxdMSIVACln2pqL7tb9a3c2n8v6DcE1codnBE=;
 b=hX/pMDnVsTMupmjlm/3bga8gZRaX8+CAoCSVJwFMI/Z7XXN5Z9k/M1HjMI3OAN1OY1kN26CGw+EUeqPP/z2VJdUE0quvJ4eBJNRlcsFwJe/gcDOJT8oFkebDhAEvWHoKy9o0sm7EqgJepW/QdEcXlUmPIfYyc6Ulex7dkXsB0A6PU9+ymMTBuVbytCG3Hk8HadkjtYuhUwF3sRzT6hQaT5dLGjhOWMl/UKW1IXWhhO8H+LGp0HEU6I7kJ3nQYLMPcqFItL19WjdVMU0wVfgcaQLXcFO2xYYO5PMxSC1jBGWimptLYu6Swt3zw3Q7bOIPac1MsCDLz90Wz445S7nGSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB7858.namprd02.prod.outlook.com (2603:10b6:208:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 9 Nov 2026
 14:20:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 14:20:47 +0000
Message-ID: <c686141b-4df3-4aab-9f02-17afabb0be1c@nutanix.com>
Date: Mon, 9 Nov 2026 14:20:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, milesg@linux.ibm.com, 
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
 <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
 <aaba798c-591b-4956-be34-e6c9653398c8@nutanix.com>
 <87qzgu43s8.fsf@pond.sub.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <87qzgu43s8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b6ef09-b07e-463c-55e9-08df3e6ca614
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|261102123227099003|56012099006|4143699003|261009223027099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 3SShUoSIuDdN78zax7Zr0Jm8F3ZqtS79LyZtGbMoAA7eMpm1FOFx/mO3xa1i7C33jGiUrMmLgElTmjBdA0qkQci1xkjEGsqywUUEWcmlF+gvIGmqs+TfrKxAP5nWPdYcWvFTaVVN2Oa5wJV+sGce2CxlO4EaZ5WMPKPMWgjBN4hZNKmoqp15GVhXpGA4yYhkSbYPzJ04YZHx2oD0yaLwFSEINaEfhn+6rgjVKskWKq+906ZKn/X7631opLPQoEb2aZKUD3hFw56P4eqVdxxqRwkxarhZw+p906NQhfSH6hM3YTRbGCfDKVWCocueoMxzjbkX4B5201rvB7rROMvqv0XSjeIQRsPLOCy6K2eujpExC0uHgUsi3MwiG033GnTuQSwHTtg0EK85e0GPs3eoP3hMwsG/aGeA7g5VxZcxM4X8lZ5B60sttn1i5nfeZBOEsa6neY6TxJ7DeHPBaHWZgAEd3R5m0kpajdLxYVdkdNvZrw+i1KTy+wpqqaZOC5L7NKDtiAiuC5IGhSZyTqsoZ3P6Atf5lLK1QEANdOeCFAH/kEgVNewARLYo4Ni/CZWkRzO/kopbJbvnnWG08Fjnc9apWEKMh5UN4GDn2IyZNcIjKNDFVGcn72cPg5NWSSM/9nxNCMwseNUuGAt6/VWTGaUIH6m7b8OE81PYIlujyHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(4143699003)(261009223027099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wko5ejE1K2g3cXExSzFqVWJsbXRSV1dnblNTQzlzNGFDVk95Kzk1Unh4dHVC?=
 =?utf-8?B?RWdUaGg3UXJZejVESTY3a0htMU5WR2dneWYxaFk0SU9jcWJoUWx2VFlYQVlp?=
 =?utf-8?B?TWk2OUxYZHhGbk5BRzFzd2lSVVhIcHVHTFdWMFpabXJMNmM4ejZmNmNiSFFN?=
 =?utf-8?B?dXpOTXRWa2pNdEV3Unh6UC9WVXE1VUVkZ1RHYTRIQXgzWkQ5blQ3cTdKRWNw?=
 =?utf-8?B?MC8wak0wM1U3a3dsU0xKeFV4NmFmSmgyc21aR095cnFoV0FSOG90VUNSczM2?=
 =?utf-8?B?NDl6WnJwVktSN3JONC9CZStkTzgvZ3BmcGlUMjlyM1FtcjkwRGVxMDh3YnBW?=
 =?utf-8?B?RDhNV3pPeWgwbVYrVTdudjNNNzlGSy8rOHZLWm9keDJNaWloN2pDMW9CTGxR?=
 =?utf-8?B?SjZvMmJwNkY2eERxWkR4a3Q1TmcvTmxrT0pjTDZBWlJyOEJKeURVcjM2aEtY?=
 =?utf-8?B?WmFqQ202SnNwYm9zLzh4NGg5UjViWSt2cnQ0d3pybmFQdTJxQWxHaGRMSXhk?=
 =?utf-8?B?YVB4Y09BWW52aEJZZ2pMSC8vbWhXZWZSTzYvMjhvWjlCU1pNSnlzVmc5NlhJ?=
 =?utf-8?B?cEhDU1haTkt3NllQMmlCMmlyTTFjWDJHRVprTWZQdVBnSGZoYmdaWG5UVkRB?=
 =?utf-8?B?STRVZlR3bTk3OGhTdkhqTlJWQ2o4TDJhL3pBMUd0UUJBNWUyTUUyZ05HOUN2?=
 =?utf-8?B?Z3pXWmM0NjlUWjg2YjJxNEhsSXl1TWRLWFlMOWJBUGJrUWEzbTZnVVBQY3R5?=
 =?utf-8?B?Y09kMFV5NWxIYndSMTFYTTE4ZGJ6OWFoR3VzRUIrMUk4V28rVlQrUm1Xdi9Y?=
 =?utf-8?B?WWs2SVJ4VWs1VktQZmtkY2d1VEFpNUoxWGcxMHhSNE9TT2ZpMmFMQjZvcFg0?=
 =?utf-8?B?VlZCemtPNjFyRmpXR243aHp3dEVuUk5QTlpHbzJ4a3hYMUNiKzc2THkzWDJQ?=
 =?utf-8?B?dS90dzllTmRaSEl6YkVZU3AyWGlRYk9qaitVRlJ0OExFaWJLVWtoU25scEdJ?=
 =?utf-8?B?RkRvdkp1OVFBMFZ4aVJPVWp5cnluaTFjMzVOOTdDRTJ4OWRKL3RRWndLWGlX?=
 =?utf-8?B?ejg3S0VLOFJrS1pjcmN0YzJkL1ZwTWJhWTQrcGQ3RWlGYmU1eTNrTzYyaVJB?=
 =?utf-8?B?Q3plZmhUODF4ejEzcXJXZE1DUkdxTmczT2N0U0UrQmdxTkZaaXFtRXhSeVFt?=
 =?utf-8?B?RkE2R25zZmRSTzZPc09VOEVuZlhtZlpINVlDUkZtZi9pc3Noc0NSWFR6V0V2?=
 =?utf-8?B?ZERXcnBLL3ZVOUVJb0ZSWE96cExkSmpJRnBaTVdjaWhXcnJ0a1F1MEQraUw2?=
 =?utf-8?B?dmtRbmpnNWRKalB0dzIveXI1Z1FYazhyNVNsZlJCdGlLbHZSTGRSYWhOTkRq?=
 =?utf-8?B?MitrdjdhWGxkUmFxUHpqRE5ZNGdOMGhROGh3ekFKUXJXRitwTnVVK1AxMkxl?=
 =?utf-8?B?WjNBbzh6eGJRWEk1ODlQSVc4OEdsemxsT09MaUVKTFBVZlR2aDJjVGdvdEZv?=
 =?utf-8?B?RzduY1BYMm91YzloV0lpSWtLcFVmYUYrZ0Ezc2xabi9zQ244Mm1WL1dqY0o3?=
 =?utf-8?B?N0JTc0RQaEd5dW9GT3N1a0JweVFSVnNCM3pxYVFwZDVnM2szTmk4L1ZNazFo?=
 =?utf-8?B?d3hiWHIweHI4eW4xS1BhODlFRUtCc0t4bmdoUjEyQTMrMTVLdUw5V1NjVWVP?=
 =?utf-8?B?YkdsT0dXU0FHWFpTbDJIam01bVRRbEt6bml3bm1JMnJ5WUYyL1NEczgxTVZj?=
 =?utf-8?B?WjhORm8vYUg4YlY1aGg5eGRHMXhUQTlyYS83VWtGeXEyaGpwMndtT29SQVpv?=
 =?utf-8?B?OUZXSEtDamJ6dVhmWkJqTUdMTHkybk9mTWRYRHo4MEZteWR1c1lkV2dOdmsw?=
 =?utf-8?B?QktwcDQrWnUzaHYzQ1d2NWh5N1RuWWFuWDE3a0dzNjA0Tk1URzVCVUZBanNi?=
 =?utf-8?B?eEVER3l2SDZMSktIK0NJWFh6UkMxUnhRM1lwTjg0d2xoT0NPNGNCdm9wMjUw?=
 =?utf-8?B?L01oUm8yc2FmMlZCaGZ3Smc0TmRHbjF6dFViZ3k1UjRDVkhLZ1dsQ0VVblow?=
 =?utf-8?B?dVVWUUJSbDIwZUdXR1dncVhsRkpITUcrbk1sUUxTWjNDY3lnYVZWMlh6VXRy?=
 =?utf-8?B?UnZNRmI1ZnYvajNBNGllKzRqZDhBTy9PMEtRNDEvbEpVV0RrMm45RmdGdzZ0?=
 =?utf-8?B?NEQ2cHJ3cFpEMTZaK3Y5a3JvbzYvUXZTOXNVSjRzUTRDTzRMVkJKekRTSkwr?=
 =?utf-8?B?bDllREROUDNmT3d1U3J3a1BVNmlHVE15WVNEYkxCeTl3enY2bGNtODVWUXkr?=
 =?utf-8?B?UkVLV2hqS3h6NXJjM3ZyRmhDL2hqSDlqK0JsbTdDamh0TVUvd1ZWU3lKZHZQ?=
 =?utf-8?Q?5ZwDh8hmSZsiorO4=3D?=
X-Exchange-RoutingPolicyChecked: YNQ1l3xloQBaoCQeE/gNR4ntL99ap2ZMArDcUP+0MBYtbTdK9Sl5aywG03Wds1AJWdoHASWRNYZO9GAzj9LPVPWg40GxMSVBG/Ps27pUAEtZFA7Y+MAyIUAgwPhaBdhzcMQ9TAvE7KHnMl2u8ALITGUdqig9obeHg4pumEsV8n56dzk9P41pTtw57olXMb/iIpv0Lml2XnpBH/IMe9fElNvb2SsQRUdXnYanWMB6cKY1hO9hBx0LZYyiufyddX0vNf02KDr806NfINzSxvdjuf1j4PgQo8Z+2CsY4+dQBOw1nJbBa81XVM9DeWIAZwP95yMdvNEABDc9o3Pwu/bJDQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b6ef09-b07e-463c-55e9-08df3e6ca614
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:20:47.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Wg7iY6KVKZbXVNk8LC0iaW+Ct8SaKZEGuIqMxfDFRa0617SjN5hTmnD9Wr1KKOHUx2WYrvv6MCVjXAiOsZwd1QK8nmqxk/0zgC+lD6vaZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7858
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX3lDJqh7oFkd/
 6WNa7f4gzl6SLxubDpi0mbEPbrh0v+nwTlnvyJ/ZNI8wFnLynHRaBni9NaoR/LdzYF82JpmhNm2
 ABWHGWqFdVw6WvVgfpEHJpNsT5NdaIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX804dz9V+xBDu
 Kf/O7yfDONvvmCTDgaWrtEyFje4l5mNriNxxpgJvHzbmRj6eYRHyukvXaV5TNJezs/phJal10kB
 R3B/uS5sRqiQcUMZFvAL2SituHtcm3uhnBHSTCUV5N/sBClHp9INZ5wkUWXZayvNr6N3GhxJOR2
 UnztJfNbZxJp6w5KP9fEC7MC/TCyOAo/MkihD74wFeDh6e25mtzw2eoMRNHrYXO2OfLSE62sWdw
 aAi1f9gYCy9vCafSJTw+wfd/7XQLdJCVhr7LE9ej8KQ0mURNPRZ4uFl5ZuaR9dc8M7/qSEmpTBv
 nfKaHwiK56Iq0vnqjXC/82SPQTtFoduxzALWgACfAKUU4YmdgtkLKiNuKlOUZyXUatW2ofFnE/3
 krHUbjtF26BbEW8caWu0BkCJC+2QrgKKvX85GAeqSdApV1gnAYYl8vH7S3zuziiUNKLdl5a6s5r
 243oxq+322BDR3Hwd7w==
X-Authority-Analysis: v=2.4 cv=eJ2GH3p1 c=1 sm=1 tr=0 ts=6af1d6c1 cx=c_pps
 a=2IlhdGxtQGNhbQsvp42KdQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=dq4e4f21VRIf9CvKBBoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YF0O5yIHZ4_D39Og0wRP-TZ74Rtc51O2
X-Proofpoint-GUID: YF0O5yIHZ4_D39Og0wRP-TZ74Rtc51O2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/11/2026 11:56, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> 
>> On 09/11/2026 09:02, Mark Cave-Ayland wrote:
>>
>>> On 06/11/2026 11:04, Markus Armbruster wrote:
>>>
>>>> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
>>>> "pca9535" a child of concrete type "pca9555".  This is inconvenient
>>>> for the next commit.  Make them both children of new abstract type
>>>> "pca9554-base".
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   include/hw/gpio/pca9554.h |  1 +
>>>>   hw/gpio/pca9554.c         | 55 +++++++++++++++++++++++----------------
>>>>   2 files changed, 33 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
>>>> index 1b33a8a752..0d841ff017 100644
>>>> --- a/include/hw/gpio/pca9554.h
>>>> +++ b/include/hw/gpio/pca9554.h
>>>> @@ -8,6 +8,7 @@
>>>>   #ifndef PCA9554_H
>>>>   #define PCA9554_H
>>>>   
>>>> +#define TYPE_PCA9554_BASE "pca9554-base"
>>>>   #define TYPE_PCA9554 "pca9554"
>>>>   #define TYPE_PCA9536 "pca9536"
>>>>   
>>>> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
>>>> index caa73f63c9..1362b605c2 100644
>>>> --- a/hw/gpio/pca9554.c
>>>> +++ b/hw/gpio/pca9554.c
>>>> @@ -26,7 +26,7 @@
>>>>   #define PCA9554_PIN_COUNT 8
>>>>   #define PCA9536_PIN_COUNT 4
>>>>   
>>>> -OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
>>>> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554_BASE)
>>>>   
>>>>   struct PCA9554State {
>>>>       /*< private >*/
> 
> [...]
> 
>>> The basic change looks good to me, however I found it tricky to follow given that PCA9554Class is now related to PCA9554_BASE_CLASS() and PCA9554State is now related to PCA9554_BASE().
>>> Would it make sense to rename PCA9554Class to PCA9554BaseClass and PCA9554State to PCA9554BaseState here? I think it would help make the hierarchy easier to follow.
>> Another follow-up question: how is PCA9554BaseState related to PCA955xState? The naming suggests that the latter is already assuming this role.
> 
> There is no PCA9554BaseState.
> 
> Have a look at the OBJECT_DECLARE_TYPE(), and its definition in
> qom/object.h.  It does the following:
> 
> * typedef struct PCA9554State PCA9554State
> 
> * typedef struct PCA9554Class PCA9554Class
> 
> * Make g_autoptr(PCA9554State) work
> 
> * Define PCA9554_BASE(), PCA9554_BASE_CLASS(), PCA9554_GET_BASE_CLASS()
> 
> Or let's approach this from another angle.
> 
> Initially, we had just one type ("pca9554").  It had its own class and
> instance struct (PCA9554Class and PCA9554State), which came with the
> usual macros PCI9554(), PCA9554_CLASS(), PCA9554_GET_CLASS().
> 
> Then we added a second type ("pca9536") as a subtype of the first.
> Instead of giving it its own class and instance struct, we reused the
> existing ones, and we didn't define any macros.
> 
> This patch adds a third type ("pca9554-base").  It is abstract.  It
> again reuses the existing class and instance struct.  However, because
> this third type is the supertype of the existing two, we can't cleanly
> reuse the existing macros.  So we *replace* them by PCA9554_BASE(),
> PCA9554_BASE_CLASS(), PCA9554_BASE_GET_CLASS().  Except this is actually
> a *rename*, because we still use them same class and instance struct.
> 
> Summary:
> 
> * "pca9536" ceases to be a subtype of "pca9554"
> 
> * "pca9554" and "pca9536" become subtypes of "pca9554-base"
> 
> * Their class and instance structs remain the same: PCA9554Class and
>    PCA9554State.  There are no new C types.
> 
> * Macros PCA9554(), PCA9554_CLASS(), PCA9554_GET_CLASS() are renamed to
>    PCA9554_BASE(), PCA9554_BASE_CLASS(), PCA9554_BASE_GET_CLASS().
> 
> Questions?

Well just the one :) The point I was making above was really about 
PCA955xState already existing in hw/gpio/pca9552.c: it seems that the 
common parent PCA955xState (and also parent class PCA955xClass) already 
exists for this family of chips, and in fact the real problem is that 
hw/gpio/pca9554.c doesn't make use of this.


ATB,

Mark.


