Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CA606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=FFVyV9yD;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=fHIB4kNA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnO5-0000ch-Mv; Fri, 30 Oct 2026 10:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnNm-0000Rb-P3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnNj-0002SA-Se
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:02 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBFsXs201527; Fri, 30 Oct 2026 07:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=e1NqQtJ+DvFYCu2/6gnQ9eiayFWIqO9AukXDYnVuS
 0s=; b=FFVyV9yDedP9Mow2qElFwzzAEZZcvVbYaN1Yd8LwuNfP70f86QtBsaiNq
 c7ElL1micjFWQzx2WToV+8EdMKtJ5IMZ3JMvD2Z5pT7xF+QsnmF931pIWeGW0XeR
 WY4vmne1pkMGn3CteFauZwDNXFEojPzuT5GhnC47c3772CYxrhK1xYrXO7ADnqKV
 3qcqpJ1ZD53tWvAj+diCFsO9CWsnI8tDHZYG/hUF2r3nIXQ3uIL3m2yltMuFiBNm
 dkyJIBJ5Akeou6PeC226OFoGTY3A1EF0E2LXr/d3cRv/sSnLs1moIJxHHEGj1XHg
 0hu0rKmqx9QRK32MkH0ezffffR63A==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020130.outbound.protection.outlook.com
 [40.93.198.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hmc2mt48s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 07:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQSqEDwWolSf1wDhQz8fqShezi0Ij/hBxLqPsIbo9d1/owonkTsLhX9yHB0xOr7bonE6mAKMmAdB3J0APyXUtsXDamPQ/sJqmNtGgbKlQPM41zLZFQ+KQiYTs3hFO61XxP94n0VDF92nPxb4noKE+deCMo8COSBR2BMqUx4+SPkuL4aoHw4gZRWQEcljtL4t/4QG7PwX1SQzSGUYACnSrZIFuIJ8itKanvxwD9mCX4wfW02Zo5agnMA1zeg8VPGz5vY7bhAWEzJqrFtgdazulroXLxUO9viYJueZGbCRtXiXkd5GvXfqvwOARtdZm7m6FU1vNUYbzxv/sqeu76OVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1NqQtJ+DvFYCu2/6gnQ9eiayFWIqO9AukXDYnVuS0s=;
 b=uKTyOMMKMq+TUTr4HXSBTOYWgqXEPblaDSwnj2dr138gmv0nNi1N/ZY/cZygJAcQtG/XMCsQ3F/XW+5KQ5cRzBhbjVZB8pHq52674pSiAlbT7luHhWWWBrP81Y9yyjf3HzjBV5gicFk51MsSUQeH22BkVkNspldpLJY21lqf6mXh4Ocyme7dJOP7doI3kIPD9jdsSAC5XaVmY617cYNkWLO/rHD0EqcaHcYt1OZhSE8Hq79wu5mdglK5yU3NVa34mWTw3o0kX0CgfYEl1ELbHtMK0kPCjzx8USyZU51cN/QzvE9WTPVx8T+8wMK1TTWFr2kBTw/TA5jLJ7tw72rITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1NqQtJ+DvFYCu2/6gnQ9eiayFWIqO9AukXDYnVuS0s=;
 b=fHIB4kNAgvsX1QPDkwUSu9kBXFvG7S5xdOyiVV/BJegb40WcHh6ODt1/j1kx8nKOhgoHaRd3Dgf4aTT/9nJpBTXtqk95jxPHuEFnlwPo/wonHceRWR/CGWrIzYPcgahAFcC2W7MpX+9E9egWeRFTvSQxUfqJX/1SqEZn2dZXD8nKe4ghhARAt2Q0Y2halA+wLCGWEt92fWIlA+9/DHCM9BuRv1PKQXxwspR7k6V1Bk9YNv5iiTDBM6DfWHAQaWzlVz3EQWt2UJsIcmnciqZV8sY0b6mJCGFDHReHB7QcMUsp2z4uwVHd47mvLC4yN8u7YWk54wAURWmyPx1QBSVkcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by CH3PR02MB9870.namprd02.prod.outlook.com
 (2603:10b6:610:175::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:14:54 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:14:54 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 1/4] ui/clipboard: add clipboard peer update notification
Date: Fri, 30 Oct 2026 15:14:39 +0100
Message-ID: <20261030141442.264308-2-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:803:64::41) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|CH3PR02MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: 998c1b88-d664-4f5a-6a30-08df36902b44
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|261026140227099003|261028144727099003|10067099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: B0qtsvb7v1NWc/JreLsAzsmrWhQWjbW6252nDJaZOqwFD2lSNaXHh3zwMUf+MlzJCDLzgfeelaSixu1zpawzj3sq5kZrFiJmtQpzYr/OCS3Z8UV89ZOV+U+qA3MYda6KieYiRwXLHMQq3Inx3JkpuLxpWZHOZEo+2uu6TG+Z6e4WRtV8AOaMxlcnwas+g9yjbcJHUUsHu9C1yrFW9jX0PbLFJ95ugl+2Gm/eMjq3IFZSyapqtgHruoeUNkBS1qeqOP6UI+o2Ktdd95r96vH0wY5sKVYDdU1DimQBkEW7bpDam1A/rPFqv/L4nXWiGmUcIW40C95WdQ49taI2LaC2COhQi7OPvuCFZnFUbpJUx73FByWJkEyyBxf2lq+TDR35A+XtNNUy7Kq3+MZMJEWgWjYqj7Hb+yHEIxyNXvtiIva9t7J7KqJgHh3O5v+N1B0at6zWIxuEwmhb2a0cdrD9Gfl97Y+p11R1J40hr7asptpWpBDsB7ISyO1c5KntKxTLoS4VlY2gApXXcw6yLTyF1EBj6GMziGkwFQ6Q845e5ta1ITr3QEb1T18DGOFuFvjoL8yM/3O0lOF3vLBQRYTVGrJqXKWNwB4cPWyH3C0vHpkdqDwt0DKdOFuEXJeCXso9GxLrb4AY0QSSdWVW/l9mzGA/3ZTiQdjXQHLBGY8fPEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vxn7lNufiAri7ZRDJdbd8kzW2P+SGkSjnlswBeX/MVsFf4WtUgs4Kgw89aso?=
 =?us-ascii?Q?/w1Aeo7+gHTrc+N3CEAVDRt8Iuiycw9s9jS5k1nl93gBrX8139JYtgNG2Nm8?=
 =?us-ascii?Q?xCRMCBbQ6jqi6rZN7QJcCpgk+uB0wg5PcfQXb4X7eLVhS0x9gGSGjwMlfF8K?=
 =?us-ascii?Q?T99sE0khfxmqL+3q83kzFdyN7PYdYrgH7ZOUDyTJYiNLDQUfxUvfUZpwiswC?=
 =?us-ascii?Q?Ds8O48LaEY4vOfEGmeRgWfyvml6czK0QtNtcUTeEr24NgZdzC7n95aXMuqea?=
 =?us-ascii?Q?4SSkTXjyPGhuIUDfc6gkEnFdiAOLimzyaV1d1/Y7oqsbMiNXQ/NPBkuOd6LZ?=
 =?us-ascii?Q?nDTnyP5ODP/12gn0/J7sXF8OhSCZ8sZzDzK96YVtDa2JmUMm+QeukIGdXhgL?=
 =?us-ascii?Q?zqYEi4QIJWFinfjYIOHKpkc6PdH3ULToB04RKA5Tq76F+AM4OcrainxYiEo/?=
 =?us-ascii?Q?ECBIou4pdnEiEXF5VMS0IieGAsBe3gbDQHJ2vAclXwNSyn9TC6CbetiS/VXu?=
 =?us-ascii?Q?/i79gaL+RaJGhd/50Cq7Py6PJFWC6KObNCfHND6OB/HZ26mJroNstZYIb6Tm?=
 =?us-ascii?Q?FqnN7KHxTFyxvV7TdIaAqQIa59NtqNaJQbBLZ6fMMIe0UajRwNI3ceL3dQb6?=
 =?us-ascii?Q?GiOggMws/kI8GGcrqTOlUcGpZgjkZBfyKgv7ScroIQEi5lCh7+BA7UvnPvKt?=
 =?us-ascii?Q?w5ybjW1FhboHWqLI9AvXZQ5RjayLc4KrfazIHupswUyxDdgfjD5eun3zd3Ix?=
 =?us-ascii?Q?BB8CbQQAREWsOuXc7xliC6OFLou5J30R4TeK6tRFy1WVN4802fh3SWkDtG/4?=
 =?us-ascii?Q?IQTVVEBLosseFPAtPv5ERhuPhBl5WA7MHTfpV1QqoX0/AIczqZPtNhT4sy1L?=
 =?us-ascii?Q?HX6iNbAqO8pZKXfz+MFbSTq/FN5b516TBKGOlf2DCfD0jXaRzC+qVT2Ypjf6?=
 =?us-ascii?Q?r3spLbqe7cBeedtWESGfZh49HLKtfdbJR9TpFFrOhO4MDBRNJzM2ePKdGE/L?=
 =?us-ascii?Q?yeEbF5aL7OfjaWtFdUZIfNDwtJ43cqq15B/xbkDC70IKBVC9s6XCmOC0RPfy?=
 =?us-ascii?Q?qvHSEpIT7EKWewGKHXMSkQFDvICl4qKKqDHLoy6odgeajMQRoNZHp79ebEiA?=
 =?us-ascii?Q?Glh4uTX1aThf/UJ9l595U/GlshqsKHuLvjS4bDrMc6/FdFcjIOF1z7JUcvhX?=
 =?us-ascii?Q?8B6XaPZqeZBIAc/55A1li9HRIyfkgCqJaoMP6vFYaTeZXLc65tbLlICZzMkb?=
 =?us-ascii?Q?r7j11U6EhURZfKbf5+glL8nqKpQ61tHfhZLdx9d2krtRl8vyJbYilUvuBocN?=
 =?us-ascii?Q?A2Ivr1kgSLwGZGFImR/OI3+DjCZtbG5f8eInu0XymW6NI4qFeXQZ3iE2va9r?=
 =?us-ascii?Q?T63VZTWIZz79mhLG0HPC5g6LrJ5pORAgr827hSl8NM17x0KFCZvb1v50XpEc?=
 =?us-ascii?Q?QObHyAsmN/2dFCBns3C/ALYGF4JjxEwwHw3p18ICV7QQZVUKyiCRSafktlHp?=
 =?us-ascii?Q?6LOb601xdpT/Akck9XRkvGwJau6FdBtRpE6FPYbGybFYK+8R2qNdIFzkJms3?=
 =?us-ascii?Q?eBrsH1qfTYdbPtzOkrQ1eInVGqA/KxefYHIshMkqFbICzAVApGD36k1ld1Dn?=
 =?us-ascii?Q?+W3HQ9BRnjlJjdhKEQ5T9iaGzGnFSRip5yj5jeMA7Fd2UyL9ekghh0F1Cobg?=
 =?us-ascii?Q?i5oJXsATmM0PBxjyiTPe5rhV4hAbmrabE/gR7NB6SHsPsmnEQVQAbULTZXs7?=
 =?us-ascii?Q?idm97ixBzA=3D=3D?=
