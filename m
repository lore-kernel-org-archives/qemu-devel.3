Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B008C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpyY-00005v-P9; Mon, 08 Jul 2024 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQpyX-0008Pv-3W
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQpyT-0002L1-0k
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720451296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eY9MCWkV6yN6o5HyeGoiK3mSlh0Xs45sAAGD/A1lF4=;
 b=Hl2PJzRVEd83SNdrw2XIGZg5fTIPqo5a+SYqIgC03lMDzSmNScvVAj3w+rkz8t0VKfFZhr
 WRKfm/8rxLb0pRnK8BUPZd9pQE6wJMwdej614MBN98y3DGU8vEmXVP+Ukh8WsIdWHBnLso
 NzCAEfq77tT7zxo07Hi54A9eml15IiE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-FnuUx5LmPiWmZq40_QW3Fw-1; Mon, 08 Jul 2024 11:08:10 -0400
X-MC-Unique: FnuUx5LmPiWmZq40_QW3Fw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so2484214f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720451289; x=1721056089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eY9MCWkV6yN6o5HyeGoiK3mSlh0Xs45sAAGD/A1lF4=;
 b=hwoe9GJaewgo171SYi3+SxOXiCxYNKHXmsJfpVGGX1lesYwtTSJMbMBTAi2wzAY7Um
 T1j4S/OYmPkUDRKxD5ad7HKaCJ/e+ZtZbeg+qPe1+fIgm66ku+FoohSZCPUvm+eorekm
 KlrsTxD65jSL64X4luMTgQcRdgMi9hcjt74cklunHfPki2oxTDiJrASaOEqamZifTnZD
 qL7t8adDFtaG4nJ3FGcRC46qHZzSbFsBWpSqWaBoGbo4kllDpLe0S1j82GJPHx/U6Lhj
 SSR/3KgOb8xTeb30XOnWqnhRZCOt38dxb3jqQ18y9t2UnyJXudZ7ypH7RTnoLvYO99V1
 zZwA==
X-Gm-Message-State: AOJu0YzRFFoFx2oUUDRpUvfcyXzKNPBKtGQlMnFnDZcoL/vSaK86tpLG
 +uyqb8bnkkvmKhZ+moH78QKkfwkjnYyHPTqm0VjuP55Gyc0pm7xXUPFMYCh8dL7KRzEvWpfzoJJ
 lnvtdTBoIVDJQy+HP3J2p8bo/sZR+BYrnqKuJ7rpMv3VpRoX0UPZa2DZf1gsCmggbY0hfxChHZY
 Uo5I8vo5zMfmDtEhi/MwWm7N15mX8=
X-Received: by 2002:adf:f4ca:0:b0:362:5a6e:2649 with SMTP id
 ffacd0b85a97d-3679de7ca7amr7837840f8f.56.1720451289618; 
 Mon, 08 Jul 2024 08:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd29mWfUctuC4oPF7xcO3umbthgsIjrKIobOTS7KWDfhzTHpEFfeWk6ZcJInPXtNVVHEteOmnkDegSAboJqLo=
X-Received: by 2002:adf:f4ca:0:b0:362:5a6e:2649 with SMTP id
 ffacd0b85a97d-3679de7ca7amr7837826f8f.56.1720451289214; Mon, 08 Jul 2024
 08:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jul 2024 17:07:56 +0200
Message-ID: <CABgObfaScXLEZzZ53CNnZFS_X5krGWP0zRpN1zWVMV38vdqiLg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 4, 2024 at 2:16=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Add mechanism to generate rust hw targets that depend on a custom
> bindgen target for rust bindings to C.
>
> This way bindings will be created before the rust crate is compiled.
>
> The bindings will end up in BUILDDIR/{target}-generated.rs and have the s=
ame name
> as a target:
>
> ninja aarch64-softmmu-generated.rs

Is there anything target-dependent in these files? You can generate it
just once I think.


> +  if with_rust and target_type =3D=3D 'system'
> +       # FIXME: meson outputs the following warnings, which should be re=
solved
> +       # before merging:
> +       # > WARNING: Project specifies a minimum meson_version '>=3D0.63.=
0' but
> +       # > uses features which were added in newer versions:
> +       # > * 0.64.0: {'fs.copyfile'}

you can use configure_file() instead.

> +       # > * 1.0.0: {'dependencies arg in rust.bindgen', 'module rust as=
 stable module'}

You can use

if meson.version().version_compare('>=3D1.0.0')
  ...
else
  error('Rust support requires Meson version 1.0.0')
endif

> +      if target in rust_targets
> +        rust_hw =3D ss.source_set()
> +        foreach t: rust_targets[target]
> +          rust_device_cargo_build =3D custom_target(t['name'],
> +                                       output: t['output'],
> +                                       depends: [bindings_rs],
> +                                       build_always_stale: true,
> +                                       command: t['command'])

Also "console: true".

> +          rust_dep =3D declare_dependency(link_args: [
> +                                          '-Wl,--whole-archive',
> +                                          t['output'],
> +                                          '-Wl,--no-whole-archive'
> +                                          ],

This is not portable, but I think you can use just "link_whole:
rust_device_cargo_build".

> +msrv =3D {
> +  'rustc': '1.77.2',
> +  'cargo': '1.77.2',

I think rustc and cargo are always matching, so no need to check both of th=
em?

> +foreach rust_hw_target, rust_hws: rust_hw_target_list
> +  foreach rust_hw_dev: rust_hws

Finding the available devices should be done using Kconfig symbols,
probably by passing the path to the config-devices.mak file to
build.rs via an environment variable.

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

I think all of these should be target-independent?

> diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
> index d2c7265461..e7d9238c16 100644
> --- a/scripts/cargo_wrapper.py
> +++ b/scripts/cargo_wrapper.py
> @@ -111,6 +111,8 @@ def get_cargo_rustc(args: argparse.Namespace) -> tupl=
e[Dict[str, Any], List[str]
>
>      env =3D os.environ
>      env["CARGO_ENCODED_RUSTFLAGS"] =3D cfg
> +    env["MESON_BUILD_DIR"] =3D str(target_dir)
> +    env["MESON_BUILD_ROOT"] =3D str(args.meson_build_root)
>
>      return (env, cargo_cmd)
>
> @@ -231,19 +233,11 @@ def main() -> None:
>          default=3D[],
>      )
>      parser.add_argument(
> -        "--meson-build-dir",
> -        metavar=3D"BUILD_DIR",
> -        help=3D"meson.current_build_dir()",
> +        "--meson-build-root",
> +        metavar=3D"BUILD_ROOT",
> +        help=3D"meson.project_build_root(): the root build directory. Ex=
ample: '/path/to/qemu/build'",
>          type=3DPath,
> -        dest=3D"meson_build_dir",
> -        required=3DTrue,
> -    )
> -    parser.add_argument(
> -        "--meson-source-dir",
> -        metavar=3D"SOURCE_DIR",
> -        help=3D"meson.current_source_dir()",
> -        type=3DPath,
> -        dest=3D"meson_build_dir",
> +        dest=3D"meson_build_root",
>          required=3DTrue,
>      )
>      parser.add_argument(

Please squash in the previous patch.

Paolo


