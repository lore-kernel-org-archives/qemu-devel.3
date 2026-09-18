Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A4BC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mgu-0006nn-3w; Thu, 17 Sep 2026 20:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mgs-0006mJ-FO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:42:58 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mgp-0001Qa-9x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:42:58 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469e25400so153607b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692174; x=1790296974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUaeGkon9+ggQZ5TaEe6QdPSzXHYkdUl5uC7WqY6h6I=;
 b=YfnMlKIBOzUL06uL6z+FGEO4YdWrhk9gKwGjoGuVG7aLvl9aJJLOA/54wQ+4VP67/+
 DISfS35wBp2gJwDM/3xCK9oXf8wm/r18J4sEWucb4SW7hrWGQ9p1/OTjlFJobHMTsH5k
 PpQ1RFZO81GtIz5Eu5qECx/M8iSRIGYLNwbUq7+FZYFbiScSJKxU6bbInEkBUoPcEiWm
 BNneAUlWOfWnFydNBS6M5ccU7Oo7Ba+3Wjg2uP7Wn3ktatWbozkM0jtgkgs6aeuFDdVA
 oDrNE24Wva8DgEb5QdrXsWjeBIP/UmMba70y9Eya+c8ketjs0kxYxjpUuYcMuAww6WIh
 4AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692174; x=1790296974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUaeGkon9+ggQZ5TaEe6QdPSzXHYkdUl5uC7WqY6h6I=;
 b=mj6arb4Rd3aVAQgGwrBAjw2exrFr7yux9BFCiLNQaH/JCDPM/HTMHMfNwKWp99RDOn
 B2mJxNiipW996X9w3rYskH+zZuc6DlsbPyHY2+oJQpCLD6sjLuvsRnB7MVcjp0buH3B+
 PFFRmOUpO+w2ji0fIuzBJ6pVDRlZe7mkKpKhSioo9Yfzfbmm/refxC4LZ5n5M0Z7FAE1
 vXNT8idKVZ7HL+W8RwKDwrbKTO1X4o1psDUd+rI8iFhthETKiNROcinNke4kibBgbukK
 n9o1FkLuS8fBPYvBT7MRfiyqY3BwLsybjUZVMQwreKPzbJSfWGZNwMb6u8KfGAYDNRcT
 MR2A==
X-Gm-Message-State: AFuF++n9IrS3rrHVHBvfNsBTdNvOuHYUjsEMWVRu0flBdAo9czBydHkK
 4tJJpoXgJcm/KJZjcp3HUHi70L8sHxsG3IwmFg0kD0mZ91oiUjd0mM8eIPDK6R25qDw=
X-Gm-Gg: AYBFou2pl2YLw9SE/S5hVmfLgtER586Dz3+tvo65NEW0RYxLbcnaChuGAQustXyZGAq
 LYiKJ1/oGvgyEi4U3WKvUDSKyrXS3ew8IEY3e+kCaOaxEFr8e6h7WhAgioChUlnYQFZ8xtknYU6
 cuVnzXStM0FRqz/dthe7Na1fLdCMTAFK8gJEYmQObNGyhSiaB2uelHMvwJF1Uxcy1BU67sBVq5a
 Qk/EG9ECMNLA1nijF5siAlPkQheDD15zBw4E8jZyfxhEzvHCPHRIgLF1oZ8BG9elElMluAeR7Hl
 6g0L/xAokKqDpbuB723NURhVGQvW3te+05t3jYntmzB5pclr7i/HAsUPV8LnYhKhluWXP0PK+MN
 BncHkC17LqBReWK6F61dnxAZR3+zJwCL3mWT6T4Y9/75C8lCuwox+84CznsjRt3CLeYNrJOaAXI
 sueAFNQHmL3xsn/QcIPUSGyXYiBSErJtNhG08wDS4/endpyKScHIY/0SZKeb98CDJon8mIPI4s9
 Aa5cRymrXkUH5cvT+B6rxsmB56wr+0P
X-Received: by 2002:a05:6a20:7d8b:b0:3d3:b02a:61a5 with SMTP id
 adf61e73a8af0-3dd8c41a021mr1325778637.28.1789692173803; 
 Thu, 17 Sep 2026 17:42:53 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:42:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 02/21] helper-gen: move helper_info extern into gen_helper
Date: Fri, 18 Sep 2026 08:42:04 +0800
Message-ID: <20260918004225.827-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Declare helper_info inside each gen_helper_* body so a comment on
DEF_HELPER attaches to gen_helper_*, not helper_info_*. The extern
still refers to the global from helper-info.c.inc. Silence
-Wnested-externs around the HELPER_H expansion only.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/exec/helper-gen.h.inc | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index dabe138e205..1a4dc27d436 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -11,49 +11,49 @@
 #include "exec/helper-head.h.inc"
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call0(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret));            \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call1(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1));                                       \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call2(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call3(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call4(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2),                         \
@@ -61,11 +61,11 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call5(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
@@ -73,11 +73,11 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 }
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call6(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
@@ -85,12 +85,12 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 }
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
-extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
+    extern TCGHelperInfo glue(helper_info_, name);                      \
     tcg_gen_call7(glue(helper_info_,name).func,                         \
                   &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
@@ -98,7 +98,15 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
                   dh_arg(t7, 7));                                       \
 }
 
+/*
+ * helper_info_* is declared inside gen_helper_* so a comment on
+ * DEF_HELPER attaches to gen_helper_*, not helper_info_*. That is a
+ * nested extern; silence -Wnested-externs for this expansion only.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wnested-externs"
 #include HELPER_H
+#pragma GCC diagnostic pop
 
 #undef DEF_HELPER_FLAGS_0
 #undef DEF_HELPER_FLAGS_1
-- 
2.52.0.windows.1


