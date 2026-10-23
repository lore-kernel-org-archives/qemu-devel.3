Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA5C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=AWw9//PU;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=uByr5Emr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkW-0006nR-6d; Fri, 23 Oct 2026 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkD-0006Pr-G8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGk7-0002Ol-EM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:41 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE65F83858567
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4h9if7kCNYjVHatWLDLk2n5DBsO4zDKStOILflfIx
 JE=; b=AWw9//PUTacH5u2XnPYy8U5pQXKI7b6EcCMu2eqE31FCSGrJ3TMDmY/re
 E7a6EEA3/bdOm9yFQt6DCIBOwi34y9/EuFe2UPU9k40/D97S0Rs8eJVdLOVUGwNx
 LnETrW644x9HTrXQusM6neRpWUXvxggYWuJIKtA+P83x5A5OG4C2YGsSXF42mLwf
 2qecenUEpLsrywTTtIIUM7tSqqoWRb43PnpLmEcgri7O+XP9Q6WnVt+fW0pavlf/
 BkwVZD5WqQRJ6HDlo64lCzKjFUoRXapo7Cdp79xYmaR/Wy0z+mglVGfwkLqLYyX1
 dkG/ufQTKAJGOwXf+1i3OEB2LtwBA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022095.outbound.protection.outlook.com [52.101.43.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974cyy5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rH17Pd1OInIlm6YQv2+7AybTO7Y3wAp+7Ks5XU8D21KyB0H9HQrT51MMaQ0B2vYt6zXc3rJ6gZ1gvJyc53NMOg6FhcM+bRScnt60bPN7vpXyuSAsRvv3Meu+NbEzFCls16JupzYyn5tk9o2KUkhOqAmRVMg0QFZdF1qajIHId3SMs7OoZaSwIIDGV2DoOR1Y7eyIR2nwGAWRxZqchPHnB8NAR3I0BcElzUUy4gFNNQYZoYtgnwLcqflgniM2vIvkgwVXLSOmn5K6jI78E2+dHGdwKkZm+PrR94rV/mOYDHHYB3nfgu2k6Mn/fzXXtlmNIu6LjF2uHAI02fQXImNQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h9if7kCNYjVHatWLDLk2n5DBsO4zDKStOILflfIxJE=;
 b=XwWQU85Ysr7IaW+kEVoD6+r+5CMtRpcbyvuHhIGctrbl029Rwzrk9eW1Qv5yaqNvDFsfAAOvE8XO2L/dcJx249scu78bH0sClJMmw5UxM+AXTVei8gEdidY6WCFc2BCRZPffRS7FrMj/xGu7jqK8+gGPJ7ts/zwYAAUwPcBjqZ/7w0HNRne927oDBHPzdR3t4OeJzskWyW3kg1xVuzs5bhde/ZXJnHcUhot22ZRfyUJpcUxx2kXUT7kXRrEocV0P4CSlcy8arQLhN1us3Kj6PP65Ip1jT+ERAxeYtijKTBBa0T+VZ3Oed6Wbf/IaKOIQWOKGxLs7unYTr7SWqh/fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h9if7kCNYjVHatWLDLk2n5DBsO4zDKStOILflfIxJE=;
 b=uByr5EmrwGPuKcxqlaBtqt6jnbP4YwobbxYILCSdfcQOCVyVw8qKvcwDH18pa4tMlM2P+TMjceeVMY9Dn/1rXHpJx7pLi01q+hW2rB9wnk5fkl5NbJt6ozPmDgXbewO9ZaEFwIYeDmeIA5Xaz/sW2/qePhneEGSGgmM4bCTBeLfVGGC7qecIBQGU1BGXL0i143j/a+XLiMGfo9ZuapPQEguP81eYmcaUBcZi8LA/djAtiLgTFfsM3lwF0CpEy+JC4/VdQTip1m/XiGaLy3PCMeIVMgOVOxpB3OwZiCdcjN06XNcDmGSCAAjvKT6S6ux/UNOvsc9MDbdJPXhWdVWE/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:36 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/28] i8259.c: use i8259 prefix for functions
