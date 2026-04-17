Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F304CF8E4A1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDaL6-0000C1-NE; Thu, 16 Apr 2026 23:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaL5-0000Bc-B3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:57:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaL3-0001Eh-Mm
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:57:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so1136895e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776398272; x=1777003072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wvsgcQ/M31Z4/UMXnX5x+3B1m7b5ZzzUe0LHeA1Em4=;
 b=GnrrIL0ea52TEIcIAIV8RP9exf7ysxiXaETXVxAuKEuroV6SgDVyiGJfzhu2AsTvXa
 sQqZVgYNcu1UArD3G/adzBarT15Iycst8Y3742C1AI/mL2DhB5Z0kIQ6igWPlhpzXLcx
 JUuYDM47TMtoQBY2RKjbhFJ804F8TSFIdxL0oD92TqFE28Bekd48Bd9+6nEGkZmiT3iz
 EsxMLZmN9SEd+jDMpo4j14U98nr25MJR4dAdIQ2oyNd0/+KNtnokc/55HBS/H5DPhJs3
 n19bG4D9QkeQALwNBjKcqgKj4BjYA3+/pRqvQ7F3fKDXgD7KqBx/UaeG7VNhNHJiOu1I
 jJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398272; x=1777003072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1wvsgcQ/M31Z4/UMXnX5x+3B1m7b5ZzzUe0LHeA1Em4=;
 b=OX7qVwm2tO5YgNkqXRA59bTBgO3s83+DK7flsogZDDMtHxL3pNZ/cKYUiimqewXKbQ
 yaeoHIlyzX8XUUzpaYT7YXB95dBzZ3Sdt1nf9sx4G4ATNobmvpBHNFIxfQcfIYppf2kU
 z7gEwJ8n42pgqZHwgw5EVfABxoUcGbUtxgOqobdG+uR+1gdIQmTwwNFZfvjRaK9XvNcw
 ExJamjKBosgB0arDSMIFPPCu1dJZL7i9KESRMN7PT/wkLLzHXm9tCxFol/cREFTxT/E2
 qZucIPJZlHf+z+k+Xca+oA7nsZbxnz/JSkBmisnWDgUVWg5LKmjFOX6he0nKM2k0VeKX
 RfrQ==
X-Gm-Message-State: AOJu0YzYDB1mUeKoLlTCVs44mibuoFNohdYpDHNo0Jd44VAsPOtvf0BG
 ktMwrEf8zRHfxkxJAgNZVAdRn0Isx/bq8s17+t254lx3rxZKfhisvo9gVQ78+LR06iaywzpjyCh
 WkeW8UBk=
X-Gm-Gg: AeBDietr9haFtaHc6GgqYS8tn8f2MT49TrsbBkqMIcuqCQQMMyvmXp8w9PXToOmVW4o
 qNvtMT/6ZJ3f2/hKPnwNzHO+7AhVvvQwS/cxFM6oOxMO6RblUWZvv0JQWG0P3azUyZ4WyPtqJdt
 qY/Jt3ebr1+NXS7j5KTcoHGrH3h/xnd3ak0FTQE9ipOL4fiNVUwrHf7t8eAXNLVwSTn36DiZukz
 y0ZMPne74hMei2v6n1fnXzB2X4QgONdDznnEad2uPRPhQnVn1jaCn3vR/pw0GoSXSXllAF0QtW5
 8v7h4TYuR5YJBgsn4ITFL7/xUH8pOJyfmlNQh7Nfk86AgcB+lOqsBIzWbHrVPrI7HJgmpS+zE+I
 sOW1eRzCNsj1mo2ndZfxQ/rrSL/VF4n6zad5rr9UNRRTb8fMOtGIKa0Vk+nI9cthU+2b6VNbmON
 9vQC3VdtNv/bI5eoOLZWG2q5hxPi3K/ylHtKeS9xlw0/sClSU6JCTIjSs4X7sO50ASqNJ+ht+D+
 BfDfVFMz2E=
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488fb73cf74mr15430345e9.3.1776398271918; 
 Thu, 16 Apr 2026 20:57:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8193sm11083345e9.1.2026.04.16.20.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 20:57:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 2/4] target/mips: Remove unnecessary target_ulong uses in
 LD/ST Multiple
Date: Fri, 17 Apr 2026 05:57:32 +0200
Message-ID: <20260417035734.32334-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417035734.32334-1-philmd@linaro.org>
References: <20260417035734.32334-1-philmd@linaro.org>
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

@do_r31 is a boolean, @base_reglist an unsigned size
and @i an unsigned index.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 7be2cad89d6..07a4aa99bae 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -228,13 +228,11 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
                 (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 4;
@@ -252,13 +250,11 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
                               mem_idx, GETPC());
             addr += 4;
@@ -276,13 +272,11 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
                 cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 8;
@@ -300,13 +294,11 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
                               mem_idx, GETPC());
             addr += 8;
-- 
2.53.0


