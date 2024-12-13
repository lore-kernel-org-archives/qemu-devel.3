Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5D3E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XZ-0007O4-VA; Fri, 13 Dec 2024 12:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wv-0006t5-Dv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wt-0001Si-Fz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso1544693f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111159; x=1734715959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2sM+UOA2cp8i3U3AHbd+sbKrYDIWz0dTXq1tSSSgIlU=;
 b=F4Wa1DX2TdHw+DSJE2R+7dFez2oCOS+xA7ppUClQ5/4JHC4bTEKMwTcejIgb6boaYM
 uhV1VKk+HBFdjc7SkufhCHLGd4WiStXiqezGxJxxPiNUKOHAfRyZi5x5hbeOn9ClJw+U
 bY18xugWDw/mAln6lgQC9277SSpYeSY9JO79fWpSw/MEJhHVKicdgMp5a0KX3k4thFkU
 A1p1wbCo4RLbTWuVJqqGX62IqoR9ywb9SVeZSfBzIjQDvq3AfQL5lgnrFQEvlq3FHjA9
 Erheqavg+AS9IVO7g7zII0ocFWE992QFABzHRf657m8/T9cGUE8vGxCYrUp45yUd3kVF
 HwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111159; x=1734715959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sM+UOA2cp8i3U3AHbd+sbKrYDIWz0dTXq1tSSSgIlU=;
 b=oaopO6Ppn3tYT19dcqTgXzqWbKkwClYT0g3xPErJBUsDCVnvdvSQ8JeufNoYovzA0i
 GAP8WaNBfzJMeS5fGCHUbUgpsfiCqb7Ay6vgEn0c53Xdmu6vyKWfn861Be2mPl4j7+FD
 i1lKFX/dSRmfegpmM2cTdSR1i0E9fbYjIavtfsCWvHe6/rYqZ0B8diEMv2DDtobNUeMW
 QXmmIRvnrHGYW4SafHTPabKJbqbLPRcpzWQcg/qIcmxspM05E5AjxDRrrfA3TGQ5caCo
 1qg9rZdkNToVuvtyxyqcK9ZJ5796tJGopqfsTlsd5Zz3T0Fpv9JdoqulrB4WOsNjc9yB
 YHOg==
X-Gm-Message-State: AOJu0YzTFXMBl8cZkGcKAki4B0K4gVAZQ/mrwSdQlwXyoy7/nr+j5+jR
 SnUp9NxT5/CAvU57SGqAeB7KD3k03GHX4jyG1HAtnRjQrdj7YvcPpHa4yvVzPTYL4UvWl8bFH2t
 P
X-Gm-Gg: ASbGncu9NYjSaFs2RF8hHtqFg0ztSNptUGwPuO4sPQ8X+4YcIqeBfGrFqsjWBdNiiAC
 JUbXZYe6nm5nM2pLFTKO0o3qB+B6UYaUw6we04h2K8KBXPjaosd3Jse2zU5I1+J34dsJVG0nBXK
 39urTzWXMn7JY3vhwTYHYz0rcELuHAGmfoolpxSnTyIJqx4Ih7nhOcpO3lLp3jSvNC6F+rBF0Jw
 63ilIHPcMJtQNACxa27CP/EEw7AWckQBtJcrmYu2Wp3ho682KZmwKioFrzldg==
X-Google-Smtp-Source: AGHT+IFACWhyEXEDhhwLeXEnd5tImkAM5rm6m4j4lhW/lcv7T/FfpX9qKg+mL6FAs7GpQYw0SRfAqQ==
X-Received: by 2002:a5d:5f52:0:b0:385:ec6e:e87a with SMTP id
 ffacd0b85a97d-3888e0f4784mr2536885f8f.43.1734111159509; 
 Fri, 13 Dec 2024 09:32:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/85] target/arm: Convert RBIT, REV16, REV32,
 REV64 to decodetree
Date: Fri, 13 Dec 2024 17:31:11 +0000
Message-Id: <20241213173229.3308926-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  11 +++
 target/arm/tcg/translate-a64.c | 137 +++++++++++++++------------------
 2 files changed, 72 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a23d6a6645b..dd44651f340 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -28,6 +28,8 @@
 &r              rn
 &rrr            rd rn rm
 &ri             rd imm
+&rr             rd rn
+&rr_sf          rd rn sf
 &rri_sf         rd rn imm sf
 &rrr_sf         rd rn rm sf
 &i              imm
@@ -685,6 +687,15 @@ GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
 PACGA           1 00 11010110 ..... 001100 ..... .....  @rrr
 
 # Data Processing (1-source)
