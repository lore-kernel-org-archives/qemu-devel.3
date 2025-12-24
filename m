Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F421E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ7-0006kS-3R; Wed, 24 Dec 2025 11:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRJ0-0006eY-EB
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:44 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIu-0006Ru-9b
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:41 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b7277324054so978763766b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592093; x=1767196893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTI6luMu/GoW8moMtBb4PmT7PmqiDrNPT7xR87KpTns=;
 b=rqoYZ7SlaETRQSof+G6LGyc4u7dUGhDAxOq0bl/IeUYCl8/Jdm1Ui33wWMO1PoZp6K
 FcBOWfbtexmmVsnp8FZuQOAQ0Gq31Fukb5trtcveuDTfPgeoAQFEi8RucJxWUdBmZsd/
 r2Hx5EtG6waiVOS0VrdEL8dZVn6JnBcEWr+fj9WpPqqOdhOdGKEAeVgOKoburc+V962N
 m1MFRmXgryHgemD5eg6IA6JkP10VBv0NOOIa0bSi4P8Mpl5Fx4N9N4NTInroN+ZtDQEo
 8/f4Jv+l8IbDI2I0EsGkq9aOLF2BgEJpAgnaBF4zdrsCrwFmk12wT57X5IhTSSZ1wYT1
 56+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592093; x=1767196893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DTI6luMu/GoW8moMtBb4PmT7PmqiDrNPT7xR87KpTns=;
 b=H1tPqIuH7Tqsh8QobtopfZQim4cFD/jWXX90r4i3Z7fvZHVrQsU8aeBkQ7QGARunSq
 DhhZExwQIDGJE5Jpp8xAmKASAdApRiNEjYCExRy8phAwhd8Q/Dj0/j7TrcLuRTjbTbLs
 2OHYjfuM1e+PMAg/46xKIi9h9RInhtNoT/X0IMfIODpOHk4MwF94KZ0/Klmf4ykNKt3c
 bMYP17epb8REtB6hsd13rHgq5SvtKs2j2QZq6bqm4teZC8jg4f94QlRCOw9FNWQXRPvb
 yv/x7LmR2pOhSZeoRyuvHBy4ayNOAuXOvjxoYBbBIUcNgeJruPYngF66mRTsqU/6FxwU
 xVEw==
X-Gm-Message-State: AOJu0YyKW3sYPbQ+vcb3NAFso3lakHIGjR//nRb2Wj8X3HE7z6WQGaCe
 3kmEYf4BELu5fc9EvvMUskrHEONbNPUlpoISm1mdFB2x1yWtAZA18seS8pc4jEyMeI54KM6SCev
 by7PC4W4=
X-Gm-Gg: AY/fxX6GlsCOuJanGvUcPyPj/Gl2ot2ntUsk5dDUL5VpmYZdNl3tnVznX/KVwcSvPXl
 nI7oR/urcElW29ZdbRAGlZsWkdlzjj2E7v2Zgy7Lt61MZsPP/EYz5OBL1PqH3UHLZXbYWKcwpEY
 x4CdT35M9SDVsqLFdE42+/O3Fk+7nYOYsWWeDazsuwz6psqyMf94fqeAsbWwvieFK3g4Zczbv+T
 LcIjrIJu9pyPu/yLVBkkdBED7S4UbwsLG/21u49WPjhdQZ5mTIAT7WkHOgE0+l2hFS9ivmTjVb9
 weIdulOkmA5LTUKKtKleNgOe7Czo/BSCddl95yMdqX8MZFmJ3HKrZf9OOSA5oNZ6tC9jV/iK1Sm
 BS7bb1SDS7bUaiEdmRf/0FvpHgRX4CDAjOy/hd1ZwxUi0eeUa5Ki6puGoKDFBagdUkfGWJJv04M
 5ULDbHpKZhxYX0xfhknqOzcJoIEMMaBhAFK5PPTkK/BYMsSbnj0SLtWK0=
X-Google-Smtp-Source: AGHT+IGSLzLhCvqEQm4B2ZOpM4WJ5t1Fze/9IEYqjvatj7Jtdr2wK6XAkqu6aRImnQ9U4d6Av+hsIw==
X-Received: by 2002:a17:907:3fa8:b0:b7a:1b3:5e52 with SMTP id
 a640c23a62f3a-b8036f60918mr1802560866b.17.1766592093275; 
 Wed, 24 Dec 2025 08:01:33 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8044f4acdbsm1651790466b.22.2025.12.24.08.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:01:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] target/alpha: Replace legacy ld_phys() ->
 address_space_ld()
Date: Wed, 24 Dec 2025 17:00:39 +0100
Message-ID: <20251224160040.88612-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
References: <20251224160040.88612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

Since we removed the last legacy uses of the legacy ldst_phys()
API, set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the legacy API to alpha binaries, avoiding further API uses
to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/alpha-linux-user.mak |  1 +
 configs/targets/alpha-softmmu.mak    |  1 +
 target/alpha/helper.c                | 29 ++++++++++++++++------------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index ee505e16ef4..2f1312f0362 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 22fbbf0cb08..5c6af0eafc1 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 80542cb0665..126a53c829b 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -169,6 +169,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
                                 int prot_need, int mmu_idx,
                                 target_ulong *pphys, int *pprot)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
     target_long saddr = addr;
     target_ulong phys = 0;
@@ -176,6 +177,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
     target_ulong pt, index;
     int prot = 0;
     int ret = MM_K_ACV;
+    MemTxResult txres;
 
     /* Handle physical accesses.  */
     if (mmu_idx == MMU_PHYS_IDX) {
@@ -214,18 +216,13 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     pt = env->ptbr;
 
-    /*
-     * TODO: rather than using ldq_phys_le() to read the page table we should
-     * use address_space_ldq() so that we can handle the case when
-     * the page table read gives a bus fault, rather than ignoring it.
-     * For the existing code the zero data that ldq_phys_le will return for
-     * an access to invalid memory will result in our treating the page
-     * table as invalid, which may even be the right behaviour.
-     */
-
     /* L1 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
-    L1pte = ldq_phys_le(cs->as, pt + index * 8);
+    L1pte = address_space_ldq_le(cs->as, pt + index * 8, attrs, &txres);
+    if (txres != MEMTX_OK) {
+        /* bus fault */
+        goto exit;
+    }
 
     if (unlikely((L1pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -238,7 +235,11 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L2 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
-    L2pte = ldq_phys_le(cs->as, pt + index * 8);
+    L2pte = address_space_ldq_le(cs->as, pt + index * 8, attrs, &txres);
+    if (txres != MEMTX_OK) {
+        /* bus fault */
+        goto exit;
+    }
 
     if (unlikely((L2pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -251,7 +252,11 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L3 page table read.  */
     index = (addr >> TARGET_PAGE_BITS) & 0x3ff;
-    L3pte = ldq_phys_le(cs->as, pt + index * 8);
+    L3pte = address_space_ldq_le(cs->as, pt + index * 8, attrs, &txres);
+    if (txres != MEMTX_OK) {
+        /* bus fault */
+        goto exit;
+    }
 
     phys = L3pte >> 32 << TARGET_PAGE_BITS;
     if (unlikely((L3pte & PTE_VALID) == 0)) {
-- 
2.52.0


