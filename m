Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=Wg3uAXxq;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=nUXCo9vs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGkD-0006Pn-NB; Fri, 23 Oct 2026 10:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGk7-0006PS-Oh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGk5-0002Oh-FF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:39 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE67Sb2350435
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RFFrcBqMszwaA3iT9gE1j0J9QLP0umMnC/pcl0oy9
 0M=; b=Wg3uAXxqhBSLSXpSD2Zb9TiM9nfo1LM/wxlUrSaTo55uDEEpEvGW5hfEP
 l/E3C7q+5HLtqn7NM7wkvuQ4Ji+FyvnQi2ZeuPXXNVZI09zr3EqtSVaTfFCqslLX
 uFRBJhkKMK6/hvg71K1UAcohOg5GDzQUEYYsQ5Fh+2cupE/S2Lkm/wLRuhINpLCe
 jLYYueSNJb2TU4oDKB4SMXeIMbAHo9RIBaDe6fCIKXezVGaYjzXmc6Ys6AbdZh/n
 WOgz7WxHbG/pvJ6Rj+Un0rscoADPtTppMvgkxTwZNR9VWXhNJ5Ye71Q6bXaXpruG
 FomGsAyi3tYt0H4UipMpFXQl6vnwQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021076.outbound.protection.outlook.com
 [40.93.194.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972d2sj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpSffTj36wlmFA1n8EeIHZ9ReQwf6KgyP8bmib+lkJBYCUIcxGKzmA8FfJ2RBc1Yj+NxOzrHEQzX3c7Fr5ICPRxGDmPFe4tAGL4GYV0o0r30PGqiQyjtEkpsX2JKoPAXZb6OykEd+G9jNubOuKIjF5LlUsaJn99DurNcOe+oNjhaupwfaAMrykAxq5jPZ7sOkEQkMNBBe+65JcKArHaphLzHUSZeEj8SV0/uUrpQKHkcjP1G2NNMB1AZOGo5OeN28qPnZq90V6Pb6KmYDx8RFTLnzaxLZP31TWmXV31fgzV1qb4vk30NlmAmrnBY6P+bQqgybWLPcUnprr7f92CCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFFrcBqMszwaA3iT9gE1j0J9QLP0umMnC/pcl0oy90M=;
 b=JfzjJBVUtJJLAxqjgPIUkV2K0UKu2Q/ig4Ax2n/MvecGGHfoIWG+YBvj6vFF+0JHJUFUTxTUGgaawvNxGsQb/Vjls78Td4d3Exchsmq7Vh3IfntCqOLKsB3VnHkbgXq+W1SC6AGwweLGuRFu8anVtbnemcisKATvijGWaqrz40cxQ7ohDkXvIUYuVRFSqrXbK7Ay0QY+FTv75Z7ONMTE/C0bSFORKZCRvQ/fe0wxIpNcO6S9zdcoa3WY8zMOEYXIiB6f/VUbwzhezmjSDHT9Jk9hMYJ+SkPq+m5o1U9z4E0J/R5FXS7aG+ys8Sb6x6nGoxolRP21/LvbvD8gUSPizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFFrcBqMszwaA3iT9gE1j0J9QLP0umMnC/pcl0oy90M=;
 b=nUXCo9vswhiBVcPLV3H6kZvUDEyKMcW9iwAzb9hcyjcUQ0fV0t9qUgapRkCAhj1+UYWQgJuLtHBD5xZAQGCIlJtX28mMj+hLfdn2z2ty0chPqLC/GC1RmEa+pgwAdGEsNForDIOIq8cQnIa2q0/GRFCG2bjO8KeVUi2awc4TrSKRKHsSlS+wzqhI/n8JhqHTeU/m/eA7ASkQkvJmdnYljJ0gGcd5QrWyFm4cg01v+sgGCcKs4D4Lv0FA6H/ws7HzC87PMIwL84mJqufWBGixJMTHYYL35S4bbDFvo2H86Ygb6aPKiZypLgdF12sRRREnyXMdythzgshiOEe5xr8ipg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:59:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/28] i8259_common.c: use i8259/i8259_common prefix for
 functions
