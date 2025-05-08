Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCABC3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9ch-0005Wd-AR; Thu, 08 May 2025 18:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cS4daAwKCoo1opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com>)
 id 1uD9ce-0005W6-Pa
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:21:44 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cS4daAwKCoo1opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com>)
 id 1uD9ca-0003SE-R4
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:21:44 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-736c1ea954fso894435b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746742897; x=1747347697; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=55Ndu5VVbYuk2bjO10ylWMKjz+z8b/iam8qIqTd5nvY=;
 b=rgpUZmIO9euWjo6aKApgW/V5gxkSzB+Bv5haeu8Q3jvIzZ3Oao0i1+eZZnzhT3u3qZ
 lneL7EsSafXQqL5g9JLCEhm0AW8go48cces7LLSHJ0PvsjEzkK7nTYwIz2lfluUiON/G
 aNaa9IQI3WuQX1RO0YqMcWa+XVRBGbdNfE4hPKwY/Eukuu3fVIZ3P6hlfedPSHZiLsq8
 1tZv9Q141OnyRBvmFeK+7gTHLqpkhYlBy/CfzC2YH00ylTtixvgjb0CgkmndcMEGa2P8
 AGiKbnprKGOYWlJMfKTLaQTWg9a8RWweBfr2dRjv4KWlFPEUysctg2zXfYVwDt5sPblQ
 4l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742897; x=1747347697;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=55Ndu5VVbYuk2bjO10ylWMKjz+z8b/iam8qIqTd5nvY=;
 b=jAThPbijazu7ThcxrecRX4Sy/DbM0umfoKSb7kjJ9ANMuCQkJfxUVSbc5f0M81BIoV
 ZNrRR3r/a7SqMgrAs8QAK8wini0UsHYKAUzr5et4zJHY7ZDRIO2MZtFQo1n0CHXjPbXK
 yay8SZr8SbYc4dnZ81Og7wP1+i+3j7HxUuI4jWGWwgJeOzwc4pbOgeAA1U//L1nDtiM9
 Z+Wq4C5MSkAl1BwED1IpXWP4Hl4ozWGFUmfk0mjeLQLAHXXst/cT+cPA4dHUOV5U/dK6
 spacIgl76sw9DmK7tK3R3UeG9YkY1Qs1j1unAt6gozHyh75rDGOw/l1P1e4QhgTDhxmw
 nPZg==
X-Gm-Message-State: AOJu0YylEcYlauizs97glR5Rej3rolAdjWZeAqwNC+ZD8srR7nyaOpwI
 yEsTen6/6yVwo1zad+y9Dbz4iBtJfixyA9qDkUywzSzeI5fvdOGqd5edxzeeNEn59tJxh8s3Cp2
 zrEwLKDWvCOxNhfeTCVu+VcnqggbFqk2O9Ilpx0zaPcjuYt+la63XtVmU7ZYCwBRz+iL7XW89TK
 hDZ9c8U1NE6Yx/Qh65bP7HgVc29sth1wxn+83lSET4NdxiLZ0njhozNwKRKRruq/c=
X-Google-Smtp-Source: AGHT+IF4k7WWKKCuZsLwQHikT7arx3W+bnu2P1U1Qzioz33pz3S8fLR8Vt/7M6ShGsyxjCBDWaSDMzNSAs1Q+zhJ9G4=
X-Received: from pgbcf5.prod.google.com ([2002:a05:6a02:845:b0:af9:bc01:4df8])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:158e:b0:1f5:8678:1820 with SMTP id
 adf61e73a8af0-215abb0b74dmr1127192637.12.1746742897315; 
 Thu, 08 May 2025 15:21:37 -0700 (PDT)
Date: Thu,  8 May 2025 22:21:32 +0000
In-Reply-To: <20250508222132.748479-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250508222132.748479-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508222132.748479-3-nabihestefan@google.com>
Subject: [PATCH 2/2] accel/tcg: fix msan findings in translate-all
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, armbru@redhat.com, 
 Peter Foley <pefoley@google.com>, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3cS4daAwKCoo1opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Peter Foley <pefoley@google.com>

e.g.
  Uninitialized value was created by an allocation of 'host_pc' in the stack frame
  #0 0xaaaac07df87c in tb_gen_code third_party/qemu/accel/tcg/translate-all.c:297:5

Signed-off-by: Peter Foley <pefoley@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 451b383aa8..03af677281 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -267,7 +267,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
     int64_t ti;
-    void *host_pc;
+    void *host_pc = NULL;
 
     assert_memory_lock();
     qemu_thread_jit_write();
-- 
2.49.0.1015.ga840276032-goog


