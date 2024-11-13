Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C803D41C0C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 07:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7dR-0003WB-TK; Wed, 13 Nov 2024 02:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7dO-0003Qo-PA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:17:51 -0500
Received: from mail-sy4aus01olkn20805.outbound.protection.outlook.com
 ([2a01:111:f403:2819::805]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7dM-0005zc-Qe
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:17:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV1EUt0QVpQipUGReC7YIpVkSvbTi5QHRbP3nWvhhrSohXg/17Os7P6Y4Px3YSqm3Pn63kXCD1sVKbjKCXCXudQBW87sn24YvGvAmNIE71+dqohh/2k1OqC+3awBfQZPwQm0eT09acvx2kdY5aDYi9TGEv+SsjG0V00YZ8AdOW/2ZEJrQ6gFP2QEnNC7/mHh8sgBjtGqBBlca2L4Z4Vca6ZwuDK8rHur09CTHQ+bFg+rA2/hFL0bbTeq7eMtt7kO34ovJ597JTFZrgF3JXGmTEk0MhW03WRGqjKSDG9/Vdh+s4jxkh/MJM1bZvCVhqPjmnca7QDf1Nu60pZvCrCNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z34IM9HvMPKly04mRrw+Kqm0Ev84ZxnsmtQ+hAOoK8M=;
 b=yuXwZx4RZ14ORM3geEl/NkgfJ8+juyytzLkVa8N89OQkJU/UwkulVlXyMJvrXN7Z4VFNwPs8zs3Zd//BYL/4vyr+e6lAr0hW4ZmNTKIFPpr18NJNZL70bDHOTp+LWfzu7JlfxRNly9vz3/AGexxlUD/fl++GaooHY6xOl3Qai46XcP+uJsd8lae7ekUL/+NiItFA8gyXmkBVhguvrc8w342oZM2k343ZM58366PkrDbaYNSbkqKdPhZ9WGpYnJLtks4bGcuVjwbhBOh+oncV4U/DcWe1IEb272epufYu3v6Vm1rIh9XXna2z2D+lwu3WuvplhCeyg9zL/Q/uLF/P8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z34IM9HvMPKly04mRrw+Kqm0Ev84ZxnsmtQ+hAOoK8M=;
 b=aeyjNKDhbaiL00lpQ5l9MTSj8+pWz8J0deuChikq/fwS11+ekkrAfdhhZQZN16wG6cB+1ShbcPSU0Mjn2XJzucSrSFTImnrd5H2f6AobFXJLmxNISpBXJ5d41Q82KsAJZ7nagdXsldV8+UGVPZtvzdyNP9O/qoFLTCQQBr0HWFymROgMo9Y3tkAkZTXiQiKRissxAilIFpuiFW5cKgTc8bGEB5s36Vxg9cT2l4Nhl5po1t5I8eHs3fTuxAc4cYwfW/5oaERAlTAgu7Oqsvtg52DP0zoEPYUDCIhks2pMZaWsM3xhSJycYw5NQS0HmcokSevls/iNtmW0fAeMWorITg==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 07:17:42 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 07:17:42 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-9-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 08/11] rust: build: establish a baseline of lints
 across all crates
