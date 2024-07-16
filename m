Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A0AC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdY9-00067k-GW; Tue, 16 Jul 2024 04:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdY6-0005zJ-Hi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdY4-00021V-W9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:38 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso4103444b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721118515; x=1721723315;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MzrJ2SIc0b0nCcptbEys+0+C2juhcCeb9eqlhLMneTY=;
 b=RjhIQy3Jn61z6pWbnUKBtfJ5E59Fc78RYzT0HLUCdq/S2QN48PdGZ5x2Wu7hQ9fmBm
 PFu26cX9z7fmRqgWmjd13KDrmQyz//w9MJgzo5CR28S8C7Udp6XHfTb5YpAvYrKK73il
 eSeS5rI/HHuyDId44GL+BRxEEe+3lxl41oDsSEYJUUKUmFGQoA9ChWpxTmH0RG/ZsZei
 2RrEiZJNsIZda0KYkdscSLkVQBvAqUkL7iUhCuH70MP32xGTS9QzP2nG+PdCE+wheNQb
 0IqcoD/sRpR5PAlLGhUBms+hhzytZ76gkgOpcbF11fARBFGu5KFT6dWmBe0RrgykIsYQ
 dcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118515; x=1721723315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzrJ2SIc0b0nCcptbEys+0+C2juhcCeb9eqlhLMneTY=;
 b=BbwZ+rRMjGTPCXNfUyBu4uKxpW8+C6HZuCF3dBVfoHHheW0yK9wkJeu9+otqLfoqTQ
 4WummgoqkxxuX48mBQqo1ilF8BVUotENjUqS7OjRfMGmI2NlljD3YMC6hy/O593zvLI8
 Hr+Lvr91V1PG/sVOltcPF1CGtP1owWpm9borL2RCiNbv/YrIhiKcWBH+s4KJiJu52zDq
 abDBFkwzCacodnGdsIY1z/xizW1vBDxnpdzv6zQ7Gsged/JRTQJXOkQZ42Sv49IXWPp3
 i7R/PtRCg8E4P1ZWj782yFfs9WeKwjKyM+ZGVRuGepwdqkhjWOVYOc+Y4gABdOx8GplR
 EQTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLTrHITK07A+sB32duwP8iUFcarJmSTQ8UyfAuMJ1LTuyMmZXqZ9NpRL4jSiRcNj0jJd1toCbnYNJgCRtJ6Hp8uOVjK1o=
X-Gm-Message-State: AOJu0YxTqw0HUWbdOi58K8roVXYH+Co3Zi9S3kLiZC72iujsoAHXrnOD
 mF0da8wZ+3ljqVNGkpLTYncqNM8z/27ofwBEuAQ2JVqphpJLHtB96byR4ppZyKTF22J6jOS6fak
 2W/I=
X-Google-Smtp-Source: AGHT+IEMIQeQRXNUb8ccsuZ8VrtU3dndgT6Vd8nvN3x21ZLqX5Ahg/3t5RVankt3OZCxhbx/gbmsPA==
X-Received: by 2002:a05:6a21:6da9:b0:1c0:e629:3912 with SMTP id
 adf61e73a8af0-1c3f12a2231mr1826892637.48.1721118515601; 
 Tue, 16 Jul 2024 01:28:35 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bbc2e0csm52710255ad.106.2024.07.16.01.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:28:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 17:28:16 +0900
Subject: [PATCH v2 4/5] target/arm: Always add pmu property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

kvm-steal-time and sve properties are added for KVM even if the
corresponding features are not available. Always add pmu property too.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9e1d15701468..32508644aee7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1781,9 +1781,10 @@ void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
-        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 
+    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+
     /*
      * Allow user to turn off VFP and Neon support, but only for TCG --
      * KVM does not currently allow us to lie to the guest about its

-- 
2.45.2


