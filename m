Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835B5CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhbx-0001H5-Eq; Mon, 22 Jun 2026 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wbhbv-0001Gs-Ri
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:34:59 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wbhbr-0001kr-Qd
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782146082;
 bh=QHgH5wDphMpSXnuBw57UntaHqnH+aJBDBAaGi6tRuX8=;
 h=From:To:Cc:Subject:Date;
 b=Insx+kIPgrjA9loR8DzK1U9+Hj5majDz2xeVhnLjwelEFNiVFulodFHk7x42IBjkR
 7JnYaVwvgJyhjtdI8ZYWRD2oWFcg/bC0lXzJKbhohmXdnZDfGydoGSI5EZPtDkFPaG
 CBmIgferzEOfIbiIwM5Jk2mLeG6TS+EUVziVee77JluT+09IJo5lXxfI2W7tcWJNOf
 7jdZfLcsy4+5B0ukeJl5aSmK19GldBwuc6cI1BWuM0wIFltR2Wc3Y0bw7PEJPMIEg9
 QOAN4qP+MuBJrk09ex/+KxT3koLDkpdydnFm0mYTSDMQdwf7osMwAqgk9Nv/H1XjJg
 90Z2moI34EKEw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 0BECE300114;
 Mon, 22 Jun 2026 16:34:42 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id DA92C37C8C7;
 Tue, 23 Jun 2026 00:34:40 +0800 (CST)
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
Subject: [PATCH v3 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
Date: Tue, 23 Jun 2026 00:34:37 +0800
Message-Id: <20260622163438.130746-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
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

You can watch the demos build, run, and report timings in CI, without checking
anything out:

  https://github.com/rover2024/qemu-passthrough-test/actions/runs/27671747420

How it works
============

The guest makes a system call with a reserved number (4096 by default) that no
real Linux ABI uses. Its first argument selects a pass-through operation; the
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

A complete reference implementation, with the minizip and OpenGL/X11 examples
above, is here:

  https://github.com/rover2024/qemu-passthrough-test

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

A note on automation
====================

The userspace thunks in that reference implementation are currently
hand-written rather than generated by the LLVM-based toolchain from the talk.
That is a deliberate choice for a demo: the automated toolchain pulls in a full
LLVM installation, which adds substantial setup time, and the example projects
are slow to build and cannot be reduced to a single Makefile. Hand-writing the
thunks was the cheaper path to a self-contained, reproducible demo, and it was
already enough to get minizip working end to end.

For real, large-scale use I will rely on the automated toolchain. The key point
is that hand-written vs. generated thunks is entirely decoupled from this plugin
and from the magic-syscall interface it defines: the toolchain only emits
out-of-tree userspace code and never touches the in-tree plugin. Automation
becomes mandatory for complex, callback-heavy targets such as the OpenGL/Vulkan
games, which is the direction this work is heading next.

It is fully opt-in (loaded with -plugin) and targets linux-user, where the
guest and host already share a trust domain. The test cases use x86_64 guests
and run on x86_64, arm64 and riscv64 Linux hosts.

The changes to the documentation (docs/about/emulation.rst) will be sent as a
separate patch.

Feedback on the plugin and on the pass-through approach is welcome.

Changes since v2:

  * Dropped the RFC tag; the approach was positively received on v2.
  * Rebased on master and adjusted the syscall-filter callback to its updated
    signature (int64_t sysret, added userdata, dropped the plugin id
    argument).

Changes since v1:

  * Renamed the plugin from "passthrough" to "dlcall" (Pierrick Bouvier).
    The old name was too generic; "dlcall" reflects what the plugin actually
    does (dlopen/dlsym a host symbol and call it) and avoids confusion with
    QEMU's existing plugin hostcall concept (QEMU_PLUGIN_*_HOSTCALL).
  * Made the magic syscall number configurable at load time via the
    "syscall_num=N" argument, defaulting to 4096 and rejecting values low
    enough to clash with a real syscall (Pierrick Bouvier).

v1: https://lore.kernel.org/qemu-devel/20260617130742.769234-1-functioner@sjtu.edu.cn/
v2: https://lore.kernel.org/qemu-devel/20260619045404.820960-1-functioner@sjtu.edu.cn/

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


