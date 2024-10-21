Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA22D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhp-0002tr-C6; Mon, 21 Oct 2024 07:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2qhf-0002oj-K0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:07 -0400
Received: from mail-me3aus01olkn2082a.outbound.protection.outlook.com
 ([2a01:111:f403:2818::82a]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2qhZ-0001m7-U1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKtaDeQWcfyODhN9MCvKGfNegitFlr6uWZ6KtZFKWlJEIzJRGbLyFFgYbCd3HtCtYSJ8nCRsUQmkBNEVKoopXDD7+OXp2uBRBHRW+bkHejuQUvouW//FVa40OoXhDnnqRinc4/qveNwtMhwYIHipr2JRIoRf40MN/Kl3x7dwCU2pfAiscI9qgpIdx47711sTukNwPe6g7GC4TlU/NdNn9Xn3lyOM95j3pJuDSYvX57F5ztjPTXXaZtca1Agc8jadmXgx38O2DCffFY10nWMRps6nGRw6lf5nbOu7tauWDd/WVr1eR36b7r/ZMP+seElgB+E+dsJp7RfYtmTz3dSQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwD0Mkrd2ucB2KpgJpIIPJuK9Oi4GovmTyPcttPfwUI=;
 b=B3x7wWq6jW5Fs0nj5iptsBET6l633v7olGE+8DxDwrgPEq6qhSH89KpHBvWetll8GBRX0Ek/h9SxpEkpqZ4USWpvGO7I3LozGo5ms6wm7wKC15kMg4xJyESoEMznnKYkxLmWUtDSglaGS6uaffW8BaRb47cfF+ulsXtF6XUWqJqek4KIezSr+DJAECtgNoTieNuNoi6eG4i+XRVUP2/v0YBOof9/OetCmYJR8A6OcHr8/zkGUmbAkje8VQYNYRtYOF+jBKGI0b2w10ocYtmSgGJ/SqiFxKgvEqPZkR+igB1TOmpRdb5GrAF4tB1YVjvj8bYoPCuHCK/+s5Cj4/ebCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwD0Mkrd2ucB2KpgJpIIPJuK9Oi4GovmTyPcttPfwUI=;
 b=SbhZZ0qniudm61C7dH/G84kBOlAnTlw4ZctwUnruJckSlr5KNYqGQ2Uwx1NKMuwvVW6OmxSsXnPS07zZ6AUzoX1icYIRQWmukA8q8nXbFWvo+VfOo5zV1Jewh3WyWpxKMzWwnja2ZNsSVCXLqsT1waQ66JER2DtqD51B97d5GTZo+KpdXlnxP1mZY025Aa7wLmtZ/tprsADQ5aolCxlWSt1F8OSHubplvVDSTq7GVEp7GPWijlRcVjxl/fUuGC2lXhrNw5lvGUiMnybzPfOB7sW6HJ1hGEKNDWPJ74A1ELMkq+JpSRRN/7jdWpVbh8LOoPNjWZzL7yp1Jz1AoYyuQw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0292.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:236::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 11:35:50 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 11:35:50 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-9-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 08/13] rust: build integration test for the qemu_api crate
