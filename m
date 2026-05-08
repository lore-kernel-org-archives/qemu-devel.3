Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C7BCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtm-0002zE-8G; Fri, 08 May 2026 11:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtG-0002hG-P7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:24 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtE-0001kZ-Jf
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:22 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-435153d9b68so1271639fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253199; x=1778857999; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uraQUC7CmqH7WHj/Zvs9bcsKQvF6ASjiwV9ETQK23L8=;
 b=IQOdtHd7PCW5D7GPkWlkafHeHYY/ywWFThRZqrdEm6opG+qNAxriVf/2mn2BdYudxJ
 PqrZMS7gMsEhkgrH0VBHsSUz6pfobsDu3E5u3V/6ML0UMUg/bRdDtykdVrYhldqSrpND
 O+0Ys/eXqTrE1flNd1H0jtUJGsbutzKAssEY6Hg84++zzR1TX1OPuk8B1HHcVu+f7fbN
 EtDk5vto2oeqIQW9pkJmda1r2/4Yh28rjfUeIRylLkw7GG9COS7He85cTIak/FAsrvo+
 jE3wExWGKxqNBzCQOHvMGm5V2tkit/xX6LYug4aHtwXzuTTmGSTSqAbgXCMdNcAxSzSk
 bCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253199; x=1778857999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uraQUC7CmqH7WHj/Zvs9bcsKQvF6ASjiwV9ETQK23L8=;
 b=HVOEzkZuxw0N5RlNnnxVo+LitJH8Sc+Ba2fZl5pgS6hcyWqh4ynA22nJhNmPEOOR82
 wMySHybb5Efvd1XlU9qOAUz+M1huPKK8zUGRNWQcPX8i8YMBpGRfd2Qlu0/0MyhXGtxz
 7Y5r5OTC1c5SsK4tqPPCwzyem8GD6ifUXWG6Zoec8r4DbMkdf6ik5Z+gJqCBPcuy2tlG
 xAOvFFLLpW7CMI7AehizRqJnWYltt2Brxgct2AQh/q4A6zHwJeaDlJyQlB3jcfmIj8vL
 lauq4IXjkc+sPOlhLzR8o9j2TkRphlMnS3I//I2Z5OM+Ug26joWkdWOp1tESuvz17Ofc
 n5ug==
X-Gm-Message-State: AOJu0Ywam3e+KnUCreFaIGNHoRGbaLfEzxz17h6CP0zJcHFNGB6JMHJL
 ovV/FGVBc9rxRAHfeQqO13NIfCOnh9N1zXn10+HMfGrdI/bgby1U7aKzbqpQ5w==
X-Gm-Gg: Acq92OETfD8aFTdtpl16GfHjMXQjiB33G3d2T/4kvW09a0ec39g+i1fXkabAs4xqJN2
 tTkADgzK1ZXY4GOXmmmxE9fpkXk5Mo7Syi6IJ07VcxPC8+2uvqojVHUtr1dlbM8Nu9x8G+DO9dW
 WP62aA2epxXhxxQXVhBmGqRkkzTWUGW9Y5lR0FZNRoicEvElpYhaGkyNi8v2jSI5Uhj1+kDZVtt
 nTFSHtPeLECf3HmqF8SkzbN2vU7KVzBkpsmPH2fSzZPlQlmVdpP3bW7vaf0az2GrdpNmYvHiZVH
 iEXBkT9evaiSxanH8/LwWn/F+3jPeEpKVghNdGeaoKKQTx0N8QNggPyeUnMMI+ixx6UAuY9YV6e
 OII+GpJrBtSOgBvmTcUVXdVJp2Od/lda0wo4aSkW+CTFidHlDqX7WU1C2EGn+pQ4AfJ6JSHvxa1
 t+vMIhcYoP4u520q0nM0EIa+rzdvKit9IkbuoSCcwnv6OAawJ29XtjZCsflkT4dEzcWsRjjfZAe
 W79vIHmYGSFulOdLTBAAMUIJ4quj8TlEuz3mLVINb0Qo57NqO+G/A6xYtMmvGvtQYB909TAeD4w
 Kr9cobNieFWwNaQhiWU8ST1h/YnvuqgkSTQLUzl1EoxbfVoJTq/zeiEkGhgf8MlSpbnbE2I=
X-Received: by 2002:a05:6871:797:b0:409:81eb:cf56 with SMTP id
 586e51a60fabf-434f655e902mr8281485fac.27.1778253198874; 
 Fri, 08 May 2026 08:13:18 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:21 -0600
Subject: [PATCH v3 21/32] target/mips: add Octeon VMULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-21-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2e.google.com
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

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Add helper and translator support for the two-limb accumulator operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split VMULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
  - Use uadd64_overflow() for multiplier limb carry accumulation.
    (suggested by Richard Henderson)
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 target/mips/tcg/op_helper.c        | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e2b83a1d19..f1e78ae329 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -24,6 +24,7 @@ DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
+DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 7de2a8f6ec..1c3dbb4a33 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,6 +50,7 @@ MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4207f01e85..bcbf73c052 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,8 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+typedef void gen_helper_lmi(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
@@ -281,6 +283,20 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
     return true;
 }
 
+static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
+                       gen_helper_lmi *helper)
+{
+    TCGv_i64 rs = tcg_temp_new_i64();
+    TCGv_i64 rt = tcg_temp_new_i64();
+    TCGv_i64 rd = tcg_temp_new_i64();
+
+    gen_load_gpr(rs, a->rs);
+    gen_load_gpr(rt, a->rt);
+    helper(rd, tcg_env, rs, rt);
+    gen_store_gpr(rd, a->rd);
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -296,3 +312,4 @@ TRANS(MTM2, trans_mtm, 2);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
+TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5b..ab3fb06a16 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -144,6 +144,38 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
 
+static void octeon_add_limb(uint64_t *sum, int limb_count,
+                            uint64_t value, int limb)
+{
+    while (limb < limb_count &&
+           uadd64_overflow(sum[limb], value, &sum[limb])) {
+        value = 1;
+        limb++;
+    }
+}
+
+uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[3] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, 3, lo, 1);
+    octeon_add_limb(sum, 3, hi, 2);
+
+    octeon_add_limb(sum, 3, rt, 0);
+    octeon_add_limb(sum, 3, env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, 3, env->active_tc.octeon.P[1], 1);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    return sum[0];
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


