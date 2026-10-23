Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62C606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=at21Uwfc;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=HkExFFNt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkg-0007kA-7h; Fri, 23 Oct 2026 11:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkP-0006d4-7c
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkN-0002Pk-Ku
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:56 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6XVr3757984
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=r+GSiPi90YLt62JzD1V/G9G+hqNZtCn8nHDamwsQZ
 Y8=; b=at21UwfclYUeKNYP42aE1EZKh61BmMPU5/KjJLuuMhEP75y02HKkW1bxV
 DwaAL9RW7J2Cu9/gBTIcB2loShF0xpD7c5f+w5DmE6QJQdbLV83ftZO2/unsQTzw
 rWxS6hlngyBOd0f0E3E5nTdIenXS9momsL18NF5cFfNjTIk+zyqeByUCDhAIseXF
 mv9HwyEGzz4y2RZtnjrayAADZAiDi5D0niCATuGYPHGlE5MLEh5BUIJFjVGm2DDc
 pRyAWXpk394/1bd5ZO0InrI/PiKG6Pc0/FK+siaBJH70O3M3FdYLZxb9tx9bjQ/N
 710w1m3oa7SQNAoUfwj7szXocZLKw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021091.outbound.protection.outlook.com [52.101.52.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975cyxk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt5dLx9LizX1hwVJx+gFj044wDyjsIV/+Uxl5WbPydN385pY3JMY8QxzMKKHVarxQPMUZqTs3h+D2Z0qeSEIDgQLle4yDGUJFnCG7S+VWcHI5QYGjgJRJ8C/eBrTXenKGPn7k+2i/QGOpkwX8E5As3LtKtPz2YgFgWQY36DktqgyxQGCoh9yChaVVz9Npb7kgiWvx8OV2NIBna6w03X4/tavgY74bkj3o6Prjq1X4XMDYYRqHRVdczg0ASuKd5beScr1kp/Q7lu/wAmxru2HWt7tO/UQXIcE10QZjhY8CuLaW4lJauBRjPkz9gML/mYxqOHeHfTrPJHU56ZVRQqxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+GSiPi90YLt62JzD1V/G9G+hqNZtCn8nHDamwsQZY8=;
 b=XAO3OfTSRqUgB/PPrdZkh2zpoXnptjpvYgP0X9Fk+Ue+Nvwxq05zIDNVGAlP5gL2AsVj6CwQKm7wcEQ+7P41DxWES6A9Fq+eTwMrMj4v8IH5tDzhych1dgOej95mxdcYEYpwwGjXJvYuXWBWXmlN3HX2i0a9EZiiKZsOyKs2El6X3AGYVY/E5BZAPaE9OZnKO0fgWQxGEJ4pUKWjUCElGHyi4044n5iIswon0GwV/KPCgzmggSAkBMHzQ/tYJ0AhGMPN5OTcxM4xjmy63TyoXw69NznXihQWxEcfKvXM0O0Pm/2RR9KZvHFnFBl+2+qoafKqhg+G7XHeO+EX6BjPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+GSiPi90YLt62JzD1V/G9G+hqNZtCn8nHDamwsQZY8=;
 b=HkExFFNtBruI1HSRdxU/LfvcpFg2lSdS2dmuinwggSistcQ3WYomASMkXalQ5eO62l9Yi/sjdYka0eA50wVaHMbJ/6bxwGQeU5T97QG9QUHbDZaLWX7s8LUpvxC/P8MzgFcDjDRJvzyaW2dJquHXI1BxT9PYkkoIHe7fYXXPulePSrXSJnjvz6/ybjwPSeYD/E4FJMeQYWbPdxUh4JTWsi8mRYnEnZZ58cmM8Mrrumy6958wWAyp6mKPuJQY6U6l3Z04PFtvzZssFmtA2DqZuVjr/GrFjoYGQeKAlP1/cAXYDw/siuvXRQ0mYL3iY18EuHKciN3Oq73SkAyEkrvRjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/28] kvm/i8259.c: convert to use DEFINE_TYPES() macro
