Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD2606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aQxqo5hZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YpsvE3nP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKIAj-00084n-3X; Fri, 23 Oct 2026 12:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKIAg-00084Y-5t
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:31:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKIAe-00042b-1g
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:31:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2qTi3228258
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3w248Jc7xcLUDTW16O4L+qNzaKAGQWJpZl7tQ3+ofR4=; b=aQxqo5hZf6t4+3b+
 jkcgOUcCSYxUe1umMjmc42arwdP5AjI4woRxcDdYDb/8MfWFuS6WLqeSAjcphfhK
 adpFyNxSmxlUrFfcMeg0OzbfCxrh2Sex6R4Z4sbLiQow0TJC/w+RIq9AWnNiCfaW
 QzCD/oBpOIL1JUqciuoDksulICCQMhIIymvc3uWakmTgZRNxhsqfYLAE70YlpgMj
 0xRYKIb9xvfiSOjFAR6cRM7sj/vFF1pWCwFd+N52QVnXmXffEYRZR3cAWrgEFKv9
 t8dRb24LQuBhQdfHpZpvi6ZDWyNroxojV9k2ihb9DJVAEJOLj73AXQp9Bsdsnqvm
 /JdQ1Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart03q4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:31:05 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-186c1aae818so3797209c88.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792773064; x=1793377864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3w248Jc7xcLUDTW16O4L+qNzaKAGQWJpZl7tQ3+ofR4=;
 b=YpsvE3nPRuIcCR2c+pQjWcssJSPx0aG9QVD2ZLW/E+NSl1Xj6sW5MHh+LjLM/RwvHf
 xX7NIaVPxmy20vXMJ46Mn/AOeuFpR266TtyMdChlUVjvmmFQC5MYx3OydT8zMRpsp2RM
 GiXnGQC3K5ZsPJ0AF0LSw9je2wfQY6iGts3jjykzL5PX9AkQS4aFNc5V9wDDxpyx92zz
 xAXRBtU4EEI+Cp7sF+JCwmFsJNr4PTylUu/IjWwgcHbR2BCdIojE6zf6IcZABubCRBKP
 VGfICdJVfDmMysgceOgyqmN7mcCQ81NDMfrm44MqIvoZFd8eGAVqcjR/hdyythN8msLK
 /sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792773064; x=1793377864;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3w248Jc7xcLUDTW16O4L+qNzaKAGQWJpZl7tQ3+ofR4=;
 b=2bT5LrXq9/PYqRp+FEbsX9GRwEYwptb+GUlL1U6cKEDn+k3ZEYRGdf8dJNHCiuNqlW
 Unp9lNaGy5ohYAdcV9Vs/Hcy/8H6h/ALTO7lU3jPAH1FRY118BMMMtsI2cdru/NTguh5
 ecFNO6Y0ydVi9EOpZcuQR92e0Uwt3XopnUq9WWvJinosQ9we+caP4T+U62agxU0MTy16
 CJ5oDpVAlSgl+h8hYi3IkZllqKeO3c6yODy4wKr74Ky8T6f6HWNqs0CKSdGtdulEbqlD
 aJie5wbLncGBpQ7XAeBvfGs2QnWANcNjDg4lEg7nRpmt6WAmjTc9skba4n9gO+5WMUWn
 N5gg==
X-Gm-Message-State: AFq9FYI60k37INLS4zQi/EAGWhQ7ALUTslMQ9oqvjL/Ky7FBq25+KiiD
 nkfp3COHXns2YrWvcEpFjGxKyG93S+riM4TJx69UV/tdJl7gNtS4kQ6AmyDljElmJBb8NCvLtUa
 NVV/7KrwLY3UujtwjaT7DnwfJtICI6LHUdXQDtRVyswDKMoUwetJ66hUrQ7IMkOETGUaW
