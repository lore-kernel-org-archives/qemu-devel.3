Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DBEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtIT-0004CG-Mo; Thu, 09 Jul 2026 14:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whtIQ-0004C8-N2
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:16:26 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whtIM-0000LB-QP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783620971;
 bh=pWtVe8ZEveqlZZima8YhRxKX1iTAh2G4gLlSmZ9MW3w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=p3PJCffBS7erm+4eD+TraAsopTdJLhYk9MN7iZ+bfAZyJJF1RH+CwfgLORdpUq+EX
 AU+CAko5trFWjILMZwtTuqT5i+Pmlh9jb9IYKwGEoz3tlthVViiGdRjg0t5rncgvAg
 wm+aEJThucXqupS0P/ZyvgGPql0E1v077iV8sm4hMtU+b0HOB8D5KY2psGB3ocKu7D
 Md0pfl4Nro3WpWtw7hekrcjUAYwCNd6Xct1cdx1EXf6Hkl4+j3EyR9izIf6UbKFJBA
 rHiE/fov/0oHHplOYWcHaTKAI24qfK9CZ9CDR3iDk8b9U3c9LRuJZfTAtSDLikoVP7
 7eT9nGRldVqZA==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 9C1B32FF3B9;
 Thu,  9 Jul 2026 18:16:11 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 3607137C91E;
 Fri, 10 Jul 2026 02:15:40 +0800 (CST)
Message-ID: <0903b004-c598-49f1-ab57-55799abbb890@sjtu.edu.cn>
Date: Fri, 10 Jul 2026 02:15:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709025528.300019-1-functioner@sjtu.edu.cn>
 <20260709025528.300019-3-functioner@sjtu.edu.cn>
 <3954a5e4-32c2-4f89-a4e4-4b445e52589a@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <3954a5e4-32c2-4f89-a4e4-4b445e52589a@oss.qualcomm.com>
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

Thanks for the detailed review. Replies inline.

On Thu, 9 Jul 2026 10:29:48 -0700, Pierrick Bouvier wrote:
 > Please remove the cplusplus part, we don't need it here.

Will do, hello.h will be plain C. The guard was there because the thunk
generator parses the header as C++, so without C linkage the generated
guest library exports a mangled name and the drop-in fails to resolve
hello(). I will fix that in the generator instead: it will wrap the
header in extern "C" by default (treating it as a C library), with an
opt-out for genuine C++ headers, so the example header stays clean C.

 > No need for fflush (same in hello_host)

I will remove both. One caveat on the host side though: dropping its
fflush is not really recommended. "hello from host" runs in the host
process, so it writes to the host libc's stdout buffer, and QEMU tears
the process down on guest exit without running the host libc atexit
handlers that would flush it. On a terminal it prints anyway
(line-buffered, the newline flushes), but once stdout is redirected or
piped it is fully buffered and the line is lost. So with both removed the
example only shows the host line on a terminal.

 > Excellent, that's a nice way to see difference between guest and host.

Thanks.

 > Please replace this part with a proper url, choosing a specific version
 > and arch. Ideally, you can publish under "latest" in addition to
 > versioned releases on GitHub so url stays stable.
 >
 > Also, please add a link to
 > https://github.com/rover2024/lorelei/releases
 > in the comment so people can click this and see what is available.

Will do. I will pin the command to x86_64 and a specific release, add a
comment linking to the releases page, and publish a stable "latest"
download asset so the URL does not rot.

 > Why do we need this variable?

