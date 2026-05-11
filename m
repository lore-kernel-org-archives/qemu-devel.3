Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1873ECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhc-0001AL-60; Mon, 11 May 2026 09:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhZ-00018D-AU
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhX-0007kC-5g
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BDQNHZ453358
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q9gvnrAkwPO
 5jBcTJUH0ke/0t/wIanuEqXbx5EOKZqY=; b=Bm6GcacECwRzvzead7ewPeetVPJ
 bpBP40ekvzUzyRpnC2tVqgc6lKOy0dPp7J+qkQOXUNzH+33s7FRk83oYax2CNhQp
 Mk54pqb7FscfR8we7FRdq4YAnNUrONs6cLLHzKfG1TgZyezamaL1iIhjpTU+i89l
 /rdA+kERaPEDU6LktUqDG7XQPfp8xUvd4LNTvQAfrHPmmrnf1a9hp8iuN0oggB4H
 x3qDMXvfXjEDz4b713m6YNgVjelIPAML/nZQ+93u2JbALKQd8mZTuLYDSmgvQhNm
 n4gqIBXURu3kYZ12VdjQfFh58VeED5b4U4cWt2UEYNeeuqRaR8bxVlw8IEw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h9ms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ae752c5273so89827296d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506177; x=1779110977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9gvnrAkwPO5jBcTJUH0ke/0t/wIanuEqXbx5EOKZqY=;
 b=SQ7SMw5GlQuBHhfBHHvTn5U55uRduX5Te+oz7dsRCLIa0+c+bCW11PDqKKKpzNwlyS
 m8/sVjl3GKbV2XwDISNKoffBrlUpZ0TZEQZ3bi0JrFReSgUKqemWRmI385wwYhEKQKD/
 ieUPIXs54euOt6K749x2tipuCLC5AGOzzhKsDGGHG5xsfVaCMAaIuCeiXMQKzWV9Wiwo
 b5ucyF0FYxP/EhHjTvWWmgoQjHeognnPWlyqULlaAyVGU6bQ08sFQI10pq/Zd21R35yR
 ne3GBUD0fNlG6jP1UBuLED3hsFp0sF2M6XmJoY/zQ8rZRiPiYWhCsLKq37I9mHwXspgx
 X1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506177; x=1779110977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9gvnrAkwPO5jBcTJUH0ke/0t/wIanuEqXbx5EOKZqY=;
 b=HqlvRV6619AJZK7QpUpMA318BmThIsD2/cSDHPOJY/uaZdSP9A879QH7sLSja1VBqZ
 bTNuxY8Ey7S8UA2GXZAEz/3PGQgcCyp8G0qxEyW3StblX9EZxMMzVrLzJFd4JuVpc0R2
 QT3W8gn6JQKSUFqW9Rvkqi1Uq4C74KBZUINrUu5oRFlTLgyR2bM8eVwdFbeBWGh4AslS
 JN7mF3bE+tePzDtpbVDlty8hEhyTAsLqXEPoiP2kmKIF04SReBIxjLGETHKVRU3f9y2w
 0EsYF8SJ7khM2Yj9aCMKWy1hn2j1PzRMSA+iS4sD+HA211+4/0owkU8zA9HMEqqQHChJ
 +aLw==
X-Gm-Message-State: AOJu0Yw19mYrGic+P5s8ssia30sAL8Gvq1+cGpNii7aNUEMbrLIVMLs1
 a3JWf/L2DdnhC+uAvpZc07ALg4OaqL5W4D2Tlzj8vxX3V4JkjvD78IFbmaa6P9ofClWkm2IVjgF
 lEDm5Ja6Nxe5CQ0cy7izoXKM/zPU5HTi8yrWzff/KCY/TIVD8tLx8TTV8k6QyssbggA==