Date: Wed, 13 Nov 2024 15:14:35 +0800
In-reply-to: <20241108180139.117112-9-pbonzini@redhat.com>
Message-ID: <ME0P300MB1040EF4DBFD69EC355D1A708955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <878qtnfvqr.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|ME0P300MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: e76da505-28ee-4dbb-4957-08dd03b343be
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|5072599009|19110799003|461199028|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pfo+8b1jFd9AvCFEcMjoHsAhXMes95u7PhPnyjBBgvLfJTZzI6Yg1VokCdsS?=
 =?us-ascii?Q?OX/p+vqyWpyEg5klTvDXV9vIuhLbrw0zLVk3j+XIlkeXfTvgPJPJgYr5HbbR?=
 =?us-ascii?Q?IjPmrvnoMX7S+LX6f48g+8zgsZ+JBIfEfL3b4xUjQK/t3P9pRzOFtAYf4zdi?=
 =?us-ascii?Q?K9wYBk82ZAlwRaulDtYtI8ckt54FhMDndZqfc/ToIp/a91MjuBKmiLNTSm15?=
 =?us-ascii?Q?B/S+RLc4tpZHjHPLWzZd4vBOlkIGH355oIeV1/A5zD+DPrSC3iYH5cjI11Xa?=
 =?us-ascii?Q?dk3DTlqscvLwZvJZQ9+4LgZq58wjYNd8Zz9NLXX28AkuyD5/ltn4p7wQxmgx?=
 =?us-ascii?Q?nWLl5QNiTeP14zXQ5jzEDz94GjZyWQZif3X2RE5exECpC2n8aGf/F5/nXS5/?=
 =?us-ascii?Q?Di2joac8CUlVgokTTABUPXefJVS/Ql1o0YC1SN/32DjW3ZEQnxjsNdRS/bhG?=
 =?us-ascii?Q?zMUZsPdPPzIL1cJybyfdqL22sd7bsOfWLy1lNPcxPQiQytPCy0GdewBdwXZl?=
 =?us-ascii?Q?3P/Ojf7kM1qth48OOe/oIIb6GyGRkq3dV8Vq0J6oQHDmS8NZ6fvU+N3F2vSD?=
 =?us-ascii?Q?buMMkZi4c4zsG2tU9+0pnva7QQl3OZvp6+SvgxgMHvzEma2xYqQ9nrF+STAh?=
 =?us-ascii?Q?wDGCKRkkaG/2NZmMJb55bQlD4U3Qh4qw42d/QVLzkXekMIAo1fa8KkmHumE2?=
 =?us-ascii?Q?u8DAbisuL4M88Whk6E/1u7MjqWeY2w4Yq6JZensZU6E9Q74C9j92sk1n7isM?=
 =?us-ascii?Q?iPJanY5x/D0xXB0JDghwz+v4iCbmOxtctVFDsKK9cG8/Lyb+4Wt7LeKMZbuG?=
 =?us-ascii?Q?AfkdF3+wK0SsdnmVERjmD6P1AczZXXYEzUeMCDkTj2BXYeuNhvO9nW8PvtFA?=
 =?us-ascii?Q?kLDReWTiQ/O6rxAl5ypy9LxfUAFVVhf7kgWZ7tgxisKq++Ln4jUsKZj3fFt7?=
 =?us-ascii?Q?RBBdly/7sClyRBtYiUBQern/ueBXZ0/5Rir/1Z+6QkKrBvri6O3rOIuPV8Je?=
 =?us-ascii?Q?homlFKVPYgAqWY4R5tWMRtSA8nYTvLsuYagcfUOZpgkJhtQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewc9R4H57Ym+kwcsLU1ohEm7PZUsL62/Plf05OeldDsG495eNq2cIovZedPQ?=
 =?us-ascii?Q?jM24zCMIGgKLimB9owBXbs4rhIhtAIGs4zNOnSYuynT4x8gq7E1vei1SOHOw?=
 =?us-ascii?Q?T23flhJpWCro39izrqOm6azdUUat4KpUNX3lsVUvJDe1Ul176SvbVa2jrM3n?=
 =?us-ascii?Q?uQsHZiLQggp3htu6HyaIMMaBJ2YRJPeZYinmfU6zdNUDIYd3vs3LX5kSE8OY?=
 =?us-ascii?Q?QyDJpi0eH+buVD9wnqLVGKLljqkXl9CYsoNbjmaVQLA0Cy42mwhmuJWrbOIF?=
 =?us-ascii?Q?dqWPmmwSLRge4CBsd+8pj8gHcRDOejZe3AgHjLrFlyLrGy3IVmYUoSuzjA8P?=
 =?us-ascii?Q?+G9ZS7fHwlXpFLU0f2V5XV86d9RHFXpnTV23e90v7ktnSuAbk6U8zIWsmsxz?=
 =?us-ascii?Q?1lcQ3Es9Zu9nH+pg2gAysC0VB2aPRvXfCtNNlBrFTNpfr/mjSGNP3Fo7WAkE?=
 =?us-ascii?Q?LQd75wFMZJtO0gl/olLT1c7PAkOVlVzba/BJl1snsmaiJ86vt8YnhdpAprnd?=
 =?us-ascii?Q?Jsa64gbrdawH60tXIZvZTCTBFXNtOFGcgvoGxwltu0kkaC+Toua2BfiMVUG5?=
 =?us-ascii?Q?EfZ+zId01ZwzVio5fUfFTEvmqtAheeRW8fQbALF0i9xFLtVIC5XRhQI8E7jx?=
 =?us-ascii?Q?91w7sDMykBYXv+RjyCSC/P8A5EJXpbdZ89E0OqmzLtP9MxoNvwojSkeu5IEI?=
 =?us-ascii?Q?PUidYBQWLYRfyR6dszw09IBHw5M3nmfoHdUpt8b30Wre6qdfDhGR0Rg++CrA?=
 =?us-ascii?Q?bi/rLkjJzWTwWT/7lvXBoUB3SQPLf+0LmI+VeV9w/OITnP6oCUKQJ5N15yGe?=
 =?us-ascii?Q?dCsD+itZytDCSvWnDJXE4+08ILzfdcGjB/2YPylXuY830yeglRhSpxRBpYWR?=
 =?us-ascii?Q?1Ot8DZplRVL223mh6hu/DhBmPhU/mlgxDnsbY1smFUEwMSkT7puXONSCH1hQ?=
 =?us-ascii?Q?vqwe6F5xC5nydRpmBExyj0y7YdeGcj/OhxbiavDHO9/h9ITYoBpkPrkvhoh2?=
 =?us-ascii?Q?iI0+Gw5tqMcTiKk/M3xuMbT6pcsQSAQAOVFpHn5FwSSpeNP6QUp+lKBvJh3O?=
 =?us-ascii?Q?HHRI+frU7z3Qrxtt4LxIvxUQ4uHV9mhlNPNMOPVqN6wHAccmY1ZFV3evxlZW?=
 =?us-ascii?Q?9iB3/KxWnF8v5UBWo7S3oTtcUV16QckEtufl9bp75YlIdiBX0WSewgcqEynO?=
 =?us-ascii?Q?tEo/PoXlFCKvbm/8BCC5S76umlt8YcmoU9jYJ/CjUUZxEC3IlpLIKDrHBL8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e76da505-28ee-4dbb-4957-08dd03b343be
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:17:42.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1309
Received-SPF: pass client-ip=2a01:111:f403:2819::805;
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

