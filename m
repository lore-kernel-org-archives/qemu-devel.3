Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682AFC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RRK-0000xi-Lt; Fri, 04 Sep 2026 06:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2RRG-0000xN-NR
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2RRD-0005PP-Cm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788518786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/L54A0BcIdi7suCwcMMStxRoFCIL1YsK2dQuithByI=;
 b=ZH9bPKQtzHelMP05i3jlAS8hHMbwm0cFaNGzezcOy1MQky25a6DZEVtS1/Or9835JjEEsZ
 cEFDQLkvA8LG7SVf4xhSetFp7gAQBeQC5O/BQohbXN2cidSasFTxO9z4AZvJW15brdz+fA
 oMCcPIWCBMIpKsdCjrySrq0ibY5Cd4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-gJZZHO_nN0mIw67e877lxA-1; Fri,
 04 Sep 2026 06:46:22 -0400
X-MC-Unique: gJZZHO_nN0mIw67e877lxA-1
X-Mimecast-MFC-AGG-ID: gJZZHO_nN0mIw67e877lxA_1788518781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F234E1953954; Fri,  4 Sep 2026 10:46:20 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E62851955F10; Fri,  4 Sep 2026 10:46:19 +0000 (UTC)
Date: Fri, 4 Sep 2026 11:46:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] agents: Add a skill for finding your way around QEMU
Message-ID: <apqheL090KYVRRBJ@redhat.com>
References: <20260904074314.896384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904074314.896384-1-pbonzini@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 04, 2026 at 09:43:13AM +0200, Paolo Bonzini wrote:
> As a side effect, establish scaffolding for the .agents/.claude/.gemini
> directories, as a base for future patches to build on.

FWIW, While researching the AGENTS.md stuff I came across this

  https://arxiv.org/pdf/2602.11988

which suggests that providing code tree overviews may not be as
helpful as people suspect, while causing the agents to consume
more tokens in their work.

It is pretty hard to benchmark / evaluate this, but it does
suggest the "Finding things" / "Core abstractions" sections
might be overkill/counterproductive. Aspects that are less
discoverable or describing QEMU specific policies/practices
ought to remain valuable.

