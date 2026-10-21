Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86F606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZVG+q8t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Elgx3nPZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMqX-0008U1-S1; Tue, 20 Oct 2026 23:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpJ-0004xQ-7A
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpH-00030S-7v
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F0Vm336596
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kqsyq5ufOSYPdPIadZgoikdqK3qQtPj8FL7aNjTYmrs=; b=aZVG+q8tHeJET48k
 zYLjnoKLk+OBXfgTvMX7E/DRXoo2dU/WNO6Ozr4qJrdiw+xgB3zw30wAS9RSyZkb
 vVxOPSP+ziantTPvuEJqTDV3SiH17cA0fKiTr8Xrfsh+cOmOz/4E/l9ljZpOj/l1
 h3R4Uux2MAZkF9uXQMRlHgc+fsGtmpRLlYaulENrmjT1JnjKlBVwlm/3+tOS2K3G
 Fldj5aD+eHzACpw3xhG6boVsMt23PbaYYxCcM9WI4YA8PLYSFM3KApnsbzwVzY6E
 StGuqefhDnGiPlbl+5UTuB9BSPkp0ZyJw4c8NrIqFIdC3fJaXqIHON/UDgEtmtZ7
 UnY9lQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhrj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf6c528aso52826585a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552623; x=1793157423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kqsyq5ufOSYPdPIadZgoikdqK3qQtPj8FL7aNjTYmrs=;
 b=Elgx3nPZAPE0mWqzU05np/GNcvqhed0RBhffGtbbC/MsJ6KAnUG8IpKal38bPp+Ibk
 ZJBE1qQVi3QrpXuizm0chECAHm+Kux93bj+SxeE8gvD+tPg3xA6UfaDNQR3aksPDRmtn
 udCq5i2Kb39NgId6JUmVHzxg/ZOZp5VsehIe3KY5YJtepzI84HlccDVbtMtCeEUnhBJX
 l8XDZtqlGBdcMDI6nto1PDiPS8m6LOSNVPQ25GF+RmzbxTJYvxQnPAafFZF4ZG5LJYXl
 +4YXo0mk/pgkudIXgXdw0OIJlfrkkuqmYyTBPqje6U9toD7lQdgDCdSZT8v2yERPsSPG
 J8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552623; x=1793157423;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kqsyq5ufOSYPdPIadZgoikdqK3qQtPj8FL7aNjTYmrs=;
 b=v0411Qa11KLZgnCpSr4ShipDPUKfU27tQqcar/m7Ekw4Rm8zeo1BpvkT2QvQtSL0zj
 ubnOTVc/BuhgZRrBgDODEa8e6VdOC6Bc+FYJnF1ZeUjTR3Ln4NwABF6M/ivkRRjNtY+n
 gUafHJyCP0Mo1zqcTxN2Zx7DDbv8PJiQp0RBZDeml16h+9E5BjI0SKYvIhHibQP8N/Co
 iRvbqxP7GIVbpQFXCd6DrnqcMKqIlcoHSvoHyigfKHOOB9n5uppXAF1PGXYJnPsyFSnC
 Dw2nvaDeIA67d/pe4mJ1/FdMUFqvvFBlkAxiXOdpOu8GK3rLxnSizDsSAYpfVWwR6UcD
 4stQ==
X-Gm-Message-State: AFq9FYLgzYjHNasZQ48DcdTZnIEmWx43dzvxzfNwehwuAS4f5RLM1B78
 1XzXZwPc9OqGEGxejfCrnC0v3JLRCxpaB2TrqanatRmlJwKzBsEW+IH8QAuVLWwy0diqWZS6z0D
 UAjc9WhXAGECw5kJR4yvyA6hxDH4VBsgsgErrWov7reVTZtKaO37zdjLDc4orfCA01Dsc
X-Gm-Gg: AYBFou3vJPRHD55YPWQy12PVB13hbBne7xfCR3XiTuMPuJR+aNdbboOPv5H9yBne+Xn
 RBRMcp7zmAsKsUfcHv0QSuqHBaqMlibrLK7ixim1EoaXEscPDtQrfNndbz7jMVA19Te0uHyOn5b
 h2z+pFCebYdJbygd/txhpW5fjj7FiZvgPN0lisZd0zWiGIuqX0o418rerLYttYfoD2+QMcoqTpg
 kKFa0i0tZTpCRQovJ9hbMZN/DLgCNUc+YMUovTdpDLyEAF8jm8tGdjh2iF4qE9wAVCBLIaXj2vc
 4OOooRw46enNQnmoVmx8QarkS5JajW8XZ2forZNOzkwmEytz+7FtuOFG/SfNHEyfOIhhDFUtSf/
 Xs2ojrb/jQDSH+kZ5XIKYKs+4pz7SuZlJD4fn4jBT
