Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1339E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1NZ-0005Le-Ho; Mon, 02 Feb 2026 16:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mj-000540-OO
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mf-0007PZ-7W
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso29520805e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067292; x=1770672092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LmvCGcAGM0gORFw9X5FQy4jvuraTKYHzRY/pBkM5xMg=;
 b=KBdrCYzE3ziN1c9GVxYC+PRNu1jMP0jTUTZa7Kh45fnWwnI7I8qrqGLXEyue6Rjhk9
 PDSM8RekXUBu8f/Visfr+aPA0F3NUTl/BnaXI8lR0q/0hSRCvc7dIlRE72X+KjHf5lfH
 M3WFdNbmS7iSb92QETt/R8DshbwA69MC8xa4IgUjADOgQoYNx0lvMJDeleOGENbA0bRw
 vxyLLkCwUrEqPBjLtJUHbH+Cr+Zo2FnaJcfjB+bNV3Y6/CDSZ3Ly1Kgeu4WMKXh76F8/
 3+OULVHJR1zUK7CtWpzwwWjpZL05Y4+42OV4eLmDCq1LQHpFrbifWaMVch6FOPzJhgD/
 uRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067292; x=1770672092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LmvCGcAGM0gORFw9X5FQy4jvuraTKYHzRY/pBkM5xMg=;
 b=vU0lYVQk5D83JsF6xKQyYNKkgHI4IPayU/wx58y9mei39LIba2JWwuyjn4Ib6Y25Bm
 4pM1wxod0LJkD4XS7b4H0uH3oWO2NlZ9tbBA/4irYjH3DqRc0GTXbVh8qSKhR0BukEaS
 2vNNhPjrNIFQONAkeLnkVEyvskzHfKylboNfLgL8ccD/g90/eNAMVu+rHIAw1RLpzqRh
 +SshSNK3uqiBrTPHN6Nn1y/ty/wLX2CBQD3cr3CBNoMwQztCxIpUtfwv3IOUt12iLaiG
 kDETBg5weQmesA1g3CWRrAC3tmy9ltKTi1Klvcm5TZ/xb0rJYcOy/2K0Mp3qvaqHT/az
 IVEA==
X-Gm-Message-State: AOJu0YzrsvbL34foJZL/JA+dQCmZgfKDCo1emG+dJZx/jj8iKvDSQMVN
 AMI3CReSUO9dD71VqeFtgANDMDaLbg1RFdyEdoZDyuqxg9y4bPDUg7XAzNFCNqO9s7FZIVHCWa1
 M9jQZdLU=
X-Gm-Gg: AZuq6aKdsSdWB0dUkizaN7pv85Sh0FYsgPqclNyanfxkwiix06/uu96VFGjvR6EJqqu
 SbKlot+kmqb3ejWdzje8UeSEcY7H0vMSPAT36JkPNLQz3tElm4hACh+BCbNjGi+t3sRVNCtyanY
 mpGevHt2uTmpay2qINnbDa1PKZXM5WgWg9bYwdd16x8MGMAbIQHHx/CcI3vR031UhyFHSKy5vi6
 SOqJr2vhDAQI1986qtU/VrU1vX5G5c/0z6sa504wqeLhK1Xszzg5po8aU8EGyb6JsmeXzgYwRfY
 37RyKC2d8s0y9wZVLhWTD5IFuPE6oZSS/+XLkBlbnm6V5BminfioofU3/Xzw56oI12ul8Jgyc+p
 S0aULUceVZXtWZJ7TnFWPg8tJekmdEq8HERq3OSVqm+Q6Mk2Ofp3ZePWp0H8QQOvikM9ioMfAiB
 L/Q4O17xyXBBx6WpSkpig9fWD758fS1a+GuCta5Eno05FlSB8ZgotKEAt/qZDQ
X-Received: by 2002:a05:600c:474f:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-482db452587mr167665915e9.9.1770067291887; 
 Mon, 02 Feb 2026 13:21:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051287cfsm25192125e9.6.2026.02.02.13.21.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
Date: Mon,  2 Feb 2026 22:20:13 +0100
Message-ID: <20260202212019.94205-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Jim Shu <jim.shu@sifive.com>

To let io_prepare() function use the multiple members in
CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
member as the argument.

It is the preliminary patch of next commit.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Burton <mburton@qti.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260128152348.2095427-2-jim.shu@sifive.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6900a126827..82c9b6389dc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1270,14 +1270,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 }
 
 static MemoryRegionSection *
-io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
+io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
 {
     MemoryRegionSection *section;
     hwaddr mr_offset;
 
-    section = iotlb_to_section(cpu, xlat, attrs);
-    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
+    section = iotlb_to_section(cpu, full->xlat_section, attrs);
+    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
@@ -1981,7 +1981,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2002,7 +2002,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2499,7 +2499,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2519,7 +2519,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
-- 
2.52.0


