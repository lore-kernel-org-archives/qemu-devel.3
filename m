Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6A6F364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxWB-00087V-LC; Thu, 09 Apr 2026 18:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxW9-00086v-SZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:29 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxW7-0000aX-3h
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:29 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso2080802eec.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775772385; x=1776377185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzcLg/55mgZkhCbHFQ8GjJiM5YvvJzpxOoFNIcHsiRY=;
 b=GGMXY4xg90+6znECYeIkRiRlj1snzNmG3RZE6dDLpUZ+W7uoZEkU9/mdTek/wXUFp+
 u1Vgew82ACnfuiCVoWRPBtLR7ngjDFaTtwrk9jOC7R+QOI8Hr4xTFIivx4V/22BjFtL5
 zk5jtsgl4Sw2gEHtRRViD+20nHmBTds/UDJOJiSIbeIv/QJ07dLlhaD9GxLKnZCfwn1k
 y6yh6i25r4X5ppjIUaNnRqFgrhlq41LqjtqPOhHLYLS2LwPS3RU7tXaerg7puZWTb0wG
 b9xKU0FytP3wFrONT2GiKr35KkfF1FEW408wGf1OrhbGHih/60yv2p+BISOaisDfWJmX
 5Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772385; x=1776377185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HzcLg/55mgZkhCbHFQ8GjJiM5YvvJzpxOoFNIcHsiRY=;
 b=Dy8BcOFP3DcgqmLhqmEzv/OWaOEJDDFpoqlth9r6eB6kbtlG4DPCnTjaYnWBbfqJrl
 PJnR6wOFR9w6VS3jFqb3l3/PTulSwaVJCVPFBA18vk4Wry1RrbjlczY53+kU5+fOShTw
 iLwfRpjfjhz3dbMY+gBOpzF2S49W1nVv5wV0ZBl4PUccb5ZzEzRJZoYNXKyOWVy+Y4eb
 vSQ3xnNF12SdF3WFAZy/N4HbndSpVIfUcU6mCCqi4ZhAgHdMzFN4ODVnvNX3zY1Fn8P0
 zF+xC3aTzXhZ1AWcUuTVxpsdzaspGpJvWgnGFAUyQGhPfEjPAko55GSptND99q4tNNto
 q0mg==
X-Gm-Message-State: AOJu0Ywul+RjP9IUSFFqiWSjVSCs6HV0ixy923O/WvHX3evHY1r0k2El
 9VBb3U8uLDYuqDepvGqLDXnun9ohRr/2D/2fm55DcE+Pkjz6mb1aFTC8n3UKiC89
X-Gm-Gg: AeBDiesEngnATeWppreGq2dh7E5FpToLUAn9bI2kqohFfLyKQ5cvhhA8rQ/+2Zdx5A2
 PGN4BwHO7o5lhOJYglcsYpx+aGxhu3VgemiAmP2TX9yRtsZHylv3x+MCnFsYkmngVuk22FWw4NV
 kIRSgO8ODZzY6cwfplUBDsxeSDSF2YbL4OK62ept5i/ZyoWyGE8UoAxmwXxXq/GfZ7WaDf5lxkY
 JH14IePoLkgoonBEue8P2v/RDr/kKU3mlbG9BWMHNvMZ2wYAO0M2ELOWbvdQ1bhArQb+RTrI5Pr
 BvB5/4MYU2Ku3RN6CZCNGg/+pYj9eBEKtm1a6BGDOu8xNFhJ2bKBU/5hTigVOZm31H0WmtcbDU5
 KKgboR88DGqCEqS6pX30zvB+f7fXSNnyVCYpGHH6IfQs5wyHbAdd0nCbrsZxGOMy5DoluXA62MJ
 x0MUxg/BMuUVrFuD/H5fgsNSGLYkIR0ruJfWdsJxOSQD2VPBuuS/Wwe36G0FIR5A==
X-Received: by 2002:a05:693c:310a:b0:2ca:2f21:64da with SMTP id
 5a478bee46e88-2d5841c5483mr537755eec.0.1775772385302; 
 Thu, 09 Apr 2026 15:06:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:bb40:195d:78fd:ecba:d45])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde68bsm1534567eec.17.2026.04.09.15.06.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 15:06:24 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v6 1/6] target/arm/emulate: add ISV=0 emulation library with
 load/store immediate
Date: Thu,  9 Apr 2026 19:06:09 -0300
Message-ID: <20260409220614.65558-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
vCPU's register file (CPUARMState) and guest memory via get_phys_addr()
for MMU translation and address_space_read/write() for physical access.

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

