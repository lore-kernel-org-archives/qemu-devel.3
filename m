Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F010CA1014
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uto58-0002yb-J7; Wed, 03 Sep 2025 10:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uto57-0002xX-80
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:03:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uto55-0005sJ-LA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:03:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-244580523a0so67464925ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756908202; x=1757513002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wUrao0n4nWdP54HC/h+jX0z4mz8Yg3JgSDps2JrXvY=;
 b=MEWx/sNdAuQkw2AlyUCJ6AbxOd+fiGr2HmmU25Qc8YS77GRnz/syQHMIzUUx0bO4/V
 KWf6Ke+9glzih/aYj1y59NOUsDc7yMdYuG0ocpoVC5n4lGvnQqtssBXG5TKzOmBXeLQn
 np84Ivzs+H2HtfBUZ9mioOjMQxOdttVguX/EA2t6Anw0M6FaXGDxVPW+t20rH0amGJGM
 YHm5lt/N5PCI2/ewkC/l/eMVg05ovw7RoFgJuMbt9aP93pGMsDm5e+Z9lzcgwZIo+NtP
 ZMEktVu013eepn3kQyOEFTDB0UarZAyf4OTwFCjR6blF4D1cQehSbQF1t9pdGabU6UHJ
 zOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756908202; x=1757513002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wUrao0n4nWdP54HC/h+jX0z4mz8Yg3JgSDps2JrXvY=;
 b=Q97YddsMBJQemQEARlU4jOFnoElD9xhf0fcLmonqTTj5MaTKhT6G3oWppeSitMpkKJ
 qEVPGMdYGx8Hkn9tRgFrGShdik198q0D6Je5pFf2FSALPe6Hs5z9XfNWbh7RtU2Z6rTd
 XjkLAFzWoIGyBAVqtfIVA7tJUq0J16SS0R6ds3LBxqPzxOWJxTkoFIcyYHpTf/9rLoEb
 95lkoL4yqQ9uwrrQeDGeHd2YqsKt4GbaRHhPKMDqtLMmRuGXhuOrMY6dZ8KvMowb+aM+
 5Ya6Hkwlg/fygpxTmCUhbeHVCdDFXNCZ6vFY6nz8qtcnQKrn0U3ScWGvbsRKfMVVrRmY
 uRSA==
X-Gm-Message-State: AOJu0YzAox/aij8drGjmy76vYZagl3IWqHwP1NeXU+R44w3Tngiwd9eo
 cQNeFbh6XUTVV8r8DBcKI8Svu6O5DhWMy0+5d67XWnQQhPiotUYkEYof6VsLBoJ6fn994gkGruN
 z4Vliuhistk2blTRJgQC5AiyJdRhV64psFHHCDE9tv3Bv7aCAHa+6CPOcUNTvsYEojj8bUYIuLS
 VypR45sWzKBwW83o6qnyO6z8x9MqZ/lCNvYjqzZ8+iig==
X-Gm-Gg: ASbGncvX8njF7BTAhQ5RAuYD4GRnKvZaBlWw83jhoVjPH1wxc8lSklaXd7aGhAo35R9
 xJ18FO8QKLlkt9ExU9YeD2d74q/dgE5tmuQ6F9F4AP72CDW5tgO1wtt+SU51ShLF5eTsSxC7Omp
 Udsg2ZnGbaIyXCKLibQPeX4t3LnwrpL9JU9rWqpThjNRhvgqNNfx8csQrnj+DvDhOxC33o9cNdC
 APmZ29Ivj9tCzPaq2EHDclCqFyCx3IuaRA2JGAvVhIvMf1zyefoALcigaJIKzVX707RJ4r4mMQl
 tkmA/ojnHuxZKO6bVR+13jhsDTGYKkj1sx9V/GUzsqDpaspUyv1ayVRnhCA7fAD53m7wgLMdYb9
 /JYa+iHyERiknvVN8UZZhnlb/Nry/+yvhmpLnjTHoIGIhYLSq/OZuzVBF3flTGHykg1NxOWuGln
 WXqw==
X-Google-Smtp-Source: AGHT+IG2ZyhNpB9r1FV1B6QZe87M11ZRE4OFc1ZE3leV7TaynZ7SalPzrHzB+Gf9cqpDNaHCXPzqqA==
X-Received: by 2002:a17:902:d4d2:b0:245:f7b9:3895 with SMTP id
 d9443c01a7336-249448f8ccemr234753635ad.12.1756908199904; 
 Wed, 03 Sep 2025 07:03:19 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b14e1b097sm50720545ad.21.2025.09.03.07.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 07:03:19 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v3 1/3] target/riscv: Add Zvqdotq cfg property
Date: Wed,  3 Sep 2025 22:03:06 +0800
Message-ID: <20250903140308.1705751-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903140308.1705751-1-max.chou@sifive.com>
References: <20250903140308.1705751-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
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

The Zvqdotq extension is the vector dot-product extension of RISC-V.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..95edd02e68 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -187,6 +187,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
+    ISA_EXT_DATA_ENTRY(zvqdotq, PRIV_VERSION_1_12_0, ext_zvqdotq),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..5da59c22d6 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -100,6 +100,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvqdotq)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb279184..7015370ab0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -767,6 +767,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvqdotq && !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Zvqdotq extension requires V or Zve* extensions");
+        return;
+    }
+
     if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
         error_setg(
             errp,
-- 
2.39.3


