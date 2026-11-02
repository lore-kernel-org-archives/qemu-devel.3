Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AA606A333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=iYtlbcQi;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=dUvkoL24
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNrKg-000758-Do; Mon, 02 Nov 2026 07:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xNrKe-00074u-VS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:40:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xNrKd-0003bq-14
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:40:12 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AfHa713290; Mon, 2 Nov 2026 04:40:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=ZC0ajDQ4JueFj
 dp4o+QX13tEjaUcbvsFb8SYoV2QCy8=; b=iYtlbcQirju7XOMAW0a/Sil1RZ4yC
 l9emTaUSdPvNr3lLFYUulV9WC1lEWwFJHWjFqj3TaBybAnHSberkBwrLa70e2Yeg
 ZMMkgk4Gz6gNGkLQcCRsUXwGW/FgCuV6b18jXQWfeI+kG6/Vl0lh021JvixUjDcr
 /qw2vZ7TTsE+yGbStKDlvtVCFHVAeVEXM1InDti7+Oyp8NJ+aPVh6/MLLdDZCAz2
 7cNLLtCRtcJsKD5ntUCoPMqLfQnhp8gvfkeTFQ4RJzWrbot1YbQDawPekz/XR7R2
 cIo1x751x6zy3aEf13Ts0X3YT+KdaAy7GFhFkUARtrOznIkCDzcdVaEgg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020129.outbound.protection.outlook.com
 [52.101.193.129])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hnc843mrb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 04:40:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFtsKZIXm+dj/+l/bGkGfoXV4PxrvcT2OQq/loZyocVKu2Cd9rdVqaDRXQA4MiSACChzwYpR8LczZvo+WYTJYkVPlqE1CpKE029xTAEVx5msBJKSUyPovzJmxgg7DC4svlTZcscVON8W4/39v69w+vRAvPEEvGu29Pxbsxb24VuSXq2QS8lvlefgRn7cIJXynjnjkqqC/c03rNLVX8JQkR49rEvRBVVJAXT7YBN2xF6aYA2WIY55/NiGNkRf6ng07yiOA5wpvGDsAtE5ewr9IC+7RyTP/ME3lcvNFfULFwhbn5dRn4lpdLXi+pgo6vP/yV8acPG5ACgVouFEXyRlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC0ajDQ4JueFjdp4o+QX13tEjaUcbvsFb8SYoV2QCy8=;
 b=B9NpMjceH8+2PS3xrdvTjvuCiJgi17XGSUali0Gcnj6A+x3CUn3QiSvFU4fsYoZXZGSLvE9/xw5c4a7bCLWSVJu5PLeotSJoh0mscqDh+IIxNnhYS0wUgfqbwy8IKn08XTGTDlHxUyzE2ZsNExwb+6bXP9aAVIARJygo5k27hpbp7Xg8KFxPS8VMtqKrwfqcC1UgnojkFFOWGb092OV6NnQSXUeqOImPXcg9qVvYgyrkx4rfCAT8WOkaC4KdLmY2psEkYLqXjfTGn/jvEaWnRRosEAt9wLd2Rm9n7u5VD67RLon4eDIfVUFtVfiBw1M/wC8AgTVkBC1eORQtjodaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC0ajDQ4JueFjdp4o+QX13tEjaUcbvsFb8SYoV2QCy8=;
 b=dUvkoL24rTlaRxKj3MK3tYgofP9dtxTQ/qBK+FGkFQw3fPt3U1BjYR8VUyxDbszRLsRDyZrn25pU7V7gbTE04iaReIiwiKGZahB93GjkXOEQhkWfJZOsF5FB7DoZiK6Jy7Gw3M17QiqiJSsKlTxnQxFwmsvq9pQXGDK0CchmC4TOSRnRcLG1wMI2qRAPmiQHdPX2x1lPjdH2Jg2l2NJnsPM1Yi9rSeujJd6lXH941w2BPHnBerOLDvG7Zt+0k+r3QXE+8zexo1Mymfda8hRQXuzEwjnLGPfYaI3YOtuz5YZlpN1X34R6yCH3q8Rz1zIzClXrXS5lsOPy9M52u2QNeQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by DM6PR02MB6842.namprd02.prod.outlook.com
 (2603:10b6:5:223::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:40:06 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:40:05 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/clipboard: replace guest_peer_count with list walk
Date: Mon,  2 Nov 2026 13:39:59 +0100
Message-ID: <20261102123959.11361-1-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:803:14::15) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|DM6PR02MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eb926c-15ce-428d-5349-08df38de6bf0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|261021121427099003|56012099006|261009223027099003|261028144727099003|261021135927099003|261026140227099003|261022105027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: gsiBtNPNBOx3NkEnI48IL6JGALRbCHC/xx22wK9qSOZirq4xb3ZE0BbXBbhZitTFbQAfF+uiUIDdviWnLsbjtbODTRClHX9ZCFIQcD1J4WKpntsZ5ISruw2RQhskH1TytAHg7F9qJhrRHgjsTfzxlDJAlpleB9S4VCNnmRsbVvG3CYtesyhrgP1grNDiZg8hhc+d1VNyWXe1jRvcyrlwrHhDHXSEz7CK/z9t0H5S9QU0OG2zjn0sidGtco8PeSwCbXzq8yaSaOt23/bVOer6SYVMBF90UR/JO1yj8nlKoXBSZRWeKqNttCjZ3A9CREQpVDXCjUYbpGDNLmyNeg3ES+ePMknc4XCGKQqTenhSNZPy3AHmGZDTVf8I8yqRAHRcdOnRYT3HdzKdVtF3sACicam1iiXHvZIybp7BSz7dNmVvPLdtI22704JOTJxlJPg0wSZ8wAwPfwEczCrCTPAlsp0SowJ3085R1Scs9HwZEoLeAkhGKZ6Dho+IsLda1FooX4l260E4YACiR3Nb8x8gVXwoHHfUyJA9a+CNeqixU6Ia1WTTpq8piIAG0ClkyoprYoyxdPba4BVPt0Rhv6T+GWCVsq/YEs/gH83vsBky8EwUk4W8bGcLwBDpn5lbFg5ilN3H8Aqx2lzUujfMnlfmVzY2qOsNTJeEx9ZMnbKC6Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261028144727099003)(261021135927099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8i32QZQHw0D3+nb+k+9kvZ1GOCzjwystUJLyJGm0zOGSEhfPOPm+FYxOoL1?=
 =?us-ascii?Q?Bh5OMAMqSAPunLaQaiTG9qI95CsHXv2y/eBSUrzpJ4Onm1XNyxPpGkVmK8Fq?=
 =?us-ascii?Q?4qwBYC1vP8nMmr4GaAs9j82BfO/VYncyZXVMDhbhFjYg0w2qoqo/lkYC7crs?=
 =?us-ascii?Q?RAviAdjXJeaOd377Y1+Bi4I2va8vsSpGvvVni+rDKOFpWDVsTi9rTAfBwFJC?=
 =?us-ascii?Q?eUqlqTQP1PObH2b8xHU5GZZrxvVlpWi4HbleKSqQL+zmrxM+xdd1ZgyM+6jH?=
 =?us-ascii?Q?M+pX2RsScJ2dS5mKBsE44ZQo2EVH9gZG5ojh9lbBBusc6/RC2p15SgsSnEGC?=
 =?us-ascii?Q?380BFsAyV752gzmBWkrvskEi/gn/Y5e0Y4FPW3ZWr28sLiwn0zlN1vh2xYZ8?=
 =?us-ascii?Q?njtpfxL7315ez3gls/7csaDn3l8Yws+KKXCn1WgNqJz3bNExfMfOdAru/5vx?=
 =?us-ascii?Q?5zX2tsKCHTiuVtqyr+kPbNrit8wJDsH4TRXfWR59S9afSX6tI/MK3uAWFayD?=
 =?us-ascii?Q?T6ra3cpScM1fT9Kyq7abhJ6is8DufyDI4EEcKNN22Or9SGQHLHfpmUpJ1k7e?=
 =?us-ascii?Q?48kWm/YKLnG9McSY33oYwBp/06ZuRzCwoqwI+tO67QF+UYInNYFAB0paNgFr?=
 =?us-ascii?Q?QCsMtHejE4i0IT6Dyqa/+RfFDUss6XHRPb/vfDpXBaat8XVRTDfCJENYx02Z?=
 =?us-ascii?Q?A/fphf0S0y8EhJGQeIxDfpiroeLV+vdG8h2c1oP3+HGTTimYmBQiiFdKrWlz?=
 =?us-ascii?Q?c3J0/TLqtQf5U8iBF5WACySwEi4Eo5s6OS/7olX70EnUp25UW+tDAxx0OK11?=
 =?us-ascii?Q?77H9nfJNv8gaiJVP6km9xT8eDfm5jrJ8lgKWyTh227ZAYL+f/y69YKv0RCNO?=
 =?us-ascii?Q?Fri7xgUJfvRl98pvXK/y82aZI6LxSJcR5gLMoe+HFFiDbMmEa4WG+h8ojtCk?=
 =?us-ascii?Q?0miLGQs0EQ7wSkIgy9gc9pC8r7Aa/zJPPrHj8Q4on2beKM89Ax7KDee0uQJW?=
 =?us-ascii?Q?m59Uq5dGH+qUkPN+5lPNkhiR5ogE9Uaw6/aVAQIvlpZNIW9LmScQujExpQT5?=
 =?us-ascii?Q?RvpIdZyAWvXm89l2NUTtVyhJXpYXfvrtpvYTgUCLqWd0AvKpsElbNvQ9dwJX?=
 =?us-ascii?Q?yUokuekeb710zTn9XGDeCUvD+beGPXtuw72AjT4va/IaVMfeRevUskhwJwA/?=
 =?us-ascii?Q?FoDQihn6G+jqdX4GDbbYGXK8IdSVyCJosdL7VJm/hyZ4/uJilRFZJTrCGFYf?=
 =?us-ascii?Q?LyYkU9o8uOMf3JklcXKNzeGIZk6bhrxn0hxv+oFXzPE2oNt4Wt3qQb2oBs8o?=
 =?us-ascii?Q?AyGLEEsOzJaye4oUiqyjMUg/eUsHY+v5DvOutuArhl8RpoFJq4h3Y+r11hvZ?=
 =?us-ascii?Q?sVNq9E2V+8dKzHE5IsvAzjeA1tDh1y56hXzuz1esSLlwrAAi6z22lPvzwfus?=
 =?us-ascii?Q?elFlidOYeBuCdW6KynpNm2VeTtNEHF/oHul73/HhzTSQU93FS5avJj90a57w?=
 =?us-ascii?Q?1+Qs+sHRCxJdMwMgC9PBp61Y0x7TbvwcyiRMjT9pmexwPF8WoK7cyupYAtGF?=
 =?us-ascii?Q?W9m2svEeiqv0XWm9ycqsEXh3t0xjOJCbPDo12d1Kb93m8GjDFT48erw5+T7N?=
 =?us-ascii?Q?UYj/bd29gCvOaPGPDY/fWWu9Bb2Q6x47rmp1wfK9X/kD5//h0Vcv5iB+BiFh?=
 =?us-ascii?Q?xvxDAwRi7YQoA3rjGVVGa5fPr6+WyiekBCbhm/QJJsmKhFP0QLHgijwcXr68?=
 =?us-ascii?Q?WUbjblkSKHiIV50hnqj5MNM2lg+vjmg=3D?=
X-Exchange-RoutingPolicyChecked: iytefjgZRA1wB4KLkxDOY8QmxMIMCuOEaXfZ7yout7jDehga9uKMRv81qtuzETSlJOU4bqzkGAg/DR/JMxfRhgxg2AZxeroEAXBIuiHa4dnAHVpgRyBWL83xo3/gazn57aWvrhF3zS0//wRXwnIVlDlofSMudlBFFFF+H7QRSjLzrT+LHCgM7f8fXth4srbB/nZAXF8nX+/pNc9IO4dm6w4VCH4g7eu4gZVMhc1ahYyAU5AkJho05o+9mPffCCHNwplOlrtAj5HueNhM7m22SEY5a1HKPuJFUJyeraDC8YTD3GhcYh2KK/HrC63KQeXFZImRD3VcK61gqGEr7S+CBQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb926c-15ce-428d-5349-08df38de6bf0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:40:05.5633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw96YSEw2jPq6MsEelM1uFwZEZZc595JkvdCVz1rfDob9gJx3eyXZe6K+0raR/pPQ2NVWszJHWm4wcvACQdw+3NSN+e7zLCMGlpeAdU+iZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6842
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX+lEndXYDOo3o
 7xN6qO7Ap3fHuFaHYVxGdGB7CP3NjBnTfTTkbqze7+1PWABXZXipZXIgSNNv1/gCMjmncC5n/Y+
 w+tXK6UTfwsiVzXPygPvvq0yU0Ex7X4=
X-Proofpoint-ORIG-GUID: OBh3T0P7nudCHXOjpp040ug3zvAx6eeR
X-Authority-Analysis: v=2.4 cv=C6N8WgP+ c=1 sm=1 tr=0 ts=6ae884a8 cx=c_pps
 a=2JLEL+eSUXzWNUMlkDf0GQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=6Dd0GQxwE3M2rsmd8eoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX7KiMELjEflGT
 3T/IyrfVxDPlrZWYsfmvNjZ7y/2GaLt78hSSC6VVZ8QnKJCM4bQAz0BHDMQ8/jjMpDZ88mZaKu8
 ZjujPghSCz1tc+RAnmCuWzuT3xTfxkDNdWwGtnH3h4YWZmCRGt3c0w2JWoee375Fi23ikSWjTjx
 3hQW6s/OkFBpXUGbUJkdNSyw5PgA+VxZXUpFGuUEdN/9IsV1BivG9uBW7k254Haa82uHtEr9IoE
 f9xgJMS4uMqC/TDd5YlQu86adiFxEdGk90pstnACEyP9cFvpbmusn3VGPW02lgknU0WvWH7d2FR
 N2B9LXnUgewYiSpEt0tLaMjmMr1gyWDofrLPs4V0Q/LP9NcBlzUSqAMVi/QCjjW8Urcf6/2WsR8
 HAWcKolp4dPOsa4FNms50bNeLYn49wqHffDRAYrKxSU34pqYwZZ0bGVKtNUp9plnfHnNyt5PPpb
 K/m7DlKZ++whzCZXLIw==
X-Proofpoint-GUID: OBh3T0P7nudCHXOjpp040ug3zvAx6eeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
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

It's unnecessary to keep guest_peer_count since that can be recomputed
reasonably quickly by walking the notifier list.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 ui/clipboard.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index f750b494eb..3f6c259124 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -12,8 +12,6 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
 
 static bool cb_reset_serial_on_resume = false;
 
-static int guest_peer_count;
-
 static const VMStateDescription vmstate_cbcontent = {
     .name = "clipboard/content",
     .version_id = 0,
@@ -82,10 +80,6 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
         cb_change_state_entry = qemu_add_vm_change_state_handler(qemu_clipboard_change_state, NULL);
     }
 
-    if (peer->guest) {
-        guest_peer_count++;
-    }
-
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
     qemu_clipboard_notify_peer_update(peer, true);
 }
@@ -98,12 +92,6 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
-
-    if (peer->guest) {
-        assert(guest_peer_count > 0);
-        guest_peer_count--;
-    }
-
     qemu_clipboard_notify_peer_update(peer, false);
 
     if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
@@ -114,7 +102,17 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
 
 bool qemu_clipboard_guest_peer_present(void)
 {
-    return guest_peer_count > 0;
+    Notifier *n;
+
+    QLIST_FOREACH(n, &clipboard_notifiers.notifiers, node) {
+        QemuClipboardPeer *peer = container_of(n, QemuClipboardPeer, notifier);
+
+        if (peer->guest) {
+            return true;
+        }
+    }
+
+    return false;
 }
 
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
-- 
2.43.0


