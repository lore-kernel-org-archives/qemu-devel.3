Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D37C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBk-0004hM-BP; Fri, 06 Jun 2025 12:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBj-0004fw-67
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBh-0003BC-LX
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so20489345e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228300; x=1749833100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gEDjW5HxfekGeOmD2/G2kge4npJYt8IQAdDV18MsLw=;
 b=hJ7wu2iaEP2t9rCQq/e2VbEO8mD4lxcLaHD21ubtZsTGSGYGOb2iTkFNFMXtmDIdpq
 RxzEpDSSOL7WDGjOQC4fIX/s/AxOjmDv2wPYlebXBNcFT+DmKjxCA7+aRs3ZMKeLIs5t
 /RJyC6qDxOlhBRdTb/xAyDo/UDqq+GG/XPBbd/yidDlwJk57UUGsjXM5TaRExwHdfCYA
 O8RaWVM9Cr6De1XY9TZDjdyBnh2A3W7zwcGUHefXFSlCpRymcuaa7v+I0xB6rL0xcmcn
 ObDWraPDrV/7nHu6sh9XW66fsMdxBckIxdYyfiYwUtI7V75uBhJ08GpvX6R8vZh5LqQH
 mOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228300; x=1749833100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gEDjW5HxfekGeOmD2/G2kge4npJYt8IQAdDV18MsLw=;
 b=QvxhroxHWf+uImmIv06WoKPPXT0dHALg/3Qlp4jDR520zam6Bgn6v+ivfYZu1eXcuj
 l3Y99jex6/RcHnW2Hf+pFBJSnZ07D49br+DjSZ5DH5NqMKmtZ6waLvdyaEADeFVvKOCr
 FDizRN3B9wCAuROfuoy9F5qTCMrHT1XC1kt9YowIXYuWmD1U0wnCmp+jqrCG2iDKAp/Y
 WYFeNFvw4Y6B9mr8wPN0O2ZmGmuTNh9ZNdj4K7Pzzol4aJRQew64NC4Tu+/I8w2t+bGm
 +GVDUPrPPwqC6DT3kZmJWCjJwBSaCSznYvi+1QaxRGc1UxdjCkK4WPQxuM9dOojVbJay
 /CtA==
X-Gm-Message-State: AOJu0Yyx1X5PgaGnR3TDHb9LZBYL7d1BJ0hEjpccaewrqGaHYpfud+Kd
 dZOZxsF3BxZupwrJY1MRAfNvKHt4m/VzcDI+ar0b2s1uGwDuuAtuR6aF+vuigwMJWC4sq7Y8ymY
 f5mq1wuOTAg==
X-Gm-Gg: ASbGncvXF0HQynX4YWU4QOK5CbS8TQxr6FxboTP8mkxto7seJ1AtoNfZs9DNmCvcHe2
 2El8mV6KdOgiXgkK0SjVcggJ0Uyq9EmEwOc+sZ91vr+MD2MwwyLGp0+uNgahM9aDUAGXLB1CRe7
 7zulMcJ4MK7El9leCS3yLQnw183J3mqgr295nyTb2t4cWp/ZU0m9SNja5zvUodcSCDgg8JxSFK8
 zxi35RkT8vU+EgdRMwuzfM0gzgGeFfO4p7iei4uIe7tsuRnT9dH50okTQlsgE2zZxJJ/e/so8cs
 kqNkCOQThuSfj6dAnwv90USIf2c1vYAuZpqyaJ8lVtl6xwmlQooYvKwWZNoTL75EfS/II9NoRxg
 16ZI6rD7z0Icd5dp5VMRceNQSyynaX1ljHfwjGfD41Ic0TY9t
X-Google-Smtp-Source: AGHT+IEG2BGePAm+aW1Be2h1yBIQOTmjPdYGteXBwIu00B6TE/NSqlLQKYFeSkiy7G8Puq2xHfQ4JQ==
X-Received: by 2002:a5d:4acc:0:b0:3a5:3a3b:6a3a with SMTP id
 ffacd0b85a97d-3a53a3b6a81mr238000f8f.54.1749228299690; 
 Fri, 06 Jun 2025 09:44:59 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730d1636sm26638875e9.38.2025.06.06.09.44.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:44:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 05/19] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Fri,  6 Jun 2025 18:44:04 +0200
Message-ID: <20250606164418.98655-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5b28b15ccec..551a462926d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2582,15 +2582,13 @@ static int kvm_init(MachineState *ms, AccelState *as)
         { /* end of list */ }
     }, *nc = num_cpus;
     int soft_vcpus_limit, hard_vcpus_limit;
-    KVMState *s;
+    KVMState *s = KVM_STATE(as);
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
 
-    s = KVM_STATE(ms->accelerator);
-
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
-- 
2.49.0


