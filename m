Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A06C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySgs-0001ne-9Y; Mon, 24 Aug 2026 07:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySgq-0001jp-IL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySgY-0005Be-DB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99Gwp3575246
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aim88kbyx4mLrKFfSdKR/nIKrzOmFcmOxoRL9bSxY1A=; b=fw+K3U9YmbiSaAvP
 peEI/vv7v+YRiMVg0JYiRY6SZzNo9EVgTZo20AgalFopyJ57ZACsZjTZn5Nil3n7
 2yB+CRT58QhLgemjAs+2dy/J0cVaikjPxZ49b9NxmG067cE4fhXma5FeeF/qJquh
 lcVkFO3gnGySk5EcLmdmkEimoPbmXe1lvizpGFEq4uhAEj7+fiXvSnaf3DFHNj+/
 HelB8XvxeZEY9+tngamLB8LkB2nZPiK0B8hiV5zLxKlPzS9gwPFmxkHdDqDkjUdl
 +iZaLskJCXqxV/AK9I2zt/uANYl25tZvmcHHXrdU14lNr52LJx8aqWlEQWm2FSmR
 ELvkZA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpjcy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:48 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-977fa96a0a6so266361241.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570268; x=1788175068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aim88kbyx4mLrKFfSdKR/nIKrzOmFcmOxoRL9bSxY1A=;
 b=TUhZz+EwUZ4wYsWw1Mg4dfF8mNbiQEAg+sEvILwO+VI6DEg8KNw/Avy2fns0zf36SV
 Kno8nGvI1ta37agmaO/XVnqIau+OVoOyDtptnpHXgTtRNc1UCTO471F+eQHckQbSUM5D
 bvlYDD6yowvnrPDVi//S3erriqAcfPdv2xMgZWJ6m9JoAGVc4jfTssxeGSQKRJFOG/hT
 7uN9OZ8TThGDKVKIQH4YzTYc68u5G6ed5KpatFHtDpyFqaSFxATn1Vsj9n6KxqnvkPYl
 bSq/jtWER/lhfU7wkkj4vpwssWaP7qs/YrmJqVLzkxjYnlf/PA2HhhxdHxxxi6EPh1Pm
 xPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570268; x=1788175068;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aim88kbyx4mLrKFfSdKR/nIKrzOmFcmOxoRL9bSxY1A=;
 b=Kv+ZtdLFSAaDbquIEltPPoTaFZQNLLkTLsmQpfSLhoWZojNGoqpyh3fZJ/faJMvS9r
 oTtgmcQKt5tk0Ank6wGXIjOt0Frd/7qXhujkyiEiBpnBgkdae45tFH1fyonmDtAM/060
 v4bp5vnCet25+nS0F9lxJZULWf67jUNrGbv2MtUWyeKPV7Qf6lwzSW0nQDnmdyWQH3hH
 jMtxU59Q6+uKWhyPnccPHJtgWTNyxYMin3FDRjQAeBYsHkmHQWLP3yFUrFTUIi9YSHFp
 Ca/GD0hkU6rlVReZVPfxZ/x6FnWX0LEv/eORyO5Qjw05yDgWKUolKa5U3gDyV0KEuSHr
 mtIg==
X-Gm-Message-State: AFuF++m4/kcidLz6RnpkAxVgdcjO5CA8egPQiCcORpAOI4rxScOqZG0/
 k61yF93vZCGn+lLKhVaJKII8keZXlK1/XSHYFeNlvrXnnjuH6o8Q8nPWOb9OTbaPsete6NTVFVx
 DzsBV0fN87qY+JY+Sbv0EHLa0rLuDI6BhCVo4b0AqMW8GJEn8cSQZ+QsyR1OJC9dUSQ==
X-Gm-Gg: AR+sD13voMcnjo+wUCgOrxTXLpyXlFh2dYnBhKxhEeTBcWJRijnJpeWJ30R7dIij/t6
 uFUFkFjp8R4zI72aDV16Gw7IYX+AbpgcyWbR7l1bz/KjkPRJYVXfXlfdgcazZejFJEsdX3x0fPP
 EMYFXY8YzyhNEqcaEbXDJ8cMYbtNnO9q//YNwhCmstyXYn4es3EB23nQo50UbWfLFbugwkaxWxz
 aqODCSnPG8LE/kaLxy5Ks8JLpdG7red4SLJUptXW8CHQrStuv4/rNoy2knAZjOKroiwYWU5OcR0
 02zPAVyWv9YJFSispDAMukFgsYRMVwDYsKMdlMR0nRju50J1vrywQyQ/8gI/HudnUmnUvijNdsC
 ctZIA31d2ZE1Vx3f1HFtbuTY2wgJP8pEq6mKiWm6dIH5IJvad0g==
X-Received: by 2002:a05:6102:5126:b0:779:5099:6ce2 with SMTP id
 ada2fe7eead31-77a62c4430fmr7664397137.7.1787570267891; 
 Mon, 24 Aug 2026 04:17:47 -0700 (PDT)
