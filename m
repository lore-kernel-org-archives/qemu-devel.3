Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC477CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQi6-00040R-IP; Tue, 16 Jun 2026 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQi4-0003h0-JU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:56 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQi2-0003Yx-R9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:56 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36bcbd7821fso2169511a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604473; x=1782209273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyHSF2KMbSW86nFqhbQ3pWPtxmeW7imEGewRME7P/WA=;
 b=BLaquhJabLqlvetGRlZRimvruaSHc7r0msCkdydwiUxdiDvKjlbJfFuqhuw/jhHSyC
 2yczRmjBZy5XT2+4Dcc7LT0U3z+rf+8iMGBee5W2huFroxtpF1irqD3+vbg5k0Js4nNM
 W1riVzmHqbgjkPBe4JoBOqtUai440y3xRDvkdldVeumuE+Up4c9naj+CQFZaPftZ6LKq
 a39QK2POwv7lxI6ueeaSyIs+ACnIsKz5Dogc900fT7uihVcbL2MwJEIdERK6yflR/6No
 mk9KdY1CwiC+WMUM1XoJ3OGjgXvGhHXZS1wFF2dLupmvYL43vpt5W9Dl6omZZnVQdKH2
 SLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604473; x=1782209273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyHSF2KMbSW86nFqhbQ3pWPtxmeW7imEGewRME7P/WA=;
 b=X9yBtLLi95Q0EZn0yLD/N4LaIjmLJoYmYtKQQPoikNEHI7jzabxKs32WDyZ1k0f+5w
 qsnGsf+LimbradrqJhACVQY0KClLe+nIoqsWtpuU0pXBGy21n5wzqf/wWR96xQJcKadF
 cEPDa3Ya4MTKvkz5MZriDGZMx15CbBUKpzDayso+DlCIyz2sTHy2+hcD+IzHZykltwVy
 RFPEBlXrN4AaIj4cHcMeEZOKzfj3lBqUOBnKtdgKjgcvY7LJloSEZofPynqe850UMAv1
 EHEv3Z7OCXHcht8JzATVJM/rb3VoKwZ5v2y+k0xC8g6Ny/v5LEfPjtWu68CwlmFUkhG7
 75uA==
X-Gm-Message-State: AOJu0YzGG5vnHuURSm/m5XSygmR6IchREEgdz6l0kLH9LyTIRePYggMy
 lwqvYUUKm9A0qIATid/BzVDNnF10f3g5wGW6bWKC67/fsQ1LF6ZJJ6gqJ5w6AKgE
X-Gm-Gg: Acq92OGqh7hdBJNCcbUN/FkAva3Z+WOqfbazmVzlwhV0rg4IswSRO07Qyte6UF97Jlx
 KNFiE+5jGnhWvzTC8OXkUsuHm7Tvm2aBCfhyTmdCu2vPD1EpxQp6kHeQBr5quXvkz6r1OxMSAPi
 UTN4VUx4sF8lAcfvvRGM5kc1fcrLzgvPpQH3YBQu057HFtGH+vwfMmV8BY+iBgO3LQQndHszNjV
 wiU1JaMicyXxvEw89Z1H4d7xtoIn7Xe51kY+P4N3CNmBqYjDdLDiPw1r73liEgZSzW1Soat/fcD
 irkjC4vzA2JeVovJb2fIAQ3p8WDpS1UX/tX/FGjNXcs2SJULJpc9yy0LY5Ze0mtgmGJA9wM70LO
 UbQoMHtrJEexjKwVj+LvMkAu5onTFtZm6kGszywCyFFZNNAmZUZc4hwsW7j4V4dIASR6+VaYpbS
 W2WSibW2Ws/sl3ml8ZzwrUSVYJi9SMh+w1JDZSoc/J
X-Received: by 2002:a17:90a:2ecc:b0:37c:63fc:b2fb with SMTP id
 98e67ed59e1d1-37c63fcba6fmr463989a91.22.1781604473511; 
 Tue, 16 Jun 2026 03:07:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/83] target/riscv/tcg: disable svnapot if satp_mode < sv39
Date: Tue, 16 Jun 2026 20:04:43 +1000
Message-ID: <20260616100527.1939565-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We did a recent change to disable svpbmt if satp_mode < sv39 that was
discovered via a gitlab report.

This time we don't have an opened bug but the problem is similar: RISC-V
privileged ISA, chapter '"Svnapot" Extension for NAPOT Translation
Contiguity, Version 1.0' states:

"The Svnapot extension depends on the Sv39 extension."

Do the same thing with svnapot, including the user warning in case we
try to enable it without the required satp_mode:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
     -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svnapot=on
qemu-system-riscv64: warning: svnapot requires at least satp sv39, current satp mode: none

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260527213034.2094103-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 21886e5d39..7e964e8f1a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -848,6 +848,16 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
                                      riscv_cpu_is_32bit(cpu)));
         }
     }
+
+    if (cpu->cfg.ext_svnapot && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
+        cpu->cfg.ext_svnapot = false;
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svnapot))) {
+            warn_report("svnapot requires at least satp sv39, "
+                        "current satp mode: %s",
+                        satp_mode_str(cpu->cfg.max_satp_mode,
+                                      riscv_cpu_is_32bit(cpu)));
+        }
+    }
 #endif
     /*
      * Disable isa extensions based on priv spec after we
-- 
2.54.0


