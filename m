Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8A5C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1L-00052n-SX; Sun, 04 May 2025 21:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl13-00048g-00
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0z-0002gk-Tt
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so3896982b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409984; x=1747014784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=QS4Yn/runeHc3++byhsuD0LZDuosUi6mdvZtldbHEhHYNUMM+c8DUxl2qrO8kfb+h6
 lS2iNMFbKbqrud+ZfSPwv0wpqXbZ0FPCGLsG3oBoq7UYHjg6IkUD+l73pF8l34Vrkg98
 BPSgMyMkDslcbC7Al+f1CB+I2QfSct/HGc9tLY9ho5V5pXR1diFrv7YqPNGkxtME6BgE
 LxaCb0Q4YKerhcBJiVF6svS3QmpRoc+Hr7d+i5HGZVjoV3/VzQAdDDr2M5HDHlZAFaKh
 /KUcrK7VVzX/jcW97fbeeUlr73kA4DXsKUiwFgulRNqeFd+MdJbSEnZytQkWY6+t2gZh
 OCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409984; x=1747014784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=jkDTMfRDsTjmisrWDYeUNHXGz/zQyNhAtUZdSW6I9CZeUbTFRmAKyZs2vi0YP/xDMn
 v9ofMCkxqB8FNsdQ6jneSluFZwL5jIbwHOm8BHTbdgWfyBooNPs/ztMILvFaaLQXHe/f
 +ykKvOOKbXJ+hwS4YLzwl6RRhcOsikrzilpBZvMAU+jKLQPtSbD/mGcYCZNjX7qN0Rkr
 vhO56wr3QoRt/hypDQiNmt9dgcIDUg/rUj9ZMaHhEKnAp+Ld/OK2uEKIM3k76cdy3JrK
 Yskym8poGkmsSMxr4Y+bWXkLkawTg7fBlI9vVP/Zn8I91tZPUyHACdtSVg965z9VVNCl
 +eXw==
X-Gm-Message-State: AOJu0YzckFygGtNazConm+AKfiKpV4pJozTvtOY8UtxqMmNcF/Tq0qq0
 B/4jvWZmrG13UVeag2t4hzmmAWnobrdkeNVzk4SmkQ2sOkZ0iUCNQKf2ce48257Mtur9/Go9scK
 ez8w=
X-Gm-Gg: ASbGncsaBCXG2MSYAE1dYtggZKbZ/ZiamLux09aGB7MAhqbUhfC0aT7Vwkm3wQMbaHC
 OqikxqLAFZ+f6aokhoRlk82TJqbYfy/6n/TVZVEd2TRjJNqnjEwaLiQJDX7dNYGV3Q/UjRaQ8qG
 6FGfQ4bTzbMBgiNWxfuw+Wk2cH9VkBqzmUlOMF2igQdwM1KRa5gw3l1N2hXTqyyRA+ji6/CwmFj
 96KTitQ8syehWnM2VLA0buYSktfNC5fpPSZEAakPNe7Yedm+wQMRWZCvViAAx4d3RAmyyHk74ov
 uobmtNGJZNH8dunqUPQikRo3FYyhT+/yrvzuNI6e
X-Google-Smtp-Source: AGHT+IHdz4XoM+G4ZSlVLLLI9T3NP/Z5hYlsd9kBRP8xO98/byZhhHtRa3EcBoUSJs9k3C7RjNhANw==
X-Received: by 2002:a05:6a21:9186:b0:1f5:874c:c987 with SMTP id
 adf61e73a8af0-20e96605740mr8115462637.15.1746409984740; 
 Sun, 04 May 2025 18:53:04 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:53:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 39/48] target/arm/kvm-stub: add missing stubs
Date: Sun,  4 May 2025 18:52:14 -0700
Message-ID: <20250505015223.3895275-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Those become needed once kvm_enabled can't be known at compile time.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4806365cdc5..34e57fab011 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


