Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94D9C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSGX-0005pn-Ne; Thu, 27 Aug 2026 01:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGV-0005pG-G7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:03 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGT-0002Ij-RG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:03 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8585c16ab5aso4602327b3.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806981; x=1788411781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qoJCBK/eJXzgVER7xSpcF+/HlWQEqa8pDFs252ZZUaI=;
 b=qV9zbJMhgOHzlGynQt2Lh+gHUtOPxB63IvJAqGgKPlYVCX3wvV6WvnVAQH4yLx638+
 qqrBUMchMZDJWT/8DIltdDGx5STx0wauGe1JxYB5rVRAfed+hXo4PFp3lmWXhihpWDku
 qarREQ2FypHFgsVlcIT3VQKeNyGo632LXUR1oAzPqlxqcu3XnpHoPuywe7GVNkxYWAB1
 QNrMSbWv8RUKblgwKaFJnBie7Hv92/C3bNRPUBB0XNGda1TyEfScgMgHsE4OEGQQlgeQ
 YdMJ/0t/KmHBw60/ZM8SsC8DWPPzlv4aCzx31WS9vFiVBlKTeu4hU5ML2e3I8t49Rbk4
 QGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806981; x=1788411781;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qoJCBK/eJXzgVER7xSpcF+/HlWQEqa8pDFs252ZZUaI=;
 b=SO53SjwCKwFSjYa+TzZm+qAn1Xj0R7zmPlqYq4ZiE/7aRi3cQqAQXXcTaAds8cKuGV
 6QZ+P2iblgWLEBBEc+eE2KdIKui3IeGJEwrvkt74w43hsU9W4IURvHDaZ50RWIiImXKI
 cL0eHpRf7vCoOz7r2L0BccnwYz1+8c5pxgFgS1MxXjVxRrx5CCulwF3rgoBnOsZxVMsD
 BzWwsc56daqt9ctZz6zc84TtSJLQwzpcwCX4nUSEOksYJV7hBwd+6upMZLr75L9FHuV+
 avVSbxoG36ksB5zg19MMnAoIiJljDKkF2M7sWpFmZcx69DndsCRx688YABR4GCt0jrFB
 XX+Q==
X-Gm-Message-State: AFuF++nfHfdRcsF4pUQmyneIW6IYJ3Q2v4m4Y4W0kzwlsnGhyVPWPfA9
 DUM3QeDlFcR1mYBuGlfbe2Ck9RlCEht7Hz2/6acA8+Z/olS51GwRX6j9hrk6AGlc
X-Gm-Gg: AR+sD10SrQNevDf9OPgJ0bV9wOoO/ar7kFxMuv21ho2ZPFJc9QdvTyALzNBBILLkvtU
 ynMhhM3g3H/+6xXv0RXU+IC7NFvWV2ojdvcmCkrkzJouszdw3CwBofc/8g9b5faoNFuJnUSiNDV
 bdL8Y97HSwsRPmQOCAnRLOMehZ+edAm62nbMGDIrv+HRwjyvejwroHvuAu7ttcR8YxZr7Y4MgY4
 obfEloEgcvMW9iZaYGC1oDd+OrTcmbXlVCk95/NRqMSYj+Wy29rOAy40XnQsNcV9eaKs0Bkb6KK
 GKug0gQTD9CKSRAa8B5v1wV6MNa4QzNfcVqcMzhEyjuIPV5Q8/9PToMeFDB/TSrY/JM0iyNJFb0
 BgTQOJlrcvH6Tmg3JfbRRC3ONV3EyrTatrm5rScNY+U3VsCoj3pqrPldyfD3pF6qJqVbgAPoNwJ
 QakdGfIH5TBGDWgIuViJtJzG2h11ADYtpkno6eIv6kycMhuORzNxhgl6d1xf/3yw1SCuSeGjPNl
 sVsdomtdtZ7pqRuFMy9lHO1PdRVxE2t24aH6wGu
X-Received: by 2002:a05:690c:399:b0:841:e9e4:8ab9 with SMTP id
 00721157ae682-857402a4134mr53042687b3.25.1787806980573; 
 Wed, 26 Aug 2026 22:03:00 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b5bc34efasm4267567b3.7.2026.08.26.22.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:02:58 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 3/9] accel/tcg: skip the can_do_io stores in user-only
 builds
Date: Thu, 27 Aug 2026 01:02:35 -0400
Message-ID: <20260827050241.3713332-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
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

    before: 1,469,772,951,575 instructions
    after:  1,402,667,803,616 instructions   -4.57%

    before: 121.04s wall clock
    after:  115.56s wall clock              -4.53%

The emulated compiler produces byte-identical output.

v3: Use #ifndef CONFIG_USER_ONLY again rather than
    if (IS_ENABLED(CONFIG_USER_ONLY)). QEMU's IS_ENABLED() is IS_EMPTY(),
    which is only true for a symbol Meson defines empty; CONFIG_USER_ONLY
    is defined as 1, so the test was always false and v2 emitted the two
    stores after all. The measurements above are from the working form.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 57daded60f..6c8fcd7a20 100644
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


