Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F769E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Ra-0008UD-Th; Fri, 13 Dec 2024 12:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bG5cZwgKCvszkhqgulnjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--whendrik.bounces.google.com>)
 id 1tM9RY-0008TQ-UI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:12 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bG5cZwgKCvszkhqgulnjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--whendrik.bounces.google.com>)
 id 1tM9RW-0007rP-EM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:12 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso11771485e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110829; x=1734715629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=rAiCO/dJHydeGND4wPl0sH4es7qWQmf2yOCvmsYbaR4=;
 b=ADEpNpr7egex4czb0dEAfzd6/BJUd9aXjTeewWF5sjEX1Utl4Iy5pMMS2280/kNwlf
 Gp5reiAHh36FSRvFsyw4kjYi14LoUQtgUEtThJfipgk6Lm8MKPwSB3aoc0HhZE1VKrgH
 AXnYrH5gTQfficdvKuCd+n8fMWu3rCQXFJAPYrb4eLraPpYbhM5KEIl9DHXuUvVzViUi
 HZL4mKWfHs1qIPnb+pP5FgVsphgA52lxgb1TXyVv2ixIIyeqH9K16YU4Xgle8I+dk/aV
 l6/YTeB4bgoef9DN9DaKeqVFe+UnPbxZ1wO4z9p+EeS84KLEstSlq7r/Wm8tUG+GyKzn
 Y+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110829; x=1734715629;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rAiCO/dJHydeGND4wPl0sH4es7qWQmf2yOCvmsYbaR4=;
 b=JE4PvPRDRIWqxElCXZroMNOh6crHYBwy9bPxmJx3o3Jtlqt1iLEu7IjCeYGjkSFnml
 VBmUF6f/SzGtoiISFLODixXMkLdvPUsjYqP3rui2OxXAB1sSuWwuxc3uWVoExSBY2Irm
 LnOYFdpngxCuD+jJGx9vkjnpbtWmpcweM6rYRANkoR38N2zBkf+jkte8N3T4iZjFwJoM
 fN5rYHK0QdwZg1CD4nWTXxbXzhdAZinWMzHT8gDli0ynEbSbb+Mbz+pDgVT8elRHRItt
 /LrV1VLEBhv5mVJ4xxrfJOVpwIvDwVi5/s+DjG4w77DmluijBBKcUnZ95CQ4jmsyqHGn
 2d1w==
X-Gm-Message-State: AOJu0YzaR2PovA3Mgn3ddNRPPMMqhD290TqVfzTk9MQaa1EJYorZjnLa
 ds8yhaBbFAR2jGMf2r0ysNCC+fHU0JpgwLGZB/UkY4DWUJvYaQufTnHVmmIiBU8LXzUlkl8OMuH
 0RsSpm1rOzbPfmHibIm7iYS8sWIq/Iejr8klK7A+wq7agR3YkpCuNvBho1KayA5hKZM/PVUuKHQ
 mzsuxO3N4BK6ZEikm8M2lYQtsPD1nfEygKSirt0dmLhw==
X-Google-Smtp-Source: AGHT+IE1ragnyyWr0MXKVjbyEQ3QqEpfY6srZsIuxKvmbQY2Pe5BVPEmwej/4kMyKUBBhuGqHCS+n5LOG9kASQ==
X-Received: from wmos10.prod.google.com ([2002:a05:600c:45ca:b0:434:fa72:f1bf])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed4:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-4362aa66874mr34466575e9.17.1734110828833; 
 Fri, 13 Dec 2024 09:27:08 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:44 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-8-whendrik@google.com>
Subject: [PATCH v5 7/8] i386/cpu: Adjust CPUID level for RDT features
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3bG5cZwgKCvszkhqgulnjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Adjust minimum CPUID level if RDT monitoring or allocation features are
enabled to ensure that CPUID will return them.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f14d6fc62..f7904870ed 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7719,6 +7719,16 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **er=
rp)
         if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
         }
+
+        /* RDT monitoring requires CPUID[0xF] */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0xF);
+        }
+
+        /* RDT allocation requires CPUID[0x10] */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQE) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x10);
+        }
     }
=20
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set =
*/
--=20
2.47.1.613.gc27f4b7a9f-goog


