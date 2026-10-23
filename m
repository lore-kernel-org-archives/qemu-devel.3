Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2E606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=2LYI5p1A;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=kk3ni7dO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGl6-00009G-2O; Fri, 23 Oct 2026 11:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGko-0008Nn-Sv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkl-0002dy-Ov
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:21 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6aFK3758148
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=S5luXW8Va3kCgHiPWlEfYSsmdIx38S4HFnfi91O0l
 hE=; b=2LYI5p1An/a+H8IJo+hl8e1lD3Wx7RVigwpgTwwXKpdkAxFCIOwS+sjBP
 kAVdYPJ/Vi1KrwY+r+Wjl/XR+c12aUojCDQu8bvkHdu5AR3+W7hMso0YhmmOajyj
 PThecEEnMCgiMW10QwxHXe9byprP1KkBGMFpSqP604vXkED7s2rN8PRTd7Gd4Ux4
 7Lp59xSyBZcpRsUCHUO/mtlRrp5vio7zvSUPFdjr1kfGW7esW2eH+XO3Gk1Kr97v
 TRRPc1TuaQXD4lXgXoq1/cTAcP1MLaOIdBcJkvZm4l3V1nw21KxoUwVLqRizoekc
 DmEKjnWB+BCyY8oRtuPlCElLJhKvA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022110.outbound.protection.outlook.com
 [40.93.195.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975d00w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLz4OASjknbq5F35S8OsZZqdKiZswb8hgfa5zM1YtjmS425/HkOwZg+fLhnQq/p+RgRhI29t43qBbOrH5xN0lu0wuOSw/YTGTeoptu/lPB9ekAwiYIn4Ldm37dsZyJZAplgmxDgo0m53Y6vXPnwNBKxlyL0XExqNQvhI0xqErXK5RUWqGR9POvP+PY+Q+1VVPrQd/u+V+Pv5sKrAfOjy77+6+bVPrzzerWFE36nxnU4h5hoqIpht+h1CW0/PoVB++377ffjdtziyW/vQk/RZAwR4TFJcwaOmloTJ5ce8/l97WnRYUkVsyv5KLnqMMVKCU3z2RLOUyiVoWQspMwB4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5luXW8Va3kCgHiPWlEfYSsmdIx38S4HFnfi91O0lhE=;
 b=LLk+uUj2P0HZY0No8qPvSftN2dLBaoUd0SNSdh21N4qk6HS13xW7ZudgKqVRhCUkaTW+7JX6CkKFj2Nv1HfwT2gpb+woIIbzWmL63pNGzlMCnu1erSV6VRrzEXkILDQwgLb8n8ei85VYYWhcKlzN8k91FCU5leaNZEEYa0dMk459PlB7mmrKCSz61pAdoTw52Y0sIJUUTLGGwJ/YOqLV34C1u6M0bDobTiCCA+U5CXCqGfoicyzb3bNiDJRnG2BIY1XmSrhtG8uHCM4nwrY5HV0RL2nkaT2koOUIY3S9lIZIoU66h5O4ScJddviu3mZYORg06DzHF73unIqiP5H7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5luXW8Va3kCgHiPWlEfYSsmdIx38S4HFnfi91O0lhE=;
 b=kk3ni7dO09zSJz9EfsyqDH5dg33oUo4gS6HtWXInjuCmVSa3VpkSfeaYQyrAKOrXStgEhf9aJ03o0q7BJCLObpEAza3Lp7MpWcGeWo0g24aeYVCweXK8Qbq4yIHC9IHgeTiDvArrRSz8sdZ8myZxXDpl3sLUwK7a6pzooUaPyeH0/ymXbpcZw+tTablQmnFsvA6GyX4dzdc49Mi7t14gItLOIXOApcKPXyIlXrN+8FnK1XarNOb16r2+eln/auC6bKyzbK5K+S9SXRagu+G9fPHOl90lg1ME7izS+D5byCch381JnPKhzXy218Yr6MiO+WeK62fzYi/qyCqPqkqavw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:00:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:09 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/28] kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
