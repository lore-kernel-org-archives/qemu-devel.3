Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B246606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=eDfhYTN8;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=PkSBGyfr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkb-0007Dr-Nk; Fri, 23 Oct 2026 11:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkU-0006pk-Eh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkR-0002Q8-Qy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:01 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5udO3969202
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MKlYkso6BFihuB7O7kKzX9ycicLwAyNiUMZ/a7waq
 2Q=; b=eDfhYTN85AYA10YKwhWKO3X5tu5eyWi9w0gck7ZhshvSnbM+NmO6JT3nO
 1qGPrFJri2jOLHhg8pxSAFyKdmOJyglgbii0P/3CMtXAFgERap7A5t+0KpITpoP3
 Gf04I7GimPWJx9CAJddEdtLKUOoaan6avcI+8Emm+JwUNokz40nrsLsYHG/FBkoF
 dZNhiJNMp2um07TNarh/+TA2POOfxXPNMYQzE9EJcDFR9nWW3wsHtY8AXtTKtCDj
 gCv89jBwf6Wgq+wPvp/aUgacpIptGlfpcS1GoKxqRZcokVx5sZ7R0uITcVRLfX6N
 aO3Y4VMA6WPNJC1Jy4gnEBpmtvZAA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021074.outbound.protection.outlook.com [52.101.52.74])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf973myby-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k48h+1NE46zVJHVXD6Jncpy//k6+fMxs4HOsPvv0lXoQmLh8JuEOMi7xJ09rdcLEPyffOUd1VWsq+2+MKxhnhJ9gyo9nNjVSSIy+BuYi3p7+DuLiuZ2Nuqrv+IgmqcC3JbmGV7batNpjb4v25iHI9A0xhV781/KHbci9ajTT0OFZ5c14fRqaPsCQslENwY8VM+qbbsklM9xc83/axP1dH3bvyNt/FXe8unb6UZKbmEnzL0i2Zn9ymPdPMXZ6X5QSoqQrsAhHekQxnG6Tr3meO4V0Jh8p0ee4SONBLIy7taumbdXMg8NP5BiNy2oSTSIPRP35YrI0W3M6aGJ3dzBgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKlYkso6BFihuB7O7kKzX9ycicLwAyNiUMZ/a7waq2Q=;
 b=iJZGeh4T7yUkc+Ic4i5bz2UpXLRgVArAlLtAUqDTnGZ1EAamCC+FlkemwGYMcwY9KzCfv+AlJsaBAIAygZRSKhwhJC9zrH4jqLcZ9q8huTf4jz0rxGO+I/y9aslQkVzaw1MNPRNuIygAes0pxbTCVp9TmFyUq7B1LEhxvjVhb76VXo40a156qtI9HX9Gc1Wm9gQxAqOm1NdQyOAYKfqhLkhq8ug8JHGoW248228GK/TKYlyQWEgLcu0dBeTHADAg/TOTha7KNJHzPXmS/saYW9D8VxGWKAdyNreQ4ZEs6Xice5yYHqB7n2xEevGO1+LwvKF6+68xEA1oVcZp1dMrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKlYkso6BFihuB7O7kKzX9ycicLwAyNiUMZ/a7waq2Q=;
 b=PkSBGyfrN8HKBjkIcoptTiyEWhpcWOUyVyc7nmvVmDh5+O/jHCEyU9v6r0G9Y/6Aob7Zg0y8V+otLiIKH9PYDkaW9AK9jFHdWhjH/ogzOoj9E2HGsQkn3KR79loDATsCtzfKImIDz8+rTo5ueqM2BjxoUgwfwYW4pC+03b0kDvYG2PQ0b89fx0fgi1V805f9dX9KUxze7m05Qdp7ey4C+DF8pb4//vMA/Kn8lhR3DmEIy9R6HR0qflmxsds2mSyzK/dHNs4hPMLSRsNCbBM/mgDBGMcYM3NTLiNmWCadMXcceSN6jpTcbqw66uYwVEgNBIZJdF/UnFnjOfJWZqdvVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/28] isa-bus.c: introduce isa_realize() function