+
+@rr             . .......... ..... ...... rn:5 rd:5     &rr
+@rr_sf          sf:1 .......... ..... ...... rn:5 rd:5  &rr_sf
+
+RBIT            . 10 11010110 00000 000000 ..... .....  @rr_sf
+REV16           . 10 11010110 00000 000001 ..... .....  @rr_sf
+REV32           . 10 11010110 00000 000010 ..... .....  @rr_sf
+REV64           1 10 11010110 00000 000011 ..... .....  @rr
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca8b644dc7a..1805d77f43c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7684,6 +7684,60 @@ static bool trans_PACGA(DisasContext *s, arg_rrr *a)
     return false;
 }
 
+typedef void ArithOneOp(TCGv_i64, TCGv_i64);
+
+static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
+{
+    fn(cpu_reg(s, rd), cpu_reg(s, rn));
+    return true;
+}
+
+static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    gen_helper_rbit(t32, t32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
+{
+    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
+    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
+    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
+    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
+    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
+}
+
+static void gen_rev16_32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_rev16_xx(tcg_rd, tcg_rn, tcg_constant_i64(0x00ff00ff));
+}
+
+static void gen_rev16_64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_rev16_xx(tcg_rd, tcg_rn, tcg_constant_i64(0x00ff00ff00ff00ffull));
+}
+
+static void gen_rev_32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_bswap32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
+}
+
+static void gen_rev32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_bswap64_i64(tcg_rd, tcg_rn);
+    tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
+}
+
+TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? gen_helper_rbit64 : gen_rbit32)
+TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
+TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
+TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8302,67 +8356,6 @@ static void handle_cls(DisasContext *s, unsigned int sf,
     }
 }
 
-static void handle_rbit(DisasContext *s, unsigned int sf,
-                        unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd, tcg_rn;
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        gen_helper_rbit64(tcg_rd, tcg_rn);
-    } else {
-        TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        gen_helper_rbit(tcg_tmp32, tcg_tmp32);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
-    }
-}
-
-/* REV with sf==1, opcode==3 ("REV64") */
-static void handle_rev64(DisasContext *s, unsigned int sf,
-                         unsigned int rn, unsigned int rd)
-{
-    if (!sf) {
-        unallocated_encoding(s);
-        return;
-    }
-    tcg_gen_bswap64_i64(cpu_reg(s, rd), cpu_reg(s, rn));
-}
-
-/* REV with sf==0, opcode==2
- * REV32 (sf==1, opcode==2)
- */
-static void handle_rev32(DisasContext *s, unsigned int sf,
-                         unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        tcg_gen_bswap64_i64(tcg_rd, tcg_rn);
-        tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
-    } else {
-        tcg_gen_bswap32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
-    }
-}
-
-/* REV16 (opcode==1) */
-static void handle_rev16(DisasContext *s, unsigned int sf,
-                         unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-    TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
-    TCGv_i64 mask = tcg_constant_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
-
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
-    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
-    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
-    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
-    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
-}
-
 /* Data-processing (1 source)
  *   31  30  29  28             21 20     16 15    10 9    5 4    0
  * +----+---+---+-----------------+---------+--------+------+------+
@@ -8388,21 +8381,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
 
     switch (MAP(sf, opcode2, opcode)) {
-    case MAP(0, 0x00, 0x00): /* RBIT */
-    case MAP(1, 0x00, 0x00):
-        handle_rbit(s, sf, rn, rd);
-        break;
-    case MAP(0, 0x00, 0x01): /* REV16 */
-    case MAP(1, 0x00, 0x01):
-        handle_rev16(s, sf, rn, rd);
-        break;
-    case MAP(0, 0x00, 0x02): /* REV/REV32 */
-    case MAP(1, 0x00, 0x02):
-        handle_rev32(s, sf, rn, rd);
-        break;
-    case MAP(1, 0x00, 0x03): /* REV64 */
-        handle_rev64(s, sf, rn, rd);
-        break;
     case MAP(0, 0x00, 0x04): /* CLZ */
     case MAP(1, 0x00, 0x04):
         handle_clz(s, sf, rn, rd);
@@ -8557,6 +8535,13 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
         break;
     default:
     do_unallocated:
+    case MAP(0, 0x00, 0x00): /* RBIT */
+    case MAP(1, 0x00, 0x00):
+    case MAP(0, 0x00, 0x01): /* REV16 */
+    case MAP(1, 0x00, 0x01):
+    case MAP(0, 0x00, 0x02): /* REV/REV32 */
+    case MAP(1, 0x00, 0x02):
+    case MAP(1, 0x00, 0x03): /* REV64 */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


