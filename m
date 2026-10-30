Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FC606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=aNijsZUH;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=KUdz0s38
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnO9-0000dY-An; Fri, 30 Oct 2026 10:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnO3-0000cB-Fi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnNp-0002cN-G4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:19 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG9tT201806; Fri, 30 Oct 2026 07:15:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MdAl1BaTHZJ+RE3tozE0K3coeJLeBJzuzKdzOUfGp
 vM=; b=aNijsZUHUvx6HZktF+H3KilDI9yw/1cOfZAs0wUGzHIKBPj9fzTb6vv42
 ODqCercvn7WZOYlXX8saj4jRp/AepQep920cVGVyjNZ2bousKss/KzC045Ywm9ki
 0GXgCD8HMIZOskozqmXWrhhgSCZNkv+bsQCqtNal6kWZFwPmB0V6ZWRrOQJ+GlfO
 F7t0BaO4crdPqlWjPM/iF0AEkiX6CS0U419uRCXXsbd51lljs7+jMfwgFd15Dhmf
 xUw32LaWw+tKRlf0LJJkNQF2QpaJ2OBmYF7qRw5SWsZx4YdHfJn+d4nn0h/5+42x
 ljD7BJsK0Wg+onep0i2fLDYs9V5IA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020100.outbound.protection.outlook.com
 [40.93.198.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hmc2mt490-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 07:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ6CCh+OyboA11h1ehR8oKZOha91VAxpiFgi1uSwpQvJWVedYF8VXqcyRcnABoTSvvDEgyxCrwz/5BJv24zoO0UagsqLXL7+rRLoUZOehkHciQ4MsHmwKlPfGVyHuZjBG11Q4gCh/b7RvBwcguNF9H7Idy+RtvvXFg+K/3VEV4crfqmbsViAL+DzsnAj+/hfGrAh5Fr+Onei4/UtO3myeOf3dgPLeYXYCqJiIxaYBMVHH6CckWRTIvVqOaVLCGrvKbvZg1U1ZAch95q8g8dE/XBccBRe2kZfN7o8rMqMrN++4krqrB0kGpRFaprkUBap7xwUBRR1CYRg0owQerz7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdAl1BaTHZJ+RE3tozE0K3coeJLeBJzuzKdzOUfGpvM=;
 b=rP9VOJuxyg0mV+ZT0SGNhojW34wz5c2Ofr4aaqnuarcf2c+BykbyzdHOETckub6eIEhRK6cTVSQKEVAtJPvalPujOO5/o6/kd8unSVQqOouCFaLaSfNwvV3jeMP9BOIAajlReujs4vF9TbFN7jZPKJwveg8ex8gkgQFDkCqZO3kIdI/eb6RX/x1ztZLzNq30clqV0E1pB9q52N6Zo6ZeUB1+aysU7NUX3A8vqxshiVeAtIhkum+aoyPgHrFaRjtzRzdCNw7ZrxaSsGAFEm7NMvfk4DasQlrh70f+0+1MeScxPv1pYLyP7YlW88yJgnpFdRYRwLIm/vzSMLaEFkDMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdAl1BaTHZJ+RE3tozE0K3coeJLeBJzuzKdzOUfGpvM=;
 b=KUdz0s38N2FoOGxNU1Hj8yNNoG5EVhEzbe7NdoTaXIhFbSnQMWatt0CqkR7Xp6QpxIMpYMLWxRQcsYmbzmPtd+DVsgHQ2FZmgoYpN7sNpPgilpimFEfvDIN6/Y5BnBAcJqpXD410HuBRb88umuvMSjYFwXaFOliTOq0aG3CtGxd2E04u8cVrxDFr87KGeQEP+LWzg329CWm/K3BewitggeQAAI9mbuo674IKBOXy1bzRErmTpCfV7SqPbXRfvP9IDGCCzaDHYLudUS3etnrOUuqtO9kPeRkz4iqxOWfoiyfeFQlJ7aNjtxp+3cG+g4OxPwy2q4xwvgY1VFxZ1SC2sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by CH3PR02MB9870.namprd02.prod.outlook.com
 (2603:10b6:610:175::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:14:59 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:14:59 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 2/4] ui/clipboard: keep track of clipboard peer side
Date: Fri, 30 Oct 2026 15:14:40 +0100
Message-ID: <20261030141442.264308-3-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0046.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::9) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|CH3PR02MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: ad18ba6e-b8a5-4bf1-0a26-08df36902e67
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|10067099003|261021135927099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ERbqPQhJHv0IDY7CeSGimxfee3Mzws2UFtC35rlzMZJCNYW74XIDU68/i8fPAgSi7eva+Ui0N1cOVX36AMFgAukkXCRJ1Dx7YK0ztB+bFTkD5gjMVBqOVSRG+GBdiq0+gjOkdST6Se3x0R4ACZnI7ZEoTQcxGne2RakLoiOBz5FpBiGKdcYex5l6DX63OtzfqdUNG7sPu6WR5cpoukgR1Kl/ap484lQupGpcn6C03Dvks/DB5OjLSN0Cuwov1WU6VlnGooH6bRtn5QfUpb5bDydIqzdMXn8OG7BHjPt+WtYEPxOpMvfxuE5r7AZAQwqIlW4jfHwqbsX6VeCDdsklsGp0/hX4QA4LmyWZkhvFGlAPDtRg7BB7KnVU2NOuT6Bmw22M6o3rjise7XKMhIK3L495dABauG4gXgqSdFq8GTqWlhsRqgsobfaeAARJBFwar+4fmF6HR8zPzgS8UyZXavimsLRxLDMZQ3z1T4kKvdlXDqAZT4HHOQuSCpsiJqzJcwDQdL/srdLM06Lg6lnVOTiZbPAS05ePgdkABDFbEXDjmJi6HTgdDwWywtMNQsn6yN/hPXZxMzphYLI+vAtc9tM3GH6uAMGw55tVxCbNu0n5vVtksnJL2AZ629O1RauRPOfbFTmfcZI7qcaC7QuCopqFRqFLgKCH4pzrh03Lhrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oo9r1zLKPn91vExUDb2eXqgTvHosL7+g/6p4D5InqEThFPawwxlHsFX785mH?=
 =?us-ascii?Q?NGs3KEHN7fK3n4m7J8n1G1/w/cYhRJFbH92wYMjCKNeoN6ArvudFA/fflVsb?=
 =?us-ascii?Q?9SPyZ1w9jx8Bm7B22o01tcfXaC4kg2lVM6fVJE9KSBbGVyGqM1vePNiR8+JE?=
 =?us-ascii?Q?dC5/iJ1obq/nLJ/Jz+JUyAqk3uJer6GQYZHRXHFAkruY+NiC3Kys29Pzme8Q?=
 =?us-ascii?Q?f85IETfnRaAcV8Pp5wJ45Ce95wDVPO2n5nLAxH1cBL0XrTGBKdf1SPunbpGl?=
 =?us-ascii?Q?A5pWMonXRRZ6ufwXaKZdJXA/ZdJwuI8rC1aan5k+zj4dnmNVl/P+ZEZLYQaU?=
 =?us-ascii?Q?bBsy3MhPcr6gE6o4h4oL5TnMai6ZTlvycPCuHb7L36WHna+Zot3WfRalfGa9?=
 =?us-ascii?Q?ofd9AHSsT46JbHWXo6nCK7fCmLVPotjXEcQH9ZZ+ohg+Md0g7dokcWknahaN?=
 =?us-ascii?Q?kLqfXMOvxhiVIYY7U1rOT2+yqeI5N506Iez4H7bc+69TM3dCAxPSBB/9vPTH?=
 =?us-ascii?Q?h2mWFcJTcAPEUMgXUlrFHKbTIvLVZ2HPhOXRg0sElVBDJWlzDwaBlSUb7MMz?=
 =?us-ascii?Q?EF1ljitIUb3S5+zf44nYyFgX7zw/9ht2ur9zmkJQAVl31di+gicYuH8H1Dxp?=
 =?us-ascii?Q?X+LAE3hymGtDHOR+0pFLwaBwNH9ixVmp8WYiBahehazW42xQdvI3dmbnsHsR?=
 =?us-ascii?Q?Q4752OEHNVeia/0N4+15dhMQBUtTXmur3W22jvQVnGxEbkoXPrggUQEdH50H?=
 =?us-ascii?Q?sU9y54yTilTYwgu4J1w7Cd+/6+IyDuqeAPs6LABfVMxdyUYCwW1EMPNVEERK?=
 =?us-ascii?Q?uQoKJoibSOWfGLLkITMVlgecY69ZXOzjVCkHpawC6aIjPPwBxkh4g+9HmeGC?=
 =?us-ascii?Q?TZBpsjFM6A1tTA7+ggO0rQsMSRNwlKnznU4Djo5ciguo0WTT5/7wQ2d+yOkg?=
 =?us-ascii?Q?8yYlJLvTRd4SJ8qFfRbl6G808gQY5fS/wpQwpROjh+GViGzuXbnJlggFPkPp?=
 =?us-ascii?Q?YU8s04XxYGxtnNgWq7SKadWXNsMG9f4ZYYY/oBPAB7tR5U62y1CrGmFDR/qT?=
 =?us-ascii?Q?NDI+Ce1OYH98N7mZDwJHp/03QY0LaiW0s6dSJSanZoDvS9QSTuCPWjpOauAI?=
 =?us-ascii?Q?DABfa7zZOgveReGUCNGb+G4IEFseaop93P9iRnes6Is8Vy3graJwMGTTsV4q?=
 =?us-ascii?Q?0AeshRIa8+R7ihNytX8B8NSoIzlsJGd3X8tq3lDsPef7Zty2XIcK7kR516M5?=
 =?us-ascii?Q?cF20TxPmqD20B4BffPHRgfBclXQK2x77iXJ5DVInt3XHlmlfbA83DputnBLp?=
 =?us-ascii?Q?DJ3prMNs5xWDL5CaUYQmEHwb4Noc0adJVh7Lklb2yrDj0V5573fONwOepWCJ?=
 =?us-ascii?Q?vVsKY7qJbra7oC55mBPdgQhvNz4bMEKFXCjt4UV36oJWMGzgLeWN/WZFrcbz?=
 =?us-ascii?Q?30QH8kJo2H/OO6v63JKsIw2A6dwV1/+TuAB9OaRk5oWv53Xj8Jgh7gDP2tUY?=
 =?us-ascii?Q?1WZOzpRBClo21VdgE4e11ucJxX1uz+k2ZQzrvgwQDXOeedUqMaDufjuOypnn?=
 =?us-ascii?Q?bzYA7Y5sH951XG7Zfy8D7qAwvHoNWubgfbeNavbHYcj45652zF4DVi531NsF?=
 =?us-ascii?Q?cNLjl9kcESs9IX3JSDp2LT1MODI4ZpXUxRAw1pSzU/6KG53rpMabSTu0hsPx?=
 =?us-ascii?Q?WabCQ0dETNW+FzpIPa4w4/WSmaisIw8a2epBakfb4YYfTtGKVrPj7SFBr4aJ?=
 =?us-ascii?Q?OYoIJQhc4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: CtJ0t0OPjQiIvI9tMjFpc2tFsVkl9OSGIO1mG+hA8cx0dBKyoRkpnO6eO4EU52cXM+5XCUbdbiWlpytrRob4viQK6gBTZSMN7Ch1OSrwqP1MvCq4Q5TP2B6ktNlDFAQhNXuO+cdouBuqd1j1vie13oOOJ15eyQGXD7lFPPINyybdlyfRQlah1SqvdDkYomwLIqex/2xCU6rNGbgWj9k1gQ0pIM8RDobqxvf8a8mM/mdKLyqndIFjNlKj46dRDlmNzn9f+iMu+V1uh/nf4HUOFcrg53FPs6Xssx6eYtpMPCWgc7BWDdJhZ9Uq5nKtBViynRjF8Ue7Ow142wk1wWT8vg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad18ba6e-b8a5-4bf1-0a26-08df36902e67
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:14:59.3389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a7bxDSwfhJH56YqCU5tjvljAeYxAdLPRoLwQISLjpfeALtrgCYk56C59nVJaPjmJMaspfUabN2Aq/hNzRCT0e/tHn2SRYvdtvmRncOxS84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9870
X-Proofpoint-ORIG-GUID: dKIN4aFT94Nkm6P8N1W2PirOMqBMSvia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfXxFRFJ8CWTgEe
 /FlEJJZuWXa431i8J7+jHxKq4wZpZWoz+eRInRxifOaRsANLhLl+28bpiL0qMRs6d2sC2QipEyr
 dOrWJl1V1xLsIRyW47/tMAnawyMaIKVlGYJyLO20fJIs5tqXB5RkDX/CKZnB12SGAqrNbMVeYl3
 zNlsgD2Kikb+0lKaN546z7MZ3U1oqVAea6H4OmbCmuYzOGb0LbRRjo3LPPot8jb9YKQIMg0pvOu
 hqwbhBSeJZYVFyrmzFkCrjs/y3yUuOh4BUYRRt/BxSFja+AZp3PQghwdcJyYaR/jyy0J3WEkef5
 h9Evus5tVnXp42kZGQo2ABtnv1bXMW3XAhM0o/kjhUMKHlw6OYSVx3gEPoXVRqqtjVu0spBK3k+
 4gmFvHTCzZkWQCDenLmBavMMiveaUET3QQYMCln48raGtUZFb6wheULI3UxUS8dq2AllI67wDNf
 nTnEYS0Jyn+y0yUPQKQ==
