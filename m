Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509C3C61DC6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsMe-0002Wo-JD; Fri, 28 Aug 2026 04:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzsMb-0002WI-RU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:55:06 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzsMY-0001oq-5j
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhyqPnUrvs6La2TeQdpLNtg0CbE6odeXxc6zkiS0eJGoVVx8e9m7OxPse8sepMNGo9vZMPJDiU8SkM8ye9mz1T2obiCjscWxz72xutEEMsLuCv/583fcnilcBeAVMfz4zxGtAhS3UGvb5v3azfTfymwYuTU/SiPFUMOEDFB5C+FGr/uM7udmZXq+oj4Fd766FEqE/3qKrsUvQrqTvsPZpz1xTUeQP9nb48LiALoKNB/mdaWE1lCho82BLqJwXteRbd2IX7mh56f1kfPzv11vGVGNdIP7m8SUhzc4ih034jBJPaYQAHX2UiTUQ7MlTiu49/NfiyfsZg5gFf2Dbf6d3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HyDj09YgPnuZFcJR0tUFypiPDu8Os9YOwReh2iHOMc=;
 b=P76xlsU8+sIlFRjbj2WQxsamA5Zao+ZUkqRn2QNEYTPXVdSxwJy/Atj/LS/RiCA2x0sdGQQiBXPsBBkeH+oCzFEcUI43W/TNrIt88gBWvyG1VI2eeUWEHZ50nKOFzlnguhZUKVG5utcpHKsob7XVdCshjvu3NZppG9JLXdz+bJ9DKwkATPXsdT+fHbS9MFShjqT56svSpiHhmc0T+mMR2OJXwyEP+BkdEbuCReyTiW1L4VhZ8e4XeDVREjvtjY+VP5LfN3O7lnYNtAVsKZhI6kE2Dn+HsOrj1/GkdlHJCbVjUPZL3DqP+oIM56z5emKJQCWs4ruQ8T9n5FDx+t+7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HyDj09YgPnuZFcJR0tUFypiPDu8Os9YOwReh2iHOMc=;
 b=b/fX3zxCxYzOXS45XkMCAjwFjziYVuE1jsPYq8mXqSQ0EUWJYZGHPHrSpMoQ3m8N86xlSqbnVc0LuNp99h6ZfufDKno8bWz9ipThdUKADtFezbWM/v9g582qEMiYQ6ekCaOH2JSzBVyrQdDwkU+VlV5ams+7LFRfS/48A/7JncOtTvELaKces7d3HTpnlKI96jQ+BCY9vqjnzOq7ckZiP4klw5wDAz71IP1CJa8BcAxD4pGLH3CM+DDgJ2zDtof2Ewmn94gxod5KXJk0YJbNPHPasw43/8CAYGc+WAixzP3wlWE2JrxGhBRSeKMnLwSIThgk5msxzHZsF0ERou2xqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6168.apcprd02.prod.outlook.com (2603:1096:820:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:54:55 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:54:54 +0000
Date: Fri, 28 Aug 2026 16:54:47 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-level <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: Re: [RFC] single-binary: merge experimental qemu-system before
 filtering
Message-ID: <apFIRPwekx4tmAi9@ChaodeMacBook-Pro.local>
References: <CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com>
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8620d3-0047-4360-b5b5-08df04e2077a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|18002099003|22082099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: tJpzHuwLmI4ezYPWs1ysD7cdJiMYS3Q/oD/DPX3kYA8RQRfr5GDQOt+eqijbFw92+V+Z0qbGWhhHTBmXR+Fp649HGiUWQVYa/0+1AO1BSQg5moZ3CiXbzpn7ORl4J6UGl4+Jji53bmYRvTp0vZUeF1xCJZSHexoo1G+KdHZ75UhR2Ns9Xobs/MolMiuwt533UJPbiAbgHlMP5opkICYRf0AgKtdsLwJR5r7wMCbHFiwflw7crvGUq/XkttE0navx4p/bwaHliqHcSDA5zJ316lEoa/pyIKJ1rwjxsbbTKyfN3ObvOSTnOHP674v6G0GaBMFWjrL7rArmINC9i73S4CRVPtNu6/c9HjM91Xk1sA4GjoMOeyrJWXoMuUSJGliLdxI5vdEc5wUxeToh89p3jRA2kcM0DKSxJrMkI5pv5ThHbgIEXC4khBHlXMo8xjU0ZjRWIwiIB3TTSgvtYIzEre92MPcuAkmaIFKmVAlGq2U/GPwS4xI57eHMZ2iRItIRuEcRRA0UzWNxZWz+l8y95Z6cq0jrWaw4wppfLFGxYZiKKPXRSUc6NJG61d5j8AEpfe7zIWTUue2bcbdR9v/a3yqP5/7ngmpYwN3v/wqMhG1jPzW6ljuLFajFjDOHBRmK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpma0ZDTVJFV1RibU5BN1BabFVWVW1kSjdBVEJMblVVdXBhV25jR3BQb1Za?=
 =?utf-8?B?RUpRWS9iQlFPSTdnSWVGb2Rtb1Jxb25mUHZzWGRaSTZaR04vYjRlMSt5Yzhu?=
 =?utf-8?B?Wk1UaXprWGdMbGl6VGs2UklGRDk4N0pWUlRSbG80L05KTDBVc3RHV2I3TjRq?=
 =?utf-8?B?cnRoZU9xeVB1ZXdsRnJFVU1YOVhNZk1VZTZQSUhGYmFISThsMDVEWFdaTFJK?=
 =?utf-8?B?TWkzNTlkSGNpd2pBNk44dzdlSCtNVVhCdUdvRTNEcjJ2a0tKaDJqUE1GbTJR?=
 =?utf-8?B?M2doZm04Zlo2MHRZcGpoZHR4ODh2MEJOU0d4OFdQYWJKVkt6dGFTdnRaMlRZ?=
 =?utf-8?B?ZHE2MlQrc2lmeFBrYWNDbXlqcGNWN3BvY2s4cHdQV2ErVnJnMEJTMGoxOVlr?=
 =?utf-8?B?SElDalJnQWZ2dllHVEg0OU9kUVR6V0Y2MUxvcWFnMkxqUFowbFA0VXVuUzZj?=
 =?utf-8?B?Tk1tV0NJRTN5aytERTY5T1BoeExUbTQwSTN2NlFabFIwck9jY3EyMGlpQ2hx?=
 =?utf-8?B?aWMxV3g0ZnR0YmUwZit0WTVvci9yQnVOUThqZlY0d2RTTDZYNldvV2c3Wmoz?=
 =?utf-8?B?Q3ZGeDhoN2twN0lrSjJBV3BqSXBueUlsMkdCUUdFMEtwL21CM3lWLzlOUXYw?=
 =?utf-8?B?dnRNTmJrNjRZaW9wZzM1T000OVVVdC96ZmpDREFKY0hEUzUrT2NWUks0NHAw?=
 =?utf-8?B?Zk8zMmF3QUtjQ21tb01SZDNTSU9LN3Vad3E5ckFmTE16ZGttUmNGYnBnNXBa?=
 =?utf-8?B?YVdRYng5OG1SZmJDSzdIRnBkSkRiQXpyakduQUhaWG03QVdIMTBUc0JzNkRm?=
 =?utf-8?B?RTFNOGtSZW9XbFpnQndkNlVSUHhCb3UvaVpJL05icEJZWkVWaGZubjk5NXFk?=
 =?utf-8?B?VVJCbFp6aU5MbEM1V3lvWTZrUkxMMnpzVFJpSlZGMkZCYTVBeHAzYXA0a0FF?=
 =?utf-8?B?N0lCMDcwNnJsQ2RQWkl3YmJCaGF4ZlAxKzlKb2xuLzlkZXZ1Tk00U1pnd0Ez?=
 =?utf-8?B?ekY3NzFoMHdodkYrRTREOTVkN2lRWlJIeW1abkpabkRnelFuQ3lnbE9GcU9Y?=
 =?utf-8?B?bGltYlNURS92cnJXclNBSFhoTHB0anhiN1lkNVFyUE5UMktMNW5FT3V0cjlr?=
 =?utf-8?B?TFlsREljbHV0STlEcXFqYU82RnYzdEJYcnp1RllqT1N5TlJmTFRleHR1RXRV?=
 =?utf-8?B?V0hCWERDckRCL2gxZm1Ya240TG15V1lGd3BBL2VuK0M2NUJxWVFURTFuVHNo?=
 =?utf-8?B?QkFzK2RnNFRkc0JhZkt6OUVtTSswdUo4YTdhcXZGRHRPbHlDTDFuMUlTeUE2?=
 =?utf-8?B?NGE0N1RZZk1nelJPc0V1MVdHbThqYXdTUk1mc1pOdkRKNmdGYXlQbEd6TVRP?=
 =?utf-8?B?WHMyemlMLzViMys0Z21UeEtqMGpibG9DSEdMNi9veUNlWE52NTlqam5rNWtG?=
 =?utf-8?B?RU9scnRhdUxPNldvbElhNkxKWUhoK3NPNmxtZjZmTmpvMFI1MlE5UlZsRzUr?=
 =?utf-8?B?ejgwQzlzM25GUFhvRmtRSWhnMTJWUWRocDcxSUZPWHJYdzQwV0UxY3NJSzQv?=
 =?utf-8?B?NGNYWTVtdmN1VDFvSzFZVXNNb0h1QXpqTkVVWVFTb08zOTB0c2FwTTRjeWJY?=
 =?utf-8?B?aW45MUpoSDFxbFhvNUYzVjhENkNieVpuS1g2SHk5Nmd3Wks1eEV1cXBjVThP?=
 =?utf-8?B?YUk1MU4zeHlxVU1VcHZsZ3puR2Q1K1RTTVplTEh5RXVmZ25Jb0s0dW9YWG5C?=
 =?utf-8?B?ZTd3ampNdlNSU2JOejJLT2ZrUE5xZUhFOEkvNFp5azI2TVNzUFNHVFB0Uk9Q?=
 =?utf-8?B?bFhIc3N4SXUwOXROWk5vNlNMQlROeVZFVVRwZnJ4K2IremJuSXk3UHNTRW1w?=
 =?utf-8?B?Nm94b2hrNlBPb1F4akRUdkpGWEwyc0Z0TkhGenNEZ0VudFJaemRhazY2QzB2?=
 =?utf-8?B?dzB4bTZIQngrdmplWWR3Yis5U1g2S1k2MWNTZFgva2s2Nnlxa1lUOEE2Q0p6?=
 =?utf-8?B?TVRSMnROMUxXaXE2VlRzeTFwOXVWSllXLytsbktZZklKSTlaNFNmZTFHTTJL?=
 =?utf-8?B?THZ3SmZmUkVvNzdJekppNDFIbE5UL0FwZVVlYkl2ZkYvUWxTandyOW1EU3dI?=
 =?utf-8?B?SFV3alBhNkVkRUFEM050T2dCandMU3VHUGpZSGtJb2dteFQ5bElwMXVIdW4v?=
 =?utf-8?B?VWhEbmhWWVhnMHNWTkw1UTBQL0lKMlZEcTl2Rkg2Sm1Xd0FCSVU2RVJUMlR4?=
 =?utf-8?B?SVgrV1AzNDNIQXhQSTJ5Z2dmYTdhYmYwS2ZOZ2xxRmFnNXZkWEUxL2ZEZm9D?=
 =?utf-8?B?MmF0L3lCRk5VcDRFM1NsckQyTGZLdnVONWdPMnErMHVCdjRwdlNMVDlLQnhq?=
 =?utf-8?Q?owwv0ZXdBdCWoy4k=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8620d3-0047-4360-b5b5-08df04e2077a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:54:54.7026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTCG0w65fF28TzQJ2SNGmeYx4oNyWeqI03C3W4x8NDPJTrN7H+qM7kKOQ6qNLU+0VRltaprZe0gy8SmcylMnv8wXBKwMO07qnPIRVpwpTBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6168
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 28, 2026 at 03:44:43PM +0800, Yonggang Luo wrote:
> Hi,
> 
> This is a design RFC, not a patch series. It follows review of
> 
>   [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
>   https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/
> 
>   [PATCH v2 00/13] single-binary: link ARM and RISC-V into qemu-system
>   https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/
> 
> and Daniel P. Berrange's measurements of that v1.
> 
> What v2 already did
> ===================
> 
> v2 of that series already takes the v1 review that got maintainer
> support:
> 
> - Keep real qemu-system-$TARGET (and $TARGETw on Windows). v1
>   installed per-arch names as symlinks to qemu-system; v2 does
>   not. qemu-system is an extra binary from the ARM+RISC-V union,
>   behind a meson option.
> - argv[0] still selects the target for qemu-system-aarch64.
> - Drop v1 little- and big-endian TargetInfo variants
>   (target-info-<name>-le/be, -target aarch64-le). One TargetInfo
>   per target_name. Endian variants are later work.
> - -target ? lists target_name only. Unknown names point at
>   -target ? rather than printing the list and exit(1).
> - Do not build qemu-systemw for the combined binary, so Windows
>   data exports (qdev_prop_array / qdev_prop_*) do not block
>   enabling modules later.
> - TargetCpuOps (b444b4fb) for QMP CPU queries, dump, and ARM/RISC-V
>   semihosting, still as one process-wide table filtered at
>   register time. This RFC revises that into a map.
> 
> v2 still required -target on bare qemu-system, still used
> TYPE_TARGET_SPECIFIC on the combined binary, and did not mark
> qemu-system experimental. Those are what this RFC asks to freeze
> before posting the next series: extra binary stays, filtering is
> not a gate, proposal A vs B. Heterogeneous (no target: on -M)
> stays an error until later.
> 
> Why this RFC now
> ================
> 
> We are very close to a linked qemu-system that contains more than
> one target (ARM + RISC-V; see v2 above). v2 already dropped the
> symlink. The remaining delay is not "can it link", it is unresolved
> product questions: -target vs -M only, complete filtering before
> the first binary exists, experimental union vs looking like
> $TARGET.
> 
> This RFC is to freeze those questions so the next series can land
> an experimental qemu-system quickly, instead of another patch bomb
> that still debates the end result. Filtering, heterogeneous
> machines, modules for RSS, and CLI polish can follow against a
> real binary. Please comment on the split and on proposal A vs B;
> that is what unblocks the merge.
> 
> Thesis
> ======
> 
> Land an extra, experimental qemu-system first, without completing
> target/device filtering. Use that binary as the test vehicle for
> filtering. Keep today's qemu-system-$TARGET as real binaries, not
> symlinks.
> 
> qemu.git has no combined qemu-system today. Filtering, uniquify,
> and CPU-op dispatch are therefore untested assumptions. Completing
> TYPE_TARGET_SPECIFIC against qemu-system-riscv64 (a single-target
> link) does not prove the union case. We need a real qemu-system in
> the tree before filtering can be designed against measured
> behavior.
> 
> Berrange compared a v1 qemu-system-riscv64 *symlink* to today's
> standalone binary:
> 
> - qom-list-types went from about 770 classes to about 1530 (ARM
>   types leak into RISC-V)
> - -device help grew
> - RSS for -nodefaults -display none -M none went from 17.3 MB to
>   20.7 MB
> - A full-union guess was much worse for RISC-V
> 
> That is a packaging blocker if $TARGET becomes a symlink. Extra RAM
> on a *new* experimental qemu-system is acceptable if we document
> that this binary exposes the union. It is also not the last word
> on RSS.
> 
> Once modules are always enabled for qemu-system, unused machines
> and devices can live in .so / .dll / .dylib and stay out of the
> startup working set. One simple shape is one module per target, so
> qemu-system -M arm:virt (or -target aarch64) loads the ARM module
> and does not map RISC-V boards. That is later work, not a blocker
> for the first extra binary (Mark Cave-Ayland already suggested
> mandatory modules for qemu-system; Berrange did not want to block
> on that). The first merge still links the union into one
> executable so we have something to test.
> 
> This split is meant to take both review positions at the layer they
> apply to:
> 
> - Berrange / Paolo: do not replace qemu-system-$TARGET with a
>   symlink. A new qemu-system can be its own thing.
> - Pierrick: select TargetInfo when the user wants a single-target
>   view; TYPE_TARGET_SPECIFIC as the filtering mechanism. Matching
>   $TARGET introspection is the *goal* of a later filtering series,
>   not a gate on the first link.
> 
> Two CLI proposals for how to select one TargetInfo are below.
> They share argv[0] and -M target:machine. They differ on whether
> -target exists. A run with no selected TargetInfo (heterogeneous /
> SYS_EMU_TARGET_HETEROGENEOUS) is deferred: the first series only
> prints an error.
> 
> experimental-qemu-system
> ========================
> 
> Keep building real qemu-system-$TARGET as today (and $TARGETw on
> Windows). Add qemu-system alongside them, from the union of ARM and
> RISC-V for the first pair, behind a meson option, marked
> experimental.
> 
> Do not install per-arch names as symlinks to qemu-system. Distro
> packaging of qemu-system-riscv64 stays on the old RSS and QOM list.
> 
> The combined binary is documented as exposing everything that was
> linked. Incomplete device filtering is an accepted experimental
> defect, not a release blocker for this first binary. -M help /
> -device help with no selected TargetInfo may still list the union.
> Starting a machine that way is not supported yet (error; see
> below).
> 
> Binding TargetInfo
> ==================
> 
> A combined process has more than one TargetInfo (target_name, page
> bits, long width, CPU_RESOLVING_TYPE, endianness).
> 
> In this mail, single-target means the process has one selected
> TargetInfo / SysEmuTarget, like qemu-system-$TARGET today.
> Heterogeneous would mean it does not (SYS_EMU_TARGET_HETEROGENEOUS).
> That mode is not implemented yet.
> 
> Single-target runs still pick one TargetInfo before the chosen
> machine and accelerators initialize.
> 
> Shared in both proposals:
> 
> - argv[0]: qemu-system-aarch64 infers aarch64. Existing $TARGET
>   command lines stay valid. Single-target. -M virt works as today.
> - -M arm:virt on bare qemu-system: single-target. The target:
>   prefix selects TargetInfo arm and machine virt together. The
>   token is target_name (arm, aarch64, riscv32, riscv64).
>   Properties stay after the machine name:
>   -M aarch64:virt,gic-version=3.
> - Bare qemu-system and -M has no target: prefix: not supported
>   yet. Fail with an error that this would be a heterogeneous
>   machine (SYS_EMU_TARGET_HETEROGENEOUS), which is deferred, and
>   point at -M arm:virt and (proposal A) -target. Do not start
>   the VM. -M help / -device help with no selected TargetInfo may
>   still list the union so users can pick a qualified name.
> 
> If argv[0] and a target: prefix are both given, they must match.
> Unknown prefix names fail. -M help may also print qualified names
> (arm:virt, riscv64:virt) so users can opt into a single-target run.
> 
> Proposal A: -target plus -M target:machine
> ------------------------------------------
> 
> Pierrick suggested -target. Keep it as an optional way to select
> TargetInfo on the combined binary. It is not mandatory on
> qemu-system.
> 
> - -target aarch64: single-target. Later filtering can make this
>   look like qemu-system-aarch64. -M virt works as today.
> - If both -target and a target: prefix are given, they must match.
>   Unknown -target names fail and point at -target ?.
> 
>   qemu-system -M help
>   qemu-system -M virt              # error: heterogeneous not supported
>   qemu-system -M arm:virt ...
>   qemu-system -target aarch64 -M virt ...
>   qemu-system-riscv64 -M virt ...
> 
> Proposal B: target only in -M or argv[0] (alternative)
> -----------------------------------------------------
> 
> Do not add -target. The target is always embedded in the machine
> argument, or inferred from argv[0].
> 
> - qemu-system-aarch64 -M virt: single-target from argv[0].
> - qemu-system -M arm:virt: single-target from -M.
> - qemu-system -M virt: error (heterogeneous not supported yet).
> 
> There is no global option that selects TargetInfo before -M.
> Early option parsing still has to read -M (and argv[0]) before
> machines initialize, the same as proposal A reads -target.
> 
>   qemu-system -M help
>   qemu-system -M virt              # error: heterogeneous not supported
>   qemu-system -M arm:virt ...
>   qemu-system -M aarch64:virt,gic-version=3 ...
>   qemu-system-riscv64 -M virt ...

> 
> Compared with A: one place to write the target on the combined
> binary (-M), no new flag, no -target vs -M mismatch cases. The
> cost is that qemu-system -M virt is never a hidden alias for
> aarch64; colliding names must be qualified, and a single-target
> view of the union binary is qemu-system -M aarch64:virt, not
> qemu-system -target aarch64 -M virt.
> 
> Please pick A or B; the rest of this RFC is the same either way.
> 
I think Proposal B is clearer and easier to merge upstream. It does
not add another option, and the <target>: prefix in -M can select
the right TargetInfo.

We only need to check that -M <target>:<machine-name> is valid.
We do not need to rename existing machine names: parse the prefix
first, then keep the existing -M parser for the rest.

Another point to discuss is what should happen when -M is missing.
For the bare qemu-system, it should exit with an error instead
of choosing a default machine, because the target is unclear.

BTW, I haven't looked closely at the earlier patch series,
so I'm not sure how much this would affect the follow-up work.

Just my two cents.

Thanks,
Chao
> SYS_EMU_TARGET_HETEROGENEOUS (deferred)
> --------------------------------------
> 
> QAPI SysEmuTarget today is the configure list (aarch64, arm,
> riscv64, ...). A later process with no selected TargetInfo and no
> target: on -M would need a value that is not a single linked
> target: add heterogeneous (C name SYS_EMU_TARGET_HETEROGENEOUS).
> It would be a process mode, not a ./configure target and not
> qemu-system-heterogeneous.
> 
> The first series does not add that enum and does not run that
> mode. qemu-system -M virt with no argv[0] target and no -target
> fails with an error: heterogeneous machines are not supported
> yet; use -M arm:virt (and -target in proposal A). How such a
> machine would name per-CPU / per-device targets is later work.
> 
> target-info-def.c
> =================
> 
> The minimum compile unit for several targets in one process is
> target-info-def.c built once per target (COMPILING_PER_TARGET).
> Each translation unit registers one TargetInfo and a
> TYPE_TARGET_INFO QOM class. meson already does that for
> qemu-system-$TARGET. Combined qemu-system extracts those objects
> from every participating target, plus arch objects from a primary
> per base architecture (aarch64 and riscv64 for the first pair).
> 
> That is enough to have several TargetInfo values. Selecting one
> TargetInfo (-M arm:virt, argv[0], and -target in proposal A) picks
> one value for the run. With none of those, the first series errors
> out; it does not invent SYS_EMU_TARGET_HETEROGENEOUS. That is not
> enough to look like a single-target binary. That is the point of
> the first merge.
> 
> TYPE_TARGET_SPECIFIC
> ====================
> 
> Pierrick's series "single-binary: implement dynamic filtering for
> machine types" is a prerequisite and is already upstream. For a
> usable combined binary we need it at least for machines: without
> is_available(), -M virt in a union link is ambiguous or can start
> the wrong board against the selected TargetInfo.
> 
> Help and introspection depend on whether TargetInfo is already
> selected:
> 
> - No selected TargetInfo and no target: on -M: -M help /
>   -device help may list the union (qualified names). Starting a
>   machine is an error (heterogeneous not supported yet).
> - Selected TargetInfo (argv[0], -M arm:virt, or -target in
>   proposal A): filter with is_available() as today. -M virt is
>   unambiguous once TargetInfo is selected.
> 
> We do not need to finish filtering every QOM class before the first
> qemu-system exists. Machine-level TYPE_TARGET_SPECIFIC (already
> wired for ARM and RISC-V boards) is enough to select a board after
> TargetInfo is selected. Device and class leakage with -target is what
> Berrange measured; on experimental qemu-system that is accepted
> until filtering-against-qemu-system. Without a selected TargetInfo
> and without a target: prefix on -M, do not run; error.
> 
> New TYPE_TARGET_SPECIFIC annotations in the first series should be
> limited to what the combined link needs. Not a campaign to tag
> every class.
> 
> TargetCpuOps must be a map
> ==========================
> 
> A combined link cannot keep one global C symbol per architecture
> for query-cpu-definitions, dump notes, or Angel semihosting.
> Commit b444b4fb6ecb ("target-info: dispatch CPU QMP, dump, and
> arm/riscv semihosting") moved those handlers onto TargetCpuOps and
> TARGET_INFO_CPU_OP (one member at a time, type_init). That
> direction is required.
> 
> The implementation is not complete. It uses a single process-wide
> 
>   static TargetCpuOps target_cpu_ops;
> 
> and target_info_register_cpu_op() stores a member only when
> cpu_type matches the already selected TargetInfo. Other
> architectures are dropped. That depends on MODULE_INIT_QOM running
> after target_info_qom_set_target(). It is the same class of
> assumption we cannot test until a combined binary exists, and it
> is the wrong shape even for qemu-system-*: one global filled or
> ignored by init order, instead of a table keyed by the selected
> target.
> 
> Proposal: keep TARGET_INFO_CPU_OP. Replace the single global with
> a map from the selected target to its TargetCpuOps. Lookup uses
> target_arch() (SysEmuTarget):
> 
>   target_info_cpu_ops() -> &map[target_arch()]
> 
> Registration always fills that architecture's slot. It does not
> compare against the currently selected TargetInfo and drop the
> rest.
> 
> qemu-system-aarch64 has one occupied slot. qemu-system has one
> slot per linked target. Same API, same callers in hw/core and
> semihosting. Help paths with no selected TargetInfo
> (qemu-system -M help) list the union and must not dispatch CPU
> QMP / dump / semihosting through a single-arch ops table. A VM
> start still needs argv[0], -M arm:virt, or -target (proposal A).
> There is no map[SYS_EMU_TARGET_HETEROGENEOUS] until that mode
> exists.
> 
> CPU_RESOLVING_TYPE is not a unique map key. TYPE_ARM_CPU is shared
> by arm and aarch64, TYPE_RISCV_CPU by riscv32 and riscv64,
> TYPE_X86_CPU by i386 and x86_64. Those siblings share one object
> file in the combined link (the primary softmmu target).
> Registration fills the compiling TARGET_ARCH, then aliases the
> same TargetCpuOps to other SysEmuTarget values whose
> TargetInfo.cpu_type matches. Lookup is still map[target_arch()].
> 
> What the first series is not
> ============================
> 
> - Completing Kconfig / target / device filtering
> - Implementing a heterogeneous machine. First series: error only.
>   SYS_EMU_TARGET_HETEROGENEOUS and how it names per-CPU /
>   per-device targets come later.
> - Mandatory modules / splitting machines and devices (or a whole
>   target) into .so / .dll / .dylib. That is the RSS follow-up
>   once qemu-system exists, not a gate on linking it.
> - A new experimental CLI (-nodefaults default, no default machine,
>   dropping -hda / -drive, ordered args)
> - Replacing qemu-system-$TARGET with a symlink
> 
> Symbol uniquify (QOM names, helpers, TYPE_ACCEL_CPU) remains
> necessary to *link*. That is engineering, not a change in user
> semantics.
> 
> filtering-against-qemu-system
> =============================
> 
> Once qemu-system exists in the tree, filtering can be implemented
> and tested for real:
> 
>   qemu-system -M riscv64:virt ...
>   qemu-system -target riscv64 ...   # proposal A only
>   qemu-system-riscv64 ...
> 
> That is the series that should drive qom-list-types, -device help,
> and RSS toward the single-target numbers Berrange measured, for
> the single-target path. Modules (always on for qemu-system, unused
> targets not mapped) are the other RSS tool, after the binary
> exists. Distros keep shipping qemu-system-$TARGET until they opt
> into the combined binary.
> 
> The no-selected-TargetInfo path is an error until heterogeneous
> support exists. Filtering must not make qemu-system -M help hide
> other arches.
> 
> Please comment on this split, and on proposal A vs B. We are
> close enough that a decision here is what lets the next series
> land experimental qemu-system instead of waiting on filtering.
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

