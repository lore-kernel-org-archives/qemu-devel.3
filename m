Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B71E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1MF-0004ZM-3x; Mon, 02 Feb 2026 16:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1M4-0004Wc-EH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:08 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1M1-0007LC-5D
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:08 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-482f2599980so21161065e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067254; x=1770672054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/CYxwqlwyfwDhs0x6N9r7EkQHeNibWYl61Ma+6YfqBs=;
 b=FptRFeJeUkyE2jvhHWVaqiQXCfryjiEQcNaAOGrOJ0f7Z16DRbxrRKPdmbJ/f5Hi3A
 GEMHTYbqAUKcCpUgqG4W8xZy5zU2I/Z6Rc+7NOaoM+a1pxQGzW8SZagKRaBD/TwD60vy
 S22nSyYLgXMo2buP6TuPJNNEDLRAVbQl/QYhI0QvB8dmZv+a8FDHeEZoyh1Dy+fSn6eO
 0kjI5fyPbQgYzSBT3iSEvAQszxepGeAT2oDCiGBvvAlDZ/dyyx+uDUW1zCUwsd4Eoae1
 JQjhtnit7S/fPRf+Gj1e9M/hsWveuCS8W1SNdMW4GcMoqcTEPwoP5TIqgJJ5GuqWjzk5
 5KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067254; x=1770672054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/CYxwqlwyfwDhs0x6N9r7EkQHeNibWYl61Ma+6YfqBs=;
 b=CpuSDf2t4G+SgRIpfvtk+eSCSJvrcHuVob+5NZQ8nLbKhrwedXB0VOsTV0cH/XQfdq
 YrU++hfZQ/8RGZdnE1gb/FhbYoPymX3Y86Vstd5pHLc8q4wv30h+83xgTzrQbV4j9qKe
 /6NTXJhr7BXfEipyeyw6YbhU2RfMUnYQQqGURid7+TrDvW216HXhnPlbQhUmp6KHws3R
 fJmfTxbqX5VxZDI92ezQ2kZZwwZ02VOjguPtduoikqtj6qw3dx7sjCVaWC0ftixFYcdY
 7zt2RzB+o+QfDaVh1ypIZAWWt7TGweAdY+0IIMExVuhWakQhf5r+s7gGlGw6WvECxP+q
 4h6Q==
X-Gm-Message-State: AOJu0Ywg6iU0zpSDOXv56UauBAeLyk/vLOslWCPI/sFE2eRzO2QyCanW
 DETDgjMEwAgLHAmxVWw7YHJBjp9qsetGQdgnWhwVivwM9CAYuOtDYUi7fGZ4/yv6st4/718up8l
 M8JcZQo4=
X-Gm-Gg: AZuq6aJmvUBJUzqfVofNzbU1D82Hdqo7gwlsCf6R4Cn4CVkkG+WHijdFtpDU4xu5vv7
 aK3J6GJs61HP5s79pZ2YzZibx8iI019F0NSq0rR0cKOGTg7e5a4O64Po6Ke1j/eGAKjAEU5POPw
 kkk2TW6mANPcf2A8XRpUu/HaJDBu1zAJaY7FJP9MRgAlqNtMaGppdxH318MMhxR9lFSIkTk8D1+
 ChCqWde3U+Mcrj1GZLR6wsCXfe2F1y1WMrQfo5a6sfTKVnZotsiCtWGGv9ynEENjmixiJfVgnvI
 KcDr8T/w+7dwBWh0Ucp0LaODt1Me57Fc3VVbtKANZBEsf+qXiti4NGlA/k4UxlCZTqIl/QVF0Gx
 B0H7MI3fH1/YDe3yepMtH1z6VYOfAEJzKXb10JasxiaU9X1a5t9J/nAqpZVRrjRDp2tC/EN8V6E
 w8fMsdZPs1pnXOul3etm4jA+W3e48t1Ru1Ixu7Sc4vE09KaLaXsbbIRpmSpQA/
X-Received: by 2002:a05:600c:528f:b0:480:6fbc:695f with SMTP id
 5b1f17b1804b1-482db49702dmr165280325e9.32.1770067254301; 
 Mon, 02 Feb 2026 13:20:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm51925616f8f.15.2026.02.02.13.20.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:20:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] target/alpha: Replace legacy ld_phys() ->
 address_space_ld()
Date: Mon,  2 Feb 2026 22:20:08 +0100
Message-ID: <20260202212019.94205-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

Since we removed the last legacy uses of the legacy ldst_phys()
API, set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the legacy API to alpha binaries, avoiding further API uses
to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224160040.88612-7-philmd@linaro.org>
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


