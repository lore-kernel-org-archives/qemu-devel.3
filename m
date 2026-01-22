Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C416ED6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2u1-0006SO-0R; Thu, 22 Jan 2026 17:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tv-0006OU-Tj
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tu-0003Lh-Gw
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so15601855e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119897; x=1769724697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwyaty6/9Dku7w0or7x9Z1FwEL5g3XwXIWEi/fxrfjo=;
 b=xaAoh3znS34v3OW6+mofkrhxHt53kp0ovQuKxlBa71MUq6X2Y+usDy1NXXOFJp8bJe
 YPXS1+dhOfrO+s09q1fPsduwe94NQcA0nTXJscehseqX+TqM8d4JTuQzON4s5VfhOqI5
 A5VTj5yiLta4/dJqHRz4lHKwU7FHRXfMy1QEXVFTXkHRaRyF7wVyvDbTPKzoy0188Itz
 0jknnOjOOSDtbMNzczD/F1SsQLy0ywarwSzCOzz6ACkuUh+pVzfQL5lKvekR/2Zj2V/G
 KXJ5jQVrR9GbAxc3x/Dvc+pg8XPI4ZjkVfenKL+28ohiF2XxLWGhK+RvzE6Y0t9G4nvq
 q6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119897; x=1769724697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwyaty6/9Dku7w0or7x9Z1FwEL5g3XwXIWEi/fxrfjo=;
 b=Lp2rfgR+6m4cmo68a6XvZX2XC9xKiVOknMryFHHxiacruHWd91gbMRyJaT000GNOjy
 EWYeATS7g+JZvyFfJEgiOjoBXCVBwByoJoKa7k3Vwp/DmeKGOpm62DKv9ircfH0GJJ3A
 FEF4QhYMlheaY+T7QYJWA4rzSXe7oOnk8XYZOoHqfRCr9Bks2kSVIHrStzAy8yWEz6Ws
 BBCAloPyCd422aHbQmv8yAw9zLZbVClQU7qQC/1pkmhuq3gptDZ4/NTjlc0aD+VNFbH/
 /hpiHjYS21UcUU5dIf8KE7fbRghAVlPad9G6wQjO5V2wEAzzClHYoMiM0qMPiLEuhEWG
 VFHg==
X-Gm-Message-State: AOJu0YzwGn+zdegbG/GDEQabvH4J3wlBHPaML3kFIDfneD26dHydkGsp
 Ng4M7YCe0cp3lFd+C/YYT5FL2cBBNJUcHkdMdYM8F6mfBOMpnzhNfrArgzTtb+eMb3SA19pEpBG
 kg4R/ITI=
X-Gm-Gg: AZuq6aK5hpcNDJJJ2ZvJwgFYkBYFvC7TNLwMwiKEr6qQMhEjy2xq2aFzYRwQ8W/Paz/
 h+ZRJ3MTKpTzIoe1TPI51KqpdkQWiupkDWrU6xwCnVPzLi8SBOaXkg78K+1OdcCYpS2U2nwNHEz
 z+XGDSPBQJHw+/zRqLTJYOmrnGRUfUf85g/fd8U9MzZQAhS3ssh+m1EhDbE/3BPsFW0ussE1Qlo
 WqU58TOm9ZdmcqojkN6Pamk7lxySeFc0IxWJXHmckGAl0NoJaFw3+DgtvZoqsu7F0rNFn95jUIg
 acjT15wITgNFtej+pYO8XwEzw649wc/Aujb6YEcWWIdrAMlNP10kX9V39q7TWxYoq/OxUnR9mtu
 WeXdT226CpuKrcQ64pHP36E1T6jaG9N+BlbgAk10R44BXFNZIvm3X3g206F7qdSr9IICrjJl36R
 MeYRyGJm9XOe17/mAHnSaq5wZUD23ZkCSfRv70UpBa3YZSQQHab39DKYTTwNip
X-Received: by 2002:a05:600c:83cd:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4804c95c9d3mr16891845e9.10.1769119896526; 
 Thu, 22 Jan 2026 14:11:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d3fda30sm5982985e9.1.2026.01.22.14.11.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/11] target/ppc: Expect page translation hash addresses
 to be aligned
Date: Thu, 22 Jan 2026 23:10:58 +0100
Message-ID: <20260122221106.57184-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The page translation hash addresses are aligned:
remove the misleading MO_UNALN flag.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6f5d82af636..a8c67364669 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOp op = MO_TE | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