Date: Fri, 23 Oct 2026 15:58:18 +0100
Message-ID: <20261023145839.34909-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: a195f8a8-556e-47fd-33cc-08df31163e2f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MU47g+cXPiGLxAC3MfRN/n+4YBMr+T9OgqiXz1VmgP8jzE1Oa3pXItyUOlGG76lVKBJHWKV84bv5dfr7Kfdf9Iautx62mhAW5+czHa8lcbo/+FpSc9Z184n7U0MHlMI6qyDZhmpyoZ1UDid0sra9/of/3xp1bDaPyR8dMJK+RXT0BoNagmpNBCIFTzKIxTZWmCU4JD/6chnYhDivAshmITFMZuuXOMxaki6kBtN3msPw2mOD0ipvmKigln2mOoc9YExMBilvmxX9k4vC88RyVnb3P4S5lTH/RqhnyIn3zGB0ROYZrxJypijG10bymn6EZoRqzBonFirAY9H8j6KzTnL7B2F5wrmXCCBXiNcB/iX/Y5ujQiW0luEKq2nd6uE+GYrZ7ureqXWT4bra+XkVftM1viIUGj8e2LzaenU25m8bgVVJqLvlE9ssP77j0QeEy7SU+fxUV113zqDx2CbsFqHHz75+lRqdp0HDX/u9VJUK4SwsoG4Q/0Ji2W6JVXR6Dsg4CUPBsA0/Yvn3B+qjTxjebTtURFniBherbj9zK3oUDSgl/KKx7gHHBRtGlKsjOg2JMJvSsV3qEDsht9ShJ3hC4gS+uKekIxoqrgHY1sQKiUgon8otYYTBlFmSt6ZROTmbXPJ4yOIeP/adntFA0oRqiAO/jf6vUVWqpj57pMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j522qcMb6kWCoOQj/P5oil/gDn0v/vzCIfez7RZ4QbwX/+AW3gYTHg+0Zizs?=
 =?us-ascii?Q?0F2mBmhdMxZ+tO3zNr72BaWNAo2aBwLVvPzYWFsUmoEftMOzrHnAUPOzOVUC?=
 =?us-ascii?Q?FsCfhn/HYSqJkiD7KjJkQnQg4tR0Bg/XDJJwe7EmHj9XMgb5fvnl1wkyaSmo?=
 =?us-ascii?Q?ujgUdx1hCCGR+/at5baHaAvVc+1aqsGjM0koklPrZiPpaEx8sAs2erO1evQ2?=
 =?us-ascii?Q?gxAB3ygjing/4OKUDEet6k/forYqp0zsWlHNoTKYYNs3Znb4G8M62ASqw7rN?=
 =?us-ascii?Q?BVbsbZdOEiEGY32yEzDOVPCLK0RJHTCooQz5iEtY3jo+trOtXQ2pa4U2oYVO?=
 =?us-ascii?Q?9GW+h+FX+ESQskFTKbbv+q5NZg7t+TPW/kMKCUuiL82+DJmci8gGaFquqhgl?=
 =?us-ascii?Q?Q3/aUHQaRfuznH0XkFoqMpduYD5rv48kwtf/aDUKOuVzq/XQTP72sPdR84+8?=
 =?us-ascii?Q?8FGU1y4JVS+Nre+dofSMz6oo1YjY+TUpsHibNBHctSwvNU78eU4wa1PHGR1O?=
 =?us-ascii?Q?J4N+uZOhyyMHhWdZPxqT9KykEkcoMF9QZylo8SBnLVGSilj6Fob71l57kN0x?=
 =?us-ascii?Q?qI3H59jaqGnEKg4CNzltsZuxTnuO16EVBzuR5MFCvu7LKlQUyLUpSA4p61+A?=
 =?us-ascii?Q?HZ46Fa8i2xsqlfJjabsoWMWu27vXRpwMoC8+7NaY524S4n6WG8fvci0xSlWv?=
 =?us-ascii?Q?OH94KIryoXBkLG9CtLT2qgshTbiB+v5Vw6/hCtAtPZ0HOQmD50qapZtD8DQc?=
 =?us-ascii?Q?JkNM4rEYvNmOIW2lg+aVuXMw/zdI2qujBNC22mI3E4ywgeU4YWoWMLj/sxmj?=
 =?us-ascii?Q?rhOunTAgUmZftEypqAx91tY9VihSS6WB+z2CQi/w/XjAOO8gd0Rx6PxD+5K4?=
 =?us-ascii?Q?iItfcF2vwpBLE66r/0M0CBdiw5mhIZ8MMzQvcyg/3k5xi1Qif3wivKt734NN?=
 =?us-ascii?Q?eCzaje47FDxNEEHBxA7jxzrxypJ2eyAqcgNbNLWp20eZjP02QEOHKs/wLXKQ?=
 =?us-ascii?Q?6fVfSX27AFPzVw//jEGOT7jvchUuOD2t94cpHV4iwbMO7McuSTch4+7jdM5l?=
 =?us-ascii?Q?QYpVyOHwM67+EobtO12E+NgpaIp4gkXVCzWyJTkIr5XAiVee9gldjbpU/FAE?=
 =?us-ascii?Q?K05GKKBVAKjuCvPenBX6rn7TuxLRs0k84maUBmMF8f9g7DBHXiOK1OLIxVpM?=
 =?us-ascii?Q?XPr06OLrqLUKkJTJI9q5p5CDZfgcfD4mkASiQhM348S44GTtx+KN0jFerD5/?=
 =?us-ascii?Q?brJ82nUICclxoKPLmoP6RW5N4s9t8j99kBh06ksoboa7D2zcQAQ1xXyKWcRu?=
 =?us-ascii?Q?Ti7qZvMJS049a6oY+byISLnZj8StUsmDwP+6TF8pt7j0jXPivUohOu9dFB9i?=
 =?us-ascii?Q?bPGesDTSyx+x3mdt2lAs0nCYLycVUhtz/5CYp29ByUqvx8gVpB8DTQyFYtgV?=
 =?us-ascii?Q?T5eMPFs6izNqF8sogVY+yGylfD8AL4MF6nRenGUDMoIXKud/p9iWvmsMtrnC?=
 =?us-ascii?Q?G3AVmv8dH4G4rrUlYZd8LImsv1GLFVDdzXS7cUxpsPhlBZ3vCWB56FfLn75s?=
 =?us-ascii?Q?AZJlHRjLNd0rZMZ0WEj4HHrjOPQuMg0mgH+FFVnBYQ+wlV0S5tsgehgkIg3j?=
 =?us-ascii?Q?+Wp/Y/rGJzG8Boc29Cwy1QBLLX5LAQPp/lDQvwQIyX0hQiNSY1prbvHA2UiR?=
 =?us-ascii?Q?s5PthNB/Q4CHS9wyw07DnR6UFwdoebxmodLRXq2ooZ7UESQgRvVY/XiO8qRu?=
 =?us-ascii?Q?t4AX0GocotfM1HgiwOT7XbSUpFzMzDc=3D?=