Date: Fri, 23 Oct 2026 15:58:23 +0100
Message-ID: <20261023145839.34909-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c73a25d-1eb3-44cf-5976-08df31164af1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uwrQKBoe3Vh759b50tu5k++90WzKMzzMtHh8upzWt0TWHAkYi6U8PDdi8YP8Ip1jFcMzCcwLuEXuJ9YBq5Q/HtM5z32QiP/WQvAmc2jmBUEovWXklqzkaKpa2MbLBCzy/TwH6PEhWCP9SP9suyabc2fFxlII1D4xzXFkSmJyCls/ugPvcFE5xWE4Ni8Q/5CF0v38ozQ/wbZj2Sk6WwxVmHwvnP9/CD++74oXKeQYGYk2L8mwJ5x+imGydx6PZnztf4+DKbnKdAQOTKjrZZ/Ba9GmfEKKTiWEyNLy5uc3YsMkdX8J/do2UEh6FEsvzNxDKRTFETO6INxy3uNNYOooiCNowxYx7qNydGy0+/fsHByoOwzpV2Vie1Hosgy6xNVvTTPqWhWy7mR044gFGHXFrMGGoJBYM9T+4CJHHsBwEjGO4YA6F8CHOjEtom/ziKf1Qx77Loy1445DxrwuyscyHOgzROU0V933Pyr0+jEV94AV1yeKwhC21+MyTYcvDdJ/Ak/T2fFEYiPv6dsMlLZayCZfwvf9TETadQ0HN40oChzieSCzZSEtnEhMrvpGOeu1BHDGqkcmoAIzQuSClkePL2TEat5epq1SmqTEyYp+drAokKdpCyr8yDFSLW06643Jbi4U/B0r6QeQDf4RspkJ8NGMaPa2VeFX5P2dxY0FhsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LQRis/n6ZswujnNskViUkalR0ORkHIHVOmKUd/BNdhLjwxryIKs5APZXZ32?=
 =?us-ascii?Q?RMXc5NHzhx0Ez53FCPDCuqIzA7sY+/PA4vV+Ml+2UD5DwseYVKkWbxc6vjS+?=
 =?us-ascii?Q?wcdOTXld+gjQNSbbYdb0zzKenO2otRVvsi7YR7qdEXq0SsS3Nm5Zydyj2mJj?=
 =?us-ascii?Q?4bAvZ+YgoOIVTv2xkfyGBvaCa8r+VOROVgP7yBqa12/y2nB7KOUkCt8atEPL?=
 =?us-ascii?Q?ARHj6+hHxrwju4r1IWAT7M+SjJsBWzLRPN9Fich9QApJb9ZKKvDeEVQkDR2A?=
 =?us-ascii?Q?23WhUjt/mk0x4ksQVB8Li6cQIhlA02DnK2zaQbQTjxGQrmwRghfpVzoR70Hx?=
 =?us-ascii?Q?61KHV9lHAD5GM2yZF23g1j0++YrqZomxh+UgKetxX5W2dPdHvs+c81ZBCVNS?=
 =?us-ascii?Q?C0YXwc9/dyYA68nieX4ySfXyqxdD36bplnCeYLBzINxOYRKsicJCLRTdwJ5f?=
 =?us-ascii?Q?mOcG9CYC9xKY3eMPsarPW+Q9QESljHQteylmTupc+12OBcSRKS85LfIYt9Y9?=
 =?us-ascii?Q?sVmPGQ3SgYQeUSLaR8SfiH3+jBQYaE9qZu2OKkPvdV2YevVjB3BOOVqglSSx?=
 =?us-ascii?Q?Dh37aOF3qiyHFnP4qcdkQLcRVCc8C5Gt1zCncfVLAmmIVVaBkDoNfyTUfq8T?=
 =?us-ascii?Q?AHAl2LIHcEKYJhZXegmadp74xxODNle4zF8TuEPRUx4Bsv01GkbFkAj+Yz96?=
 =?us-ascii?Q?W5YE2Qvt2RgTrn0hc96xBgw5JFa1yswX7Pl578hDq6TtYBOHFjwRj1KsvBG1?=
 =?us-ascii?Q?fyERg5PU9/7ebfcyze0cZmOp0QIaIJofpr2WheKXiL4sCRl3F1Hi2GT7+iqQ?=
 =?us-ascii?Q?rjOtDx8sd6lhNxmZNu8Xgwr7RNLVMSz4tdrujCxhiA68k6JXoQU0n/dmdmpZ?=
 =?us-ascii?Q?367GKM41MyzfM72iPOdi9hJkp69O5w9/G/XYYq86oIwJFqV9lzs6mN3uD0wc?=
 =?us-ascii?Q?nBvxDg0od5NedLtNQDLZjdOc1DJMliFQK4wALsXDsoNON0n0gK8fWLERh5cd?=
 =?us-ascii?Q?2OyKKzTkYPgQMS7PJ/0Kq5Yy5CEYp9zuAjiTdy4q3LScx7UhI8YqwOTQbqyI?=
 =?us-ascii?Q?ZUrHhmPfR9Bnt57QOXmEycpiHQfNDa22l8ptDbXtmSuXQs28bqoEDonBkOoP?=
 =?us-ascii?Q?wQ+0Dtz7zyHLQtrhn8hUoZFnRei6LgPZm3XtNLLw18uehumiL20cn0UvlqZm?=
 =?us-ascii?Q?7WlpQnrqhWV6gK1NBLG2lV5bDGS63u97/2mEU81YvZX6I8ynDb6HBlUDSrTO?=
 =?us-ascii?Q?LL66TbFAnsu+W1xEUAre9YeCS7sMj9ccQSyAXVHsova+3vrfIiaoG+lxcAV7?=
 =?us-ascii?Q?vcCRTLYeh/+JN7C/EKrUcwWl0nOphrzFCAWrqE2hfWUOARBtuLIYX1rYKAWL?=
 =?us-ascii?Q?DGYzCZ9wW/s5PqkR+W16orTUvmA6DLrKs7tc/MHTUAdyOwaS+NoCLa7xugM+?=
 =?us-ascii?Q?B3S8v8ww6QN/FB+Fe77hrHg/Sv0WXIGZmNKBe2L1rPwYQeWRdQwKZjMZ5e3s?=
 =?us-ascii?Q?V4sIBIq96ssSh7HMLe3WoCv2ASEDx5Fzp/sBIQbWqM1NkGYL7IKF7pChwZ+R?=
 =?us-ascii?Q?ZbVOdrTwXN8DIK5p1LA49n1FsPNu6JJWqxaoIvM1h2TibGtasA7we4ioYM08?=
 =?us-ascii?Q?OTpTMA5oSrgym3klNGn6w0rHRrlidxyoaMQpWYgNBxbPEmLv5rZASvRO6OE9?=
 =?us-ascii?Q?vlerHjTcEkmmXGAsRe1a+RVsjzHvo9QLFPD51hla6TXasKRgMsdIIlMU1DHE?=
 =?us-ascii?Q?0qio2Al1AnjTNyn9W1Zw/68OVLB+bw4=3D?=
