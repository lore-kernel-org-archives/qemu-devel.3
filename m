Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BA4C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3pha-00049j-6L; Tue, 08 Sep 2026 02:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3phX-00049S-2W
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:53:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3phU-0004KO-II
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:53:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso36064345e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788850378; x=1789455178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oCvVJPbKrXLQ8F+qzcwxNkXIHuhV99X8g2NsTSjOOZU=;
 b=TxoDAWmmZ22MGwgLa3eUb5bk10uvSDrxlZTIf1eL1h1g/AyqqabdG/UqBEagvLTPax
 aa+6+8pl+cJJLU42eSM4sxacAxwJd2lCBcD69xNOa1JGS6tLowGS3kyl2Fa7G7gDOk70
 s53G/nVYVcRFgjZLPaKvyU3fHoDhoIqkA/uJbJdLCEDJHdkKewUGJLLdxk6w5KiE4MXM
 BZM1B8AcYA6ycEMOYJjSjk9bzcpqgDAS3K5cKtvcgKaC94bE0w0tXRuD4mipyBeqEWj8
 HU/k/s+c5G3ehLFAx8li3Mp8DqQVGeOpPrqcXxU1rHJaPDA2uHShd8MxFwCcyj7f92Av
 eyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788850378; x=1789455178;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oCvVJPbKrXLQ8F+qzcwxNkXIHuhV99X8g2NsTSjOOZU=;
 b=s7s+U6+bITRgr8RqIDzJtJi4uhQGzr1pt4lpqi4cIipHZ7no2FTmyRwHzLljeaFY57
 2aBz3zt6Cs6AdGCsLc9AsCstF1fGLcKUfRPTXuUGb3vDvBIY8NTO/YrNJjwn35PqKbn0
 2las737yhQS7CUq9/LIvR1IaXcN13b1ZV+Td0J3yTmBPbvFgkC4daBMhaM0mjhtiZ+xM
 B+Cg7tOI/V5pyMOhwm70awJVtNWhv55jFUqFsPZJEfujQwQUmUkw+Ji3fYyfEmtvqPFd
 sEWvse35BB5Z3emMUP0nUl+jpgM6bOINgB40iCxB8gLeXXCQ/8+BPGM9k8FGVgh86pKj
 jUTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKtcNTp/qsBApy69eu1GrrXbcid9lGxMUVOV8BJ7sG5PQ8shFCdZla6UtdjeOnAPw5Rcq8vLnnfjQt@nongnu.org
X-Gm-Message-State: AFuF++kWOLMgBpEs11ZtbLl8oBEPBPuVPsVDQ978+gHLJdcrIAxcrnPh
 B/iAosYBfKamT4dfq7VhrYmf6BUGOXJd4UvIpJ3SBVYYPjvGGxHEjtGeO0YYIbeYedo+BZZyITe
 KJsrsDeo=
X-Gm-Gg: AYBFou0AZqtxnW9AIs8+6cbiXyyl/WbpcfZw9pXYKJe1/hnbqcmff2GuDK0ogA7NnGW
 lZ5cWS6JTm/CLJkYKOpjlJMc/j5LYjXGGSJTcd+QKQEWipYmprypoUqG5Iw86DsVk1fHNOs19aq
 VMsO1tzOdVbW8y5epJNBuFyq+vKWtguyEO7eamVUM560dpwzAfpsDSn0tYKzIvC+cWyUUV6uGBv
 OYQ/G1OYrEgUQVqD82RPC9VgeiJmU4xrb0/wKa18bFMhVOihrsGL4cyo+8SxRo3THkCeC/0vb5r
 Dr78lDfi83GC9SOP/X7lNDQSTlGjzYagMVAzrDcSVfI3qcLqFsDbg5TkUhAkjeGCD/00+tvXH3I
 84/+0JJsu5CGT+NZw5O4HolgX1sdyywCPqKLZbSQM2405eq3slD1EFDso61f5Fv47fUIoB1wihe
 Ey+E5EtVe7b3NHPF6n6JeNWQM8sErtlzRwXvX8uZWsGcL2HAbs0MH/1zVDK7AW
X-Received: by 2002:a05:600c:4709:b0:49c:fa21:e748 with SMTP id
 5b1f17b1804b1-49cfa21e99bmr244454495e9.30.1788850377828; 
 Mon, 07 Sep 2026 23:52:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm499070305e9.1.2026.09.07.23.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 23:52:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64FC35F845;
 Tue, 08 Sep 2026 07:52:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] agents: Add a skill for finding your way around QEMU
