Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D5CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMXH-00027S-HI; Tue, 23 Jul 2024 16:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWMXE-0001y8-ON
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:55:00 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWMXC-0006wX-8Q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:55:00 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso23951935ab.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721768096; x=1722372896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F51VeGdZ5qcsbBuykK2Y6MNun6pOugq2iZu2atDa51I=;
 b=dHzeRlDWbQIYxq1nJUmFvlUIjHuvMXEanD930440Bfz+jScMIh0PWhcSXoktHQwDUe
 JhS4VwZyYdiZvDOr6XEWUizld10XDbITP6DmEumE65V/Zw6rnOJ0s30Repoh8QgdUYBW
 +msRshFbYXaY7VmVsUq1DyQ175vHKTKOOEFS07oXsdyOXURARLBZy9SVu5QdhPVvfsY+
 +FraEbX6LRemWB1S5HAQeN1GGU0RT1k8JlxUD2/bYhANLZrA3qYrdRXT9tj/BHhqETPK
 1LPgHxFFxrhh6ExpE6TwENoUBZIKUzSON83BWXiNu1e+RGRGUHmuLnJR5xGUTC478NPe
 aRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768096; x=1722372896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F51VeGdZ5qcsbBuykK2Y6MNun6pOugq2iZu2atDa51I=;
 b=xNZRQNy4b2KgF5ey3QQ6g84vfKtZXAqoIUZbPhxxHLXYxjHuqy0wNuECSwEpj6lz1o
 UM4a3vWlSRb9/NqDEe9j5ypAThYZixCldysEofPiBJrcuMiFNU1G9xdqrbmBOaE6w+zL
 Pf1ne/PYAbXk3OzDqieugz5R4r6p/vXTumDF19GQHJeIGr4ndM9/OcX9R3ndw2Jbcibp
 Y5if+W5WK27+cxVLowWyuDb/CDzBDyJtCvQRzEPNb/zGzwoBxvv5o2t1idouH3rpmjYG
 usGVqOi5BllGgHgFa6nwHWZXslmZmPqjusLJbXiYK7qnVQBJjYEv+FPgp1hYwBkPxIqP
 JtUQ==
X-Gm-Message-State: AOJu0YyxLc8uYnMR/7uLSUTkrAo3t55O5+TYjfCMvZjuh/3hYdo0DhrH
 5UE4POJmAhYU1/VjmXm/0wRX+a6/bKo7vis5iYooLukHq1+YfqY+h2wFljewdfvg4D+yItrH6fR
 5
X-Google-Smtp-Source: AGHT+IFyjfL/AbXhZMdgdJx9GJ8TXLJOmJzpkwoDul+n9kOMOsbO9LmaNfY8N9oCrjWsng8yupK5iA==
X-Received: by 2002:a92:c265:0:b0:382:b82b:6e48 with SMTP id
 e9e14a558f8ab-398e4db7a69mr160530395ab.9.1721768094463; 
 Tue, 23 Jul 2024 13:54:54 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d1fafc422sm4427592b3a.113.2024.07.23.13.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 13:54:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] docs/devel: update tcg-plugins page
Date: Tue, 23 Jul 2024 13:54:51 -0700
Message-Id: <20240723205451.504193-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x12c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reflect recent changes on API (inline ops) and new plugins.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/tcg-plugins.rst | 101 +++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 38 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 954623f9bf1..5d2ebb92977 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -29,8 +29,8 @@ Once built a program can be run with multiple plugins loaded each with
 their own arguments::
 
   $QEMU $OTHER_QEMU_ARGS \
-      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
-      -plugin contrib/plugin/libhotblocks.so
+      -plugin contrib/plugins/libhowvec.so,inline=on,count=hint \
+      -plugin contrib/plugins/libhotblocks.so
 
 Arguments are plugin specific and can be used to modify their
 behaviour. In this case the howvec plugin is being asked to use inline
@@ -41,6 +41,14 @@ Linux user-mode emulation also evaluates the environment variable
 
   QEMU_PLUGIN="file=contrib/plugins/libhowvec.so,inline=on,count=hint" $QEMU
 
