Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A503D41D4E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 03:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAhPb-0000Nc-CV; Mon, 11 Nov 2024 22:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAhPZ-0000NN-Gn
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 22:17:49 -0500
Received: from mail-me3aus01olkn2082e.outbound.protection.outlook.com
 ([2a01:111:f403:2818::82e]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAhPY-0000uT-25
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 22:17:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0MuanHSaMlWRZqFdvz+0lvoo1Nx5Cf2ouJgkFviUoqRHRE7N5jvy4rwyq23UgI3x0685Rb0t6Xf2fp46hWLYU2gtB/uP4lBWz9HSlModfIOzl7cXnhF7sQa/bC6KczlENO3xtROqF210wHDxtnm99nF8oIuwkMXbYLq+dSsLaUfeUGdwR9Nct2g72awJnwIIwVBqNwEB1RcWeuHfWOi5rIc9il5skwozfa33M6n+Q1NjtGEYVuLYOecHBkTfrm17ONABKyboDCorfwRc7OAtzJi2xR4TCURwzW+hS30LfzX4o21qAlDkyJ6Q0uj1c0v/kTahGuz4hl9burdak7o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X37vuWtEyRB+uPVyCwubvPrkicySYkXy9O4BH6mzZCI=;
 b=vqUrNEdPejCYT1dOsWM/9YlGRLT2pdvLLdD2lHL6AHgQB+UBDx/vCri9ESx/sGNOSp2oUEaY4V2GuS6wAGYiIcjFQZ7bybN1dpsMFsIhsa4WRCaZ8Hyu9F/iosXzzOp/m6r3U4qhSaA9AAyWHLSXoA1ORyQmD4Xl0+jpQ32H++hAicQNfznf0s+5zp4VAg3TluvTpFukerW8yHnvfNLv524GB+Wu1FSY+KJ9Kn1FCvEd/iosFdaiQV6xtsLWA4MI1nAmgLMEoqpTjrTzHsApVFCBVFniAye9SnYeWaF7egrFfGEX5IjjiBfXQJWyxRR5BLcmzgSULMNPr8OMkDdygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X37vuWtEyRB+uPVyCwubvPrkicySYkXy9O4BH6mzZCI=;
 b=tZOWr8i6R45qBBzAv9ye3lqlq2gx7DDF9Y9+mcW6pdhz9+hI0B0ZMvGx+drkw7y0ihptjsqB/tqhcPhk5hEpPeBlXDy9DRwbhnZ+yEWfe9SKdMv+HqI1fZvYN6ELswkWTp4AZLPU4fOcZ12Q9LjF5g3crsdZUS22hNAx7mCTjKKJjXoNzJ6CLDPI097WzMQ5PYmLjhJ4HPS3qllOhwiogfT6U2kzexc3Ep3HHCeU0WAEBaTcpbPZE1+yx9YbzzgJ/Aq0NTVu07PUc2uftk2p4uwhUuQBDu+nLbEJC7rEUVtsCxENxZRZmBGC7iuDVew1y9BoHDSMnsVmNmCtIVsb3Q==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY2PPF59C41B37B.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::39c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 03:17:41 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:17:41 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-6-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 05/11] rust: cargo: store desired warning levels in
 workspace Cargo.toml
