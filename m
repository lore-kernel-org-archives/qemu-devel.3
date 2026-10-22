Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA31606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q23kUf7M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KqFvxLv/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0kZ-00056w-N0; Thu, 22 Oct 2026 17:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kL-0004u9-Gi
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kJ-0007r8-IZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MJXw101148809
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1O4lnK+uCvAK73GwAxFUIHoy4sAS46e0qdnKIvZvS+k=; b=Q23kUf7MtNZ8KtsX
 rDJXKdHCsB3iodpEW5kYdWcAqGE1nBEKJrXQdihyWXyF7GlAmR1obbYX+ne7rp5s
 QpTEjD/n6QBNIPl3FgFmaAtU1AtMUAxTgRuKN50wBzncoPtQe8FUJMYPd1+QPEFV
 lZX6EQaspU2vseTUXQaX293Ru3c158LQxpW1Nq4pdi5f64QUkygZxFerNw9UzRic
 s4m0r3uCOhbL/0LJk8PZEewIk3CAG6M7nw7i1scd7dOANmcmzAwDUta79hQRfyZF
 HrrsFBYXaz45HSsZYlHmsy7OTUeHPJK9MBBsWYI2nCAclhA/Xru2PZFLS+j66MgF
 xac4oQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8r0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so42743085a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706086; x=1793310886; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1O4lnK+uCvAK73GwAxFUIHoy4sAS46e0qdnKIvZvS+k=;
 b=KqFvxLv/K/UDtebB5Up8ce4Yvgv3b5hXduCq8/izTZDKC9t/yMG5Rqz4b+a+gt4kLD
 Fq8GlDBTmGmdLtlGXF+D/iCu83fA2MPg7vsMWLmc2Zr2SozERjTl7dVBWBU/lxS+Hq5+
 uSm7fSDrcxnsOffxASluypyQfZX9kiO9NPOGZIf5aS+ojHslwOzT8R6Ly3yI0SiqHiHH
 3xvSe8jgxKq5yAZpoAO2BFBkTtwr7GJm8FWXX+1gIfK/HVfUuHnqmeUgOFy1iwIcY+H0
 CpoKwUao6nldOZ53xzBwpb3e6JwhZoQOz6R6jQkk74Ote873bgIaVdpOY7keGLEw5+e/
 hHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706086; x=1793310886;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1O4lnK+uCvAK73GwAxFUIHoy4sAS46e0qdnKIvZvS+k=;
 b=lCbuca5KI2qsI3uAYb8sEshm0i2aMEIEEspXPXq5ZrU2TVkEPO+NfVxH0WmUZsLNqz
 2SnMTirriAaOrWrzJORQ8e9kJLeN3yrp4aQ07fK+npXFiPXgmJBOA5RZ3c/88HQFomgh
 hAgXI7EAiYUWHVCYfStLTHCMkg4fg5ePFEv5pdpiIw5lPs6y64kyGfMpABRvDErEri9a
 aG7jF74jYSIZwJcpdm8phSlF40WeGHOl7wIDoTmdBISiTrc99usA7SitKHqKUWwBglb4
 Yr6E50tPZIEtFQrEGUP9IKSpr3EMO+84cxW2ZtGE8/oT/08WukkG6S71GYhYjBazgpJp
 Io6Q==
X-Gm-Message-State: AFq9FYIWxJ/kjq1h9CTAhmu13KkWsGgQCyBIOLDD27C6tTdOdE8EJknf
 RyD3TeO6m0pUByxXGdXN8Ail6R3hEHu0CTEcNiSvV7DZ8Lj49IcaWX2cDObfLoxSd3Z+CpKDpRt
 Z9kz43kiFxDvolvgVr9s3ZwfPBvJpgKPbNyAJR+BOloFYHQ7C94rJXIokNQAkVeso0Q==
