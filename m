Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9027C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pe6-0000xc-Bq; Fri, 04 Apr 2025 18:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pe0-0000qL-N8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:13 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdy-00082z-BI
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so2112844f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806168; x=1744410968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWF7rdm9ZKpOTMOhQjFoDhQRH+RhkK3qjttuQ8CqxOQ=;
 b=UNknBY2PvWC5VZnq0loZJ02sQqPDMeddwnz9u2Sv7skhCNCwJ1bzfT6xzrdneMmznj
 JGIBXIxh3M6wjZ2zQbrIp5ZCv6QJKO9gULmWgyL7kPCRMDgLlI1jJ7HccnMg81aK3TkR
 TciBtuup2F8iBAFLfCoQG8TSuaND0B3w8LD6yF2yStiBf1ANooJSgHzBSuQvNVLEsWtT
 h9WAzhxDXuAHu6fUNQ36nAfHsVXSA0xj46v9477a6zPkfZkocS9djNYYIYlXd1/SEy/X
 5cSyqKCsREV1dTeLgkHl+HMDR/UbG/vUq17H0j9ZmZZumMiVQc9bye3VY/GDHs7SbpKz
 pDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806168; x=1744410968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWF7rdm9ZKpOTMOhQjFoDhQRH+RhkK3qjttuQ8CqxOQ=;
 b=kc8RajtEGT54LKnSKhwCjkXZZIRT9OJ93Fft+MFW/zPgiVsKbs2Z3ze1uoVU+sYG9R
 4qOoxGqdxdEEVsrkebkUjZP9ffD46IBjDbp5GzFTv0pevPkmePLCatvos+GIY5UKLRXB
 iixwlPiOTJPDRURjO0x7hY9GTpg3suJ4gpgd2RXnjKKLDZvax6YG/q9abMP16kftSVrQ
 mHU7vn85PdOi77B4Ff8tpyBvWkql80aBBRgWXpLZ94UBNOT3L/z9PeqP/MtDhZfTqhzW
 lfZXeBdtiRQmqNC0VFsEPWdiKRmgPXr4DiacbbqFHWtjscQX7vaiZpcc0Nq9PB3XrPLk
 pqZg==
X-Gm-Message-State: AOJu0YyyapG4AJOTf+ky8lxf+tzctgKRuLjlDcD/nhiRtJ74x5r99gsI
 lLZ4kUCuog+J7WAzKc6qaIZrbeD7WRHfS7jiWEA0NEWO9NWoTHo1pNJv97DkwODGtYGOPz4uSRi
 g
X-Gm-Gg: ASbGncuEHiKSBpoFE9510w64l8K63MV2zFAP0mzihhKI8ed3w1AHDD8+pUfzSpuwVuN
 xCB3FemhOlfGMSofgXHe4gpCERm+9hwkytEu8ZNu1zjimGM5/zxc1MfV1xbXfPnwG8584eEZpiU
 ZRH3aN46+mLSrCwPUBv0jWDwiXD92E5iwCG1+ppSgcaXsYM+u42L9FfHUS7RtbbWDSJGRhnLdGV
 qmXTgnBnLOejyqK3EVdSd/W8r5you/wwTU+qBe3JfkqJvtI67uvlilTupl/jY31bonBAL920yBd
 S5l3YGGPI/wWaplCgWgh7z5z0b2XKvZhAj3Y2ac5zhcwb2oH8QhMGBtUZHjIpHks6LUkmz5JQiF
 Rje0VfDXy9XEd4g+HGRBhxBA0
X-Google-Smtp-Source: AGHT+IEJDeuVCQqd5+26e5u+Xkja1NbGYrALPQ3A0LUnM6TxcRo2jV+hsTPIJ/bYCN4WFg+E5YYW/g==
X-Received: by 2002:a5d:5983:0:b0:390:e9b5:d69c with SMTP id
 ffacd0b85a97d-39cba93bc86mr4406816f8f.25.1743806167717; 
 Fri, 04 Apr 2025 15:36:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968a1sm5446597f8f.11.2025.04.04.15.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:36:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 9/9] target/arm: Build Aarch64 gdbstub helpers
 indistinctly
Date: Sat,  5 Apr 2025 00:35:21 +0200
Message-ID: <20250404223521.38781-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The Aarch64 gdbstub code is guarded by checks on ARM_FEATURE_AARCH64
and isar_feature_aa64_sve(), only enabled for Aarch64 CPUs.
Remove TARGET_AARCH64 #ifdef'ry and build gdbstub64.c once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/gdbstub.c   | 4 ----
 target/arm/meson.build | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5e549b95e14..5fd2631e8e2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1682,7 +1682,6 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
   return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
 }
 
-#ifdef TARGET_AARCH64
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
@@ -1692,6 +1691,7 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
+#ifdef TARGET_AARCH64
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 30068c22627..e76142e8ddb 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -482,10 +482,8 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
     g_autoptr(GString) qsupported_features = g_string_new(NULL);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-    #ifdef TARGET_AARCH64
         aarch64_cpu_register_gdb_commands(cpu, qsupported_features, query_table,
                                           set_table);
-    #endif
     }
 
     /* Set arch-specific handlers for 'q' commands. */
@@ -514,7 +512,6 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          * The lower part of each SVE register aliases to the FPU
          * registers so we don't need to include both.
          */
-#ifdef TARGET_AARCH64
         if (isar_feature_aa64_sve(&cpu->isar)) {
             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
@@ -546,7 +543,6 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-mte.xml"),
                                      0);
         }
-#endif
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..503d106b588 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -3,6 +3,7 @@ arm_ss.add(files(
   'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
+  'gdbstub64.c',
   'helper.c',
   'vfp_fpscr.c',
 ))
@@ -13,7 +14,6 @@ arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
-  'gdbstub64.c',
 ))
 
 arm_system_ss = ss.source_set()
-- 
2.47.1