Date: Tue, 12 Nov 2024 11:12:28 +0800
In-reply-to: <20241108180139.117112-6-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026324D1571BBD2E001536695592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87a5e5i1iu.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY2PPF59C41B37B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bae69f1-0c38-41af-8be1-08dd02c89145
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|5072599009|15080799006|7092599003|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KO0kapAp9MKfAnyBPAPvZ0zXYI023hkXPsQXbhW/g3dqcll40y9FDXVOj4a2?=
 =?us-ascii?Q?Ui1C56WwHSWcutKjVYmco8j7v+WwMZAsf9GYIjJ2LiL4LuhOMphFyjxsERZu?=
 =?us-ascii?Q?Xv3XmYRXgxm0JcHCRsS0EfrQhYDoG8ezHyh/fACc3WuJZala5BvMouo3eIJD?=
 =?us-ascii?Q?Nozj0eaVGuRUM/5zCdQD8D4JlvVaxrRkwQROyeOOnRPPEZ0Q/cGgnDDH36IM?=
 =?us-ascii?Q?ZpqCGlJ1dO0WO2KD2zrstL1OCza6f7U/xoTP80xJ/2lYZ/EUQFMRHXN3kprr?=
 =?us-ascii?Q?7n9NMC5V4v10hKcthPe/qGuR+dMsYuj/TBgk78NcjmhbQ4auOITLwk6A57P6?=
 =?us-ascii?Q?NDu6gXPly59LwQ2Rfkci5Z7qeqEY+3AC6s6DWoejob0OZh2BAMXeyQWvys2h?=
 =?us-ascii?Q?UwTWaTXsFkZ+Lftd7uiVq2OvmckZbKhTZLcFotaKyuNofrlaZDfKb/EDkdJe?=
 =?us-ascii?Q?AayVz+UJkA5hAfrt1HGR0Q9KKy3gnrY3ILdO8p0y1TbOvkMwnrHkGv1GOzsN?=
 =?us-ascii?Q?uIKCP5heMJGmwPo7x1e08v15gf7FT8S0UU3Hz0TSxyuO/jkYTChvOV6uZlSg?=
 =?us-ascii?Q?wGcwLk7opECO0INrEQNCCBT1Fe5p++DV4JD731uPxZLpejNLc5tp94k7lfOd?=
 =?us-ascii?Q?NQSI2gHx8nteq0ZovqmNf4nd6mrwErMCM9XAMiPYahQRx5mp20iqrEqmAyR+?=
 =?us-ascii?Q?fX6xvVb9Rb3Xpxs9il5BzMOXLwMt6doA7558dWB0iIzuamuSmohI9FTJoQz6?=
 =?us-ascii?Q?bXB2Kux/5Vc8s2H6TrxP5JpadwAXsqp0affEaAMBDxQ30FD1g6t+WQ9gKuIz?=
 =?us-ascii?Q?x2JI3Dze3L8Mcgtydj/uxuG6PhF9jvAEnYww47PEhud7a4hOVPuI+3yGFG3s?=
 =?us-ascii?Q?4nsBkHqg7UiLxNvIwE+rNKUvs9EKgh04zDhbQqmsnXKMACCnUKtxVd5vwyWJ?=
 =?us-ascii?Q?5z8Mzm3yfNkBDODWA7jCdONo+GbjXJOKZ+jqgT21FAm1feN4bjMvgz3s8VqP?=
 =?us-ascii?Q?xxRl+xhmIZQjkrE4CtVzxRila4JggEWDsc6BZo65nGytetw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xA3I51ScKI1d2/B82UhKyeR+MSufXJFTc1NmJEpH3IONcdmH55Gyqf+C/ZZ?=
 =?us-ascii?Q?au/JttDtAc+SsSOC4xAE1Bs6SWWW+Z4brXmfJqV8179O65haIS53SotxrSOa?=
 =?us-ascii?Q?8mJmQWfAhepJbxuQvtD2UZdfwkzx3L1jbd5d9GCS4P79P922wW3/l3w3I8Qh?=
 =?us-ascii?Q?niMs5lL6U00dNHwntJHkyHTs3hy4kvrbE0F8wsACbJFXmQdnqUaGYdqIcqjb?=
 =?us-ascii?Q?cMO9M1hCGyge4XKJCpPiilcoaAyNfQZ3/4E95FtEuop9eMI+NUH9wGGxOe+y?=
 =?us-ascii?Q?Ph8T+e7NkJbQ1oQXcGpxggxEfkAhtUz0wFn2ezpY6wZ4xFL6WjiWaKW1oM8A?=
 =?us-ascii?Q?C7q96hgo+z+RQLQAW45SQn6UCS6MkVHDOWHgy3mrLm9PY3yhp2Lp2IqeXiei?=
 =?us-ascii?Q?wHrXHL5httUNDtyfE5W9h14hn4rLtTQR9j2Ly3fa7fnik7RhOvz05C3HZ6vF?=
 =?us-ascii?Q?ZdtCqVGet5dXnJXq6jsYLZTYDzgHijok74UMqN8Z9pQBLZ4o6PeVm3Wx12Tx?=
 =?us-ascii?Q?9tYoSnN8PWXSWjLDDqZSKLPNwxhV1A3wJObDZnKdgo1eMGZtOTnONuAHHzDG?=
 =?us-ascii?Q?nMP6B5SvzFuWIQDR26xNsuEJeXWHp+RuA5YjQeZEs2gOEReTJDc41LGJNRP9?=
 =?us-ascii?Q?Z6mRfuUE8UydQ6asQBfQMe0eFLu8BoFNvghzXmMowa5/c/aqTjgx6nejls1h?=
 =?us-ascii?Q?zB2C+2KSURIcNaWLvxjzPEGEP9K4Ak6J6zG34BmOOFQahqZxrbEwtVFR/+3h?=
 =?us-ascii?Q?fFG4FxhEkWdJLQH5kOYagHWYLK94aA8e4W7NyfLjfE9OE3g4dTQPGdnt6cTK?=
 =?us-ascii?Q?VzJN284k6NG5/+aYWkXy/WjGDNDlCy8Q/OzmIdtTw/l159hU1BeTqrrqn1P0?=
 =?us-ascii?Q?GF42ahhtbobk42JiVpwcLCmEtkpFp6C6CK7eaZwvG6PmUlzDThK7UOsW9oU8?=
 =?us-ascii?Q?9YndzrQKUwlymJ4VhBGjA3Jke+deEX0LQpUSVl0Ko1JY3mk50fO+StUCyK64?=
 =?us-ascii?Q?E2mFCCdcJbee1LSXbENVPTD1Q96Z6yubMlmtOUokMv4fhWA4w5tc7xQfw5GB?=
 =?us-ascii?Q?6F01M6t6+D2EJMeCdFDPStN5BFq3eCQl2gpsjYZDBmNB9HEltCPyTkNpyytS?=
 =?us-ascii?Q?lagh9XO4JJexrWM3anWGr0veYdyOU4Og5g/cZ9ZE18LeixiFm6GXZp5KosZx?=
 =?us-ascii?Q?A8TS4mM14msdoU2GNIu4aEDq4HDc56VsBBxAy11TIqkDj0w8Qn5dkI948cQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bae69f1-0c38-41af-8be1-08dd02c89145
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:17:41.3209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF59C41B37B
Received-SPF: pass client-ip=2a01:111:f403:2818::82e;
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