X-Received: by 2002:a05:6102:5126:b0:779:5099:6ce2 with SMTP id
 ada2fe7eead31-77a62c4430fmr7664375137.7.1787570267407; 
 Mon, 24 Aug 2026 04:17:47 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1aeab9sm9375743a12.22.2026.08.24.04.17.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:17:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 03/20] cpus: Add const-qualified CPU environment accessors
Date: Mon, 24 Aug 2026 13:16:52 +0200
Message-ID: <20260824111711.26297-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX05kRnxeOhfdt
 6je4Ly4TVSmGfHaFT05g8qXAFrrKWd/lrsIO+WGvfZJlqI70t4NWq9/+RZCWNeuZkfndhzarcor
 ytvhK8jPtksg9NzI+k4RbAja0IFuw3d9mwouEjOsWqjd5kpTEfOxqgzN9Edbj/Pb+vjzUaHqj1o
 sWU5CDV1ug/TL26q9TcttvG69gTYQzBMd1c2AGqFWSftxVeJ6iVB25jPE8ZjfqET51nQCtas3ge
 ivNHl2J+PmU8NEsW5ATap74KkOCKcTOaUSW+uNAup09UXR5m/T0tcpcIIA9J8pzSA55a+aa26kx
 OG9wQVLRgqkPkmSUeXbT64UpNsq10nN5JERmVYqmkq1ku6kIOcKU1cvot6AVjuP3HHs0Mo52IYM
 t9bIQj7so3RkN4y6nGzh/uBDK+EfFKVs4lCjEi1CBkMwrExcWqrn0GDrsxpsGF9VylA6sQ9fptX
 6rWOp85P0EjMQvUYDKQ==
X-Proofpoint-GUID: 3KGOgKsvNcjt_XmEy9w3IycGyKb14iU3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX7VXubZprxDaD
 JKDgTkDod7g2fm9Nxy5Z0zduSu36oGj+YpNH9z9opIR7HLruzSZmem9T84O9GvNpj8bh5UY/a+g
 hgdcAsHcbVQ/VaxzNI5lUSh3Hjpm5Tg=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c285d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=x16qC-9I3E3lrIGWYX0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3KGOgKsvNcjt_XmEy9w3IycGyKb14iU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use _Generic() controlling-expression to add the const-qualified
variants of cpu_env(), env_cpu() and env_archcpu(). This allows to
safely access CPU architecture state when it should not be modified.

Alias env_cpu_const() which is still used.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Following checkpatch.pl errors ignored:

  ERROR: spaces required around that ':' (ctx:VxE)
  #46: FILE: include/exec/cpu-common.h:89:
  +            CPUArchState: \
                           ^
  ERROR: spaces required around that ':' (ctx:VxE)
  #62: FILE: include/exec/cpu-common.h:101:
  +            CPUArchState: \
                           ^
  ERROR: spaces required around that ':' (ctx:VxE)
  #90: FILE: include/hw/core/cpu.h:605:
  +        CPUState: \
                   ^
  total: 3 errors, 0 warnings, 64 lines checked
---
 include/exec/cpu-common.h | 30 +++++++++++-------------------
 include/hw/core/cpu.h     | 17 ++++++++++++-----
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6594f7fa1be..60997628cc6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
  *
  * Return the ArchCPU associated with the environment.
  */
-static inline ArchCPU *env_archcpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
-/**
- * env_cpu_const(env)
- * @env: The architecture environment
- *
- * Return the CPUState associated with the environment.
- */
-static inline const CPUState *env_cpu_const(const CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
+#define env_archcpu(env) _Generic(env, \
+            CPUArchState *: \
+                (ArchCPU *)((void *)env - sizeof(CPUState)), \
+            const CPUArchState *: \
+                (const ArchCPU *)((const void *)env - sizeof(CPUState)))
 
 /**
  * env_cpu(env)
@@ -107,9 +97,11 @@ static inline const CPUState *env_cpu_const(const CPUArchState *env)
  *
  * Return the CPUState associated with the environment.
  */
-static inline CPUState *env_cpu(CPUArchState *env)
-{
-    return (CPUState *)env_cpu_const(env);
-}
+#define env_cpu(env) _Generic(env, \
+            CPUArchState *: \
+                (CPUState *)((void *)(env) - sizeof(CPUState)), \
+            const CPUArchState *: \
+                (const CPUState *)((const void *)(env) - sizeof(CPUState)))
+#define env_cpu_const(cpu) env_cpu(cpu)
 
 #endif /* CPU_COMMON_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 81af7b9ee1a..18970ea39f5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,11 +594,18 @@ struct CPUState {
 QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
                   sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
 
-static inline CPUArchState *cpu_env(CPUState *cpu)
-{
-    /* We validate that CPUArchState follows CPUState in cpu-target.c */
-    return (CPUArchState *)(cpu + 1);
-}
+/**
+ * cpu_env(cpu)
+ * @cpu: The vCPU
+ *
+ * Return the CPUArchState associated with the CPU.
+ */
+#define cpu_env(cpu) _Generic(cpu, \
+    /* We validate that CPUArchState follows CPUState in target-info-stub.c */ \
+    CPUState *: \
+        (CPUArchState *)((cpu) + 1), \
+    const CPUState *: \
+        (const CPUArchState *)((cpu) + 1))
 
 #ifdef CONFIG_TCG
 /*
-- 
2.53.0