Date: Mon, 21 Oct 2024 19:28:20 +0800
In-reply-to: <20241018144306.954716-9-pbonzini@redhat.com>
Message-ID: <SY0P300MB10265D6A0FEDF3DE07F2220395432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KU1PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:802:18::36) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ldyhsn77.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a72dfd4-82e8-45a6-adb6-08dcf1c48326
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|8060799006|461199028|5072599009|19110799003|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info: Yx4P6gyzr6cU/XwytJRUY9XBnW/nOBbM80KARl+7lg8AoC5fCYs7ssbF2Jss6/fNxMBL6QmNa8EzLEKuuxOWlUJPD00ISSBGmtJGmp3jl3SkMSBEfrL1ML3yOoxVRLndN7TDDMXrANaC/c6pKjNol3UB8y0XoMlixJlZwlI8Uke6otJUQrVcebQoA+GjkpdRatW4rUdWsCFOdahYRNYtqPgNsMoVVAVhsAhy3KPIuVUK/z4qfVKzHRGSpjebhhOwfXLwZsziMZFOb7DASDG+jJ5Rb3df414uRe5+UisLePPX9C01Ye5gYp+d7k6iIE4iKhe8XwPdxiBiuEpekJwFUcoIgO7adAZSU2gm6VhAY/3CWR8jHXKfAMScGwifuUH/9FETYnI04PgSHG5jxBmhYkBpfpS5kXy2injJht/9lKkPQ3dx8MbJHtdgRjUZT72+P6pnzqCxo+PAZOozXN/sXSn69odZCwUeGG8dy3K45X0c0QUoVUChsXLXxTBUmmWcF7VA4Jycg6XxfFVC/+1SJ1Fmv1zuITFrxpatgg+forF2NeXnYqMKrYo0xfzl/Ra60zDzYZ1UYehUhhOuvNBcHt/xD/mT1zZCwOlaM4URawBLQxAZb5/Yn5dQKO13Q4W0OmOyRtavoB7PeurGExwe0gD8KLsxBbqPhvsPq+JuUzMQBY0wVN4KGY6w1PgK4fpGzF70UeamKtnTlA+Tc3tU3Hf1kI0yCDKiG9/XjL7GcGMhvzb3xNcO34LrHHjjvtdju9E98Y+KpDDLO3kBTjqxtzyVfA239a3AGwnnrBkNAzNVEtdlQt1RnL+XNvcjeAcGPKJOFjztUrfw4+NNo1+vTOqClB2cHLA+D9NLDv8HDNQZHAGfDzRl65i42tFUmgyW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVxEXtD8H9FU05fb7r4uvqsb6APUd5jED7S4s/ZuzNc+cp+h+2HOLrH8YyJk?=
 =?us-ascii?Q?eJOyJoUnbZiIwtQS5poXS8ZHKOnBRn2gHiXv+bqRU1g6Hltg4Is1eQBIGIwN?=
 =?us-ascii?Q?lOJCWbpCW7D3vp4Pjl/HvwaAhgX6/OblXO2Re5BSfZuhSG+nV9/k4awoDugI?=
 =?us-ascii?Q?tRaR5qQfGP/wfMYd2/LK0mL/PljsVrqUom3xjfk8HW1of4v0CmOLdas0zTl2?=
 =?us-ascii?Q?rXYB2WMpl60T8iyIAQPxhm0qe7RM6OpUgCVUJd6XIo9wrX8tW4tUZjsKuQAp?=
 =?us-ascii?Q?GnFjQXIf3nbZPRvVwLRAQf9Bo3NDYgLoAbwyNp4RDJR5ZvDO4ZXid6hoo8Kd?=
 =?us-ascii?Q?rrUSpH5/RD5mDzwxhWhKgaeEhRG5GfhMvsm428E65z+7PFvnOKO+y/irKswD?=
 =?us-ascii?Q?aAlgxcE6d6miZh1YeKJuPvNUU8XBauA5OwK1MJpvgJlJyGj82+fhF6RHDv8h?=
 =?us-ascii?Q?+T4XLymXauB7RibBhjbMFRhUvUfplNQ8whI9M73bRVxXQsv9n8fR3IBIIKvv?=
 =?us-ascii?Q?j7mI/6iw8XZy4Y+pubiH01AHRsEKEJvl4TfYcxyK966Qi0gNqi/yHiTvuTdg?=
 =?us-ascii?Q?KXMpLEOlxLQ2M1z4qOcsGQKP4KT5FGKKt0Nv4GZ/y9juF93KcoS8NR/3Pk2E?=
 =?us-ascii?Q?9yldn7kPXSs1JYhvWIxyZ1sDFwhRtuTTY2IzkzBWbwHuXhkckrSwIt1HjBcZ?=
 =?us-ascii?Q?mgZYuI0lMybPlPTHRCsMsE28UXjZiIr+Z7UPlBot2jYUNSx/of9tk8IZ3sYj?=
 =?us-ascii?Q?DDp58hzwLUngVNl+hOTk6bEhuSsXNihgA1QQseD80CsMJfHRez0a+QW0OYsi?=
 =?us-ascii?Q?640aSJ9nbNNAOEar6V82tvw758Imqx/JIkTcCxvP35maLOvxt9UKiv4FI0Ro?=
 =?us-ascii?Q?FEQCRyItgZB5AYz6x7IEGeLC2GntYWGwl4y5FBcdjgX/fo8UkITS+U+/N6u0?=
 =?us-ascii?Q?L9ZZLaL0V8Hl/BuOJpCgfzxaBmBB9mFzG7GT9amePsFqOWjacEDxsW6XX7xB?=
 =?us-ascii?Q?Yv16tAjUArCcCwfNZkV9t/6FUX6w8zztp/24TGfoboydneiFithX3a5LWdkN?=
 =?us-ascii?Q?aYCwcYrDTAjezu4Oovt6U2LQ/Q+QxwMG8tdwFqGFdbCm/PafbWfpRP3oWPMW?=
 =?us-ascii?Q?qZDv9z8/A1A1OC7oaJv0wilHil5WTl9QDWLxbOJbif9cmj5X9ZtJhR37btyH?=
 =?us-ascii?Q?2Tm0fVfiFiKpH36/c1tWn43XHPGEtJCCZgsgD0N23E0GBhK+3xXQnBi69wc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a72dfd4-82e8-45a6-adb6-08dcf1c48326
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:35:49.8935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0292
Received-SPF: pass client-ip=2a01:111:f403:2818::82a;
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

