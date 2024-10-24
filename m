Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33E7D0BB4F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 02:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3nTS-0007xE-Ih; Wed, 23 Oct 2024 22:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3nTN-0007wc-Eu
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:21:13 -0400
Received: from mail-sy4aus01olkn20816.outbound.protection.outlook.com
 ([2a01:111:f403:2819::816]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3nTL-0000yu-Hl
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:21:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A19juQnUJVOe+fXDSxeDaX70L2hba9FvCYNdD8pbNx2fDd8d4hUKIlKgaIMxkZzNH7Gxv1kNqXyTOBMxMmXmoXGn/sIRvHm3eedUAE3mK88jVVOvrhTb4rWyQE5HuyZ1udpBVW8EXu1KmVsGq9oWYZ1g5ZDuNxzDfPR4M5nnYx2rfHmT/i+KirmTHE7E5dj47PBCWg2p/obms92rdJhx9VtFbZ1Ynj+v0SXFC0Rx84VM3nrMCBHO39Ms/CyRJGLeFGxFyLHd1OTcLteR/1gdvnY43FoCN8URAOk5B8YlPf8CicGGtqDlKZNLj1pD0d4QgjeR9ljaryuoMbGvb5BafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkkf1rlF9ANv+u7PT1E2RQvgfUfIaDW//uMhJoUGuDo=;
 b=ybjlkjxYDbY4XGqbibHego6mJIlHvXkXDX76jpvKqTRm9+dnGoV9qT9hNgoDLA7r/X/2X3nQRSAn4/x2RcHa/Vd0lATZRHI3GuHGy3uxoZtN7FNV6MpKbKK8hPV5gcX+YS3jft9UgP6xh7NAlImxCoP1E/SlHv7I7m4HVsNaAdCIVUKWUNitSnpQoRNm6vaQZz6Q59OFTXFBk8aIvE8SYodpLACYoFvNqMdxgV4tOUvoQpafUWl8kMJNWuuhKm7nVcqKUeHhpAYhuKTSfi2HvGmu5OYstQq2vHpW7+DT7ye1gR8wBHBz+5qfi+7wCiRdXVWy2QNHaTMr+c8dXtP2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkkf1rlF9ANv+u7PT1E2RQvgfUfIaDW//uMhJoUGuDo=;
 b=NWw1PNRfrV+L1SNHNgvc0PGHvJ5kMFqJ2l5vU7z7JgPVr4EUhpYxSQu05mob3+G6qW0BjriBaWzQa7umZZ1QucLVC8I8ZHxyMBWkjvNtdeMy/SRbtTmAGPo1CDpdD/1fGK+AdDV1ZLB4PpxbeuDon6mUS+R8HMZDLePUNvyocZR1qkO0kTsZKhmYSQZ1i/pd7ltbA8mbxUpb1ThqbkBArrWC17GjJASiDrH0i+IFipwkZowTcDPtrVXl6TWB//FfnlVxriyfMlUcF7hwDfwtAdMAF7g8pNTMrK5lORz+bM24uF9hYq230h5KaFlNRq06ModAtI/bLTuAGG0qgBKo8Q==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB1375.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 02:21:04 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 02:21:04 +0000
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-2-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
 manos.pitsidianakis@linaro.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 01/14] rust: patch bilge-impl to allow compilation
 with 1.63.0