> 
> Some parts of this skill are based on
> https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.
> 
> Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: add .claude/.gitignore.  Suggest using get_maintainer.pl and ./run.
>         Fix thinko around build/source directory
> 
> 
>  .agents/skills/qemu-codebase/SKILL.md | 100 ++++++++++++++++++++++++++
>  .claude/.gitignore                    |   2 +
>  .claude/skills                        |   1 +
>  .gemini/skills                        |   1 +
>  4 files changed, 104 insertions(+)
>  create mode 100644 .agents/skills/qemu-codebase/SKILL.md
>  create mode 100644 .claude/.gitignore
>  create mode 120000 .claude/skills
>  create mode 120000 .gemini/skills
> 
> diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
> new file mode 100644
> index 00000000000..17fb55b5289
> --- /dev/null
> +++ b/.agents/skills/qemu-codebase/SKILL.md
> @@ -0,0 +1,100 @@
> +---
> +name: qemu-codebase
> +description: Orientation for QEMU — tree structure, build system, documentation pointers
> +---
> +
> +# Useful reminders for working on QEMU
> +
> +## Finding things
> +
> +`MAINTAINERS` is the authoritative list of subsystems.  You can
> +use it and `scripts/get_maintainer.pl --nogit` to query it, for example
> +
> +```
> +$ scripts/get_maintainer.pl --nogit -f block/
> +```
> +
> +`docs/devel/codebase.rst` is a guided tour of every top-level directory.
> +Here are some important ones:
> +
> +- **target/** holds CPU models and the TCG frontends
> +- **tcg/** holds the backends and the IR. See `docs/devel/tcg.rst`,
> +  `docs/devel/tcg-ops.rst`.
> +- **hw/** is devices and boards, categorized by type.
> +- **linux-user/** and **bsd-user/** are almost entirely separate, and only
> +  have parts of **hw/core/** and **accel/**'s CPU emulation infrastructure
> +  in common with system emulation
> +
> +Other directories include the back-end subsystems, for example **`block/`**
> +for the block layer.
> +
> +The `include/` tree mostly mirrors the top-level tree.
> +
> +## Build layout
> +
> +Build is always out-of-tree; the build directory is created by
> +`configure` and a checkout can have several. Determine it from context
> +(`ls */meson-info`) rather than assuming.
> +
> +The `run` script in the root of the build dir wraps `meson devenv` and
> +should be used to execute commands in the build directory.  It activates
> +the build tree's venv `pyvenv/`, adds various Python modules from
> +the source tree to `PYTHONPATH`, and defines a `MESON_BUILD_ROOT`
> +variable for general use.
> +
> +`make` at the top level forwards to `ninja` in the configured build
> +directory, and any `build.ninja` target can be invoked that way.
> +
> +## Build & Test
> +- **Build**: `ninja` or `make -jN` from build directory
> +- **Test All**: `make check`
> +- **Suites**: `make check-unit`, `make check-qtest`, `make check-functional`, `make check-rust`
> +- **Single Test**: `./run meson test <testname>` (e.g., `./run meson test qtest-x86_64/boot-serial-test`)
> +- **Debug**: Append `V=1` for verbose output or `DEBUG=1` for interactive test debugging.
> +
> +## Code Style
> +- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
> +- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
> +- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
> +- **C Comments**: Use `/* ... */` only. No `//` comments.
> +- **Naming**: `snake_case` for variables and functions; `CamelCase` for types and enums.
> +- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`) APIs. No `malloc`.
> +- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
> +- **Lints**: Run `./scripts/checkpatch.pl`.  On top, `make clippy` and `make rustfmt` for Rust.
> +
> +# Documentation pointers
> +
> +Developer docs live in `docs/devel`.  A `kernel-doc::` directive includes
> +documentation comments from source files when Sphinx builds the documentation.
> +These comments be consulted just as easily in the source tree without going
> +through e.g. `make html`.
> +
> +Here are some useful pointers.
> +
> +## Core abstractions
> +
> +- **QOM** (`qom/`, `include/qom/`) is the type/object system underneath
> +  everything.  It includes class and interface hierarchies, properties, and
> +  the object composition tree.  See `docs/devel/qom.rst`.
> +- **qdev** builds devices on top of QOM, adding for example buses, the
> +  realize/unrealize lifecycle (including hot-plug/unplug), and reset.  See
> +  `docs/devel/qdev-api.rst` and `docs/devel/reset.rst`.
> +- **MemoryRegion** (`system/memory.c`, `include/system/memory.h`) is the
> +  guest address-space model: regions, aliases, address spaces, dirty tracking,
> +  load/store and map/unmap operations, etc.  See `docs/devel/memory.rst`.
> +
> +## Concurrency
> +
> +Getting the threading model wrong is a common source of subtle bugs here.
> +
> +- The **BQL** (big QEMU lock) protects most device emulation; vCPU threads
> +  hold it when exiting to emulation.  See `include/qemu/main-loop.h`.
> +  Memory regions can (carefully) opt out of the BQL.
> +- **AioContext**/iothreads: block devices and their virtio front-ends can run
> +  outside the BQL.  See `docs/devel/multiple-iothreads.rst`.
> +- The **block layer** is coroutine-based.  `co_` prefixes and `coroutine_fn`
> +  annotations are advisory but relevant for reviewers.  Coroutines have their
> +  own locking primitives.
> +- **RCU** is used for hot, rarely-modified structures such as memory maps.
> +  Because of the BQL, RCU is mostly used with `call_rcu()` rather than
> +  `synchronize_rcu()`.  See `docs/devel/rcu.rst` and `docs/devel/atomics.rst`.
> diff --git a/.claude/.gitignore b/.claude/.gitignore
> new file mode 100644
> index 00000000000..b0a57a19c01
> --- /dev/null
> +++ b/.claude/.gitignore
> @@ -0,0 +1,2 @@
> +# reserved for the user to add their own per-project rules
> +/CLAUDE.md
> diff --git a/.claude/skills b/.claude/skills
> new file mode 120000
> index 00000000000..a7540c24423
> --- /dev/null
> +++ b/.claude/skills
> @@ -0,0 +1 @@
> +.agents/skills/
> \ No newline at end of file
> diff --git a/.gemini/skills b/.gemini/skills
> new file mode 120000
> index 00000000000..a7540c24423
> --- /dev/null
> +++ b/.gemini/skills
> @@ -0,0 +1 @@
> +.agents/skills/
> \ No newline at end of file
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


