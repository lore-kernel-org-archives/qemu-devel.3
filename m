Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415A2FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn1j-0000gW-6Q; Fri, 02 Jan 2026 16:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbn1f-0000bV-4q
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:49:39 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbn1d-0000S2-3n
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:49:38 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so12265962b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390575; x=1767995375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jBF2uGAd4xll6H3AZatvPd3p+Oc+8ihKdUIVVV1/B4c=;
 b=vLi9b0NSOn6KME9AdGhAnVNzBzSxTxKh6bIUOKHJ/+gvMQW/yWLW9sRxxY92cLwY1u
 cPtMQLJ54tBNT8huQdqTJxMHyJFBZrH+mMvZpwB/8owq6kCrqigu7PEA4XptXuv5i2Pc
 qKiq/kevXC5TdUJr1elUQp09Zh8pUDtbWgZEMQvN70cqu1bkxBzjCiGd0+BlIcPrQBBj
 5SLrceue4gdLRttaBV57buBHscfQR8skoSbdIvcyHtL7vknr0qhhYPk5JQQDwKGWidjx
 2KNAzTncTHQReue5WBllLMn/yOI4l7uXp2MKdyg89vccuKNEP4kOHtgSb3uxM9pxJd+s
 L1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390575; x=1767995375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBF2uGAd4xll6H3AZatvPd3p+Oc+8ihKdUIVVV1/B4c=;
 b=jLfyT4YUYa2AYE44T5Gur1MFkMqNAFB22gn/yqDOYhqLFbnECk3tlH0mOmL2+nrbeR
 py3QzYXJ4XIc8VoAESI70ZGLnZVhNm1J3fCRW7GLCfZFzfP1N3bdL+ktXNAm6xpAWmDV
 ccPQHu9e5OKVhvJpbpW/TVtcNDJzy3kAoBEgcbC5WzsMrV8m6njO/H+mcDtcPbh0fErN
 M9XFeR5lM+7aC3VhKgK1aBMUOymoP8xUw7joEv/H5WOvsFU7sylO5dGN5gS/cOetSd11
 xNJQ8bKdNqiyEFrqBCNPffFRz6vj+/PVm85ZOuKpuolWIIXsmgIncVTBQ19v1++fK70r
 5TWw==
X-Gm-Message-State: AOJu0YzMMN7T4aHNMP/UKSa6hq1IEx9A/SYTnx0bXCrZ6ZSkiOiFdOWv
 e1cTIPtREloEZubfswXuCG48DCjeorrWq2NHUDWT1X+EogL4EMqk5LxTZqj3gEGKHBSo8YkeWNG
 6ECOX
X-Gm-Gg: AY/fxX4rV2PrcdRZpcP/NgIW1N3p2DEsFYULuTGQmhdZupsv6ldD/s8XjNegjkf47fP
 EaFXxYWMDJdtDE9U9rpfCBRVTT4N69U8xjCHBCjYHGyLnCo6Wk71tHpBFiQr1jsIXt0sJj2sx4D
 8PenfHBHqiytl7N8D/5RZuAfVfWSlY6gy9VCtcqEjwwfuzJzbfHTKWRQAm9+cXlVFOikq0jZ7DM
 NycvdLsjYF/f/bqmGHcbWZlrSUPH/AkS/8IMce1Abljw6T/wZxY02XN6wsp1OPnYix/oGa//1n6
 Ia0wapvc+4hvNWcyqXvMy7q2a5E4RZlJdZyvb/4sIqdePBJV5HHC9UP8deFODdhB4uNFfubErwS
 XA/ljdal6TxKPGmqakErBVF8fSfkRAW0fMIgR1cmbkR+1dQvTYNpyBMTEUQZsVoMmZsD3Kp4438
 /vEGunxKwFlU9KJaMX7HiAtBYiiaCT9/zjPW1xkEelRq6KtHK0hbS2cYjwoB0b/gQOHfc=
X-Google-Smtp-Source: AGHT+IGM583ogQQkCrOWQShgproJEHsm6Cf1Q9HAH0v0nItXCCpR/cFPiGj5hliJsQLkx10usnRgXA==
X-Received: by 2002:a05:6a20:3ca2:b0:34f:ec81:bc3d with SMTP id
 adf61e73a8af0-376aa1f7e23mr40391361637.44.1767390575383; 
 Fri, 02 Jan 2026 13:49:35 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c2e20a646e8sm21219772a12.11.2026.01.02.13.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 13:49:34 -0800 (PST)