X-Exchange-RoutingPolicyChecked: iToTRNL/auqb+zMa1Ht+H4/uIWbFg4s3S8DY+eidqWXY+d3EScXVZAI5x6yMjpkvB6YS0kQguT7fLag1oYQ89KE5gbROzCC+vlJbsBI3E6MsJEEFurQEU09t9czESsw6pMXJAGsEUOzcdT7I1SKw24IKtKIJ4obC+HRtgUJ1J8BlPxOwn0Ciz7hFBG2AW9iMBIbgxob2y2YmQ4j6kgvt9sV1JDXo+9ePkKm79dB2jaH6E7ZyKBm9CKFOCOWohRE/80wUcBFuZ1mS3JN6t7ZO/AB8wGL/Ez4lv8iqQuJxKotOWhjdzjrd8YfNUNREL0AAUvbWE+5nrUgWuHIDnN9nxQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a195f8a8-556e-47fd-33cc-08df31163e2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:31.8132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch3qicySyKulGK11zfLp1Q5BA5yJ9aor3OAUUxPqtvWBBOIojeWWVi+vuhNbT7Xt2F/Ff8z0yq8p0acLV1HUIJXYmHq3bploYrfF787FbQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=SpMFe/O0 c=1 sm=1 tr=0 ts=6adb7656 cx=c_pps
 a=CWl35G79Ma0v70ZK/2v6Gg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ox8dIxdxdu1w5TD4ToMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gfvuUQsrdXvcIbT0uf7oCj3QbwHs8BbD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXym+uBMr1hVA3
 w9mvBQ5VMywcrqRtyHavjaA3iIqiSMC1FEjx728/rhcbK5L5lkgB/bXkG4BVFFNGfp/S9CU2wtl
 afZtwrKRImFlfSeDCax+6x4AGY6hjkA=
