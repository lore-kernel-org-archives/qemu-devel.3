Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE55C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYar-0007w9-8z; Sun, 18 Jan 2026 14:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZV-0006FZ-1i
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:26 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZS-0006lu-Nn
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:24 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso23618555e9.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764981; x=1769369781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRVd3/fIp9XGWnatHHkuG/q29nD05xPL4cBPZy1sqvs=;
 b=dtm8OBltM8Z7XtRIFXvi3XwGlBUJYt6S1YQz7ixUQ3rSOHSnkzib5nLaULRCbTiv1C
 l7kxrnQ3uHzFOAlunJlHmTwDuxp/3Ad0KCPLv9YtGyywwDsBkz+74BGzR8U+UtYj435E
 BZDEe5LVEXHKm7M3tI2CS+pckJkT2fZzqxJbkQULlOi/DL+364dHnQcMqI0uh8Zd47Lj
 JE3dXEo/Xme/8TlQRAIBfkYTxZrnYrNNu+mC3kQHMmxiVMxnJGu8y3ArixKJEI01v9OS
 f1MdrJtHJOvYBjueSYfhk5f0zaby+7uXtLrxY9smzZHte3FWTDiKQwtaUo5IRH46hxRP
 YElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764981; x=1769369781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RRVd3/fIp9XGWnatHHkuG/q29nD05xPL4cBPZy1sqvs=;
 b=Nt/w4tLrWIE+4ACmTqOLuBkCpQlpB2Wxu8/IaFfHm9TtPHSNxAxb6cnjTz1A/l2wxK
 ionUmXt94U12Qkno0inMrxRRFNwW02J+JwYN2Sfl7VoaLVcXPLNJLwZZvSE2nxWC9jcM
 hEdxrrnh0yIvmFs3IAvIO18mxvqJGwJypOoZ+J0WmrEMeHkYc40z5r2EF+5e05bXZnp6
 rM5nmh0xdsYANT29g0rbk+892TZhk/r9/aGpJqnyBOaaZdkE+LYIfAe/iZ54k0DcFkuL
 lM0GqhjSJbSomqTd9fr0/YArxNPkt0n8DLNWT9Mu1RF/wII4kiO0mTneESyYQvsojQmU
 NFyA==
X-Gm-Message-State: AOJu0Yx9jci/3lO3jLIOvnlD3CM5v5ZxY05EzdTxAVZVG7YHJWwIo8e0
 QH+FAqTYWjeIJyUINB36HVHwVzJrqfFOf0VUV10t+djR+PQu7kfACNIE/4SLvPz1F/H1JWSCj2i
 bbd3TLoo=
X-Gm-Gg: AY/fxX5e5GdXd1gWG14Q+qLf7YrM4CwQnSW2quFETK+130YAZ5X6oYp+Vor8ONubZ1d
 P2lJrZBf3B51eM9zbj20EkzPSL7QqrPalKlnWwgpvF5EtRNirnbHGOuU1Wbq4Yk26Y0+P3t7wxU
 L8GnKni3Y4ObegDH38siI+3nbNmmWnGOPJ8CiDac96cbgu2Rwnfed2EViguOeysD9bqzhkjmz9b
 u5cwaekWl+V5ZCqXjj4u8AXje4ITks40l7hJyeiS+Gp38gjTlsM0V6FV0WJdYMsC2U7MvsABJ2j
 oBAd3UWW+iGiLkZDM/g6eDp8I2ExtCTlk8ev0hZjUM/jJ4kDmYCL9BHr0a1FHhcFjqaRfPcYbQr
 4GqXDrzTfyZvnq0fqkjEwg7IADtTMdVdfHgilouUOPehwzJruQvAJBLvqeSu6mFQyDnPJFtC3eh
 kfg/421CtkaaJeuUn/mDODAy3bAmhiC0DSBcVhwkgO+AnbM8A6CHZzOK21O3Zj
X-Received: by 2002:a05:600c:4745:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-4801e30fae9mr120940615e9.15.1768764980873; 
 Sun, 18 Jan 2026 11:36:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879542sm159776465e9.4.2026.01.18.11.36.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 10/18] system/memory: Use ldm_p() and stm_p() helpers
Date: Sun, 18 Jan 2026 20:35:00 +0100
Message-ID: <20260118193509.42923-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

address_space_{ld,st}m_internal() take a MemOp argument
so can directly use the {ld,st}m_p() helpers.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 5c8299e0cdc..d51c5feddf7 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -27,7 +27,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                                   MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
-    uint8_t *ptr;
     uint64_t val;
     MemoryRegion *mr;
     hwaddr l = size;
@@ -45,12 +44,7 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     } else {
         /* RAM case */
         fuzz_dma_read_cb(addr, size, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        if ((mop & MO_BSWAP) == MO_LE) {
-            val = ldn_le_p(ptr, size);
-        } else {
-            val = ldn_be_p(ptr, size);
-        }
+        val = ldm_p(qemu_map_ram_ptr(mr->ram_block, addr1), mop);
         r = MEMTX_OK;
     }
     if (result) {
@@ -102,7 +96,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                               MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
-    uint8_t *ptr;
     MemoryRegion *mr;
     hwaddr l = size;
     hwaddr addr1;
@@ -116,12 +109,7 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
         r = memory_region_dispatch_write(mr, addr1, val, mop, attrs);
     } else {
         /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        if ((mop & MO_BSWAP) == MO_LE) {
-            stn_le_p(ptr, size, val);
-        } else {
-            stn_be_p(ptr, size, val);
-        }
+        stm_p(qemu_map_ram_ptr(mr->ram_block, addr1), mop, val);
         invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
     }
-- 
2.52.0


