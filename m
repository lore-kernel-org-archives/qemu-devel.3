Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FFDC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5J-0002Wc-0e; Fri, 20 Jun 2025 18:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcQ-00083x-Vj
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcP-0006fr-Hl
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso1792449f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440816; x=1751045616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzubzSShF5xtg70wgMa4NT7f7l8/QI7hYdnu6JnrJk0=;
 b=ITMBhULA7DRrjHE7ds3rlohyjmyf1u/CFVXZAnB42Eevx/VLcNg4FWcpmVwMr6Eit4
 PBRsJUVI2NwA5JeLRNDFrPHqyqdrBCGH02kYfR2v6JjID8Qa9Zyivp8bF2jbONwlU2Sy
 aQH5jt1fZj0rBk8ssxvOkmGQ5HokhQauum3G4SxqyxZ+xq1Te15sq8QQlTUBWC7+K5hc
 hIWIA1PxbmlX/U0r+dvKR9rulWQ4pH2mesXEDaF03mPtB0Mtbjs7vm69h5laT2zYudAU
 DhbJRI47UCtO0Cl7i81pMyCGwEKbT3mLEAWCkQEjZlbbB9tts9BaUr2XYI84gyvx9Qtv
 XUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440816; x=1751045616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzubzSShF5xtg70wgMa4NT7f7l8/QI7hYdnu6JnrJk0=;
 b=gqKtiXGDMmGfr6oOLVxs1UNwXuMOh8TnMubwdOxPD9yB9KZQ3W79mAt2UPZi4cWjZY
 M4f2gKGHIlNdBzJZ5vrpqiqtzkjw7Dtb3lbp6e3va860gANpFPzAKES6477yC1lM2ZPE
 2aW8X8/YTYbwFG9Gy5bv6xyD4H0M7NclVWDu3roVWgkL1SZa8GRXZzH+xlfbmnBZ3Ggn
 uXTZJpnDWfaif71K073Hu1mqCLxO17JLm5J5ttqF7FpwSP2/SgdiIbGhiez+nb9Nc42o
 ycaDb3Njp6vPbaOxS1CNobs9w10gKXSe3Rk88wI2hix5QO089f7CpdXNthwG44gMXUwx
 22IA==
X-Gm-Message-State: AOJu0YzC0Uxxoe6snQ9cQuK684zVKM29qWyc25AEr8qe15z7bpP6Hme+
 /qW/TdccaaEYYIRgfI1WWRk+KUL6xIShtATnwP7KbIAoaBwq2VeY2f7BVn8OFZNoUvW8O3KLQ4S
 aMBd/dueHDw==
X-Gm-Gg: ASbGncvQ158X6WV0fPsy96/ebfeQmgcOPziFKrqg3VJTRMxTuqVZdkEJR/q/z1bvaQF
 WZXgFEpAE/q/1zz8LEorYH84jfOo1ZQbCzjLXT1m+k2PwrJFUQGm4K0zB/4VeG70uZZ9D6OgWei
 S6jSzuICArZycgrbhjzrFEYYhO4JaPgHxVl09UtlCCQxSKh5dkFj9tPdQb5UzH8G0ByeDXID5Jb
 WuK9IuRMnNSQoOZm52SjJ9NkxSYLsUs8Bps2dubRUIz7UYr/jHKxwvcB1QbGmDyLbScPGPb6/mv
 2P2ll2PcMD378qIur5xwO+vHwOcl/5Iv+mVspJfufYwRgxf19kprKGf9x46hlY0NnWtrCglHZp8
 eLtFuIv/jk23g6U6hYDYipCeVMGF1cdrjmtCvnAVm3+PHaYsN3ASK29Cg
X-Google-Smtp-Source: AGHT+IG9uMMWzwFNWL4MjBihHUYZdtsgkR0rBJdgrmnLEj1gw0EQOSXrS8XU7cW1o4FCba7G5JP70w==
X-Received: by 2002:a05:6000:657:b0:3a5:2599:4178 with SMTP id
 ffacd0b85a97d-3a6d12de543mr2952627f8f.19.1750440815914; 
 Fri, 20 Jun 2025 10:33:35 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364708297sm32138725e9.35.2025.06.20.10.33.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 40/42] accel/split: Call
 TCGCPUOps::rebuild_tb_hflags()
Date: Fri, 20 Jun 2025 19:27:48 +0200
Message-ID: <20250620172751.94231-41-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Call TCG rebuild_tb_hflags() when transitioning from
hardware accelerator to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 615faf1d96b..4b058034252 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -40,6 +40,8 @@ static void *split_cpu_thread_routine(void *arg)
     assert(swc->allowed);
     assert(hwc->allowed);
 
+    assert(swops->rebuild_tcg_tb_flags);
+
     rcu_register_thread();
     sw_force_rcu = mttcg_vcpu_register(cpu);
 
@@ -69,6 +71,7 @@ static void *split_cpu_thread_routine(void *arg)
                 r = hwops->exec_vcpu_thread(cpu);
                 trace_accel_split_exec_vcpu_thread_hw(r);
             } else {
+                swops->rebuild_tcg_tb_flags(cpu);
                 r = swops->exec_vcpu_thread(cpu);
                 trace_accel_split_exec_vcpu_thread_sw(r);
             }
-- 
2.49.0