Date: Thu, 24 Oct 2024 10:12:28 +0800
In-reply-to: <20241022100956.196657-2-pbonzini@redhat.com>
Message-ID: <SY0P300MB102652AABC69A51603B447D0954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87wmhyi6m4.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB1375:EE_
X-MS-Office365-Filtering-Correlation-Id: 535333aa-3c99-40f6-6647-08dcf3d2828d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|7092599003|19110799003|15080799006|461199028|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: krWEEQmdhKIRh7XOlCRiFATfKoOJoh7zpI1kzVCfNPRLQJuYHIi4X85OFDSUPAqWdxDg/w6vX6x5j/VBAJmYBpB7FK7JTX4cMCMy5bsi1iHgbJVUM+eoKXPnz2xQWmorH7E7Le0TcoXi7UuaMvbuOD1pOVn+yN3YxymS4jyHNwSFKF6oHc3x1tfDezaUh3I6RIN0H8XJUpEJz2kM4+GitIHmouAqFWONtaltJEi8+SwN3B1g9hHDGTJREwCTDgysu9RgH33Xu9+WDoqiJi6q3zpE2br/81d8XgKYgB+GRYlqry+u44p8/4HPEejpLLr/7C4cS1f/Q2FhRaOjF/G/iuDeznydooX/I6weqHgfVyrTT7lkqX2HUiEuTzJLlP4Wf/ALuna8/UqYIkjTm8a5gmy/Bbf43gN1MRtttcs6oSJk6H0uJcZiUxzKfdtZY9ym6Ffq6hi6JJF5g5YXN2Uqv56s72oB6/D1cb1fnf3eMMZhNTekW6gtYNsANSMSktpCgrW6MJWJ1NKYD7ZoSjnsp9lD91Q8vMiKBbPdeZXA5qd34QxzshhMm/2imxbMFa8XuDktYjIiLhai6cY6c1DRnQ9ShkIEQyU/pCabCRwGsBmeAowqIY/NtRkbyAK4ZDCZdbpMJY5Eg5JyIhCJo0YEb8Vq6B+bfTOeeW9saQDiONG3mdhRejYa+gr+mziymrvtYmQCDkXYCVzN9yucS8Gs0yIAFph+ey70YnW4PWKZMFc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DD1oC72Kv26kiLZFFQx2YihYiA8jZWFct+1HR6yjoRRlPFpHH8HQy1JVupF?=
 =?us-ascii?Q?+O9xhEiwAjCaCxZkDoTcr2m/l0/leFy00JO1aiQhlECD0WVrzakxBDU6ySw4?=
 =?us-ascii?Q?a6FDW/gYYsGIpwgUxk1HbZce/EPv+bfzUdbfmzTBU1hyYqg75u6yLRTcDrMs?=
 =?us-ascii?Q?cUsmduk2pVpSDfUx/SU56HjlfpHAiIT/v3sX50jC2VZjilS5ajv4pFoJOwo5?=
 =?us-ascii?Q?hjJxG6hAb6d3MGb+LmNpDoUkeMHkpmzK15YsiXaXx1bAJ5kUlR4VCaVRUCTX?=
 =?us-ascii?Q?kSyaK3WZc4S27HS0rc6MisqH0c1Jdk+G9/MUSO06SlrVrDxqlVe0gmCZj3iV?=
 =?us-ascii?Q?OyCUWDqaRn1euSVb6WxTy3xV9snJvOJnASXfZ1B5CvzrqP8lkfw1VTIU+eRm?=
 =?us-ascii?Q?rNURn/l5jg0bUNjxm3FJITqt68Hupu9t+MmNIeLH4vtXi8OCRrOx2X0FNAnL?=
 =?us-ascii?Q?0220aIYRrJ6HO1vNYUbn2IeNkXcC13v6qWSxNBKMIXZgbUTjSguzxmkcmefq?=
 =?us-ascii?Q?e5ezZKQ0lR6xeWQmXxvdXevTYZ1ZFka/AyFrKTDOKk3bi9HWD4/hh7Hn7ZhT?=
 =?us-ascii?Q?5sDLrqQRdJ9QSzsPtvuqz5TGwcaq7/IEMToYTBofRYxZskcx1pme2Jbulpmc?=
 =?us-ascii?Q?n6jg7JV1GaisB39CtnFx/zmhE2ZSu4XfB8tJLrh/8iBv9tQE0IXo4U4ET6XQ?=
 =?us-ascii?Q?JG+4l0JhNLQoqSO3qaUBTfeunLeObsNjv1D1K2X6NzPddKLA7OH6izM0Og68?=
 =?us-ascii?Q?R18MRuRfMH41HmVNqzgeQs0kwq+xU02Ysw6n0kpojwm05szq5Nqxvtw/xCze?=
 =?us-ascii?Q?wppi/OMEQUs4S7CmSAGMPzY3mWyuPeFFzwgC6kSzPpQNdSyMHKL+lCRCyUKj?=
 =?us-ascii?Q?QIp5KhIszgH1OByj3BxFEtSD8Fhg+HPOKTI5xYjfDXnWJhDABk2M2TVlLpMJ?=
 =?us-ascii?Q?RO8TTGaHZ4sDEmUMv4JzDJ2Oc9niGO/ItjI7hMFjKOsa7at3ktt2b9aMH4I4?=
 =?us-ascii?Q?zL883/Oj4I5Qz9LeATyakI6yQ4HUvHA+025jnY4a4zOcOpYSoJGHNiYNHfi+?=
 =?us-ascii?Q?iLneSXOtbeHuyt7CSzBzE5TozsO7bPwrdP9DbJjmqCpAQkig6BQ7D+MfJUpq?=
 =?us-ascii?Q?Pv9PUqVNPXkjuDPwGviCRrF7Wji568IofVz1Uq/8CTkGnjuc3Gmhz55ZRmac?=
 =?us-ascii?Q?EFnffjqaT+YevrXgUFOy4oKFeP8PPYAnHM4gbX7eOD0NqYk1XhQPVjw2Lv8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 535333aa-3c99-40f6-6647-08dcf3d2828d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 02:21:04.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1375
