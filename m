Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D7E6B242
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 10:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ors-0000I6-HU; Fri, 01 Nov 2024 06:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t6orn-0000Hk-R3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 06:26:56 -0400
Received: from mail-sy4aus01olkn2063.outbound.protection.outlook.com
 ([40.92.62.63] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t6orj-0007WG-9t
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 06:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBysYCf+kk8CCGqytbeQd4BCSalnh78znWl0fT8GDBo96cFgDnBmbLzJd/v21jXEv/WxYvzOQVbj5rJriDaGfgrF1YSDmX+BlepuQYkGMGmDZc1NMcqnFPpT6WOSnnQ8uIZHfI4Sktgqj1rF+G+ha7n4p4UrERxFiQ19vT08sZqn732BPRUVYsn+hTPhxGMjf8/xE7vWVMJOztUYGwzhzJo3QZJEOxirfkYPqOTHJb7MhR342E34EsQZM59Qmupv4UK+nx4X8eMiRNG7851S29Npm+YbhWxa7YvNbPWPQuXT5YvSkahYYb29qjncq+wsEHM6WPfaUeHiNZ2kRRtvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSQdwDf2xIDqw42IInfywyKCKJ/hICDAsNw+nwfU0oE=;
 b=n6aKSqsip/9c6te64cPL9CWjsth4F4U52En9QUViMgCucsrtQAQ8OqJWRtIBak6vcxhCDk8B6jRzL7xzc7TcPpCrRrSqqC1QbdYbDc265ak3ZZtP7EJZhuVC2K7M4TRcDgdasJcGdnsYMc6oXG0mX94YRdZYwRYavONPBBUdC14+/udW3mnfe5YYWzpeODIuuP3M2Vy6ZKhdi4f8Aq+R3U7a9ReWjA+8aMwSPuMRNk3av1MJYrOym/owYBf+GM1wGt2eW9T1U/0a/9hUpMPQ09PfGHO92fPG0l5FkcygMFtA/XZjGrIDvm7PHIvBwIJ8wBMdKBz/srwNhk9t3TOzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSQdwDf2xIDqw42IInfywyKCKJ/hICDAsNw+nwfU0oE=;
 b=QITG7NwRgKxAVDW8ZLfTeYI6Gy0FF8c4n0IAEB24bLeW0QWlwvWFhHA8K5217gDB4KUbqYHTMIbMhjB2Rtu15HZc/rmIg86jHnHb9w757r+NVowq7qaMrUt6yzC4bU995KR9Fq7VrciDov6npjaoIOcaAz01JfIf0fky7IumeBiJ8BP/zEQ8uWV5XPdpI6ztpGdx6O4vx3kOHGb+NVSWmiH+BMBCrkvKrzV+1CuhpbkhPAlJ/4EkRc1g/Awvq/9+rmSBGWnCPuW+7QoxBLaIjzKX83lfYaxsY/AUsavxEyT6oCUox/REX9gBSnxRCGKVdyIWwcY7JOIZ/C6tWXPIYw==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY7P300MB0623.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Fri, 1 Nov
 2024 10:21:38 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 10:21:37 +0000
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-14-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, berrange@redhat.com
Subject: Re: [PATCH 13/23] rust: synchronize dependencies between
 subprojects and Cargo.lock
Date: Fri, 01 Nov 2024 18:14:25 +0800
In-reply-to: <20241025160209.194307-14-pbonzini@redhat.com>
Message-ID: <ME0P300MB1040C0B24C8ED1775CB0673795562@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87y123tftm.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY7P300MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: 30692496-926f-49cc-2c7e-08dcfa5ef794
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|461199028|8060799006|19110799003|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b0HJlVe61XJroh2ILlWE2gwelvpXpmNdWhhUe/irWOMp6+KaLK0QbMqe1xXH?=
 =?us-ascii?Q?T3iiJR8ebvoyEN4xQ4oYYxQEkJvGD2O7c0APDwUvUTnKSJ0L1MKemPLBcPpN?=
 =?us-ascii?Q?8pTZtTjplSfeG++jVbbYmy/wcnZA2IQvEZTW5CY6B5uiFxqzuy8kayCwx/YN?=
 =?us-ascii?Q?vb/Y/WYIWDOOIKRsEzPjet4mEugQU6+r07KcFtIssahsU747xSQlhbkuXQA5?=
 =?us-ascii?Q?19xnSxuv9R5l70mCudG2an65NcOrxQ8TLKteNAEtqNyUnkAXPtCkOT9uERLI?=
 =?us-ascii?Q?vjxeyvjeM+aYc5Q/zC3jgcNoxgXkEcJU8YKUKoUAcgCpwX8G16sFsZ03k/O7?=
 =?us-ascii?Q?blBpqR8TrnGx2ZJVtXWOcPmXAAv4tVyZtSjI+cBGPTRz+L3fpZyNNXnlUPaT?=
 =?us-ascii?Q?Lm3yGJI5Vde8Q8gbOqf+raWuPLFlCu53ArTOHCWzg/HyYd8V/zgBlBre6O4M?=
 =?us-ascii?Q?rWCe/cb4u26bUOBtO8UDziABdryV3aqiTK7P5kkK8gWjkzI93MAWpTOW0LWH?=
 =?us-ascii?Q?vlPYeW4SxlPgBVP3iz1oXa5NJsr3xxjzPxnrPZbifZ1tpWnjhEr4TWZ09DZK?=
 =?us-ascii?Q?4flrvVwUOMv59GK6hEUJIhnPhGe/gGwV7YnrLFr2ydrCsNKCAwZYUMgWWEqj?=
 =?us-ascii?Q?Izja0Mx/KgzdWkPxSIJP86ehF4I4fRCv2WPvSq8VmeheK698vs/vMvK6Mrks?=
 =?us-ascii?Q?E7VLGDyjNglL/UohDV4xeiJhPR4pde46VQJBpZ4bVp/xJdGHzVJBfcPrKdtK?=
 =?us-ascii?Q?DlvTuE6dVHIj+ZCDMCW5apy+C+fFuqjTi2FMINUGq2LD0Vp9FeJbDQXwICJI?=
 =?us-ascii?Q?9mokVW01h+jLpgulIjdgENoHkNT1rAx6IO70maeuvH11+AWA6j3cU87QGIxI?=
 =?us-ascii?Q?R2ahcotFf0gLhD2S97YWB6H2LGjXNuujsPpOiFdtRrN8rYSOKx8tPG7L2DKf?=
 =?us-ascii?Q?ndLVvUarbs8CCzmMSfy+mRgSKI55nhnOEjTrjV/KQWbrwm2xsCAv1V1uuvKU?=
 =?us-ascii?Q?kxZSo0XJMElLSkoNiIT6MLVBxdC7H6tjbz+oNPM5+d512Fs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VW1TYy6WdVuC7lPTEKdotFAL0NmnyFTKgueNJphKNoXNy/BPRQOlXuYv0LdX?=
 =?us-ascii?Q?ksOgh+igMD6/gWiQiW8nbJI9mCBFaPqksRcQJ/O2GqbWYCCNaYgbdaCNLnGl?=
 =?us-ascii?Q?+5RuXH9FuaPw4mVJZndEB2dnCEKVRDnshlqmBMexnl+4Go2ZLJy3CKxs3duw?=
 =?us-ascii?Q?cKyf1V8+Sg54bjBrQ0xOs17n+QtZXQE8zr2tLPz+QNm2qHEUIeICcLmFJMbp?=
 =?us-ascii?Q?6lZnoyA1ehblnRuPu0MtpFR7gf7f2BYSt8oQ1D9Pg8he2HXHdt+gBepcbhpR?=
 =?us-ascii?Q?w4DKy52U0fvDTwgKPKCRP+5JItn5T+t+Htg7G9lwS/V+uNZGzqjMLzOeWRnZ?=
 =?us-ascii?Q?IidYq5Tm7iBSw0bMEaQZiY5ccl9TU2lr5xC4q6iOXcANNbt0S7htMFdeVsGU?=
 =?us-ascii?Q?m6ulX1bOfWxWmYqgCRJ8wfF/i1r4FJSchFZVeUDp8wZdGAMzJVcyxlBDrZ82?=
 =?us-ascii?Q?t06q4HE/tiBJ5CNTmgr4/uu2L7n8dYHwr2JUfop2tzlriv+edT1K0e9o3JaS?=
 =?us-ascii?Q?5lWXB7d7jyxWnEpLRyzNNkeSxWpgDpXTpHrPEaphW+qE+yHVnrgaaZGVynZP?=
 =?us-ascii?Q?zmR8Qq2GFFn5zUJ8y7eB2GIG2WSulJ7s51guAWynSlWwQtKhOGjYgTUSqB9y?=
 =?us-ascii?Q?kL78Nr0EmJPBp9PgNQb4HDgU7wMAKMOkQ3A3/uHqRZZbPqCqMCUC+aChKIK4?=
 =?us-ascii?Q?pxqWKkU/CFB3Oqo7saAJRUGov734dGyuv7MwxYCNz0e6BhP6pl3/P2/dt0Mf?=
 =?us-ascii?Q?rUmLwbPlu/3bK6LCag0zPpK2716mr/JwsnDG7r2buPHNHSppYL9xPL1KNCHu?=
 =?us-ascii?Q?LdAufflwxK/O20WgPSkpnagsupR7HpqR5U4OzEGCqwrk/T3NYku8ZfZequD7?=
 =?us-ascii?Q?cbYSJb9CkrDbsNygz5Aaf7jTVICJVu4AhW1fKvZWBluENcwxhPiZepyAbG6e?=
 =?us-ascii?Q?vodonR2OtI+KYB4/C/B4c3ShK9fj2Cftj9TdgTYryzFGKh7+R6zzAO1Mr/Zv?=
 =?us-ascii?Q?y+MhNqZBmXbvJ8l7LGy7kt14Rs9dPfjpdr8qwXVO1KrUB+nmBnQd/wRwj2WE?=
 =?us-ascii?Q?lipdhWkOW+7kqqrCHUtGcpRS6F1CJaYuyQjGtOPgUgVeqcS5cLOhUUQ+Aa+3?=
 =?us-ascii?Q?9iYhSiU0/tIK0jjoQGgxw6IHJoWkl19kbRogzb5hRxXzfM1N/qHVL0cSLafY?=
 =?us-ascii?Q?89bxuDHoudoYjs8g6ffZvnfNNL1HOFHqjfk6dj6gs0QCZSg4XRFsJLBPG8o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 30692496-926f-49cc-2c7e-08dcfa5ef794
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:21:37.2285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0623
Received-SPF: pass client-ip=40.92.62.63; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> The next commit will introduce a new build.rs dependency for rust/qemu-api,
> version_check.  Before adding it, ensure that all dependencies are
> synchronized between the Meson- and cargo-based build systems.
>
> Note that it's not clear whether in the long term we'll use Cargo for
> anything; it seems that the three main uses (clippy, rustfmt, rustdoc)
> can all be invoked manually---either via glue code in QEMU, or by
> extending Meson to gain the relevant functionality.  However, for
> the time being we're stuck with Cargo so it should at least look at
> the same code as the rest of the build system.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/Cargo.lock   |  3 +++
>  rust/qemu-api-macros/Cargo.lock |  9 ++++---
>  rust/qemu-api/Cargo.lock        | 47 +++++++++++++++++++++++++++++++++
>  rust/qemu-api/Cargo.toml        |  1 +
>  4 files changed, 56 insertions(+), 4 deletions(-)
>
> diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
> index b58cebb186e..9f43b33e8b8 100644
> --- a/rust/hw/char/pl011/Cargo.lock
> +++ b/rust/hw/char/pl011/Cargo.lock
> @@ -91,6 +91,9 @@ dependencies = [
>  [[package]]
>  name = "qemu_api"
>  version = "0.1.0"
> +dependencies = [
> + "qemu_api_macros",
> +]
>
>  [[package]]
>  name = "qemu_api_macros"
> diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
> index fdc0fce116c..f989e25829f 100644
> --- a/rust/qemu-api-macros/Cargo.lock
> +++ b/rust/qemu-api-macros/Cargo.lock
> @@ -4,9 +4,9 @@ version = 3
>
>  [[package]]
>  name = "proc-macro2"
> -version = "1.0.86"
> +version = "1.0.84"

How about specifying also the exact version in Cargo.toml, e.g.:

--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -17,9 +17,9 @@ categories = []
 proc-macro = true

 [dependencies]
-proc-macro2 = "1"
-quote = "1"
-syn = { version = "2", features = ["extra-traits"] }
+proc-macro2 = "=1.0.84"
+quote = "=1.0.36"
+syn = { version = "=2.0.66", features = ["extra-traits"] }

 [lints]
 workspace = true

With that the versions of direct dependencies will be unchanged even
after a cargo generate-lockfile.

Unfortunately, versions of nested dependencies, such as either and
unicode-ident, may still have newer patch versions after a lockfile
regeneration. That can be worked around by turning nested dependencies
to direct ones with fixed version constraints, but looks quite ugly.

--
Best Regards
Junjie Mao

