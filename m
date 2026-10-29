Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC64606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXH4wPeZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ffWbkuVh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRpI-00056f-DT; Thu, 29 Oct 2026 11:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRp7-0004yA-6t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRp5-0002yU-9F
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCdoJD1147256
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oMCFMf0hTeBV+bsJ3akwrL98ruNrzwxT/pO5EMTY+hA=; b=BXH4wPeZHBwJuZwg
 UyfqrnVhp+0Mn4lI7+HfxRYXHyRBmE1+SS2EDITgZ7wj+HBeKy1fpr+ZodaW+UTF
 +PYDnAOUUcBXNBKkaco9N9KtTYajDBKZo5uDqZ9zOGK//Mhymcqbds1K1BpssxfU
 nFgsqMWowuC3NYgnLMPzDPugaSI55F1zMVHe5E7ibHz4AoH1PYmrmKGgiBfBcz21
 4HL1i9dRcUkFPb+XXAq1EKNTe1fdGHlY/2SGINMq13lrAk63+QpxSoTJ0AFUMZ8A
 SFOpQviudfKrx+lMaxdeReHpZfNtzxkJAUNiK3MjSfDOKodSECTih/YR77G5shNd
 Ppmrbg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q94jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:45 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cb225252f4so647902137.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286825; x=1793891625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oMCFMf0hTeBV+bsJ3akwrL98ruNrzwxT/pO5EMTY+hA=;
 b=ffWbkuVhID7iwbg8v4kN5bgLCUKVTkkyd726xP6O/RUtfigaprPqBJOaqGK1LINd88
 Dlyr5ANJRiKS/Vx5dePKK7UjIK8JQmHQPvPTp/AM0c2r2psRy6JK/3uT139aTs0lTH3R
 NqJl+jXyEO4RWTCuNmCirGc1dCVhGKEIXQb7tuIaGt53cyBGSY//zGL/9pqawrKHBDt9
 hwOIzw9+LXRbgCWvNpVdlmYXStPe4kaQ3qI2bPG9ZO3pUDXeByxPYUadsrqIQkFpoZxq
 3XQbhZG0GC8MYPbhdVZYXZXiqkyJVDhd8l/CsAmwmkfjSijBw7zjhRfXMlg+qM7au+28
 bb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286825; x=1793891625;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oMCFMf0hTeBV+bsJ3akwrL98ruNrzwxT/pO5EMTY+hA=;
 b=hTHAxNG5W++wTcy+A3G++mPxDPbuwGl0cCf60Lez75d0yfG4m+qG53CSR/uMoX2UDQ
 sVhxn5kHWBkto5EzCdZuZTt+5QWOSd6QQdZgKlLJ40GLFBfPGJLjhE7wtE1k1PWT9O7O
 uRvSQXCoyKhHYIebQ4SdSIs3CuaMcyI0doFcRIDRM+euP4FzoE51j8EA8P4SmbzViwis
 MZao3Kjn8p8Wnd44byOCfOLuX6EzeQvX0f19k0OsQ41GSJMTPoW/IH1W3Jpu0PA/4ddK
 O4j4BtvGSrjiXx+6qZ58ZeV7zWQaKSJWG+qyQd82/gmuxJKmsNUEEbVDfbwpJmVm06mm
 muqg==
X-Gm-Message-State: AFq9FYJkFYrz7pXk/Ugtyc7b9q/pMH3M1wlesdFdYoxRlJtpt+TECJBu
 rUXkQ1WrV09/lZCRv7iYw+SGorBIktoBL86bjuuoe1N1jq/eGlynWGd25iiBewLYu422MjDst+V
 m7OLchjsSM4WOVIZrM6WmLEexOySkH9i7GLbFEsdVxWOhcxGVKZYLoUSQmti67OCiOkqM
X-Gm-Gg: AYBFou0JqJJohma7YLC5nfhE2O36lw9k6wSsH8mQQi8gYKc6QmNmpXi/9paX8CkxCkY
 vY7odqpCzbFkJKCxe1xcaWa5XkUe9JnXUKGIe2hWyh9hpHcyH0ufXhtYnJaX2bXlW1rtDZ1Tx08
 e0qZgkhFvSZKIvxAjn/AFoiP1y9C6EYu+/BfLjDXe5QRC4WGMz7PHiTnZJv6xM5JKYNuS4VHiYR
 qEM0vljnUauRaZcTCagib3MUS4b3X9CsSEhkRofhfVsWHCXCEWH6xyF9i7yzGyZLJUIZaU85fOg
 zvWOfHELZkxhpC3BghGSaHrRTAW0G4BiervpQsighF5HKeYQFFuozFF/l6ZvEvHJuMwnJd9tr8Q
 F/hCx4cDWjmK59M7r4bLAgs6bE+yGUd+HG1p4hOyoeRiLRaDIHOX9ABl6fZa926hBwu5rH32+Y+
 C6o40enhOuliUXXDrSvyO6jKtk3rbTsA==
X-Received: by 2002:a05:6102:e0b:b0:7cc:a4b:b0e3 with SMTP id
 ada2fe7eead31-7d0541814a2mr933010137.13.1793286824595; 
 Thu, 29 Oct 2026 08:13:44 -0700 (PDT)