X-Gm-Gg: AYBFou1PF4a0LmDuxWiTYwQc0rFIHIJsvRKff+ZmJcCmYPPPGr4bGay5IIneAAd1DLF
 yHjTLvpLq2ODGXCf44c1rcfKgnOdPQo5MFnxDMZD/a7AI6HOw/bEgkeMrUc59jIKHbDW+7B9cFj
 1CpiF/EDIOXkqD7lmrP3KKj8CcXW42eBdkIou0NwD3YhermRVnw2+Af78q3fOwgl6JZwuFh83KP
 FllflllcufTTUQCAVEKqPbkILEjgNygKrbstob/VOzLEYQHWV/QvxetvcT8+ygA09BKEvmzqrvc
 IyCZHXSfpOAGHzKebHbKLzx/WX6I4djsiJ5l140uzCIJPl2pjc6jirZ+bL0MwZQ0wWlcVYUh4Ob
 oHYd150dcje85N1l9u/4XILKjEEamiWpedN+irqtA
X-Received: by 2002:a05:620a:2a01:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93f62798985mr588147185a.33.1792706085582; 
 Thu, 22 Oct 2026 14:54:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2a01:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93f62798985mr588144385a.33.1792706084990; 
 Thu, 22 Oct 2026 14:54:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21034cd1esm24143035e9.5.2026.10.22.14.54.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v3 28/33] target/sh4: Define exception vector constants
Date: Thu, 22 Oct 2026 23:51:08 +0200
Message-ID: <20261022215115.19680-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RV6HF-kpz6ELTHPPEI1m2DXoUod-BTuZ
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada8626 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=exSUSkewqcAxhAk9TGUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2natX/FPqMLl
 cWMM/Sb43UZENeQtmi7gV+t/AMPl/HvvOAyNm+pbEg3Qgfeymoe7jyLeOmqCYSH7EuUwbP7o6GA
 AKAL+7KNaBNXJXtcTkkmTvOPCCq5vz8=
X-Proofpoint-ORIG-GUID: RV6HF-kpz6ELTHPPEI1m2DXoUod-BTuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxDBA206wYOir
 4mHsBqURnIurOzdKhFvWLilHigI9sm69HhyAJVTtjovOPSv542yu3KZGnbcZV2scNnW6zBFzVeb
 vb2XdYEj3YkHSgG0V1oeiziW9vk3E5LnCVvydFUoRacJK1MquT/siMhdyrmSD5bSgL7PdQ1NSGK
 z/lULqBYUtPMHvhuUmmwPE4wWKakYXGyE0GRwWUaTyC5ufaVUxjlZBHM0Q+2FZ0bbtmDhL2HnpO
 YmSahADCsvuBL4JMe9lhhp0qvv1Gg4H3fjPly+a1ftnucrF8InyHJhwH6rSHk18Grn8BRGwhXEs
 AtxEkU7YXCC2OOw6Dvai2uY9hHWDw/WRyyKc9pKEssMlGJHruDkmFA8KyQlhO4Kx7rV+1HKLfUM
 Mjg1g4Q8hvX/YzA4r1npoBXhI2bNlS50VbvdEXMpPvZoux6ASSrdvUcymkJATVpqwxQRDQ827G8
 BeBTwIOiKse1sMKw/wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

From: Yonggang Luo <luoyonggang@gmail.com>

Name SH4 exception vectors and use the definitions throughout
exception handling and exception raising.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sh4/cpu.h       | 21 +++++++++++++++
 target/sh4/helper.c    | 60 +++++++++++++++++++++---------------------
 target/sh4/op_helper.c | 16 +++++------
 3 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 6984bb462fb..a1e9049b7be 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -135,6 +135,27 @@ typedef struct memory_content {
     struct memory_content *next;
 } memory_content;
 