Date: Fri, 23 Oct 2026 15:58:19 +0100
Message-ID: <20261023145839.34909-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e37969-9785-4ffd-7ebc-08df3116410a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EF+t5/r2V7DNeKO1XEtq+q2CNY0mFz6Z138nRWdx7PjNgiFPb5oeUI0x1sjVjOd3FzS6aYKEsq+KUKhga2wK1p8nJn9unLJv4LFhyD/yJ9j5Ui87gchu9a/9i4+0CudzWyc+pt5Yzf2l6HGpsqmLY56ak9B0OIhJk6n0aVHubdCZXH7tmeFmzt96SHL22ldC5o6GH9RHR94I+Th1msQtUGThm+3sFs/IifGnJZtOtkSaZYuOhiLpoCO4B5Ylirvy1lT7cryJIepiv2ebtsdmskZicLGRe3U4HxZB5n/yUamdnS2G3hEeajnBlRHEz2RJUt2cvIPkH5j5a1hFi+BMn4vV/0488OAt2Kcg8EDKCVKD0f5EDuHOtZ6WwtXtVBVrlDB6R9D/IwmcvvjmUS7vbW0ehgelS0x71inmW1bOUhBBeV9+lmRUPT2kdbShPd4i13Jfp54QVNPDkBDFXnWjso2e0v4baoPSeXEDLNCKAVFzsZn8+EhuU9SJxE19r3pX38W5mFqLfwvo92pp6SMSiIw4gFoFAtLEhxiBoxlv7y7Bu2IvGKmEwwyb1UezaIIiw0L7jwYtPg8nGf7hAN7nOg/KF+1Ir7JAGNjv2hqh64Ua8CDZ0Xc9EX1TavqytIwj4F3D0f0vrbPYOs12aXcblA/wHXIY8cPGfTNE0RkFmjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMyYgaKF+SC6BTqOcK6eIIgCU8pyXkTdxE596l0dUKVdTCedFRn4dWQWYiAC?=
 =?us-ascii?Q?j8hKYh1ZUboRUx0onbcJD7HDGR5Ykr0Nq6FAdVOr3/rI2MxamQYzDmh1Kw6z?=
 =?us-ascii?Q?EraXJRrwFzm6WGpvxRhLIR6sdxtWeEbgBjsVHh7R/oUlspdt7kvjlHQ51i+f?=
 =?us-ascii?Q?WDvLY76JNRq6ayLrbaWwf5nddmlvi/8FGMtTlfWu2qmDOs1uCwONURcf3ppr?=
 =?us-ascii?Q?bkeSiONqIKmLEFjl1eiu8uwCj4eyBoEfbmoRUecMANL/Dy3iUDn2Pm/Pkm2l?=
 =?us-ascii?Q?9b1JeDDj75SjBfTffDswUhlPC3OC4lFLI/lzzAHatsFKtjrbQ8Dd0XFS4NSG?=
 =?us-ascii?Q?HL5cx3tW3fz4UKy/KqRmwDNXEhovPzEbmu/4LuZaau7+PW2Tuth74YO3MvUB?=
 =?us-ascii?Q?6swpSuJEUIK2PBdkEgI6PQhsj1YjdNYFbCYosHCLrZ96Ev1luhQmQrrSL29y?=
 =?us-ascii?Q?Qr4Ay9L0VTGp2ApVcM5DWQr97Tl53ykaP5VjXZVQYpzM1y3mlV8qjCproaSd?=
 =?us-ascii?Q?v4eKFvnIyaevyR5WElUk7xZFOPcILljpQYqCO6oChCb/YLg87nTSoD/LZ+23?=
 =?us-ascii?Q?qhd2Bm7ptoaPSGc7uCeGFIVJQFjlF8zPh0i6XihK6Ojfpefch9HVrgefJboV?=
 =?us-ascii?Q?9J6aQJzAMMmPDsULVfSVNV5H4jm8GhNCNseOlw/7FxY+Pw0O+B52W38AtSCb?=
 =?us-ascii?Q?LVLbcvVaf3p7UxbmUFKJqGE54wAP4teuwYtnMAfdiq1zk9MQXyrr77J2mSWO?=
 =?us-ascii?Q?j6j44pLp/FejoOYX971hfxXQTJj7h0N9JLqHV4ILyVg2LoEHeTpf3PuI+PBx?=
 =?us-ascii?Q?Y8KsdKJbIeoHw9Szk/WSflUs569WnI/QohIYY5E+6yu6uElZfB+5dOMf7ZlU?=
 =?us-ascii?Q?2doHkaEUUOub6IOJ1n2LFScSGwl0M6k+kS+jTqIRSNCB4BqxHsOwbYFJJMlE?=
 =?us-ascii?Q?aJE0PIu75UOnvfCwdLWIo0cuorybDvPQjSU5OEtRYNzqjpuN6al5hUp51R0g?=
 =?us-ascii?Q?vphX1cQU8tOZjFbqxtRvmw+72WJGu/Ar0NpJOYtu8C6wzThS35Eg5FdKqHSH?=
 =?us-ascii?Q?a8vVPyl3ve2mgzmsaaFY1B3nvEgpbwzuQX8JySjb1+kLY6oEKr1GBopX1rYy?=
 =?us-ascii?Q?6AE5/85pbhCsBZZG+JUsftCAAQBPYmj2V4NNr1I9ZGCreg9OYHFHL5z4XXWJ?=
 =?us-ascii?Q?SWDJkpyu6oDhlWaYPMy5XZkNgl42h5l6ZmRlSBmGu08ajoheVB3qUkEk1d3H?=
 =?us-ascii?Q?DS39UKFFGgPObVHrdvhsiMI773pOIHsBYobQskojWw+XbdDLqu+bdZFTCdn0?=
 =?us-ascii?Q?wZbN3OxY//z7m3o6l6s2OrEpvoaSdLgn+JY1l9k78oGK6bwFJqq95nMFLBTS?=
 =?us-ascii?Q?rYzk3J/QqO2CCbE+1XeGgpMcpeQ1Kufcd6rz/meR8oZYM6Jl2xax1anu8fum?=
 =?us-ascii?Q?Z4wktWEZadZRy569pehgAJiueYuflzKQ6J0LfIZNOu6jhpVNTy3x4nc3FIkr?=
 =?us-ascii?Q?pTfC0LQFqHGQNy6aDUQlAuTLZXusvruiu0jzi+1ZSFdQykknFRl0ajaQkABo?=
 =?us-ascii?Q?aDkAFcW9W/ugQzeToW8XFrQuMATibMyNzXrKuSVIYhq8lUGaCaXoINLg7CO6?=
 =?us-ascii?Q?kfLm+8sIpfuAUDp0kDnvZI+18S58qRmoC0yjp8sOdodfSuj0ToH9nVkF0po0?=
 =?us-ascii?Q?8DO/n2+U9ALsEujdCMy0tT+P1Nn+MWVw0Jap4Aaq0WFX0QdYQHfEq4oFxuFJ?=
 =?us-ascii?Q?Ta0iGbIFjY34h86PuNSCau/dBBVmOUI=3D?=
