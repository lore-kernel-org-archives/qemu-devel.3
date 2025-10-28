Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16215CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeSh-0000K2-Oo; Tue, 28 Oct 2025 03:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeSe-0000JJ-S4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:49:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeSV-0006zK-AJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:49:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4146038f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637765; x=1762242565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXN/vpWvITLur9ZDJo/U77KGUGvSZDrxaC3ix1ult+U=;
 b=Z56nuKKeneXN1iCQtgz/+YaZPPeHnq1Ph4Hy9L+vmunoXaOEZcIthJsQhpEvKr0Ldw
 7oDFeKrpbm2gGzoXPD/eY9h1nToXw3/juooOSX0Uej4OpRSkk1KEX+Dc3m2JOEdlC5Fh
 9ZeHABskAFmPhmy1Kb6NHu1uxml9fKxKG5/UBh66JULTwN5nvhvxc8zhxSQqiEfJY7eq
 5k7Ik4ygVVul8qzt9hGQEJAeXBIRbyY1c+BubJ42wkbo5G6cEq0RATEWJ5vXSySxh9ys
 qNdWUwSX3gyuFRkeJqW0dOoz3H0zPknIGU4lhLOONgiJNHpE9KsEjQKe8vol8bSs+cXv
 qyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637765; x=1762242565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXN/vpWvITLur9ZDJo/U77KGUGvSZDrxaC3ix1ult+U=;
 b=IRPmduRHK+7IIfzQ5NPoqGZFUjTl5F0okKi2ncZHPmCg6LOoxqGHZgV+7WS3uTtIu7
 TaIpGNaVb/n17d5rNhMKLl5WCBms41SrtQfJFw0qoLwndaLYwQ3jiQkhjPlzu8cpxMnH
 B0MfgI9b+d2U0lzMbdzAKL7kQct0EUUQdEpjlbWJH9k6DcgpG769Tw1M7srlmTloYlvx
 i9vOAAzMo0GEE5NDty9q7XaEJvls7Cy/CMcL4ViBjJfcXjTCbz8mkwn45ckGY2MdV1jI
 xbd3vEMA/xQMtMgL5gS9oIcYe7VC4LzYhq1zGWCOsJyaD1I6pvXsYAeMXGVcun4PneOH
 9ZIA==
X-Gm-Message-State: AOJu0YzDMQ+b4zu+ozKsMrE1SCTKkzw00CAGI7/rljl8504ZYmqSgar9
 OE8cw9PWSXCEjnnxxXuvvXXT/qupuCyh4/Gjj5jisdJwzQciJpOsKJSSDBDBLvKOQ+0LHuzS4NU
 H/j96fQE=
X-Gm-Gg: ASbGncsNXNjZru0reHH5fU/H9Vv0ui3QMEKab6ymKVCZHtYuT4VQBQqbsTlYp1jmApV
 slGr4tijY1hqtp2xcFHxxaKZZvowSt7EzcxxHsVZCqiwmtWgx6R6isT7ofb6oPoFaUlXGyAlqL8
 VrKwVIY+dsPu6x5apNRRGbXw681pibwLQSSh/OOrlmIh9FdkvV5+rguB/BMA1NB0kfcDFSVbYUj
 iE3HO5Nx1uDDpoJecY0ffXj0QKoiJ6cvrDYW74Dwus7k98hL20bCU7zeAPV6CRpfDULC4xcHHrh
 llItB0oCi8ngHAd4VVHhvmt2tJ4uf8Nn2LGHKCCfIp/zzxmYTv3BA0PzN0bwCJzcS4wuVszYfuC
 Lpa4/Yck7uolfe4uuX1UK+fp7ShbhG86A8CXNjl4hrJJdX0cT6v+ouLKSLUSwQIv423XpAfzWZT
 bXfcygSeZBBOjg+sLLTyEiNoc5g8G9UdxNcsTfdQltEWKVc4ZdlFOXjDpT8K/MF5c2Yg==
X-Google-Smtp-Source: AGHT+IFZgGmgYjRVxipdgM0ms0LUPHcNV4cTY2Isw9cLlVof15Of32cuYr7kpZEKTXuSYxXeDWU+CQ==
X-Received: by 2002:a05:6000:26ce:b0:427:5e6:c0e5 with SMTP id
 ffacd0b85a97d-429a7e75aaamr1897535f8f.39.1761637765219; 
 Tue, 28 Oct 2025 00:49:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm18606985f8f.39.2025.10.28.00.49.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:49:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/23] target/hppa: Set FPCR exception flag bits for
 non-trapped exceptions
Date: Tue, 28 Oct 2025 08:48:37 +0100
Message-ID: <20251028074901.22062-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit ebd394948de4e8 ("target/hppa: Fix FPE exceptions") when
we added the code for setting up the registers correctly on trapping
FP exceptions, we accidentally broke the handling of the flag bits
for non-trapping exceptions.

In update_fr0_op() we incorrectly zero out the flag bits and the C
bit, so any fp operation would clear previously set flag bits. We
also stopped setting the flag bits when the fp operation raises
an exception and the trap is not enabled.

Adjust the code so that we set the Flag bits for every exception that
happened and where the trap is not enabled.  (This is the correct
behaviour for the case where an instruction triggers two exceptions,
one of which traps and one of which does not; that can only happen
for inexact + underflow or inexact + overflow.)

Cc: qemu-stable@nongnu.org
Fixes: ebd394948de4e8 ("target/hppa: Fix FPE exceptions")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3158
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Message-ID: <20251017085350.895681-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/fpu_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 45353202fae..2d272730f60 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -94,7 +94,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
 {
     uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
     uint32_t hard_exp = 0;
-    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
+    uint32_t shadow = env->fr0_shadow;
+    uint32_t to_flag = 0;
     uint32_t fr1 = 0;
 
     if (likely(soft_exp == 0)) {
@@ -122,6 +123,10 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
             fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
         }
     }
+    /* Set the Flag bits for every exception that was not enabled */
+    to_flag = hard_exp & ~shadow;
+    shadow |= to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
+
     env->fr0_shadow = shadow;
     env->fr[0] = (uint64_t)shadow << 32 | fr1;
 
-- 
2.51.0


