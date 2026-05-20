Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC4CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgR-00013U-D6; Wed, 20 May 2026 00:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgO-00012v-Qi
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:26 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgK-0003lm-Qp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:23 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e5c85b47c6so1125087a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251839; x=1779856639; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=LAay1NyiyeY74QapJfdvDiN/Tpxv8ViP8WcExZWrK1pd+jrJH7j+zylJocMJwUCdMO
 AKOCuIcvWDSXK6uA4zH2iaCUPCqN/jt82jGcK6RjMKns+pYWadfv5Dp6iABZdq3noNtn
 zRuImegXK5kiSpG1T89xjF00723VsmHE5B3tlmbxGNDaGdpNoG1yMhegwAYn/HivaITL
 bCc3iyTK4a9UFYi/8kiBiiWtPo0+/mDUqCVDicgYtnroPikdma9GQ6qslnwDIXiZhRd8
 lBX17e5unbO5d5c1CJN4OLZkewdIiD7sACSH7Npnan+ZcP2ay87kTI/nou1DxTtJu+IX
 TkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251839; x=1779856639;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=mA2uJVsDrhlYbP28KHU7Bryn9lzNGrs3EP3pe6gN2HYHaKZ4CZlvbR4yTp+BRWi2ZY
 WGz9ulFkh+XrvtJveV968O+RBHmRR5DhP9vnrdNdHfa6MZygBSO3fCmv+DcLHKKGaGU/
 BEPW4iVJ88J7f/PJzLTynQr4jirdslAdTeuPj2ge0SM0SArRobxNWktq3FzEkHewTzSk
 e/x2lF3hp55S5Negr2qwwjPLWYRcXBSL4WNBPUYyttZ1e4SUJsk97RLpcZzPMMcWzz/a
 ppIMlT/u0RjjzcaC4MQXffB4BShuFBKJfBIsZX41h2585b7FmcV770A9ubvvJFxeAPbF
 aMmw==
X-Gm-Message-State: AOJu0YwGCjwlgJ1z0IFfwxCLwqwJbxDVZETJjQPBcJHp/iVKYiLt+eKZ
 k7wg4qd+Hij/4Rbhgxj0AaVCy/4kLQy22pxuttaE72SdxB08ItQfscyY
X-Gm-Gg: Acq92OHUwpZNpoQsXe2VGHrw9MRcymzvAndqL/wRDKMiDdNhI+yio/1DoQNMqITUq4s
 pf8lq7u4m3cKJHgYSzDKOQCbCjuJQMcI1cjEyd7FiJXNhBAFCeApEIVwZ1urQzkvkcWJDjrYf1V
 kV+O0lzMN5kPVFPNO6lOR/56wFcxYxkE/Xcn5LaxYQrtIXk/tAhNgDwDSIOY9i2n7QNJqvMwCMm
 0nE/lusvNMYbrAzWjLrsBrkM1hs7WTQcikbxOUZISSuw96vPZhVQgMJx0EXGhLahDceZtxrXSfC
 5C5Z+xzyNS1miJTDBfkjBLXzwBdAfBz0dT82wvj2ElGAuLwARIeu/kkafGyaIScZZ7nimOuaRsr
 wnaOUMP/6PxXHrTlmu0ofJUbm0PhxU+AAusUbH1GWjtAxtygIbCIqnvqA0Lmc4ixtG2EGydohqC
 CuAx8mNYAyWuc22upobN2IqVCoEMJhNo80hyCAwtkK7uBzK4KEeADfSz/5xYUrdeezmWVdKNoAj
 UXTwuJ1iJvxhgcDLL2Ev//5WhWlYKeDhfSjdbyjq9asnBzhRjy7mhB8ppQkbIPaDpwLrBji94W2
 HktFGeOT6vxD6g==
X-Received: by 2002:a05:6830:7307:b0:7e3:fa18:746e with SMTP id
 46e09a7af769-7e4f2b1cbd3mr16928116a34.16.1779251839084; 
 Tue, 19 May 2026 21:37:19 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:36:58 -0600
Subject: [PATCH v10 04/45] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-4-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