It is the thunk-pack discovery path, and it does a different job from
LD_LIBRARY_PATH. LD_LIBRARY_PATH is the loader's search path for shared
objects. LORELEI_THUNK_PATH tells the host runtime where the thunk packs
live, so it can find the host side of each thunk (the HTL) and the
guest-to-host library mapping, and it can layer several packs. The
runtime resolves these itself, they are not something the loader would
find, so I would keep this variable rather than fold it into
LD_LIBRARY_PATH. Flattening the layout (your next point) shortens the
paths but does not remove the need for it.

 > This still fails on my side with following error message:
 > lorelei.guest-rt: failed to load host runtime: libLoreHostRT.so: cannot
 > enable executable stack as shared object requires: Invalid argument
 > qemu: uncaught target signal 6 (Aborted) - core dumped
 > Aborted
 >
 > Seems like error message is incorrect in itself "invalid argument"?
 >
 > I'm using debian trixie (stable) in case you want to reproduce this on
 > a VM.

Thank you, this is the real bug, and the new error string is exactly
what let me find it. libLoreHostRT.so was linked with an executable
stack: one assembly file in the runtime (the coroutine context switch)
was missing the ".note.GNU-stack" marker, so the linker marked the whole
library's stack executable. A hardened loader (Debian trixie) then
refuses to dlopen it.

The message is not wrong. "Invalid argument" is the kernel's errno for
the refused stack mprotect, surfaced through dlerror. It read as a
mystery only because older releases did not print the dlerror string at
all.

The fix is to mark the runtime's stack non-executable (add the missing
note, plus -z noexecstack at link time). I have confirmed the GNU_STACK
flag flips from RWE to RW with that change. A new devkit and runtime
release will carry it, and the example will load on trixie. I will
follow up here once it is published so you can retry.

 > Please simplify thunks/ folder hierarchy. Make only one subfolder
 > (thunks/x86_64) having both the thunks and lorelei lib, and remove the
 > rest.
 >
 > With this, we can simplify command to become:
 > LD_LIBRARY_PATH=$DEVKIT/lib/:build/host \
 > qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
 > -E LD_LIBRARY_PATH=thunks/x86_64 build/guest/main

I would rather keep the current layout, and I think it is justified.
Those subdirectories are not cosmetic: they are the contract the host
runtime uses to discover thunks. It scans each LORELEI_THUNK_PATH prefix
for <prefix>/x86_64/lib/x86_64-LoreGTL (guest thunks) and
<prefix>/lib/<host-arch>-LoreHTL (host thunks), which is how it tells a
guest thunk from a host thunk, and by architecture. The same guest-thunk
directory is also what the guest loader reads through -E, so collapsing
the -E path collapses the discovery path with it.

Merging the "lorelei lib" into that folder has a second cost: those are
the runtime libraries, shipped once in the devkit, not per thunk. Thunk
packs are deliberately standalone and do not each carry a copy of the
runtime. Putting them together would either duplicate the runtime into
every pack, or mix runtime libraries in with the thunks so the scan can
no longer separate the two.

So the second -E entry is not redundant: one directory is this library's
thunk, the other is the shared guest runtime. The extra path components
are the price of that separation, and the existing thunk packs already
follow this layout, so I would keep it. If the two directories read as
redundant, I can add a one-line note saying which is which, but I would
rather not collapse them.

 > Also, in lorelei tarball, why do we have /lib and x86_64/lib that have
 > same libraries, but with different sizes? What's the difference?
 > It's confusing.
 >
 > It seems like x86_64/lib folder is never used?

They are two builds of the runtime. /lib is the host runtime, native to
the host, loaded by the QEMU process (the plugin dlopens
libLoreHostRT.so from there). x86_64/lib is the guest runtime, x86_64,
loaded by the emulated guest (the generated guest thunk needs
libLoreGuestRT.so from there). Same names, different targets, hence the
different sizes. x86_64/lib is used, by the guest side. I agree the
split is confusing and will make the layout and the docs clearer.

 > Please remove the section above from the doc since it does not add
 > useful information. Also, we already have a link to Lorelei above.

Will remove it.

 > We're getting closer, hang on.
 > We need to have a simple example that is functional before being able
 > to accept the plugin.

Understood, and the executable-stack fix above is what makes it
functional. I will publish a new devkit and send a trimmed revision that
addresses all of the above.

Thanks,
Ziyang Zhang

