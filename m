Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7543CC624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUS-0000bL-Tu; Mon, 31 Aug 2026 23:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUR-0000aR-4u
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:51 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUP-0004LN-Hy
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:50 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81f36179d72so49828077b3.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234528; x=1788839328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qoJCBK/eJXzgVER7xSpcF+/HlWQEqa8pDFs252ZZUaI=;
 b=qPmzS/BdgUMH8cYcvO4X1aHPnxlwtTv1uikyST8hsRu4h4IEkQCheoysDXZeN989Fp
 xAOl4aLbljABk3Z2700Yz8LQqmQbYwe34i48h6Mxf1M4SNmaUfvpPwBuapXUcLM+rlJ0
 DiOiJLH/fDYjmQBjQlsKJmOmm6KeM+iC8T08SwEKuqyf96TdsAde3c+rCgr5rhoQ8oDq
 dbQyj8xhTV4wW+jpQrhwyt2rYTgFeswZruZ9GW9ufDGxWnSNXVegNOtUv7Cj8LJu9VMk
 YLsvfQ7uHu2lmqg2TJth4xKoisJb2RwsLDLr9ubBn/xbYkXKVkRiC4i7SlRMVCIZU9qo
 xT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234528; x=1788839328;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qoJCBK/eJXzgVER7xSpcF+/HlWQEqa8pDFs252ZZUaI=;
 b=Yf69vSSe4o42NXox8Lu9RC+Y+GX5w85TTTDrtUJFRY2pXk6Oeo6JkylYoR7yJShshN
 LtszKF607pAV3rV3vV2CdGZXkz0MtX2g3SOxvqqmi7i02o35HErNUQaPYsFlGhdzDiIQ
 AHSsNEBt+mB1R5JgN52yLGPBoeDX9YjpJ0Ma7IvGziFW1IA+ARN01Y8m/umY9Q9t9z0M
 wRdEONdUL9JCIeDO8ObGz7VEzEjJNDO5d09fk5TwX8/G8uw/knhv8FfxL8xvXWKPInen
 sIGvqBQz75K27yHhW7SG4HeNrJpKIiX5mxUbv6s+dz0TpJ5EQaWWdkKzEQ7A/pOHfCE5
 xUrw==
X-Gm-Message-State: AFuF++nMWm/X/W3UhSfDrytIJkLDnA3J0NT90nRod0aV3QmVko1aUOpF
 +tZ0BAkB4eiQWnvbulm4ZgtVfmxtLj/3yHO7WYLvFnQXK5yQOZhiLW3VgLXwBA==
X-Gm-Gg: AYBFou0HReXiXDAhRdJFinjtnY2j+TrsLZDLCDPciKOMQrAoNu6zRn0D9brZ4ktvsy9
 rZ8S8uJO9/ugVKGoe5Rb+DQ6ia+el8QAVrWAJexH9CeJLOQGsjUOutBhIb9hA/ifCd6rsykkDXf
 tCPSfQD12eG/1bwh9WEBF0RHJW0N6QpXXl/TeK1HoOOZcYOgEr7DWe/b/Mo8szjnzol5v7+z5ia
 /kV7ovstprauy9TloBru43kGYsKsmjWcHMBi+pH7gjJfoIfWzGIqipRKy77D6e00UiUH8X1fRyg
 jhGkCnQ/1HRwUS+nOF05L472b6AvQFkjxQjQ4fSopwuoil+A6+M/5XvUIidFbZRS3TKCo22Go9x
 zq/YimRDcCi3/0Ffu6tA2eUrOoX4N9kssVpH34V8P//NYXE2yT69olW6FHiee9F9q7ThIsG9clO
 opvf8u5Fl4gA/uqrlDizwaFMn53TZav8uEJKUaaVJO5mqWtqiGw7+F9l4nrEZmC/ytEeHPO6wue
 2kFIanEUOUrjdNH3Xh18XRxLZ4z6AW2i3Aj3gyw
X-Received: by 2002:a05:690e:1443:b0:66e:6089:b3ab with SMTP id
 956f58d0204a3-66e6089bff8mr5321106d50.47.1788234528345; 
 Mon, 31 Aug 2026 20:48:48 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66e4ea2d6cbsm7335283d50.0.2026.08.31.20.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:47 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 3/9] accel/tcg: skip the can_do_io stores in user-only
 builds
Date: Mon, 31 Aug 2026 23:48:02 -0400
Message-ID: <20260901034808.3524945-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112a.google.com
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


