Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14676C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvJ-0002QY-S0; Sun, 04 May 2025 01:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv9-0002Du-Rj
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv7-0004PK-JF
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2802043b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336584; x=1746941384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=kxoVD7ryk+ZzLrV0wkBIjaARfjcCn0stmdML9txWLkqB/J+WwPeg5qWxvHEvZIPMmo
 FNvQV7GorWFcGtbaEbXwb1MKjNx/yrKlu91YX6ZScJXY/CGoycedAYAHySXMA2HYxfO0
 iAfikkE3Y25HAqQXlHcNzn01bHCtnS2KOTmyV6lJnY9MeBIlYluUvktDIF7GqTkyC75n
 0ol3UVxG26inng31UTFVBfXpebyRySZflo1OsfSZELcm3XodeJ0mQbUCNg95j4rpn5HO
 z1Yw0Jwz4U5a3mqVRmKBBFtBzQ3N2JtlstX2ZcbaIHKSCn79JbhY6jDAvgd8ZIoEaLKf
 rILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336584; x=1746941384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=FCTD4TzJoNVI4aMOt7dU+pO46/OdRVYbInmnRQYVAxh/CcU0uzwGv5vwe6jTAYj+hG
 Ri4Y1qxnYMm3ZUSZnjTFdZ0DlPByif1zrsStDO71qNZ7Cc43tsrBHAL3CyN/Um4k9Pq4
 qxvEBtJAyDJL2OCVCSdx3wWRdJFHMO7ACzQe9ld5saZmT/hO97za1stRGZooIn5922Dv
 QVKNb6Pl87sxUUQsqrm+77Cb0LNvfZuyHfCo6ZnhKHdaj6Oo3An9xy4DG0D+jc3YOQEk
 NQKhvjIFs1/zfbOOHjCVg46Ui9KqvXcgVh/WfgXiSfHnUx0zTJcMczTeQmCMC1tGwiHl
 /BQg==
X-Gm-Message-State: AOJu0YxGdiOFevn1cxhvR3FyJPCC3OebI/YJOe0k5dRvVOIEu9lEcMJg
 5bX0Z8PMV38o/IzkvDGpSpupIi5ND0SN6mZ9L/wnsmKyNajkbwp2PImQ9f9ToBZgj/Iaeyoi89E
 W/RU=
X-Gm-Gg: ASbGncuOr8pBZzA5FwcgeCQ1ImQ1WRs4MwXIjxwtVhhWzyOFU7ZvtfHfOHCFEAG1dEO
 YD7LoFtdFf79b7FUuVxrqTp+yR+N9vSZCz8xaSnIVqATDfL917DmMONo/c8v+muy3vWb9fFl57A
 dMnQZCQujcC8JiJxUmWjBLbeelakmFqW8ADh84DEm3AF+c0bI5ScEwbR7RPVa6De6mp69Dl2Nc9
 wn5ghm6El+r4U/8Ik6s6P7HWZWb1vwysBV3KeP9HfCch1DKWkZwtgKNmEp6u/5frw7TOyAbwqxY
 TfDguvJ1wltEzlQpK9StM2yM5SceyeedI9OhSaPr+qLtDr5+5L8=
X-Google-Smtp-Source: AGHT+IFFBK8c34bQn544bg+nODkndDO7YUq7xG/ssggchm4p/JYvKNTvfhwfbEZR6iSs/1WMinW6Zg==
X-Received: by 2002:a05:6a00:e1b:b0:73e:96f:d4c1 with SMTP id
 d2e1a72fcca58-7406f0d9ef8mr4125601b3a.13.1746336583780; 
 Sat, 03 May 2025 22:29:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 27/40] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Date: Sat,  3 May 2025 22:29:01 -0700
Message-ID: <20250504052914.3525365-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Associated code is protected by cpu_isar_feature(aa64*)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


