Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7BCD58B0A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 03:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1cMD-0004oq-IX; Sat, 14 Mar 2026 23:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1cMB-0004no-JJ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 23:41:35 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1cM9-0003Uf-1W
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 23:41:35 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so5139305eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 20:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773546091; x=1774150891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVVM+w5YtEgVuUumx4wLK/FVrEJ2UWwyHA2kIqW+YD4=;
 b=bOtbVI/b2FrcplVuUGT8nKaxMnSUDEGIWjljXRyy/4re0pYTBLd+9v5hASJHDJKD+V
 TR/HWPcZ1oKihnLTAXbAn0nvTACwvNhOS5qYpunujGQS3ity1vBb3hGzXLgi+V+uR9T2
 Ubgfi4W1UyU+A4whuD1UcSCTKdzjBkL7cpz3eB+baJGEip89rZA01Yvr27nJfKBq5dhz
 wjKSke4G+IptTb7WAEu/v/P8kMalzGmbmBszQL+poADs+oTcI53wO2D9hwEDqP1AMBcv
 CnJ7V74XBx5h1YX1LU4eZ5n6pqSwuHwmisYFvYfqXES/SC0spA9qCW+HcCt5vUCT1rkk
 HM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773546091; x=1774150891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XVVM+w5YtEgVuUumx4wLK/FVrEJ2UWwyHA2kIqW+YD4=;
 b=nX8H+thNf7zWs9UovjGPltC+oYurJbozulcIKdcyVvwCUouYEwEPteNFnAHyILIo6Y
 oUMCzVynVsZ0shGM6Y6dAjoBv4GAc9Lpe5wxFM62CajSLUh4JVLbKjT2PmVHSXVOLVlW
 +7UbltH0eWjOk3jE3FBsnCnzWMl81YqhkjvsaQ0u7A0Rm3b4QByivH9WIK6nXnI9GONe
 zDWZuT9cuDoalzGgqjQhOkeQAeSMuFsiiJBFL4/VhpMOjTxcYl+VukvNd3qDUNUQ5jFH
 ihzfjToIekKKLrClNUg/KV6xIB+P5Mw2QCk6Rr5K5gqbQBqT46cOjOMTLHUkV+xopFzp
 bJ9g==
X-Gm-Message-State: AOJu0Yz+a46wQbAZxbeoKkmXPShWq9nCJJCXddrzL6/c5EjCyLoTrh0n
 x6bFlqYqJEUiCiGdCHXtvGzommWR9doYP83d4LkCIbEMQnvLmzPMNI9Yhi0tQePY
X-Gm-Gg: ATEYQzxjjQ04rSYAxpM+zN818WcFayGGzVT90RqnSsatusuUj06wsUjdE5qMGNQdwae
 oc10OHXvACkS8GNvIN7f3UgJUw9fQKSWeui01qK+H/ZQB2J4jXPhk7pKkmcQpWKEJgshU3iVk2o
 uZPyND2MO62uwME5fySIrfERBRaQNbSZzuTE5jtoNaWeOComsbXAGG3TP02mQ1tM+EFZX4BpvMD
 QdKx4KYow10bHqdtfTn0ZZ4s68CSi6iL0hGvzG0i/gUiCYsBdvpJ7M9XgqrZMRbTmwpbMZV/WPS
 WAGF1D13GMMLmNEOX934DBmZWxl/95erkMsL5TxZnPWfKhMkDdxj1fC8WcdKFucsy1t8fnl4WPQ
 KiKvSONIvWAWiztY7771o9euaJ8LxrInMSqyzG/080wa+o7jqMI6kpeleCDhqTnZDpcaHeSuEms
 Dgi2LjtfY0ngbE6raXKn8GTHa1m6Ah4FKbNvgoeyA=
X-Received: by 2002:a05:693c:6286:b0:2be:b2cf:cd34 with SMTP id
 5a478bee46e88-2beb2cfda25mr2238322eec.18.1773546090983; 
 Sat, 14 Mar 2026 20:41:30 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3eec8fsm8886424eec.13.2026.03.14.20.41.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 14 Mar 2026 20:41:30 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v3 1/6] target/arm/emulate: add ISV=0 emulation library with
 load/store immediate
Date: Sun, 15 Mar 2026 00:41:18 -0300
Message-ID: <20260315034123.41921-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260315034123.41921-1-lucaaamaral@gmail.com>
References: <20260313021850.42379-1-lucaaamaral@gmail.com>
 <20260315034123.41921-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a shared emulation library for AArch64 load/store instructions that