X-Gm-Gg: AYBFou1hRoz/TboTLnZKkDS3zNE1A0PWHoVgLPwnnlzuxx6cggx5rmn7QlKzAR3mwvT
 IpiIX0/gpzOffnh1NTmnZ5OIRWJ5exOG0+6LyWOchKe86LaR+mPN1PN4/pNtXmZESHBIvTf3kSc
 h0oIlQK0tbRIo4fSnUWHv1iRp/woudqXxwVukdDXeWZ/yXX1uRFoOT3GlvMSprsk20QDhQhvj0t
 6SbfUMrmr0aR+ZoIlhIx+eVOJJUB/gi5qFFD0/inYyndOUZdQnlNuMKOewPiGT8a+6GTim12672
 P2I5pEwd/6JuH0yMOEEf2aPakzbs6Js0qvFwtTo15QQlPim1W9RleDb5hzEs7Q5l4wHuO/sSJBP
 FCad0rgX5A4YHh9euqcXMRtG+R8K2rXXsNd9MHc4E
X-Received: by 2002:a05:701b:4189:20b0:12d:d972:b96e with SMTP id
 a92af1059eb24-195c1a7f2ebmr4173936c88.20.1792773064462; 
 Fri, 23 Oct 2026 09:31:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2842:b0:93f:353c:6bed with SMTP id
 af79cd13be357-93f6f79c4fcmr484202385a.20.1792772581238; 
 Fri, 23 Oct 2026 09:23:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm9909285e9.0.2026.10.23.09.23.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:23:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 78/83] target/loongarch: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:26 +0200
Message-ID: <20261023161332.60153-79-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX1VvAT0KwPbZE
 e7Rf9aBGRadLdAKFkNJsYCwxuYaOHNJ226khSCeMg1rGKRDN07YyXelFZaiEaT9AffJZK1O3jBI
 m9SXSxeBba9xogymE7H1O0tdpsMK4Z2B5PYAILM4fNVCKM2tuRf5MjpLHzfRvkW1Bye2heZbBM9
 idM0BodlCWsJyYlyp7bqWZhSf8GLYI5oL73LsNNa4I+f6P2b5+D6fBF0nWoENJLL18A4YxEeHS/
 QcMjQ1aQ7HiWG19e5t7pJoy6qL8nmDbGwL0IaJdm42P5B3YC+XPpTDUmMzVybRVD6k1kr1A61Bv
 AKkoV5k7kDffViIvFw2k2zUXWtyZbTAO0i2PYQSb76ym/gWH6qGwu3nWyYxGcfKvARPAwlNlUvC
 BLH1xQDsnQ9dO8w9JTf7XQHBdfri6m/dqgK8auRn94KoYgrDxpcG6KJR5eSI4QUi40Xo80AJFaU
 ue74r2fdK7r3K1oqCPQ==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adb8bc9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2oa03tQm7PxnfrxzRLwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX/5EspRL/4nCs
 E1cE6pQsYTHopn5P/TiXYyHrY9osWSx1ns6DVVq1y7d1R08iGFxGeMYEzORuDWnMXLC49g/t/Ys
 /8PvXbjAGeWL26hExvpjHWho5BiTKCQ=
X-Proofpoint-ORIG-GUID: TLYPnVf5aiqkZoH1TtIbWuorhuVUp-FB
X-Proofpoint-GUID: TLYPnVf5aiqkZoH1TtIbWuorhuVUp-FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

Convert loongarch to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261022125858.310252-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/loongarch/cpu-mmu.h    |  3 ++-
 target/loongarch/cpu.c        |  2 +-
 target/loongarch/cpu_helper.c | 12 +++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 54fb732d62d..491eb514d9d 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -99,7 +99,8 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
-hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool loongarch_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                       TranslateForDebugResult *result);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 9579f4db2a1..de4af284fba 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -880,7 +880,7 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_dump_info = loongarch_get_dump_info,
     .get_note_size = loongarch_get_note_size,
-    .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
+    .translate_for_debug = loongarch_cpu_translate_for_debug,
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d930..270917184a6 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -363,7 +363,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
 }
 
-hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool loongarch_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                       TranslateForDebugResult *result)
 {
     CPULoongArchState *env = cpu_env(cs);
     MMUContext context;
@@ -371,9 +372,14 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     context.addr = addr;
     if (get_physical_address(env, &context, MMU_DATA_LOAD,
                              cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
-        return -1;
+        return false;
     }
-    return context.physical;
+    *result = (TranslateForDebugResult) {
+        .physaddr = context.physical,
+        .attrs.debug = 1,
+        .lg_page_size = TARGET_PAGE_BITS,
+    };
+    return true;
 }
 
 uint64_t loongarch_palen_mask(CPULoongArchState *env)
-- 
2.55.0


