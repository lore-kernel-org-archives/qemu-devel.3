Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70A0CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKe-0006dq-Hh; Wed, 07 Oct 2026 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOGQ-0000WN-Ou
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOGO-0000uT-7S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jjZ3152005
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NWP5n/kqNqSQ8tq1K7ciKcmoTu4g1EKdUIjB1TX2JXg=; b=Uo2gs+HM6z9i9hnK
 ZjO2PuD5GDlVI5AwBsQHRiueECJhJmdq67QmUBrg6Y8A5nthNOawsM7yCkTa80Ex
 wSEcy6UGMpJix7yO04xsWEfCadoi560ZT4PSkCLk5O22TT2UAIVv5D+aHXo/y9zc
 oEWaPTclFBKE6RRaAgRW2wAoYXlLcGWqJGENvDIEvmnPqhfzCa3i0TkuY0MHNbG7
 6hi5Yv5MUaOohyJRTe/vC5jA7Cq9149Od4pfOAhVIYkks1MzBfHpCmkeBT1NX0mq
 4BRCiBNLEoWPd9PNEUTznEzVUlJ1h0WiXFw95Wyd0DKyjix9tZStmU8g8x0qGhOl
 Au153A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c719hby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:48:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so710007285a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366517; x=1791971317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NWP5n/kqNqSQ8tq1K7ciKcmoTu4g1EKdUIjB1TX2JXg=;
 b=cG9oN6F/8PWpnwQuxq37QMPX0bdw1YDjuYwN/rW20o5NU6tDUqQVmcWNA3iu0A/2Om
 IP5gfm/y0+x9kpWRlYLFcrPiam1GC3TeatQLyLdoqhdU8ljyOquYtSMZKfh+XFExr55r
 MWwyPTSlJLsC/09aH0fk/tY5FM6L9gspvIr9vBB4t5CITPn3PAgXKG66r8x8ILts8wKO
 43CgOh04ywWb4oJkiLrB+irafXpe7LM/XoN0/hXay/tdGstVj/2YBb4+scEasCI45C1C
 Ys4bAnqDEgXPC/QJWXBg4t/flcRn4xPEu7Hnwa+y3DdnmPDtlNw4HhkQq3zFr6Sos32N
 B02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366517; x=1791971317;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NWP5n/kqNqSQ8tq1K7ciKcmoTu4g1EKdUIjB1TX2JXg=;
 b=xOvk49slu24CF7wJLMoQNOwaiJ1LQ7FE88LCuL7j9bY0jyHhdySIwdva5LQhypXGc+
 0XLginfVCgGFucTCHObpxfK3O09OHqxTH46KTWBSb9v2D3sCsKV4XX+iz1gZKJp6tPlO
 dUXl8jpvIxiPaAK7rM4lyNMewEJWSQCXVR/SvPFmV2vPRPJkS9sDdhKF36MGDBPM1nla
 +7iByMbAEgemNhOVm8uHYaz+SmVc9Lm9Fufn2BUGHPZai188ytK45S+7NiJJSTfuldXx
 cIsqu1rscmm96W9nqV84tR7eqMu0xtYgPClvAUg3eCGsCuY5bntsXPrAhmWMTGSg+vVh
 Ik9w==
X-Gm-Message-State: AFuF++mLMtizO4CQgXQzNjkMKCFTtJMsa/QEomUhmndEMOih9vVeNQfP
 EFzqc1hztaI/f/UCu1Y5XPbGXN7gb8JI39gBIBB2RdbCZDqqepQuXX/88GJCbV64acNMdKaRRSI
 lxQFNKuYjdBSr+FOilIZony99gMpz1975Cr3XZBZKzCOmi9whbdEIIIUP3PAl+9vzakEZ