X-Exchange-RoutingPolicyChecked: Uiokpuo/XPNNa+yfxe60lTMSI0BqdjEnIlTk19yxeHAETeP77wjwzua/B/GjbJWbPEjhHYeMQmx8ZmqHNap0wfBCxQnNksz1Zltp5tgQNeEfF0453EQ3fJ2wiELtiVnf48CbtUALTM7WG6SogYQiSn4EbGkYS48MJd3bS19qt7R4Fspp5sjqOBM/WTTmlSED2xv//dO5Un6ZA+U63L5G6H8OCf9hB6EFKXzYeNWu1RCwwDry8TGB4UMACMgn1RaxRjWSq42Um3WxN/PjbRgP4XpFGypLzn1dlEWx6HE7cjFUAUz+iPKzqZJIIfl9CAB4xJoUw1eNTcYc4qVHG+2UUA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e37969-9785-4ffd-7ebc-08df3116410a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:36.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxTdF4Ps0qLf2NK5Eb3tBZxiWQ+xT5MLgMUIepIbCyEpf1ti17tag4nLZK8fsy1zb5W380EbCm/aBjjAuFs3xsQ39B3SExBIEQrThSUT+pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX6H86HoCO/atn
 wM4d0D8vBGalv1lq+xdW148B3EOcDyL5emsYvSx8iw87VJwZ23RIW2ZxxkJkNrHHZkWhrfTWcpV
 LlhKeLmoIXBLBzpmAmNUtiti8Qv875Gnv5wbQuczhgInsxMkDeULazPESO4HbI5tQXwPRep7eo8
 xIEIC62mXhTEKYj/9Je35S5c56ZoQFeAAvm0cP9jBHjNE+fqGwd/f5uQ5/75OoHWPJb5WQmSGbl
 G+szabtFeutMl6VsgnlMjC2Ad8VWPygBbaXmI34/BQeawrxJlCYs034CR8LNseCi0t6BAbbw3SQ
 suiDAHzT29rSJhCFKa6ja7lQewPrHDBwd+eAdUbwk+r6idF+0uYdS0E+Vt7ib1a31qfjf+fj1OR
 fFFug5sNQXDI6m9ktormkPlh04ljtALKQaWfvPjkuZuC8JvM/DNdRWudo8/zCVfFLEyrlRrsYnB
 mZBDXgkN4BckGt7nFCQ==
