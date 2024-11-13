Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ABDD41C0C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 07:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7Rf-00007c-Bn; Wed, 13 Nov 2024 02:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7Rd-000071-Ik
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:05:41 -0500
Received: from mail-sy4aus01olkn2080a.outbound.protection.outlook.com
 ([2a01:111:f403:2819::80a]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7Rb-0004c6-Nf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:05:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFzT0UdwLbqGTQ5hPTSR2po9zi3P/rN3qxgbWWXMlgsJkx8XNnhjSKT0+Ag1iB3A/XDOalzuWxoHpjP/8QkR21M1if2hgMUKKJ7quOzMrosUoR8LMp+qFUunnkZk+7HM/AgWSMGRYgUhnx3LoPmvbzx6psh4vdWtQ5uwX1UeUQGtG1tVNyuOLkLab5Khhj1NzFlQjn+Ck5DK4z3ME9sje7lrCfetMrPu0ZmhC3J66sjVeANO3xZNMcSPeen1bjxHTnb44OmCxW/h8kg4fCM8DeY7ArYxpIKlcrBDZeaZG6iZwBce5MMd7PqVk1yoSjvskgr3zqcaRlz1cGemNfc04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awI3iOK8q8F2CxYyX+FKGwF0HHVpcRy78Frmc/ioga8=;
 b=dOdntYCta3WDhmwvVIcStQ/t+8AK5N2fwqlSk1pwRL1BWyqht1Y8ysfhPXEa+k+BEtDT5CyVpXJlUhq3DiMz1lkGQKWo54hOsQLc7Foik6a58n1MI5xBbb+RHtqaw9G1xvDI3j5FOeTL5ez8mAFbf/o3+XYhdtsFw5qGlvY30j6MKzxen0CxM2ihoXnjbe340xluRouMPaohA5pidNCgh5diIeVZYSC2XxCmYuWoK5P27uQ4b0ee0E4p87c7/jPQHyEtwsL1bc6Iu76SMi4h48gZeLupUePpoXfu3Txx2WOEx51Z3pQSLrprEmhMwwU38nesgn29SwGPF+WUeoOfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awI3iOK8q8F2CxYyX+FKGwF0HHVpcRy78Frmc/ioga8=;
 b=reIBdybMtyeyzhHKIpIxAZiEaK5AYXqXVU0b9pLIQ1ZTv2aCTLb9bDSexr3QALgm+bI5Kfpj0eBHf+G3ehMcG2fw5XkzKktPhYRWj1rwplHaLtG15JQd7+xTNd33RCCfzcAMRqhOvJ+gyCTeV4I11kv4Kk5JYKmaC+RaGhVnU4jt/Gs00XLC2OsZNfcvOrCtMjjtMwAB5tsAfmIJ1ImO5HQDiOng5trJdlV7eGMlzmlOYGVpddNvAGur0DqaBbhRfkQBZTVAzOvQZkoNUtvLDRZl7sea1Puj1qhFv/yEkSH/0x7c6VghaG5rjEy1o9bgyI2cbuxVklGy5l6cvrazMQ==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY7P300MB0686.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 07:05:33 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 07:05:33 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-8-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 07/11] rust: fix a couple style issues from clippy