> Adjust the integration test to compile with a subset of QEMU object
> files, and make it actually create an object of the class it defines.
>
> Follow the Rust filesystem conventions, where tests go in tests/ if
> they use the library in the same way any other code would.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                  | 10 ++++-
>  rust/qemu-api/meson.build    | 20 +++++++--
>  rust/qemu-api/src/tests.rs   | 49 ----------------------
>  rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 104 insertions(+), 53 deletions(-)
>  delete mode 100644 rust/qemu-api/src/tests.rs
>  create mode 100644 rust/qemu-api/tests/tests.rs
<snip>
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 42ea815fa5a..d24e0c0725e 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -14,11 +14,25 @@ _qemu_api_rs =3D static_library(
>      '--cfg', 'MESON',
>      # '--cfg', 'feature=3D"allocator"',
>    ],
> -  dependencies: [
> -    qemu_api_macros,
> -  ],
>  )
>
>  qemu_api =3D declare_dependency(
>    link_with: _qemu_api_rs,
> +  dependencies: qemu_api_macros,
>  )
> +
> +# Rust executable do not support objects, so add an intermediate step.
> +rust_qemu_api_objs =3D static_library(
> +    'rust_qemu_api_objs',
> +    objects: [libqom.extract_all_objects(recursive: false),
> +              libhwcore.extract_all_objects(recursive: false)])
> +
> +rust.test('rust-qemu-api-integration',
> +     static_library(
> +         'rust_qemu_api_integration',
> +         'tests/tests.rs',
> +         override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +         link_whole: [rust_qemu_api_objs, libqemuutil]),
> +
> +     dependencies: [qemu_api, qemu_api_macros],
> +     suite: ['unit', 'rust'])

I met the following error when trying to build the test:

    [4/8] Compiling Rust source ../rust/qemu-api/tests/tests.rs
    FAILED: rust/qemu-api/librust_qemu_api_integration.rlib
    rustc -C linker=3Dcc -C link-arg=3D-m64 --color=3Dauto -C debug-asserti=
ons=3Dyes -C overflow-checks=3Dno --crate-type rlib -D warnings --edition=
=3D2021 -C opt-level=3D2 -g --cfg CONFIG_ACCEPT4 --cfg CONFIG_AF_VSOCK --cf=
g CONFIG_ASAN_IFACE_FIBER --cfg CONFIG_ATOMIC64 --cfg CONFIG_ATTR --cfg CON=
FIG_AUDIO_OSS --cfg CONFIG_AUDIO_PA --cfg CONFIG_AUDIO_SDL --cfg CONFIG_AVX=
2_OPT --cfg CONFIG_AVX512BW_OPT --cfg CONFIG_BDRV_RO_WHITELIST --cfg CONFIG=
_BDRV_RW_WHITELIST --cfg CONFIG_BLKZONED --cfg CONFIG_CLOCK_ADJTIME --cfg C=
ONFIG_CLOSE_RANGE --cfg CONFIG_CMPXCHG128 --cfg CONFIG_COROUTINE_POOL --cfg=
 CONFIG_CPUID_H --cfg CONFIG_CURSES --cfg CONFIG_DBUS_DISPLAY --cfg CONFIG_=
