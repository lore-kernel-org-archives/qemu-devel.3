Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B574FE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRcF-0001Y2-6e; Wed, 24 Dec 2025 11:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRcA-0001TE-P5
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRc8-0002fO-J8
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so61815245e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593287; x=1767198087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQFPRjUrrXt2sSJ1PtyDeGafuwwfm9FL+376XlDkJuw=;
 b=Ae3YlTSbToUQJiWiyaGyHQMjKIaz+CL7k0sW+0n9C0iYzSlgn6FXb9qhbK3a79vaF6
 fK2LUMjpZWyfMfgR8L0MGQ24k9IbfnvrMAnQlKKaO72HbMwdCj3P8tmdUN5MjIMFYSix
 dT9HlpKAQ38vjVPO05CGGKd2+gzod66as87pI9u9O/MXXqsYcAH+1aiUXIKtWITOmx7d
 IaMEWEOnK99KjYq7lXGZPJDEh18wblslyuKAglKRGwuCJ8pk9kz4iEA0GyOeFU7grIvF
 qdejOuG0rePscHnws7fRRn9eiB4BgWrCnv9RiU1oB4K6brR93BMqfd/yKLK2uKo/GZCJ
 ttcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593287; x=1767198087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BQFPRjUrrXt2sSJ1PtyDeGafuwwfm9FL+376XlDkJuw=;
 b=GF7qMtrpjcHQPy2MWKD1UWkI/OMBGRorG3X9qV7hWlxQdj1bNgXkCXkLI100vXyTMQ
 /iB56JtQgBMcQxOqNN5NZf8aMKDEkOz2nggPMOle45FssWKclvnZNl2iFYGTe3/mcbQU
 hgpWL1Rc/RdzmI8fxdyJgtqqinyudUA45R2nl8ulMEJtDRnXq8KDhgf/tP8F3B50UEFZ
 T9qsCUrk56P2blWk3WaKPBe5UbTM6WOZqnlR+xMNneV/+O8m6QEh4GmuVdK4k3VjNDAg
 DV3fZMqyGvKZJF9P4xaZn3N6GfnJSAb+f5X55YWp2yRYLLBwWzA4ESc+BeBqFjWIqDJd
 4fDw==
X-Gm-Message-State: AOJu0YxZ+H0I3sqxMbtxx1BtD7cXHQ7AQDBzDszAlv7JdH9+SnCPqGpO
 ZHWlDrKZ0KYQKvN546/n24BkxpO6izRt/DMbXrnclMx7rj5AfXMzhxHZf/+JE5OULnTroQHI5Zi
 GoytRAaM=
X-Gm-Gg: AY/fxX6zaLItwVFGdbg8a4Nm2wXCEMKKk5GpkjROcAnCxXnuDRJ37ciP5OFvdgZ10Ju
 u3/Pif4IMyp0xtSJFrQfX3blJdXWftaWy0mtI9VLc/BWpzQVFLAHukBmxMvqiByRh7ENXDGAz93
 I0KOvyyrcoTEryMJyAvTuB1+l6bG4Dir72JN9CV+PWMCynYg4y1wmrl7t2Xbo/6PQMW8rn+Ubps
 ptj1synUH3Zz1iMCpDJ6n/NILebayH2C5yVNbMH2eGy4WjyL4gELPBd9of5UVSThwRxAsSv9RQD
 TxrPLgnSb/p8PZ07yuzcTlTtlZM575gNpkUXPJNge+WZUN7lg9QumCfimzZm1XHK+pZ8Ih+uV0C
 WoatJK89mrnaYxR4hvYspWca3l5k9EYDKaZlJUn0WNql/IZoomuXBFYk+tX/67JgcTl7cfPJYsP
 28JBzvpnK2JTq5lHZdMWU2tgy7rlZcmmONicq4kgwAZjpZmEfZMEQkn9K41lEnTY53aQ==
X-Google-Smtp-Source: AGHT+IGq7EHofwN4kLvCqn7kz/ULBsFCWQoopp9Y4j4B7btKx3NhCprWVW/OUXloMFLIwXBoW0yXoA==
X-Received: by 2002:a05:600c:470e:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-47d19549856mr191292255e9.9.1766593286602; 
 Wed, 24 Dec 2025 08:21:26 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a7b687sm147648155e9.6.2025.12.24.08.21.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:21:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/s390x: Inline cpu_ld{uw,
 l}_code() calls in EX opcode helper
Date: Wed, 24 Dec 2025 17:20:32 +0100
Message-ID: <20251224162036.90404-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

In preparation of removing the cpu_lduw_code() and cpu_ldl_code()
wrappers, inline them.

Since S390x instructions are always stored in big-endian order,
replace MO_TE -> MO_BE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 507eb7feac7..ce9ced8275f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2430,15 +2430,18 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
 */
 void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
 {
+    CPUState *cs = env_cpu(env);
     uint64_t insn;
     uint8_t opc;
+    MemOpIdx oi;
 
     /* EXECUTE targets must be at even addresses.  */
     if (addr & 1) {
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
-    insn = cpu_lduw_code(env, addr);
+    oi = make_memop_idx(MO_BEUW, cpu_mmu_index(cs, true));
+    insn = cpu_ldw_code_mmu(env, addr, oi, 0);
     opc = insn >> 8;
 
     /* Or in the contents of R1[56:63].  */
@@ -2450,10 +2453,11 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     case 2:
         break;
     case 4:
-        insn |= (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
+        insn |= (uint64_t)cpu_ldw_code_mmu(env, addr + 2, oi, 0) << 32;
         break;
     case 6:
-        insn |= (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
+        oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+        insn |= (uint64_t)(uint32_t)cpu_ldl_code_mmu(env, addr + 2, oi, 0) << 16;
         break;
     default:
         g_assert_not_reached();
-- 
2.52.0


