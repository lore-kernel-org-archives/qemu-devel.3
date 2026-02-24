Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C31F4BB82
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy8Q-0002Zk-Ap; Tue, 24 Feb 2026 14:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7H-0001qL-Nv
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:31:07 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7D-0000ng-SP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:30:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so56659575e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961437; x=1772566237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wz4xwsVedpRdwPffxWHKLrRmmOeokKoi4JBBPga8kag=;
 b=C1Fh9JgEN/AxYmKQMXFKU3mjD+45t0qX29ozGLdjvYMIw7oHnL7ebBAeOLsMXz9V9p
 pC0eupxQmhv5631DkQE2Pqk0zUoaH8xSamQKoRxD9uKH11l7N0G+C+3xbzqA5hQ54Bbd
 EO+U0pxiPuDSKb55BwB167cXWrrWncz6c+IvxUEoFdIfyvcizgGwRE1E5FEt1rkKtZwh
 DmthWiXNrMjh+MSRVq7rIWOw3k8qv3Y38YcU8DVqj+VxrRbUVu1Y3wAFIs+5eqhf4Ptw
 4Ny+CUYgaUL68x1AI7mni0Kx5S/HRYXhknGLlwbDWAROdoMg6kWDkcv1MT69g3CKIbK6
 rMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961437; x=1772566237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wz4xwsVedpRdwPffxWHKLrRmmOeokKoi4JBBPga8kag=;
 b=jqP9yoOx+rWqfjL+nmQ90pBaSk0nW54wFSXt3iq/VVvRLwUlg3yDBo3/DzL/Sd38j4
 r0OJziQ6DO+w/ua72Z5ZTxTT3IpNRoB1uc/XN6pl5X9qFXt0MpdsiQEhjGMhCgMaXwOZ
 5Yu9NYXysn+g5IYP6FlokTxuPmkDytMw4aBqKj6Lxcn3Ru/cv74f68iS90Ei3F8XEkCs
 MMgVrMDQhdSkBg6iPQ+ojtR5sYoIZnlGpZw9dywC5KJKiaOH/FS2ywMUTGafR72IPmXy
 i6WTq//syjb9fuYKjsA7pg799eVkKVT/KlmhRZ2UVQaA9p5cPGvE9cj2uwr7bD3Fh0sE
 bUDg==
X-Gm-Message-State: AOJu0YzV/uwuU4AkZHRAI9u4cnERK31elTwQiiRQA294/L0/hodv70eX
 9y2FnG7ikIqfv+jZa5t1Wab2DXBwL4J2xn00hQEwsdiQozBsyCP4tMD838mWpo603dGeABt0D3k
 17DhOsAo=
X-Gm-Gg: AZuq6aJceL6Jzkk/ErIbnoHZQoKqXS58Y/jMga/PwrVyoxHk/gl/ERuwtdOE3oWNwEj
 8MudTNY1vz3Jr/TGFNy8rwCX9CO5eJG6J1TmVMtZG0x6iADvCSNVB7pNpMH4VbiyVUbs9vTVkGz
 +VT2pNtdTUfp6F03qPMQohWLBRiUOJZXww4lsLNj2GVx9HRJ9pYOvCQMky2Qsdne+WGosQdVDsU
 58pV7f+OVyFfvbl4DWgPFDLFxEHO7G1iZcYP+FPA79N5/oojBo0rmtVbVzcouOSIIm7TYhKNXGv
 O0JctbKXbdIbbxShilabRljoMwxrccfojhxb2VlNnuFcDF7b+4KEAlnUgMN5eSNiodqyfbTsCOu
 XFvkCmd3LWMQlvYoDcqmnxQ+iN8JK9NXWeJM+YChxhCxQ1/aV2vTDlL7V4e/f1NW3gFnxtSzCyX
 pZFaRROt90G/rquN7qN9wJVrolYz/mctvsvn5i2iXxgauYMLrkRAimhDGgqkUyMIG1Cq574aCI
X-Received: by 2002:a05:600c:821b:b0:483:71f7:2794 with SMTP id
 5b1f17b1804b1-483a95c9e73mr240437805e9.15.1771961437464; 
 Tue, 24 Feb 2026 11:30:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f2f88sm20099555e9.2.2026.02.24.11.30.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:30:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [RFC PATCH 1/5] target/tcg: Rename bitswap() helpers
Date: Tue, 24 Feb 2026 20:30:23 +0100
Message-ID: <20260224193028.2370-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224193028.2370-1-philmd@linaro.org>
References: <20260224193028.2370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In order to avoid symbol name clash when building
a single binary, rename TCG helpers prefixing with
the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/helper.h                   | 2 +-
 target/mips/helper.h                            | 2 +-
 target/loongarch/tcg/op_helper.c                | 2 +-
 target/mips/tcg/op_helper.c                     | 2 +-
 target/mips/tcg/translate.c                     | 2 +-
 target/loongarch/tcg/insn_trans/trans_bit.c.inc | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 8a6c62f1161..e36dd2f5de3 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -7,7 +7,7 @@ DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_1(bitrev_w, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(bitrev_d, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_1(loongarch_bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/mips/helper.h b/target/mips/helper.h
index b6cd53c8538..1c9f76f0c9c 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -16,7 +16,7 @@ DEF_HELPER_3(lld, tl, env, tl, int)
 #endif
 #endif
 
-DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_1(mips_bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #ifdef TARGET_MIPS64
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 16ac0d43bc9..6b4fe535300 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -32,7 +32,7 @@ target_ulong helper_bitrev_d(target_ulong rj)
     return revbit64(rj);
 }
 
-target_ulong helper_bitswap(target_ulong v)
+target_ulong helper_loongarch_bitswap(target_ulong v)
 {
     v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
         ((v & (target_ulong)0x5555555555555555ULL) << 1);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5be..83c340e38e0 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -45,7 +45,7 @@ target_ulong helper_dbitswap(target_ulong rt)
 }
 #endif
 
-target_ulong helper_bitswap(target_ulong rt)
+target_ulong helper_mips_bitswap(target_ulong rt)
 {
     return (int32_t)bitswap(rt);
 }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54849e9ff1a..a63aa67808e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -4839,7 +4839,7 @@ static void gen_bitswap(DisasContext *ctx, int opc, int rd, int rt)
     gen_load_gpr(t0, rt);
     switch (opc) {
     case OPC_BITSWAP:
-        gen_helper_bitswap(cpu_gpr[rd], t0);
+        gen_helper_mips_bitswap(cpu_gpr[rd], t0);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_DBITSWAP:
diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
index ee5fa003ce0..76d6ba742d5 100644
--- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
@@ -194,8 +194,8 @@ TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
 TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
 TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
 TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
-TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_loongarch_bitswap)
+TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_loongarch_bitswap)
 TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
 TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
 TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
-- 
2.52.0


