Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D658CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOHA-0001kA-Lx; Wed, 07 Oct 2026 05:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODZ-0007eT-6x
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODX-0000Ot-NF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:44 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jsO32312942
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RqBUjaEFisSFEjUT65HCzGl6ADwC2dFaP5RxNoeO4oU=; b=SbPSuJ94lUR2BDBL
 fMJqcFnyI8IU8/0k9Mch1bsPRC9KDg9SBA1h0vVYMncE1tKl0olcegmHyyy/GFPN
 wNGgWFEaPDw1LpKVHJ1XhzEJ9Ka0G76wVbTo50rpqQ60jseiagIqf6wDWLvt0Djz
 VIv/WpTLJdCj1yJRb3Wvr/XOBPZIQBvqrWlAW7tOFoxqgd3fLkPRiE9oLUg7JcSP
 mzp1mgQdOGJGt5Xo0OwkJ/Wybzjywm6QmRZlEi0WvuKMfUY5GI+Bkqy6gXxcs1FM
 zvMGJlsV6Udk+2LHpQDjlp5Pe8Z+U3JemZihykkq0w7KERNMGjngP6axsWjWU8K4
 LRdFsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53asktf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:45:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934956beec8so832718285a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366342; x=1791971142; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RqBUjaEFisSFEjUT65HCzGl6ADwC2dFaP5RxNoeO4oU=;
 b=a0jiZKD3rN0CoBe8diKelh4d9FKySt9pVt/iZqSSVcwSrkeHwPPLiEyv6/a5wwRyI9
 lPvSXjyrItpRK4moM9n3Hz/EZ31nEDWHEp6/Wac9YPmLAINAJeHqz0hVNfSuA0LdcYNO
 umG7GSS9dfiF7v9q4YkrkZYVYjXGuOoxDhaHfwGD4Pg8hSz1CSPtpYexPWd038Qq9+LE
 9xdhcEMgNunovVeRMqy9i3DJT+VacRB8ayBhKMGxjfktq8HOtkhX5HBDw21xchC2q9Gz
 vTMvKNDYNLOBFeHC1+fy/07q3fOp2oTkx4KWkjwhPV/hh0aHOoyVynOz1FC58NLx5qp4
 ozHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366342; x=1791971142;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RqBUjaEFisSFEjUT65HCzGl6ADwC2dFaP5RxNoeO4oU=;
 b=rMC5NzhnbgcVN01yZ6oRXdbSgdqh33Xg0bCAZsxIEdewb59L+NEZ23b0eEgiD7BnZX
 PzUG+0RDC0MUskwvcnGRFEYDeM1K9aWoIYw8KqGc2ap4NU5cy3MJPo4E93iuH/sLghdT
 UAp7GDY1tMnczF8ZOOHffd9kYj3dvzoLaJ1NkJBrB+7PhCUIf2P+f3o3R/Gq4mHFMMl0
 q9GhyKOWm15Ay11YtAGFKHXaNK09ucR5Ya9I1ae6s5PLIfdrEQZZs537uhsEQ6DVlcKZ
 SaJDhYB+wiyX2hfKoRfGYKnhnc3HnbWSn1G4tE9Z6cyBNiaItJos+mSBZQfAk+nYhUup
 ItxQ==
X-Gm-Message-State: AFuF++lg5a5D6a13ez44850OfuB3St8crwnqn07NvIVKcv4maL02PXVf
 2bdqF7Ojihssj13EX8/VYlO1/Ysm/LA085h/ZBUjVZvNZHh+q2pS97JpKTEMksgSkLXeRV2fFih
 GluuW5I1fh3Tu/s8BE51oRbTslsmTyxtNDeryfWSuL+z2xlrJX5bfGSTTXbrZbh+lX8BT
X-Gm-Gg: AYBFou1bfU4uQLohjrW5mwoPA2AUVc7G8AE8Ntczt+LEIcBBvcmxVuT9ZEGV4PcLvQU
 2T76DH/rIjIPiM6FP1CF7JJRTTSIXR4gQOcpyHi0YJICb8h09lPrAsG7mZ7lpnqsDrpY4RJAjEH
 FPvj98edYJN9HvZT9nUIRgUEe07pQNFkQvSmsi6S02OrUOLZ4G5Wkz593Ydi37nLkIAiX9DzQFA
 lFCkg8LRKaLZPG9maJJrB0BJhmEEI4h7HQqv8FDVh+81cxGTMV+HCPhbRp5o2GWzYJzgBoKINIt
 uPamU6yQh/6NcxRIxO16QucRUK4A2r5GOzgAvkfZqzdnewbiAUxNx6MpRyrlZY/M/mh72sTQd37
 jwYWyancm629vsnl/A07PR7WdhB3SZxE6Rb4+xlW5
X-Received: by 2002:a05:620a:3196:b0:93c:7d49:7b69 with SMTP id
 af79cd13be357-93e9b84ad2amr314787985a.60.1791366341831; 
 Wed, 07 Oct 2026 02:45:41 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:93c:7d49:7b69 with SMTP id
 af79cd13be357-93e9b84ad2amr314784285a.60.1791366341208; 
 Wed, 07 Oct 2026 02:45:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17fc664d5sm24479485e9.0.2026.10.07.02.45.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:45:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 03/27] target/alpha: Register CPUClass::exception_name()
 handler
