Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B6607154A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WhO41krX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dGvyyQid
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMsE-0002DF-La; Tue, 20 Oct 2026 23:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMqj-0000jx-U9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMqh-0003FY-87
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L36Ee63532775
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D6JPPbP2ID1neE5DTExklpLS1x7Fwl4KCF0KFVVUP3Y=; b=WhO41krXCyhNUqb/
 J5DWeUeW0gvAdbukW4/VYQ2EZGMM9nCqXDMs82We8GQPrlLYmTZR1f8i4UGnAmEo
 mU56DPIky4CBDM6aozjtgDDB6Gz772YTZrPqLhSXEJ+TplbfbvuLUhJfZWxDnWTI
 rQ33U9/kOUj0I0CJapQ8y206Of8WGsDUYehvfkiNQgbRbo2UDZGt6fAbQU1GtZYc
 7dQRPuPsm/JZgIwtnFhHOXL8MWm8RkQRdOiIoqgdjf7X4iP6dWiJuel075E9Gqz/
 PHGaFNl7yhGHvAqMyjOCrzlUzrndy4JOd+ZBwlNSqonZC/ZA//FpFYgexh9TM48v
 W0WG0w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r0ujh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:18:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f32050e72so101149485a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552711; x=1793157511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D6JPPbP2ID1neE5DTExklpLS1x7Fwl4KCF0KFVVUP3Y=;
 b=dGvyyQidaYcljE2o6URNxZcv7RhuQ1t3LjUoZV5XLXGlXSoI1vVf2MbGk0EGCiZag3
 +/zDr120eiIbYJ7UxGgRcCUNC+xxrJDc2DJ2kw0hyV8w/YivOaeMmZqRlnWChr87ZsNU
 /QKaVS9njuVOmvc4jKOvJsumtGBDBeJQlHgZdLoRPu1uVv1S86vWqeAsDUVIVqv1Ce9Z
 hpLemFAoEy5QxGj8XKhVsXatSSYdj6Q3gJwyrwLmcgeBaKVkUofds+toYrCYQfi5n4f1
 RMei2PAC0H5oLugdkkACBbc3gKVMpOUrouhBNdnoIQLzV4qKLfOewvQLxSrwEidIJZdl
 0EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552711; x=1793157511;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D6JPPbP2ID1neE5DTExklpLS1x7Fwl4KCF0KFVVUP3Y=;
 b=MLPk9zMSh0PwRDCvO5OpF0ikM2Hoemv3rADHIseXcITfm7hY0niiuWzPxFpTxKCZx7
 gEtF/8R4SCfhLP/dgHJ8o+azLiTD0fQS3328gtF2Xmqm/ZUqxjt1kR+/1fTTkMxzDZDd
 JWiF3VPGnvCa8pJ4gX0OU08ByRRsSHuo6688KW2xmccrIu8BwyW034yOVjqrF1xpnvMS
 6nEe1C5tlxzKxCnrqXziltDkNTBmM0/d+3RNAcn8aU6Q1BbKnXEneKaB9ijzlc3CeIyg
 nYAnR8cnE7OFpdrgusJjbUMIjP74++njRza9Vrj9bnJb3BEi6Z3qp1iV8pxHEpARm6xH
 RkHQ==
X-Gm-Message-State: AFq9FYLXAX91lqcBf77IHMgM2Me+9O7N14Lamedd/ir1N1wRzcfphOT1
 61YAxTcRLT9YhRkM6FKgr98c9aZqzrNvcUauWTLM1Ba2KWL6e4FyuCrV/Ajrn9Y/ORVX8+7xuMi
 IwwfM0AwaO2jJSPl6Lb2U3+T76froaKQ0N9ZjK8iFF0R8P6MVhz16eabRqlpjHFHHFzRC
X-Gm-Gg: AYBFou0rZQYo5aBzzYxYG/7aXZBjZ0Toq07T0CCSQLxJ3R1HErCRsR6e3T4CMZOGVfO
 TY7MBRirtHqtI4hRULxAW2oKr2Z7kMcVpQffBXxHXlfhJf8fOncW3TQTTj053X0QnmT8vhv7MCV
 pr8hrkLpEWnmkHRQITkvj4YntIcIGn7cpatTnyH+yBAPKFNXhLf/iLxUhaxqZ/X8RzhoMHGou1B
 +s4zXn6YRNDBO64EhFwgRD+2C/y0MnQJi1EqudqpdxaTvq8veVQxQcl3YWggeko/VP6HmmyrX7c
 jl1JuLFim1yQlApGX2vkgIPtFYFAnBxYtCHmD/Qb27gK92Ssdknx734C99x95+UbXaqb8OmqRbj
 /9TqYtumj2Ko3tiOhcIidt5ZdPRXQvo2K1P+5SnLB
