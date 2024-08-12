Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7287C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 23:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdeJK-0000Ey-1v; Mon, 12 Aug 2024 19:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sdeJI-0000DX-La
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 19:18:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sdeJ9-0003tt-VH
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 19:18:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ff67158052so31040845ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723504714; x=1724109514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XveoTt72Ig0J1NMgFKGkqnotzijPfu5WMeFb68HnIUc=;
 b=ACE8AwRZr6fAxl01Qjsq2Nfnv+gg8820jFAFvqJM+CRbtrGwoGPZoTKCrGD/l1b2EB
 IwoNe+PPdp6Rjt57z5fyivEtbam292SexnlpqbrvQgW5vH9e71s7ABCzbCqjBl7A+xVp
 VZdvhH2H3YqMLxdetx09RxaZU2VeKsElPxAJ0WRqXnhdxApmYciPsdm+cHtc1QVjKCus
 PwqsTEhjJ6neBXKLfPMH+S/VamTOVvPvxMvVpIwFzJEow/s582czDXmP0Gn/THXVsj+p
 f5czEO4sgdY5YnRz+SPxrO5wT+ZUUS7E/bvJRBv1L++Ye6Ty0u86YBKnS1k9aA2ua65X
 LYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723504714; x=1724109514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XveoTt72Ig0J1NMgFKGkqnotzijPfu5WMeFb68HnIUc=;
 b=R1p1iq3V9dujRzMAe2zWLhAYjrSuMMF4URb7sf4OcYcxoTW3zbSajVf0aMI4NmPe2p
 iCfVwLa3LHuw7LgzKK7/skzgfvvQCIweWZomSW9RK+4UDBzwqs7BKKhmN4PIkRHxbgmN
 tk1Oz0yfmFqVNYTKeoJ6xsdbq8veMOr0sPQnfhtQ1fvnhwrl6/H4oHkc/VwUGyy/nkub
 wIrcXnAHDIMPdrHllvwGfA6YHpgZsH0DN69jmbWpZmmFj6MQ0gxfu/7nhzbMzEBB2Z0e
 nJ+6j5wovfbX2CwqJwCTtodLkvh42iXs5SV/UzdS4elU/N76uY0WHxl5blGZnOpqVup6
 3gWA==
X-Gm-Message-State: AOJu0YzPE99Q4olNWJqIouLLC+7Lz4jFA4O6+XAwivpGNt3Cm+YRvYUe
 f7p/BWXSFvmOttlibvswRf/TMRsF1Z4tuwLYfc43baTgW+JP0nGhe5OOnM+xOy1OEtd+4/jzvIn
 3NFg=
X-Google-Smtp-Source: AGHT+IEN+F0DTvFJKpujiF3InFCV85vQFfiJB/23reDFUHrBf3TrF3Tsh3DJyQvojGM5C2rslYxFXw==
X-Received: by 2002:a17:902:ccc7:b0:1fa:d1df:d41e with SMTP id
 d9443c01a7336-201ca1d4959mr23977945ad.58.1723504713931; 
 Mon, 12 Aug 2024 16:18:33 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1bd3d6sm1979005ad.236.2024.08.12.16.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 16:18:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2] Reflect recent changes on API (inline ops) and new plugins.
Date: Mon, 12 Aug 2024 16:18:22 -0700
Message-Id: <20240812231822.168034-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst   | 49 ++++++++++++++++++++++++++++++++------
 docs/devel/tcg-plugins.rst | 13 ++++++----
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index c03033e4e95..eea1261baac 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -207,8 +207,8 @@ Once built a program can be run with multiple plugins loaded each with
 their own arguments::
 
   $QEMU $OTHER_QEMU_ARGS \
-      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
-      -plugin contrib/plugin/libhotblocks.so
+      -plugin contrib/plugins/libhowvec.so,inline=on,count=hint \
+      -plugin contrib/plugins/libhotblocks.so
 
 Arguments are plugin specific and can be used to modify their
 behaviour. In this case the howvec plugin is being asked to use inline
@@ -219,6 +219,14 @@ Linux user-mode emulation also evaluates the environment variable
 
   QEMU_PLUGIN="file=contrib/plugins/libhowvec.so,inline=on,count=hint" $QEMU
 
+QEMU plugins avoid to write directly to stdin/stderr, and use the log provided
+by the API (see function ``qemu_plugin_outs``).
+To show output, you may use this additional parameter::
+
+  $QEMU $OTHER_QEMU_ARGS \
+    -d plugin \
+    -plugin contrib/plugins/libhowvec.so,inline=on,count=hint
+
 Example Plugins
 ~~~~~~~~~~~~~~~
 
@@ -260,8 +268,7 @@ Behaviour can be tweaked with the following arguments:
   * - Option
     - Description
   * - inline=true|false
-    - Use faster inline addition of a single counter. Not per-cpu and not
-      thread safe.
+    - Use faster inline addition of a single counter.
   * - idle=true|false
     - Dump the current execution stats whenever the guest vCPU idles
 
@@ -381,6 +388,15 @@ run::
   160          1      0
   135          1      0
 
+Test inline operations
+......................
+
+``tests/plugins/inline.c``
+
+This plugin is used for testing all inline operations, conditional callbacks and
+scoreboard. It prints a per-cpu summary of all events.
+
+
 Hot Blocks
 ..........
 
@@ -394,9 +410,6 @@ with linux-user execution as system emulation tends to generate
 re-translations as blocks from different programs get swapped in and
 out of system memory.
 
-If your program is single-threaded you can use the ``inline`` option for
-slightly faster (but not thread safe) counters.
-
 Example::
 
   $ qemu-aarch64 \
@@ -736,6 +749,28 @@ The plugin will log the reason of exit, for example::
 
   0xd4 reached, exiting
 
+Limit instructions per second
+.............................
+
+This plugin can limit the number of Instructions Per Second that are executed::
+
+    # get number of instructions
+    $ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
+    # limit speed to execute in 10 seconds
+    $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/10)) /bin/true
+    real 10.000s
+
+
+.. list-table:: IPS arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - ips=N
+    - Maximum number of instructions per cpu that can be executed in one second.
+      The plugin will sleep when the given number of instructions is reached.
+
 Other emulation features
 ------------------------
 
diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index d8725c2854a..9463692c411 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -61,11 +61,14 @@ translation event the plugin has an option to enumerate the
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
-- 
2.39.2


