Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E4606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=y7ScXHsq;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=GDjtUD5K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGja-0006Hm-AH; Fri, 23 Oct 2026 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjX-0006HT-9b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjU-0002My-T6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:03 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5uxV2349979
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xO/Jd4widYSge1FpQhXeeehz7lIOz1Afxq2VJ4mwW
 Dk=; b=y7ScXHsq9ZKxNoBrKNc2MjK8hZtfZ/y0icdpWftLg9eG0GUIVqh0N9JHg
 iihmeIInsA2OVyuAZ9wASozgMore3M3WXy/aOkK3Noz2Ky5oGGZcQ0m62g+nlmAi
 g+Ey4/rEQPh7aUfzDMt5LWLzCL7c/2AmX/K6jaG5Ie/cKnUTsr0npCRhb8/xU8e5
 XTk4UTwZtCf1/6a00ztAop0X9dt1JlWAsYuH03yvUamfgVDRCpCKqF5vw2bLxu6R
 aor63+EKKLNFcfMS5zk5XR8+uij3fi9Xwaqpzp5rY6mK60O7B3A5CP38HarUToJx
 UHJWgGWG7AdCSWVL1AfQnkbPdT9PQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021120.outbound.protection.outlook.com [52.101.52.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972d2qv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx4U9chqPzAKN38f3jyM2WGbbyXJkG3tYB6yzBEBSm8CXe9HstHhyC+kneMu9vZZ+grPZZifOORCMTIC6GRGeVlpHQbCPmPyu9uVYEyofSHdGHy5s57CsaKYZG3t1Hui1PZWjDCK65HO+O2Q4qddDmoarG4lMRlG98u0oge+XX8yqezpbg688VhLH1V74KkNWFK+JOmvX/hyBkrWGtGCzauidl9cdZTQgDvwQul1ym1z6XMvASO6/5TkZLlgPzHwIMmpTeSKAz/U48qnVGBHuSWcXC0Y5tCX/gvuLw9uO6Vr59Y6hJC25fO2jLp0eeOA5z6WLIybQkyMD53ywHuKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO/Jd4widYSge1FpQhXeeehz7lIOz1Afxq2VJ4mwWDk=;
 b=I6NDK/rXq1PYpNXerj25wNVe0GU3AIyfaBL0YL05W3Q5GLM1jBiF2lSazONrTdRY840p5s8JsqmEUjXaA7xj2puyUT+9l+qvrTfuBHt7fl03mKJE5L3wGsCCLTCgXr66mh6iqcLQ1XwJoBTjAzcDlSw/30+d/6jrVvE2h0BlNIymBeDn1iDkazf4X9h8kOFP4bQvCCG2kkbHkK8Ply5ZFC6BoTTsmOum+JUpFVlK3I15CNHGsxKa8kywi/CHDuHaLDhWdWTapUf1y2xOexnXdrPK8sENKwf0tLTiWAjgWjIGQWHFMKw+mZFxEP/M/N/vvDUaYC+UIScBRwTir0k/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO/Jd4widYSge1FpQhXeeehz7lIOz1Afxq2VJ4mwWDk=;
 b=GDjtUD5KgkA7Pw/g2S6OHtxkjLcl/atfbeT0UZl0mDa3WG4dxkO80zC0dAeC/Vha4pUL8RDyRG+L2aKmxlVqY5L8DMEXH5qRtK+uyMxMTx7RywhDvMVfsw/s4eeIF/WfOCNh+an0HH2KukwP12EjnGD2vNSxDgH7C5L/npHTY4BX5KH5IMtg5gcj4d2CbKGl/aYzRKHnz1kpyn9ahM6zAt6JOiGPNrpbck8WrS1u8NVzl1oMF5E76cxusKt0E3FH79v5nj7CukXtqmOuIXW/Edu2iOLaejaC+44V8vVIZ0P0D2diay3qNbge8THMOysf1q2NHoLa4ULE3TAkOgnciA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB999468.namprd02.prod.outlook.com (2603:10b6:510:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:58:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:58:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/28] i8259_internal.h: rename PICCommonState to
 I8259CommonState
Date: Fri, 23 Oct 2026 15:58:09 +0100
Message-ID: <20261023145839.34909-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB999468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acf1e76-d974-4ef1-8f2c-08df31162843
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|261021123027099003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: mj+11HO7KO9nDTCiK6A58peVo+kSKZ7E3etuLv6RWcp3qT/31uNLcSein5S/aHd0z1YLvRwjrA2gGPuOXhp83N5SeG6da6tZnoXWSBWYR/DxOiECzJl/dk0nHH7YDRRP5P687IzXOdRuZ/WB0GzzjOfMs/891cEucFW0bq63UeDtgwqPL0LBydiF0Avx60WwEBpPsdo2UO0ROY1AxIuvN3vLN9nYcavhKT8dDb7ix6hw54RvvbJy49Md/Nzj9HiNwQ0k8bQC6sizMcb7krE5rF4R3msyEIkQ0/GZ/54TESuqx3BIKgLeJV6hq9/chssRZrUahkzpJGvKHvBzqKs7KSALiomsETibP/P+EB3TdqGvgeCd2q7fthUoYzGj834mEolKtw/Y4Jm0XfQzrxeljCW5G8/3LAjevaXW15jaABEBtw5fxKxbNwYvEvpFHH3zHHGrwirkwO42vvWcwpOBcy9RbzNkLLuWEFZlTo/rpyHW2KqCrsBRcH9lwIIoNKDf1IxEwaKaaUI2+g9r+m45q9bqJ89zFI5v14OaQTriUQq8YUmDLej+1KlmmaKR4RnzCzw5/19ZPr78hhufG+kcYo4EPrBADwUCMDb+xw1k9Sp4zKqCfZZyag7nRHrOfWw/E8PbALNdoEbQt0kY+4lOyyoZoAZIWXGG5B8qyvENmdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KLpuskrx01oL3sCe6liwHb8vBaqGxiQig8G1KeFEOf428/N8dU1sEj00mDm?=
 =?us-ascii?Q?AcY0gIHE8QLWb9LYKWIPx8ZNHePRQAF0na9ocwwRHnBjzANAgRGmH8Zn848w?=
 =?us-ascii?Q?f9Qlzz8L5MqZUm4RlhhqB9xWtnDkmGkaBQvn/nmzWtMXicTv8kMJ2XZmb137?=
 =?us-ascii?Q?3471j+ImskSa3wHEJoF+/v/ZuqgEv2G4vNKXWiocY46WdKK4DJUDrp1t+MK3?=
 =?us-ascii?Q?D7ur7W76Dk8zMlJrDSx6ZdXD0M1J8HiI0IyOV6l8eOlzsPwLqJQSzVcnLyCz?=
 =?us-ascii?Q?jz8W4Phd8nIVZI0+bE2PvL89WSnohmNFXilZ86UdH1t5a+cjfwT1X83sX0iL?=
 =?us-ascii?Q?r9yO50Ec5Sh3ycQU6or6Gm4hveioDQEqKfY59rEFcBXLSPuY/aKVOnudolNA?=
 =?us-ascii?Q?Jln+KEJaeOEH+dgMs6yROLsF6Axk4GPWmv4WgyGF6kFWVvRirPmYBHiNwc4H?=
 =?us-ascii?Q?9Ud+aIAN2Q6a3StrTk4sUHap7T/ivVt2NGJO6ndH31FhZlYfuO4cMt4daSGr?=
 =?us-ascii?Q?T06h8W9n46xyDc8koSRWMM0VMu5hKHgPfWKOyH9QU1wIK/yVRPjNWrdie5wS?=
 =?us-ascii?Q?G1JJMHx+JvAT6jpKOX4kJShG3ik8/EdGpFAnqWfv7MywvSLzv95JFJxKjzoN?=
 =?us-ascii?Q?ft/Lv2eYv5qGitY6wLS4913CEHzak9TMRjJWCMRsxD04AeQdgbWTNnXV5Z08?=
 =?us-ascii?Q?h3pKSZMLRfuiPiLHRIWG7z1FRtMYeqXgCYudSRpq337WUIQiC7V/e/tVTmJ+?=
 =?us-ascii?Q?q/uYwD8JF8VtOyesHmU5Ni1nqTepcr6GB90I9xGZUgSUm9JuevR3VUit8o9Q?=
 =?us-ascii?Q?lq40EVJlegA/I/Iu+FBFVAFrB9V26mKwkPiJS2gSWpJIGEQJPtwqXGEXPQNk?=
 =?us-ascii?Q?WpGXPQgC+4LcJBVqkXqklyTtyQvdA0598ROM15Lk5KS3gGBeB0RMWIGTuPJC?=
 =?us-ascii?Q?KbBVilW9VOn3NJEqlWPVzAWYHPOzz1sOhYkzUo3F8/ZZbKQ5NhCfd53bbekD?=
 =?us-ascii?Q?vy79T2Rw4y43jc5LjkXk5cyJgQ2HGTnQtb3pmL27uUk65F9pihvsI+MjlHr0?=
 =?us-ascii?Q?g6tJ8g/kgF5ufPJ4Wr93XraZwxx9Fp2H8kCqW7d19FvMZF1wHBwNjbR8hwOC?=
 =?us-ascii?Q?+c6Z/1Bk9IIQNdyIT0OHrHV7U94YKZHSl/LQL1W7E/Nnn++w5b0T3NpyXUtU?=
 =?us-ascii?Q?lnvFLEx8QxcOi86Rk0PmEbx9LQaIfGb/MCWwDxYztUaIxq4yUvDsZbrjpQ1d?=
 =?us-ascii?Q?X9fNxY+zDiJsPoe0eBcyAZxCUN+s/Cqdy9pwebbaTwHDa7bZ7iBhUGqcs5BE?=
 =?us-ascii?Q?lrc6zLZo3pPCM3h7Z9Pk5CcVUFj4agXMF5o980xZfcZqoAZygqZQxDpqmgIM?=
 =?us-ascii?Q?ZknvTJ5b8sDlwBRCbKaOQL4Bmm7s7rxpCGnaZXUdJlDIDzdOX38kmur+iIsE?=
 =?us-ascii?Q?sF0sScTNWWBo6f980/Mj/rQ+sieDTW74aoe+nvTKwFKsUt6dedDadLopM0po?=
 =?us-ascii?Q?2RtCm2CuayubtozvXEbEcX3Fhii66G7hwuxxC5XXx7bwvZKaEDDHh4mMtRjB?=
 =?us-ascii?Q?v1K/eJpvbi9J5NzWT3zrjTqHEK3at3oG3GMhjykcJm7vyGY52HZ5QlfXEfTA?=
 =?us-ascii?Q?ywg8DDUXgnT7JX6UTvp0cfdXyOQT60jvQUnK/al/erR+2tmnXIjwxDTLuyam?=
 =?us-ascii?Q?Vq2ozr+j8syu4VZ7pQgE3Qe/s4vNmKDJHVdeMrshlm5sFra1fbZ933Gha4b6?=
 =?us-ascii?Q?VCXMLH+qFnTOb0rGh63tJv9EGtwgRdA=3D?=
X-Exchange-RoutingPolicyChecked: 3loC6STZfP7pnuJjPq3rmLdGpDO9eL0OB+Mub4nb7VGS6jAQ/Z5NdMiKWWva5foKR0K5XyEzNlXL3I7cjyybtGQjMhL91RYONRxXl5g2rs04tUZU9qtQOkQUzE8Vi54MahPdoeNGYiTT2UHe53RG9vmOQtKhlL5q4gC8rLvpUyEhlqsBime7Yu2M1bwCO7vwIleC8dRhI53cKeVJq+EZS0o4bfupKdDeRnivbzkqS13K6EBMgdZsPtsEv06Kgug2+V74aQ5cck1+Ph9XS8wyqU9Jdo46DT8PrjZi+oN72HBsPWAcdxgtTprSr7hXLlRJ5PUKdOnLSIeX/khuMP47mA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acf1e76-d974-4ef1-8f2c-08df31162843
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:58:54.7014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73L1D6dKlR/+/UiVp5+NFODN+ChmSE+UOkJ8c+F8if5eplmW6BF+QN+6MxtqZDr4+u0HFu57i7zFE3SLfd810KJ39yQqAALj76qalXl5Sb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB999468
X-Authority-Analysis: v=2.4 cv=SpMFe/O0 c=1 sm=1 tr=0 ts=6adb7632 cx=c_pps
 a=zawiyoErqgptCln8LtCPNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=6HjtqBbhEYIcFmsZ4_cA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yi9DmVzRU6N55VBYJN_uD6IYzD7it7Qm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXzSKtoDgzlxNM
 rvDZl8oiI1MyF6+J3A/wCvkuBP4flFXtvFs0WDPv3mVa7qOouIB2+E3uWRc4p0Q8sAyCzvtpTxU
 fGUUlHcDOEPv9fu4fRO/bxwDpLknHRQ=
X-Proofpoint-ORIG-GUID: yi9DmVzRU6N55VBYJN_uD6IYzD7it7Qm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX08e/0dLAzsTt
 RuWZS0loB6A+JenEj2WG8cLxTs0T5/HFucIQZxBYbaiArAPm8rujrvMlimCTNEklpiqqvRlyWeE
 3imUTBIE8ucgv9+FdCAfG2RzXPIzPUc9v4mG5+kMPdGQqe9U1iVab+6mDLD42h9o8zoC0JMi8w7
 ggFLHKZcPPaJqhevIWHotsL75DQee68buxx/Gant0Ra5E4kNGjlCS0//N2J5yLEBSqqUCXR74j3
 9pp9GfCm9BXx81k8nrB3CUEjTNhT/o+UCqiZDVj+q8yzeohbfxfCY8Fd/cspaCH/eQ94w5yJlcV
 hsVbQirx6oTgk33fCnKkCpmnVLnglVZznNNZSmn1WsNk0zMKf/gHq9J17RysDRZBPAVU110TTOm
 Z1sH9nUYMYxClcJH6EBXW0x3q1lOn1nLzmzf5w5UfPJ41W24mAHUWd8i9EEayyNf3UDxzocXt6M
 /eb0Sji1Kw7jVl2oTAg==
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
Message-ID: <20261019120517.1448687-4-mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h         |  8 ++---
 include/hw/isa/i8259_internal.h | 10 +++---
 hw/i386/kvm/i8259.c             | 10 +++---
 hw/intc/i8259.c                 | 34 +++++++++----------
 hw/intc/i8259_common.c          | 58 ++++++++++++++++-----------------
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1f2420231f..1921a30371 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct PICCommonState PICCommonState;
+typedef struct I8259CommonState I8259CommonState;
 
-extern PICCommonState *isa_pic;
+extern I8259CommonState *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern PICCommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(PICCommonState *s);
-int pic_read_irq(PICCommonState *s);
+int pic_get_output(I8259CommonState *s);
+int pic_read_irq(I8259CommonState *s);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 289d08b7d7..7a2f9addaf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -32,16 +32,16 @@
 
 
 #define TYPE_I8259_COMMON "i8259-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
+OBJECT_DECLARE_TYPE(I8259CommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(PICCommonState *s);
-    void (*post_load)(PICCommonState *s);
+    void (*pre_save)(I8259CommonState *s);
+    void (*post_load)(I8259CommonState *s);
 };
 
-struct PICCommonState {
+struct I8259CommonState {
     ISADevice parent_obj;
 
     uint8_t last_irr; /* edge detection */
@@ -70,7 +70,7 @@ struct PICCommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(PICCommonState *s);
+void pic_reset_common(I8259CommonState *s);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 14029783e5..f10643a120 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -34,7 +34,7 @@ struct KVMPICClass {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(PICCommonState *s)
+static void kvm_pic_get(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -67,7 +67,7 @@ static void kvm_pic_get(PICCommonState *s)
     s->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(PICCommonState *s)
+static void kvm_pic_put(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -154,7 +154,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
 };
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 52e24d333e..45db87a2ad 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -52,12 +52,12 @@ struct PICClass {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-PICCommonState *isa_pic;
-static PICCommonState *slave_pic;
+I8259CommonState *isa_pic;
+static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(PICCommonState *s, int mask)
+static int get_priority(I8259CommonState *s, int mask)
 {
     int priority;
 
@@ -72,7 +72,7 @@ static int get_priority(PICCommonState *s, int mask)
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(PICCommonState *s)
+static int pic_get_irq(I8259CommonState *s)
 {
     int mask, cur_priority, priority;
 
@@ -101,7 +101,7 @@ static int pic_get_irq(PICCommonState *s)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(PICCommonState *s)
+static void pic_update_irq(I8259CommonState *s)
 {
     int irq;
 
@@ -117,7 +117,7 @@ static void pic_update_irq(PICCommonState *s)
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int mask = 1 << irq;
     int irq_index = s->master ? irq : irq + 8;
 
@@ -154,7 +154,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(PICCommonState *s, int irq)
+static void pic_intack(I8259CommonState *s, int irq)
 {
     if (s->auto_eoi) {
         if (s->rotate_on_auto_eoi) {
@@ -170,7 +170,7 @@ static void pic_intack(PICCommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(PICCommonState *s)
+int pic_read_irq(I8259CommonState *s)
 {
     int irq, intno;
 
@@ -210,7 +210,7 @@ int pic_read_irq(PICCommonState *s)
     return intno;
 }
 
-static void pic_init_reset(PICCommonState *s)
+static void pic_init_reset(I8259CommonState *s)
 {
     pic_reset_common(s);
     pic_update_irq(s);
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -228,7 +228,7 @@ static void pic_reset(DeviceState *dev)
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
@@ -321,7 +321,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int ret;
 
     if (s->poll) {
@@ -348,7 +348,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(PICCommonState *s)
+int pic_get_output(I8259CommonState *s)
 {
     return (pic_get_irq(s) >= 0);
 }
@@ -356,14 +356,14 @@ int pic_get_output(PICCommonState *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     s->elcr = val & s->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     return s->elcr;
 }
 
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -444,7 +444,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index e2f997e161..17040bdb1e 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(PICCommonState *s)
+void pic_reset_common(I8259CommonState *s)
 {
     s->last_irr = 0;
     s->irr &= s->elcr;
@@ -55,7 +55,7 @@ void pic_reset_common(PICCommonState *s)
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
@@ -67,7 +67,7 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_pic_ltim = {
     .minimum_version_id = 1,
     .needed = ltim_state_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(ltim, PICCommonState),
+        VMSTATE_UINT8(ltim, I8259CommonState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -169,22 +169,22 @@ static const VMStateDescription vmstate_pic_common = {
     .pre_save = pic_dispatch_pre_save,
     .post_load = pic_dispatch_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(last_irr, PICCommonState),
-        VMSTATE_UINT8(irr, PICCommonState),
-        VMSTATE_UINT8(imr, PICCommonState),
-        VMSTATE_UINT8(isr, PICCommonState),
-        VMSTATE_UINT8(priority_add, PICCommonState),
-        VMSTATE_UINT8(irq_base, PICCommonState),
-        VMSTATE_UINT8(read_reg_select, PICCommonState),
-        VMSTATE_UINT8(poll, PICCommonState),
-        VMSTATE_UINT8(special_mask, PICCommonState),
-        VMSTATE_UINT8(init_state, PICCommonState),
-        VMSTATE_UINT8(auto_eoi, PICCommonState),
-        VMSTATE_UINT8(rotate_on_auto_eoi, PICCommonState),
-        VMSTATE_UINT8(special_fully_nested_mode, PICCommonState),
-        VMSTATE_UINT8(init4, PICCommonState),
-        VMSTATE_UINT8(single_mode, PICCommonState),
-        VMSTATE_UINT8(elcr, PICCommonState),
+        VMSTATE_UINT8(last_irr, I8259CommonState),
+        VMSTATE_UINT8(irr, I8259CommonState),
+        VMSTATE_UINT8(imr, I8259CommonState),
+        VMSTATE_UINT8(isr, I8259CommonState),
+        VMSTATE_UINT8(priority_add, I8259CommonState),
+        VMSTATE_UINT8(irq_base, I8259CommonState),
+        VMSTATE_UINT8(read_reg_select, I8259CommonState),
+        VMSTATE_UINT8(poll, I8259CommonState),
+        VMSTATE_UINT8(special_mask, I8259CommonState),
+        VMSTATE_UINT8(init_state, I8259CommonState),
+        VMSTATE_UINT8(auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(rotate_on_auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(special_fully_nested_mode, I8259CommonState),
+        VMSTATE_UINT8(init4, I8259CommonState),
+        VMSTATE_UINT8(single_mode, I8259CommonState),
+        VMSTATE_UINT8(elcr, I8259CommonState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -194,10 +194,10 @@ static const VMStateDescription vmstate_pic_common = {
 };
 
 static const Property pic_properties_common[] = {
-    DEFINE_PROP_UINT32("iobase", PICCommonState, iobase,  -1),
-    DEFINE_PROP_UINT32("elcr_addr", PICCommonState, elcr_addr,  -1),
-    DEFINE_PROP_UINT8("elcr_mask", PICCommonState, elcr_mask,  -1),
-    DEFINE_PROP_BIT("master", PICCommonState, master,  0, false),
+    DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
+    DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
+    DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
+    DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
 static void pic_common_class_init(ObjectClass *klass, const void *data)
@@ -222,7 +222,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo pic_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(PICCommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
-- 
2.43.0