+QEMU plugins avoid to write directly to stdin/stderr, and use the log provided
+by the API (see function ``qemu_plugin_outs``).
+To show output, you may use this additional parameter::
+
+  $QEMU $OTHER_QEMU_ARGS \
+    -d plugin \
+    -plugin contrib/plugins/libhowvec.so,inline=on,count=hint
+
 Writing plugins
 ---------------
 
@@ -93,11 +101,14 @@ translation event the plugin has an option to enumerate the
 instructions in a block of instructions and optionally register
 callbacks to some or all instructions when they are executed.
 
-There is also a facility to add an inline event where code to
-increment a counter can be directly inlined with the translation.
-Currently only a simple increment is supported. This is not atomic so
-can miss counts. If you want absolute precision you should use a
-callback which can then ensure atomicity itself.
+There is also a facility to add inline instructions doing various operations,
+like adding or storing an immediate value. It is also possible to execute a
+callback conditionally, with condition being evaluated inline. All those inline
+operations are associated to a ``scoreboard``, which is a thread-local storage
+automatically expanded when new cores/threads are created and that can be
+accessed/modified in a thread-safe way without any lock needed. Combining inline
+operations and conditional callbacks offer a more efficient way to instrument
+binaries, compared to classic callbacks.
 
 Finally when QEMU exits all the registered *atexit* callbacks are
 invoked.
@@ -117,9 +128,9 @@ However the following assumptions can be made:
 Translation Blocks
 ++++++++++++++++++
 
-All code will go through a translation phase although not all
-translations will be necessarily be executed. You need to instrument
-actual executions to track what is happening.
+All code will go through a translation phase although not all translations will
+necessarily be executed. You need to instrument actual executions to track what
+is happening.
 
 It is quite normal to see the same address translated multiple times.
 If you want to track the code in system emulation you should examine
@@ -135,13 +146,12 @@ change control flow mid-block.
 Instructions
 ++++++++++++
 
-Instruction instrumentation runs before the instruction executes. You
-can be can be sure the instruction will be dispatched, but you can't
-be sure it will complete. Generally this will be because of a
-synchronous exception (e.g. SIGILL) triggered by the instruction
-attempting to execute. If you want to be sure you will need to
-instrument the next instruction as well. See the ``execlog.c`` plugin
-for examples of how to track this and finalise details after execution.
+Instruction instrumentation runs before the instruction executes. You can be
+sure the instruction will be dispatched, but you can't be sure it will complete.
+Generally this will be because of a synchronous exception (e.g. SIGILL)
+triggered by the instruction attempting to execute. If you want to be sure you
+will need to instrument the next instruction as well. See the ``execlog.c``
+plugin for examples of how to track this and finalise details after execution.
 
 Memory Accesses
 +++++++++++++++
@@ -200,12 +210,12 @@ encouraged to contribute your own plugins plugins upstream. There is a
 basic plugins that are used to test and exercise the API during the
 ``make check-tcg`` target in ``tests\plugins``.
 
-- tests/plugins/empty.c
+- tests/plugin/empty.c
 
 Purely a test plugin for measuring the overhead of the plugins system
 itself. Does no instrumentation.
 
-- tests/plugins/bb.c
+- tests/plugin/bb.c
 
 A very basic plugin which will measure execution in course terms as
 each basic block is executed. By default the results are shown once
@@ -220,14 +230,13 @@ Behaviour can be tweaked with the following arguments:
 
  * inline=true|false
 
- Use faster inline addition of a single counter. Not per-cpu and not
- thread safe.
+ Use faster inline addition of a single counter.
 
  * idle=true|false
 
  Dump the current execution stats whenever the guest vCPU idles
 
-- tests/plugins/insn.c
+- tests/plugin/insn.c
 
 This is a basic instruction level instrumentation which can count the
 number of instructions executed on each core/thread::
@@ -250,8 +259,7 @@ Behaviour can be tweaked with the following arguments:
 
  * inline=true|false
 
- Use faster inline addition of a single counter. Not per-cpu and not
- thread safe.
+ Use faster inline addition of a single counter.
 
  * sizes=true|false
 
@@ -267,18 +275,18 @@ Behaviour can be tweaked with the following arguments:
        -d plugin ./tests/tcg/aarch64-linux-user/sha512-vector
    ...
    0x40069c, 'bl #0x4002b0', 10 hits, 1093 match hits, Δ+1257 since last match, 98 avg insns/match