X-Gm-Gg: AYBFou2xNfOP76hqSz+MgkqDctNIYprN+nOpasYofCxFu2jJcyH42YV7vC3/tuebvz3
 EVQHXhILIKU4LxvTuhKeGP3hL6q+1nbgkAH/nDbbHLqJzWDSO4tVh9qltYmit/LtXhWfZD5obrM
 NgiAvUNOaNWM3bCI1BhPMxy/O/f1S+B9QgMFt18dSF11rTGrj8LTHbwanEjAkFKIl7Xk2OK3sS8
 htjgvbdMHxbMwr9JjFSYJ/6nTkq9sWuaNZMOCAO9gLaLnydo2nZBtT0BtIyLmoVIF/ZKbhpLy5D
 00zlHJCoTZuAME+r3y9qhrtp3ASPIpw3bsQvCHI8KLQsZdH0iA7u4wHDRORjEDAUkHbSwljNNPF
 XGd9/Hvd4guWnzkgcx2CE2WyjGWYs90Ws50NLweGc
X-Received: by 2002:a05:620a:4013:b0:93e:9808:8d75 with SMTP id
 af79cd13be357-93e9b88a482mr333908785a.79.1791366512873; 
 Wed, 07 Oct 2026 02:48:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4013:b0:93e:9808:8d75 with SMTP id
 af79cd13be357-93e9b88a482mr333906485a.79.1791366512238; 
 Wed, 07 Oct 2026 02:48:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2014asm4412607f8f.38.2026.10.07.02.48.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:48:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 27/27] target/xtensa: Implement and register
 CPUClass::exception_name()
Date: Wed,  7 Oct 2026 11:45:15 +0200
Message-ID: <20261007094516.75732-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXw1aPloRIq9eo
 dvPCQT9tsEwRAOGnPrOzBmigIXGU50YulDngrJE81CS3nWR0GEGGW5XUgO9eeeP4jTCTLTcM94s
 jlOfKtaKzvM6OLP6mubuor7zhocGtoI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXze55Hkze+zsI
 gNyJJpxXy6B01qqtKAwtyP8rs+zAtksh5pWiEvbPvsVKAL7k15LdSojjc+7d+mMuKc5Gbzr2B+L
 cg9wxhggePINok0LCm9atkK5qSeGegQmNQPzZnZl1ZVBr0fAxiLi8ZkL/7OH1KLvPt+RzcrURNZ
 3nyW2Lwkfb3r2P4xZbTLSGno18npgwXrNQ9XsEvgNMlTh8HDDrVgv4Ks9HXM5HxpTJaV/G9LCXr
 8IYSz33H7PMKGlNAniI0Zcimn9ikT1cO/2fHsW55Z0bAbC9F798nrteY216y5dXp55c+sLOJFLk
 vBGth2KUKqVE47FqkHYXSR2ZJOELEnN8hZ7Br+j021aNM6g/9cpM7r3YewY6BHm2h+Bl32cGEgi
 z5tPsUeFjwo2tSUsHQ4rQxDbYGRwAqGbMXhKWjJrR9PvQhAXPms2bjfoFhLpPcjKZyIuy/tM4bw
 2yZfEcp7fJIVVbR3xIA==
X-Proofpoint-GUID: Wqzn-FQUUaoPJKoOCGUHTeh5j9d5OJQx
X-Proofpoint-ORIG-GUID: Wqzn-FQUUaoPJKoOCGUHTeh5j9d5OJQx
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac61576 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-R6i_BgWeFa1qxdD66wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
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

Implement xtensa_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve Xtensa exception codes to names.

Use the new helper in xtensa_cpu_do_interrupt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/xtensa/cpu.h        |  2 ++
 target/xtensa/cpu.c        | 26 ++++++++++++++++++++++++++
 target/xtensa/exc_helper.c |  3 ++-
 3 files changed, 30 insertions(+), 1 deletion(-)

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
index 7c25b9ab707..d5ad9466c0d 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -239,6 +239,31 @@ static void xtensa_cpu_disas_set_info(const CPUState *cs,
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
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
+        return "unknown";
+    }
+    return excp_names[excp];
+}
+
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -348,6 +373,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, const void *data)
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


