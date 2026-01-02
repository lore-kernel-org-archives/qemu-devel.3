Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFBAEEE25C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 10:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbcV3-00050G-A6; Fri, 02 Jan 2026 05:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcV1-0004zm-VX
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:35:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcUz-0005yo-M9
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:35:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so7058208f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 02:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767350111; x=1767954911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hdt/lzR4u4ucmiMgea+EAUFxClBR4AH7k7WvIJUFIE4=;
 b=tou35Laq1GYZRaN4JDzjObFhaklqX+bHjevW42J+lzs8I/nQ00kc3VqUGiFojCbDGV
 UUXOpXeuyl4pzfVqEnzx7kZ+XdLZ8oelYvAptLZQn92m62fgBy9k6d/z4+97HcAScus5
 xCenQWM6srK/vbIALZ5PVndLAja3KzY3FUoJPr2QwIQWKQknGnYFx1GT8+0Nq3ujGJE4
 WBg+AWl5bHL/KFFrMrbK7hVZbOBvH+OlzZF+TigdTRVnmGK7Gjavi3mY7R9Oo3n/OQdV
 hXcfUVNYvCUpXP9mSuBSlDAgZt1AEFsugh9isojdiLY3/Z6bOdPq0ev1gr0XhYYXUkU5
 FohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767350111; x=1767954911;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdt/lzR4u4ucmiMgea+EAUFxClBR4AH7k7WvIJUFIE4=;
 b=qJaQZpouRvzEkIi5XRLwuG+/uoxi8uQRJ5gOHn5Sp/EdYrYK8+2iNpUzNb9TZMhBdO
 k9dZFCQTA4anrOLYoNgbGvPYW0y4Pgc1cfvP6KJbGc7jgmYTSFJUgtcrglboDHjA+vPI
 kFmeHshwTuAlScuATNt7iGzql8QfTjmu6rbSPGQ64gqVrk6VyZuSz07H6uAAtwePjDs3
 7ym4sRikpncJywsTA7BjoHgMsaVyhFky9YjCzTMrtR3RmZVyvM/d6yJ9k1nkxtMmw4W4
 JfFiIQR5H/MCAkwQBpsJoyhNSu4cNFuhyN+i9VkcYyUaFoGahQDTNDp1lSXGzGSpNway
 dm6g==
X-Gm-Message-State: AOJu0YwY/QfzJre3x51svBhUsv2tDUqhTpLoV012lD73xZgO3LNUdobu
 J3P3iUme8lDb2yJ/TIZNJGBSOgappOTPDWL5W+nv8kgKyrvoqn6xivgl0LrUN+M/iqs=
X-Gm-Gg: AY/fxX5+9l1SDM7ThRxBSp4mXyc0hkoY/13tgjhD0SQAOK/qQnrxpWPBUG1VxjJjkRK
 FkM/TQtJYHUFFtbtO+hozTYkHjzrZX70NoEH6ADx+hIzsGPCRX0GUEyT+Ln09F1uKoWQHM7cWZE
 7K05ntM1D94GRKqwHNTXJnNMmD0O7Nrk/LrNQ3jdkA/f42yQF6ymi2vrfhsl2fOLmviF0PDiyxF
 f/8SFULqbmNKek7gIc3jsSkOcsQ2KDB581BEr+CaJRGEIsnywtIOgwVEa0SDpdxBqGEQ7FucHJZ
 G0ORYMAwMzfZ98aDaHQCOjpCevifubl+/ACsc1rggfiA5WenTKj9VM58cProS7N4DLSopAzMTLi
 HZewzd+DvORz/LOrLL9goprBDp/849WGK7ovUvdTzX864l/MZ/N2DGiLsYNmWj0ff6j5IP/iQJZ
 UNikcuc/FDN1g=
X-Google-Smtp-Source: AGHT+IG1FpO+sA1pIY8wtvz5i13nNYHJmqj9JI18TnDssszJ8ZePX5+BLNkc2Zgm26vwDm+dqA4IsQ==
X-Received: by 2002:a5d:5c89:0:b0:431:38f:8bc4 with SMTP id
 ffacd0b85a97d-4324e70d84emr55077688f8f.61.1767350110868; 
 Fri, 02 Jan 2026 02:35:10 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b0efefsm50946512f8f.25.2026.01.02.02.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 02:35:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8635B5F7FE;
 Fri, 02 Jan 2026 10:35:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Gustavo
 Bueno Romero <gustavo.romero@linaro.org>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, rowan Hart
 <rowanbhart@gmail.com>
Subject: Re: [PATCH 00/11] plugins: enable C++ plugins
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 30 Dec 2025 23:33:50 -0800")
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 10:35:09 +0000
Message-ID: <87h5t4xpya.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Writing plugins in C can be sometimes tedious, especially when using Glib=
 to
> keep track of execution state. We can directly use the same C API but wri=
te our
> plugin in C++, benefiting from its great standard library offering string=
s,
> smart pointers, data structures and synchronization mechanisms.
>
> It's common for downstream QEMU forks to provide C++ for plugins, like th=
is:
> - https://github.com/panda-re/panda/tree/dev/panda/plugins
> - https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin
>
> Hopefully this will help more people to use upstream QEMU, and as a benef=
it, get
> their contribution back and help to develop plugins ecosystem upstream di=
rectly.
>
> This series first cleans up build system for plugins, factorizing details
> between contrib/plugins and tests/tcg/plugins folders.
> Then, we perform codebase cleanups to fix conflicts between existing head=
ers
> and C++ headers.
> After that, we can update the C++ standard used by QEMU, to benefit fully
> from latest updates of the language.
> Finally, we define an empty C++ plugin, making sure we can keep track of
> possible regression in qemu-plugin header.
>
> Note: This series is *not* a trojan horse to bring C++ in QEMU
> codebase, nor to define an alternative C++ API for plugins. It's just ena=
bling
> more users to get the most out of existing C plugin API.

