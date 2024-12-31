Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A211E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 03:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSSuQ-00088m-OW; Mon, 30 Dec 2024 22:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuP-000886-IO
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:05 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuN-00069K-30
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:05 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166f1e589cso154396085ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 19:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1735615621; x=1736220421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1BdhEHApuM1QJiriFTI81DbP+u7pPp8MazpUKN1r2ys=;
 b=HHRznToLvAGjRyJEDBy2rKi2bMplsvckXH754CAeU0jGvh6OYFeZVi5iUHnIHjL+Hs
 q5Fw6R8MX7MCaucZb9o8Zv5RZ+xa8s/AQKgHtYw4UWpqIjuCpncA+hQEmP4twNPx63S9
 PEZa75lY4H1/cHiN6sGgb8C/WYl2WS6AFhK4RFep7Us/sL3av5hHL/bHAodeRxEwn0T/
 R8+OMlmLT8ijP1kEuIu1T2CYUOFYW2L4Mx3OkXr0xNz8x3ZCmHmYGlIJdcqOpExG5SkW
 Nr50QFCtMQM9SF7j6mQBrFt17JKo0uULQpmO8EXbwB1viibsrTqLLMWFZXR7yBDKoelh
 DPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735615621; x=1736220421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1BdhEHApuM1QJiriFTI81DbP+u7pPp8MazpUKN1r2ys=;
 b=jwr5dFdUzVqNl8caASWfTFx7Anb35B3B3FQKoC+BtKqk7DZT0RZ1xVlHNp0bcAemUe
 x8+PQYNFq/l1sWaoRm0Yy/UuohnF/XVthYHjF1eBYXIPJEn8fARFXQK3nDWPj3wvej1Y
 2VOXR1xEA4I5K0fl0xjTi7yKxPIdGVGYLbSWR3Vl/7GTCKv/e68Y3cJMZol8FQ8y6qcg
 G7oehZiSBH+cHY13XJY00amaDc/hzlyZugPSSqFkUyCkliIzHkc9yN1/xOi0IgVnzobs
 baiQAzCgXEsMJo+HOUP8btESpZMl0//AytNkliLMrZHfyapGpL3/O84vWJY4QZR41NFM
 cQMw==
X-Gm-Message-State: AOJu0Yxlz3KwWCjtaKUnu82r+kS5+9T7QQ/XqTjdRJrIeV697XMjBXNC
 sKzrZp+kWY6+H0X+Njf9AXwcoGD6vv72a7oKriEOcI+0r+Uqb5eSYJIPH06ALAImTtXf+o4HF7p
 xkhnErYKdA2+ggsZ5OQw43Bu0q1TPRwndPP9WE6qLCgZW5lDN2dtYz9efOwN6Oe6MfS4C8NUCGC
 gjbvbJPu2jHYUe8E1QvUDGLJDs72LUYVBVz7xe6E9XJEn6
X-Gm-Gg: ASbGncudLX9/5yhNiBZIJVsTt5WIOlajrGWGuDeGpVW7oRnB9SldMJ4wbiLIWyue9Vh
 pY3fgrMUEz8NsqtKXxVVF5xyi5Fwif3NY4SS8klgqCejNgBdUUcr9CujF0/N63+j3Jmg1JUokee
 df/VrO8vTydTvS6gn4KPxKUHCkMAH82lIGUulcUyFagMIPM8Xz0SLA0TJ+/WwHvdHMuZ9dW4dIE
 IcpW5lBoQ3kEGkm9BY62xWETylal+CEV1i4iNzPAE1ha2GEcOaqcnqetLdzCgZ6DZL7KJQ9bVC+
 UZX7o8ijGxuWqNy5QHVN
X-Google-Smtp-Source: AGHT+IG0J0Bvflhtho7hItRGQNENUSJ69a4w5qv3x308CDWVvLkrwBoNbvhNrC2SdUzMep7vYcDs/g==
X-Received: by 2002:a05:6a21:1506:b0:1e1:9fef:e960 with SMTP id
 adf61e73a8af0-1e5e043f675mr58019268637.6.1735615620570; 
 Mon, 30 Dec 2024 19:27:00 -0800 (PST)
