Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA92606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLqzpZYF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OvImmWoz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpw-0006bs-5l; Tue, 20 Oct 2026 23:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMog-0004YL-Ua
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMoe-0002uB-KT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F3IZ3256691
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3uc/a/K1r0yU+DutArZzUhtCa5KlYLTfF7Yb5mQUvjc=; b=dLqzpZYFkFx7/N4s
 aOuds2Oh2Apnv9MAAQw+bZ/7uQuS/y/zxTkp06Mj+p5e5i7Fksx0De9+w7u0WP+i
 1ISR1LpmxntYB6iLpB6589WlF7pd4gfrFBoTtl1m3zmfPpqJtkMA4slesyBQNn2b
 838AyxXmY6Ej1w4QMUtXKE+8p8eUohByWxoMyTs7fhgsNwcwLZDa62NqwMfo1y2X
 b1Mi62llJtfxuiKqZVoz/uhLsOJa9opcJe6sMP8E/xEOaOALxeVks3S2Mq1RxZn6
 s717dIGjBZwhH1+hoFvjB/C+FWRmtNRq08At3WX+K+WymlArpkgghJVPFN9zJtrb
 nIUvJQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v1rs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so100822585a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552584; x=1793157384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3uc/a/K1r0yU+DutArZzUhtCa5KlYLTfF7Yb5mQUvjc=;
 b=OvImmWozky9WE0rKMm2e5YvqWC4gl4F5rdNhqTXDgQBtLKod1r/Z7PFutzWg6LcICt
 67gZo4MVIuKrxzGsEHYUOrU1vFb1QyQQncFRR6SKXk7mBfAi1kJpTy9B70DmoWiT4mKc
 fsf+Xa24BoaPYMo9B4LfHSZxTlwuZbEmYSiY4KXTxgQyrsFbZ14JT9e7c0Q9doZeW4Bg
 cyHrI++NheG7BbdqurGTkuhwebal+37HK/h0NkFKC+EOXesSfMyCFYt5ZQENBbFgoWFv
 fa6mynJikTmShxeB/KFvwUA7r3elv7iErOKlavgnk8EzdBL7+nq31sPXlO2fQFe/Kkzz
 8kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552584; x=1793157384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3uc/a/K1r0yU+DutArZzUhtCa5KlYLTfF7Yb5mQUvjc=;
 b=vMqhOIaATMZehcRc6G9URprpNkaXNd9e8wX8yht/hM7BXVYOIn2L+3VlTvfggyaFDT
 ikDmwDAKfiBfURNyAi1kT4KLQUEkmdS3Egd0VXFgJc5vE4TaN4scRzhedh5+/rqszaVk
 nl+/p721aMhz+KE0vOy8Lt2BbASG2qcORhQZrBiy1i0ObaCGikQtx+du/KpQQX34lqjG
 ju69VlwxkM0WWrijbfvd4XEw4ClMhnWKy46l3Ju6Evb++Pi1+XVYgbrHte+KfS5Z3wLM
 TwaU4oe1Xv3SntGIaLMWJhGYpF/jQzIZnueFVW9Pcy+yHlLGmcn3KMJQSMCbe9w/Odc4
 8Z/A==
X-Gm-Message-State: AFq9FYJL4GeNCQ8Z/SaoG0MNxwVgV8Qq+UxkWysX1v812ZYa+2BN6lcS
 clYGkOFybOdNmf49IN/wmSj2peiNlWLApNNBYL4Z+mnRW0vK990cu4PVSDWNRn08wDYy2M4CpFH
 PImAiG7ca+H/S6xlKuycK7b0aOCk/UZomGmoIurfDCiLWc+hr287amEXjHwalkA7gUrgv
X-Gm-Gg: AYBFou0XFvnlVdEVk27ol+ZDbOFlnzMDPSpL2NHkw28cce2GEdHD/Z3/LkkyL6WYOe0
 ip5bhHoFvPplIk1hQ1G4455MfSGU6EVtAhzzR2u1cg4EbbDSEXLBUHyQx1kPPXPqX/kh7sqIZ6T
 14ZvXdb0hLGQESGY7OFQFSX3W4hvqLIdHaC3lC8NrNHZXlkLZ8y4SCYvg/sOPxN4xtwOACxlpR3
 YjhSWj1zV7eU2Tdlhc5vqB45L8vT40d9RqjcfN23WnXlcNL23rDRrm05vqf9z/dlJpqHB31nAZc
 T+xTqRJqYUfaUFgB0n5l6GZJUKKffEDbLIe2AAdiVT+VJrtr7hxrzSMKSB0ZT3q2WNAwXx0EKM0
 Ny8Q6ScTprMcfeT2tUSA4uoJJJSE7GPcQMahCBfrs
