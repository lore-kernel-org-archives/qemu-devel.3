Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B98BC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLk-0005fp-NI; Thu, 01 May 2025 02:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLK-0005FN-0N
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0007Oo-P1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:21 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso874835b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080654; x=1746685454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4aT1FPx7v6ild1hKo4Zu9XovGo//pi9dSehqEFhLB4=;
 b=KGHYcyJzZyhOZmuVOegmgnOMjeoFc4Qv9fg5qTUUX+Ajb0fylT7UXh5P7N9ou0TPBj
 6Saa+ZN0WuGdeOVKkuWjS5naZSKvyELwFtKV/H56u94D3Z5rV/GV/AMdL67U3fqG2IWr
 wL0KBB4v909YlU6l1PUpV0fIqVtduUwzo9GVGFRKaDLtKwW23t0adqKkHk/QbP4DGTn8
 6QIyg43+GFQ3qEHn0YuBlr4WEwEo65XkxIcsPsFx+gDIG782SehZldZmI+TR6Rm3/54R
 5uLmDtt/JuWUpa6eoQ4QODZ7fXFjsaTmoCB+AQB2pTM7zXzJYepNQADNv1RmvOk5trh5
 HYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080654; x=1746685454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4aT1FPx7v6ild1hKo4Zu9XovGo//pi9dSehqEFhLB4=;
 b=qm3z3fQO0KlWb7xUsyZkT6GfG9JsnGXlsWZfgqu4bFw7DFOWKaNxpjfkyJH5OoA5Yu
 S6YqWmIOQ3jwYqzrzcJGD8MmoS1RS8F7n0GQZELD6VcuQRHLvYVV21DE/LuMC3sui6H9
 H7KIAl8mWuXGkGnCyn2vh10xYlM9NrBnwhx+5ZQXYATPX9vrb0u0Pi9NclMuoQH+MoeC
 eo9AvOJPQ+TyDTT9kU0Zh213CzelAZdC7ptWrCG+C3pUNwSot0yvpK24qHV/S2QZ3jtP
 DhAQvWRF3xyDiK4giB7NEjSnIb1Qvpc5jrVGifN+uEkyr2VlcuLJzJbJsZnOcJDOOK9D
 1YYA==
X-Gm-Message-State: AOJu0YyuIIHyhnLSlc3lmJuSfwYTzkXXEl9qxDI91K3WHK7bhQq7A24j
 wJNbMH039HyMwOzTC3EKg+hnE8uXrcarG259BREa8kX9T/yCONf2B5cKXGQGfFHEAWLD/de4Ct0
 Y
X-Gm-Gg: ASbGnctoLpgSTl1tbO25RYvbLqtcH1DFkIZIxhZ/rJQ/Yi2uZ6zxhJwaE46GtTGLs2P
 OEJrFq6BZmpsn2sQtGP3fNm8MQo7yq1ADItJbA2vdVX0w5NESKWU1TIgsXWmg1o+3WQs2Zhj7hu
 07EAnCwXBB9FJkfyCmFF/NhicDCy4AHp3L5TOWaTRlZBDloSmWqURyb98Sk9fR5A64bzWWxuyWM
 9+zvaFILBupX4Y7wqLxkDwk+PXtDG62OpHbswvfVBMJQlOjBDBUNchNhRlh9isZ896KNw2eQk8R
 YbwvL/6161f1RSRgd9j5wG4MFaLhlKO/O1lIRBbK
X-Google-Smtp-Source: AGHT+IE2vRA/bWJPyQMqjfkqLzpQvVj8Wad7xwqt7Re1vxsIoaUiDeWrqtNpRohxNat92nerkUYhOQ==
X-Received: by 2002:a05:6a00:170a:b0:730:99cb:7c2f with SMTP id
 d2e1a72fcca58-7404777ea2emr2728024b3a.6.1746080653861; 
 Wed, 30 Apr 2025 23:24:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 25/33] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Date: Wed, 30 Apr 2025 23:23:36 -0700
Message-ID: <20250501062344.2526061-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Associated code is protected by cpu_isar_feature(aa64*)

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/arch_dump.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index c40df4e7fd7..1dd79849c13 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -143,7 +143,6 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFunction f,
     return 0;
 }
 
-#ifdef TARGET_AARCH64
 static off_t sve_zreg_offset(uint32_t vq, int n)
 {
     off_t off = sizeof(struct aarch64_user_sve_header);
@@ -231,7 +230,6 @@ static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
 
     return 0;
 }
-#endif
 
 int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, DumpState *s)
@@ -273,11 +271,9 @@ int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
         return ret;
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = aarch64_write_elf64_sve(f, env, cpuid, s);
     }
-#endif
 
     return ret;
 }
@@ -451,11 +447,9 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     if (class == ELFCLASS64) {
         note_size = AARCH64_PRSTATUS_NOTE_SIZE;
         note_size += AARCH64_PRFPREG_NOTE_SIZE;
-#ifdef TARGET_AARCH64
         if (cpu_isar_feature(aa64_sve, cpu)) {
             note_size += AARCH64_SVE_NOTE_SIZE(&cpu->env);
         }
-#endif
     } else {
         note_size = ARM_PRSTATUS_NOTE_SIZE;
         if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
-- 
2.47.2


