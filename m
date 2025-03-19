Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF127C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusQu-0006C9-51; Wed, 19 Mar 2025 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tusQs-0006Bk-9o
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:22:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tusQo-0003xd-Qp
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:22:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8frHB029206;
 Wed, 19 Mar 2025 12:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=AJ5WW41uVSC0i2oIIZB6GMKcnygDclhWud065iKt8dw=; b=
 HvcqeiOWOy2jcWVF1BrvR8+qSQ0D/dPKj2k0tQ0fd9pzJMhfy4UbMyzRo7VnHVSV
 hU1CkIc/v4mhX27SktWSPMZ8g1Bw9VuKqimqs+yyZHu/B/+jKZJScJecs09CyFz2
 1DT/UV2mx5E9rXWWY4uWfpVRjP6viEMaa5H+YkKuRKaeBNu7uPR+yggVEkNyAglx
 Y0xmGo3/+oaeypQ3l4cBR1ssM5oiJCKHxYLL4NE90l4AGqnzOWy8OeUNBjZH/5B5
 NJrJFrwj6QwqVLs9lmAmVode0qrmymabQYiLtqTiwt6fQ1ddkmzJ33alqoBwfKZr
 W/byh7irnNi6FDJifxAiJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbb811-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:21:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JB136V024957; Wed, 19 Mar 2025 12:21:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxbjuqbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5ZdSP7SUxeUvBsIIGhJlZwFPXpKBL2XoRlQPHdH1n7jU1SPABOkeNK+BUl2PxWzHPMfJPecVcIDSzUE2yElMZbipjZvw8IUTIJ+m1jfA39CPBcJnHDvgDUSjAOQ/ywvLOY1WeNEu92qf3z3aeSEFenMU8ivLX9L1aWK4gQ4wRwU0dl/NOuUqXDMxKQEXrghY7gnD8q7ea1RPRS+cjYY7rn92A1pSHqN+WDYMKFDcDKLGquZWJ321ou3Jo2XNVCQ+VZjP52QwWxpFwTO8IeeQPkznkQwNvsl4fq53H1NT3z3hc+0XC2/Wn1+lbvR0fWnMWxb95PJRmWi/tbhfuHrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ5WW41uVSC0i2oIIZB6GMKcnygDclhWud065iKt8dw=;
 b=Btlx2EyfXpaux6ZIFnnm6daSlf8PdVO3tzugO8CH23gsxG93vcmhxw3+uMhkBeX6m9L175jviVMsZtzf9GDQmYpfvcfDZnbpWhnVU0BucLzYcfQr4IDdeVrceXcn7fEOowRouc+4dio78fTBd92ZJv46sXOKrban6UrEa0XMB/YiX2K4ZV98oaD0mcu5tjzTW2mJizwEtoFSrq8CbcQ/1LQBgvG7hvdOHe3GU30AzuDmpPi78zseZYJU9IUBASWvokmB+jqwITxqiRRUESKOsbPhx/b/bjw69fNVsiXLcbsL7pkUCSxxoszgRNvwdjdcdyy9D4y+8Mxm2TnUQseyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ5WW41uVSC0i2oIIZB6GMKcnygDclhWud065iKt8dw=;
 b=rI8gH4qxqa4WjZyyPEQY/NwlqPHzbGFqy35Htm83I7jxl/WVkHroLyd9RgbRetoN+6cf5f3H95HQHajUYwVS/lmrbRw3FzHtjBW8vfieDigjse+8k5kALC6CEy9HGqRdG26m5X0LylAObqsqvgSB2Ic21ojOpxC9cQR8CXD/11E=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5872.namprd10.prod.outlook.com (2603:10b6:510:146::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 12:21:51 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:21:51 +0000
Message-ID: <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
Date: Wed, 19 Mar 2025 12:21:42 +0000
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250318095415.670319-31-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0123.apcprd03.prod.outlook.com
 (2603:1096:4:91::27) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: d9470861-afb5-46e4-f886-08dd66e0a055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1FMeEVKNGg2Ym5MbXpQaWZMVEFyd2U0M2RZK3RIYng4clJFeXhwVlE3QW56?=
 =?utf-8?B?VnAwT28xL3JqQ044M0lISndCU3UzRjR5MVJoMW1PV0x1V0hnM0RyTzJ1MW13?=
 =?utf-8?B?ZXU5dW85bC9QcG94eU54MC9BV3hCam1WTVI3NGw2RUdkbTZYSGVGcmRFMElv?=
 =?utf-8?B?djFtaGhabXk2dGRianBuN0hzVG5rN0s0Y1c4bUlFbXhCbXloVXRYWTdHYTF4?=
 =?utf-8?B?ckxOM0h1SDZXMnhhbmRFYVVUeXJhUStZTHZXS1hpb2xxcWpRTE5tT1ZXN1dE?=
 =?utf-8?B?V0FtdlhzdGJPcDVMTkZQWjVobjE1RWVXeEdVcUFPbmNxWDNQZzdEdk5QeEFk?=
 =?utf-8?B?ay9ObmJxOGxzSVlGME5yS1N6c0tZYXUwdlpSYjd4RVhhU0F1MXpiR1o4OFRU?=
 =?utf-8?B?Sm1Edy9RazBwZUNMelF3b3ZsWElpQUxwcEJTamlDMDdpS2x0Z1k1TkQvQ0pX?=
 =?utf-8?B?ZlhoYjV1M2lUV3R5c3k2WUFYdXJFd01mVG9EdUNLMWtsajE4aXpZeXdEVzJk?=
 =?utf-8?B?eWpiT0lRMzBtdDdyZ3FGVDhqQXhHSnJVNEJEMG9wb2k5T01MSEM3aERHZUJl?=
 =?utf-8?B?N2ZjdjV3ZlhUU2o4VEExSjBXaE9UeHVhZ2FQdHJ6blBvL1lOYjdrUTg3WXZN?=
 =?utf-8?B?cHhVTXlJTEdlRDczYTd6bHUzaGk3L2grdStjaEZsMjR4N0tiSENQK3hXQ2tH?=
 =?utf-8?B?OGtkZVdjMUEzd1BYQWMxQ01pZlcyWExXWlBIZS9mS014YWdGV2VDbHRxcElF?=
 =?utf-8?B?dDFyWkVJYlc1dnZWSS9ubFEyejdicWk1UEdLcVpRaE9XcjJndEt6US9pemk4?=
 =?utf-8?B?c3hQVGJKQjRTeU1BVCt4VmxBN3RKZ1hCLzUzcGVCajAvcjBwUzRCQ0w4UjNl?=
 =?utf-8?B?cGtDNVczeWg4amFLK1d5bGxIWGt0S3VrWXNxUUwrR0x4SEhYQ3JTbXA4YklG?=
 =?utf-8?B?d3VRd0c1Q0ptNVZkbWVXRmlrbTdSYkxZM29FTXBnWElmL2tkSTJGWldLVmtr?=
 =?utf-8?B?SUxyYzlVSGVmeGtTSy9hb1VybkIreWpNbGZvemcwRVUwZ2llN2hLWVZtL0Fs?=
 =?utf-8?B?QUxHa1F5aXNtNm1QbUlaVU1STTgyVEZCN3FQRWhHNDVoZ2tlS0ZKSytVUlBG?=
 =?utf-8?B?b0hYTjUzc3ZtWDJzUk1ING9xbnBQeDA3TERTM1pPT05aQ0xPekFSZnZNR1Za?=
 =?utf-8?B?Wm5KejlzYWRaRzJRM093QVJ0WUxFWTI5U0toOVlzcldyNnd5ZUFqNlkwOGZj?=
 =?utf-8?B?dXVDdGpxWWVaNkNvR29FR0wwNFNqYys0OFlmRW54cnd3WWREZDhyNnRRc0lt?=
 =?utf-8?B?Z0tnRnJDSkhPT3JzSE9ZZFZqMG1mK3VEbG1OZWZlS24yb0lEN0V2MVAxVzBO?=
 =?utf-8?B?SlpnM0w4bEFidGVBVys3SHhTMVlSeWRyUlE1M2VzMTBkTHpNZVFUWTBIVmMr?=
 =?utf-8?B?eFhna1k2T1hRVFFEVEdqb1l1NzI3NHgrd2FrZHREVkhESVJoQm9GNUZhQk5r?=
 =?utf-8?B?R2JsMjBPMzdINTZnc2pTamFPSXpJOHk4ZVlieHlmb2FNZUFPSjk0NjhKMU9R?=
 =?utf-8?B?eTU4b1phaVpEc0tXcjFKMGMvRGxjYVUxc2tHcWc4eExDRDhqNHdQcUdNZW9Q?=
 =?utf-8?B?R2hkU1RsRFY4OGI2L1lBYVZtanlFVUVOV0dlT1Z2WS96WDdaMGNXQTlpWnE5?=
 =?utf-8?B?VnBvMGlmdHR4UGttUi80NWhhYWF6UDJkUjJwUnl0ZjRvMzlNZjR1bXdHbnA3?=
 =?utf-8?B?a3hHa2ZGY252QzAwZVJWeWtZUThsQ2JobWdRUDZRQThNWERUcHJjdUFZalBD?=
 =?utf-8?B?c1NmcXJDakNmR1JPcG1kblRkQ2wxWDZUSFUvRjkwcElqL1hoNitxK25nOGJB?=
 =?utf-8?Q?M38SvgqvpUvPV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZQSmtueW5GTlBucXBQR2diVjMrTjF6R29GM0g2N1NIU0NKTm8wR3RPUEsz?=
 =?utf-8?B?SnhzYUgvQjRsMkRPVEY1S0JJQjFqSzlOUzkrdk9OSzVNNkRxdWVOUnhqb050?=
 =?utf-8?B?czdWVmxiWkwvUTBIZG4vSmZNcGpaOVhHb3lsekJRTkpaM2syTjZ3Y0taamVP?=
 =?utf-8?B?MkFISjJOQzJINFlkdzRHT1VMN1dLKzJrRnpiUUVWSlZ2amFzay8zaDlaR1FZ?=
 =?utf-8?B?RGVZZVJ1WWwwL3kxUmdtaTFxNXlxaW5TMzgvS05WcFNQMGVEOGtyOWp3Nit2?=
 =?utf-8?B?Q3B5VWt5VTdLT1c0ZGovd2E4K2VPclRvdEhmU1MxL0pVN0dKeC8xMlZLZS9V?=
 =?utf-8?B?M0N2eWR5M3ROOHFXUWp2VTJwZS9OTW9MbnZqemprM053QVlTZUVhRjZ2dks4?=
 =?utf-8?B?bHBEY0FadGYwQ0pidm9zMlhNTzlhMTZiUU1KQUhzSVFMZUNhay9tTWFJK1pi?=
 =?utf-8?B?dzl3WExFQXhBcEJtQTN5RHRTSnJPNHdUcUNHQ3JJaTUvWFV4dlRNS01jaTdq?=
 =?utf-8?B?Z2s2UHA3ZmY0S055ZDBFYno0SjRCSGp3Q3JWckdEK2ZaM2RLcjN0SFBWM25p?=
 =?utf-8?B?Q2pHNFJTUGdhbTFqRVBKcGtHNFYrQzlta0xMM21QdmRwbEpET2Q2NmRxWFQ4?=
 =?utf-8?B?SXlXNjRRM3AwWW81OXhDNm5WUFpYQjBHU09oU1BMQ3JJN0hmazFjUm5zSTZF?=
 =?utf-8?B?QUZnZXNOdEZTOFZ4WnpBL1pyK1lydm1GQ1RianozUnY4bGhRYk5vMlg3dis5?=
 =?utf-8?B?ejVFVndOcUhxUmV4NE1CZnlRSFZaanhQZjZ0WkhFMTZTMjY5VllXeEZSY09l?=
 =?utf-8?B?YVVRdlBTSXJtQUNkUlBzODd3V3c0VkpoUVBGRG95cHRMZjhiNWVmNFZSL0tD?=
 =?utf-8?B?VU1jb2kxdHFvTDF3bjBEVzY2OElDaWYyZmFkajRtMWkrazFVeDNZbnhqejgw?=
 =?utf-8?B?cEl2NHhkbE5JcFRYNjJzeXhGejZkNUJvdjE4bjBITEFINW40T1htV0Iwc21Q?=
 =?utf-8?B?WmxJSW1BQmkzeXpmbEpoRHZOOXVENEFTQjIrR1VkbTlKNjBWWnNrRm5OSHdq?=
 =?utf-8?B?NVRCcE5qU2JYeWxmUWJqRDV4UDNzY1o3QmVRdndTbnQ3U0prWFhtcUR6QTl0?=
 =?utf-8?B?QXJyRDFOc0RuZllscGNUSzk1dm1sRWFnb1NRU0lJcVNpOE9QZjYrMk1SQy9a?=
 =?utf-8?B?WXlJdVdId3poOGN3NE5VQjkxU3FGNXpTYjR0TElYZkozNzlwT2MvMG1PRldC?=
 =?utf-8?B?UW95dlhSNkh6QnRteHovdWcyTzJtMGpqbDZ2U2lRQm0vVnVSOFVocXlESjZJ?=
 =?utf-8?B?SHNSa3l3ZzBlMmNIaExFNXZXZTg3MkN1WFNDVnJ2YTNwbmFhakovTndEaTZq?=
 =?utf-8?B?K0lSQkxBMXU2Q0dIaGt6RzF1QUVmSThEMVpCbWg2YUN6a2dOUzgrUXpUMkww?=
 =?utf-8?B?eHNUZXgxYkhqMUFoV3ZGbXE3anJpb1FHYndaMnZNeGhHbERUY3JUdS9FS1ht?=
 =?utf-8?B?NStYdWNPbldlclQrYkNscENrZHo4WUZwdEY1SnFMUWVPcFBpWnZvbGJ2NHBy?=
 =?utf-8?B?QmNvTklRMzM2QjQydmlFcjdBU1YrL0pvTHErQVJWeExvWTZPOEZmTVNYQ1ZP?=
 =?utf-8?B?dnM1am1TUG1WWXZRV2F4ZjluQktzUE1vQUd6bFpGNG11ejhYcGlPRitKRHp6?=
 =?utf-8?B?WjdmU2lJY3diREhjd25hRFZtRDhyNWFXbndnWFlnQWhDT0RFbmM4YlovWmZo?=
 =?utf-8?B?WDN3STkvRGt2NUxpTDFrWno2WWhIMzEwcG1PQWg1KzVXY1hHTzJZQW9uZ09D?=
 =?utf-8?B?elBzbFk4MWdMRlZFVjhkYUhYWXVMbW96QXJFQWYrNEMwTy9jU3oyZEI5R2Yz?=
 =?utf-8?B?ZExWUnkybmRFMU1KMUF6ckwvWXRpWmhUZkxpcGlhV2xDNStBZkRBVUFNTXBG?=
 =?utf-8?B?dFY2VnJVYVhVbkxReW1sQUQzZzVJMDM5blF0ZlVLQ05KUW8zZ2xxZnpZcDBm?=
 =?utf-8?B?cUhIL05IZjZSN3lpM1FhUEdVRVpVMGE3V2Vkb3hMYlhmcU1RWUJUNHZWT3JT?=
 =?utf-8?B?YzlHMXNlWnpRTFZuWEtMRFIyNmpodUJzckQ4dmt4MHNXbDJFZVNYbitxd3Jq?=
 =?utf-8?B?czA2WE9LNWE0R1J4Z2UyL2xzaWFFNUwyNk9qbS8zK1JEVjF4ek54S0QvTUxM?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yzpCdnEazOCnYPXbcSdUYHnILwJ/FaMlrG/gVtaW9GfjZtPeIGF2oJ5eCMFFcG3n1LMP3GyWakNXspcXQS3VqKN22OfZCKzF+Mfcz7aQu0SoCtuJo1yA+Z5o/c+kh1wzHJvU/rWFSLwuWGoEMcmNu8l2k40gXubvXOuGhbNjcTVg8P1oDrp0OSoW4CpjfS7IL2G97tXKktb1iGzQpu1raahfaUHzK6n13Mh16MRshTkpnCQIm673z3a3U/1uTCFKtU+wQEepXUNZkQSVPLI8HJW1sN7TWOJcCU5nl9+8jP3vwABTHSP1ho8uipHBPE3XarDpp1lvnpikIfzHOrGqUG8JIj1tuegQhh+svgDzg1R7IiomhfxKfQP1jdIN4gRwq34dQwGOjjW+6ZyEcqnxVjKq8JwoHd7I4dsb2zwrqrgxHPRKWRadLgNFc6G7fG4geTRcwNEhuXMXm+YIVyro5xxEljkMzw94k3agG+Nb97nEXR8/RmZSyQ6hylGMZ34K1PZT8EbbJe90eDGRlCkilFcbQR52XbMOE6rncBe3SN7mFh7QhZdcCgGCdDUvvYDvhTt+AgDOibfa6JC86+yPdZCKtkSnXTx/Yv1OvjWeflQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9470861-afb5-46e4-f886-08dd66e0a055
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:21:50.8550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVErbIPHxtHfG2SVTyjHBmhAsm4/gjuHTN1pjw+LvBEi0eYrbKVWAyO0W4CYTFZ7tTzBV+2cr6URbvjQ9Vvqx1WWIYlyWH+yzjuJM6RsKN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190084
X-Proofpoint-GUID: hrTdgpGvoqBAMkmrcjoEZyPexItH5adr
X-Proofpoint-ORIG-GUID: hrTdgpGvoqBAMkmrcjoEZyPexItH5adr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 18/03/2025 09:54, Cédric Le Goater wrote:
> Rename these routines :
> 
>   vfio_devices_all_device_dirty_tracking_started -> vfio_dirty_tracking_devices_is_started_all
>   vfio_devices_all_dirty_tracking_started        -> vfio_dirty_tracking_devices_is_started
>   vfio_devices_all_device_dirty_tracking         -> vfio_dirty_tracking_devices_is_supported
>   vfio_devices_dma_logging_start                 -> vfio_dirty_tracking_devices_dma_logging_start
>   vfio_devices_dma_logging_stop                  -> vfio_dirty_tracking_devices_dma_logging_stop
>   vfio_devices_query_dirty_bitmap                -> vfio_dirty_tracking_devices_query_dirty_bitmap
>   vfio_get_dirty_bitmap                          -> vfio_dirty_tracking_query_dirty_bitmap
> 
> to better reflect the namespace they belong to.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

The change itself is fine.

But on the other hand, it looks relatively long names, no? I am bit at two minds
(as I generally prefer shorter code), but I can't find any alternatives if you
really wanna have one namespaces associated with the subsystem:file as a C
namespace.

Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
when talking about this stuff, but it seems a detour from the code style to
abbreviate namespaces into acronyms.

Having said that:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
shorter.

> ---
>  hw/vfio/dirty-tracking.h |  6 +++---
>  hw/vfio/container.c      |  6 +++---
>  hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
>  hw/vfio/trace-events     |  2 +-
>  4 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
> index 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
> --- a/hw/vfio/dirty-tracking.h
> +++ b/hw/vfio/dirty-tracking.h
> @@ -11,9 +11,9 @@
>  
>  extern const MemoryListener vfio_memory_listener;
>  
> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer);
> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer);
> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
>  #endif /* HW_VFIO_DIRTY_TRACKING_H */
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
> -        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> +    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
> +        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
>              bcontainer->dirty_pages_supported) {
>              return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>          }
> @@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      }
>  
>      if (need_dirty_sync) {
> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> +        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
>                                      iotlb->translated_addr, &local_err);
>          if (ret) {
>              error_report_err(local_err);
> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
> index 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
> --- a/hw/vfio/dirty-tracking.c
> +++ b/hw/vfio/dirty-tracking.c
> @@ -45,7 +45,7 @@
>   * Device state interfaces
>   */
>  
> -static bool vfio_devices_all_device_dirty_tracking_started(
> +static bool vfio_dirty_tracking_devices_is_started_all(
>      const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
> @@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>      return true;
>  }
>  
> -bool vfio_devices_all_dirty_tracking_started(
> -    const VFIOContainerBase *bcontainer)
> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer)
>  {
> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
>             bcontainer->dirty_pages_started;
>  }
>  
> @@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
> +    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
>          return false;
>      }
>  
> @@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>      return true;
>  }
>  
> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> @@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
>      memory_listener_unregister(&dirty.listener);
>  }
>  
> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
> +static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>  {
>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>                                sizeof(uint64_t))] = {};
> @@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>      g_free(feature);
>  }
>  
> -static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
> +static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>                                            Error **errp)
>  {
>      struct vfio_device_feature *feature;
> @@ -940,7 +939,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>  
>  out:
>      if (ret) {
> -        vfio_devices_dma_logging_stop(bcontainer);
> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>      }
>  
>      vfio_device_feature_dma_logging_start_destroy(feature);
> @@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>                                                   listener);
>      bool ret;
>  
> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
> -        ret = vfio_devices_dma_logging_start(bcontainer, errp);
> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
> +        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer, errp);
>      } else {
>          ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
>      }
> @@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>      Error *local_err = NULL;
>      int ret = 0;
>  
> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
> -        vfio_devices_dma_logging_stop(bcontainer);
> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>      } else {
>          ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>                                                       &local_err);
> @@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>      return 0;
>  }
>  
> -static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +static int vfio_dirty_tracking_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>  {
>      VFIODevice *vbasedev;
> @@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>      return 0;
>  }
>  
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp)
>  {
>      bool all_device_dirty_tracking =
> -        vfio_devices_all_device_dirty_tracking(bcontainer);
> +        vfio_dirty_tracking_devices_is_supported(bcontainer);
>      uint64_t dirty_pages;
>      VFIOBitmap vbmap;
>      int ret;
> @@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>      }
>  
>      if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> -                                              errp);
> +        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer, &vbmap,
> +                                                             iova, size, errp);
>      } else {
>          ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>                                                  errp);
> @@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>      dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>                                                           vbmap.pages);
>  
> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
> +    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
> +                                                 dirty_pages);
>  out:
>      g_free(vbmap.bitmap);
>  
> @@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>          goto out_unlock;
>      }
>  
> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> +    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                  translated_addr, &local_err);
>      if (ret) {
>          error_prepend(&local_err,
> @@ -1147,7 +1147,7 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>       * Sync the whole mapped region (spanning multiple individual mappings)
>       * in one go.
>       */
> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>                                  &local_err);
>      if (ret) {
>          error_report_err(local_err);
> @@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>      ram_addr = memory_region_get_ram_addr(section->mr) +
>                 section->offset_within_region;
>  
> -    return vfio_get_dirty_bitmap(bcontainer,
> +    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
>                     REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
>                                   int128_get64(section->size), ram_addr, errp);
>  }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" -
>  vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
>  vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>  vfio_legacy_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
> +vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>  vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>  
>  # region.c


