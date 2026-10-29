Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BE606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NTfbCRqm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVxo1gcI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRpp-0005R0-6V; Thu, 29 Oct 2026 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpN-0005C1-PP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:14:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpK-0002zF-HB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:14:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCdqDC1147348
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gcAyAxCpNlk8DMy79yWMRsFPnBtIr58Iim7bIx9LPHo=; b=NTfbCRqmSceNdW6e
 ZxWzQDs09GFx56fOnNZb3xgkp3pJ5/vqOSgaMlHFNpT5jgCxO/A14rQ6jaWx46Dj
 VUbPClVJ11TYT12CmG2XRAv9saZ/9vGFZp53RV3fbjcV5VB+1Dk6/Oj1+rRvPinc
 1QAAIVMyygju6zD29qtNvRrd3u6vjyp4fLKrEMZJdxaRv+yKxxB+0tIQkupHY0ed
 HvquK6ei1KoHuKESd/rM149wIT7VmtDZzxTaDS3VBboO3ZIGJwuQcMODLHMoS4cE
 l/tsKXoat5N1NPWXjGpBcO52OLDs38zxo5nXs1QYw/CQ1Yy0MGC1/wZwOEgSusDY
 5bjhHg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q94ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:14:00 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso506636241.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286839; x=1793891639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gcAyAxCpNlk8DMy79yWMRsFPnBtIr58Iim7bIx9LPHo=;
 b=EVxo1gcIIhCBPx3tI520HSlU+1wXiVUbc3WfIMHsAvqouzAvUXQIQd0ZDC19hldrlA
 xnSI+UJCxz/mfK6zFfKZImbvr9EG+yvnPoKvKZTm8qN2wyRAY/KoU9X49lQOtvEnRNIQ
 mkNXiE+GmC2CZy0cbdbwxZMP92eynGinq2m+l/AsldTDPU988o/8P0nDdlKWrLfZynvW
 3P8Pcmyk3M8hLo+9EKWvjTNNHLj9th/z67bh1Sd5G1FfOUojRxcMhs8ae5VUxRYqPcCo
 Cuq27AqIsul2np73NCxk/Tk43OrYo/LseJB6IxsOg2hCddyeqFbEPr+Fb+BIoKCx5GQ2
 iUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286839; x=1793891639;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gcAyAxCpNlk8DMy79yWMRsFPnBtIr58Iim7bIx9LPHo=;
 b=W0juHx5zYJfynkCg/jWvcodIaRiezkO4pujSR+efeH3MJfAF8nJQre78I3Jy6BFYJN
 lprJRF+buVfu0CsdJUXDtfip5RGgIQQrojB0grVv9Uhr+13GUgNU5vdHsmGcgRtYQxyK
 dPy4l5udMUEFf1j/24aqvZ3sHlLg0PIdqNKBFxi9gwR8Hg/cTf1KZQA6nXOfSNS4x3O/
 3JfOWIW+Cf6t8nhXvfXFmLLw8dD1gy1J8w9NQinuKGh0W/wx5sy1gTS7ttbi6nOTGmv3
 5yPQq4B20TC1EzXc4lsbFGdqDusdQy3xUsazCpB1cjcYahCAGJ+Ox8w1FypJceDdyw8J
 De7w==
X-Gm-Message-State: AFq9FYJiHKrfru5KMbsdtsyU/RT/MNfZf6KRgiBpVndRAHn3noRE7uh0
 wV/9V7nprmLuPrerhdJs5vh8rCs5Fal3o7pMSldIQ7Rr6t+degwXbmaNHP+bpMittkbySSrGwH5
 UsanDuOs3vGPZM7LsAvMK/novBg4crhNsQQicz8qBBgrdaxJp0amE9xNZZVn5xFysKR8f
X-Gm-Gg: AYBFou3WPaoR4kHnEcel1ZoZFJS7+pL6McUG0zJL+drMW3isNVVSVuZYoDiYm8PcIpy
 HcbJHUBqrz4hhy2BZ7fkCBKQfvl0YxqBbzJF0AW/mrOujpdQOCT3jIZnbQ+HShSsG52U1XR2h2O
 SXyvWs0v7ugaHp8vegW99C1v2RPycKIUEUNJxUcI9d+J0RMdyvJPGXOETbdwuC22rNTaMgb/6Ia
 MqHgaGCKWSLnA5Q2cjjPFxXeG5aYeo/c/PKE1+5rrJR7Yx1DN5Uz/FVqyN4aq/GBMOzeGk/D+Bs
 0zjYC9IODl4E2kdYlJUZRkL/Z2OdoAdRawW6VqZhe43BXAdNRXNlNPB2QAd2mDvteeyeD+6HhGA
 8TeHr3GS8VWTE8mmSIVo9vMZAkPpljEPBfyFgi5iaYumWDm+T3Ol7swXAh7eagIKri0AN17p531
 P1fOaf4D2eG+qBHeZ0hcHB7TVnOGd1UQ==
X-Received: by 2002:a05:6102:5348:b0:7a7:1db6:c769 with SMTP id
 ada2fe7eead31-7d03a5aee1emr2542717137.22.1793286839069; 
 Thu, 29 Oct 2026 08:13:59 -0700 (PDT)