Date: Fri, 23 Oct 2026 15:58:27 +0100
Message-ID: <20261023145839.34909-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce199f3-f08e-483a-5266-08df311654e0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u7FXzOPdL+K0J+xVnbSE+rsZC3lB/zrcpieAKO0ard2cw6xX73r1axD9xj11z4YmWnigL+9SNq37jtyWHn3p5Rjo1JbpoY4HR644nKcIv8wGXq0KPDQDt9sGMs13n7nUSeyGj6E8gWubZqYLtjmB6PzfW+NaHOcJervcbcyvFGz1Dbbz2In5XXe/Py6erchxOplgSk1Nxbz7+L497c2OqYUdUn1etovXSKVTthOo7Ii5cQmq8wnOzQNJI7sbyGVVNdIn9JOpW01wUOfdrk1wwqOqyHn+vlkAlLLKBdk+URrQHlrLwRxTc39ueCLRIgcB1/brnIOWViB0nm1Lmsu9IVE9Q+MiVXiq4SX/KeYDW3zXIXvOjI0toc/w6aCHwqfS3CBnCXtmT3UOJ90OwK4KpFYGklmIHon+3pl6+5ZrH0DzAsCK1En/4IYAQvYO7pD5iHqMx8y/X6lNUIHzskPI/1bQZpk+OO4egDBN2umpegtJE1CLEKN37vDzBSXjDdrkVRClTzbrYAi0aLoZ+BTWrtrlL9UfWfzBGJPTMqFLj60W36NNPiZb/biXVzEzPKbdcyOF062R4YM7L7IY+5eTdSkhPCIhsALsvgin3rMDyliSAzNbCFzAxX/JOmjV8Ik6rARnlh3A+IvUqhDMaM7V8CM2hltlB2uQsoakrjvzJ7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8Op3Yiw2iRlEJDM7ePH9yJPJe3jTrADkualZe3LakIQXhLukzVDoxzi2RyN?=
 =?us-ascii?Q?vS9tby1NknzcZ29bOkieEckqWq0SnM+WRDSqa4dikYhxdWViXIut7LRxNfai?=
 =?us-ascii?Q?hPanY/KtYXNOWtiZnuFJkf4k8UF1xpN+oNTrOboWkKb0VzDhzguOXgHden7Z?=
 =?us-ascii?Q?QpgX0ZgGL1nkzu/zKEdzAbkimCLEnsipaOw3QOwIAio56ykTLbQV2djaIu15?=
 =?us-ascii?Q?kd3Urts1M94EoCmqSeaQYMgYcBTf4S75/CpqZXg1HMn7s/OcNwzGZ3xuXoIj?=
 =?us-ascii?Q?oTafAGPXzlKD0sD+RKKUO2JxiiqdI2OpEhf7gfd0EFkIYgBWAt1CwfcqTvYC?=
 =?us-ascii?Q?EKZ9e5Uy6Ty3Qmrpg0RGD8fJXS4DfTYkUBDQoOBSs//iCwOsJm/SrrDJ5Mu8?=
 =?us-ascii?Q?xLQHpDb2Hmkx9SAL0Ce5HdEQr7NvLldaitEokWJzlmn4hRm+d6iOc38OygTX?=
 =?us-ascii?Q?T9cTpfxzUISX8R8sMFuR4+M4R+CJV1ORqUFqk9IRJWYonImpprvhj807a/B1?=
 =?us-ascii?Q?W0dfe2bUnQGhazkC99w+2wrJE4R8k9liQpwxPiFaNeFzJqw8dbdR6E6Mu7R1?=
 =?us-ascii?Q?ZG+n0OyJq9F5cyFt6Xza1RmZmVosghKSuNbA5NNMj/szw6ARMG6fBZZatRSI?=
 =?us-ascii?Q?tEZDKTkvtBPGPAmbEUGImIh2AbGc7JSVqklmnBle+tBuYbFeVnTL1BkFItQV?=
 =?us-ascii?Q?0lQ+wJK82lZOhln5xmCbSuECoBPSjzHEu5/knL1k8F5CO3nXz/mC+I859Sfg?=
 =?us-ascii?Q?oPjarQEVsOuZ0lyTjjMERAlIomTF3zp3g0nZ9rAiECxebbAU/GDZS+z/m5YT?=
 =?us-ascii?Q?lZNwlE80K5oB31w3o6bdC4cpEC4p6nhDcuEeg6E0XFEZIxVrcCa+4esbC3tG?=
 =?us-ascii?Q?4LLP37KCcsBQ93tmJQn7Y3S4t2OjaEDIGl1bPfZlLZh/4YCLqb6j/7rxI/1a?=
 =?us-ascii?Q?sNpv++U1R14t6wIgsosnVqeLozDHAPj4huX7ocDGf81cZDyaH6zmUClvr0dD?=
 =?us-ascii?Q?fVIsz2zy7cq4hpWrbzPo/Wv/PbScZHueN4wEPuvmwQs7RZfxM/E6edsKiOvU?=
 =?us-ascii?Q?QeMC4vK7mCEZwMaWBKXHJwbkzcuMBv5NzuVcmFhTEmD2DZMdg9WR3L7zlj2f?=
 =?us-ascii?Q?P+Z5P7cXUOLiNAr6ykEZAkFw4oPi2y3O8PuVDNNuJk7wqdhQ5f/X72axRtnq?=
 =?us-ascii?Q?1XNcEVnaKTv+nlmJ2G0RY1PqEzBfGOWP48RTYq78VgGW1h5olWWeHiHytExl?=
 =?us-ascii?Q?DPBk6xrN2XcDpAo8Q44ja0kXU3NXt1fehN1uGsigYmZ+Jd3OAh9T+psbxk00?=
 =?us-ascii?Q?dLTzJuSrWFruzi+waWpFxOXjf3tQt0m9rlHFJ9TcCS+/NqfvjYPhUgAnS4t4?=
 =?us-ascii?Q?iO+mQSJxUftOk18fjkyDj+/uMvHxmcb9FGnA8VFR1A+UZngY2+FnACzkZvgO?=
 =?us-ascii?Q?61vSgVqOS3y7ayf5hcG5axowQKRscvnOk39LyIeZmjKgCXfxoO2b//Uh4zlL?=
 =?us-ascii?Q?BJGqdDOzgWWhUNlkQujAvkFfwKBdi8EGEtJN7X2Wgfh2fuFLNC6PXVQ0UeB/?=
 =?us-ascii?Q?pQ+lDDjstcCIy7sIoN4EmiJyrtU3cz3Pe6fbQxfqq2oJhAMnUkbEW2Zzcent?=
 =?us-ascii?Q?E1PjG52YfvJHNedWxzwl6BY0ZDjBHDJjzNO3XyOc4+YU1DogyVdQEM+toAQD?=
 =?us-ascii?Q?BXavffVHLvQw68T5FX/kkNsHWToLOx+ZFTWx1qmo+Tn8qQx6bLVvoyORmbOX?=
 =?us-ascii?Q?ElQdaSMyw3qHtY/6kkWzeMT02V7gD7g=3D?=