DUP3 --cfg CONFIG_EPOLL --cfg CONFIG_EPOLL_CREATE1 --cfg CONFIG_EVENTFD --c=
fg CONFIG_FALLOCATE --cfg CONFIG_FALLOCATE_PUNCH_HOLE --cfg CONFIG_FALLOCAT=
E_ZERO_RANGE --cfg CONFIG_FDATASYNC --cfg CONFIG_FDT --cfg CONFIG_FIEMAP --=
cfg CONFIG_FSFREEZE --cfg CONFIG_FSTRIM --cfg CONFIG_GBM --cfg CONFIG_GETAU=
XVAL --cfg CONFIG_GETCPU --cfg CONFIG_GETRANDOM --cfg CONFIG_GETTID --cfg C=
ONFIG_GIO --cfg CONFIG_GNUTLS --cfg CONFIG_GNUTLS_CRYPTO --cfg CONFIG_HAVE_=
RUST --cfg CONFIG_HEXAGON_IDEF_PARSER --cfg CONFIG_INOTIFY --cfg CONFIG_INO=
TIFY1 --cfg CONFIG_INT128 --cfg CONFIG_INT128_TYPE --cfg CONFIG_IOVEC --cfg=
 CONFIG_L2TPV3 --cfg CONFIG_LIBDW --cfg CONFIG_LIBUDEV --cfg CONFIG_LINUX -=
-cfg CONFIG_LINUX_MAGIC_H --cfg CONFIG_MADVISE --cfg CONFIG_MALLOC_TRIM --c=
fg CONFIG_MEMALIGN --cfg CONFIG_MEMFD --cfg CONFIG_OPENGL --cfg CONFIG_OPEN=
_BY_HANDLE --cfg CONFIG_PIXMAN --cfg CONFIG_PLUGIN --cfg CONFIG_PNG --cfg C=
ONFIG_POSIX --cfg CONFIG_POSIX_FALLOCATE --cfg CONFIG_POSIX_MADVISE --cfg C=
ONFIG_POSIX_MEMALIGN --cfg CONFIG_PPOLL --cfg CONFIG_PRCTL_PR_SET_TIMERSLAC=
K --cfg CONFIG_PREADV --cfg CONFIG_PTHREAD_AFFINITY_NP --cfg CONFIG_PTHREAD=
_SETNAME_NP_W_TID --cfg CONFIG_QOM_CAST_DEBUG --cfg CONFIG_RELOCATABLE --cf=
g CONFIG_REPLICATION --cfg CONFIG_RTNETLINK --cfg CONFIG_SDL --cfg CONFIG_S=
ECRET_KEYRING --cfg CONFIG_SELINUX --cfg CONFIG_SENDFILE --cfg CONFIG_SETNS=
 --cfg CONFIG_SIGNALFD --cfg CONFIG_SLIRP --cfg CONFIG_SPLICE --cfg CONFIG_=
STATX --cfg CONFIG_STATX_MNT_ID --cfg CONFIG_SYNCFS --cfg CONFIG_SYNC_FILE_=
RANGE --cfg CONFIG_SYSMACROS --cfg CONFIG_TASN1 --cfg CONFIG_TCG --cfg CONF=
IG_TIMERFD --cfg CONFIG_TPM --cfg CONFIG_TRACE_LOG --cfg CONFIG_VALGRIND_H =
--cfg CONFIG_VALLOC --cfg CONFIG_VDUSE_BLK_EXPORT --cfg CONFIG_VHOST --cfg =
CONFIG_VHOST_CRYPTO --cfg CONFIG_VHOST_KERNEL --cfg CONFIG_VHOST_NET --cfg =
CONFIG_VHOST_NET_USER --cfg CONFIG_VHOST_NET_VDPA --cfg CONFIG_VHOST_USER -=
-cfg CONFIG_VHOST_USER_BLK_SERVER --cfg CONFIG_VHOST_VDPA --cfg CONFIG_VIRT=
FS --cfg CONFIG_VNC --cfg CONFIG_VNC_JPEG --cfg CONFIG_XKBCOMMON --cfg HAVE=
_BLK_ZONE_REP_CAPACITY --cfg HAVE_BTRFS_H --cfg HAVE_COPY_FILE_RANGE --cfg =
HAVE_DRM_H --cfg HAVE_FSXATTR --cfg HAVE_GETIFADDRS --cfg HAVE_GLIB_WITH_AL=
IGNED_ALLOC --cfg HAVE_GLIB_WITH_SLICE_ALLOCATOR --cfg HAVE_HOST_BLOCK_DEVI=
CE --cfg HAVE_IPPROTO_MPTCP --cfg HAVE_MLOCKALL --cfg HAVE_OPENAT2_H --cfg =
HAVE_OPENPTY --cfg HAVE_PTY_H --cfg HAVE_STRCHRNUL --cfg HAVE_STRUCT_STAT_S=
T_ATIM --cfg HAVE_SYSTEM_FUNCTION --cfg HAVE_UTMPX -D unsafe_op_in_unsafe_f=
n -C default-linker-libraries --crate-name rust_qemu_api_integration --emit=
 dep-info=3Drust/qemu-api/rust_qemu_api_integration.d --emit link=3Drust/qe=
