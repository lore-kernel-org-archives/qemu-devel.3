Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765BFC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBN-00070u-MO; Tue, 01 Jul 2025 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBG-0006jM-VJ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBC-0006wj-TN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so3197152f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380907; x=1751985707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEs2Qm2L7ZL6HJmlAKGXkcdaY9znIdbK36UK/TTpkxY=;
 b=gi6WcyTkjiIemlM5iHsvdDmvbi7VvA+6TTb4He8Jfup+cC9/mnbd6+SXpwWFFEY0fq
 NaBnW5KdzFXxRWz4VWnHgY+jc6i9gLGvQ9Ez1qU1b8fOMaVQv9aHtnsnfBdkRHaLJ2Ls
 6FIR3IuJmHr/N6ElUOu7++qTvZ+3UiRQiiKTIokumqWF22qNW0yeBBY/s1uwC9zgas92
 GI5SgUBfkpvjbX0VVGrc8iJ4lKpzCH6BjAXtT1lfyBxcS5SSIr0EIf3pRTmnx8/OsAV7
 SGBy81u4HRwHJIE3I0eglvM58OeUwCHe55S6k5uvL+SKItZM04O2SqNRmeJuhbPEuEO0
 MjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380907; x=1751985707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEs2Qm2L7ZL6HJmlAKGXkcdaY9znIdbK36UK/TTpkxY=;
 b=OH9BBf79bQnE4SpJwxJ8P99o7S6WRckvAe/4EdRS/E5CKV0Ak6jJ9sA5r9d0bSsLd2
 fN6QXjcXqMpcmPDVElZdzM+H2ISaruxwilE4rHJ7Pb5s8KA9wH1UUTHadPBV9EtDnPMd
 Tn8JhJtFc7udcg7kAaralT4o2WcPdZF7VO2xfmNx+spx2V7+1XfxPSEq9jj+0kh5kZof
 EvAMXSkrlIZ+40wuUvzIabjteTE/+GSGVPBfFe0nvwVKnq1Yh486JJEa3lt1I6ZdPoxx
 VmZwMJHATKHcJdFma50nF4D99TRtSHOv1Ed/sWN9CsHMK8yW9MHP+UWdGgsZ5xEPFseU
 VYJA==
X-Gm-Message-State: AOJu0YzYKPmHaT8whg0yDHR2xbAwqD5CrGUOjKMYZJc9xXyOKhjf3PkO
 1TIFWZLRxyqb9h/1KdA64XGTls+sEYemwwyxnwHB7GcyzlB65ZQxORunma0PulYWzQEeIdKknh9
 n92i9
X-Gm-Gg: ASbGncsBw23KFcU941QVbwNguVZxuiluWLjVD27V9Kf7Bwupo9NIObIwNVHKIIb8gKN
 rF0xhP1cAo2kuzHXrKTRbqD1SvX/vbwZX1r0NCSHlFnqAXXzu3suFZAErLCKD/2EHmfqDu840ah
 tkZpEEamlMPq6na4wvk8ih0jPteUPsRfZizoW+FwdYtNPDieYgJqtHp8Ogu1hnRojF8pXEhKc0/
 /yRxBe0aDZGysZcgTnTFSrnHf3BuW7L9WCvIEv4pkrxatyrMGbW0e+FG71TtK9oOHz5coDxSa/l
 kwZsYuVxb918U7+1RPSAuG+2NuP5FCeTE0gNz+8AwXB4LbYh+jdIGQMu1WAE1RGzzGaFevuCIYe
 dO8SoB7y5xolc7nAdXdBuESC5vRgjgW/e9qek
X-Google-Smtp-Source: AGHT+IHZQ7/4fTVljLrAhA4ZBeY7iK69vMF0cJhw7vzUBKwVo03JKhpqCOYY03gGZ/fqTBdB24caNA==
X-Received: by 2002:a05:6000:400b:b0:3a4:e4ee:4ca9 with SMTP id
 ffacd0b85a97d-3a8fe5b2bc9mr14407249f8f.23.1751380907135; 
 Tue, 01 Jul 2025 07:41:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45388888533sm180242245e9.21.2025.07.01.07.41.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/68] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Date: Tue,  1 Jul 2025 16:39:24 +0200
Message-ID: <20250701144017.43487-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h      | 2 +-
 accel/accel-common.c      | 2 +-
 accel/hvf/hvf-accel-ops.c | 2 +-
 accel/kvm/kvm-all.c       | 2 +-
 accel/tcg/tcg-all.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index a6a95ff0bcd..1c097ac4dfb 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -50,7 +50,7 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
-    int (*gdbstub_supported_sstep_flags)(void);
+    int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
     /*
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 55d21b63a48..1d04610f55e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -128,7 +128,7 @@ int accel_supported_gdbstub_sstep_flags(void)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
+        return acc->gdbstub_supported_sstep_flags(accel);
     }
     return 0;
 }
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c24bc1e9c28..b57a75f83e3 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -347,7 +347,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static inline int hvf_gdbstub_sstep_flags(void)
+static inline int hvf_gdbstub_sstep_flags(AccelState *as)
 {
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d5917c0a344..5cd38d536cf 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3980,7 +3980,7 @@ static void kvm_accel_instance_init(Object *obj)
  * Returns: SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static int kvm_gdbstub_sstep_flags(void)
+static int kvm_gdbstub_sstep_flags(AccelState *as)
 {
     return kvm_sstep_flags;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c674d5bcf78..5904582a68d 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -219,7 +219,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
-static int tcg_gdbstub_supported_sstep_flags(void)
+static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
      * In replay mode all events will come from the log and can't be
-- 
2.49.0