X-Proofpoint-GUID: JJdqe4vkbN4PtPAA8IXEPVLhHizIqAC4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX+y6yNvWflrpx
 5J14sMdqlP1FeMVsH5M9Tt3/0UFXyjY2WbmETOa0OKqTjytVrOQfcjbduBz/S659FlL5T3Zdy/W
 YGGpg/uqkgd/b1LjVOeV2e3kVHUWsxE=
X-Authority-Analysis: v=2.4 cv=VaNir1p9 c=1 sm=1 tr=0 ts=6adb765a cx=c_pps
 a=kkxl9DAbGs3C2F6ePkv26A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=n0Z0T_akzs0uib7mm64A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JJdqe4vkbN4PtPAA8IXEPVLhHizIqAC4
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

This ensures consistency with our normal QOM-based naming convention. Also
update the trace event names for those trace events that originate from a
single i8259 chip.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-14-mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c      | 104 +++++++++++++++++++++----------------------
 hw/intc/trace-events |   8 ++--
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 97ecb77407..4b34e5a649 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -73,8 +73,8 @@ static int get_priority(I8259CommonState *cs, int mask)
     return priority;
 }
 
-/* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(I8259CommonState *cs)
+/* return the i8259 wanted interrupt. return -1 if none */
+static int i8259_get_irq(I8259CommonState *cs)
 {
     int mask, cur_priority, priority;
 
@@ -103,13 +103,13 @@ static int pic_get_irq(I8259CommonState *cs)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(I8259CommonState *cs)
+static void i8259_update_irq(I8259CommonState *cs)
 {
     int irq;
 
-    irq = pic_get_irq(cs);
+    irq = i8259_get_irq(cs);
     if (irq >= 0) {
-        trace_pic_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
+        trace_i8259_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
         qemu_irq_raise(cs->int_out[0]);
     } else {
         qemu_irq_lower(cs->int_out[0]);
@@ -117,13 +117,13 @@ static void pic_update_irq(I8259CommonState *cs)
 }
 
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
-static void pic_set_irq(void *opaque, int irq, int level)
+static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *cs = opaque;
     int mask = 1 << irq;
     int irq_index = cs->master ? irq : irq + 8;
 
-    trace_pic_set_irq(cs->master, irq, level);
+    trace_i8259_set_irq(cs->master, irq, level);
     i8259_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -152,11 +152,11 @@ static void pic_set_irq(void *opaque, int irq, int level)
             cs->last_irr &= ~mask;
         }
     }
