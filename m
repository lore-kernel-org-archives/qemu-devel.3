Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2277BCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 07:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl1GV-0008Ah-VB; Mon, 02 Sep 2024 03:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1GU-00089W-9H
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:18 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1GS-0003hT-FA
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:18 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39d3872e542so15588795ab.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725261251; x=1725866051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QkRuAa7cGOQjZ03bvNisJy8dikdL2ilxtOmS1vSCSMw=;
 b=XEQaWrYftZ9RLoAcaYoArWbW3diyVAE0hsX5oio6urZY6brUlvVESyznveMJCD4X68
 Zha8YLrBJIai0NDVz9wlzoisVDRgIL51VRlNLqJa3Fb1qqaVSfrU6LwLb1QUuyS+0QKD
 tF+kIlnyf27Av5rDH1Bwnw80BQdBu4XW0zx/XqZiePMeANzsfSRpDph8W4s/uUgPcNR/
 BmCnjQ3szu3LPGLabg2vn6VMhdtGKSZ7MKahRsBsD0Yq/EVa087hBPZib5tQ1M7Yx36E
 VIRydyPx6PNeBmRbd4KfOJQ4NsFNYmyVJxQIhPVqXQghl97ScB3SorE7VJ1YxogCmlII
 C5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725261251; x=1725866051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QkRuAa7cGOQjZ03bvNisJy8dikdL2ilxtOmS1vSCSMw=;
 b=ajARjwwkZT4X8P3ve+JFanTedNtuTTWZ/eU8aOvUakcCRs2lQcT7ragu0CZsWErC4H
 8FNnANCBDqwlyVPi6SHFekQSkJJ3Z0zpgaumz14rZup71rh/SHU5GPcqhldcsouZ06qp
 18c7np5qBss3qUGfJXhVB06qGMe0zYuvaFSWjjdpm9t6XTJe4c2T9IyeIBRaY/jHNgXc
 IqpoplhRh/IqbtjYqQ4RYhHj3QPVUSISim0NmzrEtzHuHQWuaNwvlS68u62jYh/w9tvH
 CyOeU31x19soVfyuGqrB5kpK8KyJBIFmhFq19x/ZLaQ0xl2ZE86Q46JEJsN6pwwaMwR+
 WhGQ==
X-Gm-Message-State: AOJu0YxcT11//QGswTnth7fPk8Hn6WmmO7WBdZXQRb3+vxFtVq9+BgeD
 pgwzfGp5F19VHcdqV20Lw9rpryuCSQvxY5jGMaShmJm8LZRrih/hPf4JqUHB2v7aq6wcgFzBJ+7
 Z6Sk4lb0AYEin3mL7yAFgq9UxZ6mfpp7i544CltWToRhpDO65yMGPtrw8u3//x+T31LI7lRKkd6
 Wn1be4da/7rBUFfFSSOJnPFBom4R8+FQF+0GE=
X-Google-Smtp-Source: AGHT+IHzRZk8ZdeiHMn1Sw+gSvnegFc+n/3nntQJ1xK7UAt7to67tmLyLWZiS6m/LKDpkHYYGsxg6Q==
X-Received: by 2002:a05:6e02:16c5:b0:39d:55fd:7625 with SMTP id
 e9e14a558f8ab-39f4f55f277mr79052285ab.22.1725261250519; 
 Mon, 02 Sep 2024 00:14:10 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e743252sm6793331a12.15.2024.09.02.00.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 00:14:10 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, ajones@ventanamicro.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v6 0/5] target/riscv: Add Smrnmi support.
Date: Mon,  2 Sep 2024 00:13:53 -0700
Message-Id: <20240902071358.1061693-1-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=tommy.wu@sifive.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
[2] https://github.com/TommyWu-fdgkhdkgh/qemu/tree/dev/twu/master
[3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html

Test commands :
$ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=true,
rnmi-interrupt-vector={Offset of the RNMI handler in the customized
OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
-bios fw_jump.elf -kernel Image -initrd rootfs.cpio
-qmp unix:/tmp/qmp-sock,server,wait=off

Use qmp command to inject the RNMI interrupt.
$ ./scripts/qmp/qmp-shell /tmp/qmp-sock
(QEMU)  gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi
number=0 value=true

(QEMU)  gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi
number=0 value=false

Changelog:

v6
  * Delete the redundant code in `riscv_cpu_do_interrupt`.
  ( Thank Alvin for the suggestion. )
  * Split the shared code in `helper_mret` and `helper_mnret` into a
    helper function `check_ret_from_m_mode`.
  ( Thank Alistair for the suggestion. )

v5
  * Move the patch that adds the Smrnmi extension to the last patch.
  ( Thank Alistair for the suggestion. )
  * Implement an M-mode software PoC for this with implemented handlers.
  ( Thank Andrew Jones for the suggestion. )
  * Add a commit message to all patches of the series.
  ( Thank Andrew Jones for the suggestion. )

v4
  * Fix some coding style issues.
  ( Thank Daniel for the suggestions. )

v3
  * Update to the newest version of Smrnmi extension specification.

v2
  * split up the series into more commits for convenience of review.
  * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.

Tommy Wu (5):
  target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
  target/riscv: Handle Smrnmi interrupt and exception.
  target/riscv: Add Smrnmi CSRs.
  target/riscv: Add Smrnmi mnret instruction.
  target/riscv: Add Smrnmi cpu extension.

 hw/riscv/riscv_hart.c                         | 18 ++++
 include/hw/riscv/riscv_hart.h                 |  4 +
 target/riscv/cpu.c                            | 18 ++++
 target/riscv/cpu.h                            | 10 +++
 target/riscv/cpu_bits.h                       | 23 ++++++
 target/riscv/cpu_cfg.h                        |  1 +
 target/riscv/cpu_helper.c                     | 80 ++++++++++++++++--
 target/riscv/csr.c                            | 82 +++++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
 target/riscv/op_helper.c                      | 49 +++++++++--
 12 files changed, 291 insertions(+), 10 deletions(-)

-- 
2.39.3


