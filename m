Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24475606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AmJp2V4n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iDOyc0u3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyy-0006Pb-2I; Fri, 23 Oct 2026 12:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyd-0005Dm-E3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyb-0002bu-HA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6rjx1492220
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m/FmiOituai+pOcvcRi/Tc03upJT4eaQSvGRgqTC3HQ=; b=AmJp2V4naOKvY1uQ
 xBNeaqyiKX2hEjt48hm2OGXWGf7ZxoMSla5RdvJQDhFePt/3TxAXIv9Bhyam9I0X
 HCKiSBRtPkC1AUrfw6jD1tGxFdX2CcdFmYSl98W0YgBqSSo4Tdh7/0+9W+TvMNcd
 r07t2wFw5SuAy1Np8bqpVLrPPZLHx6Paqa16RYGY3rkZ/0TqvMGwBixjPQYUsMhr
 xuIDvqAC8akkNwbvq89DZbt4dkzJ3EQO16LcPyIxcOklspmo7qyduxU4J4CgFVMt
 gQdZW+Kk5CE3wB5mlebEDxQJ6kdExWZQREmIAcXVC1GKSAbkb5LS0RsicHQvUP9U
 egt/SQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauyeu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso382115185a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772319; x=1793377119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m/FmiOituai+pOcvcRi/Tc03upJT4eaQSvGRgqTC3HQ=;
 b=iDOyc0u3F8JaNqBD2g1QIg9U89sFPC2i2NXUlSLBxySZA7YC9cKlrqaox0Dj2zQtq3
 8txBNDOsYniOuQqKylDOI4sFMjInkdi0UTQ4T4E96shER0MGjStENJM1Qzcsb08ucVj7
 ZXlUqy4kCQs/FIml81hUJlZLHtDvuiCo8ZUbC7XOCagvUiF/SKPL8DSu/U05A3BWKBQN
 3d3VfIxNSLN24F8t6unyUoSUup9JP2QV+N4lWh9nUC3ScrcrDB7nGg69GCZlwKSCZgWY
 W+jjinLAIs8stEhLxhXlLw0dt7zoZtwW69V4rTFdA9ixLahlbX1VfDoSDbcWtf7JrUPz
 nHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772319; x=1793377119;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m/FmiOituai+pOcvcRi/Tc03upJT4eaQSvGRgqTC3HQ=;
 b=f84dI+CM4kCfZrMr8DsC6CpE+JmE4w46Q+PagJVTx5a6QfNRWa92Agip+MQVObYa2E
 u4NCPf89vw6oMBvNWPwsdT2qmih3tzg/3ctB4/YsTqoXEEGOqLJCB//JtO6s0vUlW9kA
 Kr77lqswiyREN2Hex5K3cVk9nqp2LFShwn1F7kbAlftiHqDoxWMMIWOQerl2csHjnXn/
 NZdPeTjQkrdtcp6DSr1/sUmNC7q0KjKaf5Cr+UyzJbV7jch/YKqW4L869xpIqi04Xp/O
 WXN8VQ9ToNJPxIzhvqLRYLPJFAGTentq53Q6R2018UWvGjyctglbLLqJZA58DAY7oMzc
 6ktg==
X-Gm-Message-State: AFq9FYLJP63qbTxJRqGegZv3ry/ELTpi/Y1/t3+sw3nFPN/Myjr/vcV2
 BPLronzNi/dBdP8OoRN0TUMid6TvcS7PNiy5uAP+5tlePs7Yj0nu04fgmJ3b0QCAKaswhqg1hL5
 lHQX0za6BtrXJ29atP6oqCH6wqkQPiCjNU2L3uwbjsWUrWTfxV3ZKoor24ii0iw9Oos4p
X-Gm-Gg: AYBFou1PftFX4g8jB6jJCiLAT9BypagxTXUQu/wzFdAo6M6hTfON9NP42kEl3+MAmVe
 UCjGS1uOwU/p/nc+mLsuqj+3C+cJMsm81b9hnmlqPl28Z4ePRkozAqXzbm6R+2Hek+i/4nFoT6q
 mFXjyLvPe8Wjy3dJvaWqhKit5fN1xEukYdJsSyJo6Uo/mnkNG4peYlkGc0anexSCBMAwcJeZjG2
 BNaHO3sfG8h7Ayuh1UDigC/N78K6Xzv+0jdW2Fm4COUXvxFpVjTHm+/RsCJ4c+tRkMT3kBDscga
 ygfeU7MZMhy10oFZ5aeQMa+wZQZSz8qWuogIirkFkYn93pKivBafAi82acmNvuQp4QF4rZ8ebc6
 U2u1dY3XCrVOCPDb4jiEC62LKDPsrtFY0svS+kEvm
