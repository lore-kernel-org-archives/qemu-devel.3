Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6181D17159
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34O3-0005GF-1w; Mon, 21 Oct 2024 22:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34O1-0005G3-6n
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:12:41 -0400
Received: from mail-me3aus01olkn2080d.outbound.protection.outlook.com
 ([2a01:111:f403:2818::80d]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34Nz-0001NW-Bx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siN5H96bpPvt9n95gSEkEXfoN1TltIAvY6kR8Lb1BByMdY1mgawqZ2Z+Jh9r/AWvwMSCzTvfZQcvCwAaUhDCwPLI5H0Nks0JtY0nX5QU9TmayO3QxFapjiEHtMGbpcZH4UuEF80aDPa4r+6g3tWycLy+5FrYaSr3WlJ6E2uMpRz47RWJALmVJ0t+u7yi1nzSLutwXfsMLVWFewncz+KMg2qp8wai5kkjIVEO0PWH+1sFp/NRSIu6yR8uj1ogloSLWF2hg+ExalwD6vVpMA0fmbSjvyF0yU7NYvMLPYGK8Qug4BKdMtE6xALNna2xEV4lXXAeeBCFNBmy/Ab3VhD5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fnXo0VnRA98mwDl4p3nlN1n6BtQrnmCrDra7x01VOU=;
 b=Ow4IHsoXnxU7nkXxyKO1FODYP3OhNaDoU0SSoL40U3rxKqglypIIcWJZiWCHGXqJs9hfKEGqr1iypZUaJAHvnQnIFUQU1uw6/n85Dmjd+EV2uadFUdBNBxOKLpz1zy4/8n8OG6hGnz7obpf0soEe9wf8ojHOiIJE4B5gR0TiJog4aZUGrg9xfnCx5JxirHv0TFXP8HDBGgnpJtosHexcKDGmxVrYxJyld+Du+Np5yhgi/lzHMFMiLR3UFxQvvxEejccFKdzjK0kJ35egR4J52buiK2w7FUz6Uq/pfhF8tSja0l3FfB8KhtcAdz11Skk7k4aFhg8uOydN1fCgFAAGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fnXo0VnRA98mwDl4p3nlN1n6BtQrnmCrDra7x01VOU=;
 b=RIF7uCl9Ak2Yk/NbB0sCf/T7yftsGnyAf5mHaP8vrzy1NNd7BuWlr3QibY/jdt14jX2r6jCdh/o5k5dg3gsHYEdXJkFdo+FBeLkouig7ySMZbnDd1kaq64WazvGO4q1PhhunEMT+y1VtT30dQffp49W8I8P20kLixvU3VLX6bTXeih0uKbTHVUI5QwP7o4b36CAHUO+gAjWVtjvrcbtwGZz/pAj6AbdXLVr2anSt41b7xjmlmTU2Cd4p4DRXSZ+N3HmJ+g7ST4H/hzB1QJnBRvmrMh6c3uT7hAn7nd3ooEiUxLu/h6/D72ixmicuxDX8iLXFp3x3mPGQ3MCSGq01PA==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY8P300MB0490.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:291::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 02:12:33 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 02:12:33 +0000
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!, use it from
 #[derive(Object)]
Date: Tue, 22 Oct 2024 10:02:55 +0800
In-reply-to: <20241021163538.136941-9-pbonzini@redhat.com>
Message-ID: <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87msiwsx6g.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY8P300MB0490:EE_
X-MS-Office365-Filtering-Correlation-Id: f84c84de-1765-4f7f-800d-08dcf23efd47
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|15080799006|8060799006|19110799003|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 2+/L028FFJzFQesKPNML7E54oQkcJVx1ygLrtMBbbyLXEx8ohM2ROsnyhsgdq/Y05DNhb8dxxG20aCAfP0Ro5a02kpgoWNZ1DQGFvNIoPUdcXiF1+h7n7q3p2Ozgl0PEBUoLfiF2xIMOQWAGmWcYc7gZzxbOx2cI/ulNyOT2q4vhiw47dnnH35nasD6J4IhvtpOAJS8/ZOqRN0MXT3M1RDk5n7BzkICKtj44E3LT7dqu3iSD6Lcef1DjH6HXaTUxuvEsoe2/ba4mjlEP1aiJycT0KZwpnm6XaeXvOfPAQlUSmWAC53JPaFjEafz2x9T6Pbs83CfpNqh9u72PHUdiy/ci90QvtupeYx/392yp8DhAFeu35rirBKfdolce/y1YI23VYxP+jPtd94HSx1Qx28Fc4HIAq+7ZY/qKzzXU2aT2ucAAPoAmVMkpWZRxyTFEk3o1m9k/+ttJ93YB/nj+UYWwPY40hKdJn63aXIOTa0Mj39Al9rJ+npOaR44tN6fY41o1CckjZyb8AgRjS/A3QV2vhHlFvA2/KjfKIyMb8vja1xjiVYRd9kfjw5mJU3EWnLo1B0j7E3E6bZbOl3JSSlmf/WYPoFx12iMaaJXD3xZzFaOJ4Tlb8Njst2DSZHl38o0/Em5I75O5TEUSirVvoKI05XqctMcHjTSWfPAHSkEBJgftdr/gLQc4VX1Eb3nELQAGuWVAYrty5nZ9peVmJWJmPf69av3Id9VpZV5TgdU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TLzMgpWbK+L0mW7LubB+hIQyKh0BATyWyMFFSFuiN3YteVG/MsNwjcMxQ0A?=
 =?us-ascii?Q?28y35thfWU+V+Km/FgQ/enszBu6M3KbCxAAVGFVteDI6lv1tfVgW3r9pef5+?=
 =?us-ascii?Q?mnP8JJYhB/LTdW95zAUvAAN6OYUe6TZv3gqfQKLQnvc98hDktI67rgWfTmRO?=
 =?us-ascii?Q?m17BmPNOwE0MT5jbGmrTosFN5F3++oobDa57IrjRObPYo1ZJm5NDufWNivUS?=
 =?us-ascii?Q?RmPUgkUu0Kjv15rZLGKF3/YNwRMkafHdQZ8alxGsAXig4K/C5OGrrwUZ1eAK?=
 =?us-ascii?Q?QNkqLvodOGmjqUWJvoOxFTDdrflLVxX9E1MJmmvjx0t1lvBJauU/+MVDAgw4?=
 =?us-ascii?Q?whzz7gnXDQYBE2T1XHQV0Xs6xtiEvMeIv6ev14txWg6s+tF419XN91+xehtC?=
 =?us-ascii?Q?DwUgvWN+mrpHdrZahLhyPN/4IN8y8qGjuV0e0VrSwaBhG6kTQikUoIg+Ruae?=
 =?us-ascii?Q?TTYZPN25FQwYubNezTKyKWm4FdoAMjrzgErKRx6x5T5xTd2whmPLL+aNX3z8?=
 =?us-ascii?Q?KmF3GVVjqtZOQmxQ4wRfj1U3IWvS3ZcQrG9ZQTicYzmV8/EzqThPvyQIcMds?=
 =?us-ascii?Q?cz8K31c7o71GstQqMucw0Pyhuv4E7BspouomeLVI/4aa51Fz5bUUWauxJshn?=
 =?us-ascii?Q?HCDpjWNqhUhPqPQViYdzVqhRVPRQgt9CtMk5w9nDBLpDjo7JAW4S1DBcZvS5?=
 =?us-ascii?Q?HyR1q56uFrb7zf5CyItoPjDlSpkYcSDshRgScOaVEoKMQ98L4EwfDYRiLW8i?=
 =?us-ascii?Q?+/m8zGNoJqpA4KHVFd+t8+vLFtnw5tpLJR3zGBSdD8m8algtF9USlp4QWymr?=
 =?us-ascii?Q?5H1Lq9d6Gj5igKlr9yK9VJqpeIswg+2vpcDrS4Aod7iX9Yyf5onmN0DUbsAw?=
 =?us-ascii?Q?BDA8v25QP8MpYBaNGZtLU0sC+GsxGoLUfDCtzdetCFXQmSsffwSfCfT/V+fU?=
 =?us-ascii?Q?gR30Ryi9i3iGkMrG6XQtht2oL3O7lfKrGqFkB2S4HLN+//QIM26Os5jQBugL?=
 =?us-ascii?Q?tQK1c8ai7TL/k8NPVGUPRwKKpZnQaaVQSl8eI/XnXk7adag9AeNJShVM4CPO?=
 =?us-ascii?Q?CQtWnrvKUWbtP8YFr6F9r5P9qWyRp1tF4rHI4EA6int3po6V6VGPbhhIwll4?=
 =?us-ascii?Q?UZNBuYxs7txoC9n7L8njPKRXKQbpMeHqs1nhMXokRLsFk95u/HjnuirmNf0u?=
 =?us-ascii?Q?rf2zfq1uiAHomgQrj+3yb5LayuTYelVL2gxe6wUP9KGylQcOFDZJ8RVeNOo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f84c84de-1765-4f7f-800d-08dcf23efd47
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:12:33.4726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0490
Received-SPF: pass client-ip=2a01:111:f403:2818::80d;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
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

> Remove the duplicate code by using the module_init! macro; at the same time,
> simplify how module_init! is used, by taking inspiration from the implementation
> of #[derive(Object)].
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

One minor comment below.

> ---
>  rust/qemu-api-macros/src/lib.rs  | 33 +++-------------
>  rust/qemu-api/src/definitions.rs | 66 ++++++++++++++------------------
>  2 files changed, 33 insertions(+), 66 deletions(-)
>
<snip>
> diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
> index 3323a665d92..f180c38bfb2 100644
> --- a/rust/qemu-api/src/definitions.rs
> +++ b/rust/qemu-api/src/definitions.rs
> @@ -29,51 +29,40 @@ pub trait Class {
>
>  #[macro_export]
>  macro_rules! module_init {
<snip>
> +    ($type:ident => $body:block) => {
> +        const _: () = {
> +            #[used]
> +            #[cfg_attr(
> +                not(any(target_vendor = "apple", target_os = "windows")),
> +                link_section = ".init_array"
> +            )]
> +            #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
> +            #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
> +            pub static LOAD_MODULE: extern "C" fn() = {
> +                extern "C" fn init_fn() {

init_fn() should be unsafe fn according to the signature of
register_module_init. Being unsafe fn also makes sense here because it
is the caller, not init_fn() itself, that is responsible for the safety of
the unsafe code in the body.

--
Best Regards
Junjie Mao

>                      $body
>                  }
>
> -                unsafe {
> -                    $crate::bindings::register_module_init(
> -                        Some($func),
> -                        $crate::bindings::module_init_type::MODULE_INIT_QOM,
> -                    );
> +                extern "C" fn ctor_fn() {
> +                    unsafe {
> +                        $crate::bindings::register_module_init(
> +                            Some(init_fn),
> +                            $crate::bindings::module_init_type::$type,
> +                        );
> +                    }
>                  }
> -            }
>
> -            __load
> +                ctor_fn
> +            };
>          };
>      };
> +
> +    // shortcut because it's quite common that $body needs unsafe {}
> +    ($type:ident => unsafe $body:block) => {
> +        $crate::module_init! {
> +            $type => { unsafe { $body } }
> +        }
> +    };
>  }
>
>  #[macro_export]