X-Received: by 2002:a05:620a:2913:b0:93e:53fd:4137 with SMTP id
 af79cd13be357-93f57f1f09emr220446485a.20.1792552711581; 
 Tue, 20 Oct 2026 20:18:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2913:b0:93e:53fd:4137 with SMTP id
 af79cd13be357-93f57f1f09emr220444485a.20.1792552711090; 
 Tue, 20 Oct 2026 20:18:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25b04883sm2363770f8f.0.2026.10.20.20.18.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:18:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 33/33] target/xtensa: Implement and register
 CPUClass::exception_name()
Date: Wed, 21 Oct 2026 05:14:06 +0200
Message-ID: <20261021031407.24862-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad82f08 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-R6i_BgWeFa1qxdD66wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: FaX_M64Wyb4bgRcNJQKdqQMc6OJ3UklX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXwblK++Zwsw13
 lo4FkHc7HZscbDRZF1PfRrno4zcWGzcxXHeb9/qqqUgZE3cpzaPwwWvZycaC10NUI5KPAb7h84e
 8mTPlTFu8mooC14C0hmnwGO4Kh6tG1Wm80U5y6hCxDvbhzN6VGn3Ddxn/lEnVcmDzsbqMqDPHiE
 zvCGp4OOZSG6lnIp3kKPqb5lG+Moc8X3jWfKlIcoFaLXa+2fvvs60mYlD4CcFcbHXkBMYUfwUNq
 Udz7wgX2MD3n4C2GBH91/fbVzGqq1N+lgHL4gp2dQxKhzpFRbKh59zC1szn1pWoxfYVzIxLzU51
 /PLfm9rZWWBeNkM6dnyWcWISrQZWLGwhxza21sRciBEu/knH4J4MJjI3IhwN2QOKtJcSnGJOSnJ
 nIYBZL/weX4rT27JfJVeACI1Ek8AOo3SjSRP1P9Auqx/vDlmL30IzNDUt5ncUQfUQJDkmQAfFZA
 UrDBhCS0jSdRMcTl+hw==
X-Proofpoint-GUID: FaX_M64Wyb4bgRcNJQKdqQMc6OJ3UklX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX+P6WA0bt5E12
 YL36Ap/ypcd5m4mURImcjKtVDJlyb7IyR0fe/y+Vo3Qx4BnionjOKGVUWnl/rt39jLHEzDEwtI/
 PahBM3WIsxQRoD5hHUQeTGjwklnnb6s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement xtensa_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve Xtensa exception codes to names.

Use the new helper in xtensa_cpu_do_interrupt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/xtensa/cpu.h        |  2 ++
 target/xtensa/cpu.c        | 23 +++++++++++++++++++++++
 target/xtensa/exc_helper.c |  3 ++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 49d6ad9083d..3440c27862b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -262,6 +262,8 @@ enum {
     EXC_MAX
 };
 
+const char *xtensa_exception_name(int excp);
+
 enum {
     ILLEGAL_INSTRUCTION_CAUSE = 0,
     SYSCALL_CAUSE,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707..1f9cb7156be 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -239,6 +239,28 @@ static void xtensa_cpu_disas_set_info(const CPUState *cs,
                                      : BFD_ENDIAN_LITTLE;
 }
 
+const char *xtensa_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXC_RESET0]                = "reset",
+        [EXC_RESET1]                = "reset",
+        [EXC_MEMORY_ERROR]          = "memory error",
+        [EXC_WINDOW_OVERFLOW4]      = "window overflow",
+        [EXC_WINDOW_UNDERFLOW4]     = "window underflow",
+        [EXC_WINDOW_OVERFLOW8]      = "window overflow",
+        [EXC_WINDOW_UNDERFLOW8]     = "window underflow",
+        [EXC_WINDOW_OVERFLOW12]     = "window overflow",
+        [EXC_WINDOW_UNDERFLOW12]    = "window underflow",
+        [EXC_IRQ]                   = "interrupt",
+        [EXC_KERNEL]                = "kernel",
+        [EXC_USER]                  = "user",
+        [EXC_DOUBLE]                = "double",
+        [EXC_DEBUG]                 = "debug",
+    };
+
+    return ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -348,6 +370,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, const void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
+    cc->exception_name = xtensa_exception_name;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 7cb67d179a8..ff71e5d6462 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -236,9 +236,10 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     case EXC_USER:
     case EXC_DOUBLE:
     case EXC_DEBUG:
-        qemu_log_mask(CPU_LOG_INT, "%s(%d) "
+        qemu_log_mask(CPU_LOG_INT, "%s(%d:%s) "
                       "pc = %08x, a0 = %08x, ps = %08x, ccount = %08x\n",
                       __func__, cs->exception_index,
+                      xtensa_exception_name(cs->exception_index),
                       env->pc, env->regs[0], env->sregs[PS],
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
-- 
2.55.0