X-Proofpoint-ORIG-GUID: gfvuUQsrdXvcIbT0uf7oCj3QbwHs8BbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX9IQjmiWZOo2W
 5HKUm4nNEqt5AercH1ibAU6AIuH6z+3JyLW0r7fdaRP8sSFdyJhCWwQrBX28RODC4bPVYhbjYkA
 saRUqnAYJhO3SvfIej39JzHR/LW3KFJB0/DFufBcAz1sFIIBJq8qvyqZyYd0XOw8H/PL8Def46b
 Oi0/7k57wYE/4ZnL/x5XgPluBXQyVjtCpnJXk6/hnJtwcmWW7ztDJp969QHh0pz4yW/oNYdtvrv
 K85fQRvETEo9N6hym6i6fq1+H1CxmrecA+XSXMdR6cA67FkgF7J0447n4ZBJgAMq4uOpABYQpqG
 8c1Qhjp0kOTashxtpkv+UOxX7MbD9wDM+9kyEDasSHu7aYtoQj7/dLdFh3qTc9UsOMvacwfR3/H
 Hxp6vYa6itG3A21hPcJ8sOvAWz0lj0xJ2ACbEbdmKN+aW6VY0nyuLOad7dfWTz9pN7dtXeK1ANE
 DG+8BGTCjQ82kViZfGA==
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-13-mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  4 +--
 hw/i386/kvm/i8259.c             |  4 +--
 hw/intc/i8259.c                 |  4 +--
 hw/intc/i8259_common.c          | 49 +++++++++++++++++----------------
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 71fdd74266..644508a44e 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -70,8 +70,8 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *cs);
+void i8259_common_reset(I8259CommonState *cs);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
-void pic_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 86b1ffea4e..3a960e48e6 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -108,7 +108,7 @@ static void kvm_pic_reset(DeviceState *dev)
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
-    pic_reset_common(cs);
+    i8259_common_reset(cs);
 
     kvm_pic_put(cs);
 }
@@ -117,7 +117,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
     int delivered;
 