X-Received: by 2002:a05:620a:3711:b0:93f:5677:9950 with SMTP id
 af79cd13be357-93f57f46196mr217882485a.53.1792552622621; 
 Tue, 20 Oct 2026 20:17:02 -0700 (PDT)
X-Received: by 2002:a05:620a:3711:b0:93f:5677:9950 with SMTP id
 af79cd13be357-93f57f46196mr217879585a.53.1792552622126; 
 Tue, 20 Oct 2026 20:17:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcdd3855sm11075905e9.1.2026.10.20.20.17.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:17:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 22/33] target/riscv: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:55 +0200
Message-ID: <20261021031407.24862-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX6Ij4aP9OcClf
 BCESx4ajP7OU+WxfN5SbXhWmGojq96rSsutsO8Ecfz1FqIsMISxHQw2ryDeDDIm49+k6BIWyM+7
 5OnH/Ht4R1MQ7ogEVePHwW3HN4JxbD0=
X-Proofpoint-ORIG-GUID: iuLm73rZ53oOro2gHkV2GpOMKffKcT4X
X-Proofpoint-GUID: iuLm73rZ53oOro2gHkV2GpOMKffKcT4X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX3FqaHcA4dpZB
 l6W58BYBO5ZW05M0TTfrGTmYyOazeT3ima9iyWNwZe4FSZNzHYdbvjRIz0adgIqtXWNd3ahap+N
 5odRo+eUu5Po5sk25CsjLYzz/YOA3gOZ8BNFHOEj+PXU/MkWMiTm6C1yTrmW3y88vB2sOYiIOUQ
 NnwVStAKsrhu8VOWN2OuRsOp9Up4Y9UeabVy2R0pN3amRiAF4g85qe59lA5zWCrMiY2ONuw19NH
 DhTSHn6bzowY4e+8adzrcGb3raqVJ5NDVIZ4eMBj62zyMY753dV06kHGZ0idXvCaUd3GERPienP
 sKJq800oskCvNbri5eo0dMfy6OqOzZ6Mx577KIGk6oj1KnoFDjJ9oETHVHhA9ZiV5b6WBwoImMW
 U7M6uT7SEdpsztpF/lZ24NUhmnF66KWpULe0Wcimx2PqQMUkxx8CKNk23AFafIKvAUvHCVypBzX
 qGJjWRIBBaNYDVOPShw==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad82eaf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=y9j7XMdMAJhvWi9Kj2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Factor riscv_excp_name() and riscv_intr_name() out of
riscv_cpu_get_trap_name(). Register riscv_excp_name()
as the CPUClass::exception_name() handler, so the common
exception logging can resolve RISCV exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/cpu.c           | 29 ++++++++++++++++++-----------
 target/riscv/tcg/op_helper.c |  2 +-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d6319940..49a1186bdbb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -672,6 +672,7 @@ G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
+const char *riscv_excp_name(int excp);
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1f..9e9a9603685 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -398,6 +398,14 @@ static const char * const riscv_excp_names[] = {
     [RISCV_EXCP_SEMIHOST] = "semihost",
 };
 
+const char *riscv_excp_name(int excp)
+{
+    if ((excp < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[excp]) {
+        return riscv_excp_names[excp];
+    }
+    return "unknown";
+}
+
 static const char * const riscv_intr_names[] = {
     [IRQ_U_SOFT] = "u_software",
     [IRQ_S_SOFT] = "s_software",
@@ -415,19 +423,17 @@ static const char * const riscv_intr_names[] = {
     [IRQ_PMU_OVF] = "counter_overflow",
 };
 
+static const char *riscv_intr_name(int intr)
+{
+    if ((intr < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[intr]) {
+        return riscv_intr_names[intr];
+    }
+    return "unknown";
+}
+
 const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
 {
-    if (async) {
-        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
-            return riscv_intr_names[cause];
-        }
-    } else {
-        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
-            return riscv_excp_names[cause];
-        }
-    }
-
-    return "(unknown)";
+    return async ? riscv_intr_name(cause) : riscv_excp_name(cause);
 }
 
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
@@ -3128,6 +3134,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
+    cc->exception_name = riscv_excp_name;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b8b3e43ccd5..f85f5cd83c9 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -41,7 +41,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
     CPUState *cs = env_cpu(env);
 
     trace_riscv_exception(exception,
-                          riscv_cpu_get_trap_name(exception, false),
+                          riscv_excp_name(exception),
                           env->pc);
 
     cs->exception_index = exception;
-- 
2.55.0


