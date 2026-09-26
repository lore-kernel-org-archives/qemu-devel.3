Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55000C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMQt-0003Ju-QS; Sat, 26 Sep 2026 03:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQC-0002mO-JV
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:10 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQ9-0000UR-PO
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:07 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-340fbf9c1c6so928250eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406124; x=1791010924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hrGKgFew7a5BWVed114GbJvRtNCR8ABRcbnE53096fw=;
 b=nuBHQgRPk4XNg1vnVEhVthOzeIsVa+5tHrQe8+ydRnU+xVbtlrvvPnB/nCe6EMy5+Z
 tO+oSLHwDY50tRwvxJtibe6NU+/VLwwTJYwOhVgfleozZ/Dn9qR/XvvIWM2yeIfIxWkK
 IOVmZXVDP9/SuUxOE7nQ1dTNkSMnYAV9FmcNHVX7fdTBxD3htK+1dVO+hOGRXaK19Xpd
 4uKpCwlO815RH+wLW8jPb/B0EE0lxEEnuDxFeFfzhIUtp2FtPof9lxAk1ShNIZ5Rqdbn
 0OzT1MJ0D7TsqD3QRYxwo+3DgtHhOBt6IFUMOQEKm9ix0KYzKjp5j23fXg9mWMjpbbyv
 ExpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406124; x=1791010924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hrGKgFew7a5BWVed114GbJvRtNCR8ABRcbnE53096fw=;
 b=tZyZWZJX6Hl1Q1FJDcI4KJOMwyfS9J8AL1PytDrtYRuOVMsnItZCqy0mLJuVPF/C7G
 tTHic1n7VsAXAhvWiy12PJXxrtnhpDj5XzSLLbjNnbIN22cgSuU1/8K1x6lv6rF5+9l/
 kAkQGtdA97GiwC/Lrp6akJlYRPtkPBEM8vWO9vTcnlohD82bESIXaHNeRMUmtFRCT5/I
 hCw7TLqMDRY9Y5fsCoM4hdOdpLjBWTrcn3mNBWxRq9T6ysF7x5yZoGzn6HN+t2VtWfV9
 61SbQKnc3D+A/O+qYUDt6ZhnwbBu69SX/Wr6B0cvVikngkToJniH/O3GEwbfaLv7q4no
 8M5w==
X-Gm-Message-State: AFuF++mls4+MYEdnXdB8C3WAs5ErBb0XOnzQC+NIDLmvUHm15mRTJD47
 BNq7kiBTknhp2wpN/fN8y/e5rM1778zvYiIWAt/tCUyYFHDoqfRr4cMTukdHI7qE
X-Gm-Gg: AYBFou348hVFGx/m6BUrl4fT8lSR3hhAdhIno0GTjXHf9MrsldDbz97FQ89ZuxAKfX+
 AdvIQ0Vh0ARuioX7P4KWXN2dyha9dK5VRtJWP1umvo9F+4z73Fl1EE6WHAf1m74eIINax5lumn/
 qBGf4ruwPuyV3/0MzfBsy6e9jRhtxvkxt1HBY0ftiRZ07e2Bg+rud7VGrjqmBPsdoGyN5wB746P
 sjikKAm7hzAyINr0npJviVyecLUFl38ecTxUWh/sg3FG1/LnrOHG9d7z9aBU9D/BOAUFvHlNoPH
 gB5KoOyvJTji9d9/P7b3ZzR9YoIRxZO1X3oNbgkKi3HDz9aQwu3WuNe6lmUm/pPVrOG4CHk6Sd/
 s9oThMNNZDk6i0WUFkObJVjOaM0dbYcX+wBLYvNGOFl6/SF76mVmgsMwgilzY7hpFqAcai62QF6
 NinUuBzZ0fmGz2ohssMN2y4Oi+LY3rPyd/SDfB5ldsxF6ip4eWRCmbhriGdSpOH+MgPLtI0o9uN
 yPBosNpeMh4Nhvji9XQ/PbJuDX9SLXT6ccieT9NsQ==
X-Received: by 2002:a05:7301:2224:b0:341:2466:2d68 with SMTP id
 5a478bee46e88-3427304d4e6mr1888482eec.38.1790406124252; 
 Sat, 26 Sep 2026 00:02:04 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:02:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 15/55] target/arm: allow -cpu host with Nitro
Date: Sat, 26 Sep 2026 15:00:14 +0800
Message-ID: <20260926070057.1234-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Register the AArch64 host CPU when CONFIG_NITRO is set, matching
the existing initfn early-return for nitro_enabled().

- Add CONFIG_NITRO to the aarch64_cpus host type guard
- Treat nitro_enabled() like the other accels in realize
- Mention Nitro in the host-CPU realize error
- Set host_cpu_probe_failed instead of asserting when only Nitro
  is compiled in and it is not selected

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/cpu.c   | 5 +++--
 target/arm/cpu64.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 090470da40a..c138c4c0587 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1835,8 +1835,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
+        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled() &&
+            !nitro_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF, WHPX or Nitro");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1e64eb54cdc..03f3d55f6ba 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -774,7 +774,7 @@ void aarch64_host_initfn(Object *obj)
 #elif defined(CONFIG_WHPX)
     whpx_arm_set_cpu_features_from_host(cpu);
 #else
-    g_assert_not_reached();
+    cpu->host_cpu_probe_failed = true;
 #endif
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_pauth_properties(obj);
@@ -784,7 +784,8 @@ void aarch64_host_initfn(Object *obj)
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX) || \
+    defined(CONFIG_NITRO)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
-- 
2.52.0.windows.1


