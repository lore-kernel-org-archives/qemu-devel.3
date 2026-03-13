Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9287C106FD69
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 02:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0s7G-0000R6-34; Thu, 12 Mar 2026 22:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0s7E-0000QE-Be
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 22:19:04 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0s7A-00080F-HT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 22:19:04 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2bea8a1c040so280514eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773368339; x=1773973139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKe+6BgKY+nLiLRqjwf5WJqTdYg9unFiTr26RFa2JMs=;
 b=RYCWBh1qFPrG+VKM6+dJAzCg8NZnVrr5pejRoSdyd3aqjXVgyCDZzz4501sMxSoNUs
 L3TCAV2B4MS+oL42bNKAw/2fhQ2mMnGdqued5V9SX26EcmndAUXACVhzWR3LkgGUGBSW
 POLQ3da22QWIqnb3wu7BSsSNeBOC1WMIvQHVurhlJ8/8eRZhU0EjF7w8wBUSRxWCuFCu
 Nv1oKBKuauJCwFmmOa/JVD+imZ5soQLDr3piLDtEdm2AV3+SF6QU5muiCsEyWv/7R5L8
 7ANIDHln/bdGj0XTvCO4BvaueCRv24lwuduVDNk+YPH8w4og5zuY7smr3YrlnsNh6LYO
 wPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773368339; x=1773973139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EKe+6BgKY+nLiLRqjwf5WJqTdYg9unFiTr26RFa2JMs=;
 b=MoJT8RT+WQnfhAnumWBLNQndU9Sl7Y/l+g9H0RXjJKX/VCpSYsmBZkBS3Z78e8gcyP
 A8UMzmY2pcFlslHF211kWzVW4Ldog2SZab8yFhhpyIZ7YU4D2OpcsjXaxNvnwrrOZHgk
 CO2pEby8gv6z/bDTgIP6/MR7xaXvMnrT8SC8eavSkyGG1GaOQoUD6Wm5M5v77w3gCzaZ
 ZLxw06Ux/swSjhXdU6RxvV59TFvIZtcNEd437b6eQzyYXT5Po4+/lC1j8BuYkOZfSnPA
 nHmnLmpN9VdX+OjxXnlIFnyr4/MZj8YMOXWNDlCkHHGE5qMVxAICp67eA+oSlVo6rnut
 vqrw==
X-Gm-Message-State: AOJu0YzXCrznfkNK9woY/1CwlcFQ56DIk10PllulyqvIBsrddjit3i2Q
 vK3yIJrlYFqO79lfIYw+RHWBLcUw3tiXFzhgh3hRCjcBmEPPKdgQI9WTQI0PaLfJ
X-Gm-Gg: ATEYQzzRlDYVUrDYxoS6pcSpaGUOmBHMAMZAZx9Xu+wVT0/E1sEXVoY7GvbsllePAlT
 uRsb7O3dSjOigZuEhhXChOlxsBWyKJm8qS2zZkwBBUBlKOXgNQIklxfSe0ZmW0amqzuLMy4mdf/
 fmSikQN6Y7NI4gWuv9eUTSvOrUxPS5eccRGYgZs168Olrpm5NLuLFfBczldR+B58f4N1YpHoPYO
 XPPKC8+O5Mxbivq9z8Wp792vmnNLSgnpAJ2zveZ/3ILKUBi9FnM0mL3nq9Algro5PU9tvsc/lJq
 piDksHIRxdZiIe8b0bvedMhqbzv6nRmuro6w9tbYhjX845Z0J1/3iLlIMLoY8lmWHytNo3qW8mS
 E4FL+y7j1sYw8zACNbsFJehMfE3+BCleYq+60C/HqMYgFsjOftkM1YGjeIG0y1q07p0n+g1UrsM
 Kzd3ECclljRjx7PEx/S43uykCgNVaQDxV+dp6CNsr/EhnR2cVhYl0=
X-Received: by 2002:a05:7300:8608:b0:2b7:2664:ae9f with SMTP id
 5a478bee46e88-2bea53915d5mr806553eec.1.1773368338140; 
 Thu, 12 Mar 2026 19:18:58 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:588a:39d7:d008:37c2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3eec52sm796218eec.14.2026.03.12.19.18.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 19:18:57 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 1/3] target/arm: add AArch64 ISV=0 instruction emulation
 library
