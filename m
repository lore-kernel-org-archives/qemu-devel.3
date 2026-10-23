Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E0606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=d+KShxJT;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=RQuMv8o7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjn-0006KE-W1; Fri, 23 Oct 2026 10:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGji-0006JT-GF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjg-0002NX-1p
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:14 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE65VK3969478
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QioiWPVCtFtm9gf9lkncbWSFNASS0Qj62tFcUZ6qs
 fo=; b=d+KShxJTwzHZcpKm5QNCvsIKk56DPQluSl4F4rOnIYUO1+UjckFhLuqES
 HipXkAKdYNOmk00U5T1IURu0TMZ83QulaJcrifIh4eZuilYK5MjQCl5QAQuzQcB9
 W06x7itL8S62W6JwrvSK6fncxB8IIytJEWKjo4vnrLX0o4TtEyO+sEZswxtDDDxl
 K/ZFCfL9ldeDrT/m6Zzj+roMvNPCek8o+D7EFTMnk07fPj1HjrbFV6H5qaSY1s3G
 GFV+JNo2mAjLZEWKJVdT/91S8eo6JzM09zQs2yWkgbyg+Ew5y7TS/LzuLxkfFd9E
 43SkoRVL3JMkMMqOYFjfTkeKL8uLw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021075.outbound.protection.outlook.com [52.101.52.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf973myad-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rm4KpQKTT2jO9b4u3cM2A1AhTZ/4Gtgx7Zjszr4lkw5ztC7yDg6E2E3uvAMVvCvc7dB0EK9RZ5mmhi1MpQdvolpROX1VY1RrV/POUZzDXWvNsHK/zoUWU7TuIVXGH/L6B44k1hGEUpKAfu741UsIphbwEj9dOUhrj1riVgGwzrfyNZZMrgaH4KW5p0Ytw3iHk60vDvsMZlsT8l0fzkButkwgJ4dZ9e/eJPdEIgJck+N+STDlZxijtWAn+huUnolPBqO4wxlcl1QhRkG3yJg0ntXzrKMkOWcPUztTZmTGgXIkVDuw2OEjgLQgmtmekUCLKZOSl/jTU+wPcu7ZPSsEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QioiWPVCtFtm9gf9lkncbWSFNASS0Qj62tFcUZ6qsfo=;
 b=aoogBHHZQAKt6MsmbCdNhjUQUsCWX/cX8gT6G5Ckcd8Mb04v55/DBmVvoccy3MDZNkAlOXPc1uDmrj5UguMPnlZsye+6p+/AxTrrP9XAMf1sczCW98KhK7/WAjVWY/VWAfhHRoqF3Wl4tZFRJWR3e2I9KVZrTF2K2Mc0B8DSW5PIOCghJb6HxOfh4v2XkN5d1kgFZTggRzfehy3/h87v8YP8+UioUuHNV6OWcwTYwn1XZ94iknjD2IwdDk2vyF/S1L+OWEHJuR95IFKqu2HDeB/RALQIvqDbezYcyOtYEmZvMQVh+gotMN95ndPtWlAtIXmd+qeUrC/7GqaShC9unQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QioiWPVCtFtm9gf9lkncbWSFNASS0Qj62tFcUZ6qsfo=;
 b=RQuMv8o7tWsbUwiniUy/VgR2tkOAksZfNtRyH9r4HI4IUlPy/SAbyR3PsrJSKonUM7kpRDe1C2xmovgLsahM7v5HphC5U1eLhxbnzaPa/1VTXVqtyxZTkStW69UTthyDMlsHZ2cEhCTsEZxuAe58V8qqCjSAC3HiQCInocJTxtg24ZQL1REJGdQLs7QTo6t4pVg8Bh7RMGdnD/uQ7wukoi90EtsJNivl9QLi3WYxi9h73JucOFeiVzyDonoA6YbHKml1ZKn55X6zt7wkkLmW/QUpI7Aq0gS0qFpQjw9umhqyaN2Wo2Y2kgtHRiIcvoRObYc41U0zF2eyuu6H8FcQkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9784.namprd02.prod.outlook.com (2603:10b6:610:17f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 14:59:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/28] i8259.c: always use cs for I8259CommonState variables
Date: Fri, 23 Oct 2026 15:58:13 +0100
Message-ID: <20261023145839.34909-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e96385-c291-4209-01ad-08df3116309f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: E36Gf0hMTCnLMJLdGsb1vURdhJcURb9BDwbx5vbs4YYyLBq0/bqyNrD8ANlni6M4YCcl9aUu9MySqVJsKyndje8OZEZaUg2iCrh4leINr3qHVNg1V1GA9AkY2IlsBG7U2KhBXRwqSafFsMNUsCc9ZRIYZAsH1C88cFPfYoCO0CDmnc3VY4u7+CB98KIBC7MlxTb4hnyDXzX1r3tcQOD75Ng4uBfauj7j6AH0HTtmdRy2JlunqLjPYECpNs90aLjvJtdhWuDhS6nyrSrSLTrQPYldO9C2zFqPJ77/MNhJuKARVfCB3x+i26Wdozv0U+dha2bGEC5lw6bCPhAw4mxYGW6PbbD9kakoodpgipiNU0PVX+yjK8feEz71mEjWmUl3/kn4RZaIsmfES9cL0+iPQ8tYEb0Nku6P9/pcAUJmfgvaXG7Jl//iviFgvs4JnLrWq24MrvZYdMVNbX7dKwud+QY8ElB25MykZqst24z0nZSEjKsmQkXxY+BL+Y1vcYMdk7vIpG0RNko0O7MrVJ6fUI8sMkrFgt3seMGWYhMj/DIoEi/RkZyTSjyZ8NTEKv5c0HokCOL9FLrT+N1Gh5RJs/TabBIr1OTk+5z30/37bzcq1N8PoKgyKYk+usEJmpsypQFRff9y54P6b+6h7bWg6gMsPxb0ygp5pDoNFkB5nfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzxYzwpZB7kNPEjC0tq9e0lJvmhaK2DznHFZ1MhX3A6ePmjaD0xhU+sDwDs6?=
 =?us-ascii?Q?fJkCJP9V4ZdWl8198lnqtMTcKXzcKc657SZFc24VpnbsDNlxn3IQMum95Iw2?=
 =?us-ascii?Q?72GA564Mt3P6FTIMIGpdH/GKJNcVl8gA/e9Y4y4NYLwlCFN+fseLXiwyDqBL?=
 =?us-ascii?Q?HEKtnmeZlgr8IpPoFRKBZ5RPxBvXVi05h6Fe7JBdMc9PN7DbdKzVV1ajZcBj?=
 =?us-ascii?Q?IR9UBKJnPUmP42zI1A22GdSyCjg1pvimxCr7yOigbTpsMZudS2PsR5vBNwLm?=
 =?us-ascii?Q?4H3RIwAvPUQgtPGfcDWAsYsXQwttEHqjy3ERVCaUdagEFpMHahuq9Ewh0oHQ?=
 =?us-ascii?Q?jG4+88TCY503SwjnpNoprjJEDXX8e/PHjxsWbuZCGeEuV+/lJvrqhiWUojWo?=
 =?us-ascii?Q?uC+xXzdvQqh7NEtGKcHp3imOjJqDG+OwJdMn+KlxKy8stLYvHMz9oepYV1OC?=
 =?us-ascii?Q?GBZ0qHtPdUv3+t2tM3CqRjJwCIbtMWCnnxf2/z6AAxieiKRxVGhKEZ6tkfa7?=
 =?us-ascii?Q?UkyKCcQqtWG36i/MZljCt/Lq7Cosv2uCOG9TJOMCMyv9YqnDJk/Dz8Syna3H?=
 =?us-ascii?Q?VVhX79TcYRIMcFozbi5Mi5yDr3spNrEQp9yng5tVq0MQtXCzEPlEudYMxs6L?=
 =?us-ascii?Q?DfDDMP0SPMen5/WJ6ZpHLmQBRiKlmqIe6Sce06if0LBPxNjuc2tctfJxtG1t?=
 =?us-ascii?Q?nm5Mq2/UZORkczSqQdwwGHc8ffNDDmw1FxVYKd7q0oeLoHqaQYu3esNQHjR+?=
 =?us-ascii?Q?ouAUB98e4PEwAXd/mZ5OpHqHp3hAwKOUKexkKtUPGRdvFzLhSN0RIvmfjj3F?=
 =?us-ascii?Q?UAtoJ3irIcnRtkeOmdzSrh46dRuam87LWdL9cK21tF+5PQCGbh7+AwmWp/EV?=
 =?us-ascii?Q?FnRV5NgB9JiTK6UXxfnqJGpQTCU6EKQvhAReNgNVw7B8oyzRNkadOfN6WYI9?=
 =?us-ascii?Q?EwGLl9P1zjkD8bydbyjtVuJl/EG6h0UpCJGnb3ixzfLXRwPEqJHfCmOD4PQh?=
 =?us-ascii?Q?6ZbLQTrMWUFhszhYg/lY7eZUixCuHVznYk7PXakJ0DgaFzsr/75S9WNBgxhH?=
 =?us-ascii?Q?YQvuAtrXE6JUuzfl2t7aBGE/bj5D6P+jHBVxHg40Uvqh0inuxMkWXULfZkYy?=
 =?us-ascii?Q?+3RUPqxVzyR3F8ixiM7JX6QPhOETywLXYGpB71STGOaogi7ipeWYvxxVLTEW?=
 =?us-ascii?Q?gCbHjPBpsnSvBlBaILJCDWEBXQOeL/CJlHPt/SFDr3Kb1oDkKm9GKyBmkW3/?=
 =?us-ascii?Q?A90wgsvTDYQDiWT9MF5FZV4E9g0HOzoTWIgkm/s2KpZVJTamJA0QZDX8XK+y?=
 =?us-ascii?Q?geZY6ZLM7w1S+Vpj+BEMMgofsEcaaC2ZOXBw4gLqHY0Z6te0etqwwG054VBp?=
 =?us-ascii?Q?PAvNpaNaLVTQPEyI3SDORorsFD3FmCv8ytoKMtmBVrLK3zpwF5KLtseSCe+k?=
 =?us-ascii?Q?6gW13GDQNJVnShWoSsmRWgdpLt3xspSoeC5r09uOLDMZzNOX0UulZziVL7vM?=
 =?us-ascii?Q?let+wWe/1YNO7qd6ijgXrkJR235Eo5o2hssxuWg3whkS0TTt3TMcooB8ffLM?=
 =?us-ascii?Q?8jREv1xxsoMwvrb0MULZ0lBnIMYq1ubynNrlIEa5aItLjHumlFXKRvKHoM8p?=
 =?us-ascii?Q?8vNTymSVXbMZTRugK7sbkag6DLjFsf2Bx7/XeyegTxG4esTfFTnt3Dxl6nFw?=
 =?us-ascii?Q?FbzTxC4NOSSt1lhS+jxOsSXceDpcZhf6bdtFUJ51zI/XrhI4CNn74d7We5dg?=
 =?us-ascii?Q?GXc7Qf7/rUjDxYZPyuzw7NLGhfCDFuA=3D?=
X-Exchange-RoutingPolicyChecked: nPuzbvCNIKBtJCovKcqWGYVnExTbJUosWkI5wpGDwNH2OgaVSs47W4POy0FXtHLKg5WyCcW3dGd8ddoe1thw5GLFHuQZjG94NgfZ/PbMTEUE+cyO4y2KJvYXzKgWKN4y+eXrjTOyzTpbRa5eZe7gZdnr5uXdewdM6sMXLifx7LLx6aUqO01n5zQf8XA1bTNOg2qc9N5L46QGuFsmDxfRtPIxNQmTSg8bmeHLl0ad2ISVpZRr+THz6nj3th6Ql98yX1WE/C3lDcNIEaTvZQxyhPlFHZivl5bzuSvdauvx75ZHxhWahYEWAPKWD95XfORmC0S5pEmJZpFmQAc9UbVZxw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e96385-c291-4209-01ad-08df3116309f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:08.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RNKzE79t+2yVr7BUYyh/qVRqFqNuDj3lsKIr0QPezTOLNA0tGK4XIaquWsobdOIyaSflpyB3NNsbuu0CLY7U2z/aK3SdlvQ4HaDmkSqQ1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9784
X-Authority-Analysis: v=2.4 cv=E8NYNqdl c=1 sm=1 tr=0 ts=6adb763f cx=c_pps
 a=+Ua/q5Qdf9RbITHm97vdGw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=zV1iqHTY6MOlpgDiNWkA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX2wDlQGvh/J5Y
 HThH8VDemVxE196ITZeenozy/q2yklnubvq4tCRysAurdWSVrOJI2/1y7nBuMJkWEWLHKUBHAjQ
 cY3AI9rsHuoZwWFuybhXTw6VzjP22iMpztMP5JPX4eehBRK1Qx6MzuFtbtENKPGI9EbP0VjAdMf
 neI5Kr5g46RYqkVqEDvwOmL0T989duebKpdUwbsAg7BFdb3S7AF6tMOFVELcrIIUaW8btMWycu6
 oWHrsdQvMOSV5f47DHXZ8sMNJOq8XUH4b8jfFg4bYp4meZ0phjkNENSMfy7X2QWn9SyZhNdGo3X
 XfSpF0AhWXcYsWZuZNRzGuvfKHeHUqjE3qon0YdqB9Wk9BVE48ey75GuxN1oIlrfiJ5Cg+He24i
 29KFvS62n/4xQSnv6O5rAaI5LqWLA6OaMIGYSTzK2F87Hwly3OSAjDAmcOONq3gy3pvHkwmoRP2
 qRL8dLSLc3gMTqaQLRA==
X-Proofpoint-GUID: xerc0no6Dv_04_pVqY1Y9h-bwjJenBi6
X-Proofpoint-ORIG-GUID: xerc0no6Dv_04_pVqY1Y9h-bwjJenBi6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4k45SbncrPkN
 GnbrdGWPDXiDkEudTZiQ3cGccWQFFi0vZ0Qwm2Cb7cOwexaW72atsa8oY5vi+ep2ji7NrI9g8u2
 c7LavL7NDm39xsrB/6Dc95mimJDKTBA=
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

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-8-mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 192 ++++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 81827f2734..700412df74 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -59,7 +59,7 @@ static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(I8259CommonState *s, int mask)
+static int get_priority(I8259CommonState *cs, int mask)
 {
     int priority;
 
@@ -67,63 +67,63 @@ static int get_priority(I8259CommonState *s, int mask)
         return 8;
     }
     priority = 0;
-    while ((mask & (1 << ((priority + s->priority_add) & 7))) == 0) {
+    while ((mask & (1 << ((priority + cs->priority_add) & 7))) == 0) {
         priority++;
     }
     return priority;
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(I8259CommonState *s)
+static int pic_get_irq(I8259CommonState *cs)
 {
     int mask, cur_priority, priority;
 
-    mask = s->irr & ~s->imr;
-    priority = get_priority(s, mask);
+    mask = cs->irr & ~cs->imr;
+    priority = get_priority(cs, mask);
     if (priority == 8) {
         return -1;
     }
     /* compute current priority. If special fully nested mode on the
        master, the IRQ coming from the slave is not taken into account
        for the priority computation. */
-    mask = s->isr;
-    if (s->special_mask) {
-        mask &= ~s->imr;
+    mask = cs->isr;
+    if (cs->special_mask) {
+        mask &= ~cs->imr;
     }
-    if (s->special_fully_nested_mode && s->master) {
+    if (cs->special_fully_nested_mode && cs->master) {
         mask &= ~(1 << 2);
     }
-    cur_priority = get_priority(s, mask);
+    cur_priority = get_priority(cs, mask);
     if (priority < cur_priority) {
         /* higher priority found: an irq should be generated */
-        return (priority + s->priority_add) & 7;
+        return (priority + cs->priority_add) & 7;
     } else {
         return -1;
     }
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(I8259CommonState *s)
+static void pic_update_irq(I8259CommonState *cs)
 {
     int irq;
 
-    irq = pic_get_irq(s);
+    irq = pic_get_irq(cs);
     if (irq >= 0) {
-        trace_pic_update_irq(s->master, s->imr, s->irr, s->priority_add);
-        qemu_irq_raise(s->int_out[0]);
+        trace_pic_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
+        qemu_irq_raise(cs->int_out[0]);
     } else {
-        qemu_irq_lower(s->int_out[0]);
+        qemu_irq_lower(cs->int_out[0]);
     }
 }
 
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     int mask = 1 << irq;
-    int irq_index = s->master ? irq : irq + 8;
+    int irq_index = cs->master ? irq : irq + 8;
 
-    trace_pic_set_irq(s->master, irq, level);
+    trace_pic_set_irq(cs->master, irq, level);
     pic_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -132,44 +132,44 @@ static void pic_set_irq(void *opaque, int irq, int level)
     }
 #endif
 
-    if (s->ltim || (s->elcr & mask)) {
+    if (cs->ltim || (cs->elcr & mask)) {
         /* level triggered */
         if (level) {
-            s->irr |= mask;
-            s->last_irr |= mask;
+            cs->irr |= mask;
+            cs->last_irr |= mask;
         } else {
-            s->irr &= ~mask;
-            s->last_irr &= ~mask;
+            cs->irr &= ~mask;
+            cs->last_irr &= ~mask;
         }
     } else {
         /* edge triggered */
         if (level) {
-            if ((s->last_irr & mask) == 0) {
-                s->irr |= mask;
+            if ((cs->last_irr & mask) == 0) {
+                cs->irr |= mask;
             }
-            s->last_irr |= mask;
+            cs->last_irr |= mask;
         } else {
-            s->last_irr &= ~mask;
+            cs->last_irr &= ~mask;
         }
     }
-    pic_update_irq(s);
+    pic_update_irq(cs);
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(I8259CommonState *s, int irq)
+static void pic_intack(I8259CommonState *cs, int irq)
 {
-    if (s->auto_eoi) {
-        if (s->rotate_on_auto_eoi) {
-            s->priority_add = (irq + 1) & 7;
+    if (cs->auto_eoi) {
+        if (cs->rotate_on_auto_eoi) {
+            cs->priority_add = (irq + 1) & 7;
         }
     } else {
-        s->isr |= (1 << irq);
+        cs->isr |= (1 << irq);
     }
     /* We don't clear a level sensitive interrupt here */
-    if (!s->ltim && !(s->elcr & (1 << irq))) {
-        s->irr &= ~(1 << irq);
+    if (!cs->ltim && !(cs->elcr & (1 << irq))) {
+        cs->irr &= ~(1 << irq);
     }
-    pic_update_irq(s);
+    pic_update_irq(cs);
 }
 
 int pic_read_irq(I8259State *s)
@@ -213,81 +213,81 @@ int pic_read_irq(I8259State *s)
     return intno;
 }
 
-static void pic_init_reset(I8259CommonState *s)
+static void pic_init_reset(I8259CommonState *cs)
 {
-    pic_reset_common(s);
-    pic_update_irq(s);
+    pic_reset_common(cs);
+    pic_update_irq(cs);
 }
 
 static void pic_reset(DeviceState *dev)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
 
-    s->elcr = 0;
-    s->ltim = 0;
-    pic_init_reset(s);
+    cs->elcr = 0;
+    cs->ltim = 0;
+    pic_init_reset(cs);
 }
 
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
 
-    trace_pic_ioport_write(s->master, addr, val);
+    trace_pic_ioport_write(cs->master, addr, val);
 
     if (addr == 0) {
         if (val & 0x10) {
-            pic_init_reset(s);
-            s->init_state = 1;
-            s->init4 = val & 1;
-            s->single_mode = val & 2;
-            s->ltim = val & 8;
+            pic_init_reset(cs);
+            cs->init_state = 1;
+            cs->init4 = val & 1;
+            cs->single_mode = val & 2;
+            cs->ltim = val & 8;
         } else if (val & 0x08) {
             if (val & 0x04) {
-                s->poll = 1;
+                cs->poll = 1;
             }
             if (val & 0x02) {
-                s->read_reg_select = val & 1;
+                cs->read_reg_select = val & 1;
             }
             if (val & 0x40) {
-                s->special_mask = (val >> 5) & 1;
+                cs->special_mask = (val >> 5) & 1;
             }
         } else {
             cmd = val >> 5;
             switch (cmd) {
             case 0:
             case 4:
-                s->rotate_on_auto_eoi = cmd >> 2;
+                cs->rotate_on_auto_eoi = cmd >> 2;
                 break;
             case 1: /* end of interrupt */
             case 5:
-                priority = get_priority(s, s->isr);
+                priority = get_priority(cs, cs->isr);
                 if (priority != 8) {
-                    irq = (priority + s->priority_add) & 7;
-                    s->isr &= ~(1 << irq);
+                    irq = (priority + cs->priority_add) & 7;
+                    cs->isr &= ~(1 << irq);
                     if (cmd == 5) {
-                        s->priority_add = (irq + 1) & 7;
+                        cs->priority_add = (irq + 1) & 7;
                     }
-                    pic_update_irq(s);
+                    pic_update_irq(cs);
                 }
                 break;
             case 3:
                 irq = val & 7;
-                s->isr &= ~(1 << irq);
-                pic_update_irq(s);
+                cs->isr &= ~(1 << irq);
+                pic_update_irq(cs);
                 break;
             case 6:
-                s->priority_add = (val + 1) & 7;
-                pic_update_irq(s);
+                cs->priority_add = (val + 1) & 7;
+                pic_update_irq(cs);
                 break;
             case 7:
                 irq = val & 7;
-                s->isr &= ~(1 << irq);
-                s->priority_add = (irq + 1) & 7;
-                pic_update_irq(s);
+                cs->isr &= ~(1 << irq);
+                cs->priority_add = (irq + 1) & 7;
+                pic_update_irq(cs);
                 break;
             default:
                 /* no operation */
@@ -295,27 +295,27 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
             }
         }
     } else {
-        switch (s->init_state) {
+        switch (cs->init_state) {
         case 0:
             /* normal mode */
-            s->imr = val;
-            pic_update_irq(s);
+            cs->imr = val;
+            pic_update_irq(cs);
             break;
         case 1:
-            s->irq_base = val & 0xf8;
-            s->init_state = s->single_mode ? (s->init4 ? 3 : 0) : 2;
+            cs->irq_base = val & 0xf8;
+            cs->init_state = cs->single_mode ? (cs->init4 ? 3 : 0) : 2;
             break;
         case 2:
-            if (s->init4) {
-                s->init_state = 3;
+            if (cs->init4) {
+                cs->init_state = 3;
             } else {
-                s->init_state = 0;
+                cs->init_state = 0;
             }
             break;
         case 3:
-            s->special_fully_nested_mode = (val >> 4) & 1;
-            s->auto_eoi = (val >> 1) & 1;
-            s->init_state = 0;
+            cs->special_fully_nested_mode = (val >> 4) & 1;
+            cs->auto_eoi = (val >> 1) & 1;
+            cs->init_state = 0;
             break;
         }
     }
@@ -324,30 +324,30 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     int ret;
 
-    if (s->poll) {
-        ret = pic_get_irq(s);
+    if (cs->poll) {
+        ret = pic_get_irq(cs);
         if (ret >= 0) {
-            pic_intack(s, ret);
+            pic_intack(cs, ret);
             ret |= 0x80;
         } else {
             ret = 0;
         }
-        s->poll = 0;
+        cs->poll = 0;
     } else {
         if (addr == 0) {
-            if (s->read_reg_select) {
-                ret = s->isr;
+            if (cs->read_reg_select) {
+                ret = cs->isr;
             } else {
-                ret = s->irr;
+                ret = cs->irr;
             }
         } else {
-            ret = s->imr;
+            ret = cs->imr;
         }
     }
-    trace_pic_ioport_read(s->master, addr, ret);
+    trace_pic_ioport_read(cs->master, addr, ret);
     return ret;
 }
 
@@ -361,15 +361,15 @@ int pic_get_output(I8259State *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    I8259CommonState *s = opaque;
-    s->elcr = val & s->elcr_mask;
+    I8259CommonState *cs = opaque;
+    cs->elcr = val & cs->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    I8259CommonState *s = opaque;
-    return s->elcr;
+    I8259CommonState *cs = opaque;
+    return cs->elcr;
 }
 
 static const MemoryRegionOps pic_base_ioport_ops = {
@@ -392,15 +392,15 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     I8259Class *k = I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
+    memory_region_init_io(&cs->base_io, OBJECT(cs), &pic_base_ioport_ops, cs,
                           "pic", 2);
-    memory_region_init_io(&s->elcr_io, OBJECT(s), &pic_elcr_ioport_ops, s,
+    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &pic_elcr_ioport_ops, cs,
                           "elcr", 1);
 
-    qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
+    qdev_init_gpio_out(dev, cs->int_out, ARRAY_SIZE(cs->int_out));
     qdev_init_gpio_in(dev, pic_set_irq, 8);
 
     k->parent_realize(dev, errp);
-- 
2.43.0


