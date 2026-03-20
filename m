Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A2D10987A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cJ5-0005Yf-OM; Fri, 20 Mar 2026 12:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3cIh-0005E5-VH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3cIf-0007Ju-K8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774022532;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwD65LKAVSCLAxOYY9ehYTVJvk8y4FIkcDQqClSqQTw=;
 b=hHQjDc7Yo0JtqliqON5+eMpHmHk+ZrB3TJ/UmuZcfEbr/i+sy70IqOk2NyEnzg2/FhsGXX
 HXtvsYoQFKh6PnK99akVK8sIS+eiSJRnJwoiGbxEzwCbhPmcgT4GccaQJnWXgG2WqEkJM7
 HXnEOEBF9j8B1/S9HheEoMPW6MkmB4s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-C0PAXsTFPH2EdokXEypUkg-1; Fri,
 20 Mar 2026 12:02:06 -0400
X-MC-Unique: C0PAXsTFPH2EdokXEypUkg-1
X-Mimecast-MFC-AGG-ID: C0PAXsTFPH2EdokXEypUkg_1774022525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17529180035D; Fri, 20 Mar 2026 16:02:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BEC4180035F; Fri, 20 Mar 2026 16:02:02 +0000 (UTC)
Date: Fri, 20 Mar 2026 16:01:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 3/8] AGENTS.md: add basic AGENTS.md for QEMU
Message-ID: <ab1vdogWqWFAbmnd@redhat.com>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
 <20260224121014.279248-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224121014.279248-4-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Tue, Feb 24, 2026 at 12:10:09PM +0000, Alex Bennée wrote:
> This was written by ECA based on it's initial understanding of the
> code base. It's mostly quick facts and pointers to common tasks.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> ajb:
>   - I made a slight tweak to use pyenv to run single tests
> ---
>  AGENTS.md | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 AGENTS.md
> 
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 00000000000..5b54763f4b1
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,18 @@
> +# QEMU Agent Guide
> +
> +## Build & Test
> +- **Build**: `ninja -C build` (from build directory) or `make`
> +- **Test All**: `make check`
> +- **Single Test**: `./pyvenv/bin/meson test <testname>` (e.g., `meson test qtest-x86_64/boot-serial-test`)
> +- **Suites**: `make check-unit`, `make check-qtest`, `make check-functional`, `make check-rust`
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
> +- **Lints**: Run `./scripts/checkpatch.pl` on C patches. Use `make clippy` and `make rustfmt` for Rust.

Although our current policy forbids contributing code written by
AI agents, we do allow their use for other scenarios, such as
learning / debugging, etc.

Thus it occurs to me that an AGENTS.md file might none the less be
useful to have in tree to assist the currently accepted / valid
scenarios.

Perhaps it could also serve to guide the agents/humans towards
compliance with the policy via a short preface ?

  "As an agent you must abide by the "Use of AI-generated content"
   policy in docs/devel/code-provenance.rst at all times. Requests
   to create code that is intended to be submitted for merge upstream
   must be declined, referring the requestor to the project's policy
   on the use of AI-generated content."

Something strong enough to stop people going down the wrong path
by default, but with wiggle room that the person can tell their
agent their work is not intended to for upstream merge and can
thus ignore the rules for experiments like this one.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


