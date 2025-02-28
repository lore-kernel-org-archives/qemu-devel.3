Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007B0C282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6bv-0005L2-2x; Fri, 28 Feb 2025 15:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39xbCZwgKCnImXUdThYaWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--whendrik.bounces.google.com>)
 id 1to6bl-00059o-2R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:19 -0500
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39xbCZwgKCnImXUdThYaWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--whendrik.bounces.google.com>)
 id 1to6bh-0001Ae-JU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:15 -0500
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-390f6aa50c5so200077f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773111; x=1741377911; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uGSGCt2jpgGQiVQiPTcoL8q2cRRPXF5PbYpq3+oes4A=;
 b=VfVd3we6lN1YPw16oa3mZuDhefLdIHWLDUZDjyAs4WtVoihzAI9mQS8iZF3gHrGVOW
 5CD4BywXJqBu9YSn0/Dp84bXZ79JTGYOTm7q1C1zhSyroCTNO+UkcczhtbBSC0m/6QHJ
 yuJniBS/oU0fsdnUNY/Kx+vnP+nJcsy8OqZG4EY2ws8z8J+wGyh/AnicKqndleCgW0vQ
 2CqJPeHvtk18MWNu526QGyGVfGyyQEi+/9xmAri7oh4zjvT+9A1FkAjd1n3Xovk6A7Nh
 emP6tYBDWieqyc2p5fPRb428hyEW9UDPYJws4BWIR6NXoFB3AsysYXdYP7FpqD9p4Muk
 H5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773111; x=1741377911;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uGSGCt2jpgGQiVQiPTcoL8q2cRRPXF5PbYpq3+oes4A=;
 b=CuFolIJ91skYw1dukzhGCW53uhuXrPRv49kEWps+crjA1F1nTnvtAjUpDYSFwuew31
 bVW+7i6SdKqSKz29xR8PiXM8/FmgH3P7CUL0wIxg6p4pe8mB55yytit2PecgZn4Wb6DZ
 ARPsirAecTtdMw7JRs0sQ/Xb8oeIZO/KEhp8y1BgS5NjcLihTSVMRk9mo1Arb+mLlcg6
 501r1iGrLqWdUwmqFaSGi0kyYUY5F2KMs6Vqs+TsMeiF82mKK9T/zSV6BwExWOMHX8yQ
 yppxcwboclv2/wBRtXA21eIOAMN0fnkn1inKP8ll29oEV8/VGXlNx/tYJkkZ9zGZW4wA
 mbsw==
X-Gm-Message-State: AOJu0YyXJLWk4Ar/yEHorQgLQ2uhsY1R2pqn9YYOgQxOTRrkzajYVTNj
 f7MNng+UFlHvl+m0n7k246GYRK/q1qY0YkMepwvKZvWyZtzqfG/vCR9nnTlHc0pXKuyzahCJshC
 oAj/faicf/p2wb4sTnUuPK2GK9DHv2k5VdjlcelolHw2xJjAkmMBTXbU3q9iS9OLj0dVdtL+IA8
 5yUTNT2ol3cnOzdQ4O9iWH5dpM1QuH5vLHTOVTYPz8jg==
X-Google-Smtp-Source: AGHT+IFbZpM9s5UNjjeyIN6pD3JSGrNta9nwfz2pM99RKn4uczzIqfi9Nqb+BaigbskYx/PsDCW8yoqC2eMmuA==
X-Received: from wmbg8.prod.google.com ([2002:a05:600c:a408:b0:439:846f:f9c8])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1faa:b0:38d:e6b6:508b with SMTP id
 ffacd0b85a97d-390ec7cd37fmr3818354f8f.9.1740773111082; 
 Fri, 28 Feb 2025 12:05:11 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:52 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-7-whendrik@google.com>
Subject: [PATCH v6 7/8] i386/cpu: Adjust CPUID level for RDT features
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=39xbCZwgKCnImXUdThYaWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x44a.google.com
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

Adjust minimum CPUID level if RDT monitoring or allocation features are
enabled to ensure that CPUID will return them.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6262665294..1ec3d88a65 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7872,6 +7872,16 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
-- 
2.48.1.711.g2feabab25a-goog


