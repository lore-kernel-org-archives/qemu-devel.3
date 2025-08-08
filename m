Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5BC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTuw-00032p-Bh; Fri, 08 Aug 2025 16:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTut-00030X-Jt
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTur-0003E2-4K
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso3127097b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685735; x=1755290535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBrgRzoZK/flg18sYa71Nd0Qxl3OyImP8+lDbDt1BL8=;
 b=KMLc3gXhpRxfE27Vri4Rj/kcpN/dfj9H7nPkc7ag7iHhm5DJ1NO0QfS3qQUaeIHWEG
 bVXh0ORqxEQt4UC1hP7ATWnKhJWTna2gObkxQOtGJJ+HYOaDKcwCBfaw7lBorDwMSs6M
 yuSo+aAv9wdrHe+QfboKnTVgqR/0Yv7Dl258hrG2w+VGhlBEAhcNzJUPTrJjPH7Uqhwy
 RSZULyXS83SuaUjPFW1AuXLoh9ra1X8w/Fu1UBpQxqgWJTQsJVqsA0z9P4DVPrTKKdY5
 2tNyJrr3COxFzbkGp42nGW1eJIi5BlrQl956IywSbdXZERZKbogEMlO3PI+KNfwRaFvs
 +TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685735; x=1755290535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBrgRzoZK/flg18sYa71Nd0Qxl3OyImP8+lDbDt1BL8=;
 b=Vn+CY5LNVATNZgnjyzNMQA2Fo7E0Y7w5XkTW0DJMEbkT4ZDut8xDCAobsWIumErXfp
 sVVeCLfV9A+mIK2o9I3eiDmyMzoQwF9llXBMZwvLvpoBtCUztEQC6p6kzKg8faqAyGpq
 gu+nK4jE6arSe59tJGPNnaTY1zk0xzp0xLZ+1v29F+rc9WZ+ASKkN2VOupTX20EYGlYw
 f7fgNVAbqC4Fc6Jv5ZbJ+EUg6ymMNSvsUvseza48oAJYUxcDIfs7tfh91MptjTtJ+neP
 J3mjbta8JtdoJokkP9aiGSda3bhBjoOVqjAnh/Wds98k4KElTuohu3iIrf70AK6R/70O
 SfcQ==
X-Gm-Message-State: AOJu0YxfXDceo+pkB8XiaVYdSaPXN2R+DlbxqVfz6/DosY6q7hvdFBV3
 GxSwGBlhtGapUrjOjcMkRuaJy/kiAk92dWHKE7kxwIM18hZnRBAN36Sqjy1gJGtItSpw9ioLpN/
 OjJIXUPIDrg==
X-Gm-Gg: ASbGncvzW1gsD5/vgSOe1c//VdKnDtoXpJRnonKiDxzj/4o6wbFAzHhhWIP9j1MWeJj
 2QEjVFQD8vWCD/0kUZ0N2pU/4nVa8/0SHSLWLLNqMJf8w4Pb3gSzlGNoKkNgjtBDj/ndfghepoj
 CgdG6WcoFrdplucCNfS+0hlZuwk0BdW/8WvNSrY19kaFWUTGZgUaHzn8UUSYNCuIVlixweOxx7v
 e/ybJqUwOS/Gy7a61gMmZPdvTXRumNXF6mo9DuuN13m1B5V3M3sDeVLqGomc0UWTg+LbswxVIO2
 /JNAWvBpJ0fGNLvayoJX3PClmb5/WHCBH8iPLj47ekBlfft+BsUABDsDW2EJWLAv1xqNdrI4Odx
 D+4EAorGhpqq8/H1dNiVNwYS6F8mGUiob
X-Google-Smtp-Source: AGHT+IF7UcVgLxvOp9+Ku41zFxfGi/9ehGrc/hJoGFDp15lJcH/HVvIHagevNXWPh+26SeCTJ4d+ng==
X-Received: by 2002:a17:902:fc48:b0:242:b103:18e with SMTP id
 d9443c01a7336-242c226035amr64644015ad.50.1754685735474; 
 Fri, 08 Aug 2025 13:42:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org,
	pierrick.bouvier@linaro.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 9/9] contrib/plugins/uftrace: add documentation
Date: Fri,  8 Aug 2025 13:41:56 -0700
Message-ID: <20250808204156.659715-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

This documentation summarizes how to use the plugin, and present two
examples of the possibilities offered by it, in system and user mode.

As well, it explains how to rebuild and reproduce those examples.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 199 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b08..8a5e128f677 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -816,6 +816,205 @@ This plugin can limit the number of Instructions Per Second that are executed::
       The lower the number the more accurate time will be, but the less efficient the plugin.
       Defaults to ips/10
 