X-Received: by 2002:a05:6102:5348:b0:7a7:1db6:c769 with SMTP id
 ada2fe7eead31-7d03a5aee1emr2542707137.22.1793286838602; 
 Thu, 29 Oct 2026 08:13:58 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a930c5c1a8sm55554985e9.1.2026.10.29.08.13.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:13:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 4/6] target/mips: Convert MSA LD/ST.W (Word Vector)
Date: Thu, 29 Oct 2026 16:13:14 +0100
Message-ID: <20261029151317.19170-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfXxVb3CYka6TvI
 1vsL0qntKIMnnAWoUeEEPMIdhwnrMWt8a3v5eTkZDoL3kZQ5EEmDDBNiOFLbnbCodIXTszUXjVh
 9BFe8+P6gJMK7ZhcmJ4ZeC0EUqZzcq8=
X-Proofpoint-ORIG-GUID: Bx7UyUe8CHLKfEMg-OUOTp1Q9kEqawPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX8D/GJXgjOx16
 SBA/mn7eU0csnbz1LwI5Q6Y+FOep2+54NkhmTbLffsegyNBlDnmgQlOHg2CxOVBif6QvjpQWnRo
 DH0GE9cqIxGbVqry/wz30w11WCCYuHGPC1MHTemfuO4zKW1BE8JS4UkBEbHzD/ZFbEKp5V+Jl3f
 IK+avArq/LjaQCob+2GsvSpzO2DyMQS3B/36aSxsTHOm9wuiXHU/CPKtWPmsbhbqE+BpW6/q6JS
 njisq4QMxfkPE6El4sw7+yIWoVZcGr2CaHyCWapyfw/MwPg7onH0CNzIYNfM3W5AAT+7wu4e890
 RY3SLwL/45gs1FJM4gniiwwS93m80OpVlDtKn99KJ5xC0sxetY4CZuAtuEexuYkuzPRolh2zA0b
 An497RKkMYvasA21Tbc6tfOPuSmkJk/DKWV1ha+5YPXNkLxCELT8o74trJsDZ4BtVpCGUYPNRn5
 to8EBLOPtnHs/iTd3Rw==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae362b8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=u8Rp_kE_ITEjY69SfUQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Bx7UyUe8CHLKfEMg-OUOTp1Q9kEqawPr
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 47 --------------------------------
 target/mips/tcg/msa_translate.c  | 20 ++++++++++----
 3 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 86a79bf804ce..f0d31ceef291 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -436,6 +436,5 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 #define MSALDST_PROTO(type)                         \
 DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(w)
 MSALDST_PROTO(d)
 #undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 08c900785f9e..afd9cca09604 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8226,32 +8226,6 @@ void HELPER(msa_ffint_u_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-static inline uint64_t bswap32x2(uint64_t x)
-{
-    return ror64(bswap64(x), 32);
-}
-
-void HELPER(msa_ld_w)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /*
-     * Load 8 bytes at a time.  Use little-endian load, then for
-     * big-endian target, we must then bswap the two words.
-     */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap32x2(d0);
-        d1 = bswap32x2(d1);
-    }
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 void HELPER(msa_ld_d)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
@@ -8288,27 +8262,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void HELPER(msa_st_w)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  See helper_msa_ld_w. */
-    d0 = pwd->d[0];
-    d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap32x2(d0);
-        d1 = bswap32x2(d1);
-    }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
-}
-
 void HELPER(msa_st_d)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 0c6c2f4551dc..7a3c2390cfca 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -770,11 +770,21 @@ static void gen_bswap16x4_i64(TCGv_i64 dst, TCGv_i64 src)
     tcg_gen_or_i64(dst, t0, t1);        /* dst = badcfebg */
 }
 
+/*
+ * Byte pattern: abcd.efgh -> dcba.hgfe
+ */
+static void gen_bswap32x2_i64(TCGv_i64 dst, TCGv_i64 src)
+{
+    tcg_gen_bswap64_i64(dst, src);
+    tcg_gen_rotri_i64(dst, dst, 32);
+}
+
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
     static const MemOp mo_atom_df[4] = {
         MO_ATOM_NONE,
         MO_ATOM_SUBALIGN, /* Slightly stronger than required */
+        MO_ATOM_SUBALIGN, /* Slightly stronger than required */
     };
     TCGv_i32 wd;
     TCGv_i128 t16;
@@ -795,18 +805,12 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 
     if (is_load) {
         switch (a->df) {
-        case 2:
-            gen_helper_msa_ld_w(tcg_env, wd, addr);
-            return true;
         case 3:
             gen_helper_msa_ld_d(tcg_env, wd, addr);
             return true;
         }
     } else {
         switch (a->df) {
-        case 2:
-            gen_helper_msa_st_w(tcg_env, wd, addr);
-            return true;
         case 3:
             gen_helper_msa_st_d(tcg_env, wd, addr);
             return true;
@@ -839,6 +843,10 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
             gen_bswap16x4_i64(d0, d0);
             gen_bswap16x4_i64(d1, d1);
             break;
+        case 2:
+            gen_bswap32x2_i64(d0, d0);
+            gen_bswap32x2_i64(d1, d1);
+            break;
         }
     }
 
-- 
2.55.0


