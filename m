Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52329C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAi-0005rp-Sj; Tue, 01 Jul 2025 10:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAg-0005qy-Q5
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAf-0006so-0C
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so1926139f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380875; x=1751985675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7agq2/z/dMVKZ8AYrQE6GIlp8fdEIwRrjWbdb+ua6k=;
 b=jjuCx7Gz+iXAJheRCbyJZLBb0FujXqAaJPFmgp+VZnbzKuhPggKBhyrmkTBPIBQUFd
 w3XAAVRGi+VnRJLo4J5VFfcxl26vczTslsQCUf987EqWMf2CJqgR3JDYPll2ZI1MtyPX
 JYaO0nU1HxW++ceg0CqwO/+bxRD5cxjot9tNR3mXpXCuxIZCWgsSBGrKN+1by4Cz0YG/
 8NIcoBbvX4sR7m1kYMLKlf4QbCh42gERRlFkYEfZswB5TmxB8ZRH87vmfC73SK6d/zJE
 u38PaDA7XGX1q+PqDgt5c4LMFFncztO9lDe3S7PXhyUrQ3/U8Bf7k5HsDwuwnfxs/ZGT
 XDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380875; x=1751985675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7agq2/z/dMVKZ8AYrQE6GIlp8fdEIwRrjWbdb+ua6k=;
 b=dCAjV32QTuIsYUz90se0C2WfJ4G/l5Sba2edf1c8ivcjy/n+f/nCgYgZIcrU/LQJV1
 rPSwLP8xkRbAs+9tw1AOZU/Q7Q4bM09lmiKkonByHGRtnyPyu3JQChr8w7KiYIvzUghT
 UZc3qC1Wtb3Qx0YwubccDvE2JTYRqmxnWQ4kFLZ5M34gIToDNq4KmGYrhfCi3PvCIGXF
 tKgiBvr1j7PLOCFwDesr5XpjacozKApo69M9l9B80ZambJOa1Co2naxI8S4pyNms2AIV
 Pi8dL2X7RQ4cUt94wuYg7MByFyIfCke9SQTndT2LwOlxuTb+j87lyM93GduG5tosY/Qs
 uyWA==
X-Gm-Message-State: AOJu0Yw/pX0BgPPSOzntIPQCQ8fDcDYcAhsrKGdJQ3bYLoS5NfxEV1AB
 yHnjGdyj7OXBXTuYk30/J20q4xU5tkZS532LbzZqvalul4eusUwPwvHBAF06zOSxhd5mUkLiveY
 i+fkn
X-Gm-Gg: ASbGncvwC8GhkQjmdC3GfPMuBnkApQPi+j+mNCNymaoTWMpSr1wwuJEEwYqo943okKi
 mVaODbeafA678sBM3PHaVRPiN26rdhMMv6ErLDv4ChvwrKbbgOxQZ/om8AuROuUPRsbq9zHuno5
 o4otp5tKy9bMRdIwG432Tm5sNuTjdy9gtOJxhZYVIUb25jixpXuZPkVVxUmstC1uH2L/rmrReww
 gIKI7nTU9/qXZy4LGSyh9rzo+JaV+YVVXkaTpeA3W6XFCd9tuZGCjMrUzlSkChuORD7g4r2Lakh
 ALw0/2Zi/5kVptBpWbYLOrXyy7ZlbbOQDWBo3g5bxooGUSPtwpA5eebAsz0Dp+ovTeQh+HIufSU
 M80oTDY/2d+NOb6QFCeZiZo69yWlO+dPUNKQT
X-Google-Smtp-Source: AGHT+IG9Ufx4S27vj8PJ0dVg1fsqPttGlvZIlwc3d/qh0VSyKeP23PAYmO0uhTWz1DrCNO+mYmSzKA==
X-Received: by 2002:a05:6000:200e:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3a8fe5b1d02mr17437287f8f.38.1751380874925; 
 Tue, 01 Jul 2025 07:41:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a1914d10sm58341935e9.4.2025.07.01.07.41.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/68] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Tue,  1 Jul 2025 16:39:18 +0200
Message-ID: <20250701144017.43487-11-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 264f288dc64..72fba12d9fa 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2588,15 +2588,13 @@ static int kvm_init(AccelState *as, MachineState *ms)
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


