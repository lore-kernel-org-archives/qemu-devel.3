Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C57606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=AcGDOrjg;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=SdzVrobU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBXY-0004BK-7v; Wed, 11 Nov 2026 11:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBXW-00048n-B9
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:51:14 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBXU-0003wX-K3
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:51:14 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0nfW3977061; Wed, 11 Nov 2026 08:51:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eitXoLebFjaAwIgapquKDIUZXUCU03HvUXx3UVZV0
 tk=; b=AcGDOrjgwvQC/37UPZ8/6V+aYlQm1aQq0NkarrehfhEDIUhiov6+ZJy7a
 +eUq5l8AtqHhtdlKVHPrg7OyCjNUtTzweRAfqqzkXcjdzOIZo5t1V8bRkJ85Tx8F
 is7cGEpRb7W+mOXBJdW3T94gmUqCIBuVwTkq9ap0HpRMs5avNYnI5iQIaYpXonMz
 C90YEug9DdijL8RID6XZ/DMDxbXNC8klOF7tKKzhVL7ItJAo45hq7CQSqKB9L+Sz
 sy4k6BY577CRUnw4Yaxh2I8C9782IAb+uwvbnFaIQcUBltOENXLeCqmzPkALzhgl
 Kcv+MA7ljKOP3Cso7ssC/UWlaSgRQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020083.outbound.protection.outlook.com [52.101.85.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hv6dm32tx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:51:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O786QutzI+nuFDY2l3Qx4fqquI/kfUcHrJX/7o7584UhZeMHR2rQkMHFtzsVR32Hdpf1i+b7Fh1g+JTLuaOmViYU2YDFyyzhejAK15ayhaGexRwU1wZbjz7nDzkTdasGnp+bNXqxKzxlisMLLu5FAK7gi1ZuMMyvtj8wa3UTu0AwBwxnAAM5R5aRQmN6uosvdQBIIHF5TrUE8kpAehybjVVzx6TAN6l7q7oRZ3s6sFrAkNRzYgbIuktZQkpngwFtYuoFPNU4i8XLVIW0Wtxt51JcteqFetYTxOVh7fDDBiOzVTaIOzUzv3gyvpZrZsKS9jHkHpqQwJqHTyvI2Eri+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eitXoLebFjaAwIgapquKDIUZXUCU03HvUXx3UVZV0tk=;
 b=SLyWxDNPpAdq0i0SbuhY5WBp22yXTP1EaKmMQYBbw9smm5epxl9RGYmM0p3WUmDQLjriXjiAQNVuYKPpm3CPV5xfeDWcJ855VyR1kjIxsZGYW0Ur+EhxGEEOK+A+uIvQ0DRqka0p8+Q3SESRI5QIyWUJO1IIu5yzTMkdBDA6GuQGFm9Fz29PhPjoqCmUmDuIF7AMfAFjni8y3n6gqAhvcFVs8fgpQzlUjymHXqA8r/6kFGOELUX5xuRZagYLi+POjH5z4aXOSlBUWxKY2Qg33NHiKC1TkB45UBMhQ/Ad4uxfhssXQ7e5vXVIQlVJNJ29Qc/jFUhgaE7DoQa4WGNhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitXoLebFjaAwIgapquKDIUZXUCU03HvUXx3UVZV0tk=;
 b=SdzVrobUgW6bPwKKGZXWuaWjc8qsLBv6JhXHTvbPF1qq/8BD4SXdhwfq0emAn4maAWiw269xgZrpfYIOvm0aN3kDrXjTm+V838Zzpq/LtM8mbSyaoySHtgET+o5mxgMtF03AsnuxR7tCfS/R0jnJsNgmdJelc0/VsCnNkJ4lka0LTczsQgBBzXZau/vu5y+AWxYHIWXk6eFSn4e5+f+K1bsob+B+pwfpsIYiJRJEbbh7g/9755JlI1TlVIjxLVwmQO4JFn0AVgxY0WyDnjQXLZ7FcqQeXpOEMvdORYTUfwP6U1dH5Ap48Fzc26WQ+CCeRpc/vvtgZd2qMTEa2S3qXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSSPR02MB11372.namprd02.prod.outlook.com (2603:10b6:8:374::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:51:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:51:07 +0000
Message-ID: <70941e7d-629f-4c48-a0d9-0c445feb87f2@nutanix.com>
Date: Wed, 11 Nov 2026 16:51:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] backends/hostmem-memfd: Register QOM type
 unconditionally
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-6-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSSPR02MB11372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe9343c-d9f0-4476-8532-08df4013fb5d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: t8hkLm0SwMln2m/SjKcMg0I4yklv8qGbU9xO4LuuLNligaE4RXIylVVEZ2YodSUBpSP2hBDj8OSl8LZ9hriVLE9OkMWpBf1JgtoSMw3IAef4D17K90lcO3+wd82hJymyJNZaczF+FIEZF7NqofSmoV6nyBkI5Hbl1Ep0fKUod/NOW80AZeNP56uwAYXMhZyf6Hbenn8uT52pDASWP7eRWGWzcpRO/Pi/7Y1145rslQVDY+AoectHWcWltpqhn+jArRT/62rNTlSXoMLMDD2Wo9jIV+cS0/IdhgpAH81kLkM435CymJAlZMsBxvdIVdcs9INBftTGRpMjNtI8xfb5cUwHGFzr5Am1b8pUESUL3J2vPQlnPOEw0/yb3N168DB7JoJm1N53cyI7jQBxv/YUBzSTMg5nJczJAF7Dc4IAem3nv0JYzNT3A8wQ8nE4WZzg34rEoBnUJfkspsHi5oPRtvYSWePCkK+zsweRj8J4bcgKWCwCaApzBsEQJDfyETlIKb5vbjzeCmhFtczXlQWsSCc67QN29TPgeDJ0rVlC0iGa7NO2V4NKEN/TW+FApmTkBFPD1k70CvwWqjCg+9lhRhlxraLr4PX1uWp5ni/prXYWqLoKFXeD4UW7ItlDF/iVr04gpL943yxTIInT/CTe6F3lh5DCHOCtathmydFbmUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2J1Yk9zS3BUcVVEUUk4cUtsbkJZNVZ0ODhlRk1nekNRY2lYTGVGZGR2UCtw?=
 =?utf-8?B?TmFUeGtRTDZNN01FN2duRlFsRkN0WTBSWkJqZ0tSK2RLdS82MVovdEJrNEkx?=
 =?utf-8?B?UGY2cHZ0M2dsOENFOEM1UW0vS21Id0Y1UFdYSi9DN0ZLTmlHQUhsUzVlazRT?=
 =?utf-8?B?QkFUT1NBRVN3Um5VYkI2WC9FSlFML21jUHk3RmZZN0lQWGRIS0sybytZa0FS?=
 =?utf-8?B?eDAxSnplVSttUFhTWmI4aG1JQ0UzYnFGRXZnaFV2ZXhvVXRoTGxzWVFOY1hH?=
 =?utf-8?B?MURIY1dyQ0NXcm1PenZnL2dzemRJS1ZQODFTemswL3habE93THppanllc0FD?=
 =?utf-8?B?dEpvVEx1SSt6dzNxQUtwUDd6NWp3ZkVva01GdmtEUVBaeUVWdkFqVnBna1BZ?=
 =?utf-8?B?RWcxOWlDQ1RucFUyL0dEd2ZJSE02elZSMnRqL1d5ZnBOSVU4UWFrbzEzcFEz?=
 =?utf-8?B?VWdRUWM3Nkk0ajRHZDVXQWRoWUdicGt5UThmL2hPMFo4aitrdm5rVUhIejJF?=
 =?utf-8?B?TFdFZ25mZXJ4d01hSmNnc202OWNqRWFPNUdFR3BWU2liT0EzWndKSkFpWnJw?=
 =?utf-8?B?dXZLNXNjWXo1QlBFaW1tbXhwRlZlK2w2T0UzMWtBZXQ1ODdla2FxQUpXMEtr?=
 =?utf-8?B?OEk5akZFMG8wdVI4MzlQbWZIUzVQV2xrQlljZlpaUFZoZlpPNWFXK2g0TEwv?=
 =?utf-8?B?bGhDVjQrUGhFeWNXNE1VNGxjRDNUb2lmS095VlJOT3o0L2dUTDZXNGlwRnlD?=
 =?utf-8?B?N3d1YVNLdFo5U0UxdmhrbFdrSjhOSHppR29nLzFad21WK0FERno4ZFZ6RXQ1?=
 =?utf-8?B?K3VjTlgvL3dFWmQxWW10VEdXK3AvTWZqdjFpUnMvc3VsSVVaL1pwZkEzSytB?=
 =?utf-8?B?ZGU1aEUwK2lhQXd4S3BpRmRkY3phRTJsSS9NMW9qVWhPUk5VZmREbFU0aTho?=
 =?utf-8?B?WGh6NXNDeXJ5TERVUmFhVnRuVGErdnQvYnF1Qlg2czQ5cTkxV1IxRkh2Q21C?=
 =?utf-8?B?eFVzVUZKRWt5T3NmUUQwRUxJNElFOVhzVEthTXVzMExqVUZxSjczNi95dllH?=
 =?utf-8?B?V2V3WlFjYlRHSE8yT3phL2p0WUdkaW9kZEwxVjhlMlVYMTFWK0dvbGk1Q2wz?=
 =?utf-8?B?MW40bzVzZDdXMWtPZHc4ekJCMzROVjBjZ3RTb213Q1ZCdWNObm5neXZ6cmpn?=
 =?utf-8?B?OXFzL2xlM3BXQktTc3NKUEZmT2hBd2ZvcmRaUHl4R1IzSENjQ1pLckp4K0Q2?=
 =?utf-8?B?clZUekxyVkE5MktLUGZkQ3pDL1pZalBKMmRrbGM5YmFhbHFXNS90Y29CVWhw?=
 =?utf-8?B?R2RITnd6RzErVE1qMlRuRzBhd2VYcnl5ZkRidFk1R2dSWTd3RDJpbm92NVc1?=
 =?utf-8?B?Sml6L21GeDZ2ejJ6MStCQUNXZFhBd08yMTlVWEQrSnp0ZjJvSWpZQi9SSmhF?=
 =?utf-8?B?OTcxTjBUaEpSZC96WXFRYlR2bnAra0lmMmlqTXhteXE0b215MGNDUkxWaG1X?=
 =?utf-8?B?VVJjS2g2SUt4ZEpncTQzYUNuZ1ZpbFZkeGRoczA0d1pEdHRmbmxiaFJQSXFR?=
 =?utf-8?B?cS9QcTFZaFpxUnpIS1gzRzFxcW9oVHRMay9ibzZFellhNDQvV3pxWWJicTAv?=
 =?utf-8?B?eXI4K250TS80Vi9yRTlJOXUrZ1B6aGRFbnVQU0piYm8vQmEwdVpKRHVORmVY?=
 =?utf-8?B?NkJYT3ZLZ2hUdlhpSnBDeGlkOUxYYmw2aURrUnNaK1AwZ2RYb3BtYlNuVDY4?=
 =?utf-8?B?dG9SNWpBdDU1SHVGNjV6UVhUZlpxeDY4ckJMRVhYbzZnVFZzM0tiNXBKWGNm?=
 =?utf-8?B?eVZlME5rV0Y0V1BDb29YZGNaWTRqTmJIOVE0WTFmdGxDOTFDVWhYOGxuajBX?=
 =?utf-8?B?VU0xN2I2QWp3aFhtMUd5YXBNVzRyVmRVMWY0allPQzlJcldnWEd6TjRsQmNE?=
 =?utf-8?B?VUgxcUVtNTNHMHpTZk10Y2JyVW1KbFJJNmNUNGIvc2lNOWFRQ3RQa2VMUjVi?=
 =?utf-8?B?NXFSd0lmMGJyOWZkYk1RUlE4OVJlRXNCd1pwNFBnanE1YzdzQXpieDFVeWZT?=
 =?utf-8?B?aEtueDUrZ014MGY1eEI5VjZXaUc2eDFOQ2o1bGdzcGRGNWpjT0h2dWJ3Vklr?=
 =?utf-8?B?ZHFUU25sbk1HSmNRdkUwY2lrbVc3VnExWTA1WXh5ejQ2WjVpbm9YRVVEbFBP?=
 =?utf-8?B?REUrRXc1RXZ5VUJLRG9SSEdOTm5LZnREa1JnWE5rKzFUOWR2elFrTk9NY3FG?=
 =?utf-8?B?UnRqVHE0Y3RrdlZ5eVh2WWRTaitWSXB3Uk5wS004dTZQUUVwenJicWg1RFhF?=
 =?utf-8?B?eTNCdlZkVEdLL3J3YVBYbDJGS2wzVjUzaEJkNFc5RTR3aGpNamJrQmNwQ3R4?=
 =?utf-8?Q?yMVWmVfWKybX7u58=3D?=
X-Exchange-RoutingPolicyChecked: V7Ew9LZz4K92cbSb28ksIUbM/7CLTkvWg9I+HIa+X9t6Vh9gwnwNTdUlIpv/gJiqLmoDZ0G5U8TR+EDIwH44imuljdHwpzDmV2lpAtfAbPadU772VULoG4baZILCyqNJ1G3qFbHZRusX/2kmzLMs5N5wdo4x5e2nEAw74nR5+lRg/aCg6g3vre5yKL+l8tqtqIyAVC++WCyAFh8PyH7M0rF5X4bXWjoOtHkxMe1P+PSinDvHUp6UD732rB89FfhRVXP5i5GAxryf97OAwAoRwEz5hHp/ewMqRF1jWR+79q8BZJr7zU8gKBzmJ6a8Rwee8JRpRj0f5vQMp1Zj2MpLyw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe9343c-d9f0-4476-8532-08df4013fb5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:51:07.6744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZITrvU1S3LExMj1kGALnDlbaho5768yhbj9I1NmrlKGQ+Yl4empOqgBUnyeBYEu0me3UdxGWRbidvMg5qqO7XSICE9xkL0vm6JU8horDYq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR02MB11372
X-Authority-Analysis: v=2.4 cv=RLImjIi+ c=1 sm=1 tr=0 ts=6af49cfd cx=c_pps
 a=anORMkbxiaoIRYctk5qcAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=lDR7h2BtNWyaAnZamJAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX77ZD/rvOg21I
 tzgMd7OZlFjLRDJV0NwJmfZAxzb2YmIiWO22ew7Kqtw6B9hL8aFG6KRpVuwqwziWM7avw2vfJS4
 sekQ22mBebKkGLsj6E4on3O77hyHQAxhj0oWBlg08bHS+TZsI3uXVsLR8rkRxGlv26JIAqZuhn2
 6zLnOSKly1idtj0upCjjMTeaklSrkKVHcgrhcsciJL8NHvfcZTVd35u0ATEVnQGqTBts0DgQnGO
 aX2iCYFAIvO3VA2fBSOwk4SVBelnLKdkAjOBk7vdSIkkqb/jc6B5IoN0TivfQkbN6BYrrI+eAjq
 DYhVVdPVZEggS7gVMErmY2M7LayvXldQ4b+jF/dOd8BNZkNpFs1r0KWyM7Ej+yd4MImtULfl6Fd
 nQMsJI/mYaP+TNyRzvAHvONA60CA3WekPLe59SoKdhh7P9LLij0ccnpmuQaNB7iLI33qRYbeZD1
 y4L04VHVGdCo5rP4zJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX+bZP447UUxSC
 AElFfaayDsSdgWSf2Gq2wXl0rQCPnm+9CqNZRLmTrqR6rERoSg1y6tvYYrVre5+4OFzPHSNleDZ
 vZL0EhU0uSZT2IK96bdqvvvWfMTw5w4=
X-Proofpoint-ORIG-GUID: 6y88Xiz26J2R98fPRMRpAb6hQ3tPInKU
X-Proofpoint-GUID: 6y88Xiz26J2R98fPRMRpAb6hQ3tPInKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:23, Markus Armbruster wrote:

> We register QOM type "memory-backend-memfd" only when a test of
> memfd_create() succeeds.  Such conditional registration is unusual and
> problematic:
> 
> 1. Management applications use introspection interfaces to find out
> what a certain QEMU can do.  Conditional type registration makes QOM
> introspection results depend on the condition, which generally makes
> them valid only for the process that produced them.  Undesirable.
> 
> 2. For user-creatable objects like "memory-backend-memfd", it also
> makes QAPI introspection unreliable: query-qmp-schema claims the type
> exists (object-add argument @qom-type accepts "memory-backend-memfd")
> even when it doesn't.
> 
> Conditional registration actually serves no purpose here, because we
> still have to memfd_create() for real when we create the object, and
> need and do handle errors then.
> 
> Register the type unconditionally.
> 
> To test, I hacked the qemu_memfd() call to fail.  The error for
> -object memory-backend-memfd,id=mem0,size=1m changes from
> 
>      qemu-system-x86_64: invalid object type: memory-backend-memfd
> 
> to
> 
>      qemu-system-x86_64: can't create 'memory-backend-memfd': failed to create memfd with flags 0x3: Invalid argument
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/hostmem-memfd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 11d456e3ebd..54f84ae331a 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -223,9 +223,7 @@ static const TypeInfo memfd_backend_info = {
>   
>   static void register_types(void)
>   {
> -    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
> -        type_register_static(&memfd_backend_info);
> -    }
> +    type_register_static(&memfd_backend_info);
>   }
>   
>   type_init(register_types);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


