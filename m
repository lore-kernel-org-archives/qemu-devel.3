Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68D606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=2ZhUi7RI;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=OwD+lO4L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLHH-0000xN-DG; Mon, 09 Nov 2026 04:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLHA-0000vg-Jc; Mon, 09 Nov 2026 04:02:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLH8-0002My-5Z; Mon, 09 Nov 2026 04:02:52 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96BvCA372578; Mon, 9 Nov 2026 01:02:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=I/ykK7l4T/0IDFQA0wrdxU5V6dlFvL0v87ItvfLc9
 uU=; b=2ZhUi7RIRFDqtY2EVakDcNq+8GoIJzxVItgy3CwDduZ5YJ4kWrqAE6Mtr
 AtltbL09tpvzxdgdRdw6RImxnoD/FN/GAZMLgSXPzeBmhs1y6r5QI/xwDb/1E7aw
 Ztq6cwPJr24C37i/kOQ0n3OXWGcyMKxkfq1WyvyxrHbks9rDpKwxQbsvOWFMcx8i
 gteCYL08lbD/3PEOHtpqKVPu8GIPtleT5cJFUn+r2NoSdP162kHprXvDD+faTj5q
 unqoqANFCg9lQHPJK3utG2co6p2gtTmw9M4oD/sAZl0gOPQ3MvU3lP0HOz9PsdMs
 OFRSRVZbXlCd1U62LqkxLYJiSO9LA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023102.outbound.protection.outlook.com
 [40.93.201.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht16uth45-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 01:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRVTgX13mUMNcj3DAWjlavlAV5wDAko4h52/zkU6/FfqrDDU1UQIlVfaK90lX01TWF3dtRRDM/V8zbntctRM/MGzm5+XQCJsJ/CbJDnMBYZtaCHAclPD7l0LGR/uZSyGwPnOaUnZfDZiX3/Yk4BVAmIgwF4in5pHObGfH1ma0Et+x0A4zuxcq4v+K+0pNMlIucxWUBgXyyfSrKZ83De+oZFjGLjJflnBrl4biWKVVVyznqKpP/VU2zBx/YjdtCVFegtkMfGT/NUE8dV86RPwCXfISgjD2uLwb9/2jmKfiQPIMAWklBihPA9BsmkUg1l94TwetjL1pzFZ82CQK5ONxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/ykK7l4T/0IDFQA0wrdxU5V6dlFvL0v87ItvfLc9uU=;
 b=kroJ43X3lYXk7BO0Ytw4KDYNfMBKc5IOmIEVCL2xdhszAl385Nh67jWw+Ijg+Ri68WUT8ibK8TzjunAwBle/MMySNd9lWyT7QD3Xac2458UuN2xXs3y9v5vtA7WkNq1KOFiaSME03HdM85KmeeNsfd/r7yrtePAIFtpNkHVX1u98Z0gTSUqDxZHV8x5y8hbOM//heUbFkILtnouyfHwl5vE3YI/qxDY9cGnC0ZiIq8Jp3wccYDlb/K2l702pZCp3fs+MschGetWa+BKjBTzs8F582n6hQzHhA1npS6JOPkHHyqk/wtpmysesG05XTLwlal541qlijn5rrWvbBUxosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/ykK7l4T/0IDFQA0wrdxU5V6dlFvL0v87ItvfLc9uU=;
 b=OwD+lO4L0G2zl1k5owjzHROWp9XE1LxroWZIwug1zjTYwbZ9Hr17RhFbxMyfzfzPRyw+/MF9fRUidmbZ8FAVmXt1ja0mmVbl3ZjE466C0aSIa2aMcjjogRaNaErj2rR3JqP4ra35erLIDHau9AlJ8qp8B74DALaYySxOR09ItbCJkP/3sPIqmgL+hIJEVHO/IzZ57cViYF82JOkCxc71K22gnVZcQd/PI6e0H4mYFFcsjA4GBs9ihtlOeAtwBJpi2DV3zO1rEpNvLnFrFJ48OH8m5mK8RInNt9w6cHqRSZ9FYxRyP+AhQko3O4SF+0k6z2+KpSOA7Z5mIFoTanoXRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DM6PR02MB6480.namprd02.prod.outlook.com (2603:10b6:5:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:02:44 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:02:44 +0000
Message-ID: <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
Date: Mon, 9 Nov 2026 09:02:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DM6PR02MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: c8252d81-4741-4e86-91f0-08df3e40377c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|3023799007|4143699003|261102123227099003|261022075727099003|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: XsUff8reSFdkf472qTHBWwlx8yvugn0GEv3D/6Bs65HYwS7YMo4RTnKV1I4g0GKJRCAPo7O9BSDFVclv3szPLUptR5AHN6/XGFX/Auo5B5OF+BaVWpSVy3pR+fsb54GwvA6ZjXedVd/HwZVewSOMjwdHXTHbbOFpB8TeekvKflDOD0eiGop8F2az2/BTCey1/S5JSwLxqXaty7L3kPisgXYLkc/w4mu9ILoOyXMe94F7z0vVPXHq5dG9jCOBmUYD3HdM74EKdj93rI6N3MgM2/IdQoeTCmSHC5GDthsjNw/tphx74B1UzLkm0YH0W9MC/5GGwH/jvhuILXENoS5wXN9wXXqqpG8VM/0wQ+68l4Hc12z97xu8MhF1ymSOVTyIqvN8/pOeu3w1s7TwxTTMAxj+2zAPiw96mTeZqLfCI8cux+CHzNEf9ZOWOPmuYC4GogWzy7xWB2D4V8Y75n0HExCxr1R+W+VY2I6jzLdcjQPfWcizHyGE7DezADrmzyjvKMvbPNKC3W7x5lplfZzRq10M5v26EMymPDH3jCMbC0sn0t1AJzJaqRcI0W3g9n/QgbSdWMXU05bkJxjt3sJileiZT4Q+K0VvTfRBdWdXGdgysEH4+IEeXJeCoa2nAPcjmWLbpvnM6sMGEeAE0H/VJVm/npTnAAjni89r1s79Cuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJwSWdHZTZCVG1ONHk3cllRcUJzUDJ6SWJEditWcisrbTBmUnNkT1VremlS?=
 =?utf-8?B?SStVc3gvQ1AxejFadHZFQkRRMVZkaTJmbHMxR1QyYUpQb3Y1UVRBTlB3dFF6?=
 =?utf-8?B?bWR1Mlg4VG1CbE5FNk1VeWVoT2VXK2RtL0pvd2V5WU1FUTJPWk9HTU16UFdV?=
 =?utf-8?B?Um1Pb0ppamlucE5KaGgrNURNWmIraWJiZHdqazZoeWVKWW91VzdiK0lJSDk3?=
 =?utf-8?B?MzZ3OEgrZkxDSU5IK05CNytpU0JSY3lJT09zT3RUb1F3SzN2bVRhM3ZPdmds?=
 =?utf-8?B?U0RlSW02b2Y5NWpITnc5c0QzNXRIT1A5SjU4eWFIbnFobEdJdUp0K0NvdzZB?=
 =?utf-8?B?cTRyei83UllNSUJXN2NvTzNRS0twUXQ3QXMzVkh6S05kb05WaUFlQ0tkVDRz?=
 =?utf-8?B?c2E0bm9wZUZSQmNtN2I5VTNkWkFFODRrdzg1Um9lUlh4Z2E0UDZTK25BVTc3?=
 =?utf-8?B?eVNiYnJSZTBiVkZzaDdNVDlCZkVOeG9WVThVd2s5QzluVllTSGIvdzNONnVo?=
 =?utf-8?B?UnJtR2plaG1ucm9XVnkrMzVvbmRQMWo5Z2krVWd6YytoTXZDMmJoUVNmS1Vu?=
 =?utf-8?B?Q1VlVHQ4OGdnY2cyWmFwVDl5a0lSallxend1Nm1ENU1hMmlRdThzOEpER0Vt?=
 =?utf-8?B?S1VGWWg3bTAvY0F0Z05rT1RhcUJCNlBjN2NjRlRreGowQ1pGNnVGODhibXY3?=
 =?utf-8?B?bEpJZUlodFo0blNHUGNHSG5aSlZ4K3hXNUwveXA0cHdYY05UdTdwc01meXYy?=
 =?utf-8?B?OC8zS2dLL0tpNU1EOGZUa1pGR0w1K3ZYUDljbTQxbHNNa3RacytSSEJwK0ls?=
 =?utf-8?B?VE5ncVE2eGhLVzFRRHBDblhFeG9KZW5DOS9ibUlIWVIwN2VjUXZYYTVtZzF6?=
 =?utf-8?B?U1ZhS0F4a09leVJValZxTDdNN3dCaUJKWjdmTk1xZWNOK29ES1VvbjYraDZv?=
 =?utf-8?B?ZEJyYW1rRWt4ZGkrSDBQR0RjcFV4cm10b3hnNHBNQjdIMkM2OHNMZWlxWUNu?=
 =?utf-8?B?bTBTRm12TmZoV3BtN0s5cXhIcFQ2UEJwQUJTSFA3U0VGNEJzYllKdVVjNEFa?=
 =?utf-8?B?a29kYnBZQkhiM1hXMEIwMmpDNVB0Y0FNUy9rNUNPUDE2c3Mxd1M4Z2xSNG9r?=
 =?utf-8?B?Zi9Vd3h2L2VWMGJVK3EzTnVNOFp3L2VtRFZ2dG9kZTgrQUVITkFhRFBIbit5?=
 =?utf-8?B?a3BLeFplak9lb2tHeUZjcTJKZWxJdDA5Y0tCTDg4REdjU0NBWHdOZkFMS2Fm?=
 =?utf-8?B?bnp4OGo2eXF5K2hzY3ZBWVNLWVk4ZzNkUnluRjZtTWxhaTh0d3A5dk9ZNmR5?=
 =?utf-8?B?N0tuWHlxaGRuKzNqRUtXUkZ0ZmFTbmx1MlM5azRnQlNvWnZwUE1aU09RdGIz?=
 =?utf-8?B?VTVBc0FxYkY2WVMwN2NjSitQdlN1emhiUXRLcUVTcFNHVzZMYnByY2ZRTHlv?=
 =?utf-8?B?V3Y3SERIalFkTCtld2JGZVpSNDRlMHRPL2IyTzJjOVdjLzhsNkRCUDJQc1p2?=
 =?utf-8?B?WTFKU3VtL2dIcGZVZjdiYm1qakdHd0xIQ1pNc25IcFdIQ1JubkIxVDd1QVJk?=
 =?utf-8?B?NURGemZwdCt2UnBqQU1zQytoRG02Ym5ZUXBJbjlYT2p5Ymc3M3ROQXFuSE81?=
 =?utf-8?B?VFdJTFpiai9nbDNNa1FUVTdreDdrTC9PZ1JKbmpKdzlEcHorL0dja2g4QTRF?=
 =?utf-8?B?dXN4NVdoS2JBT0hOVEZqWDlVYXJLaUdsd3FHNzdWVGNySWx4UXl5ZTNxeHFx?=
 =?utf-8?B?dFA5RUtCSFVoci9rcWxobUNZMlpYZ2FYYTBWeE9OeUV4ZjVmVlJFRmZiaU5Q?=
 =?utf-8?B?cXFmWmFsazAwWmlyaEdDS0NkdExoVmF1RVdjVitxbG0zZ2lPdTBCMlY3TFVO?=
 =?utf-8?B?OGFZc3JJSmJZQkRUbkRjTVV5VURGOUNUL1liUzRDRzNXdnBWU2d5QmtRMVk5?=
 =?utf-8?B?ZGg5L3JrTndPVm13UUhQc1hOaEwwZnllK09aVGE4Y3Fxa0EzMzMvNnB0Q2NL?=
 =?utf-8?B?NGpUVS8rUkk2Q3NIOThsK3Fsamp3QmplVS9GZXZVVWNOVzF6ZlFxNklleXFE?=
 =?utf-8?B?djNRaW5sQSswelBEQnU3MW9DbmlVaCtPVXFlMWJoTGpvalprdU1ZSG0yRTUv?=
 =?utf-8?B?Z2FoajFNbTFtcmpxUFpaeHdDWFZuSGhCUC94bW1pMjBaWm00bnBZZjIyajRn?=
 =?utf-8?B?STVuSDhKeHpDbG9KZVN4L0QvcjQ3REVPV2hrL21yUVhUajdlSkZKZmY3UW9z?=
 =?utf-8?B?S2lSeW5ScjB0LzFLVVpVMmR1VlkwTjlDYXdZeW1ZQzhFK0hRd3crbVFIdWRq?=
 =?utf-8?B?N0p3VkJpZ05FVWhTVUZOSlAwVWZsVWF6RXo3U3VZejAzZ1VKR0VHUit4dDR6?=
 =?utf-8?Q?1ND+ycBuawTO8oRE=3D?=
X-Exchange-RoutingPolicyChecked: CCUMb5IDzOJWsUMW72yWp8/8iHdLe5m9nTjredFRIrJbYeujqZu6q4SKLWBrM6fhs4J0M4i4Z/cYgeZD/KKZJPi3P1VL1c9nbSQjTQ9zKQv0gpCf2goXeRqS459ZbqLl2CtBPCY2jxkLwj5NIBAe2PlgQmIsmn4nSFXuuFhhTvk5p/TTLY6sd2JLkkFxiGAQ0HD3k2CVISz3iql7r938XgQdW0AaCRzEKVCnOKgyvXqOxoIzwTQXqXnKLkxIB2u2NKvpU6AhlpYeqIjewY2DLQLs7LKV4asUFigHTGIJuBbzE0eDeI1Ze20yag9h1VDBwcgieKIRYJhoaXPtn+bCuQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8252d81-4741-4e86-91f0-08df3e40377c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:02:44.0596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0mRFYXC0BT/PzZ0E5EcM6XhrOJJT9vtOg/dTiVUCEGdRB/xJEOats+lvWXd+0OJEiuQySKOY5Vs+EFUt5l2UEloWGetsb0dejqb/3Q2QKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6480
X-Authority-Analysis: v=2.4 cv=YYkodARf c=1 sm=1 tr=0 ts=6af18c35 cx=c_pps
 a=V5lscarYawUrr6zEozVj7A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=20KFwNOVAAAA:8 a=OrYM-6J7qGsYkut1G6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX2n12LZA74BsN
 oTx2wygYf9NN0ugpeMzp3/ERIWnPPdvrGXlhtlsLwNRdkba8ztXfLe4+3Jrzv5Bj4kVyomBstZ6
 yps+T1IAAhaG3+u7p8PCjVx2yOCWjzbmSLLB+rrEf4F/qsIwrkBYDHztsNmeA7tI95nA73SH+Hi
 ta2/wDBKUFBNWcu82g0sujaWyu1xxIE6YGUPS5xLkY7P/R03gOT0rWHt7rJShRKxuFNxl3kAW+J
 N4VgFiZJcUpz2n0jpA226r1PvJvK6+PXOuiKLI8G9PiC3G8AAuWMQt+G1E4xAYvY6HkDKgSRsex
 p4Orui+HxKfkxB9C0ghc9x5PGRP9aY/+FeZf2YTTorvFkstqCu06BoJzDOJeeBMKBynwPRO95rR
 hCEM3X2n1dME7fFOd//zIQVBZkGyjH3iJhqbTXh5sq23I2v5VRnIozyY87HnWXuI25fuMJWQwP4
 q3GzrQrIqauJBf+MqUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX1N4RS2DPxV5b
 wSnW9rr/QBhmH72F1nbDtkat+Pen8dFKxHIimkp9xCKEaOHeF5UozPPWED8pxcDfynO8+GE7U31
 E5HkttMb8k14hq2Pk/GWpxELQXYdPXs=
X-Proofpoint-ORIG-GUID: Zj7ILwfYwytAsmMtw94a_eZQnEzrpvep
X-Proofpoint-GUID: Zj7ILwfYwytAsmMtw94a_eZQnEzrpvep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
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

On 06/11/2026 11:04, Markus Armbruster wrote:

> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
> "pca9535" a child of concrete type "pca9555".  This is inconvenient
> for the next commit.  Make them both children of new abstract type
> "pca9554-base".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/hw/gpio/pca9554.h |  1 +
>   hw/gpio/pca9554.c         | 55 +++++++++++++++++++++++----------------
>   2 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index 1b33a8a752..0d841ff017 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -8,6 +8,7 @@
>   #ifndef PCA9554_H
>   #define PCA9554_H
>   
> +#define TYPE_PCA9554_BASE "pca9554-base"
>   #define TYPE_PCA9554 "pca9554"
>   #define TYPE_PCA9536 "pca9536"
>   
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index caa73f63c9..1362b605c2 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -26,7 +26,7 @@
>   #define PCA9554_PIN_COUNT 8
>   #define PCA9536_PIN_COUNT 4
>   
> -OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554_BASE)
>   
>   struct PCA9554State {
>       /*< private >*/
> @@ -58,7 +58,7 @@ static const char *pin_state[] = {"low", "high"};
>   
>   static void pca9554_update_pin_input(PCA9554State *s)
>   {
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>       int i;
>       uint8_t config = s->regs[PCA9554_CONFIG];
>       uint8_t output = s->regs[PCA9554_OUTPUT];
> @@ -110,7 +110,7 @@ static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
>   
>   static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>   {
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>       uint8_t pin_mask = (1 << pc->pin_count) - 1;
>   
>       /* Variants narrower than 8 bits ignore the unimplemented upper pins. */
> @@ -134,14 +134,14 @@ static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>   
>   static uint8_t pca9554_recv(I2CSlave *i2c)
>   {
> -    PCA9554State *s = PCA9554(i2c);
> +    PCA9554State *s = PCA9554_BASE(i2c);
>   
>       return pca9554_read(s, s->pointer & 0x3);
>   }
>   
>   static int pca9554_send(I2CSlave *i2c, uint8_t data)
>   {
> -    PCA9554State *s = PCA9554(i2c);
> +    PCA9554State *s = PCA9554_BASE(i2c);
>   
>       /* First byte sent by is the register address */
>       if (s->len == 0) {
> @@ -156,7 +156,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t data)
>   
>   static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
>   {
> -    PCA9554State *s = PCA9554(i2c);
> +    PCA9554State *s = PCA9554_BASE(i2c);
>   
>       s->len = 0;
>       return 0;
> @@ -173,7 +173,7 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
>   static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>   {
> -    PCA9554State *s = PCA9554(obj);
> +    PCA9554State *s = PCA9554_BASE(obj);
>       int pin, rc;
>       uint8_t state;
>   
> @@ -182,7 +182,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>           error_setg(errp, "%s: error reading %s", __func__, name);
>           return;
>       }
> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>           error_setg(errp, "%s invalid pin %s", __func__, name);
>           return;
>       }
> @@ -200,7 +200,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>   static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>   {
> -    PCA9554State *s = PCA9554(obj);
> +    PCA9554State *s = PCA9554_BASE(obj);
>       int pin, rc, val;
>       uint8_t state, mask;
>       g_autofree char *state_str = NULL;
> @@ -213,7 +213,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>           error_setg(errp, "%s: error reading %s", __func__, name);
>           return;
>       }
> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>           error_setg(errp, "%s invalid pin %s", __func__, name);
>           return;
>       }
> @@ -274,8 +274,8 @@ static const VMStateDescription pca9554_vmstate = {
>   
>   static void pca9554_reset(DeviceState *dev)
>   {
> -    PCA9554State *s = PCA9554(dev);
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554State *s = PCA9554_BASE(dev);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>       uint8_t pin_mask = (1 << pc->pin_count) - 1;
>   
>       s->regs[PCA9554_INPUT] = pin_mask;
> @@ -292,7 +292,7 @@ static void pca9554_reset(DeviceState *dev)
>   
>   static void pca9554_initfn(Object *obj)
>   {
> -    PCA9554Class *pc = PCA9554_GET_CLASS(obj);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
>       int pin;
>   
>       for (pin = 0; pin < pc->pin_count; pin++) {
> @@ -308,8 +308,8 @@ static void pca9554_initfn(Object *obj)
>   
>   static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>   {
> -    PCA9554State *s = PCA9554(opaque);
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554State *s = PCA9554_BASE(opaque);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>   
>       assert((pin >= 0) && (pin < pc->pin_count));
>       pca9554_set_ext_state(s, pin, level);
> @@ -317,8 +317,8 @@ static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>   
>   static void pca9554_realize(DeviceState *dev, Error **errp)
>   {
> -    PCA9554State *s = PCA9554(dev);
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554State *s = PCA9554_BASE(dev);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>   
>       if (!s->description) {
>           s->description = g_strdup(object_get_typename(OBJECT(dev)));
> @@ -333,11 +333,10 @@ static const Property pca9554_properties[] = {
>       DEFINE_PROP_BOOL("hw-dir", PCA9554State, hw_dir, false),
>   };
>   
> -static void pca9554_class_init(ObjectClass *klass, const void *data)
> +static void pca9554_base_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> -    PCA9554Class *pc = PCA9554_CLASS(klass);
>   
>       k->event = pca9554_event;
>       k->recv = pca9554_recv;
> @@ -346,26 +345,36 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>       device_class_set_legacy_reset(dc, pca9554_reset);
>       dc->vmsd = &pca9554_vmstate;
>       device_class_set_props(dc, pca9554_properties);
> +}
> +
> +static void pca9554_class_init(ObjectClass *klass, const void *data)
> +{
> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>   
>       pc->pin_count = PCA9554_PIN_COUNT;
>   }
>   
>   static void pca9536_class_init(ObjectClass *klass, const void *data)
>   {
> -    PCA9554Class *pc = PCA9554_CLASS(klass);
> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>   
>       pc->pin_count = PCA9536_PIN_COUNT;
>   }
>   
>   static const TypeInfo pca9554_types[] = {
>       {
> -        .name          = TYPE_PCA9554,
> +        .name          = TYPE_PCA9554_BASE,
>           .parent        = TYPE_I2C_SLAVE,
>           .instance_init = pca9554_initfn,
>           .instance_size = sizeof(PCA9554State),
> -        .class_init    = pca9554_class_init,
> +        .class_init    = pca9554_base_class_init,
>           .class_size    = sizeof(PCA9554Class),
> -        .abstract      = false,
> +        .abstract      = true,
> +    },
> +    {
> +        .name          = TYPE_PCA9554,
> +        .parent        = TYPE_PCA9554_BASE,
> +        .class_init    = pca9554_class_init,
>       },
>       {
>           .name          = TYPE_PCA9536,

The basic change looks good to me, however I found it tricky to follow 
given that PCA9554Class is now related to PCA9554_BASE_CLASS() and 
PCA9554State is now related to PCA9554_BASE().

Would it make sense to rename PCA9554Class to PCA9554BaseClass and 
PCA9554State to PCA9554BaseState here? I think it would help make the 
hierarchy easier to follow.


ATB,

Mark.