-    pic_stat_update_irq(irq, level);
+    i8259_stat_update_irq(irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 700412df74..97ecb77407 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -124,7 +124,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
     int irq_index = cs->master ? irq : irq + 8;
 
     trace_pic_set_irq(cs->master, irq, level);
-    pic_stat_update_irq(irq_index, level);
+    i8259_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
     if (level) {
@@ -215,7 +215,7 @@ int pic_read_irq(I8259State *s)
 
 static void pic_init_reset(I8259CommonState *cs)
 {
-    pic_reset_common(cs);
+    i8259_common_reset(cs);
     pic_update_irq(cs);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 705a28ecbf..31bd663439 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *cs)
+void i8259_common_reset(I8259CommonState *cs)
 {
     cs->last_irr = 0;
     cs->irr &= cs->elcr;
@@ -53,7 +53,7 @@ void pic_reset_common(I8259CommonState *cs)
     /* Note: ELCR and LTIM are not reset */
 }
 
-static int pic_dispatch_pre_save(void *opaque)
+static int i8259_common_dispatch_pre_save(void *opaque)
 {
     I8259CommonState *cs = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
@@ -65,7 +65,7 @@ static int pic_dispatch_pre_save(void *opaque)
     return 0;
 }
 
-static int pic_dispatch_post_load(void *opaque, int version_id)
+static int i8259_common_dispatch_post_load(void *opaque, int version_id)
 {
     I8259CommonState *cs = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
@@ -76,7 +76,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void pic_common_realize(DeviceState *dev, Error **errp)
+static void i8259_common_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
@@ -105,7 +105,7 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     return isadev;
 }
 
-void pic_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
         irq_level[irq] = level;
@@ -115,8 +115,9 @@ void pic_stat_update_irq(int irq, int level)
     }
 }
 
-static bool pic_get_statistics(InterruptStatsProvider *obj,
-                               uint64_t **irq_counts, unsigned int *nb_irqs)
+static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
+                                        uint64_t **irq_counts,
+                                        unsigned int *nb_irqs)
 {
     I8259CommonState *cs = I8259_COMMON(obj);
 
@@ -131,11 +132,11 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
+static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     I8259CommonState *cs = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(cs);
+    i8259_common_dispatch_pre_save(cs);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
                            cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
@@ -162,12 +163,12 @@ static const VMStateDescription vmstate_pic_ltim = {
     }
 };
 
-static const VMStateDescription vmstate_pic_common = {
+static const VMStateDescription vmstate_i8259_common = {
     .name = "i8259",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_save = pic_dispatch_pre_save,
-    .post_load = pic_dispatch_post_load,
+    .pre_save = i8259_common_dispatch_pre_save,
+    .post_load = i8259_common_dispatch_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(last_irr, I8259CommonState),
         VMSTATE_UINT8(irr, I8259CommonState),
@@ -193,21 +194,21 @@ static const VMStateDescription vmstate_pic_common = {
     }
 };
 
-static const Property pic_properties_common[] = {
+static const Property i8259_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
     DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
     DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
     DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
-static void pic_common_class_init(ObjectClass *klass, const void *data)
+static void i8259_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
-    dc->vmsd = &vmstate_pic_common;
-    device_class_set_props(dc, pic_properties_common);
-    dc->realize = pic_common_realize;
+    dc->vmsd = &vmstate_i8259_common;
+    device_class_set_props(dc, i8259_common_properties);
+    dc->realize = i8259_common_realize;
     /*
      * Reason: unlike ordinary ISA devices, the PICs need additional
      * wiring: its IRQ input lines are set up by board code, and the
@@ -215,16 +216,16 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
      * code.
      */
     dc->user_creatable = false;
-    ic->get_statistics = pic_get_statistics;
-    ic->print_info = pic_print_info;
+    ic->get_statistics = i8259_common_get_statistics;
+    ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo pic_common_type = {
+static const TypeInfo i8259_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(I8259CommonClass),
-    .class_init = pic_common_class_init,
+    .class_init = i8259_common_class_init,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
@@ -232,9 +233,9 @@ static const TypeInfo pic_common_type = {
     },
 };
 
-static void pic_common_register_types(void)
+static void i8259_common_register_types(void)
 {
-    type_register_static(&pic_common_type);
+    type_register_static(&i8259_common_type);
 }
 
-type_init(pic_common_register_types)
+type_init(i8259_common_register_types)
-- 
2.43.0


