Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EFCC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4n-00069k-3Q; Wed, 07 May 2025 17:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4k-00068x-SL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4i-0006CT-L2
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so368239b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652387; x=1747257187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Acco64j8AohVk0U3GZiX+hk+MPR+Ymqfvr9WRzFbhZc=;
 b=ix/MEJ4VC2IYGfAjrorKwGRQRrztW/Aw0srLO5NZXWf4lQkJfIbkn0fz6ZUv7YfJdr
 eWv0Z6p+yFsM4S31CJs9V6W5zQs+rzHq4KDyITJeYuTEFPPkHCJloPrmYIf3gcyKpQHw
 8Hu1MMN4FT2AciwTO5u6ASfs+iKgpxTVDDeojvCOpniZpJw+eUqZoG40581UdGD8WToA
 9O8K4TYrrsnR/U9fLPJJW5fSvy82D0sMscw3kgpfz06IDHLnv3Q8KUlPNv0KF14OuINQ
 edgIPwVsNSnJMtsvzBjyM+3exyVZCulanrwuzsE2ryx2jWuFCBB3n67KQolG1UwcJNvh
 P6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652387; x=1747257187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Acco64j8AohVk0U3GZiX+hk+MPR+Ymqfvr9WRzFbhZc=;
 b=HgXyxlUUOmIy7JVvPnEzYhkuS1+cQ8kvxCTAyeW8r0Kcg1N0emtv3ZAEoaUNkL2wIN
 vOyUHMf17uUGUsLRvNqEy8eUzJhFM8iTvV/1YmNoz1yjSlnWv2u4tXOUtRvWRVv7zSRp
 p4o56rLl3f/grZef0hq81M0Sj4F2bwkApJXS04Vl3vPmjbABie3XJbDtgz3cBOARMatC
 O4aAW6QCopd9FABepNdBFl7fzC9wkrOtQIbQJA2PrUWbg/0conw4eDUWXunIm9yTj18a
 atyUplWUdm6L+G5T/NrUbsMjvfInJZg3KpH14HCy2UER1bzG6d1v4Vom3w8EKeFVmacg
 eo+w==
X-Gm-Message-State: AOJu0Yz3KhJUt6qaxAIyV+NFr9pHxqpa+4KMopFmL+Zmjgea/UXpXVWy
 wdAFXY/X8kj0P249nqYr3qcJHxnTgn5zvC7bS8fASV49otqgCzY6wj/Y1bFvTR2NEmJnvYs8hrm
 P
X-Gm-Gg: ASbGnctEkeD87BpZMu/HwOBePVWSHlTzCFYy1wIFAwEqN3hSGUnTEzD0jW5HEiSX6L9
 GcfGsfigYFHUx83T+P2fntf4P55Mli9N/DLHhjYfvyHoeqhQo8rrpxecQABlruyGiNVJesGgouu
 SDJXXSw4G10R7qQ8PLQy/CKD38lEJBHZAWh5VfOoK4+CH7HRCwujKpPCPWYDzSZRsP9QmTBKaLx
 /CYagIrG0unP5zaTfFvoLK3lkED7WoKLy0uVSf9pXzLkDF3FfI80DUP4a4xq0bjfS9s10M0fndO
 V6zQUmIcTsbhhClj3YQjyuEqotMLgApx9+kxmAHvJf8+QVWq+6002z/Jdgz7YqbNwd2mPaQkams
 =
X-Google-Smtp-Source: AGHT+IEHXwV+vyhmuFjS6nYMZ/hQKNGOo6It6lrHbXKCv3ab0bpl+YT0Ou795FwS8ERGLyvpE/XRyw==
X-Received: by 2002:a05:6a00:600b:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-7409cfa68cemr6620398b3a.17.1746652387136; 
 Wed, 07 May 2025 14:13:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/24] target/m68k: Introduce
 M68K_FEATURE_FPU_PACKED_DECIMAL
Date: Wed,  7 May 2025 14:12:41 -0700
Message-ID: <20250507211300.9735-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Set for 68020 and 68030, but does nothing so far.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h | 2 ++
 target/m68k/cpu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 0630eb26c2..8adb1c6515 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -574,6 +574,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* FPU supports packed decimal real format */
+    M68K_FEATURE_FPU_PACKED_DECIMAL,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e898156403..866d32fc9f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -260,6 +260,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
 }
 
 /*
@@ -302,6 +303,7 @@ static void m68040_cpu_initfn(Object *obj)
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
+    m68k_unset_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
-- 
2.43.0


