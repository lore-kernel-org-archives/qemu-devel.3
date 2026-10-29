Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491B606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k/d8bA6f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UrOvMSTY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRpR-00059y-M7; Thu, 29 Oct 2026 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpG-00053p-9T
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpC-0002yk-Q0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeXtl120324
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NPOUBIbi4rGDqPDE1Rv7rlIDdJdRR+XbT+WTGtzAY0w=; b=k/d8bA6fqm7m/toX
 3pR81u3J8Eu9PL9tuZElikjYtJijzjx+0Ovo6ArQ9p6srlBrboaNoO/MabKQhFF4
 LDc0XggUvRlrnaSf80PdN5VJ/hY/DVSNrFYRzes4COHKTcSpZe5XwrsxE4aOn7lg
 bQPLf3WpYKrzbqf1IieoDgrC0UFm+KOAiO47rPvANP9HXQ1WegpzmSilOgSsEyoD
 9JZMrlcSrQYFe5MFLF1IEx8u8shb7HTREjyG08dS4xoAEtxY1XA0QqPCTRsEup9J
 TfGSPf/d77eZMatscC23ZSkJ+1+2xwKucAdJszKfajV2C/HpoEy5xo8e/YW3md0i
 D2U8Vg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3k02d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9440b27c1feso342303985a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286832; x=1793891632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NPOUBIbi4rGDqPDE1Rv7rlIDdJdRR+XbT+WTGtzAY0w=;
 b=UrOvMSTYt9oeavKXXJKiZoqRdvdDjtKYMq9WSlJRpJ8+dJlHISc+bQq8AyInjMV2Gb
 9YXFL9KCigiBJrsZ++L17qbHgrpMXPSYxqKeakUYF6b1xHPRsv9fnBtRwlpacsZiIXtW
 9JkCbt0jRpbaiKuyOnB4GnjGc8z5B8BHKMr0d1IdADjdRXB458Ij4+MCPkKqn0W4rpPn
 d+ENsfuJnOhF33kLvX2iykZEkqtJ0AEStkgP+PHg2mIKUlPSqdGqAeKZ6MspiJjZI56e
 6MP4VCminlfhbYiA6kkLf47g01XMW+DnHMH0G1Qkavi2MRFbX1uGhsxyqkSB1hb7Qfss
 7mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286832; x=1793891632;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NPOUBIbi4rGDqPDE1Rv7rlIDdJdRR+XbT+WTGtzAY0w=;
 b=jKrhcvG8//XKnHJoPAWH748Hv3XnVTynxFF6AV5D6alq8e7hrCmmdhVlr2y3OKzL5B
 aX3ha8kkM0LxrV7tF3KAb64Kax31nrIZxXwxs0ycu3O5sTObeVkSjAcYXvy89VMoxaGW
 Qgp8RnC7fzVC8dyD5Y6lJ586YMh6YgIYoRvwSjL3mqPNeW7yDpcZMvwIaXnQm63+y1AI
 LleFP5ssUikXqR5Pbv56gDWI9h4tEZ9DQHLX1yNIjHH2aMNJKqKkMUG140Ho8S0/21Yj
 GTDCfH3wg2I2pUDYpNbgRd7K1yR0Hl8F4D5tkY95NUZ+H8prRY2sZyWUnEjCpUOPFP/q
 v+iQ==
X-Gm-Message-State: AFq9FYLRVc5T8vmArYscQabGrcg5Lv4sm9vqab5FsiL2LcWxkKEmZo7X
 3rpQ/ALGIODziNoAC35zELfSl8VZNSgUIkP3ogPKo8cZaoEgD4/qbbuDscPXllc2EFZah8WvXb8
 p2iWehlirBfgGdzRj1GLf+Z4+X5klLjB2F2cTATEjBSDwbXVtrrmOu2oKZuXwdqAQoSAG