cause ISV=0 data aborts under hardware virtualization (HVF, WHPX).

When the Instruction Syndrome Valid bit is clear, the hypervisor cannot
determine the faulting instruction's target register or access size from
the syndrome alone.  This library fetches and decodes the instruction
using a decodetree-generated decoder, then emulates it by accessing the
vCPU's register file (CPUARMState) and memory (cpu_memory_rw_debug)
directly.

This patch establishes the framework and adds load/store single with
immediate addressing — the most common ISV=0 trigger.  Subsequent
patches add register-offset, pair, exclusive, and atomic instructions.

Instruction coverage:
  - STR/LDR (GPR): unscaled, post-indexed, unprivileged, pre-indexed,
    unsigned offset — all sizes (8/16/32/64-bit), sign/zero extension
  - STR/LDR (SIMD/FP): same addressing modes, 8-128 bit elements
  - PRFM: prefetch treated as NOP
  - DC cache maintenance (SYS CRn=C7): NOP on MMIO

This library uses its own a64-ldst.decode rather than sharing
target/arm/tcg/a64.decode.  TCG's trans_* functions are a compiler:
they emit IR ops into a translation block for later execution.  This
library's trans_* functions are an interpreter: they execute directly
against the vCPU register file and memory.  The decodetree-generated
dispatcher calls trans_* by name, so both cannot coexist in the same
translation unit.  Decode patterns are kept consistent with TCG's
where possible.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode | 129 ++++++++++++++++
 target/arm/emulate/arm_emulate.c   | 226 +++++++++++++++++++++++++++++
 target/arm/emulate/arm_emulate.h   |  30 ++++
 target/arm/emulate/meson.build     |   6 +
 target/arm/meson.build             |   1 +
 5 files changed, 392 insertions(+)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
