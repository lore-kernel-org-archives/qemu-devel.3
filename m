Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F433D0BB54
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 02:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3nlz-0002R0-48; Wed, 23 Oct 2024 22:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3nly-0002Qs-2O
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:40:26 -0400
Received: from mail-me3aus01olkn2049.outbound.protection.outlook.com
 ([40.92.63.49] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3nlt-0003N3-U4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTKJH+Nrmtsr1OuDDcJ0mKHOjtTW+MAkfOLHZ2u38xDlfWIm8J609uoNxf3cH6L8OtURQkXRNc4CPvQZkjkoUgqjnCu59j4LGNutNPkfHWhLLCdm05nMSOTO381IVX67rg2frcUXKrfbk6kWAqh6KvAIUkkcn7k/Oa80Ouw4UOzC0tlTMd3+1S2mrR3YFOjF0mGxqzFMvnCBPACJMJULoms+2H6JUOB0ho9OmG7w+YsM7q2Fw8hrz/Sa2h8Bv5cs/MoF6VgMy3onq2+AlTxEFHazNqrGN349Zwnoltpw+JJVM790eypATiprPPUTa0LSkoo2RG3YGUwDobShBIA0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S0R9npTWjaAGKYtmQc3anjx87enEOKi3+c29MIjba4=;
 b=W7Hs/oPuZTHp95cBFf1sPmoQVptldUS6fD7uLbBmMEUH2zsK/ENV9zMYbk4xVsmF3Mj56J3yaWNvdediL2Meon+8F+mU6dBujMqmlCsbqlBoaQCGJF+k+hORtta72wlSyKkOx6LxCJ6q/O653HLMK8sJpK0Rsf+sI0g7EJ1FmemLxJE4muoA6cPGm6XjCP/iTHRFvNMpAmGUVWKN4dm7b9Arw3j98bm5b5xLKt1bOncZU+vhyRgs3bQ0M0wRlZnzJERCzuF/COG6YN3aetV/3RoX+LxnYquuaRmJ7JlFyKwit4uv10zpgJ2ngw9UC+0XBOC8aPNqn+xBF3kYqPiJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S0R9npTWjaAGKYtmQc3anjx87enEOKi3+c29MIjba4=;
 b=eTe/821eUgtUxLBv/YHWcbr0014nISZNfoA2bp99zihz+qNhWKi+OdOPRbgxL3A2LnIPurFF7vBiFHyc8rpDyRlFc8D1FQogYoU/8+ZyBEVfbcB7RSuPVSc+Rc0vzRzSioZ4k4HsS083xTxZoziqmrBCq7WIw6iv3YBefOLkqmM72wC3NnnZJkJ5LSS5YcukGXa48gnqza4CsoN3taiZBsNYrnp3O0Btq5oWMmwU5F288dC6zLBJuR6L/Midqc5dvGLVhxwBQE2K6Rt+T2Q4gEz6bpMOv+wlBwkYY4HG8dUcNQLq3xuSBGt352wHegaVZDJS7ldgTHto7p0XBUXkYw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB1371.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 02:35:13 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 02:35:13 +0000
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-3-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
 manos.pitsidianakis@linaro.org
Subject: Re: [PATCH v2 02/14] rust: fix cfgs of proc-macro2 for 1.63.0
Date: Thu, 24 Oct 2024 10:33:30 +0800
In-reply-to: <20241022100956.196657-3-pbonzini@redhat.com>
Message-ID: <SY0P300MB102639B5E87A78ADE3CCA650954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87sesmi5yg.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB1371:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe25226-6685-4213-2629-08dcf3d47cee
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|5072599009|8060799006|19110799003|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: En8MBzDJDOp5oEEm2D/VQstOdpgkm5RebhtOv4RMtxPgsZbf2/RYGos3lml/GBm7XdJVxx4Pm4G087wqdSHfZsloFy+iuDfFnXxAhpQxSR8PZKJIcyeG0D1mZHgy1tjzpEtBllYq//JBtBeZqTL3+g2b1jCpRt+EB1U4KHoTCIOp/n0msq8ZrQDn1OLpyj4boHzepDTZamsAMrG859AcV0a4xLy72kjvzSCt5j1VtrW1eHIcRyC4dNbdIfAYj07RwRP53FzlLlcNn2XZaDFgpHbPLt2jJ0m2aS/qe1cb07nvMy0SAURTLGrwmVpbVSsVnPjz99mGcjYbRj55sl9RrjJhDwieQO6vcL+YPfnoT5KOpPBnqwJq7scMW7KeiRYLG0CdATaUAfaaiAYUgvDAwhI6hwRVgFENLFpRH0uaj2mBjqk2vjSTunNM9DS/XbVUB1QseOqmhPTtfxmecnosCN2HLdPiKwSvg2dQGvty3+QYl4h+Gw71xhJXsCX0NgxQfXP6j1oPPWvlzKP2yStmznTMOBBcxc/zLgbYMeHCe+1/9tkjImRMT0vzDeKgscWBtiXj96kYsWLraOE2HlpWY8jQ2HDOegXsiddTeqVpViHY5IVIhFV+7JrOq6B9tCVav1NsILix2my/DqSryKlfxOv23DMnWqqqmxisHSAXQJTrytv9NOaSRoKDQ1wIn6XaruYxMUc2VllTqX3rMPrJcJp9NxTvMHRijehhogiyjRE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWqLVWBsQ/RuklzfdjDaG3AJbYxeM+0H+4XTfUp0C6MKT8SCyO66PPiew3NX?=
 =?us-ascii?Q?HnCTGrb6s9z8tZ9/EKQ62XVJctZgcnkECepnzl+5cIFFmjph7IXIH39rJf6E?=
 =?us-ascii?Q?gtMaXrNKEC/2jQTFsq5O8oOkGf4vE9dnFiIvx7uk2NGgvQ8NJTYPQO313f+L?=
 =?us-ascii?Q?4C+nrf0N3dBybBDR6UhzQQB26iYpE6Ge5GoujUqv3EPGxJ52vvhMjjUIBsrL?=
 =?us-ascii?Q?p77/f8zLtBd0VPAq5Zq4Cs2Yf9JF+CD2kbZFlc/4C6CBM4zMG8Agg1RNht8l?=
 =?us-ascii?Q?gaDdM4nfASDvUCbQLccLIPnmwYQfoKX+PKDlK+9nLjkug7/F4vlr/e9W+9Z/?=
 =?us-ascii?Q?8RUiaPVQGahJZolDJQtTzBhvdelTmvlNHbRW/z2ao5paI7COa9ncILB1Ebag?=
 =?us-ascii?Q?sIeYSboLv2iZ8cPI0pUqNIufEsanXjq7/VUTAPKoWLHNvpgg1KyUKCTB4bPo?=
 =?us-ascii?Q?Rr8m8+waU3vpopsHA3G/vKcUrL/zAg83kLBkzqxMtn34QSmeS9d2EA3mVLoD?=
 =?us-ascii?Q?kW+tZA1ZbCwwiUxVCLLqnFjA18cUv4PlicRyOZmAPYHKXMyNm8bYHv4/ySVN?=
 =?us-ascii?Q?QRLChv+vtJfjO2Wb699We2U5AbUFEmKQmysLZB7/xwyUch1FDBmzgQsRUIJm?=
 =?us-ascii?Q?OgEVg7XM5qsB/iG/H44KbMflXqpokk9LtsWPYHXQJuwBB/+5PI+1g18Owgvc?=
 =?us-ascii?Q?jiotC9CUYBrc85ovXFmv9ShhZe9lK3HJPaBt2DnagiIXYmyJlUexEdbLkd2V?=
 =?us-ascii?Q?bt3byh/RQoWE8leLOI55+80BirKG7Sm7zHfJNKTcjMsPOX95KLLH968trgsj?=
 =?us-ascii?Q?5pde6ZMLIGD2UfgnukPbMUJZjum9rxKj3tI5ZshMKKXmp+/O/8pagd6TpLQ+?=
 =?us-ascii?Q?uJbxAwwS1Yfb4C+7OBe9X7B8XoG9fpZYXujqOJht2Ngkp1QjNNTpxbpXfCuo?=
 =?us-ascii?Q?eNjElQI/wgW94yJXOeH42+SeWaOCi1+5rgA2TnWN4OjGDg154tB5sxkdLT2U?=
 =?us-ascii?Q?2Un6hUN6LZSDJqnAUjsatGiM3j21TxayVdLm5YlsVC0zC4alykhKXh8ByI6Q?=
 =?us-ascii?Q?+4tLKrf33YoDmWlwFEI42ZyajuTkyJXy+oZfIhxOSb/LHWRalDUg/0q5ItY/?=
 =?us-ascii?Q?e57iGAk7yD0AYoZWWckkwKnp0e3zKLzflNSCVBF8RMmhT4tULmACLI6LgvIi?=
 =?us-ascii?Q?RFKAt3YDpqs9+zKWZX+5Q75oo0+QyHmcIFHxOFdAUM6dOCB+shYjwQNsq6M?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe25226-6685-4213-2629-08dcf3d47cee
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 02:35:13.6340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1371
Received-SPF: pass client-ip=40.92.63.49; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
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

> Replay the configuration that would be computed by build.rs when compiling
> on a 1.63.0 compiler.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

One question below.

> ---
>  subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> index 818ec59336b..8e601b50ccc 100644
> --- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> @@ -15,7 +15,9 @@ _proc_macro2_rs = static_library(
>    rust_abi: 'rust',
>    rust_args: [
>      '--cfg', 'feature="proc-macro"',
> -    '--cfg', 'span_locations',

'span_locations' is not subject to any version check in build.rs. Is it
removed because of its performance penalty and the fact that we are not
using it anywhere?

--
Best Regards
Junjie Mao

