Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C8D41D44
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 02:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAh1D-000587-Q0; Mon, 11 Nov 2024 21:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAh1C-00057d-Ac
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:52:38 -0500
Received: from mail-sy4aus01olkn2019.outbound.protection.outlook.com
 ([40.92.62.19] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAh18-0006tP-9E
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:52:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqilCZbCng4jvmibw8VIk4pd+eaO/istv4nW5/tGfIbK9x6LzcCmIDdWuepNI0sNW1pDWKVXPB2o0rkvYT5m5zcYlhqGwhcqodt7n1s61m6qURKtMKmIhPy5TJcSnps2L0s7Lyy+kfv4v4Ev/y676PljLtS1e86sqZ3CVfxjHPj6F1Zr81Nt4Z4I09H3q9ffHCPCu1FI8rxY5JVaIpuP+Sp6fV7RrEpe0pdxOZu8HDQubdDEFkjWMlRHi20jrUmjdH/Kw8QaPcdEbPhMW5G0Imj9Om2H0UizXdx2keMa6ANA+4fgzkK0zXLzTLCFJmsdxRvCMT+u4GENjVuK8/qaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoJoTsHh2ybVGXyfPlftjP8QshGKyx38QRyFZQyKb1I=;
 b=SEIB5OhAUbar3nwKq+SpSBNXzOcQB87hMZSMjsduiB+wJ1O/Hfe+cdKkMnJgisH1mEo+4bpXmkiywtMslHyMSiX9XkCuM7eVquns9xk3zcEQbvaMhEfleNZ+CANbqfYJw3mYbFBLr9vqQXTSMNxHLhSHNfw162hnXQ3643FrH/pMaHR7/CcOlZZ3DANznV3fANt7AjrC301NXNQNXDieONvGlDyeen2dTm3dN4TKFjRcGzWP8bPNRiBcSzFYZGRQ+MqlIdjZQxOqdDsbTJwOHYV0jBlpB5TprHzFNwfJCVTkGBaVwzG4/mNRCWb8ae76KbUK1JoiKIZbFq7eL2VpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoJoTsHh2ybVGXyfPlftjP8QshGKyx38QRyFZQyKb1I=;
 b=DXz8yiocF3gX+2fF9feNRek2SaBUjL0+NRrgpW6Uwu6GgwSdoauBJBg8r+mPlYMyMGd/cDj3uISE4IvP3uHX9WQhPBXiIu4bTqxT/z1FxekS+9WPM6dVG5C+lvD2lHTN/oCczW+jmAQUWbMTac8Pvhm/NwBdGylfKn08i5VJ7XFoJaJn9s8RrXTgmiDsguSvT37ZFbC0KI3U30Ap9mKokd8Tf4vdDO08+1Ud70sv2NRJ9MkFZEkRJe9bY/ngEa6gMRaKJDLsIFR0xL45L6GZx6p2xwYre7u5FM4kC4XsPeR/8XLfPDTOkJ9TdZSdHa4BbRd/JiE7VBDhT6YfjMrJAA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by MEUP300MB0205.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 12 Nov
 2024 02:47:23 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 02:47:23 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-2-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 01/11] rust: qemu_api: do not disable lints outside
 bindgen-generated code
