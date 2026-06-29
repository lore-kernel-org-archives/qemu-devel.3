Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BCBC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weERv-0004Ax-Hh; Mon, 29 Jun 2026 12:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1weERd-000433-1J
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:02:51 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1weERU-0003Jr-Ob
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782748942;
 bh=yPB+FNojdm3U2DVtVOZaY39u3G+QLSDX/AybuCnKIYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N/Nr23FT6KcoH2XBKt6Ijjt8P931bQ4Gu6bBCoi67qgyEj5U79BHzK5k1Ev3LcFfA
 WmQg3pGmoKRvmbhEd+BQZ3ngtqeWKYFGfpYV7BiJX9F+MnzgPi9zPEa+Qgktgd3MuE
 IrMYrLrL3EZMDUwFqZR5HbLKjpBJsv1oO/32h0YC/FPQHbb/kCv+9uLcNmn2OTEg0T
 qhgpVG/w5YI8h+0zxE3ZOw5PgzMrH+9GkT6aPuhoybtBSZ+CtQ657WJOQUE2yWNKpM
 +21IkgUnXEAym5PCrS+Kq2q1LQW0YvWiDEFem+PRQ2qmVY7nTIgutrmokHZcXEcjXf
 pOUu+0HRu9SKQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 69A752FF367;
 Mon, 29 Jun 2026 16:02:22 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id DCFC637C941;
 Tue, 30 Jun 2026 00:02:19 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v4 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
Date: Tue, 30 Jun 2026 00:02:16 +0800
Message-Id: <20260629160217.1637276-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622163438.130746-1-functioner@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

This patch adds a single plugin, contrib/plugins/dlcall.c (~240 lines,
no changes to QEMU core), that lets a linux-user guest call functions in the
host's native shared libraries instead of emulating them.

It is the natural next step on top of the vCPU syscall-filter callback that I
contributed and that was merged earlier:

  https://lore.kernel.org/qemu-devel/20251214144620.179282-1-functioner@sjtu.edu.cn/

Why bother? Because it turns slow, instruction-by-instruction emulation of a
library into a native host call. Some results, all on completely unmodified
guest binaries:

  * minizip (the stock zlib utility) compresses several times faster, because
    the actual deflate runs natively on the host instead of being translated.
  * Real OpenGL/Vulkan games run under qemu-user: SuperTuxKart and Hollow
    Knight are playable, with their graphics calls going straight to the host
    GPU.

How it works
============

The guest makes a system call with a reserved number (4096 by default) that no
real Linux ABI uses. Its first argument selects a pass-through operation, and the
rest carry operands:

  syscall(4096, op, arg1, arg2, ...)
          |     |    \............ operands (pointers / values)
          |     \................. which pass-through operation
          \....................... the reserved "magic" number

The plugin registers a vCPU syscall filter: before QEMU forwards a syscall to
the host kernel, the filter runs, sees 4096, performs the operation on the
host, writes the result back, and tells QEMU the syscall is consumed, so the
real kernel never sees it.

The whole interface is just a handful of primitives:

  * query a host attribute
  * dlopen / dlclose a host shared library
  * dlsym a symbol, and read the last dlerror
  * invoke a resolved host function with a void(void *, void *) signature

That is all the plugin does. It knows nothing about zlib, X11 or OpenGL, or
about any library's calling convention.

The same machinery also runs in reverse: when a host function needs to call
back into the guest (a qsort comparator, an allocator, a GUI or game callback),
control re-enters the guest to run the callback and then resumes the suspended
host call. This reentry is what lets stateful, callback-driven APIs work, not
just leaf functions.

Why the plugin belongs in QEMU, and the rest does not
=====================================================

Only the plugin lives in the tree. Everything else is ordinary userspace:

  --- userspace (out of tree, not tied to any DBT) -------------
      guest: unmodified program  ->  guest runtime + thunk libs
  --------------------------------------------------------------
                 |  syscall(4096, op, args)   (only crossing point)
                 v
  === inside QEMU: THIS PATCH, ~240 lines ======================
      dlcall plugin:  dlopen / dlsym / invoke a host fn
  ==============================================================
                 |
                 v
  --- userspace (out of tree) ----------------------------------
      host: host runtime + thunk libs  ->  real libz / libGL ...
  --------------------------------------------------------------

