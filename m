Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7831DC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpR-0003s6-SK; Mon, 27 May 2024 22:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpQ-0003mY-3f; Mon, 27 May 2024 22:44:44 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpO-0003mH-GC; Mon, 27 May 2024 22:44:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7010a7df499so266634b3a.0; 
 Mon, 27 May 2024 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864280; x=1717469080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rwx0SPD4bR7zPO/4n31t9fpXIatcICjktSL4UeCf/R8=;
 b=LkoJmDtTpSRt4rAMRV5yhE5s6eHVuAYvpG2m3e4OvqCNP4wym2BXBQe4VKobmQebay
 sULE8PX398iEwsd5d5dyfaPHaf4HRIKjzFIPE34NzVeu6HyfhyFUJuiQilS3+Cu9HCZh
 6Udx1Cbvcf3zoPe9eyTBt7SMv0QzRu6ug8QOHATxfYtsgY0G/WYAEOWEKhfqa52NXWq8
 w8fqQVgWYA2wQNsL2V5kKXZY2/rh0KvkO680LR4UmcMr4ea5VUOVl9gLScCLZ5fy5Y/1
 5bayHHjzE+09JwL7lNFxTvknefOjyAixoEDXNer6lF2Y3vUCV66UEXqi/FwJ0311L29c
 MO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864280; x=1717469080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rwx0SPD4bR7zPO/4n31t9fpXIatcICjktSL4UeCf/R8=;
 b=BRCaBgCXDqIrxEJI/xgbJc7J34Jn1TS7dCexQj381ezcnKAPA8KpkX4ByeuIglG4fr
 fsNEyxj2a4FcoiW29msE0rcUivD6C6rOJ91WxuA1lvrKdjJyYzEGWNp2tDLRDRWo1GlR
 30vJatxx+THyUmYboIU0zp7fWL1nYpypNbFc8IyYIrDsnuxs9VJm0ugvSQJsKp4/wseN
 rqyZH2yMVJTpnXXCxd3YPhG2PCgePBDxnJ2Oy9tpz9g57XLOOdwQUQOTio4h7YibMCGc
 zxuRP4UVa2lmntFJ4yM3+WO/hPJbzWoah06hCy7hrJhcaXBmRw2sjBNXaurXA9MV6aR3
 eUYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQMJO6wgY19iBLG4iHOLVxFSXPXEttWGcKhJWnz34kmps/4xiHphNkw+YYPBlXc8rp8PteK9mANKjFntrgTvLarhYg7olA
X-Gm-Message-State: AOJu0YyqGyRTPWyE/yKdnTE2a7Ff0/1DlQqVu0uT9bkjlbzpsbl9o96i
 4Wayj0a+2o038bS1vPryqlao2rCGw5Acyw8LCiJ+nb4j9ey1kszJw6rEkw==
X-Google-Smtp-Source: AGHT+IH6eBidv7YqdsaxGaB5j3YAedlb8030h9AimV9AXAs8oRRO6dTF1Bipk5BCsdGk4BAHGXRuiw==
X-Received: by 2002:a05:6a21:800f:b0:1af:5e48:ab59 with SMTP id
 adf61e73a8af0-1b212cee853mr11244696637.13.1716864280544; 
 Mon, 27 May 2024 19:44:40 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:40 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/28] target/riscv: Fix the element agnostic function problem
Date: Tue, 28 May 2024 12:43:13 +1000
Message-ID: <20240528024328.246965-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Huang Tao <eric.huang@linux.alibaba.com>

In RVV and vcrypto instructions, the masked and tail elements are set to 1s
using vext_set_elems_1s function if the vma/vta bit is set. It is the element
agnostic policy.

However, this function can't deal the big endian situation. This patch fixes
the problem by adding handling of such case.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 996c21eb31..05b2d01e58 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
     if (tot - cnt == 0) {
         return ;
     }
+
+    if (HOST_BIG_ENDIAN) {
+        /*
+         * Deal the situation when the elements are insdie
+         * only one uint64 block including setting the
+         * masked-off element.
+         */
+        if (((tot - 1) ^ cnt) < 8) {
+            memset(base + H1(tot - 1), -1, tot - cnt);
+            return;
+        }
+        /*
+         * Otherwise, at least cross two uint64_t blocks.
+         * Set first unaligned block.
+         */
+        if (cnt % 8 != 0) {
+            uint32_t j = ROUND_UP(cnt, 8);
+            memset(base + H1(j - 1), -1, j - cnt);
+            cnt = j;
+        }
+        /* Set other 64bit aligend blocks */
+    }
     memset(base + cnt, -1, tot - cnt);
 }
 
-- 
2.45.1


