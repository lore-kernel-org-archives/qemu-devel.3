Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AA6C9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMTV-0006b0-Bn; Sat, 26 Sep 2026 03:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRD-00040a-KL
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:13 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRB-0000aw-GO
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:11 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-340fbf9c1c6so928524eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406188; x=1791010988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RDJx03fDpoFhoiEvP/bHkwDQkhcB3SmHYPY0Nad5xBI=;
 b=NYQAlbXxLLb/cYt/nym8bUB+srWKZ1OXtCF1BKs8aZPsotwqqWdWdLEE28HsHHTXf7
 /sTB4NDEeO0lXN0MfQPuL0EoMjZeU334ejlwKAfwTP73Pj+/zHgVD3tnNScbm8x4YoTs
 3FgS6lRVsuwFi8Ei27qUeXZBFkJEECFbkpsmBZrXGxmkjdB7wAmNR24T80EMEVUvtDtS
 Y4C1cadHERJvNHF/2TdZufqfs3+cH4JxxPyWP4sLjBoY6UYK/DpnghNOdFd4Sa+83qgt
 /QxVqaBTg6qrJZQbLASlGsQMcETwPmMAaXxAne7JBTas/9tu7TNyCFvvrr8z9jrsm+/S
 oG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406188; x=1791010988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RDJx03fDpoFhoiEvP/bHkwDQkhcB3SmHYPY0Nad5xBI=;
 b=qHhTvpuprYT5U3iDCWnmGQKvTM478LsmZ+bwP4ZAQQabFEQ5Va+DVA8zvueQOwQxM9
 a4fEiLMGIuK1qNMV+yPKK/NXgsr9Mm/XLk4NZOvzepdno3mPoGJ7lJ4bKvP70WZRA0Iu
 rJremzAjha4Idiwus/8axxZ5kp0Xxh4eDOjXvjKb03kn2xbm0cxnawBawWfYQZmXnNvF
 a6OkgshlwJaQy9eKX8EeQbdeCHdCjo9/CJz1lyXNCS+rUHNP85OjdJBKI+gpyq9qkl0/
 zWxhKyGYWG7OryligklZe4Q7oP/jvtGAQDie5bknKzsQ3A4DGLj66nIROqaqTwNKsNH+
 nDxA==
X-Gm-Message-State: AFuF++kpBHEVLoK0A4gAqPoKjuFPv3rwC2/SYzNUZXiEKte+aUPg/enL
 ulkCyWXaL2I5BE7MJJUcrAV7v5addNiANjdOVwLdC7cJnhJfOEv0SkuS3mOKgz7m
X-Gm-Gg: AYBFou0luiA4RlndE1//n1Qs9pI6IwBJANw4EGlxm++HZLvYhk7RYOVYBEiejg095zp
 DojCQuX2M5PSDt21t+cuzaZ1mKRNh+AL154ocW0VhPLnYs2lYA+Lg5hG7fIq+JsrLAWHe2bAK6G
 JpHJrjetOEE34TJEB5/nlFvmLRVVXScdW6a/BJKgOtpdeTnw8DQwIWXvJJ6ENLLenQrS9W/sq0a
 g8RLtKeRIWwXUYIoFuCyADYr3P00a2byYWPiewjTLsnSg94arD1x2LAS8kTSNZqqMnrbP1PaejD
 s4eTm6MgcqkPq3afK1oBdZGCkQKaFbJWUF1Zwapdk3eNdPFbroieObRQfQr56hUonojT6f92vXK
 TLovE2mFbLIU8eYARXRbN7SBxVkaE0oBtRwPzBykOk/8Ha/XpDHikJTPMsLacFeCV4jGryDeU7S
 rH9q0QF7jrruu/vKaysZJXHCivlt3uRZe92/f7fZndvS6AnTPz3paThjORDPnKgJiyip4eAZcjg
 DLZKAL3H9yq6n8M8txAXFgRfThRfGo=
X-Received: by 2002:a05:7301:4d0b:b0:341:4f3:8f84 with SMTP id
 5a478bee46e88-342707b3fb2mr2095737eec.13.1790406187813; 
 Sat, 26 Sep 2026 00:03:07 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 31/55] accel/tcg: move memory helpers out of tcg-runtime.h
Date: Sat, 26 Sep 2026 15:00:30 +0800
Message-ID: <20260926070057.1234-32-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
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

memset, ld_i128, and st_i128 are declared in ldst_common.h, and
ldst_common.c.inc emits their helper info. Atomic helpers move to
atomic_common.h, with info records emitted from atomic_common.c.inc.
tcg-runtime.h keeps the integer helpers implemented in tcg-runtime.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/atomic_common.c.inc                |  4 +
 accel/tcg/{tcg-runtime.h => atomic_common.h} | 36 ---------
 accel/tcg/ldst_common.c.inc                  |  4 +
 accel/tcg/ldst_common.h                      | 13 +++
 accel/tcg/tcg-runtime.h                      | 85 --------------------
 include/exec/helper-gen-common.h             |  8 ++
 include/exec/helper-proto-common.h           |  8 ++
 7 files changed, 37 insertions(+), 121 deletions(-)
 copy accel/tcg/{tcg-runtime.h => atomic_common.h} (65%)
 create mode 100644 accel/tcg/ldst_common.h

diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 7d779dd51db..a24250be75e 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -101,3 +101,7 @@ ATOMIC_HELPER(fetch_oro_le, Int128)
 
 #undef ATOMIC_HELPER
 #undef GEN_ATOMIC_HELPERS
+
+#define HELPER_H "accel/tcg/atomic_common.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/atomic_common.h
similarity index 65%
copy from accel/tcg/tcg-runtime.h
copy to accel/tcg/atomic_common.h
index 26e0baeca51..4fee73cf916 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/atomic_common.h
@@ -1,39 +1,3 @@
-DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(remu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-
-DEF_HELPER_FLAGS_2(div_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
-DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
-DEF_HELPER_FLAGS_2(clz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(ctz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(ctz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_1(clrsb_i32, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
-
-#ifndef IN_HELPER_PROTO
-/*
- * Pass calls to memset directly to libc, without a thunk in qemu.
- * Do not re-declare memset, especially since we fudge the type here;
- * we assume sizeof(void *) == sizeof(size_t), which is true for
- * all supported hosts.
- */
-#define helper_memset memset
-DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
-#endif /* IN_HELPER_PROTO */
-
-DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
-DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
-
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgw_be, TCG_CALL_NO_WG,
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 57f3e061924..bf74d65dd75 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -119,6 +119,10 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
     helper_st16_mmu(env, addr, val, oi, GETPC());
 }
 
+#define HELPER_H "accel/tcg/ldst_common.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /*
  * Load helpers for cpu_ldst.h
  */
diff --git a/accel/tcg/ldst_common.h b/accel/tcg/ldst_common.h
new file mode 100644
index 00000000000..cec4751ff16
--- /dev/null
+++ b/accel/tcg/ldst_common.h
@@ -0,0 +1,13 @@
+#ifndef IN_HELPER_PROTO
+/*
+ * Pass calls to memset directly to libc, without a thunk in qemu.
+ * Do not re-declare memset, especially since we fudge the type here;
+ * we assume sizeof(void *) == sizeof(size_t), which is true for
+ * all supported hosts.
+ */
+#define helper_memset memset
+DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
+#endif /* IN_HELPER_PROTO */
+
+DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
+DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 26e0baeca51..d635e6b708b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -19,88 +19,3 @@ DEF_HELPER_FLAGS_1(clrsb_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
-
-#ifndef IN_HELPER_PROTO
-/*
- * Pass calls to memset directly to libc, without a thunk in qemu.
- * Do not re-declare memset, especially since we fudge the type here;
- * we assume sizeof(void *) == sizeof(size_t), which is true for
- * all supported hosts.
- */
-#define helper_memset memset
-DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
-#endif /* IN_HELPER_PROTO */
-
-DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
-DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
-
-DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgw_be, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgw_le, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgl_be, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgl_le, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgq_be, TCG_CALL_NO_WG,
-                   i64, env, i64, i64, i64, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgq_le, TCG_CALL_NO_WG,
-                   i64, env, i64, i64, i64, i32)
-#if HAVE_CMPXCHG128
-DEF_HELPER_FLAGS_5(atomic_cmpxchgo_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgo_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_xchgo_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_xchgo_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_ando_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_ando_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_oro_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-#endif
-
-#define GEN_ATOMIC_HELPERS(NAME)                                  \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_le),           \
-                       TCG_CALL_NO_WG, i64, env, i64, i64, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_be),           \
-                       TCG_CALL_NO_WG, i64, env, i64, i64, i32)
-
-GEN_ATOMIC_HELPERS(fetch_add)
-GEN_ATOMIC_HELPERS(fetch_and)
-GEN_ATOMIC_HELPERS(fetch_or)
-GEN_ATOMIC_HELPERS(fetch_xor)
-GEN_ATOMIC_HELPERS(fetch_smin)
-GEN_ATOMIC_HELPERS(fetch_umin)
-GEN_ATOMIC_HELPERS(fetch_smax)
-GEN_ATOMIC_HELPERS(fetch_umax)
-
-GEN_ATOMIC_HELPERS(add_fetch)
-GEN_ATOMIC_HELPERS(and_fetch)
-GEN_ATOMIC_HELPERS(or_fetch)
-GEN_ATOMIC_HELPERS(xor_fetch)
-GEN_ATOMIC_HELPERS(smin_fetch)
-GEN_ATOMIC_HELPERS(umin_fetch)
-GEN_ATOMIC_HELPERS(smax_fetch)
-GEN_ATOMIC_HELPERS(umax_fetch)
-
-GEN_ATOMIC_HELPERS(xchg)
-
-#undef GEN_ATOMIC_HELPERS
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 73e979a35f3..5943a3aedf0 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -19,6 +19,14 @@
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
 #define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 3c32f95f4c1..eabe7828047 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -21,6 +21,14 @@
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
 #define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.52.0.windows.1