X-Authority-Analysis: v=2.4 cv=BoYIUoX5 c=1 sm=1 tr=0 ts=6ae4a667 cx=c_pps
 a=rsLXg5VPEOJQy+C7BNxFIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=utkLoxhBbnJZJfdwENEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX13REbvfvUVlU
 +hUH5B7vO1f64h6F4x1p3J3GNzu0SDyBim2rbJcqoQzPCp1NNtfcsxVkKeCs13hquBil2qVfbau
 pR8ijpXj7Hi1Ak2xysgwn0FjXvy4JmE=
X-Proofpoint-GUID: dKIN4aFT94Nkm6P8N1W2PirOMqBMSvia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.

Use the flag to keep track of number of registered guest peers and
allow to query for their presence with
qemu_clipboard_guest_peer_present().

This change makes it possible for a clipboard peer to determine if
any guest side peers are present so they can tell whether a guest is
actually able to participate in clipboard exchange.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h |  9 +++++++++
 ui/clipboard.c         | 17 +++++++++++++++++
 ui/vdagent.c           |  1 +
 3 files changed, 27 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 6166af5139..250f1d8ea5 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -62,6 +62,7 @@ enum QemuClipboardSelection {
  * struct QemuClipboardPeer
  *
  * @name: peer name.
+ * @guest: is peer guest side.
  * @notifier: notifier for clipboard updates.
  * @request: callback for clipboard data requests.
  *
@@ -69,6 +70,7 @@ enum QemuClipboardSelection {
  */
 struct QemuClipboardPeer {
     const char *name;
+    bool guest;
     Notifier notifier;
     void (*request)(QemuClipboardInfo *info,
                     QemuClipboardType type);
@@ -179,6 +181,13 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer);
  */
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
 
+/**
+ * qemu_clipboard_guest_peer_present
+ *
+ * Return TRUE if a guest side clipboard peer is currently registered.
+ */
+bool qemu_clipboard_guest_peer_present(void);
+
 /**
  * qemu_clipboard_peer_owns
  *
diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d8f58a855..f750b494eb 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
 
 static bool cb_reset_serial_on_resume = false;
 
+static int guest_peer_count;
+
 static const VMStateDescription vmstate_cbcontent = {
     .name = "clipboard/content",
     .version_id = 0,
@@ -80,6 +82,10 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
         cb_change_state_entry = qemu_add_vm_change_state_handler(qemu_clipboard_change_state, NULL);
     }
 
+    if (peer->guest) {
+        guest_peer_count++;
+    }
+
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
     qemu_clipboard_notify_peer_update(peer, true);
 }
@@ -92,6 +98,12 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+
+    if (peer->guest) {
+        assert(guest_peer_count > 0);
+        guest_peer_count--;
+    }
+
     qemu_clipboard_notify_peer_update(peer, false);
 
     if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
@@ -100,6 +112,11 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
     }
 }
 
+bool qemu_clipboard_guest_peer_present(void)
+{
+    return guest_peer_count > 0;
+}
+
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
                               QemuClipboardSelection selection)
 {
diff --git a/ui/vdagent.c b/ui/vdagent.c
index cc32a94fb9..cdd4cedad2 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -695,6 +695,7 @@ static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
     }
 
     vd->cbpeer.name = "vdagent";
+    vd->cbpeer.guest = true;
     vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
     vd->cbpeer.request = vdagent_clipboard_request;
     qemu_clipboard_peer_register(&vd->cbpeer);
-- 
2.43.0