> An extra benefit of workspaces is that they allow to place lint level
> settings in a single Cargo.toml; the settings are then inherited by
> packages in the workspace.
>
> Correspondingly, teach rustc_build_args.py to get the unexpected_cfgs
> configuration from the workspace Cargo.toml.
>
> Note that it is still possible to allow or deny warnings per crate or
> module, via the #![] attribute syntax.  The rust/qemu-api/src/bindings.rs
> file is an example.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                     |  8 +++++---
>  rust/Cargo.toml                 |  8 ++++++++
>  rust/hw/char/pl011/Cargo.toml   |  3 +++
>  rust/qemu-api-macros/Cargo.toml |  3 +++
>  rust/qemu-api/Cargo.toml        |  5 ++---
>  rust/qemu-api/meson.build       |  2 +-
>  scripts/rust/rustc_args.py      | 31 +++++++++++++++++++++++++++----
>  7 files changed, 49 insertions(+), 11 deletions(-)
>
[snip]
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 0c94d5037da..0230b92a9fa 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -5,3 +5,11 @@ members = [
>      "qemu-api",
>      "hw/char/pl011",
>  ]
> +
> +[workspace.lints.rust]
> +unexpected_cfgs = { level = "warn", check-cfg = [
> +    'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
> +    'cfg(has_offset_of)'] }
> +

Making a universal unexpected_cfgs apply to the whole workspace may lead
to a lengthy cfg list when more devices in Rust are added. As cargo does
not allow overriding workspace-defined lints once inherited, I think it
better to keep unexpected_cfgs crate-specific.

--
Best Regards
Junjie Mao