In-Reply-To: <apqheL090KYVRRBJ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 4 Sep 2026 11:46:16 +0100")
References: <20260904074314.896384-1-pbonzini@redhat.com>
 <apqheL090KYVRRBJ@redhat.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Tue, 08 Sep 2026 07:52:55 +0100
Message-ID: <874ig0b5fc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Sep 04, 2026 at 09:43:13AM +0200, Paolo Bonzini wrote:
>> As a side effect, establish scaffolding for the .agents/.claude/.gemini
>> directories, as a base for future patches to build on.
>
> FWIW, While researching the AGENTS.md stuff I came across this
>
>   https://arxiv.org/pdf/2602.11988
>
> which suggests that providing code tree overviews may not be as
> helpful as people suspect, while causing the agents to consume
> more tokens in their work.
>
> It is pretty hard to benchmark / evaluate this, but it does
> suggest the "Finding things" / "Core abstractions" sections
> might be overkill/counterproductive.

I've been using local rules to try and force using semcode which allows
for a more tied together browsing of the code as well as interrogating
lore instead of lots of shell grepping. But yes it seems the tree
overview doesn't help as much as it could. We could just point to
docs/devel/codebase.rst and let the agent read that if it needs to.=20

> Aspects that are less
> discoverable or describing QEMU specific policies/practices
> ought to remain valuable.
>
>>=20
>> Some parts of this skill are based on
>> https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org=
/.
>>=20
>> Co-authored-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> v1->v2: add .claude/.gitignore.  Suggest using get_maintainer.pl and ./r=
un.
>>         Fix thinko around build/source directory
>>=20
>>=20
>>  .agents/skills/qemu-codebase/SKILL.md | 100 ++++++++++++++++++++++++++
>>  .claude/.gitignore                    |   2 +
>>  .claude/skills                        |   1 +
>>  .gemini/skills                        |   1 +
>>  4 files changed, 104 insertions(+)
>>  create mode 100644 .agents/skills/qemu-codebase/SKILL.md
>>  create mode 100644 .claude/.gitignore
>>  create mode 120000 .claude/skills
>>  create mode 120000 .gemini/skills
>>=20
>> diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu=
-codebase/SKILL.md
>> new file mode 100644
>> index 00000000000..17fb55b5289
>> --- /dev/null
>> +++ b/.agents/skills/qemu-codebase/SKILL.md
>> @@ -0,0 +1,100 @@
>> +---
>> +name: qemu-codebase
>> +description: Orientation for QEMU =E2=80=94 tree structure, build syste=
m, documentation pointers
>> +---
>> +
>> +# Useful reminders for working on QEMU
>> +
>> +## Finding things
>> +
>> +`MAINTAINERS` is the authoritative list of subsystems.  You can
>> +use it and `scripts/get_maintainer.pl --nogit` to query it, for example
>> +
>> +```
>> +$ scripts/get_maintainer.pl --nogit -f block/
>> +```
>> +
>> +`docs/devel/codebase.rst` is a guided tour of every top-level directory.
>> +Here are some important ones:
>> +
>> +- **target/** holds CPU models and the TCG frontends
>> +- **tcg/** holds the backends and the IR. See `docs/devel/tcg.rst`,
>> +  `docs/devel/tcg-ops.rst`.
>> +- **hw/** is devices and boards, categorized by type.
>> +- **linux-user/** and **bsd-user/** are almost entirely separate, and o=
nly
>> +  have parts of **hw/core/** and **accel/**'s CPU emulation infrastruct=
ure
>> +  in common with system emulation
>> +
>> +Other directories include the back-end subsystems, for example **`block=
/`**
>> +for the block layer.
>> +
>> +The `include/` tree mostly mirrors the top-level tree.
>> +
>> +## Build layout
>> +
>> +Build is always out-of-tree; the build directory is created by
>> +`configure` and a checkout can have several. Determine it from context
>> +(`ls */meson-info`) rather than assuming.
>> +
>> +The `run` script in the root of the build dir wraps `meson devenv` and
>> +should be used to execute commands in the build directory.  It activates
>> +the build tree's venv `pyvenv/`, adds various Python modules from
>> +the source tree to `PYTHONPATH`, and defines a `MESON_BUILD_ROOT`
>> +variable for general use.
>> +
>> +`make` at the top level forwards to `ninja` in the configured build
>> +directory, and any `build.ninja` target can be invoked that way.
>> +
>> +## Build & Test
>> +- **Build**: `ninja` or `make -jN` from build directory
>> +- **Test All**: `make check`
>> +- **Suites**: `make check-unit`, `make check-qtest`, `make check-functi=
onal`, `make check-rust`
>> +- **Single Test**: `./run meson test <testname>` (e.g., `./run meson te=
st qtest-x86_64/boot-serial-test`)
>> +- **Debug**: Append `V=3D1` for verbose output or `DEBUG=3D1` for inter=
active test debugging.
>> +
>> +## Code Style
>> +- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100=
).
>> +- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on =
same line (except functions).
>> +- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include i=
n every `.c` file.
>> +- **C Comments**: Use `/* ... */` only. No `//` comments.
>> +- **Naming**: `snake_case` for variables and functions; `CamelCase` for=
 types and enums.