Received: from fchang-1826.. (1-169-235-48.dynamic-ip.hinet.net.
 [1.169.235.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-92587c62eacsm291797a12.21.2024.12.30.19.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 19:27:00 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v11 0/6] Add Smrnmi support
Date: Tue, 31 Dec 2024 11:26:48 +0800
Message-Id: <20241231032654.133039-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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

From: Frank Chang <frank.chang@sifive.com>

This patchset added support for Smrnmi Extension in RISC-V.

There are four new CSRs and one new instruction added to allow NMI to be
resumable in RISC-V, which are:

=============================================================
  * mnscratch (0x740)
  * mnepc     (0x741)
  * mncause   (0x742)
  * mnstatus  (0x744)
=============================================================
  * mnret: To return from RNMI interrupt/exception handler.
=============================================================

RNMI also has higher priority than any other interrupts or exceptions
and cannot be disabled by software.

RNMI may be used to route to other devices such as Bus Error Unit or
Watchdog Timer in the future.

The interrupt/exception trap handler addresses of RNMI are
implementation defined.

If anyone wants to test the patches, we can use the customized OpenSBI[1],
and the customized QEMU[2].

We implemented a PoC RNMI trap handler in the customized OpenSBI.
In the customized QEMU, we use the Smrnmi patches and the patch from
Damien Hedde[3]. The patch from Damien Hedde can be used to inject
the RNMI signal with the qmp command.

[1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
[2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v11
[3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html

Test commands :
$ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=true,
rnmi-interrupt-vector={Offset of the RNMI handler in the customized
OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
-bios fw_jump.elf -kernel Image -initrd rootfs.cpio
-qmp unix:/tmp/qmp-sock,server,wait=off

Use qmp command to inject the RNMI.

Assert RNMI:
$ ./scripts/qmp/qmp-shell /tmp/qmp-sock
(QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=true

De-assert RNMI:
(QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=false

Changelog:

v11
  * Squash patch 7 into patch 5.
  * Remove "DEFINE_PROP_END_OF_LIST()" from "riscv_harts_props[]" for
    the upcoming "DEFINE_PROP_END_OF_LIST()" removal.

v10
  * Disable Smrnmi for the 'max' type CPU.

v9
  * Add Zicfilp support for Smrnmi.
  * Change the existence checks for 'rnmi-interrupt-vector' and
    'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpvec'.
  * Add warn_once messages for cases where the user sets
    'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
    enabling Smrnmi.

v8
  * Set virt to false when trapping to M-mode by RNMI.
  (Thanks to Clément for the suggestions.)

v7
  * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
    checking codes.
  (Thanks to Clément for the suggestions.)
  * Add the missing REQUIRE_SMRNMI() check and remove the redundant
    check in 'helper_mnret'.
  * Rebase to riscv-to-apply.next.
  (Thanks to Alistair for the suggestions.)

v6
  * Delete the redundant code in 'riscv_cpu_do_interrupt'.
  (Thank Alvin for the suggestion.)
  * Split the shared code in 'helper_mret' and 'helper_mnret' into a
    helper function 'check_ret_from_m_mode'.
  (Thank Alistair for the suggestion.)

v5
  * Move the patch that adds the Smrnmi extension to the last patch.
  (Thank Alistair for the suggestion.)
  * Implement an M-mode software PoC for this with implemented handlers.
  (Thank Andrew Jones for the suggestion.)
  * Add a commit message to all patches of the series.
  (Thank Andrew Jones for the suggestion.)

v4
  * Fix some coding style issues.
  (Thank Daniel for the suggestions.)

v3
  * Update to the newest version of Smrnmi extension specification.

v2
  * split up the series into more commits for convenience of review.
  * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.

Frank Chang (1):
  target/riscv: Add Zicfilp support for Smrnmi

Tommy Wu (5):
  target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
  target/riscv: Add Smrnmi CSRs
  target/riscv: Handle Smrnmi interrupt and exception
  target/riscv: Add Smrnmi mnret instruction
  target/riscv: Add Smrnmi cpu extension

 hw/riscv/riscv_hart.c                         | 42 +++++++-
 include/hw/riscv/riscv_hart.h                 |  4 +
 target/riscv/cpu.c                            | 18 ++++
 target/riscv/cpu.h                            | 10 ++
 target/riscv/cpu_bits.h                       | 24 +++++
 target/riscv/cpu_cfg.h                        |  1 +
 target/riscv/cpu_helper.c                     | 96 +++++++++++++++++--
 target/riscv/csr.c                            | 82 ++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
 target/riscv/op_helper.c                      | 54 ++++++++++-
 target/riscv/tcg/tcg-cpu.c                    |  6 ++
 13 files changed, 349 insertions(+), 12 deletions(-)

--
2.34.1


