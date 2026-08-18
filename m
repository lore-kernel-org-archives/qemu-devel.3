Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF271C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNq7-0002u8-3r; Tue, 18 Aug 2026 13:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq4-0002sx-Ol
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:04 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq3-0007wI-9c
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:04 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-841f1dfc30fso14888937b3.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074982; x=1787679782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0rVJQgX3N6MU4TQ/rSCCOxj3fDdMcQCXO6e891ulN60=;
 b=hO7/E+JlwPHQOsQTO19WObemiA3DBQo9vBFD7VBTpLs7lZSzR1jEsGbV4EESjP8G0H
 HqZX5CaIpSKsZghmtR/hGF+Nl4bvaryI7eVUG5WI1ljvtT7SgLxVo3IHbVBx+aTggYoq
 pglDx3IfBKOY0TPr6DVjPPoE9wEVxxByqjSqIYKeHjri0vaHCoXWA/1xBjvO0GK64xDq
 ZTiERoDGPa1dKXAHcGMxnxNacWHQgpgYbfdWDoUspxbfhe3V6W5Cs7T2Iy2pWEwfRQXI
 tDuWUkGXDZ9VUC+bg+Fk4wl0kpsbPpkmTO1uQ0RNxxVpgD5Rq9wVqWxszJ9ToHi75FT0
 kJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074982; x=1787679782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0rVJQgX3N6MU4TQ/rSCCOxj3fDdMcQCXO6e891ulN60=;
 b=srOGhR4NHZsCjXWB/BfETsNGxNf3A5msELptBNnzpWFJkLJLpsVJuWOZEXHjKSbpq9
 /l8kjVunQ1gKpMBTIPdvMZTmJWcd/WTDAnuNrmku1WYLKMfacn/BUH+tiMQUpvt/qnHr
 BiTXZY4KEfjvj1N8YNafde136e+8NJVNTDrqLMjUen9x8OiLdFFpKDWbt4VEork6aTwl
 HkP0eegpeUFRoLbKQdOHLUKBb8HpgiYLWJGZXYF33RIiAe0iu6VU3Otyr6BQcVoD//Go
 hCpGiV9gLoSMGVWg6eHPb4MIGDxC8DZjNFnO+5bwY1RjMVqRyFIJuzPiydEYKAyMrTNf
 60Mg==
X-Gm-Message-State: AOJu0YxmMv9wetzRqRsBntTCevhWHk3pSREifOuhU1vrjmLwQISo3tqo
 D61jESEVcE7rpZt02T1tFuBTp9s56z/fmZeURKi2EwCyMfR17hZFZ0RLS8mc+yC9ES8=
X-Gm-Gg: AR+sD10AGnOADU3924U+a0dA33bi45iE/I10bkfUndT4BuTZhkrprQLQBziXE+PlHng
 eboNNboQd2NFA4hBNJURkit8XJxIVS6aGcJ1Vo/Ip2za6soHhp4IRwvX2eBoTKWSMueDpRDbgoM
 dZvDomn2ODrrO6OtIx4znJDa2M6TOpkh4D4WnXt+VRu7NdY3ju4YlkrPN0+BTOhzPfYTguMHXWc
 p20+tdTazlEfHDSylJ8QmDOFwcEn5z/cFXGE8NjsLdW9+ROK8wNdeMUV7djsd0Lo6/gAsMkaG1a
 O07zF2Vj5tCb1jO/99fw8hqr+jQSV38K0SWqBkgL/3pqd6hd/HpM6VTOy0xTNKjxJQsFicGO7fi
 O/+8hc1qjVGdhxQxkP5u1a1h6XFaZTQ/TGYXIYQwr6J3ky0WXiWra31heo/CjFu+TIxEs6Mlg4y
 VY2WtHAvrerYinGgb/k1iGPsYhi2VQvR+KISqw7K5UsqkBGl+MM2/p3eI07qeM
X-Received: by 2002:a05:690e:4403:b0:668:14a7:d00d with SMTP id
 956f58d0204a3-66cbc0da051mr2190665d50.2.1787074982026; 
 Tue, 18 Aug 2026 10:43:02 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb47ee907sm2659066d50.21.2026.08.18.10.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:01 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/8] accel/tcg: skip the can_do_io stores in user-only builds
Date: Tue, 18 Aug 2026 13:42:42 -0400
Message-ID: <20260818174247.649526-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112f.google.com
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
 accel/tcg/translator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index cd7d079fe0..85bb21e911 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -23,6 +23,9 @@
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
+    if (IS_ENABLED(CONFIG_USER_ONLY)) {
+        return;
+    }
     QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
     tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
                     offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
@@ -210,6 +213,10 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
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
-- 
2.54.0


