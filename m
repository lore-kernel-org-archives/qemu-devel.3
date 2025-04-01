Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABDEC36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiS-0008SC-0u; Tue, 01 Apr 2025 04:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiF-0007bW-G6
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiD-00060w-Hl
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso37529435e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495067; x=1744099867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWdRtuMa69kNKsLeJw7Q6GbvWUEnqwFnbkkmIh4OJyk=;
 b=WILL9BF/IxN622imgPiE41u1dDt4Yq3SgqrWKmMJEDTBODywWNM1bzRaIV1CsUYurA
 9uZsMRI5t2guAief3/cUtsrqxbWm83QsXd2Hl/OfAlyLhfa+MRy4tJ4K+Y4SCHthMViC
 RJVLGPJG99RbGMg3AQ5QctPWZiwF2kTTd9Pzp2wX2/oYQqv8VuHBhLREixG7vOkhIPy0
 /MBCirEGljp0lXAiG1rQ32NiqxmKURgWwkUeF++fsoJj/KMMzQ+l/Ed6rgdvfcyY0Hl6
 UYTxnFZxnPPlVRUjn/gNJDUxpHBM28s2fL0n5Pshxx8RHu80nfjrKBMb/fKTVLI3LMSw
 bCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495067; x=1744099867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWdRtuMa69kNKsLeJw7Q6GbvWUEnqwFnbkkmIh4OJyk=;
 b=iHnX9D8bYCs+3LH17ZEq9rIuk5kP9MM2ZWK11vTZlKHbAuC8ya7P0z+poEnVf3m0XE
 wLcoqNRbz/sMp667vPmCMyX9OiQt1QNmMf5usFWp1djc27vBmPysMPheYSW4iekDCVlR
 RADkErVqanuM/qw9CJQ0ug+9SYsiOgrxiyfNGAhOp44KeQ52F0ZeakCnztRLZy20BEpy
 k+Fv7FL1Z2Xrv6tnLbUNYw1fyik7zUrrZTzfFIOJOlftGKikkxlxVNkiJIxXhjl61NMU
 79PMIDzlkvYTyHElTncZrLUHLz0Ruzd23D8rtz6AG2zCoxaaO/sEQQBPELMv6d2Z8N9+
 H0yw==
X-Gm-Message-State: AOJu0YwPWbP8cnK3HJpYAf823kAAi7wdxm5TpFN5a1Y0dvC4KvuxdjW/
 MGQRovPu8lgY7h2OaSF1hTrO6tDH0JuKvb2XBEEwd4v7bEmEiO2MrBh+EoYnH5uQHUCFmrmjWjd
 u
X-Gm-Gg: ASbGncsqRXiANjGxskPOcDcSv77kQBkXtqy8yKut4rncV57V7kZwZFkqDFgLyLIKjx8
 3o1lvusq8YQXDFn5FICye3764TIsq0i53mOEM3nPrg9XIaWa3PwuEZs8IydGau6l1c9wlEM6tBO
 xwfkxvFNms7tuQq0CHkJr16sOsIweLpReOiIWbBCBEJR3nBAB11Kux/jP5pS/wjB4XhVRCcBFQh
 m/tcEZr6nDSQtErUIaepuuor1Br9dxACMtDMUeuamC/0y0wNb4uR3VsqZPnWKmqSs3QYc+f+22T
 /6A4rUV5+LbjJLPeBbYRDJY4lFhMueAqHj1/21sTdtfK+gunxmWHfPR7f160MGsXO0lmCtAN3P7
 IA8+qNyw+d5CCrXEoHuo=
X-Google-Smtp-Source: AGHT+IGE4DzfzOUal1mxa9c7TQxCRRWJpFfEx4H+umJrCu46OSIpl535vKS8sbaSF1HzyDjNFWSRgQ==
X-Received: by 2002:a05:600c:3584:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-43db62b764amr89057305e9.22.1743495067628; 
 Tue, 01 Apr 2025 01:11:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41e8sm13639107f8f.92.2025.04.01.01.11.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 18/24] target/s390x: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:31 +0200
Message-ID: <20250401080938.32278-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f75629ddc2..320ace67198 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -348,6 +348,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
+    .mmu_index = s390x_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = s390_cpu_record_sigsegv,
@@ -378,7 +379,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
-    cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
     cc->set_pc = s390_cpu_set_pc;
-- 
2.47.1


