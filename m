Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFF2CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMuM-0005CD-DS; Fri, 08 May 2026 11:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtH-0002hS-KS
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:26 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtF-0001km-5I
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:23 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-42ff0576868so987731fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253200; x=1778858000; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rEvObFEBKOnUCp3+aacmCnWcRQSvflnqgpsWE2tFMLw=;
 b=Jx1xQu2rYly36BFLFraqAy4ksZnjAOqZmYVCRBxBlewdCZQ+dngbjy9+AMUzbmpkCc
 1P9FX1M0/V8MizraCV7CvYA19NQ0gWfJDlmyTPeN5CIVjPap/vmHPxpkS01EoRa7TjG+
 WcaOZcnlhzujfWeH37a303iCUnAvxqR+cZDYNzCuILpwo2LFHq8fvJ85c6IZZufqrXdB
 l8LVZ4kB3tLV66/N01upbHK8CgPGh2TIAkYydofYD96AgEknbWj9aybGQB1nBmBI3Bw8
 DLekqidMup/SVtef91iRocC2qCe5uOHyDTd51K2h2b/pe/Fy46NGmuc3Egw/5fEK8qt0
 7YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253200; x=1778858000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rEvObFEBKOnUCp3+aacmCnWcRQSvflnqgpsWE2tFMLw=;
 b=mQIPKB37tFcG+/MYcqRRyv1xrP7nTVsM5goSKWmPvbUZMlu8evNAci6qvBST8Fws3n
 Xv4GXCSyBgKFbIcXJXs9WobM2A4HVo9I1yvmwmtMSiXxUngbFauJ8ogWLhvjLZAIgbD5
 THUi5ZVkCuLCA92Kzc3Moj2K6SWQNj4NA47Ai6xBhe2GBF5jCk4d+HvUbuPzhC9aPFFj
 DdCjTc9z7lf5LzBEgbBp+bkkC1k5Q0dbI/rmCiSFrZM5TfM2zmr3RhgdczaXXkBCwpj9
 QyJQ1T/oq2sAkdfdHTxG//wCeByjpOp5xP51A5aXwxcbj5LMRhFi/GCl7DWIrDGL3tu+
 xJQA==
X-Gm-Message-State: AOJu0Ywxbr6ZGD06ROK8J9V9ZDVAY8X8Uvqu5xIPW8HmF7ODpHU1TSZ4
 1aqJgg858URZIiRmPKabuLqC75/liHDO7ZYVGDZ/HrKLG5UqTrQSzLgGydpcNg==
X-Gm-Gg: Acq92OH4G3cqDF1hbqoAz21CECsJe7h247YY20UrXN0hWvddc5fkWLMC9nj1R2EiNrN
 6LPOLW6G9x1gDcwCYNyq8N06FHU/Byk3oaZCiu3ZB7urXcufDp7vmnPtXGI85fuYT8emkKkd8BW
 3sQhpz933gH5wH79nPgJMAMNU6PUJ+Y0mKKtF6qWm9RQexig1kOiSVMP/5T/cevImPXvjT71Km7
 7GPuu/sTfbgNUBofoqWVlP3PIaBaEsrIrxTscZFKpUfFvxh4Mp0MHzzf2hDe2uHmDfs83KVBSue
 M0yM6u+GyYPboVGAMF06phF3dE0h+s9/FkYKEcTpdVENpOMBqwQFxHWs2iMoeJyDJxOfTWm5Hmd
 N8QeRE5GNIphTdFDzWw8DlrTrX8J03wn1eBF9ralukfeyU/ysSOtIPJQS95pC+R59k/LN4HRcdu
 rPPagvwYOtlou1wg7mBChM5Nsb/0iAa8nxetgAOD2BD0YX5qo4YV1HDHWkjqZ396DTJoAl+8Lkq
 g7PrYqAjNvWxDHoX4Fy5MMk2o8A27gUncMgtassrCZkxtBXmrvZYltD+8/9g/L8UconBBSWqE/T
 s71pKv/TEEH1EB3GhFcL4vfV0nIH9y+5yJXlE3ATbs5r7EvFO3C6y0rqWob1PIWNcFP0Th0=
X-Received: by 2002:a05:6870:a453:b0:430:2e5:df00 with SMTP id
 586e51a60fabf-434f60edb43mr8487439fac.9.1778253199702; 
 Fri, 08 May 2026 08:13:19 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:22 -0600
Subject: [PATCH v3 22/32] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-22-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x32.google.com
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

VMM0 performs the VMULU accumulation, returns the low result, then feeds
that result back into the MTM0 multiplier state with a zero high operand
and clears partial products.

Add helper and translator support for this multiplier chain-update
operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split VMM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 16 ++++++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index f1e78ae329..46ccad95c3 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
+DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 1c3dbb4a33..8a909ffcee 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index bcbf73c052..c1dd03debd 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -313,3 +313,4 @@ TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
+TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ab3fb06a16..a1465068af 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -176,6 +176,22 @@ uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return sum[0];
 }
 
+uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo = helper_octeon_vmulu(env, rs, rt);
+
+    /*
+     * Complete the VMULU accumulation, then apply the MTM0-style state
+     * update with the low result and a zero high operand.
+     */
+    env->active_tc.octeon.MPL[0] = lo;
+    env->active_tc.octeon.MPL[3] = 0;
+    for (int i = 0; i < 2 * 3; i++) {
+        env->active_tc.octeon.P[i] = 0;
+    }
+    return lo;
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


