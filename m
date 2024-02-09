Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D225EC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpV-0005Qi-A0; Fri, 09 Feb 2024 04:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpT-0005Mp-Sv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:51 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpO-0000fp-VA
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:51 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5114c05806eso1076266e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469544; x=1708074344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpf2BCRR7hPdbIWz71eTijHKC+DHO0kimrwlNqyg5K8=;
 b=XcOz3sHwK+yWKiDV8T3HXsECSp1u+HGOr1d6ZgsywVsqS+OcsH1GMnEvKHUCm+8BRe
 +5crdgjj9WksgyfIHb4UnOm8IfBNWAD/4ELAPpDDzpj3x3Q0L0WCs3gPnEjUaRYPlnye
 EAe3pxCK8OuxHdX2pwfylOBcdkDcCrKGjmlxngfhxR6M/N4XOkk5yvIEJYkKvN9+7dVL
 Ksj3EYZ7gdiz60/FBltbEz31KZttuubXa1U/LkCVZBDcezB86et3etiw++L2dgbRgv2Z
 m/eyRiCFA+kHJPhg+X+0F9ehhQJsM6n8uY+n7euZkjXlyoSS+HBnYGPb970nC7315pxw
 FQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469544; x=1708074344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qpf2BCRR7hPdbIWz71eTijHKC+DHO0kimrwlNqyg5K8=;
 b=gCdeiexXZLtl6zXal9aRlSsbEraYjHNIsP9CmHVle+6/qgTFXuGilJ7V123Pg6bThf
 Ruc56AIvZeBdHewWCHw0RgLJBMPuv7BLUIMKmO0DNQ8nGR22eL0tb+g4Ag83Njx2l7LT
 AsLl/sv5lM+m9ddo+VHG4jo6QWem6we5ehuDo6kozJ5JrOyeXPkWZm9HS6eKNaWMA90G
 pB0TQ3Xrh0iHkBS7yeN1pVsNjiERk88NZhoMnGC8x62wOW66C8mLAd+qlD6Th7ZTChmQ
 sxB+MS9ZH7+qnnFL39Wf1kMJM2AltZtFF0xKEciMApqCspjuvucj1mBxsdvDkMKD3Eni
 WGFg==
X-Gm-Message-State: AOJu0YzCjQfHLXUnZVBBgTH3dNvZJfCPmpdE6eKeJC/Uyn5gTkkZZ6sG
 22zm098TJrXkuL+laK8n1F9aZ+gC4nc6cV7Q0PJ2ZIbydSdL+KHu/AnRsqqs0V8yMzlUeedrH2O
 LYRM=
X-Google-Smtp-Source: AGHT+IE4sr/rZBn6EBCQRN+l3l3RhGMcqxvbjwIoCMExexT57WcTin6WUG2v/4BBgRz+nXOi072krA==
X-Received: by 2002:a05:6512:78d:b0:511:5038:462d with SMTP id
 x13-20020a056512078d00b005115038462dmr630334lfr.35.1707469544677; 
 Fri, 09 Feb 2024 01:05:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWwDHz+ku9Hx40nBNGJCb9YR9770+2JXMws/373YpivcECTvXNX8yESal9MILlALktBMQkYhgO3fcqeewaXOWww/QSDmFYmEXxey7xTLoFq02Sb2jnbUyERoiJeGBtLYAncRLPM1OGDQj2KmhJ4rP3qIKqHpfKZyp1IK1iG1YVhZuVoVGmkyrcvJN7bJTiEexiwU1hlv0b5FTwLhEro5YMQ3y5UZ9WewgFG0I4ONe/dgOcZMEt6NDpIu7qKOvmfcd1kwGw8PK9V00RkPwzkXv3ZNwvt0ANnNqPvpc360UyvI6nxrmcXaXad4p0c9jPeH38g4eF5TzQiU1EGGsTKFunb+VuOPLw=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 n44-20020a05600c502c00b004104c42ad5asm1965943wmr.22.2024.02.09.01.05.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 05/11] hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
Date: Fri,  9 Feb 2024 10:05:06 +0100
Message-ID: <20240209090513.9401-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since previous commit the MIPSITUState::cpu0 field is not
used anymore. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mips_itu.h | 1 -
 hw/mips/cps.c              | 2 --
 hw/misc/mips_itu.c         | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 3a7330ac07..de7400c1fe 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -73,7 +73,6 @@ struct MIPSITUState {
 
     /* SAAR */
     uint64_t *saar;
-    ArchCPU *cpu0;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 988ceaa0b9..07b73b0a1f 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -103,8 +103,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Inter-Thread Communication Unit */
     if (itu_present) {
         object_initialize_child(OBJECT(dev), "itu", &s->itu, TYPE_MIPS_ITU);
-        object_property_set_link(OBJECT(&s->itu), "cpu[0]",
-                                 OBJECT(first_cpu), &error_abort);
         object_property_set_uint(OBJECT(&s->itu), "num-fifo", 16,
                                 &error_abort);
         object_property_set_uint(OBJECT(&s->itu), "num-semaphores", 16,
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index d259a88d22..9705efeafe 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -527,10 +527,6 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
                    s->num_semaphores);
         return;
     }
-    if (!s->cpu0) {
-        error_setg(errp, "Missing 'cpu[0]' property");
-        return;
-    }
 
     s->cell = g_new(ITCStorageCell, get_num_cells(s));
 }
@@ -558,7 +554,6 @@ static Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
-    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, ArchCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