Decodetree differences from TCG:
  - &ldst_imm adds a 'u' flag to distinguish 9-bit signed vs 12-bit
    unsigned immediate forms.  TCG uses %uimm_scaled to pre-scale
    the unsigned immediate at decode time; here imm:12 is extracted
    raw and the handler scales it.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode | 129 +++++++++++++
 target/arm/emulate/arm_emulate.c   | 288 +++++++++++++++++++++++++++++
 target/arm/emulate/arm_emulate.h   |  30 +++
 target/arm/emulate/meson.build     |   8 +
 target/arm/meson.build             |   1 +
 5 files changed, 456 insertions(+)
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
index 00000000..bedbdb3e
--- /dev/null
+++ b/target/arm/emulate/arm_emulate.c
@@ -0,0 +1,288 @@
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
+#include "target/arm/internals.h"
+#include "exec/cpu-common.h"
+#include "system/memory.h"
+#include "exec/target_page.h"
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+
+/* Named "DisasContext" as required by the decodetree code generator */
+typedef struct {
+    CPUState *cpu;
+    CPUARMState *env;
+    ArmEmulResult result;
+    bool be_data;
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
+/*
+ * Memory access via guest MMU translation.
+ *
+ * Translates the virtual address through the guest page tables using
+ * get_phys_addr(), then performs the access on the resulting physical
+ * address via address_space_read/write().  Each page-sized chunk is
+ * translated independently, so accesses that span a page boundary
+ * are handled correctly even when the pages map to different physical
+ * addresses.
+ */
+
+static int mem_access(DisasContext *ctx, uint64_t va, void *buf, int size,
+                      MMUAccessType access_type)
+{
+    ARMMMUIdx mmu_idx = arm_mmu_idx(ctx->env);
+
+    while (size > 0) {
+        int chunk = MIN(size, TARGET_PAGE_SIZE - (va & ~TARGET_PAGE_MASK));
+        GetPhysAddrResult res = {};
+        ARMMMUFaultInfo fi = {};
+
+        if (get_phys_addr(ctx->env, va, access_type, 0, mmu_idx,
+                          &res, &fi)) {
+            ctx->result = ARM_EMUL_ERR_MEM;
+            return -1;
+        }
+
+        AddressSpace *as = arm_addressspace(ctx->cpu, res.f.attrs);
+        MemTxResult txr;
+
+        if (access_type == MMU_DATA_STORE) {
+            txr = address_space_write(as, res.f.phys_addr, res.f.attrs,
+                                      buf, chunk);
+        } else {
+            txr = address_space_read(as, res.f.phys_addr, res.f.attrs,
+                                     buf, chunk);
+        }
+
+        if (txr != MEMTX_OK) {
+            ctx->result = ARM_EMUL_ERR_MEM;
+            return -1;
+        }
+
+        va += chunk;
+        buf += chunk;
+        size -= chunk;
+    }
+    return 0;
+}
+
+static int mem_read(DisasContext *ctx, uint64_t va, void *buf, int size)
+{
+    return mem_access(ctx, va, buf, size, MMU_DATA_LOAD);
+}
+
+static int mem_write(DisasContext *ctx, uint64_t va, const void *buf, int size)
+{
+    return mem_access(ctx, va, (void *)buf, size, MMU_DATA_STORE);
+}
+
+/*
+ * Endian-aware GPR <-> memory buffer helpers.
+ *
+ * mem_read/mem_write transfer raw bytes between guest VA and a host buffer.
+ * mem_ld/mem_st convert between a uint64_t register value and the guest
+ * byte order in a memory buffer.
+ */
+
+static uint64_t mem_ld(DisasContext *ctx, const void *buf, int size)
+{
+    return ctx->be_data ? ldn_be_p(buf, size) : ldn_le_p(buf, size);
+}
+
+static void mem_st(DisasContext *ctx, void *buf, int size, uint64_t val)
+{
+    if (ctx->be_data) {
+        stn_be_p(buf, size, val);
+    } else {
+        stn_le_p(buf, size, val);
+    }
+}
+
+/* Apply sign/zero extension */
+static uint64_t load_extend(uint64_t val, int sz, int sign, int ext)
+{
+    int data_bits = 8 << sz;
+
+    if (sign) {
+        val = sextract64(val, 0, data_bits);
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
+    uint8_t buf[16];
+    uint64_t val = gpr_read(ctx, a->rt);
+    mem_st(ctx, buf, esize, val);
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
+static bool trans_LDR_i(DisasContext *ctx, arg_ldst_imm *a)
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
+    uint64_t val = mem_ld(ctx, buf, esize);
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
+        .be_data = arm_cpu_data_is_big_endian(env),
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
index 00000000..e5455bd2
--- /dev/null
+++ b/target/arm/emulate/meson.build
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
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


