Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E199FD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifx-0004se-ER; Thu, 08 Jan 2026 00:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifp-0004jM-Ub
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:35:08 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifo-00062G-F2
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:35:05 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso21862105ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850503; x=1768455303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oweSE2rXvT6cBDGVwVx2qlRDFoW9DPuOJraIiqRFGOc=;
 b=rzSCfJiLMnRXI0nVSRaIDb1KYb6ArdwZorWFO/Eb0NPVa3JRVRtUsE4rUS4RbBJCiF
 53jTyoVXH0B4M29iT/gEHkKCj9rdGq3XM0OonyqjV0dz4GKIX3qgPAeZPuy6nxWqG6mn
 mD8ZjgIT7H//4km7koOu1d5aa1Z7gf2TrO8X9CEl+9jzB1YDsSc/P56j6P5gtXz/U5CC
 LZ4fzh3DwG3n7Q/RHnpeGIejxD5iV8I0VB2E0S9wXI9NJsrc9Nb8PFdgKeq4+8xjS4dq
 JOiWAYJWpKsG6OXttmge1cxHjGuXiJpNX2rDk6IunCVP0tpyjRs/WCLNegoml4gs3iZW
 JdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850503; x=1768455303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oweSE2rXvT6cBDGVwVx2qlRDFoW9DPuOJraIiqRFGOc=;
 b=UABfvm0x1zCGh96WTS/Pwet5G1Uk4EB0I5PUgGPCQYmok3oI2JOmTnEGbJDoUp38vb
 7Wqmf4bBeMk6d8q4rW++WqcYxzF7DyTgHSNY8PU738drY/Gsc3EYe/IZJ5LsybzXnVwg
 rROe2FfnRH8eJ8BXxKS2yYMB5Akw26efF3W0m2QK+mB3t23JivXVrQCke3uDt+PTf/e/
 pblPZtsq38x0BjCaD6kTOzQrs+Ar7yiWChFQWOP/bsFkW/HsBIkAGM3EUtqH006lfKkM
 K2VIaSp3WweYaTATEdirmuToNykR49mf65N+QIgacqYhGv4meyHRmVgl2wrpHKYXBkJb
 wyEQ==
X-Gm-Message-State: AOJu0YwsLtpCm5fM+k5YXBe9DB/5p9ItKD2QkgRKH8b+Jvedb3JhVJa8
 BYRffo6HIEROQIOabXR3QvoWRtZfWXAh3agDYGHTbChVxpmDYK2gXuNS/xCihkWy2P5gevHGHOm
 9dN+yldE=
X-Gm-Gg: AY/fxX79AFlM8JwhJBs05sy7x++iXlTptJlIdEnZvL8V5Rt98lP6rUy+4+R6qdTwGwu
 SfobQjwxolJ/ZiKKzY2iawNMTD2rXuLp6jVB6WboIWEm00csFsSt8G/bXbXVnDo6b+aCZQjQ7vn
 a3ohGwxrIcLuD8NFtEH3D7g2lJTZjhrijmF8gKYbQOlCfbQ5ZLmnRoLo+z6SjgpDFFZw1jD4BJU
 fPqhCYPW+4ZGPuEMoOrbBwu9QUV5TM1Ywr4981LyaAREvgkqSGW10CSjLiU86HNp4v0W2E3E2HK
 qdYFd61XI+e7flWY1z5XfAL6GkgEddPBOfx+TV2pkSDACbsxMhmQ6iGPODKXitzynabDOs1Yy5k
 8oWwE+dIdPnUpCaeAWrtEz9p7wyVreHWPcA2IDankfjGsvgjZKUX98HAeyVW7KY3wQM5lXOV7Ux
 X4XTUWwiQHzcNRLu0DNg==
X-Google-Smtp-Source: AGHT+IFaBxbolWsPdYzj+gSFLP+MPtKFDVzH4c8S8w3UTbRQvOqErMSyfOcW+xixRRnKL0pgRJADhQ==
X-Received: by 2002:a17:903:3545:b0:2a0:be7d:6501 with SMTP id
 d9443c01a7336-2a3ee45b7bamr41550345ad.27.1767850502791; 
 Wed, 07 Jan 2026 21:35:02 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.35.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:35:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/50] include/qemu/atomic: Drop aligned_{u}int64_t
Date: Thu,  8 Jan 2026 16:30:18 +1100
Message-ID: <20260108053018.626690-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

As we no longer support i386 as a host architecture,
this abstraction is no longer required.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h          |  4 ++--
 include/qemu/atomic.h                | 13 -------------
 include/system/cpu-timers-internal.h |  2 +-
 linux-user/hppa/cpu_loop.c           |  2 +-
 util/qsp.c                           |  4 ++--
 5 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index ae5203b439..f7924078f7 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -27,8 +27,8 @@
 # define SHIFT      4
 #elif DATA_SIZE == 8
 # define SUFFIX     q
-# define DATA_TYPE  aligned_uint64_t
-# define SDATA_TYPE aligned_int64_t
+# define DATA_TYPE  uint64_t
+# define SDATA_TYPE int64_t
 # define BSWAP      bswap64
 # define SHIFT      3
 #elif DATA_SIZE == 4
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 27d98014d4..dc9290084b 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -234,17 +234,4 @@
     _oldn;                                                              \
 })
 
-/*
- * Abstractions to access atomically (i.e. "once") i64/u64 variables.
- *
- * The i386 abi is odd in that by default members are only aligned to
- * 4 bytes, which means that 8-byte types can wind up mis-aligned.
- * Clang will then warn about this, and emit a call into libatomic.
- *
- * Use of these types in structures when they will be used with atomic
- * operations can avoid this.
- */
-typedef int64_t aligned_int64_t __attribute__((aligned(8)));
-typedef uint64_t aligned_uint64_t __attribute__((aligned(8)));
-
 #endif /* QEMU_ATOMIC_H */
diff --git a/include/system/cpu-timers-internal.h b/include/system/cpu-timers-internal.h
index 94bb7394c5..8c262ce139 100644
--- a/include/system/cpu-timers-internal.h
+++ b/include/system/cpu-timers-internal.h
@@ -47,7 +47,7 @@ typedef struct TimersState {
     int64_t last_delta;
 
     /* Compensate for varying guest execution speed.  */
-    aligned_int64_t qemu_icount_bias;
+    int64_t qemu_icount_bias;
 
     int64_t vm_clock_warp_start;
     int64_t cpu_clock_offset;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index e5c0f52d94..972e85c487 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -83,7 +83,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 uint64_t o64, n64, r64;
                 o64 = *(uint64_t *)g2h(cs, old);
                 n64 = *(uint64_t *)g2h(cs, new);
-                r64 = qatomic_cmpxchg((aligned_uint64_t *)g2h(cs, addr), o64, n64);
+                r64 = qatomic_cmpxchg((uint64_t *)g2h(cs, addr), o64, n64);
                 ret = r64 != o64;
             }
             break;
diff --git a/util/qsp.c b/util/qsp.c
index 382e4397e2..55477ae025 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -83,8 +83,8 @@ typedef struct QSPCallSite QSPCallSite;
 struct QSPEntry {
     void *thread_ptr;
     const QSPCallSite *callsite;
-    aligned_uint64_t n_acqs;
-    aligned_uint64_t ns;
+    uint64_t n_acqs;
+    uint64_t ns;
     unsigned int n_objs; /* count of coalesced objs; only used for reporting */
 };
 typedef struct QSPEntry QSPEntry;
-- 
2.43.0


