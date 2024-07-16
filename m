Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA728C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdYF-0006Yh-Eb; Tue, 16 Jul 2024 04:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdYD-0006QZ-Bc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:45 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdXw-0001yr-GM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:45 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5c69848ca98so2793534eaf.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721118506; x=1721723306;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYXhIuhb5B0Jyjgf4vjtjqsff5UW6UTsThhjedH3LOU=;
 b=X9kybmC3AyQ2/cancZTdKtxp3H6o3s0kTBH8qZ+j9ERBYLH7TH7cRmowT5NkMZSpmo
 c7mv46aCR0eVUD1mMhpQHMfoE+2MQmFh2THIDH10uerVFjk8WdWgf6UF47rF/6tCkzcH
 GCi4v+UK6ff18J7w+YZyfH4dQ8Kwti+jPJPHWDpVYAKKoyhJ1TqAQH+x/PRPij8uB8js
 RioTmC4BosNK7r0L/7FAAPr+F8EvwOCwSEeKbJ+9xsC2GL9te9R3elYbpYmtjs46AVC5
 H+uxLvlnogvwiMREFsmb3PUukDCh7Sk0NG9f+xfNJDJqh7FQdoAGjnMt9ZcAJ/autbsJ
 rfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118506; x=1721723306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYXhIuhb5B0Jyjgf4vjtjqsff5UW6UTsThhjedH3LOU=;
 b=BRifR9+pDSRf633ZnBIY2o/kUGmXBHk1YavdsXXg+FUJa4MffWVTlfboWHH/LEzZ7k
 GrEtfWLZwjeOovMrPyXQamMAKHtFFfwhzDl1MvNtPqm2n5fciLHCJrO903OxcyS7SH92
 8k3/vwt2iLeBIzB1Xrd5glpUq1jZNQ2nLv2/NwOBcyAzF3764mooj+Ns7hC0ZPv2BLaB
 Nqs+jqBpmgIMuYQ3GS9pDMWYCg/fhMwM6GmYclyb6ripIQr0Oe7eLdhAACOK/WBLn1kN
 zoUXaUB+E+jrpzcbNpAR95SKgm+MqLSnmznt9XJ7u9Y6FF5GRgEWYZV4zekJkdZEIfXe
 +JMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZZVofZ+8jYAO6tjz1LlmP24jEGJwC9NEJSW29dvdjEFQEor9dtAZeHYhS0SPKtFqcNb1yQggGNdCvFknjHjVfRPlhngs=
X-Gm-Message-State: AOJu0YzwvYJ3Y0twlSaPdONpj82XCymcaFFruZEqK4dykBeWB94FLLk4
 zHJu5p9OWFEG9LFearys0S0J7vA79yLNpaMIh87hA4/PWynRluED8fjouAhPUJ4FaDvGj3849yS
 Fb1c=
X-Google-Smtp-Source: AGHT+IEX8BPbI+Uspvd6hlS1L6kD1r/n31SaoBBK7fdOERooqOo9yLQcoozSvCe+X8hABG0SUUEteQ==
X-Received: by 2002:a05:6358:9486:b0:1a6:7af3:22ce with SMTP id
 e5c5f4694b2df-1ac901cd215mr127136755d.2.1721118505875; 
 Tue, 16 Jul 2024 01:28:25 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7910f291ee4sm3222889a12.86.2024.07.16.01.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:28:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 17:28:14 +0900
Subject: [PATCH v2 2/5] target/arm: Allow setting 'pmu' only for host and max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v2-2-f3e3e4b2d3d5@daynix.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Setting 'pmu' does not make sense for CPU types emulating physical
CPUs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 14d4eca12740..8c180c679ce2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1594,6 +1594,13 @@ static bool arm_get_pmu(Object *obj, Error **errp)
 static void arm_set_pmu(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    const char *typename = object_get_typename(obj);
+
+    if (strcmp(typename, ARM_CPU_TYPE_NAME("host")) &&
+        strcmp(typename, ARM_CPU_TYPE_NAME("max"))) {
+        error_setg(errp, "Setting 'pmu' is only supported by host and max");
+        return;
+    }
 
     if (value) {
         if (kvm_enabled() && !kvm_arm_pmu_supported()) {

-- 
2.45.2


