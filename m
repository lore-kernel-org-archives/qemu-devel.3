Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B632DC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBgaz-0003Vc-DS; Mon, 27 May 2024 16:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBgar-0003VL-Ds
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBgao-0000Xr-Le
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716840311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=znroW/2lJnpBsbH6kcIIJ6KtkLrdbmDyY3LCnaxJ+ss=;
 b=S0OE8AG+y6usRHtLtGXo9Us0P9Xom4mKU0PC9rjs9Wjn6jVCXeNr9+jTfT1CxIj/p+Kbsh
 B2BF+1OTbbZspeoAXsuXBg0j4sKyhB9hvVL2v2Amol+2+gazwgYaKae/xntg8kaydKPqo3
 UVIbMMM4VMePS/YJ1H/zIpTiwnP0Fe8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-IuJ6dL19Mw6CfyqFlmDlpw-1; Mon,
 27 May 2024 16:05:07 -0400
X-MC-Unique: IuJ6dL19Mw6CfyqFlmDlpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A0BE29AA39D;
 Mon, 27 May 2024 20:05:07 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA0B492BC6;
 Mon, 27 May 2024 20:05:06 +0000 (UTC)
Date: Mon, 27 May 2024 16:05:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Message-ID: <20240527200504.GB913874@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-2-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M5oqlcP4WcGHUrsm"
Content-Disposition: inline
In-Reply-To: <20240527081421.2258624-2-zhao1.liu@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--M5oqlcP4WcGHUrsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:14:16PM +0800, Zhao Liu wrote:
> Define the basic cargo framework to support compiling simpletrace-rust
> via cargo, and add the Rust code style (with some nightly features)
> check items to make Rust style as close to the QEMU C code as possible.
>=20
> With the base cargo package, define the basic code framework for
> simpletrace-rust, approximating the Python version, and also abstract
> Analyzer operations for simpletrace-rust. Event and other future
> trace-related structures are placed in the trace module.
>=20
> Additionally, support basic command line parsing for simpletrace-rust as
> a start.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/simpletrace-rust/.gitignore    |   1 +
>  scripts/simpletrace-rust/.rustfmt.toml |   9 +
>  scripts/simpletrace-rust/Cargo.lock    | 239 +++++++++++++++++++++++++
>  scripts/simpletrace-rust/Cargo.toml    |  11 ++
>  scripts/simpletrace-rust/src/main.rs   | 173 ++++++++++++++++++
>  scripts/simpletrace-rust/src/trace.rs  |  11 ++
>  6 files changed, 444 insertions(+)
>  create mode 100644 scripts/simpletrace-rust/.gitignore
>  create mode 100644 scripts/simpletrace-rust/.rustfmt.toml
>  create mode 100644 scripts/simpletrace-rust/Cargo.lock
>  create mode 100644 scripts/simpletrace-rust/Cargo.toml
>  create mode 100644 scripts/simpletrace-rust/src/main.rs
>  create mode 100644 scripts/simpletrace-rust/src/trace.rs
>=20
> diff --git a/scripts/simpletrace-rust/.gitignore b/scripts/simpletrace-ru=
st/.gitignore
> new file mode 100644
> index 000000000000..2f7896d1d136
> --- /dev/null
> +++ b/scripts/simpletrace-rust/.gitignore
> @@ -0,0 +1 @@
> +target/
> diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/simpletrace=
-rust/.rustfmt.toml
> new file mode 100644
> index 000000000000..97a97c24ebfb
> --- /dev/null
> +++ b/scripts/simpletrace-rust/.rustfmt.toml
> @@ -0,0 +1,9 @@
> +brace_style =3D "AlwaysNextLine"
> +comment_width =3D 80
> +edition =3D "2021"
> +group_imports =3D "StdExternalCrate"
> +imports_granularity =3D "item"
> +max_width =3D 80
> +use_field_init_shorthand =3D true
> +use_try_shorthand =3D true
> +wrap_comments =3D true

There should be QEMU-wide policy. That said, why is it necessary to customi=
ze rustfmt?

