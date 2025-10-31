Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC52CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxG-0004zz-SB; Fri, 31 Oct 2025 14:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxE-0004xm-NH
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwc-0006Hj-Gq
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso16034525e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935622; x=1762540422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GyB92fe4UqpOoI4qqm0BBnICy9YPYqxs31nBB3Pb+mg=;
 b=RigV7Lj7FxYrx6VYOzPxUysb6o5ZjduYxm9wswGEtRPtSfBcF9q32QrWijplt4Dm3e
 bmNF55ReePHYQBVD5OIxO/bvBm6ItUTewtjWSQ/aou0h2fo+uBd4glVgFQzjHMez9zMl
 rJFIyFY4UYOUoUprR6g83X/Klpi19qcYo9sz4skXjcAZe5uLVVvkzcgPxOCVa+1u5rPT
 VXbTGWRLgk9lO/47hsimv01b8ELuUR69diO5/1b4e43nbx+9iTtG4RuynpuzJIb48jo4
 nn1jMui/EuqBgRT4JlHxvjuham6KE3/ZcEQBrXjQrr9rbt5I22oxWhfJLq6h0ifYrPAi
 2OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935622; x=1762540422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyB92fe4UqpOoI4qqm0BBnICy9YPYqxs31nBB3Pb+mg=;
 b=XIc+lrZzz5H96fyEKzub8dUir4kZ8/uCdGnJ58/iDOwul4ypLYE/2IcXf66ShaVvki
 Ss2p9lsLZPJUC2/Uvs3W1MSXFOsBWWTD6WNk+SrxdDPLsVdaAFig1B5201P/B2P9IjNT
 AT/IlP52505PzWfxKFcbbY5Rjy57eiCU77gG9dZbwGCcmYegHQQrZgPDatrFpkMIlVn3
 UTOyCY2rD4X8GAb5ffCwgY1e6YqsxncJJhx7lhEM73MFXiuOSao6VP3Au1BmUEbQOzRb
 w2ZvPYlpRs9PNLa5vgrX1ERZu/13C3nRHZpAmF8K+Z7JYkZFNtcG+3Lf/nzYQpm/DsL6
 WD2g==
X-Gm-Message-State: AOJu0YwljY9x7Eey3p1IMXeGN0bIxb5HlqLfpIKjn1ZIJO7B6hnEM1LP
 8J1ZnC+UQe3Wqk9+fSI+0aIM3aCwmlXRU0mmJO5yu5mMpMZOykklzsDVjdckg5oIo+TOG9DluKD
 himQz
X-Gm-Gg: ASbGncv1C4O4tbB6718r7vnGv50PYT9l2u8weJb92HC7NNrsZdt5jaw+RTcBQde/xVf
 Cfjd9TIQ0WU0u1ogjuhmiYkYYlpU/SwvZdyHcSssSM23/YFsr8WPz45WrGJmrgK/e0c2fHmA0I2
 aenMxE7s8woUtorrUAfpm1adQvlprWkMQj+tQh263XXdq4izo7Fd5BYXvDB1tf2UrVUrP+J/XcZ
 VqSer3Z2rlIPMCDxTt61QQDzhflv7zFkVNUblwLneqwWaPVqnRbmUYjlHjvMNY9V5I38+C6+FIW
 X1Z3Dou/jyi5e7Y5iaV2SiHTlq9fiNr3WLU41egBVsbSI/Pzhlea0Y67devhY3x3BEdKgg2MSsS
 ElWkPOx+9Fl6TqDrEntQRszKEU5AkqpF9/0DnJe+4xXmPqRMka2x9AWTQYDcL8gttRXCm85wikT
 p4wqiA+g==
X-Google-Smtp-Source: AGHT+IGtn51BrHRVaZ/75Q9EbqXg3XnUdaiu06M7s/9cY0QeVEc/PtwZlfx/erX94AOtg2k8A1BGsw==
X-Received: by 2002:a05:600c:1553:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-477307b5f7cmr49196545e9.6.1761935622481; 
 Fri, 31 Oct 2025 11:33:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/38] target/arm: Call aarch64_add_pauth_properties() once in
 host_initfn()
Date: Fri, 31 Oct 2025 18:33:03 +0000
Message-ID: <20251031183310.3778349-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..f81cfd0113c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -762,20 +762,20 @@ static void aarch64_a53_initfn(Object *obj)
 
 static void aarch64_host_initfn(Object *obj)
 {
-#if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
+#if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
-        aarch64_add_pauth_properties(obj);
     }
 #elif defined(CONFIG_HVF)
-    ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        aarch64_add_pauth_properties(obj);
+    }
 }
 
 static void aarch64_max_initfn(Object *obj)
-- 
2.43.0