X-Exchange-RoutingPolicyChecked: L2duFi0lXv2sLn7ZyYPg0GTqy06uBwj/QILboCoVfZWFw+Ha4ylexnDuuEH7Ec0Cp1rzjVaN2X9+CEXBn+Id/v63GZqJ8bGJKxdjhA+M5QHAID7iMnWgMNVj3qnqztk5+a30Du76r/a1I4t3pD3QzmaQWyJVYknHN5cjtl1Ks3G7mcApoutGFytwyUcCx4ROSe+dXOTJu0gxQTzKB8u4Zkv1Bw0S4C/qIxI1BYUcGgTrtC/KgEIhlVCtgj/Po6EzFtsJfMMZH2OsX8SdKS3lhedpWMAkJaCRdzv55I8TEr8mUyV/c6342cTdnoMRWuagsvlZQEFrUpkIQYUTcdas2g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce199f3-f08e-483a-5266-08df311654e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:09.4464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHvoOa0E3B4SiQ+NkXSaQWR3gxG2PLJJjH+4l+Bt96jmsmS+EH3djKskciKfJntE6JjT6FBAoiBnBxdrIUg00AY7ReqSlyH2qKzumwpVcmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7681 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=CV9Lyex1vB-al1NDbmIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX+9aeUTcnKiHE
 KJlia4SDjhhVQd/tOKGEDoCoVBOI3KsDlv2fcJ8kVZSkL3gvGouXL8Gah7yDVytsSeDXj6oW0MJ
 TutJtOlLoJzZzdMw+gvKZ1kJv81HqpcI+0fml6iWo7tLHdlh6rad+Hvzmv+m592UNI+O4E7ZvQj
 7lJJJcWNerg0+uwDq//XrNiVbGSuWnWeeJG0YqEwyFyoASxO8zvjyjqFW+I+7iNRG0t5DiE4JWT
 Yjfp5qSc5nvWEbSd81Y/2JPkAM8hNT6AiNRHjWk1uMMdu8/0c6rKwqQp1BzsoYz0rgBTOAByX1M
 g+AOWQhgbxjmXk3zaZM9ASpc7B8vpKsVrWc180w1NQJYqtauvZOFj4VGgEdNriKP0cgcNY2LmWf
 GriLfo3lHVmX3zmV7iIu6a5jy/5Fakj7ltA8X7CwoOEJPACuhfqukv9Za8YadXJ1/vOqLcHsC90
 NfN7RkmQ1/Txr1rzldQ==
