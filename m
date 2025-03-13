Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63E1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslbT-0004Sp-BV; Thu, 13 Mar 2025 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslar-0003Wd-Gq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslal-0005jb-4W
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so2758028a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883970; x=1742488770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBRugwqnxw4q7Phz2P050i5IjB6Zbf1WGwdoEilqtkY=;
 b=V0oo/G0FjjJOv/WkwiDtWMSY4Am+JpPD0wdGo5IvVDRKonN/TKKWvQjVCFf4nTe0oa
 4Kiy+Nw4+lExuM5l8WdtEBDWGpYtj4q1Nn2vdFYo7ag6xAnLYKcvQwP6+RVpUCvBYOM0
 uZctXp30BymUXaJid+bAuEJ5mXlt289tgewTrQ1k1PuhJTijXAW7wcwDm5aDfTqQNHaF
 QTiHFdKQ1YInwdtsXUvyCSVOTpEbaN9vDzfnYNAOqJmxfXdgSZSvkZIF/57gBw1VNzVm
 cYYm3FAFX4EByamxaZj97KrgKZER/OZd2Rjt37IEACHvlrGcivSebAE+2Hwd7XJiWxAP
 NkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883970; x=1742488770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBRugwqnxw4q7Phz2P050i5IjB6Zbf1WGwdoEilqtkY=;
 b=uqajncKqCAVKqvWOLGqxZ0wCSwXkSEl4SU5UfMXJ267FE8UqM5druDL+UDy7DpbXES
 zUHou+rblfMqFy7PTETVoNL4pBwvnIWNrP6kqnRA5mbeHZLXL5WR2nnsjSnvITlxdr4/
 a+5sFnh9LN7gwdF9y0fvELm4WOB8349AUT0JPTU65pNnlUbol74r49hZ1fjs6KYZCEv9
 7ghxzcV+9UCGVWXlcM8lD+3bQ3s8eHjt8vpVkCokDRyds0M+8lk8R0RmT0Bv94fRXc5X
 NZiTBKW0nSBwBK+sG9kVDLOnnL23Q39cPWzYgEjJ2qi7o+iL3sT/+k498afc4RVqyytT
 wq0w==
X-Gm-Message-State: AOJu0YxyYh2fr9nHTTHJppxwcYIPVQG1HTdWpv8MrJAgXqpmSFNlDqFw
 tMdOzyeXLBFgXapRhIMQBCb+bRTF6BuoZevM/AnuyBFXjalkhPYlucaHXVK9HtIxf1G70QLBTNg
 Q9a0=
X-Gm-Gg: ASbGncvSiFWVY3fR/HPHfvOQ/YyTi9FMaodZZM3pxh6EfVe/AFYrJFyHBy26NH4y/z8
 /7RlF4En/I9tzQ4AGCA+LQ3YCf+NN5/in4e0ZWF0+8FF4ZddA4aUFMFZqEtdXUww0bTrM+QfGc8
 kOSPtzI/VYTwnw714e/hDXAavyM98QiujAQlXIUOUxskJM3iBPR5oWFCVXiJpfUq8jIQQebqy47
 ui2R1FHllWfGgXMHaoM+qOCGSFjHFZ6etb30xLswY3zjvItFqiQOqa22lyy664Yu8wsAYfr+NKu
 yysgd6IILAibp9DonW6LYyd+LhZnYrwCKh28edHRmWmL
X-Google-Smtp-Source: AGHT+IHRyNfs/2JPL1rq+dZtoKg0Gk6ovyIhkaylwgSPQTAI/HYpqKgruBLvp53+c1fVanolW+jjbw==
X-Received: by 2002:a17:90b:51d1:b0:2fe:a614:5cf7 with SMTP id
 98e67ed59e1d1-3014e815c62mr251908a91.3.1741883969872; 
 Thu, 13 Mar 2025 09:39:29 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 16/17] system/memory: make compilation unit common
Date: Thu, 13 Mar 2025 09:39:02 -0700
Message-Id: <20250313163903.1738581-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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
index bd82ef132e7..4f44b78df31 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -2,7 +2,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
   'globals-target.c',
-  'memory.c',
 )])
 
 system_ss.add(files(
@@ -15,6 +14,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'memory.c',
   'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.39.5


