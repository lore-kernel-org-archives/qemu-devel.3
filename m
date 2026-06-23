Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F730CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbyut-0007Lk-Bu; Tue, 23 Jun 2026 07:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbyu7-0006r9-7p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:02:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbyu3-0006BA-39
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:02:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NAsEQ23655471
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mt9hRNNgJk3i3fz5G9OTtCem7Hb8V5YHSbytsOw4E2c=; b=llxsYowWciF6bg1p
 0isXQgKIXHdev3o+jsELTOgXbOWEE/LEHy+gf3AEB1n/9O2INAVPgXcrwc4ceIav
 QEsS3K4mTzMK6LaxH1zrQXUGq4KhR5Eb5u/2WfoRZzQEGYxR1f2pcunQ4J+tamy6
 V/7qzJrB+Lm8bqHQ4MdexXLomwkvo4HEgmFcw83AHdq80LOEBD/9H8fG9VHoky/5
 ai8SMIEyPJo5ffTenIZTVd3wWL5TGYhHnoys9egTD0s+HdR+n9tMAOuhn55UmdtI
 Bst0XUK4hhLg8ebJ6gRPJ+AMmIr1FTx0ZlZcZSJuUtvH6gYnAF/MRdm5HnV1ta0m
 lsYnKw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eypx38kum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:02:49 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-48e77e6a63bso1577947b6e.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782212568; x=1782817368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mt9hRNNgJk3i3fz5G9OTtCem7Hb8V5YHSbytsOw4E2c=;
 b=VTcRHL9Vxd7JobhuUID2DVLo2gAiu6WNMftPN73p4H0Q59BcrD7MRgtScSEEy9jl/F
 TLF4Dxu+u9yKTw/8g4YdHwKSxW4zI9Uz4bLwGlfs3rquc2gfn3cJFETA+E26LxnovuL3
 BgCBYR0VWPMBBtUFGzUmOun5bmcpCRAzYCjOeKQKcEFXKH9YkkfCWC0KtHnau10jc6Bc
 Dol+ENDUSifCisBNdOGGQUh6gbQDoeDprfV1wRQlrPZ3GMDmE5ptn91gV2B5FOH3ZlNM
 w4H9Xq5/L0Mu1nfQkoDevNh+JygaRixEcd5EgJhMaLuBucWtJaO2yyR5gmcbaKXrlC1S
 OVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212568; x=1782817368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mt9hRNNgJk3i3fz5G9OTtCem7Hb8V5YHSbytsOw4E2c=;
 b=iSB763wUdOBpJJhV/xh4kUsQek76WACddfsjnUZTOn5fqcPx4qDp4CYQQMrYQDl9Z2
 aUNxbQnlhczLpdHrTDMcetHoz5+FLpB21fQwxy8Vy+c4TkuGrtMKVkVnslGTnXytpsr1
 c1PXL4c6znfWVDZJgZdVeCnP4PzRcXVQbjmEuTeEG32JbcrGiPmd1zEDbZluy719HHVV
 qXYfgSJUnRrcQ6MZYVN2Pyfd2QE04LPFIvotzA4ktmCA6lRURLJ7/PNphjnBqL5CnjWe
 Co1AAsV9qPFBqBLc5xNb67rVuoQjsCHnsbj88t9IIiIimNx2yVgPGmBLbe4d5d5mF5eX
 lwxw==
X-Gm-Message-State: AOJu0Yx06tf9bm9ill54njprivjkAQfX2pwh+aO5Mxi/7tMlnOGKANBa
 X3hm4xSvdOublUuCBkkl4Ztvm+qL1+52GKCN0xFUM03Fwy847bDUp8dQL80D0fJcaf/M+TGgJSo
 YcWMmVsKkTEEh6ZOrv2o42kGAZqKES76MS+H3jlALR8j2rkPHwGqwwQ76H35H2ccljmpb
X-Gm-Gg: AfdE7cna864L/z4Mjb5FzZ8shtN3/FWrwx1KfzgoRIZBY6yM7R8ifSwG1i/fv88fCJA
 4eMu1vgeJmd6Fe2mnVvof92uWTZwU+ucMPThK+BO8qkbnA6p3xyEC6rKG8l/6D2gNUFR8azo3A5
 Dfs3lMTykIDE8P51pc5bSITR4gNiE5a+TsQL4JvXe4JvziDMBRFXJZxEueXOLVmLR/+TMdJIOh+
 3k+Z9R4rJpLP1k9Er8GQPNbNKpHGToNV8w7eYV9K4yw/XNeJtJ+okGLpQ+p0mOmr4u8E5MhiKgu
 WZDyh+ONGVfjLnXiKUTUZroLLkwnz9QU+eZdEkBYh/cHr3Lothr7rl6Hw6NoMa2zzxPdJRusQ7d
 kLuCCeHTvDmCDjgCmNW/BcLlTAdfijCvXp5z7MnQZKQuXfMyrCKCB/P6AtnrTJgt/WY93
X-Received: by 2002:a05:6808:318a:b0:485:50e:5899 with SMTP id
 5614622812f47-48ee2d407fdmr1892580b6e.2.1782212568464; 
 Tue, 23 Jun 2026 04:02:48 -0700 (PDT)