X-Received: by 2002:a05:6102:e0b:b0:7cc:a4b:b0e3 with SMTP id
 ada2fe7eead31-7d0541814a2mr932997137.13.1793286824126; 
 Thu, 29 Oct 2026 08:13:44 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm35347047f8f.16.2026.10.29.08.13.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:13:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/6] target/mips: Convert MSA LD/ST.B (Byte Vector)
Date: Thu, 29 Oct 2026 16:13:12 +0100
Message-ID: <20261029151317.19170-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfXzm5kNy+hh0SC
 U998qjHz5O52w3nPcL1eggNqi0G1CnvVfRuACLovNHEDwg64QsqdszKr4l1vUhvygMj0RpnVQYy
 nwnmjClCH6lEDspCgYAuSOtJXmuyRJA=
X-Proofpoint-ORIG-GUID: Rnv8U2Be6qIAf0Xis3JFZSAcYDZFwSZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfXwc/VqqDx8Vzb
 llcDqroFlesc1iGPdFZXRVXlC1kjf8alSzW18bDAQJzioId9TeLL/LmLUqZ7KmBZESxDSCFijhs
 zAGbnnsGdtqOHOoDTbQhX9mQaqbraC8P4W3rHziiaxqNyweHlGokx5371BtnZx9z5WWiM6/SuKd
 q4RckQ2kKNhpGZUB1Y+d1a6aQ809FNhRPdPktI1lucwW2Uvx+/tEO1vrE4Y3m/H+v3J59MWHS8n
 NyE+TMFgC6YFLOJ3Ic8g8w2t8JqAnPVFVS4UmAU0e9P6xC4GNaOinhjLSxOe8tQjMITaQa0oJYe
 D1nDE0VHw2Twcfa/m6h1dEwEpWfTbL4At/q4BB86MMBz6+spRSRiJ8hqMr/20FkNus6mbLzTiva
 78b+WpsFb2KmjjIE6GmPp34JTRtCsGAKD5iTn0s9SdRJoFHRo803RGpJVVnx0OZvj15WpMZBTH4
 CnGR/8Cyr+0dWsu4bPg==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae362a9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=d_CV8yIliXy7NolUMewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Rnv8U2Be6qIAf0Xis3JFZSAcYDZFwSZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
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

Consider the host endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 28 ----------------------------
 target/mips/tcg/msa_translate.c  | 29 +++++++++++++++++++++++------
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 4963d1553a09..50a2732e916a 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -436,7 +436,6 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 #define MSALDST_PROTO(type)                         \
 DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(b)
 MSALDST_PROTO(h)
 MSALDST_PROTO(w)
 MSALDST_PROTO(d)
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 1919ce6be9eb..70de98050cdc 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8237,20 +8237,6 @@ static inline uint64_t bswap32x2(uint64_t x)
     return ror64(bswap64(x), 32);
 }
 
-void HELPER(msa_ld_b)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /* Load 8 bytes at a time.  Vector element ordering makes this LE.  */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 void HELPER(msa_ld_h)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
@@ -8329,20 +8315,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void HELPER(msa_st_b)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  Vector element ordering makes this LE.  */
-    cpu_stq_le_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
-}
-
 void HELPER(msa_st_h)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index ab4b1998aa0b..b7ca352d07b6 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -756,8 +756,16 @@ TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
+    static const MemOp mo_atom_df[4] = {
+        MO_ATOM_NONE,
+    };
     TCGv_i32 wd;
+    TCGv_i128 t16;
     TCGv_va addr;
+    MemOp mop;
+    int idx = a->wd << 1;
+    TCGv_i64 d0 = msa_wr_d[idx +  FP_ENDIAN_IDX];
+    TCGv_i64 d1 = msa_wr_d[idx + !FP_ENDIAN_IDX];
 
     if (!check_msa_enabled(ctx)) {
         return true;
@@ -770,9 +778,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 
     if (is_load) {
         switch (a->df) {
-        case 0:
-            gen_helper_msa_ld_b(tcg_env, wd, addr);
-            return true;
         case 1:
             gen_helper_msa_ld_h(tcg_env, wd, addr);
             return true;
@@ -785,9 +790,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         }
     } else {
         switch (a->df) {
-        case 0:
-            gen_helper_msa_st_b(tcg_env, wd, addr);
-            return true;
         case 1:
             gen_helper_msa_st_h(tcg_env, wd, addr);
             return true;
@@ -800,6 +802,21 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         }
     }
 
+    t16 = tcg_temp_new_i128();
+
+    mop = MO_128 | MO_LE;
+    mop |= mo_atom_df[a->df];
+
+    if (is_load) {
+        tcg_gen_qemu_ld_i128(t16, addr, ctx->mem_idx, mop);
+        tcg_gen_extr_i128_i64(d0, d1, t16);
+    }
+
+    if (!is_load) {
+        tcg_gen_concat_i64_i128(t16, d0, d1);
+        tcg_gen_qemu_st_i128(t16, addr, ctx->mem_idx, mop);
+    }
+
     return true;
 }
 
-- 
2.55.0