X-Gm-Gg: Acq92OHKP8desUaadVJEeVh8jeWebTrF2q/WL4lyf1Jfc3yaiHlR040uZvhjxIvTMSE
 uEtzEYZdM7IJegctNspg6GsODDTwD3X843BbXFOAe1GISSesk6G+0HShDpsjga4aitMMLkTiZFH
 jUM8qFrd53OuNDGqy062UdrRJQu46ye/BgcIicCWgwik3KjUTCxUKQxgKFj4b0X2QDUWzMeYGfc
 wpw6zk1nqDwqOv3R9q+uV8BOevhLIixppZPqof1Ym8s4HQTiMnYehLUAERbs3BLJxlOZWAp18az
 e3tie5bUFGqNlRWR6en+TzjnooMIV8F9A7Fyuf1YuxHHGV3t5SLhmKT+lHWB4I2jInAuxsxW9nb
 OwWW1GrhmGcUvUeYsidIeH3lZHsEkv53gLmxOycv6ZrzLBnzRjG2b2Sx5nv3o
X-Received: by 2002:a05:6214:40a:b0:8c2:f848:4962 with SMTP id
 6a1803df08f44-8c2f8485441mr133109756d6.17.1778506177147; 
 Mon, 11 May 2026 06:29:37 -0700 (PDT)
X-Received: by 2002:a05:6214:40a:b0:8c2:f848:4962 with SMTP id
 6a1803df08f44-8c2f8485441mr133108856d6.17.1778506176417; 
 Mon, 11 May 2026 06:29:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 10/13] target/riscv/tcg: use cfg_offset as cpu_set_multi_ext
 cb opaque
Date: Mon, 11 May 2026 10:29:07 -0300
Message-ID: <20260511132910.1738069-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d9c2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=eGyGyxdOu922ChY7XH4A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX452VtweAfxqM
 A3FEE9GTbj5YS1liNlJwC209R2CCMATFViTBDQrv1I/1QFsNHIuTqaJJRkCC6CvUUiNKecf4VRj
 1PEtTOtoqAU+reB+Tma3MD7GKUjcB7yxdXYBtmnHJV4/gPgq9pZzNkwjDYdeYf/QqadHyDKYNoT
 6k0OzOq5d1ZfSpOx7ANqEqol5IYyALGO/Jn3k7CuYlnlsbhzlQtWCEp0/8CQ8uY8W005vRSFm8g
 gsBNel+hue5WVXJRpXbtvbTfwpHoFhKtj+1qx/77dILlGwCsWI0cGjYtZSoBV2Db2cN57TgL7pJ
 2BFoM+jeMUE5BOHkNEihlmMU4Zevpb8cZ+pyAm3wyqajaAxcD3NlpQE7T32NtvvzrvJuaSABe+P
 qy1QaX00Ls2RMRFZOq1l3MR/05KAXsO1rmPT6nZhZ5u6fmsenZIzKmk3Zt4Hh/zEw5HR48fp9Ny
 A9hkfOlAn0PQFp0CXjw==
X-Proofpoint-GUID: oZHjfy3PcHvd8HdHrbBuxeWN-OhK1mL3
X-Proofpoint-ORIG-GUID: oZHjfy3PcHvd8HdHrbBuxeWN-OhK1mL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The cpu_get_multi_ext_cfg/cpu_set_multi_ext_cfg callbacks are using a
RISCVCPUMultiExtConfig pointer as opaque, but internally we're just
using multi_ext_cfg->offset.

Use multi_ext_cfg->offset as opaque instead.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 12c28f5b7a..db311118b0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1455,8 +1455,8 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t cfg_offset = *(uint32_t *)opaque;
     bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
@@ -1464,9 +1464,9 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
+    cpu_cfg_ext_add_user_opt(cfg_offset, value);
 
-    prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
+    prev_val = isa_ext_is_enabled(cpu, cfg_offset);
 
     if (value == prev_val) {
         return;
@@ -1480,17 +1480,17 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
-        cpu_bump_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
+        cpu_bump_multi_ext_priv_ver(&cpu->env, cfg_offset);
     }
 
-    isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
+    isa_ext_update_enabled(cpu, cfg_offset, value);
 }
 
 static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
-    bool value = isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->offset);
+    uint32_t cfg_offset = *(uint32_t *)opaque;
+    bool value = isa_ext_is_enabled(RISCV_CPU(obj), cfg_offset);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -1503,7 +1503,7 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
-                        NULL, (void *)multi_cfg);
+                        NULL, (void *)&multi_cfg->offset);
 
     if (!generic_cpu) {
         return;
-- 
2.43.0


