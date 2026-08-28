Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90792C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xc-00006m-Ei; Fri, 28 Aug 2026 18:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XY-0008VY-79
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XU-0005iQ-OL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMUKMb3779356
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vaAGvJ143aO
 7TCM9Lp0k6Z3V4XQ3V3keRu2UF83Cp/s=; b=KmWgTN2jIdbsO3Ec/u2DZJ5RE/x
 62WyKT59Js3D9JPc+DjDJv3SDPbrgxqfY6vqhA1mMA1aBDJryPxfdZxq23cyP+lm
 Rm8+v+D9+eyt6dmoiHjLZwDkIVjhLC/myFqk0f4YujVcWHWvWTJpfklc/GqOZcOv
 WSl+f85dsFzMmN4QcOAyd5WW5sqw9p8cwWl2fjr7qfQpe2/VMFjT6qYxlSHpCkoR
 JbAOSS6wJPvHiQPDXpjsHYkvvWUtL/4rOC7Ja4yEZBHJNjNv982yKHcXXiri+DZs
 5+TOjpdMudxMF5UgXN6Xa9mUFbXpE81XyWXX2ZOyq/VVpP4te6WMs5Fe/Ww==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbj3er82q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1c18c775eso411515a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957949; x=1788562749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vaAGvJ143aO7TCM9Lp0k6Z3V4XQ3V3keRu2UF83Cp/s=;
 b=VIC+4UbWA0zim0sMD0dgl32so5Ffej/kXtn8TiDao+x3v0TSn34c6RM9Kgol8RwOTs
 JsfrcDXBjtZGH/aY7pxCrH0g04jcNbhi24gdZq5rEkSpX8eT4xMiGjtdD8fPVBIcN+NX
 wPhhtkCi7xpF1zzrGJDfhKYvV1ti4oS/uDS2V0KWJP5UpLrjriwkbQ1RqnTyCKW4eBgK
 bFend0/Tj3zSieA3y/TcA+4OqkUx88PypUglEhp0A4048+VMdV1avaT634rOZnUKd84+
 r75paUctR3uIwkTmNUtriXYMPtTBC8b9voCY/jbj8C9AeHmXee7a/0onw+88pCPXX2UP
 fY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957949; x=1788562749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vaAGvJ143aO7TCM9Lp0k6Z3V4XQ3V3keRu2UF83Cp/s=;
 b=bl0g7SRCMNTP8l5RFIJVcarAtn+nTk22okurra65+7HPfDC5xRPJRaT6RopoStUfOU
 VmszFR2LyOexzrOPyp2IUVlV8GUtXxjj7zkLx8DsWvY4Y5MG12BZFiOTtlPo44fNaC5y
 0/CoCQr+1LocE6OAZH0gTNnWH84pU16AvG8d0NuetrfsMu+8FHdbZfWQihcRJ5hZVJtu
 chIvKRrXfP5XpENL8OwaGEFtkituqNPTzdhCNC1CJs6REAohaHx8JZYX1U64eRg31CRt
 qbuYQoSvpfwvufCTtbSc/Y3aaJ+suvwoOKI4Rhhz/q6y4IMz3c+oQ4F9W/peV2r95x4b
 UMAA==
X-Gm-Message-State: AFuF++mbC0oX+3rTKUJQLSs6BAb3hUtOBoq+Rjqa8ohgH/R8VByQVETy
 6HmBGDKrZklltkLpOrBAIzPIzYxZxvEz8UDXjV+T13MVCF94O8xZH7y3+xfrT6A3dws12rer/I4
 dMZQnMjgKk62zfgQRmGfo1EFFIpa5L7t6cHfDbJ/wV++p/TH5bErfSB22uvdYhyfszw==
X-Gm-Gg: AYBFou0I+LcTnGQi+VpBaIXyItEAv7g4h5ij99BzeZdsnkXgpstVw5UB3XsVhOLcP1T
 3BctEXPf5JuORw4EIFojP4rQt6R5zjRt4DFIjRn/GIhhN9wfshdIhvCkL2XsiobFpKmQRB6PObt
 h2ly7eIt5gddInYsigpqYkIsiH2Nca4eWzRBeCoNkvGf30RElGiAAnlYAVxpaBha67DnZ/34y1C
 JaxVsEYnc0rcMut874k2YfzM0xID6yp7GhWuvt55UEMsS0BrHH8IG70+s8/cP8jjywIDezp7+mN
 ZoZndnKTdr6XLVOzs6hG+TzKMy1zXfI9fjCNr4GJJZ6HN5dYZzP67v/oktxx5wcUBRlRS/KyER8
 WWPWRWigcdHt2Rn2RNn+oxFvE7OSQlNB//7QbMGQa0pH1qZg6LCAaCcs+hN8=
X-Received: by 2002:a17:90b:2243:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-3989b3097b0mr1849536a91.1.1787957949593; 
 Fri, 28 Aug 2026 15:59:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2243:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-3989b3097b0mr1849513a91.1.1787957949178; 
 Fri, 28 Aug 2026 15:59:09 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/47] target/arm: Introduce cpu types max-v8 and max-v9
Date: Fri, 28 Aug 2026 22:58:18 +0000
Message-ID: <20260828225901.367438-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NPnw5jq9PlVJIjHHWry3oTbKdrHyR4uM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5kTO+wLZrnS1
 dl2D40cOIsGdLcJ5xSXXcwUan3KkE5TITl2Itprzz32uwnXzKXqm/45i+xwxvrBZJxfolZqX8zA
 5DRsj32l4Gfg7/r2ZKfMd45SkvoQAppryzgcBrgHhBU4xq0t6kfGDFrGtTB8+BS9MA2g/Vv7qRp
 YwpcaPXD0PfxQ+vDf/5Dw7EqPn9SmgduBsaj8Ky7j5wScrLCFmUvYKiaRhJzTjc41jsaXMBHiwB
 cuABGswaSOXk2y88+hz3pueXGqnYcHFNOGqjUh1un5Ry62TkDuwLFP7TjYMMLMfpZ5iK8hqog/z
 amYHRF314gjMvlFFbnFkLX8KRLcJggDUx8ixeenj4vxHo45iKIFxO1GpDq4BNiiwf3z/enlXI8j
 r7cxTOmZvRCb2XuqQ3bSNIi2GCdqxIPPSEWlmSkApciCuAWWdkSxiFHlsQ9oQKpS+oOqPEw84nW
 C8zY0yWIE+BESAtQ7LA==
X-Authority-Analysis: v=2.4 cv=QLVYgALL c=1 sm=1 tr=0 ts=6a9212be cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=E1UKl2T0C9yA9quHhP4A:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NPnw5jq9PlVJIjHHWry3oTbKdrHyR4uM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1CNGZc9o4grF
 iHLlxlWdWmQq1NYQFANeoRSxvBJjSIBIPYLOFas2nO9UT1W2NrhdzPTOtAGMlH9cCNuT3atm28f
 x86ntPdTaF0Wmpulh0kJXtAixd+dJHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


