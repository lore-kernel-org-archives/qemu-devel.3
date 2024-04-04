Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01379CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWA4-0001zx-TS; Thu, 04 Apr 2024 19:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsW9y-0001z7-Lm
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsW9v-0007h7-Q7
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:18 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29fa10274e5so1050344a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271974; x=1712876774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rr1mCO1Um6MwdRz3KPxmuXvDuPkKMy5I80GI3tAWlUQ=;
 b=H/4Rdsc9jW3ewKGxn0ARmAgZV5UdFW04qx8m2CsR6FWoiCjm2/ki4yu/H4lvZF8EVm
 yn/vHkAP2bjXM08EWXxDho+knAlXgLo97ehnP2nOHHkK34Ia7EcEGKuXiBktmn8uz4Zr
 9cX1jhq2fBiyigGzODFzYCeMnLBWqecubchbIj/F2JNDgdKHPqN6mI3pCH6kOQFXSh/V
 nMU3QfYBQm3A82IC4a9HPz2xeHBmm+7Nok88CyC/tLoWR+gUnmeG/YHgDavFe5KbpZpX
 o9WLwkRf5HgfGzBYbRLwefpvTXOQCDB8EW8VLN+l44OWR8tmU+LNv7EDOhnb7QaXunyd
 HCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271974; x=1712876774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rr1mCO1Um6MwdRz3KPxmuXvDuPkKMy5I80GI3tAWlUQ=;
 b=Wvu79BxLLZHyWwNW8aoB7r5/mRZ+Bz6e70mcsvImcEIKT2hrAUUeH5TzCxhIa/uQqR
 83pBTNkIvF+dnudMuJ8j7QexBrUThAbZif9JWEq4ZjpSQX4WaX/IOKUroqIkr9grrmO7
 +cMg+x7P0aILgFOzd3/syteLF5QuGDJUdpebCPKGd+ysNQx93d0oYyD456r72m1PxsP8
 XBAT40K3MbPaNy1Q9pCb00BFfklDQFbUS1CsVd/doRIrS5gy8ED5wmIaxcfk2CWNb1bd
 V7iwNB8CexT9frCF1ba6OAmA8Fl60HG6eAD4THtXqgFiY00yxyURyX6LRL5s0JbSaVDd
 P+mQ==
X-Gm-Message-State: AOJu0YwgPeIZIPm5C2GtyvL25tWiLS4n4mhB8U3lh+vXB6kefrSe9wNO
 a2Ujq+dg7wPjIEAUpXg9gQ+o4DAeyI9KuRDm+bpIUE0INZ2JpvX2IO5PlOVgRAJC3laqSPWJN/D
 6
X-Google-Smtp-Source: AGHT+IErBUNceLB4Rve2Kk9QhMGS+WN5XBwLO2SoVs4C8UqeuWE0sFyh1X/7oTghT2cZe5If6l4ywA==
X-Received: by 2002:a17:90a:f008:b0:29d:f0f4:1e63 with SMTP id
 bt8-20020a17090af00800b0029df0f41e63mr3762116pjb.39.1712271973794; 
 Thu, 04 Apr 2024 16:06:13 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/21] Rewrite plugin code generation
Date: Thu,  4 Apr 2024 13:05:50 -1000
Message-Id: <20240404230611.21231-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Add a (trivial) mechanism for emitting code into the middle of the
opcode sequence: tcg_ctx->emit_before_op.

Rip out all of the "empty" generation and "copy" to modify those
sequences.  Replace with regular code generation once we know what
values to place.

Changes for v2:
  * Fix TCI build failure.
  * Drop qemu_plugin_insn_cleanup_fn movement; I have another plan for that.

Patches requiring review: 7 and 8.


r~


Richard Henderson (21):
  tcg: Add TCGContext.emit_before_op
  tcg: Make tcg/helper-info.h self-contained
  tcg: Pass function pointer to tcg_gen_call*
  plugins: Zero new qemu_plugin_dyn_cb entries
  plugins: Move function pointer in qemu_plugin_dyn_cb
  plugins: Create TCGHelperInfo for all out-of-line callbacks
  plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
  plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
  plugins: Add PLUGIN_GEN_AFTER_TB
  plugins: Use emit_before_op for PLUGIN_GEN_FROM_INSN
  plugins: Use emit_before_op for PLUGIN_GEN_FROM_MEM
  plugins: Remove plugin helpers
  tcg: Remove TCG_CALL_PLUGIN
  tcg: Remove INDEX_op_plugin_cb_{start,end}
  plugins: Simplify callback queues
  plugins: Introduce PLUGIN_CB_MEM_REGULAR
  plugins: Replace pr_ops with a proper debug dump flag
  plugins: Split out common cb expanders
  plugins: Merge qemu_plugin_tb_insn_get to plugin-gen.c
  plugins: Inline plugin_gen_empty_callback
  plugins: Update the documentation block for plugin-gen.c

 accel/tcg/plugin-helpers.h         |    5 -
 include/exec/helper-gen-common.h   |    4 -
 include/exec/helper-proto-common.h |    4 -
 include/exec/plugin-gen.h          |    4 -
 include/qemu/log.h                 |    1 +
 include/qemu/plugin.h              |   67 +-
 include/tcg/helper-info.h          |    3 +
 include/tcg/tcg-op-common.h        |    4 +-
 include/tcg/tcg-opc.h              |    4 +-
 include/tcg/tcg.h                  |   32 +-
 include/exec/helper-gen.h.inc      |   24 +-
 accel/tcg/plugin-gen.c             | 1007 +++++++---------------------
 plugins/api.c                      |   26 +-
 plugins/core.c                     |   61 +-
 tcg/tcg-op-ldst.c                  |    6 +-
 tcg/tcg-op.c                       |    8 +-
 tcg/tcg.c                          |   92 ++-
 tcg/tci.c                          |    1 +
 util/log.c                         |    4 +
 19 files changed, 417 insertions(+), 940 deletions(-)
 delete mode 100644 accel/tcg/plugin-helpers.h

-- 
2.34.1