mu-api/librust_qemu_api_integration.rlib --out-dir rust/qemu-api/librust_qe=
mu_api_integration.rlib.p -C metadata=3D81e2432@@rust_qemu_api_integration@=
sta -lstatic:+verbatim=3Dlibrust_qemu_api_objs.a -lstatic:+verbatim=3Dlibqe=
muutil.a -lstatic:-bundle,+verbatim=3Dlibvhost-user-glib.a -lstatic:-bundle=
,+verbatim=3Dlibvhost-user.a -ldylib:+verbatim=3Dlibgio-2.0.so -ldylib:+ver=
batim=3Dlibgobject-2.0.so -ldylib:+verbatim=3Dlibglib-2.0.so -ldylib:+verba=
tim=3Dlibgmodule-2.0.so -Clink-arg=3D-pthread -ldylib:+verbatim=3Dlibgnutls=
.so -Clink-arg=3D-pthread -Clink-arg=3D-pthread -Clink-arg=3D-pthread -Lrus=
t/qemu-api -L. -Lsubprojects/libvhost-user -L/usr/lib/x86_64-linux-gnu ../r=
ust/qemu-api/tests/tests.rs
    error[E0433]: failed to resolve: use of undeclared crate or module `qem=
u_api`
     --> ../rust/qemu-api/tests/tests.rs:7:5
      |
    7 | use qemu_api::{
      |     ^^^^^^^^ use of undeclared crate or module `qemu_api`

    error[E0432]: unresolved import `qemu_api`
     --> ../rust/qemu-api/tests/tests.rs:7:5
      |
    7 | use qemu_api::{
      |     ^^^^^^^^ use of undeclared crate or module `qemu_api`

    error: unused import: `core::ffi::CStr`
     --> ../rust/qemu-api/tests/tests.rs:5:5
      |
    5 | use core::ffi::CStr;
      |     ^^^^^^^^^^^^^^^
      |
      =3D note: `-D unused-imports` implied by `-D warnings`
      =3D help: to override `-D warnings` add `#[allow(unused_imports)]`

    error: aborting due to 3 previous errors

    Some errors have detailed explanations: E0432, E0433.
    For more information about an error, try `rustc --explain E0432`.

This is probably because rust.test() is designed to build unit tests
(i.e., tests within the same crate under test), but tests/*.rs are
integration tests which are standalone crates to be linked with the
crate under test.

Rust.test() builds unit tests by "copying the sources and arguments
passed to the original target and adding the --test argument to the
compilation" [1], but that doesn't seem to apply to integration tests.

[1] https://mesonbuild.com/Rust-module.html

I can build and run the test with the following instead:

test('rust-qemu-api-integration',
    executable(
        'rust_qemu_api_integration',
        'tests/tests.rs',
        override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
        rust_args: [
            '--test',
        ],
        install: false,
        dependencies: [qemu_api, qemu_api_macros],
        link_whole: [rust_qemu_api_objs, libqemuutil]),
    args: [
        '--test',
        '--format', 'pretty',
    ],
    protocol: 'rust',
    suite: ['unit', 'rust'])

--
Best Regards
Junjie Mao

