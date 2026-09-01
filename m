Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A46C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONI-00016a-OV; Tue, 01 Sep 2026 09:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONG-000162-PD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONF-0007D2-1c
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:02 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso1375775a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268679; x=1788873479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l23r3sBjF+KBdIzoy6ejBdKn1IF+X+LERpXbzhCmfaE=;
 b=UoU5zQ0rYGIG9K4gwIc7s/zFkrWu7fBCITir3UKOB4H+0T5dxKob63ssQVwEZP6jsd
 t6aGJIb+xtZbc+kWCyGcGgHjVB3CT1OO/GBorpIpKh/1GpAQJPyH2CW8stqD9AjFkflf
 TbvixW3er3CwmaXXQ7CeDEwOhkyWi/zeDVcLOLDQ0an8Qxv1B+hjESc9+mMdlJmCWhRJ
 Wdbqt7aV0/MdTxfi1HXjzetBBXFQpqKRrIjO+z+bwo6QQe3n3IX8Y0ttPe33N9I+L6U4
 u0EzSOrBu6+p2zXf4jVNOBL1k4Yzp61Rf4AZ+RIFUIfyySlOwhUT8goJIDuh3O0q7xZW
 hzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268679; x=1788873479;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l23r3sBjF+KBdIzoy6ejBdKn1IF+X+LERpXbzhCmfaE=;
 b=Ob6vft513mDKZbdTH/crf3TLgfY+9R5FZwfbF+l+IZgQQbeNDoPzOwonncbVfZEYQv
 MKjgz3+aIP6XuFsCyjzrHgAJeZEbLMV0LwuACTIVQH2PgF2jXu6gR8ibDSky7YU0u2zG
 1ia59n4VlqIjoG6+izyKEbHWWBl20OmqNSLWW66aBiah5qUJJyloQIj+slwObxz2v8Z+
 Sk8NXlKeV0/3peqDcPa4HRFw6Tx4lXH/k/a2qAVMFvD6NQiWrWf98pLfRgOmFBMQW8po
 CjfCysRTm5DcZfWHfVHC8xOYkbp3INX/Pv8xDUpDkdl8qRm6KH7RU3wKRHaHi8D8x8vA
 Q6ng==
X-Gm-Message-State: AFuF++m/b4d52T3hm60zyIr/NMBvtFcA8HDmKfO6bxRr/1x3YDh0xpyk
 wtbYYWhQYDFBdxXFofsH5LrOKSMs/kM8hDEJZoaeN5iWvihF0tbtpK01rCcY0D1JWiN0T9W9edc
 fo5fxTKQ=
X-Gm-Gg: AYBFou1IMcC7waHeKAIqgYhH2J56mnnIi/WS5x9WWrnz++8kXc7apFC3fA7Ycclc+Bj
 TnJ1zq9b83eyVTsn1tJfN/R676vBojTamN6Cx/syUYeQ46FeUl0A2c9Vr8fxRoAmGrmn/8ULFnk
 i6A/U3sKgMt3yrqxSZBOJhTOIx3s/ndIDZaXnrJFePDz5yGB0bb6f0XlFx+l+qiIymyRcJaCLlI
 9BDMAFSwqbWdTdEfMM0qPR/j/jGbWz3+DX0mGO8mnW0kNEXJ4fmzcKMavWYUxbEotUj4aRCGnz0
 T8DsvCfmBUdRV9yEOIR/wC9CxGYEVYm3ELVDl3h+ou/Pxwa/DokDZei/qjdj0zOhK04M27YYEjO
 tw7J1n+4sFjwLZTDr5HS5B3gbtbjvUlxwZ351HPXLPCDaHo5LsPTvat57O2KkeaE+bvAQ24xVN9
 t2jVVNfXxAUepU2SfofZGbXLEie1LMP0luEuBIPZp5Jjd/l1Qy2mHJ/lpL8rTuSu2fSmvfo9plj
 zhKyuaWdPi2XsMVbavpBvWRESxRI7veHuNIEDaqBZrblIb8jHeMTsdLgnLIqMBp+ioh1dI=
X-Received: by 2002:a17:906:c147:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c2556fb926dmr2033613666b.1.1788268679526; 
 Tue, 01 Sep 2026 06:17:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/58] target/arm: Introduce cpu types max-v8 and max-v9
Date: Tue,  1 Sep 2026 14:16:59 +0100
Message-ID: <20260901131732.2263947-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Introduce the names and allow them with the virt and sbsa-ref
machine types.  So far, the cpu types both exactly match "max".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260827041557.775080-5-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c           |  2 ++
 hw/arm/virt.c               |  2 ++
 target/arm/tcg/cpu-max-v8.c | 11 +++++++++++
 target/arm/tcg/cpu64.c      |  1 +
 4 files changed, 16 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 484b90053e8..56d08f605c8 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -913,6 +913,8 @@ static void sbsa_ref_class_init(ObjectClass *oc, const void *data)
         ARM_CPU_TYPE_NAME("neoverse-v1"),
         ARM_CPU_TYPE_NAME("neoverse-n2"),
         ARM_CPU_TYPE_NAME("max"),
+        ARM_CPU_TYPE_NAME("max-v8"),
+        ARM_CPU_TYPE_NAME("max-v9"),
         NULL,
     };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e7a56e37f73..d738b95c726 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4132,6 +4132,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v8")));
     }
     if (tcg_enabled() && target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
@@ -4143,6 +4144,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v9")));
     }
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 5a9845d88f3..55f8c341423 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -2,6 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/target-info.h"
 #include "internals.h"
 
 
@@ -117,3 +118,13 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
 #endif
 }
+
+static void cpu_max_v8_register_type(void)
+{
+    static const ARMCPUInfo max_v8[2] = {
+        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
+        { .name = "max-v8", .initfn = aarch64_max_tcg_initfn }
+    };
+    arm_cpu_register(&max_v8[target_aarch64()]);
+}
+type_init(cpu_max_v8_register_type)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b38c61ba623..d44a8221c8b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1488,6 +1488,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
+    { .name = "max-v9",             .initfn = aarch64_max_tcg_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
-- 
2.43.0


