Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62393E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHxn-0000fT-IU; Tue, 03 Feb 2026 10:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxl-0000ay-2r
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:09 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxj-0001Zq-G2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43601e96f72so1767715f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131106; x=1770735906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LULTJik1sZBRZnMOo9iwpBT/7GjbTofs8Yu1+pD+MBc=;
 b=RSFhJ793/5kSh37DXNaajo9sSmXw4oA3l9ci3eIFzjLHfu9YdUR6V46BsTjaFEKZDz
 g9kK9h9zhjtaNbD5pIRjPWNwGn4onQ8W/Pl2LEW20qXmpqjJRHZppkTbxiWPuYZ5dg9s
 YG1aaAk+G4Lb7SuMd0OaOmnzr8rXl80g5IspCPyIvcKLEqSo+OvtSYAw9M8EojNjZRcx
 dPVBe6+1+q1vMizAq+5wjwbbPCphxIutLM4+ZnUsuRrDQ1nJUJxCkesREE0RCCTPfVqv
 6gomG21He3F9TQWtniUH9OAVm+BcaioBqiFyyfDTp9ft+M9NegUT/fLZUkGp1XiBBSjX
 ve4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131106; x=1770735906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LULTJik1sZBRZnMOo9iwpBT/7GjbTofs8Yu1+pD+MBc=;
 b=Kl1suWjr16fyUpo4oZ19f4KCLHyErcXvZctRtvnY9x1u2bF/+m6lAajggP/eDg3L7U
 Ywv8tmFk+iI/39DQ0j+oHbHjVNYk4jmkHs6yywCrbP2dqJ4VlpPXitKLv1HfSHLn9KeX
 OHbvvOcoUrTBJebUZ2/qhDW7GUiCismRUfYymWMJ4OaZjNsONXLHnuF/gwbJcRvxgJSS
 6cXtF0ruO2l34TlizFwxQGnzLaIEHxQxEDH9uSYahcN3jU/1FnaAprQMKyZcI7xe7psf
 XQVcW9EdVMUZukhXhOueJPziLRVj9UamaKPE9CAifSnFMt5ytPoSUnv0p1wE2y493JMA
 Psgg==
X-Gm-Message-State: AOJu0YyJlrLMRBwKEdpy0bfwBrrsrjde3wAqdVhkTsC4/sU4NkpsR/Jg
 GL+89CchNujxabg9ZWZjIVv0mWvIRUzjXysNaPmNlI9awdkGczXN3AYU2WvfIrdTwxNBMrXbqT7
 181JeHE0=
X-Gm-Gg: AZuq6aIGfOo4PmFSl8GjGJN3fh4qiq4tpeyb71kDQku0jg/Psz/BQW5zcj87BQgAt9b
 shLVSY8KbFn6vRvoEuAzXjororchdC2A9E8rfvWrXk4PAgFO1o1RunMDZ3kXaGetXPdN8RT6WOG
 PvBg38K/pCJ2xHUWfrssbOu9l1TgVYCYj4/BesHRa9UAH3zD9MoP+0eWhXbz5+H+WRY8MK4Lb2+
 NbY9/dxsvTohZkY6z6rS2AiuVmLg3nwwYp1RQcv1bGK2Temx3pWLpNuNtlkHr2eGiMVEFyKApKL
 pCtERh3+nvF5pNm8RhfcKbl6amTPXOWmZ2do+jGDOH6xw5shyF3LkHbCeBrfpZrTDEHCxE46Bnh
 3LOrO+8UFUukrSKVZ+4ru/DW2TFbVVJi0NB5ARoVwN00p3S/ll3iuUfEyhz6VvruoA4Rzny8FEa
 M7UDSn6FLVvuR3na6fNjIVa8ekAR1f70NoKu0L1uTjwymjTLPmrJQCRoKlUygf
X-Received: by 2002:a05:6000:2088:b0:435:b7ca:7521 with SMTP id
 ffacd0b85a97d-435f3a763dbmr23756188f8f.15.1770131105630; 
 Tue, 03 Feb 2026 07:05:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ed952sm54513890f8f.10.2026.02.03.07.05.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/30] target/ppc: Inline cpu_ld/st_data_ra() calls in do_hash()
Date: Tue,  3 Feb 2026 16:04:09 +0100
Message-ID: <20260203150436.71907-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

In preparation of removing the cpu_ld*_data_ra() and
cpu_st*_data_ra() calls, inline them. No logical change
intended.

We note the page translation hash address is expected to
be aligned, so the MO_UNALN flag is misleading. Next commit
will remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-4-philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index edecfb85725..6f5d82af636 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -160,14 +160,18 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
                     target_ulong rb, uint64_t key, bool store)
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOpIdx oi = make_memop_idx(op, mmu_idx);
+    uintptr_t retaddr = GETPC();
 
     if (store) {
-        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
+        cpu_stq_mmu(env, ea, calculated_hash, oi, retaddr);
     } else {
-        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
+        loaded_hash = cpu_ldq_mmu(env, ea, oi, retaddr);
         if (loaded_hash != calculated_hash) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                POWERPC_EXCP_TRAP, GETPC());
+                                   POWERPC_EXCP_TRAP, retaddr);
         }
     }
 }
-- 
2.52.0