>> +- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`q=
emu_memalign`) APIs. No `malloc`.
>> +- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` fo=
r errors.
>> +- **Lints**: Run `./scripts/checkpatch.pl`.  On top, `make clippy` and =
`make rustfmt` for Rust.
>> +
>> +# Documentation pointers
>> +
>> +Developer docs live in `docs/devel`.  A `kernel-doc::` directive includ=
es
>> +documentation comments from source files when Sphinx builds the documen=
tation.
>> +These comments be consulted just as easily in the source tree without g=
oing
>> +through e.g. `make html`.
>> +
>> +Here are some useful pointers.
>> +
>> +## Core abstractions
>> +
>> +- **QOM** (`qom/`, `include/qom/`) is the type/object system underneath
>> +  everything.  It includes class and interface hierarchies, properties,=
 and
>> +  the object composition tree.  See `docs/devel/qom.rst`.
>> +- **qdev** builds devices on top of QOM, adding for example buses, the
>> +  realize/unrealize lifecycle (including hot-plug/unplug), and reset.  =
See
>> +  `docs/devel/qdev-api.rst` and `docs/devel/reset.rst`.
>> +- **MemoryRegion** (`system/memory.c`, `include/system/memory.h`) is the
>> +  guest address-space model: regions, aliases, address spaces, dirty tr=
acking,
>> +  load/store and map/unmap operations, etc.  See `docs/devel/memory.rst=
`.
>> +
>> +## Concurrency
>> +
>> +Getting the threading model wrong is a common source of subtle bugs her=
e.
>> +
>> +- The **BQL** (big QEMU lock) protects most device emulation; vCPU thre=
ads
>> +  hold it when exiting to emulation.  See `include/qemu/main-loop.h`.
>> +  Memory regions can (carefully) opt out of the BQL.
>> +- **AioContext**/iothreads: block devices and their virtio front-ends c=
an run
>> +  outside the BQL.  See `docs/devel/multiple-iothreads.rst`.
>> +- The **block layer** is coroutine-based.  `co_` prefixes and `coroutin=
e_fn`
>> +  annotations are advisory but relevant for reviewers.  Coroutines have=
 their
>> +  own locking primitives.
>> +- **RCU** is used for hot, rarely-modified structures such as memory ma=
ps.
>> +  Because of the BQL, RCU is mostly used with `call_rcu()` rather than
>> +  `synchronize_rcu()`.  See `docs/devel/rcu.rst` and `docs/devel/atomic=
s.rst`.
>> diff --git a/.claude/.gitignore b/.claude/.gitignore
>> new file mode 100644
>> index 00000000000..b0a57a19c01
>> --- /dev/null
>> +++ b/.claude/.gitignore
>> @@ -0,0 +1,2 @@
>> +# reserved for the user to add their own per-project rules
>> +/CLAUDE.md
>> diff --git a/.claude/skills b/.claude/skills
>> new file mode 120000
>> index 00000000000..a7540c24423
>> --- /dev/null
>> +++ b/.claude/skills
>> @@ -0,0 +1 @@
>> +.agents/skills/
>> \ No newline at end of file
>> diff --git a/.gemini/skills b/.gemini/skills
>> new file mode 120000
>> index 00000000000..a7540c24423
>> --- /dev/null
>> +++ b/.gemini/skills
>> @@ -0,0 +1 @@
>> +.agents/skills/
>> \ No newline at end of file
>> --=20
>> 2.55.0
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

