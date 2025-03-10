Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CDCC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEQ-0002z5-FR; Mon, 10 Mar 2025 00:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEA-0002hP-Ut
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE9-0008BP-4G
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22398e09e39so65589495ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582736; x=1742187536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKLFWb+An2Ks9U+R2rK1VtO2Tw0/JUbGbAmdQc7IQwE=;
 b=JdiFIFNFGaRXaPCm8U5P8FdZpKmDB6O6YwU21ocPjsoaVLe0lq1/R4rxCoDY9Ephfm
 NJ1tnLk2zDSG592CXIBfXbup8YOL0RRq4zJEMrHzaGChWnaqyI7+0BiMHbDPdQK46bqq
 ZB7mnF+8WGf3zj0GiU8mC2CVw5NS+50HqrS8G65oFyh5P48K4sNZiRC+4EXVytz/6rrB
 dtI4cjaPOTgpk1WHHWlepIhydmduKHlzTiqACZ8ZBHvypuaiBejPXSoRdQMFrLSMKwxd
 pR4zYO95cwV76eW/VA54czC+YQQ0EBlb3ooPWiNJHiA9tABq487eGCEocBBroNVLpWHz
 p+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582736; x=1742187536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKLFWb+An2Ks9U+R2rK1VtO2Tw0/JUbGbAmdQc7IQwE=;
 b=SKjm0VeQN/w/25gWJGjmMxo7SaXs8tWu66Hwa/BLPTe3XuupG8bZpcKUbi81CKguIx
 GGzM9ExYPNYxYC9VFZfguNkYlbPpQ9iHFEmz7PpWuKngA8x1BPfnAnX6GeVMdo9MCzav
 8IKEMPCDqOQ/QhldotbmVqeZLYQU10o81hck8zt0z2cOUp5gRvlt9Zf7CymKa3tX49/n
 kA4WK/0pif27K7gBcpIAWGot3GXup8eN5EXhjCamXCA4Yx8x8V1lUQIg7EcCNjsEO2p0
 GlsCbs4ZGhxcBOpSC1zpjQ+VWYJ8MmefhwL+pPmESuU4lUn/4RXmAtK96+wVS7Jcrk1L
 KrcQ==
X-Gm-Message-State: AOJu0YxU/FnTr1dH3NhP9H403jl54z+gBWFyIuOZ9ivf3xDEJTceRDsr
 uW28Utraqhybw17IytbR9ILYokSzxhIMMke8n6g9jlP1Fv3x5z6kTZyLm2pxV4HFQhfHxwbfxOa
 KpuY=
X-Gm-Gg: ASbGnctAqdD/pbQAl43aVUQMIJnBtpKHsS5Jgx3Qi8g5Ww7BNKukjblOqSi75G39X0U
 cq2RNDRFaFGSHs+Sv2upbWHxoVWCnGyz12OoXpyrcbPsnmXf2z+yinQSRj89nP5HcAx2QhW5vpe
 YGjGAdcoVDvMLI2feSoDvIjJIKANsJMPzBL7ZdmvT/djxSV/xcjmfoZ0dX2UscBo3ceraCyBACi
 MJLssTaPGaojabEYkdcNqOO3TT4oeal5m00tdCnZeUTD1BoNya+2YhXGm+0kgS4XAUuVTEtbJoS
 totUSqY7xfYFklwhE76ieFnM2nPnvP6IOXBu2hu/GgOP
X-Google-Smtp-Source: AGHT+IEAovvlOy2ME9s2bcowigrmpQEpYOhHLOJWN1HotCTdKvUP3vKFXajlsE4wLKble7VBohAKKQ==
X-Received: by 2002:a05:6a00:4fc6:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-736aab17045mr17832470b3a.23.1741582735793; 
 Sun, 09 Mar 2025 21:58:55 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
Date: Sun,  9 Mar 2025 21:58:31 -0700
Message-Id: <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

For now, they are duplicate of the same macros in cpu-all.h that we
eliminate in next commit.

Keep code readable by not defining them with macros, but simply their
implementation.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/bswap.h | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index ebf6f9e5f5c..46ec62f716d 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -442,6 +442,76 @@ DO_STN_LDN_P(be)
 
 #undef DO_STN_LDN_P
 
+/* Return ld{word}_{le,be}_p following target endianness. */
+#define LOAD_IMPL(word, args...)                    \
+do {                                                \
+    if (target_words_bigendian()) {                 \
+        return glue(glue(ld, word), _be_p)(args);   \
+    } else {                                        \
+        return glue(glue(ld, word), _le_p)(args);   \
+    }                                               \
+} while (0)
+
+static inline int lduw_p(const void *ptr)
+{
+    LOAD_IMPL(uw, ptr);
+}
+
+static inline int ldsw_p(const void *ptr)
+{
+    LOAD_IMPL(sw, ptr);
+}
+
+static inline int ldl_p(const void *ptr)
+{
+    LOAD_IMPL(l, ptr);
+}
+
+static inline uint64_t ldq_p(const void *ptr)
+{
+    LOAD_IMPL(q, ptr);
+}
+
+static inline uint64_t ldn_p(const void *ptr, int sz)
+{
+    LOAD_IMPL(n, ptr, sz);
+}
+
+#undef LOAD_IMPL
+
+/* Call st{word}_{le,be}_p following target endianness. */
+#define STORE_IMPL(word, args...)           \
+do {                                        \
+    if (target_words_bigendian()) {         \
+        glue(glue(st, word), _be_p)(args);  \
+    } else {                                \
+        glue(glue(st, word), _le_p)(args);  \
+    }                                       \
+} while (0)
+
+
+static inline void stw_p(void *ptr, uint16_t v)
+{
+    STORE_IMPL(w, ptr, v);
+}
+
+static inline void stl_p(void *ptr, uint32_t v)
+{
+    STORE_IMPL(l, ptr, v);
+}
+
+static inline void stq_p(void *ptr, uint64_t v)
+{
+    STORE_IMPL(q, ptr, v);
+}
+
+static inline void stn_p(void *ptr, int sz, uint64_t v)
+{
+    STORE_IMPL(n, ptr, sz, v);
+}
+
+#undef STORE_IMPL
+
 #undef le_bswap
 #undef be_bswap
 #undef le_bswaps
-- 
2.39.5


