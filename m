Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D395C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAJi-00038z-1q; Tue, 07 Jul 2026 14:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1whAJV-00036L-F0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:14:33 -0400
Received: from mail-japanwestazon11022109.outbound.protection.outlook.com
 ([40.107.75.109] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1whAJT-0005y0-Ab
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+5d55rXJUZUUgqrYcnRPYM0V4LXuG3tIPcKUXRbRLm2HiYAqp23evfnBaBGRm6ZkLis3nz6d+89rio172z8N4SqtZHwepM6I3WtB8uQWsJBvqD3aYzE1Lr8qOub9TqiYpXmdADZTEd2y1Lt0C3VgYdz385bf6jiuXa/5CDeKwLt3419YK1ekBEMS2PFIP4rS9QSvkxsXZihs5huYTLFrhhBd+XbmcPxfN5LiuF2hUN3LUPamlg9ogAhMeEXGLJloilBRFE3JdB5e0tMHf84YCxoQCugM2oN5S1Tbn/Xatb3osOEKDh20Qx2laO/OY4aZbR4WFRLnTPu4piMtTQa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsSn9wS01JZ9u9o4urejSSQrFwwe3WjhZqmIbmw0khs=;
 b=AHgMwpr/lE8x+C4epEFUlnEhljr4gOwAIykjI220ZNH0LgyjvQlfB2Oj09xYRoiq4pgX/3gwt7lCZlOfyQXiPGIOT5v7fCv+ZYrvoTylOzuam7AEZ5+oIMQyYsR4X1hviey0jyoKm1l9KSw8QKDANuHKvc3J64kkO5P6prNpmJ2hyD50uHZT/TSc9cIBCz73UVawiOi36ko9lzoAaGCSVtjKAdGJiVRhK/+LFCZ/rgSlqYSd8BCwgVsWfyAOsPHS7ykE0h1dNKQt7rnMnsRNi9bTr6c2qHc7i/xwUKK4OWKbIWqsDRcNHaAJwNpH6UCGFUmvyOcaqfw9W90/yOIldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYZPR06MB7074.apcprd06.prod.outlook.com (2603:1096:405:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 18:09:19 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 18:09:19 +0000
Message-ID: <04b2f0a1-3046-44c4-ada7-660273230748@linumiz.com>
Date: Tue, 7 Jul 2026 20:09:13 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Christoph.Seitz@infineon.com" <Christoph.Seitz@infineon.com>
Subject: Re: [PATCH v3 82/91] tests/tcg/tricore: system tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-83-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20260706223343.988769-83-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::7) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYZPR06MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: beb8e7bc-170a-46c1-ed4e-08dedc52dd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|7416014|1800799024|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9cA84jtT3u9XegDwja/+b0gm6pZ42b5SGSh0PxhmiaseeFeabgWVfW6wrPev1fCaFY0iTwaz6IswyPhWPrFZmWS+J3N/vm53gFiIqnnCCuyXmft3HMtafX31BB9A/aXzyl3rttb54YaRvgKhYp83oHo6UEW6KRtHK+rwpLd+H4E9SpTxIBqSqA3W/4x2Ncb57xEHB1FMfCT4bSFdgjD+oD3VZMz3vqruv4CTfbCF3Xg0M2o4cFInDOIRwHyOiuAjmIQa32UbkSgkZqsNgpZZj7kM6cuZ3R0s5S2G1CPJR/NfC8FsTZcBafOfMNE2k+QmcLdX7YsqQSjsFsk5zZySC+Lp4y7AzLy+nevIRi/7u3qkgviEB9SiuwysHchLgnH2lX6elRJ2jLMY5J7Z9nTzrCIItMBvYDEK27svW8FS3TcnULtm0tCRb+SFqy2F8oL8R0XJUcKrgUXy6IJcpKBBRRJAdPk/LlnSfXi7CQlJ00GjFOzJlf2xwLhmB6nst7UJwAJTSDUVlbq+C7iZrv3B03Z/l34GHqRr08AQzmxUOqVrjj6LrBb5vvqrbGixgjwZJwzNFoT5Lp550cZg8k9LRhPfgLFcWIyxwZZUb9ZlNyl0YHfjMgNqK0CpPboWsjjQG+i1NZlEWVrknqr5UnBOes8WM7bs2+GDoBth6XPJX60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEw0ZS9KS2ppQzZ3MjcwSGlEWG9WRXFiQkZwOTFJVUtObXRTOEl0K3BSZW9w?=
 =?utf-8?B?SDcyNHdIWGpXZjRrV2Z2NjRUWGk2RW9jbXI4VENXY0pKdXdJVGo1OFFQWmp6?=
 =?utf-8?B?OUNmYXBzQjdHbkMrLyt4UWtsYndBSWV5eFI1VE5zWlh3b1I1OEVUUmY5SFgy?=
 =?utf-8?B?RTUwblZNb2tqWHhKMkZQc0srL3JrSG5RQUhZSUZHenFOeWEzZkJRRXowZy8x?=
 =?utf-8?B?Nzg3bjBJS0lmK0FjVGxTZTlMVW9nelYyNm1NN1VPOHRsdmRJcmZNK1Ria21t?=
 =?utf-8?B?b0RCeWpCWDNGa3pEMVdtNU9lZmp5bDY5Wmp1NFVlSUNRaWlTamhEUm5veE1S?=
 =?utf-8?B?UC9pNVF5QmZEY3ViZW9jR1hPdlJUMDA0Z092eEhHR0FoaU8wNVVPazhNWGlD?=
 =?utf-8?B?ai9vVmZyWE8xRkM0S0F1NGE5WFZ4Sk1jQmZOeXpqdXBrN0xqSCtnRExjc1hw?=
 =?utf-8?B?UDM4bGZCaTJBMUVQQ2s1YWJSanpoQXdNSGNqWmFHa1UxZ2pxU1ZyVDdaU2JC?=
 =?utf-8?B?WE5hNVRPa1VSMXBGcUozVnJTdERKZTRqMXRaQjZjc0hKdzJNVGg3b04xVG1O?=
 =?utf-8?B?TXF6N0svTXUvVHlMa2ZzVndhbXhUTHhpV2ZsVytqalltc0FScTBCOVVQVnZx?=
 =?utf-8?B?RlJzMDIvY2lpVmtFSURyaHpjL1Frcmd0RkdrMFRmeHRhS1VnNlVSUzQ3bmZQ?=
 =?utf-8?B?UGk2aitnenNBU0hla2FZYmF3dndlbFBOdEtXYkM5dWVpQkVyOE5aTnk4Tzh1?=
 =?utf-8?B?TmExNkRkMEhqTUhtZCsvRGNLZnlpR1FFSkZnUW1WQ3Q1Y0QxN3RaM0pKTUJD?=
 =?utf-8?B?aUJZaCs4Ulk0T2hWclFJb3pXdldSS3c1MjdibWFWQTJKSGpLcjV2Q0FpQ3hs?=
 =?utf-8?B?Unp3Tk1Fd292bVdadkE5TkM4RFFsM0NEUENWcWRmdkRLTExvaFRrQWNYVE9U?=
 =?utf-8?B?VmdReU5ZeGdaYmp2cXc3K0E1V0U1Ym02RW05UGdya3ZvRzJpRTB4bXBuNG1U?=
 =?utf-8?B?ZjhRUE9DcmU2aWp4TGVlZ1ozejFYQ05vUExZYTBnWjV2RUNBL0xIM0xUT0Fs?=
 =?utf-8?B?cmJ4YTBZcHdOTlU4ZnN6dzF0OXA0MUgvRWhRQi8ycFArMFhuTGtadkxPaktH?=
 =?utf-8?B?WW8reUx5YjVFbWxiM0JtK2cxYkdyZFpySUIxeXp3VW4vNmJvMmNxNFRGejdr?=
 =?utf-8?B?Slg3NVdpaXNWbE1POWZ3NEtlMyttUG5UMHBVM05GKzg1UzFsVUQwb2xBS3Fr?=
 =?utf-8?B?elhYTHlhSHZRNWgwNnJIYlZJd29oYVZlS1I3citjaWp0LzFZd2tqYXgyYzNS?=
 =?utf-8?B?eXpWbDRsT2czRWMrVjlVQ3FkNURNUkpzNzdxaTZYV0dVNjQ1eWZIRWJBMlRJ?=
 =?utf-8?B?ZDYvVjRvcm9vZERRR0tWRncxOHZkT1gzREQwaW5JV1ZrMmlYczN5dzVxdzZy?=
 =?utf-8?B?a01nc0Q0Y0pUd0FDZ3Z2RmJaR2hFREQybUIvVjI1T1daYXQ2TzlVY0NCQU51?=
 =?utf-8?B?NGFvTUFoQU95K2FoTUJiMVRNNENaOUJPSnZLNkhmTGYvMmgzMzVhUFJsTDhw?=
 =?utf-8?B?eDhTQWZjdWVmdWtOOVU1cnBURCs4bzdYNFRqampwNWNVZ3FLMHRYOEhuN0tQ?=
 =?utf-8?B?c2JabWwzWit5elpxNjMrUGpLb3kwcEtpem43cVFQK1IzNTIrdmJzbTJILytr?=
 =?utf-8?B?QkhVdE9ZeEVDZUVZSko3eDAyWkJjL0JtbjBLa1kwcytFTm5OYUVGYW5PODlr?=
 =?utf-8?B?VU9pbnVSTHhySEYrZDJHMitLNXFhYUwzNmRRYUUvUytwYnVKVlhjSU9zLzNP?=
 =?utf-8?B?eGhKN2NaRHdnQnBPTGh0THpCTXovRzZweDhRL2czdVVkbitaT1Fmck1iMURi?=
 =?utf-8?B?VHJGeTh5TXRKYlRCSzkydHJUTUtBa1o2bUZEZFEzSU9yelBjTXJiSTVIYVFP?=
 =?utf-8?B?RkRqcm5HMngwYkI3M1JXbnltSkR0YUM3MnlFK1g1YWNFbGNaUWVMU1ZocTRS?=
 =?utf-8?B?UmNzNm8raUNKQ3V6eTZwOG9mdTJFWllZM25lVWRzR1RHMUZQbkxPaWR5MHR6?=
 =?utf-8?B?M2VUR0VETlRodTg3dUVKRnlZMUVvcXVzSWY4Nno2M3lKb21lZEFIcm5pb3V6?=
 =?utf-8?B?SENuQWk0cDZhRGkvS0pveTY3SHFWbXRmdk5ia2pSUFc2cXRkR21XZ3JSaFk1?=
 =?utf-8?B?eHIvWHAweTdKK21vNUl1SldUVVE0ZGtZcGU2cjVTcTFTNkplcnJEUWY4aXZM?=
 =?utf-8?B?eEFqOWw0OFN2QUJCQUFFNHRxVkFQRkFHVHM3M1g2N0E1NzRsQWNKNnI4bnFn?=
 =?utf-8?B?M044UHNvb3JwYzQ3RzZqNmFYNkk5M2dJWmMwcFN6OVRyUGEwQWVLUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb8e7bc-170a-46c1-ed4e-08dedc52dd21
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:09:18.9710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj/uYrbfZILgd2s/m6v9MZordi3ctYwNO9xJabG4i1IGN+5x64Y4aKMQvgu2/qGSz7PEVF5mtLhHKhxSQ7xCOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7074
Received-SPF: pass client-ip=40.107.75.109; envelope-from=parthiban@linumiz.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 7/7/26 12:33 AM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build         |  1 +
>  tests/tcg/tricore/meson.build | 56 +++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 tests/tcg/tricore/meson.build
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 59e71d82c99..b2630176b7f 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -152,6 +152,7 @@ subdir('ppc64le')
>  subdir('riscv64')
>  subdir('s390x')
>  subdir('sh4')
> +subdir('tricore')
>  
>  image_targets = {}
>  exe_targets = []
> diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
> new file mode 100644
> index 00000000000..6303d6a912c
> --- /dev/null
> +++ b/tests/tcg/tricore/meson.build
> @@ -0,0 +1,56 @@
> +tests = []
> +
> +link_script = files('link.ld')[0]
> +crt0 = files('c'/'crt0-tc2x.S')
> +asmflags = ['-Wl,--mcpu=tc162',
> +            '-Wl,-T', link_script,
> +            '-mtc162',
> +            '-nostartfiles']
> +cflags = [asmflags, crt0]
> +qemu_args = ['-display', 'none',
> +             '-M', 'tricore_testboard',
> +             '-cpu', 'tc37x']

-             '-cpu', 'tc37x']
+             '-cpu', 'tc37x',
+             '-kernel']

