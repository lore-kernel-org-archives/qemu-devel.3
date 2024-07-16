Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01E2C3DA5E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThe1-0002pf-Px; Tue, 16 Jul 2024 08:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdz-0002kA-22
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdx-0004uC-EC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so3355836a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721134256; x=1721739056;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPi5Z5Dqnhv2/CUnyN+zY6OWPqGpJunZ/ZxJTeOyVqc=;
 b=fmNMP+gcf/eMlha1aZVA31QPnCCrZDZRdDE7TZvV9XFRmrCK8SZjfmwr/p9lWSCN+D
 aenNoci9yMNsxLkf9b2ByqTrC3BBy0e+E4uaFZVdMmllwdKr2mxvbzTBHyIUt3Mvjt6q
 p7quNEAGih8qAKILQxPCkwFna4Gt8GUw0UKTK6x53gsAqPSrsr0APUofiA5IJIRbcJXt
 aNmMZWiKMQfO6vHmjYCdOD3s7oXENy0GHooLcGYPtPwwjnP3DEHOkPMVnMcKxxhJjGkl
 fVVwr/KpHz++7iorTPOFIOhB6Trpuqvwdps4GmLFuPEP25Gv1jCYS9hoigZfTwUI3CNS
 J2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134256; x=1721739056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPi5Z5Dqnhv2/CUnyN+zY6OWPqGpJunZ/ZxJTeOyVqc=;
 b=YvK4p1/FEw90JUHngAA86fhfgpAiE7PlGThGSxZmkwhHfutPLwGy0ZwM+/PDQ318WX
 HA6TvRw3yK6wFn73OwZVAF7eWhQb58jV6l1U5y5Crad93fpdeV/r7MANoTWqle8tn7Ok
 FPLayui3r8X0jf4KaXRNPIzAX472GhbctyU2yOGuL+522ykyahLVpkY/AJDjfrTg31Mv
 JiOQdJAXoyl6INQ2IrnaqLAo7PriMHe1ChUwJMaZFCT1xl01laY3vYYWvcIR8H+KvQpt
 BZHajLmg/AED2J2PcDcFLnxxZuxkQpOR03/g48DJhnmKl3eSsblc5iHGIHPdiKJgbJlV
 Tp8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXrg7coFMW78eVQvc58tQtqSuLxm6nJd/b1TUUuQawrAAbAjocBMs+EELuncx83pQp5uOGq8ijGOaMwVXOL8gfEAoeavE=
X-Gm-Message-State: AOJu0Ywer35ETwnjh9AMLRcvqEbDBuypkzOeL5I0Oz9l9ycZIv/1FFej
 rycsF8g8Z37OCc5dcs79tmkYRdleK+6PjP47VXCzbHqv/z9YxznNcwivxNilN9k=
X-Google-Smtp-Source: AGHT+IGiq7H1/utXn4jDP5eSrc47l3uUiIjjIuyDBP7855yWUI6xcCAqvptjtIWknKwAKTVj3TUcJA==
X-Received: by 2002:a05:6a21:10b:b0:1c0:bf35:ef42 with SMTP id
 adf61e73a8af0-1c3f11feb77mr1915725637.3.1721134256139; 
 Tue, 16 Jul 2024 05:50:56 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bba7080sm57618265ad.89.2024.07.16.05.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:50:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 21:50:32 +0900
Subject: [PATCH v3 3/5] target/arm: Always add pmu property for Armv8
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v3-3-8c7c1858a227@daynix.com>
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
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
corresponding features are not available. Always add pmu property for
Armv8. Note that the property is added only for Armv8 as QEMU emulates
PMUv3, which is part of Armv8.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 14d4eca12740..64038e26b2a9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1744,6 +1744,8 @@ void arm_cpu_post_init(Object *obj)
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+
         object_property_add_uint64_ptr(obj, "rvbar",
                                        &cpu->rvbar_prop,
                                        OBJ_PROP_FLAG_READWRITE);
@@ -1770,7 +1772,6 @@ void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
-        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 
     /*

-- 
2.45.2