Message-ID: <1e24cfca-3e5a-442c-b02a-05ce2e48511e@linaro.org>
Date: Fri, 2 Jan 2026 13:49:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] plugins: enable C++ plugins
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 12/30/25 11:33 PM, Pierrick Bouvier wrote:
> Writing plugins in C can be sometimes tedious, especially when using Glib to
> keep track of execution state. We can directly use the same C API but write our
> plugin in C++, benefiting from its great standard library offering strings,
> smart pointers, data structures and synchronization mechanisms.
> 
> It's common for downstream QEMU forks to provide C++ for plugins, like this:
> - https://github.com/panda-re/panda/tree/dev/panda/plugins
> - https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin
> 
> Hopefully this will help more people to use upstream QEMU, and as a benefit, get
> their contribution back and help to develop plugins ecosystem upstream directly.
> 
> This series first cleans up build system for plugins, factorizing details
> between contrib/plugins and tests/tcg/plugins folders.
> Then, we perform codebase cleanups to fix conflicts between existing headers
> and C++ headers.
> After that, we can update the C++ standard used by QEMU, to benefit fully
> from latest updates of the language.
> Finally, we define an empty C++ plugin, making sure we can keep track of
> possible regression in qemu-plugin header.
> 
> Note: This series is *not* a trojan horse to bring C++ in QEMU
> codebase, nor to define an alternative C++ API for plugins. It's just enabling
> more users to get the most out of existing C plugin API.
> 
> CI: https://gitlab.com/pbo-linaro/qemu/-/pipelines/2239199381
> 
> Pierrick Bouvier (11):
>    plugins: move win32_linker.c file to plugins directory
>    plugins: factorize plugin dependencies and library details
>    plugins: use complete filename for defining plugins sources
>    plugins: define plugin API symbols as extern "C" when compiling in C++
>    include: qemu/ctype.h -> qemu/qemu-ctype.h
>    include: qemu/coroutine.h -> qemu/qemu-coroutine.h
>    meson: fix supported compiler arguments in other languages than C
>    meson: enable cpp (optionally) for plugins
>    qga/vss-win32: fix clang warning with C++20
>    meson: update C++ standard to C++23
>    contrib/plugins: add empty cpp plugin
> 
>   meson.build                                   |  24 ++--
>   block/parallels.h                             |   2 +-
>   block/qcow2.h                                 |   2 +-
>   fsdev/qemu-fsdev-throttle.h                   |   2 +-
>   hw/9pfs/9p.h                                  |   2 +-
>   include/block/block-global-state.h            |   2 +-
>   include/block/block-hmp-cmds.h                |   2 +-
>   include/block/block-io.h                      |   2 +-
>   include/block/reqlist.h                       |   2 +-
>   include/block/throttle-groups.h               |   2 +-
>   include/qemu/coroutine_int.h                  |   2 +-
>   include/qemu/job.h                            |   2 +-
>   .../qemu/{coroutine.h => qemu-coroutine.h}    |   0
>   include/qemu/{ctype.h => qemu-ctype.h}        |   0
>   include/qemu/qemu-plugin.h                    |   8 ++
>   migration/migration.h                         |   2 +-
>   ui/console-priv.h                             |   2 +-
>   block.c                                       |   2 +-
>   block/block-copy.c                            |   2 +-
>   block/io_uring.c                              |   2 +-
>   block/linux-aio.c                             |   2 +-
>   block/mirror.c                                |   2 +-
>   block/progress_meter.c                        |   2 +-
>   block/ssh.c                                   |   2 +-
>   block/vdi.c                                   |   2 +-
>   block/vvfat.c                                 |   2 +-
>   chardev/char.c                                |   2 +-
>   gdbstub/gdbstub.c                             |   2 +-
>   hw/9pfs/coth.c                                |   2 +-
>   hw/block/virtio-blk.c                         |   2 +-
>   hw/core/bus.c                                 |   2 +-
>   hw/core/qdev-properties-system.c              |   2 +-
>   hw/core/qdev-properties.c                     |   2 +-
>   hw/hyperv/syndbg.c                            |   2 +-
>   hw/nvme/nguid.c                               |   2 +-
>   hw/s390x/ccw-device.c                         |   2 +-
>   hw/s390x/ipl.c                                |   2 +-
>   hw/s390x/s390-virtio-ccw.c                    |   2 +-
>   hw/scsi/scsi-generic.c                        |   2 +-
>   migration/migration.c                         |   2 +-
>   migration/rdma.c                              |   2 +-
>   monitor/fds.c                                 |   2 +-
>   monitor/hmp.c                                 |   2 +-
>   nbd/client-connection.c                       |   2 +-
>   net/colo-compare.c                            |   2 +-
>   net/net.c                                     |   2 +-
>   net/tap-solaris.c                             |   2 +-
>   {contrib/plugins => plugins}/win32_linker.c   |   0
>   qapi/qapi-util.c                              |   2 +-
>   qapi/qmp-dispatch.c                           |   2 +-
>   qobject/json-parser.c                         |   2 +-
>   target/ppc/ppc-qmp-cmds.c                     |   2 +-
>   target/riscv/cpu.c                            |   2 +-
>   target/riscv/riscv-qmp-cmds.c                 |   2 +-
>   tests/qtest/libqtest.c                        |   2 +-
>   tests/qtest/migration/migration-util.c        |   2 +-
>   tests/unit/test-aio-multithread.c             |   2 +-
>   tests/vhost-user-bridge.c                     |   2 +-
>   ui/console.c                                  |   2 +-
>   ui/keymaps.c                                  |   2 +-
>   ui/ui-qmp-cmds.c                              |   2 +-
>   util/cutils.c                                 |   2 +-
>   util/id.c                                     |   2 +-
>   util/qemu-co-shared-resource.c                |   2 +-
>   util/qemu-co-timeout.c                        |   2 +-
>   util/qemu-coroutine-io.c                      |   2 +-
>   util/readline.c                               |   2 +-
>   util/thread-pool.c                            |   2 +-
>   contrib/plugins/cpp.cpp                       | 119 ++++++++++++++++++
>   contrib/plugins/meson.build                   |  25 ++--
>   plugins/meson.build                           |  15 ++-
>   qga/vss-win32/requester.cpp                   |   6 +-
>   tests/tcg/plugins/meson.build                 |  18 +--
>   73 files changed, 237 insertions(+), 104 deletions(-)
>   rename include/qemu/{coroutine.h => qemu-coroutine.h} (100%)
>   rename include/qemu/{ctype.h => qemu-ctype.h} (100%)
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)
>   create mode 100644 contrib/plugins/cpp.cpp
> 

v2 sent:
https://lore.kernel.org/qemu-devel/20260102214724.4128196-1-pierrick.bouvier@linaro.org/T/#t