X-Received: by 2002:a05:620a:6087:b0:93f:1af1:7951 with SMTP id
 af79cd13be357-93f57f8ad29mr216490385a.66.1792552583592; 
 Tue, 20 Oct 2026 20:16:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6087:b0:93f:1af1:7951 with SMTP id
 af79cd13be357-93f57f8ad29mr216487085a.66.1792552583114; 
 Tue, 20 Oct 2026 20:16:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm111146565e9.0.2026.10.20.20.16.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:16:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 17/33] target/mips: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:50 +0200
Message-ID: <20261021031407.24862-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX+J/IvmsVBoLH
 eKm1hXndBM/aao4h8qeB9A/r0Eh90SpdWrr0ZT8MGkBd9fP/GbSrHvShaqFRIzKr3X1ET1Dlt/W
 JwvxmdxWhNFHSUP7oHJADpBFSmRHTd8=
X-Proofpoint-ORIG-GUID: y2H6CRYohJ84s5g28v3lmhDtB9vr2TJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXxSy0L9upVwgy
 9oyTI66+QvTscVZRgrtJGAq9wKNytXi3ABxEY2EaRV4kX8aLsn2V2U+bMUs/j7LDj2yGzjU+snj
 foHCZD5fU32E9Z94lc53kAAcRY1Ce2iV20Eny7C+bm+9iGseHU4dyxju4bnfO75y2na30MOg4aJ
 vSclj5mUKzFoHk43Rc+ly4Fq0GQpuOm6gs4dx4jOj7bGB6lOoqqXLtpR5fjzr9TLSGOkLFjlOyg
 TSDUuhx/BcOoHL7FlLJU4tDIx25f6J3tc2OUTUk6xPzGtyH0psqbbRTR3CDWr8D7EnDev3IbFvu
 hm+oHSFM5qjHbxt6Hkw+g0DkAt6pGWTWpSJAKhkDiU/LWRmj0MPQR/bdHusTHv//F+ofwobU0GP
 OxTSamU5wDXDuZQ8YSyEdrO1JKcRLkzqO2PQHQVcDg2gS97Z10ynLwmiutOtHlOyGt/S9Z/o6yK
 H5ekAxnYnSb90sxFbCg==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad82e88 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LEehXKFoqEHZ457G_xcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: y2H6CRYohJ84s5g28v3lmhDtB9vr2TJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Register mips_exception_name() as the CPUClass::exception_name()
handler, so the common exception logging can resolve MIPS exception
codes to names. Return "unknown" for missing array entries.
Remove the qemu_log_mask() call in do_raise_exception_err()
because it would duplicate the one in log_raise_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/cpu.h              |  2 ++
 target/mips/tcg/tcg-internal.h |  2 --
 target/mips/cpu.c              |  1 +
 target/mips/tcg/exception.c    | 11 ++---------
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5d8b78a70b8..b080c5de4de 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1349,6 +1349,8 @@ enum {
     EXCP_SEMIHOST,
 };
 
+const char *mips_exception_name(int excp);
+
 /*
  * This is an internally generated WAKE request line.
  * It is driven by the CPU itself. Raised when the MT
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f2..9f230e757d6 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -27,8 +27,6 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data);
 
-const char *mips_exception_name(int32_t exception);
-
 G_NORETURN void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
                                        int error_code, uintptr_t pc);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..528d926d16c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -742,6 +742,7 @@ static void mips_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
+    cc->exception_name = mips_exception_name;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 2f02f9be877..d2cd118518e 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
@@ -129,12 +128,9 @@ static const char * const excp_names[] = {
     [EXCP_SEMIHOST] = "Semihosting",
 };
 
-const char *mips_exception_name(int32_t exception)
+const char *mips_exception_name(int excp)
 {
-    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
-        return "unknown";
-    }
-    return excp_names[exception];
+    return ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
@@ -142,9 +138,6 @@ void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) %d\n",
-                  __func__, exception, mips_exception_name(exception),
-                  error_code);
     cs->exception_index = exception;
     env->error_code = error_code;
 
-- 
2.55.0


