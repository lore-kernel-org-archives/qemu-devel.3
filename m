Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A581088E65
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335x-0003lo-5F; Wed, 18 Mar 2026 22:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335s-0003iC-Jn
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:40 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335p-0002rl-FK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:40 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79a535e7c00so5725127b3.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887196; x=1774491996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKkANjLZg1ioAK7kFziWCBF+Rd7tkHlYjXgtjul6Zjg=;
 b=MGCiiPxEHjBVEbVePiv3NpSD5HJr5ykm90U4JZDrxPkiTcIOJIUP7yX21kvut4hM4A
 quqCvi9r/92mHmuxNyI7et2un/X5Grnk6Np0aoOoyRzyGmeD9EmneYG5itFvx5X+XJcA
 C/TUJEPUntO4Eh+2igQ40UexikzksbZx5CTtL+FpfplTHnFGt7F4t0AsnP0sBifmSlyb
 nuVJjqUZyG0CSaluDNlvW2h/hqVFGUm4rFjylzE2ZyZ39Eq1CnZCSsovN784pri8kPpj
 PozXNrq0IyYk5MVP74Xud0IYHzEHZxzixBfhC9S2RaeNmq6D5G4RzO6eOJCyZoOFdDmy
 bLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887196; x=1774491996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DKkANjLZg1ioAK7kFziWCBF+Rd7tkHlYjXgtjul6Zjg=;
 b=Y7sb8g+YuKeWwZLx1MYcvN8G/78NwMdxAIASNrITRTElzre0CHEQG8YoWYK0CxBGyb
 rEt/8vFvotYSkEkdPFs77z+B5l2RQGlYvnO0Uj1VtVJY+6BBNTfZprqeLpn3hFcy6zzA
 prOJPV3KQb+xxAwLey3ArE6Z1R832c8PoBEf9sotv9U3QImY+go/bNyHltQeeKdk6iGk
 46SYNECZRzprgm3rvGuP/JJCaHhvOgOpNQtJw+eLgXIrmzd8rRrpHDllFwZxqdDjDC3I
 v2zzHY6O0bIxXyZb0gbctodeDWFFpub5QMMnCgwbGKxCUB5N97U5dzcogTOgE7hpIwVN
 cb0A==
X-Gm-Message-State: AOJu0YxXgSDImRjRDIGOz+d+NUxpEuDORLtX+/zmiZjqbnRKvfFz74bk
 IbIL/gjgw/f/O5101y3ZtLXIrg6EMvlATXjzLkf4W9W+zOb2VrXK6cxpHsb2sQhpfTPXrxsqqrc
 vrf0LSYU=
X-Gm-Gg: ATEYQzzGum1P1P8vW/yC8Dt8Kiqs1VHEg24KxKFQQwo5ggVGcUWenbzKn5yIKVP6Uyt
 dA4xl/jlxhw1kaSOTtQDl2MwudgDzChCV2I5LI/rGsA1HrRtJ17tPCAlLROJtSwvbZ+0TDJiGib
 D2ed8PEG188yBcEKoCNdxpPr+1dyZqH4gCcq0uszobUoiTr/dJL7K9OXJZTgkOxdIDEwkNGN/U/
 VNEgZLLOPdi1nif9/Z/WlxidiUWapW+IV55yDATyL+9jt9LhalRMIz+Dr+MHcangHvtbJCJouE2
 QxQhkeEfAwkeaKtcpgRzn+cQmx8zGHgIC3bRAjwOITqKmg9i/kOw8OIC0N6mjceCBFKAYU2pyA+
 uMcVBwN0zTJExNsKomn190JQ7Jf6eRNwKhSrqwrWPB3z8XynuOP6HMj1iboY8I49fR0enYTbnAu
 kFE++SS66l2fYy2IJu2BIIRMqhnlny8Q==
X-Received: by 2002:a05:690c:9988:b0:79a:6eda:b24e with SMTP id
 00721157ae682-79a71ade8bamr60109677b3.33.1773887196291; 
 Wed, 18 Mar 2026 19:26:36 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:36 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 4/7] target/arm/cpu: Add FEAT_MEC object properties
Date: Wed, 18 Mar 2026 23:23:32 -0300
Message-Id: <20260319022335.22523-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319022335.22523-1-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x112a.google.com
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

Add 'mec' and 'mec-page' object properties to the Arm CPU object that
allows setting at machine level the memories used by FEAT_MEC.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.c | 20 ++++++++++++++++++++
 target/arm/cpu.h |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bb..98bb559eb2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1542,6 +1542,21 @@ static void arm_cpu_post_init(Object *obj)
                                      OBJ_PROP_LINK_STRONG);
         }
     }
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+        cpu_isar_feature(aa64_mec, cpu)) {
+
+        object_property_add_link(obj, "mec", TYPE_MEMORY_REGION,
+                                 (Object **)&cpu->mec,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+
+        object_property_add_link(obj, "mec-page",
+                                 TYPE_MEMORY_REGION,
+                                 (Object **)&cpu->mec_page,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+   }
 #endif
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
 }
@@ -2169,6 +2184,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (cpu->mec != NULL) {
+        cpu_address_space_init(cs, ARMASIdx_MEC, "cpu-tuple-memory", cpu->mec);
+        cpu_address_space_init(cs, ARMASIdx_MEC_PAGE, "cpu-pseudo-encrypted-page", cpu->mec_page);
+    }
+
     /* No core_count specified, default to smp_cpus. */
     if (cpu->core_count == -1) {
         cpu->core_count = smp_cpus;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ebf4e4e01c..a91db25d68 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -977,6 +977,10 @@ struct ArchCPU {
     MemoryRegion *tag_memory;
     MemoryRegion *secure_tag_memory;
 
+    /* MemoryRegion use by FEAT_MEC. */
+    MemoryRegion *mec;
+    MemoryRegion *mec_page;
+
     /* For v8M, pointer to the IDAU interface provided by board/SoC */
     Object *idau;
 
-- 
2.34.1