Date: Wed,  7 Oct 2026 11:44:51 +0200
Message-ID: <20261007094516.75732-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wau-wSIXD0j9SynlNq7ws4YnJh7DmRHf
X-Proofpoint-GUID: wau-wSIXD0j9SynlNq7ws4YnJh7DmRHf
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac614c6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kVf6GzFcR4OVXmdlW0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX5REjIiWlxBUe
 c7UsHKwvTcBDV3OHblNke4k09sJDGBSLlJ9Haed0U2AfdacrqHqZ3FDHxenPO7l+SlBoSdoPwR3
 kix3DBvyuT4yUoP0eHdvrDRHNyyT9wm6rGWyWQGWayMj5s7wmhvzFXm1dX69gnzzKVqq+j72R8G
 Ffs3mJUZIvjWub2iAmWlfq/uyclbNo3We4LoU5LBRBQmSqgi85SNqA+Z3WiKXQmDTc0jVcUCrwO
 F1h/ri0/EA6+J1ttKWDGFdtSRhmGNi5r/gT07kCY/IfFqgtO5KU6mG0YbvXp0KFyFvzIBXi94sk
 CQ41SacXx5ebheDYVvtiVD1fckBPsoFULKcw2SA3CHiqFqd8XLB4co0i6d6Nht5RyaFDV24h3r+
 +HTDZxZncBnUjMr1lT4nixrB1C0f+AqnANLaAaNS+ivno6h07PGADhfzz1kfHQ94P+BuA4go1o+
 em+mFA2I5+bstdGHWwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXxtMyBW/9/XM+
 z+Sdq9aV0h7F9ScmgAd66xORSPehPk/1BSHM0MirMFxuvxhp4f+ZBYSm04JS2LdL0MYdC1loEgu
 iIIAhpoInZUZMUC1JFWrCK1bOdNfedo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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

Factor alpha_exception_name() out of alpha_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve Alpha exception codes
to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/cpu.h    |  1 +
 target/alpha/cpu.c    |  1 +
 target/alpha/helper.c | 82 ++++++++++++++++++++++++-------------------
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d941..8f780502476 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -284,6 +284,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
+const char *alpha_exception_name(int exception);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 12e86021663..f9936315fa2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -283,6 +283,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
+    cc->exception_name = alpha_exception_name;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafda..cedb0006892 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -35,6 +35,51 @@
 #define CONVERT_BIT(X, SRC, DST) \
     (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
 
+const char *alpha_exception_name(int excp)
+{
+    const char *name;
+
+    switch (excp) {
+    case EXCP_RESET:
+        name = "reset";
+        break;
+    case EXCP_MCHK:
+        name = "mchk";
+        break;
+    case EXCP_SMP_INTERRUPT:
+        name = "smp_interrupt";
+        break;
+    case EXCP_CLK_INTERRUPT:
+        name = "clk_interrupt";
+        break;
+    case EXCP_DEV_INTERRUPT:
+        name = "dev_interrupt";
+        break;
+    case EXCP_MMFAULT:
+        name = "mmfault";
+        break;
+    case EXCP_UNALIGN:
+        name = "unalign";
+        break;
+    case EXCP_OPCDEC:
+        name = "opcdec";
+        break;
+    case EXCP_ARITH:
+        name = "arith";
+        break;
+    case EXCP_FEN:
+        name = "fen";
+        break;
+    case EXCP_CALL_PAL:
+        name = "call_pal";
+        break;
+    default:
+        name = "<unknown>";
+        break;
+    }
+    return name;
+}
+
 uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
 {
     return (uint64_t)env->fpcr << 32;
@@ -343,43 +388,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
-        const char *name = "<unknown>";
+        const char *name = alpha_exception_name(i);
 
-        switch (i) {
-        case EXCP_RESET:
-            name = "reset";
-            break;
-        case EXCP_MCHK:
-            name = "mchk";
-            break;
-        case EXCP_SMP_INTERRUPT:
-            name = "smp_interrupt";
-            break;
-        case EXCP_CLK_INTERRUPT:
-            name = "clk_interrupt";
-            break;
-        case EXCP_DEV_INTERRUPT:
-            name = "dev_interrupt";
-            break;
-        case EXCP_MMFAULT:
-            name = "mmfault";
-            break;
-        case EXCP_UNALIGN:
-            name = "unalign";
-            break;
-        case EXCP_OPCDEC:
-            name = "opcdec";
-            break;
-        case EXCP_ARITH:
-            name = "arith";
-            break;
-        case EXCP_FEN:
-            name = "fen";
-            break;
-        case EXCP_CALL_PAL:
-            name = "call_pal";
-            break;
-        }
         qemu_log("INT %6d: %s(%#x) cpu=%d pc=%016"
                  PRIx64 " sp=%016" PRIx64 "\n",
                  ++count, name, env->error_code, cs->cpu_index,
-- 
2.55.0


