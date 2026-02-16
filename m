Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E48E83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7SH-0001hs-GW; Mon, 16 Feb 2026 17:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7SE-0001hP-3f
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:35 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7SC-0006Qr-IS
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837584120eso23470625e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282351; x=1771887151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FvpYsvVz0njvhav/k+RkLNonp6k+us6Bz/UhZrU2Jio=;
 b=DO4J3m4cr8QPr+wV2TA6QEmk+MPXOQJilBoC7x3vufUup56Ybh0u6/+4ohEY5O6Iou
 Se2TneRm3DOJj14b4Rv0cfb7C0oVPoDlihtnuAtrdPIYvU1+VN+gbDch5DvU65tC4wh/
 4MdbbHLbsRlzcSAX9CaZxjOVGrQfAPoMGSd6KKYtbR8Yo+vwMzSL+H3wL6zo1QG7oN0L
 uBw4HjkhADXVQhJSbcpfyz6F/guS2/OtBwRchT8yFjiUyVG5/fX47cAGZRCHkAvmjrc6
 CTGHL4wTLel+v85RMUrPqzLWvQgLqT1T5ahZk7F5hh8OOBYOoL/LtFSxachWYxFSg+Sz
 7HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282351; x=1771887151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvpYsvVz0njvhav/k+RkLNonp6k+us6Bz/UhZrU2Jio=;
 b=H6rjTRHCQrwgXMeDnf+F7lHuo2pfXXG9wytgjZAHgOBZ4dvfvjB6+rEmRNZlu/7Lmx
 v+a/ZMQ80ELmdXd6mh43GhiYhRlqDVU+iAWA6N40BBXanmYGJiZpbRr0nEGPBn9UYCVV
 DCFSfyCXr/yYA4xzFLYsNzS5KWyiRvRtXTa7dRMctBahhp1nDiij5Z4BUr0N+xo8M4Sq
 s+yQosHeMoH2pzCF8OfLldM0c0ZcHCuYbolWG09P+5a30RgaF6rD0GOXZ1BKTCoC6UVk
 OjBf54JBr7AMW3xvKI0j9LK6Nvde0aLlGhQhCXvN/gVVgpy/1JCXwQQo60ZjmKCvh3Jc
 cWJg==
X-Gm-Message-State: AOJu0Yw/C1SKUTFlHyOyluOBtWL3MSSLFp7CvuvCQE+B0U0B+aiBYE0h
 6RiyE54FoDYWox4t/yil0av+FFeNftJk7v8KSz0dblq+d3oHQ51CgtEfbWmJ1jMo6CeXhL8CA5V
 xpf+Seio=
X-Gm-Gg: AZuq6aJi4PLKN3pmSMxA4I/JeqmyhGplE8QhtTwccV9eNxC9S2C+pOHY0mszQcAupDM
 H27S4banaCIs/CBkuN0SBnSHH4ZlTwLpcpdJ2BhIahOywlHJm9tFItFBZFF/sjLm/VHCCOf6f2g
 T9AyoZ4s/F4ljW+oU+ecVq631yl784IjC8d0BvZLqvEGUFmLqFUEYwe6FhJvwP2nbjGqChoyzKD
 J/0k1PSmyuuFMh1xDj4LSfS6PWRIqJXJvurkU75IH0p4auFvYmEoYOr62a5vhaVdPCxPKkXuRBd
 XQWqRyZrRjdw2kjBf27b8QFwebuuU/alJaffTzgavUyljYA2oobi5C2pNE9Ba8F5jDplil+FdxO
 hWvLg3uY4eWLMa+F/4nE/0+3CVnSC3in7fW1aTcnNjCse3qD8RgrMW/2d278e/EVOZiEur1LFJ8
 tVMk3rlSE3yPLPOJUzA49mm9HXQD2tCw5+5xxYrcWGx0MjCtZPFB+X5aAF/6yW7RGatjVvjK+Na
 j6QrmTEDrw=
X-Received: by 2002:a05:600c:8b30:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-48379bd7462mr165446135e9.17.1771282350586; 
 Mon, 16 Feb 2026 14:52:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad0166sm30751164f8f.35.2026.02.16.14.52.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:52:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 00/11] monitor/hmp: Automatically handle gdb-xml exposed
 registers
Date: Mon, 16 Feb 2026 23:52:16 +0100
Message-ID: <20260216225228.53959-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

MonitorDef registers parsing is one of the oldest APIs in QEMU,
thus predates gdbstub and XML register files. The latters are
maintained by the GDB/binutils project and are more up-to-date.
Getting the target register list from them allows to expose
all accessible registers to the HMP commands.

This series adds gdb_get_register() to monitor to use XML
generated registers, and remove the legacy MonitorDef entries
which became unreachable.

First we need to have the SPARC target better follow the
gdb-xml API.

Philippe Mathieu-Daudé (11):
  target/sparc: Introduce sparc_cpu_register_gdb_regs() stub
  target/sparc: Restore 'gdb-xml/sparc64-cp0.xml'
  target/sparc: Restore 'gdb-xml/sparc64-fpu.xml'
  target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
  target/sparc: Expose gdbstub registers to sparc32plus target
  target/sparc: Expose gdbstub registers to sparc32 targets
  monitor/hmp: Handle gdb-xml exposed registers via  gdb_get_register()
  target/sparc: Remove MonitorDef register entries available via gdbstub
  target/i386: Remove MonitorDef register entries available via gdbstub
  target/m68k: Remove MonitorDef register entries available via gdbstub
  target/ppc: Remove MonitorDef register entries available via gdbstub

 configs/targets/sparc-linux-user.mak          |   1 +
 configs/targets/sparc-softmmu.mak             |   1 +
 configs/targets/sparc32plus-linux-user.mak    |   1 +
 configs/targets/sparc64-linux-user.mak        |   2 +-
 configs/targets/sparc64-softmmu.mak           |   2 +-
 target/sparc/cpu.h                            |   1 +
 monitor/hmp.c                                 |  49 ++-
 target/i386/monitor.c                         |  35 ---
 target/m68k/monitor.c                         |  18 --
 target/ppc/ppc-qmp-cmds.c                     |   5 -
 target/sparc/cpu.c                            |   9 +-
 target/sparc/gdbstub.c                        | 295 +++++++++++-------
 target/sparc/monitor.c                        | 107 -------
 gdb-xml/sparc32-cp0.xml                       |  18 ++
 gdb-xml/sparc32-cpu.xml                       |  42 +++
 gdb-xml/sparc32-fpu.xml                       |  42 +++
 gdb-xml/sparc64-cp0.xml                       |  16 +
 gdb-xml/sparc64-cpu.xml                       |  42 +++
 gdb-xml/{sparc64-core.xml => sparc64-fpu.xml} |  44 +--
 19 files changed, 403 insertions(+), 327 deletions(-)
 create mode 100644 gdb-xml/sparc32-cp0.xml
 create mode 100644 gdb-xml/sparc32-cpu.xml
 create mode 100644 gdb-xml/sparc32-fpu.xml
 create mode 100644 gdb-xml/sparc64-cp0.xml
 create mode 100644 gdb-xml/sparc64-cpu.xml
 rename gdb-xml/{sparc64-core.xml => sparc64-fpu.xml} (59%)

-- 
2.52.0