X-Exchange-RoutingPolicyChecked: KCczZBcmkudy5AygcZ44zva62msXNaitxoG7LbFUVq3Q/RgEVB7UfcbyTNyOQ387Z1JAhd/HEN1vVj60Bk21nS69roqQOzBYPchVAcYA7fvW1Bvliaz3oidTSPKrKYdW/IK/+JQkWeMQc3U4iSpwkgQTuLpgWtJ/+8xM2gsiOyZjlwnBVs7H4yLC7K+Wo1+JYdKoS5sVLL6LSvwq9VKe/I19ycuHrJ8CLMIAhJvk1NrnKoZFXI8Rx77lj8X4egtg7NgA58aAzGjnyJka7W5u+8HHAGAI1xNmWlFOv621HX9KfN/vSGxINj6tSml6xjfRq+vrwV0zxpi8v4iMvUoFFA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998c1b88-d664-4f5a-6a30-08df36902b44
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:14:54.0889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYehf16Os5qPr0bjtFKJAveymh3hYVbkzlp4uC+kUHM0DL6D9YbuujkhcrUgXpo6y5dpcovI777gOfB2q6kcp3XRyv9GaOD7KXZ3FYqMflI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9870
X-Proofpoint-ORIG-GUID: 16ErFQKTljZSJJ2SgRw2p3REOItetrvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX7Vses8bckDQY
 qVimfCNN4sF90EzEAlG8FVKYJQV+IAkj4CfKJYI8dqwM/vx+pYYM6TeVShgI1sd+bfQFbnkvN8Q
 5hr57CI36Sn99Gg3HTK5HpAlfa+XjGU6blYmE86JO8Vnmsr2yfdpAxwEEOzjJAA1Mx12Xmv4sER
 Lh9xDwz7o5m4XmOdxGsR7bqYJ6B+pjIxLfp+/BTrdcyi0UTsyy8+zmBixz+ueIkdTnIHHDxPupc
 /ZXPk2Xpn9z0ciAdOH+kb+Q0dJ3paMVDz2B6U4iHBJ0KaLcYqdNzqTO2+Peai1UzJPdZQ4c7bQV
 nNoveMIPV/goTURfj92t/Lw2s8nAkzaDSIhGrKjo354edQOVBaWBi/ZkZULS/twfMb6WP6tz/TP
 JORgchfOlPcvD3nATrU1deF1px30e5AGOB3Xfq0Q+gnogJgod34vaHvIiJLfexJyUpPho1nKJuo
 zXiB18mc/VwMjXXnHTQ==
