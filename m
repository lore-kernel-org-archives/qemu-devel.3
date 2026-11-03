Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D0606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=v77B3D0k;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=hVG8ZXNb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGmN-0008PO-Rr; Tue, 03 Nov 2026 10:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xOGmM-0008P8-9l
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:50:30 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xOGmK-0005ng-9F
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:50:30 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EB5n7267181; Tue, 3 Nov 2026 07:50:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=AprIct9rb8j0c
 XtEm9Dm2VX9XPNd8Cf2f9tNYhgqtmY=; b=v77B3D0k2Av0GNzK/CrMWo7NL412U
 uzmBC9Xu1qOMPV6USzfSD5TJBDMlyZvjDni+3GdBIpfnBU1noC3TgvAvpNQBSMFB
 6Ah2cTVx2znhTVJ/iixm1LB0Wy2AUO725ZRscxcm4pW7oTknJ61DbljO8C8xwtJq
 rkVO9Ynu5UkN0/L+uY+V6F/gtpN4ClCoQZytuSbF3UAKRGH7OpRgwR44sUS/zFfA
 bMomoqazvy/ZFCMqxu3H4UiU9q+VOit+QcRfKvaBzouJwvr3PNcebglmTuXX5w/w
 ojTgFROozxgZar+Bc3ucJWai2in3nHf2B0MKBMh2kd0WBoyrK6jBAYIsQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022103.outbound.protection.outlook.com [40.107.209.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hqexsgjdb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 07:50:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ4Sn5vRe7djNmwimg7dATFfB8bqqgkvX+8s+S45fJ34VEh052MktTMWulx5rcF+gB+XuNz/ybV6/8yUfg3++pv2ppafVCwDn+V9/sDjb2u35bun62gPeiT5Gp1brGxbLigu63hWXxbPKMz7ArcRoU2ivtB8iCMmTUJnaEdBGxhhsak9ugmFlzHDaQ9F1dDbP+7d/EF7oNvC9nWaUIgEotSPb0jQICW1GJ6w56bawWZh/FsQLJmK2/jAOIgHcu9SvEbiZziSzBqbIKBxt8bzjWRJA01vpCEIpJ0uqdDO1YHN5TsqJMaHKWiw1alviSfQf4mz6u6Kx35QCqbMUxBKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AprIct9rb8j0cXtEm9Dm2VX9XPNd8Cf2f9tNYhgqtmY=;
 b=xjm9fQzvni3Qan9a1ZZ/mt9CvWrH/TN7MLu0NBI/Hgf1Kt9dTb/Q/l8CIG2EzJGUYxgfkDSWxGrINYgSrIQHAh5jm6XzTAr7qxw65arPK2S6C8DkiJUMIy4sOgR0awQBpg7B9BSIZOG/+DGp7wlX1MmF2zf/BxE3aEzNiqsJ/9zjsPLJE2fIKUHuraSmbo7mLG02Dj58Wh82E0186AHUEBI19+CwlSsPTs3Na157AxPuRkOpWF0x5PZTxbOdeysFt8MtWNLJJvCg+CLxL7DfdCmGW18r9YsVAnNyDhXMYKWZxBBGg1tjALfBzwauf6Hm+1vCtcKSvUq5fPzEQoNp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AprIct9rb8j0cXtEm9Dm2VX9XPNd8Cf2f9tNYhgqtmY=;
 b=hVG8ZXNbfzN1Co0SNGPmlDah2yjIll99Sh+TeqVb/cvEHxzjIk9Mg93vqebe0bfpV7gPxA1fO6AIBDGTFf/CUvBdvHXvNmTJ9m+tnm5xvk2fcFm7KE5Il9gNXxDy4g3DHLkVVir2B1dyDOe2+xFVeRQKDNT6v/RuGhrTpkPPzkJ6M0yURfYNi077pwH/2akxPbJ0u9clDAibyk9k+wnpNOvp7qlc7mEN3NUFp20wMjWTcMk4msXDHeFlXVhyn4Xb2Xx2jS6EL/O+G6ygyZw8DADNICYXwstAJIi8ZnwcF3euVa88g5O9dCzpu4LQN+ZOLqYS3VOmayEArc9A47J0sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS2PR02MB11186.namprd02.prod.outlook.com (2603:10b6:8:332::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:50:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:50:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: peter.maydell@linaro.org, mst@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] i8259.c: don't leak I8259_PIC output IRQ
Date: Tue,  3 Nov 2026 15:49:40 +0000
Message-ID: <20261103155018.1454989-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS2PR02MB11186:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4a03e8-b0aa-47a5-a99c-08df39c22b24
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|56012099006|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: YWR8OuvrG3nA08d43SFMYE6hub9klgiDeG/S4rxKf/1ncdcEEvdGD2v7u8HhDE3zDUzBoorQMvhgme6LGFQTCDzTsUrl0mv3MXHcDA+NmDklyomzD0JHSs/3xYp4oc7+SQuIhWOF7sxr/aEeOWCyLFAwZwCIeVUaut3ue4XkTfcJYYhU885mI2vcTuLNjw33neT15uUXVOboFcvCGo8FayRre6B44saCMLYmUfPDf3XiHw6WoEt2QlvnXzZjS+0E2jSp9fxNAkLD0sSUr9Oh0wp1Vfk7GTrVBVanXZ/0aAyURDXvfd4c935nvZKCZFsZ7UWtYmIhfM5+Q9T+1PGvliD/eiEzQaevriLKhWuOm1atrCknrkcHKY8Y25DPEbtJI/Jpo5xUFCwPREVyZIZi/HaNyQqUaxi5C0tfQv32Xo1uF2MsiuHApG4GN6hpgRSl8+Jmm4zU2O1h/HlckZugOz9YH5FghEzq+ttzqZZ/N8TJizCSKCFu2Qmr5ZPPNgtLcR7N+5OUn80bupXoW+9FtSDjBPmEkdJ8bN5XR4PuvPDe1pnJRUTxRzXCtID7NNwbCjN4JkkwXLZRGloEZsUZnoZ3r8RAitQe4ZzqIjWJXbZqpvSBK1RksS36UXqOHiUDwj1yArMb8tArzyxQbMdyT5F5QEuZRPzX/L4LQ2kzEtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(56012099006)(18002099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFnj5n1qBrEs+5MY18mSvp9+0Qyvhum70BbE7j/gbAJf+0UU3N4Js0h2uMCd?=
 =?us-ascii?Q?wh1GtzInYwiOXVqZwitKVic8OCqMEtep3HuJzPtm9f7xG3xGGJvhBACbIDHV?=
 =?us-ascii?Q?bv8Zr/ZRhOT6TVn5g95lu9HCXhoViLbx2pCZMCsX7SfO3xZVhpFc5M3v4RII?=
 =?us-ascii?Q?TdbVzPBLSZHYSne3hJ2eAUNmpnOhF9za3O0uvMLDH+xC26WGxp9qC8S0Hvre?=
 =?us-ascii?Q?+hJRBRwLD5RAWSouBRb4UeLAwlN/FZJx2XbfjvxjIX3TfROiLJa7hyH45eXL?=
 =?us-ascii?Q?MZ1IbjJ9kdgLdmzD5tqu/Z+XuHopEZrbIA5rm7exskgr+vYETeAX9dIGaGeX?=
 =?us-ascii?Q?qY02TAI/qk5y+gJ5uESreWX6EMoJo4jXyFcMkkjygD4u+bU5RrgfGamiQYl/?=
 =?us-ascii?Q?ugmEQJXjjlKKtq8vsGLdcIKuFbweFUIoL7I5YgKAFSTD43FFR/oElDYMVL+2?=
 =?us-ascii?Q?jeZoZH4Qg91rXv0GzUMX665vxoXKP6eFOyErWZmrRGp2N6t18iROVvGB0QVM?=
 =?us-ascii?Q?6FKAQ55CjLNbjtnbxjmOzG6gTvrzo6ReDguy36Cz0BfCUY3yRTWNEk+Gx1jV?=
 =?us-ascii?Q?lD6Fj3rQ+x9n4Fl1EKHBbjeldEvfXuArxGvevRT/yiycC+H5zu7BA0p02TwY?=
 =?us-ascii?Q?Cvt8UlpPSZX+NN5zSyE9ixg43gJ/CIAthTe/SeJ/KDSkyr6353tdLIiIwbLP?=
 =?us-ascii?Q?EZpovx1B3bVJROMViBhOJ02BqSw+p9vULi/q686xhIX1wFB65btbjWFIDu2i?=
 =?us-ascii?Q?VX4sS9wHavCkBC5BfaUDralZEI7d2x3UJeD6PXIjA7DK1V+abS2Js4v5A/s0?=
 =?us-ascii?Q?1ufmA1S2UpuxXol//xh6ye2R8ukG6KhB6pTTL0eq9uumlOFGtkn8kNPALuwc?=
 =?us-ascii?Q?6n5IvPORxL705DQ5lbIJjXATdhI3ZDoxPuv9EobpqHhsnjh7TLdp8EV+MQpf?=
 =?us-ascii?Q?/o19xCA4hkyYKUVs1CocG40b4M9QuaDTuY4/3/G7MRhii5A11SdX3BkJOcJI?=
 =?us-ascii?Q?ARtyG+MWwh0J7Dvg4AkynD8NmpF9Q/Ag6xgrPTy3w3hDF0nuhpGysIKQfQEW?=
 =?us-ascii?Q?LWcHWIuvCbqH8nA0noJfXwTqv/Tgg6KyUaTzbjpZ9wkgq4IQzvCz39SUuPJy?=
 =?us-ascii?Q?aCv/67UkrhAlqhMiiM9qDn8oS+3T+0I9bUHKBoeRGCLB/stOFdnCDQ4EkO9J?=
 =?us-ascii?Q?9Foa+ECNMKmvOv08wNQwep7hJMwFi9Orw8c/capzxndfXoD/ZoXGSEOQ/kjP?=
 =?us-ascii?Q?66AUtU2JkAiGPnpdRF7QI3ezqmXZG23U8s90Z4NXuz+WGzh3dkWrYfbNlHO+?=
 =?us-ascii?Q?i64ZIUsmcewzwcfcLcmWzPY9G5b/ED6ydfcKcOaepENKtYP5AkxJQ8b91X90?=
 =?us-ascii?Q?N+4YWHrwjQPUV8/6/D/UuMBlo16rhuN6DjlNqYOSTIv8nppKmsZFcnUDY/9/?=
 =?us-ascii?Q?1woP0ZJQsLuR+kd1N/qiPTRx/Z3R6ILFrcstSIDKK00FffOz4/MeDWcoAADf?=
 =?us-ascii?Q?+zvMSYaORVCKCvbInf1RLRv8ZRHZ7ex1Wg9ha2XwWTkKLFYqJ1Zt9aiRlWdk?=
 =?us-ascii?Q?f7VF118ZxJTM2oI+Hk8haKYrIDvuHg/I5XiWBHQEovCMuL5nec5OgBs+P/HJ?=
 =?us-ascii?Q?yHL5pcObloAPCMuLW607raEXh/fbGKrCvOZOZ1Dzrj8Bj4Qi81kwhsZufvVs?=
 =?us-ascii?Q?zNFWbEOgBi58VsZ/X4xiT4r/WrfwhRSN4T+6hlMlPkaJSed0SOhqVf9myUIR?=
 =?us-ascii?Q?zqx7JhlS8X/XSWi4SI55wCnsNMuozfA=3D?=
X-Exchange-RoutingPolicyChecked: dk/xEkl2+PJW0DvpLHuVYRZPmwiFaaUh7+f6fI4ht+sdrWlpmPvpTR2xIoYOyXkD3f+xQ6ZmwkTO/eUz2bp4CsgToA7+I8S3ecderKR9pJBOp8oiZixO6lZov66yZ/zhsHEClqSZFHzX2U16MrglK2NXobkBcGsmVIK0qcQ86gmVx5fSsYzygsNp09LUtblznCQfp6dhu08InNObfzFPwwePNFgHH1cURbekDD9eFey2gLB3yP2vEYoZfXoLI/MSF0JJBwpbek3azSNmqgI4Wv4fl1skF9gu+OEXJjRJ2MHGQLt47K8bpyU2IHMor/T0hXX8afqF2E0gDxysi1oQfQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a03e8-b0aa-47a5-a99c-08df39c22b24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:50:22.1356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBRP3T66DnzwBfEuq++fHCZOlj1nqg53dzXi5B9C4S+ZOOktwo4E7a0fksm43qrDE90gvjzb1w9eW7VBWDK8Hnk/iQjxV9uIzXz4ywEXMwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB11186
X-Proofpoint-ORIG-GUID: ZLeXrZ_yS4FHSMED1H6hKJCb6v61VdFi
X-Authority-Analysis: v=2.4 cv=Eu5HPicA c=1 sm=1 tr=0 ts=6aea02c0 cx=c_pps
 a=xj9m5St4rme5bLz9Jope3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=wCg6TemCCvBGOyPmVOsA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZLeXrZ_yS4FHSMED1H6hKJCb6v61VdFi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MyBTYWx0ZWRfX3N/rJ2IHbdu+
 Ueln5I7uRvy8dhK7xU8osxa5AWv7olpfCiKYpNjcF9H8ypJS9z1qxUmR3wcQa0oHjtuZYpgpfZy
 c3NH0gspzcnilQXiPfAIwsiSD3zhZ1Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MyBTYWx0ZWRfX45BTb3SOcMOg
 IY+I9nor1exmZSx4bg4QPE6Zx9f8xZzXR7pG03hTN3Ds70B9mPlPDSeviIy21eBYCPucQhx1pTt
 cWVPkIf44PItL2sbCepEBO9WyY8x+fVbMneRZt/s65DEFUTU2KwgSFr+BlKPTrbMnLuYYD8cZKa
 R+hV7PInnlObyy0ZecFO+PBHXUxcSsPpwMagiiCyIHjkzCCQZQqdDLao635pn2Tf34+3z6bc1xw
 cmEN+qGFnumjrD5lcKFRNNohZJfzLZ3IxcC9KAaV6l68jxeIgnyZdtSFhvr/WDYPLMJiU2PgQ8y
 X5yZ64ZHbLig2RF4T9fhu6LThnMoSQMUO4lSTFI0GCnQHjnzsVltVZQLk7ElllZQA8e1jUPEhCG
 BygXt0hViSzApMUec02tSjvSLaY+BG1F5YoRfrJ8Qb/LZOLK3GxZDzMC0cbn6lsNM+gQJnrmNRe
 0DXes0Om+rTjOM03/+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 54fbbb30d44e ("i8259.c: introduce TYPE_I8259_PIC device") introduced a
separate output IRQ for a PIC representing a cascaded i8259 configuration, but
failed to free it afterwards. Use qemu_init_irq_child() so that the IRQ is
automatically freed when the PIC device is finalized.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 54fbbb30d44e ("i8259.c: introduce TYPE_I8259_PIC device")
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 79b5e603bc..6c784ef2a4 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -491,7 +491,8 @@ static void i8259_pic_init(Object *obj)
     object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
     object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
 
-    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
+    qemu_init_irq_child(obj, "output-irq", &s->i8259_primary_out_irq,
+                        i8259_primary_out_irq, s, 1);
 
     qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
     qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
-- 
2.43.0


