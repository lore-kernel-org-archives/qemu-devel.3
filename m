Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDE2C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24tn-0003Un-KQ; Thu, 03 Sep 2026 06:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tl-0003K2-8c
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tj-0006q5-CT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH7MC1328087
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CCa4c+fD8c9Ts0U5IK0eUH215QRLO0qDv+6PoeJ0FYY=; b=TDDmkJifG5BWKOml
 vVadhms0jTnvAm05v5FPsAKtff53/lJMAWMrgJfLf2jRUuX3WtSRUoB3OHJpWQlX
 NAgMEcquBp8zF0cn/it+GOdCbtaHGTAo/nl2EcAtEg+Nil/oquCaqhIgugbYWr4z
 4qMyx1LV0KbpRv0wNpmqfy0qfC70z63TcZVmeWpP4REWBpf+pbpZjJheVCpj6hs1
 fws3i6vDjXYxhyKF8NzBHtA3U6DaxAv4bO7gfdnnIir8of/oYcQ8NhmXZ50/PoiD
 Pn/yR6FoZ1tI9P2GEwe1dbvooaVBL1S3OJPC9v4pMrtX65jHI1zU+1KKd1uCFLh4
 I4zwhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmm4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so597681285a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432141; x=1789036941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCa4c+fD8c9Ts0U5IK0eUH215QRLO0qDv+6PoeJ0FYY=;
 b=QnXHl8hYGFyBP/KVo+C6ALf1eKFp6pxdRt9SaEfd37+U0CbSjAT8vPK6c6qI+YTDvt
 shg97dLG2kfhFjK1d7PFNcc+iaPvNfhELUINloqzv5vUwlcme1W0k8K4RmfLaxYOmGRi
 KoapevpZMFkz+hFJtaXfIegZnWZh5E8USXY3o8Spl7N0HUOIO9yYoxShclwAkFBcnT9L
 hbppxRBOXARvTcDctTcCEOk0l7bQJvRi938KWTJX9d02ZbLzVzgZBpxPnIvLYLuz3JnB
 60uQvMyetdHU7y7o29WQGowN4u+suICrQfTzD3Dovx0Co7ooAYRBwMM7gUcOEnpdLz0D
 P0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432141; x=1789036941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCa4c+fD8c9Ts0U5IK0eUH215QRLO0qDv+6PoeJ0FYY=;
 b=sO5Pmb6vSKx2X/n3d8bqOu1p5zgHq9nNpAD3gMetUKu2yuAgH3aQrDR3GSzpBjb+59
 LM+uR/ppnXwaCpa9fOmP8CQS+xNxfd19erkjCHMdaxeAva32hf/zpaBfAF42Dbv5s8wf
 R5WLWN1dQ/NLguMvkgUKM4M/z3JR6NMItlFQi/INNq11D/ELvFf5U7g6kbEcgWu4cngC
 J5QGp1RdQ2dAj1pz6nhdT3KTtWkiloBlJkCYPxjcC/QhwF7IgsF2vcQTkMpHmDsoSHWx
 F5qtsULOZBAznG2MNF5KoNV0qKoXCrzrVU2GFkMUHvcpEgCHtKTB4s13DZy0+OoZ+ejf
 9goA==
X-Gm-Message-State: AFuF++kRelXkzdjs9YTG9zsu2sXRhuU7I3SBHM3BVnDRXv5JHQSY/N73
 fNj2lYwsKDPAS40gTpIgLMOjOQ5nIGkI8zDNgRTxyKIXzujWK0p1Dnc+trv58G/j6nzmI0oC17v
 7M10q1Gan+NWkXkmyUuO1/+Vc9l1RW0c5FkPUjLa6A12UE0rLxPacQjyfApfsy4exEw==
X-Gm-Gg: AYBFou1XMdigvBZPuKUUwrfI4R1LQO5FJxJmAeHRvdW4qKBdGyO2WU+Q/cPs+fQ0JHD
 jTq0AvTkkLvIHAjyUIkQCVyM4CXdt8Tv10OrByKgZr5yYxlNvJO7J5x0teey1hXlZ0X6wjcuZyw
 DWjH3PdWZaBKOsTfurN2sFhZn8490WRdS8k1EvCmaY1SzxjzVqWHC+aFvcYLM1WB3K85qUJn3C/
 B0kncN3uv2vM1viuJCc8SQDh7ZPMV1+hdvb3o6qjP9C8mTOBZQOvoUtLyqQjmjaoZiFubJGi+iS
 QhWr7gq7I2oev7qGTBhZDlO7uieOrYDVUKoy3LyUZi3Xy3z9/FgCiuDUyshA8EGcdl9RjdI+MIx
 p5vpwXGKHS+AIUhY7rtdvg6dELli9QkZHYcGJax05
X-Received: by 2002:a05:620a:3d0b:b0:923:7821:dc0d with SMTP id
 af79cd13be357-93960f786aamr917885885a.33.1788432141006; 
 Thu, 03 Sep 2026 03:42:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3d0b:b0:923:7821:dc0d with SMTP id
 af79cd13be357-93960f786aamr917883785a.33.1788432140545; 
 Thu, 03 Sep 2026 03:42:20 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3716sm13961164f8f.22.2026.09.03.03.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/51] cpus: Add const-qualified CPU environment accessors
Date: Thu,  3 Sep 2026 12:39:06 +0200
Message-ID: <20260903103936.62355-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -vxnXcyQ-3EDE30-J4yV7_E09XZXlD86
X-Proofpoint-ORIG-GUID: -vxnXcyQ-3EDE30-J4yV7_E09XZXlD86
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a994f0d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=x16qC-9I3E3lrIGWYX0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXwAScA2Ma4tYb
 x08S/+YF6PU1eE6eDkLZ19A4JeRNQl1qJJACaAEiVQd5btCRhvuIgVagxTivlY4t4qconu8YZ58
 6LfdS/o16aY85c/sOXBa7E/TU71/WRfoRhEPhIXSKC4hLgG2f/RpX92+sKWXxj0u3nYy7UMAdOs
 57aZKNwghljwtzywusmEBWSQfXazlngwVooP9jTFdedQZfHM8J6vuMczBxQkGG2as0luhiWHarH
 E6Mj/uvZrS6ZnyWvkAYwR3cnlYVs5s6lFLuTnufCkFCpOEx0eCA8tiMK5CwW1fhfNtAbTs4Whkq
 pk0npaFnGTqfpMvEHc6BHfClTz/cvJJGif45Ra//BQr9dxXB4Kd4XCcwU/hPQplRKoKZBd7OOyg
 JKEcpjjWssuVMiLvFWJTPP24OfmaAzRyCiLzaXOWY7FLyE1a+A6vWvNRqGBTCeDOqFBcrkEHlK5
 P+cBEYC6YR70n66EtUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/PTP/WJBucsD
 DinwZ6spWmpZ+tZZZA2x1c+mmCGDu1i5cXJKDgeDKAl9auokXv9UnanYuO/w0bNpzbM+vV7bqNm
 HooOPX3+2yyC6RXaG4PiQ6qo7zAG6ms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Message-Id: <20260901095229.72018-4-philmd@oss.qualcomm.com>
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


