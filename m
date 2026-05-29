Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19F7CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gi-0005HU-Vd; Fri, 29 May 2026 15:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GY-00050T-T0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:11 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GX-0005aM-2C
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:10 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-43b6f19b7d4so5729241fac.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084388; x=1780689188; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OJWK/EkTlXrsXIihSwbH79j1+Y9Z/xhoRkrOHiWGDKk=;
 b=Qy3KWGOryzu0R/RDeo7KnWhOBpBipKfcYIcMqH6R/jPBtOR4FGIWpDbkKkXrUMVPCk
 wsoSWXyJhdsfD749YxPEJ5L71bdx6KAvvncbP/Leb157tYLVxjYK8M/7nxH2q9WFh79E
 8gm6l4vGF7PtBJ5OQDJCqurJoSQpy8w/UNAC6LTbuXcO82qBWuPD0h4Q+p48V0ZH+MML
 YZD70B3HUEgjE0K2dhqZ7NQ0KTHjhBF8F3qn7CiB/ejqG+PL5b4di6+0Jwqds7PYrPFr
 wBMrIbbt28UjsMhWSUoYQ2yaypV9iUR+XK3oNdfuhQqikUhFyxwMJ3d9nNtRO62OWG/1
 LZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084388; x=1780689188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OJWK/EkTlXrsXIihSwbH79j1+Y9Z/xhoRkrOHiWGDKk=;
 b=m5MJpIRokgFM48PMLk3srqz73AZh05t/G8OPFBUP3fSuspB9BUHd+6HidS9C6Ndc6i
 7zvb0F5uNHskmi1WMHKrkJt6VKKM+ZFUqQUorSg+pwYPFZsKQi72g9/as0DIoNjxE6pk
 296VbP+tIlN7KY/DRzRGLlbSQHbahhT0/gQ69B8+inWWNy+6wWH+rS1+6eFRnYWjCx3C
 IATFW4nRJoGZ85j99wbM/J9M0EaeMr5VE3b8SRSvVLH7xjq24l/gryNR2W0Du1wQ6RyW
 8MuoTkim7QdRKRMWOhgLTbQ2L+csukLCs3IXiU6m5gzHqU/IbaVtR2vTwiPd2yzf4b++
 mrIg==
X-Gm-Message-State: AOJu0YyEQpLCekrmtJPVWsSblTRQMRdHsXY7lSFgORLn3/XihIkHrge4
 cSesLCaZdtIRUT2sTsyihSGldBPubcRXECMHZIsh/jdFypp8P30ejbw5
X-Gm-Gg: Acq92OF/AjVI/aWuDLtsFRMvtCWYtYTiiTE2L5KNqqAUzfihRenStYEAm1wL7l+1BYW
 +HuQTYroYDpKg8PbTaVKWlrK6Pe8CiQKqj92/zn2Xx3LBpu9UXmgGa0M08VfBUdKqw+ofvQ363m
 kBZAneCYUHzOZvbJ3G4DPdIcMwZGjuPNQk1EMOkqB3yqxl6F+YwiXqOnUV7InJCXRHwtRIFxPiw
 vagWkM8mCxDkWBVE1eW7e+ULjI0jwvAEHbWl0YYM7hhIe5hr8FZxtkKjCnzBf6hkxDo4mrQIvWM
 dQjj5RVyADKiV8WBvUYVVYU1fN886k/IUfchuHEMGuE+viIF2V2BENmmhvnvVT/J337Blnv9xG2
 xmkdudYsS2cZ4xH2KeeuuEqPTmB8RdLSYkWHSd5QE3LUuIE/i0MnNRslz5D6Kg8wzgBXRO7HMDw
 gX/EvHvP8096zx7Tpsowivkk2RKLBoODmu9n2DXqC0hzr+BfsYfuT/qA==
X-Received: by 2002:a05:6820:2906:b0:69d:f794:5959 with SMTP id
 006d021491bc7-69e105c89bbmr380990eaf.56.1780084387759; 
 Fri, 29 May 2026 12:53:07 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:07 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:49 -0700
Subject: [PATCH v7 09/15] target/arm: load on canonical tag loads ext bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-9-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=4424;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=ucqsYSjKNLvRjA8zNnf+RDqvB6/wlstLRsyvDgUe30c=;
 b=uTgMOcWX5l91glXE/ctf6rvfNpOSuGieGWKAhAlj4MWi7/Kw7JfHSOqHippSJuKyE2bs0lXw1
 OHuoZoqmQAaC0p0nW60B2jxYiX8pNq7pgTtafpnIUMdMyA14VB4mOEO
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Loading tags from canonically tagged regions should use the canonical
tags (extension bits), not allocation tags. See AArch64_MemTagRead().

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h |  4 ++--
 target/arm/tcg/mte_helper.c      | 14 ++++++++++++--
 target/arm/tcg/translate-a64.c   |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index b7880f773e..c196c927f4 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -102,14 +102,14 @@ DEF_HELPER_FLAGS_3(mte_check, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
-DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(ldg, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
 DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(ldgm, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index d35e3ef04d..c382f0149f 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -304,7 +304,7 @@ int load_tag1(uint64_t ptr, uint8_t *mem)
     return extract32(*mem, ofs, 4);
 }
 
-uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
@@ -317,6 +317,9 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
     /* Load if page supports tags. */
     if (mem) {
         rtag = load_tag1(ptr, mem);
+    } else if (mtx) {
+        uint64_t bit55 = extract64(ptr, 55, 1);
+        rtag = 0xF * bit55;
     }
 
     return address_with_allocation_tag(xt, rtag);
@@ -458,7 +461,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
     }
 }
 
-uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
+uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
@@ -476,6 +479,13 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
     /* The tag is squashed to zero if the page does not support tags.  */
     if (!tag_mem) {
+        /* Load canonical value if mtx is set (untagged memory region) */
+        if (mtx) {
+            bool bit55 = extract64(ptr, 55, 1);
+            ret = extract64(-bit55, 0, 1 << gm_bs);
+            shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
+            return ret << shift;
+        }
         return 0;
     }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 036081d897..852578aae1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4715,7 +4715,7 @@ static bool trans_LDGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_ldgm(tcg_rt, tcg_env, addr);
+        gen_helper_ldgm(tcg_rt, tcg_env, addr, tcg_constant_i32(s->mtx));
     } else {
         MMUAccessType acc = MMU_DATA_LOAD;
         int size = 4 << s->gm_blocksize;
@@ -4750,7 +4750,7 @@ static bool trans_LDG(DisasContext *s, arg_ldst_tag *a)
     tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
     tcg_rt = cpu_reg(s, a->rt);
     if (s->ata[0]) {
-        gen_helper_ldg(tcg_rt, tcg_env, addr, tcg_rt);
+        gen_helper_ldg(tcg_rt, tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     } else {
         /*
          * Tag access disabled: we must check for aborts on the load

-- 
2.54.0