Date: Wed, 13 Nov 2024 14:59:01 +0800
In-reply-to: <20241108180139.117112-8-pbonzini@redhat.com>
Message-ID: <ME0P300MB104087E536C09875E35D833C955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87cyizfwb0.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY7P300MB0686:EE_
X-MS-Office365-Filtering-Correlation-Id: 4142d8fa-512f-49fc-76ca-08dd03b190d4
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|5072599009|15080799006|8060799006|461199028|19110799003|440099028|3412199025|4302099013|1602099012|10035399004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MIHi4d2FV7W+007fVA2A9UBkIMWf26q/mSdqDHqLo40M/HA+Rp8H58/N4wJg?=
 =?us-ascii?Q?c+TdZF6tdB/5qvKm0unlbG0lZLzxenj+n2azSzxT9UrVwY8xdqZ3Q9KeiTnX?=
 =?us-ascii?Q?TT1s74yT8+2w42Zzv7m2Q3mRAsV/faJhxD6eJi9Ke+JnmVXjRUXLX1Nw7z0o?=
 =?us-ascii?Q?JbnCofgCzhMYBx/9gk9KMEq6OfZJogt6pYF6XT5erAhdeh0vE0rzG1WwmTZz?=
 =?us-ascii?Q?xezzbcqqxfeHqOzprNfMDRAFvvRcgY0gTT1miaB3iKdbHPIBNEPjC0gRfe/R?=
 =?us-ascii?Q?lPhhcBg0j0TUV+jVRoitL1/v9ogKa0zjrFLnr0Bsa49QHZ5TzAWEmTxSCH/3?=
 =?us-ascii?Q?CkARNNnqhhIFVTGIzLTszdCGcOe1DiIJKjUQmlczUlT+VdWjUGS4s1mqYR3k?=
 =?us-ascii?Q?JP3dM1mdupGUkXBRFIyMk+OX1o3YPpwrDFy6rK9gnUB3bZjbfKukDT0341Pf?=
 =?us-ascii?Q?E5LVsGq5OAw4JVd+eqSytpH1IcBtcvuypdWzLAt5LGjvyFU41JX9ZwKlfk0i?=
 =?us-ascii?Q?n54x3yf/Y4DHMHhCjlOLmGtQOUEEMPuVVbrFm96CJBpCH4dFqWy4fdOIYmxJ?=
 =?us-ascii?Q?cCj6RMJL9HqLw8+8ZACc22VCUJO+ACNVd3sVfi6tfpT0a/oAIqf4VAQ8MhZP?=
 =?us-ascii?Q?fREvu72XMi4Olb7YwjTJsi6DRXKYUx4Ceu+VxANtt+fgX+x5GV9+QRs3r5Xl?=
 =?us-ascii?Q?RBPKn0M4aGTYEfcBJQCON3xFq/Li0bKb61KOxXOwy/uqvHmuS22TrAc+trad?=
 =?us-ascii?Q?twCqpuehdjZffuXzvy2EyQ1/aSSQ/30iaCHHzPnkqPY9tQ2jlq40Fs+gQjRx?=
 =?us-ascii?Q?81FswW6puBGcb6G4KRCuA/Mh34EbC4q8uwDNJJMS2RRyMOo5aax6ATgPyWKC?=
 =?us-ascii?Q?73pDNHCx9im4FW+e5H44UqBFaJABg205ICTqPTzAIJlnWOPM0W63MR28ehw8?=
 =?us-ascii?Q?8OViIFw6zSg1J5Bj57e2hj7dPEgZRs0Jdy2hkraTOZq/beZqET8oxaVECPyr?=
 =?us-ascii?Q?utevYj7DJQEW8JkaZYSfnT+khyJldmqUHhUJ6NunPHj8+pGOBKw0jI7AmyD/?=
 =?us-ascii?Q?CjGS3GsHusnR4NnD0V38HSTOAxDbN7EhKuHn9apvhcgrsFhr2Ze8jjBcS9eQ?=
 =?us-ascii?Q?36ZdwgSHJJqZQw7Q5LIyOU3siQXOWvVCxw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luYG0nNHvXNgx+sul/oJJPZK9U8yrQb7+cfxP7W3HmF03n12wGQu4/L12DXM?=
 =?us-ascii?Q?efH8mYz8hWEyBbRlZpqhbQfOEl1TvbfDj+y1OWAek8bi67/Mfe7oRqswd0aL?=
 =?us-ascii?Q?e4qANESF+32AEav2mUH11rQf2TD433wEjz29uyAXs63wWNv295xs6xlKL0A4?=
 =?us-ascii?Q?KNi0amLHToIAsw/ilM/URWodFy372zVZlCgcEqNK6SnI9j8HSkrzpvZDGape?=
 =?us-ascii?Q?HFjeI0S0FTqxZQh2jiaMXMpse2QazH8eaJ6OhLynMCoOwuAqcG5UnKkk7FV5?=
 =?us-ascii?Q?e1wbrKrSdKrDtGrVLt5vVAskHnkOT7+aC3PZSLhrtXpj0S91ZlL9/UO9WIK4?=
 =?us-ascii?Q?mfF4U04F9ZQjwnFvyzdOKci2OWycZU7cdMdvA1fBNNu0X4u6Va2THcnQEGZ6?=
 =?us-ascii?Q?Z/k/hQ4uXT4h0ynyKEDxrxxXwfPeuelR6iDQMCeNtFQpiGJ/dRuwYMRFx+eh?=
 =?us-ascii?Q?Koxq2teBqM3YNxS0pgtu2+cncKR7i3U6ho1HC1DgHJSoIz5qWewElY3rD+tl?=
 =?us-ascii?Q?PIDsF5XnK2x9VduTA1wBVmGlQmq/gVtSvQR13mJ1wR9Au39/I25T/mW7IkBB?=
 =?us-ascii?Q?C9r4xSMyJG9uE314Ep4+mjdGDn/hVNOHa7BPNVHJCw1lciB6AWnzwMoIZdOL?=
 =?us-ascii?Q?K7+ycSIPTGSbYBsMMvpz1/WS2wGZQ2EZIxjuKX099i+AHVqrAf6UMqLqH5eN?=
 =?us-ascii?Q?VIAPTo/LroEKSHAH4M5L6IzIPBf0IizU5qLHA2zIgqQsjdJujt6LrzWrL24c?=
 =?us-ascii?Q?PWjiiqCMMC14Xfl1Xw1USxZOocdoTu4A8L0FEko0CKJs5sCpPvKfjS+vdXsY?=
 =?us-ascii?Q?chB7e9j9c3kG/6oNbBn+T42x4Ff4FOoN7Qp8TCwRqq87a9+69XqHOzBjqDUZ?=
 =?us-ascii?Q?CZHOGtt+SPqlIAKEr71TMRJExwH643QxhEjF3nN2wAEHhbz9VYIiojSqRgDK?=
 =?us-ascii?Q?2TvklS1hktWXl4YkspCnoB9qwoV0/6wDI4PyeNTAVeasFsSWM4J9f27LJ6Ya?=
 =?us-ascii?Q?Odw1auuKD9Uld7tHIGAfXcV3Cw8MCW+mJ0EkRIB+YfszJmh2ltRV8p7ziDxt?=
 =?us-ascii?Q?yw7KzHEjzLqCp3C4KpilEv2tBAne0xE/0swR3S8XwIZO37KgNeFZlaZLTaVF?=
 =?us-ascii?Q?otSRP7MUC5rUlLbNCuLi4NiO/+zPxLsoVt21xxFjZTD/pyTL4lftGvu0fSIf?=
 =?us-ascii?Q?lTDLWZGzCD2MLnp/hkIaXCLQfEK8M6l2TuDeW0IRfyFEtfwKzEZDcDwuC7Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4142d8fa-512f-49fc-76ca-08dd03b190d4
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:05:33.3577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0686
Received-SPF: pass client-ip=2a01:111:f403:2819::80a;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_BULK_SIG=0.001, RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> These are reported as clippy::semicolon_inside_block and clippy::as_ptr_cast_mut.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

One minor question below.

> ---
>  rust/hw/char/pl011/src/device.rs     | 6 ++++--
>  rust/hw/char/pl011/src/memory_ops.rs | 4 +++-
>  rust/qemu-api/tests/tests.rs         | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 2a85960b81f..7f40e7f71fa 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -499,7 +499,9 @@ pub fn update(&self) {
>          let flags = self.int_level & self.int_enabled;
>          for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
>              // SAFETY: self.interrupts have been initialized in init().
> -            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
> +            unsafe {
> +                qemu_set_irq(*irq, i32::from(flags & i != 0));
> +            }

clippy::semicolon_inside_block can be configured not to lint single-line
blocks [1]. I don't have any preference among different styles. Just
want to ask how others think.

[1] https://rust-lang.github.io/rust-clippy/master/index.html#semicolon_inside_block

--
Best Regards
Junjie Mao

