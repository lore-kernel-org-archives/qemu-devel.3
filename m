Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE3C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6c-0004s6-Rl; Thu, 19 Jun 2025 09:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6R-0004YG-DW
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6P-00045J-8O
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so804223f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338887; x=1750943687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEhVLrdb7gQcxLJ9m8XmAJvi0CaJW+OAP6dVQwdaX2k=;
 b=co7q2S5zL8CPzJxxoclKDk9sDlkWepTKCxbde9rcpi2wi48fAxRgtak5HevxKNHPlP
 YF4cknyXNNkbOR91IqpCUnaU5tpbB3C4JWylSV7miW0axAZU71G99qcLxQjxsu97iLXm
 w9JJewA19g2yAPTCxAxjcY5KaYBlEgxZhNunrDZMd/67j4gnWs2FdFQXVg2iNVrbB7E8
 7cETyEPMWTzVAgn5PVpzUgQ94+cgQLZA1Bh35NzYnVA3R/0vc6AMbRcPl7qJ4/JIzD4M
 z0A8JyaLqI+cfBosWi3DlIqf9dUiURZf4bR1qGRcOLlsmGiRhji4VfXc5qEzdtK2sGE+
 1Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338887; x=1750943687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEhVLrdb7gQcxLJ9m8XmAJvi0CaJW+OAP6dVQwdaX2k=;
 b=CV0dguBoHZix477TeGKTSrhk3EkBQocGPuDMSJ3MMwvhciHq0ROlUkUFAy8+/nYA9Q
 yj5o74Qm9s0qkl2T2dMg7QJTmWtU9eIaJNy/oxuUrIUl48YP0cXmXRMqSyNPuT4NJ30X
 P0v9MbTPHfKqOFtGZL1/QUVL35wC7jXz9qvERTIyU/zgpElad7SCshuItHZykdhuWaL+
 1VbqittbXk4j95FzUds25E0Bwcandzkj0qO+mc4zWBGZXfcEE0ZMmf9bGaOblGDFQJdc
 CzXVduHbh+xyt/WJqL9bgpf7EpkbMMYjW8UKcPK9Q/QXUZAkb6iEngT8IVLOv/mc0Ddt
 Yqjw==
X-Gm-Message-State: AOJu0YxCfAISo/ov9WVxRWesKGgqs2rIJh/xI57zRbL70kPJq6y9aaeB
 +X1Zn0tkiZ0rHpNmOzSVOE/syfSWdWPDm978lgeqEMTI6zWWLsDLEMIXA7G7yrVyxR1KbnlPJvM
 YZASOGPc=
X-Gm-Gg: ASbGncs+jciGooxSeiqiRWunhjr8+gKSdIVKpS1bFmoohEU0FBItzXX+mnQKrPx/L54
 vBLontxgGA2SQGw3E3YO9c3+XozBnOP9jT1uzIz2E9y5oa8OhmeirQTHNjn0et4/jRapkMN5vQI
 A59ZBGt3Eqvln9Y0EZcFKltXmIH+qPXo1HwWw10ILA6pKsU9t3cq6rAO3+3AdqaNCn/uungoK1X
 /U7Www+p3fkexhNOzhIlw0kHMmjvC5XQH7Kuhlc2Y0ruccqDX/8QnJtHW4Fj/yCq/AwFLu+pstE
 vmaIX08SrYGWOuRq9kH/cmYksIPI4jCNhOxcvnjLf/pad8xXuV9P62tJQVxTOS1u+7mpWBSau6O
 i17qqwfNZanEse2SgwS8Fj6Znm9mM3avWvJAB
X-Google-Smtp-Source: AGHT+IFYyws/hie04Gs7cz38N8DD6RmjvKvx7LAHAf6xXnGxdc9ttG/TDPs6rEuwn9zHE+u/jqYJ/g==
X-Received: by 2002:a05:6000:18ac:b0:3a4:f6fe:5244 with SMTP id
 ffacd0b85a97d-3a572367b13mr17405974f8f.12.1750338887297; 
 Thu, 19 Jun 2025 06:14:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b3c0d3sm19567460f8f.79.2025.06.19.06.14.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 16/20] hw/arm/virt: Only require TCG || QTest to use TrustZone
Date: Thu, 19 Jun 2025 15:13:15 +0200
Message-ID: <20250619131319.47301-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

We only need TCG (or QTest) to use TrustZone, whether
KVM or HVF are used is not relevant.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99fde5836c9..b49d8579161 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2203,7 +2203,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->secure && (kvm_enabled() || hvf_enabled())) {
+    if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Security extensions (TrustZone) to the guest CPU",
                      current_accel_name());
-- 
2.49.0


