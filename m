Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C9D6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1qU-0005WT-1X; Thu, 22 Jan 2026 16:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1p1-0003rp-FI
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oz-0005M3-Oj
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so11479155e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115740; x=1769720540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsgN08xwFykkgI55V8CeZLzuXOe+HEtSRM2XAs4O99o=;
 b=if0F7Pdy431YKIgbei9TW3i5BCrZbe1F/7MUC0E/T6FsgQjsp8PQ6iZ3jtrJMJgYDl
 A8e6BQBmxru+277FXVU4H/b+5B4tMgr9qzDu589Jt12aYxHMyTH1q1fcZXfDMAgVfbp7
 hEdFI0DpSSJj2tTQ9MIz7qqiz1pADU9X9s2I6r/AI/Jid22/0T41MyIqYU1mQU2eKftq
 6+UXN6qOV1qCKCCDJ8B4Uem71VrCXw8MhaHIcJzUIh65yXyVjvSGL3BmxAsejcHTy/nQ
 HoMohS3vLFrlr+QejhqPSaghV9M7vNaVaFj0xM+Z2ysz8S53R341rULFJc0W50m1+0nh
 Y9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115740; x=1769720540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsgN08xwFykkgI55V8CeZLzuXOe+HEtSRM2XAs4O99o=;
 b=NtRDXUfw3kMH/GSq8PCoy4bk7/ctJmbLq32IY1/tR4cw36Mh/qlBXhFj7/6I/EX6AE
 xdSKnuPQHQjl2cuqFADQNGPaVSdDgC5bSyEdU27AKZT043OfW98O98HYAv2HIg94ian9
 cFYLQcEcd9sHqd+Nl5vydZAo0e479DcijTEM/MdlTQzGT1hxgGsgkQRR+RKmbNNTba5K
 YV9QkZU6vMSua3N3DwKhRHuMzay+iC7ckoi3oGq4mMi+mHUOK30UENN27RkvF6vZWxuM
 W2pjdh5dRxeFxCX4NoU3lbrzoSGGFXKuBEKocsp22mL6Zlhtf6xf0rQIH2eoVRxsx5/O
 iV8A==
X-Gm-Message-State: AOJu0YyNwWWbm/lF3brmTBxDTzWSgDRsFdpujBw0Fhgpz1Y0CnbT10oY
 N8P1ZCWWTsgZPRklt7WaZKdaLrSqW5f/Vq5ppArgTS7IarZdXXebDzV8uVoh2K2d9cn3pUqaCDl
 wgjU6ICU=
X-Gm-Gg: AZuq6aKd1CsAQ+jy51GtULG1h224wfULRPmvw352jYq8zpcES3p8IXIF99mPoEDWbry
 jvYygcPGy9b6684IXp61oe/EiJ3tealmrFrfMRG5MnLuD/5qnmOXb7Auea6eFUYrxwsdnHq5oj4
 oHh7F/4TneUsw5nyoBVzMF8TZo4Dr2fbmgAmO1iP3WOy93fyKMHdsWUkfybsEl6OV9KiUFAUv/y
 QdhBn0t0aC0Pna+FfcPMQJ2oHt04pnYr6QMSQ46KiCukU9qwgdD2/QOTsWtou8LoMvkt7vW74xT
 FhgFO1J0pI8sPXFAPBHZsRNEEoV1TGR7Iv7bL4KwEwO5uMN8MhPrbUdkFd+Ci2P9Sq/YZOyEROw
 CiSrV/8Dh5kQWAPZ2VKbDOysI+HVq/Kw32j7E1gHAJf5oxCKH6IZ9T8uy4Mg4SeESQvtApZ9G+X
 WhieM7kavd5PN17k7FRTViVwh0rrkitcwlqQjqAAr9IuhLMy3o+A6DpZjMR71q
X-Received: by 2002:a05:6000:184f:b0:42f:bbc6:edc1 with SMTP id
 ffacd0b85a97d-435b1587d81mr1222762f8f.1.1769115739882; 
 Thu, 22 Jan 2026 13:02:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24b54sm1358257f8f.15.2026.01.22.13.02.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:02:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 11/11] target/ppc: Inline cpu_ldl_code() call in
 ppc_ldl_code()
Date: Thu, 22 Jan 2026 22:01:01 +0100
Message-ID: <20260122210101.55358-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Get the runtime endianness with mo_endian_env(), passing it
to cpu_ldl_code_mmu(). No need to swap versus qemu-system binary
anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 77d21523a5b..955afc40a83 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -428,22 +428,13 @@ G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
     cpu_loop_exit_noexc(cs);
 }
 
-/* Return true iff byteswap is needed to load instruction */
-static inline bool insn_need_byteswap(CPUArchState *env)
-{
-    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
-}
-
 uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
+    CPUState *cs = env_cpu(env);
+    MemOp op_end = mo_endian_env(env);
+    MemOpIdx oi = make_memop_idx(MO_UL | op_end, cpu_mmu_index(cs, true));
 
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
 #if defined(TARGET_PPC64)
-- 
2.52.0


