Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6437ECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cqb-0007YO-7S; Fri, 10 Oct 2025 09:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqY-0007Tc-4F
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpU-000419-Fw
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so1281579f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101596; x=1760706396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JJ1S0Z8TTCdzh+1UFNXdb7eRSo4N3PukNOUERNZzyhE=;
 b=fpfbgkBJ0ucrTocPwz5lkwqXrjKdKgVFfOPURf6htOlefacUT4Sqqx34lKSllraPuz
 2mY+O5aCisqattViqbggSdztPKB3AX0QuZ79kWEZACib0lTj5gteGKY6S7qeXJnZ9wqd
 brttkoYk646ixvK4UF8UaFYWKbiDI+Nx3JKU/GunuT7Rw6eXGsjuEeFHJ6LfTl7MUoWp
 ahLUXjDdueN6OcTb2sbosvzz4983QTJidDrfxQGCvOhy4T3HPNfeyUG6zT1AJr3axuLK
 lqMLTOgN4G7I6P87Fr3druzomv+qFj5U4Wv6dEaQkpkCD9q8EXmh/yYMZwTsQtgvcMmr
 a0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101596; x=1760706396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ1S0Z8TTCdzh+1UFNXdb7eRSo4N3PukNOUERNZzyhE=;
 b=l1nB5SaZq07HBb85XIvFCvPrdWl2LV/7rsmDg1bhNpc/LaEaVoXrAGvul/f0JOecqX
 1EGwKw0TrGENTaYBz/L0DsUqUoAAtW0pkR2pVeNgPW+2Aze5rRs2t6gXnTxWJ4FeUtO2
 BaUhha4YuAKz1P1GTcFmxAZjf3PbpmeTaCOterHv3Bxro3HLm2G3N0wHWDbHmV9AUf69
 eQ8s2ImXoKkCQOhut6CZU8qF9dm65kuGtU5IZ9NQRBk10TzhnMLJN718Q6XDNG4LLLWz
 zWmo0oG9/PdFXAZPWYsE84sVrk9pEFbONmoN8/i8q3IUz1nq+wS2zOoSpW+GyD8E668M
 v5eA==
X-Gm-Message-State: AOJu0YyWhZug1xkWQOrXrWGMYBc4SKB7szeJlNkRDtQ18PtcqOpoSHdf
 S4B7GCLf9tulYOJTaaDtFzsVHbs7zXe6qy0btoTBN4e+nzEDfdc2ZmOjaK+LRbfyeDl2obyDDTp
 XIDEH
X-Gm-Gg: ASbGnctXD0WCQgOwlMaTjjWLjwirsavcogOVKKDJHOYtJpFqLxS9MtUZ+0nYhXacprc
 0BeCkJkkyVmpsyE6mpT9asvCQvEphquYOY5+UGVufUEFV5llnPky+ARXWiFbfQ8RqoQVoRnMl7w
 6w97LZXulo6Vf7i/0zXbqriMP2s+5qNgW9N7YDRnD4hJZ6Q1stQXELiCaK+gAfaolFYYfArRkQy
 Nk9srwyppSFftTeXJVFW19fzSQS8Nz5UwUF4IHFExFiHqh+pS4HCKnG+ww9ugS8Jx70lUvkFRms
 /dCrFlNWjdPTMEXvEr0vtUKy9L3PTktONgyJWsE48/iHcS+jmSM8aZXPpaJszroG6Urv4cthBPH
 Bwwh76hjXEqNC1u9PSPESVspb/zGHDkzH/lrCC1x9wcIqW1/36jU=
X-Google-Smtp-Source: AGHT+IHN9Pg6y1Od4T9DtcrmtyDfVXhVfGFL7ElEzh22bE0GADWKC0B57m5aXkAYi/QoLYWski6Yvg==
X-Received: by 2002:a5d:5d11:0:b0:425:8502:f8c3 with SMTP id
 ffacd0b85a97d-42666ab95a3mr6469975f8f.1.1760101596268; 
 Fri, 10 Oct 2025 06:06:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/76] target/arm: Copy EXLOCKEn to EXLOCK on exception to the
 same EL
Date: Fri, 10 Oct 2025 14:05:11 +0100
Message-ID: <20251010130527.3921602-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Per R_WTXBY, PSTATE.EXLOCK is 0 on an exception to a higher EL,
and copied from EXLOCKEn otherwise.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-61-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1aa0a157b72..0077788e1e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9071,8 +9071,13 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         } else {
             addr += 0x600;
         }
-    } else if (pstate_read(env) & PSTATE_SP) {
-        addr += 0x200;
+    } else {
+        if (pstate_read(env) & PSTATE_SP) {
+            addr += 0x200;
+        }
+        if (is_a64(env) && (env->cp15.gcscr_el[new_el] & GCSCR_EXLOCKEN)) {
+            new_mode |= PSTATE_EXLOCK;
+        }
     }
 
     switch (cs->exception_index) {
-- 
2.43.0