X-Gm-Gg: AYBFou32LLUmylt3ntjD7DxEE0zpVQFhrVHKpdSSUiHfAvqgYgDl/Cb8Agqs+tv6UDo
 A86PKpyRibOCMhMNm+4GsanF0w1qYyVQWO9oLbEKr+ofe/rQ1dtDTbS9IgZ5o0XJaICfN2F/RLL
 uRJladKYUdu4Do5aetRfXekKb15AnDtr27Q6/qaJkd+3zhT6+2xbF17aiEYufsrmM0q8MB08TeO
 NqgznZ0qsZc/hSH9kjhHoafJ7DT9G7OHQvUCy9497oPXOhMRGyOYklA0lHC45/2446rMF8SaHY/
 g9IKR1h3ZEAOgfiNxDb1I6NGIKB7a8wc8lA5GXCH22kHZjvUugEZzcY5HEo0hv/EGSlRJUdh+os
 W5Q7cO4GQjx3F5VbMwQ1CKU4NqIUaLB+JauYD+AZDqJikcSsOYy2Oxzf5v07DOdoDNlTphaxcUd
 yqUa7BDTkaClIzUrkIgOC1IJGDZ9c5ng==
X-Received: by 2002:a05:620a:4008:b0:93f:35fc:5260 with SMTP id
 af79cd13be357-94408c975e6mr831745585a.35.1793286831761; 
 Thu, 29 Oct 2026 08:13:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:93f:35fc:5260 with SMTP id
 af79cd13be357-94408c975e6mr831740085a.35.1793286831271; 
 Thu, 29 Oct 2026 08:13:51 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm75596245e9.9.2026.10.29.08.13.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:13:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 3/6] target/mips: Convert MSA LD/ST.H (Halfword Vector)
Date: Thu, 29 Oct 2026 16:13:13 +0100
Message-ID: <20261029151317.19170-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX/0o7eamtCj/B
 DhNB483RLV3ck1jREM1lwGL0QTFhaXsK8AVB2dhMYLLom4DKdgmG8CFj/uaMdm5kyJzQuTinA5a
 4086BtqTnvm52Wma4e1tJQqy/m6pHX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX/kENVy9xop+l
 qkK1BkKrVPpwFPbO0hyd6V4hUGe3d4vIMHeaZfhtth7KkdHI1lrxECENYJJa3szwI+Ra/8VyhOL
 oz8s4jN8UcagAQHplsLw1Gb6Vp991+brhzN7mQxfSg3FfuqPhYqcgkV1FHjbDAg4jC6/nDM6I0G
 FoX8XuId8A0x3Q9P53gt7lGU17SbAObDr+2GWEKRE1/JssTggrUnmjH4/ZHEQZI6DVmGPxIDqn+
 fiV5BKIq3/vRKDk/7fGQzcUMeNHHQ29EklBKm9b6jmOXmjPXLHkoegHOKhyScuzg0kzD7gZTweP
 +N2GlXS5uEWRhPjidGH5tmUajjfK9rk2uut9Ug03Rn1mOkooVvDte6/9cdzDVz0qu5Z3Plxk2hL
 JErkse2zNVN1I6KWLS3/LxvoUkQQZxwLJ4KuOKQkdswP+KgLg+Ok1diI4JN2T2wW+qU2ZfT0qhp
 Od6/F9KcOwCNc/D95+A==
X-Proofpoint-ORIG-GUID: bTHkJDrvM4c5LaobLH1voQiM-wrchvGJ
X-Proofpoint-GUID: bTHkJDrvM4c5LaobLH1voQiM-wrchvGJ
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae362b0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kRuTmu9MxYQILl8-v3AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace runtime helpers by translation.

Replace the legacy cpu_ld/st*_data_ra() calls by
tcg_gen_qemu_ld/st() which allow to respect atomicity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 48 --------------------------------
 target/mips/tcg/msa_translate.c  | 42 ++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 55 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 50a2732e916a..86a79bf804ce 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -436,7 +436,6 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 #define MSALDST_PROTO(type)                         \
 DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(h)
 MSALDST_PROTO(w)
 MSALDST_PROTO(d)
 #undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 70de98050cdc..08c900785f9e 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8226,38 +8226,11 @@ void HELPER(msa_ffint_u_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-static inline uint64_t bswap16x4(uint64_t x)
