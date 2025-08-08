Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3149C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJnE-0007Re-Hl; Fri, 08 Aug 2025 05:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJn9-0007Q8-U7
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:53:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJn7-0004hj-EY
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:53:39 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-af939afe5efso238095166b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754646815; x=1755251615; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=45H3CvWXDBt7GuvDFW3rAyKYhmVQPkAP6SQMTfLRB8Y=;
 b=FSLaPYshYmT4puu+J5krrjHrD4fH+YAH3u8F6oO/JD4oSHu2oaUL8d5pTWX8if90xz
 zBCmb5+YSo38ydv6g8TSnZ2jnI6Jl9QvSwTDEDidBqBRYtE4a4B6B/Lsxu97ZGjQ1eGG
 bDt83yJO6D9RK/XRVglN2rmsMQiVL2tEvpsW5aEs8s3U6oVMa/1yqxsSDBxLls4zOE6n
 SUzLL1Nzn6JvQQmUbeovOFylZP6sHUS+DbV0pPbyqmldPahwxgiYDg9jppQ6WBV2uHh0
 mDqcXY5JRXo4LJ+D9UIuavN7YTR0AOKfgmdJvkZBBpJp2mR7bNfJX3ZKq2XBp8ykU+NZ
 KtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754646815; x=1755251615;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45H3CvWXDBt7GuvDFW3rAyKYhmVQPkAP6SQMTfLRB8Y=;
 b=Qsiy9DaYJ7LMGdESV2kh8xIDXquMD7ntAhcfwcFoj5Ao/6UQc5RyzN1G15BMAW1WAk
 yNLOMQcCZt0YpIqifXnXHLq7sL6GGz/qZLy6VreY49A1HJ+uXrr7Pd8KC8pGEiVXcU3A
 Q3//x1OTh/o/8J4tjg2iqOC6Bfu/n1wx1fDWxdHzZA+7FT3dVumhFxvY7Kaj12cBo33J
 X6AwSMO+hvKCIP+1+VqtImYvBzhdWqiRbn/fj0AI8yZQ/7Uek2/D4RYbDjXGbhuruIL7
 zIkkgXHMc1/6mOAbuBaHIycI2yAKR8YLDFwaXrWdnHlsM/x47aTGNUJSi+IPOHIRcX1c
 fYJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTztiowkGg1mJ2aRB8+d/0eKpvTPDMFUPSU+ayfQVcAt2Ivh64+xs4ZEtTYVSflzWXtNRP33L7FxB9@nongnu.org
X-Gm-Message-State: AOJu0Yz76ZQBJhelMJdntgKzFgRx7h+37eo4v4aDoM0dnSjvLIRsenBy
 krosPVimNGXb9D5afLevNUoqRwk2cp7E8nwcJo9MD8w/dlxQui6K3Gu0o7R8kYYZ8gQ=
X-Gm-Gg: ASbGncsr64NgfTCu9srMSj9ZDzKVWJyP27NlRXbzIXqneHaLdP1QEwpTKtjGnn8N+M1
 +oJlgEh708xkN/9vy9MV6qu/PqOoLOvLZOpq4kJNSBIsAiKLtXmj/m/6Qo5m0JGopGoYgFSuMsB
 Z09ZCjO4FD1DAViBGouMjjzrM3kp5oDNKCir7oMHMewnrSMRmhI1lA8/UyBpI4iLBWjURrqANvi
 pAF0XhbDKUYzgEYBWkG0u3HhEWnBv1kl5pFnWe6X3thWZ7pp0a/ZkYm7OqENiOTcGwIdRK+3++G
 x0tSBQICeGiynwHvnph2VmvvwdkN3sImwon+5incPCh+Z9wds3E9y3u2zCIMtLjVy9Dz7pJuEOT
 5n3jQAUKa2eVN4GBz4/rqPacOQWQX1+OpyWp2McubpQwRjFE/IehqS0iv32tGA4AVhgY82boGcP
 TRldDvA/A=