The split is deliberate, and it is why only this one file is proposed for the
tree:

  * This plugin defines the most general interaction interface for native
    pass-through: the magic-syscall ABI between an emulated guest and its
    emulator. That contract is what every pass-through implementation builds
    on, so it belongs in a stable, shared place.
  * It is also the only piece that is inherently QEMU-specific: it plugs into
    QEMU's syscall-filter hook and runs inside the QEMU process. The argument
    marshalling, calling conventions, callbacks/reentry and per-library
    coverage are not tied to any particular DBT and behave as ordinary
    userspace, so they should stay out of tree rather than couple QEMU to them.

Background: we presented this approach at KVM Forum 2025, "Lorelei: Enable QEMU
to Leverage Native Shared Libraries":

  https://www.youtube.com/watch?v=_jioQFm7wyU

The userspace side
==================

A fair point on v3 was that, on its own, the plugin is only half of an
interface: useful only if the other half (the guest/host runtimes and the
per-library thunks) is public and specified, rather than a private demo. That
half is now available as a standalone, documented, CI-tested project, Lorelei:

  https://github.com/rover2024/lorelei

Lorelei provides the guest and host runtimes and a Thunk Library Compiler
(TLC, built on Clang LibTooling) that reads a library's headers and generates
the guest and host thunks automatically, including the awkward cases of
function-pointer callbacks and variadic functions. It has CI for x86_64, arm64
and riscv64 hosts. Lorelei and its thunk libraries are MIT-licensed.

Because the plugin is not upstream yet, Lorelei currently builds and tests
against the QEMU fork that carries it.

The plugin stays deliberately minimal and prescribes nothing about how
thunking is done. Lorelei is one reference implementation of the userspace
side. Any toolchain, or another instrumentation framework, can implement the
same dlcall interface.

A from-scratch walkthrough of the bare mechanism, with the minizip and
OpenGL/X11 examples above, is also available here:

  https://github.com/rover2024/qemu-passthrough-test

It is fully opt-in (loaded with -plugin) and targets linux-user, where the
guest and host already share a trust domain. The test cases use x86_64 guests
and run on x86_64, arm64 and riscv64 Linux hosts.

I have deliberately kept Lorelei out of the patch itself: neither the code
nor its comments mention it, since I am not sure whether referencing an
external project from the tree is welcome. I would appreciate guidance on
where a pointer to the toolchain belongs, if anywhere. For example, would it
be appropriate to mention it from the documentation patch?

Feedback on the plugin and on the pass-through approach is welcome.

Changes since v3:

  * Lorelei, the userspace toolchain that implements this interface, is now a
    public, documented, CI-tested project, with a Thunk Library Compiler that
    generates the guest/host thunks automatically. This addresses the v3
    feedback that the interface needs a public implementation behind it. The
    plugin code itself is unchanged.
  * The documentation patch is held back for now.

Changes since v2:

  * Dropped the RFC tag. The approach was positively received on v2.
  * Rebased on master and adjusted the syscall-filter callback to its updated
    signature (int64_t sysret, added userdata, dropped the plugin id
    argument).

Changes since v1:

  * Renamed the plugin from "passthrough" to "dlcall" (Pierrick Bouvier).
    The old name was too generic. The name "dlcall" reflects what the plugin actually
    does (dlopen/dlsym a host symbol and call it) and avoids confusion with
    QEMU's existing plugin hostcall concept (QEMU_PLUGIN_*_HOSTCALL).
  * Made the magic syscall number configurable at load time via the
    "syscall_num=N" argument, defaulting to 4096 and rejecting values low
    enough to clash with a real syscall (Pierrick Bouvier).

v1: https://lore.kernel.org/qemu-devel/20260617130742.769234-1-functioner@sjtu.edu.cn/
v2: https://lore.kernel.org/qemu-devel/20260619045404.820960-1-functioner@sjtu.edu.cn/
v3: https://lore.kernel.org/qemu-devel/20260622163438.130746-1-functioner@sjtu.edu.cn/

Thanks,
Ziyang Zhang

Ziyang Zhang (1):
  contrib/plugins: add a minimal dlcall plugin

 contrib/plugins/dlcall.c    | 238 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   5 +
 2 files changed, 243 insertions(+)
 create mode 100644 contrib/plugins/dlcall.c

-- 
2.34.1