> diff --git a/scripts/simpletrace-rust/Cargo.lock b/scripts/simpletrace-ru=
st/Cargo.lock
> new file mode 100644
> index 000000000000..4a0ff8092dcb
> --- /dev/null
> +++ b/scripts/simpletrace-rust/Cargo.lock
> @@ -0,0 +1,239 @@
> +# This file is automatically @generated by Cargo.
> +# It is not intended for manual editing.
> +version =3D 3
> +
> +[[package]]
> +name =3D "anstream"
> +version =3D "0.6.14"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "418c75fa768af9c03be99d17643f93f79bbba589895012a80e3452a19d=
dda15b"
> +dependencies =3D [
> + "anstyle",
> + "anstyle-parse",
> + "anstyle-query",
> + "anstyle-wincon",
> + "colorchoice",
> + "is_terminal_polyfill",
> + "utf8parse",
> +]
> +
> +[[package]]
> +name =3D "anstyle"
> +version =3D "1.0.7"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "038dfcf04a5feb68e9c60b21c9625a54c2c0616e79b72b0fd87075a056=
ae1d1b"
> +
> +[[package]]
> +name =3D "anstyle-parse"
> +version =3D "0.2.4"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "c03a11a9034d92058ceb6ee011ce58af4a9bf61491aa7e1e59ecd24bd4=
0d22d4"
> +dependencies =3D [
> + "utf8parse",
> +]
> +
> +[[package]]
> +name =3D "anstyle-query"
> +version =3D "1.0.3"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "a64c907d4e79225ac72e2a354c9ce84d50ebb4586dee56c82b3ee73004=
f537f5"
> +dependencies =3D [
> + "windows-sys",
> +]
> +
> +[[package]]
> +name =3D "anstyle-wincon"
> +version =3D "3.0.3"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "61a38449feb7068f52bb06c12759005cf459ee52bb4adc1d5a7c4322d7=
16fb19"
> +dependencies =3D [
> + "anstyle",
> + "windows-sys",
> +]
> +
> +[[package]]
> +name =3D "clap"
> +version =3D "4.5.4"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "90bc066a67923782aa8515dbaea16946c5bcc5addbd668bb80af688e53=
e548a0"
> +dependencies =3D [
> + "clap_builder",
> +]
> +
> +[[package]]
> +name =3D "clap_builder"
> +version =3D "4.5.2"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "ae129e2e766ae0ec03484e609954119f123cc1fe650337e155d03b022f=
24f7b4"
> +dependencies =3D [
> + "anstream",
> + "anstyle",
> + "clap_lex",
> + "strsim",
> +]
> +
> +[[package]]
> +name =3D "clap_lex"
> +version =3D "0.7.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "98cc8fbded0c607b7ba9dd60cd98df59af97e84d24e49c8557331cfc26=
d301ce"
> +
> +[[package]]
> +name =3D "colorchoice"
> +version =3D "1.0.1"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "0b6a852b24ab71dffc585bcb46eaf7959d175cb865a7152e35b348d1b2=
960422"
> +
> +[[package]]
> +name =3D "is_terminal_polyfill"
> +version =3D "1.70.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "f8478577c03552c21db0e2724ffb8986a5ce7af88107e6be5d2ee6e158=
c12800"
> +
> +[[package]]
> +name =3D "proc-macro2"
> +version =3D "1.0.83"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "0b33eb56c327dec362a9e55b3ad14f9d2f0904fb5a5b03b513ab546539=
9e9f43"
> +dependencies =3D [
> + "unicode-ident",
> +]
> +
> +[[package]]
> +name =3D "quote"
> +version =3D "1.0.36"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208=
acaca7"
> +dependencies =3D [
> + "proc-macro2",
> +]
> +
> +[[package]]
> +name =3D "simpletrace-rust"
> +version =3D "0.1.0"
> +dependencies =3D [
> + "clap",
> + "thiserror",
> +]
> +
> +[[package]]
> +name =3D "strsim"
> +version =3D "0.11.1"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838=
c5fb4f"
> +
> +[[package]]
> +name =3D "syn"
> +version =3D "2.0.66"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3=
cdcff5"
> +dependencies =3D [
> + "proc-macro2",
> + "quote",
> + "unicode-ident",
> +]
> +
> +[[package]]
> +name =3D "thiserror"
> +version =3D "1.0.61"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "c546c80d6be4bc6a00c0f01730c08df82eaa7a7a61f11d656526506112=
cc1709"
> +dependencies =3D [
> + "thiserror-impl",
> +]
> +
> +[[package]]
> +name =3D "thiserror-impl"
> +version =3D "1.0.61"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "46c3384250002a6d5af4d114f2845d37b57521033f30d5c3f46c4d70e1=
197533"
> +dependencies =3D [
> + "proc-macro2",
> + "quote",
> + "syn",
> +]
> +
> +[[package]]
> +name =3D "unicode-ident"
> +version =3D "1.0.12"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec=
0fee4b"
> +
> +[[package]]
> +name =3D "utf8parse"
> +version =3D "0.2.1"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af80=
0a370a"
> +
> +[[package]]
> +name =3D "windows-sys"
> +version =3D "0.52.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425=
d9a33d"
> +dependencies =3D [
> + "windows-targets",
> +]
> +
> +[[package]]
> +name =3D "windows-targets"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d=
96e7eb"
> +dependencies =3D [
> + "windows_aarch64_gnullvm",
> + "windows_aarch64_msvc",
> + "windows_i686_gnu",
> + "windows_i686_gnullvm",
> + "windows_i686_msvc",
> + "windows_x86_64_gnu",
> + "windows_x86_64_gnullvm",
> + "windows_x86_64_msvc",
> +]
> +
> +[[package]]
> +name =3D "windows_aarch64_gnullvm"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e2357=
8d3263"
> +
> +[[package]]
> +name =3D "windows_aarch64_msvc"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a27=
52afb6"
> +
> +[[package]]
> +name =3D "windows_i686_gnu"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8=
b89670"
> +
> +[[package]]
> +name =3D "windows_i686_gnullvm"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc=
232ee9"
> +
> +[[package]]
> +name =3D "windows_i686_msvc"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe9=
7487bf"
> +
> +[[package]]
> +name =3D "windows_x86_64_gnu"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e158=
1517d9"
> +
> +[[package]]
> +name =3D "windows_x86_64_gnullvm"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b3=
34c596"
> +
> +[[package]]
> +name =3D "windows_x86_64_msvc"
> +version =3D "0.52.5"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88=
b02bf0"
> diff --git a/scripts/simpletrace-rust/Cargo.toml b/scripts/simpletrace-ru=
st/Cargo.toml
> new file mode 100644
> index 000000000000..b44ba1569dad
> --- /dev/null
> +++ b/scripts/simpletrace-rust/Cargo.toml
> @@ -0,0 +1,11 @@
> +[package]
> +name =3D "simpletrace-rust"
> +description =3D "Pretty-printer for simple trace backend binary trace fi=
les (Rust version)"
> +version =3D "0.1.0"
> +edition =3D "2021"
> +authors =3D ["Zhao Liu <zhao1.liu@intel.com>"]
> +license =3D "GPL-2.0-or-later"
> +
> +[dependencies]
> +clap =3D "4.5.4"
> +thiserror =3D "1.0.20"
> diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-r=
ust/src/main.rs
> new file mode 100644
> index 000000000000..2d2926b7658d
> --- /dev/null
> +++ b/scripts/simpletrace-rust/src/main.rs
> @@ -0,0 +1,173 @@
> +/*
> + * Pretty-printer for simple trace backend binary trace files (Rust vers=
ion)
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhao Liu <zhao1.liu@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#![allow(dead_code)]
> +#![allow(unused_variables)]
> +
> +mod trace;
> +
> +use std::env;
> +
> +use clap::Arg;
> +use clap::Command;
> +use thiserror::Error;
> +use trace::Event;
> +
> +#[derive(Error, Debug)]
> +pub enum Error
> +{
> +    #[error("usage: {0} [--no-header] <trace-events> <trace-file>")]
> +    CliOptionUnmatch(String),
> +}
> +
> +pub type Result<T> =3D std::result::Result<T, Error>;
> +
> +pub struct EventArgPayload {}
> +
> +trait Analyzer
> +{

The Python version treats this as an API so that users can write trace
analysis scripts. I see below that you're using non-doc comments. That
suggests you don't see this as a public API that people can write trace
analysis scripts against?

> +    /* Called at the start of the trace. */
> +    fn begin(&self) {}
> +
> +    /* Called if no specific method for processing a trace event. */
> +    fn catchall(
> +        &mut self,
> +        rec_args: &[EventArgPayload],
> +        event: &Event,
> +        timestamp_ns: u64,
> +        pid: u32,
> +        event_id: u64,
> +    ) -> Result<String>;
> +
> +    /* Called at the end of the trace. */
> +    fn end(&self) {}
> +
> +    /*
> +     * TODO: Support "variable" parameters (i.e. variants of process_eve=
nt()
> +     * with different parameters, like **kwargs in python), when we need=
 a
> +     * simpletrace rust module.
> +     */
> +    fn process_event(
> +        &mut self,
> +        rec_args: &[EventArgPayload],
> +        event: &Event,
> +        event_id: u64,
> +        timestamp_ns: u64,
> +        pid: u32,
> +    ) -> Result<String>
> +    {
> +        self.catchall(rec_args, event, timestamp_ns, pid, event_id)
> +
> +        /*
> +         * TODO: Support custom function hooks (like getattr() in python=
),
> +         * when we need a simpletrace rust module.
> +         */
> +    }
> +}
> +
> +struct Formatter
> +{
> +    last_timestamp_ns: Option<u64>,
> +}
> +
> +impl Formatter
> +{
> +    fn new() -> Self
> +    {
> +        Formatter {
> +            last_timestamp_ns: None,
> +        }
> +    }
> +}
> +
> +impl Analyzer for Formatter
> +{
> +    fn catchall(
> +        &mut self,
> +        rec_args: &[EventArgPayload],
> +        event: &Event,
> +        timestamp_ns: u64,
> +        pid: u32,
> +        event_id: u64,
> +    ) -> Result<String>
> +    {
> +        let fmt_str =3D String::new();
> +
> +        Ok(fmt_str)
> +    }
> +}
> +
> +fn process(
> +    event_path: &str,
> +    trace_path: &str,
> +    analyzer: &mut Formatter,
> +    read_header: bool,
> +) -> Result<()>
> +{
> +    analyzer.begin();
> +    analyzer.end();
> +
> +    Ok(())
> +}
> +
> +/*
> + * Execute an analyzer on a trace file given on the command-line.
> + * This function is useful as a driver for simple analysis scripts.  More
> + * advanced scripts will want to call process() instead.
> + */
> +fn run(analyzer: &mut Formatter) -> Result<()>
> +{
> +    let matches =3D Command::new("simple trace")
> +        .arg(
> +            Arg::new("no-header")
> +                .required(false)
> +                .long("no-header")
> +                .action(clap::ArgAction::SetTrue)
> +                .help("Disable header parsing"),
> +        )
> +        .arg(
> +            Arg::new("trace-events")
> +                .required(true)
> +                .action(clap::ArgAction::Set)
> +                .help("Path to trace events file"),
> +        )
> +        .arg(
> +            Arg::new("trace-file")
> +                .required(true)
> +                .action(clap::ArgAction::Set)
> +                .help("Path to trace file"),
> +        )
> +        .try_get_matches()
> +        .map_err(|_| {
> +            Error::CliOptionUnmatch(
> +                env::current_exe()
> +                    .unwrap_or_else(|_| "simpletrace".into())
> +                    .to_string_lossy()
> +                    .to_string(),
> +            )
> +        })?;
> +
> +    let no_header =3D matches.get_flag("no-header");
> +    let event_path =3D matches.get_one::<String>("trace-events").unwrap(=
);
> +    let trace_path =3D matches.get_one::<String>("trace-file").unwrap();
> +
> +    process(event_path, trace_path, analyzer, !no_header)?;
> +
> +    Ok(())
> +}
> +
> +fn main()
> +{
> +    let mut fmt =3D Formatter::new();
> +
> +    if let Err(e) =3D run(&mut fmt) {
> +        println!("{:?}", e.to_string());
> +    }
> +}
> diff --git a/scripts/simpletrace-rust/src/trace.rs b/scripts/simpletrace-=
rust/src/trace.rs
> new file mode 100644
> index 000000000000..3a4b06435b8b
> --- /dev/null
> +++ b/scripts/simpletrace-rust/src/trace.rs
> @@ -0,0 +1,11 @@
> +/*
> + * Machinery for generating tracing-related intermediate files (Rust ver=
sion)
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhao Liu <zhao1.liu@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +pub struct Event {}
> --=20
> 2.34.1
>=20

--M5oqlcP4WcGHUrsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZU53AACgkQnKSrs4Gr
c8hHYQf9Gc536iylXgck4LCeB8f2Cz4g0CchPjostfCywNg9FqDeNgfBXgHI56Sr
TJ1TzCuxhHQtvPopFy/K4at2KtsNGd26NBCIWOhe3y21FNrYV+Tb8uSAJi6999xF
HUJ5OonAT2lcZ2gBlKj7uK237cogE2vpiDDle2Y5xd767yDFv4SovUTSe+l+wKSm
3LvzPmH/IVcSrvLr4xkeuFAcg8KPkwkJBePS0s+QvKKUJZ6caf/V3VHSxVSvTmqp
sa0LiHOJ6UD0IZ/R32KIcgTu40KJAS9mJ8XS1SNjctz1+8MArAAC36u8xCvPXuIA
pZWVzEjJ/FPAK1AcUMs5BG42r6RyVw==
=4Kei
-----END PGP SIGNATURE-----

--M5oqlcP4WcGHUrsm--


