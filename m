Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3BDCA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVzu-0005II-Te; Mon, 11 Aug 2025 13:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzU-000512-8d
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzI-0001s3-NX
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so4251316f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754932023; x=1755536823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXHYeE/dbTRdflhUmCNmx7Q9a47atxr+CRA/ufWMQVM=;
 b=SNku07GjtRGK5Zp5BGpsUb2eb3fJD/wrlu8en9z+x6mH1pzz0bLRmGgffnEKbipp0J
 cUMIIFvmbrZBMjaeVvgTbDKAhDbuG/Vy77kg8GqRG1yDW/AsYDIrIYBy9CytRViTipnZ
 eYiM+bI41NO7kYyT36qW7t/zRfqKzP+Yy3f+lpwI8ZMvydFr8EVVrmZ6GlIsdX6BpxUh
 MveaNjWsJG3epysNZRF8xVtMS72WDpRn7zcw6CfrZjAx+we2K4Ar6ia4zpMY+/9k3tgP
 9T5yNNGc2k8io/PME7LVx7wLTbapeOZuDXCoiXrMiZnW4NObtU5hDDpjaeuvJrBd08Xu
 4whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932023; x=1755536823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXHYeE/dbTRdflhUmCNmx7Q9a47atxr+CRA/ufWMQVM=;
 b=QOAnRtxe6kOOdXTYMSNKSmef0XUCqRnS/238dcy01hJqZhjxkTYKW7EjIZP4yGa5dJ
 /ZuNmHbNmqA+PfCYXu5Za18toldD02uwJK/ACAis05CI1eWGYyP6oRrkomhOxMDYt2xW
 CFzeLw4C3CK6sJ9FchLSID3uqBPeHYQXOjqDLCBd2bv2YRu+hsGwc213vaeeg5nmpkSb
 QDQF8fvlkerJn74QmbOB3ZW3x1raP5yAUQaiWd3lPbjfL3vSrME4alVteiVpFebiS/O1
 JXzxZ+mNfEDsjPVqpHDuo7dLWhW43UWUUT3LibxAHZImKB+XQCWu2xDpats3yOdfxnXx
 BhuA==
X-Gm-Message-State: AOJu0Yx0KVsn/GHmjDOdIhq7GEHFCeEoOKhbxYc71z5PN6D9wVgiRga/
 yj1Vu6aFjZsatBa7r9uurem63KApKPJ25w03cJNMfkBPTk+sneYkV6PEWoK61GbYqVyzyGL0ltv
 isEgA
X-Gm-Gg: ASbGnctGHH3rkXOqzcw4hegc+pL1NKKjP4caj8Ss9/gjq6odVWEoDpvdTKnGeJiThjd
 +o/KNcB4EQPcB6o8wEdF0yb/qthS4FQ27F8XyIgXCa2550bEFJAfFK9pE/FeknHFPwyaHqTivBV
 onC3/gLjPXgCebdRwMrmFiFoMJ5BkHG73BiOTQkQRRHaBPlpi3vn+c+7dhDxs89qE65HXlVhsDR
 PmV3vgVXz53Ptsf4njmk+5dbbPmb9K+zKqRFL6tlkVat2OTBRQ9noXYz1QwwwZXLiwI7PMcVsq3
 m6ZinYIay8NGq2gn7wopFUboVG78980v9rxr475jWgIfYoag3kzlzRGOLGBz+0ZMVadZTR/qF6B
 Ea+1Ogxaf955ljGnUFxFjC6AdxuxOrjTpgEnbdUX92h5xxHH6N25q7yiZ2nGkrjuqM8vobTN6
X-Google-Smtp-Source: AGHT+IFUuly7Dqrg66psU4QHCuRXsJhkEzRy6aRPP2+eyqivHdPhhh2IohEjZISBtH74GHrPxa9how==
X-Received: by 2002:a05:6000:2c09:b0:3b7:806e:7773 with SMTP id
 ffacd0b85a97d-3b910fd97fbmr541303f8f.15.1754932022551; 
 Mon, 11 Aug 2025 10:07:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf33sm41526775f8f.7.2025.08.11.10.07.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:07:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 09/11] target/arm/hvf: Sync registers used at EL2
Date: Mon, 11 Aug 2025 19:06:09 +0200
Message-ID: <20250811170611.37482-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
[PMD: Adapted to host_cpu_feature_supported() API]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5174973991f..778dc3cedf7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -400,6 +400,7 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 struct hvf_sreg_match {
     int reg;
     uint32_t key;
+    bool el2;
     uint32_t cp_idx;
 };
 
@@ -545,6 +546,27 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
     { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
     { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
     { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
+    /* EL2 */
+    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
+    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
+    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
+    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },
 };
 
 int hvf_get_registers(CPUState *cpu)
@@ -588,6 +610,12 @@ int hvf_get_registers(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_match[i].el2
+            && arm_feature(env, ARM_FEATURE_EL2)
+            && !host_cpu_feature_supported(ARM_FEATURE_EL2, false)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_sreg_match[i].reg) {
@@ -725,6 +753,12 @@ int hvf_put_registers(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_match[i].el2
+            && arm_feature(env, ARM_FEATURE_EL2)
+            && !host_cpu_feature_supported(ARM_FEATURE_EL2, false)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_sreg_match[i].reg) {
-- 
2.49.0


