Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E11CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HPz-0005dy-Vn; Thu, 02 Oct 2025 07:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPr-0005cA-0X
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:07 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPb-0005be-TI
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:06 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-72ce9790acdso10459257b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404224; x=1760009024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/R5lzi/iXxvsb0xAjrue9SnyxZX/inc1472pC8H2YuE=;
 b=aGeZJemV27kj4KG6Vd3+4IMIdlXvXvO0N/IQfOmwakLgJD26tvvNGRChT5+nKoEjzM
 KazlnhtR37XE5rawmfQDmioJBVJOdMbpuxksWX+C4aIfLsuv2ns8Tk0EVKTVmMG+72JG
 nc7YuRipDgEcAf7wAq+3i7+dTopxdK+UaxFj8blaRREeuSHSxJOXqegz30VivXcvuvq/
 xvt/I8nF5uEzKGxnpOvsZHC/odFN2yJcg0e0mUddPBfbfukOJUx9eWb+z9ZJTYpmiT3c
 od7tupdVwC3jwpSeNcZLfYhGCLJoT09Ng/SoJN6hP4NbvbPQxBye9H1xG07xBGtb3vxb
 //qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404224; x=1760009024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/R5lzi/iXxvsb0xAjrue9SnyxZX/inc1472pC8H2YuE=;
 b=kFfR/7ZqPuh6RPXF1ahbSSwfSkLfPUsEp+IX1g48aChvPF6La00PJDoDlhifXQpP0V
 L/kbq77qJyfXVwtGTCQ9drDmBt9JGRG2rchhUx8W3bBV2ommjF0T9+Av/Z16Hzl6E8im
 /5ngy/TuStSgrLEgRidQF1M/DMYl7sAweb0WA5HBGmdxjfzsvEl2lehaelLOPhg3P8lu
 tSp5kLWkwJnWRuf2IAIpCB4TY1tWvCJMOAFVKBxWj/Rbat33ncr4RBvQcKNU3NBNPHU+
 odK1E2x0TLt3wKaMgegZrIAfVDOuWKZU+63fHf0KMzrEUEs5d6MS7xns+ITC9eeD3o2b
 8hXQ==
X-Gm-Message-State: AOJu0YyjGVFkt3FCRwGNs0rv0rMEPyvw35DWkxeIFWEFSx5k0BapvyWX
 e6+cOLQOY0qNQMwdEBgbAZJdsVWII8ICRKbPLuzBpVFbRW50k6p1F/LAQyXFTaPrNnjZzkYqiE9
 vhLhyFYw=
X-Gm-Gg: ASbGncvmosXog2yICO8n0X6X9EVqULKwwen8Uo+vHW3GOlyf9hAZKDTBloNpCVTnCfx
 G4rMZgwuozgY+ol2sspAe6w66Fi9k/OOyO02CKxJCHXhWGYczNJsEGApzsjBd0vLa2tamsK1+mt
 zBWJLp39wEVjY/khjhLJauEnSMu6jOMUSphjXguEydCXPUCGDqompch9UHqfEZlZfFvP0Spfj6j
 XXnRVN1koKVpcdGUg2DzdhxI27ck4xiHu19PXx+8mHL3tKdcSoTTcgDpwNO/rI5j0iW/HrdRjha
 liYYbcYOe+I1rWwN7pvLyZ8wXRSk0UlcZVaOfzN+25hR5pmJK+XEaJgLA+EdyElYkkc6FUn8wHR
 2B1kXIbdfT2n3U6+T2+ZFOQ11Vm88LLtznTaddYqdqWsbxy/GPHNCAfd6szhpasYKm+GMOHrxRf
 8=
X-Google-Smtp-Source: AGHT+IFHZYxq8DsucnnzorQgJRxLIBlkNXYvwXz8tEn+QVV0D0bAuI+yZfbJOQLn839mWcaUOXeYvw==
X-Received: by 2002:a05:690c:930c:10b0:749:bc9a:6498 with SMTP id
 00721157ae682-77f6f1358c0mr91442007b3.1.1759404224116; 
 Thu, 02 Oct 2025 04:23:44 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:23:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 00/17] hw/riscv, target/riscv: initial e-trace support
