Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B93CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQi2-0001Wi-Ke; Mon, 11 May 2026 09:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhn-0001I3-NR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhm-0007m4-45
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4OT21106460
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iaKjXD1pHbL
 leVjNwJQ6jVes6ytXS41FlOp+q9y4V2c=; b=U6yrCeK9d0FAbVs5PomKaZ/g+sE
 tULBP4nWE+KfqwfGjhmQq+tYRN/v7ZVKaWBJTS165JcealerKwt1rhdWVqRtV/A+
 gCUBrLa69RqtpIRpObyse/FXbkQOD/1R2ZV6tjOlIVHW28pBhJ2nygUEMAA6dWuV
 2CQ6Z7obO0xAtnEPl25MC1m80WvZT7Mzv5F40ps7tzkOEteZvTdTdeCmUd5Cnt6P
 LxvMDT2EOKzBL36IXOQgwOwN5mxElR/oWIb3IHGDU1T8rTF0UEiU7t3EXBlSC73X
 FhS0ldVs4feMhlp9KFldXbZcZu6WGug/sVoBZn9JbcgedgZB8qbaNa48XxA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esr89w2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b597b14a22so39657256d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506181; x=1779110981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaKjXD1pHbLleVjNwJQ6jVes6ytXS41FlOp+q9y4V2c=;
 b=TO6apHHHvtvw+p9RCzV35dH833ngvwrHYdO2I8N+QTIpEQyXm+ZAqHabcCGtlz+f4H
 lQutB6fb0jzukyNAUKbJVFUcmtPzHCxrnLfe+TqcIBHsylyaO5GyViG4AA/k3DGekIp9
 nS9XGMRR5VLOw3YbLss1BF7SFPvW6cmb0P5FV9C7W19v96KiEhUXmv1NgdGYZaWI4YR3
 rkAFdq4jJp4uv9I+6x6YNF9JfxRn3PNQ6hrKP87q1Bzv1RIkV3Cf5F7FF/kppunNof8C
 t3JSFVyd6OMQsbJaTAF5kmTaeLExKFxWTGmnVggF9MvGCZJGcYPDoBA27lBGkGWLYWVr
 dgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506181; x=1779110981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iaKjXD1pHbLleVjNwJQ6jVes6ytXS41FlOp+q9y4V2c=;
 b=igRlhEjxdtpW0WO5dwcUQZXyC43NAIImHk3XOj1scFG3XKfZDj7kgESBMy0B1Hu4T3
 ooW6RyOdOYctpXDYneOQgLwW/evNZiClepRl7N8ZX8Oaa4fm3E2pLrXSB1l7WiY1PZCq
 88BwqEjNP6w8jtjlylmXRUOwzae+8bbRydz0G4Y0UDuZyzLfyTrdBKjweGLUTtQseyH3
 pvN/p+CqPXCsg6TFy46XK1yc61VsvfIBZWAMgHdjrhEdQyJz6WAFhRXft2vh4jAVAORw
 pkC/XJZXwKkGXHNEKnB33sZfJREuYfoPWcNIzbxhIHvNxARvTekoL29b/153ME1EuCXa
 FcCA==
X-Gm-Message-State: AOJu0YxVZrOkE12iHB7cBePmjZqG6lcJJKE0leKxYfTFYBWRgGQUdMPB
 Ra2QIU2B4lsCXXNqtjZC8gmYUK2/uH9IrScK9Z9uL7c/CWpADCgckbmIXuQPJrXujylqW4eUDk1
 OkwxAjBuaIYZ7bYWQ17rpuVh8Yhu7gcyb+2Srllu+RhdCUDrbufH3hV6wDUQCuoMTpg==
