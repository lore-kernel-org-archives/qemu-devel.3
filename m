Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67D6CE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Sa-0004tH-Eb; Tue, 06 Jan 2026 10:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9SU-0004q2-Cx
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:59:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9SR-0006lK-Mf
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so8628595e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715134; x=1768319934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=algqxa9leaG3RbyZjAx1RsJr8ynE3Caj6OBqSK2e0YI=;
 b=U06MNXDwaR0So55MLg8e0JAHitOP6X2rMIYcN39M2FAWALOBL0XzvWJg3tnXxFUxDk
 dzx+PrQHfLeDOIfG96Vr6hFDIKP2qJUU0sve6kyapaKNo1HS3+dCsPwjD5ikQ3W7XJar
 Q45wPS0/OkARyhSkEfq1LRUXuOm3+xrG8P7NwEeFQj0R1K5HJVo71F81jdm/yrvM6LrE
 ie+uCdRwSK4jFtxU9MOi4BIBwTTZ8ynQuTBugZdaIrUQHrmABQtr18MI7gyspSzY7MsN
 zqpUl9NNpib7BbHY4v7n4tDqNHlXmahX6gLmMff3OpKXwJaKlXRnvTad3AuV9g9ytx0p
 swmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715134; x=1768319934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=algqxa9leaG3RbyZjAx1RsJr8ynE3Caj6OBqSK2e0YI=;
 b=OE29pFfVsIsz7ffdoCK4C1A30o8VlPU5/qcuJJbMYxizLX9qOzsGGp9PjdPG7kCoyU
 3NKRIeEHwbc4TgYqjzsEJGiPgbwZE2OE/hZtEkYQNFzBXr4X/4yZ09O413KDMWmxX70O
 iguHCCp20DXkIc9PDluNX/1RYE0dneLQxb6IGphVVmd1KVsPdX5bSu8Zi1Ad+TAxrKos
 nEDDpn5Ce4+G5O9W8tmjRa0QFBcQQflDV1dUBBr1mb+KYceFwAUUdCfURKtCD7GrXLOQ
 TPYRwY8J/l8mWs02QCs6+vfhL3q+uYQN24vPdLMDNeLDUwmdxFMg1MYAOkKUi2jdg1UX
 g57A==
X-Gm-Message-State: AOJu0YxJ4x+QWBLhEmnmBojHalBwcZC1vQ1aNuQ6dTq/GQxOkdqh/ApV
 zjtP15ig8dhoXLlQNADwp8vq4oFh7sWAi/NuRZRaAwl3bc8TzjOvI1DwD6ucpxHjpEAVN0SaiVK
 QfEWT/pQ=
X-Gm-Gg: AY/fxX5JRFPhCDOatGnWpuIofzU1lf/aZFrxklDn27oJNKVjKpI0iA5114RiTy4MPYy
 mFcy3qdaEL/dyuuoCx3tOsWRlwHMHk1JD9kkin1yKUyPnwVlwXqJpxtiybaKz2T53M2hds2SasO
 IiHEUyvw0bjMYaPLgnTcM7o4WWp10xrlwFhjJ6qLhgZZ0+DeSto/c81sI0m8i5++BO+/F8Fs87I
 qCIJ3Q6n3A4f4ox//VveGnvsl+/ywt2d31Ym/lyy43/ytRnThwlgB9ZuqM6pNwrixuf/U3OZIua
 L8VUnPgNBvUQARLXD0kIbYPnWJBnqwyIC0DhNjhGdNKme66sXV/FTPWLUiPqt1wiYe9RRW1v4aD
 eEZef8D4VexBjArGI80ofK7GgZ8B8cV9Ap3N3YPlWdHStBZtq2DKYmhUORz5CfYfcd5ZPcq7AkX
 9GLpKJYaobRSov7NAAm6A+vuJERmieAGvwqbR9pkfDE3ubh5IXe08X2X84w2EK
X-Google-Smtp-Source: AGHT+IEhL0jk9+1p/kjnE1cRg7NNF3HigWkiAapuOckZIaEvfnTVm0JjOYgCqr8ieIjoOpn3QRY8sA==
X-Received: by 2002:a05:600c:46ca:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-47d837edcccmr11162205e9.34.1767715133727; 
 Tue, 06 Jan 2026 07:58:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm48481035e9.15.2026.01.06.07.58.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/8] target/alpha: Replace legacy ld_phys() ->
 address_space_ld()
Date: Tue,  6 Jan 2026 16:57:54 +0100
Message-ID: <20260106155755.53646-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