Received-SPF: pass client-ip=2a01:111:f403:2819::816;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> Apply a patch that removes "let ... else" constructs, replacing them with
> "if let ... else" or "let ... = match ...".  "let ... else" was stabilized in
> Rust 1.65.0.
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

One question and one note below.

> ---
>  .gitattributes                                |  2 +
>  subprojects/bilge-impl-0.2-rs.wrap            |  1 +
>  subprojects/packagefiles/.gitattributes       |  1 +
>  .../packagefiles/bilge-impl-1.63.0.patch      | 45 +++++++++++++++++++
>  4 files changed, 49 insertions(+)
>  create mode 100644 subprojects/packagefiles/.gitattributes
>  create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
>
> diff --git a/.gitattributes b/.gitattributes
> index 6dc6383d3d1..9ce7a19581a 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -5,3 +5,5 @@
>  *.rs            diff=rust
>  *.rs.inc        diff=rust
>  Cargo.lock      diff=toml merge=binary
> +
> +*.patch         -text -whitespace
<snip>
> diff --git a/subprojects/packagefiles/.gitattributes b/subprojects/packagefiles/.gitattributes
> new file mode 100644
> index 00000000000..bf5b766d75d
> --- /dev/null
> +++ b/subprojects/packagefiles/.gitattributes
> @@ -0,0 +1 @@
> +/*.patch     -text

Do we really need unsetting the attrs for *.patch in both .gitattributes
and subprojects/packagefiles/.gitattributes? Is that related to the
different setting of -whitespace?

> diff --git a/subprojects/packagefiles/bilge-impl-1.63.0.patch b/subprojects/packagefiles/bilge-impl-1.63.0.patch
> new file mode 100644
> index 00000000000..987428a6d65
> --- /dev/null
> +++ b/subprojects/packagefiles/bilge-impl-1.63.0.patch
> @@ -0,0 +1,45 @@
> +--- a/src/shared/discriminant_assigner.rs
> ++++ b/src/shared/discriminant_assigner.rs

Just a note: when fetching this series using b4 am, I still get this
patch with LF line ending. Later when merging one may need to fetch this
specific commit directly from the git repository.

--
Best Regards
Junjie Mao

