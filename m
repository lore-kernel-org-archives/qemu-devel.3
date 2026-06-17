Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A038CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpzv-0004KZ-Ic; Wed, 17 Jun 2026 09:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wZpzs-0004K0-G9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:08:00 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wZpzo-00085F-LO
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781701665;
 bh=H19TVXMYIU22yMEKQmHP7GBpjLrkDwcdOgUXsPvYx+M=;
 h=From:To:Cc:Subject:Date;
 b=A2Bb/lQH0O/9WAAbhEzH5evDSUeM5OMRFsnGaHvoEjNhuIpvBtVT1nY78nYwl5bc9
 zXL76eP1NrlasLqc9Bx/Ty0EyMzH1zrI9OILPfBhQ+ICw7QzB/BAAMltAJCidlaG3P
 QZ+b4eoOE57MIOPn7E9BOjvCaSr23x1zi9ob84/2gAAaHouZ0858849FAuJI9bnVqf
 AuM/ltbbExatX1V1oosT7qc92Z+RwpbGjg3/yt0hMGQL0HMIIWnu3pXO3Uody7FD7J
 OTeDdWwG8YxZ6ae6PyDHl+W1/4tpgi/xKb/Wmp9Nej4P1aXF5BqrhmvXQmot2sf8ug
 ALqaASKpPwVXA==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id D688C2FF409;
 Wed, 17 Jun 2026 13:07:45 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 9486E37C967;
 Wed, 17 Jun 2026 21:07:44 +0800 (CST)
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
Subject: [RFC PATCH 0/1] contrib/plugins: add a minimal passthrough plugin
Date: Wed, 17 Jun 2026 21:07:41 +0800
Message-Id: <20260617130742.769234-1-functioner@sjtu.edu.cn>
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

This RFC adds a single plugin, contrib/plugins/passthrough.c (under 200 lines,
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

The guest makes a system call with a reserved number (4096) that no real Linux
ABI uses. Its first argument selects a pass-through operation; the rest carry
operands:

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
  === inside QEMU: THIS PATCH, < 200 lines =====================
      passthrough plugin:  dlopen / dlsym / invoke a host fn
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

It is fully opt-in (loaded with -plugin) and targets linux-user, where the
guest and host already share a trust domain. The test cases use x86_64 guests
and run on x86_64, arm64 and riscv64 Linux hosts.

This is an RFC: I would welcome feedback on the plugin itself and on the
pass-through approach in general.

Thanks,
Ziyang Zhang

Ziyang Zhang (1):
  contrib/plugins: add a minimal passthrough plugin

 contrib/plugins/meson.build   |   1 +
 contrib/plugins/passthrough.c | 187 ++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 contrib/plugins/passthrough.c

-- 
2.34.1


