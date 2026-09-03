Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0982C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22Uv-0002EH-7K; Thu, 03 Sep 2026 04:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x22Ut-0002Dv-OJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x22Ur-0007bA-Fx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788422909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2S6Q1bJ1iqfLXB/3gt6tK2IFdwX7GZCXbEXUDvPd03g=;
 b=E3IOxIKo25lPLD2NBzmvt3TCAjKwTFw1+gDmVtnOfUKy9piE/W0wZWNUMghceA+r0vR9+R
 P5GZ8UPri5vQzZ5YQvzoiEQ4F3PjeaOH6YPc7/Ue6abKKaiGtQbk+ZZud76goC6R7v7d7Z
 QYyHeDzvGWnalX4athfNsMezsrhObOA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-L7Rg8aYEN3e5H2Z8Npkfhg-1; Thu,
 03 Sep 2026 04:08:27 -0400
X-MC-Unique: L7Rg8aYEN3e5H2Z8Npkfhg-1
X-Mimecast-MFC-AGG-ID: L7Rg8aYEN3e5H2Z8Npkfhg_1788422907
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8E7A191FCE5; Thu,  3 Sep 2026 08:08:26 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A28BA18005BD; Thu,  3 Sep 2026 08:08:25 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:08:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] agents: Add a skill for finding your way around QEMU
Message-ID: <apkq9lLdyqXPXWmD@redhat.com>
References: <20260903073656.540570-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903073656.540570-1-pbonzini@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, Sep 03, 2026 at 09:36:56AM +0200, Paolo Bonzini wrote:
> Some parts of this skill are based on
> https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.
> 
> Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .agents/skills/qemu-codebase/SKILL.md | 93 +++++++++++++++++++++++++++
>  .claude/skills                        |  1 +
>  .gemini/skills                        |  1 +
>  3 files changed, 95 insertions(+)
>  create mode 100644 .agents/skills/qemu-codebase/SKILL.md
>  create mode 120000 .claude/skills
>  create mode 120000 .gemini/skills
> 
> diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
> new file mode 100644
> index 00000000000..6769c6c5ea4

> +## Finding things
> +
> +`MAINTAINERS` is the authoritative map from file patterns to subsystems
> +and maintainers; use it to work out who owns code and which tree a
> +change goes through.

Does the tree actually matter to agents or contributors sending patches ?

I would tend to say "use it to work out which maintainers to CC when
sending patches".  The receiving maintainer(s) will decide which tree
it will go through.

> +Every path below that starts with `pyvenv/` is relative to the build
> +directory: `configure` creates a Python venv there, and `pyvenv/bin/meson`
> +is the meson that must be used.

More generally I think we should point to the "run" script. eg


   The "run" script in the root of the build dir should be used execute
   a command with the Python venv activated, PATH expanded to include
   any local built binaries first, and use of other project local
   resources enabled.

> +`make` at the top level forwards to `ninja` in the configured build
> +directory, and any `build.ninja` target can be invoked that way.
> +
> +## Build & Test
> +- **Build**: `ninja -C build` (from build directory) or `make -jN`

The '-C build' arg is pointing to a build tree, so the comment
should say '(from source directory)', or it should have "ninja"
without the -C arg.

make could be from the source dir (if using a build dir
named 'build') or build dir, so that's ok.

> +## Code Style
> +- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
> +- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
> +- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
> +- **C Comments**: Use `/* ... */` only. No `//` comments.
> +- **Naming**: `snake_case` for variables and functions; `CamelCase` for types and enums.
> +- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`) APIs. No `malloc`.
> +- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
> +- **Lints**: Run `./scripts/checkpatch.pl` on C patches. Use `make clippy` and `make rustfmt` for Rust.

"checkpatch" should be run on all commits, not only those with
C code changes.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


