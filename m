Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBD0F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcv3-0004iD-0Q; Mon, 09 Mar 2026 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcv1-0004ZL-FZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuz-0008CE-Lg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so9338655e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071596; x=1773676396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=44Beolhsb9IaT4rslnVVRU0yRvy4qFxSOsfGseaGZiU=;
 b=FsssENkXPdC4FIkjTc3g5ugSZwY6zAWOMTDDM6qac0Krb6qmQr76I09ZQfk4OeF1mU
 DyiBm5aiN/cQajH4gDYP3abIYirGea4u69aPQ5Q+Txm6G4T++o7kQh8tyljoTyr195/Q
 pIw6APVk8lYDbL28bTe4oI1wEdIaJwU+nWQcxCXOgGHY4ghizP98mUwv9kG+RzWohY7i
 EP11Yg6/FmRYBKtrPn20rkVrNjkFSVeeTSFAGPuRMiTDcyrrz+TH9OFkIpqzgV9Vce1u
 K/WsJti9F6z3l9dPzSbLOR/g2M8i3PXeQiCHtJ+SkIYMQgyVs8d4O3KyUtlkgEHNELrz
 h2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071596; x=1773676396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=44Beolhsb9IaT4rslnVVRU0yRvy4qFxSOsfGseaGZiU=;
 b=jPseBNa1W+kfE4prJe5MfhJ2JT2u3ayBizJ8h84fqcQOl8TJR7rx5+XTIgFT0skrEv
 92S1oUcf9zOqm+77r8o7Y8Hs8xFYe/Jy2RqbKXelVphbk0ifWPjzIlgemaKp0ROfJoZz
 DwTsltO457EqWrrFdcW8xtxU+vxOWEf6ryzfRBkJXrY/fJc0pQ/sufsOT4AToVIEjVva
 E5RzntEo2blfMbjx6ahehH3lUR8rkMOAEGqRgbk7AuiafL8NmNdMnrPL43HapMaWl/KA
 0GtcwjgzrgZ6cnJmGWs8BlbHzBY1KTiXV6XSslSvVhF8Mmc2fm8btHPU8FuXlNP4Vj1N
 JO1A==
X-Gm-Message-State: AOJu0Ywy+eWnk0xqEfo+6RGh++uTIF5zzspntqDLvfsRlq93Ss2B7cCc
 r5Cw7a9JLD26rIolbiQcpWQGHpVOmNlXqe4ZCup8mpnCe1stOIeovRHAJX1G7wIIK0xiWkc3dIp
 8ltGPhUE=
X-Gm-Gg: ATEYQzyk99pUTVfmcfod1qKxLX3xnsUTf7zcT9Ay4qdwDHfwwYuEdhhjsuxFNbSqMct
 x/wZPikTQYCFQqYyVflrRgVmPXHR6LJAkEiFfLkaIYwcTY1YaCPdYi5PFk+3BINwzEaUUzH2EcR
 0lFXjDgeKqhnnGJ5H7IN6gMBkwe8ryLleCtn1YcKqq5gclolEG70Ax3fZ5rW3VGh1plXEKTDW3q
 KuG3vWIFBiOXL76kJJp8t6Gh2lbKCBsJRtibopbaDuqtQJWAz89TRBRBnQlnF5yL4OGpxSn0P8+
 nkZ0kGqOew3tY9ToRi3X1IRXwFlsZYRlUOH9T4WEQKpvxiGWl1vgXnzVmM9yneghTSmUKs7pJtz
 ZX4z4gsVzX4tOdMdg0MWYIGkk9GkKz5fm6PGZUfKu33svRAd2H855LbPsPck8fN7wN6mIEPO0CT
 QrbLIWEKjpI9yms0kdWVTJcRRWisuDtWicU+GA4ulIG+EDr1a8wERMEQwEYGSp+tkAgbHrsaT5
X-Received: by 2002:a05:600c:4445:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4852690fffemr213920095e9.1.1773071595606; 
 Mon, 09 Mar 2026 08:53:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae57c05sm25504559f8f.39.2026.03.09.08.53.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/49] target/i386/cpu: Remove X86CPU::intel_pt_auto_level field
Date: Mon,  9 Mar 2026 16:51:38 +0100
Message-ID: <20260309155219.62400-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The X86CPU::intel_pt_auto_level boolean was only set in the
pc_compat_3_1[] array, via the 'x-intel-pt-auto-level=off'
property. We removed all machines using that array, let's
emove that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-8-philmd@linaro.org>
---
 target/i386/cpu.h |  3 ---
 target/i386/cpu.c | 10 +---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2b70d56e9b0..5a62aa61579 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2457,9 +2457,6 @@ struct ArchCPU {
     /* Only advertise TOPOEXT features that AMD defines */
     bool amd_topoext_features_only;
 
-    /* Enable auto level-increase for Intel Processor Trace leave */
-    bool intel_pt_auto_level;
-
     /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
     bool fill_mtrr_mask;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c77addd2c25..0a29ff805fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9565,13 +9565,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     /* Intel Processor Trace requires CPUID[0x14] */
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
-        if (cpu->intel_pt_auto_level) {
-            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
-        } else if (cpu->env.cpuid_min_level < 0x14) {
-            mark_unavailable_features(cpu, FEAT_7_0_EBX,
-                CPUID_7_0_EBX_INTEL_PT,
-                "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
-        }
+        x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
     }
 
     /*
@@ -10589,8 +10583,6 @@ static const Property x86_cpu_properties[] = {
      * to the specific Windows version being used."
      */
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
-    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
-                     true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
     DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
 
-- 
2.53.0