X-Exchange-RoutingPolicyChecked: lNCbR2oI2GOmC996t7nsSRbcF32bNt1U//HNUoYlCN0AxfQUrdKAGVy8n47a8Sr8tGrVwY5qiCVRGeL3ONBqUUObxRW6CBbgIXFT0/gsaKRmkIg2P0d/sKRapCs2hj0ZoSm6gW+H+ihO01ei/05ombdmd72RD0UanB5D5f80/vtmY/IYYVSvWCVpV1S6hABU1Pl0ZISZ8cqzmp/rn6y4mFWxcyse07noM2dHPGHlILy6HxWuFcucZ0rSBRJPBZR0Ah42nB9dRoIKj/OV+g8nhEbrTUzTFRFnVBUIVZkfrI6KWcCgSvI4UP48HdHFAguFK9wa6icEhBsCiUMXIzYFHg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c73a25d-1eb3-44cf-5976-08df31164af1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:52.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlrnCYX38HXIcv9s8TL0iBRmu+mJb1W5yR/hdSNAeV3ahJ23u55zkJ5ZPFyG18/oG+ooLn1tfYGJZW01s7GGZSu23aVAO0mQ2SoHggLwoG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb766a cx=c_pps
 a=xaVsnCbK3fgrqDKomIvovg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=CQnoaSmAlUSJywai4vEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4pDdVxBCGL8I
 xdxMNbPzIfVkNqblYKA535DI0qo+28Hyv3CXzsFmBqjrDVsSQyOIJ4oF9UBTolLJb5GGFwqUYff
 ZbqaN0RwKo835Qev9R5HXm3F6S8+agwPKhgeETC5XXRTQg5B0oMbwlTMjRTN0ElNgrCrZEt3zFf
 nTdBA1l3xAddKXe8M8sOIhgKPBrN4hdkbWOGnYltK13bKnmfA1jU9ik7N/x+fMcjIc+xZzEbT/6
 7ja9ixxu2n0xfUUWTOUucwHoegWeQrqWWbKSagDVEkg2SzbtB4ifCAbbpKyJkpj80dyu1zLWoh9
 B9l1z6WrkJr8Ezux+u+xYN2StAFt3qpL1lKYsBz6xBwY/f+KXqtlQUc7fm9VYkWM/Qg7SBh7EGy
 a74TVgcFNpfwVIIl/gBO5SqHmIdJ2l4pKxC9KGY2p7Y2u116aGURvMZxjN/o3EOhf9lkUejQy65
 gS5e8BH0ZDfn8+Fc19w==
X-Proofpoint-GUID: EgCV_f5iE0_kEI7yz3Fx7vKfBiUDn2VG
X-Proofpoint-ORIG-GUID: EgCV_f5iE0_kEI7yz3Fx7vKfBiUDn2VG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX/VZwIO/ZJgw9
 epYPqnRWLCiQKJQ5F0j1Lv6i4x8bFu7gPbJK2lUzb2avt9Dq0Mn1YmWmltqOiBNa9dOoDrC5uYW
 oaamIdNZxbVPq1toa9lROCIRccMNVVo=
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-18-mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 952f58be11..9ee23b5695 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -154,17 +154,14 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
-static const TypeInfo kvm_i8259_info = {
-    .name = TYPE_KVM_I8259,
-    .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(KVMI8259State),
-    .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMI8259Class),
+static const TypeInfo kvm_i8259_type_infos[] = {
+    {
+        .name = TYPE_KVM_I8259,
+        .parent = TYPE_I8259_COMMON,
+        .instance_size = sizeof(KVMI8259State),
+        .class_init = kvm_i8259_class_init,
+        .class_size = sizeof(KVMI8259Class),
+    },
 };
 
-static void kvm_i8259_register_types(void)
-{
-    type_register_static(&kvm_i8259_info);
-}
-
-type_init(kvm_i8259_register_types)
+DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


