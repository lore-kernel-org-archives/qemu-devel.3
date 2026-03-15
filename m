Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0311F30271
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1oxW-000677-Ln; Sun, 15 Mar 2026 13:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxT-00066d-Kj
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:08:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxQ-0007Df-15
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:08:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43a03cb1df9so3705525f8f.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773594530; x=1774199330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qU20LmUXwP8T+krZX4dsj6BmW8EHvY1eZ9YouOufIqw=;
 b=rMsEuOjxIPf0e4jKtn6m+9+Mie9NwAgOSfvhl+NSP/XniU4nTohQODEYpbkQbbLmcZ
 Gh0SCoh8lp/obLGTe76Kf9CdHod/3llSd1RhpllnN3pIVPJJqa/+IsdE7eGB66YbAk52
 RTmK66xEIUE/kTSF1l168Km3diU0VT6s5hnc9KQ+O5eHCHvgN2dUQRvYTZj4tD8tvN9g
 bHhvTmeeUf3RPA94GrfJLR7DM463DKnuJKtM2c36FyVobCj1vAZbz7BH8ottgtbhZsSv
 NCu6/kmxQn/JZd6vT6wehR0NyUtVhaMvi5xp/5VhNCZjbb0rTDEO5yypzCmX/e+1sUh+
 rwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773594530; x=1774199330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qU20LmUXwP8T+krZX4dsj6BmW8EHvY1eZ9YouOufIqw=;
 b=KmoRq5rRB3dH6nJfOKJYuZGOVbyyApTcOvIe8/KoLAcBcgqngOl8jrJJifxyKM7Hct
 FQhsvH9gVK9SOXdgIA4jHE066SnMd8RekzLZYi5+2ls52joOI7ffzHsgeo+Kl48oHq4R
 hKH9RNtxnaabvXixfyYnEdz5yLUE8+X+83OgvMZXfZF+dINVTYXtIPKaGi72UP3frVp5
 KMibG1aAf7+vyxHqO3QSVwGWPNi4aRXa28y2vUpRTXk6yuzJxQS5cLSM9A7Wnv6UwUTb
 z6zbsGJn6r20biIUOtBpc/RaujOr40P6yNI9cao1Pa6VS20oBAp9nb0CYyQRFpDAa54e
 XQwA==
X-Gm-Message-State: AOJu0YxmXal58/f0JpJTLPtKnF/I2ZWjDlCPy4l2R4E3JNfMU+POI03Y
 fIrsMLaDzBhKwqvUynmODekT0s2TD5TfCLxix+OIR+jv/5XLUElKtW82Ka+dCvgkhs52+/Zy3Q5
 gRLDbohI=
X-Gm-Gg: ATEYQzwrCM0vppW8hWtxuGCXM5yLdX3/oaJzGkBzaBFnZP/QfQEEHdgCSQFxSE3yJd/
 6Bi5han30l6wLdLWiCKUHufoPAX/iyfY6rOS+iqUj5PzLau4YSuQqPWFCSc9kcd7xIRLLnANG4W
 wACI7R0As3rDb7eF6jK1Vp3C6lsJQr7EUAmgiYO0R8zAEIQfNuYteZlLWjbku4Tj6Eq6TQ+Llbz
 njjW2AESWENa2ntbbR315CZR2HxviEA7atF3HFvzVj3By4mAzxeN8NKxnahbvkXluPCjJE66Wkb
 JHE1fiWwGpmOczdMH7LEdWwtK47PNdHAlJRZSfHAmShc7vJ1W1g8ZH8a+/71VbmoN+ngkgHPfBm
 8msc0uTNc+K3kFd1rWWOJ62BOpcAURLS9ylZK4CbwVZzryM4NQQiTs4JGMQ41xWMDRmNhy/Q1Lm
 GBVwXDauVRubPSlgld14N0QAQd44LDT2aBeJvj4Ae+YIwrPLivOdIwy70fuOHSkrKe1Eq7fmsY
X-Received: by 2002:a05:6000:3101:b0:439:d7db:c526 with SMTP id
 ffacd0b85a97d-43a04db65a2mr19596649f8f.29.1773594529963; 
 Sun, 15 Mar 2026 10:08:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43a03cfd18fsm24862296f8f.36.2026.03.15.10.08.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 10:08:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/ppc: Explicitly declare 'cpu_reserve_val2'
 register as 64-bit
Date: Sun, 15 Mar 2026 18:08:30 +0100
Message-ID: <20260315170832.40331-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315170832.40331-1-philmd@linaro.org>
References: <20260315170832.40331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

When TARGET_PPC64 is set, the 'target_ulong' type expand to
the 'uint64_t' one. Use the latter which is more explicity,
similarly with the TCG and migration APIs. No logical change
intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h       | 2 +-
 target/ppc/machine.c   | 2 +-
 target/ppc/translate.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 63c8fa25acc..f4438982928 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1298,7 +1298,7 @@ struct CPUArchState {
     target_ulong reserve_length; /* Reservation larx op size (bytes) */
     target_ulong reserve_val;    /* Reservation value */
 #if defined(TARGET_PPC64)
-    target_ulong reserve_val2;
+    uint64_t reserve_val2;
 #endif
 
     /* These are used in supervisor mode only */
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 49cfdc6d674..b44c3ccf0ae 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -682,7 +682,7 @@ static const VMStateDescription vmstate_reservation = {
         VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
         VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
 #if defined(TARGET_PPC64)
-        VMSTATE_UINTTL(env.reserve_val2, PowerPCCPU),
+        VMSTATE_UINT64(env.reserve_val2, PowerPCCPU),
 #endif
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0fc81570a8b..ecf75c1376e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -76,7 +76,7 @@ static TCGv cpu_reserve;
 static TCGv cpu_reserve_length;
 static TCGv cpu_reserve_val;
 #if defined(TARGET_PPC64)
-static TCGv cpu_reserve_val2;
+static TCGv_i64 cpu_reserve_val2;
 #endif
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
@@ -152,7 +152,7 @@ void ppc_translate_init(void)
                                          offsetof(CPUPPCState, reserve_val),
                                          "reserve_val");
 #if defined(TARGET_PPC64)
-    cpu_reserve_val2 = tcg_global_mem_new(tcg_env,
+    cpu_reserve_val2 = tcg_global_mem_new_i64(tcg_env,
                                           offsetof(CPUPPCState, reserve_val2),
                                           "reserve_val2");
 #endif
-- 
2.53.0


