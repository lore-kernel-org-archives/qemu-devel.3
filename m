Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA97CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoo-0004mc-V1; Mon, 12 Jan 2026 17:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoc-00046U-Av
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:14 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoa-0004CL-Pr
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:14 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso31667955e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258511; x=1768863311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ixa8kMb1yAqmJeY5NW0mNxmkk+TRFUDy0Njhgryezl8=;
 b=k2NITyr+BK07b+UAZcZcx/91zq+RXKH+sxlQLWWvXDdL262IF+9YOiYLdmryX9kDIl
 yH137CXEXzM2DuQjHKRl1BeGEJpRAz25OqILUcYLioGmJZD1114h1J/4rSpycUd2nqnF
 +9ST4VtXG5EPgE/8rFoX+bJWyFUshcb3yOrW4MdhL2b6Lx5bFkZx2mLJ+PH+Wb2x3OKK
 Z+NOKANKe/9FSC8L1++wdYvp0Xykw4px/lxa0IuXkirCNJ5/4ZnDbg1h+5CE2D7lBt2r
 iGp6OU41cqnnNknA9rUglWqZOHeM7uTaqSjBNRQC+/SPSgB3BRJLKhyqkBdmkzKVN8dP
 EKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258511; x=1768863311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ixa8kMb1yAqmJeY5NW0mNxmkk+TRFUDy0Njhgryezl8=;
 b=itj4ZlVXBLJv/Rys+KoCvNjwy9usc1B/z2Dtg5IL5rniQqjAoejTYMis1YkcIXePoW
 IDmW0rbS2BYbtOow/A7XVZ2JnczhyhZNBfk7Kcf591NHToZGG+2TUrUhmiySVodNlALd
 f5EjdSDen3/hK7d9NgMd3p8tpbCteQvhZ9jETLKFaQ+r14tuP399fSbzhgrWQbyUMPOY
 wQOjx182x22p7apjT7y1QIXbAZafepK1W+WgLVxNuV/MyQnQXlPebNLJKANODum5PvqX
 XDv0BZHdr7Stks1EFwRe/eVDYBC22jd366uKDehaCCzuuxN87eEOtBI/wV/o9BrSD7qC
 +WQA==
X-Gm-Message-State: AOJu0YzGZNR+jmAuo1T035iMV0QAEhK5GY+fnqSTQCbcsg/T/gD8dhQ2
 pG7iTjSxl+LUqjtl1qZyqR11r4uShrwu5R3WuwHQo01Ge4Nc6wCkQMEdTQLoay6Qt99ybFGJw8l
 b9f2nQ98=
X-Gm-Gg: AY/fxX6B/fhV9kzTkfpnXtrQ1lNmr6tKRQv9C/3ZYTR7+lLmENFw7y8t3/I0Ocxh8t7
 e9oZDbq946BCSYfQHL1uR55Tt4K/jRkpDs3FQmUeCJ8ENUpSfjIa673I2aLMQY0O4n71mdOs/t3
 fqfJoSLdu1/drFAOUmPXB4GCDJaHdwFeajjRF+5e8DPcD7Q+enKQBr1wVXQjopI97fJzG79t0xw
 /XI3CU9zKYV0qCpH+WKYU8NVmvK26/4/OM+tyUXVvSoOid0oDt4BbpAfqJd6QIoPPdKPZX9F0yZ
 ga9L/OhSOOwBxkeUS7U0tR9gnBU8cAaM5aacIMsutzwgZP0clV1dlJEo49Ei7pP6eYsYxPbj5Wi
 u3hCkBuM4DAPXMXDoyFKDMMkalGr7lbISGFZ9uIWiz+r2MHm5SCTqxPpHDpgXhLGwJHG08p7ctH
 tPSuUjPaO8f6xyFMkKEUbi8b3nkQHDzgxo6HF8ZK0hUH25n/stbmq3ml1qqx9J
X-Google-Smtp-Source: AGHT+IE+CJSEODH1g3APyCBaU1V1el1ZLFakGo4E8/IzbMrjK9z6vYXUCTiGCc3hcMulicz2Ve4+yA==
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47d84b41007mr232428555e9.36.1768258511116; 
 Mon, 12 Jan 2026 14:55:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda45ad38sm992145e9.14.2026.01.12.14.55.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/61] target/sparc: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
Date: Mon, 12 Jan 2026 23:48:49 +0100
Message-ID: <20260112224857.42068-55-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Since SPARC instructions are always stored in big-endian order,
replace MO_TE -> MO_BE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162642.90857-8-philmd@linaro.org>
---
 target/sparc/int32_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index b29f693a6bf..d6bb3fa1e54 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -149,9 +149,11 @@ void sparc_cpu_do_interrupt(CPUState *cs)
          * mimic delayed trap delivery as if by the subsequent insn.
          */
         if (!env->fsr_qne) {
+            MemOpIdx oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+
             env->fsr_qne = FSR_QNE;
             env->fq.s.addr = env->pc;
-            env->fq.s.insn = cpu_ldl_code(env, env->pc);
+            env->fq.s.insn = cpu_ldl_code_mmu(env, env->pc, oi, 0);
         }
         env->pc = env->npc;
         env->npc = env->npc + 4;
-- 
2.52.0


