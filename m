Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78478C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJU7-0000M5-2k; Mon, 17 Jun 2024 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJJU5-0000Lu-UY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJJU1-0001gV-QS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718658104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euGjkon8gjRW1fYoRK8Sk2Xmvyl9K4RQGXs4IFjPHF4=;
 b=Phzv+TQ2NPt+z94fXDNGRakcmBthRvwURr0H58QnrdYNVrPZmgFBg6m7eIz5iLAwbciPl4
 xGluLBpKZHt451tWy4Ky1v5J2uaYUosfT8yoRI7IwekJBe4Qs7XnwBs57yv5OYYRwLix2L
 PEIjhmzwZPO0FvtcyPraOn9g5PLklJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-M-l5GiRqNw6xu98vOfTANg-1; Mon, 17 Jun 2024 17:01:38 -0400
X-MC-Unique: M-l5GiRqNw6xu98vOfTANg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-358f9dffbedso2637247f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 14:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718658097; x=1719262897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euGjkon8gjRW1fYoRK8Sk2Xmvyl9K4RQGXs4IFjPHF4=;
 b=phyoCC4tfMq1Ulb+iHlSKvDQd0UAwA85k/AJHuIHx0wYxo52CFNXHDw/quDGLcloe8
 M7lgcP2Usb4yLDYPATTroIFVB+WO8SFDWu9F2CoOBzSbWIW1NWAqBlpts6lcAFBSxj3Y
 L3nXCbJGSXjTmiRra26ZbkAEwbN5IGZQhiRNqH33+/V5fVl2AKhE7/1Pe94Xo20rmyks
 QEetxSJZ+0WzzQHg96BoesUzLx6S0PbDIKlFRPal3kzfEVnwG5U4YdzygNCuuduA9rWC
 NvAmevvegnM8b1ly6pn4JsIAKs0c1QNSshiZk5V4AZviu0PHhe1nQVPA6lW/xLquBTB5
 ysnQ==
X-Gm-Message-State: AOJu0Yz0JH9Gl0EnlI5DXapp63/jp/CWs2FYRx65QsHV8tM+elupSzo8
 b+zn0E4M463f02OTiMr95irJaYkA5e6r4g78Iwa+qfPO+sb3n/TcDZVco+i9ya5np59uoXS/CRw
 yrHcEW/wBstpYQ5a3NBKCSEYF9xkgGCYT5o41rIjGXlkXKzKz6mOr+mQgPLcvxbqC0cWFQ03A6M
 81imefcEeuhqfymFYWMCThG4ygwxY=
X-Received: by 2002:adf:e789:0:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-3609bf51f31mr1802203f8f.36.1718658097044; 
 Mon, 17 Jun 2024 14:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp9pHDIJAXp1Yod3wHjOqnTR7K7g7E/gJr4DhgKlvnuDUKr6YmLf3gkq0wxCc69p4VtTnQwvMghI8e2WMR5Ro=
X-Received: by 2002:adf:e789:0:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-3609bf51f31mr1802182f8f.36.1718658096676; Mon, 17 Jun 2024
 14:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <ef980fb29deb81d574a7301365d9b9db72c015eb.1718101832.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <ef980fb29deb81d574a7301365d9b9db72c015eb.1718101832.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Jun 2024 23:01:24 +0200
Message-ID: <CABgObfaP7DRD8dbSKNmUzhZNyxeHWO0MztaW3_EFYt=vf6SbzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] rust: add bindgen step as a meson dependency
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

Just one somewhat larger request, otherwise just a collection of ideas.