Date: Fri, 23 Oct 2026 15:58:24 +0100
Message-ID: <20261023145839.34909-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9e94d4-54ab-4570-da3f-08df31164d8d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ARlpEct3cp4sd0TP14Qk0r4yVsZMdwUf1sF2nAMzz6Een/9v8VVX9/QlofsGobspOBQx9d8uSYkJIvCNB3barSjZK+e4miJ5LkNJjKYm+bzXXpsNO9fFFT6X9vuToJHwjqM94i1aBxiTFYOgVvE8Ce41niw7tZEGkEARTycrjbG2jAtSd9MI6p0WVfPELseL8+x+bcO537KF4Qz+TqFrOW5hb4ngXwhHmX9qnd9mSuippLkkrHbUjkqy/GijT+DrHZRObA8kkN4LkgDV3x91OlSp5kRv9R6EMCHBvk2+lSDly/dSR8hiBFO1sOixwAMT63eY6HF28dqliPbmKZyWy8UF7RT0byLNeLyI2FOSSiILyQSqyZhgvIa8FLWMOeTJPWJi9qZX9B0AGR9tO0/xnZXG4w8Jeo2vMDtE/sMMrEM4xer+3a1Ixd+akKjr6Ts64886eqthZdRi8DmBT1qMvjVOmrwYsYdyA3oJRMWWEx9g3Uj2GF2nzVGd9cMWIPwN3zwghdx73C05fRjEGcvcfNTF8rkH1s93IGbo/nDTTPMuJDfkdo84SkpgTgUePzbZaiL7T6B1RdlMp/UrKrlXlZ9bcXyYQdpjs66TjhcrIAvNqoRpa9h8rSzOsNGVjtn+WFCjLd1Ilx88TMuPRTYhcQifJMffYbWI43QUYYN/8dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(10063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wt+LxJISIP00DaJvhyfQcwNVjDBpbroeMyjPc9BWRVrbkirypskhYpVuJ5Cv?=
 =?us-ascii?Q?XTwnDiJFFim/zgF+7meaNFlaXfBl7aaH423+omVZYRwAt7gJxUb+JUQbwoH1?=
 =?us-ascii?Q?76mbutnHBqI5zH6vcd9S4GBkdyU5l1rGS1gSGCK5wxcIKy5G/hduhXmu2RO+?=
 =?us-ascii?Q?BNssgKRrG1Oyk6kj6CiueUv5OZbqYwCteaukmFu782iSQzN5ni1273BVGhhw?=
 =?us-ascii?Q?iknMyIT4pFrv961VG2/dg/GCuYzLav+PMQEm4EyWBTMHhXdFmCyFJIpd0LAY?=
 =?us-ascii?Q?TuCAqHKHaUDIrh1A10s0yPgtGZaBBfh0XGHcB1d+hlyXsutUUuKL+b7rhYli?=
 =?us-ascii?Q?D1TyiL0ZpivvEcThsAivETIBAG4I9j5wVxX1UuSfzvBpF6r9cw5r4k05hR+4?=
 =?us-ascii?Q?52QKQebTvsMKsDLQVuaZLLgVj2SmNX5bXK6Gz9eSZiyqLRMN4v/UyqUI241v?=
 =?us-ascii?Q?Z9fWpabVEslkGdICBM+cBPflNqK+Lmojl/G5+A+HllkOZ/XrOpFiaMNLNLUI?=
 =?us-ascii?Q?bwMXI6w5Svvuxd/RCY6Yb1u2/WX4LofzUkTCgDXm9gEMFnY/qFrPl8XeDFV8?=
 =?us-ascii?Q?PC2Ud68oHyUPg22NPS+NgLT9DOylV7zXQWssnG3UgPMpEUxvjczxo0r4APT6?=
 =?us-ascii?Q?CGzJO84EyyMhJUTTEODy3ybKM4l4c/TkEQEzPbMyBGQ4trT1UhOamJ6t7EfQ?=
 =?us-ascii?Q?Q4kYlE8caKDAE3Tv8IowoUgZDa5lzfxJzMjg0wjcUoqK0zbT+FiZr1Ifts74?=
 =?us-ascii?Q?cvw3vlFMIp7GKtJBWYdfxHISd2RMnmWK/7fxBHhHFvVe9yXT+VGrRpnk5VbR?=
 =?us-ascii?Q?dy+TpO7RiM719xTxU4foGoqMjGG6hlelU5GhnvcQCyLOnOKkF0KT83plDuWX?=
 =?us-ascii?Q?WYAREUPW5IaxUEY84x1c3sJ00zUxgKZncnUfERLknliuZl68h46eGUPrtRoh?=
 =?us-ascii?Q?KyNQKZSSx9PfnlfMtqmZxRnMCCOSlVtpMcmHfB72wgVYhaBxBYfsnyzqJupV?=
 =?us-ascii?Q?BasLjozzxeIrp3o6IukAntDBHjNN2ov7+Mv4wecTlIoitki4igitT/y0Ev2S?=
 =?us-ascii?Q?qPEjPnGA63TcfkmtgmhxYqz9bLwtPwFL9etIeSdR3s5bwwI5c/+1Nuxys5ER?=
 =?us-ascii?Q?UqGz8DZ21ckllktUzfNbzr7TxWfDu/kRrZWqcB1mJlTtepNuzcuZL+C1tlew?=
 =?us-ascii?Q?W1kB1nP0Tq8EyKMIJgNUv4emXU+b5KV6S1zXkEFLkyuLnqkQJw6AVVAeQWdt?=
 =?us-ascii?Q?TzZyrkbKVYUFtLMFMiu4BDPQBXq+RBSkmfgDDpLr4wR6pY3JDee8NNo4qjKS?=
 =?us-ascii?Q?hoPQSYLrv85eUqHFa+yc/1eXJsnTBOwr46DoIxVHA+jkYRvFbIlkvCnITE+k?=
 =?us-ascii?Q?91iaMFv7idjvK9wA6FdBn77LIrQgYyYd0ajDqsh/ozrlY3LxoBMpqUbSWpNH?=
 =?us-ascii?Q?CyTw8POoeo+iDW4GFbBbpzBfhYsYsP1yRe1LFJIUU49d1MCqYNKTJAk9l5Qu?=
 =?us-ascii?Q?dx7Yif1KEJ4ePWyyyYav/9ryeqX/B/gchEDQYXq/efX+GlslhHBovNaXSBGE?=
 =?us-ascii?Q?4ontdXzGrjTXBPMBN3Om5MADfCmTjUsOD3fZYmVVPfIvj4b5lmN4qoiLYTRQ?=
 =?us-ascii?Q?G2wqYdxLdDPnGVz4Nmd7qSU0plbfDy93YKbWWHhq0jbMi/RUfWDsBOe+qOSc?=
 =?us-ascii?Q?yTNefxo2M1W5KdO/f0EkDhtvA/8cgYyzIe1j+I2qqh5DusAJQe86XhpatJMI?=
 =?us-ascii?Q?vqTuhlw208Z+8bOHPvUGG1n9PPd/9AY=3D?=
X-Exchange-RoutingPolicyChecked: KKQ00yVuHT/A/bWdViruMMXxg4Gmt1M8ZyEA/wnXrGOKo+VTvmH8wvAe3QoGZhwGLwu1vYpcttBX8gjQDA0cvFm+R8ff0MiIn/+D0KOXBtV5tFaIU9ws2OS/TAq+0c82/kC3QBfuMQLqtGVqGMHW+tme1mXZ7gL47TvozQtK+LiyA4zkrQzce+o8LNMI2cGlnGvU1X61q3dP2SHvd0qq+bxjXGvQIFjLb7YlAH2pvSGEtXVt1PMCPV7BnCw1IwsVMsgrB5GAM9Lu0kA7K5qTD/VP3jIhMfvTV2V96g01unWzQGk7RQlbXMRlgZiSTSB+IdyZn8zidadHHdE+m4Whlg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9e94d4-54ab-4570-da3f-08df31164d8d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:57.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av5l1zfzcq1HOOakp8Iwf4lfEOvU2zhkFdUGEoht+nwVoViNO41xdKyR4wc1OAGRvrZpKgbz1V4YSRWczom5Npne/+yx4pbZgdkcatE8aNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=E8NYNqdl c=1 sm=1 tr=0 ts=6adb766e cx=c_pps
 a=b/aSlx19e507fu+kRueGxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=E42jAAAtX2bsQao6xnwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX9gcwVodPeAdE
 FFuDeIY3Ua81As0+1mYk2DQAGM5sLDyav2BzheraCPKZw8lwJ7+i932Cd81Ku2Flvd/4H0FCm6o
 glbK8BuAjIWK1wt8evzq1Ks2WoNa8Kh4Ve9izrh0sX51Aq8fsU4eKG5a+Smjs45Qty/U67M5Qhj
 5aRQVhi/RTf0rfw5m39cmd7kx4Jb5LmHyj4FGVidHLq2HqpRBYbuLzNcBtSVkmruQPbTE9KWVsp
 PnUC75EkEDaptR43gwTvU4MT44nFfySPJ2L3DjYVdhYcu0ScNzfUy0theRrFtbcx4yeFYJEDdmC
 cbmh4MaTFLKZL/k7BGiFGObbZmv+HWujeimsglnSipbcY0rj7nnBuSlTRtD/HOSrxI+6i7AKtW/
 nk4yHRiiVixGjFDLPY3Qq/zCBjU0JKm6UqTGhS+MhFry/+X5TGaETke2dlmTTADkj45y5nlKtGg
 bRO/7kFQQlONukj8JLA==
X-Proofpoint-GUID: usUjDyME_M3s8_b1jN_rKA8nccbKL4iU
X-Proofpoint-ORIG-GUID: usUjDyME_M3s8_b1jN_rKA8nccbKL4iU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX7Vl2XYsVgbkS
 k5m//HN7vR+NHxKtoNNUx+MA8ak2WLGlcqilYO+00ji+JtINkLdec5ZZrJ764hlzQJ305huRcOy
 cxvXQJONyxaUIj2X/B4N+hjKnCoWcbE=
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

This is required for implementing a container device containing one or more ISA
devices to ensure that the refcount is handled correctly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-19-mark.caveayland@nutanix.com>
---
 include/hw/isa/isa.h | 1 +
 hw/isa/isa-bus.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 94bff33fcc..a3d54110fd 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -82,6 +82,7 @@ IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
 qemu_irq isa_bus_get_irq(ISABus *bus, unsigned irqnum);
 ISADevice *isa_new(const char *name);
 ISADevice *isa_try_new(const char *name);
+bool isa_realize(ISADevice *dev, ISABus *bus, Error **errp);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
 
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 7e6d2ce5a9..102f4a0e0d 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -172,6 +172,11 @@ ISADevice *isa_create_simple(ISABus *bus, const char *name)
     return dev;
 }
 
+bool isa_realize(ISADevice *dev, ISABus *bus, Error **errp)
+{
+    return qdev_realize(&dev->parent_obj, &bus->parent_obj, errp);
+}
+
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
-- 
2.43.0


