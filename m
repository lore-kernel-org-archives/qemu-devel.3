Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hY79Tr3r;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QQMPHquH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHzm-0007oc-H1; Fri, 23 Oct 2026 12:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzG-0007CU-LT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzE-0002fA-8M
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6r371492226
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BRlXLOLY3XVBx2yklx8lcXKZ4sgJIPqCDWLCLX6K77Y=; b=hY79Tr3r23Fpbe+o
 nSYXYOHBptxgQvX+2dLrTt7AtKXmgo6Uecbs3MrIQmhAZAl90/Qfs7PnJMbQC/Gc
 KUo54uwnwi/YNtkfVRs3ClptMg82OHI4liL97z8DbBun7Eu+sJ7EUF7MPBvjBrOq
 /xvSwmOEcDYDvshyFBvSnmRA19bMmqB6YSxbBBN1Sf8gsD7NbdRsklrM6lMcZBBb
 hcV7vyctHGXCWvRg1xMgp2HbKlP68Y6LugfgZIZ9nVHpL7zLlDNCZ5R7t90jph6A
 QFdXwZ4ANlx/2uIYxdk3k7CMq/9RVeIwscaVUbZKKBvAjuznSU3WP78QSQA6c0+M
 9QRGnw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauygu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so215362085a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772356; x=1793377156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRlXLOLY3XVBx2yklx8lcXKZ4sgJIPqCDWLCLX6K77Y=;
 b=QQMPHquHuz+wu/sW8NFXd1bYlUBwWLsFIH58PrvCooK08FzXzrtJT/OaRn/NFSGJhN
 Pmj1qmWMo5f28t1uH249dxRrhC02exg6jSqZfBUixOvM5MGQxErIlPFkhFG+CZIzYoVK
 olLchH53K9KzMyuKpDtjD+2Wb8HYjQf5KjOEcBBAaOPZ+IcRi6J1qfKcN9tiaBWdr5UV
 TPFy2OaXG6T4fNRAbxEPBe/LzHmtGzZtDZHM3nSQx/LgNlRDXbJWlkC8BJInzRPqDDGL
 SqRKwZzlIUihkSua0um07CJ9RtX2fG8QkNVBH4lIFUeWzpSWRohCaiMvVcpNGJC7sn1o
 4VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772356; x=1793377156;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BRlXLOLY3XVBx2yklx8lcXKZ4sgJIPqCDWLCLX6K77Y=;
 b=enQqvfihmI56Z1jNLgKm5v4EnulZAhJIATbChBjPlqMcKlPpVK2Abx4FN0G1/mQlJE
 G7Hvf+hno8n2z9lq15mcCKoWflcsPpHeytotkEnwbaSTy8BsFWQtsFAjJVPSQSAPHJML
 fbDYpW+4tlwvoRj0lej+TXG/oGkX6NKpp6szVeO6hiP+qAz7O9pUz1+P3zVfs+18HzCo
 K3cGHKiovHLcvfs1MpiNFcApqZt1AT90lnXYF0uAVPHRrNfzH/9j3QfUOgmdpesrQLtq
 JuJqhU4gf6HIUuH57iAmm8BOnJCTN9yloEJLoRckhKGFvhd4rj3uyObQeObbegQpyZYB
 43ag==
X-Gm-Message-State: AFq9FYJM6PYPbMQt48j/hh//mjB+tiqblYwbsWidKt6zUu7HGm0C3QgU
 gk8p1f0xJeHr7rtpgJuuZ4rOEfUsvpPtta/R8sBDnnaMmh3d68hythmv7rwiklNGjIhrKZF118c
 yW6uJRU5NFqygPeI+/sRA8A9MS4HoGmQtf7WHaaxKr+rdOfn5C1p7RncZ3ly2QFgYZHcd
X-Gm-Gg: AYBFou17z0qfiFT+ohoTJwILBIz1ke7AfxP0GuqQRR8EPSMsCDTVVuoZWSUsGIzKfho
 LUMz1lYIx9wilxfuLpH6jZ0FaaRyAt6k7e4lHOOmfG+XevDk9k35rdm1eX5N4v3krM3V+kP3nHd
 LHVoY9O9jwgNrGRpgWLctKZBoJqnf1HXkF7IZrnMnNgyW9roOs3HYuKAjeL/cfGK44fbPvVmRuw
 al8DB+0QChEEA7vuOwYclO0pi7UtunexyQHC1KlCH+EG3THfMsXKKDzc+8y1K1q+ANAD2wftBxC
 axSKkAYf7Go7RvG+lxhDh/9AwOpdq7+yUcET6Swamhr+DQO4N2C/TtA4XcKHYWBy7irm1IRwsgi
 Sear+E477nLNmfGVJM80VndWpQrsWyXtqBk5Anpdj
X-Received: by 2002:a05:620a:4104:b0:93f:5304:422f with SMTP id
 af79cd13be357-93f626da712mr970721685a.9.1792772355492; 
 Fri, 23 Oct 2026 09:19:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4104:b0:93f:5304:422f with SMTP id
 af79cd13be357-93f626da712mr970715885a.9.1792772354797; 
 Fri, 23 Oct 2026 09:19:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee699sm740808f8f.10.2026.10.23.09.19.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/83] target/sh4: Define exception vector constants
Date: Fri, 23 Oct 2026 18:12:55 +0200
Message-ID: <20261023161332.60153-48-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb8904 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=exSUSkewqcAxhAk9TGUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXy60Jz/fbDxxe
 wr1oCK4gqixJO1c651boOJsrvWeT30K0EZJK5sYnUbYO3l0JXTOzzDH25heBRBEHjhcFeV+bodr
 YA5CAbVpOVLyHkf7x74jo4BbtkLk124=
X-Proofpoint-GUID: S9WLePeySQDEk7y7X-yfrqEHDPz_mQ6h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1GfV6NQhvetB
 WQldGXsHYlORDyzIVLjZRRppLc9l3MlLCMZeJ2X1Esrs536h8Th2rTmq29Nj6MgLB52pGScN1iv
 AcN6UuMN/SeWoSZom2Og8RN+ey/QlZoYC52tPhR26iCES8ssmQtM4qRNbB2RPqpwtpj6x8JaSIX
 rZamJor1suQEnyusLPp5Cj+VaaT37ociS65Astvqj6pZB+txyhdjn04bWxN2Jc4+RYukHmOkKYK
 Q+m8uQhT0JTqkjtJGZAmU/Z0HB0yuAyrHJyqnZq5sBv9iKclM8vB814dF3ozjsaJvGr/Ct2+EK9
 t2zHWGIzw3Y6yyIE29I7fzYOhle8qrlc+W4l160wDrQMcNVGuSBKywedyx17RtsOkug97LLDZcJ
 RA5FF+V2DQbIjekzmlo6z1GBwqTjueztEgGy8YfpGUozzdU+FDZ/BJniG7CULJUbO2klWbGifmJ
 31Ws3ZmjUIP7P+uCNnA==
X-Proofpoint-ORIG-GUID: S9WLePeySQDEk7y7X-yfrqEHDPz_mQ6h
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

From: Yonggang Luo <luoyonggang@gmail.com>

Name SH4 exception vectors and use the definitions throughout
exception handling and exception raising.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-29-philmd@oss.qualcomm.com>
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