On Tue, Jun 11, 2024 at 12:34=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> diff --git a/rust/meson.build b/rust/meson.build
> new file mode 100644
> index 0000000000..e9660a3045
> --- /dev/null
> +++ b/rust/meson.build
> @@ -0,0 +1,91 @@
> +rust_targets =3D {}
> +
> +cargo_wrapper =3D [
> +  find_program(meson.global_source_root() / 'scripts/cargo_wrapper.py'),
> +  '--config-headers', meson.project_build_root() / 'config-host.h',
> +  '--meson-build-root', meson.project_build_root(),
> +  '--meson-build-dir', meson.current_build_dir(),
> +  '--meson-source-dir', meson.current_source_dir(),
> +]
>
> +
> +# TODO: verify rust_target_triple if given as an option
> +if rust_target_triple =3D=3D ''
> +  if not supported_oses.contains(host_os)
> +    message()
> +    error('QEMU does not support `' + host_os +'` as a Rust platform.')
> +  elif not supported_cpus.contains(host_arch)
> +    message()
> +    error('QEMU does not support `' + host_arch +'` as a Rust architectu=
re.')
> +  endif
> +  rust_target_triple =3D host_arch + rust_supported_oses[host_os]
> +  if host_os =3D=3D 'windows' and host_arch =3D=3D 'aarch64'
> +    rust_target_triple +=3D 'llvm'
> +  endif
> +endif
> +
> +if get_option('optimization') in ['0', '1', 'g']
> +  rs_build_type =3D 'debug'
> +else
> +  rs_build_type =3D 'release'
> +endif
> +
> +rust_hw_target_list =3D {}
> +
> +foreach rust_hw_target, rust_hws: rust_hw_target_list
> +  foreach rust_hw_dev: rust_hws
> +    output =3D meson.current_build_dir() / rust_target_triple / rs_build=
_type / rust_hw_dev['output']
> +    crate_metadata =3D {
> +      'name': rust_hw_dev['name'],
> +      'output': [rust_hw_dev['output']],
> +      'output-path': output,
> +      'command': [cargo_wrapper,
> +        '--crate-dir',
> +        meson.current_source_dir() / rust_hw_dev['dirname'],
> +        '--profile',
> +        rs_build_type,
> +        '--target-triple',
> +        rust_target_triple,
> +        '--outdir',
> +        '@OUTDIR@',
> +        'build-lib'

Probably needs to add config-devices.h as well to --config-headers? I
think that we can have just one crate that is built per target,
instead of many small crates like your rust_pl011_cargo. And then that
crate is built many times with a rust/src/ hierarchy that resembles
the meson.build files we use for C.

rust/src/mod.rs:
pub mod hw;

rust/src/hw/mod.rs:
pub mod char;

rust/src/hw/char/mod.rs:
#[cfg(feature =3D "CONFIG_PL011")] pub mod pl011;

(perhaps just src/? And we could even move all sources down one level
to src/ for QEMU as well? But that can be done later, for now it can
be rust/src/). This basically gives Kconfig integration for free if it
works, so I'd ask you to try doing this for the next version?

Also, sooner or later we'll have to tackle building a set of common
dependencies (similar to common_ss), and then bringing those as a
dependency to the build of the per-target crates. Even if we don't get
to the point of building devices once for all targets, I'd rather at
least avoid having to build a dozen times the common deps of
procedural macros.

This is not trivial, but should not be hard either, by using build.rs
(cargo::rustc-link-search) to add the -Ldependency=3D/path/to/rlibs
option to the per-target rustc invocations. This may also require
grabbing the compilation log via "cargo build
--message-format=3Djson-render-diagnostics", but that's not hard to do
in cargo_wrapper.py. And unlike the previous request about Kconfig, it
can be done after the first merge.

> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu-io.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/sysbus.h"
> +#include "exec/memory.h"
> +#include "chardev/char-fe.h"
> +#include "hw/clock.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/irq.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "chardev/char-serial.h"

Please check for any headers included indirectly and whether it's
worth including them here (e.g. it seems that qapi/error.h,
qom/object.h, hw/qdev-core.h should be there).

> diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
> index d338effdaa..a36a4fc86d 100644
> --- a/scripts/cargo_wrapper.py
> +++ b/scripts/cargo_wrapper.py
> @@ -94,6 +94,8 @@ def get_cargo_rustc(args: argparse.Namespace) -> tuple[=
Dict[str, Any], List[str]
>
>      env =3D os.environ
>      env["CARGO_ENCODED_RUSTFLAGS"] =3D cfg
> +    env["MESON_BUILD_DIR"] =3D str(target_dir)
> +    env["MESON_BUILD_ROOT"] =3D str(args.meson_build_root)
>
>      return (env, cargo_cmd)
>
> @@ -164,6 +166,14 @@ def main() -> None:
>          required=3DTrue,
>      )
>      parser.add_argument(
> +        "--meson-build-root",
> +        metavar=3D"BUILD_ROOT",
> +        help=3D"meson.project_build_root()",
> +        type=3Dpathlib.Path,
> +        dest=3D"meson_build_root",
> +        required=3DTrue,
> +    )
> +    parser.add_argument(
>          "--meson-source-dir",
>          metavar=3D"SOURCE_DIR",
>          help=3D"meson.current_source_dir()",

Probably all of cargo_wrapper.py can be moved to this patch.

Paolo


