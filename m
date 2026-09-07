Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AD6C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3hEq-0005w6-Aa; Mon, 07 Sep 2026 17:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3hEo-0005vq-Fd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 17:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3hEl-0003cS-D7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 17:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788817846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1bXZu3ukZwEduMjwXyjn7XuKyhVQhsO0c28APPnREHU=;
 b=EbdDj0/4wxoaFb9YEdBYFuQ6AiuyRidJOKGDWJxfHfEzLSVNHM8ROeJjq9glDw9vsnl0iF
 E2d4RDkkOqh3iwBJshZMF/d8LyZXwxFsE5jOVI4OKVBFLFbLV3isippXPxaGHNZuk0n/Xn
 24+N4VqYuKbNhLLt4vj0JSZoL0e2LOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-4WCUN2XwMaKZTun0OLFujA-1; Mon,
 07 Sep 2026 17:50:44 -0400
X-MC-Unique: 4WCUN2XwMaKZTun0OLFujA-1
X-Mimecast-MFC-AGG-ID: 4WCUN2XwMaKZTun0OLFujA_1788817843
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1563418009D0; Mon,  7 Sep 2026 21:50:43 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 018921955F06; Mon,  7 Sep 2026 21:50:41 +0000 (UTC)
Message-ID: <1ed52f1a-2231-4d24-a769-813f81d14e97@redhat.com>
Date: Mon, 7 Sep 2026 23:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] agents: Add a skill for finding your way around QEMU
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260904074314.896384-1-pbonzini@redhat.com>
 <apqheL090KYVRRBJ@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <apqheL090KYVRRBJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/26 12:46, Daniel P. Berrangé wrote:
> On Fri, Sep 04, 2026 at 09:43:13AM +0200, Paolo Bonzini wrote:
>> As a side effect, establish scaffolding for the .agents/.claude/.gemini
>> directories, as a base for future patches to build on.
> 
> FWIW, While researching the AGENTS.md stuff I came across this
> 
>    https://arxiv.org/pdf/2602.11988
> 
> which suggests that providing code tree overviews may not be as
> helpful as people suspect, while causing the agents to consume
> more tokens in their work.

I found the... skill creator skill, which suggests: "assume the agent 
can navigate code, keep discovery cheap, and load documentation only 
when it changes a decision."  It does seem like it should be possible to 
shorten this.

Thanks!

Paolo

> It is pretty hard to benchmark / evaluate this, but it does
> suggest the "Finding things" / "Core abstractions" sections
> might be overkill/counterproductive. Aspects that are less
> discoverable or describing QEMU specific policies/practices
> ought to remain valuable.
> 
>>
>> Some parts of this skill are based on
>> https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.
>>
>> Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> v1->v2: add .claude/.gitignore.  Suggest using get_maintainer.pl and ./run.
>>          Fix thinko around build/source directory
>>
>>
>>   .agents/skills/qemu-codebase/SKILL.md | 100 ++++++++++++++++++++++++++
>>   .claude/.gitignore                    |   2 +
>>   .claude/skills                        |   1 +
>>   .gemini/skills                        |   1 +
>>   4 files changed, 104 insertions(+)
>>   create mode 100644 .agents/skills/qemu-codebase/SKILL.md
>>   create mode 100644 .claude/.gitignore
>>   create mode 120000 .claude/skills
>>   create mode 120000 .gemini/skills
>>
>> diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
>> new file mode 100644
>> index 00000000000..17fb55b5289
>> --- /dev/null
>> +++ b/.agents/skills/qemu-codebase/SKILL.md
>> @@ -0,0 +1,100 @@
>> +---
>> +name: qemu-codebase
>> +description: Orientation for QEMU — tree structure, build system, documentation pointers
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
>> +- **linux-user/** and **bsd-user/** are almost entirely separate, and only
>> +  have parts of **hw/core/** and **accel/**'s CPU emulation infrastructure
>> +  in common with system emulation
>> +
>> +Other directories include the back-end subsystems, for example **`block/`**
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
>> +- **Suites**: `make check-unit`, `make check-qtest`, `make check-functional`, `make check-rust`
>> +- **Single Test**: `./run meson test <testname>` (e.g., `./run meson test qtest-x86_64/boot-serial-test`)
>> +- **Debug**: Append `V=1` for verbose output or `DEBUG=1` for interactive test debugging.
>> +
>> +## Code Style
>> +- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
>> +- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
>> +- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
>> +- **C Comments**: Use `/* ... */` only. No `//` comments.
>> +- **Naming**: `snake_case` for variables and functions; `CamelCase` for types and enums.
>> +- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`) APIs. No `malloc`.
>> +- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
>> +- **Lints**: Run `./scripts/checkpatch.pl`.  On top, `make clippy` and `make rustfmt` for Rust.
>> +
>> +# Documentation pointers
>> +
>> +Developer docs live in `docs/devel`.  A `kernel-doc::` directive includes
>> +documentation comments from source files when Sphinx builds the documentation.
>> +These comments be consulted just as easily in the source tree without going
>> +through e.g. `make html`.
>> +
>> +Here are some useful pointers.
>> +
>> +## Core abstractions
>> +
>> +- **QOM** (`qom/`, `include/qom/`) is the type/object system underneath
>> +  everything.  It includes class and interface hierarchies, properties, and
>> +  the object composition tree.  See `docs/devel/qom.rst`.
>> +- **qdev** builds devices on top of QOM, adding for example buses, the
>> +  realize/unrealize lifecycle (including hot-plug/unplug), and reset.  See
>> +  `docs/devel/qdev-api.rst` and `docs/devel/reset.rst`.
>> +- **MemoryRegion** (`system/memory.c`, `include/system/memory.h`) is the
>> +  guest address-space model: regions, aliases, address spaces, dirty tracking,
>> +  load/store and map/unmap operations, etc.  See `docs/devel/memory.rst`.
>> +
>> +## Concurrency
>> +
>> +Getting the threading model wrong is a common source of subtle bugs here.
>> +
>> +- The **BQL** (big QEMU lock) protects most device emulation; vCPU threads
>> +  hold it when exiting to emulation.  See `include/qemu/main-loop.h`.
>> +  Memory regions can (carefully) opt out of the BQL.
>> +- **AioContext**/iothreads: block devices and their virtio front-ends can run
>> +  outside the BQL.  See `docs/devel/multiple-iothreads.rst`.
>> +- The **block layer** is coroutine-based.  `co_` prefixes and `coroutine_fn`
>> +  annotations are advisory but relevant for reviewers.  Coroutines have their
>> +  own locking primitives.
>> +- **RCU** is used for hot, rarely-modified structures such as memory maps.
>> +  Because of the BQL, RCU is mostly used with `call_rcu()` rather than
>> +  `synchronize_rcu()`.  See `docs/devel/rcu.rst` and `docs/devel/atomics.rst`.
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
>> -- 
>> 2.55.0
>>
> 
> With regards,
> Daniel


