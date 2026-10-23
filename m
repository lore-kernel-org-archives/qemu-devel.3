Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0E606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=f1gGTMiG;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=LHlPG5Ka
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKArd-000559-HA; Fri, 23 Oct 2026 04:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKArb-000550-Kd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:42:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKArZ-000297-Bn
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:42:59 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7Euvb2965191; Fri, 23 Oct 2026 01:42:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3lLZT2uOTMlMtegXPFOCQScjPsWxraWK9hiFWH7Bz
 yc=; b=f1gGTMiGNBhK91eVVQ87u+PFU42OK1pVynEL6pmpI7vJ20PHawCnJVIQv
 IE4ChUVbwVOPsGAjsLbpulmG7yn0C0aYZDb1HXAW7IEZ96CU0UVYP0hPrbtoz28/
 Wr5aGLplKkwbePrMz4xzMNFvz0OR7N5aIiH9HI7lhpe+lUcctZ8YFHc+M5mtsPDg
 QumxXwTw3OhKrf5T/1xNRGskzTKBCcHCKC+LEZN50/C/QOigjLGOlMgLyEhIHrmu
 N5eflt2ik9aUhx78M7zkOhS/8wh1vLFF5piy4rCshKc5yzcmncnmwPA1QgNT9/jZ
 0mhFAKjh7qUitfcey31JMpEIMBv7w==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021083.outbound.protection.outlook.com [40.107.208.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf974c5wu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 01:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckC+IO9GaG9i0Qn4SgTKjKQtxFztEZrUeY/sTvvPe5MExAPimDPrhCalJvJohOlDcaZxcx2AELms+pjsTmEXc9smpjwQke9TQuecoSflzVOw6M/GNOYgcMHFuD+KNoIOtd9ANpnicUBK9TssL2rrx1uqTIpCk54Lw/E6oeMB6FD7vlr/vceUNMJ8qddSC5BbdyrIBA/g9TVRNXibQdIAebF8Nz4Jo7gc0ACJVxjgfLieHpybSsxYtTevBf3ObEo147x6VnL+SwNHwAQkOqq9tVdWwrY6suKjXLw1W+BNYjzXGamq1XGzkG/OJwcwbIRiK+tLnCSF9BOwA/uJsH7EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lLZT2uOTMlMtegXPFOCQScjPsWxraWK9hiFWH7Bzyc=;
 b=bN0KPhzFdIDShvQ4gVFCwrGilSUiF+6wJOBIHwikRDJ1K1yZkhm4Uu4Fx+CmqP7O2i6El/ZLeuXCmAlVWFE7oz+Ipo+j/6KQIJz0eCAl2aYMbkpcpjVfZs/EzVeodNd8GjSfyNz6y5bbFHjY39pwsYGLBDQq2AAtHDDNPc5GEA2JqfJ/dXdNtAgIJf/yOt++Coezbg/PYyrduNdLaszA8+LxllXyt/FKIYh8S/GoToOmabEwctQNbm+zgZa6ReGyonpatnLLBrd5npeB8vH4R8kN+PfKtTxX5+4/lSXub6Ue0bQoGgs4QSajZPkKXZlsoka/d3LXcTussToqYC0Dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lLZT2uOTMlMtegXPFOCQScjPsWxraWK9hiFWH7Bzyc=;
 b=LHlPG5KaLQeneo/SvMYGy+WqNsdhV57GyHJng9/f1WmrLDYs/eLaAn0fdvVXnnclf1s3gKd74zKP01o6BeqqWdXkjO5oXbOOmSgYq8MBS+vcYQVGUx+Fxs8jaWA+3rH51Ch2P2n05YasbRM1TSwSi8kFCWqNnCpBKufumixpzk6y+11Gk2lq0ZV1etNvGnFgWVWcjzEeK2mg9MA6/I8C7/6X0chZFXW/YZ79gaH4fHnBQhEXe9CgvgBrDbDLcqqDtMi0TID1xeSAF++iRvYuavCoKKfzN46VmRN3m9QF/Po9gpiGBH2J1dctPTRPGZSGdoIb1UalPRNaulcI2WsBvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV3PR02MB10690.namprd02.prod.outlook.com (2603:10b6:408:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 08:42:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 08:42:45 +0000
Message-ID: <cbfd187c-6114-42b8-8ff7-b9af8afe8129@nutanix.com>
Date: Fri, 23 Oct 2026 09:42:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] i8259: improve qdev PIC modelling (and misc
 fixes)
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: Peter Maydell <peter.maydell@linaro.org>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com,
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Language: en-US
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV3PR02MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbe548d-d037-4f41-dd9a-08df30e19bae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261022105027099003|261022075727099003|56012099006|261009223027099003|10067099003|261021123027099003|261021121427099003|22082099003|18002099003|6133799003|3023799007|261022113327099003;
X-Microsoft-Antispam-Message-Info: 8v9DCGJVFigCfgeTIlXwV1lUbAsWpbrqRSoaBZpfBrWdcou0eeHo+znYDl3uD6/s/L/NZP4F+Tobmctbay9ukN2OVIAQkgXRAduFB5NEVA6nulXyIaomzdvdRGVVKopArUy5rr6QhzJUDoWQ1RHz8PlGngEZOsc42rMR46kxtCkVokn66/qIwggof3jhNAqeiwghKJ+nSDYYp8DhGv1LuSujjdK/3SaT+uuvJXvtmbaaZjnmqzHQpjYGB44xTWR9kcZlQdy+N4Pos2Zl6HkQMTcBshc1gIKXUqEsXVb35hbDY5rMGQmxN2kRrTU7KU+i5GjNgfzQauDYUoz2AnDPe+MHwaYhFEW6ihN5SLjbFr86XjVJY/6XkkYTkqirqwFVei3mwzZOqWarPUf3DTxFx1imllM71DjdPG08ZumcO9yX96CFVFeUS6HlFvjV3EyO0c4VEgv5BbAWes1JcaJsrU528uC6ODGg4W0ACLt95aaEpmKtsIaahh3cZAynITSjWHuEJSqwVmPSIiKxwQlzrVZspfjJXM527OQwOUVnClk2ElFH87+iFvPsyB8TK6SXd6QV27TQUekSF6n+uagKAvZJTy7CFMZjSCM5tJ2xnbP4Uid2GPmKf0nemOasZBngoYZ9UfomvZIFWuuUjB81BEXhQbTNybW7wnmfGVqReWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261022105027099003)(261022075727099003)(56012099006)(261009223027099003)(10067099003)(261021123027099003)(261021121427099003)(22082099003)(18002099003)(6133799003)(3023799007)(261022113327099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlY4VmYyWExOWjJTWUpHYk4vTHFKcGZUSXhxMDk3NCsxdjdpVXAwcXI5Vmli?=
 =?utf-8?B?bFFVa3lOb1BmOHpKbXc5U0p5QTUySlVIVFl3d3NWSVJNc21SZzN6QmQ1SmJr?=
 =?utf-8?B?bmhsTElmOTJuMU01UVhzelJXUjVqTW1IR3c0YzFGMlIwRzNhQ25jVDdVeXND?=
 =?utf-8?B?WDgzS1RXdDc2LzN6a0R3b2JnWEd2ZmU1U0loUXVOUnR0bzc1VmFBc2NyMHdL?=
 =?utf-8?B?YWQ4VlJweWZQcEU2c3IrcWNXZlNTa1JtbGRyNUQxZUt3ckdTbXJXckYvNjhr?=
 =?utf-8?B?Q1hTWitxWlhLZUFobFBadElGdU95Q045TFlnZEh2UkhvZDhEbnRCdW1yNUMv?=
 =?utf-8?B?b1VQbHRrWCs2NWQ3NWVjWUo1ZEZ6ZUdxWUE4b09ldWVYTTkwU1Nib1E2TzRN?=
 =?utf-8?B?OVQ2c2psOExlWHBvdUNxdzdzNUJqckg2WjRoQjEzYTRUelY0Ty8xVE1IdEFZ?=
 =?utf-8?B?NmsvTU1vOTVFelpjY1VxMWxLYitHRkRVOFk1c3lacDVzZVJxR2hxZnNMaTN1?=
 =?utf-8?B?c3NzdlRTd2UxSzNVSWZLMkRFd3Mra2p6NElXd25pbGVzUXpSQURJUmllazVU?=
 =?utf-8?B?VDQ3S2UyeXQxdUxSbGw3LzBrOHFhOGR5OFhad1k4ZnNCdVNuWTRmR1Z0K2p2?=
 =?utf-8?B?cmEzakJHSTdKbElPOER2TCtvSEtPR05NNVRIaUxRRGhlUVRWNnFiOHdCVXlj?=
 =?utf-8?B?ck5XRVBRaTA4cVFHcXl6OEgvTmZ0RWwwTUYybWFLOWx4aEluM1AzWmhlbTll?=
 =?utf-8?B?YzVkK1RoR0ZaOG5waVljZXpDSFN0bHdHdVNMWWJOSTdjd1FOdjBvOUIvUHFm?=
 =?utf-8?B?TXFNMkNhd0xyVUE1WDE0MG41ajd3QitqdE9aLys3OXdhb3NhNjdjeVBxS2ZM?=
 =?utf-8?B?WXQvOFNmUlQzWHN6ZXFFdm9FMVZaSVhUdlYrdUlUYTIyNXVldlcxNjRQR2g0?=
 =?utf-8?B?eU8yTUpleG91N1FIL0lXS3NIdUJwWmlDUzBxY01Pd3RlMjVTVklGUWV3bm1O?=
 =?utf-8?B?SCtUZnhBcUY3dHFTV2I5SkwybURMSGhUcHVYaHhuUWFVcUZmWDhVVFpvdFdt?=
 =?utf-8?B?UkpXejZ2bnRIbXM3VWFZUGpxM1ZiY3Y1QWg5cEk4bU81L1ozK3NKbnNsWFM3?=
 =?utf-8?B?YndpSDdOeDk3UnM1WHFWbTFsdlNDZzd4a2twUy94UlJycmx6eW1qMUlkNGtj?=
 =?utf-8?B?SEJYWGN3QzFpRlRaRW10WTMreDVpUEQ3ZGFmVytNLytRVFQ2ZzRTZS9ldHV2?=
 =?utf-8?B?bU1wV0dlSG0yenJsZ2JLcjRocmV1ZlFFQzIyRGNmRVlOOGVSYWFsMWxWS1Vp?=
 =?utf-8?B?eDhwdkxBcGFPbDRsWTZya0pweSt0QkRpVEFhUFByQzFBSFZmb1NvWUt4ZjJN?=
 =?utf-8?B?ODZ3QzR5cDRDV0pMendBdUl5SkQvY1JGRXR3VlJxdGdQY3VZalh2VWJtL3Jz?=
 =?utf-8?B?VVF4Zm94aXhCa1pkK0lGaXBndm55eTdmdDZZL3daSzBHa3M2MUlKZzYwOWlv?=
 =?utf-8?B?ZXJWTEFXY3ZKTDF0UjJsakNBSHZMczZhbTdoTVFGRVg3VDR1NThHK3pFdllJ?=
 =?utf-8?B?Y1BXcmxiWUM3Z1A0SDc1T3pBRzVKeVlKQ0ZBL1RYWTRocnFpYVJRSW9XTmtN?=
 =?utf-8?B?T0ZMZ0NZOWQ1UGJXN2hCSXVGODVCOElJTmNFUmc4UWJpQUkzQXJxdkR0d3cz?=
 =?utf-8?B?MzcxMGsrWWkwNnhESldCczhPWkY0ZVdMVHlPTHQ0cjhOWTFsRmZmNkp3bXNl?=
 =?utf-8?B?MUhmRFFaV3JhOTdnem9xaGVWWk0wL3BwUG9WOUlybXhUYmtXVUhJelI1Vysv?=
 =?utf-8?B?WW1MeFNCZUdkazRBMHhTbEkzbHFLLzhUakV5UTMzRkJjWWRaT0VjVEQ4U3ZP?=
 =?utf-8?B?dFRCYXUvZ2xKMDM1dW8vRTg5cUFUeTh4SGg5Y1ZkOENTaU4rbGxLc1U3ckpt?=
 =?utf-8?B?V2JxNXJCYk5kUlh0U0ZlZW5odGplNTFWSWo5UXltdEN6V2JVeERvUzNBcDV5?=
 =?utf-8?B?SnFGd3FESElrOWpLVVV4QzhhTGEwbUxwU2tMbGRSdVNlTWdjZkwrMnlMWGdt?=
 =?utf-8?B?WUNucGVLK0tSOHQ4cmE1WU1UajhTajRPQm9KNU1PSlFsRXZaTEgrQU5DRk92?=
 =?utf-8?B?QUxObzBjZzhvSGd3a1hucUdEZEFrOTl3b0tiS2NKSkV6cFZJRDd6VVlzMEhH?=
 =?utf-8?B?Mm5wM29sWVllZUVXa0d5eDE0Y1FEenM4SVlSVUVWL0FuWFRHbnh3a1k2RGFM?=
 =?utf-8?B?SENKQzNnMll3K1hzVklKQUc4MWxIQ3pyRk9MU2pKNlVSY05maForNENaMVQ5?=
 =?utf-8?B?N2xRdGsraEwxTkc2dm1hUmNNcG5WTHQzTmk3TitWTFlxRzhFRFRITmIrTVNz?=
 =?utf-8?Q?/albFR0l5ZSTk0kE=3D?=
X-Exchange-RoutingPolicyChecked: 2DrViv8RUPfHTUYVFJRgCd0Ki7bBtlPt2VknGpfHkF+dfpHmMzwLfe11vVOwTA4rDSzTJra9G/2GgqC1dK4cUMNRCbYaoj54TkP4pI5Qs9SceX/vDeJtmid7xbsIwttdSn45gsuA7lMPvZke62IwFPxrmPMl9goa8LfpBrZmqT1gxM8qbiV1K+IYqieKs25j/++k3gXG/KtNMs4pbaoacdKzE+5GRR4EGQQ2E13SNgb8P9T2aIYkj8EF+NPWLY2y+mbVLXy6Sbs/wWcV/1wIjVEs8i+bCE119v5cHpXtxKuCqoEwEQmYz2abmBOItDbcAfZ09x2R6Z0YZmNr1XeaNQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbe548d-d037-4f41-dd9a-08df30e19bae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:42:45.1274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz7KD/ndaFRc5AyTe+gl4l/p+K6+KVYJHCQFIVp0f1d0h6Ho0vK3l8M7QlemPYwkTCni+Afb+M1LXy6Irlhpu2QC/1k7cGYvfOsOZUdm4Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10690
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX2J5uSaNbGaTX
 1yvdw0zqeMMTsLV2mCpqhbM3MC4Qtlr9e2KRxKk6bYrakfRsAgsjC8xi7wj4CF75OtDLuTN5qnj
 SLfVAZ0HG3FXzI+6ZPZpP/mCCs5m4ASfk0u2Y1Cm2mLC0lmt1HAw/n0DXJ3f8nehKZh6Y99o2aO
 7+iQmlQUUcqvIqo2nWpDJpWEHkhUONQgfsDdEPPwCU6GztYPTPiJDVV3kU4XEPPDNgtMkaCPBvE
 R3YVfY9FQOW/4apUFhB6L/P2g4CT9CYBUwpeYPuX5mYP+GHQJUSiya+QMNWKCxTjnwh9w8qKQEQ
 +2+koQyaPAHy/zCfBMRNSkXau3SedVFVHpKhdLsh+aTvb+rfpRrGtmtPKQK7R0xfVBHouwXy2xJ
 oHerFrUs78R8s+Ie5W5xT8+GRn/ZoN30Tw6mjQBblncnCxjEPIk5L6xgPkkOpbu6bKSu3iiwZ+I
 AYF/mzEeBw2la3Z59EA==
X-Proofpoint-GUID: y_EuDdoQT9oWsVVCLl-TYaUXSKEsGtk6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX4QOysaXreEa0
 MtYKEC8iYTvVqAuYSUQHx6en2KiL0flObL3qNK62X2Mg5ZH9p6ecIKwFZPIAQlJGxjmBCt3dDlH
 uIYVVf3/8+ZaOeA69NJI4Mzo4ahjQEA=
X-Authority-Analysis: v=2.4 cv=VaNir1p9 c=1 sm=1 tr=0 ts=6adb1e08 cx=c_pps
 a=JzGR8r3o28cAtrGeABx37g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=K9gjxBCPemF015cAt-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y_EuDdoQT9oWsVVCLl-TYaUXSKEsGtk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/2026 13:04, Mark Cave-Ayland wrote:

> This series attempts to improve the modelling of legacy x86 PICs within
> QEMU. The initial aim was to have a qdev device with one output gpio, and
> 16 input gpios representing the legacy IRQ lines, however as I went about
> trying to model this, I found a number of other inconsistencies/bugs: in
> particular there seemed to be some fuzziness around the functionality that
> belongs to an individual i8259 chip, and a cascaded i8259 configuration.
> 
> For the purposes of this patch an i8259 device is considered to be a single
> i8259 chip whilst a PIC device is considered to be either a cascaded i8259
> configuration (emulated/KVM) or standalone device (Xen) representing the set
> of 16 legacy IRQs and a single output IRQ.
> 
> Due to the updated device names, there is currently one visible change in
> the HMP monitor output for "info irq" where the isa-i8259 device now appears
> as isa-i8259-pic and the kvm-i8259 device appears as kvm-i8259-pic (see
> patch 25).
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> [Patches still requiring review: 18-21, 23]
> 
> v3:
> - Rebase onto master
> 
> - Add R-B tags from Peter
> 
> - Introduce isa_realize() function in patch 18 and use it in patches 19 and
>    21 to fix refcounting for ISA devices within the PIC container device
> 
> - Don't pass input IRQ 2 from the primary PIC when implementing the cascaded
>    PIC configuration in patch 20
> 
> v2:
> - Rebase onto master
> 
> - Add R-B tags from Peter
> 
> - Remove FIXME from commit message and rename trace event in patch 13
> 
> - Introduce a separate I8259State for TYPE_I8259 and KVMI8259State for
>    TYPE_KVM_I8259 as suggested by Peter
> 
> - Keep but rename the associated classes for TYPE_I8259 and TYPE_KVM_I8259
>    and move the DeviceRealize function into each one, instead of keeping it
>    in the parent class
> 
> - Add patches to make variable names consistent when accessing
>    I8259CommonState from child objects
> 
> - Update the comment on patch 19 to reflect that implementing the
>    cascaded secondary is actually a bugfix
> 
> 
> Mark Cave-Ayland (28):
>    i8259_internal.h: rename PIC_COMMON to I8259_COMMON
>    i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
>    i8259_internal.h: rename PICCommonState to I8259CommonState
>    i8259_internal.h: rename PICCommonClass to I8259CommonClass
>    i8259.c: rename PICClass to I8259Class
>    i8259.c: introduce TYPE_I8259 device
>    i8259.c: always use cs for I8259CommonState variables
>    kvm/i8259.c: rename KVMPICClass to KVMI8259Class
>    kvm/i8259.c: introduce TYPE_KVM_I8259 device
>    kvm/i8259.c: always use cs for I8259CommonState variables
>    i8259_common.c: always use cs for I8259CommonState variables
>    i8259_common.c: use i8259/i8259_common prefix for functions
>    i8259.c: use i8259 prefix for functions
>    kvm/i8259.c: use kvm_i8259 prefix for functions
>    i8259_common.c: convert to use DEFINE_TYPES() macro
>    i8259.c: convert to use DEFINE_TYPES() macro
>    kvm/i8259.c: convert to use DEFINE_TYPES() macro
>    isa-bus.c: introduce isa_realize() function
>    i8259.c: introduce TYPE_I8259_PIC device
>    i8259.c: properly cascade secondary i8259 from primary i8259
>    kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
>    xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
>    xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
>    i8259_common.c: remove unused i8259_init_chip() function
>    i8259: move InterruptStatsProviderClass get_statistics() from i8259 to
>      PIC
>    i8259.c: switch isa_pic from I8259State to I8259PICState
>    i8259_common.c: remove static irq_count and irq_level variables
>    i8259_common.c: add missing 0x prefixes to "info pic" output
> 
>   include/hw/intc/i8259.h         |  11 +-
>   include/hw/isa/i8259_internal.h |  19 +-
>   include/hw/isa/isa.h            |   1 +
>   include/hw/xen/xen.h            |   2 +-
>   hw/i386/kvm/i8259.c             | 250 ++++++++++++-----
>   hw/i386/pc.c                    |   2 +-
>   hw/i386/xen/xen-hvm.c           |  40 ++-
>   hw/intc/i8259.c                 | 470 ++++++++++++++++++++------------
>   hw/intc/i8259_common.c          | 225 +++++++--------
>   hw/isa/isa-bus.c                |   5 +
>   stubs/xen-hw-stub.c             |   2 +-
>   hw/intc/trace-events            |   8 +-
>   12 files changed, 648 insertions(+), 387 deletions(-)

Thanks for helping review this series, Peter. Now it is fully reviewed, 
I'll send a PR for this from my qom-qdev queue later today, unless I 
hear any last minute objections from any x86 maintainers.


ATB,

Mark.


