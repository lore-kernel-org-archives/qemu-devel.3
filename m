Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A1DC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByS-00060R-Ll; Fri, 01 Mar 2024 18:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy6-0005GU-CL
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:06 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy4-0004Jl-OY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:06 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d911c2103aso10235095ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334423; x=1709939223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZemmFhkZWzz9AvC4hLSQ8D3Jh4HUes/r/6Q/zZwIww=;
 b=p88Hc/70b6Xdgd//kfMffeuFe9PLReul6ROGQQe5282pkSnhb34RowJ1/8F+axa3or
 TmmQ5L/EFv+Kw2loXe+MtVjQjY6XLX1yz5qCo/DT8BsCKCLJpvulzn6T8JeVfDxYi0ly
 f3PaBNE4eFfevza9HElHHZWBoNWTwWdNTh8uUBylSOtQhATXOap1bcbL1upEvlYYBHuc
 3A+6J4YYvcv9tOqQm+tvdUP0vR75DlykDI0n/XHcKM1d6YF4J10zLkOF36Qi5vIJZ7KI
 t/SD4O4diGSom8jXWZV2Vvq4jYqtcJ4z0fMm1ptjoUpbDLYwGLRqWtP/ZuV7Sb5dZ74B
 jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334423; x=1709939223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZemmFhkZWzz9AvC4hLSQ8D3Jh4HUes/r/6Q/zZwIww=;
 b=uDCCKzvJSy7WeGR15ABY6rbaNpS/aSZsuLyzIxYm9PfAye+OtJL68wbuN8Kd087oo0
 l7ZKgUvbExWVR6m6HHHAr/T5+qjTTp/hv/uRBDC/fBkL130UpAw7EbPHwJAr+Ry3yzFp
 OywdtiyAdvace46ud6mK7supvdUCGuuM0zqYsBkq6WVYOhr//qqr1zo+g438tJpD7Lo6
 CCSAey4xOsVFbcIWNmNO46I1ltXAS5Sf69i+Hf0IuQ2AURLCRoA1M8hmgI9apjphMs8I
 dTYV4MSw9hlHKZ3J2ljeg9jUH7TdEn+gz+nB86W63C6Qb896kcgY35bK9ipg145uLlz7
 HBLQ==
X-Gm-Message-State: AOJu0YyhDHO3XoAiH2RxToZ3fJaYsQ0Zj45RMJL1RZcEvRmClw7uUQVT
 W6a9qvTrzjuqRb0WOKO5xHsHk8DC1dxZkLtT8hX3d77zt83vBCFhHVD+tNgqZAMRmC4CTFb0ReG
 m
X-Google-Smtp-Source: AGHT+IEIJH4RfWcnFwF3O2OIa0N3j1G1N0CYyUOI0/r2t2Y84/Ij4T4bDy2n+8syKaizYfgnUqj8vw==
X-Received: by 2002:a17:902:ce91:b0:1dc:15f5:fddf with SMTP id
 f17-20020a170902ce9100b001dc15f5fddfmr3905967plg.7.1709334423361; 
 Fri, 01 Mar 2024 15:07:03 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 29/60] migration: Remove qemu_host_page_size
Date: Fri,  1 Mar 2024 13:05:48 -1000
Message-Id: <20240301230619.661008-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace with the maximum of the real host page size
and the target page size.  This is an exact replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-12-richard.henderson@linaro.org>
---
 migration/ram.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 45a00b45ed..83fd780fc2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2934,7 +2934,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
-    int ret;
+    int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
         return -1;
@@ -2949,6 +2949,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel = f;
 
+    /*
+     * ??? Mirrors the previous value of qemu_host_page_size,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     WITH_RCU_READ_LOCK_GUARD() {
         qemu_put_be64(f, ram_bytes_total_with_ignored()
                          | RAM_SAVE_FLAG_MEM_SIZE);
@@ -2957,8 +2963,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
             qemu_put_be64(f, block->used_length);
-            if (migrate_postcopy_ram() && block->page_size !=
-                                          qemu_host_page_size) {
+            if (migrate_postcopy_ram() &&
+                block->page_size != max_hg_page_size) {
                 qemu_put_be64(f, block->page_size);
             }
             if (migrate_ignore_shared()) {
@@ -3791,6 +3797,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
     int ret = 0;
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = migration_incoming_postcopy_advised();
+    int max_hg_page_size;
 
     assert(block);
 
@@ -3808,9 +3815,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             return ret;
         }
     }
+
+    /*
+     * ??? Mirrors the previous value of qemu_host_page_size,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     /* For postcopy we need to check hugepage sizes match */
     if (postcopy_advised && migrate_postcopy_ram() &&
-        block->page_size != qemu_host_page_size) {
+        block->page_size != max_hg_page_size) {
         uint64_t remote_page_size = qemu_get_be64(f);
         if (remote_page_size != block->page_size) {
             error_report("Mismatched RAM page size %s "
-- 
2.34.1