-    pic_update_irq(cs);
+    i8259_update_irq(cs);
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(I8259CommonState *cs, int irq)
+static void i8259_intack(I8259CommonState *cs, int irq)
 {
     if (cs->auto_eoi) {
         if (cs->rotate_on_auto_eoi) {
@@ -169,7 +169,7 @@ static void pic_intack(I8259CommonState *cs, int irq)
     if (!cs->ltim && !(cs->elcr & (1 << irq))) {
         cs->irr &= ~(1 << irq);
     }
-    pic_update_irq(cs);
+    i8259_update_irq(cs);
 }
 
 int pic_read_irq(I8259State *s)
@@ -177,24 +177,24 @@ int pic_read_irq(I8259State *s)
     I8259CommonState *cs = I8259_COMMON(s);
     int irq, intno;
 
-    irq = pic_get_irq(cs);
+    irq = i8259_get_irq(cs);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = pic_get_irq(slave_pic);
+            irq2 = i8259_get_irq(slave_pic);
             if (irq2 >= 0) {
-                pic_intack(slave_pic, irq2);
+                i8259_intack(slave_pic, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
             intno = slave_pic->irq_base + irq2;
-            pic_intack(cs, irq);
+            i8259_intack(cs, irq);
             irq = irq2 + 8;
         } else {
             intno = cs->irq_base + irq;
-            pic_intack(cs, irq);
+            i8259_intack(cs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
@@ -213,34 +213,34 @@ int pic_read_irq(I8259State *s)
     return intno;
 }
 
-static void pic_init_reset(I8259CommonState *cs)
+static void i8259_init_reset(I8259CommonState *cs)
 {
     i8259_common_reset(cs);
-    pic_update_irq(cs);
+    i8259_update_irq(cs);
 }
 
-static void pic_reset(DeviceState *dev)
+static void i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
     cs->ltim = 0;
-    pic_init_reset(cs);
+    i8259_init_reset(cs);
 }
 
-static void pic_ioport_write(void *opaque, hwaddr addr64,
-                             uint64_t val64, unsigned size)
+static void i8259_base_ioport_write(void *opaque, hwaddr addr64,
+                                    uint64_t val64, unsigned size)
 {
     I8259CommonState *cs = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
 
-    trace_pic_ioport_write(cs->master, addr, val);
+    trace_i8259_ioport_write(cs->master, addr, val);
 
     if (addr == 0) {
         if (val & 0x10) {
-            pic_init_reset(cs);
+            i8259_init_reset(cs);
             cs->init_state = 1;
             cs->init4 = val & 1;
             cs->single_mode = val & 2;
@@ -271,23 +271,23 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
                     if (cmd == 5) {
                         cs->priority_add = (irq + 1) & 7;
                     }
-                    pic_update_irq(cs);
+                    i8259_update_irq(cs);
                 }
                 break;
             case 3:
                 irq = val & 7;
                 cs->isr &= ~(1 << irq);
-                pic_update_irq(cs);
+                i8259_update_irq(cs);
                 break;
             case 6:
                 cs->priority_add = (val + 1) & 7;
-                pic_update_irq(cs);
+                i8259_update_irq(cs);
                 break;
             case 7:
                 irq = val & 7;
                 cs->isr &= ~(1 << irq);
                 cs->priority_add = (irq + 1) & 7;
-                pic_update_irq(cs);
+                i8259_update_irq(cs);
                 break;
             default:
                 /* no operation */
@@ -299,7 +299,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
         case 0:
             /* normal mode */
             cs->imr = val;
-            pic_update_irq(cs);
+            i8259_update_irq(cs);
             break;
         case 1:
             cs->irq_base = val & 0xf8;
@@ -321,16 +321,16 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
     }
 }
 
-static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
-                                unsigned size)
+static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
+                                       unsigned size)
 {
     I8259CommonState *cs = opaque;
     int ret;
 
     if (cs->poll) {
-        ret = pic_get_irq(cs);
+        ret = i8259_get_irq(cs);
         if (ret >= 0) {
-            pic_intack(cs, ret);
+            i8259_intack(cs, ret);
             ret |= 0x80;
         } else {
             ret = 0;
@@ -347,7 +347,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
             ret = cs->imr;
         }
     }
-    trace_pic_ioport_read(cs->master, addr, ret);
+    trace_i8259_ioport_read(cs->master, addr, ret);
     return ret;
 }
 
@@ -355,53 +355,53 @@ int pic_get_output(I8259State *s)
 {
     I8259CommonState *cs = I8259_COMMON(s);
 
-    return (pic_get_irq(cs) >= 0);
+    return (i8259_get_irq(cs) >= 0);
 }
 
-static void elcr_ioport_write(void *opaque, hwaddr addr,
-                              uint64_t val, unsigned size)
+static void i8259_elcr_ioport_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
 {
     I8259CommonState *cs = opaque;
     cs->elcr = val & cs->elcr_mask;
 }
 
-static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
-                                 unsigned size)
+static uint64_t i8259_elcr_ioport_read(void *opaque, hwaddr addr,
+                                       unsigned size)
 {
     I8259CommonState *cs = opaque;
     return cs->elcr;
 }
 