+Uftrace
+.......
+
+``contrib/plugins/uftrace.c``
+
+This plugin generates a binary trace compatible with
+`uftrace <https://github.com/namhyung/uftrace>`_.
+
+Plugin supports aarch64 and x64, and works in user and system mode, allowing to
+trace a system boot, which is not something possible usually.
+
+In user mode, the memory mapping is directly copied from ``/proc/self/maps`` at
+the end of execution. Uftrace should be able to retrieve symbols by itself,
+without any additional step.
+In system mode, the default memory mapping is empty, and you can generate
+one (and associated symbols) using ``contrib/plugins/uftrace_symbols.py``.
+Symbols must be present in ELF binaries.
+
+It tracks the call stack (based on frame pointer analysis). Thus, your program
+and its dependencies must be compiled using ``-fno-omit-frame-pointer
+-mno-omit-leaf-frame-pointer``. In 2024, `Ubuntu and Fedora enabled it by
+default again on x64
+<https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointers.html>`_.
+On aarch64, this is less of a problem, as they are usually part of the ABI,
+except for leaf functions. That's true for user space applications, but not
+necessarily for bare metal code. You can read this `section
+<uftrace_build_system_example>` to easily build a system with frame pointers.
+
+When tracing long scenarios (> 1 min), the generated trace can become very long,
+making it hard to extract data from it. In this case, a simple solution is to
+trace execution while generating a timestamped output log using
+``qemu-system-aarch64 ... | ts "%s"``. Then, ``uftrace --time-range=start~end``
+can be used to reduce trace for only this part of execution.
+
+Performance wise, overhead compared to normal tcg execution is around x5-x15.
+
+.. list-table:: Uftrace plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - trace-privilege-level=[on|off]
+    - Generate separate traces for each privilege level (Exception Level +
+      Security State on aarch64, Rings on x64).
+
+.. list-table:: uftrace_symbols.py arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - elf_file [elf_file ...]
+    - path to an ELF file. Use /path/to/file:0xdeadbeef to add a mapping offset.
+  * - --prefix-symbols
+    - prepend binary name to symbols
+
+Example user trace
+++++++++++++++++++
+
+As an example, we can trace qemu itself running git::
+
+    $ ./build/qemu-aarch64 -plugin \
+      build/contrib/plugins/libuftrace.so \
+      ./build/qemu-aarch64 /usr/bin/git --help
+
+    # and generate a chrome trace directly
+    $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
+
+For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
+<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
+Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
+using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
+Some sequences taken from this trace:
+
+- Loading program and its interpreter
+
+.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
+   :height: 200px
+
+- open syscall
+
+.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
+   :height: 200px
+
+- TB creation
+
+.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
+   :height: 200px
+
+It's usually better to use ``uftrace record`` directly. However, tracing
+binaries through qemu-user can be convenient when you don't want to recompile
+them (``uftrace record`` requires instrumentation), as long as symbols are
+present.
+
+Example system trace
+++++++++++++++++++++
+
+A full trace example (chrome trace, from instructions below) generated from a
+system boot can be found `here
+<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
+Download it and open this trace on https://ui.perfetto.dev/. You can see code
+executed for all privilege levels, and zoom in/out using
+:kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
+taken from this trace:
+
+- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
+
+.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
+   :height: 200px
+
+- U-boot initialization (until code relocation, after which we can't track it)
+
+.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
+   :height: 200px
+
+- Stat and open syscalls in kernel
+
+.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
+   :height: 200px
+
+- Timer interrupt
+
+.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
+   :height: 200px
+
+- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
+
+.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
+   :height: 200px
+
+Build and run system example
+++++++++++++++++++++++++++++
+
+.. _uftrace_build_system_example:
+
+Building a full system image with frame pointers is not trivial.
+
+We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
+build an aarch64 system, combining Arm Trusted firmware, U-boot, Linux kernel
+and debian userland. It's based on containers (``podman`` only) and
+``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
+on machine where you build it.
+
+You can follow the exact same instructions for a x64 system, combining edk2,
+Linux, and Ubuntu, simply by switching to
+`x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
+
+To build the system::
+
+    # Install dependencies
+    $ sudo apt install -y podman qemu-user-static
+
+    $ git clone https://github.com/pbo-linaro/qemu-linux-stack
+    $ cd qemu-linux-stack
+    $ ./build.sh
+
+    # system can be started using:
+    $ ./run.sh /path/to/qemu-system-aarch64
+
+To generate a uftrace for a system boot from that::
+
+    # run true and poweroff the system
+    $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on
+
+    # generate symbols and memory mapping
+    $ path/to/contrib/plugins/uftrace_symbols.py \
+      --prefix-symbols \
+      arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
+      arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
+      arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
+      u-boot/u-boot:0x60000000 \
+      linux/vmlinux
+
+    # inspect trace with
+    $ uftrace replay
+
+Uftrace allows to filter the trace, and dump flamegraphs, or a chrome trace.
+This last one is very interesting to see visually the boot process::
+
+    $ uftrace dump --chrome > boot.json
+    # Open your browser, and load boot.json on https://ui.perfetto.dev/.
+
+Long visual chrome traces can't be easily opened, thus, it might be
+interesting to generate them around a particular point of execution::
+
+    # execute qemu and timestamp output log
+    $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on |&
+      ts "%s" | tee exec.log
+
+    $ cat exec.log  | grep 'Run /init'
+      1753122320 [   11.834391] Run /init as init process
+      # init was launched at 1753122320
+
+    # generate trace around init execution (2 seconds):
+    $ uftrace dump --chrome --time-range=1753122320~1753122322 > init.json
+
 Other emulation features
 ------------------------
 
-- 
2.47.2


