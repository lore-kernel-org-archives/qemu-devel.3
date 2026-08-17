Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED2CC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2b1-0002QZ-TZ; Mon, 17 Aug 2026 15:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zs-0006h8-VB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:01:11 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zp-0006kh-Te
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:56 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81ea0b7d137so31286837b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786993252; x=1787598052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KpvUL1chzZkJ6/YikyruA6kEN75GfHYu2PKgo1YZbyA=;
 b=PEetXr7lP03kZgsqxOYxiHWmce38/5yCva8IDHp7PuL4JFjLs4+6ZJVHzTb7zZg4ww
 2obSoOXoqDw6JsL1Oa4WgbC0H/huCPlIlULz8TzAXsGYQ4yapE1NAEQSsFk4RFMVyafd
 2zxxq5+/dvaYD+WjYF/y8n8ck/0xjEeubZTKKhdTZo7M8FahKrGZrG0mLBFGaNBYcTOm
 LxV+ezfnXfC93go1WHZQtt5XXO5cAJFl88axet/AOiGo74te5INfR2za2IkUgR5gW+J6
 dsF4/A7Bp8onbtFkRst8N2ZmxdRfkzJfgyp9gup1zzagXmT/HYEZRsduYPclYf9CisRL
 rslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993252; x=1787598052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KpvUL1chzZkJ6/YikyruA6kEN75GfHYu2PKgo1YZbyA=;
 b=DpGbxV90o9mHLfzt4gndqxIXFryBOVYsv/1NK+aieBaY0Spv9FvSFkZQ3TJKkio+q8
 FGuknRbGfGK1L3ntVjVAIORSzZTpEli8mijtBX2L69R8dTMFig6p+Sp9hiSBNHbb86Sy
 PER+N35RA1/aHbaTxtbT1PyIPwJN9rFsrQ1I86mv+FIDuVcIkD2XbVuCg8+UvtUo+l6d
 UO64AV/txQ9A7m558hBID0FFwCM2AX3s9EJStN0K38W13fFArdaTRQmcN+GaeNTRAy5Q
 zgP274ruIUvz4eXJBX4RHmtYmNbeyhSn0smmO+X0KtQwe8WCzyKKb1wcPIRuTiOsMtN/
 G3Ew==
X-Gm-Message-State: AOJu0YxG7ZqpTZTN5fHrfGrghOZZyzH2PbeyqljYWjbPt6EIKT/wongw
 XnP+CjzTL2wt94x23PSZqMj2NgeUQi4145XesdbOiR4Xt4dRaPS+xVpJhE2VzMNTwus=
X-Gm-Gg: AR+sD11G7PVAQ61+PSbzfPpnhaJ22tXLQfmh02g3589ZWlwmKMSuLhFIf3uyy0IR5vz
 +bFY2Brpofk6v+L0uYJoxII3Qu/BpmFkIufO4SdNr3ZOv7fq4PnbP0EFHi1B5TtV6j17sGdSUd3
 92NcrQuuDO+LNpbBFvD3/KhLkjkgyIR6Gev6RDIVmDTaFLvegW4hEw/nSe0ZcfXPp4klzZ6F/JX
 4zw+FILT2mJzZVOobbpVsRAzWrKdPHeuX9tI454fogN4Gjqx9bfzjdHQXMkIIsbk4XbRiJX8Vck
 Wg5ehB0FmmNq5kvnk6zSWaolMbz0aSWulTenXIhRGDVnrrJRzJbgWdjuEn8jeaJkPEgbuelxJfF
 jajhrGJ3JHhVuQlncTYb4aAWU/ObdCZwByw3+pjWlctcF672JwRntnnKAAKSDuoEAyJCTYTkPGf
 rrFSghQ06YsB942DiRIWXekWBL1+LYpImmcTQeG1klXyh2psJbBq+Y/fmTAeGw
X-Received: by 2002:a05:690c:c511:b0:81e:6cdf:b2f5 with SMTP id
 00721157ae682-837077121e3mr103551117b3.0.1786993251718; 
 Mon, 17 Aug 2026 12:00:51 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-840f3264142sm8242527b3.38.2026.08.17.12.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:49 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [RFC PATCH 3/8] accel/tcg: skip the can_do_io stores in user-only
 builds
Date: Mon, 17 Aug 2026 15:00:33 -0400
Message-ID: <20260817190038.580257-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817190038.580257-1-mattst88@gmail.com>
References: <20260817190038.580257-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Every translation block stores to cpu->neg.can_do_io twice: false before
the first instruction, true before the last one. Nothing reads it in a
user-only build. There is no memory-mapped I/O in linux-user, and every
reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
tcg-accel-ops-icount.c.

Two stores per TB is not much on its own, but TBs are short. An emulated
alpha gcc 16.2.0 compiling the SQLite 3.45.1 amalgamation (255k lines,
-O2) executes 34.2 billion TBs at 6.04 guest instructions each, so this is
68 billion stores for nothing.

Measured on an x86-64 host, LTO build, on top of the preceding two
patches:

    before: 1,469,729,281,442 instructions
    after:  1,402,816,253,499 instructions   -4.55%

    before: 120.97s wall clock
    after:  115.75s wall clock              -4.32%

The emulated compiler produces byte-identical output.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index cd7d079fe0..29e609b2ec 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -21,12 +21,14 @@
 #include "disas/disas.h"
 #include "tb-internal.h"
 
+#ifndef CONFIG_USER_ONLY
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
     QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
     tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
                     offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
 }
+#endif
 
 bool translator_io_start(DisasContextBase *db)
 {
@@ -210,17 +212,25 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     /*
      * Manage can_do_io for the translation block: set to false before
      * the first insn and set to true before the last insn.
+     *
+     * Nothing reads can_do_io in user-only builds.  There is no MMIO
+     * there, and every reader (cputlb.c, watchpoint.c, icount) is in
+     * system_ss, so skip the two stores per TB entirely.
      */
     if (db->num_insns == 1) {
         tcg_debug_assert(first_insn_start == db->insn_start);
     } else {
         tcg_debug_assert(first_insn_start != db->insn_start);
+#ifndef CONFIG_USER_ONLY
         tcg_ctx->emit_before_op = first_insn_start;
         set_can_do_io(db, false);
+#endif
     }
+#ifndef CONFIG_USER_ONLY
     tcg_ctx->emit_before_op = db->insn_start;
     set_can_do_io(db, true);
     tcg_ctx->emit_before_op = NULL;
+#endif
 
     /* May be used by disas_log or plugin callbacks. */
     tb->size = db->pc_next - db->pc_first;
-- 
2.54.0


