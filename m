Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB421E7FDF8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3d5-0005k4-Ue; Mon, 02 Feb 2026 18:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cs-0005fb-73
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cq-00053D-MI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so53259905e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075994; x=1770680794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0J0jFnaPHiF4Ff3I5uFyoQXMVpNttsXDCW8PKSS964=;
 b=PdEYfVbAU18nqe313dSR1Frk6lGA19pjR90Zdc1cy+gk/hZgdzCLvo0gIz5f1kvXOu
 XmA3i0azDafH/DJRXVqlX/rWKbxuhAI4NgrxWXLxacLHgkH+SSt1Y8coow3QCKlow6DF
 yz18seY4pLSPu3yEs+o09IZRNvoNLkcdJXhZiTue+QUUH8AbUHSziV/UktQdHCFcCdlB
 m92/REeF9t0HD7PisueZDQh694pKlDfGS7blxPCiLSzhHhKGVIiIih4q25q/WkwkY6Rd
 e+Q95AkhiP52Uc6ImPk6lglTjNu/doiE1/M9EoWxe2t6GFP82V6YbdqusJ4I/41xYq9f
 gVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075994; x=1770680794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q0J0jFnaPHiF4Ff3I5uFyoQXMVpNttsXDCW8PKSS964=;
 b=NSBBiGBiQwgH+Ptoc7jAXy3C4o3HcP1LhGC99T3zugSXJcGj2S/t9kf72XrSJ0ve90
 VuNySoQ2Y03i/i0lC00Zh02IogJ6bA5u+jtTN3xFSqN8HtGc0/2yDAUJZFZWaGpa3He3
 tLelycS7S65uweiBqTvdiJc+YEbKSGxw/dWfoYwGxy4evaggiCiS9uBSius31sRvJNYS
 sg9wOQJ8GZO1sMvoCLcMCNtiFkOv8O0duu+YJSlFnFETPd8HRnRAZZOfzbnnlAVbqUuu
 nkMovH+S1T5MNjgc0epTK1fI+ZeZ247ivKZBJKsXsaP6pkIUz7bCTXnP2Tb2/7oi5y+8
 6ebA==
X-Gm-Message-State: AOJu0YxCWVgHZ/ToHKjD5oCQPjcDuzsbVbKEA1pE4ENp/skTuwweVa5d
 ZTScZMiVxvWk2U5uMQsTotcfKsapkwSqczkmo3PiOnbgs16UzLDAnC+dmxm527lT1NeVhPnSxIl
 xftZUYy4=
X-Gm-Gg: AZuq6aLBoYua7gu4rvZdSFiWGmXKDYDxYvARKTaLo6VfIgF3ZmhipKutzY4sDBkTdo1
 v8klcGLN6RdRfosXNQK3XLW7625MfZRVHlwQz4QOuRsFpFL1hs4+sOBN+u9b8jTbicBxOx3jqmf
 V+zILBFyc5r6j5L5AUGNA5P70VC2Lzg9ZB9FjC0bS27+ampJbTepu+DZ8Ib2fB1r82afs6V+WtV
 kphcmhR5TvuIp87bFI9wwJKMG7sgyvLe07Uy9dp5LEaTCoBh54Mfkge58LAUL86V/d79vP7tP3F
 BY8l8KEk7BBS/Zu7yMlPpiB2GtwJwWC8sEF+VFUgGAC13hWyezC/O7oLgRaUAYo/1NUqwyFIoyI
 9ZCcmFBqsNtzrj8/K0Z4DorvKqyuePAfzb2y4WtJ3SKmJdpatpEYVpM5v5pTyN2jiURBtK6H+22
 nIkjLQfDIKfdKFeBuUOGmVMksrojtq14vJ53+8pcH+enb8fGsgnsQskvjPIOZkpPhhksRihLM=
X-Received: by 2002:a05:600c:c0cd:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-482db623c40mr114518815e9.23.1770075993807; 
 Mon, 02 Feb 2026 15:46:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd0f043sm121279595e9.7.2026.02.02.15.46.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:46:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] target/alpha: Remove target_ulong uses in
 get_physical_address()
Date: Tue,  3 Feb 2026 00:45:48 +0100
Message-ID: <20260202234550.34156-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
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

%addr is a virtual address, so use the 'vaddr' type.
%pphys is a pointer to a physical address, so use the 'hwaddr' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index d6200d101cc..179dc2dc7ae 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -165,14 +165,14 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
 }
 #else
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
-static int get_physical_address(CPUAlphaState *env, target_ulong addr,
+static int get_physical_address(CPUAlphaState *env, vaddr addr,
                                 int prot_need, int mmu_idx,
-                                target_ulong *pphys, int *pprot)
+                                hwaddr *pphys, int *pprot)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
     target_long saddr = addr;
-    target_ulong phys = 0;
+    hwaddr phys = 0;
     uint64_t L1pte, L2pte, L3pte;
     uint64_t pt;
     uint16_t index;
@@ -297,7 +297,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    target_ulong phys;
+    hwaddr phys;
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
@@ -309,7 +309,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                         bool probe, uintptr_t retaddr)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong phys;
+    hwaddr phys;
     int prot, fail;
 
     fail = get_physical_address(env, addr, 1 << access_type,
-- 
2.52.0