X-Received: by 2002:a05:6808:318a:b0:485:50e:5899 with SMTP id
 5614622812f47-48ee2d407fdmr1892556b6e.2.1782212568019; 
 Tue, 23 Jun 2026 04:02:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245a69f81sm345689225e9.1.2026.06.23.04.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jun 2026 04:02:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Song Gao <gaosong@loongson.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v2 4/4] target/tcg: Rename set_rounding_mode() helpers
Date: Tue, 23 Jun 2026 13:02:08 +0200
Message-ID: <20260623110209.26861-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623110209.26861-1-philmd@oss.qualcomm.com>
References: <20260623110209.26861-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EsfiaycA c=1 sm=1 tr=0 ts=6a3a67d9 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wXBZP43g33z9UTFG2cIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zGw07QRDVnChnhgS9C55hdhZ72ktm7pO
X-Proofpoint-GUID: zGw07QRDVnChnhgS9C55hdhZ72ktm7pO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfX3NLP45+BvpZL
 WtNBZzbx+2Fm8Q0HvPLhxSuY1udFh9pepMGAqNaXKlp7aFSLE1PgNWEnRdAm3kPF/x4y4Og88ce
 OKDd2Yq9o7bx2vDtl7z6/EHLAbSGiWw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfXzHMJHVfcVewK
 DV/w+jDbUt1Hm557ZcxoArMYalw5usLZLFWVM1a1X9gkLXhGwfDjfEQWJLpO6EMXeLTfrj5pYFl
 uW/1QJA5KuiXtLyY/OjcRkV2UXxxUDL8MSp9SLXJSO7GM16eht/GekRcJk0JEUNGNd86pOYMtM+
 Nk0GtCbForepcHbW1cJkz1/HFYqe8fN/IxipHbzW3+2gjk5DPRgzbYQWkJne24/6hY4YEaJrJ7d
 Jj0FSAx9/0kF4QjCUiNmJBC98pLvVHPdr2c1DUB7C6nDsWn67B/xRg7mFOVYSnQyHulvKox/KoH
 czpkDgIkqCuQsFU3IO7dgEJe3XA3Df/wBzaehrxbhxN8wMyeloY7sn60G/RNCa9drXqr8i7fnZl
 Tx6GucZhZrurSK2pq3j8E3fVs4BKzITVguec5m2LNj+T30hSMSgh/Z16uKPMbaDMh+jLGd2Wqqv
 jRv3pnT7xd38DVGVmVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to avoid symbol name clash when building
a single binary, rename TCG helpers prefixing with
the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/loongarch/tcg/helper.h                    | 2 +-
 target/riscv/helper.h                            | 2 +-
 target/loongarch/tcg/fpu_helper.c                | 2 +-
 target/riscv/fpu_helper.c                        | 2 +-
 target/riscv/translate.c                         | 2 +-
 target/loongarch/tcg/insn_trans/trans_fmov.c.inc | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 35b055eb3bc..154e70c0191 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -91,7 +91,7 @@ DEF_HELPER_2(ftint_w_d, i64, env, i64)
 DEF_HELPER_2(frint_s, i64, env, i64)
 DEF_HELPER_2(frint_d, i64, env, i64)
 
-DEF_HELPER_FLAGS_1(set_rounding_mode, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_1(loongarch_set_rounding_mode, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_1(rdtime_d, i64, env)
 
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 542b7c264fc..6f46e0d91d4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2,7 +2,7 @@
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
 /* Floating Point - rounding mode */
-DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_2(riscv_set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(set_rounding_mode_chkfrm, TCG_CALL_NO_WG, void, env, i32)
 
 /* Floating Point - fused */
diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index fc9c64c20a8..265f608cddd 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -878,7 +878,7 @@ uint64_t helper_ftint_w_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-void helper_set_rounding_mode(CPULoongArchState *env)
+void helper_loongarch_set_rounding_mode(CPULoongArchState *env)
 {
     set_float_rounding_mode(ieee_rm[(env->fcsr0 >> FCSR0_RM) & 0x3],
                             &env->fp_status);
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index db1475271b6..88261b223cc 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -66,7 +66,7 @@ void riscv_cpu_check_fflags(CPURISCVState *env,
                             FloatExceptionFlags pre_fflag) {}
 #endif
 
-void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
+void helper_riscv_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     FloatRoundMode softrm;
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9684dbe7528..d5c3366fd94 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -759,7 +759,7 @@ static void gen_set_rm(DisasContext *ctx, uint8_t rm)
 
     /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
     decode_save_opc(ctx, 0);
-    gen_helper_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
+    gen_helper_riscv_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
 }
 
 static void gen_set_rm_chkfrm(DisasContext *ctx, uint8_t rm)
diff --git a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
index 5cbd9d3f347..c4c4c2000f7 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
@@ -112,7 +112,7 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_movgr2fcsr *a)
      * Note that FCSR3 is exactly the rounding mode field.
      */
     if (mask & FCSR0_M3) {
-        gen_helper_set_rounding_mode(tcg_env);
+        gen_helper_loongarch_set_rounding_mode(tcg_env);
     }
     return true;
 }
-- 
2.53.0


