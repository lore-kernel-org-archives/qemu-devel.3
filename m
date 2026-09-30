Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2ACA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBovE-0001DP-5Z; Wed, 30 Sep 2026 03:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBovC-0001D8-Lw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:40:10 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBovA-00044f-2J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:40:10 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-34b48100af4so1232337eec.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790754006; x=1791358806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gXWytQPSY63O+H3Zo7OGSmhs7ShNPj29uTpiJdgR7J8=;
 b=KoO1ZkeHN4LAo8id1s+OAq257rZlt+Gg108KZAe8GiF7fp5f7Pk4TnVEBsIa80SVJ6
 3pqrm3iB3T75o6Oya01uiNqbtc/vt8V5+FUr2oAOvJhQAf2/DOaOVQbPpl0u9vDRPNlq
 65OehWPAJDYvTr7sZCcVfBlAFLDUjwu+1Qsv6gtGbw0wiB7JlOvPYpYhDRLAM65W4w/e
 cYh8vbodKVl1ftZkxgh3r4qr9Sa4oGXHdsRMuq0CwQmMQclzTTZ2MoRIrEak5CxXYnGW
 iCwTdtnAl8+PEPh8slU0Ua9GSTCAmTCrgf+MYQ3GCreBJjm4njR+xPU9qZcb2+HCKgYJ
 xEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754006; x=1791358806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gXWytQPSY63O+H3Zo7OGSmhs7ShNPj29uTpiJdgR7J8=;
 b=VH9wI5IYBSowEoAQQtcNTh89ADOZ1uS1/DQlYB/Ny7AWrUp1vHUYlfh0EgESBEPYs8
 +/D2mODNZ8vPEYh2aDWPXeAUIGBaSc+hL8yOQFBWsHNPwzaK5taeMptv+UKx4gkduSv8
 PRCqFuA27mo4+Bhx6pMS0tqoAEU26Roz9eBRbnc1E9KGOAaCHEwuyODw7gEz8h9YIP2G
 lD+4dlplBlp+y/aXpJlJqYDK8vVDecY6b2ejZ/b6hYmbmh1jWv/AwbgsOurk3YUOtlNn
 3jfKtpqBkGDPoCeMw4wIJismQiIDtLyvKCgIW5K5o3t+6FSV1ZDb2MsVZFUV7WNm6aZc
 5eCg==
X-Gm-Message-State: AFq9FYJEIOBdmwPBLUSTAUdlvEmVXzeeov0urUD9SBxSihl9MLrlipTg
 BqwJTCdsnR4snRwsSIQDX5Fz62dDfDjeMJe7sXYUPNE+u39yGmm4HWcAs9QKI5GT
X-Gm-Gg: AYBFou1hHl+QhM+CFzJY62xTCG0L03snQeC5vfNrdHHlvUNdsqj3z7sao6CntK77JLt
 XlnXNjjqEFcl+T5Diw7Jm0Lul2dTs8VAXFUhPTEwo6205eqVe4aPov7hP3Lm+Mqj3ySUOrJXwT/
 I+gHm+DC7ifSuEUeqy6gQ+TTaY4F8A22Ui3kCKRi1O/VJaIPblB/f3jU8ITdpqiAjIFFQBDA1Z8
 8g+mRe/wW36oNl5RtrYG3ZZ4aIQHRyJvQGkf4gIdfGfmTIfD77BL17SSR4jJk6MY8m9zH9UTLXU
 dKpMFaVOQItSRf5NzGnvgea4hMW5f9QK4vyMy7o5pe2qyKGew/tNCRwR2QEA0mANuErWveGW/b5
 DgMSQZWeJk51lLfFeAQWf9P924HkuLTQcU4Xsd4YIJzM1HCqB2/3BmBGApCyVNeksXJvqTw7cbK
 SZ7qTA8VT1Vr9FhKq5Z2ecpBDsGayB6SGHp0w+v43zs71bS3rOpRZHNV7yEZZNvowQy+nXGv5Mt
 mdqQIDkvMCOQqMp/w==
