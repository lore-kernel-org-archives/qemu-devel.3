Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD245C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhx-00070t-7w; Tue, 01 Apr 2025 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhh-0006tB-6M
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhf-0005xr-8i
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so36784175e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495033; x=1744099833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GipMLU+zEgv9YkkQClbxhhgkFeUbIdD3++IpdMFRuI=;
 b=tE5Rl28VwXNPEHpYnjtWq7MMEcOZvfuNPCe1i+0iYihGqLvaN6EXs9VzkJXldWJ+xR
 bvF9rWmWqRrfpZrUR4AsgpTdd1mJgdgpIOcYPiRzxOrE2GlYaze+utqCAIQ6DDNna2QW
 8CDZPE5FagI+seBYc1IcIxSL2rQWOOyCNozUEscbsmz1Sjdh1sjb0sfC6xio6r29Ezhg
 +AydDaUPY0Yn+Nt4MEaOWg9HMydgYCERNv5s6MBuS7AxsBa0EPD8bGbbmmdZiotpQ4L0
 hTW4FCaJNsKjuxoilqrI/8iBIpzS1LaSs2y+2Flrj+5Fc0+oObop1C2oT0J0EAij6PZV
 0FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495033; x=1744099833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GipMLU+zEgv9YkkQClbxhhgkFeUbIdD3++IpdMFRuI=;
 b=D8O7YYO5g1FDn7dDXdcQJk+xrRMi2BeCi0tYsm8ohUxOF+CJq+VaHLFrJ7Xy0V0jeZ
 T0GQJyFLYWosjGewhUggetY1uhLUq2y7GLtxsYKw3N2dGQZ9KoX6JiePesvqAwT6bTtp
 5moPftnAlNsij7030SMrQGil4WS+PQvGKuNDh1oMJQAA8JOycoKS/Xc6df4ojNHY9sh0
 Gs/g2egtvOfhZbPROIH/T7v2VpzASWPuwB5oUCPEGohujI5xWMjTjV9Fhtd6EsxMcPyf
 5pYxCx9u+n55lBw+nCWyVoq5vhtn1iOhS1E6xszphOf0DeWGMEJL/W0/hWKR+bCEW1Li
 +TRA==
X-Gm-Message-State: AOJu0YxN9TbQLRwvIzJOfhidFmREN6yVHl0rMhh2oG/qVcuMnaqPDZhe
 zma/2xpfWJkfVU+QR+2e056BB/GlGc9tdIW3t0UO6JaJBnnYg/4j2Cw6XUuzNhWaPWgdqqyYETo
 Z
X-Gm-Gg: ASbGncs4N0ZS1glTUUMfiCJPIg2j8emUCcOQg/fuMOmQjNReAdyZ1IKWbZWscpTVkqV
 HvEn+3BDq214niO91Rjzdb60d04HPozow3r8hCKmeMbxJNkLSSUeqjY4ofKeuKY4mXp+SNq4dg8
 IXkDOdKexoy6ERtk0lVpFEcDONC6qadtp5NLz2DvoltSi4KQiPVT6WDXCoS2nSQ12cwJqna6q9C
 OYQbELtzojngEv7kqgg1b4TmE1n0D0a212ig0AlmauPMbSMLWSXUZn9yqucvmQhQPlyVAbf77Sw
 O7Ek3eJPN5kUD72f0dgr8844QIPlAg9J36Z/eLHCFScYQ0DUeBIxASQ9OjpkPa43b5jomxtFvZ3
 BFRigMoEA4rDl/ZOmHYw=
X-Google-Smtp-Source: AGHT+IEA0fOe6iYkSXGF2f0KfyL/44Qy6/5ZA1uif1tkpjnOsDh8QRrOii/09x7skyApdJZWGamFNQ==
X-Received: by 2002:a05:600c:4e12:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-43db628c48bmr95310645e9.21.1743495033164; 
 Tue, 01 Apr 2025 01:10:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4979sm151190345e9.7.2025.04.01.01.10.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 11/24] target/m68k: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:24 +0200
Message-ID: <20250401080938.32278-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0065e1c1ca5..4409d8941ce 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -592,6 +592,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
+    .mmu_index = m68k_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
@@ -615,7 +616,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
-- 
2.47.1