I don't have any fundamental objection to allowing this - as you say it
keep the existing API and just makes it easier for the plugin authors to
use C++.

It would be interesting to see if there are any other changes that would
also be useful for other language bindings. I suspect the most relevant
would be Rust bindings for the plugins.

>
> CI: https://gitlab.com/pbo-linaro/qemu/-/pipelines/2239199381
>
> Pierrick Bouvier (11):
>   plugins: move win32_linker.c file to plugins directory
>   plugins: factorize plugin dependencies and library details
>   plugins: use complete filename for defining plugins sources
>   plugins: define plugin API symbols as extern "C" when compiling in C++
>   include: qemu/ctype.h -> qemu/qemu-ctype.h
>   include: qemu/coroutine.h -> qemu/qemu-coroutine.h
>   meson: fix supported compiler arguments in other languages than C
>   meson: enable cpp (optionally) for plugins
>   qga/vss-win32: fix clang warning with C++20
>   meson: update C++ standard to C++23
>   contrib/plugins: add empty cpp plugin
>
>  meson.build                                   |  24 ++--
>  block/parallels.h                             |   2 +-
>  block/qcow2.h                                 |   2 +-
>  fsdev/qemu-fsdev-throttle.h                   |   2 +-
>  hw/9pfs/9p.h                                  |   2 +-
>  include/block/block-global-state.h            |   2 +-
>  include/block/block-hmp-cmds.h                |   2 +-
>  include/block/block-io.h                      |   2 +-
>  include/block/reqlist.h                       |   2 +-
>  include/block/throttle-groups.h               |   2 +-
>  include/qemu/coroutine_int.h                  |   2 +-
>  include/qemu/job.h                            |   2 +-
>  .../qemu/{coroutine.h =3D> qemu-coroutine.h}    |   0
>  include/qemu/{ctype.h =3D> qemu-ctype.h}        |   0
>  include/qemu/qemu-plugin.h                    |   8 ++
>  migration/migration.h                         |   2 +-
>  ui/console-priv.h                             |   2 +-
>  block.c                                       |   2 +-
>  block/block-copy.c                            |   2 +-
>  block/io_uring.c                              |   2 +-
>  block/linux-aio.c                             |   2 +-
>  block/mirror.c                                |   2 +-
>  block/progress_meter.c                        |   2 +-
>  block/ssh.c                                   |   2 +-
>  block/vdi.c                                   |   2 +-
>  block/vvfat.c                                 |   2 +-
>  chardev/char.c                                |   2 +-
>  gdbstub/gdbstub.c                             |   2 +-
>  hw/9pfs/coth.c                                |   2 +-
>  hw/block/virtio-blk.c                         |   2 +-
>  hw/core/bus.c                                 |   2 +-
>  hw/core/qdev-properties-system.c              |   2 +-
>  hw/core/qdev-properties.c                     |   2 +-
>  hw/hyperv/syndbg.c                            |   2 +-
>  hw/nvme/nguid.c                               |   2 +-
>  hw/s390x/ccw-device.c                         |   2 +-
>  hw/s390x/ipl.c                                |   2 +-
>  hw/s390x/s390-virtio-ccw.c                    |   2 +-
>  hw/scsi/scsi-generic.c                        |   2 +-
>  migration/migration.c                         |   2 +-
>  migration/rdma.c                              |   2 +-
>  monitor/fds.c                                 |   2 +-
>  monitor/hmp.c                                 |   2 +-
>  nbd/client-connection.c                       |   2 +-
>  net/colo-compare.c                            |   2 +-
>  net/net.c                                     |   2 +-
>  net/tap-solaris.c                             |   2 +-
>  {contrib/plugins =3D> plugins}/win32_linker.c   |   0
>  qapi/qapi-util.c                              |   2 +-
>  qapi/qmp-dispatch.c                           |   2 +-
>  qobject/json-parser.c                         |   2 +-
>  target/ppc/ppc-qmp-cmds.c                     |   2 +-
>  target/riscv/cpu.c                            |   2 +-
>  target/riscv/riscv-qmp-cmds.c                 |   2 +-
>  tests/qtest/libqtest.c                        |   2 +-
>  tests/qtest/migration/migration-util.c        |   2 +-
>  tests/unit/test-aio-multithread.c             |   2 +-
>  tests/vhost-user-bridge.c                     |   2 +-
>  ui/console.c                                  |   2 +-
>  ui/keymaps.c                                  |   2 +-
>  ui/ui-qmp-cmds.c                              |   2 +-
>  util/cutils.c                                 |   2 +-
>  util/id.c                                     |   2 +-
>  util/qemu-co-shared-resource.c                |   2 +-
>  util/qemu-co-timeout.c                        |   2 +-
>  util/qemu-coroutine-io.c                      |   2 +-
>  util/readline.c                               |   2 +-
>  util/thread-pool.c                            |   2 +-
>  contrib/plugins/cpp.cpp                       | 119 ++++++++++++++++++
>  contrib/plugins/meson.build                   |  25 ++--
>  plugins/meson.build                           |  15 ++-
>  qga/vss-win32/requester.cpp                   |   6 +-
>  tests/tcg/plugins/meson.build                 |  18 +--
>  73 files changed, 237 insertions(+), 104 deletions(-)
>  rename include/qemu/{coroutine.h =3D> qemu-coroutine.h} (100%)
>  rename include/qemu/{ctype.h =3D> qemu-ctype.h} (100%)
>  rename {contrib/plugins =3D> plugins}/win32_linker.c (100%)
>  create mode 100644 contrib/plugins/cpp.cpp

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

