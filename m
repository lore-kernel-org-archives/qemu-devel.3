Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF256D12D76
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoNH-0007pJ-Dc; Wed, 03 Dec 2025 10:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoNE-0007nw-N1
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoNC-0008VS-T1
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e2e50c233so1934796f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764774149; x=1765378949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkG5v3AENvm5Ae7INCJPAnzf0yy0HMD9Q1n1KQfx2eA=;
 b=CxJaJR8yf1l/C8ntoD8/kp1PrAUsGJzLASxf1MC+pYauebBSrMOJuv+1/ovWnC2paY
 7vJOyyv9dqdYdYP7IIs0lf4gr5tEaFZ9OB+KDDkeh9PwZU2SGaTXR2YLHz3SKluCgug7
 TPtwOpAFPjjja+nThLrfpfXQSsaw0l+6YaeMhJAsy2AwHHKJQRUOeZr5TOHYe1aP+aru
 PiV+lbquF7Wn8ACJsTh2cvb204kphSjKWEC9kUmjBYMvNf1qfYoT68cFJ+jutDJhuOlI
 ga3qFgmNrL4U8J+6l0qHWAR+EdJbcRVNMm7888Gx2xiXip3fvXOIQkqjZuJjO+Cogyq6
 Gh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764774149; x=1765378949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QkG5v3AENvm5Ae7INCJPAnzf0yy0HMD9Q1n1KQfx2eA=;
 b=wrICo33QAecUJ8BM+EsSz8Izj/05gS4VvyUGDjlZOtv5OWURbY7BWFvz3pXKSu6jdv
 mSiUcfvxvz+1e3UIWn/qKxHhWM4QfJgPyVkJwUGn1Lyv7CR1Ue/jDb8ttEVsdZgp4GOJ
 LSs9OYqTJlJidPIM25khpkQF4cvNhF1JkRQmMAuixF8d2xMEw08jEXKEBnc76ocax19h
 bs82h1dLHTWTlekVJL9LO5N9IvrSuG4WfZNS0x2sTurFtrZIcKgGJSzt+6dnCm80/0jt
 t/ERzI4eSQbz7yj710EFTWBVdMh5ts7RlEkbq9p21kki5y/wJlkvQ7tx93ijYbDojnDE
 A7ZA==
X-Gm-Message-State: AOJu0YxUi4NRQ1KWwcaXzNozwk3+XWOyQn+y7kOtgzGWHKjml8AyngeY
 qjKgQ67QSBmbVCxI7eMlE8Jmzh2KRi7z28x2/QVfmeD5SiIGa3YCkPb48guIYyb8B4FpEwcDkf2
 PUnUO8Wg=
X-Gm-Gg: ASbGncsp/A+y0ugCj9veblsYnlw5gB1eUXRofW7ce3SQXg1RdeRPUi07rToE4ypgGgr
 Er4oKl9aKANeLAIGoR8H0Mu3nOsyBBFBm7URkVO+0sE81Loiqdg/qf6j1KxYjmB6vZKmTDHHG7A
 FWRN+8qGL+zHmtffq3yxrIBds2ykIWYZCp7KAZdpu6ZvEqVoSjDv+jEGqtONpN9t4ku7Pmb6zgm
 Xmi6Fime88nei5y+e7ZFo9+otjHWaeEzUs936qQVkerWNYKvS3mETmKjKHoX1s6LlLQU+r7XdwG
 ou4jTI7Br1S94OaJYj1o6NyzFK+SuP27LseRCoO4bhEbjHD4XmetAyHoQNmarmGioi1fK4Gy4Ql
 7cCZmwDKJOPotbPCR1hvipnbocFzWhpESXp9fLZCI7r5G+29gyDrw6vulGXPz+JqNQCRC3cbTx5
 6WcWCrSxlgNOgcqPjWdvtYXFQA8XOBpNCxD63tByMmnS3fDvzL2Xdi0LAeR9s6
X-Google-Smtp-Source: AGHT+IFov2FT896JUCndlpK8QijyNvuSVEQyhOZClcJvtOvur4qUiN5Ev5YOMp6KuelAlbNlGZZIzQ==
X-Received: by 2002:a5d:588e:0:b0:42b:411b:e476 with SMTP id
 ffacd0b85a97d-42f73171f8dmr2876513f8f.9.1764774148389; 
 Wed, 03 Dec 2025 07:02:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3041sm37064505f8f.6.2025.12.03.07.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 07:02:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/3] tcg/tci: Move maybe_{extend,
 free}_addr64() functions around
Date: Wed,  3 Dec 2025 16:02:11 +0100
Message-ID: <20251203150212.66098-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203150212.66098-1-philmd@linaro.org>
References: <20251203150212.66098-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

In order to make the next commit slightly easier to review,
move maybe_extend_addr64() and maybe_free_addr64() around.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op-ldst.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 67c15fd4d0d..50bb6853f6c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -135,6 +135,16 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
+{
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
+        return a64;
+    }
+    return temp_tcgv_i64(addr);
+}
+
 /* Only required for loads, where value might overlap addr. */
 static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
 {
@@ -153,6 +163,13 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
     return NULL;
 }
 
+static void maybe_free_addr64(TCGv_i64 a64)
+{
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        tcg_temp_free_i64(a64);
+    }
+}
+
 #ifdef CONFIG_PLUGIN
 static void
 plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
@@ -508,23 +525,6 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     ret[1] = mop_2;
 }
 
-static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
-{
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
-        return a64;
-    }
-    return temp_tcgv_i64(addr);
-}
-
-static void maybe_free_addr64(TCGv_i64 a64)
-{
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        tcg_temp_free_i64(a64);
-    }
-}
-
 static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                                      TCGArg idx, MemOp memop)
 {
-- 
2.51.0