Date: Thu, 12 Mar 2026 23:18:48 -0300
Message-ID: <20260313021850.42379-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313021850.42379-1-lucaaamaral@gmail.com>
References: <20260309214852.92545-1-lucaaamaral@gmail.com>
 <20260313021850.42379-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a shared emulation library in target/arm/emulate/ using a
decodetree decoder (a64-ldst.decode) and a callback-based interface
(struct arm_emul_ops) that any hypervisor backend can implement.

The hypervisor cannot emulate ISV=0 data aborts without decoding the
faulting instruction, since the ESR syndrome does not carry the access
size or target register.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode | 293 ++++++++++++
 target/arm/emulate/arm_emulate.c   | 738 +++++++++++++++++++++++++++++
 target/arm/emulate/arm_emulate.h   |  55 +++
 target/arm/emulate/meson.build     |  16 +
 target/arm/meson.build             |   1 +
 5 files changed, 1103 insertions(+)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
new file mode 100644
index 0000000..9a7b697
--- /dev/null
+++ b/target/arm/emulate/a64-ldst.decode
@@ -0,0 +1,293 @@
+# AArch64 load/store instruction patterns for ISV=0 emulation
+#
+# Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+### Argument sets
+
+# Load/store exclusive
+&stxr           rn rt rt2 rs sz lasr
+
+# Load/store pair (GPR and SIMD/FP)
+&ldstpair       rt2 rt rn imm sz sign w p
+
+# Load/store immediate (unscaled, pre/post-index, unprivileged, unsigned offset)
+# 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
+&ldst_imm       rt rn imm sz sign w p unpriv ext u
+
+# Load/store register offset
+&ldst           rm rn rt sign ext sz opt s
+
+# Atomic memory operations
+&atomic         rs rn rt a r sz
+
+# Compare-and-swap
+&cas            rs rn rt sz a r
+
+# Load with PAC (LDRAA/LDRAB, FEAT_PAuth)
+%ldra_imm       22:s1 12:9
+&ldra           rt rn imm m w
+
+### Format templates
+
+# Exclusives
+@stxr           sz:2 ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5   &stxr
+
+# Load/store pair: imm7 is signed, scaled by element size in handler
+@ldstpair       .. ... . ... . imm:s7 rt2:5 rn:5 rt:5          &ldstpair
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
+# Load/store register offset
+@ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
+
+# Atomics
+@atomic         sz:2 ... . .. a:1 r:1 . rs:5 . ... .. rn:5 rt:5   &atomic
+
+# Compare-and-swap: sz extracted by pattern (CAS) or set constant (CASP)
+@cas            .. ...... . a:1 . rs:5 r:1 ..... rn:5 rt:5        &cas
+
+# Load with PAC
+@ldra           .. ... . .. m:1 . . ......... w:1 . rn:5 rt:5     &ldra imm=%ldra_imm
+
+### Load/store exclusive
+
+# STXR / STLXR  (sz encodes 8/16/32/64-bit)
+STXR            .. 001000 000 ..... . ..... ..... .....         @stxr
+
+# LDXR / LDAXR
+LDXR            .. 001000 010 ..... . ..... ..... .....         @stxr
+
+# STXP / STLXP  (bit[31]=1, bit[30]=sf → sz=2 for 32-bit, sz=3 for 64-bit)
+STXP            10 001000 001 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=2
+STXP            11 001000 001 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=3
+
+# LDXP / LDAXP
+LDXP            10 001000 011 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=2
+LDXP            11 001000 011 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=3
+
+### Compare-and-swap
+
+# CAS / CASA / CASAL / CASL
+CAS             sz:2 001000 1 . 1 ..... . 11111 ..... .....     @cas
+
+# CASP / CASPA / CASPAL / CASPL (pair: Rt,Rt+1 and Rs,Rs+1)
+CASP            00 001000 0 . 1 ..... . 11111 ..... .....       @cas sz=2
+CASP            01 001000 0 . 1 ..... . 11111 ..... .....       @cas sz=3
+
+### Load/store pair — non-temporal (STNP/LDNP)
+
+# STNP/LDNP: offset only, no writeback.  Non-temporal hint ignored.
+STP             00 101 0 000 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP             00 101 0 000 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+STP             10 101 0 000 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP             10 101 0 000 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           00 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP_v           00 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+STP_v           01 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP_v           01 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           10 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+LDP_v           10 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+
+### Load/store pair — post-indexed
+
+STP             00 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+LDP             00 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+LDP             01 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=1 w=1
+STP             10 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+LDP             10 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+STP_v           00 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+LDP_v           00 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+STP_v           01 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+LDP_v           01 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+STP_v           10 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=1 w=1
+LDP_v           10 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=1 w=1
+
+### Load/store pair — signed offset
+
+STP             00 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP             00 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP             01 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=0 w=0
+STP             10 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP             10 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           00 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP_v           00 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+STP_v           01 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP_v           01 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           10 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+LDP_v           10 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+
+### Load/store pair — pre-indexed
+
+STP             00 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+LDP             00 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+LDP             01 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=0 w=1
+STP             10 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+LDP             10 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+STP_v           00 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+LDP_v           00 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+STP_v           01 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+LDP_v           01 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+STP_v           10 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=1
+LDP_v           10 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=1
+
+### Load/store pair — STGP (store allocation tag + pair)
+
+STGP            01 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+STGP            01 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STGP            01 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
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
+### Load/store register — register offset
+
+# GPR
+STR             sz:2 111 0 00 00 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+LDR             00 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=0
+LDR             01 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=1
+LDR             10 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=2
+LDR             11 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=3
+LDR             00 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=0
+LDR             01 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=1
+LDR             10 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=2
+LDR             00 111 0 00 11 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=1 sz=0
+LDR             01 111 0 00 11 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=1 sz=1
+
+# PRFM — register offset
+NOP             11 111 0 00 10 1 ----- -1- - 10 ----- -----
+
+# SIMD/FP
+STR_v           sz:2 111 1 00 00 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+STR_v           00 111 1 00 10 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
+LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
+
+### Atomic memory operations
+
+LDADD           .. 111 0 00 . . 1 ..... 0000 00 ..... .....    @atomic
+LDCLR           .. 111 0 00 . . 1 ..... 0001 00 ..... .....    @atomic
+LDEOR           .. 111 0 00 . . 1 ..... 0010 00 ..... .....    @atomic
+LDSET           .. 111 0 00 . . 1 ..... 0011 00 ..... .....    @atomic
+LDSMAX          .. 111 0 00 . . 1 ..... 0100 00 ..... .....    @atomic
+LDSMIN          .. 111 0 00 . . 1 ..... 0101 00 ..... .....    @atomic
+LDUMAX          .. 111 0 00 . . 1 ..... 0110 00 ..... .....    @atomic
+LDUMIN          .. 111 0 00 . . 1 ..... 0111 00 ..... .....    @atomic
+SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... .....    @atomic
+
+### Load with PAC (FEAT_PAuth)
+
+# LDRAA (M=0) / LDRAB (M=1), offset (W=0) / pre-indexed (W=1)
+LDRA            11 111 0 00 . . 1 ......... . 1 ..... .....  @ldra
+
+### System instructions — DC cache maintenance
+
+# SYS with CRn=C7 covers all data cache operations (DC CIVAC, CVAC, etc.).
+# On MMIO regions, cache maintenance is a harmless no-op.
+NOP             1101 0101 0000 1 --- 0111 ---- --- -----
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
new file mode 100644
index 0000000..cd8f44d
--- /dev/null
+++ b/target/arm/emulate/arm_emulate.c
@@ -0,0 +1,738 @@
+/*
+ * AArch64 instruction emulation for ISV=0 data aborts
+ *
+ * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "arm_emulate.h"
+#include "qemu/bitops.h"
+#include "qemu/error-report.h"
+
+/* Named "DisasContext" as required by the decodetree code generator */
+typedef struct {
+    CPUState *cpu;
+    const struct arm_emul_ops *ops;
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
+    return ctx->ops->read_gpr(ctx->cpu, reg);
+}
+
+static void gpr_write(DisasContext *ctx, int reg, uint64_t val)
+{
+    if (reg == 31) {
+        return;  /* XZR -- discard */
+    }
+    ctx->ops->write_gpr(ctx->cpu, reg, val);
+}
+
+/* Base register access (Rn) -- register 31 = SP */
+
+static uint64_t base_read(DisasContext *ctx, int rn)
+{
+    return ctx->ops->read_gpr(ctx->cpu, rn);
+}
+
+static void base_write(DisasContext *ctx, int rn, uint64_t val)
+{
+    ctx->ops->write_gpr(ctx->cpu, rn, val);
+}
+
+/* Memory access wrappers */
+
+static int mem_read(DisasContext *ctx, uint64_t va, void *buf, int size)
+{
+    int ret = ctx->ops->read_mem(ctx->cpu, va, buf, size);
+    if (ret != 0) {
+        ctx->result = ARM_EMUL_ERR_MEM;
+    }
+    return ret;
+}
+
+static int mem_write(DisasContext *ctx, uint64_t va, const void *buf, int size)
+{
+    int ret = ctx->ops->write_mem(ctx->cpu, va, buf, size);
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
+/* Register offset extension (DDI 0487 C6.2.131) */
+
+static uint64_t extend_reg(uint64_t val, int option, int shift)
+{
+    switch (option) {
+    case 0: /* UXTB */
+        val = (uint8_t)val;
+        break;
+    case 1: /* UXTH */
+        val = (uint16_t)val;
+        break;
+    case 2: /* UXTW */
+        val = (uint32_t)val;
+        break;
+    case 3: /* UXTX / LSL */
+        break;
+    case 4: /* SXTB */
+        val = (int64_t)(int8_t)val;
+        break;
+    case 5: /* SXTH */
+        val = (int64_t)(int16_t)val;
+        break;
+    case 6: /* SXTW */
+        val = (int64_t)(int32_t)val;
+        break;
+    case 7: /* SXTX */
+        break;
+    }
+    return val << shift;
+}
+
+/*
+ * Load/store pair: STP, LDP, STNP, LDNP, STGP, LDPSW
+ * (DDI 0487 C3.3.14 -- C3.3.16)
+ */
+
+static bool trans_STP(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;                   /* 4 or 8 bytes */
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset; /* post-index: unmodified base */
+    uint8_t buf[16];                           /* max 2 x 8 bytes */
+
+    uint64_t v1 = gpr_read(ctx, a->rt);
+    uint64_t v2 = gpr_read(ctx, a->rt2);
+    memcpy(buf, &v1, esize);
+    memcpy(buf + esize, &v2, esize);
+
+    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+static bool trans_LDP(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[16];
+    uint64_t v1 = 0, v2 = 0;
+
+    memset(buf, 0, sizeof(buf));
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+    memcpy(&v1, buf, esize);
+    memcpy(&v2, buf + esize, esize);
+
+    /* LDPSW: sign-extend 32-bit values to 64-bit (sign=1, sz=2) */
+    if (a->sign) {
+        v1 = sign_extend(v1, 8 * esize);
+        v2 = sign_extend(v2, 8 * esize);
+    }
+
+    gpr_write(ctx, a->rt, v1);
+    gpr_write(ctx, a->rt2, v2);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+/* STGP: tag operation is a NOP for emulation; data stored via STP */
+static bool trans_STGP(DisasContext *ctx, arg_ldstpair *a)
+{
+    return trans_STP(ctx, a);
+}
+
+/*
+ * SIMD/FP load/store pair: STP_v, LDP_v
+ * (DDI 0487 C3.3.14 -- C3.3.16)
+ */
+
+static bool trans_STP_v(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;                   /* 4, 8, or 16 bytes */
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[32];                           /* max 2 x 16 bytes */
+
+    ctx->ops->read_fpreg(ctx->cpu, a->rt, buf, esize);
+    ctx->ops->read_fpreg(ctx->cpu, a->rt2, buf + esize, esize);
+
+    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+static bool trans_LDP_v(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[32];
+
+    memset(buf, 0, sizeof(buf));
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    ctx->ops->write_fpreg(ctx->cpu, a->rt, buf, esize);
+    ctx->ops->write_fpreg(ctx->cpu, a->rt2, buf + esize, esize);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
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
+    ctx->ops->read_fpreg(ctx->cpu, a->rt, buf, esize);
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
+    memset(buf, 0, sizeof(buf));
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    ctx->ops->write_fpreg(ctx->cpu, a->rt, buf, esize);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+/*
+ * Load/store single -- register offset (GPR)
+ * STR / LDR (DDI 0487 C3.3.9)
+ */
+
+static bool trans_STR(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+
+    uint64_t val = gpr_read(ctx, a->rt);
+    mem_write(ctx, va, &val, esize);
+    return true;
+}
+
+static bool trans_LDR(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    val = load_extend(val, a->sz, a->sign, a->ext);
+    gpr_write(ctx, a->rt, val);
+    return true;
+}
+
+/*
+ * Load/store single -- register offset (SIMD/FP)
+ * STR_v / LDR_v (DDI 0487 C3.3.10)
+ */
+
+static bool trans_STR_v(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint8_t buf[16];
+
+    ctx->ops->read_fpreg(ctx->cpu, a->rt, buf, esize);
+    mem_write(ctx, va, buf, esize);
+    return true;
+}
+
+static bool trans_LDR_v(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint8_t buf[16];
+
+    memset(buf, 0, sizeof(buf));
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    ctx->ops->write_fpreg(ctx->cpu, a->rt, buf, esize);
+    return true;
+}
+
+/*
+ * Load/store exclusive: STXR, LDXR, STXP, LDXP
+ * (DDI 0487 C3.3.6)
+ *
+ * Exclusive monitors have no meaning on MMIO.  STXR always reports
+ * success (Rs=0) and LDXR does not set an exclusive monitor.
+ */
+
+static bool trans_STXR(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t val = gpr_read(ctx, a->rt);
+
+    if (mem_write(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    /* Report success -- no exclusive monitor on emulated access */
+    gpr_write(ctx, a->rs, 0);
+    return true;
+}
+
+static bool trans_LDXR(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, val);
+    return true;
+}
+
+static bool trans_STXP(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;                   /* sz=2->4, sz=3->8 */
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+
+    uint64_t v1 = gpr_read(ctx, a->rt);
+    uint64_t v2 = gpr_read(ctx, a->rt2);
+    memcpy(buf, &v1, esize);
+    memcpy(buf + esize, &v2, esize);
+
+    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rs, 0);  /* success */
+    return true;
+}
+
+static bool trans_LDXP(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+    uint64_t v1 = 0, v2 = 0;
+
+    memset(buf, 0, sizeof(buf));
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    memcpy(&v1, buf, esize);
+    memcpy(&v2, buf + esize, esize);
+    gpr_write(ctx, a->rt, v1);
+    gpr_write(ctx, a->rt2, v2);
+    return true;
+}
+
+/*
+ * Atomic memory operations (DDI 0487 C3.3.2)
+ *
+ * Non-atomic read-modify-write; sufficient for MMIO.
+ * Acquire/release semantics ignored (sequentially consistent by design).
+ */
+
+typedef uint64_t (*atomic_op_fn)(uint64_t old, uint64_t operand, int bits);
+
+static uint64_t atomic_add(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old + op;
+}
+
+static uint64_t atomic_clr(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old & ~op;
+}
+
+static uint64_t atomic_eor(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old ^ op;
+}
+
+static uint64_t atomic_set(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old | op;
+}
+
+static uint64_t atomic_smax(uint64_t old, uint64_t op, int bits)
+{
+    int64_t a = sign_extend(old, bits);
+    int64_t b = sign_extend(op, bits);
+    return (a >= b) ? old : op;
+}
+
+static uint64_t atomic_smin(uint64_t old, uint64_t op, int bits)
+{
+    int64_t a = sign_extend(old, bits);
+    int64_t b = sign_extend(op, bits);
+    return (a <= b) ? old : op;
+}
+
+static uint64_t atomic_umax(uint64_t old, uint64_t op, int bits)
+{
+    uint64_t mask = (bits == 64) ? UINT64_MAX : (1ULL << bits) - 1;
+    return ((old & mask) >= (op & mask)) ? old : op;
+}
+
+static uint64_t atomic_umin(uint64_t old, uint64_t op, int bits)
+{
+    uint64_t mask = (bits == 64) ? UINT64_MAX : (1ULL << bits) - 1;
+    return ((old & mask) <= (op & mask)) ? old : op;
+}
+
+static bool do_atomic(DisasContext *ctx, arg_atomic *a, atomic_op_fn fn)
+{
+    int esize = 1 << a->sz;
+    int bits = 8 * esize;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t old = 0;
+
+    if (mem_read(ctx, va, &old, esize) != 0) {
+        return true;
+    }
+
+    uint64_t operand = gpr_read(ctx, a->rs);
+    uint64_t result = fn(old, operand, bits);
+
+    if (mem_write(ctx, va, &result, esize) != 0) {
+        return true;
+    }
+
+    /* Rt receives the old value (before modification) */
+    gpr_write(ctx, a->rt, old);
+    return true;
+}
+
+static bool trans_LDADD(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_add);
+}
+
+static bool trans_LDCLR(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_clr);
+}
+
+static bool trans_LDEOR(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_eor);
+}
+
+static bool trans_LDSET(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_set);
+}
+
+static bool trans_LDSMAX(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_smax);
+}
+
+static bool trans_LDSMIN(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_smin);
+}
+
+static bool trans_LDUMAX(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_umax);
+}
+
+static bool trans_LDUMIN(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_umin);
+}
+
+static bool trans_SWP(DisasContext *ctx, arg_atomic *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t old = 0;
+
+    if (mem_read(ctx, va, &old, esize) != 0) {
+        return true;
+    }
+
+    uint64_t newval = gpr_read(ctx, a->rs);
+    if (mem_write(ctx, va, &newval, esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, old);
+    return true;
+}
+
+/* Compare-and-swap: CAS, CASP (DDI 0487 C3.3.1) */
+
+static bool trans_CAS(DisasContext *ctx, arg_cas *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t current = 0;
+
+    if (mem_read(ctx, va, &current, esize) != 0) {
+        return true;
+    }
+
+    uint64_t mask = (esize == 8) ? UINT64_MAX : (1ULL << (8 * esize)) - 1;
+    uint64_t compare = gpr_read(ctx, a->rs) & mask;
+
+    if ((current & mask) == compare) {
+        uint64_t newval = gpr_read(ctx, a->rt) & mask;
+        if (mem_write(ctx, va, &newval, esize) != 0) {
+            return true;
+        }
+    }
+
+    /* Rs receives the old memory value (whether or not swap occurred) */
+    gpr_write(ctx, a->rs, current);
+    return true;
+}
+
+/* CASP: compare-and-swap pair (Rs,Rs+1 compared; Rt,Rt+1 stored) */
+static bool trans_CASP(DisasContext *ctx, arg_cas *a)
+{
+    /* CASP requires even register pairs; odd or r31 is UNPREDICTABLE */
+    if ((a->rs & 1) || a->rs >= 31 || (a->rt & 1) || a->rt >= 31) {
+        return false;
+    }
+
+    int esize = 1 << a->sz;                   /* per-register size */
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+    uint64_t cur1 = 0, cur2 = 0;
+
+    memset(buf, 0, sizeof(buf));
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+    memcpy(&cur1, buf, esize);
+    memcpy(&cur2, buf + esize, esize);
+
+    uint64_t mask = (esize == 8) ? UINT64_MAX : (1ULL << (8 * esize)) - 1;
+    uint64_t cmp1 = gpr_read(ctx, a->rs) & mask;
+    uint64_t cmp2 = gpr_read(ctx, a->rs + 1) & mask;
+
+    if ((cur1 & mask) == cmp1 && (cur2 & mask) == cmp2) {
+        uint64_t new1 = gpr_read(ctx, a->rt) & mask;
+        uint64_t new2 = gpr_read(ctx, a->rt + 1) & mask;
+        memcpy(buf, &new1, esize);
+        memcpy(buf + esize, &new2, esize);
+        if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+            return true;
+        }
+    }
+
+    gpr_write(ctx, a->rs, cur1);
+    gpr_write(ctx, a->rs + 1, cur2);
+    return true;
+}
+
+/*
+ * Load with PAC: LDRAA / LDRAB (FEAT_PAuth)
+ * (DDI 0487 C6.2.121)
+ *
+ * Pointer authentication is not emulated -- the base register is used
+ * directly (equivalent to auth always succeeding).
+ */
+
+static bool trans_LDRA(DisasContext *ctx, arg_ldra *a)
+{
+    int64_t offset = (int64_t)a->imm << 3;  /* S:imm9, scaled by 8 */
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = base + offset;  /* auth not emulated */
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, 8) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, val);
+
+    if (a->w) {
+        base_write(ctx, a->rn, va);
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
+ArmEmulResult arm_emul_insn(CPUState *cpu, const struct arm_emul_ops *ops,
+                            uint32_t insn)
+{
+    DisasContext ctx = {
+        .cpu = cpu,
+        .ops = ops,
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
index 0000000..eef8a37
--- /dev/null
+++ b/target/arm/emulate/arm_emulate.h
@@ -0,0 +1,55 @@
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
+/*
+ * CPUState is only used as an opaque pointer (via qemu/typedefs.h).
+ * Callers that dereference CPUState include hw/core/cpu.h themselves.
+ */
+
+/**
+ * ArmEmulResult - return status from arm_emul_insn()
+ */
+typedef enum {
+    ARM_EMUL_OK,         /* Instruction emulated successfully */
+    ARM_EMUL_UNHANDLED,  /* Instruction not recognized by decoder */
+    ARM_EMUL_ERR_MEM,    /* Memory access callback failed */
+} ArmEmulResult;
+
+/**
+ * struct arm_emul_ops - hypervisor register/memory callbacks
+ *
+ * GPR reg 31 = SP (the XZR/SP distinction is handled internally).
+ * Memory callbacks use guest virtual addresses.
+ */
+struct arm_emul_ops {
+    uint64_t (*read_gpr)(CPUState *cpu, int reg);
+    void (*write_gpr)(CPUState *cpu, int reg, uint64_t val);
+
+    /* @size: access width in bytes (4, 8, or 16) */
+    void (*read_fpreg)(CPUState *cpu, int reg, void *buf, int size);
+    void (*write_fpreg)(CPUState *cpu, int reg, const void *buf, int size);
+
+    /* Returns 0 on success, non-zero on failure */
+    int (*read_mem)(CPUState *cpu, uint64_t va, void *buf, int size);
+    int (*write_mem)(CPUState *cpu, uint64_t va, const void *buf, int size);
+};
+
+/**
+ * arm_emul_insn - decode and emulate one AArch64 instruction
+ *
+ * Caller must synchronize CPU state and fetch @insn before calling.
+ */
+ArmEmulResult arm_emul_insn(CPUState *cpu, const struct arm_emul_ops *ops,
+                            uint32_t insn);
+
+#endif /* ARM_EMULATE_H */
diff --git a/target/arm/emulate/meson.build b/target/arm/emulate/meson.build
new file mode 100644
index 0000000..29b7879
--- /dev/null
+++ b/target/arm/emulate/meson.build
@@ -0,0 +1,16 @@
+gen_a64_ldst = decodetree.process('a64-ldst.decode',
+    extra_args: ['--static-decode=decode_a64_ldst'])
+
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_true: [
+    gen_a64_ldst, files('arm_emulate.c')
+])
+
+# Static library for unit testing (links emulation code + decodetree decoder)
+arm_emulate_test_lib = static_library('arm-emulate-test',
+    sources: [files('arm_emulate.c'), gen_a64_ldst],
+    dependencies: [qemuutil],
+    include_directories: include_directories('.'))
+
+arm_emulate_test = declare_dependency(
+    link_with: arm_emulate_test_lib,
+    include_directories: include_directories('.'))
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0e504..a4b2291 100644
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


