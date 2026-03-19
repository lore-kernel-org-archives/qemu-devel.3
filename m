Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E748109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ml6-00019C-M2; Thu, 19 Mar 2026 19:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Ml4-00016Y-L2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Ml3-0007iq-7m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:30 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35b95e21ccaso1159566a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962787; x=1774567587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7f9dMZ9wc8KgRYCidnrt4ZZyx/f2C93NARKjYDXY2w=;
 b=FAwcuNTrpLvLtmEdUV1NGLeK2rlINgkCmv4xIqDTctgaPg122vEtaahb/JkK5lCrAo
 o63mjx0wMS7E0LmpZ1+o4nm3jYlZMh+7rMmRU6iSPolL17hW8U1ns8boJH2K8jPdXwoz
 6bAXiD1P4M935bg3PzDZIdws3Bkh8TSqFsxvWtJsX6y1syYg+zv9IiTRonv8TWB+nOrG
 0SbdWaSuSxyQ2nTLrf9uObFebjXNmAdYy5XN7Yx/vsAlI+EOR/TDbIjEVmGL1sHTJcgV
 fL6l2TrW5UndAclIWpmA+NaT6xTRgmgqNtvmliBCDhjXI4TQOd1kFMz5muhmwYmI94yA
 1WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962787; x=1774567587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7f9dMZ9wc8KgRYCidnrt4ZZyx/f2C93NARKjYDXY2w=;
 b=k8M/LRTu2UM/iCUOgOt6cbOfbfmkRZRbAEOBY7aRzL1PxV6weHCv/Vk5VuPoTaUDKw
 d6IF7f8WUWpmMLLFZRX+TVJ7FcfVCrBEJEpSBRUSKivqwz9Nc616vkDGmkibPuCKn0c9
 zSjrEt3U28RAJ59r5Lw7AEXWF0plV5Y+5qxkRZQCasGw6qhkagbVZr+ztDb78iKpnJvP
 +FNxnRG3LNUwGfkZjQ1vpQ/VHYfpe4wNqjRZjA+v3LJG0nNfybiQI0KO0hBE+mOLCKHK
 XKUgssDwz9oMhfAQr1I12lo92QU1Nu7ReCROg8espe4vESSmi6G3a6o77glCroJTJyT8
 +/8g==
X-Gm-Message-State: AOJu0YyiVuGrbSnK4Nmssw49Bx5WjFa4zusmLhFkr9Fknp6iPCNzCaGV
 +akln2KMAD7UQvrSz0PLv/oI02tnWZNZ/AbqPPDrzgYMgnJwhqrk4PoK4ICtlA==
X-Gm-Gg: ATEYQzwNMbQZE4Dxdn3ZK6Zya1lPCkpla576CL9wrgUFpRCKTHbl4CU/JcRxmB8pCcd
 fAlb5ujcwDtTc2rikKYM6YW9pxdj0oKSak94TelMXsyYtjwJxIZ2R0VcyVolopaotjHJ/8UuLdj
 C2ak18wFzycj7jH+Up/YAnl49e+lk7HM8//RKAL11Qal8bzaMtf/8ubj9LOV7kU/tjwYY2Ac57o
 WgwTS5fB3ESUYU6MBxk/Quc+q8OHaPgDXIu9TFO17K2D43cSmDitfBHlTWpNDFKVnSXVQKUAsrl
 7WHBrjAYlIR67jWh4RyHAjfrhwlgjGUCQ8mdRElTj8bkBYAGyjimKJsrflw5N68dumwipAoUqyu
 Ow+u9dSlQ0Yl9Af0I0SYUNnbRxdhvAlVXqV9bOjOEmK/gz/6uIVxu0zSx6vdeogDH5J+uRrLFMN
 /ODXOFZqKQOxrxteRfT/PnzhlwDUYVH8DOyPKHwcXPEY/laCQWpyTx
X-Received: by 2002:a17:902:d2c9:b0:2b0:52dc:f1c1 with SMTP id
 d9443c01a7336-2b0827bd48fmr7486885ad.16.1773962786984; 
 Thu, 19 Mar 2026 16:26:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/17] target/riscv: rvv: Fix missing flags merge in
 probe_pages for cross-page accesses
Date: Fri, 20 Mar 2026 09:25:20 +1000
Message-ID: <20260319232522.1867400-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

When probe_pages probes a memory region that spans two pages, it calls
probe_access_flags twice - once for each page. However, the flags from
the second page probe were overwriting the flags from the first page
instead of being merged together.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318013805.1920377-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index caa8dd9c12..e60248d6d3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -151,9 +151,9 @@ static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
         addr += curlen;
         curlen = len - curlen;
         if (flags != NULL) {
-            *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
-                                        access_type, mmu_index, nonfault,
-                                        host, ra);
+            *flags |= probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                         access_type, mmu_index, nonfault,
+                                         host, ra);
         } else {
             probe_access(env, adjust_addr(env, addr), curlen, access_type,
                          mmu_index, ra);
@@ -161,7 +161,6 @@ static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
     }
 }
 
-
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
-- 
2.53.0