> Many lints that default to allow can be helpful in detecting bugs or
> keeping the code style homogeneous.  Add them liberally, though perhaps
> not as liberally as in hw/char/pl011/src/lib.rs.  In particular, enabling
> entire groups can be problematic because of bitrot when new links are
> added in the future.
>
> For Clippy, this is actually a feature that is only present in Cargo
> 1.74.0 but, since we are not using Cargo to *build* QEMU, only developers
> will need a new-enough cargo and only to run tools such as clippy.
> The requirement does not apply to distros that are building QEMU.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml               | 66 +++++++++++++++++++++++++++++++++++
>  rust/hw/char/pl011/src/lib.rs | 18 ++--------
>  rust/qemu-api/src/bindings.rs |  6 ++--
>  3 files changed, 71 insertions(+), 19 deletions(-)
>
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 1ff8f5c2781..43cca33a8d8 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -19,3 +19,69 @@ unknown_lints = "allow"
>
>  # Prohibit code that is forbidden in Rust 2024
>  unsafe_op_in_unsafe_fn = "deny"
> +
[snip]
> +
> +# nice to have, but cannot be enabled yet
> +#wildcard_imports = "deny"
> +
> +# these may have false positives
> +#option_if_let_else = "deny"
> +cognitive_complexity = "deny"

Just to confirm, CC <= 25 is to be enforced for all methods, right?

--
Best Regards
Junjie Mao