-   0x4006ac, 'bl #0x403690', 10 hits, 1094 match hits, Δ+47 since last match, 98 avg insns/match 
-   0x4037fc, 'bl #0x4002b0', 18 hits, 1095 match hits, Δ+22 since last match, 98 avg insns/match 
-   0x400720, 'bl #0x403690', 10 hits, 1096 match hits, Δ+58 since last match, 98 avg insns/match 
-   0x4037fc, 'bl #0x4002b0', 19 hits, 1097 match hits, Δ+22 since last match, 98 avg insns/match 
-   0x400730, 'bl #0x403690', 10 hits, 1098 match hits, Δ+33 since last match, 98 avg insns/match 
-   0x4037ac, 'bl #0x4002b0', 12 hits, 1099 match hits, Δ+20 since last match, 98 avg insns/match 
+   0x4006ac, 'bl #0x403690', 10 hits, 1094 match hits, Δ+47 since last match, 98 avg insns/match
+   0x4037fc, 'bl #0x4002b0', 18 hits, 1095 match hits, Δ+22 since last match, 98 avg insns/match
+   0x400720, 'bl #0x403690', 10 hits, 1096 match hits, Δ+58 since last match, 98 avg insns/match
+   0x4037fc, 'bl #0x4002b0', 19 hits, 1097 match hits, Δ+22 since last match, 98 avg insns/match
+   0x400730, 'bl #0x403690', 10 hits, 1098 match hits, Δ+33 since last match, 98 avg insns/match
+   0x4037ac, 'bl #0x4002b0', 12 hits, 1099 match hits, Δ+20 since last match, 98 avg insns/match
    ...
 
 For more detailed execution tracing see the ``execlog`` plugin for
 other options.
 
-- tests/plugins/mem.c
+- tests/plugin/mem.c
 
 Basic instruction level memory instrumentation::
 
@@ -291,8 +299,7 @@ Behaviour can be tweaked with the following arguments:
 
  * inline=true|false
 
- Use faster inline addition of a single counter. Not per-cpu and not
- thread safe.
+ Use faster inline addition of a single counter.
 
  * callback=true|false
 
@@ -302,7 +309,7 @@ Behaviour can be tweaked with the following arguments:
 
  Count IO accesses (only for system emulation)
 
-- tests/plugins/syscall.c
+- tests/plugin/syscall.c
 
 A basic syscall tracing plugin. This only works for user-mode. By
 default it will give a summary of syscall stats at the end of the
@@ -332,6 +339,11 @@ run::
   160          1      0
   135          1      0
 
+- tests/plugins/inline.c
+
+This plugin is used for testing all inline operations, conditional callbacks and
+scoreboard. It prints a per-cpu summary of all events.
+
 - contrib/plugins/hotblocks.c
 
 The hotblocks plugin allows you to examine the where hot paths of
@@ -342,9 +354,6 @@ with linux-user execution as system emulation tends to generate
 re-translations as blocks from different programs get swapped in and
 out of system memory.
 
-If your program is single-threaded you can use the ``inline`` option for
-slightly faster (but not thread safe) counters.
-
 Example::
 
   $ qemu-aarch64 \
@@ -462,7 +471,6 @@ people at roughly where execution diverges. The only argument you need
 for the plugin is a path for the socket the two instances will
 communicate over::
 
-
   $ qemu-system-sparc -monitor none -parallel none \
     -net none -M SS-20 -m 256 -kernel day11/zImage.elf \
     -plugin ./contrib/plugins/liblockstep.so,sockpath=lockstep-sparc.sock \
@@ -664,6 +672,23 @@ The plugin will log the reason of exit, for example::
 
   0xd4 reached, exiting
 
+- contrib/plugins/ips.c
+
+This plugin can limit the number of Instructions Per Second that are executed::
+
+    # get number of instructions
+    $ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
+    # limit speed to execute in 10 seconds
+    $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/10)) /bin/true
+    real 10.000s
+
+Options:
+
+    * ips=N
+
+    Maximum number of instructions per cpu that can be executed in one second.
+    The plugin will sleep when the given number of instructions is reached.
+
 Plugin API
 ==========
 
-- 
2.39.2