X-Authority-Analysis: v=2.4 cv=BoYIUoX5 c=1 sm=1 tr=0 ts=6ae4a660 cx=c_pps
 a=MBb0aTAfGfB4Hxob/sbgZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=1FjsvbZJLK8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=P8QhtFtuV3VGHf9AuhIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX6vRa2P2JZibG
 1Sw7HrMf6VGklB+fyoD2WVpawIglSHk5THeg29fLMb6aT7QXfN71Cedp1w2J3AwrR4AixQM5dFf
 t/LOUx/2LNlRzawqV820rWH091V5mY4=
X-Proofpoint-GUID: 16ErFQKTljZSJJ2SgRw2p3REOItetrvq
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

Add a new QEMU_CLIPBOARD_PEER_UPDATE notify type which carries
a payload with affected peer and whether it just registered or
unregistered.

All existing notifier handlers are updated to explicitly ignore
the new event so that the enum switch remains exhaustive.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h     | 19 +++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 ui/clipboard.c             | 18 ++++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  1 +
 ui/vdagent.c               |  3 +++
 ui/vnc-clipboard.c         |  3 +++
 9 files changed, 56 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 62a96ce9ff..6166af5139 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -25,6 +25,7 @@ typedef enum QemuClipboardNotifyType QemuClipboardNotifyType;
 typedef enum QemuClipboardSelection QemuClipboardSelection;
 typedef struct QemuClipboardPeer QemuClipboardPeer;
 typedef struct QemuClipboardNotify QemuClipboardNotify;
