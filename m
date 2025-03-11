Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE9EC35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lV-000493-O5; Tue, 11 Mar 2025 15:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kL-00013V-LH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kF-0000AJ-E8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2232aead377so19364765ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723109; x=1742327909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z06CcN5pABW+zUVUk9wuBNFYUJo3O9KfWdv+N0a9H8A=;
 b=BbUrARlt2IlKJEHDELgitzUJv4RQY7JNGf8AGHO52F+/IXXP32Uy3VZRJaC7ouSMbq
 U/Gstdp+wakdmygK+kKg8KFYvm+MrrWL2mId52JkBbiEnn6X+jD6WKuv49kK5QVM/n+O
 NXLwEaztbj11CE3UEkrOk+aLbNlzuiObn5ZCx4VGVvzgyfO7SLydciGeF447/3Ro6EXt
 0qR9VTxlH8mnXXqVuDV10rYV3DbfNu6WRGiFFwblyqw58xqHjASbf+KVLnL0O1aCJtYZ
 V1E3F7ahgj3DKzmQBtk+d/kNU9CjmcxTC+R3rwMeXRSaQ3iYtRVcmiZImcQSbV5K8Td+
 etDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723109; x=1742327909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z06CcN5pABW+zUVUk9wuBNFYUJo3O9KfWdv+N0a9H8A=;
 b=GLyrowR/wkQDHRaoavcPh+2XACJdAFMY6i2BN/JwBFopKtOmDIJnLdQNrdQj9WMP0H
 03zFZltzMJIKmfD1ChYExKyaCxI0l1gKBFxnpXUEGpxVdqoX52Sk/vyxhT6WbO1OM6II
 ZL4272ErFSntF8SXh3EtTpmrzE3ahW+aIcFUrMyabxSrxvzaMXB4Pd1LN+5hK31QvAwJ
 j33+dBDL5LuD7W4ktt+lc1OA8lTSk4O/9m9j3LYntwsOSdQDtKyWOc0osecQjWxNDQjK
 9o0Rax6uwMQ9wepr7oe5SFNaCK34AB9JYfo4+yWUjYXVzHOHOdRHxGxrK5AL5sjwzPi+
 IUFQ==
X-Gm-Message-State: AOJu0YyBegvpjutNnhDO07kwXwvn8ioN3to+AATfrx8dwVwTHobriyDL
 d2BpwyzPan3BVqVA4OtodN3Gk1LfJldN6Is4bBYe7OvqGOBov99qfzpXEM6oCC6l8QD7gdc0tf2
 tjtI=
X-Gm-Gg: ASbGnctoH5oDTcX1+zwZ5uKw59URqK6zzQ5Lw3U3rbXUUgErfcrBBJMYft6k7T4ejXv
 olbhcwVhxK47csyayPlxlQfru641Wo4UdsNvj4NxcUIMrRtT0O2LrkkdoHo9K4neuI2FjPNXCLZ
 KlrMa596I/wCBSWbCZbjEVAiPFnafBOD19HHDnTdOkifXFHXaGRzBiuulikwguHGE02SHOrCYcw
 uaCHtTk5aDrD2ZM2U73a2dNSifNRo/BNUYsI1Wf9MV01ga004yBqzFNw+SM9MdyRURARCLP/pst
 +hdcoqfhsskFwRgih55NSeDz/nOmTaGKxhySfQdb/Z9+
X-Google-Smtp-Source: AGHT+IFWZfAhxvvEDgAAce92ETlma5STi2t3r8z3LElksShqNyxmTswS//w9tvWqHBQDxaqLnsB1Kg==
X-Received: by 2002:a05:6a00:2e17:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-736aa9e745amr30276190b3a.3.1741723109168; 
 Tue, 11 Mar 2025 12:58:29 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 16/17] system/memory: make compilation unit common
Date: Tue, 11 Mar 2025 12:58:02 -0700
Message-Id: <20250311195803.4115788-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/memory.c    | 17 +++++------------
 system/meson.build |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0a..eddd21a6cdb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -353,15 +353,6 @@ static void flatview_simplify(FlatView *view)
     }
 }
 
-static bool memory_region_big_endian(MemoryRegion *mr)
-{
-#if TARGET_BIG_ENDIAN
-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
-}
-
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
     if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {
@@ -563,7 +554,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
-    if (memory_region_big_endian(mr)) {
+    if (devend_big_endian(mr->ops->endianness)) {
         for (i = 0; i < size; i += access_size) {
             r |= access_fn(mr, addr + i, value, access_size,
                         (size - access_size - i) * 8, access_mask, attrs);
@@ -2584,7 +2575,8 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
@@ -2619,7 +2611,8 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
diff --git a/system/meson.build b/system/meson.build
index 9d0b0122e54..881cb2736fe 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,7 +1,6 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
-  'memory.c',
 )])
 
 system_ss.add(files(
@@ -14,6 +13,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'memory.c',
   'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.39.5