X-Received: by 2002:a05:693c:864e:10b0:347:8d01:164f with SMTP id
 5a478bee46e88-34cdbadaa6cmr1001593eec.19.1790754006225; 
 Wed, 30 Sep 2026 00:40:06 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf5b4349bsm1825773eec.25.2026.09.30.00.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:40:05 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 4/6] tcg: namespace target helper symbols for combined
 builds
Date: Wed, 30 Sep 2026 15:39:31 +0800
Message-ID: <20260930073935.712-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260930073935.712-1-luoyonggang@gmail.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use target-specific assembler names and helper metadata for TCG helpers
when multiple targets share a binary. The generated prototype maps the
generic C helper name to a target-specific linker symbol, for example:

    helper_raise_exception
        __asm__("helper_i386_raise_exception")

This lets target helper definitions keep generic C names while avoiding
linker symbol collisions between targets.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/exec/helper-gen-common.h   | 26 ++++++++++++++++
 include/exec/helper-gen.h.inc      | 48 +++++++++++++++---------------
 include/exec/helper-head.h.inc     | 25 ++++++++++++++++
 include/exec/helper-info.c.inc     | 24 ++++++++++-----
 include/exec/helper-proto-common.h | 26 ++++++++++++++++
 include/exec/helper-proto.h.inc    | 18 ++++++-----
 meson.build                        |  6 +++-
 7 files changed, 132 insertions(+), 41 deletions(-)

diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 834590dc4e..c05edb5f3e 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -7,8 +7,34 @@
 #ifndef HELPER_GEN_COMMON_H
 #define HELPER_GEN_COMMON_H
 
+#undef HELPER_INFO
+#define HELPER_INFO(name) CORE_HELPER_INFO(name)
+
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/cpu-exec.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/ldst_common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/atomic_common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#undef HELPER_INFO
+#define HELPER_INFO(name) TARGET_HELPER_INFO(name)
+
 #endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index dabe138e20..95715bde1e 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -11,88 +11,88 @@
 #include "exec/helper-head.h.inc"
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_call0(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret));            \
+    tcg_gen_call0(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret));                  \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    tcg_gen_call1(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call1(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1));                                       \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    tcg_gen_call2(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call2(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    tcg_gen_call3(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call3(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-    tcg_gen_call4(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call4(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2),                         \
                   dh_arg(t3, 3), dh_arg(t4, 4));                        \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-    tcg_gen_call5(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call5(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5));                        \
 }
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-    tcg_gen_call6(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call6(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
 }
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-    tcg_gen_call7(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call7(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
                   dh_arg(t7, 7));                                       \
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 7dec5f5b06..61e106cd56 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -8,7 +8,32 @@
 
 #include "fpu/softfloat-types.h"
 
+#define TCG_TARGET_HELPER_INFO_I(prefix, name) helper_info_##prefix##_##name
+#define TCG_TARGET_HELPER_INFO(prefix, name) \
+    TCG_TARGET_HELPER_INFO_I(prefix, name)
+#define TCG_HELPER_STRINGIFY_I(value) #value
+#define TCG_HELPER_STRINGIFY(value) TCG_HELPER_STRINGIFY_I(value)
+
+#ifdef TCG_HELPER_PREFIX
+#define TARGET_HELPER_INFO(name) \
+    TCG_TARGET_HELPER_INFO(TCG_HELPER_PREFIX, name)
+#define TARGET_HELPER_ASM(name) \
+    __asm__("helper_" TCG_HELPER_STRINGIFY(TCG_HELPER_PREFIX) "_" #name)
+#else
+#define TARGET_HELPER_INFO(name) glue(helper_info_, name)
+#define TARGET_HELPER_ASM(name)
+#endif
+
+#define CORE_HELPER_INFO(name) glue(helper_info_, name)
+#define CORE_HELPER_ASM(name)
+
 #define HELPER(name) glue(helper_, name)
+#ifndef HELPER_INFO
+#define HELPER_INFO(name) TARGET_HELPER_INFO(name)
+#endif
+#ifndef HELPER_ASM
+#define HELPER_ASM(name) TARGET_HELPER_ASM(name)
+#endif
 
 /* Some types that make sense in C, but not for TCG.  */
 #define dh_alias_i32 i32
diff --git a/include/exec/helper-info.c.inc b/include/exec/helper-info.c.inc
index c551736d49..815546c818 100644
--- a/include/exec/helper-info.c.inc
+++ b/include/exec/helper-info.c.inc
@@ -16,21 +16,24 @@
 #define str(s) #s
 
 #define DEF_HELPER_FLAGS_0(NAME, FLAGS, RET)                            \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0)                                 \
     };
 
 #define DEF_HELPER_FLAGS_1(NAME, FLAGS, RET, T1)                        \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
     };
 
 #define DEF_HELPER_FLAGS_2(NAME, FLAGS, RET, T1, T2)                    \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -38,7 +41,8 @@
     };
 
 #define DEF_HELPER_FLAGS_3(NAME, FLAGS, RET, T1, T2, T3)                \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -46,7 +50,8 @@
     };
 
 #define DEF_HELPER_FLAGS_4(NAME, FLAGS, RET, T1, T2, T3, T4)            \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -55,7 +60,8 @@
     };
 
 #define DEF_HELPER_FLAGS_5(NAME, FLAGS, RET, T1, T2, T3, T4, T5)        \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -64,7 +70,8 @@
     };
 
 #define DEF_HELPER_FLAGS_6(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6)    \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -74,7 +81,8 @@
     };
 
 #define DEF_HELPER_FLAGS_7(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6, T7) \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) =                                   \