+typedef struct QemuClipboardPeerUpdate QemuClipboardPeerUpdate;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
 typedef struct QemuClipboardContent QemuClipboardContent;
 
@@ -78,12 +79,27 @@ struct QemuClipboardPeer {
  *
  * @QEMU_CLIPBOARD_UPDATE_INFO: clipboard info update
  * @QEMU_CLIPBOARD_RESET_SERIAL: reset clipboard serial
+ * @QEMU_CLIPBOARD_PEER_UPDATE: peer registered/unregistered
  *
  * Clipboard notify type.
  */
 enum QemuClipboardNotifyType {
     QEMU_CLIPBOARD_UPDATE_INFO,
     QEMU_CLIPBOARD_RESET_SERIAL,
+    QEMU_CLIPBOARD_PEER_UPDATE,
+};
+
+/**
+ * struct QemuClipboardPeerUpdate
+ *
+ * @peer: the peer affected by this event
+ * @registered: whether @peer registered or unregistered.
+ *
+ * Clipboard peer update event data.
+ */
+struct QemuClipboardPeerUpdate {
+    QemuClipboardPeer *peer;
+    bool registered;
 };
 
 /**
@@ -91,6 +107,8 @@ enum QemuClipboardNotifyType {
  *
  * @type: the type of event.
  * @info: a QemuClipboardInfo event.
+ * @peer_update: a peer register/unregister event
+ *               (valid for QEMU_CLIPBOARD_PEER_UPDATE).
  *
  * Clipboard notify data.
  */
@@ -98,6 +116,7 @@ struct QemuClipboardNotify {
     QemuClipboardNotifyType type;
     union {
         QemuClipboardInfo *info;
+        QemuClipboardPeerUpdate peer_update;
     };
 };
 
diff --git a/tools/qemu-vnc/clipboard.c b/tools/qemu-vnc/clipboard.c
index 81a09ec5ad..3ce994c9ed 100644
--- a/tools/qemu-vnc/clipboard.c
+++ b/tools/qemu-vnc/clipboard.c
@@ -174,6 +174,9 @@ vnc_dbus_clipboard_notify(Notifier *notifier, void *data)
                 -1, NULL, NULL, NULL);
         }
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/clipboard.c b/ui/clipboard.c
index 46e602dfef..3d8f58a855 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -59,6 +59,21 @@ static void qemu_clipboard_change_state(void *opaque, bool running, RunState sta
 
 }
 
