Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92496CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcya-0003oZ-D6; Fri, 21 Nov 2025 21:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMc7P-00056E-Kc
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:08:51 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMc7F-000403-3c
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:08:48 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b735b7326e5so632950066b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763773698; x=1764378498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSqacx8J6/zgtlp2PptQ1lYmcrsegZl83a7tVHbquyY=;
 b=PMBG1EX8lEomnpRnx2+EoHi6IquUJW0C4tUYBmTO0rRiHsZnEBd3btlZ5DYfJFUQCG
 DiRpNkVIS4vrsQLTZfCQDMhw/MGzqagGgtOne+pCHJrgMi3Lm2ZZmvCA1ifznu+kuYod
 vq+qHLvhdVhTqiFPUXnGmE1SKZnjW2gpAU8BvFdNm4pTqjKmUBc56glnuqSeY0+OUXGr
 myElEdIdkwGeSV9yDkdvmdBwLV0rw8/kSibozLVW/lv0r1Bjqh8xNYFICdH5cKnxZCA6
 g91FcfbEARERatp3TmKt8p9IXtjGkz5MSE8ccJ0EFFLfgYu+5Ds5sYmlqcnqFBg4/WZM
 6New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763773698; x=1764378498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dSqacx8J6/zgtlp2PptQ1lYmcrsegZl83a7tVHbquyY=;
 b=Wz5J5bmI5OFrEkPvDnno4SkZvM1/WJjZg7K9m3f1LfPezFUdjL7oH+gYj02WuFrNNu
 1gmhSmhqEPVxVfQaCE7Rb1s47OouAvI5cAaJFEO+qYgg6g3R7+poexKLh6YuEgQgMuyJ
 4jGltLLF4+otxQ6Az/YCNcvtrxSYbNA4FptBpbBPXNa15uxvUiV//bHSgP5ZkVRX3Dh3
 0+P+Zbwyjkp1lrQlJC3sOQf+MBSWmSXw57jfu6uNCIusE2P3XbJo+O1UtnfKPivYBhrM
 usx1/c2pBPIog1yGM4Cus0HuTBBGAc6YCkgsEhL53Dsem8NUU4D4DDzKDrLulmwYVYSt
 Fctg==
X-Gm-Message-State: AOJu0YxST1e0rc3PYh49ePol5SeRb+Aam+YZf1bwcH4D7eixCHJxolF6
 JyyfU6Ks1Wf7eKoDLUTEMO3MBQurECFhSourIbViY/JCgQU452/othLlFvAEPKc2QOcObVRjYvd
 7JEy6gydMMg==
X-Gm-Gg: ASbGnct5QNQo5u7c8y8CPajKjUXViXDksLQOqGhm37CF1X68IpNNen+SLVi59YdvOXe
 ORj9xOY0MonMaTfuqCenvgvsvhPMTXlX0jUtKNCdzO9KFZODMeOjuLgHLjxCT+E9quoDctTvXcT
 sTFe6MnoJZlil3jbskmHqvSfsAvMwqGzgbih0d9DSpI2iAK1lqvnNLE9VBANm1sQIT2Ox20fano
 vA2D/PW7Ft9qxgC/KlF2iNdRe87zAO68qJseP3cvKEoJExkWHdCPAmWjmHAw5ZQMQKw//6fE0Sk
 758LFdzRUqcxLOpcbfAp0x7/YDHYACgLTysHw4DDp9DcvDa/sf4ubBe2BSw5HmfkwmjuTt0KKdk
 QzY3H72oFgBcY0ccZKsGuM1nYR8JPfPjcTGOBBB3xSzig1cQp+GuCluxNc0ny9RnxbpWgv+dwHs
 YexrEYhntNY7PtHvkoq5KuAiHcZp+CnKoJ1EYMsTeKLigTeqOb/Y2fkrv3wska
X-Google-Smtp-Source: AGHT+IG2LBpzN/7MutT6FD1rJI5Vj5/7zy760hif3q1afu5JBf0/MDhD9wPBUQFy3NBz/75gXvtlLA==
X-Received: by 2002:a05:600c:35c6:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-477c0513e47mr31299105e9.12.1763732739098; 
 Fri, 21 Nov 2025 05:45:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9deb126sm84952915e9.9.2025.11.21.05.45.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 05/21] target/s390x: Use big-endian variant of
 cpu_ld{uw, l}_code()
Date: Fri, 21 Nov 2025 14:44:47 +0100
Message-ID: <20251121134503.30914-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

S390x instructions are always stored in big-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 24675fc818d..84d901c2008 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2437,7 +2437,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
-    insn = cpu_lduw_code(env, addr);
+    insn = cpu_lduw_be_code(env, addr);
     opc = insn >> 8;
 
     /* Or in the contents of R1[56:63].  */
@@ -2449,10 +2449,10 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     case 2:
         break;
     case 4:
-        insn |= (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
+        insn |= (uint64_t)cpu_lduw_be_code(env, addr + 2) << 32;
         break;
     case 6:
-        insn |= (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
+        insn |= (uint64_t)(uint32_t)cpu_ldl_be_code(env, addr + 2) << 16;
         break;
     default:
         g_assert_not_reached();
-- 
2.51.0


