Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE99C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLe-0005YQ-4S; Thu, 01 May 2025 02:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLA-0005D3-98
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL6-0007EE-1k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso987771b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080647; x=1746685447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3awBflLWeRzXlWd/2jRau0YKc04TlIhQ8bryKwVA7E=;
 b=M0GT5jXTKn+CBEpzVrMa3I7f6xJexTMBWJbeiq9LG9WdDAs9VmcwMONeqkC1rJhpdU
 oGfb5W77+lTWrK2xzuk8BfHmqLoG4Rny3cOAARdyYit0z+JhQh6ic+u3+Uz4sq7JB8/+
 D4V83j3/sOYExPFLVXDvPIvlnBrqi5oJ9DRotRM17/IKd+UrvuJjeEe+kcmFMAiXu8c7
 JZiAuYd7aF7LOLZ8do3IWRlX3bPTLyDJAqpoKLWSiCVTxk9Wl9zfdUBfIVdM+XJRnO1D
 m4bU2FIUiiaG1Iddzh5w9UJO/4WrzQk+rxU+FByy+ZjcHZjl7vnutWyUe5XyOHCFT1yL
 jzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080647; x=1746685447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3awBflLWeRzXlWd/2jRau0YKc04TlIhQ8bryKwVA7E=;
 b=QgiTKgIildUT3MeT+oPiFegfHnoOau7yG9oxvlqWEwFE5HTTYChalf/1iefrPTxhSd
 ZEXn+XEr0WLYkk64yoVQaqfeX4la/P0grvuTQXlTcWwr4bp25aV5Kz4JOI+UYPQYyQn8
 86MM/WpbrELblc0sOpx5F66uKa47Aa77ETeMuPANUnvhAMMKbpbTqaFTtf8mmlwpCNBr
 jI3uFo+XtJmLidZlPt0+RBOoGZXZMfWKxJaZfc/sW5tz5j/AtFVAyxQis/5fBNKm/JIJ
 e3Yig4EGu8X4NlyP+0sjwfCWp/jPxu3sSMVWg/NKTx483pkFyQGaYZSjko1OJA5jZLPV
 UECg==
X-Gm-Message-State: AOJu0Yx2VJV5f94qNZNaDjsm1Eab2f58cKEcV2wsT4+WuLBxem322o3I
 ezxR9eZis+8OR04dJWs/f8h1k5qmefNfk2qPliihhWtcNP1G94dHW/9Es4/nAE/v/7wRGKI3aH3
 b
X-Gm-Gg: ASbGnctUMeYFyVECN2ajxfWe7xGE/eoS9ZiMKUZZCIEyG747Q17sqYcqYWk1NbuZ9+K
 nNwV93XildCIwALQRx7euDszTRTLX465Sll4iSHyEqJdu/q1juHPOuoFwVjSZd2Q11XZe2FWlC4
 7UUI9XKRNsezOll3xaD78JAqhxnZlVXaV9jBxELli3htWzoci0Oid/ViE6mj+oXsoVwlv0jryaX
 CZ7FmJXbBQyCvtCXHmHgGzC76iCPTv19ov3G9ZW/f3Ax67zHxh8emhTjAyZ0u4ZOYa/i09S+k5o
 ix7BL0QWsUhy51vkmkE7uBK/YgTyj1cUEqZTFm6q/lVRVX7eOIU=
X-Google-Smtp-Source: AGHT+IGLOrXCRIOSVKYP4HGNXvk8Ab3WdRzAEazOrAXRXDNVWIYa9AFM0erziA9SQXy87Xjc5f+HbA==
X-Received: by 2002:a05:6a00:1411:b0:73e:235a:1fca with SMTP id
 d2e1a72fcca58-7403a82daf8mr8471635b3a.20.1746080646727; 
 Wed, 30 Apr 2025 23:24:06 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 17/33] target/arm/debug_helper: remove target_ulong
Date: Wed, 30 Apr 2025 23:23:28 -0700
Message-ID: <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 357bc2141ae..50ef5618f51 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.47.2