-{
-    uint64_t m = 0x00ff00ff00ff00ffull;
-    return ((x & m) << 8) | ((x >> 8) & m);
-}
-
 static inline uint64_t bswap32x2(uint64_t x)
 {
     return ror64(bswap64(x), 32);
 }
 
-void HELPER(msa_ld_h)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /*
-     * Load 8 bytes at a time.  Use little-endian load, then for
-     * big-endian target, we must then swap the four halfwords.
-     */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap16x4(d0);
-        d1 = bswap16x4(d1);
-    }
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 void HELPER(msa_ld_w)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
@@ -8315,27 +8288,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void HELPER(msa_st_h)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  See helper_msa_ld_h. */
-    d0 = pwd->d[0];
-    d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap16x4(d0);
-        d1 = bswap16x4(d1);
-    }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
-}
-
 void HELPER(msa_st_w)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index b7ca352d07b6..0c6c2f4551dc 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -754,10 +754,27 @@ TRANS(FTINT_U,  trans_msa_2rf, gen_helper_msa_ftint_u_df);
 TRANS(FFINT_S,  trans_msa_2rf, gen_helper_msa_ffint_s_df);
 TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
+/*
+ * Byte pattern: ab.cd.ef.gh -> ba.dc.fe.bg
+ */
+static void gen_bswap16x4_i64(TCGv_i64 dst, TCGv_i64 src)
+{
+    uint64_t m = 0x00ff00ff00ff00ffull;
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+                                        /* src = abcdefgh */
+    tcg_gen_andi_i64(t0, src, m);       /*  t0 = .b.d.f.h */
+    tcg_gen_shli_i64(t0, t0, 8);        /*  t0 = b.d.f.h. */
+    tcg_gen_shri_i64(t1, src, 8);       /*  t1 = habcdefg */
+    tcg_gen_andi_i64(t1, t1, m);        /*  t1 = .a.c.e.g */
+    tcg_gen_or_i64(dst, t0, t1);        /* dst = badcfebg */
+}
+
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
     static const MemOp mo_atom_df[4] = {
         MO_ATOM_NONE,
+        MO_ATOM_SUBALIGN, /* Slightly stronger than required */
     };
     TCGv_i32 wd;
     TCGv_i128 t16;
@@ -778,9 +795,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 
     if (is_load) {
         switch (a->df) {
-        case 1:
-            gen_helper_msa_ld_h(tcg_env, wd, addr);
-            return true;
         case 2:
             gen_helper_msa_ld_w(tcg_env, wd, addr);
             return true;
@@ -790,9 +804,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         }
     } else {
         switch (a->df) {
-        case 1:
-            gen_helper_msa_st_h(tcg_env, wd, addr);
-            return true;
         case 2:
             gen_helper_msa_st_w(tcg_env, wd, addr);
             return true;
@@ -812,6 +823,25 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         tcg_gen_extr_i128_i64(d0, d1, t16);
     }
 
+    if (mo_endian(ctx) != MO_LE) {
+        if (!is_load) {
+            TCGv_i64 temp_d0 = tcg_temp_new_i64();
+            TCGv_i64 temp_d1 = tcg_temp_new_i64();
+
+            tcg_gen_mov_i64(temp_d0, d0);
+            tcg_gen_mov_i64(temp_d1, d1);
+            d0 = temp_d0;
+            d1 = temp_d1;
+        }
+
+        switch (a->df) {
+        case 1:
+            gen_bswap16x4_i64(d0, d0);
+            gen_bswap16x4_i64(d1, d1);
+            break;
+        }
+    }
+
     if (!is_load) {
         tcg_gen_concat_i64_i128(t16, d0, d1);
         tcg_gen_qemu_st_i128(t16, addr, ctx->mem_idx, mop);
-- 
2.55.0


