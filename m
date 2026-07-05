Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733B5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUqO-0003sw-H9; Sun, 05 Jul 2026 17:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqM-0003sR-Ll
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqL-0008Jx-3i
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:42 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiqDv2170459
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iximc+qBDNz/RyZclQJYcYQjzkTl/bbNgS8+O8OxcBM=; b=dYQo4dV2VsE1ZKCC
 Cn4ppBrNOmiitq0B9C+sCxkxRG2q/yz4u0flbElEb91ob9k6pS1JKAsOo7ax/4PE
 FNhk9lY8V+2KpilTR8T9jIt8/8nBBpGYwMB+JRZ3SDapqzlsCTE7D5NVynwJglL2
 A0y+a99l2bE3dCk9Yz/4iiTMGSt6pcQ0nvv7W2A97LJ0spQ+ZYK8YET2HP+qg3gu
 k21OoJGVrmg8CxFSokYShbrOoPzBxAT9rZRCICCQ/pUeA2BbPChotOXPnt6S7osU
 9mzrmCmxgsaJrcxCw7L+NXUd8xAhRpyF1CIw3VSSt8KZQOzv3lqd2q3UnaeWrTDm
 qVC5lg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8kfcg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:57:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915f6ff639aso443641285a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288659; x=1783893459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iximc+qBDNz/RyZclQJYcYQjzkTl/bbNgS8+O8OxcBM=;
 b=DFf2iKLckh69N/vvFSnp8XqwnLbQ7ixI0PbOUqNcxWws97Vfn4U3A1gfXK8z2HFauD
 6DIWz0mx/Oavloq25eui/DTYl9h5uOYiHZt+h8BrLWkpghM+qRundCbHkxNCI7ZWBN5Q
 bf96IU9pPOJBRdvLKXbZbomicnB/3zCwzZSBC/xX5iTU3ARJ6UQY2vAwUofcWBtm/pnV
 iA9Zc5MODjGJiXJM3InqVNgKZyKXCH6zdzpBNYBwc1P0wHJQAI/8pOeqZJgzloYOhPnC
 69lX08G1xsJksgPFpYfFuFdSNrLyETNjNxTOxCIgm/o+i5RwN/JzGgQBWzMgsEVtLiNr
 i9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288659; x=1783893459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iximc+qBDNz/RyZclQJYcYQjzkTl/bbNgS8+O8OxcBM=;
 b=cJqe89uTJOpeMogYodMk2be4+3XLpQdxRzRYSYmBcY6+vVGtXZtOdoMYUBPzZ8K3gb
 P+lXMbfS0L/7nFfTNytcuJEEr6GgqXIoMdSf7iaBrEahRIJxboAGHbvLxh3G143e4fx4
 voNcBRxQITlOx/xTrVXf7+5Npi6KNtCstSWxMVQ2QlPL6A14of4b/nWfCKjuXFR7IlTw
 PDoSbnvdDUr1tXzfofZGL3rl1xld1FJZc4bbrVz4BG1y6GEPUKhbU+KKh8k9tT3SrDSY
 wIk5t7olvZwLkNS60zi0fVRQbjinhn9AOqttbpZERWVKu7TnRfM+jF9ZivbzK7B14cDi
 W0dw==
X-Gm-Message-State: AOJu0YxmDZ6tUFeBmbBelBh0B6kkv2xvOKmZ15sGMeINSCFvx/gDbTnN
 wrOE/wCR13AeGHx+t2DmZMZ9+bH0H1/PJ2mPvZxBF8SbT0+EyBN9zaMSn63qcQkPs6jLA9AGA4/
 9W6MIB2VSEeOXdhR9KjULugdDKQbfPZ2OiT1pzWV60TMC/MSbEZ642tscLX+aCFy2hw==
X-Gm-Gg: AfdE7ckAaeu0m54jo8/AiMWEdlkaYjQDc7XN0oXDCw1TxGTDkAOkF5/0uG0RUq6m0RO
 c2XYjB3BzzzsNjf6QOBOZtFt3yZLDM+54CXSyyuvRSqQdYyUECvXAaVN68jZw9QY0P6CvsDyx7S
 2CTml1ZWo+Sjw1rQnNbsfqE30MWXYagpVwYSXx0LJ1J9evpGCfO8LEdnuo4rDuXvLNFgolCxQ6q
 K7Z8DR7noclH9qU74914xO6JFWBbt270XeBBMHN7W11FZKC7oFqSJ80insnOuMHDcKBfeGInhwK
 UyCsKaWOqdGxlS5q9XuYsaAPBWzS+r0ERe4nvap9LDZfJd3llZUtFTwUP6WosI+GzdjsJ0fZUmk
 JPItpvapmgNQ5Hd4tVZOt3T5qHjlp2tFweDj92KolfL10pEuFE2ObKg==