X-Proofpoint-GUID: ZKv-QrUqEErHi6I3FohBgFs7Oe-8gQLe
X-Proofpoint-ORIG-GUID: ZKv-QrUqEErHi6I3FohBgFs7Oe-8gQLe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX2PRZWnp5/0or
 u3E0Ib0OD/KRqXmD9FaQhQXH9wRMjenEXxgmIJsBKvtW+tEhndQu10cx3HoewjW98zYqT2AO/Ak
 c4GYjzbDUDLIhl2GQBl6mS+eOLrIZJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This device represents the KVM in-kernel PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-22-mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 91 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 9ee23b5695..48282db58e 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -16,7 +16,9 @@
 #include "qemu/module.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
@@ -36,6 +38,18 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
+#define TYPE_KVM_I8259_PIC "kvm-i8259-pic"
+
+struct KVMI8259PICState {
+    DeviceState parent_obj;
+
+    ISABus *isabus;
+    KVMI8259State i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
+
+
 static void kvm_i8259_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
@@ -135,10 +149,21 @@ static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 
 qemu_irq *kvm_i8259_init(ISABus *bus)
 {
-    i8259_init_chip(TYPE_KVM_I8259, bus, true);
-    i8259_init_chip(TYPE_KVM_I8259, bus, false);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
+
+    dev = qdev_new(TYPE_KVM_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
-    return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
@@ -154,6 +179,59 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
+
+static void kvm_i8259_pic_init(Object *obj)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_KVM_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_KVM_I8259);
+
+    qdev_init_gpio_in(DEVICE(obj), kvm_pic_set_irq, ISA_NUM_IRQS);
+}
+
+static void kvm_i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+}
+
+static const Property kvm_i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", KVMI8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = kvm_i8259_pic_realize;
+    device_class_set_props(dc, kvm_i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo kvm_i8259_type_infos[] = {
     {
         .name = TYPE_KVM_I8259,
@@ -162,6 +240,13 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_class_init,
         .class_size = sizeof(KVMI8259Class),
     },
+    {
+        .name = TYPE_KVM_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .class_init = kvm_i8259_pic_class_init,
+        .instance_init = kvm_i8259_pic_init,
+        .instance_size = sizeof(KVMI8259PICState),
+    },
 };
 
 DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


