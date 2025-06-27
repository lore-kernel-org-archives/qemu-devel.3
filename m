Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3477CC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV91w-0005hm-F8; Fri, 27 Jun 2025 09:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV91t-0005gh-U8
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:22:09 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV91q-0003W5-MP
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:22:09 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234b9dfb842so21798915ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751030525; x=1751635325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HSzhEP9dEzA+7lfjcbU4kZWDFhSDWRTA9w9lKAghg8o=;
 b=d33Idx2JTYPJj10P7dBovoJ5A+i7fLqD/3ky1Pu1dXlQzyQdiyBNoglQxEqriwSuSX
 7Q21vRY9yanVV1TnlJFxLIC09ddtrM3MFbQ/O99LHAVLDGXu/SaAPB9462w7HyQhb/uj
 30hwXFUBwIdS/68RjQqi6znzb9BTzbUmgQeHeEX9EhaQ/09K5Cu0MxWD9PFDcrX0fRx2
 0J07YzLZ3/TuF8d7UxC4M44ie2UINUHEbtZ/miSuhcqZAlA5xJrHO+tHpItpxK14JWGT
 fkQXV8br/yxM993D8qJKDB3b5to1qHjCSq5HZPP8ZEPKS2y0AdNgDMGrBcGJd52nvgPs
 jrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751030525; x=1751635325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSzhEP9dEzA+7lfjcbU4kZWDFhSDWRTA9w9lKAghg8o=;
 b=FPXYmNvdwS+uyMw5yUy+mpAaUkkZwUqzRmwr3tebTFat7itpPTJJ8NJoOWVzbr000p
 miaJ6Z/B4L/KL6f6SpWzEf6tWIGHlYKJVPK/7DkJeSA8xARwLpsUTjG06kQHnLkM60Ma
 Ju0QVAOguoeUduYmkahf5NiS1fR5Al20dO6mAfzxV8Hc3vWC3DwoETTqPGS3OBbFD2Z5
 tK8ju0bWLCy1kJIop+sdDqypgKb8ov+lVOMW7yynXJzkhmjg0yZkBiIJQ2+2QUTEoBtx
 0mXC0+/tkmQbWoXQCJDpRNTlXC3rEX4sHjhzzFj4HZyfMFcwlToKrdCyJAGOnpv0kTvo
 KTWQ==
X-Gm-Message-State: AOJu0YxGYeCHjS0sYJJhzO+VO3HdJf392XS4tDmaXpRQcQuFM5Vp5PZ8
 mMaqNBm33h+bTzf8qTtlIRYQFtuUFV6WAvEJjs53WhUlBsTsHVxbwcDwMZvd/b4keDQKygwj3Io
 hK7pqad9IVlEl9mi1GUtqLvbIYyNaLNDNUqhwC6i0eWyNsKFlJug94A+SH6N1CdQtBiV4dsF8fl
 NzqFutHD2ovEGNlTCmwG4x+L/pA9KknAYfDzS+2uZveQ==
X-Gm-Gg: ASbGnct+Z963+GFxh5u7iFhQgMN1IjKQjTL2McBQtH+GrkxDgMxbp6YCRkmnaJkxKaR
 qX1Sty/Fkrx0AtyK6Oog8iRxaorA9HlwC86m+ZtYOT1v8qS7I24Hko9oI3noLJvVUBJ5eneHtbQ
 YSvJICxf8Cgy/nA25c2VI5nyOJ6SzLuPbp0/3QSi+I6ZbBYsf6qJUVyaZofcIqg9l09/Cn5NOz/
 i06XnArg/CDjHdjla5pIjl2qnOkcfw2pTfmDUBBxdiGpErfR19GCtEhbi0fAFqFbvHpVFeDm4PZ
 iyDRvCHXGlfLgbuUMlERHwZ+uDI/tqD4jQlXuhL+WxA/QhPALuVwN7IWKO8nmiFNw1LaAPRyr9q
 GpDGoVxGqgqNWe+r0X03SyuoyfP6ETmQ=
X-Google-Smtp-Source: AGHT+IHxREoC2veGcD8WiMGg/igBtulwDyefeM2wbbWKscmJnLSnC6qKlLlti17ao9c5gsetlSeRvA==
X-Received: by 2002:a17:902:d58e:b0:235:779:edf0 with SMTP id
 d9443c01a7336-23ac463560amr42025145ad.50.1751030524466; 
 Fri, 27 Jun 2025 06:22:04 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c475bsm16083705ad.212.2025.06.27.06.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:22:04 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH] target/riscv: rvv: Minimum VLEN needs to respect V/Zve
 extensions
Date: Fri, 27 Jun 2025 21:21:56 +0800
Message-ID: <20250627132156.440214-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x634.google.com
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

According to the RISC-V instruction set manual, the minimum VLEN needs
to respect the following extensions:

  Extension     Minimum VLEN
* V             128
* Zve64[d|f|x]   64
* Zve32[f|x]     32

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 163e7ce3642..187534009dd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -416,12 +416,21 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
+    uint32_t min_vlen;
     uint32_t vlen = cfg->vlenb << 3;
 
-    if (vlen > RV_VLEN_MAX || vlen < 128) {
+    if (riscv_has_ext(env, RVV)) {
+        min_vlen = 128;
+    } else if (cfg->ext_zve64x) {
+        min_vlen = 64;
+    } else if (cfg->ext_zve32x) {
+        min_vlen = 32;
+    }
+
+    if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
-                   "in the range [128, %d]", RV_VLEN_MAX);
+                   "in the range [%d, %d]", min_vlen, RV_VLEN_MAX);
         return;
     }
 
-- 
2.43.0