Date: Tue, 12 Nov 2024 10:25:22 +0800
In-reply-to: <20241108180139.117112-2-pbonzini@redhat.com>
Message-ID: <SY0P300MB102699E99096F482F06296EF95592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87iksti2xc.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|MEUP300MB0205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f429526-60fd-468b-9c30-08dd02c45594
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|19110799003|5072599009|8060799006|15080799006|461199028|1602099012|10035399004|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iokc0y9DilNLqc6cr55FbNVFwy/JMTW8/sHUVY58v8Y/Tc17JxULRndJEvvJ?=
 =?us-ascii?Q?JqJTZ2ARM13Zi0lqCSgldm2zbqr1v4OAGAXiMb4iMB046ySp5nYVhsgWRRGH?=
 =?us-ascii?Q?fq1ucb62zHHeMB04QAYcy5w6eDS1XZzYVnQcjcSLxand+6qbJcCOlR0eRVBl?=
 =?us-ascii?Q?jnYfL2lf/aH6Bfe/q9CUS5MQFvsccHz8js7B14RgxCnCycFhHQ+sT5pNe7Dn?=
 =?us-ascii?Q?iIkmFxM0z9zTOpvcgaQtWo0krhxkIIzxl7Y/lvaiELnC5ZJkzvJZCf8iKWGp?=
 =?us-ascii?Q?X+k3ouQYygBLgIHlZiunmG7rCuoEHdowuPRsYKHpl6dJQXaiLyC8u41baFzI?=
 =?us-ascii?Q?gzp+gmhERYWZIvN+B9iPH6jNntXU3i+Zvv3j2HfQ9gxXbQJ+7Z11vi7Bl9k7?=
 =?us-ascii?Q?U4OOzYOG7K8J0wINNfDljCSHV25xvDtDpwLkUwCgFMVqpAUaHeO50fh54eoH?=
 =?us-ascii?Q?j58giv6XOTqQZ43eiZeF2q/zCIJZiBuX6S4QN5Mjn++To69bexLwnw3FBkAG?=
 =?us-ascii?Q?kFEtxAgOQbCVF7kw7jPgTnWeNys6Vggw0CoNKu62cuxsD273OIRZDZ9hfJJm?=
 =?us-ascii?Q?avr44j209gjUPcOOrORNxXk2Phm8EFniMJgGXCkGbbYzVa/AYk1/tcjhrXCU?=
 =?us-ascii?Q?ew5vYkE02wVicc1Gz5Kx64okG1XOcNW6Wuw92s9ms8da9VavXYuPpl1t3Uwz?=
 =?us-ascii?Q?jZAPkGtORl8KLPN8s4zyAXYNtxT6MCdLh5KrNUtvriCODCD07vnPb4zMqUX1?=
 =?us-ascii?Q?riBIjxb4iFNkkJZCq+kxc3mi3D/sQyn1kK5xRdC502SPSahPz2LKUmr7lVgG?=
 =?us-ascii?Q?l6G9HoG+cqgpnZpHmK93nQlDunT0rYg+qinWFFIhkXh8CfqzNXefSDFLYU8s?=
 =?us-ascii?Q?3XgWepIuq1cQHB1iNRR67ysmg6oYkABw3o9xbWXFWVi+//x9FM8snv4+oZK5?=
 =?us-ascii?Q?/vGcATTCkm3f3n9mHbl5WKJ6GhfkWp7tO2s25FAhwQrFtAYbKE7WLTSAhYES?=
 =?us-ascii?Q?eAIeX/Ac41dUJ7QwXM2KLl45QHly3Bgf8bI56uuhh1Sy8dJpj7CEaIrRtftO?=
 =?us-ascii?Q?IOSuMTsPiwzn6tLlxFrOt+tiqWGRNZj95pae3C4sMT2WBH6WTTjSheEUKiqK?=
 =?us-ascii?Q?dvSZh2WssXbjOMN56fbC3F/RWOybAACxHQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K6ZdYUe11i6dxPMMNADNqtKeyhHBWjPHKnX5UG0qR6LNz0G3hRVMvhCCSERh?=
 =?us-ascii?Q?dcRfxvF/tZ0NeZFkY7JjGdJ9si0wUcNVNsVutr9hBI7JIPrK5S8NdDch+RN+?=
 =?us-ascii?Q?IreKuur/uEb7eKBYfIyATzz5wUEiMe0AT8sVPP3pPcILAUUhqZqrNChtD1+A?=
 =?us-ascii?Q?MICeWeRiy0F35KeF8m1gZ308eOCSKdufI/Jnc71wXnX01JyILBg5xYzNJJ1v?=
 =?us-ascii?Q?T+xngspM9dq7vonFNAY+IzI2guj61ZBD/dhGNdNn+3v/obUysDi+neeLbXJR?=
 =?us-ascii?Q?XrlWdaik2Eth/2hEOJqKRT6tMlxBgdRQsU+fUBkPq9fl/JIRNgGwu4OkfvCg?=
 =?us-ascii?Q?69NIrpv8phk5A9Wf31A/sNODfjv2qi3CTRDd9MdYB+6MxDkg/jlAQfjaWUTv?=
 =?us-ascii?Q?+lSMeL4lhEJXk9KumBPkcqwYjJP+v2IDxKVo6UWwqw4YxTPOUhhnh0S3RtYD?=
 =?us-ascii?Q?COT+flnuWvZDq17Ydakl8crl5GQSF/MOTGxoumQcfwMVe72yg+AzYb6w//vu?=
 =?us-ascii?Q?roOr7r5dtO0FC+L5Z1lQBf64nDjOQa5Fmh/bMW3iFIOYJQW7JjT/mp43GyDF?=
 =?us-ascii?Q?roqVqWMooyadlXDelA3HdOYh4vdG0f7hMw8N+s5WvOet0x9FAabcbR58IabB?=
 =?us-ascii?Q?Y27IIlc0bdzjTwF2fVwbiDpQ56pX7zItzF4c8OXWaMVkKtc0wA2RlgymXs0P?=
 =?us-ascii?Q?XbCo2e3OkcLVFRhNkROIG4gRyeUtl8yZSmd7+3v47Q0hGBii3rHuooLToyTF?=
 =?us-ascii?Q?xHMzt9Ki6owP5AMpvNk1hSb05DZmg2W0qyf6AZYqD9IxcEUXkTSF1LofbWDX?=
 =?us-ascii?Q?akSteH6UZdNFjh+sDY8/hSWjCEMFhp0Ypdd+WyRnp36MffiQ+1lt+67y/Eqs?=
 =?us-ascii?Q?7GP0MP0V2XDD+QGnqqbfWUPGSIfCApE8W6m8Y1WLpbLz+mCbh0Bt2SinORpq?=
 =?us-ascii?Q?TuBwpB8KHSxCojcuzfl9Whhrjm9m2GNdhiUbSQCo4tojx3No+prIDuquyBOU?=
 =?us-ascii?Q?8fK5V70A856PenzxRKFnPJGkWaPrghCf+abNl3BVvUjpabEVNdA43teFcIm1?=
 =?us-ascii?Q?d7fmM6PBKto4QZS3WMZ1tKEC62n74pnYziWSWi2DwIXnVzsWPITFE/dWV9MI?=
 =?us-ascii?Q?5RK1FIczDYsTYRqkVSzpkPZ2jNxaj1UH5vuTcp5ewrTcHXXp8kd/tmF3jS+E?=
 =?us-ascii?Q?eKV65KPqpzSZ9zsp1SKKix5S8eTkms3Z47gRb/jmv7f520/1aK7wAmHvZd4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f429526-60fd-468b-9c30-08dd02c45594
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:47:23.7156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0205
Received-SPF: pass client-ip=40.92.62.19; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> rust/qemu-api/src/lib.rs is disabling lints that cause problems
> with code generated by bindgen.

