Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A83AF417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyc-00067h-HZ; Mon, 09 Mar 2026 10:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbww-0004JF-GA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwr-0005jv-BX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439aeed8a5bso9124617f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067865; x=1773672665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44Beolhsb9IaT4rslnVVRU0yRvy4qFxSOsfGseaGZiU=;
 b=mZ9QcXV/JIVJ4wGbuSx/IwPsqXkOrAOz4LxX6AZV7Ko0sgShhcxXIYcTAaYv0NnkY1
 X1IfNhGgQmvQ5Zs2T5PQZJ8fPxg+YA3KgkzAh2kNHI+Er1WTQz+Pmy9G16q3lvPPXfOS
 vSLMB3X826eUeIsn3x+chF/k43PdNorYHLxOXBlNVvn2NYRZwD54yEdXBog0ICXYG5Fl
 lH0p7R4VajGtM379IUvotxvQQseeUaq6NNR1J5EiEPK2NEJXCe3kvfrOqiANHkcSJEPC
 KEVxK+nSrwHvVrKTTOG/t45TVwOHANp0Ri4U2Mcrbq2P44Gtt9ByBAK7lsM7XmPkyICv
 vopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067865; x=1773672665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=44Beolhsb9IaT4rslnVVRU0yRvy4qFxSOsfGseaGZiU=;
 b=cfjQyu6lna7GB7YAypw51KyjJ+RXoA2988HohENT7a4Bf+QRpn53y68ZLmULUX6wUt
 zXyNxVfgB+K1cG167rDTF+Le+Fr03BJ7mRllzqboixmnfVKMxK2pNwSBuxVxX+R+oFj2
 q/Ziv12aPkuIv1lIWkAlaTr0cW2Y15fSXsaXXuD0lBbb+f+aox97iPaXZ5tGDwKhtCSn
 i4iyNUGHDa69ph4OVD2FMX8e5w4jRhkOi9id2ZVY5I6SaKv+Z47xAK/OvGs/wQ9IqVDG
 Z8csTxfHfJ4wPFwqhyF6SHtuLn6UpTLzwGcH8LZVFdK2Jb6y7w/rg0m57z8Y68+NrJFF
 CRRg==
X-Gm-Message-State: AOJu0YzmD+Mjf50YdOSqIpzsNr2/1viCi9TWKEDGNrrUc4899wWH4Qyp
 TKvfJI0uEAGB8fagfd9lnXUX9ldX1I9kzAykiGx13NXE8rCpjSYlGY5cYqmLI7gQfWFfucn+mxt
 cxQTNndo=
X-Gm-Gg: ATEYQzwku29Jg+0rhGryQ9GRYk24vhUhu+6TPunLsHgQ0WPDP24QVktAKcqdDKL4qG8
 z3aDQbXBYpePVP4eNJFsjmiA2wTAwvnUpMEMpt4Ht/3bzhu+yH7tSXtr/S/psCFX/R//v4vnw9Z
 +7X+4pWW7h86OZ6VFZmyFc9kh0VklvRFKzMxRWvQGhEji/kFCpFLGhsx2nHId5rIIj/w1RY3r2K
 U9/V2CUBZ4hs1H9l5T6L/vH3bglxJ50Ot3ST4CAIuIirdNtzKJs/uzP7iB2Mi5ZzK3Xsm66XmKN
 kh0u8V1MvJZI6Pl6CLYrq/4TeCpoUh825agaQAxzQh+Q6wunHcX5EBpn3VlVdP09T/v4okIVvir
 turiqtXlubDaKx2ZM8HbySpScvVK5bj2q/zVKBFY37yOrCbxzz1RsHo6jlo6j16tGrIGc9mDpRE
 HgSsf1iScWOz6PSMtZGO6Rm7sdEHCx5yl9mq+xWxsSM0k7dD7BrCL1kbUVdqF36Sc3XqNesRhO4
 srcbA==
X-Received: by 2002:a05:6000:2481:b0:439:bdd7:4259 with SMTP id
 ffacd0b85a97d-439da88210cmr21014277f8f.38.1773067864910; 
 Mon, 09 Mar 2026 07:51:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba66sm23931995f8f.20.2026.03.09.07.51.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:51:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/10] target/i386/cpu: Remove X86CPU::intel_pt_auto_level
 field
Date: Mon,  9 Mar 2026 15:50:09 +0100
Message-ID: <20260309145013.44327-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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