X-Received: by 2002:a05:620a:4405:b0:92d:54f4:dfd1 with SMTP id
 af79cd13be357-92e9a47879fmr1057589085a.54.1783288659569; 
 Sun, 05 Jul 2026 14:57:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:92d:54f4:dfd1 with SMTP id
 af79cd13be357-92e9a47879fmr1057587685a.54.1783288659040; 
 Sun, 05 Jul 2026 14:57:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm19480421f8f.37.2026.07.05.14.57.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:57:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 01/32] cpu: Constify CPUState::cc (cached CPUClass pointer)
Date: Sun,  5 Jul 2026 23:56:57 +0200
Message-ID: <20260705215729.62196-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX6/onaMMoQwd/
 N/WCN7PMB7aBiOSi1Ox3oMPaxCdYvfHpNNeDg/KWan3hrw6Jl1G6ZKzW4rJlQAmImhld7bdXIMo
 LsMWlkjm223qn5bHWbLXkHU+2FiDZPMxGdZnwiNf4/3mXTLD4I/RTCYFsCyj9PjqLqGXiQrNL0W
 38/WWLlyLqf9YatAdd8Eqv9apA0fL+nn62wnvqXg3c+O+G49LFgSBWuArDrGauMbZOUhTg6fnJQ
 tNzH4aGBNw/AIyCh+u1Na2QEP80pJ0mhw+rHgrzldiYfS9BcJ5FQgYCtrJF8nutv7NZ4oKLrCUu
 X0zLPYPzuoQIn0A94pknBILb2pEXdA2GyEUQoAKFxu2oFJ1iKznM3/9Iu4oR3tYtnee9Hq4LyF/
 7dnyJPaHD82jMas07CloaKKu9dW5hPhZH+6YGJ8V97PL1gdk6ox4xmy3s9NgrnlfRT+MT6yna+D
 a2Fh9YUgfJW6pgDQmBQ==
X-Proofpoint-ORIG-GUID: 6mjWXSk9BTNs9gOAYxVrlGX7AzYHu0KB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX25+/PQroYCt+
 7RZO++tP5nVj1KS0RpcjLekSChowvI8qnruJSsg0laQglVMznbisNNJ6n8Idzih+bTB+cLs7/h7
 dohtx9w78AsgoUs2duQN4f8J8ZPwhf0=
X-Proofpoint-GUID: 6mjWXSk9BTNs9gOAYxVrlGX7AzYHu0KB
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ad354 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=O_p9N0DIn41U_kaacwQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050237
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Various CPUState can share the same CPUClass parent,
and must not update its fields. Protect the CPUClass
by marking the CPUState pointer const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 include/hw/core/cpu.h     | 2 +-
 accel/tcg/cpu-exec.c      | 2 +-
 accel/tcg/translate-all.c | 3 +--
 gdbstub/gdbstub.c         | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 59d601465b4..60a23d6f38b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -480,7 +480,7 @@ struct CPUState {
     /*< private >*/
     DeviceState parent_obj;
     /* cache to avoid expensive CPU_GET_CLASS */
-    CPUClass *cc;
+    const CPUClass *cc;
     /*< public >*/
 
     int nr_threads;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9c754b03656..d7f91dce9db 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -460,7 +460,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
          * counter hit zero); we must restore the guest PC to the address
          * of the start of the TB.
          */
-        CPUClass *cc = cpu->cc;
+        const CPUClass *cc = cpu->cc;
         const TCGCPUOps *tcg_ops = cc->tcg_ops;
 
         if (tcg_ops->synchronize_from_tb) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3f1a3a28438..328d96aba30 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -575,7 +575,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
 void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
 {
     TranslationBlock *tb;
-    CPUClass *cc;
+    const CPUClass *cc = cpu->cc;
     uint32_t n;
 
     tb = tcg_tb_lookup(retaddr);
@@ -591,7 +591,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * to account for the re-execution of the branch.
      */
     n = 1;
-    cc = cpu->cc;
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
         cpu->neg.icount_decr.u16.low++;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index c3c944e965b..26366acb674 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -578,7 +578,7 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
 
 static const char *gdb_get_core_xml_file(CPUState *cpu)
 {
-    CPUClass *cc = cpu->cc;
+    const CPUClass *cc = cpu->cc;
 
     /*
      * The CPU class can provide the XML filename via a method,
-- 
2.53.0