The commit title is misleading. Today the lint-disabling attributes are
outer ones which apply only to the bindings module. Those lints already
apply to the others in the qemu_api crate.

That said, moving the bindings mod and the related extensions (trait
impls, etc.) into a separate file still looks a good idea to me.

> Instead, include the bindgen
> code via include!(...) and move the #![allow()] directives
> into the bindings module.
>
> Add MESON_BUILD_ROOT to the devenv, so that it's easy for
> build.rs to find the include file.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                   |  4 +++-
>  rust/qemu-api/.gitignore      |  2 +-
>  rust/qemu-api/build.rs        | 20 ++++++++++++++------
>  rust/qemu-api/meson.build     |  1 +
>  rust/qemu-api/src/bindings.rs | 29 +++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs      | 22 ----------------------
>  6 files changed, 48 insertions(+), 30 deletions(-)
>  create mode 100644 rust/qemu-api/src/bindings.rs
>
> diff --git a/meson.build b/meson.build
> index e0b880e4e13..a7342c6edbd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3,6 +3,8 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>                            'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
>          version: files('VERSION'))
>
> +meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
> +
>  add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
>  add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
>  add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
> @@ -4089,7 +4091,7 @@ if have_rust
>    bindings_rs = rust.bindgen(
>      input: 'rust/wrapper.h',
>      dependencies: common_ss.all_dependencies(),
> -    output: 'bindings.rs',
> +    output: 'bindings.rs.inc',
>      include_directories: include_directories('.', 'include'),
>      bindgen_version: ['>=0.60.0'],
>      args: bindgen_args,
> diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
> index b9e7e004c86..2accb8745dc 100644
> --- a/rust/qemu-api/.gitignore
> +++ b/rust/qemu-api/.gitignore
> @@ -1,2 +1,2 @@
>  # Ignore generated bindings file overrides.
> -src/bindings.rs
> +/src/bindings.rs.inc
> diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
> index 20f8f718b90..e4eab718553 100644
> --- a/rust/qemu-api/build.rs
> +++ b/rust/qemu-api/build.rs
> @@ -2,18 +2,26 @@
>  // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  // SPDX-License-Identifier: GPL-2.0-or-later
>
> -use std::path::Path;
> +use std::{env, path::Path};
>
>  use version_check as rustc;
>
>  fn main() {
> -    if !Path::new("src/bindings.rs").exists() {
> -        panic!(
> -            "No generated C bindings found! Either build them manually with bindgen or with meson \
> -             (`ninja bindings.rs`) and copy them to src/bindings.rs, or build through meson."
> -        );
> +    // Placing bindings.rs.inc in the source directory is supported
> +    // but not documented or encouraged.

I agree that storing generated stuff in the source directory should not
be encouraged.

Just want to mention that such changes can lead to trouble to
rust-analyzer. Today there are two ways to inform rust-analyzer of the
project structure:

  1. Use rust/Cargo.toml. In this case we'll hit an issue in
  rust-analyzer [1] that prevents it from including sources outside the
  crate directory. Thus, definitions in the bindgen-generated code
  cannot be found.

  2. Use the meson-generated rust-project.json. Due to the use of
  structured_sources(), that json file refers to the copied sources of
  qemu-api in the build directory. Rust-analyzer can find every symbol
  in the qemu-api crate but will jump to those copied files, making it a
  bit more annoying when developing the crate.

We can perhaps leave it as a separate topic for another series.

[1] https://github.com/rust-lang/rust-analyzer/issues/17040

--
Best Regards
Junjie Mao

> +    let path = env::var("MESON_BUILD_ROOT")
> +        .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
> +
> +    let file = format!("{}/bindings.rs.inc", path);
> +    if !Path::new(&file).exists() {
> +        panic!(concat!(
> +            "No generated C bindings found! If you want to run `cargo`, start a subshell\n",
> +            "with `meson devenv`, or point MESON_BUILD_ROOT to the top of the build tree."
> +        ));
>      }
>
> +    println!("cargo:rustc-env=BINDINGS_RS_INC={}", file);
> +
>      // Check for available rustc features
>      if rustc::is_min_version("1.77.0").unwrap_or(false) {
>          println!("cargo:rustc-cfg=has_offset_of");
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 6f637af7b1b..e3870e901e3 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -9,6 +9,7 @@ _qemu_api_rs = static_library(
>    structured_sources(
>      [
>        'src/lib.rs',
> +      'src/bindings.rs',
>        'src/c_str.rs',
>        'src/definitions.rs',
>        'src/device_class.rs',
> diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
> new file mode 100644
> index 00000000000..1dac310594d
> --- /dev/null
> +++ b/rust/qemu-api/src/bindings.rs
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#![allow(
> +    dead_code,
> +    improper_ctypes_definitions,
> +    improper_ctypes,
> +    non_camel_case_types,
> +    non_snake_case,
> +    non_upper_case_globals,
> +    unsafe_op_in_unsafe_fn,
> +    clippy::missing_const_for_fn,
> +    clippy::too_many_arguments,
> +    clippy::approx_constant,
> +    clippy::use_self,
> +    clippy::useless_transmute,
> +    clippy::missing_safety_doc
> +)]
> +
> +#[cfg(MESON)]
> +include!("bindings.rs.inc");
> +
> +#[cfg(not(MESON))]
> +include!(env!("BINDINGS_RS_INC"));
> +
> +unsafe impl Send for Property {}
> +unsafe impl Sync for Property {}
> +unsafe impl Sync for TypeInfo {}
> +unsafe impl Sync for VMStateDescription {}
> +unsafe impl Sync for VMStateField {}
> +unsafe impl Sync for VMStateInfo {}
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index aa8d16ec94b..440aff3817d 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -4,31 +4,9 @@
>
>  #![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
>
> -#[allow(
> -    dead_code,
> -    improper_ctypes_definitions,
> -    improper_ctypes,
> -    non_camel_case_types,
> -    non_snake_case,
> -    non_upper_case_globals,
> -    unsafe_op_in_unsafe_fn,
> -    clippy::missing_const_for_fn,
> -    clippy::too_many_arguments,
> -    clippy::approx_constant,
> -    clippy::use_self,
> -    clippy::useless_transmute,
> -    clippy::missing_safety_doc,
> -)]
>  #[rustfmt::skip]
>  pub mod bindings;
>
> -unsafe impl Send for bindings::Property {}
> -unsafe impl Sync for bindings::Property {}
> -unsafe impl Sync for bindings::TypeInfo {}
> -unsafe impl Sync for bindings::VMStateDescription {}
> -unsafe impl Sync for bindings::VMStateField {}
> -unsafe impl Sync for bindings::VMStateInfo {}
> -
>  pub mod c_str;
>  pub mod definitions;
>  pub mod device_class;

