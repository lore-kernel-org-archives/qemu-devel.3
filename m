Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4563AC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6Wo-0003hz-Rc; Tue, 25 Mar 2025 11:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Wm-0003hQ-Fl
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:49:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Wj-0004v2-5h
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:49:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39127512371so3894337f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917755; x=1743522555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cA7Sj8Xho8bkcpSlMx62uWgy6fn6azFGlkA5hKrCWkg=;
 b=E4GVlyKpc8X4Ucw0XN3m46yYm5YvY6Q70fbgMbx8LU+nMHZX7v/4Ji1rrVwRjsEfMG
 iQZdxhuILsTigoEhqPwgzS4bx7RqYwqUHYN70EiGvqHehHoCnRHOywq1MlqR64KxwfW+
 ktBX+43mq+NQeBGydB2Ph95ZARgsyVw/KlSg2DgFhancyd6nYd1WRSCKcQzeqMBin41f
 w67OWyT5+JMu0vjb77WVS0oyMaavxhoniDT6jlg1WG8DsmWruLHg6Xz8kua1CoGhlKrZ
 r7nuy3jnxzuHSlFSe9gsvx6QUsZgRftnIRwmvYJ0mAFstNhco0+CbXo0JumM3Qy2mnNg
 Du6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917755; x=1743522555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cA7Sj8Xho8bkcpSlMx62uWgy6fn6azFGlkA5hKrCWkg=;
 b=sd5EHUBMJFWTgN/b+PBF5doTOYY1x6QPjwLkq2yzDK5b4PCkucr/aTKgKPJJWdKwri
 PrJfVZv63JvWqPKF6jYBAPIXRoVD6F4Uef9vuP4eiwER/wbHc5WCaSschTys7mUyv3B4
 0evbaBrEy67jH7ECP0xXQmh68t3/voMgZ5ZldIpfTu16JqFevskIHODvsZMZQfnXfK1K
 1lsudV81FLAHiIxLhh3JQm9CGjOhEuZEXqMzUsRkXX1ZXa1fDMOna/t0Da2ETsukbbek
 tMN5IQWIhJYp8qc0qpgsu7HQaXFZ8hCssbjzP1pzXvpRzwAGUR4ryw9ZdJjgzjbtKQ95
 evjw==
X-Gm-Message-State: AOJu0Ywk89/XC9WhgzCmZjfpSJuUSUrdGyEdtdCYx85JmxDNhkd/Hfoj
 0nLapP/hG9afnSnPcE2KFR5QnCQeGIcaZ3I5D2jDwEkJoLxbFzGZ5EmpcIMBdnL5+wx4asV2lYK
 +
X-Gm-Gg: ASbGncvtNdrQvVpGOSwa6pNnO6ik9BdzVARCnNaEJVTZPTv5p24Sjnvf+091sl8KV6U
 BhvdPhZ8bGkauteZKhSXMniwtNJa/hEncO+AWHcznm8XPaXoy+nodmr4cIrdnd1RPuwNpOi35hB
 AZ+IL26Q+lMdLke2OKNsLyEftWYeimqG/K5VLR8BOIXqC45Cw7Twf0m/THV1EX5Mtty6oxuZ16z
 dLfbdq6xbjeSAy61ecu/XKQdpuZVsuvFQ98f0z8idfta8iR/tcRXWOVTwadbuPWdPFS8uYF5xcL
 XDeVtjDh7F9QRvdBrRxQPhvNtK6uhSBTS7sF2wbKeaKCGOEnXJ8Q+Skh1tKbKxekzOMEFm8EZE+
 a4i0dgugN6d8R7k4Srwc=
X-Google-Smtp-Source: AGHT+IHesG14s1pmYGWVFpEUYG67zdjD8E5KGA8x5ZCYFeeUv3kRpxvWq6VMVqnAC83L4mo217cSzQ==
X-Received: by 2002:a5d:59a2:0:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-3997f8fed26mr15880271f8f.14.1742917755234; 
 Tue, 25 Mar 2025 08:49:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f33237sm205735575e9.4.2025.03.25.08.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:49:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2] target/riscv/gdbstub: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
Date: Tue, 25 Mar 2025 16:49:13 +0100
Message-ID: <20250325154913.95283-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Replace the few ldtul_p() calls by a generic ldn_p() ones.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/gdbstub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 18e88f416af..c1dc54e47d6 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -193,7 +193,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
     CPURISCVState *env = &cpu->env;
 
     if (n < CSR_TABLE_SIZE) {
-        target_ulong val = ldtul_p(mem_buf);
+        target_ulong val = ldn_p(mem_buf, sizeof(val));
         int result;
 
         result = riscv_csrrw_debug(env, n, NULL, val, -1);
@@ -229,15 +229,17 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
+        target_ulong new_priv;
+        size_t regsize = sizeof(new_priv);
         bool new_virt = 0;
 
+        new_priv = ldn_p(mem_buf, regsize) & 0x3;
         if (new_priv == PRV_RESERVED) {
             new_priv = PRV_S;
         }
 
         if (new_priv != PRV_M) {
-            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
+            new_virt = (ldn_p(mem_buf, regsize) & BIT(2)) >> 2;
         }
 
         if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
-- 
2.47.1


