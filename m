Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8DC606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=LugmGIYS;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=AJT+TzDU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjn-0006K9-MZ; Fri, 23 Oct 2026 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjm-0006Jy-Fm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjk-0002Nn-Rc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:18 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6aFA3758148
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7O524UHXKpct4YUfwt0YqWPJe0BG98st1Z/IHjO+w
 j4=; b=LugmGIYSBLk1628RDJ5n3akSeHesOc7k88jUtCK8Y8oMAT7vvCadf2x+P
 JwiMYDQq1qzDE+B8ZvNdCIMw37N92hX2PYlFkc/gEYbWUY4dLobiidbzHYGzfAHb
 FSmNkE1bd2bdyQMSrXz+Gbj8QQN7tQgK7x3A/AHyzo0Uhy0/zkmTX2OZu+UrJaGd
 H/o3zfIN1CEPxSvlvc2hLSanJ0UbZYd40lpEfkxzOR63GFwMkn5uUKCfyh6vhF9M
 UrrkHzMnlJHGWUY0ZM7uw5R/U/jF7vqE0VU+rIOEiqsjpKdFPUGTHmzQ7NTou0uM
 En5yEZcmVwOWO0ZWYX9/9Jr6Smupw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020093.outbound.protection.outlook.com [52.101.85.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975cywa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4FdkNg59PtUFAuwS8jDDYOp2VDtMcb4/Ip/MIP1z2CbT6pM7uLg1koeJFOxWJxJx4+SxrSQeOQh2KeSaKpIu1PYFcemIF1tOb67cyGMajS8mPPfZ6aJAXVIpvf40Xv+kAUhxx/vgG5Jk3w8F9wd75wBeiOor3yZ3nGzfSvn6DQt0rBNXYQyA1Ct5few80nJ73JXY20xxvmbNPJJj0x9cL1+CNUgYNy1RIDWazm30diyIjYUlowRCZMTA+BeQBeu7wt6d+DsZqgf3Sv5TlFtGAbkE9oc5oUuHD6/pQ1UCzwWpjuFxfkjnRx+1QxHhmcGgvTnbxohkhnkygAyjuatAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O524UHXKpct4YUfwt0YqWPJe0BG98st1Z/IHjO+wj4=;
 b=uRnF7/YBwPWCFqU6Wk70T9dngWWnaLCvCa/SwEd28DYsEKMcM+iTcQ9P9s/kZJ2PuRW0Z9G/rlKpnMHO6DWTNUZZP7YGUJVN8CLZVTiVD/lYq8EN+g/VIExIlExU4rKk/i1/Z76uyGF4s8Vl2afgZ2lPUMy+eJW1pHuRQloSiMXeucziM7SOxYb5c8KoTEg8l6bCkSDTkCwgOjzzNcSRPUA0/r6H3Kkat/e/LbOhqB8fcfRvsasxkWUZakkiIeyFNo516njTpfr+G5/iE+jcvUJBiuPyWRf7V4umklRPAK470XJ1YcIP7XCiGly6/oHguxWzqzwL0kg568yQGoMLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O524UHXKpct4YUfwt0YqWPJe0BG98st1Z/IHjO+wj4=;
 b=AJT+TzDUnDZYXS5jb2/iS2iN1E4bmwMSeXfDVCEUlPhmsze61C6rXjhmBQzxY4IZfYJfict16W0pWBr5SGgoT6v6ZI/VPhCFWuMuveHNWPNN1g1sOJjdxccNxUvxbrDd0CwgZlZQC3JxZqyGyyMzDqPvBEAUCE/bjrNSscI+Y0C3De3T4MdjqWjIGnUk3v3U3/7v1pe9eaFDxSNe0yRqX/8IdlRDkuEOboYaXdYKNdJPpXX0zlIzoRNFXcvAZ8AxjlGqDkM4z3euN1jK1rSQsZNo/Xjxka7Dc1iF299pyfbSzsMZtQUrqCZzJGI1bt9/GRNe9QZjLGt/vIrVEpqmuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB323931.namprd02.prod.outlook.com (2603:10b6:5:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:59:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/28] kvm/i8259.c: rename KVMPICClass to KVMI8259Class
Date: Fri, 23 Oct 2026 15:58:14 +0100
Message-ID: <20261023145839.34909-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB323931:EE_
X-MS-Office365-Filtering-Correlation-Id: e176e8aa-6e44-4e57-cfce-08df311632c8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: MUDItYSAhcbxGTeGw3KfSrGDi+jj7TmfM6/VdJu07rC466m1iC6qbQM2ALxPgei+PgyWY0nt8v4ZVAdEpSNJj4WqVYCVQBBJxbLoEVQz3rRzXUAU1pE0qh27mBZe3rKnblutinbtQaAg/LacDECsC+snFUpNt1Fo62AFDgoP3lDaostgh4FeN7WK9U4HbWTw854FD3faqVFUhXVJZoWl0d4atRDgCBZfOqvmFy7hbY/KjEgRTQ53WApyy1FC3PPlhtdpSI+tTTIZxHHElWrtitMCqyvpbgFY69CV4a/vuuCfOOLYNX/dLG4KmxVw6KxHYalbflZX2GzMGJSdcW/LRrJ81zzgNlcBf6YPxAusGx0o2Q9raIdu4sMFhu5Fb1TKH0VXsce2mKV1y6Se4bosNlb47k1m/XUVkZUw2soSFQt/UdHJY5dq9s6nFtGP+xBf/NdCZqPyxhRDj5xoANMm7tiAQbh2b6qwJnyppqjV6BRK1cdsWGROF+efoL0o7NGEZssV/4P1nGAmktpM81Ol8F3CfM1YArb8jbeySDm4BiHPyKMy2/W+AqWLgIW211oDxC40bZK6BSLMl7632rUN1/EkvFZjtikxmJTNIK/ooVnWpZ4yJka8UNb1x446y8EnWn2nYmhEzH1AWBH4Hn8cLA22yvaxHqfZeGX7zEY5pCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SXUpw8STQScXCZgJO/AnYeLEQM6TNfn2UHoWJW2LfA2tpmgDJsKDKlka9Z4?=
 =?us-ascii?Q?vOk1VnosvEHXrzpIEiFA3alfQJPxZ+txych7mUXpUC7SJE/+ZzTUGd5fCleY?=
 =?us-ascii?Q?8tZ8dp0tiwfGia3KulFsPwLZbAr80ydd9pDNzoDuWPTPHsTji3TobBTgagha?=
 =?us-ascii?Q?fzJI8mq4yg6zI9BAb95vV2rJy5VSZjDls8SBHWbw08KjE2NuEIFla2f9M8Ws?=
 =?us-ascii?Q?0WvX5OXESDU9/C//IInfPGgaSPvsk3pmuUsjxIp/1ilC+93CZO+brYjaWieN?=
 =?us-ascii?Q?aRpoWqOeGRyf6NoNZim7qxt/PNOMfUva57Kd5AOaTbzSbx3pyfAqvAQbt2Z7?=
 =?us-ascii?Q?rcWrFqP+1hvEmPqePL4Q9/uwC9gDYc4UDoqg9O6Qftf28ZIBmIenJcGLLnBM?=
 =?us-ascii?Q?Ndl9LM0JVSipIq5U37Fz4tSWH55kEsFZBO9Js8cVofdIpoNE6qbawVSiVidb?=
 =?us-ascii?Q?ioCr4+JlzczyGfahxFbkbtOmci4BaM630yqhf1u46m4xPKbP8IXTqrVufgqw?=
 =?us-ascii?Q?vxXxYqJjgkjYxYOVIOUYLaiAZ0vGjCMSphJgo1ZTbdTCSdgjyNqMB69IqlKJ?=
 =?us-ascii?Q?Vxmspz3flDpzD+v6xV6FJMz/DhJT8ixbsH0dlWWznwal/dYclnZfCmXKAzR7?=
 =?us-ascii?Q?ie+rQLdkAXK4Wt4xB3E9npG/8LhgtkiUXVY12nA6xYl6vJK3qsWvWqsLN2Vc?=
 =?us-ascii?Q?j4ZciG9gHAfkOFwmg+MFv1IQ9jtmT0hbD5T/A4YHPW9ULznrCTSeFx43l/A4?=
 =?us-ascii?Q?qj6L6Jlq/eA9xY3X5xF0TTTLHCT2jyMM93Aeb3cT4pvtm+uNPEZcmn2xm0FG?=
 =?us-ascii?Q?stm5CRFUKrJ/HtYwco+XVSxzCLjNSX88TNVns/K/3/yzqUWpO/Uel2T95TrL?=
 =?us-ascii?Q?qhaNiIWQVQS3xQUkEurUCBybk7HfdQJDppUfDfpUr2Cp9R0VX6iUyC/I6FRs?=
 =?us-ascii?Q?O+PLVu+QCRWK6efSVWATExCYhWUz9wnRRNuZysS77qKvKJW4gASpCJ8FFDoj?=
 =?us-ascii?Q?I0wt8ZuboV3fnTJbYRHId/dFjNmkOWkVPH3vu3uxEP8J16AmWJ+ITG8/+6aA?=
 =?us-ascii?Q?F9W6w2SDf0UVvpCgG/TmgESJqp7CNafOMj832NgGmtQrGObWfTAt+B+8TfhF?=
 =?us-ascii?Q?2hSFUg45Z6Oi6wiE+QtO/+ZMMYZlN2jw7SZJxXL5MK/9ua1EGylvN+sS+hTH?=
 =?us-ascii?Q?LE6vRvG54dWT4fA8T9UW0GtcDUCFXKVI0Lbocb2WyBCf6zTAutseNz8dwrEL?=
 =?us-ascii?Q?yfZg5lTT/XOZQqFBDupL4yDagh91ugbYiY4Bl7B5qYOnE0SpIJ+dZwZDeEIX?=
 =?us-ascii?Q?8QLnQErHB2OmLAu7YV7lKfrTnWuH45tPceBV6ufxDY5ISONDGivr0rYWgyke?=
 =?us-ascii?Q?5JjMu4cI62LZWHcn/ChAU5PeszLPbN7GS+9U2wXz2XOCRkGz2nZSM2S1lIXw?=
 =?us-ascii?Q?g5WMm3sSoLBKsYd352SyXL9SRj5fsgPJ31nQgJHtcMSBWupcxavZqCiUhCcj?=
 =?us-ascii?Q?xFLTXSe9URQBivcsQJl+pT4Cfu5mUArihaQ3Bf/oH7Yscz1ipeYs9PlDu8sy?=
 =?us-ascii?Q?GkwxeZUgB8CCfgPmCzl67qSayPboH4A4tQs6eKHUGUveKL7hT/bfVETLZUWx?=
 =?us-ascii?Q?udNKPdBMHTr7pFVIKZwHxwjIHDorI/rWlkSoqOKKe/VQVwlKdxv3/BCpQgwV?=
 =?us-ascii?Q?ypVo11H7OLDLcKid+kJ1m7j+WPrz5rLTHC1L78k84mEh4QIeSH5kCJpc0QCL?=
 =?us-ascii?Q?NEH9PjMFOt4mmnKCW3I0jK5L2DOVmWg=3D?=
X-Exchange-RoutingPolicyChecked: ChfIf2rGZSO9ANPhocE9qLh3KbANo01d03So41GCEI3YpAwFpUCNln+m/UHfp1OUe4gAIJQrEmHmaa69d6/IpgV3lRLpjwKMjyoB5wOtJA6IaaHSDw+VL/sqWXkM8EeRW9whAsusb1bZmllqhcqnuv9WnECi8CaMaj4uF1s9iA9WA1aoivQ55mI0A+7BrVBff7qCdWdS4qdb9Zw+xSF6FMY/a56spF+hHOladMYPZaFWEi0UXTjrBB7gLLOtfLegPHRRIWZR0SoeAh+bXHRtGuz7kZRWXeBogGbZDLRH6S9+4aCOvYshMCUOJKrJYd/hQ0acYjJuqZN8Vk9buOgSiA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e176e8aa-6e44-4e57-cfce-08df311632c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:12.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XCcUdx8VtIiKP6RYmOEuaqmkhO3qwvHVlmCxdeLixvnlFyshiHbGqTgLmpNMtdo27SdDdIMiQNvnDpmtR3Xzu+0tHd8giB1Jpuas4HTnWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB323931
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7643 cx=c_pps
 a=GdPAKRNZCFWq8uDyhvyBig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=7JMAGyXtUfIWgoDCk_YA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX68N7+bgi6z8G
 jU8byc/+YALvUbItPvRRKZOxKS7K/8tE7ZqSGd19FlC9deWDd7sacy/4xJqdnuUaRfXkND4W+ni
 YKZSkT8IjU4fTPSczAuN9/Sx/T60cD1M4CQmjM9FrNEMUhFgAhJNQX7z/51qtEikP5Y6iqEIzq1
 z83J06zdMx7jzGKgVuLxP6qnf/tpEI7uuDEYbXSWlsOFQWAtFS7VG/rNJp3W1WVfiqrQC62iAvb
 O941ztphnbT0WLVLgVd7oR20z3sgFWx3IXNSlSKxLiTPAAITNz6g1R5tbA5VCLTmdwVKL/8KSnW
 nPO1odFMD1bDB/Q+nYKKomqvdhU1dFb/iG29dWYoR6qJHutthxltmxJEANV8l0Olvj3ggloLUr7
 vFigZdd9wNegD7aZpkJ1G9cM8q3Q0dQknHaoILKkkl5ws6KmE6ey6SJry0Rk0R/iqYTl44yqHWg
 lRAdwefpD0vMKWDlsTA==
X-Proofpoint-GUID: fJmqPTH6S9bosuA6pzk4X7x2RDj0NeMq
X-Proofpoint-ORIG-GUID: fJmqPTH6S9bosuA6pzk4X7x2RDj0NeMq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX7QmGv2i8tVt0
 zCMVrQV6AGlE7PlcBbPwvByA8yz/FCkdEFESvoZis0cN2SzVRr4D9DIAIzdFSdMFN1q9Tpi2Qw5
 KmIFVX7Hm7ZLis3jME/icCVvWv0ufuc=
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

This is in preparation for its use within a QOM type presenting a single
KVM 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-9-mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 68607d721d..85176dcf80 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -20,15 +20,15 @@
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
-typedef struct KVMPICClass KVMPICClass;
-DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
+typedef struct KVMI8259Class KVMI8259Class;
+DECLARE_CLASS_CHECKERS(KVMI8259Class, KVM_I8259,
                        TYPE_KVM_I8259)
 
 /**
- * KVMPICClass:
+ * KVMI8259Class:
  * @parent_realize: The parent's realizefn.
  */
-struct KVMPICClass {
+struct KVMI8259Class {
     I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
@@ -123,7 +123,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
+    KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
     memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
@@ -141,7 +141,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
-    KVMPICClass *kpc = KVM_PIC_CLASS(klass);
+    KVMI8259Class *kpc = KVM_I8259_CLASS(klass);
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -156,7 +156,7 @@ static const TypeInfo kvm_i8259_info = {
     .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMPICClass),
+    .class_size = sizeof(KVMI8259Class),
 };
 
 static void kvm_pic_register_types(void)
-- 
2.43.0