X-Received: by 2002:a05:620a:4047:b0:93f:1789:8359 with SMTP id
 af79cd13be357-93f6278ad0fmr992196485a.31.1792772319091; 
 Fri, 23 Oct 2026 09:18:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4047:b0:93f:1789:8359 with SMTP id
 af79cd13be357-93f6278ad0fmr992191785a.31.1792772318524; 
 Fri, 23 Oct 2026 09:18:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312e820f9sm4979225e9.1.2026.10.23.09.18.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/83] target/riscv: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:50 +0200
Message-ID: <20261023161332.60153-43-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb88e0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=y9j7XMdMAJhvWi9Kj2cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX45grUhZJmwQN
 bzSTfIzYF/fCh4Ns+MPJK+pHSYnv7uw7QTFZkM9L0DPnSzGKU54wwyi26951RcrMDRLZpBj+48c
 EAMM3YpRe7hWiUj05b2Y73hh5yA8DbU=
X-Proofpoint-GUID: h8QMSCYAR4D8tjUYeOGoZ62EZRVuSDeb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX+8aCMLLK94t2
 /8XQ3UTlfe8xCxu1BD/QBOjoAdV6Tz2SdTBczjZ5XwvXY4dwT4DrCRkzv9SLhrcYb/LFkZsVNqd
 u6czCyybQyn1RgWO4yzyVgYRRHzny3zSCmu9rTJNLoU5vcOq1EOgObN5+JaRzkRISnS2uSXgPk9
 K89vs0YFC6r/12EphBLQ3h1I/lF3InJRbvDuk7nu+dSMNcFmLTBSTP2ObEMCMQOQBbUV0/GrFoM
 fk4zRIglWbRPXlHafO5A1m4QHkCU5jli5YutbMWecavJ9pWlEffM459X/2+EOG2NT+3DK1GWqYF
 I5FeZlICSCFMN/lGauYDd57O34yIqb8nfjp74f2kxmd8K0yc57c2eAf3XnFULjqle3u9pKr3zBW
 STcUTYNu06N0EaeVtWQHltrS02GKYHYPzSVIeZ3tCpqYEzXAv5t/W8ZKoOtI8HZJ2TfQs6InXpt
 kE1NHZ5layIkxR8YPDw==
X-Proofpoint-ORIG-GUID: h8QMSCYAR4D8tjUYeOGoZ62EZRVuSDeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Factor riscv_excp_name() and riscv_intr_name() out of
riscv_cpu_get_trap_name(). Register riscv_excp_name()
as the CPUClass::exception_name() handler, so the common
exception logging can resolve RISCV exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20261022215115.19680-24-philmd@oss.qualcomm.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/cpu.c           | 20 ++++++++++----------
 target/riscv/tcg/op_helper.c |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

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
index f9946f54ced..ae750f85c6c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/qemu-print.h"
 #include "qemu/ctype.h"
 #include "qemu/log.h"
@@ -398,6 +399,11 @@ static const char * const riscv_excp_names[] = {
     [RISCV_EXCP_SEMIHOST] = "semihost",
 };
 
+const char *riscv_excp_name(int excp)
+{
+    return STR_ARRAY_ELEM_OR_NULL(riscv_excp_names, excp) ?: "unknown";
+}
+
 static const char * const riscv_intr_names[] = {
     [IRQ_U_SOFT] = "u_software",
     [IRQ_S_SOFT] = "s_software",
@@ -417,17 +423,10 @@ static const char * const riscv_intr_names[] = {
 
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
+    const char *name = async ? STR_ARRAY_ELEM_OR_NULL(riscv_intr_names, cause)
+                             : STR_ARRAY_ELEM_OR_NULL(riscv_excp_names, cause);
 
-    return "(unknown)";
+    return name ?: "unknown";
 }
 
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
@@ -3130,6 +3129,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
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