+    {                                                                   \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 76e6c25bec..01a0be10c6 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -9,10 +9,36 @@
 
 #include "qemu/atomic128.h"  /* for HAVE_CMPXCHG128 */
 
+#undef HELPER_ASM
+#define HELPER_ASM(name) CORE_HELPER_ASM(name)
+
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/cpu-exec.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/ldst_common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/atomic_common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#undef HELPER_ASM
+#define HELPER_ASM(name) TARGET_HELPER_ASM(name)
+
 #include "accel/tcg/getpc.h"
 
 #endif /* HELPER_PROTO_COMMON_H */
diff --git a/include/exec/helper-proto.h.inc b/include/exec/helper-proto.h.inc
index f8e57e43ce..b7e3b10ed7 100644
--- a/include/exec/helper-proto.h.inc
+++ b/include/exec/helper-proto.h.inc
@@ -21,35 +21,37 @@
 #define DEF_HELPER_ATTR  __attribute__((noinline))
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret) \
-dh_ctype(ret) HELPER(name) (void) DEF_HELPER_ATTR;
+dh_ctype(ret) HELPER(name) (void) HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1)) DEF_HELPER_ATTR;
+dh_ctype(ret) HELPER(name) (dh_ctype(t1)) HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2)) DEF_HELPER_ATTR;
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2)) \
+    HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3) \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), \
-                            dh_ctype(t3)) DEF_HELPER_ATTR;
+                            dh_ctype(t3)) HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4) \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
-                            dh_ctype(t4)) DEF_HELPER_ATTR;
+                            dh_ctype(t4)) HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5) \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
-                            dh_ctype(t4), dh_ctype(t5)) DEF_HELPER_ATTR;
+                            dh_ctype(t4), dh_ctype(t5)) \
+    HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6) \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5), \
-                            dh_ctype(t6)) DEF_HELPER_ATTR;
+                            dh_ctype(t6)) HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7) \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5), dh_ctype(t6), \
-                            dh_ctype(t7)) DEF_HELPER_ATTR;
+                            dh_ctype(t7)) HELPER_ASM(name) DEF_HELPER_ATTR;
 
 #define IN_HELPER_PROTO
 
diff --git a/meson.build b/meson.build
index cae1591cd2..3cadf5b215 100644
--- a/meson.build
+++ b/meson.build
@@ -4161,7 +4161,10 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
 
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
-  target_c_args = ['-DCPU_DEFS_H']
+  target_c_args = [
+    '-DCPU_DEFS_H',
+    '-DTCG_HELPER_PREFIX=' + target_base_arch.to_lower()
+  ]
   target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
   if target_base_arch in target_common_arch
@@ -4277,6 +4280,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
+            '-DTCG_HELPER_PREFIX=' + target_base_arch.to_lower()
   ]
   link_args = emulator_link_args
 
-- 
2.55.0.windows.3


