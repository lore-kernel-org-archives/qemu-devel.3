Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F3CCFD62B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTH6-0000Zl-Tm; Wed, 07 Jan 2026 08:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTH2-0000Rs-Sq
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTH1-0008NV-8t
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:28 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so20601215e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791304; x=1768396104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r471lAfTDSZ91X7dNYg/GCwvgvHUQzpWa5sedZ2e7kw=;
 b=AE2zye6oldubKCtFwotsLOjfRWF416vBzIzA9qfn3F2EqVeWGlsU2FKaXEBO/lgFqT
 063LLqeryLdQQgSGNrTFP8LBleTxM5p0stLUFcy68nK5yQZR1s5MfVsQCHhOJw/TAz5C
 b1BQ0a7Ub9QRkHoHCGzOODFs7fKDhxWVMliIvIrbSM2bPZjMPlFSvPwEsjeyz55B7gNx
 q15u7jGd21X0ejopO1Arliubt+hTswts4Yf39sh4FlRgurhkeS+mDb7+V2EcrCVSBiys
 q4y6SshWISC1j9cCdYQ4/4YjxQerTB336yMdmBvXx3eJyDRAP3oV59QLmszZpGhSjv6G
 i5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791304; x=1768396104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r471lAfTDSZ91X7dNYg/GCwvgvHUQzpWa5sedZ2e7kw=;
 b=Jp8RcxaQlEk9r3Zu2PxhjA6eCVx0CIlqnav1CyervsVxwOJEKk8+2Y93s2L0z0TSQ8
 SGnRTs/Xt1L3DVJkpG5t80JhohXIDcsRQETMk32gSv/5+GCI4/7ijgSKJsrqfOgrz3wQ
 Hk6aIwGSgnTOBFmo+XdRHjkliQtoHhB/0Gkkl7HlQRzAZ8CVCHAzMtiv19GwVN9p4fgh
 f8P4c/2C/bmjUqTTdvQbXS4Vd8dAoF2hVMwGW8AZq2fX1SvrnD1hqOTusucpq1uy41qn
 nzl5iKfGtUglst+wHItJu/AIqEGr4SPPBaJMr4pd+LSNOQsnTNM2j9/Zq2+MMp8RdatS
 3rMg==
X-Gm-Message-State: AOJu0YwRowlQpEhHK0j6XASTXdWINIPz+R/HYKP7bf27Ye8/XdFOkOkJ
 nIrCjRvbvoVxYuEptW2j0PEcZJeI4Oi26gtpl8QuVmc7FjJ1fVCJsDVVxptwFdZcgyas48f+sED
 sUXqbk84=
X-Gm-Gg: AY/fxX6yAiIk9pu6HFyhI1m/5aUtLty3H5v1QTeiVLVHnrBvOAAuxx2mm02/KtGbCzC
 JhL3rYSlc+06MTduOYlKpd9rgzKGmMiigpj9rX9FlB9T2U8GBKrq0QAyfl4Fz9ascMKuNVa9HSA
 Z1Nw18zm345KC9r3bOIYAsp3NRJAbImCk/ZLYCPezIGY/hZ2GO3MoHepfAvg8+1wtI5YtphE8A5
 mlaZbgURd93u5FfFbvg3kNK6W6OTSWlb+gOqfAuGSNbpx+39rGbalucZUW46ksnf6SYr5Uy0vrb
 cqGd2wWrJw/jy7dRKoC8ZqHnomX5RdKbvU9UC+5g1I/FXVE/3optuSHTSzx8ReoJQiZRbIxu+Mg
 5TMGIptht/2vtS3RPvbJa9h2Z7PaPsljjqqwAFPf91byyJIHoXsRW03Foazvh4a0l8HPjgwlQ/L
 hk7QeFtRuFaYmbbXfWJpJOcSv3gs3XhhLjThoE0gq93ZbQ/uYG2ZiIgqI1A7XK
X-Google-Smtp-Source: AGHT+IFTu5k2vopksPZlCcsh5XGMkkD94rOxcfoW9RpZOjoNo+DiCzfx5fh6rQeaN9C/ioNfhNCcQw==
X-Received: by 2002:a05:600c:a317:b0:477:9976:9e1a with SMTP id
 5b1f17b1804b1-47d85bf063cmr19527975e9.6.1767791303723; 
 Wed, 07 Jan 2026 05:08:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d870c73c0sm12290385e9.3.2026.01.07.05.08.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 02/18] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
Date: Wed,  7 Jan 2026 14:07:50 +0100
Message-ID: <20260107130807.69870-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Keep address_space_read/write() API to access blob of memory.
When the access size is known, use the address_space_ld/st()
API which can directly swap endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 026502a3e40..9ee1d778876 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -108,6 +108,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
                                     uint64_t *entry)
 {
     CPUState *cs = env_cpu(env);
+    MemTxResult ret;
 
     /*
      * According to the PoP, these table addresses are "unpredictably real
@@ -116,13 +117,9 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
      *
      * We treat them as absolute addresses and don't wrap them.
      */
-    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
-                                    entry, sizeof(*entry)) !=
-                 MEMTX_OK)) {
-        return false;
-    }
-    *entry = be64_to_cpu(*entry);
-    return true;
+    *entry = address_space_ldl_be(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED, &ret);
+
+    return ret == MEMTX_OK;
 }
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
-- 
2.52.0


