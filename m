Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD85606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=giOSnMFM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=afGUZB50
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMqi-0000h3-5K; Tue, 20 Oct 2026 23:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpy-0006k8-0r
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpv-00036w-9g
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F4rh336950
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1O4lnK+uCvAK73GwAxFUIHoy4sAS46e0qdnKIvZvS+k=; b=giOSnMFMRASduHKi
 8yvAoYrsynd6JvAswbY6HWlNzr6LIqSHphjU4+qAiLtenkqSKiQ14/69mN9Y87Ze
 tdURaOr0npE6ITvnW4ojKjPSz7KNeVdkDxnQNUf5ilSFUTf/FWv2WWnPn+3KOWX9
 odqp3I9Ki4jWdIrsmPRNLyuEJmFxZpo/HnvfMoug20d3kOWYErhvUKgoB4a6MRYZ
 DoA8nQVd1+FFmqcjepCvIJrwA6lbmntPcNwEQXwTfttYsyY296YZDzm/Fje+P097
 iNDhq1FEBKQAlCkkbAh40FEveg7juuB+7vYDgy3lzRh4hg7xaEc33NiSGPKgqQDg
 Q0bOTw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhrmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso60093185a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552663; x=1793157463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1O4lnK+uCvAK73GwAxFUIHoy4sAS46e0qdnKIvZvS+k=;
 b=afGUZB50qpzGbAhO1xxDNYNnvUTSunlnHSN24m4BE7/jjQcg7IMmdKhYZ6U70g41q/
 awcagf2sAT9XQ35kWKSF6fc8Hhwj1a/zrN4WOreLKgqyKFnSEjbhiezDXO4904bxRl5T
 uTNW2fmZU9BCJ4smyrHw69PJlf8AsVat03F33Bnj9Vgqnc8k7oc4tNYYTz4jNaAMZr9S
 2af4PvRxITrXSkjTI1b56aNTmVnKoBvNQroDgZGqAcylabli33nLbjoDNN2NbzahcjMu
 37ubHjLEUxwKqx0+vEhh4RYCaDfynKAQWMc90Is+5e8/LfXW7L08MVMk4L6+4SLQH/n9
 zb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552663; x=1793157463;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1O4lnK+uCvAK73GwAxFUIHoy4sAS46e0qdnKIvZvS+k=;
 b=UznizD/EwEiZBp8Z1lq0eS9WzSH+8LninYlfT3IGEm3Bqnr2CchoIWIM4cO1HLiM3/
 wF45R6Oq3Z0gekKBHuYIICADnpi5eCfDpbyQ4aZSI3wvZPN/5SPNFReMnns4RvKPJAF0
 lggiSZzWxt46XoPERrUo0j9XuOKqLVxcU43DDTzoBePEOGsFBZD2ejVRE7jiQqP24g/u
 POSs44UUsikOksm5u84EXE03x0byhvYFt3XA4iTiOk9DyVuiP1l2XgL6QFWwYlTZnWrK
 yaSVHySyn38ea+/hy/hHSsKAOivCr6GaYQ2Tev1d1otgDExaNNGeZ23vG2J3+VNsJEQM
 Tf4g==
X-Gm-Message-State: AFq9FYJTMZ//CnlMOMnPlvw68LoP8C1J9sB8uoKv6RKPQ3h+JGEW7yEU
 5kpHwQyCm5PaJHYwiegX3oZqHUcGJwplZ7KG+mWULdF7+ZlGB33E8GYN02x7+lkzKpIF9LpSUq7
 3lUuEMq77rLrEg2TM/64q6CdmFNaroQFy/nBvQM8y4M3VqCYTD+6PnILtXyr1vzohmrT4
X-Gm-Gg: AYBFou2wOVLmgYYe2xZ07/aGK5vangNVJt9cge31qpPpv91KF3rTHO1eyMk6e7I89M1
 0ReJdTt2XP3dVN7rJ8I9AVWsfL7MYeG47qZj2yxzUXiDkSD/YX0+yJrr7kjs0AszCMHTTjmBBXt
 Kvm3vQFC2y6X4Cz+mU3UW2RtLof1UgcQWxRptDRdapFWsduxC10d66Ez0zZ//d5AGdPr+73gAEL
 ooYMHjmJ6fjFFYFKVS7SmYX8xD1ocxE4o0dMV8nWH8yyCCylU+G8ZfhNRYh5/Z12zNEgarj+FHf
 BwS+eH3LWR5ry1cg8T0xJHE3P0eTjUtDOJ7YoA/YFgi/cLjLvYnqOo7D8crISuWjwf8zDECTF0w
 QxOTdXqECQGZiBiIp75PM2/vwJHtL6tggAw29qGfS
X-Received: by 2002:a05:620a:1706:b0:93f:1dbf:6cec with SMTP id
 af79cd13be357-93f57f4f795mr207131485a.36.1792552662704; 
 Tue, 20 Oct 2026 20:17:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1706:b0:93f:1dbf:6cec with SMTP id
 af79cd13be357-93f57f4f795mr207129385a.36.1792552662188; 
 Tue, 20 Oct 2026 20:17:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e258426f4sm2593871f8f.54.2026.10.20.20.17.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 27/33] target/sh4: Define exception vector constants
Date: Wed, 21 Oct 2026 05:14:00 +0200
Message-ID: <20261021031407.24862-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX0LK4TtO+ikSQ
 6/52U4l42IAnGT+c6HI2okPjaxvT9mM7DCS+pcCCXv54HoXmNBs4Qg0BqjiuzUSnz5NtzVj3BC/
 ZG6K5yBWE2m0idRgv4d3+NFaBLhoLa4=
X-Proofpoint-ORIG-GUID: YXmHQtt0yfZpc7GsQdKA6TeoWiGPUmZU
X-Proofpoint-GUID: YXmHQtt0yfZpc7GsQdKA6TeoWiGPUmZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX8ppp9fZfzy4w
 89iXz2M8sguz3vCMCPAfy+M5bD+kbj7z3JNwae6SHIAq6PARP7TnJ86OuWuLKLfkzxEeEPY4GU3
 DowzeYwAHUMfWxRqYChb8JexRXYv3MDBu5NT33QF9dZqQJ9ou0vkV9bPrFA0E7p2mhQkmNpaeYi
 GHsUaeD4qwLe1M6D/o+Ks/7T2j3TgWmE4plNZ17qQyAXOy8bZ5PnsRrGUVQr9bG9xEnsgYlGiuZ
 plsCNUDxwk7invLliyonI/rRAGXCBLA0YRXKay6dh/8w7e/fKoSt4aiQeSdI4YqNBPKeicb4yF1
 xFP0Q7oEHGg5xygJmPQBhPZ1Q0fFFbO0dZUR5LFkxg9ZuSK2xYnBZYctwEtJZR96zkY5yLtZv4u
 JfRGxRTZYhSAJ3S7vmtGJBISMzDyMTdrHph8n/FwZ7FQ2NI7CCxfVoIwmlV8tFwMvX60UN7TuDc
 ZuE+IzKRtWZKrIjeHCA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad82ed7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=exSUSkewqcAxhAk9TGUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
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


