Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51435C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiM-00032i-I8; Thu, 03 Jul 2025 07:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfc-0006j7-SB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfA-0003Tw-9T
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso5602893f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540370; x=1752145170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZcPe3nYMdLPvpkVihaPaKQWmWCYPUgBDgbI5JlWA4I=;
 b=UJ7MXwxMuuwYAkKsOoHpFJCmEyG828R8qBa5G26iO8DoEbYc2x/qZPFhNYaP4w5zyT
 mLtotNLAVJcioE64Uh69k8uskRYqkPBOPZzyqYLD+/L4HsQCYbehoCOVZOXDxpSvBu8h
 XaTLwPWXuBBrjyh1pe+8NhqoVVRoevGSnTbGYQgoj3bj2hkRsiUZOomzr0Hxw2uq3GsW
 tGGge1Rw24RyafttIa2zxRTgnIMZsUvEaZg3rAjNm/SsUdaCHyDQuh7+OIXVoA4q6Kyc
 dDBU+2NXqalMzGc6bJGAqZDe6R8/8wtKDeZOGNuUQTv6fKafhD4em9luk+c6JEeO0nyA
 moDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540370; x=1752145170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZcPe3nYMdLPvpkVihaPaKQWmWCYPUgBDgbI5JlWA4I=;
 b=J5NHBcLoKJ9t6Kgkc6DgGkTrZ5XUwI2I9rsgfz3T5sKlcnRIUZWv/KFBbJNdxKdDRh
 jTjqALM1HxgLnvzvkAhjyALKI3oJZWifQE5FOc88sUh1zGo8eKseYjfnDtLtgpo4houo
 3Y+Syjtp3E68ZtdcsxhrI2kVnmRlF6ona1mzdWGDXHx3NkWH+WgucVTPHwASH3MfPusk
 u6AGLD8SKr15EJDlo5AiJYUP3yjyiEMftxNSgEd9o37fH3wk9+X/v9UYQCFXgLeVAaQu
 dwRIQLfMmUjfws1Twa1OM11RO+fUfk4He/87UWWUWKn5WckHLFNOBueSP476R4dF/QmZ
 6i9A==
X-Gm-Message-State: AOJu0YwdFoBR3yUud9YbHI2yH+AdqQSMwY0n+oWPQcWsN8Ecxcu6B+ZS
 2WLq4uFatf+6GXrlI/alUvqa0393y/ukEbH8Un3VAri/gq5TRksCxUaNqk22Ac006W7DuRH3UmL
 U/++8koE=
X-Gm-Gg: ASbGncsR29Sqh2efLO+CXq7NSN+G4+faNL2YV5j0bjt7KFhJTx9mbDQ51viSL2hD6nM
 J6n2Agq3DiyF0VEGYR3BSUII51xcsabFlZwzc+0YeJlh4brcM/Khc/8UFyVU3lK5NXXPkhGwbSB
 crZQhzLFPDE/NTmvTEpyzQpCCtPcnoV7QZlTyAqiruRwBQMCRLbtgAXLvICZT6cnrHvGyO6fL/W
 2TGoDgzZGs4RUdgxmA2Gqdmzij+qM1wYzA+/IH0WMrvWloOqMYCxfT/AMF2y848Gzx5LyYpyx24
 lPW5gWYUk1adLandw7D7oY3W39Jn9dukhK0DI2lZ+USPjDvg+s4ML4gJinZL99kMsFO/UDtsCzD
 mZJW18GQI2LcH8euMUtVGQg==
X-Google-Smtp-Source: AGHT+IFwze08KXrOCaSqmcyC/CFjfj8WXq9xrhVTjrBsf+XDLBCCaa31XIZMiSWUsLRl+UJN8QFeBw==
X-Received: by 2002:a05:6000:4013:b0:3a4:cb4f:ac2a with SMTP id
 ffacd0b85a97d-3b1feb84b5fmr5425886f8f.21.1751540369971; 
 Thu, 03 Jul 2025 03:59:29 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8b6sm18670570f8f.91.2025.07.03.03.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 43/69] accel/system: Document
 cpu_synchronize_state_post_init/reset()
Date: Thu,  3 Jul 2025 12:55:09 +0200
Message-ID: <20250703105540.67664-44-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 8 ++++++++
 include/system/hw_accel.h  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index ac0283cffba..77bd3f586bd 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,6 +43,14 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * synchronize_post_reset:
+     * synchronize_post_init:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers to the hardware accelerator
+     * (QEMU is the reference).
+     */
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
     /**
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 574c9738408..fa9228d5d2d 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -28,6 +28,14 @@
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/**
+ * cpu_synchronize_post_reset:
+ * cpu_synchronize_post_init:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers to the hardware accelerator
+ * (QEMU is the reference).
+ */
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
-- 
2.49.0


