Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730EAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wek4C-0002JA-N6; Tue, 30 Jun 2026 21:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wek4A-0002J1-EC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 21:48:43 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wek47-0003oz-He
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 21:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782870505;
 bh=m+I/bnMVHwihvOy2CbiAphq/Fvh+pfFR/3CoFvQe2jw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oFvddbpB2kft4F5U2p+ZZnBqqqnqUXvvT9hWuYTSBooZbyPoYS3VvL8lVE+kGh9Qj
 WjmJbg3P5hy7OYaAbo5/sHz0Bo20IRK8vAjdRJz/IvAwdsgdotc24uHAg6/7SwQm9V
 9HaHzS4i7ERCw0SrVSeU/NOEjzeOB6AguGzmiAlz86q3HkqCOsGghL/p1BI6JNIG07
 XQShCQdjGzbGN4WG7sUy1nZIExI68NGYX35FRNqSf144wGwvq+NKkLi6LXcC7aL2W0
 QHjDTBomxB2J6lh27AEZe65SSka32WyMf5tINy9eXNfqnk5B7oj5vFX1Zp3Pr1T1fS
 Kb1VBLaDoIIvw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id DD0E72FF47D;
 Wed,  1 Jul 2026 01:48:25 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id A588C380CA3;
 Wed,  1 Jul 2026 09:48:24 +0800 (CST)
Message-ID: <faad8fd9-5fa8-4ae8-8437-28864543e34e@sjtu.edu.cn>
Date: Wed, 1 Jul 2026 09:48:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <20260629160217.1637276-1-functioner@sjtu.edu.cn>
 <42297965-3d92-4d9d-ad6f-4861841d4806@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <42297965-3d92-4d9d-ad6f-4861841d4806@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Pierrick,

Thanks for the review, and for thinking about the end-user experience.

On Tue, 30 Jun 2026 12:34:59 -0700, Pierrick Bouvier wrote:
> Thanks for publishing it.
> 
> A few ideas to make Lorelei even more easy to use:
> 
> Would that be possible to add binary artifacts to the existing 1.0.0
> Lorelei release?
> Ideally, it should provide a toolchain (for x64 hosts) with support for
> x64, arm64 and riscv64 guest thunks.
> 
> Also, would that possible to provide a script to generate boilerplate
> for thunks, and extract list of symbols from a given library?
> 
> My ultimate goal would be to have something as simple as:
> $ wget toolchain.hostx64.tar.gz
> 
> # automatically generate boilerplate + compile guest/host thunks
> $ toolchain.hostx64/bin/generate-thunks \
>    --arch arm64 --library /usr/lib/libfoo.so \
>    --header /usr/include/foo.h --out thunks_arm64
> 
> $ aarch64-linux-gnu-gcc main.c -lfoo
> $ env LD_LIBRARY_PATH=./thunks_arm64 \
>    qemu-arm64 ./a.out -plugin contrib/plugins/liblorelei.so
> 
> I understand it asks for more, but we really need to make lorelei as
> simple to use as possible, without pushing the internal details to users.
> 
> What do you think about this?


Prebuilt toolchain / instant acceleration

Agreed: the goal is to install it and feel the speedup right away,
with no build step. I'll do this, but as a point release on top of
1.0.0.0 rather than in the initial tag, so it lands as its own
increment. The model is FEX's FEXFetchRootFS: a prebuilt host
toolchain plus ready-made thunks, so a user goes from download
straight to an accelerated guest. Like FEXFetchRootFS, the tool will
likely have the user pick their distribution and version, because a
thunk is bound to a specific library build: the exported symbols, and
sometimes the ABI, differ across distros and releases, so the prebuilt
thunks must match the host's real libraries.

Generating thunks for a new library

One caveat on the generate-thunks sketch. Lorelei guarantees that
thunk *generation* is automatic and reproducible: once a library is
described, TLC deterministically emits both sides, including the
callback and variadic cases. What it cannot do on its own is
*describe* the library, that is, pick the symbols you need and write
descriptors for the ones that do not marshal trivially (callbacks by
pointer, ownership crossing the boundary). Those stay judgment calls
that need a human, or an AI, in the loop.

So adding a new library is not one fully automatic command. What
Lorelei does is drastically cut the effort versus hand-writing every
thunk the way Box64 does: the generate-thunks helper automates what
is automatable (symbol extraction, boilerplate, building both sides),
so simple libraries are close to one-shot and harder ones start from
a skeleton rather than a blank file.

Plugin name

I would rather keep "dlcall" than rename it to "lorelei". The plugin
defines a general interface (the magic-syscall dlopen/dlsym/invoke
ABI), and Lorelei is only one userspace implementation of it now:

   - "dlcall" says what the plugin does and is understood without
     leaving the tree. "lorelei" names an external project and says
     nothing about the mechanism.
   - An in-tree interface should not be tied to the branding or
     lifetime of an out-of-tree project. If Lorelei is renamed,
     forked, or joined by other toolchains, the name becomes
     misleading.
   - Naming it after one implementation implies it is the blessed one
     and discourages alternatives. A generic name keeps QEMU neutral.
   - It also matches how the other contrib plugins are named, by
     functionality (lockstep, cache, ...).

I do agree Lorelei should be discoverable from the tree, so I'll add
docs to docs/about/emulation.rst that introduce the dlcall interface
and point at Lorelei as a ready-to-use implementation, with a minimal
example and without the internal details.

Does that sound reasonable?

Thanks,
Ziyang Zhang



