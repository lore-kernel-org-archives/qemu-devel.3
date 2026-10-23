Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB15606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=zbTIIIez;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=GLzwErwI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlG-0000Pa-JT; Fri, 23 Oct 2026 11:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGky-0000Ar-GM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGkw-0002f0-GO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:32 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE7vQM3704834
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OumqqOnJ6ofwz67I5M1SjyChr5hilMkVUv0/9m2tq
 K0=; b=zbTIIIezt+m64iSq8IUeyOR5ZXIJRNjQm+3SOTTvfl9EP0n58mbtUAeQF
 XrgR/FZh/912/Ci9lDvn8otZKZkkzbLnfaSMWevH+e8yqsHJiUkl+fIi50zQiCGM
 AxFA+02hEidWb1WIrPSECHaqXvltdbroJ1kSr2T6NRNsAZeZT0NLZoftuh948SC+
 pxno+utOLrhYXDZZGCexKLl3CUeHe8daKetKSDhezqyivUUhx7tryruVAz6qvUvf
 LiKGzdOHJ3lwTiSg8Y5EN83qZu9CYjCXzkNOWZPSO8NTV9IFv7bSsW4iHHYFm7Ff
 G2whwK0GUAOtib4c562rZiXE9oakA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022116.outbound.protection.outlook.com
 [40.93.195.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974w0mg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJbn5HW38vs7LH6uSEo8nDgF6OTzk4clC1NTfwAN5VVZ7uWGNO6Bj/8fbeeEUK39KfEwq/xNx/nc6IE2Q9WT/G2StALvzGO34RMxPaw94QKtya+cAUhdBKbGC0LNocjqhTjDR0XAkrZMKKQitbQhauaaIRGL3r4GlBxEoBsPePrvrO9V6UCr7ERpoYC+A+W2SmZNk9CPsU0utanVZ/J/tfEMdk0b8OWuvIedoJoNne0RrViqNaTndZhUFoX/LmNvn2JwqjLLjyR+o+cjRx8dij7sAUhsebrl5GcjieSPnUy0Nrc5dEpwekOCCzUrDL5EqB43uMd2fcAIOyfWS2HTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OumqqOnJ6ofwz67I5M1SjyChr5hilMkVUv0/9m2tqK0=;
 b=ZLnJXseP3tN0gaXSRb24yJK6nwwXAz2hM4w5yzW3bPgQuLRi6fyqdhZA1qJ2KcVR/YlOKWtGLuW+3wIg59YBTz8msXoet8xCeU58WE12jYHYH1qanuKyuMBG3xExRE9wbBRgLgzBH0crQfexQEluKv52xTvTg3jdDXbRSBL1Pr5YWdkLVlWOldjORg9DLJ5gk6FRk97ZZtzHwjPPlE/of1Gj3areXs41W8DketAeltxL1QXliK8XlICUnZL8y3vo4zjIIXx/PYVZlQoUna3mKL7Mgf1E4qZs0JmLwUqGDrqCaIiNROQW3x5N2jFqc3LzRoo60tLoOET/3XDVoU5f8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OumqqOnJ6ofwz67I5M1SjyChr5hilMkVUv0/9m2tqK0=;
 b=GLzwErwIFp7i4V5tMvOUcIK2cMfU3m7XhKcyk9iioW03acqFe01gLSLn+Nzm3qGFsrPNjNmTSjLm93MHneW1TI26PrKgbmn7hPa6+Kn7WpoMfXdbwTg7g/MyuJwXzb29Znm9pvWbeEI9Z8qwed8PTSHv1IvFYKvXXv/q1yy6f0BPbC4wQUICbB/aoccp2qi9gl13TbXRuYcSGCSVukVNNBq7BFd+s6XGVcZnw/yV7gK/PEbGMqztZ8FFTlOju2nnPhlI2u9j+PzlJfmRVM6IBL01Ggi2kNK3KalXRCA/JjPd1p4novwVmjbnBDAj4aWUYgMT6ArsPLlLkWpbnwkC6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS3PR02MB11571.namprd02.prod.outlook.com (2603:10b6:8:366::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 15:00:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/28] i8259.c: switch isa_pic from I8259State to I8259PICState
Date: Fri, 23 Oct 2026 15:58:32 +0100
Message-ID: <20261023145839.34909-27-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS3PR02MB11571:EE_
X-MS-Office365-Filtering-Correlation-Id: a1db4037-fbac-486c-0fc8-08df31165fb8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aFWnpPPhAxerwOwssFxpcoqAbc5Va0NDBqih1R2N3G3r9akFVqyfEyXxeBDMFArScm8OTzwXG3JuL6GOCLuEtM8FRp5nxRjSosE6kbGkpyb8WWDREmMWN49cX37KwExUsrYqr+DKW0zHjIt2Hd32IESqAHETMKH6zljpp4WgsO5KBX5m62NlycfAsP4mbp2FY1D7tFIjsJn/LMSWPVb5FdJ4iX4YGxy9GcuzJa8Pm9AOv26ooJ/B63ibIcbD+A9tR13nHJhRC6G7EbhYLJAocKM7LKuhwBNXsUmZ1ZxLSayA1GMj29S5YY1x9JmZ22yP4qh3FevOzWzwtbx/U3UuoLUiS0V3fUqonKowMlKN5M9seqDAAIKr7/aT8Rjts6GecBv7Utlypt6Ywp+66glFa7bUg0/6sBlFTYOaWRylW9b7adi5S6nny8O04tCZ4lVvdNpp6T7Y7CADjIFZcCF5Qo/GXbm17/K58ZQ8BQL3awKn9g5n6AaKCvYhIDZk2NfIpie0DwRAk3Q3miF4dDsGPCNDJ+31tPRFheJfS55FrwEp2uaC0QxI7RbL3BCKNzQjzWNkid5pcWkexVZ752lzwRbzlPz6mdyXk8BRt6egRqNbFiS0VzVTaruYzjbdotg9UzbXVossSTSyn/gN3bKmiZUZr8tcI68mqdjFe7G2M8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7m6CbK8PwOU1khkTmIarpYL6O7UyDPpdrWx8XDsLGHmbheOvmjERm5UyFK97?=
 =?us-ascii?Q?oljxRrybuqOZ6o0192T1FZgOIsJTktMh+0QfQMIxDAECV0SUqKjV5ytSDXgo?=
 =?us-ascii?Q?q4DjLoQumIbIfpyiQtSGZHyljqyc/BE5u0nq6g0ZVUlGozC2ObpVbV+TO5vg?=
 =?us-ascii?Q?Q4dfAARRGka+j3yVMNFG70iQAaI38XBAsTH30nXLr44ulTM1cD0wA6vWvjaU?=
 =?us-ascii?Q?IuS0Jx79oEQhlWbjRgw5g31p+FCE0JJMO8igGOHRFoITmgloZ+51y+Y9EG7F?=
 =?us-ascii?Q?SYVSq45cWK8rB51L6XDkoVd3wmaYZQ9vYxswJcSqYRBdQeSNJhKJckl6z+1j?=
 =?us-ascii?Q?s1sUrwOo7rqPhmCqIpy3Ai156hlfYLFSzzgEInd/Nq9Av1uxZIwYYYqkqRAU?=
 =?us-ascii?Q?FN6WABmNFNQIWrA+JICI3vZEphUynxJNxNTz67Mu9iQHxn+vwHG0tPwHKlpV?=
 =?us-ascii?Q?xpIYDnuFZ+Dq9IqsQBReR1uSnBLfwWHs77MWj5nIcrivt4DiL+awLfbIIrdV?=
 =?us-ascii?Q?so5gdUiZvAmE0lf9z49Hg5gDj8/NmPZbfF6uWN8H2HL5tCFdDyJHT6WRQCLr?=
 =?us-ascii?Q?n4theMnfNKA66OBPMGLcRuZZx/zR/fcFBC/RH6iFKBt81eFt+Fs08Rw62C/y?=
 =?us-ascii?Q?YMXu6BuZxRDMZIIonnK8f/pSbzyQYoE0LAS1mPdrEt5zmh6eFuNVplWigN6S?=
 =?us-ascii?Q?NS9jIdj7J5nj2emJQuz7i85nM+CqycOl0a0WgGDjaItOmTTmKZTVs/nOR+bq?=
 =?us-ascii?Q?LYPENta4qnHebpdlpSCUpUFD7OHeIRwH+QidYqTFXpoXoTbiAbaxUlcJmV7w?=
 =?us-ascii?Q?TE8s/NxLEhRLFHed0iwyg9i3guRXTSrlSbYmj4S3NMzhPPuJGT2BaEQnqyQd?=
 =?us-ascii?Q?aehTpnaqqJIgqfwl+kCkhnQyU8eWwdJ0ToKJcjwheeK36WD772nO7nV8jdbi?=
 =?us-ascii?Q?9YT/qNs9bEn5nLlG3MSJTfqRaIMUf9MtcXrQ1dao0oj4/pSlLDMXH4kVul/n?=
 =?us-ascii?Q?+yKfaZLtGA4Hju9VSKoUEuWHp3Af3Mb5rvAA/cAsO/DgeVQES3XKD/TTFtcX?=
 =?us-ascii?Q?dMdCAAHSzietEbMacNaXcDyl5zmX7dySB4IwFMR2scPQ220R4iImUqS6LVRn?=
 =?us-ascii?Q?vlp/gIRtSCjxfPo9XehWajfCnQd3gubvjBmMHK4lyeGysW3dOz6IQCB/FX5m?=
 =?us-ascii?Q?vaw0VL8PKbtBuP5ydSBN8sG+ujMe+KQY3TiLoL9IPH4mWfPCgnRDjF8LUz/m?=
 =?us-ascii?Q?fIq4GQmvT6bUUsZcwlPlpp+JMMuIvaNd01LeCPOUG/J6oo5z3sIiVMGlhsP/?=
 =?us-ascii?Q?qQooCsjA6YHYRhUTpYfZGNip7DlDc34O+3nL4WLH8DiYdtQvw6xepptCq5oA?=
 =?us-ascii?Q?+rjudB8iflkNnrsA2Um1eHPWsAfQMWCJGW8H8kSI+IU1vO4KtUCTuBDF/KSo?=
 =?us-ascii?Q?1lTOhOHbEVBnZG5cjFMDyDDXTQDpVSKh3oD924w30AMBCbg+l0VVO7IEq+u3?=
 =?us-ascii?Q?jvzeyAtIS0++Vd40NL3L1PMXNyMGcGq+oy10skjrvq/TH9k0oDQi40Dt95vO?=
 =?us-ascii?Q?XKldrK7bmVRyByxf042Bi0GtICtk7t4esqgx9xVzQcfp0bGVxXrzBD0GbO8U?=
 =?us-ascii?Q?ZXbdbUX5EmCCR+GiaqgRduwgfTI7l5ChJ6jaIDYlcgHHmflu73jp7POI22Hw?=
 =?us-ascii?Q?vMHdM5zz0I2dMYerR2VSvQDisSDtVCNdEsmVrFXXvYjSsh4YwlIbpbTbYJe5?=
 =?us-ascii?Q?BTJgcvtlEpt3CVp62L5yppNS78PHqMM=3D?=
X-Exchange-RoutingPolicyChecked: 0IzvhdT3sbNq4HCAphqPUNWtUQn3teuzkCTuO4nckhW6UCjNGxTNyTdOsExDGtpDSiLb+Yr+/XF81TeEyMn1ap/L1IINRrW++0FH9O2Rc4KupGt3dK57V47Mv03Rh/V9wgN91k10y+EnAraMFV7uVVASvwM/nm7zrNDFbuRvp939Zs6E+AlgdwK+g+VhdcybcKNeMzu+xMdDGkz9PmF87xUItGC+nb6jEzSZWe6f+pOlAlsnDuLZmYzX6P2fZ1KWLMgt6m7luRKKABVISLhW3my4ctwndxLb3Ywr4o8UR3v6D8hM24Vv6atDgwJmSqvD7k29zjUf4JmE8/SfbBg4Qw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db4037-fbac-486c-0fc8-08df31165fb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:27.7019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tktb7nC3Y4LCgvSa87+4bCbCmgBFzNIQ91tu8zzX8A6BJY/gEgOW5tCCtDF0qWE+11AiCaMtQrCloTYDSnn9PUHlDHqz1yn8FwPwPZVlOMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR02MB11571
X-Proofpoint-ORIG-GUID: e1NuVPI7tZpxEoKTtd6J9oz4cpXVUzuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX00U2YAo5zckc
 hYb9AoqTKHMD0TsYEaobJh/t6O35BV72jr9FwQp47R//An7ibXo9FySPdL4yAZOLH/HXl+gUGDZ
 LQ62m1TvPUz7JUOKf9avVbLKz08Cf7j0ZLdnlKRcb1OHvGETcJPoNuAQ5ouTi8PLHdJZYtt+zNq
 bDGIRLfDSNG4bnB72tW6TYXDjpGKOjzK6ejnj/LuNuA8c2BqPa0oYsQBl70/2X3cD+2Ce8sinLc
 z6DHUOrCXxOthvbLlKnKTb2Z316ykPc3DNKrXNcbyWxUDrodTrDF7spaIeUg/84hqCQr3DTzETk
 a9eME8MWvewSbakXYg9aJnwLk2iMP2RpvkMZsZnsnqUxcIP3zZ2sJO+oWqAZZRIsd4/twH/ane3
 ba691tB+pFRIeTcqCqjOTYe4Q+bIbRhJnWP33JdysjffyfTU/OVJQkpOtYThdHMoivawCS1EEDK
 1FVaOPnlQxTvDUYvSvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX82lOZ9cZgf1p
 CxiY6bRcJIT0qxcqi06vUPhmouELrxA4fJIE2zF/UzrAJI3zAewkrBqM2bJz5z8sD3xQTXP+gSh
 MNpsx56FfcHQ2N32Cjp6Nnn/qROEo18=
X-Proofpoint-GUID: e1NuVPI7tZpxEoKTtd6J9oz4cpXVUzuk
X-Authority-Analysis: v=2.4 cv=TK7Q2Fla c=1 sm=1 tr=0 ts=6adb768c cx=c_pps
 a=z2sj+kS3ni7iHMEfy3uXWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=Re7Oh-p8VE-n4k5LXTMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

The isa_pic variable exists to allow the output to be fetched or read (fetched
and acknowledged) from the x86 PIC. Since this can also contain a cascaded
interrupt from a slave i8259, switch isa_pic from I8259State to I8259PICState
and update both pic_get_output() and pic_read_irq() accordingly.

This has the advantage that a i8259-based PIC device contains its own internal
reference to both the primary and secondary i8259s, and therefore it becomes
possible to completely remove the slave_pic variable.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-27-mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h |  8 ++++----
 hw/intc/i8259.c         | 34 +++++++++++++++-------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index d51a7fde32..4922f88d5b 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -5,9 +5,9 @@
 
 /* i8259.c */
 
-typedef struct I8259State I8259State;
+typedef struct I8259PICState I8259PICState;
 
-extern I8259State *isa_pic;
+extern I8259PICState *isa_pic;
 
 /*
  * i8259_init()
@@ -18,8 +18,8 @@ extern I8259State *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259State *s);
-int pic_read_irq(I8259State *s);
+int pic_get_output(I8259PICState *s);
+int pic_read_irq(I8259PICState *s);
 bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
                               uint64_t **irq_counts,
                               unsigned int *nb_irqs);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index c3a3199b8e..b59e26cbc6 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -72,8 +72,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259State *isa_pic;
-static I8259CommonState *slave_pic;
+I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
@@ -190,34 +189,35 @@ static void i8259_intack(I8259CommonState *cs, int irq)
     i8259_update_irq(cs);
 }
 
-int pic_read_irq(I8259State *s)
+int pic_read_irq(I8259PICState *s)
 {
-    I8259CommonState *cs = I8259_COMMON(s);
+    I8259CommonState *pcs = I8259_COMMON(&s->i8259[0]);
+    I8259CommonState *scs = I8259_COMMON(&s->i8259[1]);
     int irq, intno;
 
-    irq = i8259_get_irq(cs);
+    irq = i8259_get_irq(pcs);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = i8259_get_irq(slave_pic);
+            irq2 = i8259_get_irq(scs);
             if (irq2 >= 0) {
-                i8259_intack(slave_pic, irq2);
+                i8259_intack(scs, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
-            intno = slave_pic->irq_base + irq2;
-            i8259_intack(cs, irq);
+            intno = scs->irq_base + irq2;
+            i8259_intack(pcs, irq);
             irq = irq2 + 8;
         } else {
-            intno = cs->irq_base + irq;
-            i8259_intack(cs, irq);
+            intno = pcs->irq_base + irq;
+            i8259_intack(pcs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = cs->irq_base + irq;
+        intno = pcs->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -369,9 +369,9 @@ static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259State *s)
+int pic_get_output(I8259PICState *s)
 {
-    I8259CommonState *cs = I8259_COMMON(s);
+    I8259CommonState *cs = I8259_COMMON(&s->i8259[0]);
 
     return (i8259_get_irq(cs) >= 0);
 }
@@ -428,7 +428,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
@@ -442,10 +441,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
-    isa_pic = I8259(pic_obj);
-    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
-    slave_pic = I8259_COMMON(pic_obj);
+    isa_pic = I8259_PIC(dev);
 
     return irq_set;
 }
-- 
2.43.0


