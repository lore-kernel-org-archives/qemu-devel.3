Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1D4D3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3y2-0000pd-5f; Tue, 09 Dec 2025 15:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3y0-0000p7-Tk
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:05:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3xz-0001HP-8b
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:05:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so40727055e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310745; x=1765915545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SfmQi/8MCkxDKQ5GKF/OmaXAKzuZuaBcOR9eCv28OlM=;
 b=WdYY7noOp148pdotcHb7rS4YZEVLMiAqMzWjM6RSrSseoI6TRKX3ityPkmZqn4mPf5
 fZtsVgEQX+IXoXaOARA1fFFJ5McQyJ8rFjrdHLqK2prknvjEGPwY0kzwJKETdm+O6Fyn
 WGIGQgfRFHwXuTdn52eo8TsDFBdTewWxAGUp8YWHvnHHVqGeb6JbOOb7WNIoaLjIiAYv
 1iGjQCbNYHKzYAO4I3iYWXwAauD1qQCQ6iAPJ/7a7jO3T7AIzFDeEgSYxuwojsdhHR6F
 CB9rHGTiYJk82+mzjgMoU35ysOqoi1fjKeXQGa9skypA+YbkAiSsyxo2eiYGhMpKV1zf
 PTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310745; x=1765915545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SfmQi/8MCkxDKQ5GKF/OmaXAKzuZuaBcOR9eCv28OlM=;
 b=VeJSHE8bsQ8lcxN7OtWhu+MR017caLxQeNKBbrY9065Cv3YDOThtKeH7BouO/gZeeL
 /xGnqcBJ5dBMHQ+f2vRv3ya86xfHmLo4w5yIiSh7MtOPbmTzVnLwy20Ls91CXbB43Qos
 xhATk2550y83H6Ba6WYSDa0aEb3qYSgQMZzwLmtTR02dzeAdqPZX68lg6iB/TWdRJIq1
 DlWN1E+wIGrjM5059R1IoqjeTAYdrOClI6Ivu/xv7XVblL9ejT+Rhfg+IR246y1TESu5
 sM8w+qB5rG7te3p8fcCknGrO5Abaiam5BYav3t8UXgWOuuyxCZcMgB0nUnbH2B6uZhtY
 kmYw==
X-Gm-Message-State: AOJu0Yx2B8TugxTupBXkgsH5jAg+c40CSsu59RzXaW+w0l8el5ODAWv2
 bnl7iy/WN7W13+LLKwlHnPfx84I2jdhT+VCKCax448EEHT5hmlPC2oFkj0KXbcmChlh0rcPTAbt
 IiEfHAMw=
X-Gm-Gg: ASbGnctVs2Dkt8CJy2JDFyeX/9t6AOD0sSeY0DMyTwG/a2283sIKJfQX2OEVEEA5uqv
 s5hGOw2ev3gsqeh7KvLpWRCQnx79lCFwsDW3Zngc4XqSV5SsGC2aIe65WF69xgDMY5wFo7Qar5X
 ZFgqJgHsgnEA5CKWxC9JvHWtIATn/UGPoZ8Fso16QcOk7+1lY/v2Is2CfZSQtEl7fiWJS+pMBEq
 jvDgy259OfCjxUJb7RVBDzlG5gQt/QHoIkUsSwAdIJxM7NDazfl1uWCEPVWg4VjvuUpagr9noP+
 b5L3vRjmv6JTVyHCnuJTyiVOqz5OCxEP3oGzzpnCenPmRtjExsj6k2higz4O3j6QMG9hIzUyh2J
 epqOgwK32LIX4EO8DYmAu3gMD8b3AkVDDuRPCwEpohvnfyMcCqhyANIyvxPSw/LPQJKwI1jHIrP
 xChVs3d9M7S2yRUb3IrO8xvgDQYwyEB31Dv4uhbCzcN3H/0WQB6vdv5bCdLFeD
X-Google-Smtp-Source: AGHT+IHdVsjHDCu5ydRC4r4w5ig0PJvy2F3souQCoX3QPMUYm+GtwZYSugWErt0VahtJL1mfaSOi2g==
X-Received: by 2002:a05:600c:528e:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-47a8379b9demr909685e9.31.1765310745312; 
 Tue, 09 Dec 2025 12:05:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d3319ccsm32599801f8f.34.2025.12.09.12.05.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:05:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] osdep: Undefine FSCALE definition to fix Solaris builds
Date: Tue,  9 Dec 2025 21:05:28 +0100
Message-ID: <20251209200537.84097-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Solaris defines FSCALE in <sys/param.h>:

  301 /*
  302  * Scale factor for scaled integers used to count
  303  * %cpu time and load averages.
  304  */
  305 #define FSHIFT  8               /* bits to right of fixed binary point */
  306 #define FSCALE  (1<<FSHIFT)

When emulating the SVE FSCALE instruction, we defines the same name
in decodetree format in target/arm/tcg/sve.decode:

  1129:FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm

This leads to a definition clash:

  In file included from ../target/arm/tcg/translate-sve.c:21:
  ../target/arm/tcg/translate.h:875:17: error: pasting "trans_" and "(" does not give a valid preprocessing token
    875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
        |                 ^~~~~~
  ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
   4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
        |     ^~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        | ^~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:12: error: expected declaration specifiers or '...' before numeric constant
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        |            ^~~~~~
  ../target/arm/tcg/translate.h:875:25: note: in definition of macro 'TRANS_FEAT'
    875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
        |                         ^~~~
  ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        | ^~~~~~~~~~
  ../target/arm/tcg/translate.h:875:47: error: pasting "arg_" and "(" does not give a valid preprocessing token
    875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
        |                                               ^~~~
  ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
   4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
        |     ^~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        | ^~~~~~~~~~
  In file included from ../target/arm/tcg/translate-sve.c:100:
  libqemu-aarch64-softmmu.a.p/decode-sve.c.inc:1227:13: warning: 'trans_FSCALE' used but never defined
   1227 | static bool trans_FSCALE(DisasContext *ctx, arg_FSCALE *a);
        |             ^~~~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4249:30: warning: 'sve_fscalbn_zpzz_fns' defined but not used [-Wunused-const-variable=]
   4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
        |                              ^~~~~~~~~~~
  ../target/arm/tcg/translate-sve.c:4201:42: note: in definition of macro 'DO_ZPZZ_FP'
   4201 |     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
        |                                          ^~~~

As a kludge, undefine it globally in <qemu/osdep.h>.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251203120315.62889-1-philmd@linaro.org>
---
 include/qemu/osdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cf8d7cf7e61..3cb45a14678 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -141,6 +141,12 @@ QEMU_EXTERN_C int daemon(int, int);
 #undef ELF_DATA
 #undef ELF_ARCH
 
+/*
+ * Avoid conflict with Solaris FSCALE definition from <sys/param.h> header,
+ * but we might as well do this unconditionally.
+ */
+#undef FSCALE
+
 #ifdef CONFIG_IOVEC
 #include <sys/uio.h>
 #endif
-- 
2.51.0


