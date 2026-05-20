Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BBDCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYn-0002pA-Kq; Wed, 20 May 2026 15:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYZ-00027U-M5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYV-0002Yw-IL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso70066945e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305170; x=1779909970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vT462afn82wNhErHYgh3JzlrG5paUe6twTvvhdpnxCU=;
 b=IvcdM5TMpIee1PnFTpUWZ3D6kTNW+AvsDG2T1pEuF0k1136+4ye+0TL3LNmKzAnPt1
 6lToHO2ramJEAIlHb6LGX5XW5QPpWBn1NY//46up75AbQ+Fj9TfEff+VdeXeQ0qPdicM
 tHarFzpHMfm3R7TIV6jjj6euUAXgiuLLV8JrAYXEwQEgFuy1WKhzkxv119bLKS6wiuFh
 +HepVcn3wELoT5rHXUsLWPm8KxW6BU0/PMTb/0PXbwBoJ8n0P1Wm4UIKdwT5UoD6UksQ
 pIRl9nLNxMNjRlflaABrW9QLQKMmtkgwTgw5HUZkkIt5O/tFB5JqVDK5gwNem575uSIl
 anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305170; x=1779909970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vT462afn82wNhErHYgh3JzlrG5paUe6twTvvhdpnxCU=;
 b=ce7Qad9H1zJpGsjKYWv45fhvmJzDZh4xHvUzHki8I6cVlK7MUj7jB1UDN6mtvmOE8Y
 qqNyQd1kG8to0ccgAApsXR3z/mzq9obBr2EuKWddoJmjhoWBNbzdajXRg3JydVBMRzCe
 tBuP6uhCBkw+i+vv1HgqF0JCEdCvsNN/8f7f/66peW1wVWr8fZWFSeYeKOJrN5kCOnMh
 lqwS/3JpqTq7r28w1sQ7xbX0U62T1T9Uscm4iRW4BIHI+j4BIFdYe1JC7YepJPSG/kIK
 GFyfPYTeID+qf+ay+CsDY6tdn0cjcLCHIOzNNqGfWqSxmvoo+tfu9W5Wpn/7JyU2HJkC
 QxFg==
X-Gm-Message-State: AOJu0Yw0ZsSnh47sx0qi1fiq5XoHeMDmwMOHtNj3Po9gAa9/zK6BddOa
 mwqFPcu7odMkAuUJDNAiM5RAyYVdgnIGkZe9nTFsBLZh5mFUGCd6lV+kO3F+TdA0JoXdAdlEU4f
 av/OnsOM=
X-Gm-Gg: Acq92OEcEKDPgPrWM12YVLQBjQfHYuzE0qXOeg4yqJ/4gaftZG7+zXlyNx51pYWJYn6
 uQD3tcuI7FDIzr+yFC52tN/kpNFQOjdx8pgHYXHCiG4qMVbH1+qoJkUiY87otALNQJsn3oUQ//i
 oSNRdXFEX4OPed21hQjSqG4cWEyrUB8HEb6REWO9UCQrXp0sOYF59Hc1B9oO57z/KN7HijX/R5q
 YetP/9M74bZ5l6SEsUQdQG1PXOxGR2RUdmUkUniyIHnxdsLRGO3TERbmKn4nrH4Pe41SLYlMPqj
 gMW33HpjgezuBSpvgeD/d76useIUstg7LjBEPRzrmcr2EheLI9IRYdUXcOO08mhR3X5pqCWUjwQ
 jo1Y/iP3xEFCFfYQTk4iMUg2Zuav/ip/RsvEsqOCLRSq0EzWT4USKXFM5PoDftHK9cUs113cYvg
 FE0KXDnuVnySGnk/r592D64HPa58tdGvQMXFXWGEztlbSNt2LkZwkiFQtmcGiJqVKELsdMRbYz
X-Received: by 2002:a05:600c:34c3:b0:48f:d0f7:78f1 with SMTP id
 5b1f17b1804b1-48fe60e4e27mr411195505e9.4.1779305169636; 
 Wed, 20 May 2026 12:26:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d4ad9bsm11053775e9.8.2026.05.20.12.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/33] target/mips: add Octeon SAA instruction
Date: Wed, 20 May 2026 21:23:26 +0200
Message-ID: <20260520192338.40036-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
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

From: James Hilliard <james.hilliard1@gmail.com>

SAA atomically adds rt to the naturally aligned 32-bit word at base and
discards the old memory value.

Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
The MemOp selects the word or doubleword transaction size.  QEMU only has
one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
instruction feature bucket instead of adding a finer-grained Octeon+
feature bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-14-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index db7d5f55f0a..d6b241de421 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,10 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&saa         base rt
+@saa         ...... base:5 rt:5 ................ &saa
+SAA          011100 ..... ..... 00000 00000 011000 @saa
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 401c4bd14bb..33b45611f20 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -168,3 +168,18 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->rt);
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_32);
-- 
2.53.0