X-Google-Smtp-Source: AGHT+IH6E1Cf+amyp4SSj3DG17p6yJ5UA3vYp6CgyL+rvLefb7w/rjHNSmWIw1BAZvL6zZnKJG4xQQ==
X-Received: by 2002:a17:907:7293:b0:af9:a5f8:2f34 with SMTP id
 a640c23a62f3a-af9c652c957mr210712266b.53.1754646814998; 
 Fri, 08 Aug 2025 02:53:34 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a0a37a8sm1472641966b.40.2025.08.08.02.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:53:34 -0700 (PDT)
Date: Fri, 08 Aug 2025 12:46:52 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 9/9] contrib/plugins/uftrace: add documentation
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-10-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-10-pierrick.bouvier@linaro.org>
Message-ID: <t0o659.1do94331ogqw5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Fri, 08 Aug 2025 05:07, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>This documentation summarizes how to use the plugin, and present two
>examples of the possibilities offered by it, in system and user mode.
>
>As well, it explains how to rebuild and reproduce those examples.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> docs/about/emulation.rst | 197 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 197 insertions(+)
>
>diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>index 456d01d5b08..9ce47ac2712 100644
>--- a/docs/about/emulation.rst
>+++ b/docs/about/emulation.rst
>@@ -816,6 +816,203 @@ This plugin can limit the number of Instructions Per Second that are executed::
>       The lower the number the more accurate time will be, but the less efficient the plugin.
>       Defaults to ips/10
> 
>+Uftrace
>+.......
>+
>+``contrib/plugins/uftrace.c``
>+
>+This plugin generates a binary trace compatible with
>+`uftrace <https://github.com/namhyung/uftrace>`_.
>+
>+Plugin supports aarch64 and x64, and works in user and system mode, allowing to
>+trace a system boot, which is not something possible usually.

Now it is!

>+
>+In user mode, the memory mapping is directly copied from ``/proc/self/maps`` at
>+the end of execution. Uftrace should be able to retrieve symbols by itself,
>+without any additional step.
>+In system mode, the default memory mapping is empty, and you can generate
>+one (and associated symbols) using ``contrib/plugins/uftrace_symbols.py``.
>+Symbols must be present in ELF binaries.
>+
>+It tracks the call stack (based on frame pointer analysis). Thus, your program
>+and its dependencies must be compiled using ``-fno-omit-frame-pointer
>+-mno-omit-leaf-frame-pointer``. In 2024, `Ubuntu and Fedora enabled it by
>+default again on x64
>+<https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointers.html>`_.
>+On aarch64, this is less of a problem, as they are usually part of the ABI,
>+except for leaf functions. That's true for user space applications, but not
>+necessarily for bare metal code. You can read this `section
>+<uftrace_build_system_example>` to easily build a system with frame pointers.
>+
>+When tracing long scenarios (> 1 min), the generated trace can become very long,
>+making it hard to extract data from it. In this case, a simple solution is to
>+trace execution while generating a timestamped output log using
>+``qemu-system-aarch64 ... | ts "%s"``. Then, ``uftrace --time-range=start~end``
>+can be used to reduce trace for only this part of execution.
>+
>+Performance wise, overhead compared to normal tcg execution is around x5-x15.
>+
>+.. list-table:: Uftrace plugin arguments
>+  :widths: 20 80
>+  :header-rows: 1
>+
>+  * - Option
>+    - Description
>+  * - trace-privilege-level=[on|off]
>+    - Generate separate traces for each privilege level (Exception Level +
>+      Security State on aarch64, Rings on x64).
>+
>+.. list-table:: uftrace_symbols.py arguments
>+  :widths: 20 80
>+  :header-rows: 1
>+
>+  * - Option
>+    - Description
>+  * - elf_file [elf_file ...]
>+    - path to an ELF file. Use /path/to/file:0xdeadbeef to add a mapping offset.
>+  * - --prefix-symbols
>+    - prepend binary name to symbols
>+
>+Example user trace
>+++++++++++++++++++
>+
>+As an example, we can trace qemu itself running git::
>+
>+    $ ./build/qemu-aarch64 -plugin \
>+      build/contrib/plugins/libuftrace.so \
>+      ./build/qemu-aarch64 /usr/bin/git --help
>+
>+    # and generate a chrome trace directly
>+    $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
>+
>+For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
>+<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.