+/* Guest trap numbers. */
+enum {
+    SH4_EXCP_RESET = 0x000,
+    SH4_EXCP_MANUAL_RESET = 0x020,
+    SH4_EXCP_TLB_MISS = 0x040,
+    SH4_EXCP_DTLB_MISS_WRITE = 0x060,
+    SH4_EXCP_INITIAL_PAGE_WRITE = 0x080,
+    SH4_EXCP_TLB_VIOLATION = 0x0a0,
+    SH4_EXCP_DTLB_VIOLATION_WRITE = 0x0c0,
+    SH4_EXCP_ADDR_ERROR = 0x0e0,
+    SH4_EXCP_DATA_WRITE = 0x100,
+    SH4_EXCP_FPU = 0x120,
+    SH4_EXCP_TLB_MULTIPLE = 0x140,
+    SH4_EXCP_TRAPA = 0x160,
+    SH4_EXCP_ILLEGAL_INSTRUCTION = 0x180,
+    SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION = 0x1a0,
+    SH4_EXCP_USER_BREAK = 0x1e0,
+    SH4_EXCP_FPU_DISABLE = 0x800,
+    SH4_EXCP_SLOT_FPU_DISABLE = 0x820,
+};
+
 typedef struct CPUArchState {
     uint32_t flags;             /* general execution flags */
     uint32_t gregs[24];         /* general registers */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b6b057f104b..0fbd613f333 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -70,7 +70,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     do_irq = do_irq && (cs->exception_index == -1);
 
     if (env->sr & (1u << SR_BL)) {
-        if (do_exp && cs->exception_index != 0x1e0) {
+        if (do_exp && cs->exception_index != SH4_EXCP_USER_BREAK) {
             /* In theory a masked exception generates a reset exception,
                which in turn jumps to the reset vector. However this only
                works when using a bootloader. When using a kernel and an
@@ -97,43 +97,43 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *expname;
         switch (cs->exception_index) {
-        case 0x0e0:
+        case SH4_EXCP_ADDR_ERROR:
             expname = "addr_error";
             break;
-        case 0x040:
+        case SH4_EXCP_TLB_MISS:
             expname = "tlb_miss";
             break;
-        case 0x0a0:
+        case SH4_EXCP_TLB_VIOLATION:
             expname = "tlb_violation";
             break;
-        case 0x180:
+        case SH4_EXCP_ILLEGAL_INSTRUCTION:
             expname = "illegal_instruction";
             break;
-        case 0x1a0:
+        case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
             expname = "slot_illegal_instruction";
             break;
-        case 0x800:
+        case SH4_EXCP_FPU_DISABLE:
             expname = "fpu_disable";
             break;
-        case 0x820:
+        case SH4_EXCP_SLOT_FPU_DISABLE:
             expname = "slot_fpu";
             break;
-        case 0x100:
+        case SH4_EXCP_DATA_WRITE:
             expname = "data_write";
             break;
-        case 0x060:
+        case SH4_EXCP_DTLB_MISS_WRITE:
             expname = "dtlb_miss_write";
             break;
-        case 0x0c0:
+        case SH4_EXCP_DTLB_VIOLATION_WRITE:
             expname = "dtlb_violation_write";
             break;
-        case 0x120:
+        case SH4_EXCP_FPU:
             expname = "fpu_exception";
             break;
-        case 0x080:
+        case SH4_EXCP_INITIAL_PAGE_WRITE:
             expname = "initial_page_write";
             break;
-        case 0x160:
+        case SH4_EXCP_TRAPA:
             expname = "trapa";
             break;
         default:
@@ -161,18 +161,18 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (do_exp) {
         env->expevt = cs->exception_index;
         switch (cs->exception_index) {
-        case 0x000:
-        case 0x020:
-        case 0x140:
+        case SH4_EXCP_RESET:
+        case SH4_EXCP_MANUAL_RESET:
+        case SH4_EXCP_TLB_MULTIPLE:
             env->sr &= ~(1u << SR_FD);
             env->sr |= 0xf << 4; /* IMASK */
             env->pc = 0xa0000000;
             break;
-        case 0x040:
-        case 0x060:
+        case SH4_EXCP_TLB_MISS:
+        case SH4_EXCP_DTLB_MISS_WRITE:
             env->pc = env->vbr + 0x400;
             break;
-        case 0x160:
+        case SH4_EXCP_TRAPA:
             env->spc += 2; /* special case for TRAPA */
             /* fall through */
         default:
@@ -632,7 +632,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
                     CPUState *cs = env_cpu(s);
 
                     /* Multiple TLB Exception */
-                    cs->exception_index = 0x140;
+                    cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
                     s->tea = addr;
                     break;
                 }
@@ -828,33 +828,33 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     switch (ret) {
     case MMU_ITLB_MISS:
     case MMU_DTLB_MISS_READ:
-        cs->exception_index = 0x040;
+        cs->exception_index = SH4_EXCP_TLB_MISS;
         break;
     case MMU_DTLB_MULTIPLE:
     case MMU_ITLB_MULTIPLE:
-        cs->exception_index = 0x140;
+        cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
         break;
     case MMU_ITLB_VIOLATION:
-        cs->exception_index = 0x0a0;
+        cs->exception_index = SH4_EXCP_TLB_VIOLATION;
         break;
     case MMU_DTLB_MISS_WRITE:
-        cs->exception_index = 0x060;
+        cs->exception_index = SH4_EXCP_DTLB_MISS_WRITE;
         break;
     case MMU_DTLB_INITIAL_WRITE:
-        cs->exception_index = 0x080;
+        cs->exception_index = SH4_EXCP_INITIAL_PAGE_WRITE;
         break;
     case MMU_DTLB_VIOLATION_READ:
-        cs->exception_index = 0x0a0;
+        cs->exception_index = SH4_EXCP_TLB_VIOLATION;
         break;
     case MMU_DTLB_VIOLATION_WRITE:
-        cs->exception_index = 0x0c0;
+        cs->exception_index = SH4_EXCP_DTLB_VIOLATION_WRITE;
         break;
     case MMU_IADDR_ERROR:
     case MMU_DADDR_ERROR_READ:
-        cs->exception_index = 0x0e0;
+        cs->exception_index = SH4_EXCP_ADDR_ERROR;
         break;
     case MMU_DADDR_ERROR_WRITE:
-        cs->exception_index = 0x100;
+        cs->exception_index = SH4_EXCP_DATA_WRITE;
         break;
     default:
         cpu_abort(cs, "Unhandled MMU fault");
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 777380f8e40..8beac9ca034 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -33,10 +33,10 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     switch (access_type) {
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
-        cs->exception_index = 0x0e0;
+        cs->exception_index = SH4_EXCP_ADDR_ERROR;
         break;
     case MMU_DATA_STORE:
-        cs->exception_index = 0x100;
+        cs->exception_index = SH4_EXCP_DATA_WRITE;
         break;
     default:
         g_assert_not_reached();
@@ -67,22 +67,22 @@ void raise_exception(CPUSH4State *env, int index,
 
 void helper_raise_illegal_instruction(CPUSH4State *env)
 {
-    raise_exception(env, 0x180, 0);
+    raise_exception(env, SH4_EXCP_ILLEGAL_INSTRUCTION, 0);
 }
 
 void helper_raise_slot_illegal_instruction(CPUSH4State *env)
 {
-    raise_exception(env, 0x1a0, 0);
+    raise_exception(env, SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION, 0);
 }
 
 void helper_raise_fpu_disable(CPUSH4State *env)
 {
-    raise_exception(env, 0x800, 0);
+    raise_exception(env, SH4_EXCP_FPU_DISABLE, 0);
 }
 
 void helper_raise_slot_fpu_disable(CPUSH4State *env)
 {
-    raise_exception(env, 0x820, 0);
+    raise_exception(env, SH4_EXCP_SLOT_FPU_DISABLE, 0);
 }
 
 void helper_sleep(CPUSH4State *env)
@@ -97,7 +97,7 @@ void helper_sleep(CPUSH4State *env)
 void helper_trapa(CPUSH4State *env, uint32_t tra)
 {
     env->tra = tra << 2;
-    raise_exception(env, 0x160, 0);
+    raise_exception(env, SH4_EXCP_TRAPA, 0);
 }
 
 void helper_exclusive(CPUSH4State *env)
@@ -255,7 +255,7 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
         cause = (env->fpscr & FPSCR_CAUSE_MASK) >> FPSCR_CAUSE_SHIFT;
         enable = (env->fpscr & FPSCR_ENABLE_MASK) >> FPSCR_ENABLE_SHIFT;
         if (cause & enable) {
-            raise_exception(env, 0x120, retaddr);
+            raise_exception(env, SH4_EXCP_FPU, retaddr);
         }
     }
 }
-- 
2.55.0