Date: Thu,  2 Oct 2025 08:23:18 -0300
Message-ID: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1131.google.com
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

Hi,

This series implements the Efficient Trace (e-trace) for RISC-V [1].
This is a hardware level trace similar to what we found in other archs
like ARM's CoreSight. The implementation is based on [1] and also on the
RISC-V Trace Control Interface Specification [2].

Only a subset of all available features are implemented in this work.
The idea is to contribute it back and allow others to keep incrementing
it on demand. 

The design implemented is the simplest topology allowed by the specs:
one trace encoder/trace ram sink pair per CPU. This topology was added
in the 'virt' machine. We took kernel side considerations when adding
the FDT for these components. More info on patch 05.

A lot of design decisions/simplifications were made considering how the
TCG emulation works. I attempted to justify them in the commit messages
when relevant. 

Linux kernel driver support is available here:

https://lore.kernel.org/linux-riscv/20251002060732.100213-1-apatel@ventanamicro.com/

It includes steps on how to test both the kernel and QEMU support in its
cover letter. I'll add those steps in our own QEMU documentation,
including the capabilities implemented, limitations and so on, in the
following versions of this work. 


@Richard: if you could take a look at patch 07 I appreciate it. We've
run out of tb_flags in RISC-V DisasContext and I had to be "creative" to
avoid calling trace helpers without a trace session opened.


Patches based on alistair/riscv-to-apply.next. You can also find them
here:

https://gitlab.com/danielhb/qemu/-/tree/rv-etrace


Daniel Henrique Barboza (16):
  hw/riscv: Trace Encoder initial impl
  hw/riscv: Trace RAM Sink initial impl
  hw/riscv/trace-encoder: add trace start/stop logic
  hw/riscv/virt.c: add trace encoders and trace ram sinks
  hw/riscv: add e-trace message helpers
  target/riscv: add initial trace instrumentation
  hw/riscv/trace-encoder: write e-trace packets to RAM sink
  test/qtest: add riscv-trace-test.c
  hw/riscv/rv-trace-messages.c: add encoded trap message
  hw/riscv, target/riscv: send trace trap messages
  target/riscv, hw/riscv: send trace ppccd packets
  hw/riscv/trace: add format2 msg helper
  hw/riscv, target/riscv: send resync updiscon trace packets
  hw/riscv/rv-trace-messages: add format 1 msgs with branch info
  hw/riscv/trace-encoder: send branches info
  hw/riscv/trace: update branch bit in sync messages

Mayuresh Chitale (1):
  hw/riscv/virt.c add trace encoder and ramsink fdt nodes

 hw/riscv/Kconfig                              |   5 +
 hw/riscv/meson.build                          |   2 +
 hw/riscv/rv-trace-messages.c                  | 373 +++++++++++
 hw/riscv/rv-trace-messages.h                  |  40 ++
 hw/riscv/trace-encoder.c                      | 609 ++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  62 ++
 hw/riscv/trace-events                         |   9 +
 hw/riscv/trace-ram-sink.c                     | 263 ++++++++
 hw/riscv/trace-ram-sink.h                     |  83 +++
 hw/riscv/virt.c                               | 135 ++++
 include/hw/riscv/virt.h                       |   2 +
 target/riscv/cpu.h                            |  11 +
 target/riscv/cpu_helper.c                     |  26 +-
 target/riscv/helper.h                         |   6 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  11 +
 target/riscv/insn_trans/trans_rvi.c.inc       |  15 +
 target/riscv/meson.build                      |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |   5 +
 target/riscv/trace_helper.c                   |  62 ++
 target/riscv/translate.c                      |  21 +
 tests/qtest/meson.build                       |   2 +-
 tests/qtest/riscv-trace-test.c                | 120 ++++
 22 files changed, 1862 insertions(+), 3 deletions(-)
 create mode 100644 hw/riscv/rv-trace-messages.c
 create mode 100644 hw/riscv/rv-trace-messages.h
 create mode 100644 hw/riscv/trace-encoder.c
 create mode 100644 hw/riscv/trace-encoder.h
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h
 create mode 100644 target/riscv/trace_helper.c
 create mode 100644 tests/qtest/riscv-trace-test.c

-- 
2.51.0


