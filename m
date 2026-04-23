Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8AEF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxE-0003pK-Po; Thu, 23 Apr 2026 06:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxC-0003Zs-40
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqx7-0003vH-01
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso58798405e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938789; x=1777543589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmMMDDayaPVt7OLJ+0hEHgEDaFx6/LPi13R0NCJedJY=;
 b=CWOks+b1Geu7IjXWAOjkTE7KewUCmBlu8qdBoV0t9zLGu88gd/VoFZp8LZBWzrqo9B
 NhVOutWY+mIjxQg4kF4O0kw6mrE0bc0IQ9SdtOfhireuBow2aUNT9UKIR5OvhlH3mQPj
 4qBUhNEb1byz1dKC2PDX8rOhLr6G4CpmdwJVg5R9KN0Q+avlQuUa1qj1L/QqjVioTNtF
 Yh+nLn/e/dJ+oujLTlX6evoHNnNp0ikDdChTvYjPbZrnyZpvUlvkNgVxqAeouJbWSGXv
 e6SG4MA7ks1BfWyhaqGrnr1697T9QF5N64BInQW0DIjUEpI/FMmdvr/ARKrnPKGzjCwS
 oQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938789; x=1777543589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NmMMDDayaPVt7OLJ+0hEHgEDaFx6/LPi13R0NCJedJY=;
 b=XUM2wJ8WTcs2OYW6s+pDqaOfoDaNb8L8tb81N5ue13b/IvXZCOu7fHcPVJ5hsJMiST
 VjJblLXb0jUp/ZIv1MbmfiGVFfoBNUbDqXEecDlQ10Wc0VH/8CG6C381WZp04BE53j/c
 VSEB1MjZN14xKQ5pwifFFb2fVTQh05dzZ5oWqupXI0KPuv/bB4rcONwBl/eiOFbpwc33
 3t1h11kY729fLbD42wVpQzS/HbMC/z/SruI1YZnm8OYpae6MyXPjPI31zk8KZwe4VSEY
 iyH9kU81trPlwtos+kIe+uDAH6MOiAlzgf8cP5EgnhV8DKFyNzVJi39R5e/OBsd/mcge
 8TEQ==
X-Gm-Message-State: AOJu0YyLLrNULij1kup3ukrNOFNUF7wXsKAcYeFDIyzuEFs69cAD8dtY
 WrFV37V9Sf1GeVEosfeYvO42gHOFbsIK9Bdj5tCOPGx9srsN3DKAmy7MznUVlSP/k1I2lKUsDJZ
 c0toIgNk=
X-Gm-Gg: AeBDieumr3idPLMt0fVxzxXmm6hEIe0RRhFq1kIO751VxU1eUL6jVhQHGYEHCAHtqD+
 D0eD62+xe/fHAayr3glI/PxU5jUC7jxXYqpidpz2pdOjBKw7KGC46Eyq5MLmAx2o3W+pyTOFg5e
 1ddoOkB55oJ+Z/hcGGvmkcQ719R0rjIMUZ6TvD3wtZgTiux3+LPX0SPiMBkvZGBo1gwoqiGZqvk
 d3RD1RK1POrorhFtFXJ8KyLZ31ybxJ2n+O8mO46B1EyCXadaSWPpRcsGAcr91Pq3YrumD2l7Rmq
 1WRKRX9rRN+ok2rFKW54q66/lHW1wldBZGxLqMoVJ65ZbEs18eP/4wBtrUSZDK+0zK+qa4dD81u
 nYp5qw1Y8w+ehp5LnWZ044h11W502pf+lk8mv5OZi+cjGbqmuvHKNeEG7B/thGMDqddnj8enHL6
 NFqTAUjbesUHlV4NyRL2Q69ByXOKcqCcHOS5jMUxWUkW61uvk6GnJKsdZBrRwIiLOnadEz99zGd
 VVhaTTSJ3M=
X-Received: by 2002:a05:600c:1e28:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-488fb77fbf3mr374208715e9.20.1776938788818; 
 Thu, 23 Apr 2026 03:06:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm414784785e9.3.2026.04.23.03.06.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/9] target/microblaze: Fix endianness used to disassemble
Date: Thu, 23 Apr 2026 12:06:05 +0200
Message-ID: <20260423100612.27278-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

MicroBlaze CPU model has a "little-endian" property, pointing to
the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
Explicit CPU endianness") took care of having all MicroBlaze
boards with an explicit default endianness (similarly with
commit 91fc6d8101d for linux-user binaries), so later commit
415aae543ed ("target/microblaze: Consider endianness while
translating code") could infer the endianness at runtime from
the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
definition. Doing so, we forgot to propagate that runtime change
to the disassemble_info structure. Do it now to display the
opcodes in correct endianness order.

Cc: qemu-stable@nongnu.org
Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ec513ae82d4..639f46b525e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -237,8 +237,8 @@ static void mb_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
-    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
-                                     : BFD_ENDIAN_LITTLE;
+    info->endian = MICROBLAZE_CPU(cpu)->cfg.endi ? BFD_ENDIAN_LITTLE
+                                                 : BFD_ENDIAN_BIG;
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.53.0