-static const MemoryRegionOps pic_base_ioport_ops = {
-    .read = pic_ioport_read,
-    .write = pic_ioport_write,
+static const MemoryRegionOps i8259_base_ioport_ops = {
+    .read = i8259_base_ioport_read,
+    .write = i8259_base_ioport_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
 };
 
-static const MemoryRegionOps pic_elcr_ioport_ops = {
-    .read = elcr_ioport_read,
-    .write = elcr_ioport_write,
+static const MemoryRegionOps i8259_elcr_ioport_ops = {
+    .read = i8259_elcr_ioport_read,
+    .write = i8259_elcr_ioport_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
 };
 
-static void pic_realize(DeviceState *dev, Error **errp)
+static void i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     I8259Class *k = I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&cs->base_io, OBJECT(cs), &pic_base_ioport_ops, cs,
+    memory_region_init_io(&cs->base_io, OBJECT(cs), &i8259_base_ioport_ops, cs,
                           "pic", 2);
-    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &pic_elcr_ioport_ops, cs,
+    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &i8259_elcr_ioport_ops, cs,
                           "elcr", 1);
 
     qdev_init_gpio_out(dev, cs->int_out, ARRAY_SIZE(cs->int_out));
-    qdev_init_gpio_in(dev, pic_set_irq, 8);
+    qdev_init_gpio_in(dev, i8259_set_irq, 8);
 
     k->parent_realize(dev, errp);
 }
@@ -443,8 +443,8 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     I8259Class *k = I8259_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
-    device_class_set_legacy_reset(dc, pic_reset);
+    device_class_set_parent_realize(dc, i8259_realize, &k->parent_realize);
+    device_class_set_legacy_reset(dc, i8259_reset);
 }
 
 static const TypeInfo i8259_info = {
@@ -455,9 +455,9 @@ static const TypeInfo i8259_info = {
     .class_size = sizeof(I8259Class),
 };
 
-static void pic_register_types(void)
+static void i8259_register_types(void)
 {
     type_register_static(&i8259_info);
 }
 
-type_init(pic_register_types)
+type_init(i8259_register_types)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 7512c6e600..003924ddb4 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -1,11 +1,11 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # i8259.c
-pic_update_irq(bool master, uint8_t imr, uint8_t irr, uint8_t padd) "master %d imr %"PRIu8" irr %"PRIu8" padd %"PRIu8
-pic_set_irq(bool master, int irq, int level) "master %d irq %d level %d"
+i8259_update_irq(bool master, uint8_t imr, uint8_t irr, uint8_t padd) "master %d imr %"PRIu8" irr %"PRIu8" padd %"PRIu8
+i8259_set_irq(bool master, int irq, int level) "master %d irq %d level %d"
+i8259_ioport_write(bool master, uint64_t addr, uint64_t val) "master %d addr 0x%"PRIx64" val 0x%"PRIx64
+i8259_ioport_read(bool master, uint64_t addr, int val) "master %d addr 0x%"PRIx64" val 0x%x"
 pic_interrupt(int irq, int intno) "irq %d intno %d"
-pic_ioport_write(bool master, uint64_t addr, uint64_t val) "master %d addr 0x%"PRIx64" val 0x%"PRIx64
-pic_ioport_read(bool master, uint64_t addr, int val) "master %d addr 0x%"PRIx64" val 0x%x"
 
 # apic_common.c
 cpu_set_apic_base(uint64_t val) "0x%016"PRIx64
-- 
2.43.0