We should be able to add static files in the docs/ folder that sphinx 
html can link to for images and json. WDYT?

>+Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
>+using w,a,s,d keys. Some sequences taken from this trace:

You can use :kbd:`W` etc for nice key formatting

>+
>+- Loading program and its interpreter
>+
>+.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
>+   :height: 200px
>+
>+- open syscall
>+
>+.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
>+   :height: 200px
>+
>+- TB creation
>+
>+.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
>+   :height: 200px
>+
>+It's usually better to use ``uftrace record`` directly. However, tracing
>+binaries through qemu-user can be convenient when you don't want to recompile
>+them (``uftrace record`` requires instrumentation), as long as symbols are
>+present.
>+
>+Example system trace
>+++++++++++++++++++++
>+
>+A full trace example (chrome trace, from instructions below) generated from a
>+system boot can be found `here
>+<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
>+Download it and open this trace on https://ui.perfetto.dev/. You can see code
>+executed for all privilege levels, and zoom in/out using w,a,s,d keys. You can
>+find below some sequences taken from this trace:
>+
>+- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
>+
>+.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
>+   :height: 200px
>+
>+- U-boot initialization (until code relocation, after which we can't track it)
>+
>+.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
>+   :height: 200px
>+
>+- Stat and open syscalls in kernel
>+
>+.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
>+   :height: 200px
>+
>+- Timer interrupt
>+
>+.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
>+   :height: 200px
>+
>+- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
>+
>+.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
>+   :height: 200px
>+
>+Build and run system example
>+++++++++++++++++++++++++++++
>+
>+.. _uftrace_build_system_example:
>+
>+Building a full system image with frame pointers is not trivial.
>+
>+We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
>+build an aarch64 system, combining Arm Trusted firmware, U-boot, Linux kernel
>+and debian userland. It's based on containers (``podman`` only) and
>+``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
>+on machine where you build it.
>+
>+You can follow the exact same instructions for a x64 system, combining edk2,
>+Linux, and Ubuntu, simply by switching to
>+`x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
>+
>+To build the system::
>+
>+    # Install dependencies
>+    $ sudo apt install -y podman qemu-user-static
>+
>+    $ git clone https://github.com/pbo-linaro/qemu-linux-stack
>+    $ cd qemu-linux-stack
>+    $ ./build.sh
>+
>+    # system can be started using:
>+    $ ./run.sh /path/to/qemu-system-aarch64
>+
>+To generate a uftrace for a system boot from that::
>+
>+    # run true and poweroff the system
>+    $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
>+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on
>+
>+    # generate symbols and memory mapping
>+    $ path/to/contrib/plugins/uftrace_symbols.py \
>+      --prefix-symbols \
>+      arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
>+      arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
>+      arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
>+      u-boot/u-boot:0x60000000 \
>+      linux/vmlinux
>+
>+    # inspect trace with
>+    $ uftrace replay
>+
>+Uftrace allows to filter the trace, and dump flamegraphs, or a chrome trace.
>+This last one is very interesting to see visually the boot process::
>+
>+    $ uftrace dump --chrome > boot.json
>+    # Open your browser, and load boot.json on https://ui.perfetto.dev/.
>+
>+Long visual chrome traces can't be easily opened, thus, it might be
>+interesting to generate them around a particular point of execution::
>+
>+    # execute qemu and timestamp output log
>+    $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
>+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on |&
>+      ts "%s" | tee exec.log
>+
>+    $ cat exec.log  | grep 'Run /init'
>+      1753122320 [   11.834391] Run /init as init process
>+      # init was launched at 1753122320
>+
>+    # generate trace around init execution (2 seconds):
>+    $ uftrace dump --chrome --time-range=1753122320~1753122322 > init.json
>+
> Other emulation features
> ------------------------
> 
>-- 
>2.47.2
>


Sounds comprehensive all in all. I will try to follow the instructions 
and post a Tested-by

For the doc text:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org> 

