Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6317C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHkH-00036T-Si; Sat, 02 Mar 2024 00:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHkG-00036A-C6
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:12 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk0-0007bC-RV
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:12 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5d7f1f15bso813029b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356615; x=1709961415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Bai8EGD2AgPFui2ur0HGLEHWWRs2OB7r5bHW9xIRW0=;
 b=HWC4poqNhkBks3yxnV+z0Y2Cz3wzCbVsGrEPXGhK+aA9NLJf/84IBkIVsZFYxz9Y0q
 +agc4EmltMPeDJjOON95IvfuMbG7SoRhhvYwrjLGFrCjh/HoMwJTq+bCvCsDdaJrYcvo
 S/qOqaerZBn9fgfu50NXnGAR5pY1+HXi+nJCihpEsOazeyu106h+wKj4z564In/Kxsq9
 NhrY6uY3QqmIMTqI/b49NFvqgAI7nDi7kypQTeJT7PRKB+qbd7VWH8mFytBO9YG330/4
 /DlF4gW2ViIDzSYjgqcvcANfx9iCoJgIrgVagpumMzZXMqbnEFBGR9ZTnYPTUsBD7Cda
 xeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356615; x=1709961415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Bai8EGD2AgPFui2ur0HGLEHWWRs2OB7r5bHW9xIRW0=;
 b=EDLK2JBkE3TOqsGAytslxemIqgTca68VWXJxFKZfgPby1yIhkgRwakDQ631YgbXFel
 SN3tl6wDXXoD5dv1/6/mpVFrSI9s1taL2TVJf8aYfI0jTFSW/peRfURJ1WdFOPzIo/IJ
 44od5C2aEk38JErHZIXsPbMTtgJtckl5K6Lk+YiL86hQGZ5P8fQiHtqVScghsAW67zjy
 g5lsWXg4HqYcxXfKkHSr2tJlDS5DI3RycnY3fHHZwYOrtQLFF9BjMFeqPO+bC92zG/q9
 YShWXSXGTmj9wm84LNYVDPV4F08rvDJjPDBPcZRRiJeaqrTgCXUND46XTJ3VkQfANS2r
 ddwQ==
X-Gm-Message-State: AOJu0Yz24geF8iExZ5eB13hc+J5kP5Sd4ywQdt5I1k/HkuL1vRO71vcb
 SRXp+ElzxsHCpH6jqfqdK1z4JQrZUYhfjbt4beEuW/RvrZ1uoDqIsgnRwYMIPgsa1SnB7ZdTuDj
 Q
X-Google-Smtp-Source: AGHT+IElptBOLvZWDZXU0izYq/eZpPo4S+mSZVn/GNtKmE38V9kNOvHFXeJ01kJ2rtn/iAcA8NZJPg==
X-Received: by 2002:a05:6a20:8f19:b0:1a1:4628:fd25 with SMTP id
 b25-20020a056a208f1900b001a14628fd25mr814841pzk.10.1709356615407; 
 Fri, 01 Mar 2024 21:16:55 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 32/41] target/sparc: Implement IMA extension
Date: Fri,  1 Mar 2024 19:15:52 -1000
Message-Id: <20240302051601.53649-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c           |  1 +
 target/sparc/cpu.c             |  3 +++
 target/sparc/translate.c       | 24 ++++++++++++++++++++++++
 target/sparc/cpu-feature.h.inc |  1 +
 target/sparc/insns.decode      |  3 +++
 5 files changed, 32 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 89ce0f3167..e4ee4750a2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -999,6 +999,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
     r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
+    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 07d252a35b..18dfd90845 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -553,6 +553,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS2] = "vis2",
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
     [CPU_FEATURE_BIT_VIS3] = "vis3",
+    [CPU_FEATURE_BIT_IMA] = "ima",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -879,6 +880,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_FMAF, false),
     DEFINE_PROP_BIT("vis3",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_VIS3, false),
+    DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_IMA, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f8db98c32f..56ee3927af 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -598,6 +598,26 @@ static void gen_op_umulxhi(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_mulu2_tl(discard, dst, src1, src2);
 }
 
+static void gen_op_fpmaddx(TCGv_i64 dst, TCGv_i64 src1,
+                           TCGv_i64 src2, TCGv_i64 src3)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t, src1, src2);
+    tcg_gen_add_i64(dst, src3, t);
+}
+
+static void gen_op_fpmaddxhi(TCGv_i64 dst, TCGv_i64 src1,
+                             TCGv_i64 src2, TCGv_i64 src3)
+{
+    TCGv_i64 l = tcg_temp_new_i64();
+    TCGv_i64 h = tcg_temp_new_i64();
+    TCGv_i64 z = tcg_constant_i64(0);
+
+    tcg_gen_mulu2_i64(l, h, src1, src2);
+    tcg_gen_add2_i64(l, dst, l, h, src3, z);
+}
+
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -2377,6 +2397,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_FMAF(C)    ((C)->def->features & CPU_FEATURE_FMAF)
 # define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
+# define avail_IMA(C)     ((C)->def->features & CPU_FEATURE_IMA)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
 # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
@@ -2392,6 +2413,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_FMAF(C)    false
 # define avail_GL(C)      false
 # define avail_HYPV(C)    false
+# define avail_IMA(C)     false
 # define avail_VIS1(C)    false
 # define avail_VIS2(C)    false
 # define avail_VIS3(C)    false
@@ -5194,6 +5216,8 @@ TRANS(FMADDd, FMAF, do_dddd, a, gen_op_fmaddd)
 TRANS(FMSUBd, FMAF, do_dddd, a, gen_op_fmsubd)
 TRANS(FNMSUBd, FMAF, do_dddd, a, gen_op_fnmsubd)
 TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
+TRANS(FPMADDX, IMA, do_dddd, a, gen_op_fpmaddx)
+TRANS(FPMADDXHI, IMA, do_dddd, a, gen_op_fpmaddxhi)
 
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index 3913fb4a54..e2e6de9144 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -14,3 +14,4 @@ FEATURE(POWERDOWN)
 FEATURE(CASA)
 FEATURE(FMAF)
 FEATURE(VIS3)
+FEATURE(IMA)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 54ba329440..56a82123a9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -525,6 +525,9 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FNMSUBd     10 ..... 110111 ..... ..... 1010 .....     @d_d_d_d
     FNMADDs     10 ..... 110111 ..... ..... 1101 .....     @r_r_r_r
     FNMADDd     10 ..... 110111 ..... ..... 1110 .....     @d_d_d_d
+
+    FPMADDX     10 ..... 110111 ..... ..... 0000 .....     @d_d_d_d
+    FPMADDXHI   10 ..... 110111 ..... ..... 0100 .....     @d_d_d_d
   ]
   NCP           10 ----- 110111 ----- --------- -----      # v8 CPop2
 }
-- 
2.34.1