This should fix the TriCore timeout issue.

qemu_args is missing a trailing -kernel. bare positional argument and kernel
is never loaded. PC unset.

Thanks,
Parthiban
> +
> +# Multi arch tests are not supported
> +# tests += tcg_tests['multiarch-softmmu']['tests']
> +
> +setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
> +setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
> +
> +tests += {
> +  'asm/test_abs.S': setup_asm,
> +  'asm/test_bmerge.S': setup_asm,
> +  'asm/test_clz.S': setup_asm,
> +  'asm/test_crcn.S': setup_asm,
> +  'asm/test_dextr.S': setup_asm,
> +  'asm/test_dvstep.S': setup_asm,
> +  'asm/test_fadd.S': setup_asm,
> +  'asm/test_fmul.S': setup_asm,
> +  'asm/test_ftohp.S': setup_asm,
> +  'asm/test_ftoi.S': setup_asm,
> +  'asm/test_ftou.S': setup_asm,
> +  'asm/test_hptof.S': setup_asm,
> +  'asm/test_imask.S': setup_asm,
> +  'asm/test_insert.S': setup_asm,
> +  'asm/test_ld_bu.S': setup_asm,
> +  'asm/test_ld_h.S': setup_asm,
> +  'asm/test_madd.S': setup_asm,
> +  'asm/test_msub.S': setup_asm,
> +  'asm/test_muls.S': setup_asm,
> +  'c/test_boot_to_main.c': setup_c,
> +  'c/test_context_save_areas.c': setup_c,
> +}
> +
> +if 'qemu-system-tricore' in emulators
> +  tcg_tests += {
> +    'tricore-softmmu': {
> +      'cc': 'tricore-gcc',
> +      'cc_dockerfile': 'debian-tricore-cross',
> +      'cc_docker_arch': ['x86_64'],
> +      'folder': 'tricore',
> +      'gdb_arch': 'tricore',
> +      'qemu': emulators['qemu-system-tricore'],
> +      'tests': tests,
> +    }
> +  }
> +endif