+static void qemu_clipboard_notify_peer_update(QemuClipboardPeer *peer,
+                                              bool registered)
+{
+    QemuClipboardNotify notify = {
+        .type = QEMU_CLIPBOARD_PEER_UPDATE,
+        .peer_update = {
+            .peer = peer,
+            .registered = registered,
+        },
+    };
+
+    trace_clipboard_peer_update(peer->name, registered);
+    notifier_list_notify(&clipboard_notifiers, &notify);
+}
+
 void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
 {
     if (cb_change_state_entry == NULL) {
@@ -66,6 +81,7 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
     }
 
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, true);
 }
 
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
@@ -76,6 +92,8 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, false);
+
     if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
         g_clear_pointer(&cb_change_state_entry,
                         qemu_del_vm_change_state_handler);
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3751be3792..4587547c98 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1860,6 +1860,9 @@ static void cocoa_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 90318384ee..6940f719ff 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -125,6 +125,9 @@ dbus_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         dbus_clipboard_reset_serial(dpy);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 476e6b8303..6bb3d7f3fc 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -133,6 +133,9 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/trace-events b/ui/trace-events
index 339a61f341..917d116d90 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -171,6 +171,7 @@ xkeymap_keymap(const char *name) "keymap '%s'"
 # clipboard.c
 clipboard_check_serial(int cur, int recv, bool ok) "cur:%d recv:%d %d"
 clipboard_reset_serial(void) ""
+clipboard_peer_update(const char *name, bool registered) "peer '%s' registered=%d"
 
 # vdagent.c
 vdagent_fe_open(bool fe_open) "fe_open=%d"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index b9784d4d9b..cc32a94fb9 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -477,6 +477,9 @@ static void vdagent_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         vdagent_clipboard_reset_serial(vd);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index fa05d86f42..dfe830f819 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -236,6 +236,9 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
-- 
2.43.0


