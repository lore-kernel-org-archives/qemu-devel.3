Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF86D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM4H-0006hv-Rj; Wed, 26 Nov 2025 15:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3o-0005vi-Ey
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3h-0002fS-LM
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:16 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so151442f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188650; x=1764793450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKgkNfPfnIgBlkZd4fYEByDwbkJlxYJ/qiGhZVisjIE=;
 b=oVKieNOxFElnE27q30E0MguXjCwMR+gBXQRo1uaZW+Xna1pglx9jXQplElz+xa1kAm
 MbMddo4N7JJ7K5SNFC4Hu8i8p6CdchsyZUEYXkQcOqt1n3m66Qd9slmcyrUcuCSYQDfP
 uicUWL6atUs0JKrmS7elWojPl7FmUyInDTOBM/6yR4JVx0qJbAYNzEW9EcvZ4+TIf3qY
 iJt35uvUv3+3C62m8bYioH9PfS7B0K4/SSc6kNHl8RIft8XaN6FL9hl2zhfpbE1kQxJh
 3bwRsiVBddAWIC0j9GS/Qa036Si1uDfA5fE5dFJZf1VhycuVWQXnS9TrvlH5bpf7ewJ+
 F71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188650; x=1764793450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKgkNfPfnIgBlkZd4fYEByDwbkJlxYJ/qiGhZVisjIE=;
 b=IPyF/7WCIuWSEZRfwilbXCitijcpcOmKJhHRUFCujySnVq3hn27GN43OZ9vaPuyQ+y
 WBkLk44vDXojE7T9UOzlnegIn2R07/am5KF3LXbpa++tOvPx9bYqAK2y/xbCM2pEXjaG
 7QwiXANkopj7wndaghaHw60M5obo/PXRgaACXrgO9hpwLr3XC4AmiawBhvWO+W76huSg
 /hSfnlZ6zRZ1ANAgKwk/7g/1R0RdnNJXbH9BXnhBOegRBqMi1OBre05uQA3nr38biSJP
 rcF/hBVSEAWlXWsN3PMaGIbHXZ5uG9USMMBsxGkKtpUXBV0pPU2xyi7IP3gNy9q6rWv9
 yqBg==
X-Gm-Message-State: AOJu0Yy/+8+YdnRe2lpszZqN9lexAmiaVelchekQtCAWf7NmwHtkSVLy
 OtWa1wJFbxdwdWtxq4i7mlgHtdpMzEnAjLpJDmE6Wr0hWnO3wjmlJuTbSQEMrCJsjDPNp/xODrE
 /8kcAYkXTiVKV
X-Gm-Gg: ASbGnctIiAuGt3GLKvWDJcjXi9lU1MTyjg5RkJX68dT2FVL1Pjrj87I5fdruc4vEFWH
 Eo0akDpDJBVhGYQ9hQ9FapbA8xll9XJAbaeOS/iia0ZliTtGpv9C26iYFClJjdt3S5mlJ5euC3J
 BJfCxz0aLPpk8BtT199K9kUwL4U706535YWP/2apay013KWfmRroLPK0cnQapg9an5huXOJNoIN
 6NN1+yPMhiThS6PsgXVY2juAGSS+EYsPIoG45O9NSbxig7aBpp3gWKJkiJmympi2I2erbZvilk2
 KdhBzjD9lja7T9g2ieJSQ5LMYwIKcUvvwOQsy4VImtSw6zqk3kiQ/UEvSIbRZUDUJSNo7l4pldH
 ZaTyfkbs8WihVPmzvnytGy9D2TmXaqpqXr8UUlLUxKOJPAjVT1X76y8GA2Jg8ird/X5qnsmWe4E
 3/9mEZdHThOnR3Qn7bElWUtd80uUvSvRqSeRlMyCqwcXV0mDlHeYQR7UynLJLU
X-Google-Smtp-Source: AGHT+IHD4+btEnXpeTj9PVcy18RDYzbTxn/JwEHzJPz9hksD0WYvuaUDoCISG/4dWmKDLPNmmCYBIQ==
X-Received: by 2002:a05:6000:4006:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42cc1cbcfe1mr21740153f8f.26.1764188650462; 
 Wed, 26 Nov 2025 12:24:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm33017543f8f.7.2025.11.26.12.24.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:24:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH-for-11.0 v3 18/22] target/ppc: Inline cpu_ld/st_data_ra()
 calls in do_hash()
Date: Wed, 26 Nov 2025 21:21:54 +0100
Message-ID: <20251126202200.23100-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of removing the cpu_ld*_data_ra()
and cpu_st*_data_ra() calls, inline them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index edecfb85725..244aeb23c16 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -160,14 +160,17 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
                     target_ulong rb, uint64_t key, bool store)
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ | MO_UNALN, mmu_idx);
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
2.51.0