X-Gm-Gg: Acq92OEot7B0zEs3w3w994OJje2YAMlaDKYxciOfNfDzcUqK0hRu5/bonbfskFpMi3M
 3CLP71U4tSCdFVWwQUcMNzcdtYzvh/Ok7gSQmlqKP9VKsyJobxG5uQDkev2DIzdgOG9PCENuwow
 ZzPuCTGRr7vN072+5kV/KgFD87LI5drhoXoBIreKtPAvxLywQLGiKORrZ1/f//HPjrNSf1zH7+A
 lAnAhHEjCKYvi/8kTiPAmCu3iNUjK2AAZtUpEgH0eGNSWExMRe37gwuaYFYiRIDxw94wKRvm4e/
 Ds8mcyzYbf5DwkdqwyaXDGk4gckx6DuCaxm23/ZuALbc9kfIACKgpxpveZWDdHs+ik/bOm9ZR7N
 hiJkcg0WpF6ks7s83TVIDYCIxtGr2Dgao62OpnWodNpFyBrtT1k1RaxBb0AB3
X-Received: by 2002:a05:6214:4509:b0:8bb:2e70:7a2d with SMTP id
 6a1803df08f44-8bdb6ec4f90mr277010316d6.2.1778506181218; 
 Mon, 11 May 2026 06:29:41 -0700 (PDT)
X-Received: by 2002:a05:6214:4509:b0:8bb:2e70:7a2d with SMTP id
 6a1803df08f44-8bdb6ec4f90mr277009696d6.2.1778506180770; 
 Mon, 11 May 2026 06:29:40 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 12/13] target/riscv/tcg: use isa_edata_arr[] to create user
 props
Date: Mon, 11 May 2026 10:29:09 -0300
Message-ID: <20260511132910.1738069-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yU5ZETsw0q2BMqxTOIFtlF6Y1pryddY3
X-Proofpoint-ORIG-GUID: yU5ZETsw0q2BMqxTOIFtlF6Y1pryddY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX+OT3EngRRTkF
 jpuVE2mJRAm8IXvxNXGMTg/Hxdx+1EfOz1pyoh2yasanPnP4aI6y+Q+H+GKMWc5D4DTsTowGNmN
 8pPmYPMEIgl1Q/oR5LADGK8ZGrfy5c7XwwM23wlCm+RAWaXBvf6Mjx483hVddoK8gIX1rf25A5F
 tPzr7aw3ZsHBKXQxXyuFHE/YgYtlwnkoWX1Dk7bYYT9eWtMTDbYP0+Hoye8uBLgbpTZHR4tRE+y
 FLTuMWvDhTT9gQEJGCiBpbW6pZI5NtB8dNe0YN9w6CN/q4+MGKFbYrcQaqydJBj+KIS00r7M5te
 0zCc4IKIbYtVHCZsS/iMkLYQpSvmcgQN/I5tRr0KBD0MJ0sD2NuFVpGgcJL+P1x0I3FwuZ/IXFG
 huNpJ7qMQQyY6wcLB3aKH7runStk37Vm0LeH1eumZ4m3TWpfnWSOFHncSKL9m2VRqOPMPzSzkOo
 oNXYX74xlojPlWGcetw==
X-Authority-Analysis: v=2.4 cv=G40s1dk5 c=1 sm=1 tr=0 ts=6a01d9c6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=1BXTKFuIUdj_d1BEBQIA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This change has been done twice now: one in riscv-qmp-cmds, another in
the KVM.  We're now ready to do it for TCG.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a12115df4d..214988f907 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1495,27 +1495,6 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
-static void cpu_add_multi_ext_prop(Object *cpu_obj,
-                                   const RISCVCPUMultiExtConfig *multi_cfg)
-{
-    object_property_add(cpu_obj, multi_cfg->name, "bool",
-                        cpu_get_multi_ext_cfg,
-                        cpu_set_multi_ext_cfg,
-                        NULL, (void *)&multi_cfg->offset);
-}
-
-static void riscv_cpu_add_multiext_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        cpu_add_multi_ext_prop(obj, prop);
-    }
-}
-
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1524,15 +1503,22 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
+    const RISCVIsaExtData *edata;
+
 #ifndef CONFIG_USER_ONLY
     riscv_add_satp_mode_properties(obj);
 #endif
 
     riscv_cpu_add_misa_properties(obj);
 
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            object_property_add(obj, edata->prop_name, "bool",
+                                cpu_get_multi_ext_cfg,
+                                cpu_set_multi_ext_cfg,
+                                NULL, (void *)&edata->ext_enable_offset);
+        }
+    }
 
     riscv_cpu_add_profiles(obj);
 }
-- 
2.43.0