new file mode 100644
index 00000000..c887dcba
--- /dev/null
+++ b/target/arm/emulate/a64-ldst.decode
@@ -0,0 +1,129 @@
+# AArch64 load/store instruction patterns for ISV=0 emulation
+#
+# Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+### Argument sets
+
+# Load/store immediate (unscaled, pre/post-index, unprivileged, unsigned offset)
+# 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
+&ldst_imm       rt rn imm sz sign w p unpriv ext u
+
+### Format templates
+
+# Load/store immediate (9-bit signed)
+@ldst_imm       .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=0 w=0
+@ldst_imm_pre   .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=0 w=1
+@ldst_imm_post  .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=1 w=1
+@ldst_imm_user  .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=1 p=0 w=0
+
+# Load/store unsigned offset (12-bit, handler scales by << sz)
+@ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=1 unpriv=0 p=0 w=0
+
+### Load/store register — unscaled immediate (LDUR/STUR)
+
+# GPR
+STR_i           sz:2 111 0 00 00 0 ......... 00 ..... .....    @ldst_imm sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=1 sz=1
+
+# SIMD/FP
+STR_v_i         sz:2 111 1 00 00 0 ......... 00 ..... .....    @ldst_imm sign=0 ext=0
+STR_v_i         00 111 1 00 10 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 00 01 0 ......... 00 ..... .....    @ldst_imm sign=0 ext=0
+LDR_v_i         00 111 1 00 11 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=0 sz=4
+
+### Load/store register — post-indexed
+
+# GPR
+STR_i           sz:2 111 0 00 00 0 ......... 01 ..... .....    @ldst_imm_post sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=1 sz=1
+
+# SIMD/FP
+STR_v_i         sz:2 111 1 00 00 0 ......... 01 ..... .....    @ldst_imm_post sign=0 ext=0
+STR_v_i         00 111 1 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 00 01 0 ......... 01 ..... .....    @ldst_imm_post sign=0 ext=0
+LDR_v_i         00 111 1 00 11 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=0 sz=4
+
+### Load/store register — unprivileged
+
+# GPR only (no SIMD/FP unprivileged forms)
+STR_i           sz:2 111 0 00 00 0 ......... 10 ..... .....    @ldst_imm_user sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=1 sz=1
+
+### Load/store register — pre-indexed
+
+# GPR
+STR_i           sz:2 111 0 00 00 0 ......... 11 ..... .....    @ldst_imm_pre sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=1 sz=1
+
+# SIMD/FP
+STR_v_i         sz:2 111 1 00 00 0 ......... 11 ..... .....    @ldst_imm_pre sign=0 ext=0
+STR_v_i         00 111 1 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 00 01 0 ......... 11 ..... .....    @ldst_imm_pre sign=0 ext=0
+LDR_v_i         00 111 1 00 11 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=0 sz=4
+
+### PRFM — unscaled immediate: prefetch is a NOP
+
+NOP             11 111 0 00 10 0 --------- 00 ----- -----
+
+### Load/store register — unsigned offset
+
+# GPR
+STR_i           sz:2 111 0 01 00 ............ ..... .....       @ldst_uimm sign=0 ext=0
+LDR_i           00 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=1 sz=0
+LDR_i           01 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=1 sz=1
+LDR_i           10 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=1 sz=2
+LDR_i           11 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=3
+LDR_i           00 111 0 01 10 ............ ..... .....         @ldst_uimm sign=1 ext=0 sz=0
+LDR_i           01 111 0 01 10 ............ ..... .....         @ldst_uimm sign=1 ext=0 sz=1
+LDR_i           10 111 0 01 10 ............ ..... .....         @ldst_uimm sign=1 ext=0 sz=2
+LDR_i           00 111 0 01 11 ............ ..... .....         @ldst_uimm sign=1 ext=1 sz=0
+LDR_i           01 111 0 01 11 ............ ..... .....         @ldst_uimm sign=1 ext=1 sz=1
+
+# PRFM — unsigned offset
+NOP             11 111 0 01 10 ------------ ----- -----
+
+# SIMD/FP
+STR_v_i         sz:2 111 1 01 00 ............ ..... .....       @ldst_uimm sign=0 ext=0
+STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
+LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
+
+### System instructions — DC cache maintenance
+
+# SYS with CRn=C7 covers all data cache operations (DC CIVAC, CVAC, etc.).
+# On MMIO regions, cache maintenance is a harmless no-op.
+NOP             1101 0101 0000 1 --- 0111 ---- --- -----
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
new file mode 100644
index 00000000..2b4e2a9e
--- /dev/null
+++ b/target/arm/emulate/arm_emulate.c
@@ -0,0 +1,226 @@
+/*
+ * AArch64 instruction emulation for ISV=0 data aborts
+ *
+ * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "arm_emulate.h"
+#include "target/arm/cpu.h"
+#include "exec/cpu-common.h"
+
+/* Named "DisasContext" as required by the decodetree code generator */
+typedef struct {
+    CPUState *cpu;
+    CPUARMState *env;
+    ArmEmulResult result;
+} DisasContext;
+
+#include "decode-a64-ldst.c.inc"
+
+/* GPR data access (Rt, Rs, Rt2) -- register 31 = XZR */
+
+static uint64_t gpr_read(DisasContext *ctx, int reg)
+{
+    if (reg == 31) {
+        return 0;  /* XZR */
+    }
+    return ctx->env->xregs[reg];
+}
+
+static void gpr_write(DisasContext *ctx, int reg, uint64_t val)
+{
+    if (reg == 31) {
+        return;  /* XZR -- discard */
+    }
+    ctx->env->xregs[reg] = val;
+    ctx->cpu->vcpu_dirty = true;
+}
+
+/* Base register access (Rn) -- register 31 = SP */
+
+static uint64_t base_read(DisasContext *ctx, int rn)
+{
+    return ctx->env->xregs[rn];
+}
+
+static void base_write(DisasContext *ctx, int rn, uint64_t val)
+{
+    ctx->env->xregs[rn] = val;
+    ctx->cpu->vcpu_dirty = true;
+}
+
+/* SIMD/FP register access */
+
+static void fpreg_read(DisasContext *ctx, int reg, void *buf, int size)
+{
+    memcpy(buf, &ctx->env->vfp.zregs[reg], size);
+}
+
+static void fpreg_write(DisasContext *ctx, int reg, const void *buf, int size)
+{
+    memset(&ctx->env->vfp.zregs[reg], 0, sizeof(ctx->env->vfp.zregs[reg]));
+    memcpy(&ctx->env->vfp.zregs[reg], buf, size);
+    ctx->cpu->vcpu_dirty = true;
+}
+
+/* Memory access wrappers */
+
+static int mem_read(DisasContext *ctx, uint64_t va, void *buf, int size)
+{
+    int ret = cpu_memory_rw_debug(ctx->cpu, va, buf, size, false);
+    if (ret != 0) {
+        ctx->result = ARM_EMUL_ERR_MEM;
+    }
+    return ret;
+}
+
+static int mem_write(DisasContext *ctx, uint64_t va, const void *buf, int size)
+{
+    int ret = cpu_memory_rw_debug(ctx->cpu, va, (void *)buf, size, true);
+    if (ret != 0) {
+        ctx->result = ARM_EMUL_ERR_MEM;
+    }
+    return ret;
+}
+
+/* Sign/zero extension helpers */
+
+static uint64_t sign_extend(uint64_t val, int from_bits)
+{
+    int shift = 64 - from_bits;
+    return (int64_t)(val << shift) >> shift;
+}
+
+/* Apply sign/zero extension */
+static uint64_t load_extend(uint64_t val, int sz, int sign, int ext)
+{
+    int data_bits = 8 << sz;
+
+    if (sign) {
+        val = sign_extend(val, data_bits);
+        if (ext) {
+            /* Sign-extend to 32 bits (W register) */
+            val &= 0xFFFFFFFF;
+        }
+    } else if (ext) {
+        /* Zero-extend to 32 bits (W register) */
+        val &= 0xFFFFFFFF;
+    }
+    return val;
+}
+
+/* Load/store single -- immediate (GPR) (DDI 0487 C3.3.8 -- C3.3.13) */
+
+static bool trans_STR_i(DisasContext *ctx, arg_ldst_imm *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
+                          : (int64_t)a->imm;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+
+    uint64_t val = gpr_read(ctx, a->rt);
+    if (mem_write(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+static bool trans_LDR_i(DisasContext *ctx, arg_ldst_imm *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
+                          : (int64_t)a->imm;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    val = load_extend(val, a->sz, a->sign, a->ext);
+    gpr_write(ctx, a->rt, val);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+/*
+ * Load/store single -- immediate (SIMD/FP)
+ * STR_v_i / LDR_v_i (DDI 0487 C3.3.10)
+ */
+
+static bool trans_STR_v_i(DisasContext *ctx, arg_ldst_imm *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
+                          : (int64_t)a->imm;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[16];
+
+    fpreg_read(ctx, a->rt, buf, esize);
+    if (mem_write(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+static bool trans_LDR_v_i(DisasContext *ctx, arg_ldst_imm *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
+                          : (int64_t)a->imm;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[16];
+
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    fpreg_write(ctx, a->rt, buf, esize);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+/* PRFM, DC cache maintenance -- treated as NOP */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+    (void)ctx;
+    (void)a;
+    return true;
+}
+
+/* Entry point */
+
+ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn)
+{
+    DisasContext ctx = {
+        .cpu = env_cpu(env),
+        .env = env,
+        .result = ARM_EMUL_OK,
+    };
+
+    if (!decode_a64_ldst(&ctx, insn)) {
+        return ARM_EMUL_UNHANDLED;
+    }
+
+    return ctx.result;
+}
diff --git a/target/arm/emulate/arm_emulate.h b/target/arm/emulate/arm_emulate.h
new file mode 100644
index 00000000..7fe29839
--- /dev/null
+++ b/target/arm/emulate/arm_emulate.h
@@ -0,0 +1,30 @@
+/*
+ * AArch64 instruction emulation library
+ *
+ * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ARM_EMULATE_H
+#define ARM_EMULATE_H
+
+#include "qemu/osdep.h"
+
+/**
+ * ArmEmulResult - return status from arm_emul_insn()
+ */
+typedef enum {
+    ARM_EMUL_OK,         /* Instruction emulated successfully */
+    ARM_EMUL_UNHANDLED,  /* Instruction not recognized by decoder */
+    ARM_EMUL_ERR_MEM,    /* Memory access failed */
+} ArmEmulResult;
+
+/**
+ * arm_emul_insn - decode and emulate one AArch64 instruction
+ *
+ * Caller must synchronize CPU state and fetch @insn before calling.
+ */
+ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn);
+
+#endif /* ARM_EMULATE_H */
diff --git a/target/arm/emulate/meson.build b/target/arm/emulate/meson.build
new file mode 100644
index 00000000..c0b38dd1
--- /dev/null
+++ b/target/arm/emulate/meson.build
@@ -0,0 +1,6 @@
+gen_a64_ldst = decodetree.process('a64-ldst.decode',
+    extra_args: ['--static-decode=decode_a64_ldst'])
+
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_true: [
+    gen_a64_ldst, files('arm_emulate.c')
+])
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0e504a..a4b2291b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -57,6 +57,7 @@ arm_common_system_ss.add(files(
   'vfp_fpscr.c',
 ))
 
+subdir('emulate')
 subdir('hvf')
 subdir('whpx')
 
-- 
2.52.0


