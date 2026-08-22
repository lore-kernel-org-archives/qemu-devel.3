Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC31DC5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 12:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxktt-0005BN-NF; Sat, 22 Aug 2026 08:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wxktr-0005BB-VE
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 08:32:39 -0400
Received: from mail-japanwestazon11022083.outbound.protection.outlook.com
 ([40.107.75.83] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wxktp-0005Zf-VU
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 08:32:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3rcnXCqXimcKn1mFdckhLHgMqyBlAH1XbMBWEl9PvThsRCwBE58vql44qGChhqK/p666ALWmZ58H04IUmVCL18fdtTPf6Ma3SngdFY7oBTAl3WuQjz26s6FKAdlVIb+LPQCzazCdmIcB2CoNnl9BgdVl2V/HZ4gV4tpV00PfrUx+AxTCs68D1rIZnMIrsI5XTRNESmezZdhAVtqLaLPp9EkI3GQj1b0dGsTtg9bqyiVaiNnoQ6QycdVSncEjImRjkHZ9nDks0WnMmihllgSKyU0LZV+4Zfif9Q7mp51htvjAIo7WfTUNwaIuCTYTriafd6p/jq71ysXuz2rO2AL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIbjOkTlEDUMUTXYO7roK3deraVIS6RYpiNnWXcvMec=;
 b=Aikr8qLzMOieKC5UNOohZfGPakljAdkmurCuokmqhwT/ko0jOG9Zjcp6R/g2uBZEHj8ifprFu//0InN59DzVVNBjMF/CEbUjtx5bYk/YJ/MEas13CjWceeBSjtC8a/xij8pET/knQJZ/QoO5ifb1Mvqq/fcf7ZEwpSP4lsMOT4z9DESeY4VydW9X1gfdG00MJIemuTSPsU+IsudirFgWDWP9EfuJ4bBC0V8zCJ3gNTl1TzQRRKQ2PCpKF2FtbaLCCviqgDKiIFMR9tpuFNFXMLhdCpgLZJhw7OQZOZrz7fN/XkqFJwdEGIy3saZLRNHq7wG6BYZVe6IxnWRC+nFtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIbjOkTlEDUMUTXYO7roK3deraVIS6RYpiNnWXcvMec=;
 b=fsNXuzsd+r2mn6Q/9T/6MhHLrQKdDlWvi9EZ0LWvFIg5FgN4et5iwIoZUuTXWTpgan3RqgE8cug5sSVGYJdnRW7odxpy9SJoFn6VSOzDYjjLhAL/QnZs9COaL5ddXP1EliBlNDZBiTlLTdgpLd2lejVAbxlJxjmRJEg1l61TdaPoYZn8/o01F2LAXYpEDVWTBElH5k8xCwrzqc9wHCx8wGNrBm4yAz1bbZZpsbM17fiWdIBycNuN7ati5aMeifgATT8YNz20kaBCMgeN3zDN/k+yWj54ZC2K7bkXF/O2EunwM4d9kL2Ijq0Pgra9cY/gva2R9DBfXqwK1re2GD/xgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6504.apcprd02.prod.outlook.com (2603:1096:400:363::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 12:27:26 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 12:27:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 0/1] system/physmem: Improve guest memory allocation
 failure diagnostics
Date: Sat, 22 Aug 2026 20:27:07 +0800
Message-ID: <20260822122710.3731595-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:405:370::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3b63c4-022d-4a2f-db1f-08df0048b9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: womlSFRVs8rCjIaauzdArws+tIUk37CuKzwQa2b/K0GENH9yIzikAI2EwOJhifdQnGIpKo+cYBXFNEEF2Fzhm9uaVAVyg83mJ+9B497wCJjjKzhTcHv57II+Y63er7OKhM8GPHAwR0RkVuRw3MRKiOcWFfixsUiCLXa5bl9R7vgpLe8Lxek4DIhzKERad8vqkCJMekCfym9cx8W+ww+/xW6xAsedSBBgRSOQ4PcgCfHzqiFHo12ZS7MAdvAFjlY3/FwK1eIKwMtnVwaEN8vFnRYskU7gMQgxJtnpJUQft9vp7RRu1/52oSdGzRa84EPIaRUP0WSdwHmDQZwgBCFSJxjPHfV3Q/IX0Yx8kF1RlznJfKCeqlGKnV5HAVsOBW8JfTJhSqQDHRW+/N8yVVlhlQXdbBe4W8jI2liKqmw2LygqGfxFFIVCgnCwY2z3S+mHx7JQl8btGI/bNTUebBmi9ADo1bWFPKt0q3/zi+Bz4J4kGovpXzrxUQn+aoo5vKTVM088Y+EahaVyhoDLY1dcHuqWn3V4Gu0Jaukxb0DjzlGpSdYbfKbjMUYsCL0KHfyrtIk1seKG4n/ywhF8YvE3ASMBoVRtkPtpSRmLngxdr1D1t0WHwmkEP5s6qFiFP9BPUC+plnknWRewocBohMrsK05rZ9FCkfbcdwDqC0fHJjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FCdWF0YXo2a2FEcWx2eHA3R0M2RDJRM2Z3TkVaMTZSYTk4aGJENXhod2RR?=
 =?utf-8?B?S09ZVVFQNHdqL1lPaHJlZ1krbU5DQk5DVFBtdVFTbnl4TFYvV1oyZEtXeVhT?=
 =?utf-8?B?V01DSVJFUHhIdzlRMlRIbkRMeldYRW1sUWY3M1NNRlpKQkg1bmw5cWZSeWIy?=
 =?utf-8?B?MVFQVW5Xcks3SDJtNmRaNzFwUmFrRlVpK0N1S3lhSkdMb2dvbHpMR1lvZnVx?=
 =?utf-8?B?R0RFU3Btd0VtWmlrbW1wa2RDejlVNzNUT2xWeDU2S1pCZUVObys1REdRcC9t?=
 =?utf-8?B?bUZJellyU0lNdmd4OUZybTRhM1BFalRYaDFwaDN1Q2MyR0E1Z1R0ajZUdGRD?=
 =?utf-8?B?OGJOUWlJZFo5TVQzbjhodkhLa05nZUhQU2ZUZU9oNUo4RjBJc0p3UTgyUmlU?=
 =?utf-8?B?MDkwbWpkaWFMOHk5K1REbUtmUk1YNG9saGVQQW5LY2plczZGTFhDRjFvL2hl?=
 =?utf-8?B?a1BOalpJT25ZYkNpS0VVZndvdmVjN1R0WXlHR3Z0K1VoQTlieS9KR2JZQmJl?=
 =?utf-8?B?TTBveng1T2FXc3ZUWGF4RFIvbWRRd0pHQ1NBUFFXQWxxQUhRQ0R3eXBWU2hR?=
 =?utf-8?B?WklFK2FDa3RMa1YyYklzWHlXdy9UZjVidTN3aDh0VWRNYWlTVmM3NVhLS3Rh?=
 =?utf-8?B?YUJiclI0THhkWThmWlZMTFlWam9oTjE5SXV3WUxzNjQvOVVCVFk3bk1ubEw2?=
 =?utf-8?B?Q0VOVzN4MnN5UlRwSTd6K1JRcXlhN3JnNzk2V1V2WXpmZkhwK3NPRzJBMVlZ?=
 =?utf-8?B?WUVTT1FBaHhYVUI5OGdRZ0RBTTF0Z1NlMGgxUzRud3BCa0RVWEdJM3dwdlV1?=
 =?utf-8?B?QkE1VHRBY1czd0k5WVkzTENCQ2dvc3B1b1JIU0owbjZlZS9ISzBBMi8rUTdo?=
 =?utf-8?B?NWR6dW1xeWhWa3RoTll1UkJWQit6anlFWHh1TWp2Y2xnYk1zL1dEbWNaQmFD?=
 =?utf-8?B?TmVxemR2bjgzTTNla2lEejRjQUlCSEg3cFZGZStYZHNwU0YvSVpDeGdLSjBS?=
 =?utf-8?B?d25iYkhTNmZaOW1mK2QxcHRtSS83bFZMblpwOEJwSEVkZGd0QnBrRlV3dWFz?=
 =?utf-8?B?RzBERm1hWjFzNWpHQ3IyaUlyekdJVjRISUM0M3lPb0gyK1BwN3NWbVAvMzFI?=
 =?utf-8?B?RFZScUs4dzRTVWs0UkJUeVhVWjQwSDNJUGNzdmhidFBTTFJWMk5IbDRxbTI1?=
 =?utf-8?B?Z2toRGJ5b28xT0o2c1prQkhHdVI5TEVYQkExMXFtSWhPUFA1V2tsLzJYc0sr?=
 =?utf-8?B?MmRsM3lxaW4vYWI1c2ljaDdCaUl3Q0xrVGJib3ZsbmZ2Zi94T3BmYkZCYytM?=
 =?utf-8?B?OXN3djNXK2F1RkZpQ2ZqUXZlaWo4dXZpNWs0QnlYcE51cG83S05BSnRnVVQ5?=
 =?utf-8?B?UjZObVAySitIYTFma2ZqMTVmVldnaGpTYWtQMHJDazFOOUl3REpFVXdmVFdv?=
 =?utf-8?B?bmdTS1BOV1RiRlc0emh5U29MejdyNzh4dE9CL0hyV2U4bXZiTXJURVBKWkhu?=
 =?utf-8?B?TWZmZ0tuRzhZelZFdmozMVRFdlRRMmNOZ2toRm5jK1RoQmQrOVdkR2xiSFFt?=
 =?utf-8?B?aHExVXZ3QldUS2V1NDRUOGZieEszZzJsTElvTmxleDRXTUwxYWczUnJicDR0?=
 =?utf-8?B?UW9vaWR6VklWV0JjWW1qQW53SG42OTdBd3M5L05oNHZJalVlWUdadW9Ib3lj?=
 =?utf-8?B?dk8rd2NLU3V4a0dOVUlsSTgwaXNxOHpPNU5lVi81VjhPWlFEZExJUCtjWGgw?=
 =?utf-8?B?bUhpSUlRVUF2WWJHQzVBSlRsdHhmNDRoT2EvekgyMnBrejFBWUNGYXgvQ1A2?=
 =?utf-8?B?Z1UyNWNVVG1OQmt0TExKSjROQ1cvNlpIQTJQK2JFNHhMc0NYdUltdnEvaGhD?=
 =?utf-8?B?Uko5eTgrRG8vdS9WbnkzMmplSXZyeUhRbEF6T0FheC8xaFFJTVplTlhJd1dI?=
 =?utf-8?B?eDIvMWtab0lQeXZQYWN6dWVVVkRPTlU1MldzdnRvc2g2bTgzY2wwTDJvZExM?=
 =?utf-8?B?Q0JSNTlPYlBRWVJVbDVzRnIxcElHSEFVOWNZRWRtWG1oVFZxZXJJNytNTVhm?=
 =?utf-8?B?N21PckRJT3Z4ak5XM2l0TCtRWGlJTzJrUEkwZWZGMG9VLzUvZzViVlhMNjVk?=
 =?utf-8?B?Rk9JOTBtdTZ2T0FHTlRuT21ib3VmTU9lekdCOUc3dzRvNFlJdnlIdlA1SHJs?=
 =?utf-8?B?K2ZpM05icDQ4Z1Q1VnpaMlUwaHJLWnRLN1YreVpFeG4zaWNKbnVmSVNjNm1C?=
 =?utf-8?B?ZjJrTG4wOEl4U3FHZU5PUS9ndXR0amF0WlJmaytXZ2l6K2NETHpWK1pOK2Yy?=
 =?utf-8?B?ZEZhZFZVZEdKWXNHcG9aMUVrNGFyV3FEUndpYkJjM01yS2tzUmgyUG9Kb3dJ?=
 =?utf-8?Q?zjnfhlxZZkEiujEA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3b63c4-022d-4a2f-db1f-08df0048b9a7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 12:27:26.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbUsX01l6IMuDtRdjyCswVJMkG8eOIzJOSBC/BxMli+82s2luIHFn/KC58EfSZzP8rtCIM125OSLcMLw3xyKW2HD0rFju/eer25Ni1D0qaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6504
Received-SPF: pass client-ip=40.107.75.83;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


This revives Philippe Mathieu-Daudé's patch from 2021. The original
posting and discussion are available at:

https://lore.kernel.org/r/20210820155211.3153137-1-philmd@redhat.com

When host memory allocation fails, QEMU reports the affected memory
region and host error, but not the size of the failed allocation. This
makes accidental requests harder to spot. In particular, a bare value
passed to '-m' is interpreted as MiB, so a user expecting bytes can
unintentionally request tens of TiB.

The patch adds the human-readable RAMBlock size to the existing error.
This does not try to explain host-specific overcommit, cgroup, or NUMA
policy. It provides the most useful portable fact available at the
failure site and makes both user mistakes and support reports easier
to diagnose.

Changes in v2:
- Rebase onto current master
- Update the source path from softmmu/physmem.c to system/physmem.c
- Fix a typo in the commit message
- Collect Peter Xu's Reviewed-by and Bin Meng's Tested-by

Philippe Mathieu-Daudé (1):
  system/physmem: Improve guest memory allocation failure error message

 system/physmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

---
base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95
branch: virt

-- 
2.53.0


